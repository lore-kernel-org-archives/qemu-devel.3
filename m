Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CD8C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Mxl-0004QL-0D; Thu, 03 Apr 2025 11:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u0Mxj-0004Q3-ON
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u0Mxh-00018u-Rc
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743695914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ckT0hAZjJ0/c2SquW/HW/f+YyTXGWHtGN/3dbDhN3gg=;
 b=A0rSGYNNuQh3Dm4uUSzTWiFasNejJpoQJLjH6tgEBtexvg7V9YBqKJQqvCWHc+PhTqP28I
 O+VqBGSMPcK6uQuRA03JIjtkgQe+DUjrwHiIfN8pt2rJyTpFoZ370ZHerbU5/9ijNO/vBG
 4grbSIUtnWth3oaMy9xZbfe+FvcFqAs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-smEE7O-3MR2nQXNYeebNDQ-1; Thu,
 03 Apr 2025 11:58:33 -0400
X-MC-Unique: smEE7O-3MR2nQXNYeebNDQ-1
X-Mimecast-MFC-AGG-ID: smEE7O-3MR2nQXNYeebNDQ_1743695912
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80FAF1800259; Thu,  3 Apr 2025 15:58:27 +0000 (UTC)
Received: from localhost (unknown [10.2.16.203])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E7D51955BC2; Thu,  3 Apr 2025 15:58:26 +0000 (UTC)
Date: Thu, 3 Apr 2025 11:58:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pinku Deb Nath <prantoran@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/2] [PATCH] block/file-posix.c: Use pwritev2() with
 RWF_DSYNC for FUA - update
Message-ID: <20250403155825.GB349582@fedora>
References: <20250403081633.158591-1-prantoran@gmail.com>
 <20250403081633.158591-3-prantoran@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PBZkFY/niZ4cJHJs"
Content-Disposition: inline
In-Reply-To: <20250403081633.158591-3-prantoran@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--PBZkFY/niZ4cJHJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2025 at 01:16:33AM -0700, Pinku Deb Nath wrote:
> The testing with "-t writeback" works for turning on enable_write_cache.
> I renamed the function to qemu_pwritev_fua() and fixed any typos.
>=20
> I moved the handle_aiocb_flush() into the qemu_pwritev_fua() and
> removed from the previously todo seciont. Initially I thought
> of only passing aiocb, but then I was not sure whethe I could
> derive buf from aiocb, so I added arguments for iovec and iovcnt
> into qemu_pwritev_fua().
>=20
> For handling buf in handle_aiocb_rw_linear(), I created iovec
> and passed its reference. I assumed that there will be only one
> buffer/iovec, so I passed 1 for iovcnt.
>=20
> Signed-off-by: Pinku Deb Nath <prantoran@gmail.com>
> ---
>  block/file-posix.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 34de816eab..4fffd49318 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1676,12 +1676,24 @@ qemu_pwritev(int fd, const struct iovec *iov, int=
 nr_iov, off_t offset)
>  }
> =20
>  static ssize_t
> -qemu_pwrite_fua(int fd, const struct iovec *iov, int nr_iov, off_t offse=
t)
> +qemu_pwritev_fua(const RawPosixAIOData *aiocb, struct iovec *iov, int io=
vcnt)
>  {
>  #ifdef RWF_DSYNC
> -    return pwritev2(fd, iov, nr_iov, offset, RWF_DSYNC);
> +    return pwritev2(aiocb->aio_fildes,
> +                    iov,
> +                    iovcnt,
> +                    aiocb->aio_offset,
> +                    RWF_DSYNC);
>  #else
> -    return pwritev2(fd, iov, nr_iov, offset, 0);
> +    ssize_t len =3D pwritev2(aiocb->aio_fildes,
> +                        iov,
> +                        iovcnt,
> +                        aiocb->aio_offset,
> +                        0);

On a non-Linux host pwritev2(2) will not exist. Please take a look at
how qemu_preadv() is integrated (including the !CONFIG_PREADV case) and
decide on a solution that works on non-Linux hosts.

> +    if (len =3D=3D 0) {
> +        len =3D handle_aiocb_flush(aiocb);
> +    }
> +    return len;
>  #endif
>  }
> =20
> @@ -1710,10 +1722,7 @@ static ssize_t handle_aiocb_rw_vector(RawPosixAIOD=
ata *aiocb)
>      len =3D RETRY_ON_EINTR(
>          (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) ?
>              (aiocb->flags &  BDRV_REQ_FUA) ?
> -                qemu_pwrite_fua(aiocb->aio_fildes,
> -                                aiocb->io.iov,
> -                                aiocb->io.niov,
> -                                aiocb->aio_offset) :
> +                qemu_pwritev_fua(aiocb, aiocb->io.iov, aiocb->io.niov) :
>                  qemu_pwritev(aiocb->aio_fildes,
>                              aiocb->io.iov,
>                              aiocb->io.niov,
> @@ -1744,10 +1753,11 @@ static ssize_t handle_aiocb_rw_linear(RawPosixAIO=
Data *aiocb, char *buf)
>      while (offset < aiocb->aio_nbytes) {
>          if (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
>              if (aiocb->flags & BDRV_REQ_FUA) {
> -                len =3D qemu_pwrite_fua(aiocb->aio_fildes,
> -                                    aiocb->io.iov,
> -                                    aiocb->io.niov,
> -                                    aiocb->aio_offset);
> +                struct iovec iov =3D {
> +                    .iov_base =3D buf,
> +                    .iov_len =3D aiocb->aio_nbytes - offset,
> +                };
> +                len =3D qemu_pwritev_fua(aiocb, &iov, 1);

The else branch takes offset into account. Here aiocb is passed in
assuming it's the first iteration of the while (offset <
aiocb->aio_nbytes) loop. On subsequent iterations the wrong values will
be used because offset has changed.

Perhaps it's easier to pass in the individual parameters (fd, offset,
etc) instead of passing in aiocb.

>              } else {
>                  len =3D pwrite(aiocb->aio_fildes,
>                              (const char *)buf + offset,
> @@ -2567,12 +2577,6 @@ static int coroutine_fn raw_co_prw(BlockDriverStat=
e *bs, int64_t *offset_ptr,
> =20
>      assert(qiov->size =3D=3D bytes);
>      ret =3D raw_thread_pool_submit(handle_aiocb_rw, &acb);
> -#ifndef RWD_DSYNC
> -    if (ret =3D=3D 0 && (flags & BDRV_REQ_FUA)) {
> -        /* TODO Use pwritev2() instead if it's available */
> -        ret =3D raw_co_flush_to_disk(bs);
> -    }
> -#endif
>      goto out; /* Avoid the compiler err of unused label */
> =20
>  out:
> --=20
> 2.43.0
>=20

--PBZkFY/niZ4cJHJs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfusCEACgkQnKSrs4Gr
c8iIlAf+NCzmvj4LRnkgQDzQIRwnaRlkTyQVU+OFvOktnh6mKXiqLUqewPT3cHUs
53dxBEWPvTogM4n98gxSHtjTG+TBy9o/7HKIulPrdLvbtSEQjLnQWYBxkrNz/+uh
EAVzTox5dm0/my0Ol0Yn2aXYdvLIBICT8rqrv36PtbPkTrxyUXynWkE98JJJf1Ub
zecXl+VvdssEvWxpecxN+xt06gJ1D4mKNJBOe431+SB4fu5BTnf/W8k0SOxaf1vQ
sQas0SOIcR6EpTa1q/9wQMhZq9HGbLu6efucGwy7fVbFnLKnqOpzBRw+GPASTzrJ
R+zyJvWnFfEJiXRcFjKOIw9YesZrOQ==
=F2FZ
-----END PGP SIGNATURE-----

--PBZkFY/niZ4cJHJs--


