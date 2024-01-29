Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE2AC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 03:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUIAM-0008Qf-CK; Sun, 28 Jan 2024 22:18:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rUIAG-0008Nc-L3; Sun, 28 Jan 2024 22:18:28 -0500
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rUIAD-0004uW-Ry; Sun, 28 Jan 2024 22:18:28 -0500
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-46b0c8b26c7so328017137.3; 
 Sun, 28 Jan 2024 19:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706498303; x=1707103103; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XoKs3qFEosPM/Xhyhv6SSwlQNBw+wlSzh88p3IvsmeE=;
 b=B4DKPK1h0n9/hPxNZyoLGLVuU9LtK3DSsOizMgfOreWSFL3i4cu9xkYl5KtCpJUOp+
 DQ8hwMGGVgBUWPJXOoMIBudmlPy/k3G7Rr69cudoBeRj3eHLg7CafKH8KUmD4y8lYKlA
 +jxhxtxOfcOuwuP5JpcfA/woGhQRBWEPHf7JXtb7kof95OV/ehKrI7x9dBdxBO4a53CK
 +JBiZBdml99SJ2q4QxpQMCBPdV1Rwah8n0XDXXknHYaiRmjZ0nvhQYsGeMgnpIS1x4TW
 kCfl4lgxK+KBB3LBJar0UcC4PbKOa8A0X5SR60FRY0YxSnHi5fGLlGwkiCc1m2Ryys0J
 YWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706498303; x=1707103103;
 h=in-reply-to:references:cc:to:from:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XoKs3qFEosPM/Xhyhv6SSwlQNBw+wlSzh88p3IvsmeE=;
 b=O1J9pG0fK0f02dZjddkHaDChkP7hkV+5SATjpn9h5eTfUyB/4AtM2mtjlpcXJfr0Eb
 15yywxDnKz6dsSWS4HARTlSCf6y8exyNI2KjD/7WZKzrOA1+MTY77Bz3zaZ44Z3li+9o
 OkSRgOYiBkpV1M4nGgKSRunQSyC2qNGZqHPzIG/D0SexskQsBUKy/ZFMJxwlui/u6+vj
 NDJ/ORic8a2PUci6NAsmh6jJpEqYzwH9KWT8YdxgSJphkvhuwynfTmyWcqcBqVPCsZWw
 Hgjtcnt2mGbftNGeAQtwT5HO4ZblkDk70algSKLMVmtFddwwYrH920rz01RA39GeY50f
 hDtw==
X-Gm-Message-State: AOJu0YxqBE633Bvq5XAztE9wzsGjCGKTsq0DLhXnbADtOmPEpUai38vm
 xmmJZpiJhZyyZnM7rQ+nmdlQnJVZCTP091OF39sj+jTsVOF9W00AartxZNwRwuI=
X-Google-Smtp-Source: AGHT+IEnvnkpIoVvSskVQCDDJYf7ueDpbBkerkMEcMv3yOluHrvUQqQ99aCfUuqfCMNr/Pe3EoFKMQ==
X-Received: by 2002:a67:ee11:0:b0:469:ada6:7f4b with SMTP id
 f17-20020a67ee11000000b00469ada67f4bmr1795372vsp.26.1706498303541; 
 Sun, 28 Jan 2024 19:18:23 -0800 (PST)
Received: from ?IPV6:2800:d300:3800:764:e756:a826:b882:3a82?
 ([2800:d300:3800:764:e756:a826:b882:3a82])
 by smtp.gmail.com with ESMTPSA id
 ch23-20020a0561300c9700b007cd8acf7352sm783243uab.4.2024.01.28.19.18.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jan 2024 19:18:23 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------LOvCYjA74s46FQpvl1eYGAoJ"
Message-ID: <24e71a41-ea46-4478-b2fb-2c1251d7bfd0@gmail.com>
Date: Sun, 28 Jan 2024 21:18:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/45] Add BCM2838 PCIE host
Content-Language: en-US
From: Sergei Kambalin <serg.oker@gmail.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Sergey Kambalin <sergey.kambalin@auriga.com>
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-16-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-16-sergey.kambalin@auriga.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=serg.oker@gmail.com; helo=mail-vs1-xe34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This is a multi-part message in MIME format.
--------------LOvCYjA74s46FQpvl1eYGAoJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I'm not super familiar with how QEMU models PCI controllers, but I'm not 
sure this handling of the root port config registers is right. On other 
controllers it looks like the root config reads and writes are handled 
by setting the PCIDeviceClass::config_read and PCIDevice::config_write 
methods.
It's not only for config space access but also to configuration area beyond PCIE config space.
I'm going to split into two access methods:
1) bcm2838_pcie_config_{write,read}() for access to addresses within the config space. Will be assigned to the dev->config_write.
2) bcm2838_pcie_mmio_{write,read}() for access to addresses beyond the config space. Will be implemented as 'normal' MemoryRegionOps structure.

Isn't the important thing here not what guest software thinks, but what 
the actual hardware in this bcm2838 SoC implements ?

The thing is that the code is not fully abides the PCIe spec. It's been written mostly basing on kernel code and boot logs analysis.
That's why I think it worth to add a detailed comment why it was written that way.

On 12/7/23 20:31, Sergey Kambalin wrote:
> Signed-off-by: Sergey Kambalin<sergey.kambalin@auriga.com>
> ---
>   hw/arm/bcm2838_pcie.c         | 216 +++++++++++++++++++++++++++++++++-
>   include/hw/arm/bcm2838_pcie.h |  22 ++++
>   2 files changed, 236 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/bcm2838_pcie.c b/hw/arm/bcm2838_pcie.c
> index 3b4373c6a6..75146d6c2e 100644
> --- a/hw/arm/bcm2838_pcie.c
> +++ b/hw/arm/bcm2838_pcie.c
> @@ -12,11 +12,222 @@
>   #include "hw/irq.h"
>   #include "hw/pci-host/gpex.h"
>   #include "hw/qdev-properties.h"
> -#include "migration/vmstate.h"
> -#include "qemu/module.h"
>   #include "hw/arm/bcm2838_pcie.h"
>   #include "trace.h"
>   
> +/*
> + * RC host part
> + */
> +
> +static uint64_t bcm2838_pcie_host_read(void *opaque, hwaddr offset,
> +                                       unsigned size) {
> +    hwaddr mmcfg_addr;
> +    uint64_t value = ~0;
> +    BCM2838PcieHostState *s = opaque;
> +    PCIExpressHost *pcie_hb = PCIE_HOST_BRIDGE(s);
> +    PCIDevice *root_pci_dev = PCI_DEVICE(&s->root_port);
> +    uint8_t *root_regs = s->root_port.regs;
> +    uint32_t *cfg_idx = (uint32_t *)(root_regs + BCM2838_PCIE_EXT_CFG_INDEX
> +                                     - PCIE_CONFIG_SPACE_SIZE);
> +
> +    if (offset < PCIE_CONFIG_SPACE_SIZE) {
> +        value = pci_host_config_read_common(root_pci_dev, offset,
> +                                            PCIE_CONFIG_SPACE_SIZE, size);
> +    } else if (offset - PCIE_CONFIG_SPACE_SIZE + size
> +               <= sizeof(s->root_port.regs)) {
> +        switch (offset) {
> +        case BCM2838_PCIE_EXT_CFG_DATA
> +            ... BCM2838_PCIE_EXT_CFG_DATA + PCIE_CONFIG_SPACE_SIZE - 1:
> +            mmcfg_addr = *cfg_idx
> +                | PCIE_MMCFG_CONFOFFSET(offset - BCM2838_PCIE_EXT_CFG_DATA);
> +            value = pcie_hb->mmio.ops->read(opaque, mmcfg_addr, size);
> +            break;
> +        default:
> +            memcpy(&value, root_regs + offset - PCIE_CONFIG_SPACE_SIZE, size);
> +        }
> +    } else {
> +        qemu_log_mask(
> +            LOG_GUEST_ERROR,
> +            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
> +            __func__, size, offset);
> +    }
> +
> +    trace_bcm2838_pcie_host_read(size, offset, value);
> +    return value;
> +}
> +
> +static void bcm2838_pcie_host_write(void *opaque, hwaddr offset,
> +                                    uint64_t value, unsigned size) {
> +    hwaddr mmcfg_addr;
> +    BCM2838PcieHostState *s = opaque;
> +    PCIExpressHost *pcie_hb = PCIE_HOST_BRIDGE(s);
> +    PCIDevice *root_pci_dev = PCI_DEVICE(&s->root_port);
> +    uint8_t *root_regs = s->root_port.regs;
> +    uint32_t *cfg_idx = (uint32_t *)(root_regs + BCM2838_PCIE_EXT_CFG_INDEX
> +                                     - PCIE_CONFIG_SPACE_SIZE);
> +
> +    trace_bcm2838_pcie_host_write(size, offset, value);
> +
> +    if (offset < PCIE_CONFIG_SPACE_SIZE) {
> +        pci_host_config_write_common(root_pci_dev, offset,
> +                                     PCIE_CONFIG_SPACE_SIZE, value, size);
> +    } else if (offset - PCIE_CONFIG_SPACE_SIZE + size
> +               <= sizeof(s->root_port.regs)) {
> +        switch (offset) {
> +        case BCM2838_PCIE_EXT_CFG_DATA
> +            ... BCM2838_PCIE_EXT_CFG_DATA + PCIE_CONFIG_SPACE_SIZE - 1:
> +            mmcfg_addr = *cfg_idx
> +                | PCIE_MMCFG_CONFOFFSET(offset - BCM2838_PCIE_EXT_CFG_DATA);
> +            pcie_hb->mmio.ops->write(opaque, mmcfg_addr, value, size);
> +            break;
> +        default:
> +            memcpy(root_regs + offset - PCIE_CONFIG_SPACE_SIZE, &value, size);
> +        }
> +    } else {
> +        qemu_log_mask(
> +            LOG_GUEST_ERROR,
> +            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
> +            __func__, size, offset);
> +    }
> +}
> +
> +static const MemoryRegionOps bcm2838_pcie_host_ops = {
> +    .read = bcm2838_pcie_host_read,
> +    .write = bcm2838_pcie_host_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .impl = {.max_access_size = sizeof(uint64_t)},
> +};
> +
> +int bcm2838_pcie_host_set_irq_num(BCM2838PcieHostState *s, int index, int spi)
> +{
> +    if (index >= BCM2838_PCIE_NUM_IRQS) {
> +        return -EINVAL;
> +    }
> +
> +    s->irq_num[index] = spi;
> +    return 0;
> +}
> +
> +static void bcm2838_pcie_host_set_irq(void *opaque, int irq_num, int level)
> +{
> +    BCM2838PcieHostState *s = opaque;
> +
> +    qemu_set_irq(s->irq[irq_num], level);
> +}
> +
> +static PCIINTxRoute bcm2838_pcie_host_route_intx_pin_to_irq(void *opaque,
> +                                                            int pin)
> +{
> +    PCIINTxRoute route;
> +    BCM2838PcieHostState *s = opaque;
> +
> +    route.irq = s->irq_num[pin];
> +    route.mode = route.irq < 0 ? PCI_INTX_DISABLED : PCI_INTX_ENABLED;
> +
> +    return route;
> +}
> +
> +static int bcm2838_pcie_host_map_irq(PCIDevice *pci_dev, int pin)
> +{
> +    return pin;
> +}
> +
> +static void bcm2838_pcie_host_realize(DeviceState *dev, Error **errp)
> +{
> +    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
> +    BCM2838PcieHostState *s = BCM2838_PCIE_HOST(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    int i;
> +
> +    memory_region_init_io(&s->cfg_regs, OBJECT(s), &bcm2838_pcie_host_ops, s,
> +                          "bcm2838_pcie_cfg_regs", BCM2838_PCIE_REGS_SIZE);
> +    sysbus_init_mmio(sbd, &s->cfg_regs);
> +
> +    /*
> +     * The MemoryRegions io_mmio and io_ioport that we pass to
> +     * pci_register_root_bus() are not the same as the MemoryRegions
> +     * io_mmio_window and io_ioport_window that we expose as SysBus MRs.
> +     * The difference is in the behavior of accesses to addresses where no PCI
> +     * device has been mapped.
> +     *
> +     * io_mmio and io_ioport are the underlying PCI view of the PCI address
> +     * space, and when a PCI device does a bus master access to a bad address
> +     * this is reported back to it as a transaction failure.
> +     *
> +     * io_mmio_window and io_ioport_window implement "unmapped addresses read as
> +     * -1 and ignore writes"; this is a traditional x86 PC behavior, which is
> +     * not mandated properly by the PCI spec but expected by the majority of
> +     * PCI-using guest software, including Linux.
> +     *
> +     * We implement it in the PCIe host controller, by providing the *_window
> +     * MRs, which are containers with io ops that implement the 'background'
> +     * behavior and which hold the real PCI MRs as sub-regions.
> +     */
> +    memory_region_init(&s->io_mmio, OBJECT(s), "bcm2838_pcie_mmio", UINT64_MAX);
> +    memory_region_init(&s->io_ioport, OBJECT(s), "bcm2838_pcie_ioport",
> +                       64 * 1024);
> +
> +    memory_region_init_io(&s->io_mmio_window, OBJECT(s),
> +                            &unassigned_io_ops, OBJECT(s),
> +                            "bcm2838_pcie_mmio_window", UINT64_MAX);
> +    memory_region_init_io(&s->io_ioport_window, OBJECT(s),
> +                            &unassigned_io_ops, OBJECT(s),
> +                            "bcm2838_pcie_ioport_window", 64 * 1024);
> +
> +    memory_region_add_subregion(&s->io_mmio_window, 0, &s->io_mmio);
> +    memory_region_add_subregion(&s->io_ioport_window, 0, &s->io_ioport);
> +    sysbus_init_mmio(sbd, &s->io_mmio_window);
> +    sysbus_init_mmio(sbd, &s->io_ioport_window);
> +
> +    for (i = 0; i < BCM2838_PCIE_NUM_IRQS; i++) {
> +        sysbus_init_irq(sbd, &s->irq[i]);
> +        s->irq_num[i] = -1;
> +    }
> +
> +    pci->bus = pci_register_root_bus(dev, "pcie.0", bcm2838_pcie_host_set_irq,
> +                                     bcm2838_pcie_host_map_irq, s, &s->io_mmio,
> +                                     &s->io_ioport, 0, BCM2838_PCIE_NUM_IRQS,
> +                                     TYPE_PCIE_BUS);
> +    pci_bus_set_route_irq_fn(pci->bus, bcm2838_pcie_host_route_intx_pin_to_irq);
> +    qdev_realize(DEVICE(&s->root_port), BUS(pci->bus), &error_fatal);
> +}
> +
> +static const char *bcm2838_pcie_host_root_bus_path(PCIHostState *host_bridge,
> +                                                   PCIBus *rootbus)
> +{
> +    return "0000:00";
> +}
> +
> +static void bcm2838_pcie_host_class_init(ObjectClass *class, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(class);
> +    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
> +
> +    hc->root_bus_path = bcm2838_pcie_host_root_bus_path;
> +    dc->realize = bcm2838_pcie_host_realize;
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +    dc->fw_name = "pci";
> +}
> +
> +static void bcm2838_pcie_host_initfn(Object *obj)
> +{
> +    BCM2838PcieHostState *s = BCM2838_PCIE_HOST(obj);
> +    BCM2838PcieRootState *root = &s->root_port;
> +
> +    object_initialize_child(obj, "root_port", root, TYPE_BCM2838_PCIE_ROOT);
> +    qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
> +    qdev_prop_set_bit(DEVICE(root), "multifunction", false);
> +}
> +
> +static const TypeInfo bcm2838_pcie_host_info = {
> +    .name       = TYPE_BCM2838_PCIE_HOST,
> +    .parent     = TYPE_PCIE_HOST_BRIDGE,
> +    .instance_size = sizeof(BCM2838PcieHostState),
> +    .instance_init = bcm2838_pcie_host_initfn,
> +    .class_init = bcm2838_pcie_host_class_init,
> +};
> +
>   /*
>    * RC root part (D0:F0)
>    */
> @@ -69,6 +280,7 @@ static const TypeInfo bcm2838_pcie_root_info = {
>   static void bcm2838_pcie_register(void)
>   {
>       type_register_static(&bcm2838_pcie_root_info);
> +    type_register_static(&bcm2838_pcie_host_info);
>   }
>   
>   type_init(bcm2838_pcie_register)
> diff --git a/include/hw/arm/bcm2838_pcie.h b/include/hw/arm/bcm2838_pcie.h
> index 39828f817f..58c3a0efe7 100644
> --- a/include/hw/arm/bcm2838_pcie.h
> +++ b/include/hw/arm/bcm2838_pcie.h
> @@ -16,6 +16,9 @@
>   #include "hw/pci/pcie_port.h"
>   #include "qom/object.h"
>   
> +#define TYPE_BCM2838_PCIE_HOST "bcm2838-pcie-host"
> +OBJECT_DECLARE_SIMPLE_TYPE(BCM2838PcieHostState, BCM2838_PCIE_HOST)
> +
>   #define TYPE_BCM2838_PCIE_ROOT "bcm2838-pcie-root"
>   OBJECT_DECLARE_TYPE(BCM2838PcieRootState, BCM2838PcieRootClass,
>                       BCM2838_PCIE_ROOT)
> @@ -50,4 +53,23 @@ struct BCM2838PcieRootClass {
>   };
>   
>   
> +struct BCM2838PcieHostState {
> +    /*< private >*/
> +    PCIExpressHost parent_obj;
> +
> +    /*< public >*/
> +    BCM2838PcieRootState root_port;
> +
> +    MemoryRegion cfg_regs;
> +    MemoryRegion io_ioport;
> +    MemoryRegion io_mmio;
> +    MemoryRegion io_ioport_window;
> +    MemoryRegion io_mmio_window;
> +
> +    qemu_irq irq[BCM2838_PCIE_NUM_IRQS];
> +    int irq_num[BCM2838_PCIE_NUM_IRQS];
> +};
> +
> +int bcm2838_pcie_host_set_irq_num(BCM2838PcieHostState *s, int index, int spi);
> +
>   #endif /* BCM2838_PCIE_H */
--------------LOvCYjA74s46FQpvl1eYGAoJ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre class="body-full"><cite>I'm not super familiar with how QEMU models PCI controllers,
but I'm not sure this handling of the root port config registers
is right. On other controllers it looks like the
root config reads and writes are handled by setting the
PCIDeviceClass::config_read and PCIDevice::config_write
methods.
</cite>
It's not only for config space access but also to configuration area beyond PCIE config space.
I'm going to split into two access methods:
1) bcm2838_pcie_config_{write,read}() for access to addresses within the config space. Will be assigned to the dev-&gt;config_write.
2) bcm2838_pcie_mmio_{write,read}() for access to addresses beyond the config space. Will be implemented as 'normal' MemoryRegionOps structure.

<cite>Isn't the important thing here not what guest software thinks, but
what the actual hardware in this bcm2838 SoC implements ?</cite>

The thing is that the code is not fully abides the PCIe spec. It's been written mostly basing on kernel code and boot logs analysis.
That's why I think it worth to add a detailed comment why it was written that way.

</pre>
    <p></p>
    <div class="moz-cite-prefix">On 12/7/23 20:31, Sergey Kambalin
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20231208023145.1385775-16-sergey.kambalin@auriga.com">
      <pre class="moz-quote-pre" wrap="">Signed-off-by: Sergey Kambalin <a class="moz-txt-link-rfc2396E" href="mailto:sergey.kambalin@auriga.com">&lt;sergey.kambalin@auriga.com&gt;</a>
---
 hw/arm/bcm2838_pcie.c         | 216 +++++++++++++++++++++++++++++++++-
 include/hw/arm/bcm2838_pcie.h |  22 ++++
 2 files changed, 236 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bcm2838_pcie.c b/hw/arm/bcm2838_pcie.c
index 3b4373c6a6..75146d6c2e 100644
--- a/hw/arm/bcm2838_pcie.c
+++ b/hw/arm/bcm2838_pcie.c
@@ -12,11 +12,222 @@
 #include "hw/irq.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/qdev-properties.h"
-#include "migration/vmstate.h"
-#include "qemu/module.h"
 #include "hw/arm/bcm2838_pcie.h"
 #include "trace.h"
 
+/*
+ * RC host part
+ */
+
+static uint64_t bcm2838_pcie_host_read(void *opaque, hwaddr offset,
+                                       unsigned size) {
+    hwaddr mmcfg_addr;
+    uint64_t value = ~0;
+    BCM2838PcieHostState *s = opaque;
+    PCIExpressHost *pcie_hb = PCIE_HOST_BRIDGE(s);
+    PCIDevice *root_pci_dev = PCI_DEVICE(&amp;s-&gt;root_port);
+    uint8_t *root_regs = s-&gt;root_port.regs;
+    uint32_t *cfg_idx = (uint32_t *)(root_regs + BCM2838_PCIE_EXT_CFG_INDEX
+                                     - PCIE_CONFIG_SPACE_SIZE);
+
+    if (offset &lt; PCIE_CONFIG_SPACE_SIZE) {
+        value = pci_host_config_read_common(root_pci_dev, offset,
+                                            PCIE_CONFIG_SPACE_SIZE, size);
+    } else if (offset - PCIE_CONFIG_SPACE_SIZE + size
+               &lt;= sizeof(s-&gt;root_port.regs)) {
+        switch (offset) {
+        case BCM2838_PCIE_EXT_CFG_DATA
+            ... BCM2838_PCIE_EXT_CFG_DATA + PCIE_CONFIG_SPACE_SIZE - 1:
+            mmcfg_addr = *cfg_idx
+                | PCIE_MMCFG_CONFOFFSET(offset - BCM2838_PCIE_EXT_CFG_DATA);
+            value = pcie_hb-&gt;mmio.ops-&gt;read(opaque, mmcfg_addr, size);
+            break;
+        default:
+            memcpy(&amp;value, root_regs + offset - PCIE_CONFIG_SPACE_SIZE, size);
+        }
+    } else {
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+            __func__, size, offset);
+    }
+
+    trace_bcm2838_pcie_host_read(size, offset, value);
+    return value;
+}
+
+static void bcm2838_pcie_host_write(void *opaque, hwaddr offset,
+                                    uint64_t value, unsigned size) {
+    hwaddr mmcfg_addr;
+    BCM2838PcieHostState *s = opaque;
+    PCIExpressHost *pcie_hb = PCIE_HOST_BRIDGE(s);
+    PCIDevice *root_pci_dev = PCI_DEVICE(&amp;s-&gt;root_port);
+    uint8_t *root_regs = s-&gt;root_port.regs;
+    uint32_t *cfg_idx = (uint32_t *)(root_regs + BCM2838_PCIE_EXT_CFG_INDEX
+                                     - PCIE_CONFIG_SPACE_SIZE);
+
+    trace_bcm2838_pcie_host_write(size, offset, value);
+
+    if (offset &lt; PCIE_CONFIG_SPACE_SIZE) {
+        pci_host_config_write_common(root_pci_dev, offset,
+                                     PCIE_CONFIG_SPACE_SIZE, value, size);
+    } else if (offset - PCIE_CONFIG_SPACE_SIZE + size
+               &lt;= sizeof(s-&gt;root_port.regs)) {
+        switch (offset) {
+        case BCM2838_PCIE_EXT_CFG_DATA
+            ... BCM2838_PCIE_EXT_CFG_DATA + PCIE_CONFIG_SPACE_SIZE - 1:
+            mmcfg_addr = *cfg_idx
+                | PCIE_MMCFG_CONFOFFSET(offset - BCM2838_PCIE_EXT_CFG_DATA);
+            pcie_hb-&gt;mmio.ops-&gt;write(opaque, mmcfg_addr, value, size);
+            break;
+        default:
+            memcpy(root_regs + offset - PCIE_CONFIG_SPACE_SIZE, &amp;value, size);
+        }
+    } else {
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+            __func__, size, offset);
+    }
+}
+
+static const MemoryRegionOps bcm2838_pcie_host_ops = {
+    .read = bcm2838_pcie_host_read,
+    .write = bcm2838_pcie_host_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {.max_access_size = sizeof(uint64_t)},
+};
+
+int bcm2838_pcie_host_set_irq_num(BCM2838PcieHostState *s, int index, int spi)
+{
+    if (index &gt;= BCM2838_PCIE_NUM_IRQS) {
+        return -EINVAL;
+    }
+
+    s-&gt;irq_num[index] = spi;
+    return 0;
+}
+
+static void bcm2838_pcie_host_set_irq(void *opaque, int irq_num, int level)
+{
+    BCM2838PcieHostState *s = opaque;
+
+    qemu_set_irq(s-&gt;irq[irq_num], level);
+}
+
+static PCIINTxRoute bcm2838_pcie_host_route_intx_pin_to_irq(void *opaque,
+                                                            int pin)
+{
+    PCIINTxRoute route;
+    BCM2838PcieHostState *s = opaque;
+
+    route.irq = s-&gt;irq_num[pin];
+    route.mode = route.irq &lt; 0 ? PCI_INTX_DISABLED : PCI_INTX_ENABLED;
+
+    return route;
+}
+
+static int bcm2838_pcie_host_map_irq(PCIDevice *pci_dev, int pin)
+{
+    return pin;
+}
+
+static void bcm2838_pcie_host_realize(DeviceState *dev, Error **errp)
+{
+    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
+    BCM2838PcieHostState *s = BCM2838_PCIE_HOST(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    int i;
+
+    memory_region_init_io(&amp;s-&gt;cfg_regs, OBJECT(s), &amp;bcm2838_pcie_host_ops, s,
+                          "bcm2838_pcie_cfg_regs", BCM2838_PCIE_REGS_SIZE);
+    sysbus_init_mmio(sbd, &amp;s-&gt;cfg_regs);
+
+    /*
+     * The MemoryRegions io_mmio and io_ioport that we pass to
+     * pci_register_root_bus() are not the same as the MemoryRegions
+     * io_mmio_window and io_ioport_window that we expose as SysBus MRs.
+     * The difference is in the behavior of accesses to addresses where no PCI
+     * device has been mapped.
+     *
+     * io_mmio and io_ioport are the underlying PCI view of the PCI address
+     * space, and when a PCI device does a bus master access to a bad address
+     * this is reported back to it as a transaction failure.
+     *
+     * io_mmio_window and io_ioport_window implement "unmapped addresses read as
+     * -1 and ignore writes"; this is a traditional x86 PC behavior, which is
+     * not mandated properly by the PCI spec but expected by the majority of
+     * PCI-using guest software, including Linux.
+     *
+     * We implement it in the PCIe host controller, by providing the *_window
+     * MRs, which are containers with io ops that implement the 'background'
+     * behavior and which hold the real PCI MRs as sub-regions.
+     */
+    memory_region_init(&amp;s-&gt;io_mmio, OBJECT(s), "bcm2838_pcie_mmio", UINT64_MAX);
+    memory_region_init(&amp;s-&gt;io_ioport, OBJECT(s), "bcm2838_pcie_ioport",
+                       64 * 1024);
+
+    memory_region_init_io(&amp;s-&gt;io_mmio_window, OBJECT(s),
+                            &amp;unassigned_io_ops, OBJECT(s),
+                            "bcm2838_pcie_mmio_window", UINT64_MAX);
+    memory_region_init_io(&amp;s-&gt;io_ioport_window, OBJECT(s),
+                            &amp;unassigned_io_ops, OBJECT(s),
+                            "bcm2838_pcie_ioport_window", 64 * 1024);
+
+    memory_region_add_subregion(&amp;s-&gt;io_mmio_window, 0, &amp;s-&gt;io_mmio);
+    memory_region_add_subregion(&amp;s-&gt;io_ioport_window, 0, &amp;s-&gt;io_ioport);
+    sysbus_init_mmio(sbd, &amp;s-&gt;io_mmio_window);
+    sysbus_init_mmio(sbd, &amp;s-&gt;io_ioport_window);
+
+    for (i = 0; i &lt; BCM2838_PCIE_NUM_IRQS; i++) {
+        sysbus_init_irq(sbd, &amp;s-&gt;irq[i]);
+        s-&gt;irq_num[i] = -1;
+    }
+
+    pci-&gt;bus = pci_register_root_bus(dev, "pcie.0", bcm2838_pcie_host_set_irq,
+                                     bcm2838_pcie_host_map_irq, s, &amp;s-&gt;io_mmio,
+                                     &amp;s-&gt;io_ioport, 0, BCM2838_PCIE_NUM_IRQS,
+                                     TYPE_PCIE_BUS);
+    pci_bus_set_route_irq_fn(pci-&gt;bus, bcm2838_pcie_host_route_intx_pin_to_irq);
+    qdev_realize(DEVICE(&amp;s-&gt;root_port), BUS(pci-&gt;bus), &amp;error_fatal);
+}
+
+static const char *bcm2838_pcie_host_root_bus_path(PCIHostState *host_bridge,
+                                                   PCIBus *rootbus)
+{
+    return "0000:00";
+}
+
+static void bcm2838_pcie_host_class_init(ObjectClass *class, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
+
+    hc-&gt;root_bus_path = bcm2838_pcie_host_root_bus_path;
+    dc-&gt;realize = bcm2838_pcie_host_realize;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc-&gt;categories);
+    dc-&gt;fw_name = "pci";
+}
+
+static void bcm2838_pcie_host_initfn(Object *obj)
+{
+    BCM2838PcieHostState *s = BCM2838_PCIE_HOST(obj);
+    BCM2838PcieRootState *root = &amp;s-&gt;root_port;
+
+    object_initialize_child(obj, "root_port", root, TYPE_BCM2838_PCIE_ROOT);
+    qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
+    qdev_prop_set_bit(DEVICE(root), "multifunction", false);
+}
+
+static const TypeInfo bcm2838_pcie_host_info = {
+    .name       = TYPE_BCM2838_PCIE_HOST,
+    .parent     = TYPE_PCIE_HOST_BRIDGE,
+    .instance_size = sizeof(BCM2838PcieHostState),
+    .instance_init = bcm2838_pcie_host_initfn,
+    .class_init = bcm2838_pcie_host_class_init,
+};
+
 /*
  * RC root part (D0:F0)
  */
@@ -69,6 +280,7 @@ static const TypeInfo bcm2838_pcie_root_info = {
 static void bcm2838_pcie_register(void)
 {
     type_register_static(&amp;bcm2838_pcie_root_info);
+    type_register_static(&amp;bcm2838_pcie_host_info);
 }
 
 type_init(bcm2838_pcie_register)
diff --git a/include/hw/arm/bcm2838_pcie.h b/include/hw/arm/bcm2838_pcie.h
index 39828f817f..58c3a0efe7 100644
--- a/include/hw/arm/bcm2838_pcie.h
+++ b/include/hw/arm/bcm2838_pcie.h
@@ -16,6 +16,9 @@
 #include "hw/pci/pcie_port.h"
 #include "qom/object.h"
 
+#define TYPE_BCM2838_PCIE_HOST "bcm2838-pcie-host"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2838PcieHostState, BCM2838_PCIE_HOST)
+
 #define TYPE_BCM2838_PCIE_ROOT "bcm2838-pcie-root"
 OBJECT_DECLARE_TYPE(BCM2838PcieRootState, BCM2838PcieRootClass,
                     BCM2838_PCIE_ROOT)
@@ -50,4 +53,23 @@ struct BCM2838PcieRootClass {
 };
 
 
+struct BCM2838PcieHostState {
+    /*&lt; private &gt;*/
+    PCIExpressHost parent_obj;
+
+    /*&lt; public &gt;*/
+    BCM2838PcieRootState root_port;
+
+    MemoryRegion cfg_regs;
+    MemoryRegion io_ioport;
+    MemoryRegion io_mmio;
+    MemoryRegion io_ioport_window;
+    MemoryRegion io_mmio_window;
+
+    qemu_irq irq[BCM2838_PCIE_NUM_IRQS];
+    int irq_num[BCM2838_PCIE_NUM_IRQS];
+};
+
+int bcm2838_pcie_host_set_irq_num(BCM2838PcieHostState *s, int index, int spi);
+
 #endif /* BCM2838_PCIE_H */
</pre>
    </blockquote>
  </body>
</html>

--------------LOvCYjA74s46FQpvl1eYGAoJ--

