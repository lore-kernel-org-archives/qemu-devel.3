Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6FCC54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIscl-0003QK-Cw; Sat, 24 May 2025 13:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIscj-0003Pm-8Z
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:25:29 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsch-000802-Jg
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:25:28 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso6950965e9.2
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 10:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748107525; x=1748712325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iF4yUrOMZN0fEBOnympaVqL/jstjUAG7TN921jPRJCQ=;
 b=N1FsClxIQGEV6uycHPlxbQoJ7e2gRYto9XC39bk6glj46ZMLfnTAcygVO7Xc8FMQdE
 rYBBc77pfASraWpLy6pk59g9F5aMXh6Hm4ahDTFhqs4j/xoAaPbHMy4ASxi1Tef6OGvI
 WGKm7cJDnYjuVxUuZJVPAv0kwjgGHj1wrMzxtPWyMWVO/sEsnwl/JcyfG+NjBPgFCiSA
 lrTsqC4NX/xrWTFrDyckB2m5t24LvhdIGmGl4Q2EEF4j0W2NX3EsPlS5rwH497iTmTig
 kxCA9fVSwCpcDDBVeFrE7PimYrpoqKo78thxm2i6mX8jLr9cQW2pun3WLoSjknqmEBv2
 3vrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748107525; x=1748712325;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iF4yUrOMZN0fEBOnympaVqL/jstjUAG7TN921jPRJCQ=;
 b=tTHq1+QNq+iQVHWEX+bEriBOJCi0j4jDJ3tPbh3wLOhyNJXzQIAHnRUGXSmDiuvUOv
 uECrW++BpN6kdG/FHr525VxwmbSSiJYrwYKOXXSBwUqNhqm1VPG5d+Nqt4/kRlt5Ka3J
 f0GlTKZjWk+CWFWGHLUNoOtLCiQgV0AaD283AOWUYeTPuMFxsOoylzrF4DKzY7C34+K0
 2QQYAyI5uaoIPVGpCT9vkUA4tpmTk+DMHIox+23qIfaOaUfFNvFa1/2wWQ3TIhl1UFjv
 T5yErLekx7HAR+g6oXTIrPoeVH0cUDLGc0XL/rbp+ReROkrv2E6PFoYLPDlG/HunQq7M
 Yn0g==
X-Gm-Message-State: AOJu0YxOwFwFVU5WUdjZFbowXDOec/80JSUiiksZRVCs+7zLnqyaDVQQ
 6vSXTTCVq6ooeF6IrqaiQ2BWhVSdZKYpor60nma3q8HyMCaq+2PATad8YZzXESqUseYQp1y74u3
 MMKOMfwlYwg==
X-Gm-Gg: ASbGncvANntkiJlnxwPcWb5BKAcvzSybEALXDn+idF7WOpg32YTwA5I+nJ+Ytdvyt9W
 ynaQ9m2C9bs1gvw+wVXvE4tfj93EQQnpFtxNTUZL4wg4DLrXu4ad+PRQKtaliDGTdcmLPkudiim
 9er5OvrJbhUhesNzWJqMRZCBP1YXjnkQjovD16WvqxaAkHlHtOUACn8u6EvLvhwnHtRvgUyMufi
 Rkf9o12hjK1hlB9JVEkZiCHlILE9mVltUTIIjt216xBxupavy4H5r5qa50tYyznfZ6xtfHakClO
 eZBksVOSaiq7EAVHTKORSLhkUGShNy2I0hryETWraIy6+SnGLJsEuKNZ+Ok8zQWwBA==
X-Google-Smtp-Source: AGHT+IHYYpl0KPl/d8aVAeYbK/oCpLy6h6v3vqJDp5X/3IdY9G4QzWZWDx3Wu9tTL55NS2bmCWf/vA==
X-Received: by 2002:a05:6000:2082:b0:3a4:c8a5:424d with SMTP id
 ffacd0b85a97d-3a4cb443a40mr3390674f8f.26.1748107525087; 
 Sat, 24 May 2025 10:25:25 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4ce9dcbfesm2252108f8f.13.2025.05.24.10.25.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 10:25:24 -0700 (PDT)
Message-ID: <083923f4-26d2-4132-8ab0-80c3b465c036@linaro.org>
Date: Sat, 24 May 2025 18:25:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/25] target/openrisc: call plugin trap callbacks
To: qemu-devel@nongnu.org
References: <cover.1747666625.git.neither@nut.email>
 <37da15321ffd8f3aa41ad2dadd591cc1f179feb1.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <37da15321ffd8f3aa41ad2dadd591cc1f179feb1.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

On 5/19/25 16:19, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for OpenRISC targets. We treat anything other
> than resets, timer and device interrupts as exceptions.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/openrisc/interrupt.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
> index 486823094c..08f0ed9b89 100644
> --- a/target/openrisc/interrupt.c
> +++ b/target/openrisc/interrupt.c
> @@ -25,11 +25,13 @@
>   #ifndef CONFIG_USER_ONLY
>   #include "hw/loader.h"
>   #endif
> +#include "qemu/plugin.h"
>   
>   void openrisc_cpu_do_interrupt(CPUState *cs)
>   {
>       CPUOpenRISCState *env = cpu_env(cs);
>       int exception = cs->exception_index;
> +    uint64_t last_pc = env->pc;
>   
>       env->epcr = env->pc;
>   
> @@ -98,6 +100,17 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
>           cpu_abort(cs, "Unhandled exception 0x%x\n", exception);
>       }
>   
> +    switch (exception) {
> +    case EXCP_RESET:

There are plenty of other EXCP_RESET uses that aren't marked as interrupt.
Bug?

Anyway, for this patch,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> +    case EXCP_TICK:
> +    case EXCP_INT:
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
> +        break;
> +    default:
> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
> +        break;
> +    }
> +
>       cs->exception_index = -1;
>   }
>   


