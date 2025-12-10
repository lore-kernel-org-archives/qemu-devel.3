Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB44D2CE17
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 08:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTFAL-0001Zh-Tb; Wed, 10 Dec 2025 03:03:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yubinz@google.com>) id 1vTFAI-0001Yb-Kf
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 03:03:15 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yubinz@google.com>) id 1vTFAF-00037X-SR
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 03:03:14 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-597ceef6eebso5902e87.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 00:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765353789; x=1765958589; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VAmKlxihzHLsFfGPVpUZqswaNV69W3Jo+1QnOvCZWeA=;
 b=11f35CbDa6qgBlIS804plSM8pQqQqYPc2Pr7I+VffoDuPD7ZxyGucum6KvwUqKCand
 hUpr78lDu6/vBEgwux3Vac7p4APyu0vp+s2BVNB1gjMS6+8gOeqpcedliMFjcDy5lHAn
 /DOZIxKHxZjUVOGyW54yJ8l6OQQ+1ED8fHv4FiGEltI/IOMhAnrprtc4fNTxv4+TcrG9
 6fGwRdHZk+Y3m6TXUh7lm15HalGfOx5j+6+mhxqTFvjtydM3qInzcb9jmKhGMnPUTB4Q
 ygUh6eTDkwonQFFk65Kutn+a94oyHEKy+jHFdwFw8hgHQutUOTxdAGWi05AsdNBVh8uc
 a0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765353789; x=1765958589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAmKlxihzHLsFfGPVpUZqswaNV69W3Jo+1QnOvCZWeA=;
 b=CRE/AXV7jQ/uABU33w+DlNBIxNlA9R+k7SoSmLt1/XJBjRWrqLvvhb+QECejQPhRQ4
 9HYiioXsef5i7ffyhuds/83nDBd05q3q2wkvruB9Equrb/w4WEvLOAip6Ro2UW2qn1kH
 4tUirqHTKrjR20yBKE045KxaX4QXaD8uf+Y0HwA89yQ7zt0EKwBroIvZZoyyDHluBKFE
 iw5cJ9U1CbLYDbujg8CfDtdnU+kg3du2jBPkRWjK+tnZ0Y9FQbGpwCbpGODsJILzPMUw
 FJpQTVXeVC5GSd2UmviYYD5kROym6p/P1934qtJsu/ebvt6wCevlv1SZzbo0nfrnL8bP
 NKkw==
X-Gm-Message-State: AOJu0YyCAMRABxNs6wowPbDjcIy5jSQQV1Jh4QjBNxch+BGo4Nqi3wJC
 7Ost76VhVHRF95G7r2b+VTUw9zwMHWeubX2ylFpt7vKcG1UQ96QGI5qzQNRgu4D1zdm0xJH45Rk
 6LZa8/2lrE0v86AVsw938RKXbxa2n5nCRzhNwk9nf
X-Gm-Gg: AY/fxX7i4G9Vg4BjUbWeiM4/xbXZ5IgyzH5Y32SBQALoW4CPGXdd53r+8p74KUz7JGj
 SyfHWqqql2ERqJVbRftcqGbv40bUFSr0AgTIJ05OZ/cOa0l5ZUqUY38vn4Eb1Hhkyo5dzDybq7I
 AvijalmfYoQAIobikZFSDXNSssN6+Bf8cYq+kGAyd7AdmKrQkMDKcupIy5DCGV3xssYnFnTuBQL
 liJropmfXzPjB3PH1bP1rwLBk6KVAKKy50MSUr6N0KVjv2FpB7LnkXrc/QDUdbB0X4PM3XMfq/e
 AL7MfbN/BFNMB6kOEauZOHzaTnqC+4gbxlQ6ABk=
X-Google-Smtp-Source: AGHT+IFaA40iSgOlO3qNiAnLkNh1WrztKIAIJ8E1ec8WsmWfMTmnyKSpMkM1GpE97q6qBE71jOUBlnFwqmsNjhT9H+k=
X-Received: by 2002:a05:6512:131e:b0:595:8927:8a35 with SMTP id
 2adb3069b0e04-598eef7730fmr62948e87.15.1765353788662; Wed, 10 Dec 2025
 00:03:08 -0800 (PST)
MIME-Version: 1.0
References: <20251209-aspeed-sgpio-v2-0-976e5f5790c2@google.com>
 <20251209-aspeed-sgpio-v2-1-976e5f5790c2@google.com>
 <d5fcfc09-fe80-498d-8df6-1d1dc9d15a57@kaod.org>
In-Reply-To: <d5fcfc09-fe80-498d-8df6-1d1dc9d15a57@kaod.org>
From: Yubin Zou <yubinz@google.com>
Date: Wed, 10 Dec 2025 00:02:56 -0800
X-Gm-Features: AQt7F2rvWhJbdTVhq3Cll6d6Vd81NmD_tHjHWx9HgL23GmsXEEHAMPgrhE7wfZI
Message-ID: <CABU_6BKfwx7aL3XRcTcMGcuxHw+S7dqdG9OUp3pPT9s7_EAugg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] hw/gpio/aspeed_sgpio: Add basic device model for
 Aspeed SGPIO
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>, 
 Nabih Estefan <nabihestefan@google.com>, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000007a8db206459475dd"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=yubinz@google.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--0000000000007a8db206459475dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi C=C3=A9dric

The Aspeed SGPIO has two versions, one is associated with AST2700 and an
older version before and includes AST2600.
I don't have an impending plan to implement the older version, but the
class structure is for future extensibility.

Thanks
Yubin



On Tue, Dec 9, 2025 at 1:22=E2=80=AFAM C=C3=A9dric Le Goater <clg@kaod.org>=
 wrote:

> On 12/9/25 01:01, Yubin Zou wrote:
> > This initial implementation includes the basic device structure,
> > memory-mapped register definitions, and read/write handlers for the
> > SGPIO control registers.
> >
> > Signed-off-by: Yubin Zou <yubinz@google.com>
> > ---
> >   hw/gpio/aspeed_sgpio.c         | 154
> +++++++++++++++++++++++++++++++++++++++++
> >   hw/gpio/meson.build            |   1 +
> >   include/hw/gpio/aspeed_sgpio.h |  66 ++++++++++++++++++
> >   3 files changed, 221 insertions(+)
>
> Please add to your .git/config :
>
>    [diff]
>      orderFile =3D /path/to/qemu/scripts/git.orderfile
>
> It is easier to review if the changes in header files are first.
>
>
> > diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c
> > new file mode 100644
> > index
> 0000000000000000000000000000000000000000..8676fa7ced134f1f62dc9e30b42c5fe=
6db3de268
> > --- /dev/null
> > +++ b/hw/gpio/aspeed_sgpio.c
> > @@ -0,0 +1,154 @@
> > +/*
> > + * ASPEED Serial GPIO Controller
> > + *
> > + * Copyright 2025 Google LLC.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/host-utils.h"
> > +#include "qemu/log.h"
> > +#include "qemu/error-report.h"
> > +#include "qapi/error.h"
> > +#include "qapi/visitor.h"
> > +#include "hw/qdev-properties.h"
> > +#include "hw/gpio/aspeed_sgpio.h"
> > +
> > +static uint64_t aspeed_sgpio_2700_read_int_status_reg(AspeedSGPIOState
> *s,
> > +                                uint32_t reg)
> > +{
> > +    return 0;
> > +}
> > +
> > +static uint64_t aspeed_sgpio_2700_read_control_reg(AspeedSGPIOState *s=
,
> > +                                uint32_t reg)
> > +{
> > +    AspeedSGPIOClass *agc =3D ASPEED_SGPIO_GET_CLASS(s);
> > +    uint32_t idx =3D reg - R_SGPIO_0_CONTROL;
> > +    if (idx >=3D agc->nr_sgpio_pin_pairs) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: pin index: %d, out of
> bounds\n",
> > +                      __func__, idx);
> > +        return 0;
> > +    }
> > +    return s->ctrl_regs[idx];
> > +}
> > +
> > +static void aspeed_sgpio_2700_write_control_reg(AspeedSGPIOState *s,
> > +                                uint32_t reg, uint64_t data)
> > +{
> > +    AspeedSGPIOClass *agc =3D ASPEED_SGPIO_GET_CLASS(s);
> > +    uint32_t idx =3D reg - R_SGPIO_0_CONTROL;
> > +    if (idx >=3D agc->nr_sgpio_pin_pairs) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: pin index: %d, out of
> bounds\n",
> > +                      __func__, idx);
> > +        return;
> > +    }
> > +    s->ctrl_regs[idx] =3D data;
> > +}
> > +
> > +static uint64_t aspeed_sgpio_2700_read(void *opaque, hwaddr offset,
> > +                                uint32_t size)
> > +{
> > +    AspeedSGPIOState *s =3D ASPEED_SGPIO(opaque);
> > +    uint64_t value =3D 0;
> > +    uint64_t reg;
> > +
> > +    reg =3D offset >> 2;
> > +
> > +    switch (reg) {
> > +    case R_SGPIO_INT_STATUS_0 ... R_SGPIO_INT_STATUS_7:
> > +        aspeed_sgpio_2700_read_int_status_reg(s, reg);
> > +        break;
> > +    case R_SGPIO_0_CONTROL ... R_SGPIO_255_CONTROL:
> > +        value =3D aspeed_sgpio_2700_read_control_reg(s, reg);
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: no getter for offset 0x%"
> > +                      PRIx64"\n", __func__, offset);
> > +        return 0;
> > +    }
> > +
> > +    return value;
> > +}
> > +
> > +static void aspeed_sgpio_2700_write(void *opaque, hwaddr offset,
> uint64_t data,
> > +                                uint32_t size)
> > +{
> > +    AspeedSGPIOState *s =3D ASPEED_SGPIO(opaque);
> > +    uint64_t reg;
> > +
> > +    reg =3D offset >> 2;
> > +
> > +    switch (reg) {
> > +    case R_SGPIO_0_CONTROL ... R_SGPIO_255_CONTROL:
> > +        aspeed_sgpio_2700_write_control_reg(s, reg, data);
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: no setter for offset 0x%"
> > +                      PRIx64"\n", __func__, offset);
> > +        return;
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps aspeed_gpio_2700_ops =3D {
> > +  .read       =3D aspeed_sgpio_2700_read,
> > +  .write      =3D aspeed_sgpio_2700_write,
> > +  .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +  .valid.min_access_size =3D 4,
> > +  .valid.max_access_size =3D 4,
> > +};
> > +
> > +static void aspeed_sgpio_realize(DeviceState *dev, Error **errp)
> > +{
> > +    AspeedSGPIOState *s =3D ASPEED_SGPIO(dev);
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> > +    AspeedSGPIOClass *agc =3D ASPEED_SGPIO_GET_CLASS(s);
> > +
> > +    /* Interrupt parent line */
> > +    sysbus_init_irq(sbd, &s->irq);
> > +
> > +    memory_region_init_io(&s->iomem, OBJECT(s), agc->reg_ops, s,
> > +                          TYPE_ASPEED_SGPIO, agc->mem_size);
> > +
> > +    sysbus_init_mmio(sbd, &s->iomem);
> > +}
> > +
> > +static void aspeed_sgpio_class_init(ObjectClass *klass, const void
> *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->realize =3D aspeed_sgpio_realize;
> > +    dc->desc =3D "Aspeed SGPIO Controller";
> > +}
> > +
> > +static void aspeed_sgpio_2700_class_init(ObjectClass *klass, const voi=
d
> *data)
> > +{
> > +    AspeedSGPIOClass *agc =3D ASPEED_SGPIO_CLASS(klass);
> > +    agc->nr_sgpio_pin_pairs =3D 256;
> > +    agc->mem_size =3D 0x1000;
> > +    agc->reg_ops =3D &aspeed_gpio_2700_ops;
> > +}
> > +
> > +static const TypeInfo aspeed_sgpio_info =3D {
> > +    .name           =3D TYPE_ASPEED_SGPIO,
> > +    .parent         =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size  =3D sizeof(AspeedSGPIOState),
> > +    .class_size     =3D sizeof(AspeedSGPIOClass),
> > +    .class_init     =3D aspeed_sgpio_class_init,
> > +    .abstract       =3D true,
> > +};
> > +
> > +static const TypeInfo aspeed_sgpio_ast2700_info =3D {
> > +  .name           =3D TYPE_ASPEED_SGPIO "-ast2700",
> > +  .parent         =3D TYPE_ASPEED_SGPIO,
> > +  .class_init     =3D aspeed_sgpio_2700_class_init,
> > +};
> > +
> > +static void aspeed_sgpio_register_types(void)
> > +{
> > +    type_register_static(&aspeed_sgpio_info);
> > +    type_register_static(&aspeed_sgpio_ast2700_info);
> > +}
> > +
> > +type_init(aspeed_sgpio_register_types);
> > diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
> > index
> 74840619c01bf4d9a02c058c434c3ec9d2a55bee..6a67ee958faace69ffd3fe08e8ade31=
ced0faf7e
> 100644
> > --- a/hw/gpio/meson.build
> > +++ b/hw/gpio/meson.build
> > @@ -16,5 +16,6 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
> >   ))
> >   system_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true:
> files('stm32l4x5_gpio.c'))
> >   system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true:
> files('aspeed_gpio.c'))
> > +system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true:
> files('aspeed_sgpio.c'))
> >   system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true:
> files('sifive_gpio.c'))
> >   system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
> > diff --git a/include/hw/gpio/aspeed_sgpio.h
> b/include/hw/gpio/aspeed_sgpio.h
> > new file mode 100644
> > index
> 0000000000000000000000000000000000000000..ffdc54a112da8962a7bc5773d524f1d=
86eb85d39
> > --- /dev/null
> > +++ b/include/hw/gpio/aspeed_sgpio.h
> > @@ -0,0 +1,66 @@
> > +/*
> > + * ASPEED Serial GPIO Controller
> > + *
> > + * Copyright 2025 Google LLC.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +#ifndef ASPEED_SGPIO_H
> > +#define ASPEED_SGPIO_H
> > +
> > +#include "hw/sysbus.h"
> > +#include "qom/object.h"
> > +#include "hw/registerfields.h"
> > +
> > +#define TYPE_ASPEED_SGPIO "aspeed.sgpio"
> > +OBJECT_DECLARE_TYPE(AspeedSGPIOState, AspeedSGPIOClass, ASPEED_SGPIO)
> > +
> > +#define ASPEED_SGPIO_MAX_PIN_PAIR 256
> > +#define ASPEED_SGPIO_MAX_INT 8
> > +
> > +/* AST2700 SGPIO Register Address Offsets */
> > +REG32(SGPIO_INT_STATUS_0, 0x40)
> > +REG32(SGPIO_INT_STATUS_1, 0x44)
> > +REG32(SGPIO_INT_STATUS_2, 0x48)
> > +REG32(SGPIO_INT_STATUS_3, 0x4C)
> > +REG32(SGPIO_INT_STATUS_4, 0x50)
> > +REG32(SGPIO_INT_STATUS_5, 0x54)
> > +REG32(SGPIO_INT_STATUS_6, 0x58)
> > +REG32(SGPIO_INT_STATUS_7, 0x5C)
> > +/* AST2700 SGPIO_0 - SGPIO_255 Control Register */
> > +REG32(SGPIO_0_CONTROL, 0x80)
> > +    SHARED_FIELD(SGPIO_SERIAL_OUT_VAL, 0, 1)
> > +    SHARED_FIELD(SGPIO_PARALLEL_OUT_VAL, 1, 1)
> > +    SHARED_FIELD(SGPIO_INT_EN, 2, 1)
> > +    SHARED_FIELD(SGPIO_INT_TYPE, 3, 3)
> > +    SHARED_FIELD(SGPIO_RESET_POLARITY, 6, 1)
> > +    SHARED_FIELD(SGPIO_RESERVED_1, 7, 2)
> > +    SHARED_FIELD(SGPIO_INPUT_MASK, 9, 1)
> > +    SHARED_FIELD(SGPIO_PARALLEL_EN, 10, 1)
> > +    SHARED_FIELD(SGPIO_PARALLEL_IN_MODE, 11, 1)
> > +    SHARED_FIELD(SGPIO_INT_STATUS, 12, 1)
> > +    SHARED_FIELD(SGPIO_SERIAL_IN_VAL, 13, 1)
> > +    SHARED_FIELD(SGPIO_PARALLEL_IN_VAL, 14, 1)
> > +    SHARED_FIELD(SGPIO_RESERVED_2, 15, 12)
> > +    SHARED_FIELD(SGPIO_WRITE_PROTECT, 31, 1)
> > +REG32(SGPIO_255_CONTROL, 0x47C)
> > +
> > +struct AspeedSGPIOClass {
> > +    SysBusDevice parent_obj;
> > +    uint32_t nr_sgpio_pin_pairs;
> > +    uint64_t mem_size;
> > +    const MemoryRegionOps *reg_ops;
> > +};
>
>
> I don't see any need of an AspeedSGPIOClass for now. Do you have plans
> for future models ?
>
> Thanks,
>
> C.
>
>
> > +
> > +struct AspeedSGPIOState {
> > +  /* <private> */
> > +  SysBusDevice parent;
> > +
> > +  /*< public >*/
> > +  MemoryRegion iomem;
> > +  qemu_irq irq;
> > +  uint32_t ctrl_regs[ASPEED_SGPIO_MAX_PIN_PAIR];
> > +  uint32_t int_regs[ASPEED_SGPIO_MAX_INT];
> > +};
> > +
> > +#endif /* ASPEED_SGPIO_H */
> >
>
>

--0000000000007a8db206459475dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi C=C3=A9dric<div><br></div><div>The Aspeed SGPIO has two=
 versions, one is=C2=A0<span style=3D"color:rgb(32,33,36);font-family:&quot=
;Google Sans&quot;,Roboto;letter-spacing:0.2px">associated with AST2700 and=
 an older version before and includes AST2600.</span></div><div>I don&#39;t=
 have an impending plan to implement the older version, but the class struc=
ture is for future extensibility.</div><div><br></div><div>Thanks</div><div=
>Yubin</div><div><br></div><div><br></div></div><br><div class=3D"gmail_quo=
te gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec=
 9, 2025 at 1:22=E2=80=AFAM C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg=
@kaod.org">clg@kaod.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On 12/9/25 01:01, Yubin Zou wrote:<br>
&gt; This initial implementation includes the basic device structure,<br>
&gt; memory-mapped register definitions, and read/write handlers for the<br=
>
&gt; SGPIO control registers.<br>
&gt; <br>
&gt; Signed-off-by: Yubin Zou &lt;<a href=3D"mailto:yubinz@google.com" targ=
et=3D"_blank">yubinz@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/gpio/aspeed_sgpio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
154 +++++++++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/gpio/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0include/hw/gpio/aspeed_sgpio.h |=C2=A0 66 ++++++++++++++++=
++<br>
&gt;=C2=A0 =C2=A03 files changed, 221 insertions(+)<br>
<br>
Please add to your .git/config :<br>
<br>
=C2=A0 =C2=A0[diff]<br>
=C2=A0 =C2=A0 =C2=A0orderFile =3D /path/to/qemu/scripts/git.orderfile<br>
<br>
It is easier to review if the changes in header files are first.<br>
<br>
<br>
&gt; diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000000000000000000000000000000000..8676fa7ced134f1f62dc9e=
30b42c5fe6db3de268<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/gpio/aspeed_sgpio.c<br>
&gt; @@ -0,0 +1,154 @@<br>
&gt; +/*<br>
&gt; + * ASPEED Serial GPIO Controller<br>
&gt; + *<br>
&gt; + * Copyright 2025 Google LLC.<br>
&gt; + *<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qemu/host-utils.h&quot;<br>
&gt; +#include &quot;qemu/log.h&quot;<br>
&gt; +#include &quot;qemu/error-report.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;qapi/visitor.h&quot;<br>
&gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt; +#include &quot;hw/gpio/aspeed_sgpio.h&quot;<br>
&gt; +<br>
&gt; +static uint64_t aspeed_sgpio_2700_read_int_status_reg(AspeedSGPIOStat=
e *s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t reg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint64_t aspeed_sgpio_2700_read_control_reg(AspeedSGPIOState *=
s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t reg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AspeedSGPIOClass *agc =3D ASPEED_SGPIO_GET_CLASS(s);<br=
>
&gt; +=C2=A0 =C2=A0 uint32_t idx =3D reg - R_SGPIO_0_CONTROL;<br>
&gt; +=C2=A0 =C2=A0 if (idx &gt;=3D agc-&gt;nr_sgpio_pin_pairs) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
pin index: %d, out of bounds\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__, idx);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return s-&gt;ctrl_regs[idx];<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void aspeed_sgpio_2700_write_control_reg(AspeedSGPIOState *s,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t reg, uint64_t data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AspeedSGPIOClass *agc =3D ASPEED_SGPIO_GET_CLASS(s);<br=
>
&gt; +=C2=A0 =C2=A0 uint32_t idx =3D reg - R_SGPIO_0_CONTROL;<br>
&gt; +=C2=A0 =C2=A0 if (idx &gt;=3D agc-&gt;nr_sgpio_pin_pairs) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
pin index: %d, out of bounds\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__, idx);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 s-&gt;ctrl_regs[idx] =3D data;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint64_t aspeed_sgpio_2700_read(void *opaque, hwaddr offset,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AspeedSGPIOState *s =3D ASPEED_SGPIO(opaque);<br>
&gt; +=C2=A0 =C2=A0 uint64_t value =3D 0;<br>
&gt; +=C2=A0 =C2=A0 uint64_t reg;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 reg =3D offset &gt;&gt; 2;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (reg) {<br>
&gt; +=C2=A0 =C2=A0 case R_SGPIO_INT_STATUS_0 ... R_SGPIO_INT_STATUS_7:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aspeed_sgpio_2700_read_int_status_reg(s, =
reg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case R_SGPIO_0_CONTROL ... R_SGPIO_255_CONTROL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D aspeed_sgpio_2700_read_control_=
reg(s, reg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
no getter for offset 0x%&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 PRIx64&quot;\n&quot;, __func__, offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return value;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void aspeed_sgpio_2700_write(void *opaque, hwaddr offset, uint=
64_t data,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AspeedSGPIOState *s =3D ASPEED_SGPIO(opaque);<br>
&gt; +=C2=A0 =C2=A0 uint64_t reg;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 reg =3D offset &gt;&gt; 2;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (reg) {<br>
&gt; +=C2=A0 =C2=A0 case R_SGPIO_0_CONTROL ... R_SGPIO_255_CONTROL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aspeed_sgpio_2700_write_control_reg(s, re=
g, data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
no setter for offset 0x%&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 PRIx64&quot;\n&quot;, __func__, offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps aspeed_gpio_2700_ops =3D {<br>
&gt; +=C2=A0 .read=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D aspeed_sgpio_2700_read,<br=
>
&gt; +=C2=A0 .write=C2=A0 =C2=A0 =C2=A0 =3D aspeed_sgpio_2700_write,<br>
&gt; +=C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,<br>
&gt; +=C2=A0 .valid.min_access_size =3D 4,<br>
&gt; +=C2=A0 .valid.max_access_size =3D 4,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void aspeed_sgpio_realize(DeviceState *dev, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AspeedSGPIOState *s =3D ASPEED_SGPIO(dev);<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);<br>
&gt; +=C2=A0 =C2=A0 AspeedSGPIOClass *agc =3D ASPEED_SGPIO_GET_CLASS(s);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Interrupt parent line */<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_irq(sbd, &amp;s-&gt;irq);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem, OBJECT(s), agc-=
&gt;reg_ops, s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_ASPEED_SGPIO, agc-&gt;mem_size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_mmio(sbd, &amp;s-&gt;iomem);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void aspeed_sgpio_class_init(ObjectClass *klass, const void *d=
ata)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D aspeed_sgpio_realize;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;desc =3D &quot;Aspeed SGPIO Controller&quot;;<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +static void aspeed_sgpio_2700_class_init(ObjectClass *klass, const vo=
id *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AspeedSGPIOClass *agc =3D ASPEED_SGPIO_CLASS(klass);<br=
>
&gt; +=C2=A0 =C2=A0 agc-&gt;nr_sgpio_pin_pairs =3D 256;<br>
&gt; +=C2=A0 =C2=A0 agc-&gt;mem_size =3D 0x1000;<br>
&gt; +=C2=A0 =C2=A0 agc-&gt;reg_ops =3D &amp;aspeed_gpio_2700_ops;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo aspeed_sgpio_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D TYPE_=
ASPEED_SGPIO,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D TYPE_SYS_B=
US_DEVICE,<br>
&gt; +=C2=A0 =C2=A0 .instance_size=C2=A0 =3D sizeof(AspeedSGPIOState),<br>
&gt; +=C2=A0 =C2=A0 .class_size=C2=A0 =C2=A0 =C2=A0=3D sizeof(AspeedSGPIOCl=
ass),<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =C2=A0=3D aspeed_sgpio_class_i=
nit,<br>
&gt; +=C2=A0 =C2=A0 .abstract=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D true,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const TypeInfo aspeed_sgpio_ast2700_info =3D {<br>
&gt; +=C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D TYPE_ASPEED_=
SGPIO &quot;-ast2700&quot;,<br>
&gt; +=C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D TYPE_ASPEED_SGPIO=
,<br>
&gt; +=C2=A0 .class_init=C2=A0 =C2=A0 =C2=A0=3D aspeed_sgpio_2700_class_ini=
t,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void aspeed_sgpio_register_types(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;aspeed_sgpio_info);<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;aspeed_sgpio_ast2700_info);<b=
r>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(aspeed_sgpio_register_types);<br>
&gt; diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build<br>
&gt; index 74840619c01bf4d9a02c058c434c3ec9d2a55bee..6a67ee958faace69ffd3fe=
08e8ade31ced0faf7e 100644<br>
&gt; --- a/hw/gpio/meson.build<br>
&gt; +++ b/hw/gpio/meson.build<br>
&gt; @@ -16,5 +16,6 @@ system_ss.add(when: &#39;CONFIG_RASPI&#39;, if_true:=
 files(<br>
&gt;=C2=A0 =C2=A0))<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_STM32L4X5_SOC&#39;, if_tru=
e: files(&#39;stm32l4x5_gpio.c&#39;))<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_ASPEED_SOC&#39;, if_true: =
files(&#39;aspeed_gpio.c&#39;))<br>
&gt; +system_ss.add(when: &#39;CONFIG_ASPEED_SOC&#39;, if_true: files(&#39;=
aspeed_sgpio.c&#39;))<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_SIFIVE_GPIO&#39;, if_true:=
 files(&#39;sifive_gpio.c&#39;))<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_PCF8574&#39;, if_true: fil=
es(&#39;pcf8574.c&#39;))<br>
&gt; diff --git a/include/hw/gpio/aspeed_sgpio.h b/include/hw/gpio/aspeed_s=
gpio.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000000000000000000000000000000000..ffdc54a112da8962a7bc57=
73d524f1d86eb85d39<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/gpio/aspeed_sgpio.h<br>
&gt; @@ -0,0 +1,66 @@<br>
&gt; +/*<br>
&gt; + * ASPEED Serial GPIO Controller<br>
&gt; + *<br>
&gt; + * Copyright 2025 Google LLC.<br>
&gt; + *<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; + */<br>
&gt; +#ifndef ASPEED_SGPIO_H<br>
&gt; +#define ASPEED_SGPIO_H<br>
&gt; +<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt; +#include &quot;hw/registerfields.h&quot;<br>
&gt; +<br>
&gt; +#define TYPE_ASPEED_SGPIO &quot;aspeed.sgpio&quot;<br>
&gt; +OBJECT_DECLARE_TYPE(AspeedSGPIOState, AspeedSGPIOClass, ASPEED_SGPIO)=
<br>
&gt; +<br>
&gt; +#define ASPEED_SGPIO_MAX_PIN_PAIR 256<br>
&gt; +#define ASPEED_SGPIO_MAX_INT 8<br>
&gt; +<br>
&gt; +/* AST2700 SGPIO Register Address Offsets */<br>
&gt; +REG32(SGPIO_INT_STATUS_0, 0x40)<br>
&gt; +REG32(SGPIO_INT_STATUS_1, 0x44)<br>
&gt; +REG32(SGPIO_INT_STATUS_2, 0x48)<br>
&gt; +REG32(SGPIO_INT_STATUS_3, 0x4C)<br>
&gt; +REG32(SGPIO_INT_STATUS_4, 0x50)<br>
&gt; +REG32(SGPIO_INT_STATUS_5, 0x54)<br>
&gt; +REG32(SGPIO_INT_STATUS_6, 0x58)<br>
&gt; +REG32(SGPIO_INT_STATUS_7, 0x5C)<br>
&gt; +/* AST2700 SGPIO_0 - SGPIO_255 Control Register */<br>
&gt; +REG32(SGPIO_0_CONTROL, 0x80)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(SGPIO_SERIAL_OUT_VAL, 0, 1)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(SGPIO_PARALLEL_OUT_VAL, 1, 1)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(SGPIO_INT_EN, 2, 1)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(SGPIO_INT_TYPE, 3, 3)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(SGPIO_RESET_POLARITY, 6, 1)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(SGPIO_RESERVED_1, 7, 2)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(SGPIO_INPUT_MASK, 9, 1)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(SGPIO_PARALLEL_EN, 10, 1)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(SGPIO_PARALLEL_IN_MODE, 11, 1)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(SGPIO_INT_STATUS, 12, 1)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(SGPIO_SERIAL_IN_VAL, 13, 1)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(SGPIO_PARALLEL_IN_VAL, 14, 1)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(SGPIO_RESERVED_2, 15, 12)<br>
&gt; +=C2=A0 =C2=A0 SHARED_FIELD(SGPIO_WRITE_PROTECT, 31, 1)<br>
&gt; +REG32(SGPIO_255_CONTROL, 0x47C)<br>
&gt; +<br>
&gt; +struct AspeedSGPIOClass {<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt; +=C2=A0 =C2=A0 uint32_t nr_sgpio_pin_pairs;<br>
&gt; +=C2=A0 =C2=A0 uint64_t mem_size;<br>
&gt; +=C2=A0 =C2=A0 const MemoryRegionOps *reg_ops;<br>
&gt; +};<br>
<br>
<br>
I don&#39;t see any need of an AspeedSGPIOClass for now. Do you have plans<=
br>
for future models ?<br>
<br>
Thanks,<br>
<br>
C.<br>
<br>
<br>
&gt; +<br>
&gt; +struct AspeedSGPIOState {<br>
&gt; +=C2=A0 /* &lt;private&gt; */<br>
&gt; +=C2=A0 SysBusDevice parent;<br>
&gt; +<br>
&gt; +=C2=A0 /*&lt; public &gt;*/<br>
&gt; +=C2=A0 MemoryRegion iomem;<br>
&gt; +=C2=A0 qemu_irq irq;<br>
&gt; +=C2=A0 uint32_t ctrl_regs[ASPEED_SGPIO_MAX_PIN_PAIR];<br>
&gt; +=C2=A0 uint32_t int_regs[ASPEED_SGPIO_MAX_INT];<br>
&gt; +};<br>
&gt; +<br>
&gt; +#endif /* ASPEED_SGPIO_H */<br>
&gt; <br>
<br>
</blockquote></div>

--0000000000007a8db206459475dd--

