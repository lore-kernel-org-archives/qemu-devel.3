Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE43C54F54
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZS3-0006Tz-47; Tue, 28 Jul 2026 00:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woZRz-0006Tl-Fj
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:29:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woZRx-0005XJ-Qa
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:29:55 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S46XnR1821214
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7mfV4RKJ0gYj3Dz0Wts9VsRZwebzCvI1ibFhtlKM1ks=; b=KE4faL6iyYyXiZQr
 zJgOgAWbuxjL3CXu0d1MAPHwx/BuXiUwxXDO08aLr6DEI63ybe7ZivR2jPXuQVWR
 oWObe2ak5V4mYsSftEE7m0sBqw7wlgpsy5+ewwQws+pnmxGTUAIzuj2n3uvDqMJu
 6GyHbvrfHPGI8f4vPw/a6svkQXyd/4AJFSX80dnzKMCfj1mSQPNVrbgLiPyOa8kn
 l8iVSYp0FqcjmmSaMsxiqQLgBzsx0I/KXZexaJeRFPnMmC/9b8Ao9HDBqx/FhMoH
 f5WUxan3UogD8MvDJa/tT/H6AGFfX/wSqwgh8JAdfQzxXrtUh7yrNHGcbVvW20f6
 drkIAQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y027w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:29:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0199faafso41368841cf.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785212989; x=1785817789; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7mfV4RKJ0gYj3Dz0Wts9VsRZwebzCvI1ibFhtlKM1ks=;
 b=EhaWyPHX+DnfJN8da8tkhdgmJKpU171t2vsKd4mGBQ4hFalyJMGjnV4nPNqUSf3sjb
 GEtt7N9QJ/ULY2p/MoYcvn+5yeibXearsbnRLwo5h9cQLlbCh8kh/PTpKqocOZXk4PRK
 UTX9i87L3tAZpJzvMze5w+dsSL/K2ttT1hW+w7n/MXQ8uBhOJDb3qaYtm448PJVYfxuh
 80zVlBk3uR2/ebW4DMdbX0k4NVumpJ7+3y2xcOKDSh2vd3UHkcMX2l3bSZlfdZ97KjsL
 ZIl00RLBq8nQnOHyFkFt9dWuMFcwehiXVn1tzEcHOdscocjwTAwG8tHLaM+kzGeiglWI
 B9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785212989; x=1785817789;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7mfV4RKJ0gYj3Dz0Wts9VsRZwebzCvI1ibFhtlKM1ks=;
 b=jQqblaCzT1oNbYZr8a1xvHt8wijPPkl86tvtYk4oZgq3p8BAL+/+wq5zo++4Pot6iZ
 iZbaRHepr76oOIwdcKKUXOt8bDpQ6z9qnaOvHvVWjIRuMEwOjfghfwp0zvFbgQW+Cgui
 +6w5riLwMrAH3LkyCJgokG1+ZFvq+M87b0hT5Qd8PdWWDXG6FamwzTZeVxdGWw4JH8xB
 m9iDqhaZa2603x729LkCTiavLv+rYrbQ7UPcN91gEkHBIr1d/afrC+soMN6joVvopIk+
 orxS9gZ+YKc3tcbZ/Ty3UU6m7GIpd32iUfUlAzR8jocRuelsYlaBBeyGGVH+mHF2YO5i
 nCKw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpg/YvqeXvTYbeDcWsflORBqULLnUB1UN9XOxA+OKqtR+SMEe90MsFT6vHHjY2LEmBe4fFtXMlTyJNN@nongnu.org
X-Gm-Message-State: AOJu0YzzaTgPIa7N+hk1dubqY6uRAiXkFOdaSGDU8brDdmq2gzoOfc9n
 Iyopjqsat3MTpUEZWpuuPv5FVUFzyYPWWS2DSHiat+XbzZ7A9DKRkFoc4ymmBPbGTO3NsZr+UXC
 xkwxUfp8DEhgu+Lifzii8mzz0EGOPwTbCz5uF5UH8MpEwCB5IndWhU+BMCw==
X-Gm-Gg: AR+sD11p3seKq2ZHY2vmdiYamYYj86TVUD4VIVxK/PPFDhDBEZBP01kthtsyCfoCXRF
 WYYdGrJcbOQfJlntAS4LLI0oZt0Paqu67QpMeaNhWeB82rUHRqNORkDSqJu2ZY7YVoQ9HDm1+bN
 c+fMyxwS4R9KolG+D2Quh+SLi44OIWHfvA/3FtlBXfExW6ox/2FHpj+z0Z8ey2PT6AucXDKjrBS
 ssaUlcvNOvBC4DY1I3esBMobmJ+WDWklV2ZhQDlvQPu2bXVMS9Ksi+bHKI9FSD8ORsqptwDvZRm
 pIAxru/yi/yAZdyeV8sKtQtJXbeq9Nbke+tvyBnC7mOq+smh7+jR9K/2upjzBs1mgtvt4aYRJfr
 ilpe3VJkhuSdm9Ffic8P7L7IpX2AO4tUDMF1JjOh7UGMst+kakrw=
X-Received: by 2002:ac8:7d02:0:b0:521:987f:bf34 with SMTP id
 d75a77b69052e-529d72125cdmr5434531cf.61.1785212989274; 
 Mon, 27 Jul 2026 21:29:49 -0700 (PDT)
X-Received: by 2002:ac8:7d02:0:b0:521:987f:bf34 with SMTP id
 d75a77b69052e-529d72125cdmr5434381cf.61.1785212988786; 
 Mon, 27 Jul 2026 21:29:48 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44b84edsm67604605e9.5.2026.07.27.21.29.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 21:29:48 -0700 (PDT)
Message-ID: <14b0818d-cffb-4648-bd42-560361822f95@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 06:29:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/sh4: allow full 32-bit address space
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260727114848.1041856-1-laurent@vivier.eu>
 <877be8fd-af97-4f68-b4a4-31201334c96c@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <877be8fd-af97-4f68-b4a4-31201334c96c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a68303d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=cplnpDx6AAAA:8 a=yFfpETEzUMEildScezgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=bHwCOBSOUrNypjIvOSWD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAzOCBTYWx0ZWRfX5cubaXJLTMeJ
 nJXOG93u7N29WjDZZJQQMdHpfkfUQ+clZsrvWNeU3mjOBaehizcRU9QO3WeOVbksxTWW00mMmca
 mTQZd/ZgATLoOQ9hz37ZioQHIEEyWAY=
X-Proofpoint-ORIG-GUID: E2a8cQLXAsIqYQiEeAzjbb4rtFO8irEX
X-Proofpoint-GUID: E2a8cQLXAsIqYQiEeAzjbb4rtFO8irEX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAzOCBTYWx0ZWRfX/NHPo+F8LK3w
 nRnBa0SrYkF3UxTfbZEsMxmnvDScxlXtRhaW3lPF3S72iZW2b+lC76F93hdIWJ2J4uHsa+3QVpm
 Ju9o99/CLpUk76ZcpAFnq4q1MMnjFWqPJEWzX175A5pTC+PiaAFxSCAWHwJ5fYEGFFgvnTsgzrZ
 hbJSsxkvMvMcJC+7mebvv7CJ2h4selHv4rt90M/L1oBeQ6EyhwJesXFAqdtHsYns61KrbGyl1kq
 YD7TyCYndO2IZ2YCFMcWYNiQMHfn8GqiLk5iJkc2uQtJWQfC/QdY5qgce+3VA6pt9OGGGZarico
 bJdXioOS+O5TLAt1lSPDxcNfzDS1BqyqIAYRedq+h4FJ0u+D0lhUTB9PinXzcUOihiDphTy77mu
 CplnJpfBPbvw4peg7nt/dG1CoqCMAZckkmmrCTziuuzNDMKzEflJEpIP93ZBG+7x/KaML28RYNT
 ZFOninJSe2IdOzm3J1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280038
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

Hi Laurent,

On 27/7/26 18:51, Richard Henderson wrote:
> On 7/27/26 04:48, Laurent Vivier wrote:
>> On real SH4 hardware, the address space is split between user mode
>> (U0, 0x00000000-0x7fffffff) and kernel mode (P1-P4, 
>> 0x80000000-0xffffffff),
>> so TARGET_VIRT_ADDR_SPACE_BITS was set to 31 for CONFIG_USER_ONLY.
>>
>> However, qemu-user does not emulate the MMU, so this limit is not needed.

             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ [*]

>> The only effect is to restrict reserved_va to 2 GB, causing OOM failures
>> for memory-intensive builds (e.g. webkit2gtk on Debian sh4 buildds).
>>
>> Set TARGET_VIRT_ADDR_SPACE_BITS to 32 unconditionally, like most other
>> 32-bit targets. Also fix the TASK_UNMAPPED_BASE macro to use 1ull instead
>> of 1u to avoid undefined behavior when shifting by 32.
>>
>> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   linux-user/sh4/target_mman.h | 2 +-
>>   target/sh4/cpu-param.h       | 6 +-----
>>   2 files changed, 2 insertions(+), 6 deletions(-)
> 
> So, the goal is to run things under qemu-linux-user that can't run on 
> hardware?
> 
> I'm not necessarily opposed, though there have been software systems 
> that know that the upper bit is unused and reuse it for tagged 
> pointers.  Emacs did so, sometime last century.  I'm sure there were 
> others.  Anyway that's the reason we currently limit qemu-linux-user 
> like the hardware does.
> 
> If you're going to drop that, you might do this for all targets:
> 
> mips/cpu-param.h:#  define TARGET_VIRT_ADDR_SPACE_BITS 31
> sh4/cpu-param.h:# define TARGET_VIRT_ADDR_SPACE_BITS 31

If so please add a comment ([*]) around these definitions.

