Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EABEC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6vtk-0003Da-8w; Wed, 16 Sep 2026 16:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x6vth-0003Cp-8R; Wed, 16 Sep 2026 16:06:25 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x6vte-000708-SX; Wed, 16 Sep 2026 16:06:25 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 43D68601EF;
 Wed, 16 Sep 2026 20:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7251F000FF;
 Wed, 16 Sep 2026 20:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789589173;
 bh=YGuP/gAN5ygsx2j5cjpwIXtDRIjDeLDtv8WvQN5Rl+Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EI664whNbZvXK8AYgfjuCn8aqKfw+Yu4HXCVo58+1Ym3gLx1NRJHSOliiI5OOQ+Ck
 a7Zu50+WUKVdYReLG7OE4PRYk+unF/WCsX7khRwzlA2X7qVZ2BGMqG5CS4J1xV4K4r
 i2SzYyqb/mn2z/HLSkwRQFgu5cRhmATxwXgyKNwyAKGE5K0PABUNm7A2JXNZEn6APU
 iZfqE/rkrIDDPbrTn2fxmHj/09bP0ogOk/x9fluUX7IR9sjUMDdm/xlRJKqqpewryc
 e3yRXH+mEcKzF6hu6MxW5A3xet32+3XVMAuCoK4e+90uyivx9HV4kwdffrjYCp5jKf
 +6ROz9i26zbjQ==
Date: Wed, 16 Sep 2026 22:06:07 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 04/12] virtio-blk: report the effective zone write
 granularity
Message-ID: <aqr2r83GkqmujyUG@ryzen>
References: <20260907110748.1868714-1-cassel@kernel.org>
 <20260907110748.1868714-5-cassel@kernel.org>
 <20260909182755.GC20134@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909182755.GC20134@fedora>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Sep 09, 2026 at 02:27:55PM -0400, Stefan Hajnoczi wrote:
> On Mon, Sep 07, 2026 at 01:07:39PM +0200, Niklas Cassel wrote:
> > @@ -1274,7 +1274,8 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
> >                       bs->bl.max_active_zones);
> >          virtio_stl_p(vdev, &blkcfg.zoned.max_open_zones,
> >                       bs->bl.max_open_zones);
> > -        virtio_stl_p(vdev, &blkcfg.zoned.write_granularity, blk_size);
> > +        virtio_stl_p(vdev, &blkcfg.zoned.write_granularity,
> > +                     blkconf_zone_write_granularity(conf));
> >          virtio_stl_p(vdev, &blkcfg.zoned.max_append_sectors,
> >                       bs->bl.max_append_sectors);
> >      } else {
> 
> The device emulation code cannot expose the limit value from the host
> device because that would break live migration: a guest device must
> remain unchanged across migration and the VIRTIO Configuration Space
> cannot change field values if the source and destination hosts have
> different disks. The guest driver does not expect these values to
> change once the device has been probed.
> 
> For example, it would be possible to migrate from a host with a write
> granularity of 64 KB to a host with a write granularity of 4 KB. The
> guest must still see a 64 KB write granularity the entire time (even
> after migration).
> 
> For this reason, limits on guest devices must be configured explicitly
> rather than automatically populated from the host device limits.

Sure, this can easily be implemented as:

MAX(conf->logical_block_size, conf->physical_block_size)

which is a pure function of the device configuration.


> 
> Could you implement an error when the guest limit has not been
> configured appropriately for the given BlockBackend instead?

Will do.


Kind regards,
Niklas

