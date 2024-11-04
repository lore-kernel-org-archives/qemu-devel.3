Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63400D132AC
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 11:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7unz-0006o9-Li; Mon, 04 Nov 2024 05:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t7uny-0006nr-I9
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:59:30 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t7unw-0004Wv-MK
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:59:30 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a86e9db75b9so652888166b.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 02:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730717966; x=1731322766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mz5OMtV/UHaaM9hW7xpbIoTcAeBFVS80t+xWnzGlhMA=;
 b=iqH3iZIc9T+cJWkiuhPHhq9ZJ3f+54bow5R1COM2jUyLWMJmB2QuqC4O+5HUToAZv9
 8pk0NngAYPAxTP8jpeciQ9wV3UfM/AELwMZgQj8hlI4nNGrJMjMwzmR2SzUx1eDIlLy4
 hmrNRDXuPXczXqtPwnFciCNhB6CViunic+2ZegkFF0JeERv11s8JyTONM/DMAn8QjF51
 KRIhnB2jg+t2O7j/zHfA0DKMyPwoz2UMW0psZTRmwwM/n+fSQSVcT/YJag9XKk8qjxER
 g9n+QqFKvRLRAmJvfdAKn+VOWMPmllzt8D7bscdor12Y3T5cXVcuIqQD+l6JvRbNl8Um
 9jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730717966; x=1731322766;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mz5OMtV/UHaaM9hW7xpbIoTcAeBFVS80t+xWnzGlhMA=;
 b=ZsuRVNsJaZ/YznZu9El9KEMeYFEBTH6/OadpSx7eqDYgFs+jr6cGJ/HsaG+nsq3Ixo
 rQIJWvjucaw0A29tdxTpwOFHgrQfcRNHVjVpNcxpSanpbLI7XHw8DLdvA63eRqhKQGqT
 qBOvcjH7fPCMfGWZAsVMx8YJ09/rbGiMs96RkHSxUZZ++3k8bM3jeVZcvkZ00LOSkt/x
 sUzrW48iEsxUWvIFpBbo8aafyJDqe4OOFDt1K/zgZ0Z5RzOsxl4clGOeYqxn3k/7Wo1v
 pN4RIU5hAlajB70qomGlphoTLvlNJMvlegcu7VCT7y38C3rD6rLTY8lmmOAV1mW7HiHW
 Ua3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGF4GJlR7ceOfUZwy/dldOCpEiXyU1CqnswAMFnQHg7SxOjIBMlZ/0CjnfA9oDxCELuTTXRfNzJ9ku@nongnu.org
X-Gm-Message-State: AOJu0YzT6MGd4Ld/flL1QYNLTTo3MkmlaXBKCeFYuOzD83qxFLaL2SEM
 8cY3V6vJVUQFO5Zm1+aqa8eJBGaiOXUyJz7lEj8oV8I/3eDRy3YOyzqC4gDpdeo=
X-Google-Smtp-Source: AGHT+IErrJSAtuCjMlQ1BeVsU2ECBAy6ra5jp7xH8Qm9FpUreP+5N1mNZHe+3ur+HWzWEjcDF80cug==
X-Received: by 2002:a17:906:7310:b0:a99:f779:ae0c with SMTP id
 a640c23a62f3a-a9e50916803mr1632279666b.25.1730717966455; 
 Mon, 04 Nov 2024 02:59:26 -0800 (PST)
Received: from [192.168.21.227] ([91.223.100.66])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e565ef518sm538538466b.118.2024.11.04.02.59.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 02:59:26 -0800 (PST)
Message-ID: <9994b8dd-0522-43ff-94ff-1a94aafd5ce2@linaro.org>
Date: Mon, 4 Nov 2024 10:59:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Enable FEAT_CMOW for -cpu max
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org
References: <20241101013541.883785-1-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241101013541.883785-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
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

On 11/1/24 01:35, Gustavo Romero wrote:
> FEAT_CMOW introduces support for controlling cache maintenance
> instructions executed in EL0/1 and is mandatory from Armv8.8.
> 
> On real hardware, the main use for this feature is to prevent processes
> from invalidating or flushing cache lines for addresses they only have
> read permission, which can impact the performance of other processes.
> 
> QEMU implements all cache instructions as NOPs, and, according to rule
> [1], which states that generating any Permission fault when a cache
> instruction is implemented as a NOP is implementation-defined, no
> Permission fault is generated for any cache instruction when it lacks
> read and write permissions.
> 
> QEMU does not model any cache topology, so the PoU and PoC are before
> any cache, and rules [2] apply. These rules states that generating any
> MMU fault for cache instructions in this topology is also
> implementation-defined. Therefore, for FEAT_CMOW, we do not generate any
> MMU faults either, instead, we only advertise it in the feature
> register.
> 
> [1] Rule R_HGLYG of section D8.14.3, Arm ARM K.a.
> [2] Rules R_MZTNR and R_DNZYL of section D8.14.3, Arm ARM K.a.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 1 +
>   target/arm/cpu-features.h     | 5 +++++
>   target/arm/cpu.h              | 1 +
>   target/arm/tcg/cpu64.c        | 1 +
>   4 files changed, 8 insertions(+)
> 
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index 35f52a54b1..a2a388f091 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -26,6 +26,7 @@ the following architecture extensions:
>   - FEAT_BF16 (AArch64 BFloat16 instructions)
>   - FEAT_BTI (Branch Target Identification)
>   - FEAT_CCIDX (Extended cache index)
> +- FEAT_CMOW (Control for cache maintenance permission)
>   - FEAT_CRC32 (CRC32 instructions)
>   - FEAT_Crypto (Cryptographic Extension)
>   - FEAT_CSV2 (Cache speculation variant 2)
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 04ce281826..e806f138b8 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -802,6 +802,11 @@ static inline bool isar_feature_aa64_tidcp1(const ARMISARegisters *id)
>       return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, TIDCP1) != 0;
>   }
>   
> +static inline bool isar_feature_aa64_cmow(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, CMOW) != 0;
> +}

This isn't used, so it may be omitted.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> +
>   static inline bool isar_feature_aa64_hafs(const ARMISARegisters *id)
>   {
>       return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) != 0;
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 8fc8b6398f..1ea4c545e0 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1367,6 +1367,7 @@ void pmu_init(ARMCPU *cpu);
>   #define SCTLR_EnIB    (1U << 30) /* v8.3, AArch64 only */
>   #define SCTLR_EnIA    (1U << 31) /* v8.3, AArch64 only */
>   #define SCTLR_DSSBS_32 (1U << 31) /* v8.5, AArch32 only */
> +#define SCTLR_CMOW    (1ULL << 32) /* FEAT_CMOW */
>   #define SCTLR_MSCEN   (1ULL << 33) /* FEAT_MOPS */
>   #define SCTLR_BT0     (1ULL << 35) /* v8.5-BTI */
>   #define SCTLR_BT1     (1ULL << 36) /* v8.5-BTI */
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 0168920828..2963d7510f 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1218,6 +1218,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>       t = FIELD_DP64(t, ID_AA64MMFR1, ETS, 2);      /* FEAT_ETS2 */
>       t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* FEAT_HCX */
>       t = FIELD_DP64(t, ID_AA64MMFR1, TIDCP1, 1);   /* FEAT_TIDCP1 */
> +    t = FIELD_DP64(t, ID_AA64MMFR1, CMOW, 1);     /* FEAT_CMOW */
>       cpu->isar.id_aa64mmfr1 = t;
>   
>       t = cpu->isar.id_aa64mmfr2;


