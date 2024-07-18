Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A745AC3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 22:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUZof-0006tH-RL; Thu, 18 Jul 2024 18:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZoc-0006lg-Os
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:41:34 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZoa-0005YP-IC
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:41:33 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so892740a12.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 15:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721342491; x=1721947291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ccdlkr4r1NfYd4/QDpTYyOHSdZ//iz1VzMGjRCQcO44=;
 b=a7/MNk+tOYjD9kXy94voAf4gn2A+mN15zHKh0EGOfhLynkq0gPJtsQ/AhAkRJYxKQu
 xNLcv01wPzqyz4g4SiIq0+HXpKC/RN2Bv8kRzwNhtHD/fgk2YN+DymTNK3d43ztxqRJ9
 W52pXSD+h9fAo6lYhwnMZW8rVB6JyQ4c+2N8eJA46MD23bgnJe0Ht+GW5Lbw+NooBdKg
 OTP/yeabjY8RWgGWT/fTzGb/BoFziEj0WTM/g90a9OoP7JJhLgoYyLRYe0RYOEja/MiR
 ZajWM57Yfwchflu21msM6AdRb00aAJtoVvu0iW8KoN+LIRNL19Q0azbZVmflAIyUX77p
 0Jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721342491; x=1721947291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ccdlkr4r1NfYd4/QDpTYyOHSdZ//iz1VzMGjRCQcO44=;
 b=SHQG6Fz/SlMxNxqmuPx+zhrmXH/5j5dMJkdiRaknOwRoyv094wTEQXzV6kajrKCyA4
 60NdvfZ1D6VflLTfp9V5M1YbHJ927MgkPxTDJdPd/T0eYgK2a59k2QoUJfxwB/LCl8jC
 2SsUN8K88A1L2NSu9gXpRIV/KqC9KBnqUkfPfYESzqEAMv/HGZGm5d2IgOkMNfkioYht
 yxhc46CoGzcu4J9utXXvAHViiTwnjSFYSWcmlavTT4XNOMRchOkSgw+uEZ4jXLqpL40J
 /DOJIT3zZFBQIycZTilOGpRzqExvA2nWw2yJBPwNUeVHntqnugKA6swvkes5yHadD6UU
 bwHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6eCOTY+Y8XBWVDK5VrHfD/GgZddmyoiHXoTodxtu/skoEqCmo0HfNIJs6rB1kkfiG3+ZffTmgr8k6HxNxIxUFrcMpqfc=
X-Gm-Message-State: AOJu0YzFYI8FVV2o4fAN1zPHmwnJkuay2bd3zeH+uFRK45iBDY8P7VN/
 rpGXTN5j3vkVV4rzKNlVXErOvAoTb+JkMPxoSFXVzplXH7xhPIYvOCkJGONVsss=
X-Google-Smtp-Source: AGHT+IHaMLHUSGaaTCUPSllWj8CC/zZ/YOVSDCVrMZQROmLB25hM5dpZmJgl/Qxdz2mU2AwDi/LmYg==
X-Received: by 2002:a05:6a20:918c:b0:1c0:e322:e8c5 with SMTP id
 adf61e73a8af0-1c3fdcfcdd2mr7438947637.26.1721342490866; 
 Thu, 18 Jul 2024 15:41:30 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ccf7b2cff5sm159728a91.12.2024.07.18.15.41.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 15:41:30 -0700 (PDT)
Message-ID: <58f3ebdd-1fb1-408a-846d-f037f0641456@linaro.org>
Date: Fri, 19 Jul 2024 08:41:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/18] hw/intc/loongson_ipi: Move IPICore structure to
 loongson_ipi_common.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240718083842.81199-1-philmd@linaro.org>
 <20240718083842.81199-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240718083842.81199-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
> Move the IPICore structure and corresponding common fields
> of LoongsonIPICommonState to "hw/intc/loongson_ipi_common.h".
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> [PMD: Extracted from bigger commit, added commit description]
> Co-Developed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Bibo Mao<maobibo@loongson.cn>
> Tested-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   include/hw/intc/loongson_ipi.h        | 17 --------
>   include/hw/intc/loongson_ipi_common.h | 18 +++++++++
>   hw/intc/loongson_ipi.c                | 56 +++++----------------------
>   hw/intc/loongson_ipi_common.c         | 50 ++++++++++++++++++++++++
>   4 files changed, 77 insertions(+), 64 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

