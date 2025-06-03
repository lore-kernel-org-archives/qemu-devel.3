Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7636EC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 18:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMWgm-0002Di-6y; Tue, 03 Jun 2025 14:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uMWgk-0002D1-DJ
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 14:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uMWgi-0006jR-CO
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 14:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748976519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=86/M7/dBmLPCvkCeSbrUkMp3OPlcsHCLLHG58uE+ITo=;
 b=LNZieFvOJ9j1sFR8pwmv/VPsBUum9JSxgH8H+X0Jz8ia0mIpDwe0LGkiFEwstDcaM8u0CQ
 4lueUshvJZGZ0DirRWF24M0Rm85QW1C9szTMpA/qo8+DFawiuZc2ag57xZJIxCG3kuB7pm
 VEd76vOWtml6ezvY55bedG2YybSacgk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-3Yh4g5gFNQ--GyhbYq-2_g-1; Tue,
 03 Jun 2025 14:48:34 -0400
X-MC-Unique: 3Yh4g5gFNQ--GyhbYq-2_g-1
X-Mimecast-MFC-AGG-ID: 3Yh4g5gFNQ--GyhbYq-2_g_1748976513
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA5E4180034E; Tue,  3 Jun 2025 18:48:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.58])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D57C1955D85; Tue,  3 Jun 2025 18:48:32 +0000 (UTC)
Date: Tue, 3 Jun 2025 14:48:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [RFC 08/11] aio-posix: gracefully handle io_uring_queue_init()
 failure
Message-ID: <20250603184830.GA361079@fedora>
References: <20250528190916.35864-1-stefanha@redhat.com>
 <20250528190916.35864-9-stefanha@redhat.com>
 <xamle7lt6fxiphzjkjhzlc7vgid3r4s3k6nqufipruwepb6ef6@l4xjldx5ztuj>
 <20250529153830.GB62516@fedora> <87jz5tbbqx.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GtBR7hhje4Dh6Fze"
Content-Disposition: inline
In-Reply-To: <87jz5tbbqx.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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


--GtBR7hhje4Dh6Fze
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 08:05:58AM +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > On Wed, May 28, 2025 at 05:12:14PM -0500, Eric Blake wrote:
> >> On Wed, May 28, 2025 at 03:09:13PM -0400, Stefan Hajnoczi wrote:
> >> > io_uring may not be available at runtime due to system policies (e.g.
> >> > the io_uring_disabled sysctl) or creation could fail due to file
> >> > descriptor resource limits.
> >> >=20
> >> > Handle failure scenarios as follows:
> >> >=20
> >> > If another AioContext already has io_uring, then fail AioContext
> >> > creation so that the aio_add_sqe() API is available uniformly from a=
ll
> >> > QEMU threads. Otherwise fall back to epoll(7) if io_uring is
> >> > unavailable.
> >> >=20
> >> > Notes:
> >> > - Update the comment about selecting the fastest fdmon implementatio=
n.
> >> >   At this point it's not about speed anymore, it's about aio_add_sqe=
()
> >> >   API availability.
> >> > - Uppercase the error message when converting from error_report() to
> >> >   error_setg_errno() for consistency (but there are instances of
> >> >   lowercase in the codebase).
> >> > - It's easier to move the #ifdefs from aio-posix.h to aio-posix.c.
> >> >=20
> >> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> > ---
> >> >  util/aio-posix.h      | 12 ++----------
> >> >  util/aio-posix.c      | 29 ++++++++++++++++++++++++++---
> >> >  util/fdmon-io_uring.c |  8 ++++----
> >> >  3 files changed, 32 insertions(+), 17 deletions(-)
> >> >=20
> >> > diff --git a/util/aio-posix.h b/util/aio-posix.h
> >> > index f9994ed79e..6f9d97d866 100644
> >> > --- a/util/aio-posix.h
> >> > +++ b/util/aio-posix.h
> >> > @@ -18,6 +18,7 @@
> >> >  #define AIO_POSIX_H
> >> > =20
> >> >  #include "block/aio.h"
> >> > +#include "qapi/error.h"
> >> > =20
> >> >  struct AioHandler {
> >> >      GPollFD pfd;
> >> > @@ -72,17 +73,8 @@ static inline void fdmon_epoll_disable(AioContext=
 *ctx)
> >> >  #endif /* !CONFIG_EPOLL_CREATE1 */
> >> > =20
> >> >  #ifdef CONFIG_LINUX_IO_URING
> >> > -bool fdmon_io_uring_setup(AioContext *ctx);
> >> > +void fdmon_io_uring_setup(AioContext *ctx, Error **errp);
> >>=20
> >> Why change the return type to void?  That forces you to have to check
> >> errp.  If you still return bool (true for errp unchanged, false when
> >> errp set), callers might have a simpler interface.
> >
> > QEMU has both forms. I prefer void foo(Error **errp) because it
> > eliminates these awkward states:
> > 1. Return true with errp set. There is a risk of leaking errp here.
> > 2. Return false with errp NULL. This results in no error message.
> >
> > Sometimes it is handy to have a return value but I think that void is a
> > good default return type.
>=20
> I used to think this way, too.  Experience changed my mind.
>=20
> The "awkward states" are bugs.
>=20
> The price to avoid them is more verbose error handling.  Because such
> bugs have been rare in practice, the vebosity has turned out to be too
> much pain for too little gain.  qapi/error.h's big comment:
>=20
>  * =3D Rules =3D
>  [...]
>  * - Whenever practical, also return a value that indicates success /
>  *   failure.  This can make the error checking more concise, and can
>  *   avoid useless error object creation and destruction.  Note that
>  *   we still have many functions returning void.  We recommend
>  *   =E2=80=A2 bool-valued functions return true on success / false on fa=
ilure,
>  *   =E2=80=A2 pointer-valued functions return non-null / null pointer, a=
nd
>  *   =E2=80=A2 integer-valued functions return non-negative / negative.
>=20
> For what it's worth, this is exactly how GError wants to be used.  We
> deviated from it because we thought we were smarter, and came to regret
> it.
>=20
> Further down, the big comment shows example code:
>=20
>  * Call a function, receive an error from it, and pass it to the caller
>  * - when the function returns a value that indicates failure, say
>  *   false:
>  *     if (!foo(arg, errp)) {
>  *         handle the error...
>  *     }
>  * - when it does not, say because it is a void function:
>  *     ERRP_GUARD();
>  *     foo(arg, errp);
>  *     if (*errp) {
>  *         handle the error...
>  *     }
>  * More on ERRP_GUARD() below.
>  *
>  * Code predating ERRP_GUARD() still exists, and looks like this:
>  *     Error *err =3D NULL;
>  *     foo(arg, &err);
>  *     if (err) {
>  *         handle the error...
>  *         error_propagate(errp, err); // deprecated
>  *     }
>  * Avoid in new code.  Do *not* "optimize" it to
>  *     foo(arg, errp);
>  *     if (*errp) { // WRONG!
>  *         handle the error...
>  *     }
>  * because errp may be NULL without the ERRP_GUARD() guard.
>=20
> In case you think the difference in readability isn't all that big:
> error handling is *everywhere*, and any clutter adds up quickly,
> obscuring the logic.  Every line counts.

Thank you for the pointers! I missed that this was already documented.

I will switch to a bool return type.

>=20
> > I have CCed Markus in case he has suggestions.
>=20
> Thanks for that!
>=20
> >> >  void fdmon_io_uring_destroy(AioContext *ctx);
> >> > -#else
> >> > -static inline bool fdmon_io_uring_setup(AioContext *ctx)
> >> > -{
> >> > -    return false;
> >> > -}
> >> > -
> >> > -static inline void fdmon_io_uring_destroy(AioContext *ctx)
> >> > -{
> >> > -}
> >> >  #endif /* !CONFIG_LINUX_IO_URING */
> >> > =20
> >> >  #endif /* AIO_POSIX_H */
> >> > diff --git a/util/aio-posix.c b/util/aio-posix.c
> >> > index fa047fc7ad..44b3df61f9 100644
> >> > --- a/util/aio-posix.c
> >> > +++ b/util/aio-posix.c
> >> > @@ -16,6 +16,7 @@
> >> >  #include "qemu/osdep.h"
> >> >  #include "block/block.h"
> >> >  #include "block/thread-pool.h"
> >> > +#include "qapi/error.h"
> >> >  #include "qemu/main-loop.h"
> >> >  #include "qemu/lockcnt.h"
> >> >  #include "qemu/rcu.h"
> >> > @@ -717,17 +718,39 @@ void aio_context_setup(AioContext *ctx, Error =
**errp)
> >> >      ctx->epollfd =3D -1;
> >> >      ctx->epollfd_tag =3D NULL;
> >> > =20
> >> > -    /* Use the fastest fd monitoring implementation if available */
> >> > -    if (fdmon_io_uring_setup(ctx)) {
> >> > -        return;
> >> > +#ifdef CONFIG_LINUX_IO_URING
> >> > +    {
> >> > +        static bool need_io_uring;
> >> > +        Error *local_err =3D NULL; /* ERRP_GUARD() doesn't handle e=
rror_abort */
> >>=20
> >> Really? I thought that was part of why we added ERRP_GUARD, so that
> >> error_abort is pinned closer to the spot where the error is triggered
> >> rather than where it was chained.  But your use of errp is a bit
> >> different than usual here, so you may be correct that it doesn't
> >> handle error_abort in the way that you want (allowing a graceful
> >> downgrade to epoll if it is the first failure, but aborting if it is
> >> the second AioContext that fails).
> >
> > The ERRP_GUARD() doc comment explains why it behaves this way:
> >
> >  * Note: &error_abort is not rewritten, because that would move the
> >  * abort from the place where the error is created to the place where
> >  * it's propagated.
>=20
> Error propagation should be avoided when possible.  It's not possible
> here; more on that below.
>=20
> Why avoid?  Two reasons.  One, it degrades stack backtraces, as Eric
> pointed out.  Two, passing @errp directly is more obvious and less
> verbose, as we've seen above.
>=20
> >> > +
> >> > +        /* io_uring takes precedence because it provides aio_add_sq=
e() support */
> >> > +        fdmon_io_uring_setup(ctx, &local_err);
> >> > +        if (!local_err) {
> >> > +            /*
> >> > +             * If one AioContext gets io_uring, then all AioContext=
s need io_uring
> >> > +             * so that aio_add_sqe() support is available across al=
l threads.
> >> > +             */
> >> > +            need_io_uring =3D true;
> >> > +            return;
> >> > +        }
> >> > +        if (need_io_uring) {
> >> > +            error_propagate(errp, local_err);
> >> > +            return;
> >> > +        }
> >> > +
> >> > +        warn_report_err_once(local_err); /* frees local_err */
> >> > +        local_err =3D NULL;
>=20
> This is why we can't avoid error_propagate() here: when
> fdmon_io_uring_setup() fails, we either consume the error and succeed,
> or pass it to the caller and fail.
>=20
> Because of the former, passing @errp to fdmon_io_uring_setup() would be
> wrong; we need to pass a &local_err.  Which we then need to propagate to
> do the latter.
>=20
> Similar code exists elsewhere.  It's fairly rare, though.
>=20
> ERRP_GUARD() is not designed for this pattern.  We have to propragate
> manually.
>=20
> I'd drop the /* ERRP_GUARD() doesn't handle error_abort */ comment.  To
> make sense of it, I believe you need to understand a lot more.  And if
> you do, you don't really need the comment.

Will fix.

>=20
> >> >      }
> >> > +#endif /* CONFIG_LINUX_IO_URING */
> >> > =20
> >> >      fdmon_epoll_setup(ctx);
> >> >  }
> >> > =20
> >> >  void aio_context_destroy(AioContext *ctx)
> >> >  {
> >> > +#ifdef CONFIG_LINUX_IO_URING
> >> >      fdmon_io_uring_destroy(ctx);
> >> > +#endif
> >> > =20
> >> >      qemu_lockcnt_lock(&ctx->list_lock);
> >> >      fdmon_epoll_disable(ctx);
>=20
> [...]
>=20

--GtBR7hhje4Dh6Fze
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmg/Q34ACgkQnKSrs4Gr
c8gwSwf/dsTKAz3OzPlDcly+evc8jUMwU4J8MkGF3bGP+0iL7NqxyDwbtDczEnzb
/hbg8IfMCB1zEF7CfxLHgZ2KMxwhTnEQEFySnedp4XUDfr7IzV+gyzXXNsrpGcQX
2vbWQNbNk3x7J2kiZ0Ulxv3KBKKMifl49BtgHfVfmlLLPuYDzHqoAjnFgNqC+2xj
h+Em+pFn89iz0x7DLSPyhdHelM/hVntj/EJ6irtueP4ieUt4S2SoM4f8orIJ8gEF
nBBlavyxru6F9G5+f5DDb3bOWWdQyAov73OrJZG/8BdnqSVBwDAwBnKZaIjBvZ78
Xs/+E4CPYRor1ZHOBdr8P1Hc1bnUbg==
=FTTY
-----END PGP SIGNATURE-----

--GtBR7hhje4Dh6Fze--


