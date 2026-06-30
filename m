Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7FEC43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wePkN-0002Is-Hu; Tue, 30 Jun 2026 00:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wePk9-0002H6-Tz; Tue, 30 Jun 2026 00:06:42 -0400
Received: from smtpout1.mo2.mail-out.ovh.net ([79.137.123.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wePk7-0004CF-5V; Tue, 30 Jun 2026 00:06:41 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4gq8j65Mllz4B3g;
 Tue, 30 Jun 2026 04:06:34 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Tue, 30 Jun 2026 04:06:34 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.183])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gq8j63XJDz7tKs; Tue, 30 Jun 2026 04:06:34 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 53D672403D1A; Tue, 30 Jun 2026 04:06:33 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S00272aa7159-08d9-4ab4-87a7-134636066f12,
 C9F07EB534A46111D337A1875201B4A1724CF27E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <a2734b67-ab34-40b0-8941-002c30ecb057@kaod.org>
Date: Tue, 30 Jun 2026 06:06:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] hw/sensor: support MAX11615
To: alexander.hansen@9elements.com, qemu-devel@nongnu.org
Cc: eblot@meta.com, titusr@google.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20260619115533.5664-1-alexander.hansen@9elements.com>
 <20260619115533.5664-5-alexander.hansen@9elements.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260619115533.5664-5-alexander.hansen@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 4668543967832288495
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF8VHt9H73QJBza21/f6TgjFq01aBK7dLrr897P+CLDs5axLq7cLUGTUIfbXI1U9GapQcJZ3DVNSXWzbGBneIz1B0590WJFO6UnDGHXqoFoHrrdNV93UJKWaLV3BvI6LJ/zGLzWvVsnPDGat1ouWRycc8DrVU3N1z6Ckr2Dfw56qmfZRUgixVqF3Qii3OQ3AM1+7z02nYWy/uDEIbGBhJS64UR/Z7iYgevz14+y0hdV2BxXy8ZweodLzS56riGLVPDTc17doKaf1Pl2F7UsBEWN2+PVVa89VRwCKvsNbzMK/NzK0bsWH5wN5I7odM6jQicj6n2p81UoG3QnHeLcgPrODGdx2idMaUeZedT623HsT+/qhLxhgah9IV87m7qIeAneQLglr5J5W/TtEFLuAj1R9BO6OvzCLdcnquWPp5g+j6GUOZFQ4IVstNyQFdWHq1x7UVaCWilD/IATyQ65UXV48hmmexemFB7xo7VbMjlKeep5hXO7WHz1epqQpilIF8VP6tyGjHVCKNK9WjXN1mOlu7319ywCugaCn+3oGqQQ8eIt4PU57LXIy5sKVrMNt6iMbeiZ8N4N/qnpV6Kb/GHQuLTdtNjXb16pOpia2EHl1SbRHckjhgVfn1plyxG/Ez+randpEPGMQ/eMGK6WMOzzyyFvNDrbG0xtuv8dhVdZHQ
DKIM-Signature: a=rsa-sha256; bh=viVZCSWlgHTBnuSU/c6SqKSiqfg3IKT8mBGQz3cUWOM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1782792395; v=1;
 b=j/v8BqL6ddvBoJnwVD1e+Di6DQ6M7I8v/TzyXwN8ONar017bTWDNA6hsUc2zzW5QDXxHYkAs
 cf0gGtDA4Lkl62AtMWgeZMmKpffYyJj736oFLXMfX+JlhF1TiFSMIP4ZUD9ZvNyb7VkxgTe2kHv
 VvI59TsWUGBJW9LCjVK+QkZrqDoa3oinqVQwN76FV0awUNwbpwlcL1bLs50xTrFkhR/hcS/6UlL
 jE6wrt3t4YG3rNV0wJcZruNTgxS7LMVpd/0mcik1YqQ6eGTB013V7I482KCgPh9k1evLjrKEURD
 tzcKhvR8+7gYkkHDE0ATnwSa357OQFd1M57pZHkJWzTLQ==
Received-SPF: pass client-ip=79.137.123.219; envelope-from=clg@kaod.org;
 helo=smtpout1.mo2.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> Sensor readings can be provided upon creation of the device. In case no
> readings are provided the ADC reads a pre-defined arbitrary value.
> 
> root@yosemite4:~# cat /sys/bus/iio/devices/iio:device2/name
> max11615
> root@yosemite4:~# cat /sys/bus/iio/devices/iio:device2/in_voltage0_raw
> 1922
> root@yosemite4:~# cat /sys/bus/iio/devices/iio:device2/in_voltage_scale
> 0.500000000
> 
> trace:
> less /tmp/qemu-trace.log | grep -i max116
> max11615_realize i2c_addr: 0x33
> max11615_realize i2c_addr: 0x33
> max11615_event i2c_addr: 0x33, event: 0x01
> max11615_write_setup i2c_addr: 0x33, data: 0xd2
> max11615_write_config i2c_addr: 0x33, data: 0x0f
> max11615_event i2c_addr: 0x33, event: 0x03
> max11615_event i2c_addr: 0x33, event: 0x01
> max11615_write_setup i2c_addr: 0x33, data: 0xd2
> max11615_write_config i2c_addr: 0x33, data: 0x0f
> max11615_event i2c_addr: 0x33, event: 0x03
> max11615_event i2c_addr: 0x33, event: 0x01
> max11615_write_setup i2c_addr: 0x33, data: 0xd2
> max11615_write_config i2c_addr: 0x33, data: 0x61
> max11615_event i2c_addr: 0x33, event: 0x03
> max11615_event i2c_addr: 0x33, event: 0x00
> max11615_recv i2c_addr: 0x33, reg_addr: 0x00
> max11615_recv_return i2c_addr: 0x33, returns: 0xfa
> max11615_recv i2c_addr: 0x33, reg_addr: 0x00
> max11615_recv_return i2c_addr: 0x33, returns: 0xd2
> max11615_event i2c_addr: 0x33, event: 0x04
> max11615_event i2c_addr: 0x33, event: 0x03
> 
> References:
> [1] https://www.analog.com/en/products/MAX11615.html
> [2] https://www.analog.com/media/en/technical-documentation/data-sheets/MAX11612-MAX11617.pdf
> 
> Cc: Emmanuel Blot <eblot@meta.com>
> Cc: Titus Rwantare <titusr@google.com>
> Cc: "Cédric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org> (odd fixer:Overall sensors)
> Cc: Paolo Bonzini <pbonzini@redhat.com> (maintainer:Kconfig)
> Cc: Peter Maydell <peter.maydell@linaro.org> (supporter:ARM TCG CPUs)
> Cc: qemu-devel@nongnu.org (open list:All patches CC here)
> Cc: qemu-arm@nongnu.org (open list:ARM TCG CPUs)
> Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
> ---
>   MAINTAINERS                              |   1 +
>   hw/arm/Kconfig                           |   1 +
>   hw/arm/aspeed_ast2600_fby4.c             |   8 +-
>   hw/sensor/Kconfig                        |   4 +
>   hw/sensor/max11615.c                     | 320 +++++++++++++++++++++++
>   hw/sensor/meson.build                    |   1 +
>   hw/sensor/trace-events                   |   9 +
>   include/hw/sensor/max11615.h             |  19 ++
>   tests/functional/arm/test_aspeed_fby4.py |   9 +
>   9 files changed, 371 insertions(+), 1 deletion(-)
>   create mode 100644 hw/sensor/max11615.c
>   create mode 100644 include/hw/sensor/max11615.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e3df75f7bb..4b5c8cc65a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3993,6 +3993,7 @@ S: Maintained
>   F: hw/i2c/pmbus_device.c
>   F: hw/sensor/adm1272.c
>   F: hw/sensor/isl_pmbus_vr.c
> +F: hw/sensor/max11615.c
>   F: hw/sensor/max31790.c
>   F: hw/sensor/max34451.c
>   F: include/hw/i2c/pmbus_device.h
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 43e96a671b..19259bc2e2 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -554,6 +554,7 @@ config ASPEED_SOC
>       select PMBUS
>       select MAX31785
>       select MAX31790
> +    select MAX11615
>       select FSI_APB2OPB_ASPEED
>       select AT24C
>       select PCI_EXPRESS
> diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4.c
> index 8feb31bc44..dd84839c65 100644
> --- a/hw/arm/aspeed_ast2600_fby4.c
> +++ b/hw/arm/aspeed_ast2600_fby4.c
> @@ -11,6 +11,7 @@
>   #include "hw/arm/aspeed.h"
>   #include "hw/arm/aspeed_soc.h"
>   #include "hw/nvram/eeprom_at24c.h"
> +#include "hw/sensor/max11615.h"
>   #include "hw/i2c/i2c_mux_pca954x.h"
>   #include "hw/gpio/pca9552.h"
>   
> @@ -185,7 +186,12 @@ static void fby4_i2c_init_fanboard(I2CSlave *fan_mux, size_t eepromSize)
>           i2c_slave_create_simple(bus, "max31790", 0x2f);
>   
>           /* maxim,max11615 @ 0x33   (adc) */
> -        /* TODO */
> +        static const uint16_t adc_values[8] = {
> +            1922, 1000,
> +            1922, 1000,
> +            1922, 1000,
> +            1922, 1000};
> +        max11615_init_with_values(bus, 0x33, adc_values, 8);
>   
>           at24c_eeprom_init_rom(
>               bus, 0x52, eepromSize,
> diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
> index 767f198e92..441bee7604 100644
> --- a/hw/sensor/Kconfig
> +++ b/hw/sensor/Kconfig
> @@ -47,3 +47,7 @@ config MAX31785
>   config MAX31790
>       bool
>       depends on I2C
> +
> +config MAX11615
> +    bool
> +    depends on I2C
> diff --git a/hw/sensor/max11615.c b/hw/sensor/max11615.c
> new file mode 100644
> index 0000000000..ac2ccda4fa
> --- /dev/null
> +++ b/hw/sensor/max11615.c
> @@ -0,0 +1,320 @@
> +/*
> + * Maxim MAX11615 Low-Power 12 bit ADC
> + * Models MAX11612,MAX11613,MAX11614,MAX11615,MAX11616,MAX11617
> + *
> + * Datasheet:
> + * https://www.analog.com/media/en/technical-documentation/data-sheets/MAX11612-MAX11617.pdf
> + *
> + * Copyright 2026 9elements
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/sensor/max11615.h"
> +#include "hw/i2c/i2c.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "trace.h"
> +
> +#define MAX11615_NUM_CHANNELS 8
> +
> +struct MAX11615State {
> +    I2CSlave i2c;
> +
> +    /* true: single-ended mode, false: differential mode */
> +    bool single_ended;
> +
> +    /*
> +     * Output data coding for the MAX11612–MAX11617 is
> +     * binary in unipolar mode and two’s complement in bipolar mode
> +     */
> +    bool bipolar;
> +
> +    /* The MAX11613/MAX11615/MAX11617 feature a 2.048V internal reference */
> +    uint16_t vref;
> +
> +    uint16_t channels[MAX11615_NUM_CHANNELS];
> +
> +    /* output buffer */
> +    uint8_t outlen;
> +    uint8_t outbuf[2];
> +
> +    /* selected channel for read/write operation */
> +    uint8_t pointer;
> +};
> +
> +struct MAX11615Class {
> +    I2CSlaveClass parent_class;
> +};
> +
> +OBJECT_DECLARE_TYPE(MAX11615State, MAX11615Class, MAX11615)
> +
> +static void max11615_set_outbuf(MAX11615State *s, uint16_t value)
> +{
> +    uint8_t msb = value >> 8;
> +    uint8_t lsb = value & 0xff;
> +    s->outbuf[0] = 0xf0 | (msb & 0xf);
> +    s->outbuf[1] = lsb;
> +}
> +
> +static void max11615_read_single_ended(MAX11615State *s)
> +{
> +    /* Table 3. Channel Selection in Single-Ended Mode */
> +    /* read an ADC channel, first 4 bits must be high */
> +    uint16_t value = s->channels[s->pointer];
> +    /*
> +     * In single-ended mode, the MAX11612–MAX11617 always
> +     * operates in unipolar mode irrespective of BIP/UNI.
> +     */
> +    if (value > s->vref) {
> +        value = 0xfff;
> +    }
> +    max11615_set_outbuf(s, value);
> +}
> +
> +static int16_t max11615_differential_value(MAX11615State *s)
> +{
> +    /* Table 4. Channel Selection in Differential Mode */
> +    size_t i1 = s->pointer;
> +    size_t i2 = (s->pointer % 2 == 0) ? s->pointer + 1 : s->pointer - 1;
> +
> +    const int16_t ch1 = s->channels[i1];
> +    const int16_t ch2 = s->channels[i2];
> +    return ch1 - ch2;
> +}
> +
> +static void max11615_read_differential(MAX11615State *s)
> +{
> +    const int16_t value = max11615_differential_value(s);
> +    uint16_t vu = value;
> +
> +    /* full-scale transition: Figure 12, Figure 13 */
> +    if (s->bipolar) {
> +        const uint16_t fs = s->vref / 2;
> +        if (value < -fs) {
> +            vu = 0x800;
> +        }
> +        if (value > fs) {
> +            vu = 0x7ff;
> +        }
> +    } else {
> +        /*
> +         * A negative differential analog input in unipolar mode causes the
> +         * digital output code to be zero
> +         */
> +        if (value < 0) {
> +            vu = 0;
> +        }
> +    }
> +
> +    max11615_set_outbuf(s, vu);
> +}
> +
> +static void max11615_read(MAX11615State *s)
> +{
> +    if (s->single_ended) {
> +        max11615_read_single_ended(s);
> +    } else {
> +        max11615_read_differential(s);
> +    }
> +}
> +
> +static void max11615_write_config_byte(MAX11615State *s, uint8_t data)
> +{
> +    trace_max11615_write_config(s->i2c.address, data);
> +
> +    uint8_t scan_select = (data >> 5) & 0x3;
> +
> +    if (scan_select != 0x3) {
> +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented scan select\n", __func__);
> +    }
> +
> +    uint8_t channel_select = (data >> 1) & 0xf;
> +
> +    /* Table 3. Channel Selection */
> +    if (channel_select >= MAX11615_NUM_CHANNELS) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid channel select\n",
> +                      __func__);
> +        channel_select = MAX11615_NUM_CHANNELS - 1;
> +    }
> +    s->pointer = channel_select;
> +    s->single_ended = data & 0x1;
> +}
> +
> +static void max11615_write_setup_byte(MAX11615State *s, uint8_t data)
> +{
> +    trace_max11615_write_setup(s->i2c.address, data);
> +    /* we ignore the setup byte, not implemented */
> +
> +    /* 1 = no action, 0 = resets the configuration register to default */
> +    const bool rst = ((data >> 1) & 0x1) == 0x0;
> +
> +    if (rst) {
> +        s->single_ended = true;
> +        s->pointer = 0;
> +    }
> +
> +    s->bipolar = ((data >> 2) & 0x1) == 0x1;
> +
> +    /* Table 6. Reference Voltage */
> +    const uint8_t sel = (data >> 4) & 0x7;
> +
> +    if (sel == 0x2 || sel == 0x3) {
> +        qemu_log_mask(LOG_UNIMP, "%s: unsupported: external vref\n", __func__);
> +    }
> +}
> +
> +static int max11615_send(I2CSlave *i2c, uint8_t data)
> +{
> +    MAX11615State *s = MAX11615(i2c);
> +    const uint8_t msb = (data >> 7) & 0x1;
> +
> +    if (msb) {
> +        max11615_write_setup_byte(s, data);
> +    } else {
> +        max11615_write_config_byte(s, data);
> +    }
> +
> +    s->outlen = 0;
> +    return 0;
> +}
> +
> +static uint8_t max11615_recv(I2CSlave *i2c)
> +{
> +    MAX11615State *s = MAX11615(i2c);
> +    trace_max11615_recv(s->i2c.address, s->pointer);
> +
> +    if (s->outlen >= 2) {
> +        /* MAX11615 supports multichannel scan with wraparound */
> +        /* see datasheet page 17 */
> +
> +        s->outlen = 0;
> +
> +        s->pointer++;
> +        if (s->pointer >= MAX11615_NUM_CHANNELS) {
> +            s->pointer = 0;
> +        }
> +    }
> +
> +    max11615_read(s);
> +
> +    const uint8_t data = s->outbuf[s->outlen++];
> +
> +    trace_max11615_recv_return(s->i2c.address, data);
> +    return data;
> +}
> +
> +static int max11615_event(I2CSlave *i2c, enum i2c_event event)
> +{
> +    MAX11615State *s = MAX11615(i2c);
> +
> +    trace_max11615_event(s->i2c.address, event);
> +
> +    switch (event) {
> +    case I2C_START_RECV:
> +        s->outlen = 0;
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_max11615 = {
> +    .name = TYPE_MAX11615,
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields =
> +        (const VMStateField[]){ VMSTATE_BOOL(single_ended, MAX11615State),
> +                                VMSTATE_BOOL(bipolar, MAX11615State),
> +                                VMSTATE_UINT16(vref, MAX11615State),
> +                                VMSTATE_UINT16_ARRAY(channels, MAX11615State,
> +                                                     MAX11615_NUM_CHANNELS),
> +                                VMSTATE_UINT8(outlen, MAX11615State),
> +                                VMSTATE_UINT8_ARRAY(outbuf, MAX11615State, 2),
> +                                VMSTATE_UINT8(pointer, MAX11615State),
> +                                VMSTATE_I2C_SLAVE(i2c, MAX11615State),
> +                                VMSTATE_END_OF_LIST() }
> +};
> +
> +I2CSlave *max11615_init_with_values(I2CBus *bus, uint8_t address,
> +                                    const uint16_t *init_values,
> +                                    uint32_t init_values_size)
> +{
> +    MAX11615State *s;
> +
> +    s = MAX11615(i2c_slave_new(TYPE_MAX11615, address));
> +
> +    i2c_slave_realize_and_unref(I2C_SLAVE(s), bus, &error_abort);
> +
> +    for (int i = 0; i < MAX11615_NUM_CHANNELS; i++) {
> +        /* arbitrary value if there is no data*/
> +        s->channels[i] = i < init_values_size ? init_values[i] : 0x2d2;
> +    }
> +
> +    return I2C_SLAVE(s);
> +}
> +
> +static void max11615_reset_enter(MAX11615State *s)
> +{
> +    trace_max11615_reset_enter(s->i2c.address);
> +
> +    s->single_ended = true;
> +    s->bipolar = false;
> +    s->vref = 2048;
> +    s->pointer = 0;
> +    s->outlen = 0;
> +
> +    for (int i = 0; i < MAX11615_NUM_CHANNELS; i++) {
> +        s->channels[i] = 0x2d2;
> +    }
> +}
> +
> +static void max11615_reset(Object *obj, ResetType type)
> +{
> +    MAX11615State *s = MAX11615(obj);
> +
> +    max11615_reset_enter(s);
> +}
> +
> +static void max11615_realize(DeviceState *dev, Error **errp)
> +{
> +    MAX11615State *s = MAX11615(dev);
> +
> +    trace_max11615_realize(s->i2c.address);
> +}
> +
> +static void max11615_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    dc->realize = max11615_realize;
> +    dc->desc = "Maxim MAX11615 12-bit ADC";
> +    dc->vmsd = &vmstate_max11615;
> +    rc->phases.hold = max11615_reset;
> +    k->event = max11615_event;
> +    k->recv = max11615_recv;
> +    k->send = max11615_send;
> +}
> +
> +static const TypeInfo max11615_info = {
> +    .name = TYPE_MAX11615,
> +    .parent = TYPE_I2C_SLAVE,
> +    .instance_size = sizeof(MAX11615State),
> +    .class_size = sizeof(MAX11615Class),
> +    .class_init = max11615_class_init,
> +};
> +
> +static void max11615_register_types(void)
> +{
> +    type_register_static(&max11615_info);
> +}
> +
> +type_init(max11615_register_types)
> diff --git a/hw/sensor/meson.build b/hw/sensor/meson.build
> index 4987c3b253..a1e26604fa 100644
> --- a/hw/sensor/meson.build
> +++ b/hw/sensor/meson.build
> @@ -9,3 +9,4 @@ system_ss.add(when: 'CONFIG_LSM303DLHC_MAG', if_true: files('lsm303dlhc_mag.c'))
>   system_ss.add(when: 'CONFIG_ISL_PMBUS_VR', if_true: files('isl_pmbus_vr.c'))
>   system_ss.add(when: 'CONFIG_MAX31785', if_true: files('max31785.c'))
>   system_ss.add(when: 'CONFIG_MAX31790', if_true: files('max31790.c'))
> +system_ss.add(when: 'CONFIG_MAX11615', if_true: files('max11615.c'))
> diff --git a/hw/sensor/trace-events b/hw/sensor/trace-events
> index 35c30b985c..1512819354 100644
> --- a/hw/sensor/trace-events
> +++ b/hw/sensor/trace-events
> @@ -17,3 +17,12 @@ max31790_fan_dynamics_read(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c
>   max31790_fan_dynamics_write(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c_addr: 0x%02x, channel: %zu, value: 0x%02x"
>   max31790_fan_config_read(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c_addr: 0x%02x, channel: %zu, value: 0x%02x"
>   max31790_fan_config_write(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c_addr: 0x%02x, channel: %zu, value: 0x%02x"
> +
> +# max11615.c
> +max11615_write_setup(uint8_t i2c_addr, uint8_t send) "i2c_addr: 0x%02x, data: 0x%02x"
> +max11615_write_config(uint8_t i2c_addr, uint8_t send) "i2c_addr: 0x%02x, data: 0x%02x"
> +max11615_recv(uint8_t i2c_addr, uint8_t reg_addr) "i2c_addr: 0x%02x, reg_addr: 0x%02x"
> +max11615_recv_return(uint8_t i2c_addr, uint8_t data) "i2c_addr: 0x%02x, returns: 0x%02x"
> +max11615_event(uint8_t i2c_addr, uint8_t event) "i2c_addr: 0x%02x, event: 0x%02x"
> +max11615_realize(uint8_t i2c_addr) "i2c_addr: 0x%02x"
> +max11615_reset_enter(uint8_t i2c_addr) "i2c_addr: 0x%02x"
> diff --git a/include/hw/sensor/max11615.h b/include/hw/sensor/max11615.h
> new file mode 100644
> index 0000000000..647ef62ef1
> --- /dev/null
> +++ b/include/hw/sensor/max11615.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef QEMU_MAX11615_H
> +#define QEMU_MAX11615_H
> +
> +#include "hw/i2c/i2c.h"
> +
> +#define TYPE_MAX11615 "max11615"
> +
> +/*
> + * Create and realize a MAX11615 ADC with constant caller-supplied readings
> + * @bus: I2C bus to put it on
> + * @address: I2C address
> + * @init_values: array of readings for each ADC channel
> + * @init_values_size: Size of @init_values, can be less than the number of channels
> + */
> +I2CSlave *max11615_init_with_values(I2CBus *bus, uint8_t address,
> +                                    const uint16_t *init_values, uint32_t init_values_size);
> +
> +#endif
> diff --git a/tests/functional/arm/test_aspeed_fby4.py b/tests/functional/arm/test_aspeed_fby4.py
> index f344413fe4..98223e3ab1 100755
> --- a/tests/functional/arm/test_aspeed_fby4.py
> +++ b/tests/functional/arm/test_aspeed_fby4.py
> @@ -81,6 +81,15 @@ def do_test_arm_aspeed_openbmc_no_network(self, machine, image, uboot,
>           exec_command_and_wait_for_pattern(self,
>               "cat /sys/class/hwmon/hwmon2/fan1_input", "10347");
>   
> +        # MAX11615 test
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/bus/i2c/devices/30-0033/iio:device*/name", "max11615");
> +        # read the value configured in the machine emulation
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/bus/i2c/devices/30-0033/iio:device*/in_voltage0_raw", "1922");
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/bus/i2c/devices/30-0033/iio:device*/in_voltage_scale", "0.500000000");
> +
>       def test_arm_ast2600_yosemitev4_openbmc(self):
>           image_path = self.uncompress(self.ASSET_YOSEMITE_V4_FLASH)
>   


