Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73B2C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret5t-0003ky-1d; Tue, 27 Feb 2024 03:45:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret5V-0003dM-MM
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:45:21 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret5M-00019i-6I
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:45:21 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33d38c9ca5bso2113282f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023509; x=1709628309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zi9hv8WXmOlU9cQPuWAqhoQd705Xi0sNArKoJ6BuDYw=;
 b=eEsUEdu1zJYzUdKTpoADieUgoQMdOY5tvTUbyEedq3EQSEAl+CHhdRCYhJVR7gBIIS
 s/mSg2cKaUUYiOW4ZppY4kRGd6R+MeO4isXS60VR2AUN8P7J7NPZi4KmoJ25brcfOThc
 Zi9kCnhuuRWJOcb/HrxNlfNiefQ2Qqr4qS766jqAiXWHHXBe4Cwghw9hdISEPexYgv/K
 M1ep4rZfYY6NxdYZsTG0OfrNe9p1kPvsXO0xuGwKz/uVnsWW0r4RstVzS6K+MvLQ6kZF
 r5nqAj8fk6db1PThZevo2eTB3jwqcsH1tAwFBuefH9lutuIb5iEsdV0R3wc02azGlski
 eGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023509; x=1709628309;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zi9hv8WXmOlU9cQPuWAqhoQd705Xi0sNArKoJ6BuDYw=;
 b=CPnhpEtMeRXEBH9dIoWl+O1BsNBfwamePWhm7f+Jr38agqAHNoqj6Y67CXvp6fhkSk
 GlJBbKevb1yHrspxrhOiuENeXeT86QQllPoA7PvIPMWGnwfScS1YVd6atKAzokTOmFZF
 j+kdNrPo+TTkZ/D2faqHeonhCFOaE4HoK8ujEcjiHxtsUdFZdEyAXr7DQwhvx/D8XJmy
 jJMI+kLWyQ+D6LwapkCULSnpSFtn61fg2RifSzYfxP291Xer0yvNddEDsxWmiwUNWGl+
 F0pCmjUNMjEfHX6RGCVftUhGwfXndCTUz76CDHqFObabSuRmmsNJztGC+GPRnAsZNbck
 6irQ==
X-Gm-Message-State: AOJu0YyPDn7ZkDCRXmtyAKr2uLZbTo4ZaG5ZFaIf795s/QX4fkXY7fSo
 a9WMet+ghLzOK98tsEL8i0jgjUDt7e4M6PqRtAMhrHJlf4XGLVfdvIyR1IlbfJs=
X-Google-Smtp-Source: AGHT+IG/+PufmAeoQqG4qUr45wMH7dL++K7Ned6G222vNgJX8DY07D1eIHVvNl6/MMmLbvnNPntZIg==
X-Received: by 2002:a5d:4610:0:b0:33d:855b:78f9 with SMTP id
 t16-20020a5d4610000000b0033d855b78f9mr6250432wrq.41.1709023509451; 
 Tue, 27 Feb 2024 00:45:09 -0800 (PST)
Received: from [192.168.69.100] (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 a2-20020a5d5702000000b0033ce5b3390esm10646267wrv.38.2024.02.27.00.45.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 00:45:09 -0800 (PST)
Message-ID: <0312eaa8-ed9b-4c4a-a846-42b4ed307d52@linaro.org>
Date: Tue, 27 Feb 2024 09:45:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/41] Split out common part of BCM283X classes
Content-Language: en-US
To: Sergey Kambalin <serg.oker@gmail.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Sergey Kambalin <sergey.kambalin@auriga.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-2-sergey.kambalin@auriga.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240226000259.2752893-2-sergey.kambalin@auriga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 26/2/24 01:02, Sergey Kambalin wrote:
> Pre setup for BCM2838 introduction
> 
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/bcm2836.c         | 103 ++++++++++++++++++++++-----------------
>   hw/arm/raspi.c           |   2 +-
>   include/hw/arm/bcm2836.h |  26 +++++++++-
>   3 files changed, 84 insertions(+), 47 deletions(-)


> diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
> index 6f90cabfa3..5a6717ca91 100644
> --- a/include/hw/arm/bcm2836.h
> +++ b/include/hw/arm/bcm2836.h
> @@ -17,8 +17,10 @@
>   #include "target/arm/cpu.h"
>   #include "qom/object.h"
>   
> +#define TYPE_BCM283X_BASE "bcm283x-base"

Note for eventual future cleanup, we usually name this "common".

> +OBJECT_DECLARE_TYPE(BCM283XBaseState, BCM283XBaseClass, BCM283X_BASE)
>   #define TYPE_BCM283X "bcm283x"
> -OBJECT_DECLARE_TYPE(BCM283XState, BCM283XClass, BCM283X)
> +OBJECT_DECLARE_SIMPLE_TYPE(BCM283XState, BCM283X)
>   
>   #define BCM283X_NCPUS 4
>   
> @@ -30,7 +32,7 @@ OBJECT_DECLARE_TYPE(BCM283XState, BCM283XClass, BCM283X)
>   #define TYPE_BCM2836 "bcm2836"
>   #define TYPE_BCM2837 "bcm2837"
>   
> -struct BCM283XState {
> +struct BCM283XBaseState {
>       /*< private >*/
>       DeviceState parent_obj;
>       /*< public >*/
> @@ -41,7 +43,27 @@ struct BCM283XState {
>           ARMCPU core;
>       } cpu[BCM283X_NCPUS];
>       BCM2836ControlState control;
> +};
> +
> +struct BCM283XBaseClass {
> +    /*< private >*/
> +    DeviceClass parent_class;
> +    /*< public >*/

Also we don't use these private/public comment anymore.

> +    const char *name;
> +    const char *cpu_type;
> +    unsigned core_count;
> +    hwaddr peri_base; /* Peripheral base address seen by the CPU */
> +    hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
> +    int clusterid;
> +};
> +
> +struct BCM283XState {
> +    /*< private >*/
> +    BCM283XBaseState parent_obj;
> +    /*< public >*/

Ditto.

>       BCM2835PeripheralState peripherals;
>   };
>   
> +bool bcm283x_common_realize(DeviceState *dev, Error **errp);

Amusingly you name the realize handler 'common'.

>   #endif /* BCM2836_H */


