Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB55CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPCAe-0002W1-Si; Tue, 19 May 2026 00:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wPCAd-0002Td-TO
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:35:07 -0400
Received: from 12.mo533.mail-out.ovh.net ([178.33.248.79])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wPCAZ-0007AS-3e
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:35:07 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4gKMKJ0DfZz5vfZ;
 Tue, 19 May 2026 04:35:00 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Tue, 19 May 2026 04:34:59 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.0.142])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gKMKH66lzz7ths; Tue, 19 May 2026 04:34:59 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 219B12403B52; Tue, 19 May 2026 04:34:58 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R005241c00b8-9edc-40c6-b17b-a216e1a8b578,
 A1C5BDF50025601E7F63D663DE463AD2E6007479) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <51229c30-d2dd-4caf-9bf4-c54a18efa23e@kaod.org>
Date: Tue, 19 May 2026 06:34:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] hw/sensor: support Texas Instruments ADC128D818
To: Alexander Hansen <alexander.hansen@9elements.com>, qemu-devel@nongnu.org
Cc: Titus Rwantare <titusr@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20260515150610.381066-1-alexander.hansen@9elements.com>
 <20260515150610.381066-6-alexander.hansen@9elements.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260515150610.381066-6-alexander.hansen@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 16749731442131840239
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFNXTkbClxTeBgkHjWsSJTguv8sOIglYOvdigjL1qY3ls8DKHq6Dly71GE1jzBedgkySNyugPCqa0ezWg+ynVcndnPust2PYDzF1+3k+zwmHbT7Ks031mJYscCgYBYs+1ETZbjglhZft3l5D/qgpNap6XUnMcfZWywIdLLbSsn/s1nWFWr0hV8H6YRHRl9r8h7us+3d35JwAZl8566vvj/FwrSeOiRXwr3Th0gYMaEmvhy1VFohCkyACy345ZnojKouRZrXWjEWAYJiof4Ey5hoMrHPZKt7M0U6Jn6clFdc/JJaP/L2fDpCgo3HvQJfSqVEMca3Ibi440ZviNmgEQxMQ0K7ZS7HpJmmi6I8kknupGlSQT5bpkMYYPOTyJo7ZKMUiF6WntfsYGFM/Bvr6B3ysJbEL/CtDJEKN0DSto4tI+Bwhydk6DvFi/Mlw6EBEiiuF74NiaFaRQC4n0HbavCdIqRPD6EM2IbtQXnR58Sn1D3MDG646Lvec3qu9+S/4y9RpfDXh1Q67IXRBPq1A3I8CAySVDOlEeVKOYM7n0kh/ZRwnuO7ExL6t7ssYJmncU4Vfh+zt0w9iAC9HRKldguwidhrS0ay/qkNTwQppPa396ZYkB1MZqAavIH0++eSDS1JjobeAdlgO1+EnoXL4IbO3yr8U6Gx5leKY5AIn05ZhA
DKIM-Signature: a=rsa-sha256; bh=nmLwK46NiCV+xN1FMQcH0Bloe4hIfoB420hSFxDc44o=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1779165300; v=1;
 b=m6JTtznqdPBv3Qkhf2Kq+j2d+lNpTjEEj2UPJ7MmHZnZwfKWIBBdeC2NgR6OK73rBZRH/tlt
 3YQSJil9sksvVTWfM9fNVZ5s4MntPPgHanfNCNTQNMXIoH4VbrMf0PAYrVsNcoANHGoNofTLq5V
 vNCV+f1mH9i6bshO7mEQ6XgfByVZY1v9CybcLDfoZJvmTGBreijFwGlHTmwC42BA/Gz71CVOjlK
 EelIB/agkJLXcESrKUsRRUugp2fcEgwFshORUbq9nKHgi7fB1gROWrsQe4g6N1/RfE0IksDGf8p
 Wap5XiAq+ad8F7FttnCJpRvkURtIY7uZgx/xwuPQFaMpQ==
Received-SPF: pass client-ip=178.33.248.79; envelope-from=clg@kaod.org;
 helo=12.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/15/26 16:58, Alexander Hansen wrote:
> Product: [1]
> Datasheet: [2]
> 
> ADC128D818 Support:
> - channel readings from pre-set values
> - driver can read and write most configuration registers
> 
> ADC128D818 currently unsupported:
> - slave address restriction
> - startup sequence and realistic busy register emulation
> - external VREF
> - conversion rate
> - interrupts
> - deep shutdown mode
> - individual channel shutdown
> - selection between Mode 0,1,2,3
> - pseudo-differential input
> 
> Anyone could expand it in the future for more accurate emulation.
> 
> The reason for adding this device is to support Yosemite V4 emulation.
> 
> Tested: on yosemite v4 qemu
> 
> initialize the device:
> // ti,adc128d818 @ 0x1f    (adc)
> // the driver will throw away the last 4 bits, set them 0
> uint16_t adc_values1[8] = {
>      0b011110000000, 0b010100010000,
>      0b001000110000, 0b100000100000,
>      0b011110000000, 0b010100010000,
>      0b001000110000, 0b100000100000};
> adc128d818_init_with_values(bus, 0x1f, adc_values1, 8);
> 
> Trace outputs directly after initialization:
> adc128d818_realize i2c_addr: 0x1f
> adc128d818_realize i2c_addr: 0x1f
> adc128d818_event i2c_addr: 0x1f, event: 0x01
> adc128d818_send i2c_addr: 0x1f, data: 0x00
> adc128d818_send i2c_addr: 0x1f, data: 0x80
> adc128d818_write i2c_addr: 0x1f, reg: 0x00 data: 0x80
> adc128d818_event i2c_addr: 0x1f, event: 0x03
> adc128d818_event i2c_addr: 0x1f, event: 0x01
> ...
> 
> read the values
> root@yosemite4:/sys/bus/i2c/devices/30-001f# cat hwmon/hwmon0/in0_min
> 0
> root@yosemite4:/sys/bus/i2c/devices/30-001f# cat hwmon/hwmon0/in0_max
> 0
> root@yosemite4:/sys/bus/i2c/devices/30-001f# cat hwmon/hwmon0/in0_input
> 75
> root@yosemite4:/sys/bus/i2c/devices/30-001f# cat hwmon/hwmon0/name
> adc128d818
> 
> We initially configured 0b011110000000 for the first channel.
> The driver throws away the last 4 bits and does calculation similar to
> below:
> 
> val = DIV_ROUND_CLOSEST(data->in[index][nr] * data->vref, 4095);
> 
> We can check that the calculation is as expected given our configured
> value.
> 
> ((0b011110000000 >> 4) * 2560) / 4095
> 75.01831501831502
> 
> References:
> [1] https://www.ti.com/product/ADC128D818
> [2] https://www.ti.com/lit/gpn/adc128d818
> 
> Cc: Titus Rwantare <titusr@google.com>
> Cc: "Cédric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
> Cc: Paolo Bonzini <pbonzini@redhat.com> (maintainer:Kconfig)
> Cc: Peter Maydell <peter.maydell@linaro.org> (supporter:ARM TCG CPUs)
> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org> (odd fixer:Overall sensors)
> Cc: qemu-arm@nongnu.org (open list:ARM TCG CPUs)
> Cc: qemu-devel@nongnu.org (open list:All patches CC here)
> Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
> ---
>   MAINTAINERS                              |   1 +
>   include/hw/sensor/adc128d818.h           |  20 ++
>   hw/arm/aspeed_ast2600_fby4.c             |   9 +-
>   hw/sensor/adc128d818.c                   | 410 +++++++++++++++++++++++
>   hw/arm/Kconfig                           |   1 +
>   hw/sensor/Kconfig                        |   4 +
>   hw/sensor/meson.build                    |   1 +
>   hw/sensor/trace-events                   |   8 +
>   tests/functional/arm/test_aspeed_fby4.py |  10 +
>   9 files changed, 463 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/sensor/adc128d818.h
>   create mode 100644 hw/sensor/adc128d818.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 669d6e8344..bf4d157781 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3984,6 +3984,7 @@ PMBus
>   M: Titus Rwantare <titusr@google.com>
>   S: Maintained
>   F: hw/i2c/pmbus_device.c
> +F: hw/sensor/adc128d818.c
>   F: hw/sensor/adm1272.c
>   F: hw/sensor/isl_pmbus_vr.c
>   F: hw/sensor/max11615.c
> diff --git a/include/hw/sensor/adc128d818.h b/include/hw/sensor/adc128d818.h
> new file mode 100644
> index 0000000000..e2bdc47590
> --- /dev/null
> +++ b/include/hw/sensor/adc128d818.h
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

use /* */

> +#ifndef QEMU_ADC128D818_H
> +#define QEMU_ADC128D818_H
> +
> +#include <stdint.h>

<stdint.h> shouldn't be needed.

> +#include "hw/i2c/i2c.h"
> +
> +#define TYPE_ADC128D818 "adc128d818"
> +
> +/*
> + * Create and realize a adc128d818 ADC with constant caller-supplied readings
> + * @bus: I2C bus to put it on
> + * @address: I2C address
> + * @init_values: array of readings for each ADC channel
> + * @init_values_size: Size of @init_values, can be less than the number of channels
> + */
> +I2CSlave *adc128d818_init_with_values(I2CBus *bus, uint8_t address,
> +                                    const uint16_t *init_values, uint32_t init_values_size);
> +
> +#endif
> diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4.c
> index 45ed4a4c0f..c70ef43a61 100644
> --- a/hw/arm/aspeed_ast2600_fby4.c
> +++ b/hw/arm/aspeed_ast2600_fby4.c
> @@ -12,6 +12,7 @@
>   #include "hw/arm/aspeed_soc.h"
>   #include "hw/nvram/eeprom_at24c.h"
>   #include "hw/sensor/max11615.h"
> +#include "hw/sensor/adc128d818.h"
>   #include "hw/i2c/i2c_mux_pca954x.h"
>   #include "hw/gpio/pca9552.h"
>   
> @@ -162,7 +163,13 @@ static void fby4_i2c_init_fanboard(I2CSlave *fan_mux, size_t eepromSize)
>           I2CBus *bus = pca954x_i2c_get_bus(fan_mux, i);
>   
>           /* ti,adc128d818 @ 0x1f    (adc) */
> -        /* TODO */
> +        /* the driver will throw away the last 4 bits, set them 0 */
> +        static const uint16_t adc_values1[8] = {
> +            0b011110000000, 0b010100010000,
> +            0b001000110000, 0b100000100000,
> +            0b011110000000, 0b010100010000,
> +            0b001000110000, 0b100000100000};
> +        adc128d818_init_with_values(bus, 0x1f, adc_values1, 8);
>   
>           /* maxim,max31790 @ 0x20   (pwm) */
>           i2c_slave_create_simple(bus, "max31790", 0x20);
> diff --git a/hw/sensor/adc128d818.c b/hw/sensor/adc128d818.c
> new file mode 100644
> index 0000000000..e362e41788
> --- /dev/null
> +++ b/hw/sensor/adc128d818.c
> @@ -0,0 +1,410 @@
> +/*
> + * Texas Instruments ADC128D818 12 bit ADC with temperature sensor
> + * Models ADC128D818
> + *
> + * Product: https://www.ti.com/product/ADC128D818
> + * Datasheet: https://www.ti.com/lit/gpn/adc128d818
> + *
> + * Copyright 2026 9elements
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/i2c/i2c.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "trace.h"
> +#include "hw/sensor/adc128d818.h"
> +
> +/* 8 bit, r/w */
> +#define REG_CONFIG 0x00
> +
> +/* 8 bit, readonly */
> +#define REG_INTERRUPT_STATUS 0x01
> +
> +/* 8 bit, r/w */
> +#define REG_INTERRUPT_MASK 0x03
> +
> +/* 8 bit, r/w */
> +#define REG_CONVERSION_RATE 0x07
> +
> +/* 8 bit, r/w */
> +#define REG_CHANNEL_DISABLE 0x08
> +
> +/* 8 bit, write-only */
> +#define REG_ONE_SHOT 0x09
> +
> +/* 8 bit, r/w */
> +#define REG_DEEP_SHUTDOWN 0x0a
> +
> +/* 8 bit, r/w */
> +#define REG_ADVANCED_CONFIG 0x0b
> +
> +/* 8 bit, readonly */
> +#define REG_BUSY_STATUS 0x0c
> +
> +/* 16 bit registers, N = 0..7, readonly */
> +#define REG_CHANNEL_READING(N) (0x20 + N)
> +
> +/* 8 bit registers N = 0..15, r/w */
> +#define REG_LIMIT(N) (0x2a + N)
> +
> +/* 8 bit register, readonly */
> +#define REG_MANUFACTURER_ID 0x3e
> +
> +/* 8 bit register, readonly */
> +#define REG_REVISION_ID 0x3f
> +
> +#define ADC128D818_NUM_CHANNELS 8
> +
> +struct ADC128D818State {
> +    I2CSlave i2c;
> +
> +    uint8_t config;
> +    uint8_t interrupt_mask;
> +    uint8_t conversion_rate;
> +    uint8_t channel_disable;
> +    bool deep_shutdown;
> +    uint8_t advanced_config;
> +
> +    /* channel reading registers, 2 bytes each */
> +    uint16_t channels[ADC128D818_NUM_CHANNELS];
> +
> +    /* high and low limit registers 0x2a - 0x39, one byte each */
> +    uint8_t limit[ADC128D818_NUM_CHANNELS * 2];
> +
> +    /* input buffer */
> +    uint8_t len;
> +    uint8_t buf[2];
> +
> +    /* output buffer */
> +    uint8_t outlen;
> +    uint8_t outbuf[2];
> +
> +    /* selected channel for read/write operation */
> +    uint8_t pointer;
> +};
> +
> +struct ADC128D818Class {
> +    I2CSlaveClass parent_class;
> +};
> +
> +OBJECT_DECLARE_TYPE(ADC128D818State, ADC128D818Class, ADC128D818)
> +
> +static void adc128d818_read(ADC128D818State *s)
> +{
> +    uint8_t ch_num = 0;
> +    switch (s->pointer) {
> +    case REG_CONFIG:
> +        s->outbuf[0] = s->config;
> +        break;
> +    case REG_INTERRUPT_STATUS:
> +        s->outbuf[0] = 0x0; /* POR State */
> +        break;
> +    case REG_INTERRUPT_MASK:
> +        s->outbuf[0] = s->interrupt_mask;
> +        break;
> +    case REG_CONVERSION_RATE:
> +        s->outbuf[0] = s->conversion_rate;
> +        break;
> +    case REG_CHANNEL_DISABLE:
> +        s->outbuf[0] = s->channel_disable;
> +        break;
> +    case REG_ONE_SHOT:
> +        /* not marked as readable */
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: read of register 0x%02x\n",
> +                      __func__, s->pointer);
> +        s->outbuf[0] = 0x0;
> +        break;
> +    case REG_DEEP_SHUTDOWN:
> +        s->outbuf[0] = s->deep_shutdown ? 0x1 : 0x0;
> +        break;
> +    case REG_ADVANCED_CONFIG:
> +        s->outbuf[0] = s->advanced_config & 0b111;
> +        break;
> +    case REG_BUSY_STATUS:
> +        /* not implemented */
> +        s->outbuf[0] = 0b00000010; /* POR State */
> +        break;
> +    case REG_CHANNEL_READING(0):
> +    case REG_CHANNEL_READING(1):
> +    case REG_CHANNEL_READING(2):
> +    case REG_CHANNEL_READING(3):
> +    case REG_CHANNEL_READING(4):
> +    case REG_CHANNEL_READING(5):
> +    case REG_CHANNEL_READING(6):
> +    case REG_CHANNEL_READING(7):
> +        ch_num = s->pointer - REG_CHANNEL_READING(0);
> +        /* high byte comes first, driver reads swapped */
> +        s->outbuf[0] = (s->channels[ch_num] >> 8) & 0xff;
> +        s->outbuf[1] = s->channels[ch_num] & 0xff;
> +        break;
> +    case REG_LIMIT(0):
> +    case REG_LIMIT(1):
> +    case REG_LIMIT(2):
> +    case REG_LIMIT(3):
> +    case REG_LIMIT(4):
> +    case REG_LIMIT(5):
> +    case REG_LIMIT(6):
> +    case REG_LIMIT(7):
> +    case REG_LIMIT(8):
> +    case REG_LIMIT(9):
> +    case REG_LIMIT(10):
> +    case REG_LIMIT(11):
> +    case REG_LIMIT(12):
> +    case REG_LIMIT(13):
> +    case REG_LIMIT(14):
> +    case REG_LIMIT(15):
> +        s->outbuf[0] = s->limit[s->pointer - REG_LIMIT(0)];
> +        break;
> +    case REG_MANUFACTURER_ID:
> +        s->outbuf[0] = 0x1; /* readonly */
> +        break;
> +    case REG_REVISION_ID:
> +        s->outbuf[0] = 0b00001001; /* readonly */
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: read of register 0x%02x\n",
> +                      __func__, s->pointer);
> +        break;
> +    }
> +}
> +
> +static void adc128d818_write_advanced_config(ADC128D818State *s, uint8_t data)
> +{
> +    /*
> +     * Note: Whenever the Advanced Configuration Register is programmed,
> +     * all of the values in the Channel Reading Registers and
> +     * Interrupt Status Registers will return to their default values.
> +     */

This is not what the code is doing.

> +
> +    s->advanced_config = (data & 0b111);
> +}
> +
> +static void adc128d818_write(ADC128D818State *s, uint8_t data)
> +{
> +    trace_adc128d818_write(s->i2c.address, s->pointer, data);
> +
> +    /* which bits in config register are writable */
> +    const uint8_t config_w_mask = 0b10001011;
> +    const uint8_t config_ro_mask = (uint8_t)~config_w_mask;
> +
> +    switch (s->pointer) {
> +    case REG_CONFIG:
> +        s->config = (s->config & config_ro_mask) | (data & config_w_mask);
> +        break;
> +    case REG_INTERRUPT_MASK:
> +        s->interrupt_mask = data;
> +        break;
> +    case REG_CONVERSION_RATE:
> +        s->conversion_rate = data;
> +        break;
> +    case REG_CHANNEL_DISABLE:
> +        s->channel_disable = data;
> +        break;
> +    case REG_ONE_SHOT:
> +        /*
> +         * Initiate a single conversion and comparison cycle when
> +         * the device is in shutdown mode or deep shutdown mode, after
> +         * which the device returns to the respective mode that it was in
> +         *
> +         */
> +        break;
> +    case REG_DEEP_SHUTDOWN:
> +        s->deep_shutdown = (data & 0x1) != 0;
> +        break;
> +    case REG_ADVANCED_CONFIG:
> +        adc128d818_write_advanced_config(s, data);
> +        break;
> +    case REG_LIMIT(0):
> +    case REG_LIMIT(1):
> +    case REG_LIMIT(2):
> +    case REG_LIMIT(3):
> +    case REG_LIMIT(4):
> +    case REG_LIMIT(5):
> +    case REG_LIMIT(6):
> +    case REG_LIMIT(7):
> +    case REG_LIMIT(8):
> +    case REG_LIMIT(9):
> +    case REG_LIMIT(10):
> +    case REG_LIMIT(11):
> +    case REG_LIMIT(12):
> +    case REG_LIMIT(13):
> +    case REG_LIMIT(14):
> +    case REG_LIMIT(15):
> +        s->limit[s->pointer - REG_LIMIT(0)] = data;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: write of register 0x%02x\n",
> +                      __func__, s->pointer);
> +        break;
> +    }
> +}
> +
> +static int adc128d818_send(I2CSlave *i2c, uint8_t data)
> +{
> +    ADC128D818State *s = ADC128D818(i2c);
> +    trace_adc128d818_send(s->i2c.address, data);
> +
> +    s->outlen = 0;
> +    s->buf[s->len] = data;

Dangerous array access.

> +
> +    if (s->len == 0) {
> +        s->pointer = data;
> +    } else if (s->len == 1) {
> +        adc128d818_write(s, data);
> +    }
> +
> +    s->len++;
> +    return 0;
> +}
> +
> +static uint8_t adc128d818_recv(I2CSlave *i2c)
> +{
> +    ADC128D818State *s = ADC128D818(i2c);
> +    trace_adc128d818_recv(s->i2c.address, s->pointer);
> +
> +    adc128d818_read(s);
> +
> +    if (s->outlen >= 2) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: too many bytes read\n", __func__);
> +        s->outlen = 0;
> +    }
> +
> +    const uint8_t data = s->outbuf[s->outlen++];
> +
> +    trace_adc128d818_recv_return(s->i2c.address, data);
> +    return data;
> +}
> +
> +static int adc128d818_event(I2CSlave *i2c, enum i2c_event event)
> +{
> +    ADC128D818State *s = ADC128D818(i2c);
> +
> +    trace_adc128d818_event(s->i2c.address, event);
> +
> +    switch (event) {
> +    case I2C_START_RECV:
> +        s->outlen = 0;
> +        break;
> +    case I2C_START_SEND:
> +        s->len = 0;
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_adc128d818 = {
> +    .name = TYPE_ADC128D818,
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields =
> +        (const VMStateField[]){
> +            VMSTATE_UINT8(config, ADC128D818State),
> +            VMSTATE_UINT8(interrupt_mask, ADC128D818State),
> +            VMSTATE_UINT8(conversion_rate, ADC128D818State),
> +            VMSTATE_UINT8(channel_disable, ADC128D818State),
> +            VMSTATE_BOOL(deep_shutdown, ADC128D818State),
> +            VMSTATE_UINT8(advanced_config, ADC128D818State),
> +            VMSTATE_UINT16_ARRAY(channels, ADC128D818State,
> +                                 ADC128D818_NUM_CHANNELS),
> +            VMSTATE_UINT8_ARRAY(limit, ADC128D818State,
> +                                ADC128D818_NUM_CHANNELS * 2),
> +            VMSTATE_UINT8(len, ADC128D818State),
> +            VMSTATE_UINT8_ARRAY(buf, ADC128D818State, 2),
> +            VMSTATE_UINT8(outlen, ADC128D818State),
> +            VMSTATE_UINT8_ARRAY(outbuf, ADC128D818State, 2),
> +            VMSTATE_UINT8(pointer, ADC128D818State),
> +            VMSTATE_I2C_SLAVE(i2c, ADC128D818State), VMSTATE_END_OF_LIST() }
> +};
> +
> +static void adc128d818_init(Object *obj) { /* Nothing to do */ }

please remove.

> +
> +I2CSlave *adc128d818_init_with_values(I2CBus *bus, uint8_t address,
> +                                      const uint16_t *init_values,
> +                                      uint32_t init_values_size)
> +{
> +    ADC128D818State *s;
> +
> +    s = ADC128D818(i2c_slave_new(TYPE_ADC128D818, address));
> +
> +    for (int i = 0; i < ADC128D818_NUM_CHANNELS; i++) {
> +
> +        /* arbitrary value */
> +        uint16_t value = 0b0000101011010010;
> +
> +        if (i < init_values_size) {

same problem as max11615_init_with in previous patch.

> +            value = init_values[i];
> +        }
> +        s->channels[i] = value;
> +    }
> +
> +    i2c_slave_realize_and_unref(I2C_SLAVE(s), bus, &error_abort);
> +
> +    return I2C_SLAVE(s);
> +}
> +
> +static void adc128d818_reset(DeviceState *dev)
> +{
> +    ADC128D818State *s = ADC128D818(dev);
> +
> +    s->pointer = 0;
> +    s->outlen = 0;
> +
> +    /* POR-State */
> +    s->config = 0b00001000;
> +    s->interrupt_mask = 0;
> +    s->conversion_rate = 0;
> +    s->channel_disable = 0;
> +    s->deep_shutdown = 0;
> +    s->advanced_config = 0;
> +
> +    /* No POR-State defined in datasheet */
> +    for (int i = 0; i < ADC128D818_NUM_CHANNELS * 2; i++) {
> +        s->limit[i] = 0;
> +    }

reset channels[] too ?


> +}
> +
> +static void adc128d818_realize(DeviceState *dev, Error **errp)
> +{
> +    ADC128D818State *s = ADC128D818(dev);
> +
> +    trace_adc128d818_realize(s->i2c.address);
> +}
> +
> +static void adc128d818_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +
> +    dc->realize = adc128d818_realize;
> +    dc->desc = "Texas Instruments ADC128D818 12-bit ADC with temp sensor";
> +    dc->vmsd = &vmstate_adc128d818;
> +    dc->legacy_reset = adc128d818_reset;
> +    k->event = adc128d818_event;
> +    k->recv = adc128d818_recv;
> +    k->send = adc128d818_send;
> +}
> +
> +static const TypeInfo adc128d818_info = {
> +    .name = TYPE_ADC128D818,
> +    .parent = TYPE_I2C_SLAVE,
> +    .instance_size = sizeof(ADC128D818State),
> +    .class_size = sizeof(ADC128D818Class),
> +    .instance_init = adc128d818_init,
> +    .class_init = adc128d818_class_init,
> +};
> +
> +static void adc128d818_register_types(void)
> +{
> +    type_register_static(&adc128d818_info);
> +}
> +
> +type_init(adc128d818_register_types)
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 76a7d327a9..cc89c65e3f 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -554,6 +554,7 @@ config ASPEED_SOC
>       select MAX31785
>       select MAX31790
>       select MAX11615
> +    select ADC128D818
>       select FSI_APB2OPB_ASPEED
>       select AT24C
>       select PCI_EXPRESS
> diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
> index 84eede9d84..c9190ff780 100644
> --- a/hw/sensor/Kconfig
> +++ b/hw/sensor/Kconfig
> @@ -51,3 +51,7 @@ config MAX31790
>   config MAX11615
>       bool
>       depends on I2C
> +
> +config ADC128D818
> +    bool
> +    depends on I2C
> diff --git a/hw/sensor/meson.build b/hw/sensor/meson.build
> index a1e26604fa..defd7647e7 100644
> --- a/hw/sensor/meson.build
> +++ b/hw/sensor/meson.build
> @@ -10,3 +10,4 @@ system_ss.add(when: 'CONFIG_ISL_PMBUS_VR', if_true: files('isl_pmbus_vr.c'))
>   system_ss.add(when: 'CONFIG_MAX31785', if_true: files('max31785.c'))
>   system_ss.add(when: 'CONFIG_MAX31790', if_true: files('max31790.c'))
>   system_ss.add(when: 'CONFIG_MAX11615', if_true: files('max11615.c'))
> +system_ss.add(when: 'CONFIG_ADC128D818', if_true: files('adc128d818.c'))
> diff --git a/hw/sensor/trace-events b/hw/sensor/trace-events
> index 3fed979e85..4853f1944d 100644
> --- a/hw/sensor/trace-events
> +++ b/hw/sensor/trace-events
> @@ -20,3 +20,11 @@ max11615_recv(uint8_t i2c_addr, uint8_t reg_addr) "i2c_addr: 0x%02x, reg_addr: 0
>   max11615_recv_return(uint8_t i2c_addr, uint8_t data) "i2c_addr: 0x%02x, returns: 0x%02x"
>   max11615_event(uint8_t i2c_addr, uint8_t event) "i2c_addr: 0x%02x, event: 0x%02x"
>   max11615_realize(uint8_t i2c_addr) "i2c_addr: 0x%02x"
> +
> +# adc128d818.c
> +adc128d818_send(uint8_t i2c_addr, uint8_t data) "i2c_addr: 0x%02x, data: 0x%02x"
> +adc128d818_write(uint8_t i2c_addr, uint8_t reg, uint8_t data) "i2c_addr: 0x%02x, reg: 0x%02x data: 0x%02x"
> +adc128d818_recv(uint8_t i2c_addr, uint8_t reg) "i2c_addr: 0x%02x, reg: 0x%02x"
> +adc128d818_recv_return(uint8_t i2c_addr, uint8_t data) "i2c_addr: 0x%02x, returns: 0x%02x"
> +adc128d818_event(uint8_t i2c_addr, uint8_t event) "i2c_addr: 0x%02x, event: 0x%02x"
> +adc128d818_realize(uint8_t i2c_addr) "i2c_addr: 0x%02x"
> diff --git a/tests/functional/arm/test_aspeed_fby4.py b/tests/functional/arm/test_aspeed_fby4.py
> index 319f1a7672..883e058832 100755
> --- a/tests/functional/arm/test_aspeed_fby4.py
> +++ b/tests/functional/arm/test_aspeed_fby4.py
> @@ -59,6 +59,16 @@ def do_test_arm_aspeed_openbmc_no_network(self, machine, image, uboot,
>           exec_command_and_wait_for_pattern(self,
>               "cat /sys/bus/iio/devices/iio:device2/in_voltage_scale", "0.500000000");
>   
> +        # ADC128D818 test
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/bus/i2c/devices/30-001f/hwmon/hwmon0/name", "adc128d818");
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/bus/i2c/devices/30-001f/hwmon/hwmon0/in0_input", "75");
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/bus/i2c/devices/30-001f/hwmon/hwmon0/in0_min", "0");
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/bus/i2c/devices/30-001f/hwmon/hwmon0/in0_max", "0");
> +
>       def test_arm_ast2600_yosemitev4_openbmc(self):
>           image_path = self.uncompress(self.ASSET_YOSEMITE_V4_FLASH)
>   

Thanks,

C.


