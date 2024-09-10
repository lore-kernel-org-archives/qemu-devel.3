Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D55EEDE9BA
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 20:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so7PL-0002qu-PO; Tue, 10 Sep 2024 16:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1so7PI-0002pd-5J
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 16:24:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1so7PF-0004ql-6A
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 16:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725999847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QouquCTMI5hjuDyEugG3+uJOuiJnK8QDr7vVuOAjxv0=;
 b=J8Y2++xA9uiO4856Ow6LjXfmQ56Rr+jPqmvzaaPVkgZQLHJNOiTttxRYvuJqnw0SYXenXG
 /6MPOvyRbDULdQUIxe9hepe5gHgeSf9PBhkP7ysge6RGL+GgLypvHm27ostYrDcwPFSEDU
 oYhTlCaPXrXkX167TdNnqB4aUQKjvCk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-ar6232YjPbGb19T7Afk29Q-1; Tue,
 10 Sep 2024 16:24:02 -0400
X-MC-Unique: ar6232YjPbGb19T7Afk29Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C14021933E9F; Tue, 10 Sep 2024 20:23:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.193])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E26A2196BFD0; Tue, 10 Sep 2024 20:23:44 +0000 (UTC)
Date: Tue, 10 Sep 2024 16:23:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com
Subject: Re: [PATCH v11 09/10] hw/nvme: add reservation protocal command
Message-ID: <20240910202338.GB42677@fedora.redhat.com>
References: <20240909113453.64527-1-luchangqi.123@bytedance.com>
 <20240909113453.64527-10-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="T2CBQSG9KrDUsCNc"
Content-Disposition: inline
In-Reply-To: <20240909113453.64527-10-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--T2CBQSG9KrDUsCNc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2024 at 07:34:52PM +0800, Changqi Lu wrote:
> Add reservation acquire, reservation register,
> reservation release and reservation report commands
> in the nvme device layer.
>=20
> By introducing these commands, this enables the nvme
> device to perform reservation-related tasks, including
> querying keys, querying reservation status, registering
> reservation keys, initiating and releasing reservations,
> as well as clearing and preempting reservations held by
> other keys.
>=20
> These commands are crucial for management and control of
> shared storage resources in a persistent manner.
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> Acked-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ctrl.c       | 346 +++++++++++++++++++++++++++++++++++++++++++
>  hw/nvme/ns.c         |   6 +
>  hw/nvme/nvme.h       |   9 ++
>  include/block/nvme.h |  44 ++++++
>  4 files changed, 405 insertions(+)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index ad212de723..ba98b86f9c 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -294,6 +294,10 @@ static const uint32_t nvme_cse_iocs_nvm[256] =3D {
>      [NVME_CMD_COMPARE]              =3D NVME_CMD_EFF_CSUPP,
>      [NVME_CMD_IO_MGMT_RECV]         =3D NVME_CMD_EFF_CSUPP,
>      [NVME_CMD_IO_MGMT_SEND]         =3D NVME_CMD_EFF_CSUPP | NVME_CMD_EF=
F_LBCC,
> +    [NVME_CMD_RESV_REGISTER]        =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_REPORT]          =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_ACQUIRE]         =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_RELEASE]         =3D NVME_CMD_EFF_CSUPP,
>  };
> =20
>  static const uint32_t nvme_cse_iocs_zoned[256] =3D {
> @@ -308,6 +312,10 @@ static const uint32_t nvme_cse_iocs_zoned[256] =3D {
>      [NVME_CMD_ZONE_APPEND]          =3D NVME_CMD_EFF_CSUPP | NVME_CMD_EF=
F_LBCC,
>      [NVME_CMD_ZONE_MGMT_SEND]       =3D NVME_CMD_EFF_CSUPP | NVME_CMD_EF=
F_LBCC,
>      [NVME_CMD_ZONE_MGMT_RECV]       =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_REGISTER]        =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_REPORT]          =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_ACQUIRE]         =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_RELEASE]         =3D NVME_CMD_EFF_CSUPP,
>  };
> =20
>  static void nvme_process_sq(void *opaque);
> @@ -1747,6 +1755,13 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
>      case NVME_CMD_READ:
>          status =3D NVME_UNRECOVERED_READ;
>          break;
> +    case NVME_CMD_RESV_REPORT:
> +        if (ret =3D=3D -ENOTSUP) {
> +            status =3D NVME_INVALID_OPCODE;
> +        } else {
> +            status =3D NVME_UNRECOVERED_READ;
> +        }
> +        break;
>      case NVME_CMD_FLUSH:
>      case NVME_CMD_WRITE:
>      case NVME_CMD_WRITE_ZEROES:
> @@ -1754,6 +1769,15 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
>      case NVME_CMD_COPY:
>          status =3D NVME_WRITE_FAULT;
>          break;
> +    case NVME_CMD_RESV_REGISTER:
> +    case NVME_CMD_RESV_ACQUIRE:
> +    case NVME_CMD_RESV_RELEASE:
> +        if (ret =3D=3D -ENOTSUP) {
> +            status =3D NVME_INVALID_OPCODE;
> +        } else {
> +            status =3D NVME_WRITE_FAULT;
> +        }
> +        break;
>      default:
>          status =3D NVME_INTERNAL_DEV_ERROR;
>          break;
> @@ -2692,6 +2716,320 @@ static uint16_t nvme_verify(NvmeCtrl *n, NvmeRequ=
est *req)
>      return NVME_NO_COMPLETE;
>  }
> =20
> +typedef struct NvmeKeyInfo {
> +    uint64_t cr_key;
> +    uint64_t nr_key;
> +} NvmeKeyInfo;
> +
> +static uint16_t nvme_resv_register(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    int ret;
> +    NvmeKeyInfo key_info;
> +    NvmeNamespace *ns =3D req->ns;
> +    uint32_t cdw10 =3D le32_to_cpu(req->cmd.cdw10);
> +    bool ignore_key =3D cdw10 >> 3 & 0x1;
> +    uint8_t action =3D cdw10 & 0x7;
> +    uint8_t ptpl =3D cdw10 >> 30 & 0x3;
> +    bool aptpl;
> +
> +    if (!nvme_support_pr(ns)) {
> +        return NVME_INVALID_OPCODE;
> +    }
> +
> +    switch (ptpl) {
> +    case NVME_RESV_PTPL_NO_CHANGE:
> +        aptpl =3D (ns->id_ns.rescap & NVME_PR_CAP_PTPL) ? true : false;
> +        break;
> +    case NVME_RESV_PTPL_DISABLE:
> +        aptpl =3D false;
> +        break;
> +    case NVME_RESV_PTPL_ENABLE:
> +        aptpl =3D true;
> +        break;
> +    default:
> +        return NVME_INVALID_FIELD;
> +    }
> +
> +    ret =3D nvme_h2c(n, (uint8_t *)&key_info, sizeof(NvmeKeyInfo), req);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    switch (action) {
> +    case NVME_RESV_REGISTER_ACTION_REGISTER:
> +        req->aiocb =3D blk_aio_pr_register(ns->blkconf.blk, 0,
> +                                         key_info.nr_key, 0, aptpl,

Is le64_to_cpu() missing on key_info fields?

> +                                         ignore_key, nvme_misc_cb,
> +                                         req);
> +        break;
> +    case NVME_RESV_REGISTER_ACTION_UNREGISTER:
> +        req->aiocb =3D blk_aio_pr_register(ns->blkconf.blk, key_info.cr_=
key, 0,
> +                                         0, aptpl, ignore_key,
> +                                         nvme_misc_cb, req);
> +        break;
> +    case NVME_RESV_REGISTER_ACTION_REPLACE:
> +        req->aiocb =3D blk_aio_pr_register(ns->blkconf.blk, key_info.cr_=
key,
> +                                         key_info.nr_key, 0, aptpl, igno=
re_key,
> +                                         nvme_misc_cb, req);
> +        break;
> +    default:
> +        return NVME_INVALID_FIELD;
> +    }
> +
> +    return NVME_NO_COMPLETE;
> +}
> +
> +static uint16_t nvme_resv_release(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    int ret;
> +    uint64_t cr_key;
> +    NvmeNamespace *ns =3D req->ns;
> +    uint32_t cdw10 =3D le32_to_cpu(req->cmd.cdw10);
> +    uint8_t action =3D cdw10 & 0x7;
> +    NvmeResvType type =3D cdw10 >> 8 & 0xff;
> +
> +    if (!nvme_support_pr(ns)) {
> +        return NVME_INVALID_OPCODE;
> +    }
> +
> +    ret =3D nvme_h2c(n, (uint8_t *)&cr_key, sizeof(cr_key), req);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    switch (action) {
> +    case NVME_RESV_RELEASE_ACTION_RELEASE:
> +        req->aiocb =3D blk_aio_pr_release(ns->blkconf.blk, cr_key,

le64_to_cpu() missing on cr_key?

> +                                        nvme_pr_type_to_block(type),
> +                                        nvme_misc_cb, req);
> +        break;
> +    case NVME_RESV_RELEASE_ACTION_CLEAR:
> +        req->aiocb =3D blk_aio_pr_clear(ns->blkconf.blk, cr_key,
> +                                      nvme_misc_cb, req);
> +        break;
> +    default:
> +        return NVME_INVALID_FIELD;
> +    }
> +
> +    return NVME_NO_COMPLETE;
> +}
> +
> +static uint16_t nvme_resv_acquire(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    int ret;
> +    NvmeKeyInfo key_info;
> +    NvmeNamespace *ns =3D req->ns;
> +    uint32_t cdw10 =3D le32_to_cpu(req->cmd.cdw10);
> +    uint8_t action =3D cdw10 & 0x7;
> +    NvmeResvType type =3D cdw10 >> 8 & 0xff;
> +
> +    if (!nvme_support_pr(ns)) {
> +        return NVME_INVALID_OPCODE;
> +    }
> +
> +    ret =3D nvme_h2c(n, (uint8_t *)&key_info, sizeof(NvmeKeyInfo), req);
> +    if (ret) {
> +        return ret;
> +    }

le64_to_cpu() missing on key_info fields?

> +
> +    switch (action) {
> +    case NVME_RESV_ACQUIRE_ACTION_ACQUIRE:
> +        req->aiocb =3D blk_aio_pr_reserve(ns->blkconf.blk, key_info.cr_k=
ey,
> +                                        nvme_pr_type_to_block(type),
> +                                        nvme_misc_cb, req);
> +        break;
> +    case NVME_RESV_ACQUIRE_ACTION_PREEMPT:
> +        req->aiocb =3D blk_aio_pr_preempt(ns->blkconf.blk,
> +                     key_info.cr_key, key_info.nr_key,
> +                     nvme_pr_type_to_block(type),
> +                     false, nvme_misc_cb, req);
> +        break;
> +    case NVME_RESV_ACQUIRE_ACTION_PREEMPT_AND_ABORT:
> +        req->aiocb =3D blk_aio_pr_preempt(ns->blkconf.blk, key_info.cr_k=
ey,
> +                                        key_info.nr_key, type, true,
> +                                        nvme_misc_cb, req);
> +        break;
> +    default:
> +        return NVME_INVALID_FIELD;
> +    }
> +
> +    return NVME_NO_COMPLETE;
> +}
> +
> +typedef struct NvmeResvKeys {
> +    uint32_t generation;
> +    uint32_t num_keys;
> +    uint64_t *keys;
> +    NvmeRequest *req;
> +} NvmeResvKeys;
> +
> +typedef struct NvmeReadReservation {
> +    uint32_t generation;
> +    uint64_t key;
> +    BlockPrType type;
> +    NvmeRequest *req;
> +    NvmeResvKeys *keys_info;
> +} NvmeReadReservation;
> +
> +static int nvme_read_reservation_cb(NvmeReadReservation *reservation)
> +{
> +    int rc;
> +    NvmeReservationStatus *nvme_status;
> +    NvmeRequest *req =3D reservation->req;
> +    NvmeCtrl *n =3D req->sq->ctrl;
> +    NvmeResvKeys *keys_info =3D reservation->keys_info;
> +    int len =3D sizeof(NvmeReservationStatusHeader) +
> +              sizeof(NvmeRegisteredCtrl) * keys_info->num_keys;
> +
> +    nvme_status =3D g_malloc(len);
> +    nvme_status->header.gen =3D reservation->generation;
> +    nvme_status->header.rtype =3D block_pr_type_to_nvme(reservation->typ=
e);
> +    nvme_status->header.regctl =3D keys_info->num_keys;
> +    for (int i =3D 0; i < keys_info->num_keys; i++) {
> +        nvme_status->regctl_ds[i].cntlid =3D nvme_ctrl(req)->cntlid;
> +        nvme_status->regctl_ds[i].rkey =3D keys_info->keys[i];
> +        nvme_status->regctl_ds[i].rcsts =3D keys_info->keys[i] =3D=3D
> +                                          reservation->key ? 1 : 0;
> +        /* hostid is not supported currently */
> +        memset(&nvme_status->regctl_ds[i].hostid, 0, 8);
> +    }
> +
> +    rc =3D nvme_c2h(n, (uint8_t *)nvme_status, len, req);
> +    g_free(nvme_status);
> +    return rc;
> +}
> +
> +static int nvme_read_reservation_ext_cb(NvmeReadReservation *reservation)
> +{
> +    int rc;
> +    NvmeReservationStatusExt *nvme_status_ext;
> +    NvmeRequest *req =3D reservation->req;
> +    NvmeCtrl *n =3D req->sq->ctrl;
> +    NvmeResvKeys *keys_info =3D reservation->keys_info;
> +    int len =3D sizeof(NvmeReservationStatusHeader) +
> +              sizeof(uint8_t) * 40 +
> +              sizeof(NvmeRegisteredCtrlExt) * keys_info->num_keys;
> +
> +    nvme_status_ext =3D g_malloc(len);
> +    nvme_status_ext->header.gen =3D cpu_to_be32(reservation->generation);
> +    nvme_status_ext->header.rtype =3D block_pr_type_to_nvme(reservation-=
>type);
> +    nvme_status_ext->header.regctl =3D cpu_to_be16(keys_info->num_keys);
> +
> +    for (int i =3D 0; i < keys_info->num_keys; i++) {
> +        uint16_t ctnlid =3D nvme_ctrl(req)->cntlid;
> +        nvme_status_ext->regctl_eds[i].cntlid =3D cpu_to_be16(ctnlid);
> +        nvme_status_ext->regctl_eds[i].rkey =3D cpu_to_be64(keys_info->k=
eys[i]);
> +        nvme_status_ext->regctl_eds[i].rcsts =3D keys_info->keys[i] =3D=
=3D
> +                                               reservation->key ? 1 : 0;
> +        /* hostid is not supported currently */
> +        memset(&nvme_status_ext->regctl_eds[i].hostid, 0, 16);
> +    }
> +
> +    rc =3D nvme_c2h(n, (uint8_t *)nvme_status_ext, len, req);
> +    g_free(nvme_status_ext);
> +    return rc;
> +}
> +
> +static void nvme_resv_read_reservation_cb(void *opaque, int ret)
> +{
> +    NvmeReadReservation *reservation =3D opaque;
> +    NvmeRequest *req =3D reservation->req;
> +    bool eds =3D req->cmd.cdw11 & 0x1;

Missing le32_to_cpu()?

> +    NvmeResvKeys *keys_info =3D reservation->keys_info;
> +
> +    if (ret < 0) {
> +        goto out;
> +    }
> +
> +    if (eds) {
> +        ret =3D nvme_read_reservation_ext_cb(reservation);
> +    } else {
> +        ret =3D nvme_read_reservation_cb(reservation);
> +    }
> +
> +out:
> +    g_free(keys_info->keys);
> +    g_free(keys_info);
> +    g_free(reservation);
> +    nvme_misc_cb(req, ret);
> +}
> +
> +static void nvme_resv_read_keys_cb(void *opaque, int ret)
> +{
> +    NvmeResvKeys *keys_info =3D opaque;
> +    NvmeRequest *req =3D keys_info->req;
> +    NvmeNamespace *ns =3D req->ns;
> +    NvmeReadReservation *reservation;
> +
> +    if (ret < 0) {
> +        goto out;
> +    }
> +
> +    keys_info->num_keys =3D MIN(ret, keys_info->num_keys);
> +    reservation =3D g_new0(NvmeReadReservation, 1);
> +    memset(reservation, 0, sizeof(*reservation));
> +    reservation->req =3D req;
> +    reservation->keys_info =3D keys_info;
> +
> +    req->aiocb =3D blk_aio_pr_read_reservation(ns->blkconf.blk,
> +                 &reservation->generation, &reservation->key,
> +                 &reservation->type, nvme_resv_read_reservation_cb,
> +                 reservation);
> +    return;
> +
> +out:
> +    g_free(keys_info->keys);
> +    g_free(keys_info);
> +    nvme_misc_cb(req, ret);
> +}
> +
> +
> +static uint16_t nvme_resv_report(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    int num_keys;
> +    uint32_t cdw10 =3D req->cmd.cdw10;
> +    uint32_t cdw11 =3D req->cmd.cdw11;

le32_to_cpu() missing on cmd fields?

> +    int buflen =3D (cdw10 + 1) * sizeof(uint32_t);

Please use size_t buflen to avoid 32 vs 64 and signed vs unsigned issues be=
low.

> +    bool eds =3D cdw11 & 0x1;
> +    NvmeNamespace *ns =3D req->ns;
> +    NvmeResvKeys *keys_info;
> +
> +    if (!nvme_support_pr(ns)) {
> +        return NVME_INVALID_OPCODE;
> +    }
> +
> +    if (eds) {
> +        if (buflen < sizeof(NvmeReservationStatusHeader) +
> +           sizeof(uint8_t) * 40) {
> +            return NVME_INVALID_FIELD;
> +        }
> +
> +        num_keys =3D (buflen - sizeof(NvmeReservationStatusHeader) -
> +                   sizeof(uint8_t) * 40) /
> +                   sizeof(struct NvmeRegisteredCtrlExt);
> +    } else {
> +        if (buflen < sizeof(NvmeReservationStatusHeader)) {
> +            return NVME_INVALID_FIELD;
> +        }
> +
> +        num_keys =3D (buflen - sizeof(NvmeReservationStatusHeader)) /
> +                   sizeof(struct NvmeRegisteredCtrl);
> +    }

Is it possible to validate num_keys against the actual request sg size?
Or maybe there should be a reasonable maximum so that we don't have to
worry about g_malloc() failing and aborting the process, integer
overflows, etc?

> +
> +    keys_info =3D g_new0(NvmeResvKeys, 1);
> +    keys_info->generation =3D 0;
> +    /* num_keys is the maximum number of keys that can be transmitted */
> +    keys_info->num_keys =3D num_keys;
> +    keys_info->keys =3D g_malloc(sizeof(uint64_t) * num_keys);
> +    keys_info->req =3D req;
> +
> +    req->aiocb =3D blk_aio_pr_read_keys(ns->blkconf.blk, &keys_info->gen=
eration,
> +                                      keys_info->num_keys, keys_info->ke=
ys,
> +                                      nvme_resv_read_keys_cb, keys_info);
> +
> +    return NVME_NO_COMPLETE;
> +}
> +
>  typedef struct NvmeCopyAIOCB {
>      BlockAIOCB common;
>      BlockAIOCB *aiocb;
> @@ -4469,6 +4807,14 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeReque=
st *req)
>          return nvme_dsm(n, req);
>      case NVME_CMD_VERIFY:
>          return nvme_verify(n, req);
> +    case NVME_CMD_RESV_REGISTER:
> +        return nvme_resv_register(n, req);
> +    case NVME_CMD_RESV_REPORT:
> +        return nvme_resv_report(n, req);
> +    case NVME_CMD_RESV_ACQUIRE:
> +        return nvme_resv_acquire(n, req);
> +    case NVME_CMD_RESV_RELEASE:
> +        return nvme_resv_release(n, req);
>      case NVME_CMD_COPY:
>          return nvme_copy(n, req);
>      case NVME_CMD_ZONE_MGMT_SEND:
> diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
> index a5c903d727..833bcbae08 100644
> --- a/hw/nvme/ns.c
> +++ b/hw/nvme/ns.c
> @@ -60,6 +60,12 @@ void nvme_ns_init_format(NvmeNamespace *ns)
> =20
>      blk_pr_cap =3D blk_bs(ns->blkconf.blk)->bl.pr_cap;
>      id_ns->rescap =3D block_pr_cap_to_nvme(blk_pr_cap);
> +    if (id_ns->rescap !=3D NVME_PR_CAP_ALL &&
> +        id_ns->rescap !=3D NVME_PR_CAP_RW) {
> +
> +        /* Rescap either supports all or none of them */
> +        id_ns->rescap =3D 0;
> +    }
>  }
> =20
>  static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
> diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
> index 6d0e456348..23d7173a36 100644
> --- a/hw/nvme/nvme.h
> +++ b/hw/nvme/nvme.h
> @@ -470,6 +470,10 @@ static inline const char *nvme_io_opc_str(uint8_t op=
c)
>      case NVME_CMD_ZONE_MGMT_SEND:   return "NVME_ZONED_CMD_MGMT_SEND";
>      case NVME_CMD_ZONE_MGMT_RECV:   return "NVME_ZONED_CMD_MGMT_RECV";
>      case NVME_CMD_ZONE_APPEND:      return "NVME_ZONED_CMD_ZONE_APPEND";
> +    case NVME_CMD_RESV_REGISTER:    return "NVME_CMD_RESV_REGISTER";
> +    case NVME_CMD_RESV_REPORT:      return "NVME_CMD_RESV_REPORT";
> +    case NVME_CMD_RESV_ACQUIRE:     return "NVME_CMD_RESV_ACQUIRE";
> +    case NVME_CMD_RESV_RELEASE:     return "NVME_CMD_RESV_RELEASE";
>      default:                        return "NVME_NVM_CMD_UNKNOWN";
>      }
>  }
> @@ -558,6 +562,11 @@ static inline uint8_t block_pr_cap_to_nvme(uint8_t b=
lock_pr_cap)
>      return res;
>  }
> =20
> +static inline bool nvme_support_pr(NvmeNamespace *ns)
> +{
> +    return (ns->id_ns.rescap & NVME_PR_CAP_RW) =3D=3D NVME_PR_CAP_RW;
> +}
> +
>  typedef struct NvmeSQueue {
>      struct NvmeCtrl *ctrl;
>      uint16_t    sqid;
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 9b9eaeb3a7..2eec339028 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -692,6 +692,13 @@ typedef enum NVMEPrCap {
>      NVME_PR_CAP_WR_EX_AR =3D 1 << 5,
>      /* Exclusive Access All Registrants reservation type */
>      NVME_PR_CAP_EX_AC_AR =3D 1 << 6,
> +    /* Write and Read reservation type */
> +    NVME_PR_CAP_RW =3D (NVME_PR_CAP_WR_EX |
> +                      NVME_PR_CAP_EX_AC |
> +                      NVME_PR_CAP_WR_EX_RO |
> +                      NVME_PR_CAP_EX_AC_RO |
> +                      NVME_PR_CAP_WR_EX_AR |
> +                      NVME_PR_CAP_EX_AC_AR),
> =20
>      NVME_PR_CAP_ALL =3D (NVME_PR_CAP_PTPL |
>                        NVME_PR_CAP_WR_EX |
> @@ -702,6 +709,43 @@ typedef enum NVMEPrCap {
>                        NVME_PR_CAP_EX_AC_AR),
>  } NvmePrCap;
> =20
> +typedef struct QEMU_PACKED NvmeRegisteredCtrl {
> +    uint16_t    cntlid;
> +    uint8_t     rcsts;
> +    uint8_t     rsvd3[5];
> +    uint8_t     hostid[8];
> +    uint64_t    rkey;
> +} NvmeRegisteredCtrl;
> +
> +typedef struct QEMU_PACKED NvmeRegisteredCtrlExt {
> +    uint16_t  cntlid;
> +    uint8_t   rcsts;
> +    uint8_t   rsvd3[5];
> +    uint64_t  rkey;
> +    uint8_t   hostid[16];
> +    uint8_t   rsvd32[32];
> +} NvmeRegisteredCtrlExt;
> +
> +typedef struct QEMU_PACKED NvmeReservationStatusHeader {
> +    uint32_t  gen;
> +    uint8_t   rtype;
> +    uint16_t  regctl;
> +    uint16_t  resv5;
> +    uint8_t   ptpls;
> +    uint8_t   resv10[14];
> +} NvmeReservationStatusHeader;
> +
> +typedef struct QEMU_PACKED NvmeReservationStatus {
> +    struct NvmeReservationStatusHeader header;
> +    struct NvmeRegisteredCtrl regctl_ds[];
> +} NvmeReservationStatus;
> +
> +typedef struct QEMU_PACKED NvmeReservationStatusExt {
> +    struct NvmeReservationStatusHeader header;
> +    uint8_t   rsvd24[40];
> +    struct NvmeRegisteredCtrlExt regctl_eds[];
> +} NvmeReservationStatusExt;
> +
>  typedef struct QEMU_PACKED NvmeDeleteQ {
>      uint8_t     opcode;
>      uint8_t     flags;
> --=20
> 2.20.1
>=20

--T2CBQSG9KrDUsCNc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmbgqsoACgkQnKSrs4Gr
c8jD5ggArhvWYrZaPKj2V4vCC3p5BrRErYWwjWncVc1OX6ubGCMZg6/rv5pk1jcf
1MAOwAKgty2vvyUup5xK48z4a4tfLWhDr4Az9mwVJZtmpScYAFnwX9RC/noI8Yno
Fh+7tAgF32eo4vbuIlJnSE5WfESgTBesvYBSgCczIWObNVq89gnbdfORkAy12bLC
Z679QECQG8KSPMKXptSwkZpXm4gwOHK25aIAS4MOO8c6K38s5mtJPMIDlJKPavNj
BB755Ldr0U0XMoGajo9BIs5sJYPc81pf1Od7YQBPUZlVMHQfdnuabuHPG2QwQn6V
cs6lDvkfvF6THmBP9S+nuuPgwbQpJA==
=tz11
-----END PGP SIGNATURE-----

--T2CBQSG9KrDUsCNc--


