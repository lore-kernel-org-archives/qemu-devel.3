Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3971C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 14:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBxDU-0004F0-VW; Mon, 05 May 2025 10:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBxDT-0004Eq-B9
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:54:47 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBxDR-0005Xv-FG
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:54:47 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac25520a289so762813266b.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 07:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746456883; x=1747061683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9tACv9ujnBDWISNc8RQTCWu911ZglEEofIlCvb+T3G0=;
 b=ZmYaCzzVOOt1ntyICP3N8zzCQA/AcrggVroPl1+gmEaVh5HRhIfCe7j442B+pG1EAG
 lyLj9s6lxVhr29orU7aCDI/aFRCOG7/9hRgPHE6bmeoFtot84RMQrZaookivOft0f4gn
 xCWaL4jS0gyTfBg8xVn9OvqY3p0q6gdk78VxkT89OYnej3f44nBGi/bgbzDPWCnCqEJX
 /QBBqXl2tKV6woaTeIxFzPRkrfU2gtribYs/jgQg36xyqit02X/VXiEB0bnCiWlRrLW7
 qt6dhimmnj+5WoRBaZ0+FU4oUtuAU+aDZZDgYY06fFgufslFt9hGLBy+l8+J1AuNsGXo
 1DlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746456883; x=1747061683;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9tACv9ujnBDWISNc8RQTCWu911ZglEEofIlCvb+T3G0=;
 b=VevXiIYzLMEzcZCleLSjh/+U+oOMQ9b5pjDd6bmQgJpB1uxuRIXaqCmbnIANImJuux
 w4H1Gdi1ckqPB7Oklpfbgr+nX35A1FJSokiVG8YTxX+rlaitc5eG9wj71zEXaNACkvI9
 BPre0JhX0ECDmk7GRC1UGB93GuFz3RV3ec2rLVwQ1dyJ5Y9iLObcrhSI7G6qjTu4CFft
 +DEEsADpm88VmYDnVoruLqu637/4wmzlYkoQhyW45is6TivQcPsO2Mmxo0Y948bGSJgJ
 A2kAzComU+59aFdBec04x48+mvDATOz41NN0MIgf3B0YfvWhsrosweRQuCM7E0Zl/x3L
 Hbug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNR6qSinapNbIi6oRSUp/xcYMl1CeDHylTxC7quiLjpY5a/C3Y/6luRHnMK4/ScPBdAUQtdRaQ0DbC@nongnu.org
X-Gm-Message-State: AOJu0YyKGacidATLK5TrjRNSEk1/75ny2sPQz1oaPPrxTEaFeoW0e3Y1
 eLlPEr7Ix3lXg4l/o6uVE42KLPh05K+GdSOcLo6GCpP9e1q2WDf+WWg/7FGmAP4=
X-Gm-Gg: ASbGncvwp9Jtdgvk9gj1zu7z0YL/5nT8MwsvfLtwptrOY2r3IP4R8Zd09wJAEu6t8Bh
 38hhz9nopOa1+vye3yOo38E7ANfEDV7epX+OmMXfSc80f5qICWBezUSVwjzapO7bG56W49AeLwm
 cFcm/iGl+XEfoaPL1123UHoajs2m27fXZnS9k1Yl9F5cAd1gyLpMo6QPCmPvvzwGr/k25inneY7
 0itEUTIkGfmKxWu6WBWZrw5VSYIQ4d+toXUEIzSYMtT40TBmJQ8xAzZeANi02B+7XhIU5aUvbHv
 612qBsDnFDAqp4XN2vCjiqsvs2G3tXN3vXfmS+Qze2kDOYqEbFNBxSeS19cXAq72F75sTmfCYDs
 L1WA=
X-Google-Smtp-Source: AGHT+IGmal9TsFKHY1bajht27XV+kjJVDkEXe/KRUAsucBEoitRQkZHtnzdehs45pC6XBJbr0vWXNw==
X-Received: by 2002:a17:907:d048:b0:abf:6f87:c720 with SMTP id
 a640c23a62f3a-ad1a4967e17mr695049766b.29.1746456883306; 
 Mon, 05 May 2025 07:54:43 -0700 (PDT)
Received: from [10.194.152.213] (129.21.205.77.rev.sfr.net. [77.205.21.129])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad18e2d7a88sm450863966b.36.2025.05.05.07.54.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 07:54:42 -0700 (PDT)
Message-ID: <e8baad5d-92e4-49c2-be4d-c9c7be4b30bd@linaro.org>
Date: Mon, 5 May 2025 16:54:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] target/sparc: Fill in TCGCPUOps.pointer_wrap
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: foss@percivaleng.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-12-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250504205714.3432096-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 4/5/25 22:57, Richard Henderson wrote:
> Check address masking state for sparc64.
> 
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/cpu.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 2a3e408923..ed7701b02f 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -1002,6 +1002,18 @@ static const struct SysemuCPUOps sparc_sysemu_ops = {
>   #ifdef CONFIG_TCG
>   #include "accel/tcg/cpu-ops.h"
>   
> +#ifndef CONFIG_USER_ONLY
> +static vaddr sparc_pointer_wrap(CPUState *cs, int mmu_idx,
> +                                vaddr result, vaddr base)
> +{
> +#ifdef TARGET_SPARC64
> +    return cpu_env(cs)->pstate & PS_AM ? (uint32_t)result : result;
> +#else
> +    return (uint32_t)result;

Alternatively expose AM_CHECK()?

Regardless,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +#endif
> +}
> +#endif


