Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F1BC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 01:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi0BM-0004mo-5W; Thu, 09 Jul 2026 21:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wi0B5-0004lz-JZ; Thu, 09 Jul 2026 21:37:21 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wi0B3-0006ZF-Jy; Thu, 09 Jul 2026 21:37:19 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 6A57DEC0188;
 Thu,  9 Jul 2026 21:37:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 09 Jul 2026 21:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783647436;
 x=1783733836; bh=Oe8fgGBJ9Ci/iWjpJe3KQeeehWXfwyPcEilYlAALFVI=; b=
 UQrW5If/JThHdeAW4TInD703TZ3+E2EzBNnI2iTIHAXqcNtTpfS3Gafv3tSWck6q
 7nOcHlPkrNeIIedVGMdHTtzWn2c6Bj8X/2t8//KQWKLx8xJUKpHzJINK0PgnJXnK
 fbSdHs8iDj0PELWpobMR3FJ8P1x7D7X1CLo7Sb7sG2wUgA5K04QwpoZXCgIF0gsF
 tISA4Fiej9A3cSV2d5pkG87fnQjmXCl6VqxoNh9fWsXbxtAjzj/bSWJMYEqLSd0O
 trh5Vuy7fEvvRgZwptR69NUqPvMyUvzWh50bCI4A8q9TCGvebyKnBw+lOtpOJC7R
 Y2l73EVfE1q+6goHYsQnbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1783647436; x=1783733836; bh=O
 e8fgGBJ9Ci/iWjpJe3KQeeehWXfwyPcEilYlAALFVI=; b=UIp/WJmca6Fruj774
 ViqVHfEXE2eSV7te6XLHKMOThB0bz5XoX7vFZkDbIc3VaIZS+Xg0yM89YMJS52Vy
 v9F2UjZzzOz1h/Hke2bSHkkM4BCvFshRFu/dZgEKjsx59Xo4xDQS5LOool65GYCZ
 C9DmyW2I5YRP0Kf224qLcG7J0I72gDp+1hmVGNOf3JJWU1nhjLOBJo8BPXJPTFsv
 nwRMZxpu15LpOPtyWphQwG/l52tmZ4zz0H1aDBS8X6YAKU7nA1UARaKuJ2dZXRwW
 4hiD2Um1iUeMyEMy9LGHG28cfyl/uTMH1c9gh+THz4Ext1x6TEwRNsoEDTVaAwHB
 O2Lmw==
X-ME-Sender: <xms:zExQajK8-xssxnB-uKccmNbFvUyESb1Ae_nENxNi4YPI0LIsJaPyog>
 <xme:zExQarf484yCE3FYJcNaBEZl11nEdf1OgGcYaKAinADmoAF6M8M3R0AZgU3HSwF7r
 acGXjWVSyP2F2hIduFFqD9yldE5vF4RpT9_m5dDLzhy7gpEJUUtmNPN>
X-ME-Received: <xmr:zExQaq0Cngv0Rlltx5zqYh5rRkAYyp0ba0AGtrh9SCPtyY6yHL6TaS7IZO5m3OK0wecDVh_tWcQXa_e48HNlmckTUNU>
X-ME-Proxy-Cause: dmFkZTF6SyI/3xOq8yN7X3wAOUHqmmgyHWEO1Arm1cf3YiPkVfUqYfibiO+nLDvbesbI97
 ZXppwbB7YMsPMfadmpkPJ9pnJRCf+MplGpmKdAXZN/sqS5JsqHKvyu/iC7PEnxMCsQDzft
 yfdPcC4Vt/h+3fc4eYa8NX7jH52tDsDbsWhkbPgJ9DJR/zgcXBfPHIoEI2dHoLXH/shs9B
 kS/Wpf/0Pq4i1SROHWEuMOP5xCSSS9LGu1Ss3qaNwLBhvYRZPV0zhYuKQfYXL97ZIMBGZM
 r3wSCFAEFpUZf6vexYAhOxLUTN6MytZD6o/RDfO5Bq/6gOBVCtSajR+flZSdmJC+1YzHWO
 QRcWfpty5EJz4QBVtQS+dxOutSTdcvE1zt0fBOzA6JH1lTRsEHgRNQuX9MrgDiJZXZnwR+
 8U1rh8ugakxndCvsx92dfIkIoILAd45IV3BZ2R04jCIxmIGncrRecUAliJKqrk/FHgO+a5
 9PsDGke6r1XvZK1nHx41BDmlUXaK0q5y89bOGS+XqRRaonquV9DMLe0IX8Mirvw80Ja9QD
 TCOuojFX5bi4xLUi1WljhmvULBA1Je9huIG8ccR/0E04N0TvqbPtuJcNUlQxxULdWu6pqM
 qfl7qQOpKMyWeE5DkNQqtQvNZnc478RJGz6BS9iZ1gwZDLs+3VUaYAUXzJLQ
X-ME-Proxy: <xmx:zExQakiJ_Bd1Rs73N5iZLZTXiDxTGAQpurimCxQ_2vsu6cUJfu0-Ag>
 <xmx:zExQagQsu0z9LGUEBN2S9YDfd5qovS5K-qY73kuSisbmzcd0exmA6Q>
 <xmx:zExQaljZt8n7t01C4tTsSnBQ5u2h7AfFCsz3HtWtO2qbyPqufd_d6Q>
 <xmx:zExQag4WDijR5rjlSLrGtDuANvo7YW409fLhL_JGHN4VAUHvmDMqHA>
 <xmx:zExQag-2RbyDUkPAK3hEO3aKA68TwNfnmnEOn3SyYKBfqZayoJnlb01r>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 21:37:14 -0400 (EDT)
Message-ID: <a6607686d2682e7b916e5c0a2f26382d19e818d5.camel@alistair23.me>
Subject: Re: [PATCH] hw/misc/stm32_rcc: Correct offset-to-irq calculation
From: Alistair <alistair@alistair23.me>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Date: Fri, 10 Jul 2026 11:37:12 +1000
In-Reply-To: <20260709104832.1989240-1-peter.maydell@linaro.org>
References: <20260709104832.1989240-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.144;
 envelope-from=alistair@alistair23.me; helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Thu, 2026-07-09 at 11:48 +0100, Peter Maydell wrote:
> In the STM32 RCC, there is a block of 5 "enable" registers, each of
> which has 32 bits; each bit determines the level of one of the 5 * 32
> =3D 160 enable_irq output lines.=C2=A0 The code calculates the irq to be
> worked on using
> =C2=A0 irq_offset =3D ((addr - STM32_RCC_AHB1_ENR) / 4) * 32;
>=20
> This assumes that the registers are all consecutive; however, there
> is a gap between the AHB1/2/3 registers and the APB1/2 registers, so
> for the APB1/2 registers we calculate a number that is 32 too high
> and can index off the end of the enable_irq[] array.
>=20
> The handling of the reset registers has an identical bug.
>=20
> Adjust the calculation of irq_offset to cope with the gap, and fix
> the case labels so accesses to the gap fall into the default
> LOG_UNIMP rather than being treated as if they were an actual
> register.
>=20
> Coverity CID: 1663683, 1663686
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0hw/misc/stm32_rcc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 31 +++++++++++++++++++++++++++----
> =C2=A0include/hw/misc/stm32_rcc.h |=C2=A0 6 +++++-
> =C2=A02 files changed, 32 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/misc/stm32_rcc.c b/hw/misc/stm32_rcc.c
> index 74ea29b156..5cfb39e560 100644
> --- a/hw/misc/stm32_rcc.c
> +++ b/hw/misc/stm32_rcc.c
> @@ -53,6 +53,27 @@ static uint64_t stm32_rcc_read(void *opaque,
> hwaddr addr, unsigned int size)
> =C2=A0=C2=A0=C2=A0=C2=A0 return value;
> =C2=A0}
> =C2=A0
> +static int reg_offset_to_irq_offset(hwaddr addr)
> +{
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0 * The reset and enable registers aren't all con=
secutive. In
> getting the
> +=C2=A0=C2=A0=C2=A0=C2=A0 * irq index from the register offset, we need t=
o account for
> the gap
> +=C2=A0=C2=A0=C2=A0=C2=A0 * between the AHB regs and the APB regs.
> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0 switch (addr) {
> +=C2=A0=C2=A0=C2=A0 case STM32_RCC_AHB1_RSTR ... STM32_RCC_AHB3_RSTR:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ((addr - STM32_RCC_AHB=
1_RSTR) / 4) * 32;
> +=C2=A0=C2=A0=C2=A0 case STM32_RCC_APB1_RSTR ... STM32_RCC_APB2_RSTR:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ((addr - STM32_RCC_APB=
1_RSTR) / 4) * 32 +
> STM32_RCC_N_AHB_IRQS;
> +=C2=A0=C2=A0=C2=A0 case STM32_RCC_AHB1_ENR ... STM32_RCC_AHB3_ENR:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ((addr - STM32_RCC_AHB=
1_ENR) / 4) * 32;
> +=C2=A0=C2=A0=C2=A0 case STM32_RCC_APB1_ENR ... STM32_RCC_APB2_ENR:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ((addr - STM32_RCC_APB=
1_ENR) / 4) * 32 +
> STM32_RCC_N_AHB_IRQS;
> +=C2=A0=C2=A0=C2=A0 default:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert_not_reached();
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> =C2=A0static void stm32_rcc_write(void *opaque, hwaddr addr,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint64_t val64, unsigned int size)
> =C2=A0{
> @@ -69,11 +90,12 @@ static void stm32_rcc_write(void *opaque, hwaddr
> addr,
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 switch (addr) {
> -=C2=A0=C2=A0=C2=A0 case STM32_RCC_AHB1_RSTR...STM32_RCC_APB2_RSTR:
> +=C2=A0=C2=A0=C2=A0 case STM32_RCC_AHB1_RSTR ... STM32_RCC_AHB3_RSTR:
> +=C2=A0=C2=A0=C2=A0 case STM32_RCC_APB1_RSTR ... STM32_RCC_APB2_RSTR:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prev_value =3D s->regs[a=
ddr / 4];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->regs[addr / 4] =3D va=
lue;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_offset =3D ((addr - STM32=
_RCC_AHB1_RSTR) / 4) * 32;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_offset =3D reg_offset_to_=
irq_offset(addr);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < 32=
; i++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
new_value =3D extract32(value, i, 1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (extract32(prev_value, i, 1) && !new_value) {
> @@ -82,11 +104,12 @@ static void stm32_rcc_write(void *opaque, hwaddr
> addr,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> -=C2=A0=C2=A0=C2=A0 case STM32_RCC_AHB1_ENR...STM32_RCC_APB2_ENR:
> +=C2=A0=C2=A0=C2=A0 case STM32_RCC_AHB1_ENR ... STM32_RCC_AHB3_ENR:
> +=C2=A0=C2=A0=C2=A0 case STM32_RCC_APB1_ENR ... STM32_RCC_APB2_ENR:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prev_value =3D s->regs[a=
ddr / 4];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->regs[addr / 4] =3D va=
lue;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_offset =3D ((addr - STM32=
_RCC_AHB1_ENR) / 4) * 32;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_offset =3D reg_offset_to_=
irq_offset(addr);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < 32=
; i++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
new_value =3D extract32(value, i, 1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (!extract32(prev_value, i, 1) && new_value) {
> diff --git a/include/hw/misc/stm32_rcc.h
> b/include/hw/misc/stm32_rcc.h
> index 4dccacc2db..a94781bf34 100644
> --- a/include/hw/misc/stm32_rcc.h
> +++ b/include/hw/misc/stm32_rcc.h
> @@ -65,7 +65,11 @@
> =C2=A0
> =C2=A0#define STM32_RCC_NREGS ((STM32_RCC_DCKCFGR2 >> 2) + 1)
> =C2=A0#define STM32_RCC_PERIPHERAL_SIZE 0x400
> -#define STM32_RCC_NIRQS (32 * 5) /* 32 bits per reg, 5 en/rst regs
> */
> +
> +/* 32 bits per reg, 3 AHB regs and 2 APB regs */
> +#define STM32_RCC_N_AHB_IRQS (32 * 3)
> +#define STM32_RCC_N_APB_IRQS (32 * 2)
> +#define STM32_RCC_NIRQS (STM32_RCC_N_AHB_IRQS +
> STM32_RCC_N_APB_IRQS)
> =C2=A0
> =C2=A0#define STM32_RCC_GPIO_IRQ_OFFSET 0
> =C2=A0

