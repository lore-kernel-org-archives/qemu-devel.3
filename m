Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D332C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 09:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6oBw-0001Wi-6e; Tue, 14 May 2024 05:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s6oBi-0001Uv-0w
 for qemu-devel@nongnu.org; Tue, 14 May 2024 05:11:10 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s6oBa-0002sW-Di
 for qemu-devel@nongnu.org; Tue, 14 May 2024 05:11:07 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5b277993a48so3054996eaf.1
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 02:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715677860; x=1716282660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wFt2B2tmGMJZMVU9WuNI2mtLK6I1IwQaN12zG1udVDs=;
 b=jnULYbvzQkHhUBqGXhGRMlMk1hWZYuxmQfPegJAr+MvyndifAGlFtaOi6VGjhWP27p
 GxPUw29Va5WkvxPqoQYYXKhJghmMXnOYhUHtj+M9St7V4oLPEvixlwO3t7NR468nsIBf
 +/I92vN9gGnjaAlhyh8/v32WwCmo7XPoZSNxoIUQ5V1HNn+G7c1bFS+yCeMyHtVB1g/4
 3aTf+X7JxpokfgZNlmfKBfosk1Oq7G1xzO8+lveicv2RTb+4qgc2iij85TlChG33MOsZ
 sINTMsT+yWbBOFEWJxACmd17/bsAS65bKXF9DZs63u1YjZZOiFY4+SRj7vMq3+t09+Ec
 +AdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715677860; x=1716282660;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wFt2B2tmGMJZMVU9WuNI2mtLK6I1IwQaN12zG1udVDs=;
 b=L9/4SR1tlDPq83tZ59b082mBsqo/YZiszpPLjVKSyPBiwTMrYufxqM1cJbyAlBcoiT
 GQo9WyhRctwUTkTbPlzrP9ns8jVBlz0WVfuxzfSDf1p2EhM+q0O3YTybTLQ+VYizhJrN
 826hgJnoOFX90o1oDo2er20o9PUmTht+hTcxVoPs6mUH9GCCgzk7BG8qYI8UU0jlXHvL
 3sK1r99kbylWeMQ8YEy2zB3rxwywyJuqtDeCppPuTNtqSqAFaIocTiy3FfWht03AR9nn
 9Wn8RAN5HPhTJzMlaogkPWH6Fk+58wsIjfjBO0atn2e46GKz6uLsxtf7JEP+QAb7ufp3
 GtqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTSfUxtzJb7rXLD/7eTQNi53TMw8BT73xUpTP1seysE2xY0/B3bdigkOe54EpyOi4g3F46tIETbTbOrFooNJtGi9fosts=
X-Gm-Message-State: AOJu0Yw3eS/fqCPFMxHVDESmqUQ4nY6OjRd1tUO+napmLjg99FM9DaOP
 KX8qbIgSjzjASQvE1azI8OpBhY1XLtQCBdhbLOn7pfMq07mYbQu8/YzdIuVkrzE=
X-Google-Smtp-Source: AGHT+IFwSqGeA5eWG79bjC1RGjAzgb6wDIiryQ4SH0yLb+ql0XeoO5VFrIbiVWtGjBtnidZEXL8rFA==
X-Received: by 2002:a05:6358:4285:b0:193:f936:633a with SMTP id
 e5c5f4694b2df-193f9366370mr954938155d.13.1715677860033; 
 Tue, 14 May 2024 02:11:00 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.57])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-63411346dc1sm7870703a12.83.2024.05.14.02.10.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 02:10:59 -0700 (PDT)
Message-ID: <14e88990-963c-45ef-bf51-662d54857c6e@ventanamicro.com>
Date: Tue, 14 May 2024 06:10:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: rvzicbo: Fixup CBO extension register
 calculation
To: Alistair Francis <alistair23@gmail.com>, qemu-riscv@nongnu.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 bin.meng@windriver.com, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, fabian.thomas@cispa.de,
 Bin Meng <bmeng.cn@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20240514023910.301766-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240514023910.301766-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc29.google.com
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



On 5/13/24 23:39, Alistair Francis wrote:
> When running the instruction
> 
> ```
>      cbo.flush 0(x0)
> ```
> 
> QEMU would segfault.
> 
> The issue was in cpu_gpr[a->rs1] as QEMU does not have cpu_gpr[0]
> allocated.
> 
> In order to fix this let's use the existing get_address()
> helper. This also has the benefit of performing pointer mask
> calculations on the address specified in rs1.
> 
> The pointer masking specificiation specifically states:
> 
> """
> Cache Management Operations: All instructions in Zicbom, Zicbop and Zicboz
> """
> 
> So this is the correct behaviour and we previously have been incorrectly
> not masking the address.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reported-by: Fabian Thomas <fabian.thomas@cispa.de>
> Fixes: e05da09b7cfd ("target/riscv: implement Zicbom extension")
> ---

LGTM but I wonder if this is the same fix as this one sent by Phil a month
ago or so:

https://lore.kernel.org/qemu-riscv/20240419110514.69697-1-philmd@linaro.org/
("[PATCH] target/riscv: Use get_address() to get address with Zicbom extensions")


Thanks,

Daniel

>   target/riscv/insn_trans/trans_rvzicbo.c.inc | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvzicbo.c.inc b/target/riscv/insn_trans/trans_rvzicbo.c.inc
> index d5d7095903..15711c3140 100644
> --- a/target/riscv/insn_trans/trans_rvzicbo.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzicbo.c.inc
> @@ -31,27 +31,35 @@
>   static bool trans_cbo_clean(DisasContext *ctx, arg_cbo_clean *a)
>   {
>       REQUIRE_ZICBOM(ctx);
> -    gen_helper_cbo_clean_flush(tcg_env, cpu_gpr[a->rs1]);
> +    TCGv src = get_address(ctx, a->rs1, 0);
> +
> +    gen_helper_cbo_clean_flush(tcg_env, src);
>       return true;
>   }
>   
>   static bool trans_cbo_flush(DisasContext *ctx, arg_cbo_flush *a)
>   {
>       REQUIRE_ZICBOM(ctx);
> -    gen_helper_cbo_clean_flush(tcg_env, cpu_gpr[a->rs1]);
> +    TCGv src = get_address(ctx, a->rs1, 0);
> +
> +    gen_helper_cbo_clean_flush(tcg_env, src);
>       return true;
>   }
>   
>   static bool trans_cbo_inval(DisasContext *ctx, arg_cbo_inval *a)
>   {
>       REQUIRE_ZICBOM(ctx);
> -    gen_helper_cbo_inval(tcg_env, cpu_gpr[a->rs1]);
> +    TCGv src = get_address(ctx, a->rs1, 0);
> +
> +    gen_helper_cbo_inval(tcg_env, src);
>       return true;
>   }
>   
>   static bool trans_cbo_zero(DisasContext *ctx, arg_cbo_zero *a)
>   {
>       REQUIRE_ZICBOZ(ctx);
> -    gen_helper_cbo_zero(tcg_env, cpu_gpr[a->rs1]);
> +    TCGv src = get_address(ctx, a->rs1, 0);
> +
> +    gen_helper_cbo_zero(tcg_env, src);
>       return true;
>   }

