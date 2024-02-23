Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E1AC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 06:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdOn5-0004ss-EN; Fri, 23 Feb 2024 01:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdOn4-0004sK-3m
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 01:12:10 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdOn2-0006p9-0w
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 01:12:09 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a3e85a76fa8so37964666b.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 22:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708668725; x=1709273525; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Mu1jUbQ1hJ2IvsALS3VRQ0EeN+B0lzuoroT4sstyiQ=;
 b=ZOX96J0ptCoaDxBGH5/esOrM3MRo+P9zgvk7WYOnuGu3DPxRgyeKk9wB3YB6qY46dP
 5M9WUfnuGXr9KRBhZwFAm9slal0LWlMDiDkKquUyh1rZ8+7IGzHDysHLXzxWpDKtmMkr
 9HgMDqBsqCo3FVndjovFsIlQFr157aqLys3K9tnaqMznDuvCc73rb+9HZF/Oie+knwU8
 9WKzTU1YVBYixQ5hvJKmnWUoiufxlfHWvAle2dWCwi1aM9HraExLmyEValABzg4Ry0Bj
 MWuJU5jAIIYu4YbqxWxQc03S1CoQ+wZR5qNHf8Br85dLejX/scwJJFdtWfcaISpjIrzD
 hxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708668725; x=1709273525;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Mu1jUbQ1hJ2IvsALS3VRQ0EeN+B0lzuoroT4sstyiQ=;
 b=clErf8pIF5Vx8PgYs9RPQ4LD60WvdFJa+AmERGwCbk1JH++2UIwNprhD6ZonyeEH5x
 MxOCcctYXVRNPoj56EFH8cVNJ91mgC+IHGdW+Pl29+uDFiJDbe2nmIRkHfdUiwh0FKuR
 Jonb6/+GgJNhW5/Nwej1BPW99Fr03mIlHmt+kg2MXCtcFHh6Wi0zEevD8Qe4lONbElOS
 10YKx13GU5JyuKHQeDYKUQikEnUkk/itp31ftCIsIqnhxoj6I/hR3cn9oDDi3BTZQvU9
 miqym8RLVbvxhA1rgJPBOaLBobM7TbzzVA4i0KgTz7b+GA9Xji9zC4Fd4N+hOWJX3mK0
 36Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnxBntgrjWUw8t4d8jTGPTYaHtrWF/7iMrrW0/NcnFEHV/67GYpMBfND4a6klNAngFiRqeeC/ELrXtxVS6+t2HQ4Gqaf4=
X-Gm-Message-State: AOJu0Yx+EWCCwsj3heqZDKpkZLb3NlXmc8Vm4wVx/kstfA73SUsRP1/N
 oUN1oRtBj9v93pQIpYIEMwBdwlEx8uxYe2+EqpMRIfTf/c3KBhAEw08PLynlacQ=
X-Google-Smtp-Source: AGHT+IF+Pd0EUTM3OMX6B7IzcWgWuoYOOvN/kn+OIXUOCoUFWJCtyczEAH47aaxZ2I60e1rcxjTJBA==
X-Received: by 2002:a17:906:3911:b0:a3e:5a14:a2f7 with SMTP id
 f17-20020a170906391100b00a3e5a14a2f7mr522968eje.64.1708668725024; 
 Thu, 22 Feb 2024 22:12:05 -0800 (PST)
Received: from [192.168.69.100] (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 ae2-20020a17090725c200b00a3e643e61e1sm5296597ejc.214.2024.02.22.22.12.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 22:12:04 -0800 (PST)
Message-ID: <a8c904b1-ec5a-419e-99bf-159ae1413948@linaro.org>
Date: Fri, 23 Feb 2024 07:12:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] hw/i2c: Implement Broadcom Serial Controller (BSC)
Content-Language: en-US
To: Rayhan Faizel <rayhan.faizel@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, qemu-arm@nongnu.org
References: <20240220134120.2961059-1-rayhan.faizel@gmail.com>
 <20240220134120.2961059-2-rayhan.faizel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240220134120.2961059-2-rayhan.faizel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Rayhan,

On 20/2/24 14:41, Rayhan Faizel wrote:
> A few deficiencies in the current device model need to be noted.
> 
> 1. FIFOs are not used. All sends and receives are done directly.
> 2. Repeated starts are not emulated. Repeated starts can be triggered in real
> hardware by sending a new read transfer request in the window time between
> transfer active set of write transfer request and done bit set of the same.
> 
> Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
> ---
>   docs/system/arm/raspi.rst    |   1 +
>   hw/i2c/Kconfig               |   4 +
>   hw/i2c/bcm2835_i2c.c         | 278 +++++++++++++++++++++++++++++++++++
>   hw/i2c/meson.build           |   1 +
>   include/hw/i2c/bcm2835_i2c.h |  80 ++++++++++
>   5 files changed, 364 insertions(+)
>   create mode 100644 hw/i2c/bcm2835_i2c.c
>   create mode 100644 include/hw/i2c/bcm2835_i2c.h


> new file mode 100644
> index 0000000000..d6b9bf887a
> --- /dev/null
> +++ b/hw/i2c/bcm2835_i2c.c
> @@ -0,0 +1,278 @@
> +/*
> + * Broadcom Serial Controller (BSC)
> + *
> + * Copyright (c) 2024 Rayhan Faizel <rayhan.faizel@gmail.com>
> + *
> + * SPDX-License-Identifier: MIT
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/i2c/bcm2835_i2c.h"
> +#include "hw/irq.h"
> +#include "migration/vmstate.h"
> +
> +static void bcm2835_i2c_update_interrupt(BCM2835I2CState *s)
> +{
> +    int do_interrupt = 0;
> +    /* Interrupt on RXR (Needs reading) */
> +    if (s->c & BCM2835_I2C_C_INTR && s->s & BCM2835_I2C_S_RXR) {
> +        do_interrupt = 1;
> +    }
> +
> +    /* Interrupt on TXW (Needs writing) */
> +    if (s->c & BCM2835_I2C_C_INTT && s->s & BCM2835_I2C_S_TXW) {
> +        do_interrupt = 1;
> +    }
> +
> +    /* Interrupt on DONE (Transfer complete) */
> +    if (s->c & BCM2835_I2C_C_INTD && s->s & BCM2835_I2C_S_DONE) {
> +        do_interrupt = 1;
> +    }
> +    qemu_set_irq(s->irq, do_interrupt);
> +}
> +
> +static void bcm2835_i2c_begin_transfer(BCM2835I2CState *s)
> +{
> +    int direction = s->c & BCM2835_I2C_C_READ;
> +    if (i2c_start_transfer(s->bus, s->a, direction)) {
> +        s->s |= BCM2835_I2C_S_ERR;
> +    }
> +    s->s |= BCM2835_I2C_S_TA;
> +
> +    if (direction) {
> +        s->s |= BCM2835_I2C_S_RXR | BCM2835_I2C_S_RXD;
> +    } else {
> +        s->s |= BCM2835_I2C_S_TXW;
> +    }
> +}
> +
> +static void bcm2835_i2c_finish_transfer(BCM2835I2CState *s)
> +{
> +    /*
> +     * STOP is sent when DLEN counts down to zero.
> +     *
> +     * https://github.com/torvalds/linux/blob/master/drivers/i2c/busses/i2c-bcm2835.c#L223-L261

Sorry for not reviewing your patches earlier.

Since this documentation will stay for long and the Linux master branch
will change, better use a tag:
https://github.com/torvalds/linux/blob//v6.7/drivers/i2c/busses/i2c-bcm2835.c#L223-L261

Do you mind posting a patch to correct this?

Thanks,

Phil.

