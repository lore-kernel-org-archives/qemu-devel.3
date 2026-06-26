Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B6FC43211
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6mB-000655-Mq; Fri, 26 Jun 2026 09:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wd6m9-00064a-Jr; Fri, 26 Jun 2026 09:39:21 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wd6m8-0008Hl-9u; Fri, 26 Jun 2026 09:39:21 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F034A600C8;
 Fri, 26 Jun 2026 13:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642321F000E9;
 Fri, 26 Jun 2026 13:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782481158;
 bh=9ps3lJDWt8ovZzTZYwImYVjxp6WMXdEhzLN65zIy5wc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BcnNuWZPsbt/d28mielfF6vEtSw870W/u6tWZHal83LN9jNFuB2H9Cy52YWwzactH
 j+jOeXdPvSaAT11jtfiORsD2Yeyg/M+6AcknXuhRoU7KuyR5HPpZeygnQIWki0uP5C
 uru+roiTjhazGLUSfaUH9lEK8WatqlwUof8TGk4sq4Cu/6lp29mF3t3XsPaJ32QvbA
 NZNvipacIdvYKCOcfZR+Mpb8xDH4VXRXO0hO5OP1H3sTmuvgV9k4+4N4zqt+KQx/WG
 3eV+csYJYn9WxFsIvyKFWoYcT7frrjGUtPTTRkgqEd9wYn/0Jt+yoPLjerhtpxm67B
 1b7wo9wCza/Ww==
Date: Fri, 26 Jun 2026 15:39:14 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, dlemoal@kernel.org,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v13 2/6] block: widen BlockLimits.zone_size to uint64_t
Message-ID: <aj6BAs_a7aMb1qUO@ryzen>
References: <20260626131555.459792-1-faithilikerun@gmail.com>
 <20260626131555.459792-3-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626131555.459792-3-faithilikerun@gmail.com>
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

On Fri, Jun 26, 2026 at 03:15:51PM +0200, Sam Li wrote:
> The zone-size field in BlockLimits is currently uint32_t, capping
> expressible zone sizes at 4 GiB. Real zoned-device protocols
> like NVMe ZNS allow larger zones. Widen BlockLimits.zone_size to
> uint64_t to match.
> 
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/file-posix.c               | 2 +-
>  include/block/block_int-common.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
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
>  
> diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
> index 147c08155f..7571ed9968 100644
> --- a/include/block/block_int-common.h
> +++ b/include/block/block_int-common.h
> @@ -901,7 +901,7 @@ typedef struct BlockLimits {
>      BlockZoneModel zoned;
>  
>      /* zone size expressed in bytes */
> -    uint32_t zone_size;
> +    uint64_t zone_size;
>  
>      /* total number of zones */
>      uint32_t nr_zones;
> -- 
> 2.53.0
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

