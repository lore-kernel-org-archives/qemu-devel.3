Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32500CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZY5M-000121-Nx; Tue, 16 Jun 2026 14:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZY5E-0000zH-EY
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:00:22 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZY5C-0004kK-NL
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:00:20 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2c0b9328c4aso36386045ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781632817; x=1782237617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4/gigICi/AjQI4/MOQ7Hq/q0o6r4szJGb9nH+GEK0cc=;
 b=Tx0zNTSRpasIU4AOzGjkTpO5KARadl+THwJma0G8mfscZaenA2TpisWfxbk5a3gwiH
 z5RQnvVydTq9OpoLuY3w4xvspUJpIG567BGxrKtuaZy1SxkOV8zseGijYVjLDuag0UI+
 2lAnl3PlPKTdNBl2feKkSpTgvMvEhffb/JW2JxMhiSwB4cpFN2cA6f0B78m6Ki+BFZcS
 xT1LvU7PkexRTKRWavtZxLw0aigU+hwT9O56pp5WPCDlihviRRR/YhxTqfNTPzG1RsKn
 JA2k8rYzAG5/0ME1tEJH2rAe21kcQfy0HGRd4HAy0pk7mltp/CcybA7OseHAqYq5U0gy
 B8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781632817; x=1782237617;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4/gigICi/AjQI4/MOQ7Hq/q0o6r4szJGb9nH+GEK0cc=;
 b=Dbz2sZF5TZxWAuG9vxiEXi9zw7FanBL6cMXClc/wlAQNn3bWyzGVzXVPoLaWCEzlJe
 H0iu7kmwRsWmYRL2SQH9Ps9nglQ352slARF7rbiSmtvdKKmiwYS/M8rTltQP6amh1mEf
 Gk/VaHWQnZ+Mk9ihyZt7YV81nqGGpG10kYjZL9bhHYUsQjdz9bP3xissr75VjJnKLCuQ
 VnUbCSDJ8+ABic3fiLBP4GhhiidJx9i00rtZZDD4hcpv63qPcsQOHZh4Q1DZH5RyS56h
 qMtKH15+2nYHCNt2fXuhz4KG9tKlNs7as3SBmzS1+Zm0BFc0AdDhtLO3Hnf6ofaNGMh4
 zcyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SQ5cgxGxA8j9TkkbSitjjA3bM6a0rvliCu74rvGL6DZJK8D0wTFuxVIwpQGfHB51KBhhJnH700Kou@nongnu.org
X-Gm-Message-State: AOJu0YwyxEmVm007O4dpdajQ/5IB6SBOOmILoG7NurMydkRn+gm+SD2t
 AzFoxd51bt0Ior1227+GBt0TVC6stvAjsX555heqkr/KdsvVNNXGbI/meFipHmLpEbw=
X-Gm-Gg: AfdE7ckzR1H0YVfZwvOoJrsovM2e5vGqD0x4wYktTUP4w3c1ZcSULT7FIvn7tSYt4nu
 KNnBxhnZ0Qqiw4f2FBZaTNJcUs3Po3bD6yK6CAhsmFNPOTxSTL3BremS2LEDgcHKWpNttmpA+Ar
 ED5kM4IQrE1cfAJ2vvTJIgaNVjJTI8QKBw5nj4admuXroWardDK3e1LZtjg0kWFo0Sv9LWUjQ1l
 UScgTXQAKmmIPLp86GImp+zRvhdBfmHJXnZPaWQ8hG96FsVNq4FNnjgvQE3AVmUQOKAT6JTdpmW
 ASSk/VwiAyg6qwpkzYvxXDUsdm8QgxmXDmjYNwThpVPjft3XRtmrINBctMpfhgVuC/fMSmfD94A
 dnSOBp+5361+7aVPKfPdH2MxU0ujV4LmmSc4e1YdOf9K7aFCdObealvhtVYkZ4cZQYdJ4RsbcR+
 nbTNY7NIT1lGmPbx5lIDvTc+GX4VgTz1Mrko2ar8qNC4RTa7bKAmjE0TbcmZMsDBL1W1e2
X-Received: by 2002:a17:903:19c7:b0:2c6:bb39:fed2 with SMTP id
 d9443c01a7336-2c6bc221f6fmr953215ad.25.1781632816545; 
 Tue, 16 Jun 2026 11:00:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432c8dd4bsm145768255ad.60.2026.06.16.11.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 11:00:16 -0700 (PDT)
Message-ID: <757dd9af-b464-4505-8c97-40c05fad030a@linaro.org>
Date: Tue, 16 Jun 2026 11:00:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] tcg: Include missing 'qemu/bitops.h' header in
 tcg-gvec-desc.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260616153432.92939-1-philmd@oss.qualcomm.com>
 <20260616153432.92939-2-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260616153432.92939-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 6/16/26 08:34, Philippe Mathieu-Daudé wrote:
> Include the missing 'qemu/bitops.h' header to avoid when refactoring
> unrelated headers:
> 
>    In file included from target/arm/internals.h:34:
>    include/tcg/tcg-gvec-desc.h:48:12: error: call to undeclared function 'extract32'
>       48 |     return extract32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS) * 8 + 8;
>          |            ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/tcg/tcg-gvec-desc.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/tcg/tcg-gvec-desc.h b/include/tcg/tcg-gvec-desc.h
> index 704bd864549..94c7d14b264 100644
> --- a/include/tcg/tcg-gvec-desc.h
> +++ b/include/tcg/tcg-gvec-desc.h
> @@ -20,6 +20,8 @@
>   #ifndef TCG_TCG_GVEC_DESC_H
>   #define TCG_TCG_GVEC_DESC_H
>   
> +#include "qemu/bitops.h"
> +
>   /*
>    * This configuration allows MAXSZ to represent 2048 bytes, and
>    * OPRSZ to match MAXSZ, or represent the smaller values 8, 16, or 32.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

