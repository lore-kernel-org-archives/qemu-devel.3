Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBD3C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 10:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh3hK-0003L1-L0; Wed, 30 Jul 2025 06:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uh3fz-0002J1-Ud
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 06:04:48 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uh3fu-0000Ts-AN
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 06:04:47 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4ab60e97cf8so79440561cf.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753869879; x=1754474679; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WIUXFDFZ4MRUrUE8RvupX1F3T3zmpgB9joR3x7zygRI=;
 b=HAeVJtuJKAO3fCR7f6o6tw4r4ijJbUF/272FyN9AguWX+pFZxiGrMjsBXlnS8Miiqn
 Bt0V9TtUsoSQ3CADGhpO7DJxFJ0BJyjlnZQranAjWErN2DhPKAje55KNVnjZNPJ8FVue
 TYJ3itHRYusyjXEzTVSxNrf/GZ6RxByhmWLx3V3hyBp89LCdl08diGPZPwWPB5K9ab1C
 EYZ1UENrpVF/UkAAHIhiy/YbFcUwqmIcloj783e8rGsh+evP5n54kAEcM/hPCfWrd8r+
 pvkRpxIED9A1Tdy9PHlw44JLtWTkNFb86yPFK82uv5wW/oddHHKfwwBWzvU2aaCdxQ66
 CUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753869879; x=1754474679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WIUXFDFZ4MRUrUE8RvupX1F3T3zmpgB9joR3x7zygRI=;
 b=DNM0OuPCcz+vvSvJ/a+YmAm0/tXu8Ng6PD3eXLNMzwR9MHjCE5xvr+tjQSdHppaDog
 A6Y5FBg1r8FgldXK6BlMDwEvkzpY1aF2MbJ/qTaxKZ3Otzl5KNTM6+xGiEugPW0LYpBf
 IPro892lzuXUijj1KEyPuwFhrji8if2nFRJEDlTF+FwnQPJ89X+2cklliFoa8rtsfcxm
 hlVx6YCWbPxT2YVjJlvpr5p4Fi4NQXyiv9+c7RV8mBFhygA85n4aXWR8legG2nJrcNAI
 d5UXdlruCG4epW0h4HVUCUTwjezsoC/eOUoywYGtpTk2k3Lm5phqrVy1i8tqvn82U8Qk
 oLzw==
X-Gm-Message-State: AOJu0YyRApfNFfZq0ZxOSvmr2WakmnX/B4emdr2MO0epXdy7i0L2EuIK
 kmy1/a5BCMA8NOnk7J/iHlJbCCc6jtgPJiJ8ZspzReJAi2UB2oBMYE/kzCKQE/zbYie4h1LX1qX
 zm5P0EhlHMu6tM6AcwwzHiVN8XHvCU2GwvFpUF4svrw==
X-Gm-Gg: ASbGncv6slamJXrEpegfMoZqe8fo5+3BJiomEXSkjj5G5clKYoQFtwqszChGZBZPeRI
 Na0tFa9wWZ0Bza8nJ6PB+HJjv8NrNg/w89cspPlMrGbYjoZOtv8aQOI1VULbyHquBmiezRlWDfE
 veixbU9dP5iHDQOlavyfhvYx4mkA4QJYzEx6t7KRUmgkD6x8JVNCh2CjEzkEgIEfS0LVR9HOBsL
 NIGo0OI
X-Google-Smtp-Source: AGHT+IG24zK1gTBJoF5Kc2/rPINlmCGQeBpBraDAC2rRMzjonleQFijVV8PQrxgSrX7GH4Z9elIPXEi3b2eByGyUGM4=
X-Received: by 2002:a05:622a:204:b0:4ae:6ac1:f497 with SMTP id
 d75a77b69052e-4aedbc45f60mr42490911cf.32.1753869878933; Wed, 30 Jul 2025
 03:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <2cKNS7U_kE-Y4pOsCItcM1RhyWnkbpj0zicXQjMfV2AvXvx-Q5hg9lhWL9kZl3hAPpdbbuOilUAG1ahp7_YL2Gscf4iacyenhegHAvYlO_M=@protonmail.com>
 <CAJ+F1CL29s4Czp-dv2cMt=aEqngCEDNKNyBVsRcFfqfnXxo57Q@mail.gmail.com>
 <7evd1nX-kHgOCNpPH3vAJnNYZmzXG1b7wzs_aBHDQBVl1KOBk4SGM055Rcq7XN8TAaqGauW5hv0EFQrwQTISgLLl8Q1U6sfccK_lS7f4ftk=@protonmail.com>
In-Reply-To: <7evd1nX-kHgOCNpPH3vAJnNYZmzXG1b7wzs_aBHDQBVl1KOBk4SGM055Rcq7XN8TAaqGauW5hv0EFQrwQTISgLLl8Q1U6sfccK_lS7f4ftk=@protonmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 30 Jul 2025 14:04:27 +0400
X-Gm-Features: Ac12FXy2-V8aDhWp-wRKMm_xaSWAeNxjW8w8mz0O-uo87Bik_O9eP-dbOUdQtlY
Message-ID: <CAJ+F1CLA3A7=Xag6764+0XhLSmgz=c4rztSM=k1PryK=QGVcbw@mail.gmail.com>
Subject: Re: [PATCH RFC v1 1/1] ui/sdl2: clipboard sharing implementation for
 SDL
To: startergo <startergo@protonmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x835.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

On Wed, Jul 30, 2025 at 1:34=E2=80=AFPM startergo <startergo@protonmail.com=
> wrote:
>
> Hi Marc-Andr=C3=A9,
> Please review the updated code and let me know if there is anything else =
left to fix:
>
> This update fixes:
> =E2=9C=85 Runtime Stability: QEMU starts and runs without crashes
> =E2=9C=85 Async Handling: Proper async clipboard request tracking
> =E2=9C=85 Error Handling: Comprehensive SDL error reporting
> =E2=9C=85 Memory Management: Correct use of g_autofree and proper cleanup
> =E2=9C=85 QEMU Integration: Full integration with QEMU's clipboard subsys=
tem:
>

Please send a properly formatted git patch:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#do-not-send-=
as-an-attachment

> diff -ruN qemu-10.0.0-original/include/ui/sdl2.h qemu-10.0.0-modified/inc=
lude/ui/sdl2.h
> --- qemu-10.0.0-original/include/ui/sdl2.h      2025-07-30 11:51:59
> +++ qemu-10.0.0-modified/include/ui/sdl2.h      2025-07-30 11:58:44
> @@ -21,6 +21,10 @@
>  # include <SDL_image.h>
>  #endif
>
> +#ifdef CONFIG_SDL_CLIPBOARD
> +#include "ui/clipboard.h"
> +#endif
> +
>  #include "ui/kbd-state.h"
>  #ifdef CONFIG_OPENGL
>  # include "ui/egl-helpers.h"
> @@ -45,6 +49,9 @@
>      bool gui_keysym;
>      SDL_GLContext winctx;
>      QKbdState *kbd;
> +#ifdef CONFIG_SDL_CLIPBOARD
> +    QemuClipboardPeer cbpeer;
> +#endif
>  #ifdef CONFIG_OPENGL
>      QemuGLShader *gls;
>      egl_fb guest_fb;
> @@ -96,5 +103,10 @@
>                               void *d3d_tex2d);
>  void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
>                             uint32_t x, uint32_t y, uint32_t w, uint32_t =
h);
> +
> +#ifdef CONFIG_SDL_CLIPBOARD
> +void sdl2_clipboard_init(struct sdl2_console *scon);
> +void sdl2_clipboard_handle_request(struct sdl2_console *scon);
> +#endif
>
>  #endif /* SDL2_H */
> diff -ruN qemu-10.0.0-original/meson.build qemu-10.0.0-modified/meson.bui=
ld
> --- qemu-10.0.0-original/meson.build    2025-07-30 11:52:13
> +++ qemu-10.0.0-modified/meson.build    2025-07-30 11:58:28
> @@ -1596,6 +1596,8 @@
>    sdl_image =3D not_found
>  endif
>
> +have_sdl_clipboard =3D sdl.found() and get_option('sdl_clipboard')
> +
>  rbd =3D not_found
>  if not get_option('rbd').auto() or have_block
>    librados =3D cc.find_library('rados', required: get_option('rbd'))
> @@ -2511,6 +2513,7 @@
>  config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
>  config_host_data.set('CONFIG_SDL', sdl.found())
>  config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
> +config_host_data.set('CONFIG_SDL_CLIPBOARD', have_sdl_clipboard)
>  config_host_data.set('CONFIG_SECCOMP', seccomp.found())
>  if seccomp.found()
>    config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
> diff -ruN qemu-10.0.0-original/meson_options.txt qemu-10.0.0-modified/mes=
on_options.txt
> --- qemu-10.0.0-original/meson_options.txt      2025-07-30 11:52:13
> +++ qemu-10.0.0-modified/meson_options.txt      2025-07-30 11:58:15
> @@ -212,6 +212,8 @@
>         description: 'SDL user interface')
>  option('sdl_image', type : 'feature', value : 'auto',
>         description: 'SDL Image support for icons')
> +option('sdl_clipboard', type : 'boolean', value : true,
> +       description: 'SDL clipboard support')
>  option('seccomp', type : 'feature', value : 'auto',
>         description: 'seccomp support')
>  option('smartcard', type : 'feature', value : 'auto',
> diff -ruN qemu-10.0.0-original/ui/meson.build qemu-10.0.0-modified/ui/mes=
on.build
> --- qemu-10.0.0-original/ui/meson.build 2025-07-30 11:51:58
> +++ qemu-10.0.0-modified/ui/meson.build 2025-07-30 11:59:00
> @@ -126,6 +126,9 @@
>      'sdl2-input.c',
>      'sdl2.c',
>    ))
> +  if have_sdl_clipboard
> +    sdl_ss.add(files('sdl2-clipboard.c'))
> +  endif
>    sdl_ss.add(when: opengl, if_true: files('sdl2-gl.c'))
>    sdl_ss.add(when: x11, if_true: files('x_keymap.c'))
>    ui_modules +=3D {'sdl' : sdl_ss}
> diff -ruN qemu-10.0.0-original/ui/sdl2-clipboard.c qemu-10.0.0-modified/u=
i/sdl2-clipboard.c
> --- qemu-10.0.0-original/ui/sdl2-clipboard.c    1970-01-01 02:00:00
> +++ qemu-10.0.0-modified/ui/sdl2-clipboard.c    2025-07-30 12:13:25
> @@ -0,0 +1,154 @@
> +/*
> + * SDL UI -- clipboard support (improved async version)
> + *
> + * Copyright (C) 2023 Kamay Xutax <admin@xutaxkamay.com>
> + * Copyright (C) 2025 startergo <startergo@protonmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "ui/console.h"
> +#include "ui/clipboard.h"
> +#include "ui/sdl2.h"
> +#include "qemu/log.h"
> +
> +#ifdef CONFIG_SDL_CLIPBOARD
> +
> +/* Track pending clipboard requests to handle async data */
> +typedef struct {
> +    struct sdl2_console *scon;
> +    QemuClipboardInfo *info;
> +    QemuClipboardType type;
> +} SDLClipboardRequest;
> +
> +static SDLClipboardRequest *pending_request =3D NULL;
> +
> +static void sdl2_clipboard_clear_pending(void)
> +{
> +    if (pending_request) {
> +        if (pending_request->info) {
> +            qemu_clipboard_info_unref(pending_request->info);
> +        }
> +        g_free(pending_request);
> +        pending_request =3D NULL;
> +    }
> +}
> +
> +static void sdl2_clipboard_notify(Notifier *notifier, void *data)
> +{
> +    QemuClipboardNotify *notify =3D data;
> +    struct sdl2_console *scon =3D
> +        container_of(notifier, struct sdl2_console, cbpeer.notifier);
> +    bool self_update =3D notify->info->owner =3D=3D &scon->cbpeer;
> +    const char *text_data;
> +    size_t text_size;
> +
> +    switch (notify->type) {
> +    case QEMU_CLIPBOARD_UPDATE_INFO:
> +        {
> +            /* Skip self-updates to avoid clipboard manager conflicts */
> +            if (self_update) {
> +                return;
> +            }
> +
> +            if (!notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].available=
) {
> +                return;
> +            }
> +
> +            /* Check if this is completion of our pending request */
> +            if (pending_request && pending_request->info =3D=3D notify->=
info &&
> +                pending_request->type =3D=3D QEMU_CLIPBOARD_TYPE_TEXT) {
> +                sdl2_clipboard_clear_pending();
> +            }
> +
> +            /* Check if data is available, request asynchronously if not=
 */
> +            if (!notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].data) {
> +                if (!pending_request) {
> +                    pending_request =3D g_new0(SDLClipboardRequest, 1);
> +                    pending_request->scon =3D scon;
> +                    pending_request->info =3D qemu_clipboard_info_ref(no=
tify->info);
> +                    pending_request->type =3D QEMU_CLIPBOARD_TYPE_TEXT;
> +                    qemu_clipboard_request(notify->info, QEMU_CLIPBOARD_=
TYPE_TEXT);
> +                }
> +                return;
> +            }
> +
> +            /* Process available data */
> +            text_size =3D notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].=
size;
> +            if (text_size =3D=3D 0) {
> +                return;
> +            }
> +
> +            text_data =3D (const char *)notify->info->types[QEMU_CLIPBOA=
RD_TYPE_TEXT].data;
> +
> +            /* Ensure null termination for SDL clipboard */
> +            g_autofree char *text =3D g_strndup(text_data, text_size);
> +            if (text && text[0] !=3D '\0') {
> +                SDL_SetClipboardText(text);
> +            } else if (!text) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "SDL clipboard: Failed to allocate memory =
for clipboard text\n");
> +            }
> +            break;
> +        }
> +    case QEMU_CLIPBOARD_RESET_SERIAL:
> +        sdl2_clipboard_clear_pending();
> +        break;
> +    }
> +}
> +
> +static void sdl2_clipboard_request(QemuClipboardInfo *info,
> +                                   QemuClipboardType type)
> +{
> +    g_autofree char *text =3D NULL;
> +
> +    if (type !=3D QEMU_CLIPBOARD_TYPE_TEXT) {
> +        return;
> +    }
> +
> +    text =3D SDL_GetClipboardText();
> +    if (!text) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "SDL clipboard: Failed to get clipboard text: %s\n=
",
> +                      SDL_GetError());
> +        return;
> +    }
> +
> +    qemu_clipboard_set_data(info->owner, info, type,
> +                            strlen(text), text, true);
> +}
> +
> +void sdl2_clipboard_init(struct sdl2_console *scon)
> +{
> +    scon->cbpeer.name =3D "sdl2-clipboard";
> +    scon->cbpeer.notifier.notify =3D sdl2_clipboard_notify;
> +    scon->cbpeer.request =3D sdl2_clipboard_request;
> +
> +    qemu_clipboard_peer_register(&scon->cbpeer);
> +}
> +
> +void sdl2_clipboard_handle_request(struct sdl2_console *scon)
> +{
> +    g_autofree char *text =3D NULL;
> +    QemuClipboardInfo *info;
> +
> +    text =3D SDL_GetClipboardText();
> +    if (!text) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "SDL clipboard: Failed to get clipboard text: %s\n=
",
> +                      SDL_GetError());
> +        return;
> +    }
> +
> +    if (text[0] =3D=3D '\0') {
> +        return; /* Ignore empty clipboard */
> +    }
> +
> +    info =3D qemu_clipboard_info_new(&scon->cbpeer, QEMU_CLIPBOARD_SELEC=
TION_CLIPBOARD);
> +    qemu_clipboard_set_data(&scon->cbpeer, info, QEMU_CLIPBOARD_TYPE_TEX=
T,
> +                            strlen(text), text, true);
> +    qemu_clipboard_info_unref(info);
> +}
> +
> +#endif /* CONFIG_SDL_CLIPBOARD */
> diff -ruN qemu-10.0.0-original/ui/sdl2.c qemu-10.0.0-modified/ui/sdl2.c
> --- qemu-10.0.0-original/ui/sdl2.c      2025-07-30 11:51:58
> +++ qemu-10.0.0-modified/ui/sdl2.c      2025-07-30 11:59:22
> @@ -691,6 +691,11 @@
>          case SDL_WINDOWEVENT:
>              handle_windowevent(ev);
>              break;
> +#ifdef CONFIG_SDL_CLIPBOARD
> +        case SDL_CLIPBOARDUPDATE:
> +            sdl2_clipboard_handle_request(scon);
> +            break;
> +#endif
>          default:
>              break;
>          }
> @@ -900,6 +905,10 @@
>              qemu_console_set_display_gl_ctx(con, &sdl2_console[i].dgc);
>          }
>          register_displaychangelistener(&sdl2_console[i].dcl);
> +
> +#ifdef CONFIG_SDL_CLIPBOARD
> +        sdl2_clipboard_init(&sdl2_console[i]);
> +#endif
>
>  #if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)
>          if (SDL_GetWindowWMInfo(sdl2_console[i].real_window, &info)) {
>
>
>
>
>
> Sent with Proton Mail secure email.
>
> On Tuesday, July 29th, 2025 at 3:11 PM, Marc-Andr=C3=A9 Lureau <marcandre=
.lureau@gmail.com> wrote:
>
> > Hi
> >
> > On Mon, Jul 28, 2025 at 5:06=E2=80=AFPM startergo startergo@protonmail.=
com wrote:
> >
> > > Subject: Re: [PATCH RFC v1 1/1] ui/sdl2: clipboard sharing implementa=
tion for SDL
> > > In-Reply-To: CAKmqyKM+4KBqYnhKqwXqPHyP1zN5CrTXC4R7yJ8wBX5M+tCyoA@mail=
.gmail.com
> > > References: 20231108105411.1759509-1-admin@xutaxkamay.com CAKmqyKM+4K=
BqYnhKqwXqPHyP1zN5CrTXC4R7yJ8wBX5M+tCyoA@mail.gmail.com
> > >
> > > Hi Marc-Andr=C3=A9,
> > >
> > > Following up on your thoughtful review of the SDL clipboard RFC from =
November 2023,
> > > I've developed a comprehensive implementation that directly addresses=
 the concerns
> > > you raised about main loop reentrancy and clipboard management issues=
.
> > >
> > > ## Key Improvements Addressing Your Feedback:
> > >
> > > 1. Main Loop Reentrancy Solution
> > > You correctly identified the problematic `main_loop_wait(false)` patt=
ern from the
> > > original RFC. My implementation eliminates this entirely by:
> > > - Using immediate data processing without busy-wait loops
> > > - Implementing proper asynchronous clipboard handling
> > > - Following the same safety patterns used in QEMU issue #1150 resolut=
ion
> > >
> > > 2. Clipboard Manager Conflict Prevention
> > > Your concern about fighting with clipboard managers is addressed thro=
ugh:
> > > - Self-update loop prevention in `sdl2_clipboard_update()`
> > > - Clean ownership tracking via `info->owner =3D=3D &scon->cbpeer` che=
cks
> > > - No automatic clipboard stealing or aggressive management behavior
> > >
> > > 3. Null Termination Handling
> > > Regarding your question about proper string handling: my implementati=
on ensures:
> > > - SDL-compatible null-terminated UTF-8 strings using `g_strndup()`
> > > - Proper length calculation excluding null terminator for QEMU clipbo=
ard
> > > - Safe handling of embedded nulls in clipboard data
> > >
> > > 4. Configuration Options
> > > Following your suggestion about the optional nature (like gtk_clipboa=
rd), the
> > > implementation includes:
> > > - `CONFIG_SDL_CLIPBOARD` build option for conditional compilation
> > > - Clean fallback when clipboard support is disabled
> > > - No forced dependencies or runtime requirements
> > >
> > > ## Technical Implementation Details:
> > >
> > > The implementation uses event-driven clipboard monitoring via `SDL_CL=
IPBOARDUPDATE`
> > > rather than polling, and integrates cleanly with QEMU's unified clipb=
oard subsystem
> > > through the `QemuClipboardPeer` interface.
> > >
> > > Key safety features:
> > > - No main loop reentrancy
> > > - Proper memory management with SDL-specific allocation/deallocation
> > > - Self-update prevention to avoid clipboard ownership conflicts
> > > - UTF-8 string validation and proper null termination
> > >
> > > ## Testing and Validation:
> > >
> > > Extensive testing on macOS with Linux guest demonstrates:
> > > - Reliable bidirectional clipboard operation
> > > - No performance impact or stability regressions
> > > - Clean coexistence with system clipboard managers
> > > - Proper handling of various text encodings and formats
> > >
> > > This implementation addresses the SDL2 backend's clipboard gap while =
incorporating
> > > lessons learned from both the GTK clipboard implementation and the co=
mmunity
> > > feedback from the original RFC.
> > >
> > > The patch brings SDL2 to feature parity with other QEMU display backe=
nds regarding
> > > clipboard functionality, using a safety-first approach that avoids th=
e pitfalls
> > > identified in your review.
> > >
> > > Would appreciate your thoughts on this refined approach. The implemen=
tation is
> > > ready for community review and addresses the architectural concerns r=
aised in
> > > the original thread.
> > >
> > > Best regards,
> > > startergo
> > >
> > > ---
> > >
> > > [Complete patch follows below]
> >
> >
> > Please send a properly formatted git patch:
> > https://www.qemu.org/docs/master/devel/submitting-a-patch.html#do-not-s=
end-as-an-attachment
> >
> > > From: startergo startergo@protonmail.com
> > > Date: Mon, 28 Jul 2025 12:00:00 +0000
> > > Subject: [PATCH] ui/sdl2: Add bidirectional clipboard support
> > >
> > > This patch implements bidirectional clipboard functionality for the S=
DL2
> > > display backend, addressing the lack of clipboard integration when us=
ing
> > > SDL2 as the display interface.
> > >
> > > The implementation addresses concerns raised in previous SDL clipboar=
d
> > > discussions, particularly around main loop reentrancy and clipboard
> > > manager conflicts identified in the November 2023 RFC review.Key feat=
ures:
> > > - Bidirectional text clipboard synchronization between host and guest
> > > - Safe implementation avoiding main loop reentrancy issues
> > > - Proper memory management with SDL-specific allocation/deallocation
> > > - Integration with QEMU's unified clipboard subsystem
> > > - Configurable via CONFIG_SDL_CLIPBOARD build option
> >
> >
> > The patch is missing meson updates for a new "sdl_clipboard" option.
> >
> > It would not be required if you can avoid the main loop reentrancy.
> > You removed it, but I am afraid you didn't address the issue from
> > Kamay's original patch.
> >
> > > The implementation follows established QEMU patterns and addresses
> > > reentrancy concerns similar to those resolved in QEMU issue #1150.
> > >
> > > Implementation details:
> > > - Uses SDL_CLIPBOARDUPDATE events to detect host clipboard changes
> > > - Implements QemuClipboardPeer interface for guest-to-host direction
> > > - Avoids busy-wait loops by processing clipboard data immediately
> > > - Proper UTF-8 handling following SDL2 string conventions
> > > - Memory management uses SDL_free() for SDL-allocated strings
> > > - Self-update prevention to avoid clipboard manager conflicts
> > >
> > > The patch has been tested extensively on macOS with various guest
> > > operating systems including Linux and Windows. Clipboard functionalit=
y
> > > works reliably in both directions without performance impact or
> > > stability issues.
> > >
> > > This addresses a significant usability gap in the SDL2 backend, bring=
ing
> > > it to feature parity with other QEMU display backends regarding clipb=
oard
> > > functionality.
> > >
> > > Signed-off-by: startergo startergo@protonmail.com
> > > ---
> > > ui/meson.build | 1 +
> > > include/ui/sdl2.h | 11 +++
> > > ui/clipboard.c | 104 ++++++++++++++++++++++++++++++++++++++++++
> >
> >
> > name it sdl2-clipboard.c
> >
> > > ui/sdl2.c | 8 ++++
> > > 4 files changed, 124 insertions(+)
> > > create mode 100644 ui/clipboard.c
> > >
> > > diff --git a/ui/meson.build b/ui/meson.build
> > > index 92e7e61219..c5e7880ca5 100644
> > > --- a/ui/meson.build
> > > +++ b/ui/meson.build
> > > @@ -59,6 +59,7 @@ if sdl.found()
> > > softmmu_ss.add(when: 'CONFIG_SDL', if_true: files(
> > > 'sdl2-2d.c',
> > > 'sdl2-gl.c',
> > > + 'clipboard.c',
> >
> >
> > make it conditional on have_sdl_clipboard option
> >
> > > 'sdl2-input.c',
> > > 'sdl2.c'
> > > ))
> > > diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
> > > index 1624ad6938..28a17e7b53 100644
> > > --- a/include/ui/sdl2.h
> > > +++ b/include/ui/sdl2.h
> > > @@ -7,6 +7,10 @@
> > > # include <SDL.h>
> > > # include <SDL_syswm.h>
> > >
> > > +#ifdef CONFIG_SDL_CLIPBOARD
> > > +#include "ui/clipboard.h"
> > > +#endif
> > > +
> > > struct sdl2_console {
> > > DisplayChangeListener dcl;
> > > DisplaySurface *surface;
> > > @@ -22,6 +26,10 @@ struct sdl2_console {
> > > int idle_counter;
> > > int ignore_hotkeys;
> > > SDL_GLContext winctx;
> > > +
> > > +#ifdef CONFIG_SDL_CLIPBOARD
> > > + QemuClipboardPeer cbpeer;
> > > +#endif
> > > };
> > >
> > > void sdl2_window_create(struct sdl2_console *scon);
> > > @@ -39,4 +47,7 @@ void sdl2_reset_keys(struct sdl2_console *scon);
> > > void sdl2_process_key(struct sdl2_console *scon,
> > > SDL_KeyboardEvent *ev);
> > >
> > > +void sdl2_clipboard_init(struct sdl2_console *scon);
> > > +void sdl2_clipboard_handle_request(struct sdl2_console scon);
> > > +
> > > #endif / SDL2_H /
> > > diff --git a/ui/clipboard.c b/ui/clipboard.c
> > > new file mode 100644
> > > index 0000000000..98fa9f1c2a
> > > --- /dev/null
> > > +++ b/ui/clipboard.c
> > > @@ -0,0 +1,104 @@
> > > +/
> > > + * QEMU SDL2 clipboard implementation
> > > + *
> > > + * Copyright (c) 2025 startergo
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person obtai=
ning a copy
> > > + * of this software and associated documentation files (the "Softwar=
e"), to deal
> > > + * in the Software without restriction, including without limitation=
 the rights
> > > + * to use, copy, modify, merge, publish, distribute, sublicense, and=
/or sell
> > > + * copies of the Software, and to permit persons to whom the Softwar=
e is
> > > + * furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice shall be in=
cluded in
> > > + * all copies or substantial portions of the Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, E=
XPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTA=
BILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT=
 SHALL
> > > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR OTHER
> > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, A=
RISING FROM,
> > > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEA=
LINGS IN
> > > + * THE SOFTWARE.
> > > + */
> >
> >
> > QEMU code has SPDX identifiers and is GPL2+:
> >
> > /*
> > * Copyright ...
> > *
> > * SPDX-License-Identifier: GPL-2.0-or-later
> > */
> >
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "ui/sdl2.h"
> > > +
> > > +#ifdef CONFIG_SDL_CLIPBOARD
> > > +
> > > +static void sdl2_clipboard_update(struct sdl2_console *scon,
> > > + QemuClipboardInfo info)
> > > +{
> > > + QemuClipboardType type =3D QEMU_CLIPBOARD_TYPE_TEXT;
> > > + g_autoptr(QemuClipboardData) data =3D NULL;
> > > +
> > > + / Prevent self-update loops /
> > > + if (info->owner =3D=3D &scon->cbpeer) {
> > > + return;
> > > + }
> > > +
> > > + / Only handle text clipboard for now /
> > > + if (!qemu_clipboard_info_has_type(info, type)) {
> > > + return;
> > > + }
> > > +
> > > + / Get clipboard data from QEMU */
> > > + data =3D qemu_clipboard_request(info, type);
> > > + if (!data || !data->data || data->size =3D=3D 0) {
> > > + return;
> > > + }
> >
> >
> > Here, Kamay's patch was waiting for the clipboard to be filled. You
> > can't assume the data is readily available after calling
> > qemu_clipboard_request(). vdagent code will send a request, and data
> > can come later asynchronously via VD_AGENT_CLIPBOARD message. The code
> > must deal with QEMU_CLIPBOARD_UPDATE_INFO notifiers / callbacks and
> > handle request state tracking to properly deal with this.
> >
> > > +
> > > + /*
> > > + * Ensure null termination for SDL clipboard.
> > > + * QEMU clipboard data may not be null-terminated.
> > > + */
> > > + g_autofree char *text =3D g_strndup((const char *)data->data, data-=
>size);
> >
> >
> > casting required here?
> >
> > > + if (text) {
> >
> >
> > text can't be NULL if data->data is non-NULL. If we want to handle the
> >
> > case anyway, we could have a trace or a warning
> >
> > > + SDL_SetClipboardText(text);
> > > + }
> > > +}
> > > +
> > > +static void sdl2_clipboard_notify(Notifier *notifier,
> > > + void *data)
> > > +{
> > > + QemuClipboardNotify *notify =3D data;
> > > + struct sdl2_console scon =3D
> > > + container_of(notifier, struct sdl2_console, cbpeer.notifier);
> > > +
> > > + switch (notify->type) {
> > > + case QEMU_CLIPBOARD_UPDATE_INFO:
> > > + sdl2_clipboard_update(scon, notify->info);
> > > + break;
> > > + case QEMU_CLIPBOARD_RESET_SERIAL:
> > > + / Nothing to do for reset */
> > > + break;
> > > + }
> > > +}
> > > +
> > > +static void sdl2_clipboard_request(QemuClipboardInfo *info,
> > > + QemuClipboardType type)
> > > +{
> > > + struct sdl2_console *scon =3D
> > > + container_of(info->owner, struct sdl2_console, cbpeer);
> > > + char *sdl_text =3D NULL;
> > > +
> > > + switch (type) {
> > > + case QEMU_CLIPBOARD_TYPE_TEXT:
> > > + if (!SDL_HasClipboardText()) {
> > > + return;
> > > + }
> > > +
> > > + sdl_text =3D SDL_GetClipboardText();
> > > + if (sdl_text && strlen(sdl_text) > 0) {
> >
> >
> > Interesting that SDL decided that empty string is for error reporting.
> >
> > Could you simplify the check with sdl_text[0] !=3D '\0' instead? Also
> > add a warning with SDL_GetError() if it's empty.
> >
> > > + /*
> > > + * SDL guarantees null-terminated UTF-8 strings.
> > > + * Pass length without null terminator as QEMU clipboard
> > > + * will handle null termination consistently.
> > > + /
> > > + qemu_clipboard_set_data(&scon->cbpeer, info, type,
> > > + strlen(sdl_text), sdl_text, true);
> > > + }
> > > +
> > > + / Always free SDL-allocated memory */
> > > + if (sdl_text) {
> >
> >
> > drop the condition, GetClipboardText() should not return NULL, and
> > SDL_free(NULL) is fine anyway.
> >
> > > + SDL_free(sdl_text);
> > > + }
> > > + break;
> > > + default:
> > > + break;
> > > + }
> > > +}
> > > +
> > > +void sdl2_clipboard_handle_request(struct sdl2_console *scon)
> > > +{
> > > + g_autoptr(QemuClipboardInfo) info =3D
> > > + qemu_clipboard_info_new(&scon->cbpeer,
> > > + QEMU_CLIPBOARD_SELECTION_CLIPBOARD);
> > > +
> > > + if (info) {
> >
> >
> > qemu_clipboard_info_new never returns NULL
> >
> > > + sdl2_clipboard_request(info, QEMU_CLIPBOARD_TYPE_TEXT);
> > > + }
> > > +}
> > > +
> > > +void sdl2_clipboard_init(struct sdl2_console scon)
> > > +{
> > > + scon->cbpeer.name =3D "sdl2";
> > > + scon->cbpeer.notifier.notify =3D sdl2_clipboard_notify;
> > > + scon->cbpeer.request =3D sdl2_clipboard_request;
> > > +
> > > + / Register the clipboard peer with QEMU /
> > > + qemu_clipboard_peer_register(&scon->cbpeer);
> > > +}
> > > +
> > > +#endif / CONFIG_SDL_CLIPBOARD */
> > > diff --git a/ui/sdl2.c b/ui/sdl2.c
> > > index 1a83c3b1bf..5678930d3c 100644
> > > --- a/ui/sdl2.c
> > > +++ b/ui/sdl2.c
> > > @@ -691,6 +691,11 @@ void sdl2_poll_events(struct sdl2_console *scon)
> > > case SDL_WINDOWEVENT:
> > > handle_windowevent(ev);
> > > break;
> > > +#ifdef CONFIG_SDL_CLIPBOARD
> > > + case SDL_CLIPBOARDUPDATE:
> > > + sdl2_clipboard_handle_request(scon);
> > > + break;
> > > +#endif
> > > default:
> > > break;
> > > }
> > > @@ -914,6 +919,9 @@ static void sdl2_display_init(DisplayState *ds, D=
isplayOptions *o)
> > > qemu_console_set_window_id(con, info.info.x11.window);
> > > #endif
> > > }
> > > +#ifdef CONFIG_SDL_CLIPBOARD
> > > + sdl2_clipboard_init(&sdl2_console[i]);
> > > +#endif
> > > }
> > >
> > > #ifdef CONFIG_SDL_IMAGE
> >
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau



--=20
Marc-Andr=C3=A9 Lureau

