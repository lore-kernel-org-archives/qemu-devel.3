Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D26BCED240
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 21:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxvB2-0005nx-IK; Mon, 07 Oct 2024 17:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxvAw-0005hU-P8
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:21:55 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxvAv-0001jr-FR
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:21:54 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7cd8803fe0aso3357761a12.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728336111; x=1728940911; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P8JAjpO8eNde/9AgguZ7yeqp77mIn8hCurGc5RPLjCw=;
 b=URSOVeLyFtuQvLYhDoqRW8c6llmDqaHUk++Ae5LUsgfQ978HIKmv2SOjbS6GQsOYfK
 16oNRF/9sgCjx05zJ4YlFOzfnyyBujltMHWxHCo8qMe7iL40eV41yaW1UWn8JcmSTovl
 fO4OTt9NJAv5nj/JvQk80ekCV0Vbkvm2V+v7Cboki2jY1yOfqnHi7V7yX9x0MCXNEuDo
 Za6u+GH8bEMBPnGqJrpXuS1UuDNyBvhdLRzq1x2j+ltgdeiiBytlj0g4LQy/YGWiYxrH
 oK7+ShMC+A51sqclCn6sHDzo/jciu98sZHykf5qTQGQoWrllYvUxrphvBft7snT5pmp/
 52Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728336111; x=1728940911;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P8JAjpO8eNde/9AgguZ7yeqp77mIn8hCurGc5RPLjCw=;
 b=c4nGAU7n70Bx5jiPyVk/yMVM4H74dNkKbMwTpZ9S+eF0paiOTQ/VDKt0lbjzxipF7G
 aMHeSdop6Pm5L1l15C0dggtb9j+hdOIuCH/nbfrByiJ2/iJKTDRxaw7m55nuBoxK4zR/
 EgoQ3QijOCn4dqkTdkFBXbDojxUBbfCyuDlhQAax+GlWW0CgJYbz8P6wvxbdE+wv3nTf
 Iyb6UKFjiXDg25X+y0GBHv0sLQOplqBDMbm30RpnR9dBrqxinnbOFidYRdXzPVm6Ma0p
 OGSTaPAOwiIz3CIRnFQzgqwYJJDUBWqR/OurQeCS5lAqJIwiIWS29GS0j0BefbdiZGzr
 9ItA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeVIUyvXEObBNl+XebMEwKHH3fAGYxxR1upaWZ9dhuEeac7bjNbuiUXZMt6Al36YQlV2cEXo40+GCg@nongnu.org
X-Gm-Message-State: AOJu0YxATdNURFStVdk/Znv2OmKl4HQFNc4/uxUihpyOpPwvKrjwHQ2o
 XRwZvVoN1Ohb4c8o7JmwzTfdgmvfBzZZNP4VPPtgX2PoSxj/Rwswcmm/izzSjGP3XAwWlPPQCT4
 Y
X-Google-Smtp-Source: AGHT+IE7UmUIJiV7Ff/gmSwqOwx7Ayu2TtlDU9/HAF8l9GK45IXC9sM/RYIEv2bsEy1ykPT3Tx8ZkQ==
X-Received: by 2002:a05:6a20:b58b:b0:1cf:6533:5c86 with SMTP id
 adf61e73a8af0-1d6dfa40a0fmr17450432637.21.1728336111574; 
 Mon, 07 Oct 2024 14:21:51 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d4538bsm4857433b3a.104.2024.10.07.14.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 14:21:51 -0700 (PDT)
Message-ID: <5b98abbc-8d87-4e99-90d8-9600bd5107cb@linaro.org>
Date: Mon, 7 Oct 2024 18:21:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/20] target/arm: Pass MemOp to get_phys_addr_gpc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
References: <20241005152551.307923-1-richard.henderson@linaro.org>
 <20241005152551.307923-16-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241005152551.307923-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/10/24 12:25, Richard Henderson wrote:
> Zero is the safe do-nothing value for callers to use.
> Pass the value through from get_phys_addr.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/ptw.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


