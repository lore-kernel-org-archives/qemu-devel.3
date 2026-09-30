Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B92ACA5FBE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBuAo-0004wY-UZ; Wed, 30 Sep 2026 09:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBuAh-0004w9-SR
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 09:16:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBuAf-00039S-Q3
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 09:16:31 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UB7hCm2678406
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 13:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tK78fsl6wePWyA43qhexR80/gBvlggxK9VgAz9KuCyE=; b=nT/B3gufagMvM0zv
 umcODrrMT08XNECFJ3OypQKsb3YR6jCGlYwTDe97xi0pupEE99lMxmo+q19sM7SI
 n6AffYON57MLKlYu4dfVEwBwjfHp1x8B8/Clvg8AEWwN93em9XfHB0C+TBHNmTGj
 lFTawkpJlNaqms1usOdFDNC12uHucIkg6IxLmK9b0NhNUelY9jC3MHk9AnxIt8DH
 1vs6XNO555zYr7HFGjmL4QwQmiHEUVwdDlpXlyboA30njNNa2bblW7pS3Nc8qaQA
 7CK8t21YX9ERJHstGJmOCbN2UU2hjdHq49wDkjh82JvvJlMdcNLZxMBFTLn2ZfxF
 knYRqA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0smjjpjr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 13:16:28 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-988d5a1080eso446639241.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790774187; x=1791378987; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tK78fsl6wePWyA43qhexR80/gBvlggxK9VgAz9KuCyE=;
 b=FRR1XT92mgRIg6sgnu6hLERs/921r9LZULKEP/1U7AZLfRFVX4/wNpKYF1NMNtzzQ4
 fX2gVNkRNpB/R2NhWafueqFqHTazZJ+2iodXnhDcAOH/ncNVFc9042MsvrKtfCZm1aJY
 gvzjUkOfEcx8It6UVRZqUUZmlxdkLARkjfvq7036yFyJbAsqf18AMx05xJ5zGg86KC4W
 c+YIgaeeeZCIfAGbkUVZ/xpc53JtgH8v3LYDGVT6Sfjw6tuJg3oWvp/ATSZOK/jmczqU
 WngNmRaVIRBjubwZ0T634yQh09u0Cv4jPfJljJM5RA0r4p6W5wxWhFY5WKF1vYpDdX6n
 KnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790774187; x=1791378987;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tK78fsl6wePWyA43qhexR80/gBvlggxK9VgAz9KuCyE=;
 b=hf3IYts/U/zosYJ1iTYelPBpxHsLsd5Fs3ElCpJ3s8AzAHyTG0DjeJWjacvq50YI5t
 snEvMVqpGNcyLS2udVjKais4/8OAJAV/dBDopuasS7vs5ZCCrXsjidKzQPRcUWWFiYL3
 DvSPjJ1eBiiJTTCMkw32je4uNDvLU32kFJTcuIQIx+FoWRRXnJUzNyJcnkcTMIuIN2xi
 SjGbttnMD7S7ekqIbiBxLaB1Qbv26sR68ooWZJ0JVh7RlC9dUvrkSRaarPoICusHOD1u
 TwAuCFFxHZFzCM2xUwPBw3yG/YPaMD6cQWGV8jlSYFdiQFUVfk6D5RfKhCQM9Xv8sbsX
 XxDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFl1I8M7zWHEn9zhE6NZ//EEAQUgUO+LUBJA7tY/NZwbJ28oV3uT7fHuoaK2xL8TN3j/GNFMuTJNtV@nongnu.org
X-Gm-Message-State: AFq9FYLNwexBA6PmdON++iDBejtff1UGz5qk4agreNuszdbuTYZs8JgN
 7tY6coTn5HWsDVc3R7mpkWbCrH6GiuES0jB21Pfflkp1kLeoED1POo8D6CGPw9wHfWkAhoKc1Zs
 zU9M8qR008N8X+UNXqJkocZph8yzmmkxf8y9umZOmtcyIrhH+yoq7Lo7N2A==
X-Gm-Gg: AYBFou20EAsXJdVrcjGpWvmmTCi+iGePRmZ1IkiTPAiBcb8LmTJnHZZF/MWfo17dV8j
 BLtNTRpXeTUvh6Bo0pJtGYIha+JdEmvctMS7wpfGpyI6tIK+6038GdPQBa0w5Xm7tms5iN49Wa5
 fHqajDYiwn8OguUMcElT8slcc1UDwu/fLj1fCbtJscH3aA7siBi0C4AmYe+mxW0F/W9yRqsyDHo
 00wKBrhAku1Vr3i9NmwtFs0MAm6M3jHvHvWwMbuMKunSwy0KfFzK7j2wwyfVJZG8ZHKfkNDANHX
 p7nMznxXQV0A7id4Rn3m3mivnUBZmabRCiN/pQEq/EtogJb58IIP4UfLUVh6wnopyd/MSumc6Bp
 pXDvNSE9LB3gT6QNRcapvscOlVmKCns26zQ==
X-Received: by 2002:a05:6102:38c6:b0:7a7:ad9f:53b4 with SMTP id
 ada2fe7eead31-7be72ab7845mr406270137.7.1790774186932; 
 Wed, 30 Sep 2026 06:16:26 -0700 (PDT)
X-Received: by 2002:a05:6102:38c6:b0:7a7:ad9f:53b4 with SMTP id
 ada2fe7eead31-7be72ab7845mr406254137.7.1790774186317; 
 Wed, 30 Sep 2026 06:16:26 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01cd67d57sm3813805e9.2.2026.09.30.06.16.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 06:16:25 -0700 (PDT)
Message-ID: <fa90ae0b-3846-45e0-beba-269fc2423f6b@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 15:16:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/24] target/riscv: gate riscv_cpu_update_mip with
 tcg_enabled()
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
 <20260703180538.3346781-17-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260703180538.3346781-17-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1MiBTYWx0ZWRfX0RidvOEtDjUk
 bQ6XBYWTP/p4KuV7vYI+VqTiWsmmlnILOOa6Sv3D2oQiQTrBrkxDWgl+MVJZbOWR9cSOSrxTLFZ
 E+sMLMQh2syQaN+BXJ6EdL/NjjUjCv0=
X-Proofpoint-GUID: V3lplzKv4VJ3L07TQYNfQf1y7i8H7hUL
X-Proofpoint-ORIG-GUID: V3lplzKv4VJ3L07TQYNfQf1y7i8H7hUL
X-Authority-Analysis: v=2.4 cv=KfxHIgYD c=1 sm=1 tr=0 ts=6abd0bac cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=tpsF0DDknoKtsVgG9ZQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1MiBTYWx0ZWRfX8WzXcZV0pf4s
 NW9lIWn0y+rqM1jC6rjNyq9taBcCauHA0wcJPK14rXImG0K3P3bTM4E43vvntGBHagjLrhkgAYU
 vuwEdFZmwOJVKFbY5d3BwVrLNxGEf4+SfO28KZrxStitcHPPvx621oS7u2/IZvBMvw1bqmpdOSA
 xwo0IZ0VYY381VjGx9oi26+rE700ce7QLltp5ylRK9iLJa9Fu9eChVDavx2gZSgh1nupj1DdlyO
 YvT/kgvcZEHCR5dng1qrjoF1AAFkq5WIlvxAc72pFBe7ksCYm6FjktXDUrIvKgT6HYu/hx3umJr
 fRoUa4MAsz30/c4UE71vFcYFPTP+9GVxx398AH5TgRDFYXke6/J8zgSTxvK8x9CDLq/hlYh5FF4
 uMjvABPQyhi0JyI3F8bSFWakYTBd4UtxuJkgoO7XP/iSvTPhUBrBO5WtZWnIV+GHMtJyWYMWHTJ
 RH6oDpfijPven6Ayr5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300052
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi Daniel,

(committed as 6c91b423a9a4dac2a22629491f2a3059aa40b954)

On 3/7/26 20:05, Daniel Henrique Barboza wrote:
> riscv_cpu_update_mip() is a TCG only call.  Its KVM equivalent is
> kvm_riscv_set_irq().  cpu.c gates the KVM only function with a
> kvm_enabled() check, making it unavailable for TCG only builds.  We need
> to do the same for riscv_cpu_update_mip() otherwise a KVM only build
> will fail because it doesn't know what this function is.
> 
> Use tcg_enabled() for the couple of riscv_cpu_update_mip() calls we have
> unguarded in cpu.c.
> 
> We have way more calls to deal with in time_helper.c which isn't using
> kvm_riscv_set_irq() at all, so create a riscv_accel_set_irq() local
> helper that will choose whether to use the KVM or TCG API.
> 
> The reason we're going through all this hassle in time_helper.c is
> because hw/int/riscv_aclint.c uses it, and if we don't do something
> about we won't have riscv_aclint working for KVM.  Whether this is a
> real problem or not and we should remove aclint support for KVM is
> question for another day.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.c         | 19 ++++++++++++++-----
>   target/riscv/time_helper.c | 33 +++++++++++++++++++++++++--------
>   2 files changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index db18c52656..6b79dcc5ee 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1343,14 +1343,18 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
>           case IRQ_M_EXT:
>               if (kvm_enabled()) {
>                   kvm_riscv_set_irq(cpu, irq, level);
> -            } else {
> +            }
> +
> +            if (tcg_enabled()) {
>                   riscv_cpu_update_mip(env, 1 << irq, BOOL_TO_MASK(level));
>               }
>                break;
>           case IRQ_S_EXT:
>               if (kvm_enabled()) {
>                   kvm_riscv_set_irq(cpu, irq, level);
> -            } else {
> +            }
> +
> +            if (tcg_enabled()) {
>                   env->external_seip = level;
>                   riscv_cpu_update_mip(env, 1 << irq,
>                                        BOOL_TO_MASK(level | env->software_seip));
> @@ -1377,9 +1381,14 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
>               env->hgeip |= 1ULL << irq;
>           }
>   
> -        /* Update mip.SGEIP bit */
> -        riscv_cpu_update_mip(env, MIP_SGEIP,
> -                             BOOL_TO_MASK(!!(env->hgeie & env->hgeip)));
> +        if (kvm_enabled()) {
> +            kvm_riscv_set_irq(cpu, irq, level);
> +        }
> +        if (tcg_enabled()) {
> +            /* Update mip.SGEIP bit */
> +            riscv_cpu_update_mip(env, MIP_SGEIP,
> +                                 BOOL_TO_MASK(!!(env->hgeie & env->hgeip)));
> +        }
>       } else {
>           g_assert_not_reached();
>       }
> diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
> index 400e917354..ede1a4c2a3 100644
> --- a/target/riscv/time_helper.c
> +++ b/target/riscv/time_helper.c
> @@ -21,19 +21,34 @@
>   #include "cpu_bits.h"
>   #include "time_helper.h"
>   #include "hw/intc/riscv_aclint.h"
> +#include "kvm/kvm_riscv.h"
> +#include "system/kvm.h"
> +#include "system/tcg.h"
> +
> +static void riscv_accel_set_irq(RISCVCPU *cpu, int irq, int level)

Revisiting this change, riscv_accel_set_irq() is confusing.

> +{
> +    if (kvm_enabled()) {
> +        kvm_riscv_set_irq(cpu, irq, level);

kvm_riscv_set_irq() expects IRQ number and level,

> +    }
> +
> +    if (tcg_enabled()) {
> +        riscv_cpu_update_mip(&cpu->env, irq, level);

riscv_cpu_update_mip() expects a MIP bitmask and a value.

> +    }
> +}
> +
>   
>   static void riscv_vstimer_cb(void *opaque)
>   {
>       RISCVCPU *cpu = opaque;
>       CPURISCVState *env = &cpu->env;
>       env->vstime_irq = 1;
> -    riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(1));
> +    riscv_accel_set_irq(cpu, 0, BOOL_TO_MASK(1));

In particular I don't follow what irq=0 is here, IRQ or mask?

>   }
>   
>   static void riscv_stimer_cb(void *opaque)
>   {
>       RISCVCPU *cpu = opaque;
> -    riscv_cpu_update_mip(&cpu->env, MIP_STIP, BOOL_TO_MASK(1));
> +    riscv_accel_set_irq(cpu, MIP_STIP, BOOL_TO_MASK(1));
>   }
>   
>   /*
> @@ -48,6 +63,7 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
>       RISCVAclintMTimerState *mtimer = env->rdtime_fn_arg;
>       uint32_t timebase_freq;
>       uint64_t rtc_r;
> +    RISCVCPU *cpu;
>   
>       if (!riscv_cpu_cfg(env)->ext_sstc || !env->rdtime_fn ||
>           !env->rdtime_fn_arg || !get_field(env->menvcfg, MENVCFG_STCE)) {
> @@ -63,6 +79,7 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
>   
>       timebase_freq = mtimer->timebase_freq;
>       rtc_r = env->rdtime_fn(env->rdtime_fn_arg) + delta;
> +    cpu = env_archcpu(env);
>   
>       if (timecmp <= rtc_r) {
>           /*
> @@ -71,9 +88,9 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
>            */
>           if (timer_irq == MIP_VSTIP) {
>               env->vstime_irq = 1;
> -            riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(1));
> +            riscv_accel_set_irq(cpu, 0, BOOL_TO_MASK(1));
>           } else {
> -            riscv_cpu_update_mip(env, MIP_STIP, BOOL_TO_MASK(1));
> +            riscv_accel_set_irq(cpu, MIP_STIP, BOOL_TO_MASK(1));
>           }
>           return;
>       }
> @@ -81,9 +98,9 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
>       /* Clear the [VS|S]TIP bit in mip */
>       if (timer_irq == MIP_VSTIP) {
>           env->vstime_irq = 0;
> -        riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(0));
> +        riscv_accel_set_irq(cpu, 0, BOOL_TO_MASK(0));
>       } else {
> -        riscv_cpu_update_mip(env, timer_irq, BOOL_TO_MASK(0));
> +        riscv_accel_set_irq(cpu, timer_irq, BOOL_TO_MASK(0));
>       }
>   
>       /*
> @@ -151,7 +168,7 @@ static void riscv_timer_disable_timecmp(CPURISCVState *env, QEMUTimer *timer,
>   {
>       /* Disable S-mode Timer IRQ and HW-based STIP */
>       if ((timer_irq == MIP_STIP) && !get_field(env->menvcfg, MENVCFG_STCE)) {
> -        riscv_cpu_update_mip(env, timer_irq, BOOL_TO_MASK(0));
> +        riscv_accel_set_irq(env_archcpu(env), timer_irq, BOOL_TO_MASK(0));
>           timer_del(timer);
>           return;
>       }
> @@ -161,7 +178,7 @@ static void riscv_timer_disable_timecmp(CPURISCVState *env, QEMUTimer *timer,
>           (!get_field(env->menvcfg, MENVCFG_STCE) ||
>            !get_field(env->henvcfg, HENVCFG_STCE))) {
>           env->vstime_irq = 0;
> -        riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(0));
> +        riscv_accel_set_irq(env_archcpu(env), 0, BOOL_TO_MASK(0));
>           timer_del(timer);
>           return;
>       }


