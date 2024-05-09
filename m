Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEA8C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 18:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s58Pq-0003Tt-EK; Thu, 09 May 2024 14:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s58Pi-0003TH-RG
 for qemu-devel@nongnu.org; Thu, 09 May 2024 14:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s58Pf-0004bF-K0
 for qemu-devel@nongnu.org; Thu, 09 May 2024 14:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715278958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z/QVKrrKtW+QExwkygZ4VyGHjmuxBCnJ1gdmWOK81mY=;
 b=Up/tEAQyFJbT2AOnPAfhN2lKlYIrqpBK4BAf19iYiJyLrIxk3lZ4K9yvz/f5UEykOpYD7u
 8Xz0WG+2fN1yKDqESJzBj2D7ev2obJNtDxNzUGTyHuCMtTAiLtsDZFa3OUQftw/AQBzQ+V
 lsdZ2K4fk/Gyb/vyLpfHDZm4sKllIKU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-bjUynFPQM6CRNaEx1FUbSw-1; Thu, 09 May 2024 14:22:33 -0400
X-MC-Unique: bjUynFPQM6CRNaEx1FUbSw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C260101A525;
 Thu,  9 May 2024 18:22:32 +0000 (UTC)
Received: from localhost (unknown [10.39.192.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23461FA025;
 Thu,  9 May 2024 18:22:29 +0000 (UTC)
Date: Thu, 9 May 2024 14:22:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 1/9] block: add persistent reservation in/out api
Message-ID: <20240509182228.GC515246@fedora.redhat.com>
References: <20240508093629.441057-1-luchangqi.123@bytedance.com>
 <20240508093629.441057-2-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mbqy2WFbpknYSD58"
Content-Disposition: inline
In-Reply-To: <20240508093629.441057-2-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--mbqy2WFbpknYSD58
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 05:36:21PM +0800, Changqi Lu wrote:
> Add persistent reservation in/out operations
> at the block level. The following operations
> are included:
>=20
> - read_keys:        retrieves the list of registered keys.
> - read_reservation: retrieves the current reservation status.
> - register:         registers a new reservation key.
> - reserve:          initiates a reservation for a specific key.
> - release:          releases a reservation for a specific key.
> - clear:            clears all existing reservations.
> - preempt:          preempts a reservation held by another key.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  block/block-backend.c             | 386 ++++++++++++++++++++++++++++++
>  block/io.c                        | 161 +++++++++++++
>  include/block/block-common.h      |   9 +
>  include/block/block-io.h          |  19 ++
>  include/block/block_int-common.h  |  31 +++
>  include/sysemu/block-backend-io.h |  22 ++
>  6 files changed, 628 insertions(+)
>=20
> diff --git a/block/block-backend.c b/block/block-backend.c
> index db6f9b92a3..ec67937d28 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -1770,6 +1770,392 @@ BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsi=
gned long int req, void *buf,
>      return blk_aio_prwv(blk, req, 0, buf, blk_aio_ioctl_entry, 0, cb, op=
aque);
>  }
> =20
> +typedef struct BlkPrInCo {
> +    BlockBackend *blk;
> +    uint32_t *generation;
> +    uint32_t num_keys;
> +    BlockPrType *type;
> +    uint64_t *keys;
> +    int ret;
> +} BlkPrInCo;
> +
> +typedef struct BlkPrInCB {
> +    BlockAIOCB common;
> +    BlkPrInCo prco;
> +    bool has_returned;
> +} BlkPrInCB;
> +
> +static const AIOCBInfo blk_pr_in_aiocb_info =3D {
> +    .aiocb_size         =3D sizeof(BlkPrInCB),
> +};
> +
> +static void blk_pr_in_complete(BlkPrInCB *acb)
> +{
> +    if (acb->has_returned) {
> +        acb->common.cb(acb->common.opaque, acb->prco.ret);
> +        blk_dec_in_flight(acb->prco.blk);

Please add a comment identifying which blk_inc_in_flight() call this dec
is paired with. That makes it easier for people trying to understand
in-flight reference counting.

> +        qemu_aio_unref(acb);
> +    }
> +}
> +
> +static void blk_pr_in_complete_bh(void *opaque)
> +{
> +    BlkPrInCB *acb =3D opaque;
> +    assert(acb->has_returned);
> +    blk_pr_in_complete(acb);
> +}
> +
> +static BlockAIOCB *blk_aio_pr_in(BlockBackend *blk, uint32_t *generation,
> +                                 uint32_t num_keys, BlockPrType *type,
> +                                 uint64_t *keys, CoroutineEntry co_entry,
> +                                 BlockCompletionFunc *cb, void *opaque)
> +{
> +    BlkPrInCB *acb;
> +    Coroutine *co;
> +
> +    blk_inc_in_flight(blk);

Please add a comment identifying which blk_dec_in_flight() call this inc
is paired with.

> +    acb =3D blk_aio_get(&blk_pr_in_aiocb_info, blk, cb, opaque);
> +    acb->prco =3D (BlkPrInCo) {
> +        .blk        =3D blk,
> +        .generation =3D generation,
> +        .num_keys   =3D num_keys,
> +        .type       =3D type,
> +        .ret        =3D NOT_DONE,
> +        .keys       =3D keys,
> +    };
> +    acb->has_returned =3D false;
> +
> +    co =3D qemu_coroutine_create(co_entry, acb);
> +    aio_co_enter(qemu_get_current_aio_context(), co);
> +
> +    acb->has_returned =3D true;
> +    if (acb->prco.ret !=3D NOT_DONE) {
> +        replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
> +                                         blk_pr_in_complete_bh, acb);
> +    }
> +
> +    return &acb->common;
> +}
> +
> +
> +static int coroutine_fn
> +blk_aio_pr_do_read_keys(BlockBackend *blk, uint32_t *generation,
> +                        uint32_t num_keys, uint64_t *keys)
> +{
> +    IO_CODE();
> +
> +    blk_wait_while_drained(blk);
> +    GRAPH_RDLOCK_GUARD();
> +
> +    if (!blk_co_is_available(blk)) {
> +        return -ENOMEDIUM;
> +    }
> +
> +    return bdrv_co_pr_read_keys(blk_bs(blk), generation, num_keys, keys);
> +}
> +
> +static void coroutine_fn blk_aio_pr_read_keys_entry(void *opaque)
> +{
> +    BlkPrInCB *acb =3D opaque;
> +    BlkPrInCo *prco =3D &acb->prco;
> +
> +    prco->ret =3D blk_aio_pr_do_read_keys(prco->blk, prco->generation,
> +                                        prco->num_keys, prco->keys);
> +    blk_pr_in_complete(acb);
> +}
> +
> +BlockAIOCB *blk_aio_pr_read_keys(BlockBackend *blk, uint32_t *generation,
> +                                 uint32_t num_keys, uint64_t *keys,
> +                                 BlockCompletionFunc *cb, void *opaque)
> +{
> +    IO_CODE();
> +    return blk_aio_pr_in(blk, generation, num_keys, NULL, keys,
> +                         blk_aio_pr_read_keys_entry, cb, opaque);
> +}
> +
> +
> +static int coroutine_fn
> +blk_aio_pr_do_read_reservation(BlockBackend *blk, uint32_t *generation,
> +                               uint64_t *key, BlockPrType *type)
> +{
> +    IO_CODE();
> +
> +    blk_wait_while_drained(blk);
> +    GRAPH_RDLOCK_GUARD();
> +
> +    if (!blk_co_is_available(blk)) {
> +        return -ENOMEDIUM;
> +    }
> +
> +    return bdrv_co_pr_read_reservation(blk_bs(blk), generation, key, typ=
e);
> +}
> +
> +static void coroutine_fn blk_aio_pr_read_reservation_entry(void *opaque)
> +{
> +    BlkPrInCB *acb =3D opaque;
> +    BlkPrInCo *prco =3D &acb->prco;
> +
> +    prco->ret =3D blk_aio_pr_do_read_reservation(prco->blk, prco->genera=
tion,
> +                                               prco->keys, prco->type);
> +    blk_pr_in_complete(acb);
> +}
> +
> +BlockAIOCB *blk_aio_pr_read_reservation(BlockBackend *blk, uint32_t *gen=
eration,
> +                                        uint64_t *key, BlockPrType *type,
> +                                        BlockCompletionFunc *cb, void *o=
paque)
> +{
> +    IO_CODE();
> +    return blk_aio_pr_in(blk, generation, 0, type, key,
> +                         blk_aio_pr_read_reservation_entry, cb, opaque);
> +}
> +
> +
> +typedef struct BlkPrOutCo {
> +    BlockBackend *blk;
> +    uint64_t old_key;
> +    uint64_t new_key;
> +    BlockPrType type;
> +    bool ignore_key;
> +    bool abort;
> +    int ret;
> +} BlkPrOutCo;
> +
> +typedef struct BlkPrOutCB {
> +    BlockAIOCB common;
> +    BlkPrOutCo prco;
> +    bool has_returned;
> +} BlkPrOutCB;
> +
> +static const AIOCBInfo blk_pr_out_aiocb_info =3D {
> +    .aiocb_size         =3D sizeof(BlkPrOutCB),
> +};
> +
> +static void blk_pr_out_complete(BlkPrOutCB *acb)
> +{
> +    if (acb->has_returned) {
> +        acb->common.cb(acb->common.opaque, acb->prco.ret);
> +        blk_dec_in_flight(acb->prco.blk);

Same here.

> +        qemu_aio_unref(acb);
> +    }
> +}
> +
> +static void blk_pr_out_complete_bh(void *opaque)
> +{
> +    BlkPrOutCB *acb =3D opaque;
> +    assert(acb->has_returned);
> +    blk_pr_out_complete(acb);
> +}
> +
> +static BlockAIOCB *blk_aio_pr_out(BlockBackend *blk, uint64_t old_key,
> +                                  uint64_t new_key, BlockPrType type,
> +                                  bool ignore_key, bool abort,
> +                                  CoroutineEntry co_entry,
> +                                  BlockCompletionFunc *cb, void *opaque)
> +{
> +    BlkPrOutCB *acb;
> +    Coroutine *co;
> +
> +    blk_inc_in_flight(blk);

Same here.

> +    acb =3D blk_aio_get(&blk_pr_out_aiocb_info, blk, cb, opaque);
> +    acb->prco =3D (BlkPrOutCo) {
> +        .blk        =3D blk,
> +        .old_key    =3D old_key,
> +        .new_key    =3D new_key,
> +        .type       =3D type,
> +        .ignore_key =3D ignore_key,
> +        .abort      =3D abort,
> +        .ret        =3D NOT_DONE,
> +    };
> +    acb->has_returned =3D false;
> +
> +    co =3D qemu_coroutine_create(co_entry, acb);
> +    aio_co_enter(qemu_get_current_aio_context(), co);
> +
> +    acb->has_returned =3D true;
> +    if (acb->prco.ret !=3D NOT_DONE) {
> +        replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
> +                                         blk_pr_out_complete_bh, acb);
> +    }
> +
> +    return &acb->common;
> +}
> +
> +static int coroutine_fn
> +blk_aio_pr_do_register(BlockBackend *blk, uint64_t old_key,
> +                       uint64_t new_key, BlockPrType type,
> +                       bool ignore_key)
> +{
> +    IO_CODE();
> +
> +    blk_wait_while_drained(blk);
> +    GRAPH_RDLOCK_GUARD();
> +
> +    if (!blk_co_is_available(blk)) {
> +        return -ENOMEDIUM;
> +    }
> +
> +    return bdrv_co_pr_register(blk_bs(blk), old_key, new_key, type, igno=
re_key);
> +}
> +
> +static void coroutine_fn blk_aio_pr_register_entry(void *opaque)
> +{
> +    BlkPrOutCB *acb =3D opaque;
> +    BlkPrOutCo *prco =3D &acb->prco;
> +
> +    prco->ret =3D blk_aio_pr_do_register(prco->blk, prco->old_key, prco-=
>new_key,
> +                                       prco->type, prco->ignore_key);
> +    blk_pr_out_complete(acb);
> +}
> +
> +BlockAIOCB *blk_aio_pr_register(BlockBackend *blk, uint64_t old_key,
> +                                uint64_t new_key, BlockPrType type,
> +                                bool ignore_key, BlockCompletionFunc *cb,
> +                                void *opaque)
> +{
> +    IO_CODE();
> +    return blk_aio_pr_out(blk, old_key, new_key, type, ignore_key, false,
> +                          blk_aio_pr_register_entry, cb, opaque);
> +}
> +
> +static int coroutine_fn
> +blk_aio_pr_do_reserve(BlockBackend *blk, uint64_t key, BlockPrType type)
> +{
> +    IO_CODE();
> +
> +    blk_wait_while_drained(blk);
> +    GRAPH_RDLOCK_GUARD();
> +
> +    if (!blk_co_is_available(blk)) {
> +        return -ENOMEDIUM;
> +    }
> +
> +    return bdrv_co_pr_reserve(blk_bs(blk), key, type);
> +}
> +
> +static void coroutine_fn blk_aio_pr_reserve_entry(void *opaque)
> +{
> +    BlkPrOutCB *acb =3D opaque;
> +    BlkPrOutCo *prco =3D &acb->prco;
> +
> +    prco->ret =3D blk_aio_pr_do_reserve(prco->blk, prco->old_key, prco->=
type);
> +    blk_pr_out_complete(acb);
> +}
> +
> +
> +BlockAIOCB *blk_aio_pr_reserve(BlockBackend *blk,  uint64_t key,
> +                               BlockPrType type, BlockCompletionFunc *cb,
> +                               void *opaque)
> +{
> +    IO_CODE();
> +    return blk_aio_pr_out(blk, key, 0, type, false, false,
> +                          blk_aio_pr_reserve_entry, cb, opaque);
> +}
> +
> +static int coroutine_fn
> +blk_aio_pr_do_release(BlockBackend *blk, uint64_t key, BlockPrType type)
> +{
> +    IO_CODE();
> +
> +    blk_wait_while_drained(blk);
> +    GRAPH_RDLOCK_GUARD();
> +
> +    if (!blk_co_is_available(blk)) {
> +        return -ENOMEDIUM;
> +    }
> +
> +    return bdrv_co_pr_release(blk_bs(blk), key, type);
> +}
> +
> +static void coroutine_fn blk_aio_pr_release_entry(void *opaque)
> +{
> +    BlkPrOutCB *acb =3D opaque;
> +    BlkPrOutCo *prco =3D &acb->prco;
> +
> +    prco->ret =3D blk_aio_pr_do_release(prco->blk, prco->old_key, prco->=
type);
> +    blk_pr_out_complete(acb);
> +}
> +
> +
> +BlockAIOCB *blk_aio_pr_release(BlockBackend *blk, uint64_t key,
> +                               BlockPrType type, BlockCompletionFunc *cb,
> +                               void *opaque)
> +{
> +    IO_CODE();
> +    return blk_aio_pr_out(blk, key, 0, type, false, false,
> +                          blk_aio_pr_release_entry, cb, opaque);
> +}
> +
> +static int coroutine_fn
> +blk_aio_pr_do_clear(BlockBackend *blk, uint64_t key)
> +{
> +    IO_CODE();
> +
> +    blk_wait_while_drained(blk);
> +    GRAPH_RDLOCK_GUARD();
> +
> +    if (!blk_co_is_available(blk)) {
> +        return -ENOMEDIUM;
> +    }
> +
> +    return bdrv_co_pr_clear(blk_bs(blk), key);
> +}
> +
> +static void coroutine_fn blk_aio_pr_clear_entry(void *opaque)
> +{
> +    BlkPrOutCB *acb =3D opaque;
> +    BlkPrOutCo *prco =3D &acb->prco;
> +
> +    prco->ret =3D blk_aio_pr_do_clear(prco->blk, prco->old_key);
> +    blk_pr_out_complete(acb);
> +}
> +
> +
> +BlockAIOCB *blk_aio_pr_clear(BlockBackend *blk, uint64_t key,
> +                             BlockCompletionFunc *cb, void *opaque)
> +{
> +    IO_CODE();
> +    return blk_aio_pr_out(blk, key, 0, 0, false, false,
> +                          blk_aio_pr_clear_entry, cb, opaque);
> +}
> +
> +static int coroutine_fn
> +blk_aio_pr_do_preempt(BlockBackend *blk, uint64_t old_key,
> +                      uint64_t new_key, BlockPrType type, bool abort)
> +{
> +    IO_CODE();
> +
> +    blk_wait_while_drained(blk);
> +    GRAPH_RDLOCK_GUARD();
> +
> +    if (!blk_co_is_available(blk)) {
> +        return -ENOMEDIUM;
> +    }
> +
> +    return bdrv_co_pr_preempt(blk_bs(blk), old_key, new_key, type, abort=
);
> +}
> +
> +static void coroutine_fn blk_aio_pr_preempt_entry(void *opaque)
> +{
> +    BlkPrOutCB *acb =3D opaque;
> +    BlkPrOutCo *prco =3D &acb->prco;
> +
> +    prco->ret =3D blk_aio_pr_do_preempt(prco->blk, prco->old_key,
> +                                      prco->new_key, prco->type,
> +                                      prco->abort);
> +    blk_pr_out_complete(acb);
> +}
> +
> +
> +BlockAIOCB *blk_aio_pr_preempt(BlockBackend *blk, uint64_t old_key,
> +                               uint64_t new_key, BlockPrType type,
> +                               bool abort, BlockCompletionFunc *cb,
> +                               void *opaque)
> +{
> +    IO_CODE();
> +    return blk_aio_pr_out(blk, old_key, new_key, type, false, abort,
> +                          blk_aio_pr_preempt_entry, cb, opaque);
> +}
> +
>  /* To be called between exactly one pair of blk_inc/dec_in_flight() */
>  static int coroutine_fn
>  blk_co_do_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes)
> diff --git a/block/io.c b/block/io.c
> index 7217cf811b..98a358c6b2 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -3220,6 +3220,167 @@ out:
>      return co.ret;
>  }
> =20
> +int coroutine_fn bdrv_co_pr_read_keys(BlockDriverState *bs,
> +                 uint32_t *generation, uint32_t num_keys,
> +                 uint64_t *keys)
> +{
> +    BlockDriver *drv =3D bs->drv;
> +    CoroutineIOCompletion co =3D {
> +        .coroutine =3D qemu_coroutine_self(),
> +    };
> +
> +    IO_CODE();
> +    assert_bdrv_graph_readable();
> +
> +    bdrv_inc_in_flight(bs);
> +    if (!drv || !drv->bdrv_co_pr_read_keys) {
> +        co.ret =3D -ENOTSUP;
> +        goto out;
> +    }
> +
> +    co.ret =3D drv->bdrv_co_pr_read_keys(bs, generation, num_keys, keys);
> +out:
> +    bdrv_dec_in_flight(bs);
> +    return co.ret;
> +}
> +
> +int coroutine_fn bdrv_co_pr_read_reservation(BlockDriverState *bs,
> +                 uint32_t *generation, uint64_t *key, BlockPrType *type)
> +{
> +    BlockDriver *drv =3D bs->drv;
> +    CoroutineIOCompletion co =3D {
> +        .coroutine =3D qemu_coroutine_self(),
> +    };
> +
> +    IO_CODE();
> +    assert_bdrv_graph_readable();
> +
> +    bdrv_inc_in_flight(bs);
> +    if (!drv || !drv->bdrv_co_pr_read_reservation) {
> +        co.ret =3D -ENOTSUP;
> +        goto out;
> +    }
> +
> +    co.ret =3D drv->bdrv_co_pr_read_reservation(bs, generation, key, typ=
e);
> +out:
> +    bdrv_dec_in_flight(bs);
> +    return co.ret;
> +}
> +
> +int coroutine_fn bdrv_co_pr_register(BlockDriverState *bs, uint64_t old_=
key,
> +                 uint64_t new_key, BlockPrType type, bool ignore_key)
> +{
> +    BlockDriver *drv =3D bs->drv;
> +    CoroutineIOCompletion co =3D {
> +        .coroutine =3D qemu_coroutine_self(),
> +    };
> +
> +    IO_CODE();
> +    assert_bdrv_graph_readable();
> +
> +    bdrv_inc_in_flight(bs);
> +    if (!drv || !drv->bdrv_co_pr_register) {
> +        co.ret =3D -ENOTSUP;
> +        goto out;
> +    }
> +
> +    co.ret =3D drv->bdrv_co_pr_register(bs, old_key, new_key, type, igno=
re_key);
> +out:
> +    bdrv_dec_in_flight(bs);
> +    return co.ret;
> +}
> +
> +int coroutine_fn bdrv_co_pr_reserve(BlockDriverState *bs, uint64_t key,
> +                                    BlockPrType type)
> +{
> +    BlockDriver *drv =3D bs->drv;
> +    CoroutineIOCompletion co =3D {
> +        .coroutine =3D qemu_coroutine_self(),
> +    };
> +
> +    IO_CODE();
> +    assert_bdrv_graph_readable();
> +
> +    bdrv_inc_in_flight(bs);
> +    if (!drv || !drv->bdrv_co_pr_reserve) {
> +        co.ret =3D -ENOTSUP;
> +        goto out;
> +    }
> +
> +    co.ret =3D drv->bdrv_co_pr_reserve(bs, key, type);
> +out:
> +    bdrv_dec_in_flight(bs);
> +    return co.ret;
> +}
> +
> +int coroutine_fn bdrv_co_pr_release(BlockDriverState *bs, uint64_t key,
> +                                    BlockPrType type)
> +{
> +    BlockDriver *drv =3D bs->drv;
> +    CoroutineIOCompletion co =3D {
> +        .coroutine =3D qemu_coroutine_self(),
> +    };
> +
> +    IO_CODE();
> +    assert_bdrv_graph_readable();
> +
> +    bdrv_inc_in_flight(bs);
> +    if (!drv || !drv->bdrv_co_pr_release) {
> +        co.ret =3D -ENOTSUP;
> +        goto out;
> +    }
> +
> +    co.ret =3D drv->bdrv_co_pr_release(bs, key, type);
> +out:
> +    bdrv_dec_in_flight(bs);
> +    return co.ret;
> +}
> +
> +int coroutine_fn bdrv_co_pr_clear(BlockDriverState *bs, uint64_t key)
> +{
> +    BlockDriver *drv =3D bs->drv;
> +    CoroutineIOCompletion co =3D {
> +        .coroutine =3D qemu_coroutine_self(),
> +    };
> +
> +    IO_CODE();
> +    assert_bdrv_graph_readable();
> +
> +    bdrv_inc_in_flight(bs);
> +    if (!drv || !drv->bdrv_co_pr_clear) {
> +        co.ret =3D -ENOTSUP;
> +        goto out;
> +    }
> +
> +    co.ret =3D drv->bdrv_co_pr_clear(bs, key);
> +out:
> +    bdrv_dec_in_flight(bs);
> +    return co.ret;
> +}
> +
> +int coroutine_fn bdrv_co_pr_preempt(BlockDriverState *bs, uint64_t old_k=
ey,
> +                       uint64_t new_key, BlockPrType type, bool abort)
> +{
> +    BlockDriver *drv =3D bs->drv;
> +    CoroutineIOCompletion co =3D {
> +        .coroutine =3D qemu_coroutine_self(),
> +    };
> +
> +    IO_CODE();
> +    assert_bdrv_graph_readable();
> +
> +    bdrv_inc_in_flight(bs);
> +    if (!drv || !drv->bdrv_co_pr_preempt) {
> +        co.ret =3D -ENOTSUP;
> +        goto out;
> +    }
> +
> +    co.ret =3D drv->bdrv_co_pr_preempt(bs, old_key, new_key, type, abort=
);
> +out:
> +    bdrv_dec_in_flight(bs);
> +    return co.ret;
> +}
> +
>  int coroutine_fn bdrv_co_zone_report(BlockDriverState *bs, int64_t offse=
t,
>                          unsigned int *nr_zones,
>                          BlockZoneDescriptor *zones)
> diff --git a/include/block/block-common.h b/include/block/block-common.h
> index a846023a09..c078d69f79 100644
> --- a/include/block/block-common.h
> +++ b/include/block/block-common.h
> @@ -524,6 +524,15 @@ typedef enum {
>      BDRV_FIX_ERRORS   =3D 2,
>  } BdrvCheckMode;
> =20
> +typedef enum {
> +    BLK_PR_WRITE_EXCLUSIVE              =3D 0x1,
> +    BLK_PR_EXCLUSIVE_ACCESS             =3D 0x2,
> +    BLK_PR_WRITE_EXCLUSIVE_REGS_ONLY    =3D 0x3,
> +    BLK_PR_EXCLUSIVE_ACCESS_REGS_ONLY   =3D 0x4,
> +    BLK_PR_WRITE_EXCLUSIVE_ALL_REGS     =3D 0x5,
> +    BLK_PR_EXCLUSIVE_ACCESS_ALL_REGS    =3D 0x6,

Documentation needed. If you don't want to document the full meaning
here, please include a comment referring to a specific section in a
SCSI/NVMe standard that explains the semantics.

> +} BlockPrType;
> +
>  typedef struct BlockSizes {
>      uint32_t phys;
>      uint32_t log;
> diff --git a/include/block/block-io.h b/include/block/block-io.h
> index b49e0537dd..f2827cd74e 100644
> --- a/include/block/block-io.h
> +++ b/include/block/block-io.h
> @@ -106,6 +106,25 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb);
>  int coroutine_fn GRAPH_RDLOCK
>  bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf);
> =20
> +int coroutine_fn GRAPH_RDLOCK
> +bdrv_co_pr_read_keys(BlockDriverState *bs, uint32_t *generation,
> +                     uint32_t num_keys, uint64_t *keys);
> +int coroutine_fn GRAPH_RDLOCK
> +bdrv_co_pr_read_reservation(BlockDriverState *bs, uint32_t *generation,
> +                            uint64_t *key, BlockPrType *type);
> +int coroutine_fn GRAPH_RDLOCK
> +bdrv_co_pr_register(BlockDriverState *bs, uint64_t old_key,
> +                    uint64_t new_key, BlockPrType type, bool ignore_key);
> +int coroutine_fn GRAPH_RDLOCK
> +bdrv_co_pr_reserve(BlockDriverState *bs, uint64_t key, BlockPrType type);
> +int coroutine_fn GRAPH_RDLOCK
> +bdrv_co_pr_release(BlockDriverState *bs, uint64_t key, BlockPrType type);
> +int coroutine_fn GRAPH_RDLOCK
> +bdrv_co_pr_clear(BlockDriverState *bs, uint64_t key);
> +int coroutine_fn GRAPH_RDLOCK
> +bdrv_co_pr_preempt(BlockDriverState *bs, uint64_t old_key, uint64_t new_=
key,
> +                   BlockPrType type, bool abort);
> +
>  /* Ensure contents are flushed to disk.  */
>  int coroutine_fn GRAPH_RDLOCK bdrv_co_flush(BlockDriverState *bs);
> =20
> diff --git a/include/block/block_int-common.h b/include/block/block_int-c=
ommon.h
> index 761276127e..e5526f1d04 100644
> --- a/include/block/block_int-common.h
> +++ b/include/block/block_int-common.h
> @@ -766,6 +766,37 @@ struct BlockDriver {
>      int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_ioctl)(
>          BlockDriverState *bs, unsigned long int req, void *buf);
> =20
> +    /**
> +     * bdrv_co_pr_read_keys is called to read the registered keys,
> +     * @num_keys is the maximum number of keys that can be transmitted.
> +     * On success, store generation in @generation and store keys @keys
> +     * and return the number of @keys.
> +     * On failure return -errno.
> +     */
> +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_read_keys)(
> +        BlockDriverState *bs, uint32_t *generation,
> +        uint32_t num_keys, uint64_t *keys);
> +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_read_reservation)(
> +        BlockDriverState *bs, uint32_t *generation,
> +        uint64_t *key, BlockPrType *type);

Plase add doc comments for each new function. It's okay to refer to
specific sections in the SCSI or NVMe standards if explaining the
concepts is too verbose. Someone implementing persistent reservations
support in another block driver must be able to figure out what the
exact model for persistent reservations is.

> +
> +    /**
> +     * Persist Through Power Loss(PTPL) is considered as required in QEMU
> +     * block layer, the block driver need always enable PTPL.
> +     */

What is the reasoning behind this? Will applications that rely on PTPL=3D0
work?

> +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_register)(
> +        BlockDriverState *bs, uint64_t old_key,
> +        uint64_t new_key, BlockPrType type, bool ignore_key);
> +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_reserve)(
> +        BlockDriverState *bs, uint64_t key, BlockPrType type);
> +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_release)(
> +        BlockDriverState *bs, uint64_t key, BlockPrType type);
> +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_clear)(
> +        BlockDriverState *bs, uint64_t key);
> +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_preempt)(
> +        BlockDriverState *bs, uint64_t old_key,
> +        uint64_t new_key, BlockPrType type, bool abort);

Does a block driver need to implement all or none of these callbacks? I
guess they are not optional on a per-callback basis.

> +
>      /*
>       * Returns 0 for completed check, -errno for internal errors.
>       * The check results are stored in result.
> diff --git a/include/sysemu/block-backend-io.h b/include/sysemu/block-bac=
kend-io.h
> index d174275a5c..f87c61c06e 100644
> --- a/include/sysemu/block-backend-io.h
> +++ b/include/sysemu/block-backend-io.h
> @@ -62,6 +62,28 @@ void blk_aio_cancel_async(BlockAIOCB *acb);
>  BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void=
 *buf,
>                            BlockCompletionFunc *cb, void *opaque);
> =20
> +BlockAIOCB *blk_aio_pr_read_keys(BlockBackend *blk, uint32_t *generation,
> +                                 uint32_t num_keys, uint64_t *keys,
> +                                 BlockCompletionFunc *cb, void *opaque);
> +BlockAIOCB *blk_aio_pr_read_reservation(BlockBackend *blk, uint32_t *gen=
eration,
> +                                        uint64_t *key, BlockPrType *type,
> +                                        BlockCompletionFunc *cb, void *o=
paque);
> +BlockAIOCB *blk_aio_pr_register(BlockBackend *blk, uint64_t old_key,
> +                                uint64_t new_key, BlockPrType type,
> +                                bool ignore_key, BlockCompletionFunc *cb,
> +                                void *opaque);
> +BlockAIOCB *blk_aio_pr_reserve(BlockBackend *blk,  uint64_t key,
> +                               BlockPrType type, BlockCompletionFunc *cb,
> +                               void *opaque);
> +BlockAIOCB *blk_aio_pr_release(BlockBackend *blk, uint64_t key,
> +                               BlockPrType type, BlockCompletionFunc *cb,
> +                               void *opaque);
> +BlockAIOCB *blk_aio_pr_clear(BlockBackend *blk, uint64_t key,
> +                             BlockCompletionFunc *cb, void *opaque);
> +BlockAIOCB *blk_aio_pr_preempt(BlockBackend *blk, uint64_t old_key,
> +                               uint64_t new_key, BlockPrType type, bool =
abort,
> +                               BlockCompletionFunc *cb, void *opaque);
> +
>  void blk_inc_in_flight(BlockBackend *blk);
>  void blk_dec_in_flight(BlockBackend *blk);
> =20
> --=20
> 2.20.1
>=20

--mbqy2WFbpknYSD58
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmY9FGMACgkQnKSrs4Gr
c8hIUgf/avgJrnXqAqD7J+k7g8WHlcMS5f6lgCch/lwUHZlJwng/TR77icuDHwcj
qAYQjVE7xevomTXBTlvEHhSH7BHNU9KqLJ13roeI/312MZ9oQVNHOif4AmXT90wt
kooKw6Ceku8+lUBwLL3dvKQdiw8Ex0h5oz1W2Na8cGVWJq+PWIT5XylYodkC8e7Q
4Lco2QnMbihAd2gon1DHfGv/ihKhfV7yQCxP0irmMzOQQlUFT2GB13GiE8bMRzIN
S3ApVBQJXLoGpb83wvdkQlt/J/qiqPN+YCilzEf4SYziZ7U00ZjjpRKV7w++aS8G
utOkpjWcNCZ05DnRo0BQDpUsH1jJDQ==
=6dW9
-----END PGP SIGNATURE-----

--mbqy2WFbpknYSD58--


