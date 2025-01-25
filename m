Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A206C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbi7z-00055E-Pn; Sat, 25 Jan 2025 10:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbi7w-00054q-8Y
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:31:18 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbi7u-0005NZ-GN
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:31:16 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2166360285dso53087495ad.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737819073; x=1738423873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TNOXDDG6pi8bpuMWwEFEDCO8sV6WoGp8rEd5fjHZl90=;
 b=TY/DWH81UCpCzUEAZXFiqZafa1g/b11PGalqoQWIrBAWTT4IsZWhCCPCV4K5rvndKo
 4B9qFzm1dCwMnrgZz8zlgzohbPRLbdCkF3xupl3Jdos2FsSYx4uwx4zmnVmGE0kLdwS6
 UIVAf3trC0nQ8pcR+H8R7G3eS6sGLr0qJ06zHfP4YUgftLQ4UnvI6ueHb2DN1U7JMinn
 zXRzO//LYqqtpsIBw0Pvrf/2Vj2YfQrXk5DRb6D4MGjRlu0T0k6T0aos9wmc1cuVu5wx
 zlQKCR4fROfHgqqM3LtBElFv9b6h+iawFsuprxQwqB260vJAr7iXUlLl3TWKrWMn5SA0
 Tfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737819073; x=1738423873;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TNOXDDG6pi8bpuMWwEFEDCO8sV6WoGp8rEd5fjHZl90=;
 b=r2cEqFp91dzyYYwGM45iOPsIkYTJXhHRwNLdaNk/XE0IUekZSzWQVPD0I2mUTHyh9e
 DcqBKbX8vzubRAltdFFSWiK4prghBmjoYnBAmJZgNiYWoKVj+LKT8l9qsg74MPM7SKD3
 rnHzT6EtUqExfuPONAWMZhhk6zq472DigkqrbyTc2hc9p4GsBDBJf/7iM8OdJzNuuHAP
 npDP22fqLC6Hnql39EXOMAPSw9Fwf6uIrNmSspjwwHnkuu9ZHj9MWLWLMGrydFmXduEi
 wZgmcB1vAh/5PTmfPlnmm7LvcD2Vs3AmoRjO039bQ7faBS+CZSMQcD0Etuv4N9sPDhy9
 1cBA==
X-Gm-Message-State: AOJu0YzdAXyW9XphOwnGnRVU/Q4JzrT8dCDMik9cK3Z2mp3OkKG6HDvX
 hyu4+Y4wYwI7U+fj6RpwJZmC2WXLIgZRXCpCFW5e1uHmH8fZM2u80Pep41NaV/Y5dv0oyjhiHMu
 y
X-Gm-Gg: ASbGncvKtt5J9iOR/3BKVPYqg3VZ5I4YoylEAavEE8hK4j7l2SfxrUTgh5VNwQugdz3
 /ClqeCnGnhuydaRELSC0+Cdsudji9YoAhgCI7tz42lKcrYAcDOiI5EUkbKhtvqLToK9s43WGPB4
 t1yEEGAodxRiEhW7XjoxxOtgIr2mX8mK61KLUD9XLvRRZL7GM56TSlVGKSXhVYbyPq1yo4hcVyM
 rpsxQATdwDSyxivM7cNceImJhKhUIt8UcVQpyPbFjqIhvcJ+Fau9ACaivoLlKvfQHl0NZNRqgho
 KHBnrEK58BMW2UMjSU2KuQ==
X-Google-Smtp-Source: AGHT+IFI/RyRmPTgs9GBAi6Lvzt0eP0KZ4TFpVTv7veL31orLOqg9KR1WpJ0cWwnLkBXYJDMbzIuhg==
X-Received: by 2002:aa7:88c8:0:b0:728:e9d1:218a with SMTP id
 d2e1a72fcca58-72dafa68ebfmr39690677b3a.17.1737819071740; 
 Sat, 25 Jan 2025 07:31:11 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a77c560sm3933648b3a.142.2025.01.25.07.31.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:31:11 -0800 (PST)
Message-ID: <34c5e53f-0f8e-4b12-9952-307f16261ebc@linaro.org>
Date: Sat, 25 Jan 2025 07:31:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/76] fpu: Add float_class_denormal
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-23-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-23-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> Currently in softfloat we canonicalize input denormals and so the
> code that implements floating point operations does not need to care
> whether the input value was originally normal or denormal.  However,
> both x86 and Arm FEAT_AFP require that an exception flag is set if:
>   * an input is denormal
>   * that input is not squashed to zero
>   * that input is actually used in the calculation (e.g. we
>     did not find the other input was a NaN)
> 
> So we need to track that the input was a non-squashed denormal.  To
> do this we add a new value to the FloatClass enum.  In this commit we
> add the value and adjust the code everywhere that looks at FloatClass
> values so that the new float_class_denormal behaves identically to
> float_class_normal.  We will add the code that does the "raise a new
> float exception flag if an input was an unsquashed denormal and we
> used it" in a subsequent commit.
> 
> There should be no behavioural change in this commit.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   fpu/softfloat.c           | 32 ++++++++++++++++++++++++++++---
>   fpu/softfloat-parts.c.inc | 40 ++++++++++++++++++++++++---------------
>   2 files changed, 54 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

