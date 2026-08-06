Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6765BC5AC7A
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 23:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws7x5-0005by-V0; Thu, 06 Aug 2026 19:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1ws7x4-0005bC-7V; Thu, 06 Aug 2026 19:56:42 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1ws7x2-0003gE-4q; Thu, 06 Aug 2026 19:56:41 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5BEF14180D;
 Thu,  6 Aug 2026 23:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40B51F000E9;
 Thu,  6 Aug 2026 23:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786060596;
 bh=JwMHRVJmJRBTdY6mZ4bU29hDJL2Wsm3650wZJEzAfmQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VLQCHGu4L/QHbUjXX9J3Y9+8we4M5IjJMe/MbmYPgOmrK6LXaQhaMrFBr9LAuhMZo
 wkIuny+QrWqCVa7ve60XTHO0yl0S/3CPWRq8NrJILKQQN4OZwUrdxKZ9Ugh3h4RJ3y
 rhAYEGnNROQsO8/AOJNwj61d86v/slXP4LE2YpBtR2oKaH+EYxMyflUiiQy8lpfvVc
 6o+uKYE70q05rU/3V2uZsSR+71yUDBaVRojrrYJ9WqNbiRdkomSFLIihNhT7K/YLYh
 eMpgM8bAUrwAq6X3WI4T5lAGHjhSc41kT4yvr/Ilt4khUAi+2NgU6/rZn8fxI54pKz
 4E9GCgOB/CVGA==
Date: Fri, 7 Aug 2026 01:56:31 +0200
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
Message-ID: <anUfL40CLw_amIJE@ryzen>
References: <20260708221615.346155-1-faithilikerun@gmail.com>
 <20260708221615.346155-4-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708221615.346155-4-faithilikerun@gmail.com>
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

Hello Sam,

On Thu, Jul 09, 2026 at 12:16:12AM +0200, Sam Li wrote:
> @@ -2068,6 +2236,25 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
>      }
>      bs->bl.pwrite_zeroes_alignment = s->subcluster_size;
>      bs->bl.pdiscard_alignment = s->cluster_size;
> +
> +    switch (s->zoned_header.zoned) {
> +    case QCOW2_Z_HM:
> +        bs->bl.zoned = BLK_Z_HM;
> +        break;
> +    case QCOW2_Z_NONE:
> +    default:
> +        bs->bl.zoned = BLK_Z_NONE;
> +        break;
> +    }
> +
> +    bs->bl.nr_zones = s->zoned_header.nr_zones;
> +    bs->bl.max_append_sectors = s->zoned_header.max_append_bytes
> +        >> BDRV_SECTOR_BITS;
> +    bs->bl.max_active_zones = s->zoned_header.max_active_zones;
> +    bs->bl.max_open_zones = s->zoned_header.max_open_zones;
> +    bs->bl.zone_size = s->zoned_header.zone_size;
> +    bs->bl.zone_capacity = s->zoned_header.zone_capacity;
> +    bs->bl.write_granularity = BDRV_SECTOR_SIZE;


Since we are already defining max_append_sectors in the qcow2 extension,
is there a reason not to allow the user to define the write_granularity?

From the virtio spec:
"The size of the data that is appended MUST be a multiple of
write_granularity bytes and MUST NOT exceed the max_append_sectors
value provided by the device in virtio_blk_zoned_characteristics
configuration space structure."

At least for virtio, it seems like they go together.

And if you consider that virtio is a specification that can be implemented
by hardware, somehow I do feel like we should (somehow) be able to make the
backing device (qcow2 in this case) represent the hardware.
And I don't really see the logic to define all the struct members in from
virtio

struct virtio_blk_zoned_characteristics {
	le32 zone_sectors;
	le32 max_open_zones;
	le32 max_active_zones;
	le32 max_append_sectors;
	le32 write_granularity;
	u8 model;
	u8 unused2[3];
} zoned;

except for write_granularity. (I guess we could still default
write_granularity to BDRV_SECTOR_SIZE.)

If we define max_append_sectors in qcow2, I think we should define
write_granularity in qcow2 as well.




Looking at the write_granularity in virtio-blk + file-posix:
for blkcfg.zoned.write_granularity, which is what virtio-blk exposes to
the guest, it is initialized using:
https://github.com/qemu/qemu/blob/v11.1.0-rc3/hw/block/virtio-blk.c#L1257
conf->logical_block_size:
https://github.com/qemu/qemu/blob/v11.1.0-rc3/hw/block/virtio-blk.c#L1183

and the value we set to the qemu block layer - bs->bl.write_granularity,
which file-posix initilizes using:
https://github.com/qemu/qemu/blob/v11.1.0-rc3/block/file-posix.c#L1498-L1501
the sysfs value for physical_block_size.


Sam, you seem to be the author of the code for both assignments.
It seems inconsistent that one uses the logical block size and one uses
the physical block size. I could send a patch for this if we know which
one to use. I assume that using the logical block size in both places
makes most sense for writes (even if it would be a read-modify-write),
but the physical block size makes most sense for zone appends...
Damien, thoughts?

There are some ZAC drives that support 512e, but they obviously don't
support zone append.




Trying to understand how qemu deals with other hardware limits:

logical_block_size and physical_block_size are parameters for the
virtio-blk-pci device, rather than the qcow2 blockdev.

E.g.
-drive file=vm-disk.qcow2,format=qcow2,if=none,id=hd0 \
-device virtio-blk-pci,drive=hd0,logical_block_size=4096,physical_block_size=4096

for a 4K native device.


Looking at the qcow2 driver, we can see that it does not set
bs->bl.request_alignment in the normal case (only if using crypto).

Looking at the file-posix driver, it does probe the logical block
size of the backing device (using ioctls()) and stores it in
bl.request_alignment.


The virtio-blk driver does have a check:
virtio_blk_sect_range_ok() where it will fail any request where the
size is not aligned to the logical block size, so I guess it is fine
that the qcow2 driver does not initialize bs->bl.request_alignment.

Perhaps we should modify check_zoned_request() to also check if
the len is a multiple of the logical block size?

Without such a check, for a 4Kn device (physical block size == 4K,
logical block size == 4K), with write_granularity unconditionally set to
BDRV_SECTOR_SIZE (512) (like the qcow2 driver seems to do), I think we
would be able to append less than a logical block, which seems wrong.

(This is not a problem right now since file-posix.c does initialize
bs->bl.write_granularity using the sysfs value for physical_block_size
and not a hardcoded 512 value.)


Kind regards,
Niklas

