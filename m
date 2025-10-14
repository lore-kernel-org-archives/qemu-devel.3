Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4116ECCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 14:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92kJ-0001jq-KS; Wed, 15 Oct 2025 10:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v92kH-0001j6-Mu
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v92kE-0006dL-5U
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760539484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=53IOV/0hVHANWUsGcU3NZKHOKewxkfQGTy8wWylydLw=;
 b=ety190KsUo5fJ9Wixy/15ZaQyTAE55Ztz0R+BIfmYqVgWTh3PevdSrgoGngwIumjlXjxvR
 lgfH/nOdwVJvDuZ1su1bcfdNCBeiztf2fLqczq5Rl0MEZV6dX5DOYBR7Nu5PatKhC3H5qy
 8cS35cS4brxbhynLGNmeUFNFi0Wcxzg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-h_C6LJRWPgiOW_pygj62sA-1; Wed,
 15 Oct 2025 10:44:41 -0400
X-MC-Unique: h_C6LJRWPgiOW_pygj62sA-1
X-Mimecast-MFC-AGG-ID: h_C6LJRWPgiOW_pygj62sA_1760539474
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 252CC1800451; Wed, 15 Oct 2025 14:44:34 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 48BD91800446; Wed, 15 Oct 2025 14:44:33 +0000 (UTC)
Date: Tue, 14 Oct 2025 15:52:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 12/12] block/io_uring: use non-vectored read/write
 when possible
Message-ID: <20251014195243.GH18850@fedora>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-13-stefanha@redhat.com>
 <aOk1ZEmEIIXDfXpf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HwsL3XmgrE9900qX"
Content-Disposition: inline
In-Reply-To: <aOk1ZEmEIIXDfXpf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--HwsL3XmgrE9900qX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 06:33:40PM +0200, Kevin Wolf wrote:
> Am 10.09.2025 um 19:57 hat Stefan Hajnoczi geschrieben:
> > The io_uring_prep_readv2/writev2() man pages recommend using the
> > non-vectored read/write operations when possible for performance
> > reasons.
> >=20
> > I didn't measure a significant difference but it doesn't hurt to have
> > this optimization in place.
> >=20
> > Suggested-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  block/io_uring.c | 29 ++++++++++++++++++++++++-----
> >  1 file changed, 24 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/block/io_uring.c b/block/io_uring.c
> > index dd930ee57e..bbefbddcc0 100644
> > --- a/block/io_uring.c
> > +++ b/block/io_uring.c
> > @@ -49,12 +49,24 @@ static void luring_prep_sqe(struct io_uring_sqe *sq=
e, void *opaque)
> >  #ifdef HAVE_IO_URING_PREP_WRITEV2
> >      {
> >          int luring_flags =3D (flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
> > -        io_uring_prep_writev2(sqe, fd, qiov->iov,
> > -                              qiov->niov, offset, luring_flags);
> > +        if (luring_flags !=3D 0 || qiov->niov > 1) {
> > +            io_uring_prep_writev2(sqe, fd, qiov->iov,
> > +                                  qiov->niov, offset, luring_flags);
> > +        } else {
> > +            /* The man page says non-vectored is faster than vectored =
*/
> > +            struct iovec *iov =3D qiov->iov;
> > +            io_uring_prep_write(sqe, fd, iov->iov_base, iov->iov_len, =
offset);
> > +        }
> >      }
> >  #else
> >          assert(flags =3D=3D 0);
> > -        io_uring_prep_writev(sqe, fd, qiov->iov, qiov->niov, offset);
> > +        if (qiov->niov > 1) {
> > +            io_uring_prep_writev(sqe, fd, qiov->iov, qiov->niov, offse=
t);
> > +        } else {
> > +            /* The man page says non-vectored is faster than vectored =
*/
> > +            struct iovec *iov =3D qiov->iov;
> > +            io_uring_prep_write(sqe, fd, iov->iov_base, iov->iov_len, =
offset);
> > +        }
> >  #endif
>=20
> We have a lot of duplication in this now. Let's use the #ifdef a little
> more locally:
>=20
>     {
>         int luring_flags =3D (flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
>         if (luring_flags !=3D 0 || qiov->niov > 1) {
> #ifdef HAVE_IO_URING_PREP_WRITEV2
>             io_uring_prep_writev2(sqe, fd, qiov->iov,
>                                   qiov->niov, offset, luring_flags);
> #else
>             assert(luring_flags =3D=3D 0);
>             io_uring_prep_writev(sqe, fd, qiov->iov, qiov->niov, offset);
> #endif
>         } else {
>             /* The man page says non-vectored is faster than vectored */
>             struct iovec *iov =3D qiov->iov;
>             io_uring_prep_write(sqe, fd, iov->iov_base, iov->iov_len, off=
set);
>         }
>     }

Will fix in v5. Thanks!

Stefan

--HwsL3XmgrE9900qX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjuqgsACgkQnKSrs4Gr
c8i9sAf/T9xebvp8Na8XzrUbSqPPqxsX7vDKYnXqzBBSbpx7r8FHCsGKnjs71zvL
ctovekakqif/x4kKu36iFoKewQlKe1bScMwII9TjMaJW1U9+cT+bE7nVUpliFQ1F
PANorLZkqYXeQHTmuUHCXYD9YnrttHhoLFmaewYgv/VjHv42XoyE0cZgQ2sluwxI
GwstrYtxZu9zNl5SjCebShoMHnVeaMK4K+lyUeaxejETs6FxS2B5ZHBL4NVG6zg+
crgM9gi+gy8ehz4xByG6ArueC2XlS8KRzuBV8bwSTg+amVv4dvShT4h/PVBYDhOi
CgQGzCaT+ZGJ0uPD7NTgM9dgOieSRQ==
=5feE
-----END PGP SIGNATURE-----

--HwsL3XmgrE9900qX--


