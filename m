Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACE7C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 23:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJho3-0001tn-Ty; Tue, 18 Jun 2024 19:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJho1-0001rv-4Y
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 19:00:01 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhnz-00036m-KT
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 19:00:00 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-681bc7f50d0so226609a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718751598; x=1719356398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wi26rZNrh8+ZgF+KAM9nQ6VtWnXxeP2/C60XHe/Kmak=;
 b=gsXQqejmJ3xw0WsLhverbghr5daEqUltXb6Px0p6xWN+Ejf96xQru+QqzUCv3Gq5PD
 u4D0r98wbcUjTZFfzR17mht5CVXN+7D1tKc5jzey1kKFSIGqHK8Xmkn4/YV33uvGWrJE
 qO701YPcpTIq3yZNz13KhmPtKJfsHR24h7OJ57FETl7ZyNhoUXgv7msqvmx58KgALmcN
 4kjBEZLLuWdx7Y7S12paYAY4oOQlWOhfeullCo+h2yUA+zTQuXH8M+mIAoxj2h+m4iBi
 h3CrT7qlIoQGBoeevPHZGBFmwwbsDJUKSc3KSplEsOIRy1Ox4D29bvAMsrYdY/ziuDSG
 aNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718751598; x=1719356398;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wi26rZNrh8+ZgF+KAM9nQ6VtWnXxeP2/C60XHe/Kmak=;
 b=WDK8VPzM73qJG3jhON97Ok92Gm8WLczxI2ddKjG7wtnVyfaUwNGkW8NeWCRQQC4VSm
 E88ipvR4ZXLovT+EZQCgt2D6lecUE4Lb6D3MaEj/KHGGoH8gN9Tbj7TNgtmjAC+DUKU2
 MlP68jxqjxttNlnKbFDjYy1HSUgxh6GVK6pAIvJGsrdPkVnJSjWj24Qazwvr+9WOkk5j
 vK575mIC7Lym2MPQ3fNBz3HSjvrPCqv4S9w9tIIEaEI06lQj7jcIodUth8QZQrYe9+ZV
 CeYrI9w26+na/i9zWZIZchfYJPRGYxGAFRbvtKtU8lbZP95OE9VOCAPYizYHgk9zbuP4
 okJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvLTwOMeVN5T8A2P8JVUvi+VFMg8HbWHTfRRjfrKeJcMCJ01XvP141ktsaUZT1PVSAt39JG7Pn+N+cRDifpST4OgEZbnc=
X-Gm-Message-State: AOJu0YwwCQYdJCeO+EZCoa6335SE0FXn8ZnM1mcdVnHKzSmYOxYtKWsu
 GZkYmUJruu0YC732FoThvQYh9a8EjXkEB+R0UT3qz1OyzrS+QJWfKFg8aLqGMS8=
X-Google-Smtp-Source: AGHT+IH+e1utrXbFpJ3b2X5HSJHSwqv59pMtvd6mwezSUyTrxnaDrULHJoKn79fPFhNv4cWoyuXtYQ==
X-Received: by 2002:a17:90b:e89:b0:2c4:e033:5187 with SMTP id
 98e67ed59e1d1-2c7b3bdf2demr1393680a91.24.1718751598215; 
 Tue, 18 Jun 2024 15:59:58 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c7bcf2c838sm182517a91.44.2024.06.18.15.59.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 15:59:57 -0700 (PDT)
Message-ID: <f3c7ecce-4034-40b0-8aa7-6053ffdccf5e@linaro.org>
Date: Tue, 18 Jun 2024 15:59:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] exec: avoid using C++ keywords in function parameters
To: Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com
References: <20240618224553.878869-1-rkir@google.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240618224553.878869-1-rkir@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 6/18/24 15:45, Roman Kiryanov wrote:
> to use the QEMU headers with a C++ compiler.
> 
> Google-Bug-Id: 331190993
> Change-Id: Ic4e49b9c791616bb22c973922772b0494706092c
> Signed-off-by: Roman Kiryanov<rkir@google.com>
> ---
>   include/exec/memory.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

