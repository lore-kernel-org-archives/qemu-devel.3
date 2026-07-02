Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5FBC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOMs-0006IK-Sl; Thu, 02 Jul 2026 16:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOMs-0006IC-72
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:50:42 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOMq-0003Bg-O3
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:50:41 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ca265d6ca1so11853655ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783025439; x=1783630239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vJjI2sXf3pz/Moa25rX+SEFvAPb5vzxoopCZLlRNyTk=;
 b=TuXVojFFhUC56GC6Jw1npL+HkyJIsSeu233nloj+IqWv7sv4MUgQj80fAW0Uj0qMXU
 DfUFqRzuW+kmUy8ZzDTWixIkoGxfa6D6AdYbMi6Z7n4/2oK6iHtSIEJ914fUVNgyiGIN
 E8P/ZW7I+mHevZlxIzgxu33yjF6XFCRxk7+sHhXYnOrnoEkE5C4sLIjaV/0eEU1J2+Xo
 jd9VlmkBSqWSteSpkFjhmXbAnMQ8IS32EDufYjSEvjOwUNGhLIAhf5RSO+aTeULui1AY
 sJjqFCoVlJ2KiO0vHvA83V9B7Weudst2iGx7PB1VCUEd+Hjx/fo9i311Gylrcnd9THDi
 ExZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783025439; x=1783630239;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vJjI2sXf3pz/Moa25rX+SEFvAPb5vzxoopCZLlRNyTk=;
 b=BvNmJNafK3Jun/cz1wz8CCosXJep/QPMgXn4mE9e83PHTHOA1a3uf26S8PcAWvRVR1
 2xBGJYUPCFn6e1XkhDFUH2aIjVpoJ/z6cWsh9cfi8k/zR08Ko0STNh2soZZkK2xgOTIM
 sD7PCRg/y2p4mYGHRLJ1qtJTJXnYe8V5K2D5rAw+U0L8nTfACQI+MZpIl/KJ7S/H5vE5
 xV43FG6T8ReX1FM/sPoS+BGxINWY9TS3JxdC0GY3J738/PWbbaIWkgL49FsJeRjxxJDx
 aIatEdbOmXvU/NhmzoI++69EwgqBM7XPtj7rV5gu9N1QtCX/0k9Ln69YuzB4Q/AlB/hu
 xDWQ==
X-Gm-Message-State: AOJu0YzEZ0FHHK0F9k27H+l5VF+Q4WAzj+w9PJZDmRPoZuRmLYMGdewo
 cGQA5dHaye+pTnCZGBqt+ziwzHd0J2UHnQolRtcJaAolZYqg2rjUeH89Y0x0Zi4sSedhSMBssP9
 Jr9EM
X-Gm-Gg: AfdE7cnuRx9n4Cn9x+1kBTOZdjdNdq29oMYNEfTs8tB8mWKkxfyUaC2ZO7cOSY3TpZK
 7Q25VDvmhY5oZ7+t5RC+5dJa/SitdLlVCiXfeR2Ded4QeqmETd8PWDfEknbmLUybP+ENrZpFs+8
 CSFjImumLoMFo7dRE+VTYjefugM/+sIHugF/Woy3d1u6eT9z2E2tDGFa0L7aBXAdswqRNqdztJF
 iiZa3KpNuJq2c6y8ruKLW9o62wx6iyfI+c6pRTRGIkcFSup1EO4QLR+j3m0t7nGHH/XP/rA7ySe
 LgmzhY6lQ7lWMwiqnuw3+Cg51zZWtiVB3gNGdsH8fT8vc1zguXN4cpAwGV+syYWjaWcVVrKNF9q
 eiFFbX7/fHOhyAAkj0HcZi/Rtt6jn+0A6bbyxQmR3Riyrlw6XXvnU/ir6e9hTldZeYY9AC/hMES
 cclAfSCMgaRRuCglwWWgwPWuS5EVRen0On1mF1XUasZWeAZIoUj8dWFvCnVg==
X-Received: by 2002:a17:902:d4cd:b0:2c9:994c:9a5 with SMTP id
 d9443c01a7336-2cacb1c6f95mr13617475ad.30.1783025438378; 
 Thu, 02 Jul 2026 13:50:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca9aa0b7e9sm18649305ad.81.2026.07.02.13.50.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 13:50:38 -0700 (PDT)
Message-ID: <4105fb72-6ca3-4874-a53c-c6d4c10b1c83@linaro.org>
Date: Thu, 2 Jul 2026 13:50:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] target/arm: Separate out Neon from VFP access checks
To: qemu-devel@nongnu.org
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
 <20260702184019.3431139-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260702184019.3431139-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 7/2/26 11:40, Peter Maydell wrote:
> Currently we use vfp_access_check() for AArch32 VFP and Neon
> instructions.  This is not quite right:
>   * there are optional CPACR.ASEDIS and HCPTR.TASE controls that allow
>     trapping of just the Neon and not VFP instructions
>   * Neon instructions are supposed to report a slightly different
>     syndrome in HCR when they trap to AArch32 EL2
> 
> As a preliminary refactor so we have somewhere we can make this
> distinction, separate out Neon access checks into a separate
> neon_access_check(), which initially just calls vfp_access_check().
> 
> The set of insns this needs to cover are those described in section
> E1.3.9 of the DDI0487M.b Arm ARM.  For us this corresponds to
> everything in neon-dp.decode and neon-ls.decode and thus in
> translate-neon.c, plus three insns that we handle in translate-vfp.c:
>   - VDUP (general-purpose register)
>   - VMOV (general-purpose register to scalar) byte and halfword
>   - VMOV (scalar to general-purpose register) byte and halfword
> (which are the ones in that file with ARM_FEATURE_NEON checks).
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a32.h  |  1 +
>   target/arm/tcg/translate-neon.c | 74 ++++++++++++++++-----------------
>   target/arm/tcg/translate-vfp.c  | 33 +++++++++++----
>   3 files changed, 62 insertions(+), 46 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

