Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E1DC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 11:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trb3A-00032O-Fx; Mon, 10 Mar 2025 07:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1trb38-00031X-CW
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:11:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1trb36-00014u-7u
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741605114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CNEw9WWU/ybKZvgn0Z6Q1NSTBosmxQiENf/SBhrutQo=;
 b=i7LSVf5ujYxqZOhOKKl8MpNfZ/ZvQxSKBwjOYYUtU0H9foxxccEKQKb0lW9hG2lv5f7WYn
 PyqrgdfYNKfr6kmpsbIDHfvRVTAE45+AQVF6HNQGS5GNxLtkSvWZ5mhfMjuwGKmSLCPnTK
 dRdiqQfjcMcFVL2VpyHB8wsrgWIyGV8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-d_BqCXBNMkCzRe-tATJuvw-1; Mon,
 10 Mar 2025 07:11:50 -0400
X-MC-Unique: d_BqCXBNMkCzRe-tATJuvw-1
X-Mimecast-MFC-AGG-ID: d_BqCXBNMkCzRe-tATJuvw_1741605109
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84855180025A; Mon, 10 Mar 2025 11:11:49 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.222])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B23723000197; Mon, 10 Mar 2025 11:11:47 +0000 (UTC)
Date: Mon, 10 Mar 2025 12:11:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, afaria@redhat.com,
 hreitz@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 5/5] aio-posix: Separate AioPolledEvent per AioHandler
Message-ID: <Z87I8AVI8X-ARWrM@redhat.com>
References: <20250307221634.71951-1-kwolf@redhat.com>
 <20250307221634.71951-6-kwolf@redhat.com>
 <20250310105501.GC359802@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UU87+uadPcBuN2lt"
Content-Disposition: inline
In-Reply-To: <20250310105501.GC359802@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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


--UU87+uadPcBuN2lt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 10.03.2025 um 11:55 hat Stefan Hajnoczi geschrieben:
> On Fri, Mar 07, 2025 at 11:16:34PM +0100, Kevin Wolf wrote:
> > Adaptive polling has a big problem: It doesn't consider that an event
> > loop can wait for many different events that may have very different
> > typical latencies.
> >=20
> > For example, think of a guest that tends to send a new I/O request soon
> > after the previous I/O request completes, but the storage on the host is
> > rather slow. In this case, getting the new request from guest quickly
> > means that polling is enabled, but the next thing is performing the I/O
> > request on the backend, which is slow and disables polling again for the
> > next guest request. This means that in such a scenario, polling could
> > help for every other event, but is only ever enabled when it can't
> > succeed.
> >=20
> > In order to fix this, keep a separate AioPolledEvent for each
> > AioHandler. We will then know that the backend file descriptor always
> > has a high latency and isn't worth polling for, but we also know that
> > the guest is always fast and we should poll for it. This solves at least
> > half of the problem, we can now keep polling for those cases where it
> > makes sense and get the improved performance from it.
> >=20
> > Since the event loop doesn't know which event will be next, we still do
> > some unnecessary polling while we're waiting for the slow disk. I made
> > some attempts to be more clever than just randomly growing and shrinking
> > the polling time, and even to let callers be explicit about when they
> > expect a new event, but so far this hasn't resulted in improved
> > performance or even caused performance regressions. For now, let's just
> > fix the part that is easy enough to fix, we can revisit the rest later.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/block/aio.h |  1 -
> >  util/aio-posix.h    |  1 +
> >  util/aio-posix.c    | 24 +++++++++++++++++++++---
> >  util/async.c        |  2 --
> >  4 files changed, 22 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/include/block/aio.h b/include/block/aio.h
> > index 49f46e01cb..0ef7ce48e3 100644
> > --- a/include/block/aio.h
> > +++ b/include/block/aio.h
> > @@ -233,7 +233,6 @@ struct AioContext {
> >      int poll_disable_cnt;
> > =20
> >      /* Polling mode parameters */
> > -    AioPolledEvent poll;
> >      int64_t poll_max_ns;    /* maximum polling time in nanoseconds */
> >      int64_t poll_grow;      /* polling time growth factor */
> >      int64_t poll_shrink;    /* polling time shrink factor */
> > diff --git a/util/aio-posix.h b/util/aio-posix.h
> > index 4264c518be..82a0201ea4 100644
> > --- a/util/aio-posix.h
> > +++ b/util/aio-posix.h
> > @@ -38,6 +38,7 @@ struct AioHandler {
> >  #endif
> >      int64_t poll_idle_timeout; /* when to stop userspace polling */
> >      bool poll_ready; /* has polling detected an event? */
> > +    AioPolledEvent poll;
> >  };
> > =20
> >  /* Add a handler to a ready list */
> > diff --git a/util/aio-posix.c b/util/aio-posix.c
> > index 259827c7ad..2251871c61 100644
> > --- a/util/aio-posix.c
> > +++ b/util/aio-posix.c
> > @@ -579,13 +579,19 @@ static bool run_poll_handlers(AioContext *ctx, Ai=
oHandlerList *ready_list,
> >  static bool try_poll_mode(AioContext *ctx, AioHandlerList *ready_list,
> >                            int64_t *timeout)
> >  {
> > +    AioHandler *node;
> >      int64_t max_ns;
> > =20
> >      if (QLIST_EMPTY_RCU(&ctx->poll_aio_handlers)) {
> >          return false;
> >      }
> > =20
> > -    max_ns =3D qemu_soonest_timeout(*timeout, ctx->poll.ns);
> > +    max_ns =3D 0;
> > +    QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
> > +        max_ns =3D MAX(max_ns, node->poll.ns);
> > +    }
> > +    max_ns =3D qemu_soonest_timeout(*timeout, max_ns);
> > +
> >      if (max_ns && !ctx->fdmon_ops->need_wait(ctx)) {
> >          /*
> >           * Enable poll mode. It pairs with the poll_set_started() in
> > @@ -721,8 +727,14 @@ bool aio_poll(AioContext *ctx, bool blocking)
> > =20
> >      /* Adjust polling time */
> >      if (ctx->poll_max_ns) {
> > +        AioHandler *node;
> >          int64_t block_ns =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - =
start;
> > -        adjust_polling_time(ctx, &ctx->poll, block_ns);
> > +
> > +        QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
> > +            if (QLIST_IS_INSERTED(node, node_ready)) {
> > +                adjust_polling_time(ctx, &node->poll, block_ns);
> > +            }
> > +        }
> >      }
> > =20
> >      progress |=3D aio_bh_poll(ctx);
> > @@ -772,10 +784,16 @@ void aio_context_use_g_source(AioContext *ctx)
> >  void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
> >                                   int64_t grow, int64_t shrink, Error *=
*errp)
> >  {
> > +    AioHandler *node;
> > +
> >      /* No thread synchronization here, it doesn't matter if an incorre=
ct value
> >       * is used once.
> >       */
>=20
> If you respin this series:
>=20
> This comment is confusing now that qemu_lockcnt_inc() is being used.
> Lockcnt tells other threads in aio_set_fd_handler() not to remove nodes
> from the aio_handlers list (because we're traversing the list).
>=20
> The comment is about the poll state though, not about the aio_handlers
> list. Moving it down to where poll_max_ns, etc are assigned would make
> it clearer.

Yes, I can do that while applying the series.

Should I add your R-b after making the change?

Kevin

--UU87+uadPcBuN2lt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmfOyPAACgkQfwmycsiP
L9avEw/+L0FOm+mfvKubnC/9TFy2zaPvH4hVxlWOqUdEc0+SZJXm1kqc+JP7HlId
KT79FZdSuqeNefu6FbfB97FqstHmhA3WLcay9Cdvliq8PbH1dTFtMPKY8CCNtOPe
mXKD4YFCuD9UBacspqjxv+A8q/ZHpODSjvF/4oF5gRFX1sDqsddCG6COnM9S2t1N
fK+eV5eW21qYr6P45l57aUvdZ1F1DesHKdz2FoI5yJf07HXs9TpOHKveaL4Tro+H
NMRxWmtq7D+h0egRH6rPLC2HseysL3e9G8B/SzD3XV65WYOELJqM4HDW5xrbvxNm
f/x8/UJvlJj+ugs3bxpoSNdw3WnWFTMs9bLqrWoQzHMkbTPGvy4BJzWPVRHT/beX
xpeu+uzmwnm4032jUgR90xkKe87X4lmlkmmTpEHjtbrLiEdNr4gmDnJAKD8y4IDp
+CfpknZ89HkanrIwC+GAXjftGtutVFrlvwrccnnkIpcDklcAT3gha0317H94/R8d
cW7z6lisoFawJAfgFRhZxGHJO34SHdkAVb9xAzB2D478gheozkzYjQt2GUV7fd+R
2K03Zbsklz4fS8M1Qm55obYMHfZ+QoYGpXR/5DSTQbIImVlN5irCuToEmDL/Gyyl
TepGFeScxbR6seKsNX8+C7rBTN9vBKArHgluaN2/zmuk3qtC9Dw=
=XTUK
-----END PGP SIGNATURE-----

--UU87+uadPcBuN2lt--


