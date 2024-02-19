Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5BEC48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 12:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc2Jl-00036K-88; Mon, 19 Feb 2024 07:00:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rc2Ji-0002yb-Rt; Mon, 19 Feb 2024 07:00:14 -0500
Received: from wfout1-smtp.messagingengine.com ([64.147.123.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rc2Jg-0005ea-Bu; Mon, 19 Feb 2024 07:00:14 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.west.internal (Postfix) with ESMTP id E4A1F1C0009A;
 Mon, 19 Feb 2024 07:00:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Mon, 19 Feb 2024 07:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1708344006; x=
 1708430406; bh=HuvcFgexHKGbc9cIvMgQB8ZOE6qUxPIIeMZd4MAqNgs=; b=h
 RrgM5i9pFUIE6llNCzcRPyuw+t/+xxktXtRAItNPnc0n0n0/38LpDGG67hoRHlZw
 dOfeL7V97WtbOPyIE2dqPkHYgYpuQ0w5231H78xHvPn5ziKT7JPQgOZ+9A1eICCI
 vCdjRa7SduR4UI50msOH8GV80TvJm95PoesxoAw3VDs4ggwEKtBLu0gNh1PeZWh4
 PsYKek7awURtuPYUvCTZMM4diGhKsrIXAS07aTVbTtBe27pCJuvtiXU49hrG420i
 zc0v8vXYsrqWZwLoQX7k9bIAPQNP7qhx+fOLt+Y4Lr2FN5aDyPbyqxIHPtROGJcs
 Q7VRujARDcfpqY8M2I6Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1708344006; x=1708430406; bh=HuvcFgexHKGbc9cIvMgQB8ZOE6qU
 xPIIeMZd4MAqNgs=; b=H+tH1aLfm+xqLNllb/8K9JwEn2yxcnL3zdPu1eD/OX1L
 QyPNeOZUrciPUqE55TrYYMTDQj2KFFCNgF0HUUDzK6v33CVqvmp43ioDIKqnZO6l
 wkjOIxuQl1hKe/lA0hVDvDu1nKoL1R1fouCFPDYYtdWTUNyVMtrLRdEADAw7ZYgC
 tmkYDpuP9bTzFTlHiKGhRzQrbpd/NM4d8lzB3eTcaCQ/p849sF95zA1KF6XCmWv4
 YKEgn2gldBOxaHu11cO+wsYbQ0Ndxfda9+OS80ht8y/xuGDhTGvwiiOQvpRkin86
 0hyNIZ1M2vOw3YAXAqUOMaabbjrHeUEsyPmJUNMYiw==
X-ME-Sender: <xms:xULTZfYAJc63Afk6QUo8CRTvnqbtoeVw5I_HAewlLrf_sZUjybbJ1w>
 <xme:xULTZeaIXIME3ciw7UTHw4V1jXpc8qy-ZDa-CUW20DyzqvUiUdYuEquRDvj5_ZSdu
 wMYcYtGglL3QwGTvCo>
X-ME-Received: <xmr:xULTZR9GzbBdCt0cQevS70o3YZ2eWEIVUJeOaLIlOUC5tDC_OAJwzMnKKJoLmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgdefgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffej
 veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:xULTZVoh3n-4lW3hnqg1b4E_B_AhVZXCpbAA2eXZeVe9RX7V8XWMgw>
 <xmx:xULTZarTxgoVrxc2YW6Qp0pHWfWF8_Ep-T76Zs3H6tpj_3SlCwleIA>
 <xmx:xULTZbR3cUZ_4Cu5fG4_G7qTg_P8-sWFEMLqkjQt1eBVr44JsQvGKQ>
 <xmx:xkLTZYbkeak6m2NhfQwZo4F_x2wUmTA4I7hHpvuKXa9aFbwAF4ihWRaodjw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Feb 2024 07:00:05 -0500 (EST)
Date: Mon, 19 Feb 2024 13:00:00 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH v5 01/11] hw/nvme: Use pcie_sriov_num_vfs()
Message-ID: <ZdNCwMf406yZpN1X@cormorant.local>
References: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
 <20240218-reuse-v5-1-e4fc1c19b5a9@daynix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ByGRRSzctGLxWEvB"
Content-Disposition: inline
In-Reply-To: <20240218-reuse-v5-1-e4fc1c19b5a9@daynix.com>
Received-SPF: pass client-ip=64.147.123.144; envelope-from=its@irrelevant.dk;
 helo=wfout1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--ByGRRSzctGLxWEvB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 18 13:56, Akihiko Odaki wrote:
> nvme_sriov_pre_write_ctrl() used to directly inspect SR-IOV
> configurations to know the number of VFs being disabled due to SR-IOV
> configuration writes, but the logic was flawed and resulted in
> out-of-bound memory access.
>=20
> It assumed PCI_SRIOV_NUM_VF always has the number of currently enabled
> VFs, but it actually doesn't in the following cases:
> - PCI_SRIOV_NUM_VF has been set but PCI_SRIOV_CTRL_VFE has never been.
> - PCI_SRIOV_NUM_VF was written after PCI_SRIOV_CTRL_VFE was set.
> - VFs were only partially enabled because of realization failure.
>=20
> It is a responsibility of pcie_sriov to interpret SR-IOV configurations
> and pcie_sriov does it correctly, so use pcie_sriov_num_vfs(), which it
> provides, to get the number of enabled VFs before and after SR-IOV
> configuration writes.
>=20
> Cc: qemu-stable@nongnu.org
> Fixes: 11871f53ef8e ("hw/nvme: Add support for the Virtualization Managem=
ent command")
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Thanks Akihiko,

I'll pick this up for hw/nvme nvme-next as-is.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/nvme/ctrl.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index f026245d1e9e..7a56e7b79b4d 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -8466,36 +8466,26 @@ static void nvme_pci_reset(DeviceState *qdev)
>      nvme_ctrl_reset(n, NVME_RESET_FUNCTION);
>  }
> =20
> -static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
> -                                      uint32_t val, int len)
> +static void nvme_sriov_post_write_config(PCIDevice *dev, uint16_t old_nu=
m_vfs)
>  {
>      NvmeCtrl *n =3D NVME(dev);
>      NvmeSecCtrlEntry *sctrl;
> -    uint16_t sriov_cap =3D dev->exp.sriov_cap;
> -    uint32_t off =3D address - sriov_cap;
> -    int i, num_vfs;
> +    int i;
> =20
> -    if (!sriov_cap) {
> -        return;
> -    }
> -
> -    if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
> -        if (!(val & PCI_SRIOV_CTRL_VFE)) {
> -            num_vfs =3D pci_get_word(dev->config + sriov_cap + PCI_SRIOV=
_NUM_VF);
> -            for (i =3D 0; i < num_vfs; i++) {
> -                sctrl =3D &n->sec_ctrl_list.sec[i];
> -                nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
> -            }
> -        }
> +    for (i =3D pcie_sriov_num_vfs(dev); i < old_num_vfs; i++) {
> +        sctrl =3D &n->sec_ctrl_list.sec[i];
> +        nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
>      }
>  }
> =20
>  static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
>                                    uint32_t val, int len)
>  {
> -    nvme_sriov_pre_write_ctrl(dev, address, val, len);
> +    uint16_t old_num_vfs =3D pcie_sriov_num_vfs(dev);
> +
>      pci_default_write_config(dev, address, val, len);
>      pcie_cap_flr_write_config(dev, address, val, len);
> +    nvme_sriov_post_write_config(dev, old_num_vfs);
>  }
> =20
>  static const VMStateDescription nvme_vmstate =3D {
>=20
> --=20
> 2.43.1
>=20

--=20
One of us - No more doubt, silence or taboo about mental illness.

--ByGRRSzctGLxWEvB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmXTQr8ACgkQTeGvMW1P
DekDDwf+MJTWJX2VUrNmLwSPX6PDwTpNTCgJIHUFDbr35+8a+n543EYf1Zks3UPU
gnf0sDrvhCVjiy1uUyps3yV3euUXb3NX/wcrXQITg4OnwpD4xDd6fVeXi3vN3l6N
f+Lk2iw4iYucnh0nV0mQNq91bpAPRJkeSxEAw4Jz3LdSbDz9O+BpgoIHcB0G3KhM
yvtVQL3c6q4FF+vECKEBR1ecdpsUixJW+lH3vZfaAMZOQt6y2wl7z6VnRgtqMux8
Tv5i6FRpC9ddDivVPDifXtIYMqFuLL8aqhNJMMFgGsXN3bXFIrx/lundzEVAGxZP
uEFOgCu/O7rBVeQR5zdPyvhyHtrA+g==
=ZxhB
-----END PGP SIGNATURE-----

--ByGRRSzctGLxWEvB--

