Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BE4C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrKV-00018R-59; Wed, 21 Feb 2024 13:28:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcrKT-00017w-5t
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:28:25 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcrKR-0004Rv-GK
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:28:24 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dc1ff3ba1aso16722225ad.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708540102; x=1709144902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dCt/xZht6j+ruMBWjNo94PLoSvyswCPBO6OZhq2J/tc=;
 b=KSGSrn3pXuWxy2PC0OnEvHCBKLC6ZLXjd/evEtoRC6SpkH2z9wkZIhTqBUQ/aLO0bn
 tSGPmYZVXbsY8GDjy+ogM7ZWpNN3b6Y5ahp1sMaOpbsJ0u9/J4lmdHOpHea4Exy59S5M
 c2GkSHVmJCwDc4s5Ss8ScVssnQuvAMmeqhQfJGB6fMqClsh4bSSRW4sRMcmMkPHxtK0G
 Z9ipreYg1h3biCaxau4Ao33ktfvNS2BDFJwM1q1UybHt4zNSFg+afdM7T6GhCM53xHIY
 MDXi7feA58fnrUaL5Co7HSbA+nrOWhy4WSWA6zqReasD+db65ZNuEaNbcj8byKXQXpLd
 +Wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708540102; x=1709144902;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dCt/xZht6j+ruMBWjNo94PLoSvyswCPBO6OZhq2J/tc=;
 b=rPDqwgMjsE/GMrEI1WW2qeQ31SBuNUWY5Ow/GZhW6ea4e7NnpWysLnP2Jm88VUDVS8
 KiQKmwtigpLVkubD8J9H9C5q60Q7glUh+PRqiS2eyRCOW3pK06wNuofbPAZX4tBqIbyG
 wMwd0BHOIifCPL+jE/LWA0wHyMtgntLcwKgJZP20Tsgd+/l8JoYndR/F1Q85KauKAFld
 pgF7Y32KQnsjcuCHGsPcKScFEIpBFdlSiA639Tjqkg4oP+1SCNCgc52cfUPZcJjyo36z
 ghnIeYmr8R+9KZuFA1Gi7AUqir0qL/nNXAx/Pt7kAX76MTy8nAjUzQ75AJaYoR1Kfcm4
 ax8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6W/YZ3WogaDDt1oVmkrfeborXP8n9/w9ARa8jD7KhI5X8xFLuDzNZI+2gpGK9qQcdIMj9GJCtslNyE1zszmNM+AQjjOo=
X-Gm-Message-State: AOJu0YwxFUb21zOUMywEH51FYjRgLpG8O6V7Ahbv2veUV2/kix+kp+EV
 PcltqHfZXqnk5GswUKt+gAqat2DFtGpfBpAv4CN4tiO+xUgGmMb9/PU7qO2vyUk=
X-Google-Smtp-Source: AGHT+IHxvRqtY4vjRpo3w0jYmUbW2KS1vgZrs/S0MZCdIMXH84FvY+bHKsPORHZ5vVGgLPc1XwStew==
X-Received: by 2002:a17:902:ccc2:b0:1dc:418f:c8a2 with SMTP id
 z2-20020a170902ccc200b001dc418fc8a2mr1172919ple.21.1708540101935; 
 Wed, 21 Feb 2024 10:28:21 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 kj4-20020a17090306c400b001db9c3d6506sm8452403plb.209.2024.02.21.10.28.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 10:28:21 -0800 (PST)
Message-ID: <b6a427fd-80d0-486c-a1ac-ccf394713969@linaro.org>
Date: Wed, 21 Feb 2024 08:28:17 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 02/22] target/arm: Handle HCR_EL2 accesses for bits
 introduced with FEAT_NMI
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-3-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240221130823.677762-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/21/24 03:08, Jinjie Ruan via wrote:
> FEAT_NMI defines another new bit in HCRX_EL2: TALLINT. When the
> feature is enabled, allow this bit to be written in HCRX_EL2.
> 
> Signed-off-by: Jinjie Ruan<ruanjinjie@huawei.com>
> ---
>   target/arm/cpu-features.h | 5 +++++
>   target/arm/helper.c       | 5 +++++
>   2 files changed, 10 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

