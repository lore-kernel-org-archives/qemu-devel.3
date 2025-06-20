Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540DBC7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 10:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSYon-0003iI-8p; Fri, 20 Jun 2025 06:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uSYoj-0003hq-KO; Fri, 20 Jun 2025 06:17:53 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uSYog-0005kp-Qq; Fri, 20 Jun 2025 06:17:52 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNtb13Ksbz6L5GL;
 Fri, 20 Jun 2025 18:13:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 9C04D1402FE;
 Fri, 20 Jun 2025 18:17:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 20 Jun
 2025 12:17:46 +0200
Date: Fri, 20 Jun 2025 11:17:45 +0100
To: Eric Auger <eric.auger@redhat.com>
CC: <eric.auger.pro@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>, <imammedo@redhat.com>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 25/29] hw/arm/virt: Let virt support pci
 hotplug/unplug GED event
Message-ID: <20250620111745.00004018@huawei.com>
In-Reply-To: <20250616094903.885753-26-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-26-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 16 Jun 2025 11:46:54 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Set up the IO registers used to communicate between QEMU
> and ACPI.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> v2 -> v3:
> - remove acpi_ged_state->pcihp_state.use_acpi_hotplug_bridge = true;
> - use sysbus_mmio_map_name for all regs (Igor)

I'm very much in favor of this change but maybe break them out to
a separate patch - perhaps even one that can run ahead of the rest
of this series?

Mind you if this is going to land shortly perhaps not worth the bother.

Either way

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> - create_pcie left at its original place
> 
> v1 -> v2:
> - use ACPI_PCIHP_REGION_NAME
> ---
>  include/hw/acpi/generic_event_device.h |  1 +
>  hw/arm/virt.c                          | 19 +++++++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index ec8e1abe0a..8f5d903146 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -111,6 +111,7 @@ typedef struct GEDState {
>  } GEDState;
>  
>  #define ACPI_PCIHP_REGION_NAME "pcihp container"
> +#define ACPI_MEMHP_REGION_NAME "memhp container"
>  
>  struct AcpiGedState {
>      SysBusDevice parent_obj;
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 41be8f6dbb..8c882e0794 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -684,6 +684,8 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>      DeviceState *dev;
>      MachineState *ms = MACHINE(vms);
>      SysBusDevice *sbdev;
> +    AcpiGedState *acpi_ged_state;
> +    AcpiPciHpState *pcihp_state;
>      int irq = vms->irqmap[VIRT_ACPI_GED];
>      uint32_t event = ACPI_GED_PWR_DOWN_EVT;
>  
> @@ -696,13 +698,26 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>      }
>  
>      dev = qdev_new(TYPE_ACPI_GED);
> +    acpi_ged_state = ACPI_GED(dev);
> +    pcihp_state = &acpi_ged_state->pcihp_state;
> +    if (pcihp_state->use_acpi_hotplug_bridge) {
> +        event |= ACPI_GED_PCI_HOTPLUG_EVT;
> +    }
>      qdev_prop_set_uint32(dev, "ged-event", event);
>      object_property_set_link(OBJECT(dev), "bus", OBJECT(vms->bus), &error_abort);
>      sbdev = SYS_BUS_DEVICE(dev);
>      sysbus_realize_and_unref(sbdev, &error_fatal);
>  
> -    sysbus_mmio_map(sbdev, 0, vms->memmap[VIRT_ACPI_GED].base);
> -    sysbus_mmio_map(sbdev, 1, vms->memmap[VIRT_PCDIMM_ACPI].base);
> +    sysbus_mmio_map_name(sbdev, TYPE_ACPI_GED, vms->memmap[VIRT_ACPI_GED].base);
> +    sysbus_mmio_map_name(sbdev, ACPI_MEMHP_REGION_NAME,
> +                         vms->memmap[VIRT_PCDIMM_ACPI].base);
> +    if (pcihp_state->use_acpi_hotplug_bridge) {
> +        int pcihp_region_index;
> +
> +        pcihp_region_index = sysbus_mmio_map_name(sbdev, ACPI_PCIHP_REGION_NAME,
> +                                                  vms->memmap[VIRT_ACPI_PCIHP].base);
> +        assert(pcihp_region_index >= 0);
> +    }
>      sysbus_connect_irq(sbdev, 0, qdev_get_gpio_in(vms->gic, irq));
>  
>      return dev;


