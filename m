Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A31DC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4TS-000881-La; Thu, 06 Mar 2025 01:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tq4TQ-00087g-E4
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:12:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tq4TO-00031y-Cq
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741241564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nO+VimTEW8xhqR45blT34Yx7cRvxG1H3xJW2FBykFrs=;
 b=PTJyeGBHXeedxW5Vr/f4XfVDElJehyJxdAiZ3UIqd4xu0VNxCv6XGrU9TKhGs7Jf8Ndez5
 udUKxh8nrloDUaAfda+mJAy8HhUz0mwnBeYogVmCAalF2DzbZI56zTlttHewAg9Bln+F05
 DukVEuToQ8pE79duxnqV+gsKQ+51dO8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-mD5J8--IP8uMe8ic4wK59A-1; Thu, 06 Mar 2025 01:12:38 -0500
X-MC-Unique: mD5J8--IP8uMe8ic4wK59A-1
X-Mimecast-MFC-AGG-ID: mD5J8--IP8uMe8ic4wK59A_1741241557
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac1e442740cso10925166b.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:12:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741241557; x=1741846357;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nO+VimTEW8xhqR45blT34Yx7cRvxG1H3xJW2FBykFrs=;
 b=uZ8mLn1P20twZ7L4iXZgMV2m0ywnbH4xVGv7PeS7PTnBuWYcp5VJeleiKXqBVoed3i
 fbhMIjVagUTNz0GMoPGbxSd2qSGATGELV/mtXWfWIaNQWZ8Udp6siP3/wtlFf0IwCF4Q
 Zu5l2Bszac/076rw9xVMpLv8iK7NLWhVD8BrGkw2+b2hkvtb+ZJ1lKs+zntL2Iit5bhT
 7xD5/3CVspp3/BTv3j+mpQ9/y4gBHtO84s5Wnyq7uaEoBzPUbZyzXzSJsNFYqWSF/qG+
 UbsB1G6l1Z0G1CLm4wlBQb0ujxtEIrBufQyJruo+KRHOnZjRc/A//eJjl5GUakyf808o
 zjfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyvTkXg3z1+7vpEyl1iOC9xdWpdnfTLM9xNdnk8m7yfC+Y97q8N9uqlrrudp7fjOQcF2NFVmb5eznT@nongnu.org
X-Gm-Message-State: AOJu0YxPd6OWJTjT/baXogHJzEskpgWwbhu/dmDflCjTPl5a33I28Z02
 f8DFAaPoJYTngHHI5nkpwuYNojAu/sJ8/NTIEJfRA0UuFZJ61NnN8Aog1OKI2FvtmmIhUkRZ1kT
 Vw/iI1SYgs1NL7qDLhg4H/GPrGfnpKSwXcseqZX5mz7P9rcWuMSI8
X-Gm-Gg: ASbGncu5QwI4eGiL8WuqZVc2NtWpL+O2yvCg4vSWOt3Kf8z4rc7uewBMbAqHz4cVh/1
 rTwVQqTCJZ8RzrnPu3Rb+WG6aSVoYRfq1Yy6maPmMjeXZKZdsH3hA4V987tp2YOxzJvbnsvc1kT
 KzgB+7tWfcp9L9+z9YH7addPCaPBlHdiIRQw0lZqVhV0i78R98R+pwPD2yhmDjfZq+9zjCq177b
 l8W0dLgsv/Zz9z8+H2UZ1tZMPY1sR5CMXPYXAkH2Tw5Dj2M2OdUkuuO9Y6iRMCwEEvV1OxtGXyF
 mqd8gimp4JMJfrKnQPw8MyGYMOOyX9tmEIXYbQFjYTGgick=
X-Received: by 2002:a17:907:2dac:b0:abf:70fb:7f05 with SMTP id
 a640c23a62f3a-ac20dafc173mr580469266b.50.1741241556923; 
 Wed, 05 Mar 2025 22:12:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcczIr9zH5o1ImoWKlsY3Yswn0CeDlw9AXeZPlRx3JZR3CLs6FZaHcH87bvBWOFEWKLBTvUQ==
X-Received: by 2002:a17:907:2dac:b0:abf:70fb:7f05 with SMTP id
 a640c23a62f3a-ac20dafc173mr580466766b.50.1741241556513; 
 Wed, 05 Mar 2025 22:12:36 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac23943c476sm38284466b.3.2025.03.05.22.12.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 22:12:35 -0800 (PST)
Message-ID: <cdb0db9d-1a4d-4e90-b0dc-d42b3ea2c1b1@redhat.com>
Date: Thu, 6 Mar 2025 07:12:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] hw/arm/raspi: Replace TARGET_AARCH64 by
 legacy_binary_is_64bit()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250305161248.54901-1-philmd@linaro.org>
 <20250305161248.54901-3-philmd@linaro.org>
 <91882e5b-bd0f-4f84-9c03-c40b5e3d3e3f@redhat.com>
 <9d7283b7-9d05-4dc0-8e80-3c565376a812@kaod.org>
 <0561d400-6e0b-40e0-a616-bd0d9fd4feec@redhat.com>
 <1b76a7fc-e79b-4f32-9657-b87fb7761c95@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <1b76a7fc-e79b-4f32-9657-b87fb7761c95@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 05/03/2025 20.07, Philippe Mathieu-Daudé wrote:
> On 5/3/25 19:35, Thomas Huth wrote:
>> On 05/03/2025 19.12, Cédric Le Goater wrote:
>>> On 3/5/25 18:40, Thomas Huth wrote:
>>>> On 05/03/2025 17.12, Philippe Mathieu-Daudé wrote:
>>>>> For legacy ARM binaries, legacy_binary_is_64bit() is
>>>>> equivalent of the compile time TARGET_AARCH64 definition.
>>>>>
>>>>> Use it as TypeInfo::registerable() callback to dynamically
>>>>> add Aarch64 specific types in qemu-system-aarch64 binary,
>>>>> removing the need of TARGET_AARCH64 #ifdef'ry.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>>   hw/arm/bcm2836.c | 6 ++----
>>>>>   hw/arm/raspi.c   | 7 +++----
>>>>>   2 files changed, 5 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
>>>>> index 95e16806fa1..88a32e5fc20 100644
>>>>> --- a/hw/arm/bcm2836.c
>>>>> +++ b/hw/arm/bcm2836.c
>>>>> @@ -12,6 +12,7 @@
>>>>>   #include "qemu/osdep.h"
>>>>>   #include "qapi/error.h"
>>>>>   #include "qemu/module.h"
>>>>> +#include "qemu/legacy_binary_info.h"
>>>>>   #include "hw/arm/bcm2836.h"
>>>>>   #include "hw/arm/raspi_platform.h"
>>>>>   #include "hw/sysbus.h"
>>>>> @@ -195,7 +196,6 @@ static void bcm2836_class_init(ObjectClass *oc, 
>>>>> void *data)
>>>>>       dc->realize = bcm2836_realize;
>>>>>   };
>>>>> -#ifdef TARGET_AARCH64
>>>>>   static void bcm2837_class_init(ObjectClass *oc, void *data)
>>>>>   {
>>>>>       DeviceClass *dc = DEVICE_CLASS(oc);
>>>>> @@ -208,7 +208,6 @@ static void bcm2837_class_init(ObjectClass *oc, 
>>>>> void *data)
>>>>>       bc->clusterid = 0x0;
>>>>>       dc->realize = bcm2836_realize;
>>>>>   };
>>>>> -#endif
>>>>>   static const TypeInfo bcm283x_types[] = {
>>>>>       {
>>>>> @@ -219,12 +218,11 @@ static const TypeInfo bcm283x_types[] = {
>>>>>           .name           = TYPE_BCM2836,
>>>>>           .parent         = TYPE_BCM283X,
>>>>>           .class_init     = bcm2836_class_init,
>>>>> -#ifdef TARGET_AARCH64
>>>>>       }, {
>>>>>           .name           = TYPE_BCM2837,
>>>>>           .parent         = TYPE_BCM283X,
>>>>> +        .registerable   = legacy_binary_is_64bit,
>>>>>           .class_init     = bcm2837_class_init,
>>>>> -#endif
>>>>>       }, {
>>>>>           .name           = TYPE_BCM283X,
>>>>>           .parent         = TYPE_BCM283X_BASE,
>>>>> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
>>>>> index dce35ca11aa..f7e647a9cbf 100644
>>>>> --- a/hw/arm/raspi.c
>>>>> +++ b/hw/arm/raspi.c
>>>>> @@ -15,6 +15,7 @@
>>>>>   #include "qemu/osdep.h"
>>>>>   #include "qemu/units.h"
>>>>>   #include "qemu/cutils.h"
>>>>> +#include "qemu/legacy_binary_info.h"
>>>>>   #include "qapi/error.h"
>>>>>   #include "hw/arm/boot.h"
>>>>>   #include "hw/arm/bcm2836.h"
>>>>> @@ -367,7 +368,6 @@ static void raspi2b_machine_class_init(ObjectClass 
>>>>> *oc, void *data)
>>>>>       raspi_machine_class_init(mc, rmc->board_rev);
>>>>>   };
>>>>> -#ifdef TARGET_AARCH64
>>>>>   static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
>>>>>   {
>>>>>       MachineClass *mc = MACHINE_CLASS(oc);
>>>>> @@ -387,7 +387,6 @@ static void raspi3b_machine_class_init(ObjectClass 
>>>>> *oc, void *data)
>>>>>       rmc->board_rev = 0xa02082;
>>>>>       raspi_machine_class_init(mc, rmc->board_rev);
>>>>>   };
>>>>> -#endif /* TARGET_AARCH64 */
>>>>>   static const TypeInfo raspi_machine_types[] = {
>>>>>       {
>>>>> @@ -402,16 +401,16 @@ static const TypeInfo raspi_machine_types[] = {
>>>>>           .name           = MACHINE_TYPE_NAME("raspi2b"),
>>>>>           .parent         = TYPE_RASPI_MACHINE,
>>>>>           .class_init     = raspi2b_machine_class_init,
>>>>> -#ifdef TARGET_AARCH64
>>>>>       }, {
>>>>>           .name           = MACHINE_TYPE_NAME("raspi3ap"),
>>>>>           .parent         = TYPE_RASPI_MACHINE,
>>>>> +        .registerable   = legacy_binary_is_64bit,
>>>>>           .class_init     = raspi3ap_machine_class_init,
>>>>>       }, {
>>>>>           .name           = MACHINE_TYPE_NAME("raspi3b"),
>>>>>           .parent         = TYPE_RASPI_MACHINE,
>>>>> +        .registerable   = legacy_binary_is_64bit,
>>>>>           .class_init     = raspi3b_machine_class_init,
>>>>> -#endif
>>>>>       }, {
>>>>>           .name           = TYPE_RASPI_MACHINE,
>>>>>           .parent         = TYPE_RASPI_BASE_MACHINE,
>>>>
>>>> Uh, this (together with patch 1) looks very cumbersome. Why don't you 
>>>> simply split the array into two, one for 32-bit and one for 64-bit, and 
>>>> then use a simply "if (legacy_binary_is_64bit())" in the type_init 
>>>> function instead?
>>>
>>> Sounds like a good idea.
>>>
>>> So we would have DEFINE_TYPES() and DEFINE_TYPES64() macros ?
>>
>> Either that - or simply use type_init() directly here for the time being.
> 
> As Pierrick noted on private chat, my approach doesn't scale, I should
> use smth in the lines of:
> 
>      }, {
>          .name           = MACHINE_TYPE_NAME("raspi2b"),
>          .parent         = TYPE_RASPI_MACHINE,
>          .registerable   = qemu_binary_has_target_arm,
>          .class_init     = raspi2b_machine_class_init,
>      }, {
>          .name           = MACHINE_TYPE_NAME("raspi3ap"),
>          .parent         = TYPE_RASPI_MACHINE,
>          .registerable   = qemu_binary_has_target_aarch64,
>          .class_init     = raspi3ap_machine_class_init,
>      }, {
> 
> Having:
> 
> bool qemu_binary_has_target_arm(void)
> {
>      return qemu_arch_available(QEMU_ARCH_ARM);
> }
> 
> Now back to Thomas suggestion, we could define 2 TypeInfo arrays,
> but I foresee lot of code churn when devices has to be made
> available on different setup combinations; so with that in mind
> the QOM registerable() callback appears a bit more future proof.

Honestly, in this case, I'd rather prefer some code churn now instead of 
having a unnecessary callback interface until forever! Just my 0.02 €.

  Thomas


