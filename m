Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9D6C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 06:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwvqi-0006P9-MO; Thu, 20 Aug 2026 02:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wwvqg-0006Nv-7c; Thu, 20 Aug 2026 02:01:58 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wwvqd-00089V-KF; Thu, 20 Aug 2026 02:01:57 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F27F343E1F;
 Thu, 20 Aug 2026 06:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A051F00A3A;
 Thu, 20 Aug 2026 06:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787205710;
 bh=KAGV2+sQFuqVpE+Hxk8LI28AYB2tToBqeacDQcA5NYc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=h7S5RHCrxJSnYy/ewYrcFqt9x8A+ZSHnS6BdeMI/JoB17aH7RTH7Sikxp4418LcJO
 1RO0m6Kp6MGIHs+ifYO82wFGjuLo/yskbMrIUw0e4y/3ALT/ZnD396RS8uUBgOyrOu
 rhwRQEka/d8DOLPFsPEizvkiYytopSdDgHuOQbJbO1MtZeyOgtyG4dqVuBZXoOWk0q
 S0Zknl+e1jSrX8TrhvKe2kNyAZbyMg8K+AKkSGsQT3O20DTSiLyihhlLGaUHNZlLs7
 bs7m9XtsT4Mvs3tU4VCJpEFnN2pD/ajrmqF4YCsVOwc6VwIiXG2asLXFlUdwBiBbPL
 BoBJDSfk1x4mA==
Message-ID: <faaa67f5-5e9d-479b-9784-ebbe05c020ea@kernel.org>
Date: Thu, 20 Aug 2026 15:01:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] virtio-blk: report the effective zone write
 granularity
To: Niklas Cassel <cassel@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20260819191031.3001633-1-cassel@kernel.org>
 <20260819191031.3001633-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260819191031.3001633-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=dlemoal@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On 8/20/26 04:10, Niklas Cassel wrote:
> For ZBC/ZAC devices the write granularity is the physical block size, so
> a 512e SMR disk exposed through a host_device backend has a logical block
> size of 512 and a zone write granularity of 4096. We told the driver 512
> while raw_co_zone_append() rejects anything that is not 4096 byte
> aligned, so the driver saw a plain I/O error for a request it had been
> told was valid.
> 
> Report the larger of the backend granularity and the logical block size
> instead. The driver cannot issue writes finer than the logical block
> size, so the larger of the two is the constraint that applies. This
> matches what a Linux guest derives for itself: blk_validate_zoned_limits()
> raises zone_write_granularity to the logical block size, and
> blk_stack_limits() stacks it with max().
> 
> Add it as a helper and use it for the zone append offset check in
> check_zoned_request(), which validated against bs->bl.write_granularity,
> so that the value reported to the driver and the value that requests are
> validated against cannot drift apart. The helper cannot return zero
> because blkconf_blocksizes() always leaves a logical block size behind,
> so the check no longer needs to guard against an unset granularity.
> 
> Fixes: 4f7366506a96 ("virtio-blk: add zoned storage emulation for zoned devices")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  hw/block/virtio-blk.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 6b92066aff..ef5581c1e6 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -478,6 +478,18 @@ typedef struct ZoneCmdData {
>      };
>  } ZoneCmdData;
>  
> +/*
> + * The write granularity that the device reports to the driver in
> + * virtio_blk_zoned_characteristics: the offset and size alignment constraint
> + * for writes and zone appends to sequential zones.
> + */
> +static uint32_t virtio_blk_write_granularity(VirtIOBlock *s)
> +{
> +    BlockDriverState *bs = blk_bs(s->blk);
> +
> +    return MAX(bs->bl.write_granularity, s->conf.conf.logical_block_size);
> +}
> +
>  /*
>   * check zoned_request: error checking before issuing requests. If all checks
>   * passed, return true.
> @@ -500,11 +512,11 @@ static bool check_zoned_request(VirtIOBlock *s, int64_t offset, int64_t len,
>      }
>  
>      if (append) {
> -        if (bs->bl.write_granularity) {
> -            if ((offset % bs->bl.write_granularity) != 0) {
> -                *status = VIRTIO_BLK_S_ZONE_UNALIGNED_WP;
> -                return false;
> -            }
> +        uint32_t wg = virtio_blk_write_granularity(s);
> +
> +        if ((offset % wg) != 0) {

	   if (offset & (wg - 1)) }

is more efficient. logical/physical block sizes are always power of 2s.

> +            *status = VIRTIO_BLK_S_ZONE_UNALIGNED_WP;
> +            return false;
>          }
>  
>          index = offset / bs->bl.zone_size;
> @@ -1254,7 +1266,8 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>                       bs->bl.max_active_zones);
>          virtio_stl_p(vdev, &blkcfg.zoned.max_open_zones,
>                       bs->bl.max_open_zones);
> -        virtio_stl_p(vdev, &blkcfg.zoned.write_granularity, blk_size);
> +        virtio_stl_p(vdev, &blkcfg.zoned.write_granularity,
> +                     virtio_blk_write_granularity(s));
>          virtio_stl_p(vdev, &blkcfg.zoned.max_append_sectors,
>                       bs->bl.max_append_sectors);
>      } else {


-- 
Damien Le Moal
Western Digital Research

