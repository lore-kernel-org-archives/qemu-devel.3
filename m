Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BDEC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 18:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHows-0003Pc-GU; Thu, 13 Jun 2024 14:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sHowr-0003PJ-TD
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 14:13:21 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sHowp-0006Cy-Be
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 14:13:21 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-705c0115192so1178633b3a.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 11:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718302397; x=1718907197; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OhPkw/9yfmUCiurKw9qDtgNWqclA6iHl5jI9qpHXj7k=;
 b=KABauxB9JMO5DlGBIdue6LoaEzxaoosSXvIMK4jYwY2oGcx7G8/+kiPD4UylhCNwcN
 HWNU1YpChr4I+x2JQ+9OIssvwQtjoH2gy64HwvMX4hrS4rC9WUSCO7uE6kGgNFI7fGgu
 fxqmxiv+UA+7qnQb8tiEaBpI/D9EkGJBZ+A63OkQK3GZtlmRrjCzZ3fyur5fXbmwHkPR
 5xsr1PBOYcnLVgIU6+MoEqJCwH+dLqKhyflM4vol01jmZ7AEoWK2QmaOqdPA7rzz2O3x
 KzSTChmPMphv9S96wvi/vDHR2fScuVlF5/N2kG592bMwUEGJxn+SfIlag8QRFbHLXArX
 b+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718302397; x=1718907197;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OhPkw/9yfmUCiurKw9qDtgNWqclA6iHl5jI9qpHXj7k=;
 b=fcNNsojx6km4cqrlBpiGqsU2lojz1dMiuf7mqTuuU2svTC6qp0EvOaF9JT4oMRZrK/
 0cfdvd2voM5+UoxqwSCZVNRrqZepJV705idNXpT8P9Be6e0OY7XdDVhE9w0Cii2YKZR0
 M1aniBoJarClhEcHTzYRhs5Upwfu2xtbX+GMXnHmH0Jd80KbtlSP1KQ0rzpgL7JpetpR
 7B4Z6rkk/wMPo2m+ZS1g1qyhdfmMlvn/PbZuIm5LSoCl4c2V9wOTuE8eYF4Pn8SECf8C
 dxDpnKAwZD40iIz1oTTD0WoUbfMQUTvAQcchwabq264LqP3b1vqGepBP4wrjdyjZB3Ls
 qTUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOhZOwrfAGNtCCTQKZtqlWZP6XhiAALPp3OKHXBVjvE0r7cFGM9S6udeUoIUPiXNKViT6nAbuWZBZvDSB58/Jhw7rXR+k=
X-Gm-Message-State: AOJu0YwoNjHDL5KE3nRwdD5PwbyG5rFfFktKKrIeWmbQiesxPOcchFpM
 7Qm9QMgOAQsNoUiB6rBNoSvYDa+isXq54mt0Cx6CdGfoKo97K+ncWDQUZf1J/ag=
X-Google-Smtp-Source: AGHT+IFlmHWZJwhRIO0qP1IblIDfAtFyj007LEZ1Q/uYvqgqivEXlPtwr+cf6AaVvWXgIoMNikiSxQ==
X-Received: by 2002:a05:6a00:2d02:b0:705:c0a3:3bba with SMTP id
 d2e1a72fcca58-705d71d132bmr501704b3a.32.1718302397410; 
 Thu, 13 Jun 2024 11:13:17 -0700 (PDT)
Received: from ?IPv6:2804:7f0:b400:8dcb:db2a:52bb:5a8e:66c5?
 ([2804:7f0:b400:8dcb:db2a:52bb:5a8e:66c5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb72561sm1616469b3a.180.2024.06.13.11.13.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 11:13:17 -0700 (PDT)
Subject: Re: [PATCH v2 5/9] target/arm: Make some MTE helpers widely available
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <20240613172103.2987519-6-gustavo.romero@linaro.org>
 <49457f87-2b07-4e62-98ee-893f57a3ca2a@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <e1a79665-62c3-5511-b7ad-baf8e72a17b1@linaro.org>
Date: Thu, 13 Jun 2024 15:13:13 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <49457f87-2b07-4e62-98ee-893f57a3ca2a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.395,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Phil!

On 6/13/24 2:32 PM, Philippe Mathieu-Daudé wrote:
> Hi Gustavo,
> 
> On 13/6/24 19:20, Gustavo Romero wrote:
>> Make the MTE helpers allocation_tag_mem_probe, load_tag1, and store_tag1
>> available to other subsystems by moving them from mte_helper.c to a new
>> header file, mte_helper.h.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   target/arm/tcg/mte_helper.c | 184 +------------------------------
>>   target/arm/tcg/mte_helper.h | 211 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 212 insertions(+), 183 deletions(-)
>>   create mode 100644 target/arm/tcg/mte_helper.h
> 
>> diff --git a/target/arm/tcg/mte_helper.h b/target/arm/tcg/mte_helper.h
>> new file mode 100644
>> index 0000000000..2d09345642
>> --- /dev/null
>> +++ b/target/arm/tcg/mte_helper.h
>> @@ -0,0 +1,211 @@
>> +/*
>> + * ARM MemTag Operation Helpers
>> + *
>> + * Copyright (c) 2024 Linaro, Ltd.
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2.1 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> 
> Preferably parsable license tag:
> 
>   * SPDX-License-Identifier: LGPL-2.1-or-later

ok.


>> + */
>> +
>> +#ifndef TARGET_ARM_MTE_H
>> +#define TARGET_ARM_MTE_H
>> +
>> +#include "exec/exec-all.h"
> 
> Why do you need "exec/exec-all.h"?

Otherwise one gets:

In file included from ../target/arm/gdbstub.c:30:
../target/arm/tcg/mte_helper.h: In function ‘allocation_tag_mem_probe’:
../target/arm/tcg/mte_helper.h:77:9: error: implicit declaration of function ‘cpu_loop_exit_sigsegv’; did you mean ‘cpu_loop_exit_noexc’? [-Werror=implicit-function-declaration]
    77 |         cpu_loop_exit_sigsegv(env_cpu(env), ptr, ptr_access,
       |         ^~~~~~~~~~~~~~~~~~~~~
       |         cpu_loop_exit_noexc
../target/arm/tcg/mte_helper.h:77:9: error: nested extern declaration of ‘cpu_loop_exit_sigsegv’ [-Werror=nested-externs]

Any other idea on how to satisfy it?


>> +#include "exec/ram_addr.h"
>> +#include "hw/core/tcg-cpu-ops.h"
>> +#include "qemu/log.h"
>> +
>> +/**
>> + * allocation_tag_mem_probe:
>> + * @env: the cpu environment
>> + * @ptr_mmu_idx: the addressing regime to use for the virtual address
>> + * @ptr: the virtual address for which to look up tag memory
>> + * @ptr_access: the access to use for the virtual address
>> + * @ptr_size: the number of bytes in the normal memory access
>> + * @tag_access: the access to use for the tag memory
>> + * @probe: true to merely probe, never taking an exception
>> + * @ra: the return address for exception handling
>> + *
>> + * Our tag memory is formatted as a sequence of little-endian nibbles.
>> + * That is, the byte at (addr >> (LOG2_TAG_GRANULE + 1)) contains two
>> + * tags, with the tag at [3:0] for the lower addr and the tag at [7:4]
>> + * for the higher addr.
>> + *
>> + * Here, resolve the physical address from the virtual address, and return
>> + * a pointer to the corresponding tag byte.
>> + *
>> + * If there is no tag storage corresponding to @ptr, return NULL.
>> + *
>> + * If the page is inaccessible for @ptr_access, or has a watchpoint, there are
>> + * three options:
>> + * (1) probe = true, ra = 0 : pure probe -- we return NULL if the page is not
>> + *     accessible, and do not take watchpoint traps. The calling code must
>> + *     handle those cases in the right priority compared to MTE traps.
>> + * (2) probe = false, ra = 0 : probe, no fault expected -- the caller guarantees
>> + *     that the page is going to be accessible. We will take watchpoint traps.
>> + * (3) probe = false, ra != 0 : non-probe -- we will take both memory access
>> + *     traps and watchpoint traps.
>> + * (probe = true, ra != 0 is invalid and will assert.)
>> + */
>> +static inline uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
>> +                                         uint64_t ptr, MMUAccessType ptr_access,
>> +                                         int ptr_size, MMUAccessType tag_access,
>> +                                         bool probe, uintptr_t ra)
> 
> Do we really need an inlined function? Since it calls non-inlined
> methods, I don't really see the point.

inline is just a hint and I think that in general at least the overhead
for calling this function is reduced, but it's hard to say what the
compile heuristics will do exactly without looking at the compiled code.

But I can remove it for this function and leave it just for {load,store}_tag1.


>> +{
>> +#ifdef CONFIG_USER_ONLY
>> +    uint64_t clean_ptr = useronly_clean_ptr(ptr);
>> +    int flags = page_get_flags(clean_ptr);
>> +    uint8_t *tags;
>> +    uintptr_t index;
>> +
>> +    assert(!(probe && ra));
>> +
>> +    if (!(flags & (ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ))) {
>> +        if (probe) {
>> +            return NULL;
>> +        }
>> +        cpu_loop_exit_sigsegv(env_cpu(env), ptr, ptr_access,
>> +                              !(flags & PAGE_VALID), ra);
>> +    }
>> +
>> +    /* Require both MAP_ANON and PROT_MTE for the page. */
>> +    if (!(flags & PAGE_ANON) || !(flags & PAGE_MTE)) {
>> +        return NULL;
>> +    }
>> +
>> +    tags = page_get_target_data(clean_ptr);
>> +
>> +    index = extract32(ptr, LOG2_TAG_GRANULE + 1,
>> +                      TARGET_PAGE_BITS - LOG2_TAG_GRANULE - 1);
>> +    return tags + index;
>> +#else
>> +    CPUTLBEntryFull *full;
>> +    MemTxAttrs attrs;
>> +    int in_page, flags;
>> +    hwaddr ptr_paddr, tag_paddr, xlat;
>> +    MemoryRegion *mr;
>> +    ARMASIdx tag_asi;
>> +    AddressSpace *tag_as;
>> +    void *host;
>> +
>> +    /*
>> +     * Probe the first byte of the virtual address.  This raises an
>> +     * exception for inaccessible pages, and resolves the virtual address
>> +     * into the softmmu tlb.
>> +     *
>> +     * When RA == 0, this is either a pure probe or a no-fault-expected probe.
>> +     * Indicate to probe_access_flags no-fault, then either return NULL
>> +     * for the pure probe, or assert that we received a valid page for the
>> +     * no-fault-expected probe.
>> +     */
>> +    flags = probe_access_full(env, ptr, 0, ptr_access, ptr_mmu_idx,
>> +                              ra == 0, &host, &full, ra);
>> +    if (probe && (flags & TLB_INVALID_MASK)) {
>> +        return NULL;
>> +    }
>> +    assert(!(flags & TLB_INVALID_MASK));
>> +
>> +    /* If the virtual page MemAttr != Tagged, access unchecked. */
>> +    if (full->extra.arm.pte_attrs != 0xf0) {
>> +        return NULL;
>> +    }
>> +
>> +    /*
>> +     * If not backed by host ram, there is no tag storage: access unchecked.
>> +     * This is probably a guest os bug though, so log it.
>> +     */
>> +    if (unlikely(flags & TLB_MMIO)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "Page @ 0x%" PRIx64 " indicates Tagged Normal memory "
>> +                      "but is not backed by host ram\n", ptr);
>> +        return NULL;
>> +    }
>> +
>> +    /*
>> +     * Remember these values across the second lookup below,
>> +     * which may invalidate this pointer via tlb resize.
>> +     */
>> +    ptr_paddr = full->phys_addr | (ptr & ~TARGET_PAGE_MASK);
>> +    attrs = full->attrs;
>> +    full = NULL;
>> +
>> +    /*
>> +     * The Normal memory access can extend to the next page.  E.g. a single
>> +     * 8-byte access to the last byte of a page will check only the last
>> +     * tag on the first page.
>> +     * Any page access exception has priority over tag check exception.
>> +     */
>> +    in_page = -(ptr | TARGET_PAGE_MASK);
>> +    if (unlikely(ptr_size > in_page)) {
>> +        flags |= probe_access_full(env, ptr + in_page, 0, ptr_access,
>> +                                   ptr_mmu_idx, ra == 0, &host, &full, ra);
>> +        assert(!(flags & TLB_INVALID_MASK));
>> +    }
>> +
>> +    /* Any debug exception has priority over a tag check exception. */
>> +    if (!probe && unlikely(flags & TLB_WATCHPOINT)) {
>> +        int wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ : BP_MEM_WRITE;
>> +        assert(ra != 0);
>> +        cpu_check_watchpoint(env_cpu(env), ptr, ptr_size, attrs, wp, ra);
>> +    }
>> +
>> +    /* Convert to the physical address in tag space.  */
>> +    tag_paddr = ptr_paddr >> (LOG2_TAG_GRANULE + 1);
>> +
>> +    /* Look up the address in tag space. */
>> +    tag_asi = attrs.secure ? ARMASIdx_TagS : ARMASIdx_TagNS;
>> +    tag_as = cpu_get_address_space(env_cpu(env), tag_asi);
>> +    mr = address_space_translate(tag_as, tag_paddr, &xlat, NULL,
>> +                                 tag_access == MMU_DATA_STORE, attrs);
>> +
>> +    /*
>> +     * Note that @mr will never be NULL.  If there is nothing in the address
>> +     * space at @tag_paddr, the translation will return the unallocated memory
>> +     * region.  For our purposes, the result must be ram.
>> +     */
>> +    if (unlikely(!memory_region_is_ram(mr))) {
>> +        /* ??? Failure is a board configuration error. */
>> +        qemu_log_mask(LOG_UNIMP,
>> +                      "Tag Memory @ 0x%" HWADDR_PRIx " not found for "
>> +                      "Normal Memory @ 0x%" HWADDR_PRIx "\n",
>> +                      tag_paddr, ptr_paddr);
>> +        return NULL;
>> +    }
>> +
>> +    /*
>> +     * Ensure the tag memory is dirty on write, for migration.
>> +     * Tag memory can never contain code or display memory (vga).
>> +     */
>> +    if (tag_access == MMU_DATA_STORE) {
>> +        ram_addr_t tag_ra = memory_region_get_ram_addr(mr) + xlat;
>> +        cpu_physical_memory_set_dirty_flag(tag_ra, DIRTY_MEMORY_MIGRATION);
>> +    }
>> +
>> +    return memory_region_get_ram_ptr(mr) + xlat;
>> +#endif
>> +}
>> +
>> +static inline int load_tag1(uint64_t ptr, uint8_t *mem)
>> +{
>> +    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
>> +    return extract32(*mem, ofs, 4);
>> +}
>> +
>> +/* For use in a non-parallel context, store to the given nibble.  */
>> +static inline void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
>> +{
>> +    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
>> +    *mem = deposit32(*mem, ofs, 4, tag);
>> +}
>> +
>> +#endif /* TARGET_ARM_MTE_H */
> 

