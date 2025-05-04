Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D1EC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 16:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBbvu-00021x-V7; Sun, 04 May 2025 12:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBbvr-0001yU-Dg
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:11:11 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBbvo-0005nx-ED
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:11:10 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-227d6b530d8so32574235ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 09:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746375067; x=1746979867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mg5H46AAeuqeTMZmfCyrih9/4ePsSGqG0Yc0d6h12cM=;
 b=AfTNYOQESQjSeRq9Pr5v9iOEEsaHQXbiOafOADU1msQGvWq6Q0zvNxN61iKdvdjZCW
 kEVZVKVsV9jb2oZjOPQbT1fXMu+J5B+i+4nwapzmI50+3B7qMOpaLU05fxdrL47J62kS
 jIKR0kGt3Q/7b+fwDq5JVLHFYTc/tmCHAptLiXqGWTuhlaNd30/N1XFqR8uhJ89KHhTq
 X2fBmSMkDZiP9foXpy2RR+W+/De3Hgh74Bid/w7MYWEUUt/k1Q8TAJ6zuGsMyOTEHpIx
 lJVAz+adNVdgxQC2OKKupVsi7H5BY/85Y1VVuWs9KQPg2nr5vrwLiBYRNCf9fgOYiLr4
 Cx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746375067; x=1746979867;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mg5H46AAeuqeTMZmfCyrih9/4ePsSGqG0Yc0d6h12cM=;
 b=LIG/xUqM8q+2GwHEoaxUVs3KxWCmtiGBmVylAAqz4IWFz5hG0r7GL8/Uq+fPqQ/Fm0
 7ykGKSVzGQy1tsLZCUj00gRdR+R3AQRo93xX3h2p0ZqMvH8t/smuUopu71+GljtfQuyK
 LzhGisDEjAujDNh5KExtXu/BxAppAVNOls7wXS4ob0u3Yb/dWkKPkbLot5MUEvc0qBaH
 Fq1a4+HpmZT8ZXZfRKje2Qq5WF/vfNaL4/0ZEgLily3zPv8xpMCAvHfzs7Ez33r7nda2
 YO1bkxEGaobWOkD9TBXW+8WjI3oDZbQUXD94j0TeDG7cb9K2Ko28/2P3kPpYCRCaTqwe
 jPvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHYzGem9C/nDJK9dqfK4cxQ5VFSsogq5Fs+RlZpF2+7DKE4VlrR+sh9f2JsEYPP8bXS5ug3/Bsjkj6@nongnu.org
X-Gm-Message-State: AOJu0YyHMLL2qZoEtBmQPAASdF3nlV2ZN4lL4fDlqTdTA4nISjn/NkOz
 PDM0CUJQxSpfMrmns5ywQ/rsegFcuvX4KkNL0GKQk+XMUX/10h0fnGL5F4zyiSg=
X-Gm-Gg: ASbGnctsQ4Lx2geL1COJfoTa7v0JKnPESyKohzqbi3G7aL2xOqhIHUP8YE94McTN9dh
 wqbNIPCwQsd0EKdBJQLVzipf8b1de1mTFWuyD8wQKVLrSqf/KCI0iheFaIEVDSAxyWlZH3fcbkw
 PhtMe61IlDdAyQxG1t6qIHFZB8Tl6LVMuUAI/6e5XNc9u6/mTh87RYEJjdeezPpFI3YGdDRdMlr
 Yv2W8JYD9os6C5BkqmIMtVzgO4cllodgz1qlbp7fAp9C+RcWw8O1gHmf7yHctOMOfWZGkoWt+8C
 BUFe4xBekiNIfRegoeqWd8/Y79Z2tbnWVuf44QIAZ72fmscy7+RA7ESh6M4mq9jNnGHhLjt991s
 9fljeq2o=
X-Google-Smtp-Source: AGHT+IFuPHwThnZ7gM50lbIZGvWCd/owSisb1zYGcYT/GUvXIiYYxIG9Y0DQtl31DC2c3pM+nqyqRw==
X-Received: by 2002:a17:903:120f:b0:220:eade:d77e with SMTP id
 d9443c01a7336-22e103559d3mr163818725ad.40.1746375066754; 
 Sun, 04 May 2025 09:11:06 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e152291eesm39090825ad.192.2025.05.04.09.11.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 09:11:06 -0700 (PDT)
Message-ID: <3d8b8f31-4986-4734-aad9-f73d01c735c7@linaro.org>
Date: Sun, 4 May 2025 09:11:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/40] target/arm/helper: use vaddr instead of
 target_ulong for exception_pc_alignment
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
 <20250504052914.3525365-16-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250504052914.3525365-16-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 5/3/25 22:28, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/helper.h            | 2 +-
>   target/arm/tcg/tlb_helper.c    | 2 +-
>   target/arm/tcg/translate-a64.c | 2 +-
>   target/arm/tcg/translate.c     | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

