Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3ADC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2024 16:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rw2ZU-0003SU-3I; Sun, 14 Apr 2024 12:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rw2ZS-0003S4-88
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 12:19:10 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rw2ZQ-0005Vl-PS
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 12:19:10 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41854ba7fd5so1371475e9.3
 for <qemu-devel@nongnu.org>; Sun, 14 Apr 2024 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713111547; x=1713716347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qasJ6vqXaVJF/UQMO0ISNoIjzC1qyYgIpkBn6bTltFk=;
 b=i0PQPIdWoUTqZnAREHGIFOvP2rJW1XnCOkGuATmEJJvraD+GfFNool7HprD3iDDoXN
 AHRUPTNUYUgVaGDL//YWy7gVTi+Xv5qe7+WAlmMbF9IfjzPDo7C1px9cdH8tLSwrc2FF
 c2kcLToDrQe8hyVz1IfqD9WYq0V9GvmvKKOxWGPMMKOlmPzxYHxHe+TX7OyTmUgvTQqW
 LzDgW5gmvKWR/Aj14XOMzJlJmUgzqNizs+VX4V32yFyY1suCDgiUv65jofKhax/RuN+1
 F5plGd8vHZyJFjjLU/sVeoCCtYuMa8PZYI20bKCz03OK3TQD8sw+VZR8XikOsfqZF3ym
 N11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713111547; x=1713716347;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qasJ6vqXaVJF/UQMO0ISNoIjzC1qyYgIpkBn6bTltFk=;
 b=h8ZbDhtGGvLnKLR+iQ2oNa/FBF+6aKh4bnCinIameVlHZDy276LKLSik9ryMt5qzOY
 XguzUeuyl/H3BI7rR3tPzVvWbZNLfFo3cbeTtayOZjzzB30C/2VxCBGAMlwFGERvROIi
 yrmZOZPHwQb4TORZYmE4WOOCmDCZ1h9wv+6VMD7uUuO4H2/S+RgIRaPrW3WYTi2PobdC
 QFHZZTIX+4Sh0K2s3tZ2igpyZcNSu3v4ssbCAapEFcEzgaphCjhDN52lO+vnrb7d9Qjv
 7M61lcDX1fY0/FL4n72IU/UK2172/KscdBhFhS3tzedYHSX7Lk60jyCrsir+A8aw5Z8k
 ZvNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH4gFQpbAcQBc7pRioMdR7JdSx2aCts/pPy3DXAg3MR1gu7krl3yUL++IOIacpKEnhd4BIxLLDSXKR52EXmB1kro4TaTw=
X-Gm-Message-State: AOJu0YzL5++n/RKJdom8V69s3NRfXvjAbUuTWN8BT3mMS2dMsEWJ0AeG
 nEX02cjqgulJCg0jE3N6VWtg9TQvQKwWDwPXXVQCoYnQ03qhTCQJSM783cHjpSQ=
X-Google-Smtp-Source: AGHT+IESaWVOtFx9BWtmGMgDc/Ef+99rMoFmYnf2tB80ocQEfyZEkUkyqAKtny9pJlhzsTbuxtvGEg==
X-Received: by 2002:a05:600c:1552:b0:418:3719:61ea with SMTP id
 f18-20020a05600c155200b00418371961eamr2085544wmg.41.1713111546671; 
 Sun, 14 Apr 2024 09:19:06 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.196.200])
 by smtp.gmail.com with ESMTPSA id
 a20-20020a05600c349400b004184e3a82edsm2268804wmq.32.2024.04.14.09.19.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Apr 2024 09:19:06 -0700 (PDT)
Message-ID: <f8878a58-8eb6-4a2d-8e77-d38b11a5d4c1@linaro.org>
Date: Sun, 14 Apr 2024 18:19:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest : Use `g_assert_cmphex` instead of
 `g_assert_cmpuint`
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20240414132518.278858-1-ines.varhol@telecom-paris.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240414132518.278858-1-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Inès,

On 14/4/24 15:24, Inès Varhol wrote:
> The messages for STM32L4x5 tests will be easier to understand with
> `g_assert_cmphex` since the comparisions were made with hexadecimal

"comparisons"

> numbers.
> 
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   tests/qtest/stm32l4x5_exti-test.c   | 138 ++++++++++++++--------------
>   tests/qtest/stm32l4x5_syscfg-test.c |  74 +++++++--------
>   2 files changed, 106 insertions(+), 106 deletions(-)

$ git grep g_assert_cmpuint.*,\ 0x tests/qtest/stm32*| wc -l
      105

Nice cleanup!

$ git grep g_assert_cmpuint.*,\ 0x | wc -l
      148

Still 33 to go... (not asking you to do it!).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


