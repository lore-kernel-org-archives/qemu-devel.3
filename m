Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36799C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9eI-0006qJ-Pw; Wed, 12 Aug 2026 10:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wu9eD-0006nC-IT
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:09:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wu9eB-0003Zg-72
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:09:37 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDbTR6320208
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UvLCE+UKf7LdRqNhoyD92pl86OMH0Ydf74WQexXDtaI=; b=dt5Z7RrGiA8iYLZC
 yLoKMtc6atDzquFfjPBuAbaagkFndDzod4I0Q/699m0kyErkNsmhz5f5Se8ykLqi
 8szrZ2/qX52F3KFmVV8/sFzCF6n47EIdVxp4NbU9cpQc3Vx7uE/CzPT4A0LXG9LZ
 5Vdz3iRJabnlOnqqOUeYu75HiiJq1bdFQnOdcMQsXoQz3IKUQ1XUj0dmoKVmH2xQ
 yxmj55MJKbj5nUYlKTKFjxBIhCeRFnNGIlCTOMzTXfqxv+NlUvoNhPp24dWbP19K
 kHMJZMu6npTkrEDkHI+aK0fdd3fjnpkCUekMQMSOFZM1+7d7g0xCRUhbyD0HUHBL
 vppVDQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0sk407p3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:09:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ccb687f82eso17030645ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786543772; x=1787148572; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UvLCE+UKf7LdRqNhoyD92pl86OMH0Ydf74WQexXDtaI=;
 b=dpHghkqlNtNniTXDItT6x2AljcmIBwu51hg3s0zmSF5WUP/sVqTlEO2lDLXAbRirxs
 5pgw85adjK/iTo5Gq1cD4R7AtUQILXc47EnkHhJjbImDr6tR0ixRZsGVIt+2x3IRL067
 tquDPBlPr1YvSUoyjGYbHxSoaidetkIodsWmXIw+SeEUXzQFvZ6cgtnlSJQOq10gKKFS
 Zf/J582LljUq/gF7z6j4csvIgdv5DeZR6qM+rF+kiL5HXRqa0MO/rAY6zSACF9ywpYZ4
 MqLgaMDCrAF/6L5V5UYVmXC5QZx7ccRSaRb+oxxVWI478RVeuEGsruDEnGIRbwmpEOfz
 hLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786543772; x=1787148572;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UvLCE+UKf7LdRqNhoyD92pl86OMH0Ydf74WQexXDtaI=;
 b=g6sl9zF5DlbnXh5ZB3U5FaqV6/V7Y+LvzWxD0leF2W5DrdRzyJRYdATFwUc7NEggs9
 BxGgCCMcRqQnNbfQiS1fV90T9eR0lIbTG3HhpePoFubRgzQfe1vr92xBmPbs+XPI3uV7
 m+5j17uaGUlJ1lmd78iobzuOe5EXayqSyuOjf7kIsUyWAMdR9So6GQzAkA7Quy48uub3
 TB26z1WP7DNE5c0vWbQzyK91ugbi7xGis3Wv/N6bJAf1agMQO9S++m7FJy7ZSYmsy4WY
 MKEDBUhDBWjwap2FcNhfmotWix7gccG1PpmHjpOKRd8ADCGdVL0LgoDXtypbiJMl/fxr
 z5sA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqal02xWAop5/lxqqROndvTuhVeOUqQXk2f39l+sSr2GwntIPlOWdSRWT0FjabsK/BRpeAZYfeCpLZO@nongnu.org
X-Gm-Message-State: AOJu0Yy0SL0Fq89QVRA5/mG3q9nL68pFRoIL1+h15Yu4YDY3sDYthttN
 4gxQoA/8S1FGE2ixi0y4O4X6qG3ELnQhFipc0dPL4NB2puAq6I3QrGPjqfF076afJHluG8WgtsG
 47ZntFLAK/PmL8KJvZZkSxi/qTkUut94y81FjJiXiPc4RgHCVp75ufHcSfQ==
X-Gm-Gg: AR+sD13qfnYyN0hE5ig0rzXYyl1yLvh1UIF1Psn5cq3O5wIC25IhXaWOgNKegb+FIXA
 jefgrGJ4RO3AZB4+hbU6NPP7DQKvBGvGOpalRWXa04+5z5imp6CEhSK5EwZ8ZQdhk3qmG3f1fxZ
 t32pb4R2kWQ+Af9ya7Hdl3gTE4dujbpA2BDn37GXlDT5JoJ20NLOdJl0iJA8v90/yahvibYvktU
 hMRNn1TY6T3Q4BvECvACQsCnoDozrciBS2Ds8z39RZ2bIi7YSo55K/eyHIpvsBZIqTtjnQvXSQj
 NDJEXcdBxbkI7jxa+Z8VX+ZYvG7Sp+sJSd4gfZLjkFvxZbATPqwFCKK7kl0rqknino5XKLj6sqK
 EkwilY3Zn9uHBFuInCywFyCbb9sFCEg9qsfkOkR/0Ss6h7Ed3Asd7XgjHmxtQsYLJsBVA
X-Received: by 2002:a17:902:ef11:b0:2ca:17e2:2acc with SMTP id
 d9443c01a7336-2d34574705fmr70143415ad.21.1786543771971; 
 Wed, 12 Aug 2026 07:09:31 -0700 (PDT)
X-Received: by 2002:a17:902:ef11:b0:2ca:17e2:2acc with SMTP id
 d9443c01a7336-2d34574705fmr70141695ad.21.1786543771244; 
 Wed, 12 Aug 2026 07:09:31 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d350fb0cc5sm7280955ad.14.2026.08.12.07.09.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 07:09:30 -0700 (PDT)
Message-ID: <9db3cc07-61e6-4740-823d-112ec80f216b@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 07:09:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] include/qemu/target-info-qom.h: declare
 TYPE_TARGET_SPECIFIC interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <adfd5a5f-c237-4634-9c0b-14389c0f3585@oss.qualcomm.com>
 <anNqhjSU5tEDC0br@redhat.com>
 <a9c89dd7-6317-42f1-9e03-30e48c2d08aa@oss.qualcomm.com>
 <anRgKw58IMYoR4p-@redhat.com>
 <5bda3566-5ce5-46dc-a281-2cc07a56dc6f@oss.qualcomm.com>
 <077fc585-a6b8-455a-abdc-fd72e13b8315@oss.qualcomm.com>
 <anTPOqFKWFKAX_3C@redhat.com>
 <102a3de8-ac17-429a-9294-e3b159aa642a@oss.qualcomm.com>
 <anxQdlwxAtqfl-N-@redhat.com>
 <cc88ff07-474f-48d6-a2a4-1a2c3f64f3fd@oss.qualcomm.com>
 <anxvMQpZlBUu5SaB@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <anxvMQpZlBUu5SaB@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3t1wsLvt2Bm0bY3HQkeYLb5Vt7XXrO45
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExNSBTYWx0ZWRfX/vDdoe50KP1D
 nT04U7wwJo6eXc/VYMcZ8MjUGyA1JcI2fGHRidlNBfUh3lwMvPZ4ahCKD/8Aj7bUBJuW8j1rdOU
 kGbrEqcjp5AIGH4Gn+So0qeY8d8HcZvtroJqYJpDoeZHEKjRrJJJqONxOam0WyerCs9BhsFEfEj
 bz9AUcKEO3754GYArg/IXld7ivx9ImPSBen5WKRjAbw+bQ/bnQyOA3D9uEsPINpziE6ujefsD8V
 yWU26l19d9dTkwYn7MLfmMbNMjHtpROsf9SJFP/aZS2wPCpdHTPjRzJUnF3lMVXha3uZAXHTKTc
 fehpSmlAtOPxaKTYc0tVC8LZmxXsAxWtgcOd2fvfXpb7KGrbDgAa2sX0Lex5hMNx9kuIvZKzCix
 RO0mGbUk6yPpnC7c4AlRnakIpO/8jLUXZzZH1xgD3V+5Bk8nftAGBqoV1AXWDez+DgPQotsnQ+B
 Q7EW6V+glrmXPxrebwA==
X-Authority-Analysis: v=2.4 cv=E8n9Y6dl c=1 sm=1 tr=0 ts=6a7c7e9c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=tfLtEAqYAw_bzBBtwT0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExNSBTYWx0ZWRfX2eY8IsLeB8Xd
 HtoZHefOOErjfi8XF6xoypUoyAK6CZ9AOY9hz2CUck6GhjRWKYdFVlCresjdtthRQPlwgPN5lcW
 qHN+wCFDJIyM5F3GAJe4yAsmlTGYZ8Q=
X-Proofpoint-ORIG-GUID: 3t1wsLvt2Bm0bY3HQkeYLb5Vt7XXrO45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120115
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/12/2026 6:03 AM, Daniel P. Berrangé wrote:
> On Wed, Aug 12, 2026 at 05:54:49AM -0700, Pierrick Bouvier wrote:
>> On 8/12/2026 3:52 AM, Daniel P. Berrangé wrote:
>>> On Mon, Aug 10, 2026 at 03:26:26PM -0700, Pierrick Bouvier wrote:
>>>> I have been experimenting today with static filtering of types, as you
>>>> suggested, and came up with two possibilities. Before implementing this
>>>> for all types, I would like to get some feedback on which way is the
>>>> best for you.
>>>>
>>>> 1. Add a new callback is_available to TypeInfo, similar to existing
>>>> interface.
>>>> Pros: local information is present in type definition, making obvious
>>>>       why a type is available or not. Very easy to implement
>>>>       since only type_register_static has to be modified to check it.
>>>> Cons: Add a new field to each existing type. Not the end of the world
>>>>       in terms of memory consumption, but worth mentioning.
>>>> 2. Add conditional around each type_register_static, or add an
>>>> alternative type_register_static_cond function.
>>>> Pros: I don't see any
>>>> Cons: Decouples type information from type definition, makes it harder
>>>>       to follow why a type is available or not. Much more verbose since
>>>>       we need to modify all type_register_static buried in macros.
>>>>
>>>> Based on this, I'm much more in favor or 1. The fact availability
>>>> information is in the same location than type definition is the biggest
>>>> advantage for me.
>>>>
>>>> On example given above, this would give something like this:
>>>> static const TypeInfo emulated_card_info = {
>>>>      .name          = TYPE_EMULATED_CCID,
>>>>      .parent        = TYPE_CCID_CARD,
>>>>      .instance_size = sizeof(EmulatedState),
>>>>      .class_init    = emulated_class_initfn,
>>>>      .is_available  = target_config_X,
>>>> };
>>>>
>>>> Would that work for you?
>>>> Do you have a 3rd way to offer to solve the problem we have?
>>>
>>> In the case of user creatable objects, we represented a classes'
>>> conditional availablity in QAPI schema. For example:
>>>
>>>   { 'struct': 'InputLinuxProperties',
>>>     'data': { 'evdev': 'str',
>>>               '*grab_all': 'bool',
>>>               '*repeat': 'bool',
>>>               '*grab-toggle': 'GrabToggleKeys' },
>>>     'if': 'CONFIG_LINUX' }
>>>
>>> Now this isn't quite a match for what we want, as QAPI schema is
>>> common to all targets and used to control the code generator to
>>> turn off output. Thus the permitted CONFIG_xxx are only those in
>>> config-host.mak, not any from $TARGET-softmmu-config-devices.mak
>>>
>>> The other scenario in QAPI is the concept of features:
>>>
>>> { 'struct': 'SevCommonProperties',
>>>   'data': { '*sev-device': 'str',
>>>             '*cbitpos': 'uint32',
>>>             'reduced-phys-bits': 'uint32',
>>>             '*kernel-hashes': 'bool' },
>>>   'features': ['confidential-guest-reset']}
>>>
>>> where again we just have a list of named strings. Features are fully
>>> dynamic, and crucially they are introspectable so applications can
>>> query at runtime what is available.
>>>
>>> The introspection concept is something that is highly likely to be
>>> relevant to our use cases here. If we have a single binary with all
>>> types, it would be very valuable to be able to query it once to
>>> discover everything in one go, instead of havnig to query it over
>>> and over again for each target. That implies the application doing
>>> the query needs to be told about per-target usage restrictions on
>>> types it is querying.
>>>
>>> We don't have QAPI schema for QDev devices currently, but it is likely
>>> we will do so in the future. We can't wait for that though as there is
>>> no clear ETA.
>>>
>>> What this all says to me though, is that instead of an 'is_available'
>>> method, we should instead just list the conditions as data in the
>>> TypeInfo struct directly. IOW a list of const strings like this:
>>>
>>>  static const TypeInfo emulated_card_info = {
>>>       .name          = TYPE_EMULATED_CCID,
>>>       .parent        = TYPE_CCID_CARD,
>>>       .instance_size = sizeof(EmulatedState),
>>>       .class_init    = emulated_class_initfn,
>>>       .available     = (const char *[]){ TARGET_AARCH64, CONFIG_something .... },
>>>  };
>>>
>>> This will make it easy to add in introspection at a later date.
>>>
>>> The limitation is that this can only express an "AND" condition.
>>> You can not do complex AND+OR+grouping conditions that you could
>>> express in code, but IMHO that is not likely to be a problem.
>>> In the worst case you can define a higher level "CONFIG_BLAH"
>>> that encapsulates the complex condition.
>>>
>>
>> Those strings names reuse existing target config identifiers, which
>> can't be done because of config poisoning.
>> The string compare will definitively be visible at boot time, so we
>> should rely on enum instead if we go in this direction.
>>
>> I'm a bit worried about verbosity of the result:
>> .available     = (const char *[]){ ENUM_NAME_TARGET_AARCH64, {} }
>> versus:
>> is_available = target_aarch64
> 
> The verbosity could be hidden behind a macro that takes a tar
> 
> #define QOM_AVAIL_TGT(name) \
>    .available = (const char *[]) ENUM_TARGET # name, NULL }
> 
> So usage becomes
> 
>   static const TypeInfo emulated_card_info = {
>      .name          = TYPE_EMULATED_CCID,
>      .parent        = TYPE_CCID_CARD,
>      .instance_size = sizeof(EmulatedState),
>      .class_init    = emulated_class_initfn,
>      QOM_AVAIL_TGT(AARCH64),
>   }
> 
> A separate macro could be defined for the more complex case
> wanting multiple config options.
>

Then we'll have different macros for:
one target, a collection of target, a mix of target and config, config
only. Plus, we hide what was clear in the first place with:
.is_available = target_aarch64.

I'm not super fond of the result to be honest.
 >> 99% of the types will be filtered by target only, for which we have
>> functions in target-info API. Only a few of them will need custom
>> functions. It would be worth having a nice/short way to write this
>> without having to declare all combination in a file.
>> One of your point was to not include more macros, and seems like we'll
>> end up this way.
> 
> In this case the macros expand to data that is machine consumable
> at runtime, so I thjnk that's a good tradeoff.
> 
>> The introspection argument is good, but will we really need that? The
>> whole point of conversation was to register only types available,
>> ignoring the rest. If you want introspection, it means registering all
>> types and selectively filter them.
> 
> Yes, introspection is critical to mgmt apps and places where we
> forget/miss it cause endless pain.
>

We can easily make a mechanical replace on all '^\s*\.is_available'
lines when it will be needed. Feels like we are anticipating a bit too
much, and there would be no cost to change that later.

I would kindly ask again to consider if you would be ok to delay this to
when it's effectively introduced on QAPI side.

Would you be open to it?

> With regards,
> Daniel

Regards,
Pierrick

