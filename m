Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212CCC54788
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuOF-0007WC-Kz; Wed, 21 Feb 2024 16:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcuOD-0007Vp-UK
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:44:29 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcuOB-0006bW-DJ
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:44:29 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5dbcfa0eb5dso6700843a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708551865; x=1709156665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3ymlyp9LqkKgQT6kNoix2ZwRRamVl7+be284Cy/Jwu4=;
 b=LVENi6p9xg2VD2qd+7RZ/t5AsIA2lGmhDszbhvNDFjd4OJ305oLGonZdnkpglnqz67
 e2YlaItQMYW+ZYl/jLpwp1LZ4iMvY4mHgE4yek/fkj/I/rcWCgdN3+1hkuVXIbcOnTqf
 Q/K69NgXRcak/JtClMIE8SQjjxRm18zfSwbSFFspA9b7OBcZzI+8Q347sy2PmXlvByHQ
 qI3K/LyGv4pIRPOmh763KotumxMsciW1XylwfnI6h57Z69xKUonsi1CCUnywL2fiqAOp
 XSD1EDX5MtCiV3dlCoCG4vTsJj1m95HjxJtomA5WU5K+KVv3HAN4eTVaPRQaub/V0yh2
 aBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708551865; x=1709156665;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ymlyp9LqkKgQT6kNoix2ZwRRamVl7+be284Cy/Jwu4=;
 b=D6DB0IfM5hODdXOBlzECk8236vpIn4Omblm6dYZcIOTQ0BiZrSvtgZPKC9JTwgg2lI
 B2haSewFBDKDCgcSRQsj2Cu0DnzQt8FqIKt87CixNiUIEPkzrTnzGvYxiuFHNOlcmyzV
 xVuKS0Owjis/7NNVNgd4pPo3DoQj9elis1DN/zS33YFwBBIWu6JPJI3Aw9Wgsb02Rcuq
 K0raEa/tKCPJzTEwauZNWoaMfE2dFCk1M7H98pD4GkWKGXPZoW9Pv1gqAg1IBOmd5muR
 rgJMnu+Z3vqwQOI++VbcSIXob4sU4WDdxohJPZz2qoTrcAGkpsqdbygQbsgW8e4OJLY1
 uZjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1mb8HHsNanXbeUg+MhK+S490JoCfHZwrH/zopNxyyB0Kf4V5+3AGudn+WJ98y2dE4M6LrLi+FQgg9mQSI4e0eAmqNA0k=
X-Gm-Message-State: AOJu0Yw6zOLAdiUZzLH64IG7XxRaMICDyOemWBggGxX/L/PZJOuThMUT
 uf2kCrBbjRIa6mNDIwlDmLJf/LhEFWhFElf6qTn0UD0KYlvFa7dqgMfphH/9yrs=
X-Google-Smtp-Source: AGHT+IF/+DWZKWpC726neRMh9kSXStYcqeMfeScMl5QKcxnGNZwKFLITWpRCYE6p0mgQ6fJ9tT6/vg==
X-Received: by 2002:a05:6a21:9216:b0:1a0:776c:f45e with SMTP id
 tl22-20020a056a21921600b001a0776cf45emr22745764pzb.4.1708551865555; 
 Wed, 21 Feb 2024 13:44:25 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 z16-20020aa791d0000000b006e0d165f8a4sm9446676pfa.20.2024.02.21.13.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 13:44:25 -0800 (PST)
Message-ID: <425d1313-a1fb-4098-8413-026c47a6ff44@linaro.org>
Date: Wed, 21 Feb 2024 11:44:22 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 16/22] hw/intc/arm_gicv3: Implement GICD_INMIR
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-17-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240221130823.677762-17-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
> Add GICD_INMIR0, GICD_INMIRnE register and support access GICD_INMIR0.
> 
> Signed-off-by: Jinjie Ruan<ruanjinjie@huawei.com>
> ---
>   hw/intc/arm_gicv3_dist.c | 38 ++++++++++++++++++++++++++++++++++++++
>   hw/intc/gicv3_internal.h |  2 ++
>   2 files changed, 40 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

