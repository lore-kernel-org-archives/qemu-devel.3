Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A29C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 17:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsO5t-0001VI-Fc; Fri, 07 Aug 2026 13:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsO5r-0001Pa-St
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 13:10:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsO5p-0001Rq-Od
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 13:10:51 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677GbXfO1474826
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 17:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6xvnrz2OLxqZ4lZC5Nk9PI9nrYEdoeL0ud8TQ1dIjR8=; b=PYR0x2aS4Op5ztFm
 3bAmZQarmWW/QIWqY00+cPcatGVEw+cVTbRV8M93jaW6m2XLKEk63dHzMrhcKSSt
 za7GO4LnvznFoZ/+4s6ilstxMk+o1yzAxD5CSY9uVj5VVcAaAFu6zYAIPcVhbL0K
 tFkw6ViX/KRTtZGv8oD4u1H/FB1PD8xPM7mZ5FSMa+NNK1L3Ee5fmKJLJHp22dSG
 wlLozz5LZxMZad4oWdMXvUBIeIf4PoOvbT3eU+xnBoll9hspHTi6bxCrLGX06VKK
 sLngQseyqnThtCg6XW3Enb934xHaa892Yi8Y70vQklUtf8zp9W814qi67IbvbOyB
 KEgSsg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwk228464-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 17:10:48 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52ce64c41efso60185301cf.3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786122647; x=1786727447; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6xvnrz2OLxqZ4lZC5Nk9PI9nrYEdoeL0ud8TQ1dIjR8=;
 b=h4h2moXF83o5tOxTvDFNvLxnXqYyT7IIkeHL9tclUPkMW8vxYMLuyiNj+c19p4Am5S
 k25S2YFcGENnoI0WAolwf2BtUEQjHei2S71kN5APIS84r73VH1StwYF1Qzv+Vory3Sdk
 ZzFWwDKWHaxkWbVGl0P1el386P6PKAYQqtKOljKOvgjmuKO1vbZctO2dxhiTpuu0FOAT
 n88E//Q4SOzCcwqsAD7JqRgbjQis8Cv8nDHM0DD7gpuB8MtLLH50wY/glCz41sj7R7qx
 ebQ7RBy3zNEnIozWBO5ZayqZZ/zz0T7wgmnrv5aQ2sVn/NTIec7SDavNuKElEKGMjzjJ
 SDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786122647; x=1786727447;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6xvnrz2OLxqZ4lZC5Nk9PI9nrYEdoeL0ud8TQ1dIjR8=;
 b=QMZ7tDTWSEkqwfHLsA+XHX/j51W3GSMRx79xDPV63/nJgWeNsgDrLjbVBh1IL6Dlt3
 GaKa5I6w231g3IA25lfZd6L9oGnfZqR1AxpCrUSv6xWTfTvX7fuObwlMd8NmO61W7GXw
 a6NHMRmojInUdLwCfiqEdmCvzW+/fUS91iD38WqzkNfF4kb7ztgfBj2q4W9hW3D8sYpA
 7LpYjcRnvXZP9EivjYwnyZBypnk3hgjA7Z2GcsrDxIpNkMfYTLU39CMXhUSXMeO//BqJ
 i+e/VFsmEUWb5vkB+DOXEf9/jBGlombGFVkB0kbJ5J7rxx7BIiX/QvhsXhob0BxQFF3W
 hkNA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoitHWqIlHK6Asziiui9SMIw6Qf4UPM4b+V5LAsf0YAEwz0xDOK2hMYvwlKh9BHiXmKxr3S29RX8IC7@nongnu.org
X-Gm-Message-State: AOJu0YyaUOFFc7JXcV09bf7KkOH0aFahWv/3UtyPO9HTG25ZlFTf352d
 vikECdslEj/tbqFhWnbW9zpMUBz7eMSE+e3RlpC/+ukqbw/UtXOeu+NBeh1cnqTNmO+ISSxFrUT
 BLiVJ441ZOIOz3GNSvAdaAjyhaEZwbFZs3LMWooeJph8760y+t8Xfr5HtXg==
X-Gm-Gg: AR+sD11L3vn0AAgp3w/sTxtq58uaTIwzaBO1md+zJJn49+2/9NRfTyAHBNRSAVqJy+0
 Q77ZyG7mY8UUjuk35rACvZK0Y0ogGyUXFxBeGnw09V7MH/mQDhDUUXXAKhQsH4rdf7cYUM14rMQ
 wbIO65lNzL73h0Tj5C7ZTXFqSKVXG5ncnaHFlh4kB3sirQ5PGr6rQCqpPPa2QufzZgVDhhCzsho
 anTAYaTX5vf9+9dfEY3lKCOivmotAFO13yE80rNbKlp3DUXbbTPrrcaTgVxguBZvyyS+SCm7YI3
 /GMxBQeWLh/V6T0OtEZ/p8rOc1xDRiNLICDjsN5ZZcqCqtAfyd/2tcJ7t9fCqnLx1GvaflQ2fMn
 td/rkvjVSdM8jYBL+WnSARv2dlqG/pubks1Q8
X-Received: by 2002:a05:622a:5c07:b0:51c:1a46:9148 with SMTP id
 d75a77b69052e-52ce61934eamr287088631cf.34.1786122647568; 
 Fri, 07 Aug 2026 10:10:47 -0700 (PDT)
X-Received: by 2002:a05:622a:5c07:b0:51c:1a46:9148 with SMTP id
 d75a77b69052e-52ce61934eamr287087551cf.34.1786122647046; 
 Fri, 07 Aug 2026 10:10:47 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908a918dd24sm13148936d6.8.2026.08.07.10.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 10:10:46 -0700 (PDT)
Message-ID: <d1927686-e0ba-4bd3-8570-307838d77cb7@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 14:10:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] target/riscv/kvm: Preserve MP state across
 migration
To: Xie Bo <xb@ultrarisc.com>, qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com, qemu-riscv@nongnu.org, alistair23@gmail.com,
 pbonzini@redhat.com, anup@brainfault.org, alistair.francis@wdc.com,
 rkrcmar@ventanamicro.com, palmer@dabbelt.com
References: <20250915070811.3422578-1-xb@ultrarisc.com>
 <20260730051926.7322-1-xb@ultrarisc.com>
 <20260730051926.7322-3-xb@ultrarisc.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260730051926.7322-3-xb@ultrarisc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QzZ2frU50vhmfzGd5dhmm2VLobOritzm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzNCBTYWx0ZWRfX51G1ATJ21EDw
 3/OudaYj0XIxdLMrhlOy2hZrFsU3aLaqYsd0ocItrxUMStELIuF5VwICucXcx2Dn3iK+meLEFUI
 o7oqJnaHa+gsK1EQPKgxXO1lDU3MDoNzQw35V5weubUt+DD4Kz+Pok6p+jw4QlYCeYYIZHwLxQ4
 AXLoUoeNNb6RW2Iag7d2ZnDvwKBCyUpW7dBWBWIolhWaR9Z7Hs5INrlOyn/hvnQiGUeM8vzI5QN
 WziRxKECKCYLjW/ZBgn+bu1AQuqgXNszLDAESq7lotdDStVri8LfWwX5Qd4dHKjAVLHjIZ99gQ/
 KhQSU/WABwtBV9ete5IxhFoBo/gqgrnZOacya4M5X0W8ZPpxr3WI+kQQAKhL3KbjmTjTd+Z4XqD
 G9cxNo/KT3weqIBdjgIa3frNnloriFOkJp07Z096O8ZDKzcNWtuASWE/mitHmtsoVq9mNHGBXnL
 /x2LBUY+2XGenx2Bg2g==
X-Authority-Analysis: v=2.4 cv=bcBbluPB c=1 sm=1 tr=0 ts=6a761198 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=Lx1EvxgrAAAA:8 a=EUspDBNiAAAA:8 a=Yql8k0NjKH2OSnoIS0cA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=ZFi1QaP_tuf8dODdgmj-:22
X-Proofpoint-GUID: QzZ2frU50vhmfzGd5dhmm2VLobOritzm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzNCBTYWx0ZWRfX2OwruERecCHM
 Eg4j7PUJP1pO0qbkyfqmNU9nNn8pmWRnvAah/uTRDhZ6J/LoA12FlaSIspxZSIeoC/LNn4YhkgZ
 Ml89GWmQUybA5OrtywnwjH6MgyofrOA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi,

On 7/30/2026 2:19 AM, Xie Bo wrote:
> RISC-V KVM initializes secondary vCPUs in KVM_MP_STATE_STOPPED, but QEMU
> does not save their runtime MP state. A destination therefore retains reset
> MP state after migration and cannot reliably resume all vCPUs.
> 
> Save KVM_GET_MP_STATE in a capability-gated KVM VMState subsection and
> restore it on KVM_PUT_FULL_STATE. Keep the existing reset initialization
> path unchanged. Track whether the subsection was loaded so migration
> streams from older QEMU versions retain their previous destination reset
> behavior.
> 
> Using a subsection avoids changing the generic RISC-V CPU VMState version
> and keeps the state out of TCG migration streams.
> 
> Signed-off-by: Xie Bo <xb@ultrarisc.com>
> ---
>   target/riscv/cpu.h           |  4 +++
>   target/riscv/kvm/kvm-cpu.c   | 50 ++++++++++++++++++++++++------------
>   target/riscv/kvm/kvm_riscv.h |  2 +-
>   target/riscv/machine.c       | 45 ++++++++++++++++++++++++++++++++
>   4 files changed, 84 insertions(+), 17 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c9dfa7daff..e980b5964d 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -538,6 +538,10 @@ struct CPUArchState {
>       uint64_t kvm_timer_compare;
>       uint64_t kvm_timer_state;
>       uint64_t kvm_timer_frequency;
> +
> +    /* KVM multiprocessor state */
> +    uint32_t kvm_mp_state;
> +    bool kvm_mp_state_loaded;
>   #endif /* CONFIG_KVM */
>   };
>   
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 8218832fbe..cc5655d46d 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1374,25 +1374,35 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>           return ret;
>       }
>   
> +    if (cap_has_mp_state) {
> +        struct kvm_mp_state mp_state;
> +
> +        ret = kvm_vcpu_ioctl(cs, KVM_GET_MP_STATE, &mp_state);
> +        if (ret) {
> +            return ret;
> +        }
> +        RISCV_CPU(cs)->env.kvm_mp_state = mp_state.mp_state;
> +    }
> +
>       return ret;
>   }
>   
> -int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state)
> +bool kvm_riscv_has_mp_state(void)
>   {
> -    if (cap_has_mp_state) {
> -        struct kvm_mp_state mp_state = {
> -            .mp_state = state
> -        };
> +    return cap_has_mp_state;
> +}
>   
> -        int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
> -        if (ret) {
> -            fprintf(stderr, "%s: failed to sync MP_STATE %d/%s\n",
> -                    __func__, ret, strerror(-ret));
> -            return -1;
> -        }
> +static int kvm_riscv_put_mp_state(CPUState *cs)
> +{
> +    struct kvm_mp_state mp_state = {
> +        .mp_state = RISCV_CPU(cs)->env.kvm_mp_state,
> +    };
> +
> +    if (!cap_has_mp_state) {
> +        return 0;
>       }
>   
> -    return 0;
> +    return kvm_vcpu_ioctl(cs, KVM_SET_MP_STATE, &mp_state);
>   }
>   
>   int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
> @@ -1431,10 +1441,18 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
>       }
>   
>       if (KVM_PUT_RESET_STATE == level) {
> -        RISCVCPU *cpu = RISCV_CPU(cs);
> -        int state = cs->cpu_index == 0 ? KVM_MP_STATE_RUNNABLE
> -                                       : KVM_MP_STATE_STOPPED;
> -        ret = kvm_riscv_sync_mpstate_to_kvm(cpu, state);
> +        CPURISCVState *env = &RISCV_CPU(cs)->env;
> +
> +        env->kvm_mp_state = cs->cpu_index == 0 ? KVM_MP_STATE_RUNNABLE
> +                                               : KVM_MP_STATE_STOPPED;
> +        env->kvm_mp_state_loaded = false;
> +        ret = kvm_riscv_put_mp_state(cs);
> +        if (ret) {
> +            return ret;
> +        }
> +    } else if (KVM_PUT_FULL_STATE == level &&
> +               RISCV_CPU(cs)->env.kvm_mp_state_loaded) {
> +        ret = kvm_riscv_put_mp_state(cs);
>           if (ret) {
>               return ret;
>           }
> diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
> index b2bcd1041f..61eaa12443 100644
> --- a/target/riscv/kvm/kvm_riscv.h
> +++ b/target/riscv/kvm/kvm_riscv.h
> @@ -28,7 +28,7 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>                             uint64_t aplic_base, uint64_t imsic_base,
>                             uint64_t guest_num);
>   void riscv_kvm_aplic_request(void *opaque, int irq, int level);
> -int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
> +bool kvm_riscv_has_mp_state(void);
>   void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
>   uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu);
>   
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 0ab613a298..26ecee2a48 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -25,6 +25,9 @@
>   #include "exec/icount.h"
>   #include "target/riscv/tcg/debug.h"
>   #include "hw/riscv/machines-qom.h"
> +#ifdef CONFIG_KVM
> +#include "kvm/kvm_riscv.h"
> +#endif
>   
>   static bool pmp_needed(void *opaque)
>   {
> @@ -222,6 +225,44 @@ static const VMStateDescription vmstate_kvmtimer = {
>           VMSTATE_END_OF_LIST()
>       }
>   };
> +
> +static int riscv_cpu_kvm_pre_load(void *opaque)
> +{
> +    RISCVCPU *cpu = opaque;
> +
> +    cpu->env.kvm_mp_state_loaded = false;
> +    return 0;
> +}
> +
> +static bool kvm_mp_state_needed(void *opaque)
> +{
> +    return kvm_enabled() && kvm_riscv_has_mp_state();
> +}
> +
> +static int kvm_mp_state_post_load(void *opaque, int version_id)
> +{
> +    RISCVCPU *cpu = opaque;
> +    CPURISCVState *env = &cpu->env;
> +
> +    if (!kvm_enabled() || !kvm_riscv_has_mp_state()) {
> +        return -ENOTSUP;
> +    }
> +
> +    env->kvm_mp_state_loaded = true;
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_kvm_mp_state = {
> +    .name = "cpu/kvm-mp-state",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = kvm_mp_state_needed,
> +    .post_load = kvm_mp_state_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(env.kvm_mp_state, RISCVCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
>   #endif
>   
>   static bool debug_needed(void *opaque)
> @@ -459,6 +500,9 @@ const VMStateDescription vmstate_riscv_cpu = {
>       .name = "cpu",
>       .version_id = 11,
>       .minimum_version_id = 11,

Adding a .pre_load and a subsection requires a vmstate version_id bump,
i.e. we need to bump version_id and minimum_version_id to 12.

With this change:


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


> +#ifdef CONFIG_KVM
> +    .pre_load = riscv_cpu_kvm_pre_load,
> +#endif
>       .post_load = riscv_cpu_post_load,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT64_ARRAY(env.gpr, RISCVCPU, 32),
> @@ -522,6 +566,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>           &vmstate_rv128,
>   #ifdef CONFIG_KVM
>           &vmstate_kvmtimer,
> +        &vmstate_kvm_mp_state,
>   #endif
>           &vmstate_envcfg,
>           &vmstate_debug,


