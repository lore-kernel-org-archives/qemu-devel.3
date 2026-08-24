Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F15EC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVE2-00084y-9U; Mon, 24 Aug 2026 10:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wyVDz-00084Y-VX
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 10:00:32 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wyVDw-0001zx-NY
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 10:00:31 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67ODxvQR054735
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 24 Aug 2026 22:59:57 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=2ga67+xSox6TPNIKTupBnNIYRchO5CKmXeeKFWY9OFc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787579997; v=1;
 b=S6U7VFippKuHJmMdSH2z3jEk67zxdpJoRyiBEqaWV96ExM0ZrxtNWPWtQY0X4RQv
 FkdGguwRWDV0uNh8ZPeX01Ye4UHoV6nTBZj8UgoUbwXBZ7RqgMzcDAafNshiMHvo
 ZYCWqz2YF5EOnXA295hemP4ngS1lhas6UqFPQSVPzFr/fEA7yrjwiH2khzn+Xjmm
 j5DzAw8CxxFwmjpcgAK2QrJt3SYfEMsZwkq2KClaJDU5PyesPPg7q8ykkXJza/wK
 i4ZunElmTEj/qNjkD0QPRVOKhWgnV6D5VTzyfEVtWVLuWbsAFKcJg+gq2tiky5ns
 eMzHCb1VzQI5VlHDu5Tc/Q==
Message-ID: <c0e3c9af-f3e7-469c-8621-4b797ff8e518@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 24 Aug 2026 22:59:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] hw/display/xenfb: always register vfb and
 allocate console early
To: Dario Faggioli <dfaggioli@suse.com>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, sstabellini@kernel.org,
 anthony@xenproject.org, edgar.iglesias@gmail.com, philmd@mailo.com
References: <20260824071116.935828-1-dfaggioli@suse.com>
 <20260824071116.935828-2-dfaggioli@suse.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260824071116.935828-2-dfaggioli@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/08/24 16:11, Dario Faggioli wrote:
> This commit addresses a black console issues for Xen PV and PVH guests.
> 
> In fact, commit 6ece1df966 ("hw/xen: Register framebuffer backend via
> xen_backend_init()") introduced a check before registering the vfb
> backend. Problem is that the '-vga' agrument may not be present (e.g.,
> for PV/PVH guests started with 'xl') and this causes the backend to be
> silently ignored.
> 
> This commit restores the unconditional registration of the vfb backend.

This part looks correct.

> 
> Furthermore, even with the backend always being registered, the fact
> that xenfb allocates the QemuConsole asynchronously in fb_initialise()
> looks problematic. In fact, when the UI initializes, it finds 0 active
> consoles and it permanently allocates a dummy surface showing the
> message "This VM has no graphic display device". And since the removal
> of console_select() there's no way to dynamically switch to the xenfb
> console, when it is finally up and running.
> 
> This commit works around the issue by moving console creation to
> fb_init(), so that VNC attaches to it immediately. The surface is then
> updated normally via qemu_console_set_surface() once the guest framebuffer
> is mapped.

Moving console creation to fb_init() does not look sufficient. fb_init() 
is driven by the Xenstore backend state machine, so it is not guaranteed 
to run before display initialization. If the vfb backend instance is 
discovered later, fb_init() will run later in response to a Xenstore event.

fb_init() is also a per-connection hook. If the frontend closes and 
reconnects while the backend object remains, fb_init() runs again on the 
same XenFB object. The unconditional assignment then creates another 
QemuConsole and overwrites fb->con, leaving the previous console registered.

There is also no matching teardown. When the backend Xenstore node 
disappears, xen_pv_del_xendev() invokes ops->free before unplugging the 
XenFB object, but xen_framebuffer_ops has no .free callback. The 
QemuConsole can therefore retain a pointer to the freed XenFB as its 
opaque value.

Could the QemuConsole instead be created by xen_framebuffer_ops.alloc 
and closed with qemu_graphic_console_close() from 
xen_framebuffer_ops.free? The .alloc hook runs once per XenLegacyDevice, 
so the console would remain stable across frontend reconnects, while 
.free would close it when the backend object is removed.

The .alloc hook is the earliest per-device point. However, it still
cannot make the console visible before display initialization if the vfb
backend instance itself is created later.

> 
> Fixes: 6ece1df966 ("hw/xen: Register framebuffer backend via xen_backend_init()")

The unconditional-registration hunk fixes 6ece1df96629. The console 
creation hunk addresses a separate regression introduced by 
e99441a3793b. Please split the changes and give each patch its 
corresponding Fixes tag, using at least 12 hexadecimal digits:

Fixes: 6ece1df96629 ("hw/xen: Register framebuffer backend via 
xen_backend_init()")
Fixes: e99441a3793b ("ui/curses: Do not use console_select()")

These commits first appeared in v9.1 and v9.0, respectively. The 
registration change is not needed in v9.0, so combining the fixes 
complicates backporting the console fix to that release.

Regards,
Akihiko Odaki

> Signed-off-by: Dario Faggioli <dfaggioli@suse.com>
> ---
>   hw/display/xenfb.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
> index ae302b217f..3a0cdc0578 100644
> --- a/hw/display/xenfb.c
> +++ b/hw/display/xenfb.c
> @@ -851,9 +851,14 @@ static void xenfb_handle_events(struct XenFB *xenfb)
>   
>   static int fb_init(struct XenLegacyDevice *xendev)
>   {
> +    struct XenFB *fb = container_of(xendev, struct XenFB, c.xendev);
> +
>   #ifdef XENFB_TYPE_RESIZE
>       xenstore_write_be_int(xendev, "feature-resize", 1);
>   #endif
> +
> +    fb->con = qemu_graphic_console_create(NULL, 0, &xenfb_ops, fb);
> +
>       return 0;
>   }
>   
> @@ -882,8 +887,6 @@ static int fb_initialise(struct XenLegacyDevice *xendev)
>       if (rc != 0)
>           return rc;
>   
> -    fb->con = qemu_graphic_console_create(NULL, 0, &xenfb_ops, fb);
> -
>       if (xenstore_read_fe_int(xendev, "feature-update", &fb->feature_update) == -1)
>           fb->feature_update = 0;
>       if (fb->feature_update)
> @@ -973,9 +976,6 @@ static const GraphicHwOps xenfb_ops = {
>   static void xen_ui_register_backend(void)
>   {
>       xen_be_register("vkbd", &xen_kbdmouse_ops);
> -
> -    if (vga_interface_type == VGA_XENFB) {
> -        xen_be_register("vfb", &xen_framebuffer_ops);
> -    }
> +    xen_be_register("vfb", &xen_framebuffer_ops);
>   }
>   xen_backend_init(xen_ui_register_backend);


