Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03545C27C55
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 06:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF6EX-00026V-MS; Thu, 06 Jun 2024 02:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sF6EV-00025p-Gi; Thu, 06 Jun 2024 02:04:19 -0400
Received: from fout2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sF6ET-0005Ue-Dl; Thu, 06 Jun 2024 02:04:19 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.nyi.internal (Postfix) with ESMTP id 4187713800E6;
 Thu,  6 Jun 2024 02:04:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Thu, 06 Jun 2024 02:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1717653854; x=
 1717740254; bh=pl+kXLFf4JSQCKA1CaBpyRAR3caZXuJHC8rivWn7jis=; b=A
 F3dxMPddSBBPLwEe5XjwhJGGP/FVOfV7fl8UwJ4WjB+7B0FJWbhLwg7mRTrFogjP
 gJoSop/0HCwXtZcLmRC9o/M1shEy9TZ+9ZUIk30Bk/D+5/AhDRIAcZTS6uZHpO5g
 2mPJ8RBV9NbdyX+4w/Dczaw1yf/TeayxDqhzzWQ0+w83ky3X2QXhHK9jF4nZ+hhK
 Ute0NNkUxHedehGXKO7dvnmjEo+wFQySfFMr5447Dkf8gzjkLnc+mJRjqHBFd9wZ
 AgsEXdNu64hJl5euNdE5SM56tQisIvhBCY/1tOnKK43gY2kQajgyLt+SOKMvVciP
 uCc1NQ+mblsz9qizrt/JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1717653854; x=1717740254; bh=pl+kXLFf4JSQCKA1CaBpyRAR3caZ
 XuJHC8rivWn7jis=; b=iTlKo+jLzty3DlRzXnrfn8eQO2w6rTikxfewk41MpMhf
 gLOjMDyUbQH46Lf+i5Zm6jcjBP4uGpkAGDSOnNdwhQRW33vY76rjf4S0HqPX2NaA
 jiaUkqJ5L6Is5ft1RnbW/Qo028tjdwt4xlnOcNAV0bEM/VlbG14DgBRDfkx1ZdEe
 kwkOdEauN6l7E7A18xV/klGTu3/K63xqkY9nOyaTyIllJCv63FzM631i7FVqpSfI
 b65wDeuCWb1cFAFhuHIAYtSR+G0t5ckIr3Rf03rYLFYjP5S4Frp5vjiRL+oJRiig
 zgkiqeWq+J7Fjyy4SJDq7m0RJAVju18yAMZgSEiueQ==
X-ME-Sender: <xms:XVFhZluyQkW2pREcFn1Z55wfjcZ__LskW5LkvfZXdkqoIMLlwtO5yQ>
 <xme:XVFhZufOfQe_WKpBKq5E28Y3LeCBe9gVejXlW8nD6JJLlbUb0Oqtv003JRWyWC8EC
 1Ji9Sl6irevw785fME>
X-ME-Received: <xmr:XVFhZoz6yD4zJhRy1Bhz95Q-AIt7uU5GVc02QwfoDkuulRbBKITjG2tZwW0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedguddtfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteff
 ffejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:XVFhZsPhn_I0s4P8xz-LQi0OSHSi9phD_i8oN_xLhbgZhp2XVQ_9Cg>
 <xmx:XVFhZl8W8GjmPZLdMBwtgL6Y4wKmPfXzUsZqLAEEemnPqHnfNsRT-Q>
 <xmx:XVFhZsV8zeQJqf7HeFAdnuP1FhLtzZ7goecW8mfShvrb4v69IZe3og>
 <xmx:XVFhZmev0Fe7xOU4Z3CnZwh5_GCestc0ROdX7qonobc623ZZcMkYog>
 <xmx:XlFhZlxk_bfsrXA5KXc98luuPK0ptdwKn7qGnc958ZXaml7wNmaby0Z3>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 02:04:12 -0400 (EDT)
Date: Thu, 6 Jun 2024 08:04:06 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Minwoo Im <minwoo.im@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, gost.dev@samsung.com
Subject: Re: [PATCH] hw/nvme: fix BAR size mismatch of SR-IOV VF
Message-ID: <ZmFRVrY75B662OsC@cormorant.local>
References: <CGME20240604212442epcas2p19b786aa21b03d671b7b5cf7857ce24bd@epcas2p1.samsung.com>
 <20240604211306.2155791-1-minwoo.im@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s3Oo+sgo4INjdn2l"
Content-Disposition: inline
In-Reply-To: <20240604211306.2155791-1-minwoo.im@samsung.com>
Received-SPF: pass client-ip=103.168.172.145; envelope-from=its@irrelevant.dk;
 helo=fout2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--s3Oo+sgo4INjdn2l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun  5 06:13, Minwoo Im wrote:
> PF initializes SR-IOV VF BAR0 region in nvme_init_sriov() with bar_size
> calcaulted by Primary Controller Capability such as VQFRSM and VIFRSM
> rather than `max_ioqpairs` and `msix_qsize` which is for PF only.
>=20
> In this case, the bar size reported in nvme_init_sriov() by PF and
> nvme_init_pci() by VF might differ especially with large number of
> sriov_max_vfs (e.g., 127 which is curret maximum number of VFs).  And
> this reports invalid BAR0 address of VFs to the host operating system
> so that MMIO access will not be caught properly and, of course, NVMe
> driver initialization is failed.
>=20
> For example, if we give the following options, BAR size will be
> initialized by PF with 4K, but VF will try to allocate 8K BAR0 size in
> nvme_init_pci().
>=20
> 	#!/bin/bash
>=20
> 	nr_vf=3D$((127))
> 	nr_vq=3D$(($nr_vf * 2 + 2))
> 	nr_vi=3D$(($nr_vq / 2 + 1))
> 	nr_ioq=3D$(($nr_vq + 2))
>=20
> 	...
>=20
> 	-device nvme,serial=3Dfoo,id=3Dnvme0,bus=3Drp2,subsys=3Dsubsys0,mdts=3D9=
,msix_qsize=3D$nr_ioq,max_ioqpairs=3D$nr_ioq,sriov_max_vfs=3D$nr_vf,sriov_v=
q_flexible=3D$nr_vq,sriov_vi_flexible=3D$nr_vi \
>=20
> To fix this issue, this patch modifies the calculation of BAR size in
> the PF and VF initialization by using different elements:
>=20
> 	PF: `max_ioqpairs + 1` with `msix_qsize`
> 	VF: VQFRSM with VIFRSM
>=20
> Signed-off-by: Minwoo Im <minwoo.im@samsung.com>

Thanks, looks good Minwoo!

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/nvme/ctrl.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 127c3d2383..57bc26034c 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -8093,6 +8093,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *p=
ci_dev, Error **errp)
>      uint8_t *pci_conf =3D pci_dev->config;
>      uint64_t bar_size;
>      unsigned msix_table_offset =3D 0, msix_pba_offset =3D 0;
> +    unsigned nr_vectors;
>      int ret;
> =20
>      pci_conf[PCI_INTERRUPT_PIN] =3D 1;
> @@ -8125,9 +8126,19 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *=
pci_dev, Error **errp)
>          assert(n->params.msix_qsize >=3D 1);
> =20
>          /* add one to max_ioqpairs to account for the admin queue pair */
> -        bar_size =3D nvme_mbar_size(n->params.max_ioqpairs + 1,
> -                                  n->params.msix_qsize, &msix_table_offs=
et,
> -                                  &msix_pba_offset);
> +        if (!pci_is_vf(pci_dev)) {
> +            nr_vectors =3D n->params.msix_qsize;
> +            bar_size =3D nvme_mbar_size(n->params.max_ioqpairs + 1,
> +                                      nr_vectors, &msix_table_offset,
> +                                      &msix_pba_offset);
> +        } else {
> +            NvmeCtrl *pn =3D NVME(pcie_sriov_get_pf(pci_dev));
> +            NvmePriCtrlCap *cap =3D &pn->pri_ctrl_cap;
> +
> +            nr_vectors =3D le16_to_cpu(cap->vifrsm);
> +            bar_size =3D nvme_mbar_size(le16_to_cpu(cap->vqfrsm), nr_vec=
tors,
> +                                      &msix_table_offset, &msix_pba_offs=
et);
> +        }
> =20
>          memory_region_init(&n->bar0, OBJECT(n), "nvme-bar0", bar_size);
>          memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "=
nvme",
> @@ -8141,7 +8152,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *p=
ci_dev, Error **errp)
>                               PCI_BASE_ADDRESS_MEM_TYPE_64, &n->bar0);
>          }
> =20
> -        ret =3D msix_init(pci_dev, n->params.msix_qsize,
> +        ret =3D msix_init(pci_dev, nr_vectors,
>                          &n->bar0, 0, msix_table_offset,
>                          &n->bar0, 0, msix_pba_offset, 0, errp);
>      }
> --=20
> 2.34.1
>=20

--=20
One of us - No more doubt, silence or taboo about mental illness.

--s3Oo+sgo4INjdn2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmZhUVYACgkQTeGvMW1P
DenJRAf/YOiQCL/Yn+ZWycwTFQV8AQOx2jMubrNX3TPbnUDpY+HKjVyZSNGIM73S
rkJJyajwtYF6fuV5cuNscgraqxqQh9Rtv5Of7RaqkhRIdquoNblpeh3cYUPyEpPC
rRd5A3gn3OegryCgCEz8Xo0Iwg0LQj5dNG5MsgEmS2r7VBOturbDgmp8Rf/pZqxM
Fet6zYefnXoCqVVhb7HBVodicRs5rpa+ogtTgMqgEaMTR6P/X6YsWtMgSAYGJ1Rp
bx686/zEnpDR0D2+JXGzv6EIexL6e6HIzkJ4OO4OTN+taMHEDhsoPNrSrlzH548p
/jSk88jr7x02dS+m9u3VuZxyuSN3Tw==
=XdhI
-----END PGP SIGNATURE-----

--s3Oo+sgo4INjdn2l--

