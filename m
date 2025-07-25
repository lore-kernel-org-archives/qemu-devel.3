Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939FEC83F27
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 04:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf9eU-0006G7-MX; Fri, 25 Jul 2025 00:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uf9eR-0006DG-OS
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 00:03:19 -0400
Received: from sg-3-20.ptr.tlmpb.com ([101.45.255.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uf9eK-0007sC-NX
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 00:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1753416184;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=RCVU+FAj7IoD/Hiz2MZAUFoLRZYIStBURi/l9prZjmg=;
 b=JR4HaG4H6+Bcd1yOThTVaygDmFSJvToxvGUL34t82S3XDDLEgT984vv2jIrxrXNmD7ZbfI
 PVaj6VC9BJxBUry7HA9jui6rICWYwL4WLeDR2I2E1V9UBuMDbI5JOyGbiWnOLFdBJUK0KA
 Hsl9IkKcKxeYGoI734Kv2xB+txm04pEjXPxfGn1E9mkbu7eWADCxFNJozK//VMGsE/AVHH
 nB8UZ5aOu3G75z0ZEtmnR9bDVBqQLJw+J2u0aBc71CQIvAYGGs7gHOTxywFmc0GcNFMXgh
 vrBiaPGtL0SnFMOxPBn1laoXTNThOQhjfwbNI3GOnqTsGN/nudNxgP36x8csYg==
Message-Id: <c7e5b841-899d-4fc8-b16e-c91bbcb627fe@lanxincomputing.com>
X-Lms-Return-Path: <lba+2688301f6+bdf42f+nongnu.org+liujingqi@lanxincomputing.com>
User-Agent: Mozilla Thunderbird
References: <20250724110350.452828-1-sunilvl@ventanamicro.com>
 <20250724110350.452828-3-sunilvl@ventanamicro.com>
To: "Sunil V L" <sunilvl@ventanamicro.com>, <qemu-riscv@nongnu.org>, 
 <qemu-devel@nongnu.org>
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Mime-Version: 1.0
In-Reply-To: <20250724110350.452828-3-sunilvl@ventanamicro.com>
Content-Transfer-Encoding: 7bit
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, 
 "Alistair Francis" <alistair.francis@wdc.com>, 
 "Weiwei Li" <liwei1518@gmail.com>, 
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 "Igor Mammedov" <imammedo@redhat.com>, "Ani Sinha" <anisinha@redhat.com>, 
 "Andrew Jones" <ajones@ventanamicro.com>, 
 "Anup Patel" <anup@brainfault.org>, 
 "Atish Kumar Patra" <atishp@rivosinc.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS;
 Fri, 25 Jul 2025 12:03:01 +0800
Subject: Re: [PATCH v2 2/3] hw/riscv/virt-acpi-build.c: Update FADT and MADT
 versions
Date: Fri, 25 Jul 2025 12:03:00 +0800
Received-SPF: pass client-ip=101.45.255.20;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-3-20.ptr.tlmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
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

On 7/24/2025 7:03 PM, Sunil V L wrote:
> RISC-V support is added only in ACPI 6.6. According to the ACPI 6.6
> specification, the minor version of the Fixed ACPI Description Table
> (FADT) should be 6, and the Multiple APIC Description Table (MADT)
> should use revision 7. So, update the RISC-V FADT and MADT to reflect
> correct versions.
>
> Update the code comments to reflect ACPI 6.6 version details.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>

Thanks,
Nutty
>   hw/riscv/virt-acpi-build.c | 25 ++++++++++---------------
>   1 file changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index ee1416d264..f1406cb683 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -270,11 +270,8 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
>   #define RHCT_NODE_ARRAY_OFFSET 56
>   
>   /*
> - * ACPI spec, Revision 6.5+
> - * 5.2.36 RISC-V Hart Capabilities Table (RHCT)
> - * REF: https://github.com/riscv-non-isa/riscv-acpi/issues/16
> - *      https://drive.google.com/file/d/1nP3nFiH4jkPMp6COOxP6123DCZKR-tia/view
> - *      https://drive.google.com/file/d/1sKbOa8m1UZw1JkquZYe3F1zQBN1xXsaf/view
> + * ACPI spec, Revision 6.6
> + * 5.2.37 RISC-V Hart Capabilities Table (RHCT)
>    */
>   static void build_rhct(GArray *table_data,
>                          BIOSLinker *linker,
> @@ -421,7 +418,10 @@ static void build_rhct(GArray *table_data,
>       acpi_table_end(linker, &table);
>   }
>   
> -/* FADT */
> +/*
> + * ACPI spec, Revision 6.6
> + * 5.2.9 Fixed ACPI Description Table (MADT)
> + */
>   static void build_fadt_rev6(GArray *table_data,
>                               BIOSLinker *linker,
>                               RISCVVirtState *s,
> @@ -429,7 +429,7 @@ static void build_fadt_rev6(GArray *table_data,
>   {
>       AcpiFadtData fadt = {
>           .rev = 6,
> -        .minor_ver = 5,
> +        .minor_ver = 6,
>           .flags = 1 << ACPI_FADT_F_HW_REDUCED_ACPI,
>           .xdsdt_tbl_offset = &dsdt_tbl_offset,
>       };
> @@ -508,11 +508,8 @@ static void build_dsdt(GArray *table_data,
>   }
>   
>   /*
> - * ACPI spec, Revision 6.5+
> + * ACPI spec, Revision 6.6
>    * 5.2.12 Multiple APIC Description Table (MADT)
> - * REF: https://github.com/riscv-non-isa/riscv-acpi/issues/15
> - *      https://drive.google.com/file/d/1R6k4MshhN3WTT-hwqAquu5nX6xSEqK2l/view
> - *      https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view
>    */
>   static void build_madt(GArray *table_data,
>                          BIOSLinker *linker,
> @@ -537,7 +534,7 @@ static void build_madt(GArray *table_data,
>   
>       hart_index_bits = imsic_num_bits(imsic_max_hart_per_socket);
>   
> -    AcpiTable table = { .sig = "APIC", .rev = 6, .oem_id = s->oem_id,
> +    AcpiTable table = { .sig = "APIC", .rev = 7, .oem_id = s->oem_id,
>                           .oem_table_id = s->oem_table_id };
>   
>       acpi_table_begin(&table, table_data);
> @@ -812,10 +809,8 @@ static void build_rimt(GArray *table_data, BIOSLinker *linker,
>   }
>   
>   /*
> - * ACPI spec, Revision 6.5+
> + * ACPI spec, Revision 6.6
>    * 5.2.16 System Resource Affinity Table (SRAT)
> - * REF: https://github.com/riscv-non-isa/riscv-acpi/issues/25
> - *      https://drive.google.com/file/d/1YTdDx2IPm5IeZjAW932EYU-tUtgS08tX/view
>    */
>   static void
>   build_srat(GArray *table_data, BIOSLinker *linker, RISCVVirtState *vms)

