Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D960DC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 22:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMDcM-0004kq-Tu; Mon, 02 Jun 2025 18:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uMDcL-0004j6-5a
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 18:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uMDcH-0003v8-JC
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 18:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748903201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vREyzAPNyetaPudYg41WmZi10BINRamqQCyggk2mX0k=;
 b=H+GV12tpBPrd7IejVPMXv99OizFUJbgHNylzVWEqk+lt5n3MGg6sO/RMEmvk4SKQOvYcXy
 Yu6k/8XqciEdNRq6sbA6Fqq/Ae2oe68tuKmwi7F+1QigO8424C6h0L7xOsIlioE0a2cinf
 BlnRIRIppxiw5kDwHrVEDM7JtCikMpA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-8Cq7GLTlO3mgM6c7wCTzIQ-1; Mon,
 02 Jun 2025 18:26:40 -0400
X-MC-Unique: 8Cq7GLTlO3mgM6c7wCTzIQ-1
X-Mimecast-MFC-AGG-ID: 8Cq7GLTlO3mgM6c7wCTzIQ_1748903199
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE7E51956086; Mon,  2 Jun 2025 22:26:38 +0000 (UTC)
Received: from localhost (unknown [10.2.16.84])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E28B419560A3; Mon,  2 Jun 2025 22:26:37 +0000 (UTC)
Date: Mon, 2 Jun 2025 16:20:51 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian <hibriansong@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [RFC 08/11] aio-posix: gracefully handle io_uring_queue_init()
 failure
Message-ID: <20250602202051.GE300284@fedora>
References: <20250528190916.35864-1-stefanha@redhat.com>
 <20250528190916.35864-9-stefanha@redhat.com>
 <a0a98436-5e4e-46d1-9a66-b6edce5c0ecc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y4A/9oCcGVBQ8113"
Content-Disposition: inline
In-Reply-To: <a0a98436-5e4e-46d1-9a66-b6edce5c0ecc@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
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


--Y4A/9oCcGVBQ8113
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 02, 2025 at 08:26:39AM -0400, Brian wrote:
> On 5/28/25 3:09 PM, Stefan Hajnoczi wrote:
> > io_uring may not be available at runtime due to system policies (e.g.
> > the io_uring_disabled sysctl) or creation could fail due to file
> > descriptor resource limits.
> >=20
> > Handle failure scenarios as follows:
> >=20
> > If another AioContext already has io_uring, then fail AioContext
> > creation so that the aio_add_sqe() API is available uniformly from all
> > QEMU threads. Otherwise fall back to epoll(7) if io_uring is
> > unavailable.
> >=20
> > Notes:
> > - Update the comment about selecting the fastest fdmon implementation.
> >    At this point it's not about speed anymore, it's about aio_add_sqe()
> >    API availability.
> > - Uppercase the error message when converting from error_report() to
> >    error_setg_errno() for consistency (but there are instances of
> >    lowercase in the codebase).
> > - It's easier to move the #ifdefs from aio-posix.h to aio-posix.c.
> >=20
> > Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>
> > ---
> >   util/aio-posix.h      | 12 ++----------
> >   util/aio-posix.c      | 29 ++++++++++++++++++++++++++---
> >   util/fdmon-io_uring.c |  8 ++++----
> >   3 files changed, 32 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/util/aio-posix.h b/util/aio-posix.h
> > index f9994ed79e..6f9d97d866 100644
> > --- a/util/aio-posix.h
> > +++ b/util/aio-posix.h
> > @@ -18,6 +18,7 @@
> >   #define AIO_POSIX_H
> >   #include "block/aio.h"
> > +#include "qapi/error.h" struct AioHandler { GPollFD pfd; @@ -72,17
> > +73,8 @@ static inline void fdmon_epoll_disable(AioContext *ctx) #endif
> > /* !CONFIG_EPOLL_CREATE1 */ #ifdef CONFIG_LINUX_IO_URING -bool
> > fdmon_io_uring_setup(AioContext *ctx); +void
> > fdmon_io_uring_setup(AioContext *ctx, Error **errp); void
> > fdmon_io_uring_destroy(AioContext *ctx); -#else -static inline bool
> > fdmon_io_uring_setup(AioContext *ctx) -{ - return false; -} - -static
> > inline void fdmon_io_uring_destroy(AioContext *ctx) -{ -} #endif /*
> > !CONFIG_LINUX_IO_URING */ #endif /* AIO_POSIX_H */ diff --git
> > a/util/aio-posix.c b/util/aio-posix.c index fa047fc7ad..44b3df61f9
> > 100644 --- a/util/aio-posix.c +++ b/util/aio-posix.c @@ -16,6 +16,7 @@
> > #include "qemu/osdep.h"
> >   #include "block/block.h"
> >   #include "block/thread-pool.h"
> > +#include "qapi/error.h"
> >   #include "qemu/main-loop.h"
> >   #include "qemu/lockcnt.h"
> >   #include "qemu/rcu.h"
> > @@ -717,17 +718,39 @@ void aio_context_setup(AioContext *ctx, Error **e=
rrp)
> >       ctx->epollfd =3D -1;
> >       ctx->epollfd_tag =3D NULL;
> > -    /* Use the fastest fd monitoring implementation if available */
> > -    if (fdmon_io_uring_setup(ctx)) {
> > -        return;
> > +#ifdef CONFIG_LINUX_IO_URING
> > +    {
> > +        static bool need_io_uring;
> > +        Error *local_err =3D NULL; /* ERRP_GUARD() doesn't handle erro=
r_abort */
> > +
> > +        /* io_uring takes precedence because it provides aio_add_sqe()=
 support */
> > +        fdmon_io_uring_setup(ctx, &local_err);
> > +        if (!local_err) {
> > +            /*
> > +             * If one AioContext gets io_uring, then all AioContexts n=
eed io_uring
> > +             * so that aio_add_sqe() support is available across all t=
hreads.
> > +             */
> > +            need_io_uring =3D true;
> > +            return;
> > +        }
> > +        if (need_io_uring) {
> > +            error_propagate(errp, local_err);
> > +            return;
> > +        }
> > +
> > +        warn_report_err_once(local_err); /* frees local_err */
> > +        local_err =3D NULL;
> >       }
> > +#endif /* CONFIG_LINUX_IO_URING */
> Is there a problem with the logic of this code snippet?
>=20
> If we fail at fdmon_io_uring_setup, specifically at io_uring_queue_init,
> local_err (or errp) will be set to a non-NULL error value. In that case,
> need_io_uring will be set to true, but the function will return immediate=
ly.

If local_err is non-NULL then this conditional is not taken:

  if (!local_err) {
      /*
       * If one AioContext gets io_uring, then all AioContexts need io_uring
       * so that aio_add_sqe() support is available across all threads.
       */
      need_io_uring =3D true;
      return;
  }

If the logic you described is correct, please rephrase it. I don't see
how what you've written can happen.

> As a result, the later if (need_io_uring) block will never be executed
>=20
> >       fdmon_epoll_setup(ctx);
> >   }
> >   void aio_context_destroy(AioContext *ctx)
> >   {
> > +#ifdef CONFIG_LINUX_IO_URING
> >       fdmon_io_uring_destroy(ctx);
> > +#endif
> >       qemu_lockcnt_lock(&ctx->list_lock);
> >       fdmon_epoll_disable(ctx);
> > diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
> > index 2092d08d24..ef1a866a03 100644
> > --- a/util/fdmon-io_uring.c
> > +++ b/util/fdmon-io_uring.c
> > @@ -45,6 +45,7 @@
> >   #include "qemu/osdep.h"
> >   #include <poll.h>
> > +#include "qapi/error.h"
> >   #include "qemu/rcu_queue.h"
> >   #include "aio-posix.h"
> > @@ -361,7 +362,7 @@ static const FDMonOps fdmon_io_uring_ops =3D {
> >       .gsource_dispatch =3D fdmon_io_uring_gsource_dispatch,
> >   };
> > -bool fdmon_io_uring_setup(AioContext *ctx)
> > +void fdmon_io_uring_setup(AioContext *ctx, Error **errp)
> >   {
> >       int ret;
> > @@ -369,15 +370,14 @@ bool fdmon_io_uring_setup(AioContext *ctx)
> >       ret =3D io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_i=
o_uring, 0);
> >       if (ret !=3D 0) {
> > -        return false;
> > +        error_setg_errno(errp, -ret, "Failed to initialize io_uring");
> > +        return;
> >       }
> >       QSLIST_INIT(&ctx->submit_list);
> >       ctx->fdmon_ops =3D &fdmon_io_uring_ops;
> >       ctx->io_uring_fd_tag =3D g_source_add_unix_fd(&ctx->source,
> >               ctx->fdmon_io_uring.ring_fd, G_IO_IN);
> > -
> > -    return true;
> >   }
> >   void fdmon_io_uring_destroy(AioContext *ctx)

--Y4A/9oCcGVBQ8113
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmg+B6MACgkQnKSrs4Gr
c8h0pAgAlntcJSBwPZyJogZ6Euaklc/eMRRjGNr7clN5bHH0FY48kuAzuFkyCfcU
NYAMhuxxySE68x7U4UjroeEaEZevL6xgsevOt/5qtgr81l52SDn+LeN1LihuOFFT
kvwj15eYe2JHYb7m6nb9xxSnI2gaD6OJFuztUZlEh2swrG6Z4Ad/EAlyjEm3o3T+
jRgcQs2EITaI9JxFE+bEewhsmKEi06iZ69bvLulnMzX31u6VOO889R5D8GynycKH
azvJ46pELGgGZ7rCU9RMMaRRS125o7HzawLDc4kku7CmZ0ERyGJB6lvI7R/NFvSp
sWev/F7revMM41OEDyp/KGu9/EGbAA==
=VTQ3
-----END PGP SIGNATURE-----

--Y4A/9oCcGVBQ8113--


