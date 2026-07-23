Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9453C531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvNX-0003bO-ID; Thu, 23 Jul 2026 11:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>) id 1wmvNL-0003aK-6m
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 11:30:29 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>) id 1wmvNJ-0001jp-FR
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 11:30:18 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E872A4055B;
 Thu, 23 Jul 2026 15:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C28E1F00A3D;
 Thu, 23 Jul 2026 15:30:14 +0000 (UTC)
Date: Thu, 23 Jul 2026 16:29:57 +0100
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <th.huth@posteo.eu>
Subject: Re: [PATCH 26/26] MAINTAINERS: Add PolarFire SoC Icicle Kit maintainer
Message-ID: <20260723-oppressor-starfish-3c0b33776cc8@spud>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-27-bin.meng@processmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vFjFBUmjaPmWvCSr"
Content-Disposition: inline
In-Reply-To: <20260723151853.2143177-27-bin.meng@processmission.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=conor@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Reply-to:  Conor Dooley <conor@kernel.org>
From:  Conor Dooley via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--vFjFBUmjaPmWvCSr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 11:18:53PM +0800, Bin Meng wrote:
> The preceding Icicle Kit updates restore HSS, U-Boot, and Linux
> boot. Functional test coverage is also added.
>=20
> Restore myself as a maintainer and mark the machine as 'Supported'
> to reflect its active maintenance.
>=20
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>=20
> ---
>=20
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 800a2f31cd..9ed60d14a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1761,10 +1761,11 @@ F: target/riscv/xlrbr.decode
>  F: tests/tcg/riscv64/test-crc32.S
> =20
>  Microchip PolarFire SoC Icicle Kit
> +M: Bin Meng <bin.meng@processmission.com>
>  M: Conor Dooley <conor@kernel.org>

If you're doing this, please drop me back to just being a reviewer. I
don't want to give people a false impression that Microchip is paying me
to work on maintaining the platform.

Your return itself is=20
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>  M: Sebastian Huber <sebastian.huber@embedded-brains.de>
>  L: qemu-riscv@nongnu.org
> -S: Odd Fixes
> +S: Supported
>  F: docs/system/riscv/microchip-icicle-kit.rst
>  F: hw/riscv/microchip_pfsoc.c
>  F: hw/char/mchp_pfsoc_mmuart.c
> --=20
> 2.34.1
>=20
>=20

--vFjFBUmjaPmWvCSr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamIzdQAKCRB4tDGHoIJi
0hNtAP4pTFYe3bbBvEceywOmANMkjl/t4XNCosvmdZkFdU/jrQD/b00cS/SRuCax
6uHuo0zIPiXyEzUqazKE4CrTROQI6Ag=
=RxF1
-----END PGP SIGNATURE-----

--vFjFBUmjaPmWvCSr--

