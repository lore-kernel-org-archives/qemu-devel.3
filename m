Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4466AD6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeD8-0003Pd-Sj; Thu, 14 Nov 2024 13:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeD4-000380-8K
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:04:51 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeD2-00034s-JX
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:04:50 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20c70abba48so10348135ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607486; x=1732212286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kK8dmSNjxzJuv/y5bAh8iTPFToN2L+Lsbx+rR/MAS5A=;
 b=qU5/4n+deWEmeecgaLAPUbruWatJuu57dMrfHX7FmyKR7f63kLECz1nAOY5c3s1VWQ
 ZWgslrmgcTV2H9gGZSSqPaLcG1aINz0lFVZhnyokXUAaDkNp7akyY20DNXNY8iFvf7zK
 Pcg6Kn6hwTRK/3Gg7zvb145p+pV7Q5YNuQ2zCt9Xn8ijGBwiKGoVORHGYeQxTJXrMxby
 QGpr0OfGmilYOsKNouwnygw0CkEyNIiQRIC55DPEkUR1Q7jla+DFTytB6L7uDhWb3pGO
 EyiMpjb9lWgN5S9cenN4sugOPJufKo2k6A7op/l4FfeyBJ8m9/jne5Kd32CPYTKkvxdj
 m+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607486; x=1732212286;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kK8dmSNjxzJuv/y5bAh8iTPFToN2L+Lsbx+rR/MAS5A=;
 b=xLHywHo5fX11SpZOIROSb3H+QcwIZSIrmulRa2s2wzk+YJqzfDcxIyH46JQ+YK2zPO
 PHusa8P/KgoT0Xi95ifvRwrVYuWO6JaU3MUYi7c3MD3JLuo3PKHz8tC+83Xwloz7Sg+k
 SrPbRPZg5RaxDeRC3URSb3cE4n63w1pXrU/qwIucQt1z/+Ga2Y0F8C3v5iF3pUum+syY
 ZMP4qDDuffNXWjOj/Ad+hgDr5+QXGiP0AmnKjSZScfJgkdZEVPPr/6Gq/xI51xsSNZOY
 ct+eTdKvjES7xFhTkVJt7D/2ag2GBANud9PhZI+BKQMToeBG7IvoEcIG5p2ETMu6LEHG
 jAWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtBg1eS2tpXOM5JLDbBO3uSDjD1KWkXbJVJRxlHNln+soAGxBp5JJlXwpP5gfLmZL6l5nVlEnCXdXw@nongnu.org
X-Gm-Message-State: AOJu0YyPXH9vPTvCcfSVvkekk1lCXibt54xs3QMeF2387eglHnLAbxFI
 Z68ebCHgYTZDU48WjQR3i9OJ98iail79EcNahsN2Zb8zOQtPhgO2lJlHLEGIfY4y+KjGiX2W9qs
 Dp47eDQ==
X-Google-Smtp-Source: AGHT+IEZCU4hRJ6DjORy3nZo5mWWgzthKXIXuxytqhpFL/EFvG+ZWfTl3vtfZpG338uCNLCWFSPUgA==
X-Received: by 2002:a17:903:18a:b0:20c:a189:c006 with SMTP id
 d9443c01a7336-211c50ce276mr26819365ad.45.1731607485744; 
 Thu, 14 Nov 2024 10:04:45 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7d3d534sm13539285ad.276.2024.11.14.10.04.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:04:44 -0800 (PST)
Message-ID: <3b54a627-c2df-4a63-969e-af0b205a4718@linaro.org>
Date: Thu, 14 Nov 2024 10:04:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/54] accel/tcg: Pass full addr to victim_tlb_hit
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-17-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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
> Do not mask the address to the page in these calls.
> It is easy enough to use a different helper instead.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 7ecd327297..3aab72ea82 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1387,7 +1387,7 @@ static void io_failed(CPUState *cpu, CPUTLBEntryFull *full, vaddr addr,
>   /* Return true if ADDR is present in the victim tlb, and has been copied
>      back to the main tlb.  */
>   static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
> -                           MMUAccessType access_type, vaddr page)
> +                           MMUAccessType access_type, vaddr addr)
>   {
>       size_t vidx;
>   
> @@ -1395,7 +1395,7 @@ static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
>       for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
>           CPUTLBEntry *vtlb = &cpu->neg.tlb.d[mmu_idx].vtable[vidx];
>   
> -        if (tlb_hit_page(tlb_read_idx(vtlb, access_type), page)) {
> +        if (tlb_hit(tlb_read_idx(vtlb, access_type), addr)) {
>               /* Found entry in victim tlb, swap tlb and iotlb.  */
>               CPUTLBEntry tmptlb, *tlb = &cpu->neg.tlb.f[mmu_idx].table[index];
>   
> @@ -1448,13 +1448,12 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
>       uintptr_t index = tlb_index(cpu, mmu_idx, addr);
>       CPUTLBEntry *entry = tlb_entry(cpu, mmu_idx, addr);
>       uint64_t tlb_addr = tlb_read_idx(entry, access_type);
> -    vaddr page_addr = addr & TARGET_PAGE_MASK;
>       int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
>       bool force_mmio = check_mem_cbs && cpu_plugin_mem_cbs_enabled(cpu);
>       CPUTLBEntryFull *full;
>   
> -    if (!tlb_hit_page(tlb_addr, page_addr)) {
> -        if (!victim_tlb_hit(cpu, mmu_idx, index, access_type, page_addr)) {
> +    if (!tlb_hit(tlb_addr, addr)) {
> +        if (!victim_tlb_hit(cpu, mmu_idx, index, access_type, addr)) {
>               if (!tlb_fill_align(cpu, addr, access_type, mmu_idx,
>                                   0, fault_size, nonfault, retaddr)) {
>                   /* Non-faulting page table read failed.  */
> @@ -1734,8 +1733,7 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
>   
>       /* If the TLB entry is for a different page, reload and try again.  */
>       if (!tlb_hit(tlb_addr, addr)) {
> -        if (!victim_tlb_hit(cpu, mmu_idx, index, access_type,
> -                            addr & TARGET_PAGE_MASK)) {
> +        if (!victim_tlb_hit(cpu, mmu_idx, index, access_type, addr)) {
>               tlb_fill_align(cpu, addr, access_type, mmu_idx,
>                              memop, data->size, false, ra);
>               maybe_resized = true;
> @@ -1914,8 +1912,7 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>       /* Check TLB entry and enforce page permissions.  */
>       flags = TLB_FLAGS_MASK;
>       if (!tlb_hit(tlb_addr_write(tlbe), addr)) {
> -        if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE,
> -                            addr & TARGET_PAGE_MASK)) {
> +        if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE, addr)) {
>               tlb_fill_align(cpu, addr, MMU_DATA_STORE, mmu_idx,
>                              mop, size, false, retaddr);
>               did_tlb_fill = true;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


