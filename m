Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592B2C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 18:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlBKG-0004cc-PZ; Thu, 20 Feb 2025 13:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1tlBK9-0004bx-T9; Thu, 20 Feb 2025 13:31:06 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1tlBK7-0004ku-2s; Thu, 20 Feb 2025 13:31:01 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2CE015C5EE1;
 Thu, 20 Feb 2025 18:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1B8C4CED1;
 Thu, 20 Feb 2025 18:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740076247;
 bh=/kdP9buAZx0vOLae4NGdTxhcSmc0oF/S0NLyr7tEZVE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=shyMGgVTj/INHQkycl0PhcEGCckj+Y8bOCbd14cb5Zz+UzX8EYSH1NRsl+/NF+yin
 5pjCIl0BbjT3kc1fwXjeL73ojXuJtaIvee0L9/swDaqMuNtgH0YdfaOAInahixWgon
 d+9gye+dMfoq6J81HkSvomi0xLs3XHsofBOja2kCfGwKG3Ah7VW0a3KYJVYHXKAtKZ
 yJYms079O1v9aeo7uuiRslC3Jio8XDNK17my093pq6reR8HO4PwY4BsqLExJQIcCts
 22EK37t1j1yuTFg+tt1aDR1IY1GkA6Wuz1O5e6jlLiSmrd7k950opUV27uhzkHsnjz
 f+AOkO5yKRV9Q==
Date: Thu, 20 Feb 2025 18:30:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, Conor Dooley <conor.dooley@microchip.com>,
 Bin Meng <bin.meng@windriver.com>, alistair.francis@wdc.com,
 qemu-riscv@nongnu.org
Subject: Re: [PATCH 0/5] Improve Microchip Polarfire SoC customization
Message-ID: <20250220-reggae-hardness-907e385516d8@spud>
References: <20250214062443.9936-1-sebastian.huber@embedded-brains.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4TOzEZfzET3VZRIz"
Content-Disposition: inline
In-Reply-To: <20250214062443.9936-1-sebastian.huber@embedded-brains.de>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=conor@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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


--4TOzEZfzET3VZRIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+cc qemu-riscv, Alistar.

On Fri, Feb 14, 2025 at 07:24:37AM +0100, Sebastian Huber wrote:
> Booting the microchip-icicle-kit machine using the latest PolarFire SoC
> Hart Software Services (HSS) no longer works since Qemu lacks support
> for several registers (clocks, DRAM controller). Also reading from the
> SDCard does not work currently.

On that note, I think the inaccurate docs about polarfire should be
removed. There's a wiki page here with dead links, or links to things
that do not work anymore:
https://wiki.qemu.org/Documentation/Platforms/RISCV#Microchip_PolarFire_SoC=
_Icicle_Kit
I think the whole section should be removed, find it kinda odd that
there's a polarfire section but not for any other board. Either way,
it's talking about something that just does not work, the current HSS
and Yocto don't boot.

There's also a docs page here:
https://www.qemu.org/docs/master/system/riscv/microchip-icicle-kit.html
that has a copy of the table your patch 4 modifies, that probably should
be updated to match your changes.

In a similar vein to the wiki, it talks about the HSS and booting a
yocto wic image. I think those should be deleted since they don't work.

Alistar/Other RISC-V folks, what do you think? Bin wrote the port but
seems to be AFK and I don't have the capacity to fix any of that stuff
on top of what I already do in my spare time - do you agree that
deleting the now inaccurate docs makes sense?

> In order to allow tests runs for real-time kernels such as RTEMS and
> Zephyr, improve the boot customization. This patch set enables a direct
> run of kernel executables, for example:
>=20
> qemu-system-riscv64 -no-reboot -nographic \
>   -serial null -serial mon:stdio \
>   -smp 2 \
>   -bios none \
>   -machine microchip-icicle-kit,clint-timebase-frequency=3D10000000 \
>   -kernel rtos.elf

The series breaks my usage:
qemu//build/qemu-system-riscv64 -M microchip-icicle-kit \
        -m 3G -smp 5 \
        -kernel vmlinux.bin \
        -dtb riscvpc.dtb \
        -initrd initramfs.cpio.gz \
        -display none -serial null \
        -serial mon:stdio \
        -D qemu.log -d unimp
opensbi-riscv64-generic-fw_dynamic.bin: No such file or directory
qemu-system-riscv64: could not load firmware 'opensbi-riscv64-generic-fw_dy=
namic.bin'
make: *** [Makefile:305: qemu-icicle] Error 1

Figure it is likely to be your patch 4? The file does exist, so probably
some sort of path-to-it issues?

Cheers,
Conor.

>=20
> Sebastian Huber (5):
>   hw/misc: Add MPFS system reset support
>   hw/riscv: More flexible FDT placement for MPFS
>   hw/riscv: Make FDT optional for MPFS
>   hw/riscv: Allow direct start of kernel for MPFS
>   hw/riscv: Configurable MPFS CLINT timebase freq
>=20
>  hw/misc/mchp_pfsoc_sysreg.c        |   7 ++
>  hw/riscv/microchip_pfsoc.c         | 147 +++++++++++++++++++++--------
>  include/hw/riscv/microchip_pfsoc.h |   1 +
>  3 files changed, 115 insertions(+), 40 deletions(-)
>=20
> --=20
> 2.43.0
>=20
>=20

--4TOzEZfzET3VZRIz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7d00wAKCRB4tDGHoIJi
0rYeAQDn/T624NmD2Hb6Tqh5ByLemQApLlpP/8c6kqNXyVbf/QEA+2XDoO7yn78J
fwah4EFrkAzooSlLViXFFTdw0U1nJAQ=
=U9GY
-----END PGP SIGNATURE-----

--4TOzEZfzET3VZRIz--

