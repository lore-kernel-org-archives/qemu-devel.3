Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C50CA0EC1
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 14:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk25B-0005Gg-GY; Thu, 07 Aug 2025 10:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uk259-0005Ec-EE
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:59:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uk254-00044o-If
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754578735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gpby0rC8lNziMlaNfX9P/YqbRp0NFUi4pHqdiXspYzM=;
 b=Fc6maBYewaVUB0Z+F2s/w9tFNGq5EfYkQtN/6lIDZpWVEUTXJcV02LVlRWAMlIfgAj3CFo
 BBboR1x7YBpksIc3UPFXx1pfjCmCGKhYkS2idgqG7/VxEMH12enAlsMy3QA1BJ4QMO88HU
 fboeitNTvfv3c73YDhZSFie4C0rwVP0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-qsY-RN92PXWaojVnOwydqA-1; Thu, 07 Aug 2025 10:58:53 -0400
X-MC-Unique: qsY-RN92PXWaojVnOwydqA-1
X-Mimecast-MFC-AGG-ID: qsY-RN92PXWaojVnOwydqA_1754578732
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-315af08594fso1434911a91.2
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 07:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754578731; x=1755183531;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gpby0rC8lNziMlaNfX9P/YqbRp0NFUi4pHqdiXspYzM=;
 b=lpq+YsnDjn4pQgAMUM7qimXQ1K4MUSTuF3yjDIKULAO7ckYGWqe31e/9mHgF077fui
 oxOPlp9AN+i1na30vuSA/7mrnJg1jVsbVCSyc7DPnodDxiigHxT6AHyDMHonrgCYaeWq
 AWp2pD0MJ4qHFGQ0DnsuIaU5aiGu6EDFx/4UNs32MGBdKKNWDa3gS6T/xF0+JJqLh3lc
 fMLBr8r7oYUXPNqUEZu/wgKIrujj9ADTYruA+cJgFhJPII15nDNUZciiil4oKWE52TSq
 2x+gq9fus/El3QyANDIg6/XDfermSuaENk1ua6/pCiWWZGNlND/zoYKq+sMtJHZyapHi
 OH1g==
X-Gm-Message-State: AOJu0YwBrnzTzsEWoQBu+9XrboBog6cQf8N6T2db7BLJPUqjfmNp13Xq
 V1mIQdhTtiE9N1z2JgIc6GDSL0FhMNQtIO0Y59TdYBHVuOxBc4lekSjwD7RS2OFgmpns2oLJ5XA
 ouIvojPZJKSS94jLJ9Zrc5Pe2gSESTPtNGP4p4QYf+68e94jf6VTiTBhh4RZQwKczZuRheUU1vF
 Mo+6m8rSTv67edWq7C5QXNCji9vja/lmdnuciXBSDnk0G3
X-Gm-Gg: ASbGncsLmryYxoP4alssDOstdP5oQstBtvnNF74rze5Ttfh+R+mGep4qXCSiAgMeGU0
 t5SfX4QJ8LBRkCMEl0NkOGT8M79auX8xftdmP5PweTAGfTeiyouhCQpnLyHK3pTA8+M/TIK4xrV
 7F/CHlYiDSVmOlNxF5A3Vbww==
X-Received: by 2002:a17:903:1b4f:b0:242:9bc6:63c4 with SMTP id
 d9443c01a7336-242a0b9d818mr76244095ad.55.1754578731159; 
 Thu, 07 Aug 2025 07:58:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEUK/EPvqMXglGpCr9ARE0w5ZcjXh0zLPcjpdi/Kx1xtdDU8yL96pAmAgj82HHZVO1ybvMcJ+KXsWExyUikkI=
X-Received: by 2002:a17:903:1b4f:b0:242:9bc6:63c4 with SMTP id
 d9443c01a7336-242a0b9d818mr76243855ad.55.1754578730618; Thu, 07 Aug 2025
 07:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250807144822.35251-1-startergo@protonmail.com>
In-Reply-To: <20250807144822.35251-1-startergo@protonmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 7 Aug 2025 18:58:38 +0400
X-Gm-Features: Ac12FXyOeyRonZEX6lT2JxA-Ce4H9OANMrNpKEc_V8LrzTbsNb2E5xlZ-2LG2d8
Message-ID: <CAMxuvaxmzVhjOu-G8ejQr4k-rE6B=VZwBHZzke_rOF23KyEAjg@mail.gmail.com>
Subject: Re: [PATCH] ui/sdl2: Add SDL clipboard support with screen lock
 handling
To: startergo <startergo@protonmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f82864063bc7b123"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000f82864063bc7b123
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Aug 7, 2025 at 6:49=E2=80=AFPM startergo <startergo@protonmail.com>=
 wrote:

> This patch implements SDL clipboard integration for QEMU's SDL2 UI backen=
d,
> specifically addressing the issue where clipboard functionality becomes
> unreliable during host screen lock/unlock scenarios.
>
> The implementation provides:
> - Bidirectional clipboard synchronization between guest and host
> - Robust screen lock/unlock handling to prevent clipboard conflicts
> - Asynchronous clipboard request processing
> - Proper resource cleanup and error handling
>
> This addresses a common usability issue where copy/paste functionality
> stops working after the host screen is locked and unlocked, particularly
> noticeable on macOS systems.
>
> The patch adds a new build option --enable-sdl-clipboard (enabled by
> default)
> to allow users to disable the feature if needed.
>
> Tested on QEMU 10.0.0 and master branch, passes checkpatch with zero
> errors.
>

There are many things you didn't address since the last review:
https://lore.kernel.org/qemu-devel/CAJ+F1CJyGmYhBoTKg_hWibAQfL0f9-1CDWxJnQV=
BjaS_iXExeg@mail.gmail.com/

Please
- discuss the review on the ML if it's not clear or if they are not
appropriate
- version your patch
- keep a changelog of the changes

thanks


>
> Signed-off-by: startergo <startergo@protonmail.com>
> ---
>  include/ui/sdl2.h   |  15 ++++
>  meson.build         |   3 +
>  meson_options.txt   |   2 +
>  ui/meson.build      |   3 +
>  ui/sdl2-clipboard.c | 208 ++++++++++++++++++++++++++++++++++++++++++++
>  ui/sdl2.c           |  15 ++++
>  6 files changed, 246 insertions(+)
>  create mode 100644 ui/sdl2-clipboard.c
>
> diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
> index dbe6e3d97..e73f83259 100644
> --- a/include/ui/sdl2.h
> +++ b/include/ui/sdl2.h
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
> @@ -45,6 +49,11 @@ struct sdl2_console {
>      bool gui_keysym;
>      SDL_GLContext winctx;
>      QKbdState *kbd;
> +#ifdef CONFIG_SDL_CLIPBOARD
> +    QemuClipboardPeer cbpeer;
> +    bool clipboard_active;
> +    uint32_t last_focus_time;
> +#endif
>  #ifdef CONFIG_OPENGL
>      QemuGLShader *gls;
>      egl_fb guest_fb;
> @@ -97,4 +106,10 @@ void sdl2_gl_scanout_texture(DisplayChangeListener
> *dcl,
>  void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
>                             uint32_t x, uint32_t y, uint32_t w, uint32_t
> h);
>
> +#ifdef CONFIG_SDL_CLIPBOARD
> +void sdl2_clipboard_init(struct sdl2_console *scon);
> +void sdl2_clipboard_handle_focus_change(struct sdl2_console *scon, bool
> gained_focus);
> +void sdl2_clipboard_handle_request(struct sdl2_console *scon);
> +#endif
> +
>  #endif /* SDL2_H */
> diff --git a/meson.build b/meson.build
> index 41f68d380..4a37df966 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1596,6 +1596,8 @@ else
>    sdl_image =3D not_found
>  endif
>
> +have_sdl_clipboard =3D sdl.found() and get_option('sdl_clipboard')
> +
>  rbd =3D not_found
>  if not get_option('rbd').auto() or have_block
>    librados =3D cc.find_library('rados', required: get_option('rbd'))
> @@ -2511,6 +2513,7 @@ config_host_data.set('CONFIG_RELOCATABLE',
> get_option('relocatable'))
>  config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
>  config_host_data.set('CONFIG_SDL', sdl.found())
>  config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
> +config_host_data.set('CONFIG_SDL_CLIPBOARD', have_sdl_clipboard)
>  config_host_data.set('CONFIG_SECCOMP', seccomp.found())
>  if seccomp.found()
>    config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
> diff --git a/meson_options.txt b/meson_options.txt
> index 59d973bca..be2cba3a3 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -212,6 +212,8 @@ option('sdl', type : 'feature', value : 'auto',
>         description: 'SDL user interface')
>  option('sdl_image', type : 'feature', value : 'auto',
>         description: 'SDL Image support for icons')
> +option('sdl_clipboard', type : 'boolean', value : true,
> +       description: 'SDL clipboard support')
>  option('seccomp', type : 'feature', value : 'auto',
>         description: 'seccomp support')
>  option('smartcard', type : 'feature', value : 'auto',
> diff --git a/ui/meson.build b/ui/meson.build
> index 35fb04cad..6d1bf3477 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -126,6 +126,9 @@ if sdl.found()
>      'sdl2-input.c',
>      'sdl2.c',
>    ))
> +  if have_sdl_clipboard
> +    sdl_ss.add(files('sdl2-clipboard.c'))
> +  endif
>    sdl_ss.add(when: opengl, if_true: files('sdl2-gl.c'))
>    sdl_ss.add(when: x11, if_true: files('x_keymap.c'))
>    ui_modules +=3D {'sdl' : sdl_ss}
> diff --git a/ui/sdl2-clipboard.c b/ui/sdl2-clipboard.c
> new file mode 100644
> index 000000000..6cc0fd79c
> --- /dev/null
> +++ b/ui/sdl2-clipboard.c
> @@ -0,0 +1,208 @@
> +/*
> + * SDL UI -- clipboard support with screen lock handling
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
> +    uint32_t timestamp;
> +} SDLClipboardRequest;
> +
> +static SDLClipboardRequest *pending_request;
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
> +static void sdl2_clipboard_reset_state(struct sdl2_console *scon)
> +{
> +    /* Clear any pending requests when clipboard state is reset */
> +    sdl2_clipboard_clear_pending();
> +
> +    /* Force a fresh clipboard check after reconnection */
> +    if (scon->clipboard_active) {
> +        scon->last_focus_time =3D SDL_GetTicks();
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
> +    /* Skip processing if clipboard is not active (e.g., during screen
> lock) */
> +    if (!scon->clipboard_active) {
> +        return;
> +    }
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
)
> {
> +                return;
> +            }
> +
> +            /* Check if this is completion of our pending request */
> +            if (pending_request && pending_request->info =3D=3D notify->=
info
> &&
> +                pending_request->type =3D=3D QEMU_CLIPBOARD_TYPE_TEXT) {
> +                sdl2_clipboard_clear_pending();
> +            }
> +
> +            /* Check if data is available, request asynchronously if not
> */
> +            if (!notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].data) {
> +                if (!pending_request) {
> +                    pending_request =3D g_new0(SDLClipboardRequest, 1);
> +                    pending_request->scon =3D scon;
> +                    pending_request->info =3D
> +                        qemu_clipboard_info_ref(notify->info);
> +                    pending_request->type =3D QEMU_CLIPBOARD_TYPE_TEXT;
> +                    pending_request->timestamp =3D SDL_GetTicks();
> +                    qemu_clipboard_request(notify->info,
> +                                           QEMU_CLIPBOARD_TYPE_TEXT);
> +                }
> +                return;
> +            }
> +
> +            /* Process available data */
> +            text_size =3D
> notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].size;
> +            if (text_size =3D=3D 0) {
> +                return;
> +            }
> +
> +            text_data =3D (const char *)
> +                notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].data;
> +
> +            /* Ensure null termination for SDL clipboard */
> +            g_autofree char *text =3D g_strndup(text_data, text_size);
> +            if (text && text[0] !=3D '\0') {
> +                if (SDL_SetClipboardText(text) < 0) {
> +                    qemu_log_mask(LOG_GUEST_ERROR,
> +                                  "SDL clipboard: Failed to set clipboar=
d
> text: %s\n",
> +                                  SDL_GetError());
> +                }
> +            } else if (!text) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "SDL clipboard: Failed to allocate memory
> for clipboard text\n");
> +            }
> +            break;
> +        }
> +    case QEMU_CLIPBOARD_RESET_SERIAL:
> +        sdl2_clipboard_reset_state(scon);
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
> +    scon->clipboard_active =3D true;
> +    scon->last_focus_time =3D SDL_GetTicks();
> +
> +    qemu_clipboard_peer_register(&scon->cbpeer);
> +}
> +
> +void sdl2_clipboard_handle_focus_change(struct sdl2_console *scon, bool
> gained_focus)
> +{
> +    uint32_t current_time =3D SDL_GetTicks();
> +
> +    if (gained_focus) {
> +        /* Reactivate clipboard after regaining focus */
> +        scon->clipboard_active =3D true;
> +        scon->last_focus_time =3D current_time;
> +
> +        /* Clear any stale pending requests */
> +        sdl2_clipboard_clear_pending();
> +
> +        /* Force a fresh clipboard sync after focus is regained */
> +        sdl2_clipboard_handle_request(scon);
> +    } else {
> +        /* Deactivate clipboard when losing focus to prevent conflicts *=
/
> +        scon->clipboard_active =3D false;
> +        sdl2_clipboard_clear_pending();
> +    }
> +}
> +
> +void sdl2_clipboard_handle_request(struct sdl2_console *scon)
> +{
> +    g_autofree char *text =3D NULL;
> +    QemuClipboardInfo *info;
> +
> +    /* Skip if clipboard is not active */
> +    if (!scon->clipboard_active) {
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
> +    if (text[0] =3D=3D '\0') {
> +        return; /* Ignore empty clipboard */
> +    }
> +
> +    info =3D qemu_clipboard_info_new(&scon->cbpeer,
> +                                   QEMU_CLIPBOARD_SELECTION_CLIPBOARD);
> +    qemu_clipboard_set_data(&scon->cbpeer, info, QEMU_CLIPBOARD_TYPE_TEX=
T,
> +                            strlen(text), text, true);
> +    qemu_clipboard_info_unref(info);
> +}
> +
> +#endif /* CONFIG_SDL_CLIPBOARD */
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index cda4293a5..d89ac16dd 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -606,11 +606,17 @@ static void handle_windowevent(SDL_Event *ev)
>           * key is released.
>           */
>          scon->ignore_hotkeys =3D get_mod_state();
> +#ifdef CONFIG_SDL_CLIPBOARD
> +        sdl2_clipboard_handle_focus_change(scon, true);
> +#endif
>          break;
>      case SDL_WINDOWEVENT_FOCUS_LOST:
>          if (gui_grab && !gui_fullscreen) {
>              sdl_grab_end(scon);
>          }
> +#ifdef CONFIG_SDL_CLIPBOARD
> +        sdl2_clipboard_handle_focus_change(scon, false);
> +#endif
>          break;
>      case SDL_WINDOWEVENT_RESTORED:
>          update_displaychangelistener(&scon->dcl,
> GUI_REFRESH_INTERVAL_DEFAULT);
> @@ -691,6 +697,11 @@ void sdl2_poll_events(struct sdl2_console *scon)
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
> @@ -901,6 +912,10 @@ static void sdl2_display_init(DisplayState *ds,
> DisplayOptions *o)
>          }
>          register_displaychangelistener(&sdl2_console[i].dcl);
>
> +#ifdef CONFIG_SDL_CLIPBOARD
> +        sdl2_clipboard_init(&sdl2_console[i]);
> +#endif
> +
>  #if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)
>          if (SDL_GetWindowWMInfo(sdl2_console[i].real_window, &info)) {
>  #if defined(SDL_VIDEO_DRIVER_WINDOWS)
> --
> 2.50.1
>
>
>

--000000000000f82864063bc7b123
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 7, 20=
25 at 6:49=E2=80=AFPM startergo &lt;<a href=3D"mailto:startergo@protonmail.=
com">startergo@protonmail.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">This patch implements SDL clipboard integratio=
n for QEMU&#39;s SDL2 UI backend,<br>
specifically addressing the issue where clipboard functionality becomes<br>
unreliable during host screen lock/unlock scenarios.<br>
<br>
The implementation provides:<br>
- Bidirectional clipboard synchronization between guest and host<br>
- Robust screen lock/unlock handling to prevent clipboard conflicts=C2=A0 <=
br>
- Asynchronous clipboard request processing<br>
- Proper resource cleanup and error handling<br>
<br>
This addresses a common usability issue where copy/paste functionality<br>
stops working after the host screen is locked and unlocked, particularly<br=
>
noticeable on macOS systems.<br>
<br>
The patch adds a new build option --enable-sdl-clipboard (enabled by defaul=
t)<br>
to allow users to disable the feature if needed.<br>
<br>
Tested on QEMU 10.0.0 and master branch, passes checkpatch with zero errors=
.<br></blockquote><div><br></div><div>There are many things you didn&#39;t =
address since the last review:</div><div><a href=3D"https://lore.kernel.org=
/qemu-devel/CAJ+F1CJyGmYhBoTKg_hWibAQfL0f9-1CDWxJnQVBjaS_iXExeg@mail.gmail.=
com/">https://lore.kernel.org/qemu-devel/CAJ+F1CJyGmYhBoTKg_hWibAQfL0f9-1CD=
WxJnQVBjaS_iXExeg@mail.gmail.com/</a></div><div><br></div><div>Please=C2=A0=
</div><div>- discuss the review on the ML if it&#39;s not clear or if they =
are not appropriate</div><div>- version your patch</div><div>- keep a chang=
elog of the changes</div><div><br></div><div>thanks</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: startergo &lt;<a href=3D"mailto:startergo@protonmail.com" ta=
rget=3D"_blank">startergo@protonmail.com</a>&gt;<br>
---<br>
=C2=A0include/ui/sdl2.h=C2=A0 =C2=A0|=C2=A0 15 ++++<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
=C2=A0meson_options.txt=C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A0ui/meson.build=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
=C2=A0ui/sdl2-clipboard.c | 208 +++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0ui/sdl2.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 15 ++++<br>
=C2=A06 files changed, 246 insertions(+)<br>
=C2=A0create mode 100644 ui/sdl2-clipboard.c<br>
<br>
diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h<br>
index dbe6e3d97..e73f83259 100644<br>
--- a/include/ui/sdl2.h<br>
+++ b/include/ui/sdl2.h<br>
@@ -21,6 +21,10 @@<br>
=C2=A0# include &lt;SDL_image.h&gt;<br>
=C2=A0#endif<br>
<br>
+#ifdef CONFIG_SDL_CLIPBOARD<br>
+#include &quot;ui/clipboard.h&quot;<br>
+#endif<br>
+<br>
=C2=A0#include &quot;ui/kbd-state.h&quot;<br>
=C2=A0#ifdef CONFIG_OPENGL<br>
=C2=A0# include &quot;ui/egl-helpers.h&quot;<br>
@@ -45,6 +49,11 @@ struct sdl2_console {<br>
=C2=A0 =C2=A0 =C2=A0bool gui_keysym;<br>
=C2=A0 =C2=A0 =C2=A0SDL_GLContext winctx;<br>
=C2=A0 =C2=A0 =C2=A0QKbdState *kbd;<br>
+#ifdef CONFIG_SDL_CLIPBOARD<br>
+=C2=A0 =C2=A0 QemuClipboardPeer cbpeer;<br>
+=C2=A0 =C2=A0 bool clipboard_active;<br>
+=C2=A0 =C2=A0 uint32_t last_focus_time;<br>
+#endif<br>
=C2=A0#ifdef CONFIG_OPENGL<br>
=C2=A0 =C2=A0 =C2=A0QemuGLShader *gls;<br>
=C2=A0 =C2=A0 =C2=A0egl_fb guest_fb;<br>
@@ -97,4 +106,10 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl=
,<br>
=C2=A0void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t x, uint32_t y, uint32_t w, uint32_t h);<b=
r>
<br>
+#ifdef CONFIG_SDL_CLIPBOARD<br>
+void sdl2_clipboard_init(struct sdl2_console *scon);<br>
+void sdl2_clipboard_handle_focus_change(struct sdl2_console *scon, bool ga=
ined_focus);<br>
+void sdl2_clipboard_handle_request(struct sdl2_console *scon);<br>
+#endif<br>
+<br>
=C2=A0#endif /* SDL2_H */<br>
diff --git a/meson.build b/meson.build<br>
index 41f68d380..4a37df966 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -1596,6 +1596,8 @@ else<br>
=C2=A0 =C2=A0sdl_image =3D not_found<br>
=C2=A0endif<br>
<br>
+have_sdl_clipboard =3D sdl.found() and get_option(&#39;sdl_clipboard&#39;)=
<br>
+<br>
=C2=A0rbd =3D not_found<br>
=C2=A0if not get_option(&#39;rbd&#39;).auto() or have_block<br>
=C2=A0 =C2=A0librados =3D cc.find_library(&#39;rados&#39;, required: get_op=
tion(&#39;rbd&#39;))<br>
@@ -2511,6 +2513,7 @@ config_host_data.set(&#39;CONFIG_RELOCATABLE&#39;, ge=
t_option(&#39;relocatable&#39;))<br>
=C2=A0config_host_data.set(&#39;CONFIG_SAFESTACK&#39;, get_option(&#39;safe=
_stack&#39;))<br>
=C2=A0config_host_data.set(&#39;CONFIG_SDL&#39;, sdl.found())<br>
=C2=A0config_host_data.set(&#39;CONFIG_SDL_IMAGE&#39;, sdl_image.found())<b=
r>
+config_host_data.set(&#39;CONFIG_SDL_CLIPBOARD&#39;, have_sdl_clipboard)<b=
r>
=C2=A0config_host_data.set(&#39;CONFIG_SECCOMP&#39;, seccomp.found())<br>
=C2=A0if seccomp.found()<br>
=C2=A0 =C2=A0config_host_data.set(&#39;CONFIG_SECCOMP_SYSRAWRC&#39;, seccom=
p_has_sysrawrc)<br>
diff --git a/meson_options.txt b/meson_options.txt<br>
index 59d973bca..be2cba3a3 100644<br>
--- a/meson_options.txt<br>
+++ b/meson_options.txt<br>
@@ -212,6 +212,8 @@ option(&#39;sdl&#39;, type : &#39;feature&#39;, value :=
 &#39;auto&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;SDL user interface&#39;)<br>
=C2=A0option(&#39;sdl_image&#39;, type : &#39;feature&#39;, value : &#39;au=
to&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;SDL Image support for icons&#=
39;)<br>
+option(&#39;sdl_clipboard&#39;, type : &#39;boolean&#39;, value : true,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;SDL clipboard support&#39;)<b=
r>
=C2=A0option(&#39;seccomp&#39;, type : &#39;feature&#39;, value : &#39;auto=
&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;seccomp support&#39;)<br>
=C2=A0option(&#39;smartcard&#39;, type : &#39;feature&#39;, value : &#39;au=
to&#39;,<br>
diff --git a/ui/meson.build b/ui/meson.build<br>
index 35fb04cad..6d1bf3477 100644<br>
--- a/ui/meson.build<br>
+++ b/ui/meson.build<br>
@@ -126,6 +126,9 @@ if sdl.found()<br>
=C2=A0 =C2=A0 =C2=A0&#39;sdl2-input.c&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;sdl2.c&#39;,<br>
=C2=A0 =C2=A0))<br>
+=C2=A0 if have_sdl_clipboard<br>
+=C2=A0 =C2=A0 sdl_ss.add(files(&#39;sdl2-clipboard.c&#39;))<br>
+=C2=A0 endif<br>
=C2=A0 =C2=A0sdl_ss.add(when: opengl, if_true: files(&#39;sdl2-gl.c&#39;))<=
br>
=C2=A0 =C2=A0sdl_ss.add(when: x11, if_true: files(&#39;x_keymap.c&#39;))<br=
>
=C2=A0 =C2=A0ui_modules +=3D {&#39;sdl&#39; : sdl_ss}<br>
diff --git a/ui/sdl2-clipboard.c b/ui/sdl2-clipboard.c<br>
new file mode 100644<br>
index 000000000..6cc0fd79c<br>
--- /dev/null<br>
+++ b/ui/sdl2-clipboard.c<br>
@@ -0,0 +1,208 @@<br>
+/*<br>
+ * SDL UI -- clipboard support with screen lock handling<br>
+ *<br>
+ * Copyright (C) 2023 Kamay Xutax &lt;<a href=3D"mailto:admin@xutaxkamay.c=
om" target=3D"_blank">admin@xutaxkamay.com</a>&gt;<br>
+ * Copyright (C) 2025 startergo &lt;<a href=3D"mailto:startergo@protonmail=
.com" target=3D"_blank">startergo@protonmail.com</a>&gt;<br>
+ *<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;ui/console.h&quot;<br>
+#include &quot;ui/clipboard.h&quot;<br>
+#include &quot;ui/sdl2.h&quot;<br>
+#include &quot;qemu/log.h&quot;<br>
+<br>
+#ifdef CONFIG_SDL_CLIPBOARD<br>
+<br>
+/* Track pending clipboard requests to handle async data */<br>
+typedef struct {<br>
+=C2=A0 =C2=A0 struct sdl2_console *scon;<br>
+=C2=A0 =C2=A0 QemuClipboardInfo *info;<br>
+=C2=A0 =C2=A0 QemuClipboardType type;<br>
+=C2=A0 =C2=A0 uint32_t timestamp;<br>
+} SDLClipboardRequest;<br>
+<br>
+static SDLClipboardRequest *pending_request;<br>
+<br>
+static void sdl2_clipboard_clear_pending(void)<br>
+{<br>
+=C2=A0 =C2=A0 if (pending_request) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pending_request-&gt;info) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_clipboard_info_unref(pendin=
g_request-&gt;info);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(pending_request);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pending_request =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void sdl2_clipboard_reset_state(struct sdl2_console *scon)<br>
+{<br>
+=C2=A0 =C2=A0 /* Clear any pending requests when clipboard state is reset =
*/<br>
+=C2=A0 =C2=A0 sdl2_clipboard_clear_pending();<br>
+<br>
+=C2=A0 =C2=A0 /* Force a fresh clipboard check after reconnection */<br>
+=C2=A0 =C2=A0 if (scon-&gt;clipboard_active) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scon-&gt;last_focus_time =3D SDL_GetTicks();<b=
r>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void sdl2_clipboard_notify(Notifier *notifier, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 QemuClipboardNotify *notify =3D data;<br>
+=C2=A0 =C2=A0 struct sdl2_console *scon =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 container_of(notifier, struct sdl2_console, cb=
peer.notifier);<br>
+=C2=A0 =C2=A0 bool self_update =3D notify-&gt;info-&gt;owner =3D=3D &amp;s=
con-&gt;cbpeer;<br>
+=C2=A0 =C2=A0 const char *text_data;<br>
+=C2=A0 =C2=A0 size_t text_size;<br>
+<br>
+=C2=A0 =C2=A0 /* Skip processing if clipboard is not active (e.g., during =
screen lock) */<br>
+=C2=A0 =C2=A0 if (!scon-&gt;clipboard_active) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 switch (notify-&gt;type) {<br>
+=C2=A0 =C2=A0 case QEMU_CLIPBOARD_UPDATE_INFO:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Skip self-updates to avoid cl=
ipboard manager conflicts */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (self_update) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!notify-&gt;info-&gt;types[Q=
EMU_CLIPBOARD_TYPE_TEXT].available) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if this is completion o=
f our pending request */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pending_request &amp;&amp; p=
ending_request-&gt;info =3D=3D notify-&gt;info &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pending_request-&g=
t;type =3D=3D QEMU_CLIPBOARD_TYPE_TEXT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sdl2_clipboard_cle=
ar_pending();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if data is available, r=
equest asynchronously if not */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!notify-&gt;info-&gt;types[Q=
EMU_CLIPBOARD_TYPE_TEXT].data) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pending_reque=
st) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pend=
ing_request =3D g_new0(SDLClipboardRequest, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pend=
ing_request-&gt;scon =3D scon;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pend=
ing_request-&gt;info =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 qemu_clipboard_info_ref(notify-&gt;info);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pend=
ing_request-&gt;type =3D QEMU_CLIPBOARD_TYPE_TEXT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pend=
ing_request-&gt;timestamp =3D SDL_GetTicks();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu=
_clipboard_request(notify-&gt;info,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0QEMU_CLIPBOARD_TYPE_TEXT);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Process available data */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 text_size =3D notify-&gt;info-&g=
t;types[QEMU_CLIPBOARD_TYPE_TEXT].size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (text_size =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 text_data =3D (const char *)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 notify-&gt;info-&g=
t;types[QEMU_CLIPBOARD_TYPE_TEXT].data;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Ensure null termination for S=
DL clipboard */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *text =3D g_strn=
dup(text_data, text_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (text &amp;&amp; text[0] !=3D=
 &#39;\0&#39;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (SDL_SetClipboa=
rdText(text) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu=
_log_mask(LOG_GUEST_ERROR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;SDL clipboard: Failed t=
o set clipboard text: %s\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SDL_GetError());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!text) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_=
GUEST_ERROR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;SDL clipboard: Failed to allocate mem=
ory for clipboard text\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 case QEMU_CLIPBOARD_RESET_SERIAL:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sdl2_clipboard_reset_state(scon);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void sdl2_clipboard_request(QemuClipboardInfo *info,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QemuClipboardType type)=
<br>
+{<br>
+=C2=A0 =C2=A0 g_autofree char *text =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 if (type !=3D QEMU_CLIPBOARD_TYPE_TEXT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 text =3D SDL_GetClipboardText();<br>
+=C2=A0 =C2=A0 if (!text) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;SDL clipboard: Failed to get clipboard text: %s\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SDL_GetError());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 qemu_clipboard_set_data(info-&gt;owner, info, type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 strlen(text), text, true);<br>
+}<br>
+<br>
+void sdl2_clipboard_init(struct sdl2_console *scon)<br>
+{<br>
+=C2=A0 =C2=A0 scon-&gt;<a href=3D"http://cbpeer.name" rel=3D"noreferrer" t=
arget=3D"_blank">cbpeer.name</a> =3D &quot;sdl2-clipboard&quot;;<br>
+=C2=A0 =C2=A0 scon-&gt;cbpeer.notifier.notify =3D sdl2_clipboard_notify;<b=
r>
+=C2=A0 =C2=A0 scon-&gt;cbpeer.request =3D sdl2_clipboard_request;<br>
+=C2=A0 =C2=A0 scon-&gt;clipboard_active =3D true;<br>
+=C2=A0 =C2=A0 scon-&gt;last_focus_time =3D SDL_GetTicks();<br>
+<br>
+=C2=A0 =C2=A0 qemu_clipboard_peer_register(&amp;scon-&gt;cbpeer);<br>
+}<br>
+<br>
+void sdl2_clipboard_handle_focus_change(struct sdl2_console *scon, bool ga=
ined_focus)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t current_time =3D SDL_GetTicks();<br>
+<br>
+=C2=A0 =C2=A0 if (gained_focus) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Reactivate clipboard after regaining focus =
*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scon-&gt;clipboard_active =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scon-&gt;last_focus_time =3D current_time;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Clear any stale pending requests */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sdl2_clipboard_clear_pending();<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Force a fresh clipboard sync after focus is=
 regained */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sdl2_clipboard_handle_request(scon);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Deactivate clipboard when losing focus to p=
revent conflicts */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scon-&gt;clipboard_active =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sdl2_clipboard_clear_pending();<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+void sdl2_clipboard_handle_request(struct sdl2_console *scon)<br>
+{<br>
+=C2=A0 =C2=A0 g_autofree char *text =3D NULL;<br>
+=C2=A0 =C2=A0 QemuClipboardInfo *info;<br>
+<br>
+=C2=A0 =C2=A0 /* Skip if clipboard is not active */<br>
+=C2=A0 =C2=A0 if (!scon-&gt;clipboard_active) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 text =3D SDL_GetClipboardText();<br>
+=C2=A0 =C2=A0 if (!text) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;SDL clipboard: Failed to get clipboard text: %s\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SDL_GetError());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (text[0] =3D=3D &#39;\0&#39;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return; /* Ignore empty clipboard */<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 info =3D qemu_clipboard_info_new(&amp;scon-&gt;cbpeer,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QEMU_CLIPBOARD_SELECTIO=
N_CLIPBOARD);<br>
+=C2=A0 =C2=A0 qemu_clipboard_set_data(&amp;scon-&gt;cbpeer, info, QEMU_CLI=
PBOARD_TYPE_TEXT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 strlen(text), text, true);<br>
+=C2=A0 =C2=A0 qemu_clipboard_info_unref(info);<br>
+}<br>
+<br>
+#endif /* CONFIG_SDL_CLIPBOARD */<br>
diff --git a/ui/sdl2.c b/ui/sdl2.c<br>
index cda4293a5..d89ac16dd 100644<br>
--- a/ui/sdl2.c<br>
+++ b/ui/sdl2.c<br>
@@ -606,11 +606,17 @@ static void handle_windowevent(SDL_Event *ev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * key is released.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0scon-&gt;ignore_hotkeys =3D get_mod_state=
();<br>
+#ifdef CONFIG_SDL_CLIPBOARD<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sdl2_clipboard_handle_focus_change(scon, true)=
;<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case SDL_WINDOWEVENT_FOCUS_LOST:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (gui_grab &amp;&amp; !gui_fullscreen) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sdl_grab_end(scon);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+#ifdef CONFIG_SDL_CLIPBOARD<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sdl2_clipboard_handle_focus_change(scon, false=
);<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case SDL_WINDOWEVENT_RESTORED:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0update_displaychangelistener(&amp;scon-&g=
t;dcl, GUI_REFRESH_INTERVAL_DEFAULT);<br>
@@ -691,6 +697,11 @@ void sdl2_poll_events(struct sdl2_console *scon)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case SDL_WINDOWEVENT:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0handle_windowevent(ev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+#ifdef CONFIG_SDL_CLIPBOARD<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case SDL_CLIPBOARDUPDATE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sdl2_clipboard_handle_request(sc=
on);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -901,6 +912,10 @@ static void sdl2_display_init(DisplayState *ds, Displa=
yOptions *o)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0register_displaychangelistener(&amp;sdl2_=
console[i].dcl);<br>
<br>
+#ifdef CONFIG_SDL_CLIPBOARD<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sdl2_clipboard_init(&amp;sdl2_console[i]);<br>
+#endif<br>
+<br>
=C2=A0#if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (SDL_GetWindowWMInfo(sdl2_console[i].r=
eal_window, &amp;info)) {<br>
=C2=A0#if defined(SDL_VIDEO_DRIVER_WINDOWS)<br>
-- <br>
2.50.1<br>
<br>
<br>
</blockquote></div></div>

--000000000000f82864063bc7b123--


