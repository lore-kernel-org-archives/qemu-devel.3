Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8F1C5478A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLrj-000857-QP; Tue, 20 Feb 2024 03:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1rcLrh-00084e-MV
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:52:37 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1rcLrd-00086Y-KL
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202312; t=1708419145;
 bh=KGpTTcJcL20VD0cldH8sAd82gsL6xI9iR5IB0iV1KrM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MYQifJP3Vl5zS8u9c8MYh9qoXRV7qYAkG1cRUoKlW5H5dhGaNtcwsAINFJxa5+bd6
 uZv7Mk0R1wdx7LALgWQyARRMs3o1rhKItCfXhH/x7MiJqBBgsUgAL0VKP8BVkiypr+
 K5ue3YgG+F0it/ka68Xd5dhXopivSlhilq1ZoqynXY7Vbiu/ifdwxFsRYGXumv+6le
 r/IY3WHCuCCoQpTI24RHBo+J0SlfLV4MpWv6pfjNKsOcE2WnIJcEz0Jq2q5W4MUNNR
 Tch5LWb0T8YnC3g96hUPHuDnj9IHhwlmv/cd1O1g+L7QCsqiaA+TXoluRz9b/088qx
 O5A/FqvsgR/QA==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4TfCpK3D2Kz4wc1; Tue, 20 Feb 2024 19:52:25 +1100 (AEDT)
Date: Tue, 20 Feb 2024 19:52:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Remove myself as reviewer from PPC
Message-ID: <ZdRoQ9raWA_E4JQL@zatzit>
References: <20240220080956.1341831-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PEIdreqfGdDSrFoJ"
Content-Disposition: inline
In-Reply-To: <20240220080956.1341831-1-clg@kaod.org>
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--PEIdreqfGdDSrFoJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 09:09:56AM +0100, C=E9dric le Goater wrote:
> PPC maintainership has been a side activity for the last 2 years and
> it is time to let go some of it now that Nick has taken over.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Thanks for all your contributions C=E9dric.

> ---
>  MAINTAINERS | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a74d73960c0a..f5a4e4745c92 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -316,7 +316,6 @@ F: tests/tcg/openrisc/
>  PowerPC TCG CPUs
>  M: Nicholas Piggin <npiggin@gmail.com>
>  M: Daniel Henrique Barboza <danielhb413@gmail.com>
> -R: C=E9dric Le Goater <clg@kaod.org>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: target/ppc/
> @@ -468,7 +467,6 @@ F: target/mips/sysemu/
>  PPC KVM CPUs
>  M: Nicholas Piggin <npiggin@gmail.com>
>  R: Daniel Henrique Barboza <danielhb413@gmail.com>
> -R: C=E9dric Le Goater <clg@kaod.org>
>  S: Odd Fixes
>  F: target/ppc/kvm.c
> =20
> @@ -1502,7 +1500,6 @@ F: tests/avocado/ppc_prep_40p.py
>  sPAPR (pseries)
>  M: Nicholas Piggin <npiggin@gmail.com>
>  R: Daniel Henrique Barboza <danielhb413@gmail.com>
> -R: C=E9dric Le Goater <clg@kaod.org>
>  R: David Gibson <david@gibson.dropbear.id.au>
>  R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>  L: qemu-ppc@nongnu.org

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PEIdreqfGdDSrFoJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmXUaDcACgkQzQJF27ox
2GdJcBAAgxI9OMmUCuLoq74wPUO/TAPiMJWiLUvcGv9yxz1erukqksacce9fs8Sp
wkAVGpNihVqieOp4hZwUX6aLVvXDFdRTFonrte/ZMFq09JnCDhEqHjJk0tLByHDq
oA/Qz9/9/xn9ZVQ08No/2r5vOp3gGXRY46Cc3qNED90lnu9M3sXq17VA9Az8Lx4t
0GQEm0KFh8Tny+0f9p3jiLTAzqGWT39VfeG5rDQ8uD1PTlZvi7k6tkpmEfh83rfX
mmNohtsGcCYX6+DURWqOMRV/IWyvQXOprneChMOOFVAehLtLOOrLAcP9mRJg70xX
v7y3t+WixF+ISGNKD2DbkjX3nUI/NPLN9uRQInaKjQFtM2QOoVLyoYT7moEBfcz0
FmnzutHsgQtE2vnsfwgvgyt4j3kSNG7CQN+GF9kyeqdrODa0nJ/69CCS63JLhjMk
YWQLPPKcTZWeMJJikUpgb3ITNXyQHBRNK650WbYPfW1pFsN8ShIlBWX/vcPjUHGH
5PvoTRhCTFwtDsRt/a2bHr0g1D9UGHX+gFMCDDVZ7rT9K6ZQ1HYYY10+8g37krvZ
VACDppjRk243DcMa0kg8ioFdiA20uk6aIHcHy4erPPgvUSOl53+ZPIDkWHK7Y+EK
Bpvt5wqgWErlS9yRF+AQ7CthPSEw86M7JDQBcLy3EA/mURWUb5k=
=at2D
-----END PGP SIGNATURE-----

--PEIdreqfGdDSrFoJ--

