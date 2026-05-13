Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805F2CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 21:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNGzv-0001Br-Ry; Wed, 13 May 2026 17:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNGzv-0001BN-0V
 for qemu-devel@nongnu.org; Wed, 13 May 2026 17:20:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNGzs-0001wo-Vz
 for qemu-devel@nongnu.org; Wed, 13 May 2026 17:20:06 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DJp3wB2965290
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 21:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uxArss6+J1EjxHyYCMLqCqQg44fxDziLliim7Qgcp4U=; b=OO7zyBZwHpiFhEy0
 IJkwuR5DDGmx+rOg+ZYTRLvVBufWMR7PqUdTZlQR/cUF2K+DmhJ5jBDkM2o9u6SV
 ER3N6/9gI0Qye8zhWVjMXil0tpcH1V2CZItRHlrFJJVBxfEhBNE6hDWSsA6YsHNZ
 +TiJHVlz+A9SjKKRkDPT3BwbLjQWLmRojfYPF9Ooip5pEiXvx6f9sbDSMwuDraS+
 0fGfyGYD9gyPQxOALFERdARaL2KRugabrLMDiaunmnYM/BKryKAULuT/W0N8Coxi
 dbsxunIIQigF4DvnVTakuIkJofTp8wkqgWdstQMM2BapjjpuMjguA6Ub1i4pdkV8
 KvyrDw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4ma5bgmj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 21:20:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50fba8d8c40so55043821cf.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 14:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778707201; x=1779312001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uxArss6+J1EjxHyYCMLqCqQg44fxDziLliim7Qgcp4U=;
 b=f3sLq/4VtTOQU1krf2jHnv7ye8Odmf+oD59+RW1a4Mc42xaW1pL613fmI+6c+DIGAy
 fk8Aof3MwR1kQD1c8pfuvIkmcS9nfzJqHDpCbio2Tg65bJTEth370/53M0zr7LGEcWY9
 YXRb0TvAZmfBDFG9JlaTSIO/ykAPF1teexMt+lNuuqPWaCGj68pDK3R/qBt/Kny+whgM
 ed3yrooon2gAImjLvPXhls6Py8+Mp+06dZ6BmnjApTpeM66uYm2/8rAXddqTKRBVV6z1
 NTWYoKGw3r3vcdkVpTpO8IoSWewbT4zgcD31T5wYu6/ejIyfxrK4C2q/Jz+2KwXRLDJS
 hnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778707201; x=1779312001;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uxArss6+J1EjxHyYCMLqCqQg44fxDziLliim7Qgcp4U=;
 b=DnVAvuPBfT7u4aYKnKzNNAxFHP8gj66ByJX2cOOw3aIshUNvi10q8hHLNvxq/nuVCK
 ttWiqWR29JIoMj88/UA9l1cy1xPJfUVRdyEv5yChCp/b2izdKkN614z/s4FiwkDGAs+8
 YhbIE738A7RMBNXi22qOzw/2ETj6ttnHBiLCbADCPFooXiVxgXFAZrZkDZVGIi13O8KV
 5fCbnSuIWhvN+nBxSNus/m57xkFNSPDOvg1K9CK4rW6J32V7V2TDHJuJ3OJF7vgX/8+o
 LNynnALrG3ajM/Oo0gUPaXuyNh7iUzXXhEjlJ8aeIODykOVfE7+oYqJbV+/l5A2ZV09O
 o9Gw==
X-Forwarded-Encrypted: i=1;
 AFNElJ84nFlkK9OirgF02/KSI1vs112vGYRwSMAmLBJZdj3POMkuMXxh+M7zBK8f1OKEjGtW9ugFFsbNaQW+@nongnu.org
X-Gm-Message-State: AOJu0Yx+uBNeEtJE5F5Lm2vyIvNCZtDF2/e/DYeqBg5906kl0nNQT8SU
 zXIBnSERyX/crXO2qF0l6q7aQ0wnTnlo2If57ntMUZWk3c9LZyGnAXEN05RavMX5jYrjoHeFV5o
 cnjfqzY/5ISNm5LKcMQGT5/W1vJfXJ2tOEPgWjkMmTz++cUnq1/BNtzr1hQ==
X-Gm-Gg: Acq92OErMmrrD01GvSICT3hahuoSl9aB4yVik6ctwCFISB9eGmRQvlJ0O0GL25yW+J2
 lgTP6AqG3K8W3a2nTN9Af98XdwC42MnaE5KbZRZGKrfmEpIIGAp+5LZilIS3EGsozVQSjI2oMYp
 w05p8n/64IF8xkW3amykiS0deDTCc5i6at7SOuy8wXNC7L2J9oSqdrk8XKOiFBYoJtyL+sVuigB
 ht7qfjsztU3tM/TkVZiGfdo8nQdxlF0lY7bwuoWhZLS56Quqig1OsnmO315bWtRSBeCcUWRSLFg
 SGvzDD9pNzSh5fuvGe6ISG2Q0IA0eoo2y81Og1kaouqaohR+gqleCNh6dLsZ5SooqlNievOwM3C
 1/oiPBs2feR4v0P9xaH+cHRJjq0LZxgJDXzrH7JdFwsC6Cwdhlh0Ynw1vTj6qHDkGcFjkSw==
X-Received: by 2002:a05:622a:14a:b0:50b:445a:4139 with SMTP id
 d75a77b69052e-5162f66b6efmr70631381cf.54.1778707201317; 
 Wed, 13 May 2026 14:20:01 -0700 (PDT)
X-Received: by 2002:a05:622a:14a:b0:50b:445a:4139 with SMTP id
 d75a77b69052e-5162f66b6efmr70630831cf.54.1778707200856; 
 Wed, 13 May 2026 14:20:00 -0700 (PDT)
Received: from [192.168.68.105] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c908562d3csm6623756d6.4.2026.05.13.14.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 14:20:00 -0700 (PDT)
Message-ID: <d256daa0-da81-4d9a-9824-a1eeea8e1b7e@oss.qualcomm.com>
Date: Wed, 13 May 2026 18:19:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] hw/riscv: server platform reference machine
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 leif.lindholm@oss.qualcomm.com, Fei Wu <wu.fei9@sanechips.com.cn>
References: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
 <20260424191129.1494381-4-daniel.barboza@oss.qualcomm.com>
 <CAKmqyKNZiA=rYVD6ighyFO+qmhdYVk=UgbaznBHrZ2yt1ZvOtA@mail.gmail.com>
 <wazisnbumueun37qskfnjz7n5ioqhpshesebjsczgucjmxxhia@va7avfk77xlr>
 <e172e568-5419-41a3-8a83-baf30e774f0c@oss.qualcomm.com>
 <3ruuacgtajzzzup2oz2ltmvxfrzpkdnclgqsb7hoe7pvzl6y3l@ojdsprixdffa>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3ruuacgtajzzzup2oz2ltmvxfrzpkdnclgqsb7hoe7pvzl6y3l@ojdsprixdffa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDIxMSBTYWx0ZWRfX6HuDE/G9LdtZ
 21vMzJMswvWTNtMaOGGahlWywi9E89lYTNn4Tzxo58m9k0zaQ5aSz7gxItyhT2kLcLGE4L7rinV
 iHZ3XV8k25kGogSYWYi+0/9/ailj6eO77PjBIqY24mZqX7HRMAfyqWeocvo6DS/5OSH7zDl1p8q
 269hkg/TOvqjdSfjmvfisExlG5XtHU9I7pejO3bHCfACe/qq7I/Q3b11y+jd7y3zSz3zpNX6u+k
 zwsOV77lvxZ8ZC1fqf0lneU4moSsklC+XqGTH+M7Fo3MZYBM3O9mY7Pr9vjrrl/DbckrGt14/i8
 7o+5MwB9pKblcKOeU91JrGfTven5bQNscQhlSYYJGorpgnxHj+R/kT31SPlpmUI/d17ygRALfZn
 OGUReJoB2DHxnnv8qWgoKWkxw9BoKBn+/yPypkfezWsRI1Gh+6YiM6JBr9M1LD4myoRgBBM+5ic
 20upf5Cqs2D3N9SkhnA==
X-Proofpoint-ORIG-GUID: pNpvbsjhmCmST94fDJ8PNQ04jXEpPxS_
X-Authority-Analysis: v=2.4 cv=TJZ1jVla c=1 sm=1 tr=0 ts=6a04eb02 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=bshKhp_i1SVAnh2eU98A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: pNpvbsjhmCmST94fDJ8PNQ04jXEpPxS_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130211
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 5/8/2026 2:31 PM, Andrew Jones wrote:
> On Fri, May 08, 2026 at 01:59:51PM -0300, Daniel Henrique Barboza wrote:
>>
>>
>> On 5/7/2026 4:23 PM, Andrew Jones wrote:
>>> On Fri, May 01, 2026 at 01:27:41PM +1000, Alistair Francis wrote:
>>> ...
>>>>> [1] https://github.com/riscv-non-isa/riscv-server-platform
>>>>
>>>> The first line of the README says:
>>>>
>>>> """
>>>> This document is capturing discussions at the Server Platform TG.
>>>> These are not official specifications and everything in this document
>>>> may change.
>>>> """
>>>
>>> The README should have said frozen instead of "everything may change".
>>> It was my fault for not having updated it. I have updated it now, though,
>>> but not to frozen, because v1.0 is now ratified.
>>>
>>>>
>>>> So this machine needs to start out with version support (like the ARM
>>>> virt board)
>>>>
>>>
>>> I'm happy to follow ARM's reference board's lead on this, at least for
>>> now. I only wonder if we may not want to use the QEMU machine versioning
>>> support to bind machine model versions to ratified and experimental
>>> platform specifications at some point. For example,
>>>
>>>    rv-server-ref      -- new, bleeding edge platform implementation which
>>>                          may include experimental bits
>>>    rv-server-ref-v1.0 -- versioning ensures the implementation matches v1.0
>>>                          of the spec
>>>    rv-server-ref-v2.0 -- versioning ensures the implementation matches v2.0
>>>                          of the spec - likely backward compatible with v1.0,
>>> 		       but not necessarily
>>>
>>> I'm not sure if [ab]using the QEMU machine versioning support in this way
>>> would cause confusion or other problems though.
>>
>> IMO we shouldn't use the QEMU machine versioning in this case.  We can
>> instantiate a new board in the same server_platform_ref.c file that has a
>> different init(), memmaps and etc that would reflect the new spec.  We can
>> do that once every time a new major spec version is created (so ... once
>> every 2+ years?) instead of having to cope with the all the compat_props
>> machinery from the regular QEMU versioning design every single QEMU
>> release.
>>
> 
> Sounds good to me. And the rv-server-ref cpu models can do the same. We'll
> need to get the version number into the name, which means this series
> should name the board and cpu models something like rv-server-1-0-ref or
> whatever works best. I'm not sure if we just want to do this for major
> numbers, e.g. rv-server-v1-ref, it seems like someone may want to target
> a minor release.
> 
> Hmm, how about yet another idea. The name stays rv-server-ref, but then we
> have properties for each spec major.minor that get ratified. So, for
> starters, -machine rv-server-ref,spec_1_0=on and eventually we can also
> have -machine rv-server-ref,spec_1_1=on and
> -machine rv-server-ref,spec_2_0=on. Without providing a property it would
> default to the latest ratified spec version.

Seems good to me too.  For now let's leave the code as is since we're
supporting just 1.0 and add the required boilerplate for these properties
when we change the board to support a newer version.


Cheers,
Daniel

> 
> Thanks,
> drew


