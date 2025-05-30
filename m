Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0167CC5B552
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 10:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKwv2-0002cV-7q; Fri, 30 May 2025 06:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uKwuo-0002aL-TF; Fri, 30 May 2025 06:24:43 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uKwul-00022D-1g; Fri, 30 May 2025 06:24:42 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b7zql1rTKz6GFKD;
 Fri, 30 May 2025 18:24:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id AA5C51400C8;
 Fri, 30 May 2025 18:24:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 May
 2025 12:24:23 +0200
Date: Fri, 30 May 2025 11:24:22 +0100
To: Eric Auger <eric.auger@redhat.com>
CC: <eric.auger.pro@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>, <imammedo@redhat.com>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 14/25] hw/i386/acpi-build: Move
 build_append_pci_bus_devices/pcihp_slots to pcihp
Message-ID: <20250530112422.0000376e@huawei.com>
In-Reply-To: <20250527074224.1197793-15-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-15-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 27 May 2025 09:40:16 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> We intend to reuse build_append_pci_bus_devices and
> build_append_pcihp_slots on ARM. So let's move them to
> hw/acpi/pcihp.c as well as all static helpers they
> use.
Oddly short wrap.   I guess it kind of looks prettier than ...

We intend to reuse build_append_pci_bus_devices and
build_append_pcihp_slots on ARM. So let's move them to hw/acpi/pcihp.c as 
well as all static helpers they use.


... so I'm not that fussed.

I don't really mind, but maybe a short statement of why you
put the functions in a different order in the destination
would be a good thing to add to this description?

Either way
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> 
> No functional change intended.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  include/hw/acpi/pci.h   |   1 -
>  include/hw/acpi/pcihp.h |   2 +
>  hw/acpi/pcihp.c         | 173 ++++++++++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c    | 172 ---------------------------------------
>  4 files changed, 175 insertions(+), 173 deletions(-)
> 
> diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
> index ab0187a894..4dca22c0e2 100644
> --- a/include/hw/acpi/pci.h
> +++ b/include/hw/acpi/pci.h
> @@ -37,7 +37,6 @@ typedef struct AcpiMcfgInfo {
>  void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info,
>                  const char *oem_id, const char *oem_table_id);
>  
> -void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
>  void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
>  
>  void build_srat_generic_affinity_structures(GArray *table_data);
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index f4fd44cb32..5506a58862 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -80,6 +80,8 @@ void build_append_pcihp_resources(Aml *table,
>                                    uint64_t io_addr, uint64_t io_len);
>  bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus);
>  
> +void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
> +
>  /* Called on reset */
>  void acpi_pcihp_reset(AcpiPciHpState *s);
>  
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 907a08ac7f..942669ea89 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -27,6 +27,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/acpi/pcihp.h"
>  #include "hw/acpi/aml-build.h"
> +#include "hw/acpi/acpi_aml_interface.h"
>  #include "hw/pci-host/i440fx.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bridge.h"
> @@ -763,6 +764,178 @@ bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus)
>      return !!nr_notifiers;
>  }
>  
> +static void build_append_pcihp_notify_entry(Aml *method, int slot)
> +{
> +    Aml *if_ctx;
> +    int32_t devfn = PCI_DEVFN(slot, 0);
> +
> +    if_ctx = aml_if(aml_and(aml_arg(0), aml_int(0x1U << slot), NULL));
> +    aml_append(if_ctx, aml_notify(aml_name("S%.02X", devfn), aml_arg(1)));
> +    aml_append(method, if_ctx);
> +}
> +
> +static bool is_devfn_ignored_generic(const int devfn, const PCIBus *bus)
> +{
> +    const PCIDevice *pdev = bus->devices[devfn];
> +
> +    if (PCI_FUNC(devfn)) {
> +        if (IS_PCI_BRIDGE(pdev)) {
> +            /*
> +             * Ignore only hotplugged PCI bridges on !0 functions, but
> +             * allow describing cold plugged bridges on all functions
> +             */
> +            if (DEVICE(pdev)->hotplugged) {
> +                return true;
> +            }
> +        }
> +    }
> +    return false;
> +}
> +
> +static bool is_devfn_ignored_hotplug(const int devfn, const PCIBus *bus)
> +{
> +    PCIDevice *pdev = bus->devices[devfn];
> +    if (pdev) {
> +        return is_devfn_ignored_generic(devfn, bus) ||
> +               !DEVICE_GET_CLASS(pdev)->hotpluggable ||
> +               /* Cold plugged bridges aren't themselves hot-pluggable */
> +               (IS_PCI_BRIDGE(pdev) && !DEVICE(pdev)->hotplugged);
> +    } else { /* non populated slots */
> +         /*
> +          * hotplug is supported only for non-multifunction device
> +          * so generate device description only for function 0
> +          */
> +        if (PCI_FUNC(devfn) ||
> +            (pci_bus_is_express(bus) && PCI_SLOT(devfn) > 0)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +static Aml *aml_pci_static_endpoint_dsm(PCIDevice *pdev)
> +{
> +    Aml *method;
> +
> +    g_assert(pdev->acpi_index != 0);
> +    method = aml_method("_DSM", 4, AML_SERIALIZED);
> +    {
> +        Aml *params = aml_local(0);
> +        Aml *pkg = aml_package(1);
> +        aml_append(pkg, aml_int(pdev->acpi_index));
> +        aml_append(method, aml_store(pkg, params));
> +        aml_append(method,
> +            aml_return(aml_call5("EDSM", aml_arg(0), aml_arg(1),
> +                                 aml_arg(2), aml_arg(3), params))
> +        );
> +    }
> +    return method;
> +}
> +
> +static Aml *aml_pci_device_dsm(void)
> +{
> +    Aml *method;
> +
> +    method = aml_method("_DSM", 4, AML_SERIALIZED);
> +    {
> +        Aml *params = aml_local(0);
> +        Aml *pkg = aml_package(2);
> +        aml_append(pkg, aml_int(0));
> +        aml_append(pkg, aml_int(0));
> +        aml_append(method, aml_store(pkg, params));
> +        aml_append(method,
> +            aml_store(aml_name("BSEL"), aml_index(params, aml_int(0))));
> +        aml_append(method,
> +            aml_store(aml_name("ASUN"), aml_index(params, aml_int(1))));
> +        aml_append(method,
> +            aml_return(aml_call5("PDSM", aml_arg(0), aml_arg(1),
> +                                 aml_arg(2), aml_arg(3), params))
> +        );
> +    }
> +    return method;
> +}
> +
> +void build_append_pcihp_slots(Aml *parent_scope, PCIBus *bus)
> +{
> +    int devfn;
> +    Aml *dev, *notify_method = NULL, *method;
> +    QObject *bsel = object_property_get_qobject(OBJECT(bus),
> +                        ACPI_PCIHP_PROP_BSEL, NULL);
> +    uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
> +    qobject_unref(bsel);
> +
> +    aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)));
> +    notify_method = aml_method("DVNT", 2, AML_NOTSERIALIZED);
> +
> +    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
> +        int slot = PCI_SLOT(devfn);
> +        int adr = slot << 16 | PCI_FUNC(devfn);
> +
> +        if (is_devfn_ignored_hotplug(devfn, bus)) {
> +            continue;
> +        }
> +
> +        if (bus->devices[devfn]) {
> +            dev = aml_scope("S%.02X", devfn);
> +        } else {
> +            dev = aml_device("S%.02X", devfn);
> +            aml_append(dev, aml_name_decl("_ADR", aml_int(adr)));
> +        }
> +
> +        /*
> +         * Can't declare _SUN here for every device as it changes 'slot'
> +         * enumeration order in linux kernel, so use another variable for it
> +         */
> +        aml_append(dev, aml_name_decl("ASUN", aml_int(slot)));
> +        aml_append(dev, aml_pci_device_dsm());
> +
> +        aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
> +        /* add _EJ0 to make slot hotpluggable  */
> +        method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> +        aml_append(method,
> +            aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN"))
> +        );
> +        aml_append(dev, method);
> +
> +        build_append_pcihp_notify_entry(notify_method, slot);
> +
> +        /* device descriptor has been composed, add it into parent context */
> +        aml_append(parent_scope, dev);
> +    }
> +    aml_append(parent_scope, notify_method);
> +}
> +
> +void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
> +{
> +    int devfn;
> +    Aml *dev;
> +
> +    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
> +        /* ACPI spec: 1.0b: Table 6-2 _ADR Object Bus Types, PCI type */
> +        int adr = PCI_SLOT(devfn) << 16 | PCI_FUNC(devfn);
> +        PCIDevice *pdev = bus->devices[devfn];
> +
> +        if (!pdev || is_devfn_ignored_generic(devfn, bus)) {
> +            continue;
> +        }
> +
> +        /* start to compose PCI device descriptor */
> +        dev = aml_device("S%.02X", devfn);
> +        aml_append(dev, aml_name_decl("_ADR", aml_int(adr)));
> +
> +        call_dev_aml_func(DEVICE(bus->devices[devfn]), dev);
> +        /* add _DSM if device has acpi-index set */
> +        if (pdev->acpi_index &&
> +            !object_property_get_bool(OBJECT(pdev), "hotpluggable",
> +                                      &error_abort)) {
> +            aml_append(dev, aml_pci_static_endpoint_dsm(pdev));
> +        }
> +
> +        /* device descriptor has been composed, add it into parent context */
> +        aml_append(parent_scope, dev);
> +    }
> +}
> +
>  const VMStateDescription vmstate_acpi_pcihp_pci_status = {
>      .name = "acpi_pcihp_pci_status",
>      .version_id = 1,
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 3275675e60..fe8bc62c03 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -338,29 +338,6 @@ build_facs(GArray *table_data)
>      g_array_append_vals(table_data, reserved, 40); /* Reserved */
>  }
>  
> -static Aml *aml_pci_device_dsm(void)
> -{
> -    Aml *method;
> -
> -    method = aml_method("_DSM", 4, AML_SERIALIZED);
> -    {
> -        Aml *params = aml_local(0);
> -        Aml *pkg = aml_package(2);
> -        aml_append(pkg, aml_int(0));
> -        aml_append(pkg, aml_int(0));
> -        aml_append(method, aml_store(pkg, params));
> -        aml_append(method,
> -            aml_store(aml_name("BSEL"), aml_index(params, aml_int(0))));
> -        aml_append(method,
> -            aml_store(aml_name("ASUN"), aml_index(params, aml_int(1))));
> -        aml_append(method,
> -            aml_return(aml_call5("PDSM", aml_arg(0), aml_arg(1),
> -                                 aml_arg(2), aml_arg(3), params))
> -        );
> -    }
> -    return method;
> -}
> -
>  static Aml *aml_pci_edsm(void)
>  {
>      Aml *method, *ifctx;
> @@ -414,155 +391,6 @@ static Aml *aml_pci_edsm(void)
>      return method;
>  }
>  
> -static Aml *aml_pci_static_endpoint_dsm(PCIDevice *pdev)
> -{
> -    Aml *method;
> -
> -    g_assert(pdev->acpi_index != 0);
> -    method = aml_method("_DSM", 4, AML_SERIALIZED);
> -    {
> -        Aml *params = aml_local(0);
> -        Aml *pkg = aml_package(1);
> -        aml_append(pkg, aml_int(pdev->acpi_index));
> -        aml_append(method, aml_store(pkg, params));
> -        aml_append(method,
> -            aml_return(aml_call5("EDSM", aml_arg(0), aml_arg(1),
> -                                 aml_arg(2), aml_arg(3), params))
> -        );
> -    }
> -    return method;
> -}
> -
> -static void build_append_pcihp_notify_entry(Aml *method, int slot)
> -{
> -    Aml *if_ctx;
> -    int32_t devfn = PCI_DEVFN(slot, 0);
> -
> -    if_ctx = aml_if(aml_and(aml_arg(0), aml_int(0x1U << slot), NULL));
> -    aml_append(if_ctx, aml_notify(aml_name("S%.02X", devfn), aml_arg(1)));
> -    aml_append(method, if_ctx);
> -}
> -
> -static bool is_devfn_ignored_generic(const int devfn, const PCIBus *bus)
> -{
> -    const PCIDevice *pdev = bus->devices[devfn];
> -
> -    if (PCI_FUNC(devfn)) {
> -        if (IS_PCI_BRIDGE(pdev)) {
> -            /*
> -             * Ignore only hotplugged PCI bridges on !0 functions, but
> -             * allow describing cold plugged bridges on all functions
> -             */
> -            if (DEVICE(pdev)->hotplugged) {
> -                return true;
> -            }
> -        }
> -    }
> -    return false;
> -}
> -
> -static bool is_devfn_ignored_hotplug(const int devfn, const PCIBus *bus)
> -{
> -    PCIDevice *pdev = bus->devices[devfn];
> -    if (pdev) {
> -        return is_devfn_ignored_generic(devfn, bus) ||
> -               !DEVICE_GET_CLASS(pdev)->hotpluggable ||
> -               /* Cold plugged bridges aren't themselves hot-pluggable */
> -               (IS_PCI_BRIDGE(pdev) && !DEVICE(pdev)->hotplugged);
> -    } else { /* non populated slots */
> -         /*
> -         * hotplug is supported only for non-multifunction device
> -         * so generate device description only for function 0
> -         */
> -        if (PCI_FUNC(devfn) ||
> -            (pci_bus_is_express(bus) && PCI_SLOT(devfn) > 0)) {
> -            return true;
> -        }
> -    }
> -    return false;
> -}
> -
> -void build_append_pcihp_slots(Aml *parent_scope, PCIBus *bus)
> -{
> -    int devfn;
> -    Aml *dev, *notify_method = NULL, *method;
> -    QObject *bsel = object_property_get_qobject(OBJECT(bus),
> -                        ACPI_PCIHP_PROP_BSEL, NULL);
> -    uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
> -    qobject_unref(bsel);
> -
> -    aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)));
> -    notify_method = aml_method("DVNT", 2, AML_NOTSERIALIZED);
> -
> -    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
> -        int slot = PCI_SLOT(devfn);
> -        int adr = slot << 16 | PCI_FUNC(devfn);
> -
> -        if (is_devfn_ignored_hotplug(devfn, bus)) {
> -            continue;
> -        }
> -
> -        if (bus->devices[devfn]) {
> -            dev = aml_scope("S%.02X", devfn);
> -        } else {
> -            dev = aml_device("S%.02X", devfn);
> -            aml_append(dev, aml_name_decl("_ADR", aml_int(adr)));
> -        }
> -
> -        /*
> -         * Can't declare _SUN here for every device as it changes 'slot'
> -         * enumeration order in linux kernel, so use another variable for it
> -         */
> -        aml_append(dev, aml_name_decl("ASUN", aml_int(slot)));
> -        aml_append(dev, aml_pci_device_dsm());
> -
> -        aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
> -        /* add _EJ0 to make slot hotpluggable  */
> -        method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> -        aml_append(method,
> -            aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN"))
> -        );
> -        aml_append(dev, method);
> -
> -        build_append_pcihp_notify_entry(notify_method, slot);
> -
> -        /* device descriptor has been composed, add it into parent context */
> -        aml_append(parent_scope, dev);
> -    }
> -    aml_append(parent_scope, notify_method);
> -}
> -
> -void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
> -{
> -    int devfn;
> -    Aml *dev;
> -
> -    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
> -        /* ACPI spec: 1.0b: Table 6-2 _ADR Object Bus Types, PCI type */
> -        int adr = PCI_SLOT(devfn) << 16 | PCI_FUNC(devfn);
> -        PCIDevice *pdev = bus->devices[devfn];
> -
> -        if (!pdev || is_devfn_ignored_generic(devfn, bus)) {
> -            continue;
> -        }
> -
> -        /* start to compose PCI device descriptor */
> -        dev = aml_device("S%.02X", devfn);
> -        aml_append(dev, aml_name_decl("_ADR", aml_int(adr)));
> -
> -        call_dev_aml_func(DEVICE(bus->devices[devfn]), dev);
> -        /* add _DSM if device has acpi-index set */
> -        if (pdev->acpi_index &&
> -            !object_property_get_bool(OBJECT(pdev), "hotpluggable",
> -                                      &error_abort)) {
> -            aml_append(dev, aml_pci_static_endpoint_dsm(pdev));
> -        }
> -
> -        /* device descriptor has been composed, add it into parent context */
> -        aml_append(parent_scope, dev);
> -    }
> -}
> -
>  /*
>   * build_prt - Define interrupt routing rules
>   *


