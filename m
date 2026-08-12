Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818BEC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8U1-0002xR-Ji; Wed, 12 Aug 2026 08:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wu8Tx-0002nz-EL
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:54:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wu8Tv-0001vg-2Z
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:54:57 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4KGD2860166
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GBGRRvj03gYSCG02/KIg50vEkQRzKysIBeYujWe/1K4=; b=Q/sj7CHnUb2jV7WN
 qCOmqyUola+/PEXpkhNpNpXf1kwWbNvNOTQMiEkoQGenTkRLbZ2R8MuYs14oNnai
 YLe7tZ0uHRa7vywfbkRqTeNnV+/alhLTPcg2Wq4dr4DAwEOhCDlUbo+iBm59oajX
 yHT8EolmX0x1FTrGLmMYum/YR5t8bvLbe7ROsWsQEGQ4LRBgpHOdV17HWLq8s25N
 KzWjsevcmIkolEybHnvvtgae+pjKjOLW77GamnXM0Cav+TGJKTvnNT+jkXHn6oG4
 9HX3zMtzc+lrdkIge5hqnw5ifD9fVnfPZQZLiAaWBIs8BpB0x9RxUtzc9vlXmV3J
 DNf/3g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0mnd94w9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:54:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so1472138a91.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786539291; x=1787144091; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GBGRRvj03gYSCG02/KIg50vEkQRzKysIBeYujWe/1K4=;
 b=JriXJQ3o0wdDWwYEJm7JZIRyoKXAu2koZKG/kR1Qgf+sgr/koZx9jRxQhz1gZUY285
 lFarD8dd051dLawO/by3/FLQ4XeB8YNp8f/JcUh6dMUeHajBsXyB61Ho++9Izp5ef1j1
 YLOLQR5V4CB+ueGK3xC9RyHum7c0CxheZ/Dq6g1r6mgnaUstEM4/xtgsiDqt3kbrxsav
 2SqkyRTmM0M7vMb85BGS98Z2C+JvoGhoLQe/PaNX8VxByKK9H9b5yJT8yd/q8Rqy/K3Y
 umpg8Db+J46e2HJ8JTAoI4RP6l85DBgcIqvLqAzmHc3PFyJPsTDcXBdSps2wPlFVJV/S
 GiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786539291; x=1787144091;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GBGRRvj03gYSCG02/KIg50vEkQRzKysIBeYujWe/1K4=;
 b=EMHaTXT4nJq/Bk3O4sNMyE+TSt5XlqV2drLIJfAN6JAvdWVhc7HS+RD9ZNmTmrF7EH
 HMUgc6uOfZ6WJPgRnm9QrsYdMAM8GY6KbcvsKH2kEbaLjGI2wtyifmLyoCKcbdr2T92G
 87f1smFaiVHuHrH8/Oc84rMfQavLrUzEUgihqLL98RFfROQPQ/1EdUC7Ah8c+xbpCit6
 MMKT4HgfH50e8+JXC+RD20pOVK+qM988tiCWeF+J+KkeMrhJiBC8LduExPOtZ8KYsW7y
 lxuI6ddooQO6vgmOasL36KTagoNPKzJd4uje7OppR/uSRUCFb9Fr6sPv1fgy2C5WgyO2
 28fw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ros9Gr6Fn/n48P7idQZifUAOx/PWPlEugwY5gt9c3u/TE846NdIL7YnsEkt6L2fhiNf9zBqNPvLEjis@nongnu.org
X-Gm-Message-State: AOJu0YxVWmiW+AlwTQrs/4nwdg80J8jpZ1wXm4fc8WoS7CSESZiol5aJ
 ySQ59AXteQsDIkU4M6HJXUIVpj/TBqEu9sV68xqZMGsE1I3aLqiC/gUP+2TVABfnw2gCBgEoOsc
 jdXap/oXXEgT265SMds1LLsjLTR+GUJ4ndVjAw0ZLOnxSUH+6SqzkWh3djw==
X-Gm-Gg: AR+sD124NZXvza5exeMwegckyed4KTXhyO68c1yIx8sGvKzTHm943RU2TLa8GIoEvZl
 AFobh0+GZLMOx7Ule0qwrV4xIuLIB2DbZgGIXx0tc22H7C1IiQX7f1mflU+wMTQ3fHzjZnsLZZM
 J41K1+EeBPlaodzugun0k147ci2Ys213myg5JK5xkyp+r/eB29NzIyZElyJ1k8cuaDW06kjER0f
 yg46znNAEyD4OR9o4HJ0fqffT90ScdCYKmtOIJNLVt0nqky+l5uku8/c3z9jl2iCVBaCM0AOUV3
 O6UNB8PfyQvSIQHtK6oTuJ0blmuxV6NX9OSY0qY/Ez8QtHXTkz3XikYIoqgu94mt6z39OmjfUk8
 r6pdvU+h1UmESLQqdYsUWSEdMISiZBL8iLVTAOUZ3labjA4EyulhNwi7on3t2uj8UBlFt
X-Received: by 2002:a17:90b:384f:b0:38f:dec8:f7e9 with SMTP id
 98e67ed59e1d1-393014b9560mr4356565a91.12.1786539291172; 
 Wed, 12 Aug 2026 05:54:51 -0700 (PDT)
X-Received: by 2002:a17:90b:384f:b0:38f:dec8:f7e9 with SMTP id
 98e67ed59e1d1-393014b9560mr4356479a91.12.1786539290507; 
 Wed, 12 Aug 2026 05:54:50 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f94ad854sm3522220a91.10.2026.08.12.05.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 05:54:50 -0700 (PDT)
Message-ID: <cc88ff07-474f-48d6-a2a4-1a2c3f64f3fd@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 05:54:49 -0700
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
References: <20260724000948.234657-2-pierrick.bouvier@oss.qualcomm.com>
 <anNDM7WAvxY5tO2K@redhat.com>
 <adfd5a5f-c237-4634-9c0b-14389c0f3585@oss.qualcomm.com>
 <anNqhjSU5tEDC0br@redhat.com>
 <a9c89dd7-6317-42f1-9e03-30e48c2d08aa@oss.qualcomm.com>
 <anRgKw58IMYoR4p-@redhat.com>
 <5bda3566-5ce5-46dc-a281-2cc07a56dc6f@oss.qualcomm.com>
 <077fc585-a6b8-455a-abdc-fd72e13b8315@oss.qualcomm.com>
 <anTPOqFKWFKAX_3C@redhat.com>
 <102a3de8-ac17-429a-9294-e3b159aa642a@oss.qualcomm.com>
 <anxQdlwxAtqfl-N-@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <anxQdlwxAtqfl-N-@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNSBTYWx0ZWRfX+elEsMbZhzyi
 oV811BulRaltWjkOvcv+5RGjDL1dMqb5CMqheo0a8aoFn3vEH+sz8k1athQxcPz/2RZm8ZBsT0f
 w9QkVg/+v9Kkf5SE7tBHEvxdtLQk5Rw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNSBTYWx0ZWRfX6RKyHiTtRqmN
 +MforeBUofd/seWWr/tbF+x16CZ/GyoCnoS3IVthDy3SbyB1BeGARgD0qg94ao/W71YOGaInOPe
 qJMlRGhWjwYWYO8cO23kzVKr/L5lWx8snRyOijpAKNTHYvz7K/KYgktm+xh7/P14XywIv9s6Jim
 Re7Nz1heImKu3EB+3kGTOkIi5st5VRFAum3vSiuGU9iOCzQyjbM0wUmW3Rl/5w3dhsAZdFP1MIy
 U6yalrCy2kyaM9xGWAavgwkpJOE8L2hns2de+JWiZjEAofNyo1z/hDe2A2h2e825+alPbGxcAIC
 nfJKm2UDQqHikcyZ+frCN1IfFgU2cRhn9U7bO6NbcPiWYxstDHLsd5TkflaVlXWQXo7t/v6vYwB
 rE+zq83Pv+eTVCks2s7PjTMUB2Cg2RwLrBtOc2Uv1sIcxTDZnJNyAVAUYgr+yV/r0w3WgzmJQ72
 F4Sj7/V42h/2X9oDRYg==
X-Proofpoint-GUID: 6aQ3vkARIhGY4JiY_yXI7fzFcUktSRUK
X-Authority-Analysis: v=2.4 cv=C87ZDwP+ c=1 sm=1 tr=0 ts=6a7c6d1b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bgHjAXG3SpvOzMDsn3QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 6aQ3vkARIhGY4JiY_yXI7fzFcUktSRUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120105
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

On 8/12/2026 3:52 AM, Daniel P. Berrangé wrote:
> On Mon, Aug 10, 2026 at 03:26:26PM -0700, Pierrick Bouvier wrote:
>> I have been experimenting today with static filtering of types, as you
>> suggested, and came up with two possibilities. Before implementing this
>> for all types, I would like to get some feedback on which way is the
>> best for you.
>>
>> 1. Add a new callback is_available to TypeInfo, similar to existing
>> interface.
>> Pros: local information is present in type definition, making obvious
>>       why a type is available or not. Very easy to implement
>>       since only type_register_static has to be modified to check it.
>> Cons: Add a new field to each existing type. Not the end of the world
>>       in terms of memory consumption, but worth mentioning.
>> 2. Add conditional around each type_register_static, or add an
>> alternative type_register_static_cond function.
>> Pros: I don't see any
>> Cons: Decouples type information from type definition, makes it harder
>>       to follow why a type is available or not. Much more verbose since
>>       we need to modify all type_register_static buried in macros.
>>
>> Based on this, I'm much more in favor or 1. The fact availability
>> information is in the same location than type definition is the biggest
>> advantage for me.
>>
>> On example given above, this would give something like this:
>> static const TypeInfo emulated_card_info = {
>>      .name          = TYPE_EMULATED_CCID,
>>      .parent        = TYPE_CCID_CARD,
>>      .instance_size = sizeof(EmulatedState),
>>      .class_init    = emulated_class_initfn,
>>      .is_available  = target_config_X,
>> };
>>
>> Would that work for you?
>> Do you have a 3rd way to offer to solve the problem we have?
> 
> In the case of user creatable objects, we represented a classes'
> conditional availablity in QAPI schema. For example:
> 
>   { 'struct': 'InputLinuxProperties',
>     'data': { 'evdev': 'str',
>               '*grab_all': 'bool',
>               '*repeat': 'bool',
>               '*grab-toggle': 'GrabToggleKeys' },
>     'if': 'CONFIG_LINUX' }
> 
> Now this isn't quite a match for what we want, as QAPI schema is
> common to all targets and used to control the code generator to
> turn off output. Thus the permitted CONFIG_xxx are only those in
> config-host.mak, not any from $TARGET-softmmu-config-devices.mak
> 
> The other scenario in QAPI is the concept of features:
> 
> { 'struct': 'SevCommonProperties',
>   'data': { '*sev-device': 'str',
>             '*cbitpos': 'uint32',
>             'reduced-phys-bits': 'uint32',
>             '*kernel-hashes': 'bool' },
>   'features': ['confidential-guest-reset']}
> 
> where again we just have a list of named strings. Features are fully
> dynamic, and crucially they are introspectable so applications can
> query at runtime what is available.
> 
> The introspection concept is something that is highly likely to be
> relevant to our use cases here. If we have a single binary with all
> types, it would be very valuable to be able to query it once to
> discover everything in one go, instead of havnig to query it over
> and over again for each target. That implies the application doing
> the query needs to be told about per-target usage restrictions on
> types it is querying.
> 
> We don't have QAPI schema for QDev devices currently, but it is likely
> we will do so in the future. We can't wait for that though as there is
> no clear ETA.
> 
> What this all says to me though, is that instead of an 'is_available'
> method, we should instead just list the conditions as data in the
> TypeInfo struct directly. IOW a list of const strings like this:
> 
>  static const TypeInfo emulated_card_info = {
>       .name          = TYPE_EMULATED_CCID,
>       .parent        = TYPE_CCID_CARD,
>       .instance_size = sizeof(EmulatedState),
>       .class_init    = emulated_class_initfn,
>       .available     = (const char *[]){ TARGET_AARCH64, CONFIG_something .... },
>  };
> 
> This will make it easy to add in introspection at a later date.
> 
> The limitation is that this can only express an "AND" condition.
> You can not do complex AND+OR+grouping conditions that you could
> express in code, but IMHO that is not likely to be a problem.
> In the worst case you can define a higher level "CONFIG_BLAH"
> that encapsulates the complex condition.
>

Those strings names reuse existing target config identifiers, which
can't be done because of config poisoning.
The string compare will definitively be visible at boot time, so we
should rely on enum instead if we go in this direction.

I'm a bit worried about verbosity of the result:
.available     = (const char *[]){ ENUM_NAME_TARGET_AARCH64, {} }
versus:
is_available = target_aarch64

99% of the types will be filtered by target only, for which we have
functions in target-info API. Only a few of them will need custom
functions. It would be worth having a nice/short way to write this
without having to declare all combination in a file.
One of your point was to not include more macros, and seems like we'll
end up this way.

The introspection argument is good, but will we really need that? The
whole point of conversation was to register only types available,
ignoring the rest. If you want introspection, it means registering all
types and selectively filter them.

Considering this, I would be more in favor to stick to something simpler
for now. It should be trivial to change if one day introspection becomes
a real use case.

What do you think?
 > With regards,
> Daniel

Regards,
Pierrick

