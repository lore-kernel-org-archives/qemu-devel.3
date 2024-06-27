Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF926C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMosa-0004U2-1I; Thu, 27 Jun 2024 09:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMosU-0004TV-LJ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:09:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMosM-0004LC-LQ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719493758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8wcA7ISwGfHt02LqB5va1uV52y1R748xcCylRIffVeI=;
 b=iRHKRgG/WqR6xlgc1Ja5W/Xz0LfZCPijY8v5akBxVF0/5Xlfa/eqMwuUdnyRKPZLSVzsKV
 zvX0dGS/L8nQ3d8tUfHSgVuEjphSd0M5VxOxSjtFMhsSyj63gM3l8EjKfMciBXq9vfDFJj
 G38ZQnVyQPZSc2WagcYHtT1W0vplU4o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-BF9HvUImMaOje0nKSidxxA-1; Thu, 27 Jun 2024 09:09:15 -0400
X-MC-Unique: BF9HvUImMaOje0nKSidxxA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42568f0cc18so350465e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719493754; x=1720098554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8wcA7ISwGfHt02LqB5va1uV52y1R748xcCylRIffVeI=;
 b=MvMxc4A6tUsz+Sf10HnHlgrTZE2MZo8dGXiuVGKsgLdNSCfna7Im2O8xvlWU28o89z
 yRdDBJ6hJm+Fq60v3x3+lvBW4CxZQEurJlaUSjnIqHPbDy7zVtP0+L6GE5NfaTj9XXK9
 tJg6wjwnyQnrld8wW2CjxSN7v9OV648n3rpQvi76oe+nNzd6pWlx4SY4sunyc92C4zOP
 bVjCBsafIe+QndRXjRI1SbDHZ0gePxkx0yNKvNoJDyKRZCaExIOcZ+dfXhRA0rs2rOwh
 Q1+Sbswxh8hOTAbmZ3g44oIV9FpD8NcgvFn0RVbpB5/hp1zdD0sl5tQ3Zj7uKNQSTCqN
 nOXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTa0MZ2zQtkbz3tWDSA3b8QDj7P6Aek93yiIIWrpKz6FYsM5T3QqDE1wpq9KDaOqlUZ5XJcE96jH9LPaeEnD6bB9xHpGw=
X-Gm-Message-State: AOJu0YzhEHcAFgtc7cjaniXD8iNW4CdeF0K+4WgAocQXDaQSRZJuv1/H
 71jVkcRyEWY5RUi2yPpcbU2t/es1UcZt94OzB1O+rcbWGfgizcUCA0Bp9Agl46mNeP2uKbQN7pH
 X6FVZLLtLc+fxUigNcWzdaIu+WBVOREiTFuys3XzlSFnVe8zZDh/E
X-Received: by 2002:a05:6000:154d:b0:366:e508:c7d7 with SMTP id
 ffacd0b85a97d-366e508c9d5mr11928438f8f.7.1719493754045; 
 Thu, 27 Jun 2024 06:09:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRkM81XmKbLAJ5BzgiY5vOkvLGjClh12fRigKHCMVv9dqg8B/z9ZC/Gt5msG3nEsOlgKj6Rg==
X-Received: by 2002:a05:6000:154d:b0:366:e508:c7d7 with SMTP id
 ffacd0b85a97d-366e508c9d5mr11928416f8f.7.1719493753625; 
 Thu, 27 Jun 2024 06:09:13 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36743699b19sm1840140f8f.73.2024.06.27.06.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 06:09:13 -0700 (PDT)
Date: Thu, 27 Jun 2024 15:09:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 05/11] hw/pci: Add a bus property to pci_props and
 use for acpi/gi
Message-ID: <20240627150912.6ce774b1@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240620160324.109058-6-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
 <20240620160324.109058-6-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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

On Thu, 20 Jun 2024 17:03:13 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Using a property allows us to hide the internal details of the PCI device
> from the code to build a SRAT Generic Initiator Affinity Structure with
> PCI Device Handle.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> V3: New patch
> ---
>  hw/acpi/acpi_generic_initiator.c | 11 ++++++-----
>  hw/pci/pci.c                     | 14 ++++++++++++++
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> index 73bafaaaea..34284359f0 100644
> --- a/hw/acpi/acpi_generic_initiator.c
> +++ b/hw/acpi/acpi_generic_initiator.c
> @@ -9,6 +9,7 @@
>  #include "hw/boards.h"
>  #include "hw/pci/pci_device.h"
>  #include "qemu/error-report.h"
> +#include "qapi/error.h"
>  
>  typedef struct AcpiGenericInitiatorClass {
>      ObjectClass parent_class;
> @@ -79,7 +80,7 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
>      MachineState *ms = MACHINE(qdev_get_machine());
>      AcpiGenericInitiator *gi;
>      GArray *table_data = opaque;
> -    PCIDevice *pci_dev;
> +    uint8_t bus, devfn;
>      Object *o;
>  
>      if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
> @@ -100,10 +101,10 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
>          exit(1);
>      }
>  
> -    pci_dev = PCI_DEVICE(o);
> -    build_srat_pci_generic_initiator(table_data, gi->node, 0,
> -                                     pci_bus_num(pci_get_bus(pci_dev)),
> -                                     pci_dev->devfn);
> +    bus = object_property_get_uint(o, "bus", &error_fatal);
> +    devfn = object_property_get_uint(o, "addr", &error_fatal);
> +
> +    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
>  
>      return 0;
>  }
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 324c1302d2..b4b499b172 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -67,6 +67,19 @@ static char *pcibus_get_fw_dev_path(DeviceState *dev);
>  static void pcibus_reset_hold(Object *obj, ResetType type);
>  static bool pcie_has_upstream_port(PCIDevice *dev);
>  
> +static void prop_pci_bus_get(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    uint8_t bus = pci_dev_bus_num(PCI_DEVICE(obj));
> +
> +    visit_type_uint8(v, name, &bus, errp);
> +}
> +
> +static const PropertyInfo prop_pci_bus = {
> +    .name = "bus",

/me confused,
didn't we have 'bus' property for PCI devices already?

i.e. I can add PCI device like this
  -device e1000,bus=pci.0,addr=0x6,...
  

> +    .get = prop_pci_bus_get,
> +};
> +
>  static Property pci_props[] = {
>      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>      DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
> @@ -85,6 +98,7 @@ static Property pci_props[] = {
>                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
>      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
>                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> +    { .name = "bus", .info = &prop_pci_bus },
>      DEFINE_PROP_END_OF_LIST()
>  };
>  


