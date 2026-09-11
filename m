Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF45BC88E58
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x53Bg-00086O-A7; Fri, 11 Sep 2026 11:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x53Bc-00084p-Ux
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 11:29:09 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x53BZ-00078R-0o
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 11:29:08 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49ccfae359fso8555885e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 08:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789140543; x=1789745343; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Wktg2NIF1Fa70Y3y2YTMPvNs4JtDueHegwGtUlwhlYU=;
 b=Qy9QGXNEEiS0KPdL9mzw0oXh2fNx/ZyGfK16elitb08UczZhrSczDAzcyItYgk/o3m
 BbVclYwSK1Sv14l/qErk1Lz84/i6yfapTYvtX8r57T8WrOiEwIwSJo+VUCkaIbs6eBIC
 MWYHethVtltQhtxJ59qixl1ffnMe0HxwUH6ApqHx79Iv5z8+l/aBvQ2boA4JDu9jvMyZ
 g2ODOZKmo1mxTCN/D2TIM6OY6khQ2P2hbez4By9AyxSpglWVZHeT2ln3b5n3pEif7smI
 1fekH0DaCbnzFJZ4n5qV4IrJgh+aZqK1Emt4K/QLmzQuCtjjkDstv0pCO99sVJGtlCTa
 hZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789140543; x=1789745343;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wktg2NIF1Fa70Y3y2YTMPvNs4JtDueHegwGtUlwhlYU=;
 b=jc583rH9AnDVi0zHicEgL8Y9ODYoGYolKJGhciSZGk1PMQloY1hA7ckoGNQjlUmc8F
 Q3eD+H+13gW8n65vO+FqZDq0nwIYVl7IaRu20A3Td/JaGyn/E/gkQL/Ig6jmMLvvnJgZ
 O+H+5WPtKTFJK5dWYrk26FjUqx3GbWhxZ0XyyOuVgak2LsDkTQrCGfYX1ZNMOZY33wq7
 oDe9EMEobmu6+/pl+Z7lh78Z+xvseWuauKAHaa5/bngDo7EAAUl6M0/7dOiD0C+U7hu9
 iu91oQvpBoNvHI3irCvwlMKzNnjUQZa2unHyFbqfZJLJUc+/tEqxrJVsjPmGVGsMTUbn
 VbWg==
X-Gm-Message-State: AFuF++n0e4l1Oj0DHnPXMEcoI3ziPo4f409neLRn+47t2LGsUD2A86No
 9FmKQIHVcnXaEngDF2cz75yIUK/YUUo6NwWKXChM0Qf9f6an5xRtX9G3cSdCkHFsTAk=
X-Gm-Gg: AYBFou1xdOsMaizniECyy1EbiKmMlUjL9aeVBA7OxNhjv2FwItVupZ1FLvjTINqC+li
 xeIVYYlrVMyxmpmnpfx0l1vpFhQV1XPTwYGIxjq9Ff+f4oa5Epra3ybsmf2+3Xs7uAJBDTn1iai
 FzZIoZ0c1RbFpUS9Vo2Ia+ZPsvcCR0DEdlk8XenWrZCR+ObrI0u7OwWe6JQYAwewCCJd5qMDfmO
 gMdHylt2YHyHyqOcij/bqbXdm5dh3lTM5LBc/eIwACQvotefDpJgPqYxr3LT83qtdJHTqgbrSXo
 O7cvNrcBHXAtv9tOKnKK6vc99i1tTFR83g6QXJ3XuBKvTXkrOPXc7RUkOCyLs87GR+9Ef/0b5Cg
 TgQIDIeiPeHOia7PbUzHNfeZCJsJE+tuqDWbs0Kp3bVWb4rIEXQscQTXkKQxrjg43SKz+eJ4HMK
 /O1qLkX1Tnbwu0yDXDKAH0/q2h3xQfkmoQ6T+3VhIbrQNR2aCeoyMEhP6lsW1I2dX02p5i5aA=
X-Received: by 2002:a05:600c:3104:b0:49c:eb16:9fd with SMTP id
 5b1f17b1804b1-49e6197f6f6mr58755395e9.3.1789140542646; 
 Fri, 11 Sep 2026 08:29:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62232cb7sm57280125e9.4.2026.09.11.08.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:29:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 79ACE5F856;
 Fri, 11 Sep 2026 16:29:00 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Zhao
 Liu
 <zhao1.liu@intel.com>,  Peter Maydell <peter.maydell@linaro.org>,  Chinmay
 Rath <rathc@linux.ibm.com>,  Nicholas Piggin <npiggin@gmail.com>,  Glenn
 Miles <milesg@linux.ibm.com>,  Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,  Alistair Francis
 <alistair.francis@wdc.com>,  Weiwei Li <liwei1518@gmail.com>,  Daniel
 Henrique Barboza <daniel.barboza@oss.qualcomm.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Chao Liu <chao.liu@processmission.com>,
 Max Filippov <jcmvbkbc@gmail.com>,  qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,  qemu-riscv@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Laurent Vivier <laurent@vivier.eu>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Artyom Tarasenko
 <atar4qemu@gmail.com>,  Helge Deller <deller@gmx.de>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Warner Losh <imp@bsdimp.com>,  Kyle
 Evans <kevans@freebsd.org>
Subject: Re: [PATCH 02/10] gdbstub: fix next register base after register gaps
In-Reply-To: <20260911-query-reg-v1-2-0c04f0c02cf3@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Fri, 11 Sep 2026 16:27:25 +0400")
References: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
 <20260911-query-reg-v1-2-0c04f0c02cf3@redhat.com>
User-Agent: mu4e 1.14.4-pre2; emacs 30.1
Date: Fri, 11 Sep 2026 16:29:00 +0100
Message-ID: <87fqzf958j.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Commit b3e88abb200c ("gdbstub: Consider GDBFeature::base_reg in
> gdb_register_coprocessor()") identified that register numbers may
> have gaps. We also need to adjust the next base_reg correctly
> to avoid overlapping registers. Rename the field to be more
> explicit about its usage.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  gdbstub/gdbstub.c      | 13 ++++++-------
>  include/hw/core/cpu.h  |  2 +-
>  target/arm/gdbstub.c   |  8 +++++---
>  target/arm/gdbstub64.c | 10 ++++++----
>  target/ppc/gdbstub.c   |  2 +-
>  target/riscv/gdbstub.c |  9 ++++++---
>  target/xtensa/cpu.c    |  2 +-
>  7 files changed, 26 insertions(+), 20 deletions(-)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 0a328b0dd488..0ce871d74929 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -605,13 +605,13 @@ void gdb_init_cpu(CPUState *cpu)
>          gdb_register_feature(cpu, 0,
>                               cc->gdb_read_register, cc->gdb_write_regist=
er,
>                               feature);
> -        cpu->gdb_num_regs =3D cpu->gdb_num_g_regs =3D feature->num_regs;
> +        cpu->gdb_next_base_reg =3D cpu->gdb_num_g_regs =3D feature->num_=
regs;
>      } else {
> -        cpu->gdb_num_regs =3D cpu->gdb_num_g_regs =3D cc->gdb_num_core_r=
egs;
> +        cpu->gdb_next_base_reg =3D cpu->gdb_num_g_regs =3D cc->gdb_num_c=
ore_regs;
>      }
>=20=20
>      trace_gdbxml_init_cpu(object_get_typename(OBJECT(cpu)), cpu->cpu_ind=
ex,
> -                          cpu->gdb_num_regs, cpu->gdb_num_g_regs,
> +                          cpu->gdb_next_base_reg, cpu->gdb_num_g_regs,
>                            cc->gdb_num_core_regs);
>  }
>=20=20
> @@ -621,7 +621,7 @@ void gdb_register_coprocessor(CPUState *cpu,
>  {
>      GDBRegisterState *s;
>      guint i;
> -    int base_reg =3D cpu->gdb_num_regs;
> +    int base_reg =3D cpu->gdb_next_base_reg;
>=20=20
>      for (i =3D 0; i < cpu->gdb_regs->len; i++) {
>          /* Check for duplicates.  */
> @@ -639,7 +639,7 @@ void gdb_register_coprocessor(CPUState *cpu,
>      gdb_register_feature(cpu, base_reg, get_reg, set_reg, feature);
>=20=20
>      /* Add to end of list.  */
> -    cpu->gdb_num_regs +=3D feature->num_regs;
> +    cpu->gdb_next_base_reg =3D base_reg + feature->num_regs;
>  }
>=20=20
>  void gdb_unregister_coprocessor_all(CPUState *cpu)
> @@ -651,7 +651,7 @@ void gdb_unregister_coprocessor_all(CPUState *cpu)
>      g_array_free(cpu->gdb_regs, true);
>=20=20
>      cpu->gdb_regs =3D NULL;
> -    cpu->gdb_num_regs =3D 0;
> +    cpu->gdb_next_base_reg =3D 0;
>      cpu->gdb_num_g_regs =3D 0;
>  }
>=20=20
> @@ -2522,4 +2522,3 @@ void gdb_create_default_process(GDBState *s)
>      process->attached =3D false;
>      process->target_xml =3D NULL;
>  }
> -
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 328e30045ce1..02212f555c2e 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -521,7 +521,7 @@ struct CPUState {
>      struct CPUJumpCache *tb_jmp_cache;
>=20=20
>      GArray *gdb_regs;
> -    int gdb_num_regs;
> +    int gdb_next_base_reg;
>      int gdb_num_g_regs;
>      QTAILQ_ENTRY(CPUState) node;
>=20=20
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index d6e29c4cf467..e5cbe4d951ef 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -555,19 +555,21 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU =
*cpu)
>          gdb_register_coprocessor(cs, mve_gdb_get_reg, mve_gdb_set_reg,
>                                   gdb_find_static_feature("arm-m-profile-=
mve.xml"));
>      }
> +    GDBFeature *feature =3D
> +        arm_gen_dynamic_sysreg_feature(cs, cs->gdb_next_base_reg);
>      gdb_register_coprocessor(cs, arm_gdb_get_sysreg, arm_gdb_set_sysreg,
> -                             arm_gen_dynamic_sysreg_feature(cs, cs->gdb_=
num_regs));
> +                             feature);
>=20=20
>  #ifdef CONFIG_TCG
>      if (arm_feature(env, ARM_FEATURE_M) && tcg_enabled()) {
>          gdb_register_coprocessor(cs,
>              arm_gdb_get_m_systemreg, arm_gdb_set_m_systemreg,
> -            arm_gen_dynamic_m_systemreg_feature(cs, cs->gdb_num_regs));
> +            arm_gen_dynamic_m_systemreg_feature(cs, cs->gdb_next_base_re=
g));
>  #ifndef CONFIG_USER_ONLY
>          if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
>              gdb_register_coprocessor(cs,
>                  arm_gdb_get_m_secextreg, arm_gdb_set_m_secextreg,
> -                arm_gen_dynamic_m_secextreg_feature(cs, cs->gdb_num_regs=
));
> +                arm_gen_dynamic_m_secextreg_feature(cs, cs->gdb_next_bas=
e_reg));
>          }
>  #endif
>      }
> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> index 0c3e5b30bd6a..cf5b95b54641 100644
> --- a/target/arm/gdbstub64.c
> +++ b/target/arm/gdbstub64.c
> @@ -885,7 +885,8 @@ void aarch64_cpu_register_gdb_regs_for_features(ARMCP=
U *cpu)
>      CPUState *cs =3D CPU(cpu);
>      if (isar_feature_aa64_sve(&cpu->isar) ||
>          isar_feature_aa64_sme(&cpu->isar)) {
> -        GDBFeature *feature =3D arm_gen_dynamic_svereg_feature(cs, cs->g=
db_num_regs);
> +        GDBFeature *feature =3D
> +            arm_gen_dynamic_svereg_feature(cs, cs->gdb_next_base_reg);
>          gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
>                                   aarch64_gdb_set_sve_reg, feature);
>      } else {
> @@ -896,7 +897,7 @@ void aarch64_cpu_register_gdb_regs_for_features(ARMCP=
U *cpu)
>=20=20
>      if (isar_feature_aa64_sme(&cpu->isar)) {
>          GDBFeature *sme_feature =3D
> -            arm_gen_dynamic_smereg_feature(cs, cs->gdb_num_regs);
> +            arm_gen_dynamic_smereg_feature(cs, cs->gdb_next_base_reg);
>          gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
>                                   aarch64_gdb_set_sme_reg, sme_feature);
>          if (isar_feature_aa64_sme2(&cpu->isar)) {
> @@ -927,7 +928,8 @@ void aarch64_cpu_register_gdb_regs_for_features(ARMCP=
U *cpu)
>  #endif
>=20=20
>      /* All AArch64 CPUs have at least TPIDR */
> +    GDBFeature *tls_feature =3D
> +        arm_gen_dynamic_tls_feature(cs, cs->gdb_next_base_reg);
>      gdb_register_coprocessor(cs, aarch64_gdb_get_tls_reg,
> -                             aarch64_gdb_set_tls_reg,
> -                             arm_gen_dynamic_tls_feature(cs, cs->gdb_num=
_regs));
> +                             aarch64_gdb_set_tls_reg, tls_feature);
>  }
> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> index 4d622c5cad59..ec25c541c685 100644
> --- a/target/ppc/gdbstub.c
> +++ b/target/ppc/gdbstub.c
> @@ -206,7 +206,7 @@ static void gdb_gen_spr_feature(CPUState *cs)
>=20=20
>      gdb_feature_builder_init(&builder, &pcc->gdb_spr,
>                               "org.qemu.power.spr", "power-spr.xml",
> -                             cs->gdb_num_regs);
> +                             cs->gdb_next_base_reg);
>=20=20
>      for (i =3D 0; i < ARRAY_SIZE(env->spr_cb); i++) {
>          ppc_spr_t *spr =3D &env->spr_cb[i];
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 9abbf5bcdf0e..f279f4ab2461 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -348,9 +348,10 @@ void riscv_cpu_register_gdb_regs_for_features(CPUSta=
te *cs)
>                                   gdb_find_static_feature("riscv-32bit-fp=
u.xml"));
>      }
>      if (cpu->cfg.ext_zve32x) {
> +        GDBFeature *feature =3D
> +            ricsv_gen_dynamic_vector_feature(cs, cs->gdb_next_base_reg);
>          gdb_register_coprocessor(cs, riscv_gdb_get_vector,
> -                                 riscv_gdb_set_vector,
> -                                 ricsv_gen_dynamic_vector_feature(cs, cs=
->gdb_num_regs));
> +                                 riscv_gdb_set_vector, feature);
>      }
>=20=20
>  #ifdef CONFIG_TCG
> @@ -373,8 +374,10 @@ void riscv_cpu_register_gdb_regs_for_features(CPUSta=
te *cs)
>      }
>=20=20
>      if (cpu->cfg.ext_zicsr) {
> +        GDBFeature *feature =3D
> +            riscv_gen_dynamic_csr_feature(cs, cs->gdb_next_base_reg);
>          gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_cs=
r,
> -                                 riscv_gen_dynamic_csr_feature(cs, cs->g=
db_num_regs));
> +                                 feature);
>      }
>  #endif
>  }
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index 7c25b9ab707a..48863a1859d4 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -263,7 +263,7 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
>          return;
>      }
>=20=20
> -    cs->gdb_num_regs =3D xcc->config->gdb_regmap.num_regs;
> +    cs->gdb_next_base_reg =3D xcc->config->gdb_regmap.num_regs;
>=20=20
>      qemu_init_vcpu(cs);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

