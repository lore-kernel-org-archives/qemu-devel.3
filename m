Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58550C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QQk-0001RJ-0j; Wed, 23 Sep 2026 13:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x9QQX-0001Pd-OF; Wed, 23 Sep 2026 13:06:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x9QQV-0000Tw-NV; Wed, 23 Sep 2026 13:06:37 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGZf772048454; Wed, 23 Sep 2026 17:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zWGjU/
 M1WYqjhnXAPKwvwXGPNvk9RUZzu9O6HyEfUmw=; b=L/0tyva3R95gTmi63zHDYw
 JZnNgW+HSr3R6xRovuaKwdXI4kjpuJ+j7+UMA0ty2rz+Q7jGD14RXUuyF7UGSUTB
 aeb+LKE09K75GeWWREnbayb4GW8fpaTn/REqMPYIJIPKIVuOvPiGAcgWajLm/cem
 rBY8NYMDIv1yvsIRdNagv0B2axl4p1fOXTjw0zdLLtYZW5NIyIyGg8Brfwn0xX5k
 JpLIRxYrCHJFJKv99LPMJe5h4L+U4GwwBIJxaDA7JqCk6UvyGJObPvb/VdN+WpYB
 iHRGhOTgEJUqGQEG0FaHtBgErTiIqUBQOiSBZ+BAdpQ4T1b77FLLceelOdanzcGQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1vkv2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 17:06:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGWrYc664754; Wed, 23 Sep 2026 17:06:28 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1t0ap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 17:06:28 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68NH6Qqu66846996
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 17:06:27 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94C045806B;
 Wed, 23 Sep 2026 17:06:26 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 760385805E;
 Wed, 23 Sep 2026 17:06:25 +0000 (GMT)
Received: from [9.61.145.93] (unknown [9.61.145.93])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 17:06:25 +0000 (GMT)
Message-ID: <949036a7-7047-4d56-a166-ceb0394d225b@linux.ibm.com>
Date: Wed, 23 Sep 2026 13:06:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/17] target/s390x: Use S390CpuState for CPU state APIs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Jason Herne <jjherne@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260922164936.15189-1-philmd@oss.qualcomm.com>
 <20260922164936.15189-5-philmd@oss.qualcomm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20260922164936.15189-5-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Qbloq9ycsz6t1saynsIe7-XlrwEkebTa
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab40715 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=EUspDBNiAAAA:8
 a=S4GsGaMB0scFxpZtrYwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX7+pSKM4wk/wm
 CPgKgLq0x80vl9jlt/Df9jLcj1tVbQ1hrzLmRU9s8Uhx53zaT6R76zEYjTHyC8uAHuKIz4vo5Pd
 bcLFHv6/9HfC03kkBy2aJEWkqyTwV84=
X-Proofpoint-GUID: Qbloq9ycsz6t1saynsIe7-XlrwEkebTa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX9Xh7lInYVVut
 UEQUwQOc6aHqSO8QLZba33YgHH1MaEo1Uma0HEpPLVvYxcrFc9m+dD2AGBWQ0d1CpQfklFlq1zD
 0BDAd4eknVeUdLsheKlzDhfB8+9qAZF7fPfQPsAKHZpfsKOTGBJPtUbVqIKm3/Gzdd+AtbWwSol
 PzybeABkhn1+vOPxenk1eBKd7RUno0OjPoLx3Owk0dHpFo14gW/kvZCG/GzVk1EE8uluRBsD4R5
 BuNCIBcrYcFT+iWNyptN03PIPTebmrC3q4sM2EFzKUmkmmzMBoql7Zd+olRGk6nENwSFFoWS36t
 IkEMUqhVvQnVjSMmde9/YBfwGs2+xsRgu6KVERl/zw71o+/k2hgXm/UeVAKdSdScajuTTGRN5PV
 pb8vwhxrm647HeruJGn0vqYibMl8epi2JblWGSPs4MTn7CEEFEPznGwf6MVBxAqnEJe7Sv7USLQ
 tEEmfHNOV6aKMwrQZdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230068
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 9/22/26 12:49 PM, Philippe Mathieu-Daudé wrote:
> Use the QAPI S390CpuState enum for CPU state accessors instead
> of uint8_t. Handle state checks with switch statements and assert
> unexpected states in SIGP restart and stop handling.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
> FIXME: g_assert_not_reached -> break?

Yes, please.

Those orders sent against any other cpu state should be NOPs, rather 
than a fatal assertion.

> ---
>   target/s390x/cpu.h           |  6 +++---
>   target/s390x/kvm/kvm_s390x.h |  2 +-
>   hw/intc/s390_flic.c          |  7 +++++--
>   target/s390x/cpu-system.c    | 18 ++++++++++++------
>   target/s390x/kvm/kvm.c       |  2 +-
>   target/s390x/kvm/stubs.c     |  2 +-
>   target/s390x/sigp.c          |  6 +++++-
>   7 files changed, 28 insertions(+), 15 deletions(-)

The rest of this looks fine to me.

> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 2d1dcc7045c..bf9f6ed1de2 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -847,13 +847,13 @@ void s390_do_cpu_set_diag318(CPUState *cs, run_on_cpu_data arg);
>   int s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch_id,
>                                   int vq, bool assign);
>   #ifndef CONFIG_USER_ONLY
> -void s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu);
> +void s390_cpu_set_state(S390CpuState cpu_state, S390CPU *cpu);
>   #else
> -static inline void s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
> +static inline void s390_cpu_set_state(S390CpuState cpu_state, S390CPU *cpu)
>   {
>   }
>   #endif /* CONFIG_USER_ONLY */
> -static inline uint8_t s390_cpu_get_state(const S390CPU *cpu)
> +static inline S390CpuState s390_cpu_get_state(const S390CPU *cpu)
>   {
>       return cpu->env.cpu_state;
>   }
> diff --git a/target/s390x/kvm/kvm_s390x.h b/target/s390x/kvm/kvm_s390x.h
> index 3c4fa0489cf..b1ff66f04e3 100644
> --- a/target/s390x/kvm/kvm_s390x.h
> +++ b/target/s390x/kvm/kvm_s390x.h
> @@ -22,7 +22,7 @@ int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
>   int kvm_s390_mem_op_pv(S390CPU *cpu, vaddr addr, void *hostbuf, int len,
>                          bool is_write);
>   void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
> -int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
> +int kvm_s390_set_cpu_state(S390CPU *cpu, S390CpuState cpu_state);
>   void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
>   int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
>   int kvm_s390_get_hpage(void);
> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> index 57fd4b2b81c..b5256b3ba88 100644
> --- a/hw/intc/s390_flic.c
> +++ b/hw/intc/s390_flic.c
> @@ -193,8 +193,11 @@ static void qemu_s390_flic_notify(uint32_t type)
>           cpu_set_interrupt(cs, CPU_INTERRUPT_HARD);
>   
>           /* ignore CPUs that are not sleeping */
> -        if (s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING &&
> -            s390_cpu_get_state(cpu) != S390_CPU_STATE_LOAD) {
> +        switch (s390_cpu_get_state(cpu)) {
> +        case S390_CPU_STATE_LOAD:
> +        case S390_CPU_STATE_OPERATING:
> +            break;
> +        default:
>               continue;
>           }
>   
> diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
> index 52561fffa3a..fffac09f241 100644
> --- a/target/s390x/cpu-system.c
> +++ b/target/s390x/cpu-system.c
> @@ -44,8 +44,11 @@ bool s390_cpu_has_work(CPUState *cs)
>       S390CPU *cpu = S390_CPU(cs);
>   
>       /* STOPPED cpus can never wake up */
> -    if (s390_cpu_get_state(cpu) != S390_CPU_STATE_LOAD &&
> -        s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING) {
> +    switch (s390_cpu_get_state(cpu)) {
> +    case S390_CPU_STATE_LOAD:
> +    case S390_CPU_STATE_OPERATING:
> +        break;
> +    default:
>           return false;
>       }
>   
> @@ -202,12 +205,15 @@ unsigned s390_count_running_cpus(void)
>       int nr_running = 0;
>   
>       CPU_FOREACH(cpu) {
> -        uint8_t state = S390_CPU(cpu)->env.cpu_state;
> -        if (state == S390_CPU_STATE_OPERATING ||
> -            state == S390_CPU_STATE_LOAD) {
> +        switch (s390_cpu_get_state(S390_CPU(cpu))) {
> +        case S390_CPU_STATE_LOAD:
> +        case S390_CPU_STATE_OPERATING:
>               if (!disabled_wait(cpu)) {
>                   nr_running++;
>               }
> +            break;
> +        default:
> +            break;
>           }
>       }
>   
> @@ -236,7 +242,7 @@ void s390_cpu_unhalt(S390CPU *cpu)
>       }
>   }
>   
> -void s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
> +void s390_cpu_set_state(S390CpuState cpu_state, S390CPU *cpu)
>    {
>       trace_cpu_set_state(CPU(cpu)->cpu_index, cpu_state);
>   
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index 6622886032e..dc67e848864 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -2007,7 +2007,7 @@ int kvm_s390_get_ri(void)
>       return cap_ri;
>   }
>   
> -int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
> +int kvm_s390_set_cpu_state(S390CPU *cpu, S390CpuState cpu_state)
>   {
>       struct kvm_mp_state mp_state = {};
>       int ret;
> diff --git a/target/s390x/kvm/stubs.c b/target/s390x/kvm/stubs.c
> index ebf3c83994d..c5ec7d3f1d3 100644
> --- a/target/s390x/kvm/stubs.c
> +++ b/target/s390x/kvm/stubs.c
> @@ -128,7 +128,7 @@ int kvm_s390_mem_op_pv(S390CPU *cpu, vaddr addr, void *hostbuf, int len,
>       g_assert_not_reached();
>   }
>   
> -int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
> +int kvm_s390_set_cpu_state(S390CPU *cpu, S390CpuState cpu_state)
>   {
>       g_assert_not_reached();
>   }
> diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
> index 1801b8caa6e..6e3367e2725 100644
> --- a/target/s390x/sigp.c
> +++ b/target/s390x/sigp.c
> @@ -39,7 +39,7 @@ static void set_sigp_status(SigpInfo *si, uint64_t status)
>   
>   static void sigp_sense(S390CPU *dst_cpu, SigpInfo *si)
>   {
> -    uint8_t state = s390_cpu_get_state(dst_cpu);
> +    S390CpuState state = s390_cpu_get_state(dst_cpu);
>       bool ext_call = dst_cpu->env.pending_int & INTERRUPT_EXTERNAL_CALL;
>       uint64_t status = 0;
>   
> @@ -221,6 +221,8 @@ static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
>           cpu_synchronize_state(cs);
>           s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
>           break;
> +    default:
> +        g_assert_not_reached();
>       }
>       si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
>   }
> @@ -362,6 +364,8 @@ static void sigp_restart(CPUState *cs, run_on_cpu_data arg)
>       case S390_CPU_STATE_OPERATING:
>           cpu_inject_restart(cpu);
>           break;
> +    default:
> +        g_assert_not_reached();
>       }
>       si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
>   }


