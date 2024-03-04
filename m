Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955E9C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 22:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhGrP-0003b5-Vf; Mon, 04 Mar 2024 17:32:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhGrO-0003aj-L4
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 17:32:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhGrM-0006g0-4p
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 17:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709591550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rhbVM/ZgBApEjspwPnO4X769uidaO46DKICPtyBCRtk=;
 b=JchKO1k4EJlfx9AkBUE4BiglxkgcirLnJNIr+F0ThTdxHawl+20LP37gx6dHH9/3wjV0mV
 /P+9nrQkW/kvsWCAWTj53y70S+S/FB36LpE/5axk2MU0pF34vO7bMMtQc515jJqvjhujK3
 JPd3XYbvSWMC40pOIOHCsOMVTyfRdDs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-pXeLPZ5sMvKaXHbVyucTuQ-1; Mon, 04 Mar 2024 17:32:28 -0500
X-MC-Unique: pXeLPZ5sMvKaXHbVyucTuQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-412c7ee0c97so23863075e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 14:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709591547; x=1710196347;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rhbVM/ZgBApEjspwPnO4X769uidaO46DKICPtyBCRtk=;
 b=I7+LXcVcZl785DGYyBcwbL8yexQrxpotE+3NH/4LZqpwhtX/mbeBuHLM+CVK4jGEly
 5RmiZCH+3Vq0K2qwMgREs+cVfneW9WVFJ0U1DHESlYAPZDmU+CIDxT16KsRyBfHWm2TY
 CVWWKUn/5Vq1I9O6PaNJQAY5jy+Bad+3P0+QTR9YCwwymcTVITN/LWnetuwSY3t9BhWY
 d8jyJCioLpy65g0+pWCbuO+rv21v4DDgZvqU8u2cg6S/P0YIa+iUWdzbzRItnUunNa4h
 3/RraaWkur8nJy/cJE9QbntVeKHv2jor5Z/sT2nSve7lQqQvHQM6xPFZF9fRjQtf0sNi
 wlPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNFWK/PPGr7Wfpm4Az5RAhxqCTUiRUOGb11wM0bxwSEtgY4VnrWYsQpSLK59TTyxfklnWyZVF0X/y+WwSILnE/tP82FYQ=
X-Gm-Message-State: AOJu0Yzj87nFDWICWyztY7y8O3NDYmtsGCLcHmCxYFN2n/wizpAXj8vu
 kD4QdkvlHi0ZpigPnl0AT9XT820IdPJN89QocHc8psZJaQYdodofQffq8rH1z0Kk72/or8TeWno
 h/uec7WeebZe/TfrHezwvB437/gz6dino9B1OiO9Mh5sSMwa2Furc
X-Received: by 2002:a05:600c:468a:b0:412:b0d3:62f4 with SMTP id
 p10-20020a05600c468a00b00412b0d362f4mr8202614wmo.26.1709591547517; 
 Mon, 04 Mar 2024 14:32:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHl2mE7ve+RZFY2jwRbOfNnd0ovQDh5Qr4fX2p+9Fc0ArcWbosEOWXZBHP5D6WT/UMr1gP98Q==
X-Received: by 2002:a05:600c:468a:b0:412:b0d3:62f4 with SMTP id
 p10-20020a05600c468a00b00412b0d362f4mr8202600wmo.26.1709591547095; 
 Mon, 04 Mar 2024 14:32:27 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.googlemail.com with ESMTPSA id
 n12-20020a05600c500c00b00412e9926c1dsm1226285wmr.0.2024.03.04.14.32.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 14:32:26 -0800 (PST)
Message-ID: <e818c2ac-149f-4767-bb5a-53501729762d@redhat.com>
Date: Mon, 4 Mar 2024 23:32:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/9] misc: Add a pca9554 GPIO device model
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Reza Arbab <arbab@linux.ibm.com>
References: <20240125224818.146499-1-milesg@linux.vnet.ibm.com>
 <20240125224818.146499-8-milesg@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240125224818.146499-8-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/25/24 23:48, Glenn Miles wrote:
> Specs are available here:
> 
>      https://www.nxp.com/docs/en/data-sheet/PCA9554_9554A.pdf
> 
> This is a simple model supporting the basic registers for GPIO
> mode.  The device also supports an interrupt output line but the
> model does not yet support this.
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
> 
> No changes from previous version
> 
>   MAINTAINERS                    |  10 +-
>   hw/misc/pca9554.c              | 328 +++++++++++++++++++++++++++++++++

Not a huge deal, but this should have been in hw/gpio.

Paolo

>   include/hw/misc/pca9554.h      |  36 ++++
>   include/hw/misc/pca9554_regs.h |  19 ++
>   4 files changed, 391 insertions(+), 2 deletions(-)
>   create mode 100644 hw/misc/pca9554.c
>   create mode 100644 include/hw/misc/pca9554.h
>   create mode 100644 include/hw/misc/pca9554_regs.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dfaca8323e..51861e3c7d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1169,9 +1169,7 @@ R: Joel Stanley <joel@jms.id.au>
>   L: qemu-arm@nongnu.org
>   S: Maintained
>   F: hw/*/*aspeed*
> -F: hw/misc/pca9552.c
>   F: include/hw/*/*aspeed*
> -F: include/hw/misc/pca9552*.h
>   F: hw/net/ftgmac100.c
>   F: include/hw/net/ftgmac100.h
>   F: docs/system/arm/aspeed.rst
> @@ -1540,6 +1538,14 @@ F: include/hw/pci-host/pnv*
>   F: pc-bios/skiboot.lid
>   F: tests/qtest/pnv*
>   
> +pca955x
> +M: Glenn Miles <milesg@linux.vnet.ibm.com>
> +L: qemu-ppc@nongnu.org
> +L: qemu-arm@nongnu.org
> +S: Odd Fixes
> +F: hw/misc/pca955*.c
> +F: include/hw/misc/pca955*.h
> +
>   virtex_ml507
>   M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>   L: qemu-ppc@nongnu.org
> diff --git a/hw/misc/pca9554.c b/hw/misc/pca9554.c
> new file mode 100644
> index 0000000000..778b32e443
> --- /dev/null
> +++ b/hw/misc/pca9554.c
> @@ -0,0 +1,328 @@
> +/*
> + * PCA9554 I/O port
> + *
> + * Copyright (c) 2023, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/bitops.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/misc/pca9554.h"
> +#include "hw/misc/pca9554_regs.h"
> +#include "hw/irq.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
> +#include "trace.h"
> +#include "qom/object.h"
> +
> +struct PCA9554Class {
> +    /*< private >*/
> +    I2CSlaveClass parent_class;
> +    /*< public >*/
> +};
> +typedef struct PCA9554Class PCA9554Class;
> +
> +DECLARE_CLASS_CHECKERS(PCA9554Class, PCA9554,
> +                       TYPE_PCA9554)
> +
> +#define PCA9554_PIN_LOW  0x0
> +#define PCA9554_PIN_HIZ  0x1
> +
> +static const char *pin_state[] = {"low", "high"};
> +
> +static void pca9554_update_pin_input(PCA9554State *s)
> +{
> +    int i;
> +    uint8_t config = s->regs[PCA9554_CONFIG];
> +    uint8_t output = s->regs[PCA9554_OUTPUT];
> +    uint8_t internal_state = config | output;
> +
> +    for (i = 0; i < PCA9554_PIN_COUNT; i++) {
> +        uint8_t bit_mask = 1 << i;
> +        uint8_t internal_pin_state = (internal_state >> i) & 0x1;
> +        uint8_t old_value = s->regs[PCA9554_INPUT] & bit_mask;
> +        uint8_t new_value;
> +
> +        switch (internal_pin_state) {
> +        case PCA9554_PIN_LOW:
> +            s->regs[PCA9554_INPUT] &= ~bit_mask;
> +            break;
> +        case PCA9554_PIN_HIZ:
> +            /*
> +             * pullup sets it to a logical 1 unless
> +             * external device drives it low.
> +             */
> +            if (s->ext_state[i] == PCA9554_PIN_LOW) {
> +                s->regs[PCA9554_INPUT] &= ~bit_mask;
> +            } else {
> +                s->regs[PCA9554_INPUT] |=  bit_mask;
> +            }
> +            break;
> +        default:
> +            break;
> +        }
> +
> +        /* update irq state only if pin state changed */
> +        new_value = s->regs[PCA9554_INPUT] & bit_mask;
> +        if (new_value != old_value) {
> +            if (new_value) {
> +                /* changed from 0 to 1 */
> +                qemu_set_irq(s->gpio_out[i], 1);
> +            } else {
> +                /* changed from 1 to 0 */
> +                qemu_set_irq(s->gpio_out[i], 0);
> +            }
> +        }
> +    }
> +}
> +
> +static uint8_t pca9554_read(PCA9554State *s, uint8_t reg)
> +{
> +    switch (reg) {
> +    case PCA9554_INPUT:
> +        return s->regs[PCA9554_INPUT] ^ s->regs[PCA9554_POLARITY];
> +    case PCA9554_OUTPUT:
> +    case PCA9554_POLARITY:
> +    case PCA9554_CONFIG:
> +        return s->regs[reg];
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: unexpected read to register %d\n",
> +                      __func__, reg);
> +        return 0xFF;
> +    }
> +}
> +
> +static void pca9554_write(PCA9554State *s, uint8_t reg, uint8_t data)
> +{
> +    switch (reg) {
> +    case PCA9554_OUTPUT:
> +    case PCA9554_CONFIG:
> +        s->regs[reg] = data;
> +        pca9554_update_pin_input(s);
> +        break;
> +    case PCA9554_POLARITY:
> +        s->regs[reg] = data;
> +        break;
> +    case PCA9554_INPUT:
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: unexpected write to register %d\n",
> +                      __func__, reg);
> +    }
> +}
> +
> +static uint8_t pca9554_recv(I2CSlave *i2c)
> +{
> +    PCA9554State *s = PCA9554(i2c);
> +    uint8_t ret;
> +
> +    ret = pca9554_read(s, s->pointer & 0x3);
> +
> +    return ret;
> +}
> +
> +static int pca9554_send(I2CSlave *i2c, uint8_t data)
> +{
> +    PCA9554State *s = PCA9554(i2c);
> +
> +    /* First byte sent by is the register address */
> +    if (s->len == 0) {
> +        s->pointer = data;
> +        s->len++;
> +    } else {
> +        pca9554_write(s, s->pointer & 0x3, data);
> +    }
> +
> +    return 0;
> +}
> +
> +static int pca9554_event(I2CSlave *i2c, enum i2c_event event)
> +{
> +    PCA9554State *s = PCA9554(i2c);
> +
> +    s->len = 0;
> +    return 0;
> +}
> +
> +static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
> +                            void *opaque, Error **errp)
> +{
> +    PCA9554State *s = PCA9554(obj);
> +    int pin, rc;
> +    uint8_t state;
> +
> +    rc = sscanf(name, "pin%2d", &pin);
> +    if (rc != 1) {
> +        error_setg(errp, "%s: error reading %s", __func__, name);
> +        return;
> +    }
> +    if (pin < 0 || pin > PCA9554_PIN_COUNT) {
> +        error_setg(errp, "%s invalid pin %s", __func__, name);
> +        return;
> +    }
> +
> +    state = pca9554_read(s, PCA9554_CONFIG);
> +    state |= pca9554_read(s, PCA9554_OUTPUT);
> +    state = (state >> pin) & 0x1;
> +    visit_type_str(v, name, (char **)&pin_state[state], errp);
> +}
> +
> +static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
> +                            void *opaque, Error **errp)
> +{
> +    PCA9554State *s = PCA9554(obj);
> +    int pin, rc, val;
> +    uint8_t state, mask;
> +    char *state_str;
> +
> +    if (!visit_type_str(v, name, &state_str, errp)) {
> +        return;
> +    }
> +    rc = sscanf(name, "pin%2d", &pin);
> +    if (rc != 1) {
> +        error_setg(errp, "%s: error reading %s", __func__, name);
> +        return;
> +    }
> +    if (pin < 0 || pin > PCA9554_PIN_COUNT) {
> +        error_setg(errp, "%s invalid pin %s", __func__, name);
> +        return;
> +    }
> +
> +    for (state = 0; state < ARRAY_SIZE(pin_state); state++) {
> +        if (!strcmp(state_str, pin_state[state])) {
> +            break;
> +        }
> +    }
> +    if (state >= ARRAY_SIZE(pin_state)) {
> +        error_setg(errp, "%s invalid pin state %s", __func__, state_str);
> +        return;
> +    }
> +
> +    /* First, modify the output register bit */
> +    val = pca9554_read(s, PCA9554_OUTPUT);
> +    mask = 0x1 << pin;
> +    if (state == PCA9554_PIN_LOW) {
> +        val &= ~(mask);
> +    } else {
> +        val |= mask;
> +    }
> +    pca9554_write(s, PCA9554_OUTPUT, val);
> +
> +    /* Then, clear the config register bit for output mode */
> +    val = pca9554_read(s, PCA9554_CONFIG);
> +    val &= ~mask;
> +    pca9554_write(s, PCA9554_CONFIG, val);
> +}
> +
> +static const VMStateDescription pca9554_vmstate = {
> +    .name = "PCA9554",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8(len, PCA9554State),
> +        VMSTATE_UINT8(pointer, PCA9554State),
> +        VMSTATE_UINT8_ARRAY(regs, PCA9554State, PCA9554_NR_REGS),
> +        VMSTATE_UINT8_ARRAY(ext_state, PCA9554State, PCA9554_PIN_COUNT),
> +        VMSTATE_I2C_SLAVE(i2c, PCA9554State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void pca9554_reset(DeviceState *dev)
> +{
> +    PCA9554State *s = PCA9554(dev);
> +
> +    s->regs[PCA9554_INPUT] = 0xFF;
> +    s->regs[PCA9554_OUTPUT] = 0xFF;
> +    s->regs[PCA9554_POLARITY] = 0x0; /* No pins are inverted */
> +    s->regs[PCA9554_CONFIG] = 0xFF; /* All pins are inputs */
> +
> +    memset(s->ext_state, PCA9554_PIN_HIZ, PCA9554_PIN_COUNT);
> +    pca9554_update_pin_input(s);
> +
> +    s->pointer = 0x0;
> +    s->len = 0;
> +}
> +
> +static void pca9554_initfn(Object *obj)
> +{
> +    int pin;
> +
> +    for (pin = 0; pin < PCA9554_PIN_COUNT; pin++) {
> +        char *name;
> +
> +        name = g_strdup_printf("pin%d", pin);
> +        object_property_add(obj, name, "bool", pca9554_get_pin, pca9554_set_pin,
> +                            NULL, NULL);
> +        g_free(name);
> +    }
> +}
> +
> +static void pca9554_set_ext_state(PCA9554State *s, int pin, int level)
> +{
> +    if (s->ext_state[pin] != level) {
> +        s->ext_state[pin] = level;
> +        pca9554_update_pin_input(s);
> +    }
> +}
> +
> +static void pca9554_gpio_in_handler(void *opaque, int pin, int level)
> +{
> +
> +    PCA9554State *s = PCA9554(opaque);
> +
> +    assert((pin >= 0) && (pin < PCA9554_PIN_COUNT));
> +    pca9554_set_ext_state(s, pin, level);
> +}
> +
> +static void pca9554_realize(DeviceState *dev, Error **errp)
> +{
> +    PCA9554State *s = PCA9554(dev);
> +
> +    if (!s->description) {
> +        s->description = g_strdup("pca9554");
> +    }
> +
> +    qdev_init_gpio_out(dev, s->gpio_out, PCA9554_PIN_COUNT);
> +    qdev_init_gpio_in(dev, pca9554_gpio_in_handler, PCA9554_PIN_COUNT);
> +}
> +
> +static Property pca9554_properties[] = {
> +    DEFINE_PROP_STRING("description", PCA9554State, description),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void pca9554_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +
> +    k->event = pca9554_event;
> +    k->recv = pca9554_recv;
> +    k->send = pca9554_send;
> +    dc->realize = pca9554_realize;
> +    dc->reset = pca9554_reset;
> +    dc->vmsd = &pca9554_vmstate;
> +    device_class_set_props(dc, pca9554_properties);
> +}
> +
> +static const TypeInfo pca9554_info = {
> +    .name          = TYPE_PCA9554,
> +    .parent        = TYPE_I2C_SLAVE,
> +    .instance_init = pca9554_initfn,
> +    .instance_size = sizeof(PCA9554State),
> +    .class_init    = pca9554_class_init,
> +    .class_size    = sizeof(PCA9554Class),
> +    .abstract      = false,
> +};
> +
> +static void pca9554_register_types(void)
> +{
> +    type_register_static(&pca9554_info);
> +}
> +
> +type_init(pca9554_register_types)
> diff --git a/include/hw/misc/pca9554.h b/include/hw/misc/pca9554.h
> new file mode 100644
> index 0000000000..54bfc4c4c7
> --- /dev/null
> +++ b/include/hw/misc/pca9554.h
> @@ -0,0 +1,36 @@
> +/*
> + * PCA9554 I/O port
> + *
> + * Copyright (c) 2023, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef PCA9554_H
> +#define PCA9554_H
> +
> +#include "hw/i2c/i2c.h"
> +#include "qom/object.h"
> +
> +#define TYPE_PCA9554 "pca9554"
> +typedef struct PCA9554State PCA9554State;
> +DECLARE_INSTANCE_CHECKER(PCA9554State, PCA9554,
> +                         TYPE_PCA9554)
> +
> +#define PCA9554_NR_REGS 4
> +#define PCA9554_PIN_COUNT 8
> +
> +struct PCA9554State {
> +    /*< private >*/
> +    I2CSlave i2c;
> +    /*< public >*/
> +
> +    uint8_t len;
> +    uint8_t pointer;
> +
> +    uint8_t regs[PCA9554_NR_REGS];
> +    qemu_irq gpio_out[PCA9554_PIN_COUNT];
> +    uint8_t ext_state[PCA9554_PIN_COUNT];
> +    char *description; /* For debugging purpose only */
> +};
> +
> +#endif
> diff --git a/include/hw/misc/pca9554_regs.h b/include/hw/misc/pca9554_regs.h
> new file mode 100644
> index 0000000000..602c4a90e0
> --- /dev/null
> +++ b/include/hw/misc/pca9554_regs.h
> @@ -0,0 +1,19 @@
> +/*
> + * PCA9554 I/O port registers
> + *
> + * Copyright (c) 2023, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef PCA9554_REGS_H
> +#define PCA9554_REGS_H
> +
> +/*
> + * Bits [0:1] are used to address a specific register.
> + */
> +#define PCA9554_INPUT       0 /* read only input register */
> +#define PCA9554_OUTPUT      1 /* read/write pin output state */
> +#define PCA9554_POLARITY    2 /* Set polarity of input register */
> +#define PCA9554_CONFIG      3 /* Set pins as inputs our ouputs */
> +
> +#endif


