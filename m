Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511CBF5A8A9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 18:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEsx4-000221-UW; Mon, 20 Apr 2026 14:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEswq-0001v7-Io
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 14:02:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEswm-0003QR-Ej
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 14:02:14 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KFnYMH785492
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 18:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eJGTU7QWGviETvLmaN6K6iVtOWAFfkeyz28iufx3gLo=; b=agsCk0DCo1vn1Yxp
 r4nGjIGvNLzT69AUMrvYYCOE+8lTiHHYtbgSLWf3q4fa5nXOzR6vz/gXWwVwQurK
 o7BYsqWC6zNWBr/cyUkgnRbr77gp/3Y8QqApsBe3cq0s4TSsNrAgy32po60WNMRz
 ekbRlv+iLlknzp6f1B0FV6PYr+FBNHTtMz+H6/hG8z0prhnf0pWpCxK55IBYkPo0
 XHsOLrIPAweCxYzXSKaITQNDmpB4ItHgv1nJpxZsX+mn4DWKmgAPVdUYNji5ENal
 IIlRDoq1YVhWUlIKmwL6xAY0gTIlwHFUILKMRV92zcSjd+9OTytVfTX+sNYNlIzO
 0lmUZg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnhdhhwhk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 18:02:09 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c20d5d7f4so7917008c88.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 11:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776708129; x=1777312929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eJGTU7QWGviETvLmaN6K6iVtOWAFfkeyz28iufx3gLo=;
 b=NhM+eYE24II7BUl59NHhRPrMjNMYcSFjSgiPG85yin+aJJnctzlkjixA5lqM4psqAh
 D2ZPKWRBWGraIx2LkU2DdCyeqN/7NqUEtp8o2PisWUWRtnKat46Vh7Ko3OBmC5Jw2G72
 1yynrJmIbp4ZJeXDu6d6ythqkDWl4GeE9VFqvKwWNJ5IdDZMapITr1BLZQzeCUfLHLbh
 JfEMeTUFb1R7xzI4Gcz7jOL4F36YQsogXMKT8YHsNwG+T8grFEO+83yF5cJNXyVoPp/7
 AOZy6pJy4SFHWnuJoeCyfS5zgOQ2K9spkw/5Z8BaheOdwOQiRpZ1QA0nu5SsNpKpyvQG
 TX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776708129; x=1777312929;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eJGTU7QWGviETvLmaN6K6iVtOWAFfkeyz28iufx3gLo=;
 b=aCSXGvvopX3W9C/Jcl+fvTLywXVTiUQBtvPh9/x6nJYQqLx591iZ9vTCbKYKKcUKbx
 hpLMK/xXUiEfVAlSEF88kxaBNoCsU74j3gSdXETJW9SeRtJjMtYuSVK7qd9Q+M0O8XZh
 qGBdT9IA2GuxERA6P60iWakvPntllPYPO/zWfsd7tYa4VnviuhbdWXMbNQ8A55ERlgnF
 mCRXa9/rZrKsj8o2qScLrSFcW1qySSi40SHQRC4s5X/KEJCbpgZ9wpcKDoGZi2CZG1fX
 ofvVIBl2N8UZWnGccZt3q3hbBNZGoYG9U16EhEEj+3lNZlozzCBCtrj5I2/GpfHByzCE
 rFeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zbviQE3hWXm51KQz33wmbCXWFR5mdRcYyvyRperYTSFJYjcQCaCElW7KFbil3UyXaEz2G+AXqT5Vg@nongnu.org
X-Gm-Message-State: AOJu0YzVh/bdAKNILCt5eDS4Uh6OGoNWl1aoxhnKotcA5PPnpMUXyrd8
 oHDrXQgBv+15K9RG83Q2Houi+nHDq2Hku3kX+2akFYMInEynMjgW2n+uyKUW7tGa2diS3b5oEHT
 TGp4E/zj2mrkAtxcAACv0cfutmkf0Eg83NbSfUWA8gy8GddNG9MaLRXUYkg==
X-Gm-Gg: AeBDieskiElL6FsrQPilXagszetvR4HiyW5ccOdpRr0um8z3UzjJQIxcnnJLx/71ou4
 Ul34a+siZrNslZ16MtDM/DtwjnQ+2p7+yk5KXMwoyC0HsB1hiD0mXXe2Q3ME6OBxa8qskhJOYrQ
 Fw2DdFlM81GXiUorfQ5CsRgIPPx4PnifoMS3mO0Uay5vEczWWZy/bvARH/PxJ+I5vJG8PtBYeE1
 ygzLYyJndiirurSCKGQYMqu9wt4kQLCI6mPA/w4JZBroSYtoVWaWrr+B5D9SfjyR02lE1wYVVn6
 jIg8JLzEBCX8AF3OXab1YxZ1zt9ruc/m+VJHkhXftLAxKfaGYR01/2rHx+5NNkDwBcfFnXQP1Yt
 /y01Q0ojb3SAa0DdM3J69uVCXtG/N+t+ilFDYNGXiOfZxRXbHTzhGu8wmgYX/ds/YyB22PmQ6d6
 LVYzF5x60meF7GUD/OdfJn3bwo
X-Received: by 2002:a05:701b:2706:b0:12c:873f:eb97 with SMTP id
 a92af1059eb24-12c873fee1amr2327389c88.3.1776708128609; 
 Mon, 20 Apr 2026 11:02:08 -0700 (PDT)
X-Received: by 2002:a05:701b:2706:b0:12c:873f:eb97 with SMTP id
 a92af1059eb24-12c873fee1amr2327297c88.3.1776708127674; 
 Mon, 20 Apr 2026 11:02:07 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c74a20eb5sm19461248c88.14.2026.04.20.11.02.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 11:02:07 -0700 (PDT)
Message-ID: <8bfc8ac3-9b5a-4b30-bf86-b1028124b797@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 11:02:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/28] target/hexagon: Implement software interrupt
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>,
 Mike Lambert <mlambert@quicinc.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
 <20260408041953.1899532-9-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260408041953.1899532-9-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: f7Xb3QdzRwnuhMPpbnEKfCgd5KSjNxxL
X-Authority-Analysis: v=2.4 cv=IMgyzAvG c=1 sm=1 tr=0 ts=69e66a21 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=cQpW5gH7TazSTKfvergA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: f7Xb3QdzRwnuhMPpbnEKfCgd5KSjNxxL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE3NSBTYWx0ZWRfX9cwmIlPUHxH3
 /pFLdaRFtkU0RZcZ2+ALVlkpr40YV3YRCEzb/TTSsPizeBsiAoS0wYvuxlDS2G4XtYKcGB0+Kee
 PopVeL+nGjsKzmXWwV/45CNCjbQb5Bacp6P1nHl5yd2zkMw+GYrCreKAjsr3uLTubKzdskTWNEA
 WolCv94AdG1SccDQ8bUQyUrOfyJWfBWjn8nZrp+Te3AU4szaTsRFd1hyX1BGn8IvajSpAW+Q3id
 S4/We32cCCMmEPZvQaxpi86E4U3IGU0FwIfzr+Bjxv4vB3HGPXmoAI8jhvrnjuaFSpGO062NN60
 hG+BogkM+eRz8VgaE+vq3pRYUShAaDhMiy/rLNAgvb5AXo9k1pXFOGCW2bJibyXm/hU5ghMAwhe
 xpD0zeTPF/gtcJnruu8uEfAvkElxM/5Zzh3oUIvtT+h8Tlbpz/Sl3C9qEFaEO1gtWuxe0p85mBG
 D40FmlO0ATvdcSnEXCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200175
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

On 4/7/2026 9:19 PM, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Co-authored-by: Mike Lambert <mlambert@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/hexswi.h |  17 +++
>   target/hexagon/cpu.c    |   1 +
>   target/hexagon/hexswi.c | 267 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 285 insertions(+)
>   create mode 100644 target/hexagon/hexswi.h
>   create mode 100644 target/hexagon/hexswi.c
> 
> diff --git a/target/hexagon/hexswi.h b/target/hexagon/hexswi.h
> new file mode 100644
> index 00000000000..48c1ae6e4c1
> --- /dev/null
> +++ b/target/hexagon/hexswi.h
> @@ -0,0 +1,17 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HEXSWI_H
> +#define HEXSWI_H
> +
> +
> +#include "cpu.h"
> +
> +void hexagon_cpu_do_interrupt(CPUState *cpu);
> +void register_trap_exception(CPUHexagonState *env, int type, int imm,
> +                             uint32_t PC);
> +
> +#endif /* HEXSWI_H */
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index fe7bb198d72..0670225d858 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -34,6 +34,7 @@
>   #include "sys_macros.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "qemu/main-loop.h"
> +#include "hex_interrupts.h"
>   #endif
>   
>   static void hexagon_v66_cpu_init(Object *obj) { }
> diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
> new file mode 100644
> index 00000000000..6dc3c91586e
> --- /dev/null
> +++ b/target/hexagon/hexswi.c
> @@ -0,0 +1,267 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "cpu_helper.h"
> +#include "exec/helper-proto.h"
> +#include "qemu/log.h"
> +#include "qemu/main-loop.h"
> +#include "arch.h"
> +#include "internal.h"
> +#include "macros.h"
> +#include "sys_macros.h"
> +#include "tcg/tcg-op.h"
> +#include "hex_mmu.h"
> +#include "hexswi.h"
> +#include "hw/hexagon/hexagon_globalreg.h"
> +
> +#ifdef CONFIG_USER_ONLY
> +#error "This file is only used in system emulation"
> +#endif
> +
> +static void set_addresses(CPUHexagonState *env, uint32_t pc_offset,
> +                          uint32_t exception_index)
> +
> +{
> +    HexagonCPU *cpu = env_archcpu(env);
> +    uint32_t evb = cpu->globalregs ?
> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_EVB,
> +                               env->threadId) :
> +        cpu->boot_addr;
> +    env->t_sreg[HEX_SREG_ELR] = env->gpr[HEX_REG_PC] + pc_offset;
> +    env->gpr[HEX_REG_PC] = evb | (exception_index << 2);
> +}
> +
> +static const char *event_name[] = {
> +    [HEX_EVENT_RESET] = "HEX_EVENT_RESET",
> +    [HEX_EVENT_IMPRECISE] = "HEX_EVENT_IMPRECISE",
> +    [HEX_EVENT_PRECISE] = "HEX_EVENT_PRECISE",
> +    [HEX_EVENT_TLB_MISS_X] = "HEX_EVENT_TLB_MISS_X",
> +    [HEX_EVENT_TLB_MISS_RW] = "HEX_EVENT_TLB_MISS_RW",
> +    [HEX_EVENT_TRAP0] = "HEX_EVENT_TRAP0",
> +    [HEX_EVENT_TRAP1] = "HEX_EVENT_TRAP1",
> +    [HEX_EVENT_FPTRAP] = "HEX_EVENT_FPTRAP",
> +    [HEX_EVENT_DEBUG] = "HEX_EVENT_DEBUG",
> +    [HEX_EVENT_INT0] = "HEX_EVENT_INT0",
> +    [HEX_EVENT_INT1] = "HEX_EVENT_INT1",
> +    [HEX_EVENT_INT2] = "HEX_EVENT_INT2",
> +    [HEX_EVENT_INT3] = "HEX_EVENT_INT3",
> +    [HEX_EVENT_INT4] = "HEX_EVENT_INT4",
> +    [HEX_EVENT_INT5] = "HEX_EVENT_INT5",
> +    [HEX_EVENT_INT6] = "HEX_EVENT_INT6",
> +    [HEX_EVENT_INT7] = "HEX_EVENT_INT7",
> +    [HEX_EVENT_INT8] = "HEX_EVENT_INT8",
> +    [HEX_EVENT_INT9] = "HEX_EVENT_INT9",
> +    [HEX_EVENT_INTA] = "HEX_EVENT_INTA",
> +    [HEX_EVENT_INTB] = "HEX_EVENT_INTB",
> +    [HEX_EVENT_INTC] = "HEX_EVENT_INTC",
> +    [HEX_EVENT_INTD] = "HEX_EVENT_INTD",
> +    [HEX_EVENT_INTE] = "HEX_EVENT_INTE",
> +    [HEX_EVENT_INTF] = "HEX_EVENT_INTF"
> +};
> +
> +void hexagon_cpu_do_interrupt(CPUState *cs)
> +
> +{
> +    CPUHexagonState *env = cpu_env(cs);
> +    uint32_t ssr;
> +
> +    BQL_LOCK_GUARD();
> +
> +    qemu_log_mask(CPU_LOG_INT,
> +                  "\t%s: event 0x%02x:%s, cause 0x%" PRIx32 "(%" PRIu32 ")\n",
> +                  __func__, (unsigned)cs->exception_index,
> +                  event_name[cs->exception_index], env->cause_code,
> +                  env->cause_code);
> +
> +    env->llsc_addr = ~0;
> +
> +    ssr = env->t_sreg[HEX_SREG_SSR];
> +    if (GET_SSR_FIELD(SSR_EX, ssr) == 1) {
> +        HexagonCPU *cpu = env_archcpu(env);
> +        if (cpu->globalregs) {
> +            hexagon_globalreg_write(cpu->globalregs, HEX_SREG_DIAG,
> +                                    env->cause_code, env->threadId);
> +        }
> +        env->cause_code = HEX_CAUSE_DOUBLE_EXCEPT;
> +        cs->exception_index = HEX_EVENT_PRECISE;
> +    }
> +
> +    switch (cs->exception_index) {
> +    case HEX_EVENT_TRAP0:
> +        if (env->cause_code == 0) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "trap0 is unhandled, no semihosting available\n");
> +        }
> +
> +        hexagon_ssr_set_cause(env, env->cause_code);
> +        set_addresses(env, 4, cs->exception_index);
> +        break;
> +
> +    case HEX_EVENT_TRAP1:
> +        hexagon_ssr_set_cause(env, env->cause_code);
> +        set_addresses(env, 4, cs->exception_index);
> +        break;
> +
> +    case HEX_EVENT_TLB_MISS_X:
> +        switch (env->cause_code) {
> +        case HEX_CAUSE_TLBMISSX_CAUSE_NORMAL:
> +        case HEX_CAUSE_TLBMISSX_CAUSE_NEXTPAGE:
> +            qemu_log_mask(CPU_LOG_MMU,
> +                          "TLB miss EX exception (0x%02x) caught: "
> +                          "Cause code (0x%" PRIx32 ") "
> +                          "TID = 0x%" PRIx32 ", PC = 0x%" PRIx32
> +                          ", BADVA = 0x%" PRIx32 "\n",
> +                          (unsigned)cs->exception_index,
> +                          env->cause_code, env->threadId,
> +                          env->gpr[HEX_REG_PC],
> +                          env->t_sreg[HEX_SREG_BADVA]);
> +
> +            hexagon_ssr_set_cause(env, env->cause_code);
> +            set_addresses(env, 0, cs->exception_index);
> +            break;
> +
> +        default:
> +            cpu_abort(cs,
> +                      "1:Hexagon exception %d/0x%02x: "
> +                      "Unknown cause code %" PRIu32 "/0x%" PRIx32 "\n",
> +                      cs->exception_index, (unsigned)cs->exception_index,
> +                      env->cause_code,
> +                      env->cause_code);
> +            break;
> +        }
> +        break;
> +
> +    case HEX_EVENT_TLB_MISS_RW:
> +        switch (env->cause_code) {
> +        case HEX_CAUSE_TLBMISSRW_CAUSE_READ:
> +        case HEX_CAUSE_TLBMISSRW_CAUSE_WRITE:
> +            qemu_log_mask(CPU_LOG_MMU,
> +                          "TLB miss RW exception (0x%02x) caught: "
> +                          "Cause code (0x%" PRIx32 ") "
> +                          "TID = 0x%" PRIx32 ", PC = 0x%" PRIx32
> +                          ", BADVA = 0x%" PRIx32 "\n",
> +                          (unsigned)cs->exception_index,
> +                          env->cause_code, env->threadId,
> +                          env->gpr[HEX_REG_PC],
> +                          env->t_sreg[HEX_SREG_BADVA]);
> +
> +            hexagon_ssr_set_cause(env, env->cause_code);
> +            set_addresses(env, 0, cs->exception_index);
> +            /* env->sreg[HEX_SREG_BADVA] is set when the exception is raised */
> +            break;
> +
> +        default:
> +            cpu_abort(cs,
> +                      "2:Hexagon exception %d/0x%02x: "
> +                      "Unknown cause code %" PRIu32 "/0x%" PRIx32 "\n",
> +                      cs->exception_index, (unsigned)cs->exception_index,
> +                      env->cause_code,
> +                      env->cause_code);
> +            break;
> +        }
> +        break;
> +
> +    case HEX_EVENT_FPTRAP:
> +        hexagon_ssr_set_cause(env, env->cause_code);
> +        set_addresses(env, 0, cs->exception_index);
> +        break;
> +
> +    case HEX_EVENT_DEBUG:
> +        hexagon_ssr_set_cause(env, env->cause_code);
> +        set_addresses(env, 0, cs->exception_index);
> +        qemu_log_mask(LOG_UNIMP, "single-step exception is not handled\n");
> +        break;
> +
> +    case HEX_EVENT_PRECISE:
> +        switch (env->cause_code) {
> +        case HEX_CAUSE_FETCH_NO_XPAGE:
> +        case HEX_CAUSE_FETCH_NO_UPAGE:
> +        case HEX_CAUSE_PRIV_NO_READ:
> +        case HEX_CAUSE_PRIV_NO_UREAD:
> +        case HEX_CAUSE_PRIV_NO_WRITE:
> +        case HEX_CAUSE_PRIV_NO_UWRITE:
> +        case HEX_CAUSE_MISALIGNED_LOAD:
> +        case HEX_CAUSE_MISALIGNED_STORE:
> +        case HEX_CAUSE_PC_NOT_ALIGNED:
> +            qemu_log_mask(CPU_LOG_MMU,
> +                          "MMU permission exception (0x%02x) caught: "
> +                          "Cause code (0x%" PRIx32 ") "
> +                          "TID = 0x%" PRIx32 ", PC = 0x%" PRIx32
> +                          ", BADVA = 0x%" PRIx32 "\n",
> +                          (unsigned)cs->exception_index,
> +                          env->cause_code, env->threadId,
> +                          env->gpr[HEX_REG_PC],
> +                          env->t_sreg[HEX_SREG_BADVA]);
> +
> +
> +            hexagon_ssr_set_cause(env, env->cause_code);
> +            set_addresses(env, 0, cs->exception_index);
> +            /* env->sreg[HEX_SREG_BADVA] is set when the exception is raised */
> +            break;
> +
> +        case HEX_CAUSE_DOUBLE_EXCEPT:
> +        case HEX_CAUSE_PRIV_USER_NO_SINSN:
> +        case HEX_CAUSE_PRIV_USER_NO_GINSN:
> +        case HEX_CAUSE_INVALID_OPCODE:
> +        case HEX_CAUSE_NO_COPROC_ENABLE:
> +        case HEX_CAUSE_NO_COPROC2_ENABLE:
> +        case HEX_CAUSE_UNSUPPORTED_HVX_64B:
> +        case HEX_CAUSE_REG_WRITE_CONFLICT:
> +        case HEX_CAUSE_VWCTRL_WINDOW_MISS:
> +            hexagon_ssr_set_cause(env, env->cause_code);
> +            set_addresses(env, 0, cs->exception_index);
> +            break;
> +
> +        case HEX_CAUSE_COPROC_LDST:
> +            hexagon_ssr_set_cause(env, env->cause_code);
> +            set_addresses(env, 0, cs->exception_index);
> +            break;
> +
> +        case HEX_CAUSE_STACK_LIMIT:
> +            hexagon_ssr_set_cause(env, env->cause_code);
> +            set_addresses(env, 0, cs->exception_index);
> +            break;
> +

Any reason the 3 cases above are not merged together?

> +        default:
> +            cpu_abort(cs,
> +                      "3:Hexagon exception %d/0x%02x: "
> +                      "Unknown cause code %" PRIu32 "/0x%" PRIx32 "\n",
> +                      cs->exception_index, (unsigned)cs->exception_index,
> +                      env->cause_code,
> +                      env->cause_code);
> +            break;
> +        }
> +        break;
> +
> +    case HEX_EVENT_IMPRECISE:
> +        qemu_log_mask(LOG_UNIMP,
> +                "Imprecise exception: this case is not yet handled");
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                "Hexagon Unsupported exception 0x%02x/0x%" PRIx32 "\n",
> +                (unsigned)cs->exception_index, env->cause_code);
> +        break;
> +    }
> +
> +    cs->exception_index = HEX_EVENT_NONE;
> +}
> +
> +void register_trap_exception(CPUHexagonState *env, int traptype, int imm,
> +                             uint32_t PC)
> +{
> +    CPUState *cs = env_cpu(env);
> +
> +    cs->exception_index = (traptype == 0) ? HEX_EVENT_TRAP0 : HEX_EVENT_TRAP1;
> +    ASSERT_DIRECT_TO_GUEST_UNSET(env, cs->exception_index);
> +
> +    env->cause_code = imm;
> +    env->gpr[HEX_REG_PC] = PC;
> +    cpu_loop_exit(cs);
> +}

For the rest, it seems to do what is expected.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


