Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A8DC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 11:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRsOK-0006sY-8D; Thu, 11 Jul 2024 07:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sRsOI-0006lM-CE
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:55:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sRsO4-0003k4-BR
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720698898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GLUrFLCqikNAsPcbf03qUnXoJ46gCuQE0XBBtbkOSEc=;
 b=JDrBWO0QFFhiJpC6lC0td8McrkpL1dz6KoNk5XDyBLdcLN615hcD+3q/nFtrGv6t5pHrG2
 CM8RSNgNiiOm67wbK2FQs0VesDF2H8facNZajSEpfBUvauFl0XIQjG0PmrB+veNuMlaCdB
 ztZuGFe1SeKusPkmO/aFkzma5glYNUw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-nFwUfm6yMxi57f4WBjTXbA-1; Thu, 11 Jul 2024 07:54:55 -0400
X-MC-Unique: nFwUfm6yMxi57f4WBjTXbA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ee90339092so8380021fa.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 04:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720698893; x=1721303693;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLUrFLCqikNAsPcbf03qUnXoJ46gCuQE0XBBtbkOSEc=;
 b=WZ4yJ1hXfoswhYdZMRQ+dxVV2gPdfmEgNr67XJ58q5urubR+89K+F7Mi/nie8Tx4IV
 HYZV8QkPNWndbtH2Lj0hYvSe39RbnnUMjTOuq+6Fn5ZJ3/1V+cd4ZpYv3efczrKvSwlc
 xo+kFzB9Dc4IfEmQkAcg1zrriqo4+YFlI/Nw/h0dC8McrzkcqknMZW8WDYuoiuUPxz1o
 HJVSg2HOPsfpB3KxmGVwq5eu335UUFWo+rVZsD/EXQiLdLK4LHQrR3FRAE5oJl0bHOZn
 IGgPg4VI8irEe38yi+TQwl5QW+fhRs6m0a0ZDMJmV7jzGEdeHvJ9kLdylJNgwaJmV/uk
 QMOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQhVL2/3o+RpT7nhrqvkaV0Yl8QXDNPA+8IJKLUlg2Xw8YE9NS1tfyQDr958x+r6jev8d9VhG59mORYyGy310oAvGebTc=
X-Gm-Message-State: AOJu0Ywd88cdzC8yzsxEFRNTd2rsaImRe0njNIyTwoO9LvPHQTNt9/L1
 /D4YNHV1nbis7oBRA2gXTqpwTJ1Gl12Em+ucKd2+PYOczD3JmL++mW+nOGZf8nU1dX6HWKKDYHB
 AO7mT9JFoHLh4IbLxD5N3BjDqGVl64AuhO7ailv+XzGKa9O3Aovwd
X-Received: by 2002:a2e:90cc:0:b0:2ee:7a7e:8ebb with SMTP id
 38308e7fff4ca-2eeb3198b20mr51410511fa.52.1720698893668; 
 Thu, 11 Jul 2024 04:54:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdSlbHD+ZgkWTuRRwa17SNwKB4KIBO0IU5PmgF3bItPbAkUonL9qMh9qOg9B0O82tb2+tcog==
X-Received: by 2002:a2e:90cc:0:b0:2ee:7a7e:8ebb with SMTP id
 38308e7fff4ca-2eeb3198b20mr51410401fa.52.1720698892904; 
 Thu, 11 Jul 2024 04:54:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:341:761e:f82:fc9a:623b:3fd1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279accecf4sm17799785e9.39.2024.07.11.04.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 04:54:52 -0700 (PDT)
Date: Thu, 11 Jul 2024 07:54:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, linux-edac@kernel.org,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/6] arm/virt: Wire up GPIO error source for ACPI / GHES
Message-ID: <20240711075332-mutt-send-email-mst@kernel.org>
References: <cover.1720690278.git.mchehab+huawei@kernel.org>
 <b9cd4a65d3389102def662a8bc09ffaa622265f7.1720690278.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9cd4a65d3389102def662a8bc09ffaa622265f7.1720690278.git.mchehab+huawei@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Jul 11, 2024 at 11:52:03AM +0200, Mauro Carvalho Chehab wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Creates a GED - Generic Event Device and set a GPIO to
> be used or error injection.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/arm/virt-acpi-build.c | 29 +++++++++++++++++++++++++----
>  hw/arm/virt.c            | 12 +++++++++++-
>  include/hw/boards.h      |  1 +
>  3 files changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index e10cad86dd73..b6f2e55014a2 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -63,6 +63,7 @@
>  
>  #define ARM_SPI_BASE 32
>  
> +#define ACPI_GENERIC_EVENT_DEVICE "GEDD"
>  #define ACPI_BUILD_TABLE_SIZE             0x20000
>  
>  static void acpi_dsdt_add_cpus(Aml *scope, VirtMachineState *vms)
> @@ -155,9 +156,14 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
>  
>      Aml *aei = aml_resource_template();
>      /* Pin 3 for power button */
> -    const uint32_t pin_list[1] = {3};
> +    uint32_t pin = 3;
>      aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
> -                                 AML_EXCLUSIVE, AML_PULL_UP, 0, pin_list, 1,
> +                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
> +                                 "GPO0", NULL, 0));
> +    pin = 6;
> +    /* Pin 8 for generic error */

For real? Code says 6, comment says 8.

Comments must come before the code they comment, not after it,
then this kind of thing won't happen.


> +    aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
> +                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
>                                   "GPO0", NULL, 0));
>      aml_append(dev, aml_name_decl("_AEI", aei));
>  
> @@ -166,6 +172,11 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
>      aml_append(method, aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
>                                    aml_int(0x80)));
>      aml_append(dev, method);
> +    method = aml_method("_E06", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_notify(aml_name(ACPI_GENERIC_EVENT_DEVICE),
> +                                  aml_int(0x80)));
> +    aml_append(dev, method);
> +
>      aml_append(scope, dev);
>  }
>  
> @@ -800,6 +811,15 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
>      build_fadt(table_data, linker, &fadt, vms->oem_id, vms->oem_table_id);
>  }
>  
> +static void acpi_dsdt_add_generic_event_device(Aml *scope)
> +{
> +    Aml *dev = aml_device(ACPI_GENERIC_EVENT_DEVICE);
> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> +    aml_append(scope, dev);
> +}
> +
>  /* DSDT */
>  static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> @@ -842,9 +862,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                        irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE, AML_SYSTEM_MEMORY,
>                        memmap[VIRT_ACPI_GED].base);
>      } else {
> -        acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
> -                           (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
>      }
> +    acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
> +                       (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
>  
>      if (vms->acpi_dev) {
>          uint32_t event = object_property_get_uint(OBJECT(vms->acpi_dev),
> @@ -858,6 +878,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      }
>  
>      acpi_dsdt_add_power_button(scope);
> +    acpi_dsdt_add_generic_event_device(scope);
>  #ifdef CONFIG_TPM
>      acpi_dsdt_add_tpm(scope, vms);
>  #endif
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b0c68d66a345..874a8612ef2d 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -997,6 +997,13 @@ static void create_rtc(const VirtMachineState *vms)
>  }
>  
>  static DeviceState *gpio_key_dev;
> +
> +static DeviceState *gpio_error_dev;
> +static void virt_set_error(void)
> +{
> +    qemu_set_irq(qdev_get_gpio_in(gpio_error_dev, 0), 1);
> +}
> +
>  static void virt_powerdown_req(Notifier *n, void *opaque)
>  {
>      VirtMachineState *s = container_of(n, VirtMachineState, powerdown_notifier);
> @@ -1014,6 +1021,8 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
>  {
>      gpio_key_dev = sysbus_create_simple("gpio-key", -1,
>                                          qdev_get_gpio_in(pl061_dev, 3));
> +    gpio_error_dev = sysbus_create_simple("gpio-key", -1,
> +                                          qdev_get_gpio_in(pl061_dev, 6));
>  
>      qemu_fdt_add_subnode(fdt, "/gpio-keys");
>      qemu_fdt_setprop_string(fdt, "/gpio-keys", "compatible", "gpio-keys");
> @@ -2385,8 +2394,8 @@ static void machvirt_init(MachineState *machine)
>      if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
>          vms->acpi_dev = create_acpi_ged(vms);
>      } else {
> -        create_gpio_devices(vms, VIRT_GPIO, sysmem);
>      }
> +    create_gpio_devices(vms, VIRT_GPIO, sysmem);
>  
>      if (vms->secure && !vmc->no_secure_gpio) {
>          create_gpio_devices(vms, VIRT_SECURE_GPIO, secure_sysmem);
> @@ -3100,6 +3109,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      mc->default_ram_id = "mach-virt.ram";
>      mc->default_nic = "virtio-net-pci";
>  
> +    mc->set_error = virt_set_error;
>      object_class_property_add(oc, "acpi", "OnOffAuto",
>          virt_get_acpi, virt_set_acpi,
>          NULL, NULL);
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index ef6f18f2c1a7..6cf01f3934ae 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -304,6 +304,7 @@ struct MachineClass {
>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
>      ram_addr_t (*fixup_ram_size)(ram_addr_t size);
> +    void (*set_error)(void);
>  };
>  
>  /**
> -- 
> 2.45.2


