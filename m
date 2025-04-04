Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFFCC3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kWT-0007bE-3b; Fri, 04 Apr 2025 13:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u0kWQ-0007aL-Pn
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:08:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u0kWO-0005Bu-Iu
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743786479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9v8AXBiz2VbGbNqr98/RiYkEp9OyLy9b8FlbC12ViHI=;
 b=C+RUzVYiPW+Y44dbN9377xuJ+srRFN6sYuilba/GhROL5PSOL/WYULP+5Ufb8/DecvXS1L
 OHhAh2JQtjIyMG7ykOx1qhToEx8uEi8CI2Nhn5jJoV34iT7rDdyt3L+eGbnWTIruXnCWLx
 Hctf/4obZaKULyiFhO5HdeOnv2aHgtc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-K5xrAB1QMkWYsNRb8F_ySg-1; Fri,
 04 Apr 2025 13:07:55 -0400
X-MC-Unique: K5xrAB1QMkWYsNRb8F_ySg-1
X-Mimecast-MFC-AGG-ID: K5xrAB1QMkWYsNRb8F_ySg_1743786474
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B41C51800361; Fri,  4 Apr 2025 17:07:54 +0000 (UTC)
Received: from localhost (unknown [10.2.16.156])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 291331801766; Fri,  4 Apr 2025 17:07:52 +0000 (UTC)
Date: Fri, 4 Apr 2025 11:05:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pinku Deb Nath <prantoran@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH v4] block/file-posix.c: Use pwritev2() with RWF_DSYNC for
 FUA
Message-ID: <20250404150509.GA374072@fedora>
References: <20250404074233.133365-1-prantoran@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+g98o3/GyoR6TEqM"
Content-Disposition: inline
In-Reply-To: <20250404074233.133365-1-prantoran@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--+g98o3/GyoR6TEqM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2025 at 12:42:33AM -0700, Pinku Deb Nath wrote:
> Full Unit Access (FUA) is an optimization where a disk write with the
> flag set will be persisted to disk immediately instead of potentially
> remaining in the disk's write cache. This commit address the todo task
> for using pwritev2() with RWF_DSYNC in the thread pool section of
> raw_co_prw(), if pwritev2 with RWF_DSYNC is available in the host,
> which is alway for Linux kernel >=3D 4.7. The intent for FUA is indicated
> with the BDRV_REQ_FUA flag. The old code paths are preserved in case
> BDRV_REQ_FUA is off or pwritev2() with RWF_DSYNC is not available.
>=20
> During testing, I observed that the BDRV_REQ_FUA is always turned on
> when blk->enable_write_cache is not set in block/block-backend.c, so
> I commented this section off during testing:
> https://gitlab.com/qemu-project/qemu/-/blob/master/block/block-backend.c?=
ref_type=3Dheads#L1432-1434
>=20
> Signed-off-by: Pinku Deb Nath <prantoran@gmail.com>
>=20
> Update 1:
>=20
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
>=20
> Update 2:
>=20
> For non-Linux hosts, I am returning -ENOSYS in the same way for
> pwritev.
>=20
> I changed the signature to add fd, iov, nr_iov, offset separately,
> with the aiocb pointer at the end. I thought of reconstructing
> aiocb inside the function but the handle_aiocb_flush() uses
> (BDRVRawState)aiocb->bs->opaque which I was not sure whether it
> was used to pass return values upstream.
> So I decided on passing aiocb pointer as an input argument.
>=20
> I was not sure about how git rebase worked with patches, I hope
> it worked, finger-crossed =F0=9F=98=85
>=20
> Signed-off-by: Pinku Deb Nath <prantoran@gmail.com>
> ---
>  block/file-posix.c | 59 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 47 insertions(+), 12 deletions(-)

The commit description becomes part of the git log when the commit is
merged. For the same reasons why changes to patches should be squashed,
the commit description should also be updated to reflect the latest
state instead of appending incremental descriptions.

In order to indicate what changed since the previous version, you can
add a changelog below the '---' line. Anything below the '---' line is
discarded when git-am(1) applies a commit email. For example:

---
v3:
- Changed signature to add fd, iov, nr_iov, ...

v2:
- Moved handle_aiocb_flush() into qemu_pwritev_fua().

By doing these things you make it easy for reviewers to see what has
changed while keeping the git log clean.

>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 56d1972d15..16e32acedd 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -229,6 +229,7 @@ typedef struct RawPosixAIOData {
>              unsigned long op;
>          } zone_mgmt;
>      };
> +    BdrvRequestFlags flags;
>  } RawPosixAIOData;
> =20
>  #if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
> @@ -1674,6 +1675,20 @@ qemu_pwritev(int fd, const struct iovec *iov, int =
nr_iov, off_t offset)
>      return pwritev(fd, iov, nr_iov, offset);
>  }
> =20
> +static ssize_t
> +qemu_pwritev_fua(int fd, struct iovec *iov, int nr_iov, off_t offset, co=
nst RawPosixAIOData *aiocb)
> +{
> +#ifdef RWF_DSYNC
> +    return pwritev2(fd, iov, nr_iov, offset, RWF_DSYNC);
> +#else
> +    ssize_t len =3D pwritev2(fd, iov, nr_iov, offset, 0);
> +    if (len =3D=3D 0) {
> +        len =3D handle_aiocb_flush(aiocb);
> +    }
> +    return len;
> +#endif
> +}
> +
>  #else
> =20
>  static bool preadv_present =3D false;
> @@ -1690,6 +1705,11 @@ qemu_pwritev(int fd, const struct iovec *iov, int =
nr_iov, off_t offset)
>      return -ENOSYS;
>  }
> =20
> +static ssize_t
> +qemu_pwritev_fua(int fd, struct iovec *iov, int nr_iov, off_t offset, co=
nst RawPosixAIOData *aiocb)
> +{
> +    return -ENOSYS;
> +}
>  #endif
> =20
>  static ssize_t handle_aiocb_rw_vector(RawPosixAIOData *aiocb)
> @@ -1698,10 +1718,16 @@ static ssize_t handle_aiocb_rw_vector(RawPosixAIO=
Data *aiocb)
> =20
>      len =3D RETRY_ON_EINTR(
>          (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) ?
> -            qemu_pwritev(aiocb->aio_fildes,
> -                           aiocb->io.iov,
> -                           aiocb->io.niov,
> -                           aiocb->aio_offset) :
> +            (aiocb->flags &  BDRV_REQ_FUA) ?
> +                qemu_pwritev_fua(aiocb->aio_fildes,
> +                                aiocb->io.iov,
> +                                aiocb->io.niov,
> +                                aiocb->aio_offset,
> +                                aiocb) :
> +                qemu_pwritev(aiocb->aio_fildes,
> +                            aiocb->io.iov,
> +                            aiocb->io.niov,
> +                            aiocb->aio_offset) :
>              qemu_preadv(aiocb->aio_fildes,
>                            aiocb->io.iov,
>                            aiocb->io.niov,
> @@ -1727,10 +1753,22 @@ static ssize_t handle_aiocb_rw_linear(RawPosixAIO=
Data *aiocb, char *buf)
> =20
>      while (offset < aiocb->aio_nbytes) {
>          if (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
> -            len =3D pwrite(aiocb->aio_fildes,
> -                         (const char *)buf + offset,
> -                         aiocb->aio_nbytes - offset,
> -                         aiocb->aio_offset + offset);
> +            if (aiocb->flags & BDRV_REQ_FUA) {
> +                struct iovec iov =3D {
> +                    .iov_base =3D buf,

This should be buf + offset (the same as below)?

> +                    .iov_len =3D aiocb->aio_nbytes - offset,
> +                };
> +                len =3D qemu_pwritev_fua(aiocb->aio_fildes,
> +                                    &iov,
> +                                    1,
> +                                    aiocb->aio_offset + offset,
> +                                    aiocb);

When !CONFIG_PREADV then linear FUA writes will fail because there is no
-ENOSYS fallback here. Please add a fallback to pwrite() +
handle_aiocb_flush().

> +            } else {
> +                len =3D pwrite(aiocb->aio_fildes,
> +                            (const char *)buf + offset,
> +                            aiocb->aio_nbytes - offset,
> +                            aiocb->aio_offset + offset);
> +            }
>          } else {
>              len =3D pread(aiocb->aio_fildes,
>                          buf + offset,
> @@ -2539,14 +2577,11 @@ static int coroutine_fn raw_co_prw(BlockDriverSta=
te *bs, int64_t *offset_ptr,
>              .iov            =3D qiov->iov,
>              .niov           =3D qiov->niov,
>          },
> +        .flags          =3D flags,
>      };
> =20
>      assert(qiov->size =3D=3D bytes);
>      ret =3D raw_thread_pool_submit(handle_aiocb_rw, &acb);
> -    if (ret =3D=3D 0 && (flags & BDRV_REQ_FUA)) {
> -        /* TODO Use pwritev2() instead if it's available */
> -        ret =3D raw_co_flush_to_disk(bs);
> -    }
>      goto out; /* Avoid the compiler err of unused label */
> =20
>  out:
> --=20
> 2.43.0
>=20

--+g98o3/GyoR6TEqM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfv9SUACgkQnKSrs4Gr
c8gQdwf2KO7neAbqlphZrJ38i37xDum10OylHVwfVh76KIbrpU1+IgqUkJL/66T/
fXPIONlQnJp57+0G9cUKkoCxZJLQuKzHJzIp+9Mf8TBwQSspF2ho7zRLv1Q1M09X
i11g/d8PNlgQelmPE73m4JeZSZwnGk1eb+O2lemGugN2Xah1jXx6+qq7j0H7pKY2
T20h/Vn2I6JDDxbwZc11WmgcYcm7xfomLJD6iKBkW5sEBZSM/irkWiaSpqHWIciZ
O4ERXiu/cj/3bGjiSXeXZxpIXbeyOqYC0sYvWjXWd5NU4pviWmnbC3w9mCnoyNje
9f1w1fQnymyWB3hfWyJ6Dk83RC1R
=3Jsm
-----END PGP SIGNATURE-----

--+g98o3/GyoR6TEqM--


