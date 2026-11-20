Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683BE606A32A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUQxb-0006Tw-9A; Fri, 20 Nov 2026 10:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xUQxZ-0006TH-EU
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 10:55:33 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xUQxW-0002Xs-HJ
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 10:55:33 -0500
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-49d64a88222so1425904f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 07:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795190128; x=1795794928;
 h=user-agent:content-transfer-encoding:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OA3MyGy0zjHVqbUQ8ZkozuEhRkWZJUh7pHL0emEux5s=;
 b=Lkdrk8Sjra7NW62UeAaoZTYXiB6UeN9+U/EHuW62Ma/J/uBpzfrANWMhPYpDuTMGHA
 8+umCeX+w7jVKMgCEM2Ykcif9CurbBFM6lx3AK6e/lBJ88D5s//pgC1dHcbaV/NhLtqk
 fcrXgwAj7F/C1i5Af0iuz23lyeUDrc8D3cBAe0mMU6OqCzHzsB+SNR6DVInlLS5+EOyh
 Zj5mK+ZfrC+s53uH8n+B5VNbUdkvAgFD8hwMBLl3yvgtXOfmiHRToaz/NxPZuEyoJ+D9
 tZoGYFhXoysPyLS7gOntXFyIP/PlmVHKt+TaGoMkqn+yZrItkGAM7LhePWVxyoCw5YMR
 cGGw==
X-Gm-Message-State: APuU4Z+fzmKhoise7ZCb5/OiC9HqEZxHtbtrvkL/vkjPyRrADTKRa1D1
 VwzdXxxRcifi9nbW0eJCgvoaDOySdyuN5RCzdvVu+fKnJ7GG4lQkJFZ7
X-Gm-Gg: AYBFou2heC/RiY2FMF+pvP7NQx+9TSXMGOMtzvYE3ieiyKyRX8S4mx3zVJB0Bs3fi7U
 uzHMGxhHRu+KvtGYB3wJxv5lPbIzyJmtSs+I2dOFsIaz558fpPwT7EFwA92hSEtHxkyxU6b9jUu
 Hmlh+edIcU+rVRPSBLNdzYnENCT/tdKtMeFb2pr3uJUk0NwKtJuh2s5Ou62Avi+/PiWliRghY6D
 8HyHk0Yga2Q51fmYDdEVMKQG0OOYqLZMI4ehGA7F+hVDrI+8K1gVPlwY74xBDYyKkxERYebSXZc
 wMXY6tT/4X4RHa/c6PuTPchreIIGPkIQdL3kUVTVYhgcM47DDeSRZ3u6niw0Uex3iJdyLfLFVzH
 7mbZfXS5hi5ioDVBmRZR7e+l65zEp8yc9/u093a0Ua6aq9vrgik0XwztYaMumzQSICowQowXiUK
 /idyAV+LY+C8I0J0fYIjpHiJa8mzjPgt3crY7jHmNgjjaqo47/h2EbIsNtvnzuLF5TVXLuxlqwh
 uHzlYDEr/pRYh9C26wH2qwkyNrxjaL/bu6irA/zU018C689rN7W34+hiSqDoqNZyq+oMlvYzP2a
 XSEv/CRhG6i/H5CBo47701JOpJC1p7LW8aA3c++rbb9m50cBk3ZctkRgTTSBqVMQ
X-Received: by 2002:a05:600c:1d83:b0:4bb:687c:4fbe with SMTP id
 5b1f17b1804b1-4bb88805c26mr70924715e9.8.1795190127371; 
 Fri, 20 Nov 2026 07:55:27 -0800 (PST)
Received: from localhost (31-38-191-99.abo.bbox.fr. [31.38.191.99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b2c5sm123144735e9.5.2026.11.20.07.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:55:26 -0800 (PST)
To: alexander.hansen@9elements.com
Cc: qemu-devel@nongnu.org, eblot@meta.com, titusr@google.com, clg@kaod.org,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v8 4/5] hw/sensor: MAX31790 support
Date: Fri, 20 Nov 2026 15:48:49 +0000
Message-ID: <reevu.1795189729.574001000.43540.0@free.fr>
In-Reply-To: <20261013124649.194808-5-alexander.hansen@9elements.com>
References: <20261013124649.194808-1-alexander.hansen@9elements.com>
 <20261013124649.194808-5-alexander.hansen@9elements.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
User-Agent: reevu/0.1.0
Received-SPF: pass client-ip=209.85.221.50; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f50.google.com
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 13 Oct 2026 12:46:48 +0000, alexander.hansen@9elements.com wrote:
> From: Alexander Hansen <alexander.hansen@9elements.com>
>
> Product: [1]
> Datasheet: [2]
>
> MAX31790 Support:
> - fan inputs are reading
> - tach reading propertional to pwm setting from linux driver

Nit: Typo: 'proportional'.

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

This trace event (max31790_recv) seems to have been renamed (max31790_recv_return)

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
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1312bbd1bd..870152932c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4119,6 +4119,7 @@ S: Maintained
>  F: hw/i2c/pmbus_device.c
>  F: hw/sensor/adm1272.c
>  F: hw/sensor/isl_pmbus_vr.c
> +F: hw/sensor/max31790.c

It does not seem to be a PMBus device (vs. max31785)
The .h file is tracked.
I do not know if it is possible to assign a maintainer at this stage.

> diff --git a/hw/sensor/max31790.c b/hw/sensor/max31790.c
> new file mode 100644
> index 0000000000..1aca05f35b
> --- /dev/null
> +++ b/hw/sensor/max31790.c
> @@ -0,0 +1,508 @@
> +/*
> + * Maxim MAX31790 PMBus 6-Channel Fan Controller

The MAX31790 is a plain I2C/SMBus device, not PMBus.

> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        s->outbuf[0] = s->fan_dynamics[index];
> +        trace_max31790_fan_dynamics_read(s->i2c.address, index, s->outbuf[0]);
> +        break;
> +    case MAX31790_REG_FAN_FAULT_STATUS_1:
> +    case MAX31790_REG_FAN_FAULT_STATUS_2:
> +        /* we do not have any fan fault */
> +        s->outbuf[0] = 0x00;
> +        s->outbuf[1] = 0x00;
> +        break;
> +    case MAX31790_REG_TACH_COUNT_MSB(0)... MAX31790_REG_TACH_COUNT_LSB(11):
> +        index = reg16_index(s->pointer, MAX31790_REG_TACH_COUNT_MSB(0));
> +
> +        g_assert(index < MAX31790_NUM_TACHS);
> +
> +        set_outbuf_16(s, even_reg, s->tach_count[index % MAX31790_NUM_TACHS]);
> +        break;
> +
> +    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(0)... MAX31790_REG_PWM_DUTY_CYCLE_LSB(

Nit: Line breaking is weird and a bit hard to read

> +        5):
> +        index = reg16_index(s->pointer, MAX31790_REG_PWM_DUTY_CYCLE_MSB(0));
> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        set_outbuf_16(s, even_reg, s->pwm[index & MAX31790_NUM_FANS]);

Is it not '%' rather than '&' here? (repeated below)

> +        break;
> +
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(
> +        0)... MAX31790_REG_TACH_TARGET_COUNT_LSB(5):
> +        index = reg16_index(s->pointer, MAX31790_REG_TACH_TARGET_COUNT_MSB(0));
> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        set_outbuf_16(s, even_reg, s->tach_target[index]);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: read of register %d\n", __func__,
> +                      s->pointer);
> +        break;
> +    }
> +}
> +
> +static uint8_t max31790_get_speed_range(MAX31790State *s, size_t index)
> +{
> +    g_assert(index < MAX31790_NUM_FANS);
> +    const uint16_t value = (s->fan_dynamics[index] >> 5);

Nit: not sure const is useful in C (vs C++), but should be fine

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

It might be better to use #define for true C constants

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

The datasheet says the register pointer auto-increments.
It does not seem the emulation implements this feature.
Supporting it might also simplify 2-byte special handling.

> +    size_t index = 0;
> +    uint16_t pwm = 0;
> +    const uint8_t value = s->buf[0];
> +    const bool is_msb = s->pointer % 2 == 0;
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

Should not this update tach_count register as well? or rather, should not
tach_count register value computed at read time, based on other values?

> +        break;
> +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(
> +        0)... MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(5):
> +        index =
> +            reg16_index(s->pointer, MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0));
> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        pwm =
> +            reg16_write_byte(s->pwm[index & MAX31790_NUM_FANS], is_msb, value);

& vs. % issue?

> +
> +        max31790_pwm_write(s, index, pwm);
> +        break;
> +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(
> +        0)... MAX31790_REG_TACH_TARGET_COUNT_LSB(5):
> +        index = reg16_index(s->pointer, MAX31790_REG_TACH_TARGET_COUNT_MSB(0));
> +
> +        g_assert(index < MAX31790_NUM_FANS);
> +
> +        s->tach_target[index] =
> +            reg16_write_byte(s->tach_target[index], is_msb, value);
> +        break;
> +    default:

I think there should be a double error case here:
1. Features that are not supported (such as user registers): LOG_UNIMP +
   document them in the file header
2. Addresses that are invalid: LOG_GUEST_ERROR
Same remark for the read counterpart.

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

Is is what the HW handles? From the datasheet:

The device’s control registers are organized in rows of 8 bytes. The I2C
master can read or write individual bytes, or canread or write multiple
bytes. When writing consecutive bytes, all writes are to the same row.
When the final byte in therow is reached, the next byte written is the
row’s first byte. For example, a write that starts with 02h (Fan 1
Configuration)can write to 02h, 03h, 04h, 05h, 06h, and 07h. If writes
continue, the next byte written is 00h, and so on.

I think the issue does not show up with Linux that only uses 1- and
2-byte accesses if I'm not mistaken, but the device should work with
other drivers.

Moreover I think that it is valid from the HW device perspective to
start a multibyte access on an odd address, but it is not supported
here.

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

From the datasheet:

Consecutive reads are not subject to the single-row limitation. A read
can start at any address and can continue throughFFh. If reads continue
past FFh, they wrap around to 00h.

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

Tach count array is never initialized

> +    /* this will set both pwm and tach count */
> +    for (int i = 0; i < MAX31790_NUM_FANS; i++) {
> +        max31790_pwm_write(s, i, 0x4444);

Where does 0x4444 come from? It doesn't look like a datasheet POR value.
In any case, a #define constant would be useful here.

> +    }
> +}
> +
> +static void max31790_reset_hold(Object *obj, ResetType type)
> +{
> +    MAX31790State *s = MAX31790(obj);
> +
> +    max31790_reset_enter(s);

This is a bit confusing with the Resettable API (enter/hold/exit).
If the enter phase is used, why mapping it to the hold phase?

> diff --git a/include/hw/sensor/max31790.h b/include/hw/sensor/max31790.h
> new file mode 100644
> index 0000000000..73b6375ae2
> --- /dev/null
> +++ b/include/hw/sensor/max31790.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef QEMU_MAX31790_H

Maybe state the purpose of this file in the header (same as in the C
file)

> diff --git a/tests/functional/arm/test_aspeed_fby4.py b/tests/functional/arm/test_aspeed_fby4.py
> index b6af9a21b7..be396f53bc 100755
> --- a/tests/functional/arm/test_aspeed_fby4.py
> +++ b/tests/functional/arm/test_aspeed_fby4.py
> @@ -34,6 +35,52 @@ def do_test_arm_aspeed_openbmc_no_network(self, machine, image, uboot,
>          # different from the other machines.
>          self.wait_for_console_pattern('yosemite4 login:')
>  
> +        # perform login
> +        exec_command_and_wait_for_pattern(self,
> +                                          "root", "Password:");

Python statements don't need trailing semicolons :-)

> +
> +        exec_command_and_wait_for_pattern(self, "0penBmc", "#");
> +
> +        # MAX31790 test
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/class/hwmon/hwmon3/name", "max31790");

Hardcoding hwmon3 might be fragile: please consider the hwmon directory
from the I2C device path
(e.g. /sys/bus/i2c/devices/<bus>-0020/hwmon/hwmon*).

> +
> +        # this initial fan reading value is caused by services
> +        # inside the image writing the pwm
> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/class/hwmon/hwmon3/fan1_input", "7281");

Maybe stop and sync with the service to ensure the value cannot be
modified while this test is running?

> +        exec_command_and_wait_for_pattern(self,
> +            "cat /sys/class/hwmon/hwmon3/fan1_enable", "1");

The console may echo the command, and the echo contains 'fan1_enable',
so the pattern '1' matches before the command runs, in which case this
check always passes.

It might be worth testing other channels, to validate s->pwm array
management.

Emmanuel.

