Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14725C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 23:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se0jZ-00028j-2J; Tue, 13 Aug 2024 19:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se0jX-00022x-Kg
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:15:19 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se0jS-0005Gf-1K
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:15:19 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fd640a6454so46663835ad.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 16:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723590912; x=1724195712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4NWfPsrwSsLRxXJXsWvF+4JuVroDP4Yn/u9U1cX/tvo=;
 b=HewjQmqV6z/VysmUcvlhib5Exw0QLLZIowvk6NmyguSlv57QRzTWX0ehmkyGZBtVnz
 98bQgKRfgQAZq9oxp8jLmn6uABb0LRw36Oarfmrq4gpYB2YEym96gD460lJaNModhmrE
 9R7/BYHGJ/Hzr3/e0ZBNghqgadE14xH7d2KL/Qd3KEtHfZkRF0DevYCxTHa2s1sOCKrX
 91CnroOGP4QEXPbl4ctiWQoYcNzQqm4KVwzteIO+2vsOlCoCJMF34/s3WsqnFLU+7FRL
 FFqlfj6aA6cbVCLdraAALXwcwC3On2kZyc26UwVFy4m3hCI6JK0OnMjOUHmDesP2WxhE
 Jj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723590912; x=1724195712;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4NWfPsrwSsLRxXJXsWvF+4JuVroDP4Yn/u9U1cX/tvo=;
 b=LagghSdQgreH6RLv5n8VX4lTr5JTxzaAHBbYvADgAy8bYtdVBBbVUCICEqQJtMc3eT
 n+lnaudvT4a+V6Z7RMnizPPuMimG8rPtSWmNHbk5UG0PEA/7qz/xLrgEGxZKabQM5ETx
 PRvPHfdcO6BvBWoTQ4IWNcauLURyuK7/25mz4EbWu8FVkEPtI+DSz4GukvLwk79WDHDK
 XqulY55us4vseodQmNje6fkBVY7UwevhzTy24gzkJfpKG3FuyHyKGrBUYw+3DcmzTMW7
 qaD2rV20NxkW6JgrmLCSPxDX+K6/fDp+2S49m/4KX24G/iOhjY/tb/o6x3R4Tg24AMgW
 8J4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXREq3q0UY/I22rqY4b22TvVpptYlx1Cw9iyvOdTzpkhlFvngxnCx6pEZ4yi5nGS4jSc9DPvksnQ8Sw0rMkn8+YD6+y+IQ=
X-Gm-Message-State: AOJu0Ywqo1pOEvyCP5q9aSYDKmTy7cJ9Lo5SBzapoPdBsoMu+M7o1x2U
 ZAbAg8KMNFgmNXO1uEbYWqp9sBidfuoE4eyTySHxkyMFvXryPbfbzPZ8+BVBAQ0=
X-Google-Smtp-Source: AGHT+IGA/Hw8qYpWyieWP4VPoC4tyCvHHBJfzNZhSm+CKj+WWZa1ewTo5ZtuY7AcWukFx55Y3Er6eg==
X-Received: by 2002:a17:903:1108:b0:1fb:7435:c2cc with SMTP id
 d9443c01a7336-201d648ce04mr14897085ad.45.1723590912344; 
 Tue, 13 Aug 2024 16:15:12 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1bd7dfsm18645055ad.232.2024.08.13.16.15.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 16:15:11 -0700 (PDT)
Message-ID: <72fd781e-c8c7-4086-8667-1f70b53822ad@linaro.org>
Date: Wed, 14 Aug 2024 09:15:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 09/10] hw: Rename DeviceClass::reset field to
 legacy_reset
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-10-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813165250.2717650-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 8/14/24 02:52, Peter Maydell wrote:
> Rename theDeviceClass::reset field to legacy_reset; this is helpful
> both in flagging up that it's best not used in new code and in
> making it easy to search for where it's being used still.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/hw/qdev-core.h | 4 ++--
>   hw/core/qdev.c         | 8 ++++----
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

