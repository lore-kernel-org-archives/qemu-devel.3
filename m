Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BBAC28B2E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 08:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tse6d-0005Wo-2A; Thu, 13 Mar 2025 04:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tse6a-0005Vt-Vt
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 04:39:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tse6Y-0004bx-0K
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 04:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741855189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AUV4fDzeO0ZdbT5yNMQVDjfUwAzJLJtSMNcjvq6HUBY=;
 b=MrWcCw/WdZlG3AhHQ8L/V3cNlJJeNu4ULZ6PC/6X1tJx+cbUfDwyMtrah816j/s7vOeBBe
 Mh1Acqx4xIfwTIvoFMAniw6a6cavPC7I6bHVGfgsfwc8WTr83b35WzR9KK/FKORfNchCag
 MzVx59UJWNeIJr6RyBYi5yUV+6Id+MY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-0f2d0iORO76K9u8PYa9qkw-1; Thu,
 13 Mar 2025 04:39:47 -0400
X-MC-Unique: 0f2d0iORO76K9u8PYa9qkw-1
X-Mimecast-MFC-AGG-ID: 0f2d0iORO76K9u8PYa9qkw_1741855186
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EFE819560AE; Thu, 13 Mar 2025 08:39:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.45])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 999D61955F2D; Thu, 13 Mar 2025 08:39:44 +0000 (UTC)
Date: Thu, 13 Mar 2025 16:39:41 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: saz97 <sa.z@qq.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org,
 hreitz@redhat.com
Subject: Re: [PATCH 1/2] Demo for integration coroutin into fuse export
Message-ID: <20250313083941.GA1088852@fedora>
References: <tencent_804E383A2E66E5311E555C748FB8E8109A07@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="l8cwpl+WvGHabHH5"
Content-Disposition: inline
In-Reply-To: <tencent_804E383A2E66E5311E555C748FB8E8109A07@qq.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--l8cwpl+WvGHabHH5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 02:22:05PM +0800, saz97 wrote:

The email subject says [PATCH 1/2] but I only see one patch email. The
second patch is at the bottom of this email. Please send each patch in a
separate email with email threading (this is what git-send-email(1) does
by default) in the future.

There is a website with useful git-send-email(1) setup advice here:
https://git-send-email.io/. You can test your patch emails by sending
them to yourself with `git send-email --to sa.z@qq.com ...`.

It would be nice to actually merge this once code review discussion has
completed. It will be necessary to have a commit description for each
patch to explains its purpose. Performance results demonstrating the
advantage of supporting higher queue depths are also needed.

> Signed-off-by: Changzhi Xie <sa.z@qq.com>
> ---
>  block/export/fuse.c | 167 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 114 insertions(+), 53 deletions(-)
>=20
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index 465cc9891d..f47117a00d 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c
> @@ -64,6 +64,16 @@ typedef struct FuseExport {
>      gid_t st_gid;
>  } FuseExport;
> =20
> +typedef struct FuseIORequest {
> +    fuse_req_t req;
> +    fuse_ino_t inode;
> +    size_t size;
> +    off_t offset;
> +    struct fuse_file_info *fi;
> +    FuseExport *exp;
> +    char *write_buf;
> +} FuseIORequest;
> +
>  static GHashTable *exports;
>  static const struct fuse_lowlevel_ops fuse_ops;
> =20
> @@ -570,102 +580,153 @@ static void fuse_open(fuse_req_t req, fuse_ino_t =
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
> +    }
> +
> +    buffer =3D qemu_try_blockalign(blk_bs(exp->common.blk), io_req->size=
);
> +    if (!buffer) {
> +        fuse_reply_err(io_req->req, ENOMEM);
> +        goto cleanup;
>      }
> =20
> -    ret =3D blk_pread(exp->common.blk, offset, size, buf, 0);
> +    ret =3D blk_co_pread(exp->common.blk, io_req->offset,
> +                       io_req->size, buffer, 0);
>      if (ret >=3D 0) {
> -        fuse_reply_buf(req, buf, size);
> +        fuse_reply_buf(io_req->req, buffer, io_req->size);
>      } else {
> -        fuse_reply_err(req, -ret);
> +        fuse_reply_err(io_req->req, -ret);
>      }
> =20
> -    qemu_vfree(buf);
> +    qemu_vfree(buffer);
> +
> +cleanup:
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
>      }
> +
> +cleanup:
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
> +    io_req->req =3D req;
> +    io_req->inode =3D inode;
> +    io_req->size =3D size;
> +    io_req->offset =3D offset;
> +    io_req->fi =3D fi;
> +    io_req->exp =3D exp;
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
> +    io_req->write_buf =3D g_try_malloc(size);
> +    if (!io_req->write_buf) {
> +        fuse_reply_err(req, ENOMEM);
> +        g_free(io_req);
> +        return;
> +    }
> +    memcpy(io_req->write_buf, buf, size);
> +
> +    io_req->req =3D req;
> +    io_req->inode =3D inode;
> +    io_req->size =3D size;
> +    io_req->offset =3D offset;
> +    io_req->fi =3D fi;
> +    io_req->exp =3D exp;
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
>=20
> From 3d2d317a49eb4cbf401294c6e19c72533eeeefad Mon Sep 17 00:00:00 2001
> From: saz97 <sa.z@qq.com>
> Date: Wed, 12 Mar 2025 13:47:01 +0800
> Subject: [PATCH 2/2] allocate independent fuse_buffor each coroutine and =
store
>  fuse_file_info copy instead of pointerin FuseIORequest

Reviewers appreciate it when a patch series is a sequence of logical
changes without intermediate steps (like "fix typo", etc) modifying
earlier code changes. That way reviewers don't spend time reviewing and
commenting on code that will be replaced immediately.

Please squash this patch into the previous one. This can be done with
`git rebase -i` and its "squash" command.

>=20
> Signed-off-by: Changzhi Xie <sa.z@qq.com>
> ---
>  block/export/fuse.c | 45 ++++++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 21 deletions(-)
>=20
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index f47117a00d..69ffe4f0ca 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c
> @@ -69,7 +69,7 @@ typedef struct FuseIORequest {
>      fuse_ino_t inode;
>      size_t size;
>      off_t offset;
> -    struct fuse_file_info *fi;
> +    struct fuse_file_info fi;
>      FuseExport *exp;
>      char *write_buf;
>  } FuseIORequest;
> @@ -298,6 +298,10 @@ fail:
>  static void read_from_fuse_export(void *opaque)
>  {
>      FuseExport *exp =3D opaque;
> +    struct fuse_buf buf =3D {
> +        .mem =3D g_malloc(FUSE_MAX_BOUNCE_BYTES),
> +        .size =3D FUSE_MAX_BOUNCE_BYTES,
> +    };

libfuse's lib/fuse_lowlevel.c:_fuse_session_receive_buf() allocates the
memory as needed. It should be freed using fuse_buf_free(). Is it
possible to use just `struct fuse_buf buf =3D {};` and let libfuse
automatically allocate memory?

>      int ret;
> =20
>      blk_exp_ref(&exp->common);
> @@ -314,6 +318,7 @@ static void read_from_fuse_export(void *opaque)
>      fuse_session_process_buf(exp->fuse_session, &exp->fuse_buf);
> =20
>  out:
> +    g_free(buf.mem);

fuse_session_process_buf() can return while the coroutine still exists,
so it's not safe to free the buffer here.

>      if (qatomic_fetch_dec(&exp->in_flight) =3D=3D 1) {
>          aio_wait_kick(); /* wake AIO_WAIT_WHILE() */
>      }

This assumes the request has already completed, but now there's a
coroutine that might still exist. Please take a look at
read_from_fuse_export() and think about how to put the in_flight
decrement and blk_exp_unref() into the coroutine so it only happens when
the request finishes.

> @@ -689,12 +694,15 @@ static void fuse_read(fuse_req_t req, fuse_ino_t in=
ode,
>  {
>      FuseExport *exp =3D fuse_req_userdata(req);
>      FuseIORequest *io_req =3D g_new(FuseIORequest, 1);
> -    io_req->req =3D req;
> -    io_req->inode =3D inode;
> -    io_req->size =3D size;
> -    io_req->offset =3D offset;
> -    io_req->fi =3D fi;
> -    io_req->exp =3D exp;
> +
> +    *io_req =3D (FuseIORequest) {
> +        .req =3D req,
> +        .inode =3D inode,
> +        .size =3D size,
> +        .offset =3D offset,
> +        .exp =3D exp,
> +        .fi =3D *fi,
> +    };

I'm not sure if FuseIORequest is necessary. If read_from_fuse_export()
creates a coroutine that reads and processes the next request, then it
should be possible to implement the request directly in
fuse_write()/fuse_write() without an intermediate request struct. That
would be simpler, avoid the io_req heap allocation, and require less
code.

> =20
>      Coroutine *co =3D qemu_coroutine_create(fuse_read_coroutine, io_req);
>      qemu_coroutine_enter(co);
> @@ -710,20 +718,15 @@ static void fuse_write(fuse_req_t req, fuse_ino_t i=
node, const char *buf,
>      FuseExport *exp =3D fuse_req_userdata(req);
>      FuseIORequest *io_req =3D g_new(FuseIORequest, 1);
> =20
> -    io_req->write_buf =3D g_try_malloc(size);
> -    if (!io_req->write_buf) {
> -        fuse_reply_err(req, ENOMEM);
> -        g_free(io_req);
> -        return;
> -    }
> -    memcpy(io_req->write_buf, buf, size);
> -
> -    io_req->req =3D req;
> -    io_req->inode =3D inode;
> -    io_req->size =3D size;
> -    io_req->offset =3D offset;
> -    io_req->fi =3D fi;
> -    io_req->exp =3D exp;
> +    *io_req =3D (FuseIORequest) {
> +        .req =3D req,
> +        .inode =3D inode,
> +        .size =3D size,
> +        .offset =3D offset,
> +        .exp =3D exp,
> +        .fi =3D *fi,
> +        .write_buf =3D g_memdup2_qemu(buf, size),
> +    };
> =20
>      Coroutine *co =3D qemu_coroutine_create(fuse_write_coroutine, io_req=
);
>      qemu_coroutine_enter(co);
> --=20
> 2.34.1
>=20

--l8cwpl+WvGHabHH5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfSmc0ACgkQnKSrs4Gr
c8hPYQgArBOUTMS0wm4xEdNvU9NkzZdUyRuGQQ11/pQ7hr6Q3JJ6/Vk8IrcAxvlk
w4RLoekD9WdY++eVdvf+0DAfGrf+Zqwb3zvKs3sa8NzlxT5Q8sLbCG8hjmT5FbQm
QBChNdHdUyLguRiXetn8gXHKylgPW0YaXih3M2HRhM74IU2wSAqFgHqd9rM3EVr/
t02l3ZR/yepsU4F3IKS0ZTyym+Xqi/b5wINXAXg+TojTBlRxqKbZ4drOmGP+WkDJ
Wjmi0lYzFCmVWvCneudXuMDxvUg4/6TeXiCjyx7huJbUBI44bn3O3AAUkHyY9Ihf
vebegonLQDyE/kWCIhWz4vX0krEuCw==
=Auvt
-----END PGP SIGNATURE-----

--l8cwpl+WvGHabHH5--


