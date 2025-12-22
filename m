Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324B1E6748D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 09:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXcDv-0002HC-VF; Mon, 22 Dec 2025 04:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vXcDt-0002H4-TS
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 04:29:01 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vXcDs-0004Fi-0i
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 04:29:01 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42fed090e5fso1732906f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 01:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766395737; x=1767000537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PjxJFqzKoeh4A0AI6V3nUXIKX6SEWaXRIaS/f1zZrFU=;
 b=D4WxQHfx0pBskeU6bGs0Ugxk4fYbN0FEeo4q4AfcWe5gRIB6l/BUtOmIjUfH/NPhXA
 fCMgCmoOGYVR99tMbGBv9HrbNjx/G15C8E0GFqQQAUbuJgY+fl6J6rSzaiIy73QZnC4l
 60fFwuXWVfOqjOB3+qP7J+Uac0BjZBSVfCOjOcYRly37Go9nw6mWe4S4zZFdDS9z20fD
 fBkxSPEmQRRt16K/5NTTILUOEfqIA9csQjCH425U1xhbH0BuIwJFGSasoUE1caa4L/XP
 LRR2wEKIqdpxfLvbFWpE8eOx8qjaQ/ibKxpHbDD4mxtKN3Z+L/z6q9LRZdvxYRDkvi1P
 Sj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766395737; x=1767000537;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PjxJFqzKoeh4A0AI6V3nUXIKX6SEWaXRIaS/f1zZrFU=;
 b=a/em39VgXYk8DVX2mL5tBzMQhHoH/PdO9ksHg1B43uxU4S4mTLjvNyyZ+H7emQhMfg
 a+9NY2eoNe0fNPsXwVbzw7rLfPBeFWMVxKQ5eNojtWYcCjAVcHSNOfShN6uXoN+XxiOX
 +6d89d7Q9xowVlYzTkFR2NUNoRQs2fdOm47hAbTMvG9VU3dmpNV0PxRs5cw7iGqC6A1k
 JN/S1mEDcPh459SopC5i7GpiKZaAYh9KfEEcFpiTf2xO5YRbl6APbkwrSQpzMzyBw2IH
 F3LGUWg1k+YpK0x9r6pssuA7MdHwVPPQPpGjn+vrTUzIHbLipqHEwU+6bbgX7laHcHmQ
 9Zig==
X-Gm-Message-State: AOJu0Yyw+e4BZBOvZAwdBswuXNz6kDMxGQ1/85QKyXfvDUIa1N/6kuLg
 yGEuyTgyvA1pcUNmVZY8X3up4RDJFyKpr6dh9tQftfhT/E9mLoEOE6PPxXdbmMcxq1WzmSrJXyN
 3kHeULns=
X-Gm-Gg: AY/fxX5nCCJvYtulJTB8dOVSoBwak6DO4f5S0AVDA06SHimuif6XGDC8+4DWvLOi8va
 6R1jOAh4neariU4Vev5GULPxku5Sf3wJxdsGrM4WeusPYyq/MFAqpu1XDRP8T1+5J7fX3RldDgl
 Dxm5A5D2Ve8ffFbztiW4krL+GizjrQ4HHja5Cc2bMkmjvnehrIoB4RrFGa8S+ObHmyIgoFvdlFX
 IdRXXBqQNAkt7exEusKGmAulyGpz9n8hSn+lXF6Ns1gKzdCPYEkKVQDnkrpTLQpQuOWeuSTWDed
 AbDno4AFrVJIl/sNb2Eq8zIgAb/2g0aRcxSQwec1Dczv1GfdhPzJ5liSzGPRxLiONGH55Wlvy+7
 aeNB5FxFkXZjk5ssLVCskryu5UvnlGBm3chc0bmKgCFeS2WVHuHaAraOn86058MHpsNEzU21XNL
 nJE43rBYG7uFt5YkHKAUkAsSb5IovRheJnVQoIr6nA5HEveLSSJoJ0ag==
X-Google-Smtp-Source: AGHT+IG0tUyNinS1FvnGPABwefUip4sPmn9H3iOhJzVYR5QmfM97Iwsh33un4O3K+QHTcYKG1lEKLg==
X-Received: by 2002:a05:6000:310e:b0:430:feb3:f5b4 with SMTP id
 ffacd0b85a97d-4324e70117emr9680142f8f.59.1766395737355; 
 Mon, 22 Dec 2025 01:28:57 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm21007680f8f.42.2025.12.22.01.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Dec 2025 01:28:56 -0800 (PST)
Message-ID: <fd3ee75b-c1ef-44e8-999e-0f7adf8529e7@linaro.org>
Date: Mon, 22 Dec 2025 10:28:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/41] hw/misc/pvpanic: Add MMIO interface
Content-Language: en-US
To: qemu-devel@nongnu.org, Alexander Graf <graf@amazon.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Thomas Huth <thuth@redhat.com>
References: <20250305012157.96463-1-philmd@linaro.org>
 <20250305012157.96463-3-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250305012157.96463-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Hi Alex, Phil,

On 5/3/25 02:21, Philippe Mathieu-Daudé wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> In addition to the ISA and PCI variants of pvpanic, let's add an MMIO
> platform device that we can use in embedded arm environments.

We neglected to specify the endianness of this device. As other
variantes are little-endian and I presume the "embedded arm" is
also using little endianness, is it safe to declare it also in
little endian order, following the PCI_DEVICE_ID_REDHAT_PVPANIC
definition?

> Signed-off-by: Alexander Graf <graf@amazon.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Message-ID: <20241223221645.29911-8-phil@philjordan.eu>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/misc/pvpanic.h |  1 +
>   hw/misc/pvpanic-mmio.c    | 60 +++++++++++++++++++++++++++++++++++++++
>   hw/misc/Kconfig           |  4 +++
>   hw/misc/meson.build       |  1 +
>   4 files changed, 66 insertions(+)
>   create mode 100644 hw/misc/pvpanic-mmio.c
> 
> diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
> index 9a71a5ad0d7..049a94c1125 100644
> --- a/include/hw/misc/pvpanic.h
> +++ b/include/hw/misc/pvpanic.h
> @@ -26,6 +26,7 @@
>   
>   #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
>   #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
> +#define TYPE_PVPANIC_MMIO_DEVICE "pvpanic-mmio"
>   
>   #define PVPANIC_IOPORT_PROP "ioport"
>   
> diff --git a/hw/misc/pvpanic-mmio.c b/hw/misc/pvpanic-mmio.c
> new file mode 100644
> index 00000000000..70097cecc74
> --- /dev/null
> +++ b/hw/misc/pvpanic-mmio.c
> @@ -0,0 +1,60 @@
> +/*
> + * QEMU simulated pvpanic device (MMIO frontend)
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/qdev-properties.h"
> +#include "hw/misc/pvpanic.h"
> +#include "hw/sysbus.h"
> +#include "standard-headers/misc/pvpanic.h"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(PVPanicMMIOState, PVPANIC_MMIO_DEVICE)
> +
> +#define PVPANIC_MMIO_SIZE 0x2
> +
> +struct PVPanicMMIOState {
> +    SysBusDevice parent_obj;
> +
> +    PVPanicState pvpanic;
> +};
> +
> +static void pvpanic_mmio_initfn(Object *obj)
> +{
> +    PVPanicMMIOState *s = PVPANIC_MMIO_DEVICE(obj);
> +
> +    pvpanic_setup_io(&s->pvpanic, DEVICE(s), PVPANIC_MMIO_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->pvpanic.mr);
> +}
> +
> +static const Property pvpanic_mmio_properties[] = {
> +    DEFINE_PROP_UINT8("events", PVPanicMMIOState, pvpanic.events,
> +                      PVPANIC_PANICKED | PVPANIC_CRASH_LOADED),
> +};
> +
> +static void pvpanic_mmio_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    device_class_set_props(dc, pvpanic_mmio_properties);
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +}
> +
> +static const TypeInfo pvpanic_mmio_info = {
> +    .name          = TYPE_PVPANIC_MMIO_DEVICE,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(PVPanicMMIOState),
> +    .instance_init = pvpanic_mmio_initfn,
> +    .class_init    = pvpanic_mmio_class_init,
> +};
> +
> +static void pvpanic_register_types(void)
> +{
> +    type_register_static(&pvpanic_mmio_info);
> +}
> +
> +type_init(pvpanic_register_types)
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 82bd68b4bb8..ec0fa5aa9f8 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -148,6 +148,10 @@ config PVPANIC_ISA
>       depends on ISA_BUS
>       select PVPANIC_COMMON
>   
> +config PVPANIC_MMIO
> +    bool
> +    select PVPANIC_COMMON
> +
>   config AUX
>       bool
>       select I2C
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 0b5187a2f74..6d47de482c5 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -126,6 +126,7 @@ system_ss.add(when: 'CONFIG_ARMSSE_MHU', if_true: files('armsse-mhu.c'))
>   
>   system_ss.add(when: 'CONFIG_PVPANIC_ISA', if_true: files('pvpanic-isa.c'))
>   system_ss.add(when: 'CONFIG_PVPANIC_PCI', if_true: files('pvpanic-pci.c'))
> +system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'))
>   system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
>   system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>     'aspeed_hace.c',


