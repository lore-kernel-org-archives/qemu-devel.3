Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E93EEB7ECF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 12:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxl4O-0003vR-Pq; Wed, 04 Mar 2026 07:11:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxl4M-0003vD-Pt
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 07:11:15 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxl4K-0005xl-Nr
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 07:11:14 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b935a74b7c2so918884466b.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 04:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772626271; x=1773231071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dyswVzSYu2bNIYUixRTP9TDLLf2WN2d7TAh3uYxSVCA=;
 b=vk98N/IEWmsy9BNABQ9fBUDybkD/UjzYAfa178Y2SJCaJJ/j9KTfehO7sHj/yIRpTW
 ORUIFf5qi935dcGiee1PjBfQTL9d2TzaUdaVAiuZaiq+9KVPDINLE6cKI6SPceYgkM2D
 MpDw9qbd9RN0kqm3EHQVFHTj76s6Kwj7w8xhyKOErh7zjcCdUNdJMHqVsK3eJpu5Xsuh
 VWWYDYuY0UVJ1LAtKOUZBQLH2H1RUNCN41vr5H36x/ibvMB4RCRr+RrhiHKE/pMdbot0
 jx6ZXVuYoE4LT53EN1MZaktL3ZXtBkTKXKVwC/4lDU2nYn/pjj+hd8hJYjiy6q6srquW
 FoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772626271; x=1773231071;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dyswVzSYu2bNIYUixRTP9TDLLf2WN2d7TAh3uYxSVCA=;
 b=G0Y6OZtco9FvJ5uaWyhKnqRTjRFnA6ti8b9XXd3lo4KFGrwED1p3nOgqrzgcstv9SL
 YzMwrlrUHwpjFuSx8ZgmGG+fPp7jw64V02blC3aRYLd10/KPaK7jrsy327KaZn+VO1BM
 0JLXd8RqACz8c4oSeS66ysFxjMsQqSo3WhoxMnDR0CrOJkMZI6l0RK2QC8MDwfdrL3qp
 2bFV0Zo6C3LVe5T9gKkofU4YkIvwA9m3q4Z0syhcmUGKHxI/da7105p2ytyWn7WYJVhy
 SUDaG+zkTGjOFBD7yxSrE2DUxTd5WPf9jCdfrWl5MSRkrTzPWAN4NdEIpSYjLT39nHWa
 E13w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrpMPvu+hg11PNZytIVppy5IPArEveIlDyuLUvSk4pQOCIC+Kw/aFDjoTfwmGJnIt9wKA/RhXUu5jS@nongnu.org
X-Gm-Message-State: AOJu0YymaQ87Wh60u4EtOjt3FqcMCXE1NoJkOg5pX/GV5Nnn0L+BoX5W
 AIWdLyPr2jFN3eWHViVanEAYpy7WyolfaApfaagkJoiY87ECejXelW/Um8M6tvGHgEg=
X-Gm-Gg: ATEYQzy1XjaxupEV9VIAtUJu2jRDQNJgNZck0leexmRCUtGVFWmxLdwatBnvUCUOYe7
 ZWLmr3KXcEns+RcfaTTqRfahfZ61c2My7xOTzybObYGRh1Uq8DdMJCpcuR8EzTk2J/65excn1sF
 vDsrI9YDD/W4/2SSoJ1NJ1TdAcit5GaX+PQm0HOfyumed2iRDsQCl2mD0NKKpezpgGzTzo2Whxw
 y5ni826fOX5FhcS5E0pBs6dY8ZSQebsuh0iJFVWIF6tMg9jb1FdrHwKQwDBBOY51QxosnjaHLjy
 ogUpk3PxN/PL2GgSPay/N3EjyHHpKTz76e7qSXbpBOc/Ol4Snw3LX4drztsZHBDJW7ybDKv3/1L
 bEqbJqP5dPDStiDKWAkwsNMTyKkn/6V240xRlwQAmN2lcMdWu4MO0vPcman+AWFjHGxgvqCLvnh
 G+NNIWWg8h2YHe2mga2eYLetY=
X-Received: by 2002:a17:907:e8e:b0:b93:80f3:b36b with SMTP id
 a640c23a62f3a-b93f11ec4d2mr115363066b.7.1772626270905; 
 Wed, 04 Mar 2026 04:11:10 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935aec3243sm728387266b.53.2026.03.04.04.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 04:11:10 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9959A5F7F5;
 Wed, 04 Mar 2026 12:11:09 +0000 (GMT)
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
In-Reply-To: <feff43ef-1618-4a09-aba4-e4e9c2d07e2c@collabora.com> (Dmitry
 Osipenko's message of "Wed, 4 Mar 2026 13:33:34 +0300")
References: <20260303151422.977399-1-dmitry.osipenko@collabora.com>
 <20260303151422.977399-7-dmitry.osipenko@collabora.com>
 <874imwq8rj.fsf@draig.linaro.org>
 <feff43ef-1618-4a09-aba4-e4e9c2d07e2c@collabora.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Wed, 04 Mar 2026 12:11:09 +0000
Message-ID: <87ms0npzfm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

> On 3/4/26 11:49, Alex Benn=C3=A9e wrote:
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>=20
>>> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>>
>>> If EGL is used, we can rely on dmabuf to import textures without
>>> doing copies.
>>>
>>> To get this working on X11, we use the existing SDL hint:
>>> SDL_HINT_VIDEO_X11_FORCE_EGL (because dmabuf can't be used with GLX).
>>>
>>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@a=
md.com>
>>> Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> ---
>>>  include/ui/sdl2.h |  7 +++++
>>>  meson.build       |  6 ++---
>>>  ui/sdl2-gl.c      | 66 +++++++++++++++++++++++++++++++++++++++++++++++
>>>  ui/sdl2.c         | 42 ++++++++++++++++++++++++++++++
>>>  4 files changed, 117 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
>>> index dbe6e3d9739b..9daf5ecffae7 100644
>>> --- a/include/ui/sdl2.h
>>> +++ b/include/ui/sdl2.h
>>> @@ -45,6 +45,7 @@ struct sdl2_console {
>>>      bool gui_keysym;
>>>      SDL_GLContext winctx;
>>>      QKbdState *kbd;
>>> +    bool has_dmabuf;
>>>  #ifdef CONFIG_OPENGL
>>>      QemuGLShader *gls;
>>>      egl_fb guest_fb;
>>> @@ -96,5 +97,11 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *=
dcl,
>>>                               void *d3d_tex2d);
>>>  void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
>>>                             uint32_t x, uint32_t y, uint32_t w, uint32_=
t h);
>>> +void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
>>> +                            QemuDmaBuf *dmabuf);
>>> +void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
>>> +                            QemuDmaBuf *dmabuf);
>>> +bool sdl2_gl_has_dmabuf(DisplayChangeListener *dcl);
>>> +void sdl2_gl_console_init(struct sdl2_console *scon);
>>>=20=20
>>>  #endif /* SDL2_H */
>>> diff --git a/meson.build b/meson.build
>>> index 3cd1d8dbc669..0ce84d45e6f3 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -1937,10 +1937,8 @@ if get_option('gtk') \
>>>    endif
>>>  endif
>>>=20=20
>>> -x11 =3D not_found
>>> -if gtkx11.found()
>>> -  x11 =3D dependency('x11', method: 'pkg-config', required: gtkx11.fou=
nd())
>>> -endif
>>> +x11 =3D dependency('x11', method: 'pkg-config', required: gtkx11.found=
())
>>> +
>>>  png =3D not_found
>>>  if get_option('png').allowed() and have_system
>>>     png =3D dependency('libpng', version: '>=3D1.6.34', required: get_o=
ption('png'),
>>> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
>>> index fbac3edbc09d..697ba2169c34 100644
>>> --- a/ui/sdl2-gl.c
>>> +++ b/ui/sdl2-gl.c
>>> @@ -26,6 +26,8 @@
>>>   */
>>>=20=20
>>>  #include "qemu/osdep.h"
>>> +#include "qemu/main-loop.h"
>>> +#include "qemu/error-report.h"
>>>  #include "ui/console.h"
>>>  #include "ui/input.h"
>>>  #include "ui/sdl2.h"
>>> @@ -250,3 +252,67 @@ void sdl2_gl_scanout_flush(DisplayChangeListener *=
dcl,
>>>=20=20
>>>      SDL_GL_SwapWindow(scon->real_window);
>>>  }
>>> +
>>> +void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
>>> +                            QemuDmaBuf *dmabuf)
>>> +{
>>> +    struct sdl2_console *scon =3D container_of(dcl, struct sdl2_consol=
e, dcl);
>>> +    const int *fds;
>>> +
>>> +    assert(scon->opengl);
>>> +    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>>> +
>>> +    egl_dmabuf_import_texture(dmabuf);
>>> +    if (!qemu_dmabuf_get_texture(dmabuf)) {
>>> +        fds =3D qemu_dmabuf_get_fds(dmabuf, NULL);
>>> +        error_report("%s: failed fd=3D%d", __func__, fds ? fds[0] : -1=
);
>>> +        return;
>>> +    }
>>> +
>>> +    sdl2_gl_scanout_texture(dcl, qemu_dmabuf_get_texture(dmabuf), fals=
e,
>>> +                            qemu_dmabuf_get_width(dmabuf),
>>> +                            qemu_dmabuf_get_height(dmabuf),
>>> +                            0, 0,
>>> +                            qemu_dmabuf_get_width(dmabuf),
>>> +                            qemu_dmabuf_get_height(dmabuf),
>>> +                            NULL);
>>> +
>>> +    if (qemu_dmabuf_get_allow_fences(dmabuf)) {
>>> +        scon->guest_fb.dmabuf =3D dmabuf;
>>> +    }
>>> +}
>>> +
>>> +void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
>>> +                            QemuDmaBuf *dmabuf)
>>> +{
>>> +    egl_dmabuf_release_texture(dmabuf);
>>> +}
>>> +
>>> +bool sdl2_gl_has_dmabuf(DisplayChangeListener *dcl)
>>> +{
>>> +    struct sdl2_console *scon =3D container_of(dcl, struct sdl2_consol=
e, dcl);
>>> +
>>> +    return scon->has_dmabuf;
>>> +}
>>> +
>>> +void sdl2_gl_console_init(struct sdl2_console *scon)
>>> +{
>>> +    bool hidden =3D scon->hidden;
>>> +
>>> +    scon->hidden =3D true;
>>> +    scon->surface =3D qemu_create_displaysurface(1, 1);
>>> +    sdl2_window_create(scon);
>>> +
>>> +    /*
>>> +     * QEMU checks whether console supports dma-buf before switching
>>> +     * to the console.  To break this chicken-egg problem we pre-check
>>> +     * dma-buf availability beforehand using a dummy SDL window.
>>> +     */
>>> +    scon->has_dmabuf =3D qemu_egl_has_dmabuf();
>>> +
>>> +    sdl2_window_destroy(scon);
>>> +    qemu_free_displaysurface(scon->surface);
>>> +
>>> +    scon->surface =3D NULL;
>>> +    scon->hidden =3D hidden;
>>> +}
>>> diff --git a/ui/sdl2.c b/ui/sdl2.c
>>> index 032dc14bc398..3bb2676f847b 100644
>>> --- a/ui/sdl2.c
>>> +++ b/ui/sdl2.c
>>> @@ -35,6 +35,10 @@
>>>  #include "qemu/log.h"
>>>  #include "qemu-main.h"
>>>=20=20
>>> +#ifdef CONFIG_X11
>>> +#include <X11/Xlib.h>
>>> +#endif
>>> +
>>>  static int sdl2_num_outputs;
>>>  static struct sdl2_console *sdl2_console;
>>>=20=20
>>> @@ -120,6 +124,9 @@ void sdl2_window_create(struct sdl2_console *scon)
>>>          /* The SDL renderer is only used by sdl2-2D, when OpenGL is di=
sabled */
>>>          scon->real_renderer =3D SDL_CreateRenderer(scon->real_window, =
-1, 0);
>>>      }
>>> +
>>> +    qemu_egl_display =3D eglGetCurrentDisplay();
>>> +
>>=20
>> This fails on MacOS for some reason:
>>=20
>>   o libsystem.a.p/ui_sdl2.c.o -c ../ui/sdl2.c
>>   ../ui/sdl2.c:128:5: error: use of undeclared identifier 'qemu_egl_disp=
lay'
>>     128 |     qemu_egl_display =3D eglGetCurrentDisplay();
>>         |     ^
>>   ../ui/sdl2.c:128:24: error: call to undeclared function
>> 'eglGetCurrentDisplay'; ISO C99 and later do not support implicit
>> function declarations [-Wimplicit-function-declaration]
>>     128 |     qemu_egl_display =3D eglGetCurrentDisplay();
>>         |                        ^
>>   2 errors generated.
>>=20
>> See: https://gitlab.com/stsquad/qemu/-/jobs/13340079105
>>=20
>> Not sure what the include differences are because --enable-sdl builds
>> fine on Linux.
>
> Please try with this change and let me know if you could squash it or I
> need to send a patch:
>
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 3bb2676f847b..2603b0c2bdd8 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -125,7 +125,9 @@ void sdl2_window_create(struct sdl2_console *scon)
>          scon->real_renderer =3D SDL_CreateRenderer(scon->real_window, -1=
, 0);
>      }
>
> +#ifdef CONFIG_OPENGL
>      qemu_egl_display =3D eglGetCurrentDisplay();
> +#endif
>
>      sdl_update_caption(scon);
>  }

There is one remaining build failure for win64:

  ../ui/sdl2-gl.c: In function 'sdl2_gl_scanout_dmabuf':
  ../ui/sdl2-gl.c:265:5: error: implicit declaration of function 'egl_dmabu=
f_import_texture'; did you mean 'qemu_dmabuf_set_texture'? [-Wimplicit-func=
tion-declaration]
    265 |     egl_dmabuf_import_texture(dmabuf);
        |     ^~~~~~~~~~~~~~~~~~~~~~~~~
        |     qemu_dmabuf_set_texture
  ../ui/sdl2-gl.c:265:5: error: nested extern declaration of 'egl_dmabuf_im=
port_texture' [-Werror=3Dnested-externs]
  ../ui/sdl2-gl.c: In function 'sdl2_gl_release_dmabuf':
  ../ui/sdl2-gl.c:288:5: error: implicit declaration of function 'egl_dmabu=
f_release_texture'; did you mean 'qemu_dmabuf_set_texture'? [-Wimplicit-fun=
ction-declaration]
    288 |     egl_dmabuf_release_texture(dmabuf);
        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
        |     qemu_dmabuf_set_texture
  ../ui/sdl2-gl.c:288:5: error: nested extern declaration of 'egl_dmabuf_re=
lease_texture' [-Werror=3Dnested-externs]
  cc1: all warnings being treated as errors

See: https://gitlab.com/stsquad/qemu/-/jobs/13340078806

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

