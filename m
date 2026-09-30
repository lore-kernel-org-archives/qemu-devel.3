Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96B6CA5FBE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBqzE-00070F-AG; Wed, 30 Sep 2026 05:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7264c68bd=Conor.Dooley@microchip.com>)
 id 1xBqzC-0006zr-GS
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 05:52:26 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7264c68bd=Conor.Dooley@microchip.com>)
 id 1xBqzA-00012h-U3
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 05:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1790761945; x=1822297945;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jREuYWMCR8C22dBVoUFUOZus+YmhGZEfkKZVUgg5Bgc=;
 b=FSCcWdrVhw1DPEGTwWVDCFSzgE+MZTXZ1DNDyHvi6+XQ0Wt0Zhd6gH/F
 sIKnL4w7HAayV9TwlIYzG/CUQ89SDgCR/5TZMCqIXRTokVNoqsdxlMjoq
 h3Mea6/bVTsx7HCUIo3JEcBEkSU8ziQ7bPXRlfIkjgKsVtOyq0uGZMj3T
 9DbHiVWMnrh7EWaG+jBoo7x7Fs7NJsSZs4SPhJtGxscp1EH2oQdK/H9bP
 EFOglne3bu9cHJ8byA9PzLQ6uLUuDIZ4OTgEznI8DX4Wy2C+cFXQLvEul
 ugCt/MTIoRO3382vjcn4e+gaODvz/2YT8IQN3D2IxKe3ky5RsiRZIYd3o w==;
X-CSE-ConnectionGUID: duuC/QXIR8WoAtJCqSPXiA==
X-CSE-MsgGUID: QseQuz59TsOZ+6MASNX2Zw==
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
 d="asc'?scan'208";a="64367731"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 02:52:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 30 Sep 2026 02:52:22 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Wed, 30 Sep 2026 02:52:21 -0700
Date: Wed, 30 Sep 2026 10:51:02 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Bin Meng <bin.meng@processmission.com>
CC: QEMU <qemu-devel@nongnu.org>, Conor Dooley <conor@kernel.org>, Markus
 Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 24/24] MAINTAINERS: Move Conor Dooley to PolarFire SoC
 reviewer
Message-ID: <20260930-slinky-reshape-41541a340ee9@wendy>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
 <20260904155758.3833179-25-bin.meng@processmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="paF0SHbZV5+HhgGF"
Content-Disposition: inline
In-Reply-To: <20260904155758.3833179-25-bin.meng@processmission.com>
Received-SPF: pass client-ip=68.232.153.233;
 envelope-from=prvs=7264c68bd=Conor.Dooley@microchip.com;
 helo=esa.microchip.iphmx.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--paF0SHbZV5+HhgGF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2026 at 11:57:43PM +0800, Bin Meng wrote:
> Conor asked not to be listed as a maintainer, since that could imply
> that Microchip sponsors his work on the platform.

Not an unreasonable assumption for people to make, given the status has
been changed in the previous patch to supported.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> Keep him listed as a reviewer so he continues to receive relevant
> patches without suggesting an active maintenance commitment.
>=20
> Suggested-by: Conor Dooley <conor@kernel.org>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>=20
> ---
>=20
> Changes in v2:
> - New patch
>=20
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e68e7eb12e..9590de2509 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1787,7 +1787,7 @@ F: tests/tcg/riscv64/test-crc32.S
> =20
>  Microchip PolarFire SoC Icicle Kit
>  M: Bin Meng <bin.meng@processmission.com>
> -M: Conor Dooley <conor@kernel.org>
> +R: Conor Dooley <conor@kernel.org>
>  M: Sebastian Huber <sebastian.huber@embedded-brains.de>
>  L: qemu-riscv@nongnu.org
>  S: Supported
> --=20
> 2.53.0
>=20
>=20

--paF0SHbZV5+HhgGF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarzbhQAKCRB4tDGHoIJi
0ia0AP48HsebRIX3BlVpIagZ9sg26khiNHB02esDGfWPO4RxXgD+JgreuJyZ0asf
YyK6R4F90cuA/o9hIrZoeBYWpU68VwQ=
=/Pyh
-----END PGP SIGNATURE-----

--paF0SHbZV5+HhgGF--

