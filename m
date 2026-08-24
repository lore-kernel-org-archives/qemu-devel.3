Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57234C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 21:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wycH0-0002xG-FT; Mon, 24 Aug 2026 17:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wycGy-0002wp-7O
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 17:32:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wycGw-00006l-HD
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 17:32:03 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OJGuWZ3319444
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 21:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dzQnOzwb1nQPU/Nx99dfwWTTBTH5Jzfqos7tjtAvz0U=; b=aLjdXnxuenrGeR98
 CoKAhQVBPXYodv4Hn+z31OnR3FZtyb+Mg7z6J2NJpddKzv6GAouBeBKfIrAA1g8F
 VDLBnR6ZFaaDfnPB7uNnCXNgCxxxCJ3G8qyBDNRpY1KmLI2Lo6kA7L0hotc3dJ4t
 F9CNqzP6u1bVaQE6cOHZuX8T8isWgs4GeNMMc8A0xh0+zKYsivdqBhTG92sX2dhG
 pKzjKYx8cXcwEfxXppMgzWtrhjHIqCg7L9qYmujdHSNcoY8YNFYALuGSumMWOUmY
 eVTYyxTxtIH7oc2omh9FxmTV5YoQeqJEv3st7++/jwWHMiaOdPmfMgfNvhmOVCnr
 PwANUw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kdsjy4y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 21:32:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52d7b3b6aa2so51171371cf.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 14:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787607119; x=1788211919; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dzQnOzwb1nQPU/Nx99dfwWTTBTH5Jzfqos7tjtAvz0U=;
 b=g9LhiwF5mZiDKLZf/FhX/ernx9wpEVomKThe2/ZxCAUOkQ1daPEOZYisHjQDWRK9Jn
 gmw9JmJQl2EXq6tJvPqMFfIkfbdqEW7xS5ggpOHVZP3BxBRTVkisiU90E3DxM/m8Nrn4
 hRogQWrbd+LxPRdpBSNOsojRnQpdmEN6/NcRyPvj1O1MjsjzrEpBq27A31orS4hwFWLw
 pGLoL4V+XO460TqfHKl5DGeL3Cq2Yx6/P7EIUh92NOvis9hzPz6X1WTmaV8M2jkYe26s
 K/fYyzvrGmJpTLDaK1KM9q0Nju+bDtZZXYfEVcRdaul9yF3Wg4RaGSc4y2bjpYpM4gX9
 EWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787607119; x=1788211919;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dzQnOzwb1nQPU/Nx99dfwWTTBTH5Jzfqos7tjtAvz0U=;
 b=QQkqyRt0OFuc1eW2AE8/9IHDpSIeiHYRsoF+q0XjJLA8DAwEGZBVWu62aPTurmd1Eo
 jcQVHkS41ZJUJfIyCido/etOGWvKNetXClH2brLdjyPcyV0Vzst85nGdVPFo/cP7feBW
 KwybB175IA/VOOoIywlHjKm46MnMxUOk/Qh9mdraq85jrZ0mKHZhM5gKniapRJgmLyHQ
 +JhuQOtnr03bHNEkdwayTFZobyB9gmc9EWWhqXuYS2O7J8srkhSm1P5f6dkyuiDAC45V
 nSMiNUIW7+PuAh6jCaqYr02Z7rjuqkdj2HLzSUmyz4PncU4Z+h3QKYV+d6v0DXhTDDG+
 +kEw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGIyTVXZAfJEmMtTNMBYJ+y5JCm3CB9fzj6PnV4lML+6T16QhTVruOmkvn0ufcrFKVZUpEhZV9DE45@nongnu.org
X-Gm-Message-State: AFuF++kE1A+//sXuDQCQ9mfnAri4JggutYCgylGgaT5CoK/YwnKCutW4
 +tlpYNRX67vtXHlE8+J8JkYJxVMM6C5aVNyeabhBrN8h+ohIkfRtYqxi2xtxsLKkG2HfDwEtq8Q
 zOgPmJGOuNKsQPyCnwRWXh2Y8kNuXFvFWd9curqfv31/fWm5NKg0IfJikhg==
X-Gm-Gg: AR+sD121Ol6eq+1a910EtLtlHHg8ZBv483rdhOlFf5qdjs75uSuN/4+AWIoHkU/df1G
 W6mycUfPjLzs29khwnwoYaDqyN+wQxXAGuUaV7w1y/rNftJS5iR7294P3kUq+MP5XHzVj92Q5pP
 0l7AkZUSs/qMH1n0s8iA22qbPA0OepmwO6cY/+vWTpm1Kw/LP34GuP3rOA+SsvwoIQMHqYddYyi
 zalxGJ0Odh1DaxOrNTkA5IhVmVLAy95qJYi4l1poXEmbYObzWgp61tjjxjGgtWNhM7+WiF0z9z5
 sNzaeTLwmK5GB13G3sX8oNEaO1FxEOvTw8NW5WmvT5WpFpZism7UoDvBCX50TvEkFreDr/eX01z
 Unemp1/Ykli5r8LKQzPmO4H0NxXObfjlSoHOAkz2mEM/xBHb27m4=
X-Received: by 2002:ac8:5c82:0:b0:51c:20:aea7 with SMTP id
 d75a77b69052e-52df56da609mr322061261cf.9.1787607119566; 
 Mon, 24 Aug 2026 14:31:59 -0700 (PDT)
X-Received: by 2002:ac8:5c82:0:b0:51c:20:aea7 with SMTP id
 d75a77b69052e-52df56da609mr322060751cf.9.1787607119166; 
 Mon, 24 Aug 2026 14:31:59 -0700 (PDT)
Received: from [192.168.20.232] (82-66-243-121.subs.proxad.net.
 [82.66.243.121]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9bfd8d9sm9363469f8f.20.2026.08.24.14.31.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 14:31:57 -0700 (PDT)
Message-ID: <86112e29-c60b-43be-98a7-db2030640323@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 23:31:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] accel/tcg: Make halt-to-exec transition explicit
 and remove cpu_exec_halt
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <b5b003cf-0997-48c2-adce-3632bba01f12@nutanix.com>
 <bbd002b8-c4b3-40aa-b25a-87a101293dc2@oss.qualcomm.com>
In-Reply-To: <bbd002b8-c4b3-40aa-b25a-87a101293dc2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfXzsSW6vFv/Kz4
 mqD5e4/Vw9W/OZqM792Ehtwn0qljTLlfzwQ4fZXn+x3xUz2SmLa6oErK7LaHuzjoWrz15VzeNtE
 /LM1M/Ko8uCzv7XY9KxXRHy26VjqSVA=
X-Proofpoint-ORIG-GUID: Os1R4HEO8Jo8g4UL1qN5_YhJ9vU903Hb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfX/c/heGu3JjyE
 EwePNxwCdXVuzxvRPP1l2aXRaV/7txRQ6Xox6/IQyfr0Whtjw4WkC1u5LUFcwtQgY95F7GSlOI4
 GcJvRxdMUbt/OJ613dfHWnrWzBJyKJDD7JAeeL3WYfmMUfpW+HRTiRmSdc1SnG8fduxCsbgOVgX
 DTujLrRizsrhjJg43fBg3vK6DKHnh12yxC0WGgfOwyrlIOCwpoSajO+JLxGUBvy5mSybrT7qb7S
 e6GxNkqTB2QbLWoiFoocGdM+Bf6V8PSjJiPhev0U5Y7g2BadZnT9kAdFpNzAT7CHQhtU4AeRPaO
 sdookX1rXZD+ee7tkBIsAqz77L8FhbfevqfYl+z7ZhunZlWw528qC1wKoRgnCue35Q2VC/Ymm/d
 NT6qAvryDVbJeDYzp4AzorhX40mZdbmg/5VN4deIOSgAbxiqVoPDRfCjaQOL+Hlp65V64NiNjds
 JouCgbxoogN+4qU6fWA==
X-Proofpoint-GUID: Os1R4HEO8Jo8g4UL1qN5_YhJ9vU903Hb
X-Authority-Analysis: v=2.4 cv=d8DFDxjE c=1 sm=1 tr=0 ts=6a8cb850 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=lbskcjEx90pOFJH4cTSgiA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=Gxz13x8bFVTPj56d7QsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240182
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hey Mark,

On 20/8/26 11:56, Philippe Mathieu-DaudÃ© wrote:
> Hi Mark,
> 
> On 2026-08-20 11:26, Mark Cave-Ayland wrote:
>> On 19/08/2026 15:56, Philippe Mathieu-Daudé wrote:
>>
>> Hi Phil,
>>
>> No objections to the idea of the patch, however I do have a couple of 
>> questions:
>>
>>> This series was inspired by a previous thread on the list [*].
>>>
>>> Refactor the CPU halt-to-execution transition logic in TCG as
>>> something more explicit and composable.
>>>
>>> Core problem: TCGCPUOps::cpu_exec_halt callback mixed concerns,
>>> it checked for work, processed async events, and handled state
>>> transitions all in one place.
>>>
>>> Solution: introduces two dedicated callbacks:
>>>
>>>    * process_async_events(): Process target-specific async events
>>>      before checking for work. Called early in cpu_exec().
>>
>> Can you explain exactly what you mean by async events here in the 
>> context of TCG? Looking at the thread indicated below suggests this is 
>> terminology borrowed from KVM with which I am less familiar.
> 
> "asynchronous interrupts/events that arrive (from timers, other threads) 
> while a vCPU is halted"?
> 
>>
>>>    * transition_halt_to_exec(): Perform target-specific state updates
>>>      when transitioning from halt to execution.
>>
>> That's quite a name :) Would something like cpu_exec_resume() be more 
>> descriptive here (as well as keeping the cpu_exec_ prefix used by 
>> other callbacks)?
> 
> Naming is hard, I rather something self-explaining when reading the
> code; we transition the state but do not resume yet. Anyway what about
> .resume_halted/resume_from_halt/resume_from_sleep/resume_execution
> instead of .transition_halt_to_exec?

WDYT?

> 
>>
>>> This separation allows the generic cpu_exec() code to orchestrate
>>> the flow cleanly (process events, check for work, transition state).
> 


