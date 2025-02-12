Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B8DC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 16:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiFWM-0004QE-VF; Wed, 12 Feb 2025 11:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tiFW9-0004NS-Pi; Wed, 12 Feb 2025 11:23:18 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tiFW6-0007ph-Hi; Wed, 12 Feb 2025 11:23:16 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D73424E6014;
 Wed, 12 Feb 2025 17:23:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id sKExMbfYnAmT; Wed, 12 Feb 2025 17:23:08 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DD10D4E602A; Wed, 12 Feb 2025 17:23:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DA52874577C;
 Wed, 12 Feb 2025 17:23:08 +0100 (CET)
Date: Wed, 12 Feb 2025 17:23:08 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v6 01/11] hw/qdev-properties-system: Introduce EndianMode
 QAPI enum
In-Reply-To: <a3608e43-79ce-403d-8ba7-6735fde66759@linaro.org>
Message-ID: <e1436061-a840-0942-2c2c-4f49bfb932b8@eik.bme.hu>
References: <20250212112413.37553-1-philmd@linaro.org>
 <20250212112413.37553-2-philmd@linaro.org>
 <cb828dd8-25f6-47c6-9ac7-cae5b0d0932e@redhat.com>
 <50ba4e4b-4124-46bb-bb84-4758ce9c5e66@linaro.org>
 <3b3baed4-0d79-3a28-40cd-e1835e078863@eik.bme.hu>
 <6e707c7f-b94c-47ef-83ab-795605e27963@linaro.org>
 <a3608e43-79ce-403d-8ba7-6735fde66759@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-173597825-1739377388=:91349"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-173597825-1739377388=:91349
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 12 Feb 2025, Philippe Mathieu-Daudé wrote:
> On 12/2/25 14:53, Philippe Mathieu-Daudé wrote:
>> On 12/2/25 13:56, BALATON Zoltan wrote:
>>> On Wed, 12 Feb 2025, Philippe Mathieu-Daudé wrote:
>>>> On 12/2/25 12:37, Thomas Huth wrote:
>>>>> On 12/02/2025 12.24, Philippe Mathieu-Daudé wrote:
>>>>>> Introduce the EndianMode type and the DEFINE_PROP_ENDIAN() macros.
>>>>>> Endianness can be BIG, LITTLE or unspecified (default).
>>>>>> 
>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> ---
>>>>>>   qapi/common.json                    | 16 ++++++++++++++++
>>>>>>   include/hw/qdev-properties-system.h |  7 +++++++
>>>>>>   hw/core/qdev-properties-system.c    | 11 +++++++++++
>>>>>>   3 files changed, 34 insertions(+)
>>>>>> 
>>>>>> diff --git a/qapi/common.json b/qapi/common.json
>>>>>> index 6ffc7a37890..217feaaf683 100644
>>>>>> --- a/qapi/common.json
>>>>>> +++ b/qapi/common.json
>>>>>> @@ -212,3 +212,19 @@
>>>>>>   ##
>>>>>>   { 'struct': 'HumanReadableText',
>>>>>>     'data': { 'human-readable-text': 'str' } }
>>>>>> +
>>>>>> +##
>>>>>> +# @EndianMode:
>>>>>> +#
>>>>>> +# An enumeration of three options: little, big, and unspecified
>>>>>> +#
>>>>>> +# @little: Little endianness
>>>>>> +#
>>>>>> +# @big: Big endianness
>>>>>> +#
>>>>>> +# @unspecified: Endianness not specified
>>>>>> +#
>>>>>> +# Since: 10.0
>>>>>> +##
>>>>>> +{ 'enum': 'EndianMode',
>>>>>> +  'data': [ 'little', 'big', 'unspecified' ] }
>>>>> 
>>>>> Should 'unspecified' come first? ... so that it gets the value 0, i.e. 
>>>>> when someone forgets to properly initialize a related variable, the 
>>>>> chances are higher that it ends up as "unspecified" than as "little" ?
>>>> 
>>>> Hmm but then in this series the dual-endianness regions are defined as:
>>>> 
>>>> +static const MemoryRegionOps pic_ops[2] = {
>>>> +    [0 ... 1] = {
>>> 
>>> This is already confusing as you'd have to know that 0 and 1 here means 
>>> ENDIAN_MODE_LITTLE and ENDIAN_MODE_BIG (using those constants here as well 
>>> might be clearer). It's easy to miss what this does so 
>
> At this point 0 / 1 only mean "from the index #0 included to the index
> #1 included", 0 being the first one and 1 the last one.
>
>>> maybe repeating the definitions for each case would be longer but less 
>>> confusing and then it does not matter what the values are.
>
> This is what I tried to do with:
>
> +    [ENDIAN_MODE_BIG].endianness = DEVICE_BIG_ENDIAN,
> +    [ENDIAN_MODE_LITTLE].endianness = DEVICE_LITTLE_ENDIAN,
> };
>
> but in v7 we are back of picking an arbitrary value.
>
>>> Or what uses the ops.endianness now should look at the property introduced 
>>> by this patch to avoid having to propagate it like below and drop the 
>>> ops.endianness? Or it should move to the memory region and set when the 
>>> ops are assigned?
>> 
>> I'm not understanding well what you ask, but maybe the answer is in v7 :)

I'm not sure I understand it well either. I think what I was asking about 
is the same as what Thomas asked if this could be avoided to make it 
necessary to allocate two separate ops for this. Looks like from now on 
this ops struct should really loose the endianness value and this should 
be assigned when the ops is added to the io region because that's where it 
decides which endianness is it based on the property added in this series. 
But I don't know if that could be done or would need deeper changes as 
what later uses this ops struct might not have access to the property and 
if we have a single ops struct it may need to be copied to set different 
endianness intstead of just referencing it. So I'm not sure there's a 
better way but I think this change makes an already cryptic boiler plate 
even more confusing for people less knowledgeable about QEMU and C 
programming so it makes even harder to write devices. But as long as it's 
just a few devices that need to work with different endianness then it 
might be OK. But wasn't that what NATIVE_ENDIAN was meant for? What can't 
that be kept then?

Regards,
BALATON Zoltan
--3866299591-173597825-1739377388=:91349--

