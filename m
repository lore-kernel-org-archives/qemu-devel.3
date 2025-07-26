Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0F7C87FCE
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Jul 2025 01:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufTyR-0000M6-OO; Fri, 25 Jul 2025 21:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufTyP-0000L7-I7
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 21:45:17 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufTyN-0004RV-LK
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 21:45:17 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-234fcadde3eso36865385ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 18:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753494313; x=1754099113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K3UJpfLeEam0/WNPPwTDLPczYZtaXhE7u/qq6JbLQTs=;
 b=GfiYIFmlsv8Gg1Pt2juTWgb/fTb9DDplcjVV5lkSouBmLl9etARtlauDr2pLx61iGB
 nTBSgoCmwqpTOTBqQaA4QIAsILsf5X1OkfAaJx9GVe0Tb9p3YUiHkhjEIXlx57FsekW0
 RBJART91K+cJa5iyL85yVUnM38L/anIQs7pql3fDXtpr4jVvdbTK17rD9s/FevxpeeuE
 /0Q3tcomcMR1rukenkxCgp0ZqtFVf4SABUeKM2ISN6RiDNHaqRoYiJr+gQbCuYDzLowg
 hvpWW7y4nA6j79BLBH5l24KINiwtGTOwiZkWFjqAYXh+tyjtx9iXU/4iV7h7rliydePH
 njtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753494314; x=1754099114;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K3UJpfLeEam0/WNPPwTDLPczYZtaXhE7u/qq6JbLQTs=;
 b=ZUxiu86VBPbivvdb7Q0DSNEkrqSIsW5L48JhNbvNJICE8nlHctJW0nlqTV48fIisE1
 7GJOQ/g0fwltkEDWqhp89bQNmFqUcNPRwmsQMkrGn3lykMMPklnSnnAPOa1seuAvC9dQ
 eUXRlt9irBIdSWqbD0Zab8xQNLxMpg0zC1TKvLC3A9PweDFGAKXL270Ff3ms7Ryu47YW
 csL106KKj7pJT6b5p7pDFO+p1JXTMXF7H7OourcXZrY+SecXRLebRtAYWxRuM0grAgUy
 0fY/GLy81pCUTL5TMsve28GMZlcSISrqikOd5vKZkhXiB9h32zBmGl4vEI5VkqVcTlA1
 9D0g==
X-Gm-Message-State: AOJu0Yzw1OSPTmIlYkWZd5cP1vlbwA/EJfamLHt56SWQe2hXipCSK9Vk
 BxQjeVFxBiQSOLKQMJ5PoGfFPVnfLxbig2YOC5uG7HKxkVJkO+EdVBUN2Sl1Szexj8ArY4h45DZ
 zuD4k
X-Gm-Gg: ASbGnctps+oAfgE5ZtqjIOKgVEVT3pGI4Wc1xN9c1Sgqb+ir4aiIvVelegds6XyREQ2
 BAUhWfMTEd9sQp7c3vNE0m01g6RE7d9g3y4GQ9TnBHAUyymUPRbpcS3edPvM65hgb/wNPnkWaN4
 7j0qeQZqXZJtytFllwmZYCCWm+z5MHx/XZTeBYNYr4aTyVkOhOBc7oYUdUKdrl/y4rX4i/UGTEj
 0oklHH7Oqp6YLvgSEAixpZ6YP8PV5BJEubMCyS2W5DZVCMZfUAJi6p/zQPJF3xzFE4d7b9r5uXn
 me2RQcQjkZAABp50LMvKVMJWTGjgh1ry4gd7C8yqq6xBD4u205fBLfP+DZwoO//fT/Tdza/ZGQg
 FwnQ+IKTZLusQlS7c55RAebM/l/esCYiX0UgCsS/DzNs9hzvHNdbtdAf9OMY8rOlFNtcE9CxydI
 LF6ksyjMl/UQ/M
X-Google-Smtp-Source: AGHT+IFMzWSn4f8UzW1mD4hcZTRENVEWMYEPCwwK/KivG8u9JrMtOpKlwAGTd2vouc1DVYX708mepw==
X-Received: by 2002:a17:902:f68e:b0:235:ea0d:ae10 with SMTP id
 d9443c01a7336-23fb30b8503mr71408115ad.12.1753494313501; 
 Fri, 25 Jul 2025 18:45:13 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe5781aasm6400875ad.205.2025.07.25.18.45.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 18:45:13 -0700 (PDT)
Message-ID: <c75d79ab-97b8-464b-9774-a51de03a8e31@linaro.org>
Date: Fri, 25 Jul 2025 15:45:10 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/17] target/loongarch: Use correct address when flush
 tlb
To: qemu-devel@nongnu.org
References: <20250725013739.994437-1-maobibo@loongson.cn>
 <20250725013739.994437-14-maobibo@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725013739.994437-14-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 7/24/25 15:37, Bibo Mao wrote:
> With tlb_flush_range_by_mmuidx(), the virtual address is 64 bit.
> However on LoongArch TLB emulation system, virtual address is
> 48 bit. It is necessary to convert 48 bit address to 64 bit when
> flush tlb, also fix address calculation issue with odd page.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 715c5a20da..61cc19610e 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -96,6 +96,15 @@ static void raise_mmu_exception(CPULoongArchState *env, target_ulong address,
>      }
>   }
>   
> +/* Convert 48 bit virtual address from LoongArch TLB to 64 bit VA */
> +static inline target_ulong __vaddr(target_ulong addr)
> +{
> +    target_ulong high;
> +
> +    high = -(addr >> (TARGET_VIRT_ADDR_SPACE_BITS - 1));
> +    return addr + (high << TARGET_VIRT_ADDR_SPACE_BITS);
> +}

Don't use __ symbols.
Also, this function is

     sextract64(addr, 0, TARGET_VIRT_ADDR_SPACE_BITS - 1)


r~

