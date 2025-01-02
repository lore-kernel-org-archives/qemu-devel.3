Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AC6E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 07:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTFYj-0000Wb-DN; Thu, 02 Jan 2025 02:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTFYh-0000WC-PA
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 02:23:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTFYf-0004Is-Eo
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 02:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735802631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oKUN28nVoQW/ZD1ywLDHhv+aVXaDgktvbJ2m35EVR9E=;
 b=c53Kj9UrnZoccnNJ8SD2Sz04wXozIDwiXvOH4lTdnZfu0CNwQgDbhzFII/mTJUOoE87V7/
 9Lyfv260IqATi7N/z70X7pJGccyXO/X0Mu/CsSsoGt0l21+/nZFBDnrwa135MN8Dlpu4mz
 3pYRSDsvIztbXIDwsT+n5sWq102Y2to=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-GQhnp-7JMmO1G-f2LQPHeg-1; Thu, 02 Jan 2025 02:23:49 -0500
X-MC-Unique: GQhnp-7JMmO1G-f2LQPHeg-1
X-Mimecast-MFC-AGG-ID: GQhnp-7JMmO1G-f2LQPHeg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361f371908so77805765e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2025 23:23:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735802628; x=1736407428;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oKUN28nVoQW/ZD1ywLDHhv+aVXaDgktvbJ2m35EVR9E=;
 b=ClbFDrdcAIkDmfqcXxKto9GnDcLd3KBzo/d7kJ+R/VsHIqdj7LxUScQ8Yq9F5hjuLo
 JYLbHej2ZWeLglw6SoA6w3KZzX8S08CC5lvU6HEcuUu1iJR0DPpLCuEVIjtM2LdOmeLA
 O7377izz2uElW3fOaS0qT1Icyl8ba8LdjvgEAsbJfPzbYz7gKX19WUPkP4zFWPHC7kMd
 6Kf18iTd8vF4rOWY238Q7BEGHKi0oxSneLyOgxDmIztMhNhynGPY5gWMnRs9jpOwaJnY
 h7V00Rx8rLxD1Qd3tXg55BrEyUFTprnHvWnaB0kc1WSNfv5fS5OEVrtlA/kBDsMnAcTN
 gGeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUckQj6KUrrXXfYPxBOJ0IbWa5ji+hEKODGzOYfrZs8MwdQ9iCoNXJERPVjb45mEZjepJM6OkqrBIsl@nongnu.org
X-Gm-Message-State: AOJu0YzH2jwvqhSiBFA2TwLSS7ffs9rDpwqFLSAbYrf4BFiSrE3UY4gm
 PnIZAUlJVC/AhK+j+rbAhIx0NczYC+M8yMMntyRVVIhrADT5rdB2UwbmVL34MoqVXPCEWDhXyVc
 lpctMsBiKF5w0L0EKtowQj+4OnEn6d0T3SpTMsk59txEOhkve9oku
X-Gm-Gg: ASbGncsECJjLZ6iyWirdc6SgsLJKfy01VoKj13Q7ooHz3l1GuoEn4a6jZxOKACvntbC
 FBpyfFbtQ4R+CInQ1nJtX5B+pUStXS+W+iPKIuEreLDtBNAKhkqPigz8Rlnk7vV7Sj/oQ0rdxMy
 m1cQ42iIylY2JjiNddjxf8oDJHxwg1BhYdXBnNmnVSffZvMi6q36vreRkuVlN8ev1fp7sf/P5tW
 En3eYP6tMyxdQmbThlVzkMefbQ66P7b//vbINDU5RmXi/HN47i33g/WoRfc3x18ubmEnyGB14/8
 Z99nmC53eB3S
X-Received: by 2002:a05:600c:524c:b0:434:edcf:7474 with SMTP id
 5b1f17b1804b1-43668b93c61mr301336675e9.33.1735802628064; 
 Wed, 01 Jan 2025 23:23:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6m8BUXL7P+cnHNAJKD1/sSmP8O3L3Ngy0Qh26xpiVu8YhuadFS7HUQqDXFc6HFkPTpqXF5A==
X-Received: by 2002:a05:600c:524c:b0:434:edcf:7474 with SMTP id
 5b1f17b1804b1-43668b93c61mr301336515e9.33.1735802627664; 
 Wed, 01 Jan 2025 23:23:47 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-148.web.vodafone.de.
 [109.42.51.148]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828e7asm37000731f8f.21.2025.01.01.23.23.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jan 2025 23:23:46 -0800 (PST)
Message-ID: <b89034c2-6b27-4e7b-bfc4-fe8cff7e9230@redhat.com>
Date: Thu, 2 Jan 2025 08:23:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ui/sdl2: reenable the SDL2 Windows keyboard hook
 procedure
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alexander von Gluck IV <kallisti5@unixzen.com>
Cc: Bernhard Beschow <shentey@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Howard Spoelstra <hsp.cat7@gmail.com>, qemu-devel@nongnu.org
References: <20241231115950.6732-1-vr_qemu@t-online.de>
 <b1fb1999-8bfa-4238-b366-f31c4b1e0db8@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <b1fb1999-8bfa-4238-b366-f31c4b1e0db8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 02/01/2025 08.06, Philippe Mathieu-Daudé wrote:
> Hi Volker,
> 
> On 31/12/24 12:59, Volker Rümelin wrote:
>> Windows only:
>>
>> The libSDL2 Windows message loop needs the libSDL2 Windows low
>> level keyboard hook procedure to grab the left and right Windows
>> keys correctly. Reenable the SDL2 Windows keyboard hook procedure.
>>
>> Since SDL2 2.30.4 the SDL2 keyboard hook procedure also filters
>> out the special left Control key event for every Alt Gr key event
>> on keyboards with an international layout. This means the QEMU low
>> level keyboard hook procedure is no longer needed. Remove the QEMU
>> Windows keyboard hook procedure.
> 
> Cc'ing Alexander & Thomas because I wonder if Haiku isn't using
> an older version (SDL 2.0.8).
> Should we require a minimum version in meson?

AFAICS the hack was for Windows only, and this patch does not make use of 
any new SDL code that has been introduced by a later version, so for 
non-Windows platforms, it should still compile fine with older versions of 
SDL2, right? So I think this patch is fine.

By the way, "make vm-build-haiku.x86_64" does not work anymore ... likely 
because Haiku beta5 has been released a while ago, and we're still on beta4? 
Alexander, could you maybe provide a new image based on beta5 ?

  Thomas


>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2139
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2323
>> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>> ---
>>
>> v2: Remove the QEMU lowlevel keyboard hook procedure from the
>> SDL2 UI backend.
>>
>> v3: Rebase to current master because of a merge conflict.
>>
>>   ui/meson.build |  4 ----
>>   ui/sdl2.c      | 26 --------------------------
>>   2 files changed, 30 deletions(-)
>>
>> diff --git a/ui/meson.build b/ui/meson.build
>> index 28c7381dd1..35fb04cadf 100644
>> --- a/ui/meson.build
>> +++ b/ui/meson.build
>> @@ -120,10 +120,6 @@ if gtk.found()
>>   endif
>>   if sdl.found()
>> -  if host_os == 'windows'
>> -    system_ss.add(files('win32-kbd-hook.c'))
>> -  endif
>> -
>>     sdl_ss = ss.source_set()
>>     sdl_ss.add(sdl, sdl_image, pixman, glib, files(
>>       'sdl2-2d.c',
>> diff --git a/ui/sdl2.c b/ui/sdl2.c
>> index 1fb72f67a6..2cb95a6b7c 100644
>> --- a/ui/sdl2.c
>> +++ b/ui/sdl2.c
>> @@ -32,7 +32,6 @@
>>   #include "system/runstate.h"
>>   #include "system/runstate-action.h"
>>   #include "system/system.h"
>> -#include "ui/win32-kbd-hook.h"
>>   #include "qemu/log.h"
>>   static int sdl2_num_outputs;
>> @@ -262,7 +261,6 @@ static void sdl_grab_start(struct sdl2_console *scon)
>>       }
>>       SDL_SetWindowGrab(scon->real_window, SDL_TRUE);
>>       gui_grab = 1;
>> -    win32_kbd_set_grab(true);
>>       sdl_update_caption(scon);
>>   }
>> @@ -270,7 +268,6 @@ static void sdl_grab_end(struct sdl2_console *scon)
>>   {
>>       SDL_SetWindowGrab(scon->real_window, SDL_FALSE);
>>       gui_grab = 0;
>> -    win32_kbd_set_grab(false);
>>       sdl_show_cursor(scon);
>>       sdl_update_caption(scon);
>>   }
>> @@ -371,19 +368,6 @@ static int get_mod_state(void)
>>       }
>>   }
>> -static void *sdl2_win32_get_hwnd(struct sdl2_console *scon)
>> -{
>> -#ifdef CONFIG_WIN32
>> -    SDL_SysWMinfo info;
>> -
>> -    SDL_VERSION(&info.version);
>> -    if (SDL_GetWindowWMInfo(scon->real_window, &info)) {
>> -        return info.info.win.window;
>> -    }
>> -#endif
>> -    return NULL;
>> -}
>> -
>>   static void handle_keydown(SDL_Event *ev)
>>   {
>>       int win;
>> @@ -608,10 +592,6 @@ static void handle_windowevent(SDL_Event *ev)
>>           sdl2_redraw(scon);
>>           break;
>>       case SDL_WINDOWEVENT_FOCUS_GAINED:
>> -        win32_kbd_set_grab(gui_grab);
>> -        if (qemu_console_is_graphic(scon->dcl.con)) {
>> -            win32_kbd_set_window(sdl2_win32_get_hwnd(scon));
>> -        }
>>           /* fall through */
>>       case SDL_WINDOWEVENT_ENTER:
>>           if (!gui_grab && (qemu_input_is_absolute(scon->dcl.con) || 
>> absolute_enabled)) {
>> @@ -627,9 +607,6 @@ static void handle_windowevent(SDL_Event *ev)
>>           scon->ignore_hotkeys = get_mod_state();
>>           break;
>>       case SDL_WINDOWEVENT_FOCUS_LOST:
>> -        if (qemu_console_is_graphic(scon->dcl.con)) {
>> -            win32_kbd_set_window(NULL);
>> -        }
>>           if (gui_grab && !gui_fullscreen) {
>>               sdl_grab_end(scon);
>>           }
>> @@ -869,10 +846,7 @@ static void sdl2_display_init(DisplayState *ds, 
>> DisplayOptions *o)
>>   #ifdef SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR /* only available 
>> since SDL 2.0.8 */
>>       SDL_SetHint(SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR, "0");
>>   #endif
>> -#ifndef CONFIG_WIN32
>> -    /* QEMU uses its own low level keyboard hook procedure on Windows */
>>       SDL_SetHint(SDL_HINT_GRAB_KEYBOARD, "1");
>> -#endif
>>   #ifdef SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED
>>       SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
>>   #endif
> 


