Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BC5C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 08:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYMER-0003l6-If; Fri, 09 Feb 2024 03:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rYMEO-0003kU-I6
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 03:27:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rYMEM-0000kL-Ln
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 03:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707467249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dr/MZ8+SYKXNDot7XxX1t4zyBOQblQSE6knKnLkqCc=;
 b=QaSRE8BtP6PghrtHf2uEp0Te1l2Er90+RgXGzwftX3xoIMNjnqgO24IS8k3+JgN6Yi4PxV
 pAJzawpeH3bGB/2QuS2q1YqRmnxs8ui989sztzB4x2andJdL2iDGuPZGT8lVXVl9myxaVm
 nh1IKS25fqgRq50nlEMGofo0eta6Hoc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-BGTyZW0iMY-R9plb9Xuk9g-1; Fri, 09 Feb 2024 03:27:27 -0500
X-MC-Unique: BGTyZW0iMY-R9plb9Xuk9g-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-5f6c12872fbso14466707b3.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 00:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707467247; x=1708072047;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3dr/MZ8+SYKXNDot7XxX1t4zyBOQblQSE6knKnLkqCc=;
 b=JRlfwDToKqPjq215A5BFed5gIprYmKzRBqnFOFHtgZJZ9YfzuP7F/MfpUUB3xTjUtz
 ISfXErM5vLHl41fviIxg+bU+gJ+2tw03MfBDxqAr6cw3Otawat4zjfHqyawNxHfkwuuM
 RqxjUm929ojFQWumQzGl84ZAFRHT/3MFkufVFsMb+b+2y/M40KM9wOSvMJ558bKTmsre
 6Qgdmze+/GxKv8MhNaXlOA1guHb9S764AYGpWQ/skFh8wHMkpVi90XMyITiSlYX1/iLc
 hM88cpCMVdpYMtRx/DGfWBnc+ByMDcy3LlyjJKKHhsoBllY0wcHfpXB7pb5+zovwDp0J
 Cd/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/cOM+CT/U3LH5lnZoe2VfDYccm8P8rLiq2wQf74Jb0DMg5lG8nS6yArivDMZv7O4ZRHFofEVICNuBR+XA1KlfAUokhoE=
X-Gm-Message-State: AOJu0YzrGc3t03VNRHwtrG9wgQm7mjX6VpNnmccuEGYMveQPDQLPTplw
 9jKz+nDOXS+OiqwUyo19Sw2KpR2q2hXPcUUQE/fxXoM6/gNm/H7VQYt8s8W4/qDHRBHqBTNaCFT
 XF41r+MrTdZYLJ+DZnegS5+2xgNkvZUU1u4CbE6sWRSW5C01cbuyf
X-Received: by 2002:a0d:e5c5:0:b0:602:b810:c837 with SMTP id
 o188-20020a0de5c5000000b00602b810c837mr871307ywe.47.1707467246727; 
 Fri, 09 Feb 2024 00:27:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMTQnHe4SnzOroAQ7dQq+wK3RCG6ABHte3RslACMNU+6/lVxRpClYhRFp1A6WzlpnnRbZH9g==
X-Received: by 2002:a0d:e5c5:0:b0:602:b810:c837 with SMTP id
 o188-20020a0de5c5000000b00602b810c837mr871287ywe.47.1707467246350; 
 Fri, 09 Feb 2024 00:27:26 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVj7HBYetuDBr8dgYAAvpyDBD+KMO+hXUPNp171V8OZ2qKIuDxK5hCRuU7PURa7Ct/t2vHK6guGrUJGlKUbAUkHh3SK/3wcHQzccs3xqsTGpdjD9WUrv7E38UsEV50tFpW4xygeXdrfZKlt47u1gw3obHeQGP1mCEVXRfW2oY/S1gHO/7gciQJnG8uRJbCo5u+d3PWRdTtozy1aUmE4zT6mINKtas2JLn52jxpczrti
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 x7-20020a814a07000000b006040a13db84sm234591ywa.48.2024.02.09.00.27.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 00:27:25 -0800 (PST)
Message-ID: <589b2a36-89fa-4187-b0b6-887740d7e2fe@redhat.com>
Date: Fri, 9 Feb 2024 09:27:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] aspeed: introduce a new UART0 device name
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20240207200220.453244-1-jamin_lin@aspeedtech.com>
 <20240207200220.453244-2-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20240207200220.453244-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Jamin,

On 2/7/24 21:02, Jamin Lin via wrote:
> The Aspeed datasheet refers to the UART controllers
> as UART1 - UART13 for the ast10x0, ast2600, ast2500
> and ast2400 SoCs and the Aspeed ast2700 introduces an UART0
> and the UART controllers as UART0 - UART12.
> 
> To keep the naming in the QEMU models
> in sync with the datasheet, let's introduce a new  UART0 device name
> and do the required adjustements, etc ...

Please drop the etc...

> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed.c             | 13 ++++++++-----
>   hw/arm/aspeed_ast10x0.c     |  1 +
>   hw/arm/aspeed_ast2400.c     |  2 ++
>   hw/arm/aspeed_ast2600.c     |  1 +
>   hw/arm/aspeed_soc_common.c  | 14 +++++++++-----
>   include/hw/arm/aspeed_soc.h |  2 ++
>   6 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 09b1e823ba..06d863958b 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -342,7 +342,7 @@ static void connect_serial_hds_to_uarts(AspeedMachineState *bmc)
>       int uart_chosen = bmc->uart_chosen ? bmc->uart_chosen : amc->uart_default;
>   
>       aspeed_soc_uart_set_chr(s, uart_chosen, serial_hd(0));
> -    for (int i = 1, uart = ASPEED_DEV_UART1; i < sc->uarts_num; i++, uart++) {
> +    for (int i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
>           if (uart == uart_chosen) {
>               continue;
>           }
> @@ -1094,7 +1094,7 @@ static char *aspeed_get_bmc_console(Object *obj, Error **errp)
>       AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(bmc);
>       int uart_chosen = bmc->uart_chosen ? bmc->uart_chosen : amc->uart_default;
>   
> -    return g_strdup_printf("uart%d", uart_chosen - ASPEED_DEV_UART1 + 1);
> +    return g_strdup_printf("uart%d", uart_chosen - ASPEED_DEV_UART0);
>   }
>   
>   static void aspeed_set_bmc_console(Object *obj, const char *value, Error **errp)
> @@ -1103,6 +1103,8 @@ static void aspeed_set_bmc_console(Object *obj, const char *value, Error **errp)
>       AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(bmc);
>       AspeedSoCClass *sc = ASPEED_SOC_CLASS(object_class_by_name(amc->soc_name));
>       int val;
> +    int start = sc->uarts_base - ASPEED_DEV_UART0;
> +    int end = start + sc->uarts_num;


To help the reader, I would introduce these helpers at the end of
aspeed_soc.h :

     static inline int aspeed_uart_index(int uart_dev)
     {
         return uart_dev - ASPEED_DEV_UART0;
     }
     
     static inline int aspeed_uart_first(AspeedSoCClass *sc)
     {
         return aspeed_uart_index(sc->uarts_base);
     }
     
     static inline int aspeed_uart_last(AspeedSoCClass *sc)
     {
         return aspeed_uart_first(sc) + sc->uarts_num - 1;
     }
     

>       if (sscanf(value, "uart%u", &val) != 1) {
>           error_setg(errp, "Bad value for \"uart\" property");
> @@ -1110,11 +1112,12 @@ static void aspeed_set_bmc_console(Object *obj, const char *value, Error **errp)
>       }
>   
>       /* The number of UART depends on the SoC */
> -    if (val < 1 || val > sc->uarts_num) {
> -        error_setg(errp, "\"uart\" should be in range [1 - %d]", sc->uarts_num);
> +    if (val < start || val >= end) {
> +        error_setg(errp, "\"uart\" should be in range [%d - %d]",
> +                   start, end - 1);
>           return;
>       }
> -    bmc->uart_chosen = ASPEED_DEV_UART1 + val - 1;
> +    bmc->uart_chosen = val + ASPEED_DEV_UART0;
>   }
>   
>   static void aspeed_machine_class_props_init(ObjectClass *oc)
> diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
> index c3b5116a6a..2634e0f654 100644
> --- a/hw/arm/aspeed_ast10x0.c
> +++ b/hw/arm/aspeed_ast10x0.c
> @@ -436,6 +436,7 @@ static void aspeed_soc_ast1030_class_init(ObjectClass *klass, void *data)
>       sc->wdts_num = 4;
>       sc->macs_num = 1;
>       sc->uarts_num = 13;
> +    sc->uarts_base = ASPEED_DEV_UART1;
>       sc->irqmap = aspeed_soc_ast1030_irqmap;
>       sc->memmap = aspeed_soc_ast1030_memmap;
>       sc->num_cpus = 1;
> diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
> index 8829561bb6..95da85fee0 100644
> --- a/hw/arm/aspeed_ast2400.c
> +++ b/hw/arm/aspeed_ast2400.c
> @@ -523,6 +523,7 @@ static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
>       sc->wdts_num     = 2;
>       sc->macs_num     = 2;
>       sc->uarts_num    = 5;
> +    sc->uarts_base   = ASPEED_DEV_UART1;
>       sc->irqmap       = aspeed_soc_ast2400_irqmap;
>       sc->memmap       = aspeed_soc_ast2400_memmap;
>       sc->num_cpus     = 1;
> @@ -551,6 +552,7 @@ static void aspeed_soc_ast2500_class_init(ObjectClass *oc, void *data)
>       sc->wdts_num     = 3;
>       sc->macs_num     = 2;
>       sc->uarts_num    = 5;
> +    sc->uarts_base   = ASPEED_DEV_UART1;
>       sc->irqmap       = aspeed_soc_ast2500_irqmap;
>       sc->memmap       = aspeed_soc_ast2500_memmap;
>       sc->num_cpus     = 1;
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 4ee32ea99d..f74561ecdc 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -666,6 +666,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
>       sc->wdts_num     = 4;
>       sc->macs_num     = 4;
>       sc->uarts_num    = 13;
> +    sc->uarts_base   = ASPEED_DEV_UART1;
>       sc->irqmap       = aspeed_soc_ast2600_irqmap;
>       sc->memmap       = aspeed_soc_ast2600_memmap;
>       sc->num_cpus     = 2;
> diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
> index 123a0c432c..54c875c8d5 100644
> --- a/hw/arm/aspeed_soc_common.c
> +++ b/hw/arm/aspeed_soc_common.c
> @@ -36,7 +36,7 @@ bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>       SerialMM *smm;
>   
> -    for (int i = 0, uart = ASPEED_DEV_UART1; i < sc->uarts_num; i++, uart++) {
> +    for (int i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
>           smm = &s->uart[i];
>   
>           /* Chardev property is set by the machine. */
> @@ -58,10 +58,14 @@ bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
>   void aspeed_soc_uart_set_chr(AspeedSoCState *s, int dev, Chardev *chr)
>   {
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> -    int i = dev - ASPEED_DEV_UART1;
> -
> -    g_assert(0 <= i && i < ARRAY_SIZE(s->uart) && i < sc->uarts_num);
> -    qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", chr);
> +    int uart_num = dev - ASPEED_DEV_UART0;
> +    int start = sc->uarts_base - ASPEED_DEV_UART0;
> +    int end = start + sc->uarts_num;
> +    int index = uart_num - start;
> +
> +    g_assert(uart_num >= start && uart_num < end);

I don't think this assert is necessary. Only the second one is.

If you want to check the range and return an error, please add an
Error **errp argument and have the callers pass &error_fatal. It would
have the same effect.


Thanks,

C.


> +    g_assert(index < ARRAY_SIZE(s->uart));
> +    qdev_prop_set_chr(DEVICE(&s->uart[index]), "chardev", chr);
>   }
>   
>   /*
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 9d0af84a8c..5ab0902da0 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -140,6 +140,7 @@ struct AspeedSoCClass {
>       int wdts_num;
>       int macs_num;
>       int uarts_num;
> +    int uarts_base;
>       const int *irqmap;
>       const hwaddr *memmap;
>       uint32_t num_cpus;
> @@ -151,6 +152,7 @@ const char *aspeed_soc_cpu_type(AspeedSoCClass *sc);
>   enum {
>       ASPEED_DEV_SPI_BOOT,
>       ASPEED_DEV_IOMEM,
> +    ASPEED_DEV_UART0,
>       ASPEED_DEV_UART1,
>       ASPEED_DEV_UART2,
>       ASPEED_DEV_UART3,


