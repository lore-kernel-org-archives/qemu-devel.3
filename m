Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C391CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 16:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrgeH-0001YH-10; Tue, 02 Apr 2024 12:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrge1-0001XA-BC
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:05:54 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrgdx-0005bj-PI
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:05:53 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56dc9955091so2562002a12.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 09:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712073947; x=1712678747; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DvijPh6kNQvCoFSeIBmTJDUL1uXvuBvXdUna/OBo6/w=;
 b=hCUkoWWGi3EDh7SphVCo9YIEOxWUd+le7eB17nglpNmPkF+lhgD2wIvfRAJFprkDaG
 WEehK38VaEamUIE1F0Ozfmi7CUSkSeXSsXeki/xxLuOfeYLjHrrXbtfm1Sm8gddP21EN
 bBVgrhx9fOtXychm1h4CI+H88MHsZELIa9Bi27i16urH51oTXqPF4SUUT0CcW3zxlqTV
 ppsGCAQCd+ypos/mpORdDgomCKHbFOrIzZojfS7BCDcmSpl83t0qLtsnsQnCJbxTWsRb
 FLXlFmp8HaC4oqmddk4FgGHw2FxgFGFFHPNZ036VBGEGNvRud7N0sq6m15PWIiG+gsmX
 1EPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712073947; x=1712678747;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DvijPh6kNQvCoFSeIBmTJDUL1uXvuBvXdUna/OBo6/w=;
 b=HN44sGOQiJhZbuHvRUNFL+OL6xhQFZgT+lN16fvx0pUL8YC5+Vm9XHAXZlLOYSEeJw
 RXAP0b0hP7XYEhDV72Vy+R5N2thmGq/9qavZqgxw2XGuxMmfR2uYF0333bjiTC28C4js
 vTZYyqugEmtXE9hXXBQsgjGmX8qxB1tWxaVkGQbS12ecE8tIbAkot1jp/M6ISP8aRccW
 sSvvXUfSYlQ9oT4RJpsJqPOZ34nIId8Hd1qd2IImXriV37B5OvZDCzjVGGi7Mllmw/hf
 XFRpceXVUQx5RkJrq0muxfh72gFOcnqIJtM3iYKqFkpACuHluVMV8BCZ/OCK8hXD3SYA
 XiGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNtT5b0l2kRsSdYYXbVBCHxfTMw5PP8bGAxDkaDVk1Aa5F0OgsLpPrrXp3euGeLvWxwM+8YjWOamn48MONDPiJEFmP+gY=
X-Gm-Message-State: AOJu0YywLRY8opC2imCnSgPpiIAH7cHzcT7grdToyI+a84nI2FPLgMc/
 +cH3tecqubktbv2TxDHth1T8lk8BAeUsHUNsLvItvPLpMLN87Jt3OtX88cxkFWCZjTh0BIvA3hV
 1XgeXlKqAAZhRKq3oo+qP/4P+ReLdZie7yLyGNQ==
X-Google-Smtp-Source: AGHT+IHN79t6JyLpeepGsKuS1jhUezYg5iMyt9Pcjmils/Df2gCidCGBMX3DiC0QmqLfEYLnzU7vgi72iDp/PDcNXEk=
X-Received: by 2002:a05:6402:350e:b0:56c:5ab5:5fb7 with SMTP id
 b14-20020a056402350e00b0056c5ab55fb7mr10150335edd.30.1712073947080; Tue, 02
 Apr 2024 09:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240330103128.3185962-1-ruanjinjie@huawei.com>
 <20240330103128.3185962-18-ruanjinjie@huawei.com>
In-Reply-To: <20240330103128.3185962-18-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2024 17:05:35 +0100
Message-ID: <CAFEAcA9=jEY9vj0bxrLBAtrYDJwwfQH=KK6BK3n7_9GvQnqygg@mail.gmail.com>
Subject: Re: [PATCH v11 17/23] hw/intc/arm_gicv3: Add NMI handling CPU
 interface registers
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, 30 Mar 2024 at 10:34, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Add the NMIAR CPU interface registers which deal with acknowledging NMI.
>
> When introduce NMI interrupt, there are some updates to the semantics for the
> register ICC_IAR1_EL1 and ICC_HPPIR1_EL1. For ICC_IAR1_EL1 register, it
> should return 1022 if the intid has non-maskable property. And for
> ICC_NMIAR1_EL1 register, it should return 1023 if the intid do not have
> non-maskable property. Howerever, these are not necessary for ICC_HPPIR1_EL1
> register.
>
> And the APR and RPR has NMI bits which should be handled correctly.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I have a few more comments below but otherwise I think this
patch is looking OK.


> @@ -898,12 +922,24 @@ static bool icc_hppi_can_preempt(GICv3CPUState *cs)
>       */
>      int rprio;
>      uint32_t mask;
> +    ARMCPU *cpu = ARM_CPU(cs->cpu);
> +    CPUARMState *env = &cpu->env;
>
>      if (icc_no_enabled_hppi(cs)) {
>          return false;
>      }
>
> -    if (cs->hppi.prio >= cs->icc_pmr_el1) {
> +    if (cs->gic->nmi_support && cs->hppi.nmi) {

If cs->hppi.nmi is set then nmi_support must be true, as we won't
ever set hppi.nmi if the GIC doesn't have NMI support (because the
registers where the guest can set the NMI bit will not be writeable
and so the nmi bits will always be zero). Elsewhere in the code
we assume this (eg in icc_iar1_read() below), so I think we can
also assume it here.

> +        if (!(cs->gic->gicd_ctlr & GICD_CTLR_DS) &&
> +            cs->hppi.grp == GICV3_G1NS) {
> +            if (cs->icc_pmr_el1 < 0x80) {
> +                return false;
> +            }
> +            if (arm_is_secure(env) && cs->icc_pmr_el1 == 0x80) {
> +                return false;
> +            }
> +        }
> +    } else if (cs->hppi.prio >= cs->icc_pmr_el1) {
>          /* Priority mask masks this interrupt */
>          return false;
>      }
> @@ -923,6 +959,18 @@ static bool icc_hppi_can_preempt(GICv3CPUState *cs)
>          return true;
>      }
>
> +    if (cs->gic->nmi_support && cs->hppi.nmi &&
> +        (cs->hppi.prio & mask) == (rprio & mask)) {
> +        if ((cs->hppi.grp == GICV3_G1NS) &&
> +            !(cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI)) {
> +            return true;
> +        }
> +        if ((cs->hppi.grp == GICV3_G1) &&
> +            !(cs->icc_apr[GICV3_G1][0] & ICC_AP1R_EL1_NMI)) {
> +            return true;
> +        }

You can write this part a bit more concisely:

           if (!(cs->icc_apr[cs->hppi.grp][0] & ICC_AP1R_EL1_NMI)) {
               return true;
           }

rather than writing out the G1 and G1NS cases separately.

> +    }
> +
>      return false;
>  }

> @@ -1159,13 +1212,16 @@ static uint64_t icc_iar0_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  static uint64_t icc_iar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
>      GICv3CPUState *cs = icc_cs_from_env(env);
> +    int el = arm_current_el(env);
>      uint64_t intid;
>
>      if (icv_access(env, HCR_IMO)) {
>          return icv_iar_read(env, ri);
>      }
>
> -    if (!icc_hppi_can_preempt(cs)) {
> +    if (cs->hppi.nmi && env->cp15.sctlr_el[el] & SCTLR_NMI) {
> +        intid = INTID_NMI;
> +    } else if (!icc_hppi_can_preempt(cs)) {
>          intid = INTID_SPURIOUS;
>      } else {
>          intid = icc_hppir1_value(cs, env);

This is the wrong order -- the cases where icc_hppi_can_preempt()
returns false need to take priority over the case where we return
INTID_NMI. You can get that by structuring it similarly to the
pseudocode:

    if (!icc_hppi_can_preempt(cs)) {
        intid = INTID_SPURIOUS;
    } else {
        intid = icc_hppir1_value(cs, env);
    }

    if (!gicv3_intid_is_special(intid)) {
        if (cs->hppi.nmi && env->cp15.sctlr_el[el] & SCTLR_NMI) {
            intid = INTID_NMI;
        } else {
            icc_activate_irq(cs, intid);
        }
    }

> @@ -1803,6 +1901,22 @@ static uint64_t icc_rpr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>          }
>      }
>
> +    if (cs->gic->nmi_support) {
> +        /* NMI info is reported in the high bits of RPR */
> +        if (arm_feature(env, ARM_FEATURE_EL3) && !arm_is_secure(env)) {
> +            if (cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI) {
> +                prio |= ICC_RPR_EL1_NSNMI;

This should be ICC_RPR_EL1_NMI. Compare the pseudocode for ICC_RPR_EL1:
in the EL3-nonsecure case we set pPriority<63>.

> +            }
> +        } else {
> +            if (cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI) {
> +                prio |= ICC_RPR_EL1_NSNMI;
> +            }
> +            if (cs->icc_apr[GICV3_G1][0] & ICC_AP1R_EL1_NMI) {
> +                prio |= ICC_RPR_EL1_NMI;
> +            }
> +        }
> +    }
> +
>      trace_gicv3_icc_rpr_read(gicv3_redist_affid(cs), prio);
>      return prio;
>  }

thanks
-- PMM

