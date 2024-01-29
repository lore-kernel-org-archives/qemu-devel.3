Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EB2C47DDF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 05:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUJxD-0000nl-P6; Mon, 29 Jan 2024 00:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rUJx4-0000lT-Rp
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 00:12:59 -0500
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rUJx2-0001dg-Dy
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 00:12:58 -0500
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7bc332d49f6so103165539f.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 21:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706505174; x=1707109974; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X3hsOXabyf7PsVosDH8kLvhsbh4Sp3r+QQ5wYl0vhHw=;
 b=JsJmFu3OamyC6oh6HK6Y+IQMUhz71bcv7fE7BP4E2/NLXxKkOIGGkRzUJwnBoCRnuI
 5YXGYfCeZPihwLV5SvlheN8BJiWXwvDbSJZ9k2ZElhFuOwpwvUQUH+39J18x8ukwsNHc
 A5KgGsILmdm/RddJBGZBS+39t2NAgDSLlCv7Ununyf4zHRV6tOa3+akue7hAgqz1neQf
 7aMGwv041lGhznBtX+MBytW8gkmijlVPITV+gxendTK3W0uDFFBHL1+4n81oYca+h0FD
 jcUSmEoU4JxAfUT8BMkhF+BofmqnTnp+udlVLSQszDq+2vSx7MJBj5F1135kJ/Md3SPT
 IKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706505174; x=1707109974;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3hsOXabyf7PsVosDH8kLvhsbh4Sp3r+QQ5wYl0vhHw=;
 b=jN3kTtYkw4MXRg8NpcoUNqh/vfNCH2CwQnF2XfXKd5QM+lgOO0y63+rSbR9Yj+HQy8
 5J1fRJjsh9bk3CMOLCXk1+UgA2Z1jff2Lg0WTvX9PMub5vgxE1zNoVoqdgii48gUTPGp
 EE1s6gcflTrTlyrVHqTYJpNDB58qQfOoLDkkfqfXpWkMj57S3ckevrVKGiVv6NcxG3yR
 Sc0k0on587uUfNZTQGjXwmVNDUMYZdQ5I1SYbFEkYH3Ojty2IHNm/L2W/HCvqsXxLyil
 oI+l1k0MKiKl7wCD5o+Uv+EzLtqtl3wWvBeR1ay7rB3R1yOad/AhvUG4Yzhs0ORVSgu1
 axzA==
X-Gm-Message-State: AOJu0Yz1hzK1V+UWHUcopew111E2ThAni8I7JGwelcn5E17+N+7zstQF
 Ti/5thFEKzeo15NGg4p+mHlqXbU4cINUmqXQE6ERQHplJ9ry5mCSneDwzgAW6t0=
X-Google-Smtp-Source: AGHT+IEXL1SYdIBVNd5gu/tl7KsSl4zCJSS8xGRHzdWVyVJ4O+9Mvn/tp7UlNJqN3ULhqO4NhLrZsQ==
X-Received: by 2002:a92:dcd1:0:b0:363:7379:5fde with SMTP id
 b17-20020a92dcd1000000b0036373795fdemr5150375ilr.27.1706505174498; 
 Sun, 28 Jan 2024 21:12:54 -0800 (PST)
Received: from sunil-laptop ([106.51.190.212])
 by smtp.gmail.com with ESMTPSA id
 g21-20020a02b715000000b0046ee92bc557sm1583999jam.92.2024.01.28.21.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jan 2024 21:12:54 -0800 (PST)
Date: Mon, 29 Jan 2024 10:42:43 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: Re: [RESEND v2 1/2] hw/arm/virt-acpi-build.c: Migrate SPCR creation
 to common location
Message-ID: <Zbczy87+E0gJEzgw@sunil-laptop>
References: <20240129021440.17640-1-jeeheng.sia@starfivetech.com>
 <20240129021440.17640-2-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129021440.17640-2-jeeheng.sia@starfivetech.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-io1-xd2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Jee Heng,

On Sun, Jan 28, 2024 at 06:14:39PM -0800, Sia Jee Heng wrote:
> RISC-V should also generate the SPCR in a manner similar to ARM.
> Therefore, instead of replicating the code, relocate this function
> to the common AML build.
> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> ---
>  hw/acpi/aml-build.c         | 51 ++++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c    | 68 +++++++++++++++----------------------
>  include/hw/acpi/acpi-defs.h | 33 ++++++++++++++++++
>  include/hw/acpi/aml-build.h |  4 +++
>  4 files changed, 115 insertions(+), 41 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index af66bde0f5..f3904650e4 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1994,6 +1994,57 @@ static void build_processor_hierarchy_node(GArray *tbl, uint32_t flags,
>      }
>  }
>  
> +void build_spcr(GArray *table_data, BIOSLinker *linker,
> +                const AcpiSpcrData *f, const uint8_t rev,
> +                const char *oem_id, const char *oem_table_id)
> +{
> +    AcpiTable table = { .sig = "SPCR", .rev = rev, .oem_id = oem_id,
> +                        .oem_table_id = oem_table_id };
> +
> +    acpi_table_begin(&table, table_data);
> +    /* Interface type */
> +    build_append_int_noprefix(table_data, f->interface_type, 1);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 3);
> +    /* Base Address */
> +    build_append_gas(table_data, f->base_addr.id, f->base_addr.width,
> +                     f->base_addr.offset, f->base_addr.size,
> +                     f->base_addr.addr);
> +    /* Interrupt type */
> +    build_append_int_noprefix(table_data, f->interrupt_type, 1);
> +    /* IRQ */
> +    build_append_int_noprefix(table_data, f->pc_interrupt, 1);
> +    /* Global System Interrupt */
> +    build_append_int_noprefix(table_data, f->interrupt, 4);
> +    /* Baud Rate */
> +    build_append_int_noprefix(table_data, f->baud_rate, 1);
> +    /* Parity */
> +    build_append_int_noprefix(table_data, f->parity, 1);
> +    /* Stop Bits */
> +    build_append_int_noprefix(table_data, f->stop_bits, 1);
> +    /* Flow Control */
> +    build_append_int_noprefix(table_data, f->flow_control, 1);
> +    /* Terminal Type */
> +    build_append_int_noprefix(table_data, f->terminal_type, 1);
> +    /* PCI Device ID  */
> +    build_append_int_noprefix(table_data, f->pci_device_id, 2);
> +    /* PCI Vendor ID */
> +    build_append_int_noprefix(table_data, f->pci_vendor_id, 2);
> +    /* PCI Bus Number */
> +    build_append_int_noprefix(table_data, f->pci_bus, 1);
> +    /* PCI Device Number */
> +    build_append_int_noprefix(table_data, f->pci_device, 1);
> +    /* PCI Function Number */
> +    build_append_int_noprefix(table_data, f->pci_function, 1);
> +    /* PCI Flags */
> +    build_append_int_noprefix(table_data, f->pci_flags, 4);
> +    /* PCI Segment */
> +    build_append_int_noprefix(table_data, f->pci_segment, 1);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 4);
> +
I think either there should be a comment that this supports only v2 of
SPCR spec or it should be able to create SPCR of any version. IMO, I
think it is better to add support till v4 (latest). Since consumers like
Linux probably doesn't support v4 yet, ARM/RISC-V can continue to create
v2 itself for the time being but the generic build_spcr() should be able
to create v4 also if the arch requires it.

Thanks,
Sunil
> +    acpi_table_end(linker, &table);
> +}
>  /*
>   * ACPI spec, Revision 6.3
>   * 5.2.29 Processor Properties Topology Table (PPTT)
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index a22a2f43a5..195767c0f0 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -431,48 +431,34 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>   * Rev: 1.07
>   */
>  static void
> -build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> +spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
> -    AcpiTable table = { .sig = "SPCR", .rev = 2, .oem_id = vms->oem_id,
> -                        .oem_table_id = vms->oem_table_id };
> -
> -    acpi_table_begin(&table, table_data);
> -
> -    /* Interface Type */
> -    build_append_int_noprefix(table_data, 3, 1); /* ARM PL011 UART */
> -    build_append_int_noprefix(table_data, 0, 3); /* Reserved */
> -    /* Base Address */
> -    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 32, 0, 3,
> -                     vms->memmap[VIRT_UART].base);
> -    /* Interrupt Type */
> -    build_append_int_noprefix(table_data,
> -        (1 << 3) /* Bit[3] ARMH GIC interrupt */, 1);
> -    build_append_int_noprefix(table_data, 0, 1); /* IRQ */
> -    /* Global System Interrupt */
> -    build_append_int_noprefix(table_data,
> -                              vms->irqmap[VIRT_UART] + ARM_SPI_BASE, 4);
> -    build_append_int_noprefix(table_data, 3 /* 9600 */, 1); /* Baud Rate */
> -    build_append_int_noprefix(table_data, 0 /* No Parity */, 1); /* Parity */
> -    /* Stop Bits */
> -    build_append_int_noprefix(table_data, 1 /* 1 Stop bit */, 1);
> -    /* Flow Control */
> -    build_append_int_noprefix(table_data,
> -        (1 << 1) /* RTS/CTS hardware flow control */, 1);
> -    /* Terminal Type */
> -    build_append_int_noprefix(table_data, 0 /* VT100 */, 1);
> -    build_append_int_noprefix(table_data, 0, 1); /* Language */
> -    /* PCI Device ID  */
> -    build_append_int_noprefix(table_data, 0xffff /* not a PCI device*/, 2);
> -    /* PCI Vendor ID */
> -    build_append_int_noprefix(table_data, 0xffff /* not a PCI device*/, 2);
> -    build_append_int_noprefix(table_data, 0, 1); /* PCI Bus Number */
> -    build_append_int_noprefix(table_data, 0, 1); /* PCI Device Number */
> -    build_append_int_noprefix(table_data, 0, 1); /* PCI Function Number */
> -    build_append_int_noprefix(table_data, 0, 4); /* PCI Flags */
> -    build_append_int_noprefix(table_data, 0, 1); /* PCI Segment */
> -    build_append_int_noprefix(table_data, 0, 4); /* Reserved */
> +    AcpiSpcrData serial = {
> +        .interface_type = 3,       /* ARM PL011 UART */
> +        .base_addr.id = AML_AS_SYSTEM_MEMORY,
> +        .base_addr.width = 32,
> +        .base_addr.offset = 0,
> +        .base_addr.size = 3,
> +        .base_addr.addr = vms->memmap[VIRT_UART].base,
> +        .interrupt_type = (1 << 3),/* Bit[3] ARMH GIC interrupt*/
> +        .pc_interrupt = 0,         /* IRQ */
> +        .interrupt = (vms->irqmap[VIRT_UART] + ARM_SPI_BASE),
> +        .baud_rate = 3,            /* 9600 */
> +        .parity = 0,               /* No Parity */
> +        .stop_bits = 1,            /* 1 Stop bit */
> +        .flow_control = 1 << 1,    /* RTS/CTS hardware flow control */
> +        .terminal_type = 0,        /* VT100 */
> +        .language = 0,             /* Language */
> +        .pci_device_id = 0xffff,   /* not a PCI device*/
> +        .pci_vendor_id = 0xffff,   /* not a PCI device*/
> +        .pci_bus = 0,
> +        .pci_device = 0,
> +        .pci_function = 0,
> +        .pci_flags = 0,
> +        .pci_segment = 0,
> +    };
>  
> -    acpi_table_end(linker, &table);
> +    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_table_id);
>  }
>  
>  /*
> @@ -930,7 +916,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      }
>  
>      acpi_add_table(table_offsets, tables_blob);
> -    build_spcr(tables_blob, tables->linker, vms);
> +    spcr_setup(tables_blob, tables->linker, vms);
>  
>      acpi_add_table(table_offsets, tables_blob);
>      build_dbg2(tables_blob, tables->linker, vms);
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 2b42e4192b..0e6e82b339 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -90,6 +90,39 @@ typedef struct AcpiFadtData {
>      unsigned *xdsdt_tbl_offset;
>  } AcpiFadtData;
>  
> +typedef struct AcpiGas {
> +    uint8_t id;                /* Address space ID */
> +    uint8_t width;             /* Register bit width */
> +    uint8_t offset;            /* Register bit offset */
> +    uint8_t size;              /* Access size */
> +    uint64_t addr;             /* Address */
> +} AcpiGas;
> +
> +/* SPCR (Serial Port Console Redirection table) */
> +typedef struct AcpiSpcrData {
> +    uint8_t interface_type;
> +    uint8_t reserved[3];
> +    struct AcpiGas base_addr;
> +    uint8_t interrupt_type;
> +    uint8_t pc_interrupt;
> +    uint32_t interrupt;        /* Global system interrupt */
> +    uint8_t baud_rate;
> +    uint8_t parity;
> +    uint8_t stop_bits;
> +    uint8_t flow_control;
> +    uint8_t terminal_type;
> +    uint8_t language;
> +    uint8_t reserved1;
> +    uint16_t pci_device_id;    /* Must be 0xffff if not PCI device */
> +    uint16_t pci_vendor_id;    /* Must be 0xffff if not PCI device */
> +    uint8_t pci_bus;
> +    uint8_t pci_device;
> +    uint8_t pci_function;
> +    uint32_t pci_flags;
> +    uint8_t pci_segment;
> +    uint32_t reserved2;
> +} AcpiSpcrData;
> +
>  #define ACPI_FADT_ARM_PSCI_COMPLIANT  (1 << 0)
>  #define ACPI_FADT_ARM_PSCI_USE_HVC    (1 << 1)
>  
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index ff2a310270..a3784155cb 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -497,4 +497,8 @@ void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
>  
>  void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
>                  const char *oem_id, const char *oem_table_id);
> +
> +void build_spcr(GArray *table_data, BIOSLinker *linker,
> +                const AcpiSpcrData *f, const uint8_t rev,
> +                const char *oem_id, const char *oem_table_id);
>  #endif
> -- 
> 2.34.1
> 

