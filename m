Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246DE103A9AB
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 11:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5M9l-0002UN-6e; Wed, 25 Mar 2026 07:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w5M9g-0002RB-MJ; Wed, 25 Mar 2026 07:12:09 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w5M9d-0003QR-1E; Wed, 25 Mar 2026 07:12:08 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62PBBipP089583
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 25 Mar 2026 20:11:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=DwQZgWYO+lfkraRGuO+n63GxyjOYJesnFSUlCgbcPNs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1774437104; v=1;
 b=pk8LNZ1dhm2/xFTbs244gRnnnD5Z/FMv7neiAvKRx7yiBEYzG10q7yOioPO3ZW3n
 TgjtxMoG2hxwvvP6JFRfYl4mp1B7zIFpW6ZXfOWKDZLSYSSOU8BDzm3phdUNReuv
 Rwwwf2BcdcjwuLpt7KdndCz9zNAG44KMbG2CrcrOoxeIYnSgAvcB28IOpwotkCFD
 wOcPdqUc+rjxN/sTTcrBF1pXFp6WISJl21G8rsWKk/GeMGBo6qb4/yoBgGLOnLwP
 Y+xR2UNoMeDQEmk+PmeDvhEGr7b+9i43aj/D/GyJrLeScz51QQfGXTGk77TC1cVs
 AADUiLX5DGaDEzam3YJsHg==
Message-ID: <f7c84a25-2f78-48ef-8901-2b752ead8900@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 25 Mar 2026 20:11:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 0/7] vmapple: making it work on the latest macOS
 host releases
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Alexander Graf <agraf@csgraf.de>
References: <20260324204855.29759-1-mohamed@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260324204855.29759-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/03/25 5:48, Mohamed Mediouni wrote:
> v7:
> 
> Support for newer guest OSes.
> 
> Added not mergable patch for private ISA enablement.
> 
> Not grabbing a memory reference and still using flatview_for_each_range
> for this one, which works fine as live migration is disallowed anyway.

I prefer the other solutions suggested earlier. My preference order:
- Use a listener or change flatview_for_each_range() to remove const.
- Casting away const.
- Avoid grabbing memory references (this version)

Regards,
Akihiko Odaki

> 
> v6:
> Rework the patches a bit, with making sure that there's no compiler warnings
> 
> v5:
> Address review comments and rebase.
> 
> v4:
> Rebase and resend without the RFC tag as I didn't get feedback.
> Drop patch 1 (version I posted was incomplete anyways). Last patch isn't worth it too tbh.
> 
> v2->v3:
> Remove the Apple M4 support workaround part for now, to be part of another patchset perhaps
> Address comments
> 
> v1->v2:
> Remove some lines that shouldn't have been present...
> 
> Mohamed Mediouni (7):
>    vmapple: apple-gfx: make it work on the latest macOS release
>    hw/vmapple: aes: convert MAX_LEN to a #define
>    vmapple: declare it as an AArch64-compatible machine
>    Revert "hw/arm: Do not build VMapple machine by default"
>    vmapple: add gicv2m
>    vmapple, gicv2m: add macOS compat quirk
>    hvf: do not merge: enable private ISA
> 
>   accel/hvf/entitlements.plist                |  2 +-
>   configs/devices/aarch64-softmmu/default.mak |  1 -
>   hw/display/apple-gfx-mmio.m                 | 59 ++++++++++++++++-----
>   hw/display/apple-gfx.h                      | 16 ++++++
>   hw/display/apple-gfx.m                      | 41 +++++++++++++-
>   hw/intc/arm_gicv2m.c                        |  5 ++
>   hw/vmapple/aes.c                            |  3 +-
>   hw/vmapple/vmapple.c                        | 27 ++++++++++
>   target/arm/hvf/hvf.c                        |  8 +++
>   9 files changed, 144 insertions(+), 18 deletions(-)
> 


