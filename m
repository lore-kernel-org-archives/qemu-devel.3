Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E55C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 18:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tptbO-0008Tp-0B; Wed, 05 Mar 2025 13:36:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tptbM-0008Tb-6V
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 13:36:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tptbG-0001sc-Ql
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 13:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741199761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sn1+DMqhjNdc9Fx2BMT4veukDYS6khSA3w3zNyjONsE=;
 b=eDDUgvUwqo/c447mXaSIV3J/MkGC2zI3ql6XMkiISj/2HOAvULJ2+IVZmgFLhT1uDdAiWw
 RRZ8cBeo3XoSgcUvFmJr3dHWWEF2x+us3wJ2a+RuiPooAY7fFR+k4GHCDoBR/3xxM1PQA6
 zY2GwVsjLHWFZPXZ+PLJenOdO+eBJRY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-w_TlXShEOgGOS4FpBjvwGA-1; Wed, 05 Mar 2025 13:35:58 -0500
X-MC-Unique: w_TlXShEOgGOS4FpBjvwGA-1
X-Mimecast-MFC-AGG-ID: w_TlXShEOgGOS4FpBjvwGA_1741199757
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43bd92233acso4231775e9.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 10:35:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741199757; x=1741804557;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sn1+DMqhjNdc9Fx2BMT4veukDYS6khSA3w3zNyjONsE=;
 b=q/YPUF4s6A4S+h4R7qXJTQZoWDw6f3bBucyZFXye7hhEvCcz9nEF1ygiX98M5ivRxs
 yYjnLpuc9J6Kc59CA4nZfeNEcVKwr8SCMH5eopl+QJwJKqw4GhlPQmvjcYggPRcKZOH5
 gR9cuR+2JlCnBVptHxZrH6g+Zr7Ie47F00pTeLARJ7WsGeB5Ik6ntvyhVEENxPhTR1Eu
 L7q+5WZ1K+cOP04k05LUGgbhQm5egbdYggfK5ntJMXntIAVzrMQGTKxBSF/AYXDfc5MU
 zug13ZoIqf0H0/9b+5HViBdbVHgDRQRe1VbSTbqjd9+TOCSH1+oD37chkDDfkso3sFmc
 T2Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH55qavIFqafZc1ymz0v7qsPrikg5dkA+BCirS3UIZnhMkPqW4UqtGxGxKsj73z+5+tDiqQH3c4vGF@nongnu.org
X-Gm-Message-State: AOJu0YyvAijbWU3Etyg7mTxFRo5H2OODzXBAkGjDSylaAOZSg761+WDq
 YQiOpBGQZfi+d8AuWClJzqTSs3CWt+r8plULMLOTM7Ku93X8ze5UwONq0CLuRSerDC7qpt0XT2c
 ClqwBTCEd50FbJqNq6BpX3IcV5O0Xkaqk0QWRV7reSTzbvvvnR9+U
X-Gm-Gg: ASbGnct0GE0haRseF1EWLo+kIYvrDDLTTSeJa/ebWnq3A1BwOeKfOyOr4+0sqLHoO3M
 /mmXelzBiC9yR9rlNEfJwf6SVmuKQ3RAkUkZPSFsxrr6gAotonNEYo5asUDYvOggry/xnVSyynY
 RUyfyRwIfFKbMRRj/YxmOkCgdBfz2hYLNTR6mHlp5+qkxd1SSwrjrlCRNml2Xq8NMo6jQXlEJG/
 VUlEWi736A2LZIqBH6dhnhfnoXSaLzNhfaoKbnhcSLsI1nxz7SxU3X0TtyQfNj29S161y+UEIBq
 bN5vcg4SRjIEw0keCRs+oN4MDFRvuQLkoMmCUtJObkX9B7g=
X-Received: by 2002:a05:6000:1446:b0:38d:d9e4:9ba6 with SMTP id
 ffacd0b85a97d-3911f724cf8mr4239121f8f.3.1741199757445; 
 Wed, 05 Mar 2025 10:35:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoB5Rea3DXDRp1IHdjFcQb9Fj9znbV7sXN+YTZDluJjROGSvMOk3M3FWnWcsCOOsMau8wkQg==
X-Received: by 2002:a05:6000:1446:b0:38d:d9e4:9ba6 with SMTP id
 ffacd0b85a97d-3911f724cf8mr4239103f8f.3.1741199757056; 
 Wed, 05 Mar 2025 10:35:57 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4847e62sm22065905f8f.67.2025.03.05.10.35.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 10:35:56 -0800 (PST)
Message-ID: <0561d400-6e0b-40e0-a616-bd0d9fd4feec@redhat.com>
Date: Wed, 5 Mar 2025 19:35:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] hw/arm/raspi: Replace TARGET_AARCH64 by
 legacy_binary_is_64bit()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250305161248.54901-1-philmd@linaro.org>
 <20250305161248.54901-3-philmd@linaro.org>
 <91882e5b-bd0f-4f84-9c03-c40b5e3d3e3f@redhat.com>
 <9d7283b7-9d05-4dc0-8e80-3c565376a812@kaod.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <9d7283b7-9d05-4dc0-8e80-3c565376a812@kaod.org>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 05/03/2025 19.12, Cédric Le Goater wrote:
> On 3/5/25 18:40, Thomas Huth wrote:
>> On 05/03/2025 17.12, Philippe Mathieu-Daudé wrote:
>>> For legacy ARM binaries, legacy_binary_is_64bit() is
>>> equivalent of the compile time TARGET_AARCH64 definition.
>>>
>>> Use it as TypeInfo::registerable() callback to dynamically
>>> add Aarch64 specific types in qemu-system-aarch64 binary,
>>> removing the need of TARGET_AARCH64 #ifdef'ry.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/arm/bcm2836.c | 6 ++----
>>>   hw/arm/raspi.c   | 7 +++----
>>>   2 files changed, 5 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
>>> index 95e16806fa1..88a32e5fc20 100644
>>> --- a/hw/arm/bcm2836.c
>>> +++ b/hw/arm/bcm2836.c
>>> @@ -12,6 +12,7 @@
>>>   #include "qemu/osdep.h"
>>>   #include "qapi/error.h"
>>>   #include "qemu/module.h"
>>> +#include "qemu/legacy_binary_info.h"
>>>   #include "hw/arm/bcm2836.h"
>>>   #include "hw/arm/raspi_platform.h"
>>>   #include "hw/sysbus.h"
>>> @@ -195,7 +196,6 @@ static void bcm2836_class_init(ObjectClass *oc, void 
>>> *data)
>>>       dc->realize = bcm2836_realize;
>>>   };
>>> -#ifdef TARGET_AARCH64
>>>   static void bcm2837_class_init(ObjectClass *oc, void *data)
>>>   {
>>>       DeviceClass *dc = DEVICE_CLASS(oc);
>>> @@ -208,7 +208,6 @@ static void bcm2837_class_init(ObjectClass *oc, void 
>>> *data)
>>>       bc->clusterid = 0x0;
>>>       dc->realize = bcm2836_realize;
>>>   };
>>> -#endif
>>>   static const TypeInfo bcm283x_types[] = {
>>>       {
>>> @@ -219,12 +218,11 @@ static const TypeInfo bcm283x_types[] = {
>>>           .name           = TYPE_BCM2836,
>>>           .parent         = TYPE_BCM283X,
>>>           .class_init     = bcm2836_class_init,
>>> -#ifdef TARGET_AARCH64
>>>       }, {
>>>           .name           = TYPE_BCM2837,
>>>           .parent         = TYPE_BCM283X,
>>> +        .registerable   = legacy_binary_is_64bit,
>>>           .class_init     = bcm2837_class_init,
>>> -#endif
>>>       }, {
>>>           .name           = TYPE_BCM283X,
>>>           .parent         = TYPE_BCM283X_BASE,
>>> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
>>> index dce35ca11aa..f7e647a9cbf 100644
>>> --- a/hw/arm/raspi.c
>>> +++ b/hw/arm/raspi.c
>>> @@ -15,6 +15,7 @@
>>>   #include "qemu/osdep.h"
>>>   #include "qemu/units.h"
>>>   #include "qemu/cutils.h"
>>> +#include "qemu/legacy_binary_info.h"
>>>   #include "qapi/error.h"
>>>   #include "hw/arm/boot.h"
>>>   #include "hw/arm/bcm2836.h"
>>> @@ -367,7 +368,6 @@ static void raspi2b_machine_class_init(ObjectClass 
>>> *oc, void *data)
>>>       raspi_machine_class_init(mc, rmc->board_rev);
>>>   };
>>> -#ifdef TARGET_AARCH64
>>>   static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
>>>   {
>>>       MachineClass *mc = MACHINE_CLASS(oc);
>>> @@ -387,7 +387,6 @@ static void raspi3b_machine_class_init(ObjectClass 
>>> *oc, void *data)
>>>       rmc->board_rev = 0xa02082;
>>>       raspi_machine_class_init(mc, rmc->board_rev);
>>>   };
>>> -#endif /* TARGET_AARCH64 */
>>>   static const TypeInfo raspi_machine_types[] = {
>>>       {
>>> @@ -402,16 +401,16 @@ static const TypeInfo raspi_machine_types[] = {
>>>           .name           = MACHINE_TYPE_NAME("raspi2b"),
>>>           .parent         = TYPE_RASPI_MACHINE,
>>>           .class_init     = raspi2b_machine_class_init,
>>> -#ifdef TARGET_AARCH64
>>>       }, {
>>>           .name           = MACHINE_TYPE_NAME("raspi3ap"),
>>>           .parent         = TYPE_RASPI_MACHINE,
>>> +        .registerable   = legacy_binary_is_64bit,
>>>           .class_init     = raspi3ap_machine_class_init,
>>>       }, {
>>>           .name           = MACHINE_TYPE_NAME("raspi3b"),
>>>           .parent         = TYPE_RASPI_MACHINE,
>>> +        .registerable   = legacy_binary_is_64bit,
>>>           .class_init     = raspi3b_machine_class_init,
>>> -#endif
>>>       }, {
>>>           .name           = TYPE_RASPI_MACHINE,
>>>           .parent         = TYPE_RASPI_BASE_MACHINE,
>>
>> Uh, this (together with patch 1) looks very cumbersome. Why don't you 
>> simply split the array into two, one for 32-bit and one for 64-bit, and 
>> then use a simply "if (legacy_binary_is_64bit())" in the type_init 
>> function instead?
> 
> Sounds like a good idea.
> 
> So we would have DEFINE_TYPES() and DEFINE_TYPES64() macros ?

Either that - or simply use type_init() directly here for the time being.

  Thomas


