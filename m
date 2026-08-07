Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825D6C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 00:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws874-0006wg-I1; Thu, 06 Aug 2026 20:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1ws86z-0006vs-OK; Thu, 06 Aug 2026 20:06:57 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1ws86w-0004QE-1y; Thu, 06 Aug 2026 20:06:55 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6EBF76004E;
 Fri,  7 Aug 2026 00:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55FB1F000E9;
 Fri,  7 Aug 2026 00:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786061212;
 bh=iKs5p9W0ypmysba7hkqHMaaWnXRuQFVMgH4tQC7MU+I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ccM3fETuharJ3rz72Ub6px4ofPZoI82jaKPRNNfOnayhyv2zeDMbouEwgFBdPCC8s
 LQY9hOW0F9ysskHYHnr/sZq8qySL7lAv4q4081TfmphnC3vDXplCB/IuiX/z7NBAJo
 bCW6mATFUwoU7NIqudSvQvviLqTfwbenlqakKKxqk/NdK5XnnjHkJxA2/JIozMKi6M
 hemJ9IKKqwNMF8Ckf8RuyoPk/GdtwR4TjgqFRT/RNuoxW85g/aq//SuJcuDihRFUBP
 5jC3b5arP4IhN2aviQS/ZwJviE/b7oFIYZ1ev7aQWnMlxDLs2iVBP7qkSUR4HJ6O9B
 NcAbnSUdIwAIw==
Date: Fri, 7 Aug 2026 02:06:47 +0200
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
Message-ID: <anUhlwOBFW_lUThL@ryzen>
References: <20260708221615.346155-1-faithilikerun@gmail.com>
 <20260708221615.346155-4-faithilikerun@gmail.com>
 <anUfL40CLw_amIJE@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anUfL40CLw_amIJE@ryzen>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=cassel@kernel.org;
 helo=tor.source.kernel.org
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

On Fri, Aug 07, 2026 at 01:56:36AM +0200, Niklas Cassel wrote:
> Looking at the write_granularity in virtio-blk + file-posix:
> for blkcfg.zoned.write_granularity, which is what virtio-blk exposes to
> the guest, it is initialized using:
> https://github.com/qemu/qemu/blob/v11.1.0-rc3/hw/block/virtio-blk.c#L1257
> conf->logical_block_size:
> https://github.com/qemu/qemu/blob/v11.1.0-rc3/hw/block/virtio-blk.c#L1183
> 
> and the value we set to the qemu block layer - bs->bl.write_granularity,
> which file-posix initilizes using:
> https://github.com/qemu/qemu/blob/v11.1.0-rc3/block/file-posix.c#L1498-L1501
> the sysfs value for physical_block_size.

If we are using sysfs, I wonder why this code does not simply read:
/sys/block/<disk>/queue/zone_write_granularity
instead.


But that would still be inconsistent with blkcfg.zoned.write_granularity which
is initialized using conf->logical_block_size.


Kind regards,
Niklas

