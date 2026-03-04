Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EE5EB7EAC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 08:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxhvM-0004Rk-2o; Wed, 04 Mar 2026 03:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxhvK-0004QT-2k
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:49:42 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxhvH-0002OV-Pr
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:49:41 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so1174372866b.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 00:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772614178; x=1773218978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SVKdVlxK60SHU3qapIjgYwooYFqa5QCsChnVhBAniTs=;
 b=n56FZTqlwy7RgvLjqpPwke1aghjRcK1aVqHpAo2Ug0XR/zu61p/WFjWJ0rKSOnbkZn
 tuexCqjaAR2Kvm7M8nk6zik/C8PilhwnHrMeklcULa8D+e4kLHFw9+5zV1pjWnurymKU
 Eg8dq2YYdHzxI8x8RRPQRSWEPBcCZPIIXnf/liOvY/9wepQYZubawgvLV9VLU3hvNOzB
 1KbFkhrrm4tLLLCyXu04D6BEKzhhbqjvkkQZnFClPw2QVPTHctRaTtl8J4VpGRfL2MxB
 qfnS5YxTnLswNz/LTZveGD+TNivcDcxK2Ws+su0g1GFUL1vIu+4GcsRNkNvttdbprH3e
 gQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772614178; x=1773218978;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SVKdVlxK60SHU3qapIjgYwooYFqa5QCsChnVhBAniTs=;
 b=kLt+VoehJoXy/4COwJOOWJ9TdQo47aimx9BBIG913znb/jz+/6jLQL4qO8ev8bGLcg
 4GkMQ7rg7ztpa0a3rXsD72LlPIjiiCBYNpxDFi55FQxR60WWfO0QtwRVdajTXeF2L4Ck
 /lOTULEm3rgU0UO15sysH1c8OPyzlpS4uQ4q9BnDlkfVFZfs8UlcQgqtMn87nODhlkd8
 28+R5NXBhKtINAagD7LsmYTg+5UMEBWiGx2BurvoAi3U63mL9fNZU/GU4r2d4wRzhSlP
 mrWmJ2ZbeStjuKDpzPd3P6btvqN3IU7sP1ESCw8BNVbw6SfTew1SkHHaAf9kcQSVl3ca
 HEZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqME5DA1bAAqNkGMgjrvOZJk/zr5L9Q5gu1jhv+Hqa0wo5VwgJXmWQQcey47lciE0HHp4SzRk6PpdP@nongnu.org
X-Gm-Message-State: AOJu0YxldOFPF4xKjcHvDlGJpgm4cBvl5BExcmEtJKQhrclDfXUIG1ii
 P2ZiD1tz73aTBomK2Kun8WVegvQl8QU4X8bYDTUmkuwD0pRkWi/SnYCqjNYOo8UCtYw=
X-Gm-Gg: ATEYQzxeUtMft+mZQkFafniOyXyfaztnnXpG8G509hdz3PL2IlqJVoIq1q4J2XCy0Yx
 Yo02HJ4au/lx5KaDU4/RwVaCCIHjkng2m7cnVLLIBjXi1eo5YbpSFPmw8I3N+UGCIsJcAMP/pLE
 3vhLELg9cYXVfG620o/PeZQcRYDpWPogSkuL5cMfcZH+Ro0HQ5MEwfZTlU3hXYJYRBddU2O6JxG
 XT51yVc2d2UFzYLgXjdYkGm907it4lYML7RiLZaY5X3QnK3C82GJZosIu8ekqE+6i2Wlh1vO0jj
 mI+PbUKT1WDnjrsi38Y0C0DwJlggBuoP9mLxy4Z/Ao9ypxfS8EgOolSH3zSwNpQ+yZ4srhUebSi
 Q8M9MpNV/VpRhPzhA9yNVRu6vwQ1KzWmgajvVEPw25RlTxO4mNGmdw8XUgu5V5CqUzYqRM8s6QF
 /2j/0YW0INfYrGuIsjiuo1H1CzO58NEWR4aA==
X-Received: by 2002:a17:907:7251:b0:b8a:fd04:c789 with SMTP id
 a640c23a62f3a-b93f1372c45mr66359166b.22.1772614177641; 
 Wed, 04 Mar 2026 00:49:37 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fac07b7c2sm5118997a12.31.2026.03.04.00.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 00:49:37 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3A6785F7F5;
 Wed, 04 Mar 2026 08:49:36 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Yiwei Zhang
 <zzyiwei@gmail.com>,  Sergio Lopez Pascual <slp@redhat.com>,  Gert Wollny
 <gert.wollny@collabora.com>,  qemu-devel@nongnu.org,  Gurchetan Singh
 <gurchetansingh@chromium.org>,  Alyssa Ross <hi@alyssa.is>,  Roger Pau
 =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,  Alex Deucher
 <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K?=
 =?utf-8?Q?=C3=B6nig?=
 <christian.koenig@amd.com>,  Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>,  Julia Zhang
 <julia.zhang@amd.com>,  Chen Jiqian <Jiqian.Chen@amd.com>,  Rob Clark
 <robdclark@gmail.com>,  Robert Beckett <bob.beckett@collabora.com>
Subject: Re: [PATCH v22 06/18] ui/sdl2: Implement dpy dmabuf functions
In-Reply-To: <20260303151422.977399-7-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Tue, 3 Mar 2026 18:14:09 +0300")
References: <20260303151422.977399-1-dmitry.osipenko@collabora.com>
 <20260303151422.977399-7-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Wed, 04 Mar 2026 08:49:36 +0000
Message-ID: <874imwq8rj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>
> If EGL is used, we can rely on dmabuf to import textures without
> doing copies.
>
> To get this working on X11, we use the existing SDL hint:
> SDL_HINT_VIDEO_X11_FORCE_EGL (because dmabuf can't be used with GLX).
>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  include/ui/sdl2.h |  7 +++++
>  meson.build       |  6 ++---
>  ui/sdl2-gl.c      | 66 +++++++++++++++++++++++++++++++++++++++++++++++
>  ui/sdl2.c         | 42 ++++++++++++++++++++++++++++++
>  4 files changed, 117 insertions(+), 4 deletions(-)
>
> diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
> index dbe6e3d9739b..9daf5ecffae7 100644
> --- a/include/ui/sdl2.h
> +++ b/include/ui/sdl2.h
> @@ -45,6 +45,7 @@ struct sdl2_console {
>      bool gui_keysym;
>      SDL_GLContext winctx;
>      QKbdState *kbd;
> +    bool has_dmabuf;
>  #ifdef CONFIG_OPENGL
>      QemuGLShader *gls;
>      egl_fb guest_fb;
> @@ -96,5 +97,11 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dc=
l,
>                               void *d3d_tex2d);
>  void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
>                             uint32_t x, uint32_t y, uint32_t w, uint32_t =
h);
> +void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
> +                            QemuDmaBuf *dmabuf);
> +void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
> +                            QemuDmaBuf *dmabuf);
> +bool sdl2_gl_has_dmabuf(DisplayChangeListener *dcl);
> +void sdl2_gl_console_init(struct sdl2_console *scon);
>=20=20
>  #endif /* SDL2_H */
> diff --git a/meson.build b/meson.build
> index 3cd1d8dbc669..0ce84d45e6f3 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1937,10 +1937,8 @@ if get_option('gtk') \
>    endif
>  endif
>=20=20
> -x11 =3D not_found
> -if gtkx11.found()
> -  x11 =3D dependency('x11', method: 'pkg-config', required: gtkx11.found=
())
> -endif
> +x11 =3D dependency('x11', method: 'pkg-config', required: gtkx11.found())
> +
>  png =3D not_found
>  if get_option('png').allowed() and have_system
>     png =3D dependency('libpng', version: '>=3D1.6.34', required: get_opt=
ion('png'),
> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> index fbac3edbc09d..697ba2169c34 100644
> --- a/ui/sdl2-gl.c
> +++ b/ui/sdl2-gl.c
> @@ -26,6 +26,8 @@
>   */
>=20=20
>  #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/error-report.h"
>  #include "ui/console.h"
>  #include "ui/input.h"
>  #include "ui/sdl2.h"
> @@ -250,3 +252,67 @@ void sdl2_gl_scanout_flush(DisplayChangeListener *dc=
l,
>=20=20
>      SDL_GL_SwapWindow(scon->real_window);
>  }
> +
> +void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
> +                            QemuDmaBuf *dmabuf)
> +{
> +    struct sdl2_console *scon =3D container_of(dcl, struct sdl2_console,=
 dcl);
> +    const int *fds;
> +
> +    assert(scon->opengl);
> +    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
> +
> +    egl_dmabuf_import_texture(dmabuf);
> +    if (!qemu_dmabuf_get_texture(dmabuf)) {
> +        fds =3D qemu_dmabuf_get_fds(dmabuf, NULL);
> +        error_report("%s: failed fd=3D%d", __func__, fds ? fds[0] : -1);
> +        return;
> +    }
> +
> +    sdl2_gl_scanout_texture(dcl, qemu_dmabuf_get_texture(dmabuf), false,
> +                            qemu_dmabuf_get_width(dmabuf),
> +                            qemu_dmabuf_get_height(dmabuf),
> +                            0, 0,
> +                            qemu_dmabuf_get_width(dmabuf),
> +                            qemu_dmabuf_get_height(dmabuf),
> +                            NULL);
> +
> +    if (qemu_dmabuf_get_allow_fences(dmabuf)) {
> +        scon->guest_fb.dmabuf =3D dmabuf;
> +    }
> +}
> +
> +void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
> +                            QemuDmaBuf *dmabuf)
> +{
> +    egl_dmabuf_release_texture(dmabuf);
> +}
> +
> +bool sdl2_gl_has_dmabuf(DisplayChangeListener *dcl)
> +{
> +    struct sdl2_console *scon =3D container_of(dcl, struct sdl2_console,=
 dcl);
> +
> +    return scon->has_dmabuf;
> +}
> +
> +void sdl2_gl_console_init(struct sdl2_console *scon)
> +{
> +    bool hidden =3D scon->hidden;
> +
> +    scon->hidden =3D true;
> +    scon->surface =3D qemu_create_displaysurface(1, 1);
> +    sdl2_window_create(scon);
> +
> +    /*
> +     * QEMU checks whether console supports dma-buf before switching
> +     * to the console.  To break this chicken-egg problem we pre-check
> +     * dma-buf availability beforehand using a dummy SDL window.
> +     */
> +    scon->has_dmabuf =3D qemu_egl_has_dmabuf();
> +
> +    sdl2_window_destroy(scon);
> +    qemu_free_displaysurface(scon->surface);
> +
> +    scon->surface =3D NULL;
> +    scon->hidden =3D hidden;
> +}
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 032dc14bc398..3bb2676f847b 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -35,6 +35,10 @@
>  #include "qemu/log.h"
>  #include "qemu-main.h"
>=20=20
> +#ifdef CONFIG_X11
> +#include <X11/Xlib.h>
> +#endif
> +
>  static int sdl2_num_outputs;
>  static struct sdl2_console *sdl2_console;
>=20=20
> @@ -120,6 +124,9 @@ void sdl2_window_create(struct sdl2_console *scon)
>          /* The SDL renderer is only used by sdl2-2D, when OpenGL is disa=
bled */
>          scon->real_renderer =3D SDL_CreateRenderer(scon->real_window, -1=
, 0);
>      }
> +
> +    qemu_egl_display =3D eglGetCurrentDisplay();
> +

This fails on MacOS for some reason:

  o libsystem.a.p/ui_sdl2.c.o -c ../ui/sdl2.c
  ../ui/sdl2.c:128:5: error: use of undeclared identifier 'qemu_egl_display'
    128 |     qemu_egl_display =3D eglGetCurrentDisplay();
        |     ^
  ../ui/sdl2.c:128:24: error: call to undeclared function 'eglGetCurrentDis=
play'; ISO C99 and later do not support implicit function declarations [-Wi=
mplicit-function-declaration]
    128 |     qemu_egl_display =3D eglGetCurrentDisplay();
        |                        ^
  2 errors generated.

See: https://gitlab.com/stsquad/qemu/-/jobs/13340079105

Not sure what the include differences are because --enable-sdl builds
fine on Linux.

>      sdl_update_caption(scon);
>  }
>=20=20
> @@ -808,6 +815,10 @@ static const DisplayChangeListenerOps dcl_gl_ops =3D=
 {
>      .dpy_gl_scanout_disable  =3D sdl2_gl_scanout_disable,
>      .dpy_gl_scanout_texture  =3D sdl2_gl_scanout_texture,
>      .dpy_gl_update           =3D sdl2_gl_scanout_flush,
> +
> +    .dpy_gl_scanout_dmabuf   =3D sdl2_gl_scanout_dmabuf,
> +    .dpy_gl_release_dmabuf   =3D sdl2_gl_release_dmabuf,
> +    .dpy_has_dmabuf          =3D sdl2_gl_has_dmabuf,
>  };
>=20=20
>  static bool
> @@ -835,6 +846,35 @@ static void sdl2_display_early_init(DisplayOptions *=
o)
>      }
>  }
>=20=20
> +static void sdl2_set_hint_x11_force_egl(void)
> +{
> +#if defined(SDL_HINT_VIDEO_X11_FORCE_EGL) && defined(CONFIG_OPENGL) && \
> +    defined(CONFIG_X11)
> +    Display *x_disp =3D XOpenDisplay(NULL);
> +    EGLDisplay egl_display;
> +
> +    if (!x_disp) {
> +        return;
> +    }
> +
> +    /* Prefer EGL over GLX to get dma-buf support. */
> +    egl_display =3D eglGetDisplay((EGLNativeDisplayType)x_disp);
> +
> +    if (egl_display !=3D EGL_NO_DISPLAY) {
> +        /*
> +         * Setting X11_FORCE_EGL hint doesn't make SDL to prefer X11 over
> +         * Wayland. SDL will use Wayland driver even if XWayland present=
s.
> +         * It's always safe to set the hint even if X11 is not used by S=
DL.
> +         * SDL will work regardless of the hint.
> +         */
> +        SDL_SetHint(SDL_HINT_VIDEO_X11_FORCE_EGL, "1");
> +        eglTerminate(egl_display);
> +    }
> +
> +    XCloseDisplay(x_disp);
> +#endif
> +}
> +
>  static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
>  {
>      uint8_t data =3D 0;
> @@ -862,6 +902,7 @@ static void sdl2_display_init(DisplayState *ds, Displ=
ayOptions *o)
>      SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
>  #endif
>      SDL_SetHint(SDL_HINT_WINDOWS_NO_CLOSE_ON_ALT_F4, "1");
> +    sdl2_set_hint_x11_force_egl();
>      SDL_EnableScreenSaver();
>      memset(&info, 0, sizeof(info));
>      SDL_VERSION(&info.version);
> @@ -908,6 +949,7 @@ static void sdl2_display_init(DisplayState *ds, Displ=
ayOptions *o)
>          sdl2_console[i].kbd =3D qkbd_state_init(con);
>          if (display_opengl) {
>              qemu_console_set_display_gl_ctx(con, &sdl2_console[i].dgc);
> +            sdl2_gl_console_init(&sdl2_console[i]);
>          }
>          register_displaychangelistener(&sdl2_console[i].dcl);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

