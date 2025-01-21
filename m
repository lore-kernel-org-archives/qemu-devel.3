Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1002CC02185
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 10:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taB7z-00023i-Dy; Tue, 21 Jan 2025 05:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taB7r-000232-2Q
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:04:52 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taB7o-0006Nv-Vf
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:04:50 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436202dd730so38815045e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 02:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737453885; x=1738058685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oi5qgMTu/ZAxx+q617u3c2iEOapJpSIjFiucd7b+efw=;
 b=W9oOpwaJSWOsC8d+8FlQOSezLMa1uiiuTnQ0inF49B4jiHBd9xLJcC6ExPquDb85He
 MspwVXRmB6zMbf9JnRsw4NbLO1ubNHUdPHWDRhOI5YFxYKG5kmeYCoxxNI2kgzmeC63U
 5zEFXgD5fUlpK4N5jqX1//2hijYi7GdRc+YKawNiHf8lYpUA4OODHT4njLGSqvmSshly
 IoAI1zUnXVHs7qsivusHeuRlG61iJDhfd/TEZwv9HlPgPhmCYsHS/l9rwrNGkskVErej
 1x3eifQ8tUIVHb6fFLjuT5HZdK7hsIeEI6LVG56r/6Js6bNdk8gcf20nOm2bZ5whU9Vt
 RcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737453885; x=1738058685;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oi5qgMTu/ZAxx+q617u3c2iEOapJpSIjFiucd7b+efw=;
 b=jnBLagvQT0xSRXHvUFCkemsuWGGKY2pvNaoFtAba4gbRD6yTbBsvPfJsh6o1Zj3JyR
 uu+NsuTf5lWonYkySt2dz6OoeMnsb1uF4yYPCW1zP9Tivd+z4RPsCZjsReg1kS0Zhktw
 K8Jk4R/5kU1Oy76cvFYkTd5nnqAGFvw8Ag6cbDsezmH0dow9VDCAQvmAW5cuo+B+t2QE
 Dq2CT+kOhLqYRpVikG1TyUoaMsSxtcAINsm6y1tCN9xh1ErmB06Pfo1AOKtI2cjOtwZ7
 dTf8zEw6WDhDsEcNidWLCFjQoLCVRnXyGHw+HfVdYWTIXRWdWtjgJvXC3P5ReHGiV3Vb
 9xgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOzi/gF/LB5SANx+vWYXTkh0y1iNvYhfnHY47NYUGBbnP8i6uw+u+hHgVYLlKHJqujSwbzXHseIYxH@nongnu.org
X-Gm-Message-State: AOJu0YwPQ7Y5pD8MGxTP6ZdyyZJWTvg+pkAD8pr8B176Wkmd1PJtByHO
 bGiLS7hAmmUJPM/w5ZSK+/OtMSzX9Xk41IsOjn82yIxA5m7MMlKhhhrYqrlaDI8=
X-Gm-Gg: ASbGncudAJtrnTcXebEqbL8zqz6dlSyZRM/tRIprarid9ne9Ug5PAiXLBMNYqwZF56f
 THJ6x2Jgs+kbkvc7yHPAlc97QyCczThasST13Gf5mrNxldm0TFiKao7iutAAz/Vk7ZzTzzU5lEg
 5v7gmqro7AhnePPO/cC/p3sCiymUN4Q2L3cbisK6cRxthp6Dcs6T1d115q34b0uqUoGh64h2/8k
 nkrHAND5xqcGmUhDUXgLNFP6IO7ub8ApHr5AnfIl0JfVqQfdamACtbueS/ulITHPM4Kkm0Vx3y/
 h0b46ekzw/yv2Gk25I472FzmiSzOJ2uY9FHyyg==
X-Google-Smtp-Source: AGHT+IHJXB9PAJoV49VS0XQIY9Fugc0ej56AYt33jI/WKL3aaqmc6OrRiSYlakArIhm2LCLdlIE5Xg==
X-Received: by 2002:a05:600c:4713:b0:434:fb65:ebbb with SMTP id
 5b1f17b1804b1-438913f1654mr162631955e9.17.1737453884810; 
 Tue, 21 Jan 2025 02:04:44 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c753cc1fsm236924805e9.39.2025.01.21.02.04.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 02:04:44 -0800 (PST)
Message-ID: <a301444f-623e-4ba3-9868-b301f6e86a87@linaro.org>
Date: Tue, 21 Jan 2025 11:04:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/ipack: Remove legacy qemu_allocate_irqs() use
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250121084452.81941-1-philmd@linaro.org>
 <20250121084452.81941-3-philmd@linaro.org>
 <27522A5D-63E7-45B7-8A54-A19E453AB401@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <27522A5D-63E7-45B7-8A54-A19E453AB401@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 21/1/25 10:24, Bernhard Beschow wrote:
> 
> 
> Am 21. Januar 2025 08:44:52 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> No need to dynamically allocate IRQ when we know before hands
>> how many we'll use. Declare the 2 of them in IPackDevice state
>> and initialize them in the DeviceRealize handler.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> include/hw/ipack/ipack.h | 7 ++-----
>> hw/char/ipoctal232.c     | 4 ++--
>> hw/ipack/ipack.c         | 7 +++----
>> hw/ipack/tpci200.c       | 6 +++---
>> 4 files changed, 10 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/hw/ipack/ipack.h b/include/hw/ipack/ipack.h
>> index cbcdda509d3..00f397fd020 100644
>> --- a/include/hw/ipack/ipack.h
>> +++ b/include/hw/ipack/ipack.h
>> @@ -12,6 +12,7 @@
>> #define QEMU_IPACK_H
>>
>> #include "hw/qdev-core.h"
>> +#include "hw/irq.h"
>> #include "qom/object.h"
>>
>>
>> @@ -19,10 +20,8 @@
>> OBJECT_DECLARE_SIMPLE_TYPE(IPackBus, IPACK_BUS)
>>
>> struct IPackBus {
>> -    /*< private >*/
>>      BusState parent_obj;
>>
>> -    /* All fields are private */
>>      uint8_t n_slots;
>>      uint8_t free_slot;
>>      qemu_irq_handler set_irq;
>> @@ -58,13 +57,11 @@ struct IPackDeviceClass {
>> };
>>
>> struct IPackDevice {
>> -    /*< private >*/
>>      DeviceState parent_obj;
>> -    /*< public >*/
>>
>>      int32_t slot;
>>      /* IRQ objects for the IndustryPack INT0# and INT1# */
>> -    qemu_irq *irq;
>> +    IRQState irq[2];
>> };
>>
>> extern const VMStateDescription vmstate_ipack_device;
>> diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
>> index d1e5f6dad2e..a2879977fb3 100644
>> --- a/hw/char/ipoctal232.c
>> +++ b/hw/char/ipoctal232.c
>> @@ -184,9 +184,9 @@ static void update_irq(IPOctalState *dev, unsigned block)
>>      unsigned intno = block / 2;
>>
>>      if ((blk0->isr & blk0->imr) || (blk1->isr & blk1->imr)) {
>> -        qemu_irq_raise(idev->irq[intno]);
>> +        qemu_irq_raise(&idev->irq[intno]);
>>      } else {
>> -        qemu_irq_lower(idev->irq[intno]);
>> +        qemu_irq_lower(&idev->irq[intno]);
>>      }
>> }
>>
>> diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
>> index ed75f791832..eeb48dd331c 100644
>> --- a/hw/ipack/ipack.c
>> +++ b/hw/ipack/ipack.c
>> @@ -55,22 +55,21 @@ static void ipack_device_realize(DeviceState *dev, Error **errp)
>>      }
>>      bus->free_slot = idev->slot + 1;
>>
>> -    idev->irq = qemu_allocate_irqs(bus->set_irq, idev, 2);
>> +    for (int i = 0; i < ARRAY_SIZE(idev->irq); i++) {
>> +        qemu_init_irq(&idev->irq[i], bus->set_irq, idev, i);
> 
> I wonder if we eventually need a qemu_init_irqs() (note the plural) as we remove further uses of qemu_allocate_irqs().

Yeah I thought about it, but looking at other "Initialize pre-allocated
QOM object in place", we don't have helpers for arrays. Usually because
we can set properties, and array initializer doesn't scale then.

For now IRQ doesn't have properties, so can do.

> With the above addressed:
> Reviewed-by: Bernhard Beschow <shentey@gmail.com>

Thanks!

