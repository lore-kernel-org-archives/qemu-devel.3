Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1C1C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 21:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXTHX-0005y3-Cl; Tue, 06 Feb 2024 16:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXTHW-0005s1-2L
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:47:06 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXTHU-0007PJ-JK
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:47:05 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d93f2c3701so33769385ad.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 13:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707256023; x=1707860823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=415qHFYNEGh1hFe0iT8uX89EgN+vnOMnD6jFX4CySZg=;
 b=rsB19+2Nu4UrjrRJFgqE0KxIy4hYtt2HygfbnIhLBC9XjMC6kA2PyZklbDEJWcp+Us
 37cqY6KNTURArOr0cbXvnAm+4Qy0CrgoS2DcVBSye8242YdM9R5v9DrUeQG+orlGI0lo
 M8avv2qJTcVKVXxFKcmaMdTePa8xy1Fm420DV336JY+WEBdWU3YcoZmBOtFWHbtm3t+c
 lxciI0xC8qvyXO/5ZdTYtTT+jcf/6yo2G7s83wA5qDXR29Ee7SMwCpD21Ief9HNtKIig
 1QjBkfvD3xTpPuMkuQilVmFgzGQAlp9VFZfh/38vmrhqtWlaNBdIJlXVdj2h/K/H/thS
 XWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707256023; x=1707860823;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=415qHFYNEGh1hFe0iT8uX89EgN+vnOMnD6jFX4CySZg=;
 b=kuaAaB4UhMm3cznR0JEKTz1gvB6ARNzh5lXqBa5Khugf7tWJ1sgkCqE/4M39Z46GRg
 dMnyCIlai7FvWbpu0xcLn5Nv9N8rjl26X9DgjIzqHWoIrcZcYS8oIu9pekXUYq1yfzvg
 aPqvCvVFIwC/YqRZxg2hLxM7JafsCdFpOL0xy1mtHozC13zqZsDpvs6q2k72EK8a7VHz
 J5qhAwaqOdvb7G1yS1Rg3OHVfSZh0a+GPO8qIIxk8Yg1UuNUzGHTEI9rMkrgGb4oFU2P
 WxUllOLFovlIZ+tEcGms8CpjxeAfGyoF35X4XaMGnKlr8a5i5EkqQjoRR8m86ISmPULI
 HpLA==
X-Gm-Message-State: AOJu0YwqcrvA4njXAMGm6AkpD4dKSYN3OMlhKtmM+jg2uBu4EVdok+n6
 HgBR1+uLkiWWVd+suiffneLdJY2mfrnJ99K2nbZsiaS1TJv+EUsCwzO8yygA8tgC81DjUujst0Y
 wtD0=
X-Google-Smtp-Source: AGHT+IHhAZDsfzVPrNMUV/cUZQ9+dkKSpzn43/faRu4hxAs+/XAOu7Yd8V2phhlKOxLuKeZHxPG92g==
X-Received: by 2002:a17:902:c403:b0:1d9:6420:7867 with SMTP id
 k3-20020a170902c40300b001d964207867mr3655433plk.11.1707256023167; 
 Tue, 06 Feb 2024 13:47:03 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX7lnSLcram6eHu04XyVDVtd7iBnIipMppbnsTDtdw9BmhEE5l8oDo/7Q4Isos6fCfKS4lbI5eeyhzGeUKmzEel+hmLFDqhgorzGd2B+1AjLKGt07jFtSWz2+Q=
Received: from [192.168.0.100] ([43.252.112.200])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a170902ed8b00b001d940ae8ffasm2382196plj.6.2024.02.06.13.47.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 13:47:02 -0800 (PST)
Message-ID: <9d67ac5c-abf5-45af-be06-c75498b9ecbe@linaro.org>
Date: Wed, 7 Feb 2024 07:47:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] hw/misc/mps2-scc: Fix condition for CFG3 register
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240206132931.38376-6-peter.maydell@linaro.org>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2/6/24 23:29, Peter Maydell wrote:
> We currently guard the CFG3 register read with
>   (scc_partno(s) == 0x524 && scc_partno(s) == 0x547)
> which is clearly wrong as it is never true.
> 
> This register is present on all board types except AN524
> and AN527; correct the condition.
> 
> Fixes: 6ac80818941829c0 ("hw/misc/mps2-scc: Implement changes for AN547")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/misc/mps2-scc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

