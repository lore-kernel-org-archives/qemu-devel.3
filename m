Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE782C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 08:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTHeg-0004O1-JG; Fri, 26 Jan 2024 03:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTHee-0004Nk-FD; Fri, 26 Jan 2024 03:33:40 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTHec-0007uu-BR; Fri, 26 Jan 2024 03:33:40 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TLrZ54pZlz4x80;
 Fri, 26 Jan 2024 19:33:33 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TLrZ14WWJz4x5l;
 Fri, 26 Jan 2024 19:33:29 +1100 (AEDT)
Message-ID: <116910db-f8bf-40ed-85ea-aac76ef6e92a@kaod.org>
Date: Fri, 26 Jan 2024 09:33:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/11] hw/fsi: Introduce IBM's scratchpad device
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20240126034026.31068-1-ninad@linux.ibm.com>
 <20240126034026.31068-3-ninad@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240126034026.31068-3-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=5gEp=JE=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 1/26/24 04:40, Ninad Palsule wrote:
> This is a part of patchset where IBM's Flexible Service Interface is
> introduced.
> 
> The scratchpad provides a set of non-functional registers. The firmware
> is free to use them, hardware does not support any special management
> support. The scratchpad registers can be read or written from LBUS
> slave. The scratch pad is managed under FSI CFAM state.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> [ clg: - moved object FSIScratchPad under FSICFAMState
>         - moved FSIScratchPad code under cfam.c ]
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   include/hw/fsi/lbus.h | 11 +++++++
>   hw/fsi/lbus.c         | 69 +++++++++++++++++++++++++++++++++++++++++++
>   hw/fsi/trace-events   |  2 ++
>   3 files changed, 82 insertions(+)
> 
> diff --git a/include/hw/fsi/lbus.h b/include/hw/fsi/lbus.h
> index e8a22e22a8..558268c013 100644
> --- a/include/hw/fsi/lbus.h
> +++ b/include/hw/fsi/lbus.h
> @@ -29,4 +29,15 @@ typedef struct FSILBus {
>       MemoryRegion mr;
>   } FSILBus;
>   
> +#define TYPE_FSI_SCRATCHPAD "fsi.scratchpad"
> +#define SCRATCHPAD(obj) OBJECT_CHECK(FSIScratchPad, (obj), TYPE_FSI_SCRATCHPAD)
> +
> +#define FSI_SCRATCHPAD_NR_REGS 4
> +
> +typedef struct FSIScratchPad {
> +        FSILBusDevice parent;
> +
> +        uint32_t regs[FSI_SCRATCHPAD_NR_REGS];
> +} FSIScratchPad;
> +
>   #endif /* FSI_LBUS_H */
> diff --git a/hw/fsi/lbus.c b/hw/fsi/lbus.c
> index 44d2319087..5ab7d0a741 100644
> --- a/hw/fsi/lbus.c
> +++ b/hw/fsi/lbus.c
> @@ -13,6 +13,8 @@
>   
>   #include "trace.h"
>   
> +#define TO_REG(offset) ((offset) >> 2)
> +
>   static void fsi_lbus_init(Object *o)
>   {
>       FSILBus *lbus = FSI_LBUS(o);
> @@ -34,10 +36,77 @@ static const TypeInfo fsi_lbus_device_type_info = {
>       .abstract = true,
>   };
>   
> +static uint64_t fsi_scratchpad_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    FSIScratchPad *s = SCRATCHPAD(opaque);
> +    int reg = TO_REG(addr);
> +
> +    trace_fsi_scratchpad_read(addr, size);
> +
> +    if (reg >= FSI_SCRATCHPAD_NR_REGS) {

usually, the model logs a GUEST_ERROR in such case, specially when the MMIO
window is larger than the register set. Same comment for the write memop.

with that,
  
Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.



> +        return 0;
> +    }
> +
> +    return s->regs[reg];
> +}
> +
> +static void fsi_scratchpad_write(void *opaque, hwaddr addr, uint64_t data,
> +                                 unsigned size)
> +{
> +    FSIScratchPad *s = SCRATCHPAD(opaque);
> +
> +    trace_fsi_scratchpad_write(addr, size, data);
> +    int reg = TO_REG(addr);
> +
> +    if (reg >= FSI_SCRATCHPAD_NR_REGS) {
> +        return;
> +    }
> +
> +    s->regs[reg] = data;
> +}
> +
> +static const struct MemoryRegionOps scratchpad_ops = {
> +    .read = fsi_scratchpad_read,
> +    .write = fsi_scratchpad_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static void fsi_scratchpad_realize(DeviceState *dev, Error **errp)
> +{
> +    FSILBusDevice *ldev = FSI_LBUS_DEVICE(dev);
> +
> +    memory_region_init_io(&ldev->iomem, OBJECT(ldev), &scratchpad_ops,
> +                          ldev, TYPE_FSI_SCRATCHPAD, 0x400);
> +}
> +
> +static void fsi_scratchpad_reset(DeviceState *dev)
> +{
> +    FSIScratchPad *s = SCRATCHPAD(dev);
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +}
> +
> +static void fsi_scratchpad_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->bus_type = TYPE_FSI_LBUS;
> +    dc->realize = fsi_scratchpad_realize;
> +    dc->reset = fsi_scratchpad_reset;
> +}
> +
> +static const TypeInfo fsi_scratchpad_info = {
> +    .name = TYPE_FSI_SCRATCHPAD,
> +    .parent = TYPE_FSI_LBUS_DEVICE,
> +    .instance_size = sizeof(FSIScratchPad),
> +    .class_init = fsi_scratchpad_class_init,
> +};
> +
>   static void fsi_lbus_register_types(void)
>   {
>       type_register_static(&fsi_lbus_info);
>       type_register_static(&fsi_lbus_device_type_info);
> +    type_register_static(&fsi_scratchpad_info);
>   }
>   
>   type_init(fsi_lbus_register_types);
> diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
> index e69de29bb2..c5753e2791 100644
> --- a/hw/fsi/trace-events
> +++ b/hw/fsi/trace-events
> @@ -0,0 +1,2 @@
> +fsi_scratchpad_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
> +fsi_scratchpad_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64


