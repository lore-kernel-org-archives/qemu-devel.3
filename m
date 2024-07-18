Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2740C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 22:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUZrt-0004TM-N6; Thu, 18 Jul 2024 18:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZrs-0004OT-CL
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:44:56 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZrq-00064R-MW
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:44:56 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2cb682fb0cdso610087a91.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 15:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721342693; x=1721947493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EA6EujTI906FvtsCoXqYNqm/bvWYTbuguP/TbeabKJc=;
 b=ruLUN3IEmEMHZnB15ChKcfYPfHoqoT6Hgy1I4fujlC25G4BOOAmdAzszKbC/apGKQt
 Q27NRBVTNwU8caSftB7byXOL2hel+vTBDSfcKx9nHRocjPNe921N6UuYqhqq47i5CuhX
 o9Tz97thMeC2+lb1eEIzhSxlDu+5xfzeLInUMZeHr6hupLtqv/ng6VBXfnfKW4+rbbLW
 hh0NwTIV1NYy7TipZa4q1W6Vz03R7CqIqdhccU0Du3NrVDlOo3j3DmE5vclLV+6ROhXr
 OH+Jxnjcl2eN+1eAIrAd6zUgjkW2gDVg3OZ79fySDgD/dqOi0s40jdnE1nXYl8V3elgh
 LLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721342693; x=1721947493;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EA6EujTI906FvtsCoXqYNqm/bvWYTbuguP/TbeabKJc=;
 b=FineGttkBhjPuipBeeGcj7AOpL+bkN9zCZS38rbdNTbmzkqCQAIHd2V0oydiwQLv9J
 cC1vPfEuZyFIENhi4skkMfbU8MxHhtgXjJ9A/Wx4d6ePtjvdW9fKwObKBiLIlE01pxqQ
 9OZHS1O0Eu7y/7D7b6UwW1iZvkMwEgBnktlwwThuFWF0gi5Vc2LAtdKH2UZuVrfgjZvx
 hgK0r4y9lVS6sZ2+tjvLqb5HV1IShAQthr92IljAZvNZeTG/wXriYru78vXcSt5uuWZC
 Q2yGM1B5WmE90VRvas/jJr4lK2k/80+LiARaRd3f5x8zTr/huX1+R8FAwW/jRvOwdxXt
 WGwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJVHKK/yWQPIUkoCzDfWpOW0pjt9hY23wRiQxxfZFxoE4JXztYL7UtafCa3Y8bFltS3JZMN/LAPkMYf7pPBhq2ryr9gsQ=
X-Gm-Message-State: AOJu0YyjBiKt1R10xSL6TNlzFpykohk93xx46DuRDCo4BhlEXJV7K6Te
 1KkO+7YAvwQ99oFLoGibgUFJs5Y3victAkyXmBs84ihqgPyO2hxl0TZUzTfrH4Y=
X-Google-Smtp-Source: AGHT+IED5V5LSEeKJPFn2fOwQiC2VV931eWM8riDk8Q7OomnJU7Zu7EhAVP60/DkCRL62RWCEYaXnA==
X-Received: by 2002:a17:90a:1f44:b0:2c9:887e:46de with SMTP id
 98e67ed59e1d1-2cb524571edmr5241886a91.12.1721342693239; 
 Thu, 18 Jul 2024 15:44:53 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ccf7b2adafsm161535a91.2.2024.07.18.15.44.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 15:44:52 -0700 (PDT)
Message-ID: <5b754e14-74eb-40f3-b0c7-7ce8200000bf@linaro.org>
Date: Fri, 19 Jul 2024 08:44:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/18] hw/intc/loongson_ipi: Expose
 loongson_ipi_core_read/write helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240718083842.81199-1-philmd@linaro.org>
 <20240718083842.81199-14-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240718083842.81199-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
> In order to access loongson_ipi_core_read/write helpers
> from loongson_ipi_common.c in the next commit, make their
> prototype declaration public.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> [PMD: Extracted from bigger commit, added commit description]
> Co-Developed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Bibo Mao<maobibo@loongson.cn>
> Tested-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   include/hw/intc/loongson_ipi_common.h |  6 ++++++
>   hw/intc/loongson_ipi.c                | 10 ++++------
>   2 files changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

