Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E570FC56207
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 14:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrzSQ-0003AV-4J; Thu, 06 Aug 2026 10:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wrzSP-0003AN-AX
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 10:52:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wrzSN-0000pW-9Y
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 10:52:29 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676EnpKP2574996
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 14:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XWiw0awEj7iAWlAQLn+cImFC5lnudT1VKPHhzRoKRJs=; b=OcCVzB9JcQXAWa6x
 ofEU2QYzpW4R7ZT7BUtzQq3hMXxDlhrgGgjtc0yVFhK3JN+GWvhOQsAfSmTxrSdJ
 epbeSYrQEKGNk2+LBCez/iIMnLr7C1dhQkIlCjWFGlrgrrXX4YMFw0t64wSHgwDp
 +bcAmXZXN7ab2h8tnSpVUhkW9jk9D+2Ebx1IJIfw5wUdfTrYPw9pZslolOd/f/QM
 ereV06dC3zvqwaMwRnoMDy5FPO5bP/zkz4K4m3T2D7MdYAClcWkyQ3F4ONiWOKp+
 yoEnW4i/cRAP/n0ozWBEXTt53ha1BZa/BvgLlEmazh27ei7xJFKvEwAx1ISErtf2
 v1ljjQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjucjtfj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 14:52:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so37314781cf.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 07:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786027943; x=1786632743; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XWiw0awEj7iAWlAQLn+cImFC5lnudT1VKPHhzRoKRJs=;
 b=H+mZQtNOBOh6MVPQfeTH8qZfHNip/CojRaOEXme65RG9DWLNcAQcYtgtKCoY8hB6sE
 0upo+7+nEYn8iw9PxS0fyIEzQK5gR7+aFDkpwK4MWuEb0VAnis6ri4Syjm9vP6psJQec
 xb80AnbTR0+BJQAFoFJBhJ3eWFwM64cPNuWgPyn7ZRaT9Uenp/5IVFtlyyA868MmijLN
 hmVLqdk49q5zmMSYlLXRbkc7W7xGw2DposuvTCdwOw1duW33WGpyVFWGgLrmLucn6Qlz
 UQtGCXyiB9KPwm3061o/bR70y4IRxxgwpTdtPb2LmCN0vx06hxLXw/vZBVllB2fWocYp
 8fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786027943; x=1786632743;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XWiw0awEj7iAWlAQLn+cImFC5lnudT1VKPHhzRoKRJs=;
 b=Q3YQuO6eWKFrb3GOhMXVFooaKgEDzavg9U7DkNLyb+08UPwd4eLu/77yA6qC807nq8
 1qpC9wpyLoJnSZ4lQniqyWdTV9h47b3TJyATa17jZB0MZrCieLkIqieoC4wJRW9yZXB6
 NYqiV/5AOd5v2iZqVfe94mrBbDwWqK4RMuK+S/coMh8apFbDkkNwxk7SYqj3rrbtdmNW
 k8WBQm3CpACWUbPo9nJm96auqGi71CTLdbb1jctG9zbGD//MJEtThb7qU8p3vZi4B7KZ
 m4Q+NFOQGEZSkPG+JHnNphYA79JaOMb5d3zHw+mJ+9p/trLJI4dxILjG1OGBNAY314Li
 VBEg==
X-Gm-Message-State: AOJu0YyBeYmnhmISb5R7C9f0HqNk58LaOw9/H/mBflNK93QfQMsWOqwk
 E4bI7+FncZpW3slBwug9vNBgcC5aZ1AbW8yO1zmCsa2+7hJ//V0Z87G40PzOsc2nQlNADsF/hQt
 ZRAb+oNOdyzktySQmqY+CM7bbWsVtbqMrhBCjy3bRh6zujhbiIMc4GmSdPw==
X-Gm-Gg: AR+sD124l+9OTqrUUiYl/zCRc+nGOZ3O6aJmUq2nV+jKPh7B2/67BIdrHXqGDU5coU7
 wt6N73rr+bYpzPNarDoIf/n12BZJZybpTClz8VHjNxa40QbNM+d4yjakOUnyDgLcO/Gzmzg6FYG
 Fdm3zlntcRlzRGgyxG9qWhy/JY0cPdQb5v+y1ClB3YouugvOXbw+EsLZJFWyBvN6ndDAvCNFTxp
 J3dQY6KVwkZUB7Ifbpx90d7ysdWGygyrfn+3X9Ju5AtqHUlHhOGxguTi9BqVAT2zsy9zP2DiUEE
 i0D8WBwPR7bDnPJlChTtuC6+l++XtqlU4alGeuRanHY32/beYp4ycvw+o0V4z7pStBl8zz8BfvN
 T78ybPaaoSWcMUOphcl8DazWgzUgqh0xgKBY=
X-Received: by 2002:a05:622a:c05:b0:51b:eb55:2916 with SMTP id
 d75a77b69052e-52d0b21b462mr26062711cf.34.1786027942910; 
 Thu, 06 Aug 2026 07:52:22 -0700 (PDT)
X-Received: by 2002:a05:622a:c05:b0:51b:eb55:2916 with SMTP id
 d75a77b69052e-52d0b21b462mr26061851cf.34.1786027942348; 
 Thu, 06 Aug 2026 07:52:22 -0700 (PDT)
Received: from [192.168.69.212] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b28729sm7654759f8f.32.2026.08.06.07.52.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 07:52:21 -0700 (PDT)
Message-ID: <5bda3566-5ce5-46dc-a281-2cc07a56dc6f@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 16:52:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] include/qemu/target-info-qom.h: declare
 TYPE_TARGET_SPECIFIC interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <anRgKw58IMYoR4p-@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNiBTYWx0ZWRfX2w/9jvtfCIP2
 LAKH5+u4T9lZnQmw8yjEe/zOKoFym94GAuwMegIDVTHPxzjI/y64h6aFyoZlzV8qFGhg6pUbnFh
 3pL15nZeQ8QMoBkZ/ologcqYDDeTlko=
X-Proofpoint-GUID: Sg-gWM7fBi1ofVqdYgrkHNj57GSXFBXP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNiBTYWx0ZWRfX2ABvQ5n+Ki2j
 rYJpPKqYL/qU/ZJKajQqR2Rzdu56PKjELmBksf5Q9YGVMZQkk+qnMyjQDneiTATyswjAxBVD/yM
 DKjqv7cMtlvHRN1U+zNRCyhnSsYPS2EXfcsJeTl2lFhAoCAX/gAlKHggjeTN1632xA/kcmbw0YX
 D3ZovNYMDV/2hsywa/6NV+T/BIGOG2v+iLsA8RgOfK/QVIFt2G2VKB7pNjNX49pWTxVUtIFI+0M
 ba4DwDvzwaiHSe45uupQXv6M+WyYuQ/vcDfGPQYIUtl+jeG98HbfnTEcfzqlm24rLoFY/CCn0Om
 WzzePZIJKESKoaOOgEIeiurGGoqN44jVTWGt3ZiGZwm82CnbMJygL202CCIvx9owApEXrc9wJ5A
 iI8T3OB2zNFH3LYB+uMvkg3z6ogCYpzAe+8+M7XnL5TaU0qqX37kX9m4+2HUsV+LWGxxM9qT/ce
 ayuyjWntTaldpvL7vGw==
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a749fa7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KaxKf6dAiZWKaP9yZAYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: Sg-gWM7fBi1ofVqdYgrkHNj57GSXFBXP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060116
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

On 6/8/26 12:21, Daniel P. BerrangÃ© wrote:
> On Wed, Aug 05, 2026 at 12:10:27PM -0700, Pierrick Bouvier wrote:
>> On 8/5/2026 9:53 AM, Daniel P. Berrangé wrote:
>>> On Wed, Aug 05, 2026 at 09:16:20AM -0700, Pierrick Bouvier wrote:
>>>> On 8/5/2026 7:05 AM, Daniel P. Berrangé wrote:
>>>>> On Fri, Jul 24, 2026 at 12:09:21AM +0000, Pierrick Bouvier wrote:
>>>>>> In the next commits, We'll replace the logic to filter QOM types per
>>>>>> target from a static one (based on INTERFACES) to a runtime one, based
>>>>>> on is_available() function, that can be overriden per class.
>>>>>>
>>>>>> Introduce the new interface we'll use for that.
>>>>>>
>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>>> ---
>>>>>>   include/qemu/target-info-qom.h | 15 +++++++++++++++
>>>>>>   target-info-qom.c              |  5 +++++
>>>>>>   2 files changed, 20 insertions(+)
>>>>>>
>>>>>> diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
>>>>>> index 91be415ed33..83eb537333b 100644
>>>>>> --- a/include/qemu/target-info-qom.h
>>>>>> +++ b/include/qemu/target-info-qom.h
>>>>>> @@ -14,6 +14,21 @@
>>>>>>   
>>>>>>   #define TYPE_TARGET_INFO "target-info"
>>>>>>   
>>>>>> +#define TYPE_TARGET_SPECIFIC "target-specific"
>>>>>> +
>>>>>> +typedef struct TargetSpecific TargetSpecific;
>>>>>> +
>>>>>> +typedef struct TargetSpecificClass {
>>>>>> +    InterfaceClass parent_class;
>>>>>> +
>>>>>> +    bool (*is_available)(void);
>>>>>> +} TargetSpecificClass;
>>>>>> +
>>>>>> +#define TARGET_SPECIFIC(obj) \
>>>>>> +    INTERFACE_CHECK(TargetSpecific, (obj), TYPE_TARGET_SPECIFIC)
>>>>>> +DECLARE_CLASS_CHECKERS(TargetSpecificClass, TARGET_SPECIFIC,
>>>>>> +                       TYPE_TARGET_SPECIFIC)
>>>>>
>>>>> Looking through the series,I don't really see the point
>>>>> in this interface.   Why is this not possible to do by
>>>>> adding 'is_available' to MachineClass.  It would make
>>>>> the rest of the series simpler and especially avoid the
>>>>> need to introduced yet more series of macros for defining
>>>>> machine classes.
>>>>>
>>>>
>>>> We'll need the exact same interface for cpus, and devices also. IMHO, it
>>>> makes sense to have this in an external interface, instead of forcing it
>>>> to be present in all cpus/devices/machines. I also considered adding it
>>>> directly in Object class directly (would be the simplest), but I felt it
>>>> would be hard to motivate it.
>>>
>>> I don't see a need for the common interface across cpus/devices/etc as
>>> as code that's filtering only cares about the specific types. It also
>>> definitely doesn't beloong in Object class, but the Object class could
>>> be changed to make it simpler.
>>>
>>
>> We agree on this.
>>
>>> The object_class_get_list() method could get a 'bool filter(ObjectClass *cl)'
>>> callback which could be invoked on each class to filter it.
>>>
>>> That said I find it pretty undesirable as an approach that we're
>>> registering classes that can't then be used in a given situation.
>>> This has a ripple effect where every bit of code that iterates over
>>> classes needs changing to add filtering after the fact. It is also
>>> not great for scalability, as it means every QEMU process will have
>>> the union of all classes for all targets registered, most of which
>>> have to be discarded / ignored at runtime.
>>>
>>
>> This is inherent to the nature of having a single binary.
>> We need to cover those two requirements:
>> 1. having a filter mechanism (per target)
>> 2. have all the classes accessible for the heterogeneous machines that
>> will be coming in the future
>>
>> 1. could be covered by what you describe, however, it breaks 2. For
>> this, you need to be able to register all types by design.
> 
> 
> Even the heterogeneous machines aren't going to need all the
> classes from all 30+ targets that QEMU supports.
> 
> IIUC, the current approach relies on '--target <blah>' to select
> which target we need. Would the heterogeneous machines not just
> change that to allow "--target <this> --target <that>". It still
> looks like we should be able to significantly limit  what we
> register for heterogeneous machines.

Heterogeneous binary won't filter anything at runtime (if we want
to filter components we already have Kconfig at compile time).

"--target <foo>" is only needed to have a single binary backward
compatible. If you use it, you fall back to single architecture
(our current binaries). If you want anything heterogeneous, you
can not use it. This will be by design.

