Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA2EC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 04:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJQRj-0001Dw-Ey; Tue, 18 Jun 2024 00:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJQRh-00018F-EE
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:27:49 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJQRe-0006i3-Tl
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:27:48 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3d23a0a32afso2766449b6e.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 21:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718684865; x=1719289665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rcBcHMkhXEYvnw3jZQ9X+QheEtYAHhRxrSY2kNhE8kY=;
 b=rxLq1tJMQdZngdzKFPiWIxQodu+fNt6KGb8kWqIqrgj1NqsPNQeQ4ho/zJii/IPGZE
 hUa5Zd/ibtk3kt9LE8e/TGZP2CtjM9otcOMaOn0ATvkYft/IVb+BRSauRlu2RrUjOKu0
 44MM5Q73Giu5TGamA25+1c2lNGk9vFMh8QU06F3F3Be0I+BBRzvO+jLlBc9Y0NFXMSTF
 oVwd/nRTBcYsGJOQoItfv+/V8uiLfLlQuf5S1zwRRiSqGSxPL0R0iPqRi9v2Ojydi6ZT
 ZoA/rS67ZnScdgl8CYlaERJhPZoBnzO2kvYN5FBE6dKXne2QWSbbHWO6oBKZeCKwpksh
 /uXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718684865; x=1719289665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rcBcHMkhXEYvnw3jZQ9X+QheEtYAHhRxrSY2kNhE8kY=;
 b=nqWGRX8jFDeMY0cGM0RAx86XBpjV+FAI9tOhext1/iGisAsZ5SVbYEKYarrtDWwliK
 zhIxEKUVzU0QenVhzJLp8/JvlVh0UaVJoV75adXsg5fEGnCwOfaPMKnb0h9rtphhF7eb
 u+O/1OTkWqyX0EzwWRFYuXBPGST5uQjmTSXiBkuxxeM3jtxhuvRTEkf274eRWn2jlMTf
 35j4IzPG/c1juOv4kG6X0YfgS37rO03OA+1bn9rUmX9qdpwohzHCHR3hK0oCt6lCIA8D
 PUqD8otiBvDiTp3l3zzSmb8/6EHBblQUEXWL5s8hTnLsLiaqto5GbWcsgesA91Drrhl6
 yygQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9S8687xBMb4/GE5o/r9nEv1isnDnpW53ZZe/TNzZo2JsI939GWXtE6q93bFO9tExTjbbaW7iY9gEVdYGqFIZDJJW2o8Y=
X-Gm-Message-State: AOJu0YyQJZYQCOHF0tCj6YG2S+bmC0Irl3qIjj4ksTNT1DTZU1rRUED4
 18u1XCcrv23A9LB4EV9c7dzF5DCnppHTddbEi9TzkFgm7VoFH/nO6KKBvgGxvDPeDzjqtSeeIk2
 C
X-Google-Smtp-Source: AGHT+IHyA1MCzj47Ma/1VosDAjy6P9uVp3HXhcXztwcYyToEBem0w7iwy8xWyrWd1AYOkHfPRCXzVg==
X-Received: by 2002:a05:6808:2211:b0:3d2:2414:85e with SMTP id
 5614622812f47-3d24e8ac949mr14398710b6e.9.1718684865443; 
 Mon, 17 Jun 2024 21:27:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb6adb5sm8138828b3a.155.2024.06.17.21.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 21:27:45 -0700 (PDT)
Message-ID: <bc336724-bb7f-400d-8caf-8259f73af4fe@linaro.org>
Date: Mon, 17 Jun 2024 21:27:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/23] Added function to clone CPU state
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-4-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-4-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 6/17/24 11:57, Ajeet Singh wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Function can copy cpu state to create new thread
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> ---
>   bsd-user/aarch64/target_arch_cpu.h | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

