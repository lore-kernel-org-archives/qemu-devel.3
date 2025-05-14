Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE619C3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 16:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFF6J-0000zl-TV; Wed, 14 May 2025 12:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uFEjm-0006g4-GQ; Wed, 14 May 2025 12:13:46 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uFEjj-0007t2-SN; Wed, 14 May 2025 12:13:42 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 69EF155BC02;
 Wed, 14 May 2025 18:13:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id FzcH6DRRnUzI; Wed, 14 May 2025 18:13:33 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1F4E555CA5C; Wed, 14 May 2025 18:13:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 115E1745682;
 Wed, 14 May 2025 18:13:33 +0200 (CEST)
Date: Wed, 14 May 2025 18:13:33 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Zhao Liu <zhao1.liu@intel.com>
cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=EF=BF=BD?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, 
 qemu-trivial@nongnu.org
Subject: Re: [PATCH 1/9] qom/object: Improve the doc of macros related with
 simple type
In-Reply-To: <aCS3gS3+qdxZof75@intel.com>
Message-ID: <e034853a-beaf-f5d8-4eb3-069538b012c6@eik.bme.hu>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
 <20250514084957.2221975-2-zhao1.liu@intel.com>
 <e213c4bf-1b26-f1c3-c3ed-10c2adff4a5d@eik.bme.hu>
 <aCS3gS3+qdxZof75@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Wed, 14 May 2025, Zhao Liu wrote:
> Hi BALATON,

In case you did not know:
https://en.wikipedia.org/wiki/Name_order#Hungary

> On Wed, May 14, 2025 at 02:02:48PM +0200, BALATON Zoltan wrote:
>> Date: Wed, 14 May 2025 14:02:48 +0200
>> From: BALATON Zoltan <balaton@eik.bme.hu>
>> Subject: Re: [PATCH 1/9] qom/object: Improve the doc of macros related with
>>  simple type
>>
>> On Wed, 14 May 2025, Zhao Liu wrote:
>>> There're 2 changes:
>>> - For OBJECT_DECLARE_SIMPLE_TYPE:
>>>
>>>   Since a clase may not only has virtual method, but also field, thus
>>
>> class may not only have virtual methods but also fields, clarify when class
>> is not needed
>
> Thanks for the polish! It sounds better.

It's also grammatically more correct. But I'm not a native English speaker 
so may still be wrong.

>>>   mention when class is not needed for either, then there is no need
>>>   to have the class.
>>>
>>> - For OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES:
>>>
>>>   And the words like OBJECT_DEFINE_SIMPLE_TYPE about when the type is
>>>   declared by OBJECT_DECLARE_SIMPLE_TYPE, then user should consider
>>>   to define the type via OBJECT_DEFINE_SIMPLE_TYPE or
>>>   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES.
>>>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: "Daniel P. Berrang?" <berrange@redhat.com>
>>> Cc: Eduardo Habkost <eduardo@habkost.net>
>>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>>> ---
>>> include/qom/object.h | 5 +++--
>>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/qom/object.h b/include/qom/object.h
>>> index 1d5b03372429..14f84ae454d3 100644
>>> --- a/include/qom/object.h
>>> +++ b/include/qom/object.h
>>> @@ -249,7 +249,7 @@ struct Object
>>>  * declared.
>>>  *
>>>  * This macro should be used unless the class struct needs to have
>>> - * virtual methods declared.
>>> + * virtual methods or fields declared.
>>>  */
>>> #define OBJECT_DECLARE_SIMPLE_TYPE(InstanceType, MODULE_OBJ_NAME) \
>>>     typedef struct InstanceType InstanceType; \
>>> @@ -402,7 +402,8 @@ struct Object
>>>  *
>>>  * This is a variant of OBJECT_DEFINE_TYPE_EXTENDED, which is suitable for
>>>  * the case of a non-abstract type, with interfaces, and with no requirement
>>> - * for a class struct.
>>> + * for a class struct. If you declared your type with OBJECT_DECLARE_SIMPLE_TYPE
>>> + * then this is probably the right choice for defining it.
>>
>> Is "probably" correct here? Is it a must or can still use other defining
>> macros?
>
> Yes, because there's another choice: OBJECT_DEFINE_SIMPLE_TYPE.
>
>> If correct maybe saying "this might be the right choice" is simpler.
>
> :-) I copied this sentence from the documentation of
> OBJECT_DEFINE_SIMPLE_TYPE. The difference between these 2 macros is
> OBJECT_DEFINE_SIMPLE_TYPE doesn't support interface.
>
> So I'd like to keep this sentence, consistent with the description of
> OBJECT_DEFINE_SIMPLE_TYPE.

OK in that case no problem to keep consistency. It still sounds a bit 
unspecific for documentation to me because it leaves the question open of 
what is it when it's not the right choice but if this is already there 
then that's another unrelated question.

Regards,
BALATON Zoltan

