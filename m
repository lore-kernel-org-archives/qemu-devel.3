Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D2DC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 06:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reUKX-000693-Rs; Mon, 26 Feb 2024 01:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1reUKW-00068o-S5
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:19:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1reUKL-00076t-6x
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708928339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IbKA7TBz8ivrhVLtFyWhmWeQxDnz7YcubMUvdj7SgAk=;
 b=JiL6ATFsUrwq7krw34fAiJE7V8JykQLmS2JAw+gdpU9/pV7Nlu1U1pjW8rwPN8BbA4xf/t
 3MqwmFirqRykNjs9spSQ/qHJ7dBhtiPFtteCzCphaXcWbOaUyOccuLftk4DTdkICkFtl7T
 6VgKRzZV5MjyZfzp3j53jDEH6+KmoOQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-HpOeQyc5PTO0tA-HzEAXZQ-1; Mon, 26 Feb 2024 01:18:50 -0500
X-MC-Unique: HpOeQyc5PTO0tA-HzEAXZQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-512bf07e9d1so2222250e87.2
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 22:18:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708928328; x=1709533128;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IbKA7TBz8ivrhVLtFyWhmWeQxDnz7YcubMUvdj7SgAk=;
 b=YhHMJ/uwniW/dxA4tz5QuF86xmibvXcSR5RIzBeuCthb4sydJb97Y8XZ3+bQgSfrQm
 vguhUsdSup9qsu0w66WU+4TzpyCRnKbQS+WxoeZPoj5CmQ1p19Doi7JaXNZauyhB74hv
 odByWHb0rsDoBLOX3a3naK/ts1um7k7yweyZFyuTaQwdz9Ia+K//TUqEObKQuiUh0tO+
 Sc/wFKnI9ySF4sN9D/W6D6P+uDGaT2TuROgyYOQ9omp4a81j06DdYLwkNpzggDjNK8Zt
 nl9gmynlp3zpCV0RANiZ3P6oFI65JhEPpOfGJoTX69XrdYaf+ZnNs/pMFR6yH2VrzZWs
 hOkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxbqfotrJB4CWHPZdyGINotcSMrCBzAR2SW4i4aWCmawJiUJ/MlbIINBNScfdVwjrVJiqKzyWeAyhtrCVdV/oE6p8qglA=
X-Gm-Message-State: AOJu0YwyRfsHsnBsQZzx47YUa+m+tDimKcZOo7LO94bcCENeRaakKMFK
 cQK8oSm26IzhpjYWHjxVMurhPNl2tCX1yO8apcaZ1I4cDcmbzHdAK8IOBaeVGbRI0MlhJIPaF8S
 /BI/jZ1sKc175sD0QFYfLcX4G+0rN6Y6tMBrqpvovOzlAVaNc7eWe
X-Received: by 2002:ac2:5ed0:0:b0:512:e04f:ae4b with SMTP id
 d16-20020ac25ed0000000b00512e04fae4bmr3555709lfq.10.1708928328658; 
 Sun, 25 Feb 2024 22:18:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDIEdfD1wprqk6nqqrFfL9aQopDp2WiGaZbXBpZ5MUSCZZ/PgDF+pC3mqeRaywgkUOTqjvXw==
X-Received: by 2002:ac2:5ed0:0:b0:512:e04f:ae4b with SMTP id
 d16-20020ac25ed0000000b00512e04fae4bmr3555686lfq.10.1708928328320; 
 Sun, 25 Feb 2024 22:18:48 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-215.web.vodafone.de.
 [109.43.176.215]) by smtp.gmail.com with ESMTPSA id
 d3-20020adffbc3000000b0033dd2c3131fsm3361949wrs.65.2024.02.25.22.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Feb 2024 22:18:47 -0800 (PST)
Message-ID: <6272423a-1e07-4813-bb6c-c67b91e7f245@redhat.com>
Date: Mon, 26 Feb 2024 07:18:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/arm/sbsa-ref: Do not open-code
 ahci_ide_create_devs()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Radoslaw Biernacki <rad@semihalf.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240225171637.4709-1-philmd@linaro.org>
 <20240225171637.4709-2-philmd@linaro.org>
 <0fa25487-f25a-433d-b916-4b12ea5649ed@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <0fa25487-f25a-433d-b916-4b12ea5649ed@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 25/02/2024 18.21, Philippe Mathieu-Daudé wrote:
> On 25/2/24 18:16, Philippe Mathieu-Daudé wrote:
>> Use ahci_ide_create_devs() instead of open-coding it.
>> Not accessing AHCIDevice internals anymore allows to
>> remove "hw/ide/ahci_internal.h" (which isn't really a
>> public header).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/sbsa-ref.c | 9 +--------
>>   1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
>> index 5d3a574664..995c7be23e 100644
>> --- a/hw/arm/sbsa-ref.c
>> +++ b/hw/arm/sbsa-ref.c
>> @@ -37,7 +37,6 @@
>>   #include "hw/block/flash.h"
>>   #include "hw/boards.h"
>>   #include "hw/ide/internal.h"
>> -#include "hw/ide/ahci_internal.h"
>>   #include "hw/ide/ahci-sysbus.h"
>>   #include "hw/intc/arm_gicv3_common.h"
>>   #include "hw/intc/arm_gicv3_its_common.h"
>> @@ -572,7 +571,6 @@ static void create_ahci(const SBSAMachineState *sms)
>>       DriveInfo *hd[NUM_SATA_PORTS];
>>       SysbusAHCIState *sysahci;
>>       AHCIState *ahci;
>> -    int i;
>>       dev = qdev_new("sysbus-ahci");
>>       qdev_prop_set_uint32(dev, "num-ports", NUM_SATA_PORTS);
>> @@ -583,12 +581,7 @@ static void create_ahci(const SBSAMachineState *sms)
>>       sysahci = SYSBUS_AHCI(dev);
>>       ahci = &sysahci->ahci;
> 
> Bah, we can even remove that 'ahci' variable.
> 
>>       ide_drive_get(hd, ARRAY_SIZE(hd));
>> -    for (i = 0; i < ahci->ports; i++) {
>> -        if (hd[i] == NULL) {
>> -            continue;
>> -        }
>> -        ide_bus_create_drive(&ahci->dev[i].port, 0, hd[i]);
>> -    }
>> +    ahci_ide_create_devs(ahci, hd);
>>   }
> 
> -- >8 --
> @@ -571,8 +570,6 @@ static void create_ahci(const SBSAMachineState *sms)
>       DeviceState *dev;
>       DriveInfo *hd[NUM_SATA_PORTS];
>       SysbusAHCIState *sysahci;
> -    AHCIState *ahci;
> -    int i;
> 
>       dev = qdev_new("sysbus-ahci");
>       qdev_prop_set_uint32(dev, "num-ports", NUM_SATA_PORTS);
> @@ -581,14 +578,8 @@ static void create_ahci(const SBSAMachineState *sms)
>       sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(sms->gic, 
> irq));
> 
>       sysahci = SYSBUS_AHCI(dev);
> -    ahci = &sysahci->ahci;
>       ide_drive_get(hd, ARRAY_SIZE(hd));
> -    for (i = 0; i < ahci->ports; i++) {
> -        if (hd[i] == NULL) {
> -            continue;
> -        }
> -        ide_bus_create_drive(&ahci->dev[i].port, 0, hd[i]);
> -    }
> +    ahci_ide_create_devs(&sysahci->ahci, hd);
>   }

Reviewed-by: Thomas Huth <thuth@redhat.com>



