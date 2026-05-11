Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18532CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMUxE-0006lm-Mj; Mon, 11 May 2026 14:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMUxB-0006lS-RJ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:02:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMUx9-0004nE-KI
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:02:05 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BHdxKR1856939
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 18:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NA/nT04l+q+4hnfT6D72ZMw31Zj61L2f1KTHpn/kWSM=; b=NB6z1uR61ZjJbjdl
 BIHU1AjrfGa5EZbYDqJmtfjB7bc+Xmsyst2JrZixup9HuAQZ0ba+Xx/EjcwKaEzC
 krtB3iHkYcMTJACXNpyi4diFAlOYmlFYMQ9BXP7v3lJOfbJn2g5ayJ19/FVdJPqx
 +Q1zCxu91kmqSieQkmNrAntjl2aMCBgWCeMQKSpIQ7158NSxXjrGN+zAlZRyZs06
 aisabOFW6YWPj4IpKmxoI2fwFhDKh7GGWgfXd6956n19JCzB/W5CjZEApq6149cd
 4BJBaXkY9g/k5H3hhskdyntXwzRIpzWF1cflYPyjwmW2CgYtz1j1sLPd6F6prC+R
 YUeb/w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3kqb83vm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 18:02:01 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2fe1cf409a1so2039690eec.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778522521; x=1779127321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NA/nT04l+q+4hnfT6D72ZMw31Zj61L2f1KTHpn/kWSM=;
 b=QywDCPWFAWxS+HPC7Xzn/+/0ssA0qbM21LkowwuGPvvoQ3gak1BdYzWH+C3Ihek0R6
 d1Yl8mojs6vlvVkuyqXhsKBQnYtk6jL29Nxsdh0dCtUgAoxFFG53tLbp2O1RLB/utn34
 QjOtdD3dkMl0jrGZ0XOYsgBw7NeJjKuUTr6xR5/ng/Bwrcakh8lOW5UAbBIVnebT9QfM
 8eqSwqbMbK7SwsLpVlgZaLzKCvWO12VJh/gyusRsPAGC+CuGNPDNoZzipr2RwqpgsyBY
 kYKsvk9787w/uhBXY1HgnqKDCFkk7ZJjsxtIFTUx+UvSuwCHXLL3cZ0DXNkj7Pz+WrTP
 uzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778522521; x=1779127321;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NA/nT04l+q+4hnfT6D72ZMw31Zj61L2f1KTHpn/kWSM=;
 b=f+fCf5nSaC54ZNchnTcS34XC/vdskoJBwPBhaekuIQAaAgozYXbeqQIjqdXrzmO+ls
 p1ipSpqbJ6djtM5nkDgRmnA876tHUZO9/pMCcG+zhKSv+IbSQhyypHJbgvVDBXtvIcbW
 t0+aGH/Zoa7fidk13oaet6CEEqM+wXk1/s+3O9aAkCP54hOKdvqgkKzcUHhpcihffk8c
 zL0CwI0Hs8wrCZeJaZI+pGvSn874gqggxys/28iN+hDwdvpeuhoAUKWSkKzzofp1OmTZ
 KZ8a6joayviaF1tqSlqJhUeN21O7EDk9g/ey1uKDy4V8CNWHAV9hbQwyKjRHXHRQh2rW
 2ntQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/07kNIvFPidK2PGJsujCCN10+X0oEQtnc3qxmJ4jEi+m5SrriCs8GmOhKRH4jYITrxVYnfDlJEbgzv@nongnu.org
X-Gm-Message-State: AOJu0YwzPmkt+eMdBHCRpSA7eOGKV2x6VVDSyt/jayAwnBfVqgSydCw6
 EeH8G6PTR5VpXB6j2GhggybROXDoCQtRlc1ya/4WUauHc5915nc9OXTwSbPrMxPg8nZacJbBKZo
 bfya4Y+FuN3S3UF7HUn5WnRYD7elY1OGPZvtTzeu0etrDGXx9fIyYVwMpmw==
X-Gm-Gg: Acq92OGJz4RLWxCtCBcOQU3QFXBiiwxq98bd8EtXEqLiueILewSKqDR1OQFytni/lcN
 m6WQArXGZGn05e8SI9MOrLjx9oUN9xSnEXrbLO1KlN0gF4QIQt5dO9KUYm5xgy2u5vxjoj5ZrPB
 QnkB4mTTI5C5GIlCQusQvZVVYY3ZiP6vKAaqyfhd5YBz17FqVjslgm/TxIVuWGjr/hbt9RLyNn+
 M8nWMkPgNWCwMN6oM7P5Lhzn3TY9hUHJqrWegcPxUUcaDklgyrVeVjQZHzwof08OL/8sPOj2tB1
 TYFjhztA6pgIVd3UCBWXjGV9iVoP3hLEfIGFxQC6NAEAQlth0qozII+6tNrn6lAIrU0MkM63H6s
 bZPvA79WzItqALjtL/4Qp9jttW8jq3W3AtLWyIQDyaOeW1oOObBiupdG6JzOqYAZ5Y0KZKa8Q2y
 8s7H+puj5iw3Z4Cw==
X-Received: by 2002:a05:693c:2c0d:b0:2de:aafb:feff with SMTP id
 5a478bee46e88-2f548895139mr11153879eec.2.1778522520598; 
 Mon, 11 May 2026 11:02:00 -0700 (PDT)
X-Received: by 2002:a05:693c:2c0d:b0:2de:aafb:feff with SMTP id
 5a478bee46e88-2f548895139mr11153829eec.2.1778522519919; 
 Mon, 11 May 2026 11:01:59 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888e4016asm14325725eec.28.2026.05.11.11.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 11:01:59 -0700 (PDT)
Message-ID: <2a4981de-da3f-44a9-b422-3ba9c24b7dab@oss.qualcomm.com>
Date: Mon, 11 May 2026 11:01:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 089/110] target/s390x: Introduce common system/user meson
 source set
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3b5ff524-75d6-41d0-949d-39bbff0558bb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: e3hRELBsaDh4vlFRRl9zjL5dPSn8kBEs
X-Authority-Analysis: v=2.4 cv=LOJWhpW9 c=1 sm=1 tr=0 ts=6a021999 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=Ng9wYaPqCYiD3NJH1AcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE5MiBTYWx0ZWRfXylXj1ByWI+cq
 PzmQwPdu/1AejrAdIA4ECOIxorprtEMTBFNPyzD77d0Ba2OYhjEd1mlbG07Wx7GZlfxYgMoNCNQ
 4ZsyMsU5uuz4lmTCGrKuR2Pl+HMx6KZaM9Tzm/hIup/vyIOFJMGEh4fidq9g4BUY0NP07We/DjK
 HDYfA+JaNqnPxB5tPAyt86lOPNBm3kqnfRWvECVgZJ3cfuXF62+5bXnhN+Ea9lG6WSdlx84iJxw
 3dG6Wq4IZP6jxDgi/ZusqRc08Mo44pgrUdehzP1Ri+++8/JJjR/TY2+cvRUOjuPgF7ixpKr7Eb3
 5WBu8xkSM2wnkkTX6SUgj7+xYij8I+hHQdf0sbOcF+Rn+TDEfGALZE++06OuHD3hBFj77/vtWbG
 t8LMLm/YMxoPcwq9jgF9v6XfzucshpVNnS1KeNbSuekuNFGx1GGE+txU/YPShDZZhF569oIe7cK
 y7PMTXuCtJVPtHlFqwg==
X-Proofpoint-GUID: e3hRELBsaDh4vlFRRl9zjL5dPSn8kBEs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110192
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

On 5/11/2026 10:47 AM, Philippe Mathieu-Daudé wrote:
> On 11/5/26 18:36, Cédric Le Goater wrote:
>> On 5/11/26 17:58, Eric Farman wrote:
>>> On Mon, 2026-05-11 at 17:48 +0200, Cédric Le Goater wrote:
>>>> Hello,
>>>>
>>>> On 5/6/26 15:55, Philippe Mathieu-Daudé wrote:
>>>>> Introduce a source set common to system / user. Start it
>>>>> with the files built in both sets: 'cpu_models_user.c'
>>>>> and 'gdbstub.c' No logical change intended.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>>> Message-Id: <20260423135035.50126-4-philmd@linaro.org>
>>>>
>>>> This change introduced a regression with PCI passthrough which
>>>> stopped working. Guest kernel reports :
>>>>
>>>>     [    0.156501] zpci: PCI is not supported because CPU facilities
>>>> 69 or 71 are not available
>>>>
>>>> and other devices (ap, ccw) are impacted too I think.
>>>>
>>>>> ---
>>>>>    target/s390x/meson.build | 25 +++++++++++++------------
>>>>>    1 file changed, 13 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/target/s390x/meson.build b/target/s390x/meson.build
>>>>> index 6f98ce34d73..44f58ac2919 100644
>>>>> --- a/target/s390x/meson.build
>>>>> +++ b/target/s390x/meson.build
>>>>> @@ -1,4 +1,9 @@
>>>>>    s390x_ss = ss.source_set()
>>>>> +s390x_common_ss = ss.source_set()
>>>>> +s390x_common_system_ss = ss.source_set()
>>>>> +s390x_system_ss = ss.source_set()
>>>>> +s390x_user_ss = ss.source_set()
>>>>> +
>>>>>    s390x_ss.add(files(
>>>>>      'cpu.c',
>>>>>      'cpu_features.c',
>>>>> @@ -15,15 +20,16 @@ gen_features_h = custom_target('gen-features.h',
>>>>>                                   capture: true,
>>>>>                                   command: gen_features)
>>>>> -s390x_ss.add(gen_features_h)
>>>>> +s390x_common_ss.add(gen_features_h)
>>>>> +s390x_common_ss.add(files(
>>>>> +  'cpu_models_user.c',
>>>>> +  'gdbstub.c',
>>>>> +))
>>>>> -s390x_system_ss = ss.source_set()
>>>>>    s390x_system_ss.add(files(
>>>>>      'ioinst.c',
>>>>>    ))
>>>>> -s390x_common_system_ss = ss.source_set()
>>>>> -s390x_common_system_ss.add(gen_features_h)
>>>>>    s390x_common_system_ss.add(files(
>>>>>      'helper.c',
>>>>>      'arch_dump.c',
>>>>> @@ -32,19 +38,14 @@ s390x_common_system_ss.add(files(
>>>>>      'mmu_helper.c',
>>>>>      'sigp.c',
>>>>>      'cpu-system.c',
>>>>> -  'cpu_models_system.c',
>>>>
>>>> This file is compiled anymore and the CPU features and facilities are
>>>> not propagated to the guest anymore.
>>>>
>>>> Without this patch, cpuinfo reports :
>>>>
>>>>     features    : esan3 zarch stfle msa ldisp eimm dfp edat etf3eh
>>>> highgprs te vx vxd vxe gs vxe2 vxp sort dflt vxp2 nnpa
>>>>     facilities      : 0 1 2 3 4 6 7 8 9 10 11 12 13 14 15 16 17 18
>>>> 19 20 21 22 23 24 25 26 27 28 30 31 32 33 34 35 36 37 38 40 41 42 43
>>>> 44 45 47 48 49 50 51 52 53 54 57 58 59 60 61 64 65 69 71 72 73 74 75
>>>> 76 77 78 80 81 82 129 130 131 133 134 135 138 139 140 146 147 148
>>>> 150 151 152 155 156 165 192 193 194 196 197
>>>>
>>>> with :
>>>>
>>>>     features    : esan3 zarch stfle msa ldisp eimm dfp edat etf3eh
>>>> highgprs te vx vxd vxe gs vxe2 vxp sort dflt vxp2
>>>>     acilities      : 0 1 2 3 4 6 7 8 9 10 11 13 14 16 17 18 19 20 21
>>>> 22 23 24 25 26 27 28 30 31 32 33 34 35 36 37 38 40 41 42 43 44 45 46
>>>> 47 48 49 50 51 52 53 54 55 57 58 59 60 61 64 72 73 74 75 76 77 78 80
>>>> 81 82 129 130 131 133 134 135 138 139 146 147 148 150 151 152 155 192
>>>>
>>>
>>> Thanks, Cedric... I wonder if the above is addressed by this patch?
>>> (I haven't checked yet, but will
>>> do that now.)
>>>
>>> https://lore.kernel.org/qemu-devel/20260510204640.2178926-1-
>>> marcandre.lureau@redhat.com/
>>
>> Something like below seems to work.
>>
>> C.
>>
>>
>> @@ -22,7 +22,6 @@ gen_features_h = custom_target('gen-feat
>>
>>   s390x_common_ss.add(gen_features_h)
>>   s390x_common_ss.add(files(
>> -  'cpu_models_user.c',
>>     'gdbstub.c',
>>   ))
>>
>> @@ -38,8 +37,11 @@ s390x_common_system_ss.add(files(
>>     'mmu_helper.c',
>>     'sigp.c',
>>     'cpu-system.c',
>> +  'cpu_models_system.c',
>>   ))
>>
>> +s390x_user_ss.add(files('cpu_models_user.c'))
>> +
>>   subdir('tcg')
>>   subdir('kvm')
> 
> Right. I wonder how I could screw that change...
> 
> 

The only possible thing is that code becoming common skipped some ifdef
that were here before per target.
So, something that should have been poisoned has not been, and we
definitely need to identify what it is to prevent other regressions like
this.

Regards,
Pierrick

