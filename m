Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D6BC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4NPn-0003rl-LQ; Wed, 09 Sep 2026 14:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4NPl-0003rE-Ed
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4NPi-0001R3-Lv
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788979971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x1RN1A7pCndaf/fAAmUccT30Iu3BpIXixf2G5Z718tI=;
 b=PAFXILzdU+hA17gHKW7cEAHFaIyDQlYplRfEWxr2jPLwyd24WWzikHWkNtfCqGn3ES+gZj
 /wH1Fpsj9B1N6SoNMwxjusyFuLuWrBa5+qf/ggBBSwW0msgo4ejnw18+PJqm1EBfMExCNU
 0Co2Sq/WtmYNlOPcPUzSuysJ/Wn6cB8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-R-DCfaMYPHmlXZYqzO7psA-1; Wed,
 09 Sep 2026 14:52:50 -0400
X-MC-Unique: R-DCfaMYPHmlXZYqzO7psA-1
X-Mimecast-MFC-AGG-ID: R-DCfaMYPHmlXZYqzO7psA_1788979969
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05D361956077; Wed,  9 Sep 2026 18:52:49 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E6241956087; Wed,  9 Sep 2026 18:52:47 +0000 (UTC)
Date: Wed, 9 Sep 2026 14:52:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 10/12] virtio-blk: derive the maximum zone append size
Message-ID: <20260909185247.GJ20134@fedora>
References: <20260907110748.1868714-1-cassel@kernel.org>
 <20260907110748.1868714-11-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mHB4KesqQxyLNNCk"
Content-Disposition: inline
In-Reply-To: <20260907110748.1868714-11-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--mHB4KesqQxyLNNCk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2026 at 01:07:45PM +0200, Niklas Cassel wrote:
> The max_append_sectors field of virtio_blk_zoned_characteristics must be
> set by the device to the largest zone append request that can be issued
> to it, and a value of zero tells the guest driver that zone append is not
> supported at all (virtio 1.4, 5.2.5.2). Linux refuses to attach a zoned
> device that reports zero.
>=20
> We pass BlockLimits.max_append_sectors straight through, which makes that
> field mean "zone append unsupported" when it is unset, rather than "this
> backend imposes no limit of its own". Only a backend that has a limit of
> its own has anything to put there.
>=20
> Derive the value instead. A backend limit is honoured when there is one,
> and otherwise the request is bounded by the zone size, since an append
> cannot cross a zone boundary, and by the largest request the block layer
> can carry. The result cannot be zero.
>=20
> A backend that carries out an append itself, rather than passing it to a
> device that has a limit of its own, is the one that knows how large a
> request its implementation can take, so it reports that in
> BlockLimits.max_append_sectors and this does not have to guess at it.
>=20
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  hw/block/virtio-blk.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index c2acf59c6d..131516a167 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -525,6 +525,27 @@ typedef struct ZoneCmdData {
>      };
>  } ZoneCmdData;
> =20
> +/*
> + * The maximum zone append data size that the device reports to the driv=
er in
> + * virtio_blk_zoned_characteristics, in 512 byte sectors.
> + *
> + * A backend that has no limit of its own leaves BlockLimits.max_append_=
sectors
> + * at zero, in which case the limit is whatever else bounds the request:=
 an
> + * append cannot cross a zone boundary, and the block layer cannot carry=
 a
> + * larger one. The result is never zero, which the driver would read as =
zone
> + * append not being supported at all.
> + */
> +static uint32_t virtio_blk_max_append_sectors(VirtIOBlock *s)
> +{
> +    BlockDriverState *bs =3D blk_bs(s->blk);
> +    uint64_t sectors;
> +
> +    sectors =3D MIN_NON_ZERO(bs->bl.zone_size >> BDRV_SECTOR_BITS,
> +                           bs->bl.max_append_sectors);
> +
> +    return MIN_NON_ZERO(sectors, BDRV_REQUEST_MAX_SECTORS);
> +}
> +
>  /*
>   * check zoned_request: error checking before issuing requests. If all c=
hecks
>   * passed, return true.
> @@ -560,12 +581,8 @@ static bool check_zoned_request(VirtIOBlock *s, int6=
4_t offset, int64_t len,
>              return false;
>          }
> =20
> -        if (len / 512 > bs->bl.max_append_sectors) {
> -            if (bs->bl.max_append_sectors =3D=3D 0) {
> -                *status =3D VIRTIO_BLK_S_UNSUPP;
> -            } else {
> -                *status =3D VIRTIO_BLK_S_ZONE_INVALID_CMD;
> -            }
> +        if ((len >> BDRV_SECTOR_BITS) > virtio_blk_max_append_sectors(s)=
) {
> +            *status =3D VIRTIO_BLK_S_ZONE_INVALID_CMD;
>              return false;
>          }
>      }
> @@ -1313,7 +1330,7 @@ static void virtio_blk_update_config(VirtIODevice *=
vdev, uint8_t *config)
>          virtio_stl_p(vdev, &blkcfg.zoned.write_granularity,
>                       blkconf_zone_write_granularity(conf));
>          virtio_stl_p(vdev, &blkcfg.zoned.max_append_sectors,
> -                     bs->bl.max_append_sectors);
> +                     virtio_blk_max_append_sectors(s));

This has the same issue as the write_granularity patch earlier in this
patch series, except that max_append_sectors was already exposing the
BlockBackends BlockLimits, which we shouldn't do.

>      } else {
>          blkcfg.zoned.model =3D VIRTIO_BLK_Z_NONE;
>      }
> --=20
> 2.55.0
>=20

--mHB4KesqQxyLNNCk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqhqv8ACgkQnKSrs4Gr
c8i4gwf/R2SAunYfeax354pntEXUvLtAtU3G4/Y3UUOrIjkw0SllUO37vOc3Yayf
N62gap5Kwgu6wPP+dyJ2d2hUcZMe9aWjtA0PXefB8KlUCg6cWV0lJXq2GZjZmtaQ
pZayJ+qJ6wxkWqX7azil7iOKdBR1/MxnN7VTdpuZrmPte2c7w+h/ZqsHQ+I2HCif
lKV6gNzOcKVSW+k/ofaevebAhmur7IQy8b/K3Rujb9O0ApZM66yBUrmTQhLZnCc8
FtjuNPLXkexYXhnJdYmdddw5mGmpJFXmFUnjT53KZHKCsU1Rbd26u6YC8R/5+CMR
IcriClr8vrNXhM7PbOfXeDY53dIo6Q==
=d6ra
-----END PGP SIGNATURE-----

--mHB4KesqQxyLNNCk--


