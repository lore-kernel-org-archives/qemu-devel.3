Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2458CD98C6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLTh-0005MC-C6; Wed, 10 Jun 2026 12:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXLTe-0005Li-77
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:08:27 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXLTc-0003B4-5q
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:08:25 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c858961a8efso2639288a12.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107702; x=1781712502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gq8DAg4Feau7b1dXBbjHkIzWr9vVwEwPhbRB8dEP/wI=;
 b=SSMfHhofR1ETmoHfFeFgVivduZ9z3iakz3Z86uYXgPKJpRHz84UkTlap02yYlDzgFh
 T7RSyeovXqiEXMuo7VDzUHaEOGUdgAwgGyFNp8yqzahktCZeP8FsHQ6vqxXaio0OdwlE
 UC9CcBV654mI+jAEu3MGzqA88ot3FlK6SuOzi0Jz5THkPf4YEuWQ4W/ha2UU4qATYP5V
 dWyZxKKhwsses4UB53EYdVum8yQ2youkXP2x6izR+/PpsQwTMXxpZkwMnPcdBVwVEMri
 vA26AOolaVFoTZxhl9o6KdrMXX21psMmrx4LVRG8HBaBWuwcAdXi874wBbq9E9v2wkR3
 qf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107702; x=1781712502;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gq8DAg4Feau7b1dXBbjHkIzWr9vVwEwPhbRB8dEP/wI=;
 b=OfjEawUjAHwkUObZe/aOLi5Kv39WWyxyUMaxkgfiDp/sbTxsWN54xNkUje2ts1mRfE
 NRZ6iU2Ry7ttauB1Nz3xLDAsp3diZHErbua5IYhI23y8UjBybtRzk/woFb83K0JgPuSu
 qSqR3EMXOWDC4UBjp0YUhKTzQjs+IQ5VRSsJEcFMXB6520612e69waG3i3oKyBQhLUQM
 Wdbv8jtcNdAZ5ogKlJM4UhGatSJgccmSUsFHcdrucP/4m2ANbXBLBgdxT2Y20JkqpmwT
 HikfQX+Q4xja63rO/dR/AQ0t8Sg8GOatI7p9K8vJnuFPwYasFM3QqxKdUwse+hFgWI3q
 pIvA==
X-Gm-Message-State: AOJu0Yw1gU62vlOBHe4HcRN6B1hhMS6nMishAPidLH/PZ0lJ1qRDyx5w
 A/gRXRTcEi4pTvUyC2IUeQKRslmq4WBWdOQT2AtmECBLUhDmTk1RVYlgpYhd4bVGg24eF+XpHr7
 ARtFdOW8=
X-Gm-Gg: Acq92OHKeLPS6ElO4M+ddZ066h5vTXz4gEP87VN9nZKzbx2bbl/2js1cV9miX8t2mGj
 RWNlXR+PXKrsN3oRHeTPWF694nX7235ZNz7t7IjnhOAEMjFiPoNZGjhf2Ly9+y9J4SauaewlYjS
 6+nxd34QIsp3eO2jY79zSZOvMaIjVkgvkTwb8VkigYgI7GR/MaT7otMNVUr/kbLfFPzGo1Ueo8Y
 X60CduJhTi4lMUFLCyIHzPR9qghHN2N6ShS6nPbvqr1JngPxWvsWYY9KNTyNucVLHj1GgZiyQYe
 IbFYmNHuvWG6O9xT0c+PJcCYYpvqU8kpuMXaUc/x4U3gkoHApVW7TncnQjCNdGFEtUPKAF3rluO
 M61WcOXMRLL3Zf2GjX8KL3l3SDzWm8rC6JMl0W6A/QchCXPIPOXUNHCvcWP43Mx55NjUHgeNpfz
 qqQQiZpjD3+Y7ZvUnl3qPXvMzyiB3vc38+hW4f6MF0yRqp5wc=
X-Received: by 2002:a05:6a21:68e:b0:3aa:f9cb:d41a with SMTP id
 adf61e73a8af0-3b4ccdc76admr32904662637.19.1781107701854; 
 Wed, 10 Jun 2026 09:08:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df032df5sm21201326a12.6.2026.06.10.09.08.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 09:08:21 -0700 (PDT)
Message-ID: <1f711172-1800-4919-866b-e9fb19f91f48@linaro.org>
Date: Wed, 10 Jun 2026 09:08:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] target/arm/tcg/cpu64.c: Extra test for GPC3.
To: qemu-devel@nongnu.org
References: <20260603-jmac-gpc3b-v2-0-115c51936962@linaro.org>
 <20260603-jmac-gpc3b-v2-1-115c51936962@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260603-jmac-gpc3b-v2-1-115c51936962@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 6/3/26 11:26, Jim MacArthur wrote:
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   target/arm/cpu-features.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 38a695ded7..ad1b1ddc9b 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -1148,6 +1148,11 @@ static inline bool isar_feature_aa64_rme_gpc2(const ARMISARegisters *id)
>       return FIELD_EX64_IDREG(id, ID_AA64PFR0, RME) >= 2;
>   }
>   
> +static inline bool isar_feature_aa64_rme_gpc3(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64_IDREG(id, ID_AA64PFR0, RME) >= 3;
> +}
> +
>   static inline bool isar_feature_aa64_dit(const ARMISARegisters *id)
>   {
>       return FIELD_EX64_IDREG(id, ID_AA64PFR0, DIT) != 0;
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

