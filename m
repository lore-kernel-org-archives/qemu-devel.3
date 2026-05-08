Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1770FCD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 18:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLPsX-0003RI-KH; Fri, 08 May 2026 14:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLPsQ-0003Qq-6N
 for qemu-devel@nongnu.org; Fri, 08 May 2026 14:24:43 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLPsO-0006PV-Bw
 for qemu-devel@nongnu.org; Fri, 08 May 2026 14:24:41 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-40f1a1f77a6so1820803fac.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778264678; x=1778869478; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dw6ea6eYUc5wjwgFGOvOZ+GP+ilYIfIDlh17C7H0yvc=;
 b=erAregxcudVLtfdk70uyS1RwMGYJbtNHgZ/GfPVSLnTDWeq+bLtWTDEDbixMHdvEGn
 G/SJ1LIl10f8yM6GE6FG1stP78chhvUtp9Q+PihRijxyGOHArL6SwD8O8sd/8b0ayxW6
 V5EUIxLGVNrlLQXP1zwWP8toduRLHu96+tVC0fqTruwBVKbWqiB0Uz0OXAE562xu27ky
 mteATrFKew7SmBDO1aTN6nJ2hwpFxe4uFFYYWX5fEqk90W/XhFtK4/goenFA1a9+Izxf
 OpsT/uzbLb+YADZiPetB8S4TuB3ajyWeh+3aEwEQnm8T/quWzPEslBB+b3VFq3HmXhMw
 mgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778264678; x=1778869478;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dw6ea6eYUc5wjwgFGOvOZ+GP+ilYIfIDlh17C7H0yvc=;
 b=nJhpG6sBPRsv03pjTutLGy1J4FuV1b8WJG+jj5TeUSL6KSJ4pqxFEPwMZc6cn+o55N
 7g9RTsQB2lEPZerUJHo1a+WzRMGv1P7VgvHwP9+TuqavMY7LAHPufZMMpRNNizfFwqAy
 5EF2bFCJ0GcUM8u+rk8TCCFudc1z2ip+XXYUqgd2E598Z5IloE6wVa54DNe8nrqmE29w
 nxevjOQhX4n9bFdddOsUJq0dbYNdDA1J7ykgkDETQrB+T0HyatwWf00gg3tp9D3Z88+o
 b0F74kiWPk2hNPhJw5S9SmfALuTQT2I2TX0nEpWIrhvqthNRLueDSU/5EwYdzFnYFDCe
 14aA==
X-Gm-Message-State: AOJu0YySOUg5DbCbNSB3vtSAIfAy31stk1wr3T2f4nwu6Rp7CKg2NvxO
 FGOY4mOBig2COkiYw/sRmC5/eNeo3znBBRjAApC8VtjJYxrc02jL47M6BQ0craK8I6hD44Uh9iL
 K4Wdp
X-Gm-Gg: Acq92OFC+J6/DPlax8a14g3rFewXgC7NQSkMkw+uVqSIzthRAGG/mAz78/EFl1L6sw3
 NX6gL/lSehC/q/jkT3rdgnszJ3HTjZRlwUNHT3w1EbLyrjJU7ErYtqmi9kWPBYzC/+7VUHLX4MV
 ewY8Noep8p7VuN2kMkwrOezTTpJlAty5UPTE6i5KRqCybIfBei9I0wXbzbgmHFk0B7FizF8Pdal
 iG69W5llJraNB6v8taBSChi5+ec7Ue79IrefAaKv7myAfcrMNqcO69AWOuGp/ivx9W3HCn4h+7l
 WdTqUrt2Ez5HgfQAO8sUD4kvKDEI34jmixwhDAvyYI43ukI/WQxrq0XzQxea5IvueAFLFodg2JE
 U/ebIFKQX8Fqs3RX8aPGKgnHPGe7MEEx7AAzRhyXRQeQN9Fl+UvK/8oNxeTMgxWP9bYaHyuudhL
 j9Kh9TMapAxuUt43Eu6augSljRDcloTWWeTnj2wqTCkW20Xb40Uy5tLJlsmJesQZhPY9DcMe7/A
 hgAOYEpOQ==
X-Received: by 2002:a05:6870:242:b0:430:2b69:8e9a with SMTP id
 586e51a60fabf-43556b27e81mr2110721fac.5.1778264677711; 
 Fri, 08 May 2026 11:24:37 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:4b0a:aabe:cbe1:bd0c?
 ([2600:381:c938:6375:4b0a:aabe:cbe1:bd0c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e94edsm2469555fac.13.2026.05.08.11.24.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 11:24:37 -0700 (PDT)
Message-ID: <fffc495d-d579-41cd-b444-32d145ead015@linaro.org>
Date: Fri, 8 May 2026 13:24:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/32] target/mips: add Octeon MTM0 instruction
To: qemu-devel@nongnu.org
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
 <20260508-mips-octeon-missing-insns-v2-v3-15-bcbec96357d9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-15-bcbec96357d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/8/26 10:12, James Hilliard wrote:
> MTM0 loads the low multiplier operand pair from rs/rt, starts a new
> multiplier chain, clears the upper multiplier limbs, and resets partial
> products.
> 
> Add the decode and translator path that writes MPL[0] and MPL[3].
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split MTM0 out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> ---
>   target/mips/tcg/octeon.decode      |  2 ++
>   target/mips/tcg/octeon_translate.c | 55 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 57 insertions(+)
> 
> diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
> index 56c54e0973..2dadb13845 100644
> --- a/target/mips/tcg/octeon.decode
> +++ b/target/mips/tcg/octeon.decode
> @@ -43,6 +43,8 @@ SEQ          011100 ..... ..... ..... 00000 101010 @r3
>   SNE          011100 ..... ..... ..... 00000 101011 @r3
>   SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
>   SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
> +&r2          rs rt
> +MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
>   
>   &saa         base rt
>   @saa         ...... base:5 rt:5 ................ &saa
> diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
> index f94f765055..186200036e 100644
> --- a/target/mips/tcg/octeon_translate.c
> +++ b/target/mips/tcg/octeon_translate.c
> @@ -216,6 +216,60 @@ static bool trans_ZCBT(DisasContext *ctx, arg_zcb *a)
>       return trans_ZCB(ctx, a);
>   }
>   
> +static ptrdiff_t octeon_tc_mpl_offset(unsigned int index)
> +{
> +    return offsetof(CPUMIPSState, active_tc.octeon.MPL[index]);
> +}
> +
> +static ptrdiff_t octeon_tc_p_offset(unsigned int index)
> +{
> +    return offsetof(CPUMIPSState, active_tc.octeon.P[index]);
> +}
> +
> +static void octeon_store_tc_field(ptrdiff_t offset, TCGv_i64 value)
> +{
> +    tcg_gen_st_i64(value, tcg_env, offset);
> +}

Are these really helpful?

> +static void octeon_zero_partial_product_state(void)
> +{
> +    TCGv_i64 zero = tcg_constant_i64(0);
> +
> +    for (int i = 0; i < 2 * 3; i++) {
> +        octeon_store_tc_field(octeon_tc_p_offset(i), zero);
> +    }
> +}

You probably want to use ARRAY_SIZE instead of "2 * 3".

> +static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
> +{
> +    TCGv_i64 value = tcg_temp_new_i64();
> +
> +    gen_load_gpr(value, a->rs);
> +    octeon_store_tc_field(octeon_tc_mpl_offset(index), value);
> +    gen_load_gpr(value, a->rt);
> +    octeon_store_tc_field(octeon_tc_mpl_offset(index + 3), value);
> +    if (index == 0) {
> +        octeon_clear_upper_multiplier_state();
> +    }

This does not correspond to my documentation.

     MPL0<63:0> = GPR[rs]
     P0 = 0
     P1 = 0
     P2 = 0

So: where's that + 3 copy come from, and where does the clear come from?


r~

