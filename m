Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A544D6A226
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeyT-0008EC-Ur; Thu, 14 Nov 2024 13:53:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeyR-000866-NG
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:53:47 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeyQ-0007ec-4t
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:53:47 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-720be27db27so817224b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610425; x=1732215225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2NdBoyI9bBajoNAsWbKoQQ59AGgp1fbRrIuXAIXjhnk=;
 b=bTrkjV2sI9Rz+XH66S3DAyAQAKe9ftqSkX4Cj+eX9vzYz6nx8LwNteqpPzwRV17mLZ
 BYKWBdxZsoMC5rg1v7MUn6w3sjzZHT7uaJF7YsTSBVYwo7qDx/k7zpCUD89zobspfFIk
 720i2n/Lh1bCatdva7KxXUnJeCw7W7S+5vIyY63DVbYvPbuYwiiIXO/g3NzfStevUADD
 hMGHMw8y94hbqK4j11R4RNAha1kDaKi7NxR7ayzvm3OOyHNytADqIQmN0+gpuKm/IC17
 SOhjBSnR1kSaKa6ACeGvmYWgKIDmFMzg48Ka95GuGEJk9Sg/1QMe1u2Td+P+toch0fEE
 pnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610425; x=1732215225;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2NdBoyI9bBajoNAsWbKoQQ59AGgp1fbRrIuXAIXjhnk=;
 b=FUqaScVknpJ+IqB2/DmC2DG8qLdzVHxJLSp044BtDZelmkqyzEZRN6nQD4fiKm/q3R
 pAn4NJTwA/jatPXQWz/eayTdE6Yc5JGW1PuCZzeW71iF7REEgJzHO8TbNzYbnVC06ugQ
 51lw8oCwmZfCIvm7fvkSUL13BFzFPQTEeBMYVOFdCm4SDmOIoHzDv2aj44zM3nz/gCDJ
 sGFYy9Mqyd7V65W6ZviaILgyTWWQGQXz/8Q7Mlxs2Di+aQhCfwD1i9I9CD3cjzjxA6+H
 LRgaCqzpM9pi6asCWqikBBKrV0dChK8zfTALi5a6s4m4MthNEmrNPpuVT5CWZMieyjLA
 L+Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuYx0s6Ux1fHPvjTgoB3MvDfHFbZt6PFLfsEqtihb41+mvjTnOAKoQjOd++cA2fWVzbYlidVg3Vu53@nongnu.org
X-Gm-Message-State: AOJu0YyrzVGB8ylzkebRFl71qsN/5gtunRR+fgm9l+ow7JOdwpnWWfpT
 8GlvwWefcWRVpCKFFns4hdkAID3teCrGB+it3KbMA+NGEnQ1O487xkp7iLiGXfo=
X-Google-Smtp-Source: AGHT+IHFm8zSlgD+MY93wxfsQgOhJifaFjfdGRxh97v7KHml5mlNZKkZEqvD/vjjsJvVc/TfwJRx7g==
X-Received: by 2002:a05:6a00:9285:b0:71e:7294:bbc4 with SMTP id
 d2e1a72fcca58-7244a54142dmr16250388b3a.13.1731610424643; 
 Thu, 14 Nov 2024 10:53:44 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a5ceda0sm1592394b3a.1.2024.11.14.10.53.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:53:44 -0800 (PST)
Message-ID: <63fbf6cc-b601-4ed2-9f87-c7ef5588c7b1@linaro.org>
Date: Thu, 14 Nov 2024 10:53:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 39/54] target/m68k: Do not call tlb_set_page in
 helper_ptest
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-40-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-40-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 11/14/24 08:01, Richard Henderson wrote:
> The entire operation of ptest is performed within
> get_physical_address as part of ACCESS_PTEST.
> There is no need to install the page into softmmu.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/helper.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 1decb6f39c..0a54eca9bb 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -1460,7 +1460,6 @@ void HELPER(ptest)(CPUM68KState *env, uint32_t addr, uint32_t is_read)
>       hwaddr physical;
>       int access_type;
>       int prot;
> -    int ret;
>       target_ulong page_size;
>   
>       access_type = ACCESS_PTEST;
> @@ -1476,14 +1475,7 @@ void HELPER(ptest)(CPUM68KState *env, uint32_t addr, uint32_t is_read)
>   
>       env->mmu.mmusr = 0;
>       env->mmu.ssw = 0;
> -    ret = get_physical_address(env, &physical, &prot, addr,
> -                               access_type, &page_size);
> -    if (ret == 0) {
> -        tlb_set_page(env_cpu(env), addr & TARGET_PAGE_MASK,
> -                     physical & TARGET_PAGE_MASK,
> -                     prot, access_type & ACCESS_SUPER ?
> -                     MMU_KERNEL_IDX : MMU_USER_IDX, page_size);
> -    }
> +    get_physical_address(env, &physical, &prot, addr, access_type, &page_size);
>   }
>   
>   void HELPER(pflush)(CPUM68KState *env, uint32_t addr, uint32_t opmode)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


