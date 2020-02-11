from django.middleware.csrf import CsrfViewMiddleware


class SandstormCsrfViewMiddleware(CsrfViewMiddleware):
    def process_view(self, request, callback, callback_args, callback_kwargs):
        sandstorm_base_path = request.headers.get('X-SANDSTORM-BASE-PATH')
        referer = request.headers.get('REFERER')
        if sandstorm_base_path is not None and referer is None:
            request.META['HTTP_REFERER'] = sandstorm_base_path
        super().process_view(request, callback, callback_args, callback_kwargs)
