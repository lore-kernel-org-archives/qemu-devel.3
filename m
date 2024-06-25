Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802EBC2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 02:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMG2g-0007Vu-Tf; Tue, 25 Jun 2024 19:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMG2R-0007HM-Ne; Tue, 25 Jun 2024 19:57:32 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMG1V-0007dj-Gc; Tue, 25 Jun 2024 19:57:17 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-80f4f7e6856so1452931241.2; 
 Tue, 25 Jun 2024 16:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719359654; x=1719964454; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CEGylT1U/+0jN4Bbh02dT4C2gKquZgy0l1y7q9E1Xq0=;
 b=bKECC4lJ15jmdJff/4eHN66Mh1+ZHbYjxZ6Mro6KmBqS9VcnVYOqDSYbvy+V8eT9/S
 FzZD1vDHpx7ZUtCKjZRGzmKa/471Lv4AHhS87UbC4N174V4f5cJ/V+ArjE+THaDVoYTB
 Srz9mY5uHO5Xg+DL/y0ICc/DvhHdhICLlx38XmAFq22DGO9VYFad/yz4Qc/PZ8nWrOtj
 BlZAWxJtTabzEVmtjAJUzFAg+D3sMWFhnW96D/Z8wtgfnNxxeNiRMc1LTniiOHnHSBwm
 pqDnW2sxhjtVG8r4VR+w1hPwj5/RpAdBhJcocR3YO9/NA8geYqtyrbqhN2PCZV5SnyM0
 WaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719359654; x=1719964454;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEGylT1U/+0jN4Bbh02dT4C2gKquZgy0l1y7q9E1Xq0=;
 b=IyC/X3hT3OWdbBvXc5gQnh7qzf0473gdkQY3fOKB0kLeCJja+lwxmZjnGL0mM8tEGL
 Amif/jlLbPOSpGhx5/srLFIRO6Mo7X8zzyiUGlL3sFMv7AUPa7pwDjzHpRVKpPrBeWJA
 VAy61jv63yI7Y+OKyTbweW0CLZtDl2CAJxxFuaQtHbLaRnYwC1DrPi0wARL6BI0YUF5Z
 cJ1GD3ZENVFFfVmBNeCTY2NUwbzyj76MPdtXtRLIbOjfEl0IvUDR0L4Ri/6Y3BhOqrTS
 eXpMGwUAnPyfSxdIPsz/qkB15y/+RminQmxKQs5sMtFIQKH2+qJsAFgiry9VDbHakyVd
 8I2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjVwz8JAkJru9eWXpqhg6JoUw35P1Aw2TGLU8v88i6tplfd+6k4LfzsuDl9yWTCrThl8FDrk7p7quAIOXu/DPIErV6am8=
X-Gm-Message-State: AOJu0YxP3F+DAod2EF4yh9foKJ/rBq86+j+SqsS//41JvpWh6eHtsdTf
 hUIgI4eXrdDl5hrBmyTLK7unzZBK6JWZGrAaVWfmIosIZwEJAPhJSsPKrWE1fctpkYYz5+fd/uH
 ABepvLAaSXgIH5I3Xpxv8cn0orms=
X-Google-Smtp-Source: AGHT+IEG/ioAcCm64SdRzB8xDLstuIYcczJeHN3KCLP2eZoTYDhLvzcn0floFtqC0iG4LAIgdFUbj6vZDkLsfrk5WSw=
X-Received: by 2002:a05:6102:5fc:b0:48f:147f:c022 with SMTP id
 ada2fe7eead31-48f4ef4c9a6mr8404372137.4.1719359654366; Tue, 25 Jun 2024
 16:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240625114629.27793-1-frank.chang@sifive.com>
 <20240625114629.27793-3-frank.chang@sifive.com>
In-Reply-To: <20240625114629.27793-3-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Jun 2024 09:53:48 +1000
Message-ID: <CAKmqyKOmr_RgFXS0W_+JG-uB+E8xxA6WLAEwmZn3y7Xan5P2rw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] target/riscv: Introduce extension implied rule
 helpers
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>, 
 Max Chou <max.chou@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Tue, Jun 25, 2024 at 9:47=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Introduce helpers to enable the extensions based on the implied rules.
> The implied extensions are enabled recursively, so we don't have to
> expand all of them manually. This also eliminates the old-fashioned
> ordering requirement. For example, Zvksg implies Zvks, Zvks implies
> Zvksed, etc., removing the need to check the implied rules of Zvksg
> before Zvks.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
> Tested-by: Max Chou <max.chou@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 121 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 121 insertions(+)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index eb6f7b9d12..1a3aef5bff 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -31,11 +31,17 @@
>  #include "hw/core/accel-cpu.h"
>  #include "hw/core/tcg-cpu-ops.h"
>  #include "tcg/tcg.h"
> +#ifndef CONFIG_USER_ONLY
> +#include "hw/boards.h"
> +#endif
>
>  /* Hash that stores user set extensions */
>  static GHashTable *multi_ext_user_opts;
>  static GHashTable *misa_ext_user_opts;
>
> +static GHashTable *multi_ext_implied_rules;
> +static GHashTable *misa_ext_implied_rules;
> +
>  static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
>  {
>      return g_hash_table_contains(multi_ext_user_opts,
> @@ -836,11 +842,117 @@ static void riscv_cpu_validate_profiles(RISCVCPU *=
cpu)
>      }
>  }
>
> +static void riscv_cpu_init_implied_exts_rules(void)
> +{
> +    RISCVCPUImpliedExtsRule *rule;
> +#ifndef CONFIG_USER_ONLY
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> +#endif
> +    static bool initialized;
> +    int i;
> +
> +    /* Implied rules only need to be initialized once. */
> +    if (initialized) {
> +        return;
> +    }
> +
> +    for (i =3D 0; (rule =3D riscv_misa_ext_implied_rules[i]); i++) {
> +#ifndef CONFIG_USER_ONLY
> +        rule->enabled =3D bitmap_new(ms->smp.cpus);
> +#endif
> +        g_hash_table_insert(misa_ext_implied_rules,
> +                            GUINT_TO_POINTER(rule->ext), (gpointer)rule)=
;
> +    }
> +
> +    for (i =3D 0; (rule =3D riscv_multi_ext_implied_rules[i]); i++) {
> +#ifndef CONFIG_USER_ONLY
> +        rule->enabled =3D bitmap_new(ms->smp.cpus);
> +#endif
> +        g_hash_table_insert(multi_ext_implied_rules,
> +                            GUINT_TO_POINTER(rule->ext), (gpointer)rule)=
;
> +    }
> +
> +    initialized =3D true;
> +}
> +
> +static void cpu_enable_implied_rule(RISCVCPU *cpu,
> +                                    RISCVCPUImpliedExtsRule *rule)
> +{
> +    CPURISCVState *env =3D &cpu->env;
> +    RISCVCPUImpliedExtsRule *ir;
> +    bool enabled =3D false;
> +    int i;
> +
> +#ifndef CONFIG_USER_ONLY
> +    enabled =3D test_bit(cpu->env.mhartid, rule->enabled);
> +#endif
> +
> +    if (!enabled) {
> +        /* Enable the implied MISAs. */
> +        if (rule->implied_misa_exts) {
> +            riscv_cpu_set_misa_ext(env,
> +                                   env->misa_ext | rule->implied_misa_ex=
ts);
> +
> +            for (i =3D 0; misa_bits[i] !=3D 0; i++) {
> +                if (rule->implied_misa_exts & misa_bits[i]) {
> +                    ir =3D g_hash_table_lookup(misa_ext_implied_rules,
> +                                             GUINT_TO_POINTER(misa_bits[=
i]));
> +
> +                    if (ir) {
> +                        cpu_enable_implied_rule(cpu, ir);
> +                    }
> +                }
> +            }
> +        }
> +
> +        /* Enable the implied extensions. */
> +        for (i =3D 0;
> +             rule->implied_multi_exts[i] !=3D RISCV_IMPLIED_EXTS_RULE_EN=
D; i++) {
> +            cpu_cfg_ext_auto_update(cpu, rule->implied_multi_exts[i], tr=
ue);
> +
> +            ir =3D g_hash_table_lookup(multi_ext_implied_rules,
> +                                     GUINT_TO_POINTER(
> +                                         rule->implied_multi_exts[i]));
> +
> +            if (ir) {
> +                cpu_enable_implied_rule(cpu, ir);
> +            }
> +        }
> +
> +#ifndef CONFIG_USER_ONLY
> +        bitmap_set(rule->enabled, cpu->env.mhartid, 1);
> +#endif
> +    }
> +}
> +
> +static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
> +{
> +    RISCVCPUImpliedExtsRule *rule;
> +    int i;
> +
> +    /* Enable the implied MISAs. */
> +    for (i =3D 0; (rule =3D riscv_misa_ext_implied_rules[i]); i++) {
> +        if (riscv_has_ext(&cpu->env, rule->ext)) {
> +            cpu_enable_implied_rule(cpu, rule);
> +        }
> +    }
> +
> +    /* Enable the implied extensions. */
> +    for (i =3D 0; (rule =3D riscv_multi_ext_implied_rules[i]); i++) {
> +        if (isa_ext_is_enabled(cpu, rule->ext)) {
> +            cpu_enable_implied_rule(cpu, rule);
> +        }
> +    }
> +}
> +
>  void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>  {
>      CPURISCVState *env =3D &cpu->env;
>      Error *local_err =3D NULL;
>
> +    riscv_cpu_init_implied_exts_rules();
> +    riscv_cpu_enable_implied_rules(cpu);
> +
>      riscv_cpu_validate_misa_priv(env, &local_err);
>      if (local_err !=3D NULL) {
>          error_propagate(errp, local_err);
> @@ -1346,6 +1458,15 @@ static void riscv_tcg_cpu_instance_init(CPUState *=
cs)
>
>      misa_ext_user_opts =3D g_hash_table_new(NULL, g_direct_equal);
>      multi_ext_user_opts =3D g_hash_table_new(NULL, g_direct_equal);
> +
> +    if (!misa_ext_implied_rules) {
> +        misa_ext_implied_rules =3D g_hash_table_new(NULL, g_direct_equal=
);
> +    }
> +
> +    if (!multi_ext_implied_rules) {
> +        multi_ext_implied_rules =3D g_hash_table_new(NULL, g_direct_equa=
l);
> +    }
> +
>      riscv_cpu_add_user_properties(obj);
>
>      if (riscv_cpu_has_max_extensions(obj)) {
> --
> 2.43.2
>
>

