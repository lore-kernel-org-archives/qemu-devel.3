Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3333CC54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 19:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riJQM-0003YB-Lu; Thu, 07 Mar 2024 14:29:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riJQK-0003Xx-Vb
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 14:29:00 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riJQJ-0000NX-3u
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 14:29:00 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6da9c834646so1167867b3a.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 11:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709839737; x=1710444537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6I8Gj69XpDH4y9gYASJPEZ8wsFM1peuk84ztipc620E=;
 b=WYMnM1gEn2ufnoAAbnYlbJyDLld9tcUoIrw5HZWQkMmEFaukgWEzxnnFyLAaacskfl
 DyHiKY1iJegKlGDTojtTrDvMZ1dfYQx9x0V6f/oed/vvkH+pEPnTPOlDVOC6D+zQLWGX
 SnFqEedPmVBY/Ewmd8qWwUeXWTw/RqyXjwmd10J/jLll/xxtek+QMqC9h0GGakoRnDfp
 +F/D/PSzVHLYmb/arsE/E6OK9A2DlYcxqZeNcwxNa/X4ZV4ECeyHnH0tiTJXRHDbf1B2
 mulSHccmUuTMmEdmh+p0gvsrDTdN51PI8UphGb1D8kjxuDX31kW64FXgqaPx5DHT7rql
 8sOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709839737; x=1710444537;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6I8Gj69XpDH4y9gYASJPEZ8wsFM1peuk84ztipc620E=;
 b=Ds0pkpcerdqlMZo7dv6VVTKzsbXMd6yZJg+KRP9eRgPbqAXym1oBykRbV8ttU4eSOm
 Mg2prx0GIu+N4HjzdTV8waKviFrz0ojAvmI5Nq93XVUnDzT6QyOiWWvK+JTwDzbcNVzA
 LgfVwGTmx9VVsG6kCQ2sK01m3wZFjWX/VfvHThm6nWIYg0qWlMxMwjy20r2Okx82xQzC
 zjh6FwOf2YevbCdXhnWiJPCMn0Y5hXpdbw/7cMexdJApYU06WP+KelwSIhF7Nt8Putyt
 jlCDY0TEsA5rnyvp0p1sgTMTdoZN7HoTU0R1KGDmM395yRDTYoKhXNrlSpQpNdZCXNTE
 zJ1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR4Omyd+fKZEUNJu0pb3oZBCpuvG18CoClxNzz/WLTY004CRrlGn8Sp0HnHd1jjXweJMDiu//uD96847Tegh9E8GEu00E=
X-Gm-Message-State: AOJu0YwgGWdHf2apmrqSzyzNXsWo1h+zqqsZcociVHKA3iGP1JMHGWUM
 1bnoHMn2iJfgONh0dxSr93ru/IJc146v4W+m32J9DHLH/xeYT8Kx5rQnOKbRHgRVMDFVlQVRXyB
 D
X-Google-Smtp-Source: AGHT+IFi771x2uJeGuoQqAyAUqHc5tmbbXQce5lorcx4Oi6gVeAflv3LCScCuY6TaLBo/UvcVbRCRg==
X-Received: by 2002:a05:6a00:1707:b0:6e3:c568:47aa with SMTP id
 h7-20020a056a00170700b006e3c56847aamr25939468pfc.24.1709839736656; 
 Thu, 07 Mar 2024 11:28:56 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 o189-20020a62cdc6000000b006e5597994c8sm13424894pfg.5.2024.03.07.11.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 11:28:56 -0800 (PST)
Message-ID: <167331cd-068b-470f-b08c-6687e426bd15@linaro.org>
Date: Thu, 7 Mar 2024 09:28:52 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/1] target/loongarch: Fixed tlb huge page loading issue
Content-Language: en-US
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, zhaotianrui@loongson.cn
References: <cover.1709796364.git.lixianglai@loongson.cn>
 <de249feeab14b46d4b7bd842335a4e6e4b654681.1709796364.git.lixianglai@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <de249feeab14b46d4b7bd842335a4e6e4b654681.1709796364.git.lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 3/6/24 21:37, Xianglai Li wrote:
> When we use qemu tcg simulation, the page size of bios is 4KB.
> When using the level 2 super large page (page size is 1G) to create the page table,
> it is found that the content of the corresponding address space is abnormal,
> resulting in the bios can not start the operating system and graphical interface normally.
> 
> The lddir and ldpte instruction emulation has
> a problem with the use of super large page processing above level 2.
> The page size is not correctly calculated,
> resulting in the wrong page size of the table entry found by tlb.
> 
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> Cc: maobibo@loongson.cn
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> Cc: zhaotianrui@loongson.cn
> ---
>   target/loongarch/internals.h      |  8 +++
>   target/loongarch/tcg/tlb_helper.c | 92 +++++++++++++++++++++++--------
>   2 files changed, 76 insertions(+), 24 deletions(-)
> 
> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
> index a2fc54c8a7..55ceb4c079 100644
> --- a/target/loongarch/internals.h
> +++ b/target/loongarch/internals.h
> @@ -16,6 +16,14 @@
>   #define TARGET_PHYS_MASK MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS)
>   #define TARGET_VIRT_MASK MAKE_64BIT_MASK(0, TARGET_VIRT_ADDR_SPACE_BITS)
>   
> +/*
> + * The [13..14]bits of the entry base address of the lddir/ldpte
> + * directive are used to represent the level of the large page
> + * when processing the huge page entry
> + */
> +#define HUGE_PAGE_LEVEL_SHIFT   13
> +#define HUGE_PAGE_LEVEL_MASK MAKE_64BIT_MASK(HUGE_PAGE_LEVEL_SHIFT, 2)

This would be cleaner using <hw/registerfields.h>, e.g.

FIELD(LDDIR, HUGE, 6, 1)
FIELD(LDDIR, LEVEL, 13, 2)

> +static int get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
> +                              uint64_t *dir_width, target_ulong level);

Very often you can place the new function just before its first use so that no prior 
declaration is required.

Returning a bool with true for success and false for failure is preferred over 0/-1.

> @@ -487,6 +490,16 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>       int shift;
>       uint64_t dir_base, dir_width;
>       bool huge = (base >> LOONGARCH_PAGE_HUGE_SHIFT) & 0x1;
> +    uint64_t huge_page_level = base & HUGE_PAGE_LEVEL_MASK;
> +
> +    if (huge) {

if (FIELD_EX64(base, LDDIR, HUGE))

> +        if (huge_page_level) {

if (FIELD_EX64(base, LDDIR, LEVEL))

> +        } else {
> +            huge_page_level = (level & 0x3) << HUGE_PAGE_LEVEL_SHIFT;
> +            return base | huge_page_level;

return FIELD_DP64(base, LDDIR, LEVEL, level);

I suppose setting bit [6] with level == 4 is a "don't do that" sort of programming error. 
You could log the error here, perhaps:

     if (unlikely(level == 4)) {
         qemu_log_mask(LOG_GUEST_ERROR, "Attempted use of level 4 huge page\n");
     }


> @@ -495,30 +508,10 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>       shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
>       shift = (shift + 1) * 3;
>   
> -    if (huge) {
> -        return base;
> -    }
> -    switch (level) {
> -    case 1:
> -        dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_BASE);
> -        dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_WIDTH);
> -        break;
> -    case 2:
> -        dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_BASE);
> -        dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_WIDTH);
> -        break;
> -    case 3:
> -        dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_BASE);
> -        dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_WIDTH);
> -        break;
> -    case 4:
> -        dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_BASE);
> -        dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_WIDTH);
> -        break;
> -    default:
> -        do_raise_exception(env, EXCCODE_INE, GETPC());
> +    if (get_dir_base_width(env, &dir_base, &dir_width, level) != 0) {
>           return 0;
>       }

I believe that we should not raise an exception here at all.  This illegal instruction 
exception is based on the LDDIR immediate operand, so we should have diagnosed this error 
and raised an exception in trans_lddir().

Therefore the default label should use only g_assert_not_reached(), and there need not be 
a error return from get_dir_base_width at all.


> @@ -534,17 +527,38 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>       bool huge = (base >> LOONGARCH_PAGE_HUGE_SHIFT) & 0x1;
>       uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
>       uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
> +    uint64_t dir_base, dir_width;
> +    uint64_t huge_page_level;
>   
>       base = base & TARGET_PHYS_MASK;
>   
>       if (huge) {
> -        /* Huge Page. base is paddr */
> +        /*
> +         * Gets the huge page level
> +         * Clears the huge page level information in the address
> +         * Clears huge page bit
> +         * Gets huge page size
> +         */
> +        huge_page_level = (base & HUGE_PAGE_LEVEL_MASK) >>
> +                          HUGE_PAGE_LEVEL_SHIFT;
> +
> +        base &= ~HUGE_PAGE_LEVEL_MASK;
> +
>           tmp0 = base ^ (1 << LOONGARCH_PAGE_HUGE_SHIFT);
>           /* Move Global bit */
>           tmp0 = ((tmp0 & (1 << LOONGARCH_HGLOBAL_SHIFT))  >>
>                   LOONGARCH_HGLOBAL_SHIFT) << R_TLBENTRY_G_SHIFT |
>                   (tmp0 & (~(1 << LOONGARCH_HGLOBAL_SHIFT)));
> -        ps = ptbase + ptwidth - 1;
> +
> +        huge_page_level++;

Why are you incrementing the level?

I think you want

     level = MIN(level, 1);

Google translates the documentation for LDPTE as "bits [14:13] ... should be a non-zero 
value".  I don't know if "should" is precisely correct here (english technical documents 
prefer "shall" or "may" to indicate a hard requirement vs optional behaviour).  The 
document does not appear to say what happens if the value is zero.

Since an earlier version of the specification did not have bits [14:13], my suspicion is 
that the the current version of the specification is intended to be compatible, which 
would map [14:13] == 0 to level == 1.

In any case, incrementing the level such that [14:13] == 1 -> level == 2 definitely seems 
wrong.


r~

