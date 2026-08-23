Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51855C5DF81
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 21:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyGAB-00065J-Ox; Sun, 23 Aug 2026 17:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyGA9-00062o-UE
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 17:55:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyGA7-0000oF-BP
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 17:55:33 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67NLRaB1938914
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 21:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Wkw9HatbFsxkw0XYl4HUff3BaEy9yXEfq3H1nmw3SeQ=; b=BcBrvlB/4rGmUf0d
 02pkZkMq8JCmDBCHc6hGpHAcSppI3bNgLP9xh0n4qCASels3G8084PwnvR25AFPl
 6hwmbtOnEQ5nuNF89MC63WuUnxD8/2J3yCi4tMt6DfMvUk3k3va9AWVeBTzaGQHY
 CFFcAN+FQwY01YTwiUb8Ym0lFShKhnMEMvp3VzhZlPTXmSECIuu9rC7hWC8c9xut
 cyV3FsiLI7WtT9tQ6CBJ/wC13DvZNUPGZ9UnPaBzKUke5mjNGBBoi8cyBqe3zMWt
 hSLhpQwSdA3sRNkZMbtRu/3EHlT6esaJXvOeQn70LwckfVIUn2NdG3jg6bsUjl9j
 1rTYUw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g741qvk76-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 21:55:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c01ff996dso30752431cf.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 14:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787522127; x=1788126927; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wkw9HatbFsxkw0XYl4HUff3BaEy9yXEfq3H1nmw3SeQ=;
 b=BmE/EJs5NTsDe/KytCBZmzaP8DMCX7qeRKjkUo6P1Sa/8dSQBR6OjprHhKKgs8aMy3
 OJEi+5rsfvJQUstExTzptPXCm1lM0X2UgM/j2FJE4Rcmjko58GFBDLbJrAC/kaymMiho
 E5i1wZwfURJt7bYEnnFMpUfLhLs//aDo1bmYnDegRFBEBrbrg9nr3Gj0IEWVSn2AKLdt
 p96jhffVIguSUiDyE3JpzKNyCKPJdLcaOr5wYwKw+gKYqHRo1IeBop2ZqfNpjvA5hHrj
 fxnQw50bWlbLyE2AI/O7azBqLxDoYcU4kb69zWIjAcnG4T7BqPUBjI9+6aaitgJEPx/j
 uxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787522127; x=1788126927;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wkw9HatbFsxkw0XYl4HUff3BaEy9yXEfq3H1nmw3SeQ=;
 b=RDwoIo5U5fYp1XN5EKDIIptmiNh5lUqNmZ++q5UiezvUg4WvDJbDfjhBWfR4WO468W
 q4U8jF/ysUXSNuN5JsYLylEyK6YiHCp2F202wOBZ3nqM2yGdpjK+sklekUIUqgL8rxEA
 VmOzg2wosSOLhL7tI/w6+cMLCUKNz4zOlXem/SilDyhNjS+saDqu1CxwrXq1vAcBGxtJ
 29n4Ac57fNanuc8OEwZGDeY+mqDxG/qFB8qwX42Zyh8/PT3hlTlhAyEXpWRmqD/nWir9
 uKp2A92JRasCPeKt60hSk8eZETSjywycghiw0i4qcVPI4AEogp8ZB6ppLfbw3MfhVnWq
 3DFQ==
X-Gm-Message-State: AFuF++kVyPe4NnnirbxXna91oAc3UWeKttWi7JxeHMMVrphd8tECPlkr
 k90qRHHWuBM/SGBcpk99BjWMMLilHRW7vL/sjUY8PNwh5L2AC6+GlZKsS8SrbL4oEmJVwyv6tzO
 wCdxAjvt7FZlqU6HczqQ5Vi4Z7BJpW0cK2ChnKn7E+b4JlwvHNI0Mz0f+ew==
X-Gm-Gg: AR+sD12NwyI/w/76QkjXjdQiNl1g8buw0DOyy1smodswiHbN+Vvkef33aiZDUvQlQLm
 ucptw60mHq17SV7QBxhUb7eHjlyBmRnXxSP6cr/vQ0KK7c+QxD96rYmLnxAlSeiJL3VCBzv/+Ty
 DNNWzyQptTea5mTr8C7Klhrs9DDVFnN6XxuQkdElHIM54eNIgQuB5EvMdnwOMU3UcxL61XtF+95
 QRZrAf+VY5sKlJJnxYrbQvp9eXaHQTDhmiQHFaGt4TYx+YzWaGD7JyEnOMABryYM+xoaJWsG60I
 kc18f3YiY0XcfR1oluRyisvIL7Xj7ArC1ClRFmWwXvYiDDn8x3myL4R+VXk6J7DgIB82hQdUG3X
 J+RC7gtTxz4yKTJO0t7OAdbwJgwhh/O7Mk1kC
X-Received: by 2002:ac8:5c81:0:b0:519:8998:661b with SMTP id
 d75a77b69052e-52df5a08456mr230782221cf.20.1787522126672; 
 Sun, 23 Aug 2026 14:55:26 -0700 (PDT)
X-Received: by 2002:ac8:5c81:0:b0:519:8998:661b with SMTP id
 d75a77b69052e-52df5a08456mr230781981cf.20.1787522126141; 
 Sun, 23 Aug 2026 14:55:26 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e09975fbcsm35912341cf.4.2026.08.23.14.55.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Aug 2026 14:55:25 -0700 (PDT)
Message-ID: <75d038af-a1a0-460c-9fea-7cca0423a54c@oss.qualcomm.com>
Date: Sun, 23 Aug 2026 18:55:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] riscv/virt: Add optional UART1
To: Yanfeng Liu <yfliu2008@qq.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 pierrick.bouvier@oss.qualcomm.com, sunilvl@ventanamicro.com,
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
References: <tencent_4EEBFC805F3E59863BEDC38094EF5A109206@qq.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tencent_4EEBFC805F3E59863BEDC38094EF5A109206@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDIwMSBTYWx0ZWRfX/jpjQ0rHQRME
 xJJuUKErk8pN/hI0KNHZvG6TVsV2PT1p7rM5bMeCLzymuNRdzstM9aceb1SIlr3uUwmgWEko0H+
 D5v3Mjex8TvIpIGWUjVM/FA0VGxB1Eaz+J/FhCQr2H/keumBRTG+jfy4WOjT3dlMx5YgKw7ACQA
 /xeLYbCY9RYRi1RZHaeFSjdb3+okIllLw8RzAFUcUGySv7zlcmIV9YdkveIKZefLAuw3jpSctc5
 ti/HozIDY7+ophf7iyDYBdE3VWn2vrmuUK8genc9WHOMx/L6caJlFNLEECoj6yyNH9Dc8Tdzl1S
 VawzWS4zHrrRecT1r7IAhs4XmOgOwJYAiV6cf2VffFRpia7frxndnW2fvpfcJR8on8JMG7qoEwm
 20EvWQCFcWj2Pe9IRcLM0Mp+HLHu7vr/lbZP4BnsDdTy7x4+qLqLqqFeGemFr9TNLI1WCCQw7aV
 +K8fWx3RkY3YLtujbMg==
X-Authority-Analysis: v=2.4 cv=GvNyPE1C c=1 sm=1 tr=0 ts=6a8b6c4f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=dZbOZ2KzAAAA:8 a=umBbkq_vEPmigtP7UbEA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: xtkL5l-la2yVpd7patuRkLosiiGdvZN7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDIwMSBTYWx0ZWRfXz74Cs+NmXUlL
 YG1GF4wTrSZCdE6VztTzZ3wE5RgVDlgeA7PZJkpij3JtrI/iqnCdF9rOEvaDrqOP0Cw2/621dB2
 z9am9A/VTCN/TVz72T5dCDs78nXGsNc=
X-Proofpoint-GUID: xtkL5l-la2yVpd7patuRkLosiiGdvZN7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_07,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608230201
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/17/2026 11:16 PM, Yanfeng Liu wrote:
> This adds optional UART1 to RiscV virt board if required at
> runtime to simplify multicore development.

Can you please elaborate on the use case?  We can add multiple serial
devices already.  E.g. this will add 4 serials:


$ ./build/qemu-system-riscv64 -M virt --nodefaults \
          -serial stdio \
          -serial tcp::4444,server,nowait \
          -serial pty  \
          -serial file:uart4.log \
          --nographic


The difference here is that the additional serials won't have memory mappings
and fdt nodes.


Thanks,
Daniel

> 
> Note that UART0 remains default serial_hd(0) and it is:
> 
> - the lowest address UART
> - first serial in DTB
> - behind /aliases/serial0 in DTB
> - the /chosen/stdout-path in DTB
> 
> Note that UART1 is placed at different page from UART0 to
> support page level isolation.
> 
> Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> ---
>   docs/system/riscv/virt.rst |  5 ++++-
>   hw/riscv/virt-acpi-build.c | 12 ++++++++----
>   hw/riscv/virt.c            | 40 ++++++++++++++++++++++++++++----------
>   include/hw/riscv/virt.h    |  3 +++
>   4 files changed, 45 insertions(+), 15 deletions(-)
> 
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index 60850970ce..45ac63ac77 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -16,7 +16,7 @@ The ``virt`` machine supports the following devices:
>   * Core Local Interruptor (CLINT)
>   * Platform-Level Interrupt Controller (PLIC)
>   * CFI parallel NOR flash memory
> -* 1 NS16550 compatible UART
> +* Either 1 or 2 NS16550 compatible UARTs
>   * 1 Google Goldfish RTC
>   * 1 SiFive Test device
>   * 8 virtio-mmio transport devices
> @@ -27,6 +27,9 @@ The hypervisor extension has been enabled for the default CPU, so virtual
>   machines with hypervisor extension can simply be used without explicitly
>   declaring.
>   
> +The second UART only exists if a backend is configured explicitly (e.g.
> +with a second `-serial` command line option).
> +
>   Hardware configuration information
>   ----------------------------------
>   
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 413d47d70e..597751c84a 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -169,11 +169,11 @@ static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
>   
>   static void
>   acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
> -                    uint32_t uart_irq)
> +                    uint32_t uart_irq, int uartidx)
>   {
> -    Aml *dev = aml_device("COM0");
> +    Aml *dev = aml_device("COM%d", uartidx);
>       aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0003")));
> -    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(uartidx)));
>   
>       Aml *crs = aml_resource_template();
>       aml_append(crs, aml_memory32_fixed(uart_memmap->base,
> @@ -479,7 +479,11 @@ static void build_dsdt(GArray *table_data,
>                                    memmap[VIRT_APLIC_S].size, "RSCV0002");
>       }
>   
> -    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
> +    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ, 0);
> +    if (s->uart1_present) {
> +        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART1], UART1_IRQ, 1);
> +    }
> +
>       if (virt_is_iommu_sys_enabled(s)) {
>           acpi_dsdt_add_iommu_sys(scope, &memmap[VIRT_IOMMU_SYS], IOMMU_SYS_IRQ);
>       }
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 33775a61fd..4703ac58f8 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -96,6 +96,8 @@ static const MemMapEntry virt_memmap[] = {
>       [VIRT_APLIC_S] =      {  0xd000000, APLIC_SIZE(VIRT_CPUS_MAX) },
>       [VIRT_UART0] =        { 0x10000000,         0x100 },
>       [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
> +    /* UART1 supports page isolation from UART0 */
> +    [VIRT_UART1] =        { 0x1000a000,         0x100 },
>       [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
>       [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
>       [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
> @@ -186,7 +188,8 @@ static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *nodename,
>                             FDT_MAX_INT_MAP_WIDTH] = {};
>       uint32_t *irq_map = full_irq_map;
>   
> -    /* This code creates a standard swizzle of interrupts such that
> +    /*
> +     * This code creates a standard swizzle of interrupts such that
>        * each device's first interrupt is based on it's PCI_SLOT number.
>        * (See pci_swizzle_map_irq_fn())
>        *
> @@ -832,28 +835,38 @@ static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
>   }
>   
>   static void create_fdt_uart(RISCVVirtState *s,
> -                            uint32_t irq_mmio_phandle)
> +                            uint32_t irq_mmio_phandle, int memId, int irqNo)
>   {
>       g_autofree char *name = NULL;
>       MachineState *ms = MACHINE(s);
>   
>       name = g_strdup_printf("/soc/serial@%"HWADDR_PRIx,
> -                           s->memmap[VIRT_UART0].base);
> +                           s->memmap[memId].base);
>       qemu_fdt_add_subnode(ms->fdt, name);
>       qemu_fdt_setprop_string(ms->fdt, name, "compatible", "ns16550a");
>       qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
> -                                 2, s->memmap[VIRT_UART0].base,
> -                                 2, s->memmap[VIRT_UART0].size);
> +                                 2, s->memmap[memId].base,
> +                                 2, s->memmap[memId].size);
>       qemu_fdt_setprop_cell(ms->fdt, name, "clock-frequency", 3686400);
>       qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_phandle);
>       if (s->aia_type == VIRT_AIA_TYPE_NONE) {
> -        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", UART0_IRQ);
> +        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", irqNo);
>       } else {
> -        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", UART0_IRQ, 0x4);
> +        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", irqNo, 0x4);
> +    }
> +
> +    if (VIRT_UART0 == memId) {
> +        qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
> +        qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
>       }
> +}
>   
> -    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
> -    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
> +static void create_fdt_uarts(RISCVVirtState *s, uint32_t irq_mmio_phandle)
> +{
> +    if (s->uart1_present) {
> +        create_fdt_uart(s, irq_mmio_phandle, VIRT_UART1, UART1_IRQ);
> +    }
> +    create_fdt_uart(s, irq_mmio_phandle, VIRT_UART0, UART0_IRQ);
>   }
>   
>   static void create_fdt_rtc(RISCVVirtState *s,
> @@ -1023,7 +1036,7 @@ static void finalize_fdt(RISCVVirtState *s)
>   
>       create_fdt_reset(s, &phandle);
>   
> -    create_fdt_uart(s, irq_mmio_phandle);
> +    create_fdt_uarts(s, irq_mmio_phandle);
>   
>       create_fdt_rtc(s, irq_mmio_phandle);
>   }
> @@ -1567,6 +1580,13 @@ static void virt_machine_init(MachineState *machine)
>           0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
>           serial_hd(0), DEVICE_LITTLE_ENDIAN);
>   
> +    if (serial_hd(1)) {
> +        serial_mm_init(system_memory, s->memmap[VIRT_UART1].base,
> +            0, qdev_get_gpio_in(mmio_irqchip, UART1_IRQ), 399193,
> +            serial_hd(1), DEVICE_LITTLE_ENDIAN);
> +        s->uart1_present = true;
> +    }
> +
>       sysbus_create_simple("goldfish_rtc", s->memmap[VIRT_RTC].base,
>           qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
>   
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 18a2a323a3..7d57c8292e 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -59,6 +59,7 @@ struct RISCVVirtState {
>       int aia_guests;
>       char *oem_id;
>       char *oem_table_id;
> +    bool uart1_present;
>       OnOffAuto acpi;
>       const MemMapEntry *memmap;
>       struct GPEXHost *gpex_host;
> @@ -78,6 +79,7 @@ enum {
>       VIRT_APLIC_S,
>       VIRT_UART0,
>       VIRT_VIRTIO,
> +    VIRT_UART1,
>       VIRT_FW_CFG,
>       VIRT_IMSIC_M,
>       VIRT_IMSIC_S,
> @@ -93,6 +95,7 @@ enum {
>   enum {
>       UART0_IRQ = 10,
>       RTC_IRQ = 11,
> +    UART1_IRQ = 12,
>       VIRTIO_IRQ = 1, /* 1 to 8 */
>       VIRTIO_COUNT = 8,
>       PCIE_IRQ = 0x20, /* 32 to 35 */


