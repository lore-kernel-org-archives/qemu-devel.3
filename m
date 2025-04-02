Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45ED7C36010
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 03:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzojk-0000ih-Bm; Tue, 01 Apr 2025 23:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tzoji-0000iK-Gz
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 23:25:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tzojg-0000jf-OB
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 23:25:54 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5320UhbH000927
 for <qemu-devel@nongnu.org>; Wed, 2 Apr 2025 03:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v/DCK0AYVofgODeBBbODv4VitB8OWuX6DK+gvOpaiGo=; b=fKNqP6S8qWF0cSlm
 XaE31baXQdy0xeGJiJ2+2fe+Lqq/UTF6BPf7qUTS9XNp9tmGxH/5fKR2LY0CSEE8
 mrGsVnK7oGFqJoVo09ni8qoGMfHq4BH8rRhdUIZ04wbcBuVk62bs4EcOG38Y52P0
 /HHQS7J4rEyGBKjURcCsyVtX3+AXaTbaE2BH8dFvbhZk/Di6NiWNJcS+zB54p+iC
 +P2Opr53wclc9gB+ElYp0nVxdFbZAZBgndLPP/V+hvNWYWStxa5nymmYmfHS3B/L
 i0yv5Rzogb9YArRG++HfxjyZ6oi+C7iyodLOa3Nxv/fB36DvHJ0f7ScVHFUjhj+d
 bPSJzg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p67qj8px-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 03:25:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2254bdd4982so159810165ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 20:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743564349; x=1744169149;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v/DCK0AYVofgODeBBbODv4VitB8OWuX6DK+gvOpaiGo=;
 b=MLIQwmAYuQyPQ8G5sadPu2PQ0sFohU6iOax1sw5CX/FVYCizLiKYeA43RQvW4g/rPJ
 XwDTtb8FBfToR5Yqqs4aBsxoYiKAskoj3QUsexKiVBUWAOIHH0ligqeHVvLWjH9DPY6g
 aMhF+3quMD0GR5AJ7b+/6Gj+K73ND0xMorRXr8vQK9spCZ5xupYqF6YjJfpX7BsqpOhH
 Q9stWtvo+v5IS6S3baWwfG1b+LTGe6xYB3YjrhJhjzrVW3IPDqIgyqGG+JUHg9hVUALr
 1ICENK64VDWUfMAkqRgvWY8+hO940TfA8V42PTs0lmO78eWkjlxSYbST9ASRpdkuuamu
 j7Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPpM0Ixd+BgJ1PA6gYrCMo9O6HQkm2hvVTOwKQJ9WSIxKbFJz9fuuxWl/1210Jxw3s3k0qO6wagYh9@nongnu.org
X-Gm-Message-State: AOJu0YzNH94PEhVZhf0Q4kYR8cyWN/zfNfOMht+dOgkmAprNGL5Iz9Oh
 xVKlB8viNwWowH2QQ+1Px/3x3dCIrBjm9Xo3oftPz1NVPKwGV7SfgmcCf0naEVXeBGy3A6roVyA
 DBYzG/E6H6+c09w2Q+NFt281lxp7BAV7p/Chr87INMgAs+C6CW3XItg==
X-Gm-Gg: ASbGnctO9YMcXMVosGLAIE6PW9RPsNKo3RTfTauUNAOPoj6rv2NkaKBlFh8YkSPlsA1
 Vufb2b3KJS9JdWaH11ZXbXTo1dQFhrqaYrZlkmgjYnjeAhUPvQcvcW5Kx6cYrTImlJ1bvP9DOR1
 az8uYEHAxW/HRMgF1qPdczyC6UzPAZnOqKpAPGvA5omUJKOD2BeKx6K4ygFrjszxEOBYCZ8ZcNS
 CbO0Y6IP9ffPCoXmBjpT4is2uatp06edk/5OellHm15HIrvdxzr0ENHwYAUysDdC3nDhROT0Z6c
 PcDyaJwur7EALkT2yvy3F9e7n9UAIApqKgaZCjK4dq8ts9HkBO5g7FcmfQS1k46WKoQId3/JCEI
 0Ok7Ca86PA8u+JiKo
X-Received: by 2002:a17:903:94e:b0:223:6455:8752 with SMTP id
 d9443c01a7336-2296c8785acmr13209765ad.43.1743564349009; 
 Tue, 01 Apr 2025 20:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1Vbf/0uxrGHA21VIwMm6gM0dPWJIHHgqufLOak7QBzp4pAMDo+GsTX/kdujMQyWY17A8nLA==
X-Received: by 2002:a17:903:94e:b0:223:6455:8752 with SMTP id
 d9443c01a7336-2296c8785acmr13209515ad.43.1743564348678; 
 Tue, 01 Apr 2025 20:25:48 -0700 (PDT)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1f8b4dsm96892465ad.237.2025.04.01.20.25.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 20:25:48 -0700 (PDT)
Message-ID: <4dc71c96-228b-49a5-8ce0-32da564a911f@oss.qualcomm.com>
Date: Tue, 1 Apr 2025 22:25:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/hexagon: Drop `ident` postprocess step
To: 'Anton Johansson' <anjo@rev.ng>
Cc: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org, ale@rev.ng,
 philmd@linaro.org
References: <20250312194547.7364-1-anjo@rev.ng>
 <20250312194547.7364-3-anjo@rev.ng>
 <001501db9d28$affce200$0ff6a600$@gmail.com>
 <e02be58e-9459-4799-8725-c7831169c89a@oss.qualcomm.com>
 <cg2nuphin6qlonwamvagphgdiky22uq3oaxqux5rwwthyimzbh@m5aq6yrw3i4k>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <cg2nuphin6qlonwamvagphgdiky22uq3oaxqux5rwwthyimzbh@m5aq6yrw3i4k>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fMI53Yae c=1 sm=1 tr=0 ts=67ecae3e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=wyPjQEBLlR2KjtVLFpQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ZPh5Hkmy5PonSLU1VmiDPVcFid9rDqgr
X-Proofpoint-GUID: ZPh5Hkmy5PonSLU1VmiDPVcFid9rDqgr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_02,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020020
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/26/2025 7:42 AM, 'Anton Johansson' wrote:
> On 25/03/25, Brian Cain wrote:
>> On 3/24/2025 8:53 PM, ltaylorsimpson@gmail.com wrote:
>>>> -----Original Message-----
>>>> From: Anton Johansson <anjo@rev.ng>
>>>> Sent: Wednesday, March 12, 2025 2:46 PM
>>>> To: qemu-devel@nongnu.org
>>>> Cc: ale@rev.ng; ltaylorsimpson@gmail.com; brian.cain@oss.qualcomm.com;
>>>> philmd@linaro.org
>>>> Subject: [PATCH 2/2] target/hexagon: Drop `ident` postprocess step
>>>>
>>>> The indent command is not available on a default mac osx setup with xcode
>>>> cli tools installed.  While it does make idef-parser generated code nicer
>>> to
>>>> debug, it's not crucial and can be dropped.
>>>>
>>>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>>>> ---
>>>>    target/hexagon/meson.build | 21 ++-------------------
>>>>    1 file changed, 2 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
>>>> index abcf00ca1f..246dc7b241 100644
>>>> --- a/target/hexagon/meson.build
>>>> +++ b/target/hexagon/meson.build
>>>> @@ -323,30 +323,13 @@ if idef_parser_enabled and 'hexagon-linux-user' in
>>>> target_dirs
>>>>            command: [idef_parser, '@INPUT@', '@OUTPUT0@', '@OUTPUT1@',
>>>> '@OUTPUT2@']
>>>>        )
>>>>
>>>> -    indent = find_program('indent', required: false)
>>>> -    if indent.found()
>>>> -        idef_generated_tcg_c = custom_target(
>>>> -            'indent',
>>>> -            input: idef_generated_tcg[0],
>>>> -            output: 'idef-generated-emitter.indented.c',
>>>> -            command: [indent, '-linux', '@INPUT@', '-o', '@OUTPUT@']
>>>> -        )
>>>> -    else
>>>> -        idef_generated_tcg_c = custom_target(
>>>> -            'copy',
>>>> -            input: idef_generated_tcg[0],
>>>> -            output: 'idef-generated-emitter.indented.c',
>>>> -            command: ['cp', '@INPUT@', '@OUTPUT@']
>>>> -        )
>>>> -    endif
>>>> -
>>> I prefer to have the indented version present.
>>>
>>> Is the above check/fallback not sufficient on MacOS?  It works on a Linux
>>> system where indent is not present.
>>
>> Aside: could using "clang-format" be another approach?  I suppose it's just
>> exchanging one dependency for another, but maybe xcode comes w/this tool?
>> Then again, maybe it would be an inconvenient dependency on linux systems?
>>
>>
>>
>>> Thanks,
>>> Taylor
> Sorry, I misspoke in the commit message. The problem does not occur for a
> default xcode commandline tools install, but when the user has installed
> indent via homebrew or some other source. I don't have access to a mac
> at this moment so I cannot verify, but I think `-linux` is not
> supported.
>
> If we want to handle this situation we can either expand `-linux` into
> it's constituent flags or add a `host_os == 'linux'` condition.


I wouldn't bind this behavior to the hexagon-linux-user target, because 
it happens to be hosted on "!macos" if that's what you mean.  But 
"host_os == linux" seems reasonable.


OTOH if it's not easy to detect this condition, I think it's fine to 
remove it entirely.  Seems like -- if we as developers want to read the 
output we can indent it on demand (or use something like inotifywait + 
indent to automagically indent it after writing).


Nit: subject typo - s/ident/indent/



