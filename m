Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC01DC3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 08:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYiLO-0007kr-DF; Tue, 30 Jul 2024 04:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sYiLN-0007gS-7r
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sYiLL-0005av-BI
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722328585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZvxrDQmClMXIYrFtS427ByaFNgahNTrWr4i/x1An7w=;
 b=hq/ofLGvxlZ6UzX5Ha15MbdQacMtRUTXeNCfKhuMkVF2qAA34kEUQAkiiqtRd+RqROcdfU
 /Gxbo6yVX7mxE9N865if1BNOkuf/VbZV0un2i/4WkFnjrNfHHPvCh5D8ucVhwOHQr6jhF4
 XGGlVDDsbn9tW4UepfmqVhPZTlYblxA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-AEXACLTwOwGrwQkpQ1WO2w-1; Tue, 30 Jul 2024 04:36:19 -0400
X-MC-Unique: AEXACLTwOwGrwQkpQ1WO2w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4280d8e685eso25327935e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 01:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722328578; x=1722933378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jZvxrDQmClMXIYrFtS427ByaFNgahNTrWr4i/x1An7w=;
 b=HM6tUoL4pUWtxFeb09MJNkAYppCizU0W/NRENY7ixVDZEDDNDvTCkphHarGKukX7+R
 CqkwKZ4y9jwyMwlGqmPN8XsTi4Rh2LvviyFirnP0c2QpgHXltVUQgCX4EjvbVuUpuvOb
 JbgdqjWr1pEMaiZnsPqGK4vLqGAHZmQ+z2D4hiQN4bP3gv3DBv/21YOp4ZRRg/9QQuuQ
 Dr2TixmKFpuJxlGurq9e7iFKmaZSTIyd3ngkLvoqRN9DaWCJWyBGelJpKLEJxbywrDKC
 NdrZgg4K+J/KTt7dSztVsLTvN78Dp89MJ5tZIQ4qt+Pu/D6mzfKqYcirmHWYQI1C2UPF
 +uZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUooe4usRLu7Z2S3e/L7WDhdZ4FT0FQ6KQeKoGWJn3WeFdjuMuNbqs4JjfCKnavDFeVyyeoOqeN0Uf/B30BctUIBgfaKLM=
X-Gm-Message-State: AOJu0YwyfglH2igegfhhjiczP9yMXpwlABDfoIMYLJbJX7X0xWZIJgxo
 3tKJJfbPO+4eNN168RVmk8vyqM66f9LaQ4nqQU7liRmaj22thDlKOivG/tdZPns/a/FRWFcimbs
 PTc/dcCGqghg/z4phzOpCPg5X7W9FM8ADIALN3q7MyedLC4CNkWG9
X-Received: by 2002:adf:e707:0:b0:367:9088:fecc with SMTP id
 ffacd0b85a97d-36b5d0b04a6mr7637662f8f.7.1722328578269; 
 Tue, 30 Jul 2024 01:36:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFX4uoGu0ltyAIFOKyUsPySdzb1wHut0ofsSOLJt5xD+DWRL85w43RjRJ8JmCYg6vsfKakvPQ==
X-Received: by 2002:adf:e707:0:b0:367:9088:fecc with SMTP id
 ffacd0b85a97d-36b5d0b04a6mr7637636f8f.7.1722328577802; 
 Tue, 30 Jul 2024 01:36:17 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36861b11sm14072497f8f.96.2024.07.30.01.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 01:36:17 -0700 (PDT)
Date: Tue, 30 Jul 2024 10:36:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan
 Wang <wangyanan55@huawei.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v3 2/7] arm/virt: Wire up GPIO error source for ACPI / GHES
Message-ID: <20240730103615.5bb7613a@imammedo.users.ipa.redhat.com>
In-Reply-To: <034a7e86761e09996001394c98ffb8201ac52cd2.1721630625.git.mchehab+huawei@kernel.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <034a7e86761e09996001394c98ffb8201ac52cd2.1721630625.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, 22 Jul 2024 08:45:54 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Creates a GED - Generic Event Device and set a GPIO to
> be used or error injection.

QEMU already has GED device, so question is why it wasn't
used for event delivery?
I nutshell, I'd really prefer this series being rewritten
to reuse exiting GED instead of adding ad hoc GPIO and ACPI
plumbing.

PS:
as side effect of that, error injection could be used no only for
ARM but other machines that use GED (providing they implement GHES) 

Also CCing Shameer wrt touched power button code

> [mchehab: use a define for the generic event pin number and do some cleanups]
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/arm/virt-acpi-build.c | 30 ++++++++++++++++++++++++++----
>  hw/arm/virt.c            | 14 ++++++++++++--
>  include/hw/arm/virt.h    |  1 +
>  include/hw/boards.h      |  1 +
>  4 files changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f76fb117adff..c502ccf40909 100644
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
> @@ -142,6 +143,8 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>  static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
>                                             uint32_t gpio_irq)

this function supposed to be called when acpi_dev is not present (exiting GED device)
and run on old machines only, so it should not be called for recent machine types.
I'd avoid adding anything to it.

see more comment about it below

>  {
> +    uint32_t pin;
> +
>      Aml *dev = aml_device("GPO0");
>      aml_append(dev, aml_name_decl("_HID", aml_string("ARMH0061")));
>      aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> @@ -155,7 +158,12 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
>  
>      Aml *aei = aml_resource_template();
>  
> -    const uint32_t pin = GPIO_PIN_POWER_BUTTON;
> +    pin = GPIO_PIN_POWER_BUTTON;
> +    aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
> +                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
> +                                 "GPO0", NULL, 0));
> +    /* Pin for generic error */
> +    pin = GPIO_PIN_GENERIC_ERROR;
>      aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
>                                   AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
>                                   "GPO0", NULL, 0));
> @@ -166,6 +174,11 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
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
> @@ -800,6 +813,15 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
>      build_fadt(table_data, linker, &fadt, vms->oem_id, vms->oem_table_id);
>  }
>  
> +static void acpi_dsdt_add_generic_event_device(Aml *scope)
> +{
> +    Aml *dev = aml_device(ACPI_GENERIC_EVENT_DEVICE);
> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
this is not _event_ device, it's referred as _error_ device in spec.

PS:
please properly document new ACPI primitives/devices,
see comment above aml_notify() for example.
Use earliest APIC spec where the device was defined for the 1st time.

> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> +    aml_append(scope, dev);
> +}
> +
>  /* DSDT */
>  static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> @@ -841,10 +863,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                        HOTPLUG_HANDLER(vms->acpi_dev),
>                        irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE, AML_SYSTEM_MEMORY,
>                        memmap[VIRT_ACPI_GED].base);
> -    } else {
> -        acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
> -                           (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
>      }
> +    acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
> +                       (irqmap[VIRT_GPIO] + ARM_SPI_BASE));

wouldn't that create double/conflicting power button handlers
(GPIO and GED one), on recent machine types GED should be used
and power button in acpi_dsdt_add_gpio() is used only if
machine doesn't have GED.

>  
>      if (vms->acpi_dev) {
>          uint32_t event = object_property_get_uint(OBJECT(vms->acpi_dev),
> @@ -858,6 +879,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      }
>  
>      acpi_dsdt_add_power_button(scope);
> +    acpi_dsdt_add_generic_event_device(scope);
>  #ifdef CONFIG_TPM
>      acpi_dsdt_add_tpm(scope, vms);
>  #endif
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index c99c8b1713c6..f81cf3a69961 100644
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
> @@ -1015,6 +1022,9 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
>      gpio_key_dev = sysbus_create_simple("gpio-key", -1,
>                                          qdev_get_gpio_in(pl061_dev,
>                                                           GPIO_PIN_POWER_BUTTON));
> +    gpio_error_dev = sysbus_create_simple("gpio-key", -1,
> +                                          qdev_get_gpio_in(pl061_dev,
> +                                                           GPIO_PIN_GENERIC_ERROR));
>  
>      qemu_fdt_add_subnode(fdt, "/gpio-keys");
>      qemu_fdt_setprop_string(fdt, "/gpio-keys", "compatible", "gpio-keys");
> @@ -2385,9 +2395,8 @@ static void machvirt_init(MachineState *machine)
>  
>      if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
>          vms->acpi_dev = create_acpi_ged(vms);
> -    } else {
> -        create_gpio_devices(vms, VIRT_GPIO, sysmem);
>      }
> +    create_gpio_devices(vms, VIRT_GPIO, sysmem);

again, this create duplicate/conflicting power button source

>  
>      if (vms->secure && !vmc->no_secure_gpio) {
>          create_gpio_devices(vms, VIRT_SECURE_GPIO, secure_sysmem);
> @@ -3101,6 +3110,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      mc->default_ram_id = "mach-virt.ram";
>      mc->default_nic = "virtio-net-pci";
>  
> +    mc->set_error = virt_set_error;
>      object_class_property_add(oc, "acpi", "OnOffAuto",
>          virt_get_acpi, virt_set_acpi,
>          NULL, NULL);
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index a4d937ed45ac..c9769d7d4d7f 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -49,6 +49,7 @@
>  
>  /* GPIO pins */
>  #define GPIO_PIN_POWER_BUTTON  3
> +#define GPIO_PIN_GENERIC_ERROR 6
>  
>  enum {
>      VIRT_FLASH,
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


