Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55555C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 01:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYyHw-0004R6-9G; Tue, 30 Jul 2024 21:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyHu-0004KS-IX
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:37:58 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyHs-0007Px-1J
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:37:58 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70d2b921c48so4002405b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 18:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722389874; x=1722994674; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wxztcxgl1zl8L4/RBureT0HkZ2BHo50CPn9EIdINFdM=;
 b=J7+A7cdm5kYj/llvQE6PqhnmaFF3tkkp5MdiSeq+xEYOlFKIpsah2ew9JY81vcFPqo
 3MR1LebbVxYRjRNa81Diedw4VNcafhaQIUiAWykOTSR7TGmOCAJbrTWqbci0jKqvr+O3
 pjwQuvVe1S7U90DVnVxX5Wnn8MRXCg7L6WCFYJ97FAP3KB+Mak8riAz8GsA/B4Q5UyP+
 wD4Po1YWWYWwETZz1E5sisxbcWSYL3NJkrgkBa1ATtc0OBtJ7gmtIZNhVc1UNZrGAbqC
 KVyV79lC5x2mGdETBvTbEnJ8P9Opr3FsHPReWmNHQyAhGHR/X5uBnajU/7pceYjUVlkz
 GnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722389874; x=1722994674;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wxztcxgl1zl8L4/RBureT0HkZ2BHo50CPn9EIdINFdM=;
 b=QEexshRmgyhaOHXlpKWazw2H64DosFtyzXR9KOpHrbuG5p03KbakZS/0VnjfTcnuWP
 hemAftRSGyR+vqqUkeddKyMURvjNPAmqsdJDDrCOL2diAUupfuae6ZsfjvoCCrfz6Su2
 LLicC4Zts+9utxtYGiN6rfHU4FgrhJKI/WL52sHFywy8waOMqCdkfuT6r8AJK98WxnLD
 H7ncV3hnlLkqKvezsSEyqv3MAHi+3ZNAbpo6EsaXaG0TbMqti4ED1UY9LHImgAD5j+1H
 FjSnJqWi9tU/bHVDoZszM4QdJLTA2gSUxuWylQtqibe3cVJSX1jqkQZZZ7pOCDzq5Qyl
 s+4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlf4+yH6ul2z0lzdtGARHgHL92FIhAUQpPgDwNVIdMyDyePGjveZKNG4Y2vepzX/2PBjdw8bW3iwSODYgpTYQ0s8iiFCI=
X-Gm-Message-State: AOJu0YxIhn3qM3bR7Yft5YKSdd7mO7umHFzDO5t1yxnc5I+F6A4B2+TH
 6WccwTBD2fEV8sbCFk79emgWHGts8o/EF5/CphOtY0bMevRSgniAnp9UMklQ/fM=
X-Google-Smtp-Source: AGHT+IEuxcshsC4OJdNT/PZUx14wDeSfb9fSlGLDZJUA8FtHW/J64hT1DWUYSOdI5e8E2NG/awdDBg==
X-Received: by 2002:a05:6a00:b55:b0:70a:9672:c3a2 with SMTP id
 d2e1a72fcca58-70eceda187emr11001254b3a.24.1722389874498; 
 Tue, 30 Jul 2024 18:37:54 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7104e5411c8sm82301b3a.39.2024.07.30.18.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 18:37:54 -0700 (PDT)
Message-ID: <b4719a70-3bc6-4017-9be3-aa145507112d@linaro.org>
Date: Wed, 31 Jul 2024 11:37:48 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] target/arm: Pass env pointer through to
 gvec_bfdot_idx helper
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240730160306.2959745-1-peter.maydell@linaro.org>
 <20240730160306.2959745-5-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730160306.2959745-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 7/31/24 02:03, Peter Maydell wrote:
> Pass the env pointer through to the gvec_bfdot_idx helper,
> so we can use it to add support for FEAT_EBF16.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.h             |  4 ++--
>   target/arm/tcg/translate-a64.c  | 11 ++++++++++-
>   target/arm/tcg/translate-neon.c |  4 ++--
>   target/arm/tcg/translate-sve.c  |  8 +++++++-
>   target/arm/tcg/vec_helper.c     |  2 +-
>   5 files changed, 22 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

