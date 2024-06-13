Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C97C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHoJK-0008LH-DM; Thu, 13 Jun 2024 13:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHoJI-0008Ko-Em
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:32:28 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHoJF-0007cm-Os
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:32:28 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-35dc9cef36dso1285303f8f.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 10:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718299944; x=1718904744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yGEwkwNzCPYIkUjLXEEaRxLOqIvYwlkZeCXJ++hG7BA=;
 b=zh6VQ8pTGUJ0MD9zD8LBcFsO4gW9Tcm2TadxL48AHm5f42bcOEk1142Xau+Hkiptyb
 VbQGlmnTaQL1UK6jxYK8k1H7ezikaIZHtWUoh5FOMqXCA2SrTDfNcP4XaIdRg6OP+rDn
 hNwfBTSfnCU2Sjk+86vlTmKf7H+a8EAkmh70pUefdpNs9qTGLa/lrtCtSU9u7hA/HY0u
 4VvUxYnWo4UOxSehBfqzTtyIPs0lycaZpxkxebjJ8/ebwRtkmX9Mg6enoezmy4RFga9x
 zGuKAManfvTSSxw259xiagkrmXno/TFoNVXdFpEsGDtxGqaKM11fvSjYlOi1NARxs2sU
 7EgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718299944; x=1718904744;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yGEwkwNzCPYIkUjLXEEaRxLOqIvYwlkZeCXJ++hG7BA=;
 b=nvjXR5KIsgdqY4wssM3jgPPbGe1Dv8GM3Iyy0EJsGJRWMdBRG9mc7gs32c5LgWDmWQ
 aCHON/P1KgoWzWi0vWzDMiifdJH+Hqi2W+4rCBK0CECDHTRWeX/C6nVjWRb5Q2Ls3mzR
 cIcMO4yil5bSkk5GaeiTJmntWyayyQUZw7NnozUncFsjCEzg65pAfiAAjlprQKtHjY6o
 lreCLVzM/kArvaT7G8awiWoDL1SixO47oRuOhzcVbQ8dGVJpbRDqlgBn68eQyJN90wlo
 X6vDV+v7fCddIwWcPwKQTlfcew6iUzzO6GHtLT90f19X3GeXNtodnCzPdL87+F0r4XEz
 gOFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4TY0qlEw8oNpvARbo5Ze+1bAFmXvzf20B0nEpz9LOhXwLeNbYViJDxtKF8w7NoejubK6DGzqx1RKDFvsOIcyByfM4Ilk=
X-Gm-Message-State: AOJu0YzWtlZQ2YUWD657eGnJd40BXNneffeo2mi63E7zTiZoVQkz+xo4
 S3EBeFmFwPvP+0luWTDR4N5y/2NH5I0xrtVpjah/BHvBzGjcZp7pE1u3Is8a66mrAK3UQnUhcje
 I
X-Google-Smtp-Source: AGHT+IFKXj/i3tBClLZKctcq5mgWKxdrst9mG6SQMnWvPYtXHu+W4bqPqSXwlGVO50//8wJY+t7FWA==
X-Received: by 2002:adf:f3ca:0:b0:35f:24dc:ad97 with SMTP id
 ffacd0b85a97d-3607a75c36dmr234559f8f.34.1718299944142; 
 Thu, 13 Jun 2024 10:32:24 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.148.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075103237sm2271541f8f.92.2024.06.13.10.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 10:32:23 -0700 (PDT)
Message-ID: <49457f87-2b07-4e62-98ee-893f57a3ca2a@linaro.org>
Date: Thu, 13 Jun 2024 19:32:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] target/arm: Make some MTE helpers widely available
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <20240613172103.2987519-6-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613172103.2987519-6-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Gustavo,

On 13/6/24 19:20, Gustavo Romero wrote:
> Make the MTE helpers allocation_tag_mem_probe, load_tag1, and store_tag1
> available to other subsystems by moving them from mte_helper.c to a new
> header file, mte_helper.h.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   target/arm/tcg/mte_helper.c | 184 +------------------------------
>   target/arm/tcg/mte_helper.h | 211 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 212 insertions(+), 183 deletions(-)
>   create mode 100644 target/arm/tcg/mte_helper.h

> diff --git a/target/arm/tcg/mte_helper.h b/target/arm/tcg/mte_helper.h
> new file mode 100644
> index 0000000000..2d09345642
> --- /dev/null
> +++ b/target/arm/tcg/mte_helper.h
> @@ -0,0 +1,211 @@
> +/*
> + * ARM MemTag Operation Helpers
> + *
> + * Copyright (c) 2024 Linaro, Ltd.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.

Preferably parsable license tag:

  * SPDX-License-Identifier: LGPL-2.1-or-later

> + */
> +
> +#ifndef TARGET_ARM_MTE_H
> +#define TARGET_ARM_MTE_H
> +
> +#include "exec/exec-all.h"

Why do you need "exec/exec-all.h"?

> +#include "exec/ram_addr.h"
> +#include "hw/core/tcg-cpu-ops.h"
> +#include "qemu/log.h"
> +
> +/**
> + * allocation_tag_mem_probe:
> + * @env: the cpu environment
> + * @ptr_mmu_idx: the addressing regime to use for the virtual address
> + * @ptr: the virtual address for which to look up tag memory
> + * @ptr_access: the access to use for the virtual address
> + * @ptr_size: the number of bytes in the normal memory access
> + * @tag_access: the access to use for the tag memory
> + * @probe: true to merely probe, never taking an exception
> + * @ra: the return address for exception handling
> + *
> + * Our tag memory is formatted as a sequence of little-endian nibbles.
> + * That is, the byte at (addr >> (LOG2_TAG_GRANULE + 1)) contains two
> + * tags, with the tag at [3:0] for the lower addr and the tag at [7:4]
> + * for the higher addr.
> + *
> + * Here, resolve the physical address from the virtual address, and return
> + * a pointer to the corresponding tag byte.
> + *
> + * If there is no tag storage corresponding to @ptr, return NULL.
> + *
> + * If the page is inaccessible for @ptr_access, or has a watchpoint, there are
> + * three options:
> + * (1) probe = true, ra = 0 : pure probe -- we return NULL if the page is not
> + *     accessible, and do not take watchpoint traps. The calling code must
> + *     handle those cases in the right priority compared to MTE traps.
> + * (2) probe = false, ra = 0 : probe, no fault expected -- the caller guarantees
> + *     that the page is going to be accessible. We will take watchpoint traps.
> + * (3) probe = false, ra != 0 : non-probe -- we will take both memory access
> + *     traps and watchpoint traps.
> + * (probe = true, ra != 0 is invalid and will assert.)
> + */
> +static inline uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
> +                                         uint64_t ptr, MMUAccessType ptr_access,
> +                                         int ptr_size, MMUAccessType tag_access,
> +                                         bool probe, uintptr_t ra)

Do we really need an inlined function? Since it calls non-inlined
methods, I don't really see the point.

> +{
> +#ifdef CONFIG_USER_ONLY
> +    uint64_t clean_ptr = useronly_clean_ptr(ptr);
> +    int flags = page_get_flags(clean_ptr);
> +    uint8_t *tags;
> +    uintptr_t index;
> +
> +    assert(!(probe && ra));
> +
> +    if (!(flags & (ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ))) {
> +        if (probe) {
> +            return NULL;
> +        }
> +        cpu_loop_exit_sigsegv(env_cpu(env), ptr, ptr_access,
> +                              !(flags & PAGE_VALID), ra);
> +    }
> +
> +    /* Require both MAP_ANON and PROT_MTE for the page. */
> +    if (!(flags & PAGE_ANON) || !(flags & PAGE_MTE)) {
> +        return NULL;
> +    }
> +
> +    tags = page_get_target_data(clean_ptr);
> +
> +    index = extract32(ptr, LOG2_TAG_GRANULE + 1,
> +                      TARGET_PAGE_BITS - LOG2_TAG_GRANULE - 1);
> +    return tags + index;
> +#else
> +    CPUTLBEntryFull *full;
> +    MemTxAttrs attrs;
> +    int in_page, flags;
> +    hwaddr ptr_paddr, tag_paddr, xlat;
> +    MemoryRegion *mr;
> +    ARMASIdx tag_asi;
> +    AddressSpace *tag_as;
> +    void *host;
> +
> +    /*
> +     * Probe the first byte of the virtual address.  This raises an
> +     * exception for inaccessible pages, and resolves the virtual address
> +     * into the softmmu tlb.
> +     *
> +     * When RA == 0, this is either a pure probe or a no-fault-expected probe.
> +     * Indicate to probe_access_flags no-fault, then either return NULL
> +     * for the pure probe, or assert that we received a valid page for the
> +     * no-fault-expected probe.
> +     */
> +    flags = probe_access_full(env, ptr, 0, ptr_access, ptr_mmu_idx,
> +                              ra == 0, &host, &full, ra);
> +    if (probe && (flags & TLB_INVALID_MASK)) {
> +        return NULL;
> +    }
> +    assert(!(flags & TLB_INVALID_MASK));
> +
> +    /* If the virtual page MemAttr != Tagged, access unchecked. */
> +    if (full->extra.arm.pte_attrs != 0xf0) {
> +        return NULL;
> +    }
> +
> +    /*
> +     * If not backed by host ram, there is no tag storage: access unchecked.
> +     * This is probably a guest os bug though, so log it.
> +     */
> +    if (unlikely(flags & TLB_MMIO)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Page @ 0x%" PRIx64 " indicates Tagged Normal memory "
> +                      "but is not backed by host ram\n", ptr);
> +        return NULL;
> +    }
> +
> +    /*
> +     * Remember these values across the second lookup below,
> +     * which may invalidate this pointer via tlb resize.
> +     */
> +    ptr_paddr = full->phys_addr | (ptr & ~TARGET_PAGE_MASK);
> +    attrs = full->attrs;
> +    full = NULL;
> +
> +    /*
> +     * The Normal memory access can extend to the next page.  E.g. a single
> +     * 8-byte access to the last byte of a page will check only the last
> +     * tag on the first page.
> +     * Any page access exception has priority over tag check exception.
> +     */
> +    in_page = -(ptr | TARGET_PAGE_MASK);
> +    if (unlikely(ptr_size > in_page)) {
> +        flags |= probe_access_full(env, ptr + in_page, 0, ptr_access,
> +                                   ptr_mmu_idx, ra == 0, &host, &full, ra);
> +        assert(!(flags & TLB_INVALID_MASK));
> +    }
> +
> +    /* Any debug exception has priority over a tag check exception. */
> +    if (!probe && unlikely(flags & TLB_WATCHPOINT)) {
> +        int wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ : BP_MEM_WRITE;
> +        assert(ra != 0);
> +        cpu_check_watchpoint(env_cpu(env), ptr, ptr_size, attrs, wp, ra);
> +    }
> +
> +    /* Convert to the physical address in tag space.  */
> +    tag_paddr = ptr_paddr >> (LOG2_TAG_GRANULE + 1);
> +
> +    /* Look up the address in tag space. */
> +    tag_asi = attrs.secure ? ARMASIdx_TagS : ARMASIdx_TagNS;
> +    tag_as = cpu_get_address_space(env_cpu(env), tag_asi);
> +    mr = address_space_translate(tag_as, tag_paddr, &xlat, NULL,
> +                                 tag_access == MMU_DATA_STORE, attrs);
> +
> +    /*
> +     * Note that @mr will never be NULL.  If there is nothing in the address
> +     * space at @tag_paddr, the translation will return the unallocated memory
> +     * region.  For our purposes, the result must be ram.
> +     */
> +    if (unlikely(!memory_region_is_ram(mr))) {
> +        /* ??? Failure is a board configuration error. */
> +        qemu_log_mask(LOG_UNIMP,
> +                      "Tag Memory @ 0x%" HWADDR_PRIx " not found for "
> +                      "Normal Memory @ 0x%" HWADDR_PRIx "\n",
> +                      tag_paddr, ptr_paddr);
> +        return NULL;
> +    }
> +
> +    /*
> +     * Ensure the tag memory is dirty on write, for migration.
> +     * Tag memory can never contain code or display memory (vga).
> +     */
> +    if (tag_access == MMU_DATA_STORE) {
> +        ram_addr_t tag_ra = memory_region_get_ram_addr(mr) + xlat;
> +        cpu_physical_memory_set_dirty_flag(tag_ra, DIRTY_MEMORY_MIGRATION);
> +    }
> +
> +    return memory_region_get_ram_ptr(mr) + xlat;
> +#endif
> +}
> +
> +static inline int load_tag1(uint64_t ptr, uint8_t *mem)
> +{
> +    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
> +    return extract32(*mem, ofs, 4);
> +}
> +
> +/* For use in a non-parallel context, store to the given nibble.  */
> +static inline void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
> +{
> +    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
> +    *mem = deposit32(*mem, ofs, 4, tag);
> +}
> +
> +#endif /* TARGET_ARM_MTE_H */


