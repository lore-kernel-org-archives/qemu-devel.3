Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7072CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 16:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMpja-0000zz-EH; Tue, 12 May 2026 12:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wMpjY-0000zV-Mk
 for qemu-devel@nongnu.org; Tue, 12 May 2026 12:13:24 -0400
Received: from 11.mo534.mail-out.ovh.net ([46.105.33.174])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wMpjR-0005IC-70
 for qemu-devel@nongnu.org; Tue, 12 May 2026 12:13:24 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4gFM88127mz6MB3;
 Tue, 12 May 2026 16:13:12 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Tue, 12 May 2026 16:13:12 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.178.131])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gFM8771BFz7thY; Tue, 12 May 2026 16:13:11 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 3E431941006; 
 Tue, 12 May 2026 16:13:10 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S0015c545a77-9e66-40e8-b1b0-24f2a185cdc9,
 39874C6F3F9F68F15966500C6FBBDB0B53A96BD7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <326e6058-0e2a-426a-98c4-de032b33e723@kaod.org>
Date: Tue, 12 May 2026 18:13:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] ast2600: yosemite4 initial support
To: Alexander Hansen <alexander.hansen@9elements.com>, qemu-devel@nongnu.org
Cc: Titus Rwantare <titusr@google.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org
References: <20260512102157.176511-1-alexander.hansen@9elements.com>
 <20260512102157.176511-2-alexander.hansen@9elements.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260512102157.176511-2-alexander.hansen@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 5879449313792338955
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGQ8+LxNbWm+/oYl0htFNB8AGm1xuO1rFbBoNZesQLJnHdQjG/e+InfTG7YBCU+FJpNzJy0XQc9/OLREksDkebrFKvbMCZEAABy5iWYUzJZIhDXTZtKW0nD56L3vpxV8AVby4yjtVwKxHGNO2yMJj/3AfKUM2XZNKbbLRRoAh1Ase4YNxgZRUazWJqFdVqsDim6GoZKtNwTlxSZRnS/5GESMPepuV1lTEuo+ZVIRG2QYS9EBDD/J9q4xVD9ZDyLFX32J9+08xLoW6JcWamkFmhoTu/5IN0KrO87ZrvbUZO+2yGrCfOS27JEO14q624e2Cl4Ti2WMjqa8kZHFpeR0euPGweF4GqjD7AIJojTaKSbhuMRVht50J7z3Kk1oL+XSdF43qoOmOdFe2wFVfhBzz2k7zhpMx7wpFshn0cc1DAxh14WwPdnIwuYd/ZFe9GaVE1gyrVwJstllK2c2FqVkJDKYU5yqn6jdnTpEitpeyOy9HhVzk/OX+qK1BmL0hbDvK4mbVeUVQ441cy6NgpuVtqehl7PHZh0XGS2VRyU/HtG3o71JTEr8AgwlSNVxIOPqczPen5fRzuC1VIbb6Wnj2wIcjqKODfdP6zKrXp4mJoHS+Ox26KschV/su4cS78f/N5trynjrYA1lwroO8fw4L7IixNNw0TiVmBwQZyjlUXOrQ
DKIM-Signature: a=rsa-sha256; bh=TV2xkJ/yz2c5gJRChPP/IRiYTaEdyp9Gmrl3YRr3H/s=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1778602393; v=1;
 b=a9kunq8TBLuT/b7sxwBbHQqQB8DauuIM1tIGJQTxNc/IomTLob637Sub24SLbEzfKwVozbXi
 47uBVlQmH5vfG61v8tSqaMOsWSFFiv/PbhkktSsmUivwbekfWOgIjHg/v5Dxq9gwf4NQz7VIOid
 cbC3cbHm6nXqMlz8YQlY8BAXKJSPW16OMtOooNCzXypuHxLwT5GpdItrqIX9fekFQAikLPFPX1a
 K3Jw+MIdsvrWLMHCihmXtogGxZbKpktewJ25udMai/5c7qwsU30iQb9sVL6I4Q2uDrMb2VbkCaP
 8ivGpvqVumWKZQLeSa96QCbSG/y/8Z6xf123e1VGuzETA==
Received-SPF: pass client-ip=46.105.33.174; envelope-from=clg@kaod.org;
 helo=11.mo534.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/12/26 12:20, Alexander Hansen wrote:
> Initial patch based on [1] to support yosemite v4 bmc emulation.
> 
> The goal of this machine support is to support OpenBMC development.

    Linux version 6.18.26-80ec78d

Nice. this is a commit coming from Andrew.

> 
> Reference linux devicetree from openbmc linux is [2].
> 
> Status:
> - Enclosure FRU:         showing up
> - Management Board FRU:  showing up
> - Blade Board FRU:       showing up
> - Blade Board sensors:   not implemented
> - Blade Chassis FRU:     showing up
> - Fan Board FRU:         both showing up
> - Fan Board sensors:     supported
> 
> Overall the emulation is incomplete but already helpful in development
> and testing.
> 
> The focus of this initial support is on the FRU eeproms and fanboard
> sensors.
> 
> Tested: booted an OpenBMC image for yosemite4 target.
> 
> References:
> [1] https://github.com/9elements/qemu/commit/32139f913c2bd0ebe4bd26c46765861f6f9f2d49
> [2] arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> [3] https://github.com/legoater/qemu-aspeed-boot/pull/5
> 
> Cc: Titus Rwantare <titusr@google.com>
> Cc: "Cédric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
> Cc: Peter Maydell <peter.maydell@linaro.org> (maintainer:ASPEED BMCs)
> Cc: Steven Lee <steven_lee@aspeedtech.com> (reviewer:ASPEED BMCs)
> Cc: Troy Lee <leetroy@gmail.com> (reviewer:ASPEED BMCs)
> Cc: Jamin Lin <jamin_lin@aspeedtech.com> (reviewer:ASPEED BMCs)
> Cc: Kane Chen <kane_chen@aspeedtech.com> (reviewer:ASPEED BMCs)
> Cc: Andrew Jeffery <andrew@codeconstruct.com.au> (reviewer:ASPEED BMCs)
> Cc: Joel Stanley <joel@jms.id.au> (reviewer:ASPEED BMCs)
> Cc: qemu-arm@nongnu.org (open list:ASPEED BMCs)
> Cc: qemu-devel@nongnu.org (open list:All patches CC here)
> Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
> ---
>   hw/arm/aspeed_ast2600_fby4.c | 267 +++++++++++++++++++++++++++++++++++
>   hw/arm/meson.build           |   1 +
>   2 files changed, 268 insertions(+)
>   create mode 100644 hw/arm/aspeed_ast2600_fby4.c
> 
> diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4.c
> new file mode 100644
> index 0000000000..d79a88e2fe
> --- /dev/null
> +++ b/hw/arm/aspeed_ast2600_fby4.c
> @@ -0,0 +1,267 @@
> +/*
> + * Yosemite V4

"Facebook Yosemite V4" may be ?

> + *
> + * Copyright 2026 9elements.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/arm/machines-qom.h"
> +#include "hw/arm/aspeed.h"
> +#include "hw/arm/aspeed_soc.h"
> +#include "hw/nvram/eeprom_at24c.h"
> +#include "hw/i2c/i2c_mux_pca954x.h"
> +#include "hw/gpio/pca9552.h"
> +
> +#define FBY4_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> +
> +/* START OF EEPROM CONTENTS */
> +
> +/*
> + *./frugen -s board.mfg="Wiwynn" \
> + * --set board.pname="Fan Board FSC-MAX ADC-TI LED-NXP EFUSE-MAX" \
> + * --set text:board.pn="BRD-PN-345" \
> + * --board-date "10/1/2017 12:58:00" \
> + * --set board.serial="123456" \
> + * --set product.pname="Yosemite V4" \
> + * --set product.mfg="Wiwynn" \
> + * --set product.ver="v1.1" \
> + * --set product.serial="123456" \
> + * --set product.atag="PLACEHOLDER" \
> + * --set product.custom="Fanboard Custom1" \
> + * --set product.custom.1="Fanboard Custom2" \
> + * --set text:product.pn="PN-345" \
> + * fru-yv4-fanboard.bin
> + */
> +/* EM Config: yosemite4_fanboard_fsc_max_adc_ti_led_nxp_ons_efuse_max.json */
> +/* Yosemite4 fan board */
> +static const uint8_t fru_yv4_fanboard_bin[] = {
> +  0x01, 0x00, 0x00, 0x01, 0x0b, 0x00, 0x00, 0xf3, 0x01, 0x0a, 0x19, 0xce,
> +  0xc2, 0xa8, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xea, 0x46, 0x61,
> +  0x6e, 0x20, 0x42, 0x6f, 0x61, 0x72, 0x64, 0x20, 0x46, 0x53, 0x43, 0x2d,
> +  0x4d, 0x41, 0x58, 0x20, 0x41, 0x44, 0x43, 0x2d, 0x54, 0x49, 0x20, 0x4c,
> +  0x45, 0x44, 0x2d, 0x4e, 0x58, 0x50, 0x20, 0x45, 0x46, 0x55, 0x53, 0x45,
> +  0x2d, 0x4d, 0x41, 0x58, 0x85, 0x91, 0x34, 0x51, 0x95, 0x05, 0xca, 0x42,
> +  0x52, 0x44, 0x2d, 0x50, 0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc0, 0xc1, 0x00,
> +  0x00, 0x00, 0x00, 0xdb, 0x01, 0x09, 0x19, 0xc6, 0x57, 0x69, 0x77, 0x79,
> +  0x6e, 0x6e, 0xcb, 0x59, 0x6f, 0x73, 0x65, 0x6d, 0x69, 0x74, 0x65, 0x20,
> +  0x56, 0x34, 0xc6, 0x50, 0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc4, 0x76, 0x31,
> +  0x2e, 0x31, 0x85, 0x91, 0x34, 0x51, 0x95, 0x05, 0x89, 0x30, 0x1b, 0x8e,
> +  0x25, 0xfa, 0xb2, 0x64, 0x29, 0x03, 0xc0, 0xd0, 0x46, 0x61, 0x6e, 0x62,
> +  0x6f, 0x61, 0x72, 0x64, 0x20, 0x43, 0x75, 0x73, 0x74, 0x6f, 0x6d, 0x32,
> +  0xc1, 0x00, 0x00, 0x9d
> +};
> +static const size_t fru_yv4_fanboard_bin_len = sizeof(fru_yv4_fanboard_bin);
> +
> +/*
> + *./frugen -s board.mfg="Wiwynn" \
> + * --set board.pname="Sentinel Dome without Retimer" \
> + * --set text:board.pn="BRD-PN-345" \
> + * --board-date "10/1/2017 12:58:00" \
> + * --set board.serial="123456" \
> + * --set product.pname="Yosemite V4" \
> + * --set product.mfg="Wiwynn" \
> + * --set product.ver="v1.1" \
> + * --set product.serial="123456" \
> + * --set product.atag="PLACEHOLDER" \
> + * --set product.custom="Yosemite V4 T1" \
> + * --set product.custom.1="Yosemite V4 T1" \
> + * --set text:product.pn="PN-345" \
> + * fru-yv4-sentineldome-board.bin
> + */
> +/* product.cust maps to PRODUCT_INFO_AM2 */
> +/* EM Config: yosemite4_sentineldome_t1.json */
> +/* Yosemite4 Sentinel Dome without Retimer Boards */
> +static const uint8_t fru_yv4_sentineldome_board_bin[] = {
> +  0x01, 0x00, 0x00, 0x01, 0x09, 0x00, 0x00, 0xf5, 0x01, 0x08, 0x19, 0xce,
> +  0xc2, 0xa8, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xdd, 0x53, 0x65,
> +  0x6e, 0x74, 0x69, 0x6e, 0x65, 0x6c, 0x20, 0x44, 0x6f, 0x6d, 0x65, 0x20,
> +  0x77, 0x69, 0x74, 0x68, 0x6f, 0x75, 0x74, 0x20, 0x52, 0x65, 0x74, 0x69,
> +  0x6d, 0x65, 0x72, 0x85, 0x91, 0x34, 0x51, 0x95, 0x05, 0xca, 0x42, 0x52,
> +  0x44, 0x2d, 0x50, 0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc0, 0xc1, 0x00, 0x78,
> +  0x01, 0x09, 0x19, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xcb, 0x59,
> +  0x6f, 0x73, 0x65, 0x6d, 0x69, 0x74, 0x65, 0x20, 0x56, 0x34, 0xc6, 0x50,
> +  0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc4, 0x76, 0x31, 0x2e, 0x31, 0x85, 0x91,
> +  0x34, 0x51, 0x95, 0x05, 0x89, 0x30, 0x1b, 0x8e, 0x25, 0xfa, 0xb2, 0x64,
> +  0x29, 0x03, 0xc0, 0xce, 0x59, 0x6f, 0x73, 0x65, 0x6d, 0x69, 0x74, 0x65,
> +  0x20, 0x56, 0x34, 0x20, 0x54, 0x31, 0xc1, 0x00, 0x00, 0x00, 0x00, 0xeb
> +};
> +static const size_t fru_yv4_sentineldome_board_bin_len =
> +    sizeof(fru_yv4_sentineldome_board_bin);
> +
> +/*
> + *./frugen -s board.mfg="Wiwynn" \
> + * --set board.pname="Sentinel Dome" \
> + * --set text:board.pn="BRD-PN-345" \
> + * --board-date "10/1/2017 12:58:00" \
> + * --set board.serial="123456" \
> + * --set product.pname="Yosemite V4" \
> + * --set product.mfg="Wiwynn" \
> + * --set product.ver="v1.1" \
> + * --set product.serial="123456" \
> + * --set product.atag="PLACEHOLDER" \
> + * --set text:product.pn="PN-345" \
> + * fru-yv4-sentineldome-chassis.bin
> + */
> +/* EM Config: yosemite4_sentineldome_chassis.json */
> +/* Yosemite 4 Sentinel Dome Chassis FRU */
> +static const uint8_t fru_yv4_sentineldome_chassis_bin[] = {
> +  0x01, 0x00, 0x00, 0x01, 0x07, 0x00, 0x00, 0xf7, 0x01, 0x06, 0x19, 0xce,
> +  0xc2, 0xa8, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xcd, 0x53, 0x65,
> +  0x6e, 0x74, 0x69, 0x6e, 0x65, 0x6c, 0x20, 0x44, 0x6f, 0x6d, 0x65, 0x85,
> +  0x91, 0x34, 0x51, 0x95, 0x05, 0xca, 0x42, 0x52, 0x44, 0x2d, 0x50, 0x4e,
> +  0x2d, 0x33, 0x34, 0x35, 0xc0, 0xc1, 0x00, 0xb6, 0x01, 0x07, 0x19, 0xc6,
> +  0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xcb, 0x59, 0x6f, 0x73, 0x65, 0x6d,
> +  0x69, 0x74, 0x65, 0x20, 0x56, 0x34, 0xc6, 0x50, 0x4e, 0x2d, 0x33, 0x34,
> +  0x35, 0xc4, 0x76, 0x31, 0x2e, 0x31, 0x85, 0x91, 0x34, 0x51, 0x95, 0x05,
> +  0x89, 0x30, 0x1b, 0x8e, 0x25, 0xfa, 0xb2, 0x64, 0x29, 0x03, 0xc0, 0xc1,
> +  0x00, 0x00, 0x00, 0x59
> +};
> +static const size_t fru_yv4_sentineldome_chassis_bin_len =
> +    sizeof(fru_yv4_sentineldome_chassis_bin);
> +
> +/*
> + *./frugen -s board.mfg="Wiwynn" \
> + * --set board.pname="Management Board wBMC" \
> + * --set text:board.pn="BRD-PN-345" \
> + * --board-date "10/1/2017 12:58:00" \
> + * --set board.serial="123456" \
> + * --set product.pname="Yosemite V4" \
> + * --set product.mfg="Wiwynn" \
> + * --set product.ver="v1.1" \
> + * --set product.serial="123456" \
> + * --set product.atag="PLACEHOLDER" \
> + * --set text:product.pn="PN-345" \
> + * fru-yv4-eclosure.bin
> + */
> +/* EM Config: yosemite4_chassis.json, yosemite4.json */
> +/* Yosemite 4 Sentinel Dome Enclosure FRU */
> +static const uint8_t fru_yv4_eclosure_bin[] = {
> +  0x01, 0x00, 0x00, 0x01, 0x08, 0x00, 0x00, 0xf6, 0x01, 0x07, 0x19, 0xce,
> +  0xc2, 0xa8, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xd5, 0x4d, 0x61,
> +  0x6e, 0x61, 0x67, 0x65, 0x6d, 0x65, 0x6e, 0x74, 0x20, 0x42, 0x6f, 0x61,
> +  0x72, 0x64, 0x20, 0x77, 0x42, 0x4d, 0x43, 0x85, 0x91, 0x34, 0x51, 0x95,
> +  0x05, 0xca, 0x42, 0x52, 0x44, 0x2d, 0x50, 0x4e, 0x2d, 0x33, 0x34, 0x35,
> +  0xc0, 0xc1, 0x00, 0x26, 0x01, 0x07, 0x19, 0xc6, 0x57, 0x69, 0x77, 0x79,
> +  0x6e, 0x6e, 0xcb, 0x59, 0x6f, 0x73, 0x65, 0x6d, 0x69, 0x74, 0x65, 0x20,
> +  0x56, 0x34, 0xc6, 0x50, 0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc4, 0x76, 0x31,
> +  0x2e, 0x31, 0x85, 0x91, 0x34, 0x51, 0x95, 0x05, 0x89, 0x30, 0x1b, 0x8e,
> +  0x25, 0xfa, 0xb2, 0x64, 0x29, 0x03, 0xc0, 0xc1, 0x00, 0x00, 0x00, 0x59
> +};
> +static const size_t fru_yv4_eclosure_bin_len = sizeof(fru_yv4_eclosure_bin);
> +
> +/* END OF EEPROM CONTENTS */
> +
> +static void fby4_i2c_init_fanboard(I2CSlave *fan_mux, size_t eepromSize)
> +{
> +    /* 2 fan boards */
> +    for (int i = 0; i <= 1; i++) {
> +        /* downstream bus */
> +        I2CBus *bus = pca954x_i2c_get_bus(fan_mux, i);
> +
> +        /* ti,adc128d818 @ 0x1f    (adc) */
> +        /* TODO */
> +
> +        /* maxim,max31790 @ 0x20   (pwm) */
> +        /* TODO */
> +
> +        /*
> +         * ti,tca6424 @ 0x22       (gpio)
> +         * linux handles tca6424 with PCA953X_TYPE, same as pca9535
> +         * { "pca9535", 16 | PCA953X_TYPE | PCA_INT, },
> +         * { "tca6424", 24 | PCA953X_TYPE | PCA_INT, },
> +         * so we _could_ be fine here unless more than 16 gpios are used
> +         */
> +        i2c_slave_create_simple(bus, TYPE_PCA9535, 0x22);
> +
> +        /*
> +         * NOTE: above works and could use for gpio presence:
> +         * $ gpioget gpiochip2 2
> +         * 1
> +         */
> +
> +        /* maxim,max31790 @ 0x2f   (pwm) */
> +        /* TODO */
> +
> +        /* maxim,max11615 @ 0x33   (adc) */
> +        /* TODO */
> +
> +        at24c_eeprom_init_rom(
> +            bus, 0x52, eepromSize,
> +            fru_yv4_fanboard_bin,
> +            fru_yv4_fanboard_bin_len);
> +
> +        /* LED blink driver / gpio expander */
> +        /* nxp,pca9552 @ 0x61   (gpio) */
> +        i2c_slave_create_simple(bus, TYPE_PCA9552, 0x61);
> +    }
> +}
> +
> +static void fby4_i2c_init_blade_chassis(I2CBus *bus, size_t eepromSize)
> +{
> +    /* Sentinel Dome Blade EEPROMS */
> +
> +    /* Board */
> +    at24c_eeprom_init_rom(bus, 0x54, eepromSize,
> +        fru_yv4_sentineldome_board_bin, fru_yv4_sentineldome_board_bin_len);
> +
> +    /* Chassis */
> +   at24c_eeprom_init_rom(bus, 0x55, eepromSize,
> +       fru_yv4_sentineldome_chassis_bin, fru_yv4_sentineldome_chassis_bin_len);
> +}
> +
> +static void fby4_i2c_init_multiple_blade_chassis(I2CBus **i2c,
> +    size_t eepromSize)
> +{
> +    /* there is 8 blade chassis, but we only emulate 2 for performance reason */
> +    for (int bus = 1; bus <= (8 / 4); bus++) {
> +        fby4_i2c_init_blade_chassis(i2c[bus], eepromSize);
> +    }
> +}
> +
> +static void fby4_i2c_init(AspeedMachineState *bmc)
> +{
> +    AspeedSoCState *soc = bmc->soc;
> +    I2CBus *i2c[16];
> +
> +    for (int i = 0; i < 16; i++) {
> +        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
> +    }
> +
> +    /* Enclosure (EM Config: yosemite4_chassis.json, yosemite4.json) */
> +    at24c_eeprom_init_rom(i2c[1], 0x51, 128 * KiB,
> +        fru_yv4_eclosure_bin, fru_yv4_eclosure_bin_len);
> +
> +    fby4_i2c_init_multiple_blade_chassis(i2c, 128 * KiB);
> +
> +    /* Yv4 fanboard connection */
> +    I2CSlave *fan_mux = i2c_slave_create_simple(i2c[14], TYPE_PCA9546, 0x74);
> +
> +    fby4_i2c_init_fanboard(fan_mux, 128 * KiB);
> +}
> +
> +static void aspeed_machine_fby4_class_init(ObjectClass *oc, const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc       = "Facebook fby4 BMC (Cortex-A7)";
> +    amc->fmc_model = "mx66l1g45g";
> +    amc->num_cs    = 2;
> +    amc->macs_mask = ASPEED_MAC3_ON;
> +    amc->i2c_init  = fby4_i2c_init;
> +    mc->default_ram_size = FBY4_BMC_RAM_SIZE;
> +    aspeed_machine_class_init_cpus_defaults(mc);
> +}
> +
> +static const TypeInfo aspeed_ast2600_fby4_types[] = {
> +    {
> +        .name          = MACHINE_TYPE_NAME("fby4-bmc"),
> +        .parent        = MACHINE_TYPE_NAME("ast2600-evb"),
> +        .class_init    = aspeed_machine_fby4_class_init,
> +        .interfaces    = arm_machine_interfaces,
> +    }
> +};
> +
> +DEFINE_TYPES(aspeed_ast2600_fby4_types)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 84b8ec5fb5..ccbc23e549 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -60,6 +60,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>     'aspeed_ast2600_catalina.c',
>     'aspeed_ast2600_evb.c',
>     'aspeed_ast2600_fby35.c',
> +  'aspeed_ast2600_fby4.c',
>     'aspeed_ast2600_fuji.c',
>     'aspeed_ast2600_gb200nvl.c',
>     'aspeed_ast2600_qcom-dc-scm-v1.c',


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




