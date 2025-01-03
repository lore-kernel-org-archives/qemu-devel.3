Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DC3E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 13:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tThMq-00033M-3l; Fri, 03 Jan 2025 08:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1tThMi-00032C-7a
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 08:05:24 -0500
Received: from mailout07.t-online.de ([194.25.134.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1tThMg-0001HY-4T
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 08:05:23 -0500
Received: from fwd77.aul.t-online.de (fwd77.aul.t-online.de [10.223.144.103])
 by mailout07.t-online.de (Postfix) with SMTP id 0860B13D2;
 Fri,  3 Jan 2025 14:05:12 +0100 (CET)
Received: from [192.168.211.200] ([93.236.158.175]) by fwd77.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1tThMV-3YA7lJ0; Fri, 3 Jan 2025 14:05:11 +0100
Message-ID: <de0d9747-443c-406a-ab86-29422b35c935@t-online.de>
Date: Fri, 3 Jan 2025 14:05:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH v3] ui/sdl2: reenable the SDL2 Windows keyboard hook
 procedure
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alexander von Gluck IV <kallisti5@unixzen.com>
Cc: Bernhard Beschow <shentey@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Howard Spoelstra <hsp.cat7@gmail.com>, qemu-devel@nongnu.org
References: <20241231115950.6732-1-vr_qemu@t-online.de>
 <b1fb1999-8bfa-4238-b366-f31c4b1e0db8@linaro.org>
 <b89034c2-6b27-4e7b-bfc4-fe8cff7e9230@redhat.com>
Content-Language: en-US
In-Reply-To: <b89034c2-6b27-4e7b-bfc4-fe8cff7e9230@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1735909511-0D7F99D3-193DE919/0/0 CLEAN NORMAL
X-TOI-MSGID: a26749df-9636-4ff1-aa79-d3562557f9e8
Received-SPF: pass client-ip=194.25.134.83; envelope-from=vr_qemu@t-online.de;
 helo=mailout07.t-online.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 02.01.25 um 08:23 schrieb Thomas Huth:
> On 02/01/2025 08.06, Philippe Mathieu-Daudé wrote:
>> Hi Volker,
>>
>> On 31/12/24 12:59, Volker Rümelin wrote:
>>> Windows only:
>>>
>>> The libSDL2 Windows message loop needs the libSDL2 Windows low
>>> level keyboard hook procedure to grab the left and right Windows
>>> keys correctly. Reenable the SDL2 Windows keyboard hook procedure.
>>>
>>> Since SDL2 2.30.4 the SDL2 keyboard hook procedure also filters
>>> out the special left Control key event for every Alt Gr key event
>>> on keyboards with an international layout. This means the QEMU low
>>> level keyboard hook procedure is no longer needed. Remove the QEMU
>>> Windows keyboard hook procedure.
>>
>> Cc'ing Alexander & Thomas because I wonder if Haiku isn't using
>> an older version (SDL 2.0.8).
>> Should we require a minimum version in meson?
>
> AFAICS the hack was for Windows only, and this patch does not make use
> of any new SDL code that has been introduced by a later version, so
> for non-Windows platforms, it should still compile fine with older
> versions of SDL2, right? So I think this patch is fine.

This is correct. Version 2.30.4 or newer is only a runtime requirement
on Windows. Compilation with older SDL2 versions works fine. Only a few
keys may not work as expected if the Windows DLL loader loads an older
SDL2.dll version.

With best regards,
Volker

>
> By the way, "make vm-build-haiku.x86_64" does not work anymore ...
> likely because Haiku beta5 has been released a while ago, and we're
> still on beta4? Alexander, could you maybe provide a new image based
> on beta5 ?
>
>  Thomas
>
>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2139
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2323
>>> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>>> ---
>>>
>>> v2: Remove the QEMU lowlevel keyboard hook procedure from the
>>> SDL2 UI backend.
>>>
>>> v3: Rebase to current master because of a merge conflict.
>>>
>>>   ui/meson.build |  4 ----
>>>   ui/sdl2.c      | 26 --------------------------
>>>   2 files changed, 30 deletions(-)
>>>
>>> diff --git a/ui/meson.build b/ui/meson.build
>>> index 28c7381dd1..35fb04cadf 100644
>>> --- a/ui/meson.build
>>> +++ b/ui/meson.build
>>> @@ -120,10 +120,6 @@ if gtk.found()
>>>   endif
>>>   if sdl.found()
>>> -  if host_os == 'windows'
>>> -    system_ss.add(files('win32-kbd-hook.c'))
>>> -  endif
>>> -
>>>     sdl_ss = ss.source_set()
>>>     sdl_ss.add(sdl, sdl_image, pixman, glib, files(
>>>       'sdl2-2d.c',
>>> diff --git a/ui/sdl2.c b/ui/sdl2.c
>>> index 1fb72f67a6..2cb95a6b7c 100644
>>> --- a/ui/sdl2.c
>>> +++ b/ui/sdl2.c
>>> @@ -32,7 +32,6 @@
>>>   #include "system/runstate.h"
>>>   #include "system/runstate-action.h"
>>>   #include "system/system.h"
>>> -#include "ui/win32-kbd-hook.h"
>>>   #include "qemu/log.h"
>>>   static int sdl2_num_outputs;
>>> @@ -262,7 +261,6 @@ static void sdl_grab_start(struct sdl2_console
>>> *scon)
>>>       }
>>>       SDL_SetWindowGrab(scon->real_window, SDL_TRUE);
>>>       gui_grab = 1;
>>> -    win32_kbd_set_grab(true);
>>>       sdl_update_caption(scon);
>>>   }
>>> @@ -270,7 +268,6 @@ static void sdl_grab_end(struct sdl2_console *scon)
>>>   {
>>>       SDL_SetWindowGrab(scon->real_window, SDL_FALSE);
>>>       gui_grab = 0;
>>> -    win32_kbd_set_grab(false);
>>>       sdl_show_cursor(scon);
>>>       sdl_update_caption(scon);
>>>   }
>>> @@ -371,19 +368,6 @@ static int get_mod_state(void)
>>>       }
>>>   }
>>> -static void *sdl2_win32_get_hwnd(struct sdl2_console *scon)
>>> -{
>>> -#ifdef CONFIG_WIN32
>>> -    SDL_SysWMinfo info;
>>> -
>>> -    SDL_VERSION(&info.version);
>>> -    if (SDL_GetWindowWMInfo(scon->real_window, &info)) {
>>> -        return info.info.win.window;
>>> -    }
>>> -#endif
>>> -    return NULL;
>>> -}
>>> -
>>>   static void handle_keydown(SDL_Event *ev)
>>>   {
>>>       int win;
>>> @@ -608,10 +592,6 @@ static void handle_windowevent(SDL_Event *ev)
>>>           sdl2_redraw(scon);
>>>           break;
>>>       case SDL_WINDOWEVENT_FOCUS_GAINED:
>>> -        win32_kbd_set_grab(gui_grab);
>>> -        if (qemu_console_is_graphic(scon->dcl.con)) {
>>> -            win32_kbd_set_window(sdl2_win32_get_hwnd(scon));
>>> -        }
>>>           /* fall through */
>>>       case SDL_WINDOWEVENT_ENTER:
>>>           if (!gui_grab && (qemu_input_is_absolute(scon->dcl.con) ||
>>> absolute_enabled)) {
>>> @@ -627,9 +607,6 @@ static void handle_windowevent(SDL_Event *ev)
>>>           scon->ignore_hotkeys = get_mod_state();
>>>           break;
>>>       case SDL_WINDOWEVENT_FOCUS_LOST:
>>> -        if (qemu_console_is_graphic(scon->dcl.con)) {
>>> -            win32_kbd_set_window(NULL);
>>> -        }
>>>           if (gui_grab && !gui_fullscreen) {
>>>               sdl_grab_end(scon);
>>>           }
>>> @@ -869,10 +846,7 @@ static void sdl2_display_init(DisplayState *ds,
>>> DisplayOptions *o)
>>>   #ifdef SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR /* only
>>> available since SDL 2.0.8 */
>>>       SDL_SetHint(SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR, "0");
>>>   #endif
>>> -#ifndef CONFIG_WIN32
>>> -    /* QEMU uses its own low level keyboard hook procedure on
>>> Windows */
>>>       SDL_SetHint(SDL_HINT_GRAB_KEYBOARD, "1");
>>> -#endif
>>>   #ifdef SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED
>>>       SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
>>>   #endif
>>
>


