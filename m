Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2529C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 21:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roVYi-0004oY-DO; Sun, 24 Mar 2024 17:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roVYg-0004mY-51
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 17:39:14 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roVYe-0005zJ-Ki
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 17:39:13 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29c7512e3b8so2892549a91.1
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 14:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711316351; x=1711921151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EahoKhcDddHjnORZFLTEk9Ewz0U68Dqhy4UVFNwpKns=;
 b=wIrlRbRhInFrhydkDUgRms2SqCIFsztgkRiBOHFbvx2JxggtWaDYyijOqcfcAiMmBd
 7fbgNqFToNci8gQbK0xRamHP5aCnZTq8h5VRxZOM+GLBeMMhJ3Sll/8Dl1fKsSZ2zyLa
 RVQI5g6+i2twwajCr4vJG2wTnbQkdJlmzyPZg9F3vLrGk2IYzUHZiY2SHHbFuxzoJ9pw
 2lfPhy6OOyXy4DQ/ssnEQtCvZRf2dswR+uDxlGhhA5sI1nOzjiibJHtnQ8LXI/2XgUbQ
 4OnBT8bWnN58fZBFoCa/jnChmbAafnUlhogwFMgxYCR6uyp3a5WX6rTb3L6Dg5XgcYdX
 5O8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711316351; x=1711921151;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EahoKhcDddHjnORZFLTEk9Ewz0U68Dqhy4UVFNwpKns=;
 b=Tld33FFfCbZ7DqNoulb0M9JhYwltL96pPmA7l09LumB4zimav3t3xj8Fyc8cA+H6WD
 SucmVYSLtCk5GeKYAtgWnudbqwjF1AbO/+wShQP7ePssux5N8FTKQ+/a/GoP8EzCumPZ
 FIU8AvO//ThyZtJy4wDeL9xnM5Y69f/sAXIpwMP2DUQiIuiL2mWW1WZSrwzPZABF0XoB
 /D62SYj6sw2sy540aQ672gGQi3lsVf5yx/HNVeRdY7e2vFigglL50+kb+p3h/qY59di7
 yTDO6joce5+BC9EpuwPjiG8dbdlfoaf7s7LaCOJ65N7aSnsuADbcB5wcDfcBh1zXLufx
 rhEg==
X-Gm-Message-State: AOJu0YzDsxjHXa/mzBnKHxNPOF3/riBUSmB0X0qNSlufJYobQRqeQIX5
 ubpCYsc9kfa0S9XOBxbhUdQM+eR2eieWJ/7e2eoXrgMZLKaBhGlIFqXCS6B43ws=
X-Google-Smtp-Source: AGHT+IEvJZsK1HyVhU4Kira+vulnq7L0zjIsp+xFZoyQBbCgqrkTGniFaq7TNj/91qVzScLCm4mg7A==
X-Received: by 2002:a17:90b:806:b0:2a0:4bc9:a4e0 with SMTP id
 bk6-20020a17090b080600b002a04bc9a4e0mr4100611pjb.4.1711316350824; 
 Sun, 24 Mar 2024 14:39:10 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 em13-20020a17090b014d00b0029f8d8db93esm9061308pjb.19.2024.03.24.14.39.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Mar 2024 14:39:10 -0700 (PDT)
Message-ID: <c26dd647-bf03-4ade-8266-e1c653554110@linaro.org>
Date: Sun, 24 Mar 2024 11:39:06 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/hppa: fix building gva for wide mode
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240324080945.991100-1-svens@stackframe.org>
 <20240324080945.991100-4-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240324080945.991100-4-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 3/23/24 22:09, Sven Schnelle wrote:
> 64 Bit hppa no longer has a fixed 32/32 bit split between space and
> offset. Instead it uses 42 bits for the offset. The lower 10 bits of
> the space are always zero, leaving 22 bits actually used. Simply or
> the values together to build the gva.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   target/hppa/mem_helper.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> index 84785b5a5c..6f895fced7 100644
> --- a/target/hppa/mem_helper.c
> +++ b/target/hppa/mem_helper.c
> @@ -523,13 +523,16 @@ void HELPER(itlbp_pa11)(CPUHPPAState *env, target_ulong addr, target_ulong reg)
>   }
>   
>   static void itlbt_pa20(CPUHPPAState *env, target_ulong r1,
> -                       target_ulong r2, vaddr va_b)
> +                       target_ulong r2, uint64_t spc, uint64_t off)
>   {
>       HPPATLBEntry *ent;
> -    vaddr va_e;
> +    vaddr va_b, va_e;
>       uint64_t va_size;
>       int mask_shift;
>   
> +    va_b = off & gva_offset_mask(env->psw);
> +    va_b |= spc << 32;

Actually, no, these instructions don't form a GVA in the normal fashion:

space ← ISR;
offset ← cat(ISR{32..63},IOR{32..63});
VIRTUAL_ADDR ← (space<<32) | (offset);

> -    vaddr va_b = deposit64(env->cr[CR_IOR], 32, 32, env->cr[CR_ISR]);

But this is wrong too.

Since the input here is from the result of a previous memory access, which populated 
ISR+IOR, I presume any masking would be done from the prior memory access.

We do need to fix the merge, per the docs though.


r~

