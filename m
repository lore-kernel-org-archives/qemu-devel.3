Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEE8C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 07:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAPHz-0005Nd-At; Fri, 24 May 2024 03:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sAPHx-0005Mq-I5; Fri, 24 May 2024 03:24:29 -0400
Received: from fhigh8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sAPHv-0007gL-6B; Fri, 24 May 2024 03:24:29 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 4267A11401CC;
 Fri, 24 May 2024 03:24:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Fri, 24 May 2024 03:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1716535466; x=
 1716621866; bh=O0vSpVkXMyLZfUeY9iozC4QKIorHgcwVo34Z2AqGVYw=; b=M
 NVTni4uuHZ7kaGWdX+mr7DsP+FYjbsM8fqQcMsOEZMBh/hwCz23mujaEZumQl0F2
 01jpze+KkuozXFoQ4SEcbk33TM6ocZcJeFd2nckF2KDkHwMZNd7wvN5qosZmctAc
 dQQhjt7aLRZEvKSkON1rPsepEgvoj+DD+1lwWBtG7LXbfvetLsXfVt2YEloqlXYG
 hBQtGP8ddyJVEmYM/Vngr1CrFMJkZNuenebt7Dvp/5xxr/lD5uVKFh0MG2yw/AXo
 S9i/QbIE290rxWz6F3CClP2NOsTjpL1Yj8GmQjBU26//IIKTIEWJq+mJ12HE1e+s
 kp0IarWT3qf5ECItE0F/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1716535466; x=1716621866; bh=O0vSpVkXMyLZfUeY9iozC4QKIorH
 gcwVo34Z2AqGVYw=; b=Pc8qVmDIDWVncM4omemGKwKh+bjCJD5UC8QnoTsVI3sb
 8a+MoDv3q6v0aiKbPfV8J5vE9kDDAMP7qd5b88vBEXfTw2J1GUD1SW/zj8ptWrom
 wz5iM0pEEglsh5BgBmCVeLyX9sA9KVgD69GzqgJbRMcymKOodyElTBZDkXoDFcQh
 YqgbMKKqNyuxuc49C/uRuv03U8Z6vsvJnehucytUuafn/Gnxe7yxEpGqLRZl8Q28
 QW9t+Y6Ng/d8cCaEiy0TEsejlgUxinNW4HlRfZbXSm75vC7WSkFkLdAHXbjJF3iF
 DapL9IVy//BepTL9YOLmCrUhW1xhB6oXL2wMqvpqnA==
X-ME-Sender: <xms:qUBQZtiEUhg4FLrHSN4VgcPuhz5K9qX2gCo7YkSk7BsH-ycBPOVSmA>
 <xme:qUBQZiC8ko1wfDNz731IAhqHeLd0GNZRKSs1akVU-2I62vgXzp1oyM_5wywHDQwJZ
 xWb3DK1HMeFYow_GOo>
X-ME-Received: <xmr:qUBQZtExX0FSXuaTNi27G1tENEGkj3oEugB-9ggA1ygz3nGtKOSQg4bL9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeijedguddujecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteff
 ffejveenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:qUBQZiRo2csgf6l25lR3F6TeXX9IC7xorJJISGwvJbtMN81XroA3KQ>
 <xmx:qUBQZqxzlZSCT1d22_G45exRubi5T7ofRcRF7jl5xrfMJJiGfxGAlQ>
 <xmx:qUBQZo5kBdXBKZomIcrrPSjn7IZaJxymzEe7vTd82ksO1tYLQDe80g>
 <xmx:qUBQZvz1KNUswhBj4uCfmYqZq2KB0ddb8f_Zz_azqqN8_j0QYOHLPQ>
 <xmx:qkBQZuCJqrGoQBMaGbKw02iEi7OgPZuA0VhLR6VYeQ8p3HNP_S4xbp5b>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 03:24:25 -0400 (EDT)
Date: Fri, 24 May 2024 09:24:19 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v3 10/11] hw/nvme: add reservation protocal command
Message-ID: <ZlBAo_zIqL6NLsFY@cormorant.local>
References: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
 <20240517095218.3107672-11-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4FUABoC276nDyHJ1"
Content-Disposition: inline
In-Reply-To: <20240517095218.3107672-11-luchangqi.123@bytedance.com>
Received-SPF: pass client-ip=103.168.172.159; envelope-from=its@irrelevant.dk;
 helo=fhigh8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--4FUABoC276nDyHJ1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 17 17:52, Changqi Lu wrote:
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
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  hw/nvme/ctrl.c       | 321 ++++++++++++++++++++++++++++++++++++++++++-
>  hw/nvme/nvme.h       |   4 +
>  include/block/nvme.h |  38 +++++
>  3 files changed, 362 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 182307a48b..ac2fbd22ec 100644
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
> @@ -1745,6 +1753,7 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
> =20
>      switch (req->cmd.opcode) {
>      case NVME_CMD_READ:
> +    case NVME_CMD_RESV_REPORT:
>          status =3D NVME_UNRECOVERED_READ;
>          break;
>      case NVME_CMD_FLUSH:
> @@ -1752,6 +1761,9 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
>      case NVME_CMD_WRITE_ZEROES:
>      case NVME_CMD_ZONE_APPEND:
>      case NVME_CMD_COPY:
> +    case NVME_CMD_RESV_REGISTER:
> +    case NVME_CMD_RESV_ACQUIRE:
> +    case NVME_CMD_RESV_RELEASE:
>          status =3D NVME_WRITE_FAULT;
>          break;
>      default:
> @@ -2127,7 +2139,10 @@ static inline bool nvme_is_write(NvmeRequest *req)
> =20
>      return rw->opcode =3D=3D NVME_CMD_WRITE ||
>             rw->opcode =3D=3D NVME_CMD_ZONE_APPEND ||
> -           rw->opcode =3D=3D NVME_CMD_WRITE_ZEROES;
> +           rw->opcode =3D=3D NVME_CMD_WRITE_ZEROES ||
> +           rw->opcode =3D=3D NVME_CMD_RESV_REGISTER ||
> +           rw->opcode =3D=3D NVME_CMD_RESV_ACQUIRE ||
> +           rw->opcode =3D=3D NVME_CMD_RESV_RELEASE;
>  }
> =20
>  static void nvme_misc_cb(void *opaque, int ret)
> @@ -2692,6 +2707,302 @@ static uint16_t nvme_verify(NvmeCtrl *n, NvmeRequ=
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
> +    NVMEResvType type =3D cdw10 >> 8 & 0xff;
> +
> +    ret =3D nvme_h2c(n, (uint8_t *)&cr_key, sizeof(cr_key), req);
> +    if (ret) {
> +        return ret;
> +    }
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
> +    uint8_t action =3D cdw10 & 0x7;
> +    NVMEResvType type =3D cdw10 >> 8 & 0xff;
> +
> +    ret =3D nvme_h2c(n, (uint8_t *)&key_info, sizeof(NvmeKeyInfo), req);
> +    if (ret) {
> +        return ret;
> +    }
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
> +static int _nvme_resv_read_reservation_cb(NvmeReadReservation *reservati=
on)

Nit: you can drop the leading underscore.

But I have no problems introducing this to hw/nvme, so

Acked-by: Klaus Jensen <k.jensen@samsung.com>

I will give this a proper review once reviews trickle in on the core
block layer changes (since this obviously depends on that).

--4FUABoC276nDyHJ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmZQQKMACgkQTeGvMW1P
DemoywgAkF/wbcBAMGeRkAPh10FgYRYrUnnG4byxwY3zSBWNzLZphfKYwdm3Oyjt
wRlln/p9MsK+DKv0dzx1ORk6+IESyezn/37vrq7YCmqBzF/Qqo6iZrJWix0ZhyIh
vq2Kywzf+1GNDN254ZXjhNXC7mF5p8JsNGSsadTdGlskOy/L2Mr+WpO04MPcis9H
2rVyVocRYzFgq1GQQCt8fvkuYqVQyIkiqO0SFNHMw61JLPopT4Y8ds5QTv8TXfg4
TFPjnov7z8IAbSFypCLmQcIxUZRNH7hURXdvZLm5LXx4SYJpMAhIvcU31mr4Ynb9
tWDwA5vVPxltm62zP+UfDiEfWUzViQ==
=EB03
-----END PGP SIGNATURE-----

--4FUABoC276nDyHJ1--

