Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D2FCD4F47
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 17:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOf5m-00079R-So; Sun, 17 May 2026 13:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOf5e-00077Z-NB
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:15:48 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOf5d-00081a-6R
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:15:46 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-36608b2f2dcso720555a91.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 10:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779038144; x=1779642944; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eXsM9vv8t1X0tUss7pPxNucTu1AuODqudSeCS2yAClg=;
 b=LnsAylQnsaqx57q5+6KV/EAKMSln5n010WD+HAInX0IDvt7Z4OhZ+3Z3eH3+vxPdwI
 drapXJiGvGQLocXW05G4Xiza3mW8emccJJm0U2R1XPkt2yYPE8nQ76lW8+p+DXRh2C+e
 l1QArbUnEsY2Xy9itypyzfxZx/3qX0kgZkrIBKIOprdogUe5o63mMmQ5W52w236Sz6df
 +FvR10siY0Mu3mqG1tS5FVolQD+sn34SUhvdpvs0ZUXUprNe5DGOT7dOfcpowyvvdsTC
 kCFuXWovXaqXnqURjZJdBF97qLyZN0HfJC5OT+8y+MTcv7htN66iKObVwDLb6iqKoLhI
 BX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779038144; x=1779642944;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eXsM9vv8t1X0tUss7pPxNucTu1AuODqudSeCS2yAClg=;
 b=N+otszdbPfLDiUKnyKOq4FgFwPdi34rtN05G1GJxCUomwZOG9kM9p/uC86urAR3AmB
 ZfBnWFEhRCwmKD0ocsMLuiu+JBSse8UMnoLKFNfRqMfdkCoRO1gsSksOJREQGXT0VKmj
 OlpnpFHKZ91zl66XKCj7/zhjnUX9IT80wygZA21Mem+lVKxsHgVbrNFv6qayANW2LhyV
 ZNt39POO8W+pSmdTHqPxGqHd7Z1y/Sa6M163duEtJDq9O9wmTdd4iLLVJzOtAV1GHL9Q
 ocgsOVQ9yvOXWrGT3Z1Z7xTsVsQNKoDFwCwESojvD6SJNrFM79PNwHBNp+353tnwg8Iv
 K0qw==
X-Gm-Message-State: AOJu0Yyw7OL5fG3VSsSEuwvOp+sYQaiOtlsfrCZjy9MkHL8x0wWLJeK/
 xGxSC714ZlVb8eCKrFDJz+4xF/U0qz8UG8titxecUi3AKEXzklc+VAjJV0k7u3FmKO7wp2uRaF2
 Usg6P
X-Gm-Gg: Acq92OFVrfK75HlHGHkAW2p/pGkw1fvauv73W5oKS69yJkEcAmCV4QabCi2XykJGPll
 kRuqh1esgdr+xg0m9QT6pv1Du6tGRq4eeyhz3gjf2RgvZZS+r/Ukm2jP5/Ncp5SLPcOV7jV8RNa
 sSIZ+lwNOm0Z7ZdnrcsizXSgNrnvFnejPgRaBqqEm6UVHoqqP1eKDhYDi5nrDVG5UIyWSLYA1N8
 9WWS3eLQrcbDf2QTPic2WiUcYEYG0ltjhLg/BJt9tTs25k9KEPct1HISIvZU4lKzwO9DBMoZkAg
 FkMAIof1J/gg07uuEv4SRMVk3qNFMZ63pfUpzS2satAlK57yKIeRnCpqfftCggicCqe9TB6lMWH
 4k1HlTFWo36J2DE3eoWiHMN8p0WLQL/hA6j4rh3v6wnoj4e1z8guzqfjWc25zWbE85tWVutDGjD
 PDAzswCxev8zFN7YoNwbIJ72eu+6BDmfur65cy
X-Received: by 2002:a17:90b:57c7:b0:368:ed92:6f6 with SMTP id
 98e67ed59e1d1-369518961a6mr11551681a91.1.1779038143606; 
 Sun, 17 May 2026 10:15:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36959f52fe4sm4022078a91.5.2026.05.17.10.15.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 10:15:43 -0700 (PDT)
Message-ID: <cdf191bb-49eb-412f-9217-ec0b8fc61b92@linaro.org>
Date: Sun, 17 May 2026 10:15:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] hw/dma/omap_dma: Remove omap_3_1_compatible_disable
 flag
To: qemu-devel@nongnu.org
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
 <20260512203414.3633237-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512203414.3633237-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 5/12/26 13:34, Peter Maydell wrote:
> The OMAP DMA device has an omap_3_1_compatible_disable flag in its
> channel struct, which the 3.2 version of the DMA block used to tell
> whether it should behave compatibly with 3.1 or not.  Now we have no
> 3.2 support, the omap_3_1_compatible_disable flag is set to false and
> can't be changed, so we can remove it, folding out all the conditions
> where we were testing it as always-false.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/dma/omap_dma.c | 59 +++++++++++++++--------------------------------
>   1 file changed, 19 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

