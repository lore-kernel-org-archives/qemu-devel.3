Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5E6CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI6H-0000GA-T3; Mon, 01 Sep 2025 23:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI6F-0008Uh-Td
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:54:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI69-0005UA-2v
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:54:27 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SKqC025556
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NUe8pJGoctrG/8DBrygrXeVgX6gxDjW8C9TwK6L3LXw=; b=GRHIXBJsWwC5wHhI
 vLri4h1e0SwqJtqlZ2wd3s6noJzgXBTd/6balDlcWuRLLBcJbFVcvnjih9alwYpm
 rf+C9nvAIEScplnw22v8ks5nyR/u9FiLyEbwzICCKnAR532V7gjZKAjF64grjzHA
 QKQMlq1pYG5obdoRWgKWy8Fqz7YVco5GnyTxglwINq53AKz/5QZjvDJIi4XVjS14
 /U2q4iCHzfistgEbx+h2aKRabaEPm5PKaWiNtzyHOsoH3GoccjPV+L4f0+hAzpPW
 AhUXPSXjL2IvK6rCYMuXovLYVnx26VYheM6iUMGKRNGZpjfp1dJ37sw4cyuLirFA
 hRj2Uw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuxep0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:54:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-24a8dcb3bddso27610585ad.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785258; x=1757390058;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NUe8pJGoctrG/8DBrygrXeVgX6gxDjW8C9TwK6L3LXw=;
 b=gF8hAeDnrpQvY2LDWTR3+AVEuuzQ35zXprvuPPUC4czP2k3GxTNGzHHMo9bgi+iNY4
 Q4YS9WXihbBINBWNkx7nsP9XH1D5gk+o7d6LgLrmqU4sLQuh4gcL12oYZJrkh4HhnSNh
 vszQQH+UHZLgZmcZH7MUFloBUgkMe30pkiWmcghenhJq02bZq66CvJStyoMETNZYQbzs
 +FhVjcg2eVDxiMzJ4UvWYqtCB/eUIhAs5vehBVpP7MH4zE4Ly2kA79bXBhtwkklsN+5/
 Y5jVU+8NmawuY7NQAdSIMNGUYykbpUfLsA3CeRDtNmSrGh2mjfSSJlOrqN1Shg46sjGd
 Ox4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgb2Vii81EPUlEb8yGHzNPgwtgOgLgdX2UMixptQOU+U9fFc4VOX5jFv45pY7UlL9mIfRRTGg1pRc+@nongnu.org
X-Gm-Message-State: AOJu0YysnOl0PMKm3SSIXedDqVYRdl3m8exL7e/5X6VNVSjdEtJbjHSt
 RAQoYyJrSEsfeTooVQI49FCdc+loi6sSlthqE6Zo7RWQccTDRMgWHI/Z3nXciyTAt55mbBn2on1
 IRzc3vTWnm7TzMToHgXvH6/FJwnm0q2UYHDHp0+2+1OZ5LUwoawjFSiOi3g==
X-Gm-Gg: ASbGncuCaP+ofrQUOEJ1fIUoA9o57OnD+90UicXZ+x2WyR+AmMwo///4dR+oqW3leh0
 cFOLaqLp7HrxD0eb43HMdW8NHpEV8IAV+hwInglOcVgIPcXbz7gUEICuiq74eOvta3bhZZ7gVsg
 YVpeFty1SD9f1gddEhUCQQjf0Ooe3fOnLIwXEBcc8Beh5Y9+u0Xv3eA8B6Ex+rjEXs0gOCeCbnY
 DdTkQZHdeFUlfxDz80inJ9MNURUcpuzefbhymPMjLyCm6g83qJZjqMyqqn5Soszy6BFGjmCpuiY
 tyz4WKFUbPozcM0el79KAccd+GWFxKnEcwPKe8Vtg9cGPE4hXZc0fFuM/bCwWQ==
X-Received: by 2002:a17:902:d4c5:b0:248:d67d:e176 with SMTP id
 d9443c01a7336-24944aa3a67mr141802515ad.38.1756785258277; 
 Mon, 01 Sep 2025 20:54:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBvvVhHPuQq47gVO3bmJN62HG7YIygGZ9nG0QUqwTE8ihJqCEp71FQnrATwXUldFgTqEmygA==
X-Received: by 2002:a17:902:d4c5:b0:248:d67d:e176 with SMTP id
 d9443c01a7336-24944aa3a67mr141802205ad.38.1756785257787; 
 Mon, 01 Sep 2025 20:54:17 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24903727e23sm119295495ad.45.2025.09.01.20.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 20:54:17 -0700 (PDT)
Message-ID: <e9cba40d-4860-48a6-abe0-eae8e03319e1@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 19:46:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/38] target/hexagon: Add sysemu TCG overrides
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-23-brian.cain@oss.qualcomm.com>
 <030901db8fcb$8611d410$92357c30$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <030901db8fcb$8611d410$92357c30$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX3Nt2qXeWlqZg
 KoDz63zbwH2QojCTowJTD7oN1XEGCxEieVB8QeHt/hLEw3pFvddL4AOl+kE2fnbdR5LW6OChB+A
 a63PT7sy+bJns9wFjdQWjN7isyPlUldDbpVkIPB6Zl+zQCbaDWlZ82ppxE8xRYBlfJEU9/ohrrh
 1lpTRmJ+OIzUKPfxQjmlQX8rHFIg/QPPme8THYwd/tWymboWk9drA0nsMvP7dXH2Me2i12gasDO
 Xk6A4OK5ShhGDtArDsCH4Jz7tjD6GXbBxMUMcHMPt8Iac5TyD/8LUfu0vhE/zFoTPeM3hUKCOap
 y8FWo447F2zGz+UzQemQx/sLN5HDDoUG+eNVPqI3KPnVUfP5WjuA36ypPZ60/4MEUZmMcFAGQ4O
 vqtJvkig
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b66a6b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=gLyP4fyVEMdYrpJmCBsA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: NoPEXOYCYHxOoFk3a_hinJga_rwwExmW
X-Proofpoint-GUID: NoPEXOYCYHxOoFk3a_hinJga_rwwExmW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


On 3/7/2025 7:43 PM, ltaylorsimpson@gmail.com wrote:
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
>> Subject: [PATCH 22/38] target/hexagon: Add sysemu TCG overrides
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Define TCG overrides for setprio(), crswap(,sgp{0,1,1:0}).
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu_helper.h  | 32 ++++++++++++++++++++++++++++
>> target/hexagon/gen_tcg_sys.h | 41
>> ++++++++++++++++++++++++++++++++++++
>>   target/hexagon/helper.h      |  1 +
>>   target/hexagon/cpu_helper.c  | 36 +++++++++++++++++++++++++++++++
>>   target/hexagon/genptr.c      |  4 ++++
>>   target/hexagon/op_helper.c   |  7 ++++++
>>   target/hexagon/hex_common.py |  2 ++
>>   target/hexagon/meson.build   | 14 ++++++------
>>   8 files changed, 131 insertions(+), 6 deletions(-)  create mode 100644
>> target/hexagon/cpu_helper.h  create mode 100644
>> target/hexagon/gen_tcg_sys.h  create mode 100644
>> target/hexagon/cpu_helper.c
>>
>> diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
>> new file mode 100644 index 0000000000..194bcbf451
>> --- /dev/null
>> +++ b/target/hexagon/cpu_helper.h
>> @@ -0,0 +1,32 @@
>> +/*
>> + * Copyright(c) 2019-2025 Qualcomm Innovation Center, Inc. All Rights
>> Reserved.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later  */
>> +
>> +#ifndef HEXAGON_CPU_HELPER_H
>> +#define HEXAGON_CPU_HELPER_H
>> +
>> +static inline void arch_set_thread_reg(CPUHexagonState *env, uint32_t
>> reg,
>> +                                       uint32_t val) {
>> +    g_assert(reg < TOTAL_PER_THREAD_REGS);
>> +    g_assert_not_reached();
>> +}
>> +
>> +static inline uint32_t arch_get_thread_reg(CPUHexagonState *env,
>> +uint32_t reg) {
>> +    g_assert(reg < TOTAL_PER_THREAD_REGS);
>> +    g_assert_not_reached();
>> +}
>> +
>> +static inline void arch_set_system_reg(CPUHexagonState *env, uint32_t
>> reg,
>> +                                       uint32_t val) {
>> +    g_assert_not_reached();
>> +}
>> +
>> +uint32_t arch_get_system_reg(CPUHexagonState *env, uint32_t reg);
>> +
>> +#endif
>> +
>> diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
>> new file mode 100644 index 0000000000..362703ab45
>> --- /dev/null
>> +++ b/target/hexagon/gen_tcg_sys.h
>> @@ -0,0 +1,41 @@
>> +/*
>> + * Copyright(c) 2022-2025 Qualcomm Innovation Center, Inc. All Rights
>> Reserved.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later  */
>> +
>> +#ifndef HEXAGON_GEN_TCG_SYS_H
>> +#define HEXAGON_GEN_TCG_SYS_H
>> +
>> +#define fGEN_TCG_Y2_setprio(SHORTCODE) \
>> +    gen_helper_setprio(tcg_env, PtV, RsV)
>> +
>> +#define fGEN_TCG_Y2_crswap0(SHORTCODE) \
>> +    do { \
>> +        TCGv tmp = tcg_temp_new(); \
>> +        tcg_gen_mov_tl(tmp, RxV); \
>> +        tcg_gen_mov_tl(RxV, hex_t_sreg[HEX_SREG_SGP0]); \
>> +        tcg_gen_mov_tl(ctx->t_sreg_new_value[HEX_SREG_SGP0], tmp); \
>> +    } while (0)
>> +
>> +#define fGEN_TCG_Y4_crswap1(SHORTCODE) \
>> +    do { \
>> +        TCGv tmp = tcg_temp_new(); \
>> +        tcg_gen_mov_tl(tmp, RxV); \
>> +        tcg_gen_mov_tl(RxV, hex_t_sreg[HEX_SREG_SGP1]); \
>> +        tcg_gen_mov_tl(ctx->t_sreg_new_value[HEX_SREG_SGP1], tmp); \
>> +    } while (0)
>> +
>> +#define fGEN_TCG_Y4_crswap10(SHORTCODE) \
>> +    do { \
>> +        g_assert_not_reached(); \
>> +        TCGv_i64 tmp = tcg_temp_new_i64(); \
>> +        tcg_gen_mov_i64(tmp, RxxV); \
>> +        tcg_gen_concat_i32_i64(RxxV, \
>> +                               hex_t_sreg[HEX_SREG_SGP0], \
>> +                               hex_t_sreg[HEX_SREG_SGP1]); \
>> +        tcg_gen_extrl_i64_i32(ctx->t_sreg_new_value[HEX_SREG_SGP0],
>> tmp); \
>> +        tcg_gen_extrh_i64_i32(ctx->t_sreg_new_value[HEX_SREG_SGP1],
>> tmp); \
>> +    } while (0)
>> +
>> +#endif
>> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h index
>> fddbd99a19..146f4f02e4 100644
>> --- a/target/hexagon/helper.h
>> +++ b/target/hexagon/helper.h
>> @@ -115,4 +115,5 @@ DEF_HELPER_2(greg_read, i32, env, i32)
>> DEF_HELPER_2(greg_read_pair, i64, env, i32)  DEF_HELPER_3(sreg_write,
>> void, env, i32, i32)  DEF_HELPER_3(sreg_write_pair, void, env, i32, i64)
>> +DEF_HELPER_3(setprio, void, env, i32, i32)
>>   #endif
>> diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
>> new file mode 100644 index 0000000000..6e4bc85580
>> --- /dev/null
>> +++ b/target/hexagon/cpu_helper.c
>> @@ -0,0 +1,36 @@
>> +/*
>> + * Copyright(c) 2019-2025 Qualcomm Innovation Center, Inc. All Rights
>> Reserved.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later  */
>> +
>> +#include "qemu/osdep.h"
>> +#include "cpu.h"
>> +#include "cpu_helper.h"
>> +#include "system/cpus.h"
>> +#ifdef CONFIG_USER_ONLY
>> +#include "qemu.h"
>> +#include "exec/helper-proto.h"
>> +#else
>> +#include "hw/boards.h"
>> +#include "hw/hexagon/hexagon.h"
>> +#endif
>> +#include "exec/exec-all.h"
>> +#include "exec/cpu_ldst.h"
>> +#include "qemu/log.h"
>> +#include "tcg/tcg-op.h"
>> +#include "internal.h"
>> +#include "macros.h"
>> +#include "sys_macros.h"
>> +#include "arch.h"
>> +
>> +
>> +#ifndef CONFIG_USER_ONLY
>> +
>> +uint32_t arch_get_system_reg(CPUHexagonState *env, uint32_t reg) {
>> +    g_assert_not_reached();
>> +}
> This should be a static inline in cpu_helper.h.
> That means you could postpone the introduction of this new file.


This was not addressed in v2, I will work on it for v3.

>
> Otherwise
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>
>

