Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515E4C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 10:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1OfI-0000jG-H3; Mon, 29 Apr 2024 06:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OfC-0000il-0x
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:55:14 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Of9-0005ml-Qs
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:55:13 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-343c2f5b50fso2797888f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 03:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714388110; x=1714992910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LP2Wu0Dw54Q00OIOEd9jYBjLmXzE8lcBDZN927nb1oE=;
 b=QiT6AWaUXox9UwBUyZls0AGLN1V8fj2shWSRHQitYs4GSVEFJ+tRBH2IDSgzZ0sd7c
 b78lsduzIgON0WCTj3rREsTOkoVEhyu+UARa6HlOZi6vUgi41PNzKEsIgmUg702Ekjow
 H5B14p8FbeD/SDkODEoLNHB0Oigspp6NoOhz3RcUX/QXkhpBlB0TcAKVMYMtEB9SKTuk
 Gq+WvGpPXschWDQC3E9v3T8t+68Rk4v0J2ht88/CjhALgJN5t6grUvpmI0RYIHoJT+Kt
 FkNRaQbJq56DIjK/Q7dpBMwqz2NDy/KvxHDWaLfc6gDwqMo2Y+N+qBlr3YnFVtscUJqB
 DEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714388110; x=1714992910;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LP2Wu0Dw54Q00OIOEd9jYBjLmXzE8lcBDZN927nb1oE=;
 b=bB5rcMfI6tTfUtuaPa7dQ1oUhLs5NOgfk4/yQaq2sCgHypNSlG6hnUnw0YApSI3qp6
 2EUcNvTKBcBP36yxKol1gdIqcrNw4Quf7VYja/6RXi3261lC7f6kQKLHCU6nqcPY1/d6
 qca0zHHTJVs++GWdgNM1d3XrKcJEtAzYS4WDMR68q5WFfAIYqdcPM/t7AU0SF202N54w
 hIHIgEQ8/ubQeE8pWdsKdJF6klrvdLTdCOCckQ+ZA1saDjvPkdkAwY2XCFPTyhG+utq8
 EpXaNSmeyH6uTbi7/ga3+PBe7H6nNL92QgiQCsiy9uIhmb6kXWe1H2FrIb9C9vuEpJFz
 2k0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDx1xe7u74R8OW46mojSBgCd2/NuD2OkHVwhFWzvyLg45qYe46n4SzoLET0br2NYLBzphYlAuNHhhXlj3SfhcZG55KjM8=
X-Gm-Message-State: AOJu0YzVR2Awvy8X7Gpvy+DBk9X2NObzVA14A73ys6xuKM2uygliZrBM
 iWi8TWCLTfMV0J7oRdy9hWSTgySVjczZuzdbUlAMndtGBSkAjprRSIo2c1y+O3qeEjYfefnSzAJ
 LJt8=
X-Google-Smtp-Source: AGHT+IHzK/irlEJPmlWh0zdWn8HG2ihhUElOH+dQPuaXIvVvL87wf5iLR7WthyaSL5Zp5gXupxHj0g==
X-Received: by 2002:a5d:564a:0:b0:34c:b8fa:976a with SMTP id
 j10-20020a5d564a000000b0034cb8fa976amr4130495wrw.59.1714388109851; 
 Mon, 29 Apr 2024 03:55:09 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 b7-20020adff907000000b0034b3394f0e1sm18685009wrr.10.2024.04.29.03.55.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 03:55:09 -0700 (PDT)
Message-ID: <b6b4cc3a-45e9-4516-9faa-942795ad9c36@linaro.org>
Date: Mon, 29 Apr 2024 12:55:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/33] target/riscv: Use translator_ld* for everything
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-30-richard.henderson@linaro.org>
Content-Language: en-US
Cc: qemu-riscv <qemu-riscv@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424233131.988727-30-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cc'ing qemu-riscv@

On 25/4/24 01:31, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/translate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index c999e942e1..2c27fd4ce1 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -20,7 +20,6 @@
>   #include "qemu/log.h"
>   #include "cpu.h"
>   #include "tcg/tcg-op.h"
> -#include "exec/cpu_ldst.h"
>   #include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "exec/helper-gen.h"
> @@ -1082,7 +1081,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
>       CPUState *cpu = ctx->cs;
>       CPURISCVState *env = cpu_env(cpu);
>   
> -    return cpu_ldl_code(env, pc);
> +    return translator_ldl(env, &ctx->base, pc);
>   }
>   
>   /* Include insn module translation function */
> @@ -1243,7 +1242,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>               unsigned page_ofs = ctx->base.pc_next & ~TARGET_PAGE_MASK;
>   
>               if (page_ofs > TARGET_PAGE_SIZE - MAX_INSN_LEN) {
> -                uint16_t next_insn = cpu_lduw_code(env, ctx->base.pc_next);
> +                uint16_t next_insn =
> +                    translator_lduw(env, &ctx->base, ctx->base.pc_next);
>                   int len = insn_len(next_insn);
>   
>                   if (!is_same_page(&ctx->base, ctx->base.pc_next + len - 1)) {


