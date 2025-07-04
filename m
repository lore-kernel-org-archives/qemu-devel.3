Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109DDC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 22:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXouO-0000Bq-9I; Fri, 04 Jul 2025 18:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXouN-0000BX-8U
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:29:27 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXouL-0004ye-KA
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:29:26 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7382ffcb373so858579a34.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 15:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751668164; x=1752272964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PSW5Sd3fMRcO+9pF1PYCNd4U9ckjj4wNXGVkuLJI+50=;
 b=J1iitQrLBxH///ssODG5zfEDxcLOSJjHEo4XMR2fbIiIaqkEF8ICoAYVpNf8Uc6Nim
 feXv30sNg+WQcvD4b1FBrdxI6jDBMHNY3jeM8yzF0HCh9Hl4ovDoVVXwur+gPAoE6jvv
 crAL7KAyXc4NZLZfTqytmJ5ImUGLdti8fMoe0EJ4CRjg4ZTWf3X1hvTb/vzaSCdtWzbZ
 r+1xtV2F5uLU1LgwDfgeam2M7Wt/o1C3vSF2mEvatjHVesAnr9ycFD66Ix/cv9Yqtzpm
 9PuLIVxhsvVZnG6mkD9r8YKjwaMhPX9EuRqbADg7BCVxQNay1AN+t30+6y5Zfz/CtEtn
 mlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751668164; x=1752272964;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PSW5Sd3fMRcO+9pF1PYCNd4U9ckjj4wNXGVkuLJI+50=;
 b=HHA8eqTIT1Hp9fn7AMHn/Y9zRUaHHvBUU1j1xbTxU0kFwx5ufcMt4CaBtVnKGz3w3r
 lBgpI+vdyB0GwhntYZqr8SOMcmOmJju5pU0MI6ocl8EulvCxxxnc2wdGr/Ba3VSYZPRt
 cAppwmKm1meKxuvhD0Ylc6vfZ9qHTDbszwdqGZ94zO/78f93GUDrMY2mR8sT/d5Fg6ep
 P7zgLx7daEIWKafK9AEdBLDDMiK0Lt7JgpeYGy51PZX2j1OE8z7q8s4BSI6u95LZAeJp
 St8jsKAcy2Sn8ivlbP/LvpOwBEYQsU+cXhh5eRSpM3gZCIcx/HkgKwvzjSGaQRY3bTcV
 KazQ==
X-Gm-Message-State: AOJu0Yyn96DODujciKqmaVud11jC5qZV6OjF5Jt0pRWoFbLLaPMqd4om
 fy15gniv6MONEGybzFfSs4FBQBVg6mFRHZf+k6e9gIcJ/kaLNas4QnzrmfClOeaBvCw=
X-Gm-Gg: ASbGncvXsH7Qchybx+IhQp9p+E3C4kzWfSPHoR1ih8G32p+yU73cltoqVXssS6KRAPm
 TXgJaYnCdpN4vXINx9+By24Rs492Sm1/zxLJMtrrBIG+uO5Nospq77HWBF2EmiXPTOoR+Ao9T5p
 Sd7fS+UQxhUq2hFmw99TTZ5UekJYzid8EtGHawK0u+CA23Hh2fEb4N07nLk9MZrYX4XkMwOmdlv
 uQWBSIhpPrxdtTTjWCD61TEUVqlJVHXl383pTRZmKZ7GRF3bZQK4wlSeTlJRRK8RJeP3ret8YLZ
 5AFWDWta4mEGf3l17h/ND6jrf2/Y63YGz5gkvcD8v5Gd6n4Xy4GH2g/w/vdS3ijwtsPsSw2/BXp
 rXzKqjHTi0mMXm+M2i2zk/oBj5eo5Kw9nQ2Vo+8Ur
X-Google-Smtp-Source: AGHT+IFNltfHEPPmzoHupTJkq0BusMmkW8D5wSxtbZ0PuXL0cTpWykazdEPe2SQ/Gw2J+K8yY/PfiQ==
X-Received: by 2002:a05:6808:2183:b0:40b:4208:710f with SMTP id
 5614622812f47-40d2cc40ef2mr206202b6e.24.1751668164146; 
 Fri, 04 Jul 2025 15:29:24 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40d02a442d3sm453991b6e.13.2025.07.04.15.29.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 15:29:23 -0700 (PDT)
Message-ID: <04076187-3892-48dd-9b6d-60bd9dc4a16c@linaro.org>
Date: Fri, 4 Jul 2025 16:29:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [WIP-for-10.1 v2 4/5] target/arm: Add FEAT_TCR2
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org
References: <20250704151431.1033520-1-gustavo.romero@linaro.org>
 <20250704151431.1033520-5-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250704151431.1033520-5-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

On 7/4/25 09:14, Gustavo Romero wrote:
> +static CPAccessResult tcr2_access(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                  bool isread)
> +{
> +    return CP_ACCESS_OK;
> +};

Eh?  This is missing everything: TRVM, HCRX_EL2.TCR2En, SCR_EL3.TCR2En.
Two different functions required for TCR2_EL1 and TCR2_EL2.

> +
> +static void tcr2_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                       uint64_t value)
> +{
> +    int el = arm_current_el(env);
> +    uint64_t valid_mask = 0ULL;
> +
> +    valid_mask |= TCR2_AMEC0;
> +    if (el_is_in_host(env, el)) {
> +        if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
> +            valid_mask |= TCR2_AMEC1;
> +	}

This is incorrect.

(1) Both bits are reserved unless FEAT_MEC.
(2) Bits that change interpretation based on el_is_in_host must always be writable, but 
ignored when !el_is_in_host.

> +    }
> +
> +    value &= valid_mask;
> +    raw_write(env, ri, value);
> +}
> +
> +static const ARMCPRegInfo tcr2_reginfo[] = {
> +    { .name = "TCR2_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .opc2 = 3, .crn = 2, .crm = 0,
> +      .access = PL1_RW, .accessfn = tcr2_access,
> +      .writefn = tcr2_write,
> +      .fieldoffset = offsetof(CPUARMState, cp15.tcr2_el[1]) },

Missing FGT and NV2 settings.


r~

