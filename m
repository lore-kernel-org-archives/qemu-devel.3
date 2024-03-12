Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D374C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 20:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk8cH-00008B-K3; Tue, 12 Mar 2024 16:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rk8cG-000082-Fx
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:20:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rk8cE-0002K4-W3
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:20:52 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41329a665d8so19752925e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 13:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710274849; x=1710879649; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YUZ4qL6mx9uzaL2tf+9xYVmLzr4Smb+H0BA5f3drV1o=;
 b=cMZbZl9cshcQWdzIRDyXeEMTXNKYpCTUzF0s/wQ2DFtmxh50bEDO+isa+jkjtDSS+9
 920EKu96QEQPy66mmKBMtHYt5v47jKIJAnmcPrVotFprb+TPav/IPPNR/ZZXSKNjN/Em
 V+tjJnTui+gGHrs4y7kw6fFLNWo6B6mS6xQaA5hrz1+iHHAodc4YDw7tlmoPfi7MS5k+
 F7LGBmn6h+lV3vFnMVr2FWoLMgYz1elB/U44Q/Q0/U43N7NG3/EVT2RemE6Oi3ghZVkx
 SHh30ZeBznbMe6dhNYG4wAWreC1YiK/BVZmkbPOwja/Vk5NjuW244k7x4RmkUyTnkpz0
 MqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710274849; x=1710879649;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YUZ4qL6mx9uzaL2tf+9xYVmLzr4Smb+H0BA5f3drV1o=;
 b=BSgsPf/2AtgUTiPgSo6gDn8PI6pnvrIfh00eGvcp6S0F9zqvZhXK94prkXZcWjrlKb
 cn8rdIoZgzGy2NSJsDdrXoDKn5PSzJupHOpfgyayjC5p+NRXh58MqU6tUGwIVpLpuPZ7
 k4bHiAPSIiPqyFup+oB+h9ygLaaHuQ+8cYsMvO+P/L2Iy6VK4z1uuQxE9mBGfymzd+0r
 YQ0wdBIZ1GakZ9ofYcfVX3PoMIGh5pmlZKbwGYxW8F92poJAu0A348jOTM5IKE54drOQ
 Jwqk+I3IzqrZyZ3uKty66lb8+nDiDHXKmzH4D5D0krlASDxKKRS+pl6RlhvvrtaT9uaW
 eWnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnwuYVy4c8SNxen10Y0lIA+Qw/r32ZOQobIw5hxfncAH5LOnvWM9EXLIxOdYOWUorkgmt2aWk8daLKSSYbVyI2snU8kys=
X-Gm-Message-State: AOJu0YzcEsSlmhfnyClFxgGifISRs1FmsmyW7RMMTBWI/pN9M02kwrJX
 5KafY7OkbgXXWuewv/7OtPpHDxYnLvj6TksgwR/SOSvHzHpdjZS/MjUpsz5gGBorj/SyHe9cJX8
 ydOI=
X-Google-Smtp-Source: AGHT+IE3FdGw2utSO+cNz7SGoBjQdMx2ESx9RlVobrs42jpDLqcCrTnax8C53oxqOaD4LiHEUKKJig==
X-Received: by 2002:a05:600c:c14:b0:413:2cbe:2398 with SMTP id
 fm20-20020a05600c0c1400b004132cbe2398mr4443556wmb.1.1710274849438; 
 Tue, 12 Mar 2024 13:20:49 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 r13-20020a05600c458d00b00413e6a1935dsm621722wmo.36.2024.03.12.13.20.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 13:20:49 -0700 (PDT)
Message-ID: <135e2605-f43f-43a5-9862-146fc746d624@linaro.org>
Date: Tue, 12 Mar 2024 21:20:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] tests/qtest/libqtest.c: Check for g_setenv() failure
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240312183810.557768-1-peter.maydell@linaro.org>
 <20240312183810.557768-8-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240312183810.557768-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 12/3/24 19:38, Peter Maydell wrote:
> Coverity points out that g_setenv() can fail and we don't
> check for this in qtest_inproc_init(). In practice this will
> only fail if a memory allocation failed in setenv() or if
> the caller passed an invalid architecture name (e.g. one
> with an '=' in it), so rather than requiring the callsite
> to check for failure, make g_setenv() failure fatal here,
> similarly to what we did in commit aca68d95c515.
> 
> Resolves: Coverity CID 1497485
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/qtest/libqtest.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


