Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5501ECDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd4oO-0003qz-MA; Fri, 26 Jun 2026 07:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wd4oL-0003oy-7N; Fri, 26 Jun 2026 07:33:29 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wd4oJ-0003h6-JG; Fri, 26 Jun 2026 07:33:28 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 778D4600AE;
 Fri, 26 Jun 2026 11:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801D01F000E9;
 Fri, 26 Jun 2026 11:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782473603;
 bh=sS93TaCKFRhG8OrwWdEQm2ONk3STYP7SPWWd38Fif5E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aEVjNeW2RpgEk1ll9am90HVh+p0jhvZG9NAQO2qjgOCczKNPtxXAX+xSSTGUL5D/0
 jPpbBWnBwwtrzSTxdoq0bD5DQTN26Ugm2UOmzcmU4H53OgXlzCNbJaVRWYmWJt+92K
 huzGNF/2Orp89lRmyzlBnob2jNcS+f5PoamQmoHDRaXcZ5wp7zdykqC96g73UJ5n8K
 LFXp+ikLx7aHwyG5Gj1yh1klTYG6qqoA+9FuONRce8zuHLYZl47wegE/VNCE/7hreR
 n+z6YKXteDWiObSTCoG/qoUnobrEq1F+wtl7oL1t7qxaDsEbDZQeFvjKCMljA5/4oB
 zg2M3s/T+7xqA==
Date: Fri, 26 Jun 2026 13:33:17 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 dlemoal@kernel.org, qemu-block@nongnu.org, dmitry.fomichev@wdc.com,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v12 0/5] Add full zoned storage emulation to the qcow2
 driver
Message-ID: <aj5jfQ90ej74tAB-@ryzen>
References: <20260623184830.373232-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623184830.373232-1-faithilikerun@gmail.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Hello Sam,

Again, thank you so much for spending your spare time on this!

On Tue, Jun 23, 2026 at 08:48:25PM +0200, Sam Li wrote:
> This patch series add a new extension - zoned format - to the
> qcow2 driver, allowing full zoned storage emulation on a qcow2
> image file. A user can attach such an image to a guest and have
> it appear as a host-managed zoned block device.
> 
> The zoned format is opt-in through a new qcow2 header extension
> that pins the zone geometry. Behind the extension is a dedicated
> zoned metadata region that stores one 8-byte write pointer (WP)
> per zone. The extension is gated by an incompatible bit, so an
> older qcow2 implementation cannot accidentally open the image.
> 
> Each write pointer is routed through the write pointer cache,
> a Qcow2Cache object. The write pointer cache is written to disk
> after the qcow2 metadata is written, thus guaranteeing that
> the write pointer is updated after the corresponding data is
> written.
> 
> Zone states are in memory. Read-only and offline states are
> device-internal events, which are not modelled in qcow2
> emulation for simplicity. The other zone states
> (closed, empty, full) can be inferred from write poiner
> values, presistent across QEMU reboots. The open states are
> kept in memory using open zone lists.
> 
> To create a qcow2 file with the zoned format:
> 
>     qemu-img create -f qcow2 zbc.qcow2 \
>         -o size=768M \
>         -o zone.size=64M \
>         -o zone.capacity=64M \
>         -o zone.conventional_zones=0 \
>         -o zone.max_append_bytes=4096 \
>         -o zone.max_open_zones=6 \
>         -o zone.max_active_zones=8 \
>         -o zone.mode=host-managed
> 
> Then attach it to a guest via the QEMU command line:
>     -blockdev node-name=drive1,driver=qcow2,\
>               file.driver=file,file.filename=zbc.qcow2 \
>     -device virtio-blk-pci,drive=drive1 \
> 
> v11->v12:
> - validate the zoned header extension before allocating any zoned metadata
> - fix the zoned locking discipline: hold the qcow2 state lock (s->lock)
>   across all zone-state list updates [Stefan]
> - reject, instead of aborting on an assertion, a write that reaches the
>   open-zone limit while every open zone is explicitly open
> - fix reduced-capacity (zone_capacity < zone_size) handling:
>     * transition a zone to FULL when the write pointer reaches the zone
>       capacity
>     * report the zone capacity, not the zone size, in zone_report
> - return -EIO rather than -EINVAL for zone write-rule violations
> - use int64_t for the zoned-metadata cluster offset and zone_size to
>   avoid truncation on large images
> - simplify qcow2_cache_set_dependency() [Stefan]
> - virtio-blk: read the zone size through a new blk_get_zone_size() [Stefan]

> - docs/QAPI: clarify the max_open_zones / max_active_zones /
>   max_append_bytes descriptions; use warn_report() for recoverable zoned
>   configuration values in qcow2_check_zone_options() [Niklas, Stefan]

I'm sorry, but to me, it looks like patch 1/5 in v12 is identical to v11.

Did you perhaps forget to do git add or something?


Kind regards,
Niklas

