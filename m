Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C27D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 09:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vStve-00064Y-EB; Tue, 09 Dec 2025 04:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vStvc-00063r-F2
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 04:22:40 -0500
Received: from smtpout2.mo529.mail-out.ovh.net ([79.137.123.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vStvZ-0001lb-In
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 04:22:40 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.152])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4dQYKN0lkVz5wM7;
 Tue,  9 Dec 2025 09:22:32 +0000 (UTC)
Received: from kaod.org (37.59.142.114) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 9 Dec
 2025 10:22:31 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S008e1d709f2-5181-455a-acf7-f712cd482e84,
 913B1D19E2E265D49699B36B6A33E6F0AA87D788) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d5fcfc09-fe80-498d-8df6-1d1dc9d15a57@kaod.org>
Date: Tue, 9 Dec 2025 10:22:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] hw/gpio/aspeed_sgpio: Add basic device model for
 Aspeed SGPIO
To: Yubin Zou <yubinz@google.com>, <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kane-Chen-AS <kane_chen@aspeedtech.com>, Nabih Estefan
 <nabihestefan@google.com>, <qemu-arm@nongnu.org>
References: <20251209-aspeed-sgpio-v2-0-976e5f5790c2@google.com>
 <20251209-aspeed-sgpio-v2-1-976e5f5790c2@google.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251209-aspeed-sgpio-v2-1-976e5f5790c2@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.114]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: c04511bb-2f45-43c1-99f4-71c06bf84584
X-Ovh-Tracer-Id: 16885965330920409918
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFejC3nEJIYfpU30ppryD/SHo1RXxjM2PmQV0WQTHi+MG/wUv0SdBfFBvn3zDg69vM1NKtJCVc858FjK7GWjgjOLrD4Enp59Cu5B0+nMN5eOflxMvhlGWCrgh8RaD4uMvdW3gxTBwPetPhJt1fbN9hkq+yJIOKposm27YsSpTdk/OKmbxgoL0Ei54x6zCz5LOGJ7iaaJZmvD9nsY9u/J06bwrTPIsGlmrDYWMQlfG5D1jFoKu042OQTQxrEcr0ZqC6kvt970uuui+Miw3E5mRbZiRHh4r/9otYdz7ddMt9RPT6gUDmmuovrH216fzYmaaVhCRuNW1jpfwLwUZ23f+VEA6OupIhTIIAwULZXSHzvHUrpSg9WPnATVeSVm4deLaU1xgKWNHiI6U2ZtEM0SgL/tWmBJlII6OfuXX0q7eV0NaGHRBfaohLlXNsTxSkYCoVO83EjHFG5wi6W8827mOYrAtD/DTu3pqgBv4jmW98sszzRggJwrvfzAGVTcBKFlfS7DRfmbemL5LPZHMqE1RCxV/7ueRD2nayLcYj0hJJTIdKTbtH6Twr/E1YZsz8s7FgR/M6SfX/QRQAx6x3T3aAEJJ5+kPEATp+GK8633/5jnv/8UFIrufD0rMbqC8LagEs9Tjkv2lX66v0Ro60RBS+fr24BOA0Zueuwj734Czp55g
DKIM-Signature: a=rsa-sha256; bh=IpF1KpRVhu6x3BRWxObhxln3AtcDimVkijBo57IkE3M=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1765272154; v=1;
 b=JmLBc7bhlJChG7WWiskfBjLfU7tgBKZh5ZnomQYG1jxQ8faBve7z4O9UTI3FSC0mBBs30QfK
 7MEe4i6gUCOSWtlQHwfLccZYSj+6bbLvYp7cksvKGyfk+vMBVg/+81P5PoddsO2OoARfYdIkffh
 3PZebruswECyiRFYDg5tftzt93q3H7yqXq+gk8Z05OSixPq0p7Cyt0/ni9ZGsnR2QKMBGOX9DWa
 NDNjo0cAshk1seHyEN2fLlsphV0HArPA321l6vrm7yPZddSkS/VaMicBqjf4l4vuv65k2t41/Kr
 7I/P0yTFnIEtoP2d8K/q7G25qAa9FLKPMkCTjwh3LWAtg==
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout2.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/9/25 01:01, Yubin Zou wrote:
> This initial implementation includes the basic device structure,
> memory-mapped register definitions, and read/write handlers for the
> SGPIO control registers.
> 
> Signed-off-by: Yubin Zou <yubinz@google.com>
> ---
>   hw/gpio/aspeed_sgpio.c         | 154 +++++++++++++++++++++++++++++++++++++++++
>   hw/gpio/meson.build            |   1 +
>   include/hw/gpio/aspeed_sgpio.h |  66 ++++++++++++++++++
>   3 files changed, 221 insertions(+)

Please add to your .git/config :

   [diff]
     orderFile = /path/to/qemu/scripts/git.orderfile

It is easier to review if the changes in header files are first.


> diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..8676fa7ced134f1f62dc9e30b42c5fe6db3de268
> --- /dev/null
> +++ b/hw/gpio/aspeed_sgpio.c
> @@ -0,0 +1,154 @@
> +/*
> + * ASPEED Serial GPIO Controller
> + *
> + * Copyright 2025 Google LLC.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/host-utils.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/gpio/aspeed_sgpio.h"
> +
> +static uint64_t aspeed_sgpio_2700_read_int_status_reg(AspeedSGPIOState *s,
> +                                uint32_t reg)
> +{
> +    return 0;
> +}
> +
> +static uint64_t aspeed_sgpio_2700_read_control_reg(AspeedSGPIOState *s,
> +                                uint32_t reg)
> +{
> +    AspeedSGPIOClass *agc = ASPEED_SGPIO_GET_CLASS(s);
> +    uint32_t idx = reg - R_SGPIO_0_CONTROL;
> +    if (idx >= agc->nr_sgpio_pin_pairs) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: pin index: %d, out of bounds\n",
> +                      __func__, idx);
> +        return 0;
> +    }
> +    return s->ctrl_regs[idx];
> +}
> +
> +static void aspeed_sgpio_2700_write_control_reg(AspeedSGPIOState *s,
> +                                uint32_t reg, uint64_t data)
> +{
> +    AspeedSGPIOClass *agc = ASPEED_SGPIO_GET_CLASS(s);
> +    uint32_t idx = reg - R_SGPIO_0_CONTROL;
> +    if (idx >= agc->nr_sgpio_pin_pairs) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: pin index: %d, out of bounds\n",
> +                      __func__, idx);
> +        return;
> +    }
> +    s->ctrl_regs[idx] = data;
> +}
> +
> +static uint64_t aspeed_sgpio_2700_read(void *opaque, hwaddr offset,
> +                                uint32_t size)
> +{
> +    AspeedSGPIOState *s = ASPEED_SGPIO(opaque);
> +    uint64_t value = 0;
> +    uint64_t reg;
> +
> +    reg = offset >> 2;
> +
> +    switch (reg) {
> +    case R_SGPIO_INT_STATUS_0 ... R_SGPIO_INT_STATUS_7:
> +        aspeed_sgpio_2700_read_int_status_reg(s, reg);
> +        break;
> +    case R_SGPIO_0_CONTROL ... R_SGPIO_255_CONTROL:
> +        value = aspeed_sgpio_2700_read_control_reg(s, reg);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: no getter for offset 0x%"
> +                      PRIx64"\n", __func__, offset);
> +        return 0;
> +    }
> +
> +    return value;
> +}
> +
> +static void aspeed_sgpio_2700_write(void *opaque, hwaddr offset, uint64_t data,
> +                                uint32_t size)
> +{
> +    AspeedSGPIOState *s = ASPEED_SGPIO(opaque);
> +    uint64_t reg;
> +
> +    reg = offset >> 2;
> +
> +    switch (reg) {
> +    case R_SGPIO_0_CONTROL ... R_SGPIO_255_CONTROL:
> +        aspeed_sgpio_2700_write_control_reg(s, reg, data);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: no setter for offset 0x%"
> +                      PRIx64"\n", __func__, offset);
> +        return;
> +    }
> +}
> +
> +static const MemoryRegionOps aspeed_gpio_2700_ops = {
> +  .read       = aspeed_sgpio_2700_read,
> +  .write      = aspeed_sgpio_2700_write,
> +  .endianness = DEVICE_LITTLE_ENDIAN,
> +  .valid.min_access_size = 4,
> +  .valid.max_access_size = 4,
> +};
> +
> +static void aspeed_sgpio_realize(DeviceState *dev, Error **errp)
> +{
> +    AspeedSGPIOState *s = ASPEED_SGPIO(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    AspeedSGPIOClass *agc = ASPEED_SGPIO_GET_CLASS(s);
> +
> +    /* Interrupt parent line */
> +    sysbus_init_irq(sbd, &s->irq);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), agc->reg_ops, s,
> +                          TYPE_ASPEED_SGPIO, agc->mem_size);
> +
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static void aspeed_sgpio_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = aspeed_sgpio_realize;
> +    dc->desc = "Aspeed SGPIO Controller";
> +}
> +
> +static void aspeed_sgpio_2700_class_init(ObjectClass *klass, const void *data)
> +{
> +    AspeedSGPIOClass *agc = ASPEED_SGPIO_CLASS(klass);
> +    agc->nr_sgpio_pin_pairs = 256;
> +    agc->mem_size = 0x1000;
> +    agc->reg_ops = &aspeed_gpio_2700_ops;
> +}
> +
> +static const TypeInfo aspeed_sgpio_info = {
> +    .name           = TYPE_ASPEED_SGPIO,
> +    .parent         = TYPE_SYS_BUS_DEVICE,
> +    .instance_size  = sizeof(AspeedSGPIOState),
> +    .class_size     = sizeof(AspeedSGPIOClass),
> +    .class_init     = aspeed_sgpio_class_init,
> +    .abstract       = true,
> +};
> +
> +static const TypeInfo aspeed_sgpio_ast2700_info = {
> +  .name           = TYPE_ASPEED_SGPIO "-ast2700",
> +  .parent         = TYPE_ASPEED_SGPIO,
> +  .class_init     = aspeed_sgpio_2700_class_init,
> +};
> +
> +static void aspeed_sgpio_register_types(void)
> +{
> +    type_register_static(&aspeed_sgpio_info);
> +    type_register_static(&aspeed_sgpio_ast2700_info);
> +}
> +
> +type_init(aspeed_sgpio_register_types);
> diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
> index 74840619c01bf4d9a02c058c434c3ec9d2a55bee..6a67ee958faace69ffd3fe08e8ade31ced0faf7e 100644
> --- a/hw/gpio/meson.build
> +++ b/hw/gpio/meson.build
> @@ -16,5 +16,6 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
>   ))
>   system_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_gpio.c'))
>   system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
> +system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sgpio.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
>   system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
> diff --git a/include/hw/gpio/aspeed_sgpio.h b/include/hw/gpio/aspeed_sgpio.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..ffdc54a112da8962a7bc5773d524f1d86eb85d39
> --- /dev/null
> +++ b/include/hw/gpio/aspeed_sgpio.h
> @@ -0,0 +1,66 @@
> +/*
> + * ASPEED Serial GPIO Controller
> + *
> + * Copyright 2025 Google LLC.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef ASPEED_SGPIO_H
> +#define ASPEED_SGPIO_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +#include "hw/registerfields.h"
> +
> +#define TYPE_ASPEED_SGPIO "aspeed.sgpio"
> +OBJECT_DECLARE_TYPE(AspeedSGPIOState, AspeedSGPIOClass, ASPEED_SGPIO)
> +
> +#define ASPEED_SGPIO_MAX_PIN_PAIR 256
> +#define ASPEED_SGPIO_MAX_INT 8
> +
> +/* AST2700 SGPIO Register Address Offsets */
> +REG32(SGPIO_INT_STATUS_0, 0x40)
> +REG32(SGPIO_INT_STATUS_1, 0x44)
> +REG32(SGPIO_INT_STATUS_2, 0x48)
> +REG32(SGPIO_INT_STATUS_3, 0x4C)
> +REG32(SGPIO_INT_STATUS_4, 0x50)
> +REG32(SGPIO_INT_STATUS_5, 0x54)
> +REG32(SGPIO_INT_STATUS_6, 0x58)
> +REG32(SGPIO_INT_STATUS_7, 0x5C)
> +/* AST2700 SGPIO_0 - SGPIO_255 Control Register */
> +REG32(SGPIO_0_CONTROL, 0x80)
> +    SHARED_FIELD(SGPIO_SERIAL_OUT_VAL, 0, 1)
> +    SHARED_FIELD(SGPIO_PARALLEL_OUT_VAL, 1, 1)
> +    SHARED_FIELD(SGPIO_INT_EN, 2, 1)
> +    SHARED_FIELD(SGPIO_INT_TYPE, 3, 3)
> +    SHARED_FIELD(SGPIO_RESET_POLARITY, 6, 1)
> +    SHARED_FIELD(SGPIO_RESERVED_1, 7, 2)
> +    SHARED_FIELD(SGPIO_INPUT_MASK, 9, 1)
> +    SHARED_FIELD(SGPIO_PARALLEL_EN, 10, 1)
> +    SHARED_FIELD(SGPIO_PARALLEL_IN_MODE, 11, 1)
> +    SHARED_FIELD(SGPIO_INT_STATUS, 12, 1)
> +    SHARED_FIELD(SGPIO_SERIAL_IN_VAL, 13, 1)
> +    SHARED_FIELD(SGPIO_PARALLEL_IN_VAL, 14, 1)
> +    SHARED_FIELD(SGPIO_RESERVED_2, 15, 12)
> +    SHARED_FIELD(SGPIO_WRITE_PROTECT, 31, 1)
> +REG32(SGPIO_255_CONTROL, 0x47C)
> +
> +struct AspeedSGPIOClass {
> +    SysBusDevice parent_obj;
> +    uint32_t nr_sgpio_pin_pairs;
> +    uint64_t mem_size;
> +    const MemoryRegionOps *reg_ops;
> +};


I don't see any need of an AspeedSGPIOClass for now. Do you have plans
for future models ?

Thanks,

C.


> +
> +struct AspeedSGPIOState {
> +  /* <private> */
> +  SysBusDevice parent;
> +
> +  /*< public >*/
> +  MemoryRegion iomem;
> +  qemu_irq irq;
> +  uint32_t ctrl_regs[ASPEED_SGPIO_MAX_PIN_PAIR];
> +  uint32_t int_regs[ASPEED_SGPIO_MAX_INT];
> +};
> +
> +#endif /* ASPEED_SGPIO_H */
> 


