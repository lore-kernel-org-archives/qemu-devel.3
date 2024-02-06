Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29ED7C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 20:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXRzO-0006ft-Rs; Tue, 06 Feb 2024 15:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXRzN-0006fQ-9O
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:24:17 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXRzL-0005kX-9Q
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:24:17 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d8ef977f1eso46118505ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 12:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707251053; x=1707855853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xMLnpEwC/pwWC/ZQ1056pXNvkQfDivNGGlGItWvvw54=;
 b=uqBw+dfsdzCqXeTFRwxDrk5LX+ig0fUeAth0QTjMWIYuj07P/A+GDzJzb1X864dV6q
 /pNx9mIgyJFW/FK3TRkEx3E5J6u3NSb2APYWKS7jBOsKXQe+VhIW5XIoeAMH1Jwqmqpr
 O50xU2FAC7fluQ7l79xFcbPB3Nk95sXJSciqKuuodUXS4hsgkZ2uPQ1m2gMQrzlJxuFq
 XXHoNUTDSzyZO1pCBkoY7KrQVf3yI1ByQBd0QpGWyewHso9d4pzTEFCn1/07Xp6ZTPIg
 8j6zZBQG8+HOksQMmlHRiLiS0miGsfVuuL1gvHU4M1nWVa16mOBCDgfbuDKQQV0fhJJg
 TKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707251053; x=1707855853;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xMLnpEwC/pwWC/ZQ1056pXNvkQfDivNGGlGItWvvw54=;
 b=sEzkRUfNqIfbC+vQ0IcXNCMTnd7QtY67L+kqc5ZuEWfZnqAfXwmA0Ee0eg9Fjx3/PY
 XuJtLDOan1DlttRr31SbnzntCSE9Z7p+pksObRUF8M0B38kC0KC3SaDwmAGoPpwFsxXs
 IOoIclrycArIvLoppRsGHAuRlGZn9YmvufjBZ4ap49OMIvXcPsXEiuT/r2FCsKuoafXG
 KCwJde98xcOCDb2vZeH2f/sZ0yjmVoa916s7Xjg6a+1P1oCrd5+4PIMXx7PlQLxud3Mv
 Ty7HDNaIr72xVFQ4hQPy8ny8YdOlutlQ4aJ4diIVargbnbF3y7PTQL8gzGdfi1ZAQ4FG
 em7g==
X-Gm-Message-State: AOJu0Yw/aUwVpGJQt/Ss+AejKe1BHgTDm+8Pfu8B2mhtZxURiVDCNq1m
 lLkuGcICrX3FvWAsZ+IFS56dsSeYzpcFr5UDsc0Qtei0ZhgYq46gYsdRXUSwDiPQY/7LvvrIZcB
 Sad0=
X-Google-Smtp-Source: AGHT+IH2ii7CJ/bROgsLUKKmwF76pavKC2AAX5TiE/wZwLxVKnE2mf1HQEyD/I+4zcXmRiF5XnuX7Q==
X-Received: by 2002:a17:902:f7c3:b0:1d9:855a:3130 with SMTP id
 h3-20020a170902f7c300b001d9855a3130mr2175024plw.33.1707251053582; 
 Tue, 06 Feb 2024 12:24:13 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVLaJy2q/k3ku6tuhzLL/E5aTXZ/QdwFz3wh1+/2eTqd7AN7W+OkxrWo6kmPOAKQm15rLY8KYbJZ9KGZ020zlXCXwtSH29A7wxZPi4S20iGAHnu3Q9qfTbavKjdSkZcCLBANACJACVoF3aI9uTd3aWm0by9XhNLxux9asRaBKFReLniT/42nOTcRo+YRS+zfgYWVQ6pTaXtF5S15L9WkSh/2qLLpHB7H0L+tHVyMkA5GYC+3qEYLpGj4PDEB33HEbLWwbHArwqnen+cYPIVi2mOYe/ZaaLiuc5OKK9TFOPm3TPfUUKTJbXWE2tcPPIVp8tr+Ci5JUh9
Received: from [192.168.0.100] ([43.252.112.200])
 by smtp.gmail.com with ESMTPSA id
 mq8-20020a170902fd4800b001d9ba3b2b33sm2303677plb.163.2024.02.06.12.24.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 12:24:13 -0800 (PST)
Message-ID: <162e0b5c-ed98-4e84-af6e-9fdaea0dcc04@linaro.org>
Date: Wed, 7 Feb 2024 06:24:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Update $pc after linking to $ra in
 trans_cm_jalt()
Content-Language: en-US
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>
References: <20240206131911.10998-1-jason.chien@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240206131911.10998-1-jason.chien@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 2/6/24 23:18, Jason Chien wrote:
> The original implementation sets $pc to the address read from the jump
> vector table first and links $ra with the address of the next instruction
> after the updated $pc. After jumping to the updated $pc and executing the
> next ret instruction, the program jumps to $ra, which is in the same
> function currently executing, which results in an infinite loop.
> This commit reverses the two action. Firstly, $ra is updated with the
> address of the next instruction after $pc, and sets $pc to the address
> read from the jump vector table.

This is unlikely to be correct in the case the vector table read faults,
leaving $ra updated.

I guess this got broken with CF_PCREL.  Anyway, the solution is to use a temporary...

> -    /*
> -     * Update pc to current for the non-unwinding exception
> -     * that might come from cpu_ld*_code() in the helper.
> -     */
> -    gen_update_pc(ctx, 0);
> -    gen_helper_cm_jalt(cpu_pc, cpu_env, tcg_constant_i32(a->index));

... here and then ...

> @@ -307,6 +300,13 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_cm_jalt *a)
>           gen_set_gpr(ctx, xRA, succ_pc);
>       }
>   

... copy the temp to cpu_pc here.

>       tcg_gen_lookup_and_goto_ptr();
>       ctx->base.is_jmp = DISAS_NORETURN;
>       return true;



r~

