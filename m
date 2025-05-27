Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879B0C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 15:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJwfm-0002yH-94; Tue, 27 May 2025 11:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJwfj-0002vw-Pd
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJwfg-0005RA-Rj
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748361414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZp4OkMS0wneelPodZb02GukKgjqxfQUF5cHCQf+gw8=;
 b=Y2cU1tusxPd6FSgrXk4v8hk4n3bTtr/sCXJYK9QSxKZaKktvVPOBc5zrLgvhj8tMJp2u73
 gNhS7Q08/FX1oZNzEUHql1hUrpC8xAeGwviw6gNRdracihQ/iK1v4Pmrcc1bspBjFis4bu
 1hzA1xwrg2rFyUZFS83m4bmNgBC0ZO8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-rvpvNX62MPyQfHfculJqMA-1; Tue, 27 May 2025 11:56:53 -0400
X-MC-Unique: rvpvNX62MPyQfHfculJqMA-1
X-Mimecast-MFC-AGG-ID: rvpvNX62MPyQfHfculJqMA_1748361412
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-442f4a3851fso25984995e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 08:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748361412; x=1748966212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jZp4OkMS0wneelPodZb02GukKgjqxfQUF5cHCQf+gw8=;
 b=Og9NUozsAOSRF1ww20PkN6C0Eta7o33cQQEeVzIg/zyUZVAFn6iirrEQhg3KMp9vTi
 f/ERoxCbjVjLMzVXYDJXPyf+ZPFP++MtGM9vn4z3VwdfOm1Hz/NeDltSpzlO8fbkv25R
 CDcONnMmnwQ3mNHYQLxUp18upFqHpv0GCZ1V4NEfv1okTHmlMhH+9B+v/U3hoAdWA3UG
 IRHcDe4b6NeuwbtEgcxJHZ7m05eHoM5AUNN2uTJdR6eQ6oz8OloBNjiKA42SUk/Yi5R1
 2iGvnMGbTY4bgsDk19U62ZFLIX5jFLzgEzE3xHAMXgxWKUo0UsbPhbIIKHUEy87aD6i7
 rUMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq1WTIRw3yDSJpXXCecV2jF7V2NOuMSlp8hEFmjuQ61R0cn8gGHKhNBvOw1/ldMKBsiVhEmAPNgBeP@nongnu.org
X-Gm-Message-State: AOJu0Yw7eIUyTqaRqAowZnA8DR7qW4t3C4AEuhwnQgsDnPU851yX8+7c
 KAOUn0SvAtgIMAvCU21JJshZH/NUkKjP6hKI1bWh6kUIOkTtuq9cwsrUn4wdYGHte00UxgGS0eS
 yaDf1ujjXkla0GH3t83ki3eTo31CjccBjlGCm/xA1ayZMTlRhb3KY0ko6
X-Gm-Gg: ASbGncvMjyTYRRPDpIG0qASoovxoQtks4Q0QMON71HRu6RahnGtuKwGKnVtMOQtWFZJ
 D0sX8N6v4UMqsy+x5SQvp4Aj7csgDZG76Zf/+9ZSDWBrjmRzOvAibB+YCsTeHLhGtTTCGKnDhSn
 J104giCx9SZQX8i/YTpzWCGpKqiizghULBIN7iyAZCkCZRL/Bc/p4XxYbLmXGjW9hMyWDQHWM8v
 cyl1WLEaKAMbJpGtSsOz+FEg2uEjTuF0gVKxU2uxX+RO7Asgi63WdYms3i9q8HUciTDrWGLCF2g
 zVxCZ0vtdksJu1rzTGfyGGwPfuZzdPSA
X-Received: by 2002:a05:600c:3505:b0:43d:fa59:be39 with SMTP id
 5b1f17b1804b1-44c95aad969mr110281875e9.33.1748361411875; 
 Tue, 27 May 2025 08:56:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMo1kEeRQa9KZtdWtoTranRFVU26B52jCbmjM9UWKULmm9vvijLERo8sNNYLIiAmx9T9Un5Q==
X-Received: by 2002:a05:600c:3505:b0:43d:fa59:be39 with SMTP id
 5b1f17b1804b1-44c95aad969mr110281595e9.33.1748361411363; 
 Tue, 27 May 2025 08:56:51 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f3ce483bsm270077905e9.33.2025.05.27.08.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 08:56:50 -0700 (PDT)
Date: Tue, 27 May 2025 17:56:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 22/25] hw/arm/virt: Let virt support pci
 hotplug/unplug GED event
Message-ID: <20250527175649.5d276bc8@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527074224.1197793-23-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-23-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 27 May 2025 09:40:24 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Set up the IO registers used to communicate between QEMU
> and ACPI.



> Move the create_pcie() call after the creation of the acpi
> ged device since hotplug callbacks will soon be called on gpex
> realize and will require the acpi pcihp state to be initialized.
> 
> The hacky thing is the root bus has not yet been created on
> acpi_pcihp_init() call so it is set later after the gpex realize.

can you elaborate on this, preferably with call expected call flows?

> How to fix this chicken & egg issue?
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v1 -> v2:
> - use ACPI_PCIHP_REGION_NAME
> ---
>  include/hw/arm/virt.h    |  1 +
>  hw/arm/virt-acpi-build.c |  1 +
>  hw/arm/virt.c            | 42 +++++++++++++++++++++++++++++++++++-----
>  3 files changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 1b2e2e1284..a4c4e3a67a 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -35,6 +35,7 @@
>  #include "hw/boards.h"
>  #include "hw/arm/boot.h"
>  #include "hw/arm/bsa.h"
> +#include "hw/acpi/pcihp.h"
>  #include "hw/block/flash.h"
>  #include "system/kvm.h"
>  #include "hw/intc/arm_gicv3_common.h"
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 9d88ffc318..cd49f67d60 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -44,6 +44,7 @@
>  #include "hw/acpi/generic_event_device.h"
>  #include "hw/acpi/tpm.h"
>  #include "hw/acpi/hmat.h"
> +#include "hw/acpi/pcihp.h"
>  #include "hw/pci/pcie_host.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bus.h"
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 4aa40c8e8b..cdcff0a984 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -682,6 +682,8 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>  {
>      DeviceState *dev;
>      MachineState *ms = MACHINE(vms);
> +    SysBusDevice *sbdev;
> +
>      int irq = vms->irqmap[VIRT_ACPI_GED];
>      uint32_t event = ACPI_GED_PWR_DOWN_EVT;
>  
> @@ -693,12 +695,28 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>          event |= ACPI_GED_NVDIMM_HOTPLUG_EVT;
>      }
>  
> +    if (vms->acpi_pcihp) {
> +        event |= ACPI_GED_PCI_HOTPLUG_EVT;
> +    }
> +
>      dev = qdev_new(TYPE_ACPI_GED);
>      qdev_prop_set_uint32(dev, "ged-event", event);
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sbdev = SYS_BUS_DEVICE(dev);
> +    sysbus_realize_and_unref(sbdev, &error_fatal);
>  
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_ACPI_GED].base);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, vms->memmap[VIRT_PCDIMM_ACPI].base);
> +    sysbus_mmio_map(sbdev, 0, vms->memmap[VIRT_ACPI_GED].base);
> +    sysbus_mmio_map(sbdev, 1, vms->memmap[VIRT_PCDIMM_ACPI].base);


Perhaps move out sbdev renaming into a separate patch, as it's not really related.

> +    if (vms->acpi_pcihp) {
> +        AcpiGedState *acpi_ged_state = ACPI_GED(dev);
> +        int i;
> +
> +        i = sysbus_mmio_map_name(sbdev, ACPI_PCIHP_REGION_NAME,
> +                                 vms->memmap[VIRT_ACPI_PCIHP].base);

I don't like mix of old way (index based) above and new name based mapping,
can we use the same, please?

> +        assert(i >= 0);
g_assert(sysbus_mmio_map_name...) to get more meaning-full crash
that is not compiled out.

> +        acpi_pcihp_init(OBJECT(dev), &acpi_ged_state->pcihp_state,
> +                        vms->bus, sysbus_mmio_get_region(sbdev, i), 0);

hmm, looks broken..
 region mapping must happen after acpi_pcihp_init().

if we after making sysbus_mmio_map() sane and easier to use
(which is a bit on tangent to this series).
We could feed sysbus owner device a memory map (ex: name based),
and then use [pre_]plug handlers on sysbus to map children
automatically.
That will alleviate need to do all mapping manually in every board.
(frankly speaking it deserves its own series, with tree wide cleanup).

As it is I'd use old index based approach like the rest.
(unless you feel adventurous about sysbus refactoring)


> +        acpi_ged_state->pcihp_state.use_acpi_hotplug_bridge = true;
> +    }
>      sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(vms->gic, irq));
>  
>      return dev;
> @@ -1758,6 +1776,13 @@ void virt_machine_done(Notifier *notifier, void *data)
>      pci_bus_add_fw_cfg_extra_pci_roots(vms->fw_cfg, vms->bus,
>                                         &error_abort);


> +
> +    if (vms->acpi_pcihp) {
> +        AcpiGedState *acpi_ged_state = ACPI_GED(vms->acpi_dev);
> +
> +        acpi_pcihp_reset(&acpi_ged_state->pcihp_state);
> +    }
> +
>      virt_acpi_setup(vms);
>      virt_build_smbios(vms);
>  }
> @@ -2395,8 +2420,6 @@ static void machvirt_init(MachineState *machine)
>  
>      create_rtc(vms);
>  
> -    create_pcie(vms);
> -
>      if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
>          vms->acpi_pcihp &= !vmc->no_acpi_pcihp;
>          vms->acpi_dev = create_acpi_ged(vms);
> @@ -2405,6 +2428,15 @@ static void machvirt_init(MachineState *machine)
>          create_gpio_devices(vms, VIRT_GPIO, sysmem);
>      }
>  
> +    create_pcie(vms);
> +
> +    if (vms->acpi_dev) {
> +        AcpiGedState *acpi_ged_state = ACPI_GED(vms->acpi_dev);
> +
> +        acpi_ged_state = ACPI_GED(vms->acpi_dev);
> +        acpi_ged_state->pcihp_state.root = vms->bus;
> +    }
> +
>      if (vms->secure && !vmc->no_secure_gpio) {
>          create_gpio_devices(vms, VIRT_SECURE_GPIO, secure_sysmem);
>      }

I don't like pulling acpi_pcihp_init()/reset (and issues it causes) into board code,
on x86 it's a part of host bridge device model.
The same should apply to GED device.

The only thing board has to do is map regions into IO space like we do
everywhere else.

with current code, may be add link<pci_bus> property to GED,
and set it before GED realize in create_acpi_ged(),
then just follow existing sysbus_mmio_map() pattern.


