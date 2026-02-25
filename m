Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6333BFD45F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 21:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvMke-0005KN-Pz; Wed, 25 Feb 2026 16:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvMkc-0005Jv-WF
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:48:59 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvMkb-0005gc-IU
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:48:58 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-827307b12dfso85848b3a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 13:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772056136; x=1772660936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hE/1PM5dbwL2kBk1LF1eKK4ILUxwlZ8GKE5yrR9IUHE=;
 b=YV4HKH6MhWmh1eYH6x62zmybirThAGd5N3e/zDtadQbAXW/aZopJEwMJmZ679xu0ys
 BVq2OvaoSurPXy3LZNP+vPyRJtDxZgX1nmKHkjJmOkOVitgp4BL8D934E2fTYE8hYDiu
 V9rLgUGwZDUbOQHqeftfnv8jJ36CdFETEuviBBNorksDpTjN5jn7AOZBWoz7CFpvaUqZ
 5/gGE7M0+8t1iq1CSb4OQcb3TiUNxvjYpDIidbCeZVB1kZxVR2d5IpygPsOuXbrQirBL
 06pIFpGdsT8kEbteahlfP2Y+QoxfRE6Yao8+pGo9Pi6wYu+Kr6ksLx5u83Kg9G2TYzFP
 rt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772056136; x=1772660936;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hE/1PM5dbwL2kBk1LF1eKK4ILUxwlZ8GKE5yrR9IUHE=;
 b=dF2v7unfwD5q5OZcS7GheNmv3POYvdhWcPa3kibHCcDPU24XOpF3suiqAUSPTkAdJ7
 TeplMvqRyNQ9yzyyp7p9+WfDIOgXXqBxXI8axuZOxS4WXfsKqsqILdS5j57mYwaKMJNt
 MbJT40q/R4RNR0Vlm9XVU3e5acJJp75ByPMPXZP47FCRtvWghNq/ArZjC3bdWj2iY6jc
 mmqi9kK2fkoEiMupZTsrAUu6mpcj6FEjIjcUHqPGyBFqEEgtqvgG5+bCTpz5fMca9Hap
 kZtqL1mccEp64hOXi/P3uiXnGKItFD474ky8w7hmeXJEQJ+5ellYWSj/ODbxJAKIw7pN
 Ob9Q==
X-Gm-Message-State: AOJu0Yyf8G4zKTmf4q5EMUqS69qQK+XvqKF1QUvWfYCSKlMO0vPGOAVw
 h/9UHulK58IWvJt8dChjZfexBu0DP/hlwf3cj3xMWV6kb8m18AuLjbgicVuC6a9zjtk=
X-Gm-Gg: ATEYQzx2KRZivrwzFHpmw1RUJW/JsVWyYV/W2pbwKkrFnJR4KW8pNAyZpb7oNnCdNvd
 0UxstlofVqONz7FvSoN9hW665b8/HQGXxK5ryv5v9VFvKjqSYutgMtPXx+i4S2+rxra6PFaGzN5
 CWURBzufife3+G/KXmGGNp0El0yzMKiuZNdX7242hfzTssTObRQVSEIoyp6zMg2As2KslwqtCWr
 xiTRXFl3Isc20/F2BKHuFzuO2WxYGEzXzYpNjSnKbMv5+JwYzdTin94oq9SdL0aJGFT1EXNn1dS
 GRoFUgXCttmFbjuOcIGDtvtL7qnXgd0IqTkNC9iM1vU9KayTBP+AMI5YUVreCgIvki4+44XUewH
 /jNEQHHAGkR6RaYV1fOepZquJdfRAtC8vZYPuwX4o1pCuo1WubS14ni2mIg9qohsS8WXr8n6bbk
 HGGgaNOrX4J6T1NkmRcMqq50jfngU3hroBEIR6n7UQFHeEiwZcObPtYPI9qcKlfVmH01q2
X-Received: by 2002:a05:6a00:35c4:b0:81e:7734:9e85 with SMTP id
 d2e1a72fcca58-827398061efmr356596b3a.20.1772056135575; 
 Wed, 25 Feb 2026 13:48:55 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8273a0107f5sm201940b3a.45.2026.02.25.13.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 13:48:55 -0800 (PST)
Message-ID: <d3ea2736-6a1a-4cf3-a071-84d28dc59da4@linaro.org>
Date: Wed, 25 Feb 2026 13:48:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 21/31] hw/arm/smmuv3: Add access checks for
 GERROR_IRQ_CFG registers
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101749.2995372-1-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260221101749.2995372-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 2/21/26 2:17 AM, Tao Tang wrote:
> Add helper functions smmu_msi_supported() and smmu_gerror_irq_cfg_writable()
> to check accessibility of GERROR_IRQ_CFG registers. Reading returns RES0
> when MSI is not supported. Writing is ignored when GERROR_IRQEN is set.
> 
> Additionally, mask reserved bits on writes using SMMU_GERROR_IRQ_CFG0_RESERVED.
> 
> Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
> Fixes: 10a83cb9887e ("hw/arm/smmuv3: Skeleton")
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   hw/arm/smmuv3.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 75 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

