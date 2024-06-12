Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E52C27C78
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 01:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHCg7-0002Ra-3D; Tue, 11 Jun 2024 21:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sHCg5-0002Qw-Kb
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 21:21:30 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sHCg3-0003Hz-IK
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 21:21:29 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57c7ec8f1fcso3902440a12.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 18:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718155286; x=1718760086; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wWWADvaiuk8PhDWff264JBS7tqCOmM8141hgpKxj/Xc=;
 b=ib3mMhExzmcTO6GOfk+emmvuB/eMgGGYdf86QIgplhYRTOqjXOoFJHfyfdl1qQvoxG
 XWUAkCsBPP3juHBTLHjPvObcO8sqimBiYd82LOUfXRuB1NCaDa00QhD9SVgND6aUyOJK
 yY/qFXwTTrs/7oWcQcrvZcphg2sgQI3kGUXXzxK5HkxHIfRM0ldvb/+Exz0laREtP6Sa
 rtYntxGFH4rp/rue4OynW3cLux2WOFCqjcNRpYbUiVvKXNqPpMYeUxUytpsaYaCSXruS
 l8K/NFr5Lp6MsSrovweLHB7cAfBBEC0iItVr1EfSPuURPXw6Nj2fkYz2oyeJ0gu7NnIF
 ludg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718155286; x=1718760086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wWWADvaiuk8PhDWff264JBS7tqCOmM8141hgpKxj/Xc=;
 b=mP+qlgmdIc//IUwGPPpqm0jQipceXejCJiO2SmpjC4TQHbKAd23ui8cAsvVurOxhi/
 ywSB7t7Tf3oMzGFOTUGwouSwrNyUEGbRoIhd/cgOVskJPTPDY+67OAwAQd5JZQJggFZs
 +VoXCoecW50HcsCJIXUgAXuLSGIiTWNqbLSQ5WYNQ+txqoXIARak1AUQ6ZP9nmUvCPFT
 2ELegTBI/LBcaEP3fKNdJRhECH3WGHv3U4WAoFM7hODYKBK1Dqhciw/tcbK6f0Jdkztk
 8UzjUD0ZhjIh8aiyGKZiR/7OaH6mRfDQCeMff28srXLNSTSESz2SuugO9i7BpwMxqqMC
 n0YA==
X-Gm-Message-State: AOJu0YxItN9PwrJCwiMSlpn4pli9kCN1shEO36OAEK2b/DFEz10Bx4yO
 b9feEYZxfiBv4xMvwS7/prRWf7o37dDhHlXr7iMXBEo2AZm3TROYUZ3HNOrrDg9XEbg2EmybHp4
 QFzwf1Sr/h9dWuq6Ceg5NegG4zB3Tt1/slKxpGbjXZEq9DDdq
X-Google-Smtp-Source: AGHT+IGOUTMVuyMAZ8rsYjxhVocpPZkKsPztx6/uzZi2RbkHYucybfGwi6I1kjmrhw4eKwlCaZ7iCMnsXV+FtLfn9f0=
X-Received: by 2002:a50:8703:0:b0:57c:5e65:1ff7 with SMTP id
 4fb4d7f45d1cf-57caaaf5726mr249022a12.39.1718155285670; Tue, 11 Jun 2024
 18:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240605063154.31298-1-frank.chang@sifive.com>
 <20240605063154.31298-3-frank.chang@sifive.com>
In-Reply-To: <20240605063154.31298-3-frank.chang@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Wed, 12 Jun 2024 09:21:15 +0800
Message-ID: <CAE_xrPiksW3QYQCd1EKuRs3xMBwjnPEOJdvi9tehVXmojy7Upw@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/6] target/riscv: Introduce extension implied rule
 helpers
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000078ce5a061aa733ab"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--00000000000078ce5a061aa733ab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 2:32=E2=80=AFPM <frank.chang@sifive.com> wrote:

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
> ---
>  target/riscv/tcg/tcg-cpu.c | 89 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 683f604d9f..899d605d36 100644
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
> @@ -833,11 +836,95 @@ static void riscv_cpu_validate_profiles(RISCVCPU
> *cpu)
>      }
>  }
>
> +static void riscv_cpu_init_implied_exts_rules(void)
> +{
> +    RISCVCPUImpliedExtsRule *rule;
> +    int i;
> +
> +    for (i =3D 0; (rule =3D riscv_misa_implied_rules[i]); i++) {
> +        g_hash_table_insert(misa_implied_rules,
> GUINT_TO_POINTER(rule->ext),
> +                            (gpointer)rule);
> +    }
> +
> +    for (i =3D 0; (rule =3D riscv_ext_implied_rules[i]); i++) {
> +        g_hash_table_insert(ext_implied_rules,
> GUINT_TO_POINTER(rule->ext),
> +                            (gpointer)rule);
> +    }
> +}
> +
> +static void cpu_enable_implied_rule(RISCVCPU *cpu,
> +                                    RISCVCPUImpliedExtsRule *rule)
> +{
> +    CPURISCVState *env =3D &cpu->env;
> +    RISCVCPUImpliedExtsRule *ir;
> +    target_ulong hartid =3D 0;
> +    int i;
> +
> +#if !defined(CONFIG_USER_ONLY)
> +    hartid =3D env->mhartid;
> +#endif
> +
> +    if (!(rule->enabled & BIT_ULL(hartid))) {
> +        /* Enable the implied MISAs. */
> +        if (rule->implied_misas) {
> +            riscv_cpu_set_misa_ext(env, env->misa_ext |
> rule->implied_misas);
> +
> +            for (i =3D 0; misa_bits[i] !=3D 0; i++) {
> +                if (rule->implied_misas & misa_bits[i]) {
> +                    ir =3D g_hash_table_lookup(misa_implied_rules,
> +
>  GUINT_TO_POINTER(misa_bits[i]));
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
_END;
> i++) {
> +            cpu_cfg_ext_auto_update(cpu, rule->implied_exts[i], true);
> +
> +            ir =3D g_hash_table_lookup(ext_implied_rules,
> +
>  GUINT_TO_POINTER(rule->implied_exts[i]));
> +
> +            if (ir) {
> +                cpu_enable_implied_rule(cpu, ir);
> +            }
> +        }
> +
> +        rule->enabled |=3D BIT_ULL(hartid);
>

Should I use the qatomic API here to set the enabled bitmask?

This wouldn't impact the results but it may cause the implied rules
to be traversed and re-enabled (which has no harm) if the enabled bit
of a hart is accidentally cleared by another harts.


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
> @@ -1343,6 +1430,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *c=
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

--00000000000078ce5a061aa733ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Jun 5, 2024 at 2:32=E2=80=AFPM &l=
t;<a href=3D"mailto:frank.chang@sifive.com">frank.chang@sifive.com</a>&gt; =
wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifiv=
e.com" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
<br>
Introduce helpers to enable the extensions based on the implied rules.<br>
The implied extensions are enabled recursively, so we don&#39;t have to<br>
expand all of them manually. This also eliminates the old-fashioned<br>
ordering requirement. For example, Zvksg implies Zvks, Zvks implies<br>
Zvksed, etc., removing the need to check the implied rules of Zvksg<br>
before Zvks.<br>
<br>
Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" ta=
rget=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
---<br>
=C2=A0target/riscv/tcg/tcg-cpu.c | 89 +++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 89 insertions(+)<br>
<br>
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c<br>
index 683f604d9f..899d605d36 100644<br>
--- a/target/riscv/tcg/tcg-cpu.c<br>
+++ b/target/riscv/tcg/tcg-cpu.c<br>
@@ -36,6 +36,9 @@<br>
=C2=A0static GHashTable *multi_ext_user_opts;<br>
=C2=A0static GHashTable *misa_ext_user_opts;<br>
<br>
+static GHashTable *misa_implied_rules;<br>
+static GHashTable *ext_implied_rules;<br>
+<br>
=C2=A0static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0return g_hash_table_contains(multi_ext_user_opts,<br>
@@ -833,11 +836,95 @@ static void riscv_cpu_validate_profiles(RISCVCPU *cpu=
)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+static void riscv_cpu_init_implied_exts_rules(void)<br>
+{<br>
+=C2=A0 =C2=A0 RISCVCPUImpliedExtsRule *rule;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; (rule =3D riscv_misa_implied_rules[i]); i++) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_hash_table_insert(misa_implied_rules, GUINT_=
TO_POINTER(rule-&gt;ext),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (gpointer)rule);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; (rule =3D riscv_ext_implied_rules[i]); i++) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_hash_table_insert(ext_implied_rules, GUINT_T=
O_POINTER(rule-&gt;ext),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (gpointer)rule);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void cpu_enable_implied_rule(RISCVCPU *cpu,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCVCPUImpliedExtsRul=
e *rule)<br>
+{<br>
+=C2=A0 =C2=A0 CPURISCVState *env =3D &amp;cpu-&gt;env;<br>
+=C2=A0 =C2=A0 RISCVCPUImpliedExtsRule *ir;<br>
+=C2=A0 =C2=A0 target_ulong hartid =3D 0;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+#if !defined(CONFIG_USER_ONLY)<br>
+=C2=A0 =C2=A0 hartid =3D env-&gt;mhartid;<br>
+#endif<br>
+<br>
+=C2=A0 =C2=A0 if (!(rule-&gt;enabled &amp; BIT_ULL(hartid))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Enable the implied MISAs. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rule-&gt;implied_misas) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_cpu_set_misa_ext(env, env-=
&gt;misa_ext | rule-&gt;implied_misas);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; misa_bits[i] !=3D =
0; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rule-&gt;impli=
ed_misas &amp; misa_bits[i]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ir =
=3D g_hash_table_lookup(misa_implied_rules,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0GUINT_TO_POINTER(misa_bits[i]));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
ir) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cpu_enable_implied_rule(cpu, ir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Enable the implied extensions. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; rule-&gt;implied_exts[i] !=3D RI=
SCV_IMPLIED_EXTS_RULE_END; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_cfg_ext_auto_update(cpu, rul=
e-&gt;implied_exts[i], true);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ir =3D g_hash_table_lookup(ext_i=
mplied_rules,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GUINT_TO_POINTER=
(rule-&gt;implied_exts[i]));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ir) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_enable_implied=
_rule(cpu, ir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rule-&gt;enabled |=3D BIT_ULL(hartid);<br></bl=
ockquote><div><br></div><div>Should I use the qatomic=C2=A0API here to set =
the enabled bitmask?</div><div><br></div><div>This wouldn&#39;t impact the =
results but it may cause the implied rules</div><div>to be traversed and re=
-enabled (which has no harm) if the enabled bit</div><div>of a hart is acci=
dentally cleared by another harts.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)<br>
+{<br>
+=C2=A0 =C2=A0 RISCVCPUImpliedExtsRule *rule;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 /* Enable the implied MISAs. */<br>
+=C2=A0 =C2=A0 for (i =3D 0; (rule =3D riscv_misa_implied_rules[i]); i++) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (riscv_has_ext(&amp;cpu-&gt;env, rule-&gt;e=
xt)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_enable_implied_rule(cpu, rul=
e);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Enable the implied extensions. */<br>
+=C2=A0 =C2=A0 for (i =3D 0; (rule =3D riscv_ext_implied_rules[i]); i++) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isa_ext_is_enabled(cpu, rule-&gt;ext)) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_enable_implied_rule(cpu, rul=
e);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPURISCVState *env =3D &amp;cpu-&gt;env;<br>
=C2=A0 =C2=A0 =C2=A0Error *local_err =3D NULL;<br>
<br>
+=C2=A0 =C2=A0 riscv_cpu_init_implied_exts_rules();<br>
+=C2=A0 =C2=A0 riscv_cpu_enable_implied_rules(cpu);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0riscv_cpu_validate_misa_priv(env, &amp;local_err);<br>
=C2=A0 =C2=A0 =C2=A0if (local_err !=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_propagate(errp, local_err);<br>
@@ -1343,6 +1430,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0misa_ext_user_opts =3D g_hash_table_new(NULL, g_direct_=
equal);<br>
=C2=A0 =C2=A0 =C2=A0multi_ext_user_opts =3D g_hash_table_new(NULL, g_direct=
_equal);<br>
+=C2=A0 =C2=A0 misa_implied_rules =3D g_hash_table_new(NULL, g_direct_equal=
);<br>
+=C2=A0 =C2=A0 ext_implied_rules =3D g_hash_table_new(NULL, g_direct_equal)=
;<br>
=C2=A0 =C2=A0 =C2=A0riscv_cpu_add_user_properties(obj);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (riscv_cpu_has_max_extensions(obj)) {<br>
-- <br>
2.43.2<br>
<br>
</blockquote></div></div>

--00000000000078ce5a061aa733ab--

