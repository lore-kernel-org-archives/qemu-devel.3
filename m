Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0214CED611
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 22:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syfai-0003Of-FB; Wed, 09 Oct 2024 18:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syfag-0003OH-5k
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 18:55:34 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syfae-000789-KA
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 18:55:33 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20ba8d92af9so2130965ad.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 15:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728514531; x=1729119331; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=35YnWnvG+1k+e2SAdzafruz3LcIebfaWMB1FSUR/Kvg=;
 b=Q3pZJeUM0SOCh6O4rZx60FMyHgNgEA0X/6WVRIkIkHu0EmguIQ9VyPDTyZGBXRJRxJ
 NFTLaF2Iwalp4BHU2DWt/QicLzr2ut2a0eleAVbFWxRRIhbeb+UaGzQmu+LOMgOs6aRf
 SSoegqWjE1WtnNxviH75zommYY2T/Twi2lD9IR5Xa3hgCV+D2MPCcQ8Frsj/CdOx0WlG
 0R0dTQIrGX9DjFQTLgVZ/Ppeeh3yDWp3NIBbPSaUk1wt8LMGF57ll1uxWmdYrgmQA56m
 XDSsG+zE6zpLmiv6a+lFdR30BVoknd13Unr1D0ryDH13GXb83nN4WEfOt/a0a/+TbZdV
 CAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728514531; x=1729119331;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=35YnWnvG+1k+e2SAdzafruz3LcIebfaWMB1FSUR/Kvg=;
 b=CmcCDdwDA1DTB+axJZXrl/N8V3Jleeac97LcNYhyIEK/8OHnH03OwGjD2JhIswWLJ5
 uS6xaQGlmE+WSn1FDf8XlOkXvqwmI2GVplAgwV0+FZYrKseDST7/CLv3F5bolVsIBvjO
 juWVfmXCXR/f/dTUa9Ey5f5q/GGJyDZ4b+RTPAktSqFACxzRGYZLw8kJZZhCPP5P/HkI
 P5Cd3qIHOInVnx8NjxxsRS4AOlaJe2BDkKuGWdfU/kCxYB4SyFbAMO86eokrbfYT214j
 Ue20oJEcDX01SmLEo0/78w6Mo3PePmJATdhKezrf7nMKT0y50D0DGWeeCowWJxIgC3OE
 dQhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg0J+oG0yXcGlIGLOjIYO4ui1hqyXZxZGTfnKUbatckYVn2sEm7Waebiz85sKNdl5BRp/F0JvN86yv@nongnu.org
X-Gm-Message-State: AOJu0YzOPGeQFlPNUEuQo09kxefFC6r18clNNMMjkdzkarcROZwQSTc2
 lhpQXsM18E/hx0RlnOht+PNxD+f7Sah8XFtgcmOArzGGzN8nKhGe8sIGKJy6o4uXYhqWjD8qvax
 UIiQ=
X-Google-Smtp-Source: AGHT+IHuZW8cK1sNg2ADyWzjI5f/5CnNfNDJZQ868VBN4H6NeGYEBxTuD1QeVbmnlRIaj0HA8lgzYQ==
X-Received: by 2002:a17:902:c405:b0:20b:dad8:8aec with SMTP id
 d9443c01a7336-20c6377fdbfmr63827235ad.48.1728514530997; 
 Wed, 09 Oct 2024 15:55:30 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1398a459sm75250465ad.267.2024.10.09.15.55.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 15:55:30 -0700 (PDT)
Message-ID: <c483b040-31da-4d48-a78b-08c660f821a5@linaro.org>
Date: Wed, 9 Oct 2024 15:55:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/23] accel/tcg: Split out tlbfast_{index,entry}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-4-richard.henderson@linaro.org>
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

On 10/9/24 08:08, Richard Henderson wrote:
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

