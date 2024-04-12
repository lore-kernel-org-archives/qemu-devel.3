Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3424CC04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 10:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvEc6-0004EV-38; Fri, 12 Apr 2024 06:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvEc4-0004BM-45
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:58:32 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvEc2-0002yT-76
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:58:31 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d8b2389e73so7503861fa.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 03:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712919508; x=1713524308; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oSgP4HC4E44YHf/cX/3LF7eSjyfD3deAkIq/n6TQfSM=;
 b=iwOIqTpdDwGJUJcMpQET0ut8D6Es/ewxT42Lsz+xi2dH+Bc72os2C1N0bXg5lGlJMs
 HFYLBbJSzCHwn/5MMd96tmMioZYm5Wzn+BxqKms3X76TB+MPb5HdlFZeWkjlJL/ntyl1
 Je/Wv7qltdCy3yfyHmHy6pMHk+MgRfWLZsbpd8Ycuy/lc7sINgLuBYmut0ZZ4GGf38sR
 JgjPmZS6xaOnNt2XNCEceML0Aba1CZrweS6GZuaauyj81hdLXAdgQNQWXKBqba4Z+fMz
 201fDlBKosnJR/qu+aFaDy+0JG+ISJnf4H/jpD+BTD72eGhNF7URBx2A1/bMAEelzpF5
 1KDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712919508; x=1713524308;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oSgP4HC4E44YHf/cX/3LF7eSjyfD3deAkIq/n6TQfSM=;
 b=sNjkyOPaYuR+httPCZJ3RCpqtavymLVql4M3oNE2PMOpW6VeWg+mcot9qyKCmc2idR
 FcueHTNUvXbO1RUoE14Z0yKvUhbNvFMpTFy/6CjmB9pnmtSNn36nn4aZ60avvXBkc87N
 egUl5EIynddNBTsCBpBzAcdcHLMlM6qptkzkGXa2Qvwt/392DkcVW8jGoHTPrCsgGTnm
 eKD9Qy7gfZCL0fNctr93YV815ZEojMOueymDMKN/6AjZpMLKZzxZE6ZmUHdgm6k4M0u5
 x5tc35xgV9MQbITpHWvyeG2uWed6Q7SClW1UToEr21oehIKo+9OU6rw+pREWZX4NjopX
 /wxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqRRa5Nm5r9E5Bjrbf7Q+abA7vzD2h0Iv19jYlL6Fdd2VHPWIOi8G7TEehyvFXCVJmZAYBLi8bD773430a+hovX5Fe0tU=
X-Gm-Message-State: AOJu0Yw40WZD+9tfEX9HPMh+UW8Hm3/RXFuQr8Y/SuDMdGMPOALWc0td
 0GgQ2Iuo2gaO5uIWzH4uekUznqYe34QtUbSMcwxboYPy9dWbfAWmHYhEkZe+8kg=
X-Google-Smtp-Source: AGHT+IGrIuf9YhcC7tdzCEJBgTNEH15VP+enWzcmcQsP6ev87RYTpMubxNI4y3UhjmmoCYJWNBxmkg==
X-Received: by 2002:a2e:be8b:0:b0:2d8:4158:fa64 with SMTP id
 a11-20020a2ebe8b000000b002d84158fa64mr1726952ljr.35.1712919507545; 
 Fri, 12 Apr 2024 03:58:27 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 jg24-20020a05600ca01800b00417ccfd5ee1sm5292990wmb.29.2024.04.12.03.58.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 03:58:27 -0700 (PDT)
Message-ID: <897eeeb8-d97e-4309-83df-d2828916b5be@linaro.org>
Date: Fri, 12 Apr 2024 12:58:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/27] hw/net/rocker: Replace sprintf() by snprintf()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-25-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412073346.458116-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

On 12/4/24 09:33, Richard Henderson wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience. Use snprintf() instead.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-Id: <20240411104340.6617-7-philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/net/rocker/rocker.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)


>           switch (offset) {
>           case ROCKER_DMA_DESC_ADDR_OFFSET:
> -            sprintf(buf, "Ring[%s] ADDR", ring_name);
> +            snprintf(buf, sizeofbuf), "Ring[%s] ADDR", ring_name);

Ideally we should convert the DEBUG_FOO guards to trace events,
to avoid to maintain dead code.

