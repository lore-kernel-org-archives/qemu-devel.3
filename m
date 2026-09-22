Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD54C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94Ut-0008FQ-VD; Tue, 22 Sep 2026 13:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x94Un-0008FB-8C
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:41:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x94Uk-0007de-Sm
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:41:33 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEjmev3952789
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 17:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wBLbn/6KKDZBWhGFMJ2mCl5kFypdja1aDX4n1b/Bo5g=; b=Ys8OhAU3jPSRR7Ck
 Di25+VvXo9mW8fTyrSboEVYPPcrSsiv6WMkouWcixyznN5y53yFInxZ/6JC9US7z
 qmyh5KlmaUfsg0DNUB1Pulf9KbYkEftpuSOmXz/12F6CNJK3CR6JFfZCYzFd8F/i
 8AhTMDFOiBdSmgNBjSFOorHdEVZK0pQVMDi3GKmnvrAJ/WuK+uO+VbU8pnkrEWEj
 vUJ7p7GtYj+vwqdWDvOKAsJRiuL94SME28ObUUTmvSl2cM7zWW+JWC2z723nN/7O
 OdPtkic3Vne/64a8vQF35mhKFZQ90MbmOj/0TiwYw2yh7GkLGpfr09kUXmJ1EZm1
 /kesxQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufsqbxt5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 17:41:28 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-78fb21aaad9so102793137.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 10:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790098888; x=1790703688; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wBLbn/6KKDZBWhGFMJ2mCl5kFypdja1aDX4n1b/Bo5g=;
 b=Hzu0VlobYieWtkifqF68a6+nBj+ZVP1CIqj/g0CBSoNjHsTe+EPirRBkqco3MAHcsL
 4EQSfdVkwhSwNi3XWMwt6Rfv0TVQMjX4BOxQBWlsuOLYXD6tAVEtSvAArOzoVCBlYUXI
 jYx7unhrK1PQ/1ZsbjsdnWbsTpVAqYNqu8nSypUvrPnXfGNDkqsX/nFMcp7mDLmQtJFe
 1NWJt3E1/8ZF++vTWo6CYENIWOqusd6tcdEVG25QaHpvQMcyzkJIxhXkDrY3AhoUDfxP
 EQx1q0hb5zqcwxqkliOj4PsH1AmptTtFeJUgjTkJa7GAQJs9sXyWHkrT2embyySWCpTt
 AiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790098888; x=1790703688;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wBLbn/6KKDZBWhGFMJ2mCl5kFypdja1aDX4n1b/Bo5g=;
 b=bnZczwcWuEyQPsFIEyBNYmmfwnqi/HJosXZ1ptGEaANMBIkYdZAii/ayxNMh72Tg3g
 OXBfkcII7+z7sDImww3QVWSaSoslifer2e9Uad8HMMgkWSgjlVAmZMV+srAQ9GgVyEqT
 Xf0jUhiXD1TwojFqChlggDq8nNqt28zrQBZE/tTkyfHoeTWy2GBcEceoAJlr5Zu63IOE
 nSUt2l8GESE3ti+S+iRrBXEXj5u/BkNk4kSmcUgd6WP+BAdGGoLB4S6ROXzvuaewTARs
 E1qE2BYAlIczcBrCvV/H1f/YfJKAGdQzfvaaonJmUxbdgdNxxuuNdoiwcmmDHb9JA/4M
 GThQ==
X-Gm-Message-State: AFuF++le0K0WcK1wPYl68r7Te5J/t1SJQX86Ik+AvYHNt7hLGDmMOqEl
 +pwx17ZWJBPPkR+FykUDgR0SBXBaP4nvBvuRDKQ1FQ9uP2hSXG3ah0VlSqRvJWSe2GH6NO4EdSq
 Hl4wpWcwpTTdR6zzwWUmwAAp6mDEOX1n7X3NuwjBCjqaC6lGGm9/NILFehg==
X-Gm-Gg: AYBFou2aFWaSyRg+IEmFwUqXuM2YqhEzEuq9MFl42xADihyhp1/9P5KdHd11m5c6qiy
 7gt1mrA4AiCT2o/pPtKw7fyPml/ZqiAi5PsDDiaHyhRb8V2phJKikP4GiIU+4Mth38v3QUOqWqk
 OqinpWhO8ft3kAEttjTODtaoBMZ7/X+N+HSeQrN5CUsy+Rgxs+de8QpdZSo4I1Zf4QhjDn8WMKg
 4ny+6HC6M0Iz0HVEcuR0qIjQyP6jr05NsbNcWmk6oMsqdr/Fi5XF92vtILH/tGy1qQ/WrK4yMy6
 8DNLb3Ye3sPP8itKD1njatmkBfQl2hYQKRjXXA199DxkOgWaJgEeMfMHWgRUq1cyO8wFBP/LgFm
 qHiY7xauMOX6PoKaLuUw4
X-Received: by 2002:a05:6102:6312:10b0:7ab:9152:1c6e with SMTP id
 ada2fe7eead31-7ab91616786mr2073807137.27.1790098888403; 
 Tue, 22 Sep 2026 10:41:28 -0700 (PDT)
X-Received: by 2002:a05:6102:6312:10b0:7ab:9152:1c6e with SMTP id
 ada2fe7eead31-7ab91616786mr2073775137.27.1790098887974; 
 Tue, 22 Sep 2026 10:41:27 -0700 (PDT)
Received: from [10.251.40.67] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdab0c240sm46659535e9.4.2026.09.22.10.41.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 10:41:27 -0700 (PDT)
Message-ID: <c9515735-f2fc-41a0-99a1-8885a5dda73a@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 19:41:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] tests/docker/dockerfiles: refresh images
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
 <20260921231458.3369-3-pierrick.bouvier@oss.qualcomm.com>
 <4207d4f8-a452-417f-b240-77cef59b7d54@oss.qualcomm.com>
 <arKywfq6YHXxN8Ch@redhat.com>
 <039cb46b-90ba-40e6-bdb3-9812add2fc44@oss.qualcomm.com>
 <arK8UOJtGSxYpNtf@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <arK8UOJtGSxYpNtf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3zA-YUNJ2RPGlti8vW2RfP6h8QixfpX1
X-Proofpoint-GUID: 3zA-YUNJ2RPGlti8vW2RfP6h8QixfpX1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI1OSBTYWx0ZWRfX4yr90Rccq2ov
 AiCppCFv+0y48B79CHNn8jtKAnrYvI5QwkbCCnh3kW76E5A3AyH9XVsvjuAa7ZmhSUVNX+6VPqV
 tnakcnpoTRdUIIG/8vm4v9+T+hOacSY=
X-Authority-Analysis: v=2.4 cv=NKBAaE6g c=1 sm=1 tr=0 ts=6ab2bdc9 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=YPqRKA67QM5dgqA1zZEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI1OSBTYWx0ZWRfX9fdcQmTjsXdC
 UMAv1PGcC+uxyEJ6ENOkCkl5mhBg4OVAftXi1QKLZVE3x9V5zI5kHP8pEtAm8lr9YtXNV+adlqK
 t3WFrhEuX6fB3k1Gu+kxyTXY+30KH8TZ392h62a6gcrCJrG5bOE0XbD1sCkrutPDMzFF20ZVG7i
 9SGwvqSyov1Rzty9qZAD3hOj1e/Kahka370Q3jDZY85nLSrm6Hn5uL0Xmka0YvwV0AiBO1AopAC
 atFi5U1Quijr4dCuAmT0mYLsp8oOjEAjppBNznSrI7OG+Qq84iKXs9uUWXarkd3oncYBvyeHN83
 64OOmdWMFGpbiyRysgdNLZkHbVxuVjFM3l9xiQh7ivmGcM/MfDNCPQ9O0WHMT6HhqIXVBIgfWsQ
 RpSbf3lMwrZmVWqpomjckdt5ztML/ZWbGMmGJir6xPEGGhLNxPU6EIWaa2ul2H0I0qap9NHgDnq
 7kH0A/a/c9cSvYvU0jQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220259
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 2026-09-22 19:35, Daniel P. Berrangé wrote:
> On Tue, Sep 22, 2026 at 10:16:27AM -0700, Pierrick Bouvier wrote:
>> On 9/22/2026 9:54 AM, Daniel P. Berrangé wrote:
>>> On Tue, Sep 22, 2026 at 09:15:02AM -0700, Pierrick Bouvier wrote:
>>>> On 9/21/2026 4:14 PM, Pierrick Bouvier wrote:
>>>>> latest update of libvirt-ci changed packages, but images were not
>>>>> refreshed.
>>>>>
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>> ---
>>>>>   tests/docker/dockerfiles/debian.docker     | 1 -
>>>>>   tests/docker/dockerfiles/ubuntu2404.docker | 1 -
>>>>>   2 files changed, 2 deletions(-)
>>>>>
>>>>> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
>>>>> index 77869f71546..2d03ff03c8d 100644
>>>>> --- a/tests/docker/dockerfiles/debian.docker
>>>>> +++ b/tests/docker/dockerfiles/debian.docker
>>>>> @@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>>>>>                         libpcre2-dev \
>>>>>                         libpipewire-0.3-dev \
>>>>>                         libpixman-1-dev \
>>>>> -                      libpmem-dev \
>>>>>                         libpng-dev \
>>>>>                         libpulse-dev \
>>>>>                         librbd-dev \
>>>>> diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
>>>>> index bb8f4e4e53f..440699a5005 100644
>>>>> --- a/tests/docker/dockerfiles/ubuntu2404.docker
>>>>> +++ b/tests/docker/dockerfiles/ubuntu2404.docker
>>>>> @@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>>>>>                         libpcre2-dev \
>>>>>                         libpipewire-0.3-dev \
>>>>>                         libpixman-1-dev \
>>>>> -                      libpmem-dev \
>>>>>                         libpng-dev \
>>>>>                         libpulse-dev \
>>>>>                         librbd-dev \
>>>>
>>>> Dropping this patch, as it's incorrect.
>>>> In libvirt-ci, libpmem-dev is a dependency of targets debian-13 and
>>>> ubuntu2404, so not sure why it removes it here. Seems like a bug in
>>>> libvirt-ci itself.
>>>
>>> Most likely you ran invoked lcitool from an aarch64 host OS, so it
>>> filtered out libpmem-dev which is only valid on x86_64 targets.
>>> The non-cross containers we have defined here are assumed to be
>>> for x86_64 targets.
>>>
>>> We should change the tests/lcitool/refresh script in QEMU to pass
>>> '--host-arch x86_64' to lcitool, rather than defaulting to the
>>> developers' machine's arch.
>>>
>>
>> Thanks for the sharing the reason, I'll add this option.
>>
>> Out of curiosity, what's the reason to differentiate generation based on
>> host arch?
>> Wouldn't that be better to be explicit if you want to generate an arch
>> specific Dockerfile (and use FROM docker.io/arch/... instead of
>> docker.io/library)?
> 
> I'm not familiar with docker.io/arch/

IIRC this was not available back then when lcitool was started.

> but this all just grew up
> organically over time, and since most usage was x86_64 host based
> there  was not much need to think about other scenarios.
> 
> If we want the tests/docker/dockerfiles to be portable to non-x86
> hosts, then we'd need to either have many dockerfiles there for
> each arch, or drop packages that are arch specific from the
> install list.
> 
> With regards,
> Daniel


