Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57301CA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrN4-0006OI-4r; Wed, 30 Sep 2026 06:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7264c68bd=Conor.Dooley@microchip.com>)
 id 1xBrMy-0006DV-L0; Wed, 30 Sep 2026 06:17:00 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7264c68bd=Conor.Dooley@microchip.com>)
 id 1xBrMw-0004Zl-Em; Wed, 30 Sep 2026 06:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1790763418; x=1822299418;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9boqTe+v2aXKx3hXyi1/nG06GNAD1Rknp4JzZk2sWQk=;
 b=baVf6QOoruNUxQyP8yul8Tr3hMz/SMgaFRymFjM5tpe1XnFsItFyRy5K
 lQCwnhEC4R9i+/EA0vbxFU/+gFYC93asNXG52AnL1TyICkDdVY1QAHjwY
 DPFerWdYrpEcyoG080T1pEzB4fYgdN/iVykEPGcMICjM72LbKErdv7VlZ
 dV+P6s6fszRubQzS1+iZSL2h44D5DXoifkv51SkB9DietrCc7bZlLd09Y
 YcJUW4CGRcGxxt7UVf3hImsoYOpd+GEfp0ssqG5DKtn9byYUV1q6/FUwk
 k/z6ROzfNTjx5lEgTcWOgsZeEZ77bH3J2xDsWsSplzZAXlA23XPAYFoEA w==;
X-CSE-ConnectionGUID: 0qD2XlbCSD2RCZqZFsAkDQ==
X-CSE-MsgGUID: Yx18vnZJR/m2cQ4c3xtDYA==
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
 d="asc'?scan'208";a="74573421"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 03:16:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 30 Sep 2026 03:16:55 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Wed, 30 Sep 2026 03:16:54 -0700
Date: Wed, 30 Sep 2026 11:15:35 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Bin Meng <bin.meng@processmission.com>
CC: QEMU <qemu-devel@nongnu.org>, Conor Dooley <conor@kernel.org>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Sebastian Huber
 <sebastian.huber@embedded-brains.de>, <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2 20/24] docs/system/riscv: Document Icicle Kit HSS boot
Message-ID: <20260930-disparity-announcer-a6bc30a7084c@wendy>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
 <20260904155758.3833179-21-bin.meng@processmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NwE48z+lYfehFyqX"
Content-Disposition: inline
In-Reply-To: <20260904155758.3833179-21-bin.meng@processmission.com>
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

--NwE48z+lYfehFyqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2026 at 11:57:39PM +0800, Bin Meng wrote:
> With all previous changes, the Icicle Kit model is now able to boot
> HSS v2024.06 through a Buildroot 2026.05 SD image to U-Boot and Linux.
>=20
> Document the tested source versions and exact commands to build HSS
> and Buildroot. Include the sparse resize and GPT relocation steps
> needed to make the generated SD image usable by QEMU.
>=20
> Also describe the RAM and serial setup, boot stages, and remaining
> model limitations.
>=20
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
>=20
> (no changes since v1)
>=20
>  docs/system/riscv/microchip-icicle-kit.rst | 101 +++++++++++++++++++--
>  1 file changed, 95 insertions(+), 6 deletions(-)
>=20
> diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/ris=
cv/microchip-icicle-kit.rst
> index 38352cc62b..eeb4ff938c 100644
> --- a/docs/system/riscv/microchip-icicle-kit.rst
> +++ b/docs/system/riscv/microchip-icicle-kit.rst
> @@ -19,12 +19,15 @@ The ``microchip-icicle-kit`` machine supports the fol=
lowing devices:
>  * 4 U54 cores
>  * Core Level Interruptor (CLINT)
>  * Platform-Level Interrupt Controller (PLIC)
> -* L2 Loosely Integrated Memory (L2-LIM)
> +* Loosely Integrated Memory (L2-LIM)
> +* L2 cache controller (L2CC)
>  * DDR memory controller
> +* System controller and system services mailbox
>  * 5 MMUARTs
>  * 1 DMA controller
>  * 2 GEM Ethernet controllers
>  * 1 SDHC storage controller
> +* 1 Real-Time Clock
> =20
>  The machine has a fixed 2 GiB of RAM. Other memory sizes are rejected.
>  The machine always exposes all five harts. Other CPU counts are rejected.
> @@ -101,10 +104,96 @@ CAVEATS:
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
> +
> +Configure HSS for the ``mpfs-icicle-kit-es`` board using its default
> +configuration. QEMU provides the software-visible registers and determin=
istic
> +status consumed by the HSS v2024.06 DDR initialization and training flow;
> +it does not model the electrical properties of DDR training. HSS requires
> +the RISC-V bare-metal toolchain supplied by Microchip SoftConsole to be
> +available in ``PATH``.  Build the tested HSS version with:

What's the reason that this is using 2024.06 by the way? Why not use the
most recent release of the HSS?

> +
> +.. code-block:: bash
> +
> +  $ git clone https://github.com/polarfire-soc/hart-software-services.git
> +  $ cd hart-software-services
> +  $ git checkout v2024.06
> +  $ make BOARD=3Dmpfs-icicle-kit-es defconfig
> +  $ make -j$(nproc) BOARD=3Dmpfs-icicle-kit-es
> +
> +The HSS build creates both the raw wrapper and an eNVM programming image=
=2E  QEMU
> +needs the complete eNVM image, including the 256-byte boot header added =
by the
> +Microchip boot mode programmer. Convert the generated Intel HEX file to =
a raw
> +binary image, for example:
> +
> +.. code-block:: bash
> +
> +  $ riscv64-unknown-elf-objcopy -I ihex -O binary \
> +      build/hss-envm-wrapper.mpfs-icicle-kit-es.hex build/hss.bin
> +
> +Do not pass ``build/hss-envm-wrapper.bin`` directly to QEMU. That file s=
tarts
> +at eNVM offset 0x100 and does not contain the boot header with the image=
 size
> +and per-hart reset vectors.

--NwE48z+lYfehFyqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarzhRwAKCRB4tDGHoIJi
0hzkAQCGX39jFeBVpyaXqTy8FjRkJYHrQOj+KwY3Zg09wmWzSgD+LaPWevV3cxko
/1woODrxW845rb+81YHlSMjFPntOwQ4=
=Jwnx
-----END PGP SIGNATURE-----

--NwE48z+lYfehFyqX--

