Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE461CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utIZx-0004Mp-Kj; Tue, 02 Sep 2025 00:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIZa-00042K-SS
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:24:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIZY-0001AF-6c
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:24:46 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SuwU011396
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 04:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HtFBowf/B5f24nMQ7iGb1zz8xAYQ+fqDLO5A/K0h5WU=; b=FAFpRGO74dwaJZ9x
 +5aZ/eUn/QfEvfAqBilV+f3NrnXQuwYGK7L58t8e5dUcHUkeAhhcONNLcpKm/0x2
 UlYVGCnP1DOFETV2XM7Kx5H5QiL/bxeUu7UtPsGoc7bAOG78cuvrOSstuKv1UPC8
 PQ8jA+DFOy7CSX+17uoYr4kjBfSu1gfIpqSj4oaLpr0V81Q7TdrTiXu59T4XaXdg
 sH0bU4/XrY7vz0EJq2qOQfylylWC7/2oSbeZumMkJjcnG8UY494lbSXQNZ54aHba
 3qT3QlPZJK7bFzcloPVUe+dcny4o5j9B+00tK2Iy7INtxQjJG9qBykv4t7lnnyMC
 8ucdRw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjefkg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:24:43 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4b339e7d107so19263981cf.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 21:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756787082; x=1757391882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HtFBowf/B5f24nMQ7iGb1zz8xAYQ+fqDLO5A/K0h5WU=;
 b=VkLdkZKf++yDPDlwY1AZEoX0dQFIT52zFVB9rGiOb3ldvcKF4BIsoy583y2XG/ye11
 SjwzdvAnwLfyi8bN1P31eLC822HZ9VNNL64K7NcniMij9/v1Q/Xfp5VjwiVOpsxVjT71
 Xf0unLg/EYie37vnpndK50cCIkuq9YITtizekVAbo9iTehJhxjKkiMXnvZoZwRFx7fz3
 5reiKbY+NLO6l2MG4sfc2hqVhvLTdfsqrSVrtZoMnF4qjWf9Qlu4uu2rdP6MWaI4zZ3q
 s2y8j0SjM+I4VL1jEJ17MgWlP+6253WsPF708L2KC72n7ZOrlyn4m+LTd1IJz/rHO9R4
 /0xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbCBeFYKvKhyQB6fsw565XQSqosgzaXJs17Wb6eLKz3jkfuFtMjyrZo4F29e+nmmBz5ReKOMFQ2o1B@nongnu.org
X-Gm-Message-State: AOJu0YzmRFRikUMUcErAg2DkI5gAGDOJ5dSAYC40yq7DnWT+CtT+EfNJ
 cwllXhYziPu5CkpXQQFYYF9RheZOsyxqxkiDgdEbvdGzmev5RAToEtz9y8krt9GCf8NHtPmrCn2
 lsjLTv3vXUy1gmBRrOTfAQUPDv/25b3EBvwJZKAHk3WxkfDjHbYybAfZa7Q==
X-Gm-Gg: ASbGncsHKc1oP3Amn/ONPwaCydXfHbqK44GZGaZJ6AnW+DXEsA/ebZN0HrmmTz86u/N
 NJ8xPEJXY8AqOQsW5HgrXLhR7MKfavEy9hs5iDq5gkaCahNvoyhybReGnEjhpF+kxgjGTW72HGD
 4xRGMOugR0rjf0bzpVcu05LDceBaRG0XMQ79FAXsQUdzoV1OVb4MGA8HkBDFczibxzZNpZaLlEj
 sae8wFe4ul66o6K9fu7EEPWZb4q+k6SomFPPamsRuBzhMlq8wm7V0MH+qoG+TrZRLLi/xsmSOFT
 x+9wT0TrPoKm0zCcH57BQo5Nz5unSrMPtPRnj5qOthPK9slnpcMi9Sq3iIRJqg==
X-Received: by 2002:a05:622a:4e:b0:4b0:b7ce:90b4 with SMTP id
 d75a77b69052e-4b31dcd88admr121933331cf.44.1756787081901; 
 Mon, 01 Sep 2025 21:24:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFamebzO4kb9FKSny5B1dF0Sqgpw3em0CqJvFpcKwSqS6VZc7CKqU9lS0oqen9DnMXDtXG69w==
X-Received: by 2002:a05:622a:4e:b0:4b0:b7ce:90b4 with SMTP id
 d75a77b69052e-4b31dcd88admr121933041cf.44.1756787081378; 
 Mon, 01 Sep 2025 21:24:41 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d5e5fsm17958390f8f.27.2025.09.01.21.24.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 21:24:40 -0700 (PDT)
Message-ID: <97c99d4e-12c5-46b1-9d1f-5734b5dc7f81@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 21:03:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/39] target/hexagon: Implement software interrupt
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>, 'Mike Lambert' <mlambert@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-18-brian.cain@oss.qualcomm.com>
 <02e101db9915$d1c42fe0$754c8fa0$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <02e101db9915$d1c42fe0$754c8fa0$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b6718b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=fjZv-glThPG368fN3rIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: G1xMI228W2lUBxuaqh7ut23uynP2PPea
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX4P0Si6g+BfMU
 djbJP11/kZZClSIfKGNboMpi2LxdjkCX4v7HQJ03QULp2kz3bfbE21cEMcG5iLQ6VuDdymYdCM6
 n7NW/aNmiPlDTQ/gAyw8zmnhik32EII340cwahuF+zYUzi7X/rbfJKlmrnDilMIZKl8fZKxmlwA
 Rq0qE5KT37N6ud1HPdnd/0wS2LyOGV5IN094IqUzzxyECEEs5CoDgMw6pb3VSeTYBe51ysMczX9
 TDY866iV80kH4rNhP2Ag+pTYMehF3fgz8ipoGMHCR8jr6ctkW5EIV9VIzMKZtArgTbpW5+qqG51
 94i2dzpBxD4bM5O4xyqedp5a+iM79jiZUoDZyQiBZGgSqf/Cbd+ArrFqJcbV94Onn1XF7AHTshQ
 lezetbKN
X-Proofpoint-ORIG-GUID: G1xMI228W2lUBxuaqh7ut23uynP2PPea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 3/19/2025 4:28 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:28 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>; Mike Lambert
>> <mlambert@quicinc.com>
>> Subject: [PATCH 17/39] target/hexagon: Implement software interrupt
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Co-authored-by: Mike Lambert <mlambert@quicinc.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu.h       |   1 -
>>   target/hexagon/hexswi.h    |  17 +++
>>   target/hexagon/cpu.c       |   2 +
>>   target/hexagon/hexswi.c    | 258
>> +++++++++++++++++++++++++++++++++++++
>>   target/hexagon/op_helper.c |   1 +
>>   5 files changed, 278 insertions(+), 1 deletion(-)  create mode 100644
>> target/hexagon/hexswi.h  create mode 100644 target/hexagon/hexswi.c
>>
>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h index
>> dabee310c5..045581d7be 100644
>> --- a/target/hexagon/cpu.h
>> +++ b/target/hexagon/cpu.h
>> @@ -256,5 +256,4 @@ typedef HexagonCPU ArchCPU;  void
>> hexagon_translate_init(void);  void hexagon_translate_code(CPUState *cs,
>> TranslationBlock *tb,
>>                               int *max_insns, vaddr pc, void *host_pc);
>> -
> Gratuitous change
Fixed in v2.
>>   #endif /* HEXAGON_CPU_H */
>> diff --git a/target/hexagon/hexswi.h b/target/hexagon/hexswi.h new file
>> mode 100644 index 0000000000..5d232cb06c
>> --- /dev/null
>> +++ b/target/hexagon/hexswi.h
>> @@ -0,0 +1,17 @@
>> +/*
>> + * Copyright(c) 2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later  */
>> +
>> +#ifndef HEXSWI_H
>> +#define HEXSWI_H
>> +
>> +
>> +#include "cpu.h"
>> +
>> +void hexagon_cpu_do_interrupt(CPUState *cpu); void
>> +register_trap_exception(CPUHexagonState *env, int type, int imm,
>> +                             target_ulong PC);
>> +
>> +#endif /* HEXSWI_H */
>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c index
>> 89a051b41d..843be8221f 100644
>> --- a/target/hexagon/cpu.c
>> +++ b/target/hexagon/cpu.c
>> @@ -33,6 +33,8 @@
>>   #ifndef CONFIG_USER_ONLY
>>   #include "sys_macros.h"
>>   #include "qemu/main-loop.h"
>> +#include "hex_interrupts.h"
>> +#include "hexswi.h"
> Move these added include to a different patch where the contents are needed.

I didn't fix this in v2 because I convinced myself that these were 
appropriate as-is.  But on reconsideration I think I'm mistaken and will 
try to fix this for v3.


>>   #endif
>>
>>   static void hexagon_v66_cpu_init(Object *obj) { } diff --git
>> a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c new file mode
>> 100644 index 0000000000..5fcf9b2be9
>> --- /dev/null
>> +++ b/target/hexagon/hexswi.c
>> @@ -0,0 +1,258 @@
>> +/*
>> + * Copyright(c) 2019-2025 Qualcomm Innovation Center, Inc. All Rights
>> Reserved.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later  */
>> +
>> +#include "qemu/osdep.h"
>> +#include "cpu.h"
>> +#ifdef CONFIG_USER_ONLY
> This file is only included in the system-mode build, so we don't need these guards.  Several in this file.

Fixed in v2.


>> +#include "exec/helper-proto.h"
>> +#include "qemu.h"
>> +#endif
>> +#include "exec/cpu_ldst.h"
>> +#include "exec/exec-all.h"
>> +#include "qemu/log.h"
>> +#include "qemu/main-loop.h"
>> +#include "arch.h"
>> +#include "internal.h"
>> +#include "macros.h"
>> +#include "sys_macros.h"
>> +#include "tcg/tcg-op.h"
>> +#ifndef CONFIG_USER_ONLY
>> +#include "hex_mmu.h"
>> +#include "hexswi.h"
>> +#endif
>> +
>> +#ifndef CONFIG_USER_ONLY
>> +
>> +
>> +static void set_addresses(CPUHexagonState *env, target_ulong pc_offset,
>> +                          target_ulong exception_index)
>> +
>> +{
>> +    arch_set_system_reg(env, HEX_SREG_ELR,
>> +                        arch_get_thread_reg(env, HEX_REG_PC) + pc_offset);
>> +    arch_set_thread_reg(env, HEX_REG_PC,
>> +                        arch_get_system_reg(env, HEX_SREG_EVB) |
>> +                            (exception_index << 2)); }
>> +
>> +static const char *event_name[] = {
>> +    [HEX_EVENT_RESET] = "HEX_EVENT_RESET",
>> +    [HEX_EVENT_IMPRECISE] = "HEX_EVENT_IMPRECISE",
>> +    [HEX_EVENT_TLB_MISS_X] = "HEX_EVENT_TLB_MISS_X",
>> +    [HEX_EVENT_TLB_MISS_RW] = "HEX_EVENT_TLB_MISS_RW",
>> +    [HEX_EVENT_TRAP0] = "HEX_EVENT_TRAP0",
>> +    [HEX_EVENT_TRAP1] = "HEX_EVENT_TRAP1",
>> +    [HEX_EVENT_FPTRAP] = "HEX_EVENT_FPTRAP",
>> +    [HEX_EVENT_DEBUG] = "HEX_EVENT_DEBUG",
>> +    [HEX_EVENT_INT0] = "HEX_EVENT_INT0",
>> +    [HEX_EVENT_INT1] = "HEX_EVENT_INT1",
>> +    [HEX_EVENT_INT2] = "HEX_EVENT_INT2",
>> +    [HEX_EVENT_INT3] = "HEX_EVENT_INT3",
>> +    [HEX_EVENT_INT4] = "HEX_EVENT_INT4",
>> +    [HEX_EVENT_INT5] = "HEX_EVENT_INT5",
>> +    [HEX_EVENT_INT6] = "HEX_EVENT_INT6",
>> +    [HEX_EVENT_INT7] = "HEX_EVENT_INT7",
>> +    [HEX_EVENT_INT8] = "HEX_EVENT_INT8",
>> +    [HEX_EVENT_INT9] = "HEX_EVENT_INT9",
>> +    [HEX_EVENT_INTA] = "HEX_EVENT_INTA",
>> +    [HEX_EVENT_INTB] = "HEX_EVENT_INTB",
>> +    [HEX_EVENT_INTC] = "HEX_EVENT_INTC",
>> +    [HEX_EVENT_INTD] = "HEX_EVENT_INTD",
>> +    [HEX_EVENT_INTE] = "HEX_EVENT_INTE",
>> +    [HEX_EVENT_INTF] = "HEX_EVENT_INTF"
>> +};
>> +
>> +void hexagon_cpu_do_interrupt(CPUState *cs)
>> +
>> +{
>> +    CPUHexagonState *env = cpu_env(cs);
>> +    BQL_LOCK_GUARD();
>> +
>> +    qemu_log_mask(CPU_LOG_INT, "\t%s: event 0x%x:%s, cause
>> 0x%x(%d)\n",
>> +                  __func__, cs->exception_index,
>> +                  event_name[cs->exception_index], env->cause_code,
>> +                  env->cause_code);
>> +
>> +    env->llsc_addr = ~0;
>> +
>> +    uint32_t ssr = arch_get_system_reg(env, HEX_SREG_SSR);
> Declarations at the beginning of the function.

Fixed in v2.


>> +    if (GET_SSR_FIELD(SSR_EX, ssr) == 1) {
>> +        arch_set_system_reg(env, HEX_SREG_DIAG, env->cause_code);
>> +        env->cause_code = HEX_CAUSE_DOUBLE_EXCEPT;
>> +        cs->exception_index = HEX_EVENT_PRECISE;
>> +    }
>> +
>> +    switch (cs->exception_index) {
>> +    case HEX_EVENT_TRAP0:
>> +        if (env->cause_code == 0) {
>> +            qemu_log_mask(LOG_UNIMP,
>> +                          "trap0 is unhandled, no semihosting available\n");
>> +        }
>> +
>> +        hexagon_ssr_set_cause(env, env->cause_code);
>> +        set_addresses(env, 4, cs->exception_index);
>> +        break;
>> +
>> +    case HEX_EVENT_TRAP1:
>> +        hexagon_ssr_set_cause(env, env->cause_code);
>> +        set_addresses(env, 4, cs->exception_index);
>> +        break;
>> +
>> +    case HEX_EVENT_TLB_MISS_X:
>> +        switch (env->cause_code) {
>> +        case HEX_CAUSE_TLBMISSX_CAUSE_NORMAL:
>> +        case HEX_CAUSE_TLBMISSX_CAUSE_NEXTPAGE:
>> +            qemu_log_mask(CPU_LOG_MMU,
>> +                          "TLB miss EX exception (0x%x) caught: "
>> +                          "Cause code (0x%x) "
>> +                          "TID = 0x%" PRIx32 ", PC = 0x%" PRIx32
>> +                          ", BADVA = 0x%" PRIx32 "\n",
>> +                          cs->exception_index, env->cause_code, env->threadId,
>> +                          arch_get_thread_reg(env, HEX_REG_PC),
>> +                          arch_get_system_reg(env, HEX_SREG_BADVA));
>> +
>> +            hexagon_ssr_set_cause(env, env->cause_code);
>> +            set_addresses(env, 0, cs->exception_index);
>> +            break;
>> +
>> +        default:
>> +            cpu_abort(cs,
>> +                      "1:Hexagon exception %d/0x%x: "
>> +                      "Unknown cause code %d/0x%x\n",
>> +                      cs->exception_index, cs->exception_index, env->cause_code,
>> +                      env->cause_code);
>> +            break;
>> +        }
>> +        break;
>> +
>> +    case HEX_EVENT_TLB_MISS_RW:
>> +        switch (env->cause_code) {
>> +        case HEX_CAUSE_TLBMISSRW_CAUSE_READ:
>> +        case HEX_CAUSE_TLBMISSRW_CAUSE_WRITE:
>> +            qemu_log_mask(CPU_LOG_MMU,
>> +                          "TLB miss RW exception (0x%x) caught: "
>> +                          "Cause code (0x%x) "
>> +                          "TID = 0x%" PRIx32 ", PC = 0x%" PRIx32
>> +                          ", BADVA = 0x%" PRIx32 "\n",
>> +                          cs->exception_index, env->cause_code, env->threadId,
>> +                          env->gpr[HEX_REG_PC],
>> +                          arch_get_system_reg(env, HEX_SREG_BADVA));
>> +
>> +            hexagon_ssr_set_cause(env, env->cause_code);
>> +            set_addresses(env, 0, cs->exception_index);
>> +            /* env->sreg[HEX_SREG_BADVA] is set when the exception is raised
>> */
>> +            break;
>> +
>> +        default:
>> +            cpu_abort(cs,
>> +                      "2:Hexagon exception %d/0x%x: "
>> +                      "Unknown cause code %d/0x%x\n",
>> +                      cs->exception_index, cs->exception_index, env->cause_code,
>> +                      env->cause_code);
>> +            break;
>> +        }
>> +        break;
>> +
>> +    case HEX_EVENT_FPTRAP:
>> +        hexagon_ssr_set_cause(env, env->cause_code);
>> +        arch_set_thread_reg(env, HEX_REG_PC,
>> +                            arch_get_system_reg(env, HEX_SREG_EVB) |
>> +                                (cs->exception_index << 2));
> Why not use set_addresses here?  How is ELR set?
>
>> +        break;
>> +
>> +    case HEX_EVENT_DEBUG:
>> +        hexagon_ssr_set_cause(env, env->cause_code);
>> +        set_addresses(env, 0, cs->exception_index);
>> +        qemu_log_mask(LOG_UNIMP, "single-step exception is not
>> handled\n");
>> +        break;
>> +
>> +    case HEX_EVENT_PRECISE:
>> +        switch (env->cause_code) {
>> +        case HEX_CAUSE_FETCH_NO_XPAGE:
>> +        case HEX_CAUSE_FETCH_NO_UPAGE:
>> +        case HEX_CAUSE_PRIV_NO_READ:
>> +        case HEX_CAUSE_PRIV_NO_UREAD:
>> +        case HEX_CAUSE_PRIV_NO_WRITE:
>> +        case HEX_CAUSE_PRIV_NO_UWRITE:
>> +        case HEX_CAUSE_MISALIGNED_LOAD:
>> +        case HEX_CAUSE_MISALIGNED_STORE:
>> +        case HEX_CAUSE_PC_NOT_ALIGNED:
>> +            qemu_log_mask(CPU_LOG_MMU,
>> +                          "MMU permission exception (0x%x) caught: "
>> +                          "Cause code (0x%x) "
>> +                          "TID = 0x%" PRIx32 ", PC = 0x%" PRIx32
>> +                          ", BADVA = 0x%" PRIx32 "\n",
>> +                          cs->exception_index, env->cause_code, env->threadId,
>> +                          env->gpr[HEX_REG_PC],
>> +                          arch_get_system_reg(env, HEX_SREG_BADVA));
>> +
>> +
>> +            hexagon_ssr_set_cause(env, env->cause_code);
>> +            set_addresses(env, 0, cs->exception_index);
>> +            /* env->sreg[HEX_SREG_BADVA] is set when the exception is raised
>> */
>> +            break;
>> +
>> +        case HEX_CAUSE_DOUBLE_EXCEPT:
>> +        case HEX_CAUSE_PRIV_USER_NO_SINSN:
>> +        case HEX_CAUSE_PRIV_USER_NO_GINSN:
>> +        case HEX_CAUSE_INVALID_OPCODE:
>> +        case HEX_CAUSE_NO_COPROC_ENABLE:
>> +        case HEX_CAUSE_NO_COPROC2_ENABLE:
>> +        case HEX_CAUSE_UNSUPORTED_HVX_64B:
>> +        case HEX_CAUSE_REG_WRITE_CONFLICT:
>> +        case HEX_CAUSE_VWCTRL_WINDOW_MISS:
>> +            hexagon_ssr_set_cause(env, env->cause_code);
>> +            set_addresses(env, 0, cs->exception_index);
>> +            break;
>> +
>> +        case HEX_CAUSE_COPROC_LDST:
>> +            hexagon_ssr_set_cause(env, env->cause_code);
>> +            set_addresses(env, 0, cs->exception_index);
>> +            break;
>> +
>> +        case HEX_CAUSE_STACK_LIMIT:
>> +            hexagon_ssr_set_cause(env, env->cause_code);
>> +            set_addresses(env, 0, cs->exception_index);
>> +            break;
>> +
>> +        default:
>> +            cpu_abort(cs,
>> +                      "3:Hexagon exception %d/0x%x: "
>> +                      "Unknown cause code %d/0x%x\n",
>> +                      cs->exception_index, cs->exception_index, env->cause_code,
>> +                      env->cause_code);
>> +            break;
>> +        }
>> +        break;
>> +
>> +    case HEX_EVENT_IMPRECISE:
>> +        qemu_log_mask(LOG_UNIMP,
>> +                "Imprecise exception: this case is not yet handled");
>> +        break;
>> +
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP,
>> +                "Hexagon Unsupported exception 0x%x/0x%x\n",
>> +                  cs->exception_index, env->cause_code);
>> +        break;
>> +    }
>> +
>> +    cs->exception_index = HEX_EVENT_NONE; }
>> +
>> +void register_trap_exception(CPUHexagonState *env, int traptype, int
>> imm,
>> +                             target_ulong PC) {
>> +    CPUState *cs = env_cpu(env);
>> +
>> +    cs->exception_index = (traptype == 0) ? HEX_EVENT_TRAP0 :
>> HEX_EVENT_TRAP1;
>> +    ASSERT_DIRECT_TO_GUEST_UNSET(env, cs->exception_index);
>> +
>> +    env->cause_code = imm;
>> +    env->gpr[HEX_REG_PC] = PC;
>> +    cpu_loop_exit(cs);
>> +}
>> +#endif
>> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
>> index 42805d0f1d..687e7f45c2 100644
>> --- a/target/hexagon/op_helper.c
>> +++ b/target/hexagon/op_helper.c
>> @@ -38,6 +38,7 @@
>>   #include "hex_mmu.h"
>>   #include "hw/intc/l2vic.h"
>>   #include "hex_interrupts.h"
>> +#include "hexswi.h"
> Move this do a different patch where the contents are needed

I didn't fix this in v2 because I convinced myself that these were 
appropriate as-is.  But on reconsideration I think I'm mistaken and will 
try to fix this for v3.


>>   #endif
>>
>>   #define SF_BIAS        127
>> --
>> 2.34.1
>

