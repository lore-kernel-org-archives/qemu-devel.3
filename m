Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14EDC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 18:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNFVp-0000Ys-Rs; Thu, 05 Jun 2025 14:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNFVn-0000Y7-9x
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 14:40:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNFVk-0005uE-V1
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 14:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749148816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F4jI4RlMbzS61V7WGEti2SOllcaad+ZLmpObqXE6ecE=;
 b=N53FB+NPKTgwsHhrr7+1eqcDC5j2JobUQp0Xb+SHHJ6HaxPa9v79Yrt8k3Fu26OO1PeLDw
 icB0XG8bBNjeWjOzU4EE9gBPyaxr7WPPToxUyS4TtRjzerMrCNuKAC6YNmEQWFn9i8psu4
 FNw6UgRgDfc+jbWJIZe36UWuefFOaV8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-1l-TtkEVO9GUkzoY7GPkxA-1; Thu,
 05 Jun 2025 14:40:12 -0400
X-MC-Unique: 1l-TtkEVO9GUkzoY7GPkxA-1
X-Mimecast-MFC-AGG-ID: 1l-TtkEVO9GUkzoY7GPkxA_1749148811
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DF53195609F; Thu,  5 Jun 2025 18:40:11 +0000 (UTC)
Received: from localhost (unknown [10.2.16.172])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ECC80195E74A; Thu,  5 Jun 2025 18:40:10 +0000 (UTC)
Date: Thu, 5 Jun 2025 14:40:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hibriansong@gmail.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [RFC 11/11] block/io_uring: use aio_add_sqe()
Message-ID: <20250605184009.GB481264@fedora>
References: <20250528190916.35864-1-stefanha@redhat.com>
 <20250528190916.35864-12-stefanha@redhat.com>
 <ofidabivimcy5qpuxqeni6e6lfwvfhutg5nxychdhgqs5cdkrr@nspmykro2ap5>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wAhx5RKjcp1fXJGe"
Content-Disposition: inline
In-Reply-To: <ofidabivimcy5qpuxqeni6e6lfwvfhutg5nxychdhgqs5cdkrr@nspmykro2ap5>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


--wAhx5RKjcp1fXJGe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 04:11:21PM -0500, Eric Blake wrote:
> On Wed, May 28, 2025 at 03:09:16PM -0400, Stefan Hajnoczi wrote:
> > AioContext has its own io_uring instance for file descriptor monitoring.
> > The disk I/O io_uring code was developed separately. Originally I
> > thought the characteristics of file descriptor monitoring and disk I/O
> > were too different, requiring separate io_uring instances.
> >=20
> > Now it has become clear to me that it's feasible to share a single
> > io_uring instance for file descriptor monitoring and disk I/O. We're not
> > using io_uring's IOPOLL feature or anything else that would require a
> > separate instance.
> >=20
> > Unify block/io_uring.c and util/fdmon-io_uring.c using the new
> > aio_add_sqe() API that allows user-defined io_uring sqe submission. Now
> > block/io_uring.c just needs to submit readv/writev/fsync and most of the
> > io_uring-specific logic is handled by fdmon-io_uring.c.
> >=20
> > There are two immediate advantages:
> > 1. Fewer system calls. There is no need to monitor the disk I/O io_uring
> >    ring fd from the file descriptor monitoring io_uring instance. Disk
> >    I/O completions are now picked up directly. Also, sqes are
> >    accumulated in the sq ring until the end of the event loop iteration
> >    and there are fewer io_uring_enter(2) syscalls.
> > 2. Less code duplication.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
>=20
> Comments below, but looks sane to me.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> >  include/block/aio.h     |   7 -
> >  include/block/raw-aio.h |   5 -
> >  block/file-posix.c      |  38 ++--
> >  block/io_uring.c        | 489 ++++++++++------------------------------
> >  stubs/io_uring.c        |  32 ---
> >  util/async.c            |  35 ---
> >  util/fdmon-io_uring.c   |   6 +
> >  block/trace-events      |  12 +-
> >  stubs/meson.build       |   3 -
> >  util/trace-events       |   4 +
> >  10 files changed, 139 insertions(+), 492 deletions(-)
> >  delete mode 100644 stubs/io_uring.c
> >=20
> > diff --git a/include/block/aio.h b/include/block/aio.h
> > index 95beef28c3..fbb45cca74 100644
> > --- a/include/block/aio.h
> > +++ b/include/block/aio.h
> > @@ -291,8 +291,6 @@ struct AioContext {
> >      struct LinuxAioState *linux_aio;
> >  #endif
> >  #ifdef CONFIG_LINUX_IO_URING
> > -    LuringState *linux_io_uring;
> > -
> >      /* State for file descriptor monitoring using Linux io_uring */
> >      struct io_uring fdmon_io_uring;
> >      AioHandlerSList submit_list;
> > @@ -597,11 +595,6 @@ struct LinuxAioState *aio_setup_linux_aio(AioConte=
xt *ctx, Error **errp);
> >  /* Return the LinuxAioState bound to this AioContext */
> >  struct LinuxAioState *aio_get_linux_aio(AioContext *ctx);
> > =20
> > -/* Setup the LuringState bound to this AioContext */
> > -LuringState *aio_setup_linux_io_uring(AioContext *ctx, Error **errp);
> > -
> > -/* Return the LuringState bound to this AioContext */
> > -LuringState *aio_get_linux_io_uring(AioContext *ctx);
> >  /**
> >   * aio_timer_new_with_attrs:
> >   * @ctx: the aio context
> > diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
> > index 6570244496..30e5fc9a9f 100644
> > --- a/include/block/raw-aio.h
> > +++ b/include/block/raw-aio.h
> > @@ -74,15 +74,10 @@ static inline bool laio_has_fua(void)
> >  #endif
> >  /* io_uring.c - Linux io_uring implementation */
> >  #ifdef CONFIG_LINUX_IO_URING
> > -LuringState *luring_init(Error **errp);
> > -void luring_cleanup(LuringState *s);
> > -
> >  /* luring_co_submit: submit I/O requests in the thread's current AioCo=
ntext. */
> >  int coroutine_fn luring_co_submit(BlockDriverState *bs, int fd, uint64=
_t offset,
> >                                    QEMUIOVector *qiov, int type,
> >                                    BdrvRequestFlags flags);
> > -void luring_detach_aio_context(LuringState *s, AioContext *old_context=
);
> > -void luring_attach_aio_context(LuringState *s, AioContext *new_context=
);
> >  bool luring_has_fua(void);
> >  #else
> >  static inline bool luring_has_fua(void)
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 9b5f08ccb2..d1f1fc3a77 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -755,14 +755,23 @@ static int raw_open_common(BlockDriverState *bs, =
QDict *options,
> >      }
> >  #endif /* !defined(CONFIG_LINUX_AIO) */
> > =20
> > -#ifndef CONFIG_LINUX_IO_URING
> >      if (s->use_linux_io_uring) {
> > +#ifdef CONFIG_LINUX_IO_URING
> > +        if (!aio_has_io_uring()) {
>=20
> Compared to the old code... [1]
>=20
> > +            error_setg(errp, "aio=3Dio_uring was specified, but is not=
 "
> > +                             "available (disabled via io_uring_disable=
d "
> > +                             "sysctl or blocked by container runtime "
> > +                             "seccomp policy?)");
> > +            ret =3D -EINVAL;
> > +            goto fail;
> > +        }
> > +#else
> >          error_setg(errp, "aio=3Dio_uring was specified, but is not sup=
ported "
> >                           "in this build.");
>=20
> While here, let's get rid of the trailing '.' in the error_setg call.

Sounds good.

>=20
>=20
> >          ret =3D -EINVAL;
> >          goto fail;
> > -    }
> >  #endif /* !defined(CONFIG_LINUX_IO_URING) */
> > +    }
> > =20
> >      s->has_discard =3D true;
> >      s->has_write_zeroes =3D true;
> > @@ -2522,27 +2531,6 @@ static bool bdrv_qiov_is_aligned(BlockDriverStat=
e *bs, QEMUIOVector *qiov)
> >      return true;
> >  }
> > =20
> > -#ifdef CONFIG_LINUX_IO_URING
> > -static inline bool raw_check_linux_io_uring(BDRVRawState *s)
> > -{
> > -    Error *local_err =3D NULL;
> > -    AioContext *ctx;
> > -
> > -    if (!s->use_linux_io_uring) {
> > -        return false;
> > -    }
> > -
> > -    ctx =3D qemu_get_current_aio_context();
> > -    if (unlikely(!aio_setup_linux_io_uring(ctx, &local_err))) {
>=20
> [1]... is there a reason you dropped the unlikely() wrapper?

raw_check_linux_io_uring() was called from the I/O code path where a
branch prediction hint might make sense for performance reasons. The
raw_open_common() you mentioned above is not in the I/O code path.

Also, the new code in raw_open_common() is not the same as
raw_check_linux_io_uring(). aio_setup_linux_io_uring() no longer exists
in the new code. The patch removes this code entirely, it doesn't just
drop unlikely().

>=20
> > -        error_reportf_err(local_err, "Unable to use linux io_uring, "
> > -                                     "falling back to thread pool: ");
> > -        s->use_linux_io_uring =3D false;
> > -        return false;
> > -    }
> > -    return true;
> > -}
> > -#endif
> > -
> >  #ifdef CONFIG_LINUX_AIO
> >  static inline bool raw_check_linux_aio(BDRVRawState *s)
> >  {
> > @@ -2595,7 +2583,7 @@ static int coroutine_fn raw_co_prw(BlockDriverSta=
te *bs, int64_t *offset_ptr,
> >      if (s->needs_alignment && !bdrv_qiov_is_aligned(bs, qiov)) {
> >          type |=3D QEMU_AIO_MISALIGNED;
> >  #ifdef CONFIG_LINUX_IO_URING
> > -    } else if (raw_check_linux_io_uring(s)) {
> > +    } else if (s->use_linux_io_uring) {
> >          assert(qiov->size =3D=3D bytes);
> >          ret =3D luring_co_submit(bs, s->fd, offset, qiov, type, flags);
> >          goto out;
> > @@ -2692,7 +2680,7 @@ static int coroutine_fn raw_co_flush_to_disk(Bloc=
kDriverState *bs)
> >      };
> > =20
> >  #ifdef CONFIG_LINUX_IO_URING
> > -    if (raw_check_linux_io_uring(s)) {
> > +    if (s->use_linux_io_uring) {
> >          return luring_co_submit(bs, s->fd, 0, NULL, QEMU_AIO_FLUSH, 0);
> >      }
> >  #endif
> > diff --git a/block/io_uring.c b/block/io_uring.c
> > index dd4f304910..dd930ee57e 100644
> > --- a/block/io_uring.c
> > +++ b/block/io_uring.c
> > @@ -11,28 +11,20 @@
> >  #include "qemu/osdep.h"
> >  #include <liburing.h>
> >  #include "block/aio.h"
> > -#include "qemu/queue.h"
> >  #include "block/block.h"
> >  #include "block/raw-aio.h"
> >  #include "qemu/coroutine.h"
> > -#include "qemu/defer-call.h"
> > -#include "qapi/error.h"
> >  #include "system/block-backend.h"
> >  #include "trace.h"
> > =20
> > -/* Only used for assertions.  */
> > -#include "qemu/coroutine_int.h"
> > -
> > -/* io_uring ring size */
> > -#define MAX_ENTRIES 128
> > -
> > -typedef struct LuringAIOCB {
> > +typedef struct {
> >      Coroutine *co;
> > -    struct io_uring_sqe sqeq;
> > -    ssize_t ret;
> >      QEMUIOVector *qiov;
> > -    bool is_read;
> > -    QSIMPLEQ_ENTRY(LuringAIOCB) next;
> > +    uint64_t offset;
> > +    ssize_t ret;
> > +    int type;
> > +    int fd;
> > +    BdrvRequestFlags flags;
> > =20
> >      /*
> >       * Buffered reads may require resubmission, see
> > @@ -40,36 +32,51 @@ typedef struct LuringAIOCB {
> >       */
> >      int total_read;
> >      QEMUIOVector resubmit_qiov;
> > -} LuringAIOCB;
> > =20
> > -typedef struct LuringQueue {
> > -    unsigned int in_queue;
> > -    unsigned int in_flight;
> > -    bool blocked;
> > -    QSIMPLEQ_HEAD(, LuringAIOCB) submit_queue;
> > -} LuringQueue;
> > +    CqeHandler cqe_handler;
> > +} LuringRequest;
> > =20
> > -struct LuringState {
> > -    AioContext *aio_context;
> > -
> > -    struct io_uring ring;
> > -
> > -    /* No locking required, only accessed from AioContext home thread =
*/
> > -    LuringQueue io_q;
> > -
> > -    QEMUBH *completion_bh;
> > -};
> > -
> > -/**
> > - * luring_resubmit:
> > - *
> > - * Resubmit a request by appending it to submit_queue.  The caller mus=
t ensure
> > - * that ioq_submit() is called later so that submit_queue requests are=
 started.
> > - */
> > -static void luring_resubmit(LuringState *s, LuringAIOCB *luringcb)
> > +static void luring_prep_sqe(struct io_uring_sqe *sqe, void *opaque)
> >  {
> > -    QSIMPLEQ_INSERT_TAIL(&s->io_q.submit_queue, luringcb, next);
> > -    s->io_q.in_queue++;
> > +    LuringRequest *req =3D opaque;
> > +    QEMUIOVector *qiov =3D req->qiov;
> > +    uint64_t offset =3D req->offset;
> > +    int fd =3D req->fd;
> > +    BdrvRequestFlags flags =3D req->flags;
> > +
> > +    switch (req->type) {
> > +    case QEMU_AIO_WRITE:
> > +#ifdef HAVE_IO_URING_PREP_WRITEV2
> > +    {
> > +        int luring_flags =3D (flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
> > +        io_uring_prep_writev2(sqe, fd, qiov->iov,
> > +                              qiov->niov, offset, luring_flags);
> > +    }
> > +#else
> > +        assert(flags =3D=3D 0);
> > +        io_uring_prep_writev(sqe, fd, qiov->iov, qiov->niov, offset);
>=20
> Hmm.  'man io_uring_prep_writev2' states:
>=20
>        Unless an application explicitly needs to pass in more than  one  =
iovec,
>        it  is  more  efficient  to  use io_uring_prep_write(3) rather tha=
n this
>        function, as no state has to be maintained for  a  non-vectored  I=
O  re=E2=80=90
>        quest.
>=20
> Obviously, if we want luring_flags of RWF_DSYNC to be set, we have to
> use the newer interface; but if that flag is not present, should we be
> conditionally falling back to the simpler interface when qiov->niov =3D=3D
> 1?

Thanks for the suggestion. I will try it out and benchmark it for v2.

>=20
> In fact, even when qiov->niov > 1, can we unvector it ourselves into
> multiple io_uring_prep_write() calls, since the whole point of the
> uring is that we aren't making syscalls, so more ops on the uring
> should still be cheaper?  But that's a question for a followup patch
> (still, given that your series is RFC for performance reasons, it may
> be worth investigating).

That's more complicated. I won't pursue that for the time being.

--wAhx5RKjcp1fXJGe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhB5IkACgkQnKSrs4Gr
c8gsCAf9GowTdXzBm9EtThLII8u+nFKE35WQeLWLlFw0zXfUDfhzy7MnhlD3dLBz
4A7Ix1ZmlbHJpR+hUIkvsjLQ3xOP+B0xs4qahu3F+56g6JFrFV2ga5HWyYpJj220
thlYDy859g+cO9gzQIZ3G8lqtQR4YaQYaRVMDHc2BE4f31vClzqNDP5cZgNtASyV
GxsSF4QjqlTjdaK1Jt7KqocADmM/e8NVQ8RCorw2FNZFCN7lIwR6iGy3GCiuruDR
7pHmWdb19QOetQwSFMMCio/SD+Ialnqthr7P19DLmqZRkHOYYGOrWQm4RBmnq5+J
auEMom2lJocReEY/0KeoGAcpt7pjwg==
=UDjU
-----END PGP SIGNATURE-----

--wAhx5RKjcp1fXJGe--


