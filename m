Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4330CC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 22:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtYSF-0008Gj-3k; Mon, 10 Aug 2026 18:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wtYS8-0008Fj-2F
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 18:26:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wtYS5-0007Lg-IX
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 18:26:39 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ALXGgo2541879
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 22:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZvARSTIf+mnnjB14bYeLOgPzRU9a4qQoqYa7k98gUEk=; b=dNiRnISKVyfyEFbW
 LWMRgGvoMKq2Z3m2wlay2dbktfEZr8sxw4LgLHBo+jRmm6REhHNpbjp2AMM09K0B
 /4t2ccDoFqqX3xfbk9+HXRb46YDoNvo1OSF4LPqG1aHsxzg2GkNMeahin1+xKvcp
 aM+B29qzuN3/1RHx/DaxcD+UtHtipyiHQyx1U9BLcGoII0ssElemJLywCxm8rzRk
 7EGJO8D4+LkYyd9PA2tg7mFcRDqKErwtMMIymlK2dHL0KNOUHES0TY0xQVIqJ+zd
 ONCGpWtxfepwJJ/P56zhpyz2/MG6jTButTxHTZwPs2Qe/Cl8VcTxycfOEJpoxIQd
 LJpzUQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk619pn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 22:26:29 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38dbe39ce62so337759a91.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 15:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786400789; x=1787005589; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZvARSTIf+mnnjB14bYeLOgPzRU9a4qQoqYa7k98gUEk=;
 b=MGEoGwknrl7vKprAZwb7cfiK9cmziu3bLmT/6rdU6upacKY1VxfFe9zYO6tkFvUkJm
 8QIWnl9Yi86+97pmmtoGqRNQ0ObxZ4kPzgEF4fyq2z7ICaSXZvSCe6B3dWTvTOAwlUQb
 nNfjZhjujy1XFxhEuyVm3Nb4g+cAwlUkrlgU1vivVgk6mgjkV4C0/A41JZ46K8Ku6B+f
 zBvdvx4C+ur9XnPkBqbsqxuuF/rC99QLQpUTZos/Qx/sGLUl3CUJTFTPcMNYbo4jCTST
 LXD9cgYZtkNiO4B8N/RcTaOzHH/pW0HfHQXiNorCFcUZZacWeNU93qR31QEasrZQgMFM
 D7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786400789; x=1787005589;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZvARSTIf+mnnjB14bYeLOgPzRU9a4qQoqYa7k98gUEk=;
 b=qvrF1TAW4XKNUTgvkkvcirNTmUS49iv0/epqQgDkktkCtOCl+Kwg/utIVivL7HGGxS
 HORi8HjxmTZL6iMPg1RKFstwX2DAU1cwPmIlLcP2FD8XlkqgsXCiGsw2YyRhX/vyphwE
 VCu6halyLloK+f09Ramcm3nava6oO/4NA99EUmNGLBLL9ibfTOAH0B1aDcHvEn/jsATt
 FjxEr/A0uZvlEt4TOTtEqBEPpxTW223RFOXEZabMwZNKLzYt89LwLxH6ZpCdHCWzAFis
 3fpTx6knc+aMES8q+BTSCUaP7ErblZnbf3OIzo/DOxMjXKds8JXENTIrYE69v+jmpdbH
 /dBA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnxkiOJIR9oI+v8JLA+e6uB8A3eV6zVHMjy9X5gEGdbuiTokYL1wxZLpZfhgAItFMnJA2nZZMtrfYx@nongnu.org
X-Gm-Message-State: AOJu0YyNXlYMh17EadGjKBDlG5e8eGIi+freJiWTvrNhsyJxm5o7s1Gp
 27p2amho/D9cF6N1rNaIeK7zSLGyUfAb7KCzoStMfBo2nyYfc6pJ0IuECMOHFlmPOAC8f3g7932
 nn9MMY8FE7u2mxN0ND/4RvHWQ2oqgNKyqPPv1cS5ylNwB5m2jqb1W3woYRQ==
X-Gm-Gg: AR+sD12uKbIPOa19v/i2HmzEykkT/W9z5uCJJsSNzm54OJtbMuQ4eS5g2PSDjYklNAY
 +zQAT/ltFYJp94/SLqV3FdhjY0JWE0SySodKCmYx7hJAbvaAUXhJDV6YlFungAJfco0TExz4mSE
 PVjbkp+ccCyNJ6pLbpfzYDsfw/HUoav6bTPYCvk0oK8mLupPMRRDAzX23hTbJQHCTa9tRYRpUaS
 qTmN9+ZCGxS1XmUp2yJ3cm54wx8UKenm4MQQkwiti3qLv/7V2z6bmCerWyfPfaC1ibypR5AE8KN
 uU3TvmyUUSUVsH+lUxB49gJwPD4d5wB2KiQQ/vWebmSyDjELXB0VmyPGhSqxK1Drj57z5k4dW4e
 kLdzaCbxfuS5nR4FLE75IwHFZJ9RtYoG2y6AhodFaZTzX5YDRMx+tU+YCBRBhNYjJzzxq
X-Received: by 2002:a17:90b:3bc6:b0:38f:cab0:9aa9 with SMTP id
 98e67ed59e1d1-392d619181emr837220a91.13.1786400788600; 
 Mon, 10 Aug 2026 15:26:28 -0700 (PDT)
X-Received: by 2002:a17:90b:3bc6:b0:38f:cab0:9aa9 with SMTP id
 98e67ed59e1d1-392d619181emr837198a91.13.1786400788058; 
 Mon, 10 Aug 2026 15:26:28 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86e917sm53082667eec.5.2026.08.10.15.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 15:26:27 -0700 (PDT)
Message-ID: <102a3de8-ac17-429a-9294-e3b159aa642a@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 15:26:26 -0700
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
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <20260724000948.234657-2-pierrick.bouvier@oss.qualcomm.com>
 <anNDM7WAvxY5tO2K@redhat.com>
 <adfd5a5f-c237-4634-9c0b-14389c0f3585@oss.qualcomm.com>
 <anNqhjSU5tEDC0br@redhat.com>
 <a9c89dd7-6317-42f1-9e03-30e48c2d08aa@oss.qualcomm.com>
 <anRgKw58IMYoR4p-@redhat.com>
 <5bda3566-5ce5-46dc-a281-2cc07a56dc6f@oss.qualcomm.com>
 <077fc585-a6b8-455a-abdc-fd72e13b8315@oss.qualcomm.com>
 <anTPOqFKWFKAX_3C@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <anTPOqFKWFKAX_3C@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Nb3WEWD4 c=1 sm=1 tr=0 ts=6a7a5015 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=TAW1L8CnMsigg1-llCgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: H30PiIrOX_mqeEGC0AcAP-ytNhDsfmjK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE5MCBTYWx0ZWRfX7uNSDH2nHbv5
 cyY/QzS8MPoD7CioFtV1/fAO+j4hsmidW/K9sTqa14d4wdVNuuSG+MLmzqOeC1PZefebJqrUGQ/
 6KvCKsVs8FHHl0SKHz7ZVTUYTbCxLZo=
X-Proofpoint-GUID: H30PiIrOX_mqeEGC0AcAP-ytNhDsfmjK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE5MCBTYWx0ZWRfX3odq95VGfYjG
 h0m4Q8C0M5sLu5QA7IhHLB4P6c4Y4TAiMJYNo4BrkxO7EEbVBxmb4iqsDdRvDbKmxozr9vuyVDL
 /zIpMJOa/a85uXGMwPPJ4euOi3JQVFrNbhzHatOepv9aP4oFGWLU7A7y3FS8KrNtjL0zzO4npHV
 V2vQZgaTUMSRv7PCCeWd7pqkrzbD/wnQjviUzOdShz8xE3xDzpfBp/h2FdqYw6IhmOwEM5ytrCA
 aKt3KRexqrxZkuVvRZX3+BxNB3cI+Lvv+61HHPZo43iZdXZS3HBOdruPo2ZYc0ehBuuN/mvmK7y
 Jj/8Jr0wA+Veivpoi6eryjsLbe2L76gkla5AVn6atl9/kKGPm5tbDJt4TFk62hKu7Qs/4ldDp8t
 0mptQzQmwUlsmyI6CY1fpbS/fBQ38tAUnAVtwwWiOfXEN4o1EO9W5pdXEr07+7PqsLWOjlDE49E
 OhJzcneym34+72VBQBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100190
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

On 8/6/2026 11:15 AM, Daniel P. Berrangé wrote:
> On Thu, Aug 06, 2026 at 09:38:43AM -0700, Pierrick Bouvier wrote:
>> On 8/6/2026 7:52 AM, Philippe Mathieu-Daudé wrote:
>>> On 6/8/26 12:21, Daniel P. BerrangÃ© wrote:
>>>> On Wed, Aug 05, 2026 at 12:10:27PM -0700, Pierrick Bouvier wrote:
>>>>> On 8/5/2026 9:53 AM, Daniel P. Berrangé wrote:
>>>>>> On Wed, Aug 05, 2026 at 09:16:20AM -0700, Pierrick Bouvier wrote:
>>>>>>> On 8/5/2026 7:05 AM, Daniel P. Berrangé wrote:
>>>>>>>> On Fri, Jul 24, 2026 at 12:09:21AM +0000, Pierrick Bouvier wrote:
>>>>>>>>> In the next commits, We'll replace the logic to filter QOM types per
>>>>>>>>> target from a static one (based on INTERFACES) to a runtime one,
>>>>>>>>> based
>>>>>>>>> on is_available() function, that can be overriden per class.
>>>>>>>>>
>>>>>>>>> Introduce the new interface we'll use for that.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>>>>>> ---
>>>>>>>>>   include/qemu/target-info-qom.h | 15 +++++++++++++++
>>>>>>>>>   target-info-qom.c              |  5 +++++
>>>>>>>>>   2 files changed, 20 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/include/qemu/target-info-qom.h b/include/qemu/
>>>>>>>>> target-info-qom.h
>>>>>>>>> index 91be415ed33..83eb537333b 100644
>>>>>>>>> --- a/include/qemu/target-info-qom.h
>>>>>>>>> +++ b/include/qemu/target-info-qom.h
>>>>>>>>> @@ -14,6 +14,21 @@
>>>>>>>>>     #define TYPE_TARGET_INFO "target-info"
>>>>>>>>>   +#define TYPE_TARGET_SPECIFIC "target-specific"
>>>>>>>>> +
>>>>>>>>> +typedef struct TargetSpecific TargetSpecific;
>>>>>>>>> +
>>>>>>>>> +typedef struct TargetSpecificClass {
>>>>>>>>> +    InterfaceClass parent_class;
>>>>>>>>> +
>>>>>>>>> +    bool (*is_available)(void);
>>>>>>>>> +} TargetSpecificClass;
>>>>>>>>> +
>>>>>>>>> +#define TARGET_SPECIFIC(obj) \
>>>>>>>>> +    INTERFACE_CHECK(TargetSpecific, (obj), TYPE_TARGET_SPECIFIC)
>>>>>>>>> +DECLARE_CLASS_CHECKERS(TargetSpecificClass, TARGET_SPECIFIC,
>>>>>>>>> +                       TYPE_TARGET_SPECIFIC)
>>>>>>>>
>>>>>>>> Looking through the series,I don't really see the point
>>>>>>>> in this interface.   Why is this not possible to do by
>>>>>>>> adding 'is_available' to MachineClass.  It would make
>>>>>>>> the rest of the series simpler and especially avoid the
>>>>>>>> need to introduced yet more series of macros for defining
>>>>>>>> machine classes.
>>>>>>>>
>>>>>>>
>>>>>>> We'll need the exact same interface for cpus, and devices also.
>>>>>>> IMHO, it
>>>>>>> makes sense to have this in an external interface, instead of
>>>>>>> forcing it
>>>>>>> to be present in all cpus/devices/machines. I also considered
>>>>>>> adding it
>>>>>>> directly in Object class directly (would be the simplest), but I
>>>>>>> felt it
>>>>>>> would be hard to motivate it.
>>>>>>
>>>>>> I don't see a need for the common interface across cpus/devices/etc as
>>>>>> as code that's filtering only cares about the specific types. It also
>>>>>> definitely doesn't beloong in Object class, but the Object class could
>>>>>> be changed to make it simpler.
>>>>>>
>>>>>
>>>>> We agree on this.
>>>>>
>>>>>> The object_class_get_list() method could get a 'bool
>>>>>> filter(ObjectClass *cl)'
>>>>>> callback which could be invoked on each class to filter it.
>>>>>>
>>>>>> That said I find it pretty undesirable as an approach that we're
>>>>>> registering classes that can't then be used in a given situation.
>>>>>> This has a ripple effect where every bit of code that iterates over
>>>>>> classes needs changing to add filtering after the fact. It is also
>>>>>> not great for scalability, as it means every QEMU process will have
>>>>>> the union of all classes for all targets registered, most of which
>>>>>> have to be discarded / ignored at runtime.
>>>>>>
>>>>>
>>>>> This is inherent to the nature of having a single binary.
>>>>> We need to cover those two requirements:
>>>>> 1. having a filter mechanism (per target)
>>>>> 2. have all the classes accessible for the heterogeneous machines that
>>>>> will be coming in the future
>>>>>
>>>>> 1. could be covered by what you describe, however, it breaks 2. For
>>>>> this, you need to be able to register all types by design.
>>>>
>>>>
>>>> Even the heterogeneous machines aren't going to need all the
>>>> classes from all 30+ targets that QEMU supports.
>>>>
>>>> IIUC, the current approach relies on '--target <blah>' to select
>>>> which target we need. Would the heterogeneous machines not just
>>>> change that to allow "--target <this> --target <that>". It still
>>>> looks like we should be able to significantly limit  what we
>>>> register for heterogeneous machines.
>>>
>>> Heterogeneous binary won't filter anything at runtime (if we want
>>> to filter components we already have Kconfig at compile time).
>>>
>>> "--target <foo>" is only needed to have a single binary backward
>>> compatible. If you use it, you fall back to single architecture
>>> (our current binaries). If you want anything heterogeneous, you
>>> can not use it. This will be by design.
>>
>> I've been thinking about it yesterday, and we could apply the paradigm
>> "register only classes that will be used". For heterogeneous machine,
>> either we'll provide a "none" target, which enables all target, or use
>> --target aarch64,riscv64, like Daniel proposed.
>>
>> I will implement what Daniel asked for v2.
>> However, please be aware it will be probably be more invasive and
>> verbose, since we'll need to add macros and stuff to have conditional
>> type_register_static.
>>
>> I would like to avoid doing a change you asked, and have no further
>> comment after that or something like "it was better before".
>> Do we agree on this Daniel?
> 
> That is an unreasonable request - I can't approve of a patch series
> that doesn't exist yet.
> 
> I can only say that I don't think the current series is a desirable
> approach and make suggestions of what I think is (hopefully) a
> better way.
> 
> 
> Something else that I didn't consider previously is possible interaction
> with modules. Much of our use of modules is to make backends loadable,
> but we've got a few loadable devices too. It seems likely that with the
> single binary model we'll have greater motivation to make more device &
> machine code into loadable modules, as people have repeatedly pushed us
> to have a lower mandatory footprint for QEMU.
> 
> The loadable modules relies on some metadata defined in the source
> code alongside the type info. For example
> 
>   static const TypeInfo emulated_card_info = {
>     .name          = TYPE_EMULATED_CCID,
>     .parent        = TYPE_CCID_CARD,
>     .instance_size = sizeof(EmulatedState),
>     .class_init    = emulated_class_initfn,
>   };
>   module_obj(TYPE_EMULATED_CCID);
>   module_kconfig(USB);
> 
> In particular it feels like the module_kconfig() and module_arch()
> metadata have overlap with what you're trying todo in this series.
> 
> So I wonder if we could generalize the module metadata so that it
> serves a broader set of use cases. Instead of having to manually
> write conditional logic in XXX_register_type() methods, perhaps we
> can do the right thing automatically in type_register() using the
> metadata we collect from the code ?
>

I have been experimenting today with static filtering of types, as you
suggested, and came up with two possibilities. Before implementing this
for all types, I would like to get some feedback on which way is the
best for you.

1. Add a new callback is_available to TypeInfo, similar to existing
interface.
Pros: local information is present in type definition, making obvious
      why a type is available or not. Very easy to implement
      since only type_register_static has to be modified to check it.
Cons: Add a new field to each existing type. Not the end of the world
      in terms of memory consumption, but worth mentioning.
2. Add conditional around each type_register_static, or add an
alternative type_register_static_cond function.
Pros: I don't see any
Cons: Decouples type information from type definition, makes it harder
      to follow why a type is available or not. Much more verbose since
      we need to modify all type_register_static buried in macros.

Based on this, I'm much more in favor or 1. The fact availability
information is in the same location than type definition is the biggest
advantage for me.

On example given above, this would give something like this:
static const TypeInfo emulated_card_info = {
     .name          = TYPE_EMULATED_CCID,
     .parent        = TYPE_CCID_CARD,
     .instance_size = sizeof(EmulatedState),
     .class_init    = emulated_class_initfn,
     .is_available  = target_config_X,
};

Would that work for you?
Do you have a 3rd way to offer to solve the problem we have?

> With regards,
> Daniel

Thanks,
Pierrick

