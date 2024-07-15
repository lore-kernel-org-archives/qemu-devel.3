Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81ED1C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 22:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTUZz-0006m0-NQ; Mon, 15 Jul 2024 18:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTUZy-0006lU-WF
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 18:53:59 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTUZx-00057n-FO
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 18:53:58 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fb457b53c8so39774775ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 15:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721084036; x=1721688836; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=snshB3rHt641KR7d9p5KM99A7aw5L+Ac2R2zhxVve9c=;
 b=UtdosgDqgXvhWRG0Cy9oGScALD/RwCtdqIOf6VhEQg6+YSQNs3mjE//HSlaTn8Ql2S
 9OBV7otzG1VRpuKRGl7pz6yhzRw1TcGw4JzWHR4oZIUtFOMrf22lPWlvvRJ+MLe0nLFy
 aEyXuug4d/HrhNmN5TvGtmANJ3d30zFY6gIDB9ZLXQqL1bqjTmYz6Tm1rqQV8z4kTUw0
 6nbUEZ6dvP8DDcJQEzTosGsoRbVvChl/T9jWeCZHNdlO0GJ+keKURIJLkOQicuMJkFFz
 lYQWy47qDpHhzR1LCEfuIvps6Z02KJNxM8Y8+Ys6oHLcPcHIxefg/ksT1yVvAwUw2x9t
 Nh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721084036; x=1721688836;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=snshB3rHt641KR7d9p5KM99A7aw5L+Ac2R2zhxVve9c=;
 b=YpS6UXXTvRCAac6XDVQA2SD0QIU5XECqGcRjlE1nPjHUAwDyooEpgdX0RoOlcFY3Yq
 SN1lJnld0tXZ5pDvzP2J8IuE/Red2sf8fVReKsGSyOyZVZwrDOoMzwJ2iAx87x65ZAnI
 sqRNX0A8xAPZCJOXh28ZctRtO0eE2Re+XwxLNejnM7jcpCXjYgnjwfhuub11pS7dSZhJ
 MRLrR9CFkj/pEqf1EKKyZCSSBmUB1VYdMTY3+2+O23lUv1Vq/CpTcoUM9t8xzbu+sZVU
 qTdeqd+WEpzjndARGQd7l+z30z1jLOnM1Ssnkw9dSy/77iwCyFzHARk18JQByG33UdAC
 Dfeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEO2U2CzafdNSQSiXMEEtrM1Nw/l0CAlkAewaZla6X/Zyr72O/94jFYEDRwuFMGW6Mon0T84DLgtDjAypnYbnWRISCm/M=
X-Gm-Message-State: AOJu0YyDnbqWneqRbqBbRAs8dt4v1ms+KwaePAAASUNUP7FcCWBpCfOe
 V7QoQsScNki9PD4I1aZHcDGMAQBKhX/KR16Ka82yZouP4fACZ/f+5lFKCbdEmRg=
X-Google-Smtp-Source: AGHT+IGSS6e40QySTHiIRFoWGsvzz+zMkn54boxKPJi6rVVyly+lMkvSz7ZUxY8IRaAxKGi0uDyb8A==
X-Received: by 2002:a17:902:fc86:b0:1fb:4a94:4fa7 with SMTP id
 d9443c01a7336-1fc3d93b70bmr2464285ad.26.1721084035628; 
 Mon, 15 Jul 2024 15:53:55 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bbc4e68sm46046385ad.119.2024.07.15.15.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 15:53:55 -0700 (PDT)
Message-ID: <befe331b-7b81-4dc9-8879-bea5db9fa6c8@linaro.org>
Date: Tue, 16 Jul 2024 08:53:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] disas: Fix build against Capstone v6
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Cc: alex.bennee@linaro.org
References: <20240715213943.1210355-1-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240715213943.1210355-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/16/24 07:39, Gustavo Romero wrote:
> Capstone v6 made major changes, such as renaming for AArch64, which
> broke programs using the old headers, like QEMU. However, Capstone v6
> provides the CAPSTONE_AARCH64_COMPAT_HEADER compatibility definition
> allowing to build against v6 with the old definitions, so fix the QEMU
> build using it.
> 
> We can lift that definition and switch to the new naming once our
> supported distros have Capstone v6 in place.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/disas/capstone.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/disas/capstone.h b/include/disas/capstone.h
> index e29068dd97..a11985151d 100644
> --- a/include/disas/capstone.h
> +++ b/include/disas/capstone.h
> @@ -3,6 +3,7 @@
>   
>   #ifdef CONFIG_CAPSTONE
>   
> +#define CAPSTONE_AARCH64_COMPAT_HEADER
>   #include <capstone.h>
>   
>   #else

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

