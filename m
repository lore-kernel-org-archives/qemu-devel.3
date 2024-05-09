Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5EFC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 13:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s540l-000217-CF; Thu, 09 May 2024 09:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s540j-00020t-TG
 for qemu-devel@nongnu.org; Thu, 09 May 2024 09:40:37 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s540i-0004iI-B0
 for qemu-devel@nongnu.org; Thu, 09 May 2024 09:40:37 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2dac77cdf43so10882951fa.2
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715262034; x=1715866834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2xYoSIZ6oXWZ4DewpOXG2jAh+KmA/4F353mZO4bdEjE=;
 b=MkpAMWnI50y51lAhWyuJUr5P+HvMG0kNy7gM9HEjoFU/BN2uQPEMivVeIXLKiJxRbD
 kZWgcnQhER1nrev50F7QoufImjIhU0TI24b1tixAqFf5344Qar3IgQIBVShaWt1Muz0c
 R4ukPLcNVyUvTQqyXLF2gR0uZZKCMJOVMWOBzRyd4qRHmZiBdHLI1fg4YScsudgPUgfO
 eEvk07CzsBt0EoadZ9EyZY2vYf+0m9jwBY2BH90o0brUFfrSmCiLNYAcmD7DF26IlqAK
 b45Hw5rGrN7JtsvO2nEGagMM08aTH2WgZUwtFO200Qc07um25D39v40rfOt/3l4Z3BaF
 qnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715262034; x=1715866834;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2xYoSIZ6oXWZ4DewpOXG2jAh+KmA/4F353mZO4bdEjE=;
 b=Z3NpXtekePletwTS6BsB015V4g/OUNMDpTqpdB4rPyyoPkBWbTAp30cBmBJq7jOQjF
 +Gx4CS5oZRLcmruuYF0Kd4HMC8lMNMpmpuIlKu+I+vqhE4VTy4qT1QQnXANBQIrVCpUD
 LbgixquqkftW6S01E1oG8/RR/7FsV1WVl9AWqiRhspcO1Y8VDhEEuFBVoUCtZiPJjM6y
 0Vi+1XOZ2ct7K34qc2gc4Ashj9iEpvHjmxUNCsrSoBYqUCvMQewdv8dKLYmwTpm+EU0c
 JnDdpDZu0gLI05kUVFqyRMeZsWtR8+osjGSKZTcbRQCFX2anbM1tbSWjRy+OkbgEiaL+
 Wuuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMmOMOn3AuUJvLLmLkPRM/jD8vU55Ss3ekXVyuaquCiV93qWwHDDAwzRFxZm/vCZ/+95zsuXHVNz1V1Gag39kv7ZZoJaw=
X-Gm-Message-State: AOJu0YzPomC7bJnT7g0h/14ePx0kbaBvNB83lSYgngMU3eqmjEuW8PoU
 7w61iaMwsVSn5qeMvSWPt6bD4HD5e0Czc1ZVGZc8yIEm3RXpC+AHw/ehIlV7WW8=
X-Google-Smtp-Source: AGHT+IFGsfo3HWNOdw4viqaG42XILkntAioH1XCIHVTVOgpZ3Kfx+vKMLERiR8M5BFITMzlFlE8iIw==
X-Received: by 2002:a2e:9d91:0:b0:2e0:ffea:4298 with SMTP id
 38308e7fff4ca-2e4475a1987mr42619891fa.34.1715262034277; 
 Thu, 09 May 2024 06:40:34 -0700 (PDT)
Received: from [192.168.51.227] (56.red-79-159-217.dynamicip.rima-tde.net.
 [79.159.217.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f882085c5sm61502905e9.40.2024.05.09.06.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 May 2024 06:40:33 -0700 (PDT)
Message-ID: <b66b782f-c6a2-4ab9-84d3-4e1dabd1159f@linaro.org>
Date: Thu, 9 May 2024 15:40:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: remove PCOMMIT from TCG, deprecate property
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240508154421.61419-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240508154421.61419-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x230.google.com
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

On 5/8/24 17:44, Paolo Bonzini wrote:
> The PCOMMIT instruction was never included in any physical processor.
> TCG implements it as a no-op instruction, but its utility is debatable
> to say the least.  Drop it from the decoder since it is only available
> with "-cpu max", which does not guarantee migration compatibility
> across versions, and deprecate the property just in case someone is
> using it as "pcommit=off".
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   docs/about/deprecated.rst   |  8 ++++++++
>   target/i386/cpu.h           |  2 --
>   target/i386/cpu.c           |  2 +-
>   target/i386/tcg/translate.c | 12 +-----------
>   4 files changed, 10 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

