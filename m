Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4171C0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 21:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcAaU-0007gH-QG; Sun, 26 Jan 2025 16:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcAaO-0007WH-4a
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:54:35 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcAaK-000690-HR
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:54:30 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21654fdd5daso63420895ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 13:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737928467; x=1738533267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ABiMwPoBWKSO5FIltdFSYs6UuGLMiDwfONbqOYocom4=;
 b=H3wPZf4qVt1CdoMD5+6kQbosCaf0tNkd2eXPEJ1fFZFssddGaIUVn8H1XRuMuAbrhi
 FrNufrwdcua+q1mIvwmuCdxU4G3Qrtd7iJjRAoBOCjqm/Q9Un2r/pbFuBBvaehZ9bfj9
 eVIpYrA4tHB2V/5Lg5tcxMmlNkJQIDNOq6Z92spFeEjiq9X5oXsG4T/7J5xqhOXCXj/I
 FyHXyvEJgdlr7absv83Xa6XHLLMk+EiQB8gMwzB9RVQ5H1URd3mVNmPw7yxxHSciSDwk
 x17sQ6oZ8HDN7lLIni0z6oYUuwNEPzhhgfVzEoijGpNHZb0mYkSbudnL3lhCk9XtL4rt
 hLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737928467; x=1738533267;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ABiMwPoBWKSO5FIltdFSYs6UuGLMiDwfONbqOYocom4=;
 b=KCWoXcej4ZZmGSabh5pUgyBy7yXpqMGa/oN8toB1bG/JmFM6v7nygEyU1pCUNd8yu+
 cXmdSbi1J8L0AuTjSzoyZmolI/YFH+mlHV3o+u2ucGH0ZIl9Ez+x+beGtCbR/0qOg89M
 PrYP+8CXeztQgxA1WaVHqpLtotFWR5i+RzRQN4risVjQ+URcfZivi++1uO1BkOXM7SgS
 OL2VSHvPNLp/8RbVGKCkuMVjwy20Zw1lawVQfchiqk4UL6hKwyRAaw8qk3b2ytv2wqz4
 mPSmbIaFUrNSL8BhNMIJzrGbSq/YQ85raCT+ArfPzSSPkgLy9Y2q1kjGj4DwLDfEcnbx
 NwEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2P1hb1aUjtRtCjqKyLDNuAJEWNFt9V4+Cc6W9uc+ZoH4h9kqUXb5IP1JywJW13mbt/2HgydH4pNVC@nongnu.org
X-Gm-Message-State: AOJu0Yx+uflcdxAQMTni+zrjbxIUxVqJFquI7VhwTL7QM6Iu6wEAt1dr
 P0wgmohBta75S6T4TEteB1tVSeaYjVg4JUcLI0kCU1RTvAmnWdpOj+JBQMrmttOnq3zFRwvDaFo
 J
X-Gm-Gg: ASbGncu3W6otkw8nWgoYBgcg9ldnfg5Gwhhsh3UTr/X2gCbTA1J2L+O2qrB0aFIY06D
 cVIJBKowleXK/pVZUm23h4rBQL55n6y3leoejp2DNIocrGbabfql9vIT96DHJtk/8eye4pxQsaT
 LSs4nYllJsxGehJ9LT7aLH7g6ak8dg/LMRTWyhKjr1HSX2M/W8gstNrOJCV96YroR7F88/fVi6Z
 XAZAIYc+x4YNjUCaCmC+q3NOdlV4KAsLZRB4ojgH2Bx1VfC+gCdEGya+tvtCB5gTcTvxCY8rQvC
 HNwpe4nE9UFN/NdsZpZsp6cGEb5JHlb2p5ulfIdSJZkWqIs=
X-Google-Smtp-Source: AGHT+IHGXG/TKyPDWfq7WcMnGKiNhxdgXoxHNg1D1+qFskDHBbjK1Haho7c4AbNtrnkhwSPA2bf0xg==
X-Received: by 2002:a17:902:ccd1:b0:21c:17b2:d346 with SMTP id
 d9443c01a7336-21c35593de0mr606114955ad.32.1737928467056; 
 Sun, 26 Jan 2025 13:54:27 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3d9dedcsm50546455ad.46.2025.01.26.13.54.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 13:54:26 -0800 (PST)
Message-ID: <87bb71a4-8ff3-4ae9-90be-f40034de415c@linaro.org>
Date: Sun, 26 Jan 2025 13:54:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] hw/i386: Have X86_IOMMU devices inherit from
 DYNAMIC_SYS_BUS_DEVICE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250125181343.59151-1-philmd@linaro.org>
 <20250125181343.59151-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250125181343.59151-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/25/25 10:13, Philippe Mathieu-Daudé wrote:
> Do not explain why _X86_IOMMU devices are user_creatable,
> have them inherit TYPE_DYNAMIC_SYS_BUS_DEVICE, to explicit
> they can optionally be plugged on TYPE_PLATFORM_BUS_DEVICE.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/i386/amd_iommu.c   | 2 --
>   hw/i386/intel_iommu.c | 2 --
>   hw/i386/x86-iommu.c   | 2 +-
>   3 files changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

