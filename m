Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FEDCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 15:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSzW1-0003L3-Tq; Fri, 29 May 2026 11:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSzVw-0003Jy-Ph
 for qemu-devel@nongnu.org; Fri, 29 May 2026 11:52:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSzVs-0000Oq-BR
 for qemu-devel@nongnu.org; Fri, 29 May 2026 11:52:48 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TDL0nT3568485
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 15:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pVWCoTn53j4cnuaZ6yMVHAvOdUN+nx9XS60hf4WxTOQ=; b=K6ySQ9yxGkMgOMGI
 dnQy8hnxoL5aWg1ZGrxct6o4Ndj7lTilkDstvfe2igtZvA+ZLrO9f42AMJXpuAu9
 1tNjbCXYwk1af/ZoByCnuU2sUsUbIxxua4pmJLbOnRIO8YPYUeCQ0mLYjMtg2DR/
 K4eAIMj6O6ewHYnUrt7U7w1YqNNTfONaqVJffeW3XJlpMEJUOp4NdZpH3IlkyIt2
 WA84NgTSxkJwylNd+gE9kjR8jZH0agjZJQlAum5Bgnj+ZaNH+TiNFhRhwLvZViu8
 rNXdmzqRQAT7nTSRAtYcrXDXfyBddisvknD+qox+1ViJQobRaFNYuTcLXcPgTGwF
 TzgBPQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eevumvbku-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 15:52:26 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3041ab826ddso14657846eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780069945; x=1780674745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pVWCoTn53j4cnuaZ6yMVHAvOdUN+nx9XS60hf4WxTOQ=;
 b=XKXNaMuwozeQQuJDFYkXmC79BkXuQXgseBQc2HOMrsCxfhqWwOJxy1p7ADS1Fsz4X6
 c6peNnbbg89zxK3EiBunfl3mc2Ia7xe/z6RRMzgpANs9VgcH9olI94332wsiF9lu5N/P
 nkQ+ryqtSAJGmeJAZ0GOuvqkvnF08ny47m8cFDgpIMl1O5No9qBqHzCEG63UrzRlSEaP
 7b8++ozadU6M8IL5CEn+ew7ovkQ4+dbJRD+uIh44mS8LSdGcHnAJFszC4xphR08ecCwy
 9cBPFjEGf8Bg0Tto/I8Ml1nBUAjlWu/Djs1hDLRMKsSZaLC0BW28fJ/bCIqaJSWkstE+
 nwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780069945; x=1780674745;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pVWCoTn53j4cnuaZ6yMVHAvOdUN+nx9XS60hf4WxTOQ=;
 b=dJz4XuntOS96H43hpi71TR4GZXPbhIsZ0Hsq1Mwt9Fxy0KwvKmS0TjXKBj3I9NuVJ5
 oeSGJos8QBuAbcXsvz/N2SLM7GRHuC3Qw2aCpS9SftR5gW/lIfgVYs18dydlwZtEGXWa
 JkZwGMSldG/tQDADHcoXuUsWB6lf4jFUUUabFHubjCC6L7r0gt2EO4XK/h/zk65H45J1
 pMsp4I8dnedNPgUttl8s4l1G5i5QvaJ/ubWatLwdguvDRy6ZUmq6vlHpwFP2Pvn07+gW
 C38CJR8+psQxNJQyNFh+cf63fa0VbmZ3FiAbBqbwD5mqwKJtyYFzxoC8xqVwW8hbYHnZ
 UH/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eJ7b/wEG+r3MRf/6Z+cs0aRZCnXKNs30TqDSCqWRPsmI2Y6ftkglCKvfb1p/Tnon1PslZVQQqJqNh@nongnu.org
X-Gm-Message-State: AOJu0YyUuxYA9K/7Zf3w0Ea5iqF64UPBSmJSEEZvtrWZthVtbvcPlWf4
 05pAAuImjIvNCdFXfDGj3NtkhbcMJ2wfYvtDk6kZAf4bLWpkBygRoO1Q3WHfUuymPNvdIc9hhXh
 nl/2yYHo4NdNaTLviokBPFhAmhlTHxehkEGwp0MaseFHqlKZbHZqqPIaXHg==
X-Gm-Gg: Acq92OHV+z3sy4gOJpRigk0bxCs4VVFjo0JyZ3IoMKPXMM8i4K/6uwfE74kgK1glhQj
 dNnw03wvzub10pkOFrQK1QtuATbUg95DHaTByBRLhtbWdteY1xuITAk+qfeQFkSE9WiWiJIzqWe
 QcuX/db9wCDw2LO4JD43+luKgwJBhSi8O4gcJGaOnsnv1RUrP7Q+OtK0kJ39hw/I1aESYVU6NFh
 gHZqkTTBA4HyTLlEchM2nVuXkqhgzKNC+LH6hVVbEtiNR+3r9/eL8nyjViaol8bRdeHnuYlxb86
 lzMOAVQNRRWkKPJTSDRBWlhDn3lkmA5zR7K9c0cNgQMtwTArtWTNVlN8qGLPvtRVX0AZArNFGQY
 Jm792/Kx/dxVH/1CC++wOWq8F7fiu8jJU6hCEu1d69v/7L+YwBbH3PKC1SkwPfUDm+JLXJgR4OI
 SVmtVR7jjjSqqPVKblVV4M+U5W
X-Received: by 2002:a05:7022:307:b0:136:959a:abe9 with SMTP id
 a92af1059eb24-137d3f1850amr115484c88.5.1780069945101; 
 Fri, 29 May 2026 08:52:25 -0700 (PDT)
X-Received: by 2002:a05:7022:307:b0:136:959a:abe9 with SMTP id
 a92af1059eb24-137d3f1850amr115469c88.5.1780069944489; 
 Fri, 29 May 2026 08:52:24 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b2d04287sm1869243c88.0.2026.05.29.08.52.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 08:52:23 -0700 (PDT)
Message-ID: <61a6166a-8950-487d-a4d7-92f92bfc02a9@oss.qualcomm.com>
Date: Fri, 29 May 2026 08:52:22 -0700
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
 <39ce331b-e361-49ae-9954-47e3aaa88948@oss.qualcomm.com>
 <ee503de0-85fb-4220-8069-6a084f164339@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ee503de0-85fb-4220-8069-6a084f164339@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0_HbG8_LIbSc6C9CZFwz6UgZhCRcgq0q
X-Proofpoint-ORIG-GUID: 0_HbG8_LIbSc6C9CZFwz6UgZhCRcgq0q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1OSBTYWx0ZWRfX7n5ZEt7woiJW
 fvc6MfkxVZD5tsrYtxSgwFYGaqEASC1DoiQkcp0ETInqj/kRep6wlt5wMOO9uV/gSsLr/tU0kCd
 eZdu8BQ/BNWVEB2vX3WzZAXnYGKIpvlzo9JBWZkJtWsMPTOY29vRcjhZzS3Zy5nRLIDzQsEZe1e
 zUIDU+YRdDF1vzex0l27L1R3npUpiPB9/qKkX2RpJyce3w3vMqESEgltY1sZd/7haoDEbrxFXdg
 gEojb/h+45n0RNTYBeHjsUIztTtHuHK1x9hF6Z70vgAgZaRYxStiWtnAWcIpHDXM1r4prBh9JxR
 1l/hwoV4aQykXC+39MeUcrbS1vr3yNH7XQPRnrMPTnOVksmnxWw9ciJAzZbXlJ4ES7Ok8lgmKZm
 hXvtfB6SogvLIwYDJRfYh8rfLyN4EZnmesHZvfm19EtNhCgMqOx+tYbtvVIKVSYhIc6svMJOtyy
 vpdH29oDr68U7tgKwzQ==
X-Authority-Analysis: v=2.4 cv=cObQdFeN c=1 sm=1 tr=0 ts=6a19b63a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=QuRxvGadYWfA6dF6RbMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0
 phishscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290159
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

On 5/29/2026 7:37 AM, Philippe Mathieu-Daudé wrote:
> On 28/5/26 22:02, Pierrick Bouvier wrote:
>> On 5/28/2026 12:59 PM, Philippe Mathieu-Daudé wrote:
>>> On 28/5/26 20:47, Pierrick Bouvier wrote:
>>>> On 5/28/2026 11:47 AM, Pierrick Bouvier wrote:
>>>>> On 5/28/2026 7:08 AM, Philippe Mathieu-Daudé wrote:
>>>>>> Initialize the TypeInfo structure at runtime using the TargetInfo
>>>>>> API to resolve TYPE_ACCEL_CPU, replacing CPU_RESOLVING_TYPE by
>>>>>> target_cpu_type(). Since the code is no more target-specific, move
>>>>>> it to accel-common.c, removing the need for accel-target.c.
>>>>>>
>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> ---
>>>>>> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>>>
>>>>>> Pierrick, this is an alternative for both
>>>>>> 20260528051642.115721-4-pierrick.bouvier@oss.qualcomm.com
>>>>>> and
>>>>>> 20260528051642.115721-5-pierrick.bouvier@oss.qualcomm.com
>>>>>> for your "single-binary: fix compilation/execution for {arm,
>>>>>> aarch32, microblaze}" series. WDYT?
>>>>>> ---
>>>>>>    accel/accel-common.c | 15 +++++++++++++++
>>>>>>    accel/accel-target.c | 41
>>>>>> -----------------------------------------
>>>>>>    accel/meson.build    |  1 -
>>>>>>    3 files changed, 15 insertions(+), 42 deletions(-)
>>>>>>    delete mode 100644 accel/accel-target.c
> 
> 
>>>>>> diff --git a/accel/meson.build b/accel/meson.build
>>>>>> index 7da12b9741f..1b5b37e3097 100644
>>>>>> --- a/accel/meson.build
>>>>>> +++ b/accel/meson.build
>>>>>> @@ -1,5 +1,4 @@
>>>>>>    common_ss.add(files('accel-common.c'))
>>>>>> -specific_ss.add(files('accel-target.c'))
>>>>>>    system_ss.add(files('accel-system.c', 'accel-blocker.c', 'accel-
>>>>>> qmp.c', 'accel-irq.c'))
>>>>>>    user_ss.add(files('accel-user.c'))
>>>>>>    
>>>>>
>>>>> I'm open to follow this approach first .
>>>>> The only downside is that it limits to a single accelerator parent
>>>>> type,
>>>>> which will be a problem as soon as we have two arch using this
>>>>> framework
>>>>> for tcg. Nothing we can't solve later though.
>>>
>>> Good point. I'll see how to handle that (as a following up patch).
>>>
>>
>> Maybe we need to duplicate this struct for each base architecture? :)
> 
> Back to your patch? I was never fond of AccelCPUClass and its QOM use,
> ended to ditch it completly:
> https://lore.kernel.org/qemu-devel/20260529142434.87880-1-
> philmd@linaro.org/
> 

Great! I'll take a look.

>>
>>>>>
>>>>> Regards,
>>>>> Pierrick
>>>>
>>>> Forgot :)
>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>
>>
> 


