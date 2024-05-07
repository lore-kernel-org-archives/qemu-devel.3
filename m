Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A166C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 06:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4E2l-00061H-QP; Tue, 07 May 2024 02:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s4E2g-0005uH-5Q
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s4E2c-0006HC-Il
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715062264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=neXV6sbchfdNbXkwQ9pChe7WPYkPhnLXDns3CvkLVSg=;
 b=YGlfjpGa0QbbQfE5WyCwLexncYkuD19SHE+JEz2QKuqt4dKNe/g4bcfeGSPdW5V5WGw4oz
 LLwrd1ain3SN81jpttCqzGL7c6QHrMP9dnMURrsuD1VBDdgwD9klD+2lHPto0OmLQy25Nv
 zlx5M9CoHMoEtahKHar/7Db4zd0AGwE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-EnFJO1r2O8-jyC48VCnBzA-1; Tue, 07 May 2024 02:11:03 -0400
X-MC-Unique: EnFJO1r2O8-jyC48VCnBzA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59c2583f0bso112415966b.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 23:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715062262; x=1715667062;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=neXV6sbchfdNbXkwQ9pChe7WPYkPhnLXDns3CvkLVSg=;
 b=e49YWeGzyOvjAJ2sDc1R/aPZoLoXZrsQ3V4CLNqjn2Sd+ZhKxYIGtOmOCA/8BNPY5N
 ziLeHwOqUHulk8BxIvb7N1BCNJksDW9ot/jdRAGkMLly8xUlOyvlBFX4RT1zsdBxWGrn
 T4vHyyvg69Lv8lQZnk1a6WpUhb5mdmvcDFJlaKk/P4YPPOkBdxK6Sh1+2Vpn1Atc2S4q
 uOKr4t3hBGf09aiS8wsoUP9ZU86NgE79/+VMdmrR09nsRxKFcFRIkYJG30JzSTl2sVJK
 N/WJZZbqnfgcO28pvhoTvv1bm7/sdZDohiyiVWFO0re7KwbffXQan9Jv1F2sf1zkXgIy
 qSrA==
X-Gm-Message-State: AOJu0YwJZ7w6WgFzh1GnxLFXfevFEyKOhEwl5iOpDQ5TSOEoyvSk2joP
 zyNl5Te3iRjwN25Eaxu+1JvNM75fOBsDNWnBs8kKP6ozpe6nBUaAOUOt4eBVP6Uiv5iyOr95Rfl
 Q7aCTZpwLNAcJhjMtzThZS9Cwg5Zn7+WFiiouVrCtU+hzBI0qbY/7
X-Received: by 2002:a17:907:7292:b0:a59:ad47:756f with SMTP id
 dt18-20020a170907729200b00a59ad47756fmr5406363ejc.74.1715062261966; 
 Mon, 06 May 2024 23:11:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3QvI1O1vBoDq/kubD/T1k/RedD3e0VWRT92VBPmx+HBpDvaVGgPWNpA3YhjSfkEnwvT4AuA==
X-Received: by 2002:a17:907:7292:b0:a59:ad47:756f with SMTP id
 dt18-20020a170907729200b00a59ad47756fmr5406349ejc.74.1715062261638; 
 Mon, 06 May 2024 23:11:01 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-40-241-109.web.vodafone.de.
 [109.40.241.109]) by smtp.gmail.com with ESMTPSA id
 p14-20020a170906604e00b00a58a3238522sm6007540ejj.207.2024.05.06.23.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 23:11:01 -0700 (PDT)
Message-ID: <ea6ca025-8c2a-49ab-a5b5-9e77d1d4114a@redhat.com>
Date: Tue, 7 May 2024 08:10:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] hw/loongarch: Rename LOONGARCH_MACHINE with
 VIRT_MACHINE
To: maobibo <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240506030206.2119832-1-maobibo@loongson.cn>
 <20240506030206.2119832-2-maobibo@loongson.cn>
 <b1a4b08c-e288-4319-ac4a-7d6ca1256755@redhat.com>
 <1a05cc73-3fda-2b17-e9be-541113a751fb@loongson.cn>
 <d5845d4e-c50d-87e6-c8d6-b21bd354c148@loongson.cn>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <d5845d4e-c50d-87e6-c8d6-b21bd354c148@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 07/05/2024 03.18, maobibo wrote:
> 
> 
> On 2024/5/6 下午2:09, maobibo wrote:
>>
>>
>> On 2024/5/6 下午12:24, Thomas Huth wrote:
>>> On 06/05/2024 05.02, Bibo Mao wrote:
>>>> On LoongArch system, there is only virt machine type now, name
>>>> LOONGARCH_MACHINE is confused, rename it with VIRT_MACHINE. Machine name
>>>> about Other real hw boards can be added in future.
>>>>
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>> ---
>>> ...
>>>> @@ -1245,7 +1244,7 @@ static void loongarch_class_init(ObjectClass *oc, 
>>>> void *data)
>>>>   static const TypeInfo loongarch_machine_types[] = {
>>>>       {
>>>> -        .name           = TYPE_LOONGARCH_MACHINE,
>>>> +        .name           = TYPE_VIRT_MACHINE,
>>>>           .parent         = TYPE_MACHINE,
>>>>           .instance_size  = sizeof(LoongArchMachineState),
>>>>           .class_init     = loongarch_class_init,
>>>> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
>>>> index 4e14bf6060..5ea2f0370d 100644
>>>> --- a/include/hw/loongarch/virt.h
>>>> +++ b/include/hw/loongarch/virt.h
>>>> @@ -73,8 +73,8 @@ struct LoongArchMachineState {
>>>>       struct loongarch_boot_info bootinfo;
>>>>   };
>>>> -#define TYPE_LOONGARCH_MACHINE  MACHINE_TYPE_NAME("virt")
>>>> -OBJECT_DECLARE_SIMPLE_TYPE(LoongArchMachineState, LOONGARCH_MACHINE)
>>>> +#define TYPE_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
>>>> +OBJECT_DECLARE_SIMPLE_TYPE(LoongArchMachineState, VIRT_MACHINE)
>>>>   bool loongarch_is_acpi_enabled(LoongArchMachineState *lams);
>>>>   void loongarch_acpi_setup(LoongArchMachineState *lams);
>>>>   #endif
>>>
>>>   Hi,
>>>
>>> there are currently some efforts going on to create the possibility to 
>>> link a QEMU binary that contains all targets in one binary. Since we 
>>> already have a TYPE_VIRT_MACHINE for other targets, I wonder whether it 
>>> might be better to use LOONGARCH_VIRT_MACHINE than just VIRT_MACHINE 
>>> here? Philippe, could you comment on this?
>>
>> It is great if there is one QEMU binary which supports different targets. 
>> And LOONGARCH_VIRT_MACHINE is ok for me.
> Hi Thomas, Philippe,
> 
> Does machine name "virt" need be changed if LOONGARCH_VIRT_MACHINE is used? 
> There will be compatible issues if "virt" machine type is not suggested to use.
> 
> However CPU type "max" is not widely used now, can we get different 
> architectures from CPU type rather than machine type for one QEMU binary 
> which supports different targets?

I assume it should be fine to keep the "virt" machine name and "max" CPU 
type for each target, we've got a bunch of those already. I assume we'll 
keep the binary names as symlinks to the generic binary around and then 
decide via argv[0] about the main target...? Philippe, do you have already 
concrete plans for this?

  Thomas



