Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5BECD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIUAi-0006j9-01; Thu, 30 Apr 2026 12:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIUAW-0006gi-RX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:23:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIUAT-0004gy-Dy
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:23:16 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UBkDUR1820572
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 16:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r9QrMadZHoVIDPqW5rXZUvwNTSOdS0LR9INo/HTKsQE=; b=NDknboNXhB0L2K8P
 EGoBXu/Pc1TBkgv+3oa58X5Q7zURFlQRqAksCfbBxdpW1tEc03FklSNuybZez5LR
 5/3Z7RRfXYH0YNitTJVEEzhjq01E+PXnhdC/kdncyX1yFk7uuVKpl2iNXkdmPW/J
 8zzNSZkkwW92PlnSVQbTEONhA9sZzDjYQQmOhGi8d3Cb2Sqo5TOGn29lrylUiJJp
 felujD5RRyHgZAks0TDYNKlJ0HpENRX75b2kkSYXs/JcYBqZVQOs4TlFtEYlgh53
 pGfN8e+/wbpEHPi8/eQJ6+cVhwu95/GpwTWT0uyQpGgGQluK2EatGvEocBS3GRxQ
 AYQnHQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv6gesa27-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 16:23:11 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12c66fdd4aeso2211108c88.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 09:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777566191; x=1778170991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r9QrMadZHoVIDPqW5rXZUvwNTSOdS0LR9INo/HTKsQE=;
 b=YMxW4umgercqwKllxX34cuH6RQ4exEhK6HfMCjY05URemXiywm1y3sEEL3AtbNnEst
 XHfDVcLBEAGuURGUPl8CRtGuTF2pvFWlsaL1HXDZoT2SsaEaAE5TTncpi/ZZkZi3n7jT
 zIXNGZfS9OCYu7DKSRSimYr3JUF6OjJVpkKPLW5L6fEShDVhtbUD/GqwHTaRA5mbRWcz
 ZnuT8dQv+OKtyFXlYDfsdw2of1mfH9vasFVZflKS+bH1L5xG98h1SvX/SBuF6rM4l7fA
 Th475Zdq9n51Xv35RIPFXGLbTiWt5ID7GH4MR7ovh6AUVkzG8sdbA2077bupUyQBtDcm
 LovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777566191; x=1778170991;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r9QrMadZHoVIDPqW5rXZUvwNTSOdS0LR9INo/HTKsQE=;
 b=XPAp0XbApzD2IDjHcQb0yN3fyVgLt519jYzuw8yra2SVYk5M6sNxbdR/3oVxcVTyEm
 3M8LAF/F7TPAaQ9GhFjO6oJItoPbjgcEV0/9EbeXRlvVvKMUnF3T5dbE7hBZcDL6PGUI
 Bcdu02Zxz+AFjvZnz0B7399zJlATwdj4dBUfydvsiNrgQZiwNiLeG/reCVcTbI2XddRZ
 4AYmhyOsVfGXfgBj4Aq92XJs6724qYxT/FBhmLAhrrDoWNyxOCJLq73inc1vfFQHUjJC
 knBh4e0ZL+mpvaQ5t6YuS1UcbcuqUUBrv0wpHzKfH8k0OjdUwl/jAmJU25dqQxKSik1Y
 xU1w==
X-Gm-Message-State: AOJu0Yxn4I7v1036XNw6VbMkGOF8I61hQgK8FH9LLfkmqxFiw5vUYwiT
 24HEWYEdssNmSwwPMKb3+0sQglLddqVmnjDGFafGiO/LAGeek+Wp6v1pTZIKYrfYhXfuFykN5GU
 6oarCdEPKSJtnwuU6nqGcqIQHiin3Mzngn4wgFjUUoIZMKGuGICn4xn5OXQ==
X-Gm-Gg: AeBDievfeTxeyTZH+wytcpSdLAkQ1d/QY5AasyDiFu797a3/3blFadlPaHvV+DS3q0W
 lQXWeQG1+Ta1GqiXa+rX/IeJPCpO1HRc/aFjAYc1mC4mWDQHpOWdNAch4n95d2Qa3Tc5EJp6sP3
 m4cmROUPuURnDZLhxshJGJXSuKfGzUN442YxQXAYKGO7HdeAK/gDagM4IJM5o7MPTwVbAENJTBJ
 17c5uyIv1xN6tRYuxuaSc04+rHL/vTKpmsgU2TGYeIqfqGMFd1WOGa8FpBPQWRq9Is4lJoxR+bh
 5suFE05PK4OhzdfluFnFtqU40ch+2yUiKSld5swjomUl87wsp33/p2xifoxWDiI0WVAL4KX12KZ
 qBqzRKCWqp6skm6ojhAAnactWPGm4s7Q5budwkVu0aPOlz/M6bRoJ8fG+liGB5r1HIlHIASw5BS
 VfX6PskysrojgplV/ZMqO/1VTD
X-Received: by 2002:a05:7022:394:b0:12d:b396:eade with SMTP id
 a92af1059eb24-12deac422a8mr2106268c88.3.1777566190936; 
 Thu, 30 Apr 2026 09:23:10 -0700 (PDT)
X-Received: by 2002:a05:7022:394:b0:12d:b396:eade with SMTP id
 a92af1059eb24-12deac422a8mr2106250c88.3.1777566190267; 
 Thu, 30 Apr 2026 09:23:10 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee38e71ccesm649243eec.10.2026.04.30.09.23.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 09:23:09 -0700 (PDT)
Message-ID: <4915e243-839e-405f-969d-3393efcd6e95@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 09:23:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] target-info: extract target_info() definition in
 target-info-init.h
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
 <20260430035626.3511676-2-pierrick.bouvier@oss.qualcomm.com>
 <CAMxuvayPtYgPobPaBMoZ7UaWNdWMdOwiVAeP9PkDv8HxE_ZaFQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAMxuvayPtYgPobPaBMoZ7UaWNdWMdOwiVAeP9PkDv8HxE_ZaFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=f6V4wuyM c=1 sm=1 tr=0 ts=69f381ef cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=6E8BPlxdP1DbhElWlgMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: rqh4gp3BfRyAgeyA2rRf8pt7BcIMV6mC
X-Proofpoint-ORIG-GUID: rqh4gp3BfRyAgeyA2rRf8pt7BcIMV6mC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE2OSBTYWx0ZWRfX9qyZvGKr6atR
 qh/DEbldEROtxcKp+t5PjBQzHzogRYhMBKiqP8Mk0YJyVIgBnrujN12Jq/EeGvw3gaxh71Cs6NN
 V89siUnJIAgqpHXLXshtADAKSA37H9E3KBg9jD25l/4jMgGh/Btpqmhdm15oDrr3X2vZIuV0q7r
 rLI74LCUK3Zfi7SrcewCeNguY+EZBQXcfIQxp3juw4CzEkk4IOfpXA7BKGkQ43mCU6gnHhF0oLx
 Rsc0dZ7sbiGHDeri9blB/O7HaEq3G3yZPOA1/IxZUZQa3zcphX7OGx6/PorDXRye09fUfBlCb7c
 mQt+HLmagnuekbQ7drVbH3E2dakLE1SJnfOLBE6mDtbarVeEFuUPv7Y2hAybIxpnRYY6QLxKNFT
 DT3WI+NPQDQHDd8Nu5miC+rpxSYU0B8RdqTLsdHh725BEDiByclSNGvKChYWfqZrIz7dDROkPfa
 eJwOlirQUTNqQa9f3ow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300169
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

On 4/30/2026 1:03 AM, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Apr 30, 2026 at 7:56 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> This allows us to prepare next commits, which will introduce qom
>> registration for system mode.
>>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  configs/targets/aarch64-softmmu.c |  6 ++----
>>  configs/targets/arm-softmmu.c     |  6 ++----
>>  include/qemu/target-info-init.h   | 20 ++++++++++++++++++++
>>  target-info-stub.c                |  6 ++----
>>  4 files changed, 26 insertions(+), 12 deletions(-)
>>  create mode 100644 include/qemu/target-info-init.h
>>
>> diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
>> index 82ccb575759..75d95b0e743 100644
>> --- a/configs/targets/aarch64-softmmu.c
>> +++ b/configs/targets/aarch64-softmmu.c
>> @@ -8,6 +8,7 @@
>>
>>  #include "qemu/osdep.h"
>>  #include "qemu/target-info-impl.h"
>> +#include "qemu/target-info-init.h"
>>  #include "hw/arm/machines-qom.h"
>>  #include "target/arm/cpu-qom.h"
>>  #include "target/arm/cpu-param.h"
>> @@ -23,7 +24,4 @@ static const TargetInfo target_info_aarch64_system = {
>>      .page_bits_init = TARGET_PAGE_BITS_LEGACY,
>>  };
>>
>> -const TargetInfo *target_info(void)
>> -{
>> -    return &target_info_aarch64_system;
>> -}
>> +target_info_init(target_info_aarch64_system)
>> diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
>> index 18940e51e55..73546fa5737 100644
>> --- a/configs/targets/arm-softmmu.c
>> +++ b/configs/targets/arm-softmmu.c
>> @@ -8,6 +8,7 @@
>>
>>  #include "qemu/osdep.h"
>>  #include "qemu/target-info-impl.h"
>> +#include "qemu/target-info-init.h"
>>  #include "hw/arm/machines-qom.h"
>>  #include "target/arm/cpu-qom.h"
>>  #include "target/arm/cpu-param.h"
>> @@ -23,7 +24,4 @@ static const TargetInfo target_info_arm_system = {
>>      .page_bits_init = TARGET_PAGE_BITS_LEGACY,
>>  };
>>
>> -const TargetInfo *target_info(void)
>> -{
>> -    return &target_info_arm_system;
>> -}
>> +target_info_init(target_info_arm_system)
>> diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
>> new file mode 100644
>> index 00000000000..9be06d8523a
>> --- /dev/null
>> +++ b/include/qemu/target-info-init.h
>> @@ -0,0 +1,20 @@
>> +/*
>> + * QEMU target info initialization
>> + *
>> + * Copyright (c) Qualcomm
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * This file is included by each file defining a TargetInfo structure and is
>> + * responsible for registering it.
>> + */
>> +
>> +#ifndef TARGET_INFO_DEF_H
>> +
> 
> missing #define TARGET_INFO_DEF_H
>

Wrong rebase, this was fixed in patch 2. I'll move it here for v3.

Thanks,
Pierrick

