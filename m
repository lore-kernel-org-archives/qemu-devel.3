Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6184CCA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJmF-0000dL-JF; Mon, 12 Oct 2026 13:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1xGJmD-0000cA-2T; Mon, 12 Oct 2026 13:25:29 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1xGJmB-0001md-5R; Mon, 12 Oct 2026 13:25:28 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 216A043929;
 Mon, 12 Oct 2026 17:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD5C1F0089B;
 Mon, 12 Oct 2026 17:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791825923;
 bh=GlgzHk6lBqYRVt9kvsS750ANy+S/ktfzU9rWOqrS8j4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IqfpQUy+whXAk2uj9jh1nzqavoYFe10o1iw6uzDto4ywooqYIyzocf8ivr4KxdRt+
 yK918O+150msMZGdDbNu2XVT5DSlMbkhkZezUM/kKEeSch47g9DjK/nygS38hOCWEF
 2+aKZeAvZTP0IH9GXkh39DhreIwiabzeKGqg71YF7UbyLV0VDEznknvE8PP/e5YosD
 4MgxrYvAGIt9xpBUmHq5hTmiMnaJMplFVZ+x5CBq/Vh9xHXNKivBv9YBoxY3ZCcs99
 SFa7uKe9dwpo4IbE4QuI5CTA/yRUK1wm3XqGIrC29iOh8CbH+QBd0Rlz4c7JM3jnJA
 Ipm5xa2EVNfaA==
Date: Mon, 12 Oct 2026 18:25:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>, Bin Meng <bmeng.cn@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Thomas Huth <th.huth@posteo.eu>, Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 00/27] hw/riscv: Restore Microchip PolarFire SoC
 Icicle Kit firmware boot
Message-ID: <20261012-evasive-constant-57bc85edf1d9@spud>
References: <20261003170232.2450916-1-bin.meng@processmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y5BO9IpI+dz1AkEx"
Content-Disposition: inline
In-Reply-To: <20261003170232.2450916-1-bin.meng@processmission.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=conor@kernel.org;
 helo=sea.source.kernel.org
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

--y5BO9IpI+dz1AkEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 04, 2026 at 01:01:50AM +0800, Bin Meng wrote:
> The microchip-icicle-kit machine was originally validated with an older
> Hart Software Services (HSS) firmware stack. HSS v2024.06 cannot boot
> through U-Boot to Linux because several firmware-visible parts of the
> PolarFire SoC are missing or incomplete.
>=20
> The first failure occurs before the UART is initialized because the L2
> zero window is not mapped. HSS then needs additional L2 cache controller
> and DDR training behavior. Later boot stages exercise system services,
> the RTC, SDHC version 4 DMA, and high-capacity SD card block sizing,
> along with the complete DDR aliases. The existing models ither reject
> these accesses or expose behavior that does not match the hardware
> specifications.
>=20
> This series restores the complete firmware boot flow. With these
> changes, QEMU boots the HSS v2024.06 eNVM image, loads its U-Boot
> payload from an SD card, and reaches the Buildroot 2026.05 Linux
> login prompt.
>=20
> The changes are organized around the firmware boot sequence:
>=20
> * Correct the L2-LIM size, map the L2 zero window, and provide the DMC
>   status transitions required by HSS DDR initialization.
> * Model the documented L2CC Config, WayEnable, and WayMask registers,
>   and resize L2-LIM as cache ways are enabled.
> * Complete SDHCI version 4 support used by the Cadence controller,
>   including Host Control 2, SDMA system addressing, 64-bit ADMA2
>   descriptors, and SDMA boundary continuation.
> * Run ADMA from a bounded timer-driven engine instead of performing work
>   from command or unrelated MMIO accesses.  This keeps DMA progress
>   independent of guest register traffic and avoids consuming a polling
>   deadline inside the command write.
> * Keep SDHC and SDXC memory transfers at their fixed 512-byte block
>   size, and advertise the Cadence controller's 64-bit system bus
>   support.
> * Add the PolarFire SoC serial-number system service and RTC, and honor
>   the system-service notification control bit.
> * Correct the DDR aliases and fix the board topology at its physical
>   configuration of 2 GiB of RAM and five harts.
> * Document direct and HSS boot, add focused qtests and a full firmware
>   functional test, and restore the machine's Supported maintainer
>   status.
>=20
> Testing performed:
>=20
> * Built qemu-system-riscv64 and the documentation.
> * Passed various newly added qtests.
> * Booted HSS v2024.06, U-Boot, and Buildroot 2026.05 Linux to the login
>   prompt using the functional-test image.
>=20
> The functional test uses the processmission/qemu-machine-images release
> v1.0.0 tarball:
>=20
> https://github.com/processmission/qemu-machine-images/releases/download/
> v1.0.0/riscv64-microchip-icicle-kit-v1.0.0.tar.zst
>=20
> When restoring the HSS boot support, 3 potential bugs were identified in
> the upstream HSS source codes that either blocks the DDR training from
> succeed or traps in a multi-core race at the very beginning or after
> a succesfully DDR training but stuck at OpenSBI/U-Boot hand-off. There
> are already bug reports filed aginst various upstream projects.

Due to post conference busy-ness, I'm not entirely sure when I'll get to
provide a review on this, but for now
Tested-by: Conor Dooley <conor.dooley@microchip.com> # with 2026.04.1 HSS +=
 provided sdcard.img

Thanks,
Conor.

--y5BO9IpI+dz1AkEx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas0X/AAKCRB4tDGHoIJi
0rBCAQDKoQPomJWCVV6MNfXvxGBe2r013pdb3CpfnF6aBjYMQwEAgd1aDFlJfewJ
WdYFIUknMjVc+vFDgXbeDfeeIueXtgA=
=/dfT
-----END PGP SIGNATURE-----

--y5BO9IpI+dz1AkEx--

