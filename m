Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01ED0CD37B2
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 21:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLpEp-0001KY-Bc; Sat, 09 May 2026 17:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLpEn-0001KK-Bw
 for qemu-devel@nongnu.org; Sat, 09 May 2026 17:29:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLpEl-0001eD-L7
 for qemu-devel@nongnu.org; Sat, 09 May 2026 17:29:29 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 649L0jiX1768168
 for <qemu-devel@nongnu.org>; Sat, 9 May 2026 21:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xb76E9MbUZaXM0JC1CiISd1mOXxmdaZr9LMA78lBvQY=; b=dUB/d0nU5ezOrrwo
 NsJIWaRC1KxEsk43yEHrSEa3p+1RXpVkSW9Y/UX6Hhhzawd+gWnqZBL016b4EAUs
 m8fFX3oBDwCXu4In8Ju9BuzAf0wlzLM4Jn2V7AQMMV0WIdHyuwY66u7HvoaHLA2l
 9SIovjeXGSw63xyLK+QWnOcF2v+zn6VA1Eji2SuvgCfuR1pJFlXfmgq2r0DjFddS
 976MgIv7J+DeFgQzhlvqkKmtQe9ZP2KkD52Gsn4+a0VuLyWjQO5fdJ1n7XHlocWA
 dguYMdGmgwJkHgCGCRHTOdEJU9gC28p9JDPbPecgc/TDL6/wNJKFD1/a1Ltllg2j
 Al62yA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1t9q220a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 21:29:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ef37c3f773so3785091eec.1
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 14:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778362165; x=1778966965; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xb76E9MbUZaXM0JC1CiISd1mOXxmdaZr9LMA78lBvQY=;
 b=E3FPRVtNBrgDKY187M6024qoFzKvD0yEaRn4Gik/oZ7CD5IgpeS/gEgdDAeeUig3da
 JUWGHo+ZlodGP2xCiLgS7dGb5rGFRvqdMNqHPH8lQyZxRADjqLuCZpR8XjjWGHxZPDhW
 awN3PiSBBaF5FhOIQ+WpVfFpRH61E9mUWIprfGiwKVUb1vE0+0ppVJRyuTBbX85CPceO
 CuQZJmYgrz0Zs2hcQ45r9YPmn+pqnmZW4Y78YdLlHN8hB+zMftg62UPIGA92qV7KdHVI
 GjIy8y5RwQabKaF+avYtVWyo/KhBb4S0zPl4rH4KwuVDsYbf3k8Wt+yOSwusIAAGYYCJ
 XbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778362165; x=1778966965;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xb76E9MbUZaXM0JC1CiISd1mOXxmdaZr9LMA78lBvQY=;
 b=rKP4ILWRqzMVV0xOlYseYjXsXSGd2oG/XUN+r7Nyr4xKzWWJ4MdE9iZXq5458vyPTC
 ZJgyTmACNzs9nxzezENcCXg/zNvY/cilB/ca+zJ0WseHhozIOc0m21mItQHd7QF89rNO
 Jf3LzVmqWkR44MNqCJLneDUcwHSQSApk0E2cvgTfYCyq8YRedHgFsXEIn8WseQ8bEtjd
 xOd1VKHoHw/ge0+0qVf5FzcmaGCUXlhfsUXmUn8oDdSL9S1hbF8PFkpeLE1Ra6SUKZip
 vy7balIVNmB1vqFGpxj9Mg2W3jSGbwNKfsUqr3XjnIwBxZ9jThKBmnALB0UcXcNhSYWR
 /PSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Y1/GzzhnMvNQwt9eHW7R7rNB75fSGq3hcQ7Pr1Vr5cki3rNvd5MRj2PDKYeNXgf7heQNMSvLCBPSW@nongnu.org
X-Gm-Message-State: AOJu0Yz07/Ac7MbLjDkjkJ+0V5OdtRs9z4Y+SZmVIQGjw3YKulKiu7zL
 iVnEnvVX9hdgUy6Ur+Oun3/7vghValveeXpL1eq/fsVORRo0tpv4fQpZQg/4lCyB1IrDO1kaWod
 SNOxNHy75e8Jd4A3GIjnCvavoS4QEmC/H6m5HItBvTukjn6oJfef5IfHJjQ==
X-Gm-Gg: Acq92OG3By9k1zsrwv+AHmBrGPcgZDntWUhv3cBJg3IoGF4xe0H9H7Iy7G/n2whA6DH
 GToT+fG7cGve7kxFaCpRMxrHySH3Rd0GRcr4dWRebWzXWDJ1WQjCWyf+mAdtArjzELttQgEjjir
 QiKTjDry4jF1qyz8W6fZr2xbO6oN5q97S+xO7PgS9HbWN/b5wjhpkBsvFGuBidXyvAfnZhH9VAE
 ux+rrwNknfi8L7ejwiXIIfDQ/gF/zInsOm5vLF9QYyu59ItbCiMzzj50C/gQ5gl5c7/zgxw2RtZ
 NsY396fkmiLMEjjksEPF3x52fIa1HVs+INIISy9L+HVpeEU8/G8GnQqLfAXfvjMmwCaHKg0bTW1
 oGB3qdhRySORXjebdtUYZfXsbGs1wsFAhd6wLx9EiAPL30w60qvsQqydwj30ZwSqkQVM/15TbxZ
 0VkTr8NWyK/5tMTw==
X-Received: by 2002:a05:7300:ec08:b0:2ea:c085:44b1 with SMTP id
 5a478bee46e88-2f549f838d8mr7994741eec.19.1778362164553; 
 Sat, 09 May 2026 14:29:24 -0700 (PDT)
X-Received: by 2002:a05:7300:ec08:b0:2ea:c085:44b1 with SMTP id
 5a478bee46e88-2f549f838d8mr7994724eec.19.1778362163819; 
 Sat, 09 May 2026 14:29:23 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888d3af4esm7557309eec.25.2026.05.09.14.29.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 May 2026 14:29:23 -0700 (PDT)
Message-ID: <626b60c0-2d2d-4ef9-a5fc-48ea192dd2b9@oss.qualcomm.com>
Date: Sat, 9 May 2026 14:29:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] target-info-qom: use a single class_init for
 target-info-* classes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
 <20260509005453.3984184-7-pierrick.bouvier@oss.qualcomm.com>
 <7854820a-9879-47ec-95ba-7f7ae65374a0@oss.qualcomm.com>
 <7bdc61c1-3dad-49b5-b385-4e9fbd0fc1c6@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <7bdc61c1-3dad-49b5-b385-4e9fbd0fc1c6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: G-JTltmmj_EwdRGJyei-M7rYIC51CqKR
X-Proofpoint-ORIG-GUID: G-JTltmmj_EwdRGJyei-M7rYIC51CqKR
X-Authority-Analysis: v=2.4 cv=J7yaKgnS c=1 sm=1 tr=0 ts=69ffa735 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=UvhoqJAvBteyMnZVz78A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDIzMCBTYWx0ZWRfXwfxdxZ1TlDZl
 LV3dWwTlvXDzs3sqphZ80WDsqWKUKc/KNt22a7x3O2OvElj+7KS3o224LHbGfXkRVbKTAm2cNSY
 yS8NXHifiU6Zch9PO+2vaKJMWuiNVTY8hJm2tXkBvqEZu58kY7ItiIT9CXSmPXfCyLsWVWF6CSn
 OX8zgzvhNtIjSun7xjXmA0dUwcr5qZk5V8fvFQNlnZsvEJiXNMz2ZBkpp0NrPjq+b2wxZnAQ3FF
 3ufd4dRXKhCc7FgoKmG4fizMsXLjo+NfXXybxtfIX1m9Rb2TS3jmLpE7S28X+mdhjAbqWZ68y7Q
 o+hBTAoI8mQu+cNIraVvGViVyySPfJHVnDKZqfkpd3MtaJGfOGjh4HCJ7smL4iOT93dCddWyXkC
 u5KZW2GVDFkUA/3iPabGld1D4pPPgrs+t0psPcQt7zB5X4LMFQNiJHl+iKBSo3IAvgwjk+PL5+b
 ZNDF08pkJ7uIX3dlNhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_06,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090230
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

On 5/9/2026 8:03 AM, Richard Henderson wrote:
> On 5/8/26 19:59, Pierrick Bouvier wrote:
>> On 5/8/2026 5:54 PM, Pierrick Bouvier wrote:
>>> Instead of defining a class_init per class, just use a common
>>> constructor and set class_data to corresponding TargetInfo structure.
>>>
>>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>   include/qemu/target-info-init.h | 14 ++------------
>>>   include/qemu/target-info-qom.h  |  1 +
>>>   target-info-qom.c               |  6 ++++++
>>>   3 files changed, 9 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/include/qemu/target-info-init.h b/include/qemu/target-
>>> info-init.h
>>> index 176fd975a16..3945f2998e0 100644
>>> --- a/include/qemu/target-info-init.h
>>> +++ b/include/qemu/target-info-init.h
>>> @@ -37,8 +37,6 @@ const TargetInfo *target_info(void)     \
>>>   #include "qemu/target-info-qom.h"
>>>   #include "qom/object.h"
>>>   -#define TYPE_TARGET_INFO_TARGET TYPE_TARGET_INFO"-"TARGET_NAME
>>> -
>>>   typedef struct TargetInfoQomTarget {
>>>       TargetInfoQom parent;
>>>   } TargetInfoQomTarget;
>>> @@ -47,24 +45,16 @@ typedef struct TargetInfoQomTargetClass {
>>>       TargetInfoQomClass parent_class;
>>>   } TargetInfoQomTargetClass;
>>>   -OBJECT_DECLARE_TYPE(TargetInfoQomTarget, TargetInfoQomTargetClass,
>>> TARGET_INFO_TARGET)
>>> -
>>>   #define
>>> target_info_init(ti_var)                                            \
>>> -static void target_info_qom_class_init(ObjectClass *oc, const void *
>>> data)  \
>>> -
>>> {                                                                           \
>>> -    TargetInfoQomTargetClass *klass =
>>> TARGET_INFO_TARGET_CLASS(oc);         \
>>> -    klass->parent_class.target_info =
>>> &ti_var;                              \
>>> -}                                                                           \
>>> -
>>>                                                                             \
>>>   static const TypeInfo target_info_qom_target_type_info =
>>> {                  \
>>> -    .name =
>>> TYPE_TARGET_INFO_TARGET,                                        \
>>> +    .name = 
>>> TYPE_TARGET_INFO"-"TARGET_NAME,                                \
>>>       .parent =
>>> TYPE_TARGET_INFO,                                             \
>>>       .instance_size =
>>> sizeof(TargetInfoQomTarget),                           \
>>>       .class_size =
>>> sizeof(TargetInfoQomTargetClass),                         \
>>>       .class_init =
>>> target_info_qom_class_init,                               \
>>> +    .class_data =
>>> &ti_var,                                                  \
>>>       .abstract =
>>> false,                                                      \
>>>   };                                                                          \
>>> -
>>>                                                                             \
>>>   DEFINE_TARGET_INFO_TYPE(target_info_qom_target_type_info)
>>>     #endif /* CONFIG_USER_ONLY */
>>> diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-
>>> info-qom.h
>>> index 91be415ed33..a37c3e101e0 100644
>>> --- a/include/qemu/target-info-qom.h
>>> +++ b/include/qemu/target-info-qom.h
>>> @@ -25,6 +25,7 @@ typedef struct TargetInfoQomClass {
>>>     OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
>>>   +void target_info_qom_class_init(ObjectClass *oc, const void * data);
>>>   void target_info_qom_set_target(void);
>>>     #endif /* QEMU_TARGET_INFO_QOM_H */
>>> diff --git a/target-info-qom.c b/target-info-qom.c
>>> index cc470b3b4d6..5b0498ca654 100644
>>> --- a/target-info-qom.c
>>> +++ b/target-info-qom.c
>>> @@ -37,6 +37,12 @@ static const TypeInfo target_info_parent_type = {
>>>     DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
>>>   +void target_info_qom_class_init(ObjectClass *oc, const void * data)
>>> +{
>>> +    TargetInfoQomClass *klass = TARGET_INFO_CLASS(oc);
>>> +    klass->target_info = data;
>>> +}
>>> +
>>>   static const TargetInfo *target_info_ptr;
>>>     const TargetInfo *target_info(void)
>>
>> This patch can be squashed with 3, but I thought it might be better for
>> review to keep it on top for now.
> 
> Mmm.  You've missed the part about using class_base_init instead of
> class_init, so that you don't need the extern function declaration.  See
> review of patch 3.
>

I feel that this pattern of using a super ctor with a data set by child
is very counter intuitive, but I'll trust your judgment on how QOM is
supposed to work.

I'll squash this with patch 3 in next version so there is no confusion also.

> 
> r~

Regards,
Pierrick

