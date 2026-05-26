Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7861CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRq4q-0003ur-1L; Tue, 26 May 2026 07:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wRq4o-0003ua-3J
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:36:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wRq4k-00057e-9D
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:36:01 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q7Kkmq507064
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 11:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wstwRG0e4C8qsFOqw6SshCdz21oIWKY+UFI6BVwME3g=; b=XDGbqIkBMc8P28gF
 ZSDmp10/5XojlNA/EEV+CIfcg3Cc9D0GjPeciS2Lg2WwgpGDctTx7eRdH4FCegVk
 tfZd7ZrPHkHiMbSPsaVw9NPHZdVJUoRN0IUfxiWAI3lieILC8RwT9/5c8KDsfXsw
 Z6iDrtyS8sV7QB79H8gZ3fo4ynpeHNgCTZe5D9pd+LG/36nCu7oG7nAs3ZoHGlNw
 Y/fLxVsmnZd6h+MyFHyvwmbrfX7L2C1nZ7i93uQeq8RnbZ8r4DkB2gKG6O9oQRED
 wYnaVfflATSJqIBkYW5AMtl6h3Ebm7EfRvZFQyVj7+EY/wJWJ8k216kvKcTQI3S0
 vFDwEw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecpyqkupy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 11:35:54 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b552610488so58440386d6.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779795354; x=1780400154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wstwRG0e4C8qsFOqw6SshCdz21oIWKY+UFI6BVwME3g=;
 b=d2/a1e1gmB5VRcKQMATTN984AWhoJ8Do+j6x2tRLLCs8VPWweCPgcnOUNPZeuvQqio
 fTB2SB2KQVXL+RutF4eRR/YownUMOpvaZXuRHk2aU8jf92U0/S3zW52pzsY8GSPnypZc
 kaP5RAQ3ps5iF3a+Ad6CPE9wBQjEL7X2bUiOrglrTRtg3EbRFskl4547ZJKjjom7MDid
 SNrUVx4qhxz45qUe7UAmTEI4ymv5YzGJUi06jNr6KUVzb57VgKusNyEZWrbEBaCGPYMU
 8PYRshxI0cs5+BxMEY8ou2BC11a4bdCdLWs5CmQvCedkv9aQoYnnPsvM702y6WVqnVQt
 gMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779795354; x=1780400154;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wstwRG0e4C8qsFOqw6SshCdz21oIWKY+UFI6BVwME3g=;
 b=cyBbcmqSUdfqFVokJ9Fkawj3MtWpbuuK+CuUmuGVU6lkgv236h1t+6cwc0QlmzMiw2
 /YdH5lyjn+5ce/mJZVe5dnbZsB7J/qite9V6BnZcrwS8HUG8OQCuzKeDzgVxPz183Or3
 jb3s788pRUuMoJ6uZkIWwmULnokajZ5m1MeNoRuZwpRtmTZ0i+XxeXzJ4rdWPhCrO+y2
 E/W99zW0ubEzElN+ltBA9UDEfbyWeE7/KZuQGicwlaJdV8GnnNX5CsRC1Vw/JDh4yBBJ
 polgKxl0pGHq5QPnAczW52arhWVEbnx9p1pU/yxpmpaQ4QEoeCtB7vB3TjHfuad3+3/+
 YPeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ96sHb5ovw2BpMeoSDovCwCmGMJEnZG2DpvGASNMhagx1R0zwXyrt06mlqAaWzMxgCc1hLlZqkZ2A1R@nongnu.org
X-Gm-Message-State: AOJu0Yzp1ppDP0zDFtvNJftxljZ+ysQtdbqT70dx9tpGcSh7vj7U6cmv
 SKIknIjqDDFrc5VMNioM1ii20h+vhDLkFMOZyDYGkQbx/Y0URL102INfRXgAW1LrmKo4bkKPWPJ
 8hIVyujf24LaewixVzOQ7anPHJaTm0ZyvfKlPgS2XZzwA/Dtyps4zlyA9Pw==
X-Gm-Gg: Acq92OE8FShP4SlC8cDltWEXaOKQgQWP+SfJsIU6Hzm6zrgnYIXjzbhSicFJTqWjjIW
 vq1YvXBODFWTiejirecvQBQqwVgmn4UJFg6MANaCyba8gLSqmhgPo8IXS0bYpzBJU5yzsNAh9GJ
 gfwcPNULMhaJPR57GzXx492RJTc4ZS5xDiioniPCE9Fu8gYhOaqck4I7s/j33phCD2xLbc2q2QE
 ZDp2BC9V7gnz8TlWYDd9sbly+ouAQbQPkUWbnzPAlolWh37bvGKL0PtqDdYN8RnH3dnjloBU4o7
 b6ff3X/GCaJ/i9ATRMsiH1606FylTpZhN/pyjSCmZQYrnk+CB8mDEAZGduErn4ng5SK9k9s79Vo
 OkUW7/83EDAjDktnQKDG36q0O0dXEpMY6X/ikItd6npTdBmqI/VUUqgm9JXg=
X-Received: by 2002:a05:6214:33c4:b0:89a:9ef:1922 with SMTP id
 6a1803df08f44-8cc7b5c06e0mr309598166d6.40.1779795353790; 
 Tue, 26 May 2026 04:35:53 -0700 (PDT)
X-Received: by 2002:a05:6214:33c4:b0:89a:9ef:1922 with SMTP id
 6a1803df08f44-8cc7b5c06e0mr309597606d6.40.1779795353340; 
 Tue, 26 May 2026 04:35:53 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc80deae74sm139370746d6.11.2026.05.26.04.35.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 04:35:52 -0700 (PDT)
Message-ID: <9f8b2370-7b0f-4302-9ced-93993214bc11@oss.qualcomm.com>
Date: Tue, 26 May 2026 08:35:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 37/48] target/riscv: do not set defaults in cpu prop
 callback
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alistair23@gmail.com, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
 <20260522000324.23255-38-alistair.francis@wdc.com>
 <f99bbe2d-07d6-4cd5-a309-78d521f9127d@linaro.org>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f99bbe2d-07d6-4cd5-a309-78d521f9127d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dtfrzVg4 c=1 sm=1 tr=0 ts=6a15859a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=R6idZvmv3lllwpMSse8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: Jhe_j-LDc73kkQsmVgFr6kcCoysiR2rL
X-Proofpoint-ORIG-GUID: Jhe_j-LDc73kkQsmVgFr6kcCoysiR2rL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEwMCBTYWx0ZWRfX+7bK+G1CNjw3
 EMx+X4OoI02NsoGG2wUXeE5+B+if8vXBgDyunYQNi9FfYZeEqXmcLNojMsujRXqWER8PxpkLdDs
 cJHt681XDh/5GdZJXHRBbS72uYnjH3YQ/hz8opMmDjD6en0gLRN7Zqwart+03bPfhcv+s4zLv7a
 LSOVTREFx1jt5QwWQAoszpt96K9MI61bemn7xzrdSajfebGjkEneA1PWmLj35CHhI2TOuVj9yc2
 5jOeazfIeQxo9KLTu3sfwSxmiKaWfrRbUJ4am9r1wSTr+kX93NQ11XWD1xPWLy+LuVsU7nskUeR
 646dFX3PRKSwQYgXjyDLET3f0PJamJsGyItJmef5L08BJ8CQHPXgHiYrKaL7gjcu7qq+WBPPQLN
 ryeJ/mY0QV5hG44AvGdwqSzE0bwy03viJQ5BLqX627awF00pUwP7fhWop44EXSDV8LDNh8NUPis
 O66t1iWDIwka/OYnRqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260100
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 5/26/2026 5:26 AM, Philippe Mathieu-Daudé wrote:
> On 22/5/26 02:03, alistair23@gmail.com wrote:
>> From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>>
>> Do not rely on riscv_cpu_* arrays to set rv32/rv64 CPU defaults - add
>> them to the CPU definition like we do with all other CPUs (aside from
>> 'max').
> 
> Hmm this change is unfortunate, I was about to replace the 3 machine
> uses of TYPE_RISCV_CPU_BASE by "max" (they were semantically identical).
> 
> Why do we need these "base" CPU types and can't use "max" instead?
> Because they are "fake but stable" why "max" doesn't aim to be?

rv32 and rv64 don't have a cohesive design.  They happen to be the
default CPUs that we kept using since the start of the RISC-V port 8
years go, and each new extension added back then was turned on by
default on those CPUs.  There's no deep meaning or reasoning behind
the default extensions of each of them.

I discussed with Alistair a couple of times about making rv32/rv64
as aliases for 'max'.  From what I understood your idea would go
in line with that.  In that case I think you can go ahead with your change.

Bear in mind that we'll need to put this change somewhere in the docs
because every other rv64 user will have a lot of extra extensions to
deal with.  We might have to deal with ppl complaining about some
particular OS setup stop working, we'll provide workarounds, and life
will go on.



Cheers,
Daniel




> 
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> Acked-by: Alistair Francis <alistair.francis@wdc.com>
>> Message-ID: <20260512032926.1978818-13-daniel.barboza@oss.qualcomm.com>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   target/riscv/cpu.c         | 40 ++++++++++++++++++++++++++++++++++++++
>>   target/riscv/tcg/tcg-cpu.c | 14 -------------
>>   2 files changed, 40 insertions(+), 14 deletions(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 64e3fa4ef0..5d3383f335 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -3076,6 +3076,26 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
>>           .cfg.max_satp_mode = VM_1_10_SV32,
>>           .misa_mxl_max = MXL_RV32,
>> +
>> +        /*  Default extensions as of QEMU 11.1.  */
>> +        .cfg.ext_zicbom = true,
>> +        .cfg.ext_zicbop = true,
>> +        .cfg.ext_zicboz = true,
>> +        .cfg.ext_zicntr = true,
>> +        .cfg.ext_zicsr = true,
>> +        .cfg.ext_zifencei = true,
>> +        .cfg.ext_zihintntl = true,
>> +        .cfg.ext_zihintpause = true,
>> +        .cfg.ext_zihpm = true,
>> +        .cfg.ext_zawrs = true,
>> +        .cfg.ext_zfa = true,
>> +        .cfg.ext_zba = true,
>> +        .cfg.ext_zbb = true,
>> +        .cfg.ext_zbc = true,
>> +        .cfg.ext_zbs = true,
>> +        .cfg.ext_sstc = true,
>> +        .cfg.ext_svadu = true,
>> +        .cfg.ext_svvptc = true,
>>       ),
>>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_IBEX, TYPE_RISCV_VENDOR_CPU,
>> @@ -3128,6 +3148,26 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE64, TYPE_RISCV_DYNAMIC_CPU,
>>           .cfg.max_satp_mode = VM_1_10_SV57,
>>           .misa_mxl_max = MXL_RV64,
>> +
>> +        /*  Default extensions as of QEMU 11.1.  */
>> +        .cfg.ext_zicbom = true,
>> +        .cfg.ext_zicbop = true,
>> +        .cfg.ext_zicboz = true,
>> +        .cfg.ext_zicntr = true,
>> +        .cfg.ext_zicsr = true,
>> +        .cfg.ext_zifencei = true,
>> +        .cfg.ext_zihintntl = true,
>> +        .cfg.ext_zihintpause = true,
>> +        .cfg.ext_zihpm = true,
>> +        .cfg.ext_zawrs = true,
>> +        .cfg.ext_zfa = true,
>> +        .cfg.ext_zba = true,
>> +        .cfg.ext_zbb = true,
>> +        .cfg.ext_zbc = true,
>> +        .cfg.ext_zbs = true,
>> +        .cfg.ext_sstc = true,
>> +        .cfg.ext_svadu = true,
>> +        .cfg.ext_svvptc = true,
>>       ),
>>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>> index 50d9218a75..7575884d7e 100644
>> --- a/target/riscv/tcg/tcg-cpu.c
>> +++ b/target/riscv/tcg/tcg-cpu.c
>> @@ -1553,24 +1553,10 @@ static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
>>   static void cpu_add_multi_ext_prop(Object *cpu_obj,
>>                                      const RISCVCPUMultiExtConfig *multi_cfg)
>>   {
>> -    bool generic_cpu = riscv_cpu_is_generic(cpu_obj);
>> -
>>       object_property_add(cpu_obj, multi_cfg->name, "bool",
>>                           cpu_get_multi_ext_cfg,
>>                           cpu_set_multi_ext_cfg,
>>                           NULL, (void *)&multi_cfg->offset);
>> -
>> -    if (!generic_cpu) {
>> -        return;
>> -    }
>> -
>> -    /*
>> -     * Set def val directly instead of using
>> -     * object_property_set_bool() to save the set()
>> -     * callback hash for user inputs.
>> -     */
>> -    isa_ext_update_enabled(RISCV_CPU(cpu_obj), multi_cfg->offset,
>> -                           multi_cfg->enabled);
>>   }
>>   static void riscv_cpu_add_multiext_prop_array(Object *obj,
> 


