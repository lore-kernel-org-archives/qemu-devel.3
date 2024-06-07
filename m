Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECDEC27C53
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 00:08:20 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFctv-0004mF-7h; Fri, 07 Jun 2024 12:57:15 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFcts-0004Xw-Sd
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 12:57:12 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFctq-0002cK-Qd
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 12:57:12 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7024791a950so2356909b3a.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717779429; x=1718384229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vr1wyaRHRa+pQqueQlxbteuISAmF54rl+yNLCV4juxg=;
 b=ws2ftKJwAZ4pW4pUH64uS/TWrYd6VlvGq0yMXF//lEFqZ+NrU5ED5GWvdAh2cORHTd
 mM0eNGRxt2z3b61BtAul47IGZ+2TTdo6Dq5GhRuR0ACaoBCYdZd2xLbM+Hv0twzs7jKM
 I/7FMy3D/791CVLMGKYhZ68IHG2EJV9pvgloCpFQh3ggnog2csiq42rzbtdSRuLRoP+b
 VdwkBMEjK4PrtGf1fx+D+AnwZJlmqyXWzdZRKfXvnaupFR2ynVP8PsF48VXSAFzU001f
 7ic5xekzD2BBp3insgMJHGPz5/miVWo+unZehEbbtD666HSbS+JGtlwkYnUEOTUrkJNH
 FhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717779429; x=1718384229;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vr1wyaRHRa+pQqueQlxbteuISAmF54rl+yNLCV4juxg=;
 b=O2smasFnmSRam+AaKw2sxnSLWuepF1o/2dm5Pya3Xossb8H5ji3yactMpi8h6SYykV
 zNY7WZbHhqfEKjonvyRUh2bQTFJqEeIydInu2xpFuEg88ManSJBqJv5cGwNZrJQyDLm8
 1hotAzmBfnjZOKBTvWH6dNItxDbqxyHbkelhCz/9aER2KMqi0LCXW+B4Fzc8tPwJPoUp
 +WCJ95E215R2tr+Q6q2jnO7Xvk4ScBvdytXZMMparb/5Y1clDchUVhS4Sw6ca+Pz/Rsy
 Tcc6fKWMpGksgDCHyjS38a3yOgtz+I0mZdYkv8v0Feb+2/keSFJrqXDBNOnxJm240dUP
 2yAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1dqEVIjuBq3z7Dz4nLtuqtIZiom5NRLwmeOUe+HTuNOK3eXxATs+n56CFbUkQm5VBlaiTy2usEcYaoRngkbt+Eqq/HE4=
X-Gm-Message-State: AOJu0YwJQafcwY+gCkGMAnmPxb1iefTeDe0NORVgXruoGzU0OfgWfkEF
 Fs8jMp9tKD67ngTftAuq729KtBOkOZCgQd1lCFDQ4S1tin/5Q1V6uXKa01XE7GE=
X-Google-Smtp-Source: AGHT+IE9sLg+dUHVVkto6gpHazUzQX91vovt1KZIqBTyNZAdLBkSbGEpE5OWZ5iSzd5HnDzZJozMPw==
X-Received: by 2002:a05:6a21:150a:b0:1b2:c28b:5799 with SMTP id
 adf61e73a8af0-1b2e77cfe68mr4423264637.19.1717779428844; 
 Fri, 07 Jun 2024 09:57:08 -0700 (PDT)
Received: from [192.168.223.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd4d9d8fsm2880570b3a.149.2024.06.07.09.57.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 09:57:08 -0700 (PDT)
Message-ID: <101886bb-12f2-43f9-8a7b-d2bf8e8f596c@linaro.org>
Date: Fri, 7 Jun 2024 09:57:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] Add an "info pg" command that prints the current
 page tables
To: Don Porter <porter@cs.unc.edu>, qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 philmd@linaro.org
References: <20240606140253.2277760-1-porter@cs.unc.edu>
 <20240606140253.2277760-2-porter@cs.unc.edu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240606140253.2277760-2-porter@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 6/6/24 07:02, Don Porter wrote:
> +/**
> + * _for_each_pte - recursive helper function
> + *
> + * @cs - CPU state
> + * @fn(cs, data, pte, vaddr, height) - User-provided function to call on each
> + *                                     pte.
> + *   * @cs - pass through cs
> + *   * @data - user-provided, opaque pointer
> + *   * @pte - current pte
> + *   * @vaddr_in - virtual address translated by pte
> + *   * @height - height in the tree of pte
> + * @data - user-provided, opaque pointer, passed to fn()
> + * @visit_interior_nodes - if true, call fn() on page table entries in
> + *                         interior nodes.  If false, only call fn() on page
> + *                         table entries in leaves.
> + * @visit_not_present - if true, call fn() on entries that are not present.
> + *                         if false, visit only present entries.
> + * @node - The physical address of the current page table radix tree node
> + * @vaddr_in - The virtual address bits translated in walking the page
> + *          table to node
> + * @height - The height of node in the radix tree
> + *
> + * height starts at the max and counts down.
> + * In a 4 level x86 page table, pml4e is level 4, pdpe is level 3,
> + *  pde is level 2, and pte is level 1
> + *
> + * Returns true on success, false on error.
> + */
> +static bool
> +_for_each_pte(CPUState *cs,

External identifiers beginning with "_[a-z]" are reserved.  While this is not external, 
and so is technically ok, it is still not a great idea.  Use for_each_pte_$SUFFIX, with 
SUFFIX as int, internal, recurse or something.


> +              int (*fn)(CPUState *cs, void *data, PTE_t *pte,
> +                        vaddr vaddr_in, int height, int offset),
> +              void *data, bool visit_interior_nodes,
> +              bool visit_not_present, hwaddr node,
> +              vaddr vaddr_in, int height)
> +{
> +    int ptes_per_node;
> +    int i;
> +
> +    assert(height > 0);
> +
> +    CPUClass *cc = CPU_GET_CLASS(cs);
> +
> +    if ((!cc->sysemu_ops->page_table_entries_per_node)
> +        || (!cc->sysemu_ops->get_pte)
> +        || (!cc->sysemu_ops->pte_present)
> +        || (!cc->sysemu_ops->pte_leaf)
> +        || (!cc->sysemu_ops->pte_child)) {
> +        return false;
> +    }

Probably move this check to the non-recursive function, since it only needs to be done 
once.  Following a check for page_table_root, should the rest be asserts?  I.e. if a 
target implements one hook, it must implement them all?

CPU_GET_CLASS is non-trivial: it is cached in cs->cc.
It seems like you should cache cs->cc->sysemu_ops in a local to avoid constantly reloading 
the pointer across the loop.

> +    ptes_per_node = cc->sysemu_ops->page_table_entries_per_node(cs, height);

It would be better if the entire page table format were computed by page_table_root. 
Perhaps fill in a whole structure rather than just height.

> +    for (i = 0; i < ptes_per_node; i++) {
> +        PTE_t pt_entry;
> +        vaddr vaddr_i;
> +        bool pte_present;
> +
> +        cc->sysemu_ops->get_pte(cs, node, i, height, &pt_entry, vaddr_in,
> +                                &vaddr_i, NULL);
> +        pte_present = cc->sysemu_ops->pte_present(cs, &pt_entry);
> +
> +        if (pte_present || visit_not_present) {
> +            if ((!pte_present) || cc->sysemu_ops->pte_leaf(cs, height,
> +                                                           &pt_entry)) {

Again, better to fill in a structure in get_pte rather than make 4 calls for vaddr, 
present, leaf, child.

Drop the unnecessary (), e.g. around !pte_present.

> +/* Intended to become a generic PTE type */
> +typedef union PTE {
> +    uint64_t pte64_t;
> +    uint32_t pte32_t;
> +} PTE_t;

While not yet supported by qemu, the latest Arm v9.4 document contains a 128-bit PTE.
Don't give the tag and the typedef different names.
Avoid "_t" as that's POSIX reserved namespace.

I know naming is hard, but there are many kinds of PTE in qemu -- better to use something 
more descriptive.  Perhaps "QemuPageWalkerPTE"?

> +bool for_each_pte(CPUState *cs,
> +                  int (*fn)(CPUState *cs, void *data, PTE_t *pte, vaddr vaddr,
> +                            int height, int offset), void *data,
> +                  bool visit_interior_nodes, bool visit_not_present);

Use a typedef for the callback function.
qemu_page_walker_for_each?

> +
> +
>   /**
>    * CPUDumpFlags:
>    * @CPU_DUMP_CODE:
> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
> index 24d003fe04..eb16a1c3e2 100644
> --- a/include/hw/core/sysemu-cpu-ops.h
> +++ b/include/hw/core/sysemu-cpu-ops.h
> @@ -12,6 +12,39 @@
>   
>   #include "hw/core/cpu.h"
>   
> +/* Maximum supported page table height - currently x86 at 5 */
> +#define MAX_HEIGHT 5
> +
> +/*
> + * struct mem_print_state: Used by monitor in walking page tables.
> + */
> +struct mem_print_state {
> +    Monitor *mon;
> +    CPUArchState *env;
> +    int vaw, paw; /* VA and PA width in characters */
> +    int max_height;
> +    bool (*flusher)(CPUState *cs, struct mem_print_state *state);
> +    bool flush_interior; /* If false, only call flusher() on leaves */
> +    bool require_physical_contiguity;
> +    /*
> +     * The height at which we started accumulating ranges, i.e., the
> +     * next height we need to print once we hit the end of a
> +     * contiguous range.
> +     */
> +    int start_height;
> +    /*
> +     * For compressing contiguous ranges, track the
> +     * start and end of the range
> +     */
> +    hwaddr vstart[MAX_HEIGHT + 1]; /* Starting virt. addr. of open pte range */
> +    hwaddr vend[MAX_HEIGHT + 1]; /* Ending virtual address of open pte range */
> +    hwaddr pstart; /* Starting physical address of open pte range */
> +    hwaddr pend; /* Ending physical address of open pte range */
> +    int64_t ent[MAX_HEIGHT + 1]; /* PTE contents on current root->leaf path */

PTE_t (or the rename)?

> +    int offset[MAX_HEIGHT + 1]; /* PTE range starting offsets */
> +    int last_offset[MAX_HEIGHT + 1]; /* PTE range ending offsets */
> +};
> +
>   /*
>    * struct SysemuCPUOps: System operations specific to a CPU class
>    */
> @@ -87,6 +120,129 @@ typedef struct SysemuCPUOps {
>        */
>       const VMStateDescription *legacy_vmsd;
>   
> +    /**
> +     * page_table_root - Given a CPUState, return the physical address
> +     *                    of the current page table root, as well as
> +     *                    write the height of the tree into *height.
> +     *
> +     * @cs - CPU state
> +
> +     * @height - a pointer to an integer, to store the page table tree
> +     *           height
> +     *
> +     * Returns a hardware address on success.  Should not fail (i.e.,
> +     * caller is responsible to ensure that a page table is actually
> +     * present).
> +     */
> +    hwaddr (*page_table_root)(CPUState *cs, int *height);

There may be two page table roots on Arm, depending on the cpu state and the virtual 
address.  The shape of the two page tables are independent so...


> +
> +    /**
> +     * page_table_entries_per_node - Return the number of entries in a
> +     *                                   page table node for the CPU
> +     *                                   at a given height.
> +     *
> +     * @cs - CPU state
> +     * @height - height of the page table tree to query, where the leaves
> +     *          are 1.
> +     *
> +     * Returns a value greater than zero on success, -1 on error.
> +     */
> +    int (*page_table_entries_per_node)(CPUState *cs, int height);

... implementing this independently from page_table_root is not possible.


> +
> +    /**
> +     * @mon_init_page_table_iterator: Callback to configure a page table
> +     * iterator for use by a monitor function.
> +     * Returns true on success, false if not supported (e.g., no paging disabled
> +     * or not implemented on this CPU).
> +     */
> +    bool (*mon_init_page_table_iterator)(Monitor *mon,
> +                                         struct mem_print_state *state);

I don't understand the purpose of this one as a target-specific hook.

> +    /**
> +     * @flush_page_table_iterator_state: Prints the last entry,
> +     * if one is present.  Useful for iterators that aggregate information
> +     * across page table entries.
> +     */
> +    bool (*mon_flush_page_print_state)(CPUState *cs,
> +                                       struct mem_print_state *state);

Is this specific to "info pg" or not?
It appears to be, but the description suggests it is not.


r~

