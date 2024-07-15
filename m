Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E858C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 14:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTMgu-0004Kb-N2; Mon, 15 Jul 2024 10:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTMgt-0004K1-9S
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 10:28:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTMgo-0004kT-Db
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 10:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721053708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5W1KE42WuOYIQBeRTA987gly7BCI2Uoj3YSvsHDuLw=;
 b=dAg0F9JBlpjPqw1v5xbx8oTvFjl2Vew1BPVzMeSl1UDhqIVHJukyGxxG4FjX+pq/HWvkxd
 1yGdvs0x8X+BU8ztqLy0Ic4hXdSrrmlDS4cG9nWbQsFFAfm5sHS3EoFGQWNt4Pi1mGujCc
 iI4UYxCLmKcHM0fdeURRjX1m6ZIItMY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-qXirRSy2Mx6jWZivm7gUxA-1; Mon, 15 Jul 2024 10:28:27 -0400
X-MC-Unique: qXirRSy2Mx6jWZivm7gUxA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4265d3bf59dso32554365e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 07:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721053706; x=1721658506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q5W1KE42WuOYIQBeRTA987gly7BCI2Uoj3YSvsHDuLw=;
 b=E4lyeYxo0cEDJyUeaYY2aW1Jt26Bv+i1KJXc78doPnV88xGXEBRHV5wHygIdnNcgAd
 9hd3nlyjTOuH+PthPpdMlbKP9YDCTKpL2RuIcG5vRf1XRA1+hVO7jfUMw/STklO9lolM
 AuLFPeNfrIIcYo0HjMYCTAX3sQsTAM+wjqS7G/ELZtbK9njoaSPqzwv6cRompsSLKh6i
 gLLWkohQsA0Xl3nyGBCSeHTFiZQJUrs4lzKqdbWSWgAnJ289r6jjKBUfDurCUaYEqsP+
 1NkT9Wvkk7PvihkcVADxZj+r+6tVMsIFay2urJDKVRyHaxX/PW0/t3DlFco7wiKXFqnV
 wTcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb2dzQDGTDiiqATdFzy3cdLN1XeduVtijKfMzdCTFgRyiVAPilBAGrax4HAG9u7Y4IxHNNwboJKCKtOv9Tg1zghDe56E8=
X-Gm-Message-State: AOJu0YxR1ytxlkNqcVPK6En1z1jXYqv/b+5DYJd2BcCS7N5cUt+glvbi
 xlGRhT51z5/6i0jLNWpff46V/0bhCmAOX19UXcf7toUY09VDxAQi/Wei2fbbtNv6FAPv1Qs6Dav
 3vuFeBpnlJeJfdSl6jIFOtoLPWWpe8KQVL1yc57fDJnx/W5EuiWwF
X-Received: by 2002:a05:600c:6541:b0:426:6364:c2c4 with SMTP id
 5b1f17b1804b1-426707cf9c4mr109759705e9.14.1721053706154; 
 Mon, 15 Jul 2024 07:28:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkiSdAJsZ4KS92/uHf4ztmPgpbLaqjZGDB4NeQ2JUrQ2mgfwWqLJF/auE8r3dQQuDRKP7/4g==
X-Received: by 2002:a05:600c:6541:b0:426:6364:c2c4 with SMTP id
 5b1f17b1804b1-426707cf9c4mr109759545e9.14.1721053705704; 
 Mon, 15 Jul 2024 07:28:25 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef4793sm89451105e9.43.2024.07.15.07.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 07:28:25 -0700 (PDT)
Date: Mon, 15 Jul 2024 16:28:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <linuxarm@huawei.com>,
 <linux-cxl@vger.kernel.org>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Dave
 Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v5 06/13] acpi/pci: Move Generic Initiator object
 handling into acpi/pci.*
Message-ID: <20240715162824.6574fcd9@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240712110837.1439736-7-Jonathan.Cameron@huawei.com>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
 <20240712110837.1439736-7-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 12 Jul 2024 12:08:10 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Whilst ACPI SRAT Generic Initiator Afinity Structures are able to refer to
> both PCI and ACPI Device Handles, the QEMU implementation only implements
> the PCI Device Handle case.  For now move the code into the existing
> hw/acpi/pci.c file and header.  If support for ACPI Device Handles is
> added in the future, perhaps this will be moved again.
> 
> Also push the struct AcpiGenericInitiator down into the c file as not
> used outside pci.c.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> v5: Carry forward changes from previous patch.
>     Move the TYPE_ACPI_GENERIC_INTIATOR define down into the c file
>     along with include qom/object_interfaces.h
> ---
>  include/hw/acpi/acpi_generic_initiator.h |  24 -----
>  include/hw/acpi/pci.h                    |   3 +
>  hw/acpi/acpi_generic_initiator.c         | 120 ----------------------
>  hw/acpi/pci.c                            | 124 +++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c                 |   1 -
>  hw/i386/acpi-build.c                     |   1 -
>  hw/acpi/meson.build                      |   1 -
>  7 files changed, 127 insertions(+), 147 deletions(-)
> 
> diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
> deleted file mode 100644
> index 7b98676713..0000000000
> --- a/include/hw/acpi/acpi_generic_initiator.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> - */
> -
> -#ifndef ACPI_GENERIC_INITIATOR_H
> -#define ACPI_GENERIC_INITIATOR_H
> -
> -#include "qom/object_interfaces.h"
> -
> -#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
> -
> -typedef struct AcpiGenericInitiator {
> -    /* private */
> -    Object parent;
> -
> -    /* public */
> -    char *pci_dev;
> -    uint16_t node;
> -} AcpiGenericInitiator;
> -
> -void build_srat_generic_pci_initiator(GArray *table_data);
> -
> -#endif
> diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
> index 467a99461c..3015a8171c 100644
> --- a/include/hw/acpi/pci.h
> +++ b/include/hw/acpi/pci.h
> @@ -40,4 +40,7 @@ Aml *aml_pci_device_dsm(void);
>  
>  void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
>  void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
> +
> +void build_srat_generic_pci_initiator(GArray *table_data);
> +
>  #endif
> diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> deleted file mode 100644
> index 365feb527f..0000000000
> --- a/hw/acpi/acpi_generic_initiator.c
> +++ /dev/null
> @@ -1,120 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> - */
> -
> -#include "qemu/osdep.h"
> -#include "hw/acpi/acpi_generic_initiator.h"
> -#include "hw/acpi/aml-build.h"
> -#include "hw/boards.h"
> -#include "hw/pci/pci_device.h"
> -#include "qemu/error-report.h"
> -#include "qapi/error.h"
> -
> -typedef struct AcpiGenericInitiatorClass {
> -    ObjectClass parent_class;
> -} AcpiGenericInitiatorClass;
> -
> -OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
> -                   ACPI_GENERIC_INITIATOR, OBJECT,
> -                   { TYPE_USER_CREATABLE },
> -                   { NULL })
> -
> -OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
> -
> -static void acpi_generic_initiator_init(Object *obj)
> -{
> -    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> -
> -    gi->node = MAX_NODES;
> -    gi->pci_dev = NULL;
> -}
> -
> -static void acpi_generic_initiator_finalize(Object *obj)
> -{
> -    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> -
> -    g_free(gi->pci_dev);
> -}
> -
> -static void acpi_generic_initiator_set_pci_device(Object *obj, const char *val,
> -                                                  Error **errp)
> -{
> -    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> -
> -    gi->pci_dev = g_strdup(val);
> -}
> -
> -static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
> -                                            const char *name, void *opaque,
> -                                            Error **errp)
> -{
> -    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> -    MachineState *ms = MACHINE(qdev_get_machine());
> -    uint32_t value;
> -
> -    if (!visit_type_uint32(v, name, &value, errp)) {
> -        return;
> -    }
> -
> -    if (value >= MAX_NODES) {
> -        error_printf("%s: Invalid NUMA node specified\n",
> -                     TYPE_ACPI_GENERIC_INITIATOR);
> -        exit(1);
> -    }
> -
> -    gi->node = value;
> -    ms->numa_state->nodes[gi->node].has_gi = true;
> -}
> -
> -static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
> -{
> -    object_class_property_add_str(oc, "pci-dev", NULL,
> -        acpi_generic_initiator_set_pci_device);
> -    object_class_property_add(oc, "node", "int", NULL,
> -        acpi_generic_initiator_set_node, NULL, NULL);
> -}
> -
> -static int build_acpi_generic_initiator(Object *obj, void *opaque)
> -{
> -    MachineState *ms = MACHINE(qdev_get_machine());
> -    AcpiGenericInitiator *gi;
> -    GArray *table_data = opaque;
> -    int32_t devfn;
> -    uint8_t bus;
> -    Object *o;
> -
> -    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
> -        return 0;
> -    }
> -
> -    gi = ACPI_GENERIC_INITIATOR(obj);
> -    if (gi->node >= ms->numa_state->num_nodes) {
> -        error_printf("%s: Specified node %d is invalid.\n",
> -                     TYPE_ACPI_GENERIC_INITIATOR, gi->node);
> -        exit(1);
> -    }
> -
> -    o = object_resolve_path_type(gi->pci_dev, TYPE_PCI_DEVICE, NULL);
> -    if (!o) {
> -        error_printf("%s: Specified device must be a PCI device.\n",
> -                     TYPE_ACPI_GENERIC_INITIATOR);
> -        exit(1);
> -    }
> -
> -    bus = object_property_get_uint(o, "busnr", &error_fatal);
> -    devfn = object_property_get_int(o, "addr", &error_fatal);
> -    /* devfn is constrained in PCI to be 8 bit but storage is an int32_t */
> -    assert(devfn >= 0 && devfn < PCI_DEVFN_MAX);
> -
> -    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
> -
> -    return 0;
> -}
> -
> -void build_srat_generic_pci_initiator(GArray *table_data)
> -{
> -    object_child_foreach_recursive(object_get_root(),
> -                                   build_acpi_generic_initiator,
> -                                   table_data);
> -}
> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> index 20b70dcd81..3e1db161cc 100644
> --- a/hw/acpi/pci.c
> +++ b/hw/acpi/pci.c
> @@ -24,8 +24,13 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qom/object_interfaces.h"
> +#include "qapi/error.h"
> +#include "hw/boards.h"
>  #include "hw/acpi/aml-build.h"
>  #include "hw/acpi/pci.h"
> +#include "hw/pci/pci_device.h"
>  #include "hw/pci/pcie_host.h"
>  
>  /*
> @@ -59,3 +64,122 @@ void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info,
>  
>      acpi_table_end(linker, &table);
>  }
> +
> +typedef struct AcpiGenericInitiator {
> +    /* private */
> +    Object parent;
> +
> +    /* public */
> +    char *pci_dev;
> +    uint16_t node;
> +} AcpiGenericInitiator;
> +
> +typedef struct AcpiGenericInitiatorClass {
> +    ObjectClass parent_class;
> +} AcpiGenericInitiatorClass;
> +
> +#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
> +
> +OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
> +                   ACPI_GENERIC_INITIATOR, OBJECT,
> +                   { TYPE_USER_CREATABLE },
> +                   { NULL })
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
> +
> +static void acpi_generic_initiator_init(Object *obj)
> +{
> +    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> +
> +    gi->node = MAX_NODES;
> +    gi->pci_dev = NULL;
> +}
> +
> +static void acpi_generic_initiator_finalize(Object *obj)
> +{
> +    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> +
> +    g_free(gi->pci_dev);
> +}
> +
> +static void acpi_generic_initiator_set_pci_device(Object *obj, const char *val,
> +                                                  Error **errp)
> +{
> +    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> +
> +    gi->pci_dev = g_strdup(val);
> +}
> +
> +static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
> +                                            const char *name, void *opaque,
> +                                            Error **errp)
> +{
> +    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    uint32_t value;
> +
> +    if (!visit_type_uint32(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    if (value >= MAX_NODES) {
> +        error_printf("%s: Invalid NUMA node specified\n",
> +                     TYPE_ACPI_GENERIC_INITIATOR);
> +        exit(1);
> +    }
> +
> +    gi->node = value;
> +    ms->numa_state->nodes[gi->node].has_gi = true;
> +}
> +
> +static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
> +{
> +    object_class_property_add_str(oc, "pci-dev", NULL,
> +        acpi_generic_initiator_set_pci_device);
> +    object_class_property_add(oc, "node", "int", NULL,
> +        acpi_generic_initiator_set_node, NULL, NULL);
> +}
> +
> +static int build_acpi_generic_initiator(Object *obj, void *opaque)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    AcpiGenericInitiator *gi;
> +    GArray *table_data = opaque;
> +    int32_t devfn;
> +    uint8_t bus;
> +    Object *o;
> +
> +    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
> +        return 0;
> +    }
> +
> +    gi = ACPI_GENERIC_INITIATOR(obj);
> +    if (gi->node >= ms->numa_state->num_nodes) {
> +        error_printf("%s: Specified node %d is invalid.\n",
> +                     TYPE_ACPI_GENERIC_INITIATOR, gi->node);
> +        exit(1);
> +    }
> +
> +    o = object_resolve_path_type(gi->pci_dev, TYPE_PCI_DEVICE, NULL);
> +    if (!o) {
> +        error_printf("%s: Specified device must be a PCI device.\n",
> +                     TYPE_ACPI_GENERIC_INITIATOR);
> +        exit(1);
> +    }
> +
> +    bus = object_property_get_uint(o, "busnr", &error_fatal);
> +    devfn = object_property_get_uint(o, "addr", &error_fatal);
> +    /* devfn is constrained in PCI to be 8 bit but storage is an int32_t */
> +    assert(devfn >= 0 && devfn < PCI_DEVFN_MAX);
> +
> +    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
> +
> +    return 0;
> +}
> +
> +void build_srat_generic_pci_initiator(GArray *table_data)
> +{
> +    object_child_foreach_recursive(object_get_root(),
> +                                   build_acpi_generic_initiator,
> +                                   table_data);
> +}
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index e10cad86dd..a50b00b7c1 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -57,7 +57,6 @@
>  #include "migration/vmstate.h"
>  #include "hw/acpi/ghes.h"
>  #include "hw/acpi/viot.h"
> -#include "hw/acpi/acpi_generic_initiator.h"
>  #include "hw/virtio/virtio-acpi.h"
>  #include "target/arm/multiprocessing.h"
>  
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index f4e366f64f..ee92783836 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -68,7 +68,6 @@
>  #include "hw/acpi/utils.h"
>  #include "hw/acpi/pci.h"
>  #include "hw/acpi/cxl.h"
> -#include "hw/acpi/acpi_generic_initiator.h"
>  
>  #include "qom/qom-qobject.h"
>  #include "hw/i386/amd_iommu.h"
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index fa5c07db90..5441c9b1e4 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -1,6 +1,5 @@
>  acpi_ss = ss.source_set()
>  acpi_ss.add(files(
> -  'acpi_generic_initiator.c',
>    'acpi_interface.c',
>    'aml-build.c',
>    'bios-linker-loader.c',


