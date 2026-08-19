Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CFAC5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTly-0007rD-2h; Tue, 18 Aug 2026 20:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1wwTlv-0007qS-Of; Tue, 18 Aug 2026 20:03:11 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1wwTls-0005kv-LX; Tue, 18 Aug 2026 20:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1787097782;
 bh=2SQk7T/GNP1Yf1sN+B13EFNV8udy89ysNTcGihRxD5Q=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=M9Djp+YLkGghgA5FSHBBNcLr3JUgTUoeSiIXlloXDTvnka/8A80KzyM0r8DodJ8E6
 ih+t8YnpZgQyqMMjkM2lwk4iDIWP82VAWib1yAFBaFoTv2doc0yMHyc2IsBA0HOQmS
 4HoSZjtde9MDeevqJZGQevw1F5a5zVuU2/drVUXTExUnSIQlpVzvL5w9Y+iHCMRiF3
 vSLLvLTvyzGhiyGQ8ALAbgm+/yU2pne5vRVpO36tjLyz8LVN8dOGkoqJg1LkVrD8js
 XqjyzAqyz9oigWlh7w9ArcZgZW1KPfTd/3UUh2Bd+oZzwtpfGy1pxBTldNYhSUKhX0
 DM7oLls3xxXjg==
Received: from [192.168.68.117] (unknown [180.150.113.112])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 07CFB6490E;
 Wed, 19 Aug 2026 08:03:00 +0800 (AWST)
Message-ID: <6531a80710d4b2163605b7d44747189a7ab58dbf.camel@codeconstruct.com.au>
Subject: Re: [PATCH] hw/misc/aspeed_scu: Set both AST2600 protection key
 registers on reset
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Steven Lee	
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin	
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, Joel
 Stanley	 <joel@jms.id.au>, qemu-arm@nongnu.org
Date: Wed, 19 Aug 2026 09:32:57 +0930
In-Reply-To: <98572f2f-cb08-45c5-aaf6-749db2a2611b@kaod.org>
References: <20260818-dev-ast2600-hw-prot-key-reset-v1-1-5dc3de64c247@codeconstruct.com.au>
 <98572f2f-cb08-45c5-aaf6-749db2a2611b@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Tue, 2026-08-18 at 23:20 +0200, C=C3=A9dric Le Goater wrote:
> On 8/18/26 03:43, Andrew Jeffery wrote:
> > Currently, booting Linux on the ast2600-evb machine via -kernel results
> > in a lot of warnings about failing to apply pinmux configuration when
> > binding drivers:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 7.339307][=C2=A0=C2=A0=C2=
=A0 T1] Creating 5 MTD partitions on "bmc":
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 7.340402][=C2=A0=C2=A0=C2=
=A0 T1] 0x000000000000-0x0000000e0000 : "u-boot"
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 7.513755][=C2=A0=C2=A0=C2=
=A0 T1] 0x0000000e0000-0x000000100000 : "u-boot-env"
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 7.664219][=C2=A0=C2=A0=C2=
=A0 T1] 0x000000100000-0x000000a00000 : "kernel"
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 7.826974][=C2=A0=C2=A0=C2=
=A0 T1] 0x000000a00000-0x000002a00000 : "rofs"
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 8.026666][=C2=A0=C2=A0=C2=
=A0 T1] 0x000002a00000-0x000004000000 : "rwfs"
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 8.201612][=C2=A0=C2=A0=C2=
=A0 T1] spi-aspeed-smc 1e630000.spi: error -EPERM: Error applying setting, =
reverse things back
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 8.370835][=C2=A0=C2=A0=C2=
=A0 T1] spi-aspeed-smc 1e630000.spi: Calibration area too uniform, using lo=
w speed
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 8.371131][=C2=A0=C2=A0=C2=
=A0 T1] spi-aspeed-smc 1e630000.spi: Force to dts configuration 100000kHz.
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 8.371500][=C2=A0=C2=A0=C2=
=A0 T1] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:4 [0x406c0741]
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 8.766797][=C2=A0=C2=A0=C2=
=A0 T1] mdio-aspeed 1e650000.mdio: error -EPERM: Error applying setting, re=
verse things back
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 8.906008][=C2=A0=C2=A0=C2=
=A0 T1] mdio-aspeed 1e650008.mdio: error -EPERM: Error applying setting, re=
verse things back
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 9.039240][=C2=A0=C2=A0=C2=
=A0 T1] mdio-aspeed 1e650010.mdio: error -EPERM: Error applying setting, re=
verse things back
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 9.147942][=C2=A0=C2=A0=C2=
=A0 T1] mdio-aspeed 1e650018.mdio: error -EPERM: Error applying setting, re=
verse things back
> >=20
> > The pinmux configuration fails because the SCU is not unlocked.
> >=20
> > Set both SCU protection keys for the AST2600. Further, set them
> > such that they behave accordance with the read value documented
> > by the datasheet. The new arrangement now upholds the comment in
> > hw/arm/aspeed.c regarding passing -kernel on the qemu command-line.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 7.568170][=C2=A0=C2=A0=C2=
=A0 T1] Creating 5 MTD partitions on "bmc":
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 7.569330][=C2=A0=C2=A0=C2=
=A0 T1] 0x000000000000-0x0000000e0000 : "u-boot"
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 7.740372][=C2=A0=C2=A0=C2=
=A0 T1] 0x0000000e0000-0x000000100000 : "u-boot-env"
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 7.883570][=C2=A0=C2=A0=C2=
=A0 T1] 0x000000100000-0x000000a00000 : "kernel"
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 8.041004][=C2=A0=C2=A0=C2=
=A0 T1] 0x000000a00000-0x000002a00000 : "rofs"
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 8.196824][=C2=A0=C2=A0=C2=
=A0 T1] 0x000002a00000-0x000004000000 : "rwfs"
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 8.547037][=C2=A0=C2=A0=C2=
=A0 T1] spi-aspeed-smc 1e630000.spi: Calibration area too uniform, using lo=
w speed
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 8.547320][=C2=A0=C2=A0=C2=
=A0 T1] spi-aspeed-smc 1e630000.spi: Force to dts configuration 100000kHz.
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 8.547642][=C2=A0=C2=A0=C2=
=A0 T1] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:4 [0x406c0741]
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 9.494235][=C2=A0=C2=A0=C2=
=A0 T1] ftgmac100 1e660000.ethernet: Read MAC address 52:54:00:12:34:56 fro=
m chip
> > =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 9.531186][=C2=A0=C2=A0=C2=
=A0 T1] RTL8211E Gigabit Ethernet 1e650000.mdio-1:00: attached PHY driver (=
mii_bus:phy_addr=3D1e650000.mdio-1:00,
> >=20
> > Fixes: e09cf36321f6 ("hw: aspeed_scu: Add AST2600 support")
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> > I ran into this issue while improving test coverage in my patch review
> > process.
> > ---
> > =C2=A0 hw/misc/aspeed_scu.c | 3 ++-
> > =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> > index ca93c3699d81..1e3db6d03f91 100644
> > --- a/hw/misc/aspeed_scu.c
> > +++ b/hw/misc/aspeed_scu.c
> > @@ -821,7 +821,8 @@ static void aspeed_ast2600_scu_reset_hold(Object *o=
bj, ResetType type)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->regs[AST2600_SILICON_REV2] =3D s->sil=
icon_rev;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->regs[AST2600_HW_STRAP1] =3D s->hw_str=
ap1;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->regs[AST2600_HW_STRAP2] =3D s->hw_str=
ap2;
> > -=C2=A0=C2=A0=C2=A0 s->regs[PROT_KEY] =3D s->hw_prot_key;
> > +=C2=A0=C2=A0=C2=A0 s->regs[AST2600_PROT_KEY] =3D s->hw_prot_key =3D=3D=
 ASPEED_SCU_PROT_KEY;
> > +=C2=A0=C2=A0=C2=A0 s->regs[AST2600_PROT_KEY2] =3D s->hw_prot_key =3D=
=3D ASPEED_SCU_PROT_KEY;
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 static void aspeed_2600_scu_class_init(ObjectClass *klass, const=
 void *data)
> >=20
> > ---
> > base-commit: 9696bf5dc5a5bf0b4a9d05b6cdfe5f13990f97aa
> > change-id: 20260818-dev-ast2600-hw-prot-key-reset-e68eb9f49ee9
> >=20
> > Best regards,
> > --
> > Andrew Jeffery <andrew@codeconstruct.com.au>
> >=20
>=20
> Applied to
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/legoater/qemu=C2=A0aspeed-nex=
t
>=20
> Thanks,
>=20
> C.

Thanks C=C3=A9dric!

