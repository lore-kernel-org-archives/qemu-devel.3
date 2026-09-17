Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FA9C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8eD8-0002uY-Ug; Mon, 21 Sep 2026 09:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eD7-0002u3-8c
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eD5-0002mZ-Rn
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789997851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XCCSjz3f+GhASrKeTJR9IQMS2KQPkbpr9+0hGiR4LpE=;
 b=A5/l+K/pGbLzW6H/mihZDsQvcxfXN+T+jHun03iCNb/Ve9Hv2W2VbfrwxltpT0O+wNQVzS
 02/3Ke6Ve9DW/NnsgfdwMXlRl30nArDldnMQmJyY0t0NnaBiba86Nr4b2zOaeyhZq5XeaB
 Qk2of57RDYxPDcSbU+ESGjPXYUch8SU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-iU1pYozyNsC_ECaUJUrVbw-1; Mon,
 21 Sep 2026 09:37:27 -0400
X-MC-Unique: iU1pYozyNsC_ECaUJUrVbw-1
X-Mimecast-MFC-AGG-ID: iU1pYozyNsC_ECaUJUrVbw_1789997845
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49A371977035; Mon, 21 Sep 2026 13:37:25 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC4791956089; Mon, 21 Sep 2026 13:37:24 +0000 (UTC)
Date: Thu, 17 Sep 2026 12:03:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 10/12] virtio-blk: derive the maximum zone append size
Message-ID: <20260917160339.GN162769@fedora>
References: <20260907110748.1868714-1-cassel@kernel.org>
 <20260907110748.1868714-11-cassel@kernel.org>
 <20260909185247.GJ20134@fedora> <aqsHK1AeZ_q34TMb@ryzen>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lOXQOJOEQDAXF3fD"
Content-Disposition: inline
In-Reply-To: <aqsHK1AeZ_q34TMb@ryzen>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_48_96=1,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--lOXQOJOEQDAXF3fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:16:27PM +0200, Niklas Cassel wrote:
> On Wed, Sep 09, 2026 at 02:52:47PM -0400, Stefan Hajnoczi wrote:
> > On Mon, Sep 07, 2026 at 01:07:45PM +0200, Niklas Cassel wrote:
> > > @@ -1313,7 +1330,7 @@ static void virtio_blk_update_config(VirtIODevi=
ce *vdev, uint8_t *config)
> > >          virtio_stl_p(vdev, &blkcfg.zoned.write_granularity,
> > >                       blkconf_zone_write_granularity(conf));
> > >          virtio_stl_p(vdev, &blkcfg.zoned.max_append_sectors,
> > > -                     bs->bl.max_append_sectors);
> > > +                     virtio_blk_max_append_sectors(s));
> >=20
> > This has the same issue as the write_granularity patch earlier in this
> > patch series, except that max_append_sectors was already exposing the
> > BlockBackends BlockLimits, which we shouldn't do.
>=20
> If we can't derive it from any field in bs->blk, then the best thing I can
> think of (that hay precedence) is to add a virtio-blk property:
>=20
> DEFINE_PROP_UINT32("max-append-sectors", VirtIOBlock,
>                    conf.max_append_sectors, BDRV_REQUEST_MAX_SECTORS),
>=20
> Since it is very similar to the existing virtio-blk properties:
>=20
>     DEFINE_PROP_UINT32("max-discard-sectors", VirtIOBlock,               =
      =20
>                        conf.max_discard_sectors, BDRV_REQUEST_MAX_SECTORS=
),    =20
>     DEFINE_PROP_UINT32("max-write-zeroes-sectors", VirtIOBlock,          =
      =20
>                        conf.max_write_zeroes_sectors, BDRV_REQUEST_MAX_SE=
CTORS),
>=20
>=20
>=20
> However, your argument reaches beyond this patch:
> zoned.model, zone_sectors, max_open_zones and max_active_zones are all
> read from bs->bl in virtio_blk_update_config(), and VIRTIO_BLK_F_ZONED
> itself is set from bs->bl.zoned at realize.
>=20
> Should I just let them be?
>=20
> Seems out of scope of this series, but following your argument, I'm
> wondering if they shouldn't have been virtio-blk properties as well.

I agree it's out of scope. Feel free to leave it.

How I think about block limits and migration:

Explicit properties make sense where live migration is possible across
different values. Migrating across changing zoned.model, zone_sectors,
max_open_zones, max_active_zones is very hard or impossible, so directly
exposing values from the host is fine here.

Looking at max_append_sectors from that perspective, an explicit
property enables migration from a source host with a lower
max_append_sectors to a destination host with a higher
max_append_sectors. So a property would be appropriate, I think.

Stefan

--lOXQOJOEQDAXF3fD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqsD1sACgkQnKSrs4Gr
c8g6kQf+IKLbpVoIbLA2Dhe3dy6kiCAj2INV33Zyv99eItuMp5362cdRPGWiqs5Q
YR8lM1CPcUjJwDnwjv7GJR44mtWZPWy4coePDKcMWdVAOt+jeq5GXh2FZ3mDig7Q
ITFMVTHQf1BuzjauruI48bH8MRuOoxbJgVooC0CKWP87dvjbG6sPmeoxJFo00btt
0TPswPla/sWgZgoFdButXJjHBshD1zJQ776HBjqwKKdpggZEAsiz858WLwQusLXg
EcnGimGuYOyxc9BKljbO06hY0YSanY6oP3xZ+7w+k+c8PzS9c2t79YYnPDbaDDy6
1TfcmlBtTnkPu5aEdqv0vpz/tVy8YA==
=7zv5
-----END PGP SIGNATURE-----

--lOXQOJOEQDAXF3fD--


