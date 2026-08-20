Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E101C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 22:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxAnV-0000Kn-Tx; Thu, 20 Aug 2026 17:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wxAnU-0000KH-F4
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 17:59:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wxAnS-0008OR-3U
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 17:59:40 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK87j7067150
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fZ1Sej6+39RUs0pxX1cn9T4P/Pny7nJ64hDtFMqYbjY=; b=VSvsjwm1r7hNk+AA
 S4lmvNs4Xeo9POKz7v+CsSAsZoNKNHZfLDGxcQFMj4H1/mqvbEGht7BhC+4BXiiJ
 X+BsNX+u/LriqBSuth6cOw7LBhq6qxBLwfLFJb5hjMcerb784Gboc74rKSZk43IH
 D2QqbzFbzl+jDHxBYR4BXEeIaiGW+9jAvaHil4NLdVMyG6uN41LuQfE5fn4LyL7z
 QorF6XwBcixgYRN/AXpIwKk0l4D1Ye62vhuCyn8jBVwJsrFIPTVl37wYBeak1RvU
 M4i2gJQUVf/6Y7PsvNp27deTDC1kt9J7hkewsMzgd6rSMB/Inhn0ukMhVQIjN1c1
 QIThPg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg0k35g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:59:36 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ea75996387so6939776d6.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 14:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787263176; x=1787867976; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fZ1Sej6+39RUs0pxX1cn9T4P/Pny7nJ64hDtFMqYbjY=;
 b=UQX3oNRtGu17KcVXwB3k5BFsAgf+kSFWL6s0OFZ4SIBiFwVo8N3iZsH3ELryBurMep
 FEKiZ7SKzb8QcjtuHqO98rIpns/B2UEgvzCs1o033dNBJYVIwCd9OFs0ltK+/K9sHe9k
 Aw3PM90IXiFWtdkUTEIkRzIyQlC1a2s0Am5QFoxd4ataT6CKH8h/dOH5tfnh3HmPURQW
 0e9jRdiVN+eEOwTpVdz1BMqvyGiTLc77KYNrEZkZEUhdDaJstE3wVmzQclB0cf0UAPI6
 mXxfN6LXKp0pdonFlnQa1Z6gbDfmYDGTQj2fqUx6CWy6a1vDUgCOnSieFqBkWS4Wrd95
 bCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787263176; x=1787867976;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fZ1Sej6+39RUs0pxX1cn9T4P/Pny7nJ64hDtFMqYbjY=;
 b=oV8gQsx2282mgW9goV0Ys/N4YbQuM9FFyH+BFss2rd0gmzHdvJS7V5neGYAwwI1i6a
 AOUSB3uU8SSIhcrrsLioKBRwJfBz5yN7Qs1Hk3fC7GOIWh/C8tw56vNbU2FPjxItmFTI
 p+kbY5t2ckW0vQKiEuIIirFdiYoi0ezdhrXChNseeLBMU38jCvyk2693y3KEme+HQQZv
 8bnRD2j5eUYrUzENG9FwZkDu/T17FYjqItw0ZPFG/Qj4HNZk/t/2rcm1g/HraAxB3hmq
 GuBlpbs2T/hxbvfT50y2yU3b1hLScSaXyOsgEXITSrTerPfmYNpjXXXZFXUc8cCWSZui
 nHzg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQCf1pF9ECDsvoFHU7R3uYIFezwSCp76qr7oGzSvEpYdRfaApJ7NU3V00ZVNVC6oGUi8hyjo3wYHUT@nongnu.org
X-Gm-Message-State: AFuF++lJdCU8/Dh2UrgS/b+AseqzGY8FYsikUOQ2kkd/TULF0lEdamfZ
 yL+yLkqFJ2YFaMJn8I0NpxFHu1JwIcOK02W9BaAMWtQs2oPpTmkoey0MNxQJV4jzW4js7UqFfuu
 sh7pyoU7MLbJkb396dw9DPYRIlg6CgagkVXwFwywa7WQHTlhzPSMw9T933Q==
X-Gm-Gg: AR+sD13rSCK7DYK7+PQEWqSDESsIR0Isyvv0q0y74OowUXETD8hqMSKejbp7AGwFpOH
 N3QjrHEZK1F0AiZbLGzXi+YDoAmoIRsgFvFof93lIEMjPcLajssdidKZBDC0C93DkLzi75el6m4
 ppvXYT7hdNV9N6LgfXkRgb/YrQ6jbIdoRSkd7QyfqNAmgkdvA9P2ng88rSdL1ZXO6nrQW1K+gHa
 J4fOpxwCsKoSC3yFS2kzn0xKpmGqe50D6pyV2s43jf8Rd5Pf0b3MI92vek3KnK5RygXJcORFCNK
 xEfsAKWGlZAsEUAJ6ijtS38e4rDJQOzLGJaGCgoTQS5KZKZnBxooHtDhas4rEKczQQt9kKItm5x
 8xR8EbfALbl7U+YbxUvJQ1euLWwZty5l8d5YeZUOPyHolAa4W82ogfECYQwa0wmk9IWHEsDrCoG
 5RMTQ+
X-Received: by 2002:a05:6214:3198:b0:8ee:fbc5:8110 with SMTP id
 6a1803df08f44-90c80fa74c3mr15979306d6.32.1787263175659; 
 Thu, 20 Aug 2026 14:59:35 -0700 (PDT)
X-Received: by 2002:a05:6214:3198:b0:8ee:fbc5:8110 with SMTP id
 6a1803df08f44-90c80fa74c3mr15978926d6.32.1787263175268; 
 Thu, 20 Aug 2026 14:59:35 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5edb3c03sm47627946d6.3.2026.08.20.14.59.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 14:59:34 -0700 (PDT)
Message-ID: <aad0607b-d78d-4cd5-822b-9c29bdfc2c6a@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 16:59:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] target/hexagon: implement direct-to-guest interrupt
 delivery
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
 <20260819013144.3264096-10-brian.cain@oss.qualcomm.com>
 <cfef4655-01ac-4cc2-b2d4-a45cd7294622@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <cfef4655-01ac-4cc2-b2d4-a45cd7294622@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hN9bK8Ux7CjYDVQaSCGrpEQYL3AofvLK
X-Proofpoint-ORIG-GUID: hN9bK8Ux7CjYDVQaSCGrpEQYL3AofvLK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MyBTYWx0ZWRfX2YazOyZPzSmX
 VXiwfxrcy8VripJGzVGEFQRLQU0oFSr8A1sUzk7F/51JiGjcH0pnhPcSH0aPayti50Yl5X0DrSV
 bdGW21QRd9IOkZko8zMc1kuK8/fSzU++UUSiVlDEPC0nxpU3LyRyc2NZCAERSDIk+XuHaMGpeqi
 Cf533dP4jLWuqnhKJWloqhOmJzTyHd2MDVF4cuBTES5vJrhiQ4gxauelYwW4Bh8TupnYjZ99Lfb
 0baidhVEuPay1YtRwF2KCx1UR1tJvUPKeYjvvf5epOWcZxGDGqTsrKiJjTKL92qtyMegeJqaDah
 /zWDINJB+X+AoJn7IiwfZADj6o05bnrwB68mEyw6EoqwUOm2Kz7YW7i3l/awpbkWifSkhJrJO2j
 fUd2xgptXYmZXy8EVFEQHZCsuBkXYsZ/TGtYYx2xctsP3BQuITCFDyf+/QgotCaGdDAGF465Zeb
 A4foZtk9TMLgnLQx6Gw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MyBTYWx0ZWRfX83Di3phZfXac
 Tx32efu7mpDITVRjHPTqRX42X3FE4aYlayV93Zq7Vyq36jOaxfSKO+NOAaVF9dLGtdUbKZpXX6f
 wemXyJicH6tVsZB6N9MTuAnx7w1Kuao=
X-Authority-Analysis: v=2.4 cv=JoXBas4C c=1 sm=1 tr=0 ts=6a8778c8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=sVik-Gj8kpLVY5oBZ9AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200163
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


On 8/20/2026 1:57 PM, Pierrick Bouvier wrote:
> On 8/18/2026 6:31 PM, Brian Cain wrote:
>> Interrupts 3 through 5 are routed to guest mode when CCR:GIE and the
>> matching CCR:VV bit are set.  Enter through GEVB rather than EVB,
>> record the pre-entry state in GSR and the return address in GELR, and
>> read the vector ID from the l2vic.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/reg_fields_def.h.inc |  7 +++
>>   target/hexagon/cpu.c                |  5 ++
>>   target/hexagon/hex_interrupts.c     | 87 ++++++++++++++++++++++++++---
>>   3 files changed, 92 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/hexagon/reg_fields_def.h.inc b/target/hexagon/reg_fields_def.h.inc
>> index d2c706d56b5..29497fbcc4d 100644
>> --- a/target/hexagon/reg_fields_def.h.inc
>> +++ b/target/hexagon/reg_fields_def.h.inc
>> @@ -136,6 +136,13 @@ DEF_REG_FIELD(CCR_VV1, 29, 1)
>>   DEF_REG_FIELD(CCR_VV2, 30, 1)
>>   DEF_REG_FIELD(CCR_VV3, 31, 1)
>>   
>> +/* GSR fields */
>> +DEF_REG_FIELD(GSR_CAUSE, 0, 16)
>> +DEF_REG_FIELD(GSR_CFI, 28, 1)
>> +DEF_REG_FIELD(GSR_SS, 29, 1)
>> +DEF_REG_FIELD(GSR_IE, 30, 1)
>> +DEF_REG_FIELD(GSR_UM, 31, 1)
>> +
>>   /* ISDB ST fields */
>>   DEF_REG_FIELD(ISDBST_WAITRUN, 24, 8)
>>   DEF_REG_FIELD(ISDBST_ONOFF, 16, 8)
>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>> index 0a677840bcb..efaf569c6f8 100644
>> --- a/target/hexagon/cpu.c
>> +++ b/target/hexagon/cpu.c
>> @@ -475,6 +475,11 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
>>           error_setg(errp, "hexagon cpu requires 'tlb' link property to be set");
>>           return;
>>       }
>> +    if (!HEXAGON_CPU(dev)->l2vic) {
>> +        error_setg(errp,
>> +                   "hexagon cpu requires 'l2vic' link property to be set");
>> +        return;
>> +    }
>>   #endif
>>   
>>       qemu_init_vcpu(cs);
>> diff --git a/target/hexagon/hex_interrupts.c b/target/hexagon/hex_interrupts.c
>> index 3534481da24..ea1ba0903dd 100644
>> --- a/target/hexagon/hex_interrupts.c
>> +++ b/target/hexagon/hex_interrupts.c
>> @@ -11,6 +11,7 @@
>>   #include "cpu_helper.h"
>>   #include "exec/cpu-interrupt.h"
>>   #include "hex_interrupts.h"
>> +#include "hw/intc/hex-l2vic.h"
>>   #include "macros.h"
>>   #include "sys_macros.h"
>>   #include "system/cpus.h"
>> @@ -215,19 +216,75 @@ static void restore_state(CPUHexagonState *env, bool int_accepted)
>>       }
>>   }
>>   
>> +static bool int_should_dtg(CPUHexagonState *env, int int_num)
>> +{
> What does dtg means?

"dtg" is "direct-to-guest" interrupts.  This is an architectural feature 
to raise interrupts directly in the guest instead of the monitor/VMM, 
saving the latency of having to manually propagate interrupts to the guest.

Maybe this is a good case for a clarifying comment on `int_should_dtg()`?

>
>> +    uint32_t ccr = env->t_sreg[HEX_SREG_CCR];
>> +
>> +    switch (int_num) {
>> +    case 3:
>> +        if (!GET_FIELD(CCR_VV1, ccr)) {
>> +            return false;
>> +        }
>> +        break;
>> +    case 4:
>> +        if (!GET_FIELD(CCR_VV2, ccr)) {
>> +            return false;
>> +        }
>> +        break;
>> +    case 5:
>> +        if (!GET_FIELD(CCR_VV3, ccr)) {
>> +            return false;
>> +        }
>> +        break;
>> +    default:
>> +        return false;
>> +    }
>> +
>> +    return GET_FIELD(CCR_GIE, ccr);
>> +}
>> +
>> +static void guest_interrupt_entry(CPUHexagonState *env, uint32_t cause,
>> +                                  uint32_t event_pc)
>> +{
>> +    uint32_t old_ssr = env->t_sreg[HEX_SREG_SSR];
>> +    uint32_t new_ssr = old_ssr;
>> +    uint32_t ccr = env->t_sreg[HEX_SREG_CCR];
>> +    uint32_t gsr = 0;
>> +
>> +    gsr = deposit32(gsr, reg_field_info[GSR_CAUSE].offset,
>> +                    reg_field_info[GSR_CAUSE].width, cause);
>> +    gsr = deposit32(gsr, reg_field_info[GSR_SS].offset,
>> +                    reg_field_info[GSR_SS].width,
>> +                    GET_SSR_FIELD(SSR_SS, old_ssr));
>> +    gsr = deposit32(gsr, reg_field_info[GSR_UM].offset,
>> +                    reg_field_info[GSR_UM].width,
>> +                    !GET_SSR_FIELD(SSR_GM, old_ssr));
>> +    gsr = deposit32(gsr, reg_field_info[GSR_IE].offset,
>> +                    reg_field_info[GSR_IE].width,
>> +                    GET_FIELD(CCR_GIE, ccr));
>> +    env->greg[HEX_GREG_GSR] = gsr;
>> +
>> +    fSET_FIELD(new_ssr, SSR_SS, 0);
>> +    fSET_FIELD(new_ssr, SSR_GM, 1);
>> +    env->t_sreg[HEX_SREG_SSR] = new_ssr;
>> +    hexagon_modify_ssr(env, new_ssr, old_ssr);
>> +
>> +    SET_SYSTEM_FIELD(env, HEX_SREG_CCR, CCR_GIE, 0);
>> +    env->greg[HEX_GREG_GELR] = event_pc;
>> +    env->gpr[HEX_REG_PC] = env->t_sreg[HEX_SREG_GEVB] |
>> +                           (HEX_EVENT_INT0 << 2);
>> +}
>> +
>>   static void hex_accept_int(CPUHexagonState *env, int int_num)
>>   {
>>       CPUState *cs = env_cpu(env);
>>       HexagonCPU *cpu = env_archcpu(env);
>> -    uint32_t evb =
>> -        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_EVB,
>> -                               env->threadId);
>>       const int exe_mode = get_exe_mode(env);
>>       const bool in_wait_mode = exe_mode == HEX_EXE_MODE_WAIT;
>> +    uint32_t elr;
>>   
>>       set_ipend_bit(env, int_num, 0);
>>       set_iad_bit(env, int_num, 1);
>> -    set_ssr_ex_cause(env, 1, HEX_CAUSE_INT0 | int_num);
>>       cs->exception_index = HEX_EVENT_INT0 + int_num;
>>       env->cause_code = HEX_EVENT_INT0 + int_num;
>>       clear_pending_locks(env);
>> @@ -235,15 +292,31 @@ static void hex_accept_int(CPUHexagonState *env, int int_num)
>>           qemu_log_mask(CPU_LOG_INT,
>>               "%s: thread " TARGET_FMT_ld " resuming, exiting WAIT mode\n",
>>               __func__, env->threadId);
>> -        set_elr(env, env->wait_next_pc);
>> +        elr = env->wait_next_pc;
>>           clear_wait_mode(env);
>>           cs->halted = false;
>>       } else if (env->k0_lock_state == HEX_LOCK_WAITING) {
>>           g_assert_not_reached();
>>       } else {
>> -        set_elr(env, env->gpr[HEX_REG_PC]);
>> +        elr = env->gpr[HEX_REG_PC];
>> +    }
>> +
>> +    if (int_should_dtg(env, int_num)) {
>> +        int vic_group = int_num - 2;
>> +        uint32_t vid_packed = l2vic_read_vid(cpu->l2vic, vic_group / 2);
>> +        uint32_t vid = extract32(vid_packed,
>> +                                 (vic_group & 1) ? 16 : 0, 16);
>> +
>> +        guest_interrupt_entry(env, vid, elr);
>> +    } else {
>> +        uint32_t evb =
>> +            hexagon_globalreg_read(cpu->globalregs, HEX_SREG_EVB,
>> +                                   env->threadId);
>> +
>> +        set_ssr_ex_cause(env, 1, HEX_CAUSE_INT0 | int_num);
>> +        set_elr(env, elr);
>> +        env->gpr[HEX_REG_PC] = evb | (cs->exception_index << 2);
>>       }
>> -    env->gpr[HEX_REG_PC] = evb | (cs->exception_index << 2);
>>       if (get_ipend(env) == 0) {
>>           restore_state(env, true);
>>       }

