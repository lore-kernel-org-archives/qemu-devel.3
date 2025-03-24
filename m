Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCB8C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 18:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twmFX-0001Nt-Vz; Mon, 24 Mar 2025 14:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twmFT-0001Mj-QM
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:10:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twmFR-0003xT-1F
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742839804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ViesXAR8Cr5T9M4BFZTNuVN4DuIRwxrQVaYfW/9MGKw=;
 b=UzunyTH2gXsls6LCXqki/Zl4wToVBOzQ73mcVNVe50xE5gLa46v5Fd0WvqWsDTmxK+wnUl
 De3+qrdyqK3nrjCSObTdJRzS+ohaPjVzk9JIW0N7bZE5wjgCOqIhWFEdRcUwwV7HTNdBBc
 KjjyfrbVCObwmF5n8kwKZ/Ewwuapk0w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-G8z05zb7Ore2vw9IJHxt7w-1; Mon,
 24 Mar 2025 14:09:20 -0400
X-MC-Unique: G8z05zb7Ore2vw9IJHxt7w-1
X-Mimecast-MFC-AGG-ID: G8z05zb7Ore2vw9IJHxt7w_1742839758
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52BC01800262; Mon, 24 Mar 2025 18:09:16 +0000 (UTC)
Received: from localhost (unknown [10.2.16.139])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED98A1801747; Mon, 24 Mar 2025 18:09:14 +0000 (UTC)
Date: Mon, 24 Mar 2025 14:09:13 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: zoudongjie <zoudongjie@huawei.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 hreitz@redhat.com, alex.chen@huawei.com, chenjianfei3@huawei.com,
 eric.fangyi@huawei.com, luolongmin@huawei.com,
 mujinsheng@huawei.com, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, renxuming@huawei.com,
 suxiaodong1@huawei.com, wangjian161@huawei.com,
 wangyan122@huawei.com, yebiaoxiang@huawei.com, zhuyangyang14@huawei.com
Subject: Re: [PATCH v2 1/2] io/block: Refactoring the bdrv_drained_begin()
 function and implement a timeout mechanism.
Message-ID: <20250324180913.GH64982@fedora>
References: <20250321070917.2889854-1-zoudongjie@huawei.com>
 <20250321070917.2889854-2-zoudongjie@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="myxWfuO6BRJ7ziqF"
Content-Disposition: inline
In-Reply-To: <20250321070917.2889854-2-zoudongjie@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--myxWfuO6BRJ7ziqF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 03:09:16PM +0800, zoudongjie wrote:
> From: Zhu Yangyang <zhuyangyang14@huawei.com>
>=20
> The bdrv_drained_begin() function is a blocking function. In scenarios wh=
ere network storage
> is used and network links fail, it may block for a long time.
> Therefore, we add a timeout parameter to control the duration of the bloc=
k.
>=20
> Since bdrv_drained_begin() has been widely adopted, both bdrv_drained_beg=
in()
> and bdrv_drained_begin_timeout() will be retained.
>=20
> Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
> ---
>  block/io.c               | 58 +++++++++++++++++++++++++++++++++-------
>  include/block/aio-wait.h | 49 +++++++++++++++++++++++++++++++++
>  include/block/block-io.h | 22 ++++++++++++++-
>  util/aio-wait.c          |  5 ++++
>  4 files changed, 123 insertions(+), 11 deletions(-)
>=20
> diff --git a/block/io.c b/block/io.c
> index 1ba8d1aeea..912b76c4a4 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -255,6 +255,8 @@ typedef struct {
>      bool begin;
>      bool poll;
>      BdrvChild *parent;
> +    uint64_t timeout_ns;
> +    int ret;
>  } BdrvCoDrainData;
> =20
>  /* Returns true if BDRV_POLL_WHILE() should go into a blocking aio_poll(=
) */
> @@ -283,6 +285,10 @@ static bool bdrv_drain_poll_top_level(BlockDriverSta=
te *bs,
>      return bdrv_drain_poll(bs, ignore_parent, false);
>  }
> =20
> +static int bdrv_do_drained_begin_timeout(BlockDriverState *bs,
> +                                         BdrvChild *parent,
> +                                         bool poll,
> +                                         uint64_t timeout_ns);
>  static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *paren=
t,
>                                    bool poll);
>  static void bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent);
> @@ -296,7 +302,9 @@ static void bdrv_co_drain_bh_cb(void *opaque)
>      if (bs) {
>          bdrv_dec_in_flight(bs);
>          if (data->begin) {
> -            bdrv_do_drained_begin(bs, data->parent, data->poll);
> +            data->ret =3D bdrv_do_drained_begin_timeout(bs, data->parent,
> +                                                      data->poll,
> +                                                      data->timeout_ns);
>          } else {
>              assert(!data->poll);
>              bdrv_do_drained_end(bs, data->parent);
> @@ -310,10 +318,11 @@ static void bdrv_co_drain_bh_cb(void *opaque)
>      aio_co_wake(co);
>  }
> =20
> -static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
> -                                                bool begin,
> -                                                BdrvChild *parent,
> -                                                bool poll)
> +static int coroutine_fn bdrv_co_yield_to_drain_timeout(BlockDriverState =
*bs,
> +                                                       bool begin,
> +                                                       BdrvChild *parent,
> +                                                       bool poll,
> +                                                       uint64_t timeout_=
ns)
>  {
>      BdrvCoDrainData data;
>      Coroutine *self =3D qemu_coroutine_self();
> @@ -329,6 +338,8 @@ static void coroutine_fn bdrv_co_yield_to_drain(Block=
DriverState *bs,
>          .begin =3D begin,
>          .parent =3D parent,
>          .poll =3D poll,
> +        .timeout_ns =3D timeout_ns,
> +        .ret =3D 0
>      };
> =20
>      if (bs) {
> @@ -342,16 +353,27 @@ static void coroutine_fn bdrv_co_yield_to_drain(Blo=
ckDriverState *bs,
>      /* If we are resumed from some other event (such as an aio completio=
n or a
>       * timer callback), it is a bug in the caller that should be fixed. =
*/
>      assert(data.done);
> +    return data.ret;
>  }
> =20
> -static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *paren=
t,
> -                                  bool poll)
> +static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
> +                                                bool begin,
> +                                                BdrvChild *parent,
> +                                                bool poll)
> +{
> +    bdrv_co_yield_to_drain_timeout(bs, begin, parent, poll, 0);
> +}
> +
> +static int bdrv_do_drained_begin_timeout(BlockDriverState *bs,
> +                                         BdrvChild *parent,
> +                                         bool poll,
> +                                         uint64_t timeout_ns)
>  {
>      IO_OR_GS_CODE();
> =20
>      if (qemu_in_coroutine()) {
> -        bdrv_co_yield_to_drain(bs, true, parent, poll);
> -        return;
> +        return bdrv_co_yield_to_drain_timeout(bs, true, parent, poll,
> +                                              timeout_ns);
>      }
> =20
>      GLOBAL_STATE_CODE();
> @@ -375,8 +397,17 @@ static void bdrv_do_drained_begin(BlockDriverState *=
bs, BdrvChild *parent,
>       * nodes.
>       */
>      if (poll) {
> -        BDRV_POLL_WHILE(bs, bdrv_drain_poll_top_level(bs, parent));
> +        return BDRV_POLL_WHILE_TIMEOUT(bs,
> +                                       bdrv_drain_poll_top_level(bs, par=
ent),
> +                                       timeout_ns);
>      }
> +    return 0;
> +}
> +
> +static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *paren=
t,
> +                                  bool poll)
> +{
> +    bdrv_do_drained_begin_timeout(bs, parent, poll, 0);
>  }
> =20
>  void bdrv_do_drained_begin_quiesce(BlockDriverState *bs, BdrvChild *pare=
nt)
> @@ -391,6 +422,13 @@ bdrv_drained_begin(BlockDriverState *bs)
>      bdrv_do_drained_begin(bs, NULL, true);
>  }
> =20
> +int coroutine_mixed_fn
> +bdrv_drained_begin_timeout(BlockDriverState *bs, uint64_t timeout_ns)
> +{
> +    IO_OR_GS_CODE();
> +    return bdrv_do_drained_begin_timeout(bs, NULL, true, timeout_ns);
> +}
> +
>  /**
>   * This function does not poll, nor must any of its recursively called
>   * functions.
> diff --git a/include/block/aio-wait.h b/include/block/aio-wait.h
> index cf5e8bde1c..24c31df620 100644
> --- a/include/block/aio-wait.h
> +++ b/include/block/aio-wait.h
> @@ -99,6 +99,53 @@ extern AioWait global_aio_wait;
>      qatomic_dec(&wait_->num_waiters);                              \
>      waited_; })
> =20
> +/**
> + * AIO_WAIT_WHILE_TIMEOUT:
> + *
> + * Refer to the implementation of AIO_WAIT_WHILE_INTERNAL,
> + * the timeout parameter is added.
> + * @timeout_ns: maximum duration to wait, in nanoseconds, except the val=
ue
> + *              is unsigned, 0 means infinite.
> + */
> +#define AIO_WAIT_WHILE_TIMEOUT(ctx, cond, timeout_ns) ({                =
 \
> +    int ret_ =3D 0;                                                     =
   \
> +    uint64_t timeout_ =3D (timeout_ns);                                 =
   \
> +    AioWait *wait_ =3D &global_aio_wait;                                =
   \
> +    AioContext *ctx_ =3D (ctx);                                         =
   \
> +    AioContext *current_ctx_ =3D NULL;                                  =
   \
> +    QEMUTimer timer_;                                                   =
 \
> +    /* Increment wait_->num_waiters before evaluating cond. */          =
 \
> +    qatomic_inc(&wait_->num_waiters);                                   =
 \
> +    /* Paired with smp_mb in aio_wait_kick(). */                        =
 \
> +    smp_mb__after_rmw();                                                =
 \
> +    if (ctx_ && in_aio_context_home_thread(ctx_)) {                     =
 \
> +        current_ctx_ =3D ctx_;                                          =
   \
> +    } else {                                                            =
 \
> +        assert(qemu_get_current_aio_context() =3D=3D                    =
     \
> +               qemu_get_aio_context());                                 =
 \
> +        current_ctx_ =3D qemu_get_aio_context();                        =
   \
> +    }                                                                   =
 \
> +    if (timeout_ > 0) {                                                 =
 \
> +        timer_init_full(&timer_, &current_ctx_->tlg,                    =
 \
> +                        QEMU_CLOCK_REALTIME,                            =
 \
> +                        SCALE_NS, 0, aio_wait_timer_cb, NULL);          =
 \
> +        timer_mod_ns(&timer_,                                           =
 \
> +                     qemu_clock_get_ns(QEMU_CLOCK_REALTIME) +           =
 \
> +                     timeout_);                                         =
 \
> +    }                                                                   =
 \
> +    while ((cond)) {                                                    =
 \
> +        aio_poll(current_ctx_, true);                                   =
 \
> +        if (timeout_ > 0 && !timer_pending(&timer_)) {                  =
 \
> +            ret_ =3D -ETIMEDOUT;                                        =
   \
> +            break;                                                      =
 \
> +        }                                                               =
 \
> +    }                                                                   =
 \
> +    if (timeout_ > 0) {                                                 =
 \
> +        timer_del(&timer_);                                             =
 \
> +    }                                                                   =
 \
> +    qatomic_dec(&wait_->num_waiters);                                   =
 \
> +    ret_; })
> +
>  #define AIO_WAIT_WHILE(ctx, cond)                                  \
>      AIO_WAIT_WHILE_INTERNAL(ctx, cond)

It would be nice to unify AIO_WAIT_WHILE_INTERNAL() and
AIO_WAIT_WHILE_TIMEOUT(). I don't see any caller that uses the waited_
return value from AIO_WAIT_WHILE_INTERNAL(), so I think it's possible to
replace AIO_WAIT_WHILE_INTERNAL() with AIO_WAIT_WHILE_TIMEOUT(.., ..., 0).

> =20
> @@ -149,4 +196,6 @@ static inline bool in_aio_context_home_thread(AioCont=
ext *ctx)
>      }
>  }
> =20
> +void aio_wait_timer_cb(void *opaque);
> +
>  #endif /* QEMU_AIO_WAIT_H */
> diff --git a/include/block/block-io.h b/include/block/block-io.h
> index b49e0537dd..844e9cf350 100644
> --- a/include/block/block-io.h
> +++ b/include/block/block-io.h
> @@ -354,6 +354,11 @@ bdrv_co_copy_range(BdrvChild *src, int64_t src_offse=
t,
>      AIO_WAIT_WHILE(bdrv_get_aio_context(bs_),              \
>                     cond); })
> =20
> +#define BDRV_POLL_WHILE_TIMEOUT(bs, cond, timeout_ns) ({   \
> +    BlockDriverState *bs_ =3D (bs);                          \
> +    AIO_WAIT_WHILE_TIMEOUT(bdrv_get_aio_context(bs_),      \
> +                           cond, timeout_ns); })
> +
>  void bdrv_drain(BlockDriverState *bs);
> =20
>  int co_wrapper_mixed_bdrv_rdlock
> @@ -432,7 +437,22 @@ bdrv_drain_poll(BlockDriverState *bs, BdrvChild *ign=
ore_parent,
>  void bdrv_drained_begin(BlockDriverState *bs);
> =20
>  /**
> - * bdrv_do_drained_begin_quiesce:
> + * bdrv_drained_begin_timeout:
> + *
> + * Added timeout parameter for bdrv_drained_begin() to make a time limit=
ed.
> + *
> + * @timeout_ns: maximum duration to wait; 0 means infinite, equal to call
> + *              bdrv_drained_begin().
> + *
> + * Returns: 0 if succeeded; -ETIMEDOUT when a timeout occurs.
> + *
> + * Note: when the timeout fails, we've already begin aquiesced section, =
so we
> + * still need to call bdrv_drained_end() to end the quiescent section.
> + */
> +int bdrv_drained_begin_timeout(BlockDriverState *bs, uint64_t timeout_ns=
);
> +
> +/**
> + * bdrv_do_drained_badegin_quiesce:
>   *
>   * Quiesces a BDS like bdrv_drained_begin(), but does not wait for alrea=
dy
>   * running requests to complete.
> diff --git a/util/aio-wait.c b/util/aio-wait.c
> index b5336cf5fd..64c3714fb8 100644
> --- a/util/aio-wait.c
> +++ b/util/aio-wait.c
> @@ -84,3 +84,8 @@ void aio_wait_bh_oneshot(AioContext *ctx, QEMUBHFunc *c=
b, void *opaque)
>      aio_bh_schedule_oneshot(ctx, aio_wait_bh, &data);
>      AIO_WAIT_WHILE_UNLOCKED(NULL, !data.done);
>  }
> +
> +void aio_wait_timer_cb(void *opaque)
> +{
> +    /* The point is to make AIO_WAIT_WHILE_TIMEOUT()'s aio_poll() return=
 */
> +}
> --=20
> 2.33.0
>=20

--myxWfuO6BRJ7ziqF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfhn8kACgkQnKSrs4Gr
c8hVUwgAosFqPO01hocm0kAGJWThgrw3LvB2TTX2W7QTKt2E2b9ErnGdVr90hk0J
Fn4ZHEI0UGgsZzjDRAdQIvNqCohr/aGCgKPRQO6wQ2u9bKd7OBEaVEBGqy0a+9WY
RSClaDjqAOik2ROQ3gJUtZ8OyDhKDuLMkZXII+6/PFr3iaND+K3/4eS9GC91Ik6o
ZF1LUQWpDgXjE8JzV0gZrO8yxmHWEMh3O2O5aOi0pYRoOWyiv3l64Cly085kN+BC
dNL/EIAhAwOvCeWQW4LCLgTRC0KnncC/v5McOd2O5TNkoRVtYnpgXccOVTvxVBk/
uAxQGysTmjkvvYUhe5V7MS/GeAlbkQ==
=Cvi4
-----END PGP SIGNATURE-----

--myxWfuO6BRJ7ziqF--


