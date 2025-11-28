Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DE3D116E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 16:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP1cW-0000e5-QK; Fri, 28 Nov 2025 11:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>) id 1vP1cR-0000d6-CT
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 11:46:53 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>) id 1vP1cP-0005n6-32
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 11:46:50 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 13E3F6016F;
 Fri, 28 Nov 2025 16:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68719C4CEF1;
 Fri, 28 Nov 2025 16:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764348399;
 bh=2/LDXJbhzfaY8TgSwz0wTHwET8ytYKSX0vuKmjOg9q8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gPTyQiqSWeJ3qKgwhHuE5OPm2JY5XfYMHBl1vU3fZitjs7TtFqOXG3NzAuDjD6JNW
 IFbSUWsKQ0fmzhLxmPezWj4XweDRXlKLO/6wj5x6PGVU6GfETcgUXjUCWTOS0jxTcw
 HrvAv/MQ4sVAHQA9n3NwhVs6TjQW+ftvxO/Zj2cidFS/fQMoqa2opCqEUyq9v+LMQF
 XLIyGc5/Rfig+zszKHU8nQqXljrzlaGN3IPiGjIm7svpG7zmQeKX2kAQ/6WxkNR76s
 xk50wEPHeuten1KOHxMbuYOzD/oV+DNMSogIHtvNp7AynWGz55u2t8KMobEg0LpQbj
 EgI5QnJFNq6lA==
Date: Fri, 28 Nov 2025 09:46:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: qemu-devel@nongnu.org, Peter.Turner@cloud.com, ngoc-tu.dinh@vates.tech,
 Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, xen-devel@lists.xenproject.org
Subject: Re: Default NVMe MDTS value causes Widnows Server 2025 hangs and
 BSODs (during install at least)
Message-ID: <aSnR7elEI_aJ1fFM@kbusch-mbp>
References: <aSl5X4dJHACpJHPU@Mac.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSl5X4dJHACpJHPU@Mac.lan>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=kbusch@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Nov 28, 2025 at 11:28:47AM +0100, Roger Pau Monné wrote:
> Hello,
> 
> As part of XenServer Windows Server 2025 testing using Xen plus QEMU
> we discovered an issue during install that would lead to either the
> Windows installer getting stuck without making progress (albeit the
> screen was still showing the spinning circle correctly) or a BSOD that
> doesn't seem to have a unique number, the most common one was 0x50
> (PAGE_FAULT_IN_NONPAGED_AREA).
> 
> After a fair amount of debugging and following incorrect leads we have
> narrowed down what triggers the issue to QEMU emulated NVMe reporting
> a MDTS value of 7 by default (so max request size of 512KiB).
> Switching to higher MDTS values seemed to solve the issue.
> 
> The commit that made that change:
> 
> e137d20e7dff hw/block/nvme: add check for mdts
> 
> Didn't contain much justification for the change from unlimited to
> 512KiB max request size.
> 
> Windows is like a black box to me, but I believe there's some error in
> the Windows logic that splits requests, and hence when MDTS is set to
> a sufficiently low value, and Windows has to split NVMe requests, it
> causes Windows to hit an internal bug.  This will be raised with
> Microsoft to get the issue debugged and possibly fixed on their side.
> 
> From limited experimentation setting mdts to 10 (so 4MiB max request
> size) or 9 (2MiB) workarounds the issue.
> 
> Would it be acceptable for QEMU NVMe to consider increasing the
> default MDTS value to something higher than 7 to workaround the issue?
> I've tested both 9 and 10 and they prevent the issue, I would avoid 8
> as it's too close to the current one that causes issues.  I don't have
> many references of other emulated NVMe implementations, I just know
> about Bhyve emulated NVMe, which sets MDTS to 9.
> 
> If bumping MDTS to a higher value is acceptable please let me know and
> I will prepare a patch.

The mdts value is a prameter you can set at the command line. The 512k
default is really pretty reasonable, but you can set it up to 2MB
(mdts=9) if you want before hitting a different software limit that
won't let you go any higher. So rather than patch the device, I'd
recommend you just modify your startup command line parameters instead.

Not sure if it's still the case, but there was a time when Windows
Storport's maximum IO size had been limited to 128k, and that's exactly
what many nvme devices reported for MDTS, so Windows is certainly
supposed to work correctly with such values.

