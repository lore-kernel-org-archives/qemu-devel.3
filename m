Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D70C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 06:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFSms-0001Ur-61; Fri, 07 Jun 2024 02:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFSmp-0001UP-T1
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 02:09:15 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFSml-00057Y-7T
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 02:09:15 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57a32b0211aso2247547a12.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 23:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717740549; x=1718345349; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+LC7ZGcOrbKrZAId0euPnZ5ozpHloShdSyALAb0478Q=;
 b=QcRgmzDXG01Tl5M7pLgPu4oith3rW3viI/BDlffY8dou1+4pI2q7ASfo7EUlignLZt
 i5uaXulcoV4bB+gzCWzRgzTgUuWbtYxh0cUv+kZVxjbArYY+3S/lyz9cMW/d1loNaTfz
 UP5KI/uBrW5e1nyrPSoll8tFhrHaM36KXRAV9KxHoNUwWvrRTXE+nQJjUhZ2e6Di0SCT
 T6J+QGJ43zTvbr0l6PsvFudKDdVq2ibns059YxYr7j/WHLo/uvYueOXxQNrzgO7byfpo
 XlCcQtvgIN026GCNZ/yiB8oMDmx4Rar3JDDr9vNX5xSeBTgMRPBLSi+eaDgMdoHc39Yv
 Frfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717740549; x=1718345349;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+LC7ZGcOrbKrZAId0euPnZ5ozpHloShdSyALAb0478Q=;
 b=P+3ShBUbaRjavnBNgAa6wqRnRT6GXM/Yr0FPmGVH8oUS+yvJI3X58pifIId/O0iS0w
 geJ0XuaqTc5TN/7qDUhpgElnrkcX3TlZFIotLbUPUlzdqC/2uikitS1RQinEJkHZnblP
 gITmXTVV2J4vT6B+fBKHIjrvR1gAWrEx66yFLACHx0HHSkD6FVDTZuioW8i3O67QS1U3
 Jsnm0EcQPw010NNj68TE/cM+fs1lfKuFdBP+WIGNPskab5ZsFUvOYpYwmIt2v9a2b+M9
 7uQX1dK27gZdNpoCs5BDCgt1VKPw+TK4T6hmM1h+GTHAhqg46vIBgaMHv9l6WHfCZ/VX
 ukMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl0ZXDL8/ekIyGgVJbiYJDRIKw+7kRM9yJGHIVMSMTWSh7ehXcPwPUORgKEa3JNbT0HtSHvMbpRuK6uFM8Y5koLPbsgXE=
X-Gm-Message-State: AOJu0YwlQbjWWxwvMNZ7XzA9NMRQ8fkVMqO3GHB8jDiFe+7C19YCafMC
 wOB/x/3Lj+DFhLl/IiNTS2KzD/3nCcMb1gAQG5B2+tOYobvA3bu/fRxvbaCGUOyMGrLNNetya0+
 6uss=
X-Google-Smtp-Source: AGHT+IFpgRCaAF1Ya1UX4YEVhxSo8Xl34UvvfjwI4Bzid4rKzQwLULh0VvXxEj7CB6jPFW3wKtVj0A==
X-Received: by 2002:a17:906:48c7:b0:a6a:44d9:7d15 with SMTP id
 a640c23a62f3a-a6cdb203f7amr92273166b.58.1717740548683; 
 Thu, 06 Jun 2024 23:09:08 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.196.231])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805d0ba8sm193448966b.85.2024.06.06.23.09.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 23:09:08 -0700 (PDT)
Message-ID: <3ac73020-6313-4548-a470-524dfb7ffa34@linaro.org>
Date: Fri, 7 Jun 2024 08:09:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] Add an "info pg" command that prints the current
 page tables
To: Don Porter <porter@cs.unc.edu>, qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20240606140253.2277760-1-porter@cs.unc.edu>
 <20240606140253.2277760-2-porter@cs.unc.edu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240606140253.2277760-2-porter@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

On 6/6/24 16:02, Don Porter wrote:
> The new "info pg" monitor command prints the current page table,
> including virtual address ranges, flag bits, and snippets of physical
> page numbers.  Completely filled regions of the page table with
> compatible flags are "folded", with the result that the complete
> output for a freshly booted x86-64 Linux VM can fit in a single
> terminal window.  The output looks like this:
> 
> VPN range             Entry         Flags            Physical page
> [7f0000000-7f0000000] PML4[0fe]     ---DA--UWP
>    [7f28c0000-7f28fffff]  PDP[0a3]     ---DA--UWP
>      [7f28c4600-7f28c47ff]  PDE[023]     ---DA--UWP
>        [7f28c4655-7f28c4656]  PTE[055-056] X--D---U-P 0000007f14-0000007f15
>        [7f28c465b-7f28c465b]  PTE[05b]     ----A--U-P 0000001cfc
> ...
> [ff8000000-ff8000000] PML4[1ff]     ---DA--UWP
>    [ffff80000-ffffbffff]  PDP[1fe]     ---DA---WP
>      [ffff81000-ffff81dff]  PDE[008-00e] -GSDA---WP 0000001000-0000001dff
>    [ffffc0000-fffffffff]  PDP[1ff]     ---DA--UWP
>      [ffffff400-ffffff5ff]  PDE[1fa]     ---DA--UWP
>        [ffffff5fb-ffffff5fc]  PTE[1fb-1fc] XG-DACT-WP 00000fec00 00000fee00
>      [ffffff600-ffffff7ff]  PDE[1fb]     ---DA--UWP
>        [ffffff600-ffffff600]  PTE[000]     -G-DA--U-P 0000001467
> 
> This draws heavy inspiration from Austin Clements' original patch.
> 
> This also adds a generic page table walker, which other monitor
> and execution commands will be migrated to in subsequent patches.
> 
> Signed-off-by: Don Porter <porter@cs.unc.edu>
> ---
>   hmp-commands-info.hx              |  13 ++
>   hw/core/cpu-sysemu.c              | 140 ++++++++++++
>   include/hw/core/cpu.h             |  34 ++-
>   include/hw/core/sysemu-cpu-ops.h  | 156 +++++++++++++
>   include/monitor/hmp-target.h      |   1 +
>   monitor/hmp-cmds-target.c         | 198 +++++++++++++++++
>   target/i386/arch_memory_mapping.c | 351 +++++++++++++++++++++++++++++-
>   target/i386/cpu.c                 |  11 +
>   target/i386/cpu.h                 |  15 ++
>   target/i386/monitor.c             | 165 ++++++++++++++
>   10 files changed, 1082 insertions(+), 2 deletions(-)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 20a9835ea8..a873841920 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -242,6 +242,19 @@ SRST
>       Show memory tree.
>   ERST
>   
> +    {
> +        .name       = "pg",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "show the page table",
> +        .cmd        = hmp_info_pg,
> +    },
> +
> +SRST
> +  ``info pg``
> +    Show the active page table.
> +ERST
> +
>   #if defined(CONFIG_TCG)
>       {
>           .name       = "jit",
> diff --git a/hw/core/cpu-sysemu.c b/hw/core/cpu-sysemu.c
> index 2a9a2a4eb5..fd936fa90c 100644
> --- a/hw/core/cpu-sysemu.c
> +++ b/hw/core/cpu-sysemu.c
> @@ -142,3 +142,143 @@ GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
>       }
>       return res;
>   }
> +
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

Please avoid '_' prefix.

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

Since this function has local scope, it shouldn't be called with
any of these unset. If you are unsure, we can assert() on them.

> +    }
> +
> +    ptes_per_node = cc->sysemu_ops->page_table_entries_per_node(cs, height);
> +
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
> +                if (fn(cs, data, &pt_entry, vaddr_i, height, i)) {
> +                    /* Error */
> +                    return false;
> +                }
> +            } else { /* Non-leaf */
> +                if (visit_interior_nodes) {
> +                    if (fn(cs, data, &pt_entry, vaddr_i, height, i)) {
> +                        /* Error */
> +                        return false;
> +                    }
> +                }
> +                hwaddr child = cc->sysemu_ops->pte_child(cs, &pt_entry, height);
> +                assert(height > 1);
> +                if (!_for_each_pte(cs, fn, data, visit_interior_nodes,
> +                                   visit_not_present, child, vaddr_i,
> +                                   height - 1)) {
> +                    return false;
> +                }
> +            }
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +/**
> + * for_each_pte - iterate over a page table, and
> + *                call fn on each entry
> + *
> + * @cs - CPU state
> + * @fn(cs, data, pte, vaddr, height) - User-provided function to call on each
> + *                                     pte.
> + *   * @cs - pass through cs
> + *   * @data - user-provided, opaque pointer
> + *   * @pte - current pte
> + *   * @vaddr - virtual address translated by pte
> + *   * @height - height in the tree of pte
> + * @data - opaque pointer; passed through to fn
> + * @visit_interior_nodes - if true, call fn() on interior entries in
> + *                         page table; if false, visit only leaf entries.
> + * @visit_not_present - if true, call fn() on entries that are not present.
> + *                         if false, visit only present entries.
> + *
> + * Returns true on success, false on error.
> + *
> + */
> +bool for_each_pte(CPUState *cs,
> +                  int (*fn)(CPUState *cs, void *data, PTE_t *pte,
> +                            vaddr vaddr, int height, int offset),
> +                  void *data, bool visit_interior_nodes,
> +                  bool visit_not_present)
> +{
> +    int height;
> +    vaddr vaddr = 0;
> +    hwaddr root;
> +    CPUClass *cc = CPU_GET_CLASS(cs);
> +
> +    if (!cpu_paging_enabled(cs)) {
> +        /* paging is disabled */
> +        return true;
> +    }
> +
> +    if (!cc->sysemu_ops->page_table_root) {
> +        return false;
> +    }
> +
> +    root = cc->sysemu_ops->page_table_root(cs, &height);
> +
> +    assert(height > 1);
> +
> +    /* Recursively call a helper to walk the page table */
> +    return _for_each_pte(cs, fn, data, visit_interior_nodes, visit_not_present,
> +                         root, vaddr, height);
> +}
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index a2c8536943..00d7162795 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -671,9 +671,41 @@ int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
>    * Caller is responsible for freeing the data.
>    */
>   GuestPanicInformation *cpu_get_crash_info(CPUState *cpu);
> -
>   #endif /* !CONFIG_USER_ONLY */
>   
> +/* Intended to become a generic PTE type */
> +typedef union PTE {
> +    uint64_t pte64_t;
> +    uint32_t pte32_t;
> +} PTE_t;
> +
> +/**
> + * for_each_pte - iterate over a page table, and
> + *                call fn on each entry
> + *
> + * @cs - CPU state
> + * @fn(cs, data, pte, vaddr, height) - User-provided function to call on each
> + *                                     pte.
> + *   * @cs - pass through cs
> + *   * @data - user-provided, opaque pointer
> + *   * @pte - current pte
> + *   * @vaddr - virtual address translated by pte
> + *   * @height - height in the tree of pte
> + * @data - opaque pointer; passed through to fn
> + * @visit_interior_nodes - if true, call fn() on interior entries in
> + *                         page table; if false, visit only leaf entries.
> + * @visit_not_present - if true, call fn() on entries that are not present.
> + *                         if false, visit only present entries.
> + *
> + * Returns true on success, false on error.
> + *
> + */
> +bool for_each_pte(CPUState *cs,
> +                  int (*fn)(CPUState *cs, void *data, PTE_t *pte, vaddr vaddr,
> +                            int height, int offset), void *data,
> +                  bool visit_interior_nodes, bool visit_not_present);
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

I'd rather keep the monitor out of this state.

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
> +
> +    /**
> +     * get_pte - Copy the contents of the page table entry at node[i]
> +     *           into pt_entry.  Optionally, add the relevant bits to
> +     *           the virtual address in vaddr_pte.
> +     *
> +     * @cs - CPU state
> +     * @node - physical address of the current page table node
> +     * @i - index (in page table entries, not bytes) of the page table
> +     *      entry, within node
> +     * @height - height of node within the tree (leaves are 1, not 0)
> +     * @pt_entry - Pointer to a PTE_t, stores the contents of the page
> +     *             table entry
> +     * @vaddr_parent - The virtual address bits already translated in
> +     *                 walking the page table to node.  Optional: only
> +     *                 used if vaddr_pte is set.
> +     * @vaddr_pte - Optional pointer to a variable storing the virtual
> +     *              address bits translated by node[i].
> +     * @pte_paddr - Pointer to the physical address of the PTE within node.
> +     *              Optional parameter.
> +     */
> +
> +    void (*get_pte)(CPUState *cs, hwaddr node, int i, int height,
> +                    PTE_t *pt_entry, vaddr vaddr_parent, vaddr *vaddr_pte,
> +                    hwaddr *pte_paddr);
> +
> +    /**
> +     * pte_present - Return true if the pte is marked 'present'
> +     */
> +    bool (*pte_present)(CPUState *cs, PTE_t *pte);
> +
> +    /**
> +     * pte_leaf - Return true if the pte is a page table leaf, false
> +     *                if the pte points to another node in the radix
> +     *                tree.
> +     */
> +    bool (*pte_leaf)(CPUState *cs, int height, PTE_t *pte);
> +
> +    /**
> +     * pte_child - Returns the physical address of a radix tree node
> +     *                 pointed to by pte.
> +     *
> +     * @cs - CPU state
> +     * @pte - The page table entry
> +     * @height - The height in the tree of pte
> +     *
> +     * Returns the physical address stored in pte on success, -1 on
> +     * error.
> +     */
> +    hwaddr (*pte_child)(CPUState *cs, PTE_t *pte, int height);
> +
> +    /**
> +     * pte_leaf_page_size - Return the page size of a leaf entry,
> +     *                          given the height and CPU state
> +     *
> +     * @cs - CPU state
> +     * @height - height of the page table tree to query, where the leaves
> +     *          are 1.
> +     *
> +     * Returns a value greater than zero on success, -1 on error.
> +     */
> +    uint64_t (*pte_leaf_page_size)(CPUState *cs, int height);
> +
> +    /**
> +     * pte_flags - Return the flag bits of the page table entry.
> +     *
> +     * @pte - the contents of the PTE, not the address.
> +     *
> +     * Returns pte with the non-flag bits masked out.
> +     */
> +    uint64_t (*pte_flags)(uint64_t pte);
> +
> +    /**
> +     * @mon_init_page_table_iterator: Callback to configure a page table
> +     * iterator for use by a monitor function.
> +     * Returns true on success, false if not supported (e.g., no paging disabled
> +     * or not implemented on this CPU).
> +     */
> +    bool (*mon_init_page_table_iterator)(Monitor *mon,
> +                                         struct mem_print_state *state);

Here too, I'm reluctant to wire the monitor to this API.

If we want text, we should use HumanReadableText.

> +    /**
> +     * @mon_info_pg_print_header: Prints the header line for 'info pg'.
> +     */
> +    void (*mon_info_pg_print_header)(Monitor *mon,
> +                                     struct mem_print_state *state);
> +
> +    /**
> +     * @flush_page_table_iterator_state: Prints the last entry,
> +     * if one is present.  Useful for iterators that aggregate information
> +     * across page table entries.
> +     */
> +    bool (*mon_flush_page_print_state)(CPUState *cs,
> +                                       struct mem_print_state *state);
> +
>   } SysemuCPUOps;
>   
>   #endif /* SYSEMU_CPU_OPS_H */
> diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
> index b679aaebbf..9af72ea58d 100644
> --- a/include/monitor/hmp-target.h
> +++ b/include/monitor/hmp-target.h
> @@ -50,6 +50,7 @@ CPUState *mon_get_cpu(Monitor *mon);
>   void hmp_info_mem(Monitor *mon, const QDict *qdict);
>   void hmp_info_tlb(Monitor *mon, const QDict *qdict);
>   void hmp_mce(Monitor *mon, const QDict *qdict);
> +void hmp_info_pg(Monitor *mon, const QDict *qdict);
>   void hmp_info_local_apic(Monitor *mon, const QDict *qdict);
>   void hmp_info_sev(Monitor *mon, const QDict *qdict);
>   void hmp_info_sgx(Monitor *mon, const QDict *qdict);
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index ff01cf9d8d..60a8bd0c37 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -31,6 +31,7 @@
>   #include "qapi/error.h"
>   #include "qapi/qmp/qdict.h"
>   #include "sysemu/hw_accel.h"
> +#include "hw/core/sysemu-cpu-ops.h"
>   
>   /* Set the current CPU defined by the user. Callers must hold BQL. */
>   int monitor_set_cpu(Monitor *mon, int cpu_index)
> @@ -120,6 +121,203 @@ void hmp_info_registers(Monitor *mon, const QDict *qdict)
>       }
>   }
>   
> +/* Assume only called on present entries */
> +static
> +int compressing_iterator(CPUState *cs, void *data, PTE_t *pte,
> +                         vaddr vaddr_in, int height, int offset)
> +{
> +    CPUClass *cc = CPU_GET_CLASS(cs);
> +    struct mem_print_state *state = (struct mem_print_state *) data;
> +    hwaddr paddr = cc->sysemu_ops->pte_child(cs, pte, height);
> +    target_ulong size = cc->sysemu_ops->pte_leaf_page_size(cs, height);
> +    bool start_new_run = false, flush = false;
> +    bool is_leaf = cc->sysemu_ops->pte_leaf(cs, height, pte);
> +
> +    int entries_per_node = cc->sysemu_ops->page_table_entries_per_node(cs,
> +                                                                       height);
> +
> +    /* Prot of current pte */
> +    int prot = cc->sysemu_ops->pte_flags(pte->pte64_t);
> +
> +    /* If there is a prior run, first try to extend it. */
> +    if (state->start_height != 0) {
> +
> +        /*
> +         * If we aren't flushing interior nodes, raise the start height.
> +         * We don't need to detect non-compressible interior nodes.
> +         */
> +        if ((!state->flush_interior) && state->start_height < height) {
> +            state->start_height = height;
> +            state->vstart[height] = vaddr_in;
> +            state->vend[height] = vaddr_in;
> +            state->ent[height] = pte->pte64_t;
> +            if (offset == 0) {
> +                state->last_offset[height] = entries_per_node - 1;
> +            } else {
> +                state->last_offset[height] = offset - 1;
> +            }
> +        }
> +
> +        /* Detect when we are walking down the "left edge" of a range */
> +        if (state->vstart[height] == -1
> +            && (height + 1) <= state->start_height
> +            && state->vstart[height + 1] == vaddr_in) {
> +
> +            state->vstart[height] = vaddr_in;
> +            state->vend[height] = vaddr_in;
> +            state->ent[height] = pte->pte64_t;
> +            state->offset[height] = offset;
> +            state->last_offset[height] = offset;
> +
> +            if (is_leaf) {
> +                state->pstart = paddr;
> +                state->pend = paddr;
> +            }
> +
> +            /* Detect contiguous entries at same level */
> +        } else if ((state->vstart[height] != -1)
> +                   && (state->start_height >= height)
> +                   && cc->sysemu_ops->pte_flags(state->ent[height]) == prot
> +                   && (((state->last_offset[height] + 1) % entries_per_node)
> +                       == offset)
> +                   && ((!is_leaf)
> +                       || (!state->require_physical_contiguity)
> +                       || (state->pend + size == paddr))) {
> +
> +
> +            /*
> +             * If there are entries at the levels below, make sure we
> +             * completed them.  We only compress interior nodes
> +             * without holes in the mappings.
> +             */
> +            if (height != 1) {
> +                for (int i = height - 1; i >= 1; i--) {
> +                    int entries = cc->sysemu_ops->page_table_entries_per_node(
> +                        cs, i);
> +
> +                    /* Stop if we hit large pages before level 1 */
> +                    if (state->vstart[i] == -1) {
> +                        break;
> +                    }
> +
> +                    if ((state->last_offset[i] + 1) != entries) {
> +                        flush = true;
> +                        start_new_run = true;
> +                        break;
> +                    }
> +                }
> +            }
> +
> +
> +            if (!flush) {
> +
> +                /* We can compress these entries */
> +                state->ent[height] = pte->pte64_t;
> +                state->vend[height] = vaddr_in;
> +                state->last_offset[height] = offset;
> +
> +                /* Only update the physical range on leaves */
> +                if (is_leaf) {
> +                    state->pend = paddr;
> +                }
> +            }
> +            /* Let PTEs accumulate... */
> +        } else {
> +            flush = true;
> +        }
> +
> +        if (flush) {
> +            /*
> +             * We hit dicontiguous permissions or pages.
> +             * Print the old entries, then start accumulating again
> +             *
> +             * Some clients only want the flusher called on a leaf.
> +             * Check that too.
> +             *
> +             * We can infer whether the accumulated range includes a
> +             * leaf based on whether pstart is -1.
> +             */
> +            if (state->flush_interior || (state->pstart != -1)) {
> +                if (state->flusher(cs, state)) {
> +                    start_new_run = true;
> +                }
> +            } else {
> +                start_new_run = true;
> +            }
> +        }
> +    } else {
> +        start_new_run = true;
> +    }
> +
> +    if (start_new_run) {
> +        /* start a new run with this PTE */
> +        for (int i = state->start_height; i > 0; i--) {
> +            if (state->vstart[i] != -1) {
> +                state->ent[i] = 0;
> +                state->last_offset[i] = 0;
> +                state->vstart[i] = -1;
> +            }
> +        }
> +        state->pstart = -1;
> +        state->vstart[height] = vaddr_in;
> +        state->vend[height] = vaddr_in;
> +        state->ent[height] = pte->pte64_t;
> +        state->offset[height] = offset;
> +        state->last_offset[height] = offset;
> +        if (is_leaf) {
> +            state->pstart = paddr;
> +            state->pend = paddr;
> +        }
> +        state->start_height = height;
> +    }
> +
> +    return 0;
> +}
> +
> +void hmp_info_pg(Monitor *mon, const QDict *qdict)
> +{
> +    struct mem_print_state state;
> +
> +    CPUState *cs = mon_get_cpu(mon);
> +    if (!cs) {
> +        monitor_printf(mon, "Unable to get CPUState.  Internal error\n");
> +        return;
> +    }
> +
> +    CPUClass *cc = CPU_GET_CLASS(cs);
> +
> +    if ((!cc->sysemu_ops->pte_child)
> +        || (!cc->sysemu_ops->pte_leaf)
> +        || (!cc->sysemu_ops->pte_leaf_page_size)
> +        || (!cc->sysemu_ops->page_table_entries_per_node)
> +        || (!cc->sysemu_ops->pte_flags)
> +        || (!cc->sysemu_ops->mon_init_page_table_iterator)
> +        || (!cc->sysemu_ops->mon_info_pg_print_header)
> +        || (!cc->sysemu_ops->mon_flush_page_print_state)) {
> +        monitor_printf(mon, "Info pg unsupported on this ISA\n");
> +        return;
> +    }
> +
> +    if (!cc->sysemu_ops->mon_init_page_table_iterator(mon, &state)) {
> +        monitor_printf(mon, "Unable to initialize page table iterator\n");
> +        return;
> +    }
> +
> +    state.flush_interior = true;
> +    state.require_physical_contiguity = true;
> +    state.flusher = cc->sysemu_ops->mon_flush_page_print_state;
> +
> +    cc->sysemu_ops->mon_info_pg_print_header(mon, &state);
> +
> +    /*
> +     * We must visit interior entries to get the hierarchy, but
> +     * can skip not present mappings
> +     */
> +    for_each_pte(cs, &compressing_iterator, &state, true, false);
> +
> +    /* Print last entry, if one present */
> +    cc->sysemu_ops->mon_flush_page_print_state(cs, &state);
> +}
>   static void memory_dump(Monitor *mon, int count, int format, int wsize,
>                           hwaddr addr, int is_physical)
>   {
> diff --git a/target/i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
> index d1ff659128..562a00b5a7 100644
> --- a/target/i386/arch_memory_mapping.c
> +++ b/target/i386/arch_memory_mapping.c
> @@ -15,6 +15,356 @@
>   #include "cpu.h"
>   #include "sysemu/memory_mapping.h"
>   
> +/**
> + ************** code hook implementations for x86 ***********
> + */
> +
> +#define PML4_ADDR_MASK 0xffffffffff000ULL /* selects bits 51:12 */
> +
> +/**
> + * x86_page_table_root - Given a CPUState, return the physical address
> + *                       of the current page table root, as well as
> + *                       write the height of the tree into *height.
> + *
> + * @cs - CPU state
> + * @height - a pointer to an integer, to store the page table tree height
> + *
> + * Returns a hardware address on success.  Should not fail (i.e., caller is
> + * responsible to ensure that a page table is actually present).
> + */
> +hwaddr x86_page_table_root(CPUState *cs, int *height)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +    /*
> +     * DEP 5/15/24: Some original page table walking code sets the a20
> +     * mask as a 32 bit integer and checks it on each level of hte
> +     * page table walk; some only checks it against the final result.
> +     * For 64 bits, I think we need to sign extend in the common case
> +     * it is not set (and returns -1), or we will lose bits.
> +     */
> +    int64_t a20_mask;
> +
> +    assert(cpu_paging_enabled(cs));
> +    a20_mask = x86_get_a20_mask(env);
> +
> +    if (env->cr[4] & CR4_PAE_MASK) {
> +#ifdef TARGET_X86_64
> +        if (env->hflags & HF_LMA_MASK) {
> +            if (env->cr[4] & CR4_LA57_MASK) {
> +                *height = 5;
> +            } else {
> +                *height = 4;
> +            }
> +            return (env->cr[3] & PML4_ADDR_MASK) & a20_mask;
> +        } else
> +#endif
> +        {
> +            *height = 3;
> +            return (env->cr[3] & ~0x1f) & a20_mask;
> +        }
> +    } else {
> +        *height = 2;
> +        return (env->cr[3] & ~0xfff) & a20_mask;
> +    }
> +}
> +
> +
> +/**
> + * x86_page_table_entries_per_node - Return the number of entries in a
> + *                                   page table node for the CPU at a
> + *                                   given height.
> + *
> + * @cs - CPU state
> + * @height - height of the page table tree to query, where the leaves
> + *          are 1.
> + *
> + * Returns a value greater than zero on success, -1 on error.
> + */
> +int x86_page_table_entries_per_node(CPUState *cs, int height)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +    bool pae_enabled = env->cr[4] & CR4_PAE_MASK;
> +
> +    assert(height < 6);
> +    assert(height > 0);
> +
> +    switch (height) {
> +#ifdef TARGET_X86_64
> +    case 5:
> +        assert(env->cr[4] & CR4_LA57_MASK);
> +    case 4:
> +        assert(env->hflags & HF_LMA_MASK);
> +        assert(pae_enabled);
> +        return 512;
> +#endif
> +    case 3:
> +        assert(pae_enabled);
> +#ifdef TARGET_X86_64
> +        if (env->hflags & HF_LMA_MASK) {
> +            return 512;
> +        } else
> +#endif
> +        {
> +            return 4;
> +        }
> +    case 2:
> +    case 1:
> +        return pae_enabled ? 512 : 1024;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    return -1;
> +}
> +
> +/**
> + * x86_pte_leaf_page_size - Return the page size of a leaf entry,
> + *                          given the height and CPU state
> + *
> + * @cs - CPU state
> + * @height - height of the page table tree to query, where the leaves
> + *          are 1.
> + *
> + * Returns a value greater than zero on success, -1 on error.
> + */
> +uint64_t x86_pte_leaf_page_size(CPUState *cs, int height)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +    bool pae_enabled = env->cr[4] & CR4_PAE_MASK;
> +
> +    assert(height < 6);
> +    assert(height > 0);
> +
> +    switch (height) {
> +#ifdef TARGET_X86_64
> +    case 5:
> +        assert(pae_enabled);
> +        assert(env->cr[4] & CR4_LA57_MASK);
> +        assert(env->hflags & HF_LMA_MASK);
> +        return 1ULL << 48;
> +    case 4:
> +        assert(pae_enabled);
> +        assert(env->hflags & HF_LMA_MASK);
> +        return 1ULL << 39;
> +#endif
> +    case 3:
> +        assert(pae_enabled);
> +        return 1 << 30;
> +    case 2:
> +        if (pae_enabled) {
> +            return 1 << 21;
> +        } else {
> +            return 1 << 22;
> +        }
> +    case 1:
> +        return 4096;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    return -1;
> +}
> +
> +/*
> + * Given a CPU state and height, return the number of bits
> + * to shift right/left in going from virtual to PTE index
> + * and vice versa, the number of useful bits.
> + */
> +static void _mmu_decode_va_parameters(CPUState *cs, int height,
> +                                      int *shift, int *width)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +    int _shift = 0;
> +    int _width = 0;
> +    bool pae_enabled = env->cr[4] & CR4_PAE_MASK;
> +
> +    switch (height) {
> +    case 5:
> +        _shift = 48;
> +        _width = 9;
> +        break;
> +    case 4:
> +        _shift = 39;
> +        _width = 9;
> +        break;
> +    case 3:
> +        _shift = 30;
> +        _width = 9;
> +        break;
> +    case 2:
> +        /* 64 bit page tables shift from 30->21 bits here */
> +        if (pae_enabled) {
> +            _shift = 21;
> +            _width = 9;
> +        } else {
> +            /* 32 bit page tables shift from 32->22 bits */
> +            _shift = 22;
> +            _width = 10;
> +        }
> +        break;
> +    case 1:
> +        _shift = 12;
> +        if (pae_enabled) {
> +            _width = 9;
> +        } else {
> +            _width = 10;
> +        }
> +
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    if (shift) {
> +        *shift = _shift;
> +    }
> +
> +    if (width) {
> +        *width = _width;
> +    }
> +}
> +
> +/**
> + * get_pte - Copy the contents of the page table entry at node[i] into pt_entry.
> + *           Optionally, add the relevant bits to the virtual address in
> + *           vaddr_pte.
> + *
> + * @cs - CPU state
> + * @node - physical address of the current page table node
> + * @i - index (in page table entries, not bytes) of the page table
> + *      entry, within node
> + * @height - height of node within the tree (leaves are 1, not 0)
> + * @pt_entry - Poiter to a PTE_t, stores the contents of the page table entry
> + * @vaddr_parent - The virtual address bits already translated in walking the
> + *                 page table to node.  Optional: only used if vaddr_pte is set.
> + * @vaddr_pte - Optional pointer to a variable storing the virtual address bits
> + *              translated by node[i].
> + * @pte_paddr - Pointer to the physical address of the PTE within node.
> + *              Optional parameter.
> + */
> +void
> +x86_get_pte(CPUState *cs, hwaddr node, int i, int height,
> +            PTE_t *pt_entry, vaddr vaddr_parent, vaddr *vaddr_pte,
> +            hwaddr *pte_paddr)
> +
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +    int32_t a20_mask = x86_get_a20_mask(env);
> +    hwaddr pte;
> +
> +    if (env->hflags & HF_LMA_MASK) {
> +        /* 64 bit */
> +        int pte_width = 8;
> +        pte = (node + (i * pte_width)) & a20_mask;
> +        pt_entry->pte64_t = address_space_ldq(cs->as, pte,
> +                                              MEMTXATTRS_UNSPECIFIED, NULL);
> +    } else {
> +        /* 32 bit */
> +        int pte_width = 4;
> +        pte = (node + (i * pte_width)) & a20_mask;
> +        pt_entry->pte32_t = address_space_ldl(cs->as, pte,
> +                                              MEMTXATTRS_UNSPECIFIED, NULL);
> +    }
> +
> +    if (vaddr_pte) {
> +        int shift = 0;
> +        _mmu_decode_va_parameters(cs, height, &shift, NULL);
> +        *vaddr_pte = vaddr_parent | ((i & 0x1ffULL) << shift);
> +    }
> +
> +    if (pte_paddr) {
> +        *pte_paddr = pte;
> +    }
> +}
> +
> +
> +static bool
> +mmu_pte_check_bits(CPUState *cs, PTE_t *pte, int64_t mask)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +    if (env->hflags & HF_LMA_MASK) {
> +        return pte->pte64_t & mask;
> +    } else {
> +        return pte->pte32_t & mask;
> +    }
> +}
> +
> +/**
> + * x86_pte_present - Return true if the pte is marked 'present'
> + */
> +bool
> +x86_pte_present(CPUState *cs, PTE_t *pte)
> +{
> +    return mmu_pte_check_bits(cs, pte, PG_PRESENT_MASK);
> +}
> +
> +/**
> + * x86_pte_leaf - Return true if the pte is
> + *                a page table leaf, false if
> + *                the pte points to another
> + *                node in the radix tree.
> + */
> +bool
> +x86_pte_leaf(CPUState *cs, int height, PTE_t *pte)
> +{
> +    return height == 1 || mmu_pte_check_bits(cs, pte, PG_PSE_MASK);
> +}
> +
> +/**
> + * x86_pte_child - Returns the physical address
> + *                 of a radix tree node pointed to by pte.
> + *
> + * @cs - CPU state
> + * @pte - The page table entry
> + * @height - The height in the tree of pte
> + *
> + * Returns the physical address stored in pte on success,
> + *     -1 on error.
> + */
> +hwaddr
> +x86_pte_child(CPUState *cs, PTE_t *pte, int height)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +    bool pae_enabled = env->cr[4] & CR4_PAE_MASK;
> +    int32_t a20_mask = x86_get_a20_mask(env);
> +
> +    switch (height) {
> +#ifdef TARGET_X86_64
> +    case 5:
> +        assert(env->cr[4] & CR4_LA57_MASK);
> +    case 4:
> +        assert(env->hflags & HF_LMA_MASK);
> +        /* assert(pae_enabled); */
> +        /* Fall through */
> +#endif
> +    case 3:
> +        assert(pae_enabled);
> +#ifdef TARGET_X86_64
> +        if (env->hflags & HF_LMA_MASK) {
> +            return (pte->pte64_t & PG_ADDRESS_MASK) & a20_mask;
> +        } else
> +#endif
> +        {
> +            return (pte->pte64_t & ~0xfff) & a20_mask;
> +        }
> +    case 2:
> +    case 1:
> +        if (pae_enabled) {
> +            return (pte->pte64_t & PG_ADDRESS_MASK) & a20_mask;
> +        } else {
> +            return (pte->pte32_t & ~0xfff) & a20_mask;
> +        }
> +    default:
> +        g_assert_not_reached();
> +    }
> +    return -1;
> +}
> +
>   /* PAE Paging or IA-32e Paging */
>   static void walk_pte(MemoryMappingList *list, AddressSpace *as,
>                        hwaddr pte_start_addr,
> @@ -313,4 +663,3 @@ bool x86_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
>   
>       return true;
>   }
> -
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 914bef442c..8bd6164b68 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8305,6 +8305,17 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
>       .write_elf32_qemunote = x86_cpu_write_elf32_qemunote,
>       .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
>       .legacy_vmsd = &vmstate_x86_cpu,
> +    .page_table_root = &x86_page_table_root,
> +    .page_table_entries_per_node = &x86_page_table_entries_per_node,
> +    .get_pte = &x86_get_pte,
> +    .pte_present = &x86_pte_present,
> +    .pte_leaf = &x86_pte_leaf,
> +    .pte_child = &x86_pte_child,
> +    .pte_leaf_page_size = &x86_pte_leaf_page_size,
> +    .pte_flags = &x86_pte_flags,
> +    .mon_init_page_table_iterator = &x86_mon_init_page_table_iterator,
> +    .mon_info_pg_print_header = &x86_mon_info_pg_print_header,
> +    .mon_flush_page_print_state = &x86_mon_flush_print_pg_state,
>   };
>   #endif
>   
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index c64ef0c1a2..cbb6f6fc4d 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -21,6 +21,7 @@
>   #define I386_CPU_H
>   
>   #include "sysemu/tcg.h"
> +#include "hw/core/sysemu-cpu-ops.h"
>   #include "cpu-qom.h"
>   #include "kvm/hyperv-proto.h"
>   #include "exec/cpu-defs.h"
> @@ -2150,8 +2151,22 @@ int x86_cpu_write_elf64_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
>   int x86_cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
>                                    DumpState *s);
>   
> +hwaddr x86_page_table_root(CPUState *cs, int *height);
> +int x86_page_table_entries_per_node(CPUState *cs, int height);
> +uint64_t x86_pte_leaf_page_size(CPUState *cs, int height);
> +void x86_get_pte(CPUState *cs, hwaddr node, int i, int height,
> +                 PTE_t *pt_entry, vaddr vaddr_parent, vaddr *vaddr_pte,
> +                 hwaddr *pte_paddr);
> +bool x86_pte_present(CPUState *cs, PTE_t *pte);
> +bool x86_pte_leaf(CPUState *cs, int height, PTE_t *pte);
> +hwaddr x86_pte_child(CPUState *cs, PTE_t *pte, int height);
> +uint64_t x86_pte_flags(uint64_t pte);
>   bool x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
>                                   Error **errp);
> +bool x86_mon_init_page_table_iterator(Monitor *mon,
> +                                      struct mem_print_state *state);
> +void x86_mon_info_pg_print_header(Monitor *mon, struct mem_print_state *state);
> +bool x86_mon_flush_print_pg_state(CPUState *cs, struct mem_print_state *state);
>   
>   void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
>   
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 2d766b2637..65e82e73e8 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -32,6 +32,171 @@
>   #include "qapi/qapi-commands-misc-target.h"
>   #include "qapi/qapi-commands-misc.h"
>   
> +
> +/********************* x86 specific hooks for printing page table stuff ****/
> +
> +const char *names[7] = {(char *)NULL, "PTE", "PDE", "PDP", "PML4", "Pml5",
> +                        (char *)NULL};
> +static char *pg_bits(hwaddr ent)
> +{
> +    static char buf[32];
> +    snprintf(buf, 32, "%c%c%c%c%c%c%c%c%c%c",
> +            ent & PG_NX_MASK ? 'X' : '-',
> +            ent & PG_GLOBAL_MASK ? 'G' : '-',
> +            ent & PG_PSE_MASK ? 'S' : '-',
> +            ent & PG_DIRTY_MASK ? 'D' : '-',
> +            ent & PG_ACCESSED_MASK ? 'A' : '-',
> +            ent & PG_PCD_MASK ? 'C' : '-',
> +            ent & PG_PWT_MASK ? 'T' : '-',
> +            ent & PG_USER_MASK ? 'U' : '-',
> +            ent & PG_RW_MASK ? 'W' : '-',
> +            ent & PG_PRESENT_MASK ? 'P' : '-');
> +    return buf;
> +}
> +
> +bool x86_mon_init_page_table_iterator(Monitor *mon,
> +                                      struct mem_print_state *state)
> +{
> +    CPUArchState *env;
> +    state->mon = mon;
> +    state->flush_interior = false;
> +    state->require_physical_contiguity = false;
> +
> +    for (int i = 0; i < MAX_HEIGHT; i++) {
> +        state->vstart[i] = -1;
> +        state->last_offset[i] = 0;
> +    }
> +    state->start_height = 0;
> +
> +    env = mon_get_cpu_env(mon);
> +    if (!env) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return false;
> +    }
> +    state->env = env;
> +
> +    if (!(env->cr[0] & CR0_PG_MASK)) {
> +        monitor_printf(mon, "PG disabled\n");
> +        return false;
> +    }
> +
> +    /* set va and pa width */
> +    if (env->cr[4] & CR4_PAE_MASK) {
> +        state->paw = 13;
> +#ifdef TARGET_X86_64
> +        if (env->hflags & HF_LMA_MASK) {
> +            if (env->cr[4] & CR4_LA57_MASK) {
> +                state->vaw = 15;
> +                state->max_height = 5;
> +            } else {
> +                state->vaw = 12;
> +                state->max_height = 4;
> +            }
> +        } else
> +#endif
> +        {
> +            state->vaw = 8;
> +            state->max_height = 3;
> +        }
> +    } else {
> +        state->max_height = 2;
> +        state->vaw = 8;
> +        state->paw = 8;
> +    }
> +
> +    return true;
> +}
> +
> +void x86_mon_info_pg_print_header(Monitor *mon, struct mem_print_state *state)
> +{
> +    /* Header line */
> +    monitor_printf(mon, "%-*s %-13s %-10s %*s%s\n",
> +                   3 + 2 * (state->vaw - 3), "VPN range",
> +                   "Entry", "Flags",
> +                   2 * (state->max_height - 1), "", "Physical page(s)");
> +}
> +
> +
> +static void pg_print(CPUState *cs, Monitor *mon, uint64_t pt_ent,
> +                     target_ulong vaddr_s, target_ulong vaddr_l,
> +                     hwaddr paddr_s, hwaddr paddr_l,
> +                     int offset_s, int offset_l,
> +                     int height, int max_height, int vaw, int paw,
> +                     bool is_leaf)
> +
> +{
> +    char buf[128];
> +    char *pos = buf, *end = buf + sizeof(buf);
> +    target_ulong size = x86_pte_leaf_page_size(cs, height);
> +
> +    /* VFN range */
> +    pos += snprintf(pos, end - pos, "%*s[%0*"PRIx64"-%0*"PRIx64"] ",
> +                    (max_height - height) * 2, "",
> +                    vaw - 3, (uint64_t)vaddr_s >> 12,
> +                    vaw - 3, ((uint64_t)vaddr_l + size - 1) >> 12);
> +
> +    /* Slot */
> +    if (vaddr_s == vaddr_l) {
> +        pos += snprintf(pos, end - pos, "%4s[%03x]    ",
> +                       names[height], offset_s);
> +    } else {
> +        pos += snprintf(pos, end - pos, "%4s[%03x-%03x]",
> +                       names[height], offset_s, offset_l);
> +    }
> +
> +    /* Flags */
> +    pos += snprintf(pos, end - pos, " %s", pg_bits(pt_ent));
> +
> +
> +    /* Range-compressed PFN's */
> +    if (is_leaf) {
> +        if (vaddr_s == vaddr_l) {
> +            pos += snprintf(pos, end - pos, " %0*"PRIx64,
> +                            paw - 3, (uint64_t)paddr_s >> 12);
> +        } else {
> +            pos += snprintf(pos, end - pos, " %0*"PRIx64"-%0*"PRIx64,
> +                            paw - 3, (uint64_t)paddr_s >> 12,
> +                            paw - 3, (uint64_t)paddr_l >> 12);
> +        }
> +        pos = MIN(pos, end);
> +    }
> +
> +    /* Trim line to fit screen */
> +    if (pos - buf > 79) {
> +        strcpy(buf + 77, "..");
> +    }
> +
> +    monitor_printf(mon, "%s\n", buf);
> +}
> +
> +uint64_t x86_pte_flags(uint64_t pte)
> +{
> +    return pte & (PG_USER_MASK | PG_RW_MASK |
> +                  PG_PRESENT_MASK);
> +}
> +
> +/* Returns true if it emitted anything */
> +bool x86_mon_flush_print_pg_state(CPUState *cs, struct mem_print_state *state)
> +{
> +    bool ret = false;
> +    for (int i = state->start_height; i > 0; i--) {
> +        if (state->vstart[i] == -1) {
> +            break;
> +        }
> +        PTE_t my_pte;
> +        my_pte.pte64_t = state->ent[i];
> +        ret = true;
> +        pg_print(cs, state->mon, state->ent[i],
> +                 state->vstart[i], state->vend[i],
> +                 state->pstart, state->pend,
> +                 state->offset[i], state->last_offset[i],
> +                 i, state->max_height, state->vaw, state->paw,
> +                 x86_pte_leaf(cs, i, &my_pte));
> +    }
> +
> +    return ret;
> +}
> +
>   /* Perform linear address sign extension */
>   static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
>   {


