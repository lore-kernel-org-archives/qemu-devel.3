Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B714C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 08:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUNPM-0004zJ-7o; Mon, 29 Jan 2024 03:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUNPL-0004yy-9F
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 03:54:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUNPJ-0007mD-1Z
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 03:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706518459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oorgb+BlWVMYQCskgufSPlA0qHmGXKaL4ZeDFtL69m8=;
 b=IHCdLM5Ht78xR7utHMqNys2E56qei9QxXh4dpe7sreNpFvKMrF1Wohty5aO5FJbfmeBghr
 qjcILAeJVkqplrJKRhPjMuHfvlAIHn61lbo0B8r6MUHJRtFjSP/AlnmijZgc+VyCenmyR1
 knL40QBNY2ZB+cUtgXB9ODuKpnh67aU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-PbUBaCSaNfqDiApohYJfRQ-1; Mon, 29 Jan 2024 03:54:18 -0500
X-MC-Unique: PbUBaCSaNfqDiApohYJfRQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2cf37b157f5so19360001fa.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 00:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706518456; x=1707123256;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oorgb+BlWVMYQCskgufSPlA0qHmGXKaL4ZeDFtL69m8=;
 b=C4KVjgw/u5+NzqDn7Hgo70/d+VWeOHZ/dbCPD3w4ptujAbBxqWHSXMPhpjbSFOglvq
 Mbs/GtRnRjiV1FGoznHC+M8rVGQ2chRqAS+OFDTFhMacrMIjO3o2gqurdq5axOtmSaDX
 Re/cNW3WOmmU3j6BK4syMvymSf0PSW4AjfPkexZdwtUQl+4fKbuD9g5BXrL4jAsvY6aZ
 F4BLiqxu5YqjEjmg+2rr71F4lNBNCqdp80mhj7rph4JUPCTi5Q5amnE2N/ekUIg0Fo6d
 jiqVaGGKc0KrC3ct1Ndy0U3ZJsiojdJd/IeC/4NTQmG+mBZZt4wsQcEpC+YIVJs2jzN7
 HQ5g==
X-Gm-Message-State: AOJu0Yzb7pIC77T5ryMUQ2WFI5sF2ft718/5ydDWCFiOIZ35AT0NOo5E
 ve8FKMcPkkCyfwhSh6xkhLLIx/EXM00h1J6UH+VPF9shbbMhMReYDXsEu5BGCoGoxMmS5annboO
 Z9BQZ5wz6mDx633gyR3gO6/ZW3iVKIIx+NznCzza8wzfN5rIJBEyT
X-Received: by 2002:a19:7506:0:b0:510:6e7:6999 with SMTP id
 y6-20020a197506000000b0051006e76999mr3215706lfe.45.1706518456599; 
 Mon, 29 Jan 2024 00:54:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzfEI4PMldeU4N6Quh7mvJJetSSD4AkNIQnf5pr04iU10sShZyMZ2fG5TOiiLbCOsiTtNCeg==
X-Received: by 2002:a19:7506:0:b0:510:6e7:6999 with SMTP id
 y6-20020a197506000000b0051006e76999mr3215693lfe.45.1706518456207; 
 Mon, 29 Jan 2024 00:54:16 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.googlemail.com with ESMTPSA id
 w7-20020aa7da47000000b0055f0c027a3esm465242eds.30.2024.01.29.00.54.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 00:54:11 -0800 (PST)
Message-ID: <3e984769-f178-46b3-aaa8-1718b6fd49bf@redhat.com>
Date: Mon, 29 Jan 2024 09:54:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] target/arm: Move v7m-related code from cpu32.c
 into a separate file
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas
 <farosas@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20240129081835.137726-1-thuth@redhat.com>
 <20240129081835.137726-2-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20240129081835.137726-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/29/24 09:18, Thomas Huth wrote:
> Move the code to a separate file so that we do not have to compile
> it anymore if CONFIG_ARM_V7M is not set.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/arm/tcg/cpu-v7m.c   | 290 +++++++++++++++++++++++++++++++++++++
>   target/arm/tcg/cpu32.c     | 261 ---------------------------------
>   target/arm/meson.build     |   3 +
>   target/arm/tcg/meson.build |   3 +
>   4 files changed, 296 insertions(+), 261 deletions(-)
>   create mode 100644 target/arm/tcg/cpu-v7m.c
> 
> diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
> new file mode 100644
> index 0000000000..89a25444a2
> --- /dev/null
> +++ b/target/arm/tcg/cpu-v7m.c
> @@ -0,0 +1,290 @@
> +/*
> + * QEMU ARMv7-M TCG-only CPUs.
> + *
> + * Copyright (c) 2012 SUSE LINUX Products GmbH
> + *
> + * This code is licensed under the GNU GPL v2 or later.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "hw/core/tcg-cpu-ops.h"
> +#include "internals.h"
> +
> +#if !defined(CONFIG_USER_ONLY)
> +
> +#include "hw/intc/armv7m_nvic.h"
> +
> +static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
> +{
> +    CPUClass *cc = CPU_GET_CLASS(cs);
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +    bool ret = false;
> +
> +    /*
> +     * ARMv7-M interrupt masking works differently than -A or -R.
> +     * There is no FIQ/IRQ distinction. Instead of I and F bits
> +     * masking FIQ and IRQ interrupts, an exception is taken only
> +     * if it is higher priority than the current execution priority
> +     * (which depends on state like BASEPRI, FAULTMASK and the
> +     * currently active exception).
> +     */
> +    if (interrupt_request & CPU_INTERRUPT_HARD
> +        && (armv7m_nvic_can_take_pending_exception(env->nvic))) {
> +        cs->exception_index = EXCP_IRQ;
> +        cc->tcg_ops->do_interrupt(cs);
> +        ret = true;
> +    }
> +    return ret;
> +}
> +
> +#endif /* !CONFIG_USER_ONLY */
> +
> +static void cortex_m0_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    set_feature(&cpu->env, ARM_FEATURE_V6);
> +    set_feature(&cpu->env, ARM_FEATURE_M);
> +
> +    cpu->midr = 0x410cc200;
> +
> +    /*
> +     * These ID register values are not guest visible, because
> +     * we do not implement the Main Extension. They must be set
> +     * to values corresponding to the Cortex-M0's implemented
> +     * features, because QEMU generally controls its emulation
> +     * by looking at ID register fields. We use the same values as
> +     * for the M3.
> +     */
> +    cpu->isar.id_pfr0 = 0x00000030;
> +    cpu->isar.id_pfr1 = 0x00000200;
> +    cpu->isar.id_dfr0 = 0x00100000;
> +    cpu->id_afr0 = 0x00000000;
> +    cpu->isar.id_mmfr0 = 0x00000030;
> +    cpu->isar.id_mmfr1 = 0x00000000;
> +    cpu->isar.id_mmfr2 = 0x00000000;
> +    cpu->isar.id_mmfr3 = 0x00000000;
> +    cpu->isar.id_isar0 = 0x01141110;
> +    cpu->isar.id_isar1 = 0x02111000;
> +    cpu->isar.id_isar2 = 0x21112231;
> +    cpu->isar.id_isar3 = 0x01111110;
> +    cpu->isar.id_isar4 = 0x01310102;
> +    cpu->isar.id_isar5 = 0x00000000;
> +    cpu->isar.id_isar6 = 0x00000000;
> +}
> +
> +static void cortex_m3_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    set_feature(&cpu->env, ARM_FEATURE_V7);
> +    set_feature(&cpu->env, ARM_FEATURE_M);
> +    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
> +    cpu->midr = 0x410fc231;
> +    cpu->pmsav7_dregion = 8;
> +    cpu->isar.id_pfr0 = 0x00000030;
> +    cpu->isar.id_pfr1 = 0x00000200;
> +    cpu->isar.id_dfr0 = 0x00100000;
> +    cpu->id_afr0 = 0x00000000;
> +    cpu->isar.id_mmfr0 = 0x00000030;
> +    cpu->isar.id_mmfr1 = 0x00000000;
> +    cpu->isar.id_mmfr2 = 0x00000000;
> +    cpu->isar.id_mmfr3 = 0x00000000;
> +    cpu->isar.id_isar0 = 0x01141110;
> +    cpu->isar.id_isar1 = 0x02111000;
> +    cpu->isar.id_isar2 = 0x21112231;
> +    cpu->isar.id_isar3 = 0x01111110;
> +    cpu->isar.id_isar4 = 0x01310102;
> +    cpu->isar.id_isar5 = 0x00000000;
> +    cpu->isar.id_isar6 = 0x00000000;
> +}
> +
> +static void cortex_m4_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    set_feature(&cpu->env, ARM_FEATURE_V7);
> +    set_feature(&cpu->env, ARM_FEATURE_M);
> +    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
> +    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
> +    cpu->midr = 0x410fc240; /* r0p0 */
> +    cpu->pmsav7_dregion = 8;
> +    cpu->isar.mvfr0 = 0x10110021;
> +    cpu->isar.mvfr1 = 0x11000011;
> +    cpu->isar.mvfr2 = 0x00000000;
> +    cpu->isar.id_pfr0 = 0x00000030;
> +    cpu->isar.id_pfr1 = 0x00000200;
> +    cpu->isar.id_dfr0 = 0x00100000;
> +    cpu->id_afr0 = 0x00000000;
> +    cpu->isar.id_mmfr0 = 0x00000030;
> +    cpu->isar.id_mmfr1 = 0x00000000;
> +    cpu->isar.id_mmfr2 = 0x00000000;
> +    cpu->isar.id_mmfr3 = 0x00000000;
> +    cpu->isar.id_isar0 = 0x01141110;
> +    cpu->isar.id_isar1 = 0x02111000;
> +    cpu->isar.id_isar2 = 0x21112231;
> +    cpu->isar.id_isar3 = 0x01111110;
> +    cpu->isar.id_isar4 = 0x01310102;
> +    cpu->isar.id_isar5 = 0x00000000;
> +    cpu->isar.id_isar6 = 0x00000000;
> +}
> +
> +static void cortex_m7_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    set_feature(&cpu->env, ARM_FEATURE_V7);
> +    set_feature(&cpu->env, ARM_FEATURE_M);
> +    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
> +    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
> +    cpu->midr = 0x411fc272; /* r1p2 */
> +    cpu->pmsav7_dregion = 8;
> +    cpu->isar.mvfr0 = 0x10110221;
> +    cpu->isar.mvfr1 = 0x12000011;
> +    cpu->isar.mvfr2 = 0x00000040;
> +    cpu->isar.id_pfr0 = 0x00000030;
> +    cpu->isar.id_pfr1 = 0x00000200;
> +    cpu->isar.id_dfr0 = 0x00100000;
> +    cpu->id_afr0 = 0x00000000;
> +    cpu->isar.id_mmfr0 = 0x00100030;
> +    cpu->isar.id_mmfr1 = 0x00000000;
> +    cpu->isar.id_mmfr2 = 0x01000000;
> +    cpu->isar.id_mmfr3 = 0x00000000;
> +    cpu->isar.id_isar0 = 0x01101110;
> +    cpu->isar.id_isar1 = 0x02112000;
> +    cpu->isar.id_isar2 = 0x20232231;
> +    cpu->isar.id_isar3 = 0x01111131;
> +    cpu->isar.id_isar4 = 0x01310132;
> +    cpu->isar.id_isar5 = 0x00000000;
> +    cpu->isar.id_isar6 = 0x00000000;
> +}
> +
> +static void cortex_m33_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    set_feature(&cpu->env, ARM_FEATURE_V8);
> +    set_feature(&cpu->env, ARM_FEATURE_M);
> +    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
> +    set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
> +    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
> +    cpu->midr = 0x410fd213; /* r0p3 */
> +    cpu->pmsav7_dregion = 16;
> +    cpu->sau_sregion = 8;
> +    cpu->isar.mvfr0 = 0x10110021;
> +    cpu->isar.mvfr1 = 0x11000011;
> +    cpu->isar.mvfr2 = 0x00000040;
> +    cpu->isar.id_pfr0 = 0x00000030;
> +    cpu->isar.id_pfr1 = 0x00000210;
> +    cpu->isar.id_dfr0 = 0x00200000;
> +    cpu->id_afr0 = 0x00000000;
> +    cpu->isar.id_mmfr0 = 0x00101F40;
> +    cpu->isar.id_mmfr1 = 0x00000000;
> +    cpu->isar.id_mmfr2 = 0x01000000;
> +    cpu->isar.id_mmfr3 = 0x00000000;
> +    cpu->isar.id_isar0 = 0x01101110;
> +    cpu->isar.id_isar1 = 0x02212000;
> +    cpu->isar.id_isar2 = 0x20232232;
> +    cpu->isar.id_isar3 = 0x01111131;
> +    cpu->isar.id_isar4 = 0x01310132;
> +    cpu->isar.id_isar5 = 0x00000000;
> +    cpu->isar.id_isar6 = 0x00000000;
> +    cpu->clidr = 0x00000000;
> +    cpu->ctr = 0x8000c000;
> +}
> +
> +static void cortex_m55_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    set_feature(&cpu->env, ARM_FEATURE_V8);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_1M);
> +    set_feature(&cpu->env, ARM_FEATURE_M);
> +    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
> +    set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
> +    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
> +    cpu->midr = 0x410fd221; /* r0p1 */
> +    cpu->revidr = 0;
> +    cpu->pmsav7_dregion = 16;
> +    cpu->sau_sregion = 8;
> +    /* These are the MVFR* values for the FPU + full MVE configuration */
> +    cpu->isar.mvfr0 = 0x10110221;
> +    cpu->isar.mvfr1 = 0x12100211;
> +    cpu->isar.mvfr2 = 0x00000040;
> +    cpu->isar.id_pfr0 = 0x20000030;
> +    cpu->isar.id_pfr1 = 0x00000230;
> +    cpu->isar.id_dfr0 = 0x10200000;
> +    cpu->id_afr0 = 0x00000000;
> +    cpu->isar.id_mmfr0 = 0x00111040;
> +    cpu->isar.id_mmfr1 = 0x00000000;
> +    cpu->isar.id_mmfr2 = 0x01000000;
> +    cpu->isar.id_mmfr3 = 0x00000011;
> +    cpu->isar.id_isar0 = 0x01103110;
> +    cpu->isar.id_isar1 = 0x02212000;
> +    cpu->isar.id_isar2 = 0x20232232;
> +    cpu->isar.id_isar3 = 0x01111131;
> +    cpu->isar.id_isar4 = 0x01310132;
> +    cpu->isar.id_isar5 = 0x00000000;
> +    cpu->isar.id_isar6 = 0x00000000;
> +    cpu->clidr = 0x00000000; /* caches not implemented */
> +    cpu->ctr = 0x8303c003;
> +}
> +
> +static const struct TCGCPUOps arm_v7m_tcg_ops = {
> +    .initialize = arm_translate_init,
> +    .synchronize_from_tb = arm_cpu_synchronize_from_tb,
> +    .debug_excp_handler = arm_debug_excp_handler,
> +    .restore_state_to_opc = arm_restore_state_to_opc,
> +
> +#ifdef CONFIG_USER_ONLY
> +    .record_sigsegv = arm_cpu_record_sigsegv,
> +    .record_sigbus = arm_cpu_record_sigbus,
> +#else
> +    .tlb_fill = arm_cpu_tlb_fill,
> +    .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
> +    .do_interrupt = arm_v7m_cpu_do_interrupt,
> +    .do_transaction_failed = arm_cpu_do_transaction_failed,
> +    .do_unaligned_access = arm_cpu_do_unaligned_access,
> +    .adjust_watchpoint_address = arm_adjust_watchpoint_address,
> +    .debug_check_watchpoint = arm_debug_check_watchpoint,
> +    .debug_check_breakpoint = arm_debug_check_breakpoint,
> +#endif /* !CONFIG_USER_ONLY */
> +};
> +
> +static void arm_v7m_class_init(ObjectClass *oc, void *data)
> +{
> +    ARMCPUClass *acc = ARM_CPU_CLASS(oc);
> +    CPUClass *cc = CPU_CLASS(oc);
> +
> +    acc->info = data;
> +    cc->tcg_ops = &arm_v7m_tcg_ops;
> +    cc->gdb_core_xml_file = "arm-m-profile.xml";
> +}
> +
> +static const ARMCPUInfo arm_v7m_cpus[] = {
> +    { .name = "cortex-m0",   .initfn = cortex_m0_initfn,
> +                             .class_init = arm_v7m_class_init },
> +    { .name = "cortex-m3",   .initfn = cortex_m3_initfn,
> +                             .class_init = arm_v7m_class_init },
> +    { .name = "cortex-m4",   .initfn = cortex_m4_initfn,
> +                             .class_init = arm_v7m_class_init },
> +    { .name = "cortex-m7",   .initfn = cortex_m7_initfn,
> +                             .class_init = arm_v7m_class_init },
> +    { .name = "cortex-m33",  .initfn = cortex_m33_initfn,
> +                             .class_init = arm_v7m_class_init },
> +    { .name = "cortex-m55",  .initfn = cortex_m55_initfn,
> +                             .class_init = arm_v7m_class_init },

I'm not sure these CPU models make sense for linux-user but, since this 
patch makes no functional change, they can be removed later.

Paolo


