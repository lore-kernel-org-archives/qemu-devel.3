Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434DFE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaCT-0003oi-2F; Fri, 20 Dec 2024 05:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOaCR-0003oJ-De
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:25:39 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOaCP-0007nZ-Pn
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:25:39 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361f796586so18239415e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 02:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734690335; x=1735295135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2UzE0euSl0tJtXtQ85xngC+JKg6+SMV8rtbtI4ia8oA=;
 b=gicbAjtS33TovH011asaSxKDI85LB07eoM56/MRISOYPpFi+Vm3g+u5Sr6fJf2wWqF
 Z3knbpGAyXOXdxBB/x3RMLKfl/4zKlGTDWn55kHksQK6q9eDNIWosL5ZmDXoJ985vGXD
 LU5rMdOAT1yKmc9+2k880MjDZSwyaQPdkBii3CLMEOuY26oh261SNcaWYr9cl/MTXdEo
 HzHIM/qFo9vg9fsj7JM5dCZ7XVdIyzj1ViWLwpf6PLfUXxeDmR+UJbj2W8zRbr50e7im
 lcsCB2Mnk5HoM2x4Ioikensm888qpTeopjlcYXXi/SH8KQ8GgUlgzniNuaGMVOAQTz6Z
 4YNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734690335; x=1735295135;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2UzE0euSl0tJtXtQ85xngC+JKg6+SMV8rtbtI4ia8oA=;
 b=IFmERO1CKHHAXCcHYYFYP0Anow7gl0Mug3/Ja7ty7wRQoh1zUZHV3FMKkrC8wkwVB1
 kcgs+lsxDWxvZlGIXQ2ptd28h76Wgp67GZxuqIM3Xkg829p7pFTTIJpQgMjv9DSYjz8k
 yo91bKYDRiB0qc5Vk26pJGLkXlt3Z1F+NdYroYoVPmwLEo9qswamu5t06xdcC+D8JCcN
 juDsasfhck2l8SgWGeVb2D2QjKGePLLko6XSRbEowfrqrWyPHWvjsYxYZ7VMpGu/45Ti
 BwRcgptf4nz8Sr7uK41Ih3Rcyzjy/t4rmBHSSFRhwnOWPgC4kZ5YzBs9Vky3Vu7wCvl5
 e2Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkGBO6nL0xKEHPzxcUsWZVOnfSJppraSO+vh6P+VmhhuZn8idaSwbJQAwMERI5pILsc18IQc/Ee3sx@nongnu.org
X-Gm-Message-State: AOJu0Yya/L5BmML9PKruiyP3+gGNdqavwRjkaMRx3SY3My5PDe/CBdGp
 NxoHHZrqi0he0pskAbuUODIQb3H/tRrX6txGnsYg1FvhLtpj6ZoaiOLxomoR+b0=
X-Gm-Gg: ASbGnctjQJB9DkFNejVRtrfDnDeknG8RbFSh0i1KBsF1JIZ3Slx9BFqkOqX7eU0Rpil
 /rpEV+kx6QarkBm6POe646vCyDI0BJRVxp/WDtJPk55ymA7IZsvfSS6Ud/cz2iqt2npDjsidEOG
 UMd0/4sgtAstRxMOn3TEiFBfRzU1eay5iWk/AZe3jPwiwpCG0WpSLq8iF/zX+NY9Ms2FoaS/+1E
 tiq7fM1+6LvgiLu4KOUDEjonoxTO9pnF8Z8wQNmxGnJlHVMAO1B3w5BsrDyuYzWlf33CP0=
X-Google-Smtp-Source: AGHT+IFu4kPTZ15V2eOQbT9CkyXjCpnUGG3M1uaNd5/Yo0m3OS0ea2+fH240iGv4oi6ciIW7mCysGQ==
X-Received: by 2002:a05:600c:4709:b0:436:1ac2:1acf with SMTP id
 5b1f17b1804b1-43668a3a35dmr17378285e9.20.1734690335359; 
 Fri, 20 Dec 2024 02:25:35 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366e210cecsm6001875e9.2.2024.12.20.02.25.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 02:25:34 -0800 (PST)
Message-ID: <b266d634-d922-4402-aa28-1096d19e07ba@linaro.org>
Date: Fri, 20 Dec 2024 11:25:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char: stm32f2xx_usart: replace print with trace
To: Nikita Shubin <nikita.shubin@maquefel.me>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Nikita Shubin <n.shubin@yadro.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20241220084623.1889-1-nikita.shubin@maquefel.me>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241220084623.1889-1-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Hi Nikita,

On 20/12/24 09:46, Nikita Shubin wrote:
> From: Nikita Shubin <nshubin@yadro.com>
> 
> Drop debug printing macros and replace them with according trace
> functions.
> 
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
> ---
>   hw/char/stm32f2xx_usart.c | 47 ++++++++++++++++++---------------------
>   hw/char/trace-events      |  6 +++++
>   2 files changed, 28 insertions(+), 25 deletions(-)


>   static int stm32f2xx_usart_can_receive(void *opaque)
>   {
> @@ -67,10 +57,11 @@ static void stm32f2xx_update_irq(STM32F2XXUsartState *s)
>   static void stm32f2xx_usart_receive(void *opaque, const uint8_t *buf, int size)
>   {
>       STM32F2XXUsartState *s = opaque;
> +    DeviceState *d = DEVICE(s);
>   
>       if (!(s->usart_cr1 & USART_CR1_UE && s->usart_cr1 & USART_CR1_RE)) {
>           /* USART not enabled - drop the chars */
> -        DB_PRINT("Dropping the chars\n");
> +        trace_stm32f2xx_usart_drop(d->id);
>           return;
>       }
>   
> @@ -79,7 +70,7 @@ static void stm32f2xx_usart_receive(void *opaque, const uint8_t *buf, int size)
>   
>       stm32f2xx_update_irq(s);
>   
> -    DB_PRINT("Receiving: %c\n", s->usart_dr);
> +    trace_stm32f2xx_usart_recieve(d->id, *buf);

Typo "receive".

>   }
>   
>   static void stm32f2xx_usart_reset(DeviceState *dev)
> @@ -101,49 +92,55 @@ static uint64_t stm32f2xx_usart_read(void *opaque, hwaddr addr,
>                                          unsigned int size)
>   {
>       STM32F2XXUsartState *s = opaque;
> +    DeviceState *d = DEVICE(s);
>       uint64_t retvalue;

'retvalue' should be initialized ...

>   
> -    DB_PRINT("Read 0x%"HWADDR_PRIx"\n", addr);
> -
>       switch (addr) {
>       case USART_SR:
>           retvalue = s->usart_sr;
>           qemu_chr_fe_accept_input(&s->chr);
> -        return retvalue;
> +        break;
>       case USART_DR:
> -        DB_PRINT("Value: 0x%" PRIx32 ", %c\n", s->usart_dr, (char) s->usart_dr);
>           retvalue = s->usart_dr & 0x3FF;
>           s->usart_sr &= ~USART_SR_RXNE;
>           qemu_chr_fe_accept_input(&s->chr);
>           stm32f2xx_update_irq(s);
> -        return retvalue;
> +        break;
>       case USART_BRR:
> -        return s->usart_brr;
> +        retvalue = s->usart_brr;
> +        break;
>       case USART_CR1:
> -        return s->usart_cr1;
> +        retvalue = s->usart_cr1;
> +        break;
>       case USART_CR2:
> -        return s->usart_cr2;
> +        retvalue = s->usart_cr2;
> +        break;
>       case USART_CR3:
> -        return s->usart_cr3;
> +        retvalue = s->usart_cr3;
> +        break;
>       case USART_GTPR:
> -        return s->usart_gtpr;
> +        retvalue = s->usart_gtpr;
> +        break;
>       default:
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
>           return 0;
>       }
>   
> -    return 0;
> +    trace_stm32f2xx_usart_read(d->id, size, addr, retvalue);
> +
> +    return retvalue;

... since you return here.

Otherwise, the patch looks good!

Regards,

Phil.

>   }


