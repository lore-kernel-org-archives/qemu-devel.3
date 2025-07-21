Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D707DC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 18:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udv2c-0005yY-EA; Mon, 21 Jul 2025 14:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udv2O-0005Ky-8k
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 14:15:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udv2K-0001o9-24
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 14:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753121690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a9+d0gHd+lkXWBLMmpnyz0FnR4+RWV8vsaGYoNwnF3M=;
 b=IJYeyJwdQk2ZFaUACNk8VBnTgfp08Hwi3F5OekzpocLzO+nq6li3zDLRe3XJqJGX11NzGI
 /VXsS6GWIoHWPyMzGjndRTrNB+vejMyJ+9zLBOwCSPPlbcrH17IYOjJaJf2JyLk5W3hliy
 9/bvD9fC1sc0TAbvEmW9dDS6c/dXrLo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-CjYF935vOO2FoM7JxD_zqQ-1; Mon,
 21 Jul 2025 14:14:47 -0400
X-MC-Unique: CjYF935vOO2FoM7JxD_zqQ-1
X-Mimecast-MFC-AGG-ID: CjYF935vOO2FoM7JxD_zqQ_1753121686
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B999D195FD1B; Mon, 21 Jul 2025 18:14:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.31])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7ECB91955F4A; Mon, 21 Jul 2025 18:14:44 +0000 (UTC)
Date: Mon, 21 Jul 2025 14:14:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, eblake@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Aarushi Mehta <mehta.aaru20@gmail.com>, hibriansong@gmail.com
Subject: Re: [PATCH v2 01/12] aio-posix: fix race between io_uring CQE and
 AioHandler deletion
Message-ID: <20250721181443.GD47107@fedora>
References: <20250620000829.1426291-1-stefanha@redhat.com>
 <20250620000829.1426291-2-stefanha@redhat.com>
 <aGUhxUhGk7dx4fd-@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="46SzC9C+bT2eSxbT"
Content-Disposition: inline
In-Reply-To: <aGUhxUhGk7dx4fd-@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--46SzC9C+bT2eSxbT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 02, 2025 at 02:10:45PM +0200, Kevin Wolf wrote:
> Am 20.06.2025 um 02:08 hat Stefan Hajnoczi geschrieben:
> > When an AioHandler is enqueued on ctx->submit_list for removal, the
> > fill_sq_ring() function will submit an io_uring POLL_REMOVE operation to
> > cancel the in-flight POLL_ADD operation.
> >=20
> > There is a race when another thread enqueues an AioHandler for deletion
> > on ctx->submit_list when the POLL_ADD CQE has already appeared. In that
> > case POLL_REMOVE is unnecessary. The code already handled this, but
> > forgot that the AioHandler itself is still on ctx->submit_list when the
> > POLL_ADD CQE is being processed. It's unsafe to delete the AioHandler at
> > that point in time (use-after-free).
> >=20
> > Solve this problem by keeping the AioHandler alive but setting a flag so
> > that it will be deleted by fill_sq_ring() when it runs.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  util/fdmon-io_uring.c | 26 +++++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
> > index b0d68bdc44..2e40fff09a 100644
> > --- a/util/fdmon-io_uring.c
> > +++ b/util/fdmon-io_uring.c
> > @@ -52,9 +52,10 @@ enum {
> >      FDMON_IO_URING_ENTRIES  =3D 128, /* sq/cq ring size */
> > =20
> >      /* AioHandler::flags */
> > -    FDMON_IO_URING_PENDING  =3D (1 << 0),
> > -    FDMON_IO_URING_ADD      =3D (1 << 1),
> > -    FDMON_IO_URING_REMOVE   =3D (1 << 2),
> > +    FDMON_IO_URING_PENDING            =3D (1 << 0),
> > +    FDMON_IO_URING_ADD                =3D (1 << 1),
> > +    FDMON_IO_URING_REMOVE             =3D (1 << 2),
> > +    FDMON_IO_URING_DELETE_AIO_HANDLER =3D (1 << 3),
> >  };
> > =20
> >  static inline int poll_events_from_pfd(int pfd_events)
> > @@ -218,6 +219,9 @@ static void fill_sq_ring(AioContext *ctx)
> >          if (flags & FDMON_IO_URING_REMOVE) {
> >              add_poll_remove_sqe(ctx, node);
> >          }
> > +        if (flags & FDMON_IO_URING_DELETE_AIO_HANDLER) {
> > +            QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers, node, no=
de_deleted);
> > +        }
> >      }
> >  }
>=20
> Why is it safe to add new SQEs for the node and then add it to
> ctx->deleted_aio_handlers without waiting for the CQEs first?  I
> expected this to be the first check in the loop iteration and to
> contain a 'continue;' statement.
>=20
> The POLL_REMOVE case is clear when looking at more context, it doesn't
> pass the node. As for POLL_ADD, I suppose both flags are actually never
> set together in practice because FDMON_IO_URING_DELETE_AIO_HANDLER is
> only set when processing the CQE of POLL_ADD, so no new POLL_ADD for the
> same node will be pending yet. And checking the callers, I see that
> adding is only ever done with newly allocated nodes, so something like
> removing and re-adding the same node doesn't happen either.
>=20
> Could we then assert that FDMON_IO_URING_DELETE_AIO_HANDLER is never
> combined with FDMON_IO_URING_ADD, but always with FDMON_IO_URING_REMOVE,
> to make the assumptions more explicit?

Yes, the new flag cannot be set at the same time as ADD and is always
set together with REMOVE. I made that assumption in the code, which is a
bit ugly now that you mention it.

An assert is a good idea, that will make the code clearer and more
robust. Thanks!

>=20
> > @@ -347,10 +356,13 @@ void fdmon_io_uring_destroy(AioContext *ctx)
> >              unsigned flags =3D qatomic_fetch_and(&node->flags,
> >                      ~(FDMON_IO_URING_PENDING |
> >                        FDMON_IO_URING_ADD |
> > -                      FDMON_IO_URING_REMOVE));
> > +                      FDMON_IO_URING_REMOVE |
> > +                      FDMON_IO_URING_DELETE_AIO_HANDLER));
> > =20
> > -            if (flags & FDMON_IO_URING_REMOVE) {
> > -                QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers, node=
, node_deleted);
> > +            if ((flags & FDMON_IO_URING_REMOVE) ||
> > +                (flags & FDMON_IO_URING_DELETE_AIO_HANDLER)) {
>=20
> If my conclusion above is right, FDMON_IO_URING_REMOVE will be set in
> both cases, so checking FDMON_IO_URING_DELETE_AIO_HANDLER is redundant.
> Maybe assert this, too, when setting FDMON_IO_URING_DELETE_AIO_HANDLER.

Will fix in v3.

Stefan

--46SzC9C+bT2eSxbT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh+g5MACgkQnKSrs4Gr
c8jXVAf/fYBBG8tpM7A9k7tPph0YeybdU3lanz2TyqXhsj8XIqmXSPnmoALUz4VU
tbdXVPgX+OSQhlWw8vBDGWZzuFhS3Z4whNjoRU/oWOR3sSQpI3AKsMzKigRKveoP
ST4YGlviLah7RNpiiuw+ZlXKRGqzAiW5qzGNLF9Cpmh4No505Bna+0/tkeK43OJu
rd8SdtMK/mmKFnJUqAhH1vGgI7rvg0SGPU6rL0S3XdjG72HUMGrhgqT8GWuYUm5p
xDpzPBEuVagDUE5Wk8azdca+llWkEqrIVRQV6ZyBrnPhDwF0PkgXZrvtNUc9Ndxv
5wQNQgzZrT8pxYS5zD5TspHerp33Dg==
=eCky
-----END PGP SIGNATURE-----

--46SzC9C+bT2eSxbT--


