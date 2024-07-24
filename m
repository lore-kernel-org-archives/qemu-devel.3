Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6FDC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 06:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWVwo-0000n8-1k; Wed, 24 Jul 2024 02:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWVwm-0000ku-4b
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 02:58:00 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWVwi-0002I6-R4
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 02:57:59 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-427edcc207cso13858935e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 23:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721804275; x=1722409075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lfpyUM9uNhrIiakDM85MnHl0o0QwRdZzU2dzqsg2eV8=;
 b=H73/xsNWd/ZDB54e7PIcA09C3UBCGxxbXaY/EVusOGwuaxQlW3WTbP1jtQuTTKnJ3b
 3+3E5wLYRkUxiM+htC7ezQVmPHKcPPRf079mbfgxfdY1rZp6esK2YFYorkbLlqwYoyYT
 by5hGnECEpccqc74UGkviVsfAU967nnkX05rvWNwJI5/KBBMp3gsp96XgRamqvM+QFR8
 vu5tFYgETq1GJsM3hEnZH6uS4dM0Yea+sjug3U8TwMt86H/UMr5/hOgc9wg8msEvuYqY
 e/CkDmFXrVovA8mn+wfAINA0hF2HuZoCRFHHd2rPweYbt5vaiNXMgc+6jOTfiVJCPhdE
 e/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721804275; x=1722409075;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lfpyUM9uNhrIiakDM85MnHl0o0QwRdZzU2dzqsg2eV8=;
 b=VB5qblf98xNKRo/Es5Zb/WiAXayrZoLT5o7mhxDJg7E922fNhap78vi3lQAPobvInj
 GCpLk1UaL/C6tevecX+wH8gv8M9n3vBGZ2iW4BspXsbdF5yTymFK7EuWTUz1HS8F2TIH
 OgvC53Gm4cHhg099FuYynt5UvndJSAFtVdndq6VT/TKm/+8BQpGh8Zq0YvlypHw1K405
 HdSiolciaxqJlC9hcykcNV3cBV3gfLu7kGmeMjZ5c9MMZRh/2qtDGULZn6JpViN11/X0
 Z+NGxJLZ7vbukMcUuKeilDn1Upn41D4HZWnr3oJfo4lTeOayTO1+hyXIETzLqK6mRnKF
 mOEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzv/x6WPkU6iFpT6RyKjx15YLJpytfPjcEG6dmNtyKuG/W7zT5ral9SA5xftniB3R+qMOzFpBXL3wLYIkvJwpAoKo/sNE=
X-Gm-Message-State: AOJu0YzTFWnuVi2Eb3Md/NtG+BM1s6wk6CNuy2t0ZJGaMGqWDgomUXbu
 UOrSq95RAKrt9F6KMydsr/b25KxGyDg9eEz4CpWYYxxX/6zfQcaC6/caKIMORf8=
X-Google-Smtp-Source: AGHT+IF8dReDjHXH5KnLHpRPDRkWYUmC0psx1eGcFp+sp9Ko2djaosafVa/cQ0o+q0Z4oWHcilpXhw==
X-Received: by 2002:adf:ed05:0:b0:368:2f01:307a with SMTP id
 ffacd0b85a97d-369f5b810dcmr799059f8f.46.1721804275137; 
 Tue, 23 Jul 2024 23:57:55 -0700 (PDT)
Received: from [192.168.69.100] (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr.
 [176.184.50.4]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f93e6871sm15029275e9.30.2024.07.23.23.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 23:57:54 -0700 (PDT)
Message-ID: <4ef1c80b-17e2-497b-9af7-c7f4224be48a@linaro.org>
Date: Wed, 24 Jul 2024 08:57:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/tcg: Use --noexecstack with assembler files
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240724010733.22129-1-richard.henderson@linaro.org>
 <20240724010733.22129-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240724010733.22129-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 24/7/24 03:07, Richard Henderson wrote:
> Add the --noexecstack assembler command-line option to avoid:
> 
>    /usr/bin/ld: warning: boot.o: missing .note.GNU-stack section implies executable stack
>    /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> 
> which is enabled by default with current debian cross toolchains.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/tcg/Makefile.target                     | 2 +-
>   tests/tcg/aarch64/Makefile.softmmu-target     | 2 +-
>   tests/tcg/alpha/Makefile.softmmu-target       | 2 +-
>   tests/tcg/arm/Makefile.softmmu-target         | 2 +-
>   tests/tcg/arm/Makefile.target                 | 2 +-
>   tests/tcg/i386/Makefile.softmmu-target        | 2 +-
>   tests/tcg/loongarch64/Makefile.softmmu-target | 2 +-
>   tests/tcg/riscv64/Makefile.softmmu-target     | 2 +-
>   tests/tcg/s390x/Makefile.softmmu-target       | 2 +-
>   tests/tcg/x86_64/Makefile.softmmu-target      | 2 +-
>   10 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


