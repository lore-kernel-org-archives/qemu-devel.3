Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45F4C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 12:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9NRg-00085r-NJ; Mon, 28 Apr 2025 08:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9NRY-0007y1-04
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9NRS-0005xY-Hb
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745842710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=85AyiEuKw37TnKlHYD5OdwAalQSw23HWyewxBLBSnDA=;
 b=NTsJhcLlS/qY/xJIoFwm8xiBsdp0oCm3OSKRpjkz8jtQV7s3MhMjxMfwn4nvwc9dRMvpI1
 ynjhSVyrI5k65Ep1UvaxGNyzAauBN4kax/7jfD7RjtyIhoZCZYD9Gu1BWNSxtcNGN2ZBCX
 vX1WoYX3rV7prcnnYNCRvhAIC6YSF+w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-fuixBHXlNyG8RxN3Z35H4g-1; Mon, 28 Apr 2025 08:17:21 -0400
X-MC-Unique: fuixBHXlNyG8RxN3Z35H4g-1
X-Mimecast-MFC-AGG-ID: fuixBHXlNyG8RxN3Z35H4g_1745842640
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-44059976a1fso18839625e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 05:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745842639; x=1746447439;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=85AyiEuKw37TnKlHYD5OdwAalQSw23HWyewxBLBSnDA=;
 b=bGBPZsZ7eatPfxwwWuU/OQaiOv06tExPrHfITjdcS7AsB8ELNjNqfvw2XYLB5sUAFt
 LC/mUu7EhHupZ7/meOU2s4iu38vDxfT1f8Bbd1ktMIgzgQJ529JaE6TuEokQdCph0+ih
 QmASk5hsvd8S1N+vn+mCOznln7w7xdhqc4hQLJxNzCdO2YZN43fkecdQ8GFNa/cyvb78
 ZY4AdmFBG/sd2m2ALKMKfWC2wT5B4D78hoiXwW7Vdp509M3tzjdiJDghx8T4tt2TaB2C
 osMobyRia2ThYv4eRMg/AKypnGXShdyeJt5sWlRZKOZMLIUpevwo4BQhPGIn9zpN+OnA
 NlrA==
X-Gm-Message-State: AOJu0YxTgKBuyvAdPQe6EPjqdf96nb+uFZTCV5WA9NkE2woHTZbVR/ES
 r3rzG/dx7OMT5TIyz7vlwtgS4vIjQstGn76vS0GsM0Aotkp9KIAsrowpCOBODTyWg4QvrVkPgqC
 Cu7AtCvDjvP82Dzp55C97Gz+EHEFiVpM+P7ml0TipLNBxeh8OXo4B/wuvR3SW1DBF2wmNJh5KwQ
 dS9SH3h6N1cudd1Icm5SRUv5EPpKQUxsjM7GUHnQ==
X-Gm-Gg: ASbGnctileo4aMyMOMkupMv1o2hfhAVmu5GvkC/01uXNwe4h0LYkqBf7yKmE6qD4Xcw
 jMW7DSVZTtwrnPs2VYpeDz/1uBbsJLDquDeD5BqGGAkBQLXDYKR6R42DDOEfuKX6rxa+b
X-Received: by 2002:a5d:64ed:0:b0:39c:142d:c0a with SMTP id
 ffacd0b85a97d-3a074e233bcmr8346489f8f.19.1745842639484; 
 Mon, 28 Apr 2025 05:17:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlZa/afQ/Qvz+9b3p9P/PPkUEBUQrwbhVmN4IBE/Fd8SkAnBcQiy7Bg2qZcSUP/d6kLfFwLuAspZYJbXPNE00=
X-Received: by 2002:a5d:64ed:0:b0:39c:142d:c0a with SMTP id
 ffacd0b85a97d-3a074e233bcmr8346471f8f.19.1745842639077; Mon, 28 Apr 2025
 05:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250428073442.315770-1-pbonzini@redhat.com>
 <20250428073442.315770-9-pbonzini@redhat.com>
 <30770d2b-ac76-4d13-b8f2-ca39c0b82e0f@ventanamicro.com>
In-Reply-To: <30770d2b-ac76-4d13-b8f2-ca39c0b82e0f@ventanamicro.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 28 Apr 2025 14:17:07 +0200
X-Gm-Features: ATxdqUHYroJ4HglSKbajTSSIbCcDau1Pq4_ZpQxiXIHK0QfR5z0HsTn1tPpCpIc
Message-ID: <CABgObfZX1j4N=Oeq9Y=_YeccCq7--s0=r5DaANA+iA1UnoJyVg@mail.gmail.com>
Subject: Re: [PATCH 08/26] target/riscv: store RISCVCPUDef struct directly in
 the class
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Apr 28, 2025 at 1:50=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 4/28/25 4:34 AM, Paolo Bonzini wrote:
> > Prepare for adding more fields to RISCVCPUDef and reading them in
> > riscv_cpu_init: instead of storing the misa_mxl_max field in
> > RISCVCPUClass, ensure that there's always a valid RISCVCPUDef struct
> > and go through it.
> >
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   target/riscv/cpu.h         |  2 +-
> >   hw/riscv/boot.c            |  2 +-
> >   target/riscv/cpu.c         | 23 ++++++++++++++++++-----
> >   target/riscv/gdbstub.c     |  6 +++---
> >   target/riscv/kvm/kvm-cpu.c | 21 +++++++++------------
> >   target/riscv/machine.c     |  2 +-
> >   target/riscv/tcg/tcg-cpu.c | 10 +++++-----
> >   target/riscv/translate.c   |  2 +-
> >   8 files changed, 39 insertions(+), 29 deletions(-)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 62e303f0635..842c9d3f194 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -553,7 +553,7 @@ struct RISCVCPUClass {
> >
> >       DeviceRealize parent_realize;
> >       ResettablePhases parent_phases;
> > -    RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
> > +    RISCVCPUDef *def;
> >   };
> >
> >   static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > index 765b9e2b1ab..828a867be39 100644
> > --- a/hw/riscv/boot.c
> > +++ b/hw/riscv/boot.c
> > @@ -37,7 +37,7 @@
> >   bool riscv_is_32bit(RISCVHartArrayState *harts)
> >   {
> >       RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(&harts->harts[0]);
> > -    return mcc->misa_mxl_max =3D=3D MXL_RV32;
> > +    return mcc->def->misa_mxl_max =3D=3D MXL_RV32;
> >   }
> >
> >   /*
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index f30cf1b532b..d8c189d596b 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -357,7 +357,7 @@ void riscv_cpu_set_misa_ext(CPURISCVState *env, uin=
t32_t ext)
> >
> >   int riscv_cpu_max_xlen(RISCVCPUClass *mcc)
> >   {
> > -    return 16 << mcc->misa_mxl_max;
> > +    return 16 << mcc->def->misa_mxl_max;
> >   }
> >
> >   #ifndef CONFIG_USER_ONLY
> > @@ -1048,7 +1048,7 @@ static void riscv_cpu_reset_hold(Object *obj, Res=
etType type)
> >           mcc->parent_phases.hold(obj, type);
> >       }
> >   #ifndef CONFIG_USER_ONLY
> > -    env->misa_mxl =3D mcc->misa_mxl_max;
> > +    env->misa_mxl =3D mcc->def->misa_mxl_max;
> >       env->priv =3D PRV_M;
> >       env->mstatus &=3D ~(MSTATUS_MIE | MSTATUS_MPRV);
> >       if (env->misa_mxl > MXL_RV32) {
> > @@ -1450,7 +1450,7 @@ static void riscv_cpu_init(Object *obj)
> >       RISCVCPU *cpu =3D RISCV_CPU(obj);
> >       CPURISCVState *env =3D &cpu->env;
> >
> > -    env->misa_mxl =3D mcc->misa_mxl_max;
> > +    env->misa_mxl =3D mcc->def->misa_mxl_max;
> >
> >   #ifndef CONFIG_USER_ONLY
> >       qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
> > @@ -1544,7 +1544,7 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPUC=
lass *mcc)
> >       CPUClass *cc =3D CPU_CLASS(mcc);
> >
> >       /* Validate that MISA_MXL is set properly. */
> > -    switch (mcc->misa_mxl_max) {
> > +    switch (mcc->def->misa_mxl_max) {
> >   #ifdef TARGET_RISCV64
> >       case MXL_RV64:
> >       case MXL_RV128:
> > @@ -3071,12 +3071,24 @@ static void riscv_cpu_common_class_init(ObjectC=
lass *c, const void *data)
> >       device_class_set_props(dc, riscv_cpu_properties);
> >   }
> >
> > +static void riscv_cpu_class_base_init(ObjectClass *c, const void *data=
)
> > +{
> > +    RISCVCPUClass *mcc =3D RISCV_CPU_CLASS(c);
> > +    RISCVCPUClass *pcc =3D RISCV_CPU_CLASS(object_class_get_parent(c))=
;
> > +
> > +    if (pcc->def) {
> > +        mcc->def =3D g_memdup2(pcc->def, sizeof(*pcc->def));
> > +    } else {
> > +        mcc->def =3D g_new0(RISCVCPUDef, 1);
> > +    }
> > +}
> > +
> >   static void riscv_cpu_class_init(ObjectClass *c, const void *data)
> >   {
> >       RISCVCPUClass *mcc =3D RISCV_CPU_CLASS(c);
> >       const RISCVCPUDef *def =3D data;
> >
> > -    mcc->misa_mxl_max =3D def->misa_mxl_max;
> > +    mcc->def->misa_mxl_max =3D def->misa_mxl_max;
> >       riscv_cpu_validate_misa_mxl(mcc);
> >   }
> >
> > @@ -3227,6 +3239,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D =
{
> >           .abstract =3D true,
> >           .class_size =3D sizeof(RISCVCPUClass),
> >           .class_init =3D riscv_cpu_common_class_init,
> > +        .class_base_init =3D riscv_cpu_class_base_init,
> >       },
> >       {
> >           .name =3D TYPE_RISCV_DYNAMIC_CPU,
> > diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> > index 18e88f416af..1934f919c01 100644
> > --- a/target/riscv/gdbstub.c
> > +++ b/target/riscv/gdbstub.c
> > @@ -62,7 +62,7 @@ int riscv_cpu_gdb_read_register(CPUState *cs, GByteAr=
ray *mem_buf, int n)
> >           return 0;
> >       }
> >
> > -    switch (mcc->misa_mxl_max) {
> > +    switch (mcc->def->misa_mxl_max) {
> >       case MXL_RV32:
> >           return gdb_get_reg32(mem_buf, tmp);
> >       case MXL_RV64:
> > @@ -82,7 +82,7 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_=
t *mem_buf, int n)
> >       int length =3D 0;
> >       target_ulong tmp;
> >
> > -    switch (mcc->misa_mxl_max) {
> > +    switch (mcc->def->misa_mxl_max) {
> >       case MXL_RV32:
> >           tmp =3D (int32_t)ldl_p(mem_buf);
> >           length =3D 4;
> > @@ -359,7 +359,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUSt=
ate *cs)
> >                                    ricsv_gen_dynamic_vector_feature(cs,=
 cs->gdb_num_regs),
> >                                    0);
> >       }
> > -    switch (mcc->misa_mxl_max) {
> > +    switch (mcc->def->misa_mxl_max) {
> >       case MXL_RV32:
> >           gdb_register_coprocessor(cs, riscv_gdb_get_virtual,
> >                                    riscv_gdb_set_virtual,
> > diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> > index 75724b6af4f..41b6f34552a 100644
> > --- a/target/riscv/kvm/kvm-cpu.c
> > +++ b/target/riscv/kvm/kvm-cpu.c
> > @@ -1997,22 +1997,19 @@ static void kvm_cpu_accel_register_types(void)
> >   }
> >   type_init(kvm_cpu_accel_register_types);
> >
> > -static void riscv_host_cpu_class_init(ObjectClass *c, const void *data=
)
> > -{
> > -    RISCVCPUClass *mcc =3D RISCV_CPU_CLASS(c);
> > -
> > -#if defined(TARGET_RISCV32)
> > -    mcc->misa_mxl_max =3D MXL_RV32;
> > -#elif defined(TARGET_RISCV64)
> > -    mcc->misa_mxl_max =3D MXL_RV64;
> > -#endif
> > -}
> > -
> >   static const TypeInfo riscv_kvm_cpu_type_infos[] =3D {
> >       {
> >           .name =3D TYPE_RISCV_CPU_HOST,
> >           .parent =3D TYPE_RISCV_CPU,
> > -        .class_init =3D riscv_host_cpu_class_init,
> > +#if defined(TARGET_RISCV32)
> > +        .class_data =3D &((const RISCVCPUDef) {
> > +            .misa_mxl_max =3D MXL_RV32,
> > +        },
> > +#elif defined(TARGET_RISCV64)
> > +        .class_data =3D &((const RISCVCPUDef) {
> > +            .misa_mxl_max =3D MXL_RV64,
> > +        },
> > +#endif
> >       }
> >   };
>
> Are we sure this patch compiles?

No, you're right; I was not aware that RISC-V KVM is not covered by
CI. I'm sorry.

https://lore.kernel.org/qemu-devel/20250425152843.69638-1-philmd@linaro.org=
/T/#t

> As I said in the v3 this except opening 2 parentheses
> and closing just one after RISCVCPUDef:
>
> The error is fixable by closing both parentheses right before the comma, =
e.g:
>
> > +        }),
>
>
> Can you mention the pull requests you based this series on top of? I can =
apply the
> dependencies and this series on top of it to see if it builds.

It's based on master +
https://lore.kernel.org/qemu-devel/20250425152843.69638-1-philmd@linaro.org=
/.

Paolo


