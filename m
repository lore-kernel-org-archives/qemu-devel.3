Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A1CCD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVBi-0002wJ-UT; Mon, 11 May 2026 14:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMVBZ-0002tE-UJ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:17:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMVBU-00085M-Bu
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:16:54 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BHUtOt3051348
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 18:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Wubr0Dg1Z9sA7ptm1coQGqdB
 67NVzvwdqO4t0o01Tho=; b=PA4rc+LewEcwOIySBu45JhKyxgLvkUoqsGqg6DK1
 i3qsy16sAUV0qjgPz0IdMeQAzy2ja/+FeHXumbJFZmZvf4zXZi9f0wafSfpqkkHG
 hHTlFfHZn6szuwdIsmCGGRYYKozq/o+xTQ59UO4bpWyyRgQZq5HqGm5Mt/V9cbVk
 rsro2ErbStlGePNvsMj83zX62B8uPZS1ww3GX8IA1XNnvRuDsjEzzucbdNzqhcwc
 L3WxSpl/XSwcRx0hw9HqzeuQfmBiI90uaACMY1ZSxINST0BxZixiFHhXLUHRZNWx
 sinjDWXlctTs+GoY2B3s4i4xMdyZu0ZpjGnaTa9jdYxsVQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3kjwg656-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 18:16:48 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-132d631edaaso8215745c88.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778523408; x=1779128208; darn=nongnu.org;
 h=in-reply-to:content-language:references:to:from:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Wubr0Dg1Z9sA7ptm1coQGqdB67NVzvwdqO4t0o01Tho=;
 b=WEPCRVLnEfNWwr6YYPXu32zwrTOQzrNuP8jltRrPtX3OFkdRGPNAu9JQIcKXizI4CB
 n3DtdZVeNpmFyLRjm2W5CLyEUMWV6i4JeS1JeGLTZV0iGRtfauj8TlRM4oDM0QZQ/hvj
 hCzPiQHFNK2fjWLj4mvy69BwbXnhhHG9t0NeH9HkHNbniD71hJHzFhinTfDlPFJCYd/W
 xJbHAj/B+nUO5hCKL8iAU3Nm8tp4oBcfto71ERhGYgod3f86CLNmExoOeaSw7DD+FNgm
 5ACC0qhNDC8N73JDJjKAJf6r/PONX5Fgz26Gh8DL6OV9tW4mwr9dWUQk9+ESdt3PMV+V
 cUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523408; x=1779128208;
 h=in-reply-to:content-language:references:to:from:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wubr0Dg1Z9sA7ptm1coQGqdB67NVzvwdqO4t0o01Tho=;
 b=mswKOhqBaHvfg1SD4+N44bvG/fQDx/R8G5i546+vh/m/AbNSVJ1axBZ8v7wtX8pTJP
 Yxfx1wDVktey4hZFhbsucoO3cRIrYRT9TL34wHqRR/YGEbJu5ILZBaCN6qSaJc7c1zIk
 Xaib8gok+zzFAG+AFHsZO5AJFg+T//FocZOxY4D6SLf0IejbnEcgkIVTVWeiUo3+jEgf
 HlmKpQhlwBSRTxXOV78nzrWfCeXJvMnKauDDECK4AoQeYf26EL0OOyzZQriGKe+8gVlV
 E+BGWHVaRPlkNK3pPArIxFGzaJ2Xp0JjY+Cg0r137QHhoQVULKfhE/XC7g3BNsLfDo66
 YocA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Inwx4VXEei1Jo2hhzC6/Fmi12CjzYqV3wZtaI+LplMiFHGZLs1Ex68H2rFRE+MhfeVNuatP0JW8ri@nongnu.org
X-Gm-Message-State: AOJu0YzIrKxRxvpwDt1w+rvYiFxySd4W5ND8lKaQPaTZvCqvllxxWuB2
 hgnq0LwHN1mHqd5xBOpuvEG3HkZH2ReXS+w2PvAsMDy3v2BBXYW16B1NGgC2fUdROUb0/tOAaPk
 z3ybY6O4vbun4wGXKo49uxZWQHi+LILHVNKU79p84dcxx+WBkWiF1RKrXtQ==
X-Gm-Gg: Acq92OGQ4IWFC9POBLVkqG+Qq736lTKp9Enyom+xm41mYlWGu6kma30hWU9fC3FnN7L
 D8ajFzpDZPpuFNJ/XZiRG41hvtIKUSpv9AtGLHdNFKbO6C2LwhVsQv6mW94ib6DQc1yRAJ/xZPD
 TJWUrLhTYjT3tvfNSgSv+2qOn5UZ6iioJuhwSFStpQaLHaBY27pTV+uSHhJPHz0+FPgnifG7EnD
 0hpbNZM6btYNUhRce+ei0ZOeoySDuWt2YMnKrzPn2z8CO9rOYQSl3p45Ae94o9F/5r5mHJIwQ6M
 x5Un1Xj8flJTLg3Cua4Jet0w3r8Jm02+KU2Am/DN5XaLzyt088V2ykzqs0YKl2mGM9xAXjz/z9k
 K9bbmHZkP4kGV9z/nM/xZ9I7xiHsU0+JEPeSzfChIDryLx1W9PnKKVfQoAZPvh3DvMy8fvkkQs7
 FbBkzsg7BrtRczgg==
X-Received: by 2002:a05:7022:2225:b0:12d:b205:c737 with SMTP id
 a92af1059eb24-132a7af0230mr5785290c88.17.1778523407408; 
 Mon, 11 May 2026 11:16:47 -0700 (PDT)
X-Received: by 2002:a05:7022:2225:b0:12d:b205:c737 with SMTP id
 a92af1059eb24-132a7af0230mr5785257c88.17.1778523406732; 
 Mon, 11 May 2026 11:16:46 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13278210ff2sm15772929c88.6.2026.05.11.11.16.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 11:16:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------JjbntBI0tKRC4Tm0fMwfX0JW"
Message-ID: <4d0a80a8-396d-4ce5-ae8c-ec5581f5e90f@oss.qualcomm.com>
Date: Mon, 11 May 2026 11:16:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 089/110] target/s390x: Introduce common system/user meson
 source set
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
References: <20260506135524.20617-1-philmd@linaro.org>
 <20260506135524.20617-90-philmd@linaro.org>
 <5b1fd1f6-00ec-4575-9609-845218405403@redhat.com>
 <90ea3dacb27252a623c0f95bad334e4702222d83.camel@linux.ibm.com>
 <40f3f863-04fe-4eb5-9672-a21ae4fca950@redhat.com>
 <3b5ff524-75d6-41d0-949d-39bbff0558bb@linaro.org>
 <2a4981de-da3f-44a9-b422-3ba9c24b7dab@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2a4981de-da3f-44a9-b422-3ba9c24b7dab@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: pF4BZRTbbp2upSt8feJDY4MzojHt-4b7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE5NSBTYWx0ZWRfXwQy/OqFL1zJH
 qlw5Kebq4iR2ZU/3tiF315XZ1erseifYbWyfBvhsV+UblOlCJgjdJHlz5Y7qEgzJDw7YKHQt/gy
 jcTEWKymXGpgffqYw28n0FxFDZWSlySkuB9nOAfDGOxu1wHi3PYnF3LWNvcRxhYSzYes2OPiV2i
 4deU4W+J+XoYFJvaxaWkHnBrrboOD7ocY5LJEoSrZ0jUwGYg8s+YQHeH9h7ZoFml/u28LD6W2jx
 DlYQMaNmmqxb2F++29Ur5msM591k4BAkElz/QYDjbr3FCx1t+y4NVKS7rn6uSHplYe6Zct4qft1
 BfEzonnRuRA3iwzSb/ZGjDF85oOiVkd6UYuR+k7oos6fcVMDoBWYqdtlDspBYKCWDIvmO7yywlS
 1ekn8fR0lCWMe0G2/pB+EjogeD8i0RjnIqg75qYq5wO0QtPihYWO8I7ARSrSaYGW3eijSYmKejD
 QHheHQsgNBTqTWEGqYw==
X-Proofpoint-GUID: pF4BZRTbbp2upSt8feJDY4MzojHt-4b7
X-Authority-Analysis: v=2.4 cv=MKRQXsZl c=1 sm=1 tr=0 ts=6a021d10 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=PxyEoLZricNkxfrdmg8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a6BCqF6zBHvFJxF2HW8A:9 a=B2y7HmGcmWMA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110195
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

This is a multi-part message in MIME format.
--------------JjbntBI0tKRC4Tm0fMwfX0JW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/11/2026 11:01 AM, Pierrick Bouvier wrote:
> On 5/11/2026 10:47 AM, Philippe Mathieu-Daudé wrote:
>> On 11/5/26 18:36, Cédric Le Goater wrote:
>>> On 5/11/26 17:58, Eric Farman wrote:
>>>> On Mon, 2026-05-11 at 17:48 +0200, Cédric Le Goater wrote:
>>>>> Hello,
>>>>>
>>>>> On 5/6/26 15:55, Philippe Mathieu-Daudé wrote:
>>>>>> Introduce a source set common to system / user. Start it
>>>>>> with the files built in both sets: 'cpu_models_user.c'
>>>>>> and 'gdbstub.c' No logical change intended.
>>>>>>
>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>>>> Message-Id: <20260423135035.50126-4-philmd@linaro.org>
>>>>>
>>>>> This change introduced a regression with PCI passthrough which
>>>>> stopped working. Guest kernel reports :
>>>>>
>>>>>     [    0.156501] zpci: PCI is not supported because CPU facilities
>>>>> 69 or 71 are not available
>>>>>
>>>>> and other devices (ap, ccw) are impacted too I think.
>>>>>
>>>>>> ---
>>>>>>    target/s390x/meson.build | 25 +++++++++++++------------
>>>>>>    1 file changed, 13 insertions(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/target/s390x/meson.build b/target/s390x/meson.build
>>>>>> index 6f98ce34d73..44f58ac2919 100644
>>>>>> --- a/target/s390x/meson.build
>>>>>> +++ b/target/s390x/meson.build
>>>>>> @@ -1,4 +1,9 @@
>>>>>>    s390x_ss = ss.source_set()
>>>>>> +s390x_common_ss = ss.source_set()
>>>>>> +s390x_common_system_ss = ss.source_set()
>>>>>> +s390x_system_ss = ss.source_set()
>>>>>> +s390x_user_ss = ss.source_set()
>>>>>> +
>>>>>>    s390x_ss.add(files(
>>>>>>      'cpu.c',
>>>>>>      'cpu_features.c',
>>>>>> @@ -15,15 +20,16 @@ gen_features_h = custom_target('gen-features.h',
>>>>>>                                   capture: true,
>>>>>>                                   command: gen_features)
>>>>>> -s390x_ss.add(gen_features_h)
>>>>>> +s390x_common_ss.add(gen_features_h)
>>>>>> +s390x_common_ss.add(files(
>>>>>> +  'cpu_models_user.c',
>>>>>> +  'gdbstub.c',
>>>>>> +))
>>>>>> -s390x_system_ss = ss.source_set()
>>>>>>    s390x_system_ss.add(files(
>>>>>>      'ioinst.c',
>>>>>>    ))
>>>>>> -s390x_common_system_ss = ss.source_set()
>>>>>> -s390x_common_system_ss.add(gen_features_h)
>>>>>>    s390x_common_system_ss.add(files(
>>>>>>      'helper.c',
>>>>>>      'arch_dump.c',
>>>>>> @@ -32,19 +38,14 @@ s390x_common_system_ss.add(files(
>>>>>>      'mmu_helper.c',
>>>>>>      'sigp.c',
>>>>>>      'cpu-system.c',
>>>>>> -  'cpu_models_system.c',
>>>>>
>>>>> This file is compiled anymore and the CPU features and facilities are
>>>>> not propagated to the guest anymore.
>>>>>
>>>>> Without this patch, cpuinfo reports :
>>>>>
>>>>>     features    : esan3 zarch stfle msa ldisp eimm dfp edat etf3eh
>>>>> highgprs te vx vxd vxe gs vxe2 vxp sort dflt vxp2 nnpa
>>>>>     facilities      : 0 1 2 3 4 6 7 8 9 10 11 12 13 14 15 16 17 18
>>>>> 19 20 21 22 23 24 25 26 27 28 30 31 32 33 34 35 36 37 38 40 41 42 43
>>>>> 44 45 47 48 49 50 51 52 53 54 57 58 59 60 61 64 65 69 71 72 73 74 75
>>>>> 76 77 78 80 81 82 129 130 131 133 134 135 138 139 140 146 147 148
>>>>> 150 151 152 155 156 165 192 193 194 196 197
>>>>>
>>>>> with :
>>>>>
>>>>>     features    : esan3 zarch stfle msa ldisp eimm dfp edat etf3eh
>>>>> highgprs te vx vxd vxe gs vxe2 vxp sort dflt vxp2
>>>>>     acilities      : 0 1 2 3 4 6 7 8 9 10 11 13 14 16 17 18 19 20 21
>>>>> 22 23 24 25 26 27 28 30 31 32 33 34 35 36 37 38 40 41 42 43 44 45 46
>>>>> 47 48 49 50 51 52 53 54 55 57 58 59 60 61 64 72 73 74 75 76 77 78 80
>>>>> 81 82 129 130 131 133 134 135 138 139 146 147 148 150 151 152 155 192
>>>>>
>>>>
>>>> Thanks, Cedric... I wonder if the above is addressed by this patch?
>>>> (I haven't checked yet, but will
>>>> do that now.)
>>>>
>>>> https://lore.kernel.org/qemu-devel/20260510204640.2178926-1-
>>>> marcandre.lureau@redhat.com/
>>>
>>> Something like below seems to work.
>>>
>>> C.
>>>
>>>
>>> @@ -22,7 +22,6 @@ gen_features_h = custom_target('gen-feat
>>>
>>>   s390x_common_ss.add(gen_features_h)
>>>   s390x_common_ss.add(files(
>>> -  'cpu_models_user.c',
>>>     'gdbstub.c',
>>>   ))
>>>
>>> @@ -38,8 +37,11 @@ s390x_common_system_ss.add(files(
>>>     'mmu_helper.c',
>>>     'sigp.c',
>>>     'cpu-system.c',
>>> +  'cpu_models_system.c',
>>>   ))
>>>
>>> +s390x_user_ss.add(files('cpu_models_user.c'))
>>> +
>>>   subdir('tcg')
>>>   subdir('kvm')
>>
>> Right. I wonder how I could screw that change...
>>
>>
> 
> The only possible thing is that code becoming common skipped some ifdef
> that were here before per target.
> So, something that should have been poisoned has not been, and we
> definitely need to identify what it is to prevent other regressions like
> this.
> 
> Regards,
> Pierrick

Fortunately, it was a much simpler bug, where we incorrectly removed
cpu_models_system.c completely, and used user stubs for all versions.

Attached patch should fix it. Can you please test and confirm?

Regards,
Pierrick
--------------JjbntBI0tKRC4Tm0fMwfX0JW
Content-Type: text/plain; charset=UTF-8;
 name="0001-target-s390x-fix-cpu_models-build-between-user-syste.patch"
Content-Disposition: attachment;
 filename*0="0001-target-s390x-fix-cpu_models-build-between-user-syste.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3OTIxYjUzNGRlMGQxMDYzNGUzZGZmMTVmOWY1ZjIxNjNkODJjNzI5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQG9zcy5xdWFsY29tbS5jb20+CkRhdGU6IE1vbiwgMTEgTWF5IDIwMjYgMTE6MDg6Mzgg
LTA3MDAKU3ViamVjdDogW1BBVENIXSB0YXJnZXQvczM5MHg6IGZpeCBjcHVfbW9kZWxzIGJ1
aWxkIGJldHdlZW4gdXNlci9zeXN0ZW0KCkEgcmVjZW50IGNvbW1pdCBpbmNvcnJlY3RseSBy
ZXBsYWNlZCBjcHVfbW9kZWxzX3N5c3RlbSBieSBzdHVicwpjcHVfbW9kZWxzX3VzZXIsIHRo
dXMgYnJlYWtpbmcgUENJIHBhc3N0aHJvdWdoIG9uIHMzOTAuCkZpeCBpdCBieSBjb3JyZWN0
bHkgdXNpbmcgc3lzdGVtL3VzZXIgdmVyc2lvbiBhcyBpdCB3YXMgZG9uZSBiZWZvcmUuCgpG
aXhlczogMGI4M2FjZjJmMDU2Y2M3ZjVhOWIwNWIxYWY5Yzk3YzkxZTJhN2IxZSAoInRhcmdl
dC9zMzkweDogSW50cm9kdWNlIGNvbW1vbiBzeXN0ZW0vdXNlciBtZXNvbiBzb3VyY2Ugc2V0
IikKU2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBv
c3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9zMzkweC9tZXNvbi5idWlsZCB8IDQgKysr
LQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9zMzkweC9tZXNvbi5idWlsZCBiL3RhcmdldC9zMzkweC9tZXNv
bi5idWlsZAppbmRleCA0NGY1OGFjMjkxOS4uMzE2Y2RiOTU0ZjggMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9zMzkweC9tZXNvbi5idWlsZAorKysgYi90YXJnZXQvczM5MHgvbWVzb24uYnVpbGQK
QEAgLTIyLDcgKzIyLDYgQEAgZ2VuX2ZlYXR1cmVzX2ggPSBjdXN0b21fdGFyZ2V0KCdnZW4t
ZmVhdHVyZXMuaCcsCiAKIHMzOTB4X2NvbW1vbl9zcy5hZGQoZ2VuX2ZlYXR1cmVzX2gpCiBz
MzkweF9jb21tb25fc3MuYWRkKGZpbGVzKAotICAnY3B1X21vZGVsc191c2VyLmMnLAogICAn
Z2Ric3R1Yi5jJywKICkpCiAKQEAgLTMwLDYgKzI5LDggQEAgczM5MHhfc3lzdGVtX3NzLmFk
ZChmaWxlcygKICAgJ2lvaW5zdC5jJywKICkpCiAKK3MzOTB4X3VzZXJfc3MuYWRkKGZpbGVz
KCdjcHVfbW9kZWxzX3VzZXIuYycpKQorCiBzMzkweF9jb21tb25fc3lzdGVtX3NzLmFkZChm
aWxlcygKICAgJ2hlbHBlci5jJywKICAgJ2FyY2hfZHVtcC5jJywKQEAgLTM4LDYgKzM5LDcg
QEAgczM5MHhfY29tbW9uX3N5c3RlbV9zcy5hZGQoZmlsZXMoCiAgICdtbXVfaGVscGVyLmMn
LAogICAnc2lncC5jJywKICAgJ2NwdS1zeXN0ZW0uYycsCisgICdjcHVfbW9kZWxzX3N5c3Rl
bS5jJywKICkpCiAKIHN1YmRpcigndGNnJykKLS0gCjIuNDMuMAoK

--------------JjbntBI0tKRC4Tm0fMwfX0JW--

