Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD594C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3uHs-0002EY-KH; Tue, 08 Sep 2026 07:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3uHr-0002EL-GQ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:46:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3uH9-0001MD-7I
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:46:51 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688BXovt2874055
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 11:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d0sdqtjB6dv6WEu53mmCRPUj0+MJj8tGbsAvqv0vwdQ=; b=DcuTI7LFYECQV/fO
 QLl2pCThxHRKnCdgmrNrK1K+8frGSlzubHifv6KHuIQtfcmkaIwir5VHtUte9a/i
 CAZofskFVUbSQvCDmQy6gJC1Y1VQ3yML/7lmCl/UAMkFZ2kHQfU4J+HukVsm7/2j
 sBa5hAwxt9cn/TX7cBiDKrm5BckX3Gc3xm7oOUdv8wIVh+bHwjfDbAlTBytfs3C6
 qorSbVXFpaeQnbfKYxUnmg+kMIl1S4JF93yQ0BO979voF6vvb6qr9bS/gpUhQ78n
 HZlXO/F7YSO7Gs0VlFoL3564n5LN0EA9h6KGz3HFptV8qBbGKSfsuGnUwAmOqAya
 KIQgeQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjhkj01bw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 11:46:05 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90e8341cfb4so43843306d6.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 04:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788867959; x=1789472759; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=d0sdqtjB6dv6WEu53mmCRPUj0+MJj8tGbsAvqv0vwdQ=;
 b=dHSU7B8lkNdPCKVq0D6JY4qZnrDbHKxRNVintFaHWHeykWR11mBMbAOg3PVvSvZVkZ
 LXJ9YNlGL6xGF2eOV0P5Q35rYyhpp512BqyES4jOhqhUa6ORESC2FPtMmz840EObi/xX
 6WZmaFoPCF9RLeziGrHcMxNJmGF83suY9+VXg/2RE2HGcBoqwoj5OKm3a/iGH7yPGlej
 GKsOqCwI4Ua2iHXbJsgnTCHxHEC96r77M9r+w6kLDeAR1aUUDesguR4s5oVqZNH0KzAQ
 7APr/lZGX/+LT9URXdlq5BOPkSU/49AjrwbiHIhhEjtXLyi4mI5ZyTY61qkF6tFLuf1i
 rFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788867959; x=1789472759;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d0sdqtjB6dv6WEu53mmCRPUj0+MJj8tGbsAvqv0vwdQ=;
 b=amqzO0FdQa7HclGbQKR3Epmch+mS8rqCMryGUEA/5nLhhTHeqT3ngfRpro/La+2ovB
 cjJPaq19yhEl4bHdx6yCuSxLkEuhEbfusxN/KNWoMe0VLHs4fdV3Temghc1xz0y36rYh
 kaueaZXVGfiAAVdovAkGSI0h4yQLU02cqV56O348OFGLJwo0/E3SIXL+iLDaxsg8oKSt
 bINq3cH3/K+3s3MZgINuslA8q0R/0taVyuG26g9uWE2KYEvyGRmxkrvcpavdfGF61NKg
 32OS/U1KbrZu+ig3Dxcqpw0hkygKZsN9Sqh6fSioGo8SP2CYeQn9tM8RtvOy5QR6z0DN
 /fcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBylBEPSia2SkwTLaHcButDT2RltLznxEnzfpK3iEdXu+D/m078foM1OqM3fO5f9oJznRWRdWWqmn5HL@nongnu.org
X-Gm-Message-State: AFuF++nkYR7Ipm1xSWr43q1mG09+Vp8w04Fc8JgMVLQ6fZLKETr420Eg
 cO5WmodxP8QrT2Id+Ovs7Z0QzbOPThxKLNnTO/STuikFtI5m9X0tafA7iCy9mylM/P5IhlGNKcf
 pD2cOO7pqqXvWZEHYBohszEjgDzVpzOnCZlcdPELaSilFJPHvmIEdvpYr4Q==
X-Gm-Gg: AYBFou114FFQ/O1XFtyh+BF9o4xzCLltGhVjLwRpn4osMAxcO5Q//bf9bS2WxWfbN7m
 lpRRaoKSnnd/2aUoBqKitvdk+Rool5HPJMyRqKcY0lqLV52L0gLI6qufEyamefgfzUOfh2Ur/5R
 iiUPo+zIou6/Pw+uptYtYFvzdqDHD05GR8xV9IRx3qWgKzsN0owPjSgFTuIJtwx/z/T9jtP9RwP
 +vrJj2Y2LLN0VRnhWYhaPiaPTj+AbfPNbXj5VJ3v71Z78aAh6EST210GC8erYZZSLrwgISOTbwP
 6rjw42Yq1kUrEhute4joZvsvNaYDKoBdqWvX+toiYkq+n15V9kD4DYpYRvIj1fH0RfooDf0iXpV
 k6v81jdAYX4QbGrEItV99Vt7rigqgc+Vulx1l
X-Received: by 2002:ad4:4ee4:0:b0:90c:b635:df18 with SMTP id
 6a1803df08f44-9103f003460mr349755666d6.27.1788867959110; 
 Tue, 08 Sep 2026 04:45:59 -0700 (PDT)
X-Received: by 2002:ad4:4ee4:0:b0:90c:b635:df18 with SMTP id
 6a1803df08f44-9103f003460mr349755176d6.27.1788867958550; 
 Tue, 08 Sep 2026 04:45:58 -0700 (PDT)
Received: from [192.168.15.12] ([177.214.151.199])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-910405966f0sm115467296d6.6.2026.09.08.04.45.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 04:45:57 -0700 (PDT)
Message-ID: <f6477ee0-db77-4564-950e-384759ae5a81@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 08:45:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] target/riscv: Use VM-elapsed sources for fixed PMU
 events
To: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260907-riscv-pmu-correctness-v1-0-5f1f41458989@linux.alibaba.com>
 <20260907-riscv-pmu-correctness-v1-3-5f1f41458989@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260907-riscv-pmu-correctness-v1-3-5f1f41458989@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEyNSBTYWx0ZWRfX6dfviGLDsDg/
 9cgUpS+GJ1WnMiohNxrUL/tCjBLqPqbMmsYZB1Bvj1hanrjF2rZBdw7jUyzhYcKzJu0x+LeIGkp
 GSKUwbOT22uvfLOnUADv5RUThBDo0mQ=
X-Proofpoint-GUID: 0CbWObJ3VeCInkJzVnU-l6fUZLB8W6Ff
X-Authority-Analysis: v=2.4 cv=VYjH+lp9 c=1 sm=1 tr=0 ts=6a9ff57d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=lJrVL2S40hk4Skp227i47g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=69wJf7TsAAAA:8 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=366_GuYNFlfm1CcW-0cA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: 0CbWObJ3VeCInkJzVnU-l6fUZLB8W6Ff
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEyNSBTYWx0ZWRfX5CND54TFVdbu
 ZUctQiNdw2/MRI5eQu0g1vdZGfwNdvTWvKPGVWe54O9qXUxf5jWTSWNj1s1XDaD/hTddkUNQlvH
 qOAV4NZUG8Z3LzDpiyhfg8U+7U2bhpmLcZLuCiZOiki07oieWFWuMep2lVByR90EflRziJS4fAX
 +RLdLF6v92UE7XPfTvBvxN2YIo4zaDeflzwnhDW9eKMexr2VHcLSHrNXnqNMCNVXpjv1cor6zM2
 yoGuXEyjAwvjErMzNnA1xGnlQtonxz0h6w1QfljJWsvbcAeOfviFYQ3aYEK1+17Ylt9J2Yari3W
 5byqYlceri2lTyQO//9SpVNSxPBBYi+iNyIhkD1OTTVzDQsCTjP3L7T/EJ8sbYGLmU9Y7MEJx/t
 CC73x2qh/jGFAWKkmce1Ii/noat9V/KJ7/RmzN24I9gkr09zQZoUJnG2UItAWnjp69wf2FF0JCV
 /ZDckEdxAosnF62JS3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080125
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



On 9/6/2026 1:37 PM, TANG Tiancheng wrote:
> Raw host ticks keep advancing while the VM is stopped. Use
> cpus_get_elapsed_ticks() for cycles and non-icount instruction counting,
> and retain icount_get_raw() for instructions under icount. Document that
> cpu_get_ticks() returns its stored value while VM ticks are disabled.
> 
> Under icount, cycles are already virtual nanoseconds. Convert only raw
> instruction counts when scheduling overflow, avoiding a second scaling
> of cycle distances. Add a cycle-overflow regression with icount shift=3.
> 
> Link: https://lists.nongnu.org/archive/html/qemu-devel/2025-10/msg00668.html
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   system/cpu-timers.c                         |  4 +-
>   system/cpus.c                               |  6 +--
>   target/riscv/tcg/csr.c                      |  8 +---
>   target/riscv/tcg/pmu.c                      | 52 +++++++++++++++-----------
>   target/riscv/tcg/pmu.h                      |  1 +
>   tests/tcg/riscv64/Makefile.softmmu-target   |  4 ++
>   tests/tcg/riscv64/sscofpmf-cycle-overflow.S | 58 +++++++++++++++++++++++++++++
>   7 files changed, 100 insertions(+), 33 deletions(-)
> 
> diff --git a/system/cpu-timers.c b/system/cpu-timers.c
> index 9919b46230f1caf8be1a1b6ef00acd94678437ce..0415636aff3f774f0de61fdac3969f5b45ae6993 100644
> --- a/system/cpu-timers.c
> +++ b/system/cpu-timers.c
> @@ -118,8 +118,8 @@ void cpu_enable_ticks(void)
>   }
>   
>   /*
> - * disable cpu_get_ticks() : the clock is stopped. You must not call
> - * cpu_get_ticks() after that.
> + * Freeze VM ticks. While disabled, cpu_get_ticks() returns the stored tick
> + * value instead of sampling the advancing host counter.
>    * Caller must hold BQL which serves as mutex for vm_clock_seqlock.
>    */
>   void cpu_disable_ticks(void)
> diff --git a/system/cpus.c b/system/cpus.c
> index e11a5aab6a696962d94ad30ac38acd8867b1bf88..f61639ae78277fd90cbddb0b9f75b134e3cc1a17 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -237,9 +237,9 @@ void cpus_set_virtual_clock(int64_t new_time)
>   }
>   
>   /*
> - * return the time elapsed in VM between vm_start and vm_stop.  Unless
> - * icount is active, cpus_get_elapsed_ticks() uses units of the host CPU cycle
> - * counter.
> + * Return VM-elapsed ticks. While VM ticks are disabled, passage of host time
> + * does not advance the returned value. Unless icount is active, the units are
> + * those of the host CPU cycle counter.
>    */
>   int64_t cpus_get_elapsed_ticks(void)
>   {
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index d15a2d096cb6e13cd123ff9ae82ee7c643c2a961..60caee32dc0cf5b6a8492e0cf8ff15f71acc2087 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -1327,13 +1327,7 @@ static uint64_t riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
>       }
>   
>       if (!cfg_val) {
> -        if (icount_enabled()) {
> -                curr_val = inst ? icount_get_raw() : icount_get();
> -        } else {
> -            curr_val = cpu_get_host_ticks();
> -        }
> -
> -        return curr_val;
> +        return riscv_pmu_read_fixed_source(env, inst);
>       }
>   
>       /* Update counter before reading. */
> diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
> index f19f417e90e33a94d00007ef132ef4e154175b19..ea0ffe41258d4dbef9dc952655e6301c14ba1d23 100644
> --- a/target/riscv/tcg/pmu.c
> +++ b/target/riscv/tcg/pmu.c
> @@ -24,8 +24,14 @@
>   #include "pmu.h"
>   #include "exec/icount.h"
>   #include "system/device_tree.h"
> +#include "system/cpu-timers.h"
>   
> -#define RISCV_TIMEBASE_FREQ 1000000000 /* 1Ghz */
> +/*
> + * cpu_get_ticks() does not expose the host tick frequency.  Use a 1 GHz
> + * approximation only when scheduling non-icount overflow checks; fixed
> + * counter values remain in host-tick units.
> + */
> +#define RISCV_PMU_HOST_TICK_HZ_ASSUMED 1000000000
>   
>   static bool riscv_pmu_counter_valid(RISCVCPU *cpu, uint32_t ctr_idx)
>   {
> @@ -75,6 +81,19 @@ static bool riscv_pmu_counter_filtered(CPURISCVState *env, uint64_t cfg)
>               (cfg & MHPMEVENT_BIT_UINH));
>   }
>   
> +/*
> + * VM-elapsed ticks stop advancing while VM ticks are disabled.  Under
> + * icount, instruction events retain raw instruction-count units.
> + */
> +uint64_t riscv_pmu_read_fixed_source(CPURISCVState *env, bool instret)
> +{
> +    if (instret && icount_enabled()) {
> +        return icount_get_raw();
> +    }
> +
> +    return cpus_get_elapsed_ticks();
> +}
> +
>   /*
>    * Information needed to update counters:
>    *  new_priv, new_virt: To correctly save starting snapshot for the newly
> @@ -96,11 +115,7 @@ static void riscv_pmu_icount_update_priv(CPURISCVState *env,
>       uint64_t *counter_arr;
>       uint64_t delta;
>   
> -    if (icount_enabled()) {
> -        current_icount = icount_get_raw();
> -    } else {
> -        current_icount = cpu_get_host_ticks();
> -    }
> +    current_icount = riscv_pmu_read_fixed_source(env, true);
>   
>       if (env->virt_enabled) {
>           g_assert(env->priv <= PRV_S);
> @@ -137,11 +152,7 @@ static void riscv_pmu_cycle_update_priv(CPURISCVState *env,
>       uint64_t *counter_arr;
>       uint64_t delta;
>   
> -    if (icount_enabled()) {
> -        current_ticks = icount_get();
> -    } else {
> -        current_ticks = cpu_get_host_ticks();
> -    }
> +    current_ticks = riscv_pmu_read_fixed_source(env, false);
>   
>       if (env->virt_enabled) {
>           g_assert(env->priv <= PRV_S);
> @@ -286,17 +297,15 @@ static bool riscv_pmu_event_supported(uint32_t event_idx)
>       }
>   }
>   
> -static int64_t pmu_icount_ticks_to_ns(int64_t value)
> +static int64_t pmu_ticks_to_ns(CPURISCVState *env, uint32_t ctr_idx,
> +                               int64_t value)
>   {
> -    int64_t ret = 0;
> -
> -    if (icount_enabled()) {
> -        ret = icount_to_ns(value);
> -    } else {
> -        ret = (NANOSECONDS_PER_SECOND / RISCV_TIMEBASE_FREQ) * value;
> +    if (icount_enabled() &&
> +        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> +        return icount_to_ns(value);
>       }
>   
> -    return ret;
> +    return (NANOSECONDS_PER_SECOND / RISCV_PMU_HOST_TICK_HZ_ASSUMED) * value;
>   }
>   
>   void riscv_pmu_rebuild_event_map(CPURISCVState *env)
> @@ -448,8 +457,9 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
>   
>       if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>           riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> -        overflow_ns = pmu_icount_ticks_to_ns((int64_t)overflow_delta);
> -        overflow_left = pmu_icount_ticks_to_ns(overflow_left) ;
> +        overflow_ns = pmu_ticks_to_ns(env, ctr_idx,
> +                                      (int64_t)overflow_delta);
> +        overflow_left = pmu_ticks_to_ns(env, ctr_idx, overflow_left);
>       } else {
>           return -1;
>       }
> diff --git a/target/riscv/tcg/pmu.h b/target/riscv/tcg/pmu.h
> index 910091690290cac9f77855f479bb9d90b2762efe..339a4b3ac09c4a91cddd9250824284203b16b4fa 100644
> --- a/target/riscv/tcg/pmu.h
> +++ b/target/riscv/tcg/pmu.h
> @@ -26,6 +26,7 @@ bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
>                                           uint32_t target_ctr);
>   bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env,
>                                     uint32_t target_ctr);
> +uint64_t riscv_pmu_read_fixed_source(CPURISCVState *env, bool instret);
>   void riscv_pmu_timer_cb(void *priv);
>   void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
>   void riscv_pmu_rebuild_event_map(CPURISCVState *env);
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
> index 97978c6707247bb786f41549ada69e12aab619ce..677244e8b187435b09fc6b7616e269992543587c 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -44,6 +44,10 @@ TESTS += sscofpmf-overflow
>   run-sscofpmf-overflow: sscofpmf-overflow
>   	$(call run-test, $<, $(QEMU) -cpu max -icount shift=0 $(QEMU_OPTS)$<)
>   
> +TESTS += sscofpmf-cycle-overflow
> +run-sscofpmf-cycle-overflow: sscofpmf-cycle-overflow
> +	$(call run-test, $<, $(QEMU) -cpu max -icount shift=3 $(QEMU_OPTS)$<)
> +
>   EXTRA_RUNS += run-plugin-doubletrap
>   run-plugin-doubletrap: doubletrap
>   	$(call run-test, $<, \
> diff --git a/tests/tcg/riscv64/sscofpmf-cycle-overflow.S b/tests/tcg/riscv64/sscofpmf-cycle-overflow.S
> new file mode 100644
> index 0000000000000000000000000000000000000000..1acf61ee54ab9b8dc6e5228a6bce3c013fe7201c
> --- /dev/null
> +++ b/tests/tcg/riscv64/sscofpmf-cycle-overflow.S
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +	.option	norvc
> +	.option	norelax
> +
> +	.text
> +	.global _start
> +_start:
> +	/* UINT64_MAX - 4095 leaves 4096 cycle increments until overflow. */
> +	csrw	0x323, zero		/* mhpmevent3 */
> +	li	t0, -4096
> +	csrw	0xb03, t0		/* mhpmcounter3 */
> +	li	t0, 1
> +	csrw	0x323, t0		/* mhpmevent3: cycles */
> +	csrr	t1, mcycle
> +
> +1:
> +	csrr	t0, 0x323
> +	beqz	t0, fail
> +	li	t2, 1
> +	slli	t2, t2, 63
> +	and	t0, t0, t2
> +	bnez	t0, pass
> +
> +	/*
> +	 * Allow 16384 cycles for OF to become visible. With shift=3, scaling
> +	 * the 4096-cycle distance twice would delay it to about 32768 cycles.
> +	 */
> +	csrr	t0, mcycle
> +	sub	t0, t0, t1
> +	li	t2, 16384
> +	bltu	t0, t2, 1b
> +
> +fail:
> +	li	a0, 1
> +	j	exit
> +
> +pass:
> +	li	a0, 0
> +
> +exit:
> +	lla	a1, semiargs
> +	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	a0, 8(a1)
> +	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
> +
> +	/* Semihosting call sequence. */
> +	.balign	16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.data
> +	.balign	16
> +semiargs:
> +	.space	16
> 


