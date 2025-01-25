Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A27C0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbkL5-0006Fh-0L; Sat, 25 Jan 2025 12:52:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbkL0-0006EX-76
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:52:54 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbkKy-0000xe-IA
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:52:53 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2165cb60719so54760075ad.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737827570; x=1738432370; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4wr9jypUAISQ5elGrnqDjJVIz7HWgXoBF0LyJsDxIbU=;
 b=j4XDEjv8MMyuzZKQPxMjfaphb+0p+BDqaWCF8sDI0wKNfQ1dRTVgWYuhVw7IqutVbL
 H39eWR/z94EJlaXCa8uypXQDAf0IdZVkv04vqIv1on4mpJ/otcb+i7ie/hak1hZMK/ht
 KdGjqse0/aS0GpA5+ISXl6OYVreUI2RIofnFvtVmu3lGszxeq7yWja2oy1L3/NONlTyV
 WnQohzUi39Ey9Xmdiio99VYwryP2fEQ4Esbb2Uk6A14rDO4t3eykuxkp9JhPlhAXwIMi
 /z94kN3Cw0m5CmD5tZbqKb6L6EJJrus2tRiyB68IKbwkrLsdh4pMNrf374wDpBWqRVqU
 uRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737827570; x=1738432370;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4wr9jypUAISQ5elGrnqDjJVIz7HWgXoBF0LyJsDxIbU=;
 b=SdT/RYQkCIVXNakXJ2ZF3i70+a+s/qsyj2IScaVUIzZ74d4dFsekwwl+Vy57dQLk0N
 i72EQDpW4pRbPs/cZuh9/RpgvPZxdRv49Fauyb6/ezPqvoZ88QDUtsvM9U1gGItOnjEa
 8UObyc8rWa5A+zKrL1VEA3LVb53tz/6+SK6M+HnrtSG3+HFxTpPL5lW2mmlO5eE8+LKH
 ZX9+tPbduzzIFadI/Egfix5Cla2LMfP5LTVG+F6+Nqyy7y+WHrUKh1VFQZ6/gBU0xlBq
 HPEw2LE9E4YRxhVN6KJ7MlK/SxrN/mxLj+q3hm9Ad3cm+fMCz13jweuFPTJmwK5xJ/Bg
 twbQ==
X-Gm-Message-State: AOJu0YxxNFb2O22CNE242rSOADno9zTo9LNTlzVl5eaYnH5OQ112hGsB
 QdKEaumLiwHi8DYiRFrdKd1Fk61bvFp+qR0rykXHi+dlOLFovVxnxBY7G9mfUV3Zv8rn+vqyLok
 f
X-Gm-Gg: ASbGncue0sjXBanOw2kv6b7QEDlw7Nz1CjX7R1XDSM1IikWnj1ZRArau08QXmmR7ili
 XVdGVzrqw/eqXWodDaXAIPpt0gcBzL5TVh6r4U9BWQuMVnaSfU9SRNdoPyLI1+GcY9Hzy2tZJn6
 OCmW5OAUvQILl7o4nXQVghx/IoohPNCpC1p3kd9/AjK5naBUipO8NUjzDrMhsy7l6x/0binW/Wf
 8yjfsm7e8VwjzMh9N7LrsHO5g+DgYT8mq4ers6eBjB8mOgRdrxZvOK2r9zPcDXum5BD8RtkX6Vt
 y269gS4sbxnhdkE6R9g+Hw==
X-Google-Smtp-Source: AGHT+IEwQo80EKFY+wQiN6oGrtKm2IBE24U0DIixSeFE0telTij8U9WQlb4Futw14jORLkrzE4o0rg==
X-Received: by 2002:a17:902:e5c8:b0:21a:8716:fa97 with SMTP id
 d9443c01a7336-21c35401120mr475006055ad.13.1737827570502; 
 Sat, 25 Jan 2025 09:52:50 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da424d59dsm34527835ad.218.2025.01.25.09.52.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 09:52:50 -0800 (PST)
Message-ID: <49d2c367-b206-478f-89e9-935911cb7394@linaro.org>
Date: Sat, 25 Jan 2025 09:52:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/76] target/arm: Define and use new
 write_fp_*reg_merging() functions
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-38-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-38-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> For FEAT_AFP's FPCR.NEP bit, we need to programmatically change the
> behaviour of the writeback of the result for most SIMD scalar
> operations, so that instead of zeroing the upper part of the result
> register it merges the upper elements from one of the input
> registers.
> 
> Provide new functions write_fp_*reg_merging() which can be used
> instead of the existing write_fp_*reg() functions when we want this
> "merge the result with one of the input registers if FPCR.NEP is
> enabled" handling, and use them in do_fp3_scalar_with_fpsttype().
> 
> Note that (as documented in the description of the FPCR.NEP bit)
> which input register to use as the merge source varies by
> instruction: for these 2-input scalar operations, the comparison
> instructions take from Rm, not Rn.
> 
> We'll extend this to also provide the merging behaviour for
> the remaining scalar insns in subsequent commits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 117 +++++++++++++++++++++++++--------
>   1 file changed, 91 insertions(+), 26 deletions(-)
> 
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index d34672a8ba6..19a4ae14c15 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -665,6 +665,68 @@ static void write_fp_sreg(DisasContext *s, int reg, TCGv_i32 v)
>       write_fp_dreg(s, reg, tmp);
>   }
>   
> +/*
> + * Write a double result to 128 bit vector register reg, honouring FPCR.NEP:
> + * - if FPCR.NEP == 0, clear the high elements of reg
> + * - if FPCR.NEP == 1, set the high elements of reg from mergereg
> + *   (i.e. merge the result with those high elements)
> + * In either case, SVE register bits above 128 are zeroed (per R_WKYLB).
> + */
> +static void write_fp_dreg_merging(DisasContext *s, int reg, int mergereg,
> +                                  TCGv_i64 v)
> +{
> +    if (!s->fpcr_nep) {
> +        write_fp_dreg(s, reg, v);
> +        return;
> +    }
> +
> +    /*
> +     * Move from mergereg to reg; this sets the high elements and
> +     * clears the bits above 128 as a side effect.
> +     */
> +    tcg_gen_gvec_mov(MO_64, fp_reg_offset(s, reg, MO_64),
> +                     fp_reg_offset(s, mergereg, MO_64),
> +                     16, vec_full_reg_size(s));

I think this would be clearer with vec_full_reg_offset(), though the result is correct 
either way.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

