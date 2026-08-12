Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91802C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuBFy-0005A0-SF; Wed, 12 Aug 2026 11:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wuBFw-00058j-VT
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:52:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wuBFu-0004BI-47
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:52:40 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDbt8Z2728899
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WNqME8sMyP0ocgBqXPIWoieim6qWxLvjzL5WVX4xjvc=; b=QP/mRMJ1C7Vaclkz
 tZVuIun93fUvr8j3q4NsqHtKhNawg1xA8sE/IHUSIHkHto0JP2VvlI6iJOV5cEKl
 i2vwj8272ZpR/uGFTu9uWkcBGef36HrFZRstHrBWegBFoAcFopS9HJJzw8anHuJl
 KfBwM7hH3BjkdARaaXMtAVvNCYhwurC1+d+hbQ6DsDWpWpBk3kRlfM20HZq1ARza
 E9Z16CsFEFAfmN2kV5I23gp2gjCs+BxFixjEEaN9vpTWMXr7F4B95jInfLNjVOam
 y+oAGJ2oDSbMv7Y0akMwohx/Wd929LyPlZrJ5w6hoLsl294kbaZpGwIYuSWaEK0k
 0wPF6Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hfw2t7n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:52:36 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cec4226c70so15587805ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786549955; x=1787154755; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WNqME8sMyP0ocgBqXPIWoieim6qWxLvjzL5WVX4xjvc=;
 b=TLr8yACnVYRUlLtvTfA2dMb8RTnHsXcLqjjE38Daq9CmIXD9BK9Mc7ihwz87c3/jaf
 Is7bd4ICMvnnkBaPztZHt+/+SOXntxsoCs76SJ5tvuBF/rBKCrvR95BEdzxYOVY8yO3u
 WzQasIppKSxob7Sgg8YAF04JWO1nJU2hXjVlGXlvtvQKgplzQKLp3kG2Tn4NWnSj3IHI
 YZfaicR0Yne831T9T1k1tEQOr0KIzX0XNsVI6O+oMYNMDXkkkresWdZgh/zXND6Vgwes
 MOPqmHUC5YE8o244UAmYdftMKYvGHNuYOdAEY6u4T8t4yVRcFqXn1qCVnAMheKgg1j1r
 D06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786549955; x=1787154755;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WNqME8sMyP0ocgBqXPIWoieim6qWxLvjzL5WVX4xjvc=;
 b=DSTQxgrILdhngv9oNJ5xMgRSZ8EbYWf2as0XRYpnlO3MiG1VXi7uo5qHKeodRvweys
 aOh2p6d+yuAnBSgUol3Mn224EWUgD4R8wRWWgZ0DeOhd2YmuSdfQcEK+o1rXwG3oJvB3
 Wi8MEkJJ71F4GjxCTaDMOIz4oGjVKyY9NRpH/j387d5U3+KwlQR9LU42zatI3l5GHjL+
 HPKZzr4ZgKlvf9P3Mq8A8i55h0ogWDYko4VpMfXLh5CczF8k49ono6TGC04qrF/fmHPc
 6++hoPetVCTkuuu6uNCRhbcAtrQtuYILAtMXNI6LDZ6K4HthevLP9KYgwbETXrMQfTeG
 vBIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFj4kwSinbY9bTsGj9lyvCd1p9bWqzJVAccjzoYChD914Amyy4o3CxO75vkvxek1xdJqm01W0nyCmj@nongnu.org
X-Gm-Message-State: AOJu0YxBUqvf0aU97IN07d4EM/sADxve9gYQaRGBtt13/WW3OdKhII2e
 bwG/mZ5ffhyl5SWv0JGrVnXD5M+TNQtsjiEMwNxc11cyI0IVw2Kk7EOnHLm08Hjn7gAMpH97Hpc
 BdgNE4+cKpoWcHQa5HOfVK9VEM3xJZE/yuA33U2ya1ThJ+G95i5dlLAjVXA==
X-Gm-Gg: AR+sD1065TEjOnt7FNn3LdaDn15Es1OWchv7ZD5+OKblozBDacq5qA/FBW8YZ6ohWiO
 fxot6fYepJ2MxnSwpjKFoYjzmCb0jTMxU3jl4pxxp8NTCCIoR5TJoLA6cGZGvj5wsvE/gLGrHIa
 r7jKbn+1CDh3arGzfc9ToGGKy5gBysqyHlUeDWvBS43auLr/4GE6w38VQ+xHLnF08pSx1FvJVOd
 QdNtLxNTDaU0aH/MJia66fWRBIKuvhgIdPZpuJXNepTb2zvnqqmTF+J05gnX6TvmvIkxWiW0Agc
 2VWtMmWO8cTsuMhlDMex2CbrIqDz+JEmuY6cIbCGt4Ci8LaDEWT1sMwfFdd17nAUNW8XeJgWRbE
 E0p2GsIR/W7gi6SiihaTb1VyKDQfHpiASuDg/DUC20gqXsKv20nUffL6a+TeZBVHkX9oC
X-Received: by 2002:a17:90b:55c5:b0:381:bc4c:da5b with SMTP id
 98e67ed59e1d1-393017b600dmr7263792a91.18.1786549955268; 
 Wed, 12 Aug 2026 08:52:35 -0700 (PDT)
X-Received: by 2002:a17:90b:55c5:b0:381:bc4c:da5b with SMTP id
 98e67ed59e1d1-393017b600dmr7263713a91.18.1786549954651; 
 Wed, 12 Aug 2026 08:52:34 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f908a82bsm4038603a91.0.2026.08.12.08.52.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 08:52:34 -0700 (PDT)
Message-ID: <e40e5a75-cb20-4608-b628-f363068a36ba@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 08:52:33 -0700
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
References: <a9c89dd7-6317-42f1-9e03-30e48c2d08aa@oss.qualcomm.com>
 <anRgKw58IMYoR4p-@redhat.com>
 <5bda3566-5ce5-46dc-a281-2cc07a56dc6f@oss.qualcomm.com>
 <077fc585-a6b8-455a-abdc-fd72e13b8315@oss.qualcomm.com>
 <anTPOqFKWFKAX_3C@redhat.com>
 <102a3de8-ac17-429a-9294-e3b159aa642a@oss.qualcomm.com>
 <anxQdlwxAtqfl-N-@redhat.com>
 <cc88ff07-474f-48d6-a2a4-1a2c3f64f3fd@oss.qualcomm.com>
 <anxvMQpZlBUu5SaB@redhat.com>
 <9db3cc07-61e6-4740-823d-112ec80f216b@oss.qualcomm.com>
 <anyCswBYBZWeMt3I@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <anyCswBYBZWeMt3I@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOSBTYWx0ZWRfX4HlA1DFQk8Uf
 DjDQacGYuRl+9ZWqxBZ9OHGiuAHuoh+V5RxRBwTlzShpdSPpB4v6ZbV5A1HXIiFsoSleDYbdsz3
 OKqrhqb/nrmImbUty9tKyzxoC6nLOtk=
X-Proofpoint-GUID: 93djMng1Qh8CuwAU1FZWa1JgdgxGYIm_
X-Authority-Analysis: v=2.4 cv=fpDsol4f c=1 sm=1 tr=0 ts=6a7c96c4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=LZraz4wHKpTCNbm4znUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 93djMng1Qh8CuwAU1FZWa1JgdgxGYIm_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOSBTYWx0ZWRfX1oH0Z9x7MMIG
 Ah8ny4Y9vM8jTgKmqmxis8nROL1Hnru4v3LKbuKwHgi2M1ivYG78dw+jN1Rh48FapS66CVv52Og
 P0xky6Sx7wlxhWGnFlJd40K5BvSSj6FMirwGdZr+3nB01U32CW84LkexTbn834zGcUUAwsSkN8J
 jXHZH822/tqpeOBLVg4CTabHrpoUkRVr1y6xySMpmjbAvFvoaUXbYWmMcGfHqfdYxGh4zAEwvUc
 9hL/3rLTR3ts4jSOLwbUwtYblzfaO3M0apCV7DF4fPKzY6ZCOnd7Hv+k097DR2eFPdA8zyfEdcx
 9Xq0VokKIz/CByjjwrLZAzSQD81BcRDUEGwL+da7esrQSCG0LTbK3ZLv68U8rEPTEt2r4t3qqx6
 i91F61iL9Z0O/p/NrL044qrGCFROgOXV2RAbXfrDuNVc3JY34hga58kgHAfbGdRFlVtFQ3zvd6P
 LwBGNFJQtJJrOPOjK9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120129
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 8/12/2026 7:26 AM, Daniel P. Berrangé wrote:
> On Wed, Aug 12, 2026 at 07:09:29AM -0700, Pierrick Bouvier wrote:
>> On 8/12/2026 6:03 AM, Daniel P. Berrangé wrote:
>>> On Wed, Aug 12, 2026 at 05:54:49AM -0700, Pierrick Bouvier wrote:
>>>> On 8/12/2026 3:52 AM, Daniel P. Berrangé wrote:
>>>>> On Mon, Aug 10, 2026 at 03:26:26PM -0700, Pierrick Bouvier wrote:
>>>>>> I have been experimenting today with static filtering of types, as you
>>>>>> suggested, and came up with two possibilities. Before implementing this
>>>>>> for all types, I would like to get some feedback on which way is the
>>>>>> best for you.
>>>>>>
>>>>>> 1. Add a new callback is_available to TypeInfo, similar to existing
>>>>>> interface.
>>>>>> Pros: local information is present in type definition, making obvious
>>>>>>       why a type is available or not. Very easy to implement
>>>>>>       since only type_register_static has to be modified to check it.
>>>>>> Cons: Add a new field to each existing type. Not the end of the world
>>>>>>       in terms of memory consumption, but worth mentioning.
>>>>>> 2. Add conditional around each type_register_static, or add an
>>>>>> alternative type_register_static_cond function.
>>>>>> Pros: I don't see any
>>>>>> Cons: Decouples type information from type definition, makes it harder
>>>>>>       to follow why a type is available or not. Much more verbose since
>>>>>>       we need to modify all type_register_static buried in macros.
>>>>>>
>>>>>> Based on this, I'm much more in favor or 1. The fact availability
>>>>>> information is in the same location than type definition is the biggest
>>>>>> advantage for me.
>>>>>>
>>>>>> On example given above, this would give something like this:
>>>>>> static const TypeInfo emulated_card_info = {
>>>>>>      .name          = TYPE_EMULATED_CCID,
>>>>>>      .parent        = TYPE_CCID_CARD,
>>>>>>      .instance_size = sizeof(EmulatedState),
>>>>>>      .class_init    = emulated_class_initfn,
>>>>>>      .is_available  = target_config_X,
>>>>>> };
>>>>>>
>>>>>> Would that work for you?
>>>>>> Do you have a 3rd way to offer to solve the problem we have?
>>>>>
>>>>> In the case of user creatable objects, we represented a classes'
>>>>> conditional availablity in QAPI schema. For example:
>>>>>
>>>>>   { 'struct': 'InputLinuxProperties',
>>>>>     'data': { 'evdev': 'str',
>>>>>               '*grab_all': 'bool',
>>>>>               '*repeat': 'bool',
>>>>>               '*grab-toggle': 'GrabToggleKeys' },
>>>>>     'if': 'CONFIG_LINUX' }
>>>>>
>>>>> Now this isn't quite a match for what we want, as QAPI schema is
>>>>> common to all targets and used to control the code generator to
>>>>> turn off output. Thus the permitted CONFIG_xxx are only those in
>>>>> config-host.mak, not any from $TARGET-softmmu-config-devices.mak
>>>>>
>>>>> The other scenario in QAPI is the concept of features:
>>>>>
>>>>> { 'struct': 'SevCommonProperties',
>>>>>   'data': { '*sev-device': 'str',
>>>>>             '*cbitpos': 'uint32',
>>>>>             'reduced-phys-bits': 'uint32',
>>>>>             '*kernel-hashes': 'bool' },
>>>>>   'features': ['confidential-guest-reset']}
>>>>>
>>>>> where again we just have a list of named strings. Features are fully
>>>>> dynamic, and crucially they are introspectable so applications can
>>>>> query at runtime what is available.
>>>>>
>>>>> The introspection concept is something that is highly likely to be
>>>>> relevant to our use cases here. If we have a single binary with all
>>>>> types, it would be very valuable to be able to query it once to
>>>>> discover everything in one go, instead of havnig to query it over
>>>>> and over again for each target. That implies the application doing
>>>>> the query needs to be told about per-target usage restrictions on
>>>>> types it is querying.
>>>>>
>>>>> We don't have QAPI schema for QDev devices currently, but it is likely
>>>>> we will do so in the future. We can't wait for that though as there is
>>>>> no clear ETA.
>>>>>
>>>>> What this all says to me though, is that instead of an 'is_available'
>>>>> method, we should instead just list the conditions as data in the
>>>>> TypeInfo struct directly. IOW a list of const strings like this:
>>>>>
>>>>>  static const TypeInfo emulated_card_info = {
>>>>>       .name          = TYPE_EMULATED_CCID,
>>>>>       .parent        = TYPE_CCID_CARD,
>>>>>       .instance_size = sizeof(EmulatedState),
>>>>>       .class_init    = emulated_class_initfn,
>>>>>       .available     = (const char *[]){ TARGET_AARCH64, CONFIG_something .... },
>>>>>  };
>>>>>
>>>>> This will make it easy to add in introspection at a later date.
>>>>>
>>>>> The limitation is that this can only express an "AND" condition.
>>>>> You can not do complex AND+OR+grouping conditions that you could
>>>>> express in code, but IMHO that is not likely to be a problem.
>>>>> In the worst case you can define a higher level "CONFIG_BLAH"
>>>>> that encapsulates the complex condition.
>>>>>
>>>>
>>>> Those strings names reuse existing target config identifiers, which
>>>> can't be done because of config poisoning.
>>>> The string compare will definitively be visible at boot time, so we
>>>> should rely on enum instead if we go in this direction.
>>>>
>>>> I'm a bit worried about verbosity of the result:
>>>> .available     = (const char *[]){ ENUM_NAME_TARGET_AARCH64, {} }
>>>> versus:
>>>> is_available = target_aarch64
>>>
>>> The verbosity could be hidden behind a macro that takes a tar
>>>
>>> #define QOM_AVAIL_TGT(name) \
>>>    .available = (const char *[]) ENUM_TARGET # name, NULL }
>>>
>>> So usage becomes
>>>
>>>   static const TypeInfo emulated_card_info = {
>>>      .name          = TYPE_EMULATED_CCID,
>>>      .parent        = TYPE_CCID_CARD,
>>>      .instance_size = sizeof(EmulatedState),
>>>      .class_init    = emulated_class_initfn,
>>>      QOM_AVAIL_TGT(AARCH64),
>>>   }
>>>
>>> A separate macro could be defined for the more complex case
>>> wanting multiple config options.
>>>
>>
>> Then we'll have different macros for:
>> one target, a collection of target, a mix of target and config, config
>> only. Plus, we hide what was clear in the first place with:
>> .is_available = target_aarch64.
>> I'm not super fond of the result to be honest.
> 
> That's a different interpration of "clear".
> 
> What I'm proposing exposes the rules as data, and that ensures
> the rules are clear to machines.
> 
> What you're proposing exposes the rules as code and that is only
> clear to human reviewers.
>

Agree, I will always prefer what is clear for human to read/understand.
That said, your requirement is fair also, and I see the value in
describing rules instead of a function pointer.
We both agree to add a field in TypeInfo, that's a good start.

I'll do my best to add something that satisfies both in next version.

>>  >> 99% of the types will be filtered by target only, for which we have
>>>> functions in target-info API. Only a few of them will need custom
>>>> functions. It would be worth having a nice/short way to write this
>>>> without having to declare all combination in a file.
>>>> One of your point was to not include more macros, and seems like we'll
>>>> end up this way.
>>>
>>> In this case the macros expand to data that is machine consumable
>>> at runtime, so I thjnk that's a good tradeoff.
>>>
>>>> The introspection argument is good, but will we really need that? The
>>>> whole point of conversation was to register only types available,
>>>> ignoring the rest. If you want introspection, it means registering all
>>>> types and selectively filter them.
>>>
>>> Yes, introspection is critical to mgmt apps and places where we
>>> forget/miss it cause endless pain.
>>>
>>
>> We can easily make a mechanical replace on all '^\s*\.is_available'
>> lines when it will be needed. Feels like we are anticipating a bit too
>> much, and there would be no cost to change that later.
>>
>> I would kindly ask again to consider if you would be ok to delay this to
>> when it's effectively introduced on QAPI side.
>>
>> Would you be open to it?
> 
> Introspection has always been a critical problem in QEMU and rectifying
> it after the fact is very costly. IMHO we need to do this as data from
> day one rather than knowingly taking a path that makes introspection
> harder.
> 
> 
> With regards,
> Daniel

Thanks for the feedback, and glad we found a solution that works for
both of us.

Regards,
Pierrick

