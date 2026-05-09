Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F55CD3445
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 16:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLkiC-0004dE-JS; Sat, 09 May 2026 12:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wLki9-0004ci-Ua
 for qemu-devel@nongnu.org; Sat, 09 May 2026 12:39:30 -0400
Received: from 6.mo533.mail-out.ovh.net ([54.36.140.181])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wLki5-0001eV-Nh
 for qemu-devel@nongnu.org; Sat, 09 May 2026 12:39:29 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4gCWsk3LDCz5vcS;
 Sat,  9 May 2026 16:39:22 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Sat,  9 May 2026 16:39:22 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.254.225])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gCWsk2WDFz1y2n;
 Sat,  9 May 2026 16:39:22 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 C40832403506; Sat,  9 May 2026 16:39:20 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S00210518935-2c11-484d-b7eb-47b5b52cab1b,
 3D272E53171ADE400D76652CEA3707ABC032970B) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <78ded35c-18d9-4469-a20d-6974646e4557@kaod.org>
Date: Sat, 9 May 2026 18:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] ast2600: yosemite4 initial support
To: Alexander Hansen <alexander.hansen@9elements.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org
References: <20260505154410.230969-1-alexander.hansen@9elements.com>
 <20260505154410.230969-5-alexander.hansen@9elements.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260505154410.230969-5-alexander.hansen@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 7150027361466690571
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF3+v8VG030dRAB/Wepp6Ate+jSwcpHh6xNLmRKa68OMXyJimzX4FeSrql+U0yx+Rf4hshr3RUUyMVNQjcw+I91oBManzancRqnVTjtmERmEDM38A5I2DRsDsWBrAZeSo7yk7VzWIqShbwe6nCvCwFfa4MHewVoXmhuA4sySycjSLwDjYW3OUMg+LVWwlmJyVbTFU69e3G+42x/EaxI8WzfLW9fsPFfycdH1le/uP8oMTQLPugBorvDvvDoxdnNKISf5x6bFDnL8R8XUse7qIcQsgM7XE/bgGoThDa9WtLPVFWWSPag5s9TpI6iFiHjrOzVppmh7A+BZIK4XHvE9ooMm7yTZoeOYwhlFrJEm0xhKk2gK7Z1tyzN2tltVWEuRs7s0AyhiClMTar9mUIz6S0EZzsHWXgzg08jxSRzd6JEe2oXYSygQWOSd9bZ/H0lHyZgqXOdYQnUvtiIbOy54okNv43Dkn3Y8TA2uJOcDxj6Xu8jy7xcxAcsW4om9HZcEFACbApUBN2NnlGpyqskciii9aN51szPpqbAO0EnoHIvQjMdQbhih9QXLuAxIc7XaAaSSXAfyOQ3AQFmQFhN1bgjGUGPQ7RFFBaceJU3npPtSNYQMcXy8Zye0pt++1vZ7l+8nKQ+c2fVEwQupZRP39SW3B1BmIGRJQUVb/DY6O/5QQ
DKIM-Signature: a=rsa-sha256; bh=CM+l34/VzNXmCvxCWMA++ljf70HfKMLeD1Btt3zFU/k=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1778344762; v=1;
 b=Y8JUtwuQzyDGQ6sjqTP0vnSnbU2U1zZF1MpoWheVPE7C5jQYc1kdW1kcjYD5/knwuUC3S6im
 VtefZBodFZvMLH06sId3Psc52uWvcWpg2rwUj++u7tihcboMtYuWoB+GnMCQIAEpG8vTD2Fmqa2
 g/vvklaxjp382cFpPmUhd4kYSP+WyQRbtEOlK2Mz07F9lb3DMaV+YZ73i9LZ9ucef1uAF/z9Fzb
 RKRxzITPAjZH/DS4MDZ+6mUas6acS29G7kKQzjuZ50notB+lY30UxtKtNmikXY0fvXiEofPQheO
 f9z0QSfyaCzHKQWeamdnQLMun10QTeDA8aElVpb/J8VDg==
Received-SPF: pass client-ip=54.36.140.181; envelope-from=clg@kaod.org;
 helo=6.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Alexander,

Could you please cc: me on the whole series ? I'd like to see
what the rest is about. However, I am not the sensor maintainer,
Titus is.

On 5/5/26 17:42, Alexander Hansen wrote:
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
> 
> Tested: functional test (see [5] for the image) passed.
> 
> ```

Please remove the markdown annotations. This is a git commit log.

> export QEMU_TEST_QEMU_BINARY=qemu-system-arm
> ./build/run tests/functional/arm/test_aspeed_fby4.py
> TAP version 13
> ok 1 test_aspeed_fby4.YosemiteV4Machine.test_arm_ast2600_yosemitev4_openbmc
> 1..1
> ```
> 
> References:
> [1] https://github.com/9elements/qemu/commit/32139f913c2bd0ebe4bd26c46765861f6f9f2d49
> [2] arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> [3] https://github.com/legoater/qemu-aspeed-boot/pull/5
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
>   hw/arm/aspeed_ast2600_fby4.c             | 289 +++++++++++++++++++++++
>   hw/arm/meson.build                       |   1 +
>   tests/functional/arm/meson.build         |   2 +
>   tests/functional/arm/test_aspeed_fby4.py |  44 ++++

I would prefer the functional test to be proposed in its own patch.

The machine looks good. Just a few minor comments.

>   4 files changed, 336 insertions(+)
>   create mode 100644 hw/arm/aspeed_ast2600_fby4.c
>   create mode 100755 tests/functional/arm/test_aspeed_fby4.py
> 
> diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4.c
> new file mode 100644
> index 0000000000..284f64e3f3
> --- /dev/null
> +++ b/hw/arm/aspeed_ast2600_fby4.c
> @@ -0,0 +1,289 @@
> +/*
> + * Yosemite V4
> + *
> + * Copyright 2026 9elements.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
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

I don't think this include is needed.


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
> +        /* the driver will throw away the last 4 bits, set them 0 */
> +        static const uint16_t adc_values1[8] = {
> +            0b011110000000, 0b010100010000,
> +            0b001000110000, 0b100000100000,
> +            0b011110000000, 0b010100010000,
> +            0b001000110000, 0b100000100000};
> +        adc128d818_init_with_values(bus, 0x1f, adc_values1, 8);
> +
> +        /* maxim,max31790 @ 0x20   (pwm) */
> +        i2c_slave_create_simple(bus, TYPE_MAX31790, 0x20);
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
> +        i2c_slave_create_simple(bus, TYPE_MAX31790, 0x2f);
> +
> +        /* maxim,max11615 @ 0x33   (adc) */
> +        static const uint16_t adc_values[8] = {
> +            0b011110000010, 0b010100011000,
> +            0b001000110100, 0b100000101001,
> +            0b011110000010, 0b010100011000,
> +            0b001000110100, 0b100000101001};
> +        max11615_init_with_values(bus, 0x33, adc_values, 8);
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
> +

Extra line.

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

These variables seem superflous.

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
> diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
> index 2f538f29a2..10c0006f22 100644
> --- a/tests/functional/arm/meson.build
> +++ b/tests/functional/arm/meson.build
> @@ -14,6 +14,7 @@ test_arm_timeouts = {
>     'aspeed_ast2600_sdk_otp' : 720,
>     'aspeed_bletchley' : 480,
>     'aspeed_catalina' : 480,
> +  'aspeed_fby4': 480,
>     'aspeed_gb200nvl_bmc' : 480,
>     'aspeed_rainier' : 480,
>     'bpim2u' : 500,
> @@ -47,6 +48,7 @@ tests_arm_system_thorough = [
>     'aspeed_ast2600_sdk_otp',
>     'aspeed_bletchley',
>     'aspeed_catalina',
> +  'aspeed_fby4',
>     'aspeed_gb200nvl_bmc',
>     'aspeed_rainier',
>     'bpim2u',
> diff --git a/tests/functional/arm/test_aspeed_fby4.py b/tests/functional/arm/test_aspeed_fby4.py
> new file mode 100755
> index 0000000000..9679e4a1c5
> --- /dev/null
> +++ b/tests/functional/arm/test_aspeed_fby4.py
> @@ -0,0 +1,44 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots the ASPEED machines
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import Asset
> +from aspeed import AspeedTest
> +
> +
> +class YosemiteV4Machine(AspeedTest):
> +
> +    ASSET_YOSEMITE_V4_FLASH = Asset(
> +        'https://github.com/pointbazaar/qemu-aspeed-boot/raw/3ef9a0d8cd2902c2039924ad1f16c8f2345486f3/images/yosemite4-bmc/openbmc-20260505132843/obmc-phosphor-image-yosemite4-20260505132843.static.mtd.xz',
> +        'dff6946363b41f952b15cfc3156482b89fcfc1b0ecfc3ec8b3ed496a5f001ef9')

Now that the yosemite4 image is merged in my image test tree, may be
it is best to update the asset ? As you wish. Works like that too.
  
> +
> +    def do_test_arm_aspeed_openbmc_no_network(self, machine, image, uboot,
> +                                   cpu_id, soc):
> +
> +        self.set_machine(machine)
> +        self.vm.set_console()
> +        self.vm.add_args('-drive', f'file={image},if=mtd,format=raw',
> +                         '-snapshot')
> +        self.vm.launch()
> +
> +        self.wait_for_console_pattern(f'U-Boot {uboot}')
> +        self.wait_for_console_pattern('## Loading kernel from FIT Image')
> +        self.wait_for_console_pattern('Starting kernel ...')
> +        self.wait_for_console_pattern(f'Booting Linux on physical CPU {cpu_id}')
> +        self.wait_for_console_pattern(f'ASPEED {soc}')
> +        self.wait_for_console_pattern('/init as init process')
> +        # yosemite v4 does not emit the hostname log which is
> +        # different from the other machines.
> +        self.wait_for_console_pattern('yosemite4 login:')
> +
> +    def test_arm_ast2600_yosemitev4_openbmc(self):
> +        image_path = self.uncompress(self.ASSET_YOSEMITE_V4_FLASH)
> +
> +        self.do_test_arm_aspeed_openbmc_no_network('fby4-bmc', image=image_path,
> +                                        uboot='2019.04', cpu_id='0xf00',
> +                                        soc='AST2600 rev A3')


I don't see any tests regarding the new sensor models.

The commit logs of patch 1-3 :

   hw/sensor: MAX31790 support
   hw/sensor: support MAX11615
   hw/sensor: support Texas Instruments ADC128D818

contain Linux command sequences that could be included in this test
case. Could you do that please ?

Also, for sensors, please cc:

  Titus Rwantare <titusr@google.com>

and we will need new entries under MAINTAINERS.

Thanks,

C.


