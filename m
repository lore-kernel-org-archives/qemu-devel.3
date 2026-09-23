Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD46C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9IPa-0004hj-Iq; Wed, 23 Sep 2026 04:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x9IPT-0004ha-Ab
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 04:33:00 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x9IPQ-0006dk-BG
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 04:32:59 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68N8WoAi094272
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 23 Sep 2026 17:32:50 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=sGOKJaWMd45eCCCDIeBP83SvDyeByLEOB3SM3UjpOjE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1790152370; v=1;
 b=ITLOkl+eZJFXkGAXAXduuiYx+Uu4xK38GOcLRjlULSbxIJLP8tULj7ruHLpqd1oZ
 4xAPbhqMhadB83k1A5DDtpY55lzcwFle1glSfaVYkIOZukO1XwBRvNe/ywWfYjbj
 bT0AicPYIWy5kgykp553MAXyPhMLmiagFzBgWKdlyuS3c8BnAqfTjlrPr3jC0hDg
 rA8G6onr4NDdwyIUJ3mSSuffAq8zEyfUUL9jtu2+RIH5KGGf6tYPxZHXGo/xZIU/
 S6GhBF36tJ7WMmu254XULbDj2iyLl9SyYYaixWtno9lCaLyuPvbf4sDNraPc/3va
 rMlpMmAELdn5UWF7IO4YJA==
Message-ID: <aa8b022a-f6ca-46a9-ad4c-310123c2335a@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 23 Sep 2026 17:32:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu 0/1] hw/net/e1000e: make PHY power-management match a
 real 82574L
To: ~oyasan2-ba2 <oyasan.ba2@gmail.com>, qemu-devel@nongnu.org
Cc: dmitry.fleytman@gmail.com, jasowangio@gmail.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
References: <179015005471.1471.12638559665582988999-0@git.sr.ht>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <179015005471.1471.12638559665582988999-0@git.sr.ht>
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

On 2026/09/23 16:54, ~oyasan2-ba2 wrote:
> This series brings e1000e's PHY power-management handling (BMCR.PDOWN,
> CTRL.RST vs CTRL.PHY_RST, and the PCI D3hot -> D0 transition) in line
> with the 82574 datasheet (Order 317694-016, Rev 2.5) and with what I
> measured on a real 82574L NIC (8086:10d3, via direct MDIC register
> access, bypassing the guest driver so the link-down and power-down
> states could actually be observed).
> 
> Currently the model:
> - ignores BMCR.PDOWN entirely for the link (patch 1);
> - resets the PHY on every CTRL.RST (a software/MAC reset) but not on
>    CTRL.PHY_RST (backwards from the datasheet and from what I measured
>    on real hardware) (patch 2);
> - does nothing on a D3hot -> D0 PCI power-state transition, although
>    the datasheet says the device performs an internal reset that
>    includes the PHY (patch 3).
> 
> Patch 2 depends on patch 1 (e1000e_phy_powered_down()), and patch 3
> depends on patch 2 (e1000e_phy_reset()). Each patch adds its own qtest
> (phy_power_down, phy_reset_semantics, phy_d3hot_reset); I verified each
> new test fails without its patch and passes with it, and that the
> existing e1000e qtests (init, tx, rx, multiple_transfers, hotplug)
> still pass throughout. The series applies to and builds cleanly against
> current master.

This series only contains one patch and cannot be applied.

Regards,
Akihiko Odaki

> 
> I found this while implementing a fault-injection test harness for the
> e1000e driver (suspend/resume and RX-buffer fault scenarios) - the
> model's link/PHY state didn't behave like the real 82574L it emulates,
> which made some of those scenarios impossible to exercise faithfully.
> 
> oyasan2-ba2 (1):
>    hw/net/e1000e: reset the PHY on a D3hot to D0 transition
> 
>   hw/net/e1000e.c           | 14 ++++++++++++++
>   hw/net/e1000e_core.c      | 15 +++++++++++++++
>   hw/net/e1000e_core.h      |  3 +++
>   tests/qtest/e1000e-test.c | 40 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 72 insertions(+)
> 


