Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B0BCF6497
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 10:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suUrf-0005LP-Mv; Sat, 28 Sep 2024 06:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1suUre-0005HB-0U; Sat, 28 Sep 2024 06:39:50 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1suUrb-00005e-Mo; Sat, 28 Sep 2024 06:39:49 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D3A6E4E6010;
 Sat, 28 Sep 2024 12:39:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ULQswipGQ6RH; Sat, 28 Sep 2024 12:39:37 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C0D7C4E6004; Sat, 28 Sep 2024 12:39:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BE681746F60;
 Sat, 28 Sep 2024 12:39:37 +0200 (CEST)
Date: Sat, 28 Sep 2024 12:39:37 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Phil Dennis-Jordan <phil@philjordan.eu>
cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, 
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 02/14] hw/display/apple-gfx: Adds PCI implementation
In-Reply-To: <20240928085727.56883-3-phil@philjordan.eu>
Message-ID: <67acdfdc-348d-fcd2-7891-06a38349beb1@eik.bme.hu>
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-3-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1085095182-1727519977=:26933"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1085095182-1727519977=:26933
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 28 Sep 2024, Phil Dennis-Jordan wrote:
> This change wires up the PCI variant of the paravirtualised
> graphics device, mainly useful for x86-64 macOS guests, implemented
> by macOS's ParavirtualizedGraphics.framework. It builds on code
> shared with the vmapple/mmio variant of the PVG device.
>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
> hw/display/Kconfig         |   5 ++
> hw/display/apple-gfx-pci.m | 138 +++++++++++++++++++++++++++++++++++++
> hw/display/meson.build     |   1 +
> 3 files changed, 144 insertions(+)
> create mode 100644 hw/display/apple-gfx-pci.m
>
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 179a479d220..c2ec268f8e9 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -152,3 +152,8 @@ config MAC_PVG_VMAPPLE
>     bool
>     depends on MAC_PVG
>     depends on ARM
> +
> +config MAC_PVG_PCI
> +    bool
> +    depends on MAC_PVG && PCI
> +    default y if PCI_DEVICES
> diff --git a/hw/display/apple-gfx-pci.m b/hw/display/apple-gfx-pci.m
> new file mode 100644
> index 00000000000..9370258ee46
> --- /dev/null
> +++ b/hw/display/apple-gfx-pci.m
> @@ -0,0 +1,138 @@
> +/*
> + * QEMU Apple ParavirtualizedGraphics.framework device, PCI variant
> + *
> + * Copyright © 2023-2024 Phil Dennis-Jordan
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * ParavirtualizedGraphics.framework is a set of libraries that macOS provides
> + * which implements 3d graphics passthrough to the host as well as a
> + * proprietary guest communication channel to drive it. This device model
> + * implements support to drive that library from within QEMU as a PCI device
> + * aimed primarily at x86-64 macOS VMs.
> + */
> +
> +#include "apple-gfx.h"
> +#include "hw/pci/pci_device.h"
> +#include "hw/pci/msi.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> +
> +typedef struct AppleGFXPCIState {
> +    PCIDevice parent_obj;
> +
> +    AppleGFXState common;
> +} AppleGFXPCIState;

You don't need typedef here because OBJECT_DECLARE_SIMPLE_TYPE will add 
that. You can also put the struct AppleGFXPCIState definition after the 
OBJECT_DECLARE_SIMPLE_TYPE line. (See other devices for example.)

Regards,
BALATON Zoltan

> +
> +OBJECT_DECLARE_SIMPLE_TYPE(AppleGFXPCIState, APPLE_GFX_PCI)
> +
> +static const char* apple_gfx_pci_option_rom_path = NULL;
> +
> +static void apple_gfx_init_option_rom_path(void)
> +{
> +    NSURL *option_rom_url = PGCopyOptionROMURL();
> +    const char *option_rom_path = option_rom_url.fileSystemRepresentation;
> +    if (option_rom_url.fileURL && option_rom_path != NULL) {
> +        apple_gfx_pci_option_rom_path = g_strdup(option_rom_path);
> +    }
> +    [option_rom_url release];
> +}
> +
> +static void apple_gfx_pci_init(Object *obj)
> +{
> +    AppleGFXPCIState *s = APPLE_GFX_PCI(obj);
> +
> +    if (!apple_gfx_pci_option_rom_path) {
> +        /* Done on device not class init to avoid -daemonize ObjC fork crash */
> +        PCIDeviceClass *pci = PCI_DEVICE_CLASS(object_get_class(obj));
> +        apple_gfx_init_option_rom_path();
> +        pci->romfile = apple_gfx_pci_option_rom_path;
> +    }
> +
> +    apple_gfx_common_init(obj, &s->common, TYPE_APPLE_GFX_PCI);
> +}
> +
> +static void apple_gfx_pci_interrupt(PCIDevice *dev, AppleGFXPCIState *s,
> +                                    uint32_t vector)
> +{
> +    bool msi_ok;
> +    trace_apple_gfx_raise_irq(vector);
> +
> +    msi_ok = msi_enabled(dev);
> +    if (msi_ok) {
> +        msi_notify(dev, vector);
> +    }
> +}
> +
> +static void apple_gfx_pci_realize(PCIDevice *dev, Error **errp)
> +{
> +    AppleGFXPCIState *s = APPLE_GFX_PCI(dev);
> +    Error *err = NULL;
> +    int ret;
> +
> +    pci_register_bar(dev, PG_PCI_BAR_MMIO,
> +                     PCI_BASE_ADDRESS_SPACE_MEMORY, &s->common.iomem_gfx);
> +
> +    ret = msi_init(dev, 0x0 /* config offset; 0 = find space */,
> +                   PG_PCI_MAX_MSI_VECTORS, true /* msi64bit */,
> +                   false /*msi_per_vector_mask*/, &err);
> +    if (ret != 0) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    @autoreleasepool {
> +        PGDeviceDescriptor *desc = [PGDeviceDescriptor new];
> +        desc.raiseInterrupt = ^(uint32_t vector) {
> +            apple_gfx_pci_interrupt(dev, s, vector);
> +        };
> +
> +        apple_gfx_common_realize(&s->common, desc);
> +        [desc release];
> +        desc = nil;
> +    }
> +}
> +
> +static void apple_gfx_pci_reset(Object *obj, ResetType type)
> +{
> +    AppleGFXPCIState *s = APPLE_GFX_PCI(obj);
> +    [s->common.pgdev reset];
> +}
> +
> +static void apple_gfx_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *pci = PCI_DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    assert(rc->phases.hold == NULL);
> +    rc->phases.hold = apple_gfx_pci_reset;
> +    dc->desc = "macOS Paravirtualized Graphics PCI Display Controller";
> +    dc->hotpluggable = false;
> +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> +
> +    pci->vendor_id = PG_PCI_VENDOR_ID;
> +    pci->device_id = PG_PCI_DEVICE_ID;
> +    pci->class_id = PCI_CLASS_DISPLAY_OTHER;
> +    pci->realize = apple_gfx_pci_realize;
> +
> +    // TODO: Property for setting mode list
> +}
> +
> +static TypeInfo apple_gfx_pci_types[] = {
> +    {
> +        .name          = TYPE_APPLE_GFX_PCI,
> +        .parent        = TYPE_PCI_DEVICE,
> +        .instance_size = sizeof(AppleGFXPCIState),
> +        .class_init    = apple_gfx_pci_class_init,
> +        .instance_init = apple_gfx_pci_init,
> +        .interfaces = (InterfaceInfo[]) {
> +            { INTERFACE_PCIE_DEVICE },
> +            { },
> +        },
> +    }
> +};
> +DEFINE_TYPES(apple_gfx_pci_types)
> +
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 70d855749c0..ceb7bb07612 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -67,6 +67,7 @@ system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c', 'ati_
>
> system_ss.add(when: 'CONFIG_MAC_PVG',         if_true: [files('apple-gfx.m'), pvg, metal])
> system_ss.add(when: 'CONFIG_MAC_PVG_VMAPPLE', if_true: [files('apple-gfx-vmapple.m'), pvg, metal])
> +system_ss.add(when: 'CONFIG_MAC_PVG_PCI',     if_true: [files('apple-gfx-pci.m'), pvg, metal])
>
> if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
>   virtio_gpu_ss = ss.source_set()
>
--3866299591-1085095182-1727519977=:26933--

