Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6DAC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU1Ns-0007qs-FE; Wed, 17 Jul 2024 05:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1Np-0007km-4u
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:55:37 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1Nn-0004Xq-9B
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:55:36 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so53021235e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 02:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721210133; x=1721814933; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YtzktnSK4zkVsP/pcjVRLdEcQ1HHY25dswFh+ARvGCw=;
 b=yxmTxT0c/NYX3n6ApK8PL263OFs/64xXe5zXkEne72COyxWXU1eEjs8J5i5xl+UEuR
 OKUy/bjJdz1CDAsOzJ+B269cnXphXdNjlqZS+fDKm+VFdX2AE/g2TCgwe7yL7L575fNF
 EKRHS8sUwbeS9zNp5JrQwV/e1I9bIP1rPBd/bNRlsd01/3z7ZFUw5QU6SSZI02Phi9oZ
 CWDipOlxmH3vxYuohXlc0YEmFoY6JNk1WXV0HceTpiWFPTSbkHSKYNp9Rr8WqMRYhAVp
 MTCpeHcEvfGNm4LaQhgDpQkuiMJVbjcZD/9IGNnUXYMNGiNvAftFtWJY/32VU8uAsNW4
 9X7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721210133; x=1721814933;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YtzktnSK4zkVsP/pcjVRLdEcQ1HHY25dswFh+ARvGCw=;
 b=fGFsZT2o+otQvg5I2DZQfuyw4NrlyvkIsrSqRaWk9Wk5sVczBvL5CL0J5m+ZjBXbPN
 OJCH9NkSn5E+kAHlP1wDsPVl8jP5YDAQdGIIpY2K75M1djvdzSJxdHB5+5QILZ9aHIkc
 f34k0dfI2FekeQXhun803dOGCMbq8iv9aEOb0ODYnEupWLkUj079XFVyqZnK8LEJJs4k
 IJ6AVuamp774AKKq594zC5a9Luf+jwHN4hJgFtBT9jtQjuUksp6LvFrNq/jswgsnKA6a
 OgjOVN0UH/r0PEzjdjLc85iQL59V22oThNjEp5NKrWG7ZJwnPrYTJ0DSiItlbMJfvovE
 141A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrmdkRFuO8XNRwhYqjiCQFHEPS0UwetoWVBeO4iJT3v/8pcVtLqfcxfDhYfFfRg3rN1MByj9a7c6lh4MVSEfj3GjDGhto=
X-Gm-Message-State: AOJu0Yw3yXuziPoGDuEbre0hmn20kWPYHuQjSE1nUJ9v7PJ7pMMw8tPG
 Nla0X9XhtUd6UqDOKzpB3ujp+dTrllqlH7idF6yArP8AXQ9nl/Dh50pN3Okg+3A=
X-Google-Smtp-Source: AGHT+IEa496T/aNzl4mMMS/G16nF5mhesKtLKsUvkB+vfkgEDpZgRgu4ZvGPkmMF30uSTm7hIKSf0w==
X-Received: by 2002:a5d:4845:0:b0:368:3f5b:2ae7 with SMTP id
 ffacd0b85a97d-3683f5b3871mr233829f8f.24.1721210133417; 
 Wed, 17 Jul 2024 02:55:33 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e77488sm167749645e9.9.2024.07.17.02.55.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 02:55:33 -0700 (PDT)
Message-ID: <10eb7805-6de3-45ec-8d2a-f5af5f63545b@linaro.org>
Date: Wed, 17 Jul 2024 11:55:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] target/arm: Convert EXT to decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20240717060903.205098-1-richard.henderson@linaro.org>
 <20240717060903.205098-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240717060903.205098-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/7/24 08:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 121 +++++++++++++--------------------
>   target/arm/tcg/a64.decode      |   5 ++
>   2 files changed, 53 insertions(+), 73 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


