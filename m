Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACAAC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 10:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tran0-00005w-K5; Mon, 10 Mar 2025 06:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tramx-000056-SL
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:55:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tramu-0005uu-Ku
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741604110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fDcCQ7CuPUGFWVbwfBZZf401C3MuFweFWiev+Lm6a7o=;
 b=KTsr+vRIw/ZGJZwnUyj668qT897mYxjy9Og5QH3vBYA5yOhLdBTUR0TANZ/080WPoUymoL
 P6ya9vYQXpADSWZI45DpBtsXZdq7UxAvPtFiwK9UnKPBpborCpHj1Ma2nRS7clS3aul6ZL
 JWQaERBX6rf4xpEqRUiXNQk9mBiWj68=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-1DGw1vQqMBOhVdG81xWKGg-1; Mon,
 10 Mar 2025 06:55:07 -0400
X-MC-Unique: 1DGw1vQqMBOhVdG81xWKGg-1
X-Mimecast-MFC-AGG-ID: 1DGw1vQqMBOhVdG81xWKGg_1741604106
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48185195609E; Mon, 10 Mar 2025 10:55:05 +0000 (UTC)
Received: from localhost (unknown [10.2.16.19])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D2903000197; Mon, 10 Mar 2025 10:55:04 +0000 (UTC)
Date: Mon, 10 Mar 2025 18:55:01 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, afaria@redhat.com,
 hreitz@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 5/5] aio-posix: Separate AioPolledEvent per AioHandler
Message-ID: <20250310105501.GC359802@fedora>
References: <20250307221634.71951-1-kwolf@redhat.com>
 <20250307221634.71951-6-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y1yVTQc4elM+8F+z"
Content-Disposition: inline
In-Reply-To: <20250307221634.71951-6-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--Y1yVTQc4elM+8F+z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 11:16:34PM +0100, Kevin Wolf wrote:
> Adaptive polling has a big problem: It doesn't consider that an event
> loop can wait for many different events that may have very different
> typical latencies.
>=20
> For example, think of a guest that tends to send a new I/O request soon
> after the previous I/O request completes, but the storage on the host is
> rather slow. In this case, getting the new request from guest quickly
> means that polling is enabled, but the next thing is performing the I/O
> request on the backend, which is slow and disables polling again for the
> next guest request. This means that in such a scenario, polling could
> help for every other event, but is only ever enabled when it can't
> succeed.
>=20
> In order to fix this, keep a separate AioPolledEvent for each
> AioHandler. We will then know that the backend file descriptor always
> has a high latency and isn't worth polling for, but we also know that
> the guest is always fast and we should poll for it. This solves at least
> half of the problem, we can now keep polling for those cases where it
> makes sense and get the improved performance from it.
>=20
> Since the event loop doesn't know which event will be next, we still do
> some unnecessary polling while we're waiting for the slow disk. I made
> some attempts to be more clever than just randomly growing and shrinking
> the polling time, and even to let callers be explicit about when they
> expect a new event, but so far this hasn't resulted in improved
> performance or even caused performance regressions. For now, let's just
> fix the part that is easy enough to fix, we can revisit the rest later.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/aio.h |  1 -
>  util/aio-posix.h    |  1 +
>  util/aio-posix.c    | 24 +++++++++++++++++++++---
>  util/async.c        |  2 --
>  4 files changed, 22 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/block/aio.h b/include/block/aio.h
> index 49f46e01cb..0ef7ce48e3 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -233,7 +233,6 @@ struct AioContext {
>      int poll_disable_cnt;
> =20
>      /* Polling mode parameters */
> -    AioPolledEvent poll;
>      int64_t poll_max_ns;    /* maximum polling time in nanoseconds */
>      int64_t poll_grow;      /* polling time growth factor */
>      int64_t poll_shrink;    /* polling time shrink factor */
> diff --git a/util/aio-posix.h b/util/aio-posix.h
> index 4264c518be..82a0201ea4 100644
> --- a/util/aio-posix.h
> +++ b/util/aio-posix.h
> @@ -38,6 +38,7 @@ struct AioHandler {
>  #endif
>      int64_t poll_idle_timeout; /* when to stop userspace polling */
>      bool poll_ready; /* has polling detected an event? */
> +    AioPolledEvent poll;
>  };
> =20
>  /* Add a handler to a ready list */
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index 259827c7ad..2251871c61 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -579,13 +579,19 @@ static bool run_poll_handlers(AioContext *ctx, AioH=
andlerList *ready_list,
>  static bool try_poll_mode(AioContext *ctx, AioHandlerList *ready_list,
>                            int64_t *timeout)
>  {
> +    AioHandler *node;
>      int64_t max_ns;
> =20
>      if (QLIST_EMPTY_RCU(&ctx->poll_aio_handlers)) {
>          return false;
>      }
> =20
> -    max_ns =3D qemu_soonest_timeout(*timeout, ctx->poll.ns);
> +    max_ns =3D 0;
> +    QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
> +        max_ns =3D MAX(max_ns, node->poll.ns);
> +    }
> +    max_ns =3D qemu_soonest_timeout(*timeout, max_ns);
> +
>      if (max_ns && !ctx->fdmon_ops->need_wait(ctx)) {
>          /*
>           * Enable poll mode. It pairs with the poll_set_started() in
> @@ -721,8 +727,14 @@ bool aio_poll(AioContext *ctx, bool blocking)
> =20
>      /* Adjust polling time */
>      if (ctx->poll_max_ns) {
> +        AioHandler *node;
>          int64_t block_ns =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - st=
art;
> -        adjust_polling_time(ctx, &ctx->poll, block_ns);
> +
> +        QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
> +            if (QLIST_IS_INSERTED(node, node_ready)) {
> +                adjust_polling_time(ctx, &node->poll, block_ns);
> +            }
> +        }
>      }
> =20
>      progress |=3D aio_bh_poll(ctx);
> @@ -772,10 +784,16 @@ void aio_context_use_g_source(AioContext *ctx)
>  void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
>                                   int64_t grow, int64_t shrink, Error **e=
rrp)
>  {
> +    AioHandler *node;
> +
>      /* No thread synchronization here, it doesn't matter if an incorrect=
 value
>       * is used once.
>       */

If you respin this series:

This comment is confusing now that qemu_lockcnt_inc() is being used.
Lockcnt tells other threads in aio_set_fd_handler() not to remove nodes
=66rom the aio_handlers list (because we're traversing the list).

The comment is about the poll state though, not about the aio_handlers
list. Moving it down to where poll_max_ns, etc are assigned would make
it clearer.

> -    ctx->poll.ns =3D 0;
> +    qemu_lockcnt_inc(&ctx->list_lock);
> +    QLIST_FOREACH(node, &ctx->aio_handlers, node) {
> +        node->poll.ns =3D 0;
> +    }
> +    qemu_lockcnt_dec(&ctx->list_lock);
> =20
>      ctx->poll_max_ns =3D max_ns;
>      ctx->poll_grow =3D grow;
> diff --git a/util/async.c b/util/async.c
> index 38667ea091..4124a948fd 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -609,8 +609,6 @@ AioContext *aio_context_new(Error **errp)
>      qemu_rec_mutex_init(&ctx->lock);
>      timerlistgroup_init(&ctx->tlg, aio_timerlist_notify, ctx);
> =20
> -    ctx->poll.ns =3D 0;
> -
>      ctx->poll_max_ns =3D 0;
>      ctx->poll_grow =3D 0;
>      ctx->poll_shrink =3D 0;
> --=20
> 2.48.1
>=20

--Y1yVTQc4elM+8F+z
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfOxQUACgkQnKSrs4Gr
c8jxZggAte3v8BaJ2N5myWYqM4fNtJ+lrfwH+QsQmcXchD3bVBiP4oCt0ecy7rjo
wlbbIis0LfCttMDG6BoqUvosonCVMaOWy7hnKFF6o2yQ16LGasI7ndmlIMPdc4Ve
3aQ2DGBCUU0TX7DbcPpfnhGZUeIxbcG0fprf5FL/EOVz2Z6+H4bZ+McXh3x3p+Tc
y4GFCNLLyFvgFIjw1pqb3FVDWmBeQ1T4vAakELn/89LVVc7/yVV25jv+xA/cbGwD
vgMGhqi0TbmE6Es03P7K3yiX9/VS+ZRXGe20hfuINDS1Z44UOEacUv+q8iEtEQRu
Z1oUll2elg972vc0JXkCg4tyNKVzsA==
=a0gj
-----END PGP SIGNATURE-----

--Y1yVTQc4elM+8F+z--


