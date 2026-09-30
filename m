Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB718CA5FAC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBuR8-0002XQ-JM; Wed, 30 Sep 2026 09:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBuQa-0002Uq-Ra
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 09:33:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBuQX-0005fA-1S
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 09:32:56 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UB8TmP3796647
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 13:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c/TROTiSD+evJFLgbvxl3ZTsPrXv6R/qqiDmdugwz40=; b=QJ0f5VXuYk4icDrQ
 4NvZs5XsXAddSPI6m57dFniIGW16wYHy+MqmYaevwP9dSlAc3RJNLb8HHx0wqfsc
 uTSYJAixAlr9n05ewX+4q2ggYwXe6/pJyWFKMEpDtI9FuogAWf/NNy030mE8VRgw
 mmFgmvFHbVRoff162r6BCXnpiqHDc/tXDyTqDBQd7upd60VReMtBT/Q2SSIRdLWl
 vJ4Nk/3CNIeOr1SKMY/WKj/Oo2pw50UmpoCGfaBNIE5O7ni4Zx/X1vEvaj0WZ81Z
 F7y9nLAaCqXfltmhE7NAd8bfcLYmHyxKPouwI3UrudNmt3ZG06KMr0+jCRb4WaxD
 Kkekhg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0nm3kn9t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 13:32:51 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-791463ed29dso4491093137.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 06:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790775171; x=1791379971; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=c/TROTiSD+evJFLgbvxl3ZTsPrXv6R/qqiDmdugwz40=;
 b=Rc1upe63yvxqBKS7Mq1SQGs0XqUffE5JD2rUwLdgp1ore5I9mCI9tU7iZxQAI55KdT
 7ANmEo3Qp1d39iKqwsM1xrapZ6nDgPvQX1UVqPUmrjP+TsvPtGXO7UoToHnMsg6CMRrl
 F7jvq3KHLtIP7keTSOLqG/gTuD1qnAKzH+x1OH83AwOClY4hJ0ZegHqLLRH6RCGMhhhR
 JD45tVpxP+FD75IR1nrZ8QrT94UNNJ7NVHcHJU9niF4+T/zkjyjDYzOZAVKetZvuwvu+
 ykDqGu4oVDY7YVGgU8jdCHZXcDs7NhhFtF1OdzOuxefQcVkJjgMdmxTg2sMrrtakJw/U
 ExdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775171; x=1791379971;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c/TROTiSD+evJFLgbvxl3ZTsPrXv6R/qqiDmdugwz40=;
 b=e2YCqfApIhw4JL0kv9eRwze7eynMfvha7MfUsb08ybtkcLwJv3hjTwU8OtmSCTV8fb
 cljnPDsyc1NDKAy7Jffn4hLz0+l71nbyGg+QA1r+UDGkPBUIL5qg9Nb67bjMOCuHMZS0
 agacPGi1PF2z/eroWEW0HYCRRlRgg3eyrpN3gdgo08DzUaGZzZF/Kd12xItRNU0ZKcMx
 IU9XuOo5xmPoxnG0s2JF803rGdWQYlo4LWYkJ8MEey/BZvCUTQ7TG2Fibs5EBL8Pssrb
 dbrN0xOf+T6bEOD5fiJgfq6JPwhKdsqt7SgR/uO2E8YZBNlz+XvwXYpzrKIM75QV9HoR
 vJ/g==
X-Forwarded-Encrypted: i=1;
 AKwUvByMdwENNsSsQGiO6Yhsbh2G1e7AqCl+6xRx/M/vYc7pA9++5tURtpGBBlvr25I5314MUhiWUKfrq3FD@nongnu.org
X-Gm-Message-State: AFq9FYLgoSpcQi5sjFnPJLyWKRKVzt+qQFFf5YYF2MqkLXau9itcKqSk
 Yu7XINhrmGPTVlI1ncUqg8IX0VJTAA7tMDM+rn8FAcwe4VTNiM9obUJ9CIUapwPdK/taElzMgJi
 GFAPhVA+Oe/vWeADd/uFilr2TH2OChjdvdhz0AzvCha8lug+L251A2NPyKQ==
X-Gm-Gg: AYBFou1OG+s+Ypn2Okg3Z+EEkKJQgv6K8UTVqRi3Eb00vnPxLIDQiXjeJCQ9wQcHVGK
 rZK3cnBfg5loYpHWAWdVu5INhbELF1XZyvyZ/K8NLLxmLRCYyUBSRJ3x+e9/pZcW8tnOdL4aE1r
 LEPOPUaJhebDGxYIDT1Tb8NID4pNwSFw1FwyK7Zb9yS5ywbb1+CMAFSGftGDPguXxgDiWuxT4UI
 Y+2ywFuVIopJCF+z3zqkr96ah5HMelQS+ooUn/R6GEMALe9AD02Za88pbJ3WwIqj6mHY9Ehbqb2
 pFTOavpQNUXYji7KM0mq3MeVkeKMTZqTfYrdKKxSn/vDumewMjBt5OnDI2v7MeCxC6UFGy+N9/3
 fliE9+egClkKrNQWcLSh8NBEo9XBMMbV+Ig==
X-Received: by 2002:a05:6102:54a1:b0:7b2:c1b1:1d0 with SMTP id
 ada2fe7eead31-7be729ac2a0mr368127137.11.1790775170660; 
 Wed, 30 Sep 2026 06:32:50 -0700 (PDT)
X-Received: by 2002:a05:6102:54a1:b0:7b2:c1b1:1d0 with SMTP id
 ada2fe7eead31-7be729ac2a0mr368100137.11.1790775169962; 
 Wed, 30 Sep 2026 06:32:49 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01ca32a44sm12402295e9.0.2026.09.30.06.32.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 06:32:49 -0700 (PDT)
Message-ID: <0d4948b7-21f7-498d-b198-66ce4b7c51f1@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 15:32:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/24] target/riscv: gate riscv_cpu_update_mip with
 tcg_enabled()
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
 <20260703180538.3346781-17-daniel.barboza@oss.qualcomm.com>
 <fa90ae0b-3846-45e0-beba-269fc2423f6b@oss.qualcomm.com>
In-Reply-To: <fa90ae0b-3846-45e0-beba-269fc2423f6b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2R9qnaW5Z-sh7non8YHN0x2adkKNZ6Os
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1MyBTYWx0ZWRfX1KCIh6ihGk+T
 x28xfXlC7QoXxXK5eVFReXkDLUYsnnV0Utg/Ozl3McFUgjdClGwBZNjQrq/VRpERnDxPazJCJYk
 CqwdM3pSFTW8EierUM3LOIpkKCKVSlBiR0RJTWYFL9+imvZ5SZQsdaq0Uw4ummwjjeQeWG3S+pF
 ClFrgHM2ci1kb5y4ixkEmYNkAbIgYQeU2lYags99OWEf4iohKzx8v5uMla9o77Zm+87etwOlmg0
 Sz+aOdmqwkshPDNq2CbRfeWU1FJp452GAN+bprnDL5zMg8NoIrkNU+LmnAN6zjoJfZMRFQEGpJZ
 /pwLxjeu05iJvJtBlscmETRFE8TIGWDN46Op0kSBtmwq8lRcSbamoXW5bkn1wNXo1iHOyzxlsR+
 BykNwh1AsoXLu28F8P4W8HoY3+dS/aeuWy+3IxfFqH0WwqzNp+Q9dxo4L0lXn9kSwVNLt1E7TNG
 cZMNfD4h2FvnL5WGvcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1MyBTYWx0ZWRfX1DgU7SPg5IN1
 h1AhBift8o3ILpILGkGjPdqw6VWxwpLqQpvJ71n9RsxnYfEFwrytYmRlHz2p33hpMGTG3Bam72A
 XRoLsvvbpL6wRR428CQnaVEyn5NNXZs=
X-Proofpoint-GUID: 2R9qnaW5Z-sh7non8YHN0x2adkKNZ6Os
X-Authority-Analysis: v=2.4 cv=fqxJ914f c=1 sm=1 tr=0 ts=6abd0f83 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=laPHfx2b8EGOn1Lu-fwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300053
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 30/9/26 15:16, Philippe Mathieu-DaudÃ© wrote:
> Hi Daniel,
> 
> (committed as 6c91b423a9a4dac2a22629491f2a3059aa40b954)
> 
> On 3/7/26 20:05, Daniel Henrique Barboza wrote:
>> riscv_cpu_update_mip() is a TCG only call.  Its KVM equivalent is
>> kvm_riscv_set_irq().  cpu.c gates the KVM only function with a
>> kvm_enabled() check, making it unavailable for TCG only builds.  We need
>> to do the same for riscv_cpu_update_mip() otherwise a KVM only build
>> will fail because it doesn't know what this function is.
>>
>> Use tcg_enabled() for the couple of riscv_cpu_update_mip() calls we have
>> unguarded in cpu.c.
>>
>> We have way more calls to deal with in time_helper.c which isn't using
>> kvm_riscv_set_irq() at all, so create a riscv_accel_set_irq() local
>> helper that will choose whether to use the KVM or TCG API.
>>
>> The reason we're going through all this hassle in time_helper.c is
>> because hw/int/riscv_aclint.c uses it, and if we don't do something
>> about we won't have riscv_aclint working for KVM.  Whether this is a
>> real problem or not and we should remove aclint support for KVM is
>> question for another day.
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   target/riscv/cpu.c         | 19 ++++++++++++++-----
>>   target/riscv/time_helper.c | 33 +++++++++++++++++++++++++--------
>>   2 files changed, 39 insertions(+), 13 deletions(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index db18c52656..6b79dcc5ee 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -1343,14 +1343,18 @@ static void riscv_cpu_set_irq(void *opaque, 
>> int irq, int level)
>>           case IRQ_M_EXT:
>>               if (kvm_enabled()) {
>>                   kvm_riscv_set_irq(cpu, irq, level);
>> -            } else {
>> +            }
>> +
>> +            if (tcg_enabled()) {
>>                   riscv_cpu_update_mip(env, 1 << irq, 
>> BOOL_TO_MASK(level));
>>               }
>>                break;
>>           case IRQ_S_EXT:
>>               if (kvm_enabled()) {
>>                   kvm_riscv_set_irq(cpu, irq, level);
>> -            } else {
>> +            }
>> +
>> +            if (tcg_enabled()) {
>>                   env->external_seip = level;
>>                   riscv_cpu_update_mip(env, 1 << irq,
>>                                        BOOL_TO_MASK(level | env- 
>> >software_seip));
>> @@ -1377,9 +1381,14 @@ static void riscv_cpu_set_irq(void *opaque, int 
>> irq, int level)
>>               env->hgeip |= 1ULL << irq;
>>           }
>> -        /* Update mip.SGEIP bit */
>> -        riscv_cpu_update_mip(env, MIP_SGEIP,
>> -                             BOOL_TO_MASK(!!(env->hgeie & env->hgeip)));
>> +        if (kvm_enabled()) {
>> +            kvm_riscv_set_irq(cpu, irq, level);
>> +        }
>> +        if (tcg_enabled()) {
>> +            /* Update mip.SGEIP bit */
>> +            riscv_cpu_update_mip(env, MIP_SGEIP,
>> +                                 BOOL_TO_MASK(!!(env->hgeie & env- 
>> >hgeip)));
>> +        }
>>       } else {
>>           g_assert_not_reached();
>>       }
>> diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
>> index 400e917354..ede1a4c2a3 100644
>> --- a/target/riscv/time_helper.c
>> +++ b/target/riscv/time_helper.c
>> @@ -21,19 +21,34 @@
>>   #include "cpu_bits.h"
>>   #include "time_helper.h"
>>   #include "hw/intc/riscv_aclint.h"
>> +#include "kvm/kvm_riscv.h"
>> +#include "system/kvm.h"
>> +#include "system/tcg.h"
>> +
>> +static void riscv_accel_set_irq(RISCVCPU *cpu, int irq, int level)
> 
> Revisiting this change, riscv_accel_set_irq() is confusing.
> 
>> +{
>> +    if (kvm_enabled()) {
>> +        kvm_riscv_set_irq(cpu, irq, level);
> 
> kvm_riscv_set_irq() expects IRQ number and level,
> 
>> +    }
>> +
>> +    if (tcg_enabled()) {
>> +        riscv_cpu_update_mip(&cpu->env, irq, level);
> 
> riscv_cpu_update_mip() expects a MIP bitmask and a value.
> 
>> +    }
>> +}

For now self-documented as:

-- >8 --
Author: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Date:   Wed Sep 30 15:22:48 2026 +0200

     target/riscv: Clarify riscv_accel_set_irq() arguments

     Use per-accelerator locals to make the differing conventions
     explicit: TCG takes a MIP bitmask and value, KVM takes an IRQ
     number and a level.

     Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index ede1a4c2a34..85f3f2760b5 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -27,5 +27,9 @@

-static void riscv_accel_set_irq(RISCVCPU *cpu, int irq, int level)
+static void riscv_accel_set_irq(RISCVCPU *cpu,
+                                int irq_or_mask, int level_or_value)
  {
      if (kvm_enabled()) {
+        int irq = irq_or_mask;
+        int level = level_or_value;
+
          kvm_riscv_set_irq(cpu, irq, level);
@@ -34,3 +38,6 @@ static void riscv_accel_set_irq(RISCVCPU *cpu, int 
irq, int level)
      if (tcg_enabled()) {
-        riscv_cpu_update_mip(&cpu->env, irq, level);
+        uint64_t mask = irq_or_mask;
+        uint64_t value = level_or_value;
+
+        riscv_cpu_update_mip(&cpu->env, mask, value);
      }
---

>>   static void riscv_vstimer_cb(void *opaque)
>>   {
>>       RISCVCPU *cpu = opaque;
>>       CPURISCVState *env = &cpu->env;
>>       env->vstime_irq = 1;
>> -    riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(1));
>> +    riscv_accel_set_irq(cpu, 0, BOOL_TO_MASK(1));
> 
> In particular I don't follow what irq=0 is here, IRQ or mask?
> 
>>   }
>>   static void riscv_stimer_cb(void *opaque)
>>   {
>>       RISCVCPU *cpu = opaque;
>> -    riscv_cpu_update_mip(&cpu->env, MIP_STIP, BOOL_TO_MASK(1));
>> +    riscv_accel_set_irq(cpu, MIP_STIP, BOOL_TO_MASK(1));
>>   }
>>   /*
>> @@ -48,6 +63,7 @@ void riscv_timer_write_timecmp(CPURISCVState *env, 
>> QEMUTimer *timer,
>>       RISCVAclintMTimerState *mtimer = env->rdtime_fn_arg;
>>       uint32_t timebase_freq;
>>       uint64_t rtc_r;
>> +    RISCVCPU *cpu;
>>       if (!riscv_cpu_cfg(env)->ext_sstc || !env->rdtime_fn ||
>>           !env->rdtime_fn_arg || !get_field(env->menvcfg, 
>> MENVCFG_STCE)) {
>> @@ -63,6 +79,7 @@ void riscv_timer_write_timecmp(CPURISCVState *env, 
>> QEMUTimer *timer,
>>       timebase_freq = mtimer->timebase_freq;
>>       rtc_r = env->rdtime_fn(env->rdtime_fn_arg) + delta;
>> +    cpu = env_archcpu(env);
>>       if (timecmp <= rtc_r) {
>>           /*
>> @@ -71,9 +88,9 @@ void riscv_timer_write_timecmp(CPURISCVState *env, 
>> QEMUTimer *timer,
>>            */
>>           if (timer_irq == MIP_VSTIP) {
>>               env->vstime_irq = 1;
>> -            riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(1));
>> +            riscv_accel_set_irq(cpu, 0, BOOL_TO_MASK(1));
>>           } else {
>> -            riscv_cpu_update_mip(env, MIP_STIP, BOOL_TO_MASK(1));
>> +            riscv_accel_set_irq(cpu, MIP_STIP, BOOL_TO_MASK(1));
>>           }
>>           return;
>>       }
>> @@ -81,9 +98,9 @@ void riscv_timer_write_timecmp(CPURISCVState *env, 
>> QEMUTimer *timer,
>>       /* Clear the [VS|S]TIP bit in mip */
>>       if (timer_irq == MIP_VSTIP) {
>>           env->vstime_irq = 0;
>> -        riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(0));
>> +        riscv_accel_set_irq(cpu, 0, BOOL_TO_MASK(0));
>>       } else {
>> -        riscv_cpu_update_mip(env, timer_irq, BOOL_TO_MASK(0));
>> +        riscv_accel_set_irq(cpu, timer_irq, BOOL_TO_MASK(0));
>>       }
>>       /*
>> @@ -151,7 +168,7 @@ static void 
>> riscv_timer_disable_timecmp(CPURISCVState *env, QEMUTimer *timer,
>>   {
>>       /* Disable S-mode Timer IRQ and HW-based STIP */
>>       if ((timer_irq == MIP_STIP) && !get_field(env->menvcfg, 
>> MENVCFG_STCE)) {
>> -        riscv_cpu_update_mip(env, timer_irq, BOOL_TO_MASK(0));
>> +        riscv_accel_set_irq(env_archcpu(env), timer_irq, 
>> BOOL_TO_MASK(0));
>>           timer_del(timer);
>>           return;
>>       }
>> @@ -161,7 +178,7 @@ static void 
>> riscv_timer_disable_timecmp(CPURISCVState *env, QEMUTimer *timer,
>>           (!get_field(env->menvcfg, MENVCFG_STCE) ||
>>            !get_field(env->henvcfg, HENVCFG_STCE))) {
>>           env->vstime_irq = 0;
>> -        riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(0));
>> +        riscv_accel_set_irq(env_archcpu(env), 0, BOOL_TO_MASK(0));
>>           timer_del(timer);
>>           return;
>>       }
> 
> 


