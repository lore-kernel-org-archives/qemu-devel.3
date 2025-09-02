Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3E9CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI7B-0003xL-7U; Mon, 01 Sep 2025 23:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI78-0003mA-Fg
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:55:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI75-0005kE-CR
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:55:21 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rodf012377
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JmLMMC8pW6kHAF7ePhd1QmNygysToxC/uSomCIZmnfc=; b=EQ4HH7CeLnQg8/tm
 5rfgZLetu5Kf2n52KWZKaorTY8A9C4X51uC0vm69jr0dt8kQ4GdVSzpQQVEsU8LS
 Vay0pVFeQtY3gMZSIpVDX8v4eSiwWBxSY6qy//KLwJZ1qotF9yLbzDqemaz0ggMa
 PyVn322FaBxJgHxMYCfs94vQvJVBmuyjJCZ5U6oA3bJ6oT6eII7dsJIn03w3cOAa
 W/QbxJYAlq2AJaxScfeRW2V2GMnyJ68Mhn4oKzSUjfAJcxnOpMIGTSsjlaDrtMSa
 Q7kHMVAqnY/MSAzvX+KhMmqlDd1vrGy/HmQ5mwuln9WasYXA9lrGBgBblmzDpErq
 3Heh5Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2feajj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:55:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-244570600a1so60553395ad.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785305; x=1757390105;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JmLMMC8pW6kHAF7ePhd1QmNygysToxC/uSomCIZmnfc=;
 b=aEXvxOAsOmoui1XGd2hYa2GaozQU+GumNQSlSMY+h+BMLFsMUg7bp3wMRD1eRpjirQ
 96g119dXLpIlbiTNuSUlFgAyuMODHiv14fKmeNG43E/Z6IOInwX8DDe096wBhnaktekF
 GFdi9Iq3Pr9SHPOrmiOnzeYlHbVdu3Aw9pb2cKr3aBce97LSQxxhce/AZ/D6yEt1pka+
 dqUih4x7kR7X8iQc2CscpzHExXRb88Alg0dhA6WYl8xGA6E9c2FvK3PACHr4JxFqYLsu
 iV/Sli6vTHJdn21IYm9tM0+F6vsOIvR4xYeKgDC4TUMJftWA/qmvorypbfIUsD6pafGz
 /Vug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgMaAZGfHaRCr+8bwuE0Mi8PqF9RVHXaN8PXx+Kf+mK0LwNGnx6e4RXrcv1N5hwwF6VwAFrNzHNACs@nongnu.org
X-Gm-Message-State: AOJu0YwYqpFMcoh1yyWkKJIlXURZ9iOTyZS6IPN9QACYFg0miU9hIoxd
 XDGpXiwTaGyBqcE63FGuORrGjqB9gYlrYn2Da4n1NdKukxPHYlxXZMyYZCBmK6uWh9WSijppCIm
 ZJgU7NAEK4kZZW8YQC3BZ301iNTMjp0EvQqEKAe6TxZ8UYECRAkb2nU4WZA==
X-Gm-Gg: ASbGncuhPi/LySjdBaybkHhcCj9K6HrWd5n1i+UnQJImcsjp6c9wrTqaSL0T3duOlqS
 DogXoN5ZsuK3uuL8SCywB/RoOwHMelLYet+0HWNnCx1xElVr5TH+qVoovInMasolOmYdouIUscn
 ORuuAzqJAD1e/1+5R+55u3Bl9yjEWtHAi2hcoaOKaQNHHF6EkOD3HGwO/4HKqjLxgxfHsZ+zxQk
 8Os0Djev+nCAaZx0csXADYNeZTjbrsv2R6tSuwRLJgdK4my/g6zmUMJKnHCHQ9q2Chs61oZR17A
 /QQ13XFfYvVCcH9V2IyGkdrUCUMotZAh9fhTobkoMGWE9MYq9H/ppXbDBo+KTA==
X-Received: by 2002:a17:902:e5cb:b0:249:f73:bbad with SMTP id
 d9443c01a7336-2493ec11630mr154105965ad.0.1756785305252; 
 Mon, 01 Sep 2025 20:55:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUNarBThVwpoi+czC9aNPApRFMF6d7nO3dHKEPypS83Tt6vEk/O9eK+wWtUafcya04sWkexg==
X-Received: by 2002:a17:902:e5cb:b0:249:f73:bbad with SMTP id
 d9443c01a7336-2493ec11630mr154105635ad.0.1756785304788; 
 Mon, 01 Sep 2025 20:55:04 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24905da25dbsm119720745ad.68.2025.09.01.20.54.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 20:55:04 -0700 (PDT)
Message-ID: <be67c0e7-cdb9-408a-b1e2-26fb0466bf30@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 19:53:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/38] target/hexagon: Add sreg_{read,write} helpers
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-28-brian.cain@oss.qualcomm.com>
 <00a201db92dc$66add3d0$34097b70$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <00a201db92dc$66add3d0$34097b70$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfXwbCpHetKi7o0
 g6fi7lKVy8xegrJgA8yL8Axa/o/vcKM2YRnzwYx0Swu6dy0kn8bfYi+aBUWXJ1ydVlgiPnJW5Au
 Z+2e4kr3saEKrXWwtWaje9ZlbmUh0717Cqw7MkVdV8fVd4tX6lKxrgLKcETm0o+Sta6G5NIyPVw
 tVXwk4mDE9V5AKf3exKD4LMd7R16g24DN9jFQ7r4qF6mn3fuNSC50nHABIxB/sgwLKlbYwgB63/
 4f9mQi8D4McfvF6vnvFd9OsbxCV2oPwQCLehRzjENultBc8J+usNoFJPRQi08alcEZteghYHaRr
 peQ5BL1PgS2PMJPttjnRQ0S6Vxk5i5/ZAOXEAtGqQ21XhwH6l6mQTIPMPHJou/BFzr/y6/6awys
 yJpoOneY
X-Proofpoint-ORIG-GUID: JmAcyOIuwjtUAy6T-UVa2AvO7jPTe68S
X-Proofpoint-GUID: JmAcyOIuwjtUAy6T-UVa2AvO7jPTe68S
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b66a9a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=o4f20BpcAAKX1N7CF-gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/11/2025 6:22 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:26 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>> Subject: [PATCH 27/38] target/hexagon: Add sreg_{read,write} helpers
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Co-authored-by: Sid Manning <sidneym@quicinc.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu_helper.h |   8 +++
>>   target/hexagon/cpu.c        |   1 +
>>   target/hexagon/cpu_helper.c |  37 ++++++++++++
>> target/hexagon/op_helper.c  | 114
>> ++++++++++++++++++++++++++++++++++--
>>   4 files changed, 156 insertions(+), 4 deletions(-)
>>
>
> diff --git a/target/hexagon/cpu.c
>> b/target/hexagon/cpu.c index 0db91a936a..36a93cc22f 100644
>> --- a/target/hexagon/cpu.c
>> +++ b/target/hexagon/cpu.c
>> @@ -322,6 +322,7 @@ static void hexagon_cpu_realize(DeviceState *dev,
>> Error **errp)
>>       qemu_init_vcpu(cs);
>>       cpu_reset(cs);
>>   #ifndef CONFIG_USER_ONLY
>> +    CPUHexagonState *env = cpu_env(cs);
> Is there a use for this?  If it's in a later patch, move this declaration there.
>
>>       if (cs->cpu_index == 0) {
>>           env->g_sreg = g_new0(target_ulong, NUM_SREGS);
>>       } else {
>
>> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
>> index 139a0b5ab2..76b2475d88 100644
>> --- a/target/hexagon/op_helper.c
>> +++ b/target/hexagon/op_helper.c
>> @@ -17,6 +17,7 @@
>>
>>   #include "qemu/osdep.h"
>>   #include "qemu/log.h"
>> +#include "qemu/main-loop.h"
>>   #include "exec/exec-all.h"
>>   #include "exec/cpu_ldst.h"
>>   #include "exec/helper-proto.h"
>> @@ -1397,25 +1398,130 @@ void HELPER(setimask)(CPUHexagonState *env,
>> uint32_t pred, uint32_t imask)
>>       g_assert_not_reached();
>>   }
>>
>> +static bool handle_pmu_sreg_write(CPUHexagonState *env, uint32_t reg,
>> +                                  uint32_t val) {
>> +    if (reg == HEX_SREG_PMUSTID0 || reg == HEX_SREG_PMUSTID1
>> +        || reg == HEX_SREG_PMUCFG || reg == HEX_SREG_PMUEVTCFG
>> +        || reg == HEX_SREG_PMUEVTCFG1
>> +        || (reg >= HEX_SREG_PMUCNT4 && reg <= HEX_SREG_PMUCNT3)) {
>> +        qemu_log_mask(LOG_UNIMP, "PMU registers not yet implemented");
>> +        return true;
>> +    }
>> +    return false;
>> +}
>> +
> Poor name for this function.  It's not *handling* the write, it's checking for a set of registers.  Until PMU registers are implemented, it's hard to comment on the correctness of the check.


Yeah, I guess I tried to preserve the shell of PMU code while putting in 
a stub implementation and it looks inconsistent.   I'll try just 
introducing this call later when the feature implementation shows up 
instead.


>
>> +static inline QEMU_ALWAYS_INLINE void sreg_write(CPUHexagonState
>> *env,
>> +                                                 uint32_t reg, uint32_t
>> +val)
>> +
>> +{
>> +    g_assert(bql_locked());
>> +    if ((reg == HEX_SREG_VID) || (reg == HEX_SREG_VID1)) {
>> +        hexagon_set_vid(env, (reg == HEX_SREG_VID) ? L2VIC_VID_0 :
>> L2VIC_VID_1,
>> +                        val);
>> +        arch_set_system_reg(env, reg, val);
>> +    } else if (reg == HEX_SREG_SYSCFG) {
>> +        modify_syscfg(env, val);
>> +    } else if (reg == HEX_SREG_IMASK) {
>> +        val = GET_FIELD(IMASK_MASK, val);
>> +        arch_set_system_reg(env, reg, val);
>> +    } else if (reg == HEX_SREG_PCYCLELO) {
>> +        hexagon_set_sys_pcycle_count_low(env, val);
>> +    } else if (reg == HEX_SREG_PCYCLEHI) {
>> +        hexagon_set_sys_pcycle_count_high(env, val);
>> +    } else if (!handle_pmu_sreg_write(env, reg, val)) {
> This should be
>      } else if (handle_pmu_sreg_write(...)) {
>          qemu_log_mask(LOG_UNIMP, ...);
>      } else {
> That leaves a better spot for you to come back in the future and add the implementation.
>
>> +        if (reg >= HEX_SREG_GLB_START) {
>> +            arch_set_system_reg(env, reg, val);
>> +        } else {
>> +            arch_set_system_reg(env, reg, val);
>> +        }
> Why the check when the two conditions do the same thing?
>
>> +    }
>> +}
>> +
>>   void HELPER(sreg_write)(CPUHexagonState *env, uint32_t reg, uint32_t val)
>> {
>> -    g_assert_not_reached();
>> +    BQL_LOCK_GUARD();
>> +    sreg_write(env, reg, val);
>>   }
>>
>>   void HELPER(sreg_write_pair)(CPUHexagonState *env, uint32_t reg,
>> uint64_t val)
>> +{
>> +    BQL_LOCK_GUARD();
>> +    sreg_write(env, reg, val & 0xFFFFFFFF);
>> +    sreg_write(env, reg + 1, val >> 32); }
>>
>> +static inline QEMU_ALWAYS_INLINE uint32_t sreg_read(CPUHexagonState
>> *env,
>> +                                                    uint32_t reg)
>>   {
>> -    g_assert_not_reached();
>> +    g_assert(bql_locked());
>> +    if (reg == HEX_SREG_PMUSTID0 || reg == HEX_SREG_PMUSTID1
>> +        || reg == HEX_SREG_PMUCFG || reg == HEX_SREG_PMUEVTCFG
>> +        || reg == HEX_SREG_PMUEVTCFG1
>> +        || (reg >= HEX_SREG_PMUCNT4 && reg <= HEX_SREG_PMUCNT3)) {
>> +        qemu_log_mask(LOG_UNIMP, "PMU registers not yet implemented");
>> +        return 0;
>> +    }
>> +    if ((reg == HEX_SREG_VID) || (reg == HEX_SREG_VID1)) {
>> +        const uint32_t vid = hexagon_find_last_irq(env, reg);
>> +        arch_set_system_reg(env, reg, vid);
>> +    } else if ((reg == HEX_SREG_TIMERLO) || (reg == HEX_SREG_TIMERHI)) {
>> +        uint32_t low = 0;
>> +        uint32_t high = 0;
>> +        hexagon_read_timer(env, &low, &high);
>> +        arch_set_system_reg(env, HEX_SREG_TIMERLO, low);
>> +        arch_set_system_reg(env, HEX_SREG_TIMERHI, high);
>> +    } else if (reg == HEX_SREG_BADVA) {
>> +        target_ulong ssr = arch_get_system_reg(env, HEX_SREG_SSR);
>> +        if (GET_SSR_FIELD(SSR_BVS, ssr)) {
>> +            return arch_get_system_reg(env, HEX_SREG_BADVA1);
>> +        }
>> +        return arch_get_system_reg(env, HEX_SREG_BADVA0);
>> +    }
>> +    return arch_get_system_reg(env, reg);
>>   }
>>
>>   uint32_t HELPER(sreg_read)(CPUHexagonState *env, uint32_t reg)  {
>> -    g_assert_not_reached();
>> +    BQL_LOCK_GUARD();
>> +    return sreg_read(env, reg);
>>   }
>>
>>   uint64_t HELPER(sreg_read_pair)(CPUHexagonState *env, uint32_t reg)  {
>> -    g_assert_not_reached();
>> +    BQL_LOCK_GUARD();
>> +    if (reg == HEX_SREG_TIMERLO) {
>> +        uint32_t low = 0;
>> +        uint32_t high = 0;
>> +        hexagon_read_timer(env, &low, &high);
>> +        arch_set_system_reg(env, HEX_SREG_TIMERLO, low);
>> +        arch_set_system_reg(env, HEX_SREG_TIMERHI, high);
> Why handle this here instead of relying on sreg_read?
>
>> +    } else if (reg == HEX_SREG_PCYCLELO) {
>> +        return hexagon_get_sys_pcycle_count(env);
> Why isn't this handled in sreg_read?
>
>> +    }
>> +    return   (uint64_t)sreg_read(env, reg) |
>> +           (((uint64_t)sreg_read(env, reg + 1)) << 32);
>>   }
>>
>>   uint32_t HELPER(greg_read)(CPUHexagonState *env, uint32_t reg)
>> --
>> 2.34.1
Most of the above issues remain in v2.  I will work on addressing these 
for v3.
>

