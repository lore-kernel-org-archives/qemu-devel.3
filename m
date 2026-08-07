Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B07C5AC67
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 00:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws8HJ-00088j-4V; Thu, 06 Aug 2026 20:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1ws8HD-00088Q-PQ; Thu, 06 Aug 2026 20:17:32 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1ws8HB-0006JG-Mi; Thu, 06 Aug 2026 20:17:30 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 14676404AD;
 Fri,  7 Aug 2026 00:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4FC1F000E9;
 Fri,  7 Aug 2026 00:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786061847;
 bh=SLxc4eVqoA64jflmY+2zL+dzl62hQKdRsRl9P+3gvE8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dnXy7fEfdaCGMkYakyImgHuPX4abb+DoUGy44m813S4HsG6BKcH2tTF8IcRC0EoRN
 WdgWDYgy9iMM6H/Y4+MsWPvP/FGXvXHyTfbkx6EYrBgcslkKeRO8XvIIuOOjqqZFoE
 hwou5t/j5QalbADvjopkCzxb+c4EIvYI0zTf7hEdB2syKd03UjCc4VJHRPS/vGJTNg
 F/aS/8urwtffjYwnj8QwAlRL5bjCumIai3CohZo4uf/l7c6EHPnhvb/KwtFPOYu0rA
 Aa9pp5qV+w9oIr5bI/gwViijuxmrpd6kM8VkKKyKapVgt6r+ieXaCoM4uEgmdqWhT8
 2ZZN/9i2DcRWw==
Date: Fri, 7 Aug 2026 02:17:22 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Sam Li <faithilikerun@gmail.com>, dlemoal@kernel.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v14 3/6] qcow2: add configurations for zoned format
 extension
Message-ID: <anUkEv3T9GqFzQ0q@ryzen>
References: <20260708221615.346155-1-faithilikerun@gmail.com>
 <20260708221615.346155-4-faithilikerun@gmail.com>
 <anUfL40CLw_amIJE@ryzen> <anUhlwOBFW_lUThL@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anUhlwOBFW_lUThL@ryzen>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=cassel@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 07, 2026 at 02:06:52AM +0200, Niklas Cassel wrote:
> On Fri, Aug 07, 2026 at 01:56:36AM +0200, Niklas Cassel wrote:
> > Looking at the write_granularity in virtio-blk + file-posix:
> > for blkcfg.zoned.write_granularity, which is what virtio-blk exposes to
> > the guest, it is initialized using:
> > https://github.com/qemu/qemu/blob/v11.1.0-rc3/hw/block/virtio-blk.c#L1257
> > conf->logical_block_size:
> > https://github.com/qemu/qemu/blob/v11.1.0-rc3/hw/block/virtio-blk.c#L1183
> > 
> > and the value we set to the qemu block layer - bs->bl.write_granularity,
> > which file-posix initilizes using:
> > https://github.com/qemu/qemu/blob/v11.1.0-rc3/block/file-posix.c#L1498-L1501
> > the sysfs value for physical_block_size.
> 
> If we are using sysfs, I wonder why this code does not simply read:
> /sys/block/<disk>/queue/zone_write_granularity
> instead.
> 
> 
> But that would still be inconsistent with blkcfg.zoned.write_granularity which
> is initialized using conf->logical_block_size.

At least QEMU is currently bug compatible with Linux:

linux $ git grep "zone_write_granularity ="
block/blk-settings.c:           lim->zone_write_granularity = lim->logical_block_size;
drivers/scsi/sd_zbc.c:  lim->zone_write_granularity = sdkp->physical_block_size;

Where blk-settings is using the logical block size, but SCSI is using the
physical block size :)


Kind regards,
Niklas

