Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA0CC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 20:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rih4f-00019h-GL; Fri, 08 Mar 2024 15:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rih4e-00018a-6p
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 15:44:12 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rih4c-00074C-71
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 15:44:11 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33e2774bdc5so1861010f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 12:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709930648; x=1710535448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3x5qrcX/Vesq43PITjbZccQG2661oOnRzIb5TFsL3Kc=;
 b=pmhVzHB5itfcPosPKfcyWUACw5/2A1A4bFVptLW9nV6nJg0W9HmDq3qB8MsxKcVNSC
 9N8qCpuZttwAkVeC1zKKGjcpnN5/Jtxi2GZON8TQkUcuakBmSSM2X/28MeMoSIFV9DA/
 OFdPtVyIAfZ4nGF7nF6RLXmDqWVr1EeM2LbOt/h8xaYp5Avw5mBXV/i+UD6zGesqw8Yh
 3f/3Pv53WpO6JkOD9+E92CD6EozmI1dXqXxD/aNUWEIbImJT/YtKtRlEsniqv9lYzfm1
 WnwFxxSmhL9HQpICUtzocbgC0u37QkewPKBCEsU4rejh1aIrxidRwUzQlAnc66QTeFIW
 AxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709930648; x=1710535448;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3x5qrcX/Vesq43PITjbZccQG2661oOnRzIb5TFsL3Kc=;
 b=d9U22N3xdQ+A5q3fAgpCY7ZRzjuPnc33J8T4RTzFCH3eP3+Rvm/2ll+aac5HaZfjdi
 TeVslrjv6DzIjKGJS7LhmE4W0v05+vNUfe6KKvmRbzWRkpDDA02GhTlHGO6BCWO/7HYH
 pB/z+RYslC5JwBzcGBQL75gyHiKpePHbmYXkFF1qwMXAGpajUr6vBGCHM90SP2jKaRFR
 P7h3Kp3bUpYSKzHoq66rpTivRqK9HyNtCG30HPrhw5fqAE9qfLDdEeMtnhooHcchDoG9
 NMg1YrsQLC6/V757gU1z2hmU+Ce4gblJitaUQOuyio0Eaukzi8xH3FNkyJKvDxXdcVnV
 E/3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoRKGfUL52jtG6LRU7cNNthIknPIKZDbDzlygHJyWYp3pPS9oRow3+j32tw1KWNTxrTtt8/F/+BrjsBXIIXLXTbgflN/c=
X-Gm-Message-State: AOJu0YyUFeRt8Rma9FzG4aYsZot5MLB5FnZGgfGbOwyag4JRi7hpEb9F
 Dbn4UbRskSi3/qdGIOzr2n2FPs+iOvDpzov/vOvqb9Pt2OFL1XmXFHf70xpfad3G1PYtU+ct36F
 f
X-Google-Smtp-Source: AGHT+IHe1AkxIhFbe2lg0kgwcGCCuYmd2TjVd/i/NtqKniy8vm0lhFG0EHVBQlcm2SZ6tG/y1mcLmQ==
X-Received: by 2002:adf:fd89:0:b0:33e:363b:a7dd with SMTP id
 d9-20020adffd89000000b0033e363ba7ddmr210527wrr.20.1709930648462; 
 Fri, 08 Mar 2024 12:44:08 -0800 (PST)
Received: from [192.168.69.100] (cvl92-h01-176-184-49-62.dsl.sta.abo.bbox.fr.
 [176.184.49.62]) by smtp.gmail.com with ESMTPSA id
 bk5-20020a0560001d8500b0033e699fc6b4sm267654wrb.69.2024.03.08.12.44.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 12:44:08 -0800 (PST)
Message-ID: <0cbde20b-db66-4894-b498-8360b8006693@linaro.org>
Date: Fri, 8 Mar 2024 21:44:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw: gpio: introduce pcf8574 driver
Content-Language: en-US
To: Dmitriy Sharikhin <d.sharikhin@yadro.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Igor Kononenko <i.kononenko@yadro.com>,
 "Alexander A. Filippov" <a.filippov@yadro.com>,
 Alexander Amelkin <a.amelkin@yadro.com>
References: <ee386866ca7ba80add0c428b59efb936fd7ce797.camel@yadro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ee386866ca7ba80add0c428b59efb936fd7ce797.camel@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Dmitriy,

On 1/3/24 08:36, Dmitriy Sharikhin wrote:
> NXP PCF8574 and compatible ICs are simple I2C GPIO expanders.
> PCF8574 incorporates quasi-bidirectional IO, and simple
> communication protocol, when IO read is I2C byte read, and
> IO write is I2C byte write. User can think of it as
> open-drain port, when line high state is input and line low
> state is output.
> 
> This patch allow to instantiate virtual I2C device called
> "pcf8574" in machine init code via generic mechanism.
> 
> Signed-off-by: Dmitrii Sharikhin <d.sharikhin@yadro.com>
> ---
>   hw/gpio/Kconfig           |   4 ++
>   hw/gpio/meson.build       |   1 +
>   hw/gpio/pcf8574.c         | 139 ++++++++++++++++++++++++++++++++++++++
>   include/hw/gpio/pcf8574.h |  15 ++++
>   4 files changed, 159 insertions(+)
>   create mode 100644 hw/gpio/pcf8574.c
>   create mode 100644 include/hw/gpio/pcf8574.h
> 
> diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
> index d2cf3accc8..bb731ff4ce 100644
> --- a/hw/gpio/Kconfig
> +++ b/hw/gpio/Kconfig
> @@ -16,3 +16,7 @@ config GPIO_PWR
>   
>   config SIFIVE_GPIO
>       bool
> +
> +config PCF8574
> +    bool
> +    depends on I2C
> diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
> index 8a8d03d885..c0d9a3c757 100644
> --- a/hw/gpio/meson.build
> +++ b/hw/gpio/meson.build
> @@ -15,3 +15,4 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
>   ))
>   system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
> +system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
> diff --git a/hw/gpio/pcf8574.c b/hw/gpio/pcf8574.c
> new file mode 100644
> index 0000000000..a6c6bd36fa
> --- /dev/null
> +++ b/hw/gpio/pcf8574.c
> @@ -0,0 +1,139 @@
> +/*
> + * NXP PCF8574 8-port I2C GPIO expansion chip.
> + *
> + * Copyright (c) 2024 KNS Group (YADRO).
> + * Written by Dmitrii Sharikhin <d.sharikhin@yadro.com>
> + *
> + * This file is licensed under GNU GPL.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/i2c/i2c.h"
> +#include "hw/gpio/pcf8574.h"
> +#include "hw/irq.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qom/object.h"
> +
> +/**
> + * PCF8574 and compatible chips incorporate quasi-bidirectional
> + * IO. Electrically it means that device sustain pull-up to line
> + * unless IO port is configured as output _and_ driven low.
> + *
> + * IO access is implemented as simple I2C single-byte read
> + * or write operation. So, to configure line to input user write 1
> + * to corresponding bit. To configure line to output and drive it low
> + * user write 0 to corresponding bit.
> + *
> + * In essence, user can think of quasi-bidirectional IO as
> + * open-drain line, except presence of builtin rising edge acceleration
> + * embedded in PCF8574 IC
> + **/

#define PORTS_COUNT 8

> +
> +OBJECT_DECLARE_SIMPLE_TYPE(PCF8574State, PCF8574)
> +
> +struct PCF8574State {
> +    I2CSlave parent_obj;
> +    uint8_t  input;      /* external electrical line state */
> +    uint8_t  output;     /* Pull-up (1) or drive low (0) on bit */
> +    qemu_irq handler[8];

s/8/PORTS_COUNT/

> +    qemu_irq *gpio_in;

There is also a gpio_out, why not implement it?

> +};
> +
> +static void pcf8574_reset(DeviceState *dev)
> +{
> +    PCF8574State *s = PCF8574(dev);
> +    s->input  = 0xFF;
> +    s->output = 0xFF;

Alternatively MAKE_64BIT_MASK(0, PORTS_COUNT);

> +}
> +
> +static inline uint8_t pcf8574_line_state(PCF8574State *s)
> +{
> +    // we driving line low or external circuit does that

Comment as /* ... */, see
https://www.qemu.org/docs/master/devel/style.html#comment-style

> +    return s->input & s->output;
> +}
> +
> +static uint8_t pcf8574_rx(I2CSlave *i2c)
> +{
> +    return pcf8574_line_state(PCF8574(i2c));
> +}
> +
> +static int pcf8574_tx(I2CSlave *i2c, uint8_t data)
> +{
> +    PCF8574State *s = PCF8574(i2c);
> +    uint8_t prev;
> +    uint8_t diff;
> +    uint8_t actual;
> +    int line = 0;
> +
> +    prev = pcf8574_line_state(s);
> +    s->output = data;
> +    actual = pcf8574_line_state(s);
> +
> +    for (diff = (actual ^ prev); diff; diff &= ~(1 << line))

No enter before brace.

> +    {
> +        line = ctz32(diff);
> +        if (s->handler[line])

Missing brace, see
https://www.qemu.org/docs/master/devel/style.html#block-structure

Please run scripts/checkpatch.pl, see
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#use-the-qemu-coding-style

> +            qemu_set_irq(s->handler[line], (actual >> line) & 1);
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_pcf8574 = {
> +    .name = "pcf8574",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8(input,  PCF8574State),
> +        VMSTATE_UINT8(output, PCF8574State),
> +        VMSTATE_I2C_SLAVE(parent_obj, PCF8574State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void pcf8574_gpio_set(void *opaque, int line, int level)
> +{
> +    PCF8574State *s = (PCF8574State *) opaque;
> +    assert(line >= 0 && line < ARRAY_SIZE(s->handler));
> +
> +    if (level)
> +        s->input |=  (1 << line);
> +    else
> +        s->input &= ~(1 << line);
> +}
> +
> +static void pcf8574_realize(DeviceState *dev, Error **errp)
> +{
> +    PCF8574State *s = PCF8574(dev);
> +
> +    qdev_init_gpio_in(dev, pcf8574_gpio_set, ARRAY_SIZE(s->handler));
> +    qdev_init_gpio_out(dev, s->handler, ARRAY_SIZE(s->handler));
> +}
> +
> +static void pcf8574_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass   *dc = DEVICE_CLASS(klass);
> +    I2CSlaveClass *k  = I2C_SLAVE_CLASS(klass);
> +
> +    k->recv     = pcf8574_rx;
> +    k->send     = pcf8574_tx;
> +    dc->realize = pcf8574_realize;
> +    dc->reset   = pcf8574_reset;
> +    dc->vmsd    = &vmstate_pcf8574;
> +}
> +
> +static const TypeInfo pcf8574_info = {
> +    .name          = TYPE_PCF8574,
> +    .parent        = TYPE_I2C_SLAVE,
> +    .instance_size = sizeof(PCF8574State),
> +    .class_init    = pcf8574_class_init,
> +};
> +
> +static void pcf8574_register_types(void)
> +{
> +    type_register_static(&pcf8574_info);
> +}
> +
> +type_init(pcf8574_register_types)

Preferably DEFINE_TYPES()

> diff --git a/include/hw/gpio/pcf8574.h b/include/hw/gpio/pcf8574.h
> new file mode 100644
> index 0000000000..c690e73487
> --- /dev/null
> +++ b/include/hw/gpio/pcf8574.h
> @@ -0,0 +1,15 @@
> +/*
> + * NXP PCF8574 8-port I2C GPIO expansion chip.
> + *
> + * Copyright (c) 2024 KNS Group (YADRO).
> + * Written by Dmitrii Sharikhin <d.sharikhin@yadro.com>
> + *
> + * This file is licensed under GNU GPL.

Which GPL version? Preferably add an explicit SPDX tag.

> + */
> +
> +#ifndef _HW_GPIO_PCF8574
> +#define _HW_GPIO_PCF8574
> +
> +#define TYPE_PCF8574 "pcf8574"
> +
> +#endif /* _HW_GPIO_PCF8574 */

Overall LGTM, waiting for v2!

Regards,

Phil.

