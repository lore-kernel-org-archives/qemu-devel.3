Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7495EC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd59E-0002Xl-HK; Thu, 22 Feb 2024 04:13:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rd59C-0002S6-QH; Thu, 22 Feb 2024 04:13:42 -0500
Received: from fhigh1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rd59A-0000gH-I6; Thu, 22 Feb 2024 04:13:42 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 760B811400D6;
 Thu, 22 Feb 2024 04:13:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Thu, 22 Feb 2024 04:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1708593217; x=
 1708679617; bh=XwRqkdl0vuH6Ba/gl15XuZXHtlJr5Sza38PG/38JFBg=; b=Y
 UnMOmEzC1OXYp+XMKqJkcpVJWNt2ZH7DpZ105PiSxqc+NxIRJ3uZ1pPEDYPBVgKt
 kM9TfKAI/qwH7pzoEcC451cMi5o1u5zsDXCESsmILJVh2ZM3AJKhjD7aiJWWQufx
 BOB7hqH2au3mg3XHvg/rKGoI3NEnG+dOhwXBZqLtHHI9J25rKvrLBK6+WyYU++c5
 Uji+PC1I2YxiEYfFwP+hAsh24zvkidd3LrK5x6F/FzrOACNxuKPgdyBfrw/vO6fq
 AJwbZvNu395BLsHx7lemSByjkak/67ewEqHlF8RdOluXtxp6yeOZscC60rFMauvF
 WRM0ewUO3m7fhoRZqSiUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1708593217; x=1708679617; bh=XwRqkdl0vuH6Ba/gl15XuZXHtlJr
 5Sza38PG/38JFBg=; b=psPVACYVkoKvE7NgePX0xHMSj8ziIgtkFxU6KHYgpv0P
 0MDiDsg4JYi08BiTZp9T4SVO0eTnMpem1MP/7Uu0PQ0oRwS4Ru/ekl/ZZpm4XSSc
 RSrzYQ1ggq1079rClbcPrQtApx7HUS6TJyQGoLFLBRwej/6O1y5g+A05pyazt3bT
 wWHb7P4mRT9x9azVUpAqfzJ5ZYJoWSSXvAej0myo4y5h3Jmw0WJ0LqSU3zNXcv2S
 tuWdk0WhzXEn4KFiGIWWUiKeO/k7vuWhgXiXahaaH/rvNfXNBhdD8D7SXKwzdDp7
 9RZ7+uzrVrUg7udXv4WXoZLOZ0KPQVjR90xTpdu6Zg==
X-ME-Sender: <xms:QRDXZcFqeCV_-XGXe6bSnURLIs7PVO6MV4AjMNS8nFjS_etlvV4OfQ>
 <xme:QRDXZVX2EDQcrV1yEKc_cxUuNqDRX1frxZNNTuNOdVtJ45vDrx8dKNtWXkPzF6OAJ
 OZBzEOIOy6s5sa__1w>
X-ME-Received: <xmr:QRDXZWKYRSyGEmPpfW8r9UfXheWRGYE3JhKDn-6ynPlMN8NHj5vk0zzq04BQog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeegucetufdoteggodetrfdotffvucfrrh
 hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 epfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushculfgv
 nhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnh
 epjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffffjeevnecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesih
 hrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:QRDXZeFZxRuHhDnu4zDSW_EvpmtQDMJdkjhnNMMVQRRMsYyTtfYxJA>
 <xmx:QRDXZSUvd1eHRXyesrReDKr66urrdQeXMP7EPQZQ0ZPn3EHIVWCmag>
 <xmx:QRDXZRPtHF_0qUda171wqwmWbz2TIN9pwuBM2gpwO8mQjDZPkbsWsA>
 <xmx:QRDXZdG_KMunmlC-aMXOJvLEFkfBH7NYx3RLLJ2ySllv_AD43j_m9A>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Feb 2024 04:13:36 -0500 (EST)
Date: Thu, 22 Feb 2024 10:13:30 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Nabih Estefan <nabihestefan@google.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 kbusch@kernel.org, roqueh@google.com
Subject: Re: [PATCH] hw/nvme/ns: Add NVMe NGUID property
Message-ID: <ZdcQOnW1G6nCYqH-@cormorant.local>
References: <20240221173853.1573034-1-nabihestefan@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9QHRZVwhrjmLGtfr"
Content-Disposition: inline
In-Reply-To: <20240221173853.1573034-1-nabihestefan@google.com>
Received-SPF: pass client-ip=103.168.172.152; envelope-from=its@irrelevant.dk;
 helo=fhigh1-smtp.messagingengine.com
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


--9QHRZVwhrjmLGtfr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 21 17:38, Nabih Estefan wrote:
> From: Roque Arcudia Hernandez <roqueh@google.com>
>=20
> This patch adds a way to specify an NGUID for a given NVMe Namespace usin=
g a
> string of hexadecimal digits with an optional '-' separator to group byte=
s. For
> instance:
>=20
> -device nvme-ns,nguid=3D"e9accd3b83904e13167cf0593437f57d"
>=20
> If provided, the NGUID will be part of the Namespace Identification Descr=
iptor
> list and the Identify Namespace data.
>=20
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>

Hi Thanks! Looks good,

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

Only a minor nit below.

> diff --git a/hw/nvme/nguid.c b/hw/nvme/nguid.c
> new file mode 100644
> index 0000000000..3e3e0567c5
> --- /dev/null
> +++ b/hw/nvme/nguid.c
> @@ -0,0 +1,192 @@
> +/*
> + *  QEMU NVMe NGUID functions
> + *
> + * Copyright 2024 Google LLC
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but W=
ITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/visitor.h"
> +#include "qemu/ctype.h"
> +#include "nvme.h"
> +
> +#define NGUID_SEPARATOR '-'
> +
> +#define NGUID_VALUE_AUTO "auto"
> +
> +#define NGUID_FMT              \
> +    "%02hhx%02hhx%02hhx%02hhx" \
> +    "%02hhx%02hhx%02hhx%02hhx" \
> +    "%02hhx%02hhx%02hhx%02hhx" \
> +    "%02hhx%02hhx%02hhx%02hhx"
> +
> +#define NGUID_STR_LEN (2 * NGUID_LEN + 1)
> +
> +bool nvme_nguid_is_null(const NvmeNGUID *nguid)
> +{
> +    int i;
> +    for (i =3D 0; i < NGUID_LEN; i++) {
> +        if (nguid->data[i] !=3D 0) {
> +            return false;
> +        }
> +    }
> +    return true;
> +}

Maybe just

	bool nvme_nguid_is_null(const NvmeNGUID *nguid)
	{
	    static NvmeNGUID null_nguid;
	    return memcmp(nguid, &null_nguid, sizeof(NvmeNGUID)) =3D=3D 0;
	}


--9QHRZVwhrjmLGtfr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmXXEDoACgkQTeGvMW1P
Del7LAf/VaQwP7xFj6IOMaSBMiYakWgEmwPaf/lYJgpkhHZE3wgRDwAzepCorbho
snr5jP/sdUC4cvErzzry3OEzWDe2khgqtC5B3N/fosv8f0t9DOoDa2OREm1pXCAy
QTBr5l68UkNfImr+r/zL7rkq3NvWfTn96dvtt5stZ1+30hQazHn8DpxmFfvmG2WU
68A2MDcvNsdSjcPK3PX4xs8acPh1ZAB9cx3Ub9Db8c0QDJuFEXp/Jc+28tNezSfG
Xv/5Ba43zDnu1IjXf1tNvd0IHDQgkqL8SzbNOGROPRwQa/8bnjMNAowTdbq2NxaC
73Vi7Jd2sLxxuop6HO5kYfyVec9MFw==
=uY8A
-----END PGP SIGNATURE-----

--9QHRZVwhrjmLGtfr--

