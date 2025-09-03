Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F8DCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmeT-00009w-Vh; Wed, 03 Sep 2025 08:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmeK-000071-8v
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:31:40 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmeI-0002GN-DD
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:31:39 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b046f6fb2a9so71014066b.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756902696; x=1757507496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HwJxw16tGOz39sGj0uy6RLxK1qGiONLJOj546mJutOI=;
 b=NDaVhAX6s5o2TvANBFfyvmDfgVytlfleOKjTYhjl+Lh+v9FxqFgGz+u2cDt/eihgOE
 s3Zez4gwammB83BjzRPREym6VApSHwCYPXUx8CZge/P9u1EtgBI2JJahk9QyPIERQZul
 tmfaXxx9Ooz1OCcV74dZ0+KGmMsACwBthNWdC/SZ0w6DT2RdGr86XYW8ZkqOzBFlH6J/
 bkF+Vdxmese39G+wsOOeE3pzMtjkqZQmSeH9EuOKpzTW1wN1m7ofFYo9qfqShyxydLEx
 p8bUB60TSwd+vkzbp36BOKeQ8aSm3OCwNnnm2y5E/BOQwLA30Ygnq+oXvsSaC5XEga1W
 PXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756902696; x=1757507496;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HwJxw16tGOz39sGj0uy6RLxK1qGiONLJOj546mJutOI=;
 b=IlaPDi5IDpTjzokBXU8+P+a1pK3iCfuinc1BGaKfSoJzNLvw6/0HCJ0zBbv6RJVtR9
 EOF76WHacq1iZ5to/My2jZdbARhH9nu1qU/CQx3cg8B25SajAX2c9o5OM2oRIEF9cAfg
 qfr9Xtfpp+fcTLT/0kdskMBTP64WkNDtL3hE3UVDtQzxsYQK3ykiMH20gGIQyaeqAxtK
 kQHHCHXfQHSyOiqdFzDixDlxsw6kOztIPG67xUJ7+qIg8Z95QKdUT6Hc0ISN6nNjaWgb
 bxXaTAq9fSxYE4NGMltky+c0duRGLz7u4TFRY1IHIrB+IMxSIoPoiu5xZPmXxtFnEAzm
 H1UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCoTRBDIo4OYfIJLilXMJHFO9Ossq2ehCmoj97FBx7zpvyqwgqjSJqA3dtsILmRatnlw9ZD+vsw+lV@nongnu.org
X-Gm-Message-State: AOJu0Yyy/XvqLXSy4or/YfVXLY1/xojfFpeoCHUcPtlhm0/peItttLx5
 4d0G3j669hPtKmhRbJ3ig54/VQWtCoLt+x0cWWeET3ziOZktY/BnAIKanzz5DYQ3QtM=
X-Gm-Gg: ASbGncuSBbD/H12a5ZlIcbwzYx5Vy9KntE7/QwGAFMHF8RS41bqMrYMRdXXOedIfP1b
 T+dNdsN1nemC1aHPs4XCYW38AnEudMswiOfCJctrVotj6thQEwNHEqai+qE14mq/tfZhgvesohj
 q4vOLH8pRlz0f8gs+20rlgUSG6Jtd53XGSlVqsDsF/E+oI6v0afIDazE+6JtWjltXfQin0mFLY7
 Bsw9H8QpjA3BU5ot1mmEcNJnV+iyYGl7Fg9yTyL7Jvl4A3oL0jlH4yABj8TzIaZNvA/syW1Ee+T
 CYPfyZJneR7y3MVw9zh9A7r3dTy3SSn0kPaevcDNG7dgrjqddB2Nc1F81oLwqKN4wd/zputI0xL
 yUVPMZV/0H3UFb2Ta8F4ba/itipbQ9Wsr1OJ/1c7K6SbhFDEO7t/F1Y9SmTh8IbU2RLBzVAzvDt
 DlTnJO/g==
X-Google-Smtp-Source: AGHT+IE8T0GcaixJdJCr+4eja0hk8io5Q5Nr2/2cT9Ns7u59vBiv7bnVQGTqAz+7itRcDO4r+z7iHQ==
X-Received: by 2002:a17:906:478e:b0:b01:af25:ebbe with SMTP id
 a640c23a62f3a-b01f2106acfmr1742521966b.63.1756902696502; 
 Wed, 03 Sep 2025 05:31:36 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b041f6fb232sm885099766b.87.2025.09.03.05.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:31:35 -0700 (PDT)
Message-ID: <a032f370-9973-4407-812c-57f6d4d03abe@linaro.org>
Date: Wed, 3 Sep 2025 14:31:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] accel/hvf: Rename hvf_put|get_registers ->
 hvf_arch_put|get_registers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903100702.16726-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62a.google.com
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

On 9/3/25 12:06, Philippe Mathieu-Daudé wrote:
> hvf_put_registers() and hvf_get_registers() are implemented per
> target, rename them using the 'hvf_arch_' prefix following the
> per target pattern.
> 
> Since they call hv_vcpu_set_reg() / hv_vcpu_get_reg(), mention
> they must be called on the vCPU.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/hvf_int.h  | 6 ++++--
>   accel/hvf/hvf-accel-ops.c | 2 +-
>   target/arm/hvf/hvf.c      | 8 +++++---
>   target/i386/hvf/hvf.c     | 2 +-
>   target/i386/hvf/x86hvf.c  | 4 ++--
>   5 files changed, 13 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

