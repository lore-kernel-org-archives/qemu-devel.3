Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65081ECD984
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1js-0004Zv-Co; Thu, 05 Feb 2026 10:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vo1jp-0004ZL-VU
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:57:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vo1jl-0008G0-FM
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:57:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770307064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rnef7B8v4j4es0Ww/agLLTWFcDAlbIZAHUvulO7nJnA=;
 b=FvdUfRxn9Znp+v/YgSsbLoUK9VClcXTBNxs0uuK2apG/eMlJCHgGftuiViTAo7zdiv4qrN
 Q7KC9a0PG3DpXCaq6mzbZkp4PnrD5wkANc1fCo76QmmSl2weINNsxWnmUf8811e5MUb8Ru
 96w/3O0i3krsRMWahH0Zzow9qSWpd1E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-B0bDrLJfOrmsMywXoVGEMg-1; Thu,
 05 Feb 2026 10:57:41 -0500
X-MC-Unique: B0bDrLJfOrmsMywXoVGEMg-1
X-Mimecast-MFC-AGG-ID: B0bDrLJfOrmsMywXoVGEMg_1770307060
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B77811800464; Thu,  5 Feb 2026 15:57:39 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.198])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 351C718004BB; Thu,  5 Feb 2026 15:57:36 +0000 (UTC)
Date: Thu, 5 Feb 2026 16:57:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, hreitz@redhat.com, fam@euphon.net
Subject: Re: [PATCH 4/6] block/io: safeguard max transfer calculation in
 bdrv_aligned_pwritev()
Message-ID: <aYS97vFFCkVLKLdV@redhat.com>
References: <20260109120837.2772961-1-f.ebner@proxmox.com>
 <20260109120837.2772961-5-f.ebner@proxmox.com>
 <20260119193452.GC834718@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GnzmQQuJbf8TLTvW"
Content-Disposition: inline
In-Reply-To: <20260119193452.GC834718@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--GnzmQQuJbf8TLTvW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 19.01.2026 um 20:34 hat Stefan Hajnoczi geschrieben:
> On Fri, Jan 09, 2026 at 01:08:31PM +0100, Fiona Ebner wrote:
> > This partially fixes iotest 177 with qcow2, where max_transfer is
> > 64KiB, but the cluster size and thus pwrite_zeroes_alignment is 1MiB.
> > Previously, max_transfer would be calculated as 0, triggering an
> > assertion later.
> >=20
> > Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> > ---
> >  block/io.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/block/io.c b/block/io.c
> > index 12dc153573..233b2617ea 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -2087,8 +2087,10 @@ bdrv_aligned_pwritev(BdrvChild *child, BdrvTrack=
edRequest *req,
> >      assert(is_power_of_2(align));
> >      assert((offset & (align - 1)) =3D=3D 0);
> >      assert((bytes & (align - 1)) =3D=3D 0);
> > -    max_transfer =3D QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer,=
 INT_MAX),
> > -                                   align);
> > +    max_transfer =3D MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX);
> > +    if (max_transfer > align) {
> > +        max_transfer =3D QEMU_ALIGN_DOWN(max_transfer, align);
> > +    }
>=20
> max_transfer < align seems paradoxical. It's a situation where the
> largest allowed I/O request cannot meet alignment requirements.
>=20
> Every other place that uses max_transfer in QEMU would also need to cope
> with this.
>=20
> block/blkdebug.c:blkdebug_open() fails if max_transfer is not aligned,
> indicating that there are assumptions at least in some places that
> max_transfer is aligned.
>=20
> I hesitate to make this change because I fear it will break more things.
> Why was max_transfer 64KB while pwrite_zeroes_alignment was 1MiB? Either
> max_transfer should fit the alignment or pwrite_zeroes code needs to
> distinguish between actual write zeroes operations and read-write-modify
> I/O (which is plain read/write and not subject to
> pwrite_zeroes_alignment).

I don't think haing a 64k max_transfer for normal I/O where data is
actually transferred and much larger write_zeroes requests should be
inherently incompatible.

In fact, in this specific case, I'm wondering how we even hit a
problematic case where align =3D=3D pwrite_zeroes_alignment, but
max_transfer is still used. Shouldn't we take the BDRV_REQ_ZERO_WRITE
code path, which leaves max_transfer completely unused?

Do we somehow end up with normal writes using pwrite_zeroes_alignment?
Ah, yes. This seems to be a problem with patch 3. It doesn't consider
that bdrv_co_do_zero_pwritev() deals both with write_zeroes requests
(for the bulk in the middle) and with normal writes for the padding,
which require different alignments. So changing 'align' for all calls
seems wrong, it should probably be only for those requests that keep the
BDRV_REQ_ZERO_WRITE flag set.

Kevin

--GnzmQQuJbf8TLTvW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmmEve4ACgkQfwmycsiP
L9a2+w/+Jmf3VEVknwM3ghoCnhTZ5b8WgYeRoui/lEYJ0gmJcuE9CCAQglTfSMMQ
Lg9m1ySZb7qZ9YlthTCuLbsqq6XpU8pexvRC0SSQk8nGtAaaX1C6R0MSke6K5wpD
D4U5BoGC0Z+T5XISrPGjt2xumGXdp4TwT1FoFb6HTVJzRtL4nsSFr3UsWPtzhu74
t150NtEF4JOGPYpbquRoqWS7LGUolC/emJiLiRC8Lt8Kkvi10ay6hw5OKFNnfpY8
Kdo7ILq/oCX8k5uaOQlDh0om+U+Z6zXs1K57tOuvD793/wsqor/E/A0b0yqID7cc
i0KOsOJ8m77LYdghNn25WveFgf7XxlindBhHACUvvN4Oyeaum7aEmtLS1rXuo5WS
TNkMTbqwbBr9LYchBXcABdxT43Fed+qW8WZBuHy9DkJiVXBJwWIddtxBl0P/o6l8
9VxbaSVvnx1hTjLXxE7uH/DSW/+PxuMQs4MKwIV+zdD/Oa4W0C9BzgnQ6549C4Cr
N6zivWCJvRu6O1h9JalekVElMDy/oU+AXm1B/fjj8ulMSfccI3rqlt0n7PTR4H4O
havLs6HkdrHvi0ZU9R269kFo6rIcFAHabBqtbLKTYnqS9ERcrEhP5tVn3OgDsS4h
6BCtjGzUNk8haqzoPDWZtSodCVfRUr5e3tlWF9qh5447tpkkczw=
=VBBd
-----END PGP SIGNATURE-----

--GnzmQQuJbf8TLTvW--


