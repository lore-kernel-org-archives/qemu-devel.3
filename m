Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D8FC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjRw-0005cM-0A; Fri, 22 Mar 2024 14:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnjRn-0005ZJ-SO
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:16:56 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnjRg-00083Z-DC
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:16:51 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56890b533aaso3001610a12.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711131403; x=1711736203; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stdoSV9ntZpVzVEx7ecukiuBxB08z1i9BkzJV8hxl/0=;
 b=RYHy9qBI5tM4+iUlIOahGvPrd4EMnaaPazJQqe2rnharrmj0Rn4uKh2UkYa3jpVFGb
 znqL7vM+jBACoS4hZvhbIE1/TYiPG7yXFkkgXHbHRch7Aij5BoULRa/IxPHN2Ud242pH
 1GslWRh01UdhZSh6PLKOLimQ5WxnBAObg+N0ZTKKdpEoi4LjviSRFg7PXpqczNUa8v2k
 LcoqEL2oqW4eQBBtKrQLuFjTIwKpX2ViYFCLbOqJ0aP3pMlKfU9CDPYkKtz8U0k7lLCA
 sAi3q7Xb5dwjMMjrJv5et08zEz3WpvDn60PWfxyRvIXgZi6DOrmMmB5OmfRO+HrJUoPr
 f51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131403; x=1711736203;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=stdoSV9ntZpVzVEx7ecukiuBxB08z1i9BkzJV8hxl/0=;
 b=RPg6BUnHea6BWa5f+96CeCvatHtZagjjPWNRPOeQjCL6ogmFzn+EmT6UpOVK7MBbVv
 fPVBnGRuLkdci0myj7I6fHY28hXYlSHGUPbaiNUUwgHizwHIpXUQ+fziZN6zZvAjmDib
 hmp3B531WWaRRsVN7glbCULFXbUF0GG8g6HtMMau1mSOtOekxUeCylso5XXoppDFUc9M
 Y1D+lRX/GZ6/NIJdf6T4QMQnkBUHbHmA3pm5McblMFJkzEuDA+WbAlNY1cPeD+A8POf2
 xSdsSfwFx6GO68PzhOqxjbz950NZdOAwhScBirCEH2M8eDAdfaPCFya6OxAl5AC07jlz
 nL5w==
X-Gm-Message-State: AOJu0YzyifqNB39r/qF2BM0ZUO3+c7uyxSWqPX9EYV5iEDI0E6Fvw27z
 TAxkb25Ae/w2RjAvoazoKmLUmmid819iiEh13RlvRZDpVl0p12P9HDZy83Y8VP8PsZxGDy9dVvY
 l8yTj87Lka+RlirLhdvPcA1zvnZOk+e+obs8NLA==
X-Google-Smtp-Source: AGHT+IFptiuLSPSGbYBXGwmJ7Q7QjxVYjapjmrxVMPKXgTngjcg6a5uzO+HA3/RVPIxhnQuAnuKOFyKl0uc1xrsosHk=
X-Received: by 2002:a50:d5d5:0:b0:567:504e:e779 with SMTP id
 g21-20020a50d5d5000000b00567504ee779mr206413edj.25.1711131402884; Fri, 22 Mar
 2024 11:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240317103918.44375-1-arnaud.minier@telecom-paris.fr>
 <20240317103918.44375-8-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240317103918.44375-8-arnaud.minier@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 18:16:32 +0000
Message-ID: <CAFEAcA8KjiaBHpMYQXrTBV3xG4Paqx82v6iFms_i2jwO2i2Fsg@mail.gmail.com>
Subject: Re: [PATCH 7/7] tests/qtest: Add tests for the STM32L4x5 USART
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Sun, 17 Mar 2024 at 10:42, Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
>
> Test:
> - read/write from/to the usart registers
> - send/receive a character/string over the serial port
>
> The test to detect overrun is implemented but disabled
> because overruns are currently impossible due to how we signal
> in the USART when we are ready to receive a new character.
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---



> --- /dev/null
> +++ b/tests/qtest/stm32l4x5_usart-test.c
> @@ -0,0 +1,399 @@
> +/*
> + * QTest testcase for STML4X5_USART
> + *
> + * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest-single.h"
> +#include "hw/misc/stm32l4x5_rcc_internals.h"
> +#include "hw/registerfields.h"
> +
> +/*
> + * All page references in the following test
> + * refer to the ST RM0351 Reference Manuel.

"Manual". Also, what page references? I couldn't see any
from a quick scroll through.


> + */
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
> +    if (n < 32) {
> +        return false;
> +    }

I think this would be better as an assert() -- it would be
a bug in the test case if it called this with a bad interrupt number.

> +    n -=3D 32;
> +    return qtest_readl(qts, NVIC_ISPR1) & (1 << n);
> +}
> +
> +static bool clear_nvic_pending(QTestState *qts, unsigned int n)
> +{
> +    /* No USART interrupts are less than 32 */
> +    if (n < 32) {
> +        return false;
> +    }

Similarly here.

> +    n -=3D 32;
> +    qtest_writel(qts, NVIC_ICPR1, (1 << n));
> +    return true;
> +}
> +
> +static void usart_writel(unsigned int offset, uint32_t value)
> +{
> +    writel(USART1_BASE_ADDR + offset, value);
> +}
> +
> +static uint32_t usart_readl(unsigned int offset)
> +{
> +    return readl(USART1_BASE_ADDR + offset);
> +}
> +
> +static bool usart_wait_for_flag(QTestState *qts, uint32_t event_addr, ui=
nt32_t flag)
> +{
> +    /* Wait at most 5 seconds */
> +    for (int i =3D 0; i < 5000; i++) {
> +        if ((qtest_readl(qts, event_addr) & flag)) {
> +            return true;
> +        }
> +        g_usleep(1000);
> +    }

qtest tests should never need to sleep(). If you need to advance
the guest clock, use clock_step(). If this is because we've sent some
data to the UART over the socket and need to wait for it to appear
in the QEMU process, that might be trickier, but I would see if
advancing the guest clock works reliably for that.

In general having tests which encode "wait for some wallclock
time" is flaky, because while it might be plenty of time on your
fast development machine, it can cause intermittent failures due
to timeouts if the test is on some heavily-loaded slow CI runner.

I note that the microbit version of this "wait for the UART"
has a timeout of 10 minutes.

> +
> +    return false;
> +}



> +int main(int argc, char **argv)
> +{
> +    int ret;
> +
> +    g_test_init(&argc, &argv, NULL);
> +    g_test_set_nonfatal_assertions();
> +
> +    qtest_add_func("stm32l4x5/usart/write_read", test_write_read);
> +    qtest_add_func("stm32l4x5/usart/receive_char", test_receive_char);
> +    qtest_add_func("stm32l4x5/usart/send_char", test_send_char);
> +    qtest_add_func("stm32l4x5/usart/receive_str", test_receive_str);
> +    qtest_add_func("stm32l4x5/usart/send_str", test_send_str);
> +    /* Disabled tests */
> +    if (false) {
> +        qtest_add_func("stm32l4x5/usart/overrun", test_overrun);
> +    }

If the test doesn't work because QEMU's implementation never
generates overruns, I would just not put it in the file, rather
than having dead code we never run.

> +    qtest_start("-machine b-l475e-iot01a");
> +    ret =3D g_test_run();
> +    qtest_end();
> +
> +    return ret;
> +}

thanks
-- PMM

