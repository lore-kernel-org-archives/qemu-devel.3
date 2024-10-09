Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF59CED611
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syfww-0005yn-UB; Wed, 09 Oct 2024 19:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syfwt-0005yX-N1
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:18:31 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syfwr-0002Fx-R5
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:18:31 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7163489149eso234817a12.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728515908; x=1729120708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gAVU8NcAHJK0YBI17/haFuFt6yks6DQuHAdUdP+2y9k=;
 b=I9DSweF0STgot14xPkyPoCUiE7fLJeh9bo39G8mkxpTHTTEBlSSglX/lrGj+LeKjhl
 zC8jjzfvYS8ZOAx9UMPM3NzNY39vJ8GNZkYNgt9mfB0B15o1AJAyHCgzfdGAeIpz4ySK
 hz1R41IGwH4lqvQhZvegUsf9jB4lUJR+QylGhi9N4QFie0LDZLG30itn3JU+WwH/jwrp
 dnwmghgiw52LNXISpPH03OusQaUfr9PjZelrVqq0jTLXcllKzA6uAtNFRTY82+xjkAwc
 yk/TY8MMIiIYylPuQokhzo5kYk0HYfyfv56aMbOVnQb841fyMfe+l1v4+ek83rQ8H0+L
 BHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728515908; x=1729120708;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gAVU8NcAHJK0YBI17/haFuFt6yks6DQuHAdUdP+2y9k=;
 b=GWXEwFgxGXPXzCb15Dc6aZm8BD3zlp4EQ76foL/fhPVlcgn8AzwuC+txWJZtlIIZrd
 aH7Jt2IcyGPf/HMvZ8d95ad8z1Ngxz6axci/AKi8chX6m4xTS2MRVaUq9wCtxWRM0Os1
 D7rN0rQ/oXUCvO4QrTKCkpTyeayStIv46jYRiIynVGP38K1TJtJer1rPOmL7lCPkvXjM
 RyrxEQnmwMjfjNibtNf588paFLTsAVli4av/sQV8gWvXpNvNWb/chAGhX3P9SQUoLDQm
 srTamlKWWAmneCLc3FagIF/pxKuwY/VAP66nDEhDVbAs+QH0cFIFroIsBCOXLtmtsZa2
 rM7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ3XafICVDH7jFsZOINZSAnwmBccNw0xkjC9+/vCBtXjtiDGOhvrojTFtqSUy7ulEjMzJFztTjho+o@nongnu.org
X-Gm-Message-State: AOJu0Yzwkn5dcE0cAtWBVucuccrL0BXknbAJCd4HLKJ3VmTtgSpjpdm2
 yq9E73oL8nEkVzZwaKk342G4l/keMRZ+nJE6PowcMoMp6n49gsWFR/0PgXZj+SE=
X-Google-Smtp-Source: AGHT+IEShS27vMo3Pt+WFjeMvolUU89Q9wYKN+fek6QfoCQl1qAjZsinb8cG/ERixJsYdRtunJ960Q==
X-Received: by 2002:a05:6a21:501:b0:1d8:ae1a:4ce9 with SMTP id
 adf61e73a8af0-1d8ae1a4d33mr1774216637.40.1728515907620; 
 Wed, 09 Oct 2024 16:18:27 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0cbba36sm8298195b3a.3.2024.10.09.16.18.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 16:18:27 -0700 (PDT)
Message-ID: <0e8f906e-8380-450c-9a59-78e5ea4804d6@linaro.org>
Date: Wed, 9 Oct 2024 16:18:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/23] accel/tcg: Fix flags usage in mmu_lookup1,
 atomic_mmu_lookup
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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
> The INVALID bit should only be auto-cleared when we have
> just called tlb_fill, not along the victim_tlb_hit path.
> 
> In atomic_mmu_lookup, rename tlb_addr to flags, as that
> is what we're actually carrying around.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 33 ++++++++++++++++++++++-----------
>   1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 6773874f2d..fd8da8586f 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1657,7 +1657,7 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
>       uint64_t tlb_addr = tlb_read_idx(entry, access_type);
>       bool maybe_resized = false;
>       CPUTLBEntryFull *full;
> -    int flags;
> +    int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
>   
>       /* If the TLB entry is for a different page, reload and try again.  */
>       if (!tlb_hit(tlb_addr, addr)) {
> @@ -1668,8 +1668,14 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
>               maybe_resized = true;
>               index = tlb_index(cpu, mmu_idx, addr);
>               entry = tlb_entry(cpu, mmu_idx, addr);
> +            /*
> +             * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
> +             * to force the next access through tlb_fill.  We've just
> +             * called tlb_fill, so we know that this entry *is* valid.
> +             */
> +            flags &= ~TLB_INVALID_MASK;
>           }
> -        tlb_addr = tlb_read_idx(entry, access_type) & ~TLB_INVALID_MASK;
> +        tlb_addr = tlb_read_idx(entry, access_type);
>       }
>   
>       full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
> @@ -1819,10 +1825,10 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>       MemOp mop = get_memop(oi);
>       uintptr_t index;
>       CPUTLBEntry *tlbe;
> -    vaddr tlb_addr;
>       void *hostaddr;
>       CPUTLBEntryFull *full;
>       bool did_tlb_fill = false;
> +    int flags;
>   
>       tcg_debug_assert(mmu_idx < NB_MMU_MODES);
>   
> @@ -1833,8 +1839,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>       tlbe = tlb_entry(cpu, mmu_idx, addr);
>   
>       /* Check TLB entry and enforce page permissions.  */
> -    tlb_addr = tlb_addr_write(tlbe);
> -    if (!tlb_hit(tlb_addr, addr)) {
> +    flags = TLB_FLAGS_MASK;
> +    if (!tlb_hit(tlb_addr_write(tlbe), addr)) {
>           if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE,
>                               addr & TARGET_PAGE_MASK)) {
>               tlb_fill_align(cpu, addr, MMU_DATA_STORE, mmu_idx,
> @@ -1842,8 +1848,13 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>               did_tlb_fill = true;
>               index = tlb_index(cpu, mmu_idx, addr);
>               tlbe = tlb_entry(cpu, mmu_idx, addr);
> +            /*
> +             * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
> +             * to force the next access through tlb_fill.  We've just
> +             * called tlb_fill, so we know that this entry *is* valid.
> +             */
> +            flags &= ~TLB_INVALID_MASK;
>           }
> -        tlb_addr = tlb_addr_write(tlbe) & ~TLB_INVALID_MASK;
>       }
>   
>       /*
> @@ -1879,11 +1890,11 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>           goto stop_the_world;
>       }
>   
> -    /* Collect tlb flags for read. */
> -    tlb_addr |= tlbe->addr_read;
> +    /* Collect tlb flags for read and write. */
> +    flags &= tlbe->addr_read | tlb_addr_write(tlbe);
>   
>       /* Notice an IO access or a needs-MMU-lookup access */
> -    if (unlikely(tlb_addr & (TLB_MMIO | TLB_DISCARD_WRITE))) {
> +    if (unlikely(flags & (TLB_MMIO | TLB_DISCARD_WRITE))) {
>           /* There's really nothing that can be done to
>              support this apart from stop-the-world.  */
>           goto stop_the_world;
> @@ -1892,11 +1903,11 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>       hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
>       full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
>   
> -    if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
> +    if (unlikely(flags & TLB_NOTDIRTY)) {
>           notdirty_write(cpu, addr, size, full, retaddr);
>       }
>   
> -    if (unlikely(tlb_addr & TLB_FORCE_SLOW)) {
> +    if (unlikely(flags & TLB_FORCE_SLOW)) {
>           int wp_flags = 0;
>   
>           if (full->slow_flags[MMU_DATA_STORE] & TLB_WATCHPOINT) {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

