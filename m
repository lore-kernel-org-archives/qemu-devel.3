Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64990C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 21:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj21E-0004Lx-FK; Sun, 12 Jul 2026 17:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wj214-0004Ll-2P; Sun, 12 Jul 2026 17:47:14 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wj212-0007Rj-FH; Sun, 12 Jul 2026 17:47:13 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E9C3D42D55;
 Sun, 12 Jul 2026 21:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398041F000E9;
 Sun, 12 Jul 2026 21:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783892823;
 bh=AH9sHZqiZnrU64VKuEgL1kJNEloFav+z0XsixA3WpHE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UXTIhlP/SMqtLO6BnHatS4tCUYuMr1/LHoW71t5zvAYupULuFondRMGjYYGE/SsFV
 CxMNv/BNGD+djyFZYeMWwnosXtouOWkEzUkuHdVTaVmqNAYn0IcaxHtfpPF4Q6JfEb
 SQz7c1F/nlgGe1tu4cpwFM0eoglicDqIL/3ny+ria2ybAi7NAm9M12OpYl0HfPrKLp
 OLubbC5Xna2690lOBjX4hKOeT/tiWlgyrF2Y4+eQMOu99CoHLQUjtf4RQOYSlBC5Ct
 fPPgwD95f6cOJ3WxbjCqQZpCOQuQ4Tamc5bzOdmrfqHYfC4tW88k/EYDElXRPaOtaq
 ejxtuaANKLuZg==
Date: Sun, 12 Jul 2026 22:47:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, qemu-riscv@nongnu.org,
 bin.meng@processmission.com, mzamazal@redhat.com, mst@redhat.com,
 sgarzare@redhat.com
Subject: Re: [PATCH 1/2] MAINTAINERS: Mark "Microchip PolarFire SoC Icicle
 Kit" orphaned
Message-ID: <20260712-divided-cork-204b87d9651a@spud>
References: <20260710114305.2961898-1-armbru@redhat.com>
 <20260710114305.2961898-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RD9QCCXpaqjQxBKL"
Content-Disposition: inline
In-Reply-To: <20260710114305.2961898-2-armbru@redhat.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=conor@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--RD9QCCXpaqjQxBKL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 01:43:04PM +0200, Markus Armbruster wrote:
> Commit 4a16a1a7ad (MAINTAINERS: Remove Bin Meng from RISC-V
> maintainers, 2025-01-28) removed the only M:, but left S: Supported.
> This makes no sense.  Downgrade to S: Orphan.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 576ef6fff5..aa2df9cbe3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1761,7 +1761,7 @@ F: tests/tcg/riscv64/test-crc32.S
> =20
>  Microchip PolarFire SoC Icicle Kit
>  L: qemu-riscv@nongnu.org
> -S: Supported
> +S: Orphan

This should have been updated in:
https://lore.kernel.org/qemu-devel/20260513023859.518484-1-alistair.francis=
@wdc.com/

Alistair said he applied that patch, so I'm guessing whatever tree you've
based on doesn't include it yet?

Cheers,
Conor.

>  F: docs/system/riscv/microchip-icicle-kit.rst
>  F: hw/riscv/microchip_pfsoc.c
>  F: hw/char/mchp_pfsoc_mmuart.c
> --=20
> 2.54.0
>=20
>=20

--RD9QCCXpaqjQxBKL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCalQLUwAKCRB4tDGHoIJi
0nZuAQCbpwmWA1uUKpMkeqvcSrahJgm1U8IhPJgYFUIACDYw7wD/XdsCT1xDOb87
9RCsMsmPyBu247FaA99peru1u5M5aQw=
=URx1
-----END PGP SIGNATURE-----

--RD9QCCXpaqjQxBKL--

