Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874B7C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 23:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZIJO-0007oD-52; Wed, 31 Jul 2024 19:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZIJM-0007lN-5x
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 19:00:48 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZIJK-0007t2-I5
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 19:00:47 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70f5ef740b7so2381777b3a.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 16:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722466844; x=1723071644; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZyPtboJt+m78kSqNs4mOUAYKCiN4YAze2Lx1xSh2y94=;
 b=rDrMUkyGxE6ZYLm9XZEX3wowZR5vwlX2idS2N++r7ZinGdmvULIyPPmFxURBqAim0V
 kfvGmZu876pMYTdDRb7yh2xqiED5PcIgDwqDd3CqjTAFbFgkdj2ZGpqdmloNkVoSRCmm
 JNRnFM4dB9UcdPmTtba0FOLGZEM4m5YsFcuzFj/4dUAXuBMe4FnSy36gG8FUS0MoLKNP
 svt2sefHuS+i0zIlau27WGYskNP5mEtzob4OB0WziMk8XOyI71Vnet2UUtIG580gDZVH
 +bKBB9dT5ZCaR20rxAI57W20/cUe1omraEY9KKw7Oup1cveTK61d49KDuGytwT7wY1N2
 5bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722466844; x=1723071644;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZyPtboJt+m78kSqNs4mOUAYKCiN4YAze2Lx1xSh2y94=;
 b=si3qJRwjGyL9CJPalqdus3p2Z0+GIQOKFHnhtlp/ZXvdkRfl12gcnNIUNmzCdaU0m5
 Br6nzAoLNA+b1sgR7+OkLa7HuYWNHtbnAfFp8YYB6yuRQ8LyCxqS5YqJFMAuqlD1ydYU
 HdCFfIz+VD6d4+IfQAuj5S4FmUWoPLe9pU7X5tzmuSnH0T+c2EnqCgVojQjWODrzFDUp
 xoaGqfF3z5A9bt6dgP7agqlx+ID4HnenQe0e0G2j97fbks1BjzfZLW/b0oAqf28qGM4C
 +IYD0lw1TISRTjimngy/cIlBCo+W0Nfx4Vg21QrVcivQrUwShBLF1cUMjfaq5OkS6flW
 jZcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsnlGF9gPtpb7tYZeQIdAu1Phumejym+QmrwI82eRVln3gsMAX414DYwj6hPV776uBrtmGvncjNASPFhfn4jL+rOGJAis=
X-Gm-Message-State: AOJu0YwF5CQW9Wt2+2j2fzPXAzrHAxYlMvYt6kbIkT0C2Bqn2EMn+x/R
 mORviLmQSx8A1m6CWtWWUJ8jWv1DB3pNSioWe8Z6tBuF0lcBa5tjEw9aKdVNtXM=
X-Google-Smtp-Source: AGHT+IHgD9CNgGtk/cU0YFiVpIJI6mYOXMvY2uH4ytQlLvr5TVneThY7xQhFzmgtGDPmycP7Ok1XSw==
X-Received: by 2002:a05:6a21:458b:b0:1c3:ce0f:bfb2 with SMTP id
 adf61e73a8af0-1c68cf82b39mr699482637.23.1722466844244; 
 Wed, 31 Jul 2024 16:00:44 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead712682sm10451662b3a.60.2024.07.31.16.00.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 16:00:43 -0700 (PDT)
Message-ID: <42fb9582-9215-4ccc-bede-0c4f03fffd4c@linaro.org>
Date: Thu, 1 Aug 2024 09:00:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/24] tests/functional: Convert the riscv_opensbi
 avocado test into a standalone test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-17-berrange@redhat.com>
 <9fbf2f80-c7df-4819-8f74-c7ce75dc70a5@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9fbf2f80-c7df-4819-8f74-c7ce75dc70a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 7/31/24 22:56, Philippe Mathieu-Daudé wrote:
> On 30/7/24 19:03, Daniel P. Berrangé wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> The avocado test defined test functions for both, riscv32 and riscv64.
>> Since we can run the whole file with multiple targets in the new
>> framework, we can now consolidate the functions so we have to only
>> define one function per machine now.
>>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/avocado/riscv_opensbi.py         | 63 --------------------------
>>   tests/functional/meson.build           |  8 ++++
>>   tests/functional/test_riscv_opensbi.py | 36 +++++++++++++++
>>   3 files changed, 44 insertions(+), 63 deletions(-)
>>   delete mode 100644 tests/avocado/riscv_opensbi.py
>>   create mode 100755 tests/functional/test_riscv_opensbi.py
> 
> Please squash:
> 
> -- >8 --
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 98eddf7ae1..a906218f9d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -336,6 +337,7 @@ F: include/hw/riscv/
>   F: linux-user/host/riscv32/
>   F: linux-user/host/riscv64/
>   F: tests/tcg/riscv64/
> +F: tests/functional/test_riscv_opensbi.py

It seems worth taking this opportunity to add per-target subdirs of tests/functional/, so 
that we don't have to list every individual test in MAINTAINERS.

Surely one

F: tests/functional/riscv/

etc, is actually maintainable...


r~

