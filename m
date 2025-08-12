Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC569CA0ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 00:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulckn-0000kJ-OJ; Mon, 11 Aug 2025 20:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulckk-0000jx-R4
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 20:20:34 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulcke-0006Gm-IH
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 20:20:34 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7698e914cd2so6127447b3a.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 17:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754958022; x=1755562822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EbL9Rd2Jhd8DiF1ZC7jeZZK+l6NZxwUsdmsfhlCKuhE=;
 b=vqrQ2xLQ3MMLVuDEgHon8UqaP5C20vXiGeDKuLTMg+6LF08EJyNCSlM35oRPYx4wSK
 R53P3pdWwcibR0glcnDd1C7nm0lz2SxMiQGB2H/uzABj915zb66AkYrEsFoi1f1Wj6wL
 LbszvPBw+AqywqgdOyT0yo4i/n6UC0xK73DeX8ugxQIkzoukAGcQ8EOooDrcLeLx2xP6
 0S81H/TU6f7g9eRKkz2tolb18Ae9rZ6jCTCpUeBB0LFKbShbUbVZTln1qnpq6oeCZ3nc
 eE2z8CAtsgBc5Xk1USXKc1yK11NQyLkzlZYHhBBMw1+F0ExiyNXk/qPa/V+uAurwMlcn
 XnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754958022; x=1755562822;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EbL9Rd2Jhd8DiF1ZC7jeZZK+l6NZxwUsdmsfhlCKuhE=;
 b=eNIl1Q1a6qjTPLp5wibFDbOqKV+Xa/79axByYHHtHX+6rP0oNM4faXb5n47VQlsFJe
 fw4y/T0wGPDC6bOPSv66IxMQJmHRBWx5zX1VjO7dLrad2HRksz6ai4rnMlYb17+1kclI
 +gWkGQ8b/s6nKvDxy6C9hVCXR/aPGDeiz3A+GLP++HgQgfDuxukojO2L63bizhpafUOd
 lYkkCI9E55LxRKAO1J8MHhvidk/gjArV3JrEbK0wWCvDh0u1z9SRIk+3m9tfrDoUWLr2
 upENdkS6fFjL8QudOVGBVU10NXjjfmk0ylTjR5K5+N5bVwcYXeROMdAgt62Yf0GvjaNW
 pUXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSvva4aPylnR5K+ByhJ+qWVzTq76/qQdsWiATcauwv6lefpgrcW+buJE3h3RElqHh8N0yf/YqZOb7q@nongnu.org
X-Gm-Message-State: AOJu0Yw9n0xhJy+JaWO9UhxA/uZnvt0rYWTA3KOxcEEMAGwaK6qr+Y2g
 ipYO1A0ybleIoj2ueAEOcIRq7/B3USqLWZQXSZTTxntYIcc6JhHtSGEjiJ6w8wAYRgA=
X-Gm-Gg: ASbGnculo9N8x9i82mD9KSDNrOEtGjznZ4ZEy3R98Pox+avgP/KkMtml6pSxiklF23W
 rZNAmWcO+Lb5CqKCDvWIqdDmffWxbk4xSfwKMKl506qtc1HMT8xoevqqRN1mGdwefp79bbhBIHr
 btQtOFFVo5DaTd1QsW9+7QaSE6SbNJSGz/kZRUrkrbYOCSC6mJv2dyLhprKIyORBGW33ITumheF
 IoJQYdXBhla51FEXOCQM5jA08Ic9eLwSGgPENRbnSyaeY9U2W0HlTN46mcQiwD5i4bHQ3gDG45/
 ung/HaoyDsYMWkQCZ6/81DStuycbQ/haSpn8cdYULuWmB1TlY0vXf23DyACjzgPNZaGWEx6r/MY
 Kl589RbAwzNvB5kfaKjifbomxeYk+UrIjv8/Wb+AfNg==
X-Google-Smtp-Source: AGHT+IHW/Fq1zfjNdu+tpnvYkenb3pJ71O7q8uoMYcJaaM863K7/XGZKdIrGYOtcwi31D0ha3sKp7A==
X-Received: by 2002:a05:6a21:6da9:b0:240:1bdb:bed2 with SMTP id
 adf61e73a8af0-2409a9932ffmr1897235637.32.1754958022308; 
 Mon, 11 Aug 2025 17:20:22 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfbd7d1sm27948174b3a.80.2025.08.11.17.20.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 17:20:21 -0700 (PDT)
Message-ID: <ce436008-3a53-4e31-a563-188cb3b1654d@linaro.org>
Date: Tue, 12 Aug 2025 10:20:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/11] target/arm/hvf: Sync registers used at EL2
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250811170611.37482-1-philmd@linaro.org>
 <20250811170611.37482-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250811170611.37482-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 8/12/25 03:06, Philippe Mathieu-Daudé wrote:
> From: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> When starting up the VM at EL2, more sysregs are available. Sync the state of those.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> [PMD: Adapted to host_cpu_feature_supported() API]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 5174973991f..778dc3cedf7 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -400,6 +400,7 @@ static const struct hvf_reg_match hvf_fpreg_match[] = {
>   struct hvf_sreg_match {
>       int reg;
>       uint32_t key;
> +    bool el2;
>       uint32_t cp_idx;
>   };
>   
> @@ -545,6 +546,27 @@ static struct hvf_sreg_match hvf_sreg_match[] = {
>       { HV_SYS_REG_CNTV_CTL_EL0, HVF_SYSREG(14, 3, 3, 3, 1) },
>       { HV_SYS_REG_CNTV_CVAL_EL0, HVF_SYSREG(14, 3, 3, 3, 2) },
>       { HV_SYS_REG_SP_EL1, HVF_SYSREG(4, 1, 3, 4, 0) },
> +    /* EL2 */
> +    { HV_SYS_REG_CPTR_EL2, HVF_SYSREG(1, 1, 3, 4, 2), .el2 = true },
> +    { HV_SYS_REG_ELR_EL2, HVF_SYSREG(4, 0, 3, 4, 1), .el2 = true },
> +    { HV_SYS_REG_ESR_EL2, HVF_SYSREG(5, 2, 3, 4, 0), .el2 = true },
> +    { HV_SYS_REG_FAR_EL2, HVF_SYSREG(6, 0, 3, 4, 0), .el2 = true },
> +    { HV_SYS_REG_HCR_EL2, HVF_SYSREG(1, 1, 3, 4, 0), .el2 = true },
> +    { HV_SYS_REG_HPFAR_EL2, HVF_SYSREG(6, 0, 3, 4, 4), .el2 = true },
> +    { HV_SYS_REG_MAIR_EL2, HVF_SYSREG(10, 2, 3, 4, 0), .el2 = true },
> +    { HV_SYS_REG_MDCR_EL2, HVF_SYSREG(1, 1, 3, 4, 1), .el2 = true },
> +    { HV_SYS_REG_SCTLR_EL2, HVF_SYSREG(1, 0, 3, 4, 0), .el2 = true },
> +    { HV_SYS_REG_SPSR_EL2, HVF_SYSREG(4, 0, 3, 4, 0), .el2 = true },
> +    { HV_SYS_REG_SP_EL2, HVF_SYSREG(4, 1, 3, 6, 0), .el2 = true},
> +    { HV_SYS_REG_TCR_EL2, HVF_SYSREG(2, 0, 3, 4, 2), .el2 = true },
> +    { HV_SYS_REG_TPIDR_EL2, HVF_SYSREG(13, 0, 3, 4, 2), .el2 = true },
> +    { HV_SYS_REG_TTBR0_EL2, HVF_SYSREG(2, 0, 3, 4, 0), .el2 = true },
> +    { HV_SYS_REG_TTBR1_EL2, HVF_SYSREG(2, 0, 3, 4, 1), .el2 = true },
> +    { HV_SYS_REG_VBAR_EL2, HVF_SYSREG(12, 0, 3, 4, 0), .el2 = true },
> +    { HV_SYS_REG_VMPIDR_EL2, HVF_SYSREG(0, 0, 3, 4, 5), .el2 = true },
> +    { HV_SYS_REG_VPIDR_EL2, HVF_SYSREG(0, 0, 3, 4, 0), .el2 = true },
> +    { HV_SYS_REG_VTCR_EL2, HVF_SYSREG(2, 1, 3, 4, 2), .el2 = true },
> +    { HV_SYS_REG_VTTBR_EL2, HVF_SYSREG(2, 1, 3, 4, 0), .el2 = true },

Note that el2 == opc1 in {4,5}.

> @@ -588,6 +610,12 @@ int hvf_get_registers(CPUState *cpu)
>               continue;
>           }
>   
> +        if (hvf_sreg_match[i].el2
> +            && arm_feature(env, ARM_FEATURE_EL2)
> +            && !host_cpu_feature_supported(ARM_FEATURE_EL2, false)) {

Why are you checking both arm_feature and host_cpu_feature_supported?
Surely by the time we get to hvf_get/put_registers we have already detected the host cpu 
features and have updated env to match.


r~

