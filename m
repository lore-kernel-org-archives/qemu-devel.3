Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D048C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 18:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tptF8-0004A1-Q7; Wed, 05 Mar 2025 13:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=HzNt=VY=kaod.org=clg@ozlabs.org>)
 id 1tptEz-00049N-CI; Wed, 05 Mar 2025 13:13:09 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=HzNt=VY=kaod.org=clg@ozlabs.org>)
 id 1tptEw-0005pK-4k; Wed, 05 Mar 2025 13:13:08 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Z7LJ90Vbqz4xN0;
 Thu,  6 Mar 2025 05:12:57 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Z7LHy0rr8z4xM7;
 Thu,  6 Mar 2025 05:12:45 +1100 (AEDT)
Message-ID: <9d7283b7-9d05-4dc0-8e80-3c565376a812@kaod.org>
Date: Wed, 5 Mar 2025 19:12:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] hw/arm/raspi: Replace TARGET_AARCH64 by
 legacy_binary_is_64bit()
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250305161248.54901-1-philmd@linaro.org>
 <20250305161248.54901-3-philmd@linaro.org>
 <91882e5b-bd0f-4f84-9c03-c40b5e3d3e3f@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <91882e5b-bd0f-4f84-9c03-c40b5e3d3e3f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=HzNt=VY=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/5/25 18:40, Thomas Huth wrote:
> On 05/03/2025 17.12, Philippe Mathieu-Daudé wrote:
>> For legacy ARM binaries, legacy_binary_is_64bit() is
>> equivalent of the compile time TARGET_AARCH64 definition.
>>
>> Use it as TypeInfo::registerable() callback to dynamically
>> add Aarch64 specific types in qemu-system-aarch64 binary,
>> removing the need of TARGET_AARCH64 #ifdef'ry.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/bcm2836.c | 6 ++----
>>   hw/arm/raspi.c   | 7 +++----
>>   2 files changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
>> index 95e16806fa1..88a32e5fc20 100644
>> --- a/hw/arm/bcm2836.c
>> +++ b/hw/arm/bcm2836.c
>> @@ -12,6 +12,7 @@
>>   #include "qemu/osdep.h"
>>   #include "qapi/error.h"
>>   #include "qemu/module.h"
>> +#include "qemu/legacy_binary_info.h"
>>   #include "hw/arm/bcm2836.h"
>>   #include "hw/arm/raspi_platform.h"
>>   #include "hw/sysbus.h"
>> @@ -195,7 +196,6 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
>>       dc->realize = bcm2836_realize;
>>   };
>> -#ifdef TARGET_AARCH64
>>   static void bcm2837_class_init(ObjectClass *oc, void *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(oc);
>> @@ -208,7 +208,6 @@ static void bcm2837_class_init(ObjectClass *oc, void *data)
>>       bc->clusterid = 0x0;
>>       dc->realize = bcm2836_realize;
>>   };
>> -#endif
>>   static const TypeInfo bcm283x_types[] = {
>>       {
>> @@ -219,12 +218,11 @@ static const TypeInfo bcm283x_types[] = {
>>           .name           = TYPE_BCM2836,
>>           .parent         = TYPE_BCM283X,
>>           .class_init     = bcm2836_class_init,
>> -#ifdef TARGET_AARCH64
>>       }, {
>>           .name           = TYPE_BCM2837,
>>           .parent         = TYPE_BCM283X,
>> +        .registerable   = legacy_binary_is_64bit,
>>           .class_init     = bcm2837_class_init,
>> -#endif
>>       }, {
>>           .name           = TYPE_BCM283X,
>>           .parent         = TYPE_BCM283X_BASE,
>> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
>> index dce35ca11aa..f7e647a9cbf 100644
>> --- a/hw/arm/raspi.c
>> +++ b/hw/arm/raspi.c
>> @@ -15,6 +15,7 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu/units.h"
>>   #include "qemu/cutils.h"
>> +#include "qemu/legacy_binary_info.h"
>>   #include "qapi/error.h"
>>   #include "hw/arm/boot.h"
>>   #include "hw/arm/bcm2836.h"
>> @@ -367,7 +368,6 @@ static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
>>       raspi_machine_class_init(mc, rmc->board_rev);
>>   };
>> -#ifdef TARGET_AARCH64
>>   static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
>>   {
>>       MachineClass *mc = MACHINE_CLASS(oc);
>> @@ -387,7 +387,6 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
>>       rmc->board_rev = 0xa02082;
>>       raspi_machine_class_init(mc, rmc->board_rev);
>>   };
>> -#endif /* TARGET_AARCH64 */
>>   static const TypeInfo raspi_machine_types[] = {
>>       {
>> @@ -402,16 +401,16 @@ static const TypeInfo raspi_machine_types[] = {
>>           .name           = MACHINE_TYPE_NAME("raspi2b"),
>>           .parent         = TYPE_RASPI_MACHINE,
>>           .class_init     = raspi2b_machine_class_init,
>> -#ifdef TARGET_AARCH64
>>       }, {
>>           .name           = MACHINE_TYPE_NAME("raspi3ap"),
>>           .parent         = TYPE_RASPI_MACHINE,
>> +        .registerable   = legacy_binary_is_64bit,
>>           .class_init     = raspi3ap_machine_class_init,
>>       }, {
>>           .name           = MACHINE_TYPE_NAME("raspi3b"),
>>           .parent         = TYPE_RASPI_MACHINE,
>> +        .registerable   = legacy_binary_is_64bit,
>>           .class_init     = raspi3b_machine_class_init,
>> -#endif
>>       }, {
>>           .name           = TYPE_RASPI_MACHINE,
>>           .parent         = TYPE_RASPI_BASE_MACHINE,
> 
> Uh, this (together with patch 1) looks very cumbersome. Why don't you simply split the array into two, one for 32-bit and one for 64-bit, and then use a simply "if (legacy_binary_is_64bit())" in the type_init function instead?

Sounds like a good idea.

So we would have DEFINE_TYPES() and DEFINE_TYPES64() macros ?


C.

