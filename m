Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D42CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENlQ-0002dr-QW; Wed, 07 Oct 2026 05:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEM2n-0001lD-26
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 03:26:41 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEM2d-0008MV-Er
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 03:26:27 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6aa97d1cbffso2530798a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 00:26:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791357971; cv=none;
 d=google.com; s=arc-20260327;
 b=NOjSEfk55AOwRP+S/GsTI37hfT8vEPeFjUZY+L9pztbrxJpzsSlnZzDezOWuSuypcR
 CR76WSuCHrNjGXyqsgjhBNCoPURXcmV9Rak8nkUKFhpXi/aBRKdg1G9cAsI1gMH0701k
 6zlmc4QSMpozpvH/HkZyQ/TGKMQvfnT6MEFgI/NPAaHLPmsRuw0OLJtlqZhu7B0CRFqx
 on96encW29awC59bKN16A2D/QEZC1rSUooZfipuL8MtG9P95F21Lqovz8UIJ3+mVU09Y
 +si490xgxX226Mde1RxEL+OwtcRf0pvg1S5RF5XrW9CdVdOevDP1+Z8rXhQ1XOS7nlZE
 D+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=IYJ4GEz8V0Itcmv+R83YQloRwoIsKUUFi4LazpxdnMw=;
 fh=thzEKEaFN6tU38sXyx2/DVeRmK43ws63SfWnaHyeRsI=;
 b=OvO6PNZZ+2Wb0SF4TRj1KFc9N/TWSGFI1yfz9PNL8P+gq7CzasoFoGZm6gvDTEzGTU
 zPKdvSbklMrxeyZ4KBJAKP6d2gJn7n8HTS5k13AJ/gIqjbZVVhSSugAFydIoFZNLuu4t
 61p8uCp1psrOnJ0xhUETs2z4oHGdLd43F6Prn5jaQHYvr1t/hzSVEPltJNyHrysG7WiE
 TtDQsI6i6i2VI1Z9bhe1OmGmgx0nw7qsQj+YnfO6n9LikVMeh3xL0qgCDeWDmFCWKe64
 Kpum59woRJ7OJAjZHJyh5HTh8w2UPx4Mq/bXc6MmAEb7ToOBg1+1DYl3flWfCVKpWCV/
 92wg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791357971; x=1791962771; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IYJ4GEz8V0Itcmv+R83YQloRwoIsKUUFi4LazpxdnMw=;
 b=ianK6LOcbpECbEbSkThnK2DJ2oa4OFVT53N05U8YY0UyxF3ZXeTxEvG+QiSnYWa3H8
 ao8UW0p8T0IuTMgIe4SPqOZF2mVsHOROqB6ypz6ciWbNeKIzfcaHQlsEO7HzbgSxacBX
 tPyB109Ae5V6Y6WDpFXJXwMOu3UDh+Y+SK8hMOFGAC1IOowDXkngGkQPHPcBN4WFqRNx
 vr/fWd9RsKXiXYC/VJDoJr4cWgRhv4q/61YCDUXp2W1+defR1/Vqmskxn4hyUzFN9gK8
 MYMKWkXXSCAThVClmsvIjccmJcK/hwRLpRDRx0X3O2vmPcp/zOzdX37tmyQQ9G0Wzz2p
 GLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791357971; x=1791962771;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IYJ4GEz8V0Itcmv+R83YQloRwoIsKUUFi4LazpxdnMw=;
 b=2HG36ShDzP3OovLTTGvxWbbOYozXWDo38vxKx3Kd7USx/toug8Pymw1Ih4qikZ9Brh
 cptMUwNRYXzeoZ4VaVn8YYT6E2qfjaXyWE95fk/5clTxThgXn6K0CLWqtDHCB/xIBSpo
 ji+FttrEd65d1TEYSu7Sm5Mj3DDGRCQ2SlMVEN8LPj6VCIxmUEYhTdEkNn0/DYh9ZjLc
 Zce2E6KGtYE6VNdx5P9neGF+luxlvZNOKZFaG8kCLops2q5tlC4uyt8Vv1NypqNb9twK
 +lmtNLTtp0dknhhR6FRCs8ZGomxObZTMGkeXJpsqWZFBwLiWukBKk96iKRJHDKDz/F/L
 Yy0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLIcbkh/uEAtEzpdpKotHj3jzj61mhov6Pla8uItTUSbzoVBt/dyvkqzJ/FkaN72NO6/4K2TGgHa3u@nongnu.org
X-Gm-Message-State: AFq9FYK3tzgu96WYTjpCrzKtN33R1djdEsSdon81fV9iZYnwgDnd/MaB
 EGif3Nn+/MAXebUoCB9+YVhN8S5x0u9Kmutv6pNnBFqZGPEP+o1vVIbeuEd5LDAZVYHdyBSFB83
 FdxvlkcZeBO2PG1ehc2Y/MlLDXjQrJkw=
X-Gm-Gg: AYBFou0f/0ITYcFNUiHW+uorEjf5NeSfEcYPhW4kvr2K+BiQ6fricMOPpWejzHpa5CU
 VNYe+jiDwoY9/Nbf/aJOt0SL440XK2Hm4Gqr3fBsuW4mpt5B+tv68BdRKEs6Sv/+1tgqSqREUkh
 xVuZhA0FmnCvVtVg173U2LV5d/f6WpXHFqF6VAJYtkL80T/208M9WGJfydaFXJ4elLVQLT35BLY
 7wZ0cAfA5+tyGqslvu7gFJvqHNGMIqi1d81fBiadjhrI1ePG+LUv6tOwVcWuk5no5n4LROKCHeR
 UHzDkMPI3QKX9wLDiEw3rWY+RuX30a5Eob0lsDJPluOwnxHkSboMN4mpnQ8JBV+roA==
X-Received: by 2002:a05:6402:a0d2:b0:6ae:1504:5ba with SMTP id
 4fb4d7f45d1cf-6aff47a0e11mr957925a12.30.1791357971342; Wed, 07 Oct 2026
 00:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-7-ea69b07afd31@rev.ng>
 <CAE2XoE_ag1RR_JFwgcg+9zPed+qpO2skf7W1_kiqvwB=Vf9aAQ@mail.gmail.com>
 <f8f27bc3-83ce-4ccf-ae38-a43188b2ebc5@oss.qualcomm.com>
 <ar_AzEWpF9XDGNdg@hive.localdomain>
 <CAE2XoE_vsVDXH2qggECnqHC8dMpo7zyTTg9w64uvjnPeXE9y6A@mail.gmail.com>
 <asUMlHlLI7j5MTUf@hive.localdomain>
In-Reply-To: <asUMlHlLI7j5MTUf@hive.localdomain>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 7 Oct 2026 15:25:58 +0800
X-Gm-Features: AclHuK_thFqASHhBOvSen0wo0Vp3n6bY-7YzlPzrdQmxY0HHxzfAPrmlZ2w80LQ
Message-ID: <CAE2XoE9G1tOrWXcpf240woCF-==a4YcxTZ4pS9o5WxtPExWFjw@mail.gmail.com>
Subject: Re: [PATCH 07/18] target/riscv: Runtime register MAX and BARE CPUs
To: Anton Johansson <anjo@rev.ng>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com, 
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 7, 2026 at 7:09=E2=80=AFAM Anton Johansson <anjo@rev.ng> wrote:
>
> On 02/10/26, Yonggang Luo wrote:
> > target/riscv: resolve target-dependent CPU definition fields
> >
> > The class-base initializer later reads def->misa_mxl_max and passes
> > def->cfg to riscv_cpu_cfg_merge(), which merges max_satp_mode. Resolve
> > both chooser results in a mutable copy so those steps use the selected
> > values without modifying the const TypeInfo class data.
> >
> >
> > defer riscv_cpu_validate_misa_mxl is not enough, mainly
> > def->misa_mxl_max is accessed in
> > riscv_cpu_class_base_init, for exactly match previous behavior, add
> > two callback for each value
>
> Right, we would have to move more stuff to instance init which isn't the
> best idea.  Personally I'm still not keen on adding more callbacks to
> initialize two fields for two cpus, surely this is solvable with the
> current machinery.  I'll submit a v2 and try defining two tables for
> MAX/BARE instead, similar to ARM.


Make sense, thanks

>
> >
> > On Fri, Oct 2, 2026 at 11:36=E2=80=AFPM Anton Johansson <anjo@rev.ng> w=
rote:
> > >
> > > On 02/10/26, Pierrick Bouvier wrote:
> > > > On 10/1/2026 9:28 AM, Yonggang Luo wrote:
> > > > > On Thu, Oct 1, 2026 at 11:55=E2=80=AFPM Anton Johansson via qemu =
development
> > > > > <qemu-devel@nongnu.org> wrote:
> > > > >>
> > > > >> Moves initialization of satp and mxl fields to a class initializ=
ation
> > > > >> function that checks target_riscv64().
> > > > >>
> > > > >> Note: I'm aware the current iteration of this patch is rather ha=
cky, I
> > > > >> don't like the introduction of runtime_misa_mxl_max, but I'm kee=
ping
> > > > >> this in to get the series out there and collect feedback.
> > > > >>
> > > > >> Signed-off-by: Anton Johansson <anjo@rev.ng>
> > > > >> ---
> > > > >>  target/riscv/cpu.h |  1 +
> > > > >>  target/riscv/cpu.c | 90 +++++++++++++++++++++++++++++++++++----=
---------------
> > > > >>  2 files changed, 59 insertions(+), 32 deletions(-)
> > > > >>
> > > > >
> > > > > This patch is how I handle these, just for reference, not a revie=
w.
> > > >
> > > > Yonggang approach looks cleaner, I would favor this one.
> > >
> > > I'm personally not a huge fan, it still feels rather hacky. Why add a
> > > completely new RISCVCPUDef::target_init just to make sure fields are
> > > initialized before riscv_cpu_validate_misa_mxl()? Wouldn't moving the
> > > check to a later point, maybe .instance_init, be better? Then for
> > > riscv_cpu_init() we get
> > >
> > >   riscv_cpu_validate_misa_mxl(mcc);
> > >   env->misa_mxl =3D mcc->def->misa_mxl_max;
> > >
> > > misa_mxl_max would be verified only during instance rather than
> > > class initialization, which seems like a decent tradeoff for a simple=
r
> > > solution.
> > >
> > > --
> > > Anton Johansson
> > > rev.ng Labs Srl.
> >
> >
> >
> > --
> >          =E6=AD=A4=E8=87=B4
> > =E7=A4=BC
> > =E7=BD=97=E5=8B=87=E5=88=9A
> > Yours
> >     sincerely,
> > Yonggang Luo
>
> > From 31138892fe5cf878da9818cf93535ce10b125cb0 Mon Sep 17 00:00:00 2001
> > From: Yonggang Luo <luoyonggang@gmail.com>
> > Date: Sat, 3 Oct 2026 01:54:52 +0800
> > Subject: [PATCH] target/riscv: resolve target-dependent CPU definition =
fields
> >
> > The class-base initializer later reads def->misa_mxl_max and passes
> > def->cfg to riscv_cpu_cfg_merge(), which merges max_satp_mode. Resolve
> > both chooser results in a mutable copy so those steps use the selected
> > values without modifying the const TypeInfo class data.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  target/riscv/cpu.c | 40 +++++++++++++++++++++++++++-------------
> >  target/riscv/cpu.h |  2 ++
> >  2 files changed, 29 insertions(+), 13 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index c6f1739075..754f158250 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -3092,6 +3092,8 @@ static void riscv_cpu_class_base_init(ObjectClass=
 *c, const void *data)
> >
> >      if (pcc->def) {
> >          mcc->def =3D g_memdup2(pcc->def, sizeof(*pcc->def));
> > +        mcc->def->max_satp_mode_choose =3D NULL;
> > +        mcc->def->misa_mxl_max_choose =3D NULL;
> >      } else {
> >          mcc->def =3D g_new0(RISCVCPUDef, 1);
> >      }
> > @@ -3108,7 +3110,16 @@ static void riscv_cpu_class_base_init(ObjectClas=
s *c, const void *data)
> >  #endif
> >
> >      if (data) {
> > -        const RISCVCPUDef *def =3D data;
> > +        RISCVCPUDef def_data =3D *(const RISCVCPUDef *)data;
> > +        RISCVCPUDef *def =3D &def_data;
> > +
> > +        if (def->max_satp_mode_choose) {
> > +            def->cfg.max_satp_mode =3D def->max_satp_mode_choose(def);
> > +        }
> > +        if (def->misa_mxl_max_choose) {
> > +            def->misa_mxl_max =3D def->misa_mxl_max_choose(def);
> > +        }
> > +
> >          mcc->def->bare |=3D def->bare;
> >          if (def->profile) {
> >              assert(profile_extends(def->profile, mcc->def->profile));
> > @@ -3299,6 +3310,18 @@ static void riscv_cpu_instance_finalize(Object *=
obj)
> >      g_clear_pointer(&cpu->multi_ext_user_opts, g_hash_table_destroy);
> >  }
> >
> > +static int8_t riscv_cpu_max_satp_mode_choose(const RISCVCPUDef *def)
> > +{
> > +    (void)def;
> > +    return target_riscv32() ? VM_1_10_SV32 : VM_1_10_SV57;
> > +}
> > +
> > +static RISCVMXL riscv_cpu_misa_mxl_max_choose(const RISCVCPUDef *def)
> > +{
> > +    (void)def;
> > +    return target_riscv32() ? MXL_RV32 : MXL_RV64;
> > +}
> > +
> >  static const TypeInfo riscv_cpu_type_infos[] =3D {
> >      {
> >          .name =3D TYPE_RISCV_CPU,
> > @@ -3339,21 +3362,12 @@ static const TypeInfo riscv_cpu_type_infos[] =
=3D {
> >           * only MBARE will be available if the user doesn't enable
> >           * a mode manually (see riscv_cpu_satp_mode_finalize()).
> >           */
> > -#ifdef TARGET_RISCV32
> > -        .cfg.max_satp_mode =3D VM_1_10_SV32,
> > -#else
> > -        .cfg.max_satp_mode =3D VM_1_10_SV57,
> > -#endif
> > +        .max_satp_mode_choose =3D riscv_cpu_max_satp_mode_choose,
> >      ),
> >
> >      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX, TYPE_RISCV_DYNAMIC_CPU,
> > -#if defined(TARGET_RISCV32)
> > -        .misa_mxl_max =3D MXL_RV32,
> > -        .cfg.max_satp_mode =3D VM_1_10_SV32,
> > -#elif defined(TARGET_RISCV64)
> > -        .misa_mxl_max =3D MXL_RV64,
> > -        .cfg.max_satp_mode =3D VM_1_10_SV57,
> > -#endif
> > +        .max_satp_mode_choose =3D riscv_cpu_max_satp_mode_choose,
> > +        .misa_mxl_max_choose =3D riscv_cpu_misa_mxl_max_choose,
> >      ),
> >
> >      DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E, TYPE_RISCV_VEND=
OR_CPU,
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 034d7e96c4..b6b5f679c9 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -597,6 +597,8 @@ typedef struct RISCVCPUDef {
> >  #endif
> >      /* This is just a setter for env->num_triggers.  */
> >      uint32_t num_triggers;
> > +    int8_t (*max_satp_mode_choose)(const struct RISCVCPUDef *def);
> > +    RISCVMXL (*misa_mxl_max_choose)(const struct RISCVCPUDef *def);
> >  } RISCVCPUDef;
> >
> >  /**
> > --
> > 2.55.0.windows.3
> >



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

