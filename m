Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04589C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 03:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raSP7-0000hW-6r; Wed, 14 Feb 2024 22:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raSP6-0000hF-Cq; Wed, 14 Feb 2024 22:27:16 -0500
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raSP4-0000V6-Du; Wed, 14 Feb 2024 22:27:16 -0500
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7ce3c7566e0so195075241.1; 
 Wed, 14 Feb 2024 19:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707967632; x=1708572432; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++BCDDwEfyWHf7sv3j/2aFDaF6Kf25MAYwqOLnXTzeQ=;
 b=X9Z+Cm94B4PknaXLZKKY7QEIdjcd9aX9mkHCPOfTow/Eenrv7MUK4zFORYw97k3NK/
 +cTiZTlVTh+ZxGHAFEhfILOb3IDKA2A1HhPOS9JLsDc1uR87CD39pF2sbM5+ZD+T+3V2
 rC/v/abCgFfoahdtgbkurxCS19UYvM27+TLz3RXUdQshiKbrSP1/hn4Etkxhh9QeOq7s
 zrtLYqu3Udj+gA24WIGW/s+leNGpygWENj+av+NQjAjzaROD1RzEdqcKuR3wfc19HKfZ
 FDhIKQV0562ERBjkqx/YbJR3elWkIYKMTxkqFLymjQDRm4kYsJJSyK0tanKmngpYroGq
 Om1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707967632; x=1708572432;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=++BCDDwEfyWHf7sv3j/2aFDaF6Kf25MAYwqOLnXTzeQ=;
 b=IkzGBPcYT/fFwBuAnMO7KPJP/xQe85JbSFIw4MqpDB0EFs8ZbGDak+Pj+Uo9x47VLf
 NH8gibqSbgXj4AzDvbKt6b6B8B1brG8ITyf32iW7U8sMnMyo6B2ma2YnNsnpKltZuvUH
 Fy2L7q9b/GhiGiuuM+uIGtlsXhvi9LKMkJtciIWChJxjPy+OEz9oKC8P+5eINlwXhurR
 9X6c1TXuAWJPjWa7HePq4XSnIKBlXNDZhjRf86/C1RreC7XNFGGknKNCi6FMDS+iVM+b
 hEh09Vhufso4X1eWDGAbiv1EzyL/BRWDJvL1BtN+45dwEuriBTyEmNDRfhuLtYJfC2IF
 F7pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjcN4R7YoYkVSijz2HvNowvwPTHXwAdHkXMbN1TwsJVGWodr662pDGkkt/MSbGAKjHOaausq1EdIGcD7u1m/cjxjSyydjnny48rsH/BTsj9Arm87oGQwDVgEoD0w==
X-Gm-Message-State: AOJu0YwkIs/8zKBsxvqPHlIm4mgQZRM0ifocZHYEV4Zs3oBAt1fOK5uh
 +4NAAH6KSmpr9bv8nwQGkJS4StQp0fx69kr97M2g+5pHTzJ6auKyyPkavZkNd1EepuUrMoJK2ms
 PECUPlQrW7U0zQTHwE6v4WrOSTso=
X-Google-Smtp-Source: AGHT+IGhebV/4yruRR+566QSiczBw0rNk39MAuOxOc9KfmDL3RxxGdWt7b2IuCLp+S7jSpS8zhIg4URFcdwTDZ3T6tk=
X-Received: by 2002:a1f:d784:0:b0:4c0:2bdc:250f with SMTP id
 o126-20020a1fd784000000b004c02bdc250fmr353799vkg.7.1707967632347; Wed, 14 Feb
 2024 19:27:12 -0800 (PST)
MIME-Version: 1.0
References: <20240116010930.43433-1-jeeheng.sia@starfivetech.com>
 <20240116010930.43433-2-jeeheng.sia@starfivetech.com>
In-Reply-To: <20240116010930.43433-2-jeeheng.sia@starfivetech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 13:26:45 +1000
Message-ID: <CAKmqyKP6YNhXaOU=4-y7NbwMnXAfqW7KRMatiGOK2zjiYAqmqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/arm/virt-acpi-build.c: Migrate SPCR creation to
 common location
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Jan 16, 2024 at 11:11=E2=80=AFAM Sia Jee Heng
<jeeheng.sia@starfivetech.com> wrote:
>
> RISC-V should also generate the SPCR in a manner similar to ARM.
> Therefore, instead of replicating the code, relocate this function
> to the common AML build.
>
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> @@ -1994,6 +1994,57 @@ static void build_processor_hierarchy_node(GArray =
*tbl, uint32_t flags,
>      }
>  }
>
> +void build_spcr(GArray *table_data, BIOSLinker *linker,
> +                const AcpiSpcrData *f, const uint8_t rev,
> +                const char *oem_id, const char *oem_table_id)
> +{
> +    AcpiTable table =3D { .sig =3D "SPCR", .rev =3D rev, .oem_id =3D oem=
_id,
> +                        .oem_table_id =3D oem_table_id };
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
> @@ -431,48 +431,34 @@ build_iort(GArray *table_data, BIOSLinker *linker, =
VirtMachineState *vms)
>   * Rev: 1.07
>   */
>  static void
> -build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms=
)
> +spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms=
)
>  {
> -    AcpiTable table =3D { .sig =3D "SPCR", .rev =3D 2, .oem_id =3D vms->=
oem_id,
> -                        .oem_table_id =3D vms->oem_table_id };
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
> -    build_append_int_noprefix(table_data, 3 /* 9600 */, 1); /* Baud Rate=
 */
> -    build_append_int_noprefix(table_data, 0 /* No Parity */, 1); /* Pari=
ty */
> -    /* Stop Bits */
> -    build_append_int_noprefix(table_data, 1 /* 1 Stop bit */, 1);
> -    /* Flow Control */
> -    build_append_int_noprefix(table_data,
> -        (1 << 1) /* RTS/CTS hardware flow control */, 1);
> -    /* Terminal Type */
> -    build_append_int_noprefix(table_data, 0 /* VT100 */, 1);
> -    build_append_int_noprefix(table_data, 0, 1); /* Language */
> -    /* PCI Device ID  */
> -    build_append_int_noprefix(table_data, 0xffff /* not a PCI device*/, =
2);
> -    /* PCI Vendor ID */
> -    build_append_int_noprefix(table_data, 0xffff /* not a PCI device*/, =
2);
> -    build_append_int_noprefix(table_data, 0, 1); /* PCI Bus Number */
> -    build_append_int_noprefix(table_data, 0, 1); /* PCI Device Number */
> -    build_append_int_noprefix(table_data, 0, 1); /* PCI Function Number =
*/
> -    build_append_int_noprefix(table_data, 0, 4); /* PCI Flags */
> -    build_append_int_noprefix(table_data, 0, 1); /* PCI Segment */
> -    build_append_int_noprefix(table_data, 0, 4); /* Reserved */
> +    AcpiSpcrData serial =3D {
> +        .interface_type =3D 3,       /* ARM PL011 UART */
> +        .base_addr.id =3D AML_AS_SYSTEM_MEMORY,
> +        .base_addr.width =3D 32,
> +        .base_addr.offset =3D 0,
> +        .base_addr.size =3D 3,
> +        .base_addr.addr =3D vms->memmap[VIRT_UART].base,
> +        .interrupt_type =3D (1 << 3),/* Bit[3] ARMH GIC interrupt*/
> +        .pc_interrupt =3D 0,         /* IRQ */
> +        .interrupt =3D (vms->irqmap[VIRT_UART] + ARM_SPI_BASE),
> +        .baud_rate =3D 3,            /* 9600 */
> +        .parity =3D 0,               /* No Parity */
> +        .stop_bits =3D 1,            /* 1 Stop bit */
> +        .flow_control =3D 1 << 1,    /* RTS/CTS hardware flow control */
> +        .terminal_type =3D 0,        /* VT100 */
> +        .language =3D 0,             /* Language */
> +        .pci_device_id =3D 0xffff,   /* not a PCI device*/
> +        .pci_vendor_id =3D 0xffff,   /* not a PCI device*/
> +        .pci_bus =3D 0,
> +        .pci_device =3D 0,
> +        .pci_function =3D 0,
> +        .pci_flags =3D 0,
> +        .pci_segment =3D 0,
> +    };
>
> -    acpi_table_end(linker, &table);
> +    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_tab=
le_id);
>  }
>
>  /*
> @@ -930,7 +916,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuild=
Tables *tables)
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
> @@ -497,4 +497,8 @@ void build_fadt(GArray *tbl, BIOSLinker *linker, cons=
t AcpiFadtData *f,
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

