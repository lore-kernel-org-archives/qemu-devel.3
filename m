Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57678C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ZPc-0004NZ-1J; Mon, 07 Sep 2026 09:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1x3ZPZ-0004MM-Ru; Mon, 07 Sep 2026 09:29:25 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1x3ZPX-0008EW-43; Mon, 07 Sep 2026 09:29:24 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 71C1E43E3E;
 Mon,  7 Sep 2026 13:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6541F00A3D;
 Mon,  7 Sep 2026 13:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788787759;
 bh=0t9xL962eoHzfQTVPINrp0LliqjObPfTvJyXN3o6ulM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lLtKmljxCHi3GMDXrWPxBbU8Vq075oSvzMaEp3TFtqUiMDsOTjfX3la2J1ttZweun
 OiUITt205emSfK8miuucBEMJOCTSmgoo8IRl4HNlha5nT1HRyPtkGvLlqB/JLzlU/Z
 PcWjTnbZpGN694YlF2cjpv4EeRwzt7vVsoUqT0gm6YJEauet7D/27dAvN5TRx9DV3z
 9sdif8G888SYO1lMezQmMxyd/dkmhxZUihRXPbFoWefetFMoBtFfk5ygqjBHuQ9Hg7
 1vJPhqZrSG0tfpxMYlMbkAmYToSDcl2sFhlLQNieoaSfoOpITEjd4qaEeY5vShncP9
 W6hIJuquwA6NQ==
Date: Mon, 7 Sep 2026 14:29:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>, Bin Meng <bmeng.cn@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Thomas Huth <thuth@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v2 00/24] hw/riscv: Restore Microchip PolarFire SoC
 Icicle Kit firmware boot
Message-ID: <20260907-cognition-happiness-822c3be7e45c@spud>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
 <7a6ef890-a630-46b3-aedf-a687fec487cc@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mXywBnsZ83DGzamE"
Content-Disposition: inline
In-Reply-To: <7a6ef890-a630-46b3-aedf-a687fec487cc@oss.qualcomm.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=conor@kernel.org; helo=sea.source.kernel.org
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

--mXywBnsZ83DGzamE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2026 at 06:11:38PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 4/9/26 17:57, Bin Meng wrote:
>=20
> > Bin Meng (23):
> >    hw/riscv: pfsoc: Correct the L2LIM maximum mapped size
> >    hw/riscv: pfsoc: Map the L2 zero device window
> >    hw/misc: pfsoc: Support DDR training with newer HSS
> >    hw/misc: pfsoc: Model L2 cache controller registers
> >    hw/riscv: pfsoc: Couple L2CC to L2-LIM
> >    tests/qtest: Add PolarFire SoC L2CC coverage
> >    hw/sd: sdhci: Run ADMA independently of MMIO
> >    hw/sd: sd: Keep high-capacity memory blocks at 512 bytes
> >    hw/sd: cadence: Add 64-bit system bus property
>=20
> FYI I tagged this series (in particular the SD/HCI patches)
> to review but won't be able to until Sept 21. Not a blocker
> although if Alistair think the series is ready.

FWIW, I'd like to look at the pfsoc parts but I am also indisposed
until the 21st.

>=20
> >    hw/riscv: pfsoc: Enable 64-bit SDHCI system bus support
> >    hw/misc: pfsoc: Model PolarFire SoC serial number service
> >    hw/rtc: Add PolarFire SoC RTC model
> >    hw/riscv: pfsoc: Add PolarFire SoC RTC to Icicle Kit
> >    tests/qtest: Add PolarFire SoC RTC coverage
> >    hw/misc: pfsoc: Honor PolarFire service notification requests
> >    hw/riscv: pfsoc: Correct PolarFire SoC DDR aliases
> >    hw/riscv: pfsoc: Fix Icicle Kit RAM size at 2 GiB
> >    hw/riscv: pfsoc: Fix Icicle Kit hart count at five
> >    docs/system/riscv: Document Icicle Kit HSS boot
> >    docs/system/riscv: pfsoc: Document CLINT topology for direct Linux
> >      boot
> >    tests/functional/riscv64: Add Icicle Kit firmware boot test
> >    MAINTAINERS: Add PolarFire SoC Icicle Kit maintainer
> >    MAINTAINERS: Move Conor Dooley to PolarFire SoC reviewer
>=20
>=20

--mXywBnsZ83DGzamE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCap68KAAKCRB4tDGHoIJi
0lhdAP91XDEzupVU41fGt+BpEjmihb++kxg0fc4nQkfx4XSDUQEA0ku4gqgn1dnO
Y5iJlMI9utsx6IMdO2tzUeYgVAH26AI=
=6ORC
-----END PGP SIGNATURE-----

--mXywBnsZ83DGzamE--

