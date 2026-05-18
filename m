Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD0BCD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 18:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP2kK-00064N-Pd; Mon, 18 May 2026 14:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wP2kD-00063n-Ug; Mon, 18 May 2026 14:31:14 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wP2kB-0002Do-Dh; Mon, 18 May 2026 14:31:13 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1255C6001A;
 Mon, 18 May 2026 18:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F36C2BCB7;
 Mon, 18 May 2026 18:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779129068;
 bh=4IcgA1xATiOGwZtYPvWjABOdJaKLydE+kjCwGaJYQSk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=nEfiNA9VSjzspr2XqPlzZDpLnaNS4k1EWCdZKE2m55/bXiBL50tNU2PBmKt8kH/X2
 Z6i5a/ldX+Sz2wrOaAYydThoEMEZMN3Lv4SejsRLk7Kgrx6qmY87jgU+Da5GFCL6Lu
 oCgdRWwSG8AaMKcLnNmoYmXz3QNlPK4D0VN9dcTEW4YsAM1gpirqHCU8kH6jtncvD1
 /bEDTh2yPHpVSPl3hk+gZNZydDDINPzv/6GLGLqQjSmoKFVi6VBYGQ7ehQqwgW7CQL
 m4Gs3oIjsQACyaFbvy87Gri5Gzy54xgM1pD6npa8x1OfxYYa0dg2CWuP/s1msWaeyZ
 L5l2v1jeaLl2A==
Date: Mon, 18 May 2026 19:30:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexander Hansen <alexander.hansen@9elements.com>
Cc: qemu-devel@nongnu.org, Titus Rwantare <titusr@google.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v3 4/5] hw/sensor: support MAX11615
Message-ID: <20260518193059.70beae18@jic23-huawei>
In-Reply-To: <20260512102157.176511-5-alexander.hansen@9elements.com>
References: <20260512102157.176511-1-alexander.hansen@9elements.com>
 <20260512102157.176511-5-alexander.hansen@9elements.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=172.105.4.254; envelope-from=jic23@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 12 May 2026 12:20:39 +0200
Alexander Hansen <alexander.hansen@9elements.com> wrote:

> Product: [1]
> Datasheet: [2]
>=20
> Sensor readings can be provided upon creation of the device. In case no
> readings are provided the ADC reads a pre-defined arbitrary value.
>=20
> root@yosemite4:~# cat /sys/bus/iio/devices/iio:device2/name
> max11615
> root@yosemite4:~# cat /sys/bus/iio/devices/iio:device2/in_voltage0_raw
> 1922
> root@yosemite4:~# cat /sys/bus/iio/devices/iio:device2/in_voltage_scale
> 0.500000000
>=20

Great to see emulation for a sensor in this family - I've not had working
actual hardware for quite some time - not because the ADC isn't still
common, but just because the arm board was a PXA271 one that I long
ago killed off kernel support for ;)

A few comments inline. Whilst I understand the motivation is to
emulate something, it is a bit minimal and the linux driver is going
to trip over the gaps if anyone tries to do much beyond the
minimum stuff you have in the test.

I think min changes to make are to log a bit more carefully when
attempts are made to do things that aren't emulated. In some cases
it might be easier to just emulate a bit more though.

It's not a particularly complex device but I understand you probably
don't want to spend that much time on it.

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
>=20
> References:
> [1] https://www.analog.com/en/products/MAX11615.html
> [2] https://www.analog.com/media/en/technical-documentation/data-sheets/M=
AX11612-MAX11617.pdf
>=20
> Cc: Titus Rwantare <titusr@google.com>
> Cc: "C=C3=A9dric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org> (odd fixer:Overall =
sensors)
> Cc: Paolo Bonzini <pbonzini@redhat.com> (maintainer:Kconfig)
> Cc: Peter Maydell <peter.maydell@linaro.org> (supporter:ARM TCG CPUs)
> Cc: qemu-devel@nongnu.org (open list:All patches CC here)
> Cc: qemu-arm@nongnu.org (open list:ARM TCG CPUs)
> Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
> ---
>  MAINTAINERS                              |   1 +
>  hw/arm/Kconfig                           |   1 +
>  hw/arm/aspeed_ast2600_fby4.c             |   8 +-
>  hw/sensor/Kconfig                        |   4 +
>  hw/sensor/max11615.c                     | 202 +++++++++++++++++++++++
>  hw/sensor/meson.build                    |   1 +
>  hw/sensor/trace-events                   |   8 +
>  include/hw/sensor/max11615.h             |  20 +++
>  tests/functional/arm/test_aspeed_fby4.py |   8 +
>  9 files changed, 252 insertions(+), 1 deletion(-)
>  create mode 100644 hw/sensor/max11615.c
>  create mode 100644 include/hw/sensor/max11615.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9c991f8e70..a9c88996a2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3981,6 +3981,7 @@ S: Maintained
>  F: hw/i2c/pmbus_device.c
>  F: hw/sensor/adm1272.c
>  F: hw/sensor/isl_pmbus_vr.c
> +F: hw/sensor/max11615.c
>  F: hw/sensor/max31790.c
>  F: hw/sensor/max34451.c
>  F: include/hw/i2c/pmbus_device.h
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 99864eb878..76a7d327a9 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -553,6 +553,7 @@ config ASPEED_SOC
>      select PMBUS
>      select MAX31785
>      select MAX31790
> +    select MAX11615
>      select FSI_APB2OPB_ASPEED
>      select AT24C
>      select PCI_EXPRESS
> diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4.c
> index a7c2dc09ea..036f5b9e38 100644
> --- a/hw/arm/aspeed_ast2600_fby4.c
> +++ b/hw/arm/aspeed_ast2600_fby4.c
> @@ -12,6 +12,7 @@
>  #include "hw/arm/aspeed_soc.h"
>  #include "hw/nvram/eeprom_at24c.h"
>  #include "hw/sensor/max31790.h"
> +#include "hw/sensor/max11615.h"
>  #include "hw/i2c/i2c_mux_pca954x.h"
>  #include "hw/gpio/pca9552.h"
> =20
> @@ -186,7 +187,12 @@ static void fby4_i2c_init_fanboard(I2CSlave *fan_mux=
, size_t eepromSize)
>          i2c_slave_create_simple(bus, TYPE_MAX31790, 0x2f);
> =20
>          /* maxim,max11615 @ 0x33   (adc) */
> -        /* TODO */
> +        static const uint16_t adc_values[8] =3D {
> +            0b011110000010, 0b010100011000,
> +            0b001000110100, 0b100000101001,
> +            0b011110000010, 0b010100011000,
> +            0b001000110100, 0b100000101001};

Given these correspond to the values read out in the test, maybe just
but them in decimal? I'm not sure what the value is in using binary here.

> +        max11615_init_with_values(bus, 0x33, adc_values, 8);
> =20
>          at24c_eeprom_init_rom(
>              bus, 0x52, eepromSize,
> diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
> index ece2f2b167..84eede9d84 100644
> --- a/hw/sensor/Kconfig
> +++ b/hw/sensor/Kconfig
> @@ -47,3 +47,7 @@ config MAX31785
>  config MAX31790
>      bool
>      depends on PMBUS
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
> + * https://www.analog.com/media/en/technical-documentation/data-sheets/M=
AX11612-MAX11617.pdf
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
> +    uint8_t msb =3D s->channels[s->pointer] >> 8;
> +    uint8_t lsb =3D s->channels[s->pointer] & 0xff;
> +    s->outbuf[0] =3D 0b11110000 | (msb & 0b00001111);
> +    s->outbuf[1] =3D lsb;
> +}
> +
> +static void max11615_write_config_byte(MAX11615State *s, uint8_t data)
> +{
> +    trace_max11615_write_config(s->i2c.address, data);
> +
> +    uint8_t channelSelect =3D (data >> 1) & 0b1111;

It shouldn't be too horrible to support differential mode. Maybe for
now just log something if bit 0 is set or implement as the appropriate
subtraction of the single ended values.

Also good to log a print if the scan mode is set to anything other b11
as output will be garbage (and the linux driver supports all that fun stuff=
).

> +
> +    /* Table 3. Channel Selection (AIN0 ... AIN11) */
> +    if (channelSelect > 11) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid channel select", __f=
unc__);
> +        channelSelect =3D 11;
> +    }
> +    s->pointer =3D channelSelect;
> +}
> +
> +static void max11615_write_setup_byte(MAX11615State *s, uint8_t data)
> +{
> +    trace_max11615_write_setup(s->i2c.address, data);
> +    /* we ignore the setup byte, not implemented */
Maybe should log on any attempt to set it to values that the emulation will
generate wrong answers for? Mind you without differential support only
reference is going to make much difference I think. Probably just
a print on external reference being set?

> +}
> +
> +static int max11615_send(I2CSlave *i2c, uint8_t data)
> +{
> +    MAX11615State *s =3D MAX11615(i2c);
> +    const uint8_t msb =3D (data >> 7) & 0b1;
> +
> +    if (msb) {
> +        max11615_write_setup_byte(s, data);
> +    } else {
> +        max11615_write_config_byte(s, data);
> +    }
> +
> +    s->outlen =3D 0;
> +    return 0;
> +}
> +
> +static uint8_t max11615_recv(I2CSlave *i2c)
> +{
> +    MAX11615State *s =3D MAX11615(i2c);
> +    trace_max11615_recv(s->i2c.address, s->pointer);
> +
> +    max11615_read(s);
> +
> +    if (s->outlen >=3D 2) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: too many bytes read", __func=
__);

Is that right error type?  It's not a guest error to do this, it's
unimp emulation.  From what I recall large reads are how we get multichannel
scans.

> +        s->outlen =3D 0;
> +    }
> +
> +    const uint8_t data =3D  s->outbuf[s->outlen++];

bonus space after =3D

> +
> +    trace_max11615_recv_return(s->i2c.address, data);
> +    return data;
> +}
> +
> +static int max11615_event(I2CSlave *i2c, enum i2c_event event)
> +{
> +    MAX11615State *s =3D MAX11615(i2c);
> +
> +    trace_max11615_event(s->i2c.address, event);
> +
> +    switch (event) {
> +    case I2C_START_RECV:
> +        s->outlen =3D 0;
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_max11615 =3D {
> +    .name =3D TYPE_MAX11615,
> +    .version_id =3D 0,
> +    .minimum_version_id =3D 0,
> +    .fields =3D (const VMStateField[]){
> +        VMSTATE_UINT16_ARRAY(channels, MAX11615State, MAX11615_NUM_CHANN=
ELS),
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
> +    s =3D MAX11615(i2c_slave_new(TYPE_MAX11615, address));
> +
> +    for (int i =3D 0; i < MAX11615_NUM_CHANNELS && i < init_values_size;=
 i++) {
> +
> +        /* arbitrary value */
> +        uint16_t value =3D 0b0000101011010010;
> +
> +        if (i < init_values_size) {
> +            value =3D init_values[i];
> +        }
> +        s->channels[i] =3D value;
> +    }
> +
> +    i2c_slave_realize_and_unref(I2C_SLAVE(s), bus, &error_abort);
> +
> +    return I2C_SLAVE(s);
> +}
> +
> +static void max11615_realize(DeviceState *dev, Error **errp)
> +{
> +    MAX11615State *s =3D MAX11615(dev);
> +
> +    trace_max11615_realize(s->i2c.address);
> +
> +    s->pointer =3D 0;
> +    s->outlen =3D 0;
> +}

> diff --git a/tests/functional/arm/test_aspeed_fby4.py b/tests/functional/=
arm/test_aspeed_fby4.py
> index d29423add7..319f1a7672 100755
> --- a/tests/functional/arm/test_aspeed_fby4.py
> +++ b/tests/functional/arm/test_aspeed_fby4.py
> @@ -51,6 +51,14 @@ def do_test_arm_aspeed_openbmc_no_network(self, machin=
e, image, uboot,
>          exec_command_and_wait_for_pattern(self,
>              "cat /sys/class/hwmon/hwmon2/fan1_fault", "0");
> =20
> +        # MAX11615 test
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/bus/iio/devices/iio:device2/name", "max11615");
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/bus/iio/devices/iio:device2/in_voltage0_raw", "192=
2");
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/bus/iio/devices/iio:device2/in_voltage_scale", "0.=
500000000");
> +
The file naming is probably not stable.  But I guess it might work well eno=
ugh.
If you want stable file names go via the bus device and a wild card for the=
=20
iio:device? bit


Jonathan


