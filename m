Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D89BC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4N1r-0002ip-Vq; Wed, 09 Sep 2026 14:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4N1q-0002iT-FN
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:28:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4N1f-00043r-NC
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788978482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7HpqzRohQ/5lxSz9xoGDQstKFUvKFhUCE35ZoRttZq0=;
 b=inTWfqHaT7DksaHruj5nflDs9mtTxlxObaDXAOPslPEnoP/o/+GPUoSTWWmq+sYgm5V0yU
 xf7U1WxrNgLMCVnPOfs/SxplS4ZrcOh6PfTtr/It99o8Mdtc8HceHRaZDWayjLoKebyVT6
 OW2swXmEq+2TUmmADVkv5/XKsNxbgLU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-Vfza8hGoOHmnd7bMwqWxRg-1; Wed,
 09 Sep 2026 14:27:59 -0400
X-MC-Unique: Vfza8hGoOHmnd7bMwqWxRg-1
X-Mimecast-MFC-AGG-ID: Vfza8hGoOHmnd7bMwqWxRg_1788978477
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CF6C180067A; Wed,  9 Sep 2026 18:27:57 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C6F11955F19; Wed,  9 Sep 2026 18:27:56 +0000 (UTC)
Date: Wed, 9 Sep 2026 14:27:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 04/12] virtio-blk: report the effective zone write
 granularity
Message-ID: <20260909182755.GC20134@fedora>
References: <20260907110748.1868714-1-cassel@kernel.org>
 <20260907110748.1868714-5-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QqDLHnxMkRLtXKO1"
Content-Disposition: inline
In-Reply-To: <20260907110748.1868714-5-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--QqDLHnxMkRLtXKO1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 07, 2026 at 01:07:39PM +0200, Niklas Cassel wrote:
> @@ -1274,7 +1274,8 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>                       bs->bl.max_active_zones);
>          virtio_stl_p(vdev, &blkcfg.zoned.max_open_zones,
>                       bs->bl.max_open_zones);
> -        virtio_stl_p(vdev, &blkcfg.zoned.write_granularity, blk_size);
> +        virtio_stl_p(vdev, &blkcfg.zoned.write_granularity,
> +                     blkconf_zone_write_granularity(conf));
>          virtio_stl_p(vdev, &blkcfg.zoned.max_append_sectors,
>                       bs->bl.max_append_sectors);
>      } else {

The device emulation code cannot expose the limit value from the host
device because that would break live migration: a guest device must
remain unchanged across migration and the VIRTIO Configuration Space
cannot change field values if the source and destination hosts have
different disks. The guest driver does not expect these values to
change once the device has been probed.

For example, it would be possible to migrate from a host with a write
granularity of 64 KB to a host with a write granularity of 4 KB. The
guest must still see a 64 KB write granularity the entire time (even
after migration).

For this reason, limits on guest devices must be configured explicitly
rather than automatically populated from the host device limits.

Could you implement an error when the guest limit has not been
configured appropriately for the given BlockBackend instead?

Stefan

--QqDLHnxMkRLtXKO1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqhpSsACgkQnKSrs4Gr
c8gjIgf/VDY9BopxrQFvHMeU7rNaeQYDJbkghvQYv6CxwYiKhdi2kk+HaOotV0Rk
NsNLDjvprHchuNV31mw8dli3h/1/rVAQeK2vPPHiioTO4nt7Urps6R2yKYXpPy1m
VKBnc0IMFzXNsrMhm38mu20DNfQty/IZDDP4CBwas2/OUrDZBiyLJC2hMebfAFNK
NYnQpM6u9r0hY9wWJRfuzXoxRU8X6ZucSHKyR++dFetklCsTLKa4HI7VIGV3kwLr
T9rImAMu9gEOwjeCeTH+C0nXVa3mhtw3x9tHy+yzGprq5MLqLL4f/0o9omHVnZb1
8921yFcmnG8K/RtTBhEokkpu8cdPbw==
=qBpT
-----END PGP SIGNATURE-----

--QqDLHnxMkRLtXKO1--


