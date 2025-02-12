Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD2BC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 14:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiDLA-0006pc-Qu; Wed, 12 Feb 2025 09:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiDL7-0006oZ-Gg
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:03:46 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiDL5-0006XS-FX
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:03:45 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38dd935a267so3126096f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 06:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739369022; x=1739973822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kAH2qclmGgBA3ka8vJzUEw7N4C7mBg3fIza94AFCUGI=;
 b=UbkiZW39MrY0A/jnjsPCqfVFfhFXyM/hjOB2w+7c1WQwVm5ege+38p3A+SdVKNrb0n
 uH5fSq7LITLpNbWOA8vPFX638penPK1iqJKhSlXK8qvfTwmiWSVrdyHcaL2mGtjUonZs
 jAlveIy8l+mXrbWmjqw4iqCERwRRzzwXbtvz9iLIrk2c0JxOxJUXEaOJwor9SlCH8FTM
 fKanWyyGwKqAnnZlgzEob7SZXVWavRz1EBGr3ffzfJawPJF7+hy6w6vRPfIsvr9nYgvf
 fDqWfKwTm+X7c2ErvpDW1/rjPIyqAVLa/m2mkbINjxA1bO2PKMT1vajm5vzMabEDSNfD
 5tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739369022; x=1739973822;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kAH2qclmGgBA3ka8vJzUEw7N4C7mBg3fIza94AFCUGI=;
 b=jLDo2t0S/GPAGklCiToNTdCxZSjzwdksV0v3q3KOGZpwJq7Q+iwC1I4bPeBHbi1CWb
 MnkgAaQ2r4IXKOW20OgFCDItqhrPv9zpWSzpwP63VdfEVaRI9zvZPqPlt2Xx9zqucpor
 mh5pYDzXHnSp+n6LvNv36xoOKVFJcU1DxtsRW2aqrZzpX+gao8iE0SqadRQqI2jvc4xB
 VD0tK+HlYhLF+mKetCE0tfYcyKsdtO+gKUsIH1jXpxQz8JNUT9YRj5YnhFwRkwhnHFnU
 mSWm2VggIzt5nuqWE6wy0SdJyJRYm6foMufqJSKqW5slwFd2N9SSJiPkJyAMqMIYxr3o
 Vm3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvADL2aSA5qdmLAbSnMluymUst6rCS8hvfZZe8V1COKZ/BUmT/17PYwEfmQas6gdstN3+JueJSIfLo@nongnu.org
X-Gm-Message-State: AOJu0YwzqsDOOqHgbRZS2DtolB8Skam/l+Ko/nTAUV/M0Tpyy24Cm+oS
 dEUMIfhPtPVYrZg5WBdIzxjc4CsZ2BUgtIKakLqJI9MhrqVbzD96Z0PCFZwGoWA=
X-Gm-Gg: ASbGncsrDUeg91jVEROO6tuMh3q+yj0XSUoggTX4i5NAjapVYm17RcWUagdmvf8+DU1
 yz7rDIiWpBItS1MeYlMtXu4Td+Og94QJvZFa7LiH+052g9wviDgiM/HSA0wTsTsLGC7DjETRL1+
 G/E5wFnMxuQy7B0KLWysraNND7ouKSDXasU3M0bvmHRu6KURxlmRDB83LWPsXRbP6E6lKETMBUn
 qe4auohZO9j/3TAgdr6+auhiMh9d9lD0gOfNLYK5GdhXM5MaufD0HKTo/Rjmc+72Ejg/6dInDAh
 jo4dYx19zldipSshTF/zLwYFyJs3iL27y36JSpt61jDvWGkS9btsc90awrQ=
X-Google-Smtp-Source: AGHT+IGEf2YuUGY1vo8xQmGC8IuKzzqXdWx4AHY5ax9Y3JFPirG0TdNyckGhDpiEc1MuI0gcWZtlTw==
X-Received: by 2002:a05:6000:184:b0:38d:b448:8ffc with SMTP id
 ffacd0b85a97d-38dea28eb1cmr2337831f8f.27.1739369021551; 
 Wed, 12 Feb 2025 06:03:41 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1b84bcsm21489225e9.40.2025.02.12.06.03.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 06:03:40 -0800 (PST)
Message-ID: <a3608e43-79ce-403d-8ba7-6735fde66759@linaro.org>
Date: Wed, 12 Feb 2025 15:03:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/11] hw/qdev-properties-system: Introduce EndianMode
 QAPI enum
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250212112413.37553-1-philmd@linaro.org>
 <20250212112413.37553-2-philmd@linaro.org>
 <cb828dd8-25f6-47c6-9ac7-cae5b0d0932e@redhat.com>
 <50ba4e4b-4124-46bb-bb84-4758ce9c5e66@linaro.org>
 <3b3baed4-0d79-3a28-40cd-e1835e078863@eik.bme.hu>
 <6e707c7f-b94c-47ef-83ab-795605e27963@linaro.org>
Content-Language: en-US
In-Reply-To: <6e707c7f-b94c-47ef-83ab-795605e27963@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 12/2/25 14:53, Philippe Mathieu-Daudé wrote:
> On 12/2/25 13:56, BALATON Zoltan wrote:
>> On Wed, 12 Feb 2025, Philippe Mathieu-Daudé wrote:
>>> On 12/2/25 12:37, Thomas Huth wrote:
>>>> On 12/02/2025 12.24, Philippe Mathieu-Daudé wrote:
>>>>> Introduce the EndianMode type and the DEFINE_PROP_ENDIAN() macros.
>>>>> Endianness can be BIG, LITTLE or unspecified (default).
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>>   qapi/common.json                    | 16 ++++++++++++++++
>>>>>   include/hw/qdev-properties-system.h |  7 +++++++
>>>>>   hw/core/qdev-properties-system.c    | 11 +++++++++++
>>>>>   3 files changed, 34 insertions(+)
>>>>>
>>>>> diff --git a/qapi/common.json b/qapi/common.json
>>>>> index 6ffc7a37890..217feaaf683 100644
>>>>> --- a/qapi/common.json
>>>>> +++ b/qapi/common.json
>>>>> @@ -212,3 +212,19 @@
>>>>>   ##
>>>>>   { 'struct': 'HumanReadableText',
>>>>>     'data': { 'human-readable-text': 'str' } }
>>>>> +
>>>>> +##
>>>>> +# @EndianMode:
>>>>> +#
>>>>> +# An enumeration of three options: little, big, and unspecified
>>>>> +#
>>>>> +# @little: Little endianness
>>>>> +#
>>>>> +# @big: Big endianness
>>>>> +#
>>>>> +# @unspecified: Endianness not specified
>>>>> +#
>>>>> +# Since: 10.0
>>>>> +##
>>>>> +{ 'enum': 'EndianMode',
>>>>> +  'data': [ 'little', 'big', 'unspecified' ] }
>>>>
>>>> Should 'unspecified' come first? ... so that it gets the value 0, 
>>>> i.e. when someone forgets to properly initialize a related variable, 
>>>> the chances are higher that it ends up as "unspecified" than as 
>>>> "little" ?
>>>
>>> Hmm but then in this series the dual-endianness regions are defined as:
>>>
>>> +static const MemoryRegionOps pic_ops[2] = {
>>> +    [0 ... 1] = {
>>
>> This is already confusing as you'd have to know that 0 and 1 here 
>> means ENDIAN_MODE_LITTLE and ENDIAN_MODE_BIG (using those constants 
>> here as well might be clearer). It's easy to miss what this does so 

At this point 0 / 1 only mean "from the index #0 included to the index
#1 included", 0 being the first one and 1 the last one.

>> maybe repeating the definitions for each case would be longer but less 
>> confusing and then it does not matter what the values are.

This is what I tried to do with:

+    [ENDIAN_MODE_BIG].endianness = DEVICE_BIG_ENDIAN,
+    [ENDIAN_MODE_LITTLE].endianness = DEVICE_LITTLE_ENDIAN,
};

but in v7 we are back of picking an arbitrary value.

>> Or what uses the ops.endianness now should look at the property 
>> introduced by this patch to avoid having to propagate it like below 
>> and drop the ops.endianness? Or it should move to the memory region 
>> and set when the ops are assigned?
> 
> I'm not understanding well what you ask, but maybe the answer is in v7 :)


