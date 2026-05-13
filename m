Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53706CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 19:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNF71-0002dD-58; Wed, 13 May 2026 15:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wNF6i-0002cP-BU; Wed, 13 May 2026 15:19:00 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wNF6g-0006Wq-H5; Wed, 13 May 2026 15:19:00 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 98690600AE;
 Wed, 13 May 2026 19:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF97C19425;
 Wed, 13 May 2026 19:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778699933;
 bh=X2YLTt9fRik+V2qElmFWqPJU1fN8M6c846oFcyLIxRM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vES12sr/ZOJnhDhfFnKSnNGDJMlSCyNOd8FlS8+fZ3d+v/O0cXQhH/7LKkCE3thM6
 ERmYxfW3adBEhKUpC8OZ41FY6/8h1ZfXqWZRFDi6oUOK1zWVyA/0BjiUhsYi6RHS34
 2seKEq3Pacy6dOT562qIWBGHN+EOFkuwldO/fmUAlMdvSwi3y/eoC/yXH0hmIuzEfz
 GnHturSzMe3j2EYF6R98VwOCNLdWTfoqyuWw84oxmE4R5OfbLSAJ4+D1opRTVh4FnA
 MfCP7qEcwMsvnqPLTJp2PVSRc6bRQxBLARfEOfu46UGoDG+cO85ZBGoDPKdB6XcPF+
 LQgxxHkltKeqg==
Date: Wed, 13 May 2026 20:18:49 +0100
From: Conor Dooley <conor@kernel.org>
To: alistair23@gmail.com
Cc: palmer@dabbelt.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, sebastian.huber@embedded-brains.de,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] MAINTAINERS: Mark Microchip PolarFire SoC as Odd Fixes
Message-ID: <20260513-karaoke-richly-bf92412e0ad8@spud>
References: <20260513023859.518484-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cGOVApgztEMLBplK"
Content-Disposition: inline
In-Reply-To: <20260513023859.518484-1-alistair.francis@wdc.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=conor@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--cGOVApgztEMLBplK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 12:38:59PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Mark the "Microchip PolarFire SoC Icicle Kit" as Odd Fixes and enlist
> Conor and Sebastian as people to help deal with the fixes.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> Conor let me know if it should be a different address
>=20
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 952ed683bb..9626eb1ea9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1751,8 +1751,10 @@ F: target/riscv/xlrbr.decode
>  F: tests/tcg/riscv64/test-crc32.S
> =20
>  Microchip PolarFire SoC Icicle Kit
> +M: Conor Dooley <conor@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> +M: Sebastian Huber <sebastian.huber@embedded-brains.de>
>  L: qemu-riscv@nongnu.org
> -S: Supported
> +S: Odd Fixes
>  F: docs/system/riscv/microchip-icicle-kit.rst
>  F: hw/riscv/microchip_pfsoc.c
>  F: hw/char/mchp_pfsoc_mmuart.c
> --=20
> 2.53.0
>=20
>=20

--cGOVApgztEMLBplK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagTOmAAKCRB4tDGHoIJi
0kA8AP4no0VjS4dpNNC+A+3j1War5xy1rkamoegVsSmnNMXKrwD5AbLjXxoTPRnU
afz7yjvHmAcEh5CWUQ1O3dw9GJ1wJAs=
=k9Qz
-----END PGP SIGNATURE-----

--cGOVApgztEMLBplK--

