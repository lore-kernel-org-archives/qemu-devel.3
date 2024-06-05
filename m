Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73738C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 06:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEkAt-0008OM-7H; Wed, 05 Jun 2024 02:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEkAq-0008NX-9x
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:31:04 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEkAo-00074O-BQ
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:31:03 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52b91f655d1so570978e87.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 23:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717569059; x=1718173859; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=umEcdQe2pceXQxrb0KFBV5aPvpdXBhJ/cp4yyKed1CQ=;
 b=O/KZ3WNvsHVGZkUrNtVwu5FxQNQSO4+Ps9LDKRlqeeWlOjnbj3lvBG+6xVY9DlRXsR
 ZAssRNP7Hhqqk65eB/N/OfSsfK6yf0QcIFxcO41H4A3Oin5WBTExKsvCuoyHquZJzwV2
 BPIl3QuUUgx198BPRmf+WGyhF8+58BNIMi6Hjth7QgTo0gYo4le30ZeGsGVoE13ub4KJ
 6L4ztv8+9QIFajne0hMPwsht9ah7v+BaZ7SGwQ2PX5B0aUkg7gTXE7HK/o55KqOSaGNS
 YQ6p5XNv6DDS32GzBlK6LBI0qbHg5y1idvKVRN/LOpkLWZVXBePfIAkG4UTGl2s1szCR
 5qpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717569059; x=1718173859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=umEcdQe2pceXQxrb0KFBV5aPvpdXBhJ/cp4yyKed1CQ=;
 b=Bx7q0hMRzWF9Uv2oT2FOjsC1o5qJYBnlrv3gKAsrG1xvFGnc/VqhvQ8JKttGe77BeD
 HT1nPuxVSZAa5SbdJWK7ie5npWzaUVQGQFzpVjuVfdpG72jUY3ZQ5sAAldhlTKSeeLKa
 6wdOIHTMYSDi8ap0zer/6Nd1dEjatNZr9KkO5mUFkcKmDdDt+Ppftp+fLt2SNrIkXe3Z
 1DF6lF+wAL4S0VNzNaaC6UX/EQpMLkTnzP7+wANbYbnLAOfWP+B4aqqc+ENLT8AKOTC6
 HGRNFabFB1FaEq3VPCF6kAv5w+Un+CWGNFpzwj0xzH+65U731evIbHrH43eWT7L88hr6
 S4UA==
X-Gm-Message-State: AOJu0Yw/ZeCQwUlniujjTOkQbwSWmU4wv3fZXTMpnsqdDqlFKfcqzKbH
 BbzWtc/dX8pcTBIngPLAid4lEvRyGBxXHX3XaYfcMB75Yovcwth4hRKwoSJUcceLllIFjEzpoqI
 X2vQoIsodT4udbM3FlWiH8fEfWPyiXQ2ysbJsVFaU/PGf15xdVNRCYoOd2bk7I9lfj42ieV7CzT
 UoMJaRLAaT5I9DxMxrct9r1UlNljyttzeOccC8S0wSsQ==
X-Google-Smtp-Source: AGHT+IEwqsVPFtpRPf2sRsokDx9q/buWDh0H5RfIMX4M1r73dZW26pcmib3VPhJ8Orh8asHBix2kXA==
X-Received: by 2002:a05:6512:3e16:b0:52b:9a7f:6152 with SMTP id
 2adb3069b0e04-52ba224067emr1595854e87.4.1717569059002; 
 Tue, 04 Jun 2024 23:30:59 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com.
 [209.85.208.179]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52b9793e3f3sm956122e87.47.2024.06.04.23.30.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 23:30:58 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-2eaa5cd9f0bso5295191fa.1; 
 Tue, 04 Jun 2024 23:30:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVYpkzESkfO6ebqSRczECqM9zNzuviNuT/TKJKJUUzwVJ7wX2mJxh4P+tt7cwGlCvTBIX9+MGEeHjElQa4WjEJr0HpOX/c=
X-Received: by 2002:a2e:9184:0:b0:2ea:a155:3320 with SMTP id
 38308e7fff4ca-2eabb804c60mr12336681fa.26.1717569058391; Tue, 04 Jun 2024
 23:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240603060522.2180-1-frank.chang@sifive.com>
 <20240603060522.2180-3-frank.chang@sifive.com>
In-Reply-To: <20240603060522.2180-3-frank.chang@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Wed, 5 Jun 2024 14:30:47 +0800
X-Gmail-Original-Message-ID: <CANzO1D0qxF35UGoLx9PxpXhPYJnw-o4cUCKdv+_GcjNV5_P6UQ@mail.gmail.com>
Message-ID: <CANzO1D0qxF35UGoLx9PxpXhPYJnw-o4cUCKdv+_GcjNV5_P6UQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] target/riscv: Introduce extension implied rule helpers
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

<frank.chang@sifive.com> =E6=96=BC 2024=E5=B9=B46=E6=9C=883=E6=97=A5 =E9=80=
=B1=E4=B8=80 =E4=B8=8B=E5=8D=882:06=E5=AF=AB=E9=81=93=EF=BC=9A
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
> ---
>  target/riscv/tcg/tcg-cpu.c | 84 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 683f604d9f..243a8547a2 100644
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
> @@ -833,11 +836,90 @@ static void riscv_cpu_validate_profiles(RISCVCPU *c=
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
> +    int i;
> +
> +    if (!rule->enabled) {

Sorry that I found that the rule is not properly applied to the
secondary cores when SMP > 1.
I will fix the issue and resend the patchset.

Regards,
Frank Chang

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
> +        rule->enabled =3D true;
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
> @@ -1343,6 +1425,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *c=
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

