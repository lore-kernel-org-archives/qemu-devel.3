Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC9ACA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOk3-0007kJ-2Q; Wed, 07 Oct 2026 06:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1xEOjw-0007jb-Cj; Wed, 07 Oct 2026 06:19:14 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1xEOju-0005dC-Fl; Wed, 07 Oct 2026 06:19:12 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E295601FB;
 Wed,  7 Oct 2026 10:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321361F0089B;
 Wed,  7 Oct 2026 10:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791368347;
 bh=gfSmDP0g5TyGmbGURJWb2wAR+xSGMJgUJ6w15j9EBSk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EO2MzxS0T/gux4PpEl8i3RGFnWNB3Bqs3KIe6+XWQYBFV23rAVxneiEpxFvTWi6WK
 9nNdbL1GMAk/hb3Y8eRd5pUesfH1wrH2UsYYrD7sDQItyhyz3OlqB+cVnzsZKdcAEi
 X90r984BOJSeDfdRuRHehynq0hBLCzmHAiSTH3wVAnuO0QxeOVAGtVT1VaeM3sisd6
 LKA+uTy35sLWq7i2LpNUy6jou92WSzCcPbXsbHuLWgbkiqmD5KJ/kBn4Gvfjk0bJeW
 JnJQLfGF2MT+7R0SdEQPJQsBUYRCnP+F7b/qJMqYfTRPiqh8qMOByz2PCH+pQyf3lQ
 hktWCiljAp5dg==
Date: Wed, 7 Oct 2026 11:19:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 23/27] docs/system/riscv: Document Icicle Kit HSS boot
Message-ID: <20261007-5d77f819ba9b7157c5d9c837@squawk>
References: <20261003170232.2450916-1-bin.meng@processmission.com>
 <20261003170232.2450916-24-bin.meng@processmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SRkHVF/e2R5rUuOv"
Content-Disposition: inline
In-Reply-To: <20261003170232.2450916-24-bin.meng@processmission.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=conor@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

--SRkHVF/e2R5rUuOv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 04, 2026 at 01:02:13AM +0800, Bin Meng wrote:
> With all previous changes, the Icicle Kit model is now able to boot
> HSS v2024.06 through a Buildroot 2026.05 SD image to U-Boot and Linux.
>=20
> Document the tested source versions and exact commands to build HSS
> and Buildroot. Include the sparse resize and GPT relocation steps
> needed to make the generated SD image usable by QEMU.
>=20
> Explain the pinned firmware baseline and include the DDR pattern-test
> patch used by the versioned test image. Document the tool check needed
> for image-only builds and distinguish the DDR training failure from
> the two investigated multi-hart startup races. Describe their visible
> symptoms, affected source versions, and all three DTB supply paths.
>=20
> Also describe the RAM and serial setup, boot stages, and remaining
> model limitations. The official HSS v2026.04.1 eNVM image was
> also verified to reach the Linux login prompt with the same SD
> image, while the functional test keeps its versioned baseline.
>=20
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>=20
> ---
>=20
> Changes in v3:
> - Include the DDR pattern-test patch used by the functional-test image
> - Document the image-only FPGA programming tool check
> - Describe startup-race symptoms and link the firmware investigations
>=20
>  docs/system/riscv/microchip-icicle-kit.rst | 130 ++++++++++++++++++++-
>  1 file changed, 124 insertions(+), 6 deletions(-)
>=20
> diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/ris=
cv/microchip-icicle-kit.rst
> index 138289a913..9fde3f1073 100644
> --- a/docs/system/riscv/microchip-icicle-kit.rst
> +++ b/docs/system/riscv/microchip-icicle-kit.rst
> @@ -19,12 +19,14 @@ The ``microchip-icicle-kit`` machine supports the fol=
lowing devices:
>  * 4 U54 cores
>  * Core Level Interruptor (CLINT)
>  * Platform-Level Interrupt Controller (PLIC)
> -* L2 Loosely Integrated Memory (L2-LIM)
> +* L2 cache controller, including L2-LIM and L2-Zero windows
>  * DDR memory controller
> +* System controller and system services mailbox
>  * 5 MMUARTs
>  * 1 DMA controller
>  * 2 GEM Ethernet controllers
>  * 1 SDHC storage controller
> +* 1 Real-Time Clock
> =20
>  The machine has a fixed 2 GiB of RAM. Other memory sizes are rejected.
>  The machine defaults to all five harts. ``-smp`` may select two to five =
harts,
> @@ -103,10 +105,126 @@ CAVEATS:
>  Running HSS
>  -----------
> =20
> -The machine ``microchip-icicle-kit`` used to run the Hart Software Servi=
ces
> -(HSS_), however, the HSS development progressed and the QEMU machine
> -implementation lacks behind.  Currently, running the HSS no longer works.
> -There is missing support in the clock and memory controller devices.  In
> -particular, reading from the SD card does not work.
> +The ``microchip-icicle-kit`` machine can boot the Hart Software Services
> +(HSS_), which then loads an HSS payload containing U-Boot from an SD car=
d.
> +The following flow was tested with HSS v2024.06 and Buildroot 2026.05.


As I said on the v2, I think this should be much more recent, I tried
2026.04 on top of your series and it seemed to work fine.

--SRkHVF/e2R5rUuOv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasYclwAKCRB4tDGHoIJi
0hbgAP9cuIkXYc6wQSyQ/WM/53IvFd4NiZEqcVFzbhx/YB1+ZAD+LMZpoJJWmmRM
oLrYAdR6Becner9VPfVTe9Yzf7XjxgQ=
=INlq
-----END PGP SIGNATURE-----

--SRkHVF/e2R5rUuOv--

