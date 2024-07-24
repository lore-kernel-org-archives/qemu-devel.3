Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2E5C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 03:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWSkn-0005Iv-8T; Tue, 23 Jul 2024 23:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWSkl-0005IE-Ty
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 23:33:23 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWSkj-0003KW-T4
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 23:33:23 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3dab2bb288aso3459308b6e.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 20:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721791999; x=1722396799; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D1PGRn7lMb1NeIrC3MzsFfvMABnPG6v/ZPvg1Mv6iX4=;
 b=RUdYuEUTdaAMszznBu5eAUGjQi1haoVYGCY0TFkMRvGfTKK6Xlc8VWOFIouK/tRwUj
 91M6gqCuMs7/uqhBBRGC69Mqzsp1JNkY90zsk3PbXTP1mgP1rgSrKLjaLwmSxMDKmj5j
 6hs4CuckbTRjFwtB58V6N/uy52QlkxensT8M5B20t6m/EWik10ZuGU4nYlvtNgYW6u+r
 Wu2W7/1k1CLHqdotIAb5nRGPHiQWoR0sK160lvef0qqmCbeTgJC0FvpUPfiD8roPrhj0
 m0bUdlAIOSlFIOR3MI5Bb6Oq18bOxxNnrUoFwmXsAHoRs7sYrwKw7d16DNitSyF9oy+y
 Xxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721791999; x=1722396799;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D1PGRn7lMb1NeIrC3MzsFfvMABnPG6v/ZPvg1Mv6iX4=;
 b=AlrKPFpN/SAabD2tWv7W7BN0KiCs9JhO4jTrxG+BFUFuSp9I8+KhC0Yqk2gglUM+zX
 660V2imDWQ82BgOzqvRNvR8XEuYpn0dEWPc+vjsINYlZWD8eBHojbhnMcswTDMB0F/1s
 yQmEKcSibqnYGrThrY6FHVtmAGre+jqlRKhYftcFNIWM0MKhHMF4Sk18DZW4/9C/pNk+
 XHbSEtq4Boy9aO2nmyUvicYrY18kdidvJB6M+jgSOOgUi/C/dJPsOR2E5a88PerDfnRd
 d7llRACFwheFerkwb1zOVWm2szs73fZwjtPAdIe9yFSXY7UkFeSBwgXSF1N4AQoij10l
 hQYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI3bstQwebwPvXUbYMi8BbILp7F9FtI+jFwtWPk6WKpb5zhqDf2B8NQ956fFq1xkL+FyN4U13a5412eAXhhwDgXgxA+As=
X-Gm-Message-State: AOJu0Yy4nRXqv9nEmihbBBQ2K49se74gVi8YVA91mX5DK1EuHypIenEO
 B2OjDJE4xWNmQ5SeHeTE8Gk/TlZuv2of8okTXBPV2Vwbl3FuZbvulNSJkoA6DPM=
X-Google-Smtp-Source: AGHT+IEyTMQhiHPJzQzZza+tq+iuv7FSy3HPHoL8KfzUVDvtva0XcIuaLl8ruvRYIkyAyvBv+9S6gg==
X-Received: by 2002:a05:6870:169e:b0:261:1339:1cb8 with SMTP id
 586e51a60fabf-263ab5f1a6cmr10700597fac.35.1721791999279; 
 Tue, 23 Jul 2024 20:33:19 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d16cc50d7sm5407371b3a.202.2024.07.23.20.33.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 20:33:18 -0700 (PDT)
Message-ID: <d3316e48-e601-4a43-b77e-2bf127d91a7a@linaro.org>
Date: Wed, 24 Jul 2024 13:33:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] Add an "info pg" command that prints the current
 page tables
To: Don Porter <porter@cs.unc.edu>, qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 philmd@linaro.org, berrange@redhat.com
References: <20240723010545.3648706-1-porter@cs.unc.edu>
 <20240723010545.3648706-4-porter@cs.unc.edu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240723010545.3648706-4-porter@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

On 7/23/24 11:05, Don Porter wrote:
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index d946161717..c70d31433d 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -605,10 +605,11 @@ extern bool mttcg_enabled;
>   /**
>    * cpu_paging_enabled:
>    * @cpu: The CPU whose state is to be inspected.
> + * @mmu_idx: 0 == traditional paging, 1 == nested paging
>    *
>    * Returns: %true if paging is enabled, %false otherwise.
>    */
> -bool cpu_paging_enabled(const CPUState *cpu);
> +bool cpu_paging_enabled(const CPUState *cpu, int mmu_idx);

mmu_idx already means something very different to TCG.
You will only confuse matters by using this name for a different concept here.


> @@ -671,9 +672,82 @@ int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
>    * Caller is responsible for freeing the data.
>    */
>   GuestPanicInformation *cpu_get_crash_info(CPUState *cpu);
> -
>   #endif /* !CONFIG_USER_ONLY */
>   
> +/* Maximum supported page table height - currently x86 at 5 */
> +#define MAX_HEIGHT 5
> +
> +typedef struct PageTableLayout {
> +    int height; /* Height of the page table */
> +    int entries_per_node[MAX_HEIGHT + 1];
> +} PageTableLayout;
> +
> +typedef struct DecodedPTE {
> +    int prot; /* Always populated, arch-specific, decoded flags */
> +    bool present;
> +    bool leaf; /* Only valid if present */
> +    bool reserved_bits_ok;
> +    bool user_read_ok;
> +    bool user_write_ok;
> +    bool user_exec_ok;
> +    bool super_read_ok;
> +    bool super_write_ok;
> +    bool super_exec_ok;
> +    bool dirty;
> +    hwaddr child; /* Only valid if present and !leaf */
> +    uint64_t leaf_page_size; /* Only valid if present and leaf */
> +    uint64_t nested_page_size; /*
> +                                * If nested paging, the page size of the host
> +                                * page storing the data, versus the size of the
> +                                * guest page frame in leaf_page_size
> +                                */
> +    vaddr bits_translated; /*
> +                            * The virtual address bits translated in walking
> +                            * the page table to node[i].
> +                            */
> +    hwaddr pte_addr; /* (guest) physical address of the PTE */
> +    hwaddr pte_host_addr; /* (host) physical address of the PTE */
> +    uint64_t pte_contents; /* Raw contents of the pte */
> +} DecodedPTE;
> +
> +typedef int (*qemu_page_walker_for_each)(CPUState *cs, void *data,
> +                                         DecodedPTE *pte,
> +                                         int height, int offset, int mmu_idx,
> +                                         const PageTableLayout *layout);
> +
> +/**
> + * for_each_pte - iterate over a page table, and
> + *                call fn on each entry
> + *
> + * @cs - CPU state
> + * @fn(cs, data, pte, height, offset, layout) - User-provided function to call
> + *                                              on each pte.
> + *   * @cs - pass through cs
> + *   * @data - user-provided, opaque pointer
> + *   * @pte - current pte, decoded
> + *   * @height - height in the tree of pte
> + *   * @offset - offset within the page tabe node
> + *   * @layout - pointer to a PageTableLayout for this tree
> + * @data - opaque pointer; passed through to fn
> + * @visit_interior_nodes - if true, call fn() on interior entries in
> + *                         page table; if false, visit only leaf entries.
> + * @visit_not_present - if true, call fn() on entries that are not present.
> + *                         if false, visit only present entries.
> + * @mmu_idx - Which level of the mmu we are interested in:
> + *            0 == user mode, 1 == nested page table
> + *            Note that MMU_*_IDX macros are not consistent across
> + *            architectures.
> + *
> + * Returns true on success, false on error.
> + *
> + * We assume all callers of this function are in debug mode, and do not
> + * want to synthesize, say, a user-mode load, on each page in the address
> + * space.
> + */
> +bool for_each_pte(CPUState *cs, qemu_page_walker_for_each fn, void *data,
> +                  bool visit_interior_nodes, bool visit_not_present,
> +                  bool visit_malformed, int mmu_idx);
> +

None of this should be in hw/core/cpu.h.
Isolate it somewhere else, not included by 80% of QEMU.


> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
> index 4c94e51267..d0e939def8 100644
> --- a/include/hw/core/sysemu-cpu-ops.h
> +++ b/include/hw/core/sysemu-cpu-ops.h
> @@ -12,6 +12,43 @@
>   
>   #include "hw/core/cpu.h"
>   
> +/*
> + * struct mem_print_state: Used by qmp in walking page tables.
> + */
> +struct mem_print_state {
> +    GString *buf;
> +    CPUArchState *env;
> +    int vaw, paw; /* VA and PA width in characters */
> +    int max_height;
> +    int mmu_idx; /* 0 == user mode, 1 == nested page table */
> +    bool (*flusher)(CPUState *cs, struct mem_print_state *state);
> +    bool flush_interior; /* If false, only call flusher() on leaves */
> +    bool require_physical_contiguity;
> +    /*
> +     * The height at which we started accumulating ranges, i.e., the
> +     * next height we need to print once we hit the end of a
> +     * contiguous range.
> +     */
> +    int start_height;
> +    int leaf_height; /* The height at which we found a leaf, or -1 */
> +    /*
> +     * For compressing contiguous ranges, track the
> +     * start and end of the range
> +     */
> +    hwaddr vstart[MAX_HEIGHT + 1]; /* Starting virt. addr. of open pte range */
> +    hwaddr vend[MAX_HEIGHT + 1]; /* Ending virtual address of open pte range */
> +    hwaddr pstart; /* Starting physical address of open pte range */
> +    hwaddr pend; /* Ending physical address of open pte range */
> +
> +    /* PTE protection flags current root->leaf path */
> +    uint64_t prot[MAX_HEIGHT + 1];
> +
> +    /* Page size (leaf) or address range covered (non-leaf). */
> +    uint64_t pg_size[MAX_HEIGHT + 1];
> +    int offset[MAX_HEIGHT + 1]; /* PTE range starting offsets */
> +    int last_offset[MAX_HEIGHT + 1]; /* PTE range ending offsets */
> +};

Likewise.
Also, CamelCase for typedefs, per coding style.


> +    if (env->hflags & HF_GUEST_MASK) {
> +
> +        /* Extract the EPTP value from vmcs12 structure, store in arch state */
> +        if (env->nested_state->format == KVM_STATE_NESTED_FORMAT_VMX) {
> +            struct vmcs12 *vmcs =
> +                (struct vmcs12 *) env->nested_state->data.vmx->vmcs12;

This is not required.  You appear to be confused by nested paging.

First: nested paging is how hardware virtualization works.  When we are *using* hardware 
virtualization, all of that is the kernel's job.  Our job as hypervisor is to give a bag 
of pages to the kernel and have it map them into the guest intermediate address space.

When we are *using* hardware virtualization, we are only ever concerned with one level of 
paging: from the guest to the intermediate address space.  From there we use QEMU data 
structures to map to QEMU virtual address space (address_space_ld/st, etc).

This is all we will ever see from KVM, HVF etc.

With TCG, we can *emulate* hardware virtualization.  It is at this point where we are 
concerned about two levels of paging, because QEMU is handling both.


r~

