Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62296CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrnm-0006AV-UI; Wed, 17 Jun 2026 11:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZrnk-00069S-QZ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:03:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZrnh-0004Ex-Gx
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:03:36 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HF2RrW3158542
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cdzMnZ+KKSJ/8Y2qvlDteynFannW2DlMzyDru52zFwg=; b=bus0Hc3cCqSh3sq+
 wQMka4y7JTs891hmNMJM7Hqy6XUMUwnflCBl+HEPGLaKpLRUOgmCxfxlWlCBVRD/
 0JRpBzRCxtubmyarozPCovLXb6OxA/JtJr/iJ37LO68XfDUyE7HLl/jmTbQ59+8c
 veDW8yWDMuyDfeBn+QDPZWPjfBwzPEZ93cNmB5Ts9ugrlHxmYecMKxm3qqh1pmL3
 fuZwMv31Eln7qsQZ88L7Xpz8VRCtu9rk/N0QFp55Cd2UaVPFxJT+0j47Txvv1KVg
 SKqUkrRoQ9xvSXOz5nAluXenAgR7MfZnKTEzjM4qAi+XOlYo7FKDOXV6mw4Jt01X
 DQcEfg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euef2bvct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:03:31 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1361d52b3a0so7399936c88.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 08:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781708610; x=1782313410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cdzMnZ+KKSJ/8Y2qvlDteynFannW2DlMzyDru52zFwg=;
 b=e1YlSduP9dMBNEJq9KwYvAtVtFJko+k9t1506o5P8ZBN8ApKF+oJmxAPodKEuv0Vy0
 kmDTCOUaleIDeRj1wxLv5+utKNos9hvS5TtT8yOJtvSTuTxt7H7czKRmQ5he4UuFGBlO
 qYtizVJIlaNDSkHtuWY4dixLzH8LW1I+vHYJ/eazxjI88m7RaUjC4VdsYXOwGFWGgAmq
 Tcu61xiU0pxkWS+btd65TIqnlWgR/CM1ZJTRT0+/iP8NARjrVxGrfRbhaExfkZ2HtfU2
 spKEvh2Dk6OSUbxuEQih0aMifS0eV1kidZhO0AvJrYm8PvdFV/JnvXBrsqt4O/HRmmey
 Jf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781708610; x=1782313410;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cdzMnZ+KKSJ/8Y2qvlDteynFannW2DlMzyDru52zFwg=;
 b=NMSu7uSNlH8W/O3bRLNI7v7qcOV+fX3DFaRj1T1EClg07N9j3doLpWcyd9nrB4mpk/
 uHRPi9rP7bnXn9dLnCwiPGp7iZIA050+9luB4ZduwbchkBij2JaedHT+C8/DBG7SyAja
 xeBjX4cqrOnOwV9buMMCR9t6ThQhF3xyf6rzBTLKxwM7L5lcF4wLKEFLg/1ibpl9GxQG
 zJlDp14JjQpRDfkozrkmOqqPGUFiry1HStsh9vq27/qLIgN31WVvBKN6wm/ZpE0ghKHg
 WNHqMtR/9cVBKpNcHEsGlxgzo6JwLmwUyB3V4KCdCK/vdqvhIHJlVEtEt2H1wjD7SXk8
 UAcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/l0QKnqhd6m4YbbJ04UxSTZhLyGNILiPledfGMctho4rxNWVlW4pUuFdem4C4jvVM4K0ryNyLjxk6S@nongnu.org
X-Gm-Message-State: AOJu0Yz8J8xH0FZss1YGvuV56hdG/OTfjYtawiR+ejmrqkq1wvjkLASs
 cvNQqB8E1gGl+ce+2APrK2KXLGJ6dUuFttetREAjYN/lD0ySB25AN+lnctUbVYYeyLLnDxw/Y6I
 2Z4HnB+q20z08kM8bFn/BLHCFEWXyFAcaDXZsn9Z/G4jjQpRzsNT0LYcuVw==
X-Gm-Gg: Acq92OH2W0FzA5qr0l201ao4dJ6BsM0bGH9Z6utAD5VPP9/fjUTQqtglrwhTpQicvFB
 TYvY96PmwE6lcN+U1D/Tt+UKCcjlngatcENUf9sLMj61Lm1Ttn+ourefQQoE6aH+wI+Pef+xtFz
 GebwZ1h4lKlZF2JWukHCLAKIJRDbLobcgNFKOqPxUw8IJExJigc9TOeIAE8zaod5XTfnstsQduG
 JvpL9JH5ep4Mm3QqQ/ko16vxfi520MbMqxgVGkGswD03fCD3iLLmn91HgWnzTr8N1s1hxCccCDH
 l84678lpejD9Oz5T+CemN6Dtsq07gqvzpOlFl6uI0I06OlQADx7Cd9PI6VW8QZfsw+aHz0R+Eoh
 w1axNothrPY5PVn8TyZ9ITvyojLD6pFoulUlZ6H/LxuYv+YK/wNxdfWuaqT+mP+NmEqETCsATw4
 DO3zA=
X-Received: by 2002:a05:7022:baa:b0:132:f16:a574 with SMTP id
 a92af1059eb24-1398f669256mr1495225c88.7.1781708609396; 
 Wed, 17 Jun 2026 08:03:29 -0700 (PDT)
X-Received: by 2002:a05:7022:baa:b0:132:f16:a574 with SMTP id
 a92af1059eb24-1398f669256mr1495060c88.7.1781708607953; 
 Wed, 17 Jun 2026 08:03:27 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b9110d3sm17332118c88.5.2026.06.17.08.03.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 08:03:27 -0700 (PDT)
Message-ID: <9db7fcdc-5673-4ae7-a17f-ce5937775f32@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 08:03:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] target/hexagon: Update TARGET_PAGE_BITS, stubs for
 modify_ssr/get_exe_mode
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
 <20260611052857.3911981-35-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260611052857.3911981-35-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=F8hnsKhN c=1 sm=1 tr=0 ts=6a32b743 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=0WJ_kZ_cvEWoEYAswAcA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE0NCBTYWx0ZWRfX+JAA7Gk25exn
 FSSpLjfHnvsTiB4aeU/KnWBPvXh93ErzmubTfuY2mtQEDezCWzssBYf9gRFApYZv59VIyBzZrVE
 GFWHbJmgVa+ZIeeqCzAMgRvieGSbP6I=
X-Proofpoint-GUID: fw3hFTwUlm2eIgCVuhKnWlNh4sEM21Bu
X-Proofpoint-ORIG-GUID: fw3hFTwUlm2eIgCVuhKnWlNh4sEM21Bu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE0NCBTYWx0ZWRfXyrh1WD2a8MKx
 nlkR8hs9uZs0J+6RsZPQw5HrWRc9ZdwqKwMiDQKsQzwsTkFO0hpMvynMYGDZWtR9ORcy1vNN6Ut
 o7iE5plpMyBOs+bfuQJT+lBxopsb0qj/i+IooJ4qLJPIkZOqFgRCGOsLl9HaKq94EQuSDoynCiR
 S7mgaWG7Gz3gU1/pJk4wq5boh1Xd1wzJX6oV7XMSX2G3UmffogIG3jAuEPN/cKc4eNC5NP9hVUf
 LIPSf4y7wW5llPI7WqL9IF8WEbP2Y424jsiQT4RN55jpSHGRQR1zQbw4szWS+ffNyT9p7zaBAI0
 g2rd8EPWfDPC9VfxD4G0ilVKKHybXrBdJEXaTsYvzFWla3Z+UrPWl/7xRMflJ1wUwJc25aiTjTv
 gYz4dp/10i2eOY8rJ2FzGZi8JCEAJNugK/raNfEuxBLyLQJqHUvznLC/V5ETcsN8JgDDpgd8b0B
 UzV3UU9sGuegUl7nnqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 6/10/2026 10:28 PM, Brian Cain wrote:
> Add hex_mmu.[ch], cpu mode helpers, and additional includes/stubs
> that integrate the TLB device with the CPU model.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu-param.h  |   2 +-
>  target/hexagon/cpu.h        |  21 +++
>  target/hexagon/hex_mmu.h    |  26 ++++
>  target/hexagon/internal.h   |   9 ++
>  target/hexagon/sys_macros.h |   3 +
>  target/hexagon/cpu.c        |  36 +++++
>  target/hexagon/hex_mmu.c    | 268 ++++++++++++++++++++++++++++++++++++
>  7 files changed, 364 insertions(+), 1 deletion(-)
>  create mode 100644 target/hexagon/hex_mmu.h
>  create mode 100644 target/hexagon/hex_mmu.c
> 
> diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
> index 1f0f22a7968..bfe9a868d63 100644
> --- a/target/hexagon/cpu-param.h
> +++ b/target/hexagon/cpu-param.h
> @@ -18,7 +18,7 @@
>  #ifndef HEXAGON_CPU_PARAM_H
>  #define HEXAGON_CPU_PARAM_H
>  
> -#define TARGET_PAGE_BITS 16     /* 64K pages */
> +#define TARGET_PAGE_BITS 12     /* 4K pages */
>

For information and people reviewing this series, this change has been
tested internally with our test suite, for user and system mode.

>  #define TARGET_VIRT_ADDR_SPACE_BITS 32
>  
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 7ba1d3047df..dbdc456d732 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -27,6 +27,9 @@
>  #define SREG_WRITES_MAX 2
>  #endif
>  
> +typedef struct HexagonTLBState HexagonTLBState;
> +typedef struct HexagonGlobalRegState HexagonGlobalRegState;
> +
>  #include "cpu-qom.h"
>  #include "exec/cpu-common.h"
>  #include "exec/target_long.h"
> @@ -39,6 +42,7 @@
>  #error "Hexagon does not support system emulation"
>  #endif
>  
> +
>  #define NUM_PREGS 4
>  #define TOTAL_PER_THREAD_REGS 64
>  
> @@ -47,10 +51,13 @@
>  #define REG_WRITES_MAX 32
>  #define PRED_WRITES_MAX 5                   /* 4 insns + endloop */
>  #define VSTORES_MAX 2
> +#define MAX_TLB_ENTRIES 1024
>  
>  #define CPU_RESOLVING_TYPE TYPE_HEXAGON_CPU
>  #ifndef CONFIG_USER_ONLY
>  #define CPU_INTERRUPT_SWI      CPU_INTERRUPT_TGT_INT_0
> +#define CPU_INTERRUPT_K0_UNLOCK CPU_INTERRUPT_TGT_INT_1
> +#define CPU_INTERRUPT_TLB_UNLOCK CPU_INTERRUPT_TGT_INT_2
>  
>  #define HEX_CPU_MODE_USER    1
>  #define HEX_CPU_MODE_GUEST   2
> @@ -67,6 +74,12 @@
>  #define MMU_GUEST_IDX        1
>  #define MMU_KERNEL_IDX       2
>  
> +typedef enum {
> +    HEX_LOCK_UNLOCKED       = 0,
> +    HEX_LOCK_WAITING        = 1,
> +    HEX_LOCK_OWNER          = 2,
> +    HEX_LOCK_QUEUED        = 3
> +} hex_lock_state_t;
>  #endif
>  
>  
> @@ -128,6 +141,10 @@ typedef struct CPUArchState {
>  
>      /* This alias of CPUState.cpu_index is used by imported sources: */
>      uint32_t threadId;
> +    hex_lock_state_t tlb_lock_state;
> +    hex_lock_state_t k0_lock_state;
> +    uint32_t tlb_lock_count;
> +    uint32_t k0_lock_count;
>      uint64_t t_cycle_count;
>  #endif
>      uint32_t next_PC;
> @@ -178,6 +195,10 @@ struct ArchCPU {
>      bool lldb_compat;
>      target_ulong lldb_stack_adjust;
>      bool short_circuit;
> +#ifndef CONFIG_USER_ONLY
> +    HexagonTLBState *tlb;
> +    uint32_t htid;
> +#endif
>  };
>  
>  #include "cpu_bits.h"
> diff --git a/target/hexagon/hex_mmu.h b/target/hexagon/hex_mmu.h
> new file mode 100644
> index 00000000000..4f556c715a9
> --- /dev/null
> +++ b/target/hexagon/hex_mmu.h
> @@ -0,0 +1,26 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HEXAGON_MMU_H
> +#define HEXAGON_MMU_H
> +
> +#include "cpu.h"
> +#include "monitor/monitor.h"
> +
> +extern void hex_tlbw(CPUHexagonState *env, uint32_t index, uint64_t value);
> +extern uint32_t hex_tlb_lookup(CPUHexagonState *env, uint32_t ssr, uint32_t VA);
> +extern void hex_mmu_on(CPUHexagonState *env);
> +extern void hex_mmu_off(CPUHexagonState *env);
> +extern void hex_mmu_mode_change(CPUHexagonState *env);
> +extern bool hex_tlb_find_match(CPUHexagonState *env, uint32_t VA,
> +                               MMUAccessType access_type, hwaddr *PA, int *prot,
> +                               uint64_t *size, int32_t *excp, int mmu_idx);
> +extern int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry,
> +                                 uint64_t index);
> +extern void hex_tlb_lock(CPUHexagonState *env);
> +extern void hex_tlb_unlock(CPUHexagonState *env);
> +void dump_mmu(Monitor *mon, CPUHexagonState *env);
> +#endif
> diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
> index 33d73ed18d1..4338914efb5 100644
> --- a/target/hexagon/internal.h
> +++ b/target/hexagon/internal.h
> @@ -36,6 +36,15 @@ void G_NORETURN do_raise_exception(CPUHexagonState *env,
>          uint32_t PC,
>          uintptr_t retaddr);
>  
> +#define hexagon_cpu_mmu_enabled(env) ({ \
> +    HexagonCPU *cpu = env_archcpu(env); \
> +    cpu->globalregs ? \
> +        GET_SYSCFG_FIELD(SYSCFG_MMUEN, \
> +            hexagon_globalreg_read(cpu->globalregs, \
> +                                   HEX_SREG_SYSCFG, (env)->threadId)) : \
> +        0; \
> +})
> +
>  #ifndef CONFIG_USER_ONLY
>  extern const VMStateDescription vmstate_hexagon_cpu;
>  #endif
> diff --git a/target/hexagon/sys_macros.h b/target/hexagon/sys_macros.h
> index 09d78b002e6..8b81e1ca0af 100644
> --- a/target/hexagon/sys_macros.h
> +++ b/target/hexagon/sys_macros.h
> @@ -139,6 +139,9 @@
>  #define fDCINVIDX(REG)
>  #define fDCINVA(REG) do { REG = REG; } while (0) /* Nothing to do in qemu */
>  
> +#define fSET_TLB_LOCK()       hex_tlb_lock(env);
> +#define fCLEAR_TLB_LOCK()     hex_tlb_unlock(env);
> +
>  #define fTLB_IDXMASK(INDEX) \
>      ((INDEX) & (fPOW2_ROUNDUP( \
>          fCAST4u(hexagon_tlb_get_num_entries(env_archcpu(env)->tlb))) - 1))
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 626100d43fd..73aca0a4217 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -23,9 +23,17 @@
>  #include "qapi/error.h"
>  #include "hw/core/qdev-properties.h"
>  #include "fpu/softfloat-helpers.h"
> +#include "hw/hexagon/hexagon_tlb.h"
>  #include "tcg/tcg.h"
>  #include "exec/gdbstub.h"
>  #include "accel/tcg/cpu-ops.h"
> +#include "cpu_helper.h"
> +#include "hex_mmu.h"
> +
> +#ifndef CONFIG_USER_ONLY
> +#include "sys_macros.h"
> +#include "accel/tcg/cpu-ldst.h"
> +#endif
>  
>  static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
>  {
> @@ -43,6 +51,11 @@ static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
>  }
>  
>  static const Property hexagon_cpu_properties[] = {
> +#ifndef CONFIG_USER_ONLY
> +    DEFINE_PROP_LINK("tlb", HexagonCPU, tlb, TYPE_HEXAGON_TLB,
> +                     HexagonTLBState *),
> +    DEFINE_PROP_UINT32("htid", HexagonCPU, htid, 0),
> +#endif
>      DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
>      DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, lldb_stack_adjust, 0,
>                           qdev_prop_uint32, target_ulong),
> @@ -269,7 +282,11 @@ static TCGTBCPUState hexagon_get_tb_cpu_state(CPUState *cs)
>      }
>  
>  #ifndef CONFIG_USER_ONLY
> +    hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX,
> +                           cpu_mmu_index(env_cpu(env), false));
>      hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, PCYCLE_ENABLED, 1);
> +#else
> +    hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX, MMU_USER_IDX);
>  #endif
>  
>      return (TCGTBCPUState){ .pc = pc, .flags = hex_flags };
> @@ -289,11 +306,15 @@ static void hexagon_restore_state_to_opc(CPUState *cs,
>      cpu_env(cs)->gpr[HEX_REG_PC] = data[0];
>  }
>  
> +
>  static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
>  {
>      CPUState *cs = CPU(obj);
>      HexagonCPUClass *mcc = HEXAGON_CPU_GET_CLASS(obj);
>      CPUHexagonState *env = cpu_env(cs);
> +#ifndef CONFIG_USER_ONLY
> +    HexagonCPU *cpu = HEXAGON_CPU(cs);
> +#endif
>  
>      if (mcc->parent_phases.hold) {
>          mcc->parent_phases.hold(obj, type);
> @@ -307,7 +328,14 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
>      memset(env->t_sreg, 0, sizeof(uint32_t) * NUM_SREGS);
>      memset(env->greg, 0, sizeof(uint32_t) * NUM_GREGS);
>      env->wait_next_pc = 0;
> +    env->tlb_lock_state = HEX_LOCK_UNLOCKED;
> +    env->k0_lock_state = HEX_LOCK_UNLOCKED;
> +    env->tlb_lock_count = 0;
> +    env->k0_lock_count = 0;
>      env->next_PC = 0;
> +
> +    env->t_sreg[HEX_SREG_HTID] = cpu->htid;
> +    env->threadId = cpu->htid;
>  #endif
>      env->cause_code = HEX_EVENT_NONE;
>  }
> @@ -337,7 +365,15 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
>                               hexagon_hvx_gdb_write_register,
>                               gdb_find_static_feature("hexagon-hvx.xml"));
>  
> +#ifndef CONFIG_USER_ONLY
> +    if (!HEXAGON_CPU(dev)->tlb) {
> +        error_setg(errp, "hexagon cpu requires 'tlb' link property to be set");
> +        return;
> +    }
> +#endif
> +
>      qemu_init_vcpu(cs);
> +
>      cpu_reset(cs);
>      mcc->parent_realize(dev, errp);
>  }
> diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
> new file mode 100644
> index 00000000000..c921e82b377
> --- /dev/null
> +++ b/target/hexagon/hex_mmu.c
> @@ -0,0 +1,268 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/qemu-print.h"
> +#include "cpu.h"
> +#include "system/cpus.h"
> +#include "internal.h"
> +#include "exec/cpu-interrupt.h"
> +#include "cpu_helper.h"
> +#include "exec/cputlb.h"
> +#include "hex_mmu.h"
> +#include "macros.h"
> +#include "sys_macros.h"
> +#include "hw/hexagon/hexagon_tlb.h"
> +#include "hw/hexagon/hexagon_globalreg.h"
> +
> +static inline void hex_log_tlbw(uint32_t index, uint64_t entry)
> +{
> +    qemu_log_mask(CPU_LOG_MMU,
> +                  "tlbw[%03" PRIu32 "]: 0x%016" PRIx64 "\n",
> +                  index, entry);
> +}
> +
> +void hex_tlbw(CPUHexagonState *env, uint32_t index, uint64_t value)
> +{
> +    uint32_t myidx = fTLB_NONPOW2WRAP(fTLB_IDXMASK(index));
> +    HexagonTLBState *tlb = env_archcpu(env)->tlb;
> +    uint64_t old_entry = hexagon_tlb_read(tlb, myidx);
> +
> +    bool old_entry_valid = extract64(old_entry, 63, 1);
> +    if (old_entry_valid && hexagon_cpu_mmu_enabled(env)) {
> +        CPUState *cs = env_cpu(env);
> +        tlb_flush(cs);
> +    }
> +    hexagon_tlb_write(tlb, myidx, value);
> +    hex_log_tlbw(myidx, value);
> +}
> +
> +void hex_mmu_on(CPUHexagonState *env)
> +{
> +    CPUState *cs = env_cpu(env);
> +    qemu_log_mask(CPU_LOG_MMU, "Hexagon MMU turned on!\n");
> +    tlb_flush(cs);
> +}
> +
> +void hex_mmu_off(CPUHexagonState *env)
> +{
> +    CPUState *cs = env_cpu(env);
> +    qemu_log_mask(CPU_LOG_MMU, "Hexagon MMU turned off!\n");
> +    tlb_flush(cs);
> +}
> +
> +void hex_mmu_mode_change(CPUHexagonState *env)
> +{
> +    qemu_log_mask(CPU_LOG_MMU, "Hexagon mode change!\n");
> +    CPUState *cs = env_cpu(env);
> +    tlb_flush(cs);
> +}
> +
> +bool hex_tlb_find_match(CPUHexagonState *env, uint32_t VA,
> +                        MMUAccessType access_type, hwaddr *PA, int *prot,
> +                        uint64_t *size, int32_t *excp, int mmu_idx)
> +{
> +    HexagonCPU *cpu = env_archcpu(env);
> +    uint32_t ssr = env->t_sreg[HEX_SREG_SSR];
> +    uint8_t asid = GET_SSR_FIELD(SSR_ASID, ssr);
> +    int cause_code = 0;
> +
> +    bool found = hexagon_tlb_find_match(cpu->tlb, asid, VA, access_type,
> +                                        PA, prot, size, excp, &cause_code,
> +                                        mmu_idx);
> +    if (cause_code) {
> +        env->cause_code = cause_code;
> +    }
> +    return found;
> +}
> +
> +/* Called from tlbp instruction */
> +uint32_t hex_tlb_lookup(CPUHexagonState *env, uint32_t ssr, uint32_t VA)
> +{
> +    HexagonCPU *cpu = env_archcpu(env);
> +    uint8_t asid = GET_SSR_FIELD(SSR_ASID, ssr);
> +    int cause_code = 0;
> +
> +    uint32_t result = hexagon_tlb_lookup(cpu->tlb, asid, VA, &cause_code);
> +    if (cause_code) {
> +        env->cause_code = cause_code;
> +    }
> +    return result;
> +}
> +
> +/*
> + * Return codes:
> + * 0 or positive             index of match
> + * -1                        multiple matches
> + * -2                        no match
> + */
> +int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry, uint64_t index)
> +{
> +    HexagonCPU *cpu = env_archcpu(env);
> +    return hexagon_tlb_check_overlap(cpu->tlb, entry, index);
> +}
> +
> +void dump_mmu(Monitor *mon, CPUHexagonState *env)
> +{
> +    HexagonCPU *cpu = env_archcpu(env);
> +    hexagon_tlb_dump(mon, cpu->tlb);
> +}
> +
> +static inline void print_thread(const char *str, CPUState *cs)
> +{
> +    g_assert(bql_locked());
> +    CPUHexagonState *thread = cpu_env(cs);
> +    bool is_stopped = cpu_is_stopped(cs);
> +    int exe_mode = get_exe_mode(thread);
> +    hex_lock_state_t lock_state = thread->tlb_lock_state;
> +    qemu_log_mask(CPU_LOG_MMU,
> +           "%s: threadId = %" PRIu32 ": %s, exe_mode = %s, tlb_lock_state = %s\n",
> +           str,
> +           thread->threadId,
> +           is_stopped ? "stopped" : "running",
> +           exe_mode == HEX_EXE_MODE_OFF ? "off" :
> +           exe_mode == HEX_EXE_MODE_RUN ? "run" :
> +           exe_mode == HEX_EXE_MODE_WAIT ? "wait" :
> +           exe_mode == HEX_EXE_MODE_DEBUG ? "debug" :
> +           "unknown",
> +           lock_state == HEX_LOCK_UNLOCKED ? "unlocked" :
> +           lock_state == HEX_LOCK_WAITING ? "waiting" :
> +           lock_state == HEX_LOCK_OWNER ? "owner" :
> +           "unknown");
> +}
> +
> +static inline void print_thread_states(const char *str)
> +{
> +    CPUState *cs;
> +    CPU_FOREACH(cs) {
> +        print_thread(str, cs);
> +    }
> +}
> +
> +void hex_tlb_lock(CPUHexagonState *env)
> +{
> +    qemu_log_mask(CPU_LOG_MMU, "hex_tlb_lock: " TARGET_FMT_ld "\n",
> +                  env->threadId);
> +    BQL_LOCK_GUARD();
> +    g_assert((env->tlb_lock_count == 0) || (env->tlb_lock_count == 1));
> +
> +    HexagonCPU *cpu = env_archcpu(env);
> +    uint32_t syscfg = cpu->globalregs ?
> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_SYSCFG,
> +                               env->threadId) : 0;
> +    uint8_t tlb_lock = GET_SYSCFG_FIELD(SYSCFG_TLBLOCK, syscfg);
> +    if (tlb_lock) {
> +        if (env->tlb_lock_state == HEX_LOCK_QUEUED) {
> +            env->next_PC += 4;
> +            env->tlb_lock_count++;
> +            env->tlb_lock_state = HEX_LOCK_OWNER;
> +            SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 1);
> +            return;
> +        }
> +        if (env->tlb_lock_state == HEX_LOCK_OWNER) {
> +            qemu_log_mask(CPU_LOG_MMU | LOG_GUEST_ERROR,
> +                          "Double tlblock at PC: 0x%" PRIx32 ", thread may hang\n",
> +                          env->next_PC);
> +            env->next_PC += 4;
> +            CPUState *cs = env_cpu(env);
> +            cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> +            return;
> +        }
> +        env->tlb_lock_state = HEX_LOCK_WAITING;
> +        CPUState *cs = env_cpu(env);
> +        cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> +    } else {
> +        env->next_PC += 4;
> +        env->tlb_lock_count++;
> +        env->tlb_lock_state = HEX_LOCK_OWNER;
> +        SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 1);
> +    }
> +
> +    if (qemu_loglevel_mask(CPU_LOG_MMU)) {
> +        qemu_log_mask(CPU_LOG_MMU, "Threads after hex_tlb_lock:\n");
> +        print_thread_states("\tThread");
> +    }
> +}
> +
> +void hex_tlb_unlock(CPUHexagonState *env)
> +{
> +    BQL_LOCK_GUARD();
> +    g_assert((env->tlb_lock_count == 0) || (env->tlb_lock_count == 1));
> +
> +    /* Nothing to do if the TLB isn't locked by this thread */
> +    HexagonCPU *cpu = env_archcpu(env);
> +    uint32_t syscfg = cpu->globalregs ?
> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_SYSCFG,
> +                               env->threadId) : 0;
> +    uint8_t tlb_lock = GET_SYSCFG_FIELD(SYSCFG_TLBLOCK, syscfg);
> +    if ((tlb_lock == 0) ||
> +        (env->tlb_lock_state != HEX_LOCK_OWNER)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "thread %" PRIu32 " attempted to tlbunlock without having the "
> +                      "lock, tlb_lock state = %d\n",
> +                      env->threadId, env->tlb_lock_state);
> +        g_assert(env->tlb_lock_state != HEX_LOCK_WAITING);
> +        return;
> +    }
> +
> +    env->tlb_lock_count--;
> +    env->tlb_lock_state = HEX_LOCK_UNLOCKED;
> +    SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 0);
> +
> +    /* Look for a thread to unlock */
> +    unsigned int this_threadId = env->threadId;
> +    CPUHexagonState *unlock_thread = NULL;
> +    CPUState *cs;
> +    CPU_FOREACH(cs) {
> +        CPUHexagonState *thread = cpu_env(cs);
> +
> +        /*
> +         * The hardware implements round-robin fairness, so we look for threads
> +         * starting at env->threadId + 1 and incrementing modulo the number of
> +         * threads.
> +         *
> +         * To implement this, we check if thread is a earlier in the modulo
> +         * sequence than unlock_thread.
> +         *     if unlock thread is higher than this thread
> +         *         thread must be between this thread and unlock_thread
> +         *     else
> +         *         thread higher than this thread is ahead of unlock_thread
> +         *         thread must be lower then unlock thread
> +         */
> +        if (thread->tlb_lock_state == HEX_LOCK_WAITING) {
> +            if (!unlock_thread) {
> +                unlock_thread = thread;
> +            } else if (unlock_thread->threadId > this_threadId) {
> +                if (this_threadId < thread->threadId &&
> +                    thread->threadId < unlock_thread->threadId) {
> +                    unlock_thread = thread;
> +                }
> +            } else {
> +                if (thread->threadId > this_threadId) {
> +                    unlock_thread = thread;
> +                }
> +                if (thread->threadId < unlock_thread->threadId) {
> +                    unlock_thread = thread;
> +                }
> +            }
> +        }
> +    }
> +    if (unlock_thread) {
> +        cs = env_cpu(unlock_thread);
> +        print_thread("\tWaiting thread found", cs);
> +        unlock_thread->tlb_lock_state = HEX_LOCK_QUEUED;
> +        SET_SYSCFG_FIELD(unlock_thread, SYSCFG_TLBLOCK, 1);
> +        cpu_interrupt(cs, CPU_INTERRUPT_TLB_UNLOCK);
> +    }
> +
> +    if (qemu_loglevel_mask(CPU_LOG_MMU)) {
> +        qemu_log_mask(CPU_LOG_MMU, "Threads after hex_tlb_unlock:\n");
> +        print_thread_states("\tThread");
> +    }
> +
> +}

For the rest, it looks good to me.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

