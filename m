Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584ADD277C1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 22:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veKkA-0005xn-Rm; Fri, 09 Jan 2026 17:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKk8-0005wR-5O
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:14:04 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKk6-0002RV-M5
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:14:03 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81c72659e6bso2373477b3a.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 14:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767996841; x=1768601641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dj78KKGxJrVsuBkTg6x37rMjXaDMOcksfupShUy5k14=;
 b=jMCl2zfxnkwBxSUDBZCPziQGRdqG50rtJAscgpK94LzdV91qanCUuN4yXbQWlDQG1/
 VkMu4mD6yO4tP5XSc6DChVSfHtq9SZ/6NMI4N1foQQjHMjwwWavUR0Z4WTP4IOAxN1+r
 NwXgZfcRmWv38GDeyMed2ZsDeHO8b9ZDsQO4XUFiNf3fFt6xrn78hviVvcRv4lBfv0kK
 ywuVlidHOOkkEuPlMN0ghfomifjs7f614V2lOR6+DhVzsEN65aup25lfjPY99mQI2ydB
 khgZWyAdvOhHUT+vb6eQJGPA1QuS3XyLAD2NwJX3ChgKP9tyenVvmrStTXvz5u82TKDx
 /45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767996841; x=1768601641;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dj78KKGxJrVsuBkTg6x37rMjXaDMOcksfupShUy5k14=;
 b=HoQKQXip5k3/B81oJOyGOmIKeWGgMpMgYPc5Y1GJidDzIAFTgB8MO1ab1yFjm6dDXM
 o+eLjhJbQPC5zjxBnJBwJ3mI4qawRX2HUgyDmpfEjEzHK9vO1y8bnrd7rZGMmmJiVoTU
 wCGOq2SFh/CefLksj/8VpBmowGqzo6XrA1+UdSqKxeOhXQdvcEYaBogIFmiyLnEAykjc
 4QOEulAxMlqo5TtDmiWCMikXayl0xGYrSWEyCeAQVyntU4GHGUajnGoiKsejTTjQJzwY
 wdhLTNot7ZP62xShOigt4heuPXQZXKGChSmQ6dHd2CKhKXjwSN6xmyEjvQ0yShydAUcq
 IPAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDzb4ieroT8lTmcZ5ZHHa7MnmERdxr2aNbP4Fyknqw5k8hM+WUiVeinmPHGC+Ssxiu5BlF3aB6Zn90@nongnu.org
X-Gm-Message-State: AOJu0Ywc/vdNUXaS5+orCJS5hh7PMDhAJS/CyzmZHlJYSSpgw9PK5lc9
 qTfvSAwBTzXTyd3LGJ1x+Jro5pQZLLscpsrA7IiOUndFe3ihE19fqviSIOPYAhNQlXE=
X-Gm-Gg: AY/fxX63cUw98VaS9hdfp4P7MFNAphCSnAo9XTyTyhrTvvMSfv8MwW1itlKt6Spj3Am
 WHGBfTOnn/r0GygfzG2pY07RYTQG9k+p6JoR7/GSrVo4fu0NXnG0/OXCphpt1dJ/OK7Br0/1/xx
 pz1WSOG5Lb56JgNW+Gon7gafRZHJi6DNQ1Q+FYyKtyplh7O90xfySe4nHicoWnyPTQQZPKFJnij
 fiTSL7XdijOQ8L89rkZuP2gq6lXEtHfAjS/0rDVKiPsPH1Gzkn/Te0ADzN63cn6hgl3gyqBYxaE
 95r0eHdFzB7bEJIAT0MfvElSeEQBLrCZ1K/ba/uYAQ+W+lmn0bGavxB5pn6HUFuOrCiPwfYRckM
 KhNpKhXnGf6V455qixq5Ve8xFIW6CV5ubl9+9YhYSmyUmdYlN1Qk54yLB9ZbLyITrKecC5xEmSA
 ysF+s+5ZLC2K9hNCbpjMF0azrsJc8sHODzL7Xl
X-Google-Smtp-Source: AGHT+IGWCE+EPbIvjfxWK5OourM8KyUdSij2cT/oQzB0y/sziZ88o+1noVU5rfgG7nFjwqF2tY7I2g==
X-Received: by 2002:a05:6a00:f96:b0:81e:4ec2:da9d with SMTP id
 d2e1a72fcca58-81e4ec2dce2mr2607344b3a.46.1767996840995; 
 Fri, 09 Jan 2026 14:14:00 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81e7cdaa87bsm2412705b3a.17.2026.01.09.14.13.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 14:14:00 -0800 (PST)
Message-ID: <7fcbddf8-46be-449f-ac20-1caba498be32@linaro.org>
Date: Sat, 10 Jan 2026 09:13:53 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/29] accel/tcg/translate-all.c: detect addr_type
 dynamically
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-16-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-16-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> With TARGET_ADDRESS_BITS mechanism, it's now possible to specify which
> variant every source file is written for. Compared to before, it means
> that addr_type will now vary per tb translation, where it was constant
> for a given target previously.
> 
> Instead of introducing a new parameter to translator_loop(), we simply
> add this information in TCGTBCPUState, which is returned by
> get_tb_cpu_state() during the translation, and passed down to
> tb_gen_code().
> 
> To avoid modifying all target with this new field, we simply define a
> default value that is equivalent to current state: use
> target_long_bits(). With this, we can progressively convert new
> architectures.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/accel/tcg/tb-cpu-state.h | 12 ++++++++++++
>   accel/tcg/translate-all.c        | 15 ++++++++++++++-
>   2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/include/accel/tcg/tb-cpu-state.h b/include/accel/tcg/tb-cpu-state.h
> index 8f912900ca6..b77c4dd5100 100644
> --- a/include/accel/tcg/tb-cpu-state.h
> +++ b/include/accel/tcg/tb-cpu-state.h
> @@ -8,11 +8,23 @@
>   
>   #include "exec/vaddr.h"
>   
> +/*
> + * Default value 0 means to refer to target_long_bits(). It allows to stay
> + * compatible with architectures that don't yet have varying definition of TCGv
> + * depending on execution mode.
> + */
> +typedef enum TCGvType {
> +    TCGV_TYPE_TARGET_LONG = 0,
> +    TCGV_TYPE_I32,
> +    TCGV_TYPE_I64,
> +} TCGvType;
> +
>   typedef struct TCGTBCPUState {
>       vaddr pc;
>       uint32_t flags;
>       uint32_t cflags;
>       uint64_t cs_base;
> +    TCGvType tcgv_type;
>   } TCGTBCPUState;

No need for this.  This state is already present in flags, in a target-specific manner. 
If you actually needed this information, you'd want a new target hook.  However...

> @@ -316,7 +329,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
>       }
>   
>       tcg_ctx->gen_tb = tb;
> -    tcg_ctx->addr_type = target_long_bits() == 32 ? TCG_TYPE_I32 : TCG_TYPE_I64;
> +    tcg_ctx->addr_type = tcgv_type_to_tcg_type(s.tcgv_type);

I did mention in our discussion that it would be best to set this in translator_loop() 
instead, via a new parameter.

This makes it trivial for target/arm/tcg/translate.c to simply tell us that TCG_TYPE_I32 
is correct, for target/arm/tcg/translate-a64.c to specify TCG_TYPE_I64, and for all other 
users to use TCG_TYPE_TL.


r~

