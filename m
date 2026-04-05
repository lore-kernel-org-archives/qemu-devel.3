Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9D0E9D826
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 23:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Wu8-0007uR-DS; Sun, 05 Apr 2026 19:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Wu6-0007rr-QH
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:29:18 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Wu5-0003cx-0s
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:29:18 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82ce09b4197so1373899b3a.2
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 16:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775431755; x=1776036555; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XVJgRTKar0OKIkiaMyik766IrfuPggiR4vgPrf6SCBI=;
 b=RSxCkznasC2Z7qGDEIBW0dBcxSPSuz0AzD/53kTsoNG/D3S0vZRB5fp7yQ6VB3HN4B
 sqIJkSNWURLtXHf+UmqGHT4mZjER8GiZLueBCHluaCVqTelIVY2uerj68zXw+c/c+rFK
 La3aeqSiwAiEllKzPeEKsMK8wfMZOIjUIEgm2KhLwsM5moYTYCPCIFqSGE+Aup6JyHeA
 1tMzSVeHn171EvVYH3b5NcDKaOX8AilaEqXkF6H6O1ks0b1Ifa+67wImMSCtowOy+RBq
 eL7EV2aDfaNGT3pvotpkeBvDrHyc6erbdeSklC0Z+F/XqcpeeEOhdqqp4+Z7agl/1aKO
 84oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775431755; x=1776036555;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XVJgRTKar0OKIkiaMyik766IrfuPggiR4vgPrf6SCBI=;
 b=WIrrpuy31q2h+RMNU13UO4QEWIKNoi3XhVURWdTOCIvMMtfj/o11lNNHi1EZ4Ze+xn
 EhgisFwL8thykBIMP0NrhSMJKkRMGyQVW2LzUMXs39MoTbJId54PNVkEk6hfwQzaAK1v
 uAHaE2w7/VrB9bYOv+6Ne7JF1bfjAyTsGoXqZmsb7WxcXW4hSmW1CQzrkD4TpSEnmXWD
 zBk7Ib17Hs0dlPUjNgIgNkHa9YAxKZ4QcbcKFq/Ta/ZAOVnUZhYNKR7r9dogtWyGFu0h
 1ivLyYubVAJn4sKLBAXXCXfVcHrIftxzlm+DUDDQY2WEtAdNq1PuALfcCImOoc3VzVUD
 n0Wg==
X-Gm-Message-State: AOJu0Yz0o2t5+v09R5WPGSeoU+z94yA2h6VHHVfTjsZgpZ+TQUn6W+er
 QS4cvDYgLVZlbUTM9MmyartwLnjfnfXuMgjk8MlqRL9aigIM9PbjMiNhUvWZHL5p9oWTyqy/KYK
 N8VW1
X-Gm-Gg: AeBDietz/e0nomjBxrEYAND5Tfefjpj3bTE24xZQzMqeJ0zsD2Qwm/XoO4BvvT+DbAT
 kwa9ICgAPBakPLRWu6pNy6RFKv7e3ADvG/HfThrG+WwDMeg+K2hxEA08BF/GJAvFWdQhVpwSjHa
 rb5hW9SReEYHA3wVGCJGbVKdeyVxoZ/a/yQ51nKSsldeEB693gd8GBvO5HCtz5ncLPg91jh7xaA
 LHt1F55nL0tsF8gU4amaq868OkO+V4v1LaomtkbIY6L0ofG1lZVl1YPQw6/oGQ2WA4f2JolZLRd
 EQgFSreFgj8PBSAmTzadDUNT4JEOvVnj3f7WlWL1ULXOklvk7DLCxj6PGFI+lGf1jZzKCC3DJhO
 yrwXUkdhatFq1CVsPOTEj8nJiAlx1Ur3pu1HyFUf+iTDesjkWvXCFsMaXkz4mhslwK1yLniIB1u
 l7rT9KzbOLg0o6FutnUAuaAwZAdQZYnaOmYqSakCe3hoiy/YmJ8zIwp7CWw3i7QeKumRg=
X-Received: by 2002:a05:6a00:2282:b0:829:780d:99c9 with SMTP id
 d2e1a72fcca58-82d0db351a5mr11924122b3a.26.1775431755403; 
 Sun, 05 Apr 2026 16:29:15 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b3dcb3sm11864216b3a.16.2026.04.05.16.29.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 16:29:15 -0700 (PDT)
Message-ID: <c8b37585-7a12-47a7-abf5-ede046388406@linaro.org>
Date: Mon, 6 Apr 2026 09:29:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/35] target/arm: migrate BXJ trap syndromes to
 registerfields
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 3/21/26 00:05, Alex Bennée wrote:
> This is an Armv7 specific syndrome for chips with Jazelle
> functionality.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/syndrome.h | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
> index 0520e51a686..fb86e7bf6a8 100644
> --- a/target/arm/syndrome.h
> +++ b/target/arm/syndrome.h
> @@ -440,10 +440,26 @@ static inline uint32_t syn_btitrap(int btype)
>       return res;
>   }
>   
> +/*
> + * ISS encoding for trapped BXJ execution
> + *
> + * This is an Armv7 encoding.
> + */
> +FIELD(BXJ_ISS, RM, 0, 4)
> +/* bits 4:19 are Reserved, UNK/SBZP */
> +FIELD(BXJ_ISS, COND, 20, 4)
> +FIELD(BXJ_ISS, CV, 24, 1)
> +
>   static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
>   {
> -    return (EC_BXJTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL |
> -        (cv << 24) | (cond << 20) | rm;
> +    uint32_t res = syn_set_ec(0, EC_BXJTRAP);
> +    res = FIELD_DP32(res, SYNDROME, IL, 1);
> +
> +    res = FIELD_DP32(res, BXJ_ISS, CV, cv);
> +    res = FIELD_DP32(res, BXJ_ISS, COND, cond);
> +    res = FIELD_DP32(res, BXJ_ISS, RM, rm);
> +
> +    return res;
>   }
>   
>   static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc, int vncr,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

