Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA91CCA100E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utIID-0000mv-56; Tue, 02 Sep 2025 00:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIHg-0000dX-IW
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:06:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIHe-0007I8-7H
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:06:16 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RkKp029653
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 04:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RXatCP/vaW9uWQkEK8nshTmU1FDhcw8Dqcb5okpQqxU=; b=eSiwO95astmQEr3c
 dx27G9TwY5tDA0WmTZNbeP02neRvWYcJE6CTOWY+SOHzfKPRKnxZFpHujLoT2sJ9
 WHeWB8Dl+OTbAUSI3AsbICN6/IpA9I72DXD/9ogdly7m6pwunZZOS5lEqSCS4sz5
 fLQB6r6CSkcgu2KXs3n9wSMRRZb92lxbH5IHiLIIiiABh/yvw8ghRPm7GxO+4Kee
 CmDnPNNzI9UcF2ILOmnqk6JMBBhw/9wxGjH7nwQglOy19Z/vaGvSfGBe6hLFKlNM
 1vmvdhkpfOej2ZHQFUaZuz2sHV+0/Mh+2PPf4ZF5L/u6Vh0VmsCULbVgB1xIA23U
 jwUjNg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush2xbt1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:06:09 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-24ab0409d3eso35807545ad.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 21:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785969; x=1757390769;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RXatCP/vaW9uWQkEK8nshTmU1FDhcw8Dqcb5okpQqxU=;
 b=DpuQI+9OZyVOv95CC9TvCYRcJEZPvu1j/OB4QcPn3ZC0jtqu0HmT1fI8NMHKOWyjQS
 Tir0w9aJkva+cPz/Or2/CMEQsNycYarlSKGbau3e95Ef4mqYNBM0dVerJZEFD1fEzF1L
 +Ex3nHE9dy2omslDppATRkvoLwvEKKxpbV2XQ0yPvMEIWq1Wn+QVBIyzghcSVH5dcfrB
 oSQUp0s8Af47dRyddOPw8iZm9TRJCU7PT6QW2sgTMtD6Wq54zB2awXmmy5c6R91N4Ct/
 ZTOGU3w2hQO0VctG6BvHPgrf09WEi1UHdzeIOk2QoTJB9WSsOh4M+szizGSOuRvGyVms
 IhUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU23rq9XsuVQowEquXqb7SlXGJU6bSIl0H3lN2+BXLg23KtXTUL6aHsVRhTODDfB6t+IF9VaxAuUa1F@nongnu.org
X-Gm-Message-State: AOJu0Yxx2kgcMFZneH9KktK+y1Oc6GdTJIW8Yg8i0klXwHu9qRPRszxd
 053zvi5cwhDOilepG7a15faQnocYx69BXuDzt6leaUzwKPUs4px5IldfDzn9zJdfD4YXC4rN4qj
 KSVKDyFe9ELkQYFdUsHOtWuteTNNHdD8iD//qcCOL+7XGUwCtDoxgcEf6JQ==
X-Gm-Gg: ASbGnct32BgLvHhkXQGVCDs1EqCscI6ARyutU0dvVCX//z6WZVsYvqIIrurq4wFANT3
 KoH711FNmf9k1KBMjKHmDY26cbEGFMC+hxvtXhItshc6fUHf/xTII1Ui32H/PFcnWZGOiN9Pj8g
 SF7yshvJdJjPcdai/pbSvZwspGmdZbItuHqeXvsRDU8W5sBf6KWb+4zKHNkKCBzBQw5LgJ0r7IR
 AGgpI/Aqe7d9xFmy+wAPNsVF67qyFfIWJsPYy8bnjjcpK57lk8Tiz/EL7CmxdTokiAT8vTx8wsw
 P1CDUh0mZAaSMiu3gjZgWVcT5S4Vcx873oTamY89C9f7XidwWeTOxt1B1yYVsQ==
X-Received: by 2002:a17:902:dac6:b0:249:789:28f0 with SMTP id
 d9443c01a7336-249448cc423mr116060295ad.13.1756785968959; 
 Mon, 01 Sep 2025 21:06:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpOtBZ0dikytCyzkLuSCErI+4iPOCDsOIiHOk43PNNuH6P2naqBFHAgQYWpn9GtzeTiijmxw==
X-Received: by 2002:a17:902:dac6:b0:249:789:28f0 with SMTP id
 d9443c01a7336-249448cc423mr116060005ad.13.1756785968500; 
 Mon, 01 Sep 2025 21:06:08 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24903727e23sm119538555ad.45.2025.09.01.21.05.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 21:06:08 -0700 (PDT)
Message-ID: <d184740b-8f13-4c8c-b5d3-01679bccbb20@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 20:33:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/39] target/hexagon: Implement start/stop helpers
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-5-brian.cain@oss.qualcomm.com>
 <016801db975a$a42bdb30$ec839190$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <016801db975a$a42bdb30$ec839190$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX4A6nwR7rzp/N
 m+O1r61dC0bk/IfhgGqSPPxoBr2iMo71BRoKpqf/VI/KbIFclIQfANOzIyQLJnh9sXGPHas6p8e
 ESgbhXCEVDq0AQ5LCd/sTARezCtUYnR6MlzJoMcEaV56f8sdt2gd05ZV28OMR5duoe1LgDClfP2
 1IbSaCRiViXAtr1WqPa3BBnrgwrHZMTYrtx5QtEqFInCDJzZlzgGdX+TaZilKo68QHoxelJG7IM
 JGqooX77dtB7dWGCLt+pn8EBrkZoj2uj5o/IFr13vzjXBmC5JSJT4HwzBkS0blgfmlYBN5B+iGi
 fxLrDPaRzvopHmn0R5sBV2ZKCDCF/Dy3tIvXqTRoaspRSqlTri2hmJ6HH3xWAGlwToS55zeQmf9
 uaFLzBnf
X-Proofpoint-ORIG-GUID: NKEwiGvHTgfaGlgwGZl-bxVujYDnjtjX
X-Proofpoint-GUID: NKEwiGvHTgfaGlgwGZl-bxVujYDnjtjX
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b66d31 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=k-hRw0_JMA9RF8zVToUA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 3/17/2025 11:35 AM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:28 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>> Subject: [PATCH 04/39] target/hexagon: Implement start/stop helpers
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu.h        |  3 ++
>>   target/hexagon/cpu_bits.h   |  1 +
>>   target/hexagon/cpu_helper.h |  3 ++
>>   target/hexagon/cpu.c        | 14 +++++-
>>   target/hexagon/cpu_helper.c | 94
>> +++++++++++++++++++++++++++++++++++++
>>   target/hexagon/op_helper.c  |  4 +-
>>   6 files changed, 116 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h index
>> 894219fd20..1549c4f1f0 100644
>> --- a/target/hexagon/cpu.h
>> +++ b/target/hexagon/cpu.h
>> @@ -41,6 +41,7 @@ typedef struct CPUHexagonTLBContext
>> CPUHexagonTLBContext;  #define REG_WRITES_MAX 32
>>   #define PRED_WRITES_MAX 5                   /* 4 insns + endloop */
>>   #define VSTORES_MAX 2
>> +#define VECTOR_UNIT_MAX 8
> Not related to start/stop and not used in this patch.
HVX contexts moved out of this series, they'll return in a new series 
after we land parts 1,2,3.
>
>>   #ifndef CONFIG_USER_ONLY
>>   #define CPU_INTERRUPT_SWI      CPU_INTERRUPT_TGT_INT_0
>> @@ -178,6 +179,7 @@ struct ArchCPU {
>>   #ifndef CONFIG_USER_ONLY
>>       uint32_t num_tlbs;
>>       uint32_t l2vic_base_addr;
>> +    uint32_t hvx_contexts;
> Not related to start/stop.
>
>>   #endif
>>   };
>>
>> @@ -194,6 +196,7 @@ G_NORETURN void
>> hexagon_raise_exception_err(CPUHexagonState *env,  uint32_t
>> hexagon_greg_read(CPUHexagonState *env, uint32_t reg);  uint32_t
>> hexagon_sreg_read(CPUHexagonState *env, uint32_t reg);  void
>> hexagon_gdb_sreg_write(CPUHexagonState *env, uint32_t reg, uint32_t
>> val);
>> +void hexagon_cpu_soft_reset(CPUHexagonState *env);
>>   #endif
>>
>>   #include "exec/cpu-all.h"
>> diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h index
>> b559a7ba88..610094a759 100644
>> --- a/target/hexagon/cpu_bits.h
>> +++ b/target/hexagon/cpu_bits.h
>> @@ -52,6 +52,7 @@ enum hex_event {
>>
>>   enum hex_cause {
>>       HEX_CAUSE_NONE = -1,
>> +    HEX_CAUSE_RESET = 0x000,
>>       HEX_CAUSE_TRAP0 = 0x172,
>>       HEX_CAUSE_FETCH_NO_UPAGE =  0x012,
>>       HEX_CAUSE_INVALID_PACKET =  0x015,
>> diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
>> index 6f0c6697ad..95a0cc0788 100644
>> --- a/target/hexagon/cpu_helper.h
>> +++ b/target/hexagon/cpu_helper.h
>> @@ -17,6 +17,9 @@ void
>> hexagon_set_sys_pcycle_count_high(CPUHexagonState *env, uint32_t);
>> void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t
>> old);  int get_exe_mode(CPUHexagonState *env);  void
>> clear_wait_mode(CPUHexagonState *env);
>> +void hexagon_ssr_set_cause(CPUHexagonState *env, uint32_t cause); void
>> +hexagon_start_threads(CPUHexagonState *env, uint32_t mask); void
>> +hexagon_stop_thread(CPUHexagonState *env);
>>
>>   static inline void arch_set_thread_reg(CPUHexagonState *env, uint32_t reg,
>>                                          uint32_t val) diff --git a/target/hexagon/cpu.c
>> b/target/hexagon/cpu.c index cb56b929cf..84a96a194b 100644
>> --- a/target/hexagon/cpu.c
>> +++ b/target/hexagon/cpu.c
>> @@ -32,6 +32,7 @@
>>
>>   #ifndef CONFIG_USER_ONLY
>>   #include "sys_macros.h"
>> +#include "qemu/main-loop.h"
>>   #endif
>>
>>   static void hexagon_v66_cpu_init(Object *obj) { } @@ -61,6 +62,7 @@ static
>> const Property hexagon_cpu_properties[] = {
>>       DEFINE_PROP_UINT32("jtlb-entries", HexagonCPU, num_tlbs,
>> MAX_TLB_ENTRIES),
>>       DEFINE_PROP_UINT32("l2vic-base-addr", HexagonCPU, l2vic_base_addr,
>>           0xffffffffULL),
>> +    DEFINE_PROP_UINT32("hvx-contexts", HexagonCPU, hvx_contexts, 0),
> Not related to start/stop.
>
>>   #endif
>>       DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),

