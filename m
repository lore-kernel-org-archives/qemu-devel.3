Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CCFC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTAjS-00080f-1p; Sat, 21 Jun 2025 22:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAjQ-00080E-E1
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:46:56 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAjP-0007KP-11
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:46:56 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b2c4331c50eso2539337a12.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750560413; x=1751165213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JVTQRjUHjc5X+UTMIyjMhpNgv9D6hnWM9KZqNFPpZ5c=;
 b=orANKVqmhWYPuIcL/V9+hCp9H2e2EZvi/y+fWWEpsUjDQhA/JM2TpxBEhQgeswf/ws
 eu5O838WstXzQtxH5xkztXCS2O8wp9BQAEP4u8n1nJ8jsEG2ILbap/+HsXu8PxPsUFw8
 u4pITJBMe2UEOq4g0c5DqNSQ9rnyenmJA5lcgqbD0h8UFBLG3qAqVAcjOdmUcN8Yb5X+
 XGXNLW8vg9W2Defn61sV5K0rnxrrtl4Tu+9zRriEAaVhd5kmeAGgoz1aOBV4gZO+WRNi
 ICBHfKrwB3sxmhlBzpRngt9bwO1+DhpDbFVGqbo32+iNLaFTjNYtix5u4d31OqXaEYAi
 DJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750560413; x=1751165213;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JVTQRjUHjc5X+UTMIyjMhpNgv9D6hnWM9KZqNFPpZ5c=;
 b=EZ/2NvL76vKaKlrpFR+0FbxotNQCABjrnJJJVRciWpWxq/lneQH+EjECPRisCCeqbi
 KHHTfCy8x5F3vEbiVykyo8eIXuWRofkflA2jAXA0q1enSb1kjyzZ5V91sLVDUVijkAHv
 RLy96h+gXJc+XdaiZ1kGD/DELlBvmGo9SF0Lxnb7w7Djh1Wm6VQ3akNUdGnIMuM17plp
 0LzO+sm7aqg4/dOaUbMX18KPicMgYayyceF/x7J+Fr7Zy3Mcj20WzUTztX6e35Oi/Qqd
 ssG6gs8HB3TiiW9JX7KHjZ9Lt7NXrK2Pzx6pUAyJLIjA1Gld56GO3qxIGEWyaa5OtyVp
 ayVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr2TQp+QzhnNDgLNAdJWLnE4uR4QWJgPrH3uexjybPGdqjEEa5iyA4aFfVwerw6WdDcSe2X5PTbcM2@nongnu.org
X-Gm-Message-State: AOJu0Yyut2GrhexacNm1V1YWLjFiuFKBpHCJTRC4Chevt72RduPiJyWX
 OxrQUe15+N34IDw/29/pQ3Xl2hDIfCiyBZLlk0F/n6r0OhgFuYSrnPO+o8OK02C+5B8=
X-Gm-Gg: ASbGncstRHmZS7FfT4gTVxFeC8XYdQsT0yPVh5HaH8COvR/YkHeJUfgrxfDAnJ81kcY
 TkeSIpLTM/40215pvM7e1mSnFCuXB/DsJNPae4gsMxb4qFusdvZko1wSKr4OTnNwsC8VFNppJiR
 TU+TEYZqz0V44J5v1N8n8WGCdOti7gOlsk5WIVmq20aweMXtHheHMujSRXeXg+n8QW2e2PGgvvf
 f0iVEBtnMSz2vE/9liG+8C6G+QsHcVO0UgP0N2iyx+cqG6L/kOBxdbzAnv7ZB+WTn+GLo6Qqnp8
 9z9WCtYvmEBDW00R5HAO8Q9Z/HyPiGyMMvAnYE9HZAmy1+lVZcS4w48dHbpAZuF6wRp+p18/BNo
 3bdPGQoeIiGWRdhDpcsoGGggKLl2R
X-Google-Smtp-Source: AGHT+IGOafYC+PQBkfDbVxvvD4nIzMu4EI02dRNDdQEHODkLjJayouQ4OKSQWAIiLV/+x/WDPxO1nw==
X-Received: by 2002:a17:903:1905:b0:235:e71e:a396 with SMTP id
 d9443c01a7336-237d9a504a0mr135055225ad.51.1750560413530; 
 Sat, 21 Jun 2025 19:46:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d839357csm51649885ad.6.2025.06.21.19.46.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:46:53 -0700 (PDT)
Message-ID: <b5cd4650-3435-4f16-a360-0f6ddc217bfa@linaro.org>
Date: Sat, 21 Jun 2025 19:46:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 13/42] accel/split: Implement cpu_reset_hold()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-14-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-accel-ops.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
> index 39495fdff14..d4fa07c2dec 100644
> --- a/accel/split/split-accel-ops.c
> +++ b/accel/split/split-accel-ops.c
> @@ -10,6 +10,7 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/guest-random.h"
>   #include "exec/cpu-common.h"
> +#include "hw/core/cpu.h"
>   #include "system/accel-ops.h"
>   #include "system/cpus.h"
>   #include "split-accel.h"
> @@ -121,7 +122,16 @@ static void split_cpu_common_unrealize(CPUState *cpu)
>   
>   static void split_cpu_reset_hold(CPUState *cpu)
>   {
> -    g_assert_not_reached();
> +    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
> +    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
> +    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
> +
> +    if (hwc->ops->cpu_reset_hold) {
> +        hwc->ops->cpu_reset_hold(cpu);
> +    }
> +    if (swc->ops->cpu_reset_hold) {
> +        swc->ops->cpu_reset_hold(cpu);
> +    }
>   }
>   
>   static void split_kick_vcpu_thread(CPUState *cpu)


