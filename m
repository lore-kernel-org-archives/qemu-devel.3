Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D4FCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgwe-0005jL-Rc; Thu, 28 May 2026 16:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgwX-0005d7-Po
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:03:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgwU-0004aM-SR
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:03:01 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SGw27C2753284
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 20:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9eyLZNzvGnqhzNDbCHq26YtTKSS9zk5M2Nq45RkpzqI=; b=XIIksFo3RpNpsU42
 WMzh3/ia6jcH9jUdDKIZeT0FpCXny7Fvb+VBhGZoPl+iF3e3BzsOnSxgKp36LfV+
 kLOfmAFtMOBIZgi4QDkdtQ/bAip1UaQqLF0JDSESQ5dbHHUXAEiGu5RQt05bXFLy
 u/2ONK+hw/9sLjnhzjOeB9v9Zczyre9uVdOxQGET9Fm4YxK/o9/RbM0OuJQfy8Am
 TvHm3ybKrTG+vmx1NpOC9cjT448HtqnbEjm9+uiQdzHLUO5526UfEqhkXbQjYnNU
 NEeRcEy27A65jUzdlseuGbGYdtzabVkQ6C9vgF0FAR9nhIC3LoFCZ4tpjXYop6Hn
 q2IabQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eespn0sh2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 20:02:55 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304ba38f45dso2476441eec.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779998575; x=1780603375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9eyLZNzvGnqhzNDbCHq26YtTKSS9zk5M2Nq45RkpzqI=;
 b=VNqP7E4g4A7/0QcOc14a4to85nPRyurd+j8mqTRsRfRXP6dw17+4tTmawvpUMds9yJ
 +jbbQJ0CLzvdcvzz3NndmaJohRPomoeJ0Y/tk0gtAWsiGtYGWr9S0pz/hmMkQTDOXE0S
 gWkbg1ECAddwD6ufcP56O5FixaiQOSaPPZznDOQvR+SoULY2dS+OnoOk2AlxJn3Xkhhc
 +rsq+9gK3FSxO4lTLy1rPzQZ7xSPV6JxqzXR4uAdiH79qcmc4t+eJaqe1daChMLi/krK
 kx2bEVDh7Z6LBhB30qd7g8trnghak6ObaNmUF1XwleWwEV0wYgVr+NgjvrRes/aftHoO
 srcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779998575; x=1780603375;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9eyLZNzvGnqhzNDbCHq26YtTKSS9zk5M2Nq45RkpzqI=;
 b=O48leuXWjRQ934qpHCftnuDGxI97dOR9dGGZvkvPOkuisLGiHWow3tcfA9rcFRabxk
 MlcU0JPx85CNAVIF+JsATQOpqrKHkV7gwxHZqIzbx44KvTTj6cKb93Fz6eMfvAScbb+7
 CW3t11+k8HfoAt7f1CwFSeLRQTta1KYu/pTrFT6QiPN53QmPO3O8TGyYyb2xDhcFb7BH
 bgjp0Cp8X+/SAaxD4Nl7KH8MSu62F5S2hM44p0IBI6TkNx6FGLugI5s5RftGgx/w2hxN
 EaKVFReqCFHJqSQXcHSQW8qpRuM3pCyE0lhMqZSxIIJ1V2D1hm845nDR1EFIxf/AsAcc
 VCNw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9J24cNrU5JsHBVXBqAbPCgtryogwB3dQGqeW+A2/nSMM7R1whhi6A3rXOohRf+RyVCudbGUVkKDFNx@nongnu.org
X-Gm-Message-State: AOJu0YyEl2eqK6LWPnZdh3necn/YVropbOhYAX5ft773LvKdumqj7PnW
 cLUaGCtymBqWOOyJrFt4Aniq46PzRpgaUVZX9aSfh+euk+O/j1l7ocDP0JtAuofZHDZy6LsypkS
 sL54imgQtraQbPiv2WdZB3u6aUqwMwVyZZWbUfjYXTbNzDu/e/rnE2otsYQ==
X-Gm-Gg: Acq92OHq6HkMOnh7X8QNKsESm1TP0z7FBMbGa68unlYZvTjW1X0ECkKJUXQfuGvYdXX
 IBIq2f8vCijHDBVrjGOmF1Il0+QvfmKeuPuglylA40ANHyymP38l6COGwetzVES/WmTVzETnm3i
 HWSKPXzuLbzo02WhsrBN6or6zdLvOMeWNBT3kOuzeTIiwaSoQgPgrJPBfNDQutmun0cmLBYpIc5
 GxBlw87XaVXtERkvVjvHrnNAbNnSGu0hk43C02ecutcRKLvtXLQ2JbI+U4QeBBmp5snm1hEd9xF
 YF+3Hn05f44PtKUuj0eH0EClzbNFDLPUxQ4PoNAFxdRorfSi64N7HhebxhKC97Wvn4EFNn6gIwn
 qb264f4nTjxlhrW8ktZtxw/BuFS/2n1GF0zZZItuJ6XPgNfbPO+oyJj89pZPsDxDcM938m1eVmW
 jyt9TTr7Vik6TviN/ZlewGJ6tl
X-Received: by 2002:a05:7301:4b18:b0:2d9:f0b3:1d98 with SMTP id
 5a478bee46e88-304e8af23a8mr250195eec.7.1779998574554; 
 Thu, 28 May 2026 13:02:54 -0700 (PDT)
X-Received: by 2002:a05:7301:4b18:b0:2d9:f0b3:1d98 with SMTP id
 5a478bee46e88-304e8af23a8mr250170eec.7.1779998573911; 
 Thu, 28 May 2026 13:02:53 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304e98c7975sm169000eec.15.2026.05.28.13.02.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 13:02:53 -0700 (PDT)
Message-ID: <39ce331b-e361-49ae-9954-47e3aaa88948@oss.qualcomm.com>
Date: Thu, 28 May 2026 13:02:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/common: Remove last bit of target-specific code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260528140857.44130-1-philmd@linaro.org>
 <b2a58b62-b061-4bdf-b459-9953b7f373fe@oss.qualcomm.com>
 <5b693f87-2f9a-4564-9efb-83c815bcb20e@oss.qualcomm.com>
 <dc1b9965-4ac3-4157-91e3-edb9d93556cf@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <dc1b9965-4ac3-4157-91e3-edb9d93556cf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NFK7xcmMWqzmh7zGMjqAWQSeQcncF8p6
X-Proofpoint-ORIG-GUID: NFK7xcmMWqzmh7zGMjqAWQSeQcncF8p6
X-Authority-Analysis: v=2.4 cv=auOCzyZV c=1 sm=1 tr=0 ts=6a189f6f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=m4alCSzOIIkxYTHo6xoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDIwMiBTYWx0ZWRfX5/ajgD7wnJ0w
 0AdNIX0FJbq8AN16Gd7jKRMKI9klqHnPVV4ckPUcxCJ7kFY87gGOU9pHeSICDjz1w0FpueEtVn0
 av+OULrWZtRCt19Y8nCrmxHGBxAPiWGse1bA0QZIxPxnodXAwH8RUrK3NSeCBZOejXQS5/h8yey
 sLgFxiypRcvzdQXVEYO+QFdZhIZllKtkgfL7ll7vm3MgQT6lI5v7oijsGzr3mXOega/m5pQ43hv
 AbM7COkzKyP5rRTbZNhtLrAi4ll0G/K4n5MW7SNJktxqG7Z9afsAfE6Ij7wA9lmBwLcpmbVAFrI
 RGfMjUJB84aNbLvHPLTICe9OencEmlmh6WQrfIxiZx3kGl2+tfwNatTx3qzsWMKB4i5zEsoF5tA
 QjHUzMzxKQcZ5Tg7vFaDDER06WTI8B3yEMgQxeghEgBut8b/XvYlFMi9nSBC8jvq5rsvBGyYFzl
 uTZIOYbGzBJ/9tAhf6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280202
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

On 5/28/2026 12:59 PM, Philippe Mathieu-Daudé wrote:
> On 28/5/26 20:47, Pierrick Bouvier wrote:
>> On 5/28/2026 11:47 AM, Pierrick Bouvier wrote:
>>> On 5/28/2026 7:08 AM, Philippe Mathieu-Daudé wrote:
>>>> Initialize the TypeInfo structure at runtime using the TargetInfo
>>>> API to resolve TYPE_ACCEL_CPU, replacing CPU_RESOLVING_TYPE by
>>>> target_cpu_type(). Since the code is no more target-specific, move
>>>> it to accel-common.c, removing the need for accel-target.c.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>
>>>> Pierrick, this is an alternative for both
>>>> 20260528051642.115721-4-pierrick.bouvier@oss.qualcomm.com
>>>> and
>>>> 20260528051642.115721-5-pierrick.bouvier@oss.qualcomm.com
>>>> for your "single-binary: fix compilation/execution for {arm,
>>>> aarch32, microblaze}" series. WDYT?
>>>> ---
>>>>   accel/accel-common.c | 15 +++++++++++++++
>>>>   accel/accel-target.c | 41 -----------------------------------------
>>>>   accel/meson.build    |  1 -
>>>>   3 files changed, 15 insertions(+), 42 deletions(-)
>>>>   delete mode 100644 accel/accel-target.c
>>>>
>>>> diff --git a/accel/accel-common.c b/accel/accel-common.c
>>>> index 9c5b4111c8d..62590a7d9a6 100644
>>>> --- a/accel/accel-common.c
>>>> +++ b/accel/accel-common.c
>>>> @@ -134,3 +134,18 @@ static const TypeInfo accel_types[] = {
>>>>   };
>>>>     DEFINE_TYPES(accel_types)
>>>> +
>>>> +static void register_accel_target_type(void)
>>>> +{
>>>> +    g_autofree char *name = g_strconcat("accel-",
>>>> target_cpu_type(), NULL);
>>>> +    const TypeInfo accel_cpu_type = {
>>>> +        .name = name,
>>>> +        .parent = TYPE_OBJECT,
>>>> +        .abstract = true,
>>>> +        .class_size = sizeof(AccelCPUClass),
>>>> +    };
>>>> +
>>>> +    type_register_static(&accel_cpu_type);
>>>> +}
>>>> +
>>>> +type_init(register_accel_target_type);
>>>> diff --git a/accel/accel-target.c b/accel/accel-target.c
>>>> deleted file mode 100644
>>>> index 7fd392fbc4a..00000000000
>>>> --- a/accel/accel-target.c
>>>> +++ /dev/null
>>>> @@ -1,41 +0,0 @@
>>>> -/*
>>>> - * QEMU accel class, components common to system emulation and user
>>>> mode
>>>> - *
>>>> - * Copyright (c) 2003-2008 Fabrice Bellard
>>>> - * Copyright (c) 2014 Red Hat Inc.
>>>> - *
>>>> - * Permission is hereby granted, free of charge, to any person
>>>> obtaining a copy
>>>> - * of this software and associated documentation files (the
>>>> "Software"), to deal
>>>> - * in the Software without restriction, including without
>>>> limitation the rights
>>>> - * to use, copy, modify, merge, publish, distribute, sublicense,
>>>> and/or sell
>>>> - * copies of the Software, and to permit persons to whom the
>>>> Software is
>>>> - * furnished to do so, subject to the following conditions:
>>>> - *
>>>> - * The above copyright notice and this permission notice shall be
>>>> included in
>>>> - * all copies or substantial portions of the Software.
>>>> - *
>>>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>>> EXPRESS OR
>>>> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>>> MERCHANTABILITY,
>>>> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
>>>> EVENT SHALL
>>>> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
>>>> DAMAGES OR OTHER
>>>> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>>>> ARISING FROM,
>>>> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>>>> DEALINGS IN
>>>> - * THE SOFTWARE.
>>>> - */
>>>> -
>>>> -#include "qemu/osdep.h"
>>>> -#include "accel/accel-cpu-target.h"
>>>> -
>>>> -static const TypeInfo accel_cpu_type = {
>>>> -    .name = TYPE_ACCEL_CPU,
>>>> -    .parent = TYPE_OBJECT,
>>>> -    .abstract = true,
>>>> -    .class_size = sizeof(AccelCPUClass),
>>>> -};
>>>> -
>>>> -static void register_accel_types(void)
>>>> -{
>>>> -    type_register_static(&accel_cpu_type);
>>>> -}
>>>> -
>>>> -type_init(register_accel_types);
>>>> diff --git a/accel/meson.build b/accel/meson.build
>>>> index 7da12b9741f..1b5b37e3097 100644
>>>> --- a/accel/meson.build
>>>> +++ b/accel/meson.build
>>>> @@ -1,5 +1,4 @@
>>>>   common_ss.add(files('accel-common.c'))
>>>> -specific_ss.add(files('accel-target.c'))
>>>>   system_ss.add(files('accel-system.c', 'accel-blocker.c', 'accel-
>>>> qmp.c', 'accel-irq.c'))
>>>>   user_ss.add(files('accel-user.c'))
>>>>   
>>>
>>> I'm open to follow this approach first .
>>> The only downside is that it limits to a single accelerator parent type,
>>> which will be a problem as soon as we have two arch using this framework
>>> for tcg. Nothing we can't solve later though.
> 
> Good point. I'll see how to handle that (as a following up patch).
>

Maybe we need to duplicate this struct for each base architecture? :)

>>>
>>> Regards,
>>> Pierrick
>>
>> Forgot :)
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 


