Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CE9109C057
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 19:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5U3z-0000vd-N4; Wed, 25 Mar 2026 15:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5U3y-0000k7-3u
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 15:38:46 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5U3v-0003hg-9p
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 15:38:45 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so160434f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774467521; x=1775072321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RNc+JQ81313HgWSGBIJLwRbgOzzuGzXkYDimoCN7D9c=;
 b=wte9SG37Tl7b6yGXIctdJ/4/C/CQsmnePg+rVsXJFGdY79w47zxwHo8vG/uEQM2TZx
 MK01fLeiZManvGtid8S+xbop/jo3WkfOflx/azHYHirNkeFlcof2E5DtN9dXxTEgtC8Y
 +Uk1PeSgBAkBDFvZgAniLr6jntMn5q0shM29OzPHvn3LsghYQbTPuZGuo01OIrmy/3UY
 Ei14ROgySV/soy0xmKabTBST4AJmUCdOAKlbePZZpkSgvAof+n5g/bkLrl5RfCXgjP/A
 /SsxwmPN0HETEo1nITF44xg+qFN2mR3rU9SXRTHW8xkvVIdmUZPYyIsl43nXogZ+F9V3
 jlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774467521; x=1775072321;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RNc+JQ81313HgWSGBIJLwRbgOzzuGzXkYDimoCN7D9c=;
 b=JO3SQUrWwUHi6uA3R+YzVVs0ldsY21PqP6PQUyBJers/9ZvSDBQQYdVhrEi2JWF5gA
 wwsDqhL0Oke9PPmp09r6M3JjJQxR5OZlIcHtgccAZs8p/HiGQJmP3HJ9YpiBfLBqCMfv
 /Fp0Uqd7sw2d5V31Nuc9PKWG3i98BGM2fAkpwajtJxZIhPxwXOOTVnMRxiDa9b1YiyM0
 t/xIpfUgBMCBgu/TAjBpC0FGKFsPlYnwZ83bfQE17nFcB4Q7nkQxrDnD6EH3BvVoHy4t
 ynxjDr5WijF5lEcEk91gSPDI1//xNxifhjvskyjXSsY26UdOa7A/GbQN9l+I37bdENEY
 cpsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrWJ+XzNDdLSrYsRGD/jt2Y/qqDSt/JwrDWIZLQQFOmw2ibgMPj7L+ZzMuSDktLafHoOFD9sEKJrOF@nongnu.org
X-Gm-Message-State: AOJu0YzYdGyFyWgg+8ALo/sEZ6lVZltY0kKetSM2Tdaj0yHr2sjNFyRz
 l0v/Fa8k/wEUacC/CEiuPTWQMMKKvQ+R2ra6ptqvkmHWj1xRnkesB2ukINQCUg4eTtwT9sxbEzb
 5S9lGwzw=
X-Gm-Gg: ATEYQzx22pMuKVJxTcxQIm82I/ReST9reZyNJLsgx0gJDWxi10DaJwnHhAhiwjMTGo/
 DwqWJHgb+r4UNMLht6/BdbUPHMcKfwmhkeIq/5PeWpeO86H/yefzQUyKvksozR5jcpAmF+1EMOB
 qNZPQaUHUSjjnxA8FP4hDBLjp7D2qs6WxRXGPNfufDLx4lB404obVBnxZoFMAd8cw2/CS7zEhrH
 0rOsg0ka1gDOm0n6dXOrrUrzcTxeH1jN/JG0nFWnq9KFE6kPf4TZ3tjb55q3dBozeSuiE6uxgvG
 /IcK3lmyQPULA6BpCD8bX8HfOH8yRiBhUlTxNEQAZPcvYrjX6qwgDaNOiGaODh2V6o2G32gJ3Im
 lLVsyJG6ymKHj52FKBPGFizoQ1N3QxgD6i1khba3SP4gCPdn/W2JqmzrCxwSSs+oKt4nMVpepmg
 gCfAjlTX8CZX8zi8eLLSFGaewyMGRi1/83SSNmElnTQoV9xbw05buVFTb6Xz088p2J4A==
X-Received: by 2002:a05:6000:1861:b0:43b:5003:e301 with SMTP id
 ffacd0b85a97d-43b88a8e928mr6019687f8f.42.1774467521195; 
 Wed, 25 Mar 2026 12:38:41 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf069sm1826038f8f.22.2026.03.25.12.38.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 12:38:38 -0700 (PDT)
Message-ID: <4f62c8fe-60ac-4d1c-a0e6-6139e9c334dc@linaro.org>
Date: Wed, 25 Mar 2026 20:38:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 31/35] hw/hexagon: Introduce hexagon TLB device
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
 <20260311034923.1044737-32-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311034923.1044737-32-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Brian,

On 11/3/26 04:49, Brian Cain wrote:
> Add the hexagon TLB QOM device model.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>   include/hw/hexagon/hexagon_tlb.h |  45 +++
>   target/hexagon/cpu.h             |   4 +
>   hw/hexagon/hexagon_tlb.c         | 463 +++++++++++++++++++++++++++++++
>   target/hexagon/cpu.c             |   5 +
>   4 files changed, 517 insertions(+)
>   create mode 100644 include/hw/hexagon/hexagon_tlb.h
>   create mode 100644 hw/hexagon/hexagon_tlb.c
> 
> diff --git a/include/hw/hexagon/hexagon_tlb.h b/include/hw/hexagon/hexagon_tlb.h
> new file mode 100644
> index 00000000000..bcb387aa24d
> --- /dev/null
> +++ b/include/hw/hexagon/hexagon_tlb.h
> @@ -0,0 +1,45 @@
> +/*
> + * Hexagon TLB QOM Device
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_HEXAGON_TLB_H
> +#define HW_HEXAGON_TLB_H
> +
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +#include "exec/hwaddr.h"
> +#include "exec/mmu-access-type.h"
> +#define TYPE_HEXAGON_TLB "hexagon-tlb"
> +OBJECT_DECLARE_SIMPLE_TYPE(HexagonTLBState, HEXAGON_TLB)
> +
> +struct HexagonTLBState {
> +    SysBusDevice parent_obj;
> +
> +    uint32_t num_entries;
> +    uint64_t *entries;
> +};
> +
> +uint64_t hexagon_tlb_read(HexagonTLBState *tlb, uint32_t index);
> +void hexagon_tlb_write(HexagonTLBState *tlb, uint32_t index, uint64_t value);
> +
> +bool hexagon_tlb_find_match(HexagonTLBState *tlb, uint32_t asid,
> +                            uint32_t VA, MMUAccessType access_type,
> +                            hwaddr *PA, int *prot, uint64_t *size,
> +                            int32_t *excp, int *cause_code, int mmu_idx);
> +
> +uint32_t hexagon_tlb_lookup(HexagonTLBState *tlb, uint32_t asid,
> +                            uint32_t VA, int *cause_code);
> +
> +int hexagon_tlb_check_overlap(HexagonTLBState *tlb, uint64_t entry,
> +                              uint64_t index);
> +
> +void hexagon_tlb_dump(HexagonTLBState *tlb);
> +
> +bool hexagon_tlb_dump_entry(FILE *f, uint64_t entry);
> +
> +uint32_t hexagon_tlb_get_num_entries(HexagonTLBState *tlb);
> +
> +#endif /* HW_HEXAGON_TLB_H */
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 9eb2d1bbabe..e39e6e39fec 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -46,6 +46,7 @@
>   #define REG_WRITES_MAX 32
>   #define PRED_WRITES_MAX 5                   /* 4 insns + endloop */
>   #define VSTORES_MAX 2
> +#define MAX_TLB_ENTRIES 1024
>   
>   #define CPU_RESOLVING_TYPE TYPE_HEXAGON_CPU
>   #ifndef CONFIG_USER_ONLY
> @@ -174,6 +175,9 @@ struct ArchCPU {
>       bool lldb_compat;
>       target_ulong lldb_stack_adjust;
>       bool short_circuit;
> +#ifndef CONFIG_USER_ONLY
> +    struct HexagonTLBState *tlb;

Please use the typedef (dropping the 'struct').

> +#endif
>   };
>   
>   #include "cpu_bits.h"
> diff --git a/hw/hexagon/hexagon_tlb.c b/hw/hexagon/hexagon_tlb.c
> new file mode 100644
> index 00000000000..90f319f56d3
> --- /dev/null
> +++ b/hw/hexagon/hexagon_tlb.c
> @@ -0,0 +1,463 @@
> +/*
> + * Hexagon TLB QOM Device
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/hexagon/hexagon_tlb.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/resettable.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "target/hexagon/cpu.h"
> +#include "target/hexagon/cpu_bits.h"
> +
> +/* PTE (TLB entry) field extraction */
> +#define GET_PTE_PPD(entry)   extract64((entry),  0, 24)
> +#define GET_PTE_C(entry)     extract64((entry), 24,  4)
> +#define GET_PTE_U(entry)     extract64((entry), 28,  1)
> +#define GET_PTE_R(entry)     extract64((entry), 29,  1)
> +#define GET_PTE_W(entry)     extract64((entry), 30,  1)
> +#define GET_PTE_X(entry)     extract64((entry), 31,  1)
> +#define GET_PTE_VPN(entry)   extract64((entry), 32, 20)
> +#define GET_PTE_ASID(entry)  extract64((entry), 52,  7)
> +#define GET_PTE_ATR0(entry)  extract64((entry), 59,  1)
> +#define GET_PTE_ATR1(entry)  extract64((entry), 60,  1)
> +#define GET_PTE_PA35(entry)  extract64((entry), 61,  1)
> +#define GET_PTE_G(entry)     extract64((entry), 62,  1)
> +#define GET_PTE_V(entry)     extract64((entry), 63,  1)
> +
> +/* PPD (physical page descriptor) */
> +static inline uint64_t GET_PPD(uint64_t entry)
> +{
> +    return GET_PTE_PPD(entry) | (GET_PTE_PA35(entry) << 24);
> +}
> +
> +#define NO_ASID      (1 << 8)
> +
> +typedef enum {
> +    PGSIZE_4K,
> +    PGSIZE_16K,
> +    PGSIZE_64K,
> +    PGSIZE_256K,
> +    PGSIZE_1M,
> +    PGSIZE_4M,
> +    PGSIZE_16M,
> +    PGSIZE_64M,
> +    PGSIZE_256M,
> +    PGSIZE_1G,
> +    NUM_PGSIZE_TYPES

Matter of style, since the last entry isn't part of the enum
I'd use:

   #define NUM_PGSIZE_TYPES (PGSIZE_1G + 1)

> +} tlb_pgsize_t;
> +
> +static const char *pgsize_str[NUM_PGSIZE_TYPES] = {
> +    "4K",
> +    "16K",
> +    "64K",
> +    "256K",
> +    "1M",
> +    "4M",
> +    "16M",
> +    "64M",
> +    "256M",
> +    "1G",
> +};
> +
> +#define INVALID_MASK 0xffffffffLL
> +
> +static const uint64_t encmask_2_mask[] = {
> +    0x0fffLL,                           /* 4k,   0000 */
> +    0x3fffLL,                           /* 16k,  0001 */
> +    0xffffLL,                           /* 64k,  0010 */
> +    0x3ffffLL,                          /* 256k, 0011 */
> +    0xfffffLL,                          /* 1m,   0100 */
> +    0x3fffffLL,                         /* 4m,   0101 */
> +    0xffffffLL,                         /* 16m,  0110 */
> +    0x3ffffffLL,                        /* 64m,  0111 */
> +    0xfffffffLL,                        /* 256m, 1000 */
> +    0x3fffffffLL,                       /* 1g,   1001 */
> +    INVALID_MASK,                       /* RSVD, 0111 */

Typo '1111' I suppose, since 0111 is 64M.

> +};
> +
> +static inline tlb_pgsize_t hex_tlb_pgsize_type(uint64_t entry)
> +{
> +    if (entry == 0) {
> +        qemu_log_mask(CPU_LOG_MMU, "%s: Supplied TLB entry was 0!\n",
> +                      __func__);
> +        return 0;
> +    }
> +    tlb_pgsize_t size = ctz64(entry);
> +    g_assert(size < NUM_PGSIZE_TYPES);
> +    return size;
> +}
> +
> +static inline uint64_t hex_tlb_page_size_bytes(uint64_t entry)
> +{
> +    return 1ull << (TARGET_PAGE_BITS + 2 * hex_tlb_pgsize_type(entry));
> +}
> +
> +static inline uint64_t hex_tlb_phys_page_num(uint64_t entry)
> +{
> +    uint32_t ppd = GET_PPD(entry);
> +    return ppd >> 1;
> +}
> +
> +static inline uint64_t hex_tlb_phys_addr(uint64_t entry)
> +{
> +    uint64_t pagemask = encmask_2_mask[hex_tlb_pgsize_type(entry)];
> +    uint64_t pagenum = hex_tlb_phys_page_num(entry);
> +    uint64_t PA = (pagenum << TARGET_PAGE_BITS) & (~pagemask);

We are replacing all TARGET_PAGE_BITS uses by qemu_target_page_bits().

> +    return PA;
> +}
> +
> +static inline uint64_t hex_tlb_virt_addr(uint64_t entry)
> +{
> +    return (uint64_t)GET_PTE_VPN(entry) << TARGET_PAGE_BITS;
> +}
> +
> +bool hexagon_tlb_dump_entry(FILE *f, uint64_t entry)
> +{

Prefer Monitor* instead of FILE*.

> +    if (GET_PTE_V(entry)) {
> +        fprintf(f, "0x%016" PRIx64 ": ", entry);
> +        uint64_t PA = hex_tlb_phys_addr(entry);
> +        uint64_t VA = hex_tlb_virt_addr(entry);
> +        fprintf(f, "V:%" PRId64 " G:%" PRId64
> +                " A1:%" PRId64 " A0:%" PRId64,
> +                GET_PTE_V(entry),
> +                GET_PTE_G(entry),
> +                GET_PTE_ATR1(entry),
> +                GET_PTE_ATR0(entry));
> +        fprintf(f, " ASID:0x%02" PRIx64 " VA:0x%08" PRIx64,
> +                GET_PTE_ASID(entry), VA);
> +        fprintf(f,
> +                " X:%" PRId64 " W:%" PRId64 " R:%" PRId64
> +                " U:%" PRId64 " C:%" PRId64,
> +                GET_PTE_X(entry),
> +                GET_PTE_W(entry),
> +                GET_PTE_R(entry),
> +                GET_PTE_U(entry),
> +                GET_PTE_C(entry));
> +        fprintf(f, " PA:0x%09" PRIx64 " SZ:%s (0x%" PRIx64 ")", PA,
> +                pgsize_str[hex_tlb_pgsize_type(entry)],
> +                hex_tlb_page_size_bytes(entry));
> +        fprintf(f, "\n");
> +        return true;
> +    }
> +
> +    /* Not valid */
> +    return false;
> +}
> +
> +static inline bool hex_tlb_entry_match_noperm(uint64_t entry, uint32_t asid,
> +                                              uint64_t VA)
> +{
> +    if (GET_PTE_V(entry)) {
> +        if (GET_PTE_G(entry)) {
> +            /* Global entry - ignore ASID */
> +        } else if (asid != NO_ASID) {
> +            uint32_t tlb_asid = GET_PTE_ASID(entry);
> +            if (tlb_asid != asid) {
> +                return false;
> +            }
> +        }
> +
> +        uint64_t page_size = hex_tlb_page_size_bytes(entry);
> +        uint64_t page_start =
> +            ROUND_DOWN(hex_tlb_virt_addr(entry), page_size);
> +        if (page_start <= VA && VA < page_start + page_size) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +static inline void hex_tlb_entry_get_perm(uint64_t entry,
> +                                          MMUAccessType access_type,
> +                                          int mmu_idx, int *prot,
> +                                          int32_t *excp, int *cause_code)
> +{
> +    bool perm_x = GET_PTE_X(entry);
> +    bool perm_w = GET_PTE_W(entry);
> +    bool perm_r = GET_PTE_R(entry);
> +    bool perm_u = GET_PTE_U(entry);
> +    bool user_idx = mmu_idx == MMU_USER_IDX;
> +
> +    if (mmu_idx == MMU_KERNEL_IDX) {
> +        *prot = PAGE_VALID | PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +        return;
> +    }
> +
> +    *prot = PAGE_VALID;
> +    switch (access_type) {
> +    case MMU_INST_FETCH:
> +        if (user_idx && !perm_u) {
> +            *excp = HEX_EVENT_PRECISE;
> +            *cause_code = HEX_CAUSE_FETCH_NO_UPAGE;
> +        } else if (!perm_x) {
> +            *excp = HEX_EVENT_PRECISE;
> +            *cause_code = HEX_CAUSE_FETCH_NO_XPAGE;
> +        }
> +        break;
> +    case MMU_DATA_LOAD:
> +        if (user_idx && !perm_u) {
> +            *excp = HEX_EVENT_PRECISE;
> +            *cause_code = HEX_CAUSE_PRIV_NO_UREAD;
> +        } else if (!perm_r) {
> +            *excp = HEX_EVENT_PRECISE;
> +            *cause_code = HEX_CAUSE_PRIV_NO_READ;
> +        }
> +        break;
> +    case MMU_DATA_STORE:
> +        if (user_idx && !perm_u) {
> +            *excp = HEX_EVENT_PRECISE;
> +            *cause_code = HEX_CAUSE_PRIV_NO_UWRITE;
> +        } else if (!perm_w) {
> +            *excp = HEX_EVENT_PRECISE;
> +            *cause_code = HEX_CAUSE_PRIV_NO_WRITE;
> +        }
> +        break;
> +    }
> +
> +    if (!user_idx || perm_u) {
> +        if (perm_x) {
> +            *prot |= PAGE_EXEC;
> +        }
> +        if (perm_r) {
> +            *prot |= PAGE_READ;
> +        }
> +        if (perm_w) {
> +            *prot |= PAGE_WRITE;
> +        }
> +    }
> +}
> +
> +static inline bool hex_tlb_entry_match(uint64_t entry, uint8_t asid,
> +                                       uint32_t VA,
> +                                       MMUAccessType access_type, hwaddr *PA,
> +                                       int *prot, uint64_t *size,
> +                                       int32_t *excp, int *cause_code,
> +                                       int mmu_idx)
> +{
> +    if (hex_tlb_entry_match_noperm(entry, asid, VA)) {
> +        hex_tlb_entry_get_perm(entry, access_type, mmu_idx, prot, excp,
> +                               cause_code);
> +        *PA = hex_tlb_phys_addr(entry);
> +        *size = hex_tlb_page_size_bytes(entry);
> +        return true;
> +    }
> +    return false;
> +}
> +
> +static bool hex_tlb_is_match(uint64_t entry1, uint64_t entry2,
> +                             bool consider_gbit)
> +{
> +    bool valid1 = GET_PTE_V(entry1);
> +    bool valid2 = GET_PTE_V(entry2);
> +    uint64_t size1 = hex_tlb_page_size_bytes(entry1);
> +    uint64_t vaddr1 = ROUND_DOWN(hex_tlb_virt_addr(entry1), size1);
> +    uint64_t size2 = hex_tlb_page_size_bytes(entry2);
> +    uint64_t vaddr2 = ROUND_DOWN(hex_tlb_virt_addr(entry2), size2);
> +    int asid1 = GET_PTE_ASID(entry1);
> +    int asid2 = GET_PTE_ASID(entry2);
> +    bool gbit1 = GET_PTE_G(entry1);
> +    bool gbit2 = GET_PTE_G(entry2);
> +
> +    if (!valid1 || !valid2) {
> +        return false;
> +    }
> +
> +    if (((vaddr1 <= vaddr2) && (vaddr2 < (vaddr1 + size1))) ||
> +        ((vaddr2 <= vaddr1) && (vaddr1 < (vaddr2 + size2)))) {
> +        if (asid1 == asid2) {
> +            return true;
> +        }
> +        if ((consider_gbit && gbit1) || gbit2) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +/* Public API */
> +
> +uint64_t hexagon_tlb_read(HexagonTLBState *tlb, uint32_t index)
> +{
> +    g_assert(index < tlb->num_entries);
> +    return tlb->entries[index];
> +}
> +
> +void hexagon_tlb_write(HexagonTLBState *tlb, uint32_t index, uint64_t value)
> +{
> +    g_assert(index < tlb->num_entries);
> +    tlb->entries[index] = value;
> +}
> +
> +bool hexagon_tlb_find_match(HexagonTLBState *tlb, uint32_t asid,
> +                            uint32_t VA, MMUAccessType access_type,
> +                            hwaddr *PA, int *prot, uint64_t *size,
> +                            int32_t *excp, int *cause_code, int mmu_idx)
> +{
> +    *PA = 0;
> +    *prot = 0;
> +    *size = 0;
> +    *excp = 0;
> +    *cause_code = 0;
> +
> +    for (uint32_t i = 0; i < tlb->num_entries; i++) {
> +        if (hex_tlb_entry_match(tlb->entries[i], asid, VA, access_type,
> +                                PA, prot, size, excp, cause_code, mmu_idx)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +uint32_t hexagon_tlb_lookup(HexagonTLBState *tlb, uint32_t asid,
> +                            uint32_t VA, int *cause_code)
> +{
> +    uint32_t not_found = 0x80000000;
> +    uint32_t idx = not_found;
> +
> +    for (uint32_t i = 0; i < tlb->num_entries; i++) {
> +        uint64_t entry = tlb->entries[i];
> +        if (hex_tlb_entry_match_noperm(entry, asid, VA)) {
> +            if (idx != not_found) {
> +                *cause_code = HEX_CAUSE_IMPRECISE_MULTI_TLB_MATCH;
> +                break;
> +            }
> +            idx = i;
> +        }
> +    }
> +
> +    if (idx == not_found) {
> +        qemu_log_mask(CPU_LOG_MMU,
> +                      "%s: 0x%" PRIx32 ", 0x%08" PRIx32 " => NOT FOUND\n",
> +                      __func__, asid, VA);
> +    } else {
> +        qemu_log_mask(CPU_LOG_MMU,
> +                      "%s: 0x%" PRIx32 ", 0x%08" PRIx32 " => %d\n",
> +                      __func__, asid, VA, idx);
> +    }
> +
> +    return idx;
> +}
> +
> +/*
> + * Return codes:
> + * 0 or positive             index of match
> + * -1                        multiple matches
> + * -2                        no match
> + */
> +int hexagon_tlb_check_overlap(HexagonTLBState *tlb, uint64_t entry,
> +                              uint64_t index)
> +{
> +    int matches = 0;
> +    int last_match = 0;
> +
> +    for (uint32_t i = 0; i < tlb->num_entries; i++) {
> +        if (hex_tlb_is_match(entry, tlb->entries[i], false)) {
> +            matches++;
> +            last_match = i;
> +        }
> +    }
> +
> +    if (matches == 1) {
> +        return last_match;
> +    }
> +    if (matches == 0) {
> +        return -2;
> +    }
> +    return -1;
> +}
> +
> +void hexagon_tlb_dump(HexagonTLBState *tlb)
> +{
> +    for (uint32_t i = 0; i < tlb->num_entries; i++) {
> +        hexagon_tlb_dump_entry(stdout, tlb->entries[i]);
> +    }
> +}
> +
> +uint32_t hexagon_tlb_get_num_entries(HexagonTLBState *tlb)
> +{
> +    return tlb->num_entries;
> +}
> +
> +/* QOM lifecycle */
> +
> +static void hexagon_tlb_init(Object *obj)
> +{
> +}
> +
> +static void hexagon_tlb_realize(DeviceState *dev, Error **errp)
> +{
> +    HexagonTLBState *s = HEXAGON_TLB(dev);
> +
> +    if (s->num_entries == 0 || s->num_entries > MAX_TLB_ENTRIES) {
> +        error_setg(errp, "Invalid TLB num-entries: %" PRIu32,
> +                   s->num_entries);
> +        return;
> +    }
> +    s->entries = g_new0(uint64_t, s->num_entries);
> +}
> +
> +static void hexagon_tlb_finalize(Object *obj)
> +{
> +    HexagonTLBState *s = HEXAGON_TLB(obj);
> +    g_free(s->entries);

This should be done in the unrealize() handler.

> +    s->entries = NULL;
> +}
> +
> +static void hexagon_tlb_reset_hold(Object *obj, ResetType type)
> +{
> +    HexagonTLBState *s = HEXAGON_TLB(obj);
> +    if (s->entries) {
> +        memset(s->entries, 0, sizeof(uint64_t) * s->num_entries);
> +    }
> +}
> +
> +static const VMStateDescription vmstate_hexagon_tlb = {
> +    .name = "hexagon-tlb",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(num_entries, HexagonTLBState),
> +        VMSTATE_VARRAY_UINT32_ALLOC(entries, HexagonTLBState, num_entries,
> +                                    0, vmstate_info_uint64, uint64_t),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static const Property hexagon_tlb_properties[] = {
> +    DEFINE_PROP_UINT32("num-entries", HexagonTLBState, num_entries,
> +                       MAX_TLB_ENTRIES),
> +};
> +
> +static void hexagon_tlb_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    dc->realize = hexagon_tlb_realize;
> +    rc->phases.hold = hexagon_tlb_reset_hold;
> +    dc->vmsd = &vmstate_hexagon_tlb;
> +    dc->user_creatable = false;
> +    device_class_set_props(dc, hexagon_tlb_properties);
> +}
> +
> +static const TypeInfo hexagon_tlb_info = {
> +    .name = TYPE_HEXAGON_TLB,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(HexagonTLBState),
> +    .instance_init = hexagon_tlb_init,
> +    .instance_finalize = hexagon_tlb_finalize,
> +    .class_init = hexagon_tlb_class_init,
> +};
> +
> +static void hexagon_tlb_register_types(void)
> +{
> +    type_register_static(&hexagon_tlb_info);
> +}
> +
> +type_init(hexagon_tlb_register_types)
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index b1317f83ef4..32d158684a0 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -23,6 +23,7 @@
>   #include "qapi/error.h"
>   #include "hw/core/qdev-properties.h"
>   #include "fpu/softfloat-helpers.h"
> +#include "hw/hexagon/hexagon_tlb.h"
>   #include "tcg/tcg.h"
>   #include "exec/gdbstub.h"
>   #include "accel/tcg/cpu-ops.h"
> @@ -50,6 +51,10 @@ static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
>   }
>   
>   static const Property hexagon_cpu_properties[] = {
> +#if !defined(CONFIG_USER_ONLY)
> +    DEFINE_PROP_LINK("tlb", HexagonCPU, tlb, TYPE_HEXAGON_TLB,
> +                     HexagonTLBState *),

Not used at this point, maybe add later?

> +#endif
>       DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
>       DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, lldb_stack_adjust, 0,
>                            qdev_prop_uint32, target_ulong),


