Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D49D10C00
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 17:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4kZT-0002WE-Ml; Sat, 26 Oct 2024 13:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4kZS-0002SZ-6y
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:27:26 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4kZQ-0000LZ-IL
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:27:25 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so1993911a12.2
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 10:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729963642; x=1730568442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V+w83/fuWr/Cdw8zeU0XSK8IK+Cws/tHifvrrGAx1vU=;
 b=P/hUKDojsH2YWYfC5aI/Z2GBe3no+C8CySgVp4g1J0XY+ql/+m5q9bNKc/D+BOwCc8
 RvzS+EwBRto7p2U17LXAdcv6Wd9lMhiK3QBMT4cYYi76l3aX3o2RBd1GzxDwCQQvXvkh
 umz1EnBkMt4q3gcAhlhMtzD3mjFkp/c7k+ZoEJvCmR+D94UNsmFQ6iWvSIvHo2lOJNg9
 NT3pqExUxlwlpB/uu0wRnSXPD01yiBn0r7OIfMEBqdTWGQuCA5MLtB4Gpv0qh9tYozup
 u9kIOSUEGcrXfvyuE4m38+klPQPcEUE7hofU2pqo0Q/7l8JNbMCa1nQN9MWLPbf0zCDy
 ep7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729963642; x=1730568442;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V+w83/fuWr/Cdw8zeU0XSK8IK+Cws/tHifvrrGAx1vU=;
 b=IKLJ4QtVbXPthoUFE+1NdXpiz3250jw5bjQfZ+vFqG8Knf57q/LHcYWo0/v09Hxusx
 d4DtXPvBwNuW4kkvyQ0LP35wnH1MHxMxdhyAN6dvo7/w6Kap/0fdKf7iJGGQckWHNqyB
 A2diCw+zLZNGlU+HjdcC1yNYKk5yfyc3R8ribUxfXUyrKxMV8U7wLf4W0BnVgh1VTKlO
 3JJjPEbJPz51M9dImS3tBoaQbt9IvdvPW3isbPCiE2kd6ilyv+hE64qG8edlyuqKc7t5
 ebbK8PD2hNV/HqAvf1+VoZSsvqGTdfdx6H0ryx3gRYUotEy6d67wF03nmwsjuT/XAJJL
 uqGw==
X-Gm-Message-State: AOJu0YzYswvmmAKCx5ZADi63oQ8Hnd2xR0mwBAGHm7vteEjzbgfLWjLt
 8zlodnxhi38TAo3t7ZYlgpS97Gz6ccDivSF299dmUCO/kfkDqM20ql8VV8ODWB5TwXPe+wsQbk7
 H
X-Google-Smtp-Source: AGHT+IGN8bNFverxPPGyN7Jb33uD3+AM/XbI5Y1rk8GammtW1Jibm/+Sfotx2+XUbqlBkhyrHxMMEA==
X-Received: by 2002:a05:6a20:e198:b0:1d6:fd8c:fa16 with SMTP id
 adf61e73a8af0-1d9a850541dmr4392550637.46.1729963641825; 
 Sat, 26 Oct 2024 10:27:21 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edc89f2d5bsm2995901a12.57.2024.10.26.10.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Oct 2024 10:27:21 -0700 (PDT)
Message-ID: <6daa0815-c3b7-4272-9ba2-ab290384ed19@linaro.org>
Date: Sat, 26 Oct 2024 14:27:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: Remove unreachable 32-bit code on 64-bit
 Loongson Ext
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20241026154550.78880-1-philmd@linaro.org>
 <c6eea5c7-7ca1-4340-beeb-72241c0b2bf0@linaro.org>
Content-Language: en-US
In-Reply-To: <c6eea5c7-7ca1-4340-beeb-72241c0b2bf0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 26/10/24 14:20, Philippe Mathieu-Daudé wrote:
> On 26/10/24 12:45, Philippe Mathieu-Daudé wrote:
>> Loongson fixed-point multiplies and divisions opcodes are
>> specific to 64-bit cores (Loongson-2 and Loongson-3 families).
>> Simplify by removing the 32-bit checks.
>>
>> Reported-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Based-on: <20230831203024.87300-1-philmd@linaro.org>
>> ---
>>   target/mips/tcg/loong_translate.c | 43 +++----------------------------
>>   target/mips/tcg/translate.c       |  2 +-
>>   target/mips/tcg/meson.build       |  2 +-
>>   3 files changed, 6 insertions(+), 41 deletions(-)
> 
> 
>> @@ -295,6 +258,8 @@ static bool trans_DMULTu_G(DisasContext *s, 
>> arg_muldiv *a)
>>   bool decode_ext_loongson(DisasContext *ctx, uint32_t insn)
>>   {
>> +    assert(ctx->hflags & MIPS_HFLAG_64);
>> +
>>       if ((ctx->insn_flags & INSN_LOONGSON2E)
>>               && decode_godson2(ctx, ctx->opcode)) {
>>           return true;
>> diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
>> index 9839575247e..68a5c21bb2d 100644
>> --- a/target/mips/tcg/translate.c
>> +++ b/target/mips/tcg/translate.c
>> @@ -15020,7 +15020,7 @@ static void decode_opc(CPUMIPSState *env, 
>> DisasContext *ctx)
>>       if (cpu_supports_isa(env, INSN_VR54XX) && decode_ext_vr54xx(ctx, 
>> ctx->opcode)) {
>>           return;
>>       }
>> -    if (decode_ext_loongson(ctx, ctx->opcode)) {
>> +    if (TARGET_LONG_BITS == 64 && decode_ext_loongson(ctx, 
>> ctx->opcode)) {
>>           return;
>>       }
> 
> Thinking of single binary, better is to extract decode_running_64bit()
> and check as runtime; IOW squash:
> 
> -- >8 --
> diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
> index 36f3396477a..aa70f27fbba 100644
> --- a/target/mips/tcg/translate.h
> +++ b/target/mips/tcg/translate.h
> @@ -219,0 +220,2 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn);
> +bool decode_running_64bit(DisasContext *ctx);
> +
> diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
> index 68a5c21bb2d..67480106226 100644
> --- a/target/mips/tcg/translate.c
> +++ b/target/mips/tcg/translate.c
> @@ -1617,0 +1618,5 @@ static inline void check_ps(DisasContext *ctx)
> +bool decode_running_64bit(DisasContext *ctx)
> +{
> +    return ctx->hflags & MIPS_HFLAG_64;
> +}
> +
> @@ -1624 +1629 @@ void check_mips_64(DisasContext *ctx)
> -    if (unlikely((TARGET_LONG_BITS != 64) || !(ctx->hflags & 
> MIPS_HFLAG_64))) {
> +    if (unlikely((TARGET_LONG_BITS != 64) || 
> !decode_running_64bit(ctx))) {
> @@ -15023 +15028 @@ static void decode_opc(CPUMIPSState *env, 
> DisasContext *ctx)
> -    if (TARGET_LONG_BITS == 64 && decode_ext_loongson(ctx, ctx->opcode)) {
> +    if (decode_running_64bit(ctx) && decode_ext_loongson(ctx, 
> ctx->opcode)) {
> diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
> index fd91148df74..fbb6d6eb407 100644
> --- a/target/mips/tcg/meson.build
> +++ b/target/mips/tcg/meson.build
> @@ -18,0 +19 @@ mips_ss.add(files(
> +  'loong_translate.c',
> @@ -33 +33,0 @@ mips_ss.add(when: 'TARGET_MIPS64', if_true: files(
> -  'loong_translate.c',
> ---

Eh not that fast... Still work to do before getting there:

target/mips/tcg/loong_translate.c:57:53: warning: implicit conversion 
from 'long long' to 'int32_t' (aka 'int') changes value from 
-9223372036854775808 to 0 [-Wconstant-conversion]
    57 |     tcg_gen_brcondi_tl(TCG_COND_NE, t0, is_double ? LLONG_MIN : 
INT_MIN, l2);
       |     ~~~~~~~~~~~~~~~~~~                              ^~~~~~~~~


