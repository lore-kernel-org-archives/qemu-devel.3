Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57879CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGa0-0000pj-PH; Wed, 10 Jun 2026 06:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXGZy-0000pA-UX
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:54:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXGZx-0001Rp-2x
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:54:38 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65A7hxwW990993
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 10:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 df7M030d6wKw1VUNf+82BdLwSkH0OHfHpc+clGG6SQM=; b=ZQGkUzF5NmNoqZjH
 CF/Es/ZmABRU5untYGn0ocnUT2G1QW3OJZHzw/167NWfZMX5CVoMmnm7f7jw5NpA
 zXZxXB9Fdz8AVNr+5JRlEYwHuNBntemZ6ebRhyDUb1WbdoSjQniqAOJrTHcZpeeB
 jbAVBBqOj7gYblKfuBmSEjbZJv6r9y4W8QgQ7WM0WOeriw7yffqUSPJh6PJ7xtBS
 K/1UzbmrY63+Lpx/6e13i99HE5PQxXSvhV/1rcBJkt2/+S6UizvvsWOtjpNNntfO
 fUprDvgdyJJccerY9bUNa7XIbE+35omQnhKg5dirw+mFONlT/5EfCJWLA8hLol0I
 oX9/9w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq1tg17p0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 10:54:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5174a23afcbso81006921cf.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781088874; x=1781693674; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=df7M030d6wKw1VUNf+82BdLwSkH0OHfHpc+clGG6SQM=;
 b=IKI/iPsnT1JGpBwyW0LwtwePXK11rSE/AKJcfCcNwQ5CU7+rD6lSSbujHETM8cB/2Z
 LPAFEWtu89Qm4/738b038lqI4keOhfpyXdJg619WqFFzegxA2Ps2Dua8wbg6mGZ7V7If
 pAJoJQjijJrVSuEx7vV7HVqDuQ2JsbsEff3A8hTgudDTS+izhPq8HKu0ivWMv4f/cbJa
 d8Y19ECyNgCQ7a33mFNE4ZTczMpdQJkIoqt9+vmBzNJpkC/YGg6QzEcVJT5Lq82n+QQs
 M4Lg8oEZdUuhQxk2RcNFWqSSbccK6OuqSvZIx2cS2nJbTdBJ6927VX55Q37jfvWhSnWg
 4RMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781088874; x=1781693674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=df7M030d6wKw1VUNf+82BdLwSkH0OHfHpc+clGG6SQM=;
 b=boVcit6EaBA8GTZPJBRJ8JGhhMWD/Cd8m0tOnrSOLgvgZz++GL+teziObG3sMGC51j
 rn4KU6Yt2A9TDvRRiRS3bzpaJEgo9HAl6IRo8PioA157RrWCaLvDDdtP/usm0FyJy7nh
 g7dIahVtu/vetZoH/DFwKUJdbSaeDUSwJwvoxARxp+B9ctOUPiH+c95BDAl/QFWP6noU
 q8yG4erKcdtUSyBhxVJyGechcSwWyuagVi3EAU6vaObS6kQtOTct8zzGvSgTaFYvP3/J
 +qUrE6rr5tfLlls0kdos6t0r5iEF/443UTYye9Sc4trlEfe5t1RYfC9oTcdg/bfu2oqW
 yiVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8krgNcwE9nJz4kYw1vD1yhah/z4pfdlxnjc+7ZI+SSzwaK85FA7vxbg6YPk7Gf9hZtCkXglexQTZf2@nongnu.org
X-Gm-Message-State: AOJu0Yw+Fgstey47Qxa+Rkpx2SePvfFxsZrDqw214GpdcvT3c0WU48pg
 ki+U4apHJJKW34Tia+vjbd0HNkhQGfezLfAe1I//uUvu738LwyEpWaHucmPMPe8j0knFLC6NGro
 vYTVELJ+NRzOxJAhw7GGldOZxgZV0pQIWh4pLEPdgkhQzW5qJbrZOwTo8CA==
X-Gm-Gg: Acq92OFhlpKclzyFSn26h72u+PX0gGqQhUfU3ntO9zc9icaxje0wT1oxkKTMO5S+AkK
 4tFJHgy9YWDcOgjqkCLe08NNTiY/pFEK401BVpfUWwlsbVuOaQMg80xcuYCgiEWhnCSrt/EXA5K
 yEJkBvDricDyFKnPFOPJ+KZbWuFHIopYoMW6GHkmMpJLyC41bVxkx0O4MEQ/mSL6mW1uKGHCtOM
 op1MMJUxIE6rj0fmZwRAjoAOnsZnkyWBIcHz5EglsmHVylNrvzHuiT1A02icj3jD6y585GfNPuc
 PteyBsdMoBOx6UzSJYfsAd2ouWInjz/8XQt4JGkPxq3PvZtmyCZ+lCWeUydlxBQxBv4ZZNLOnCN
 k5ammLPEAHqxEUk8WE9xBTY88QVAtyuIlmtHThpfvjNsbWeaJ4qdWjmxXWE3EoMrx7xgWSKffVA
 ==
X-Received: by 2002:a05:622a:1a9b:b0:517:9157:ecf0 with SMTP id
 d75a77b69052e-51795be13abmr330472091cf.29.1781088873684; 
 Wed, 10 Jun 2026 03:54:33 -0700 (PDT)
X-Received: by 2002:a05:622a:1a9b:b0:517:9157:ecf0 with SMTP id
 d75a77b69052e-51795be13abmr330471771cf.29.1781088873116; 
 Wed, 10 Jun 2026 03:54:33 -0700 (PDT)
Received: from [10.156.84.244] (49.170.88.92.rev.sfr.net. [92.88.170.49])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0559f1f97sm1203213966b.60.2026.06.10.03.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 03:54:32 -0700 (PDT)
Message-ID: <affa4048-c00e-44b9-b06b-06a5e38df47b@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 12:54:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: add 'trigger-count' debug property
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260609213905.1126795-1-daniel.barboza@oss.qualcomm.com>
 <6db02c91-83fb-4021-91ec-72e6b56afeb3@oss.qualcomm.com>
 <25dc379c-7421-44e2-98a7-15593db4f93c@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <25dc379c-7421-44e2-98a7-15593db4f93c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4zE1wL4rcWOKrvQD7AjT5LZPK0dFpGYJ
X-Authority-Analysis: v=2.4 cv=dLmWXuZb c=1 sm=1 tr=0 ts=6a29426a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=YLXAUxGLE6hMr2F5uSHVqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ozpIENw6cf2SYRR5OSYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEwNCBTYWx0ZWRfXx5oOrK+RD66c
 x8tmYv8j/8EKHLnvSaoAonEnITKCluSqjhrbCPNf6I5I9A1uCwYbFA7P9o29PY4CqGe1FGeG6w/
 FI5Khn9J4bGtQap+9gNDwdw9UZG5Ax0m6mjANC7jwO8m7Kw6MsTiF/Ds28alxB4oD3JzPK282Dx
 IdyXFuncyw0kGj9B9m6NC4zyrhaGaT1v6c2ZRZcOHKehlLyemfbkoS08rM5a10XH6vG7sDlf3W7
 rz0rbtqg/+CN0HbsAUhAdh5FcQmqjPm7yGH1zDbbWcIffpbxeDwvkwlyISpjm1sDoqUbjbLRqXc
 37TmDrnachwmGgv2Hy0kgPXTQOfxUjHZ9VULhOjIggajj2kFxuc0qKc3wvnQ8bm5uuBHdPS2h9B
 AfqyRAN8ZS1g5sBOUMmkSMpR0gXtIctVHuay+gkrp2ByFtmCL4bINqv16DYu/Jx+uMeeGCAJFqV
 th8Vaq7wGQqM+4qT01Q==
X-Proofpoint-ORIG-GUID: 4zE1wL4rcWOKrvQD7AjT5LZPK0dFpGYJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100104
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 10/6/26 11:37, Daniel Henrique Barboza wrote:
> 
> 
> On 6/10/2026 6:04 AM, Philippe Mathieu-Daudé wrote:
>> Hi Daniel,
>>
>> On 9/6/26 23:39, Daniel Henrique Barboza wrote:
>>> All CPUs have the same amount of triggers: 2 triggers per hart, set via
>>> RV_MAX_TRIGGERS.  This is not enough anymore: we'll have at least one
>>> future CPU that will demand more triggers per hart when implementing the
>>> RISC-V Server Ref Platform, requiring at least 11 triggers per hart.
>>>
>>> Parametrize the trigger amount using a new 'trigger_count' env property.
>>> The default amount is kept at 2.  Set the new maximum to an educated
>>> guess of 128 triggers per hart (which is less than 2^XLEN theoretical
>>> maximum by the spec).  All relevant callers (csr.c and debug.c) will now
>>> use env->trigger_count instead of RV_MAX_TRIGGERS.
>>>
>>> We're also adding two ways of setting the property:
>>>
>>> - a '.trigger_count' CPU definition flag, allowing CPUs to set a custom
>>>    amount inside the CPU def in DEFINE_RISCV_CPU();
>>> - a new 'trigger-count' user property.  The user property has a higher
>>>    priority than an existing '.trigger_count' CPU def setting.
>>>
>>> Assuming a hypotetical case where a CPU 'X' is defined with
>>> '.trigger_count = 8':
>>>
>>> - -cpu X,trigger-count=30 => trigger_count set to 30
>>> - -cpu X (...)            => trigger_count set to 8
>>>
>>> For a CPU that doesn't set '.trigger_count':
>>>
>>> - -cpu rv64,trigger-count=30 => trigger_count set to 30
>>> - -cpu rv64 (...)            => trigger_count set to 2
>>>
>>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>>> ---
>>>   target/riscv/cpu.c         | 11 +++++++++++
>>>   target/riscv/cpu.h         | 23 ++++++++++++++++++++++-
>>>   target/riscv/csr.c         |  2 +-
>>>   target/riscv/debug.c       | 16 ++++++++--------
>>>   target/riscv/machine.c     |  4 ++--
>>>   target/riscv/tcg/tcg-cpu.c |  7 +++++++
>>>   6 files changed, 51 insertions(+), 12 deletions(-)
>>
>>
>>> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
>>> index 6e70b145a5..a667c06b17 100644
>>> --- a/target/riscv/machine.c
>>> +++ b/target/riscv/machine.c
>>> @@ -240,8 +240,8 @@ static int debug_post_load(void *opaque, int 
>>> version_id)
>>>   static const VMStateDescription vmstate_debug = {
>>>       .name = "cpu/debug",
>>> -    .version_id = 3,
>>> -    .minimum_version_id = 3,
>>> +    .version_id = 4,
>>> +    .minimum_version_id = 4,
>>
>> Since you bump the migration version, we can also change the array size
>> to only serialize the number of trigger used:
>>
>> @@ -246,9 +246,9 @@ static const VMStateDescription vmstate_debug = {
>>       .post_load = debug_post_load,
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
>> -        VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
>> -        VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
>> -        VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
>> +        VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, env.trigger_count),
>> +        VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, env.trigger_count),
>> +        VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, env.trigger_count),
> 
> Good stuff.  I searched a bit yesterday to see if there was a way of 
> putting a
> variable in the array size of this macro and figured this wasn't possible.
> Didn't find any example after searching for like 2 minutes, then convinced
> myself that the vmstate array should have a static size.

Same happened to me, unfortunately there is no documentation at all.

> 
> I'll send a v2.
> 
> 
> 
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
>>
>> Orthogonal, we'd need to replace these target_ulong at some point
>> (likely bumping the version number again).
> 
> I suppose we should do that in a separated patch that handles all ulongs
> from all vmstate objects of this file.  Then we can do a mass bump on
> everything.

Sure :)

> 
> 
> Thanks,
> Daniel
> 
> 


