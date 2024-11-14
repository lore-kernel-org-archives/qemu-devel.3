Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AB7D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBebT-0002TS-0s; Thu, 14 Nov 2024 13:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBebN-0002Ok-PM
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:29:58 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBebK-00018z-Vm
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:29:57 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ea0bd709c0so611022a91.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731608993; x=1732213793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RPdsoxL68jFLQKssYQ5BOQ1mmx8AQLNIT6BZdQXqzYI=;
 b=s8yDbqhEHuYSpHY67VEVNEvg+WOA8M4SKg8w+lMF93CM6HRKdJKDNnGbhDnlEIyqqt
 rprOfRWSvgJ+pAE6HPP2DSVncDOFizFpA7ZEHBofRNlyUIo7Y5NqAVR7bvE8zO11JqN3
 rhdV8h6oBfTSbUu9eSinSlLymK7rJaXbt9IxUN/usxGcWz9Hi3ZGx3t9cC1Q5qkBjThj
 KVlHO9TKlfPt7moRm8Vlc3H4+hs5S6Fyp2ik5CG54RzgZ9Y/tGx9pAtPOGcOyrOg1CRs
 +zI79y+oL6YZareknVIrlzaOztKxb0irS7E0z8vC7xMKwcw22euuppNWzafMy/yCusd5
 9lpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731608993; x=1732213793;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RPdsoxL68jFLQKssYQ5BOQ1mmx8AQLNIT6BZdQXqzYI=;
 b=o3/U6ujeJYno8A4IR4TmePzC1vy69DCw1DoWs1eicsNjCWNp8BaybRhq/acBAJOOnl
 A87YPW6TRJWLXB2+8wvJcblx7Ud9/E0B/r0UfQY4q/h2Rgkfy28Du8+O2DmslHv6tW08
 NobEndKE6qsJYoWvm6/2qpikY1ZgI0tFLvXvNC0UoAi2PFKxfZ46nhNoirrymZlDus/Y
 otBaJedv++WMzyG0udcFxSq2VLN8S3dGaEEvR0RtweiQa3xsbkZZhuvJcYYJ71hRpahg
 6I+6yhSLnRn5edegUbDopiX6mWqYGzgZ9Dtn/P6H/j3xZ+OphHdXi/EM+6vnIZy6dL4L
 A24Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZhJWZTIiHYYeHZiHA3PhtIyNC+WOeZmxdo0rtM1vSYaT/o72uWVuNRqC8rQJCAV7CBkIrBbEGbDHo@nongnu.org
X-Gm-Message-State: AOJu0YygC62ArmXycJym9oCQZ2Yj975sn1+Yz/V4vBIjWL2UGKXW+GDU
 s39nT/WpSH+CUpkvAS6+f4jx9HVS46i71lgRO+P6ejvR19mYs6JmCsHkJYBby+Q=
X-Google-Smtp-Source: AGHT+IHsJXMlJvgq+U/OEa2ThxDe4eOzPgwAs0ieoW09DYwFNJeLyQAD5EXgzIGHnS/CMd8Voakh4A==
X-Received: by 2002:a17:90a:d005:b0:2c9:b72:7a1f with SMTP id
 98e67ed59e1d1-2ea06a934ecmr3010449a91.28.1731608993350; 
 Thu, 14 Nov 2024 10:29:53 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7c2c605sm13797005ad.8.2024.11.14.10.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:29:52 -0800 (PST)
Message-ID: <dfc3ebe1-173d-4aa1-8153-a927fdfe2320@linaro.org>
Date: Thu, 14 Nov 2024 10:29:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/54] accel/tcg: Partially unify MMULookupPageData and
 TLBLookupOutput
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-30-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-30-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

On 11/14/24 08:01, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 151 ++++++++++++++++++++++-----------------------
>   1 file changed, 74 insertions(+), 77 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index a33bebf55a..8f459be5a8 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1684,10 +1684,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
>    */
>   
>   typedef struct MMULookupPageData {
> -    CPUTLBEntryFull *full;
> -    void *haddr;
>       vaddr addr;
> -    int flags;
>       int size;
>       TLBLookupOutput o;
>   } MMULookupPageData;
> @@ -1724,10 +1721,6 @@ static void mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
>       };
>   
>       tlb_lookup_nofail(cpu, &data->o, &i);
> -
> -    data->full = &data->o.full;
> -    data->flags = data->o.flags;
> -    data->haddr = data->o.haddr;
>   }
>   
>   /**
> @@ -1743,24 +1736,22 @@ static void mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
>   static void mmu_watch_or_dirty(CPUState *cpu, MMULookupPageData *data,
>                                  MMUAccessType access_type, uintptr_t ra)
>   {
> -    CPUTLBEntryFull *full = data->full;
> -    vaddr addr = data->addr;
> -    int flags = data->flags;
> -    int size = data->size;
> +    int flags = data->o.flags;
>   
>       /* On watchpoint hit, this will longjmp out.  */
>       if (flags & TLB_WATCHPOINT) {
>           int wp = access_type == MMU_DATA_STORE ? BP_MEM_WRITE : BP_MEM_READ;
> -        cpu_check_watchpoint(cpu, addr, size, full->attrs, wp, ra);
> +        cpu_check_watchpoint(cpu, data->addr, data->size,
> +                             data->o.full.attrs, wp, ra);
>           flags &= ~TLB_WATCHPOINT;
>       }
>   
>       /* Note that notdirty is only set for writes. */
>       if (flags & TLB_NOTDIRTY) {
> -        notdirty_write(cpu, addr, size, full, ra);
> +        notdirty_write(cpu, data->addr, data->size, &data->o.full, ra);
>           flags &= ~TLB_NOTDIRTY;
>       }
> -    data->flags = flags;
> +    data->o.flags = flags;
>   }
>   
>   /**
> @@ -1795,7 +1786,7 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>       if (likely(!crosspage)) {
>           mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
>   
> -        flags = l->page[0].flags;
> +        flags = l->page[0].o.flags;
>           if (unlikely(flags & (TLB_WATCHPOINT | TLB_NOTDIRTY))) {
>               mmu_watch_or_dirty(cpu, &l->page[0], type, ra);
>           }
> @@ -1812,7 +1803,7 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>           mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
>           mmu_lookup1(cpu, &l->page[1], 0, l->mmu_idx, type, ra);
>   
> -        flags = l->page[0].flags | l->page[1].flags;
> +        flags = l->page[0].o.flags | l->page[1].o.flags;
>           if (unlikely(flags & (TLB_WATCHPOINT | TLB_NOTDIRTY))) {
>               mmu_watch_or_dirty(cpu, &l->page[0], type, ra);
>               mmu_watch_or_dirty(cpu, &l->page[1], type, ra);
> @@ -2029,7 +2020,7 @@ static Int128 do_ld16_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
>    */
>   static uint64_t do_ld_bytes_beN(MMULookupPageData *p, uint64_t ret_be)
>   {
> -    uint8_t *haddr = p->haddr;
> +    uint8_t *haddr = p->o.haddr;
>       int i, size = p->size;
>   
>       for (i = 0; i < size; i++) {
> @@ -2047,7 +2038,7 @@ static uint64_t do_ld_bytes_beN(MMULookupPageData *p, uint64_t ret_be)
>    */
>   static uint64_t do_ld_parts_beN(MMULookupPageData *p, uint64_t ret_be)
>   {
> -    void *haddr = p->haddr;
> +    void *haddr = p->o.haddr;
>       int size = p->size;
>   
>       do {
> @@ -2097,7 +2088,7 @@ static uint64_t do_ld_parts_beN(MMULookupPageData *p, uint64_t ret_be)
>   static uint64_t do_ld_whole_be4(MMULookupPageData *p, uint64_t ret_be)
>   {
>       int o = p->addr & 3;
> -    uint32_t x = load_atomic4(p->haddr - o);
> +    uint32_t x = load_atomic4(p->o.haddr - o);
>   
>       x = cpu_to_be32(x);
>       x <<= o * 8;
> @@ -2117,7 +2108,7 @@ static uint64_t do_ld_whole_be8(CPUState *cpu, uintptr_t ra,
>                                   MMULookupPageData *p, uint64_t ret_be)
>   {
>       int o = p->addr & 7;
> -    uint64_t x = load_atomic8_or_exit(cpu, ra, p->haddr - o);
> +    uint64_t x = load_atomic8_or_exit(cpu, ra, p->o.haddr - o);
>   
>       x = cpu_to_be64(x);
>       x <<= o * 8;
> @@ -2137,7 +2128,7 @@ static Int128 do_ld_whole_be16(CPUState *cpu, uintptr_t ra,
>                                  MMULookupPageData *p, uint64_t ret_be)
>   {
>       int o = p->addr & 15;
> -    Int128 x, y = load_atomic16_or_exit(cpu, ra, p->haddr - o);
> +    Int128 x, y = load_atomic16_or_exit(cpu, ra, p->o.haddr - o);
>       int size = p->size;
>   
>       if (!HOST_BIG_ENDIAN) {
> @@ -2160,8 +2151,8 @@ static uint64_t do_ld_beN(CPUState *cpu, MMULookupPageData *p,
>       MemOp atom;
>       unsigned tmp, half_size;
>   
> -    if (unlikely(p->flags & TLB_MMIO)) {
> -        return do_ld_mmio_beN(cpu, p->full, ret_be, p->addr, p->size,
> +    if (unlikely(p->o.flags & TLB_MMIO)) {
> +        return do_ld_mmio_beN(cpu, &p->o.full, ret_be, p->addr, p->size,
>                                 mmu_idx, type, ra);
>       }
>   
> @@ -2210,8 +2201,9 @@ static Int128 do_ld16_beN(CPUState *cpu, MMULookupPageData *p,
>       uint64_t b;
>       MemOp atom;
>   
> -    if (unlikely(p->flags & TLB_MMIO)) {
> -        return do_ld16_mmio_beN(cpu, p->full, a, p->addr, size, mmu_idx, ra);
> +    if (unlikely(p->o.flags & TLB_MMIO)) {
> +        return do_ld16_mmio_beN(cpu, &p->o.full, a, p->addr,
> +                                size, mmu_idx, ra);
>       }
>   
>       /*
> @@ -2223,7 +2215,7 @@ static Int128 do_ld16_beN(CPUState *cpu, MMULookupPageData *p,
>       case MO_ATOM_SUBALIGN:
>           p->size = size - 8;
>           a = do_ld_parts_beN(p, a);
> -        p->haddr += size - 8;
> +        p->o.haddr += size - 8;
>           p->size = 8;
>           b = do_ld_parts_beN(p, 0);
>           break;
> @@ -2242,7 +2234,7 @@ static Int128 do_ld16_beN(CPUState *cpu, MMULookupPageData *p,
>       case MO_ATOM_NONE:
>           p->size = size - 8;
>           a = do_ld_bytes_beN(p, a);
> -        b = ldq_be_p(p->haddr + size - 8);
> +        b = ldq_be_p(p->o.haddr + size - 8);
>           break;
>   
>       default:
> @@ -2255,10 +2247,11 @@ static Int128 do_ld16_beN(CPUState *cpu, MMULookupPageData *p,
>   static uint8_t do_ld_1(CPUState *cpu, MMULookupPageData *p, int mmu_idx,
>                          MMUAccessType type, uintptr_t ra)
>   {
> -    if (unlikely(p->flags & TLB_MMIO)) {
> -        return do_ld_mmio_beN(cpu, p->full, 0, p->addr, 1, mmu_idx, type, ra);
> +    if (unlikely(p->o.flags & TLB_MMIO)) {
> +        return do_ld_mmio_beN(cpu, &p->o.full, 0, p->addr, 1,
> +                              mmu_idx, type, ra);
>       } else {
> -        return *(uint8_t *)p->haddr;
> +        return *(uint8_t *)p->o.haddr;
>       }
>   }
>   
> @@ -2267,14 +2260,15 @@ static uint16_t do_ld_2(CPUState *cpu, MMULookupPageData *p, int mmu_idx,
>   {
>       uint16_t ret;
>   
> -    if (unlikely(p->flags & TLB_MMIO)) {
> -        ret = do_ld_mmio_beN(cpu, p->full, 0, p->addr, 2, mmu_idx, type, ra);
> +    if (unlikely(p->o.flags & TLB_MMIO)) {
> +        ret = do_ld_mmio_beN(cpu, &p->o.full, 0, p->addr, 2,
> +                             mmu_idx, type, ra);
>           if ((memop & MO_BSWAP) == MO_LE) {
>               ret = bswap16(ret);
>           }
>       } else {
>           /* Perform the load host endian, then swap if necessary. */
> -        ret = load_atom_2(cpu, ra, p->haddr, memop);
> +        ret = load_atom_2(cpu, ra, p->o.haddr, memop);
>           if (memop & MO_BSWAP) {
>               ret = bswap16(ret);
>           }
> @@ -2287,14 +2281,15 @@ static uint32_t do_ld_4(CPUState *cpu, MMULookupPageData *p, int mmu_idx,
>   {
>       uint32_t ret;
>   
> -    if (unlikely(p->flags & TLB_MMIO)) {
> -        ret = do_ld_mmio_beN(cpu, p->full, 0, p->addr, 4, mmu_idx, type, ra);
> +    if (unlikely(p->o.flags & TLB_MMIO)) {
> +        ret = do_ld_mmio_beN(cpu, &p->o.full, 0, p->addr, 4,
> +                             mmu_idx, type, ra);
>           if ((memop & MO_BSWAP) == MO_LE) {
>               ret = bswap32(ret);
>           }
>       } else {
>           /* Perform the load host endian. */
> -        ret = load_atom_4(cpu, ra, p->haddr, memop);
> +        ret = load_atom_4(cpu, ra, p->o.haddr, memop);
>           if (memop & MO_BSWAP) {
>               ret = bswap32(ret);
>           }
> @@ -2307,14 +2302,15 @@ static uint64_t do_ld_8(CPUState *cpu, MMULookupPageData *p, int mmu_idx,
>   {
>       uint64_t ret;
>   
> -    if (unlikely(p->flags & TLB_MMIO)) {
> -        ret = do_ld_mmio_beN(cpu, p->full, 0, p->addr, 8, mmu_idx, type, ra);
> +    if (unlikely(p->o.flags & TLB_MMIO)) {
> +        ret = do_ld_mmio_beN(cpu, &p->o.full, 0, p->addr, 8,
> +                             mmu_idx, type, ra);
>           if ((memop & MO_BSWAP) == MO_LE) {
>               ret = bswap64(ret);
>           }
>       } else {
>           /* Perform the load host endian. */
> -        ret = load_atom_8(cpu, ra, p->haddr, memop);
> +        ret = load_atom_8(cpu, ra, p->o.haddr, memop);
>           if (memop & MO_BSWAP) {
>               ret = bswap64(ret);
>           }
> @@ -2414,15 +2410,15 @@ static Int128 do_ld16_mmu(CPUState *cpu, vaddr addr,
>       cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
>       crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_LOAD, &l);
>       if (likely(!crosspage)) {
> -        if (unlikely(l.page[0].flags & TLB_MMIO)) {
> -            ret = do_ld16_mmio_beN(cpu, l.page[0].full, 0, addr, 16,
> +        if (unlikely(l.page[0].o.flags & TLB_MMIO)) {
> +            ret = do_ld16_mmio_beN(cpu, &l.page[0].o.full, 0, addr, 16,
>                                      l.mmu_idx, ra);
>               if ((l.memop & MO_BSWAP) == MO_LE) {
>                   ret = bswap128(ret);
>               }
>           } else {
>               /* Perform the load host endian. */
> -            ret = load_atom_16(cpu, ra, l.page[0].haddr, l.memop);
> +            ret = load_atom_16(cpu, ra, l.page[0].o.haddr, l.memop);
>               if (l.memop & MO_BSWAP) {
>                   ret = bswap128(ret);
>               }
> @@ -2568,10 +2564,10 @@ static uint64_t do_st_leN(CPUState *cpu, MMULookupPageData *p,
>       MemOp atom;
>       unsigned tmp, half_size;
>   
> -    if (unlikely(p->flags & TLB_MMIO)) {
> -        return do_st_mmio_leN(cpu, p->full, val_le, p->addr,
> +    if (unlikely(p->o.flags & TLB_MMIO)) {
> +        return do_st_mmio_leN(cpu, &p->o.full, val_le, p->addr,
>                                 p->size, mmu_idx, ra);
> -    } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
> +    } else if (unlikely(p->o.flags & TLB_DISCARD_WRITE)) {
>           return val_le >> (p->size * 8);
>       }
>   
> @@ -2582,7 +2578,7 @@ static uint64_t do_st_leN(CPUState *cpu, MMULookupPageData *p,
>       atom = mop & MO_ATOM_MASK;
>       switch (atom) {
>       case MO_ATOM_SUBALIGN:
> -        return store_parts_leN(p->haddr, p->size, val_le);
> +        return store_parts_leN(p->o.haddr, p->size, val_le);
>   
>       case MO_ATOM_IFALIGN_PAIR:
>       case MO_ATOM_WITHIN16_PAIR:
> @@ -2593,9 +2589,9 @@ static uint64_t do_st_leN(CPUState *cpu, MMULookupPageData *p,
>               ? p->size == half_size
>               : p->size >= half_size) {
>               if (!HAVE_al8_fast && p->size <= 4) {
> -                return store_whole_le4(p->haddr, p->size, val_le);
> +                return store_whole_le4(p->o.haddr, p->size, val_le);
>               } else if (HAVE_al8) {
> -                return store_whole_le8(p->haddr, p->size, val_le);
> +                return store_whole_le8(p->o.haddr, p->size, val_le);
>               } else {
>                   cpu_loop_exit_atomic(cpu, ra);
>               }
> @@ -2605,7 +2601,7 @@ static uint64_t do_st_leN(CPUState *cpu, MMULookupPageData *p,
>       case MO_ATOM_IFALIGN:
>       case MO_ATOM_WITHIN16:
>       case MO_ATOM_NONE:
> -        return store_bytes_leN(p->haddr, p->size, val_le);
> +        return store_bytes_leN(p->o.haddr, p->size, val_le);
>   
>       default:
>           g_assert_not_reached();
> @@ -2622,10 +2618,10 @@ static uint64_t do_st16_leN(CPUState *cpu, MMULookupPageData *p,
>       int size = p->size;
>       MemOp atom;
>   
> -    if (unlikely(p->flags & TLB_MMIO)) {
> -        return do_st16_mmio_leN(cpu, p->full, val_le, p->addr,
> +    if (unlikely(p->o.flags & TLB_MMIO)) {
> +        return do_st16_mmio_leN(cpu, &p->o.full, val_le, p->addr,
>                                   size, mmu_idx, ra);
> -    } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
> +    } else if (unlikely(p->o.flags & TLB_DISCARD_WRITE)) {
>           return int128_gethi(val_le) >> ((size - 8) * 8);
>       }
>   
> @@ -2636,8 +2632,8 @@ static uint64_t do_st16_leN(CPUState *cpu, MMULookupPageData *p,
>       atom = mop & MO_ATOM_MASK;
>       switch (atom) {
>       case MO_ATOM_SUBALIGN:
> -        store_parts_leN(p->haddr, 8, int128_getlo(val_le));
> -        return store_parts_leN(p->haddr + 8, p->size - 8,
> +        store_parts_leN(p->o.haddr, 8, int128_getlo(val_le));
> +        return store_parts_leN(p->o.haddr + 8, p->size - 8,
>                                  int128_gethi(val_le));
>   
>       case MO_ATOM_WITHIN16_PAIR:
> @@ -2645,7 +2641,7 @@ static uint64_t do_st16_leN(CPUState *cpu, MMULookupPageData *p,
>           if (!HAVE_CMPXCHG128) {
>               cpu_loop_exit_atomic(cpu, ra);
>           }
> -        return store_whole_le16(p->haddr, p->size, val_le);
> +        return store_whole_le16(p->o.haddr, p->size, val_le);
>   
>       case MO_ATOM_IFALIGN_PAIR:
>           /*
> @@ -2655,8 +2651,8 @@ static uint64_t do_st16_leN(CPUState *cpu, MMULookupPageData *p,
>       case MO_ATOM_IFALIGN:
>       case MO_ATOM_WITHIN16:
>       case MO_ATOM_NONE:
> -        stq_le_p(p->haddr, int128_getlo(val_le));
> -        return store_bytes_leN(p->haddr + 8, p->size - 8,
> +        stq_le_p(p->o.haddr, int128_getlo(val_le));
> +        return store_bytes_leN(p->o.haddr + 8, p->size - 8,
>                                  int128_gethi(val_le));
>   
>       default:
> @@ -2667,69 +2663,69 @@ static uint64_t do_st16_leN(CPUState *cpu, MMULookupPageData *p,
>   static void do_st_1(CPUState *cpu, MMULookupPageData *p, uint8_t val,
>                       int mmu_idx, uintptr_t ra)
>   {
> -    if (unlikely(p->flags & TLB_MMIO)) {
> -        do_st_mmio_leN(cpu, p->full, val, p->addr, 1, mmu_idx, ra);
> -    } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
> +    if (unlikely(p->o.flags & TLB_MMIO)) {
> +        do_st_mmio_leN(cpu, &p->o.full, val, p->addr, 1, mmu_idx, ra);
> +    } else if (unlikely(p->o.flags & TLB_DISCARD_WRITE)) {
>           /* nothing */
>       } else {
> -        *(uint8_t *)p->haddr = val;
> +        *(uint8_t *)p->o.haddr = val;
>       }
>   }
>   
>   static void do_st_2(CPUState *cpu, MMULookupPageData *p, uint16_t val,
>                       int mmu_idx, MemOp memop, uintptr_t ra)
>   {
> -    if (unlikely(p->flags & TLB_MMIO)) {
> +    if (unlikely(p->o.flags & TLB_MMIO)) {
>           if ((memop & MO_BSWAP) != MO_LE) {
>               val = bswap16(val);
>           }
> -        do_st_mmio_leN(cpu, p->full, val, p->addr, 2, mmu_idx, ra);
> -    } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
> +        do_st_mmio_leN(cpu, &p->o.full, val, p->addr, 2, mmu_idx, ra);
> +    } else if (unlikely(p->o.flags & TLB_DISCARD_WRITE)) {
>           /* nothing */
>       } else {
>           /* Swap to host endian if necessary, then store. */
>           if (memop & MO_BSWAP) {
>               val = bswap16(val);
>           }
> -        store_atom_2(cpu, ra, p->haddr, memop, val);
> +        store_atom_2(cpu, ra, p->o.haddr, memop, val);
>       }
>   }
>   
>   static void do_st_4(CPUState *cpu, MMULookupPageData *p, uint32_t val,
>                       int mmu_idx, MemOp memop, uintptr_t ra)
>   {
> -    if (unlikely(p->flags & TLB_MMIO)) {
> +    if (unlikely(p->o.flags & TLB_MMIO)) {
>           if ((memop & MO_BSWAP) != MO_LE) {
>               val = bswap32(val);
>           }
> -        do_st_mmio_leN(cpu, p->full, val, p->addr, 4, mmu_idx, ra);
> -    } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
> +        do_st_mmio_leN(cpu, &p->o.full, val, p->addr, 4, mmu_idx, ra);
> +    } else if (unlikely(p->o.flags & TLB_DISCARD_WRITE)) {
>           /* nothing */
>       } else {
>           /* Swap to host endian if necessary, then store. */
>           if (memop & MO_BSWAP) {
>               val = bswap32(val);
>           }
> -        store_atom_4(cpu, ra, p->haddr, memop, val);
> +        store_atom_4(cpu, ra, p->o.haddr, memop, val);
>       }
>   }
>   
>   static void do_st_8(CPUState *cpu, MMULookupPageData *p, uint64_t val,
>                       int mmu_idx, MemOp memop, uintptr_t ra)
>   {
> -    if (unlikely(p->flags & TLB_MMIO)) {
> +    if (unlikely(p->o.flags & TLB_MMIO)) {
>           if ((memop & MO_BSWAP) != MO_LE) {
>               val = bswap64(val);
>           }
> -        do_st_mmio_leN(cpu, p->full, val, p->addr, 8, mmu_idx, ra);
> -    } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
> +        do_st_mmio_leN(cpu, &p->o.full, val, p->addr, 8, mmu_idx, ra);
> +    } else if (unlikely(p->o.flags & TLB_DISCARD_WRITE)) {
>           /* nothing */
>       } else {
>           /* Swap to host endian if necessary, then store. */
>           if (memop & MO_BSWAP) {
>               val = bswap64(val);
>           }
> -        store_atom_8(cpu, ra, p->haddr, memop, val);
> +        store_atom_8(cpu, ra, p->o.haddr, memop, val);
>       }
>   }
>   
> @@ -2822,19 +2818,20 @@ static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
>       cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
>       crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_STORE, &l);
>       if (likely(!crosspage)) {
> -        if (unlikely(l.page[0].flags & TLB_MMIO)) {
> +        if (unlikely(l.page[0].o.flags & TLB_MMIO)) {
>               if ((l.memop & MO_BSWAP) != MO_LE) {
>                   val = bswap128(val);
>               }
> -            do_st16_mmio_leN(cpu, l.page[0].full, val, addr, 16, l.mmu_idx, ra);
> -        } else if (unlikely(l.page[0].flags & TLB_DISCARD_WRITE)) {
> +            do_st16_mmio_leN(cpu, &l.page[0].o.full, val, addr,
> +                             16, l.mmu_idx, ra);
> +        } else if (unlikely(l.page[0].o.flags & TLB_DISCARD_WRITE)) {
>               /* nothing */
>           } else {
>               /* Swap to host endian if necessary, then store. */
>               if (l.memop & MO_BSWAP) {
>                   val = bswap128(val);
>               }
> -            store_atom_16(cpu, ra, l.page[0].haddr, l.memop, val);
> +            store_atom_16(cpu, ra, l.page[0].o.haddr, l.memop, val);
>           }
>           return;
>       }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


