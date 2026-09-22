Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD5CC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94Hg-0004WW-2v; Tue, 22 Sep 2026 13:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x94He-0004VT-QD
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:27:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x94Hc-00064Z-Q1
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:27:58 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEjLb9318147
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 17:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z8nCiQLGCTSnO9dfl3DrE94+L4gIHuzodyxC11PT1rU=; b=nAxFaG0Daxe86/pe
 ZGKNLcInlFdexIPqkitZsUutwE7sIIDF96KmGSzHqBTwabWkcjMUQyr/aFsXlxfC
 hAqntJOQqO9wToB+tLbubNwPfbT76+yshAMk2nfM+nl9qzxoS/hasgdSMR9gkY7r
 rQ3/21hIMGNUhPTEIG8UDdx/U875/IIBD8niUBaY1kgfZzI+97s00v3IkqVQCCND
 MN23eixMCN2JP5nE8N6Bqn7gt24EaHe50Hk8shmEtgNmoWz8T3WQy0lbPItnZDJk
 pGOOS4DotkyrPKhgLbCvwSiDyp8jaU2qHuWJm1XMMauwWKuPCHIjkhAGsexZSHOn
 UkUx7Q==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gupbqjdpw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 17:27:54 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-97c7e1d8bbeso31793241.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790098074; x=1790702874; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z8nCiQLGCTSnO9dfl3DrE94+L4gIHuzodyxC11PT1rU=;
 b=W8sNqNmu+1vOUiJjslpPmbBBY22QwUWv3k+urMyVJD2Uj+e2pVcCdFZ0/2c1h3QUro
 03Q2eU99fAK6P2AW49qJqd1KfHPi2Js7IH2G+sTqPJCflUJMsogULNbxvc5tHprJvn3d
 aRxc17yK5XTeKaHWUQv4n7DsRK+qygSfqJsx0NxHPMA3HJ/P3GGl03FArqE5fe/n1/C4
 4gsBNXVBQsEzWALimMX6JH0wIlmKdkQolPXJlBhRV60BG7PJtRLbv1Pt79gAd5hspFwE
 Oj+BYU+W3FejPSmsjV4D4p79up+qoHARkwOHhrUNy5sFY+h8WYtlkiXbwIjcwWyY/6uK
 gENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790098074; x=1790702874;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z8nCiQLGCTSnO9dfl3DrE94+L4gIHuzodyxC11PT1rU=;
 b=06gJdqRkjpLdLsPucEk/vapTR1C5BVC5+OeOevxzAyAeTqmQyuz87+2LTW1nEX+V5W
 A2Jl1/hJkOB8eW6rgYSdJt1ln0KykfrciS+css81Q459K5vgIq++U9iNb0LTDtW2L6NB
 xN6+0Q3M1/QnO+/eEo8teBo1BT2qc7IQQdoJMp/hurOeSd622Ur4wK6p9h9/m7e9aP2Q
 pmdeM0x9E+bTzEuPiE1Jzn4JVQiSqeJwy1b56zY37wa9a6wuw2qYYIGW76/wHecJzQ4G
 W8mzI3RbbDdggssP2IPcYm8Knaty54l6YFSNk0vSeOJthdRSeI5L8eyghB3itnkkW5F9
 EOPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqDdQrAHLLHIUDvLPwAoJdSWgO+RY3Mtsn2cQdLjDpu4PYcvT1cZvJ4z3EdyKS+uD2ya0jatX8T+lc@nongnu.org
X-Gm-Message-State: AFuF++kAXL5iJNcLRJKSdHRxU8xtGU58C9qj/6P7gJZhEftTaDznphIr
 pAyPDQHDdKS+XTQeFFSersHbzyHO1zNXnF20FZeTmQX1zXYH+cWxd4ShpQdKqZ0wwbAgj9A/6Iy
 7SSzCELvnrRgYh8ffcATtSBW1GogiXo6/ezLNUgcBD27eVA3XWiNWD12L/Q==
X-Gm-Gg: AYBFou1hCfYZTKT+jUct2i55bZiJW/AWGuiHYVWM+6OOugpXcQhpo5O1OW5SdGavaia
 5O2ILxIT+K+De1QiEgSycaj0jpxBMYB52KvlD+W6Fe0R4knb50pf6Fb5cFQhmzS6hVFTalXkfir
 9OzoDuYS4IoQzwHULYKkId3+oa4lHistUjLRbDjyQr9G+4/NnX3X+ETUQ+7OvYZRJ4Mn+ZyAD7Y
 ZzA8pd2Ep28ZmvYMvuEQB664CB9pj1tz+z/qL5uxYcfPr2PyrKHhUyq2/Pyk9QMHJ+w5E3HQUbG
 6oYkqpiKzbpZJY6u17NIFBmei1E0OAwGUZvIAwGK7x97FaBHuDpW1pDt34HD5cNgXHUTuKpmU2q
 3TYH8XjnMxIWQXWaTgOxxlQnZjWGr+2yOGQ==
X-Received: by 2002:a05:6102:a47:b0:7a6:e302:e24f with SMTP id
 ada2fe7eead31-7a6e31243femr6903202137.24.1790098074004; 
 Tue, 22 Sep 2026 10:27:54 -0700 (PDT)
X-Received: by 2002:a05:6102:a47:b0:7a6:e302:e24f with SMTP id
 ada2fe7eead31-7a6e31243femr6903148137.24.1790098073395; 
 Tue, 22 Sep 2026 10:27:53 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaada7b6sm43664425e9.2.2026.09.22.10.27.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 10:27:52 -0700 (PDT)
Message-ID: <5957fc53-99eb-4cad-89b6-0dae6e2a6d85@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 19:27:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/11] target/riscv: Replace TARGET_LONG_BITS in header
 exposed to common code
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com
References: <20260918-hw-riscv-cpu-int-v5-0-f98c5a244636@rev.ng>
 <20260918-hw-riscv-cpu-int-v5-3-f98c5a244636@rev.ng>
 <3539b4ac-aeda-4c90-935a-1c5e105713e7@oss.qualcomm.com>
In-Reply-To: <3539b4ac-aeda-4c90-935a-1c5e105713e7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI1NSBTYWx0ZWRfX/+ZmieD+Yjfp
 KpY344Qk24G+Tkz01mFyiMae0uMGzfmPcLtxyScyZtucRz3Xc28euWNFGYZemfMfiXHv343yUs4
 E/LZxGEDdziAwlz7ZeAGEYwOCFKsEv5LJ0rUGz5jkihdLrsD9cg+SRYUcwneMG3keBPL+Mk5mxz
 tYt+W4StsC7FNpf6+cA+TNX29nkZlbL+W/fg7Mgy9NH2sZ4NcgnDobYMucVzvDUej86XXaqjITf
 k5T4epinQTAEYyr5PlV5O7U7O6izsZ+sow1laUDhtKUcsZ2gpJtEE6u/qA4huBrJFCpXTIgADn8
 cmGTENy1qJ3j3+ItYRUajIk0HzXq0Nwq7uMUUocz1DMqUk6BoRt250xwHV0jd60JPsiM5ggS9Ax
 wmHP5LYtVE+AEg6dlTPzsMCV7y7/uabeC1Loe4TJeIU8tAESsGGrl14R9kuv93xSX+AmBM3g+QH
 0J/h5p6TKJeXvZNjsiA==
X-Authority-Analysis: v=2.4 cv=FdaiV5+6 c=1 sm=1 tr=0 ts=6ab2ba9a cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=aztJ6Iox8fokGBo3vNgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: 92vU631QQAEUyNUIMduRrCyvUO4se0Mx
X-Proofpoint-GUID: 92vU631QQAEUyNUIMduRrCyvUO4se0Mx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI1NSBTYWx0ZWRfXwDYSilGi2+Sx
 39j8EdvTTBd6HoN9yyXZ/fKlGCNpGjnIMvj5eG1DCXYmsqggFE1y77ZYgkZjRtRtD7mOrre/FJJ
 kZWLJaZyquYXnI3fPqc7QRHC7/vPZ5k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220255
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 21/9/26 16:02, Philippe Mathieu-DaudÃ© wrote:
> Hi Anton,
> 
> On 2026-09-18 0:04, Anton Johansson wrote:
>> IRQ_LOCAL_GUEST_MAX depends on TARGET_LONG_BITS and is used in
>> hw/intc/riscv_imsic.c.  The macro is replaced by a field in RISCVCPUDef
>> initialized in riscv_cpu_class_base_init().
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>> ---
>>   target/riscv/cpu.h      |  5 ++++-
>>   target/riscv/cpu_bits.h |  2 --
>>   hw/intc/riscv_imsic.c   |  4 +++-
>>   target/riscv/cpu.c      | 16 ++++++++++++++--
>>   4 files changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index e2e0547eef..a820ec2f6e 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -589,8 +589,11 @@ typedef struct RISCVCPUDef {
>>       int32_t vext_spec;
>>       RISCVCPUConfig cfg;
>>       bool bare;
>> -#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>> +#if !defined(CONFIG_USER_ONLY)
>> +#if defined(CONFIG_TCG)
>>       const RISCVCSR *custom_csrs;
>> +#endif
>> +    uint8_t irq_local_guest_max;
> 
> If it is variable, we shouldn't have it in the def. IMO we
> simply want a helper on the CPU class:
> 
>    uint8_t riscv_imsic_irq_local_guest_max(RISCVCPUClass *rcc);

Even uint8_t riscv_imsic_irq_local_guest_max(const RISCVCPUClass *rcc).

> 
> WDYT?

Pierrick told me this suggestion is not clear. See below...

> 
>>   #endif
>>       /* This is just a setter for env->num_triggers.  */
>>       uint32_t num_triggers;
>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>> index c01050ce2b..9c499e33f2 100644
>> --- a/target/riscv/cpu_bits.h
>> +++ b/target/riscv/cpu_bits.h
>> @@ -811,8 +811,6 @@ typedef enum RISCVException {
>>   #define IRQ_S_GEXT                         12
>>   #define IRQ_PMU_OVF                        13
>>   #define IRQ_LOCAL_MAX                      64
>> -/* -1 is due to bit zero of hgeip and hgeie being ROZ. */
>> -#define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS - 1)
>>   /* RNMI causes */
>>   #define RNMI_MAX                           16
>> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
>> index cb9ce9612c..bf0434e96f 100644
>> --- a/hw/intc/riscv_imsic.c
>> +++ b/hw/intc/riscv_imsic.c
>> @@ -501,13 +501,15 @@ DeviceState *riscv_imsic_create(MemoryRegion 
>> *container, hwaddr addr,
>>   {
>>       DeviceState *dev = qdev_new(TYPE_RISCV_IMSIC);
>>       CPUState *cpu = cpu_by_arch_id(hartid);
>> +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(RISCV_CPU(cpu));
>>       uint32_t i;
>>       assert(!(addr & (IMSIC_MMIO_PAGE_SZ - 1)));
>>       if (mmode) {
>>           assert(num_pages == 1);
>>       } else {
>> -        assert(num_pages >= 1 && num_pages <= (IRQ_LOCAL_GUEST_MAX + 
>> 1));
>> +        assert(num_pages >= 1 &&
>> +               num_pages <= (mcc->def->irq_local_guest_max + 1));
>>       }
>>       assert(IMSIC_MIN_ID <= num_ids);
>>       assert(num_ids <= IMSIC_MAX_ID);
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 5fff9d745e..4f58e91b62 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -1416,6 +1416,7 @@ void riscv_add_satp_mode_properties(Object *obj)
>>   static void riscv_cpu_set_irq(void *opaque, int irq, int level)
>>   {
>> +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(opaque);
>>       RISCVCPU *cpu = RISCV_CPU(opaque);
>>       CPURISCVState *env = &cpu->env;
>> @@ -1454,7 +1455,7 @@ static void riscv_cpu_set_irq(void *opaque, int 
>> irq, int level)
>>           default:
>>               g_assert_not_reached();
>>           }
>> -    } else if (irq < (IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX)) {
>> +    } else if (irq < (IRQ_LOCAL_MAX + mcc->def->irq_local_guest_max)) {
>>           /* Require H-extension for handling guest local interrupts */
>>           if (!riscv_has_ext(env, RVH)) {
>>               g_assert_not_reached();
>> @@ -1501,7 +1502,7 @@ static void riscv_cpu_init(Object *obj)
>>   #ifndef CONFIG_USER_ONLY
>>       qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
>> -                      IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
>> +                      IRQ_LOCAL_MAX + mcc->def->irq_local_guest_max);
>>       if (mcc->def->num_triggers) {
>>           env->num_triggers = mcc->def->num_triggers;
>>       }
>> @@ -3092,6 +3093,17 @@ static void 
>> riscv_cpu_class_base_init(ObjectClass *c, const void *data)
>>           mcc->def = g_new0(RISCVCPUDef, 1);
>>       }
>> +#ifndef CONFIG_USER_ONLY
>> +    /*
>> +     * RISCVCPUDef::irq_local_guest_max is initialized to
>> +     * `target_long_bits()-1` due to bit zero of hgeip and hgeie
>> +     * being ROZ.
>> +     *
>> +     * This value does not vary between CPU types.
>> +     */
>> +    mcc->def->irq_local_guest_max = target_long_bits() - 1;

... here I'm worried this change the behavior of qemu-system-riscv32
vs qemu-system-riscv64, in particular when instantiating a RV32 with
the qemu-system-riscv64 binary. Maybe the change doesn't trigger any
bug, but this is a change and we committed to not do any when
introducing the single binary. Or at least we should mention the
change in the commit description. But again, introducing
riscv_imsic_irq_local_guest_max() then we don't need this RISCVCPUDef
field and no behavioral change at all.

>> +#endif
>> +
>>       if (data) {
>>           const RISCVCPUDef *def = data;
>>           mcc->def->bare |= def->bare;
>>
> 
> 


