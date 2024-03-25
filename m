Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ACBC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 06:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rodgJ-0007Fd-Fm; Mon, 25 Mar 2024 02:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rodgD-0007Df-3k
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 02:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rodgA-0007fI-Vl
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 02:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711347569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hYJD0dTXplx8tmYUFvxPyIMbnTl0e1SqD5FBdPJRvz0=;
 b=ckJHv08cfQOUFiu5jS7c5qhA2k62WySGsjWI9FMdzvTsqAaKOklRHA+Waz+iz4FL9W9f6k
 yPWCF+jLzJU8yWmwOyuLwmNuku2GZ0Zt94NGHIgD9qJCWQjDf7EQ5xqY57fy1bxHpa8x7m
 r1DqUCmeN0VC/opYzJtj5laujiIdiH4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-zSM-U6KIN9aHBtcujOnTwQ-1; Mon, 25 Mar 2024 02:19:27 -0400
X-MC-Unique: zSM-U6KIN9aHBtcujOnTwQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4147de378b9so13730985e9.3
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 23:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711347566; x=1711952366;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hYJD0dTXplx8tmYUFvxPyIMbnTl0e1SqD5FBdPJRvz0=;
 b=g0YdS/8YW3GXvTbNoGAPmumpP4TlPyrNSVzoGnm8r9l8oNeYYJuCP+9I52CJxeOfdv
 Nj1g78SAR9nMcgS1EPB1T5xdOrzJ/k8mRwiveiRATY2h8dt/p47M3gzeG+gsxm/Znnpn
 cabJyRL7a3fx+1YUosNtecAl/ZBgg0KYK7XyqN6MZlfNXoE9rHNzvzRTF96j+AAF+Zif
 Cw/e7M8WZ+M/xtl1h3NW3f0GabINZANizb1NUimZd6NtssQzDhLOD7drf8f441mNJ6yL
 Pw2fVQZeu0ZjWeYaY7WPO8dXwYU1bO/sw/CmVhRQXIKB3UcWPPOoSpUFR60YmP6/vpYQ
 36RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+l1OoR0kNq054kOngy2hUM2QkDFo0z129J8cTTAyxGtjVr9jrN6h5pNoN+w1FF4pycV94CvBxWTXh96B1StW4kUtE7gU=
X-Gm-Message-State: AOJu0Yw6RL6VeV31yVr8Ew7VqKGc4ndBBTVXR04gxf6Ibj8cV20HHYab
 gRb/9eTpGO3yVJaY412Ctw5p3HntRvR0qbVdO9/YLQ40qX80fWSUz7VS8oUyYA+BdFevih/KKZ1
 KnyxrufD1IvsBJTieaahRHp1XGJyygVUi1gEtjBETuwARIkquJ89i
X-Received: by 2002:a5d:40c7:0:b0:33e:6056:6b8b with SMTP id
 b7-20020a5d40c7000000b0033e60566b8bmr4181671wrq.7.1711347566628; 
 Sun, 24 Mar 2024 23:19:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9vxS7cgaPl5VSd5wqZKrvXLiNsnJ+dluBmd4q2Jwi1kCJUl82DgvbwD9Yh6NN2ojiEa6Vow==
X-Received: by 2002:a5d:40c7:0:b0:33e:6056:6b8b with SMTP id
 b7-20020a5d40c7000000b0033e60566b8bmr4181661wrq.7.1711347566251; 
 Sun, 24 Mar 2024 23:19:26 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-176-158.web.vodafone.de.
 [109.43.176.158]) by smtp.gmail.com with ESMTPSA id
 j1-20020adff001000000b0033e7e9c8657sm8507662wro.45.2024.03.24.23.19.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Mar 2024 23:19:25 -0700 (PDT)
Message-ID: <9e6142e9-83b1-465d-b29a-01f60f9cbc49@redhat.com>
Date: Mon, 25 Mar 2024 07:19:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] tests/qtest: Add tests for the STM32L4x5 USART
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240324165545.201908-1-arnaud.minier@telecom-paris.fr>
 <20240324165545.201908-7-arnaud.minier@telecom-paris.fr>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240324165545.201908-7-arnaud.minier@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  Hi!

On 24/03/2024 17.55, Arnaud Minier wrote:
> Test:
> - read/write from/to the usart registers
> - send/receive a character/string over the serial port
> 
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   tests/qtest/meson.build            |   3 +-
>   tests/qtest/stm32l4x5_usart-test.c | 326 +++++++++++++++++++++++++++++
>   2 files changed, 328 insertions(+), 1 deletion(-)
>   create mode 100644 tests/qtest/stm32l4x5_usart-test.c
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 36c5c13a7b..e0d72ee91e 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -205,7 +205,8 @@ qtests_stm32l4x5 = \
>     ['stm32l4x5_exti-test',
>      'stm32l4x5_syscfg-test',
>      'stm32l4x5_rcc-test',
> -   'stm32l4x5_gpio-test']
> +   'stm32l4x5_gpio-test',
> +   'stm32l4x5_usart-test']

We are now using timeouts from the meson test harneess in meson.build, too, 
see the slow_qtests[] at the beginning of that file.
You seem to be using a 10 minutes timeout in your test below 
(usart_wait_for_flag() function), but you didn't adjust the meson timeout 
setting in meson.build, so this does not quite match...
How long does your test take on a very loaded machine (with --enable-debug 
used)? If it could take more than 30 seconds, you need to adjust the timeout 
in meson.build, too. If it is running very fast, you should likely adjust 
the 10 minutes timeout in usart_wait_for_flag() to < 30 seconds instead to 
match the meson timeout setting.

>   qtests_arm = \
>     (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
> diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_usart-test.c
> new file mode 100644
> index 0000000000..2d42f053f6
> --- /dev/null
> +++ b/tests/qtest/stm32l4x5_usart-test.c
> @@ -0,0 +1,326 @@
> +/*
> + * QTest testcase for STML4X5_USART
> + *
> + * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "hw/misc/stm32l4x5_rcc_internals.h"
> +#include "hw/registerfields.h"
> +
> +#define RCC_BASE_ADDR 0x40021000
> +/* Use USART 1 ADDR, assume the others work the same */
> +#define USART1_BASE_ADDR 0x40013800
> +
> +/* See stm32l4x5_usart for definitions */
> +REG32(CR1, 0x00)
> +    FIELD(CR1, M1, 28, 1)
> +    FIELD(CR1, OVER8, 15, 1)
> +    FIELD(CR1, M0, 12, 1)
> +    FIELD(CR1, PCE, 10, 1)
> +    FIELD(CR1, TXEIE, 7, 1)
> +    FIELD(CR1, RXNEIE, 5, 1)
> +    FIELD(CR1, TE, 3, 1)
> +    FIELD(CR1, RE, 2, 1)
> +    FIELD(CR1, UE, 0, 1)
> +REG32(CR2, 0x04)
> +REG32(CR3, 0x08)
> +    FIELD(CR3, OVRDIS, 12, 1)
> +REG32(BRR, 0x0C)
> +REG32(GTPR, 0x10)
> +REG32(RTOR, 0x14)
> +REG32(RQR, 0x18)
> +REG32(ISR, 0x1C)
> +    FIELD(ISR, TXE, 7, 1)
> +    FIELD(ISR, RXNE, 5, 1)
> +    FIELD(ISR, ORE, 3, 1)
> +REG32(ICR, 0x20)
> +REG32(RDR, 0x24)
> +REG32(TDR, 0x28)
> +
> +#define NVIC_ISPR1 0XE000E204
> +#define NVIC_ICPR1 0xE000E284
> +#define USART1_IRQ 37
> +
> +static bool check_nvic_pending(QTestState *qts, unsigned int n)
> +{
> +    /* No USART interrupts are less than 32 */
> +    assert(n > 32);
> +    n -= 32;
> +    return qtest_readl(qts, NVIC_ISPR1) & (1 << n);
> +}
> +
> +static bool clear_nvic_pending(QTestState *qts, unsigned int n)
> +{
> +    /* No USART interrupts are less than 32 */
> +    assert(n > 32);
> +    n -= 32;
> +    qtest_writel(qts, NVIC_ICPR1, (1 << n));
> +    return true;

I'd suggest to change the return type to "void" and drop the "return true" here.

> +}
> +
> +/*
> + Tests should never need to sleep(), because while it might be plenty of time on a
> + fast development machine, it can cause intermittent failures due
> + to timeouts if the test is on some heavily-loaded slow CI runner.
> + */
> +static bool usart_wait_for_flag(QTestState *qts, uint32_t event_addr, uint32_t flag)
> +{
> +    /* Wait at most 10 minutes */
> +    for (int i = 0; i < 600000; i++) {
> +        if ((qtest_readl(qts, event_addr) & flag)) {
> +            return true;
> +        }
> +        g_usleep(1000);

As I recently learnt again, some systems (like some BSD kernels) still use a 
time slice resolution of 10 ms, so it might be better to g_usleep(10000) and 
adjust the loop counter to a value that is 10 times less instead, otherwise 
your loop might 100 minutes instead of 10 minutes in the worst case instead.

> +    }
> +
> +    return false;
> +}

  Thomas



