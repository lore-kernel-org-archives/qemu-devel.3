Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74384E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 13:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWxhO-0004BC-1V; Sun, 12 Jan 2025 08:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tWxhJ-00048j-JV
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 08:08:09 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tWxhG-0000B0-PY
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 08:08:08 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so539956766b.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 05:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736687285; x=1737292085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRnabKtxYVVFvyggSZpQh+Xi8gzcnAaC8Tq6sUY1olA=;
 b=VQwbIo/dvitE8nwMxVoj0KSNvvYvjTs88hipVweOuQOPNFL/S2HYW4q9LBYpl1N7zW
 CgVMHUgNi/fqksv5K3fgW+o0pqXxF6GECkH+wbdsP9Nqhtz5BSqfmpP0StRs/2n9c0aw
 yT/Ps7WhpvbJ9y07+eUsZiImty8mNvXxedsfgE2Nca1hm4Ki159V2hHhFYk6WLOdZone
 8m6FyOobkzZcLBciBr1bRFtHlE9YAZmnmzJZ6oqQBotSFCDEU80ZTtFAxqaQs2DXwQXQ
 bvsnQH44q6Xc1+wj6aXJGPplaOMQmJWhcDWwPg7+qWGwWEOHRg4QzVWK9vYPgrBtbA2/
 E+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736687285; x=1737292085;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fRnabKtxYVVFvyggSZpQh+Xi8gzcnAaC8Tq6sUY1olA=;
 b=vL1UTeZSOLgqtZS+JKJEiwu7RUDSM0ckfTz47GywaD8iNZsmPsrjhk6e6rxhc3WXFY
 7xlnthuJXSgQXOqNEnZ8X3UISYPqGquWvZv0alJzQdCWmD3qylyVqAzVOS/A/cas01Fx
 rTM5tUVnFhCe6DKNQhDkfOQ5gAqh9a0LlMcTAK7nTZ10ZuZVpsGU8qdm79jcmhPg0Fcx
 7E7iCVGVFVDQwUBGBVFQU/4K5TYT4ab4uiOyPAkwvTU2GHGhwpHMH0PeSI+Qwcnvs1Fg
 mG1hayzwGtlO2PMcMbvUljgUS++LUgn9mCXL9m3D6QRmibCG5J+Qwx43HZttYba/aQxd
 4qJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5M7x+MbhwAIW/13CjsEsY/lHv/fRTDRaQWYHDSBKsphxWnpOPfsT1OZ29jnF7QYUO4yuFX+MclsXN@nongnu.org
X-Gm-Message-State: AOJu0Yxow0/GqPf47IuqpqhE3/QvPA65z6QJ5bcbdYmux6fw7Lk3fJo7
 Rb6gRIcbWdHd64VDIAbLMEltTAZquTP/mlmE1V6H/3ZvemhbIMjs
X-Gm-Gg: ASbGnctYExVZzxtFpDod6INJmXgMIMr8dSJjZaeLa7oGQnComDeAFJ+VZQjZZZOQjJz
 bNdqMIlWLvWFMDhXgKb98AKkeaFxQDEqIOmOAVwC6USkqfNVRJ6PSTTsGrGn6y0DGLvoTMl0WMK
 yCnIKh3TK35qDON1pDxzt70BWnN98/v2hbTmm+uD5EOoupr7+7iuHgX/7P454SKRavnNaXJ1BDU
 QKx8X9cn9VoPZGnf7+/vX7B+I8htZuuWOqs+XIPOifHOlDRj/wHSHVq12ttEHLf9rA8OezkzCrA
 YSDAPKYuxphgtBxs+gaNznpxHoSUpSM=
X-Google-Smtp-Source: AGHT+IEH3UCFZroXycTREBJ1bf8TC6Dwby0FyU0FK1XnVXcc9v/t48HycIkAF83BqOvh3X7uPdvNJQ==
X-Received: by 2002:a17:907:9997:b0:ab2:c0c8:3841 with SMTP id
 a640c23a62f3a-ab2c0c83ac9mr1417348466b.4.1736687284619; 
 Sun, 12 Jan 2025 05:08:04 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-013-193-192.77.13.pool.telefonica.de.
 [77.13.193.192]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c91362a2sm368789266b.85.2025.01.12.05.08.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jan 2025 05:08:03 -0800 (PST)
Date: Sun, 12 Jan 2025 13:08:03 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
CC: Stefan Weil <sw@weilnetz.de>, Howard Spoelstra <hsp.cat7@gmail.com>,
 qemu-devel@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_ui/sdl2=3A_reenable_the?=
 =?US-ASCII?Q?_SDL2_Windows_keyboard_hook_procedure?=
In-Reply-To: <20241231115950.6732-1-vr_qemu@t-online.de>
References: <20241231115950.6732-1-vr_qemu@t-online.de>
Message-ID: <4D63C579-181F-47CE-8D0D-D3F4590BF9DC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 31=2E Dezember 2024 11:59:50 UTC schrieb "Volker R=C3=BCmelin" <vr_qemu=
@t-online=2Ede>:
>Windows only:
>
>The libSDL2 Windows message loop needs the libSDL2 Windows low
>level keyboard hook procedure to grab the left and right Windows
>keys correctly=2E Reenable the SDL2 Windows keyboard hook procedure=2E
>
>Since SDL2 2=2E30=2E4 the SDL2 keyboard hook procedure also filters
>out the special left Control key event for every Alt Gr key event
>on keyboards with an international layout=2E This means the QEMU low
>level keyboard hook procedure is no longer needed=2E Remove the QEMU
>Windows keyboard hook procedure=2E
>
>Resolves: https://gitlab=2Ecom/qemu-project/qemu/-/issues/2139
>Resolves: https://gitlab=2Ecom/qemu-project/qemu/-/issues/2323
>Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online=2Ede>

Resolving bugs strictly by removing code=2E Nice!

Issuing Meta+E opens a file manager in a guest running on Win11/msys2 host=
=2E Thus:

Tested-by: Bernhard Beschow <shentey@gmail=2Ecom>
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>---
>
>v2: Remove the QEMU lowlevel keyboard hook procedure from the
>SDL2 UI backend=2E
>
>v3: Rebase to current master because of a merge conflict=2E
>
> ui/meson=2Ebuild |  4 ----
> ui/sdl2=2Ec      | 26 --------------------------
> 2 files changed, 30 deletions(-)
>
>diff --git a/ui/meson=2Ebuild b/ui/meson=2Ebuild
>index 28c7381dd1=2E=2E35fb04cadf 100644
>--- a/ui/meson=2Ebuild
>+++ b/ui/meson=2Ebuild
>@@ -120,10 +120,6 @@ if gtk=2Efound()
> endif
>=20
> if sdl=2Efound()
>-  if host_os =3D=3D 'windows'
>-    system_ss=2Eadd(files('win32-kbd-hook=2Ec'))
>-  endif
>-
>   sdl_ss =3D ss=2Esource_set()
>   sdl_ss=2Eadd(sdl, sdl_image, pixman, glib, files(
>     'sdl2-2d=2Ec',
>diff --git a/ui/sdl2=2Ec b/ui/sdl2=2Ec
>index 1fb72f67a6=2E=2E2cb95a6b7c 100644
>--- a/ui/sdl2=2Ec
>+++ b/ui/sdl2=2Ec
>@@ -32,7 +32,6 @@
> #include "system/runstate=2Eh"
> #include "system/runstate-action=2Eh"
> #include "system/system=2Eh"
>-#include "ui/win32-kbd-hook=2Eh"
> #include "qemu/log=2Eh"
>=20
> static int sdl2_num_outputs;
>@@ -262,7 +261,6 @@ static void sdl_grab_start(struct sdl2_console *scon)
>     }
>     SDL_SetWindowGrab(scon->real_window, SDL_TRUE);
>     gui_grab =3D 1;
>-    win32_kbd_set_grab(true);
>     sdl_update_caption(scon);
> }
>=20
>@@ -270,7 +268,6 @@ static void sdl_grab_end(struct sdl2_console *scon)
> {
>     SDL_SetWindowGrab(scon->real_window, SDL_FALSE);
>     gui_grab =3D 0;
>-    win32_kbd_set_grab(false);
>     sdl_show_cursor(scon);
>     sdl_update_caption(scon);
> }
>@@ -371,19 +368,6 @@ static int get_mod_state(void)
>     }
> }
>=20
>-static void *sdl2_win32_get_hwnd(struct sdl2_console *scon)
>-{
>-#ifdef CONFIG_WIN32
>-    SDL_SysWMinfo info;
>-
>-    SDL_VERSION(&info=2Eversion);
>-    if (SDL_GetWindowWMInfo(scon->real_window, &info)) {
>-        return info=2Einfo=2Ewin=2Ewindow;
>-    }
>-#endif
>-    return NULL;
>-}
>-
> static void handle_keydown(SDL_Event *ev)
> {
>     int win;
>@@ -608,10 +592,6 @@ static void handle_windowevent(SDL_Event *ev)
>         sdl2_redraw(scon);
>         break;
>     case SDL_WINDOWEVENT_FOCUS_GAINED:
>-        win32_kbd_set_grab(gui_grab);
>-        if (qemu_console_is_graphic(scon->dcl=2Econ)) {
>-            win32_kbd_set_window(sdl2_win32_get_hwnd(scon));
>-        }
>         /* fall through */
>     case SDL_WINDOWEVENT_ENTER:
>         if (!gui_grab && (qemu_input_is_absolute(scon->dcl=2Econ) || abs=
olute_enabled)) {
>@@ -627,9 +607,6 @@ static void handle_windowevent(SDL_Event *ev)
>         scon->ignore_hotkeys =3D get_mod_state();
>         break;
>     case SDL_WINDOWEVENT_FOCUS_LOST:
>-        if (qemu_console_is_graphic(scon->dcl=2Econ)) {
>-            win32_kbd_set_window(NULL);
>-        }
>         if (gui_grab && !gui_fullscreen) {
>             sdl_grab_end(scon);
>         }
>@@ -869,10 +846,7 @@ static void sdl2_display_init(DisplayState *ds, Disp=
layOptions *o)
> #ifdef SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR /* only available sin=
ce SDL 2=2E0=2E8 */
>     SDL_SetHint(SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR, "0");
> #endif
>-#ifndef CONFIG_WIN32
>-    /* QEMU uses its own low level keyboard hook procedure on Windows */
>     SDL_SetHint(SDL_HINT_GRAB_KEYBOARD, "1");
>-#endif
> #ifdef SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED
>     SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
> #endif

