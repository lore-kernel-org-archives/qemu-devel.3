Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45927C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 09:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwIg2-00075U-AM; Mon, 15 Apr 2024 05:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwIfz-00074B-C7
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:31:00 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwIfx-0003DJ-CB
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:30:59 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4187481e3feso1712375e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 02:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713173454; x=1713778254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2VSaVO0jKEglRFYHwOI5PvU1TZFN7MEPyVaQBRQh+z0=;
 b=B15CJU3XnFWKYEp/NREhkLhsZmJWwUh2BbKaQS9Vtt0McusixDtIbUAo4lnEXUQAec
 md4NOKEGkORXZruOKTIu96l4pGxUr55dYaUqIszdjr3MxRUsqdYTxqItErG2LnhYr27Z
 rfWLSueLCHv00K6UaElPYjoA9JHAA3AIEor6ouBmTRiNrF/cmNJz9x7AUQ2FMHBmupB2
 HRVUgJBXuvAbbszllvMbQZqWsLHWQzT25bJ45RaLUNYYBYXCWhDsM+S+BNa0koZ01V/P
 ZTd1348+ZeTK7To7QTizNnUPkqr4bdq3gMRMK4Lf7cG6g27R1rtuRoz1RYjWnp8VoKWc
 qeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713173454; x=1713778254;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2VSaVO0jKEglRFYHwOI5PvU1TZFN7MEPyVaQBRQh+z0=;
 b=w3He8LbnSEK1ISyjAuShB32SYfnY9X9ch2gi71DVEKBs183awPv4ptMFqQ99adM9u5
 MdPrXTPlPdQUMg2nDJcuSskFfTUYtFcEGeFGNBns+CfUy+opzSHpcN8KuJIyYSkDVsPR
 qv/dqpeoVEgvKaY/2E2kE1/bBiD011X2zaN5yOpYKj8OalUWk3amumZIuDTVrDT8viUa
 /qFroTU2iSZ+arakx7FXoTnMjWqE02p2JYkfArKmeOCvIECmDLxbIscjOqJDLNw6uJYA
 qJ5qXUTC6S1X2KGjVkgjPichoAr69WGYH+MXX+BGwS8F+T8ZHGZzq5WAN1HhuDCJ9B5s
 xKfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPavvJbbWPXhPlsa55cT+kBpm+dCSc7zAHkBeidBVYx0ANQHn9OVdnl7SF/Jy6PQnEivbYUR4YlcqBVEwtcCcK21wDLNQ=
X-Gm-Message-State: AOJu0YxGZAQMy36d1CZkOchJJDJ+ZOZF53AL52XZ1iC1v7UIogcd1UXT
 x8m6U+r2cltlkP0w6Dk+s/Q02DI20V27DFiexSAmPply2wbqvKYoLr7UE9pi0ek=
X-Google-Smtp-Source: AGHT+IE3Jmf6oAn2eFQFrhR9XM94Om6rf4A73ItGGNZB606WL34KPvlBBTtVft5zfzhAzQh1DyanmQ==
X-Received: by 2002:adf:f40b:0:b0:343:facf:228a with SMTP id
 g11-20020adff40b000000b00343facf228amr5417701wro.19.1713173454445; 
 Mon, 15 Apr 2024 02:30:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.132.126])
 by smtp.gmail.com with ESMTPSA id
 e1-20020a5d5941000000b0034722442e60sm8086547wri.61.2024.04.15.02.30.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 02:30:54 -0700 (PDT)
Message-ID: <14d2fa55-4938-4007-ac65-6ec6c48fbec9@linaro.org>
Date: Mon, 15 Apr 2024 11:30:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] hw/arm : Create Bl475eMachineState
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Samuel Tardieu <sam@rfc1149.net>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240414130604.182059-1-ines.varhol@telecom-paris.fr>
 <20240414130604.182059-4-ines.varhol@telecom-paris.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240414130604.182059-4-ines.varhol@telecom-paris.fr>
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

On 14/4/24 15:05, Inès Varhol wrote:
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   hw/arm/b-l475e-iot01a.c | 44 +++++++++++++++++++++++++++++------------
>   1 file changed, 31 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
> index d862aa43fc..2b570b3e09 100644
> --- a/hw/arm/b-l475e-iot01a.c
> +++ b/hw/arm/b-l475e-iot01a.c
> @@ -2,8 +2,8 @@
>    * B-L475E-IOT01A Discovery Kit machine
>    * (B-L475E-IOT01A IoT Node)
>    *
> - * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> - * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
> + * Copyright (c) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2024 Inès Varhol <ines.varhol@telecom-paris.fr>

2023-2024

>    *
>    * SPDX-License-Identifier: GPL-2.0-or-later
>    *
> @@ -32,33 +32,51 @@


> +static void bl475e_init(MachineState *machine)
>   {
> +    Bl475eMachineState *s = B_L475E_IOT01A(machine);
>       const Stm32l4x5SocClass *sc;
> -    DeviceState *dev;
>   
> -    dev = qdev_new(TYPE_STM32L4X5XG_SOC);
> -    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc,
> +                            TYPE_STM32L4X5XG_SOC);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
>   
> -    sc = STM32L4X5_SOC_GET_CLASS(dev);
> +    sc = STM32L4X5_SOC_GET_CLASS(&s->soc);
>       armv7m_load_kernel(ARM_CPU(first_cpu),
> -                       machine->kernel_filename,
> -                       0, sc->flash_size);
> +        machine->kernel_filename, 0, sc->flash_size);

Spurious line change.

>   }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



