Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C33D1812F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 16:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0NpG-0007YD-5e; Mon, 14 Oct 2024 12:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0NpD-0007XU-SI
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:21:39 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0NpC-00080W-4E
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:21:39 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7ea6a4f287bso1285280a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728922896; x=1729527696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iKi8nhm8LRThhA7OaGrGE7Fu7+K48a8MyXrhua5J6u0=;
 b=JgvkFTwg6i6R70N/cW8IVgHfRVyYWEi1bLjZdvta96vy9H0OCPzgotyrRckvstDP/F
 kf860k8lBfxZCgrxAT5yboLHYf6Mn1RfMFL36K09ytpCQs43ZEOSDlmYgFcHmJ5iyueL
 aacu6Y8C3FrMnO+eZKF9tDbdZ4aDPD1VjVAplxqLGmZFqZzEsXTwvY2CP5OB74Yn2TeW
 5dX0ajdfOyf4ZP1qd5ZoFaW8P9DdQbf0VleWLtbqVrHt0BvQ0r+gV992QIsLw7NW88kb
 meO13K4pioury1A10GfGrvs283jLwBPRQKLwyXtGIiSbxQ9OizN9sj9rzdenKFWZjRm9
 FFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728922896; x=1729527696;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iKi8nhm8LRThhA7OaGrGE7Fu7+K48a8MyXrhua5J6u0=;
 b=mo1CT5YMUyQqDzNAxsxYF4+Cz6PcfQrkCUExhcMQtPtdWISP7+8hztsAZa2Epx3Ie5
 cZa128X454/3tuQXRCUAZLM6Hz9dOrLYwqqMD2N7vqRCaqOqFg2T2bU5EZIRZLe7wLY3
 SldxFupyjm7V7TW8yqWJTW8MxjtemWvCGOtYIscnLMHgON9pCpZNpZ2shJzaJXarB2a3
 zrmScjmjomwYcXziryWUhqYvOl6+u+li5ffrLA2eirk1NUReaoKBiAeC9bddos47h53R
 80264hnTs9hNQbaFLdqHA6dg6HmUKIP0jSClZXmTvcOm/PBcZYyA9kahqOmAekORhOkP
 ZwMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwuvTLUqNFhhuS8+iwknuKdMU5xAw/QBhTKqu89eLEQa2MGNR24GinjdMvGl+8erzAxh1eo1AygRBV@nongnu.org
X-Gm-Message-State: AOJu0YzXOHnAQW30NucNKYWC6eNXCA9MvNmMFrvjWsmeWOjJZa8zigIo
 du7xQzExB1S6IA5/x3tvvPVcjGD48+yigcl4oOyyQKkbtFvVyue3zPc2w7JGmP8sG+9eUClHSRe
 e
X-Google-Smtp-Source: AGHT+IE7BQJE81GRux7pM+E8N2XzpfefkP4mNs8SnDbLWm63VHNUi6qPlvG/nXap5yOHlTjK68I4iw==
X-Received: by 2002:a17:902:e742:b0:205:8275:768 with SMTP id
 d9443c01a7336-20cbb1a91a3mr106124455ad.21.1728922896359; 
 Mon, 14 Oct 2024 09:21:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c0f2272sm67658015ad.136.2024.10.14.09.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 09:21:35 -0700 (PDT)
Message-ID: <d429c462-22d8-4df8-9cf1-3ec0105357b0@linaro.org>
Date: Mon, 14 Oct 2024 09:21:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] arm: Add FEAT_XS's TLBI NXS variants
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20241014-arm-feat-xs-v1-0-42bb714d6b11@linaro.org>
 <20241014-arm-feat-xs-v1-1-42bb714d6b11@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241014-arm-feat-xs-v1-1-42bb714d6b11@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 10/14/24 03:48, Manos Pitsidianakis wrote:
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   target/arm/cpu-features.h |   5 +
>   target/arm/helper.c       | 366 +++++++++++++++++++++++++++-------------------
>   2 files changed, 218 insertions(+), 153 deletions(-)
> 
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 04ce2818263e2c3b99c59940001b65302e1d26d2..b4dcd429c3540e18c44d3c30f82f030be45719f2 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -970,6 +970,11 @@ static inline bool isar_feature_aa64_sme_fa64(const ARMISARegisters *id)
>       return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, FA64);
>   }
>   
> +static inline bool isar_feature_aa64_xs(const ARMISARegisters *id)
> +{
> +    return FIELD_SEX64(id->id_aa64isar1, ID_AA64ISAR1, XS) >= 0;
> +}
> +
>   /*
>    * Feature tests for "does this exist in either 32-bit or 64-bit?"
>    */
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 3f77b40734f2db831254a0e4eb205751aec0d1e5..3104a2d1dab6e58bf454c75afd478ec6d5fe521f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5671,98 +5671,111 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
>         .fgt = FGT_DCCISW,
>         .access = PL1_W, .accessfn = access_tsw, .type = ARM_CP_NOP },
>       /* TLBI operations */
> -    { .name = "TLBI_VMALLE1IS", .state = ARM_CP_STATE_AA64,
> +#define TLBI(name, opc0, opc1, crn, crm, opc2, access, accessfn, type, fgt, \
> +             writefn)                                                       \
> +{ name, .state = ARM_CP_STATE_AA64, opc0, opc1, crn, crm, opc2, access,     \
> +  accessfn, type, fgt, writefn },                                           \
> +{ name"NXS", .state = ARM_CP_STATE_AA64, opc0, opc1, crn + 1, crm, opc2,    \
> +   access, accessfn, type, fgt, writefn }

You cannot insert the NXS operations into the existing arrays.
They must be separate, so that they are registered only if FEAT_XS is present.

You can see this with the split between v8_cp_reginfo[] and tlbirange_reginfo[].

> @@ -9201,7 +9260,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                                  R_ID_AA64ISAR1_SB_MASK |
>                                  R_ID_AA64ISAR1_BF16_MASK |
>                                  R_ID_AA64ISAR1_DGH_MASK |
> -                               R_ID_AA64ISAR1_I8MM_MASK },
> +                               R_ID_AA64ISAR1_I8MM_MASK |
> +                               R_ID_AA64ISAR1_XS_MASK },

This is incorrect.  Here we are emulating

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/arch/arm64/cpu-feature-registers.rst#n208

and XS is not present.  Nor should it be, since cache flushing is not something that 
userland may do.


r~

