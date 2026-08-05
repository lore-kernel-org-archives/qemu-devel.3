Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2594C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrh0n-0007eV-1z; Wed, 05 Aug 2026 15:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wrh0h-0007eC-GU
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 15:10:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wrh0c-0005Mr-TW
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 15:10:39 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675HSIa13596727
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 19:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 074MdNQg6IrB3m1lyS8fkOltcPJTQBiqmsrxoybI3Co=; b=VDN0/aoUSaOGGsXl
 KMOnjBBoO9MzFEA4kb8BWoSCgC8HYNQf+368ccl1C+38G2bEF6j8w3uBaWd0OSku
 Yk7H6IyEji7CYHxNzCkcuFpy96ROaBrFdx0yukgCtj4GaQSazKnKvUKqpyqCGq6h
 7KU+elamPFWT6QzyiQpsMAdTFAL+jMcGfJXJaoGshchK2p7OVXfLca5UekdE/MFl
 fOZjctXfiNpz+8D8JPIZn57gumecuSkZLUMhvK7Mgg9IKLmFCAEQy6W/Ax3VSPNs
 965HmZxht3UamxA6FHRqE7ymK9VmMuLd28YVW6kxuyToWOJnLpaFbL5kGWGs0P/O
 J+6LTg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv2c0anyw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 19:10:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38f0fe57470so194935a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 12:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785957031; x=1786561831; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=074MdNQg6IrB3m1lyS8fkOltcPJTQBiqmsrxoybI3Co=;
 b=L8x6wC5TxBxdcPuT9w1PO5RxRBV9arN6CpU9xEb3d3veOaTIAuv1gpnQAf08XTZhZd
 WrcZsIgp1G2IlF4kqSvMert2e1SxGemvDkgMey5hgWwCf+qLF95W3ee/V+45+LCyc1RX
 AdlzNKDYXc1Ih3ncK0Z+rm4uFPybSm8/XcjmJLnVDxFcPJPc1kujfuCt6sLASEcqTTDB
 TwdD6AyKSaXFmwaOp6rpTQITXdB+xv+6/PkxS1eGI0O0dXxiL20DVJ+9n4b4RNv9LA/J
 vYWhhfKi4mfNCIdnJdV9EpLYCCnzDUqhcreTMSapSnV+DvtJIpppXr63+RBkE707sPRF
 +80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785957031; x=1786561831;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=074MdNQg6IrB3m1lyS8fkOltcPJTQBiqmsrxoybI3Co=;
 b=Onh6bWNtvlsIQSQSPwKl2eaf1WQRSSEwiv478ah3WP6sw2iucaCFH12hfvKtm0O3KF
 Nvpq3WOFYWTt3G8uYlmQ2y6vZ5GLZfO6tuzuVi+jWa4/g/wdGy42gcKGLZqfg+G5omHx
 AsD6A9hG2Uo4CaiwvR1kK83g8yU1Piw9v144nSaSH6/NKSdXiTlGC2CWDoa0VpeRy1mM
 EXlG1kudANEe8UVFenn3Xvtdk3Atur3SZQxFe5ILQQandfsCHA1hhnYPn4fd7sq550Pi
 H5nTDvAt9WFRsMRfLnTNtSozM+d7AHK/3oE7YTA6gwaRRok6d/5qtzptnnrQksSKahXO
 KVlw==
X-Gm-Message-State: AOJu0YxzqS2NBUARNTBCxOSMhNbuopOvFZz0mxNbIuemwzipJFZP0ESI
 +GIxpIoYk7FbE/y6vQstiuPBvMESBtmjx28mEngWS/9PRyTJMbM7VSNxq8BS27vCk/uE4d3f/g3
 vH2cbyO7s4g/Vf4mxmzkzN8VUuPr1FQNqiEY/zZ+7MJRhkBK4evtkhJQtpg==
X-Gm-Gg: AR+sD10/gi7P9bLItV3i8iGfD77A/+Ak6YYJcGfTwAG6WJGTheV5+h5BC/Wng//CCvp
 6fLeS0x5eutb4Hov1ClvEBH6AXaiKXLl4UfQ0LEqpeDGwbZSFWQx02XHCx4xhSpvvZN69ngZZSa
 mR72vJp6asqn02gs12nYVxf7P9QjJkNtK6fbqKWnJKOvPIV79TCa6DDUEH3zXMspIf2B1Qi9fDG
 zio1wE71eoMfOPn0oRHWOeOqMyy6KBBbI1GubWS0gHyXEPfxmc78geOc2NqL3b6f8htg7dKZkq0
 7pT+qbYiH7iap8+yYIFYzuOuEvw7r3HYzbhl9hKBlSbZxcDxzErrsc25D67WdgOJWFdpuNhO/I6
 OJHSaginALX0qUBf+Sq7R75lPwyvMpi+8txtKEAtU7MQkg4QT2mWbb9AUfPLT7eWpXETn
X-Received: by 2002:a17:90b:3b89:b0:38f:cfe2:fd3a with SMTP id
 98e67ed59e1d1-39083b030demr629957a91.15.1785957030417; 
 Wed, 05 Aug 2026 12:10:30 -0700 (PDT)
X-Received: by 2002:a17:90b:3b89:b0:38f:cfe2:fd3a with SMTP id
 98e67ed59e1d1-39083b030demr629922a91.15.1785957029763; 
 Wed, 05 Aug 2026 12:10:29 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fca63ce12sm20125557c88.5.2026.08.05.12.10.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 12:10:29 -0700 (PDT)
Message-ID: <a9c89dd7-6317-42f1-9e03-30e48c2d08aa@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 12:10:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] include/qemu/target-info-qom.h: declare
 TYPE_TARGET_SPECIFIC interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Nicholas Piggin <npiggin@gmail.com>,
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <anNqhjSU5tEDC0br@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tm7isW7FCWTw0Iu7390tcY7qsPCjXWZW
X-Authority-Analysis: v=2.4 cv=aOfAb79m c=1 sm=1 tr=0 ts=6a738aa7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=e2bK46OptfiluozgRIcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE1NyBTYWx0ZWRfXxzvGPkBc2vII
 zxee/sl5bXpojeDb9rKKeUTVIsisIo2v2P96cG7foJcgUyXLwuHB9P6micwGmMJ+z0Swh63p1X9
 BcYcO1hPF2P/zCeqdzG0nF1NkYGGAyk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE1NyBTYWx0ZWRfX893/1KdyuP3B
 TjFtlhbz53QCFNxus7a5KGnuFQHy/n/aWP1ojtIelN9l2YZtCMYfXQ0fCLOXw8bRErYkYYgGBy0
 Y9JFF1GnR5XmAy/BD/yJL7jB4ErI6NKX/JR25GjaggirvyxI20n1MlXhSUpnIkLYK2kE9myTkWh
 B0Tc8jmAVktkUVMsQe4YBz2wuCqxIiED9wuWij850NKz/R5WnbyVlUgboAkH5FLtx2YgFXgEidR
 hLRtTGzWM04o9xuOlHKuBfcrAyeZ2NR1oKVyrtwpxpepBcCk+sX0Yw5yMzzoP6moqMPcJ7wyJXm
 Hbqah42RvnIHQYVm03R1A/PKwIUa0fVG//JzqTh+eebrSYEOrUKwr/LKvso9Qf9M4FzeGjfehn2
 nRmtL/N4g4pA6N6qMPBTNMYRt7HYpVLnoTVNAv72iIlz8BN9q2OaJg0CxZ4I+IYaQdaKi2A2KwY
 OnCTPa2mZ55PTE9T3nA==
X-Proofpoint-GUID: tm7isW7FCWTw0Iu7390tcY7qsPCjXWZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050157
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

On 8/5/2026 9:53 AM, Daniel P. Berrangé wrote:
> On Wed, Aug 05, 2026 at 09:16:20AM -0700, Pierrick Bouvier wrote:
>> On 8/5/2026 7:05 AM, Daniel P. Berrangé wrote:
>>> On Fri, Jul 24, 2026 at 12:09:21AM +0000, Pierrick Bouvier wrote:
>>>> In the next commits, We'll replace the logic to filter QOM types per
>>>> target from a static one (based on INTERFACES) to a runtime one, based
>>>> on is_available() function, that can be overriden per class.
>>>>
>>>> Introduce the new interface we'll use for that.
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>> ---
>>>>  include/qemu/target-info-qom.h | 15 +++++++++++++++
>>>>  target-info-qom.c              |  5 +++++
>>>>  2 files changed, 20 insertions(+)
>>>>
>>>> diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
>>>> index 91be415ed33..83eb537333b 100644
>>>> --- a/include/qemu/target-info-qom.h
>>>> +++ b/include/qemu/target-info-qom.h
>>>> @@ -14,6 +14,21 @@
>>>>  
>>>>  #define TYPE_TARGET_INFO "target-info"
>>>>  
>>>> +#define TYPE_TARGET_SPECIFIC "target-specific"
>>>> +
>>>> +typedef struct TargetSpecific TargetSpecific;
>>>> +
>>>> +typedef struct TargetSpecificClass {
>>>> +    InterfaceClass parent_class;
>>>> +
>>>> +    bool (*is_available)(void);
>>>> +} TargetSpecificClass;
>>>> +
>>>> +#define TARGET_SPECIFIC(obj) \
>>>> +    INTERFACE_CHECK(TargetSpecific, (obj), TYPE_TARGET_SPECIFIC)
>>>> +DECLARE_CLASS_CHECKERS(TargetSpecificClass, TARGET_SPECIFIC,
>>>> +                       TYPE_TARGET_SPECIFIC)
>>>
>>> Looking through the series,I don't really see the point
>>> in this interface.   Why is this not possible to do by
>>> adding 'is_available' to MachineClass.  It would make
>>> the rest of the series simpler and especially avoid the
>>> need to introduced yet more series of macros for defining
>>> machine classes.
>>>
>>
>> We'll need the exact same interface for cpus, and devices also. IMHO, it
>> makes sense to have this in an external interface, instead of forcing it
>> to be present in all cpus/devices/machines. I also considered adding it
>> directly in Object class directly (would be the simplest), but I felt it
>> would be hard to motivate it.
> 
> I don't see a need for the common interface across cpus/devices/etc as
> as code that's filtering only cares about the specific types. It also
> definitely doesn't beloong in Object class, but the Object class could
> be changed to make it simpler.
>

We agree on this.

> The object_class_get_list() method could get a 'bool filter(ObjectClass *cl)'
> callback which could be invoked on each class to filter it.
> 
> That said I find it pretty undesirable as an approach that we're
> registering classes that can't then be used in a given situation.
> This has a ripple effect where every bit of code that iterates over
> classes needs changing to add filtering after the fact. It is also
> not great for scalability, as it means every QEMU process will have
> the union of all classes for all targets registered, most of which
> have to be discarded / ignored at runtime.
>

This is inherent to the nature of having a single binary.
We need to cover those two requirements:
1. having a filter mechanism (per target)
2. have all the classes accessible for the heterogeneous machines that
will be coming in the future

1. could be covered by what you describe, however, it breaks 2. For
this, you need to be able to register all types by design.

For listing cpus, machines and devices, we provide the filtering
functions associated. The surface of what we need to change is very
limited. There are less than 10 call sites with TYPE_{CPU, MACHINE, DEVICE}.

> 
> IMHO we should never register the classes to begin with.
> 
> The trick is dealing with dependencies/ordering during early startup.
> 
> eg taking one random example:
> 
>   static void zynq_machine_register_types(void)
>   {
>       type_register_static(&zynq_machine_type);
>   }
> 
> IMHO we ought to be able to say in that:
> 
>   static void zynq_machine_register_types(void)
>   {
>       if (target_arm()) {
>         type_register_static(&zynq_machine_type);
>       }
>   }
> 
> The problem is target_arm() depends on having parsed the '-target'
> argument. The type register methods are called from qemu_init_subsystems(),
> which is called before we have done CLI parsing. This looks fixable
> though. We already have two iterations over argv in qemu_init().
> 
> We can move qemu_init_subsystems after the first iteration, and
> process -target in the first iteration.
>

I already have all this implemented in the way you describe. However, as
explained above, we need to support 2, which brought the current design.

It would be bad to implement something and have to change it all again
in 6 months when we'll experiment with an heterogeneous machine.
We also made the promise (and we'll hold it) that single-binary will not
add yet another config.

So the last thing I would like to see is:
if (target_arm() || single_binary_...()) {		
  type_register_static(&my_heterogeneous_machine_type);
}

Unfortunately, if we stick to "register only types we can use", it
becomes the only way to solve it.

> 
> With regards,
> Daniel

Regards,
Pierrick

