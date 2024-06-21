Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAABFC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 04:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKVg6-0002fh-6j; Fri, 21 Jun 2024 00:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sKVg4-0002ev-9E; Fri, 21 Jun 2024 00:15:08 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sKVg1-0006r2-O9; Fri, 21 Jun 2024 00:15:07 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4ef267f2912so1166566e0c.0; 
 Thu, 20 Jun 2024 21:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718943304; x=1719548104; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=feKj/EM+n6H2oGbfWdudtspX7KyFCArbep3r+d8bU2s=;
 b=U7Fasl7nvOpFWUZl7dbbhq5TK7Hr75+b352G2h33o7zkSyH1cGDJRbHFc9Cy8rIgoI
 O34VVrnZzLRN2JXNcjwk9pqOuOe3ih+LBxxO3TjXAix9dvMV/x5RzvaMqPs9fepPPLOD
 x13wGe+PhHfAvCXfRmWvuAOYkw+4dKRqTb0Sbi4WLUYlBINYib5B0xY8V10C7Lg+OPhT
 Rd9ftZCMbMeh0Sc8HKIPVGX8TQwsUlE6Hj0dkDhFoMo98eeQMsbQUpJ44tx1YfW5zR6u
 1rrGF5ksvEYnXI3R6VklglsZhRszGJ/X5t0XLGomCPfbGSIH0CtJlAa5W1eGgmlQMfjH
 VSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718943304; x=1719548104;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=feKj/EM+n6H2oGbfWdudtspX7KyFCArbep3r+d8bU2s=;
 b=dz9NmetzvHjddWSGNseAq7u2ahSn80nD3O6l3qxo59dkzek/XUnWVjmuo+LqwgYmwy
 SfxfkZjDQRKZx6FIH9ROSKX5t/1LbXJBhGv3Jv1W22bYCaJf7J8iC5YLLNaWuATItrOk
 fusZhe7Vy3S9zrDoyQe0zMHtwdEc2qhO20RvJ60J8WFX/vMals815197WflD9URY8vjP
 Sxh9jaIUziYk3JxVuVTKzZ3ckKseu1jRlMclAURikMMEfC1mGnDW5ucqX9mJJD0JBlfZ
 MtTTZGKZmXayL/aet5cIrqbNcbPgfEopYIt+IKsv0CtjRA7NmYKqBCkUBE2ieLgzeEGc
 vp8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN0uGk2FawfIh9A1Agm2UEPeZyebrOZQrwvgWUrrXd4F7I4R85U07qL8eEISN2B3LrydWdf2I8NQMwo57PVyHQoCHI/yk=
X-Gm-Message-State: AOJu0YyWU2KO63r7JarEpGpjalp9iOsZREmFa4LarG75vSPblAYpE9Ny
 9lNl4V/Se++0QLW8oiZHqkRSvM7VV0QqBTskP3Zb1N2cTpoTlrjYl6bR+6kZJQBHqPcWBsHveaz
 05Hu+iyDAlrRNeT2X7cUV/ZTIFuw=
X-Google-Smtp-Source: AGHT+IGamiyOxdZd8uBdx/TJvR6ytC3QFFoLyzqo/0jai0qiLvD1saiDr4Hl3i/ThNM3zBY5oNsVXWlR7bVUx4WajRg=
X-Received: by 2002:a05:6122:3108:b0:4eb:1d6b:7a6d with SMTP id
 71dfb90a1353d-4ef1ab2f813mr10208064e0c.7.1718943304024; Thu, 20 Jun 2024
 21:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240616024657.17948-1-frank.chang@sifive.com>
 <20240616024657.17948-3-frank.chang@sifive.com>
In-Reply-To: <20240616024657.17948-3-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 21 Jun 2024 14:14:36 +1000
Message-ID: <CAKmqyKOVg=KND_YER=b61gFAUX8yk6SHZvxiNxKuKoPH1_8wnA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] target/riscv: Introduce extension implied rule
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sun, Jun 16, 2024 at 12:48=E2=80=AFPM <frank.chang@sifive.com> wrote:
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
> ---
>  target/riscv/tcg/tcg-cpu.c | 91 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index eb6f7b9d12..f8d6371764 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -36,6 +36,9 @@
>  static GHashTable *multi_ext_user_opts;
>  static GHashTable *misa_ext_user_opts;
>
> +static GHashTable *misa_implied_rules;
> +static GHashTable *ext_implied_rules;
> +
>  static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
>  {
>      return g_hash_table_contains(multi_ext_user_opts,
> @@ -836,11 +839,97 @@ static void riscv_cpu_validate_profiles(RISCVCPU *c=
pu)
>      }
>  }
>
> +static void riscv_cpu_init_implied_exts_rules(void)
> +{
> +    RISCVCPUImpliedExtsRule *rule;
> +    int i;
> +
> +    for (i =3D 0; (rule =3D riscv_misa_implied_rules[i]); i++) {
> +        g_hash_table_insert(misa_implied_rules, GUINT_TO_POINTER(rule->e=
xt),
> +                            (gpointer)rule);
> +    }
> +
> +    for (i =3D 0; (rule =3D riscv_ext_implied_rules[i]); i++) {
> +        g_hash_table_insert(ext_implied_rules, GUINT_TO_POINTER(rule->ex=
t),
> +                            (gpointer)rule);
> +    }
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
> +    enabled =3D qatomic_read(&rule->enabled) & BIT_ULL(cpu->env.mhartid)=
;

enabled is a uint64_t, so this limits us to 64 harts right?

The virt machine currently has a limit of 512, so this won't work right?

Alistair

> +#endif
> +
> +    if (!enabled) {
> +        /* Enable the implied MISAs. */
> +        if (rule->implied_misas) {
> +            riscv_cpu_set_misa_ext(env, env->misa_ext | rule->implied_mi=
sas);
> +
> +            for (i =3D 0; misa_bits[i] !=3D 0; i++) {
> +                if (rule->implied_misas & misa_bits[i]) {
> +                    ir =3D g_hash_table_lookup(misa_implied_rules,
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
> +        for (i =3D 0; rule->implied_exts[i] !=3D RISCV_IMPLIED_EXTS_RULE=
_END; i++) {
> +            cpu_cfg_ext_auto_update(cpu, rule->implied_exts[i], true);
> +
> +            ir =3D g_hash_table_lookup(ext_implied_rules,
> +                                     GUINT_TO_POINTER(rule->implied_exts=
[i]));
> +
> +            if (ir) {
> +                cpu_enable_implied_rule(cpu, ir);
> +            }
> +        }
> +
> +#ifndef CONFIG_USER_ONLY
> +        qatomic_or(&rule->enabled, BIT_ULL(cpu->env.mhartid));
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
> +    for (i =3D 0; (rule =3D riscv_misa_implied_rules[i]); i++) {
> +        if (riscv_has_ext(&cpu->env, rule->ext)) {
> +            cpu_enable_implied_rule(cpu, rule);
> +        }
> +    }
> +
> +    /* Enable the implied extensions. */
> +    for (i =3D 0; (rule =3D riscv_ext_implied_rules[i]); i++) {
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
> @@ -1346,6 +1435,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *c=
s)
>
>      misa_ext_user_opts =3D g_hash_table_new(NULL, g_direct_equal);
>      multi_ext_user_opts =3D g_hash_table_new(NULL, g_direct_equal);
> +    misa_implied_rules =3D g_hash_table_new(NULL, g_direct_equal);
> +    ext_implied_rules =3D g_hash_table_new(NULL, g_direct_equal);
>      riscv_cpu_add_user_properties(obj);
>
>      if (riscv_cpu_has_max_extensions(obj)) {
> --
> 2.43.2
>
>

