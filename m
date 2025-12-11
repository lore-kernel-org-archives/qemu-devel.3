Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66088D43359
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 22:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTp2W-0007P2-20; Thu, 11 Dec 2025 17:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vTp2U-0007Oj-Kz
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 17:21:34 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vTp2T-0003H6-3A
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 17:21:34 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7b8eff36e3bso899902b3a.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 14:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765491692; x=1766096492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f5xjuMkaaczkaNqjWZ/VAUt1Oj5pKOGI3NKeSFWso6A=;
 b=PLk3ICziswE/zoU6QPOcZxf2pSmdladN/qNIqARPUgVhtoNSiPphZMQnavt2HG+8cs
 7M6fHr/Mr1tXky/+YYBAB/oQZzUfQno4xOj39Th8G+GVqN0OScQu5OVCcwJ1Md/CdD6F
 e2E04/hJdo27N+FoHVcpKLDXyop6ZA8shX65FZxNH3UMEgeruZ8ZpTQ7vIeX/ZkqIMWT
 ZKDXee9DINE9FC4fRdq8xUr4LLTl2AdZJLPGjcThnVVCfv3DrU7YV9OnN3PsW5fwnnZP
 ZlAN+5srYP/FpEryiYpNVr+dunXTwX21g9kq487LZMUGRBsQT+MOoOJDhpfza3tGlmLM
 Gg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765491692; x=1766096492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f5xjuMkaaczkaNqjWZ/VAUt1Oj5pKOGI3NKeSFWso6A=;
 b=H2ZbA+FpteSmIVPYV/0ifOg3ifuxIz82QW2Uy88rFTkhlI2EPCY3WILffnjDWjOoOe
 s2Zvw3TJJHUbcfEU6+8PL6/uX1/q2Z/AQmsYZzNoquWhC1gOGn+ETYHKIYOmQuDjW6wb
 Bb05D/eZacJM/if9zo660JO7Ri31thw6wuU1WbZHll26LvqgnZK6uC6OOL6KTO1pProq
 2Y+QKN2rPzDDGSQ+fnyShVIlDnJK727gnGPByfQ8mFwubrab8Fuk762IlOdJxeBFhND4
 5Yedogzfjwwh/awWBZFs7nZ60yabsZptvGJ/rd7g4MBOR8Td4KPFrV9qx35I6QpZRLqn
 XSaw==
X-Gm-Message-State: AOJu0YxXhKxLeQg3dAhpXDwidczFDXhy5kprQGTadzZ63WQFarjJ646P
 fOny5gYmgQZor+kUiCT3D12ETBnfza+3+abOCV3bsiXrXjUySPL+Y8LFt/CPqeN+MzcOkAXItCo
 mkd7bBsM+ng==
X-Gm-Gg: AY/fxX7RRrMZdziwJwNEDnb47mUtTMaiAtizkTm6Dma0M2W9XRRuPXrHxIp+2XB8ads
 ON1Qkb0zpVYcbMRwzJk05N9S8GDfUmdxSlLwiAzXA9L19Tvvn0U+z2PWD1XiWP4CE+iZ7/IKNAW
 nhRkt14Rc0mbs6/BmkINNJuLGXhHhbcsulxy2QSN7jcBn92Qglxao6iXUFnhuDoJLTSkqNeAj0K
 GyiU7qBPBZxhtscuyemtdRYj1/cA162O20/mLIc9hHBZS3/7VkZdM+zw2JKxvHvRanl0QJ4PzRS
 baGyoiQB6MX5AImuocxg9LJ3C3oYwS5kC82zZem+qTVqAd9731SekMnvsLizLeJDuVLUfuIoKSk
 lobvSc/u9eAnq/Z6r/xQ1NstHi7HWgxZwVYvm52qIXfx7/uWADL8OkeMuMoUmjydEkOk3KiwBdZ
 sv3/hqFXuWsT9PYGXyYCLLLXNMYMNzecu0KzkBP8URBC7sXmp19snM8ms=
X-Google-Smtp-Source: AGHT+IFNm2y4AR3PKe6mILZegPOntdSrjY8+8FE6ss/f/ggJ2n72H1LfJXEQ+9yXsL1OC+ZWe0Sqwg==
X-Received: by 2002:a05:6a21:339b:b0:366:581e:19e9 with SMTP id
 adf61e73a8af0-369adfb3027mr31088637.19.1765491691535; 
 Thu, 11 Dec 2025 14:21:31 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c2c582e86sm3167497a12.33.2025.12.11.14.21.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 14:21:30 -0800 (PST)
Message-ID: <ffeefd82-43a0-412b-bbe3-31018d0321d7@linaro.org>
Date: Thu, 11 Dec 2025 14:21:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/smmu: add memory regions as property for an SMMU
 instance
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 tangtao1634@phytium.com.cn, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-arm@nongnu.org, Eric Auger
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>
References: <20251211221715.2206662-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251211221715.2206662-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 12/11/25 2:17 PM, Pierrick Bouvier wrote:
> This will be used to access non-secure and secure memory. Secure support
> and Granule Protection Check (for RME) for SMMU need to access secure
> memory.
> 
> As well, it allows to remove usage of global address_space_memory,
> allowing different SMMU instances to have a specific view of memory.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/arm/smmu-common.h |  4 ++++
>   hw/arm/sbsa-ref.c            | 16 ++++++++++++----
>   hw/arm/smmu-common.c         | 24 ++++++++++++++++++++++++
>   hw/arm/virt.c                | 16 +++++++++++-----
>   4 files changed, 51 insertions(+), 9 deletions(-)
>

This hopefully solves issue discussed here:
https://lore.kernel.org/qemu-devel/20251012150701.4127034-9-tangtao1634@phytium.com.cn/

