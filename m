Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F21C2BA1B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 07:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscZo-0006RQ-6Y; Thu, 13 Mar 2025 03:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tscZe-0006M2-Mk
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:01:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tscZc-00072N-C8
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741849302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cJlV9KL5qzc/g9WH9boSNFSx3Scsmd13Te5P9Vs3ttc=;
 b=FXHcitKhJcwD7UQ6Jp/y5Ut7iIhh7A7XcCSBiYz2/v1ZMtfbMi/G6G7BgnLZEwQmjp9T4f
 abDx0sAa5dIUKSCVYQRIRGEoSy097JEPMJOe9ZrbWgLS2Nw3b0UakqqvVyHXz5KOvpTFcm
 Zq3e2sSRXj7xR1fxoiVXn8pj5sp3/Rs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-3YWmW9usPayyqtMKDDOTXg-1; Thu,
 13 Mar 2025 03:01:37 -0400
X-MC-Unique: 3YWmW9usPayyqtMKDDOTXg-1
X-Mimecast-MFC-AGG-ID: 3YWmW9usPayyqtMKDDOTXg_1741849295
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20400180AF6E; Thu, 13 Mar 2025 07:01:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8704B18001F6; Thu, 13 Mar 2025 07:01:30 +0000 (UTC)
Date: Thu, 13 Mar 2025 12:22:52 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: zoudongjie <zoudongjie@huawei.com>
Cc: zhuyangyang14@huawei.com, qemu-devel@nongnu.org, fam@euphon.net,
 hreitz@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 luolongmin@huawei.com, suxiaodong1@huawei.com,
 wangyan122@huawei.com, yebiaoxiang@huawei.com,
 wangjian161@huawei.com, mujinsheng@huawei.com, alex.chen@huawei.com,
 eric.fangyi@huawei.com, chenjianfei3@huawei.com, renxuming@huawei.com
Subject: Re: [PATCH 1/2] io/block: Refactoring the bdrv_drained_begin()
 function and implement a timeout mechanism.
Message-ID: <20250313042252.GC1074020@fedora>
References: <20250308101618.721954-1-zoudongjie@huawei.com>
 <20250308101618.721954-2-zoudongjie@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bm+/56xT04SxmdRt"
Content-Disposition: inline
In-Reply-To: <20250308101618.721954-2-zoudongjie@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


--bm+/56xT04SxmdRt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 08, 2025 at 06:16:17PM +0800, zoudongjie wrote:
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
>  block/io.c               | 55 ++++++++++++++++++++++++++++++-------
>  include/block/aio-wait.h | 58 ++++++++++++++++++++++++++++++++++++++++
>  include/block/block-io.h |  7 +++++
>  util/aio-wait.c          |  7 +++++
>  4 files changed, 117 insertions(+), 10 deletions(-)
>=20
> diff --git a/block/io.c b/block/io.c
> index d369b994df..03b8b2dca7 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -255,6 +255,8 @@ typedef struct {
>      bool begin;
>      bool poll;
>      BdrvChild *parent;
> +    int ret;
> +    int64_t timeout;
>  } BdrvCoDrainData;
> =20
>  /* Returns true if BDRV_POLL_WHILE() should go into a blocking aio_poll(=
) */
> @@ -283,6 +285,8 @@ static bool bdrv_drain_poll_top_level(BlockDriverStat=
e *bs,
>      return bdrv_drain_poll(bs, ignore_parent, false);
>  }
> =20
> +static int bdrv_do_drained_begin_timeout(BlockDriverState *bs,
> +    BdrvChild *parent, bool poll, int64_t timeout);
>  static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *paren=
t,
>                                    bool poll);
>  static void bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent);
> @@ -296,7 +300,8 @@ static void bdrv_co_drain_bh_cb(void *opaque)
>      if (bs) {
>          bdrv_dec_in_flight(bs);
>          if (data->begin) {
> -            bdrv_do_drained_begin(bs, data->parent, data->poll);
> +            data->ret =3D bdrv_do_drained_begin_timeout(
> +                bs, data->parent, data->poll, data->timeout);
>          } else {
>              assert(!data->poll);
>              bdrv_do_drained_end(bs, data->parent);
> @@ -310,10 +315,11 @@ static void bdrv_co_drain_bh_cb(void *opaque)
>      aio_co_wake(co);
>  }
> =20
> -static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
> -                                                bool begin,
> -                                                BdrvChild *parent,
> -                                                bool poll)
> +static int coroutine_fn bdrv_co_yield_to_drain_timeout(BlockDriverState =
*bs,
> +                                                         bool begin,
> +                                                         BdrvChild *pare=
nt,
> +                                                         bool poll,
> +                                                         int64_t timeout)
>  {
>      BdrvCoDrainData data;
>      Coroutine *self =3D qemu_coroutine_self();
> @@ -329,6 +335,8 @@ static void coroutine_fn bdrv_co_yield_to_drain(Block=
DriverState *bs,
>          .begin =3D begin,
>          .parent =3D parent,
>          .poll =3D poll,
> +        .timeout =3D timeout,
> +        .ret =3D 0
>      };
> =20
>      if (bs) {
> @@ -342,16 +350,25 @@ static void coroutine_fn bdrv_co_yield_to_drain(Blo=
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
> +    bdrv_co_yield_to_drain_timeout(bs, begin, parent, poll, -1);
> +}
> +
> +static int bdrv_do_drained_begin_timeout(BlockDriverState *bs,
> +    BdrvChild *parent, bool poll, int64_t timeout_ms)
>  {
>      IO_OR_GS_CODE();
> =20
>      if (qemu_in_coroutine()) {
> -        bdrv_co_yield_to_drain(bs, true, parent, poll);
> -        return;
> +        return bdrv_co_yield_to_drain_timeout(bs, true, parent, poll,
> +                                              timeout_ms);
>      }
> =20
>      GLOBAL_STATE_CODE();
> @@ -375,8 +392,20 @@ static void bdrv_do_drained_begin(BlockDriverState *=
bs, BdrvChild *parent,
>       * nodes.
>       */
>      if (poll) {
> -        BDRV_POLL_WHILE(bs, bdrv_drain_poll_top_level(bs, parent));
> +        if (timeout_ms < 0) {
> +            BDRV_POLL_WHILE(bs, bdrv_drain_poll_top_level(bs, parent));
> +        } else {
> +            return BDRV_POLL_WHILE_TIMEOUT(
> +                bs, bdrv_drain_poll_top_level(bs, parent), timeout_ms);
> +        }
>      }
> +    return 0;
> +}
> +
> +static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *paren=
t,
> +                                  bool poll)
> +{
> +    bdrv_do_drained_begin_timeout(bs, parent, poll, -1);
>  }
> =20
>  void bdrv_do_drained_begin_quiesce(BlockDriverState *bs, BdrvChild *pare=
nt)
> @@ -390,6 +419,12 @@ bdrv_drained_begin(BlockDriverState *bs)
>      IO_OR_GS_CODE();
>      bdrv_do_drained_begin(bs, NULL, true);
>  }
> +int coroutine_mixed_fn
> +bdrv_drained_begin_timeout(BlockDriverState *bs, int64_t timeout_ms)
> +{
> +    IO_OR_GS_CODE();
> +    return bdrv_do_drained_begin_timeout(bs, NULL, true, timeout_ms);
> +}
> =20
>  /**
>   * This function does not poll, nor must any of its recursively called
> diff --git a/include/block/aio-wait.h b/include/block/aio-wait.h
> index cf5e8bde1c..efbcb9777a 100644
> --- a/include/block/aio-wait.h
> +++ b/include/block/aio-wait.h
> @@ -28,6 +28,8 @@
>  #include "block/aio.h"
>  #include "qemu/main-loop.h"
> =20
> +#define AIO_WAIT_INTERVAL 10  /* ms */
> +
>  /**
>   * AioWait:
>   *
> @@ -56,6 +58,11 @@ typedef struct {
>      unsigned num_waiters;
>  } AioWait;
> =20
> +typedef struct {
> +    struct QEMUTimer *timer;
> +    int64_t interval;
> +} AioWaitTimer;
> +
>  extern AioWait global_aio_wait;
> =20
>  /**
> @@ -99,6 +106,55 @@ extern AioWait global_aio_wait;
>      qatomic_dec(&wait_->num_waiters);                              \
>      waited_; })
> =20
> +/**
> + * AIO_WAIT_WHILE_TIMEOUT:
> + *
> + * Refer to the implementation of AIO_WAIT_WHILE_INTERNAL,
> + * the timeout parameter is added.
> + */
> +#define AIO_WAIT_WHILE_TIMEOUT(ctx, cond, timeout) ({                   =
 \
> +    int ret_ =3D 0;                                                     =
   \
> +    AioWait *wait_ =3D &global_aio_wait;                                =
   \
> +    AioContext *ctx_ =3D (ctx);                                         =
   \
> +    int64_t start_ =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);          =
   \
> +    int64_t deadline_ =3D start_ + (timeout);                           =
   \
> +    /* Ensure that the aio_poll exits periodically to check timeout. */ =
 \
> +    AioWaitTimer *s_ =3D g_malloc0(sizeof(AioWaitTimer));               =
   \
> +    s_->interval =3D AIO_WAIT_INTERVAL;                                 =
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
> +        s_->timer =3D aio_timer_new(ctx_, QEMU_CLOCK_REALTIME,          =
   \
> +                        SCALE_MS, aio_wait_timer_retry, s_);            =
 \
> +        aio_wait_timer_retry(s_);                                       =
 \
> +        while ((cond)) {                                                =
 \
> +            aio_poll(ctx_, true);                                       =
 \
> +            if (qemu_clock_get_ms(QEMU_CLOCK_REALTIME) > deadline_) {   =
 \
> +                ret_ =3D -ETIMEDOUT;                                    =
   \
> +                break;                                                  =
 \
> +            }                                                           =
 \
> +        }                                                               =
 \
> +    } else {                                                            =
 \
> +        s_->timer =3D aio_timer_new(qemu_get_aio_context(),             =
   \
> +            QEMU_CLOCK_REALTIME, SCALE_MS, aio_wait_timer_retry, s_);   =
 \
> +        aio_wait_timer_retry(s_);                                       =
 \
> +        while ((cond)) {                                                =
 \
> +            assert(qemu_get_current_aio_context() =3D=3D                =
     \
> +                   qemu_get_aio_context());                             =
 \
> +            aio_poll(qemu_get_aio_context(), true);                     =
 \
> +            if (qemu_clock_get_ms(QEMU_CLOCK_REALTIME) > deadline_) {   =
 \
> +                ret_ =3D -ETIMEDOUT;                                    =
   \
> +                break;                                                  =
 \
> +            }                                                           =
 \
> +        }                                                               =
 \
> +    }                                                                   =
 \
> +    qatomic_dec(&wait_->num_waiters);                                   =
 \
> +    timer_free(s_->timer);                                              =
 \
> +    g_free(s_);                                                         =
 \
> +    ret_; })
> +
>  #define AIO_WAIT_WHILE(ctx, cond)                                  \
>      AIO_WAIT_WHILE_INTERNAL(ctx, cond)
> =20
> @@ -149,4 +205,6 @@ static inline bool in_aio_context_home_thread(AioCont=
ext *ctx)
>      }
>  }
> =20
> +void aio_wait_timer_retry(void *opaque);
> +
>  #endif /* QEMU_AIO_WAIT_H */
> diff --git a/include/block/block-io.h b/include/block/block-io.h
> index b49e0537dd..84f92d2b09 100644
> --- a/include/block/block-io.h
> +++ b/include/block/block-io.h
> @@ -354,6 +354,11 @@ bdrv_co_copy_range(BdrvChild *src, int64_t src_offse=
t,
>      AIO_WAIT_WHILE(bdrv_get_aio_context(bs_),              \
>                     cond); })
> =20
> +#define BDRV_POLL_WHILE_TIMEOUT(bs, cond, timeout) ({      \
> +    BlockDriverState *bs_ =3D (bs);                          \
> +    AIO_WAIT_WHILE_TIMEOUT(bdrv_get_aio_context(bs_),      \
> +                           cond, timeout); })
> +
>  void bdrv_drain(BlockDriverState *bs);
> =20
>  int co_wrapper_mixed_bdrv_rdlock
> @@ -431,6 +436,8 @@ bdrv_drain_poll(BlockDriverState *bs, BdrvChild *igno=
re_parent,
>   */
>  void bdrv_drained_begin(BlockDriverState *bs);
> =20
> +int bdrv_drained_begin_timeout(BlockDriverState *bs, int64_t timeout_ms);

Missing documentation, especially that bdrv_drained_end() must be called
when -ETIMEDOUT is returned.

> +
>  /**
>   * bdrv_do_drained_begin_quiesce:
>   *
> diff --git a/util/aio-wait.c b/util/aio-wait.c
> index b5336cf5fd..9aed165529 100644
> --- a/util/aio-wait.c
> +++ b/util/aio-wait.c
> @@ -84,3 +84,10 @@ void aio_wait_bh_oneshot(AioContext *ctx, QEMUBHFunc *=
cb, void *opaque)
>      aio_bh_schedule_oneshot(ctx, aio_wait_bh, &data);
>      AIO_WAIT_WHILE_UNLOCKED(NULL, !data.done);
>  }
> +
> +void aio_wait_timer_retry(void *opaque)
> +{
> +    AioWaitTimer *s =3D opaque;
> +
> +    timer_mod(s->timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + s->inte=
rval);
> +}
> --=20
> 2.33.0
>=20

--bm+/56xT04SxmdRt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfSXZwACgkQnKSrs4Gr
c8hPTQf/Xw65Fxh30CFyMwUjNtnIYRh1oq3vrujHRLr3WTO0Og53pAAMxAxqeCgT
97reQs5Flyfo6d97KiKPjodhKTrDSZXm2oA5KvEJXmA6ZJ9CPleIVaDxoFGrtilD
LGeIAlFThPXbDA5vX5VklHyKZIgrVT4X7A+SO4EUD1AaBx5D6ofktCfl55XXWMhg
BhtFOs5Iss5sQtnimORVAF70c7fUUFLKqmP8fLAnfL8uTnWH2HcCg9in1Dd3RDv6
OQTvbq+ufvNT+9rIJ2pFi93hwKBLSAob7qA4J42T4FDGK/Vpxli3Q2hy9ygrRhkd
rcX9SGnccyHbURaEZOW880Ed9qTrcA==
=0Yk1
-----END PGP SIGNATURE-----

--bm+/56xT04SxmdRt--


