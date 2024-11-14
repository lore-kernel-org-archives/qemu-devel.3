Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF93D6A223
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 17:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBe1j-0002z2-Pf; Thu, 14 Nov 2024 12:53:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe1i-0002yc-OT
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:53:06 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe1h-0000sE-7Q
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:53:06 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71e4244fdc6so721577b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 09:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731606779; x=1732211579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=srBfZwDyQBpheJxpNZmQlNZ3tKCAxq9bXZv5KSdu6kc=;
 b=NYJQBstgR6+MtnkI/QG05BcmlN9RNIvqjC5YigcJ8O0pQdnl+xa70LnoMkOS6H47Bs
 9zXu5rgDTRxIkFoG0Guqe9Qe/oSp8sDQ2UtJLjJmhcIdDKeatwSVUsNQJ53OKWMshNju
 7X9Or96hV8sc63G5CmR0NzKgDEFcrvie8EsNhXrb/xeExbqfYtDSmIx/1fC9MgcBCw34
 OodZWX0RHu55NHhKwCbRKDAB/R7NeW56yyVFJiO3O/zcDhlQNKFuH8hSLBppcwH309bp
 Pcz/sOVPceXX9i7Bbr6bVPUEXx+HYRhyUkhzvamkztjPfX+/iechyfqJyiTSSU9wW01Y
 20Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731606779; x=1732211579;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=srBfZwDyQBpheJxpNZmQlNZ3tKCAxq9bXZv5KSdu6kc=;
 b=SfCU9olKYz6J4JHwPdU6MTie6TVg8GcUzRPg50rSsJAnAWTwm70be/GYu/4OxtYDPf
 zERk6jRuE5WSLpHcWNKcWJMSdDBSgObr/KkAAuzYLTpXRJdTZuC5jNNm2cqOPudsbe+7
 p0TBC3IJeNlX1C85o/fS5Fcbj5LJywyQVSR00SGXS/G41f6vO2MzH20X7tY9ZW9XRXoh
 WhcrvPFehqofn9YnkSJCQlF+kipJ1kWegazxogL2eVOq4AviVENJfpi6Zsm/94EW9xpV
 jtKjGJPi29DMSDt/6u95qmQKKEmEtj+8sMTo6wER5XBlruVxMMdn9crBY+HiUEQrXcmB
 kz6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSaNiSfuEcMlTj6Mh0tEUoriXgHDjuSMRDn5qkzsmHJKOJT2YpfsdNW27dRVmq94+KPKrk1Up/LgLz@nongnu.org
X-Gm-Message-State: AOJu0Yzox2jMd3cOGuftoxKE6IJQludexK8zgPE2Vl+orzFHj624InSS
 o48k0746i2UJKr6B5K9LLgk37N83ZUr995QBTqb5c6odywKNpJ2ZK+MMSB0vNx8=
X-Google-Smtp-Source: AGHT+IFo8Gk/oCsi2LNM9CYmbCMHb7YiHG9q/b7loDyCVSyBgTBPUwxUWKSj5yyG89+Z0LF5msK3BA==
X-Received: by 2002:a05:6a00:3ccd:b0:724:5aac:1687 with SMTP id
 d2e1a72fcca58-72469df14ecmr4348830b3a.20.1731606779192; 
 Thu, 14 Nov 2024 09:52:59 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a6e71e6sm1536637b3a.51.2024.11.14.09.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 09:52:58 -0800 (PST)
Message-ID: <39c4e148-242a-454a-9a67-8490025b5afa@linaro.org>
Date: Thu, 14 Nov 2024 09:52:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/54] accel/tcg: Split out tlbfast_{index,entry}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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
> Often we already have the CPUTLBDescFast structure pointer.
> Allows future code simplification.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index c1838412e8..e37af24525 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -131,20 +131,28 @@ static inline uint64_t tlb_addr_write(const CPUTLBEntry *entry)
>       return tlb_read_idx(entry, MMU_DATA_STORE);
>   }
>   
> +static inline uintptr_t tlbfast_index(CPUTLBDescFast *fast, vaddr addr)
> +{
> +    return (addr >> TARGET_PAGE_BITS) & (fast->mask >> CPU_TLB_ENTRY_BITS);
> +}
> +
> +static inline CPUTLBEntry *tlbfast_entry(CPUTLBDescFast *fast, vaddr addr)
> +{
> +    return fast->table + tlbfast_index(fast, addr);
> +}
> +
>   /* Find the TLB index corresponding to the mmu_idx + address pair.  */
>   static inline uintptr_t tlb_index(CPUState *cpu, uintptr_t mmu_idx,
>                                     vaddr addr)
>   {
> -    uintptr_t size_mask = cpu->neg.tlb.f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS;
> -
> -    return (addr >> TARGET_PAGE_BITS) & size_mask;
> +    return tlbfast_index(&cpu->neg.tlb.f[mmu_idx], addr);
>   }
>   
>   /* Find the TLB entry corresponding to the mmu_idx + address pair.  */
>   static inline CPUTLBEntry *tlb_entry(CPUState *cpu, uintptr_t mmu_idx,
>                                        vaddr addr)
>   {
> -    return &cpu->neg.tlb.f[mmu_idx].table[tlb_index(cpu, mmu_idx, addr)];
> +    return tlbfast_entry(&cpu->neg.tlb.f[mmu_idx], addr);
>   }
>   
>   static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


