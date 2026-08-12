Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1F8C5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2wc-0006MJ-2d; Wed, 12 Aug 2026 03:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wu2wY-0006Is-KO
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:00:06 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wu2wV-0000ND-Pn
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:00:06 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-84f77cc7302so288180b3a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 00:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786518002; cv=none;
 d=google.com; s=arc-20260327;
 b=gpl2MFSd6Oc6pfaZn4z9Mg3XMGQ2UMcqzd0fo5xlucldW4A/tri445S0uVXKrLnCZK
 YGLNi6dtIPwPA1YmWTpPoZpqjb/PtMpGqVdafSeprNZATmI/mQBMTxET99mSVE8KuEbV
 SopQ6eoQAX/xChOvZtN4fY5vwYfH1oKgPF1SGHKyQbhAwmedGx0Pn0F0Jk0vQWWdctd4
 qUNWz62ZxM9A0hMeTg9T0F24v3lIXFSTVZDe5gN9QwLV4LMHRcWuyZpZUDPkNw9Spgoq
 rLVvVwLDRKUKRdxsRZB0+gkNHevWNSdjUtu4WBnsge6rgsPhFDJLPL4+qkMDaYfcPpVY
 RM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ok0rGZzlwkjciQv+adIB8gMCbfh56M57LhucXvZnAEs=;
 fh=nMmB30uaIhDTpmtBZUvn0sOwGbCfGyYqBWkoOVEzeQU=;
 b=SVTSPSmluw4+UB7IqwaZnzLr8KZ2KKTVs0gsO77L9cHiJnPIOqo/11b9O8HK3lOjh5
 rbOifR4/ZjubUmvZ3iMBe0qcXJuTsqzcZMcidl88bLeoQTM97NrMumUV9QYykHV9vTEv
 0utuw//yENip+wJBOyK+7N+0Ei9AHxpm+zvk5L6EgCqcZ3Vticffo1nwCNUsZCU76JF2
 02lx8X5zbOdyFIrUXOI1s7K4+Yu4bAeicVVD8vUlJ/X1Bla0Ue5DQRiZoocpk7TvS82d
 MFAHqmrLL83Hq0Q3WXduEyNKVO94bW15uMfFxfbdshMdSNttm83ko/srDiTBuTIuS10b
 Bisw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786518002; x=1787122802; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ok0rGZzlwkjciQv+adIB8gMCbfh56M57LhucXvZnAEs=;
 b=n87hbGd5U0+6CaEmpySoIth7XgGi3Yo6MpaVdUSdBBFChAmmDjfUqU3YLDUZFGPWat
 K0VhFk/a72cvSsbQ0WFdvf/0i9SnO6cAhxQY8kjM9+4jbDWKpbmMK6vlpOfH3EmvtKUN
 cyxKLCmUCK/aQsVB30BvQ4aviQMEzIgzJ1Rfi6XBW7gZWTo4bYpQHSZmIDUJ7glyUVka
 bdDWjtccU6dZoK2YZrgb65j70SkKKYtamHjk/3DLmCnJbcXELcyATasiUZx6OSTgowAM
 PQUoxEbDG1BgB3PUp4XifenzhznYrnDOy4hVzPrkjfefd6CJ3PYheAt7W7ny2qlZg0Rs
 0zBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786518002; x=1787122802;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ok0rGZzlwkjciQv+adIB8gMCbfh56M57LhucXvZnAEs=;
 b=ZygA8iIqrRB8JLxyrgVvr2HBv00/i1gpgOXugIp+mpSMA7iXLcm2ic5y0pwSJI/nTV
 HoRjqsWF8WhZT6uUG7WfEBVvueQDRNI53LKxRqsZD4cANzXOQmpIJGmkoT7yxWBS2/0r
 G41KLNiNqK4CKpC6tYlZ6pwUnNaykvDEZCHGN6d4qAvIxXOEcYG86XVQDPY2hF2ct/4P
 2/EGj11JktFvmo1+3y8YHyuxLmc4RoXyjnoQsKQnrMweDCWoTWUA0xu0bDt3u3bCn1uO
 nICKU9xlFV56hsjaOqf8USCD9481PdysrIoaX34gKNDYQlvOYyXAA3phMO/GGxoqzSba
 rwAw==
X-Gm-Message-State: AOJu0Yxk/P3Mcg1l6Q9jLBQSY0D9Qcen/hGKWS9QHqihgiH9Vqq+hO47
 28Pi9GCiu8ouR3B+X/H/nRuyXhdACr5ZCt6XEbdZx4dRTP4bwo2KIn/bNWTIP+7bTMWmY/li7yq
 20xONEI7Wf+pqHZ3EZf2WvtxsbaaebYY=
X-Gm-Gg: AR+sD10UZmXrc7oJp1Z9Snira26iCONxylUZgCZEF+0Cuqg5AuOOl2qyxeF+SQs6AcI
 qI/Gzej/YHCM7tKCO56WZaVaBhjdfwFWMOhzw2tCCPpqQnd4DQWdJDuVrmpl8QMskwDQmQ4eMHH
 /kW6vJxELs5XNaZdv6VZmdWuYQ3n1bYWP9Z/tVXJUIapkQOQ5SnVSGUSXdgimvsC2btMGscBeTn
 BIUjv/5N7uHRp8fGS0deb/nT/1ML/uFTa/oOWZmfSg11RmDbU+2gkl1aTJ61DSp4tGo9Sx5sR2R
 q/Fj6MtcOLiyLH338dnCItbbpLDHPJLIsqQ79yIO7ubJv0NaMk7KHVjJW+6gaMk8DQ3ACy+RKfA
 f
X-Received: by 2002:a05:6a20:ad98:b0:3b4:6026:6c5d with SMTP id
 adf61e73a8af0-3cc3f528390mr3152890637.5.1786518001787; Wed, 12 Aug 2026
 00:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
 <20260611052857.3911981-35-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260611052857.3911981-35-brian.cain@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 12 Aug 2026 10:59:49 +0400
X-Gm-Features: AUfX_mxpJTJ89_aI907rqmHlUVxQCukV8DsHvWMeEAietXYT8upKSlWLc2hGKsU
Message-ID: <CAJ+F1CJb1rZPCE8euSqdwojNRTHtquOYcT+BTWjuO_c8oKYgqg@mail.gmail.com>
Subject: Re: [PATCH v8] target/hexagon: Update TARGET_PAGE_BITS,
 stubs for modify_ssr/get_exe_mode
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com, philmd@mailo.org, 
 philmd@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Brian

On Thu, Jun 11, 2026 at 9:31=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
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
> +    HEX_LOCK_UNLOCKED       =3D 0,
> +    HEX_LOCK_WAITING        =3D 1,
> +    HEX_LOCK_OWNER          =3D 2,
> +    HEX_LOCK_QUEUED        =3D 3
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
> +extern void hex_tlbw(CPUHexagonState *env, uint32_t index, uint64_t valu=
e);
> +extern uint32_t hex_tlb_lookup(CPUHexagonState *env, uint32_t ssr, uint3=
2_t VA);
> +extern void hex_mmu_on(CPUHexagonState *env);
> +extern void hex_mmu_off(CPUHexagonState *env);
> +extern void hex_mmu_mode_change(CPUHexagonState *env);
> +extern bool hex_tlb_find_match(CPUHexagonState *env, uint32_t VA,
> +                               MMUAccessType access_type, hwaddr *PA, in=
t *prot,
> +                               uint64_t *size, int32_t *excp, int mmu_id=
x);
> +extern int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry,
> +                                 uint64_t index);
> +extern void hex_tlb_lock(CPUHexagonState *env);
> +extern void hex_tlb_unlock(CPUHexagonState *env);
> +void dump_mmu(Monitor *mon, CPUHexagonState *env);

dump_mmu() is unused, should it be dropped or commented out (and
reintroduced when wired to info tlb?)

> +#endif
> diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
> index 33d73ed18d1..4338914efb5 100644
> --- a/target/hexagon/internal.h
> +++ b/target/hexagon/internal.h
> @@ -36,6 +36,15 @@ void G_NORETURN do_raise_exception(CPUHexagonState *en=
v,
>          uint32_t PC,
>          uintptr_t retaddr);
>
> +#define hexagon_cpu_mmu_enabled(env) ({ \
> +    HexagonCPU *cpu =3D env_archcpu(env); \
> +    cpu->globalregs ? \
> +        GET_SYSCFG_FIELD(SYSCFG_MMUEN, \
> +            hexagon_globalreg_read(cpu->globalregs, \
> +                                   HEX_SREG_SYSCFG, (env)->threadId)) : =
\
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
>  #define fDCINVA(REG) do { REG =3D REG; } while (0) /* Nothing to do in q=
emu */
>
> +#define fSET_TLB_LOCK()       hex_tlb_lock(env);
> +#define fCLEAR_TLB_LOCK()     hex_tlb_unlock(env);
> +
>  #define fTLB_IDXMASK(INDEX) \
>      ((INDEX) & (fPOW2_ROUNDUP( \
>          fCAST4u(hexagon_tlb_get_num_entries(env_archcpu(env)->tlb))) - 1=
))
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
> @@ -43,6 +51,11 @@ static ObjectClass *hexagon_cpu_class_by_name(const ch=
ar *cpu_model)
>  }
>
>  static const Property hexagon_cpu_properties[] =3D {
> +#ifndef CONFIG_USER_ONLY
> +    DEFINE_PROP_LINK("tlb", HexagonCPU, tlb, TYPE_HEXAGON_TLB,
> +                     HexagonTLBState *),
> +    DEFINE_PROP_UINT32("htid", HexagonCPU, htid, 0),
> +#endif
>      DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
>      DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, lldb_stack_adj=
ust, 0,
>                           qdev_prop_uint32, target_ulong),
> @@ -269,7 +282,11 @@ static TCGTBCPUState hexagon_get_tb_cpu_state(CPUSta=
te *cs)
>      }
>
>  #ifndef CONFIG_USER_ONLY
> +    hex_flags =3D FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX,
> +                           cpu_mmu_index(env_cpu(env), false));
>      hex_flags =3D FIELD_DP32(hex_flags, TB_FLAGS, PCYCLE_ENABLED, 1);
> +#else
> +    hex_flags =3D FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX, MMU_USER_ID=
X);
>  #endif
>
>      return (TCGTBCPUState){ .pc =3D pc, .flags =3D hex_flags };
> @@ -289,11 +306,15 @@ static void hexagon_restore_state_to_opc(CPUState *=
cs,
>      cpu_env(cs)->gpr[HEX_REG_PC] =3D data[0];
>  }
>
> +
>  static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
>  {
>      CPUState *cs =3D CPU(obj);
>      HexagonCPUClass *mcc =3D HEXAGON_CPU_GET_CLASS(obj);
>      CPUHexagonState *env =3D cpu_env(cs);
> +#ifndef CONFIG_USER_ONLY
> +    HexagonCPU *cpu =3D HEXAGON_CPU(cs);
> +#endif
>
>      if (mcc->parent_phases.hold) {
>          mcc->parent_phases.hold(obj, type);
> @@ -307,7 +328,14 @@ static void hexagon_cpu_reset_hold(Object *obj, Rese=
tType type)
>      memset(env->t_sreg, 0, sizeof(uint32_t) * NUM_SREGS);
>      memset(env->greg, 0, sizeof(uint32_t) * NUM_GREGS);
>      env->wait_next_pc =3D 0;
> +    env->tlb_lock_state =3D HEX_LOCK_UNLOCKED;
> +    env->k0_lock_state =3D HEX_LOCK_UNLOCKED;
> +    env->tlb_lock_count =3D 0;
> +    env->k0_lock_count =3D 0;
>      env->next_PC =3D 0;
> +
> +    env->t_sreg[HEX_SREG_HTID] =3D cpu->htid;
> +    env->threadId =3D cpu->htid;
>  #endif
>      env->cause_code =3D HEX_EVENT_NONE;
>  }
> @@ -337,7 +365,15 @@ static void hexagon_cpu_realize(DeviceState *dev, Er=
ror **errp)
>                               hexagon_hvx_gdb_write_register,
>                               gdb_find_static_feature("hexagon-hvx.xml"))=
;
>
> +#ifndef CONFIG_USER_ONLY
> +    if (!HEXAGON_CPU(dev)->tlb) {
> +        error_setg(errp, "hexagon cpu requires 'tlb' link property to be=
 set");
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
> +    uint32_t myidx =3D fTLB_NONPOW2WRAP(fTLB_IDXMASK(index));
> +    HexagonTLBState *tlb =3D env_archcpu(env)->tlb;
> +    uint64_t old_entry =3D hexagon_tlb_read(tlb, myidx);
> +
> +    bool old_entry_valid =3D extract64(old_entry, 63, 1);
> +    if (old_entry_valid && hexagon_cpu_mmu_enabled(env)) {
> +        CPUState *cs =3D env_cpu(env);
> +        tlb_flush(cs);
> +    }
> +    hexagon_tlb_write(tlb, myidx, value);
> +    hex_log_tlbw(myidx, value);
> +}
> +
> +void hex_mmu_on(CPUHexagonState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +    qemu_log_mask(CPU_LOG_MMU, "Hexagon MMU turned on!\n");
> +    tlb_flush(cs);
> +}
> +
> +void hex_mmu_off(CPUHexagonState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +    qemu_log_mask(CPU_LOG_MMU, "Hexagon MMU turned off!\n");
> +    tlb_flush(cs);
> +}
> +
> +void hex_mmu_mode_change(CPUHexagonState *env)
> +{
> +    qemu_log_mask(CPU_LOG_MMU, "Hexagon mode change!\n");
> +    CPUState *cs =3D env_cpu(env);
> +    tlb_flush(cs);
> +}
> +
> +bool hex_tlb_find_match(CPUHexagonState *env, uint32_t VA,
> +                        MMUAccessType access_type, hwaddr *PA, int *prot=
,
> +                        uint64_t *size, int32_t *excp, int mmu_idx)
> +{
> +    HexagonCPU *cpu =3D env_archcpu(env);
> +    uint32_t ssr =3D env->t_sreg[HEX_SREG_SSR];
> +    uint8_t asid =3D GET_SSR_FIELD(SSR_ASID, ssr);
> +    int cause_code =3D 0;
> +
> +    bool found =3D hexagon_tlb_find_match(cpu->tlb, asid, VA, access_typ=
e,
> +                                        PA, prot, size, excp, &cause_cod=
e,
> +                                        mmu_idx);
> +    if (cause_code) {
> +        env->cause_code =3D cause_code;
> +    }
> +    return found;
> +}
> +
> +/* Called from tlbp instruction */
> +uint32_t hex_tlb_lookup(CPUHexagonState *env, uint32_t ssr, uint32_t VA)
> +{
> +    HexagonCPU *cpu =3D env_archcpu(env);
> +    uint8_t asid =3D GET_SSR_FIELD(SSR_ASID, ssr);
> +    int cause_code =3D 0;
> +
> +    uint32_t result =3D hexagon_tlb_lookup(cpu->tlb, asid, VA, &cause_co=
de);
> +    if (cause_code) {
> +        env->cause_code =3D cause_code;
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
> +int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry, uint64_t=
 index)
> +{
> +    HexagonCPU *cpu =3D env_archcpu(env);
> +    return hexagon_tlb_check_overlap(cpu->tlb, entry, index);
> +}
> +
> +void dump_mmu(Monitor *mon, CPUHexagonState *env)
> +{
> +    HexagonCPU *cpu =3D env_archcpu(env);
> +    hexagon_tlb_dump(mon, cpu->tlb);
> +}
> +
> +static inline void print_thread(const char *str, CPUState *cs)
> +{
> +    g_assert(bql_locked());
> +    CPUHexagonState *thread =3D cpu_env(cs);
> +    bool is_stopped =3D cpu_is_stopped(cs);
> +    int exe_mode =3D get_exe_mode(thread);
> +    hex_lock_state_t lock_state =3D thread->tlb_lock_state;
> +    qemu_log_mask(CPU_LOG_MMU,
> +           "%s: threadId =3D %" PRIu32 ": %s, exe_mode =3D %s, tlb_lock_=
state =3D %s\n",
> +           str,
> +           thread->threadId,
> +           is_stopped ? "stopped" : "running",
> +           exe_mode =3D=3D HEX_EXE_MODE_OFF ? "off" :
> +           exe_mode =3D=3D HEX_EXE_MODE_RUN ? "run" :
> +           exe_mode =3D=3D HEX_EXE_MODE_WAIT ? "wait" :
> +           exe_mode =3D=3D HEX_EXE_MODE_DEBUG ? "debug" :
> +           "unknown",
> +           lock_state =3D=3D HEX_LOCK_UNLOCKED ? "unlocked" :
> +           lock_state =3D=3D HEX_LOCK_WAITING ? "waiting" :
> +           lock_state =3D=3D HEX_LOCK_OWNER ? "owner" :
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
> +    g_assert((env->tlb_lock_count =3D=3D 0) || (env->tlb_lock_count =3D=
=3D 1));
> +
> +    HexagonCPU *cpu =3D env_archcpu(env);
> +    uint32_t syscfg =3D cpu->globalregs ?
> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_SYSCFG,
> +                               env->threadId) : 0;
> +    uint8_t tlb_lock =3D GET_SYSCFG_FIELD(SYSCFG_TLBLOCK, syscfg);
> +    if (tlb_lock) {
> +        if (env->tlb_lock_state =3D=3D HEX_LOCK_QUEUED) {
> +            env->next_PC +=3D 4;
> +            env->tlb_lock_count++;
> +            env->tlb_lock_state =3D HEX_LOCK_OWNER;
> +            SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 1);
> +            return;
> +        }
> +        if (env->tlb_lock_state =3D=3D HEX_LOCK_OWNER) {
> +            qemu_log_mask(CPU_LOG_MMU | LOG_GUEST_ERROR,
> +                          "Double tlblock at PC: 0x%" PRIx32 ", thread m=
ay hang\n",
> +                          env->next_PC);
> +            env->next_PC +=3D 4;
> +            CPUState *cs =3D env_cpu(env);
> +            cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> +            return;
> +        }
> +        env->tlb_lock_state =3D HEX_LOCK_WAITING;
> +        CPUState *cs =3D env_cpu(env);
> +        cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> +    } else {
> +        env->next_PC +=3D 4;
> +        env->tlb_lock_count++;
> +        env->tlb_lock_state =3D HEX_LOCK_OWNER;
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
> +    g_assert((env->tlb_lock_count =3D=3D 0) || (env->tlb_lock_count =3D=
=3D 1));
> +
> +    /* Nothing to do if the TLB isn't locked by this thread */
> +    HexagonCPU *cpu =3D env_archcpu(env);
> +    uint32_t syscfg =3D cpu->globalregs ?
> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_SYSCFG,
> +                               env->threadId) : 0;
> +    uint8_t tlb_lock =3D GET_SYSCFG_FIELD(SYSCFG_TLBLOCK, syscfg);
> +    if ((tlb_lock =3D=3D 0) ||
> +        (env->tlb_lock_state !=3D HEX_LOCK_OWNER)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "thread %" PRIu32 " attempted to tlbunlock without=
 having the "
> +                      "lock, tlb_lock state =3D %d\n",
> +                      env->threadId, env->tlb_lock_state);
> +        g_assert(env->tlb_lock_state !=3D HEX_LOCK_WAITING);
> +        return;
> +    }
> +
> +    env->tlb_lock_count--;
> +    env->tlb_lock_state =3D HEX_LOCK_UNLOCKED;
> +    SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 0);
> +
> +    /* Look for a thread to unlock */
> +    unsigned int this_threadId =3D env->threadId;
> +    CPUHexagonState *unlock_thread =3D NULL;
> +    CPUState *cs;
> +    CPU_FOREACH(cs) {
> +        CPUHexagonState *thread =3D cpu_env(cs);
> +
> +        /*
> +         * The hardware implements round-robin fairness, so we look for =
threads
> +         * starting at env->threadId + 1 and incrementing modulo the num=
ber of
> +         * threads.
> +         *
> +         * To implement this, we check if thread is a earlier in the mod=
ulo
> +         * sequence than unlock_thread.
> +         *     if unlock thread is higher than this thread
> +         *         thread must be between this thread and unlock_thread
> +         *     else
> +         *         thread higher than this thread is ahead of unlock_thr=
ead
> +         *         thread must be lower then unlock thread
> +         */
> +        if (thread->tlb_lock_state =3D=3D HEX_LOCK_WAITING) {
> +            if (!unlock_thread) {
> +                unlock_thread =3D thread;
> +            } else if (unlock_thread->threadId > this_threadId) {
> +                if (this_threadId < thread->threadId &&
> +                    thread->threadId < unlock_thread->threadId) {
> +                    unlock_thread =3D thread;
> +                }
> +            } else {
> +                if (thread->threadId > this_threadId) {
> +                    unlock_thread =3D thread;
> +                }
> +                if (thread->threadId < unlock_thread->threadId) {
> +                    unlock_thread =3D thread;
> +                }
> +            }
> +        }
> +    }
> +    if (unlock_thread) {
> +        cs =3D env_cpu(unlock_thread);
> +        print_thread("\tWaiting thread found", cs);
> +        unlock_thread->tlb_lock_state =3D HEX_LOCK_QUEUED;
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
> --
> 2.34.1
>


--=20
Marc-Andr=C3=A9 Lureau

