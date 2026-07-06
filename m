Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206E8C44502
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgmvx-0005xP-1e; Mon, 06 Jul 2026 13:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1wgmvu-0005ws-UN; Mon, 06 Jul 2026 13:16:38 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1wgmvs-0000f0-Rz; Mon, 06 Jul 2026 13:16:38 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 6FEDCEC019B;
 Mon,  6 Jul 2026 13:16:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 06 Jul 2026 13:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1783358195;
 x=1783444595; bh=Qi2hFhZRWnynHEOZ3uKAYDWZ5mtD8/edMhnXoiEb4Cc=; b=
 Qr5FvnjiJaUXHPgl8GOraEReUUFiXQJegrXRgHQky5PtWdj0RvHOr+4tkpA6HJwD
 7Lh6sdBAbYTIBqBwSJwm5CLIp9qKqx5POQkx1vK4ewwsiEfaaEaXhCVDgbWQuaNP
 QwuWRPLxhFnpeePaKB12pkV1znVxUTWUacfbaJUJGM+p9VfdyAe3Mj6DC2Vxymrg
 vWfEnKXPGyF9y98gqKHu41wsYp7+slrERKgYZuqkd+MOYANsbfN7i4OKdpSMo/sw
 F6yesAFAZ4vWAximSs+UZom2k5OnQNzJRkgitRvqq3j6e+DfLLnrSVspopC5d7JV
 7hSzwp0LyCPwWmpLGvOzIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783358195; x=
 1783444595; bh=Qi2hFhZRWnynHEOZ3uKAYDWZ5mtD8/edMhnXoiEb4Cc=; b=g
 569d9LCnOEp0dZIqvOPqOjfHd7nll6SHxg4veIY3hjBwRrO55ftBv37jnTVCsj59
 DPMt+Kcr8kzAEx+D7USlHwed6rxJu26Lugf/omQHp+5mMqG/K+IoNVcrfYaIYWqg
 S/mI8PX1uDejZfPLIucATty3B9yhen0qEPTsEdRrr+xXeSodR5Y3bo6+dAvcm4mr
 01g2iWOHZ3IEX1uHjcqJQTCVz2s79r2GFec7xO+kQsPI817acJlQWwyT8S4Qs7Sw
 Rah8Rg+iKf5/MaOo5AOffQLRuSQQlgq5U/xr6boj0GhFW20/901RRLTbpdaOSV2u
 IjYG35QuSfo9L0U+PgEGw==
X-ME-Sender: <xms:8uJLasduCXpTikeIofhDHAlU9oYf0YX_GWtsnMi3rYnlwKUxRpw_1Q>
 <xme:8uJLagf5zB9hWUOmvh7fViZI6HZHAoiikVkfaETBT2STdzacfMHO4ubYPghqNukPP
 UVh81IZISdr7b2wupB1nlGxeaFr-8AWhn5QkzYwmNwFTyY7mcpjcA>
X-ME-Received: <xmr:8uJLavwtukFZFGs_HCkL0iAQMj-Lu2uDydj4KTUM_BAiLgUpc6T9Nopb7pU>
X-ME-Proxy-Cause: dmFkZTFw1wR0YX/SPd5VeNq6ejKz0GEeIbrfiw9Wyb1J2Js7kSAx7d8RPaOmEG4OBP3I6N
 eDFJPhn2w8h4LXYp8U31C3JvRz4DW85op4B6t6rAhg+mp8zk18Kn7Fouxb0GwOHI78gGIl
 nNKam7ufyVUIFEhQcctc8d+kSQ4e/BnL+UaGpZks3/dIRRR4YOPDKS12s7hkom6EW+HbYf
 8fyAi8chOh/o3T7LkHoD2PgjR8RSR+3qVJGzNsIXZIWA/dQF9f2IEqlIp+Zalmyx+4fI0h
 PDu5yRqoMMX3ljnnPO4EuaqFvrS44KMv+dtSe3MXIOrQB4lpDvD4QusRwM5YHNB1MxFCqW
 fF3kn534ofalDocyJlN7g2lTSvnDe7rsPiz+bFn2ZL/O0xSzu5uTU3/EmPom0nF2dpdhHs
 BcpLBwYtIqUYQxQqUw3HmpApeG+F616aiBH7LQ4fAEhnI+RYIi+w1CddvdRoKDSYZyAVpH
 9L9nSqEtuvASrZfbjlKfQJhZn2BRS80O61ualQBLORpbo/AHZ2LcAbzupb+etVk6MYLH9d
 CNuHGCF88mhnecS/qaSk4HN4NwNiTJO25sLBbdSik9NDjuEOiHIHbwVvF4YyMwvQoBhRcB
 7h7t29hFd4ocU3IJy94D3ENko01SyqCmjwQ2hS+WYWQxrqDdCrmbdRyam64Q
X-ME-Proxy: <xmx:8uJLan9qlbyordrVmDYBk-geqaQeGMAxf8MgUSBKLc-mnbHhwmJwXQ>
 <xmx:8uJLanhGFSBr_FHifxYepxQ_AL833lPoTGzIjXbW7wj_RcxRD8d0rw>
 <xmx:8uJLauEwTB-xnRiXxH6Zwhrdbg_y1C58h5nmqApuhle6PuKa8FDYEg>
 <xmx:8uJLam9RoWjQIZmzxRdQvVsay20UcxAp1rhgYaScdbHuY694V_GgWQ>
 <xmx:8-JLahCbd4hVQZFiGSxGZiGKYvtLRncQC479V-DVf8Zvv7_pSpb0En_z>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 13:16:34 -0400 (EDT)
Date: Mon, 6 Jul 2026 11:16:32 -0600
From: Alex Williamson <alex@shazbot.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Eric Auger
 <eric.auger@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 alex@shazbot.org
Subject: Re: [PATCH] vfio/listener: Only warn on misalignment for VFIO-owned
 regions
Message-ID: <20260706111632.64266244@shazbot.org>
In-Reply-To: <CAFEAcA-d9CJhfJQ2B1h+mZTPphc7SKk8yjCuGH4RWYT9J=EATw@mail.gmail.com>
References: <20260702160640.3875666-1-clg@redhat.com>
 <20260706082023.7ee830b8@shazbot.org>
 <3f799ad7-08a5-44c7-b6bf-b143da038593@redhat.com>
 <CAFEAcA9wOZhn41Twz9zzCBD4MAET2+gbF71kUKnr7r6TXfhjuw@mail.gmail.com>
 <20260706094241.1457bbc6@shazbot.org>
 <CAFEAcA-d9CJhfJQ2B1h+mZTPphc7SKk8yjCuGH4RWYT9J=EATw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=alex@shazbot.org;
 helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Mon, 6 Jul 2026 17:12:35 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 6 Jul 2026 at 16:42, Alex Williamson <alex@shazbot.org> wrote:
> >
> > On Mon, 6 Jul 2026 16:27:46 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:  
> > > It seems very unlikely that anything not page-aligned is going
> > > to be a sensible target for DMA ops from a device: the main
> > > reason to have a non-page-aligned or non-page-sized region is that
> > > it's the way we've chosen to implement a device, or it's some
> > > "RAM but not general-purpose RAM" thing. If there's a path to
> > > warn/error if it's actually used for a DMA op that would be worthwhile,  
> >
> > But for a vfio-pci device there is no DMA op, it either gets mapped
> > into the IOMMU for direct access to the device or not.  This is the
> > point at which that decision is made.  
> 
> Why is small RAM different from MMIO register regions here?
> Those also you're not going to be able to have a device do
> direct memory access to.

There's a precedent for bare metal, peer-to-peer DMA is less reliable
and drivers don't typically have blind faith in it working.
Peer-to-peer DMA also has specific use cases, drivers don't arbitrarily
pick a peer device to DMA to, they have specific use cases and target
regions are inherently sized and aligned appropriately.

Here we have RAM and we're trying to determine whether it's RAM that
could be allocated as a DMA buffer or expect a DMA access from a
device.

Commit 851d6d1a0ff2 spelled out that we could have declared these sorts
of regions as RAM device, solving the problem with a simple test, but
that wasn't well received (for reasons I don't remember), so we were
forced to create this mechanism and maintenance issue.

> > > but as it stands I think all this warning will ever cause us to
> > > do is add more entries to its whitelist every time it complains.  
> >
> > IMO, that's ok.  That's the purpose.  We're up to one whole class of
> > device so far, we don't care about mapping failures to TPM devices.  If
> > some day this does fire on something we care about, especially a
> > regression, it'll earn its keep.  It doesn't seem like an excessive
> > burden yet. Thanks,  
> 
> The reason we're having this conversation is because it just fired
> again, and the warning gives the impression that the right thing
> to do is to somehow change the misaligned memory region, not to
> add something to the whitelist. That's already wasted several
> people's time.

Since being introduced 4 years ago, we've iterated on one class of
device.  It doesn't feel like there's a persistent time sink here.

> You could add a comment saying
> 
> /*
>  * If this warning ever fires, then it will almost certainly
>  * be because of a legitimately non-aligned RAM-backed
>  * MemoryRegion that needs adding to the whitelist.
>  */

Personally I'd start with the error log itself, providing a hint that
the region is presented as RAM but isn't sized/aligned for DMA from a
vfio device, with a hint to mark it as safe if it is legitimately not a
valid DMA target.  Thanks,

Alex

