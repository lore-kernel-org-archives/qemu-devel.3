Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BA2C54FD4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 20:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpB9u-00060M-HT; Wed, 29 Jul 2026 16:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wpB9s-0005xj-5h
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 16:45:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wpB9p-0001uY-UY
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 16:45:43 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TKDSYr4044562
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 20:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U6t4wsSqA0Ik4beHlOCbmpVnM75WfIbT1VH+AlPbTWM=; b=FSiTRxyYz9qBKfjx
 4L2Ei/K48Na1bfXN1n/h7AFA60w/f0kw3eUTmLmbw/ujm+o43sGb2RXErDPMKVN8
 cvuuJao0L2+3EMtyfryTB905AV4RoojJvEM6tLHCYYgpw1Ou9pyvkrlzlXhjY/IE
 HKbFFS22ijMsygAiRSrKuOSO55VW7B+3jz/BabhOZNIPp2mI1muZmleYPln8lobc
 C+BDzwnUDqDaeJWFefekYqdqqzAASVW3bYzGsPLCd5n+ffk9BefwhPXWwjZyTWTJ
 ycN6dJWifvGwfDeIL83pzA+ETUBCUCZWu2a6fp2mxpTSc15ND75D9BTX8Jpe+kMq
 DBUbFA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqrc7g02w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 20:13:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-930edb4362dso127154085a.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 13:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785356038; x=1785960838; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U6t4wsSqA0Ik4beHlOCbmpVnM75WfIbT1VH+AlPbTWM=;
 b=LHhmkf/0L4SpZ2+FFgSupoKsxR9Y/I0l8fg+n3JPQ8xEn9HtX3VfrFBeVpcJbM6PO4
 Riv6lQMAcMhinYZc6ONMXjbAlpoDYotDDJMnlp7k9MM0c9xyqm1lKB4QZ+EhQBnv4lJW
 v+4oHYfx9hAwAVGvcVdK2nDHJQtblKEaBBZhd8skdR5+EMN3i1qXMEYirHRcd1qgq2TS
 9fPtTaydvNxNgmpbgMTejNQqijFuAFC/tziEwFWrA2ds1HZIKfkIYzzw6n89HyuNPIp1
 bianDmTuoy2hJlRlYwYLUXyQVemAzqR9OSr2tvYZOKZAUhWYftEg5fOQNkijnJ0aflKM
 JaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785356038; x=1785960838;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U6t4wsSqA0Ik4beHlOCbmpVnM75WfIbT1VH+AlPbTWM=;
 b=n7uiXeeeBf4VQ46qP4caC+t8TO3sYUgk+dsX2/adNHcOjmKtGivBtmAMm+4ClzSy33
 SQVGS1Ztn6ImLimcIwIRkEmyMFpewqCNgWa11OK8uMQkei4n+LtPZVUdNqijw+df/9Su
 cK5SUete5YONh95D7FDA0Q6xkVd8z+Q8gAjf26kNw3tEraGf0dp0hfHgbnvbjk6VOi69
 DG32sLWOPna+OWPzbHZeWLYQaq6adgZamWAB1Fjuqs+blFwugTOZ4O29pWXxgwkPdQ/J
 0eMV6wgaTuTHOxd8LG7hf7JdMWFD2g+rxYVQuzO+BEfXyS8JpuTHsGMrAIPWAnYzEXtN
 252A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGwO4Ryv8soejkGHUcYFiHjlOAsmSEfg/lt5z3EBbRZVYURIwdRv2tVHk1+lD+RAZCjC9FcY48IjbH@nongnu.org
X-Gm-Message-State: AOJu0YzTKPzVMHpwSS55L4Bhf+J2W+tLbYVEllT0rCs8uFoWWjTooQ0Q
 L6tE1Yp96XRte4ErYFZQqmG0g1nNmCyBpx+8Sruc0lTFyzbbFbJVzAWO9sOJbTEAVF+q9ipuGKv
 jUBcxrV4mivFZFpquBLf8lEtw8koLYtp+/zeVYXwAySwIt05sK5vYTFlpUA==
X-Gm-Gg: AR+sD118txIZ/7KA2r85p/89NKkFC8xPSUDUMmIq2zrU/uo+2GOKFUP1imQeN4d3+vd
 JNDzxiWxesibiAY074nf7Z8GYE1EGoJuNsDF30i3mskwhPk0pLBMC0j22KQunjHz/5Pm0LVjt5j
 YfjJ7/73hWVYAYpRM2Mv9YhjA3PSCjAOTv7Q524HOouQ9lnrC3TWawjHkHFM7WqlR0AwGoxyK4F
 h/aWjMQ5sXNBVX16UNO4kc7CrJ5CQWYHyUEvAoOyZjG0UzKtJ/aWMlAAvm3yaXX4HUnQo3Rfo9g
 RQ3KlPN1EIwj7k0B1gdUqBojQlnTmA7IcL58WNdv+M24ngoB+g1xkMuSHWPP9n7SBnFEGTaNiuS
 7enzu3N7fGbY3aWrBFi3+iWPGFTmaVC85W/O4yA==
X-Received: by 2002:a05:620a:c41:b0:930:af44:8b21 with SMTP id
 af79cd13be357-93483f13affmr37872685a.79.1785356038205; 
 Wed, 29 Jul 2026 13:13:58 -0700 (PDT)
X-Received: by 2002:a05:620a:c41:b0:930:af44:8b21 with SMTP id
 af79cd13be357-93483f13affmr37867285a.79.1785356037411; 
 Wed, 29 Jul 2026 13:13:57 -0700 (PDT)
Received: from [192.168.68.104] ([191.202.238.134])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933e733e170sm246234685a.32.2026.07.29.13.13.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 13:13:56 -0700 (PDT)
Message-ID: <2b3c06e8-721a-4f31-a9c6-76d1a093f936@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 17:13:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: do not count ECALL in minstret
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com
References: <20260729032202.1415046-1-fritchleybohrer@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260729032202.1415046-1-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: b7PmaGG9QESxDdPY5soWt0pG6dDu0hN5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE1NSBTYWx0ZWRfX/ifNOcTEzaos
 Yxu43yuBoiR9D9Yp1zE3v14SiKGPTojAVBNA0SKuFtjnQO9VPXQvvVjg3y+oEtMIwI+iq/xXgWb
 5W4PHbm5F1xgnNvpJ/dN0qCs84r1IUTonlYBQk2nhVPBkdcICb2cTwjFhQMrjM5lSIBQo6PJevh
 wSqvmlJVyDAdIs1QhUb0uSi0bgi5S2AfR6WccluIUhTiouk7pkPNIw7mpr08MJV9kNwnSsJLGvK
 SlYxd607HbnBRswkN5LwIQS1ToYjOtJ62FhZ0+AvavA79FM+pqDNlg0gz0rIv6yrBhNFCrxBEMu
 8W8QNKmhDGMe7GkyT5Jm7ifxPQctpUgbJuJA64BeSSb+uwOJLsV4DOZ0R1yIvu1eOYy0NGV6GZ+
 WcTi2JgWlbuxVzVBQUw1mxfqYrbx+9qgKG027+laQvBcDGAW8gAsi2dIHyaoW4BxdeVhcnXU6Fs
 9iT4HEImKDtGXVOGmcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE1NSBTYWx0ZWRfX7xxIfx15x03R
 8VIDRycV4pWZKvQnwlrnplKE0E+gbqIBZMnVzbzLNFdZxwlByA1+y59TNCiGearqfp+iyCG9y5a
 fUf5pDdp4x+fBnY+M2gN2m3pdxdBdVE=
X-Proofpoint-GUID: b7PmaGG9QESxDdPY5soWt0pG6dDu0hN5
X-Authority-Analysis: v=2.4 cv=XJcAjwhE c=1 sm=1 tr=0 ts=6a6a5f07 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=krItrnN2KmZux9Htc+7Wjw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fJNhUIT9uDURjZvhfsoA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_07,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290155
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



On 7/29/2026 12:22 AM, Zephyr Li wrote:
> With icount enabled, helper_raise_exception() leaves ECALL in
> icount_get_raw() because it exits without restoring the current TB
> state. This makes minstret count an instruction that does not retire.
> 
> Adjust only the fixed minstret baseline so that mcycle accounting
> remains unchanged.
> 
> Add an RV64 softmmu regression test for the issue.

That's a good habit that I need to incorporate as well.

> 

Fixes: 4fe8ae0906 ("target/riscv: Combine mhpmcounter and mhpmcounterh")

> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4087
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/op_helper.c              |  6 +++
>   target/riscv/tcg/pmu.c                    | 44 +++++++++++++-----
>   target/riscv/tcg/pmu.h                    |  1 +
>   tests/tcg/riscv64/Makefile.softmmu-target |  4 ++
>   tests/tcg/riscv64/test-minstret-ecall.S   | 55 +++++++++++++++++++++++
>   5 files changed, 98 insertions(+), 12 deletions(-)
>   create mode 100644 tests/tcg/riscv64/test-minstret-ecall.S
> 
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index ba3c7da375..acdccd1a97 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -21,6 +21,9 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "target/riscv/tcg/csr.h"
> +#ifndef CONFIG_USER_ONLY
> +#include "pmu.h"
> +#endif
>   #include "internals.h"
>   #include "exec/cputlb.h"
>   #include "accel/tcg/cpu-ldst.h"
> @@ -47,6 +50,9 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
>   
>   void helper_raise_exception(CPURISCVState *env, uint32_t exception)
>   {
> +#ifndef CONFIG_USER_ONLY
> +    riscv_pmu_decr_instret(env);
> +#endif
>       riscv_raise_exception(env, exception, 0);
>   }
>   
> diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
> index 38ad2737e1..1a4658319b 100644
> --- a/target/riscv/tcg/pmu.c
> +++ b/target/riscv/tcg/pmu.c
> @@ -49,6 +49,21 @@ static bool riscv_pmu_counter_enabled(RISCVCPU *cpu, uint32_t ctr_idx)
>       }
>   }
>   
> +static bool riscv_pmu_counter_filtered(CPURISCVState *env, uint64_t cfg)
> +{
> +    bool virt_on = env->virt_enabled;
> +
> +    return (env->priv == PRV_M && (cfg & MHPMEVENT_BIT_MINH)) ||
> +           (env->priv == PRV_S && virt_on &&
> +            (cfg & MHPMEVENT_BIT_VSINH)) ||
> +           (env->priv == PRV_U && virt_on &&
> +            (cfg & MHPMEVENT_BIT_VUINH)) ||
> +           (env->priv == PRV_S && !virt_on &&
> +            (cfg & MHPMEVENT_BIT_SINH)) ||
> +           (env->priv == PRV_U && !virt_on &&
> +            (cfg & MHPMEVENT_BIT_UINH));
> +}
> +
>   /*
>    * Information needed to update counters:
>    *  new_priv, new_virt: To correctly save starting snapshot for the newly
> @@ -147,12 +162,27 @@ void riscv_pmu_update_fixed_ctrs(CPURISCVState *env,
>       riscv_pmu_icount_update_priv(env, newpriv, new_virt);
>   }
>   
> +void riscv_pmu_decr_instret(CPURISCVState *env)
> +{
> +    if (!icount_enabled() ||
> +        (env->mcountinhibit & COUNTEREN_IR) ||
> +        riscv_pmu_counter_filtered(env, env->minstretcfg)) {
> +        return;
> +    }
> +
> +    /*
> +     * minstret is derived from icount, which includes the current
> +     * instruction.  Move the baseline forward to exclude an instruction
> +     * that raises an exception and therefore does not retire.
> +     */
> +    env->pmu_ctrs[2].mhpmcounter_prev++;
> +}
> +
>   int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
>   {
>       uint32_t ctr_idx;
>       CPURISCVState *env = &cpu->env;
>       uint64_t max_val = UINT64_MAX;
> -    bool virt_on = env->virt_enabled;
>       PMUCTRState *counter;
>       gpointer value;
>   
> @@ -170,17 +200,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
>           return -1;
>       }
>   
> -    /* Privilege mode filtering */
> -    if ((env->priv == PRV_M &&
> -        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_MINH)) ||
> -        (env->priv == PRV_S && virt_on &&
> -        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VSINH)) ||
> -        (env->priv == PRV_U && virt_on &&
> -        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VUINH)) ||
> -        (env->priv == PRV_S && !virt_on &&
> -        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_SINH)) ||
> -        (env->priv == PRV_U && !virt_on &&
> -        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_UINH))) {
> +    if (riscv_pmu_counter_filtered(env, env->mhpmevent_val[ctr_idx])) {
>           return 0;
>       }
>   
> diff --git a/target/riscv/tcg/pmu.h b/target/riscv/tcg/pmu.h
> index b4f1e469a2..2429c01b77 100644
> --- a/target/riscv/tcg/pmu.h
> +++ b/target/riscv/tcg/pmu.h
> @@ -36,6 +36,7 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
>                             uint32_t ctr_idx);
>   void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, privilege_mode_t newpriv,
>                                    bool new_virt);
> +void riscv_pmu_decr_instret(CPURISCVState *env);
>   RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>                                     bool upper_half, uint32_t ctr_idx);
>   
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
> index 82be8a2c91..42038ce3b4 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -24,6 +24,10 @@ EXTRA_RUNS += run-test-mepc-masking
>   run-test-mepc-masking: test-mepc-masking
>   	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
>   
> +EXTRA_RUNS += run-test-minstret-ecall
> +run-test-minstret-ecall: test-minstret-ecall
> +	$(call run-test, $<, $(QEMU) -icount shift=1 $(QEMU_OPTS)$<)
> +
>   EXTRA_RUNS += run-plugin-doubletrap
>   run-plugin-doubletrap: doubletrap
>   	$(call run-test, $<, \
> diff --git a/tests/tcg/riscv64/test-minstret-ecall.S b/tests/tcg/riscv64/test-minstret-ecall.S
> new file mode 100644
> index 0000000000..ab268f7f22
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-minstret-ecall.S
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +	.option	norvc
> +
> +	.text
> +	.global	_start
> +_start:
> +	lla	t0, trap
> +	csrw	mtvec, t0
> +
> +	/*
> +	 * The first CSR read retires after obtaining s0.  The ecall does not
> +	 * retire, so the trap handler must observe a difference of one.
> +	 */
> +	csrr	s0, minstret
> +	ecall
> +	sub	t0, s1, s0
> +	li	t1, 1
> +	bne	t0, t1, fail
> +
> +	li	a0, 0
> +	j	_exit
> +
> +trap:
> +	csrr	s1, minstret
> +	csrr	t0, mcause
> +	li	t1, 11		/* Environment call from M-mode */
> +	bne	t0, t1, fail
> +
> +	csrr	t0, mepc
> +	addi	t0, t0, 4
> +	csrw	mepc, t0
> +	mret
> +
> +fail:
> +	li	a0, 1
> +
> +_exit:
> +	lla	a1, semiargs
> +	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	a0, 8(a1)
> +	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
> +
> +	/* Semihosting call sequence */
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


