Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C962AE7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 23:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW1w1-0007lW-2I; Thu, 09 Jan 2025 18:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1vz-0007lO-Hh
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:27:27 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1vy-00036Y-3s
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:27:27 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so11662885e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 15:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736465244; x=1737070044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r6b0hRLM814SNKqd+BfCZyrHbHQigp3DUDKVB+BSMXM=;
 b=qUUMg1emxAIEOp/10bmw8Ez4OF5MGOF2YQMmPMkl6BEspPWXPM1cYaxqRChaKnDrM3
 vyPFlTNp55iHBH7929n1SJ2DMAKCMc9xGoiwy4G2RgwpaP7atWx23p033u5F45UlAmoM
 BqytUvn960tPjCKVQ1dV6/iLXHXsuM3sd9bcvXf3jexjWuPlJnCrTK4qshGcnrCekqiu
 J+/+HBYd6Gk7TFY84Qapaa1hTBT8dsVTSCjHNlgJYE1FaYGOPKcSV3fmKt9jjVDEsO9M
 9RDJekgx+OBODO06CJAI9Bw34B8b1QUR7SmR8/PY4YGjB8Z6laHenLcu2b2STAn1Oqf5
 499g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736465244; x=1737070044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r6b0hRLM814SNKqd+BfCZyrHbHQigp3DUDKVB+BSMXM=;
 b=SSX+pJS74A3tcV7T50Kbw1580f6UwFdxmXksLE//KJ4pDGgO6xXCrfjyTp/E6hL8wN
 i0StRWyiU4YKjyketwRj6rTHRsUbY4iBE8B/fib+QTUD6vHTf/kLm6O9VZ1b5u46JzzQ
 ZzckADAzTlWRwJ1HSPmoiGB+iyW070Lf5HBT83aaEEyNsNohYpJu1JVu05Pvl52DRArC
 xsxguAp2RNkTmJzNrrcjnaQXH4GYT25nuZve1TAEQiKmgmsLKBl3OPy6B+7jgZV3YTwM
 NBnC0qP/+xoARqh6WhIulQPunc8DTJ4TZgK/etRWvuGu7oRNOCNDqBZ5fdOMZsZLAiXF
 tB/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuXTK+UgdtcPeOSTnJPTDwJTKn0hvDj3G+BGBO7fDsf9g1mVhzlJwVkvht6e9TAtTRWPUoQ9YSdVg5@nongnu.org
X-Gm-Message-State: AOJu0Yxn2mNArMwwOVXj+LOEsjF664hj9YRzbrNiPjcIU46Yx6VaTl/r
 4AJHUlG7BSEmY0/F3SjV0oGXcFakJMiak9F2SSRc+WPqrPCLypIn82XnLna3ynA=
X-Gm-Gg: ASbGncvHgK8AVFefAuZOKL0ell7+i91vwkVgwQ6Jdyh+Xud5dS4/oulnwCB1yjurmJI
 aNAP/rgL9c0gP2D1G158EtcT2ZyVGntiKOMA4tvztgm3pdcFDY5D8/SLA+9ws0IBTFaQvpg0QaC
 XRc9Z9MmFI82c7r53uPNuKLjPEUyR3qgaVJNQOgy9VHRMBh8W8w5NBzG+Un3q0bVaP6xr/FiuGl
 z5vIydP+KFzeBgTpPWsEHoyrBV47M8n7AZZAqx7OWIy4baTGn7ebLpcCrG5D0gxL6agI0RYnkWO
 jwZ3o8Ri3aFXPhNh2XnVFRPCpGw=
X-Google-Smtp-Source: AGHT+IEngWtvxKEOiGJvMtAv8V8qp1XlTSyGTPKS3118HvTZXyZXoef3Hk7v/wmqp1tGS2zLx37sAA==
X-Received: by 2002:a05:600c:5117:b0:431:60ec:7a96 with SMTP id
 5b1f17b1804b1-436e26ddc53mr65923335e9.25.1736465244209; 
 Thu, 09 Jan 2025 15:27:24 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e37d46sm34055905e9.25.2025.01.09.15.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 15:27:23 -0800 (PST)
Message-ID: <52861d83-4695-44ea-8199-837dbe9ce15c@linaro.org>
Date: Fri, 10 Jan 2025 00:27:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 67/81] tcg/optimize: Fold eqv with immediate to xor
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-68-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-68-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


