Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF80C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 12:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiCHt-0000sz-Oe; Wed, 12 Feb 2025 07:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tiCHm-0000rh-JB; Wed, 12 Feb 2025 07:56:15 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tiCHk-0005un-HT; Wed, 12 Feb 2025 07:56:14 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 107734E6019;
 Wed, 12 Feb 2025 13:56:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id QFPQKJGT4X-Q; Wed, 12 Feb 2025 13:56:01 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1B4624E6014; Wed, 12 Feb 2025 13:56:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 18F3674577C;
 Wed, 12 Feb 2025 13:56:01 +0100 (CET)
Date: Wed, 12 Feb 2025 13:56:01 +0100 (CET)
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
In-Reply-To: <50ba4e4b-4124-46bb-bb84-4758ce9c5e66@linaro.org>
Message-ID: <3b3baed4-0d79-3a28-40cd-e1835e078863@eik.bme.hu>
References: <20250212112413.37553-1-philmd@linaro.org>
 <20250212112413.37553-2-philmd@linaro.org>
 <cb828dd8-25f6-47c6-9ac7-cae5b0d0932e@redhat.com>
 <50ba4e4b-4124-46bb-bb84-4758ce9c5e66@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-533999827-1739364961=:31598"
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

--3866299591-533999827-1739364961=:31598
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 12 Feb 2025, Philippe Mathieu-Daudé wrote:
> On 12/2/25 12:37, Thomas Huth wrote:
>> On 12/02/2025 12.24, Philippe Mathieu-Daudé wrote:
>>> Introduce the EndianMode type and the DEFINE_PROP_ENDIAN() macros.
>>> Endianness can be BIG, LITTLE or unspecified (default).
>>> 
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   qapi/common.json                    | 16 ++++++++++++++++
>>>   include/hw/qdev-properties-system.h |  7 +++++++
>>>   hw/core/qdev-properties-system.c    | 11 +++++++++++
>>>   3 files changed, 34 insertions(+)
>>> 
>>> diff --git a/qapi/common.json b/qapi/common.json
>>> index 6ffc7a37890..217feaaf683 100644
>>> --- a/qapi/common.json
>>> +++ b/qapi/common.json
>>> @@ -212,3 +212,19 @@
>>>   ##
>>>   { 'struct': 'HumanReadableText',
>>>     'data': { 'human-readable-text': 'str' } }
>>> +
>>> +##
>>> +# @EndianMode:
>>> +#
>>> +# An enumeration of three options: little, big, and unspecified
>>> +#
>>> +# @little: Little endianness
>>> +#
>>> +# @big: Big endianness
>>> +#
>>> +# @unspecified: Endianness not specified
>>> +#
>>> +# Since: 10.0
>>> +##
>>> +{ 'enum': 'EndianMode',
>>> +  'data': [ 'little', 'big', 'unspecified' ] }
>> 
>> Should 'unspecified' come first? ... so that it gets the value 0, i.e. when 
>> someone forgets to properly initialize a related variable, the chances are 
>> higher that it ends up as "unspecified" than as "little" ?
>
> Hmm but then in this series the dual-endianness regions are defined as:
>
> +static const MemoryRegionOps pic_ops[2] = {
> +    [0 ... 1] = {

This is already confusing as you'd have to know that 0 and 1 here means 
ENDIAN_MODE_LITTLE and ENDIAN_MODE_BIG (using those constants here as well 
might be clearer). It's easy to miss what this does so maybe repeating the 
definitions for each case would be longer but less confusing and then it 
does not matter what the values are.

Or what uses the ops.endianness now should look at the property introduced 
by this patch to avoid having to propagate it like below and drop the 
ops.endianness? Or it should move to the memory region and set when the 
ops are assigned?

Regards,
BALATON Zoltan

> +        .read = pic_read,
> +        .write = pic_write,
> +        .endianness = DEVICE_BIG_ENDIAN,
> +        .impl = {
> +            .min_access_size = 4,
> +            .max_access_size = 4,
> +        },
> +        .valid = {
> +            /*
> +             * All XPS INTC registers are accessed through the PLB 
> interface.
> +             * The base address for these registers is provided by the
> +             * configuration parameter, C_BASEADDR. Each register is 32 bits
> +             * although some bits may be unused and is accessed on a 4-byte
> +             * boundary offset from the base address.
> +             */
> +            .min_access_size = 4,
> +            .max_access_size = 4,
> +        },
>     },
> -    .valid = {
> -        .min_access_size = 4,
> -        .max_access_size = 4
> -    }
> +    [ENDIAN_MODE_BIG].endianness = DEVICE_BIG_ENDIAN,
> +    [ENDIAN_MODE_LITTLE].endianness = DEVICE_LITTLE_ENDIAN,
> };
>
> We could declare the array using the confusing __MAX definition
> (at the price of wasting the ENDIAN_MODE_UNSPECIFIED entry) as:
>
> static const MemoryRegionOps pic_ops[ENDIAN_MODE__MAX - 1] { }
>
> WDYT?
>
>> Apart from that:
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> 
>
> Thanks!
>
>
--3866299591-533999827-1739364961=:31598--

