Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1D9C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 05:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTasz-00076b-GE; Sat, 27 Jan 2024 00:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTasx-00075h-Rr
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 00:05:43 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTasw-0003cc-BA
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 00:05:43 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6e0ed26cc5eso666211a34.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 21:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706331941; x=1706936741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=weKuqzC9tp6/h7jatkkGZ0S6HamZ7GxJD+IJulFZky4=;
 b=JchK99UlXwNd4Mj5SIkGXTKjhGCNXpsx5qgENcOCQEKUMDzIgMbyHc9hPRqXwIyI4O
 7jD+8WvCcHKL7uu6LKT+0bdFrrU0lzYVjf6jJQlM5txTdOtohO68sCVjQzIMQTO1BLS1
 1CwEeZ0HL6y5Xf/fB7Kss92nZOvS7Obry6fmqjy6i3Cd3ZTZvmf6WpyFeqB1BAGoSsKJ
 AYWDVgVzaUz7xiLAzSHZg2euDvHApVBXqyKhLM597/FbLIeoe5tGH3686qwTNf/5Yjgk
 eIvvSzvU2j/z8AVbksK5uqlUkufBfbpwum258XQcHaxiWpRJwSWeb8Kg0a2xWaPUjpFD
 HJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706331941; x=1706936741;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=weKuqzC9tp6/h7jatkkGZ0S6HamZ7GxJD+IJulFZky4=;
 b=T9aaXazpfxvTDsBFtaht0TWmOl4KtMd7T+kMyoNLMMRnXe3Jo0IqsZcwb+bVWzEmIb
 SenCrGWIXbLjji73cO4T+QbOQnvBCO35kE5tOWZoKXj/uhMlAkakpABLiYZZ3cmCG6Js
 3bfXstUjX96PIC/50I14G9q/RbmyjM+9q2WJJaR6QJ4PU21O58Y2b4mLxqJXTyt9tVep
 gH19XvX6jgV0yqkZkGb8eieNoFlwHi8pVuV2CoCVmXja1SeKA14hGMD8MDx4kPXpvRik
 I8+wapby3NfGNZL/NJIOscra0xGWu/su0RjjEgpQfYKs+2TE1zpX9gZeplf1ry04EB++
 biMQ==
X-Gm-Message-State: AOJu0YyfXMrGMDJ0JgmD9K8OQC/tGaG8ey71vYe2grYiyKHFPr3xxR9P
 sIJeQKHAPHLg26DHX51CGmRtqe4pPsWreOblCMj8Mtb2bKNtahsGrnGOP+r69Z8=
X-Google-Smtp-Source: AGHT+IFJgSbso49Rd1Px9udkRJgMmwapp2zH5ljWTOkiLQ2G6L/M5zi3oIsq/tgotTicmt3C+JTHdQ==
X-Received: by 2002:a9d:3e4d:0:b0:6dd:eebd:cd5f with SMTP id
 h13-20020a9d3e4d000000b006ddeebdcd5fmr959462otg.48.1706331941057; 
 Fri, 26 Jan 2024 21:05:41 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 d3-20020aa78683000000b006ddc14c416dsm1974542pfo.95.2024.01.26.21.05.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 21:05:40 -0800 (PST)
Message-ID: <da1c3d20-2fa4-45d1-89e7-708b8437066e@linaro.org>
Date: Sat, 27 Jan 2024 15:05:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] aspeed: Clean up includes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240125163408.1595135-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

On 1/26/24 02:34, Peter Maydell wrote:
> This commit was created with scripts/clean-includes.
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>    it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>    Drop these, too.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/arm/aspeed_eeprom.h     | 1 -
>   tests/qtest/qtest_aspeed.h | 2 --
>   hw/arm/aspeed_eeprom.c     | 1 +
>   3 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

