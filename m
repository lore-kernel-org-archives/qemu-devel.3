Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A24C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 17:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGinQ-0003kO-0y; Mon, 10 Jun 2024 13:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sGinN-0003i2-Bi
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sGinJ-0003oz-VR
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718040416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lc0ml7SNkGtVVdgm0zFaPwJSYf6uHIj5VSLzPLmnyrY=;
 b=HYm84tIAYjRXjCTE+EUjG0+Tp39tvFRg6Py3acIzRPb6Rh/cI0mzA514zwRlMob2NeKJqj
 orfugiTGyS/Dxpbi2yP6GMeR4cTUy8IYf+5I+XzqC4ZL6Z3sFuklc/WJz2JUSe5yPWA0lH
 Cqq86wq63D1mRdYmLAJdu8MrVhBysIM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-vY3Mr3L4PUe4oDk-oVGjKQ-1; Mon,
 10 Jun 2024 13:26:51 -0400
X-MC-Unique: vY3Mr3L4PUe4oDk-oVGjKQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C0BE195605F; Mon, 10 Jun 2024 17:26:47 +0000 (UTC)
Received: from localhost (unknown [10.39.195.112])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8668F1956089; Mon, 10 Jun 2024 17:26:45 +0000 (UTC)
Date: Mon, 10 Jun 2024 13:26:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v5 01/10] block: add persistent reservation in/out api
Message-ID: <20240610172643.GB334653@fedora.redhat.com>
References: <20240606122444.2914576-1-luchangqi.123@bytedance.com>
 <20240606122444.2914576-2-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TN78XIvGZ/gvOYpZ"
Content-Disposition: inline
In-Reply-To: <20240606122444.2914576-2-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--TN78XIvGZ/gvOYpZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 08:24:35PM +0800, Changqi Lu wrote:
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
>  block/block-backend.c             | 397 ++++++++++++++++++++++++++++++
>  block/io.c                        | 163 ++++++++++++
>  include/block/block-common.h      |  40 +++
>  include/block/block-io.h          |  20 ++
>  include/block/block_int-common.h  |  84 +++++++
>  include/sysemu/block-backend-io.h |  24 ++
>  6 files changed, 728 insertions(+)
>=20
> diff --git a/block/block-backend.c b/block/block-backend.c
> index db6f9b92a3..6707d94df7 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -1770,6 +1770,403 @@ BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsi=
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

Did you receive my replies to v1 of this patch series?

Please take a look at them and respond:
https://lore.kernel.org/qemu-devel/20240508093629.441057-1-luchangqi.123@by=
tedance.com/

Thanks,
Stefan

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
> +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
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
> +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
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
> +typedef struct BlkPrOutCo {
> +    BlockBackend *blk;
> +    uint64_t old_key;
> +    uint64_t new_key;
> +    bool ptpl;
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
> +                                  uint64_t new_key, bool ptpl,
> +                                  BlockPrType type, bool ignore_key,
> +                                  bool abort, CoroutineEntry co_entry,
> +                                  BlockCompletionFunc *cb, void *opaque)
> +{
> +    BlkPrOutCB *acb;
> +    Coroutine *co;
> +
> +    blk_inc_in_flight(blk);
> +    acb =3D blk_aio_get(&blk_pr_out_aiocb_info, blk, cb, opaque);
> +    acb->prco =3D (BlkPrOutCo) {
> +        .blk        =3D blk,
> +        .old_key    =3D old_key,
> +        .new_key    =3D new_key,
> +        .ptpl       =3D ptpl,
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
> +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
> +static int coroutine_fn
> +blk_aio_pr_do_register(BlockBackend *blk, uint64_t old_key,
> +                       uint64_t new_key, BlockPrType type,
> +                       bool ptpl, bool ignore_key)
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
> +    return bdrv_co_pr_register(blk_bs(blk), old_key, new_key, type,
> +                               ptpl, ignore_key);
> +}
> +
> +static void coroutine_fn blk_aio_pr_register_entry(void *opaque)
> +{
> +    BlkPrOutCB *acb =3D opaque;
> +    BlkPrOutCo *prco =3D &acb->prco;
> +
> +    prco->ret =3D blk_aio_pr_do_register(prco->blk, prco->old_key, prco-=
>new_key,
> +                                       prco->type, prco->ptpl,
> +                                       prco->ignore_key);
> +    blk_pr_out_complete(acb);
> +}
> +
> +BlockAIOCB *blk_aio_pr_register(BlockBackend *blk, uint64_t old_key,
> +                                uint64_t new_key, BlockPrType type,
> +                                bool ptpl, bool ignore_key,
> +                                BlockCompletionFunc *cb,
> +                                void *opaque)
> +{
> +    IO_CODE();
> +    return blk_aio_pr_out(blk, old_key, new_key, ptpl, type, ignore_key,=
 false,
> +                          blk_aio_pr_register_entry, cb, opaque);
> +}
> +
> +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
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
> +    prco->ret =3D blk_aio_pr_do_reserve(prco->blk, prco->old_key,
> +                                      prco->type);
> +    blk_pr_out_complete(acb);
> +}
> +
> +
> +BlockAIOCB *blk_aio_pr_reserve(BlockBackend *blk,  uint64_t key,
> +                               BlockPrType type,
> +                               BlockCompletionFunc *cb,
> +                               void *opaque)
> +{
> +    IO_CODE();
> +    return blk_aio_pr_out(blk, key, 0, false, type, false, false,
> +                          blk_aio_pr_reserve_entry, cb, opaque);
> +}
> +
> +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
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
> +    return blk_aio_pr_out(blk, key, 0, false, type, false, false,
> +                          blk_aio_pr_release_entry, cb, opaque);
> +}
> +
> +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
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
> +    return blk_aio_pr_out(blk, key, 0, false, 0, false, false,
> +                          blk_aio_pr_clear_entry, cb, opaque);
> +}
> +
> +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
> +static int coroutine_fn
> +blk_aio_pr_do_preempt(BlockBackend *blk, uint64_t cr_key,
> +                      uint64_t pr_key, BlockPrType type, bool abort)
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
> +    return bdrv_co_pr_preempt(blk_bs(blk), cr_key, pr_key, type, abort);
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
> +BlockAIOCB *blk_aio_pr_preempt(BlockBackend *blk, uint64_t cr_key,
> +                               uint64_t pr_key, BlockPrType type,
> +                               bool abort, BlockCompletionFunc *cb,
> +                               void *opaque)
> +{
> +    IO_CODE();
> +    return blk_aio_pr_out(blk, cr_key, pr_key, false, type, false, abort,
> +                          blk_aio_pr_preempt_entry, cb, opaque);
> +}
> +
>  /* To be called between exactly one pair of blk_inc/dec_in_flight() */
>  static int coroutine_fn
>  blk_co_do_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes)
> diff --git a/block/io.c b/block/io.c
> index 7217cf811b..87a363c94f 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -3220,6 +3220,169 @@ out:
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
> +                 uint64_t new_key, BlockPrType type, bool ptpl,
> +                 bool ignore_key)
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
> +    co.ret =3D drv->bdrv_co_pr_register(bs, old_key, new_key, type,
> +    ptpl, ignore_key);
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
> +int coroutine_fn bdrv_co_pr_preempt(BlockDriverState *bs, uint64_t cr_ke=
y,
> +                 uint64_t pr_key, BlockPrType type, bool abort)
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
> +    co.ret =3D drv->bdrv_co_pr_preempt(bs, cr_key, pr_key, type, abort);
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
> index a846023a09..7ca4e2328f 100644
> --- a/include/block/block-common.h
> +++ b/include/block/block-common.h
> @@ -524,6 +524,46 @@ typedef enum {
>      BDRV_FIX_ERRORS   =3D 2,
>  } BdrvCheckMode;
> =20
> +/**
> + *  According SCSI protocol(chapter 5.9 of SCSI Primary Commands - 4)
> + *  and NVMe protocol(chapter 7.2 of NVMe Base Specification 2.0),
> + *  the persistent reservation types and persistent capabilities of
> + *  the public layer block are abstracted.
> + */
> +typedef enum {
> +    BLK_PR_WRITE_EXCLUSIVE              =3D 0x1,
> +    BLK_PR_EXCLUSIVE_ACCESS             =3D 0x2,
> +    BLK_PR_WRITE_EXCLUSIVE_REGS_ONLY    =3D 0x3,
> +    BLK_PR_EXCLUSIVE_ACCESS_REGS_ONLY   =3D 0x4,
> +    BLK_PR_WRITE_EXCLUSIVE_ALL_REGS     =3D 0x5,
> +    BLK_PR_EXCLUSIVE_ACCESS_ALL_REGS    =3D 0x6,
> +} BlockPrType;
> +
> +typedef enum BLKPrCap {
> +    /* Persist Through Power Loss */
> +    BLK_PR_CAP_PTPL =3D 1 << 0,
> +    /* Write Exclusive reservation type */
> +    BLK_PR_CAP_WR_EX =3D 1 << 1,
> +    /* Exclusive Access reservation type */
> +    BLK_PR_CAP_EX_AC =3D 1 << 2,
> +    /* Write Exclusive Registrants Only reservation type */
> +    BLK_PR_CAP_WR_EX_RO =3D 1 << 3,
> +    /* Exclusive Access Registrants Only reservation type */
> +    BLK_PR_CAP_EX_AC_RO =3D 1 << 4,
> +    /* Write Exclusive All Registrants reservation type */
> +    BLK_PR_CAP_WR_EX_AR =3D 1 << 5,
> +    /* Exclusive Access All Registrants reservation type */
> +    BLK_PR_CAP_EX_AC_AR =3D 1 << 6,
> +
> +    BLK_PR_CAP_ALL =3D (BLK_PR_CAP_PTPL |
> +                     BLK_PR_CAP_WR_EX |
> +                     BLK_PR_CAP_EX_AC |
> +                     BLK_PR_CAP_WR_EX_RO |
> +                     BLK_PR_CAP_EX_AC_RO |
> +                     BLK_PR_CAP_WR_EX_AR |
> +                     BLK_PR_CAP_EX_AC_AR),
> +} BLKPrCap;
> +
>  typedef struct BlockSizes {
>      uint32_t phys;
>      uint32_t log;
> diff --git a/include/block/block-io.h b/include/block/block-io.h
> index b49e0537dd..908361862b 100644
> --- a/include/block/block-io.h
> +++ b/include/block/block-io.h
> @@ -106,6 +106,26 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb);
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
> +                    uint64_t new_key, BlockPrType type,
> +                    bool ptpl, bool ignore_key);
> +int coroutine_fn GRAPH_RDLOCK
> +bdrv_co_pr_reserve(BlockDriverState *bs, uint64_t key, BlockPrType type);
> +int coroutine_fn GRAPH_RDLOCK
> +bdrv_co_pr_release(BlockDriverState *bs, uint64_t key, BlockPrType type);
> +int coroutine_fn GRAPH_RDLOCK
> +bdrv_co_pr_clear(BlockDriverState *bs, uint64_t key);
> +int coroutine_fn GRAPH_RDLOCK
> +bdrv_co_pr_preempt(BlockDriverState *bs, uint64_t cr_key, uint64_t pr_ke=
y,
> +                   BlockPrType type, bool abort);
> +
>  /* Ensure contents are flushed to disk.  */
>  int coroutine_fn GRAPH_RDLOCK bdrv_co_flush(BlockDriverState *bs);
> =20
> diff --git a/include/block/block_int-common.h b/include/block/block_int-c=
ommon.h
> index 761276127e..6e628069e9 100644
> --- a/include/block/block_int-common.h
> +++ b/include/block/block_int-common.h
> @@ -766,6 +766,87 @@ struct BlockDriver {
>      int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_ioctl)(
>          BlockDriverState *bs, unsigned long int req, void *buf);
> =20
> +    /*
> +     * Persistent reservation series api.
> +     * Please refer to chapter 5.9 of SCSI Primary Commands - 4 or
> +     * chapter 7 of NVMe Base Specification 2.0.
> +     *
> +     * The block layer driver should implement all the following APIs
> +     * or none at all, including: bdrv_co_pr_read_keys,
> +     * bdrv_co_pr_read_reservation, bdrv_co_pr_register,
> +     * bdrv_co_pr_reserve, bdrv_co_pr_release,
> +     * bdrv_co_pr_clear and bdrv_co_pr_preempt.
> +     *
> +     * Read the registered keys and return them in the @keys.
> +     * @generation: The generation of the reservation key.
> +     * @num_keys:   The maximum number of keys that can be transmitted.
> +     * @keys:       Registered keys array.
> +     *
> +     * On success, store generation in @generation and store keys @keys
> +     * and return the number of @keys.
> +     * On failure return -errno.
> +     */
> +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_read_keys)(
> +        BlockDriverState *bs, uint32_t *generation,
> +        uint32_t num_keys, uint64_t *keys);
> +    /*
> +     * Read the reservation key and store it in the @key.
> +     * @generation: The generation of the reservation key.
> +     * @key:        The reservation key.
> +     * @type:       Type of the reservation key.
> +     *
> +     * On success, store generation in @generation, store the
> +     * reservation key in @key and return the number of @key
> +     * which used to determine whether the reservation key exists.
> +     * On failure return -errno.
> +     */
> +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_read_reservation)(
> +        BlockDriverState *bs, uint32_t *generation,
> +        uint64_t *key, BlockPrType *type);
> +    /*
> +     * Register, unregister, or replace a reservation key.
> +     * @old_key:    The current reservation key associated with the host.
> +     * @new_key:    The new reservation Key.
> +     * @type:       Type of the reservation key.
> +     * @ignore_key: Ignore or not @old_key.
> +     * @ptpl:       Whether to support Persist Through Power Loss(PTPL).
> +     */
> +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_register)(
> +        BlockDriverState *bs, uint64_t old_key,
> +        uint64_t new_key, BlockPrType type,
> +        bool ptpl, bool ignore_key);
> +    /*
> +     * Acquire a reservation on a host.
> +     * @key:  The current reservation key associated with the host.
> +     * @type: Type of the reservation key.
> +     */
> +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_reserve)(
> +        BlockDriverState *bs, uint64_t key, BlockPrType type);
> +    /*
> +     * Release a reservation on a host.
> +     * @key:  The current reservation key associated with the host.
> +     * @type: Type of the reservation key.
> +     */
> +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_release)(
> +        BlockDriverState *bs, uint64_t key, BlockPrType type);
> +    /**
> +     * Clear reservations on a host.
> +     * @key: The current reservation key associated with the host.
> +     */
> +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_clear)(
> +        BlockDriverState *bs, uint64_t key);
> +    /*
> +     * Preempt a reservation held on a host.
> +     * @cr_key: The current reservation key associated with the host.
> +     * @pr_key: The preempt reservation Key which to be
> +     *          unregistered from the namespace.
> +     * @type:   Type of the reservation key.
> +     * @abort:  Whether to abort a reservation held on a host.
> +     */
> +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_preempt)(
> +        BlockDriverState *bs, uint64_t cr_key,
> +        uint64_t pr_key, BlockPrType type, bool abort);
> +
>      /*
>       * Returns 0 for completed check, -errno for internal errors.
>       * The check results are stored in result.
> @@ -899,6 +980,9 @@ typedef struct BlockLimits {
>      uint32_t max_active_zones;
> =20
>      uint32_t write_granularity;
> +
> +   /* Persistent reservation capacities. */
> +    uint8_t pr_cap;
>  } BlockLimits;
> =20
>  typedef struct BdrvOpBlocker BdrvOpBlocker;
> diff --git a/include/sysemu/block-backend-io.h b/include/sysemu/block-bac=
kend-io.h
> index d174275a5c..b3d49a3c6f 100644
> --- a/include/sysemu/block-backend-io.h
> +++ b/include/sysemu/block-backend-io.h
> @@ -62,6 +62,30 @@ void blk_aio_cancel_async(BlockAIOCB *acb);
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
> +                                bool ptpl, bool ignore_key,
> +                                BlockCompletionFunc *cb,
> +                                void *opaque);
> +BlockAIOCB *blk_aio_pr_reserve(BlockBackend *blk,  uint64_t key,
> +                               BlockPrType type,
> +                               BlockCompletionFunc *cb,
> +                               void *opaque);
> +BlockAIOCB *blk_aio_pr_release(BlockBackend *blk, uint64_t key,
> +                               BlockPrType type, BlockCompletionFunc *cb,
> +                               void *opaque);
> +BlockAIOCB *blk_aio_pr_clear(BlockBackend *blk, uint64_t key,
> +                             BlockCompletionFunc *cb, void *opaque);
> +BlockAIOCB *blk_aio_pr_preempt(BlockBackend *blk, uint64_t cr_key,
> +                               uint64_t pr_key, BlockPrType type, bool a=
bort,
> +                               BlockCompletionFunc *cb, void *opaque);
> +
>  void blk_inc_in_flight(BlockBackend *blk);
>  void blk_dec_in_flight(BlockBackend *blk);
> =20
> --=20
> 2.20.1
>=20

--TN78XIvGZ/gvOYpZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZnN1MACgkQnKSrs4Gr
c8jqYQgAsWt3wHrNjpEfgTz9ErsF2kToJw+wgV4pkpM5vlFNLkpsSSSepVDtdUfa
Pic2pLfn3l8SsRbtoXMvYQsbmMmhoz+bRDSwBr6KmFjlDIXYeYpA8hZCae4IKfxf
GsMNPA5kPWdDWw92vuFsh/z3zp7GVXxtk5i2nFh+BXdvWYFi6gwW9Kxp1oEehDEu
SAn5eq3IWTyPC1u5JBMgAyUdGM71Q7JfKLY7IPN01+by9VvaDs6lXHw+zjbQgOFG
yRpRRLAgRvrg5nUgtTE7KUxHWM7iAYxuX3yitnhE72MQqQrqkKC25y5sx7eloqYh
GuZNiuLolcLwjivmzagsxb2FwREerg==
=WV18
-----END PGP SIGNATURE-----

--TN78XIvGZ/gvOYpZ--


