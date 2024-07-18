Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A221FC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 22:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUZjq-0002xZ-Tl; Thu, 18 Jul 2024 18:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZjp-0002x5-GE
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:36:37 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZjn-0003y6-US
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:36:37 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fc6a017abdso7516695ad.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 15:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721342194; x=1721946994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qf1WbBFc4eOnItdIjiDb3cgpQAswGxsWLLLNlVXLH28=;
 b=ATsP4plFokHZwZbwciR2poowb7gXNLtZBs4SzhI4r6TH3JqOh/K/VOiTUaPn8sWoC6
 Xbdu6ZEpaW9JjfetBWX3ZGHrQ1TYArRtanhHnCzteBerq/k2ShxTmjZkT9+FDolVJDAN
 5Cxp/NT8jY6JxsdNI9uFyzh68x6qHr9+V5IFnICQ9defmApw3k7tM1cM0i5P7LHs9Q/f
 rLoGaUO2MUlauQbF7YxeizN0LRcZdNGUFegBNC1sD83dz/fDBfMNP6C15jYDe/idhOXW
 h7Jb39uXU+7EVAY7kaCJPQXHNV88M3MM0VpxAEZr7G/+CXkvYiZPtrG2GbGTQwIm2oS3
 f9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721342194; x=1721946994;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qf1WbBFc4eOnItdIjiDb3cgpQAswGxsWLLLNlVXLH28=;
 b=oNRtvJ86SVhKipeCmE2UIXOFvz+RAzazqGTNXqMJLHUJS3HqQw4V5VWCB3rFom682l
 kQrkqqD5j2N9GuhIX1OSKIgRMfgVJ971DM//lKSRwzXzRTGl6wLAAO+G8OQJie3t1cID
 /T1ERme0/4zHe9tMSJlcgoFiUBP0CeNADoGgKmWYzgLSMArV0Zq/5MosSh5Bb74BoW4Y
 rVsFmLOTIwtxhtE+1KMCwWdLCApfJ0YqOyxU+z6m76Hejb4c57U7oyZmRp016Z87tij+
 YdVi4IhhIBrilDpJXeDW/TSGJUos99OeJ0wBJs3H3bdbjhjcp7uIGvqRKbJUMJIwWx0E
 FqTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa9kZ2c4IeZGrrE7cV1CBSayrY0zbxamDjQXi30BN0BjYdnlKl9OJr8uHVb5XRND8qr24mPjNWpmZtQ4kx9Yqot6sIWE0=
X-Gm-Message-State: AOJu0YzB39yHYWjtAB0ARjHIsCCj0XQLFmNT13+4JuJ5QqxDv3KS4D4x
 sqQBQqlRtHQlhskbLiAA85+lYmsTrml7YymBiNBZXh9F5jeqlTCl4SLNmDTWcvI=
X-Google-Smtp-Source: AGHT+IHw0P2L2RwMmWdhKEZIda+Ae/V9sXZ/NgWEx6erf76DfJOPUMP6b8z3W++mRxnGUg4BYGslDg==
X-Received: by 2002:a17:903:32c1:b0:1fc:3600:5ce7 with SMTP id
 d9443c01a7336-1fc4e134b59mr60055805ad.17.1721342193807; 
 Thu, 18 Jul 2024 15:36:33 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd64d207c5sm804405ad.222.2024.07.18.15.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 15:36:33 -0700 (PDT)
Message-ID: <adb94029-20b5-4acf-b969-db97261c8b06@linaro.org>
Date: Fri, 19 Jul 2024 08:36:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/18] hw/intc/loongson_ipi: Rename LoongsonIPI ->
 LoongsonIPIState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240718083842.81199-1-philmd@linaro.org>
 <20240718083842.81199-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240718083842.81199-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/18/24 18:38, Philippe Mathieu-Daudé wrote:
> From: Bibo Mao<maobibo@loongson.cn>
> 
> We'll have to add LoongsonIPIClass in few commits,
> so rename LoongsonIPI as LoongsonIPIState for clarity.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> [PMD: Extracted from bigger commit, added commit description]
> Co-Developed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Bibo Mao<maobibo@loongson.cn>
> Tested-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   include/hw/intc/loongson_ipi.h |  6 +++---
>   hw/intc/loongson_ipi.c         | 16 ++++++++--------
>   2 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

