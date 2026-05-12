Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECB2CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 16:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMqOZ-0006ri-Pp; Tue, 12 May 2026 12:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wMqOX-0006rB-NG
 for qemu-devel@nongnu.org; Tue, 12 May 2026 12:55:45 -0400
Received: from smtpout3.mo533.mail-out.ovh.net ([46.105.35.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wMqOT-000890-Fp
 for qemu-devel@nongnu.org; Tue, 12 May 2026 12:55:45 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4gFN564N2Jz60rl;
 Tue, 12 May 2026 16:55:38 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Tue, 12 May 2026 16:55:38 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.54.5])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gFN562rzZz7tj0;
 Tue, 12 May 2026 16:55:38 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 95C1312E3519;
 Tue, 12 May 2026 16:55:36 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S006bdefc18f-2c98-4807-8556-5e11b07817e1,
 39874C6F3F9F68F15966500C6FBBDB0B53A96BD7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <fe3414be-8150-42ac-b2ae-2518bb499b38@kaod.org>
Date: Tue, 12 May 2026 18:55:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] hw/sensor: support MAX11615
To: Alexander Hansen <alexander.hansen@9elements.com>, qemu-devel@nongnu.org
Cc: Titus Rwantare <titusr@google.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20260512102157.176511-1-alexander.hansen@9elements.com>
 <20260512102157.176511-5-alexander.hansen@9elements.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260512102157.176511-5-alexander.hansen@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 6596084607260273903
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEHaMiDIf9cGkuhyIqLYoWm7NUqfthgwNkFfjfrvdomlo3dwxAPQjpSozDTUaWaOra9mbTP8mEKSWYeQT6u1z6i43kf28ZW2b4XT1ztLdtCMMy0+HI2Tqm/3LnjR3Txbx4LyvWOYiTS6z1LcifMWr1NXOQfc2FM+AfQetDjZrSSF22x67cfHCuYO66SZ2f1/Mqeq2fmEPyDFeqA77RfLuuL8awo8Wrq/UNbmk90j683dtehIB1flCxvYvCj7oenCIt/NhRycziqpk6rk4pekPyblZxIAnADGm9xGgmURDtFJsatzgVBG+2vYeEFDorOX6b2KngtF4NdMK8XjlDeU+7CExinmUYrdXZZNdLuqWVrYY/G7/xY6p8pUicOQjDIJAFs79JAR3dGwnAhM8M+1WK7ltjyWFEFErSU06p8ewvJXv5060guCaq9DClsIhw+oFKsNS2gpb03DFBIdfpWvhr53Io4GJe3DY72Qwz5hBznb3NfwwKqLLU5C9pLK/ZFgomK32SJgN+Uw7qr9nPs+yujHXwy+ktujM4qtgeGO38TJB1KhTe0iiF7aPozRYvgbAegK+f2Dm8fsUxMKtpdQujydPYyD1vMhvw8pwDwwp7FEJfZKPux/8Lxc726OwjfqcWPDeBTULu3PgZJLPAu2BSsYiw1OW2merd9TCxRC/KwYg
DKIM-Signature: a=rsa-sha256; bh=Q650hUVmYkYbfLIhkTzQ2klg1iyhYoOeX4LrirQ5hRA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1778604939; v=1;
 b=ewClaUcOPEJ2/h4w9p5ACkjON1tCxbzS3asAdvebXV6bE0tn/1AXUvWNeMVHQt51xfB7sF4E
 dplZ5vHqWOULlQNaecv57S/JA7albPMqpnSvZlQU6RVZcFUFdUz4LZGo5deSyBpRIDKiW1Vz3Fy
 17NIyVCZ0b+9VWH7PCTwrfZX2jrJLgazs4dgVj5G59Y7K8vh58czLXWsT+6aMP+ZLssPQex2wj5
 VOmv/knwvp8mMcdFVz9BaG5FuwsQMBjzFYCAkvPFu98KJM8vvVTFDnBVARiW5yOWR/YQ6tqrqY7
 CIgVjUobrYXKbIpv1mhHOBTZHH3uy2fF2r+MKVmuKdHTw==
Received-SPF: pass client-ip=46.105.35.92; envelope-from=clg@kaod.org;
 helo=smtpout3.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Cc: Titus Rwantare <titusr@google.com>
> Cc: "Cédric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
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
>   hw/sensor/max11615.c                     | 202 +++++++++++++++++++++++
>   hw/sensor/meson.build                    |   1 +
>   hw/sensor/trace-events                   |   8 +
>   include/hw/sensor/max11615.h             |  20 +++
>   tests/functional/arm/test_aspeed_fby4.py |   8 +
>   9 files changed, 252 insertions(+), 1 deletion(-)
>   create mode 100644 hw/sensor/max11615.c
>   create mode 100644 include/hw/sensor/max11615.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9c991f8e70..a9c88996a2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3981,6 +3981,7 @@ S: Maintained
>   F: hw/i2c/pmbus_device.c
>   F: hw/sensor/adm1272.c
>   F: hw/sensor/isl_pmbus_vr.c
> +F: hw/sensor/max11615.c
>   F: hw/sensor/max31790.c
>   F: hw/sensor/max34451.c
>   F: include/hw/i2c/pmbus_device.h
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 99864eb878..76a7d327a9 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -553,6 +553,7 @@ config ASPEED_SOC
>       select PMBUS
>       select MAX31785
>       select MAX31790
> +    select MAX11615
>       select FSI_APB2OPB_ASPEED
>       select AT24C
>       select PCI_EXPRESS
> diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4.c
> index a7c2dc09ea..036f5b9e38 100644
> --- a/hw/arm/aspeed_ast2600_fby4.c
> +++ b/hw/arm/aspeed_ast2600_fby4.c
> @@ -12,6 +12,7 @@
>   #include "hw/arm/aspeed_soc.h"
>   #include "hw/nvram/eeprom_at24c.h"
>   #include "hw/sensor/max31790.h"
> +#include "hw/sensor/max11615.h"
>   #include "hw/i2c/i2c_mux_pca954x.h"
>   #include "hw/gpio/pca9552.h"
>   
> @@ -186,7 +187,12 @@ static void fby4_i2c_init_fanboard(I2CSlave *fan_mux, size_t eepromSize)
>           i2c_slave_create_simple(bus, TYPE_MAX31790, 0x2f);
>   
>           /* maxim,max11615 @ 0x33   (adc) */
> -        /* TODO */
> +        static const uint16_t adc_values[8] = {
> +            0b011110000010, 0b010100011000,
> +            0b001000110100, 0b100000101001,
> +            0b011110000010, 0b010100011000,
> +            0b001000110100, 0b100000101001};
> +        max11615_init_with_values(bus, 0x33, adc_values, 8);
>   
>           at24c_eeprom_init_rom(
>               bus, 0x52, eepromSize,
> diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
> index ece2f2b167..84eede9d84 100644
> --- a/hw/sensor/Kconfig
> +++ b/hw/sensor/Kconfig
> @@ -47,3 +47,7 @@ config MAX31785
>   config MAX31790
>       bool
>       depends on PMBUS
> +
> +config MAX11615
> +    bool
> +    depends on I2C
> diff --git a/hw/sensor/max11615.c b/hw/sensor/max11615.c
> new file mode 100644
> index 0000000000..7950e00e33
> --- /dev/null
> +++ b/hw/sensor/max11615.c
> @@ -0,0 +1,202 @@
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
> +#include "hw/i2c/i2c.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "trace.h"
> +#include "hw/sensor/max11615.h"
> +
> +#define MAX11615_NUM_CHANNELS 8
> +
> +struct MAX11615State {
> +    I2CSlave i2c;
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
> +static void max11615_read(MAX11615State *s)
> +{
> +    /* read an ADC channel, first 4 bits must be high */
> +    uint8_t msb = s->channels[s->pointer] >> 8;
> +    uint8_t lsb = s->channels[s->pointer] & 0xff;
> +    s->outbuf[0] = 0b11110000 | (msb & 0b00001111);
> +    s->outbuf[1] = lsb;
> +}
> +
> +static void max11615_write_config_byte(MAX11615State *s, uint8_t data)
> +{
> +    trace_max11615_write_config(s->i2c.address, data);
> +
> +    uint8_t channelSelect = (data >> 1) & 0b1111;

channel_select

> +
> +    /* Table 3. Channel Selection (AIN0 ... AIN11) */
> +    if (channelSelect > 11) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid channel select", __func__);
> +        channelSelect = 11;
> +    }
> +    s->pointer = channelSelect;
> +}
> +
> +static void max11615_write_setup_byte(MAX11615State *s, uint8_t data)
> +{
> +    trace_max11615_write_setup(s->i2c.address, data);
> +    /* we ignore the setup byte, not implemented */
> +}
> +
> +static int max11615_send(I2CSlave *i2c, uint8_t data)
> +{
> +    MAX11615State *s = MAX11615(i2c);
> +    const uint8_t msb = (data >> 7) & 0b1;
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
> +    max11615_read(s);
> +
> +    if (s->outlen >= 2) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: too many bytes read", __func__);
> +        s->outlen = 0;
> +    }
> +
> +    const uint8_t data =  s->outbuf[s->outlen++];
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
> +    .fields = (const VMStateField[]){
> +        VMSTATE_UINT16_ARRAY(channels, MAX11615State, MAX11615_NUM_CHANNELS),
> +        VMSTATE_UINT8(outlen, MAX11615State),
> +        VMSTATE_UINT8_ARRAY(outbuf, MAX11615State, 2),
> +        VMSTATE_UINT8(pointer, MAX11615State),
> +        VMSTATE_I2C_SLAVE(i2c, MAX11615State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void max11615_init(Object *obj)
> +{
> +    /* Nothing to do */
> +}
> +
> +I2CSlave *max11615_init_with_values(I2CBus *bus, uint8_t address,
> +    const uint16_t *init_values, uint32_t init_values_size)
> +{
> +    MAX11615State *s;
> +
> +    s = MAX11615(i2c_slave_new(TYPE_MAX11615, address));
> +
> +    for (int i = 0; i < MAX11615_NUM_CHANNELS && i < init_values_size; i++) {
> +
> +        /* arbitrary value */
> +        uint16_t value = 0b0000101011010010;
> +
> +        if (i < init_values_size) {
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
> +static void max11615_realize(DeviceState *dev, Error **errp)
> +{
> +    MAX11615State *s = MAX11615(dev);
> +
> +    trace_max11615_realize(s->i2c.address);
> +
> +    s->pointer = 0;
> +    s->outlen = 0;
> +}
> +
> +static void max11615_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +
> +    dc->realize = max11615_realize;
> +    dc->desc = "Maxim MAX11615 12-bit ADC";
> +    dc->vmsd = &vmstate_max11615;
> +    k->event = max11615_event;
> +    k->recv = max11615_recv;
> +    k->send = max11615_send;
> +}
> +
> +static const TypeInfo max31790_info = {

wrong name.

Thanks,

C.

> +    .name = TYPE_MAX11615,
> +    .parent = TYPE_I2C_SLAVE,
> +    .instance_size = sizeof(MAX11615State),
> +    .class_size = sizeof(MAX11615Class),
> +    .instance_init = max11615_init,
> +    .class_init = max11615_class_init,
> +};
> +
> +static void max31790_register_types(void)
> +{
> +    type_register_static(&max31790_info);
> +}
> +
> +type_init(max31790_register_types)
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
> index c15c0a7e93..3fed979e85 100644
> --- a/hw/sensor/trace-events
> +++ b/hw/sensor/trace-events
> @@ -12,3 +12,11 @@ max31790_recv_return(uint8_t i2c_addr, uint8_t data) "i2c_addr: 0x%02x, returns:
>   max31790_event(uint8_t i2c_addr, uint8_t event) "i2c_addr: 0x%02x, event: 0x%02x"
>   max31790_realize(uint8_t i2c_addr) "i2c_addr: 0x%02x"
>   max31790_pwm_write(uint8_t i2c_addr, size_t index, uint16_t value) "i2c_addr: 0x%02x, index: %zu, value: 0x%04x"
> +
> +# max11615.c
> +max11615_write_setup(uint8_t i2c_addr, uint8_t send) "i2c_addr: 0x%02x, data: 0x%02x"
> +max11615_write_config(uint8_t i2c_addr, uint8_t send) "i2c_addr: 0x%02x, data: 0x%02x"
> +max11615_recv(uint8_t i2c_addr, uint8_t reg_addr) "i2c_addr: 0x%02x, reg_addr: 0x%02x"
> +max11615_recv_return(uint8_t i2c_addr, uint8_t data) "i2c_addr: 0x%02x, returns: 0x%02x"
> +max11615_event(uint8_t i2c_addr, uint8_t event) "i2c_addr: 0x%02x, event: 0x%02x"
> +max11615_realize(uint8_t i2c_addr) "i2c_addr: 0x%02x"
> diff --git a/include/hw/sensor/max11615.h b/include/hw/sensor/max11615.h
> new file mode 100644
> index 0000000000..ccc0c9bc2e
> --- /dev/null
> +++ b/include/hw/sensor/max11615.h
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#ifndef QEMU_MAX11615_H
> +#define QEMU_MAX11615_H
> +
> +#include <stdint.h>
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
> index d29423add7..319f1a7672 100755
> --- a/tests/functional/arm/test_aspeed_fby4.py
> +++ b/tests/functional/arm/test_aspeed_fby4.py
> @@ -51,6 +51,14 @@ def do_test_arm_aspeed_openbmc_no_network(self, machine, image, uboot,
>           exec_command_and_wait_for_pattern(self,
>               "cat /sys/class/hwmon/hwmon2/fan1_fault", "0");
>   
> +        # MAX11615 test
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/bus/iio/devices/iio:device2/name", "max11615");
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/bus/iio/devices/iio:device2/in_voltage0_raw", "1922");
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/bus/iio/devices/iio:device2/in_voltage_scale", "0.500000000");
> +
>       def test_arm_ast2600_yosemitev4_openbmc(self):
>           image_path = self.uncompress(self.ASSET_YOSEMITE_V4_FLASH)
>   


