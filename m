Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16740C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 21:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuHdU-0004FZ-NT; Mon, 17 Mar 2025 17:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tuHdE-0004Do-L0
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 17:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tuHdA-0002cq-MZ
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 17:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742245454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LnvXHcqFIbUwpVCt8bCseMBRX8FTHRrJAItDbeDB8M0=;
 b=VwYhhEbSJmfoLrO7P9vtR8WLj+G5vZzPPMmDwsE5df7YeeopXxqjFVqwl8eelV6MGuhWx5
 ir/JvgfJlOePBakA1xi1i/MLbcfouMnz+S5ayJLrIEmuMhGL/aGsyuVsYbhUYoeEJXolWf
 TCUE+rNBnxQ7EewxsgPKnn1PERGAp6g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-d4R26mBRPuaTqq5TugLFfg-1; Mon,
 17 Mar 2025 17:04:12 -0400
X-MC-Unique: d4R26mBRPuaTqq5TugLFfg-1
X-Mimecast-MFC-AGG-ID: d4R26mBRPuaTqq5TugLFfg_1742245451
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C882118001F8; Mon, 17 Mar 2025 21:04:10 +0000 (UTC)
Received: from localhost (unknown [10.2.17.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45320180174E; Mon, 17 Mar 2025 21:04:09 +0000 (UTC)
Date: Mon, 17 Mar 2025 17:04:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: saz97 <sa.z@qq.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org
Subject: Re: [PATCH RFC v2] Integration coroutines into fuse export
Message-ID: <20250317210408.GF1214048@fedora>
References: <tencent_C6F198B4EA3ABA591C57084BA7125D04B306@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="s+NNU7avonaiVvLf"
Content-Disposition: inline
In-Reply-To: <tencent_C6F198B4EA3ABA591C57084BA7125D04B306@qq.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--s+NNU7avonaiVvLf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 01:30:20AM +0800, saz97 wrote:
> Signed-off-by: Changzhi Xie <sa.z@qq.com>
>=20
> This commit refactors the FUSE export to process read and write operations
> using coroutines, improving concurrency and avoiding blocking the main lo=
op.
>=20
> The main changes include:
> 1.  Introduce FuseIORequest structure to encapsulate I/O parameters and s=
tate
> 2.  Move read/write processing into coroutine fuse_read_coroutine and fus=
e_write_coroutine
> 3.  Use blk_co_pread/pwrite for async block layer access
> ---
>  block/export/fuse.c | 189 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 132 insertions(+), 57 deletions(-)
>=20
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index 465cc9891d..3314f64706 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c
> @@ -39,6 +39,7 @@
> =20
>  #ifdef __linux__
>  #include <linux/fs.h>
> +#include <linux/fuse.h>
>  #endif
> =20
>  /* Prevent overly long bounce buffer allocations */
> @@ -49,7 +50,6 @@ typedef struct FuseExport {
>      BlockExport common;
> =20
>      struct fuse_session *fuse_session;
> -    struct fuse_buf fuse_buf;
>      unsigned int in_flight; /* atomic */
>      bool mounted, fd_handler_set_up;
> =20
> @@ -64,6 +64,14 @@ typedef struct FuseExport {
>      gid_t st_gid;
>  } FuseExport;
> =20
> +typedef struct FuseIORequest {
> +    fuse_req_t req;
> +    size_t size;
> +    off_t offset;
> +    FuseExport *exp;
> +    char *write_buf;
> +} FuseIORequest;
> +
>  static GHashTable *exports;
>  static const struct fuse_lowlevel_ops fuse_ops;
> =20
> @@ -288,6 +296,7 @@ fail:
>  static void read_from_fuse_export(void *opaque)
>  {
>      FuseExport *exp =3D opaque;
> +    struct fuse_buf buf =3D {};
>      int ret;
> =20
>      blk_exp_ref(&exp->common);
> @@ -295,20 +304,30 @@ static void read_from_fuse_export(void *opaque)
>      qatomic_inc(&exp->in_flight);
> =20
>      do {
> -        ret =3D fuse_session_receive_buf(exp->fuse_session, &exp->fuse_b=
uf);
> +        ret =3D fuse_session_receive_buf(exp->fuse_session, &buf);
>      } while (ret =3D=3D -EINTR);
>      if (ret < 0) {
>          goto out;
>      }
> =20
> -    fuse_session_process_buf(exp->fuse_session, &exp->fuse_buf);
> +    fuse_session_process_buf(exp->fuse_session, &buf);
> =20
>  out:
> +    struct fuse_in_header *in =3D (struct fuse_in_header *)buf.mem;
> +
> +    if (in->opcode =3D=3D FUSE_WRITE || in->opcode =3D=3D FUSE_READ) {
> +        g_free(buf.mem);
> +        return;

Returning here is not safe because &buf was passed to
fuse_session_process_buf() and is located on read_from_fuse_export()'s
stack. The coroutine must not access buf after this function returns.

I suggest moving most of this function into a coroutine so that struct
fuse_buf can be on the coroutine's stack. That way it outlives
fuse_session_process_buf().

Doing this also avoids duplicating the code below and eliminates the
need for FuseIORequest.

> +    }
> +
>      if (qatomic_fetch_dec(&exp->in_flight) =3D=3D 1) {
>          aio_wait_kick(); /* wake AIO_WAIT_WHILE() */
>      }
> =20
>      blk_exp_unref(&exp->common);
> +
> +    g_free(buf.mem);

Please make this free(buf.mem) since libfuse uses malloc(3).

> +
>  }
> =20
>  static void fuse_export_shutdown(BlockExport *blk_exp)
> @@ -347,7 +366,6 @@ static void fuse_export_delete(BlockExport *blk_exp)
>          fuse_session_destroy(exp->fuse_session);
>      }
> =20
> -    free(exp->fuse_buf.mem);
>      g_free(exp->mountpoint);
>  }
> =20
> @@ -570,102 +588,159 @@ static void fuse_open(fuse_req_t req, fuse_ino_t =
inode,
>      fuse_reply_open(req, fi);
>  }
> =20
> -/**
> - * Handle client reads from the exported image.
> - */
> -static void fuse_read(fuse_req_t req, fuse_ino_t inode,
> -                      size_t size, off_t offset, struct fuse_file_info *=
fi)
> +static void coroutine_fn fuse_read_coroutine(void *opaque)
>  {
> -    FuseExport *exp =3D fuse_req_userdata(req);
> +    FuseIORequest *io_req =3D opaque;
> +    FuseExport *exp =3D io_req->exp;
>      int64_t length;
> -    void *buf;
> +    void *buffer;
>      int ret;
> =20
> -    /* Limited by max_read, should not happen */
> -    if (size > FUSE_MAX_BOUNCE_BYTES) {
> -        fuse_reply_err(req, EINVAL);
> -        return;
> +    if (io_req->size > FUSE_MAX_BOUNCE_BYTES) {
> +        fuse_reply_err(io_req->req, EINVAL);
> +        goto cleanup;
>      }
> =20
> -    /**
> -     * Clients will expect short reads at EOF, so we have to limit
> -     * offset+size to the image length.
> -     */
>      length =3D blk_getlength(exp->common.blk);
>      if (length < 0) {
> -        fuse_reply_err(req, -length);
> -        return;
> +        fuse_reply_err(io_req->req, -length);
> +        goto cleanup;
>      }
> =20
> -    if (offset + size > length) {
> -        size =3D length - offset;
> +    if (io_req->offset + io_req->size > length) {
> +        io_req->size =3D length - io_req->offset;
>      }
> =20
> -    buf =3D qemu_try_blockalign(blk_bs(exp->common.blk), size);
> -    if (!buf) {
> -        fuse_reply_err(req, ENOMEM);
> -        return;
> +    if (io_req->size =3D=3D 0) {
> +        fuse_reply_buf(io_req->req, NULL, 0);
> +        goto cleanup;
>      }
> =20
> -    ret =3D blk_pread(exp->common.blk, offset, size, buf, 0);
> +    buffer =3D qemu_try_blockalign(blk_bs(exp->common.blk), io_req->size=
);
> +    if (!buffer) {
> +        fuse_reply_err(io_req->req, ENOMEM);
> +        goto cleanup;
> +    }
> +
> +    ret =3D blk_co_pread(exp->common.blk, io_req->offset,
> +                       io_req->size, buffer, 0);
>      if (ret >=3D 0) {
> -        fuse_reply_buf(req, buf, size);
> +        fuse_reply_buf(io_req->req, buffer, io_req->size);
>      } else {
> -        fuse_reply_err(req, -ret);
> +        fuse_reply_err(io_req->req, -ret);
> +    }
> +
> +    qemu_vfree(buffer);
> +
> +cleanup:
> +    if (qatomic_fetch_dec(&exp->in_flight) =3D=3D 1) {
> +        aio_wait_kick(); /* wake AIO_WAIT_WHILE() */
>      }
> =20
> -    qemu_vfree(buf);
> +    blk_exp_unref(&exp->common);
> +
> +    g_free(io_req);
>  }
> =20
> -/**
> - * Handle client writes to the exported image.
> - */
> -static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
> -                       size_t size, off_t offset, struct fuse_file_info =
*fi)
> +static void coroutine_fn fuse_write_coroutine(void *opaque)
>  {
> -    FuseExport *exp =3D fuse_req_userdata(req);
> +    FuseIORequest *io_req =3D opaque;
> +    FuseExport *exp =3D io_req->exp;
>      int64_t length;
>      int ret;
> =20
> -    /* Limited by max_write, should not happen */
> -    if (size > BDRV_REQUEST_MAX_BYTES) {
> -        fuse_reply_err(req, EINVAL);
> -        return;
> +    if (io_req->size > BDRV_REQUEST_MAX_BYTES) {
> +        fuse_reply_err(io_req->req, EINVAL);
> +        goto cleanup;
>      }
> =20
>      if (!exp->writable) {
> -        fuse_reply_err(req, EACCES);
> -        return;
> +        fuse_reply_err(io_req->req, EACCES);
> +        goto cleanup;
>      }
> =20
> -    /**
> -     * Clients will expect short writes at EOF, so we have to limit
> -     * offset+size to the image length.
> -     */
>      length =3D blk_getlength(exp->common.blk);
>      if (length < 0) {
> -        fuse_reply_err(req, -length);
> -        return;
> +        fuse_reply_err(io_req->req, -length);
> +        goto cleanup;
>      }
> =20
> -    if (offset + size > length) {
> +    if (io_req->offset + io_req->size > length) {
>          if (exp->growable) {
> -            ret =3D fuse_do_truncate(exp, offset + size, true, PREALLOC_=
MODE_OFF);
> +            ret =3D fuse_do_truncate(exp, io_req->offset + io_req->size,
> +                                   true, PREALLOC_MODE_OFF);
>              if (ret < 0) {
> -                fuse_reply_err(req, -ret);
> -                return;
> +                fuse_reply_err(io_req->req, -ret);
> +                goto cleanup;
>              }
>          } else {
> -            size =3D length - offset;
> +            io_req->size =3D MAX(0, length - io_req->offset);
> +            if (io_req->size =3D=3D 0) {
> +                fuse_reply_write(io_req->req, 0);
> +                goto cleanup;
> +            }
>          }
>      }
> =20
> -    ret =3D blk_pwrite(exp->common.blk, offset, size, buf, 0);
> +    ret =3D blk_co_pwrite(exp->common.blk, io_req->offset, io_req->size,
> +                        io_req->write_buf, 0);
>      if (ret >=3D 0) {
> -        fuse_reply_write(req, size);
> +        fuse_reply_write(io_req->req, io_req->size);
>      } else {
> -        fuse_reply_err(req, -ret);
> +        fuse_reply_err(io_req->req, -ret);
> +    }
> +
> +cleanup:
> +    if (qatomic_fetch_dec(&exp->in_flight) =3D=3D 1) {
> +        aio_wait_kick(); /* wake AIO_WAIT_WHILE() */
>      }
> +
> +    blk_exp_unref(&exp->common);
> +
> +    g_free(io_req->write_buf);
> +    g_free(io_req);
> +}
> +
> +/**
> + * Handle client reads from the exported image.
> + */
> +static void fuse_read(fuse_req_t req, fuse_ino_t inode,
> +                      size_t size, off_t offset, struct fuse_file_info *=
fi)
> +{
> +    FuseExport *exp =3D fuse_req_userdata(req);
> +    FuseIORequest *io_req =3D g_new(FuseIORequest, 1);
> +
> +    *io_req =3D (FuseIORequest) {
> +        .req =3D req,
> +        .size =3D size,
> +        .offset =3D offset,
> +        .exp =3D exp,
> +    };
> +
> +    Coroutine *co =3D qemu_coroutine_create(fuse_read_coroutine, io_req);
> +    qemu_coroutine_enter(co);
> +}
> +
> +
> +/**
> + * Handle client writes to the exported image.
> + */
> +static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
> +                       size_t size, off_t offset, struct fuse_file_info =
*fi)
> +{
> +    FuseExport *exp =3D fuse_req_userdata(req);
> +    FuseIORequest *io_req =3D g_new(FuseIORequest, 1);
> +
> +    *io_req =3D (FuseIORequest) {
> +        .req =3D req,
> +        .size =3D size,
> +        .offset =3D offset,
> +        .exp =3D exp,
> +        .write_buf =3D g_memdup2_qemu(buf, size),
> +    };
> +
> +    Coroutine *co =3D qemu_coroutine_create(fuse_write_coroutine, io_req=
);
> +    qemu_coroutine_enter(co);
>  }
> =20
>  /**
> --=20
> 2.34.1
>=20

--s+NNU7avonaiVvLf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfYjkgACgkQnKSrs4Gr
c8gRUgf/VdYmTOZFYgCIFu0b/+igX+tm4EmzTY6eIT9llJuX6tC/N5RthvvIuTI2
kczVyQ7veoIZnKrUi53XbV+BtHpmJ6M0GKrrXTJ/BnOn0FbjeIBMKVxDascn2Pfm
z6Qs8odG/L9jZZ8o9Yjqrs4s4Gs9GUqCKhNAYZBvRPxWUmp+vEYmTZ+WtIttFOVK
/CwXCJhDweCeMCrr5AzBDuSNtJ44hCVGzU6RtSm2QhDOqBOAVPAtHRg2bUmpuN4R
J8qG0ApNj53wvCeNFfNV9KQiAoaLHUnNBVNTG41BxykjiX749CRMggtGMgeAu2UT
rs1TCnpKoWj46Z7qy+7dj62kTWy2gg==
=woYw
-----END PGP SIGNATURE-----

--s+NNU7avonaiVvLf--


