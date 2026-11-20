Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0388A60A2609
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSh1-0007VX-Bd; Fri, 20 Nov 2026 12:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xUSgy-0007Ue-I3
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:46:32 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xUSgv-00076F-TC
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:46:32 -0500
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e47347279so674037f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 09:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795196788; x=1795801588;
 h=user-agent:content-transfer-encoding:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LaozFs58eFR06BZA/sbq+kzNLFB2/AKKGyEXybFcCHo=;
 b=EvljjuXw80iSWnUzCU5tfd+ecZmnDE//Eu8nDIpkMR4ckhYAb2oegluYQ9y+dNFU9h
 IDBru/ChesW0bQlf8ZMRlKXt7mK5jN2yCqb99jQ/5/YG0/uIa/w/pSDT4lS4Nz6UriIw
 TooGF5HpkbznKWC0qwH2pcwaNdznlAM0oWvQRr12KKI27cPIUgcoWvCrPQD8TcfdZQZY
 O5aiDTPUlRy5YJIdBFHM/wkZij/DqSsffYPlRDkL8y7/OTtZ/lZG+GpwHm43kRI4MgMt
 65DgSyy+f3KgwWgR2/0VGCmUDXn949iEIe0hw6xvGGYbdx0zDmuAyOqPl8w1lFO9qLvk
 tSIw==
X-Gm-Message-State: APuU4Z9lLVMRgSkPhC8bNWK2sdkGDmmOiq1DMovAQ3/L3EVxQnouGFeA
 JWl9KhEvlWlM7GyjeBqA26e3MnYYWPoon+pL0Sa1mQ9qhatvY6ghIPjs
X-Gm-Gg: AZFdTZfwVcmwS06CWShdZyUc5rqWBUcSNHcam8IHtOx8t0ByvZkCOh+3AJ0CJWEASCh
 eeGc/ZvjNR5czig3ExeIHmxM7nIhcDE6g3OHrm5IapyQWbZUF7aBmA2zCAaVYo3q6eoJYCQo1uX
 ZYCUBByVGU9bbSQ5klWJkQj9judsuRhqk5VzyH078CxNL1t8axfcYKZ82OP8p80CZ2CxyXvoQb9
 f2sXOUHuj3LBj+hSJtDSBXIjr6/inMz2wMsLSzES9bJx+lgS4cCQiJjrcpBL5nUrIE/WIOA5D18
 GrinhSTlcEdiEoiAO4BcaAhf0J/ZUJAJVLaBfKEOYz7qANAwAOG89L6ix5O5XNLzlC5s6hJojs4
 3PhjEohKsiEbOQj+Xw4tbWkTlrcgie5ohz0ZteMkXR0m8QJ9cdYGKi7+VIW9psnxizq2ya+0Ozm
 EBsTUvcIzfWEW4PaAAL0majKPNjpDVt8KLOpoE5M+h4QWgpZhdVxGRY8MsFionNBF95jRbKTgi9
 3D4EQzgCDQB0z9KEJdkv4F86kHlX6SbcAsukPykKMdqBn7crJZp1+X7ADOsDFEH21UrvTpZQmq+
 NJ6L7JzeUXI6q9lplCCpc1aVD7PMBm3Teh0iSd2oBqatbeQtSDEqvxru4hM2igYr
X-Received: by 2002:a05:6000:4809:b0:4aa:842f:5f78 with SMTP id
 ffacd0b85a97d-4abb759e947mr8062620f8f.46.1795196788033; 
 Fri, 20 Nov 2026 09:46:28 -0800 (PST)
Received: from localhost (31-38-191-99.abo.bbox.fr. [31.38.191.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf630esm7030212f8f.16.2026.11.20.09.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 09:46:27 -0800 (PST)
To: alexander.hansen@9elements.com
Cc: qemu-devel@nongnu.org, eblot@meta.com, titusr@google.com, clg@kaod.org,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v8 5/5] hw/sensor: support MAX11615
Date: Fri, 20 Nov 2026 17:38:31 +0000
Message-ID: <reevu.1795196311.957878000.15648.1@free.fr>
In-Reply-To: <20261013124649.194808-6-alexander.hansen@9elements.com>
References: <20261013124649.194808-1-alexander.hansen@9elements.com>
 <20261013124649.194808-6-alexander.hansen@9elements.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
User-Agent: reevu/0.1.0
Received-SPF: pass client-ip=209.85.221.49; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f49.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 13 Oct 2026 12:46:49 +0000, alexander.hansen@9elements.com wrote:
> From: Alexander Hansen <alexander.hansen@9elements.com>
>
> Product: [1]
> Datasheet: [2]
>
> The ADC reads a pre-defined arbitrary value.
>
> root@yosemite4:~# cat /sys/bus/iio/devices/iio:device2/name
> max11615
> root@yosemite4:~# cat /sys/bus/iio/devices/iio:device2/in_voltage0_raw
> 722
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

Nit: is this trace in sync with the code?

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
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 870152932c..6bd06dd3ab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4119,6 +4119,7 @@ S: Maintained
>  F: hw/i2c/pmbus_device.c
>  F: hw/sensor/adm1272.c
>  F: hw/sensor/isl_pmbus_vr.c
> +F: hw/sensor/max1161x.c

The MAX11615 is a plain I2C ADC, not a PMBus device
include/hw/sensor/max1161x.h is not listed
I do not know if this new code can be assigned to a maintainer

> diff --git a/hw/sensor/max1161x.c b/hw/sensor/max1161x.c
> new file mode 100644
> index 0000000000..69f7da0438
> --- /dev/null
> +++ b/hw/sensor/max1161x.c
> @@ -0,0 +1,314 @@
> +/*
> + * Maxim MAX11615 Low-Power 12 bit ADC
> + * Models MAX11612,MAX11613,MAX11614,MAX11615,MAX11616,MAX11617

Only MAX11615 is registered, and class_init hardcodes the MAX11615
parameters. The other parts differ.
Maybe only keep 11615 reference for now, and add a note that document
the same file could be used to support other variants? IOW, keep the
'x' suffix for function prefixes, filenames and struct names, but only
document '5' variant as currently supported.

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
> +#include "hw/sensor/max1161x.h"
> +#include "hw/i2c/i2c.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "trace.h"
> +
> +#define MAX11615_NUM_CHANNELS 8
> +
> +struct MAX11615State {

Should be MAX1161xState I believe

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

I think you need to specify the unit here: mV

> +
> +    uint16_t channels[MAX11615_NUM_CHANNELS];

What do channels actually store: RAW/output value or the real voltage?

> +    I2CSlaveClass parent_class;
> +
> +    uint8_t channel_select_mask;
> +    size_t n_channels;
> +};
> +
> +OBJECT_DECLARE_TYPE(MAX11615State, MAX1161XClass, MAX11615)
> +
> +static void max1161x_reset(MAX11615State *s)
> +{
> +    trace_max11615_reset(s->i2c.address);
> +
> +    s->single_ended = true;
> +    s->bipolar = false;
> +    s->vref = 2048;
> +    s->pointer = 0;
> +    s->outlen = 0;
> +
> +    MAX1161XClass *mc = MAX11615_GET_CLASS(s);
> +
> +    for (int i = 0; i < mc->n_channels; i++) {

signed int vs. unsigned (long) int comparison

> +        s->channels[i] = 0x2d2;

Why 0x2d2? I think it should rather be a C #define with some short doc.
It would be nice to have dynamic object properties to change the values
on the ADC input pins

> +    }
> +}
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

I think raw unit/output code and voltage in mV are mixed here. The
actual voltage scaling is ignored: 1 LSB is 0.5 mv so 2048 raw value
means ~ 1.024 volts. I would suggest to name the variables/constants
(local and in MAX11615 state) to reflect the unit/type of data to avoid
this kind of mistake, and help the reader.

It is probably easier to store the actual voltage in mV and perform
conversion to output value on read out

> +}
> +
> +static int16_t max11615_differential_value(const MAX11615State *s)
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

Same unit mismatch here

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

Only SCAN=0b11 is supported here, which means "convert the selected
channel" and do not scan, where as the management of 'pointer' makes the
opposite and implements channel scanning.

> +    }
> +
> +    const MAX1161XClass *mc = MAX11615_GET_CLASS(s);
> +
> +    uint8_t channel_select = (data >> 1) & mc->channel_select_mask;
> +
> +    /* Table 3. Channel Selection */
> +    if (channel_select >= mc->n_channels) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid channel select\n",
> +                      __func__);
> +        channel_select = mc->n_channels - 1;
> +    }
> +    s->pointer = channel_select;
> +    s->single_ended = data & 0x1;
> +}
> +
> +static void max11615_write_setup_byte(MAX11615State *s, uint8_t data)
> +{
> +    trace_max11615_write_setup(s->i2c.address, data);
> +    /* we ignore the setup byte, not implemented */

This comment is out-of-sync, as the code below does handle RST, BIP/UNI
and the reference select.

SEL=00x (VDD as reference) is neither handled nor logged; vref stays at
2048.

> +
> +    /* 1 = no action, 0 = resets the configuration register to default */
> +    const bool rst = ((data >> 1) & 0x1) == 0x0;

Nit: maybe registerfields.h REG8 macros could help, naming fields and
writing if (! (data & R_SETUP_RST) ) or the like

> +
> +    if (rst) {
> +        max1161x_reset(s);

RST=0 resets only the configuration register (scan, CS, SGL/DIF) whereas
the setup register stays as it is.

max1161x_reset() also resets vref, bipolar and the simulated analog
input values in channels[].

The reset feature should be split (config-register reset vs. out of the
device reset).

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
> +    MAX1161XClass *mc = MAX11615_GET_CLASS(s);
> +
> +    if (s->outlen >= 2) {
> +        /* MAX11615 supports multichannel scan with wraparound */
> +        /* see datasheet page 17 */

This depends on SCAN mode

> +
> +        s->outlen = 0;
> +
> +        s->pointer++;
> +        if (s->pointer >= mc->n_channels) {
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

There is a mix of max11615_ and max1161x_ prefixes

> +{
> +    MAX11615State *s = MAX11615(i2c);
> +
> +    trace_max11615_event(s->i2c.address, event);
> +
> +    switch (event) {
> +    case I2C_START_RECV:
> +        s->outlen = 0;

outlen is reset but not pointer

After a guest reads 4 bytes, pointer is 1. Every later read transaction
then returns AIN1 although CS still selects AIN0. On real hardware each
read starts a new conversion of the configured channel(s).

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

I'm not sure this matches the usual QEMU format style

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
> +static void max1161x_reset_hold(Object *obj, ResetType type)
> +{
> +    MAX11615State *s = MAX11615(obj);
> +
> +    max1161x_reset(s);

At reset, the device uses SEL=0b000, that is VDD as the voltage
reference, which is not internal Vref Either warn if a conversion is
started without SEL being assigned Vref first, or implement Vref
conversion. I would suggest the latter, as it could reveal unit
conversion issues with some dedicated unit tests.

> +}
> +
> +static void max11615_realize(DeviceState *dev, Error **errp)
> +{
> +    MAX11615State *s = MAX11615(dev);

Drop this function since it does nothing (anymore?)

> diff --git a/hw/sensor/trace-events b/hw/sensor/trace-events
> index 2041c91dd9..b0d46f3f01 100644
> --- a/hw/sensor/trace-events
> +++ b/hw/sensor/trace-events
> @@ -25,3 +25,12 @@ max31790_fan_dynamics_read(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c
>  max31790_fan_dynamics_write(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c_addr: 0x%02x, channel: %zu, value: 0x%02x"
>  max31790_fan_config_read(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c_addr: 0x%02x, channel: %zu, value: 0x%02x"
>  max31790_fan_config_write(uint8_t i2c_addr, size_t channel, uint8_t value) "i2c_addr: 0x%02x, channel: %zu, value: 0x%02x"
> +
> +# max11615.c

The file is named max1161x.c

> diff --git a/tests/functional/arm/test_aspeed_fby4.py b/tests/functional/arm/test_aspeed_fby4.py
> index be396f53bc..0d81638c82 100755
> --- a/tests/functional/arm/test_aspeed_fby4.py
> +++ b/tests/functional/arm/test_aspeed_fby4.py
> @@ -81,6 +81,15 @@ def do_test_arm_aspeed_openbmc_no_network(self, machine, image, uboot,
>          exec_command_and_wait_for_pattern(self,
>              "cat /sys/class/hwmon/hwmon3/fan1_input", "10347");
>  
> +        # MAX11615 test
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/bus/i2c/devices/30-0033/iio:device*/name", "max11615");
> +        # read the value configured in the machine emulation
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/bus/i2c/devices/30-0033/iio:device*/in_voltage0_raw", "722");
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/bus/i2c/devices/30-0033/iio:device*/in_voltage_scale", "0.500000000");

Beware of line width, use checkpath.pl for guidance

Emmanuel.

