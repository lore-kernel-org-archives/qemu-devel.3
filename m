Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E81C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 16:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP33Z-0006ZJ-HO; Wed, 03 Jul 2024 12:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP33Y-0006Yw-3Z
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 12:42:08 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP33V-0004ZF-3D
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 12:42:06 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7067108f2cdso4311048b3a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 09:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720024923; x=1720629723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ijUaT7FMtRGU/YN4aXpAULqtZdn68hVnjBIDO905N9s=;
 b=OlFoxlpW+d/auhRF/YrjrmzbLpONL4XFYYXNBkl3W0kD2vZs2FKU/kV8l5zuPJV0dE
 cH66fm9XpwqKHHnJysYwN/thUB043veK4edvJZUlXSkQAKD3TLUr9/sqXIpehOlmRpUP
 oPqrHJwudx7Q6A6QJZH+1X4T45ULANeIgh0dl99LnZrPaX0CIHjhBjh69nhrbfXOEe68
 1Y4/ZhSk1085eS21aSH35snKVyfIbyPpDW6Mw+U6TsiHhvVPj9qIbP1T847tqdlIBThg
 iBBMSxtZ8uO8g5wJRQxdAT+dssF74vRB89e7YU4A1MlEUs6MYldinfMjXIAcHI259aOb
 PjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720024923; x=1720629723;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ijUaT7FMtRGU/YN4aXpAULqtZdn68hVnjBIDO905N9s=;
 b=XZ7YNXakMRTlaQ77o0c2FXsjVVwx1+/IIvO2HN8HqLlVVDaG6OSptw/0gJ7w29A/b1
 cRdAmOf8FnKwXtzG1HeRiAkFoK0FUxqbThucZUp5Dh21wzn0hoME+p3HpXMbalxgcmp1
 6zMIYv78iaGBNHXxxb6ypaiD16m9KFnr7YyXRWKXd1VzOmr6gbS7B7vEu5++LsTmc58n
 qGx9sK6M8Cf6+DGqeluByP/xAwlW0MxoDQ/O25ZREK5PmoHoNnUkSOZMvtJPEcLFxnoN
 JO3W8fmhcIBV8Ye6rWBUAvB4BnA5xW7+hwWly3kmzQas3TEAu3FTbF/tXT/F4FgdLH9X
 VDUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4DKDAxZVGNpX3xzNOi4l4IJlpL4AQ688HrfMLvRCeEExEETAxp7wF086QMo4HK0Kn7UpqQMNyYjY9i3WT4Zv0oG+fgbg=
X-Gm-Message-State: AOJu0YxRW4NG+Dw0vXYOtyMERp2OfxiME32GfOapDaPvKggseY5QXL8Q
 Vwg1aVClljXvJLLFaftcRZen8YnTprTuA8zPULTCV1v+y47i+62sXicJlpuoO9Y=
X-Google-Smtp-Source: AGHT+IGMAEg7dT5FvuP6oUufVl4qBni9qKMfrKQ1LbGNDL6SbpMDRGtgoJT7Zr8z83SdyiGEbwTKow==
X-Received: by 2002:a05:6a00:2d83:b0:706:62b6:cbcf with SMTP id
 d2e1a72fcca58-70aaaf1dffdmr13312251b3a.30.1720024922950; 
 Wed, 03 Jul 2024 09:42:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70803ed469fsm10665073b3a.111.2024.07.03.09.42.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 09:42:02 -0700 (PDT)
Message-ID: <9c5dbe05-7097-4fba-abe8-e7ecbf60e15f@linaro.org>
Date: Wed, 3 Jul 2024 09:42:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: SEV: fix formatting of CPUID mismatch message
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240703104312.1642361-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240703104312.1642361-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 7/3/24 03:43, Paolo Bonzini wrote:
> Fixes: 70943ad8e4d ("i386/sev: Add support for SNP CPUID validation", 2024-06-05)
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/sev.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

