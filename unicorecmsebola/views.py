from pyramid.view import view_config
from cms.views.cms_views import CmsViews


class EbolaCmsViews(CmsViews):

    @view_config(route_name='credits', renderer='templates/credits.pt')
    def credits(self):
        return {}
