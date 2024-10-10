Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF73CED611
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 00:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sygs6-0002lm-7s; Wed, 09 Oct 2024 20:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sygs4-0002lc-M4
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:17:37 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sygs2-00035k-Qp
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:17:36 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20b7259be6fso3619595ad.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 17:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728519453; x=1729124253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q/OZN8WPRuoLeymGxNYqmJVZ6yHhXGR+yaxohnovVls=;
 b=ZNpeSWR0b85eHXONqJTop9hJePuV39PdGMkBPVDUzOdh7HNjeP9jDY3FCydvF9RLfl
 zp/v7MIb9607h0FkAT47YtUKkELvAHRYOJ2vlKgeoWlYZHdk/hVhEQT77WiDydMoQmhA
 HwWX0f6lR5KcQ6UiGdpFcmX1rTg1lKiMbsuK6e/DQ3q8hrCOOC8dPwiCxwu+mOZDHhFr
 8Wz7rQfLRIiC5pxLZlAxabr2fg6s1+FwrfELAobMJUChXavHPy/cUkwdpm8g+s5NfY30
 LFBLfCvIRwomSkmi6GJBLt6dx3np67neQ202faETHXeubfw7fD5y0wR9MYTnTIbDxK+U
 08Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728519453; x=1729124253;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/OZN8WPRuoLeymGxNYqmJVZ6yHhXGR+yaxohnovVls=;
 b=Elrc0mS4ASt5s1OYfL2S9m0RtI45wvW4tnFm1qZNhJ/LJ7USG06MjW7ro+bJi8qNkp
 7NJ9tAmJE8LjZd5M5GxRI0kc+8LpSnrvr/cL2Xh83Agnuyd6rrcMSwZZ1vqOa3kVIM3q
 yN7VdxAyWa4jO4cuWUXiL0RsyZIAxl1OPSqVlvf8zaZxsjupjAM5zq3OlWa7N8Et0njC
 Zy4ZFSPBVrCu14ikVsvm2wh/mtx/CWoMrD77cy6FXpXhDvq4JoCYGwHW3Uau96bK6xm3
 TYMDgxJx7ks4rsW6F9a5M6oKn55B8q1Wo66D693/wRwhk7ZfE8ZYWdr4604IMZvviu3G
 E2qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSNCn4Gv0i/8ggfIzGn4eZmyO0s4WLelXc3j6ZPzM8cv21RRuZd78zbWDWwqa3f5hw4QCCJBhajObw@nongnu.org
X-Gm-Message-State: AOJu0Yw7/cIDl3H04RuHiW29g56HelsjKWAIyLLSHgBGHbmzES3ZwTVH
 LYWMI7EmSNP3CyiFkIF2GyefzQkMbTfyC3xraTUDD4GuuyHOrdFW1Frp6q7GOBQ=
X-Google-Smtp-Source: AGHT+IHtkk03BAktf+DKCJ5Y+8tVg9ZoT/DDUGpLtD4UNmqySCO6dkdZ8EIeYqA/7hhMK2dCZKcVnA==
X-Received: by 2002:a17:903:244a:b0:20b:5046:354 with SMTP id
 d9443c01a7336-20c6378fc9bmr64911185ad.55.1728519452765; 
 Wed, 09 Oct 2024 17:17:32 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c0e74d6sm40915ad.166.2024.10.09.17.17.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 17:17:32 -0700 (PDT)
Message-ID: <cc635711-f20d-4e35-ad86-0db4ced104ef@linaro.org>
Date: Wed, 9 Oct 2024 17:17:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/23] include/exec/tlb-common: Move CPUTLBEntryFull from
 hw/core/cpu.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-17-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 10/9/24 08:08, Richard Henderson wrote:
> CPUTLBEntryFull structures are no longer directly included within
> the CPUState structure.  Move the structure definition out of cpu.h
> to reduce visibility.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/tlb-common.h | 63 +++++++++++++++++++++++++++++++++++++++
>   include/hw/core/cpu.h     | 63 ---------------------------------------
>   2 files changed, 63 insertions(+), 63 deletions(-)
> 
> diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
> index dc5a5faa0b..300f9fae67 100644
> --- a/include/exec/tlb-common.h
> +++ b/include/exec/tlb-common.h
> @@ -53,4 +53,67 @@ typedef struct CPUTLBDescFast {
>       CPUTLBEntry *table;
>   } CPUTLBDescFast QEMU_ALIGNED(2 * sizeof(void *));
>   
> +/*
> + * The full TLB entry, which is not accessed by generated TCG code,
> + * so the layout is not as critical as that of CPUTLBEntry. This is
> + * also why we don't want to combine the two structs.
> + */
> +struct CPUTLBEntryFull {
> +    /*
> +     * @xlat_section contains:
> +     *  - in the lower TARGET_PAGE_BITS, a physical section number
> +     *  - with the lower TARGET_PAGE_BITS masked off, an offset which
> +     *    must be added to the virtual address to obtain:
> +     *     + the ram_addr_t of the target RAM (if the physical section
> +     *       number is PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM)
> +     *     + the offset within the target MemoryRegion (otherwise)
> +     */
> +    hwaddr xlat_section;
> +
> +    /*
> +     * @phys_addr contains the physical address in the address space
> +     * given by cpu_asidx_from_attrs(cpu, @attrs).
> +     */
> +    hwaddr phys_addr;
> +
> +    /* @attrs contains the memory transaction attributes for the page. */
> +    MemTxAttrs attrs;
> +
> +    /* @prot contains the complete protections for the page. */
> +    uint8_t prot;
> +
> +    /* @lg_page_size contains the log2 of the page size. */
> +    uint8_t lg_page_size;
> +
> +    /* Additional tlb flags requested by tlb_fill. */
> +    uint8_t tlb_fill_flags;
> +
> +    /*
> +     * Additional tlb flags for use by the slow path. If non-zero,
> +     * the corresponding CPUTLBEntry comparator must have TLB_FORCE_SLOW.
> +     */
> +    uint8_t slow_flags[MMU_ACCESS_COUNT];
> +
> +    /*
> +     * Allow target-specific additions to this structure.
> +     * This may be used to cache items from the guest cpu
> +     * page tables for later use by the implementation.
> +     */
> +    union {
> +        /*
> +         * Cache the attrs and shareability fields from the page table entry.
> +         *
> +         * For ARMMMUIdx_Stage2*, pte_attrs is the S2 descriptor bits [5:2].
> +         * Otherwise, pte_attrs is the same as the MAIR_EL1 8-bit format.
> +         * For shareability and guarded, as in the SH and GP fields respectively
> +         * of the VMSAv8-64 PTEs.
> +         */
> +        struct {
> +            uint8_t pte_attrs;
> +            uint8_t shareability;
> +            bool guarded;
> +        } arm;
> +    } extra;
> +};
> +
>   #endif /* EXEC_TLB_COMMON_H */
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 87b864f5c4..6b1c2bfadd 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -198,69 +198,6 @@ struct CPUClass {
>    */
>   #define NB_MMU_MODES 16
>   
> -/*
> - * The full TLB entry, which is not accessed by generated TCG code,
> - * so the layout is not as critical as that of CPUTLBEntry. This is
> - * also why we don't want to combine the two structs.
> - */
> -struct CPUTLBEntryFull {
> -    /*
> -     * @xlat_section contains:
> -     *  - in the lower TARGET_PAGE_BITS, a physical section number
> -     *  - with the lower TARGET_PAGE_BITS masked off, an offset which
> -     *    must be added to the virtual address to obtain:
> -     *     + the ram_addr_t of the target RAM (if the physical section
> -     *       number is PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM)
> -     *     + the offset within the target MemoryRegion (otherwise)
> -     */
> -    hwaddr xlat_section;
> -
> -    /*
> -     * @phys_addr contains the physical address in the address space
> -     * given by cpu_asidx_from_attrs(cpu, @attrs).
> -     */
> -    hwaddr phys_addr;
> -
> -    /* @attrs contains the memory transaction attributes for the page. */
> -    MemTxAttrs attrs;
> -
> -    /* @prot contains the complete protections for the page. */
> -    uint8_t prot;
> -
> -    /* @lg_page_size contains the log2 of the page size. */
> -    uint8_t lg_page_size;
> -
> -    /* Additional tlb flags requested by tlb_fill. */
> -    uint8_t tlb_fill_flags;
> -
> -    /*
> -     * Additional tlb flags for use by the slow path. If non-zero,
> -     * the corresponding CPUTLBEntry comparator must have TLB_FORCE_SLOW.
> -     */
> -    uint8_t slow_flags[MMU_ACCESS_COUNT];
> -
> -    /*
> -     * Allow target-specific additions to this structure.
> -     * This may be used to cache items from the guest cpu
> -     * page tables for later use by the implementation.
> -     */
> -    union {
> -        /*
> -         * Cache the attrs and shareability fields from the page table entry.
> -         *
> -         * For ARMMMUIdx_Stage2*, pte_attrs is the S2 descriptor bits [5:2].
> -         * Otherwise, pte_attrs is the same as the MAIR_EL1 8-bit format.
> -         * For shareability and guarded, as in the SH and GP fields respectively
> -         * of the VMSAv8-64 PTEs.
> -         */
> -        struct {
> -            uint8_t pte_attrs;
> -            uint8_t shareability;
> -            bool guarded;
> -        } arm;
> -    } extra;
> -};
> -
>   /*
>    * Data elements that are per MMU mode, minus the bits accessed by
>    * the TCG fast path.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

