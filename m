Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FABEC5AC67
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws4al-0002iI-LJ; Thu, 06 Aug 2026 16:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1ws4ag-0002fd-1l
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:21:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1ws4ad-0004Dj-II
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:21:21 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676IHwhB2704704
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 20:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Zqsjk1YulkHspxh1Gh//OHjJU/IebvO7tnk/ZOIeJcg=; b=MQOS2jJ2huMrSOiB
 V2P4Pj5EYitVTaifsLlxcujo1M+BoPutmKfZX6m7lIsHZcXr5Uotn1uiGrhR5P5Z
 g3bdWZuDK3IyA0O9dF+F2Vb2zE0kMz9q5i+A1Puio9KyLxJ1v9C0eUoh95Y5ctzh
 we+2gZPrUwx3p/eyPzpEntriFB4+g0EKTmSSX2G4kTAv0cSHRo016asBkP/oStZC
 MykervzBpvolZxQR+cf7zbGUK2A6dcIS4OWlY3VEAVBH3Cq7FMVDVAIbApyNUfwp
 bGtQzoyDJ/evFoGADLBWFA+Uz49diveZXk5/NGKI+uJLX9FLq50rZ5uif5l3Bbs/
 eHGGgg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6h8kv5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 20:21:17 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb48f41343aso1008734a12.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786047676; x=1786652476; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zqsjk1YulkHspxh1Gh//OHjJU/IebvO7tnk/ZOIeJcg=;
 b=iwK7EkPE0WLWiKfeP8f9/5/KGQSyJGhlI7PAXeLptEIC28zO3UXgojyAx+y436Pirf
 K2UNz6IPK+5swx9C4F1rmxjnFTg4ZTyWiTyH+47I+vr6UGXin/wm9VpfbMTqQAHvMy+L
 krEDkFgTGolm3cAofohxQUDD0y0xnljgqB0T6atrSKAvJLtyJlhek+qHpW22ZDsiHM/j
 o9E5KHcMgH9PWfxVwKhYvjT1WnO02Y5uhVGQ7dC7qM1YtmPtlqFgRPVTbyQIx0OFWwgg
 MDmujLwkcAP65yq3aFp5io01W+gCski6OU+ip8tNIm65kvIccLTtF9pX4Fp7aVcOjWu2
 IU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786047676; x=1786652476;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zqsjk1YulkHspxh1Gh//OHjJU/IebvO7tnk/ZOIeJcg=;
 b=ZyxWasoBWuqhGvKVNdhVuc6YBzsM4JjkKUKdpp/tQcg9CsB8b88UadLOyBno0B37U5
 di+vO1VK2u1tA54hQmOIs/n/sJw0oHiZzDI0XzVd12KwsZHSTyxg/DgIf4evwxjPyYPz
 PW/Iv/QzBIFtl+3gysSzl8zUW5ojXU0afEIbKSs9BCjTqJjQo57kjLk7X1cngqPq0dRl
 2fxhElBm2U0erhgOiRuTOq0irMaGNNZTF9dnzFTjkV81EWKw8iJfTd5rbtROE8lPHn6u
 WYMgJ/K+T95kOVQLkjjvG8B4oaZ6V+WMrkyAX+cDxIgHQG+HFYnzAi4POXQrOsUc+WXT
 qH6Q==
X-Gm-Message-State: AOJu0Yx/UUnw41L8zl9+7Mz1j8yP/X9/3CY9qTnspmIChZWTJrV0Dmh2
 TMcMA8u9CVeJ7VRzd1FBhmSrTUIH2JeruOSuO3Fkj1Skuf879zWBsilL0NH+jL7EvCVYDnc2+yo
 ZNrCRhyC2pN9P0GNeUXQAV9fkSq0BKJ/bsgiBryMmJkqMXsUbG9U/QOdWIA==
X-Gm-Gg: AR+sD11RnVNSL/bxakMo+oOWy2UUt5+GTNDiQ2TTtbWeDpXFRirRp24av2b7ErvJoRH
 LrLrkQgcO3KUMYaPYMY7pJEr7FuFJqr6wIA0vaHz8BhDzVHka74hfC2+GIHAqPFNmWJrdn1jkZ6
 pZVreQ6fhDOg3mbki5mSlpcUeZ1aepZiIEMlh/6I0x67eVluj+pj30PtKE7c3tx7W2w0AI/e9UQ
 2CeWxmypJ4/UbMfoKVJJByhgddL4U8fgNWqF0xxiVPISYhl3+Aig+8KQrmpR8NBIKroia5HKpdw
 4ZTwByC3wjhhhB8XcFREGsySLM00RzOKMQWHPZCJyp86dDQto3dbktU05xTralGAdloVLW8TPvV
 DfQ4Hwx0T+kv2ly25OScxX7i+pqRP9OmVAF3AMMOmNFk1DysQiDwRQLEx7ccSAeZwc44U
X-Received: by 2002:a05:6300:86:b0:3b3:3506:cf3f with SMTP id
 adf61e73a8af0-3cb9c071e7emr12263088637.1.1786047675918; 
 Thu, 06 Aug 2026 13:21:15 -0700 (PDT)
X-Received: by 2002:a05:6300:86:b0:3b3:3506:cf3f with SMTP id
 adf61e73a8af0-3cb9c071e7emr12263025637.1.1786047675341; 
 Thu, 06 Aug 2026 13:21:15 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315a8179ee5sm10751913eec.18.2026.08.06.13.21.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 13:21:14 -0700 (PDT)
Message-ID: <328caf32-d011-40e5-aa05-dac3273fa203@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 13:21:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] include/qemu/target-info-qom.h: declare
 TYPE_TARGET_SPECIFIC interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
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
 <anS7uRcg2IkGxR-4@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <anS7uRcg2IkGxR-4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JJNVka3gq_HAIcV_8orHHCQLgbH5ctfu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE1OCBTYWx0ZWRfXwheBAFrJsd4W
 yvCx7hOum4eIGXlrczM2WyAXPRe7RicPs2j1qfmWMa0n9Iv9s0pDIyvYt40rrgfinXYTxXtrqgn
 55O8SsrMd4Et/u4VEEfC7MkMAsT20qP40zKlMmA6Ejiv1AAlwDgwUXajtMegagBtU3ohrjmMhC+
 0wQTsi3iwzIIqeQ2mGBdAvRz0/H5SwHzmNOdpzAQjIHCuNhjUod3m5a11/SSAaVKISP0aP4fIu0
 DpiXbRNwuBV9msVRX4DsC3oYazNkpPPBQwr1M84Yumme6N+M5Qs+S06u/hT+rtGkZm3ziFCpZtP
 9zA9SORrJmP1iWSrmlZDRjnwAREI2UC4DtEq7ZRMgR7/3k8pQG3mZYIkdALCTdnUDTMpokFVmt9
 GYaWCwOwHjBg48twogr7EjeXca7p3gAzCG21LyVILzUdNrBpL8z82jj0fI5OE5OBAbFHEaUDROt
 jEG4vqYBYxqxjQlnIFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE1OCBTYWx0ZWRfX0aaNdAFR0ogW
 V1xb7RWv8mio1JAUzcH3/wOAd/xKqd4nJQdMmdRrwWHHw8kjxMxSIdPn238GAmSRxOk0qWlIEdD
 D8kR9UYiv/QQ7OP+MTzvLgNtZe5Ph9M=
X-Proofpoint-ORIG-GUID: JJNVka3gq_HAIcV_8orHHCQLgbH5ctfu
X-Authority-Analysis: v=2.4 cv=MbpcfZ/f c=1 sm=1 tr=0 ts=6a74ecbd cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=GaQpPoNlAAAA:8 a=EUspDBNiAAAA:8 a=IgDrO4xL9vupSvmVmpwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060158
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

On 8/6/2026 9:52 AM, Daniel P. Berrangé wrote:
> On Thu, Aug 06, 2026 at 04:52:20PM +0200, Philippe Mathieu-Daudé wrote:
>> On 6/8/26 12:21, Daniel P. BerrangÃ© wrote:
>>> On Wed, Aug 05, 2026 at 12:10:27PM -0700, Pierrick Bouvier wrote:
>>>> On 8/5/2026 9:53 AM, Daniel P. Berrangé wrote:
>>>>> On Wed, Aug 05, 2026 at 09:16:20AM -0700, Pierrick Bouvier wrote:
>>>>>> On 8/5/2026 7:05 AM, Daniel P. Berrangé wrote:
>>>>>>> On Fri, Jul 24, 2026 at 12:09:21AM +0000, Pierrick Bouvier wrote:
>>>>>>>> In the next commits, We'll replace the logic to filter QOM types per
>>>>>>>> target from a static one (based on INTERFACES) to a runtime one, based
>>>>>>>> on is_available() function, that can be overriden per class.
>>>>>>>>
>>>>>>>> Introduce the new interface we'll use for that.
>>>>>>>>
>>>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>>>>> ---
>>>>>>>>   include/qemu/target-info-qom.h | 15 +++++++++++++++
>>>>>>>>   target-info-qom.c              |  5 +++++
>>>>>>>>   2 files changed, 20 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
>>>>>>>> index 91be415ed33..83eb537333b 100644
>>>>>>>> --- a/include/qemu/target-info-qom.h
>>>>>>>> +++ b/include/qemu/target-info-qom.h
>>>>>>>> @@ -14,6 +14,21 @@
>>>>>>>>   #define TYPE_TARGET_INFO "target-info"
>>>>>>>> +#define TYPE_TARGET_SPECIFIC "target-specific"
>>>>>>>> +
>>>>>>>> +typedef struct TargetSpecific TargetSpecific;
>>>>>>>> +
>>>>>>>> +typedef struct TargetSpecificClass {
>>>>>>>> +    InterfaceClass parent_class;
>>>>>>>> +
>>>>>>>> +    bool (*is_available)(void);
>>>>>>>> +} TargetSpecificClass;
>>>>>>>> +
>>>>>>>> +#define TARGET_SPECIFIC(obj) \
>>>>>>>> +    INTERFACE_CHECK(TargetSpecific, (obj), TYPE_TARGET_SPECIFIC)
>>>>>>>> +DECLARE_CLASS_CHECKERS(TargetSpecificClass, TARGET_SPECIFIC,
>>>>>>>> +                       TYPE_TARGET_SPECIFIC)
>>>>>>>
>>>>>>> Looking through the series,I don't really see the point
>>>>>>> in this interface.   Why is this not possible to do by
>>>>>>> adding 'is_available' to MachineClass.  It would make
>>>>>>> the rest of the series simpler and especially avoid the
>>>>>>> need to introduced yet more series of macros for defining
>>>>>>> machine classes.
>>>>>>>
>>>>>>
>>>>>> We'll need the exact same interface for cpus, and devices also. IMHO, it
>>>>>> makes sense to have this in an external interface, instead of forcing it
>>>>>> to be present in all cpus/devices/machines. I also considered adding it
>>>>>> directly in Object class directly (would be the simplest), but I felt it
>>>>>> would be hard to motivate it.
>>>>>
>>>>> I don't see a need for the common interface across cpus/devices/etc as
>>>>> as code that's filtering only cares about the specific types. It also
>>>>> definitely doesn't beloong in Object class, but the Object class could
>>>>> be changed to make it simpler.
>>>>>
>>>>
>>>> We agree on this.
>>>>
>>>>> The object_class_get_list() method could get a 'bool filter(ObjectClass *cl)'
>>>>> callback which could be invoked on each class to filter it.
>>>>>
>>>>> That said I find it pretty undesirable as an approach that we're
>>>>> registering classes that can't then be used in a given situation.
>>>>> This has a ripple effect where every bit of code that iterates over
>>>>> classes needs changing to add filtering after the fact. It is also
>>>>> not great for scalability, as it means every QEMU process will have
>>>>> the union of all classes for all targets registered, most of which
>>>>> have to be discarded / ignored at runtime.
>>>>>
>>>>
>>>> This is inherent to the nature of having a single binary.
>>>> We need to cover those two requirements:
>>>> 1. having a filter mechanism (per target)
>>>> 2. have all the classes accessible for the heterogeneous machines that
>>>> will be coming in the future
>>>>
>>>> 1. could be covered by what you describe, however, it breaks 2. For
>>>> this, you need to be able to register all types by design.
>>>
>>>
>>> Even the heterogeneous machines aren't going to need all the
>>> classes from all 30+ targets that QEMU supports.
>>>
>>> IIUC, the current approach relies on '--target <blah>' to select
>>> which target we need. Would the heterogeneous machines not just
>>> change that to allow "--target <this> --target <that>". It still
>>> looks like we should be able to significantly limit  what we
>>> register for heterogeneous machines.
>>
>> Heterogeneous binary won't filter anything at runtime (if we want
>> to filter components we already have Kconfig at compile time).
>>
>> "--target <foo>" is only needed to have a single binary backward
>> compatible. If you use it, you fall back to single architecture
>> (our current binaries). If you want anything heterogeneous, you
>> can not use it. This will be by design.
> 
> I wonder if we've got a disconnect in our respective understanding
> of what we're aiming to create ? You seem to be suggesting heterogeneous
> binary and single binary are not ultimately the same thing, but I saw
> heterogeneous machines as a new feature of the single binary.
>

Single-binary is a step toward heterogeneous emulation, but not (yet) a
new feature of it.

We have been talking about how we would like to approach heterogeneous
emulation problem, but didn't share that
publicly. We submitted a talk for next KVM Forum to present our ideas.

In short: before being able to have any heterogeneous machine, we need
to solve all global state issues we identified so far: sysbus, global
memory address space, cpu indexing, etc. This work will be conducted
with a downstream "fake" machine that we have no plan to upstream.
Our long term goal is to be able to run two kernels on two different
socs with different architectures, different address spaces and set of
devices, unconnected to each other. This would prove we have effectively
achieved heterogeneous emulation.
*Once*, and only *once* all the problems above will be solved, we'll
consider what the command line should be for that. We have some ideas,
but I don't want to present them here and now, because there are many
questions left.

> IOW my interpretation is that the end point that we eventually reach
> is that we have  "qemu-system" as a binary, and that can be used
> to host **anything** we want to deliver, whether that's a traditional
> machine like  x86 'i440fx', or aarch64 'virt', or some new fancy
> machine which has multiple heterogeneous CPU types.
>

Current scope of single-binary qemu-system is only to do a single
target, without any functional change compared to existing binaries.

> All the existing qemu-system-$TARGET machines would go away,
> becoming hardlinks to "qemu-system" where argv0 name represents
> an implicit $TARGET.
>

That's correct. It will take time though, and qemu-system + existing
binaries will cohabit for a while.

> 
> What machines you could see when doing "qemu-system --machine help"
> would depend on which/how many "--target NAME" args you enable.
> 
>  qemu-system -target x86_64 -machine help
>    -> x86_64 machines
>    (equiv of qemu-system-x86_64)
> 
>  qemu-system -target aarch64
>    -> aarch64 machines
>    (equiv of qemu-system-aarch64)
> 
>  qemu-system -target x86_64,aarch64
>    -> aarch64 machines
>    -> x86_64 machines
>    -> aarch64+x86_64 machines
>    (equiv of qemu-system-aarch64 plus qemu-system-x86_64 plus new heterogenous machines)
> 
>  qemu-system -target x86_64,aarch64,riscv64
>    -> aarch64 machines
>    -> x86_64 machines
>    -> riscv64 machines
>    -> aarch64+x86_64 machines
>    -> aarch64+riscv64 machines
>    -> riscv64+x86_64 machines
>    -> aarch64+riscv64+x86_64 machines
>    (equiv of qemu-system-aarch64 plus qemu-system-x86_64
>     plus qemu-system-riscv64 plus new heterogenous machines
>     for any combo of x86_64, aarch64 and riscv64)
>

This is where we have a gap in our understanding.
The goal is not to enable multiple targets, not in this way at least.

I give you a simple example about why it's a bad design:
What is the semantic of such a line?
$ qemu-system -target x86_64,aarch64,riscv64 -M virt -cpu max
We now created an ambiguous command line, is virt the virt riscv64 or
aarch64? How about cpu?

Someone with over engineering tendencies will come with the idea:
"Ok let's prefix machine and cpu with target".
$ qemu-system -target x86_64,aarch64,riscv64 -M aarch64:virt -cpu
aarch64:max

And then, someone will say:
$ qemu-system -target x86_64,aarch64,riscv64 -M aarch64:virt -cpu
riscv64:max
And then, we will all go to hell for creating such a thing.

The only sane solution is to restrict to a single -target, and have the
exact same behavior than current binaries. No change, no breakage.

For heterogeneous machines, we want to propose a very different
approach, that requires all QOM types to be registered. Once again, it's
not the time to present/solve that, but it's why we implemented this
runtime filtering instead of exposing only some types.

> 
> With regards,
> Daniel

Finally, I would like to make one thing *crystal* clear.

It's totally ok for you (or anyone) to come on any series, review, and
criticize design, as long as a good suggestion is provided. That's the
force of our community.

However, dropping on a series, saying "NO", "do X", and stop following
it after that is not ok. It happened two months ago, when adding
target-info QOM
(https://patchew.org/QEMU/20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com/),
where you suggested and insisted on the wrong design, despite arguments
against it. After, you've been "busy" and stopped answering.
Whether you're busy or not does not matter at all, if you engage in such
a change, you have to ensure you can be present in the next iterations.
It's not the first time you stop answering to a thread when you run out
of arguments or things don't go in your way, and this passive-aggressive
behavior have to stop.
You can be an architect for things, but you can't leave out in the
middle of the construction when it needs you, that's unprofessional. If
you don't have time, don't engage in the first place: pick your battles.

Given this, can you confirm you understood the consequences of asking to
modify current design to register only types needed, and you are ready
to review and accept it will be more verbose than current design? If
yes, I can happily spend my time on refactoring it.

Regards,
Pierrick

