Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E152C54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 16:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rknzF-0007FI-AV; Thu, 14 Mar 2024 12:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rknyr-00078l-Ts
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 12:31:00 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rknym-0007DM-BO
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 12:30:57 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e6ee9e3cffso404665b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 09:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710433850; x=1711038650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QtvyLnExdEXPnyABwtveRZFaDo4tMagzQRp7gH+fACI=;
 b=fTAwAuT1Mv/BlhFOMDH17sCllfqHKXlewZPNSWtI09HKnzEhjpqc0S9bMG17E52HLH
 I7Am/1vrA0a+K4kSJvoMwoQrihJy4JwFov03GoCJ34BILi/DjvIZ8J5q8YutdxCt0vkx
 i/8i2K8m8MliLj8b0/lbG1AdhvvBBvyGX4hLGlJIHeQd00CtR2W0NUWyje3WanGtaoOD
 /FMtDzonRZNK82o6brSR7AKRhx8bNStjjpcNZTwRU/SP0MgN/PScDKfMeEvLlgxAW9Dy
 dUQEZQeAtYqPB0AlEAdZG8HjBTfISnFc87nDqwdI8haUV+iWj8hKRVAbr0DDu/68ICxM
 rNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710433850; x=1711038650;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QtvyLnExdEXPnyABwtveRZFaDo4tMagzQRp7gH+fACI=;
 b=XBaYgFp6oN7ckIsOE+/LziA0Aij2UXVyGVfNljRC0qccOuyComVh2qfRhsyLqHN6Ai
 VqLR+HYCSnUCnwnAomGxmLgt6f/gtZ7yCHYkRasp8GlsJO2i9mah0BWrFOYnx/wVD8gT
 94mIYSqD5VfJCXMiAQWzn5OKDav5JbDutF8kpFFx9K+vEK8MyP+ioo2CPWz86mMgNJe/
 0nqlM2185siT1L9B9RM7nW3X4Vml8VWfeoLHtUWRPtLFiV99O2t8FwCmLpftmVZTzySy
 eAJCeZNW8blzx3LRYt8qRFAjY/z7cHQWX9mW/esgM1SbxfCAoHegHghZgoK8k0AiXkpl
 pBpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU227lQFEb97bUnNZq3TijO/70UlWszrKYhUqzLV+Aj6hUZqty9sZyP6A3YHh9OsB5qxSJudnEa7ANEchAHfleA0tA97Qw=
X-Gm-Message-State: AOJu0YxwIB9gNSOBeKwmKh99p+gfTMdeDpz/Yx2b2Z7e2rW+F4FsYWn7
 t6MXeyrUswS1928MqYXqC2y7B7hQrYLP61sDVNz3gNAFv7E8yX/ekWIXIuwy2w0=
X-Google-Smtp-Source: AGHT+IHYD26jJ2d8YLRBUQ/tHMau8NdzItL/LUHuYy5n+Z/INlF8iaMUhH3fjZrcjSGO65BEevX3dg==
X-Received: by 2002:a05:6a20:a103:b0:1a3:484d:89ca with SMTP id
 q3-20020a056a20a10300b001a3484d89camr1420547pzk.16.1710433850273; 
 Thu, 14 Mar 2024 09:30:50 -0700 (PDT)
Received: from [192.168.0.227] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 n188-20020a6327c5000000b005dc491ccdcesm911586pgn.14.2024.03.14.09.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 09:30:49 -0700 (PDT)
Message-ID: <60733d71-daba-4f4a-a184-357526a3b3a0@linaro.org>
Date: Thu, 14 Mar 2024 06:30:45 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/1] target/loongarch: Fixed tlb huge page loading issue
Content-Language: en-US
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, zhaotianrui@loongson.cn,
 yijun@loongson.cn, wuruiyang@loongson.cn
References: <cover.1710379781.git.lixianglai@loongson.cn>
 <0e940b2aee9a5c29bb41d6a9611955482d250325.1710379781.git.lixianglai@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <0e940b2aee9a5c29bb41d6a9611955482d250325.1710379781.git.lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/13/24 15:33, Xianglai Li wrote:
> +    if (unlikely((level == 0) || (level > 4))) {
> +        return base;
> +    }
> +
> +    if (FIELD_EX64(base, TLBENTRY, HUGE)) {
> +        if (FIELD_EX64(base, TLBENTRY, LEVEL)) {
> +            return base;
> +        } else {
> +            return  FIELD_DP64(base, TLBENTRY, LEVEL, level);
> +        }
> +
> +        if (unlikely(level == 4)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Attempted use of level %lu huge page\n", level);
> +        }

This block is unreachable, because you've already returned.
Perhaps it would be worthwhile to add another for the level==0 or > 4 case above?

> @@ -530,20 +553,34 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>       CPUState *cs = env_cpu(env);
>       target_ulong phys, tmp0, ptindex, ptoffset0, ptoffset1, ps, badv;
>       int shift;
> -    bool huge = (base >> LOONGARCH_PAGE_HUGE_SHIFT) & 0x1;
>       uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
>       uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
> +    uint64_t dir_base, dir_width;
>   
>       base = base & TARGET_PHYS_MASK;
> +    if (FIELD_EX64(base, TLBENTRY, HUGE)) {
> +        /*
> +         * Gets the huge page level and Gets huge page size
> +         * Clears the huge page level information in the address
> +         * Clears huge page bit
> +         */
> +        get_dir_base_width(env, &dir_base, &dir_width,
> +                           FIELD_EX64(base, TLBENTRY, LEVEL));
> +
> +        FIELD_DP64(base, TLBENTRY, LEVEL, 0);
> +        FIELD_DP64(base, TLBENTRY, HUGE, 0);
> +        if (FIELD_EX64(base, TLBENTRY, HG)) {
> +            FIELD_DP64(base, TLBENTRY, HG, 0);
> +            FIELD_DP64(base, TLBENTRY, G, 1);

FIELD_DP64 returns a value.  You need

     base = FIELD_DP64(base, ...);


r~

