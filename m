Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30707C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94W9-0000Z3-NQ; Tue, 22 Sep 2026 13:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x94Vt-0000V3-Uw
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:42:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x94Vr-0007i5-VP
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:42:41 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEj9Bu1423272
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 17:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cCfukmttpMj1AiTdijkKMoUwrjkT798l4DySci6EqPg=; b=l8WxPsOtGa3FIy5a
 a0oKdLrdPdqo6mcUCA7VdCa/0YRnDN6CjoXm/KTG1DYLjLTMWfDI61lZEfnjb4Ih
 w6/TxkpKG16CZ6NDWFZQELviMwiC5qMDYZH1qG3JZg9MMkBy2mi504x9M6WFpQKc
 iaKcPZzA9bu/NyqxKe/QfASCdEruPMWQuMUuoEMqAd4jjVvVTpISORGoaDtmg3pv
 sVuyET9zV2/d/c9Nb3AjEyC6p0Kzw+DKy1XsP80flAVqZfC9NMB6egFtSXc2SdUe
 n47Ps3PcA/KIUuIIq+n/AlSsfXkm1vrZV87p6QUMjZ+waMTH5bTuqppyXLhYhHaw
 P9Nd0A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guqk4t4et-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 17:42:38 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-32ab0911226so54713eec.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 10:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790098957; x=1790703757; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cCfukmttpMj1AiTdijkKMoUwrjkT798l4DySci6EqPg=;
 b=PPA5icfk/IClr6dVwJcZnzC58d0mRTIv13HziXasCdJshqnNwQA+poSICqyulQ/S4t
 6sIxdjdO5eNBCqmdLe8feGZmGNMET4jqqIXc3h56px5rb9gLycdIr42Iha4AmaB7EO3f
 jwdGYYa6/GBbmrjGOKiKMBmVPb7bG2rn8NjDjEQkRvaPOdG2nETuoLDwlzXD/t9c5K9r
 umdR5FkuGJFN5096XGLSksGlHeGAmLRDc0VW0OjxIT88QxPv/jwlJ6pD8PSRbHKcY0QR
 bZPVw5tHRMDDONV2QQ18IQWioIoiY27Lr9DBpFNLXeFA4geVudyVkHL0pcFbd0bry0KB
 SBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790098957; x=1790703757;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cCfukmttpMj1AiTdijkKMoUwrjkT798l4DySci6EqPg=;
 b=JtG4dReBb5pl3nn5o81xBmU2pEPmDRaUqBeBXURRezqaiC80VhsXpDXIzgGZrX/3NV
 2oqyzhwvl26b6Y+FlF8PA/BZxY6HQluoyIagVfwS2Tw4XmDketpqasK819IM1rarkt+B
 rYVkeH0rckBomslKnGE/64MqyOez73LfkTz61SWeIRjE2ietGvwhTFUEjH2WU3kHz2Fb
 PbRrDDKNC/tByo58ZsvAxkhZ9EfQkSvBGfX6YM0tGne8BNM6n7jtBNqkQtl6X6A+nNXh
 VdDuH+i8b0wIN8N3314SMrn5w3xl7Z1aE/iVapg/sCMzfbkjPVbDxbOIVBOnTpDGvmbr
 bp1A==
X-Gm-Message-State: AFuF++nJh56Fc6uo2gyMH0YQ14a9RfmDv731JgoZzyS5t7k/XVcYOV/a
 Oe1niQ53U78GUpBTW324/HDAAOhuA59+9sdY/XZrr/6Q8JemV5kZYRA1lFwwUgApuSqVXfwyzlL
 r71gWFBARSnXz+CHSzKb6qtF9yazhs625CsqHdFkcBEABJe24dFKUk0yJRA==
X-Gm-Gg: AYBFou1LhcieddTEyEOl+97t785GDGP8RmwMCGZPQESYs21taDjhMt+WCPRcoDVHstk
 7Gpa/+nkB3BRlbxFlWIGClq/pN+0n16sR6gnJyOEmwr8skwUuc+B/pTu6PnRpR7IZOptWEANCTy
 YlccpaXRQN1uSsjWYQWhWI12InkHQaYBnDjsDDq8rer11E5qxzJDihpLvBJrQUcHYiHQn+4empb
 He8wN3YbHsY6ea3M2sFBx2zJzJnpNNcROlIVbRWH0CLOxeBAG4YOxs7yZ8SeATa8Xoq1xcWChaT
 oB8ptUU84tJVc528KexFcYgmPI6wMo/SQb/fVqCxpyntHj3UPgBox+1rsYbxnlScS9Rtp+zKVO3
 XdGz+yvG/cgvMFMj3+vSSoYAKeO6L5NoLmGRIJ+rj53ehuKtHv5weqGVT0VlVbe/kdes=
X-Received: by 2002:a05:7022:3c0b:b0:143:1bb1:b3cc with SMTP id
 a92af1059eb24-144f8e175cdmr178684c88.23.1790098957191; 
 Tue, 22 Sep 2026 10:42:37 -0700 (PDT)
X-Received: by 2002:a05:7022:3c0b:b0:143:1bb1:b3cc with SMTP id
 a92af1059eb24-144f8e175cdmr178662c88.23.1790098956599; 
 Tue, 22 Sep 2026 10:42:36 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f8feab50sm135357c88.6.2026.09.22.10.42.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 10:42:36 -0700 (PDT)
Message-ID: <b6175747-073d-46d6-b35b-b9f1a9c47107@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 10:42:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] tests/docker/dockerfiles: refresh images
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
 <20260921231458.3369-3-pierrick.bouvier@oss.qualcomm.com>
 <4207d4f8-a452-417f-b240-77cef59b7d54@oss.qualcomm.com>
 <arKywfq6YHXxN8Ch@redhat.com>
 <039cb46b-90ba-40e6-bdb3-9812add2fc44@oss.qualcomm.com>
 <arK8UOJtGSxYpNtf@redhat.com>
 <f2df6883-ee78-48b1-bd03-9b7d41ac2b60@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f2df6883-ee78-48b1-bd03-9b7d41ac2b60@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI1OSBTYWx0ZWRfX8rDpcDwMOrOS
 kVDAJwut4PeBpWGi6jgiOzJxwiuXK3k9eWGtyfkGvQ2/D5Sz0n+3fb/bM/iz0Fltl0BZ3xAB5jV
 dXrkgb4pvbK9hgCy5PfHctaPv4QLFnqxqs/tuyvBmEYjLSEvYbiPM8dzvocai1SaYdb83O2uFSj
 vBsamIGnba26JtoiLuiXAePpj6Tsn3a3zBayV9/Qnn7Sd97e05DrfjE0NgjR3fpirCZ2YFMkLBP
 QT0F8SATl7H5W75+WEme6cVpKDdi47BcQFWo1Yxwiu24AhPeksPBpRZcp0ke0VKSFtON0jCKEZY
 5W/q8CscWES3ZMs2s1rwBJe0BNxong9ITIuqNfKVGc2xGlBgi1GBvuliRy/tAhrGgD5xWF1QPKz
 8AgcivvoD/n5LKaX/SvRYyPouTDbWFFB7NEUoc++XcHzcvWahtSCyWt+ir1a8MyonUy9MiXLaTn
 heqyYNzItYWJY1df7aQ==
X-Proofpoint-GUID: Q0PiAS7vbENk39PerZum3qd1ek5itlDB
X-Proofpoint-ORIG-GUID: Q0PiAS7vbENk39PerZum3qd1ek5itlDB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI1OSBTYWx0ZWRfX3YK7hrifCW9F
 f571pIO/Kkbgo5du6uxGsDoX6QpfteweAC1CJyJpV2lJu7VW/N4Y+SIdnnlIePHNwnWB7wGOkl1
 9FDvldT+8LwRRpPg+RUasvlZmNPf7HI=
X-Authority-Analysis: v=2.4 cv=XrVvqlF9 c=1 sm=1 tr=0 ts=6ab2be0e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=8Ko_RuCesc2uCrh8j00A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220259
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

On 9/22/2026 10:41 AM, Pierrick Bouvier wrote:
> On 9/22/2026 10:35 AM, Daniel P. Berrangé wrote:
>> On Tue, Sep 22, 2026 at 10:16:27AM -0700, Pierrick Bouvier wrote:
>>> On 9/22/2026 9:54 AM, Daniel P. Berrangé wrote:
>>>> On Tue, Sep 22, 2026 at 09:15:02AM -0700, Pierrick Bouvier wrote:
>>>>> On 9/21/2026 4:14 PM, Pierrick Bouvier wrote:
>>>>>> latest update of libvirt-ci changed packages, but images were not
>>>>>> refreshed.
>>>>>>
>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>>> ---
>>>>>>  tests/docker/dockerfiles/debian.docker     | 1 -
>>>>>>  tests/docker/dockerfiles/ubuntu2404.docker | 1 -
>>>>>>  2 files changed, 2 deletions(-)
>>>>>>
>>>>>> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
>>>>>> index 77869f71546..2d03ff03c8d 100644
>>>>>> --- a/tests/docker/dockerfiles/debian.docker
>>>>>> +++ b/tests/docker/dockerfiles/debian.docker
>>>>>> @@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>>>>>>                        libpcre2-dev \
>>>>>>                        libpipewire-0.3-dev \
>>>>>>                        libpixman-1-dev \
>>>>>> -                      libpmem-dev \
>>>>>>                        libpng-dev \
>>>>>>                        libpulse-dev \
>>>>>>                        librbd-dev \
>>>>>> diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
>>>>>> index bb8f4e4e53f..440699a5005 100644
>>>>>> --- a/tests/docker/dockerfiles/ubuntu2404.docker
>>>>>> +++ b/tests/docker/dockerfiles/ubuntu2404.docker
>>>>>> @@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>>>>>>                        libpcre2-dev \
>>>>>>                        libpipewire-0.3-dev \
>>>>>>                        libpixman-1-dev \
>>>>>> -                      libpmem-dev \
>>>>>>                        libpng-dev \
>>>>>>                        libpulse-dev \
>>>>>>                        librbd-dev \
>>>>>
>>>>> Dropping this patch, as it's incorrect.
>>>>> In libvirt-ci, libpmem-dev is a dependency of targets debian-13 and
>>>>> ubuntu2404, so not sure why it removes it here. Seems like a bug in
>>>>> libvirt-ci itself.
>>>>
>>>> Most likely you ran invoked lcitool from an aarch64 host OS, so it
>>>> filtered out libpmem-dev which is only valid on x86_64 targets.
>>>> The non-cross containers we have defined here are assumed to be
>>>> for x86_64 targets.
>>>>
>>>> We should change the tests/lcitool/refresh script in QEMU to pass
>>>> '--host-arch x86_64' to lcitool, rather than defaulting to the
>>>> developers' machine's arch.
>>>>
>>>
>>> Thanks for the sharing the reason, I'll add this option.
>>>
>>> Out of curiosity, what's the reason to differentiate generation based on
>>> host arch?
>>> Wouldn't that be better to be explicit if you want to generate an arch
>>> specific Dockerfile (and use FROM docker.io/arch/... instead of
>>> docker.io/library)?
>>
>> I'm not familiar with docker.io/arch/ but this all just grew up
>> organically over time, and since most usage was x86_64 host based
>> there  was not much need to think about other scenarios.
>>
> 
> Basically, it's (official) docker images per arch, following docker
> platform naming:
> - docker.io/amd64
> - docker.io/aarch64
>

s/aarch64/arm64v8

> https://github.com/docker-library/official-images#architectures-other-than-amd64
> 
> Advantage is that image are provided for a specific platform, which
> avoid some of the issue multi plaform images have.
> 
> For instance, on aarch64 host:
> $ podman run --platform linux/amd64 docker.io/library/debian:latest true
> $ podman run docker.io/library/debian:latest true
> WARNING: image platform (linux/amd64) does not match the expected
> platform (linux/arm64)
> # podman/docker now select the amd64 version by default, which can break
> build of other containers. It's a design issue with docker cli IMHO.
> 
>> If we want the tests/docker/dockerfiles to be portable to non-x86
>> hosts, then we'd need to either have many dockerfiles there for
>> each arch, or drop packages that are arch specific from the
>> install list.
>>
> 
> I'll add the --host-arch x86_64 option to lcitool as recommended, which
> should be enough for our need.
> 
>> With regards,
>> Daniel
> 
> Regards,
> Pierrick


