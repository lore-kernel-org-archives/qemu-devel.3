Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7A3C3271F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 19:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPS7i-0005gU-2S; Thu, 04 Jul 2024 15:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sPS7M-0005Ti-Gl
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 15:27:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sPS7I-0005yt-0I
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 15:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720121258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=loDU8/JJcRpy7c/7ZYNrN1xoYWHU1S8Gazi+09fVM3Q=;
 b=Lq/ZRu6L/GtqKqMZYf5BERZECwrQ88em551xu0c4vswlJjtReaIbFA2G3AImm7Mz5yBadp
 NtJIrS+p43G9ePhuYhCojC7M4X47VAvPKQrPhskxNB3TiHFeikOlAKj/D8OLN8ZkkxGbvM
 uv954W2v1GBb1w1P+L/V4lbfyV6GXTI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-bLjT9rwpO9-ohfdLoJVRWg-1; Thu,
 04 Jul 2024 15:27:31 -0400
X-MC-Unique: bLjT9rwpO9-ohfdLoJVRWg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC7701955F44; Thu,  4 Jul 2024 19:27:29 +0000 (UTC)
Received: from localhost (unknown [10.39.192.129])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E93F195605F; Thu,  4 Jul 2024 19:27:27 +0000 (UTC)
Date: Thu, 4 Jul 2024 20:28:55 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v6 05/10] hw/scsi: add persistent reservation in/out api
 for scsi device
Message-ID: <20240704182855.GH2529519@fedora.redhat.com>
References: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
 <20240613071327.2498953-6-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lrp0SycR2lKUIPE2"
Content-Disposition: inline
In-Reply-To: <20240613071327.2498953-6-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--lrp0SycR2lKUIPE2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 03:13:22PM +0800, Changqi Lu wrote:
> Add persistent reservation in/out operations in the
> SCSI device layer. By introducing the persistent
> reservation in/out api, this enables the SCSI device
> to perform reservation-related tasks, including querying
> keys, querying reservation status, registering reservation
> keys, initiating and releasing reservations, as well as
> clearing and preempting reservations held by other keys.
>=20
> These operations are crucial for management and control of
> shared storage resources in a persistent manner.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  hw/scsi/scsi-disk.c | 352 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 352 insertions(+)
>=20
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 4bd7af9d0c..0e964dbd87 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -32,6 +32,7 @@
>  #include "migration/vmstate.h"
>  #include "hw/scsi/emulation.h"
>  #include "scsi/constants.h"
> +#include "scsi/utils.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/blockdev.h"
>  #include "hw/block/block.h"
> @@ -42,6 +43,7 @@
>  #include "qemu/cutils.h"
>  #include "trace.h"
>  #include "qom/object.h"
> +#include "block/block_int.h"
> =20
>  #ifdef __linux
>  #include <scsi/sg.h>
> @@ -1474,6 +1476,346 @@ static void scsi_disk_emulate_read_data(SCSIReque=
st *req)
>      scsi_req_complete(&r->req, GOOD);
>  }
> =20
> +typedef struct SCSIPrReadKeys {
> +    uint32_t generation;
> +    uint32_t num_keys;
> +    uint64_t *keys;
> +    void     *req;
> +} SCSIPrReadKeys;
> +
> +typedef struct SCSIPrReadReservation {
> +    uint32_t generation;
> +    uint64_t key;
> +    BlockPrType type;
> +    void *req;
> +} SCSIPrReadReservation;
> +
> +static void scsi_pr_read_keys_complete(void *opaque, int ret)
> +{
> +    int num_keys;
> +    uint8_t *buf;
> +    SCSIPrReadKeys *blk_keys =3D (SCSIPrReadKeys *)opaque;
> +    SCSIDiskReq *r =3D (SCSIDiskReq *)blk_keys->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> +
> +    assert(blk_get_aio_context(s->qdev.conf.blk) =3D=3D
> +            qemu_get_current_aio_context());
> +
> +    assert(r->req.aiocb !=3D NULL);
> +    r->req.aiocb =3D NULL;
> +
> +    if (scsi_disk_req_check_error(r, ret, true)) {
> +        goto done;
> +    }
> +
> +    buf =3D scsi_req_get_buf(&r->req);
> +    num_keys =3D MIN(blk_keys->num_keys, ret);
> +    blk_keys->generation =3D cpu_to_be32(blk_keys->generation);
> +    memcpy(&buf[0], &blk_keys->generation, 4);
> +    for (int i =3D 0; i < num_keys; i++) {
> +        blk_keys->keys[i] =3D cpu_to_be64(blk_keys->keys[i]);
> +        memcpy(&buf[8 + i * 8], &blk_keys->keys[i], 8);
> +    }
> +    num_keys =3D cpu_to_be32(num_keys * 8);
> +    memcpy(&buf[4], &num_keys, 4);
> +
> +    scsi_req_data(&r->req, r->buflen);
> +done:
> +    scsi_req_unref(&r->req);
> +    g_free(blk_keys->keys);
> +    g_free(blk_keys);
> +}
> +
> +static int scsi_disk_emulate_pr_read_keys(SCSIRequest *req)
> +{
> +    SCSIPrReadKeys *blk_keys;
> +    SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +    int buflen =3D MIN(r->req.cmd.xfer, r->buflen);
> +    int num_keys =3D (buflen - sizeof(uint32_t) * 2) / sizeof(uint64_t);
> +
> +    blk_keys =3D g_new0(SCSIPrReadKeys, 1);
> +    blk_keys->generation =3D 0;
> +    /* num_keys is the maximum number of keys that can be transmitted */
> +    blk_keys->num_keys =3D num_keys;
> +    blk_keys->keys =3D g_malloc(sizeof(uint64_t) * num_keys);
> +    blk_keys->req =3D r;
> +
> +    /* The request is used as the AIO opaque value, so add a ref.  */
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_read_keys(s->qdev.conf.blk, &blk_keys->g=
eneration,
> +                                        blk_keys->num_keys, blk_keys->ke=
ys,
> +                                        scsi_pr_read_keys_complete, blk_=
keys);
> +    return 0;
> +}
> +
> +static void scsi_pr_read_reservation_complete(void *opaque, int ret)
> +{
> +    uint8_t *buf;
> +    uint32_t additional_len =3D 0;
> +    SCSIPrReadReservation *blk_rsv =3D (SCSIPrReadReservation *)opaque;
> +    SCSIDiskReq *r =3D (SCSIDiskReq *)blk_rsv->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> +
> +    assert(blk_get_aio_context(s->qdev.conf.blk) =3D=3D
> +            qemu_get_current_aio_context());
> +
> +    assert(r->req.aiocb !=3D NULL);
> +    r->req.aiocb =3D NULL;
> +
> +    if (scsi_disk_req_check_error(r, ret, true)) {
> +        goto done;
> +    }
> +
> +    buf =3D scsi_req_get_buf(&r->req);
> +    blk_rsv->generation =3D cpu_to_be32(blk_rsv->generation);
> +    memcpy(&buf[0], &blk_rsv->generation, 4);
> +    if (ret) {
> +        additional_len =3D cpu_to_be32(16);
> +        blk_rsv->key =3D cpu_to_be64(blk_rsv->key);
> +        memcpy(&buf[8], &blk_rsv->key, 8);
> +        buf[21] =3D block_pr_type_to_scsi(blk_rsv->type) & 0xf;
> +    } else {
> +        additional_len =3D cpu_to_be32(0);
> +    }
> +
> +    memcpy(&buf[4], &additional_len, 4);
> +    scsi_req_data(&r->req, r->buflen);
> +
> +done:
> +    scsi_req_unref(&r->req);
> +    g_free(blk_rsv);
> +}
> +
> +static int scsi_disk_emulate_pr_read_reservation(SCSIRequest *req)
> +{
> +    SCSIPrReadReservation *blk_rsv;
> +    SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +
> +    blk_rsv =3D g_malloc(sizeof(*blk_rsv));
> +    blk_rsv->generation =3D 0;
> +    blk_rsv->key =3D 0;
> +    blk_rsv->type =3D 0;
> +    blk_rsv->req =3D r;
> +
> +    /* The request is used as the AIO opaque value, so add a ref.  */
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_read_reservation(s->qdev.conf.blk,
> +                   &blk_rsv->generation, &blk_rsv->key, &blk_rsv->type,
> +                   scsi_pr_read_reservation_complete, blk_rsv);
> +    return 0;
> +}
> +
> +static int scsi_disk_emulate_pr_report_capabilities(SCSIRequest *req)
> +{
> +    SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +    BlockDriverState *bs =3D blk_bs(s->qdev.conf.blk);
> +    uint8_t blk_pr_cap =3D bs->file->bs->bl.pr_cap;

I'm not sure that file->bs is always valid here. Block layer code
typically checks for !bs and !bs->drv.

Also, ->file could be NULL if the SCSI disk points directly to
--blockdev file without a --blockdev raw on top. I think the block layer
should propagate pr_cap from the leaves of the block graph to the root
node via bdrv_merge_limits() so that traversing the graph (->file) is
not necessary. Instead this line should just be bs->bl.pr_cap.

> +    uint8_t *buf =3D scsi_req_get_buf(req);
> +    uint16_t pr_cap;
> +    /*
> +     * according to response of report_capabilities
> +     * command of chapter 6.13 of spc4
> +     */
> +    int len =3D sizeof(uint16_t) * 2 + sizeof(uint8_t) * 4;
> +
> +    if (len > r->buflen) {
> +        return -EINVAL;
> +    }
> +
> +    len =3D cpu_to_be16(len);
> +    memcpy(&buf[0], &len, 2);
> +    /* enable PTPL_C */
> +    buf[2] =3D 1;
> +    buf[3] =3D (blk_pr_cap & BLK_PR_CAP_PTPL) ? 1 : 0;
> +    /* enable TMV */
> +    buf[3] |=3D 1 << 7;
> +
> +    /* enable persistent reservation type */
> +    pr_cap =3D block_pr_cap_to_scsi(blk_pr_cap);
> +    buf[4] =3D pr_cap >> 8 & 0xff;
> +    buf[5] =3D pr_cap & 0xff;
> +
> +    scsi_req_data(&r->req, len);
> +    return 0;
> +}
> +
> +static void scsi_aio_pr_complete(void *opaque, int ret)
> +{
> +    SCSIDiskReq *r =3D (SCSIDiskReq *)opaque;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> +
> +    /* The request must only run in the BlockBackend's AioContext */
> +    assert(blk_get_aio_context(s->qdev.conf.blk) =3D=3D
> +           qemu_get_current_aio_context());
> +
> +    assert(r->req.aiocb !=3D NULL);
> +    r->req.aiocb =3D NULL;
> +
> +    if (scsi_disk_req_check_error(r, ret, true)) {
> +        goto done;
> +    }
> +
> +    scsi_req_complete(&r->req, GOOD);
> +
> +done:
> +    scsi_req_unref(&r->req);
> +}
> +
> +static int scsi_disk_emulate_pr_register(SCSIDiskReq *r, uint64_t r_key,
> +                                         uint64_t sa_key, SCSIPrType typ=
e,
> +                                         uint8_t aptpl, bool ignore_key)
> +{
> +    SCSIRequest *req =3D &r->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +
> +    /* The request is used as the AIO opaque value, so add a ref.  */
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_register(s->qdev.conf.blk, r_key, sa_key,
> +                                       scsi_pr_type_to_block(type),
> +                                       aptpl ? true : false,
> +                                       ignore_key, scsi_aio_pr_complete,=
 r);
> +
> +    return 0;
> +}
> +
> +static int scsi_disk_emulate_pr_reserve(SCSIDiskReq *r, uint64_t r_key,
> +                                        SCSIPrType type)
> +{
> +    SCSIRequest *req =3D &r->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +
> +    /* The request is used as the AIO opaque value, so add a ref.  */
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_reserve(s->qdev.conf.blk, r_key,
> +                                      scsi_pr_type_to_block(type),
> +                                      scsi_aio_pr_complete, r);
> +
> +    return 0;
> +}
> +
> +static int scsi_disk_emulate_pr_release(SCSIDiskReq *r, uint64_t r_key,
> +                                        SCSIPrType type)
> +{
> +    SCSIRequest *req =3D &r->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +
> +    /* The request is used as the AIO opaque value, so add a ref.  */
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_release(s->qdev.conf.blk, r_key,
> +                                      scsi_pr_type_to_block(type),
> +                                      scsi_aio_pr_complete, r);
> +
> +    return 0;
> +}
> +
> +static int scsi_disk_emulate_pr_clear(SCSIDiskReq *r, uint64_t r_key)
> +{
> +    SCSIRequest *req =3D &r->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +
> +    /* The request is used as the AIO opaque value, so add a ref.  */
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_clear(s->qdev.conf.blk, r_key,
> +                                    scsi_aio_pr_complete, r);
> +
> +    return 0;
> +}
> +
> +static int scsi_disk_emulate_pr_preempt(SCSIDiskReq *r, uint64_t r_key,
> +                                        uint64_t sa_key, SCSIPrType type,
> +                                        bool abort)
> +{
> +    SCSIRequest *req =3D &r->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +
> +    /* The request is used as the AIO opaque value, so add a ref.  */
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_preempt(s->qdev.conf.blk, r_key, sa_key,
> +                                      scsi_pr_type_to_block(type), abort,
> +                                      scsi_aio_pr_complete, r);
> +
> +    return 0;
> +}
> +
> +static int scsi_disk_emulate_pr_in(SCSIRequest *req)
> +{
> +    int rc;
> +    SCSIPrInAction action =3D req->cmd.buf[1] & 0x1f;
> +
> +    switch (action) {
> +    case SCSI_PR_IN_READ_KEYS:
> +        rc =3D scsi_disk_emulate_pr_read_keys(req);
> +        break;
> +    case SCSI_PR_IN_READ_RESERVATION:
> +        rc =3D scsi_disk_emulate_pr_read_reservation(req);
> +        break;
> +    case SCSI_PR_IN_REPORT_CAPABILITIES:
> +        rc =3D scsi_disk_emulate_pr_report_capabilities(req);
> +        break;
> +    default:
> +        return -ENOTSUP;
> +    }
> +
> +    return rc;
> +}
> +
> +static int scsi_disk_emulate_pr_out(SCSIDiskReq *r, uint8_t *inbuf)
> +{
> +    int rc;
> +    uint8_t aptpl;
> +    uint64_t r_key, sa_key;
> +    SCSIPrOutAction action;
> +    SCSIPrScope scope;
> +    SCSIPrType type;
> +    SCSIRequest *req =3D &r->req;
> +
> +    memcpy(&r_key, &inbuf[0], 8);
> +    r_key =3D be64_to_cpu(r_key);
> +    memcpy(&sa_key, &inbuf[8], 8);
> +    sa_key =3D be64_to_cpu(sa_key);
> +    memcpy(&aptpl, &inbuf[20], 1);
> +    aptpl =3D  aptpl & 0x01;
> +    action =3D req->cmd.buf[1] & 0x1f;
> +    scope =3D (req->cmd.buf[2] >> 4) & 0x0f;
> +    type =3D req->cmd.buf[2] & 0x0f;
> +
> +    if (scope !=3D SCSI_PR_LU_SCOPE) {
> +        return -ENOTSUP;
> +    }
> +
> +    switch (action) {
> +    case SCSI_PR_OUT_REGISTER:
> +        rc =3D scsi_disk_emulate_pr_register(r, r_key, sa_key, type,
> +                                           aptpl, false);
> +        break;
> +    case SCSI_PR_OUT_REG_AND_IGNORE_KEY:
> +        rc =3D scsi_disk_emulate_pr_register(r, r_key, sa_key, type, apt=
pl, true);
> +        break;
> +    case SCSI_PR_OUT_RESERVE:
> +        rc =3D scsi_disk_emulate_pr_reserve(r, r_key, type);
> +        break;
> +    case SCSI_PR_OUT_RELEASE:
> +        rc =3D scsi_disk_emulate_pr_release(r, r_key, type);
> +        break;
> +    case SCSI_PR_OUT_CLEAR:
> +        rc =3D scsi_disk_emulate_pr_clear(r, r_key);
> +        break;
> +    case SCSI_PR_OUT_PREEMPT:
> +        rc =3D scsi_disk_emulate_pr_preempt(r, r_key, sa_key, type, fals=
e);
> +        break;
> +    case SCSI_PR_OUT_PREEMPT_AND_ABORT:
> +        rc =3D scsi_disk_emulate_pr_preempt(r, r_key, sa_key, type, true=
);
> +        break;
> +    default:
> +        return -ENOTSUP;
> +    }
> +
> +    return rc;
> +}
> +
>  static int scsi_disk_check_mode_select(SCSIDiskState *s, int page,
>                                         uint8_t *inbuf, int inlen)
>  {
> @@ -1957,6 +2299,9 @@ static void scsi_disk_emulate_write_data(SCSIReques=
t *req)
>          scsi_req_complete(&r->req, GOOD);
>          break;
> =20
> +    case PERSISTENT_RESERVE_OUT:
> +        scsi_disk_emulate_pr_out(r, r->iov.iov_base);
> +        break;
>      default:
>          abort();
>      }
> @@ -2213,6 +2558,11 @@ static int32_t scsi_disk_emulate_command(SCSIReque=
st *req, uint8_t *buf)
>      case FORMAT_UNIT:
>          trace_scsi_disk_emulate_command_FORMAT_UNIT(r->req.cmd.xfer);
>          break;
> +    case PERSISTENT_RESERVE_OUT:
> +        break;
> +    case PERSISTENT_RESERVE_IN:
> +        scsi_disk_emulate_pr_in(req);
> +        return 0;
>      default:
>          trace_scsi_disk_emulate_command_UNKNOWN(buf[0],
>                                                  scsi_command_name(buf[0]=
));
> @@ -2632,6 +2982,8 @@ static const SCSIReqOps *const scsi_disk_reqops_dis=
patch[256] =3D {
>      [VERIFY_12]                       =3D &scsi_disk_emulate_reqops,
>      [VERIFY_16]                       =3D &scsi_disk_emulate_reqops,
>      [FORMAT_UNIT]                     =3D &scsi_disk_emulate_reqops,
> +    [PERSISTENT_RESERVE_IN]           =3D &scsi_disk_emulate_reqops,
> +    [PERSISTENT_RESERVE_OUT]          =3D &scsi_disk_emulate_reqops,
> =20
>      [READ_6]                          =3D &scsi_disk_dma_reqops,
>      [READ_10]                         =3D &scsi_disk_dma_reqops,
> --=20
> 2.20.1
>=20

--lrp0SycR2lKUIPE2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaG6ecACgkQnKSrs4Gr
c8i1Vgf+KPdtOFECBGNd4mNMtkKvSXrlffzFN96Fajksaw5yelcID3tg3FaPE+0y
qKLhJkpRly+V8kVOXZaTt7AL/DB7oGUtJHsT2lFTifZKdKBWykwKNYUu6Jywr0nQ
Vo3vkCUStcUziyR3+UZRXQ1VWqScjBOOqEmwmvOBVLRZBXid0DyD86EkxwUemJCx
HdTMPeGQrtCSQHhbI9QfEDAs8uROSbiiHXVA7EHq1sgnENjZwHsNpwNFWTsoZ6V0
2AiBgD7pp2TLdPcFEI+6rEUPwtKDvW5iBig+qkIoXQlkllV8t5sgE0vOTGLrvgUs
huLXxEerEfmk/GCiVeJ20sQIar7EVg==
=/Lpf
-----END PGP SIGNATURE-----

--lrp0SycR2lKUIPE2--


