Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7FFC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 15:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNDrs-0007tR-K3; Fri, 28 Jun 2024 11:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNDrk-0007o2-TJ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:50:26 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNDrj-0007D1-3c
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:50:24 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70698bcd19eso593876b3a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 08:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719589818; x=1720194618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tF1N5TvFlgbPuhz7UsAWhJ0PkEpXSXYCOi0u3u9GVDA=;
 b=fq16tDlxwr3tb9Lzm9ggxtBmecIvJIWuVsNr17rr0QTG59p6L5+IkyMEN43I9107yq
 ydc0Il1y0FZjrqq0swYjjOJRO6YGxzR+dmFizWZNuudrbDxnSovxPf5chcxd2eq4NBIM
 lx52kYuEw7ad6t+IJVulF+R3L3H/bXoH6PLzkUPtDM1LusZvO7Yps6EyMFZgtlqa15eS
 XSRuebxntQYWlImwljMktnuoOK0FU7VdnmEfUhfDo+OjhfgnFBJY2XmzqAghXHzcRjzw
 G1iaA+15XNB0/I8KX7ghuf1ORyvwO5kPjUdwZzFtfHK7vsrMsGLJg+YBAP+NNjreTz0j
 aeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719589818; x=1720194618;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tF1N5TvFlgbPuhz7UsAWhJ0PkEpXSXYCOi0u3u9GVDA=;
 b=W0GXtEOh3YskFGcRlDqHHBSQDCrs2htWgKggJbe+XvjNgOI3k/8sQUr4Ntd4QcbAuI
 xjnlNu7c1ZwQqRZwNl+fbBW/KSOsFFLgIi03XhrAiQkemMWGnIYj72UAsZk5vnHyHHrZ
 a2zZ/FHhLAhYw3OAem4cUtpZL2zQssrizn/7t8holUz5KZBarokp3tXZTE4hvEhoJ888
 q8AcPN3r1daVinAMMLsJgUgQLfFd6jQFpQUbZJMDS7BkYD/x7wBxTbs0avki0RWptGHp
 ZYZoDhugPLQ/3kExJ85PhodvwwTsL/H52p1ulfUcqBqP+bmwznWmIIjRjtE5M7J0D4Q4
 nxbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzD7sCguIBVIa+EHE2z86comZuNJ4L325iRScN2LsN84KfhVCiZc6sKKyOW1D0nb2zZeWEO8csPFDz3TMBrjbQIVE9JJc=
X-Gm-Message-State: AOJu0YxmCB6wmsN+firNMYmOT4ITt51NPj7aJl5X96JYQlKrubvaG8/Z
 6HE56vRUwErZRiihxoWRp7Vr2R/6gMWvGOae1TnWykNGdPZ4JP0Am6I111SldHU=
X-Google-Smtp-Source: AGHT+IFrvnm5MUCHLPYwZc3Hn0k4Y4PwAKl0SW8mvnfj4YbVGjfIpALHwdLH6VyEsdccGBo73TpKMg==
X-Received: by 2002:a05:6a20:da82:b0:1be:bf38:7b18 with SMTP id
 adf61e73a8af0-1bebf387cabmr10347066637.60.1719589818233; 
 Fri, 28 Jun 2024 08:50:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1549f2esm17322235ad.164.2024.06.28.08.50.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 08:50:17 -0700 (PDT)
Message-ID: <9c16d849-cccf-4637-858b-e556ddf0869e@linaro.org>
Date: Fri, 28 Jun 2024 08:50:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] target/arm: Make vfp_set_fpscr() call vfp_set_{fpcr, 
 fpsr}
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240628142347.1283015-1-peter.maydell@linaro.org>
 <20240628142347.1283015-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240628142347.1283015-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/28/24 07:23, Peter Maydell wrote:
> +void vfp_set_fpsr(CPUARMState *env, uint32_t val)
> +{
> +    ARMCPU *cpu = env_archcpu(env);
> +
> +    vfp_set_fpsr_to_host(env, val);
> +
> +    if (arm_feature(env, ARM_FEATURE_NEON) ||
> +        cpu_isar_feature(aa32_mve, cpu)) {
> +        /*
> +         * The bit we set within fpscr_q is arbitrary; the register as a
> +         * whole being zero/non-zero is what counts.
> +         */
> +        env->vfp.qc[0] = val & FPCR_QC;

While it's code movement, the comment is out of date.
Update s/fpscr_q/vfp.qc[]/, possibly as a follow-up.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

