Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDF9C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 05:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN3EK-0002F4-DP; Thu, 05 Jun 2025 01:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1uN3EG-0002Ed-Jb
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 01:33:28 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1uN3EC-00025m-J3
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 01:33:28 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-235ef62066eso7917805ad.3
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 22:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1749101602; x=1749706402; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m6vJ0CnZRV9FH2vn9qI/zdBLwyIizFlPmviKKnw1tnw=;
 b=VLqTNfbXl/j4aZVSv5H7LZ9x5pJAM6u9OlrzoDWPEMhlKjfHg/JvcveFFYGBTKhjOe
 Jrt4kZe+huZrHhVdFsgCF7Nt87D9Wff6H3qaLsXNun4EWToU5/QS5uJVeZj+ge6Ugs28
 IJW2PyWRZ7OaMsWZsgUqm55bLIgQIepCt2Kf8bwhyBaI4uVePgpFSgf55ihpUPj8bBVw
 c1yict6PUUdhxjaJxpfdhK8aKWGQFMoF9DcVHNLvqdz2KtqWWrztDz5tB3bT3FmaZ1hv
 LT4H0hCoLV1ZMtw2baEF+sxSVaCzfZSkkUDJoBeIQkTy7ZZ7YSvgU7B8qU0R8L+q4qJP
 xH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749101602; x=1749706402;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m6vJ0CnZRV9FH2vn9qI/zdBLwyIizFlPmviKKnw1tnw=;
 b=q2tmsggC3A+hhERAXDil9++d+W1PR+LKgyphr4WVP+utj9teZTmJxb9poTy78JmkAV
 R0LtZPeTf1KtwT2rBfJsh2Z74J03Zx9jXLwY2NR+FjLMCyIZVtEisBXX1N2seKr6NBHz
 o1uWqagYW3SKesErgTZP4M8bBER3H61WuZggh1xEG0eKSfvMKc2xf+gb5vCNLkcvboPx
 +9G2X/oRmaS//pMybjCdXOzRbrp4/Dvq5OviRRG8IxFaLS9vv/5zK3lU2ZISHIUuxz6y
 g4lFYDu8ZkqmtCpsAi3TwGq8w4IjXezQgqw6Za2dvbi7AlOh3rrSRxfzbONMY6gh2DTe
 o7eQ==
X-Gm-Message-State: AOJu0Yz0yT0goeGIIwS4jNj0luoNLou5PKHZ9fjWBplZkEI5/S9LUJ/o
 6YMUJuos+376ol0vyujyQyH+dxIT+GXQBjsm4BsLISg2WCjtiFeMK0UW2h1CYmean3l4U+rO8m/
 vQcNQg5IWOzaXDxYz3S5W/3sBkwOnzrZtfbnsJtJwPQ==
X-Gm-Gg: ASbGncuWRVIN6w7b4W3CxzbnURnBJS1dICDsU6feYPNRhBMQNVgNfJVGogVG5XERQWL
 zOoaMmV62Olkc29cDGS5wayW1Q3SUqCKIS6iOjIRHuWuPKvojlqtdUDOr5EMlr0MlLcBTKK9Vfe
 Soa885hEUauWeeGCeiDfbpRJduGcQ/PZibRd/tvtLoIF41xw==
X-Google-Smtp-Source: AGHT+IGx9nwpjIR22M6w1Ms7OUxYmxlwCcsy7YsNl02bQme8j6RHDv0WjVnqDzx4JuLBK8azNddeBeUcEOUSjDlb0gs=
X-Received: by 2002:a17:903:1107:b0:234:8e54:2d53 with SMTP id
 d9443c01a7336-235e1255c3cmr75378115ad.45.1749101602178; Wed, 04 Jun 2025
 22:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250522081236.4050-1-jay.chang@sifive.com>
 <20250522081236.4050-3-jay.chang@sifive.com>
 <14110641-4610-4f44-b192-2fd35f302e15@ventanamicro.com>
In-Reply-To: <14110641-4610-4f44-b192-2fd35f302e15@ventanamicro.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Thu, 5 Jun 2025 13:33:11 +0800
X-Gm-Features: AX0GCFvIdOGdsG9OuIyA_bJpZdlnHnKUJv1EWewnr2xwtzxA3JtxhHjaAGMW9Ic
Message-ID: <CACNNAjNrm77bB48jhR=u00BB9C9=MJ+NJK_fVH5uSLhWHVxbrA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] target/riscv: Make PMP region count configurable
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Frank Chang <frank.chang@sifive.com>
Content-Type: multipart/alternative; boundary="000000000000acaeea0636cc73fe"
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--000000000000acaeea0636cc73fe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

*Hi Daniel,*

You're absolutely right =E2=80=94 thanks for pointing it out and providing =
the fix!

Would you like me to send out a v5 patch incorporating your changes?


Best Regards
Jay Chang


On Thu, Jun 5, 2025 at 2:20=E2=80=AFAM Daniel Henrique Barboza <
dbarboza@ventanamicro.com> wrote:

> It seems like this patch is breaking 'make check-functional':
>
>
> >>>
> UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:pr=
int_stacktrace=3D1
> RUST_BACKTRACE=3D1
> LD_LIBRARY_PATH=3D/home/danielhb/work/qemu/build/contrib/plugins:/home/da=
nielhb/work/qemu/build/tests/tcg/plugins
> MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:pri=
nt_stacktrace=3D1
> QEMU_BUILD_ROOT=3D/home/danielhb/work/qemu/build
> QEMU_TEST_QEMU_IMG=3D/home/danielhb/work/qemu/build/qemu-img
> PYTHONPATH=3D/home/danielhb/work/qemu/python:/home/danielhb/work/qemu/tes=
ts/functional
> G_TEST_SLOW=3D1 ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print=
_summary=3D1
> MALLOC_PERTURB_=3D229 MESON_TEST_ITERATION=3D1
> QEMU_TEST_QEMU_BINARY=3D/home/danielhb/work/qemu/build/qemu-system-riscv6=
4
> /home/danielhb/work/qemu/build/pyvenv/bin/python3
> /home/danielhb/work/qemu/tests/functional/test_riscv64_tuxrun.py
>
>
> Summary of Failures:
>
> 11/12 qemu:func-thorough+func-riscv32-thorough+thorough /
> func-riscv32-riscv32_tuxrun TIMEOUT         90.02s   killed by signal 15
> SIGTERM
> 12/12 qemu:func-thorough+func-riscv64-thorough+thorough /
> func-riscv64-riscv64_tuxrun TIMEOUT        120.13s   killed by signal 15
> SIGTERM
>
>
>
> Going through the code:
>
>
>
> On 5/22/25 5:12 AM, Jay Chang wrote:
> > Previously, the number of PMP regions was hardcoded to 16 in QEMU.
> > This patch replaces the fixed value with a new `pmp_regions` field,
> > allowing platforms to configure the number of PMP regions.
> >
> > If no specific value is provided, the default number of PMP regions
> > remains 16 to preserve the existing behavior.
> >
> > A new CPU parameter num-pmp-regions has been introduced to the QEMU
> > command line. For example:
> >
> >       -cpu rv64, g=3Dtrue, c=3Dtrue, pmp=3Dtrue, num-pmp-regions=3D8
> >
> > Signed-off-by: Jay Chang <jay.chang@sifive.com>
> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
> > ---
> >   target/riscv/cpu.c                | 54 +++++++++++++++++++++++++++++-=
-
> >   target/riscv/cpu.h                |  3 +-
> >   target/riscv/cpu_cfg_fields.h.inc |  1 +
> >   target/riscv/csr.c                |  5 ++-
> >   target/riscv/machine.c            |  3 +-
> >   target/riscv/pmp.c                | 28 ++++++++++------
> >   6 files changed, 80 insertions(+), 14 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 629ac37501..8e32252c11 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -1117,6 +1117,7 @@ static void riscv_cpu_init(Object *obj)
> >       cpu->cfg.cbom_blocksize =3D 64;
> >       cpu->cfg.cbop_blocksize =3D 64;
> >       cpu->cfg.cboz_blocksize =3D 64;
> > +    cpu->cfg.pmp_regions =3D 16;
>
> pmp_regions is set to 16 in the base class, which is what we want to keep
> the default intact. But then:
>
> >       cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
> >       cpu->cfg.max_satp_mode =3D -1;
> >
> > @@ -1568,6 +1569,46 @@ static const PropertyInfo prop_pmp =3D {
> >       .set =3D prop_pmp_set,
> >   };
> >
> > +static void prop_num_pmp_regions_set(Object *obj, Visitor *v, const
> char *name,
> > +                                     void *opaque, Error **errp)
> > +{
> > +    RISCVCPU *cpu =3D RISCV_CPU(obj);
> > +    uint8_t value;
> > +
> > +    visit_type_uint8(v, name, &value, errp);
> > +
> > +    if (cpu->cfg.pmp_regions !=3D value && riscv_cpu_is_vendor(obj)) {
> > +        cpu_set_prop_err(cpu, name, errp);
> > +        return;
> > +    }
> > +
> > +    if (cpu->env.priv_ver < PRIV_VERSION_1_12_0 && value >
> OLD_MAX_RISCV_PMPS) {
> > +        error_setg(errp, "Number of PMP regions exceeds maximum
> available");
> > +        return;
> > +    } else if (value > MAX_RISCV_PMPS) {
> > +        error_setg(errp, "Number of PMP regions exceeds maximum
> available");
> > +        return;
> > +    }
> > +
> > +    cpu_option_add_user_setting(name, value);
> > +    cpu->cfg.pmp_regions =3D value;
> > +}
> > +
> > +static void prop_num_pmp_regions_get(Object *obj, Visitor *v, const
> char *name,
> > +                                     void *opaque, Error **errp)
> > +{
> > +    uint8_t value =3D RISCV_CPU(obj)->cfg.pmp_regions;
> > +
> > +    visit_type_uint8(v, name, &value, errp);
> > +}
> > +
> > +static const PropertyInfo prop_num_pmp_regions =3D {
> > +    .type =3D "uint8",
> > +    .description =3D "num-pmp-regions",
> > +    .get =3D prop_num_pmp_regions_get,
> > +    .set =3D prop_num_pmp_regions_set,
> > +};
> > +
> >   static int priv_spec_from_str(const char *priv_spec_str)
> >   {
> >       int priv_version =3D -1;
> > @@ -2567,6 +2608,7 @@ static const Property riscv_cpu_properties[] =3D =
{
> >
> >       {.name =3D "mmu", .info =3D &prop_mmu},
> >       {.name =3D "pmp", .info =3D &prop_pmp},
> > +    {.name =3D "num-pmp-regions", .info =3D &prop_num_pmp_regions},
> >
> >       {.name =3D "priv_spec", .info =3D &prop_priv_spec},
> >       {.name =3D "vext_spec", .info =3D &prop_vext_spec},
> > @@ -2891,6 +2933,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D =
{
> >       DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU,
> >           .cfg.mmu =3D true,
> >           .cfg.pmp =3D true,
> > +        .cfg.pmp_regions =3D 8,
> >           .priv_spec =3D PRIV_VERSION_LATEST,
> >       ),
> >
> > @@ -2937,7 +2980,8 @@ static const TypeInfo riscv_cpu_type_infos[] =3D =
{
> >           .cfg.max_satp_mode =3D VM_1_10_MBARE,
> >           .cfg.ext_zifencei =3D true,
> >           .cfg.ext_zicsr =3D true,
> > -        .cfg.pmp =3D true
> > +        .cfg.pmp =3D true,
> > +        .cfg.pmp_regions =3D 8
>
> We can't set pmp_regions =3D 8 in the CPU definitions too. This will
> overwrite the
> pmp_regions =3D 16 from the parent object. In short, we're changing the
> default
> val for a lot of CPUs.
>
> This diff fixes the test:
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d49c02dfe4..b84f08e582 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2933,7 +2933,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>       DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU,
>           .cfg.mmu =3D true,
>           .cfg.pmp =3D true,
> -        .cfg.pmp_regions =3D 8,
>           .priv_spec =3D PRIV_VERSION_LATEST,
>       ),
>
> @@ -3011,7 +3010,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>           .cfg.ext_zifencei =3D true,
>           .cfg.ext_zicsr =3D true,
>           .cfg.pmp =3D true,
> -        .cfg.pmp_regions =3D 8,
>           .cfg.ext_smepmp =3D true,
>
>           .cfg.ext_zba =3D true,
> @@ -3086,7 +3084,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>           .cfg.ext_xtheadmempair =3D true,
>           .cfg.ext_xtheadsync =3D true,
>           .cfg.pmp =3D true,
> -        .cfg.pmp_regions =3D 8,
>
>           .cfg.mvendorid =3D THEAD_VENDOR_ID,
>
> @@ -3110,7 +3107,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>           .cfg.rvv_ta_all_1s =3D true,
>           .cfg.misa_w =3D true,
>           .cfg.pmp =3D true,
> -        .cfg.pmp_regions =3D 8,
>           .cfg.cbom_blocksize =3D 64,
>           .cfg.cbop_blocksize =3D 64,
>           .cfg.cboz_blocksize =3D 64,
> @@ -3167,7 +3163,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>           .cfg.ext_zifencei =3D true,
>           .cfg.ext_zicsr =3D true,
>           .cfg.pmp =3D true,
> -        .cfg.pmp_regions =3D 8,
>           .cfg.ext_zicbom =3D true,
>           .cfg.cbom_blocksize =3D 64,
>           .cfg.cboz_blocksize =3D 64,
> @@ -3212,7 +3207,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>
>           .cfg.mmu =3D true,
>           .cfg.pmp =3D true,
> -        .cfg.pmp_regions =3D 8,
>
>           .cfg.max_satp_mode =3D VM_1_10_SV39,
>       ),
>
>
> I removed all "pmp_regions =3D 8" assignments but the Si-five ones. The
> generic
> CPUs should retain the default pmp regions value, and every other vendor
> CPU
> should set its own default if they want.
>
>
> Thanks,
>
> Daniel
>
> >       ),
> >
> >       DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U,
> TYPE_RISCV_VENDOR_CPU,
> > @@ -2948,7 +2992,8 @@ static const TypeInfo riscv_cpu_type_infos[] =3D =
{
> >           .cfg.ext_zifencei =3D true,
> >           .cfg.ext_zicsr =3D true,
> >           .cfg.mmu =3D true,
> > -        .cfg.pmp =3D true
> > +        .cfg.pmp =3D true,
> > +        .cfg.pmp_regions =3D 8
> >       ),
> >
> >   #if defined(TARGET_RISCV32) || \
> > @@ -2966,6 +3011,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D =
{
> >           .cfg.ext_zifencei =3D true,
> >           .cfg.ext_zicsr =3D true,
> >           .cfg.pmp =3D true,
> > +        .cfg.pmp_regions =3D 8,
> >           .cfg.ext_smepmp =3D true,
> >
> >           .cfg.ext_zba =3D true,
> > @@ -3040,6 +3086,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D =
{
> >           .cfg.ext_xtheadmempair =3D true,
> >           .cfg.ext_xtheadsync =3D true,
> >           .cfg.pmp =3D true,
> > +        .cfg.pmp_regions =3D 8,
> >
> >           .cfg.mvendorid =3D THEAD_VENDOR_ID,
> >
> > @@ -3063,6 +3110,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D =
{
> >           .cfg.rvv_ta_all_1s =3D true,
> >           .cfg.misa_w =3D true,
> >           .cfg.pmp =3D true,
> > +        .cfg.pmp_regions =3D 8,
> >           .cfg.cbom_blocksize =3D 64,
> >           .cfg.cbop_blocksize =3D 64,
> >           .cfg.cboz_blocksize =3D 64,
> > @@ -3119,6 +3167,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D =
{
> >           .cfg.ext_zifencei =3D true,
> >           .cfg.ext_zicsr =3D true,
> >           .cfg.pmp =3D true,
> > +        .cfg.pmp_regions =3D 8,
> >           .cfg.ext_zicbom =3D true,
> >           .cfg.cbom_blocksize =3D 64,
> >           .cfg.cboz_blocksize =3D 64,
> > @@ -3163,6 +3212,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D =
{
> >
> >           .cfg.mmu =3D true,
> >           .cfg.pmp =3D true,
> > +        .cfg.pmp_regions =3D 8,
> >
> >           .cfg.max_satp_mode =3D VM_1_10_SV39,
> >       ),
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 229ade9ed9..67323a7d9d 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -159,7 +159,8 @@ extern RISCVCPUImpliedExtsRule
> *riscv_multi_ext_implied_rules[];
> >
> >   #define MMU_USER_IDX 3
> >
> > -#define MAX_RISCV_PMPS (16)
> > +#define MAX_RISCV_PMPS (64)
> > +#define OLD_MAX_RISCV_PMPS (16)
> >
> >   #if !defined(CONFIG_USER_ONLY)
> >   #include "pmp.h"
> > diff --git a/target/riscv/cpu_cfg_fields.h.inc
> b/target/riscv/cpu_cfg_fields.h.inc
> > index 59f134a419..33c4f9bac8 100644
> > --- a/target/riscv/cpu_cfg_fields.h.inc
> > +++ b/target/riscv/cpu_cfg_fields.h.inc
> > @@ -163,6 +163,7 @@ TYPED_FIELD(uint16_t, elen, 0)
> >   TYPED_FIELD(uint16_t, cbom_blocksize, 0)
> >   TYPED_FIELD(uint16_t, cbop_blocksize, 0)
> >   TYPED_FIELD(uint16_t, cboz_blocksize, 0)
> > +TYPED_FIELD(uint8_t,  pmp_regions, 0)
> >
> >   TYPED_FIELD(int8_t, max_satp_mode, -1)
> >
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index d6cd441133..6296ecd1e1 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -738,7 +738,10 @@ static RISCVException dbltrp_hmode(CPURISCVState
> *env, int csrno)
> >   static RISCVException pmp(CPURISCVState *env, int csrno)
> >   {
> >       if (riscv_cpu_cfg(env)->pmp) {
> > -        if (csrno <=3D CSR_PMPCFG3) {
> > +        int max_pmpcfg =3D (env->priv_ver >=3D PRIV_VERSION_1_12_0) ?
> > ++                              CSR_PMPCFG15 : CSR_PMPCFG3;
> > +
> > +        if (csrno <=3D max_pmpcfg) {
> >               uint32_t reg_index =3D csrno - CSR_PMPCFG0;
> >
> >               /* TODO: RV128 restriction check */
> > diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> > index c97e9ce9df..1600ec44f0 100644
> > --- a/target/riscv/machine.c
> > +++ b/target/riscv/machine.c
> > @@ -36,8 +36,9 @@ static int pmp_post_load(void *opaque, int version_id=
)
> >       RISCVCPU *cpu =3D opaque;
> >       CPURISCVState *env =3D &cpu->env;
> >       int i;
> > +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> >
> > -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> > +    for (i =3D 0; i < pmp_regions; i++) {
> >           pmp_update_rule_addr(env, i);
> >       }
> >       pmp_update_rule_nums(env);
> > diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> > index 5af295e410..3540327c9a 100644
> > --- a/target/riscv/pmp.c
> > +++ b/target/riscv/pmp.c
> > @@ -122,7 +122,9 @@ uint32_t pmp_get_num_rules(CPURISCVState *env)
> >    */
> >   static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t
> pmp_index)
> >   {
> > -    if (pmp_index < MAX_RISCV_PMPS) {
> > +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> > +
> > +    if (pmp_index < pmp_regions) {
> >           return env->pmp_state.pmp[pmp_index].cfg_reg;
> >       }
> >
> > @@ -136,7 +138,9 @@ static inline uint8_t pmp_read_cfg(CPURISCVState
> *env, uint32_t pmp_index)
> >    */
> >   static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index,
> uint8_t val)
> >   {
> > -    if (pmp_index < MAX_RISCV_PMPS) {
> > +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> > +
> > +    if (pmp_index < pmp_regions) {
> >           if (env->pmp_state.pmp[pmp_index].cfg_reg =3D=3D val) {
> >               /* no change */
> >               return false;
> > @@ -236,9 +240,10 @@ void pmp_update_rule_addr(CPURISCVState *env,
> uint32_t pmp_index)
> >   void pmp_update_rule_nums(CPURISCVState *env)
> >   {
> >       int i;
> > +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> >
> >       env->pmp_state.num_rules =3D 0;
> > -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> > +    for (i =3D 0; i < pmp_regions; i++) {
> >           const uint8_t a_field =3D
> >               pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
> >           if (PMP_AMATCH_OFF !=3D a_field) {
> > @@ -332,6 +337,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr
> addr,
> >       int pmp_size =3D 0;
> >       hwaddr s =3D 0;
> >       hwaddr e =3D 0;
> > +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> >
> >       /* Short cut if no rules */
> >       if (0 =3D=3D pmp_get_num_rules(env)) {
> > @@ -356,7 +362,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr
> addr,
> >        * 1.10 draft priv spec states there is an implicit order
> >        * from low to high
> >        */
> > -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> > +    for (i =3D 0; i < pmp_regions; i++) {
> >           s =3D pmp_is_in_range(env, i, addr);
> >           e =3D pmp_is_in_range(env, i, addr + pmp_size - 1);
> >
> > @@ -527,8 +533,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t
> addr_index,
> >   {
> >       trace_pmpaddr_csr_write(env->mhartid, addr_index, val);
> >       bool is_next_cfg_tor =3D false;
> > +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> >
> > -    if (addr_index < MAX_RISCV_PMPS) {
> > +    if (addr_index < pmp_regions) {
> >           if (env->pmp_state.pmp[addr_index].addr_reg =3D=3D val) {
> >               /* no change */
> >               return;
> > @@ -538,7 +545,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t
> addr_index,
> >            * In TOR mode, need to check the lock bit of the next pmp
> >            * (if there is a next).
> >            */
> > -        if (addr_index + 1 < MAX_RISCV_PMPS) {
> > +        if (addr_index + 1 < pmp_regions) {
> >               uint8_t pmp_cfg =3D env->pmp_state.pmp[addr_index +
> 1].cfg_reg;
> >               is_next_cfg_tor =3D PMP_AMATCH_TOR =3D=3D
> pmp_get_a_field(pmp_cfg);
> >
> > @@ -573,8 +580,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t
> addr_index,
> >   target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index=
)
> >   {
> >       target_ulong val =3D 0;
> > +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> >
> > -    if (addr_index < MAX_RISCV_PMPS) {
> > +    if (addr_index < pmp_regions) {
> >           val =3D env->pmp_state.pmp[addr_index].addr_reg;
> >           trace_pmpaddr_csr_read(env->mhartid, addr_index, val);
> >       } else {
> > @@ -592,6 +600,7 @@ void mseccfg_csr_write(CPURISCVState *env,
> target_ulong val)
> >   {
> >       int i;
> >       uint64_t mask =3D MSECCFG_MMWP | MSECCFG_MML;
> > +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> >       /* Update PMM field only if the value is valid according to Zjpm
> v1.0 */
> >       if (riscv_cpu_cfg(env)->ext_smmpm &&
> >           riscv_cpu_mxl(env) =3D=3D MXL_RV64 &&
> > @@ -603,7 +612,7 @@ void mseccfg_csr_write(CPURISCVState *env,
> target_ulong val)
> >
> >       /* RLB cannot be enabled if it's already 0 and if any regions are
> locked */
> >       if (!MSECCFG_RLB_ISSET(env)) {
> > -        for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> > +        for (i =3D 0; i < pmp_regions; i++) {
> >               if (pmp_is_locked(env, i)) {
> >                   val &=3D ~MSECCFG_RLB;
> >                   break;
> > @@ -659,6 +668,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env,
> hwaddr addr)
> >       hwaddr tlb_sa =3D addr & ~(TARGET_PAGE_SIZE - 1);
> >       hwaddr tlb_ea =3D tlb_sa + TARGET_PAGE_SIZE - 1;
> >       int i;
> > +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> >
> >       /*
> >        * If PMP is not supported or there are no PMP rules, the TLB pag=
e
> will not
> > @@ -669,7 +679,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env,
> hwaddr addr)
> >           return TARGET_PAGE_SIZE;
> >       }
> >
> > -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> > +    for (i =3D 0; i < pmp_regions; i++) {
> >           if (pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg) =3D=3D
> PMP_AMATCH_OFF) {
> >               continue;
> >           }
>
>

--000000000000acaeea0636cc73fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p><strong>Hi Daniel,</strong></p><p>You&#39;re absolutely=
 right =E2=80=94 thanks for pointing it out and providing the fix!</p><p>

</p><p>Would you like me to send out a v5 patch incorporating your changes?=
</p><p><br>Best Regards<br>Jay Chang<br><br></p></div><br><div class=3D"gma=
il_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Th=
u, Jun 5, 2025 at 2:20=E2=80=AFAM Daniel Henrique Barboza &lt;<a href=3D"ma=
ilto:dbarboza@ventanamicro.com">dbarboza@ventanamicro.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">It seems like this=
 patch is breaking &#39;make check-functional&#39;:<br>
<br>
<br>
&gt;&gt;&gt; UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_sum=
mary=3D1:print_stacktrace=3D1 RUST_BACKTRACE=3D1 LD_LIBRARY_PATH=3D/home/da=
nielhb/work/qemu/build/contrib/plugins:/home/danielhb/work/qemu/build/tests=
/tcg/plugins MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summ=
ary=3D1:print_stacktrace=3D1 QEMU_BUILD_ROOT=3D/home/danielhb/work/qemu/bui=
ld QEMU_TEST_QEMU_IMG=3D/home/danielhb/work/qemu/build/qemu-img PYTHONPATH=
=3D/home/danielhb/work/qemu/python:/home/danielhb/work/qemu/tests/functiona=
l G_TEST_SLOW=3D1 ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print=
_summary=3D1 MALLOC_PERTURB_=3D229 MESON_TEST_ITERATION=3D1 QEMU_TEST_QEMU_=
BINARY=3D/home/danielhb/work/qemu/build/qemu-system-riscv64 /home/danielhb/=
work/qemu/build/pyvenv/bin/python3 /home/danielhb/work/qemu/tests/functiona=
l/test_riscv64_tuxrun.py<br>
<br>
<br>
Summary of Failures:<br>
<br>
11/12 qemu:func-thorough+func-riscv32-thorough+thorough / func-riscv32-risc=
v32_tuxrun TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A090.02s=C2=A0 =C2=A0kill=
ed by signal 15 SIGTERM<br>
12/12 qemu:func-thorough+func-riscv64-thorough+thorough / func-riscv64-risc=
v64_tuxrun TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 120.13s=C2=A0 =C2=A0killed by=
 signal 15 SIGTERM<br>
<br>
<br>
<br>
Going through the code:<br>
<br>
<br>
<br>
On 5/22/25 5:12 AM, Jay Chang wrote:<br>
&gt; Previously, the number of PMP regions was hardcoded to 16 in QEMU.<br>
&gt; This patch replaces the fixed value with a new `pmp_regions` field,<br=
>
&gt; allowing platforms to configure the number of PMP regions.<br>
&gt; <br>
&gt; If no specific value is provided, the default number of PMP regions<br=
>
&gt; remains 16 to preserve the existing behavior.<br>
&gt; <br>
&gt; A new CPU parameter num-pmp-regions has been introduced to the QEMU<br=
>
&gt; command line. For example:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-cpu rv64, g=3Dtrue, c=3Dtrue, pmp=3Dtrue, n=
um-pmp-regions=3D8<br>
&gt; <br>
&gt; Signed-off-by: Jay Chang &lt;<a href=3D"mailto:jay.chang@sifive.com" t=
arget=3D"_blank">jay.chang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com"=
 target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 54 +++++++++++++++++++++++++++++--<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 3 +-<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_cfg_fields.h.inc |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 5 ++-<br>
&gt;=C2=A0 =C2=A0target/riscv/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 3 +-<br>
&gt;=C2=A0 =C2=A0target/riscv/pmp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 28 ++++++++++------<br>
&gt;=C2=A0 =C2=A06 files changed, 80 insertions(+), 14 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
&gt; index 629ac37501..8e32252c11 100644<br>
&gt; --- a/target/riscv/cpu.c<br>
&gt; +++ b/target/riscv/cpu.c<br>
&gt; @@ -1117,6 +1117,7 @@ static void riscv_cpu_init(Object *obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;cfg.cbom_blocksize =3D 64;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;cfg.cbop_blocksize =3D 64;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;cfg.cboz_blocksize =3D 64;<br>
&gt; +=C2=A0 =C2=A0 cpu-&gt;cfg.pmp_regions =3D 16;<br>
<br>
pmp_regions is set to 16 in the base class, which is what we want to keep<b=
r>
the default intact. But then:<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;env.vext_ver =3D VEXT_VERSION_1_00_0=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;cfg.max_satp_mode =3D -1;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -1568,6 +1569,46 @@ static const PropertyInfo prop_pmp =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.set =3D prop_pmp_set,<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static void prop_num_pmp_regions_set(Object *obj, Visitor *v, const c=
har *name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque=
, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 RISCVCPU *cpu =3D RISCV_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 uint8_t value;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 visit_type_uint8(v, name, &amp;value, errp);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (cpu-&gt;cfg.pmp_regions !=3D value &amp;&amp; riscv=
_cpu_is_vendor(obj)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_set_prop_err(cpu, name, errp);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (cpu-&gt;env.priv_ver &lt; PRIV_VERSION_1_12_0 &amp;=
&amp; value &gt; OLD_MAX_RISCV_PMPS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Number of PMP regi=
ons exceeds maximum available&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 } else if (value &gt; MAX_RISCV_PMPS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Number of PMP regi=
ons exceeds maximum available&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cpu_option_add_user_setting(name, value);<br>
&gt; +=C2=A0 =C2=A0 cpu-&gt;cfg.pmp_regions =3D value;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void prop_num_pmp_regions_get(Object *obj, Visitor *v, const c=
har *name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque=
, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint8_t value =3D RISCV_CPU(obj)-&gt;cfg.pmp_regions;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 visit_type_uint8(v, name, &amp;value, errp);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const PropertyInfo prop_num_pmp_regions =3D {<br>
&gt; +=C2=A0 =C2=A0 .type =3D &quot;uint8&quot;,<br>
&gt; +=C2=A0 =C2=A0 .description =3D &quot;num-pmp-regions&quot;,<br>
&gt; +=C2=A0 =C2=A0 .get =3D prop_num_pmp_regions_get,<br>
&gt; +=C2=A0 =C2=A0 .set =3D prop_num_pmp_regions_set,<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static int priv_spec_from_str(const char *priv_spec_str)<b=
r>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int priv_version =3D -1;<br>
&gt; @@ -2567,6 +2608,7 @@ static const Property riscv_cpu_properties[] =3D=
 {<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{.name =3D &quot;mmu&quot;, .info =3D &amp;p=
rop_mmu},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{.name =3D &quot;pmp&quot;, .info =3D &amp;p=
rop_pmp},<br>
&gt; +=C2=A0 =C2=A0 {.name =3D &quot;num-pmp-regions&quot;, .info =3D &amp;=
prop_num_pmp_regions},<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{.name =3D &quot;priv_spec&quot;, .info =3D =
&amp;prop_priv_spec},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{.name =3D &quot;vext_spec&quot;, .info =3D =
&amp;prop_vext_spec},<br>
&gt; @@ -2891,6 +2933,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC=
_CPU, TYPE_RISCV_CPU,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.mmu =3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.pmp =3D true,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp_regions =3D 8,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.priv_spec =3D PRIV_VERSION_LA=
TEST,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0),<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -2937,7 +2980,8 @@ static const TypeInfo riscv_cpu_type_infos[] =3D=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.max_satp_mode =3D VM_1_10=
_MBARE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.ext_zifencei =3D true,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.ext_zicsr =3D true,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp =3D true<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp =3D true,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp_regions =3D 8<br>
<br>
We can&#39;t set pmp_regions =3D 8 in the CPU definitions too. This will ov=
erwrite the<br>
pmp_regions =3D 16 from the parent object. In short, we&#39;re changing the=
 default<br>
val for a lot of CPUs.<br>
<br>
This diff fixes the test:<br>
<br>
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
index d49c02dfe4..b84f08e582 100644<br>
--- a/target/riscv/cpu.c<br>
+++ b/target/riscv/cpu.c<br>
@@ -2933,7 +2933,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {<br=
>
=C2=A0 =C2=A0 =C2=A0 DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE=
_RISCV_CPU,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.mmu =3D true,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp =3D true,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp_regions =3D 8,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .priv_spec =3D PRIV_VERSION_LATEST,<br>
=C2=A0 =C2=A0 =C2=A0 ),<br>
<br>
@@ -3011,7 +3010,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.ext_zifencei =3D true,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.ext_zicsr =3D true,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp =3D true,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp_regions =3D 8,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.ext_smepmp =3D true,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.ext_zba =3D true,<br>
@@ -3086,7 +3084,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.ext_xtheadmempair =3D true,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.ext_xtheadsync =3D true,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp =3D true,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp_regions =3D 8,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.mvendorid =3D THEAD_VENDOR_ID,<br>
<br>
@@ -3110,7 +3107,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.rvv_ta_all_1s =3D true,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.misa_w =3D true,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp =3D true,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp_regions =3D 8,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.cbom_blocksize =3D 64,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.cbop_blocksize =3D 64,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.cboz_blocksize =3D 64,<br>
@@ -3167,7 +3163,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.ext_zifencei =3D true,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.ext_zicsr =3D true,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp =3D true,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp_regions =3D 8,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.ext_zicbom =3D true,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.cbom_blocksize =3D 64,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.cboz_blocksize =3D 64,<br>
@@ -3212,7 +3207,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.mmu =3D true,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp =3D true,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp_regions =3D 8,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.max_satp_mode =3D VM_1_10_SV39,<br>
=C2=A0 =C2=A0 =C2=A0 ),<br>
<br>
<br>
I removed all &quot;pmp_regions =3D 8&quot; assignments but the Si-five one=
s. The generic<br>
CPUs should retain the default pmp regions value, and every other vendor CP=
U<br>
should set its own default if they want.<br>
<br>
<br>
Thanks,<br>
<br>
Daniel<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0),<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIF=
IVE_U, TYPE_RISCV_VENDOR_CPU,<br>
&gt; @@ -2948,7 +2992,8 @@ static const TypeInfo riscv_cpu_type_infos[] =3D=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.ext_zifencei =3D true,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.ext_zicsr =3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.mmu =3D true,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp =3D true<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp =3D true,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp_regions =3D 8<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0),<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#if defined(TARGET_RISCV32) || \<br>
&gt; @@ -2966,6 +3011,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.ext_zifencei =3D true,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.ext_zicsr =3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.pmp =3D true,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp_regions =3D 8,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.ext_smepmp =3D true,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.ext_zba =3D true,<br>
&gt; @@ -3040,6 +3086,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.ext_xtheadmempair =3D tru=
e,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.ext_xtheadsync =3D true,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.pmp =3D true,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp_regions =3D 8,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.mvendorid =3D THEAD_VENDO=
R_ID,<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -3063,6 +3110,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.rvv_ta_all_1s =3D true,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.misa_w =3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.pmp =3D true,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp_regions =3D 8,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.cbom_blocksize =3D 64,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.cbop_blocksize =3D 64,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.cboz_blocksize =3D 64,<br=
>
&gt; @@ -3119,6 +3167,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.ext_zifencei =3D true,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.ext_zicsr =3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.pmp =3D true,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp_regions =3D 8,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.ext_zicbom =3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.cbom_blocksize =3D 64,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.cboz_blocksize =3D 64,<br=
>
&gt; @@ -3163,6 +3212,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D=
 {<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.mmu =3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.pmp =3D true,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cfg.pmp_regions =3D 8,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cfg.max_satp_mode =3D VM_1_10=
_SV39,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0),<br>
&gt; diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h<br>
&gt; index 229ade9ed9..67323a7d9d 100644<br>
&gt; --- a/target/riscv/cpu.h<br>
&gt; +++ b/target/riscv/cpu.h<br>
&gt; @@ -159,7 +159,8 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_im=
plied_rules[];<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#define MMU_USER_IDX 3<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -#define MAX_RISCV_PMPS (16)<br>
&gt; +#define MAX_RISCV_PMPS (64)<br>
&gt; +#define OLD_MAX_RISCV_PMPS (16)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#if !defined(CONFIG_USER_ONLY)<br>
&gt;=C2=A0 =C2=A0#include &quot;pmp.h&quot;<br>
&gt; diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_=
fields.h.inc<br>
&gt; index 59f134a419..33c4f9bac8 100644<br>
&gt; --- a/target/riscv/cpu_cfg_fields.h.inc<br>
&gt; +++ b/target/riscv/cpu_cfg_fields.h.inc<br>
&gt; @@ -163,6 +163,7 @@ TYPED_FIELD(uint16_t, elen, 0)<br>
&gt;=C2=A0 =C2=A0TYPED_FIELD(uint16_t, cbom_blocksize, 0)<br>
&gt;=C2=A0 =C2=A0TYPED_FIELD(uint16_t, cbop_blocksize, 0)<br>
&gt;=C2=A0 =C2=A0TYPED_FIELD(uint16_t, cboz_blocksize, 0)<br>
&gt; +TYPED_FIELD(uint8_t,=C2=A0 pmp_regions, 0)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0TYPED_FIELD(int8_t, max_satp_mode, -1)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/target/riscv/csr.c b/target/riscv/csr.c<br>
&gt; index d6cd441133..6296ecd1e1 100644<br>
&gt; --- a/target/riscv/csr.c<br>
&gt; +++ b/target/riscv/csr.c<br>
&gt; @@ -738,7 +738,10 @@ static RISCVException dbltrp_hmode(CPURISCVState =
*env, int csrno)<br>
&gt;=C2=A0 =C2=A0static RISCVException pmp(CPURISCVState *env, int csrno)<b=
r>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (riscv_cpu_cfg(env)-&gt;pmp) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (csrno &lt;=3D CSR_PMPCFG3) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int max_pmpcfg =3D (env-&gt;priv_ver &gt;=
=3D PRIV_VERSION_1_12_0) ?<br>
&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CSR_PMPCFG15 : CSR_PMPCFG3;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (csrno &lt;=3D max_pmpcfg) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t reg_ind=
ex =3D csrno - CSR_PMPCFG0;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* TODO: RV128 r=
estriction check */<br>
&gt; diff --git a/target/riscv/machine.c b/target/riscv/machine.c<br>
&gt; index c97e9ce9df..1600ec44f0 100644<br>
&gt; --- a/target/riscv/machine.c<br>
&gt; +++ b/target/riscv/machine.c<br>
&gt; @@ -36,8 +36,9 @@ static int pmp_post_load(void *opaque, int version_i=
d)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RISCVCPU *cpu =3D opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CPURISCVState *env =3D &amp;cpu-&gt;env;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; +=C2=A0 =C2=A0 uint8_t pmp_regions =3D riscv_cpu_cfg(env)-&gt;pmp_regi=
ons;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; MAX_RISCV_PMPS; i++) {<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; pmp_regions; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pmp_update_rule_addr(env, i);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pmp_update_rule_nums(env);<br>
&gt; diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c<br>
&gt; index 5af295e410..3540327c9a 100644<br>
&gt; --- a/target/riscv/pmp.c<br>
&gt; +++ b/target/riscv/pmp.c<br>
&gt; @@ -122,7 +122,9 @@ uint32_t pmp_get_num_rules(CPURISCVState *env)<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0static inline uint8_t pmp_read_cfg(CPURISCVState *env, uin=
t32_t pmp_index)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 if (pmp_index &lt; MAX_RISCV_PMPS) {<br>
&gt; +=C2=A0 =C2=A0 uint8_t pmp_regions =3D riscv_cpu_cfg(env)-&gt;pmp_regi=
ons;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (pmp_index &lt; pmp_regions) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return env-&gt;pmp_state.pmp[p=
mp_index].cfg_reg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -136,7 +138,9 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *=
env, uint32_t pmp_index)<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp=
_index, uint8_t val)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 if (pmp_index &lt; MAX_RISCV_PMPS) {<br>
&gt; +=C2=A0 =C2=A0 uint8_t pmp_regions =3D riscv_cpu_cfg(env)-&gt;pmp_regi=
ons;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (pmp_index &lt; pmp_regions) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (env-&gt;pmp_state.pmp[pmp_=
index].cfg_reg =3D=3D val) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* no change */<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br=
>
&gt; @@ -236,9 +240,10 @@ void pmp_update_rule_addr(CPURISCVState *env, uin=
t32_t pmp_index)<br>
&gt;=C2=A0 =C2=A0void pmp_update_rule_nums(CPURISCVState *env)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; +=C2=A0 =C2=A0 uint8_t pmp_regions =3D riscv_cpu_cfg(env)-&gt;pmp_regi=
ons;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;pmp_state.num_rules =3D 0;<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; MAX_RISCV_PMPS; i++) {<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; pmp_regions; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const uint8_t a_field =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pmp_get_a_field(=
env-&gt;pmp_state.pmp[i].cfg_reg);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (PMP_AMATCH_OFF !=3D a_fiel=
d) {<br>
&gt; @@ -332,6 +337,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr=
 addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int pmp_size =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr s =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr e =3D 0;<br>
&gt; +=C2=A0 =C2=A0 uint8_t pmp_regions =3D riscv_cpu_cfg(env)-&gt;pmp_regi=
ons;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Short cut if no rules */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (0 =3D=3D pmp_get_num_rules(env)) {<br>
&gt; @@ -356,7 +362,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr=
 addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * 1.10 draft priv spec states there is an i=
mplicit order<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * from low to high<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; MAX_RISCV_PMPS; i++) {<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; pmp_regions; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s =3D pmp_is_in_range(env, i, =
addr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e =3D pmp_is_in_range(env, i, =
addr + pmp_size - 1);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -527,8 +533,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_=
t addr_index,<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_pmpaddr_csr_write(env-&gt;mhartid, add=
r_index, val);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool is_next_cfg_tor =3D false;<br>
&gt; +=C2=A0 =C2=A0 uint8_t pmp_regions =3D riscv_cpu_cfg(env)-&gt;pmp_regi=
ons;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 if (addr_index &lt; MAX_RISCV_PMPS) {<br>
&gt; +=C2=A0 =C2=A0 if (addr_index &lt; pmp_regions) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (env-&gt;pmp_state.pmp[addr=
_index].addr_reg =3D=3D val) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* no change */<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; @@ -538,7 +545,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_=
t addr_index,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * In TOR mode, need to check =
the lock bit of the next pmp<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * (if there is a next).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (addr_index + 1 &lt; MAX_RISCV_PMPS) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (addr_index + 1 &lt; pmp_regions) {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t pmp_cfg =
=3D env-&gt;pmp_state.pmp[addr_index + 1].cfg_reg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0is_next_cfg_tor =
=3D PMP_AMATCH_TOR =3D=3D pmp_get_a_field(pmp_cfg);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -573,8 +580,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_=
t addr_index,<br>
&gt;=C2=A0 =C2=A0target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t=
 addr_index)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong val =3D 0;<br>
&gt; +=C2=A0 =C2=A0 uint8_t pmp_regions =3D riscv_cpu_cfg(env)-&gt;pmp_regi=
ons;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 if (addr_index &lt; MAX_RISCV_PMPS) {<br>
&gt; +=C2=A0 =C2=A0 if (addr_index &lt; pmp_regions) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D env-&gt;pmp_state.pmp[=
addr_index].addr_reg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_pmpaddr_csr_read(env-&gt=
;mhartid, addr_index, val);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; @@ -592,6 +600,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_=
ulong val)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t mask =3D MSECCFG_MMWP | MSECCFG_MML=
;<br>
&gt; +=C2=A0 =C2=A0 uint8_t pmp_regions =3D riscv_cpu_cfg(env)-&gt;pmp_regi=
ons;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Update PMM field only if the value is val=
id according to Zjpm v1.0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (riscv_cpu_cfg(env)-&gt;ext_smmpm &amp;&a=
mp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0riscv_cpu_mxl(env) =3D=3D MXL_=
RV64 &amp;&amp;<br>
&gt; @@ -603,7 +612,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_=
ulong val)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* RLB cannot be enabled if it&#39;s already=
 0 and if any regions are locked */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!MSECCFG_RLB_ISSET(env)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; MAX_RISCV_PMPS; i++)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; pmp_regions; i++) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pmp_is_locke=
d(env, i)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0va=
l &amp;=3D ~MSECCFG_RLB;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0br=
eak;<br>
&gt; @@ -659,6 +668,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env, =
hwaddr addr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr tlb_sa =3D addr &amp; ~(TARGET_PAGE_S=
IZE - 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr tlb_ea =3D tlb_sa + TARGET_PAGE_SIZE =
- 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; +=C2=A0 =C2=A0 uint8_t pmp_regions =3D riscv_cpu_cfg(env)-&gt;pmp_regi=
ons;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * If PMP is not supported or there are no P=
MP rules, the TLB page will not<br>
&gt; @@ -669,7 +679,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env, =
hwaddr addr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TARGET_PAGE_SIZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; MAX_RISCV_PMPS; i++) {<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; pmp_regions; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pmp_get_a_field(env-&gt;pm=
p_state.pmp[i].cfg_reg) =3D=3D PMP_AMATCH_OFF) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
</blockquote></div>

--000000000000acaeea0636cc73fe--

