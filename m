Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDE6CF649D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 10:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svDsH-0007wR-3e; Mon, 30 Sep 2024 06:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1svDsC-0007bR-AZ; Mon, 30 Sep 2024 06:43:25 -0400
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1svDsA-0006lJ-9x; Mon, 30 Sep 2024 06:43:24 -0400
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2B762114026C;
 Mon, 30 Sep 2024 06:43:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 30 Sep 2024 06:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1727692999; x=
 1727779399; bh=+xzMrWQfA83GBXMHQQLKdN3CFWXJpwqpCOm73SLu0Io=; b=U
 QZf8HMe4GsGXvFF0wyqvCgxpU5YuJuQElCfm6YqdF3F/fy1KsMFXKTpIE2iVizPx
 fmM1Qy9hV08a4WGGCYANzlfEk+r9ab4ePRVbpunBx6hgwUK2lmd9Cj/NWjXEwnxY
 CL4DapIEcQVulU7UJbgdP64AGrbd1mzqd1U6w6k7/VhY2agXO0i0ocsbsyKp1Bcq
 qPLbT86bKijD/CM2S/rY5ckPpRNcZAxbQ95dhClv2h01W50YR4akHeKG3ALWCa7T
 vl+I+gwXdY/5hcTgFXeZN6Wzuz4Sd43eb+QRsKJCOXANDsWB+TI432lr/w93Xp5A
 SNRTM10ctPDztDcMGoPog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1727692999; x=1727779399; bh=+xzMrWQfA83GBXMHQQLKdN3CFWXJ
 pwqpCOm73SLu0Io=; b=d3fSaKZnFqVtgBm2CaywVlYhpipuEcyFx6df4Tg/Fdzs
 WV25a7lSgJklD7Ut7HDJted43zTsrwwyp7hp6ikcl36RSajoAvr4jnFgYK7pWGrZ
 kzvU+AiC6OXQ3HUiM6zmxmVYFPydwhSxoVvB3J/7oDMq9wFUK23ZgMi7hXgE26hB
 MNWMOdOoA8Q8rBU9tXZDB8gJ0b4JsrdYHHGAHOnEbkDBSpxvOh0nsOvIvNQrymIE
 n2SEwopuNYcFRmKLN5N9lsldbEahVu3vuqKm1D4Gi5pGmfJ3b5vem2KxPp5CffCK
 Y8KIIrucxx1QW+MoBcH11iusRDGVvgH2dbVhP7XJJg==
X-ME-Sender: <xms:xYD6Zodrid-aKK0GXq5SuKL9gbg0jcvXBOYAodUuHRfvt88TycgD8g>
 <xme:xYD6ZqMuiB609WR3h5zpvCG7PXXhyhD-4VpqwNcUHEfd-xdQmyNqJE9vWiMALgzNB
 NxvKjkDRMd0i-1B_m0>
X-ME-Received: <xmr:xYD6ZpilhqlNWPH8Q0vhC7jEm_tFAJNrZtOGPKADQdkbbWaVUlyppPezTHPC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgfeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveej
 vedtuddugeeigeetffffjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgsuhhstghhsehkvghrnh
 gvlhdrohhrghdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphht
 thhopegrrhhunhdrkhhkrgesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehqvghmuh
 dqsghlohgtkhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghl
 sehnohhnghhnuhdrohhrghdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhngh
 drtghomhdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:xYD6Zt99HuQ8pPn8W3OZQB-_gIuFpywfH7W4UFFpTVz-oS8Dabp-Vw>
 <xmx:xYD6Zku26S1jAsGzbMiR7c48BBxDBny0SbXnDUi0lQh2Prsgm5-lRg>
 <xmx:xYD6ZkGcVB6detHQoND-MUkWYOgnl9ZhyCkfUv6VL0Hurn7DR6zGsA>
 <xmx:xYD6ZjN_8spkg8ypAbpd7_kYDYxjJ-n62wneUQI8B3pm-w2ktNSBqA>
 <xmx:x4D6Zp-nNgWelMTPuooAtJc4EehpXFwEfcw2Eg6iGkqHDWatrnvSwiL3>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 06:43:17 -0400 (EDT)
Date: Mon, 30 Sep 2024 12:43:16 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 Arun Kumar <arun.kka@samsung.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH] hw/nvme: add knob for CTRATT.MEM
Message-ID: <ZvqAxASMwl-Q-frr@AALNPWKJENSEN.aal.scsc.local>
References: <20240924-add-ctratt-mem-knob-v1-1-0674de9b88b4@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JDHB02o2sbCBFCjU"
Content-Disposition: inline
In-Reply-To: <20240924-add-ctratt-mem-knob-v1-1-0674de9b88b4@samsung.com>
Received-SPF: pass client-ip=103.168.172.152; envelope-from=its@irrelevant.dk;
 helo=fhigh-a1-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


--JDHB02o2sbCBFCjU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 24 08:35, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Add a boolean prop (ctratt.mem) for setting CTRATT.MEM and default it to
> unset (false) to keep existing behavior of the device intact.
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ctrl.c | 7 ++++++-
>  hw/nvme/nvme.h | 4 ++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index f36c45931821..8556f3e61fa0 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -8492,7 +8492,11 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice =
*pci_dev)
>      id->cntlid =3D cpu_to_le16(n->cntlid);
> =20
>      id->oaes =3D cpu_to_le32(NVME_OAES_NS_ATTR);
> -    ctratt =3D NVME_CTRATT_ELBAS | NVME_CTRATT_MEM;
> +
> +    ctratt =3D NVME_CTRATT_ELBAS;
> +    if (n->params.ctratt.mem) {
> +        ctratt |=3D NVME_CTRATT_MEM;
> +    }
> =20
>      id->rab =3D 6;
> =20
> @@ -8751,6 +8755,7 @@ static Property nvme_props[] =3D {
>                       false),
>      DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
>      DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
> +    DEFINE_PROP_BOOL("ctratt.mem", NvmeCtrl, params.ctratt.mem, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
> index 781985754d0d..bd3c6ba33a67 100644
> --- a/hw/nvme/nvme.h
> +++ b/hw/nvme/nvme.h
> @@ -538,6 +538,10 @@ typedef struct NvmeParams {
>      uint32_t  sriov_max_vq_per_vf;
>      uint32_t  sriov_max_vi_per_vf;
>      bool     msix_exclusive_bar;
> +
> +    struct {
> +        bool mem;
> +    } ctratt;
>  } NvmeParams;
> =20
>  typedef struct NvmeCtrl {
>=20
> ---
> base-commit: 3245de3f3d002bc9ce2ecae61e8d86cb9e375808
> change-id: 20240924-add-ctratt-mem-knob-ae4431251cb1
>=20
> Best regards,
> --=20
> Klaus Jensen <k.jensen@samsung.com>
>=20
>=20

Applied to nvme-next.

--JDHB02o2sbCBFCjU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmb6gMEACgkQTeGvMW1P
Dem9TQf+MYsh+Z/D735Kh/6665Oclm8gh+Hehg0CaZCYAXm1yMHFz3Y62izDov2W
aQOseTh/jV8Mm0VEzd02X0DA51bG+yC0G2V960hJrhau32h3y0sDMHzUj/fPbmrN
L9UDCCFNgMhm1UXhFJ9mrhZLsIcw9qmlEy2Rzd1MwWUkfXqahVGLIfzW/kHRVQll
D08zpCgSWUD3uaYvhC00X/+3/f2r/0+Kcaa5dij6eT6N222aJcZ3nL7VAK+uay2P
dhh3J0BZxkH1XubJZTeWWG6k5Xai+iHxicqEUrq5ajlPlAObPv/E7C2oTYw0mRsi
yNaPXg/jiqY1VZBk2SG3VulCEzn7dg==
=SIqB
-----END PGP SIGNATURE-----

--JDHB02o2sbCBFCjU--

