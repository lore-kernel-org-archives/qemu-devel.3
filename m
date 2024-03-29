Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD99CD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 12:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqBgU-0001E8-7P; Fri, 29 Mar 2024 08:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rqBgS-0001Di-ML
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 08:50:12 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rqBgQ-0002Gw-RA
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 08:50:12 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-341b01dbebbso1671444f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 05:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711716609; x=1712321409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fLJZI85SobsK3W2KBK/10ilOKIiM63d9NpdfIrfNLEA=;
 b=sWorGE9FiKdlHbrxdBmJOQ1dUGQad5PRgrRWHwkEV4n5Uu/aVWEfL6tP7HZCTgMegZ
 Ce08yV8Mcnqh0+x4Wt3dXRMk9cultwOCY1k7SEZOHdkXAjO/1SKBjmfbySNlnW6xImAe
 vGll0ulrjVt61693Ydak+QYEtNvDpnv+3Tu5/UT5Du2zl0wZz3CckvNTv71oz49PwG6q
 ZYiXy5HfYWOLU1OdacxWLMd80cM3rjJykFLo/ZBSCXTexLhjEvYB0iuP+jmheOgLFQAM
 WnAW/M/I4PJs6bJLp3Kw2/8Vyh/3h4an42/d6B71iFofsbyf04AFyP3Y4sPOyHxVdCK/
 EsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711716609; x=1712321409;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fLJZI85SobsK3W2KBK/10ilOKIiM63d9NpdfIrfNLEA=;
 b=PgC+TtOuHRQ/asC8rP6O25dRXwDaQnWulcnh3xA39q6ZVYkDijGgUt9gpzE+655zB+
 6xL/+Dtbzdbgr4kDk24x1NaYi2rTKQ7lgEXSmMKZr0u7tTRr7cwYdpoHDiDKUVXjQUKR
 O8aFxsv25/bq7tYu+WL059pmw+Dx3CNtB0MeDw6YwzFj1WwUdN2uMs2aOVr0XU/1q/xA
 4F4dDyvCZeZNUSVl1X/e97OkPhotG/JGvQ1G8gYDxnx+LOy7LW+3c7fcHCm52Il9huFV
 5eeBzKydCBNDZbwb5gMx9Ykv6S+gyouzeD1tr6bnZn+gjTMtgH/wFnbXcOlqqcqUmkRE
 UFnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7xRAQYMBN79Bc3ZtpSq2SXIMrAal+sCoP7jgW8zUAdL6SEuafiCukM+cvo0W5ipTIKY1kBPnA+DiEqJWCvJ66ZTgouAU=
X-Gm-Message-State: AOJu0Yx4vk9rD9EmHsXAyyCW83kvF9DXkG1daurc0tDDXiUI5zjo2lw4
 JJ75vF6t7oRmw7RDvI8za8zoaQpxX9vBmJQVGAcf0V+rNYP/dS+VhTCdEwnhFIQ=
X-Google-Smtp-Source: AGHT+IHy3etOLf5E5+223nd3XCfIUTyZlwYOvw3Z0NmtLpxl8fmiy4vcfxbL9RaRhDqEQ+7RCQGS4g==
X-Received: by 2002:a05:6000:362:b0:33e:ca3a:1bba with SMTP id
 f2-20020a056000036200b0033eca3a1bbamr1665668wrf.20.1711716609168; 
 Fri, 29 Mar 2024 05:50:09 -0700 (PDT)
Received: from [192.168.69.100] (uni14-h01-176-184-39-242.dsl.sta.abo.bbox.fr.
 [176.184.39.242]) by smtp.gmail.com with ESMTPSA id
 a19-20020a1709066d5300b00a4707ec7c34sm1884547ejt.166.2024.03.29.05.50.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Mar 2024 05:50:08 -0700 (PDT)
Message-ID: <063e567d-2b88-4e4c-b293-5225d4084ded@linaro.org>
Date: Fri, 29 Mar 2024 13:50:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] tests/qtest: Fix STM32L4x5 GPIO test on 32-bit
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
References: <20240329092747.298259-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240329092747.298259-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Hi Cédric, Thomas,

On 29/3/24 10:27, Cédric Le Goater wrote:
> The test mangles the GPIO address and the pin number in the
> qtest_add_data_func data parameter. Doing so, it assumes that the host
> pointer size is always 64-bit, which breaks on 32-bit :
> 
> ../tests/qtest/stm32l4x5_gpio-test.c: In function ‘test_gpio_output_mode’:
> ../tests/qtest/stm32l4x5_gpio-test.c:272:25: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>    272 |     unsigned int pin = ((uint64_t)data) & 0xF;
>        |                         ^
> ../tests/qtest/stm32l4x5_gpio-test.c:273:22: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>    273 |     uint32_t gpio = ((uint64_t)data) >> 32;
>        |                      ^

Any clue why this isn't this covered by CI?

> 
> To fix, improve the mangling of the GPIO address and pin number fields
> by using GPIO_SIZE so that the resulting value fits in a 32-bit pointer.
> While at it, include some helpers to hide the details.
> 
> Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Cc: Inès Varhol <ines.varhol@telecom-paris.fr>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/qtest/stm32l4x5_gpio-test.c | 59 ++++++++++++++++++-------------
>   1 file changed, 35 insertions(+), 24 deletions(-)


