Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C24C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 09:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3unp-0002Hd-5D; Mon, 06 May 2024 05:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3unl-0002HB-Nf
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:38:31 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3unh-000862-2W
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:38:27 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41b794510cdso13842635e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 02:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714988303; x=1715593103; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+1MGiyuXYSBdOFTKlxKUlXpn2qOa/nnvW/VJpw7fIJY=;
 b=BVfQMwEfy5f1oZHNvoRA+fSf+rr1ihycpCwIEpM3puLLdS/ekMmJrdJYE+qLtCyPFQ
 2C+keruZ7rPIIPPUh9giLTIdfjybtXzze5qLdYzjeqqCU3qcOc74BKOorzK13eCvfscD
 A9j4EBYW5mEyv29g3bxcQi1Qifzc7dJNbdhfRg63PS74e6NVl9iUGH8Ekj58BkHspQM2
 L3vzWW0FPPVLQs7/JVv8rPMGd8QmhY9DaLmMQHf3n63wvOtP7RSAyjSBQgjN0+HvjyO1
 xTgjy/MetfOkMkIJDDOVsP/31ZlkFCgu/w9b/Ga64/jLBOh+mbO9ZS2rPTWd56tBkX5l
 eabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714988303; x=1715593103;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+1MGiyuXYSBdOFTKlxKUlXpn2qOa/nnvW/VJpw7fIJY=;
 b=PPoVN3bgg9zMQydR4H3saH50pjuk3rFE3uDQs8Gj8UEGMgsNeYz1g6WD/8vNrCb2Et
 zoKc3wr1q8ECv9LvGi/Awn1ab3gSnqzNPi3iju1N+GgD7td0XDDW8z0C8wHPUMlcxrP+
 17+/Ps9ZvlNLIHBHtFH40HgcUOIWbT1yDtjU4aKqIYpud2XSpK5qhce1/EeZqukjs1rJ
 2OcTkTQBdQpqaoTxSZjGn3mSPBENA85+lBeSqvRbDyM2VkTb2ofPmBQlCwvYcFQ9TO3Z
 6AgvbmY8jyp0MlqsKOnuKVSKbnrezUi9pgGtw0ReQD/hRyvgDgvnEaeBygKiO90XHxtS
 8oYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtk3NrOwGjkz9JJFdWf4zP+tXdmTy0WA54tpnDYF7a41g9o8ekFkaRvtRjBfPOvGbKU1bo6qGK8BFJrFKUEEVWX6pRrDw=
X-Gm-Message-State: AOJu0YwmSns5IYFC47emoe/UO9r1GDrmH8LwZ5hBQIrCmplIvqGo3k45
 9QIS19Do+19fwT1ZWmclcxPp3hlQAZBYJGLA93+Hs6aZuGgopfWj3tFFjhOqXvE=
X-Google-Smtp-Source: AGHT+IGWKoOdkI1Y5j2Rxd0HJnHd3Ejb02ZN4FcOobcsGhOR4hIOAtmfPIPm1R/Ob+D+CiZDvEn49Q==
X-Received: by 2002:a05:600c:444c:b0:417:fbc2:caf8 with SMTP id
 v12-20020a05600c444c00b00417fbc2caf8mr6902151wmn.23.1714988302904; 
 Mon, 06 May 2024 02:38:22 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 g19-20020a05600c311300b0041496734318sm19218482wmo.24.2024.05.06.02.38.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 02:38:22 -0700 (PDT)
Message-ID: <16596e82-46fb-43ca-92ba-dfbfa7bf560e@linaro.org>
Date: Mon, 6 May 2024 11:38:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/gpio: Handle clock migration in STM32L4x5 gpios
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240505140556.373711-1-ines.varhol@telecom-paris.fr>
 <20240505140556.373711-3-ines.varhol@telecom-paris.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240505140556.373711-3-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 5/5/24 16:05, Inès Varhol wrote:

Fixes: 1cdcfb6e93 ("hw/gpio: Implement STM32L4x5 GPIO")

> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   hw/gpio/stm32l4x5_gpio.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/gpio/stm32l4x5_gpio.c b/hw/gpio/stm32l4x5_gpio.c
> index 71bf5fddb2..14e6618d30 100644
> --- a/hw/gpio/stm32l4x5_gpio.c
> +++ b/hw/gpio/stm32l4x5_gpio.c
> @@ -20,6 +20,7 @@
>   #include "qemu/log.h"
>   #include "hw/gpio/stm32l4x5_gpio.h"
>   #include "hw/irq.h"
> +#include "hw/clock.h"
>   #include "hw/qdev-clock.h"
>   #include "hw/qdev-properties.h"
>   #include "qapi/visitor.h"
> @@ -441,6 +442,7 @@ static const VMStateDescription vmstate_stm32l4x5_gpio = {
>           VMSTATE_UINT32(ascr, Stm32l4x5GpioState),
>           VMSTATE_UINT16(disconnected_pins, Stm32l4x5GpioState),
>           VMSTATE_UINT16(pins_connected_high, Stm32l4x5GpioState),
> +        VMSTATE_CLOCK(clk, Stm32l4x5GpioState),

IIUC we need to increase vmstate_stm32l4x5_gpio version_id (see
commit 8fd34dc0c4 "hw/arm/armsse: Wire up clocks" for example).

>           VMSTATE_END_OF_LIST()
>       }
>   };


