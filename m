Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9155C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 13:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1mwq-00029X-Bn; Mon, 07 Apr 2025 09:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u1mwp-00029M-3j
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 09:55:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u1mwn-00020R-9u
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 09:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744034130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w/NSW8dZFl34s2IQ+/lApiWD5Idzh/hJ5nw/W9TQAn0=;
 b=aC7C1l2uftO3L+wzTCgjJguxi7iKuAibKElaUM6B4PbygPJC08t7pzsYyiQkf2STU+lhWW
 YPeI2nEQuXfuH5iLL0aYZLyjdPI3HUjCaiJLMCrXforRdW0jAjMAf6ZTGzIbdIJGHAelYF
 RhsIxPofRXhoZk3iPMUthX6a9nofyEw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-ogOt-kN4NNmgtoi94trzgQ-1; Mon,
 07 Apr 2025 09:55:26 -0400
X-MC-Unique: ogOt-kN4NNmgtoi94trzgQ-1
X-Mimecast-MFC-AGG-ID: ogOt-kN4NNmgtoi94trzgQ_1744034124
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EEC1195608F; Mon,  7 Apr 2025 13:55:22 +0000 (UTC)
Received: from localhost (unknown [10.2.16.119])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC7B0192C7C3; Mon,  7 Apr 2025 13:55:20 +0000 (UTC)
Date: Mon, 7 Apr 2025 09:55:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pinku Deb Nath <prantoran@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5] block/file-posix.c: Use pwritev2() with RWF_DSYNC for
 FUA
Message-ID: <20250407135519.GB473226@fedora>
References: <20250405235229.215582-1-prantoran@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DgF6PKx1Og2FEuy8"
Content-Disposition: inline
In-Reply-To: <20250405235229.215582-1-prantoran@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--DgF6PKx1Og2FEuy8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 05, 2025 at 04:52:29PM -0700, Pinku Deb Nath wrote:
> Full Unit Access (FUA) is an optimization where a disk write with the
> flag set will be persisted to disk immediately instead of potentially
> remaining in the disk's write cache.
>=20
> This commit address the todo task
> for using pwritev2() with RWF_DSYNC in the thread pool section of
> raw_co_prw(), if pwritev2() with RWF_DSYNC is available in the host,
> which is always the case for Linux kernel >=3D 4.7.
>=20
> The intent for FUA is indicated with the BDRV_REQ_FUA flag.
> The old code paths are preserved in case BDRV_REQ_FUA is off
> or pwritev2() with RWF_DSYNC is not available.
>=20
> Support for disk writes with FUA is handled in qemu_pwritev_fua(),
> which uses pwritev2() with RWF_DSYNC if available, otherwise falls
> back to pwritev2() with no flags followed by flush using
> handle_aiocb_flush().
>=20
> If pwritev2() is not implemented, then disk write in the linear FUA
> will fallback to pwrite() + handle_aiocb_flush().
>=20
> Signed-off-by: Pinku Deb Nath <prantoran@gmail.com>
>=20
> ---
>=20
> v4:
> - Add fallback when qemu_pwritev_fua() returns ENOSYS
> - Similar fallback was not added for handle_aiocb_rw_vector()
> since there is a preadv_present check in handle_aiocb_rw()
>=20
> v3:
> - Changed signature to add fd, iov, nr_iov
> - Return -ENOSYS for non-Linux hosts
>=20
> v2:
> - Moved handle_aiocb_flush() into qemu_pwritev_fua()
> - In handle_aiocb_rw_linear(), iovec with iovcnt=3D1 is created
> based on the assumption that there will be only one buffer
> ---
>  block/file-posix.c | 68 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 56 insertions(+), 12 deletions(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 56d1972d15..59bed7866a 100644
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

This will fail to compile on non-Linux OSes that provide preadv(2)
(CONFIG_PREADV) because they do not have pwritev2(2). This can be fixed
by using pwritev() since the flags aren't needed:

  ssize_t len =3D pwritev(fd, iov, nr_iov, offset);

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
> @@ -1727,10 +1753,31 @@ static ssize_t handle_aiocb_rw_linear(RawPosixAIO=
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
> +                    .iov_base =3D buf + offset,
> +                    .iov_len =3D aiocb->aio_nbytes - offset,
> +                };
> +                len =3D qemu_pwritev_fua(aiocb->aio_fildes,
> +                                    &iov,
> +                                    1,
> +                                    aiocb->aio_offset + offset,
> +                                    aiocb);
> +                if (len =3D=3D -ENOSYS) {
> +                    len =3D pwrite(aiocb->aio_fildes,
> +                                (const char *)buf + offset,
> +                                aiocb->aio_nbytes - offset,
> +                                aiocb->aio_offset + offset);
> +                    if (len =3D=3D 0) {
> +                        len =3D handle_aiocb_flush(aiocb);
> +                    }
> +                }
> +            } else {
> +                len =3D pwrite(aiocb->aio_fildes,
> +                            (const char *)buf + offset,
> +                            aiocb->aio_nbytes - offset,
> +                            aiocb->aio_offset + offset);
> +            }
>          } else {
>              len =3D pread(aiocb->aio_fildes,
>                          buf + offset,
> @@ -2539,14 +2586,11 @@ static int coroutine_fn raw_co_prw(BlockDriverSta=
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

--DgF6PKx1Og2FEuy8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfz2UcACgkQnKSrs4Gr
c8jyCQf/Woz+WEbUwRul1UTOK/Q8S9eCdtppwVdWvwneMWpONj2ClocprCDtDQ67
YUu1PjvtX3qw7ZTbv97iENwaTg2RDWpnlTogqArcuIEFpO5BXbZPvXlfMJNIbOJ4
1hUbU0tgZQOyFKilThYIiB4EV1J1HXy41PUMXkmjDyxbKsaRXBzYNqXwF4A0PkS4
aQzYiLO2LmXLFCYv3E9k4IkF2YnpLLgEvmrmzDa/zeYETNOCFnmvUxWXBYZPG1sn
RqZT+973dbpyTcHCmxhTUu1IjCsh5Eva1QfvWj2Yz/qQ0qPVJsBzt4Ctu4BIjTZZ
XSY0SDE738dCRGanXMwtSTlESZx6/Q==
=I12z
-----END PGP SIGNATURE-----

--DgF6PKx1Og2FEuy8--


