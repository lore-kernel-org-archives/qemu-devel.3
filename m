Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF483D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 19:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBfxP-0005Qy-UQ; Thu, 14 Nov 2024 14:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBfxL-0005Qb-4v
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:56:43 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBfxF-0000lg-PU
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:56:39 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20c6f492d2dso12087235ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 11:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731614195; x=1732218995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vc5JdlxvD62tTwd3L59iUPQRBd1BWOi7diCE1d1/lP8=;
 b=ddjkJM3qpB4fgW+XBeuWHC+reMwChWTtBjAOQ1eUFcQoC8BAHpBwPhbEW5/7cTMg9b
 MDLt99cbmu6sW64/+wJ3KI+FbF0oEklysdlIO/DF9q5s/4aSNE94ks2EP/lRvAGkNLB6
 UGr6OOz217KGwB5TQ75odW806eW1T2CQU2DcP98psJBlwZ3uTkLfbUoOBGlavpmHeTVL
 q9AgwD5IMIhATM/tkPgz848EoYNKVfH/MGfCaDvxiGazGczSHiAuXM+lfEkRe6vh3HOx
 twxlpjR3Bdv49phIP7JnoRY4j1nny7WlNcDGumGoOhgYsqqtgwA09Rw3Bp1z8uJazWuW
 Uo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731614195; x=1732218995;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vc5JdlxvD62tTwd3L59iUPQRBd1BWOi7diCE1d1/lP8=;
 b=rYgOkM0eu902fYDHqQ/PdMFA0CWtkY1gs7SQEWg0m8jgd8QSxcg+TcA3cMnIS0K12e
 qD/eEkEv9snH0pZ0zs5Gjovz8mO+h0mEHKoyZHSTbjSLgqzRJ9poIV31nDpOVDqHKAeW
 s6O7IQu7xRBJRyn2fXjRLppAvpJFGkIKPOKfcYdWoHH9bAJ1S76MvwZokdk/LA6VI4Hj
 oE7LpySzI8JYKwJJHZhWwqDnBP9XZApgBBmqNcByLSJQ+VQu77slPZ46pKmGC5l+dFxD
 +SurnyNVgM1oBFYCsYr3GjddyY55WWtVzLgi/RzslztyYXIWhmEgYe+haA0E8XDIB8lW
 KjFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdo+VBSW19mH0eUyxbMFCEEixVJSECZvrWzDqVwvyEpSxNotEI/SkP3WSg1nA+MWnis4gZnGOtMF9M@nongnu.org
X-Gm-Message-State: AOJu0YwClmiN8WMs4WWrS3dKPYmlFTB5i5zrluRAV9nUg9MdAoJbKlu6
 Bj53fevXzMAAycbkz97DRZYFtA9GxnqclmNXPaEAdCedrzJ7q/bSZMTjzXHf01Q=
X-Google-Smtp-Source: AGHT+IH+uSaxEffmaSU/E/DkFsrVoNfgCmTBWKPuBN0cfg/Z7Q3KFO6FvSzB5SPI/8zSF06pseDdMQ==
X-Received: by 2002:a17:902:d2d0:b0:20b:b40b:3454 with SMTP id
 d9443c01a7336-211d0cacb05mr1859235ad.0.1731614195475; 
 Thu, 14 Nov 2024 11:56:35 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f346e2sm105285ad.141.2024.11.14.11.56.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 11:56:35 -0800 (PST)
Message-ID: <eaa2ecf4-74ce-49e1-846e-8f0c9c16d1af@linaro.org>
Date: Thu, 14 Nov 2024 11:56:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 v2 00/54] accel/tcg: Convert victim tlb to
 IntervalTree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 11/14/24 08:00, Richard Henderson wrote:
> v1: 20241009150855.804605-1-richard.henderson@linaro.org
> 
> The initial idea was: how much can we do with an intelligent data
> structure for the same cost as a linear search through an array?
> 
> 
> r~
> 
> 
> Richard Henderson (54):
>    util/interval-tree: Introduce interval_tree_free_nodes
>    accel/tcg: Split out tlbfast_flush_locked
>    accel/tcg: Split out tlbfast_{index,entry}
>    accel/tcg: Split out tlbfast_flush_range_locked
>    accel/tcg: Fix flags usage in mmu_lookup1, atomic_mmu_lookup
>    accel/tcg: Assert non-zero length in tlb_flush_range_by_mmuidx*
>    accel/tcg: Assert bits in range in tlb_flush_range_by_mmuidx*
>    accel/tcg: Flush entire tlb when a masked range wraps
>    accel/tcg: Add IntervalTreeRoot to CPUTLBDesc
>    accel/tcg: Populate IntervalTree in tlb_set_page_full
>    accel/tcg: Remove IntervalTree entry in tlb_flush_page_locked
>    accel/tcg: Remove IntervalTree entries in tlb_flush_range_locked
>    accel/tcg: Process IntervalTree entries in tlb_reset_dirty
>    accel/tcg: Process IntervalTree entries in tlb_set_dirty
>    accel/tcg: Use tlb_hit_page in victim_tlb_hit
>    accel/tcg: Pass full addr to victim_tlb_hit
>    accel/tcg: Replace victim_tlb_hit with tlbtree_hit
>    accel/tcg: Remove the victim tlb
>    accel/tcg: Remove tlb_n_used_entries_inc
>    include/exec/tlb-common: Move CPUTLBEntryFull from hw/core/cpu.h
>    accel/tcg: Delay plugin adjustment in probe_access_internal
>    accel/tcg: Call cpu_ld*_code_mmu from cpu_ld*_code
>    accel/tcg: Check original prot bits for read in atomic_mmu_lookup
>    accel/tcg: Preserve tlb flags in tlb_set_compare
>    accel/tcg: Return CPUTLBEntryFull not pointer in probe_access_full_mmu
>    accel/tcg: Return CPUTLBEntryFull not pointer in probe_access_full
>    accel/tcg: Return CPUTLBEntryFull not pointer in probe_access_internal
>    accel/tcg: Introduce tlb_lookup
>    accel/tcg: Partially unify MMULookupPageData and TLBLookupOutput
>    accel/tcg: Merge mmu_lookup1 into mmu_lookup
>    accel/tcg: Always use IntervalTree for code lookups
>    accel/tcg: Link CPUTLBEntry to CPUTLBEntryTree
>    accel/tcg: Remove CPUTLBDesc.fulltlb
>    target/alpha: Convert to TCGCPUOps.tlb_fill_align
>    target/avr: Convert to TCGCPUOps.tlb_fill_align
>    target/i386: Convert to TCGCPUOps.tlb_fill_align
>    target/loongarch: Convert to TCGCPUOps.tlb_fill_align
>    target/m68k: Convert to TCGCPUOps.tlb_fill_align
>    target/m68k: Do not call tlb_set_page in helper_ptest
>    target/microblaze: Convert to TCGCPUOps.tlb_fill_align
>    target/mips: Convert to TCGCPUOps.tlb_fill_align
>    target/openrisc: Convert to TCGCPUOps.tlb_fill_align
>    target/ppc: Convert to TCGCPUOps.tlb_fill_align
>    target/riscv: Convert to TCGCPUOps.tlb_fill_align
>    target/rx: Convert to TCGCPUOps.tlb_fill_align
>    target/s390x: Convert to TCGCPUOps.tlb_fill_align
>    target/sh4: Convert to TCGCPUOps.tlb_fill_align
>    target/sparc: Convert to TCGCPUOps.tlb_fill_align
>    target/tricore: Convert to TCGCPUOps.tlb_fill_align
>    target/xtensa: Convert to TCGCPUOps.tlb_fill_align
>    accel/tcg: Drop TCGCPUOps.tlb_fill
>    accel/tcg: Unexport tlb_set_page*
>    accel/tcg: Merge tlb_fill_align into callers
>    accel/tcg: Return CPUTLBEntryTree from tlb_set_page_full
> 
>   include/exec/cpu-all.h               |   3 +
>   include/exec/exec-all.h              |  65 +-
>   include/exec/tlb-common.h            |  68 +-
>   include/hw/core/cpu.h                |  75 +-
>   include/hw/core/tcg-cpu-ops.h        |  10 -
>   include/qemu/interval-tree.h         |  11 +
>   target/alpha/cpu.h                   |   6 +-
>   target/avr/cpu.h                     |   7 +-
>   target/i386/tcg/helper-tcg.h         |   6 +-
>   target/loongarch/internals.h         |   7 +-
>   target/m68k/cpu.h                    |   7 +-
>   target/microblaze/cpu.h              |   7 +-
>   target/mips/tcg/tcg-internal.h       |   6 +-
>   target/openrisc/cpu.h                |   8 +-
>   target/ppc/internal.h                |   7 +-
>   target/riscv/cpu.h                   |   8 +-
>   target/s390x/s390x-internal.h        |   7 +-
>   target/sh4/cpu.h                     |   8 +-
>   target/sparc/cpu.h                   |   8 +-
>   target/tricore/cpu.h                 |   7 +-
>   target/xtensa/cpu.h                  |   8 +-
>   accel/tcg/cputlb.c                   | 994 +++++++++++++--------------
>   target/alpha/cpu.c                   |   2 +-
>   target/alpha/helper.c                |  23 +-
>   target/arm/ptw.c                     |  10 +-
>   target/arm/tcg/helper-a64.c          |   4 +-
>   target/arm/tcg/mte_helper.c          |  15 +-
>   target/arm/tcg/sve_helper.c          |   6 +-
>   target/avr/cpu.c                     |   2 +-
>   target/avr/helper.c                  |  19 +-
>   target/i386/tcg/sysemu/excp_helper.c |  36 +-
>   target/i386/tcg/tcg-cpu.c            |   2 +-
>   target/loongarch/cpu.c               |   2 +-
>   target/loongarch/tcg/tlb_helper.c    |  17 +-
>   target/m68k/cpu.c                    |   2 +-
>   target/m68k/helper.c                 |  32 +-
>   target/microblaze/cpu.c              |   2 +-
>   target/microblaze/helper.c           |  33 +-
>   target/mips/cpu.c                    |   2 +-
>   target/mips/tcg/sysemu/tlb_helper.c  |  29 +-
>   target/openrisc/cpu.c                |   2 +-
>   target/openrisc/mmu.c                |  39 +-
>   target/ppc/cpu_init.c                |   2 +-
>   target/ppc/mmu_helper.c              |  21 +-
>   target/riscv/cpu_helper.c            |  22 +-
>   target/riscv/tcg/tcg-cpu.c           |   2 +-
>   target/rx/cpu.c                      |  19 +-
>   target/s390x/cpu.c                   |   4 +-
>   target/s390x/tcg/excp_helper.c       |  23 +-
>   target/sh4/cpu.c                     |   2 +-
>   target/sh4/helper.c                  |  24 +-
>   target/sparc/cpu.c                   |   2 +-
>   target/sparc/mmu_helper.c            |  44 +-
>   target/tricore/cpu.c                 |   2 +-
>   target/tricore/helper.c              |  19 +-
>   target/xtensa/cpu.c                  |   2 +-
>   target/xtensa/helper.c               |  28 +-
>   util/interval-tree.c                 |  20 +
>   util/selfmap.c                       |  13 +-
>   59 files changed, 938 insertions(+), 923 deletions(-)
> 

I tested this change by booting a debian x86_64 image, it works as expected.

I noticed that this change does not come for free (64s before, 82s after 
- 1.3x). Is that acceptable?

Pierrick

