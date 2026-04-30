Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D04FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJNs-0005ZU-Sv; Thu, 30 Apr 2026 00:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJNs-0005ZM-Cb
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:52:20 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJNr-0001GP-2E
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:52:20 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso5099205e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777524737; x=1778129537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5ssSbN07k6VyzqD7d6Rjkr1auXjJalciNKCxAMT1M2E=;
 b=R7qq+1qaSaQ4F75IvYACqxGJ7tTz5VxL0Y4BBHZdm4pWWoZRrovsqtAW7bd3q1mxNx
 GWsNGkPfR9c+orHGlWYpz5bJQ1OQNGFojpp6fiiU0x1ewE6raM+lFER74ScmwlFIi5Dc
 bHODOfA6TAFanc/X9rnztiQlVMuKg+psQTcOUff7FcbSejaafxbva4cFGswm+7vMI7/y
 9AsSvFGvNdMTWxy5CVI7ikPcpy77a6CWTJ9DOmIfdpHzgfMOgNllRRbyB4/AO4y9HHR5
 rnVhsQUtjCYu7rjfxuW9fRfSsNxmndaL2/r7BeQ9AaBWyx7CnbNSLdvUzPY48gNJPJnO
 6RbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777524737; x=1778129537;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5ssSbN07k6VyzqD7d6Rjkr1auXjJalciNKCxAMT1M2E=;
 b=pF5F1fSwokw0h1nk3N+hknYLMstByiEf+NmjdB2fN1/EA4bpWWxr6sLuxuDdqXzvKs
 mTkokLkqoxBbooalMc/RipGNJzKh/pEEaGgHwTHUANC2hKdXHMAxeoYR1xePq8r4BYS1
 tzW2ZWREKEcVcL0N9wkeagXa3ZRzDrh1HkfN9e1/mnaQxgu+Gr7U4QVQsoGH7A68bJLv
 ImGjdfd9LP2iBtlrU6p4d2ykHHZS7rUfD3FnT27OoJFisV4cZ9r6cG/VNCLFltd3WcTD
 iprUGPI1e2Qk2At4/W12PC9H4/+A9eF8v1Dt/uxgZiet7C9OoDT5Zh2dKW7oFq/TtzsI
 C8WA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3WQyipTWwd+9LLn8pZQgNf7rb59c2YhOQc89WLMEaAgg0/jVJtxMJeQrPxDCvIXtOtApPFZ/sIhNs@nongnu.org
X-Gm-Message-State: AOJu0YwwhvMiBMMtqfnaex188Gz2jOV/nIhzBTP9g1GYFb1HhQ9dHphA
 FjyKa8srP7R17jM0xuyaaS0xuCIXSgJN2hxR+ODOlx8qhYZYtnOLoM1hTzk6i+ptGQQ=
X-Gm-Gg: AeBDiev6vcKf3HaTahbtPtVXFaSKtNF/Wnft5QIAa9B80JSp9ACy4ZQRG7+ud7BeYog
 jVL+bLUvpO+sygfUoR3YmHuXBw/NdtAMzO3VHwiTXowxh6iGeEKD6unmnFpE/OQ1x5oJ2LYiUcK
 j+oDBodymhdJsh5Rd7haG5Tf2rFTeGKejWRTlneW5vwDqrtqKxmZPu03/NQV2BtdJFRbXUcMfkY
 NPNkmyGV2zU6HQwIlAaHfrztwHqaA8I7B7dV9jxfPrRn+G9HmIU6TVa9GNXk1ebjQo9efcuBOKh
 F3OD7LpW0JrsqBasCfcKYvzEE4nvWOF7sqlegUIiT3UaQ5IiY8pKwHgKcjjAdhdYYa+JVaYMqqd
 AFf6ibOhHIXCGg5HCI9UO7HYsIDECiTs+afVM4KkvbKfulws51sQRqh5e7HcnIQPKZZD95Bob9m
 MnWUVy4fJvMYSxZ2DZNRmI0g9vZbf8zy1rkzNisfgIuaecYtbVksPMGA1qOY7S7j7k2fYXpSLCP
 Qus
X-Received: by 2002:a05:600c:859a:b0:48a:65a5:750f with SMTP id
 5b1f17b1804b1-48a84484fbdmr13685805e9.21.1777524736905; 
 Wed, 29 Apr 2026 21:52:16 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82301ad1sm69168445e9.9.2026.04.29.21.52.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 21:52:16 -0700 (PDT)
Message-ID: <c67dd4ff-c90c-4eb8-bc88-73be242a2c96@linaro.org>
Date: Thu, 30 Apr 2026 06:52:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/40] fpu: Export FloatFmt structures
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 30/4/26 02:04, Richard Henderson wrote:
> Export most of the FloatFmt structures.
> Skip float16_params_ahp and the floatx80 precisions.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-parts.h | 48 ++++++++++++++++++++++++++++++
>   fpu/softfloat.c               | 55 +++++------------------------------
>   2 files changed, 56 insertions(+), 47 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

