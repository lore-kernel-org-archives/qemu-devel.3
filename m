Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F56CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 18:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSfm3-00043o-9W; Thu, 28 May 2026 14:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSflw-00043Z-2Q
 for qemu-devel@nongnu.org; Thu, 28 May 2026 14:48:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSflu-0001GI-60
 for qemu-devel@nongnu.org; Thu, 28 May 2026 14:47:59 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SGTc6a1562684
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 18:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fHYyPC5hXcmgadmeMqBIC22DtfW5v1Yz2HiTeZEMcR0=; b=c9hicPcHzVim9c+v
 HAUx703brakiw6fskSjLUtfY/xUsMdba8vGPhJED/DZonq3oTr8ix8Kq7wd3eY1M
 s0TN79Uvp1kjuKO2MHTAlOgbKMaSDqXHjKSb4zJnBz1b8QNDAZTPnUa3QbJZt6wJ
 LI9rsmOa9m4AGJO9OGXQYI6iYPn7g3S2UHMjoCzOdxhD0PVw3AlnCM7M3B0ouAmY
 1mSwmee5xcNX4GIBKUcZK9hA64psmI9hxwxdsvcpzzNrbIicAV/ZKBa/1a9SdXFr
 DJVduIUdZNlrZeiubkuVBCiONbznapCP9XyYnhPiYpWdBhpAtMtMk3yFsfWPBqb4
 prfzPg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y2v7w6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 18:47:56 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304bbf2423cso2492349eec.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 11:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779994076; x=1780598876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fHYyPC5hXcmgadmeMqBIC22DtfW5v1Yz2HiTeZEMcR0=;
 b=gNPi+gGHE8v1rcWewyMFkb2udaj83wWbAXzSCKKvAstdlv6SggTpnD9/IE3tap8idh
 x+Mvk+PNa72mEYPoqD7lVRl6JfkyccOCVO+jaq7kW9sWIlUICy4cet1vyJb74qnn/BvK
 kROssRkJfG2j/OTB/d4ND/NS/QE8+FmRQONjYSVHtPo2LyP1bOMKEpkur4ObeGAAkG2O
 ZR/zxNtZ6nxv4VWX37lAz1UfSpoFQCJFPG47IQJ6yFfQPRkmCX2jcFSmHuOIIKzlHsrN
 yX53PL4KzCNxmPbRt5s6J0mju7oZAP6kRnp8SRVwLMzCvxHMLjsNoyRiu0KjVXsbaapB
 xfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779994076; x=1780598876;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fHYyPC5hXcmgadmeMqBIC22DtfW5v1Yz2HiTeZEMcR0=;
 b=GaDcQhDS9F/qmHtkhnOEtRnpV4kDlnJe4jgo0zpST7GX7tbxNX+2TBhjJ8km9S08h7
 4FK5jcT5QoUnBy0phriSAWCUuMpFxPRNTtxflzK7f09sKLi0MJmS/dUmYSHpBl7gKI7A
 OJRmCBldtP1DlwQhU+2vwi5/kdW6qNGx82Ccpnt/FDfn5SEjmd9wHP0EKmqH6hCv9W+e
 8LgesJAzc21hSrHfxnbBUQt7uWgxEVCub7FP/mrJRWU8EmyhRrlNZZgGpMVJrTsnJNN0
 ii+vxfH8Nuz0gmqIfdte5qytLYmCNWSCuilkSHbnkylnyq8HmDfgwh5kBBBZUNdJc2Ao
 noJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jI5/9ygE0N8QcfMZBKIlQI/GsZ3/PdWEudC6Q7AiNP4A4Qy2/lt8aoTVjO5uKpqq+awDU0ycgs4QS@nongnu.org
X-Gm-Message-State: AOJu0Yzc2iI5ANdNIMdyTp9G1HMinDSdlOHIu6vlTzHziq/BThIsI1WV
 s7nBQ0kypROfRTFtglnK0IDnbZoyb1sCVbQrgWTRhiGRkbeFABlMEIo/Ua5CB7309gcKLMtMP48
 pr+N4sxyMFg4gvHoCGa1G97Cupqjm6GUVzIxExjSl7u5yuxMUnwbL9nijLw==
X-Gm-Gg: Acq92OES8ygpOBCi3EEynLaExXQhkGujYK9La3wtAtKEMQFQQBfN6GavAMp4JzC5uVp
 K92ALdiJWi/WoYAg2fwB2rEqqdbwHo4DxIPMU5jSHTqoXXNR2RkrPNAvKVBcQvYRrUi69UMIW23
 97reWIY7S+LRuNTmfC74+cdy8tLSRg6QL2lEWNo2ZS9skaOU6nEEajJGnRKqNBtZ8Ohpl0xFFed
 D9CRB4l2YME9QYk2I5igUAmC9js2MW/4GkozBOOak/Nmu7OC5hbeN2/GN0s5c0+tRMH7UCFEU2B
 O9Gv2NKHV+kUk2J0u2B0HaMTksTouPZ/jbebv9U2XVVCZy0JR4Umf/DdqPyV3T5q7U72mYQQn67
 NYcY6zY+gfh+t05MVen0NswMIsNptNoKO5SA7zNKdGKxha1FTPsokkCKZnpXgNZTU4CMrjZF8rU
 GFuKC6GnVvP9f5LK8l74mBv0/0
X-Received: by 2002:a05:7022:419c:b0:136:fac0:84da with SMTP id
 a92af1059eb24-137a8c08239mr83807c88.35.1779994076294; 
 Thu, 28 May 2026 11:47:56 -0700 (PDT)
X-Received: by 2002:a05:7022:419c:b0:136:fac0:84da with SMTP id
 a92af1059eb24-137a8c08239mr83783c88.35.1779994075631; 
 Thu, 28 May 2026 11:47:55 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137a948b649sm87493c88.2.2026.05.28.11.47.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 11:47:55 -0700 (PDT)
Message-ID: <5b693f87-2f9a-4564-9efb-83c815bcb20e@oss.qualcomm.com>
Date: Thu, 28 May 2026 11:47:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/common: Remove last bit of target-specific code
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260528140857.44130-1-philmd@linaro.org>
 <b2a58b62-b061-4bdf-b459-9953b7f373fe@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b2a58b62-b061-4bdf-b459-9953b7f373fe@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VeXH+lp9 c=1 sm=1 tr=0 ts=6a188ddd cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=QaID0Q7b5USOubk93yUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE4OSBTYWx0ZWRfXwkGiduJQjget
 3z+SWK6o8rK7eS/aspmYR+uv1I/5hO0YQojMH4mXRUlvJ07Bk0ocibGxgjUZ8Z4ZV+IVWy9qZGq
 1pSKmE6Vgm1haNXxKnLlLgNCYOvnj7Tfv2OEj3c4I1q+GUEwoldi8Xg4sKTbUcrJkHMmtytjiGx
 vMKhT5GE/YdMJS+xIQOMcA1eYulNRtWY3IQo7Xuy5xtgjgy/e+fOnF7vdFfa4NiIyt94764IsiH
 jRWDnei/ngz5G3dljEc2tXUvxiwi3ei1O7EXJylbQJ/R/pGY2NK+OqaBABi+RWsJpKaHcxX+GL6
 Yn4xmFsNEuHXnJQbLbXsDoLti9SYwEbo7oz+As0VgKqzmZrIRV8dnfIu21yuE199SVicpKnoEc/
 1kE0LdzBuzja5X3ZJaV/UHF/S5bgQw==
X-Proofpoint-GUID: aJ__HFinuHMUSjm8e1RTMKnFnmaOnytp
X-Proofpoint-ORIG-GUID: aJ__HFinuHMUSjm8e1RTMKnFnmaOnytp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605210000 definitions=main-2605280189
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

On 5/28/2026 11:47 AM, Pierrick Bouvier wrote:
> On 5/28/2026 7:08 AM, Philippe Mathieu-Daudé wrote:
>> Initialize the TypeInfo structure at runtime using the TargetInfo
>> API to resolve TYPE_ACCEL_CPU, replacing CPU_RESOLVING_TYPE by
>> target_cpu_type(). Since the code is no more target-specific, move
>> it to accel-common.c, removing the need for accel-target.c.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>
>> Pierrick, this is an alternative for both
>> 20260528051642.115721-4-pierrick.bouvier@oss.qualcomm.com
>> and
>> 20260528051642.115721-5-pierrick.bouvier@oss.qualcomm.com
>> for your "single-binary: fix compilation/execution for {arm,
>> aarch32, microblaze}" series. WDYT?
>> ---
>>  accel/accel-common.c | 15 +++++++++++++++
>>  accel/accel-target.c | 41 -----------------------------------------
>>  accel/meson.build    |  1 -
>>  3 files changed, 15 insertions(+), 42 deletions(-)
>>  delete mode 100644 accel/accel-target.c
>>
>> diff --git a/accel/accel-common.c b/accel/accel-common.c
>> index 9c5b4111c8d..62590a7d9a6 100644
>> --- a/accel/accel-common.c
>> +++ b/accel/accel-common.c
>> @@ -134,3 +134,18 @@ static const TypeInfo accel_types[] = {
>>  };
>>  
>>  DEFINE_TYPES(accel_types)
>> +
>> +static void register_accel_target_type(void)
>> +{
>> +    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
>> +    const TypeInfo accel_cpu_type = {
>> +        .name = name,
>> +        .parent = TYPE_OBJECT,
>> +        .abstract = true,
>> +        .class_size = sizeof(AccelCPUClass),
>> +    };
>> +
>> +    type_register_static(&accel_cpu_type);
>> +}
>> +
>> +type_init(register_accel_target_type);
>> diff --git a/accel/accel-target.c b/accel/accel-target.c
>> deleted file mode 100644
>> index 7fd392fbc4a..00000000000
>> --- a/accel/accel-target.c
>> +++ /dev/null
>> @@ -1,41 +0,0 @@
>> -/*
>> - * QEMU accel class, components common to system emulation and user mode
>> - *
>> - * Copyright (c) 2003-2008 Fabrice Bellard
>> - * Copyright (c) 2014 Red Hat Inc.
>> - *
>> - * Permission is hereby granted, free of charge, to any person obtaining a copy
>> - * of this software and associated documentation files (the "Software"), to deal
>> - * in the Software without restriction, including without limitation the rights
>> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>> - * copies of the Software, and to permit persons to whom the Software is
>> - * furnished to do so, subject to the following conditions:
>> - *
>> - * The above copyright notice and this permission notice shall be included in
>> - * all copies or substantial portions of the Software.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>> - * THE SOFTWARE.
>> - */
>> -
>> -#include "qemu/osdep.h"
>> -#include "accel/accel-cpu-target.h"
>> -
>> -static const TypeInfo accel_cpu_type = {
>> -    .name = TYPE_ACCEL_CPU,
>> -    .parent = TYPE_OBJECT,
>> -    .abstract = true,
>> -    .class_size = sizeof(AccelCPUClass),
>> -};
>> -
>> -static void register_accel_types(void)
>> -{
>> -    type_register_static(&accel_cpu_type);
>> -}
>> -
>> -type_init(register_accel_types);
>> diff --git a/accel/meson.build b/accel/meson.build
>> index 7da12b9741f..1b5b37e3097 100644
>> --- a/accel/meson.build
>> +++ b/accel/meson.build
>> @@ -1,5 +1,4 @@
>>  common_ss.add(files('accel-common.c'))
>> -specific_ss.add(files('accel-target.c'))
>>  system_ss.add(files('accel-system.c', 'accel-blocker.c', 'accel-qmp.c', 'accel-irq.c'))
>>  user_ss.add(files('accel-user.c'))
>>  
> 
> I'm open to follow this approach first .
> The only downside is that it limits to a single accelerator parent type,
> which will be a problem as soon as we have two arch using this framework
> for tcg. Nothing we can't solve later though.
> 
> Regards,
> Pierrick

Forgot :)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

