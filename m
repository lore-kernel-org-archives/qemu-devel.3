Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49531C3601A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 13:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzyKn-0003Wo-6k; Wed, 02 Apr 2025 09:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzyKX-0003L3-Qd
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzyKT-0008VB-DL
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743601226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ODUjV9kPsX8UtF9wJ3MdQtaP/P/07iRH+aEYkRK1QE=;
 b=KwebbahsWrq96X+bAacoChJWTLixGN7Jc9qlpeXrlVID7p/FnZg6z0lcGD6RRabI7phyv9
 /WCowC0YAHulcgvMJwZ4og3REtC3T226wRuShpnhC8m8AsxaPPKltaO51zB3b7AZmmc9Td
 HR68wvCAqTyA9TzLgI8VazQDSHJKKlc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-sMPZuCptPLaVHPynI9iQRA-1; Wed,
 02 Apr 2025 09:40:23 -0400
X-MC-Unique: sMPZuCptPLaVHPynI9iQRA-1
X-Mimecast-MFC-AGG-ID: sMPZuCptPLaVHPynI9iQRA_1743601222
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5892D1954B3B; Wed,  2 Apr 2025 13:40:22 +0000 (UTC)
Received: from localhost (unknown [10.2.16.101])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E7011955BEF; Wed,  2 Apr 2025 13:40:20 +0000 (UTC)
Date: Wed, 2 Apr 2025 09:40:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pinku Deb Nath <prantoran@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] block/file-posix.c: Use pwritev2() with RWF_DSYNC for FUA
Message-ID: <20250402134020.GB304512@fedora>
References: <20250402093101.256136-1-prantoran@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AY9E7m6smc6yzJOx"
Content-Disposition: inline
In-Reply-To: <20250402093101.256136-1-prantoran@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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


--AY9E7m6smc6yzJOx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 02:31:01AM -0700, Pinku Deb Nath wrote:
> Full Unit Access (FUA) is an optimization where a disk write with the
> flag set will be persisted to disk immediately instead of potentially
> remaining in the disk's write cache. This commit address the todo task
> for using pwritev2() with RWF_DSYNC in the thread pool section of
> raw_co_prw(), if pwritev2 with RWF_DSYNC is available in the host,
> which is alway for Linux kernel >=3D 4.7. The intent for FUA is indicated

"alway" -> "always true"?

> with the BDRV_REQ_FUA flag. The old code paths are preserved in case
> BDRV_REQ_FUA is off or pwritev2() with RWF_DSYNC is not available.
>=20
> During testing, I observed that the BDRV_REQ_FUA is always turned on
> when blk->enable_write_cache is not set in block/block-backend.c, so
> I commented this section off during testing:
> https://gitlab.com/qemu-project/qemu/-/blob/master/block/block-backend.c?=
ref_type=3Dheads#L1432-1434

You can also use the qemu-io "open -t writeback <filename>" command to
open the image file with enable_write_cache.

>=20
> Signed-off-by: Pinku Deb Nath <prantoran@gmail.com>
> ---
>  block/file-posix.c | 42 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 8 deletions(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 56d1972d15..34de816eab 100644
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
> @@ -1674,6 +1675,16 @@ qemu_pwritev(int fd, const struct iovec *iov, int =
nr_iov, off_t offset)
>      return pwritev(fd, iov, nr_iov, offset);
>  }
> =20
> +static ssize_t
> +qemu_pwrite_fua(int fd, const struct iovec *iov, int nr_iov, off_t offse=
t)

Please call this function qemu_pwritev_fua() since it takes an iovec
array.

> +{
> +#ifdef RWF_DSYNC
> +    return pwritev2(fd, iov, nr_iov, offset, RWF_DSYNC);
> +#else
> +    return pwritev2(fd, iov, nr_iov, offset, 0);

In the #else case the function is not doing what its name says - FUA is
skipped. Kevin mentioned that the flush could be moved into the handle
function. How about calling handle_aiocb_flush() so that
qemu_pwrite_fua() has the intended semantics even on hosts without
RWF_DSYNC?

> +#endif
> +}
> +
>  #else
> =20
>  static bool preadv_present =3D false;
> @@ -1698,10 +1709,15 @@ static ssize_t handle_aiocb_rw_vector(RawPosixAIO=
Data *aiocb)
> =20
>      len =3D RETRY_ON_EINTR(
>          (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) ?
> -            qemu_pwritev(aiocb->aio_fildes,
> -                           aiocb->io.iov,
> -                           aiocb->io.niov,
> -                           aiocb->aio_offset) :
> +            (aiocb->flags &  BDRV_REQ_FUA) ?
> +                qemu_pwrite_fua(aiocb->aio_fildes,
> +                                aiocb->io.iov,
> +                                aiocb->io.niov,
> +                                aiocb->aio_offset) :
> +                qemu_pwritev(aiocb->aio_fildes,
> +                            aiocb->io.iov,
> +                            aiocb->io.niov,
> +                            aiocb->aio_offset) :
>              qemu_preadv(aiocb->aio_fildes,
>                            aiocb->io.iov,
>                            aiocb->io.niov,
> @@ -1727,10 +1743,17 @@ static ssize_t handle_aiocb_rw_linear(RawPosixAIO=
Data *aiocb, char *buf)
> =20
>      while (offset < aiocb->aio_nbytes) {
>          if (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
> -            len =3D pwrite(aiocb->aio_fildes,
> -                         (const char *)buf + offset,
> -                         aiocb->aio_nbytes - offset,
> -                         aiocb->aio_offset + offset);
> +            if (aiocb->flags & BDRV_REQ_FUA) {
> +                len =3D qemu_pwrite_fua(aiocb->aio_fildes,
> +                                    aiocb->io.iov,
> +                                    aiocb->io.niov,
> +                                    aiocb->aio_offset);

handle_aiocb_rw() can pass in a temporary buffer (instead of iov), so
it's incorrect to use aiocb->io.iov here. Instead, create a local struct
iov iov =3D { .iov_base =3D buf, .iov_len =3D aiocb->aio_nbytes - offset }
here.

> +            } else {
> +                len =3D pwrite(aiocb->aio_fildes,
> +                            (const char *)buf + offset,
> +                            aiocb->aio_nbytes - offset,
> +                            aiocb->aio_offset + offset);
> +            }
>          } else {
>              len =3D pread(aiocb->aio_fildes,
>                          buf + offset,
> @@ -2539,14 +2562,17 @@ static int coroutine_fn raw_co_prw(BlockDriverSta=
te *bs, int64_t *offset_ptr,
>              .iov            =3D qiov->iov,
>              .niov           =3D qiov->niov,
>          },
> +        .flags          =3D flags,
>      };
> =20
>      assert(qiov->size =3D=3D bytes);
>      ret =3D raw_thread_pool_submit(handle_aiocb_rw, &acb);
> +#ifndef RWD_DSYNC

RWF_DSYNC

>      if (ret =3D=3D 0 && (flags & BDRV_REQ_FUA)) {
>          /* TODO Use pwritev2() instead if it's available */

This TODO comment can be deleted now.

>          ret =3D raw_co_flush_to_disk(bs);

This can be removed if qemu_pwritev_fua() ensures that the flush has
occurred.

>      }
> +#endif
>      goto out; /* Avoid the compiler err of unused label */
> =20
>  out:
> --=20
> 2.43.0
>=20

--AY9E7m6smc6yzJOx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmftPkMACgkQnKSrs4Gr
c8hRSwgAsiyDilgzK6zLkjoOJZgIPHa+DKsKgowN1BG5jwP8doZ8vN6dT6OmCFu/
Q7P4/0XJN59q2TZQtqaifFHkSY0oYEkd4F7aP8CKHQ7jHjITagL3I5lz9f7h7oMN
J3A7/7YEc/6MztWjt9jVOhZhYK2ec/jnrLdFL8mobrpopeFotmUrZC/4TsQRshX0
CRwY3idQYS8FDrU3RG8Lc6LWMdOh2qK6kR7KL7ETuAs1vIEN9UkedwtOVefwGHRG
/Gfd0MNnoV3wNROnr45h9ty/57QpAGWQUjxF1YAZq5HSTIVT8DK0X92FoyYR+13v
5oeaDl0EILg1LGrMJxYeBpdj7LWZkQ==
=NawT
-----END PGP SIGNATURE-----

--AY9E7m6smc6yzJOx--


