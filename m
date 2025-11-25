Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB29BD0E6C4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 10:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqjS-0001QM-TP; Tue, 25 Nov 2025 05:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqjP-0000tp-8L
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:57:11 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqjL-0001xt-FK
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:57:09 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso35555305e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 02:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764068225; x=1764673025; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8F+7XBbj8dMCWClWSWjNz2+XpUchu80kvzZ8tPKf/Jg=;
 b=XqiIIBhIvGV1vaEWK96Jjq7jqa/K8kAHqM/c0qkEPm/iV0qnCnXHeSYHp6QoIZm3RH
 x7zZQVszdZ5nTwoivuMqUevVmsCoKCBS7D25oq7fRyRxwB3AiQknJ6kohhTpL7KzFv85
 KAnBSrE1RfJR1vWm+bd94ATn236rwMY1JQusN0Q3mACUb9Ret4o9FPhSSdBiR9PVoHnm
 OdyrWeveH+ovNUA/KlzvaXRWKNLBFQPXZeXPGZN0hi+MU/GC7C+LLzQ6iDK8bQz8vwBJ
 UizNeJAt1sIq9TdtFNHV2urD3kKXIFIcxkjUaHqK1C1nHs+3Y+NaI0hFBNG3PiIhit3v
 deHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764068225; x=1764673025;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8F+7XBbj8dMCWClWSWjNz2+XpUchu80kvzZ8tPKf/Jg=;
 b=beRO7yMf9bWFdjUb6vMGPiK+qa9Miba7TBVxK3rbqxZfCuGLfWdnHJ2yGJpFCKsheq
 jMwkPEo5W/ZFycDVE8CQCLozwCmrUF4ubSc1D6qlv7DWsVDrjUwm87ymezcBGhiOs606
 ElU76rU3YnSkGKURlFc8TNLKtsqgxOcOqRU2qKSJ1yhZfjOhzxJtKKSdvC+ZS9kOkQSe
 7XzeoIDkAYg3vvFd9TkMzSEGIhxaEQwvrECbb/6hkSON9bzka9mKMaQ65jS/tUwnZeXm
 g4Z0SHCx4StwnEN8KVldPg7S0NCsa7rPpp1sQdzDBgQfVoCqox3tYa0YYNt+4CTv9HML
 FUxw==
X-Gm-Message-State: AOJu0Yxps8+J8fCfr9GQ4UovnlRMR+RazEKVFaQFUo5L9rXZHJHM6c1D
 eoXsEbFOaxU3Q7tnG8y8ghe9BZ4Yay8ugfu1nzh5qDYVMo89kRXDG/7mR3EPTYt/pcNZfWigfOA
 OJXQ/2Re0bg==
X-Gm-Gg: ASbGncu3CvrssrHyDFU8vaPT8RjcQnoZD42I7utjQkJMhNtV1Bnr1bFz/WunEidnhky
 6g57GyIuQFvr51ZsK5TTUZwpRhJmPAi3BqfRC1I32cjHXojf8o4T/IY/a8dy6FGOiRffwbbhznL
 U+T2kSFH6vn68b7+hUJPDBgobMh5T2kC/KyYwznqSpQSxfYtj0w2LIcCalRHrhYgNNAGfmWJarp
 s8PRZbVMMcq6wXpgcZLqk39ch+R2D/0myL9Tn1IkT0qiOk3PLdD178pibmREu8iEKST6EHdWb7y
 f2CsY2U5kseHhkna/paRZCilKP9dV8I2GgQnyL2Bu127RGyJTtpXiQIibulruptefkP05vK38WY
 5V2J5v9rMbQoZQ2Q1wwQ4VW/F4r/eqi6LjoSMTsoF+02XGRMV7oNzvdMfmWW6Ymg81XHcrB+QbW
 hc/IBR3XwAEZm86GQGPHEfjsFhuPIvUBcY/7xuEeuiorU7G6FvUAHWUA==
X-Google-Smtp-Source: AGHT+IFgr2ULu6OeQVHYV1WhuPkFgtUzDYCjKxF1hMHvtSEPDSxh/PAZk5fAzNXco65utjHs7Sv7/A==
X-Received: by 2002:a05:600c:5253:b0:477:63dc:be00 with SMTP id
 5b1f17b1804b1-477c01bf726mr120223685e9.25.1764068225122; 
 Tue, 25 Nov 2025 02:57:05 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf227ae2sm243420425e9.9.2025.11.25.02.57.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 02:57:04 -0800 (PST)
Message-ID: <0d10960f-0046-454b-985a-da663e9202a8@linaro.org>
Date: Tue, 25 Nov 2025 11:57:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 02/12] target/tricore: Use little-endian variant
 of cpu_ld/st_data*()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
References: <20251125105434.92355-1-philmd@linaro.org>
 <20251125105434.92355-3-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251125105434.92355-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 25/11/25 11:54, Philippe Mathieu-Daudé wrote:
> We only build the TriCore target using little endianness order,
> therefore the cpu_ld/st_data*() definitions expand to the little
> endian declarations. Use the explicit little-endian variants.
> 
> Mechanical change running:
> 
>    $ tgt=tricore; \
>      end=le; \
>      for op in data mmuidx_ra; do \
>        for ac in uw sw l q; do \
>          sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>        for ac in w l q; do \
>          sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/tricore/op_helper.c | 152 ++++++++++++++++++-------------------
>   1 file changed, 76 insertions(+), 76 deletions(-)
> 
> diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
> index 2c8281a67e0..88b50bc1a9b 100644
> --- a/target/tricore/op_helper.c
> +++ b/target/tricore/op_helper.c
> @@ -2451,84 +2451,84 @@ static bool cdc_zero(uint32_t *psw)
>   
>   static void save_context_upper(CPUTriCoreState *env, uint32_t ea)
>   {
> -    cpu_stl_data(env, ea, env->PCXI);
> -    cpu_stl_data(env, ea+4, psw_read(env));
> -    cpu_stl_data(env, ea+8, env->gpr_a[10]);
> -    cpu_stl_data(env, ea+12, env->gpr_a[11]);
> -    cpu_stl_data(env, ea+16, env->gpr_d[8]);
> -    cpu_stl_data(env, ea+20, env->gpr_d[9]);
> -    cpu_stl_data(env, ea+24, env->gpr_d[10]);
> -    cpu_stl_data(env, ea+28, env->gpr_d[11]);
> -    cpu_stl_data(env, ea+32, env->gpr_a[12]);
> -    cpu_stl_data(env, ea+36, env->gpr_a[13]);
> -    cpu_stl_data(env, ea+40, env->gpr_a[14]);
> -    cpu_stl_data(env, ea+44, env->gpr_a[15]);
> -    cpu_stl_data(env, ea+48, env->gpr_d[12]);
> -    cpu_stl_data(env, ea+52, env->gpr_d[13]);
> -    cpu_stl_data(env, ea+56, env->gpr_d[14]);
> -    cpu_stl_data(env, ea+60, env->gpr_d[15]);
> +    cpu_stl_le_data(env, ea, env->PCXI);
> +    cpu_stl_le_data(env, ea+4, psw_read(env));
> +    cpu_stl_le_data(env, ea+8, env->gpr_a[10]);
> +    cpu_stl_le_data(env, ea+12, env->gpr_a[11]);
> +    cpu_stl_le_data(env, ea+16, env->gpr_d[8]);
> +    cpu_stl_le_data(env, ea+20, env->gpr_d[9]);
> +    cpu_stl_le_data(env, ea+24, env->gpr_d[10]);
> +    cpu_stl_le_data(env, ea+28, env->gpr_d[11]);
> +    cpu_stl_le_data(env, ea+32, env->gpr_a[12]);
> +    cpu_stl_le_data(env, ea+36, env->gpr_a[13]);
> +    cpu_stl_le_data(env, ea+40, env->gpr_a[14]);
> +    cpu_stl_le_data(env, ea+44, env->gpr_a[15]);
> +    cpu_stl_le_data(env, ea+48, env->gpr_d[12]);
> +    cpu_stl_le_data(env, ea+52, env->gpr_d[13]);
> +    cpu_stl_le_data(env, ea+56, env->gpr_d[14]);
> +    cpu_stl_le_data(env, ea+60, env->gpr_d[15]);
>   }

Pre-existing checkpatch error that can be fixed:

   ERROR: spaces required around that '+' (ctx:VxV)
   #56: FILE: target/tricore/op_helper.c:2455:
   +    cpu_stl_le_data(env, ea+4, psw_read(env));
                             ^

