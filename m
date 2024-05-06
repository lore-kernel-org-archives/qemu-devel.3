Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B84AC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 14:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3z4t-0002rr-H5; Mon, 06 May 2024 10:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3z4e-0002nr-8S
 for qemu-devel@nongnu.org; Mon, 06 May 2024 10:12:13 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3z4b-0004yM-2T
 for qemu-devel@nongnu.org; Mon, 06 May 2024 10:12:10 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-51ff65b1e14so2327681e87.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 07:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715004727; x=1715609527; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2bumhZu9zHcL59l3ZUdMSQkrRfCpNmOMQc2cYu0vo8A=;
 b=PPtIK3MKDCfVh3MAlWlBw80Gk+6Jb1mx8gTOEZ/98E+XJIlSq7kNdo+cmq7ztUNnAl
 omKzg3BN/NAy9CkCdT3PtecAo8Xk24wG3zdj1H9Ji9Zww6rcbzdt0ISxBzQsStJZNFzM
 JJ3K0zFzCYuGcxZUf++luy/CIMdNxaabA+Drg+vLEOaQqizfJVTNT0ycGyjQmYpvuCUo
 DYBdgr56rHFgxxhX4iPJ06moXlbeYE7o94amhD472lefwvFFlJ1C1x+rImqUykimWy6k
 01bopjv4n8FKCn1sX9bIf2leH/MOgG5iuxWT/sOswd95P8PrVZAZKhPAm3tqmmPNCI2R
 qu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715004727; x=1715609527;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2bumhZu9zHcL59l3ZUdMSQkrRfCpNmOMQc2cYu0vo8A=;
 b=kf1xdkM9bdxa5OziL1EGHvqAi1XkCQIrl+WMvuasuzi6OwE8TWsHOwZb5BwiSdjxcW
 oJhH3N6OCEcX7ytZ5xJzhaF86ceeDh25kUgMyNX0f9zWxJhXg/uvTaM2jJ2d0PRji/wP
 UXluty77abqlV6PLOnJhKcgzhYVVLZC/WPm8wEmX/BY7Lqi0sCoVzL+VxgEedUW7pcDa
 6SIay7N6CdSivWuXoUfamlJZ56+NVmawM5k4yAZe1ibigjziQ45Vl12Bf/L3M3/NmCUm
 opYBijMxTqwwuP9cf6uN0SG4+7UFczriH1Izel/6FEj1IqRme+lb/BpBXhq7Jelktm9l
 qyMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnhjjz0MeaNitNcCsqMv5neIwM0fRs0EyMMFucteY9WVUK44PozCYE4hjKfMANKP1VMQN3bkirxk0uR5pcjhE+HK0s7pY=
X-Gm-Message-State: AOJu0YwvMt5X4i+84a/03zMMZXpVAz17SpzJhMPzH6T2IXoJLLFb+jJG
 h7DlWSBdYmsmMNVayJCaF157c1IrppdL7SFD3c6m31UedXMl87hEs1UEcPcheoc=
X-Google-Smtp-Source: AGHT+IG9VDPWBxIawuw6kzInVtqk+/tf+i/FS3YjXhyyn9bFJ+3F7V0Z8TcG4DwBf0nid+ckSBK9IQ==
X-Received: by 2002:a05:6512:238e:b0:520:9df8:f245 with SMTP id
 c14-20020a056512238e00b005209df8f245mr2441449lfv.1.1715004727020; 
 Mon, 06 May 2024 07:12:07 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a5d67ca000000b0034dcc70929dsm10752845wrw.83.2024.05.06.07.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 07:12:06 -0700 (PDT)
Message-ID: <f846aaed-5d58-4f23-8a89-fbea80e6f13a@linaro.org>
Date: Mon, 6 May 2024 16:12:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] target/sparc: Fix FMULD8*X16
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240502165528.244004-1-richard.henderson@linaro.org>
 <20240502165528.244004-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502165528.244004-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

On 2/5/24 18:55, Richard Henderson wrote:
> Not only do these instructions have f32 inputs, they also do not
> perform rounding.  Since these are relatively simple, implement
> them properly inline.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/helper.h     |  2 --
>   target/sparc/translate.c  | 48 +++++++++++++++++++++++++++++++++++----
>   target/sparc/vis_helper.c | 46 -------------------------------------
>   3 files changed, 44 insertions(+), 52 deletions(-)


> +static void gen_op_fmuld8ulx16(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
> +{
> +    TCGv_i32 t0 = tcg_temp_new_i32();
> +    TCGv_i32 t1 = tcg_temp_new_i32();
> +    TCGv_i32 t2 = tcg_temp_new_i32();
> +
> +    tcg_gen_ext8u_i32(t0, src1);
> +    tcg_gen_ext16s_i32(t1, src2);
> +    tcg_gen_mul_i32(t0, t0, t1);
> +
> +    tcg_gen_extract_i32(t1, src1, 16, 8);
> +    tcg_gen_sextract_i32(t2, src2, 16, 16);
> +    tcg_gen_mul_i32(t1, t1, t2);
> +
> +    tcg_gen_concat_i32_i64(dst, t0, t1);
> +}
> +
> +static void gen_op_fmuld8sux16(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
> +{
> +    TCGv_i32 t0 = tcg_temp_new_i32();
> +    TCGv_i32 t1 = tcg_temp_new_i32();
> +    TCGv_i32 t2 = tcg_temp_new_i32();
> +
> +    /*
> +     * The insn description talks about extracting the upper 8 bits
> +     * of the signed 16-bit input rs1, performing the multiply, then
> +     * shifting left by 8 bits.  Instead, zap the lower 8 bits of
> +     * the rs1 input, which avoids the need for two shifts.

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +     */
> +    tcg_gen_ext16s_i32(t0, src1);
> +    tcg_gen_andi_i32(t0, t0, ~0xff);
> +    tcg_gen_ext16s_i32(t1, src2);
> +    tcg_gen_mul_i32(t0, t0, t1);
> +
> +    tcg_gen_sextract_i32(t1, src1, 16, 16);
> +    tcg_gen_andi_i32(t1, t1, ~0xff);
> +    tcg_gen_sextract_i32(t2, src2, 16, 16);
> +    tcg_gen_mul_i32(t1, t1, t2);
> +
> +    tcg_gen_concat_i32_i64(dst, t0, t1);
> +}

