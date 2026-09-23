Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1013DC98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 01:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9ByD-0004TN-9m; Tue, 22 Sep 2026 21:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9By8-0004S7-7t
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 21:40:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9By6-0003aE-4Q
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 21:40:19 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MN7r6a1402061
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 01:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hyMfAlhlQIUCvBYlmOsEi0f3x6qCvBZUD1fnjI8YGt0=; b=mIGjF2g/izbvx9GP
 4iEycg5CuGdLULmUDgQQNQsvtssVD9lKGqH3ncxxfN1SAZH4aaEC0b3P8yT/dPoX
 FjqtYToDuO7VrLiFmbRMcEFG4apw1CX2Ol7QOFqnfiyfw5kjs/kEEuo1gkKAKrh7
 zR0KN4WWWD6xo4QVYGCjKQdsgARU/Evcu0zAH3JgslhVLVEOD4dP3UJComICSM5q
 r2zLwa6qVDIeXRuJ+jmW877zHn6UdESTNMKwZ3Eonl+ReO8m9EJWTdCWpK8HfioO
 GndW6vRgCgN7cZWMaQFvacjuZpIPuS7HRU+7r7A0eYthWL5sKiv8C2gn2dMZRShH
 K6re+w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv3318df2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 01:40:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93bd22160bbso98887385a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 18:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790127614; x=1790732414; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hyMfAlhlQIUCvBYlmOsEi0f3x6qCvBZUD1fnjI8YGt0=;
 b=a/d/8dXfhJNujEZbgesZmvoxvoIvJjzxAWi9xTqGgdVwQSBL/cYQMu1j8XkDJyrSov
 CvFKRTTqz5FfptHa76HR8Xjf8w6sqFCbrxh5Ikahpye2YmEupT6CnUP0JlCfKJnIKcvM
 tBSC9u3WxGAR3AphIZIa3KBVfVF6HLPvWFYBQlD8R/eKCVRH2tEFn96yoVFkQkle0B9/
 /W7IVqco+ey/1g7XYSrIAF1cQs8nWv4oOkjZ28/vHl+RlsJXloMk1gT3CdWLH9Fv4i+6
 ey0s6SMYckZ0vNS0wfODclfBgIUBc6/3I6xXnwbZh41+KKSCTLkAQZKKRgbIS7sxCrwv
 bjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790127614; x=1790732414;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hyMfAlhlQIUCvBYlmOsEi0f3x6qCvBZUD1fnjI8YGt0=;
 b=0CrwFxnext5Z+haSf4kQ7cmvAosswghhieCk4UiiYQF600LC5Aq3FXkXag6YAvt4fb
 b3qLMqsDwjnLS5IRMMw2Ly7rAXZEoUmv1hjlGDFt7TS5kzqDxN1xZUKSq/Wo2F47oUf6
 OEQvyQ0PxcKcxYzFZNvzAEAElYWdU5be+0Jx8Kj33vdiXZmrsDeQ1Kn3skCRbb9277nB
 YxkTF6evSOAB32yJ3yQah597RwI/S8rk7w6mipe8EmygbIM3NXjtmlhqvovbRIk2GO2Y
 Wt+pWSy5A3WHOQKsmY0iKPtHq8c1FdcU8T5sFXg7Ese6nq0P7TBfdTYMN5l3zjChGW6L
 RbRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAC0tSIMsflgD6n4YPjIHuTu4IEINULSS4zyMKP2kfM2JV39qBDrOwYxZmOX3/pmpbCu/LU6FbiVTR@nongnu.org
X-Gm-Message-State: AFuF++lFsU9fu4IKSJzzF+8b+/lT0m4hZcz0DsvCA2FSyBXSff3xJuNn
 TotgA3wIR7JEYCTnyQ6kI60rJpj7hOEhnCctcT3d3eC5tlMthvt50sk6NA6+B1AC2ElusdefBzX
 zr5M1pKy+6nFeDnZwPPxkmEbnE2nM9RkGji929hAlV0nztit1X8Tj9m238Q==
X-Gm-Gg: AYBFou3mhJOsvVjK1PJufuUHyAUJPNdjtxoHSI/nWH9xMnZVMCY6gi9POa+FSPgrRJP
 NxXeJXtAMHa67flkvH/9ZeK4IzfySRIYY2MXADZP6sSPJIPqvFJNuM1xchGPeiq8xTCuHhEm7DZ
 X6WZkVAvK+ccn5xdVbKEC0nYQd1Jz2ltU7tkQ+n6LNcbN5bFTMEG4Ww0YWYSyUluzKrEyoO9jHm
 ZQMPoOHN1VtnOkm62od4BVkYFu1x+ccD5j8GGkPK657d7ei6guzVFz4eOQcviNOaUzxv/lcwsmB
 SBHzh4mdSREUGTw2jXRAmfrzWliZ7Ir2bs3fTr86k9Ua2Pij23KWJwks/DAyvfyAQxzkHn/N8if
 hKNWJl0AQJNL1dB7GEhbcpK/EqQnY+JH6sTQgMaCjCzON3iswAPfr2NIUHjK9
X-Received: by 2002:a05:620a:2682:b0:93c:2419:37d6 with SMTP id
 af79cd13be357-93c252555e7mr196068185a.66.1790127614294; 
 Tue, 22 Sep 2026 18:40:14 -0700 (PDT)
X-Received: by 2002:a05:620a:2682:b0:93c:2419:37d6 with SMTP id
 af79cd13be357-93c252555e7mr196066485a.66.1790127613907; 
 Tue, 22 Sep 2026 18:40:13 -0700 (PDT)
Received: from [10.248.104.162] (136.sub-174-237-82.myvzw.com.
 [174.237.82.136]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c2485883asm116576885a.20.2026.09.22.18.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 18:40:13 -0700 (PDT)
Message-ID: <9f65087d-f8f4-469f-a099-9fbb48a12158@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 20:40:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] target/hexagon: share HVX contexts among CPUs
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260915145541.4038637-1-brian.cain@oss.qualcomm.com>
 <20260915145541.4038637-6-brian.cain@oss.qualcomm.com>
 <88356789-fd7c-4641-a1ac-5291a5fe34de@oss.qualcomm.com>
 <b109667c-e31f-4126-981e-c7bc1c8629aa@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b109667c-e31f-4126-981e-c7bc1c8629aa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KUQ5D4QLP7Kcml9mfLJIQLgUBNpAe5sK
X-Authority-Analysis: v=2.4 cv=HdaB3SE8 c=1 sm=1 tr=0 ts=6ab32dfe cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=9PLFPpoJQzO8A2hTliJUZw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=m_B-xraQ-SmDn7oG9mAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: KUQ5D4QLP7Kcml9mfLJIQLgUBNpAe5sK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAwNiBTYWx0ZWRfX0IQKZQL2YKKm
 KfFVuG+emktVPRT4lFh7/RA9j+S31cruGGg5JI/ouU8BN5KwyYxE+9CwhhvHFFo7pDZuq5lgJH3
 wD6sP/WarQpkWlQseUTSzGAPKwXE8Oduiu5Vz0TzBDa0kVaRGP3zn5dv3XykxWkoPgR7OqPDpiy
 qU57sGVHpQAzquVPKDBQb5Hl8PbnuphLCAgnHUOZn7rHdWR/c97N7JN7MvsbrEPI8Wq3nRKwpiI
 FxSSziIAaX9ewtsfJ4zJ9vn1qLTfxzCNbL8FpvKVUcKSWuHyLxEhJI9DsmZvaetO1qBdSJG7MYa
 zvh3KHdIqMpPtOoyzHtGcVl50OWp5ifVUaxFQBX6lT1kBygaLqYVtkaBR1GC186fHkVDt/071qu
 RJj3IGU0bLrxVbHF7u0V0rnk7GZUeWCdpe96d4SHorl4C0Q7ntcxpOj1nGA3VwOMcrZMuo+74T6
 YRx8ZKazHmoF7kRX89A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAwNiBTYWx0ZWRfX5qLc0C5KEbR8
 yASR2qbUASFj64MX/NWciqJHxm8CFF6DcOM+7u0XA3t+FBSNEzRu7f1LH5alepxY4kAxcC+Pj59
 Ld18r7ZCSjk4EQsbh9aOxveno7C0EzA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230006
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 9/22/2026 1:43 PM, Brian Cain wrote:
>
> On 9/21/2026 6:59 AM, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 15/9/26 16:55, Brian Cain wrote:
>>> The HVX register file belongs to an extension context, not a 
>>> hardware thread.
>>> Model each system-emulation context as a QOM device, link the 
>>> contexts to
>>> each vCPU, and use SSR:XA to select the active context.
>>>
>>> Keep one embedded context per linux-user CPU.  Carry the selected 
>>> register-file
>>> base with HVX operands so translated code can address the selected 
>>> context
>>> at run time.
>>>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   include/hw/hexagon/hexagon.h             |   1 +
>>>   include/hw/hexagon/hexagon_hvx_context.h |  27 +
>>>   target/hexagon/cpu.h                     |  25 +-
>>>   target/hexagon/cpu_helper.h              |   1 +
>>>   target/hexagon/gen_tcg_hvx.h             | 608 
>>> +++++++++++++----------
>>>   target/hexagon/genptr.h                  |   8 +
>>>   target/hexagon/mmvec/macros.h            |  14 +-
>>>   target/hexagon/translate.h               |  11 +-
>>>   hw/hexagon/hex-subsys.c                  |  36 ++
>>>   hw/hexagon/hexagon_hvx_context.c         |  84 ++++
>>>   target/hexagon/cpu.c                     |  30 +-
>>>   target/hexagon/cpu_helper.c              |  82 +++
>>>   target/hexagon/gdbstub.c                 |  16 +-
>>>   target/hexagon/genptr.c                  | 102 ++--
>>>   target/hexagon/machine.c                 |  12 +
>>>   target/hexagon/op_helper.c               |  37 +-
>>>   target/hexagon/translate.c               |  60 ++-
>>>   hw/hexagon/meson.build                   |   1 +
>>>   target/hexagon/hex_common.py             | 179 ++++---
>>>   19 files changed, 886 insertions(+), 448 deletions(-)
>>>   create mode 100644 include/hw/hexagon/hexagon_hvx_context.h
>>>   create mode 100644 hw/hexagon/hexagon_hvx_context.c
>>
>>
>>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
>>> index 97f689fda22..df4c0182247 100644
>>> --- a/target/hexagon/cpu.h
>>> +++ b/target/hexagon/cpu.h
>>> @@ -29,6 +29,7 @@
>>>     typedef struct HexagonTLBState HexagonTLBState;
>>>   typedef struct HexagonGlobalRegState HexagonGlobalRegState;
>>> +typedef struct HexagonHVXContextState HexagonHVXContextState;
>>>     #include "cpu-qom.h"
>>>   #include "exec/cpu-common.h"
>>> @@ -49,6 +50,7 @@ typedef struct HexagonGlobalRegState 
>>> HexagonGlobalRegState;
>>>   #define REG_WRITES_MAX 32
>>>   #define PRED_WRITES_MAX 5                   /* 4 insns + endloop */
>>>   #define VSTORES_MAX 2
>>
>> Could this simplify #ifdef'ry maintenance in source?
>>
>>   #ifdef CONFIG_USER_ONLY
>>   #define HVX_CONTEXTS_MAX 1
>>   #else
>>
>>> +#define HVX_CONTEXTS_MAX 8
>>
>>   #endif
>>
> Okay, good idea - I'll give it a go. 


Hmmm - making that change and making both modes have a 
"HexagonHVXContext *hvx" would work but then we'd need to add some 
ifdef'd magic to cpu_copy() so that we get one context bound to each 
thread.  That sounds like it's not a net win.


>
>>>   #define MAX_TLB_ENTRIES 1024
>>>   #define THREADS_MAX 16
>>>   @@ -120,6 +122,11 @@ typedef struct {
>>>   /* Maximum number of vector temps in a packet */
>>>   #define VECTOR_TEMPS_MAX            4
>>>   +typedef struct HexagonHVXContext {
>>> +    MMVector VRegs[NUM_VREGS];
>>> +    MMQReg QRegs[NUM_QREGS];
>>> +} QEMU_ALIGNED(16) HexagonHVXContext;
>>> +
>>>   typedef struct CPUArchState {
>>>       target_ulong gpr[TOTAL_PER_THREAD_REGS];
>>>       target_ulong pred[NUM_PREGS];
>>> @@ -159,11 +166,15 @@ typedef struct CPUArchState {
>>>       target_ulong llsc_val;
>>>       uint64_t     llsc_val_i64;
>>>   -    MMVector VRegs[NUM_VREGS] QEMU_ALIGNED(16);
>>> +#ifdef CONFIG_USER_ONLY
>>> +    HexagonHVXContext hvx_ctx;
>>> +#else
>>> +    HexagonHVXContext *hvx;
>>> +#endif
>>> +
>>>       MMVector future_VRegs[VECTOR_TEMPS_MAX] QEMU_ALIGNED(16);
>>>       MMVector tmp_VRegs[VECTOR_TEMPS_MAX] QEMU_ALIGNED(16);
>>>   -    MMQReg QRegs[NUM_QREGS] QEMU_ALIGNED(16);
>>>       MMQReg future_QRegs[NUM_QREGS] QEMU_ALIGNED(16);
>>>         /* Temporaries used within instructions */
>>> @@ -196,6 +207,7 @@ struct ArchCPU {
>>>       CPUHexagonState env;
>>>       HexagonCPUConfig cfg;
>>>   #ifndef CONFIG_USER_ONLY
>>> +    HexagonHVXContextState *hvx_ctx[HVX_CONTEXTS_MAX];
>>>       HexagonTLBState *tlb;
>>>       uint32_t boot_addr;
>>>       HexagonGlobalRegState *globalregs;
>>> @@ -204,6 +216,15 @@ struct ArchCPU {
>>>   #endif
>>>   };
>>>   +static inline HexagonHVXContext *hex_hvx(CPUHexagonState *env)
>>> +{
>>> +#ifdef CONFIG_USER_ONLY
>>> +    return &env->hvx_ctx;
>>> +#else
>>> +    return env->hvx;
>>> +#endif
>>> +}
>>

