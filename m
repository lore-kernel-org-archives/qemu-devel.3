Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE80E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 13:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVWUm-0005bb-Me; Wed, 08 Jan 2025 08:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tVWUj-0005Xu-VI; Wed, 08 Jan 2025 08:53:14 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tVWUh-0005lg-22; Wed, 08 Jan 2025 08:53:13 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E9E4B4E601D;
 Wed, 08 Jan 2025 14:53:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ZRt2igV2o-7v; Wed,  8 Jan 2025 14:53:03 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 066444E6010; Wed, 08 Jan 2025 14:53:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F399C746F60;
 Wed, 08 Jan 2025 14:53:02 +0100 (CET)
Date: Wed, 8 Jan 2025 14:53:02 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, 
 Fabiano Rosas <farosas@suse.de>, Guenter Roeck <linux@roeck-us.net>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, 
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 04/14] hw/core: Introduce TYPE_SHARED_IRQ
In-Reply-To: <20250108092538.11474-5-shentey@gmail.com>
Message-ID: <8c12f28d-ee24-d4dc-f472-a6fe2e401dee@eik.bme.hu>
References: <20250108092538.11474-1-shentey@gmail.com>
 <20250108092538.11474-5-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 8 Jan 2025, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> include/hw/core/shared-irq.h | 39 ++++++++++++++++
> hw/core/shared-irq.c         | 88 ++++++++++++++++++++++++++++++++++++
> hw/core/Kconfig              |  3 ++
> hw/core/meson.build          |  1 +
> 4 files changed, 131 insertions(+)
> create mode 100644 include/hw/core/shared-irq.h
> create mode 100644 hw/core/shared-irq.c
>
> diff --git a/include/hw/core/shared-irq.h b/include/hw/core/shared-irq.h
> new file mode 100644
> index 0000000000..803c303dd0
> --- /dev/null
> +++ b/include/hw/core/shared-irq.h
> @@ -0,0 +1,39 @@
> +/*
> + * IRQ sharing device.
> + *
> + * Copyright (c) 2025 Bernhard Beschow <shentey@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +/*
> + * This is a simple device which has one GPIO output line and multiple GPIO
> + * input lines. The output line is active if at least one of the input lines is.

How is this different from TYPE_OR_IRQ. Also or-irq.h is in 
include/hw/or-irq.h not in include/hw/core/ where split-irq.h is so maybe 
these could all be moved to one place for consistency? Or-irq also has a 
reset method, do you need one in this device?

Regards,
BALATON Zoltan

> + *
> + * QEMU interface:
> + *  + N unnamed GPIO inputs: the input lines
> + *  + one unnamed GPIO output: the output line
> + *  + QOM property "num-lines": sets the number of input lines
> + */
> +#ifndef HW_SHARED_IRQ_H
> +#define HW_SHARED_IRQ_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_SHARED_IRQ "shared-irq"
> +
> +#define MAX_SHARED_LINES 16
> +
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(SharedIRQ, SHARED_IRQ)
> +
> +struct SharedIRQ {
> +    DeviceState parent_obj;
> +
> +    qemu_irq out_irq;
> +    uint16_t irq_states;
> +    uint8_t num_lines;
> +};
> +
> +#endif
> diff --git a/hw/core/shared-irq.c b/hw/core/shared-irq.c
> new file mode 100644
> index 0000000000..b2a4ea4a66
> --- /dev/null
> +++ b/hw/core/shared-irq.c
> @@ -0,0 +1,88 @@
> +/*
> + * IRQ sharing device.
> + *
> + * Copyright (c) 2025 Bernhard Beschow <shentey@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/core/shared-irq.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-properties.h"
> +#include "qapi/error.h"
> +#include "migration/vmstate.h"
> +
> +static void shared_irq_handler(void *opaque, int n, int level)
> +{
> +    SharedIRQ *s = opaque;
> +    uint16_t mask = BIT(n);
> +
> +    if (level) {
> +        s->irq_states |= mask;
> +    } else {
> +        s->irq_states &= ~mask;
> +    }
> +
> +    qemu_set_irq(s->out_irq, !!s->irq_states);
> +}
> +
> +static void shared_irq_init(Object *obj)
> +{
> +    SharedIRQ *s = SHARED_IRQ(obj);
> +
> +    qdev_init_gpio_out(DEVICE(s), &s->out_irq, 1);
> +}
> +
> +static void shared_irq_realize(DeviceState *dev, Error **errp)
> +{
> +    SharedIRQ *s = SHARED_IRQ(dev);
> +
> +    if (s->num_lines < 1 || s->num_lines >= MAX_SHARED_LINES) {
> +        error_setg(errp,
> +                   "IRQ shared number of lines %d must be between 1 and %d",
> +                   s->num_lines, MAX_SHARED_LINES);
> +        return;
> +    }
> +
> +    qdev_init_gpio_in(dev, shared_irq_handler, s->num_lines);
> +}
> +
> +static const Property shared_irq_properties[] = {
> +    DEFINE_PROP_UINT8("num-lines", SharedIRQ, num_lines, 1),
> +};
> +
> +static const VMStateDescription shared_irq_vmstate = {
> +    .name = TYPE_SHARED_IRQ,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT16(irq_states, SharedIRQ),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static void shared_irq_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    /* No state to reset */
> +    device_class_set_props(dc, shared_irq_properties);
> +    dc->vmsd = &shared_irq_vmstate;
> +    dc->realize = shared_irq_realize;
> +
> +    /* Reason: Needs to be wired up to work */
> +    dc->user_creatable = false;
> +}
> +
> +static const TypeInfo shared_irq_types[] = {
> +    {
> +       .name = TYPE_SHARED_IRQ,
> +       .parent = TYPE_DEVICE,
> +       .instance_size = sizeof(SharedIRQ),
> +       .instance_init = shared_irq_init,
> +       .class_init = shared_irq_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(shared_irq_types)
> diff --git a/hw/core/Kconfig b/hw/core/Kconfig
> index d1bdf765ee..ddff977963 100644
> --- a/hw/core/Kconfig
> +++ b/hw/core/Kconfig
> @@ -32,6 +32,9 @@ config PLATFORM_BUS
> config REGISTER
>     bool
>
> +config SHARED_IRQ
> +    bool
> +
> config SPLIT_IRQ
>     bool
>
> diff --git a/hw/core/meson.build b/hw/core/meson.build
> index ce9dfa3f4b..6b5bdc8ec7 100644
> --- a/hw/core/meson.build
> +++ b/hw/core/meson.build
> @@ -21,6 +21,7 @@ system_ss.add(when: 'CONFIG_OR_IRQ', if_true: files('or-irq.c'))
> system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('platform-bus.c'))
> system_ss.add(when: 'CONFIG_PTIMER', if_true: files('ptimer.c'))
> system_ss.add(when: 'CONFIG_REGISTER', if_true: files('register.c'))
> +system_ss.add(when: 'CONFIG_SHARED_IRQ', if_true: files('shared-irq.c'))
> system_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq.c'))
> system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
> system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
>

