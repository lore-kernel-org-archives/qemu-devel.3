Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E086CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 17:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJxC9-0006ly-Cs; Mon, 04 May 2026 13:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wJxC6-0006kq-O6
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:34:59 -0400
Received: from smtpout3.mo534.mail-out.ovh.net ([51.210.94.142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wJxC0-0005rE-QT
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:34:58 -0400
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [51.68.80.175])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4g8TKy6Cpbz614y;
 Mon,  4 May 2026 17:34:46 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Mon,  4 May 2026 17:34:46 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.138])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4g8TKy3qWlz5vLP; Mon,  4 May 2026 17:34:46 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 4428B24034C7; Mon,  4 May 2026 17:34:45 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001274fa6f1-8adb-46ef-8be8-85cbb564ee0d,
 6CC5FA71F9BBCB93EEE0D9DCB002DEB149E91A90) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <7184f945-7e92-4394-b484-1eb336aa4161@kaod.org>
Date: Mon, 4 May 2026 19:34:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ast2600: yosemite4 initial support
To: Alexander Hansen <alexander.hansen@9elements.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org
References: <20260504165043.213704-2-alexander.hansen@9elements.com>
 <20260504165043.213704-6-alexander.hansen@9elements.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260504165043.213704-6-alexander.hansen@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 15615668759392332811
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGvzoMqq6/LpqBtDNj+tVXXkJuZMZBIFVCbhP8QXervLtsuKacEPqepiPGIoD/ga/kkXwHJ81aUFsqnux5EJQ4S5LWJGcLrZPTLrqWlKd+LLfMvZmU2THZIZ2T+UTMtpj/dyMQsK4jHktb5ixxDPEliwGZalgnQcAvCUc2i2PeIsbvnKJp0TgQgiYIUOFV9z5/OwsXP1zxHxFeLflNLd9Dx1x//Q+0CQ3M/mRx3iCOEE4KPMZRmM30Um5yMpLXvJmgGr6qWDJTleOeK+6moG7ImoO5a5GvKiSl/P4AW+GoykXCGZTXDfcrnbIY+I7z+YquPwDzVzoCs6KeOcNRHFUWYf9rKftIhgVaQ9mdBlkJx51sKinOIsNS7IvREkvB59xTCYHutJSXFN7pQW8PRx9RSFw31LNXDPE1wYdE7n8o/tCTO0wuEyVnYxRu5bq7hOgLdPSQddsP4+9WcxOCHX00zbYaYxvOJ1KvMyVVtZakLrCajeAg12V9TtZRm+j3JnI6Qlg2BeNNiiHtd4qAwgCEmC7lM/ZQvXu7ij2PXJcL9qkZEUoZlUpiH9SFiXgB5EKAVdURK2eOGG0jmpDMOLGHWxoxp2Oi8z/Y8CFFWeP6o5t+so9XQItg8+avDX5bKavc3mICT7QrRv6kPM9j2sblC35oqmqqH1KPYGNQ7yDmomQ
DKIM-Signature: a=rsa-sha256; bh=Ko6SwvFfr+HvmA19ntsuFAqqMWHTI16hqCVTLo88Rfk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1777916088; v=1;
 b=GqK2Hu/ZVOOfGA/mACtjRXowgAt6gJR3k+l3d7WzL/1i16X6H9Kdk+QPM6uRAfEFHXjRnfaV
 f6gl+hwjw6Wv+E19wpKPDexKlYDVCUE1Nton9AGbVkgXvImJSGwFhdOOkziUhMCGeshsQ+YFahE
 r4mdI7dm+vDXpVti37fzKtqyZbzvQDRIyFkVv49yApkNSnF1SxsUjlU/06YHzDzRiAckPamI3FT
 +MBABO468qajMI5eLZ19kG8Ojg3V9Kc+c8u8eG8nP3vZLnW9/mHCpKcWH/Eh7/oLa6J30oh62eG
 nzS+b7vPxmhJUsynlk820t2VLjTwRhBt6P53KbZVVOsHg==
Received-SPF: pass client-ip=51.210.94.142; envelope-from=clg@kaod.org;
 helo=smtpout3.mo534.mail-out.ovh.net
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

Hello,

On 5/4/26 18:48, Alexander Hansen wrote:
> Initial patch based on [1] to support yosemite v4 bmc emulation.
> 
> The goal of this machine support is to support OpenBMC development.
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

A functional test would be greatly appreciated. This is especially
true since the other patches add new sensors.


> References:
> [1] https://github.com/9elements/qemu/commit/32139f913c2bd0ebe4bd26c46765861f6f9f2d49
> [2] arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> 
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
>   hw/arm/aspeed_ast2600_fby4.c | 298 +++++++++++++++++++++++++++++++++++
>   hw/arm/meson.build           |   1 +
>   2 files changed, 299 insertions(+)
>   create mode 100644 hw/arm/aspeed_ast2600_fby4.c
> 
> diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4.c
> new file mode 100644
> index 0000000000..84cd372838
> --- /dev/null
> +++ b/hw/arm/aspeed_ast2600_fby4.c
> @@ -0,0 +1,298 @@

This lacks a SPDX-License-Identifier and Copyright.

Did you run './scripts/checkpatch.pl' ?


> +#include <inttypes.h>
> +#include <stdbool.h>

Please remove

> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/arm/machines-qom.h"
> +#include "hw/arm/aspeed.h"
> +#include "hw/arm/aspeed_soc.h"
> +#include "hw/nvram/eeprom_at24c.h"
> +#include "hw/sensor/tmp105.h"
> +#include "hw/sensor/max31790.h"
> +#include "hw/sensor/max11615.h"
> +#include "hw/sensor/adc128d818.h"
> +#include "hw/i2c/i2c_mux_pca954x.h"
> +#include "hw/gpio/pca9552.h"
> +#include "system/reset.h"
> +
> +#define FBY4_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> +
> +/* START OF EEPROM CONTENTS */
> +
> +/*
> +./frugen -s board.mfg="Wiwynn" \
> +  --set board.pname="Fan Board FSC-MAX ADC-TI LED-NXP EFUSE-MAX" \
> +  --set text:board.pn="BRD-PN-345" \
> +  --board-date "10/1/2017 12:58:00" \
> +  --set board.serial="123456" \
> +  --set product.pname="Yosemite V4" \
> +  --set product.mfg="Wiwynn" \
> +  --set product.ver="v1.1" \
> +  --set product.serial="123456" \
> +  --set product.atag="PLACEHOLDER" \
> +  --set product.custom="Fanboard Custom1" \
> +  --set product.custom.1="Fanboard Custom2" \
> +  --set text:product.pn="PN-345" \
> +  fru-yv4-fanboard.bin
> +*/
> +/* EM Config: yosemite4_fanboard_fsc_max_adc_ti_led_nxp_ons_efuse_max.json */
> +/* Yosemite4 fan board */
> +unsigned char fru_yv4_fanboard_bin[] = {

this should be a "static const uint8_t'

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
> +unsigned int fru_yv4_fanboard_bin_len = 160;

static const size_t fru_yv4_fanboard_bin_len = sizeof(fru_yv4_fanboard_bin);

> +
> +/*
> +./frugen -s board.mfg="Wiwynn" \
> +  --set board.pname="Sentinel Dome without Retimer" \
> +  --set text:board.pn="BRD-PN-345" \
> +  --board-date "10/1/2017 12:58:00" \
> +  --set board.serial="123456" \
> +  --set product.pname="Yosemite V4" \
> +  --set product.mfg="Wiwynn" \
> +  --set product.ver="v1.1" \
> +  --set product.serial="123456" \
> +  --set product.atag="PLACEHOLDER" \
> +  --set product.custom="Yosemite V4 T1" \
> +  --set product.custom.1="Yosemite V4 T1" \
> +  --set text:product.pn="PN-345" \
> +  fru-yv4-sentineldome-board.bin
> +*/
> +/* product.cust maps to PRODUCT_INFO_AM2 */
> +/* EM Config: yosemite4_sentineldome_t1.json */
> +/* Yosemite4 Sentinel Dome without Retimer Boards */
> +unsigned char fru_yv4_sentineldome_board_bin[] = {
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
> +unsigned int fru_yv4_sentineldome_board_bin_len = 144;
> +
> +/*
> +./frugen -s board.mfg="Wiwynn" \
> +        --set board.pname="Sentinel Dome" \
> +        --set text:board.pn="BRD-PN-345" \
> +        --board-date "10/1/2017 12:58:00" \
> +        --set board.serial="123456" \
> +        --set product.pname="Yosemite V4" \
> +        --set product.mfg="Wiwynn" \
> +        --set product.ver="v1.1" \
> +        --set product.serial="123456" \
> +        --set product.atag="PLACEHOLDER" \
> +        --set text:product.pn="PN-345" \
> +        fru-yv4-sentineldome-chassis.bin
> +*/
> +/* EM Config: yosemite4_sentineldome_chassis.json */
> +/* Yosemite 4 Sentinel Dome Chassis FRU */
> +unsigned char fru_yv4_sentineldome_chassis_bin[] = {
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
> +unsigned int fru_yv4_sentineldome_chassis_bin_len = 112;
> +
> +/*
> +./frugen -s board.mfg="Wiwynn" \
> +      --set board.pname="Management Board wBMC" \
> +      --set text:board.pn="BRD-PN-345" \
> +      --board-date "10/1/2017 12:58:00" \
> +      --set board.serial="123456" \
> +      --set product.pname="Yosemite V4" \
> +      --set product.mfg="Wiwynn" \
> +      --set product.ver="v1.1" \
> +      --set product.serial="123456" \
> +      --set product.atag="PLACEHOLDER" \
> +      --set text:product.pn="PN-345" \
> +      fru-yv4-eclosure.bin
> +*/
> +/* EM Config: yosemite4_chassis.json, yosemite4.json */
> +/* Yosemite 4 Sentinel Dome Enclosure FRU */
> +unsigned char fru_yv4_eclosure_bin[] = {
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
> +unsigned int fru_yv4_eclosure_bin_len = 120;
> +
> +/* END OF EEPROM CONTENTS */
> +
> +static void fby4_i2c_init_fanboard(I2CSlave *fan_mux, size_t eepromSize)
> +{
> +

extra white line

> +    /* 2 fan boards */
> +    for (int i = 0; i <= 1; i++) {
> +        /* downstream bus */
> +        I2CBus *bus = pca954x_i2c_get_bus(fan_mux, i);
> +
> +        /* ti,adc128d818 @ 0x1f    (adc) */
> +        /* the driver will throw away the last 4 bits, set them 0 */
> +        uint16_t adc_values1[8] = {

I would define these arrays as read only data.

> +            0b011110000000, 0b010100010000,
> +            0b001000110000, 0b100000100000,
> +            0b011110000000, 0b010100010000,
> +            0b001000110000, 0b100000100000};
> +        adc128d818_init_with_values(bus,
> +                              0x1f, adc_values1, 8);

This could be on one line.

> +
> +        /* maxim,max31790 @ 0x20   (pwm) */
> +        i2c_slave_create_simple(bus,
> +                              TYPE_MAX31790, 0x20);

same here.

> +
> +        /*
> +         * ti,tca6424 @ 0x22       (gpio)
> +         * linux handles tca6424 with PCA953X_TYPE, same as pca9535
> +         * { "pca9535", 16 | PCA953X_TYPE | PCA_INT, },
> +         * { "tca6424", 24 | PCA953X_TYPE | PCA_INT, },
> +         * so we _could_ be fine here unless more than 16 gpios are used
> +         */
> +        i2c_slave_create_simple(bus,
> +                              TYPE_PCA9535, 0x22);
> +        /*
> +         * NOTE: above works and could use for gpio presence:
> +         * $ gpioget gpiochip2 2
> +         * 1
> +         */
> +
> +        /* maxim,max31790 @ 0x2f   (pwm) */
> +        i2c_slave_create_simple(bus,
> +                              TYPE_MAX31790, 0x2f);
> +
> +        /* maxim,max11615 @ 0x33   (adc) */
> +        uint16_t adc_values[8] = {
> +            0b011110000010, 0b010100011000,
> +            0b001000110100, 0b100000101001,
> +            0b011110000010, 0b010100011000,
> +            0b001000110100, 0b100000101001};
> +        max11615_init_with_values(bus,
> +                              0x33, adc_values, 8);
> +> +        at24c_eeprom_init_rom(
> +            bus, 0x52, eepromSize,
> +            fru_yv4_fanboard_bin,
> +            fru_yv4_fanboard_bin_len);
> +
> +        /* LED blink driver / gpio expander */
> +        /* nxp,pca9552 @ 0x61   (gpio) */
> +        i2c_slave_create_simple(bus,
> +                              TYPE_PCA9552, 0x61);
> +    }
> +}
> +
> +static void fby4_i2c_init_blade_chassis(I2CBus *bus, size_t eepromSize)
> +{
> +

Extra white line.

> +    /* Sentinel Dome Board EEPROMS */
> +    const uint8_t board_addr = 0x54;
> +    const uint8_t chassis_addr = 0x55;

These variables look unnecessary.

> +
> +    /* Board */
> +    at24c_eeprom_init_rom(bus, board_addr, eepromSize,
> +        fru_yv4_sentineldome_board_bin, fru_yv4_sentineldome_board_bin_len);
> +
> +    /* Chassis */
> +   at24c_eeprom_init_rom(bus, chassis_addr, eepromSize,
> +       fru_yv4_sentineldome_chassis_bin, fru_yv4_sentineldome_chassis_bin_len);
> +}
> +
> +static void fby4_i2c_init_multiple_blade_chassis(I2CBus **i2c,
> +    size_t eepromSize)
> +{
> +

Extra white line.


> +    /* there is 8 blade chassis, but we only emulate 2 for performance reason */
> +    for (int bus = 1; bus <= (8 / 4); bus++) {
> +
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
> +    const size_t eepromSize = 128 * KiB;
> +
> +    const uint8_t enclosure_addr = 0x51;
> +
> +    /* Enclosure (EM Config: yosemite4_chassis.json, yosemite4.json) */
> +    at24c_eeprom_init_rom(i2c[1], enclosure_addr, eepromSize,
> +        fru_yv4_eclosure_bin, fru_yv4_eclosure_bin_len);
> +
> +    fby4_i2c_init_multiple_blade_chassis(i2c, eepromSize);
> +
> +    /* Yv4 fanboard connection */
> +    I2CSlave *fan_mux = i2c_slave_create_simple(i2c[14], TYPE_PCA9546, 0x74);
> +
> +    fby4_i2c_init_fanboard(fan_mux, eepromSize);
> +}
> +
> +static void fby4_reset(MachineState *state, ResetType type)
> +{
> +    qemu_devices_reset(type);
> +}


not needed

> +static void aspeed_machine_fby4_class_init(ObjectClass *oc, const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc       = "Facebook fby4 BMC (Cortex-A7)";
> +    mc->reset      = fby4_reset;
> +    amc->fmc_model = "mx66l1g45g";
> +    amc->num_cs    = 2;
> +    amc->macs_mask = ASPEED_MAC3_ON;
> +    amc->i2c_init  = fby4_i2c_init;
> +    mc->default_ram_size = FBY4_BMC_RAM_SIZE;
> +    aspeed_machine_class_init_cpus_defaults(mc);
> +}> +
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

Thanks,

C.

