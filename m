Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C497FC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 04:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raTA0-00083c-Ll; Wed, 14 Feb 2024 23:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raT9z-000832-F5; Wed, 14 Feb 2024 23:15:43 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raT9v-0004pA-36; Wed, 14 Feb 2024 23:15:43 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4c0375d438eso196224e0c.0; 
 Wed, 14 Feb 2024 20:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707970537; x=1708575337; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c73KorNCwxryw04w7c3bm7d0P3hEWjKSU+6XhRXJSk4=;
 b=lgZjjEiHidGYddJvL57Yb8zdg8gf5WDOo4GNpeVKlVaA74jwBVusxGQHkMHTHwp8L5
 9bkctOm0QCQC4L+owBxLGEi63ZPll1a4x3d7uhCuNOL3e+NzezH4g1DHWsbNNnC0bKmR
 zFh//AU56nZvNEyKPCcydeHmq+AXZHfNFv6qcsGwLMehlMY+TXXPmWmPdJ5ejww+3wE9
 +7+MaI7ZMiE0854Tvc3UN2jGXN5q6ugrrhGrtvcFo/8caHA2x/XWYwDGCsEk3PG19NZW
 UH/B3ohqCmSRmleBT+IY2w3XMdWXHUqOwkJvRrpw8eq1Lefrp+ghsTF9FnqjMlsu237B
 9mVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707970537; x=1708575337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c73KorNCwxryw04w7c3bm7d0P3hEWjKSU+6XhRXJSk4=;
 b=PVbVyncoLl8nv6ktR4eQu/DSHIbvPL/xjOYe9smTPBtM53AyFZdar5c/1kca//kCwQ
 GKWIHN/mNetrRNn1aelOrcUKPpfkNI7PdE7DizIgVEHtnm5/akhvjxjq5eI+9CQi7FLg
 b5xdAbhZD41pbKIdKLgWYUSn55lc33WybWtu3Ijs54AMTSUtrGrz5U7pGn1zoGKPSf4s
 ZI6Ul+aWfM+hTc8z5DdD12DOQvR6xhB5AvFAj+6XsfIhcNtai9Rc8Erhs+mtY3BCJZsT
 IYr1+2lGPJ3nsK9qZUGDxb7O/7CYPfYLB0nDl63zWzoNvBBQhSGj4PdaBtSKgZD0XRqK
 mPvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlNRq3xyxoDrHY5ehphGQzgPIAXIRUI3fK48s1K5BNyNy+goctxdFBZ2Ocb6bak0Cg5r9BR343RdtwRQLuI+KWOmeM83E=
X-Gm-Message-State: AOJu0YyEPfJWpF4mpkAfNJeLfjGeoKyHq4kigKUEeq90D+ron96v+Syu
 H//u4J9Lg8H6zvfHhOK+cGnFNBZOE4yDTUdLpbgDDzWxWNpum+zfP7lQkbMTitz5+pbzUpWFtEd
 YZNUHi3xPoeceOiNHP8vnGDSVXF4=
X-Google-Smtp-Source: AGHT+IFZcOtLnpdW35+7Kd633uEWq+F+wDIs6O22fQvuxZl3moGa4B2cSEgCPAni3LejPtjyiBMa1AsLFxH0o561Ix8=
X-Received: by 2002:a1f:d847:0:b0:4c0:683a:d114 with SMTP id
 p68-20020a1fd847000000b004c0683ad114mr489298vkg.15.1707970537432; Wed, 14 Feb
 2024 20:15:37 -0800 (PST)
MIME-Version: 1.0
References: <20240126133101.61344-8-ajones@ventanamicro.com>
 <20240126133101.61344-11-ajones@ventanamicro.com>
In-Reply-To: <20240126133101.61344-11-ajones@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 14:15:11 +1000
Message-ID: <CAKmqyKPUDGp9xXi5dvsF_bgrsZTEhcHRR41zCYwAqv4c9q6gMA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] target/riscv: add remaining named features
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Fri, Jan 26, 2024 at 11:33=E2=80=AFPM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>
> The RVA22U64 and RVA22S64 profiles mandates certain extensions that,
> until now, we were implying that they were available.
>
> We can't do this anymore since named features also has a riscv,isa
> entry.  Let's add them to riscv_cpu_named_features[].
>
> They will also need to be explicitly enabled in both profile
> descriptions. TCG will enable the named features it already implements,
> other accelerators are free to handle it as they like.
>
> After this patch, here's the riscv,isa from a buildroot using the
> 'rva22s64' CPU:
>
>  # cat /proc/device-tree/cpus/cpu@0/riscv,isa
> rv64imafdc_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_ziccrse_
> zicntr_zicsr_zifencei_zihintpause_zihpm_za64rs_zfhmin_zca_zcd_zba_zbb_
> zbs_zkt_sscounterenw_sstvala_sstvecd_svade_svinval_svpbmt#
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  target/riscv/cpu.c         | 41 +++++++++++++++++++++++++++++---------
>  target/riscv/cpu_cfg.h     |  9 +++++++++
>  target/riscv/tcg/tcg-cpu.c | 19 +++++++++++++++++-
>  3 files changed, 59 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 28d3cfa8ce59..1ecd8a57ed02 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -101,6 +101,10 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
>      ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
>      ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
> +    ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, ext_ziccamoa),
> +    ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, ext_ziccif),
> +    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_zicclsm),
> +    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
>      ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
>      ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
>      ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
> @@ -109,6 +113,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause=
),
>      ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
>      ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
> +    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, ext_za64rs),
>      ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
>      ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
>      ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
> @@ -170,8 +175,12 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
> +    ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, ext_ssccptr),
>      ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
> +    ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, ext_sscountere=
nw),
>      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
> +    ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, ext_sstvala),
> +    ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, ext_sstvecd),
>      ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
>      ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
>      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
> @@ -1523,6 +1532,22 @@ const RISCVCPUMultiExtConfig riscv_cpu_named_featu=
res[] =3D {
>      MULTI_EXT_CFG_BOOL("svade", ext_svade, true),
>      MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
>
> +    /*
> +     * cache-related extensions that are always enabled
> +     * since QEMU RISC-V does not have a cache model.
> +     */
> +    MULTI_EXT_CFG_BOOL("za64rs", ext_za64rs, true),
> +    MULTI_EXT_CFG_BOOL("ziccif", ext_ziccif, true),
> +    MULTI_EXT_CFG_BOOL("ziccrse", ext_ziccrse, true),
> +    MULTI_EXT_CFG_BOOL("ziccamoa", ext_ziccamoa, true),
> +    MULTI_EXT_CFG_BOOL("zicclsm", ext_zicclsm, true),
> +    MULTI_EXT_CFG_BOOL("ssccptr", ext_ssccptr, true),
> +
> +    /* Other named features that QEMU TCG always implements */
> +    MULTI_EXT_CFG_BOOL("sstvecd", ext_sstvecd, true),
> +    MULTI_EXT_CFG_BOOL("sstvala", ext_sstvala, true),
> +    MULTI_EXT_CFG_BOOL("sscounterenw", ext_sscounterenw, true),
> +
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> @@ -2116,13 +2141,8 @@ static const PropertyInfo prop_marchid =3D {
>  };
>
>  /*
> - * RVA22U64 defines some 'named features' or 'synthetic extensions'
> - * that are cache related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
> - * and Zicclsm. We do not implement caching in QEMU so we'll consider
> - * all these named features as always enabled.
> - *
> - * There's no riscv,isa update for them (nor for zic64b, despite it
> - * having a cfg offset) at this moment.
> + * RVA22U64 defines some cache related extensions: Za64rs,
> + * Ziccif, Ziccrse, Ziccamoa and Zicclsm.
>   */
>  static RISCVCPUProfile RVA22U64 =3D {
>      .parent =3D NULL,
> @@ -2139,7 +2159,9 @@ static RISCVCPUProfile RVA22U64 =3D {
>          CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
>
>          /* mandatory named features for this profile */
> -        CPU_CFG_OFFSET(ext_zic64b),
> +        CPU_CFG_OFFSET(ext_za64rs), CPU_CFG_OFFSET(ext_zic64b),
> +        CPU_CFG_OFFSET(ext_ziccif), CPU_CFG_OFFSET(ext_ziccrse),
> +        CPU_CFG_OFFSET(ext_ziccamoa), CPU_CFG_OFFSET(ext_zicclsm),
>
>          RISCV_PROFILE_EXT_LIST_END
>      }
> @@ -2170,7 +2192,8 @@ static RISCVCPUProfile RVA22S64 =3D {
>          CPU_CFG_OFFSET(ext_svinval),
>
>          /* rva22s64 named features */
> -        CPU_CFG_OFFSET(ext_svade),
> +        CPU_CFG_OFFSET(ext_sstvecd), CPU_CFG_OFFSET(ext_sstvala),
> +        CPU_CFG_OFFSET(ext_sscounterenw), CPU_CFG_OFFSET(ext_svade),
>
>          RISCV_PROFILE_EXT_LIST_END
>      }
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 698f926ab1be..f79fc3dfd199 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -125,6 +125,15 @@ struct RISCVCPUConfig {
>      /* Named features  */
>      bool ext_svade;
>      bool ext_zic64b;
> +    bool ext_za64rs;
> +    bool ext_ziccif;
> +    bool ext_ziccrse;
> +    bool ext_ziccamoa;
> +    bool ext_zicclsm;
> +    bool ext_ssccptr;
> +    bool ext_sstvecd;
> +    bool ext_sstvala;
> +    bool ext_sscounterenw;

Daniel and I have discussed this a bit before. This doesn't feel
right. We are adding variables that must always be true. To me this
seems confusing to anyone reading the code in the future. I understand
it isn't exposed to users, but it still feels odd.

I guess it's nice that we reuse the same logic and this is in some
ways cleaner than an "always_true", but it just seems clunky.
Especially as this list seems to be growing very quickly.

>
>      /* Vendor-specific custom extensions */
>      bool ext_xtheadba;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 90861cc065e5..6d5028cf84d0 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -206,7 +206,8 @@ static void riscv_cpu_enable_named_feat(RISCVCPU *cpu=
, uint32_t feat_offset)
>          cpu->cfg.ext_svadu =3D false;
>          break;
>      default:
> -        g_assert_not_reached();
> +        /* Named feature already enabled in riscv_tcg_cpu_instance_init =
*/
> +        return;
>      }
>  }
>
> @@ -1342,6 +1343,20 @@ static bool riscv_cpu_has_max_extensions(Object *c=
pu_obj)
>      return object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_MAX) !=3D NULL;
>  }
>
> +/* Named features that TCG always implements */
> +static void riscv_tcg_cpu_enable_named_feats(RISCVCPU *cpu)
> +{
> +    cpu->cfg.ext_za64rs =3D true;
> +    cpu->cfg.ext_ziccif =3D true;
> +    cpu->cfg.ext_ziccrse =3D true;
> +    cpu->cfg.ext_ziccamoa =3D true;
> +    cpu->cfg.ext_zicclsm =3D true;
> +    cpu->cfg.ext_ssccptr =3D true;
> +    cpu->cfg.ext_sstvecd =3D true;
> +    cpu->cfg.ext_sstvala =3D true;
> +    cpu->cfg.ext_sscounterenw =3D true;

Maybe we should assert that these are all true somewhere in the CPU
init/realise/reset. That at least indicates to someone using the code
that these can't actually be disabled.

@Daniel Henrique Barboza that might be a reasonable compromise as I
know I complained to you about the same thing. Unless you have
implemented something really clean and nice :)

Alistair

> +}
> +
>  static void riscv_tcg_cpu_instance_init(CPUState *cs)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
> @@ -1354,6 +1369,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *c=
s)
>      if (riscv_cpu_has_max_extensions(obj)) {
>          riscv_init_max_cpu_extensions(obj);
>      }
> +
> +    riscv_tcg_cpu_enable_named_feats(cpu);
>  }
>
>  static void riscv_tcg_cpu_init_ops(AccelCPUClass *accel_cpu, CPUClass *c=
c)
> --
> 2.43.0
>
>

