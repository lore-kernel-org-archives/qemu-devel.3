Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBD5C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhqx-0007sr-BJ; Wed, 19 Aug 2026 11:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhqw-0007sZ-AP
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:05:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhqu-0001xd-H0
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:05:18 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JF1AhD3869628
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 15:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YrN3UW6zkeMhVAx+wUb7xxib9AC1mZ6inYfCR9edCB8=; b=mB4qSdB3bfuSAsPw
 ma9EJqyJjfW/DPZBdWYoTn2XIbUA6syltVQ7V7TJTnUBuuV7bqwIp31Gd6KIBXoz
 WTSkLinjkvwqHguZndf9mA3D/ytp9O4dCefKnF/whEzLxdn2z1Z3bxIEybLinm5J
 NXIuby8KLTne1aefQiZKbA4r6RBu7eoahwyTq9vYdOGkbiNxkO5Mz8/OEdyj93VQ
 jkjwUE7hXMcl8lBJ6hfqRBYf4+wwkQtI6dPuEx+ODnbB+9aOMpQBqNfkjhKELhjt
 HaSRPVp5XIF0nFQOTtWLx316Sph/AtC5no1nD7GeNzk1r34zaBLmJMs+RObN/7In
 +f+M+A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5ervg0qg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 15:05:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e4f946461so125862685a.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 08:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787151912; x=1787756712; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YrN3UW6zkeMhVAx+wUb7xxib9AC1mZ6inYfCR9edCB8=;
 b=VRwwgsmqRH0+3u93M8CDOAX0NYeDWsEPsWed4Uo1qw8tm2YoAWncA8tzjVWCcuczWb
 3nn0gdfkDml6g5oUq/2Iqyom0o2WmNywhgRDKKX1hBS8wa58i1s+5h92AxcPU64311+H
 GUBVLI2bQMcMXxEPvjfLrAN1w66bFvGzoiYK3BwyqUNF12ypswG094yclhN7eEIUQawU
 nzdHd/P8sXt6vQcURIrbzib0PTpuBJLxKUbV83qx9rLpVLUx4ipV2baMA2VaFva8gMhU
 sZH2DDzxjLMeInGrUfpv0vKSxvIywgBYI1zmNToU87vrXw2YtoIpZzorOFc51kcXYI9a
 jQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787151912; x=1787756712;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YrN3UW6zkeMhVAx+wUb7xxib9AC1mZ6inYfCR9edCB8=;
 b=ah0/DRaE7a/8Ng7vtD4zzHHOspLMmQtBSTyWz6N11oaHBgfKxb9a5bnc73mr33TThS
 2Xv6NpMn/7qw6Z0fyTRGR+tMIlnFlKXXKHHmd/1AczUhMWSow9RnzjjEep2XZCjEhYlv
 T800JYotZTmH3cT7Cnn+0/hxojqFDK3yKh+sBjc8eNNo9lQdsJ85Ov7qk4ux0QvpJ/xK
 JIw57NVjbqOEbXQX/0cF5iLbt71FIJHJehT+d9H8cPRmM+4D9+Tu7ThXzzpMUPqz6e2U
 ma2wb1jbUgeaDbqbgx5/mpTQlqJIBmQDKcGhBg4FmFuZibsi5Koywat1FbUplRKZvklH
 q0YA==
X-Gm-Message-State: AOJu0YxnYp/prlsGteb4aeskbXVNyxL4WemoZ58/RrSvHcd2tYxTi+8j
 0pGmWiRM6OTPQZGN4t6UVTfyB/VM/CpbKfj0n8Vh0loEBF7pSgZx0F7Rw5gjQ61BwOsb9/u7Q1L
 MnyrgbfRbzn3wrlmftAhma5rNZZn6T/KQ/8pckYIROM6ubY9eRNhfDj6uuEmPU3aD8f8/
X-Gm-Gg: AR+sD139dehTcVWLej/s+cjBaBtI8nt7tjg/KkBhFlcyxJYGRPmV3CmdgaKZnvJrsyc
 DsXreay7pKPkcG94k8cGvidANnCDOw+f4jeZXZCoH9gJlrWPDlw0OYVgoYeTo4+zrA8z4k8fT7c
 knCOG2pvci3GC6EKDY51YhvwuPND15bDNO2oXi47mNc87MNO7zcyamtPRt0PWh6yPoxot2MujtH
 AvV79qVCGGKiaVW+R3kw2EKfZrq/RSxeU3JED9BYZHiHhyOjTAhjZpP/xf0MH2YTOuN+wyStY40
 nC47DGMHAOZUejgCP/c5QyFA5xm679mijFbpzDj33HBpTHG/TrNdL1R+EThV6x4v+oq72x4hZUe
 vMQJSXddhAtBn7PfwvMXlsMNhndlrspbcghY=
X-Received: by 2002:a05:620a:6914:b0:937:16da:5028 with SMTP id
 af79cd13be357-9371e301606mr460815885a.30.1787151911455; 
 Wed, 19 Aug 2026 08:05:11 -0700 (PDT)
X-Received: by 2002:a05:620a:6914:b0:937:16da:5028 with SMTP id
 af79cd13be357-9371e301606mr460803385a.30.1787151910864; 
 Wed, 19 Aug 2026 08:05:10 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c45d1sm5331802f8f.30.2026.08.19.08.05.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 08:05:10 -0700 (PDT)
Message-ID: <c39f45cd-f345-4e65-9989-5af96cd2d6d2@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 17:05:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] accel/tcg: Remove the now redundant cpu_exec_halt()
 hook
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-12-philmd@oss.qualcomm.com>
In-Reply-To: <20260819145649.23439-12-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: utq7jpreCVySu9MEmlUz-R45ftM9qB53
X-Authority-Analysis: v=2.4 cv=VZ3H+lp9 c=1 sm=1 tr=0 ts=6a85c628 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Zuu7zhy06pRdiNC0prEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfXxBh9AqIzj3IJ
 zu1BzcGjtrMvPyRndOPnPPMJOe17rebL5uWFMXDQPqm5PjAcEhfVS0bON2cHqN84snyRuQeYBHi
 sA7pBWLxBeYI5EFAkcBbrZVIE6kzWlJGTdWGly3rfC0OQIRgFpe6XCkE5i3NMoaGah3u4sv3KbI
 DQXgp25WT3OCPG9RTLJ60BdZ5gfVbhpxYzuZ8Bxkl4SAS+njEqgUPPOwvkue62zNySU7s3eVQN/
 5C7rABH4lrFQsQH0/38S0ZAfmFns5wLD9E7E0QIXw42C9siZfaxdzCFOiUKYwWNMhMlXvb6DxIN
 T2wkC9WJQxEfLImYWFsoPo2V7qWjB90r5FQ+pW6CuvfENpvORrMESjLtF4h3MwkhOPUHNSl5kwR
 CTCbzDwCM/QDqSeRcPliiiMNz8CvjJoYR6Vva6zRNVDvDXucbzl8hGYg02CNbTdvlqWJMt/rwNa
 dH5GSvKhjzvZjP/VwWg==
X-Proofpoint-ORIG-GUID: utq7jpreCVySu9MEmlUz-R45ftM9qB53
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfX7/ecK5ZFU8hm
 aeudQtEFSge2dF395+Z43j43et0fjFU35G6EBkdG1Y2ILzjkPHV0aWX0MNjNCcCEzmB8xtWIVTL
 IE597RaZGlhCmpF0xziChSkUKTxhmQE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190116
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

On 19/8/26 16:56, Philippe Mathieu-DaudÃ© wrote:
> Every target setting the cpu_exec_halt callback alias it to
> their cpu_has_work() function, making the callback redundant.
> 
> Call cpu_has_work() directly in accel/tcg/cpu-exec.c
> cpu_has_work_after_processing_async_events() and remove the
> boilerplate cpu_exec_halt hook registration. No functional
> impact expected.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/accel/tcg/cpu-ops.h    | 17 -----------------
>   accel/tcg/cpu-exec.c           | 23 ++++++++---------------
>   target/alpha/cpu.c             |  1 -
>   target/avr/cpu.c               |  1 -
>   target/hexagon/cpu.c           |  1 -
>   target/hppa/cpu.c              |  1 -
>   target/loongarch/tcg/tcg_cpu.c |  1 -
>   target/m68k/cpu.c              |  1 -
>   target/microblaze/cpu.c        |  1 -
>   target/mips/cpu.c              |  1 -
>   target/or1k/cpu.c              |  1 -
>   target/ppc/cpu_init.c          |  1 -
>   target/riscv/tcg/tcg-cpu.c     |  1 -
>   target/rx/cpu.c                |  1 -
>   target/s390x/cpu.c             |  1 -
>   target/sh4/cpu.c               |  1 -
>   target/sparc/cpu.c             |  1 -
>   target/tricore/cpu.c           |  1 -
>   target/xtensa/cpu.c            |  1 -
>   19 files changed, 8 insertions(+), 49 deletions(-)


> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 54561ed31c1..bfdc42ab6a0 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -48,7 +48,6 @@
>   #include "internal-common.h"
>   #if !defined(CONFIG_USER_ONLY)
>   #include "accel/tcg/iommu.h"
> -#include "hw/core/sysemu-cpu-ops.h"
>   #endif
>   
>   /* -icount align implementation. */
> @@ -659,21 +658,16 @@ static bool cpu_has_work_after_processing_async_events(CPUState *cpu)
>   {
>       const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
>   
> +    if (tcg_ops->process_async_events) {
> +        tcg_ops->process_async_events(cpu);
> +    }
> +
> +    if (!cpu_has_work(cpu)) {
> +        return false;
> +    }
> +
>       if (tcg_ops->transition_halt_to_exec) {
> -        assert(!tcg_ops->cpu_exec_halt);
> -        if (tcg_ops->process_async_events) {
> -            tcg_ops->process_async_events(cpu);
> -        }
> -        if (!cpu_has_work(cpu)) {
> -            return false;
> -        }
>           tcg_ops->transition_halt_to_exec(cpu);
> -    } else {
> -        assert(!tcg_ops->process_async_events);
> -        assert(cpu->cc->sysemu_ops->has_work == tcg_ops->cpu_exec_halt);
> -        if (!tcg_ops->cpu_exec_halt(cpu)) {
> -            return false;
> -        }
>       }

Hmm maybe I should squash:

-- >8 --
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 22fae41125f..9761bb173c1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -874,8 +874,6 @@ static void arm_cpu_transition_halt_to_exec(CPUState 
*cs)
  {
      ARMCPU *cpu = ARM_CPU(cs);

-    assert(cpu_has_work(cs));
-
      /* We're about to come out of WFI/WFE: disable the WFxT timer */
      if (cpu->wfxt_timer) {
          timer_del(cpu->wfxt_timer);
diff --git a/target/i386/tcg/system/seg_helper.c 
b/target/i386/tcg/system/seg_helper.c
index 7a3f14a255e..cbea6bebeb5 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -145,8 +145,6 @@ void x86_cpu_transition_halt_to_exec(CPUState *cpu)
      X86CPU *x86_cpu = X86_CPU(cpu);
      CPUX86State *env = cpu_env(cpu);

-    assert(cpu_has_work(cpu));
-
      /* Complete HLT instruction.  */
      if (env->eflags & TF_MASK) {
          env->dr[6] |= DR6_BS;
---

