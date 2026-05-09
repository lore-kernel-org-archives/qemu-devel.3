Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD852CD3445
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 15:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLjDO-0000wv-Ie; Sat, 09 May 2026 11:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLjDI-0000vn-NJ
 for qemu-devel@nongnu.org; Sat, 09 May 2026 11:03:32 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLjDE-0007VB-CN
 for qemu-devel@nongnu.org; Sat, 09 May 2026 11:03:31 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-42fdab683a9so2224822fac.1
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 08:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778339006; x=1778943806; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oECUhms8xXPdGv2JZBB5q6VF/mwAZxrenD2nZvD2qwU=;
 b=YJ+gCsaHG4O6PWWX0BzyRyCYOQbOLPr/sBQLCxQIgKIhRJUcVhBfxBtaVRz07ljMJD
 Esfq3ihE15Mdob4JApxp9V6DrzuamkJuEA347XJg0bieHMTLDrJH1h0R1xykkFVLXTzc
 VAXLAr31RfGWBDONJHjWDmFEbh6zGJ/Vt+mVrOmpHgTRGYjXhzXXsZdGfgF87O/rYMEK
 HdYZa4uNoA2O0dWElDcqiN6ttgaWVP8Q9wUJWfVAx0Gl9WrBzbhDJSeLPrEOtRoA16dV
 tOKSrYrbyFsHREoCuCnHd3/ju/vGNy69XOZRGuUZKWRLjEBHMAPh04I7nrs22Om3HXDU
 /EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778339006; x=1778943806;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oECUhms8xXPdGv2JZBB5q6VF/mwAZxrenD2nZvD2qwU=;
 b=bGjdI2wh7glDC+Mt89CnuE6WErN4YMUPPQ1em90XA7Qka5pgnPYvzUFji+3lk9Cgfe
 xpkztoZmETdZW98/xpMBE6gW63m1XQcoNoSBtFJpxEcBs2rbbPmHa7nLewjIBVoyFNeS
 rki/djPnhF66zYf5SvvPJcHKbPx2S09TuNHobF1bKnqc+jy7uT2DRHhvJKT5sPqsK+Fs
 lYKNzIxklOrCAlJ1SK06LVXMEBt1T/RWH16dIEuvrLyL+ztPwarMQWd960aTx2E63TBR
 S0HSMIflaOnn5tyVrcwJ+I8ky7Hx6Dvj1dic1BdbFoI+wFlmS3Qk17PoGrSqqgJ5HWee
 seDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nYl/Yw5cZiCmYyxnTycs1d+5x6DXMAWIpTRHzABIFsEXkSehYwfg/GHnGEzybatNmMvRdkxLaxwDR@nongnu.org
X-Gm-Message-State: AOJu0YyJfO3kO9JYplK8vbGuyZYb9uv0/h8rQREV0BTvPj+7oQHMm313
 r7JXrP1UK+aqhYVp9VTWgPQCCVeflWvPGZ4Nn1qAkY0tU0QTndC8f9VGFd3l/psIvxg=
X-Gm-Gg: Acq92OGY+nernpilpt3PwB+D5a7yV6IBZpNBsblfuCm5gAn04OlNVNJIgIYEs9s3Pnh
 gWEnbCp7SxYRZ+/7yWBIhl8KT6lqxjIMajnCGe0ufPztL8l1vsANUO+zoKxkx8dRfFdxu9KC+76
 eyb61XL2Ei7lvQZdlALXdjG69x17/OMc/7DhfXk93Z3w5foi+kItbfKsQPf3Nkj7fPDgbIyMI2c
 j1+5eB7IXw852RTcoItOK1he4Q723Z5D2CWozWov9anu58HQS8L0/Y+x2AoyHeXxSapPh45oXx6
 WnlwZKDhXktksqynf9acQ9lXW8B0+jkaTylrQtHj3gurrx5CrwR2ZE1qeJeQIMwWZYzMbmy055Y
 li8VVqEisDsHJGwPWwdnmX5Sh3seagvKB/bOQZOMahZDUGl2ahg5oPfHxqb5we5SD+tbbWpqnrL
 GlCXZtliNCvDVY27GApk4dpL++OQowUUf3BkALISFbXkF/PvObHdwaNRE4hiwVALYVFD3bDyKab
 1s+E1vgvg==
X-Received: by 2002:a05:6870:16d2:b0:41c:616:5317 with SMTP id
 586e51a60fabf-434f6776953mr11315705fac.39.1778339005556; 
 Sat, 09 May 2026 08:03:25 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:88d3:58e4:a68b:b30c?
 ([2600:381:c938:6375:88d3:58e4:a68b:b30c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b67sm4479590fac.6.2026.05.09.08.03.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 May 2026 08:03:25 -0700 (PDT)
Message-ID: <7bdc61c1-3dad-49b5-b385-4e9fbd0fc1c6@linaro.org>
Date: Sat, 9 May 2026 10:03:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] target-info-qom: use a single class_init for
 target-info-* classes
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
 <20260509005453.3984184-7-pierrick.bouvier@oss.qualcomm.com>
 <7854820a-9879-47ec-95ba-7f7ae65374a0@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <7854820a-9879-47ec-95ba-7f7ae65374a0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/8/26 19:59, Pierrick Bouvier wrote:
> On 5/8/2026 5:54 PM, Pierrick Bouvier wrote:
>> Instead of defining a class_init per class, just use a common
>> constructor and set class_data to corresponding TargetInfo structure.
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   include/qemu/target-info-init.h | 14 ++------------
>>   include/qemu/target-info-qom.h  |  1 +
>>   target-info-qom.c               |  6 ++++++
>>   3 files changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
>> index 176fd975a16..3945f2998e0 100644
>> --- a/include/qemu/target-info-init.h
>> +++ b/include/qemu/target-info-init.h
>> @@ -37,8 +37,6 @@ const TargetInfo *target_info(void)     \
>>   #include "qemu/target-info-qom.h"
>>   #include "qom/object.h"
>>   
>> -#define TYPE_TARGET_INFO_TARGET TYPE_TARGET_INFO"-"TARGET_NAME
>> -
>>   typedef struct TargetInfoQomTarget {
>>       TargetInfoQom parent;
>>   } TargetInfoQomTarget;
>> @@ -47,24 +45,16 @@ typedef struct TargetInfoQomTargetClass {
>>       TargetInfoQomClass parent_class;
>>   } TargetInfoQomTargetClass;
>>   
>> -OBJECT_DECLARE_TYPE(TargetInfoQomTarget, TargetInfoQomTargetClass, TARGET_INFO_TARGET)
>> -
>>   #define target_info_init(ti_var)                                            \
>> -static void target_info_qom_class_init(ObjectClass *oc, const void * data)  \
>> -{                                                                           \
>> -    TargetInfoQomTargetClass *klass = TARGET_INFO_TARGET_CLASS(oc);         \
>> -    klass->parent_class.target_info = &ti_var;                              \
>> -}                                                                           \
>> -                                                                            \
>>   static const TypeInfo target_info_qom_target_type_info = {                  \
>> -    .name = TYPE_TARGET_INFO_TARGET,                                        \
>> +    .name =  TYPE_TARGET_INFO"-"TARGET_NAME,                                \
>>       .parent = TYPE_TARGET_INFO,                                             \
>>       .instance_size = sizeof(TargetInfoQomTarget),                           \
>>       .class_size = sizeof(TargetInfoQomTargetClass),                         \
>>       .class_init = target_info_qom_class_init,                               \
>> +    .class_data = &ti_var,                                                  \
>>       .abstract = false,                                                      \
>>   };                                                                          \
>> -                                                                            \
>>   DEFINE_TARGET_INFO_TYPE(target_info_qom_target_type_info)
>>   
>>   #endif /* CONFIG_USER_ONLY */
>> diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
>> index 91be415ed33..a37c3e101e0 100644
>> --- a/include/qemu/target-info-qom.h
>> +++ b/include/qemu/target-info-qom.h
>> @@ -25,6 +25,7 @@ typedef struct TargetInfoQomClass {
>>   
>>   OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
>>   
>> +void target_info_qom_class_init(ObjectClass *oc, const void * data);
>>   void target_info_qom_set_target(void);
>>   
>>   #endif /* QEMU_TARGET_INFO_QOM_H */
>> diff --git a/target-info-qom.c b/target-info-qom.c
>> index cc470b3b4d6..5b0498ca654 100644
>> --- a/target-info-qom.c
>> +++ b/target-info-qom.c
>> @@ -37,6 +37,12 @@ static const TypeInfo target_info_parent_type = {
>>   
>>   DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
>>   
>> +void target_info_qom_class_init(ObjectClass *oc, const void * data)
>> +{
>> +    TargetInfoQomClass *klass = TARGET_INFO_CLASS(oc);
>> +    klass->target_info = data;
>> +}
>> +
>>   static const TargetInfo *target_info_ptr;
>>   
>>   const TargetInfo *target_info(void)
> 
> This patch can be squashed with 3, but I thought it might be better for
> review to keep it on top for now.

Mmm.  You've missed the part about using class_base_init instead of class_init, so that 
you don't need the extern function declaration.  See review of patch 3.


r~

