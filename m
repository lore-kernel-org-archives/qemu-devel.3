Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46511CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 22:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLTHj-00030S-4M; Fri, 08 May 2026 18:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLTHh-000309-FZ
 for qemu-devel@nongnu.org; Fri, 08 May 2026 18:03:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLTHf-00044t-GP
 for qemu-devel@nongnu.org; Fri, 08 May 2026 18:03:01 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648GU1hf145625
 for <qemu-devel@nongnu.org>; Fri, 8 May 2026 22:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fKJH4AVRY0aOrlrR9PNmfX+bmpndXFZiS5gpZRfoK+0=; b=kYMlhN5JSG5Uea6s
 AGnFjDX3/pOEX7HF4AH6DJNCWLvh3nlj7/w0i4auI7Gjs6/p65bHEwOS1PgP2Zvn
 tXO5qBKFD2IjLWX+lpN1K9jvp5LYWLc4ldWlzJyJUuA823Iw0u3BwWGm108pGieS
 M6FqYzbSJc3YvIhwF90oAu3EMDeVLJP2/Ce/ur1OayBrqP3cFlkXs4eIbSMgOUMy
 o7g+U5nLemuBA6AMH8rUdrz0sxj/YQmwSOm1lcl9hfHwKhRVXaKVtW/9Xld6gqBf
 yHJAJEafHsGaQIa+m3jbbN+2ZobnAs0UloyQJ6Mks86CoO6nbSrcAvgqcEK6l2Oo
 u4Pacw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1kdc10v0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 22:02:56 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2f525565b33so3279598eec.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 15:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778277776; x=1778882576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fKJH4AVRY0aOrlrR9PNmfX+bmpndXFZiS5gpZRfoK+0=;
 b=ggHGEQfxqaqJaxKyiLnLuaJG+WbQEYjZlMUySlNy9sMK3O+iAmt+qK+8XeJKQvTmi0
 7i6XEXlIOVEZbfpv0Sd/iPse3ZSwebfxpJnOb8zpyMx0SKfQFFYdsS97x4YWv8U4Jdm4
 zjy7KhyleZNKMbaPE8poyYk5l7FQzltKAsLpGG6XZ871PokPVSI4weefuOvW3lhHCwVh
 UQplkGAFdle6MPqTCjdr/XXTYne2QcMQodV/+6aD59Q8wYqnPHqsDjxWplxUV5bGfZ9C
 JbVOVqzRcpd+O17wvjwo4IxB70a38RZLdpUHVo0AM3c2iJIrjrOWsCWGErhUVE+ZLC04
 KeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778277776; x=1778882576;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fKJH4AVRY0aOrlrR9PNmfX+bmpndXFZiS5gpZRfoK+0=;
 b=REtDBxi3yqOLyY7Du3oJ5ZYTqNucQpO8pTw2q3ALXN6CheDJomrZDNySe8OfBlRw3H
 ++HuHk93TVMz82NNG0+L50nPix6hzV/X85s8j/FugquE+6Yc46Z0X35FYPiGmc+EbJT3
 ovNcx2+JPo3/Y4j/4MVkaQGw/xGocyBxv7yuu1UyWpCuvlzemCT+ZSliAbduDljrF0cx
 d9yQwdrwHUZmq6gUTwQ9Vmzw0hzwKOJNZz1503EnPaOQx0DeYL3J8vogmOD+BoPjoqEc
 0TqOWR8OeAlEO8LhVRktKTSzd1tXYSqi5NQ0QH3TUbSuqhDB2wdG0YCMUEOuVJmdoSt4
 gUVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7y7QEUMyscwaZNauHzrKqpWhg8yV0QIQOft/T1a7YXTFPnHn52FCknMAGexZqHzWmdkoeGcAF4gRK@nongnu.org
X-Gm-Message-State: AOJu0YzD3cbSDhvLUOP+NPR2jjmXlVl2AjpP4BBUjGRHftIiO7k80b/j
 0TI1rqeoxlflUEg83urkYIFugCF6Yg7VNx6BKIkblnHtj8pt+MvjbIJjMoRnFTUkfHkz0uafBMp
 Nmn/9R0LaCgWpJNxIM/KI6UcqHSW/0qa79Kejra29swmTh4qAUn6DjuteHg==
X-Gm-Gg: Acq92OERFFrrNoctKn5ehiS5Uk/X2GmW3r6SM9TXnxY9HQfGvjEcqmklJqhzmd/dhp5
 k7y2ZpIeJ3n26RX5PJ3tYt2D7A34/fFYM9l1mcbRWhE8MuPFDmSBgHH/X86oq0Ad878dYuicD9v
 DWT4mY8ga1Sb8wotrOhQixNzF8/p3KRWzo0t4z8trHRWQEtGRsHrH+Awb+aNoF3Z4tMATpiP2uQ
 /atORfMrz4AihUd4GvUZlHA47Cq3kgwkqcqFhiAiWPhDadr95xkyRpP2SC5rwJ0d+ZQXRUzbuj4
 T/pLw26l+Z+I7i3YL/EP3xLTz2IHTJlzRud+pCY3fCS+ZFahYGNspNPmrgEKgxO/9ZqAUx1a+kZ
 5BsAwWuSVeoUNnqDZ08P5Cf4QTTz5J8oto+/rFelptx6bLBg+Pr1UUHXb6ovIDkvg4CXvOqVB1g
 8dLB0JYpgqw+nZh4ec9WXgcEu3
X-Received: by 2002:a05:7300:2146:b0:2e6:e77d:7bcf with SMTP id
 5a478bee46e88-2f54f9442edmr7406031eec.22.1778277775884; 
 Fri, 08 May 2026 15:02:55 -0700 (PDT)
X-Received: by 2002:a05:7300:2146:b0:2e6:e77d:7bcf with SMTP id
 5a478bee46e88-2f54f9442edmr7406004eec.22.1778277775285; 
 Fri, 08 May 2026 15:02:55 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8862d43b4sm3942531eec.11.2026.05.08.15.02.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 15:02:54 -0700 (PDT)
Message-ID: <432ef803-1696-4fa3-b2ef-a284b560b58f@oss.qualcomm.com>
Date: Fri, 8 May 2026 15:02:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] target-info-qom: detect target from QOM
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
 <20260505224826.2698753-6-pierrick.bouvier@oss.qualcomm.com>
 <fd1ff950-1f9c-4097-9bdf-57a7c650c305@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fd1ff950-1f9c-4097-9bdf-57a7c650c305@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDIxOCBTYWx0ZWRfX2HaWHAi2IPNw
 /r99e1r88Hs23KEpY0z7O6pvn+fyhAdBsLRbLdZRkbxHD5Mt1FNH+xEvjIhRGl1kmD/HVIuRIGW
 XvyB6cXhxIH8TTUC1HgHt5kwcZ+L87egMl9OL6KjiqGzsWoFmdVpUbpJsgA9oRF0ojqKSxb6HoS
 sOFNCWMS97KnQLeND2gLCqDHUFFywRcVvDI52uGdNtv24WukkRAWmzqh4i8dqh9uKI/jaOoNAjn
 k2qeGBmzPye5m52wOBGKUGXOglGuyY2RKR935+EVAW/R0KvpSAVf7QAWdxGF0D+6O7t+vrovTFL
 M3UMSvcd4UIou+qzxl1gtG8tp79KRWOS/+TjyfDT2Wg9vE2Q7Cl7i2xvKKUeyEa/VWgcHR0rzUL
 9bYbfQg/u3iBQxv5P9ntMs8k0HukypdfvsnAWo4M3BlxsPqDeGhhV3vRevzMM41mRat89pUIwxH
 tVHS5Pl6FWqcqJQxAYQ==
X-Authority-Analysis: v=2.4 cv=RZOgzVtv c=1 sm=1 tr=0 ts=69fe5d90 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=5TNK94RA4NGO6XG2mAsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: CiCIGu8hWcIdr0kvGRccKfG30BDTj1O3
X-Proofpoint-ORIG-GUID: CiCIGu8hWcIdr0kvGRccKfG30BDTj1O3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080218
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

On 5/8/2026 1:29 PM, Richard Henderson wrote:
> On 5/5/26 17:48, Pierrick Bouvier wrote:
>> For now, we expect only one target to be available at runtime. This will
>> change with the single-binary and we'll detect which one to use
>> dynamically.
>>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   include/qemu/target-info-qom.h |  2 ++
>>   system/vl.c                    |  2 ++
>>   target-info-qom.c              | 16 ++++++++++++++++
>>   3 files changed, 20 insertions(+)
>>
>> diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-
>> info-qom.h
>> index 585995c7ad0..91be415ed33 100644
>> --- a/include/qemu/target-info-qom.h
>> +++ b/include/qemu/target-info-qom.h
>> @@ -25,4 +25,6 @@ typedef struct TargetInfoQomClass {
>>     OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
>>   +void target_info_qom_set_target(void);
>> +
>>   #endif /* QEMU_TARGET_INFO_QOM_H */
>> diff --git a/system/vl.c b/system/vl.c
>> index 2b6739271ba..77b2b4e673d 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -28,6 +28,7 @@
>>   #include "qemu/units.h"
>>   #include "qemu/module.h"
>>   #include "qemu/target-info.h"
>> +#include "qemu/target-info-qom.h"
>>   #include "exec/cpu-common.h"
>>   #include "exec/page-vary.h"
>>   #include "hw/core/qdev-properties.h"
>> @@ -2891,6 +2892,7 @@ void qemu_init(int argc, char **argv)
>>       os_setup_limits();
>>         module_call_init(MODULE_INIT_TARGET_INFO);
>> +    target_info_qom_set_target();
>>         module_init_info(qemu_modinfo);
>>       module_allow_arch(target_name());
>> diff --git a/target-info-qom.c b/target-info-qom.c
>> index ba2c7923760..9d1f50ffcab 100644
>> --- a/target-info-qom.c
>> +++ b/target-info-qom.c
>> @@ -36,3 +36,19 @@ static const TypeInfo target_info_parent_type = {
>>   };
>>     DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
>> +
>> +static const TargetInfo *target_info_ptr;
>> +
>> +void target_info_qom_set_target(void)
>> +{
>> +    g_autoptr(GSList) targets =
>> object_class_get_list(TYPE_TARGET_INFO, false);
>> +
>> +    size_t num_found = g_slist_length(targets);
>> +    if (num_found != 1) {
>> +        error_setg(&error_fatal, num_found == 0 ?
>> +                                 "no target-info is available" :
>> +                                 "more than one target-info is
>> available");
>> +    }
>> +
>> +    target_info_ptr = TARGET_INFO_CLASS(targets->data)->target_info;
>> +}
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> For future improvement, I suggest structuring the code more like page-
> vary-common.c, where exactly one compilation unit sees a non-const
> "TargetInfo target_info", all others see a "const TargetInfo
> target_info", and target_info() the function is eliminated.
> 
> One could even plausibly unify page-vary with target-info, rather than
> duplicating some of the page_bits information between the two structures.
> 
> Most pieces of target_info are really only referenced at startup, but
> target_big_endian() and target_long_bits() are the big exceptions to
> that, and it would be really nice for them not to require an out-of-line
> function call.
>

The only point we are still discussing with Philippe is how we'll model
having several targets, especially at the startup, where we create
machines and types. Once you're in a vcpu thread, things are easier as
there is only one context possible.

It does not mean we can't eliminate the function now, and using indirect
struct access instead, but I think we'll need to have something else to
answer the startup phase. And we don't have a clear answer yet.
 >
> r~

Regards,
Pierrick

