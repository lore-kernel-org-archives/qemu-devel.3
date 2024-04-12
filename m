Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29359C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 11:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvF97-00083d-TG; Fri, 12 Apr 2024 07:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rvF8y-000818-39
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rvF8w-0001kE-5W
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712921546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=P2VhnuzguCU1DNFZJjfQNWwdBPMZdrCZPG775pmOn3Q=;
 b=eh0Vhz7qRHX0k4KRdVKSY1JNyDvoHerS5Ud06nP7Q5f+Sr23/NHEle3G6e8ibxdMKifPrR
 swVfljOcow3JJS1wFd4+rxwxe+ih+Cw0mGg/fh3uBpXytOzZRY7Jl1GuS9rKLKuSwpLBn3
 qYQc6giu12tek3EAMCRajiG07uCNLRI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-dKV4dVyNNPub0xQhRix2mw-1; Fri, 12 Apr 2024 07:32:25 -0400
X-MC-Unique: dKV4dVyNNPub0xQhRix2mw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-78d72b6869eso96446985a.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 04:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712921545; x=1713526345;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2VhnuzguCU1DNFZJjfQNWwdBPMZdrCZPG775pmOn3Q=;
 b=igGDwSRXk0TlX/OEIuIqpXMnw6jvIko/tEFlGNVfhlwGFJT0koR90E4jXmVp+BMXCk
 /4yCGvmgQK1An4+/5liafkHrMmy1sXRrxEYZw4eVEvjeG99ym2htlkLPVtqgzSdXF9jR
 s3/8B5GunPiGHqt4LgjnKUkWaNFrdn3CkskusWIc7ayiI8H+JtDAuFZQLogsEjp8R3fa
 wYvKu0NIrYBSQPZML+UUAq4UP1RBzLGePW+PVTpsGWdP2BFRUuipULM82sSPJEL1yzmg
 sBSBAawvTDMsA1dC9cls2AJz4yW0ygkkvwgYesnww6x0wZZjuQdswyLrdVEOuO09vsI4
 eZFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm4zsRvOsU0wis5OZRJgIDejQq7PO16JUW9kQGJzVceHimDomm+XrJCu8DqnZ0vDU1JrgxBgmoiEdtpEUnJ0xCeeIWfHE=
X-Gm-Message-State: AOJu0Yxx8T9APyz49I1eIh9kk2+s1Rd68KSpuAFUJMdXVQuyhlBkbXFz
 04TBn88K+EjzN/rG+FDkqcGChMKpv+Cyvp+k9gJ9XhxSzHbYMcI/I/yrXBp18g3+uyazXICAJIr
 pzuxzjDiN9FyynkB5EMizrByXzsgRbOcv2Zf9xEDAjvVW4n+w59yC
X-Received: by 2002:a37:e319:0:b0:78e:c795:a636 with SMTP id
 y25-20020a37e319000000b0078ec795a636mr2844423qki.0.1712921544836; 
 Fri, 12 Apr 2024 04:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXlyhvb1ziIB6CKuQZk8wYuW/Q1M5RSgDbhBwu51EiVvr91HCccBJG99YzpyEQBkuw6EKlxw==
X-Received: by 2002:a37:e319:0:b0:78e:c795:a636 with SMTP id
 y25-20020a37e319000000b0078ec795a636mr2844391qki.0.1712921544530; 
 Fri, 12 Apr 2024 04:32:24 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-142.web.vodafone.de.
 [109.43.179.142]) by smtp.gmail.com with ESMTPSA id
 e21-20020a05620a12d500b0078eca9de099sm963112qkl.134.2024.04.12.04.32.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 04:32:24 -0700 (PDT)
Message-ID: <f75a5002-8292-4383-9d62-ebd8f3587c20@redhat.com>
Date: Fri, 12 Apr 2024 13:32:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw: Fix problem with the A*MPCORE switches in the
 Kconfig files
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20240412062042.105174-1-thuth@redhat.com>
 <20240412062042.105174-2-thuth@redhat.com>
 <35ea1f53-5c7a-45e8-9fa1-0df8fc7a0cba@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <35ea1f53-5c7a-45e8-9fa1-0df8fc7a0cba@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/04/2024 13.10, Philippe Mathieu-Daudé wrote:
> On 12/4/24 08:20, Thomas Huth wrote:
>> A9MPCORE, ARM11MPCORE and A15MPCORE are defined twice, once in
>> hw/cpu/Kconfig and once in hw/arm/Kconfig. This is only possible
>> by accident, since hw/cpu/Kconfig is never included from hw/Kconfig.
>> Fix it by declaring the switches only in hw/cpu/Kconfig (since the
>> related files reside in the hw/cpu/ folder) and by making sure that
>> the file hw/cpu/Kconfig is now properly included from hw/Kconfig.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/Kconfig     |  1 +
>>   hw/arm/Kconfig | 15 ---------------
>>   hw/cpu/Kconfig | 12 +++++++++---
>>   3 files changed, 10 insertions(+), 18 deletions(-)
>>
>> diff --git a/hw/Kconfig b/hw/Kconfig
>> index 2c00936c28..9567cc475d 100644
>> --- a/hw/Kconfig
>> +++ b/hw/Kconfig
>> @@ -48,6 +48,7 @@ source watchdog/Kconfig
>>   # arch Kconfig
>>   source arm/Kconfig
>> +source cpu/Kconfig
>>   source alpha/Kconfig
>>   source avr/Kconfig
>>   source cris/Kconfig
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index 893a7bff66..d97015c45c 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -678,21 +678,6 @@ config ZAURUS
>>       select NAND
>>       select ECC
>> -config A9MPCORE
>> -    bool
>> -    select A9_GTIMER
>> -    select A9SCU       # snoop control unit
>> -    select ARM_GIC
>> -    select ARM_MPTIMER
>> -
>> -config A15MPCORE
>> -    bool
>> -    select ARM_GIC
>> -
>> -config ARM11MPCORE
>> -    bool
>> -    select ARM11SCU
>> -
>>   config ARMSSE
>>       bool
>>       select ARM_V7M
>> diff --git a/hw/cpu/Kconfig b/hw/cpu/Kconfig
>> index 1767d028ac..f776e884cd 100644
>> --- a/hw/cpu/Kconfig
>> +++ b/hw/cpu/Kconfig
>> @@ -1,8 +1,14 @@
>> -config ARM11MPCORE
>> -    bool
>> -
>>   config A9MPCORE
>>       bool
>> +    select A9_GTIMER
>> +    select A9SCU       # snoop control unit
>> +    select ARM_GIC
>> +    select ARM_MPTIMER
>>   config A15MPCORE
>>       bool
>> +    select ARM_GIC
>> +
>> +config ARM11MPCORE
>> +    bool
>> +    select ARM11SCU
> 
> I thought 
> https://lore.kernel.org/qemu-devel/20231212162935.42910-6-philmd@linaro.org/
>   was already merged :/ I'll look at what is missing and respin.

Oh, ok. But I'd prefer to keep the hw/cpu/Kconfig file since it will be used 
in the 2nd patch here, too.

  Thomas



