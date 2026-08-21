Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B6FC5DF97
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxS0u-0007AZ-AI; Fri, 21 Aug 2026 12:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxS0t-00079N-1O
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:22:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxS0q-0004DX-LK
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:22:38 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LFm6WC3876550
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 16:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QbIfrsxs+tL0fGREVlJvOpSiE4kfwaLuBN+DLG7cGRI=; b=SwaJADuEw/o6jQgY
 BwAvepoDsSiYGTM8BXI4E25TgtkKuoKWkgBF5ADvSUPeUPVXo6TqFqzzdymKhs+O
 qkgrnftIPIK5OP/DAz382UxhiByJU63LKGMY/XJ/lA7yFDfrB2RN5yi/iCD7ij/n
 XwXNnKJs7VlJSFC7Hrdr2nakaRrLY1YI90lHtvKsm18VQZJ9v5/LPc91ULOw++M7
 lvvAhpQAgiKV2Zq4FtzGUE1DRkAiEurBtlpre6bAmMXBkIQt98cr9JTnz2+u7RaZ
 tJy1LaC0ZVk5yQw9Ucyc3Z/ETsapv01VdQvHNKFvJrxm4kOTEMbwFRPcIxEWRBAa
 tFoj+w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fg9tkmx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 16:22:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-395543dc382so1338039a91.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 09:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787329350; x=1787934150; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QbIfrsxs+tL0fGREVlJvOpSiE4kfwaLuBN+DLG7cGRI=;
 b=dumeqWfrhgbaFhLDhrK1kx/OT70LOiDeYsslZTpCKNSTJ+oEljzsS7IDQoFoGu7QbB
 gksK9gn+maPXjLP1hS8AUV5lbi+6mDhAfh9flmMzLTWSqKgzztzK9TyeKiBQSJ8fVsjw
 cGUBJNVP24efzfYHyUxjv529uYzI5QGjeLgNjzvNSPs6TG7l3YbQ3AuVE9kxxqYyjDk0
 vmvZz2CbhhRIdPCB8uS8O+cbhZTbJRyNU72+tUUvs6Rjx/h6z++jx/QdFeau6nlNB5Xr
 jVqNf8zj7NIjoiSnTfRDVpePSUon8HNfdkN6NQfuYn/sDrSJAPDhYBE+K2fI9ir6d6U1
 6AmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787329350; x=1787934150;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QbIfrsxs+tL0fGREVlJvOpSiE4kfwaLuBN+DLG7cGRI=;
 b=JDtAvpmv14y0+eRCgSyRCMk6hJIBX3ty68JP8g6aWcGf8f5R+g8yRzZhCuEB9D8wIW
 bHrspufuBd25oXCCk+1ZXLIvpqF3DBaFafAXLlArFtOOMPDLRw8E5Y5k9Mmry6bh9atS
 Ld9LRvLvLsOTA/5bbp7QMNMPDqqqI2vcIr/HYzqG6ZPuifmHdUDseZL7bzavRqZUxBjY
 YnihRkS3d2jpAuSeIfCgTjDoO2a00JeKmfGbcbvTZlA6u5O0aZMTFUy6GunvhSABEBXC
 yzCgBKXeG+xKeLvH3J8Mli1pkhrMH9xJ0/wskoYExmdhCvRRzWSr4zlvYeUCbrIYyAGa
 XGhQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfQUcbKlDAwfsXE2c6oImm1xYZle5Yaha8O8wrQENxBErwlS50GFBX93rxIkCnPw55K0ai39NCYA0u@nongnu.org
X-Gm-Message-State: AFuF++kKXtnn8zRHQhZeQ8HdgllIWX+ncdMA+GDcch3twxhaEsmhxWnE
 F7CRzhRDDyH2ZrSFxKYVPf0MFVAV9gmg50zISkKSaft+F5Ay7YJvmhfNaPBtpmxEmZ7JjXCRH/w
 n8mLHUuRf3MtCXRbhzNZDPUzDMNk0vrFYcDPugPc2UB+wZW/zijDQqsUd0Q==
X-Gm-Gg: AR+sD117APk7XOJPjEAQJZ6Gx0fJOMZwuJ1ic4wTG0kmUnZVqCTbBuIdSwmdSf3bq8g
 Sytv+OuItzCvTdpNDQUPi3YBYNcrlBrK8lX2vd5OiVmnnDj9bOq3LBm1Z+gBQqO+NTnS7crskKb
 ZVwkPOn1yxmZiTh7ynfiggG5hjG398hyKgYtiGGvqHZwSrpsw4Rr0aQRQYvYCbe2wKkJgxMRB89
 oVcIjgX5qRzJenZ1CZTQrWJN9C9aM7JehG1C6dIr+x1rrwPHDJX+t3fvJoVgKkB3HPdBgToHB0t
 dDiqIc0FQdZ43uZMBr+Wh6qQQukEuThC/X1Z1kyoPNRH6/inx9oYZnvrIWO10ioA/07rQzLGkCe
 m2rN3py0aHZ6VD/rWlcYSsmlX2CwL3TilUaTRBGvrkdgqeEPhWL8yEkYzsLU+WcAZrTHH
X-Received: by 2002:a17:90a:f945:b0:38f:aab1:5148 with SMTP id
 98e67ed59e1d1-395c35b75efmr13343794a91.13.1787329350124; 
 Fri, 21 Aug 2026 09:22:30 -0700 (PDT)
X-Received: by 2002:a17:90a:f945:b0:38f:aab1:5148 with SMTP id
 98e67ed59e1d1-395c35b75efmr13343694a91.13.1787329349637; 
 Fri, 21 Aug 2026 09:22:29 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4baa594sm3703337a91.17.2026.08.21.09.22.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 09:22:29 -0700 (PDT)
Message-ID: <16b8bb43-f2d5-417e-b1a8-ed71945fc313@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 09:22:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] target/hexagon: implement direct-to-guest interrupt
 delivery
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
 <20260819013144.3264096-10-brian.cain@oss.qualcomm.com>
 <cfef4655-01ac-4cc2-b2d4-a45cd7294622@oss.qualcomm.com>
 <aad0607b-d78d-4cd5-822b-9c29bdfc2c6a@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aad0607b-d78d-4cd5-822b-9c29bdfc2c6a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEyOCBTYWx0ZWRfX0vJTuMElNd8w
 c/iIn+ZlT0icnGNjaUWvB6vc6/0ynn99NIE98R73I3bKQA6XsYJkv6VDqyA8OLYnVabaXbZJ5Ve
 5jfDHO5tv6KETuipQ1G1VKis3rPlMdpznueTbdF0dX2nBFYyWZS6/f0i/8d/20kQz3plOKzgIbZ
 TWnVMP5owQ0tGeOu9tLuDjH6MXESp6UhKZn23fTJB2AYUochL84ZyoYueZ7ihv8RuQ2CUPnzybR
 NDWt+A78gnOd86syE1oCHUSHCWZd8eX+TF9zszRzkSyR31qt16LZcBu30IfOz6qIy4Q/gBf5eFL
 CzGJwdjdPesk0Ege7IVRaucUU8cMCUMCAkMJzmvEp6Z8KtdmgnxnDNxAjXo7inog2psYb+fao7b
 1P4BIsNtC7B0EkvYEwEWhoOZHKRsbwnAp96ZQGSrsHLe9D/xZVmv8geONHL8QH9G7kE6vD6i5om
 rBS3wqL/THXJCRL4kTA==
X-Proofpoint-ORIG-GUID: hIhPUk38h0IBiLMLwKVzS_ZC4a6aTHeI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEyOCBTYWx0ZWRfX83FO/DFz8hYs
 KYAAiO399WzHjZXxDVVsXaOrr8XpXM3GoognWOm/njn0Op2pimtgnsJ39z4mVQBJUKVOh2fAyyE
 DPmD7gYjChNMazWUSH3b9mj6joHvJ34=
X-Authority-Analysis: v=2.4 cv=Av/eGu9P c=1 sm=1 tr=0 ts=6a887b46 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=0hkEc7pzT7K6rHV9yUMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: hIhPUk38h0IBiLMLwKVzS_ZC4a6aTHeI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210128
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 8/20/2026 2:59 PM, Brian Cain wrote:
> 
> On 8/20/2026 1:57 PM, Pierrick Bouvier wrote:
>> On 8/18/2026 6:31 PM, Brian Cain wrote:
>>> Interrupts 3 through 5 are routed to guest mode when CCR:GIE and the
>>> matching CCR:VV bit are set.  Enter through GEVB rather than EVB,
>>> record the pre-entry state in GSR and the return address in GELR, and
>>> read the vector ID from the l2vic.
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   target/hexagon/reg_fields_def.h.inc |  7 +++
>>>   target/hexagon/cpu.c                |  5 ++
>>>   target/hexagon/hex_interrupts.c     | 87 ++++++++++++++++++++++++++---
>>>   3 files changed, 92 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/target/hexagon/reg_fields_def.h.inc b/target/hexagon/
>>> reg_fields_def.h.inc
>>> index d2c706d56b5..29497fbcc4d 100644
>>> --- a/target/hexagon/reg_fields_def.h.inc
>>> +++ b/target/hexagon/reg_fields_def.h.inc
>>> @@ -136,6 +136,13 @@ DEF_REG_FIELD(CCR_VV1, 29, 1)
>>>   DEF_REG_FIELD(CCR_VV2, 30, 1)
>>>   DEF_REG_FIELD(CCR_VV3, 31, 1)
>>>   +/* GSR fields */
>>> +DEF_REG_FIELD(GSR_CAUSE, 0, 16)
>>> +DEF_REG_FIELD(GSR_CFI, 28, 1)
>>> +DEF_REG_FIELD(GSR_SS, 29, 1)
>>> +DEF_REG_FIELD(GSR_IE, 30, 1)
>>> +DEF_REG_FIELD(GSR_UM, 31, 1)
>>> +
>>>   /* ISDB ST fields */
>>>   DEF_REG_FIELD(ISDBST_WAITRUN, 24, 8)
>>>   DEF_REG_FIELD(ISDBST_ONOFF, 16, 8)
>>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>>> index 0a677840bcb..efaf569c6f8 100644
>>> --- a/target/hexagon/cpu.c
>>> +++ b/target/hexagon/cpu.c
>>> @@ -475,6 +475,11 @@ static void hexagon_cpu_realize(DeviceState
>>> *dev, Error **errp)
>>>           error_setg(errp, "hexagon cpu requires 'tlb' link property
>>> to be set");
>>>           return;
>>>       }
>>> +    if (!HEXAGON_CPU(dev)->l2vic) {
>>> +        error_setg(errp,
>>> +                   "hexagon cpu requires 'l2vic' link property to be
>>> set");
>>> +        return;
>>> +    }
>>>   #endif
>>>         qemu_init_vcpu(cs);
>>> diff --git a/target/hexagon/hex_interrupts.c b/target/hexagon/
>>> hex_interrupts.c
>>> index 3534481da24..ea1ba0903dd 100644
>>> --- a/target/hexagon/hex_interrupts.c
>>> +++ b/target/hexagon/hex_interrupts.c
>>> @@ -11,6 +11,7 @@
>>>   #include "cpu_helper.h"
>>>   #include "exec/cpu-interrupt.h"
>>>   #include "hex_interrupts.h"
>>> +#include "hw/intc/hex-l2vic.h"
>>>   #include "macros.h"
>>>   #include "sys_macros.h"
>>>   #include "system/cpus.h"
>>> @@ -215,19 +216,75 @@ static void restore_state(CPUHexagonState *env,
>>> bool int_accepted)
>>>       }
>>>   }
>>>   +static bool int_should_dtg(CPUHexagonState *env, int int_num)
>>> +{
>> What does dtg means?
> 
> "dtg" is "direct-to-guest" interrupts.  This is an architectural feature
> to raise interrupts directly in the guest instead of the monitor/VMM,
> saving the latency of having to manually propagate interrupts to the guest.
> 
> Maybe this is a good case for a clarifying comment on `int_should_dtg()`?
>

Yes it would help to add the paragraph above to describe what it is.

>>
>>> +    uint32_t ccr = env->t_sreg[HEX_SREG_CCR];
>>> +
>>> +    switch (int_num) {
>>> +    case 3:
>>> +        if (!GET_FIELD(CCR_VV1, ccr)) {
>>> +            return false;
>>> +        }
>>> +        break;
>>> +    case 4:
>>> +        if (!GET_FIELD(CCR_VV2, ccr)) {
>>> +            return false;
>>> +        }
>>> +        break;
>>> +    case 5:
>>> +        if (!GET_FIELD(CCR_VV3, ccr)) {
>>> +            return false;
>>> +        }
>>> +        break;
>>> +    default:
>>> +        return false;
>>> +    }
>>> +
>>> +    return GET_FIELD(CCR_GIE, ccr);
>>> +}
>>> +
>>> +static void guest_interrupt_entry(CPUHexagonState *env, uint32_t cause,
>>> +                                  uint32_t event_pc)
>>> +{
>>> +    uint32_t old_ssr = env->t_sreg[HEX_SREG_SSR];
>>> +    uint32_t new_ssr = old_ssr;
>>> +    uint32_t ccr = env->t_sreg[HEX_SREG_CCR];
>>> +    uint32_t gsr = 0;
>>> +
>>> +    gsr = deposit32(gsr, reg_field_info[GSR_CAUSE].offset,
>>> +                    reg_field_info[GSR_CAUSE].width, cause);
>>> +    gsr = deposit32(gsr, reg_field_info[GSR_SS].offset,
>>> +                    reg_field_info[GSR_SS].width,
>>> +                    GET_SSR_FIELD(SSR_SS, old_ssr));
>>> +    gsr = deposit32(gsr, reg_field_info[GSR_UM].offset,
>>> +                    reg_field_info[GSR_UM].width,
>>> +                    !GET_SSR_FIELD(SSR_GM, old_ssr));
>>> +    gsr = deposit32(gsr, reg_field_info[GSR_IE].offset,
>>> +                    reg_field_info[GSR_IE].width,
>>> +                    GET_FIELD(CCR_GIE, ccr));
>>> +    env->greg[HEX_GREG_GSR] = gsr;
>>> +
>>> +    fSET_FIELD(new_ssr, SSR_SS, 0);
>>> +    fSET_FIELD(new_ssr, SSR_GM, 1);
>>> +    env->t_sreg[HEX_SREG_SSR] = new_ssr;
>>> +    hexagon_modify_ssr(env, new_ssr, old_ssr);
>>> +
>>> +    SET_SYSTEM_FIELD(env, HEX_SREG_CCR, CCR_GIE, 0);
>>> +    env->greg[HEX_GREG_GELR] = event_pc;
>>> +    env->gpr[HEX_REG_PC] = env->t_sreg[HEX_SREG_GEVB] |
>>> +                           (HEX_EVENT_INT0 << 2);
>>> +}
>>> +
>>>   static void hex_accept_int(CPUHexagonState *env, int int_num)
>>>   {
>>>       CPUState *cs = env_cpu(env);
>>>       HexagonCPU *cpu = env_archcpu(env);
>>> -    uint32_t evb =
>>> -        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_EVB,
>>> -                               env->threadId);
>>>       const int exe_mode = get_exe_mode(env);
>>>       const bool in_wait_mode = exe_mode == HEX_EXE_MODE_WAIT;
>>> +    uint32_t elr;
>>>         set_ipend_bit(env, int_num, 0);
>>>       set_iad_bit(env, int_num, 1);
>>> -    set_ssr_ex_cause(env, 1, HEX_CAUSE_INT0 | int_num);
>>>       cs->exception_index = HEX_EVENT_INT0 + int_num;
>>>       env->cause_code = HEX_EVENT_INT0 + int_num;
>>>       clear_pending_locks(env);
>>> @@ -235,15 +292,31 @@ static void hex_accept_int(CPUHexagonState
>>> *env, int int_num)
>>>           qemu_log_mask(CPU_LOG_INT,
>>>               "%s: thread " TARGET_FMT_ld " resuming, exiting WAIT
>>> mode\n",
>>>               __func__, env->threadId);
>>> -        set_elr(env, env->wait_next_pc);
>>> +        elr = env->wait_next_pc;
>>>           clear_wait_mode(env);
>>>           cs->halted = false;
>>>       } else if (env->k0_lock_state == HEX_LOCK_WAITING) {
>>>           g_assert_not_reached();
>>>       } else {
>>> -        set_elr(env, env->gpr[HEX_REG_PC]);
>>> +        elr = env->gpr[HEX_REG_PC];
>>> +    }
>>> +
>>> +    if (int_should_dtg(env, int_num)) {
>>> +        int vic_group = int_num - 2;
>>> +        uint32_t vid_packed = l2vic_read_vid(cpu->l2vic, vic_group /
>>> 2);
>>> +        uint32_t vid = extract32(vid_packed,
>>> +                                 (vic_group & 1) ? 16 : 0, 16);
>>> +
>>> +        guest_interrupt_entry(env, vid, elr);
>>> +    } else {
>>> +        uint32_t evb =
>>> +            hexagon_globalreg_read(cpu->globalregs, HEX_SREG_EVB,
>>> +                                   env->threadId);
>>> +
>>> +        set_ssr_ex_cause(env, 1, HEX_CAUSE_INT0 | int_num);
>>> +        set_elr(env, elr);
>>> +        env->gpr[HEX_REG_PC] = evb | (cs->exception_index << 2);
>>>       }
>>> -    env->gpr[HEX_REG_PC] = evb | (cs->exception_index << 2);
>>>       if (get_ipend(env) == 0) {
>>>           restore_state(env, true);
>>>       }


