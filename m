Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8515C282DE
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 02:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trpCH-0004oO-Ld; Mon, 10 Mar 2025 22:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trpCG-0004ny-5p
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 22:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trpCB-00061F-9g
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 22:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741659493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gHLIoOQm+QSB3Ye/VAzJHXxWu+NQy+2lmBGC2GDRK38=;
 b=SCHtq3MdGP/WpJORf55iqECoHy8UmBERhHYGH2t4+1cIgz8+h9gh+pjG9bibSyW9COe8if
 ZbhyzCiUBg3tdhlWCE7aOMzjUkuPiAYPrZr2xjFMJ6pAMNNNtbVR9fFXcYlRLw9txcXCtH
 MItVbtiCmrcE+yN7XamEqP6OE8nrZvU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-DqTTIc7ONliFXAP4LpOfxA-1; Mon,
 10 Mar 2025 22:18:11 -0400
X-MC-Unique: DqTTIc7ONliFXAP4LpOfxA-1
X-Mimecast-MFC-AGG-ID: DqTTIc7ONliFXAP4LpOfxA_1741659491
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 069EB1809CA5; Tue, 11 Mar 2025 02:18:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.75])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E75381800268; Tue, 11 Mar 2025 02:18:08 +0000 (UTC)
Date: Tue, 11 Mar 2025 10:18:05 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, afaria@redhat.com,
 hreitz@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 5/5] aio-posix: Separate AioPolledEvent per AioHandler
Message-ID: <20250311021805.GC487512@fedora>
References: <20250307221634.71951-1-kwolf@redhat.com>
 <20250307221634.71951-6-kwolf@redhat.com>
 <20250310105501.GC359802@fedora> <Z87I8AVI8X-ARWrM@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="InBOtQS0+G2YKmG1"
Content-Disposition: inline
In-Reply-To: <Z87I8AVI8X-ARWrM@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--InBOtQS0+G2YKmG1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 12:11:44PM +0100, Kevin Wolf wrote:
> Am 10.03.2025 um 11:55 hat Stefan Hajnoczi geschrieben:
> > On Fri, Mar 07, 2025 at 11:16:34PM +0100, Kevin Wolf wrote:
> > > Adaptive polling has a big problem: It doesn't consider that an event
> > > loop can wait for many different events that may have very different
> > > typical latencies.
> > >=20
> > > For example, think of a guest that tends to send a new I/O request so=
on
> > > after the previous I/O request completes, but the storage on the host=
 is
> > > rather slow. In this case, getting the new request from guest quickly
> > > means that polling is enabled, but the next thing is performing the I=
/O
> > > request on the backend, which is slow and disables polling again for =
the
> > > next guest request. This means that in such a scenario, polling could
> > > help for every other event, but is only ever enabled when it can't
> > > succeed.
> > >=20
> > > In order to fix this, keep a separate AioPolledEvent for each
> > > AioHandler. We will then know that the backend file descriptor always
> > > has a high latency and isn't worth polling for, but we also know that
> > > the guest is always fast and we should poll for it. This solves at le=
ast
> > > half of the problem, we can now keep polling for those cases where it
> > > makes sense and get the improved performance from it.
> > >=20
> > > Since the event loop doesn't know which event will be next, we still =
do
> > > some unnecessary polling while we're waiting for the slow disk. I made
> > > some attempts to be more clever than just randomly growing and shrink=
ing
> > > the polling time, and even to let callers be explicit about when they
> > > expect a new event, but so far this hasn't resulted in improved
> > > performance or even caused performance regressions. For now, let's ju=
st
> > > fix the part that is easy enough to fix, we can revisit the rest late=
r.
> > >=20
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  include/block/aio.h |  1 -
> > >  util/aio-posix.h    |  1 +
> > >  util/aio-posix.c    | 24 +++++++++++++++++++++---
> > >  util/async.c        |  2 --
> > >  4 files changed, 22 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/include/block/aio.h b/include/block/aio.h
> > > index 49f46e01cb..0ef7ce48e3 100644
> > > --- a/include/block/aio.h
> > > +++ b/include/block/aio.h
> > > @@ -233,7 +233,6 @@ struct AioContext {
> > >      int poll_disable_cnt;
> > > =20
> > >      /* Polling mode parameters */
> > > -    AioPolledEvent poll;
> > >      int64_t poll_max_ns;    /* maximum polling time in nanoseconds */
> > >      int64_t poll_grow;      /* polling time growth factor */
> > >      int64_t poll_shrink;    /* polling time shrink factor */
> > > diff --git a/util/aio-posix.h b/util/aio-posix.h
> > > index 4264c518be..82a0201ea4 100644
> > > --- a/util/aio-posix.h
> > > +++ b/util/aio-posix.h
> > > @@ -38,6 +38,7 @@ struct AioHandler {
> > >  #endif
> > >      int64_t poll_idle_timeout; /* when to stop userspace polling */
> > >      bool poll_ready; /* has polling detected an event? */
> > > +    AioPolledEvent poll;
> > >  };
> > > =20
> > >  /* Add a handler to a ready list */
> > > diff --git a/util/aio-posix.c b/util/aio-posix.c
> > > index 259827c7ad..2251871c61 100644
> > > --- a/util/aio-posix.c
> > > +++ b/util/aio-posix.c
> > > @@ -579,13 +579,19 @@ static bool run_poll_handlers(AioContext *ctx, =
AioHandlerList *ready_list,
> > >  static bool try_poll_mode(AioContext *ctx, AioHandlerList *ready_lis=
t,
> > >                            int64_t *timeout)
> > >  {
> > > +    AioHandler *node;
> > >      int64_t max_ns;
> > > =20
> > >      if (QLIST_EMPTY_RCU(&ctx->poll_aio_handlers)) {
> > >          return false;
> > >      }
> > > =20
> > > -    max_ns =3D qemu_soonest_timeout(*timeout, ctx->poll.ns);
> > > +    max_ns =3D 0;
> > > +    QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
> > > +        max_ns =3D MAX(max_ns, node->poll.ns);
> > > +    }
> > > +    max_ns =3D qemu_soonest_timeout(*timeout, max_ns);
> > > +
> > >      if (max_ns && !ctx->fdmon_ops->need_wait(ctx)) {
> > >          /*
> > >           * Enable poll mode. It pairs with the poll_set_started() in
> > > @@ -721,8 +727,14 @@ bool aio_poll(AioContext *ctx, bool blocking)
> > > =20
> > >      /* Adjust polling time */
> > >      if (ctx->poll_max_ns) {
> > > +        AioHandler *node;
> > >          int64_t block_ns =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME) =
- start;
> > > -        adjust_polling_time(ctx, &ctx->poll, block_ns);
> > > +
> > > +        QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
> > > +            if (QLIST_IS_INSERTED(node, node_ready)) {
> > > +                adjust_polling_time(ctx, &node->poll, block_ns);
> > > +            }
> > > +        }
> > >      }
> > > =20
> > >      progress |=3D aio_bh_poll(ctx);
> > > @@ -772,10 +784,16 @@ void aio_context_use_g_source(AioContext *ctx)
> > >  void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
> > >                                   int64_t grow, int64_t shrink, Error=
 **errp)
> > >  {
> > > +    AioHandler *node;
> > > +
> > >      /* No thread synchronization here, it doesn't matter if an incor=
rect value
> > >       * is used once.
> > >       */
> >=20
> > If you respin this series:
> >=20
> > This comment is confusing now that qemu_lockcnt_inc() is being used.
> > Lockcnt tells other threads in aio_set_fd_handler() not to remove nodes
> > from the aio_handlers list (because we're traversing the list).
> >=20
> > The comment is about the poll state though, not about the aio_handlers
> > list. Moving it down to where poll_max_ns, etc are assigned would make
> > it clearer.
>=20
> Yes, I can do that while applying the series.
>=20
> Should I add your R-b after making the change?

Yes, please.

Stefan

--InBOtQS0+G2YKmG1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfPnV0ACgkQnKSrs4Gr
c8ilcgf/aPI5LK5OGX/rbwCCIIrHNe9hvFFt4HtR9cgu7ZsoBUxY+QluZ0x2I+CN
jGJacRmeUN8qYr9JXrDIYbtuNPEskI/9jd7Hd4vZX074ivGFUzvmq2eqw3tg73dO
W3LRpdr17POBG9PN4xL/0jS2wUU7Mt7blLs5qC9mtwraqTCrJctpANES1USD+Of1
LeVS4kQO+dhabTb0JnzT8gI6fmVpoqiRFiD0J8Ql4/r079gb7uD+ogffIbktYFj5
MLdBX6YalrDVNyWROkp/iOHwNnNItYup3++M3Vek8XL1nz5ig0Wz90JnrUKXSWQe
uspAPf5jkMoKj7ir/qDi2iKUlCNkYQ==
=ZPOR
-----END PGP SIGNATURE-----

--InBOtQS0+G2YKmG1--


