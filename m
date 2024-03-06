Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CC0C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 18:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhwSp-0001YC-G8; Wed, 06 Mar 2024 13:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhwSo-0001Xr-8B
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 13:58:02 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhwSh-0005Ec-Tg
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 13:58:01 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-29a61872f4eso5182475a91.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 10:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709751474; x=1710356274; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2YG5uMHYgXaT8wpQi0YUe9AEiblBe2sbxqY7RGp8EFU=;
 b=C+M6EZrxUmFLb58hxiGCMgcpTkdkrZh0atiy23to8LfMp0/YBMt4TTAf8RHr3nOK/8
 4p9WfmVrPsJKC/KSQlWu/w4x3mlR/Dh7HmHXnqmHsb/M2EhUUU/LG6VyaCI6O4iKjDc9
 3QLEonv8IHfeljz+OikUPwZbrNbw499KDLhlymjlbRnEwvL015wZNNaRMVsG/Rs2q+7i
 BDCIlCUe0P+ChYQULlvMV7xtS+q5/NkN2kcrqFzjvaRQnL8rhOZE8DqpjY3UEZbicEF2
 833l4tjNP/5oKW2KSF495pDKzM7ealyisuwfVQ+jAqh0hzwcGIuefFS3l+Hqi8EYt3LR
 wGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709751474; x=1710356274;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2YG5uMHYgXaT8wpQi0YUe9AEiblBe2sbxqY7RGp8EFU=;
 b=jzt3S9YUCPSDJ2JQ2S1KoBn3VzNLMmVOIPQOAcEREMOWgknbanVflmUAWk7ZYcsKrZ
 eA3iHN69vfrev4SWWi8dqlRYKPIz1cr4bRvr/L+C9oJ+HxUoOU5NRk+2hemsQrdAD2z9
 rKz7wZTo5xJzJmEcLZI6vVX2C0HDaWH7ih07Tpv44EZ5s1AGIBxG5M4WSFI+GIf9gxLm
 5MeFMkA6D5fJ1jP/CPJMGFGqdPHHBkex4fHfNavvhfGKMnsXS4ohejaoMTgt7ETM2NMv
 iizyQqPpVjNBX8nXaxwrZYB5sz70BUQrAE9D0Ndmij0MOu9AdS0qYbd95xNPXWlYoGiE
 l9+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgVxb4+3pmI5k/2qhldn8v3aiqxnOidXgvEXtjR55L1bLZpD0XBhoIJvSIw1/XxW+j4gwAHAW2/4TNLKVq+Os8ur8qo88=
X-Gm-Message-State: AOJu0YyQ8Z44md4LntuwONgH/0hXAB+SDHNiqOBAPiNj0cwfg1nV0qYe
 xXqw/B4HKDVDQsa9ai/xnF9pOeqtRP05Vnf2Mz3+ACz9SuFtdCwfjsWs7OTHTJs=
X-Google-Smtp-Source: AGHT+IEK/7k8iM1HsyWVuin4L0rpOStjuyhS+pM/kY/cCM7bVNzW+JB8nWkmyBqp5x2I6Q+CoG74hA==
X-Received: by 2002:a17:90b:3585:b0:29b:f79:2b75 with SMTP id
 mm5-20020a17090b358500b0029b0f792b75mr13942442pjb.7.1709751473698; 
 Wed, 06 Mar 2024 10:57:53 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 ee13-20020a17090afc4d00b0029a8d207010sm56658pjb.54.2024.03.06.10.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 10:57:52 -0800 (PST)
Message-ID: <49d0d8d3-c7fd-4039-aeed-6c31ba16557a@ventanamicro.com>
Date: Wed, 6 Mar 2024 15:57:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/arm/virt-acpi-build.c: Migrate SPCR creation to
 common location
Content-Language: en-US
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 sunilvl@ventanamicro.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
References: <20240116010930.43433-1-jeeheng.sia@starfivetech.com>
 <20240116010930.43433-2-jeeheng.sia@starfivetech.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240116010930.43433-2-jeeheng.sia@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1033.google.com
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

Hi,

This patch break check-qtest, most specifically 'bios-table'test', for aarch64.
I found this while running riscv-to-apply.next in the Gitlab pipeline.


Here's the output:

$ make -j && QTEST_QEMU_BINARY=./qemu-system-aarch64 V=1 ./tests/qtest/bios-tables-test
TAP version 13
# random seed: R02Sf0f2fa0a3fac5d540b1681c820621b7d
# starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-591353.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-591353.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -machine none -accel qtest
1..8
# Start of aarch64 tests
# Start of acpi tests
# starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-591353.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-591353.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -machine virt  -accel tcg -nodefaults -nographic -drive if=pflash,format=raw,file=pc-bios/edk2-aarch64-code.fd,readonly=on -drive if=pflash,format=raw,file=pc-bios/edk2-arm-vars.fd,snapshot=on -cdrom tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2 -cpu cortex-a57 -smbios type=4,max-speed=2900,current-speed=2700 -accel qtest
acpi-test: Warning! SPCR binary file mismatch. Actual [aml:/tmp/aml-9G53J2], Expected [aml:tests/data/acpi/virt/SPCR].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! SPCR mismatch. Actual [asl:/tmp/asl-SR53J2.dsl, aml:/tmp/aml-9G53J2], Expected [asl:/tmp/asl-4Z33J2.dsl, aml:tests/data/acpi/virt/SPCR].

The diff is here:

--- /tmp/asl-4Z33J2.dsl	2024-03-06 15:40:24.879879348 -0300
+++ /tmp/asl-SR53J2.dsl	2024-03-06 15:40:24.877879347 -0300
@@ -1,57 +1,49 @@
  /*
   * Intel ACPI Component Architecture
   * AML/ASL+ Disassembler version 20220331 (64-bit version)
   * Copyright (c) 2000 - 2022 Intel Corporation

(...)

  [000h 0000   4]                    Signature : "SPCR"    [Serial Port Console Redirection Table]
-[004h 0004   4]                 Table Length : 00000050
+[004h 0004   4]                 Table Length : 0000004F
  [008h 0008   1]                     Revision : 02
-[009h 0009   1]                     Checksum : B1
+[009h 0009   1]                     Checksum : B2
  [00Ah 0010   6]                       Oem ID : "BOCHS "

(...)

-[042h 0066   2]                PCI Vendor ID : FFFF
+[042h 0066   2]                PCI Vendor ID : 00FF


After inspecting the common helper and what the original ARM code was doing
I found out that we're missing something down there:


On 1/15/24 22:09, Sia Jee Heng wrote:
> RISC-V should also generate the SPCR in a manner similar to ARM.
> Therefore, instead of replicating the code, relocate this function
> to the common AML build.
> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> ---
>   hw/acpi/aml-build.c         | 51 ++++++++++++++++++++++++++++
>   hw/arm/virt-acpi-build.c    | 68 +++++++++++++++----------------------
>   include/hw/acpi/acpi-defs.h | 33 ++++++++++++++++++
>   include/hw/acpi/aml-build.h |  4 +++
>   4 files changed, 115 insertions(+), 41 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index af66bde0f5..f3904650e4 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1994,6 +1994,57 @@ static void build_processor_hierarchy_node(GArray *tbl, uint32_t flags,
>       }
>   }
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

Here. We're missing the "Language" entry.


This diff fixes the broken test:


$ git diff
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index f3904650e4..6d4517cfbe 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2024,6 +2024,8 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
      build_append_int_noprefix(table_data, f->stop_bits, 1);
      /* Flow Control */
      build_append_int_noprefix(table_data, f->flow_control, 1);
+    /* Language */
+    build_append_int_noprefix(table_data, f->language, 1);
      /* Terminal Type */
      build_append_int_noprefix(table_data, f->terminal_type, 1);
      /* PCI Device ID  */



As a side note, it seems like 'bios-table-test' isn't being run for RISC-V. Not sure if this
is intentional or a foresight.


Thanks,

Daniel


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
>   /*
>    * ACPI spec, Revision 6.3
>    * 5.2.29 Processor Properties Topology Table (PPTT)
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index a22a2f43a5..195767c0f0 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -431,48 +431,34 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>    * Rev: 1.07
>    */
>   static void
> -build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> +spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>   {
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
>   }
>   
>   /*
> @@ -930,7 +916,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>       }
>   
>       acpi_add_table(table_offsets, tables_blob);
> -    build_spcr(tables_blob, tables->linker, vms);
> +    spcr_setup(tables_blob, tables->linker, vms);
>   
>       acpi_add_table(table_offsets, tables_blob);
>       build_dbg2(tables_blob, tables->linker, vms);
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 2b42e4192b..0e6e82b339 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -90,6 +90,39 @@ typedef struct AcpiFadtData {
>       unsigned *xdsdt_tbl_offset;
>   } AcpiFadtData;
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
>   #define ACPI_FADT_ARM_PSCI_COMPLIANT  (1 << 0)
>   #define ACPI_FADT_ARM_PSCI_USE_HVC    (1 << 1)
>   
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index ff2a310270..a3784155cb 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -497,4 +497,8 @@ void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
>   
>   void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
>                   const char *oem_id, const char *oem_table_id);
> +
> +void build_spcr(GArray *table_data, BIOSLinker *linker,
> +                const AcpiSpcrData *f, const uint8_t rev,
> +                const char *oem_id, const char *oem_table_id);
>   #endif

