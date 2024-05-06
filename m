Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1C9C25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 22:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s471K-0006LJ-Bi; Mon, 06 May 2024 18:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s471H-0006Kl-1x
 for qemu-devel@nongnu.org; Mon, 06 May 2024 18:41:15 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4719-00016y-8A
 for qemu-devel@nongnu.org; Mon, 06 May 2024 18:41:08 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-34d99ec52e1so1571044f8f.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 15:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715035266; x=1715640066; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YtIsa+q+qyaxAqznMXhnV7+sLoP1fEvZyowUHXXY0wM=;
 b=Nl/cNxlejq50+QV4sCF/PrIhED1XLih1z8MkJGY2poWFcqja+Vc/TlW98Kr3Ef1A6E
 p2fuuDPxZIl2Zg47NeQVJ0d7kHOlLUGVJNvWebUa2eOeKREL5uosUFRY5eDNydbTb22/
 jx0bRR+e+po1E8kb0oKBclnxCSDNcj4lIoLXZhmw1QN3dsioDP2peyuBTeNZBZ2aTIGv
 OE6jGMLRUdDk4rTfS7BJSsD9tOjdAIuU4JJWVxBVbhO+8u5pwTMEEKQAHT8uIpz5RfmK
 H1qsq04leIsH94rHOsiEZ7vA6CHhQbFrLlqJKOJCyCnF8ifvk48/wEJsRsvQOCqcmSol
 VCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715035266; x=1715640066;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YtIsa+q+qyaxAqznMXhnV7+sLoP1fEvZyowUHXXY0wM=;
 b=MswoH4Js7YhTqSNzlksDarCmaFX47icZx8J/zHbWDTzYQdPaTsiRJbT+REM8mL4l7g
 A76NyC00B40CZXg7uaho5DBQ5f938qbmGN3PDTH0yxup9/mOOEIvPiMTIQm/65GOakSQ
 /kWtUQBEA8gnkNDbudShT15DhUsHsGWaJxlEazga9PeqD3SaJrK8hAW45atBoPnK1XFB
 LpyddF9O+WDDhoT2na6UYzbE5iXdWWM80dFnsxUsbJcJV3FbquLT/tSebCNzE6w2nLba
 pm4EiIMAlNHU78JA8kbQnls9Sr7JRhHnkgDMcVnVZicCdBa89RJKIU3Q959l7crGMHjb
 s8bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURoCsKGt4RAp/IYBxujEA9lepO4vaE11hp+U/Thv7TsyoKUHbY6yIYQ8q5Q8oPaHB1uSsyy2QB+HKrqHiqBZSPJ5X5rZI=
X-Gm-Message-State: AOJu0YyaaYVPyyHl00xzIkK4svGz1qbC9rKvm3vYm/f9LoWiRagKKdf0
 /44h8y5wTXPgsqr7wNKsV+Xp9LPe9jCBNb9k9n2fUexdxzqD6Ts3F98unsob9aZL5An5DL47bep
 8
X-Google-Smtp-Source: AGHT+IHFbRsmplE+J2ALAA00Cj7ybZezLSKS2kmOH+n0g432fQ/DozQpDWIEXvXREMxLBp+fzaZGUw==
X-Received: by 2002:adf:e750:0:b0:34c:65ba:5d43 with SMTP id
 c16-20020adfe750000000b0034c65ba5d43mr7882594wrn.46.1715035265743; 
 Mon, 06 May 2024 15:41:05 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a5d420d000000b00346f9071405sm11589508wrq.21.2024.05.06.15.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 15:41:05 -0700 (PDT)
Message-ID: <757d2ba9-27a6-4d8e-9e79-f31d3efa3000@linaro.org>
Date: Tue, 7 May 2024 00:41:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 32/33] target/s390x: Use translator_lduw in get_next_pc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-33-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424233131.988727-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 25/4/24 01:31, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



