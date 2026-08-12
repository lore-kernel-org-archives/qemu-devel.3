Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58049C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAxS-0005kw-1H; Wed, 12 Aug 2026 11:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuAxQ-0005jc-L4; Wed, 12 Aug 2026 11:33:32 -0400
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuAwg-0004Io-Nc; Wed, 12 Aug 2026 11:33:32 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 55B571400088;
 Wed, 12 Aug 2026 11:32:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 12 Aug 2026 11:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786548765; x=1786635165; bh=CsjhMTXGP0SAlh4DyBpR6rK/ZxXLZ090
 j/OjkAeH4Ls=; b=0s6zAb/q5nLrgjNYN2lnPvuKkb48+Tbmjz2CBkYy6GdA8skD
 Nkc1OhE5qQ7HDkqtVQynRTocNfB9EDNvFWQsOJau7DrS/coe2i89FmX6PJZz7Da+
 6iV4rHKs9DAvPvl4hcl2Yx1i4zoQQEvjJO+MsvWZ+yQQI4nsBXXdvglvgn94XMVA
 Wf87uflWGUVXPfi+jMek8oAVWz0NYFAKXR4bkbPvYa4Ja+DWdDkz1Wodx5v0po03
 j4i2lXmgoymKdx9a/PkJ+Pa+WuYE1vwcVYBg3oTcrolQP5Iv0hBF+jRfleHcqii+
 GHN7uQ7nc5ElTisJ9MpO+82me5KDmt5F/i3Wgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786548765; x=
 1786635165; bh=CsjhMTXGP0SAlh4DyBpR6rK/ZxXLZ090j/OjkAeH4Ls=; b=Z
 vtnIgUUk4XUuIv9kOHHVUfCHnlBlqbRPIB0a6PL+oeSQa3YXzj/YqcP29jSSKb5e
 1yfRv5ZBp837dDKyRdABrJwPUbqkQbhkoEuTC58uQ2fY5cN4iXzmgfyKGOGRpAhO
 kJiDWXOXaWLyPOSrhkhq5b7vXedhBeo3kGW1ZhwHkbrnjllhcM4IC2jXWVxcR52+
 vYVEn0d/v7axI1Von+QjNEqVahNr5wf2moLKvdbJ0wXh1G8kn41MUbN6NAYylvhZ
 eucwNHpG15wMu5XWsh6vKSbobkQSkYqFaZgx8DZSCdSYlrAj/s8oJZfFZnGzjwtK
 tpwwDVbVo4mlXSCYbx/ow==
X-ME-Sender: <xms:HZJ8ak5oslIaSQHJ4MZMFoHPbmyoVid2FFSYJsVAtkm2Sej0uQbtZw>
 <xme:HZJ8au3WkE_JRIBDrjzNFuY39foXoCo58dn1LXP4B8_4RxZLjpJV6gr1VNDvk-D-h
 yygRiTOScUKJHEzKG3MiT49tjrqBG-3wlVZr5BPbrXsRfgkwtizCwa2>
X-ME-Received: <xmr:HZJ8avC4eQAKtvgc60A5tfDjRRSKL7LOZo1tPRS2gXpbcFdbLjwk89WvfXh0az7LSHrcsw>
X-ME-Proxy-Cause: dmFkZTFFg8fCAL84k0YLJG4ddtLP/FaVD+vWuNUPplT24xuQu9TfrDrJHyL52wBMXbTnIt
 DyCkDsJ4H6E4FN6Qca+9ukxr4Ao8zaXYKpdEEkeDEE2K4768oZpwpsqhyG2lcLKm1IxqWF
 0o2pl7ILNjod2q1X2556PtiFiHNt9TPrLYeVQ1nQBLoAkx0p6WiI6SBkgXHi1vVWr84Fqj
 E4IbE5x/lVVur1qxF6ThfQdlYohTs5wItW/jjN9y4J4h4J3prqF10p1Wehco5thc8YS4Kc
 bummzs7wZdUVQUOD4L7Rre8hGmdJLpECzP7XZqq3taWe3jEqW3rOfiyImSuFcgGFUuxoKU
 clEJCXxtSHv91L+xeE3LH5WC4Wa9nKD3e/sF7WJvQI+XMqnCqWPhR5gMruWkI3VV12pUIJ
 /H3IfryXGYY3nrKFfGM/ZM2Gn0SKNsl6U3HLjcu9eSD04ObioIJjdBVZyZ7acNLgYdc4kV
 z8cgIsFrLAfmfskjIMft2EIvoZCtJEmtXLhWPT37kF2hec2aC0p8QiCkWmzuJhUZiuTnjG
 Lg9GipGonVwlaUA2z52qKCMOScTSC5KeAyzSXjUGY8VmrcjWafKqo9UtzQg2Uq6x/NDw8r
 3AM20dzGGQFGhUOoRTFhDPt8KzPCoetndqUy0bUFNvqYaHMBv5S8L7yWTyTg
X-ME-Proxy: <xmx:HZJ8apOfrCStchfO-S7cCxNtIgbJcEz8otvVTZ39lUjDKhMRjvUqew>
 <xmx:HZJ8akZeJZMjhvRbQ9yUl0fGcQXngdNJTogTX0mNjhlY42Ia3VU15g>
 <xmx:HZJ8aot3EbpVJsrN4XwsnRwSNbn-n-RruDFMtnN1eKRhmltuCNTshw>
 <xmx:HZJ8amOXcA-wIuq1citif82iRh2WnYG3MULJpRycgCWmrY7pnn4XiQ>
 <xmx:HZJ8aqNNwiKR_wkEgP4QArs5cG5aZcrnqGFP66qNUanWn73fhA-aHgY0>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 11:32:44 -0400 (EDT)
Message-ID: <2446959f1e25d886cd3d7c05fb95a89082d9c5ad.camel@alistair23.me>
Subject: Re: [PATCH 04/26] hw/misc: pfsoc: Model L2 cache controller registers
From: Alistair <alistair@alistair23.me>
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Date: Thu, 13 Aug 2026 01:32:44 +1000
In-Reply-To: <20260723151853.2143177-5-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-5-bin.meng@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.152;
 envelope-from=alistair@alistair23.me; helo=fhigh-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Thu, 2026-07-23 at 23:18 +0800, Bin Meng wrote:
> Implement the Config, WayEnable, and per-master WayMask registers
> described by the PolarFire SoC MSS reference manual. Make WayEnable
> monotonic and report the remaining register space as unimplemented.
>=20
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
>=20
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 2 +
> =C2=A0include/hw/misc/mchp_pfsoc_l2cc.h |=C2=A0 30 +++++
> =C2=A0hw/misc/mchp_pfsoc_l2cc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 180
> ++++++++++++++++++++++++++++++
> =C2=A0hw/misc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0hw/misc/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A05 files changed, 216 insertions(+)
> =C2=A0create mode 100644 include/hw/misc/mchp_pfsoc_l2cc.h
> =C2=A0create mode 100644 hw/misc/mchp_pfsoc_l2cc.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a28935c898..c0bb18c47a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1770,11 +1770,13 @@ F: hw/riscv/microchip_pfsoc.c
> =C2=A0F: hw/char/mchp_pfsoc_mmuart.c
> =C2=A0F: hw/misc/mchp_pfsoc_dmc.c
> =C2=A0F: hw/misc/mchp_pfsoc_ioscb.c
> +F: hw/misc/mchp_pfsoc_l2cc.c
> =C2=A0F: hw/misc/mchp_pfsoc_sysreg.c
> =C2=A0F: include/hw/riscv/microchip_pfsoc.h
> =C2=A0F: include/hw/char/mchp_pfsoc_mmuart.h
> =C2=A0F: include/hw/misc/mchp_pfsoc_dmc.h
> =C2=A0F: include/hw/misc/mchp_pfsoc_ioscb.h
> +F: include/hw/misc/mchp_pfsoc_l2cc.h
> =C2=A0F: include/hw/misc/mchp_pfsoc_sysreg.h
> =C2=A0
> =C2=A0Shakti C class SoC
> diff --git a/include/hw/misc/mchp_pfsoc_l2cc.h
> b/include/hw/misc/mchp_pfsoc_l2cc.h
> new file mode 100644
> index 0000000000..1b5b3888d5
> --- /dev/null
> +++ b/include/hw/misc/mchp_pfsoc_l2cc.h
> @@ -0,0 +1,30 @@
> +/*
> + * Microchip PolarFire SoC L2 cache controller
> + *
> + * Copyright (c) 2026 Process Mission
> + *
> + * Author:
> + *=C2=A0=C2=A0 Bin Meng <bin.meng@processmission.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef MCHP_PFSOC_L2CC_H
> +#define MCHP_PFSOC_L2CC_H
> +
> +#include "hw/core/register.h"
> +#include "hw/core/sysbus.h"
> +
> +#define MCHP_PFSOC_L2CC_REG_SIZE 0x1000
> +#define MCHP_PFSOC_L2CC_REG_NUM=C2=A0 (MCHP_PFSOC_L2CC_REG_SIZE / 8)
> +
> +typedef struct MchpPfSoCL2ccState {
> +=C2=A0=C2=A0=C2=A0 SysBusDevice parent;
> +=C2=A0=C2=A0=C2=A0 uint64_t regs[MCHP_PFSOC_L2CC_REG_NUM];
> +=C2=A0=C2=A0=C2=A0 RegisterInfo regs_info[MCHP_PFSOC_L2CC_REG_NUM];
> +} MchpPfSoCL2ccState;
> +
> +#define TYPE_MCHP_PFSOC_L2CC "mchp.pfsoc.l2cc"
> +OBJECT_DECLARE_SIMPLE_TYPE(MchpPfSoCL2ccState, MCHP_PFSOC_L2CC)
> +
> +#endif
> diff --git a/hw/misc/mchp_pfsoc_l2cc.c b/hw/misc/mchp_pfsoc_l2cc.c
> new file mode 100644
> index 0000000000..b320356572
> --- /dev/null
> +++ b/hw/misc/mchp_pfsoc_l2cc.c
> @@ -0,0 +1,180 @@
> +/*
> + * Microchip PolarFire SoC L2 cache controller
> + *
> + * Copyright (c) 2026 Process Mission
> + *
> + * Author:
> + *=C2=A0=C2=A0 Bin Meng <bin.meng@processmission.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/core/register.h"
> +#include "hw/core/registerfields.h"
> +#include "hw/misc/mchp_pfsoc_l2cc.h"
> +
> +REG64(L2_CONFIG, 0x000)
> +=C2=A0=C2=A0=C2=A0 FIELD(L2_CONFIG, BANKS, 0, 8)
> +=C2=A0=C2=A0=C2=A0 FIELD(L2_CONFIG, WAYS, 8, 8)
> +=C2=A0=C2=A0=C2=A0 FIELD(L2_CONFIG, SETS, 16, 8)
> +=C2=A0=C2=A0=C2=A0 FIELD(L2_CONFIG, BYTES, 24, 8)
> +REG64(L2_WAY_ENABLE, 0x008)
> +=C2=A0=C2=A0=C2=A0 FIELD(L2_WAY_ENABLE, VALUE, 0, 8)
> +REG64(L2_WAY_MASK_DMA, 0x800)
> +REG64(L2_WAY_MASK_AXI4_PORT_0, 0x808)
> +REG64(L2_WAY_MASK_AXI4_PORT_1, 0x810)
> +REG64(L2_WAY_MASK_AXI4_PORT_2, 0x818)
> +REG64(L2_WAY_MASK_AXI4_PORT_3, 0x820)
> +REG64(L2_WAY_MASK_HART0_DCACHE, 0x828)
> +REG64(L2_WAY_MASK_HART0_ICACHE, 0x830)
> +REG64(L2_WAY_MASK_HART1_DCACHE, 0x838)
> +REG64(L2_WAY_MASK_HART1_ICACHE, 0x840)
> +REG64(L2_WAY_MASK_HART2_DCACHE, 0x848)
> +REG64(L2_WAY_MASK_HART2_ICACHE, 0x850)
> +REG64(L2_WAY_MASK_HART3_DCACHE, 0x858)
> +REG64(L2_WAY_MASK_HART3_ICACHE, 0x860)
> +REG64(L2_WAY_MASK_HART4_DCACHE, 0x868)
> +REG64(L2_WAY_MASK_HART4_ICACHE, 0x870)
> +
> +#define L2_CONFIG_RESET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
0x06091004
> +
> +static uint64_t mchp_pfsoc_l2cc_way_enable_pre_write(RegisterInfo
> *reg,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 uint64_t value)
> +{
> +=C2=A0=C2=A0=C2=A0 uint64_t current =3D *(uint64_t *)reg->data;
> +
> +=C2=A0=C2=A0=C2=A0 return MAX(current, value);
> +}
> +
> +#define WAY_MASK_REGISTER(_name)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +=C2=A0=C2=A0=C2=A0 {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "WAY_MASK_" #_name,=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .addr =3D A_L2_WAY_MASK_ ## _=
name,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .reset =3D UINT64_MAX,=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +=C2=A0=C2=A0=C2=A0 }
> +
> +static const RegisterAccessInfo mchp_pfsoc_l2cc_regs_info[] =3D {
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "CONFIG",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .addr =3D A_L2_CONFIG,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .reset =3D L2_CONFIG_RESET,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ro =3D UINT64_MAX,
> +=C2=A0=C2=A0=C2=A0 }, {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "WAY_ENABLE",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .addr =3D A_L2_WAY_ENABLE,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .rsvd =3D ~R_L2_WAY_ENABLE_VA=
LUE_MASK,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pre_write =3D mchp_pfsoc_l2c=
c_way_enable_pre_write,
> +=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 WAY_MASK_REGISTER(DMA),
> +=C2=A0=C2=A0=C2=A0 WAY_MASK_REGISTER(AXI4_PORT_0),
> +=C2=A0=C2=A0=C2=A0 WAY_MASK_REGISTER(AXI4_PORT_1),
> +=C2=A0=C2=A0=C2=A0 WAY_MASK_REGISTER(AXI4_PORT_2),
> +=C2=A0=C2=A0=C2=A0 WAY_MASK_REGISTER(AXI4_PORT_3),
> +=C2=A0=C2=A0=C2=A0 WAY_MASK_REGISTER(HART0_DCACHE),
> +=C2=A0=C2=A0=C2=A0 WAY_MASK_REGISTER(HART0_ICACHE),
> +=C2=A0=C2=A0=C2=A0 WAY_MASK_REGISTER(HART1_DCACHE),
> +=C2=A0=C2=A0=C2=A0 WAY_MASK_REGISTER(HART1_ICACHE),
> +=C2=A0=C2=A0=C2=A0 WAY_MASK_REGISTER(HART2_DCACHE),
> +=C2=A0=C2=A0=C2=A0 WAY_MASK_REGISTER(HART2_ICACHE),
> +=C2=A0=C2=A0=C2=A0 WAY_MASK_REGISTER(HART3_DCACHE),
> +=C2=A0=C2=A0=C2=A0 WAY_MASK_REGISTER(HART3_ICACHE),
> +=C2=A0=C2=A0=C2=A0 WAY_MASK_REGISTER(HART4_DCACHE),
> +=C2=A0=C2=A0=C2=A0 WAY_MASK_REGISTER(HART4_ICACHE),
> +};
> +
> +static bool mchp_pfsoc_l2cc_register_implemented(hwaddr offset)
> +{
> +=C2=A0=C2=A0=C2=A0 size_t i;
> +
> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARRAY_SIZE(mchp_pfsoc_l2cc_regs_inf=
o); i++) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mchp_pfsoc_l2cc_regs_info=
[i].addr =3D=3D offset) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n true;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 return false;
> +}
> +
> +static uint64_t mchp_pfsoc_l2cc_read(void *opaque, hwaddr offset,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsig=
ned size)
> +{
> +=C2=A0=C2=A0=C2=A0 if (mchp_pfsoc_l2cc_register_implemented(offset)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return register_read_memory(o=
paque, offset, size);
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 qemu_log_mask(LOG_UNIMP, "%s: unimplemented device re=
ad "
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "(size %u, offset 0x%" HWADDR_PRIx ")\n",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, size, offset);
> +=C2=A0=C2=A0=C2=A0 return 0;
> +}
> +
> +static void mchp_pfsoc_l2cc_write(void *opaque, hwaddr offset,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t value, unsigne=
d size)
> +{
> +=C2=A0=C2=A0=C2=A0 if (mchp_pfsoc_l2cc_register_implemented(offset)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 register_write_memory(opaque,=
 offset, value, size);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 qemu_log_mask(LOG_UNIMP, "%s: unimplemented device wr=
ite "
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "(size %u, value 0x%" PRIx64
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ", offset 0x%" HWADDR_PRIx ")\n",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, size, value, offset);
> +}
> +
> +static const MemoryRegionOps mchp_pfsoc_l2cc_ops =3D {
> +=C2=A0=C2=A0=C2=A0 .read =3D mchp_pfsoc_l2cc_read,
> +=C2=A0=C2=A0=C2=A0 .write =3D mchp_pfsoc_l2cc_write,
> +=C2=A0=C2=A0=C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,
> +=C2=A0=C2=A0=C2=A0 .valid =3D { .min_access_size =3D 1, .max_access_size=
 =3D 8 },
> +=C2=A0=C2=A0=C2=A0 .impl =3D { .min_access_size =3D 1, .max_access_size =
=3D 8 },
> +};
> +
> +static void mchp_pfsoc_l2cc_reset(DeviceState *dev)
> +{
> +=C2=A0=C2=A0=C2=A0 MchpPfSoCL2ccState *s =3D MCHP_PFSOC_L2CC(dev);
> +=C2=A0=C2=A0=C2=A0 size_t i;
> +
> +=C2=A0=C2=A0=C2=A0 memset(s->regs, 0, sizeof(s->regs));
> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARRAY_SIZE(mchp_pfsoc_l2cc_regs_inf=
o); i++) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwaddr addr =3D mchp_pfsoc_l2=
cc_regs_info[i].addr;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 register_reset(&s->regs_info[=
addr / sizeof(uint64_t)]);
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +static void mchp_pfsoc_l2cc_init(Object *obj)
> +{
> +=C2=A0=C2=A0=C2=A0 MchpPfSoCL2ccState *s =3D MCHP_PFSOC_L2CC(obj);
> +=C2=A0=C2=A0=C2=A0 RegisterInfoArray *reg_array;
> +
> +=C2=A0=C2=A0=C2=A0 reg_array =3D register_init_block64(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEVICE(obj), mchp_pfsoc_l2cc_=
regs_info,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(mchp_pfsoc_l2cc_re=
gs_info), s->regs_info, s-
> >regs,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mchp_pfsoc_l2cc_ops, false, =
MCHP_PFSOC_L2CC_REG_SIZE);
> +=C2=A0=C2=A0=C2=A0 sysbus_init_mmio(SYS_BUS_DEVICE(obj), &reg_array->mem=
);
> +}
> +
> +static void mchp_pfsoc_l2cc_class_init(ObjectClass *klass, const
> void *data)
> +{
> +=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +=C2=A0=C2=A0=C2=A0 device_class_set_legacy_reset(dc, mchp_pfsoc_l2cc_res=
et);

Again, non-legacy reset would be best

Otherwise:

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +}
> +
> +static const TypeInfo mchp_pfsoc_l2cc_info =3D {
> +=C2=A0=C2=A0=C2=A0 .name =3D TYPE_MCHP_PFSOC_L2CC,
> +=C2=A0=C2=A0=C2=A0 .parent =3D TYPE_SYS_BUS_DEVICE,
> +=C2=A0=C2=A0=C2=A0 .instance_size =3D sizeof(MchpPfSoCL2ccState),
> +=C2=A0=C2=A0=C2=A0 .instance_init =3D mchp_pfsoc_l2cc_init,
> +=C2=A0=C2=A0=C2=A0 .class_init =3D mchp_pfsoc_l2cc_class_init,
> +};
> +
> +static void mchp_pfsoc_l2cc_register_types(void)
> +{
> +=C2=A0=C2=A0=C2=A0 type_register_static(&mchp_pfsoc_l2cc_info);
> +}
> +
> +type_init(mchp_pfsoc_l2cc_register_types)
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 1543ee6653..772a2d87b3 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -203,6 +203,9 @@ config MCHP_PFSOC_DMC
> =C2=A0config MCHP_PFSOC_IOSCB
> =C2=A0=C2=A0=C2=A0=C2=A0 bool
> =C2=A0
> +config MCHP_PFSOC_L2CC
> +=C2=A0=C2=A0=C2=A0 bool
> +
> =C2=A0config MCHP_PFSOC_SYSREG
> =C2=A0=C2=A0=C2=A0=C2=A0 bool
> =C2=A0
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 23265f6035..5f45861d8a 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -30,6 +30,7 @@ system_ss.add(when: 'CONFIG_VIRT_CTRL', if_true:
> files('virt_ctrl.c'))
> =C2=A0# RISC-V devices
> =C2=A0system_ss.add(when: 'CONFIG_MCHP_PFSOC_DMC', if_true:
> files('mchp_pfsoc_dmc.c'))
> =C2=A0system_ss.add(when: 'CONFIG_MCHP_PFSOC_IOSCB', if_true:
> files('mchp_pfsoc_ioscb.c'))
> +system_ss.add(when: 'CONFIG_MCHP_PFSOC_L2CC', if_true:
> files('mchp_pfsoc_l2cc.c'))
> =C2=A0system_ss.add(when: 'CONFIG_MCHP_PFSOC_SYSREG', if_true:
> files('mchp_pfsoc_sysreg.c'))
> =C2=A0system_ss.add(when: 'CONFIG_SIFIVE_TEST', if_true:
> files('sifive_test.c'))
> =C2=A0system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true:
> files('sifive_e_prci.c'))

