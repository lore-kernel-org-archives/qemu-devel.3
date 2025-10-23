Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A30CCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 21:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC2WQ-0008V8-P3; Thu, 23 Oct 2025 17:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vC2WO-0008Tc-7L
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 17:06:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vC2WL-0004R5-Kn
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 17:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761253612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZ8t45d1LdePCn6GrNt0ZSwocF3Fo15nSvk998gDmAA=;
 b=eizwF94gd4gc1I0Wb9zQ6k4aehcQW0g258TfXVFIOGSVGFM9gtttJIjbkxSBsOAWSfdu6X
 ofUuPmjEa6sQmal4vtY+KYb55/4I5QqcQ0tuwdEb/Thk28/83KgNpmtLWhbA7sJuK9pHUO
 EeZh48Xgp0orSj6FLFbSMNTFJC6ql84=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-xeKH9EbtOE2uVmkkSSDRCg-1; Thu,
 23 Oct 2025 17:06:49 -0400
X-MC-Unique: xeKH9EbtOE2uVmkkSSDRCg-1
X-Mimecast-MFC-AGG-ID: xeKH9EbtOE2uVmkkSSDRCg_1761253608
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA1EF1956089; Thu, 23 Oct 2025 21:06:47 +0000 (UTC)
Received: from localhost (unknown [10.2.16.62])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDEB71800451; Thu, 23 Oct 2025 21:06:46 +0000 (UTC)
Date: Thu, 23 Oct 2025 16:09:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 09/12] aio-posix: add aio_add_sqe() API for
 user-defined io_uring requests
Message-ID: <20251023200908.GB62080@fedora>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-10-stefanha@redhat.com>
 <aOkk0NL7IMq3gFVl@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eVCQim5an6GGhmHi"
Content-Disposition: inline
In-Reply-To: <aOkk0NL7IMq3gFVl@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--eVCQim5an6GGhmHi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 05:23:20PM +0200, Kevin Wolf wrote:
> Am 10.09.2025 um 19:57 hat Stefan Hajnoczi geschrieben:
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
>=20
> This is a mechanism that we know from other places in the code like the
> Linux AIO or indeed the old io_uring block driver code, because a BH is
> the only thing that makes sure that the main loop will call into the
> code again later.
>=20
> Do we really need it here, though? This _is_ literally the main loop
> implementation, we don't have to make the main loop call us.
> .need_wait() checks io_uring_cq_ready(), so as long as there are
> unprocessed completions, we know that .wait() will be called in nested
> event loops. We just can't take more than one completion out of the
> queue to process them later for this to work, but have to process them
> one by one as we get them from the ring. But that's what we already do.
>=20
> Am I missing something?
>=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > ---
> > v2:
> > - Fix pre_sqe -> prep_sqe typo [Eric]
> > - Add #endif terminator comment [Eric]
> > ---
> >  include/block/aio.h   |  84 ++++++++++++++++++++++-
> >  util/aio-posix.h      |   1 +
> >  util/aio-posix.c      |   9 +++
> >  util/fdmon-io_uring.c | 152 ++++++++++++++++++++++++++++++++----------
> >  4 files changed, 208 insertions(+), 38 deletions(-)
> >=20
> > diff --git a/include/block/aio.h b/include/block/aio.h
> > index d919d7c8f4..56ea0d47b7 100644
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
>=20
> s/aio_add_sqe/add_sqe/

Thanks, will fix.

>=20
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
> > +     * The kernel may see the sqe as soon as @prep_sqe() returns or it=
 may take
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
> > @@ -255,7 +297,11 @@ struct AioContext {
> >      struct io_uring fdmon_io_uring;
> >      AioHandlerSList submit_list;
> >      gpointer io_uring_fd_tag;
> > -#endif
> > +
> > +    /* Pending callback state for cqe handlers */
> > +    CqeHandlerSimpleQ cqe_handler_ready_list;
> > +    QEMUBH *cqe_handler_bh;
> > +#endif /* CONFIG_LINUX_IO_URING */
> > =20
> >      /* TimerLists for calling timers - one per clock type.  Has its own
> >       * locking.
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
> > + * as soon as @prep_sqe() returns or it may take until the next event =
loop
> > + * iteration.
> > + *
> > + * When the AioContext is destroyed, pending sqes are ignored and their
> > + * CqeHandlers are not invoked.
> > + *
> > + * This function must be called only when aio_has_io_uring() returns t=
rue.
> > + */
> > +void aio_add_sqe(void (*prep_sqe)(struct io_uring_sqe *sqe, void *opaq=
ue),
> > +                 void *opaque, CqeHandler *cqe_handler);
> > +#endif /* CONFIG_LINUX_IO_URING */
> > +
> >  #endif
> > diff --git a/util/aio-posix.h b/util/aio-posix.h
> > index 6f9d97d866..57ef801a5f 100644
> > --- a/util/aio-posix.h
> > +++ b/util/aio-posix.h
> > @@ -36,6 +36,7 @@ struct AioHandler {
> >  #ifdef CONFIG_LINUX_IO_URING
> >      QSLIST_ENTRY(AioHandler) node_submitted;
> >      unsigned flags; /* see fdmon-io_uring.c */
> > +    CqeHandler cqe_handler;
>=20
> Can we either rename this or add a comment to clarify that this is for
> fdmon-internal requests like POLL_ADD/REMOVE?

Will fix.

>=20
> >  #endif
> >      int64_t poll_idle_timeout; /* when to stop userspace polling */
> >      bool poll_ready; /* has polling detected an event? */
> > diff --git a/util/aio-posix.c b/util/aio-posix.c
> > index 800b4debbf..df945312b3 100644
> > --- a/util/aio-posix.c
> > +++ b/util/aio-posix.c
>=20
> > +/* Returns true if a handler became ready */
> > +static bool process_cqe(AioContext *ctx,
> > +                        AioHandlerList *ready_list,
> > +                        struct io_uring_cqe *cqe)
> > +{
> > +    CqeHandler *cqe_handler =3D io_uring_cqe_get_data(cqe);
> > +
> > +    /* poll_timeout and poll_remove have a zero user_data field */
> > +    if (!cqe_handler) {
> > +        return false;
> > +    }
> > +
> > +    /*
> > +     * Special handling for AioHandler cqes. They need ready_list and =
have a
> > +     * return value.
> > +     */
> > +    if (cqe_handler->cb =3D=3D fdmon_special_cqe_handler) {
> > +        AioHandler *node =3D container_of(cqe_handler, AioHandler, cqe=
_handler);
> > +        return process_cqe_aio_handler(ctx, ready_list, node, cqe);
> > +    }
>=20
> Is the reason why we special case internal requests (instead of just
> using the normal mechanism where the callback is actually called) the
> overhead of going through a BH that we don't want to have for every
> event?
>=20
> But if so, why are we okay with the same overhead for other requests?

No, it's special-cased so the AioHandler can be put onto ready_list and
processed by aio_poll() using aio_dispatch_ready_handlers().

There are complications if we try to unify them, with regards to
accounting per-AioHandler polling time and getting the progress boolean
right (the ctx->notifier EventNotifier must not set progress to true
when it becomes readable). Also, it would create two separate paths for
dispatching AioHandlers: the io_uring-specific BH and the non-io_uring
aio_dispatch_ready_handlers().

Maybe we could first unify everything in the existing aio_poll() code,
including non-io_uring aio_dispatch_ready_handlers(), and always using
BHs to dispatch callbacks (including AioHandlers). Then it would
probably be possible for fdmon-io_uring to use BHs for everything too.

I'm not sure if this will simplify things overall though. Let me think
about this in the context of your other reply about processing CQEs
twice...

>=20
> > +
> > +    cqe_handler->cqe =3D *cqe;
> > +    QSIMPLEQ_INSERT_TAIL(&ctx->cqe_handler_ready_list, cqe_handler, ne=
xt);
> > +    qemu_bh_schedule(ctx->cqe_handler_bh);
> > +    return false;
> > +}
> > +
> >  static int process_cq_ring(AioContext *ctx, AioHandlerList *ready_list)
> >  {
> >      struct io_uring *ring =3D &ctx->fdmon_io_uring;
> > @@ -368,6 +438,7 @@ static const FDMonOps fdmon_io_uring_ops =3D {
> >      .gsource_prepare =3D fdmon_io_uring_gsource_prepare,
> >      .gsource_check =3D fdmon_io_uring_gsource_check,
> >      .gsource_dispatch =3D fdmon_io_uring_gsource_dispatch,
> > +    .add_sqe =3D fdmon_io_uring_add_sqe,
> >  };
> > =20
> >  void fdmon_io_uring_setup(AioContext *ctx, Error **errp)
> > @@ -383,6 +454,8 @@ void fdmon_io_uring_setup(AioContext *ctx, Error **=
errp)
> >      }
> > =20
> >      QSLIST_INIT(&ctx->submit_list);
> > +    QSIMPLEQ_INIT(&ctx->cqe_handler_ready_list);
> > +    ctx->cqe_handler_bh =3D aio_bh_new(ctx, cqe_handler_bh, ctx);
> >      ctx->fdmon_ops =3D &fdmon_io_uring_ops;
> >      ctx->io_uring_fd_tag =3D g_source_add_unix_fd(&ctx->source,
> >              ctx->fdmon_io_uring.ring_fd, G_IO_IN);
> > @@ -390,33 +463,38 @@ void fdmon_io_uring_setup(AioContext *ctx, Error =
**errp)
> > =20
> >  void fdmon_io_uring_destroy(AioContext *ctx)
> >  {
> > -    if (ctx->fdmon_ops =3D=3D &fdmon_io_uring_ops) {
> > -        AioHandler *node;
> > +    AioHandler *node;
> > =20
> > -        io_uring_queue_exit(&ctx->fdmon_io_uring);
> > +    if (ctx->fdmon_ops !=3D &fdmon_io_uring_ops) {
> > +        return;
> > +    }
> > =20
> > -        /* Move handlers due to be removed onto the deleted list */
> > -        while ((node =3D QSLIST_FIRST_RCU(&ctx->submit_list))) {
> > -            unsigned flags =3D qatomic_fetch_and(&node->flags,
> > -                    ~(FDMON_IO_URING_PENDING |
> > -                      FDMON_IO_URING_ADD |
> > -                      FDMON_IO_URING_REMOVE |
> > -                      FDMON_IO_URING_DELETE_AIO_HANDLER));
> > +    io_uring_queue_exit(&ctx->fdmon_io_uring);
> > =20
> > -            if ((flags & FDMON_IO_URING_REMOVE) ||
> > -                (flags & FDMON_IO_URING_DELETE_AIO_HANDLER)) {
> > -                QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers,
> > -                                      node, node_deleted);
> > -            }
> > +    /* Move handlers due to be removed onto the deleted list */
> > +    while ((node =3D QSLIST_FIRST_RCU(&ctx->submit_list))) {
> > +        unsigned flags =3D qatomic_fetch_and(&node->flags,
> > +                ~(FDMON_IO_URING_PENDING |
> > +                  FDMON_IO_URING_ADD |
> > +                  FDMON_IO_URING_REMOVE |
> > +                  FDMON_IO_URING_DELETE_AIO_HANDLER));
> > =20
> > -            QSLIST_REMOVE_HEAD_RCU(&ctx->submit_list, node_submitted);
> > +        if ((flags & FDMON_IO_URING_REMOVE) ||
> > +            (flags & FDMON_IO_URING_DELETE_AIO_HANDLER)) {
> > +            QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers,
> > +                                  node, node_deleted);
> >          }
> > =20
> > -        g_source_remove_unix_fd(&ctx->source, ctx->io_uring_fd_tag);
> > -        ctx->io_uring_fd_tag =3D NULL;
> > -
> > -        qemu_lockcnt_lock(&ctx->list_lock);
> > -        fdmon_poll_downgrade(ctx);
> > -        qemu_lockcnt_unlock(&ctx->list_lock);
> > +        QSLIST_REMOVE_HEAD_RCU(&ctx->submit_list, node_submitted);
> >      }
> > +
> > +    g_source_remove_unix_fd(&ctx->source, ctx->io_uring_fd_tag);
> > +    ctx->io_uring_fd_tag =3D NULL;
> > +
> > +    assert(QSIMPLEQ_EMPTY(&ctx->cqe_handler_ready_list));
> > +    qemu_bh_delete(ctx->cqe_handler_bh);
>=20
> These are the only two lines that are actually added in the last hunk
> apart from switching from a big if to an early return. I wonder if the
> improved readability of the diff would be worth a separate patch just
> for the switch to the early return. (But git diff -w is helpful enough
> once you realise what's going on.)

Sure, I'll introduce a patch to do that.

--eVCQim5an6GGhmHi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmj6i2QACgkQnKSrs4Gr
c8jBMwgAmklr2gJWINBM373td9GoxZngvyXKXkY5MPN8adQpm+MTilppfRS3EtNK
gmwQVZZgCm49kr2FI3JVKqQvOQHkhXfEH4IMo6/wlVySQkL+yfsQiSOiHgMJTuJ5
fC2RDHsUVRfmJpWYVOi0kZX0a3esG7169WFdEkqAbaF+GYzqZGI51igAKVtZRT2y
+hz/MMKo/CoErZiA0fhlkwsH6zB3pn2PCbZ+m+YXh2cHMWl8tOm/WLmwD7OqVgp9
Llel69nykcwgAi9y85/D7TrMQvXyPgVwCG0/wu1Ekg1L3E/5bB7t90iKnK8XABD4
/vQ28QvQZoqVG/+bRFqCfaoIJ/8UJg==
=avFQ
-----END PGP SIGNATURE-----

--eVCQim5an6GGhmHi--


