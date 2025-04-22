Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2227C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 15:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7FhG-0007HQ-R3; Tue, 22 Apr 2025 11:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7FhE-00078j-9Q
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:38:04 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7FhC-0002K7-EN
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:38:03 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so54017855e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 08:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745336281; x=1745941081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vytMJNzvMJzskWUtLOOXcfSbQ70tPfTAY7DgR2dxEoU=;
 b=z4zMOJo/K7rKzzgQK71qmUN8x1+WwPelgah3Pp0m9+9pcAH1EFuHgnMLdXNOT4p6HM
 pauQ415+lR3PGMsAVKxjdg8ILEvNC1W1PT40tuEeyCNJjcu2fZzNIJ6Y+f35KrnsinwA
 ADCbklszBh77oVuoARzLnbVTEuEGIb1QkGvPAVqkONoyzY55UaypAmpTlggKQhmQHUsS
 z6YREIi9xstMe/Lp/+BSx2ee7ocL6mpyxHBGGGJBErSvoJaFKYj5+MVWNBEIi8k9Kec8
 J0Yxr3La4UWpZtgJn36yzpaCyI0XLpNjSosu+GNbkkmpuXVMilwukBDwUDQH987mwnQ7
 APHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745336281; x=1745941081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vytMJNzvMJzskWUtLOOXcfSbQ70tPfTAY7DgR2dxEoU=;
 b=emZmEheIxXVw1UAmcXwWjGz37REhT1/4ERHNlGD8S16VWd/dPATZ7KtShJwxXqw+rp
 VEo8Mmkq/15qxbqVPnKvLfdayu6I03A+xxZCH673eFPFNzAu7/pr+pphOw5HBlTLzWGs
 AIsGdVQpi+0U19yxUtI+ZRNJQ+B5ylHxrh9f2dujg71K9jIqgTMTybqT8eDlmeE56LR/
 PiSE4tVr5Z5ggNgl5XrCST8iRH90TNX1sw0HFALl5kvqRnajDCmD7moV3AS96nn55R/K
 jgJKeDKlj1cZAQsmFDm4dG8oTP6FvSk/Uda1XCdl9lyjO/P4gIDE4KUt7ZiE7SwwdOGp
 Tabg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlOW5vDF/u2qzgboc/qaihhvKwQHZ+dHtOVYkQLZsZpXdM2gIxmhtdigTbkolFaMb6m60MWdd44Cj9@nongnu.org
X-Gm-Message-State: AOJu0YwI3MVtZkFcAgvflr+kiXuvjh7zKDg3nt+HR8/tzuFLa4fMUR9f
 dqCeLCU6accvfE0RXAQRMpYdS9DYbFCiuVe9+ClQBwPm7ssbs+A52hdgTiscvlPPBZVjW9m/RSz
 z
X-Gm-Gg: ASbGncvzfs37Z5MarbD52i/ICEIKdvEUqsV4wIStsephzrZ3P6WfKCskBNjRnsYhOY6
 Mkv0TmKU9NNeFfOwUGfnHw7p5N21yJDQGP64ZJQQE7XNdegURU2Hdnl9Q3Bap8El/QbDRt0mL52
 O4W2PuWJP5kWKQZs7+OFXqhcZratAenFnnRoSl+YWtdIdJlUbUZz8X0fKfWNszxhaM+Hs3RJWHs
 2/3rpkXeAqAl1uCf/cNz4G8frlxDeem0E8Ny6CwYdvz9/4emAz0K/LUBqx/fPcy4CSs8kpFWGZS
 1fOozqLILV/xoJXZKrQglDrXDTxO1KqxGFfAPFM2mntXmIP8MH5NRcK8J0VqORCkpXEu5HIveNn
 haUhVb4Zz
X-Google-Smtp-Source: AGHT+IFIVJUD4S14RA0mW1rcFhvFtqF77DQ5oEvH3NrrLcr7Iez97DfTgbPkC4VvsiF1rxQjsS+Azw==
X-Received: by 2002:a05:6000:402b:b0:39c:e0e:bb46 with SMTP id
 ffacd0b85a97d-39efba383d1mr12087392f8f.4.1745336280662; 
 Tue, 22 Apr 2025 08:38:00 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43c023sm15391082f8f.46.2025.04.22.08.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 08:38:00 -0700 (PDT)
Message-ID: <f00922dd-aebc-405a-8d06-1956e892d1e4@linaro.org>
Date: Tue, 22 Apr 2025 17:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 084/163] tcg/ppc: Expand arguments to tcg_out_cmp2
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-85-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-85-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 15/4/25 21:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/ppc/tcg-target.c.inc | 21 +++++++--------------
>   1 file changed, 7 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


