Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C5DC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 04:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6N8f-0003lq-36; Mon, 13 May 2024 00:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6MtX-0001z3-Vr; Mon, 13 May 2024 00:02:36 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6MtP-0001li-Ms; Mon, 13 May 2024 00:02:32 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-47ef107b07fso2003895137.0; 
 Sun, 12 May 2024 21:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715572940; x=1716177740; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yW0MzsOp6vUNM6xkpXB8bEogZkLwNe3KfgNbfn+kDW8=;
 b=coMWbw1mMNB/6Pmu2b+3GScs1RiTdHZU5rTNkM8pEePTNS46ESfY5zORd8hBo0ujgX
 IRKvF7aKzgV8q7eDypusYk4JFR9RQyiuKCJXyxrzY4SiExSHhc3W82b1GLc2f0kx8dFT
 WMJSCmWElPCn8zZTnccTSbMEOiPuoIWQ2W08QvZzBOBD8L+GaFiwSkLrj3tmVjEEjQXq
 Pf3tJ81eQSohQuhpFrqos+tktH3W0/V681GsXZ982PfSwndLKuKEdZel0mK1xwLjNwrp
 SJMQQcJkm9/8RaErVhbpmnCmr1wE3LOkMct3mCnQGMBbF2Vcs94bZVJ1DPCG26ehy3Iz
 fBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715572940; x=1716177740;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yW0MzsOp6vUNM6xkpXB8bEogZkLwNe3KfgNbfn+kDW8=;
 b=Rm0B5JYG/834TuYnbrtk6ZvrHoATWLquvLEAkLdp1Ygo0mNWPiY7gk58SuZ2qSdoJA
 MzehG3AguPlTEtr80ob0crkD5OJD3TthUmqd17GOBd7Mm+itgsbc/JZ2uEoPfgDScwU6
 i3byp5ZModEIh/8dSwWfsbFL62M9FEgrI6uOjGxCTCS3rz3YhD9SCjfkg1ZFmsZqywzd
 Sie2bX6OMzbg48yp8GGwYBS2ygKJvdXGTVxzN4E6baJwzd1JSQ0B3rFxNqMyBk7pdCIv
 5kQMSGBrIsb6vAA1LWer5NvqYhJHBL35jwft7Pgz6AQq28yr3PY4hpyziOhgjWP4Nw3i
 UTnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGiYaBkPZg0fW4fo3FKzqbFjhKUyXdhGDXupIx0vQ6YvjejYVIfiNc13NnFkPCf+fILi4uf7q6We4rZBHW5fKGd7FCuiFbjPuDMKCn4+VmGtRGPPh3m80fRGZHfg==
X-Gm-Message-State: AOJu0Ywwgw/wtMGRcE++7jdCT3oIMycEkUPVvRB3XgW0ZR2yq3zeRfLM
 6z72gCg9+PH3HWfw8Jos0AlyDOa2VFGhGFYgqJI3DT46Df7Tzil4P9XhsOYo4//f2Y9tjsmBqrO
 xmGlGwAJTd1f0+suhiGPAehR0FFw7gw==
X-Google-Smtp-Source: AGHT+IGUHhaKMsWU1UCUK5vNB12IhH7tlikLzQ7QdnGjf3K1DZAjL8z861sbS0JsPsoK+oN67SRXbcmlkvL/aW6mE4I=
X-Received: by 2002:a05:6102:c50:b0:47c:296c:5fe3 with SMTP id
 ada2fe7eead31-48077b9908cmr6421489137.9.1715572940372; Sun, 12 May 2024
 21:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240507052212.291137-1-jeeheng.sia@starfivetech.com>
 <20240507052212.291137-3-jeeheng.sia@starfivetech.com>
In-Reply-To: <20240507052212.291137-3-jeeheng.sia@starfivetech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 May 2024 14:01:54 +1000
Message-ID: <CAKmqyKNuoLbhsohLQoFrwKquVbHoW7TEkMzLCQyVSweDkBP6Yw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hw/acpi: Upgrade ACPI SPCR table to support SPCR
 table version 4 format
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe31.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 7, 2024 at 3:24=E2=80=AFPM Sia Jee Heng
<jeeheng.sia@starfivetech.com> wrote:
>
> Update the SPCR table to accommodate the SPCR Table version 4 [1].
> The SPCR table has been modified to adhere to the version 4 format [2].
>
> [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/=
serial-port-console-redirection-table
> [2]: https://github.com/acpica/acpica/pull/931
>
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/acpi/aml-build.c         | 14 +++++++++++---
>  hw/arm/virt-acpi-build.c    | 10 ++++++++--
>  hw/riscv/virt-acpi-build.c  | 12 +++++++++---
>  include/hw/acpi/acpi-defs.h |  7 +++++--
>  include/hw/acpi/aml-build.h |  2 +-
>  5 files changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 6d4517cfbe..7c43573eef 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1996,7 +1996,7 @@ static void build_processor_hierarchy_node(GArray *=
tbl, uint32_t flags,
>
>  void build_spcr(GArray *table_data, BIOSLinker *linker,
>                  const AcpiSpcrData *f, const uint8_t rev,
> -                const char *oem_id, const char *oem_table_id)
> +                const char *oem_id, const char *oem_table_id, const char=
 *name)
>  {
>      AcpiTable table =3D { .sig =3D "SPCR", .rev =3D rev, .oem_id =3D oem=
_id,
>                          .oem_table_id =3D oem_table_id };
> @@ -2042,8 +2042,16 @@ void build_spcr(GArray *table_data, BIOSLinker *li=
nker,
>      build_append_int_noprefix(table_data, f->pci_flags, 4);
>      /* PCI Segment */
>      build_append_int_noprefix(table_data, f->pci_segment, 1);
> -    /* Reserved */
> -    build_append_int_noprefix(table_data, 0, 4);
> +    /* UartClkFreq */
> +    build_append_int_noprefix(table_data, f->uart_clk_freq, 4);
> +    /* PreciseBaudrate */
> +    build_append_int_noprefix(table_data, f->precise_baudrate, 4);
> +    /* NameSpaceStringLength */
> +    build_append_int_noprefix(table_data, f->namespace_string_length, 2)=
;
> +    /* NameSpaceStringOffset */
> +    build_append_int_noprefix(table_data, f->namespace_string_offset, 2)=
;
> +    /* NamespaceString[] */
> +    g_array_append_vals(table_data, name, f->namespace_string_length);
>
>      acpi_table_end(linker, &table);
>  }
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 6a1bde61ce..cb345e8659 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -428,11 +428,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, =
VirtMachineState *vms)
>
>  /*
>   * Serial Port Console Redirection Table (SPCR)
> - * Rev: 1.07
> + * Rev: 1.10
>   */
>  static void
>  spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms=
)
>  {
> +    const char name[] =3D ".";
>      AcpiSpcrData serial =3D {
>          .interface_type =3D 3,       /* ARM PL011 UART */
>          .base_addr.id =3D AML_AS_SYSTEM_MEMORY,
> @@ -456,9 +457,14 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, V=
irtMachineState *vms)
>          .pci_function =3D 0,
>          .pci_flags =3D 0,
>          .pci_segment =3D 0,
> +        .uart_clk_freq =3D 0,
> +        .precise_baudrate =3D 0,
> +        .namespace_string_length =3D sizeof(name),
> +        .namespace_string_offset =3D 88,
>      };
>
> -    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_tab=
le_id);
> +    build_spcr(table_data, linker, &serial, 4, vms->oem_id, vms->oem_tab=
le_id,
> +               name);
>  }
>
>  /*
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 0925528160..5fa3942491 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -176,14 +176,15 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *u=
art_memmap,
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
> +    const char name[] =3D ".";
>      AcpiSpcrData serial =3D {
> -        .interface_type =3D 0,       /* 16550 compatible */
> +        .interface_type =3D 0x12,       /* 16550 compatible */
>          .base_addr.id =3D AML_AS_SYSTEM_MEMORY,
>          .base_addr.width =3D 32,
>          .base_addr.offset =3D 0,
> @@ -205,9 +206,14 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, R=
ISCVVirtState *s)
>          .pci_function =3D 0,
>          .pci_flags =3D 0,
>          .pci_segment =3D 0,
> +        .uart_clk_freq =3D 0,
> +        .precise_baudrate =3D 0,
> +        .namespace_string_length =3D sizeof(name),
> +        .namespace_string_offset =3D 88,
>      };
>
> -    build_spcr(table_data, linker, &serial, 2, s->oem_id, s->oem_table_i=
d);
> +    build_spcr(table_data, linker, &serial, 4, s->oem_id, s->oem_table_i=
d,
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
> @@ -500,5 +500,5 @@ void build_tpm2(GArray *table_data, BIOSLinker *linke=
r, GArray *tcpalog,
>
>  void build_spcr(GArray *table_data, BIOSLinker *linker,
>                  const AcpiSpcrData *f, const uint8_t rev,
> -                const char *oem_id, const char *oem_table_id);
> +                const char *oem_id, const char *oem_table_id, const char=
 *name);
>  #endif
> --
> 2.34.1
>
>

