Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25031C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 13:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shU87-0002qN-LV; Fri, 23 Aug 2024 09:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1shU85-0002oK-S8
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 09:15:01 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1shU83-0000Fv-QD
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 09:15:01 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-428163f7635so14982625e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724418898; x=1725023698; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qYx02xrmRLGWpG1GZCOhwzNloqICSEynNtzbCrSKGgk=;
 b=EHz6aGaiAHmtKg/VRBKZQsKj41SnzmfjTXHMUkKzLqFCKt24ZhdispCu1KKXw1hcz0
 ppJvOAlj20cukkLlE5eHEDgUXYtRur3FCrfvmyc8UyP1DyDK8H08xSbrE0ULwHzRG+mO
 XzA46ZtXgFQrqOa4hEfoBbQkO/L+NkZfAZoo4d7JTRU7VXwxNdYVzGUE5s3M3SKdh2IB
 8vRF9FDIjBwkj+ymoGkrcyYL+39fNoRFLskZ875j5ExhTBQYhtfXcCwFzjUlqadI0s7t
 oApnHut3w1uOIcv5ZW1CYiKRDy1+yaEGivIosReICgHSJfjs+1Hpq2p31ASstjvZPE+8
 lgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724418898; x=1725023698;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYx02xrmRLGWpG1GZCOhwzNloqICSEynNtzbCrSKGgk=;
 b=mm8Hrkx7zwRbi4yW5kzG5qlRPX2vTTWv14oZgNWRkpDN6V9V5javOopvd0OktsQz5C
 C0SExHacmQM69akKw+cN/owEPDkp4CNNeVGBhyYfIARr+kn9Yg7uBUORrQHXzd28LGnX
 RylwiQV4+qBI+wFap/YxZgZzSpObZnJA0SCY3ar7+Y/kZGX6eKnTRzlU1KSFpIUQjBVc
 Fkz0bB01I85T4YRnUYyghiGkchsbYtY+/dKjpGeCE01bkHn7xzIh0Ds8Fu+H6nzWMJ0N
 BGCQGxNtKrvBXxAIbqgeEKMIx6cZlan6lvskOpHbkJgEF2akMYyrbTVsu1jLfgjCEIX5
 XSHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN42kDYJxPaBnd9TOFpU9wcIZfrxOOPgLy6sghDVbYuUTCQ9+JI/s+W7NsSDwfZMkiNi1lm6UBkcO4@nongnu.org
X-Gm-Message-State: AOJu0YwtJAgPy/akqmLDbNB6suaLE0m83OXFhqjD7uvcK2niupgdnIdM
 jPH9y/UXgKH3uqaY8GLpeep1EIJ3WrYJj3PkkFmPmI+vGZ20+Np/dLVBd3RTZjQ=
X-Google-Smtp-Source: AGHT+IHkaw6bFZiDiAEOIwb13QmJ36GlvyhQMc57PWhWE0GtdJzTIwbd89hOHKxcadeB43v9pjH8GA==
X-Received: by 2002:a05:600c:35c6:b0:426:6667:5c42 with SMTP id
 5b1f17b1804b1-42acc8d494fmr16871005e9.4.1724418897675; 
 Fri, 23 Aug 2024 06:14:57 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac5158f14sm60273915e9.16.2024.08.23.06.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:14:57 -0700 (PDT)
Date: Fri, 23 Aug 2024 18:44:45 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH RESEND v4 2/3] hw/acpi: Upgrade ACPI SPCR table to
 support SPCR table revision 4 format
Message-ID: <ZsiLRdozsvdCLgqg@sunil-laptop>
References: <20240823113142.161727-1-jeeheng.sia@starfivetech.com>
 <20240823113142.161727-3-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823113142.161727-3-jeeheng.sia@starfivetech.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-wm1-x330.google.com
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

On Fri, Aug 23, 2024 at 04:31:41AM -0700, Sia Jee Heng wrote:
> Update the SPCR table to accommodate the SPCR Table revision 4 [1].
> The SPCR table has been modified to adhere to the revision 4 format [2].
> 
> [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
> [2]: https://github.com/acpica/acpica/pull/931
> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/acpi/aml-build.c         | 20 ++++++++++++++++----
>  hw/arm/virt-acpi-build.c    | 10 +++++++---
>  hw/riscv/virt-acpi-build.c  | 12 +++++++++---
>  include/hw/acpi/acpi-defs.h |  7 +++++--
>  include/hw/acpi/aml-build.h |  2 +-
>  5 files changed, 38 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 6d4517cfbe..ad0a306db1 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1996,7 +1996,7 @@ static void build_processor_hierarchy_node(GArray *tbl, uint32_t flags,
>  
>  void build_spcr(GArray *table_data, BIOSLinker *linker,
>                  const AcpiSpcrData *f, const uint8_t rev,
> -                const char *oem_id, const char *oem_table_id)
> +                const char *oem_id, const char *oem_table_id, const char *name)
>  {
>      AcpiTable table = { .sig = "SPCR", .rev = rev, .oem_id = oem_id,
>                          .oem_table_id = oem_table_id };
> @@ -2042,9 +2042,21 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
>      build_append_int_noprefix(table_data, f->pci_flags, 4);
>      /* PCI Segment */
>      build_append_int_noprefix(table_data, f->pci_segment, 1);
> -    /* Reserved */
> -    build_append_int_noprefix(table_data, 0, 4);
> -
> +    if (rev < 4) {
> +        /* Reserved */
> +        build_append_int_noprefix(table_data, 0, 4);
> +    } else {
> +        /* UartClkFreq */
> +        build_append_int_noprefix(table_data, f->uart_clk_freq, 4);
> +        /* PreciseBaudrate */
> +        build_append_int_noprefix(table_data, f->precise_baudrate, 4);
> +        /* NameSpaceStringLength */
> +        build_append_int_noprefix(table_data, f->namespace_string_length, 2);
> +        /* NameSpaceStringOffset */
> +        build_append_int_noprefix(table_data, f->namespace_string_offset, 2);
> +        /* NamespaceString[] */
> +        g_array_append_vals(table_data, name, f->namespace_string_length);
> +    }
>      acpi_table_end(linker, &table);
>  }
>  /*
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f76fb117ad..cc27ba7daf 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -435,7 +435,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  
>  /*
>   * Serial Port Console Redirection Table (SPCR)
> - * Rev: 1.07
> + * Rev: 1.10
Why should this comment be updated? Since revision 2 of SPCR table ARM
uses corresponds to only 1.07 right?

>   */
>  static void
>  spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> @@ -464,8 +464,12 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          .pci_flags = 0,
>          .pci_segment = 0,
>      };
> -
> -    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_table_id);
> +    /*
> +     * Passing NULL as the SPCR Table for Revision 2 doesn't support
> +     * NameSpaceString.
> +     */
> +    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_table_id,
> +               NULL);
>  }
>  
>  /*
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 36d6a3a412..68ef15acac 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -200,14 +200,15 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
>  
>  /*
>   * Serial Port Console Redirection Table (SPCR)
> - * Rev: 1.07
> + * Rev: 1.10
>   */
>  
>  static void
>  spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
>  {
> +    const char name[] = ".";
>      AcpiSpcrData serial = {
> -        .interface_type = 0,       /* 16550 compatible */
> +        .interface_type = 0x12,       /* 16550 compatible */
>          .base_addr.id = AML_AS_SYSTEM_MEMORY,
>          .base_addr.width = 32,
>          .base_addr.offset = 0,
> @@ -229,9 +230,14 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
>          .pci_function = 0,
>          .pci_flags = 0,
>          .pci_segment = 0,
> +        .uart_clk_freq = 0,
> +        .precise_baudrate = 0,
> +        .namespace_string_length = sizeof(name),
> +        .namespace_string_offset = 88,
>      };
>  
> -    build_spcr(table_data, linker, &serial, 2, s->oem_id, s->oem_table_id);
> +    build_spcr(table_data, linker, &serial, 4, s->oem_id, s->oem_table_id,
> +               name);
>  }
>  
>  /* RHCT Node[N] starts at offset 56 */
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 0e6e82b339..2e6e341998 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -112,7 +112,6 @@ typedef struct AcpiSpcrData {
>      uint8_t flow_control;
>      uint8_t terminal_type;
>      uint8_t language;
> -    uint8_t reserved1;
>      uint16_t pci_device_id;    /* Must be 0xffff if not PCI device */
>      uint16_t pci_vendor_id;    /* Must be 0xffff if not PCI device */
>      uint8_t pci_bus;
> @@ -120,7 +119,11 @@ typedef struct AcpiSpcrData {
>      uint8_t pci_function;
>      uint32_t pci_flags;
>      uint8_t pci_segment;
> -    uint32_t reserved2;
> +    uint32_t uart_clk_freq;
> +    uint32_t precise_baudrate;
> +    uint32_t namespace_string_length;
> +    uint32_t namespace_string_offset;
> +    char namespace_string[];
>  } AcpiSpcrData;
>  
>  #define ACPI_FADT_ARM_PSCI_COMPLIANT  (1 << 0)
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index a3784155cb..68c0f2dbee 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -500,5 +500,5 @@ void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
>  
>  void build_spcr(GArray *table_data, BIOSLinker *linker,
>                  const AcpiSpcrData *f, const uint8_t rev,
> -                const char *oem_id, const char *oem_table_id);
> +                const char *oem_id, const char *oem_table_id, const char *name);
>  #endif

Otherwise, LGTM.

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

