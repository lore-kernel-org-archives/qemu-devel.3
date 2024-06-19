Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F3AC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 02:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJlFf-0008O9-EL; Tue, 18 Jun 2024 22:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJlFd-0008NX-K0
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 22:40:45 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJlFc-0004lK-3K
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 22:40:45 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5c19d338401so819612eaf.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 19:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718764842; x=1719369642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/1Hnq8xFabbTZezXjqEYEABUKtAYTe9eYkbzuVrdfvY=;
 b=LUuAdka76UBD8QQ0NSPVolDBT7AHHmWTfGFIeWEBoSbAI+1hBSTH3YzLOqnRATnbVb
 7wrl1NevguoFtDIPhedjllYHTbM/Kh45h+VnYHIZC5fl4mLLF2Pz4tP1tn6WNlbxb3nC
 jc86KHp91kxYEQZsOqghdk4ZGKz88bGQDh0HkxYEwthywCAZnujLhnvVsKote82tQfCd
 19GU2aHmcmINeDaW8cttgCS0AQJrEbuZEwwf73tSW0bFGLXusVdEdY/6wJG266FZXKgF
 LXmWp5g+WcZlqXDjm/DtIrZJCy+K1QCIjiIZkjdpecyq9cl5+RAwR299cbpU1pkdhnl6
 KjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718764842; x=1719369642;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/1Hnq8xFabbTZezXjqEYEABUKtAYTe9eYkbzuVrdfvY=;
 b=nHnalsDFMA5on95qiDwP8EGFoUPgaoOsm7eo+s7RsQtHODucpKDxUyI4bulnFgXaFC
 giixyJlbQMPaT/PlokDOSLZ28MSqoqybvzmsfmkdojwTQTTN6UjRT7W814iYvfgaKFWp
 fObA2UxmpyEiXT6lTCr3/k3e1iZfaM1Ii1iCoGlOnFTS9Sf+jBE9w5TdiQSWp4cbAiRo
 6P2vCnDoLXHhf2wIKB+l39wPWCcvk5YdStw3Vpgm1L/lWfVMkcQT7ecMbLrci8ld+rOn
 FQbxtW3PhySlnPItvWMPA08ez1No0vJkonar3i0BB8zZnBRlXEjP3YWkrLxRfd/Ssb/7
 ND/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS5ppAe+/3BbmOCUoSchBaDRZRl7CMv8S7S13Jh4jnnw5ySo159Wf9aRQSjvhj/ehvHU0o976H4/pVWxcyloOGufr+xV8=
X-Gm-Message-State: AOJu0YyujQWRHyOpZ5jnoKUbfCp6XZ/2PM/JOs3cEWkLzLCrhQxqvbrt
 r9hQ0qcBjTpUxkS8rYD9fiKSqvKnZprIJ5kCQyVgVys0wuvqTTwezVQWW3s3MJw=
X-Google-Smtp-Source: AGHT+IEAMrhMqiU4vSuCABx6q8058dzhFiW6aPdqlCniT7rDZJ4GhRaVw04KmTTcPCOqPcmNI8WGKQ==
X-Received: by 2002:a05:6358:b01a:b0:1a1:bbe5:5d4f with SMTP id
 e5c5f4694b2df-1a1fd656caamr141717455d.30.1718764842257; 
 Tue, 18 Jun 2024 19:40:42 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6fedd21591csm8563966a12.14.2024.06.18.19.40.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 19:40:41 -0700 (PDT)
Message-ID: <da5c118f-cd5e-4ada-9de6-a793a0f6dfa0@linaro.org>
Date: Tue, 18 Jun 2024 19:40:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] exec: use char* for pointer arithmetic
To: Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com
References: <20240619000450.893463-1-rkir@google.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240619000450.893463-1-rkir@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

On 6/18/24 17:04, Roman Kiryanov wrote:
> void* pointer arithmetic is not in the
> C standard. This change allows using
> the QEMU headers with a C++ compiler.
> 
> Google-Bug-Id: 331190993
> Change-Id: I5a064853429f627c17a9213910811dea4ced6174
> Signed-off-by: Roman Kiryanov<rkir@google.com>
> ---
> v2: change `char*` into `char *` (add the missing space).
> 
>   include/exec/memory.h                 |  8 ++++----
>   include/exec/memory_ldst_cached.h.inc | 12 ++++++------
>   2 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

