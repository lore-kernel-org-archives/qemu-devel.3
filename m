Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAF9CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHOlB-0006GQ-ER; Thu, 15 Oct 2026 12:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHOkv-0006Eo-Lj
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 12:56:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHOkr-0003Pl-Fq
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 12:56:37 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFgSxj2809317
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 16:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gG7ACg1z6L1SEO51yYG9+sA6LIAZRJwe+ytR6c12GDI=; b=mktC8Sv8zSSnGrAw
 pMkdy/Lc2wsUrGV5d1H8NBq26WzfEsWszqXl6lgExdfVkNeGaNELH5Z7nGYHfgv+
 jJNfMDTvIrFjhDpUXIY67bDn/nSW7qQImvr+1HO33ekbMZBJSLTM2QWxNhAnTJer
 MPZ9bySC3LTfljUt3tD9hvP9vSRtIOQAdmbGT+MrQhjNNsTpllQiipqZh6HB9rG7
 960WEhmWHIU4XkJED+qmCbRPsaUSElxO0XdTfQd7ot2dgnJeK81Se22Dt189SuRK
 yjV10O+qBZDw8bgFcy6bE1zF7eN02fdjrly8YMh6dtn5qRHzg+5xAli7/0T45/n3
 NmCPTw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4han54unxu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 16:56:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f13c143c8so121303385a.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792083389; x=1792688189; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gG7ACg1z6L1SEO51yYG9+sA6LIAZRJwe+ytR6c12GDI=;
 b=TLrLvcC6ORQONaPMdKfwzMNMT6j+KSa2KgkMeVbpNhMYJl0P6jWZxXAwBIzGfwaIFy
 JiPZwMs7tZA5KU5/PFOIo/a3uL9sVxNwZ+4fPG1LiyVToIR2barQ/kXqC16A1NCigFLP
 I+4AmUdVJaY44+FSM7TPgAvyK9uzrY5lXmCZzanJE/JrKvfJOBMtUAkj9kaDFDI0Zy2e
 MqaZGF7iIt+Qx/vRDoXsZ5cJbvjXPbGb0tYM8CwQatBnXHnGP6I1iv38l+xz7N4fm/Rf
 B5j5r8cpfQYCK9Arfy7gCvr4xYWoSJzKAHbpBlebmrKEMhPOWlA2xXSZ/D0wErWssqaY
 yO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792083389; x=1792688189;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gG7ACg1z6L1SEO51yYG9+sA6LIAZRJwe+ytR6c12GDI=;
 b=glffhJXJs/K5h7Hh/iCshnA7LVdQBCjqjDBlfcN7yhJ/tnAtTa5paz2cq/je1w4JUT
 BWDhqnM7ZwC2s38GDTJ0yLf78eq/YQPZ46BCfgVZGv9chtrIXt8e5ckRpLoo1UdVFZfi
 ekiZJG63824jQopWZr5IcgnA1T70nj8CCDFqZH5xuv0L/lHd2c8kXyeNg4UqkwY4ie6/
 xD6dGz1gmkcv9HWTq3ExNi+MGOUlhIcJtrNb2WRgbw1mbqVPbuptdWYz0+yk+cw5l47r
 Vuk54z/uvu6dMwLcuJ3VwR5tKiVv3spK6HLWANGSHLp3+CvmSASVVJgU8iHicQhHls0r
 lI4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxw58Qf3ve04YUfJM6ozJyhOPIzku1ddQaNQBKqRDk2o1j2XDkf00SfuX0I/E94iZlQlgkJq7aACLN@nongnu.org
X-Gm-Message-State: AFq9FYLAIjYY1E2YydTBOfs1t8SB2aBGXBObYnEiOe0OCqsIwC9gVgkY
 /gdNBiMQ7aMTUSADjt90X/WITN65XkCxxJMFu5kstUzU2f6TbVozZ2lKKk9ldIAL99vyZoi2Ocz
 kSvuxy/F7X0Qvlu7Y4opgdqH6KHQvIcX5uYGy9YnDhwpqhL1+JX9F5KevQQ==
X-Gm-Gg: AYBFou0SF8PBXOiNb2qz17c57P/OpBf/rrC4zyUcUf17+7ecRQC2RcmAilw8apTBj7E
 6ZGDClbeVAdxQ84N8GhtyNjitq4siYrXdJTy9PGmd/TyCSZ4yp8Rbo5Qqf3pF8EFyvG/M9gT2nY
 eIByQ2kcu+1/Gf6cmtddbj4BVtHS/dChrd55Yr8qDuSfi1hjXlFoxO4zIm9phjuceyfxNuDrWDv
 p7oKZyj3jww8p3J0lqXu+vjWOQXwm8NiI2KQ/SBeEN4oVL8nl+iJi1oDiGOEGFVFZ/PPMd8kJsz
 sQAWntLV7uHvaiRi9ZjIZavg+c/6FPWQgpLmroFCNqJ9ak1VyR8O2QP4+sacJMBkf1Zv7kiTEiP
 oofSX4cfTyUQ7gxeGUBUPv5alyYBxahgEeRo=
X-Received: by 2002:a05:620a:2949:b0:93e:c12c:4409 with SMTP id
 af79cd13be357-93ec12c4a64mr3026961785a.69.1792083388963; 
 Thu, 15 Oct 2026 09:56:28 -0700 (PDT)
X-Received: by 2002:a05:620a:2949:b0:93e:c12c:4409 with SMTP id
 af79cd13be357-93ec12c4a64mr3026955285a.69.1792083388274; 
 Thu, 15 Oct 2026 09:56:28 -0700 (PDT)
Received: from [192.168.68.103] ([152.234.126.58])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ef50947e6sm811063485a.42.2026.10.15.09.56.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 09:56:27 -0700 (PDT)
Message-ID: <ea698fba-d160-4d12-8e44-dfd41037b064@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 13:56:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hw/riscv/virt: Add ACPI PPTT table
To: Sunil V L <sunilvl@oss.qualcomm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, "Michael S . Tsirkin"
 <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>,
 Drew Fustini <fustini@kernel.org>, Prajwal N <prajwal.n@oss.qualcomm.com>,
 Shankar C <shankar.c@oss.qualcomm.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
References: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
 <20261015064957.4076464-3-sunilvl@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261015064957.4076464-3-sunilvl@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RYQFmFtv c=1 sm=1 tr=0 ts=6ad105bd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=XIBTAJF/fpiF5bhQ2IRv1g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Bq6zwJu1AAAA:8 a=e7M5XfOby5X2jGa20tgA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=KQ6X2bKhxX7Fj2iT9C4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA2NyBTYWx0ZWRfX9R8sZCcw4IqQ
 ewQdniK+/XncabRPdKsJbezHNkTaCtbX+NlheaqK581UseWui7nhp+ybUEPDi92py7/iiVDq0eA
 2OdS/7O1GMWTZGgfqVRBm1W0bvFEmuJRJI19youk/18Jr/FUdhDFeISpqvxoPe7MTGiHSTgvyug
 8RY2QOycxQoOIp3SSk7bUNa3lsImp2BS0FxIAhy+B3qyNXTi5pqz48ZakxJMxljI8GYNzqAzHhc
 wKT9bMfglXeEQqvt+Uiv9hI6t39CF2XDa2DpKdjeBRfXl48VfNkIjnwHJz6nLnUt98cIiZy0uBE
 h3kRtHfDIZzwYsciS5NIwbqUc4Uv2tsxpP2hEcIrAs07XeRL2BbWbMQMAL4kFv/fPWhgxQYD9GU
 kw5HGU8O5mTDZNqMb+dicV1Uht0ih0uFOUiX3+D2XOsyiIyLeFnJx7fRRKb/rg+LEDiU7gr3xFq
 f9kTRUOFcS32EJRM5gA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA2NyBTYWx0ZWRfX4hVFqOxVHwQF
 Fmry/rfJwgTijLhkaH9Jiuhxl7XOhLUO/Ox01R/Pr38epHqj0DZ0stUxGDQXoEZYz3lZ/lvTiXL
 W/2ozhcCkmQy0O0XItf0XgHT8PIjOYU=
X-Proofpoint-GUID: m9H7M1bqeFPmPmn1YRJqRurA4YGIEQRB
X-Proofpoint-ORIG-GUID: m9H7M1bqeFPmPmn1YRJqRurA4YGIEQRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150067
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



On 10/15/2026 3:49 AM, Sunil V L wrote:
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

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/virt-acpi-build.c |  7 ++++++
>   hw/riscv/virt.c            | 51 ++++++++++++++++++++++++++++++++++++++
>   include/hw/riscv/virt.h    |  4 +++
>   3 files changed, 62 insertions(+)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 0475dcb5c601..8254f1294a72 100644
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
>       table_offsets = g_array_new(false, true,
>                                   sizeof(uint32_t));
>   
> @@ -909,6 +912,10 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
>           build_rimt(tables_blob, tables->linker, s);
>       }
>   
> +    acpi_add_table(table_offsets, tables_blob);
> +    build_pptt(tables_blob, tables->linker, ms, s->oem_id,
> +               s->oem_table_id, num_caches, caches);
> +
>       acpi_add_table(table_offsets, tables_blob);
>   
>       if (ms->acpi_spcr_enabled) {
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d4b501802f60..c84b17a40125 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -109,6 +109,45 @@ static const MemMapEntry virt_memmap[] = {
>       [VIRT_DRAM] =         { 0x80000000,           0x0 },
>   };
>   
> +static CPUCoreCaches virt_caches[] = {
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
> @@ -140,6 +179,12 @@ static void virt_flash_map(RISCVVirtState *s,
>                            sysmem, VIRT_FLASH_SECTOR_SIZE);
>   }
>   
> +unsigned int virt_get_caches(CPUCoreCaches *caches)
> +{
> +    memcpy(caches, virt_caches, sizeof(virt_caches));
> +    return ARRAY_SIZE(virt_caches);
> +}
> +
>   static void create_fdt_socket_plic(RISCVVirtState *s,
>                                      int socket,
>                                      uint32_t *phandle, uint32_t *intc_phandles,
> @@ -1144,6 +1189,12 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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


