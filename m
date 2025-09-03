Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C56CA100C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkJw-0003yh-BH; Wed, 03 Sep 2025 06:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1utkJt-0003xd-RS; Wed, 03 Sep 2025 06:02:25 -0400
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1utkJT-0004OS-2k; Wed, 03 Sep 2025 06:02:05 -0400
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D39D21400378;
 Wed,  3 Sep 2025 06:01:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Wed, 03 Sep 2025 06:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1756893716; x=
 1756980116; bh=vPf3MflgQDgEZwNguXj0iPV33GHQ5kWKwELMc6xB76U=; b=G
 K3wyZ9YsUdEQLnJ2bfoedTc417dyYqtM2vJ8WeEtSb1eDub5B0ZUdIUiQg+ne84h
 qUxH1KKVeRtzPr+17199Ja7hjPAoIJR2xhtOB8nIq0Bj0iciFebaFbJRchFoWiyv
 F43Ab2E3CrjAsI3YoECJ1autNYsHDbY6tebcdheVbYeXaBPNAENoeTOPItSZwM7D
 epS4j8qXuiGF/5/O7Y++0zbRT3sGQAytUDMe2BLVwQFlHlh1oK2lvrDzlBnY7yOW
 9NKqVwEtczAZx7oSEVyr8sbsAcf4k8WWiXkLWDrwZKgHL9b419zzqf9+0wbA0i4B
 aaeyFfd5om7vgebRba5zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1756893716; x=1756980116; bh=vPf3MflgQDgEZwNguXj0iPV33GHQ5kWKwEL
 Mc6xB76U=; b=J1SHCpTmNigHq/rmp6StCBD9v2RPjziZ4vrdxwwru0bvlPO29Ts
 kOB8hEAOzUgaLNpBBGERaj5TALmzDVcCS7IUhfLREbVIK8HbknZDRnfsAIY2yV+/
 wxGlUFN/lkCTSUMHd+KDNAqJZcf8C7u3/CUivS/vXPL5tddoK7M91Txc6elMHoQE
 ZkASKSNpITmfXJw+ImOqbxRYYuGJAJihkLxNLYMZwrZv5XfhvHbYMU2e7KxZSWmf
 L6Sngkbrk+vbcIcVcjS0KPcVa0K16fnpa73op3SYUpIsYY/IQiKcyD+iMB7wgAEI
 xPRypZ3XdoRahg3LR19yUnqKptg8ysAH12Q==
X-ME-Sender: <xms:ExK4aLkBGaZFign9UQh0K_5MaQ7dleHLXrwjNCn8l7_08gMj2w5gOQ>
 <xme:ExK4aNz26Mjt3hN9UJcCZF7gq9wzhBdKd0N6K5f9LF80nCg4qX18xGQXplB8z1kjn
 SzO1VxC1spIb-MDzxQ>
X-ME-Received: <xmr:ExK4aNs2dWeRFHlwBmeJgJhF3x09ntC-7i-QAyV1eDN44HsOV9JghA89VloQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvkeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 epfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushculfgv
 nhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnh
 epjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffffjeevnecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesih
 hrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhp
 ohhuthdprhgtphhtthhopeifihhlfhhrvggurdhophgvnhhsohhurhgtvgesghhmrghilh
 drtghomhdprhgtphhtthhopegrlhhishhtrghirhdrfhhrrghntghishesfigutgdrtgho
 mhdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfh
 hoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepshhtvghfrghnhhgrsehrvggu
 hhgrthdrtghomhdprhgtphhtthhopehfrghmsegvuhhphhhonhdrnhgvthdprhgtphhtth
 hopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhrtghpthhtohepkhifohhlfhesrhgv
 ughhrghtrdgtohhmpdhrtghpthhtohephhhrvghithiisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:ExK4aHGN-DinqrrqHIF1bw-JuD8USttMkL2wJeeh1T4LKyzQtP5rvg>
 <xmx:ExK4aL6OpUmsbKbjmSMiS4KAWKGQJT9EJIyXXJ2R3ZrJyrELh7LbzQ>
 <xmx:ExK4aIyFj4-T_dodZcDbno7eNiH3Gc0R4qk1oCtSHBT-3kp7_qphmw>
 <xmx:ExK4aB0E20plb2nGhF3PXYcNI7_3s8zWAe3Ugw-U9JlXAGDhSQBVpA>
 <xmx:FBK4aItOhvnBDP9XIjDSQI54ZAWl5oBDJy6JgvHrwY1g1EBRev7ACdrg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 06:01:54 -0400 (EDT)
Date: Wed, 3 Sep 2025 12:01:53 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v3 3/5] hw/nvme: add NVMe Admin Security SPDM support
Message-ID: <aLgOlzuRwi0-_cvy@AALNPWKJENSEN.aal.scsc.local>
References: <20250901034759.85042-2-wilfred.opensource@gmail.com>
 <20250901034759.85042-5-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lFuRYtVkxG59qMDw"
Content-Disposition: inline
In-Reply-To: <20250901034759.85042-5-wilfred.opensource@gmail.com>
Received-SPF: pass client-ip=103.168.172.155; envelope-from=its@irrelevant.dk;
 helo=fhigh-a4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--lFuRYtVkxG59qMDw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep  1 13:47, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>=20
> Adds the NVMe Admin Security Send/Receive command support with support
> for DMTFs SPDM. The transport binding for SPDM is defined in the
> DMTF DSP0286.
>=20
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---

> +/* From host to controller */
> +static uint16_t nvme_security_send(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
> +    uint8_t secp =3D (dw10 >> 24) & 0xff;
> +
> +    switch (secp) {
> +    case NVME_SEC_PROT_DMTF_SPDM:
> +        return nvme_sec_prot_spdm_send(n, req);

If spdm_socket is not set, I think this should be Invalid Field in
Command too, right? Same for receive.

> +    default:
> +        /* Unsupported Security Protocol Type */
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    return NVME_INVALID_FIELD | NVME_DNR;
> +}
> +


--lFuRYtVkxG59qMDw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmi4Eg8ACgkQTeGvMW1P
DekUYAgApTwcabaHUW/MGIYZdjRRcYgbSRrkQooCOXvnt/P9bto9Ov/xkBLd30Q6
uNIJn+QAnweP0HIXSOgSQ1nvVjpB0ElWGDpD5dPoOl00FvERzFaOxcPmfPWtw+1h
W/7Ux1wloAMIsNLPDrQ1KeCsT3gW7iX/mifhU9h30g/fnN8NFuoZFqpKhwaa4xig
SyWo5eAH4bYNv+2/bJC4TIGEU4/MWCz5MfbJj1ynqcx1AR1HIjGFgkPkN5n3Ruq2
IA2qk4z/M51I+V4qtXMC1RvCP8zbY3MYlGw8oMjR00mR8P4rSzv+Fgjvk6dglBGG
mPtdHSinzzr0nIq2MqGyCQwT9qarMg==
=oi4l
-----END PGP SIGNATURE-----

--lFuRYtVkxG59qMDw--

