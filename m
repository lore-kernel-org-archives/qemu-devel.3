Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED90FCD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 23:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZ1B-00033T-Dy; Fri, 22 May 2026 19:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wQZ19-00033D-Q0; Fri, 22 May 2026 19:10:59 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wQZ15-0005RS-JH; Fri, 22 May 2026 19:10:58 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0C63744550;
 Sat, 23 May 2026 01:10:53 +0200 (CEST)
Message-ID: <51204e0c-14e1-41db-8eaf-83bc3734567d@proxmox.com>
Date: Sat, 23 May 2026 01:10:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Stable-11.0.1 v2 00/94] Patch Round-up for stable 11.0.1, freeze
 on 2026-05-22 (frozen)
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
References: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1779491432465
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Hi Michael,

Am 22.05.26 um 11:35 PM schrieb Michael Tokarev:
> Please respond here or CC qemu-stable@nongnu.org on any additional patches
> you think should (or shouldn't) be included in the release.

> 92 b8bfb1478d61 Kevin Wolf:
>    qcow2: Fix corruption on discard during write with COW
> 93 389f5bcc744d Kevin Wolf:
>    iotests/046: Test that discard/write_zeroes wait for dependencies

since number 92 can cause an issue [0] that is much easier to run into
than the one it solves, but still similarly bad, I think it should only
be included together with Thomas' fix [1] on top. I know that one has
not been applied to master or reviewed by a maintainer yet, so if
including it goes against procedure, maybe it'd be better to leave 92
(and 93) out for now or delay the release?

Same for the other stable series. Thank you for the consideration!

Best Regards,
Fiona

[0]:
https://lore.kernel.org/qemu-devel/414848c6-3829-4120-b760-6db8d43c1ab5@proxmox.com/
[1]:
https://lore.kernel.org/qemu-devel/20260522151318.238064-1-t.lamprecht@proxmox.com/



