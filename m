Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5C7C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 22:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tctwu-0005bd-Pt; Tue, 28 Jan 2025 17:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tctwt-0005bO-FY; Tue, 28 Jan 2025 17:20:47 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tctwm-0006fU-3o; Tue, 28 Jan 2025 17:20:46 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d41848901bso268792a12.0; 
 Tue, 28 Jan 2025 14:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738102837; x=1738707637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nOoNmuVDDkzIJNJlOimsggShsBz3musmQuvvUmq3FDo=;
 b=hQJIWwwolG2Pr6lyjI18Ep7+cY4s/WRGxrWNpWIcoVNMRfmQAkJjM5Ln34f1evxSzG
 GiGBWIn7577efV0qvz1t7hyr6FZ+SECl5eRC6b4aJTsFFS6tfnqgh+x6LxmvOOTh9Wu9
 gwsXjSll7laEKAb/1KMFxM8aeAPEfm+3F9iPjq0PX9S1InxwZyvL45atPFj879i98tBk
 PHSKohbKyZVZOLOI7XRljuQ0oXns53Q9Myy/XlFCnNkUMIgxIVYg2swkznRx3sMOk4q5
 PWpj3oTSvKBqr0FFe+thrQtXL+646IEk4eBNcm+6wduEQ9WPnC2M46zN/MgIkslIbxb1
 wKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738102837; x=1738707637;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nOoNmuVDDkzIJNJlOimsggShsBz3musmQuvvUmq3FDo=;
 b=KrM1FT10AfrYbx0pGaSJNNBYYUtQwFl4QvY448fXTvnUgjIFuoQplThWZ+QVNvEwjf
 PzRlq8FOxdl+y1KrXcGRP/Bejc7qCJYOSiBCbt3aPRPaGtbKMWGqMPaDD7sM2EVY6d8r
 jGGnX1RrIt0jQz5Y+5QdwcnQmNNSsEPeefq+cnmGLed/x7xvamreYqomnOLGyeCLIaHr
 2qwBT1fGJLkF3JykhsaQLBKkY/mW/izPnKGjwqMnSsXy9NJkXcMlGtACjLib8dH+5GTE
 4/MyTDz4X1jjImu3eJvoKk/tpCIIn7Q4XXsq9ZKNVX2CqxKcX6UossbTnM6qYKLXCga3
 m8gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+xZH/r/pP4x5QzHIjLBRUuy09VYVHYc81KfoSKsYjsfZFWEWSKSax+cIQlPcYOs8JR3LaXpIHbQ==@nongnu.org
X-Gm-Message-State: AOJu0YyvN1mCAeaQIwV+7n32xhjbkeYP7nHnkuZu0B2QLLEzCJlNCQoa
 UVMTPWUDc6y7D32/Ur9CgT9UkVyBQX+YoTv8unxkqpxBL4/qMZ57
X-Gm-Gg: ASbGncsNWo65kctr79q8QovdVuBDnto/zSpC+RH5guqoGvkAcG5sDwEP1lebfLrjMnb
 QAmyZwuWFb2/XNR7dncDk7vY22ckw8zXvaSG2mX+kuC5MfI5xwW8AWATSbjDNgxYGKMiO+cijK9
 xAeA90zJ9lSeAhbslnhABMUC1ikAwBm7Zb/pn5LCTJfWT6FNhW8Z3XzWw7Nh+8m3l/8SHWpaybb
 hlcaP9YH1tbX/LN/lllZPxD90U5Q0XGgjXbVBFwpKZky+f/bK/KeflrsisfA+vRuVzQTldvFuZl
 zB1Mbqoow3nj6LP+HM0JmoqtqR4QwKqBjqh9icv/BJZZyYLkRXzuHDDtY25tKFJe
X-Google-Smtp-Source: AGHT+IHn9ewcW6HNhDiybxMY91lFI0JLqdSldHLCVIRKxA9e3E2AEQgp0r1YwKr+V3uSPHsVFy8ViQ==
X-Received: by 2002:a05:6402:440d:b0:5db:7353:2b5c with SMTP id
 4fb4d7f45d1cf-5dc5e2751afmr992412a12.11.1738102837197; 
 Tue, 28 Jan 2025 14:20:37 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-012-042-254.89.12.pool.telefonica.de.
 [89.12.42.254]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc186d8a27sm7559375a12.73.2025.01.28.14.20.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 14:20:36 -0800 (PST)
Date: Tue, 28 Jan 2025 22:20:35 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 20/21] hw/i2c: Import TCA6416 emulation from Xilinx
In-Reply-To: <33ced970-1f59-7471-a5cb-4bd5236b87bb@eik.bme.hu>
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-21-shentey@gmail.com>
 <33ced970-1f59-7471-a5cb-4bd5236b87bb@eik.bme.hu>
Message-ID: <6C95ED63-9A9E-43B5-887F-31D6A858587D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 21=2E Januar 2025 03:07:39 UTC schrieb BALATON Zoltan <balaton@eik=2Ebm=
e=2Ehu>:
>On Mon, 20 Jan 2025, Bernhard Beschow wrote:
>> Xilinx QEMU implements a TCA6416 device model which may be useful for t=
he
>> broader QEMU community, so upstream it=2E In the Xilinx fork, the devic=
e model
>> gets compiled whenever CONFIG_CADENCE is true, so have it maintained by=
 the
>> "hw/*/cadence_*" maintainers=2E
>>=20
>> The code is based on Xilinx QEMU version xilinx_v2024=2E2 plus the foll=
owing
>> modifications:
>> * Use OBJECT_DECLARE_SIMPLE_TYPE()
>> * Port from DPRINTF() to trace events
>> * Follow QEMU conventions for naming of state struct
>> * Rename type to not contain a ','
>> * Use DEFINE_TYPES() macro
>> * Implement under hw/gpio since device is i2c client and gpio provider
>> * Have dedicated Kconfig switch
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>=20
>> --
>> I have a use for TCA6416 emulation=2E Question: Are Xilinx Zynq maintai=
ners
>> willing to maintain this device model?
>> ---
>> MAINTAINERS          |   1 +
>> hw/gpio/tca6416=2Ec    | 122 ++++++++++++++++++++++++++++++++++++++++++=
+
>> hw/gpio/Kconfig      |   5 ++
>> hw/gpio/meson=2Ebuild  |   1 +
>> hw/gpio/trace-events |   4 ++
>> 5 files changed, 133 insertions(+)
>> create mode 100644 hw/gpio/tca6416=2Ec
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7531d65429=2E=2E0cac9c90bc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1030,6 +1030,7 @@ S: Maintained
>> F: hw/*/xilinx_*
>> F: hw/*/cadence_*
>> F: hw/misc/zynq_slcr=2Ec
>> +F: hw/gpio/tca6416=2Ec
>> F: hw/adc/zynq-xadc=2Ec
>> F: include/hw/misc/zynq_slcr=2Eh
>> F: include/hw/adc/zynq-xadc=2Eh
>> diff --git a/hw/gpio/tca6416=2Ec b/hw/gpio/tca6416=2Ec
>> new file mode 100644
>> index 0000000000=2E=2E81ed7a654d
>> --- /dev/null
>> +++ b/hw/gpio/tca6416=2Ec
>> @@ -0,0 +1,122 @@
>> +/*
>> + * QEMU model of TCA6416 16-Bit I/O Expander
>> + *
>> + * Copyright (c) 2018 Xilinx Inc=2E
>> + *
>> + * Written by Sai Pavan Boddu <sai=2Epavan=2Eboddu@xilinx=2Ecom>
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
>> + * of this software and associated documentation files (the "Software"=
), to deal
>> + * in the Software without restriction, including without limitation t=
he rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
>> + * copies of the Software, and to permit persons to whom the Software =
is
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be incl=
uded in
>> + * all copies or substantial portions of the Software=2E
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT=
 SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
>> + * THE SOFTWARE=2E
>> + */
>> +#include "qemu/osdep=2Eh"
>> +#include "hw/i2c/i2c=2Eh"
>> +#include "trace=2Eh"
>> +
>> +#define TYPE_TCA6416 "tca6416"
>> +OBJECT_DECLARE_SIMPLE_TYPE(Tca6416State, TCA6416)
>> +
>> +#define IN_PORT0    0
>> +#define IN_PORT1    1
>> +#define OUT_PORT0   2
>> +#define OUT_PORT1   3
>> +#define POL_INV0    4
>> +#define POL_INV1    5
>> +#define CONF_PORT0  6
>> +#define CONF_PORT1  7
>> +#define RMAX (CONF_PORT1 + 1)
>
>Maybe make this list an enum? (But also fine as it is=2E)

Good idea indeed=2E I'd address this once maintainership is clarified=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> +
>> +enum tca6416_events {
>> +     ADDR_DONE,
>> +     ADDRESSING,
>> +};
>> +
>> +struct Tca6416State {
>> +     I2CSlave i2c;
>> +
>> +     uint8_t addr;
>> +     uint8_t state;
>> +     uint8_t regs[RMAX];
>> +};
>> +
>> +static uint8_t tca6416_read(I2CSlave *i2c)
>> +{
>> +    Tca6416State *s =3D TCA6416(i2c);
>> +    uint8_t ret;
>> +
>> +    ret =3D s->regs[s->addr];
>> +    trace_tca6416_read(ret);
>> +    return ret;
>> +}
>> +
>> +static int tca6416_write(I2CSlave *i2c, uint8_t data)
>> +{
>> +    Tca6416State *s =3D TCA6416(i2c);
>> +
>> +    trace_tca6416_write(data);
>> +    if (s->state =3D=3D ADDRESSING) {
>> +        s->addr =3D data;
>> +    } else {
>> +        s->regs[s->addr] =3D data;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void tca6416_realize(DeviceState *dev, Error **errp)
>> +{
>> +    Tca6416State *s =3D TCA6416(dev);
>> +
>> +    s->regs[CONF_PORT0] =3D 0xFF;
>> +    s->regs[CONF_PORT1] =3D 0xFF;
>> +}
>> +
>> +static int tca6416_event(I2CSlave *i2c, enum i2c_event event)
>> +{
>> +    Tca6416State *s =3D TCA6416(i2c);
>> +
>> +    switch (event) {
>> +    case I2C_START_SEND:
>> +        s->state =3D ADDRESSING;
>> +        break;
>> +    default:
>> +         s->state =3D ADDR_DONE;
>> +    };
>> +    return 0;
>> +}
>> +
>> +static void tca6416_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
>> +
>> +    dc->realize =3D tca6416_realize;
>> +    k->recv =3D tca6416_read;
>> +    k->send =3D tca6416_write;
>> +    k->event =3D tca6416_event;
>> +}
>> +
>> +static const TypeInfo tca6416_types[] =3D {
>> +    {
>> +        =2Ename =3D TYPE_TCA6416,
>> +        =2Eparent =3D TYPE_I2C_SLAVE,
>> +        =2Eclass_init =3D tca6416_class_init,
>> +        =2Einstance_size =3D sizeof(Tca6416State),
>> +    }
>> +};
>> +
>> +DEFINE_TYPES(tca6416_types)
>> diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
>> index c423e10f59=2E=2Ea240cf2de2 100644
>> --- a/hw/gpio/Kconfig
>> +++ b/hw/gpio/Kconfig
>> @@ -20,5 +20,10 @@ config PCF8574
>>     bool
>>     depends on I2C
>>=20
>> +config TCA6416
>> +    bool
>> +    depends on I2C
>> +    default y if I2C_DEVICES
>> +
>> config ZAURUS_SCOOP
>>     bool
>> diff --git a/hw/gpio/meson=2Ebuild b/hw/gpio/meson=2Ebuild
>> index 74840619c0=2E=2Eb3ff7c7460 100644
>> --- a/hw/gpio/meson=2Ebuild
>> +++ b/hw/gpio/meson=2Ebuild
>> @@ -18,3 +18,4 @@ system_ss=2Eadd(when: 'CONFIG_STM32L4X5_SOC', if_true=
: files('stm32l4x5_gpio=2Ec'))
>> system_ss=2Eadd(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio=
=2Ec'))
>> system_ss=2Eadd(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio=
=2Ec'))
>> system_ss=2Eadd(when: 'CONFIG_PCF8574', if_true: files('pcf8574=2Ec'))
>> +system_ss=2Eadd(when: 'CONFIG_TCA6416', if_true: files('tca6416=2Ec'))
>> diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
>> index cea896b28f=2E=2E6724f2efb8 100644
>> --- a/hw/gpio/trace-events
>> +++ b/hw/gpio/trace-events
>> @@ -46,3 +46,7 @@ stm32l4x5_gpio_read(char *gpio, uint64_t addr) "GPIO%=
s addr: 0x%" PRIx64 " "
>> stm32l4x5_gpio_write(char *gpio, uint64_t addr, uint64_t data) "GPIO%s =
addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
>> stm32l4x5_gpio_update_idr(char *gpio, uint32_t old_idr, uint32_t new_id=
r) "GPIO%s from: 0x%x to: 0x%x"
>> stm32l4x5_gpio_pins(char *gpio, uint16_t disconnected, uint16_t high) "=
GPIO%s disconnected pins: 0x%x levels: 0x%x"
>> +
>> +# tca6416=2Ec
>> +tca6416_write(uint8_t value) "0x%02x"
>> +tca6416_read(uint8_t value) "0x%02x"
>>=20

