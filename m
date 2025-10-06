Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CFACCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 14:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5mU8-0001pR-Ir; Mon, 06 Oct 2025 10:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v5mTo-0001jb-FV
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v5mTl-0007DP-Ei
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759761974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CZPjZPCWKFBjEcqrTHxuvSIzKfDI0NlWllGoOg3aT4U=;
 b=L8hiI+3noPb69OQNww8gbod0NJFEwvbvu6fxKmb+oi3alrZHgadyQGA+jdsB4Tilx7/W8Z
 5n1+1Ge2MsF0bO04NRFsCHtdsyuhIIqPXJ63Gtr1oMl0q8aOI+L7y4Ev65YooGYokp3WI7
 lxqnswlTcyvsCxyk9F81TMPDra0QfUA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-htYBz3utMZuZyvbj218c9w-1; Mon,
 06 Oct 2025 10:46:13 -0400
X-MC-Unique: htYBz3utMZuZyvbj218c9w-1
X-Mimecast-MFC-AGG-ID: htYBz3utMZuZyvbj218c9w_1759761972
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE9EC180034A; Mon,  6 Oct 2025 14:46:11 +0000 (UTC)
Received: from localhost (unknown [10.2.16.162])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 236A6180035E; Mon,  6 Oct 2025 14:46:10 +0000 (UTC)
Date: Mon, 6 Oct 2025 10:46:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Jean-Louis Dupond <jean-louis@dupond.be>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 1/3] file-posix: populate pwrite_zeroes_alignment
Message-ID: <20251006144609.GA21887@fedora>
References: <20251002184000.410486-1-stefanha@redhat.com>
 <20251002184000.410486-2-stefanha@redhat.com>
 <f4aa2d8a-0bc4-476e-aee0-0770a4bbd396@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IncuC9+/ajPiGfdx"
Content-Disposition: inline
In-Reply-To: <f4aa2d8a-0bc4-476e-aee0-0770a4bbd396@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--IncuC9+/ajPiGfdx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 11:04:38AM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> On 02.10.25 21:39, Stefan Hajnoczi wrote:
> > Linux block devices require write zeroes alignment whereas files do not.
> >=20
> > It may come as a surprise that block devices opened in buffered I/O mode
> > require the alignment although regular read/write requests do not.
> >=20
> > Therefore it is necessary to populate the pwrite_zeroes_alignment field.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   block/file-posix.c | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> >=20
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 8c738674ce..05c92c824d 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -1602,6 +1602,23 @@ static void raw_refresh_limits(BlockDriverState =
*bs, Error **errp)
> >               bs->bl.pdiscard_alignment =3D dalign;
> >           }
> > +
> > +#ifdef __linux__
> > +        /*
> > +         * When request_alignment > 1, pwrite_zeroes_alignment does no=
t need to
> > +         * be set explicitly. When request_alignment =3D=3D 1, it must=
 be set
> > +         * explicitly because Linux requires logical block size alignm=
ent.
> > +         */
> > +        if (bs->bl.request_alignment =3D=3D 1) {
>=20
> would "if (!s->needs_alignment) {" be a more visual check? This way reade=
r will not have to analyze
> raw_probe_alignment, and understand that needs_alignment=3Dfalse is the o=
nly path for block device
> to have request_alignment=3D=3D1.

Yes, that would make it easier to understand. Thanks!

>=20
> > +            ret =3D probe_logical_blocksize(s->fd,
> > +                                          &bs->bl.pwrite_zeroes_alignm=
ent);
> > +            if (ret < 0) {
> > +                error_setg_errno(errp, -ret,
> > +                                 "Failed to probe logical block size");
> > +                return;
> > +            }
> > +        }
> > +#endif /* __linux__ */
> >       }
> >       raw_refresh_zoned_limits(bs, &st, errp);
>=20
>=20
> --=20
> Best regards,
> Vladimir
>=20

--IncuC9+/ajPiGfdx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjj1jEACgkQnKSrs4Gr
c8jfzwf+JKiNm2E4ST0w0yltOxrV2na5rwX5eLATyYmfqB7iSX0WJJgDIN4Q22Qk
hbkirOuuVj15uBjZNdgI8zKCDpX2/MD2SGbB5Nu8FMcANJqIn6eENirpDrnhf7FQ
py7s6YGPyfNedKAo2OEFamfm6NhpSlYKX6mMgW0w8U7b7riRcoTh/CT71k+D/DUm
0bB0yYsW6Cdj1DFn4P9AvBtzmm1XVP7uoL10wuHZsf58f+FQ4zw8Z8u1JzkwM87W
i/KHGa/uUfGOnvWdP5lR0bJtFwiHnk+j3QuDKpiLuU48sURCjqWJVQTfd3XDT2BP
mhl7TH9bmqeASK3Rf0QHE4cVT3AIDQ==
=P0De
-----END PGP SIGNATURE-----

--IncuC9+/ajPiGfdx--


