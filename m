Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D0CC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 18:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s58m3-0004lj-Ly; Thu, 09 May 2024 14:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s58lk-0004fI-L3
 for qemu-devel@nongnu.org; Thu, 09 May 2024 14:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s58ld-0003qq-Iz
 for qemu-devel@nongnu.org; Thu, 09 May 2024 14:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715280319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AY6/3TNa7m7u3YwBejXjqzR16nYFvCaalnQm1SSeWII=;
 b=ZzIrUk9YuNHAdlCn10wQdIA6iQ+7xU2FYHluDHHcykboGcVlOTWzYhA4haqT5Jx7u3e86h
 xNPNOQ2om7J+UDIhHWhsLo8u6KD8ReCChwz6JBuqZ/6KdcX/FDRwbhLBHhBqV0UWMqkEQK
 Tg+bh6WQzIGiRluTL6QpHy9A74Ks90U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-6D3FTQlJMretOzQaUFtJ-w-1; Thu,
 09 May 2024 14:45:16 -0400
X-MC-Unique: 6D3FTQlJMretOzQaUFtJ-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A49D29AA38E;
 Thu,  9 May 2024 18:45:15 +0000 (UTC)
Received: from localhost (unknown [10.39.192.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 453A120C5C8A;
 Thu,  9 May 2024 18:45:13 +0000 (UTC)
Date: Thu, 9 May 2024 14:45:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 Changqi Lu <luchangqi.123@bytedance.com>, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it,
 philmd@linaro.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 5/9] hw/scsi: add persistent reservation in/out api for
 scsi device
Message-ID: <20240509184512.GG515246@fedora.redhat.com>
References: <20240508093629.441057-1-luchangqi.123@bytedance.com>
 <20240508093629.441057-6-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XcP0khRg8//sB5yw"
Content-Disposition: inline
In-Reply-To: <20240508093629.441057-6-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


--XcP0khRg8//sB5yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 05:36:25PM +0800, Changqi Lu wrote:
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
>  hw/scsi/scsi-disk.c | 302 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 302 insertions(+)

Paolo: Please review for buffer overflows. I find the buffer size
assumption in the SCSI layer mysterious (e.g. scsi_req_get_buf() returns
a void* and it's not obvious how large the buffer is), so I didn't check
for buffer overflows.

>=20
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 4bd7af9d0c..bdd66c4026 100644
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
> @@ -1474,6 +1475,296 @@ static void scsi_disk_emulate_read_data(SCSIReque=
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
> +    uint32_t num_keys =3D 0;
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
> +        num_keys =3D cpu_to_be32(16);

The SPC-6 calls this field Additional Length, which is clearer than
num_keys (there is only 1 key here!). Could you rename it to
additional_len to avoid confusion?

> +        blk_rsv->key =3D cpu_to_be64(blk_rsv->key);
> +        memcpy(&buf[8], &blk_rsv->key, 8);
> +        buf[21] =3D block_pr_type_to_scsi(blk_rsv->type) & 0xf;
> +    } else {
> +        num_keys =3D cpu_to_be32(0);
> +    }
> +
> +    memcpy(&buf[4], &num_keys, 4);
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
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_read_reservation(s->qdev.conf.blk,
> +                   &blk_rsv->generation, &blk_rsv->key, &blk_rsv->type,
> +                   scsi_pr_read_reservation_complete, blk_rsv);
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
> +static int scsi_disk_emulate_pr_register(SCSIDiskReq *r, uint64_t old_ke=
y,
> +                                         uint64_t new_key, SCSIPrType ty=
pe,
> +                                         bool ignore_key)
> +{
> +    SCSIRequest *req =3D &r->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_register(s->qdev.conf.blk, old_key, new_=
key,
> +                                       scsi_pr_type_to_block(type),
> +                                       ignore_key, scsi_aio_pr_complete,=
 r);
> +
> +    return 0;
> +}
> +
> +static int scsi_disk_emulate_pr_reserve(SCSIDiskReq *r, uint64_t key,
> +                                        SCSIPrType type)
> +{
> +    SCSIRequest *req =3D &r->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_reserve(s->qdev.conf.blk, key,
> +                                      scsi_pr_type_to_block(type),
> +                                      scsi_aio_pr_complete, r);
> +
> +    return 0;
> +}
> +
> +static int scsi_disk_emulate_pr_release(SCSIDiskReq *r, uint64_t key,
> +                                        SCSIPrType type)
> +{
> +    SCSIRequest *req =3D &r->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_release(s->qdev.conf.blk, key,
> +                                      scsi_pr_type_to_block(type),
> +                                      scsi_aio_pr_complete, r);
> +
> +    return 0;
> +}
> +
> +static int scsi_disk_emulate_pr_clear(SCSIDiskReq *r, uint64_t key)
> +{
> +    SCSIRequest *req =3D &r->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_clear(s->qdev.conf.blk, key,
> +                                    scsi_aio_pr_complete, r);
> +
> +    return 0;
> +}
> +
> +static int scsi_disk_emulate_pr_preempt(SCSIDiskReq *r, uint64_t new_key,
> +                                        uint64_t old_key, SCSIPrType typ=
e,
> +                                        bool abort)
> +{
> +    SCSIRequest *req =3D &r->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_preempt(s->qdev.conf.blk, new_key, old_k=
ey,
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
> +    uint64_t old_key, new_key;
> +    SCSIPrOutAction action;
> +    SCSIPrScope scope;
> +    SCSIPrType type;
> +    SCSIRequest *req =3D &r->req;
> +
> +    memcpy(&old_key, &inbuf[0], 8);
> +    old_key =3D be64_to_cpu(old_key);
> +    memcpy(&new_key, &inbuf[8], 8);
> +    new_key =3D be64_to_cpu(new_key);
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
> +        rc =3D scsi_disk_emulate_pr_register(r, old_key, new_key, type, =
false);
> +        break;
> +    case SCSI_PR_OUT_REG_AND_IGNORE_KEY:
> +        rc =3D scsi_disk_emulate_pr_register(r, old_key, new_key, type, =
true);
> +        break;
> +    case SCSI_PR_OUT_RESERVE:
> +        rc =3D scsi_disk_emulate_pr_reserve(r, old_key, type);
> +        break;
> +    case SCSI_PR_OUT_RELEASE:
> +        rc =3D scsi_disk_emulate_pr_release(r, old_key, type);
> +        break;
> +    case SCSI_PR_OUT_CLEAR:
> +        rc =3D scsi_disk_emulate_pr_clear(r, old_key);
> +        break;
> +    case SCSI_PR_OUT_PREEMPT:
> +        rc =3D scsi_disk_emulate_pr_preempt(r, old_key, new_key, type, f=
alse);
> +        break;
> +    case SCSI_PR_OUT_PREEMPT_AND_ABORT:
> +        rc =3D scsi_disk_emulate_pr_preempt(r, old_key, new_key, type, t=
rue);
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
> @@ -1957,6 +2248,9 @@ static void scsi_disk_emulate_write_data(SCSIReques=
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
> @@ -2213,6 +2507,12 @@ static int32_t scsi_disk_emulate_command(SCSIReque=
st *req, uint8_t *buf)
>      case FORMAT_UNIT:
>          trace_scsi_disk_emulate_command_FORMAT_UNIT(r->req.cmd.xfer);
>          break;
> +    case PERSISTENT_RESERVE_OUT:
> +        break;
> +    case PERSISTENT_RESERVE_IN:
> +        scsi_req_ref(&r->req);

Please add a comment indicating which scsi_req_unref() this ref is
paired with. That makes it easier to understand request reference
counting.

> +        scsi_disk_emulate_pr_in(req);
> +        return 0;
>      default:
>          trace_scsi_disk_emulate_command_UNKNOWN(buf[0],
>                                                  scsi_command_name(buf[0]=
));
> @@ -2632,6 +2932,8 @@ static const SCSIReqOps *const scsi_disk_reqops_dis=
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

--XcP0khRg8//sB5yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmY9GbgACgkQnKSrs4Gr
c8gPRgf8CSAtIAUMtU46ZRgK968D3v8Lg4jCkmipheXnzIlNtM/j+IHYkBo3H4RD
jkg0ZPVfKDvRuSChRcVaV4Bmt6tq+3tOX30N3+2cdPVrLKy/WkGxuFOCRodD6NnA
qCs2rVD9ruvHgCQsoir6SUaq9l/Kdt0lTYLZsQOJ8z29z+zfwai1nW7aNNCZKv/e
TeXybiVZJsuK1GcUf5tkMFFyaES6ki96U5zrJ6l1pXu14e7pMvBHl6j72u4Myknt
Z6nDkjrN8BfyZfPeCfQIUC6K+ryiE/W90Szgiixa4L9+LKVvnfigs4V1IHQumKkL
By2XDaVN/MfqzPGNiodXd7duHQQGJA==
=/33f
-----END PGP SIGNATURE-----

--XcP0khRg8//sB5yw--


