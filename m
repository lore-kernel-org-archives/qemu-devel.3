Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC45DC43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wepWN-0006xn-EH; Wed, 01 Jul 2026 03:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wepWM-0006xP-BO
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 03:38:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wepWJ-0002Er-IJ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 03:38:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6615lZPo058567
 for <qemu-devel@nongnu.org>; Wed, 1 Jul 2026 07:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FyeW2TAWskJyLxcZObdcnDYJlnr8V8BLy4aJGluv7pA=; b=ah3yisJJgaRdS6Kr
 FVXdvI6ix0/r/2KwXGdW/QI/hoPSvZVOseWJiwVVnxD0zMOcb/WeIJhcSxfF815U
 iaSWkwlPhXaWp7wOYhAMM8jzemUpPNp8W7XUjFUFsG9wCqMZ3W+BRzjo7gYMsdhX
 U04ykHvsXrDfT2lBDmZcktrYVJXysdITQ0j/KMCKrRCpTU6Fau4PjXRX/yW5XxCi
 XhkqzpiQ8V9PuGe2+RjxKUOCo12dMAvfLCEUYS30jCwvz+2/tPD7vxAcQZpra4r5
 MI+gmAtB59ALdvq8AgOzqF0v59VQFAeC/lok8SMj4jJV7SF5XZC2oGJx5j4CpXwi
 7upZhw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hfybayg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 07:38:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e6ed4fe99so72262885a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 00:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782891485; x=1783496285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FyeW2TAWskJyLxcZObdcnDYJlnr8V8BLy4aJGluv7pA=;
 b=IfGeFOQIOGHVYklqYV6H11j6rlj4wTfeQe+uuIceaJDb/X83Mi6TJTs3STKVmph1wj
 0IO7TJtjo1WHozwVGsh/5lqNRdefcF23tFk2XZUyKQ3UNcxNYsCEnUwISbdBpsLlRHCW
 LGebXHTV5vePWBYqOactP3HNazSBeppDewI+W+4mzEdQv3w/Fgy6CGor6Z2kBYINKyTd
 yI/9Pb8Fcizw3wr1/stQuIbr1+PLfmcDBk/kGeW1CDHtGcjF4od9wcUmBQ/g1n736cwc
 5FZP8MBeQoFBtrjmp3Ic/5CGid4HWU/wtcg3YA8CTcuvGstVGwBMgbVBKWEayoKRybQJ
 le+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782891485; x=1783496285;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FyeW2TAWskJyLxcZObdcnDYJlnr8V8BLy4aJGluv7pA=;
 b=oRdFwH7THqs3jUeidV5XyAYs1kTTyioslda4+NWkJJsBS5HWrMYk1g1x9hv9+mbHHw
 owagU+qPS1eoAqi9yipTRokC175pqZcnbP+WksmHZuOcMVwRwEWQBs9+yyqUQ/y1WO7v
 CAUQJPBBssMHJzREwoP7+WNNgkVSGn9tEvn9udXiDdEJj4x5s77xwwCVb4uj594xzLJL
 mll7RNgSrR+IKgmmCUG+uRorOBytHb5A2Y/M/GuhoHxk9fy9ddhEd+Rfexpio8bsop5M
 mQRYFWBubh3O1v1uWvcHlKIQTxxLiz0F1qjvYQnDzS1A69+UusivqFJmjkLDtQP7wAMg
 brYA==
X-Gm-Message-State: AOJu0Yx/5kjkyJWhDpJ1YJVDckYhLk57VBQ52IkC9+9zl18C64zlMgP9
 uMQkS3F5LDqc827AiLSBF/AaDpw3GS76vxP5FVwa03bA45xBD9n+G+b2Qxlqhnlg3JMOi2lq0r/
 +9Mp0a+xgcqsGHRsnscM3NoxuPtWKATLueJNppwNlYB3zyQHJBE4HJ7PZ7cUxOGyHog==
X-Gm-Gg: AfdE7cmGqj7MWYYGTnXfuiQL0UJ/MVFgYvrXFZ5NI+rjzfE7lCu8jJ6Q2k+Co74GNTu
 CMwaojESo1qCet+Oma7kqYvqHqUBqeF6YcNcF89FKrgnl4X8aCoESkAYTSUrc5XSFd5JJeQe4v4
 DHtp51+STtVWykYL8ZZ0hr8+BW5ItgrWCikmiGCYdZnT3lDvqj2JkGeX4hPU1B1QZXn1QDS1XA3
 ftN6yHJcjBXBSosJxNKAaP8HKx9ilp1SoLq897Jp9G/i6KB0bCQg09dnD95m0Am1jyjrRuhxw8j
 KCkavbaXglERsFG9Il3gK3RFFqZos21xSSBzY7aZ61U/VFo1LzfUxTT9LZyK5mvLiWvPAKsvWc1
 VGVuYrc1Ugz7o17NmJLnleWv0MldJubXRaN4nHwVwhN1MPx1vSjTQML2IjGPNSQ==
X-Received: by 2002:a05:620a:f14:b0:92b:6805:91b5 with SMTP id
 af79cd13be357-92e78501cdcmr72972185a.61.1782891485010; 
 Wed, 01 Jul 2026 00:38:05 -0700 (PDT)
X-Received: by 2002:a05:620a:f14:b0:92b:6805:91b5 with SMTP id
 af79cd13be357-92e78501cdcmr72968185a.61.1782891484228; 
 Wed, 01 Jul 2026 00:38:04 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4d8f5asm82276565e9.8.2026.07.01.00.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 00:38:01 -0700 (PDT)
Message-ID: <e9cdc625-7ded-4678-965a-a98f18150ade@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 09:37:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 21/34] target/arm: Update contiguous first-fault and
 no-fault loads
Content-Language: en-US
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
 <20200511133405.5275-22-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
In-Reply-To: <20200511133405.5275-22-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=J5OaKgnS c=1 sm=1 tr=0 ts=6a44c3dd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=YbNv1KhtmH_5ZlmxC-oA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: yLAPLXBHrXJMCC_RgGEmoUBsI8YilPaG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3NiBTYWx0ZWRfX13IdA6gmB/FM
 Se5oq5njnmheWwxuMpGcscr2vPuA9KFmj4I+g6+LZt7Ko+UPGwwLVsJbeGM4zDS5w1lwpcJvA27
 6l50xmuAwFSMzsvs6jCHz6Zsw3Zn190=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3NiBTYWx0ZWRfX7voPXzmpJONq
 qfKUc6+T5FEOQGTxUxEjgt2ESnOtrmbFI1n22OedpRwvdLPZISLztxF3A+i5aOweBiHG3l0Bi2b
 r/JG79QOcXrifb6+AWqe6qaMkEsFtT4qtqQn/OtgDvG2QMj2Si/4gSJ2G411bBEYaTbBnOczoI/
 vtfB+mPqsKdq8itWHcarR+HdjhS5TS/PADRdvxjR2gkTGxehjg7ipTOilHSerNYWPK9KSrrwjhu
 w0zKOdXxLVVkNA2qedSV079/hKiTupyg79UOeLXhUiZdAB7YS2xO+wcOvXAGJHXl5sNwEzbYJi4
 3V/XgFKRgafhvfkN1A/nVMfKcCPgvW0yQcMUGF5fMzfclXqIqk3DAaEMmAfcgdJ1mgsRgcBTlvh
 C/hyeFXA5JAow+dWj5i2JDSWwZTzzgneZuCnJj/jVv+x3mc+Io0rJRLrecwWf3hozV2njjc+QFW
 PuAnapLxAG+KSk0Mdmw==
X-Proofpoint-GUID: yLAPLXBHrXJMCC_RgGEmoUBsI8YilPaG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010076
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

(this is commit c647673ce4d72a8789703c62a7f3cbc732cb1ea8)

On 11/5/20 15:33, Peter Maydell wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> With sve_cont_ldst_pages, the differences between first-fault and no-fault
> are minimal, so unify the routines.  With cpu_probe_watchpoint, we are able
> to make progress through pages with TLB_WATCHPOINT set when the watchpoint
> does not actually fire.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20200508154359.7494-15-richard.henderson@linaro.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/sve_helper.c | 346 +++++++++++++++++++---------------------
>   1 file changed, 162 insertions(+), 184 deletions(-)
> 
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 9365e326464..f4969347d41 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -4101,18 +4101,6 @@ static intptr_t find_next_active(uint64_t *vg, intptr_t reg_off,
>       return reg_off;
>   }
>   
> -/*
> - * Return the maximum offset <= @mem_max which is still within the page
> - * referenced by @base + @mem_off.
> - */
> -static intptr_t max_for_page(target_ulong base, intptr_t mem_off,
> -                             intptr_t mem_max)
> -{
> -    target_ulong addr = base + mem_off;
> -    intptr_t split = -(intptr_t)(addr | TARGET_PAGE_MASK);
> -    return MIN(split, mem_max - mem_off) + mem_off;
> -}
> -
>   /*
>    * Resolve the guest virtual address to info->host and info->flags.
>    * If @nofault, return false if the page is invalid, otherwise
> @@ -4435,19 +4423,6 @@ static void sve_cont_ldst_watchpoints(SVEContLdSt *info, CPUARMState *env,
>   #endif
>   }
>   
> -/*
> - * The result of tlb_vaddr_to_host for user-only is just g2h(x),
> - * which is always non-null.  Elide the useless test.
> - */
> -static inline bool test_host_page(void *host)
> -{
> -#ifdef CONFIG_USER_ONLY
> -    return true;
> -#else
> -    return likely(host != NULL);
> -#endif
> -}
> -
>   /*
>    * Common helper for all contiguous 1,2,3,4-register predicated stores.
>    */
> @@ -4705,167 +4680,167 @@ static void record_fault(CPUARMState *env, uintptr_t i, uintptr_t oprsz)
>   }
>   
>   /*
> - * Common helper for all contiguous first-fault loads.
> + * Common helper for all contiguous no-fault and first-fault loads.
>    */
> -static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
> -                        uint32_t desc, const uintptr_t retaddr,
> -                        const int esz, const int msz,
> -                        sve_ldst1_host_fn *host_fn,
> -                        sve_ldst1_tlb_fn *tlb_fn)
> +static inline QEMU_ALWAYS_INLINE
> +void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
> +                   uint32_t desc, const uintptr_t retaddr,
> +                   const int esz, const int msz, const SVEContFault fault,
> +                   sve_ldst1_host_fn *host_fn,
> +                   sve_ldst1_tlb_fn *tlb_fn)
>   {
> -    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
> -    const int mmu_idx = get_mmuidx(oi);
>       const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
>       void *vd = &env->vfp.zregs[rd];
> -    const int diffsz = esz - msz;
>       const intptr_t reg_max = simd_oprsz(desc);
> -    const intptr_t mem_max = reg_max >> diffsz;
> -    intptr_t split, reg_off, mem_off, i;
> +    intptr_t reg_off, mem_off, reg_last;
> +    SVEContLdSt info;
> +    int flags;
>       void *host;
>   
> -    /* Skip to the first active element.  */
> -    reg_off = find_next_active(vg, 0, reg_max, esz);
> -    if (unlikely(reg_off == reg_max)) {
> +    /* Find the active elements.  */
> +    if (!sve_cont_ldst_elements(&info, addr, vg, reg_max, esz, 1 << msz)) {
>           /* The entire predicate was false; no load occurs.  */
>           memset(vd, 0, reg_max);
>           return;
>       }
> -    mem_off = reg_off >> diffsz;
> +    reg_off = info.reg_off_first[0];
>   
> -    /*
> -     * If the (remaining) load is entirely within a single page, then:
> -     * For softmmu, and the tlb hits, then no faults will occur;
> -     * For user-only, either the first load will fault or none will.
> -     * We can thus perform the load directly to the destination and
> -     * Vd will be unmodified on any exception path.
> -     */
> -    split = max_for_page(addr, mem_off, mem_max);
> -    if (likely(split == mem_max)) {
> -        host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
> -        if (test_host_page(host)) {
> -            i = reg_off;
> -            host -= mem_off;
> -            do {
> -                host_fn(vd, i, host + (i >> diffsz));
> -                i = find_next_active(vg, i + (1 << esz), reg_max, esz);
> -            } while (i < reg_max);
> -            /* After any fault, zero any leading inactive elements.  */
> +    /* Probe the page(s). */
> +    if (!sve_cont_ldst_pages(&info, fault, env, addr, MMU_DATA_LOAD, retaddr)) {
> +        /* Fault on first element. */
> +        tcg_debug_assert(fault == FAULT_NO);
> +        memset(vd, 0, reg_max);
> +        goto do_fault;
> +    }
> +
> +    mem_off = info.mem_off_first[0];
> +    flags = info.page[0].flags;
> +
> +    if (fault == FAULT_FIRST) {
> +        /*
> +         * Special handling of the first active element,
> +         * if it crosses a page boundary or is MMIO.
> +         */
> +        bool is_split = mem_off == info.mem_off_split;
> +        /* TODO: MTE check. */
> +        if (unlikely(flags != 0) || unlikely(is_split)) {
> +            /*
> +             * Use the slow path for cross-page handling.
> +             * Might trap for MMIO or watchpoints.
> +             */
> +            tlb_fn(env, vd, reg_off, addr + mem_off, retaddr);
> +
> +            /* After any fault, zero the other elements. */
>               swap_memzero(vd, reg_off);
> -            return;
> +            reg_off += 1 << esz;
> +            mem_off += 1 << msz;
> +            swap_memzero(vd + reg_off, reg_max - reg_off);
> +
> +            if (is_split) {
> +                goto second_page;
> +            }
> +        } else {
> +            memset(vd, 0, reg_max);
> +        }
> +    } else {
> +        memset(vd, 0, reg_max);
> +        if (unlikely(mem_off == info.mem_off_split)) {

Is this code reachable on user emulation? The changes are
quite complex, previously code was guarded with CONFIG_USER_ONLY.

> +            /* The first active element crosses a page boundary. */
> +            flags |= info.page[1].flags;
> +            if (unlikely(flags & TLB_MMIO)) {
> +                /* Some page is MMIO, see below. */
> +                goto do_fault;
> +            }
> +            if (unlikely(flags & TLB_WATCHPOINT) &&
> +                (cpu_watchpoint_address_matches
> +                 (env_cpu(env), addr + mem_off, 1 << msz)
> +                 & BP_MEM_READ)) {
> +                /* Watchpoint hit, see below. */
> +                goto do_fault;
> +            }
> +            /* TODO: MTE check. */
> +            /*
> +             * Use the slow path for cross-page handling.
> +             * This is RAM, without a watchpoint, and will not trap.
> +             */
> +            tlb_fn(env, vd, reg_off, addr + mem_off, retaddr);
> +            goto second_page;
>           }
>       }
>   
>       /*
> -     * Perform one normal read, which will fault or not.
> -     * But it is likely to bring the page into the tlb.
> +     * From this point on, all memory operations are MemSingleNF.
> +     *
> +     * Per the MemSingleNF pseudocode, a no-fault load from Device memory
> +     * must not actually hit the bus -- it returns (UNKNOWN, FAULT) instead.
> +     *
> +     * Unfortuately we do not have access to the memory attributes from the
> +     * PTE to tell Device memory from Normal memory.  So we make a mostly
> +     * correct check, and indicate (UNKNOWN, FAULT) for any MMIO.
> +     * This gives the right answer for the common cases of "Normal memory,
> +     * backed by host RAM" and "Device memory, backed by MMIO".
> +     * The architecture allows us to suppress an NF load and return
> +     * (UNKNOWN, FAULT) for any reason, so our behaviour for the corner
> +     * case of "Normal memory, backed by MMIO" is permitted.  The case we
> +     * get wrong is "Device memory, backed by host RAM", for which we
> +     * should return (UNKNOWN, FAULT) for but do not.
> +     *
> +     * Similarly, CPU_BP breakpoints would raise exceptions, and so
> +     * return (UNKNOWN, FAULT).  For simplicity, we consider gdb and
> +     * architectural breakpoints the same.
>        */
> -    tlb_fn(env, vd, reg_off, addr + mem_off, retaddr);
> +    if (unlikely(flags & TLB_MMIO)) {
> +        goto do_fault;
> +    }
>   
> -    /* After any fault, zero any leading predicated false elts.  */
> -    swap_memzero(vd, reg_off);
> -    mem_off += 1 << msz;
> -    reg_off += 1 << esz;
> +    reg_last = info.reg_off_last[0];
> +    host = info.page[0].host;
>   
> -    /* Try again to read the balance of the page.  */
> -    split = max_for_page(addr, mem_off - 1, mem_max);
> -    if (split >= (1 << msz)) {
> -        host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
> -        if (host) {
> -            host -= mem_off;
> -            do {
> +    do {
> +        uint64_t pg = *(uint64_t *)(vg + (reg_off >> 3));
> +        do {
> +            if ((pg >> (reg_off & 63)) & 1) {
> +                if (unlikely(flags & TLB_WATCHPOINT) &&
> +                    (cpu_watchpoint_address_matches
> +                     (env_cpu(env), addr + mem_off, 1 << msz)
> +                     & BP_MEM_READ)) {
> +                    goto do_fault;
> +                }
> +                /* TODO: MTE check. */
>                   host_fn(vd, reg_off, host + mem_off);
> -                reg_off += 1 << esz;
> -                reg_off = find_next_active(vg, reg_off, reg_max, esz);
> -                mem_off = reg_off >> diffsz;
> -            } while (split - mem_off >= (1 << msz));
> -        }
> -    }
> -
> -    record_fault(env, reg_off, reg_max);
> -}
> -
> -/*
> - * Common helper for all contiguous no-fault loads.
> - */
> -static void sve_ldnf1_r(CPUARMState *env, void *vg, const target_ulong addr,
> -                        uint32_t desc, const int esz, const int msz,
> -                        sve_ldst1_host_fn *host_fn)
> -{
> -    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
> -    void *vd = &env->vfp.zregs[rd];
> -    const int diffsz = esz - msz;
> -    const intptr_t reg_max = simd_oprsz(desc);
> -    const intptr_t mem_max = reg_max >> diffsz;
> -    const int mmu_idx = cpu_mmu_index(env, false);
> -    intptr_t split, reg_off, mem_off;
> -    void *host;
> -
> -#ifdef CONFIG_USER_ONLY
> -    host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmu_idx);
> -    if (likely(page_check_range(addr, mem_max, PAGE_READ) == 0)) {
> -        /* The entire operation is valid and will not fault.  */
> -        reg_off = 0;
> -        do {
> -            mem_off = reg_off >> diffsz;
> -            host_fn(vd, reg_off, host + mem_off);
> +            }
>               reg_off += 1 << esz;
> -            reg_off = find_next_active(vg, reg_off, reg_max, esz);
> -        } while (reg_off < reg_max);
> -        return;
> -    }
> -#endif
> +            mem_off += 1 << msz;
> +        } while (reg_off <= reg_last && (reg_off & 63));
> +    } while (reg_off <= reg_last);
>   
> -    /* There will be no fault, so we may modify in advance.  */
> -    memset(vd, 0, reg_max);
> -
> -    /* Skip to the first active element.  */
> -    reg_off = find_next_active(vg, 0, reg_max, esz);
> -    if (unlikely(reg_off == reg_max)) {
> -        /* The entire predicate was false; no load occurs.  */
> -        return;
> -    }
> -    mem_off = reg_off >> diffsz;
> -
> -#ifdef CONFIG_USER_ONLY
> -    if (page_check_range(addr + mem_off, 1 << msz, PAGE_READ) == 0) {
> -        /* At least one load is valid; take the rest of the page.  */
> -        split = max_for_page(addr, mem_off + (1 << msz) - 1, mem_max);
> -        do {
> -            host_fn(vd, reg_off, host + mem_off);
> -            reg_off += 1 << esz;
> -            reg_off = find_next_active(vg, reg_off, reg_max, esz);
> -            mem_off = reg_off >> diffsz;
> -        } while (split - mem_off >= (1 << msz));
> -    }
> -#else
>       /*
> -     * If the address is not in the TLB, we have no way to bring the
> -     * entry into the TLB without also risking a fault.  Note that
> -     * the corollary is that we never load from an address not in RAM.
> -     *
> -     * This last is out of spec, in a weird corner case.
> -     * Per the MemNF/MemSingleNF pseudocode, a NF load from Device memory
> -     * must not actually hit the bus -- it returns UNKNOWN data instead.
> -     * But if you map non-RAM with Normal memory attributes and do a NF
> -     * load then it should access the bus.  (Nobody ought actually do this
> -     * in the real world, obviously.)
> -     *
> -     * Then there are the annoying special cases with watchpoints...
> -     * TODO: Add a form of non-faulting loads using cc->tlb_fill(probe=true).
> +     * MemSingleNF is allowed to fail for any reason.  We have special
> +     * code above to handle the first element crossing a page boundary.
> +     * As an implementation choice, decline to handle a cross-page element
> +     * in any other position.
>        */
> -    host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
> -    split = max_for_page(addr, mem_off, mem_max);
> -    if (host && split >= (1 << msz)) {
> -        host -= mem_off;
> -        do {
> -            host_fn(vd, reg_off, host + mem_off);
> -            reg_off += 1 << esz;
> -            reg_off = find_next_active(vg, reg_off, reg_max, esz);
> -            mem_off = reg_off >> diffsz;
> -        } while (split - mem_off >= (1 << msz));
> +    reg_off = info.reg_off_split;
> +    if (reg_off >= 0) {
> +        goto do_fault;
>       }
> -#endif
>   
> + second_page:
> +    reg_off = info.reg_off_first[1];
> +    if (likely(reg_off < 0)) {
> +        /* No active elements on the second page.  All done. */
> +        return;
> +    }
> +
> +    /*
> +     * MemSingleNF is allowed to fail for any reason.  As an implementation
> +     * choice, decline to handle elements on the second page.  This should
> +     * be low frequency as the guest walks through memory -- the next
> +     * iteration of the guest's loop should be aligned on the page boundary,
> +     * and then all following iterations will stay aligned.
> +     */
> +
> + do_fault:
>       record_fault(env, reg_off, reg_max);
>   }
>   
> @@ -4873,58 +4848,61 @@ static void sve_ldnf1_r(CPUARMState *env, void *vg, const target_ulong addr,
>   void HELPER(sve_ldff1##PART##_r)(CPUARMState *env, void *vg,            \
>                                    target_ulong addr, uint32_t desc)      \
>   {                                                                       \
> -    sve_ldff1_r(env, vg, addr, desc, GETPC(), ESZ, 0,                   \
> -                sve_ld1##PART##_host, sve_ld1##PART##_tlb);             \
> +    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_FIRST, \
> +                  sve_ld1##PART##_host, sve_ld1##PART##_tlb);           \
>   }                                                                       \
>   void HELPER(sve_ldnf1##PART##_r)(CPUARMState *env, void *vg,            \
>                                    target_ulong addr, uint32_t desc)      \
>   {                                                                       \
> -    sve_ldnf1_r(env, vg, addr, desc, ESZ, 0, sve_ld1##PART##_host);     \
> +    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_NO,    \
> +                  sve_ld1##PART##_host, sve_ld1##PART##_tlb);           \
>   }
>   
>   #define DO_LDFF1_LDNF1_2(PART, ESZ, MSZ) \
>   void HELPER(sve_ldff1##PART##_le_r)(CPUARMState *env, void *vg,         \
>                                       target_ulong addr, uint32_t desc)   \
>   {                                                                       \
> -    sve_ldff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,                 \
> -                sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);       \
> +    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST,  \
> +                  sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);     \
>   }                                                                       \
>   void HELPER(sve_ldnf1##PART##_le_r)(CPUARMState *env, void *vg,         \
>                                       target_ulong addr, uint32_t desc)   \
>   {                                                                       \
> -    sve_ldnf1_r(env, vg, addr, desc, ESZ, MSZ, sve_ld1##PART##_le_host); \
> +    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO,     \
> +                  sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);     \
>   }                                                                       \
>   void HELPER(sve_ldff1##PART##_be_r)(CPUARMState *env, void *vg,         \
>                                       target_ulong addr, uint32_t desc)   \
>   {                                                                       \
> -    sve_ldff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,                 \
> -                sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);       \
> +    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST,  \
> +                  sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);     \
>   }                                                                       \
>   void HELPER(sve_ldnf1##PART##_be_r)(CPUARMState *env, void *vg,         \
>                                       target_ulong addr, uint32_t desc)   \
>   {                                                                       \
> -    sve_ldnf1_r(env, vg, addr, desc, ESZ, MSZ, sve_ld1##PART##_be_host); \
> +    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO,     \
> +                  sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);     \
>   }
>   
> -DO_LDFF1_LDNF1_1(bb,  0)
> -DO_LDFF1_LDNF1_1(bhu, 1)
> -DO_LDFF1_LDNF1_1(bhs, 1)
> -DO_LDFF1_LDNF1_1(bsu, 2)
> -DO_LDFF1_LDNF1_1(bss, 2)
> -DO_LDFF1_LDNF1_1(bdu, 3)
> -DO_LDFF1_LDNF1_1(bds, 3)
> +DO_LDFF1_LDNF1_1(bb,  MO_8)
> +DO_LDFF1_LDNF1_1(bhu, MO_16)
> +DO_LDFF1_LDNF1_1(bhs, MO_16)
> +DO_LDFF1_LDNF1_1(bsu, MO_32)
> +DO_LDFF1_LDNF1_1(bss, MO_32)
> +DO_LDFF1_LDNF1_1(bdu, MO_64)
> +DO_LDFF1_LDNF1_1(bds, MO_64)
>   
> -DO_LDFF1_LDNF1_2(hh,  1, 1)
> -DO_LDFF1_LDNF1_2(hsu, 2, 1)
> -DO_LDFF1_LDNF1_2(hss, 2, 1)
> -DO_LDFF1_LDNF1_2(hdu, 3, 1)
> -DO_LDFF1_LDNF1_2(hds, 3, 1)
> +DO_LDFF1_LDNF1_2(hh,  MO_16, MO_16)
> +DO_LDFF1_LDNF1_2(hsu, MO_32, MO_16)
> +DO_LDFF1_LDNF1_2(hss, MO_32, MO_16)
> +DO_LDFF1_LDNF1_2(hdu, MO_64, MO_16)
> +DO_LDFF1_LDNF1_2(hds, MO_64, MO_16)
>   
> -DO_LDFF1_LDNF1_2(ss,  2, 2)
> -DO_LDFF1_LDNF1_2(sdu, 3, 2)
> -DO_LDFF1_LDNF1_2(sds, 3, 2)
> +DO_LDFF1_LDNF1_2(ss,  MO_32, MO_32)
> +DO_LDFF1_LDNF1_2(sdu, MO_64, MO_32)
> +DO_LDFF1_LDNF1_2(sds, MO_64, MO_32)
>   
> -DO_LDFF1_LDNF1_2(dd,  3, 3)
> +DO_LDFF1_LDNF1_2(dd,  MO_64, MO_64)
>   
>   #undef DO_LDFF1_LDNF1_1
>   #undef DO_LDFF1_LDNF1_2


