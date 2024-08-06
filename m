Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E583C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 01:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb9Ja-0002P4-FQ; Mon, 05 Aug 2024 21:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb9JY-0002MP-0U; Mon, 05 Aug 2024 21:48:40 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb9JW-00027n-2h; Mon, 05 Aug 2024 21:48:39 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-4ef33a09a3aso55068e0c.2; 
 Mon, 05 Aug 2024 18:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722908915; x=1723513715; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjfhfCJrGAgF2c8vROOad89+jQoOYVHOZCA0PJ61H/0=;
 b=CmFWennqjeWiB8XERm3VZro4/yr37gwcpcbiehiAOoqTFrhUsAAgpHQQJuETRq4WBI
 sBn/ZmwATUxpdcnmwBQQ1JgU9gYHDZJiuepItLgYjd+vSVpg8hlTYF1BK83yCbycbCCR
 kKlLoQONdjS41Q29+6OfjDJp5UH9A4pXcwv+EAYhd1LOsfEjNTmsoW2yHJO2k63Rp28G
 WL9qEiW3dzSGlsHZrznotXBTQk+YFa9XyIFdNcxW+RhXKI8AEgD4PiI5rLEhR/A2Lkma
 F2P593LXEeIgh8sm2hAy+QFYxsnQZuoL5cvqZ9cTtnysk8pNxsZ3uonLePmA5w2t3Nqs
 rzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722908915; x=1723513715;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FjfhfCJrGAgF2c8vROOad89+jQoOYVHOZCA0PJ61H/0=;
 b=YsVpl+JIv9Hfcuy0zys1KhtCzMYJ8OM84fVzYBqsxeKdeS0DbiJz9hUxx291+8ztEz
 ATPJovpxk9c62g1qJyCQ88A7FbgnTqKtSmf5Hvpxbrz5BB++6qegoFr1iUy4rUnUFVwI
 vIxE3joBhzELPgJyjiKIpwa3OVPUkkRQs6/Pd6SXcdUTOo8cyasrRmzvVn4KppOhKbcb
 6djTyHYtymNTL7iC2uVY/eAungLZJX/xkXMKStpIazZbubKOyQGfYvO0jdXVZD0Nou0M
 1P0dsEx//mmCoGJxY/ZOi48VYjJn1/z3nu9S7HvDB8o9wrlX9oJYcpou6LAaFQBp++7D
 02AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU10k4UrHnjEkWDuXjmoQI2mlyC+JUmAqYJbXH69uTMP48LKXVM0L8YUJYMMWR6Bewlnhjm9isI0Hlk78N04I2AfXN8QtE=
X-Gm-Message-State: AOJu0YxdCvv5UcV97dN2GM6jjCTEBSvLhyeaxQoGJ0mU5hB82L/CKh6O
 5005TA2WDI9i08U549BKg99vg9/K2f+JgbsBi2X0WlwCOBB9QWK2uFChvjb9on7k4kUeeCrrCoE
 ABgSW+5MBJ6VlAwF4Q1uhHRWrLyI=
X-Google-Smtp-Source: AGHT+IFTEHK31O2eMgzARE7jyIwResIFAbw6a8XnZO63BXD0YEEe4521sRQLdiUe+L1bJd+vd+matlFtwa2hIUafhgE=
X-Received: by 2002:a05:6102:f10:b0:48f:40c1:3cd0 with SMTP id
 ada2fe7eead31-4945be0bbbdmr11466997137.12.1722908914557; Mon, 05 Aug 2024
 18:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-12-c4170a5348ca@rivosinc.com>
In-Reply-To: <20240723-counter_delegation-v2-12-c4170a5348ca@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 6 Aug 2024 11:48:08 +1000
Message-ID: <CAKmqyKNX2LDGBMqWE_Dxmi9Ko7YWxz0ODXxMJN7eeeYakO7pow@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] target/riscv: Add a preferred ISA extension rule
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Jul 24, 2024 at 9:32=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> In addition to the implied rule, a preferred rule will be useful
> where an ISA extension may require a list of ISA extension to be
> enabled to use all the features defined in that extension. All
> these extensions may not be implied in the ISA.

This seems practically the same as an implied rule, I'm not sure we
need a separate list of rules

Alistair

>
> This patch just introduces a new preferred rule which allows
> to enable multiple extensions together without burdening the qemu
> commandline user.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  target/riscv/cpu.c         |  4 ++++
>  target/riscv/cpu.h         | 17 ++++++++++++++
>  target/riscv/tcg/tcg-cpu.c | 57 ++++++++++++++++++++++++++++++++++++++++=
------
>  3 files changed, 71 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 393d1d67120e..22ba43c7ff2a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2665,6 +2665,10 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_r=
ules[] =3D {
>      NULL
>  };
>
> +RISCVCPUPreferredExtsRule *riscv_multi_ext_preferred_rules[] =3D {
> +    NULL
> +};
> +
>  static Property riscv_cpu_properties[] =3D {
>      DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index af25550a4a54..d775866344f5 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -142,10 +142,27 @@ typedef struct riscv_cpu_implied_exts_rule {
>      const uint32_t implied_multi_exts[];
>  } RISCVCPUImpliedExtsRule;
>
> +typedef struct riscv_cpu_preferred_exts_rule {
> +#ifndef CONFIG_USER_ONLY
> +    /*
> +     * Bitmask indicates the rule enabled status for the harts.
> +     * This enhancement is only available in system-mode QEMU,
> +     * as we don't have a good way (e.g. mhartid) to distinguish
> +     * the SMP cores in user-mode QEMU.
> +     */
> +    unsigned long *enabled;
> +#endif
> +    /* multi extension offset. */
> +    const uint32_t ext;
> +    const uint32_t preferred_multi_exts[];
> +} RISCVCPUPreferredExtsRule;
> +
>  extern RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[];
>  extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
> +extern RISCVCPUPreferredExtsRule *riscv_multi_ext_preferred_rules[];
>
>  #define RISCV_IMPLIED_EXTS_RULE_END -1
> +#define RISCV_PREFRRED_EXTS_RULE_END RISCV_IMPLIED_EXTS_RULE_END
>
>  #define MMU_USER_IDX 3
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 1c9a87029423..d8f74720815a 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -32,6 +32,7 @@
>  #include "hw/core/accel-cpu.h"
>  #include "hw/core/tcg-cpu-ops.h"
>  #include "tcg/tcg.h"
> +#include <stdio.h>
>  #ifndef CONFIG_USER_ONLY
>  #include "hw/boards.h"
>  #endif
> @@ -733,6 +734,7 @@ static void riscv_cpu_validate_profiles(RISCVCPU *cpu=
)
>  static void riscv_cpu_init_ext_rules(void)
>  {
>      RISCVCPUImpliedExtsRule *rule;
> +    RISCVCPUPreferredExtsRule *prule;
>  #ifndef CONFIG_USER_ONLY
>      MachineState *ms =3D MACHINE(qdev_get_machine());
>  #endif
> @@ -760,22 +762,40 @@ static void riscv_cpu_init_ext_rules(void)
>                              GUINT_TO_POINTER(rule->ext), (gpointer)rule)=
;
>      }
>
> +    for (i =3D 0; (prule =3D riscv_multi_ext_preferred_rules[i]); i++) {
> +#ifndef CONFIG_USER_ONLY
> +        prule->enabled =3D bitmap_new(ms->smp.cpus);
> +#endif
> +        g_hash_table_insert(multi_ext_enabling_rules,
> +                            GUINT_TO_POINTER(prule->ext), (gpointer)prul=
e);
> +    }
> +
>      initialized =3D true;
>  }
>
>  static void cpu_enable_ext_rule(RISCVCPU *cpu,
> -                                    RISCVCPUImpliedExtsRule *rule)
> +                                RISCVCPUImpliedExtsRule *rule,
> +                                RISCVCPUPreferredExtsRule *prule)
>  {
>      CPURISCVState *env =3D &cpu->env;
>      RISCVCPUImpliedExtsRule *ir;
> +    RISCVCPUPreferredExtsRule *pr;
>      bool enabled =3D false;
>      int i;
>
>  #ifndef CONFIG_USER_ONLY
> -    enabled =3D test_bit(cpu->env.mhartid, rule->enabled);
> +    if (rule) {
> +        enabled =3D test_bit(cpu->env.mhartid, rule->enabled);
> +    } else if (prule) {
> +        enabled =3D test_bit(cpu->env.mhartid, prule->enabled);
> +    } else {
> +        return;
> +    }
>  #endif
> +    if (enabled)
> +        return;
>
> -    if (!enabled) {
> +    if (rule) {
>          /* Enable the implied MISAs. */
>          if (rule->implied_misa_exts) {
>              riscv_cpu_set_misa_ext(env,
> @@ -787,7 +807,7 @@ static void cpu_enable_ext_rule(RISCVCPU *cpu,
>                                               GUINT_TO_POINTER(misa_bits[=
i]));
>
>                      if (ir) {
> -                        cpu_enable_ext_rule(cpu, ir);
> +                        cpu_enable_ext_rule(cpu, ir, NULL);
>                      }
>                  }
>              }
> @@ -803,12 +823,27 @@ static void cpu_enable_ext_rule(RISCVCPU *cpu,
>                                              rule->implied_multi_exts[i])=
);
>
>              if (ir) {
> -                cpu_enable_ext_rule(cpu, ir);
> +                cpu_enable_ext_rule(cpu, ir, NULL);
>              }
>          }
>
>  #ifndef CONFIG_USER_ONLY
>          bitmap_set(rule->enabled, cpu->env.mhartid, 1);
> +#endif
> +    } else if (prule) {
> +        /* Enable the preferred extensions. */
> +        for (i =3D 0;
> +          prule->preferred_multi_exts[i] !=3D RISCV_PREFRRED_EXTS_RULE_E=
ND; i++) {
> +            cpu_cfg_ext_auto_update(cpu, prule->preferred_multi_exts[i],=
 true);
> +            pr =3D g_hash_table_lookup(multi_ext_enabling_rules,
> +                                     GUINT_TO_POINTER(
> +                                     prule->preferred_multi_exts[i]));
> +            if (pr) {
> +                cpu_enable_ext_rule(cpu, NULL, prule);
> +            }
> +        }
> +#ifndef CONFIG_USER_ONLY
> +        bitmap_set(prule->enabled, cpu->env.mhartid, 1);
>  #endif
>      }
>  }
> @@ -847,6 +882,7 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu=
)
>  static void riscv_cpu_enable_ext_rules(RISCVCPU *cpu)
>  {
>      RISCVCPUImpliedExtsRule *rule;
> +    RISCVCPUPreferredExtsRule *prule;
>      int i;
>
>      /* Enable the implied extensions for Zc. */
> @@ -855,14 +891,21 @@ static void riscv_cpu_enable_ext_rules(RISCVCPU *cp=
u)
>      /* Enable the implied MISAs. */
>      for (i =3D 0; (rule =3D riscv_misa_ext_implied_rules[i]); i++) {
>          if (riscv_has_ext(&cpu->env, rule->ext)) {
> -            cpu_enable_ext_rule(cpu, rule);
> +            cpu_enable_ext_rule(cpu, rule, NULL);
>          }
>      }
>
>      /* Enable the implied extensions. */
>      for (i =3D 0; (rule =3D riscv_multi_ext_implied_rules[i]); i++) {
>          if (isa_ext_is_enabled(cpu, rule->ext)) {
> -            cpu_enable_ext_rule(cpu, rule);
> +            cpu_enable_ext_rule(cpu, rule, NULL);
> +        }
> +    }
> +
> +    /* Enable the preferred extensions. */
> +    for (i =3D 0; (prule =3D riscv_multi_ext_preferred_rules[i]); i++) {
> +        if (isa_ext_is_enabled(cpu, prule->ext)) {
> +            cpu_enable_ext_rule(cpu, NULL, prule);
>          }
>      }
>  }
>
> --
> 2.34.1
>
>

