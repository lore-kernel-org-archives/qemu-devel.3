Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC41C36002
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 01:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twtEU-0001X3-LI; Mon, 24 Mar 2025 21:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEM-0001VR-KV
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:26 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEK-0007PX-Q5
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:26 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso99115535ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 18:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742866643; x=1743471443; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Qsv8GWi8oHmDmrLISV9ECCnpn06gwR3uptN7njeHoo=;
 b=IgtbB2zpPuxNqPHr9EIkGJqEqUU8dyc4BzYmrxs9QWxwkvGIIrRQHPi01+IEGGnJsS
 RjJn799kWZyfd2ZY2rp6l6nGy0f4QiY7d4kqszIiki3+C01yccZX1mhgAWv9XJxuUQ/P
 N4MbnyeGr7RIWBjdFd6snii/QHc7dWIfFUBh6cYXz5ZINJ7WDEfy6NRdjpESDeDlXJfG
 OBuFMPurMXdyC5K2hrZzHnWFJoSCeItEHXjIjifboRTcVV73lYAMHvAz6c857fn1yhp1
 msP++TG6zdd7KwShgGEnU+CzJiuW+IKy4LCO0030aviunQPPXsDAnPwFaGiiCFLK8gNy
 FBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742866643; x=1743471443;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Qsv8GWi8oHmDmrLISV9ECCnpn06gwR3uptN7njeHoo=;
 b=G7WVXVsYQo241sS+DC4ltPqqf5+aYLYT+PNVUpVD1tnyIOzpa3fcGKxNS4vu+vruqd
 Lmq/WrMh0+Tiu1GWxcpEw32055UeUA+rpEGupEFdk5AUs5TDQTVBjq8UggD5CScM3KZc
 RnA6aEMH32/b3BIS5S4jr4ku4v2MHmEzZftV6T5o1ebUtBe1d/xrwTSywLgn5jX7BSA2
 x1B3SkU3cns2GgRQP8ksjD730i5VU24kuUU5yZ+oiofnWaUeZdStfyAPNicnVAZqICh1
 F0+MWx2oBM89yXQvwNb47XrHRgf90mBpn72F1BSfrbnJsQ2RSIFFB9myMQVlY5FpxrS6
 1c5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUtQbTF2jv4TmcAGXY7c6eFi890wsYx1sG5aj5vqLToTIucpyCmi/+PCWcMN6F4WiIcrbJ0r35ALmD@nongnu.org
X-Gm-Message-State: AOJu0YwjYGrTG3GwDuwvtPFTmabybm04BHH1VauloYUmoGeGIFM5t8/6
 xgFee+fiaCsuWMhPYcQnjI/Ik0gXtnx8Ubp11Y48yjrJ4hgOIg4kJKkNy2XaGQ8=
X-Gm-Gg: ASbGncu9UEw8P6AEZ95vvHSiLkJwcUjlJhxBfnp2Tf1KXa/UTV/FcUZVzURsOw6qjOZ
 LjDBKYl73s9As6Vv9wCQ3X0/z1i6YOesrqeFnG6YDd9qRcF1N2kiGH9Wgm/lm63tGB+IAq86VVh
 EFtHMUAjFx0lTPIKpIpU7WZbbKb8OFSilxzreI/8bjCxHsmKcfF1bHJyePhClv+/Z23fXJkQdUw
 EPQpi1zdongaMXTGbOVzsBP1WgN36IGzbYAeC3rX7N2l3dz6Z3gyYQixKn9eSlBt+1wdORqSpJB
 /2Jy3tskAnhTZX9seRpRbJI5DURMVwahEO+J4ubtFh4mUbowYXefHHKKUQ==
X-Google-Smtp-Source: AGHT+IFMGBat3/gj91m2OSHiv9vwM81+UzlU882tawVsvv9h2Crv0CdZVPy8IDv3ChQw8GoBTdm6yQ==
X-Received: by 2002:a05:6a00:80e:b0:736:6279:ca25 with SMTP id
 d2e1a72fcca58-73905a27ae5mr27610127b3a.24.1742866642618; 
 Mon, 24 Mar 2025 18:37:22 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73906158ef2sm9090422b3a.141.2025.03.24.18.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 18:37:22 -0700 (PDT)
Message-ID: <3f6af01d-97a5-4c6d-b642-a5897aa8ad55@linaro.org>
Date: Mon, 24 Mar 2025 18:12:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] target/avr: Introduce gen_data_{load,store}_raw
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-10-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250323173730.3213964-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 3/23/25 10:37, Richard Henderson wrote:
> Prepare for offset_io being non-zero; also allow folding
> stack pointer offsets into the arithmetic.
> So far, all offsets are 0.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/translate.c | 42 ++++++++++++++++++++++++++++++++----------
>   1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/target/avr/translate.c b/target/avr/translate.c
> index e9fef1aaad..6bb4154dff 100644
> --- a/target/avr/translate.c
> +++ b/target/avr/translate.c
> @@ -198,6 +198,28 @@ static bool decode_insn(DisasContext *ctx, uint16_t insn);
>   static void gen_inb(DisasContext *ctx, TCGv data, int port);
>   static void gen_outb(DisasContext *ctx, TCGv data, int port);
>   
> +static void gen_data_store_raw(DisasContext *ctx, TCGv data,
> +                               TCGv addr, int offset, MemOp mop)
> +{
> +    if (ctx->offset_io + offset) {
> +        TCGv t = tcg_temp_new();
> +        tcg_gen_addi_tl(t, addr, ctx->offset_io + offset);
> +        addr = t;
> +    }
> +    tcg_gen_qemu_st_tl(data, addr, MMU_DATA_IDX, mop);
> +}
> +
> +static void gen_data_load_raw(DisasContext *ctx, TCGv data,
> +                              TCGv addr, int offset, MemOp mop)
> +{
> +    if (ctx->offset_io + offset) {
> +        TCGv t = tcg_temp_new();
> +        tcg_gen_addi_tl(t, addr, ctx->offset_io + offset);
> +        addr = t;
> +    }
> +    tcg_gen_qemu_ld_tl(data, addr, MMU_DATA_IDX, mop);
> +}
> +
>   /*
>    * Arithmetic Instructions
>    */
> @@ -940,21 +962,21 @@ static void gen_push_ret(DisasContext *ctx, int ret)
>       if (avr_feature(ctx->env, AVR_FEATURE_1_BYTE_PC)) {
>           TCGv t0 = tcg_constant_i32(ret & 0x0000ff);
>   
> -        tcg_gen_qemu_st_tl(t0, cpu_sp, MMU_DATA_IDX, MO_UB);
> +        gen_data_store_raw(ctx, t0, cpu_sp, 0, MO_UB);
>           tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
>       } else if (avr_feature(ctx->env, AVR_FEATURE_2_BYTE_PC)) {
>           TCGv t0 = tcg_constant_i32(ret & 0x00ffff);
>   
>           tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
> -        tcg_gen_qemu_st_tl(t0, cpu_sp, MMU_DATA_IDX, MO_BEUW);
> +        gen_data_store_raw(ctx, t0, cpu_sp, 0, MO_BEUW);
>           tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
>       } else if (avr_feature(ctx->env, AVR_FEATURE_3_BYTE_PC)) {
>           TCGv lo = tcg_constant_i32(ret & 0x0000ff);
>           TCGv hi = tcg_constant_i32((ret & 0xffff00) >> 8);
>   
> -        tcg_gen_qemu_st_tl(lo, cpu_sp, MMU_DATA_IDX, MO_UB);
> +        gen_data_store_raw(ctx, lo, cpu_sp, 0, MO_UB);
>           tcg_gen_subi_tl(cpu_sp, cpu_sp, 2);
> -        tcg_gen_qemu_st_tl(hi, cpu_sp, MMU_DATA_IDX, MO_BEUW);
> +        gen_data_store_raw(ctx, hi, cpu_sp, 0, MO_BEUW);
>           tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
>       }
>   }
> @@ -963,20 +985,20 @@ static void gen_pop_ret(DisasContext *ctx, TCGv ret)
>   {
>       if (avr_feature(ctx->env, AVR_FEATURE_1_BYTE_PC)) {
>           tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
> -        tcg_gen_qemu_ld_tl(ret, cpu_sp, MMU_DATA_IDX, MO_UB);
> +        gen_data_load_raw(ctx, ret, cpu_sp, 0, MO_UB);
>       } else if (avr_feature(ctx->env, AVR_FEATURE_2_BYTE_PC)) {
>           tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
> -        tcg_gen_qemu_ld_tl(ret, cpu_sp, MMU_DATA_IDX, MO_BEUW);
> +        gen_data_load_raw(ctx, ret, cpu_sp, 0, MO_BEUW);
>           tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
>       } else if (avr_feature(ctx->env, AVR_FEATURE_3_BYTE_PC)) {
>           TCGv lo = tcg_temp_new_i32();
>           TCGv hi = tcg_temp_new_i32();
>   
>           tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
> -        tcg_gen_qemu_ld_tl(hi, cpu_sp, MMU_DATA_IDX, MO_BEUW);
> +        gen_data_load_raw(ctx, hi, cpu_sp, 0, MO_BEUW);
>   
>           tcg_gen_addi_tl(cpu_sp, cpu_sp, 2);
> -        tcg_gen_qemu_ld_tl(lo, cpu_sp, MMU_DATA_IDX, MO_UB);
> +        gen_data_load_raw(ctx, lo, cpu_sp, 0, MO_UB);
>   
>           tcg_gen_deposit_tl(ret, lo, hi, 8, 16);
>       }
> @@ -1498,13 +1520,13 @@ static void gen_data_store(DisasContext *ctx, TCGv data, TCGv addr)
>       if (ctx->base.tb->flags & TB_FLAGS_FULL_ACCESS) {
>           gen_helper_fullwr(tcg_env, data, addr);
>       } else {
> -        tcg_gen_qemu_st_tl(data, addr, MMU_DATA_IDX, MO_UB);
> +        gen_data_store_raw(ctx, data, addr, 0, MO_UB);
>       }
>   }
>   
>   static void gen_data_load(DisasContext *ctx, TCGv data, TCGv addr)
>   {
> -    tcg_gen_qemu_ld_tl(data, addr, MMU_DATA_IDX, MO_UB);
> +    gen_data_load_raw(ctx, data, addr, 0, MO_UB);
>   }
>   
>   static void gen_inb(DisasContext *ctx, TCGv data, int port)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


