Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490C3CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHsX-000685-LF; Fri, 08 May 2026 05:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHsT-00067V-Dj
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:52:14 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHsR-0008Le-P0
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:52:13 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso16113325e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 02:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778233930; x=1778838730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DifUpwIJQepbIyrtHhM2sEXCA4mascvaauCKo3pas9c=;
 b=Vs2yA9bNx4ZyGZwjx+oZ3X2sMh51PQzbn0TTsJZVpcWJauPs8N2aS4RG1rNxS4gxUg
 USu602ZA/rLS1QegF7Xton7MHjNfWi2KzdIvOmYoKG63Id5L01HxoYnJhWjPuT84MmiJ
 QnIAXBmSEo2Vlt12GnqPuQy/jcpxIUVL4rlk8N3yoNVEtZnJLk3t5ldD5xd+nT20yAZ7
 MWjnpe8cKuDusDAFoA6e2bxJhQ6tppvPMOYgsXz0fsbqSLBhOh6fmTBOLw2J8aknEmQe
 WZfZCtX+rSrqNHOeTR+cBUmRIKsP0C5iT+jO2NaDHv7ziUnCBn3t/yyBUqyl3xej0+0h
 QPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778233930; x=1778838730;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DifUpwIJQepbIyrtHhM2sEXCA4mascvaauCKo3pas9c=;
 b=jeTe0eXNPxAc9VJu2gDNHz8xnpNLPWyjmmFEZqNvMmNCa4vdKiSCUDMDvDH4Dh8QMo
 jNw8Nyv7n6PjxFT5BIr/lBaw8/yL5iYSDeUtrhlJnKbDwpt5Smz5xV5RgTUTBMAJ3369
 jDMtQxAe84Z5X2s3OxVLi9qw1ae4lRhDjps3x4dg1y3/uK7c7wqSefArrgQyWqesWQjx
 otThpfhzWqIAmTAhvd4hZ8VyrLIvYLotujOkFkGgyUJ/tfvPiA7EqlosdNXW0g8Tr8rI
 7TMFBMhrpFSd4KybBzp06xSRGeg+fTgZbcwob8xQJthexEY9PHm4wCVCdYwEJKdLE0fO
 UXpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8V6arzpsNzkl6tJJ3XhPBQ6/Ay87cKMTSoQ9K51YNawhX0J74QSpPi2jpsNehSv5eClQSQKlI7IdlG@nongnu.org
X-Gm-Message-State: AOJu0YwXbcrBvJWvTFobXi9No+zUAB7xqVrTbn6cxDvvslvmwl7Y/XVU
 iuyc7vZCycmxdMGG7Hk4KILUcPXrJOAQuVeEF6Ta2W5QNfE07vPGzGO7BeUIMKMRfXTBnWj52NA
 S0kZelZM=
X-Gm-Gg: AeBDievGY9DEYNtFTmyhQ1V4/CN+u79hOQPBXdaB+7K2KPbcnqmkd37gkZXjIyf2YPL
 gzIhVQjrwopjZSyB91AsiwCBs/UDDRH6tmWkOPUgbc+TAUTCFvd5ggf+507PCMzIaCUhcwAD6A6
 FHXw+Ch2shYFLop2Bfvm2Ziff9v4JBS8dyULVRtQQb1m59gi6MZwGZDh9lgQoSPYQSaP/m9dHby
 uOocm904Oxna9gbjacjpYmjXaW6Kf/p+LTgXfdqrKsljZXmR2pcteO/uCxuluCUaxlPhjmaEGtD
 +SLmn7iUFIad62Suxk99nXo7v6+7QP1+JPe/UxYWsFVK+ICSjqsaq0gzJTZGh+6+Cc6HcA6B80Z
 Uk7lVt5psTweyez7L9F8+iQxI+LAVBxIpK5y5mM+QvYQmoUsMRb6+4zwQHnxHUiuqVNZDdkNy/P
 j0c0UFOs2ca3y1l9BykYdF50IvDaGqA9pDAciTgDzcVW/w2LXgvzqyv5XcUdcWHe2YDdtkTQ==
X-Received: by 2002:a05:600c:8115:b0:48a:53ea:1408 with SMTP id
 5b1f17b1804b1-48e51e1804amr172748115e9.8.1778233929966; 
 Fri, 08 May 2026 02:52:09 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e68ec417bsm25272885e9.10.2026.05.08.02.52.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 02:52:09 -0700 (PDT)
Message-ID: <303c398c-124d-4bf7-abd6-88a6b9908b0f@linaro.org>
Date: Fri, 8 May 2026 11:52:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] fpu: Use {get,set}_flush_to_zero everywhere
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260507221717.486023-1-richard.henderson@linaro.org>
 <20260507221717.486023-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507221717.486023-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 8/5/26 00:17, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c             | 2 +-
>   target/arm/tcg/vfp_helper.c | 6 +++---
>   tests/fp/fp-bench.c         | 2 +-
>   fpu/softfloat-parts.c.inc   | 4 ++--
>   4 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

