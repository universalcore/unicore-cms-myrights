# -*- coding: utf-8 -*-

from datetime import datetime
from pyramid import testing

from cms.tests.base import UnicoreTestCase
from unicorecmsmyrights import main
from unicore.content.models import Page, Localisation, Category


class TestViews(UnicoreTestCase):

    def setUp(self):
        self.workspace = self.mk_workspace()
        self.workspace.setup_custom_mapping(Page, {
            'properties': {
                'slug': {
                    'type': 'string',
                    'index': 'not_analyzed',
                },
                'language': {
                    'type': 'string',
                    'index': 'not_analyzed',
                }
            }
        })
        self.workspace.setup_custom_mapping(Category, {
            'properties': {
                'slug': {
                    'type': 'string',
                    'index': 'not_analyzed',
                },
                'language': {
                    'type': 'string',
                    'index': 'not_analyzed',
                },
                'position': {
                    'type': 'long'
                }
            }
        })

        self.workspace.setup_custom_mapping(Localisation, {
            'properties': {
                'locale': {
                    'type': 'string',
                    'index': 'not_analyzed',
                }
            }
        })

        settings = {
            'git.path': self.workspace.working_dir,
            'git.content_repo_url': '',
            'es.index_prefix': self.workspace.index_prefix,
            'cache.enabled': 'false',
            'cache.regions': 'long_term, default_term',
            'cache.long_term.expire': '1',
            'cache.default_term.expire': '1',
            'pyramid.default_locale_name': 'eng_GB',
            'thumbor.security_key': 'sample-security-key',
        }
        self.config = testing.setUp(settings=settings)
        self.app = self.mk_app(self.workspace, settings=settings, main=main)

    def test_homepage_page(self):
        self.create_categories(self.workspace, count=1)

        intro_page = Page({
            'title': 'Homepage Intro Title', 'language': 'eng_GB',
            'description': 'this is the description text',
            'slug': 'homepage-intro', 'content': 'this is the body of work',
            'position': 0, 'modified_at': datetime.utcnow().isoformat()})
        self.workspace.save(intro_page, 'save intro')
        localisation = Localisation({
            'locale': 'eng_GB',
            'image_host': 'http://some.site.com',
            'image': 'some-uuid'})
        self.workspace.save(localisation, 'save localisation')
        self.workspace.refresh_index()

        resp = self.app.get('/', status=200)
        self.assertTrue(
            '<p><strong>Homepage Intro Title</strong></p>' in
            resp.body)
        self.assertTrue(
            '<p>this is the description text</p>' in
            resp.body)
        self.assertTrue(
            '<img alt="MyRights" '
            'src="http://some.site.com/VNlJN07VKnfaB6k1imziAts4n0o='
            '/320x0/some-uuid"/>' in
            resp.body)

        resp = self.app.get('/', status=200)
        self.assertTrue('<a href="/">Home</a>' in resp.body)

        resp = self.app.get('/?_LOCALE_=eng_UK', status=200)
        self.assertTrue('<a href="/">Home</a>' in resp.body)

        resp = self.app.get('/?_LOCALE_=hin_IN', status=200)
        self.assertTrue('<a href="/"> होम</a>' in resp.body)

        resp = self.app.get('/?_LOCALE_=hin_IN', status=200)
        self.assertTrue('<a href="/"> होम</a>' in resp.body)

    def test_footer_page(self):
        self.create_categories(self.workspace, count=1)

        intro_page = Page({
            'title': 'Footer page', 'language': 'eng_GB',
            'description': 'this is the description text',
            'slug': 'site-footer', 'content': 'this is the body of work',
            'position': 0, 'modified_at': datetime.utcnow().isoformat()})
        self.workspace.save(intro_page, 'save footer')
        self.workspace.refresh_index()

        resp = self.app.get('/', status=200)
        self.assertTrue(
            '<span>this is the body of work</span>' in
            resp.body)

    def test_views_no_primary_category(self):
        [page] = self.create_pages(
            self.workspace,
            linked_pages=None,
            count=1, content='', description='',
            primary_category=None,
            featured=True,
            created_at='2015-01-01T00:00:00')

        # checks that relevant views don't generate exceptions
        self.app.get('/')
        self.app.get('/spice/')
        self.app.get('/content/detail/%s/' % page.uuid)
        self.app.get('/spice/content/detail/%s/' % page.uuid)
        self.app.get('/content/comments/%s/' % page.uuid)
