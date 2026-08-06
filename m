Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C22C5AC82
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 21:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws5GC-0006YB-JN; Thu, 06 Aug 2026 17:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1ws5G8-0006Xs-AP
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 17:04:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1ws5G5-0001ov-VA
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 17:04:12 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676L12qT2760975
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 21:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 US7sw3rXHPI09ruTVx/AAHK/e3Qza4vWbP4dnz5JwYo=; b=klhqtzxeohofnOgm
 IXxdUY3fG1Tk9L8uYmSk6eWH8R6uwPVpmm89UYpaP8zNNHD4B2T21xtGN78LMb86
 znvNFsuaDcWGB3sIDhyos48Sb6qGx0wQ7l0uIM8qQWkb1u+SUCm5clyIJd5EQIf2
 Jwa09mSuGDLfiNsSq3QFaIYj9A6MnRjtSB6YmOAjOhO/S7yG0+GwXreFniXic/MU
 qsUWzznj+oW0SgrMAZS11Wt17WGrOl9/OnVVCZJjmFA7UwPbR+gSTh6sS8bcqLVx
 TovgQ7yrQ6hRYKpcEeGqHtlDOMnsLIWoPLlKPuOv2utsq1gAhbpkb6SU++TOlQJA
 TOvOcg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6jgqny-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 21:04:06 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ec0f510a9so5710084a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 14:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786050246; x=1786655046; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=US7sw3rXHPI09ruTVx/AAHK/e3Qza4vWbP4dnz5JwYo=;
 b=RSpq7wdcWlkds0xKkrwSLWCabYsLX4qV9t7N5HxzW6uP2MsAnv3s5lM561QFE0bDx9
 pmrMm084K8mysEu2sbqxfsYHUtp25jz2fv0YXhLJUP6NCUfXUJwcKRWlhgTetz/GXF3H
 UOQm96vl9L4wgackoTEorDXerq59sd8G2fyAq4PnOtG1iJQWD/HVQOi6iC5dysAt46CS
 0/JQXVFFOxpfSiN5oqwBr+aol9l5rcQI0RQcJgQfdNgKW1jMb49vSNIMQGDedM1Q3gSI
 z8PMxvdMNbD8vhAqHzKhhHvgUccbYeGr8TzXd1EMTtb+CBy5q05DLabepIR2dBppuKNy
 /64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786050246; x=1786655046;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=US7sw3rXHPI09ruTVx/AAHK/e3Qza4vWbP4dnz5JwYo=;
 b=k+hUaNQCtuN7QcuBA0g9yxoJ+QdQJxq9DfgR2C8iyIQGcgTqhfN0244rCpg5ETtCIU
 BzJ4AdXbwPlOn06kc3+KZ1Jk1dVymFOyaqXt9T3WHRHgr3AokEvERDHN1EPcau346v4Q
 DyXx4kIMVnz5hbX0fDGgbtRucLF9i3Lo4bmhwI/L/q1O45k5LorW0KHnE+raHVrxEKA6
 698FJV5ROpw7as6fkE2vpzbYEa5uYD7HRCrHJXRoVxt+CcWIjEAcb9ApKXN5f0gmHhFc
 +PLPFgG/flFkZTFV8VTWcQryMy4HJLSeCyVbiwZ+cRc6IyIQhZphRcCJtzg3ned5VhLr
 gATg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZT5U3bY8gTXmKNC6WRFMrScY8u/wkz92pXK9hqhcCpvl3vJKLWSx3EXx3FlmwIyG+WgbtpkUAxsAa@nongnu.org
X-Gm-Message-State: AOJu0YyXeVftJijhRERkcGh7tcOtN0j0h6Ti+TtEDny/7geeC3cJq3cg
 o1QenQq3MCfaKhu449TBzpuGbLrI2Vqyq3y3KE8aTTpW5TV5SEtpNBydR7m6QGacRGbJeZP8AqH
 vkLelGIumhLdOV09gc7LIy5f7J/A5EAZiFgm+aYNuIbAAI/NDk5kh3/K2pg==
X-Gm-Gg: AR+sD12rmwbI+NHS7oM1tjRwPyylOLt9/5cYHpxrl4MzVmyCIYp3AOyNkum99frZi+Z
 RqLu/oKhCaadP9y41WYhQV3+f8krwLYoC5P1zK7V+cx77st9JmwmMhskkTR1Gv+NptmTmhz0dbg
 c6LlWcSZ6xG3PQFJwK/XIu/TNyvKBg+PTrnsrNReDSAC8FG0jhzVnQMyud6sTOkds9qe9xkejd+
 uzYqydCSf3imrHqK+YZNzTT2fszVFXhK6rziyG0OVdJ4BDQ0tE2bL1oDOwz5JYyfR44C+xYAH9W
 atyMi0s/riun3bO6OHsrUtVyMBHW4jCDKRf9MTG2vJQAbzGh6qjHBPPc1lqlA5IZqN8ELWZROgG
 Ye/SNOjC3MOUDwRUlB8rZrcKEktkJ4hxyjq0M/wOMT6bug0f3BZA3X9xJMavtfe+m7COf
X-Received: by 2002:a17:90a:c88e:b0:38e:488f:7068 with SMTP id
 98e67ed59e1d1-3903c5373b4mr19767559a91.2.1786050246060; 
 Thu, 06 Aug 2026 14:04:06 -0700 (PDT)
X-Received: by 2002:a17:90a:c88e:b0:38e:488f:7068 with SMTP id
 98e67ed59e1d1-3903c5373b4mr19767492a91.2.1786050245577; 
 Thu, 06 Aug 2026 14:04:05 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bc6681fcsm165397eec.11.2026.08.06.14.04.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 14:04:04 -0700 (PDT)
Message-ID: <c67d7326-c58c-4abf-97ca-9c75aa49cf52@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 14:04:03 -0700
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE2MyBTYWx0ZWRfX5VhoGkMloYpP
 mTVUp7PeZzY8djAPVoyMztTURdBD02sVIyskL01be8QY/gAquBimcI/QwjtpnyKdP1qCyE5gCAH
 amZPA6e+3nDeYpvv0WWgDCK33a3DxYN/Ts1HdavQYaUuYsBKJOhME2zBKndgpabWBI8I9RSpfb5
 34QQ0YZ1jUwvhj/12NFfVD/BnMJ+RFDDeregXX/Yze3qVihYV3Zvbb/lmI7PKkSColuUkrQA+aZ
 B+zEkzAhn9XSFB/5Ot/PGEujllGR82uSuab7iM0wyCzpYqyW1l+2iPcxGEMr+c7B3NCBLjzG4xi
 RITejjYpp4UvkW9DD5q9c7BByxmxKpWn5IM+OqC8N+u5i1uZiz8q58F/sS07lKPx/+EmjstNRIa
 OyB2h4u+O1aPb3OMRX2DRzlTOxaar49BOqpQCeWUUfwm8z/3Kpr3wiviRAOM5fC6LFCNxiUT5KJ
 AHNolDSR8InjyOZ+KUg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE2MyBTYWx0ZWRfX1eN40UrkMlI8
 jdDACj20ELuZT/yY/Ym9xAS8xwn0RLGrFGMJnM2T4LAQVB31UNtPFUyBHtea10W7Cpvgp9O6PwV
 tV/zfukXOzrouk6oviUgE2YCUaqINCc=
X-Proofpoint-ORIG-GUID: s-Ehe8D87xczKY9Ugs-SnFL1yQcCDAkD
X-Proofpoint-GUID: s-Ehe8D87xczKY9Ugs-SnFL1yQcCDAkD
X-Authority-Analysis: v=2.4 cv=e5Y2j6p/ c=1 sm=1 tr=0 ts=6a74f6c6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=B2Io-VH_eOaOZM7tp5oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060163
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

That's always welcome, but there is a difference between a suggestion
and insisting on something. Suggestions can be ignored.

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

We came from a specific need "We need to filter machines, cpus and
devices per target" to "Let's make all the types filterable in a generic
way that unify modules and the rest we have". This is some serious and
dangerous over engineering.

Feel free to have fun and send us the series implementing that.
> With regards,
> Daniel

Regards
Pierrick

