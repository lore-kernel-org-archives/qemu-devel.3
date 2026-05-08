Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A38ECD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 21:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLT9D-0000yo-Ub; Fri, 08 May 2026 17:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLT9B-0000yH-Tt
 for qemu-devel@nongnu.org; Fri, 08 May 2026 17:54:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLT99-0001l8-Si
 for qemu-devel@nongnu.org; Fri, 08 May 2026 17:54:13 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648KdfHs852271
 for <qemu-devel@nongnu.org>; Fri, 8 May 2026 21:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qWA7+BecjYalnZlIaIka+saU7x1bP/HbXClI/EPK3nQ=; b=cKuy/PAiZkqWACAa
 R65COuQMF6gczQ71y2d1j3pG5imUahE30D6Sm38Sj8FtGTUE0flQxYz7vZ8I9/We
 bIQVauGlbUhbZDZA1uWUO5O7klDcH6H19G+JHjjL4Mkq7q1MxDoG5eO4tcYz+qgT
 ipqXDK5Cbh9+PL5vaUY1nLW0YqFHzRXo9fjYnoL76M5sadQViTIXYdIyUWCxnCYz
 QgAg2x16pQMS/6McVyyDEye+aYaRMz8ynAVgvVGiPoXV1QOm6ZSC/BRwV3BsxFhx
 ZCg1BkycOygeR/jpOT23dwYw4t+t8WoQ5F3Uo0GgKH0qNeUSIE2E6uqRL+Hz3HQj
 l8cenA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1fptj2ev-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 21:54:09 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1325c685526so4952965c88.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 14:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778277249; x=1778882049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qWA7+BecjYalnZlIaIka+saU7x1bP/HbXClI/EPK3nQ=;
 b=WLaplJ6jozGPeCAUNXNeO9bT5I5O3G/BCoNhlE/YInsQ2JVzgHIWIL0J/xNmFJinke
 38YrPGW/03sK7GxIVKtVAhrLTl3noqQG8vkOLFMxZLSUmkeZT0miyvsSp3mis4YEvWKg
 sxItetFbvdD50XZcwqMeeFX6eiYTjCIr4bsFxcZSgRV0G7tudD5MSusmRYSTuRGJCf/g
 zG8BLYTqlpB1Z9r61vjppsBMDGU34QyYg8dNMkUsrLygGZOU2CaDKjxjGCrRsMlaIWFe
 dQDl2HdVbEgO6wNQT51T+OeQe2tC3eYond7FjrqHJPj8Fdvid5ZEOC/JxPnu+1VCewNW
 zScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778277249; x=1778882049;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qWA7+BecjYalnZlIaIka+saU7x1bP/HbXClI/EPK3nQ=;
 b=tJ7xHQsPX5wj2BZ2urkCZXfPVKy7LJt6RC8AsavmE0vLvBmPgfWNTnEm75U1vJmSkM
 kxfseYSeXyow1EadQrrgcQ/IKkdSI4rlIjERqa4Nf1WOKeLTERQfq4LHCK+G4ccf77W8
 9CMTFUlEG82T7auYbop9SHp8DFgUFOjZtqSY1pdLfyi8sgZ4/Bzz3tnDPaURV7kcKxAq
 0sMHJwuYLt4DpkrfOPFW8EvXL4H4ESEuqOQAlwvj3Iw/wATCpItYrdmRwe7CTWchxC1j
 Ejc5LikmtNQyMAHCiXMFi1o4EkIMkAA/ecXnJlbWd9mIXl9FaOg+8VSROhFCqukdMHLW
 By6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8X0ZoXA7zktNaD6PUhHHBRSKLo9hJaxzuE8TD5YBWLfYKeJlZRFm8IzpaZvTXkCs0RQ81M9lwaELD@nongnu.org
X-Gm-Message-State: AOJu0YxAK9QG58BdiM04HMzuaJm0qtu+2wNMtAiyS1UkmeV6suw7N3f1
 ei7LleO4EB1oppQnqDF1T+FbnpVR303PTaPHuApV1dEhVzQegqk9KeufuEDx1CtImVmdBpr7D+N
 FggAr9EYEeCMD067S0Q78niHQVv8tR1WO/JtuXiS14a8tW3Ycs7BdmyqBXQ==
X-Gm-Gg: AeBDiesQd3pNes9N+ISS5JbxVxIQPXJhuJYSIpoCPE7rOwe2f2xEUumrRtnxqvFiJVC
 8RNwKWIpIhHEhMD6X/iXjuJf0fAYr63hx9gomy4Qv19nxtXynXRHYGm/WeQs+//XahehDyZGYEC
 xhhUSx8Wmq41UlV2OoBi1aXgnYRm6fh9+FebNv0LtXjfe/MDaoaile/t0fT3Rlz3SxLPUIVszuw
 w33X3a9A/KLRyHLVEmKGHUImjeKkywby0fTHJ95nOVhwoL81veQ14T+6hwHazZ1GsTTIQSUeRaA
 amL70RSSk0Pjlq1wItbCyj7wwvIgUbQKtG2/L+yJ0lgA5A+/4L7TFAPGvwjmOWY2pLLn9GpGHFm
 0VBP7zkLRvmOh53tP5CKMC/gNUEplLCic+RisWqffWj6IvqJVl/HYt8m2qIx0DgdhbtA1lr/sGk
 4hf3D33Q/uUQS7TA==
X-Received: by 2002:a05:7022:6286:b0:12d:b7e5:a691 with SMTP id
 a92af1059eb24-132a78eaa30mr88407c88.7.1778277248909; 
 Fri, 08 May 2026 14:54:08 -0700 (PDT)
X-Received: by 2002:a05:7022:6286:b0:12d:b7e5:a691 with SMTP id
 a92af1059eb24-132a78eaa30mr88363c88.7.1778277248258; 
 Fri, 08 May 2026 14:54:08 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327865955fsm5036011c88.11.2026.05.08.14.54.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 14:54:07 -0700 (PDT)
Message-ID: <c81dd5ca-f189-4c60-ae73-aa8fc589b820@oss.qualcomm.com>
Date: Fri, 8 May 2026 14:54:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] target-info: introduce TargetInfo in QOM
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
 <20260505224826.2698753-5-pierrick.bouvier@oss.qualcomm.com>
 <3c379e6b-2009-4f7b-92df-c69c31897279@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3c379e6b-2009-4f7b-92df-c69c31897279@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0vIj2HN2J1nHC7djZfvilChfJ9VinqWJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDIxNiBTYWx0ZWRfX572k1Lpjl5iY
 Y+9D0QmRWDb06iaLQKggt0/1QiD6kqeLd+GqrpDirBixMxM9EcHah8W6nGaMuy3xo69fxHm8qY8
 ppeciR50FBY7unVaiMVRCLLOJopJ2fYz+Ifnqe1JYK/zFjnq9R7Z2DIyKHkvF+L+iEJDFuSh81x
 4ywg3HEOkMrYJE7q21osieN9lnyV5RuCVzgNn/wUyLA4vWKWsw9Jsv9f+BEiK9sp69ssk7Eg5bb
 UCoUFZt2ho0zB80cUN6oMUNim39cTgX+6MziH7iOtO0VRIfaqAv+eirjKu5mIE5t3JeKagRiS1g
 Ld2nMqSfsqCTumrz6chkRX0h9YvrFxW9iv0vKBXK0eRzAhZ6gvzwYy2VF+gqKuvdUw9haxJ7ir3
 rADJH3o4WoXrHFf3QT/go5cN1/Kaue3cbnJtaLqDtYxvQj638s/kcRE8IQJZazyF02z1uvXDPld
 +IG2HyWz7+OULRlxq5Q==
X-Proofpoint-GUID: 0vIj2HN2J1nHC7djZfvilChfJ9VinqWJ
X-Authority-Analysis: v=2.4 cv=IYi3n2qa c=1 sm=1 tr=0 ts=69fe5b81 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=rb7h1TKKZrmooqBdc3IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080216
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

On 5/8/2026 1:14 PM, Richard Henderson wrote:
> On 5/5/26 17:48, Pierrick Bouvier wrote:
>> diff --git a/include/qemu/target-info-init.h b/include/qemu/target-
>> info-init.h
>> index c781cfc0590..859451c672e 100644
>> --- a/include/qemu/target-info-init.h
>> +++ b/include/qemu/target-info-init.h
>> @@ -12,10 +12,67 @@
>>   #ifndef TARGET_INFO_DEF_H
>>   #define TARGET_INFO_DEF_H
>>   +#define
>> DEFINE_TARGET_INFO_TYPE(info)                                       \
>> +static void
>> do_qemu_init_target_info(void)                                  \
>> +{                                                                           \
>> +   
>> type_register_static(&info);                                            \
>> +}                                                                           \
>> +module_init(do_qemu_init_target_info, MODULE_INIT_TARGET_INFO)
>> +
>> +#ifdef COMPILING_PER_TARGET
>> +#ifdef CONFIG_USER_ONLY
>> +
>> +/*
>> + * User mode does not support multiple targets in the same binary, so
>> just
>> + * define target_info().
>> + */
>>   #define target_info_init(ti_var)        \
>>   const TargetInfo *target_info(void)     \
>>   {                                       \
>>       return &ti_var;                     \
>>   }
>>   +#else /* CONFIG_USER_ONLY */
>> +
>> +#include "qemu/target-info-qom.h"
>> +#include "qom/object.h"
>> +
>> +#define TYPE_TARGET_INFO_TARGET TYPE_TARGET_INFO"-"TARGET_NAME
>> +
>> +typedef struct TargetInfoQomTarget {
>> +    TargetInfoQom parent;
>> +} TargetInfoQomTarget;
>> +
>> +typedef struct TargetInfoQomTargetClass {
>> +    TargetInfoQomClass parent_class;
>> +} TargetInfoQomTargetClass;
>> +
>> +OBJECT_DECLARE_TYPE(TargetInfoQomTarget, TargetInfoQomTargetClass,
>> TARGET_INFO_TARGET)
>> +
>> +#define
>> target_info_init(ti_var)                                            \
>> +const TargetInfo
>> *target_info(void)                                         \
>> +{                                                                           \
>> +    return
>> &ti_var;                                                         \
>> +}                                                                           \
>> +                                                                            \
>> +static void target_info_qom_class_init(ObjectClass *oc, const void *
>> data)  \
>> +{                                                                           \
>> +    TargetInfoQomTargetClass *klass =
>> TARGET_INFO_TARGET_CLASS(oc);         \
>> +    klass->parent_class.target_info =
>> &ti_var;                              \
>> +}                                                                           \
>> +                                                                            \
>> +static const TypeInfo target_info_qom_target_type_info =
>> {                  \
>> +    .name =
>> TYPE_TARGET_INFO_TARGET,                                        \
>> +    .parent =
>> TYPE_TARGET_INFO,                                             \
>> +    .instance_size =
>> sizeof(TargetInfoQomTarget),                           \
>> +    .class_size =
>> sizeof(TargetInfoQomTargetClass),                         \
>> +    .class_init =
>> target_info_qom_class_init,                               \
>> +    .abstract =
>> false,                                                      \
>> +};                                                                          \
>> +                                                                            \
>> +DEFINE_TARGET_INFO_TYPE(target_info_qom_target_type_info)
>> +
>> +#endif /* CONFIG_USER_ONLY */
>> +#endif /* COMPILING_PER_TARGET */
>> +
>>   #endif /* TARGET_INFO_DEF_H */
> 
> If I understand this correctly, you're getting one symbol passed down as
> the argument to target_info_init, and you're getting another symbol
> implicitly from TARGET_NAME.
>

We have the top target-info class, and children classes (one per
target-info-$target). I first relied on QOM instance, but realized we
could simply embed the info we need in class, so everything is available
without needing to instantiate anything.
> AFAICS, this is incorrect for the configs/targets/*.c versions.
> Or at minimum really confusing.
>

I appreciate it can be confusing.
For every configs/targets/*.c, we get a unique QOM type out of this,
with its static class_init and static type_info struct. (1 func + 1
static struct).

From what I understand, the static struct is mandatory (we really need a
proper type per target), but maybe we could factorize the class_init,
and rely on data parameter, as you suggest later in this email.
I thought it was mandatory to have a custom class_init to perform the
cast to child class, but we can as well cast it directly to parent class
and call it a day.

It's my first adventure in QOM territory, and mostly relied on my C++
muscle memory, so it's totally possible I missed a point in how to
design things within QOM constraints.

> I'm trying to work out how target-info-stub.c and the configs/targets/
> *.c files can be unified.  Perhaps we have one large macro like
> 
> #define DEF_TARGET(NAME, ARCH, BITS, ...) \
> static const TargetInfo ti = {            \
>     .target_name = NAME,                  \
>     ...                                   \
> }                                         \
> static const TypeInfo type_info = {       \
>     .name = TYPE_TARGET_INFO "-" NAME,    \
>     .class_data = &ti,                    \
> }
> 
> Note as well that we can use .class_data and .class_base_init to avoid
> having lots of those trivial class_init functions.
>

Yes, will try that.

> Another option might be a .c.inc file which uses TARGET_NAME etc, which
> we then locally #define for the {arm,aarch64}-softmmu.c files prior to
> the #include.  I can see that might have to jump through hoops to avoid
> poisoned identifiers, but perhaps
>
> ---> /* Avoid poisoning identifiers we will supply locally. */
> #define COMPILING_PER_TARGET
> #include "qemu/osdep.h"
> ...
> 
> #define TARGET_NAME "arm"
> ...
> 
> #include "target-info.c.inc"
> ---
> 
> isn't too horrible, and in the end more readable than a mega macro.
>

It came through my mind, but remembered also the times I struggled with
(some) .c.inc files, and wanted to save time for other people that might
have to deal with that part in the future.

With the class_init deduplication, our big scary macro should turn into
a gentle one.

> 
> r~

Thanks for the feedback,
Pierrick

