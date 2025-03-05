Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74363C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 20:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpvZJ-00022t-Lm; Wed, 05 Mar 2025 15:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tpvZ8-000219-MO; Wed, 05 Mar 2025 15:42:08 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tpvZ6-0001Ud-DS; Wed, 05 Mar 2025 15:42:06 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B12FD4E600F;
 Wed, 05 Mar 2025 21:41:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id PjYwf-AWy0HM; Wed,  5 Mar 2025 21:41:57 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9757D4E6001; Wed, 05 Mar 2025 21:41:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 946D674577C;
 Wed, 05 Mar 2025 21:41:57 +0100 (CET)
Date: Wed, 5 Mar 2025 21:41:57 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Thomas Huth <thuth@redhat.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 2/4] hw/arm/raspi: Replace TARGET_AARCH64 by
 legacy_binary_is_64bit()
In-Reply-To: <1b76a7fc-e79b-4f32-9657-b87fb7761c95@linaro.org>
Message-ID: <9d0eb259-ec66-28ab-7cb1-8dcced230f0d@eik.bme.hu>
References: <20250305161248.54901-1-philmd@linaro.org>
 <20250305161248.54901-3-philmd@linaro.org>
 <91882e5b-bd0f-4f84-9c03-c40b5e3d3e3f@redhat.com>
 <9d7283b7-9d05-4dc0-8e80-3c565376a812@kaod.org>
 <0561d400-6e0b-40e0-a616-bd0d9fd4feec@redhat.com>
 <1b76a7fc-e79b-4f32-9657-b87fb7761c95@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1915168761-1741207317=:28911"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1915168761-1741207317=:28911
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 5 Mar 2025, Philippe Mathieu-Daudé wrote:
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
>>>>> @@ -195,7 +196,6 @@ static void bcm2836_class_init(ObjectClass *oc, void 
>>>>> *data)
>>>>>       dc->realize = bcm2836_realize;
>>>>>   };
>>>>> -#ifdef TARGET_AARCH64
>>>>>   static void bcm2837_class_init(ObjectClass *oc, void *data)
>>>>>   {
>>>>>       DeviceClass *dc = DEVICE_CLASS(oc);
>>>>> @@ -208,7 +208,6 @@ static void bcm2837_class_init(ObjectClass *oc, void 
>>>>> *data)
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
>    }, {
>        .name           = MACHINE_TYPE_NAME("raspi2b"),
>        .parent         = TYPE_RASPI_MACHINE,
>        .registerable   = qemu_binary_has_target_arm,
>        .class_init     = raspi2b_machine_class_init,
>    }, {
>        .name           = MACHINE_TYPE_NAME("raspi3ap"),
>        .parent         = TYPE_RASPI_MACHINE,
>        .registerable   = qemu_binary_has_target_aarch64,
>        .class_init     = raspi3ap_machine_class_init,
>    }, {
>
> Having:
>
> bool qemu_binary_has_target_arm(void)
> {
>    return qemu_arch_available(QEMU_ARCH_ARM);
> }

I don't know where this is going and what are the details here but why add 
yet another one line function that calls another one that's identical to a 
third one. Why not put in TypeInfo .arch = QEMU_ARCH_ARM then compare to 
that when needed? Although it's questionable if arch belongs to QOM 
TypeInfo and not in Device or Machine instead this may be needed if you 
have to decide on this when registering types. I'm not sure about what 
.registerable means here but more common spelling might be .registrable 
(which suggests this could be problematic in practice so maybe try to find 
a better name for this).

Regards,
BALATON Zoltan

> Now back to Thomas suggestion, we could define 2 TypeInfo arrays,
> but I foresee lot of code churn when devices has to be made
> available on different setup combinations; so with that in mind
> the QOM registerable() callback appears a bit more future proof.
>
>
--3866299591-1915168761-1741207317=:28911--

