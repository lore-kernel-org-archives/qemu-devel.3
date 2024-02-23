Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205C1C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUeM-00046w-LW; Fri, 23 Feb 2024 07:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdUd9-00014J-VD
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:26:20 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdUd4-0000iI-3Z
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:26:19 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33d754746c3so510261f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 04:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708691172; x=1709295972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=idKcpIcniaL8IAn26qKaZe0/gBqZXOItKcX8UBMnGYY=;
 b=eMCfVHgZr6CMQ92pKVaJzLYxK3/CQUfj9Wbi5zkO57bwsTW/DhlfAX/vmXRXZ67pX2
 zSrNuQjFbefJfV+++fyZFjLkgTimO3y49WoBxbBL6GCbp0ZAdAKtJh5rPafVNB6fuIh7
 zULYQD2S0pHd71B1hecgyLgrWA0D+Y1ae01I8oIRiinzF87Rs6SFAaok8Ubbt9ivvEaL
 odG6V6SknD0g7N+ABok4RfRhh1EwaS+cBRx7oKDBTStGw6z3pPDwocpZ9A8AKLJy6GE0
 2KpgIwd6Xu7IvaeZz6yAeHs06/AiTTpJRpDeMW5ll4XZ+hlARdAtxHXZFPfCp1DeL78A
 oTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708691172; x=1709295972;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=idKcpIcniaL8IAn26qKaZe0/gBqZXOItKcX8UBMnGYY=;
 b=UsB9xYsu5CeuzTIaUggruWNg+SYx8lyVjRoWEARgspxexZQcWmcUTcS7h/FHgm93w5
 F6BWXA0bB2xyAby8b53iyKt2OxXe9/ot1/dIciUH4xW/O1CudjHm6/FxZCaDUdq8cGBg
 tfouUhEdBQJaK6TtK/IcPCFFPMPLL+CrqHXDl382n4JJhREQQ6FCVAjhmbytIGoP74Wm
 p4keNEvBkDX6pbceq4Sv7H+gWtt82o7kJAaGjQsu994QD7xsdLSVqYYzzUPIJlEcQZFz
 X8jxs2/hGsVbfS/LOaiP1fnu58V4w3BomhbLk53wfebTiwc5p7hPvi7eAr8W5KDVu4ta
 PHXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqatDIQYqJOIWukMC7DJrPBIXZvuZhjEsqXnPbb/jkR4XUpzoJIVjBG0nccc3bxQKXOb5GvFLZTJJ0AlcSLYg4T2+eIhw=
X-Gm-Message-State: AOJu0YyBQ4PcOE+hcsLF9vDD6LygEuNaPlaQJu09IQK6vOSaggmSjnep
 tnk8QlFVh5NXI90DbcfY+tPj5wOtDVmx02bxYL67HbF/hVhyoeIDRjZ9KCr+FS8=
X-Google-Smtp-Source: AGHT+IHnIEp/VcVfii7b1CECYChjjfIibRUhm3aQVldvM5WPXvGfRGsoOBvoM2LkRUPpZ04AZkZ/4w==
X-Received: by 2002:a5d:4203:0:b0:33d:a011:ae42 with SMTP id
 n3-20020a5d4203000000b0033da011ae42mr1282215wrq.38.1708691172532; 
 Fri, 23 Feb 2024 04:26:12 -0800 (PST)
Received: from [192.168.69.100] (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 v11-20020a5d4b0b000000b0033d90b314e7sm2631441wrq.101.2024.02.23.04.26.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 04:26:11 -0800 (PST)
Message-ID: <1a71aa6a-0fe0-4407-a2f3-3fb9bacaed8c@linaro.org>
Date: Fri, 23 Feb 2024 13:26:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] tests/qtest: Add STM32L4x5 GPIO QTest testcase
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Thomas Huth <thuth@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>
References: <20240207132517.198348-1-ines.varhol@telecom-paris.fr>
 <20240207132517.198348-4-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207132517.198348-4-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/2/24 14:23, Inès Varhol wrote:
> The testcase contains :
> - `test_idr_reset_value()` :
> Checks the reset values of MODER, OTYPER, PUPDR, ODR and IDR.
> - `test_gpio_output_mode()` :
> Checks that writing a bit in register ODR results in the corresponding
> pin rising or lowering, if this pin is configured in output mode.
> - `test_gpio_input_mode()` :
> Checks that a input pin set high or low externally results
> in the pin rising and lowering.
> - `test_pull_up_pull_down()` :
> Checks that a floating pin in pull-up/down mode is actually high/down.
> - `test_push_pull()` :
> Checks that a pin set externally is disconnected when configured in
> push-pull output mode, and can't be set externally while in this mode.
> - `test_open_drain()` :
> Checks that a pin set externally high is disconnected when configured
> in open-drain output mode, and can't be set high while in this mode.
> - `test_bsrr_brr()` :
> Checks that writing to BSRR and BRR has the desired result in ODR.
> - `test_clock_enable()` :
> Checks that GPIO clock is at the right frequency after enabling it.
> 
> Acked-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   tests/qtest/stm32l4x5_gpio-test.c | 586 ++++++++++++++++++++++++++++++
>   tests/qtest/meson.build           |   3 +-
>   2 files changed, 588 insertions(+), 1 deletion(-)
>   create mode 100644 tests/qtest/stm32l4x5_gpio-test.c

LGTM!

