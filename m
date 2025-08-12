Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FE1C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 16:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulrnO-00032n-4F; Tue, 12 Aug 2025 12:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <regressions@leemhuis.info>)
 id 1ulrnI-00031v-AQ
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 12:24:13 -0400
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <regressions@leemhuis.info>)
 id 1ulrnC-0002hj-VD
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 12:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
 Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
 References; bh=aHJzgTYNHhUFIaGCwqmyoUgVvhj+lSUoXDtgiSq6xY8=; t=1755015847;
 x=1755447847; b=Tzb4Htt04XBMvgKCFd7s6RyPDLXtgZeRifWonT27JiK9naAg4bjJy+eR+e26j
 aVV0D9QO2DZtWFeLDek4gmeQryyVWgAe6zgdyUdg/cM+NAl9o44+QEfBC17P9+xQyqX4OQ+GQhuC/
 8XPrFeyMqe0bbbLLbaMWe0kfRPLFWEG+Wov5UPWrSo/rrf3oiaxEb4WI2WlxyQlz1dUm4UGJGeTHO
 uD7i0FcAhsq5iA/E/nJ/jv8X4HdbP6V7kLB8lrr6PgMkv1DEVitp2EnB1SW/pONcub3jgwpo6R4/x
 49I63xg+DSDaK7HOnO/Y/jZ77effaCcLcOEAb51bbobrz+0eTg==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 id 1ulrms-004YLW-1x; Tue, 12 Aug 2025 18:23:46 +0200
Message-ID: <9b9edf2a-b4f3-4024-a91d-0902cfe832dc@leemhuis.info>
Date: Tue, 12 Aug 2025 18:23:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] kernel panic is not displayed correctly in
 qemu (CONFIG_DRM_BOCHS)
To: Askar Safin <safinaskar@zohomail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Noralf_Tr=C3=B8nnes?=
 <noralf@tronnes.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 virtualization <virtualization@lists.linux.dev>,
 ryasuoka <ryasuoka@redhat.com>, dri-devel <dri-devel@lists.freedesktop.org>,
 qemu-devel <qemu-devel@nongnu.org>, regressions
 <regressions@lists.linux.dev>, Ben Hutchings <benh@debian.org>
References: <197f290e30b.eaadc7bc7913.7315623184036672946@zohomail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <197f290e30b.eaadc7bc7913.7315623184036672946@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1755015847;
 8aa843d8; 
X-HE-SMSGID: 1ulrms-004YLW-1x
Received-SPF: pass client-ip=80.237.130.52;
 envelope-from=regressions@leemhuis.info; helo=wp530.webpack.hosteurope.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi! Thanks for your report. Given that Thomas' commits that broke things
and then partially made them working again are from 2019 there is no
real benefit in tracking this with regzbot, as it can't be solved with a
revert or such; sure, ideally the involved developers or someone else
will look at it, but often they have much more important things to fix –
and often they moved on to new endeavors and sometimes even retired in
between. Sorry, that's just how it is.

But well, with a bit of luck this mail or something else motivates
someone to look into the issue. :-D Wish you luck!

Ciao, Thorsten

#regzbot introduced: a6c3464f69cf5a8a31e
#regzbot resolve: tracking unpromising

On 10.07.25 06:21, Askar Safin wrote:
> Steps to reproduce:
> 
> - Build Linux v6.16-rc5 so:
> 
> $ cat mini
> CONFIG_64BIT=y
> 
> CONFIG_EXPERT=y
> CONFIG_EMBEDDED=y
> 
> CONFIG_PRINTK=y
> CONFIG_PRINTK_TIME=y
> 
> CONFIG_PCI=y
> 
> CONFIG_TTY=y
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_DRM=y
> CONFIG_DRM_FBDEV_EMULATION=y
> CONFIG_DRM_BOCHS=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_PROC_FS=y
> $ make KCONFIG_ALLCONFIG=mini allnoconfig
> $ make
> 
> - Then boot this Linux image in Qemu so:
> 
> $ qemu-system-x86_64 -enable-kvm -m 1024 -daemonize -kernel arch/x86_64/boot/bzImage
> 
> Kernel will (predictably) panic (because it has no initramfs, nor real disk), but actual panic message will not be shown!
> 
> Last shown line is "Run /bin/sh as init process"
> 
> My host OS is Debian Trixie. "uname -a":
> 
> Linux receipt 6.12.33+deb13-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.12.33-1 (2025-06-19) x86_64 GNU/Linux
> 
> Qemu version is:
> 
> QEMU emulator version 10.0.2 (Debian 1:10.0.2+ds-1)
> 
> Guest kernel is v6.16-rc5 x86_64.
> 
> The problem doesn't reproduce on old guest kernels. I. e. old guest kernels actually show panic message.
> 
> I did bisect, and bisect showed the following two commits:
> 
> ===
> 
> commit a6c3464f69cf5a8a31eb31cc436e7dbd325b8ff9
> Author: Thomas Zimmermann <tzimmermann@suse.de>
> Date:   Thu Jun 13 09:30:33 2019 +0200
> 
>     drm/gem-vram: Support pinning buffers to current location
>     
>     Pinning a buffer prevents it from being moved to a different memory
>     location. For some operations, such as buffer updates, it is not
>     important where the buffer is located. Setting the pin function's
>     pl_flag argument to 0 will pin the buffer to whereever it is stored.
>     
>     v2:
>             * document pin flags in PRIME pin helper
>     
>     Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>     Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>     Link: https://patchwork.freedesktop.org/patch/msgid/20190613073041.29350-2-tzimmermann@suse.de
> 
> commit 58540594570778fd149cd8c9b2bff61f2cefa8c9
> Author: Thomas Zimmermann <tzimmermann@suse.de>
> Date:   Wed Jul 3 09:58:34 2019 +0200
> 
>     drm/bochs: Use shadow buffer for bochs framebuffer console
>     
>     The bochs driver (and virtual hardware) requires buffer objects to
>     reside in video ram to display them to the screen. So it can not
>     display the framebuffer console because the respective buffer object
>     is permanently pinned in system memory.
>     
>     Using a shadow buffer for the console solves this problem. The console
>     emulation will pin the buffer object only during updates from the shadow
>     buffer. Otherwise, the bochs driver can freely relocated the buffer
>     between system memory and video ram.
>     
>     v2:
>             * select shadow FB via struct drm_mode_config.prefer_shadow_fbdev
>     
>     Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>     Acked-by: Noralf Trønnes <noralf@tronnes.org>
>     Link: https://patchwork.freedesktop.org/patch/315833/
>     Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> ===
> 
> Commit a6c3464f69cf5a8a31e changed good behavior to absolutely wrong: after a6c3464f69cf5a8a31e I see just black screen.
> Then (after many commits) 58540594570778fd149 made screen working again, but now panics are not shown.
> 
> So, result: all commits in range a6c3464f69cf5a8a31e .. 58540594570778fd149 are not testable (black screen), all commits before a6c3464f69cf5a8a31e
> are "good" (panic is shown) and all commits after 58540594570778fd149 (inclusive) (including v6.16-rc5) are "bad" (panic is not shown).
> 
> The next commit after 58540594570778fd149 is 5fd5d2b7c53de5a1290d82, thus correct regzbot instruction is:
> 
> #regzbot introduced: a6c3464f69cf5a8a31e..5fd5d2b7c53de5a1290d82
> 
> Config above is not special. It is result of minimizing standard Debian config.
> 
> The bug is reproducible with standard Debian kernels (if we use them as guests).
> 
> Reproduction steps are so:
> - Install Debian Trixie to Qemu VM
> - Boot it with "init=/bin/true" added (to cause kernel panic)
> 
> You will not see panic message.
> 
> I minimized this Debian bug to small config shown in the beginning of this letter.
> 
> --
> Askar Safin
> https://types.pl/@safinaskar
> 
> 
> 


