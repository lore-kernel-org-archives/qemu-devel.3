Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FA1C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 17:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNElW-0001bA-BV; Thu, 05 Jun 2025 13:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNElT-0001ah-UW
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 13:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNElS-0003Iq-27
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 13:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749145948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hmV21X3n5ywQmHSeeY0T9URNLQ50FOneY37fYVmnTPw=;
 b=Q3048zBQ6pkIcoAMaz2KpCG41b7VIMKAltqqpLLAXfjSVScDf4eqMFf6Beneg0esMLUsFt
 c2ZXU6CARuoFbCIdFlpYICyb+RNEUZ2gM1FFvjbI10HjEBQE2B1W0svpbIJGKR8OFL8ChG
 ibVTLdr3fGT/6xBGiZMP3UQcKe8/bGM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-tBQBwwkNO96p5L9WWgPjhA-1; Thu,
 05 Jun 2025 13:52:27 -0400
X-MC-Unique: tBQBwwkNO96p5L9WWgPjhA-1
X-Mimecast-MFC-AGG-ID: tBQBwwkNO96p5L9WWgPjhA_1749145946
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EEF018002B5; Thu,  5 Jun 2025 17:52:26 +0000 (UTC)
Received: from localhost (unknown [10.2.16.172])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B1F6195E74A; Thu,  5 Jun 2025 17:52:25 +0000 (UTC)
Date: Thu, 5 Jun 2025 13:52:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hibriansong@gmail.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [RFC 09/11] aio-posix: add aio_add_sqe() API for user-defined
 io_uring requests
Message-ID: <20250605175224.GA481264@fedora>
References: <20250528190916.35864-1-stefanha@redhat.com>
 <20250528190916.35864-10-stefanha@redhat.com>
 <lwn6k4zy3rovxboe4lia46islqxaagpklba2mggqxinsvy2u7k@yhthtmjlh2mn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C+HwCitDK/rRcK4f"
Content-Disposition: inline
In-Reply-To: <lwn6k4zy3rovxboe4lia46islqxaagpklba2mggqxinsvy2u7k@yhthtmjlh2mn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--C+HwCitDK/rRcK4f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 03:02:16PM -0500, Eric Blake wrote:
> On Wed, May 28, 2025 at 03:09:14PM -0400, Stefan Hajnoczi wrote:
> > Introduce the aio_add_sqe() API for submitting io_uring requests in the
> > current AioContext. This allows other components in QEMU, like the block
> > layer, to take advantage of io_uring features without creating their own
> > io_uring context.
> >=20
> > This API supports nested event loops just like file descriptor
> > monitoring and BHs do. This comes at a complexity cost: a BH is required
> > to dispatch CQE callbacks and they are placed on a list so that a nested
> > event loop can invoke its parent's pending CQE callbacks. If you're
> > wondering why CqeHandler exists instead of just a callback function
> > pointer, this is why.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
>=20
> Large patch.  I found a couple of nits, but the overall design looks
> sound.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> >  include/block/aio.h   |  82 ++++++++++++++++++++++++
> >  util/aio-posix.h      |   1 +
> >  util/aio-posix.c      |   9 +++
> >  util/fdmon-io_uring.c | 145 +++++++++++++++++++++++++++++++-----------
> >  4 files changed, 200 insertions(+), 37 deletions(-)
> >=20
> > diff --git a/include/block/aio.h b/include/block/aio.h
> > index d919d7c8f4..95beef28c3 100644
> > --- a/include/block/aio.h
> > +++ b/include/block/aio.h
> > @@ -61,6 +61,27 @@ typedef struct LuringState LuringState;
> >  /* Is polling disabled? */
> >  bool aio_poll_disabled(AioContext *ctx);
> > =20
> > +#ifdef CONFIG_LINUX_IO_URING
> > +/*
> > + * Each io_uring request must have a unique CqeHandler that processes =
the cqe.
> > + * The lifetime of a CqeHandler must be at least from aio_add_sqe() un=
til
> > + * ->cb() invocation.
> > + */
> > +typedef struct CqeHandler CqeHandler;
> > +struct CqeHandler {
> > +    /* Called by the AioContext when the request has completed */
> > +    void (*cb)(CqeHandler *handler);
>=20
> I see an opaque callback pointer in prep_cqe below, but not one here.
> Is that because callers can write their own struct that includes a
> CqeHandler as its first member, if more state is needed?

Yes.

>=20
> > +
> > +    /* Used internally, do not access this */
> > +    QSIMPLEQ_ENTRY(CqeHandler) next;
> > +
> > +    /* This field is filled in before ->cb() is called */
> > +    struct io_uring_cqe cqe;
> > +};
> > +
> > +typedef QSIMPLEQ_HEAD(, CqeHandler) CqeHandlerSimpleQ;
> > +#endif /* CONFIG_LINUX_IO_URING */
> > +
> >  /* Callbacks for file descriptor monitoring implementations */
> >  typedef struct {
> >      /*
> > @@ -138,6 +159,27 @@ typedef struct {
> >       * Called with list_lock incremented.
> >       */
> >      void (*gsource_dispatch)(AioContext *ctx, AioHandlerList *ready_li=
st);
> > +
> > +#ifdef CONFIG_LINUX_IO_URING
> > +    /**
> > +     * aio_add_sqe: Add an io_uring sqe for submission.
> > +     * @prep_sqe: invoked with an sqe that should be prepared for subm=
ission
> > +     * @opaque: user-defined argument to @prep_sqe()
> > +     * @cqe_handler: the unique cqe handler associated with this reque=
st
> > +     *
> > +     * The caller's @prep_sqe() function is invoked to fill in the det=
ails of
> > +     * the sqe. Do not call io_uring_sqe_set_data() on this sqe.
> > +     *
> > +     * The kernel may see the sqe as soon as @pre_sqe() returns or it =
may take
>=20
> prep_sqe

Oops, will fix.

>=20
> > +     * until the next event loop iteration.
> > +     *
> > +     * This function is called from the current AioContext and is not
> > +     * thread-safe.
> > +     */
> > +    void (*add_sqe)(AioContext *ctx,
> > +                    void (*prep_sqe)(struct io_uring_sqe *sqe, void *o=
paque),
> > +                    void *opaque, CqeHandler *cqe_handler);
> > +#endif /* CONFIG_LINUX_IO_URING */
> >  } FDMonOps;
> > =20
> >  /*
> > @@ -255,6 +297,10 @@ struct AioContext {
> >      struct io_uring fdmon_io_uring;
> >      AioHandlerSList submit_list;
> >      gpointer io_uring_fd_tag;
> > +
> > +    /* Pending callback state for cqe handlers */
> > +    CqeHandlerSimpleQ cqe_handler_ready_list;
> > +    QEMUBH *cqe_handler_bh;
> >  #endif
>=20
> While here, is it worth adding a comment to state which matching #if
> it ends (similar to what you did above in FDMonOps add_sqe)?

Sounds good.

>=20
> > =20
> >      /* TimerLists for calling timers - one per clock type.  Has its own
> > @@ -761,4 +807,40 @@ void aio_context_set_aio_params(AioContext *ctx, i=
nt64_t max_batch);
> >   */
> >  void aio_context_set_thread_pool_params(AioContext *ctx, int64_t min,
> >                                          int64_t max, Error **errp);
> > +
> > +#ifdef CONFIG_LINUX_IO_URING
> > +/**
> > + * aio_has_io_uring: Return whether io_uring is available.
> > + *
> > + * io_uring is either available in all AioContexts or in none, so this=
 only
> > + * needs to be called once from within any thread's AioContext.
> > + */
> > +static inline bool aio_has_io_uring(void)
> > +{
> > +    AioContext *ctx =3D qemu_get_current_aio_context();
> > +    return ctx->fdmon_ops->add_sqe;
> > +}
> > +
> > +/**
> > + * aio_add_sqe: Add an io_uring sqe for submission.
> > + * @prep_sqe: invoked with an sqe that should be prepared for submissi=
on
> > + * @opaque: user-defined argument to @prep_sqe()
> > + * @cqe_handler: the unique cqe handler associated with this request
> > + *
> > + * The caller's @prep_sqe() function is invoked to fill in the details=
 of the
> > + * sqe. Do not call io_uring_sqe_set_data() on this sqe.
> > + *
> > + * The sqe is submitted by the current AioContext. The kernel may see =
the sqe
> > + * as soon as @pre_sqe() returns or it may take until the next event l=
oop
>=20
> prep_sqe

Will fix.

--C+HwCitDK/rRcK4f
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhB2VgACgkQnKSrs4Gr
c8hxhQgAw26cqYLCYcIv2LvplPKNSUQvdcql0prvdYFNVgfs6BhYlCT19Hhpl6u2
rfCFAAeGYrsQSCjOfu26UOJ4KWJ+u5PdD2oiiD94o5FVMOpow3ZkrZXODIoldkqf
L0OLsQsU34NJ4cNjbse26sWiEi+2UMe2VIwE++jOr2yDTLBPzkjVlP+h7P2kiU4U
cm8iGHi+uS+Gz4J08nZmkezyxH+WMENfgkYpQgYuskCJLWUXF8e8Upl5S6PBuwMC
ew19K4JWOYZ3I5W5GBABWoAVMTD7d+xemkvr+LZ0Dqny/zG4BTmkzLVUfGinuxJU
+GuGAgdTzrW4K5UbNF0QX4Ko0G1nmg==
=2mUG
-----END PGP SIGNATURE-----

--C+HwCitDK/rRcK4f--


