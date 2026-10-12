Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EBBCA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 09:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGCVD-00042l-IF; Mon, 12 Oct 2026 05:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xGCVB-00042Q-Dd
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 05:39:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xGCV9-00073E-72
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 05:39:24 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C8KfVU741647
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 09:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TX5GKIOh4OFebQubg6UFnRZxE4XAme6FeLaQHqPJiVA=; b=axtZDi7/ZFnI+ZKY
 MVB3/w8zl6/kYExCn/5FTpu1YoaNYIfQRmmWSm9zFVF9RYX8im52xnJEh9e5m+Wc
 LNNPL6UbaDD3sKFW0qCjKpLJnnLw7JUbYvb4HFkIfZO6hkIFKN6i8EtMXvk2mFVq
 KPkooaEF41WtLuRp2N01rxdZQDugvpiU6yt+mljpymiZhq9uJA4IBHaWFdcGOoJS
 LIPS0seafR97B/vQkJxuswvvRX8mBhDXPTbkWoCIgZfV06RTiL9Ak2JXIp0jp84v
 P6q1c8ozA36pTrWYeYl2lTuZHDw6ib01CcComhWiMdSK6X8YbahZOjvIaicwE1D9
 vs+MgA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j6dj4fy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 09:39:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caa0ce0cdso173540485a.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 02:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791797960; x=1792402760; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TX5GKIOh4OFebQubg6UFnRZxE4XAme6FeLaQHqPJiVA=;
 b=gluZl1M4OI9xSbFxejsi5YeDXXjf9oz7v7992YwrfGSSYjbYkO56m0hMuQqB/Y2W7Z
 d58bEwZQBua+vBPAKf0LWsLwpkKpkQcxNSlAfpOr+olrB2/5sLrLUFS7oBTqiDemiknw
 XfrHaeu7Z+N4qFV75g/KPYE1aJyKUnWVeQoQxVdbV2eZ6EyQEiVXjYBKCBx6k35Cdv6u
 rHV8M9CbmptFzqTUm+O50+dwwa1pMugurYXa2Pab7Ia098iEIigmtBM66t+iACgfY5HR
 oSbA9JlQ/UaPS7dD1QWnHBkTFRON/4v67Jh5kMmh8Po0+foi0mTJUJlwnKyvM8cIgqsj
 PVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791797960; x=1792402760;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TX5GKIOh4OFebQubg6UFnRZxE4XAme6FeLaQHqPJiVA=;
 b=clGSAjP3Na5tZg076kdOtvFN99+inydNpH3MC6HYLx39fD9U0dhGw9ny82GGkCQPuv
 bE2xnDkBlu6BionuYA9RSCBINkNscdGFp3r1USmlRPtoHc7TQ1274t5va7WI9Ap5RQcs
 MsUISz6F/gVQZdYy1lAemG+QFx22Cbw3oghw3DbSbTjWVIjOkMK3xEFQSOfa/Vc0Hftl
 VkmwIfOEDPTg7eTn1dUcwbmfIwxrSfagZKHjqPBjf/8OBra4Folq2LzCTar03iGcDDl/
 P8z/W5pkCCKez3kW1lzjpGl1H7i19yk1fMwwoeKjGjvf9r8c5gV9BncoH/v6RBcmIM4i
 LiMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRHHIVaLdzaj8CDBDtRhfzrzbCUh602JHtLXCa503lKKb3hg5KBaYf9Yl99Y8HEofRwyBSnfCpBX/T@nongnu.org
X-Gm-Message-State: AFq9FYIQOJf4Nezx6db/kX6TyCyvV34XVj8O1t9IhTY2p3DaASMN897W
 AT+Let68tO3SErQqQSdIk0h5WjPcdvgiUHt+Pg36cPbVVzjwRGHp0mXBS9qq2KMnxFvkWBVaZNf
 VqYHvwz+p0Li8JXob00a+HFLJt/XJWFLvHOR33mSAOM8dmeiz5gIFrv60Xw==
X-Gm-Gg: AYBFou1Ovje/YQdM7CLgUy7JoBSgYlW5LPAO1TMBCO7OB5Xa4Xg+T+W51FuLT+olXJp
 xvRuow6VxRg+hvPy8CGJ5NN3Ji0aWGfCL711kwaKBHFEFR3lRrpd2y75F2bUGUxXA7Rn3Xqqhn7
 uCY2QyWd6QgQVunvaxruIwozWpI5wFoAMibtoZOpqPqHkUtp4H+aSNbzpMnRMjGuc8TM6+VqeVK
 FzwLCQwQ+X+pVZCkQeNIWQuvePeRai0J179PviZ0oW3z01PbufccySE08/bEv459CFHOwmXtTBF
 GfgwOukORE99PaFxF/ZyukDWDfkYJ2GyZ3UlIleFoDT2wmrYLXiwWPuIlKNJ4XFQMGO+SkfaRCV
 AZekWccV/z6wnWGbGk92TIoty8SkOZipaF70=
X-Received: by 2002:a05:620a:4693:b0:93a:9ef5:d370 with SMTP id
 af79cd13be357-93ebd0be3d8mr1534817985a.1.1791797960456; 
 Mon, 12 Oct 2026 02:39:20 -0700 (PDT)
X-Received: by 2002:a05:620a:4693:b0:93a:9ef5:d370 with SMTP id
 af79cd13be357-93ebd0be3d8mr1534815885a.1.1791797959966; 
 Mon, 12 Oct 2026 02:39:19 -0700 (PDT)
Received: from [192.168.68.107] ([152.234.126.58])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb9848702sm819358085a.12.2026.10.12.02.39.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 02:39:18 -0700 (PDT)
Message-ID: <3847ee55-78c8-496d-942e-104def334b72@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 06:39:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/riscv/virt: Add ACPI PPTT table
To: Sunil V L <sunilvl@oss.qualcomm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, "Michael S . Tsirkin"
 <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>,
 Drew Fustini <fustini@kernel.org>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
References: <20261011182552.1071742-1-sunilvl@oss.qualcomm.com>
 <20261011182552.1071742-3-sunilvl@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261011182552.1071742-3-sunilvl@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzOCBTYWx0ZWRfXzwBQBFlHT846
 7ud1xA9thliHRbpUVnRfymfpLkQPNaFkLDys3eqXqjqXh/DW0zp2fXQmNLTDeeEdV3AfnJ52N2Y
 IDXVPCVv5isyv1v0rdBGxxZYdgvRy385KwmvypykDZ3irvc7Y5AmSz2g4mPbNs6JJIRWejuWs67
 JpID9zz9EgxSD8sdOQNgu6C0C8SxWPOXcyewjLdEuiNmhTmSkHVWq9AjBfH/4pYe+CNF0CuYjia
 lpurdOXdUVS79jjrEb9l6xDw2UjUsHYFG7+2SWmwnMtGBJXKquktnwTAK9G29wtBkyTmnXDWeVG
 u/44Z6N6c/6+Jiirp3rkTnuN4wt0URDtgTyF+5QK4gu4ywEHZ7H5Di9hq1S7F7VrMyKTJWdIoXL
 yQ4IL1K6ae5YOzWW2Hwq3JHiyNYhJvLrH3OJCkC0du8uB5VxjOTaLOeTc/32cQ69hJdqKcVk41n
 ieKObDmvmO8M4/cKF9w==
X-Authority-Analysis: v=2.4 cv=aK5lOr9m c=1 sm=1 tr=0 ts=6accaac9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=XIBTAJF/fpiF5bhQ2IRv1g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Bq6zwJu1AAAA:8 a=e7M5XfOby5X2jGa20tgA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=KQ6X2bKhxX7Fj2iT9C4S:22
X-Proofpoint-GUID: b7fa8ffZyBfOnRBVyIa-1tXjww36mV92
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzOCBTYWx0ZWRfXz7lOe5ewfKr7
 KnbOh3niFVOvHjCU1BnCKx5rji1y6ToNzPIQ827FKbksq2mya2wy2eM6Bik+ZDjwptscL+Xr1IA
 eKSBxgKV5njNfomD13l+vxiJRzG95eQ=
X-Proofpoint-ORIG-GUID: b7fa8ffZyBfOnRBVyIa-1tXjww36mV92
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120038
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

Hi Sunil!

On 10/11/2026 3:25 PM, Sunil V L wrote:
> From: Sunil V L <sunilvl@oss.qualcomm.com>
> 
> Generate the Processor Properties Topology Table (PPTT) for the RISC-V
> virt machine.
> 
> Describe the machine using separate L1 data and instruction caches plus
> unified L2 and L3 caches, and enable the corresponding cache and cluster
> SMP properties.
> 
> Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> ---
>   hw/riscv/virt-acpi-build.c |  7 +++++
>   hw/riscv/virt.c            | 54 ++++++++++++++++++++++++++++++++++++++
>   include/hw/riscv/virt.h    |  4 +++
>   3 files changed, 65 insertions(+)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 0475dcb5c601..3c72a03dadb6 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -882,7 +882,10 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
>       unsigned dsdt, xsdt;
>       GArray *tables_blob = tables->table_data;
>       MachineState *ms = MACHINE(s);
> +    CPUCoreCaches caches[CPU_MAX_CACHES];
> +    unsigned int num_caches;
>   
> +    num_caches = virt_get_caches(caches);

So if we have virt_get_caches() as:

unsigned int virt_get_caches(CPUCoreCaches *caches)
{
     for (int i = 0; i < ARRAY_SIZE(virt_caches); i++) {
         caches[i] = virt_caches[i];
     }

     return ARRAY_SIZE(virt_caches);
}


And then we do:


     CPUCoreCaches caches[CPU_MAX_CACHES];
     unsigned int num_caches;

     num_caches = virt_get_caches(caches);


Isn't that the same as:


     CPUCoreCaches caches[CPU_MAX_CACHES];
     unsigned int num_caches = ARRAY_SIZE(virt_caches);

     memcpy(caches, virt_caches, num_caches * sizeof(CPUCoreCaches));


and then we can get rid of virt_get_caches()?  Am I missing something?


Cheers,
Daniel


>       table_offsets = g_array_new(false, true,
>                                   sizeof(uint32_t));
>   
> @@ -915,6 +918,10 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
>           spcr_setup(tables_blob, tables->linker, s);
>       }
>   
> +    acpi_add_table(table_offsets, tables_blob);
> +    build_pptt(tables_blob, tables->linker, ms, s->oem_id,
> +               s->oem_table_id, num_caches, caches);
> +
>       acpi_add_table(table_offsets, tables_blob);
>       {
>           AcpiMcfgInfo mcfg = {
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d4b501802f60..245651fbbd13 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -109,6 +109,45 @@ static const MemMapEntry virt_memmap[] = {
>       [VIRT_DRAM] =         { 0x80000000,           0x0 },
>   };
>   
> +CPUCoreCaches virt_caches[] = {
> +    {
> +        .type = DATA_CACHE,
> +        .sets = 256,
> +        .size = 64 * KiB,
> +        .level = 1,
> +        .linesize = 64,
> +        .attributes = 0x0,
> +        .associativity = 4,
> +    },
> +    {
> +        .type = INSTRUCTION_CACHE,
> +        .sets = 256,
> +        .size = 64 * KiB,
> +        .level = 1,
> +        .linesize = 64,
> +        .attributes = 0x0,
> +        .associativity = 4,
> +    },
> +    {
> +        .type = UNIFIED_CACHE,
> +        .sets = 4096,
> +        .size = 2048 * KiB,
> +        .level = 2,
> +        .linesize = 64,
> +        .attributes = 0x0,
> +        .associativity = 8,
> +    },
> +    {
> +        .type = UNIFIED_CACHE,
> +        .sets = 8192,
> +        .size = 4096 * KiB,
> +        .level = 3,
> +        .linesize = 64,
> +        .attributes = 0x0,
> +        .associativity = 8,
> +    },
> +};
> +
>   /* PCIe high mmio is fixed for RV32 */
>   #define VIRT32_HIGH_PCIE_MMIO_BASE  0x300000000ULL
>   #define VIRT32_HIGH_PCIE_MMIO_SIZE  (4 * GiB)
> @@ -140,6 +179,15 @@ static void virt_flash_map(RISCVVirtState *s,
>                            sysmem, VIRT_FLASH_SECTOR_SIZE);
>   }
>   
> +unsigned int virt_get_caches(CPUCoreCaches *caches)
> +{
> +    for (int i = 0; i < ARRAY_SIZE(virt_caches); i++) {
> +        caches[i] = virt_caches[i];
> +    }
> +
> +    return ARRAY_SIZE(virt_caches);
> +}
> +
>   static void create_fdt_socket_plic(RISCVVirtState *s,
>                                      int socket,
>                                      uint32_t *phandle, uint32_t *intc_phandles,
> @@ -1144,6 +1192,12 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>       mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
>       mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
>       mc->numa_mem_supported = true;
> +    mc->smp_props.clusters_supported = true;
> +    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L1D] = true;
> +    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L1I] = true;
> +    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L2] = true;
> +    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L3] = true;
> +
>       /* platform instead of architectural choice */
>       mc->cpu_cluster_has_numa_boundary = true;
>       mc->default_ram_id = "riscv_virt_board.ram";
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index e516898f9ad9..1e498a4f5f6e 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -121,10 +121,14 @@ enum {
>   #define VIRT_PLIC_SIZE(__num_context) \
>       (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
>   
> +#define CPU_MAX_CACHES 16
> +
>   bool virt_is_acpi_enabled(RISCVVirtState *s);
>   bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
>   void virt_acpi_setup(RISCVVirtState *vms);
>   
> +unsigned int virt_get_caches(CPUCoreCaches *caches);
> +
>   /*
>    * The virt machine physical address space used by some of the devices
>    * namely ACLINT, PLIC, APLIC, and IMSIC depend on number of Sockets,


