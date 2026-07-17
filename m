Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5713C44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 19:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkoQQ-0001Ik-Lb; Fri, 17 Jul 2026 15:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkoQO-0001ID-QF
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:40:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkoQK-00033C-FQ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:40:44 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HHL3912535217
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RWxkIhMw5A48bKdXOjFXHBa4tUubWjUqQmfXc0yexes=; b=G+0yiYbZoy0jPVEl
 Ru/U/FXs4Ut7c1lHCqzDrqCa8eLdgEu6WJ/uu05Z/AXL4SBFhJNyHzOnQ4DSySBe
 5XxoB0UGoWOqPwIOsyzpiv0VcdjWzT3JRMV3GtOVcfKOo6297/b0z5SjnCVx057A
 ZOT438ythEW1JQVdTFtI6CapCULwpoZ8Rux2BakAh3biePlZWXuYpz1k6dKtOB/u
 kP2qfNRXMA/drMpAqZBxJUcPv4ZJ3mx4/TPlQdmcOoB1BaO1OKgvygiXjOP7oCFT
 cdqxgJw+Ym4b9ykUGWfrNLBL3n5AAiDiIqNHgPWg14rOfshWKG/ELmFWndvJooaF
 4/009A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffrqd8hw8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:40:38 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38127ae6b99so2530522a91.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784317237; x=1784922037; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RWxkIhMw5A48bKdXOjFXHBa4tUubWjUqQmfXc0yexes=;
 b=eP08KIYI4jFFemw7NVXQU7e9HfMxKDCURCywb3eDF6y3W+AvqfSDOUoghQBn8BR7qn
 3afnrtdpYq2utWDarj5me8mkYWWpBVF3/D1FVsOklYhpv8RRh2Lykm28zVGmMmZ275Kg
 AnEjysI1zzeU9SgXeCDyII/BDJds4WzgcVssSHoPWtvzquOuRvNS6a/GAsGY2p5J3fdE
 aYH9wtpB1pP5lW70eyovMswsiqk9eBRk8VCMzQD02UGmbymf5KvET5FHgKqq/uODkelX
 spemaZEbuFf3CCGrMNUGdNcaAnOH1cOSnDiFKGbLJ+V7HE8CAJfU0PQolPXDxxArVOZO
 KVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784317237; x=1784922037;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RWxkIhMw5A48bKdXOjFXHBa4tUubWjUqQmfXc0yexes=;
 b=Rru2XoWYxcKvKwpWxivqluwFDFg5D4Xm/7khQf12RmyM+A6BFgVDVyUv9AHIVwj+GK
 MTt8maKXGjQsBOlxRZLQD8Hm3uryYZ+egweUZhMuMo9GmOBheG1d4+iOSZbbu6uoUJBt
 XEiWaAm29rMuOTmfBdJQQXIwgxkEqfGmPAXFAW+Sx7kkjlu3/dxverlRCJm6qpjisDVN
 /4VZ7UMASC0yg335iGPy/JRPiLnJTVhL9LoFr/aHyXF6OfhoWuAQKTQIVW7gRxjfpr/l
 k58k8bBYhJwBs+8446VUqxjnWk4PtWrFiq9fLZsmbB2NovZx3IXrX7hGPwKgn5iwiZ6f
 Hubw==
X-Forwarded-Encrypted: i=1;
 AHgh+Roe0gzsnOAThFygv21tb5wwhB4cVDbAafosWAMVGOYRxGTo7sLNG+j1muh4sbVJUlQ8mEQOI9IHqvcq@nongnu.org
X-Gm-Message-State: AOJu0YzhDJt8ZbqyiiWDx9ILN5Huu9zRHLW35B7yZmNi9Ikqipxw3QZI
 PXehwDD4DIIb/dhS/0tBH9cwSPA21HBG/tp8k22GMmKnlUs4mVeEyPFEDU3LCXckIOot6BaEXA9
 Xmc+0aFKGzeDrCbwI3kSpLZnH2l2iIwJNziPwaQuM4MMFWdLpuR6H55PcGw==
X-Gm-Gg: AfdE7cl6M3IfNGyiTQpayHXgsW79uwYiyovoI2X4qmBAr+kMfjbFN2bwwwvuNKjHKo6
 CEjp1nG8mm9jZYL1pZYgrZV3unCqC6otdzhG8+yTwUknJx0vk0Noe56QhYRN/a7dqj7qwHa4EjZ
 KnDVIcnKjErpuh4z/ikHKKthqsLWJqXBJBS00JCyOjoLWregfMtJSTIs8vMua4HiJi2YRAoZbcr
 NKfv4gVDrT6RqIl+qBYFfwug1Hsqm/Sv7RhYiJMaOr8tpr8WQ6+2xZJ7oDmHOvFHum2E9V0SN9n
 D2cFMBLSXu++PR5n/ZEDH9cczejC7+CYfWHwmxEi9gwDJm/foPI/hIoeRKU9oKatmLw7eGuckls
 UXnufmeXPc9ISjZtKb52x+2ZNuZcZSVH65YCxtIatcHPTX4uuAC/NAmhTP3Nrf51N6By8
X-Received: by 2002:a17:90b:1fc3:b0:387:d9cc:7dc3 with SMTP id
 98e67ed59e1d1-38e3d2b11dfmr9559552a91.21.1784317237460; 
 Fri, 17 Jul 2026 12:40:37 -0700 (PDT)
X-Received: by 2002:a17:90b:1fc3:b0:387:d9cc:7dc3 with SMTP id
 98e67ed59e1d1-38e3d2b11dfmr9559528a91.21.1784317236988; 
 Fri, 17 Jul 2026 12:40:36 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2cd764fsm8240882c88.12.2026.07.17.12.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 12:40:36 -0700 (PDT)
Message-ID: <d3f85639-e6a4-4917-8300-d48a7852662f@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 12:40:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hw/vfio/listener.c: remove CONFIG_KVM
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Michael Tokarev <mjt@tls.msk.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-2-pierrick.bouvier@linaro.org>
 <c3a7cd83-7666-40c5-9baa-ebe64edacab6@tls.msk.ru>
 <3f98fbb6-16be-4de1-b9ae-6108f8f33b57@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3f98fbb6-16be-4de1-b9ae-6108f8f33b57@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: w6Z0tG-s6G16JC1KX72TpJKywklRv0dp
X-Authority-Analysis: v=2.4 cv=DbYnbPtW c=1 sm=1 tr=0 ts=6a5a8536 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=hJmSWdEuvZDX9NXYRS8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: w6Z0tG-s6G16JC1KX72TpJKywklRv0dp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIwMSBTYWx0ZWRfXyHwilkBhpRUQ
 OX2Sb70IGQGyzemOZ+/BYu4iuWZd6SnckY/AOXKpzShEjS2e1FjCEqEj4NAveFLU0XfP3o3OFLB
 glmJ3+jjUaD8tTZWoJpwLEY96Kz4rjA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIwMSBTYWx0ZWRfX9Su8GgQSHGBP
 JV5Gua8kFqc5xAk0OwWcmpWVkkqtlloXfGzvyUtGNOOUcp/WpCwuIQqerIPG+XFoEu8NgiTXZPc
 VsGajzih3edkA8duKi/q8QADil1rFRI7bH4KW7nWCebATLMjP6JRDBN/oDQIvDMTekJ3jPJFbWa
 evInntJa05L7f6bVhokyGrmFCbWrPxQdM8OMEcpf/G+KvvhdD9gvnxSXYLUFLTj0nSoEUXHDlbs
 o0ZzhksRIjsOVx4CuoAdYb8ehwYxTlSb5m3U9oKH3uIkTecs/5NNwTccPmWpzt2Oi4Q0O3UsggL
 YKMMlmnn8z47Y35+51ry5cTTm+gNQ1cv5YTPh+q3RMAaEEUCUamnyRhzG4xYlCpRQeD+6UdL3jD
 qBcF4I/vfnkIkVprPw3A55ZU1SaLXP7h1udmSDTLU00+A3buCiPWQf69u/QqaDx/f1dYUCcBfZ1
 iwGuXIri3A/ilHnlcnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170201
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 7/17/2026 12:26 PM, Pierrick Bouvier wrote:
> On 7/17/2026 11:51 AM, Michael Tokarev wrote:
>> On 3/13/26 01:44, Pierrick Bouvier wrote:
>>> Code concerned is under a kvm_enabled() guard.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>   hw/vfio/listener.c | 4 ----
>>>   1 file changed, 4 deletions(-)
>>>
>>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>>> index 960da9e0a93..31c3113f8fb 100644
>>> --- a/hw/vfio/listener.c
>>> +++ b/hw/vfio/listener.c
>>> @@ -20,9 +20,7 @@
>>>     #include "qemu/osdep.h"
>>>   #include <sys/ioctl.h>
>>> -#ifdef CONFIG_KVM
>>>   #include <linux/kvm.h>
>>> -#endif
>>>   #include <linux/vfio.h>
>>
>> This now fails to build on sparc64:
>>
>> In file included from ../../hw/vfio/listener.c:23:
>> /build/reproducible-path/qemu-11.1.0~rc0+ds/linux-headers/linux/
>> kvm.h:16:10: fatal error: asm/kvm.h: No such file or directory
>>    16 | #include <asm/kvm.h>
>>       |          ^~~~~~~~~~~
>>
> 
> It seems like it was unnoticed because we don't test cross builds for
> this platform. We can't guess something not tested is broken.
> Seems like it should be added to CI if we want to keep it working on
> these hosts in the future.
> 
>> I wonder if this is a sparc problem or qemu problem.
>>
> 
> QEMU issue.
> 
>> I don't think kvm has been enabled on sparc, ever.>
> 
> Right.
> If I'm correct, it should imply that vfio is not supported as well,
> which means that hw/vfio should not be built at all on this host.
> meson.build correctly adds files only when CONFIG_VFIO is set.
> 
> So you can a look at why CONFIG_VFIO is set on sparc64 host first. By
> fixing this, and it will fix the build compilation by not including
> those files.
>

https://gitlab.com/qemu-project/qemu/-/blob/master/hw/vfio/Kconfig?ref_type=heads#L5

```
config VFIO
    bool
    depends on LINUX
```

Incorrect, and it should exclude Linux hosts not supporting VFIO.
At least sparc64 to fix the current issue.

> For more safety in the future, feel free to add a sparc64 cross
> container (debian-sparc64-cross.docker) + a CI build job using it.
> 
> If you're stuck, feel free to ping for help :).
> 
>> Thanks,
>>
>> /mjt
>>
> 
> Regards,
> Pierrick


