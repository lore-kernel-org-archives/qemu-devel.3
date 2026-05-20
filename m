Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64376CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 01:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPVL5-0001db-VM; Tue, 19 May 2026 21:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPVL4-0001dT-ON
 for qemu-devel@nongnu.org; Tue, 19 May 2026 21:03:10 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPVL3-0006g6-1p
 for qemu-devel@nongnu.org; Tue, 19 May 2026 21:03:10 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-366be8040a9so1708251a91.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 18:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779238987; x=1779843787; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RgPaPewJlQxVJdh6nzjNfaTz7XZnjI48myW0YU8O2rQ=;
 b=y0GK+eLmT/mybcEAPk4kRTbdwukAo4yWFz9bbvfHJeLbzCW/MdQTEZ9dT4AbifEwrZ
 Z3YXxgktmX6M1JTJBO5w9U3am8/1X3Cyev66UvtYf0rvGrySUUSyYMitvz51sOl+/oQd
 ndIv1eXUm6BEhfYao2sTe++A1aVHDzlpBTIqssQriDyeKwPPE47fV/uES86YqEqCJZcv
 wU6Zuxl/gQCy5z0DVnvaTV1HXsoNxcs4PWzpF0cWJNaPvfqrzvU6HeeCYQ3dwkhBGdLW
 6F1tYXzLpI5laywRoCaVwW9kvido467/n4WwzvVSR1VmA7WS73Uqk42LES/vxxpKj/Xz
 DsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779238987; x=1779843787;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RgPaPewJlQxVJdh6nzjNfaTz7XZnjI48myW0YU8O2rQ=;
 b=VHsx2aGnHGrCAkxxWN0hDNQA5dODsMBwkOFTl8WvfDNL/Ozk9MfEAcGkXsrUg5ZpdJ
 H6VT45siHyvnLU/NbPtmJuybJFU0y4FKDPbIUOTIf42sWQZkyE9XwuMPow4o8ebtWOLI
 avX9kwn1DzFxfMUvvuR5cZSZInJQA4826WyUGqVATMzkvxF4dqPEIBY8rl2Y8XDph4TB
 emdS3/vE+Lr4Csw4DpsQfzY1CodZmHHiJQnhwRDqA15zygMm+aKYi0WVGDq6ReNPlm3g
 eqJzW13vq3WzFVfVgF2GLa2CsWRqq2LtC+Irfqg4Be/sCGGFQMSv8uTpxdJjODMHTiV7
 LsnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JdgZSd0RFqnKFrh/qCkR3OhfHoZL680MpCE3HfbDrF2xdVXTNyvzgQ/a2oQafsmmLOOWrq70ooXkp@nongnu.org
X-Gm-Message-State: AOJu0YwyVf+0cSqxstin0LFdyCYW9lN/LnLm7DRo2YMeCXwvBzQPUWeS
 Knsm7m3haPUZLmJq/BvLODfjr34TD0SEr/s+21JY7dLy1Eeoi0iMKExM4I9w+ygbypk=
X-Gm-Gg: Acq92OHn8Q/cANZBdiXF7e0NDXnjNVBL1BQzKSEGjbqdIjfFL+kpxaS0N9Fb76MlONv
 I/ufBJCSgSpWvoLjANZfC/5Nc4Fu5901CjFs1Ry+lYJDOBwNEdLd/w0uDYBqIwSlN0g2KCp5W4c
 nzGAI6lsa5+y0fhJR4LlNR5tZZEjjpdpuwQd/h/gYJlEQla4GCS+OL+reIjgd0M0WZtHs1Lu0Ql
 SvFWmy4Bwb554ARKRjG/kEYfcOhs3ri7k5QeM1/QagMnOEtWEEksS4JWtSy7EBZE0Ff3eKOVV+P
 aRl+4t8ZwxOybxInu69ZihnT1JAyY+OLyDT9WFk+Zj9odFLYh1ZVclOM9+iNnrhpiRqXm3rGVzD
 5LtRHdL4lErXq6QwTFQvO1cQI7kLLC68iGFe/xTRAsfalBCUsvTOIrW0G6rImYhXRyvsO/ez6p5
 5FcfEcb8ipRIiAdQdqPIPX+MzmRFYDZwBXJ/ua
X-Received: by 2002:a17:90b:1810:b0:366:4782:1375 with SMTP id
 98e67ed59e1d1-36951ca5e48mr22340367a91.22.1779238986779; 
 Tue, 19 May 2026 18:03:06 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36951437316sm15670348a91.11.2026.05.19.18.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 18:03:06 -0700 (PDT)
Message-ID: <2284ad97-b7db-49e0-93c1-2770a5b2d360@linaro.org>
Date: Tue, 19 May 2026 18:03:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 29/40] target/mips: add Octeon ZUC COP2 helpers
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
 <20260519-mips-octeon-missing-insns-v2-v9-29-d7dd735ecddd@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-29-d7dd735ecddd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 5/19/26 09:22, James Hilliard wrote:
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index a061a86658..b57a7a0584 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -541,6 +541,7 @@ typedef enum MIPSOcteonSharedMode {
>       OCTEON_SHARED_MODE_NONE = 0,
>       OCTEON_SHARED_MODE_SHA512,
>       OCTEON_SHARED_MODE_SNOW3G,
> +    OCTEON_SHARED_MODE_ZUC,
>       OCTEON_SHARED_MODE_SHA3,
>   } MIPSOcteonSharedMode;
>   
> @@ -572,6 +573,10 @@ typedef struct MIPSOcteonCryptoState {
>       uint32_t snow3g_fsm[3];
>       uint32_t snow3g_lfsr[16];
>       uint64_t snow3g_result;
> +    uint32_t zuc_fsm[2];
> +    uint32_t zuc_lfsr[16];
> +    uint32_t zuc_window[3];
> +    uint32_t zuc_tresult;
>   } MIPSOcteonCryptoState;

None of this is architectural state, and logically overlaps HASH{DAT,IV}.


r~

