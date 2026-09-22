Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7312C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x95TB-0006LB-Ba; Tue, 22 Sep 2026 14:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x95T7-0006G2-Ur
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:43:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x95T5-0006YM-Gu
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:43:53 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI6tXQ2033218
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 18:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iRLbfP70PhRdYZITN4f4G3R/lEJGsTgfnwo6JDD3SRU=; b=bSBlFIZ+d2FQ7tsT
 Qx3ArKCCJosgDHYrBWJWmwo67FxHgvX6t6qS9Rj+8Dmw9gE6f9dF+ztsDR/MPn7u
 yB9Ld/yOIG77g7oMn7Dz6z3wNTvPuUsQkITMvbLhn+ASdoxY0cCk27Eurt9LGcxy
 g4/1viZhk488tadW4qwMm4VJOzA42KjpC8SKaFTmNHVMrPb24X7M6ny6c+Kbvqqk
 dGBCAcZ5llT+A38hPEgLn0p6EVjFX+YZmUEpofgk9hAV/7B/WAekjFCSxaX3O7be
 DkR8zPLSVmLTNtEtUn3d6o6VfzKAE2CwzD7rj2Zlvu6Gf0i9MQ4ce7DzBD7POrml
 1OUz/w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux8c0b6p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 18:43:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a05d645acso46229785a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 11:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790102626; x=1790707426; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iRLbfP70PhRdYZITN4f4G3R/lEJGsTgfnwo6JDD3SRU=;
 b=QJxm/liAjbNlSaF7fHQ7D6Z9PC1Bu07UMw/zNy9XGopGJzsSYwo3J7Dq7JKflsbsEg
 8aeKz2bn4VKCnAzV5aYAZjCvQizsGOpQYBNsvZTbt+m8vYiDLBvcYuj+RbNfSrRIqW5K
 j0db1gV2NE4swvliKCRLqBWUxXaUypTOclnwZ+VHM3GboSI/LJnogQN+1dBPjCqQV9Mx
 ExvKTpVpwilsHqxiAyCyW8MYj8dpuBMJwm5qgW0WXzt440CEOyIHgizMSHbGwxDzbXHe
 2lErAmzpSKo2Nw/f+HxkC+fN9adNw5VGz07231KFZL92SlN1GVAG2YCo/H8/4oaIrlrz
 27GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790102626; x=1790707426;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iRLbfP70PhRdYZITN4f4G3R/lEJGsTgfnwo6JDD3SRU=;
 b=u2nDJEL4XRw77Mt04a2Vnx3P6Eki0s/K9hL2PlXaWLvGOSsUpOOymM4DZR1P/9j7tt
 OjroIqknX7xeLrMTv2xKP3C/2eO4CkEYDdmuPRNyYvKxSNqm8XtftkPBvCwK01n8DwuJ
 LUHyER31VRHN5uplJkavUcLPnaZyugoFEu4vzHnvMeHmrb0wq2JqxIMuhWJgBfZBO6zW
 Wxv2D4wuY+SwJmEXwGSo0hxXjym8XYpHfpQu1egYx5WrkHBDihHLb6uexabiGKVSQPe5
 QnHfZweIfW82WAgsnuo1eoxh6QHdDgWpPHHhgqb30iq8Mj+sevtoXb3DktJ4z1QJYaaj
 ZdKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2MXs1DUVKaNdZxN3n1DpptZXva6MJnVE75vq+lIwnot0hWl5+hLHTV280pARa3FqeCIcBCXl1nC8/@nongnu.org
X-Gm-Message-State: AFuF++mQgorlEBB6AfuHVKIONg/AcxAvWMQxT1oPzu35XsgECWtNoxhU
 wm0mEkRzJ5JDc0/N6b8USu/Gc9hFJnyX/mSiaZFvbnirh+oLQlLdn6WyD6D5pzHVM2I4L/4WtKw
 bOzvrhPSf5Lv4SoRRVvloaLt6tPc82/nmx036RpBECEMWQUC6iLKRs74d6A==
X-Gm-Gg: AYBFou0eZ5mh7xYnlkEvjGxqVlOInoECrGv+G9Etu3lWsl0LOJ2HuHOZHiNgVAb+vE3
 55dB9A1//7G37PNmm5hyghDqktZ0Z7SVg3LruVUJ072olu5sZkZiBFC1pJbd4ltxiHa3VffyXme
 2gglCxsQif4nT7CkAf5Xpy3p4K0XwZfCmlDA2M6cmq/gQzGaOcKVxmX5nR8qZmlDvVnLwVJKD5p
 7FFWz7RnYE5DXUlX4aWcwhqpB4IIY+vRyeLZOdFMkoESDy4TFBBWURHMQbNB2FVBG1N0zwbizg6
 d7h66mCc2ScdJL62OW2cUo57Zk8Zm81Z8r5gPxIo8w/m24tERXVXZKRo1ojztyMnAKxgqoincnw
 XasHExGXS6XjKUw39QzVvqQgqxFMNPhsERYqrqCh2b0LOkbVVVHoM7Vx/yo8MxT9q
X-Received: by 2002:a05:620a:2697:b0:93b:d79b:9a67 with SMTP id
 af79cd13be357-93c2526dec1mr40090585a.72.1790102626326; 
 Tue, 22 Sep 2026 11:43:46 -0700 (PDT)
X-Received: by 2002:a05:620a:2697:b0:93b:d79b:9a67 with SMTP id
 af79cd13be357-93c2526dec1mr40087885a.72.1790102625799; 
 Tue, 22 Sep 2026 11:43:45 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9140c41134esm3768906d6.21.2026.09.22.11.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 11:43:44 -0700 (PDT)
Message-ID: <b109667c-e31f-4126-981e-c7bc1c8629aa@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 13:43:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] target/hexagon: share HVX contexts among CPUs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260915145541.4038637-1-brian.cain@oss.qualcomm.com>
 <20260915145541.4038637-6-brian.cain@oss.qualcomm.com>
 <88356789-fd7c-4641-a1ac-5291a5fe34de@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <88356789-fd7c-4641-a1ac-5291a5fe34de@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI3NCBTYWx0ZWRfX+Zz/YAZP7el5
 r2gjS6vxCdjUtLZpPqTS8ZSV91xENM08CyTy8l4jqGf2X6i6CP1qUWGSI6Ev8NF1GpwNSTR5XEB
 ynLXN8Ra4qP8w6Ml9JjbwlgFkoLXxhPKP70g2ipIGlxTaHTUzDyDRZRZ+LBuWVKvoZw+b5JaPcG
 Tc/fCer6XnMeKad+ms6vLWJxu/qk0BcXWGP1ezZ2ZqPAe6iFAcugY+p8OnLHLdzQDf1KLtKEjJg
 1iacqasKjctIFDMR0Smw8eFE/oIbo8Hu4GDOUYafoEsBhXntIkuFgFf7ZoybqORDJaCxEh3gqtl
 9YWJVr1h3Qd2+gPbz5lSj0zdbjGgl6PMohgnoRoSqiQ79JcqRstmCYsxoeTNGXuXBzHOFcbKS9w
 QeglGrNzkOMxgERwFesQ+Ugda6xIyP6dK4iDnrcEcmC5yPQZaU8CgasTVa6qiRmzT0dj4f5c9tJ
 dxl5FOMsWDu5ZWHzVAQ==
X-Authority-Analysis: v=2.4 cv=P9evFSAu c=1 sm=1 tr=0 ts=6ab2cc63 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=XYppQdVU47HfOEa1YxsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 9ATc66-HTOKaZnoAI61-od1rHw2n7gCZ
X-Proofpoint-GUID: 9ATc66-HTOKaZnoAI61-od1rHw2n7gCZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI3NCBTYWx0ZWRfX99mxjQ6CzG+3
 q5Rd4kjf9UfAjVCf0MdqKv7u5rdZGVgE48nVvOsvuaQ17QGgDxGtz6cT/R6mYojGuozYwjNsIvR
 07PLKFO+x8pXA3+z0CHD7w8oFpBMViI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220274
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 9/21/2026 6:59 AM, Philippe Mathieu-Daudé wrote:
> Hi,
>
> On 15/9/26 16:55, Brian Cain wrote:
>> The HVX register file belongs to an extension context, not a hardware 
>> thread.
>> Model each system-emulation context as a QOM device, link the 
>> contexts to
>> each vCPU, and use SSR:XA to select the active context.
>>
>> Keep one embedded context per linux-user CPU.  Carry the selected 
>> register-file
>> base with HVX operands so translated code can address the selected 
>> context
>> at run time.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   include/hw/hexagon/hexagon.h             |   1 +
>>   include/hw/hexagon/hexagon_hvx_context.h |  27 +
>>   target/hexagon/cpu.h                     |  25 +-
>>   target/hexagon/cpu_helper.h              |   1 +
>>   target/hexagon/gen_tcg_hvx.h             | 608 +++++++++++++----------
>>   target/hexagon/genptr.h                  |   8 +
>>   target/hexagon/mmvec/macros.h            |  14 +-
>>   target/hexagon/translate.h               |  11 +-
>>   hw/hexagon/hex-subsys.c                  |  36 ++
>>   hw/hexagon/hexagon_hvx_context.c         |  84 ++++
>>   target/hexagon/cpu.c                     |  30 +-
>>   target/hexagon/cpu_helper.c              |  82 +++
>>   target/hexagon/gdbstub.c                 |  16 +-
>>   target/hexagon/genptr.c                  | 102 ++--
>>   target/hexagon/machine.c                 |  12 +
>>   target/hexagon/op_helper.c               |  37 +-
>>   target/hexagon/translate.c               |  60 ++-
>>   hw/hexagon/meson.build                   |   1 +
>>   target/hexagon/hex_common.py             | 179 ++++---
>>   19 files changed, 886 insertions(+), 448 deletions(-)
>>   create mode 100644 include/hw/hexagon/hexagon_hvx_context.h
>>   create mode 100644 hw/hexagon/hexagon_hvx_context.c
>
>
>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
>> index 97f689fda22..df4c0182247 100644
>> --- a/target/hexagon/cpu.h
>> +++ b/target/hexagon/cpu.h
>> @@ -29,6 +29,7 @@
>>     typedef struct HexagonTLBState HexagonTLBState;
>>   typedef struct HexagonGlobalRegState HexagonGlobalRegState;
>> +typedef struct HexagonHVXContextState HexagonHVXContextState;
>>     #include "cpu-qom.h"
>>   #include "exec/cpu-common.h"
>> @@ -49,6 +50,7 @@ typedef struct HexagonGlobalRegState 
>> HexagonGlobalRegState;
>>   #define REG_WRITES_MAX 32
>>   #define PRED_WRITES_MAX 5                   /* 4 insns + endloop */
>>   #define VSTORES_MAX 2
>
> Could this simplify #ifdef'ry maintenance in source?
>
>   #ifdef CONFIG_USER_ONLY
>   #define HVX_CONTEXTS_MAX 1
>   #else
>
>> +#define HVX_CONTEXTS_MAX 8
>
>   #endif
>
Okay, good idea - I'll give it a go.


>>   #define MAX_TLB_ENTRIES 1024
>>   #define THREADS_MAX 16
>>   @@ -120,6 +122,11 @@ typedef struct {
>>   /* Maximum number of vector temps in a packet */
>>   #define VECTOR_TEMPS_MAX            4
>>   +typedef struct HexagonHVXContext {
>> +    MMVector VRegs[NUM_VREGS];
>> +    MMQReg QRegs[NUM_QREGS];
>> +} QEMU_ALIGNED(16) HexagonHVXContext;
>> +
>>   typedef struct CPUArchState {
>>       target_ulong gpr[TOTAL_PER_THREAD_REGS];
>>       target_ulong pred[NUM_PREGS];
>> @@ -159,11 +166,15 @@ typedef struct CPUArchState {
>>       target_ulong llsc_val;
>>       uint64_t     llsc_val_i64;
>>   -    MMVector VRegs[NUM_VREGS] QEMU_ALIGNED(16);
>> +#ifdef CONFIG_USER_ONLY
>> +    HexagonHVXContext hvx_ctx;
>> +#else
>> +    HexagonHVXContext *hvx;
>> +#endif
>> +
>>       MMVector future_VRegs[VECTOR_TEMPS_MAX] QEMU_ALIGNED(16);
>>       MMVector tmp_VRegs[VECTOR_TEMPS_MAX] QEMU_ALIGNED(16);
>>   -    MMQReg QRegs[NUM_QREGS] QEMU_ALIGNED(16);
>>       MMQReg future_QRegs[NUM_QREGS] QEMU_ALIGNED(16);
>>         /* Temporaries used within instructions */
>> @@ -196,6 +207,7 @@ struct ArchCPU {
>>       CPUHexagonState env;
>>       HexagonCPUConfig cfg;
>>   #ifndef CONFIG_USER_ONLY
>> +    HexagonHVXContextState *hvx_ctx[HVX_CONTEXTS_MAX];
>>       HexagonTLBState *tlb;
>>       uint32_t boot_addr;
>>       HexagonGlobalRegState *globalregs;
>> @@ -204,6 +216,15 @@ struct ArchCPU {
>>   #endif
>>   };
>>   +static inline HexagonHVXContext *hex_hvx(CPUHexagonState *env)
>> +{
>> +#ifdef CONFIG_USER_ONLY
>> +    return &env->hvx_ctx;
>> +#else
>> +    return env->hvx;
>> +#endif
>> +}
>

