Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4A2C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 23:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rheN0-0006Lq-La; Tue, 05 Mar 2024 18:38:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rheMy-0006LP-Nq
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 18:38:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rheMt-0001Of-Th
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 18:38:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709681922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Or6i0AIU9LpV9F14dBKXOIPE5wb8eLAtoT8Ct2rbRqI=;
 b=i7iseVnCqGtv1petcw7rUK4sk8XdjAes0Y/y0z3LfNgvysMltYvrqUH8uMvIvBLQdstMzh
 3YMlbjgaFEfmnpB0XNqgDaosFea3HotPWIF7nm86FwK2HbN05n+8+9T6RbMBZQl255sCRf
 wcGjLd47YgSSHgLX2X7nNdKk3wOg05U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-TqmRPVLTM9SKzp1Etbj22Q-1; Tue, 05 Mar 2024 18:38:40 -0500
X-MC-Unique: TqmRPVLTM9SKzp1Etbj22Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33d8d208be9so3853458f8f.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 15:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709681919; x=1710286719;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Or6i0AIU9LpV9F14dBKXOIPE5wb8eLAtoT8Ct2rbRqI=;
 b=QRXPX/O+r0q/Jtyq6IfEdkvb26wjX0U3TV7NZ0iD1oPQYXEUd84njtQc4697/0IJw4
 5D4X7Tmorvi5ortTJO/enWbfLCDYE+Z9bMHxumZK2E+f0WsGupJsyqtEC/M3P3gYOUWn
 BIynvNSOgitPxW6ZEYiTvttDNNUWSFnSSW+Oxe6AHFNiLGW+0+OEtT71saQHuJpEdtMM
 YWNi/KNiyzHQNNsMri4lIeP3WBA8taJ0KYbvVn8S8Of2NPxy4SaD+J7wyhmJv1BRMkSW
 opnAL4E1HvXaBGAlFWxre1o+QQVY1mpCkem27LtwCNd5C7usGiTyK2j7p9jQK8AJilis
 zcFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd+XHiOZuO9Yr6pTWegurdNCxYuZmE/oCgqEwDHZzpSa5+wnuHizpnQlX489mVec7NPc3R4vVDzC4zAC4wPh0zR3zyHmg=
X-Gm-Message-State: AOJu0Yym2UD1rOFpA7u3mWvmCyXXgSbVhB/MNGel7PgY0/la31YXSlof
 5igeVbyLmQa3s0AxMrpF+igHViPcnTlAzxQmVnfxsZGgR+xMUSHSlCwlbb1VVss19DA3s+Qh1Ju
 XgQbT5LJzaYS7nCxImrTuNJWRpm4ReM1mypOGgjykzLSmdIBdgHp3n/doSpSdtR3nMu/LXGaJtu
 zDcy5CFWkIe0LA03flzybeCqYeC/4=
X-Received: by 2002:adf:a390:0:b0:33d:5a6f:a856 with SMTP id
 l16-20020adfa390000000b0033d5a6fa856mr9196252wrb.30.1709681919449; 
 Tue, 05 Mar 2024 15:38:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqCUcKzx9icehJdOXiBfcug0jTA1TGAOgURx2b9XsL9vSqXiAyZ3ePWbq29WwyWnDhLoTE9IHMZ+S56nBOudc=
X-Received: by 2002:adf:a390:0:b0:33d:5a6f:a856 with SMTP id
 l16-20020adfa390000000b0033d5a6fa856mr9196241wrb.30.1709681919034; Tue, 05
 Mar 2024 15:38:39 -0800 (PST)
MIME-Version: 1.0
References: <20240125224818.146499-1-milesg@linux.vnet.ibm.com>
 <20240125224818.146499-8-milesg@linux.vnet.ibm.com>
 <e818c2ac-149f-4767-bb5a-53501729762d@redhat.com>
 <1a40d19d-993f-4820-b839-95b17c31a703@kaod.org>
In-Reply-To: <1a40d19d-993f-4820-b839-95b17c31a703@kaod.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 6 Mar 2024 00:38:26 +0100
Message-ID: <CABgObfZpNRPX=XVwJK0aNe9gzjZxCaeVUHWiF=zpJLF_-tZM5Q@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] misc: Add a pca9554 GPIO device model
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 "zmta06.collab.prod.int.phx2.redhat.com, list@suse.de" <qemu-ppc@nongnu.org>,
 Nicholas Piggin <npiggin@gmail.com>, 
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>, 
 Reza Arbab <arbab@linux.ibm.com>
Content-Type: multipart/alternative; boundary="00000000000076999c0612f257cc"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000076999c0612f257cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 5 mar 2024, 07:26 C=C3=A9dric Le Goater <clg@kaod.org> ha scritto:

> ** CID 1534919:  Error handling issues  (CHECKED_RETURN)
> /builds/bonzini/qemu/hw/misc/pca9554.c: 171 in pca9554_get_pin()
>
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 1534919:  Error handling issues  (CHECKED_RETURN)
> /builds/bonzini/qemu/hw/misc/pca9554.c: 171 in pca9554_get_pin()
> 165             return;
> 166         }
> 167
> 168         state =3D pca9554_read(s, PCA9554_CONFIG);
> 169         state |=3D pca9554_read(s, PCA9554_OUTPUT);
> 170         state =3D (state >> pin) & 0x1;
> >>>     CID 1534919:  Error handling issues  (CHECKED_RETURN)
> >>>     Calling "visit_type_str" without checking return value (as is don=
e
> elsewhere 689 out of 740 times).
> 171         visit_type_str(v, name, (char **)&pin_state[state], errp);
> 172     }
>

This one is innocuous and need not be fixed (there are over 50 false
positive because generated code always checks the result and have written
code almost never needs to).

Paolo

174     static void pca9554_set_pin(Object *obj, Visitor *v, const char
> *name,
> 175                                 void *opaque, Error **errp)
> 176     {
>
>
>
>
> ** CID 1534917:  Integer handling issues  (BAD_SHIFT)
> /builds/bonzini/qemu/hw/misc/pca9554.c: 170 in pca9554_get_pin()
>
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 1534917:  Integer handling issues  (BAD_SHIFT)
> /builds/bonzini/qemu/hw/misc/pca9554.c: 170 in pca9554_get_pin()
> 164             error_setg(errp, "%s invalid pin %s", __func__, name);
> 165             return;
> 166         }
> 167
> 168         state =3D pca9554_read(s, PCA9554_CONFIG);
> 169         state |=3D pca9554_read(s, PCA9554_OUTPUT);
> >>>     CID 1534917:  Integer handling issues  (BAD_SHIFT)
> >>>     In expression "state >> pin", right shifting "state" by more than
> 7 bits always yields zero.  The shift amount, "pin", is as much as 8.
> 170         state =3D (state >> pin) & 0x1;
> 171         visit_type_str(v, name, (char **)&pin_state[state], errp);
> 172     }
> 173
> 174     static void pca9554_set_pin(Object *obj, Visitor *v, const char
> *name,
> 175                                 void *opaque, Error **errp)
>
>
>
> >
> > Paolo
> >
> >>   include/hw/misc/pca9554.h      |  36 ++++
> >>   include/hw/misc/pca9554_regs.h |  19 ++
> >>   4 files changed, 391 insertions(+), 2 deletions(-)
> >>   create mode 100644 hw/misc/pca9554.c
> >>   create mode 100644 include/hw/misc/pca9554.h
> >>   create mode 100644 include/hw/misc/pca9554_regs.h
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index dfaca8323e..51861e3c7d 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -1169,9 +1169,7 @@ R: Joel Stanley <joel@jms.id.au>
> >>   L: qemu-arm@nongnu.org
> >>   S: Maintained
> >>   F: hw/*/*aspeed*
> >> -F: hw/misc/pca9552.c
> >>   F: include/hw/*/*aspeed*
> >> -F: include/hw/misc/pca9552*.h
> >>   F: hw/net/ftgmac100.c
> >>   F: include/hw/net/ftgmac100.h
> >>   F: docs/system/arm/aspeed.rst
> >> @@ -1540,6 +1538,14 @@ F: include/hw/pci-host/pnv*
> >>   F: pc-bios/skiboot.lid
> >>   F: tests/qtest/pnv*
> >> +pca955x
> >> +M: Glenn Miles <milesg@linux.vnet.ibm.com>
> >> +L: qemu-ppc@nongnu.org
> >> +L: qemu-arm@nongnu.org
> >> +S: Odd Fixes
> >> +F: hw/misc/pca955*.c
> >> +F: include/hw/misc/pca955*.h
> >> +
> >>   virtex_ml507
> >>   M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> >>   L: qemu-ppc@nongnu.org
> >> diff --git a/hw/misc/pca9554.c b/hw/misc/pca9554.c
> >> new file mode 100644
> >> index 0000000000..778b32e443
> >> --- /dev/null
> >> +++ b/hw/misc/pca9554.c
> >> @@ -0,0 +1,328 @@
> >> +/*
> >> + * PCA9554 I/O port
> >> + *
> >> + * Copyright (c) 2023, IBM Corporation.
> >> + *
> >> + * SPDX-License-Identifier: GPL-2.0-or-later
> >> + */
> >> +
> >> +#include "qemu/osdep.h"
> >> +#include "qemu/log.h"
> >> +#include "qemu/module.h"
> >> +#include "qemu/bitops.h"
> >> +#include "hw/qdev-properties.h"
> >> +#include "hw/misc/pca9554.h"
> >> +#include "hw/misc/pca9554_regs.h"
> >> +#include "hw/irq.h"
> >> +#include "migration/vmstate.h"
> >> +#include "qapi/error.h"
> >> +#include "qapi/visitor.h"
> >> +#include "trace.h"
> >> +#include "qom/object.h"
> >> +
> >> +struct PCA9554Class {
> >> +    /*< private >*/
> >> +    I2CSlaveClass parent_class;
> >> +    /*< public >*/
> >> +};
> >> +typedef struct PCA9554Class PCA9554Class;
> >> +
> >> +DECLARE_CLASS_CHECKERS(PCA9554Class, PCA9554,
> >> +                       TYPE_PCA9554)
> >> +
> >> +#define PCA9554_PIN_LOW  0x0
> >> +#define PCA9554_PIN_HIZ  0x1
> >> +
> >> +static const char *pin_state[] =3D {"low", "high"};
> >> +
> >> +static void pca9554_update_pin_input(PCA9554State *s)
> >> +{
> >> +    int i;
> >> +    uint8_t config =3D s->regs[PCA9554_CONFIG];
> >> +    uint8_t output =3D s->regs[PCA9554_OUTPUT];
> >> +    uint8_t internal_state =3D config | output;
> >> +
> >> +    for (i =3D 0; i < PCA9554_PIN_COUNT; i++) {
> >> +        uint8_t bit_mask =3D 1 << i;
> >> +        uint8_t internal_pin_state =3D (internal_state >> i) & 0x1;
> >> +        uint8_t old_value =3D s->regs[PCA9554_INPUT] & bit_mask;
> >> +        uint8_t new_value;
> >> +
> >> +        switch (internal_pin_state) {
> >> +        case PCA9554_PIN_LOW:
> >> +            s->regs[PCA9554_INPUT] &=3D ~bit_mask;
> >> +            break;
> >> +        case PCA9554_PIN_HIZ:
> >> +            /*
> >> +             * pullup sets it to a logical 1 unless
> >> +             * external device drives it low.
> >> +             */
> >> +            if (s->ext_state[i] =3D=3D PCA9554_PIN_LOW) {
> >> +                s->regs[PCA9554_INPUT] &=3D ~bit_mask;
> >> +            } else {
> >> +                s->regs[PCA9554_INPUT] |=3D  bit_mask;
> >> +            }
> >> +            break;
> >> +        default:
> >> +            break;
> >> +        }
> >> +
> >> +        /* update irq state only if pin state changed */
> >> +        new_value =3D s->regs[PCA9554_INPUT] & bit_mask;
> >> +        if (new_value !=3D old_value) {
> >> +            if (new_value) {
> >> +                /* changed from 0 to 1 */
> >> +                qemu_set_irq(s->gpio_out[i], 1);
> >> +            } else {
> >> +                /* changed from 1 to 0 */
> >> +                qemu_set_irq(s->gpio_out[i], 0);
> >> +            }
> >> +        }
> >> +    }
> >> +}
> >> +
> >> +static uint8_t pca9554_read(PCA9554State *s, uint8_t reg)
> >> +{
> >> +    switch (reg) {
> >> +    case PCA9554_INPUT:
> >> +        return s->regs[PCA9554_INPUT] ^ s->regs[PCA9554_POLARITY];
> >> +    case PCA9554_OUTPUT:
> >> +    case PCA9554_POLARITY:
> >> +    case PCA9554_CONFIG:
> >> +        return s->regs[reg];
> >> +    default:
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: unexpected read to
> register %d\n",
> >> +                      __func__, reg);
> >> +        return 0xFF;
> >> +    }
> >> +}
> >> +
> >> +static void pca9554_write(PCA9554State *s, uint8_t reg, uint8_t data)
> >> +{
> >> +    switch (reg) {
> >> +    case PCA9554_OUTPUT:
> >> +    case PCA9554_CONFIG:
> >> +        s->regs[reg] =3D data;
> >> +        pca9554_update_pin_input(s);
> >> +        break;
> >> +    case PCA9554_POLARITY:
> >> +        s->regs[reg] =3D data;
> >> +        break;
> >> +    case PCA9554_INPUT:
> >> +    default:
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: unexpected write to
> register %d\n",
> >> +                      __func__, reg);
> >> +    }
> >> +}
> >> +
> >> +static uint8_t pca9554_recv(I2CSlave *i2c)
> >> +{
> >> +    PCA9554State *s =3D PCA9554(i2c);
> >> +    uint8_t ret;
> >> +
> >> +    ret =3D pca9554_read(s, s->pointer & 0x3);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static int pca9554_send(I2CSlave *i2c, uint8_t data)
> >> +{
> >> +    PCA9554State *s =3D PCA9554(i2c);
> >> +
> >> +    /* First byte sent by is the register address */
> >> +    if (s->len =3D=3D 0) {
> >> +        s->pointer =3D data;
> >> +        s->len++;
> >> +    } else {
> >> +        pca9554_write(s, s->pointer & 0x3, data);
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int pca9554_event(I2CSlave *i2c, enum i2c_event event)
> >> +{
> >> +    PCA9554State *s =3D PCA9554(i2c);
> >> +
> >> +    s->len =3D 0;
> >> +    return 0;
> >> +}
> >> +
> >> +static void pca9554_get_pin(Object *obj, Visitor *v, const char *name=
,
> >> +                            void *opaque, Error **errp)
> >> +{
> >> +    PCA9554State *s =3D PCA9554(obj);
> >> +    int pin, rc;
> >> +    uint8_t state;
> >> +
> >> +    rc =3D sscanf(name, "pin%2d", &pin);
> >> +    if (rc !=3D 1) {
> >> +        error_setg(errp, "%s: error reading %s", __func__, name);
> >> +        return;
> >> +    }
> >> +    if (pin < 0 || pin > PCA9554_PIN_COUNT) {
> >> +        error_setg(errp, "%s invalid pin %s", __func__, name);
> >> +        return;
> >> +    }
> >> +
> >> +    state =3D pca9554_read(s, PCA9554_CONFIG);
> >> +    state |=3D pca9554_read(s, PCA9554_OUTPUT);
> >> +    state =3D (state >> pin) & 0x1;
> >> +    visit_type_str(v, name, (char **)&pin_state[state], errp);
> >> +}
> >> +
> >> +static void pca9554_set_pin(Object *obj, Visitor *v, const char *name=
,
> >> +                            void *opaque, Error **errp)
> >> +{
> >> +    PCA9554State *s =3D PCA9554(obj);
> >> +    int pin, rc, val;
> >> +    uint8_t state, mask;
> >> +    char *state_str;
> >> +
> >> +    if (!visit_type_str(v, name, &state_str, errp)) {
> >> +        return;
> >> +    }
> >> +    rc =3D sscanf(name, "pin%2d", &pin);
> >> +    if (rc !=3D 1) {
> >> +        error_setg(errp, "%s: error reading %s", __func__, name);
> >> +        return;
> >> +    }
> >> +    if (pin < 0 || pin > PCA9554_PIN_COUNT) {
> >> +        error_setg(errp, "%s invalid pin %s", __func__, name);
> >> +        return;
> >> +    }
> >> +
> >> +    for (state =3D 0; state < ARRAY_SIZE(pin_state); state++) {
> >> +        if (!strcmp(state_str, pin_state[state])) {
> >> +            break;
> >> +        }
> >> +    }
> >> +    if (state >=3D ARRAY_SIZE(pin_state)) {
> >> +        error_setg(errp, "%s invalid pin state %s", __func__,
> state_str);
> >> +        return;
> >> +    }
> >> +
> >> +    /* First, modify the output register bit */
> >> +    val =3D pca9554_read(s, PCA9554_OUTPUT);
> >> +    mask =3D 0x1 << pin;
> >> +    if (state =3D=3D PCA9554_PIN_LOW) {
> >> +        val &=3D ~(mask);
> >> +    } else {
> >> +        val |=3D mask;
> >> +    }
> >> +    pca9554_write(s, PCA9554_OUTPUT, val);
> >> +
> >> +    /* Then, clear the config register bit for output mode */
> >> +    val =3D pca9554_read(s, PCA9554_CONFIG);
> >> +    val &=3D ~mask;
> >> +    pca9554_write(s, PCA9554_CONFIG, val);
> >> +}
> >> +
> >> +static const VMStateDescription pca9554_vmstate =3D {
> >> +    .name =3D "PCA9554",
> >> +    .version_id =3D 0,
> >> +    .minimum_version_id =3D 0,
> >> +    .fields =3D (VMStateField[]) {
> >> +        VMSTATE_UINT8(len, PCA9554State),
> >> +        VMSTATE_UINT8(pointer, PCA9554State),
> >> +        VMSTATE_UINT8_ARRAY(regs, PCA9554State, PCA9554_NR_REGS),
> >> +        VMSTATE_UINT8_ARRAY(ext_state, PCA9554State,
> PCA9554_PIN_COUNT),
> >> +        VMSTATE_I2C_SLAVE(i2c, PCA9554State),
> >> +        VMSTATE_END_OF_LIST()
> >> +    }
> >> +};
> >> +
> >> +static void pca9554_reset(DeviceState *dev)
> >> +{
> >> +    PCA9554State *s =3D PCA9554(dev);
> >> +
> >> +    s->regs[PCA9554_INPUT] =3D 0xFF;
> >> +    s->regs[PCA9554_OUTPUT] =3D 0xFF;
> >> +    s->regs[PCA9554_POLARITY] =3D 0x0; /* No pins are inverted */
> >> +    s->regs[PCA9554_CONFIG] =3D 0xFF; /* All pins are inputs */
> >> +
> >> +    memset(s->ext_state, PCA9554_PIN_HIZ, PCA9554_PIN_COUNT);
> >> +    pca9554_update_pin_input(s);
> >> +
> >> +    s->pointer =3D 0x0;
> >> +    s->len =3D 0;
> >> +}
> >> +
> >> +static void pca9554_initfn(Object *obj)
> >> +{
> >> +    int pin;
> >> +
> >> +    for (pin =3D 0; pin < PCA9554_PIN_COUNT; pin++) {
> >> +        char *name;
> >> +
> >> +        name =3D g_strdup_printf("pin%d", pin);
> >> +        object_property_add(obj, name, "bool", pca9554_get_pin,
> pca9554_set_pin,
> >> +                            NULL, NULL);
> >> +        g_free(name);
> >> +    }
> >> +}
> >> +
> >> +static void pca9554_set_ext_state(PCA9554State *s, int pin, int level=
)
> >> +{
> >> +    if (s->ext_state[pin] !=3D level) {
> >> +        s->ext_state[pin] =3D level;
> >> +        pca9554_update_pin_input(s);
> >> +    }
> >> +}
> >> +
> >> +static void pca9554_gpio_in_handler(void *opaque, int pin, int level)
> >> +{
> >> +
> >> +    PCA9554State *s =3D PCA9554(opaque);
> >> +
> >> +    assert((pin >=3D 0) && (pin < PCA9554_PIN_COUNT));
> >> +    pca9554_set_ext_state(s, pin, level);
> >> +}
> >> +
> >> +static void pca9554_realize(DeviceState *dev, Error **errp)
> >> +{
> >> +    PCA9554State *s =3D PCA9554(dev);
> >> +
> >> +    if (!s->description) {
> >> +        s->description =3D g_strdup("pca9554");
> >> +    }
> >> +
> >> +    qdev_init_gpio_out(dev, s->gpio_out, PCA9554_PIN_COUNT);
> >> +    qdev_init_gpio_in(dev, pca9554_gpio_in_handler, PCA9554_PIN_COUNT=
);
> >> +}
> >> +
> >> +static Property pca9554_properties[] =3D {
> >> +    DEFINE_PROP_STRING("description", PCA9554State, description),
> >> +    DEFINE_PROP_END_OF_LIST(),
> >> +};
> >> +
> >> +static void pca9554_class_init(ObjectClass *klass, void *data)
> >> +{
> >> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >> +    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
> >> +
> >> +    k->event =3D pca9554_event;
> >> +    k->recv =3D pca9554_recv;
> >> +    k->send =3D pca9554_send;
> >> +    dc->realize =3D pca9554_realize;
> >> +    dc->reset =3D pca9554_reset;
> >> +    dc->vmsd =3D &pca9554_vmstate;
> >> +    device_class_set_props(dc, pca9554_properties);
> >> +}
> >> +
> >> +static const TypeInfo pca9554_info =3D {
> >> +    .name          =3D TYPE_PCA9554,
> >> +    .parent        =3D TYPE_I2C_SLAVE,
> >> +    .instance_init =3D pca9554_initfn,
> >> +    .instance_size =3D sizeof(PCA9554State),
> >> +    .class_init    =3D pca9554_class_init,
> >> +    .class_size    =3D sizeof(PCA9554Class),
> >> +    .abstract      =3D false,
> >> +};
> >> +
> >> +static void pca9554_register_types(void)
> >> +{
> >> +    type_register_static(&pca9554_info);
> >> +}
> >> +
> >> +type_init(pca9554_register_types)
> >> diff --git a/include/hw/misc/pca9554.h b/include/hw/misc/pca9554.h
> >> new file mode 100644
> >> index 0000000000..54bfc4c4c7
> >> --- /dev/null
> >> +++ b/include/hw/misc/pca9554.h
> >> @@ -0,0 +1,36 @@
> >> +/*
> >> + * PCA9554 I/O port
> >> + *
> >> + * Copyright (c) 2023, IBM Corporation.
> >> + *
> >> + * SPDX-License-Identifier: GPL-2.0-or-later
> >> + */
> >> +#ifndef PCA9554_H
> >> +#define PCA9554_H
> >> +
> >> +#include "hw/i2c/i2c.h"
> >> +#include "qom/object.h"
> >> +
> >> +#define TYPE_PCA9554 "pca9554"
> >> +typedef struct PCA9554State PCA9554State;
> >> +DECLARE_INSTANCE_CHECKER(PCA9554State, PCA9554,
> >> +                         TYPE_PCA9554)
> >> +
> >> +#define PCA9554_NR_REGS 4
> >> +#define PCA9554_PIN_COUNT 8
> >> +
> >> +struct PCA9554State {
> >> +    /*< private >*/
> >> +    I2CSlave i2c;
> >> +    /*< public >*/
> >> +
> >> +    uint8_t len;
> >> +    uint8_t pointer;
> >> +
> >> +    uint8_t regs[PCA9554_NR_REGS];
> >> +    qemu_irq gpio_out[PCA9554_PIN_COUNT];
> >> +    uint8_t ext_state[PCA9554_PIN_COUNT];
> >> +    char *description; /* For debugging purpose only */
> >> +};
> >> +
> >> +#endif
> >> diff --git a/include/hw/misc/pca9554_regs.h
> b/include/hw/misc/pca9554_regs.h
> >> new file mode 100644
> >> index 0000000000..602c4a90e0
> >> --- /dev/null
> >> +++ b/include/hw/misc/pca9554_regs.h
> >> @@ -0,0 +1,19 @@
> >> +/*
> >> + * PCA9554 I/O port registers
> >> + *
> >> + * Copyright (c) 2023, IBM Corporation.
> >> + *
> >> + * SPDX-License-Identifier: GPL-2.0-or-later
> >> + */
> >> +#ifndef PCA9554_REGS_H
> >> +#define PCA9554_REGS_H
> >> +
> >> +/*
> >> + * Bits [0:1] are used to address a specific register.
> >> + */
> >> +#define PCA9554_INPUT       0 /* read only input register */
> >> +#define PCA9554_OUTPUT      1 /* read/write pin output state */
> >> +#define PCA9554_POLARITY    2 /* Set polarity of input register */
> >> +#define PCA9554_CONFIG      3 /* Set pins as inputs our ouputs */
> >> +
> >> +#endif
> >
>
>

--00000000000076999c0612f257cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 5 mar 2024, 07:26 C=C3=A9dric Le Goater &lt;<a =
href=3D"mailto:clg@kaod.org">clg@kaod.org</a>&gt; ha scritto:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">** CID 1534919:=C2=A0 Error handling issues=C2=
=A0 (CHECKED_RETURN)<br>
/builds/bonzini/qemu/hw/misc/pca9554.c: 171 in pca9554_get_pin()<br>
<br>
<br>
___________________________________________________________________________=
_____________________________<br>
*** CID 1534919:=C2=A0 Error handling issues=C2=A0 (CHECKED_RETURN)<br>
/builds/bonzini/qemu/hw/misc/pca9554.c: 171 in pca9554_get_pin()<br>
165=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
166=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
167<br>
168=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0state =3D pca9554_read(s, PCA9554_CONF=
IG);<br>
169=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0state |=3D pca9554_read(s, PCA9554_OUT=
PUT);<br>
170=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0state =3D (state &gt;&gt; pin) &amp; 0=
x1;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0CID 1534919:=C2=A0 Error handling issues=C2=
=A0 (CHECKED_RETURN)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Calling &quot;visit_type_str&quot; without =
checking return value (as is done elsewhere 689 out of 740 times).<br>
171=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0visit_type_str(v, name, (char **)&amp;=
pin_state[state], errp);<br>
172=C2=A0 =C2=A0 =C2=A0}<br></blockquote></div></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">This one is innocuous and need not be fixed (there =
are over 50 false positive because generated code always checks the result =
and have written code almost never needs to).</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
174=C2=A0 =C2=A0 =C2=A0static void pca9554_set_pin(Object *obj, Visitor *v,=
 const char *name,<br>
175=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque, Error **errp)=
<br>
176=C2=A0 =C2=A0 =C2=A0{<br>
<br>
<br>
<br>
<br>
** CID 1534917:=C2=A0 Integer handling issues=C2=A0 (BAD_SHIFT)<br>
/builds/bonzini/qemu/hw/misc/pca9554.c: 170 in pca9554_get_pin()<br>
<br>
<br>
___________________________________________________________________________=
_____________________________<br>
*** CID 1534917:=C2=A0 Integer handling issues=C2=A0 (BAD_SHIFT)<br>
/builds/bonzini/qemu/hw/misc/pca9554.c: 170 in pca9554_get_pin()<br>
164=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;%=
s invalid pin %s&quot;, __func__, name);<br>
165=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
166=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
167<br>
168=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0state =3D pca9554_read(s, PCA9554_CONF=
IG);<br>
169=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0state |=3D pca9554_read(s, PCA9554_OUT=
PUT);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0CID 1534917:=C2=A0 Integer handling issues=
=C2=A0 (BAD_SHIFT)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0In expression &quot;state &gt;&gt; pin&quot=
;, right shifting &quot;state&quot; by more than 7 bits always yields zero.=
=C2=A0 The shift amount, &quot;pin&quot;, is as much as 8.<br>
170=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0state =3D (state &gt;&gt; pin) &amp; 0=
x1;<br>
171=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0visit_type_str(v, name, (char **)&amp;=
pin_state[state], errp);<br>
172=C2=A0 =C2=A0 =C2=A0}<br>
173<br>
174=C2=A0 =C2=A0 =C2=A0static void pca9554_set_pin(Object *obj, Visitor *v,=
 const char *name,<br>
175=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque, Error **errp)=
<br>
<br>
<br>
<br>
&gt; <br>
&gt; Paolo<br>
&gt; <br>
&gt;&gt; =C2=A0 include/hw/misc/pca9554.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 36 ++++<br>
&gt;&gt; =C2=A0 include/hw/misc/pca9554_regs.h |=C2=A0 19 ++<br>
&gt;&gt; =C2=A0 4 files changed, 391 insertions(+), 2 deletions(-)<br>
&gt;&gt; =C2=A0 create mode 100644 hw/misc/pca9554.c<br>
&gt;&gt; =C2=A0 create mode 100644 include/hw/misc/pca9554.h<br>
&gt;&gt; =C2=A0 create mode 100644 include/hw/misc/pca9554_regs.h<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt;&gt; index dfaca8323e..51861e3c7d 100644<br>
&gt;&gt; --- a/MAINTAINERS<br>
&gt;&gt; +++ b/MAINTAINERS<br>
&gt;&gt; @@ -1169,9 +1169,7 @@ R: Joel Stanley &lt;<a href=3D"mailto:joel@j=
ms.id.au" target=3D"_blank" rel=3D"noreferrer">joel@jms.id.au</a>&gt;<br>
&gt;&gt; =C2=A0 L: <a href=3D"mailto:qemu-arm@nongnu.org" target=3D"_blank"=
 rel=3D"noreferrer">qemu-arm@nongnu.org</a><br>
&gt;&gt; =C2=A0 S: Maintained<br>
&gt;&gt; =C2=A0 F: hw/*/*aspeed*<br>
&gt;&gt; -F: hw/misc/pca9552.c<br>
&gt;&gt; =C2=A0 F: include/hw/*/*aspeed*<br>
&gt;&gt; -F: include/hw/misc/pca9552*.h<br>
&gt;&gt; =C2=A0 F: hw/net/ftgmac100.c<br>
&gt;&gt; =C2=A0 F: include/hw/net/ftgmac100.h<br>
&gt;&gt; =C2=A0 F: docs/system/arm/aspeed.rst<br>
&gt;&gt; @@ -1540,6 +1538,14 @@ F: include/hw/pci-host/pnv*<br>
&gt;&gt; =C2=A0 F: pc-bios/skiboot.lid<br>
&gt;&gt; =C2=A0 F: tests/qtest/pnv*<br>
&gt;&gt; +pca955x<br>
&gt;&gt; +M: Glenn Miles &lt;<a href=3D"mailto:milesg@linux.vnet.ibm.com" t=
arget=3D"_blank" rel=3D"noreferrer">milesg@linux.vnet.ibm.com</a>&gt;<br>
&gt;&gt; +L: <a href=3D"mailto:qemu-ppc@nongnu.org" target=3D"_blank" rel=
=3D"noreferrer">qemu-ppc@nongnu.org</a><br>
&gt;&gt; +L: <a href=3D"mailto:qemu-arm@nongnu.org" target=3D"_blank" rel=
=3D"noreferrer">qemu-arm@nongnu.org</a><br>
&gt;&gt; +S: Odd Fixes<br>
&gt;&gt; +F: hw/misc/pca955*.c<br>
&gt;&gt; +F: include/hw/misc/pca955*.h<br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0 virtex_ml507<br>
&gt;&gt; =C2=A0 M: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@g=
mail.com" target=3D"_blank" rel=3D"noreferrer">edgar.iglesias@gmail.com</a>=
&gt;<br>
&gt;&gt; =C2=A0 L: <a href=3D"mailto:qemu-ppc@nongnu.org" target=3D"_blank"=
 rel=3D"noreferrer">qemu-ppc@nongnu.org</a><br>
&gt;&gt; diff --git a/hw/misc/pca9554.c b/hw/misc/pca9554.c<br>
&gt;&gt; new file mode 100644<br>
&gt;&gt; index 0000000000..778b32e443<br>
&gt;&gt; --- /dev/null<br>
&gt;&gt; +++ b/hw/misc/pca9554.c<br>
&gt;&gt; @@ -0,0 +1,328 @@<br>
&gt;&gt; +/*<br>
&gt;&gt; + * PCA9554 I/O port<br>
&gt;&gt; + *<br>
&gt;&gt; + * Copyright (c) 2023, IBM Corporation.<br>
&gt;&gt; + *<br>
&gt;&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;&gt; + */<br>
&gt;&gt; +<br>
&gt;&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt;&gt; +#include &quot;qemu/log.h&quot;<br>
&gt;&gt; +#include &quot;qemu/module.h&quot;<br>
&gt;&gt; +#include &quot;qemu/bitops.h&quot;<br>
&gt;&gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt;&gt; +#include &quot;hw/misc/pca9554.h&quot;<br>
&gt;&gt; +#include &quot;hw/misc/pca9554_regs.h&quot;<br>
&gt;&gt; +#include &quot;hw/irq.h&quot;<br>
&gt;&gt; +#include &quot;migration/vmstate.h&quot;<br>
&gt;&gt; +#include &quot;qapi/error.h&quot;<br>
&gt;&gt; +#include &quot;qapi/visitor.h&quot;<br>
&gt;&gt; +#include &quot;trace.h&quot;<br>
&gt;&gt; +#include &quot;qom/object.h&quot;<br>
&gt;&gt; +<br>
&gt;&gt; +struct PCA9554Class {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 /*&lt; private &gt;*/<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 I2CSlaveClass parent_class;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 /*&lt; public &gt;*/<br>
&gt;&gt; +};<br>
&gt;&gt; +typedef struct PCA9554Class PCA9554Class;<br>
&gt;&gt; +<br>
&gt;&gt; +DECLARE_CLASS_CHECKERS(PCA9554Class, PCA9554,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TYPE_=
PCA9554)<br>
&gt;&gt; +<br>
&gt;&gt; +#define PCA9554_PIN_LOW=C2=A0 0x0<br>
&gt;&gt; +#define PCA9554_PIN_HIZ=C2=A0 0x1<br>
&gt;&gt; +<br>
&gt;&gt; +static const char *pin_state[] =3D {&quot;low&quot;, &quot;high&q=
uot;};<br>
&gt;&gt; +<br>
&gt;&gt; +static void pca9554_update_pin_input(PCA9554State *s)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 int i;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint8_t config =3D s-&gt;regs[PCA9554_CONFIG];=
<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint8_t output =3D s-&gt;regs[PCA9554_OUTPUT];=
<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint8_t internal_state =3D config | output;<br=
>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i &lt; PCA9554_PIN_COUNT; i++) {=
<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t bit_mask =3D 1=
 &lt;&lt; i;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t internal_pin_s=
tate =3D (internal_state &gt;&gt; i) &amp; 0x1;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t old_value =3D =
s-&gt;regs[PCA9554_INPUT] &amp; bit_mask;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t new_value;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (internal_pin_s=
tate) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PCA9554_PIN_LOW:<=
br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 s-&gt;regs[PCA9554_INPUT] &amp;=3D ~bit_mask;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PCA9554_PIN_HIZ:<=
br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /*<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * pullup sets it to a logical 1 unless<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * external device drives it low.<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 */<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (s-&gt;ext_state[i] =3D=3D PCA9554_PIN_LOW) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 s-&gt;regs[PCA9554_INPUT] &amp;=3D ~bit_mask;<b=
r>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 } else {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 s-&gt;regs[PCA9554_INPUT] |=3D=C2=A0 bit_mask;<=
br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* update irq state on=
ly if pin state changed */<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_value =3D s-&gt;re=
gs[PCA9554_INPUT] &amp; bit_mask;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (new_value !=3D old=
_value) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (new_value) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* changed from 0 to 1 */<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_set_irq(s-&gt;gpio_out[i], 1);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 } else {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* changed from 1 to 0 */<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_set_irq(s-&gt;gpio_out[i], 0);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static uint8_t pca9554_read(PCA9554State *s, uint8_t reg)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 switch (reg) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 case PCA9554_INPUT:<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return s-&gt;regs[PCA9=
554_INPUT] ^ s-&gt;regs[PCA9554_POLARITY];<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 case PCA9554_OUTPUT:<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 case PCA9554_POLARITY:<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 case PCA9554_CONFIG:<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return s-&gt;regs[reg]=
;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 default:<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_log_mask(LOG_GUES=
T_ERROR, &quot;%s: unexpected read to register %d\n&quot;,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, r=
eg);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0xFF;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static void pca9554_write(PCA9554State *s, uint8_t reg, uint8_t d=
ata)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 switch (reg) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 case PCA9554_OUTPUT:<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 case PCA9554_CONFIG:<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s-&gt;regs[reg] =3D da=
ta;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pca9554_update_pin_inp=
ut(s);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 case PCA9554_POLARITY:<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s-&gt;regs[reg] =3D da=
ta;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 case PCA9554_INPUT:<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 default:<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_log_mask(LOG_GUES=
T_ERROR, &quot;%s: unexpected write to register %d\n&quot;,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, r=
eg);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static uint8_t pca9554_recv(I2CSlave *i2c)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 PCA9554State *s =3D PCA9554(i2c);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint8_t ret;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 ret =3D pca9554_read(s, s-&gt;pointer &amp; 0x=
3);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 return ret;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static int pca9554_send(I2CSlave *i2c, uint8_t data)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 PCA9554State *s =3D PCA9554(i2c);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* First byte sent by is the register address =
*/<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (s-&gt;len =3D=3D 0) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s-&gt;pointer =3D data=
;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s-&gt;len++;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 } else {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pca9554_write(s, s-&gt=
;pointer &amp; 0x3, data);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 return 0;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static int pca9554_event(I2CSlave *i2c, enum i2c_event event)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 PCA9554State *s =3D PCA9554(i2c);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 s-&gt;len =3D 0;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 return 0;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static void pca9554_get_pin(Object *obj, Visitor *v, const char *=
name,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 void *opaque, Error **errp)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 PCA9554State *s =3D PCA9554(obj);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 int pin, rc;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint8_t state;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 rc =3D sscanf(name, &quot;pin%2d&quot;, &amp;p=
in);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (rc !=3D 1) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, &quot=
;%s: error reading %s&quot;, __func__, name);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (pin &lt; 0 || pin &gt; PCA9554_PIN_COUNT) =
{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, &quot=
;%s invalid pin %s&quot;, __func__, name);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 state =3D pca9554_read(s, PCA9554_CONFIG);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 state |=3D pca9554_read(s, PCA9554_OUTPUT);<br=
>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 state =3D (state &gt;&gt; pin) &amp; 0x1;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 visit_type_str(v, name, (char **)&amp;pin_stat=
e[state], errp);<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static void pca9554_set_pin(Object *obj, Visitor *v, const char *=
name,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 void *opaque, Error **errp)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 PCA9554State *s =3D PCA9554(obj);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 int pin, rc, val;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint8_t state, mask;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 char *state_str;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (!visit_type_str(v, name, &amp;state_str, e=
rrp)) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 rc =3D sscanf(name, &quot;pin%2d&quot;, &amp;p=
in);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (rc !=3D 1) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, &quot=
;%s: error reading %s&quot;, __func__, name);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (pin &lt; 0 || pin &gt; PCA9554_PIN_COUNT) =
{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, &quot=
;%s invalid pin %s&quot;, __func__, name);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 for (state =3D 0; state &lt; ARRAY_SIZE(pin_st=
ate); state++) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!strcmp(state_str,=
 pin_state[state])) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (state &gt;=3D ARRAY_SIZE(pin_state)) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, &quot=
;%s invalid pin state %s&quot;, __func__, state_str);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* First, modify the output register bit */<br=
>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 val =3D pca9554_read(s, PCA9554_OUTPUT);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 mask =3D 0x1 &lt;&lt; pin;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (state =3D=3D PCA9554_PIN_LOW) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val &amp;=3D ~(mask);<=
br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 } else {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val |=3D mask;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 pca9554_write(s, PCA9554_OUTPUT, val);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* Then, clear the config register bit for out=
put mode */<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 val =3D pca9554_read(s, PCA9554_CONFIG);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 val &amp;=3D ~mask;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 pca9554_write(s, PCA9554_CONFIG, val);<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static const VMStateDescription pca9554_vmstate =3D {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 .name =3D &quot;PCA9554&quot;,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 .version_id =3D 0,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 .minimum_version_id =3D 0,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 .fields =3D (VMStateField[]) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT8(len, PCA=
9554State),<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT8(pointer,=
 PCA9554State),<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT8_ARRAY(re=
gs, PCA9554State, PCA9554_NR_REGS),<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT8_ARRAY(ex=
t_state, PCA9554State, PCA9554_PIN_COUNT),<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_I2C_SLAVE(i2c,=
 PCA9554State),<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_END_OF_LIST()<=
br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +static void pca9554_reset(DeviceState *dev)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 PCA9554State *s =3D PCA9554(dev);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 s-&gt;regs[PCA9554_INPUT] =3D 0xFF;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 s-&gt;regs[PCA9554_OUTPUT] =3D 0xFF;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 s-&gt;regs[PCA9554_POLARITY] =3D 0x0; /* No pi=
ns are inverted */<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 s-&gt;regs[PCA9554_CONFIG] =3D 0xFF; /* All pi=
ns are inputs */<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 memset(s-&gt;ext_state, PCA9554_PIN_HIZ, PCA95=
54_PIN_COUNT);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 pca9554_update_pin_input(s);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 s-&gt;pointer =3D 0x0;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 s-&gt;len =3D 0;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static void pca9554_initfn(Object *obj)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 int pin;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 for (pin =3D 0; pin &lt; PCA9554_PIN_COUNT; pi=
n++) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *name;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D g_strdup_prin=
tf(&quot;pin%d&quot;, pin);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_add(ob=
j, name, &quot;bool&quot;, pca9554_get_pin, pca9554_set_pin,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 NULL, NULL);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(name);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static void pca9554_set_ext_state(PCA9554State *s, int pin, int l=
evel)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (s-&gt;ext_state[pin] !=3D level) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s-&gt;ext_state[pin] =
=3D level;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pca9554_update_pin_inp=
ut(s);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static void pca9554_gpio_in_handler(void *opaque, int pin, int le=
vel)<br>
&gt;&gt; +{<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 PCA9554State *s =3D PCA9554(opaque);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 assert((pin &gt;=3D 0) &amp;&amp; (pin &lt; PC=
A9554_PIN_COUNT));<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 pca9554_set_ext_state(s, pin, level);<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static void pca9554_realize(DeviceState *dev, Error **errp)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 PCA9554State *s =3D PCA9554(dev);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (!s-&gt;description) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s-&gt;description =3D =
g_strdup(&quot;pca9554&quot;);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 qdev_init_gpio_out(dev, s-&gt;gpio_out, PCA955=
4_PIN_COUNT);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 qdev_init_gpio_in(dev, pca9554_gpio_in_handler=
, PCA9554_PIN_COUNT);<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static Property pca9554_properties[] =3D {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_STRING(&quot;description&quot;, PC=
A9554State, description),<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +static void pca9554_class_init(ObjectClass *klass, void *data)<br=
>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);<b=
r>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 k-&gt;event =3D pca9554_event;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 k-&gt;recv =3D pca9554_recv;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 k-&gt;send =3D pca9554_send;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 dc-&gt;realize =3D pca9554_realize;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 dc-&gt;reset =3D pca9554_reset;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 dc-&gt;vmsd =3D &amp;pca9554_vmstate;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 device_class_set_props(dc, pca9554_properties)=
;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static const TypeInfo pca9554_info =3D {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D TYPE_PCA9554,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 .parent=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D TYPE_I2C_SLAVE,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 .instance_init =3D pca9554_initfn,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 .instance_size =3D sizeof(PCA9554State),<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 .class_init=C2=A0=C2=A0=C2=A0 =3D pca9554_clas=
s_init,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 .class_size=C2=A0=C2=A0=C2=A0 =3D sizeof(PCA95=
54Class),<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 .abstract=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D fa=
lse,<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +static void pca9554_register_types(void)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 type_register_static(&amp;pca9554_info);<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +type_init(pca9554_register_types)<br>
&gt;&gt; diff --git a/include/hw/misc/pca9554.h b/include/hw/misc/pca9554.h=
<br>
&gt;&gt; new file mode 100644<br>
&gt;&gt; index 0000000000..54bfc4c4c7<br>
&gt;&gt; --- /dev/null<br>
&gt;&gt; +++ b/include/hw/misc/pca9554.h<br>
&gt;&gt; @@ -0,0 +1,36 @@<br>
&gt;&gt; +/*<br>
&gt;&gt; + * PCA9554 I/O port<br>
&gt;&gt; + *<br>
&gt;&gt; + * Copyright (c) 2023, IBM Corporation.<br>
&gt;&gt; + *<br>
&gt;&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;&gt; + */<br>
&gt;&gt; +#ifndef PCA9554_H<br>
&gt;&gt; +#define PCA9554_H<br>
&gt;&gt; +<br>
&gt;&gt; +#include &quot;hw/i2c/i2c.h&quot;<br>
&gt;&gt; +#include &quot;qom/object.h&quot;<br>
&gt;&gt; +<br>
&gt;&gt; +#define TYPE_PCA9554 &quot;pca9554&quot;<br>
&gt;&gt; +typedef struct PCA9554State PCA9554State;<br>
&gt;&gt; +DECLARE_INSTANCE_CHECKER(PCA9554State, PCA9554,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 TYPE_PCA9554)<br>
&gt;&gt; +<br>
&gt;&gt; +#define PCA9554_NR_REGS 4<br>
&gt;&gt; +#define PCA9554_PIN_COUNT 8<br>
&gt;&gt; +<br>
&gt;&gt; +struct PCA9554State {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 /*&lt; private &gt;*/<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 I2CSlave i2c;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 /*&lt; public &gt;*/<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint8_t len;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint8_t pointer;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint8_t regs[PCA9554_NR_REGS];<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_irq gpio_out[PCA9554_PIN_COUNT];<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint8_t ext_state[PCA9554_PIN_COUNT];<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 char *description; /* For debugging purpose on=
ly */<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +#endif<br>
&gt;&gt; diff --git a/include/hw/misc/pca9554_regs.h b/include/hw/misc/pca9=
554_regs.h<br>
&gt;&gt; new file mode 100644<br>
&gt;&gt; index 0000000000..602c4a90e0<br>
&gt;&gt; --- /dev/null<br>
&gt;&gt; +++ b/include/hw/misc/pca9554_regs.h<br>
&gt;&gt; @@ -0,0 +1,19 @@<br>
&gt;&gt; +/*<br>
&gt;&gt; + * PCA9554 I/O port registers<br>
&gt;&gt; + *<br>
&gt;&gt; + * Copyright (c) 2023, IBM Corporation.<br>
&gt;&gt; + *<br>
&gt;&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;&gt; + */<br>
&gt;&gt; +#ifndef PCA9554_REGS_H<br>
&gt;&gt; +#define PCA9554_REGS_H<br>
&gt;&gt; +<br>
&gt;&gt; +/*<br>
&gt;&gt; + * Bits [0:1] are used to address a specific register.<br>
&gt;&gt; + */<br>
&gt;&gt; +#define PCA9554_INPUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 /* re=
ad only input register */<br>
&gt;&gt; +#define PCA9554_OUTPUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 /* read/wr=
ite pin output state */<br>
&gt;&gt; +#define PCA9554_POLARITY=C2=A0=C2=A0=C2=A0 2 /* Set polarity of i=
nput register */<br>
&gt;&gt; +#define PCA9554_CONFIG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3 /* Set pin=
s as inputs our ouputs */<br>
&gt;&gt; +<br>
&gt;&gt; +#endif<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--00000000000076999c0612f257cc--


