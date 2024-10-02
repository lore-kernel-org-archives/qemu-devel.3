Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAC0CF3195
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 06:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsi4-0006oI-8b; Wed, 02 Oct 2024 02:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1svsi2-0006nc-Mt; Wed, 02 Oct 2024 02:19:38 -0400
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1svshz-0008BU-Dm; Wed, 02 Oct 2024 02:19:38 -0400
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8A56111401FD;
 Wed,  2 Oct 2024 02:19:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 02:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1727849973; x=
 1727936373; bh=38G9s5yoFQQwpv8Z+UcZqHn0aAR1VF3pBB422zX6h5Y=; b=k
 f7acmgTeB0DnEyV/eG8uzbSRZ0iXXRuDwvyK+ZjeeBSdBe8bKyoGoI4P4fmTKLgY
 bG3Ffce0gRAf5yvQZUY905mRtoZSbS9N/iDlpSYsyW7YfsNuFVMSpApNl8P3XT+s
 DfHp2ONe87K5Dj5da0PzjgjafuYuEwtQUbyuTjh9DrKOWle1hGya1z7EbKkX2sPW
 rpKqfdgC9aDztYoXl3tphJIOVktmxSDWHhRVawN/JWNx8BWpgN6jzcKsE8FpEGYA
 rBNZ0dPwhqM+av76z9b3zUnY+73YQH0zKlPJwIJTxeVh5kb8OiGDJXs+Pcx7jwpf
 vCz9I8joGIoj03OTXy81w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1727849973; x=1727936373; bh=38G9s5yoFQQwpv8Z+UcZqHn0aAR1
 VF3pBB422zX6h5Y=; b=feMUn95lRmlzzKiwCE6+ZiA/j6iKtAktaoSJ96uYDZSr
 Y3EASUCiW2KsK7wtxgxICXVASpsdQA64CcTigtFUJ/U4DMaf4SkqUWsogoEq+gOW
 QErc512S2BMWwlCrejwZJ5I3i596wqUk0kpBL+CHUU0dHYqUg7JFCUVxbSU+Kg88
 5BjNxELAXpplSKNc6hfOGqCfW+r1bzzif87zXkTOXH0YofGkJl0Ts4xbEfvfzo4o
 ZegV1AUzSSjnv7HxnzrZhqgJT0DCfIgCMiwSAKDWifuCNiF/17FGdGTQt6R3r6J3
 ke5XJhXo4DQpgvYkUb2pLKWGDmpJssyWs02qKBMupg==
X-ME-Sender: <xms:8-X8Zrx8JI3kY4iKYfrQ-V7Nig1WPv7Uvn-Ql7pSSSN7mHO5wPQS8Q>
 <xme:8-X8ZjQg4C3wI_bNJ-00es-7tscF5ukA7jDcv-u4C5hVgwaJWQTGygEpDPWk7noz2
 WtVrlHDyLnrHlE-wSM>
X-ME-Received: <xmr:8-X8ZlXGrKTVbhS9XVwpEMNgU_lc5jsCrW_IS5sE1GzLOE1zjzUqNmT5y7qD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddukedguddtjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdej
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeev
 jeevtdduudegieegteffffejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
 thhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhutghhrghnghhqih
 druddvfeessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehqvghmuhdqsghlohgt
 khesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhngh
 hnuhdrohhrghdprhgtphhtthhopehkfiholhhfsehrvgguhhgrthdrtghomhdprhgtphht
 thhopehhrhgvihhtiiesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshhtvghfrghnhh
 grsehrvgguhhgrthdrtghomhdprhgtphhtthhopehfrghmsegvuhhphhhonhdrnhgvthdp
 rhgtphhtthhopehrohhnnhhivghsrghhlhgsvghrghesghhmrghilhdrtghomhdprhgtph
 htthhopehpsghonhiiihhnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:8-X8Zlg8ACmsvfEjRenxl3BChRHAHzpV7LbrBYWw3tfdXdNRrPk2nA>
 <xmx:8-X8ZtCFtNitSq7osPGd-v5K724KqJ-no4nRuXf3Zpi9rFSE7MbGbA>
 <xmx:8-X8ZuJ1vLGwnZ-2ZP5W4VpbIYM3GQVDUh6GM8GPvB93PR2CkA0qlg>
 <xmx:8-X8ZsDOHBrXuzYJIlAY8ggiRdAioiYkqaiu4ey8vb_FdD2BJvlk1w>
 <xmx:9eX8ZvweF_kSMjTou8IEI5US2sFeipD6J1Y79FzgrAKUDJ-wDFNhwMex>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 02:19:31 -0400 (EDT)
Date: Wed, 2 Oct 2024 08:19:30 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com
Subject: Re: [PATCH v13 09/10] hw/nvme: add reservation protocal command
Message-ID: <Zvzl8miLGFNaCzLU@AALNPWKJENSEN.aal.scsc.local>
References: <20240926074546.24507-1-luchangqi.123@bytedance.com>
 <20240926074546.24507-10-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tJ6IcJ97HIFi2yHK"
Content-Disposition: inline
In-Reply-To: <20240926074546.24507-10-luchangqi.123@bytedance.com>
Received-SPF: pass client-ip=103.168.172.155; envelope-from=its@irrelevant.dk;
 helo=fhigh-a4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--tJ6IcJ97HIFi2yHK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 26 15:45, Changqi Lu wrote:
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
>  hw/nvme/ctrl.c       | 359 +++++++++++++++++++++++++++++++++++++++++++
>  hw/nvme/ns.c         |   6 +
>  hw/nvme/nvme.h       |  10 ++
>  include/block/nvme.h |  44 ++++++
>  4 files changed, 419 insertions(+)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index ad212de723..ffb876a99f 100644
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

Can the -ENOTSUP actually happen if the block layer has indicated
support for reservations? Or is this a left over from the way you
handled missing support earlier?

>      default:
>          status =3D NVME_INTERNAL_DEV_ERROR;
>          break;
> @@ -2692,6 +2716,333 @@ static uint16_t nvme_verify(NvmeCtrl *n, NvmeRequ=
est *req)
>      return NVME_NO_COMPLETE;
>  }
> =20
> +typedef struct NvmeKeyInfo {
> +    uint64_t cr_key;
> +    uint64_t nr_key;
> +} NvmeKeyInfo;

This is an spec data structure, should be in include/block/nvme.h (and
maybe use a union to alias NRKEY and PRKEY).

> +
> +static uint16_t nvme_resv_register(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    int ret;
> +    NvmeKeyInfo key_info;
> +    NvmeNamespace *ns =3D req->ns;
> +    uint32_t cdw10 =3D le32_to_cpu(req->cmd.cdw10);
> +    bool ignore_key =3D cdw10 >> 3 & 0x1;

Prefer parantheses around the shift arguments.

> +    uint8_t action =3D cdw10 & 0x7;
> +    uint8_t ptpl =3D cdw10 >> 30 & 0x3;

Parantheses. Name is technically CPTPL.

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
> +    key_info.cr_key =3D le64_to_cpu(key_info.cr_key);
> +    key_info.nr_key =3D le64_to_cpu(key_info.nr_key);
> +
> +    switch (action) {
> +    case NVME_RESV_REGISTER_ACTION_REGISTER:
> +        req->aiocb =3D blk_aio_pr_register(ns->blkconf.blk, 0,
> +                                         key_info.nr_key, 0, aptpl,
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

I don't understand the reason for this requirement (due to an ECN?), but
if IEKEY (bit 3 in DWORD 10) is set, the controller SHALL return an
error of Invalid Field in Command.=20

> +    uint8_t action =3D cdw10 & 0x7;
> +    NvmeResvType type =3D cdw10 >> 8 & 0xff;

Parantheses.

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
> +    cr_key =3D le64_to_cpu(cr_key);
> +
> +    switch (action) {
> +    case NVME_RESV_RELEASE_ACTION_RELEASE:
> +        req->aiocb =3D blk_aio_pr_release(ns->blkconf.blk, cr_key,
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

Same weird IEKEY requirement.

> +    uint8_t action =3D cdw10 & 0x7;
> +    NvmeResvType type =3D cdw10 >> 8 & 0xff;

Parantheses.

> +
> +    if (!nvme_support_pr(ns)) {
> +        return NVME_INVALID_OPCODE;
> +    }
> +
> +    ret =3D nvme_h2c(n, (uint8_t *)&key_info, sizeof(NvmeKeyInfo), req);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    key_info.cr_key =3D le64_to_cpu(key_info.cr_key);
> +    key_info.nr_key =3D le64_to_cpu(key_info.nr_key);
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

This leaks contents of the heap in the uninitialized reserved fields.
Use g_malloc0.

> +    nvme_status->header.gen =3D cpu_to_be32(reservation->generation);
> +    nvme_status->header.rtype =3D block_pr_type_to_nvme(reservation->typ=
e);
> +    nvme_status->header.regctl =3D cpu_to_be16(keys_info->num_keys);
> +    for (int i =3D 0; i < keys_info->num_keys; i++) {
> +        uint16_t ctnlid =3D nvme_ctrl(req)->cntlid;
> +        nvme_status->regctl_ds[i].cntlid =3D cpu_to_be16(ctnlid);
> +        nvme_status->regctl_ds[i].rkey =3D cpu_to_be64(keys_info->keys[i=
]);
> +        nvme_status->regctl_ds[i].rcsts =3D keys_info->keys[i] =3D=3D
> +                                          reservation->key ? 1 : 0;
> +        /* hostid is not supported currently */
> +        memset(&nvme_status->regctl_ds[i].hostid, 0, 8);

With g_malloc0, no need to memset this.

> +    }

The endian conversions here should all be cpu to little-endian, no? I
don't see anything in the spec defining these to be big-endian.

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

sizeof(NvmeReservationStatusExt)?

> +              sizeof(NvmeRegisteredCtrlExt) * keys_info->num_keys;
> +
> +    nvme_status_ext =3D g_malloc(len);

This leaks contents of the heap in the uninitialized reserved fields.
Use g_malloc0.

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

With g_malloc0, no need to memset this.

> +    }

Same here, should be little-endian I believe.=20

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
> +    bool eds =3D le32_to_cpu(req->cmd.cdw11) & 0x1;
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

g_new0 zeroes the memory.

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
> +    uint32_t cdw10 =3D le32_to_cpu(req->cmd.cdw10);
> +    uint32_t cdw11 =3D le32_to_cpu(req->cmd.cdw11);
> +    size_t buflen =3D (cdw10 + 1) * sizeof(uint32_t);
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

No point in the sizeof(uint8_t) and would be more clear to just use
sizeof(NvmeReservationStatusExt), no?

In these cases I try to go for the strategy of just building the data
structure in its entirety and then when we get to nvme_c2h above, only
transfer the part of the data structure that the host requested.

Maybe, you could get rid of the NVME_MAX_RESERVATION_KEYS band-aid
(that, as far as I can tell, is non-spec compliant?), by DMA'ing to the
host in "chunks" in the callback (i.e., read 128 keys, c2h, repeat), but
I guess that would require the blk_aio_pr API to have an "offset" so you
didn't have to read all keys in one go?

What are the implications of putting a hard limit of
NVME_MAX_RESERVATION_KEYS here? There is no way to convey that limit to
the host, is there?

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
> +
> +    /*
> +     * The maximum number of keys that can be transmitted is 128.
> +     */
> +    num_keys =3D MIN(num_keys, NVME_MAX_RESERVATION_KEYS);
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
> @@ -4469,6 +4820,14 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeReque=
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
> index 6d0e456348..b87e1fa3b0 100644
> --- a/hw/nvme/nvme.h
> +++ b/hw/nvme/nvme.h
> @@ -29,6 +29,7 @@
>  #define NVME_EUI64_DEFAULT ((uint64_t)0x5254000000000000)
>  #define NVME_FDP_MAX_EVENTS 63
>  #define NVME_FDP_MAXPIDS 128
> +#define NVME_MAX_RESERVATION_KEYS 128
> =20
>  /*
>   * The controller only supports Submission and Completion Queue Entry Si=
zes of
> @@ -470,6 +471,10 @@ static inline const char *nvme_io_opc_str(uint8_t op=
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
> @@ -558,6 +563,11 @@ static inline uint8_t block_pr_cap_to_nvme(uint8_t b=
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

Not a biggie, but this field is named REGSTRNT now.

> +    uint16_t  resv5;
> +    uint8_t   ptpls;
> +    uint8_t   resv10[14];
> +} NvmeReservationStatusHeader;
> +
> +typedef struct QEMU_PACKED NvmeReservationStatus {
> +    struct NvmeReservationStatusHeader header;
> +    struct NvmeRegisteredCtrl regctl_ds[];

We generally do not use 'struct' if we do not have to, and here it is
not required I believe.

> +} NvmeReservationStatus;
> +
> +typedef struct QEMU_PACKED NvmeReservationStatusExt {
> +    struct NvmeReservationStatusHeader header;
> +    uint8_t   rsvd24[40];

Align or drop the spaces here.

> +    struct NvmeRegisteredCtrlExt regctl_eds[];

Same here.

> +} NvmeReservationStatusExt;
> +

Please add QEMU_BUILD_BUG_ON(sizeof(...) !=3D ...) checks in
_nvme_check_size for these structs.

They all add up as far as I can tell, but it's a good safe-guard
generally.

>  typedef struct QEMU_PACKED NvmeDeleteQ {
>      uint8_t     opcode;
>      uint8_t     flags;
> --=20
> 2.20.1
>=20
>=20

--tJ6IcJ97HIFi2yHK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmb85ewACgkQTeGvMW1P
DekWBQf/WZi/0Mn0/BL4Gp/cJWgwLwhcPPNMMGSg2ywCYkHfyXETCbvziXpdq94r
oiPEi86su90YNnubA+zac/htwRwNka+gWYl4Mc57CFF8QSDRIiNQpWShREpjMAcf
R/YQwoe6pGLrvJSWSi83VBycNidrMUZsWbhLsjIJkvlFSriSXpViwX+IT48TtCUU
Abyw/C2pjgkZYniUmcTX5rvm1uUnRMGjMJXHD4LtMymDuIH8fhEcjmwJo0bhsXvE
dqcRCdOw8hpXGiSlwmwOgPpCUTaBqG9Y24+Eq0Jl1v8p7YHGFv8GewcJks0g/n2S
RT6luSxR2jHVwF6pQhD0mFLzxCb0rw==
=ucsQ
-----END PGP SIGNATURE-----

--tJ6IcJ97HIFi2yHK--

