Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74237C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 06:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKY6x-0006gO-W1; Fri, 21 Jun 2024 02:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sKY6w-0006fw-9n
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 02:51:02 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sKY6t-0003HJ-NU
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 02:51:02 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57d1012e52fso1802601a12.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 23:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718952658; x=1719557458; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PkX5Q3gJbgqn4dlu9z28iZs7sw8W3cChZ8y9pqqxBh8=;
 b=QbuqUIwWDR9fBENnxg3QHgQAcI5yhK2+Cj0R5NHDh7SWlG4/fW2BS1jM/CuZ5KBYLS
 +r2mqhkHldqmlbTpPpOCek85qSjRmJ5lcT9mDrFjRYgM6h3H46CvV1WbdwUS0LLRSdPg
 Z3oaoenRWEskj22DTNjy6zbPY43+h1XA+CtUjr+aeLwZgnNgPnYsnIRZ3phdbtU+dErG
 ZA42T3CwKmi7WlG7OGtSLgdpvY2Ex6VTamOC+hezQtNRm5LlM00pQflHP2c+Iqv4nBX0
 2HivfeNKuU+sUgtYVcPJZL42YqctN3mWpLc3qH8+YAz0IFKm9ffpuB5/0/Wa76uUyMMK
 PEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718952658; x=1719557458;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PkX5Q3gJbgqn4dlu9z28iZs7sw8W3cChZ8y9pqqxBh8=;
 b=vCgF9vlQUssKD9/Abz5TaLG9LZt+x6iiRXw5JZGGhdHix8AQclDc0aBlBOsCHIle5a
 Sn3/6JvHiIQkFgInzkerNUPRf2zxtBbllsWLIzm8+LOlfBWsfa4b8GZ4t1xZdhKXX87A
 TVOXYoO+Rv/py3KoxjcAfR1YSzoGBv0epMx/oT0J9+Cw+5jshOhZ8r3mYt7zVmH0eesU
 NLQZisfca8EcCaR469egHEdQMSe1lEuT9rlElsv32mL25A1apruScVgoQna9Vwb+jJcX
 eI4yJ/l7pASgFHw3KOz/zS8ZdhcBn51m8Yc4HZt7Enb+T9ZlqmG84UJh5J4ERqpfQWU/
 RdSg==
X-Gm-Message-State: AOJu0YwuRBvLyDDPlQI5aIy9FQlRF/Fho+rH5tvga9SAJIPjoS0Rjtna
 CqVtsufSdAL1GuG81AcgStxMFFop7dlOFkcPh8Fj8eh9bg+yaWhVYYNqV3/BgSJte6w3ZObR3ko
 36iln5yGOlaniUlMhzDkq9FzS5EF5MR6okr1NUw==
X-Google-Smtp-Source: AGHT+IH/Hndw4pP+r5hH9n5IgWY/p7/iD3n/lef7LF6bohd8Nse2kVmnYlQEdB//+a1kDaaGhX48SAz4q2NVw59JC+I=
X-Received: by 2002:a50:c014:0:b0:57c:935d:2881 with SMTP id
 4fb4d7f45d1cf-57d07eb274bmr5450735a12.32.1718952657759; Thu, 20 Jun 2024
 23:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240616024657.17948-1-frank.chang@sifive.com>
 <20240616024657.17948-3-frank.chang@sifive.com>
 <CAKmqyKOVg=KND_YER=b61gFAUX8yk6SHZvxiNxKuKoPH1_8wnA@mail.gmail.com>
In-Reply-To: <CAKmqyKOVg=KND_YER=b61gFAUX8yk6SHZvxiNxKuKoPH1_8wnA@mail.gmail.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 21 Jun 2024 14:50:45 +0800
Message-ID: <CAE_xrPijscrtEtV=+SeKyd0XwnfC4FbcyBfSTNh4wakUZno+Xg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] target/riscv: Introduce extension implied rule
 helpers
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>, 
 Max Chou <max.chou@sifive.com>
Content-Type: multipart/alternative; boundary="0000000000008d7c7a061b60dad6"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x536.google.com
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

--0000000000008d7c7a061b60dad6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 12:15=E2=80=AFPM Alistair Francis <alistair23@gmail=
.com>
wrote:

> On Sun, Jun 16, 2024 at 12:48=E2=80=AFPM <frank.chang@sifive.com> wrote:
> >
> > From: Frank Chang <frank.chang@sifive.com>
> >
> > Introduce helpers to enable the extensions based on the implied rules.
> > The implied extensions are enabled recursively, so we don't have to
> > expand all of them manually. This also eliminates the old-fashioned
> > ordering requirement. For example, Zvksg implies Zvks, Zvks implies
> > Zvksed, etc., removing the need to check the implied rules of Zvksg
> > before Zvks.
> >
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
> > Tested-by: Max Chou <max.chou@sifive.com>
> > ---
> >  target/riscv/tcg/tcg-cpu.c | 91 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >
> > diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> > index eb6f7b9d12..f8d6371764 100644
> > --- a/target/riscv/tcg/tcg-cpu.c
> > +++ b/target/riscv/tcg/tcg-cpu.c
> > @@ -36,6 +36,9 @@
> >  static GHashTable *multi_ext_user_opts;
> >  static GHashTable *misa_ext_user_opts;
> >
> > +static GHashTable *misa_implied_rules;
> > +static GHashTable *ext_implied_rules;
> > +
> >  static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
> >  {
> >      return g_hash_table_contains(multi_ext_user_opts,
> > @@ -836,11 +839,97 @@ static void riscv_cpu_validate_profiles(RISCVCPU
> *cpu)
> >      }
> >  }
> >
> > +static void riscv_cpu_init_implied_exts_rules(void)
> > +{
> > +    RISCVCPUImpliedExtsRule *rule;
> > +    int i;
> > +
> > +    for (i =3D 0; (rule =3D riscv_misa_implied_rules[i]); i++) {
> > +        g_hash_table_insert(misa_implied_rules,
> GUINT_TO_POINTER(rule->ext),
> > +                            (gpointer)rule);
> > +    }
> > +
> > +    for (i =3D 0; (rule =3D riscv_ext_implied_rules[i]); i++) {
> > +        g_hash_table_insert(ext_implied_rules,
> GUINT_TO_POINTER(rule->ext),
> > +                            (gpointer)rule);
> > +    }
> > +}
> > +
> > +static void cpu_enable_implied_rule(RISCVCPU *cpu,
> > +                                    RISCVCPUImpliedExtsRule *rule)
> > +{
> > +    CPURISCVState *env =3D &cpu->env;
> > +    RISCVCPUImpliedExtsRule *ir;
> > +    bool enabled =3D false;
> > +    int i;
> > +
> > +#ifndef CONFIG_USER_ONLY
> > +    enabled =3D qatomic_read(&rule->enabled) & BIT_ULL(cpu->env.mharti=
d);
>
> enabled is a uint64_t, so this limits us to 64 harts right?
>
> The virt machine currently has a limit of 512, so this won't work right?
>
> Alistair
>

Yes, that's true.
Though it wouldn't impact the result as this is just the optimization
of not iterating the rules that have been applied already.

Maybe I can replace it with the dynamic hart bitmask.

Regards,
Frank Chang


>
> > +#endif
> > +
> > +    if (!enabled) {
> > +        /* Enable the implied MISAs. */
> > +        if (rule->implied_misas) {
> > +            riscv_cpu_set_misa_ext(env, env->misa_ext |
> rule->implied_misas);
> > +
> > +            for (i =3D 0; misa_bits[i] !=3D 0; i++) {
> > +                if (rule->implied_misas & misa_bits[i]) {
> > +                    ir =3D g_hash_table_lookup(misa_implied_rules,
> > +
>  GUINT_TO_POINTER(misa_bits[i]));
> > +
> > +                    if (ir) {
> > +                        cpu_enable_implied_rule(cpu, ir);
> > +                    }
> > +                }
> > +            }
> > +        }
> > +
> > +        /* Enable the implied extensions. */
> > +        for (i =3D 0; rule->implied_exts[i] !=3D
> RISCV_IMPLIED_EXTS_RULE_END; i++) {
> > +            cpu_cfg_ext_auto_update(cpu, rule->implied_exts[i], true);
> > +
> > +            ir =3D g_hash_table_lookup(ext_implied_rules,
> > +
>  GUINT_TO_POINTER(rule->implied_exts[i]));
> > +
> > +            if (ir) {
> > +                cpu_enable_implied_rule(cpu, ir);
> > +            }
> > +        }
> > +
> > +#ifndef CONFIG_USER_ONLY
> > +        qatomic_or(&rule->enabled, BIT_ULL(cpu->env.mhartid));
> > +#endif
> > +    }
> > +}
> > +
> > +static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
> > +{
> > +    RISCVCPUImpliedExtsRule *rule;
> > +    int i;
> > +
> > +    /* Enable the implied MISAs. */
> > +    for (i =3D 0; (rule =3D riscv_misa_implied_rules[i]); i++) {
> > +        if (riscv_has_ext(&cpu->env, rule->ext)) {
> > +            cpu_enable_implied_rule(cpu, rule);
> > +        }
> > +    }
> > +
> > +    /* Enable the implied extensions. */
> > +    for (i =3D 0; (rule =3D riscv_ext_implied_rules[i]); i++) {
> > +        if (isa_ext_is_enabled(cpu, rule->ext)) {
> > +            cpu_enable_implied_rule(cpu, rule);
> > +        }
> > +    }
> > +}
> > +
> >  void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
> >  {
> >      CPURISCVState *env =3D &cpu->env;
> >      Error *local_err =3D NULL;
> >
> > +    riscv_cpu_init_implied_exts_rules();
> > +    riscv_cpu_enable_implied_rules(cpu);
> > +
> >      riscv_cpu_validate_misa_priv(env, &local_err);
> >      if (local_err !=3D NULL) {
> >          error_propagate(errp, local_err);
> > @@ -1346,6 +1435,8 @@ static void riscv_tcg_cpu_instance_init(CPUState
> *cs)
> >
> >      misa_ext_user_opts =3D g_hash_table_new(NULL, g_direct_equal);
> >      multi_ext_user_opts =3D g_hash_table_new(NULL, g_direct_equal);
> > +    misa_implied_rules =3D g_hash_table_new(NULL, g_direct_equal);
> > +    ext_implied_rules =3D g_hash_table_new(NULL, g_direct_equal);
> >      riscv_cpu_add_user_properties(obj);
> >
> >      if (riscv_cpu_has_max_extensions(obj)) {
> > --
> > 2.43.2
> >
> >
>

--0000000000008d7c7a061b60dad6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Jun 21, 2024 at 12:15=E2=80=AFPM =
Alistair Francis &lt;<a href=3D"mailto:alistair23@gmail.com">alistair23@gma=
il.com</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Sun, Jun 16, 2024 at 12:48=E2=80=AFPM &=
lt;<a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">frank.chang@=
sifive.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=
=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt;<br>
&gt; Introduce helpers to enable the extensions based on the implied rules.=
<br>
&gt; The implied extensions are enabled recursively, so we don&#39;t have t=
o<br>
&gt; expand all of them manually. This also eliminates the old-fashioned<br=
>
&gt; ordering requirement. For example, Zvksg implies Zvks, Zvks implies<br=
>
&gt; Zvksed, etc., removing the need to check the implied rules of Zvksg<br=
>
&gt; before Zvks.<br>
&gt;<br>
&gt; Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.co=
m" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Jerry Zhang Jian &lt;<a href=3D"mailto:jerry.zhangjian@si=
five.com" target=3D"_blank">jerry.zhangjian@sifive.com</a>&gt;<br>
&gt; Tested-by: Max Chou &lt;<a href=3D"mailto:max.chou@sifive.com" target=
=3D"_blank">max.chou@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/tcg/tcg-cpu.c | 91 ++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 1 file changed, 91 insertions(+)<br>
&gt;<br>
&gt; diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c<b=
r>
&gt; index eb6f7b9d12..f8d6371764 100644<br>
&gt; --- a/target/riscv/tcg/tcg-cpu.c<br>
&gt; +++ b/target/riscv/tcg/tcg-cpu.c<br>
&gt; @@ -36,6 +36,9 @@<br>
&gt;=C2=A0 static GHashTable *multi_ext_user_opts;<br>
&gt;=C2=A0 static GHashTable *misa_ext_user_opts;<br>
&gt;<br>
&gt; +static GHashTable *misa_implied_rules;<br>
&gt; +static GHashTable *ext_implied_rules;<br>
&gt; +<br>
&gt;=C2=A0 static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return g_hash_table_contains(multi_ext_user_opts,<=
br>
&gt; @@ -836,11 +839,97 @@ static void riscv_cpu_validate_profiles(RISCVCPU=
 *cpu)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static void riscv_cpu_init_implied_exts_rules(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 RISCVCPUImpliedExtsRule *rule;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; (rule =3D riscv_misa_implied_rules[i]); i=
++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_hash_table_insert(misa_implied_rules, G=
UINT_TO_POINTER(rule-&gt;ext),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (gpointer)rule);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; (rule =3D riscv_ext_implied_rules[i]); i+=
+) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_hash_table_insert(ext_implied_rules, GU=
INT_TO_POINTER(rule-&gt;ext),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (gpointer)rule);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void cpu_enable_implied_rule(RISCVCPU *cpu,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCVCPUImpliedExt=
sRule *rule)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 CPURISCVState *env =3D &amp;cpu-&gt;env;<br>
&gt; +=C2=A0 =C2=A0 RISCVCPUImpliedExtsRule *ir;<br>
&gt; +=C2=A0 =C2=A0 bool enabled =3D false;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +#ifndef CONFIG_USER_ONLY<br>
&gt; +=C2=A0 =C2=A0 enabled =3D qatomic_read(&amp;rule-&gt;enabled) &amp; B=
IT_ULL(cpu-&gt;env.mhartid);<br>
<br>
enabled is a uint64_t, so this limits us to 64 harts right?<br>
<br>
The virt machine currently has a limit of 512, so this won&#39;t work right=
?<br>
<br>
Alistair<br></blockquote><div><br></div><div>Yes, that&#39;s true.</div><di=
v>Though it wouldn&#39;t impact the result as this is just the optimization=
</div><div>of not iterating the rules that have been applied already.</div>=
<div><br></div><div>Maybe I can replace it with the dynamic hart bitmask.</=
div><div><br></div><div>Regards,</div><div>Frank Chang</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!enabled) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Enable the implied MISAs. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rule-&gt;implied_misas) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_cpu_set_misa_ext(env,=
 env-&gt;misa_ext | rule-&gt;implied_misas);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; misa_bits[i] =
!=3D 0; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rule-&gt;=
implied_misas &amp; misa_bits[i]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 ir =3D g_hash_table_lookup(misa_implied_rules,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0GUINT_TO_POINTER(misa_bits[i]));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if (ir) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 cpu_enable_implied_rule(cpu, ir);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Enable the implied extensions. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; rule-&gt;implied_exts[i] !=
=3D RISCV_IMPLIED_EXTS_RULE_END; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_cfg_ext_auto_update(cpu=
, rule-&gt;implied_exts[i], true);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ir =3D g_hash_table_lookup(=
ext_implied_rules,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GUINT_TO_POI=
NTER(rule-&gt;implied_exts[i]));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ir) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_enable_im=
plied_rule(cpu, ir);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +#ifndef CONFIG_USER_ONLY<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qatomic_or(&amp;rule-&gt;enabled, BIT_ULL=
(cpu-&gt;env.mhartid));<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 RISCVCPUImpliedExtsRule *rule;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Enable the implied MISAs. */<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; (rule =3D riscv_misa_implied_rules[i]); i=
++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (riscv_has_ext(&amp;cpu-&gt;env, rule-=
&gt;ext)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_enable_implied_rule(cpu=
, rule);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Enable the implied extensions. */<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; (rule =3D riscv_ext_implied_rules[i]); i+=
+) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isa_ext_is_enabled(cpu, rule-&gt;ext)=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_enable_implied_rule(cpu=
, rule);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp=
)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 CPURISCVState *env =3D &amp;cpu-&gt;env;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 riscv_cpu_init_implied_exts_rules();<br>
&gt; +=C2=A0 =C2=A0 riscv_cpu_enable_implied_rules(cpu);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 riscv_cpu_validate_misa_priv(env, &amp;local_err);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (local_err !=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br=
>
&gt; @@ -1346,6 +1435,8 @@ static void riscv_tcg_cpu_instance_init(CPUState=
 *cs)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 misa_ext_user_opts =3D g_hash_table_new(NULL, g_di=
rect_equal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 multi_ext_user_opts =3D g_hash_table_new(NULL, g_d=
irect_equal);<br>
&gt; +=C2=A0 =C2=A0 misa_implied_rules =3D g_hash_table_new(NULL, g_direct_=
equal);<br>
&gt; +=C2=A0 =C2=A0 ext_implied_rules =3D g_hash_table_new(NULL, g_direct_e=
qual);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 riscv_cpu_add_user_properties(obj);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (riscv_cpu_has_max_extensions(obj)) {<br>
&gt; --<br>
&gt; 2.43.2<br>
&gt;<br>
&gt;<br>
</blockquote></div></div>

--0000000000008d7c7a061b60dad6--

