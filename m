Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3F5D0C604
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 17:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4kTK-0000IK-58; Sat, 26 Oct 2024 13:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4kTJ-0000IB-4Z
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:21:05 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4kTF-0007vD-Qi
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:21:04 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71e79f73aaeso2063358b3a.3
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 10:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729963259; x=1730568059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ahgDsqrmj/QDxdFPOicou4MwxOnySOGhDUHYAVuYiiE=;
 b=dDWPyZNE+5FyyQPxzG3UXUcQawWpshY96WVE1jbBAfXAqhV4v02oBsCBGtCJmUu8JZ
 nWMEd70+JzjSr9/xThx2zGtgUPqfjH33C8b0UUqhEZk3Mfi2vac8cWTQK1r8j5U3YBFb
 8L77QQ0Lnbn5kfesGsy7A+QeiNk8t5QzbY/R0KzFwZ4vaol2aLloZ75JLcDNENivZ6EM
 84758q7CcFwF+Sji1UpS9ui9bWWKmpAo0iiiJxRo+Uqg/Xc0F4hEBxoceApVOT8ZXSEr
 VgyDf9ADpY+O4OImmGHuvmX3eNm3aSf+KGr0D06kyjyoD5HqyqMfqYbEy+vRndkoVifS
 y+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729963259; x=1730568059;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ahgDsqrmj/QDxdFPOicou4MwxOnySOGhDUHYAVuYiiE=;
 b=TrACwp2lgg8KoyTSTQ+VZRSFS7rUn2nA++DlJ379aBhpP/61b0Xypha+mf2sX26bcj
 WU2PQrfl1YJxEOom4Wffkxt+gJPNvoZyAY+y215QhwxhWvMvsI+JQL8obBh9YPH0tYJv
 r9TLJ8IqjhayDb1Hy/8ySmtuRG1oOdAZ4iETH0m6lrBVGRIMbE9t2hyuO+t8EVw5v6Tb
 n1i3x+hv/yBHIFuqGk/X/h9GMSDkySTM43ZJAh802Q5h5MC4PhLGQJDFHMcruXonbNF8
 i1mXe94E1ENcDlYAChBDfinoW/YAQRaeu4gOL3BqrBwd4LkUw764yWwOfPTMSg/47gE6
 BKCg==
X-Gm-Message-State: AOJu0Yx8cAEzddGGRJpvdJe2Ed2q2+v6Iy9+xvrSBxtieCKop5yHNA5W
 ThYb0ErYk4nOAgl3NROb+9HmQgGJJlq+rjH1rV1RORa+JEVEaZuwWziRkVeV/UukE59uWwWnaiC
 A
X-Google-Smtp-Source: AGHT+IHeSbokbm7YpswkK5/pZKoK4dljaMbFaFYd8IGmWIZdAkrFECKuFwXxfn2yZDpXY4DrWSWFMw==
X-Received: by 2002:a05:6a00:4b52:b0:71e:b1dc:f229 with SMTP id
 d2e1a72fcca58-7206306ecbbmr5101874b3a.19.1729963258746; 
 Sat, 26 Oct 2024 10:20:58 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edc8a3d0cesm2987143a12.80.2024.10.26.10.20.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Oct 2024 10:20:58 -0700 (PDT)
Message-ID: <c6eea5c7-7ca1-4340-beeb-72241c0b2bf0@linaro.org>
Date: Sat, 26 Oct 2024 14:20:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: Remove unreachable 32-bit code on 64-bit
 Loongson Ext
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20241026154550.78880-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241026154550.78880-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42b.google.com
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

On 26/10/24 12:45, Philippe Mathieu-Daudé wrote:
> Loongson fixed-point multiplies and divisions opcodes are
> specific to 64-bit cores (Loongson-2 and Loongson-3 families).
> Simplify by removing the 32-bit checks.
> 
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20230831203024.87300-1-philmd@linaro.org>
> ---
>   target/mips/tcg/loong_translate.c | 43 +++----------------------------
>   target/mips/tcg/translate.c       |  2 +-
>   target/mips/tcg/meson.build       |  2 +-
>   3 files changed, 6 insertions(+), 41 deletions(-)


> @@ -295,6 +258,8 @@ static bool trans_DMULTu_G(DisasContext *s, arg_muldiv *a)
>   
>   bool decode_ext_loongson(DisasContext *ctx, uint32_t insn)
>   {
> +    assert(ctx->hflags & MIPS_HFLAG_64);
> +
>       if ((ctx->insn_flags & INSN_LOONGSON2E)
>               && decode_godson2(ctx, ctx->opcode)) {
>           return true;
> diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
> index 9839575247e..68a5c21bb2d 100644
> --- a/target/mips/tcg/translate.c
> +++ b/target/mips/tcg/translate.c
> @@ -15020,7 +15020,7 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
>       if (cpu_supports_isa(env, INSN_VR54XX) && decode_ext_vr54xx(ctx, ctx->opcode)) {
>           return;
>       }
> -    if (decode_ext_loongson(ctx, ctx->opcode)) {
> +    if (TARGET_LONG_BITS == 64 && decode_ext_loongson(ctx, ctx->opcode)) {
>           return;
>       }

Thinking of single binary, better is to extract decode_running_64bit()
and check as runtime; IOW squash:

-- >8 --
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 36f3396477a..aa70f27fbba 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -219,0 +220,2 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn);
+bool decode_running_64bit(DisasContext *ctx);
+
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 68a5c21bb2d..67480106226 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1617,0 +1618,5 @@ static inline void check_ps(DisasContext *ctx)
+bool decode_running_64bit(DisasContext *ctx)
+{
+    return ctx->hflags & MIPS_HFLAG_64;
+}
+
@@ -1624 +1629 @@ void check_mips_64(DisasContext *ctx)
-    if (unlikely((TARGET_LONG_BITS != 64) || !(ctx->hflags & 
MIPS_HFLAG_64))) {
+    if (unlikely((TARGET_LONG_BITS != 64) || !decode_running_64bit(ctx))) {
@@ -15023 +15028 @@ static void decode_opc(CPUMIPSState *env, 
DisasContext *ctx)
-    if (TARGET_LONG_BITS == 64 && decode_ext_loongson(ctx, ctx->opcode)) {
+    if (decode_running_64bit(ctx) && decode_ext_loongson(ctx, 
ctx->opcode)) {
diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index fd91148df74..fbb6d6eb407 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -18,0 +19 @@ mips_ss.add(files(
+  'loong_translate.c',
@@ -33 +33,0 @@ mips_ss.add(when: 'TARGET_MIPS64', if_true: files(
-  'loong_translate.c',
---

