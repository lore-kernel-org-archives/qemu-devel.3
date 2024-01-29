Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B5DC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 09:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUNnh-0004om-P6; Mon, 29 Jan 2024 04:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rUNnN-0004kc-J1
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:19:17 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rUNnJ-0005CD-I3
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:19:12 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a2f22bfb4e6so370860566b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 01:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706519945; x=1707124745; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z1Iz0NXm8lZKCaX5Vu1diFa6lfHDRFty58QoqBOmom8=;
 b=MiYXsbmd1spaAVDadc2EsgGB2KVwh+PsHDvl1WmTIrgWEpfq1AS59L01Jt3R+u097+
 cHfzILJzstgKKK2bV3lBd70RyCaONEsxCOJ6szRIbG34dTWOBRdsgdGL87GpNPf5TpWE
 0gAtuZUuc3oozNPJikizKKEUWpbFCPqA6pLQxPXiqSiI/6njEaM9StmQt2FtvEmH2bFM
 1z5F7wxL8U3+cV4UD4S8w9Mh7KU68n6XHCeGrUGagfB0qzsJBN0E+7bKplsBPrM5kFiz
 qQQBFRycxdMWeQfbXkDp9/kDARPm45uiSp3Yk1HkThM6gIg2+03fcu3kVH9fagzkII56
 T/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706519945; x=1707124745;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z1Iz0NXm8lZKCaX5Vu1diFa6lfHDRFty58QoqBOmom8=;
 b=m4IgWocWp39n3flZYOuZqJniMsEkKu3cEZNZE/wbhNfdW7Bl2wK8D8nyKro3PF9my4
 ugeUBZwDJR+0yNnimtkCwnk8mwebK/MRtLCuMhxCyTAb2/VpYy7SqzapT46tKQsQgX9g
 xkPDKb7E/O+gqkXxjXcRVWj5YXcgTYaeeT4je0x4vUslgfvSEZLMNhUcXmP1llSdit+R
 5QEEs0Lbsh2wPWJd1+s3BaGtKqoSwJDYD/47IN0uP4WLc0JZBPVrb/TD/O1hyfje1Ixs
 uYn1iOA846N0MhPaI03AyXje0PsYQgSblIjUeQz63HHWe3lVThvcveQXf64QR6jwd9Ar
 rLRA==
X-Gm-Message-State: AOJu0Ywg0QhziHSW0f6XkgGRMbrTJKM0GwmB61HMbaOP9Qr+gXEsXPC2
 sYEjEkJzmWCdqFlVZwneMgceSbLYkXt78OM97UhY3XFpUkvZ8xvHp8ruqrBO9VM=
X-Google-Smtp-Source: AGHT+IF3AcSBCnrhvowGY96NJtm3PxdIrHebqRj3h5iTxP/LdHb+se7Ok7NnANsGS6Qd4Vxmc6za0Q==
X-Received: by 2002:a17:906:1196:b0:a35:f361:724 with SMTP id
 n22-20020a170906119600b00a35f3610724mr57509eja.21.1706519945155; 
 Mon, 29 Jan 2024 01:19:05 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 tx18-20020a1709078e9200b00a3551f727d1sm2350257ejc.68.2024.01.29.01.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 01:19:04 -0800 (PST)
Date: Mon, 29 Jan 2024 10:19:03 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: Re: [RESEND v2 1/2] hw/arm/virt-acpi-build.c: Migrate SPCR creation
 to common location
Message-ID: <20240129-e51095f37656f4ba5262ec68@orel>
References: <20240129021440.17640-1-jeeheng.sia@starfivetech.com>
 <20240129021440.17640-2-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129021440.17640-2-jeeheng.sia@starfivetech.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Sharing code is good, but if we have to parametrize the entire table, then
we might as well keep Arm and RISCV separate. Building the table first
with this struct, just to have it built again with the build_append API,
doesn't make much sense to me. Do Arm and riscv really diverge on all
these parameters? If not, then just add the parameters which do diverge
build_scpr's arguments.

Thanks,
drew


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
> 

