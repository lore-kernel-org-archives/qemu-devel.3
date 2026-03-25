Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810AB109C05B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 20:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Uyt-0000nI-Kq; Wed, 25 Mar 2026 16:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w5Uyp-0000im-DE
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 16:37:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w5Uyn-0003u9-74
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 16:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774471048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=okGu3iCIsjaNtnI71uFSo+5OeT93nD1JMY3laNXXIjE=;
 b=FS8zJWUBQUVEs7KjC3bEjMYzvpUdpxKbcMHaPj4L08j9jybygYXZeDfc25OL31S0wH0u2t
 NU4c6DX69U0AS4T0YMgb+fn+YV9453iTx8M9H65X9aBU3HJtJpK35ac0yr2HYy6qXg197x
 Njh2xQ0tmergH53KW+zo0VizGCsUg/s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-VT6Zr1i9O9u2SbsMEL3_cQ-1; Wed,
 25 Mar 2026 16:37:22 -0400
X-MC-Unique: VT6Zr1i9O9u2SbsMEL3_cQ-1
X-Mimecast-MFC-AGG-ID: VT6Zr1i9O9u2SbsMEL3_cQ_1774471041
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0F081956096; Wed, 25 Mar 2026 20:37:20 +0000 (UTC)
Received: from localhost (unknown [10.44.32.10])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3BE053000223; Wed, 25 Mar 2026 20:37:18 +0000 (UTC)
Date: Wed, 25 Mar 2026 16:37:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pbonzini@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
Subject: Re: [PATCH RFC v2 2/3] aio-poll: refine iothread polling using
 weighted handler intervals
Message-ID: <20260325203716.GD701300@fedora>
References: <20260323135451.579655-1-jhkim@linux.ibm.com>
 <20260323135451.579655-3-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gRu6PJk+TjdQZrBq"
Content-Disposition: inline
In-Reply-To: <20260323135451.579655-3-jhkim@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--gRu6PJk+TjdQZrBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 08:54:50AM -0500, Jaehoon Kim wrote:
> Refine adaptive polling in aio_poll by updating iothread polling
> duration based on weighted AioHandler event intervals.
>=20
> Each AioHandler's poll.ns is updated using a weighted factor when an
> event occurs. Idle handlers accumulate block_ns until poll_max_ns and
> then reset to 0, preventing sporadically active handlers from
> unnecessarily prolonging iothread polling.
>=20
> The iothread polling duration is set based on the largest poll.ns among
> active handlers. The shrink divider defaults to 2, matching the grow
> rate, to reduce frequent poll_ns resets for slow devices.
>=20
> The default weight factor (POLL_WEIGHT_SHIFT=3D3, meaning the current
> interval contributes 12.5% to the weighted average) was selected based
> on extensive testing comparing QEMU 10.0.0 baseline vs poll-weight=3D2
> and poll-weight=3D3 across various workloads.
>=20
> The table below shows a comparison between:
> -Host: RHEL 10.1 GA + qemu-10.0.0-14.el10_1, Guest: RHEL 9.6GA vs.
> -Host: RHEL 10.1 GA + qemu-10.0.0-14.el10_1 (w=3D2/w=3D3), Guest: RHEL 9.=
6GA
> for FIO FCP and FICON with 1 iothread and 8 iothreads.
> The values shown are the averages for numjobs 1, 4, and 8.
>=20
> Summary of results (% change vs baseline):
>=20
>                     | poll-weight=3D2      | poll-weight=3D3
> --------------------|--------------------|-----------------
> Throughput avg      | -2.4% (all tests)  | -2.2% (all tests)
> CPU consumption avg | -10.9% (all tests) | -9.4% (all tests)
>=20
> Both weight=3D2 and weight=3D3 show significant CPU consumption reduction
> (~10%) compared to baseline, which addresses the CPU utilization
> regression observed in QEMU 10.0.0. The throughput impact is minimal
> for both (~2%).
>=20
> Weight=3D3 is selected as the default because it provides slightly better
> throughput (-2.2% vs -2.4%) while still achieving substantial CPU
> savings (-9.4%). The difference between weight=3D2 and weight=3D3 is smal=
l,
> but weight=3D3 offers a better balance for general-purpose workloads.
>=20
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> ---
>  include/qemu/aio.h |   4 +-
>  util/aio-posix.c   | 135 +++++++++++++++++++++++++++++++--------------
>  util/async.c       |   1 +
>  3 files changed, 99 insertions(+), 41 deletions(-)
>=20
> diff --git a/include/qemu/aio.h b/include/qemu/aio.h
> index 8cca2360d1..6c77a190e9 100644
> --- a/include/qemu/aio.h
> +++ b/include/qemu/aio.h
> @@ -195,7 +195,8 @@ struct BHListSlice {
>  typedef QSLIST_HEAD(, AioHandler) AioHandlerSList;
> =20
>  typedef struct AioPolledEvent {
> -    int64_t ns;        /* current polling time in nanoseconds */
> +    bool has_event; /* Flag to indicate if an event has occurred */
> +    int64_t ns;     /* estimated block time in nanoseconds */
>  } AioPolledEvent;
> =20
>  struct AioContext {
> @@ -306,6 +307,7 @@ struct AioContext {
>      int poll_disable_cnt;
> =20
>      /* Polling mode parameters */
> +    int64_t poll_ns;        /* current polling time in nanoseconds */
>      int64_t poll_max_ns;    /* maximum polling time in nanoseconds */
>      int64_t poll_grow;      /* polling time growth factor */
>      int64_t poll_shrink;    /* polling time shrink factor */
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index b02beb0505..2b3522f2f9 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -29,9 +29,11 @@
> =20
>  /* Stop userspace polling on a handler if it isn't active for some time =
*/
>  #define POLL_IDLE_INTERVAL_NS (7 * NANOSECONDS_PER_SECOND)
> +#define POLL_WEIGHT_SHIFT   (3)
> =20
> -static void adjust_polling_time(AioContext *ctx, AioPolledEvent *poll,
> -                                int64_t block_ns);
> +static void adjust_block_ns(AioContext *ctx, int64_t block_ns);
> +static void grow_polling_time(AioContext *ctx, int64_t block_ns);
> +static void shrink_polling_time(AioContext *ctx, int64_t block_ns);
> =20
>  bool aio_poll_disabled(AioContext *ctx)
>  {
> @@ -373,7 +375,7 @@ static bool aio_dispatch_ready_handlers(AioContext *c=
tx,
>           * add the handler to ctx->poll_aio_handlers.

This comment refers to adjusting the polling time. The code no longer
does this and the comment should be updated.

>           */
>          if (ctx->poll_max_ns && QLIST_IS_INSERTED(node, node_poll)) {
> -            adjust_polling_time(ctx, &node->poll, block_ns);

aio_dispatch_ready_handlers() no longer uses the block_ns argument. It
can be removed.

> +            node->poll.has_event =3D true;
>          }
>      }
> =20
> @@ -560,18 +562,13 @@ static bool run_poll_handlers(AioContext *ctx, AioH=
andlerList *ready_list,
>  static bool try_poll_mode(AioContext *ctx, AioHandlerList *ready_list,
>                            int64_t *timeout)
>  {
> -    AioHandler *node;
>      int64_t max_ns;
> =20
>      if (QLIST_EMPTY_RCU(&ctx->poll_aio_handlers)) {
>          return false;
>      }
> =20
> -    max_ns =3D 0;
> -    QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
> -        max_ns =3D MAX(max_ns, node->poll.ns);
> -    }
> -    max_ns =3D qemu_soonest_timeout(*timeout, max_ns);
> +    max_ns =3D qemu_soonest_timeout(*timeout, ctx->poll_ns);
> =20
>      if (max_ns && !ctx->fdmon_ops->need_wait(ctx)) {
>          /*
> @@ -587,46 +584,98 @@ static bool try_poll_mode(AioContext *ctx, AioHandl=
erList *ready_list,
>      return false;
>  }
> =20
> -static void adjust_polling_time(AioContext *ctx, AioPolledEvent *poll,
> -                                int64_t block_ns)
> +static void shrink_polling_time(AioContext *ctx, int64_t block_ns)
>  {
> -    if (block_ns <=3D poll->ns) {
> -        /* This is the sweet spot, no adjustment needed */
> -    } else if (block_ns > ctx->poll_max_ns) {
> -        /* We'd have to poll for too long, poll less */
> -        int64_t old =3D poll->ns;
> -
> -        if (ctx->poll_shrink) {
> -            poll->ns /=3D ctx->poll_shrink;
> -        } else {
> -            poll->ns =3D 0;
> -        }
> +    /*
> +     * Reduce polling time if the block_ns is zero or
> +     * less than the current poll_ns.
> +     */
> +    int64_t old =3D ctx->poll_ns;
> +    int64_t shrink =3D ctx->poll_shrink;
> =20
> -        trace_poll_shrink(ctx, old, poll->ns);
> -    } else if (poll->ns < ctx->poll_max_ns &&
> -               block_ns < ctx->poll_max_ns) {
> -        /* There is room to grow, poll longer */
> -        int64_t old =3D poll->ns;
> -        int64_t grow =3D ctx->poll_grow;
> +    if (shrink =3D=3D 0) {
> +        shrink =3D 2;
> +    }
> =20
> -        if (grow =3D=3D 0) {
> -            grow =3D 2;
> -        }
> +    if (block_ns < (ctx->poll_ns / shrink)) {
> +        ctx->poll_ns /=3D shrink;
> +    }
> =20
> -        if (poll->ns) {
> -            poll->ns *=3D grow;
> -        } else {
> -            poll->ns =3D 4000; /* start polling at 4 microseconds */
> -        }
> +    trace_poll_shrink(ctx, old, ctx->poll_ns);

This trace event should be inside if (block_ns < (ctx->poll_ns /
shrink)) like it was before this patch.

> +}
> =20
> -        if (poll->ns > ctx->poll_max_ns) {
> -            poll->ns =3D ctx->poll_max_ns;
> -        }
> +static void grow_polling_time(AioContext *ctx, int64_t block_ns)
> +{
> +    /* There is room to grow, poll longer */
> +    int64_t old =3D ctx->poll_ns;
> +    int64_t grow =3D ctx->poll_grow;
> =20
> -        trace_poll_grow(ctx, old, poll->ns);
> +    if (grow =3D=3D 0) {
> +        grow =3D 2;
>      }
> +
> +    if (block_ns > ctx->poll_ns * grow) {
> +        ctx->poll_ns =3D block_ns;
> +    } else {
> +        ctx->poll_ns *=3D grow;
> +    }
> +
> +    if (ctx->poll_ns > ctx->poll_max_ns) {
> +        ctx->poll_ns =3D ctx->poll_max_ns;
> +    }
> +
> +    trace_poll_grow(ctx, old, ctx->poll_ns);

Same here.

>  }
> =20
> +static void adjust_block_ns(AioContext *ctx, int64_t block_ns)
> +{
> +    AioHandler *node;
> +    int64_t adj_block_ns =3D -1;
> +
> +    QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
> +        if (node->poll.has_event) {

Did you consider unifying node->poll.has_event with
node->poll_idle_timeout, which is assigned now + POLL_IDLE_INTERVAL_NS
every time ->io_poll() detects an event?

For instance, rename node->poll_idle_timeout to
node->last_event_timestamp and assign now without adding
POLL_IDLE_INTERVAL_NS. Then use the field for both idle node removal and
adjust_block_ns() (pass in now).

> +            /*
> +             * Update poll.ns for the node with an event.
> +             * Uses a weighted average of the current block_ns and the p=
revious
> +             * poll.ns to smooth out polling time adjustments.
> +             */
> +            node->poll.ns =3D node->poll.ns
> +                ? (node->poll.ns - (node->poll.ns >> POLL_WEIGHT_SHIFT))
> +                + (block_ns >> POLL_WEIGHT_SHIFT) : block_ns;
> +
> +            if (node->poll.ns > ctx->poll_max_ns) {
> +                node->poll.ns =3D 0;
> +            }

Previously:
-        if (poll->ns > ctx->poll_max_ns) {
-            poll->ns =3D ctx->poll_max_ns;
-        }

Was this causing excessive CPU consumption in your benchmarks?

Can you explain the rationale for zeroing the poll time? Aside from
reducing CPU consumption, it also reduces the chance that polling will
succeed and could therefore impact performance.

I'm asking about this because this patch makes several changes at once
and I'm not sure how the CPU usage and performance changes are
attributed to these multiple changes. I want to make sure the changes
merged are minimal and the best set - sometimes when multiple things are
changes at the same time, not all of them are beneficial.

> +            /*
> +             * To avoid excessive polling time increase, update adj_bloc=
k_ns
> +             * for nodes with the event flag set to true
> +             */
> +            adj_block_ns =3D MAX(adj_block_ns, node->poll.ns);

adj_block_ns is not the blocking time, it's the maximum current poll
time across all nodes. It would be clearer to change the variable name.

> +            node->poll.has_event =3D false;
> +         } else {

4-space indentation should be used.

> +            /*
> +             * No event now, but was active before.
> +             * If it waits longer than poll_max_ns, poll.ns will stay 0
> +             * until the next event arrives.
> +             */
> +            if (node->poll.ns !=3D 0) {
> +                node->poll.ns +=3D block_ns;

Why is block_ns being added to an recently inactive node's polling time?
Here node->poll.ns no longer measures the weighted time until the
handler had an event.

If the goal is to get rid of inactive nodes, then maybe the idle handler
removal mechanism should be made more aggresive instead?

> +                if (node->poll.ns > ctx->poll_max_ns) {
> +                    node->poll.ns =3D 0;
> +                }
> +            }
> +        }
> +    }
> +
> +    if (adj_block_ns >=3D 0) {
> +        if (adj_block_ns > ctx->poll_ns) {
> +            grow_polling_time(ctx, adj_block_ns);
> +        } else {
> +            shrink_polling_time(ctx, adj_block_ns);
> +         }
> +     }
> + }
> +
>  bool aio_poll(AioContext *ctx, bool blocking)
>  {
>      AioHandlerList ready_list =3D QLIST_HEAD_INITIALIZER(ready_list);
> @@ -723,6 +772,10 @@ bool aio_poll(AioContext *ctx, bool blocking)
> =20
>      aio_free_deleted_handlers(ctx);
> =20
> +    if (ctx->poll_max_ns) {
> +        adjust_block_ns(ctx, block_ns);
> +    }
> +
>      qemu_lockcnt_dec(&ctx->list_lock);
> =20
>      progress |=3D timerlistgroup_run_timers(&ctx->tlg);
> @@ -784,6 +837,7 @@ void aio_context_set_poll_params(AioContext *ctx, int=
64_t max_ns,
> =20
>      qemu_lockcnt_inc(&ctx->list_lock);
>      QLIST_FOREACH(node, &ctx->aio_handlers, node) {
> +        node->poll.has_event =3D false;
>          node->poll.ns =3D 0;
>      }
>      qemu_lockcnt_dec(&ctx->list_lock);
> @@ -794,6 +848,7 @@ void aio_context_set_poll_params(AioContext *ctx, int=
64_t max_ns,
>      ctx->poll_max_ns =3D max_ns;
>      ctx->poll_grow =3D grow;
>      ctx->poll_shrink =3D shrink;
> +    ctx->poll_ns =3D 0;
> =20
>      aio_notify(ctx);
>  }
> diff --git a/util/async.c b/util/async.c
> index 80d6b01a8a..9d3627566f 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -606,6 +606,7 @@ AioContext *aio_context_new(Error **errp)
>      timerlistgroup_init(&ctx->tlg, aio_timerlist_notify, ctx);
> =20
>      ctx->poll_max_ns =3D 0;
> +    ctx->poll_ns =3D 0;
>      ctx->poll_grow =3D 0;
>      ctx->poll_shrink =3D 0;
> =20
> --=20
> 2.50.1
>=20

--gRu6PJk+TjdQZrBq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnER3wACgkQnKSrs4Gr
c8hEDggAq796uCOyV0ikA5cxxvs8omdq5BAgg7dOgWO2yG0CQO62rFMCljUBP2ab
+zhI0nQitqwLYbUlpUVykP1l642N2sVenjNQfkQ5swtRmHJs/OLE5dJIvGrITAL/
hB7Q0GeVdeZ13omjkw44GCnBBz1lShGpuF8T5ebCdmEP208ZYqEJfuOMekAOLuVi
n4F2WEpW4ZlKirDou48QloO8XbugHlhOXM5MTzMAsZouutMtSLqhT4TVhEBr8EPo
U7tTTmdvQOcBYdtQGaWNSxxwqwGk/CHmG3Ht1Naeovo3PpdQV5d05q9nP5qHxL+z
+jIkOLnYcfxurBsompmQVPB8R43baA==
=lgCc
-----END PGP SIGNATURE-----

--gRu6PJk+TjdQZrBq--


