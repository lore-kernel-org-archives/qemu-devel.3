Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587A1CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utIGv-0006Vm-KQ; Tue, 02 Sep 2025 00:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIGh-0006Mc-Ar
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:05:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIGX-00077x-UB
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:05:15 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SDrx030680
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 04:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5U3X03XI+3CaYdsrFa9ikiy9R/yafn6T/ILPFySxnro=; b=PapM9U8o+W1YwdH1
 1UWeVSB7Yybrqgcq7uYQ5rwPGu96cSeLAnNTax+lg5lYvP9C7ejO+1stO1wt3vGq
 RCu9Vo6qloNJeloyRtikttpNYw6Vpjr4hwnv2XZ0o9Y72UvH0oAnrZQ/XvXRUfWY
 aY76S26CNA0Iirrw3JBpvWHwAD+byGLB0qLEE68IAzwwGFQ6CqT+DZxKD+sUgvBi
 zlZWWrrMQGVO2g7jgHCBoKOiDpLbRcMvlMajvb6Y55k3hSco8O31N9EygPCGgk9z
 Q5T4bGbmzZZKVSkV/kpUZGdCG2VDkRuJwd5BM6O7I/kYkIvlFba9jgvRum2l4tsW
 FEpsUg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8pd8p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:05:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-24b18ad403eso1122065ad.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 21:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785901; x=1757390701;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5U3X03XI+3CaYdsrFa9ikiy9R/yafn6T/ILPFySxnro=;
 b=e/yGUscj2QtztMCqTUYZXEhNEfFsouPWqyRoTcG74K7vPE66H2ib7htr+md6f+JQ/I
 RfUnKgTVN6eotY4EffTJAdKU0wiONAxA9xNGu3M1W2lUSo1YumOpEaZdFSueGHzoAU3a
 hCd6KiVJjiJLdUwmSZn6znp37GwUTI6Y+++VFd3T676m71SQU6vpMyUdiHpjRRM/5xWY
 fTHpz3nIPEU2v8iDU3rXf7ysJsIx5BgIhsygnvMvT6BrHKDKKKrWBt0eZQfwjxGhAdKS
 k7o+Xp2HRWSCMWg8IgpzfIcfRGZFU5kbfTCNi5U5bxvVsmfSQ/EOZqKSsvR3gPAUshDO
 k6Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS/nwDNU7OtRPYN9NVpCVWQ80xQPK9EN5ijpCVRgh8KckH9W5lLtJQnOskdXvckg5zEjylrE1j/jlJ@nongnu.org
X-Gm-Message-State: AOJu0Yz1L0woENfBPQrHxia3JlnRLC32zkTtDAZHvINak6hRRSLlkAub
 whqRnjDiCb2k0jBmQVBse4iPUWWtPY00aQOdlNwC/0GGueD7ycvmUxKq4LT26jpN6gRp697+H9p
 8PrdSm8Th/PYVjkxDxV1KJWyNUoua2hR0hb0MKUtfQmiBHvqPr0WpLJG6PMX0zTzyhbMu
X-Gm-Gg: ASbGncsjqJh6HohkF4hoqXZ+U9BabfoSDonMFGqAuTsWYaUA17RO/9MfZCzsIqeybHR
 8ichTBabxXVQTlfnn9CcvE4UBKdPIUhw2yD3iBC9WcdJaOdxUrG4yGmE0HVchQUQQkTOL6FCnhc
 h8xuNKjQYfmxoMxlG8joKvspJRZ2NodNyai0xhG5GphGfCpYkDkmHhL/1k95u7N8Cjn1EsZ9DKf
 81tGHYmSUsJ0svpialr25zr9VN4Drgymc+ZN73+DTva5xqCbmzyEkl9IuyDYVJNXXZV1ghTFZGW
 7VhO6RvrMtMpUuPUWGprDCe0fBF9ubOlZ4mDLq8j+ER2Db2oVeW86W7Lt5cGfw==
X-Received: by 2002:a17:902:ef43:b0:24a:9342:ecc3 with SMTP id
 d9443c01a7336-24a9342eedbmr113860385ad.14.1756785901010; 
 Mon, 01 Sep 2025 21:05:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/DIFaDFx/KjJg1u51SYMgE/9wzhViE8ou1/Y+PhWz0jfVAXMH/l7vhy0+FOc262SzqIezfQ==
X-Received: by 2002:a17:902:ef43:b0:24a:9342:ecc3 with SMTP id
 d9443c01a7336-24a9342eedbmr113860095ad.14.1756785900503; 
 Mon, 01 Sep 2025 21:05:00 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249037254a0sm115887685ad.33.2025.09.01.21.04.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 21:05:00 -0700 (PDT)
Message-ID: <fbf20ae7-b528-4915-9ed1-42f90822cb8e@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 20:20:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/38] target/hexagon: Add initial MMU model
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>, 'Michael Lambert' <mlambert@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-35-brian.cain@oss.qualcomm.com>
 <011101db9370$ddebf410$99c3dc30$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <011101db9370$ddebf410$99c3dc30$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CX8fHX_bFpSkq4fi4ZeqF6b_Ah7u3D_l
X-Proofpoint-GUID: CX8fHX_bFpSkq4fi4ZeqF6b_Ah7u3D_l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX62276Fq9DADh
 v/pDaKqzK1YO0nL98YHHyaQltUNfv4B8JMi3pV9TMmNAXiJz9NafQVPmdiVBdweqCxe10LpZOGf
 jrQcXAA3tgUwkhp1yGRvVbO9BKVZI3cIw47VPq9/5bIf3hqlIseCrxzdpkqNvg4xuiRbLV9/maE
 MsmZwr3A/K0pWVn14g7Zgc4ekMypLGvah0ho2muRVfhDqLdWOwVy4DgN8tuwb3NXD+8h9j6XOpa
 BegNe3Pqdf9rHVCl75NACzwjYmJa9e54F+3cJdBYLdbyDz+fvEwFKeUrGJHpaDs81wV7e+YvobI
 hqZYK5CozTEn+GzzGzK38rV87zdTn+D19Xk1xlTymtNkmVzAItRPr/cHlPTBDqfrBhSF/+faumf
 3B5TmPdp
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b66cee cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=Q0g7hkgB0gUcp5_g9AYA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On 3/12/2025 12:04 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:26 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>; Michael Lambert
>> <mlambert@quicinc.com>
>> Subject: [PATCH 34/38] target/hexagon: Add initial MMU model
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>> Co-authored-by: Michael Lambert <mlambert@quicinc.com>
>> Co-authored-by: Sid Manning <sidneym@quicinc.com>
>> Co-authored-by: Matheus Tavares Bernardino
>> <quic_mathbern@quicinc.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>
>> diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c new
>> file mode 100644 index 0000000000..54c4ba2dbf
>> --- /dev/null
>> +++ b/target/hexagon/hex_mmu.c
>> @@ -0,0 +1,528 @@
>> +/*
>> + * Copyright(c) 2019-2025 Qualcomm Innovation Center, Inc. All Rights
>> Reserved.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later  */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/main-loop.h"
>> +#include "qemu/qemu-print.h"
>> +#include "cpu.h"
>> +#include "system/cpus.h"
>> +#include "internal.h"
>> +#include "exec/exec-all.h"
>> +#include "hex_mmu.h"
>> +#include "macros.h"
>> +#include "sys_macros.h"
>> +#include "reg_fields.h"
>> +
>> +#define GET_TLB_FIELD(ENTRY, FIELD)                               \
>> +    ((uint64_t)fEXTRACTU_BITS(ENTRY, reg_field_info[FIELD].width, \
>> +                              reg_field_info[FIELD].offset))
>> +
>> +/* PPD (physical page descriptor) */
>> +static inline uint64_t GET_PPD(uint64_t entry) {
>> +    return GET_TLB_FIELD(entry, PTE_PPD) |
>> +        (GET_TLB_FIELD(entry, PTE_PA35) <<
>> +reg_field_info[PTE_PPD].width); }
>> +
>> +#define NO_ASID      (1 << 8)
>> +
>> +typedef enum {
>> +    PGSIZE_4K,
>> +    PGSIZE_16K,
>> +    PGSIZE_64K,
>> +    PGSIZE_256K,
>> +    PGSIZE_1M,
>> +    PGSIZE_4M,
>> +    PGSIZE_16M,
>> +    PGSIZE_64M,
>> +    PGSIZE_256M,
>> +    PGSIZE_1G,
>> +    NUM_PGSIZE_TYPES
>> +} tlb_pgsize_t;
>> +
>> +static const char *pgsize_str[NUM_PGSIZE_TYPES] = {
>> +    "4K",
>> +    "16K",
>> +    "64K",
>> +    "256K",
>> +    "1M",
>> +    "4M",
>> +    "16M",
>> +    "64M",
>> +    "256M",
>> +    "1G",
>> +};
>> +
>> +#define INVALID_MASK 0xffffffffLL
>> +
>> +static const uint64_t encmask_2_mask[] = {
>> +    0x0fffLL,                           /* 4k,   0000 */
>> +    0x3fffLL,                           /* 16k,  0001 */
>> +    0xffffLL,                           /* 64k,  0010 */
>> +    0x3ffffLL,                          /* 256k, 0011 */
>> +    0xfffffLL,                          /* 1m,   0100 */
>> +    0x3fffffLL,                         /* 4m,   0101 */
>> +    0xffffffLL,                         /* 16m,  0110 */
>> +    0x3ffffffLL,                        /* 64m,  0111 */
>> +    0xfffffffLL,                        /* 256m, 1000 */
>> +    0x3fffffffLL,                       /* 1g,   1001 */
>> +    INVALID_MASK,                      /* RSVD, 0111 */
>> +};
>> +
>> +/*
>> + * @return the page size type from @a entry.
>> + */
>> +static inline tlb_pgsize_t hex_tlb_pgsize_type(uint64_t entry) {
>> +    if (entry == 0) {
>> +        qemu_log_mask(CPU_LOG_MMU, "%s: Supplied TLB entry was 0!\n",
>> __func__);
>> +        return 0;
>> +    }
>> +    tlb_pgsize_t size = ctz64(entry);
>> +    g_assert(size < NUM_PGSIZE_TYPES);
>> +    return size;
>> +}
>> +
>> +/*
>> + * @return the page size of @a entry, in bytes.
>> + */
>> +static inline uint64_t hex_tlb_page_size_bytes(uint64_t entry) {
>> +    return 1ull << (TARGET_PAGE_BITS + 2 * hex_tlb_pgsize_type(entry));
>> +}
>> +
>> +static inline uint64_t hex_tlb_phys_page_num(uint64_t entry) {
>> +    uint32_t ppd = GET_PPD(entry);
>> +    return ppd >> 1;
>> +}
>> +
>> +static inline uint64_t hex_tlb_phys_addr(uint64_t entry) {
>> +    uint64_t pagemask = encmask_2_mask[hex_tlb_pgsize_type(entry)];
>> +    uint64_t pagenum = hex_tlb_phys_page_num(entry);
>> +    uint64_t PA = (pagenum << TARGET_PAGE_BITS) & (~pagemask);
>> +    return PA;
>> +}
>> +
>> +static inline uint64_t hex_tlb_virt_addr(uint64_t entry) {
>> +    return (uint64_t)GET_TLB_FIELD(entry, PTE_VPN) <<
>> TARGET_PAGE_BITS;
>> +}
>> +
>> +static bool hex_dump_mmu_entry(FILE *f, uint64_t entry) {
>> +    if (GET_TLB_FIELD(entry, PTE_V)) {
>> +        fprintf(f, "0x%016" PRIx64 ": ", entry);
>> +        uint64_t PA = hex_tlb_phys_addr(entry);
>> +        uint64_t VA = hex_tlb_virt_addr(entry);
>> +        fprintf(f, "V:%" PRId64 " G:%" PRId64 " A1:%" PRId64 " A0:%" PRId64,
>> +                GET_TLB_FIELD(entry, PTE_V), GET_TLB_FIELD(entry, PTE_G),
>> +                GET_TLB_FIELD(entry, PTE_ATR1), GET_TLB_FIELD(entry,
>> PTE_ATR0));
>> +        fprintf(f, " ASID:0x%02" PRIx64 " VA:0x%08" PRIx64,
>> +                GET_TLB_FIELD(entry, PTE_ASID), VA);
>> +        fprintf(f,
>> +                " X:%" PRId64 " W:%" PRId64 " R:%" PRId64 " U:%" PRId64
>> +                " C:%" PRId64,
>> +                GET_TLB_FIELD(entry, PTE_X), GET_TLB_FIELD(entry, PTE_W),
>> +                GET_TLB_FIELD(entry, PTE_R), GET_TLB_FIELD(entry, PTE_U),
>> +                GET_TLB_FIELD(entry, PTE_C));
>> +        fprintf(f, " PA:0x%09" PRIx64 " SZ:%s (0x%" PRIx64 ")", PA,
>> +                pgsize_str[hex_tlb_pgsize_type(entry)],
>> +                hex_tlb_page_size_bytes(entry));
>> +        fprintf(f, "\n");
>> +        return true;
>> +    }
>> +
>> +    /* Not valid */
>> +    return false;
>> +}
>> +
>> +void dump_mmu(CPUHexagonState *env)
>> +{
>> +    int i;
>> +
>> +    HexagonCPU *cpu = env_archcpu(env);
>> +    for (i = 0; i < cpu->num_tlbs; i++) {
>> +        uint64_t entry = env->hex_tlb->entries[i];
>> +        if (GET_TLB_FIELD(entry, PTE_V)) {
>> +            qemu_printf("0x%016" PRIx64 ": ", entry);
>> +            uint64_t PA = hex_tlb_phys_addr(entry);
>> +            uint64_t VA = hex_tlb_virt_addr(entry);
>> +            qemu_printf(
>> +                "V:%" PRId64 " G:%" PRId64 " A1:%" PRId64 " A0:%" PRId64,
>> +                GET_TLB_FIELD(entry, PTE_V), GET_TLB_FIELD(entry, PTE_G),
>> +                GET_TLB_FIELD(entry, PTE_ATR1), GET_TLB_FIELD(entry,
>> PTE_ATR0));
>> +            qemu_printf(" ASID:0x%02" PRIx64 " VA:0x%08" PRIx64,
>> +                        GET_TLB_FIELD(entry, PTE_ASID), VA);
>> +            qemu_printf(
>> +                " X:%" PRId64 " W:%" PRId64 " R:%" PRId64 " U:%" PRId64
>> +                " C:%" PRId64,
>> +                GET_TLB_FIELD(entry, PTE_X), GET_TLB_FIELD(entry, PTE_W),
>> +                GET_TLB_FIELD(entry, PTE_R), GET_TLB_FIELD(entry, PTE_U),
>> +                GET_TLB_FIELD(entry, PTE_C));
>> +            qemu_printf(" PA:0x%09" PRIx64 " SZ:%s (0x%" PRIx64 ")", PA,
>> +                        pgsize_str[hex_tlb_pgsize_type(entry)],
>> +                        hex_tlb_page_size_bytes(entry));
>> +            qemu_printf("\n");
> Use hex_dump_mmu_entry instead.


Will fix this in v3.

>
>> +        }
>> +    }
>> +}
>> +
>> +static inline void hex_log_tlbw(uint32_t index, uint64_t entry) {
>> +    if (qemu_loglevel_mask(CPU_LOG_MMU)) {
>> +        if (qemu_log_enabled()) {
>> +            FILE *logfile = qemu_log_trylock();
>> +            if (logfile) {
>> +                fprintf(logfile, "tlbw[%03d]: ", index);
>> +                if (!hex_dump_mmu_entry(logfile, entry)) {
>> +                    fprintf(logfile, "invalid\n");
>> +                }
>> +                qemu_log_unlock(logfile);
>> +            }
>> +        }
>> +    }
>> +}
>> +
>> +void hex_tlbw(CPUHexagonState *env, uint32_t index, uint64_t value) {
>> +    uint32_t myidx = fTLB_NONPOW2WRAP(fTLB_IDXMASK(index));
>> +    bool old_entry_valid = GET_TLB_FIELD(env->hex_tlb->entries[myidx],
>> PTE_V);
>> +    if (old_entry_valid && hexagon_cpu_mmu_enabled(env)) {
>> +        CPUState *cs = env_cpu(env);
>> +
>> +        tlb_flush(cs);
>> +    }
>> +    env->hex_tlb->entries[myidx] = (value);
>> +    hex_log_tlbw(myidx, value);
>> +}
>> +
>> +void hex_mmu_realize(CPUHexagonState *env) {
>> +    CPUState *cs = env_cpu(env);
>> +    if (cs->cpu_index == 0) {
>> +        env->hex_tlb = g_malloc0(sizeof(CPUHexagonTLBContext));
>> +    } else {
>> +        CPUState *cpu0_s = NULL;
>> +        CPUHexagonState *env0 = NULL;
>> +        CPU_FOREACH(cpu0_s) {
>> +            assert(cpu0_s->cpu_index == 0);
>> +            env0 = &(HEXAGON_CPU(cpu0_s)->env);
>> +            break;
>> +        }
> Seems fragile to assume cpu_index == 0 will be first in CPU_FOREACH.  This would be better
>      CPU_FOREACH(cpu0_s) {
>          if (cpu0_s->cpu_index == 0) {
>              env0 = &(HEXAGON_CPU(cpu0_s)->env);
>              break;
>          }
>      }
>      g_assert(env0);  /* Make sure we found it */

In fact, this suffers from the same design error we made w/the global 
registers.

We will move the global TLB state to an Object like we did w/the global 
register state, and it will eliminate this FOREACH entirely and any 
fragile binding with cpu_index == 0.


>
>> +        env->hex_tlb = env0->hex_tlb;
>> +    }
>> +}
>
>> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
>> index 3ec53010fa..aa729a3683 100644
>> --- a/target/hexagon/meson.build
>> +++ b/target/hexagon/meson.build
>> @@ -273,7 +273,8 @@ hexagon_ss.add(files(
>>   #     idef-generated-enabled-instructions
>>   #
>>   idef_parser_enabled = get_option('hexagon_idef_parser') -if
>> idef_parser_enabled and 'hexagon-linux-user' in target_dirs
>> +if idef_parser_enabled and ('hexagon-linux-user' in target_dirs or
>> +                            'hexagon-softmmu' in target_dirs)
>>       idef_parser_input_generated = custom_target(
>>           'idef_parser_input.h.inc',
>>           output: 'idef_parser_input.h.inc',
> Move this to later patch "add build config for softmmu"
>
Done in v2.
>

