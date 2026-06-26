Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B41CCDE00E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd5eW-00027Y-09; Fri, 26 Jun 2026 08:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wd5eP-00025v-Lw; Fri, 26 Jun 2026 08:27:18 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wd5eC-000876-BJ; Fri, 26 Jun 2026 08:27:17 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5A1A24345A;
 Fri, 26 Jun 2026 12:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47711F000E9;
 Fri, 26 Jun 2026 12:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782476801;
 bh=0w+UV/aJcbeAChLuaIHR+ffrOkNsj6ZX4J/nnxrxrR8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CY/ALllivROSG1iFlZBdZyGSAD7RAmyM4fZlhOvuFRFsqy/jejd+pK0IXaT3DgOqv
 75AluDbNKTF7edoSPoSkj7ArWh0hjh7uPAF1jq+oNW+TMaZKWDYjozdBvmVWHR5b+1
 a/WJfwknHS6bzFivdzr5CAbwGoVJFt85d+2seAvOJOrlCu6aX7ek5PBOQTKfcZUD/2
 hvtT902e1/c6EvsXLAK+ZRDg3ufLcgktX6K/uIjwqJbhfq6KmMoqqhLlvVJZWm75WG
 qvAIdh9qmF6EP5aEH0rOH9DcCvjuIA6Q9RKHlCHPYmgKpImOrOnFSxFdA78J1IH8pd
 vGCiol7LKVIJg==
Date: Fri, 26 Jun 2026 14:26:36 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 dlemoal@kernel.org, qemu-block@nongnu.org, dmitry.fomichev@wdc.com,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v12 2/5] qcow2: add configurations for zoned format
 extension
Message-ID: <aj5v_GsZyzPSwlPR@ryzen>
References: <20260623184830.373232-1-faithilikerun@gmail.com>
 <20260623184830.373232-3-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623184830.373232-3-faithilikerun@gmail.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=sea.source.kernel.org
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

On Tue, Jun 23, 2026 at 08:48:27PM +0200, Sam Li wrote:
> To configure the zoned format feature on the qcow2 driver, it
> requires settings as: the device size, zone model, zone size,
> zone capacity, number of conventional zones, limits on zone
> resources (max append bytes, max open zones, and max_active_zones).
> 
> To create a qcow2 image with zoned format feature, use command like
> this:
> qemu-img create -f qcow2 zbc.qcow2 -o size=768M \
> -o zone.size=64M -o zone.capacity=64M -o zone.conventional_zones=0 \
> -o zone.max_append_bytes=4096 -o zone.max_open_zones=6 \
> -o zone.max_active_zones=8 -o zone.mode=host-managed
> 
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> Acked-by: Markus Armbruster <armbru@redhat.com> # QAPI schema
> ---
>  block/file-posix.c               |   2 +-
>  block/qcow2.c                    | 335 ++++++++++++++++++++++++++++++-
>  block/qcow2.h                    |  83 +++++++-
>  docs/interop/qcow2.rst           | 120 ++++++++++-
>  include/block/block_int-common.h |  15 +-
>  qapi/block-core.json             |  91 ++++++++-
>  tests/qemu-iotests/082.out       | 126 ++++++++++++
>  7 files changed, 763 insertions(+), 9 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 3c985da94f..ddb159c58b 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -3600,7 +3600,7 @@ raw_co_zone_append(BlockDriverState *bs,
>  
>      if (*offset & zone_size_mask) {
>          error_report("sector offset %" PRId64 " is not aligned to zone size "
> -                     "%" PRId32 "", *offset / 512, bs->bl.zone_size / 512);
> +                     "%" PRId64 "", *offset / 512, bs->bl.zone_size / 512);
>          return -EINVAL;
>      }

I think it would be easier if this change, together with:

> @@ -901,7 +908,13 @@ typedef struct BlockLimits {
>      BlockZoneModel zoned;
>  
>      /* zone size expressed in bytes */
> -    uint32_t zone_size;
> +    uint64_t zone_size;

was in a separate prep patch earlier in this series.

While I understand the logic behind increasing the zone_size to uint64_t
(i.e. to match "struct blk_zone" struct member "len" (representing
zone size) in Linux include/uapi/linux/blkzoned.h), this seems like an
independent change that should be done to the QEMU block layer, that
does not really have anything to do with adding qcow2 zoned support.


Kind regards,
Niklas

