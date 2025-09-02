Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C546BCA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI7q-0005fA-73; Mon, 01 Sep 2025 23:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI7U-0005P4-1g
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:55:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI7O-0005lO-7K
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:55:43 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S0JA030892
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qa9WhB7c5rkvhXemElNwqNs6wpSb+xyBEZO2jQCuEAI=; b=lNZWYRqTAVNghFB+
 MArDbFgDc9HrWV8rKG8Hf8kSinsMdeIJyRNMS/UlXeJLdOrzLiaXU1v994pgIdDN
 CrqvcU6kQLLTEN383+EanPdOUtVDmPtsZtQPW4kSjsuB6O1JrNGIQdNak5aq6YCz
 jslnFHSIkRN7qhbX4P/JT2b+uVdOZYpPtEm21pbIu1Z9LrNJ4tEPgZ6gA1KJq1Pa
 vPHSIgQYsvmMFclMNumfQrzlewmTD8pAIszSoBySBf7c/BWJFPD8QwOODKqE86ZA
 b9ho9Q9y9Sg5m/KtalzEYbjrbHcAFcLsp8ZA3ppJH80Q2Cs+lzl4uZ1DCIwvV/dW
 ZcRTVQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush2xb42-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:55:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-24458274406so95092065ad.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785332; x=1757390132;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qa9WhB7c5rkvhXemElNwqNs6wpSb+xyBEZO2jQCuEAI=;
 b=nuIDUVwek7Gsoq+cxmHYReGxiFRL7ifW/DSvGi8KUxkSWwVTFuXkXTJV8PfbJoP0Z+
 xXlDogf1hUhD2a1EtDFEQPep5+lEJnMoek0LIYWRKY0ZOcz/NjDreOKbfrlmRG39fYLG
 Wz71IuGS3VsTylODR2/DVCXJBLHnq2MauCGTIjugfKJRzY+VYXjVNH9MMU020hhTKgaC
 0iFaTGRMpjObenKfEfshA/kXvWa3DS7/lWS3GF5fm4StUNiMCt8pwqF9aTV9dZUk4l6Y
 2FE6Sv4tUgYcp5uaGvZYSAqxjTYBasyzBhW6n8Q6f89JStQgUvj0tEf27W7Cd9p1pV4B
 xKcQ==
X-Gm-Message-State: AOJu0YwiyrP50mWmRMwe7Q1dEA33iuRQKaUEWKKILVUkTVA6ggtHoiQY
 h5zwbaJwGh8aMJc1VCOXfJF/vXmYNOiUpXOH9sfK0DtzubQGr7sfdAvAzSWeBIANfjL3dScolbM
 UKyrx5j6Zo2VNh+Db4ehR+6Tl4W+FjeyuOAMfqAjaBdm2SeeCaQmq9zX6WGufH/yk6KMN
X-Gm-Gg: ASbGncsBCyjAu56JtfcWgCYo8WXGH8HihL8PjvTP/xO5a6Gu7GY++hoz23xr/zIfOUg
 Qw4Ny4McUpcc+V70yrr0CcX2EAhnWeq3pj0O9fzHFjxDGb0+9+8PEk04p0BnD8+KDUtpRYRZkMy
 6+hNDlwTngA6PF2q4IiQKqnPx6L3orwyoXisfz+V3OfK92lWDXQakjH5LXOk1GC0nhR7T/TihPh
 ZEva7aljs+9770w5+/dD8lK7f08osVeAqHm8ulMc3JPJ0aW6t/XYGHMckL6yuwt7doehlLWguKA
 HANuNGfoTrHlQROJmeSlP2e8YZLnCB+5BRRxWLIJW/pRfquRzTlkCxnf6iHBMQ==
X-Received: by 2002:a17:903:2c06:b0:246:cfc5:1b61 with SMTP id
 d9443c01a7336-24944b15b97mr128774355ad.55.1756785331384; 
 Mon, 01 Sep 2025 20:55:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDTmpqes6S/g4PC6fQdkGspXOcRjZF9kgjt9UwCqTxTAa1MaeqQWgzvz9k/zkQ0pdOeDCtMw==
X-Received: by 2002:a17:903:2c06:b0:246:cfc5:1b61 with SMTP id
 d9443c01a7336-24944b15b97mr128773955ad.55.1756785330897; 
 Mon, 01 Sep 2025 20:55:30 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24905da25dbsm119720745ad.68.2025.09.01.20.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 20:55:30 -0700 (PDT)
Message-ID: <f4d42c89-92e8-4267-a6df-1bd6e4ee06f5@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 20:15:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/38] target/hexagon: Add gdb support for sys regs
To: qemu-devel@nongnu.org, Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 ltaylorsimpson@gmail.com, alex.bennee@linaro.org,
 quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-34-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-34-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX4Uckw5+pvMgF
 Byox5F7gwFUDSkuLc2V6L2O5QrDp8TkWL5SyqTW31MS4wZeNcd2wA8ONFrB81HUKP8dRVRC6Wbn
 U8Ju7sZ8P+f9Cc63kR7lbH2jmmzmfT9+zjCB0O97qspcmuGHGENNS1qktGnJ5e50ceKLG4+T2dg
 X4ztaB14Rfy0cCFc8hG+U9YAA1BlZKW6OZcVvjkRwqpb0wD3ju3B4DJxE1SJG4SuRxYcbJ69lYc
 XWS1zPXkRaQLLzS6YVs+GeCF8gQBtR9Yc1q5iGg95PPXJN939dWexJkiSE3Eggk80vnWnAmomwK
 QaSqoCYgoglAsEcn1phhRfWhkBKpMbwEf4Z6oAT6QayNPOe6LZDteKtfcff9orBhsVOQpLkGj19
 klWFV7vc
X-Proofpoint-ORIG-GUID: SlmEQc1eVDVBOO-66rlm_yULdTvB6Gsw
X-Proofpoint-GUID: SlmEQc1eVDVBOO-66rlm_yULdTvB6Gsw
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b66ab4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=Z_v64f_Pw6W4mcmaEYoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
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


On 2/28/2025 11:26 PM, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
>
> Co-authored-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.h       |   6 ++
>   target/hexagon/internal.h  |   4 ++
>   target/hexagon/cpu.c       |  17 ++++++
>   target/hexagon/gdbstub.c   |  45 ++++++++++++++
>   target/hexagon/op_helper.c |  16 +++++
>   gdb-xml/hexagon-sys.xml    | 116 +++++++++++++++++++++++++++++++++++++
>   6 files changed, 204 insertions(+)
>   create mode 100644 gdb-xml/hexagon-sys.xml
>
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index ddc1158d8e..b0ccaf36f9 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -183,6 +183,12 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
>                                               uint32_t exception,
>                                               uintptr_t pc);
>   
> +#ifndef CONFIG_USER_ONLY
> +uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg);
> +uint32_t hexagon_sreg_read(CPUHexagonState *env, uint32_t reg);
> +void hexagon_gdb_sreg_write(CPUHexagonState *env, uint32_t reg, uint32_t val);
> +#endif
> +
>   static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
>                                           uint64_t *cs_base, uint32_t *flags)
>   {
> diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
> index 7cf7bcaa6c..c24c360921 100644
> --- a/target/hexagon/internal.h
> +++ b/target/hexagon/internal.h
> @@ -22,6 +22,10 @@
>   
>   int hexagon_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>   int hexagon_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> +#ifndef CONFIG_USER_ONLY
> +int hexagon_sys_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n);
> +int hexagon_sys_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n);
> +#endif
>   int hexagon_hvx_gdb_read_register(CPUState *env, GByteArray *mem_buf, int n);
>   int hexagon_hvx_gdb_write_register(CPUState *env, uint8_t *mem_buf, int n);
>   
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 7c34d015a3..34c39cecd9 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -29,6 +29,10 @@
>   #include "cpu_helper.h"
>   #include "max.h"
>   
> +#ifndef CONFIG_USER_ONLY
> +#include "sys_macros.h"
> +#endif
> +
>   static void hexagon_v66_cpu_init(Object *obj) { }
>   static void hexagon_v67_cpu_init(Object *obj) { }
>   static void hexagon_v68_cpu_init(Object *obj) { }
> @@ -341,6 +345,12 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
>                                hexagon_hvx_gdb_write_register,
>                                gdb_find_static_feature("hexagon-hvx.xml"), 0);
>   
> +#ifndef CONFIG_USER_ONLY
> +    gdb_register_coprocessor(cs, hexagon_sys_gdb_read_register,
> +                             hexagon_sys_gdb_write_register,
> +                             gdb_find_static_feature("hexagon-sys.xml"), 0);
> +#endif
> +
>       qemu_init_vcpu(cs);
>       cpu_reset(cs);
>   #ifndef CONFIG_USER_ONLY
> @@ -400,6 +410,13 @@ static void hexagon_cpu_class_init(ObjectClass *c, void *data)
>       cc->tcg_ops = &hexagon_tcg_ops;
>   }
>   
> +#ifndef CONFIG_USER_ONLY
> +uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg)
> +{
> +    g_assert_not_reached();
> +}
> +#endif
> +
>   #define DEFINE_CPU(type_name, initfn)      \
>       {                                      \
>           .name = type_name,                 \
> diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
> index 12d6b3bbcb..8476199b75 100644
> --- a/target/hexagon/gdbstub.c
> +++ b/target/hexagon/gdbstub.c
> @@ -76,6 +76,51 @@ int hexagon_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>       g_assert_not_reached();
>   }
>   
> +#ifndef CONFIG_USER_ONLY
> +int hexagon_sys_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
> +{
> +    CPUHexagonState *env = cpu_env(cs);
> +
> +    if (n < NUM_SREGS) {
> +        return gdb_get_regl(mem_buf, hexagon_sreg_read(env, n));
> +    }
> +    n -= NUM_SREGS;
> +
> +    if (n < NUM_GREGS) {
> +        return gdb_get_regl(mem_buf, hexagon_greg_read(env, n));


My mailer seems to have eaten his message but I can see on the list 
archive that Taylor asked "Are all of these writable directly without 
any checks?"

Good question.  We have mutability masks that prevent the transfer 
instructions from overwriting bits they shouldn't be able to.  If we're 
using that same interface for the gdbstub, it would probably make 
sense.  I'll check that and if it's not right I'll address it for v3.

> +    }
> +    n -= NUM_GREGS;
> +
> +    n -= TOTAL_PER_THREAD_REGS;
> +
> +    if (n < NUM_PREGS) {
> +        env->pred[n] = ldtul_p(mem_buf) & 0xff;
> +        return sizeof(uint8_t);
> +    }
> +
> +    n -= NUM_PREGS;
> +
> +    g_assert_not_reached();
> +}
> +
> +int hexagon_sys_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    CPUHexagonState *env = cpu_env(cs);
> +
> +    if (n < NUM_SREGS) {
> +        hexagon_gdb_sreg_write(env, n, ldtul_p(mem_buf));
> +        return sizeof(target_ulong);
> +    }
> +    n -= NUM_SREGS;
> +
> +    if (n < NUM_GREGS) {
> +        return env->greg[n] = ldtul_p(mem_buf);
> +    }
> +    n -= NUM_GREGS;
> +
> +    g_assert_not_reached();
> +}
> +#endif
>   static int gdb_get_vreg(CPUHexagonState *env, GByteArray *mem_buf, int n)
>   {
>       int total = 0;
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 76b2475d88..fd9caafefc 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1465,6 +1465,17 @@ void HELPER(sreg_write)(CPUHexagonState *env, uint32_t reg, uint32_t val)
>       sreg_write(env, reg, val);
>   }
>   
> +void hexagon_gdb_sreg_write(CPUHexagonState *env, uint32_t reg, uint32_t val)
> +{
> +    BQL_LOCK_GUARD();
> +    sreg_write(env, reg, val);
> +    /*
> +     * The above is needed to run special logic for regs like syscfg, but it
> +     * won't set read-only bits. This will:
> +     */
> +    arch_set_system_reg(env, reg, val);
> +}
> +
>   void HELPER(sreg_write_pair)(CPUHexagonState *env, uint32_t reg, uint64_t val)
>   {
>       BQL_LOCK_GUARD();
> @@ -1508,6 +1519,11 @@ uint32_t HELPER(sreg_read)(CPUHexagonState *env, uint32_t reg)
>       return sreg_read(env, reg);
>   }
>   
> +uint32_t hexagon_sreg_read(CPUHexagonState *env, uint32_t reg)
> +{
> +    return sreg_read(env, reg);
> +}
> +
>   uint64_t HELPER(sreg_read_pair)(CPUHexagonState *env, uint32_t reg)
>   {
>       BQL_LOCK_GUARD();
> diff --git a/gdb-xml/hexagon-sys.xml b/gdb-xml/hexagon-sys.xml
> new file mode 100644
> index 0000000000..1d9c211722
> --- /dev/null
> +++ b/gdb-xml/hexagon-sys.xml
> @@ -0,0 +1,116 @@
> +<?xml version="1.0"?>
> +<!--
> +  Copyright(c) 2023-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
> +
> +  This work is licensed under the terms of the GNU GPL, version 2 or
> +  (at your option) any later version. See the COPYING file in the
> +  top-level directory.
> +
> +  Note: this file is intended to be use with LLDB, so it contains fields
> +  that may be unknown to GDB. For more information on such fields, please
> +  see:
> +  https://github.com/llvm/llvm-project/blob/287aa6c4536408413b860e61fca0318a27214cf3/lldb/docs/lldb-gdb-remote.txt#L738-L860
> +  https://github.com/llvm/llvm-project/blob/287aa6c4536408413b860e61fca0318a27214cf3/lldb/source/Plugins/Process/gdb-remote/ProcessGDBRemote.cpp#L4275-L4335
> +-->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name="org.gnu.gdb.hexagon.sys">
> +
> +  <reg name="sgp0"       bitsize="32" offset="4416" encoding="uint" format="hex" group="System Registers" dwarf_regnum="135" />
> +  <reg name="sgp1"       bitsize="32" offset="4420" encoding="uint" format="hex" group="System Registers" dwarf_regnum="136" />
> +  <reg name="stid"       bitsize="32" offset="4424" encoding="uint" format="hex" group="System Registers" dwarf_regnum="137" />
> +  <reg name="elr"        bitsize="32" offset="4428" encoding="uint" format="hex" group="System Registers" dwarf_regnum="138" />
> +  <reg name="badva0"     bitsize="32" offset="4432" encoding="uint" format="hex" group="System Registers" dwarf_regnum="139" />
> +  <reg name="badva1"     bitsize="32" offset="4436" encoding="uint" format="hex" group="System Registers" dwarf_regnum="140" />
> +  <reg name="ssr"        bitsize="32" offset="4440" encoding="uint" format="hex" group="System Registers" dwarf_regnum="141" />
> +  <reg name="ccr"        bitsize="32" offset="4444" encoding="uint" format="hex" group="System Registers" dwarf_regnum="142" />
> +  <reg name="htid"       bitsize="32" offset="4448" encoding="uint" format="hex" group="System Registers" dwarf_regnum="143" />
> +  <reg name="badva"      bitsize="32" offset="4452" encoding="uint" format="hex" group="System Registers" dwarf_regnum="144" />
> +  <reg name="imask"      bitsize="32" offset="4456" encoding="uint" format="hex" group="System Registers" dwarf_regnum="145" />
> +  <reg name="gevb"       bitsize="32" offset="4460" encoding="uint" format="hex" group="System Registers" dwarf_regnum="146" />
> +  <reg name="rsv12"      bitsize="32" offset="4464" encoding="uint" format="hex" group="System Registers" dwarf_regnum="147" />
> +  <reg name="rsv13"      bitsize="32" offset="4468" encoding="uint" format="hex" group="System Registers" dwarf_regnum="148" />
> +  <reg name="rsv14"      bitsize="32" offset="4472" encoding="uint" format="hex" group="System Registers" dwarf_regnum="149" />
> +  <reg name="rsv15"      bitsize="32" offset="4476" encoding="uint" format="hex" group="System Registers" dwarf_regnum="150" />
> +  <reg name="evb"        bitsize="32" offset="4480" encoding="uint" format="hex" group="System Registers" dwarf_regnum="151" />
> +  <reg name="modectl"    bitsize="32" offset="4484" encoding="uint" format="hex" group="System Registers" dwarf_regnum="152" />
> +  <reg name="syscfg"     bitsize="32" offset="4488" encoding="uint" format="hex" group="System Registers" dwarf_regnum="153" />
> +  <reg name="free19"     bitsize="32" offset="4492" encoding="uint" format="hex" group="System Registers" dwarf_regnum="154" />
> +  <reg name="ipendad"    bitsize="32" offset="4496" encoding="uint" format="hex" group="System Registers" dwarf_regnum="155" />
> +  <reg name="vid"        bitsize="32" offset="4500" encoding="uint" format="hex" group="System Registers" dwarf_regnum="156" />
> +  <reg name="vid1"       bitsize="32" offset="4504" encoding="uint" format="hex" group="System Registers" dwarf_regnum="157" />
> +  <reg name="bestwait"   bitsize="32" offset="4508" encoding="uint" format="hex" group="System Registers" dwarf_regnum="158" />
> +  <reg name="free24"     bitsize="32" offset="4512" encoding="uint" format="hex" group="System Registers" dwarf_regnum="159" />
> +  <reg name="schedcfg"   bitsize="32" offset="4516" encoding="uint" format="hex" group="System Registers" dwarf_regnum="160" />
> +  <reg name="free26"     bitsize="32" offset="4520" encoding="uint" format="hex" group="System Registers" dwarf_regnum="161" />
> +  <reg name="cfgbase"    bitsize="32" offset="4524" encoding="uint" format="hex" group="System Registers" dwarf_regnum="162" />
> +  <reg name="diag"       bitsize="32" offset="4528" encoding="uint" format="hex" group="System Registers" dwarf_regnum="163" />
> +  <reg name="rev"        bitsize="32" offset="4532" encoding="uint" format="hex" group="System Registers" dwarf_regnum="164" />
> +  <reg name="pcyclelo"   bitsize="32" offset="4536" encoding="uint" format="hex" group="System Registers" dwarf_regnum="165" />
> +  <reg name="pcyclehi"   bitsize="32" offset="4540" encoding="uint" format="hex" group="System Registers" dwarf_regnum="166" />
> +  <reg name="isdbst"     bitsize="32" offset="4544" encoding="uint" format="hex" group="System Registers" dwarf_regnum="167" />
> +  <reg name="isdbcfg0"   bitsize="32" offset="4548" encoding="uint" format="hex" group="System Registers" dwarf_regnum="168" />
> +  <reg name="isdbcfg1"   bitsize="32" offset="4552" encoding="uint" format="hex" group="System Registers" dwarf_regnum="169" />
> +  <reg name="livelock"   bitsize="32" offset="4556" encoding="uint" format="hex" group="System Registers" dwarf_regnum="170" />
> +  <reg name="brkptpc0"   bitsize="32" offset="4560" encoding="uint" format="hex" group="System Registers" dwarf_regnum="171" />
> +  <reg name="brkptccfg0" bitsize="32" offset="4564" encoding="uint" format="hex" group="System Registers" dwarf_regnum="172" />
> +  <reg name="brkptpc1"   bitsize="32" offset="4568" encoding="uint" format="hex" group="System Registers" dwarf_regnum="173" />
> +  <reg name="brkptcfg1"  bitsize="32" offset="4572" encoding="uint" format="hex" group="System Registers" dwarf_regnum="174" />
> +  <reg name="isdbmbxin"  bitsize="32" offset="4576" encoding="uint" format="hex" group="System Registers" dwarf_regnum="175" />
> +  <reg name="isdbmbxout" bitsize="32" offset="4580" encoding="uint" format="hex" group="System Registers" dwarf_regnum="176" />
> +  <reg name="isdben"     bitsize="32" offset="4584" encoding="uint" format="hex" group="System Registers" dwarf_regnum="177" />
> +  <reg name="isdbgpr"    bitsize="32" offset="4588" encoding="uint" format="hex" group="System Registers" dwarf_regnum="178" />
> +  <reg name="pmucnt4"    bitsize="32" offset="4592" encoding="uint" format="hex" group="System Registers" dwarf_regnum="179" />
> +  <reg name="pmucnt5"    bitsize="32" offset="4596" encoding="uint" format="hex" group="System Registers" dwarf_regnum="180" />
> +  <reg name="pmucnt6"    bitsize="32" offset="4600" encoding="uint" format="hex" group="System Registers" dwarf_regnum="181" />
> +  <reg name="pmucnt7"    bitsize="32" offset="4604" encoding="uint" format="hex" group="System Registers" dwarf_regnum="182" />
> +  <reg name="pmucnt0"    bitsize="32" offset="4608" encoding="uint" format="hex" group="System Registers" dwarf_regnum="183" />
> +  <reg name="pmucnt1"    bitsize="32" offset="4612" encoding="uint" format="hex" group="System Registers" dwarf_regnum="184" />
> +  <reg name="pmucnt2"    bitsize="32" offset="4616" encoding="uint" format="hex" group="System Registers" dwarf_regnum="185" />
> +  <reg name="pmucnt3"    bitsize="32" offset="4620" encoding="uint" format="hex" group="System Registers" dwarf_regnum="186" />
> +  <reg name="pmuevtcfg"  bitsize="32" offset="4624" encoding="uint" format="hex" group="System Registers" dwarf_regnum="187" />
> +  <reg name="pmustid0"   bitsize="32" offset="4628" encoding="uint" format="hex" group="System Registers" dwarf_regnum="188" />
> +  <reg name="pmuevtcfg1" bitsize="32" offset="4632" encoding="uint" format="hex" group="System Registers" dwarf_regnum="189" />
> +  <reg name="pmustid1"   bitsize="32" offset="4636" encoding="uint" format="hex" group="System Registers" dwarf_regnum="190" />
> +  <reg name="timerlo"    bitsize="32" offset="4640" encoding="uint" format="hex" group="System Registers" dwarf_regnum="191" />
> +  <reg name="timerhi"    bitsize="32" offset="4644" encoding="uint" format="hex" group="System Registers" dwarf_regnum="192" />
> +  <reg name="pmucfg"     bitsize="32" offset="4648" encoding="uint" format="hex" group="System Registers" dwarf_regnum="193" />
> +  <reg name="rsv59"      bitsize="32" offset="4652" encoding="uint" format="hex" group="System Registers" dwarf_regnum="194" />
> +  <reg name="rsv60"      bitsize="32" offset="4656" encoding="uint" format="hex" group="System Registers" dwarf_regnum="195" />
> +  <reg name="rsv61"      bitsize="32" offset="4660" encoding="uint" format="hex" group="System Registers" dwarf_regnum="196" />
> +  <reg name="rsv62"      bitsize="32" offset="4664" encoding="uint" format="hex" group="System Registers" dwarf_regnum="197" />
> +  <reg name="rsv63"      bitsize="32" offset="4668" encoding="uint" format="hex" group="System Registers" dwarf_regnum="198" />
> +  <reg name="g0"         bitsize="32" offset="4672" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="179" />
> +  <reg name="g1"         bitsize="32" offset="4676" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="180" />
> +  <reg name="g2"         bitsize="32" offset="4680" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="181" />
> +  <reg name="g3"         bitsize="32" offset="4684" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="182" />
> +  <reg name="rsv4"       bitsize="32" offset="4688" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="183" />
> +  <reg name="rsv5"       bitsize="32" offset="4692" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="184" />
> +  <reg name="rsv6"       bitsize="32" offset="4696" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="185" />
> +  <reg name="rsv7"       bitsize="32" offset="4700" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="186" />
> +  <reg name="rsv8"       bitsize="32" offset="4704" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="187" />
> +  <reg name="rsv9"       bitsize="32" offset="4708" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="188" />
> +  <reg name="rsv10"      bitsize="32" offset="4712" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="189" />
> +  <reg name="rsv11"      bitsize="32" offset="4716" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="190" />
> +  <reg name="rsv12"      bitsize="32" offset="4720" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="191" />
> +  <reg name="rsv13"      bitsize="32" offset="4724" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="192" />
> +  <reg name="rsv14"      bitsize="32" offset="4728" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="193" />
> +  <reg name="rsv15"      bitsize="32" offset="4732" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="194" />
> +  <reg name="gpmucnt4"   bitsize="32" offset="4736" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="195" />
> +  <reg name="gpmucnt5"   bitsize="32" offset="4740" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="196" />
> +  <reg name="gpmucnt6"   bitsize="32" offset="4744" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="197" />
> +  <reg name="gpmucnt7"   bitsize="32" offset="4748" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="198" />
> +  <reg name="rsv20"      bitsize="32" offset="4752" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="199" />
> +  <reg name="rsv21"      bitsize="32" offset="4756" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="200" />
> +  <reg name="rsv22"      bitsize="32" offset="4760" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="201" />
> +  <reg name="rsv23"      bitsize="32" offset="4764" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="202" />
> +  <reg name="gpcyclelo"  bitsize="32" offset="4768" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="203" />
> +  <reg name="gpcyclehi"  bitsize="32" offset="4772" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="204" />
> +  <reg name="gpmucnt0"   bitsize="32" offset="4776" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="205" />
> +  <reg name="gpmucnt1"   bitsize="32" offset="4780" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="206" />
> +  <reg name="gpmucnt2"   bitsize="32" offset="4784" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="207" />
> +  <reg name="gpmucnt3"   bitsize="32" offset="4788" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="208" />
> +  <reg name="rsv30"      bitsize="32" offset="4792" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="209" />
> +  <reg name="rsv31"      bitsize="32" offset="4796" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="210" />
> +
> +</feature>

