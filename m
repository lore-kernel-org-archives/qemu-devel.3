Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A9FC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 19:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPS7c-0005d4-L0; Thu, 04 Jul 2024 15:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sPS7E-0005Nh-7O
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 15:27:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sPS7C-0005y4-Gv
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 15:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720121254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GAKDGATUOn4BexJcSQiNhjOEn93yjajJn7Tv5gbabtg=;
 b=Lreibf5W8IY0/AuODmju5prJKk4jfF1NUDWc/Y6Nci7LB8M+RywtrddL2L3C+nIZh4VX0C
 GIUqNXlHle3vG3UTYR7eQaXQrlx+6jJKxAQZWrmgo+J0FF2Y4olxKZOd3oLr/cprFnixXQ
 AisuElFaAMj3BwbyrySFFtgvGLUu8gE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-fV1K-eBANN-sN-fM7NYyFg-1; Thu,
 04 Jul 2024 15:27:28 -0400
X-MC-Unique: fV1K-eBANN-sN-fM7NYyFg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A0F919560B1; Thu,  4 Jul 2024 19:27:26 +0000 (UTC)
Received: from localhost (unknown [10.39.192.129])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE6771956046; Thu,  4 Jul 2024 19:27:24 +0000 (UTC)
Date: Thu, 4 Jul 2024 20:20:31 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 fam@euphon.net, ronniesahlberg@gmail.com, pbonzini@redhat.com,
 pl@dlhnet.de, kbusch@kernel.org, its@irrelevant.dk,
 foss@defmacro.it, philmd@linaro.org, pizhenwei@bytedance.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: Re: [PATCH v6 08/10] hw/nvme: enable ONCS and rescap function
Message-ID: <20240704182031.GG2529519@fedora.redhat.com>
References: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
 <20240613071327.2498953-9-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7pgJn/R9+Q0pRPbP"
Content-Disposition: inline
In-Reply-To: <20240613071327.2498953-9-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--7pgJn/R9+Q0pRPbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 03:13:25PM +0800, Changqi Lu wrote:
> This commit enables ONCS to support the reservation
> function at the controller level. Also enables rescap
> function in the namespace by detecting the supported reservation
> function in the backend driver.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  hw/nvme/ctrl.c | 3 ++-
>  hw/nvme/ns.c   | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 127c3d2383..182307a48b 100644
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
> +                           NVME_ONCS_RESRVATIONS);

RESRVATIONS -> RESERVATIONS typo?

> =20
>      /*
>       * NOTE: If this device ever supports a command set that does NOT us=
e 0x0
> diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
> index ea8db175db..320c9bf658 100644
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
> +    blk_pr_cap =3D blk_bs(ns->blkconf.blk)->file->bs->bl.pr_cap;

Kevin: This unprotected block graph access and the assumption that
->file->bs exists could be problematic. What is the best practice for
making this code safe and defensive?

> +    id_ns->rescap =3D block_pr_cap_to_nvme(blk_pr_cap);
>  }
> =20
>  static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
> --=20
> 2.20.1
>=20

--7pgJn/R9+Q0pRPbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaG5+8ACgkQnKSrs4Gr
c8iIvwf+Lvhrrj5nYClxPzdheIPZiLbOX1R4VjjJXgp2h2YGtpy2KvZAZZz0dLig
a8ejpx7JryrTfkmnPVwNbbkUN2SnqrI+j6WfO/3RaRJwGTZXvef3h9VRc5Bh3j7/
bUMOO6EwllCcfpkEyB/rxlB1/u3BfVstrAt9wnNfOEV4tilGXfw0eCUYcXkqokNN
CDK4SBhtDO/9JJEu9SiJDTrEECa3YGJ+kgb5JAWxt/t0FI0+ynD58LGxfOpJifxH
OXoyN7Y+zaXy/Hsb5dQHLqeAbZirqi2GXQvNa+3+iW4rrwv9c4YAPpld8B3PKaCF
4cKk8aFcreKkD0+GzYAekFXfwV9alw==
=5dqS
-----END PGP SIGNATURE-----

--7pgJn/R9+Q0pRPbP--


