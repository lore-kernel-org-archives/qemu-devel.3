Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE15CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 08:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBqVc-0000hR-9D; Thu, 23 Oct 2025 04:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBqVJ-0000cq-QI
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 04:17:06 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBqVD-0006ac-GG
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 04:16:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso5288725e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 01:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761207413; x=1761812213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jYFpb3kXxgsMmagIn1nhcIKCG/vI488Zt38/aF91mTA=;
 b=AWLjcXkYIkEzHV/4QEbCk9M37QZU+dSLIoaTmGUj7Lxz4Vzrj+4jRRBFCTTn6ovLLy
 AHUG8HTrrkhrrhzQpuyLCNnTBAhO914UGjnvbrekoYkGAbSD4/E0TGycS/YFKnG3tszi
 nEFESux0szVGTrpBHL1LnGcDFun+vg+Og2H2oG/v39IyhO9OTG7/xsVMn9Q5R0fuXmfU
 /q9E2OHk+GAXQPecz4ok1mKhW1r8Qh66ykoSxt1r2YznBH3IDF0+cbRO3qfU6mK/PQPH
 URAe4i688QWWz76CNJgj21XJyEM5TN3BoZv4fCR2s7jFmVIg/S9riQZNPX1G/Ojr4Ljs
 kW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761207413; x=1761812213;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jYFpb3kXxgsMmagIn1nhcIKCG/vI488Zt38/aF91mTA=;
 b=AUZqEajey1wrZhycJ3GJBY+GYk2XmBvrUVkPe/bZEF686HE3pg4HeIvhrXuqy1C1m7
 yrvHkU4ixvc4ZoVwPDnLy2VPNTc1TLf385lXGZ2KojCS56N+TsTkvB29Vg+4T1ZeMFci
 OIgmPQGsQh+KJh6qcfT0hS51voAEoFLqv/GFVesTD3zQORylm1+erj/PpQSuPJZOQrCn
 8TbxXhVXRyRh/TNePlCqHn0/Dit7yW5PenvP+uzAGolXmf8Q+XZKzliubwJUfNeEpr8e
 yyns2Suaomv/W2M4uypgkyVU3lEF066BDNNC9y3IYEBMIBv2TpZIcmrhxKOgb11fkN33
 KCGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXgjiB+OUnn0DSjWLOsY2RXX/OP9kZ2ZKo7GK75ysQegPOtt+GPVO41Hzt0xo9RjnrD7+By+lbydx+@nongnu.org
X-Gm-Message-State: AOJu0Yy0GW1cIT4Yztb6J9UFU1onY9WqSX4NOoatXFIT0FxtcX6r90yI
 oua+9alGsYi4bpcIuuKC2dSLCO3A8yZw4Yuzdax2z0lkIBAp2KI6kGn0wQRNOgJ2k94=
X-Gm-Gg: ASbGncsyGW2kIGbdU4YYHJGagzEhX+LNDzqyj18mM5QUwJFIxksGA52SfL3a+WIMuHs
 eDnaqLwxqmQ7s4ix4rWBHN31EkK8JuQpZtcWL1aPwS9TGFulRAi5d4FZ0ghmSwVGA1A19E8pAnV
 rzK3vEbnzTP5CP7BlsI/b+8iX2b6ZFs/gzCKvYJDPyGRuKsB9nhzKbtE8e4gXexxlGZPX97Ud6m
 Qu3FWa6THdoFuUWo9DGEQp/Hpa7vhs7oMHM1WTbDMFPHhLpq9qugNXc70IYSA4kFewcRZqRUi/m
 EGqbztWgKd+Vn6HqHQ4950DUiYZttwLQ4Bzgfc0BypZtFvA/rtWvTt3dj9PG4pVIRTzxoOfjS3o
 KsPnXpVrhcv3HJ1TpS0sXQi3S8TUAiW1k1+bCHkbNQU9AoZjmPL40qhxYPHoIWclFW3k7Js74GN
 q6qk3NrgCUc9es9QHhRuHPG2LZw5pGXSjf5tMF0Zfzyig=
X-Google-Smtp-Source: AGHT+IGU/ef0PqDqRYCsHbaBkgVYy3iDEnrCD9SKPMOTNW8xz3F3gByVWSaDDZDkBoodXhZCJAbTSg==
X-Received: by 2002:a05:600c:3f08:b0:470:ffd1:782d with SMTP id
 5b1f17b1804b1-47117876a19mr195200245e9.6.1761207413355; 
 Thu, 23 Oct 2025 01:16:53 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47494ac30b4sm53905885e9.2.2025.10.23.01.16.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 01:16:52 -0700 (PDT)
Message-ID: <7a50b3b9-3bf6-4e4e-97b6-b927ad48902b@linaro.org>
Date: Thu, 23 Oct 2025 10:16:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iotests: Run iotests with sanitizers
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20251023-iotests-v1-0-fab143ca4c2f@rsg.ci.i.u-tokyo.ac.jp>
 <20251023-iotests-v1-2-fab143ca4c2f@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251023-iotests-v1-2-fab143ca4c2f@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 23/10/25 10:10, Akihiko Odaki wrote:
> Commit 2cc4d1c5eab1 ("tests/check-block: Skip iotests when sanitizers
> are enabled") changed iotests to skip when sanitizers are enabled.
> The rationale is that AddressSanitizer emits warnings and reports leaks,
> which results in test breakage. Later, sanitizers that are enabled for
> production environments (safe-stack and cfi-icall) were exempted.
> 
> However, this approach has a few problems.
> 
> - It requires rebuild to disable sanitizers if the existing build has
>    them enabled.
> - It disables other useful non-production sanitizers.
> - The exemption of safe-stack and cfi-icall is not correctly
>    implemented, so qemu-iotests are incorrectly enabled whenever either
>    safe-stack or cfi-icall is enabled *and*, even if there is another
>    sanitizer like AddressSanitizer.
> 
> To solve these problems, direct AddressSanitizer warnings to separate
> files to avoid changing the test results, and selectively disable
> leak detection at runtime instead of requiring to disable all
> sanitizers at buildtime.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   tests/qemu-iotests/meson.build   |  8 --------
>   tests/qemu-iotests/testrunner.py | 12 ++++++++++++
>   2 files changed, 12 insertions(+), 8 deletions(-)

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


