Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AADDC3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 15:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRZhB-0006QV-BQ; Wed, 10 Jul 2024 11:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRZh8-0006Eg-Dd
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:57:26 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRZh6-000628-NB
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:57:26 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-75c5bdab7faso3583322a12.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 08:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720627043; x=1721231843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=23AWD9dpEkddx+eo2Q6j8rjbwacngLnBtXcRsy+AZDI=;
 b=yzxFPujTd6ti3f9f7EI8QayQEV7O2x7M8Q1NRBT7HQfq6Tnyb0BQ/F5prcLGe1ylXf
 gPiC9eQsnuVQ/+RqtcdBA/c1YVrbjSMGDYmHMnnyxqKdC0hPJssu5KsOv63Bcwh/rxm0
 Qvg7RO7/Yv5pXkT2v4rPiKoDAxrS+Q9tHAwBocENh/XctVeixub+rivv1SZFjfLwzLex
 WgoLafdK+x4VfB/3uGN8okHDImABhF6IROtEfg/t2yjkxb132ZMgQvBTkBzVpOQGvZL4
 1RY8gdlRgycEradmCoIfBBmBV+ArJcox4KXup9m7yGbqeL7cBBYLRzAUi67PllOdc5Z4
 yr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720627043; x=1721231843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=23AWD9dpEkddx+eo2Q6j8rjbwacngLnBtXcRsy+AZDI=;
 b=dchl7XUwPX/qznghP6V0Q923+DH4BYZyzf3DZUTg5y4SwWktJ56K1z8On3Ci9hICB8
 ijgDYTWAPnR/1kSXxN+UrFZrCv9L3TfkTtfubmr+n8c6L70OulJZSTzAAJsnq/DUpdl3
 mrR8zZVwedt5qeOBZOUCGQJUv08OIjnJdEojmYPZGHM0CkL+j9KI1s5Ovzm0ujtWsEwq
 dU6A3EGYBQbktMbuAB1psTL4ymDnLsvxzI92rauzpTHu8JYXMQme/i6lerSv2AS2+kdY
 F2ZOapgXj3TuQ8BkU/cWhBdOw8NGwfQuZBcVP7KkcBtWFGBit9KaYf520ctpGjFHOMQn
 nD3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcsgOUsScje7BUSjXDyrnH4TtCK/eZ23w7dfWEiPaXt1WGuFIHsG/KPrwgIjYVLfj8B8nI67uZgmgrnhSRd/GS34J+pC4=
X-Gm-Message-State: AOJu0Yx99BDWHODg4+wAYgUIOzFfMSFAOARJHJjY01CidoudhlCenoGC
 uoLnpb9QxYcDJZGuNwr4T+C8+GgiTQW+1wBFzvPRc3K194IExmN0B9Mhz5Zcf2k=
X-Google-Smtp-Source: AGHT+IEk193aBYoZxHSHuK1bot1dUBIZT2ZxdEX6HGvv1VLM+UjLD39CG6gbMeoX6JaETUemCrKwNw==
X-Received: by 2002:a05:6a21:789f:b0:1c2:8b95:de15 with SMTP id
 adf61e73a8af0-1c2984e11c1mr7200930637.53.1720627043108; 
 Wed, 10 Jul 2024 08:57:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438bfa94sm3958461b3a.50.2024.07.10.08.57.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 08:57:22 -0700 (PDT)
Message-ID: <77dbe97a-01a2-4db9-8939-6d0976c69764@linaro.org>
Date: Wed, 10 Jul 2024 08:57:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] target/i386/tcg: Use DPL-level accesses for
 interrupts and call gates
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: rrh.henry@gmail.com
References: <20240710062920.73063-1-pbonzini@redhat.com>
 <20240710062920.73063-8-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240710062920.73063-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 7/9/24 23:29, Paolo Bonzini wrote:
> This fixes a bug wherein i386/tcg assumed an interrupt return using
> the CALL or JMP instructions were always going from kernel or user mode to
> kernel mode, when using a call gate. This assumption is violated if
> the call gate has a DPL that is greater than 0.
> 
> In addition, the stack accesses should count as explicit, not implicit
> ("kernel" in QEMU code), so that SMAP is not applied if DPL=3.
> 
> Analyzed-by: Robert R. Henry<rrh.henry@gmail.com>
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/249
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/seg_helper.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

