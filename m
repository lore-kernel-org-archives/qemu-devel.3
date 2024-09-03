Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE7DCD3440
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 21:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slbA1-0002Uo-3H; Tue, 03 Sep 2024 17:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slb9y-0002SB-O3
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 17:33:58 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slb9x-0007yT-8U
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 17:33:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-428e0d184b4so48185835e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 14:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725399235; x=1726004035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f0Ib4U8lZ3ZsJLZzUUh/vOe+ENblshKaDKWawyFfb4c=;
 b=M1hHQ8sBl+hRwYu7olJvbHVxDXPLTflQZZh/i8B8+xnsZDDz0dEPaNECx+yjUm5KP8
 U71On7hBocUyBktD1Mw7dT2k6mmRUpXzz6LcP674DEuAi+B/2JWg34nTKyAm2FKHGo+O
 6pb4noQq5B34t6pREfCD4gK3pXDv++IAKLJRgcnxI269fzNsUfmmsHDZJAaheEDc1tmT
 b3vwfGRnJ73m0zmWm/kH32CnG4RzB9u7vfktlJvY57yo5RCKhq+mNJn0EfTjcbAkohtW
 0ueXqpG+njGF6vUREHFU7sWqbd97x91c5aFCxwVVBEbOhQJmRTqQeqGeaZyA/gl5HdAw
 ENFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725399235; x=1726004035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f0Ib4U8lZ3ZsJLZzUUh/vOe+ENblshKaDKWawyFfb4c=;
 b=EhqT62svERiF7ggqyBwkogZdWwmssiRj0nSm3x9C6rDrGSKyVtAaAlQ52lbHmziSEV
 00OBZ8rO/+sWNQTiyzJhOJ5ND+YuQrqoRzhE1IhymkAcHhK9PMNZr5oR6eQ4+yfKp/wj
 rhiBTZ2BVMNqU2bzHJAsmAlU1HWltzuwhFA+Yiejqs1f3ZHQGXr3dYHXrWrw1dbe3akq
 DIlrcrjDPK97RtATZNzkoXsArRCbynMO7ghpSmKNye2VXb4ACf7/ysajJk4kRwUotUMd
 mYy4G2FCg77PPld9MiNUxvcQWZuPcWNwe9b9/cLg7PgOmHPsoNpHyQNzLAnOOZcg5iBH
 2IIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmgd3NqpOGKSMIHy1ucDBbfMq7YHhTaaA7LE9S7y5ew7WKqhiKTce7QxWkLWiHlwkFeOCLlhSgqTgG@nongnu.org
X-Gm-Message-State: AOJu0Yz2+OLiqHBxaMRVuPWR4MAIIukYqTCa+fUpvn5Nqn/Od8+4EVQw
 zXtDW2A25KU8IEwcPKsIUlihXmgBtvnqINfu3df1rLHy+EAXdXOTIeizDXX69ec=
X-Google-Smtp-Source: AGHT+IGQLd3LUDOjcUihJHCIrTgEtvDfjoujpeS5db8o0Ad/GBKTaDegXlxz0uo5/NUlgbWdbvX4nw==
X-Received: by 2002:a05:600c:3547:b0:426:5dd0:a1ea with SMTP id
 5b1f17b1804b1-42c7b5d8f34mr75757385e9.28.1725399235259; 
 Tue, 03 Sep 2024 14:33:55 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df7c5bsm182687405e9.23.2024.09.03.14.33.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 14:33:54 -0700 (PDT)
Message-ID: <d3c901c2-0ba0-4c13-82a4-24dd3750753c@linaro.org>
Date: Tue, 3 Sep 2024 23:33:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 19/53] hw/dma: Remove pxa2xx_dma
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-20-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-20-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 3/9/24 18:07, Peter Maydell wrote:
> Remove the pxa2xx-specific pxa2xx_dma device.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/pxa.h |   4 -
>   hw/dma/pxa2xx_dma.c  | 591 -------------------------------------------
>   hw/dma/meson.build   |   1 -
>   3 files changed, 596 deletions(-)
>   delete mode 100644 hw/dma/pxa2xx_dma.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


