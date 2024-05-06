Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F33C25B5C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 09:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3ukD-0000TL-BN; Mon, 06 May 2024 05:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3uk9-0000Qk-V6
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:34:46 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3uk7-0007CH-Qj
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:34:45 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a59a387fbc9so381341466b.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714988081; x=1715592881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kfoPd5lIV4bqhuA9i3A1ge+qoho79nPaXq5HjCBEwuQ=;
 b=qscxZZpuWpNLAzHeBgJPr8rV7EvgtXKbqOmBywz0iSIPtnv7COi0NfphGgZz6rksdy
 Gqz5vA5DGzBXNTihOw+gCVIkhcf/DNeUle8K61AYV5DTjn2rFaHKlJoOA64fXwf9MPD7
 siqcQRxoVejz6rVx/RQ0VkmmbtmSrBpnATDlqfysI/2og/zCwxcxEhuMe5PPuFdBMrph
 8nlGhvJ+YFI4tFITDmMaZw+wA6zPUgk70Krr5dzqul1fNv67Mazzkjhp3L+eg8zazWD6
 vVZfuPE7io0TkPrMnCx0x/ghsV8hK84GgJP3O3sabU1GTIfeRfOkPdRRW9KpY/QJtbgc
 tCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714988081; x=1715592881;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kfoPd5lIV4bqhuA9i3A1ge+qoho79nPaXq5HjCBEwuQ=;
 b=Wu3BtxHdeEXyNlsNJ5uSJvXCDc1OG+kkpta1/vJtlrqmED7c0Xnbq9xd+d59LfIngy
 mhEE6jsjwte/bSR4hWNImo5qDSwf+stOdlrpFVUJh96nCWSyfsOBAxL9QEz+5bshWDjF
 m48/xYlCfqcs34okRslmEh2EhmWD/BeYaboLXawiltgEoECHBJVNxWhLZ64mVozD78yz
 TKpIu4m+8DEvGTwrTH+oT2NYwz8zs6/fzrnmqHWcuKQ1mTTjoNOIQ2eV1xC7iL7Ettn4
 xk4xC6CAPJQAOh49ea+AkGyRj+76tp7vdpkNH7MKxLN2C96BfW7miVeRq32LEHmPiFD1
 vr6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZRlq2G69/coNuIl4AgDkN0fja3j4OKfyf+DheXagOrxtSDLFP5xkUiqGusDOrlbO5o6yBUef2KWBYQxJIynxxXZtYols=
X-Gm-Message-State: AOJu0YzTWXmuiW05+icjWuaJL4T5zdfz+SGGditvrRm3bnfhdWAdFY3k
 D7baodSvQGUlTw887QQX7Zf4Yiqa8CkyGtripxAn0FXnZHLpYaB28SXtH+Tgf5A=
X-Google-Smtp-Source: AGHT+IEH0xvvW9WbqM1rgaFNxQzM57dtnx1fZ23stmlO86FlL43JQO0X6z1U0Dkcm+5c//aeeTuoZQ==
X-Received: by 2002:a50:bac6:0:b0:570:c8f:1a35 with SMTP id
 x64-20020a50bac6000000b005700c8f1a35mr5812355ede.8.1714988081223; 
 Mon, 06 May 2024 02:34:41 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a056402241900b005725de35790sm4977627eda.61.2024.05.06.02.34.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 02:34:40 -0700 (PDT)
Message-ID: <06e98554-3430-49d5-94f3-c5d683327f55@linaro.org>
Date: Mon, 6 May 2024 11:34:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/char: Add QOM property for STM32L4x5 USART clock
 frequency
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20240505140556.373711-1-ines.varhol@telecom-paris.fr>
 <20240505140556.373711-4-ines.varhol@telecom-paris.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240505140556.373711-4-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Hi,

On 5/5/24 16:05, Inès Varhol wrote:
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   hw/char/stm32l4x5_usart.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
> index fc5dcac0c4..ee7727481c 100644
> --- a/hw/char/stm32l4x5_usart.c
> +++ b/hw/char/stm32l4x5_usart.c
> @@ -26,6 +26,7 @@
>   #include "hw/clock.h"
>   #include "hw/irq.h"
>   #include "hw/qdev-clock.h"
> +#include "qapi/visitor.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/qdev-properties-system.h"
>   #include "hw/registerfields.h"
> @@ -523,6 +524,14 @@ static Property stm32l4x5_usart_base_properties[] = {
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> +static void clock_freq_get(Object *obj, Visitor *v,
> +    const char *name, void *opaque, Error **errp)
> +{
> +    Stm32l4x5UsartBaseState *s = STM32L4X5_USART_BASE(obj);
> +    uint32_t clock_freq_hz = clock_get_hz(s->clk);
> +    visit_type_uint32(v, name, &clock_freq_hz, errp);
> +}
> +
>   static void stm32l4x5_usart_base_init(Object *obj)
>   {
>       Stm32l4x5UsartBaseState *s = STM32L4X5_USART_BASE(obj);
> @@ -534,6 +543,9 @@ static void stm32l4x5_usart_base_init(Object *obj)
>       sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>   
>       s->clk = qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
> +
> +    object_property_add(obj, "clock-freq-hz", "uint32",
> +                        clock_freq_get, NULL, NULL, NULL);

Patch LGTM, but I wonder if registering QOM getter without setter
is recommended. Perhaps we should encourage parity? In normal HW
emulation we shouldn't update this clock externally, but thinking
about testing, this could be interesting to introduce jitter.

Any opinion on this?

>   }
>   
>   static int stm32l4x5_usart_base_post_load(void *opaque, int version_id)


