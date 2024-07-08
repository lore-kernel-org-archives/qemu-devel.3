Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EABC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 08:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQjZg-0001ws-OW; Mon, 08 Jul 2024 04:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sQjZe-0001vH-UC; Mon, 08 Jul 2024 04:18:14 -0400
Received: from fhigh3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sQjZc-0001M7-Qe; Mon, 08 Jul 2024 04:18:14 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 8296611403D2;
 Mon,  8 Jul 2024 04:18:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Mon, 08 Jul 2024 04:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1720426690; x=
 1720513090; bh=X4IZ4GPQQwRvKV39HwUsifqbdhgqAth8RDKPae2z+lk=; b=O
 aQ+USAkDEc0e0iaMwJ1yjYbxmCAsB7fl6m0Mdntb4dr+B3qxvcZ5O2FMkxUrRkNC
 xvBQR1Ek277gjzmpUpXp9qNaHeX2nppJKfmCJnvJEtR9ALb0EvmVunF74tPiCWne
 qT2IKNlog5aAllh3xJzyBTAF7l1SLeDWy5RIXocjXmxzuPQ1WQ64cspI7nlUIsQa
 dhqfuyzWx6hHf5FK41iWQc54Omq3Pfk+xJD8qR/Cpt4hfk4bnfoh+a5cSsof7s3H
 49acGkFpwecc1/GFFo9gHMz+ZBIU3hdqwjgyfQ+MswMh9e5Ci340vIj+rylw0mRK
 ISU2zGruNHnLYeq9vztxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1720426690; x=1720513090; bh=X4IZ4GPQQwRvKV39HwUsifqbdhgq
 Ath8RDKPae2z+lk=; b=dhx5W0eDt49aE+6MXEO0CjnOyx1QnZLRClcYoYAdupJK
 AltOP7YgfyYu2nwozWsKDNyVA6t2hje6DCeAX5n3VKQXg9Bfn7xNUTQomOD0NWct
 +BBamuHgd9Gqdx+6+qhpHPWme6Yi3Pl/CA+K1l8reqYmXpaR7VYRLmEtG1z3oVYp
 sNAz8yiCfgXGcDDBd62/PG/8NMFMy9OR+ii/Ho7pGEMhjQ50efqIXN/RPG5cKTf7
 U2+LHVx3M8RcdD/Olh4ZmRuXdFAyY2Ij++GSeReAyLj4Nf01NgbIOxMdE5vS45hW
 NOILLkWhDt3JB7c9JXiM3sBI7f+U5grUPPzwlY28jA==
X-ME-Sender: <xms:wKCLZqmMKJLVepwLWv5UubCeVBGYAgd0Qg1rrJh-Zc12rcPohZCygw>
 <xme:wKCLZh3WZStk7J7osZbcw7fa5OEDIVe1535HO5ricifI9G40kW4ihkmRBtxBJTe6k
 RvoatlyGoJI7JblhRU>
X-ME-Received: <xmr:wKCLZoqQ1nhkZapwuHfGlSh9yMgiMrtQ_TpTyrj0LDWeEA0RKwxIBtlUYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejgddtudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffej
 veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:wKCLZunyUmkgd6xd5nODSgIlFWBtqEsXj63ZdtqjEWnPkHJjO0-A5g>
 <xmx:wKCLZo2Hnpe8KqKZobZuCOlS10n8lZiq0QhWUPX1KvyNUMP_NPLxKA>
 <xmx:wKCLZlsBK7lTpBBWOiynqphByix5x6EAPAu4d6UH0fgVA-0d-hSQtA>
 <xmx:wKCLZkXnCBeSdLITrt967OtibmNG8r4eZUUDpmpcJX3FF5mEXx9BxA>
 <xmx:wqCLZr1nkrQ99qCZ7hpSS75OsHSs_jehQAReIHqqqUskiGr8iVmuI-cl>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jul 2024 04:18:07 -0400 (EDT)
Date: Mon, 8 Jul 2024 10:18:02 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v7 08/10] hw/nvme: enable ONCS and rescap function
Message-ID: <ZouguoF17DbzKF7h@cormorant.local>
References: <20240705105614.3377694-1-luchangqi.123@bytedance.com>
 <20240705105614.3377694-9-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rCjYjMt07x67hMKg"
Content-Disposition: inline
In-Reply-To: <20240705105614.3377694-9-luchangqi.123@bytedance.com>
Received-SPF: pass client-ip=103.168.172.154; envelope-from=its@irrelevant.dk;
 helo=fhigh3-smtp.messagingengine.com
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


--rCjYjMt07x67hMKg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul  5 18:56, Changqi Lu wrote:
> This commit enables ONCS to support the reservation
> function at the controller level. Also enables rescap
> function in the namespace by detecting the supported reservation
> function in the backend driver.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  hw/nvme/ctrl.c       | 3 ++-
>  hw/nvme/ns.c         | 5 +++++
>  include/block/nvme.h | 2 +-
>  3 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 127c3d2383..ad212de723 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -8248,7 +8248,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *=
pci_dev)
>      id->nn =3D cpu_to_le32(NVME_MAX_NAMESPACES);
>      id->oncs =3D cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAM=
P |
>                             NVME_ONCS_FEATURES | NVME_ONCS_DSM |
> -                           NVME_ONCS_COMPARE | NVME_ONCS_COPY);
> +                           NVME_ONCS_COMPARE | NVME_ONCS_COPY |
> +                           NVME_ONCS_RESERVATIONS);
> =20
>      /*
>       * NOTE: If this device ever supports a command set that does NOT us=
e 0x0
> diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
> index ea8db175db..a5c903d727 100644
> --- a/hw/nvme/ns.c
> +++ b/hw/nvme/ns.c
> @@ -20,6 +20,7 @@
>  #include "qemu/bitops.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/block-backend.h"
> +#include "block/block_int.h"
> =20
>  #include "nvme.h"
>  #include "trace.h"
> @@ -33,6 +34,7 @@ void nvme_ns_init_format(NvmeNamespace *ns)
>      BlockDriverInfo bdi;
>      int npdg, ret;
>      int64_t nlbas;
> +    uint8_t blk_pr_cap;
> =20
>      ns->lbaf =3D id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
>      ns->lbasz =3D 1 << ns->lbaf.ds;
> @@ -55,6 +57,9 @@ void nvme_ns_init_format(NvmeNamespace *ns)
>      }
> =20
>      id_ns->npda =3D id_ns->npdg =3D npdg - 1;
> +
> +    blk_pr_cap =3D blk_bs(ns->blkconf.blk)->bl.pr_cap;
> +    id_ns->rescap =3D block_pr_cap_to_nvme(blk_pr_cap);
>  }
> =20
>  static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 8b125f7769..9b9eaeb3a7 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -1251,7 +1251,7 @@ enum NvmeIdCtrlOncs {
>      NVME_ONCS_DSM           =3D 1 << 2,
>      NVME_ONCS_WRITE_ZEROES  =3D 1 << 3,
>      NVME_ONCS_FEATURES      =3D 1 << 4,
> -    NVME_ONCS_RESRVATIONS   =3D 1 << 5,
> +    NVME_ONCS_RESERVATIONS  =3D 1 << 5,
>      NVME_ONCS_TIMESTAMP     =3D 1 << 6,
>      NVME_ONCS_VERIFY        =3D 1 << 7,
>      NVME_ONCS_COPY          =3D 1 << 8,
> --=20
> 2.20.1
>=20

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--=20
One of us - No more doubt, silence or taboo about mental illness.

--rCjYjMt07x67hMKg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmaLoLkACgkQTeGvMW1P
DemAlQf/UpYBIpmWjxzAxAs/yZOsgkyD76SSL+3GLgn525QSFchtiVk+DHfJ6bnY
Su++9n2e2GF6950Ewf5f0wij4mT1v+V8zPtFFOlLK225ZUz2I0WQQy1FnNSxpJr/
MMjH/HDt4djuDORRcycwx/gTpxUPMRAqjix9KVjM5fhp2duMWev2Y4tNEp84m+se
S1Y2+tHweRkYa5/f4u1CSfxesSKWrNxZxEuMJyS7nrBjk8KhD38K3OQwT7YuI3hn
i2XIJQqL7eDzymlNDvYybJOoHq6wo4Mud6snvpSYmKutoqH3WOUHnPN5D/hn8Zxu
MpewXyHIdIF1zac2yfeulGGMbVOoNw==
=rdMt
-----END PGP SIGNATURE-----

--rCjYjMt07x67hMKg--

