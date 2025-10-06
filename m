Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49206CCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 14:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5meY-0005qD-HY; Mon, 06 Oct 2025 10:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v5meW-0005p4-7q
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:57:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v5meQ-0000gS-HW
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759762638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BCgRBQFXfxAF5k43LBoscuobg/QwdG7u0Jx9zHfItK4=;
 b=EzMbgVaHX7sFMG88Nw/mzGCAprmb2TGVraPc6eRInToPzHDT+CsINnXt+cq7EUaD69H7uM
 GOglupqRX2sA9Ood6ZlBkGQFdEZxg63n8a2F4ulit91rp8yurfHzSWzphsiMlnJjzST8lg
 wpf+RgTbWI8Kjtl+IAKPO1D9MflN8T0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-O5Jf_zskPCSaO6iZDu6qRQ-1; Mon,
 06 Oct 2025 10:57:14 -0400
X-MC-Unique: O5Jf_zskPCSaO6iZDu6qRQ-1
X-Mimecast-MFC-AGG-ID: O5Jf_zskPCSaO6iZDu6qRQ_1759762633
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50B7719560B8; Mon,  6 Oct 2025 14:57:13 +0000 (UTC)
Received: from localhost (unknown [10.2.16.162])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 299C430002CC; Mon,  6 Oct 2025 14:57:11 +0000 (UTC)
Date: Mon, 6 Oct 2025 10:57:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Jean-Louis Dupond <jean-louis@dupond.be>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 1/3] file-posix: populate pwrite_zeroes_alignment
Message-ID: <20251006145710.GB21887@fedora>
References: <20251002184000.410486-1-stefanha@redhat.com>
 <20251002184000.410486-2-stefanha@redhat.com>
 <dd50f99b-03d3-44ca-9f79-dde3dff1c3d4@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TP9HXYLStPp8I3s9"
Content-Disposition: inline
In-Reply-To: <dd50f99b-03d3-44ca-9f79-dde3dff1c3d4@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


--TP9HXYLStPp8I3s9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 10:55:09AM +0300, Vladimir Sementsov-Ogievskiy wrot=
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
> > +            ret =3D probe_logical_blocksize(s->fd,
> > +                                          &bs->bl.pwrite_zeroes_alignm=
ent);
> > +            if (ret < 0) {
> > +                error_setg_errno(errp, -ret,
> > +                                 "Failed to probe logical block size");
>=20
> Isn't it too restrictive? Could we consider failed attempt to probe as pe=
rmission
> to proceed without write-zeroes alignment? In raw_probe_alignment, we fal=
lback
> to guessing request_alignment from memalign.

The logical block size alignment is required for write zeroes, otherwise
write zeroes will fail with EINVAL (not ENOTSUP).

There is no way to probe in the !needs_alignment case since read
requests don't require alignment and write zeroes would be destructive.

I think it's preferrable to fail here. This should never happen on a
Linux kernel because BLKSSZGET has been there since the initial git
import in 2005.

>=20
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

--TP9HXYLStPp8I3s9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjj2MYACgkQnKSrs4Gr
c8j9mggAxQbp7km1/oqcj3rYZUxGqt8hzKPP5xsQ9mqyE1G20KihAF3VPbOnuZQK
WGqaoqeBPcYQ3tWgi/JzEtB2TFKR7gJOdOT1gAhogMWYVXQeQCp8MrVO4Enmk1Yl
CQkK+X1/YcGE8zBV0EdMTEr8Ljf5mKqFMFuhN/DF/06XYEjeZqSj7VnB9rA3Qt7+
GA6NxxM/r+qvHt5nSZMfQ61zugESlhj0LBGIhg/pdpWxiI/NMiBGURxwfmkQ+F/X
0ZUeNgttbiPU+vcVsav7H8fzmTPamV9n13DCucJXZk1VCdrLwZc5LB4TFyLetCgt
m4W2mZLNw8zR9ksdSmN7LtZmZTlOqA==
=Prlj
-----END PGP SIGNATURE-----

--TP9HXYLStPp8I3s9--


