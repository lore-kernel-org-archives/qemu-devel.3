Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6811C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 17:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwn2h-0005BL-TT; Tue, 16 Apr 2024 13:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwn2g-0005B6-OZ
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 13:56:26 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwn2f-0002uW-2B
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 13:56:26 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e2b1cd446fso37016035ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 10:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713290183; x=1713894983; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vDtJTWxXcB+3oWxvZ6SPWEWZvWHsfQJWMABQ+ZSLGtw=;
 b=aSCxjKbHSYxc148MwWPR/P9zSLIfeNuPej4VwCiNC5SSrve8c5P5wdhXTR5ylKd1/5
 ewlZz9ziZ18FbF892R1mPOnXAr1OffbE9Y06PyRwKOfF45XNrh+O4FsSZ5dxCz8GElw5
 a8ock27lMjybLHmMg0I9+/cFbrqFZeAaffsCT+Flsda0vkihdJGZfNNQKUfMrIUTjflI
 UvysnoiwXmApmuQgf2J23A0753QXZLHDheYxSFUutDWxBT33VahIrlT6MsFZPWZExQXR
 bYfDtfTYMRjIqPZ5VE9fI/OxGPz+Gc4L1mLobFQcBUFEZCbLxPP/sHKvQkkoLY/VXl0R
 kjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713290183; x=1713894983;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vDtJTWxXcB+3oWxvZ6SPWEWZvWHsfQJWMABQ+ZSLGtw=;
 b=O9xK0bKSDbKgLlg88lVo8/BKbVlb5ObgRdJEoeu/e2+ccrYc0Z9IIXp7cO61El1Tzi
 VqGQxJlBG34rYtjsDLIP/jBYL08X7OkTwMT+r/Ly3rjc43oONqfnL/qzvTTI4IMwLAXY
 RJIe6chiRyXJ854tW7sUYkespeSZ4LKlG/jgZLDacoY+FMOu9eZRlne+NPLnWGm6zW4f
 ZaBO+24A8xcbr/2p9PxZt5iQVVZDIH2mADck1d/mNha0MmhBZvJgC/1PARpGvJsA+p3Q
 a12FHnWZDqdAZsW2pu2YuoGEArPzC2WrLVyRZQjBT3e6pVRWXKF0lodQQn6CWn4cOp4c
 HnCQ==
X-Gm-Message-State: AOJu0YyrVSaHiKwy8H8YxJS2yqrwuEvfNLBgmQeqY+LtuAgcxxSFfc+y
 OpJ6aiaIdkij+ddWSl1gth+6FNWspytaBVKB/PPrbUVhyDtdTdQOCShDtUOtCRQ=
X-Google-Smtp-Source: AGHT+IEcon8NUZmDyUB8FB90GIzzmGr6VCVlxVQImairKR1pyltNMyBE4UU5a2cjfEHcvoPmeKM7GQ==
X-Received: by 2002:a17:903:8c3:b0:1e3:f4f1:a2c4 with SMTP id
 lk3-20020a17090308c300b001e3f4f1a2c4mr18882267plb.64.1713290183461; 
 Tue, 16 Apr 2024 10:56:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 f24-20020a170902ab9800b001e0c5be4e2esm10039236plr.48.2024.04.16.10.56.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 10:56:22 -0700 (PDT)
Message-ID: <1cb63686-bbb1-4c7a-89ad-51f5da248029@linaro.org>
Date: Tue, 16 Apr 2024 10:56:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] target/ppc: Move mul{li, lw, lwo, hw, hwu}
 instructions to decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240416063927.99428-1-rathc@linux.ibm.com>
 <20240416063927.99428-2-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240416063927.99428-2-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/15/24 23:39, Chinmay Rath wrote:
> Moving the following instructions to decodetree specification :
> 	mulli                   	: D-form
> 	mul{lw, lwo, hw, hwu}[.]	: XO-form
> 
> The changes were verified by validating that the tcg ops generated by those
> instructions remain the same, which were captured with the '-d in_asm,op' flag.
> 
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/insn32.decode                   |  9 +++
>   target/ppc/translate.c                     | 89 ----------------------
>   target/ppc/translate/fixedpoint-impl.c.inc | 71 +++++++++++++++++
>   3 files changed, 80 insertions(+), 89 deletions(-)

This is an accurate reorg of the current code, so
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

However, as follow-up, the code generation could be cleaned up:


> +static bool trans_MULLW(DisasContext *ctx, arg_MULLW *a)
> +{
> +#if defined(TARGET_PPC64)
> +    TCGv_i64 t0, t1;
> +    t0 = tcg_temp_new_i64();
> +    t1 = tcg_temp_new_i64();
> +    tcg_gen_ext32s_tl(t0, cpu_gpr[a->ra]);
> +    tcg_gen_ext32s_tl(t1, cpu_gpr[a->rb]);
> +    tcg_gen_mul_i64(cpu_gpr[a->rt], t0, t1);
> +#else
> +    tcg_gen_mul_i32(cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb]);
> +#endif
> +    if (unlikely(a->rc)) {
> +        gen_set_Rc0(ctx, cpu_gpr[a->rt]);
> +    }
> +    return true;
> +}

Without ifdefs:

     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();

     tcg_gen_ext32s_tl(t0, ra);
     tcg_gen_ext32s_tl(t1, rb);
     tcg_gen_mul_tl(rt, t0, t1);

For ppc32, ext32s_tl will turn into a mov, which will be optimized away.  So ideal code 
generation for both modes.


> +static bool trans_MULLWO(DisasContext *ctx, arg_MULLWO *a)
> +{
> +    TCGv_i32 t0 = tcg_temp_new_i32();
> +    TCGv_i32 t1 = tcg_temp_new_i32();
> +
> +    tcg_gen_trunc_tl_i32(t0, cpu_gpr[a->ra]);
> +    tcg_gen_trunc_tl_i32(t1, cpu_gpr[a->rb]);
> +    tcg_gen_muls2_i32(t0, t1, t0, t1);
> +#if defined(TARGET_PPC64)
> +    tcg_gen_concat_i32_i64(cpu_gpr[a->rt], t0, t1);
> +#else
> +    tcg_gen_mov_i32(cpu_gpr[a->rt], t0);
> +#endif
> +
> +    tcg_gen_sari_i32(t0, t0, 31);
> +    tcg_gen_setcond_i32(TCG_COND_NE, t0, t0, t1);
> +    tcg_gen_extu_i32_tl(cpu_ov, t0);

Usually hosts need to create the full 64-bit product and then break it apart for 
tcg_gen_muls2_i32, so split followed immediately by concatenate isn't great.


     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();

#ifdef TARGET_PPC64
     tcg_gen_ext32s_i64(t0, ra);
     tcg_gen_ext32s_i64(t1, rb);
     tcg_gen_mul_i64(rt, t0, t1);
     tcg_gen_sextract_i64(t0, rt, 31, 1);
     tcg_gen_sari_i64(t1, rt, 32);
#else
     tcg_gen_muls2_i32(rt, t1, ra, rb);
     tcg_gen_sari_i32(t0, rt, 31);
#endif
     tcg_gen_setcond_tl(TCG_COND_NE, cpu_ov, t0, t1);


> +    if (is_isa300(ctx)) {
> +        tcg_gen_mov_tl(cpu_ov32, cpu_ov);
> +    }
> +    tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
> +
> +    if (unlikely(a->rc)) {
> +        gen_set_Rc0(ctx, cpu_gpr[a->rt]);
> +    }
> +    return true;
> +}


r~

