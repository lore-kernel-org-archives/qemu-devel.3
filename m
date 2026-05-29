Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6292BCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 18:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT23Q-0004jB-AT; Fri, 29 May 2026 14:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wT23N-0004hm-H8
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:35:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wT23J-0000ly-Kp
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:35:28 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2In7589662
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 18:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UCcuDhd/yYEud3f9ZIoVNZvSDJ2OwXA/S56pjq8bWkY=; b=Jexp0ArBlLbAzrhu
 /TrmzAj8kVFtwkyP2ij2V4EIGWIzHIxxETvfXsYww/f0C1rQY6FzaJHT3Mnpjff5
 c+VQDMuoCfcKBCmCYYo0TX21gJAsam8Rlyc72FgTy342+p0u1NGiyjgL0KJFcHZf
 Eokfy9MgL6S2Zmtm4oR+CJYs26yLo3T0KAPjR0g6gKWOjGrlFDAMNOD841VgT1Ab
 aHXGxffz7WgoOyobqR7HPKm6LTGVVzWTu21mcGK21MpgamUh96X80MwNyjs/xFq/
 NPyePIJKM5bcFa56opOgxBpt5z/S3RCTmAr9QHFgCBAluDraVktFtT405FXs9Fxj
 Cw83uA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef8rcjjfy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 18:35:23 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304ec73b015so515285eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780079722; x=1780684522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UCcuDhd/yYEud3f9ZIoVNZvSDJ2OwXA/S56pjq8bWkY=;
 b=eCaVqdlMIipjrgfv/+31XrDtpeBVEQSI2il6jM/B6wcUIhbGPsLiMcRV6GiWEuCqzA
 6H7AsMRN3wu19znA40b9qOIWeh4pcII+wrkMvVwNsnzMmOK+m/m9Y+KeNcSs9u1UXOwy
 rbqlRy5gHMmVjFgCKBTcLQjqVjNnj6pIsdlhHBsje8+zoZD/sSm5fUPQKLPCBlE03Z+a
 R0MM8ekPMrpBYwtqR+iEr/BR+1Vb9YQEmPQvQ82ZrZyjOt8XZrveWoKoOU1jbHdSFwZo
 IFImbcB6nDPvq2LJo4NGkORYiTF7b/spncC7AsnLlDahQrNsgjGiaHvfICeKwfzvejJR
 4jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780079722; x=1780684522;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UCcuDhd/yYEud3f9ZIoVNZvSDJ2OwXA/S56pjq8bWkY=;
 b=FGEiGDTA+in28X/X86VhPIoNW94Ry7ucQUWuwQq1bpZFgE7iQR6wGQ4meV12/FskHc
 6cWdlqC/+qtHmwsnk2dFcJeT0onadmBkvPJSsRcqLu7NUjwqVsoEye7WMz3X2j2ARxeR
 w7cG1crSPkbriM3TZ+4N0Z/qJKq1vN0/w5Tp/GMy/DANTuuOFoVUJCG4EWQChkpce4DY
 ZokIjNrMe3I1JsagNM1mh5q4MMjEhTEhPlQvZWyPqJdx65PhHIzSYcCQGNQIFUPtQCwg
 wMd/IzJAEsY3AeSzNj4IJVHuycEINUV5taCZLkag3zR8OSdLZ72GXMJbCAYMolcdpNEN
 s69Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/kF9A+T+yI5SyodvaVTzzjBrj9o/9bv0qdObvDQLWaPTWg49pQlpRBszZR7H37+Y2J6LRzniFQrouF@nongnu.org
X-Gm-Message-State: AOJu0YwjyfXtoLYkGT3RfbbBmaj3NhBupKgEOBrE+phsKzUhIjeu4/cX
 mks5jP6OOrYeGrZinWcm2gMs7wdIZHoCsj5Rh7OAUymTHQsql35RGntuXvhyqOP6Gx0XUHa2bS9
 dglQxbP+IBtCug1MFchuBtzxcdj5IrcbCVK0F2t0tgFku8RVF+TOxunFEWw==
X-Gm-Gg: Acq92OEQ0DfIx7oBLHy3mR8chDxom1gIDYl8C5/rmAeJle/ylRB9yfqnRZYZgj7mtLw
 ic9hmOTxoCGmTs9DfzfDkL/88HvM3WUTYzYcP+puUG11gQmAwyYEua/rjo5jKnNkBumAM9+Nzeb
 37zQlngE56e+Do8w09fD5YvMQ8TOMv/nSYuEG6FpS8+y849jIcvHbEIELGk+IeCvc/7jCvQobfk
 kagbyrZs/nMpIXLT3xtaQCj5VrVQ8U4pJr13fsEBQApmvA5kMAtwcTIZCpcjiTYh8rk8EbUda2E
 koOCA7BsxFLm7GFhVGXf/sNzh6fPmiAfHMoj9b0kclssR6+ENY78mx40ZqPhAxhE5+EGL4jucUw
 E2y1KMhOB0LzPrRvQQGATW2or4DnGQnXWFnFpOHDdXb1o6H7DJu8it+jMh/9ViLtV6AMywiXPJY
 MDmGqK1tvUFGZgOXblAot6Amhc
X-Received: by 2002:a05:7300:7495:b0:2db:2089:460f with SMTP id
 5a478bee46e88-304fa5eb2e3mr516680eec.19.1780079722084; 
 Fri, 29 May 2026 11:35:22 -0700 (PDT)
X-Received: by 2002:a05:7300:7495:b0:2db:2089:460f with SMTP id
 5a478bee46e88-304fa5eb2e3mr516664eec.19.1780079721461; 
 Fri, 29 May 2026 11:35:21 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed130dafsm1975612eec.0.2026.05.29.11.35.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 11:35:20 -0700 (PDT)
Message-ID: <d85a57cd-0f90-4930-9bd7-1f29c2526a25@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:35:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] accel/kvm: Remove need for
 AccelCPUClass::cpu_target_realize
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260529142434.87880-1-philmd@linaro.org>
 <20260529142434.87880-6-philmd@linaro.org>
 <179357ae-8d50-49e5-abc5-8abf670be847@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <179357ae-8d50-49e5-abc5-8abf670be847@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iz6Zxld5-I8UX-D-tEygcbQVZ3XnrN0C
X-Proofpoint-ORIG-GUID: iz6Zxld5-I8UX-D-tEygcbQVZ3XnrN0C
X-Authority-Analysis: v=2.4 cv=DuNmPm/+ c=1 sm=1 tr=0 ts=6a19dc6b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=kOTYBn2Tj0T_yd3JnKoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NSBTYWx0ZWRfXxIr/sjvsG6d7
 IFBayMJ07VvrkoxkKRO4YKIU68LhMHHPp4//XRDGLCwR/8tMtxDNvNx1qJdyrmlua2hhH2+7hC2
 kwUb3Ksv7afHpUIXoH3AgXgOr9qa68GBNwRTeLN5wjlIZubDQa0ARjTwm0h4LknKoX+632N8K8m
 gXR1uq/hexSX0xiSEUDr66ycK0FKdvEaXCcKP8usqZRzE7lmPvekg1iU4E7zgVM89IX8GeOArmx
 6Qw7wC07qFePAY4A9d46KC+ygbKBoM8o7bvxPYcWOUp4S+zXlpHJVtJhVHAnV0ywSGnAV6DTz9h
 xqg5YIr/N9lwNPk7baYPDcKrrAvSsP5bY455j7NdAP/6bEYPJa3v8HRXufSHM7jbf/yNyiHlL49
 VFSUexLKxmYskYnSo1ahBXvec/rxUobUxg2eq475DfbvpBUV8V3M8DFpTHa+uXpKbj0ZCxqppe1
 tg0lM0arvxwaroQDogQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290185
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

On 5/29/2026 11:32 AM, Pierrick Bouvier wrote:
> On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
>> accel_cpu_common_realize() first calls accel_cpu->cpu_target_realize
>> then ops->cpu_realize.
>>
>> Rather than having one handler for each host architecture, use a
>> single host-specific method (prefixed with kvm_arch_* like other
>> similar KVM methods). Register it once as AccelOpsClass
>> cpu_target_realize handler.
>>
>> PPC's ACCEL_CPU_NAME("kvm") TypeInfo is  now empty, remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>  include/system/kvm.h       |  2 ++
>>  accel/kvm/kvm-accel-ops.c  |  1 +
>>  target/i386/kvm/kvm-cpu.c  |  3 +--
>>  target/ppc/kvm.c           | 23 +----------------------
>>  target/riscv/kvm/kvm-cpu.c | 10 +---------
>>  5 files changed, 6 insertions(+), 33 deletions(-)
>>
>> diff --git a/include/system/kvm.h b/include/system/kvm.h
>> index 5fa33eddda3..fd7175ea9f5 100644
>> --- a/include/system/kvm.h
>> +++ b/include/system/kvm.h
>> @@ -364,6 +364,8 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
>>  int kvm_arch_init_vcpu(CPUState *cpu);
>>  int kvm_arch_destroy_vcpu(CPUState *cpu);
>>  
>> +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp);
>> +
>>  #ifdef TARGET_KVM_HAVE_RESET_PARKED_VCPU
>>  void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd);
>>  #else
>> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
>> index 6d9140e549f..4294c7a9514 100644
>> --- a/accel/kvm/kvm-accel-ops.c
>> +++ b/accel/kvm/kvm-accel-ops.c
>> @@ -97,6 +97,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
>>      AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
>>  
>>      ops->create_vcpu_thread = kvm_start_vcpu_thread;
>> +    ops->cpu_target_realize = kvm_arch_cpu_realize;
> 
> cpu_realize

Ignore, I was wrong, confused that with AccelCPUClass.

> 
>>      ops->cpu_thread_is_idle = kvm_vcpu_thread_is_idle;
>>      ops->cpus_are_resettable = kvm_cpus_are_resettable;
>>      ops->synchronize_post_reset = kvm_cpu_synchronize_post_reset;
>> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
>> index c34d9f15c7e..36634ec8929 100644
>> --- a/target/i386/kvm/kvm-cpu.c
>> +++ b/target/i386/kvm/kvm-cpu.c
>> @@ -39,7 +39,7 @@ static void kvm_set_guest_phys_bits(CPUState *cs)
>>      }
>>  }
>>  
>> -static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>> +bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
>>  {
>>      X86CPU *cpu = X86_CPU(cs);
>>      X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
>> @@ -237,7 +237,6 @@ static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
>>  {
>>      AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
>>  
>> -    acc->cpu_target_realize = kvm_cpu_realizefn;
>>      acc->cpu_instance_init = kvm_cpu_instance_init;
>>  }
>>  static const TypeInfo kvm_cpu_accel_type_info = {
>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> index b94c2997a07..013f5e852e1 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -49,7 +49,6 @@
>>  #include "elf.h"
>>  #include "system/kvm_int.h"
>>  #include "system/kvm.h"
>> -#include "accel/accel-cpu-target.h"
>>  
>>  #include CONFIG_DEVICES
>>  
>> @@ -2353,7 +2352,7 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
>>      }
>>  }
>>  
>> -static bool kvmppc_cpu_realize(CPUState *cs, Error **errp)
>> +bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
>>  {
>>      int ret;
>>      const char *vcpu_str = (cs->parent_obj.hotplugged == true) ?
>> @@ -2995,23 +2994,3 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
>>  void kvm_arch_accel_class_init(ObjectClass *oc)
>>  {
>>  }
>> -
>> -static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
>> -{
>> -    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
>> -
>> -    acc->cpu_target_realize = kvmppc_cpu_realize;
>> -}
>> -
>> -static const TypeInfo kvm_cpu_accel_type_info = {
>> -    .name = ACCEL_CPU_NAME("kvm"),
>> -
>> -    .parent = TYPE_ACCEL_CPU,
>> -    .class_init = kvm_cpu_accel_class_init,
>> -    .abstract = true,
>> -};
>> -static void kvm_cpu_accel_register_types(void)
>> -{
>> -    type_register_static(&kvm_cpu_accel_type_info);
>> -}
>> -type_init(kvm_cpu_accel_register_types);
>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>> index 17ba38403a3..7c4440d0025 100644
>> --- a/target/riscv/kvm/kvm-cpu.c
>> +++ b/target/riscv/kvm/kvm-cpu.c
>> @@ -1990,14 +1990,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
>>      kvm_riscv_add_cpu_user_properties(obj);
>>  }
>>  
>> -/*
>> - * We'll get here via the following path:
>> - *
>> - * riscv_cpu_realize()
>> - *   -> cpu_exec_realizefn()
>> - *      -> kvm_cpu_realize() (via accel_cpu_common_realize())
>> - */
>> -static bool kvm_cpu_realize(CPUState *cs, Error **errp)
>> +bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
>>  {
>>      RISCVCPU *cpu = RISCV_CPU(cs);
>>      int ret;
>> @@ -2120,7 +2113,6 @@ static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
>>      AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
>>  
>>      acc->cpu_instance_init = kvm_cpu_instance_init;
>> -    acc->cpu_target_realize = kvm_cpu_realize;
>>  }
>>  
>>  static const TypeInfo kvm_cpu_accel_type_info = {
> 
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> Regards,
> Pierrick


