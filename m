Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037A8CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 21:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC1hg-0000b6-0H; Wed, 30 Sep 2026 17:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xC1hU-0000ZY-Ra
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 17:18:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xC1hS-0000Wi-CG
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 17:18:52 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHeetn1198586
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 21:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UyDhz7kmP9qBlEDAjfkJDfc+P44sGwTwscBdz4N2QTw=; b=iYrVHNcbImlFl6t0
 bsOjbiaIpdjLa3qyxj772leTgC5v/ZX0uAYbYEzqmEIgVjJTJwFze0wWDC4VFm9B
 SXHP+aOBCJ1YwYSdizJD9LtRb3GxsPH+d7BCGIUKJLicLA6ZKOuXXDTivz7wh5lr
 mfv62I+YSHhLS3ZCK/h/at/sVYuo0mR4KbExJTvv90KUKRUeTvQurvmgCNC3bRj0
 6H10twoYjzU5j6CbSnWz+cVVrovthKDNuReJkb1Q7wzc8HoAzD5r8aL77W/YTox9
 +66CwJTe6gziB7gtf9uzv5x/2iPEk/KNTagoxvkQENKmpNhWgWrBPfG7qOjyDwY5
 g3KHCw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h136tj1u5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 21:18:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a3f673221so1569043985a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 14:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790803127; x=1791407927; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UyDhz7kmP9qBlEDAjfkJDfc+P44sGwTwscBdz4N2QTw=;
 b=fBdNbxIUdCjcNOYhMfdzdfTxwVeSi2bxS9CFmaj4Zh0n87zznXl17jGFYq8nouAKXJ
 Nk6tZKT3+Dyd6BieLta4zexMV3rJgF0LySXXlZrq3HOW71RoooO/rXXyTvgMTWO3djgx
 H2OGA69/jDZ0JTz1QbexrD9rSGwT/oUMqXAWzc2x+MCUTiwaiZSuKrE9+kYu8caEzjbm
 +tZYP19D2d1fMiCvNa/RgB50b6OlYuqLe8sCvNqQ2IQ32rDEDegV1xw3vUi4c1dGUnJr
 +7dF+WIkRG5LT7l1ZVDHXPchIuCswOW2cK8PF4aoeapEIl9wopiiiMK5YQB1xQyI/2vT
 lDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790803127; x=1791407927;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UyDhz7kmP9qBlEDAjfkJDfc+P44sGwTwscBdz4N2QTw=;
 b=QA28gT2scx1k3vV4ws22Jb+bw79+rlWc5urQAsRbqG+In7Py3m4qmskEavCHnXyGrR
 /lGdDg7Zu18OQOojIUyfKS1ecWjBX6kCC2Qprs/1JXxk/AiratZjFbfEZ+qIqquhBh0j
 t88sy9twYN/oWr+0vdUWU1eMNPzOZfCjeeHjTeywM+VdIlvk1ivrKmh3JLZ6LIAHSR1K
 sR56f1BDZ4jWd09CgTkaYw/havAK2HJYheJz+AMCXO2LM5Neb8OcJu/TlIi/sNaXWj+0
 kMTjuyV4t6z1LJMP2/ZaaCJ1XhHfBCOszZ2UGz85Vhe7yRdc/VrqO8vw4VgFHQkYB3be
 4IdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5Ticbyhm3zk5wEuZvNLrmvRR/LvicO5uif9xrd3fpLqcFkpEYFgXCsjnRm+NSCp+5WfaBgYP6yhrM@nongnu.org
X-Gm-Message-State: AFuF++kIm6dB9qvygVMn2S0idb+nwBUgQXOuG0CkZJdqU5fECtuZWXYl
 eYyRrjZ/aQSn+zhXSvGIunNHL8xeywAVNlVELKhF0jbIw3YJKo7Q1ZMYVGVM7FEyxUA3CkkXq49
 Fa8HBQiGW9EnXrbfaRE/yM77It6aRj02ShMdS3BJgTfWX8OVlA6Q0oMFtWQ==
X-Gm-Gg: AYBFou0Bl7OqDMn3YW8iS+i9VJj7EsoD8/R5jhzEg+s9BcbaP63LK0LIt5TSxcl2O+8
 lmx4p66hYIHtHCgosFvkhMkNEOPPaoBqsjKSJ/Bf2NbOOvrFQ41KaNFfXVIbplud9nofDKtzI1D
 UI9DoXbFbB4viOXl8Yhh6q0g9XD5h923SIysfbuCgKCiCJ9hVgeuQUgLjFQc5eRxR7bjL39KVq6
 RsFfzNqHmZb+E6NeawgS8ltIUZG6M3PPTd/6Z7ad2cTWqN6pXepVC8uXuFxTwjsFllu5c2N/1S4
 Kk4tjmlcmrQW9iabxFBeO0qeYerHEsR2I9GnBBdlo6O8/F28/f+6zXOswAbXW8hRXLEJt7xAc+n
 CX21zjYV6iPiTRLt7ayRWAKlxUCAjsv4yCQ==
X-Received: by 2002:a05:620a:27c3:b0:937:1097:feb8 with SMTP id
 af79cd13be357-93ca96c5f73mr443318485a.24.1790803127187; 
 Wed, 30 Sep 2026 14:18:47 -0700 (PDT)
X-Received: by 2002:a05:620a:27c3:b0:937:1097:feb8 with SMTP id
 af79cd13be357-93ca96c5f73mr443313285a.24.1790803126410; 
 Wed, 30 Sep 2026 14:18:46 -0700 (PDT)
Received: from [192.168.68.100] ([187.10.234.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917a8a2feedsm9077566d6.33.2026.09.30.14.18.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 14:18:45 -0700 (PDT)
Message-ID: <19ec18d8-548e-469c-ad03-6d47380cb6dc@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:18:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/24] target/riscv: gate riscv_cpu_update_mip with
 tcg_enabled()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
 <20260703180538.3346781-17-daniel.barboza@oss.qualcomm.com>
 <fa90ae0b-3846-45e0-beba-269fc2423f6b@oss.qualcomm.com>
 <0d4948b7-21f7-498d-b198-66ce4b7c51f1@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0d4948b7-21f7-498d-b198-66ce4b7c51f1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA4NiBTYWx0ZWRfX6ePIhSxvurYq
 417W5s0Dwa7pK8FoqrDEgvaUFbwvteu5Bk7bIYeFv3tnuH/QeOG/3reBXN/Ta2PTIAzPMao7Yom
 ZRTC+P6/SLyRKSdOdhUV3q8mtJgP6es=
X-Authority-Analysis: v=2.4 cv=aPFlOr9m c=1 sm=1 tr=0 ts=6abd7cb8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=jbqyKmyYbxlRs/MVMa3Ccg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=qJD6E9i2tIaHFd1jSFQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: g6XrqxYjYbRZVOXAmw4_auHezM98Q0v-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4NiBTYWx0ZWRfX30ZqxOzE/0qo
 1tBC185bQlZ7CUWhkfeYzblg7blx/jmgdje1UgLAi3ChULP4a7oX/riFAZwBU4dlheGDCvv9LO1
 +3W3Bqd91iX+Mm5VancpybMtAdx+Rtcr2jhltXbqDti7+Cs0EOSLrwm362eOpTvwoZMVQH7Yp6i
 9+84OOGoUAvZle+ydZ/1ZbqjAP4WZ05qINjCzFNUKDTSoLUb0DIriOmlSAQc5Al24GuK6fGsOlC
 ezYw/36gF48BnP2W2iyhsEu/JuX/gIxibalbJbf9MnROJasOHP3WTB4JPv2r5g9WLNqYy/AtPff
 yWj4BURZF7iWQhfT7DpneABmb7rji6iLn74RyyN0ICxyvhe4R8xOhsRpkjOzBUm08bcsj3y0+eC
 MSNtfOkJUIhuTcZeE7ObEssareAKJkZnofxDp0ueYmg0+juuFkHFPo2Ernu0OfTrbqU6fktowJ9
 tadYlmXR/eZlgeVU11A==
X-Proofpoint-GUID: g6XrqxYjYbRZVOXAmw4_auHezM98Q0v-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300086
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



On 9/30/2026 10:32 AM, Philippe Mathieu-Daudé wrote:
> On 30/9/26 15:16, Philippe Mathieu-DaudÃ© wrote:
>> Hi Daniel,
>>
>> (committed as 6c91b423a9a4dac2a22629491f2a3059aa40b954)
>>
>> On 3/7/26 20:05, Daniel Henrique Barboza wrote:
>>> riscv_cpu_update_mip() is a TCG only call.  Its KVM equivalent is
>>> kvm_riscv_set_irq().  cpu.c gates the KVM only function with a
>>> kvm_enabled() check, making it unavailable for TCG only builds.  We need
>>> to do the same for riscv_cpu_update_mip() otherwise a KVM only build
>>> will fail because it doesn't know what this function is.
>>>
>>> Use tcg_enabled() for the couple of riscv_cpu_update_mip() calls we have
>>> unguarded in cpu.c.
>>>
>>> We have way more calls to deal with in time_helper.c which isn't using
>>> kvm_riscv_set_irq() at all, so create a riscv_accel_set_irq() local
>>> helper that will choose whether to use the KVM or TCG API.
>>>
>>> The reason we're going through all this hassle in time_helper.c is
>>> because hw/int/riscv_aclint.c uses it, and if we don't do something
>>> about we won't have riscv_aclint working for KVM.  Whether this is a
>>> real problem or not and we should remove aclint support for KVM is
>>> question for another day.
>>>
>>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>>   target/riscv/cpu.c         | 19 ++++++++++++++-----
>>>   target/riscv/time_helper.c | 33 +++++++++++++++++++++++++--------
>>>   2 files changed, 39 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>> index db18c52656..6b79dcc5ee 100644
>>> --- a/target/riscv/cpu.c
>>> +++ b/target/riscv/cpu.c
>>> @@ -1343,14 +1343,18 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
>>>           case IRQ_M_EXT:
>>>               if (kvm_enabled()) {
>>>                   kvm_riscv_set_irq(cpu, irq, level);
>>> -            } else {
>>> +            }
>>> +
>>> +            if (tcg_enabled()) {
>>>                   riscv_cpu_update_mip(env, 1 << irq, BOOL_TO_MASK(level));
>>>               }
>>>                break;
>>>           case IRQ_S_EXT:
>>>               if (kvm_enabled()) {
>>>                   kvm_riscv_set_irq(cpu, irq, level);
>>> -            } else {
>>> +            }
>>> +
>>> +            if (tcg_enabled()) {
>>>                   env->external_seip = level;
>>>                   riscv_cpu_update_mip(env, 1 << irq,
>>>                                        BOOL_TO_MASK(level | env- >software_seip));
>>> @@ -1377,9 +1381,14 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
>>>               env->hgeip |= 1ULL << irq;
>>>           }
>>> -        /* Update mip.SGEIP bit */
>>> -        riscv_cpu_update_mip(env, MIP_SGEIP,
>>> -                             BOOL_TO_MASK(!!(env->hgeie & env->hgeip)));
>>> +        if (kvm_enabled()) {
>>> +            kvm_riscv_set_irq(cpu, irq, level);
>>> +        }
>>> +        if (tcg_enabled()) {
>>> +            /* Update mip.SGEIP bit */
>>> +            riscv_cpu_update_mip(env, MIP_SGEIP,
>>> +                                 BOOL_TO_MASK(!!(env->hgeie & env- >hgeip)));
>>> +        }
>>>       } else {
>>>           g_assert_not_reached();
>>>       }
>>> diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
>>> index 400e917354..ede1a4c2a3 100644
>>> --- a/target/riscv/time_helper.c
>>> +++ b/target/riscv/time_helper.c
>>> @@ -21,19 +21,34 @@
>>>   #include "cpu_bits.h"
>>>   #include "time_helper.h"
>>>   #include "hw/intc/riscv_aclint.h"
>>> +#include "kvm/kvm_riscv.h"
>>> +#include "system/kvm.h"
>>> +#include "system/tcg.h"
>>> +
>>> +static void riscv_accel_set_irq(RISCVCPU *cpu, int irq, int level)
>>
>> Revisiting this change, riscv_accel_set_irq() is confusing.
>>
>>> +{
>>> +    if (kvm_enabled()) {
>>> +        kvm_riscv_set_irq(cpu, irq, level);
>>
>> kvm_riscv_set_irq() expects IRQ number and level,
>>
>>> +    }
>>> +
>>> +    if (tcg_enabled()) {
>>> +        riscv_cpu_update_mip(&cpu->env, irq, level);
>>
>> riscv_cpu_update_mip() expects a MIP bitmask and a value.
>>
>>> +    }
>>> +}
> 
> For now self-documented as:
> 
> -- >8 --
> Author: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Date:   Wed Sep 30 15:22:48 2026 +0200
> 
>      target/riscv: Clarify riscv_accel_set_irq() arguments
> 
>      Use per-accelerator locals to make the differing conventions
>      explicit: TCG takes a MIP bitmask and value, KVM takes an IRQ
>      number and a level.

Yep, that's a fair description.  The logic was withdrew from existing code
in cpu.c and other places ... back then we were doing TCG code first and then
sprinkling KVM bits on the top.  Ideally this common IRQ helper that translates
between KVM and TCG would be used since the beginning, but yeah.




> 
>      Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 

In case you want to push this via your tree:


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
> index ede1a4c2a34..85f3f2760b5 100644
> --- a/target/riscv/time_helper.c
> +++ b/target/riscv/time_helper.c
> @@ -27,5 +27,9 @@
> 
> -static void riscv_accel_set_irq(RISCVCPU *cpu, int irq, int level)
> +static void riscv_accel_set_irq(RISCVCPU *cpu,
> +                                int irq_or_mask, int level_or_value)
>   {
>       if (kvm_enabled()) {
> +        int irq = irq_or_mask;
> +        int level = level_or_value;
> +
>           kvm_riscv_set_irq(cpu, irq, level);
> @@ -34,3 +38,6 @@ static void riscv_accel_set_irq(RISCVCPU *cpu, int irq, int level)
>       if (tcg_enabled()) {
> -        riscv_cpu_update_mip(&cpu->env, irq, level);
> +        uint64_t mask = irq_or_mask;
> +        uint64_t value = level_or_value;
> +
> +        riscv_cpu_update_mip(&cpu->env, mask, value);
>       }
> ---
> 
>>>   static void riscv_vstimer_cb(void *opaque)
>>>   {
>>>       RISCVCPU *cpu = opaque;
>>>       CPURISCVState *env = &cpu->env;
>>>       env->vstime_irq = 1;
>>> -    riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(1));
>>> +    riscv_accel_set_irq(cpu, 0, BOOL_TO_MASK(1));
>>
>> In particular I don't follow what irq=0 is here, IRQ or mask?
>>
>>>   }
>>>   static void riscv_stimer_cb(void *opaque)
>>>   {
>>>       RISCVCPU *cpu = opaque;
>>> -    riscv_cpu_update_mip(&cpu->env, MIP_STIP, BOOL_TO_MASK(1));
>>> +    riscv_accel_set_irq(cpu, MIP_STIP, BOOL_TO_MASK(1));
>>>   }
>>>   /*
>>> @@ -48,6 +63,7 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
>>>       RISCVAclintMTimerState *mtimer = env->rdtime_fn_arg;
>>>       uint32_t timebase_freq;
>>>       uint64_t rtc_r;
>>> +    RISCVCPU *cpu;
>>>       if (!riscv_cpu_cfg(env)->ext_sstc || !env->rdtime_fn ||
>>>           !env->rdtime_fn_arg || !get_field(env->menvcfg, MENVCFG_STCE)) {
>>> @@ -63,6 +79,7 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
>>>       timebase_freq = mtimer->timebase_freq;
>>>       rtc_r = env->rdtime_fn(env->rdtime_fn_arg) + delta;
>>> +    cpu = env_archcpu(env);
>>>       if (timecmp <= rtc_r) {
>>>           /*
>>> @@ -71,9 +88,9 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
>>>            */
>>>           if (timer_irq == MIP_VSTIP) {
>>>               env->vstime_irq = 1;
>>> -            riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(1));
>>> +            riscv_accel_set_irq(cpu, 0, BOOL_TO_MASK(1));
>>>           } else {
>>> -            riscv_cpu_update_mip(env, MIP_STIP, BOOL_TO_MASK(1));
>>> +            riscv_accel_set_irq(cpu, MIP_STIP, BOOL_TO_MASK(1));
>>>           }
>>>           return;
>>>       }
>>> @@ -81,9 +98,9 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
>>>       /* Clear the [VS|S]TIP bit in mip */
>>>       if (timer_irq == MIP_VSTIP) {
>>>           env->vstime_irq = 0;
>>> -        riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(0));
>>> +        riscv_accel_set_irq(cpu, 0, BOOL_TO_MASK(0));
>>>       } else {
>>> -        riscv_cpu_update_mip(env, timer_irq, BOOL_TO_MASK(0));
>>> +        riscv_accel_set_irq(cpu, timer_irq, BOOL_TO_MASK(0));
>>>       }
>>>       /*
>>> @@ -151,7 +168,7 @@ static void riscv_timer_disable_timecmp(CPURISCVState *env, QEMUTimer *timer,
>>>   {
>>>       /* Disable S-mode Timer IRQ and HW-based STIP */
>>>       if ((timer_irq == MIP_STIP) && !get_field(env->menvcfg, MENVCFG_STCE)) {
>>> -        riscv_cpu_update_mip(env, timer_irq, BOOL_TO_MASK(0));
>>> +        riscv_accel_set_irq(env_archcpu(env), timer_irq, BOOL_TO_MASK(0));
>>>           timer_del(timer);
>>>           return;
>>>       }
>>> @@ -161,7 +178,7 @@ static void riscv_timer_disable_timecmp(CPURISCVState *env, QEMUTimer *timer,
>>>           (!get_field(env->menvcfg, MENVCFG_STCE) ||
>>>            !get_field(env->henvcfg, HENVCFG_STCE))) {
>>>           env->vstime_irq = 0;
>>> -        riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(0));
>>> +        riscv_accel_set_irq(env_archcpu(env), 0, BOOL_TO_MASK(0));
>>>           timer_del(timer);
>>>           return;
>>>       }
>>
>>
> 


