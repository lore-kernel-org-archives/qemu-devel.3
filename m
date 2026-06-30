Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854B3C43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wePkA-0002H3-CO; Tue, 30 Jun 2026 00:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wePk4-0002GJ-Rf
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:06:36 -0400
Received: from smtpout1.mo537.mail-out.ovh.net ([51.210.91.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wePjv-0004Ap-Df
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:06:34 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4gq8hv1LfYz3xhq;
 Tue, 30 Jun 2026 04:06:23 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Tue, 30 Jun 2026 04:06:23 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.0.151])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gq8hv0095z5vM4;
 Tue, 30 Jun 2026 04:06:22 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id A8355203D1A; 
 Tue, 30 Jun 2026 04:06:21 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004027f73b9-59b9-4a6a-a7c8-29a2ea58b713,
 C9F07EB534A46111D337A1875201B4A1724CF27E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <0fee9fe8-abe5-4712-a3c0-e46fb2ee26fc@kaod.org>
Date: Tue, 30 Jun 2026 06:06:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] hw/sensor: MAX31790 support
To: alexander.hansen@9elements.com, qemu-devel@nongnu.org
Cc: eblot@meta.com, titusr@google.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-arm@nongnu.org, Titus Rwantare <titusr@google.com>
References: <20260619115533.5664-1-alexander.hansen@9elements.com>
 <20260619115533.5664-4-alexander.hansen@9elements.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260619115533.5664-4-alexander.hansen@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 4665447739663428847
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFIkpuNE1ozDngAiy740wDcevvrG7ZNP+tRCde3PO/LxJRsxdCzSznaGnleiVslUhX4M2LtHrJ2VT8gbS6eEIijrop9yWTt9Os3HBQxpupD8Bgn76pgX06Y8FhJhSINR1SvAbhKj08Cm6ks/KDAxFUAdyY1tL4PqE8jAnxuR4enadYKwAucdJ1Qq4UyTMKIZG+E1Hg7wb02ivpiLjh7m4ip+mPEpBbwY/3AdXRaomp78KS6Y5CIDwd3tUMdri//rpbrX78985CWNeuL6EuhEHSatYex8HBGao9HkDjbjMimfrJm9ds5rVf3ospVXM8h8rZiRrN72e1AiWHNfdObfsk7Shzza+uQa1iaweAC/eGJvsjIG8ztWtbEpC4W7/Ft/m2zoEazTB7aE4OcSrrohw79xWeYI9E+7UH+eCTO1MEzLUVngDDtDOkfPTp4n7G/fh6WSp71d8LsX7g3+Vhn+Z1Q+BxXRSQ/UqVLTVG5j0x8E4ONi3bUz9anmL4ci9hIjgiW3lhiKJ1a5T25rMpL4exZM4QAlG9/0nA/4p66P/f54ua1LPn8Pd+dtp3Jfqd2+cgVxRnzweV59LpBcB+SyRCsIUBXNM6Gl7dwKrTwP2sC0gTw25+y4sIv0CFsEfwanJrTYPtddzn/OtC73+b6/fzIyH6zOzlUTLSfvg7mqC+0Dg
DKIM-Signature: a=rsa-sha256; bh=Xm8UCN/gU1MKaL/nMIkvDrtSJNt+BvSSnJyfmqW7djc=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1782792383; v=1;
 b=QduR7HeySgipQ4awqsn7+CT5rNmRpMvUoXhISUX7EqnbThPN+Hx16rQO6ZlVM198VnHvMrZw
 QkhUDm6QGics5/+HzrYbaCMkbxePW5AUiT6UF1EhW8SZz3IoUUnG/33Htx67UiJxEF5Gamp0Srw
 A9ephv0iUbosjN9XHNJAnKZ8tzIs+Y3KgKnosCjJxMcG+Xp2qIQkTDAVoA3SaRCG1wVSl3cM16F
 +jv678wmzHCS29h2vf41BoajCDFtJOuEex6rHkuE1f9xhigtWXWVvDfQKJD01oZ2l3A4IXzp6li
 xbZaVscgBp1edOafnGJNLMLufz5TtxVgRZ+AAjguzdl8Q==
Received-SPF: pass client-ip=51.210.91.20; envelope-from=clg@kaod.org;
 helo=smtpout1.mo537.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hello,

Could the sensors Maintainers take a look please ?

Thanks,

C.


On 6/19/26 13:55, alexander.hansen@9elements.com wrote:
> From: Alexander Hansen <alexander.hansen@9elements.com>
> 
> Product: [1]
> Datasheet: [2]
> 
> MAX31790 Support:
> - fan inputs are reading
> - tach reading propertional to pwm setting from linux driver
> - fans do not show any fault
> - 6 PWM registers influence 6 TACH registers
> 
> There is intentional stub behavior in some places and various functions
> of the device are currently unsupported.
> 
> MAX31790 currently unsupported:
> - slave address restriction
> - fan dynamics
> - spin-up configuration
> - fault state / failure possibility
> - rate-of-change control
> - tach mode
> - mixed layouts where number of fans != number of tachs
> - see Figure 5.9 in [2] for example of mixed layout
> 
> Anyone could expand it in the future for more accurate emulation.
> 
> The reason for adding this device is to support Yosemite V4 emulation.
> 
> Tested: on yosemite 4 qemu
> 
> root@yosemite4:~# ls /sys/class/hwmon/hwmon2/
> device	    fan2_fault   fan3_target  fan5_fault   fan6_target  pwm2	     pwm5
> fan1_enable  fan2_input   fan4_enable  fan5_input   name	pwm2_enable  pwm5_enable
> fan1_fault   fan2_target  fan4_fault   fan5_target  of_node	pwm3	     pwm6
> fan1_input   fan3_enable  fan4_input   fan6_enable  power	pwm3_enable  pwm6_enable
> fan1_target  fan3_fault   fan4_target  fan6_fault   pwm1	pwm4	     subsystem
> fan2_enable  fan3_input   fan5_enable  fan6_input   pwm1_enable  pwm4_enable  uevent
> root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_input
> 4551
> root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_enable
> 1
> root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_fault
> 0
> root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_target
> 2048
> root@yosemite4:~# cat /sys/class/hwmon/hwmon2/pwm1
> 178
> root@yosemite4:~# cat /sys/class/hwmon/hwmon2/name
> max31790
> 
> Trace output:
> max31790_realize i2c_addr: 0x20
> max31790_realize i2c_addr: 0x2f
> max31790_realize i2c_addr: 0x20
> max31790_realize i2c_addr: 0x2f
> max31790_event i2c_addr: 0x20, event: 0x01
> max31790_send i2c_addr: 0x20, data: 0x02
> max31790_event i2c_addr: 0x20, event: 0x00
> max31790_recv i2c_addr: 0x20, reg_addr: 0x02
> max31790_recv_return i2c_addr: 0x20, returns: 0x08
> ...
> 
> References:
> [1] https://www.analog.com/en/products/MAX31790.html
> [2] https://www.analog.com/media/en/technical-documentation/data-sheets/MAX31790.pdf
> 
> Cc: Emmanuel Blot <eblot@meta.com>
> Cc: Titus Rwantare <titusr@google.com>
> Cc: "Cédric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org
> Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
> ---
>   MAINTAINERS                              |   1 +
>   hw/arm/Kconfig                           |   1 +
>   hw/arm/aspeed_ast2600_fby4.c             |   4 +-
>   hw/sensor/Kconfig                        |   4 +
>   hw/sensor/max31790.c                     | 584 +++++++++++++++++++++++
>   hw/sensor/meson.build                    |   1 +
>   hw/sensor/trace-events                   |  13 +
>   tests/functional/arm/test_aspeed_fby4.py |  47 ++
>   8 files changed, 653 insertions(+), 2 deletions(-)
>   create mode 100644 hw/sensor/max31790.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93df53d87f..e3df75f7bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3993,6 +3993,7 @@ S: Maintained
>   F: hw/i2c/pmbus_device.c
>   F: hw/sensor/adm1272.c
>   F: hw/sensor/isl_pmbus_vr.c
> +F: hw/sensor/max31790.c
>   F: hw/sensor/max34451.c
>   F: include/hw/i2c/pmbus_device.h
>   F: include/hw/sensor/isl_pmbus_vr.h
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 500bfdfe2a..43e96a671b 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -553,6 +553,7 @@ config ASPEED_SOC
>       select LED
>       select PMBUS
>       select MAX31785
> +    select MAX31790
>       select FSI_APB2OPB_ASPEED
>       select AT24C
>       select PCI_EXPRESS
> diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4.c
> index 03f54d4393..8feb31bc44 100644
> --- a/hw/arm/aspeed_ast2600_fby4.c
> +++ b/hw/arm/aspeed_ast2600_fby4.c
> @@ -164,7 +164,7 @@ static void fby4_i2c_init_fanboard(I2CSlave *fan_mux, size_t eepromSize)
>           /* TODO */
>   
>           /* maxim,max31790 @ 0x20   (pwm) */
> -        /* TODO */
> +        i2c_slave_create_simple(bus, "max31790", 0x20);
>   
>           /*
>            * ti,tca6424 @ 0x22       (gpio)
> @@ -182,7 +182,7 @@ static void fby4_i2c_init_fanboard(I2CSlave *fan_mux, size_t eepromSize)
>            */
>   
>           /* maxim,max31790 @ 0x2f   (pwm) */
> -        /* TODO */
> +        i2c_slave_create_simple(bus, "max31790", 0x2f);
>   
>           /* maxim,max11615 @ 0x33   (adc) */
>           /* TODO */
> diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
> index bc6331b4ab..767f198e92 100644
> --- a/hw/sensor/Kconfig
> +++ b/hw/sensor/Kconfig
> @@ -43,3 +43,7 @@ config ISL_PMBUS_VR
>   config MAX31785
>       bool
>       depends on PMBUS
> +
> +config MAX31790
> +    bool
> +    depends on I2C
> diff --git a/hw/sensor/max31790.c b/hw/sensor/max31790.c
> new file mode 100644
> index 0000000000..af610376d1
> --- /dev/null
> +++ b/hw/sensor/max31790.c
> @@ -0,0 +1,584 @@
> +/*
> + * Maxim MAX31790 PMBus 6-Channel Fan Controller
> + *
> + * Datasheet:
> + * https://www.analog.com/media/en/technical-documentation/data-sheets/MAX31790.pdf
> + *
> + * Copyright 2026 9elements
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/i2c/i2c.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
> +#include "migration/vmstate.h"
> +#include "qemu/module.h"
> +#include "qom/object.h"
> +#include "trace.h"
> +
> +#define TYPE_MAX31790 "max31790"
> +
> +#define MAX31790_NUM_FANS 6
> +#define MAX31790_NUM_TACHS 12
> +
> +#define MAX31790_REG_GLOBAL_CONFIG 0x00
> +#define MAX31790_REG_PWM_FREQ 0x01
> +
> +/* 0x02 to 0x07: N = 0 .. 5 */
> +#define MAX31790_REG_FAN_CONFIG(N) (0x02 + (N))
> +
> +/* 0x08 to 0x0d: N = 0 .. 5 */
> +#define MAX31790_REG_FAN_DYNAMICS(N) (0x08 + (N))
> +
> +#define MAX31790_REG_FAN_FAULT_STATUS_2 0x10
> +#define MAX31790_REG_FAN_FAULT_STATUS_1 0x11
> +#define MAX31790_REG_FAN_FAULT_MASK_2 0x12
> +#define MAX31790_REG_FAN_FAULT_MASK_1 0x13
> +#define MAX31790_REG_FAILED_FAN_OPT 0x14
> +
> +/* 0x18 to 0x2f: N = 0 .. 11 */
> +#define MAX31790_REG_TACH_COUNT_MSB(N) (0x18 + 2 * (N))
> +#define MAX31790_REG_TACH_COUNT_LSB(N) (0x19 + 2 * (N))
> +
> +/* 0x30 to 0x3b: N = 0 .. 5 */
> +#define MAX31790_REG_PWM_DUTY_CYCLE_MSB(N) (0x30 + 2 * (N))
> +#define MAX31790_REG_PWM_DUTY_CYCLE_LSB(N) (0x31 + 2 * (N))
> +
> +/* .. reserved registers ... */
> +
> +/* 0x40 to 0x4b: N = 0 .. 5 */
> +#define MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(N) (0x40 + 2 * (N))
> +#define MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(N) (0x41 + 2 * (N))
> +
> +/* ... 'User Byte' registers ... */
> +
> +/* 0x50 to 0x5b: N = 0 .. 5 */
> +#define MAX31790_REG_TACH_TARGET_COUNT_MSB(N) (0x50 + 2 * (N))
> +#define MAX31790_REG_TACH_TARGET_COUNT_LSB(N) (0x51 + 2 * (N))
> +
> +struct MAX31790State {
> +    I2CSlave i2c;
> +
> +    uint8_t fan_config[MAX31790_NUM_FANS];
> +    uint8_t fan_dynamics[MAX31790_NUM_FANS];
> +
> +    uint16_t pwm[MAX31790_NUM_FANS];
> +    uint16_t tach_target[MAX31790_NUM_FANS];
> +
> +    /*
> +     * Fan speed is measured by counting the number of internal 8192Hz
> +     * (fTOSC/4) clock cycles that take place during a select-
> +     * able number of tachometer periods. The number of clock
> +     * cycles counted (11-bit value) is stored in the associated
> +     * TACH Count registers and the desired number of cycles
> +     * is stored in the TACH Target Count registers.
> +     */
> +    uint16_t tach_count[MAX31790_NUM_TACHS];
> +
> +    /* command buffer */
> +    uint8_t len;
> +    uint8_t buf[2];
> +
> +    /* output buffer */
> +    uint8_t outlen;
> +    uint8_t outbuf[2];
> +
> +    /* selected register for read/write operation */
> +    uint8_t pointer;
> +};
> +
> +struct MAX31790Class {
> +    I2CSlaveClass parent_class;
> +};
> +
> +OBJECT_DECLARE_TYPE(MAX31790State, MAX31790Class, MAX31790)
> +
> +static void max31790_read(MAX31790State *s)
> +{
> +    size_t index = 0;
> +    uint8_t out0 = 0;
> +    uint8_t out1 = 0;
> +
> +    switch (s->pointer) {
> +    case MAX31790_REG_FAN_CONFIG(0)... MAX31790_REG_FAN_CONFIG(5):
> +        index = s->pointer - MAX31790_REG_FAN_CONFIG(0);
> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        out0 = s->fan_config[index];
> +        trace_max31790_fan_config_read(s->i2c.address, index, out0);
> +        break;
> +    case MAX31790_REG_FAN_DYNAMICS(0)... MAX31790_REG_FAN_DYNAMICS(5):
> +        index = s->pointer - MAX31790_REG_FAN_DYNAMICS(0);
> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        out0 = s->fan_dynamics[index];
> +        trace_max31790_fan_dynamics_read(s->i2c.address, index, out0);
> +        break;
> +    case MAX31790_REG_FAN_FAULT_STATUS_1:
> +    case MAX31790_REG_FAN_FAULT_STATUS_2:
> +        /* we do not have any fan fault */
> +        out0 = 0x00;
> +        out1 = 0x00;
> +        break;
> +    case MAX31790_REG_TACH_COUNT_MSB(0):
> +    case MAX31790_REG_TACH_COUNT_MSB(1):
> +    case MAX31790_REG_TACH_COUNT_MSB(2):
> +    case MAX31790_REG_TACH_COUNT_MSB(3):
> +    case MAX31790_REG_TACH_COUNT_MSB(4):
> +    case MAX31790_REG_TACH_COUNT_MSB(5):
> +    case MAX31790_REG_TACH_COUNT_MSB(6):
> +    case MAX31790_REG_TACH_COUNT_MSB(7):
> +    case MAX31790_REG_TACH_COUNT_MSB(8):
> +    case MAX31790_REG_TACH_COUNT_MSB(9):
> +    case MAX31790_REG_TACH_COUNT_MSB(10):
> +    case MAX31790_REG_TACH_COUNT_MSB(11):
> +        index = (s->pointer - MAX31790_REG_TACH_COUNT_MSB(0)) / 2;
> +
> +        g_assert(index < MAX31790_NUM_TACHS);
> +
> +        out0 = (s->tach_count[index % MAX31790_NUM_TACHS] >> 8) & 0xff;
> +        out1 = s->tach_count[index % MAX31790_NUM_TACHS] & 0xff;
> +        break;
> +
> +    case MAX31790_REG_TACH_COUNT_LSB(0):
> +    case MAX31790_REG_TACH_COUNT_LSB(1):
> +    case MAX31790_REG_TACH_COUNT_LSB(2):
> +    case MAX31790_REG_TACH_COUNT_LSB(3):
> +    case MAX31790_REG_TACH_COUNT_LSB(4):
> +    case MAX31790_REG_TACH_COUNT_LSB(5):
> +    case MAX31790_REG_TACH_COUNT_LSB(6):
> +    case MAX31790_REG_TACH_COUNT_LSB(7):
> +    case MAX31790_REG_TACH_COUNT_LSB(8):
> +    case MAX31790_REG_TACH_COUNT_LSB(9):
> +    case MAX31790_REG_TACH_COUNT_LSB(10):
> +    case MAX31790_REG_TACH_COUNT_LSB(11):
> +        index = (s->pointer - MAX31790_REG_TACH_COUNT_LSB(0)) / 2;
> +
> +        g_assert(index < MAX31790_NUM_TACHS);
> +
> +        out0 = s->tach_count[index % MAX31790_NUM_TACHS] & 0xff;
> +        break;
> +
> +    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(0):
> +    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(1):
> +    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(2):
> +    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(3):
> +    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(4):
> +    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(5):
> +        index = (s->pointer - MAX31790_REG_PWM_DUTY_CYCLE_MSB(0)) / 2;
> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        out0 = (s->pwm[index % MAX31790_NUM_FANS] >> 8) & 0xff;
> +        out1 = s->pwm[index % MAX31790_NUM_FANS] & 0xff;
> +        break;
> +    case MAX31790_REG_PWM_DUTY_CYCLE_LSB(0):
> +    case MAX31790_REG_PWM_DUTY_CYCLE_LSB(1):
> +    case MAX31790_REG_PWM_DUTY_CYCLE_LSB(2):
> +    case MAX31790_REG_PWM_DUTY_CYCLE_LSB(3):
> +    case MAX31790_REG_PWM_DUTY_CYCLE_LSB(4):
> +    case MAX31790_REG_PWM_DUTY_CYCLE_LSB(5):
> +        index = (s->pointer - MAX31790_REG_PWM_DUTY_CYCLE_LSB(0)) / 2;
> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        out0 = s->pwm[index % MAX31790_NUM_FANS] & 0xff;
> +        break;
> +
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(1):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(2):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(3):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(4):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(5):
> +        index = (s->pointer - MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0)) / 2;
> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        out0 = (s->pwm[index % MAX31790_NUM_FANS] >> 8) & 0xff;
> +        out1 = s->pwm[index % MAX31790_NUM_FANS] & 0xff;
> +        break;
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(0):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(1):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(2):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(3):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(4):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(5):
> +        index = (s->pointer - MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(0)) / 2;
> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        out0 = s->pwm[index % MAX31790_NUM_FANS] & 0xff;
> +        break;
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(0):
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(1):
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(2):
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(3):
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(4):
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(5):
> +        index = (s->pointer - MAX31790_REG_TACH_TARGET_COUNT_MSB(0)) / 2;
> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        out0 = (s->tach_target[index] >> 8) & 0xff;
> +        out1 = s->tach_target[index] & 0xff;
> +        break;
> +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(0):
> +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(1):
> +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(2):
> +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(3):
> +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(4):
> +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(5):
> +        index = (s->pointer - MAX31790_REG_TACH_TARGET_COUNT_LSB(0)) / 2;
> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        out0 = s->tach_target[index] & 0xff;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: read of register %d\n", __func__,
> +                      s->pointer);
> +        break;
> +    }
> +
> +    s->outbuf[0] = out0;
> +    s->outbuf[1] = out1;
> +}
> +
> +static uint8_t max31790_get_speed_range(MAX31790State *s, size_t index)
> +{
> +    g_assert(index < MAX31790_NUM_FANS);
> +    const uint16_t value = (s->fan_dynamics[index] >> 5);
> +    return (value > 5) ? 32 : 1 << value;
> +}
> +
> +static void max31790_set_rpm(MAX31790State *s, size_t index, uint16_t rpm)
> +{
> +    trace_max31790_rpm_write(s->i2c.address, index, rpm);
> +
> +    /*
> +     * (see page 11) NP = number of tachometer pulses per revolution.
> +     * Most general-purpose brushless DC fans produce two tachometer
> +     * pulses per revolution.
> +     */
> +    const uint64_t sr = max31790_get_speed_range(s, index);
> +
> +    /* page 11: tach_count = 60 * SR * 8192 / (NP * RPM) */
> +
> +    /* prevent division by 0 */
> +    rpm = (rpm == 0) ? 1 : rpm;
> +
> +    /* (60 * 8192) / 2 */
> +    const uint64_t tach_count_constant = 245760ULL;
> +
> +    /* simplified, assuming NP = 2 */
> +    uint64_t tach_count = (tach_count_constant * sr) / (uint64_t)rpm;
> +
> +    /* in case of overflow, clamp to the maximum value */
> +    if (tach_count > 0x7ff) {
> +        tach_count = 0x7ff;
> +    }
> +
> +    g_assert(index < MAX31790_NUM_TACHS);
> +
> +    /* datasheet: lowest 5 bits are 0 */
> +    s->tach_count[index] = (uint16_t)(tach_count << 5);
> +
> +    trace_max31790_tach_count_reg(s->i2c.address, index, s->tach_count[index]);
> +}
> +
> +static void max31790_pwm_write(MAX31790State *s, size_t index, uint16_t value)
> +{
> +    trace_max31790_pwm_write(s->i2c.address, index, value);
> +
> +    g_assert(index < MAX31790_NUM_FANS);
> +
> +    s->pwm[index % MAX31790_NUM_FANS] = value;
> +
> +    /* last 7 bits in register are 0 , 9 bits remaining */
> +    const uint16_t pwm_real = s->pwm[index % MAX31790_NUM_FANS] >> 7;
> +
> +    /* maximum value will be 511 */
> +
> +    /*
> +     * This formula has magic values which model the relationship
> +     * of PWM input to a fan. Not derived from datasheet.
> +     */
> +    max31790_set_rpm(s, index, 100 + pwm_real * 20);
> +}
> +
> +static void max31790_write_2_byte(MAX31790State *s)
> +{
> +    size_t index = 0;
> +    const uint8_t value0 = s->buf[0];
> +    const uint8_t value1 = s->buf[1];
> +
> +    switch (s->pointer) {
> +    case MAX31790_REG_FAN_CONFIG(0)... MAX31790_REG_FAN_CONFIG(5):
> +        break; /* handled by one byte write */
> +    case MAX31790_REG_FAN_DYNAMICS(0)... MAX31790_REG_FAN_DYNAMICS(5):
> +        break; /* handled by one byte write */
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(1):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(2):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(3):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(4):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(5):
> +        index = (s->pointer - MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0)) / 2;
> +        max31790_pwm_write(s, index, value0 << 8 | value1);
> +        break;
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(0):
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(1):
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(2):
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(3):
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(4):
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(5):
> +        index = (s->pointer - MAX31790_REG_TACH_TARGET_COUNT_MSB(0)) / 2;
> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        s->tach_target[index] = (value0 << 8) | value1;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: write to register %d\n", __func__,
> +                      s->pointer);
> +        break;
> +    }
> +}
> +
> +static void max31790_write_1_byte(MAX31790State *s)
> +{
> +    size_t index = 0;
> +    uint16_t pwm = 0;
> +    const uint8_t value = s->buf[0];
> +
> +    switch (s->pointer) {
> +    case MAX31790_REG_FAN_CONFIG(0)... MAX31790_REG_FAN_CONFIG(5):
> +        index = s->pointer - MAX31790_REG_FAN_CONFIG(0);
> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        s->fan_config[index] = value;
> +        trace_max31790_fan_config_write(s->i2c.address, index, value);
> +        break;
> +    case MAX31790_REG_FAN_DYNAMICS(0)... MAX31790_REG_FAN_DYNAMICS(5):
> +        index = s->pointer - MAX31790_REG_FAN_DYNAMICS(0);
> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        s->fan_dynamics[index] = value;
> +        trace_max31790_fan_dynamics_write(s->i2c.address, index, value);
> +        break;
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(1):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(2):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(3):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(4):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(5):
> +        index = (s->pointer - MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0)) / 2;
> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        pwm = (value << 8) | (s->pwm[index % MAX31790_NUM_FANS] & 0x00ff);
> +        max31790_pwm_write(s, index, pwm);
> +        break;
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(0):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(1):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(2):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(3):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(4):
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(5):
> +        index = (s->pointer - MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(0)) / 2;
> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        pwm = (s->pwm[index % MAX31790_NUM_FANS] & 0xff00) | (value & 0x00ff);
> +        max31790_pwm_write(s, index, pwm);
> +        break;
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(0):
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(1):
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(2):
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(3):
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(4):
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(5):
> +        index = (s->pointer - MAX31790_REG_TACH_TARGET_COUNT_MSB(0)) / 2;
> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        s->tach_target[index] = (s->tach_target[index] & 0x00ff) | (value << 8);
> +        break;
> +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(0):
> +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(1):
> +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(2):
> +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(3):
> +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(4):
> +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(5):
> +        index = (s->pointer - MAX31790_REG_TACH_TARGET_COUNT_LSB(0)) / 2;
> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        s->tach_target[index] = (s->tach_target[index] & 0xff00) | value;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: write to register %d\n", __func__,
> +                      s->pointer);
> +        break;
> +    }
> +}
> +
> +static int max31790_send(I2CSlave *i2c, uint8_t data)
> +{
> +    MAX31790State *s = MAX31790(i2c);
> +
> +    trace_max31790_send(s->i2c.address, data);
> +
> +    if (s->len == 0) {
> +        /* first byte is the register pointer for a read / write operation */
> +        s->pointer = data;
> +        s->len++;
> +        return 0;
> +    }
> +
> +    if (s->len > 2) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: write too many bytes\n", __func__);
> +        return 1; /* NAK */
> +    }
> +
> +    /* second / third byte is the data to write */
> +    s->buf[s->len - 1] = data;
> +    s->len++;
> +
> +    if (s->len == 2) {
> +        max31790_write_1_byte(s);
> +    } else if (s->len == 3) {
> +        max31790_write_2_byte(s);
> +    }
> +
> +    return 0;
> +}
> +
> +static uint8_t max31790_recv(I2CSlave *i2c)
> +{
> +    MAX31790State *s = MAX31790(i2c);
> +
> +    max31790_read(s);
> +    s->len = 0;
> +
> +    if (s->outlen >= 2) {
> +        /* error */
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: guest over read\n", __func__);
> +        s->outlen = 0;
> +    }
> +
> +    const uint8_t data = s->outbuf[s->outlen++];
> +
> +    trace_max31790_recv_return(s->i2c.address, s->pointer, data);
> +    return data;
> +}
> +
> +static int max31790_event(I2CSlave *i2c, enum i2c_event event)
> +{
> +    MAX31790State *s = MAX31790(i2c);
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
> +static const VMStateDescription vmstate_max31790 = {
> +    .name = TYPE_MAX31790,
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields =
> +        (const VMStateField[]){
> +            VMSTATE_UINT8(len, MAX31790State),
> +            VMSTATE_UINT8_ARRAY(fan_config, MAX31790State, MAX31790_NUM_FANS),
> +            VMSTATE_UINT8_ARRAY(fan_dynamics, MAX31790State, MAX31790_NUM_FANS),
> +            VMSTATE_UINT16_ARRAY(pwm, MAX31790State, MAX31790_NUM_FANS),
> +            VMSTATE_UINT16_ARRAY(tach_target, MAX31790State, MAX31790_NUM_FANS),
> +            VMSTATE_UINT16_ARRAY(tach_count, MAX31790State, MAX31790_NUM_TACHS),
> +            VMSTATE_UINT8_ARRAY(buf, MAX31790State, 2),
> +            VMSTATE_UINT8(outlen, MAX31790State),
> +            VMSTATE_UINT8_ARRAY(outbuf, MAX31790State, 2),
> +            VMSTATE_UINT8(pointer, MAX31790State),
> +            VMSTATE_I2C_SLAVE(i2c, MAX31790State), VMSTATE_END_OF_LIST() }
> +};
> +
> +static void max31790_reset_enter(MAX31790State *s)
> +{
> +    trace_max31790_reset(s->i2c.address);
> +
> +    for (int i = 0; i < MAX31790_NUM_FANS; i++) {
> +        /* POR-State 0b 0XX0 0000 */
> +        s->fan_config[i] = 0x0;
> +
> +        /* same as POR-State */
> +        s->tach_target[i] = 0x3c00;
> +
> +        /* same as POR-State */
> +        s->fan_dynamics[i] = 0x4c;
> +    }
> +
> +    /* this will set both pwm and tach count */
> +    for (int i = 0; i < MAX31790_NUM_FANS; i++) {
> +        max31790_pwm_write(s, i, 0x4444);
> +    }
> +}
> +
> +static void max31790_reset_hold(Object *obj, ResetType type)
> +{
> +    MAX31790State *s = MAX31790(obj);
> +
> +    max31790_reset_enter(s);
> +}
> +
> +static void max31790_realize(DeviceState *dev, Error **errp)
> +{
> +    MAX31790State *s = MAX31790(dev);
> +
> +    trace_max31790_realize(s->i2c.address);
> +}
> +
> +static void max31790_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    dc->realize = max31790_realize;
> +    dc->desc = "Maxim MAX31790 6-Channel Fan Controller";
> +    dc->vmsd = &vmstate_max31790;
> +    rc->phases.hold = max31790_reset_hold;
> +    k->event = max31790_event;
> +    k->recv = max31790_recv;
> +    k->send = max31790_send;
> +}
> +
> +static const TypeInfo max31790_info = {
> +    .name = TYPE_MAX31790,
> +    .parent = TYPE_I2C_SLAVE,
> +    .instance_size = sizeof(MAX31790State),
> +    .class_size = sizeof(MAX31790Class),
> +    .class_init = max31790_class_init,
> +};
> +
> +static void max31790_register_types(void)
> +{
> +    type_register_static(&max31790_info);
> +}
> +
> +type_init(max31790_register_types)
> diff --git a/hw/sensor/meson.build b/hw/sensor/meson.build
> index 420fdc3359..4987c3b253 100644
> --- a/hw/sensor/meson.build
> +++ b/hw/sensor/meson.build
> @@ -8,3 +8,4 @@ system_ss.add(when: 'CONFIG_MAX34451', if_true: files('max34451.c'))
>   system_ss.add(when: 'CONFIG_LSM303DLHC_MAG', if_true: files('lsm303dlhc_mag.c'))
>   system_ss.add(when: 'CONFIG_ISL_PMBUS_VR', if_true: files('isl_pmbus_vr.c'))
>   system_ss.add(when: 'CONFIG_MAX31785', if_true: files('max31785.c'))
> +system_ss.add(when: 'CONFIG_MAX31790', if_true: files('max31790.c'))
> diff --git a/hw/sensor/trace-events b/hw/sensor/trace-events
> index a3fe54fa6d..35c30b985c 100644
> --- a/hw/sensor/trace-events
> +++ b/hw/sensor/trace-events
> @@ -4,3 +4,16 @@
>   tmp105_read(uint8_t dev, uint8_t addr) "device: 0x%02x, addr: 0x%02x"
>   tmp105_write(uint8_t dev, uint8_t addr) "device: 0x%02x, addr 0x%02x"
>   tmp105_write_shutdown(uint8_t dev) "device: 0x%02x"
> +
> +# max31790.c
> +max31790_send(uint8_t i2c_addr, uint8_t send) "i2c_addr: 0x%02x, data: 0x%02x"
> +max31790_recv_return(uint8_t i2c_addr, uint8_t reg_addr, uint8_t data) "i2c_addr: 0x%02x, reg_addr: 0x%02x, returns: 0x%02x"
> +max31790_realize(uint8_t i2c_addr) "i2c_addr: 0x%02x"
> +max31790_reset(uint8_t i2c_addr) "i2c_addr: 0x%02x"
> +max31790_pwm_write(uint8_t i2c_addr, size_t index, uint16_t value) "i2c_addr: 0x%02x, index: %zu, value: 0x%04x"
> +max31790_rpm_write(uint8_t i2c_addr, size_t index, uint16_t value) "i2c_addr: 0x%02x, index: %zu, value: 0x%04x"
> +max31790_tach_count_reg(uint8_t i2c_addr, size_t index, uint16_t value) "i2c_addr: 0x%02x, index: %zu, value: 0x%04x"
> +max31790_fan_dynamics_read(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c_addr: 0x%02x, channel: %zu, value: 0x%02x"
> +max31790_fan_dynamics_write(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c_addr: 0x%02x, channel: %zu, value: 0x%02x"
> +max31790_fan_config_read(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c_addr: 0x%02x, channel: %zu, value: 0x%02x"
> +max31790_fan_config_write(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c_addr: 0x%02x, channel: %zu, value: 0x%02x"
> diff --git a/tests/functional/arm/test_aspeed_fby4.py b/tests/functional/arm/test_aspeed_fby4.py
> index a521834f79..f344413fe4 100755
> --- a/tests/functional/arm/test_aspeed_fby4.py
> +++ b/tests/functional/arm/test_aspeed_fby4.py
> @@ -7,6 +7,7 @@
>   from qemu_test import Asset
>   from qemu_test import wait_for_console_pattern
>   from aspeed import AspeedTest
> +from qemu_test import exec_command_and_wait_for_pattern
>   
>   
>   class YosemiteV4Machine(AspeedTest):
> @@ -34,6 +35,52 @@ def do_test_arm_aspeed_openbmc_no_network(self, machine, image, uboot,
>           # different from the other machines.
>           self.wait_for_console_pattern('yosemite4 login:')
>   
> +        # perform login
> +        exec_command_and_wait_for_pattern(self,
> +                                          "root", "Password:");
> +
> +        exec_command_and_wait_for_pattern(self, "0penBmc", "#");
> +
> +        # MAX31790 test
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/class/hwmon/hwmon2/name", "max31790");
> +
> +        # this initial fan reading value is caused by services
> +        # inside the image writing the pwm
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/class/hwmon/hwmon2/fan1_input", "7281");
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/class/hwmon/hwmon2/fan1_enable", "1");
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/class/hwmon/hwmon2/fan1_fault", "0");
> +
> +        exec_command_and_wait_for_pattern(self,
> +            "echo 1 > /sys/class/hwmon/hwmon2/pwm1", "root@yosemite4");
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/class/hwmon/hwmon2/fan1_input", "0");
> +
> +        # linux driver pwm write:
> +        # >>> hex(int((11 * 511) / 255) << 7)
> +        # '0xb00'
> +        exec_command_and_wait_for_pattern(self,
> +            "echo 11 > /sys/class/hwmon/hwmon2/pwm1", "root@yosemite4");
> +        # device emulation logic:
> +        # >>> hex(100 + (0xb00 >> 7) * 20)
> +        # '0x21c'
> +        # register reading value:
> +        # >>> hex(int((245760 * 4) / 0x21c) << 5)
> +        # '0xe380'
> +        # linux driver calculation:
> +        # >>> int((60 * 4 * 8192) / (0xe380 >> 4))
> +        # 540
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/class/hwmon/hwmon2/fan1_input", "540");
> +
> +        exec_command_and_wait_for_pattern(self,
> +            "echo 255 > /sys/class/hwmon/hwmon2/pwm1", "root@yosemite4");
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/class/hwmon/hwmon2/fan1_input", "10347");
> +
>       def test_arm_ast2600_yosemitev4_openbmc(self):
>           image_path = self.uncompress(self.ASSET_YOSEMITE_V4_FLASH)
>   


