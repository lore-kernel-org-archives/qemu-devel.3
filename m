Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09975C4828D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 02:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVj5W-0002dp-6p; Thu, 01 Feb 2024 21:15:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVj5L-0002bz-Rg; Thu, 01 Feb 2024 21:15:20 -0500
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVj5J-00016u-Bx; Thu, 01 Feb 2024 21:15:19 -0500
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7d5bbbe5844so811596241.0; 
 Thu, 01 Feb 2024 18:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706840116; x=1707444916; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RdLUADTOKCQiZHLCLrIWsFkyZ95cEQxAx1ky8CAdOdk=;
 b=lNKk49Iglgv1gVuMV70GrF+uxLauoA1bJdMTwbqavfRwpBgd7L3lOmRPTNVBwAs05Y
 3biC4fUboBRlx2qAV0vkMIRWEjScPxJh7uUQWah5lWmWZtkZ0uj+1QJysqgXAesQ8OP3
 xKDSacCxoS7j61tVVjNeVdbJQqGZZFh5DNsGxfOQIlnrXKHcg0Qo1m4frb26ivb7UCpI
 kj713zOGkDc3VJEzm1kROGSry6tN17snm+gEt4rqIKOrbofxnqbOB2UfUmLwJ00WCEnN
 9Wmgmx2wRdykCLmDQAGOpH+uKVT+DuyvCYeVWP+GG5XDYcMAIUr9/eOhDd0i07ycFPNi
 tnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706840116; x=1707444916;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RdLUADTOKCQiZHLCLrIWsFkyZ95cEQxAx1ky8CAdOdk=;
 b=kRS+wOmaot9KnzycvXIkTxuVSjCVFV40mH4xLvnNVqjRIw2XHzKkYnetCOWBpcS0VK
 umRVDRiBzHyGuKQJvO1hs8gpFfITk2g8TZtLifoKiyEJ8xYx5muVlLBqTcQOLiOCWxlB
 zG3cbxoI23SD4itfv/0CaiElK91vvDfupazN5SqFFsFifkgPuPMmCV3T9XxpwDTp49fe
 pEZ9faGcctUSaEReCOi3RIzWXfsqVYWF3JAbp7pSN6G5mfG1mg33bDUz+OE7OOYkmetB
 WYKmcCSSNkKsVbqpw7Ly+SJvLKB+kVcxuL7p6cW3X0wDpmr3kFxaj4Yt8JeD4ZL2MtQ+
 d9oQ==
X-Gm-Message-State: AOJu0YzWDvl0cC6qo+YioWgAik7eBIOZmW/T2HdJKwgK7c4Lspx/jDej
 n8dtzr43UdTm0BBbKgpBFEjppe6KnwZl66t+drumWipk0uMREBJLCi+QPb5cOP3QpBITpv+y4ya
 1kyfPSDcU3/4Jl8vjdydqe6dPxVU=
X-Google-Smtp-Source: AGHT+IF8MS7SkEzbBIAP71XFSLu/2Pq06tvJazbn30hxsUgErWnLbKkhooH8tbvGMARlw/yLZ6Bx8yGSy/gEmOaITyw=
X-Received: by 2002:a1f:fe8d:0:b0:4bd:76f3:9dff with SMTP id
 l135-20020a1ffe8d000000b004bd76f39dffmr819152vki.8.1706840115640; Thu, 01 Feb
 2024 18:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20240125195319.329181-1-dbarboza@ventanamicro.com>
 <20240125195319.329181-4-dbarboza@ventanamicro.com>
 <CAKmqyKNZ73Ep1sBKGBoX=wNvOPq_R+UU_K9qSRABBQUzK-LFLA@mail.gmail.com>
 <92c19649-4799-44c1-b7df-c958e1d5b2cc@ventanamicro.com>
In-Reply-To: <92c19649-4799-44c1-b7df-c958e1d5b2cc@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 2 Feb 2024 12:14:49 +1000
Message-ID: <CAKmqyKNPGRmWsrbm+Q4ArVNX66CM4JCNUrVid4x=mHYkdeZaYQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] target/riscv: add remaining named features
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
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

On Thu, Feb 1, 2024 at 5:15=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 1/29/24 22:10, Alistair Francis wrote:
> > On Fri, Jan 26, 2024 at 5:54=E2=80=AFAM Daniel Henrique Barboza
> > <dbarboza@ventanamicro.com> wrote:
> >>
> >> The RVA22U64 and RVA22S64 profiles mandates certain extensions that,
> >> until now, we were implying that they were available.
> >>
> >> We can't do this anymore since named features also has a riscv,isa
> >> entry.  Let's add them to riscv_cpu_named_features[].
> >>
> >> They will also need to be explicitly enabled in both profile
> >> descriptions. TCG will enable the named features it already implements=
,
> >> other accelerators are free to handle it as they like.
> >>
> >> After this patch, here's the riscv,isa from a buildroot using the
> >> 'rva22s64' CPU:
> >>
> >>   # cat /proc/device-tree/cpus/cpu@0/riscv,isa
> >> rv64imafdc_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_ziccrse=
_
> >> zicntr_zicsr_zifencei_zihintpause_zihpm_za64rs_zfhmin_zca_zcd_zba_zbb_
> >> zbs_zkt_sscounterenw_sstvala_sstvecd_svade_svinval_svpbmt#
> >>
> >> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> >> ---
> >>   target/riscv/cpu.c         | 41 +++++++++++++++++++++++++++++-------=
--
> >>   target/riscv/cpu_cfg.h     |  9 +++++++++
> >>   target/riscv/tcg/tcg-cpu.c | 19 +++++++++++++++++-
> >>   3 files changed, 59 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> >> index 28d3cfa8ce..1ecd8a57ed 100644
> >> --- a/target/riscv/cpu.c
> >> +++ b/target/riscv/cpu.c
> >> @@ -101,6 +101,10 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
> >>       ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
> >>       ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
> >>       ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
> >> +    ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, ext_ziccamoa),
> >> +    ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, ext_ziccif),
> >> +    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_zicclsm),
> >> +    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
> >>       ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
> >>       ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
> >>       ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
> >> @@ -109,6 +113,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
> >>       ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintp=
ause),
> >>       ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
> >>       ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
> >> +    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, ext_za64rs),
> >>       ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
> >>       ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
> >>       ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
> >> @@ -170,8 +175,12 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
> >>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
> >>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen=
),
> >>       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
> >> +    ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, ext_ssccptr),
> >>       ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
> >> +    ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, ext_sscount=
erenw),
> >>       ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
> >> +    ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, ext_sstvala),
> >> +    ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, ext_sstvecd),
> >>       ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
> >>       ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
> >>       ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
> >> @@ -1523,6 +1532,22 @@ const RISCVCPUMultiExtConfig riscv_cpu_named_fe=
atures[] =3D {
> >>       MULTI_EXT_CFG_BOOL("svade", ext_svade, true),
> >>       MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
> >>
> >> +    /*
> >> +     * cache-related extensions that are always enabled
> >> +     * since QEMU RISC-V does not have a cache model.
> >> +     */
> >> +    MULTI_EXT_CFG_BOOL("za64rs", ext_za64rs, true),
> >> +    MULTI_EXT_CFG_BOOL("ziccif", ext_ziccif, true),
> >> +    MULTI_EXT_CFG_BOOL("ziccrse", ext_ziccrse, true),
> >> +    MULTI_EXT_CFG_BOOL("ziccamoa", ext_ziccamoa, true),
> >> +    MULTI_EXT_CFG_BOOL("zicclsm", ext_zicclsm, true),
> >> +    MULTI_EXT_CFG_BOOL("ssccptr", ext_ssccptr, true),
> >> +
> >> +    /* Other named features that QEMU TCG always implements */
> >> +    MULTI_EXT_CFG_BOOL("sstvecd", ext_sstvecd, true),
> >> +    MULTI_EXT_CFG_BOOL("sstvala", ext_sstvala, true),
> >> +    MULTI_EXT_CFG_BOOL("sscounterenw", ext_sscounterenw, true),
> >> +
> >>       DEFINE_PROP_END_OF_LIST(),
> >>   };
> >>
> >> @@ -2116,13 +2141,8 @@ static const PropertyInfo prop_marchid =3D {
> >>   };
> >>
> >>   /*
> >> - * RVA22U64 defines some 'named features' or 'synthetic extensions'
> >> - * that are cache related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
> >> - * and Zicclsm. We do not implement caching in QEMU so we'll consider
> >> - * all these named features as always enabled.
> >> - *
> >> - * There's no riscv,isa update for them (nor for zic64b, despite it
> >> - * having a cfg offset) at this moment.
> >> + * RVA22U64 defines some cache related extensions: Za64rs,
> >> + * Ziccif, Ziccrse, Ziccamoa and Zicclsm.
> >>    */
> >>   static RISCVCPUProfile RVA22U64 =3D {
> >>       .parent =3D NULL,
> >> @@ -2139,7 +2159,9 @@ static RISCVCPUProfile RVA22U64 =3D {
> >>           CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
> >>
> >>           /* mandatory named features for this profile */
> >> -        CPU_CFG_OFFSET(ext_zic64b),
> >> +        CPU_CFG_OFFSET(ext_za64rs), CPU_CFG_OFFSET(ext_zic64b),
> >> +        CPU_CFG_OFFSET(ext_ziccif), CPU_CFG_OFFSET(ext_ziccrse),
> >> +        CPU_CFG_OFFSET(ext_ziccamoa), CPU_CFG_OFFSET(ext_zicclsm),
> >>
> >>           RISCV_PROFILE_EXT_LIST_END
> >>       }
> >> @@ -2170,7 +2192,8 @@ static RISCVCPUProfile RVA22S64 =3D {
> >>           CPU_CFG_OFFSET(ext_svinval),
> >>
> >>           /* rva22s64 named features */
> >> -        CPU_CFG_OFFSET(ext_svade),
> >> +        CPU_CFG_OFFSET(ext_sstvecd), CPU_CFG_OFFSET(ext_sstvala),
> >> +        CPU_CFG_OFFSET(ext_sscounterenw), CPU_CFG_OFFSET(ext_svade),
> >>
> >>           RISCV_PROFILE_EXT_LIST_END
> >>       }
> >> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> >> index 698f926ab1..f79fc3dfd1 100644
> >> --- a/target/riscv/cpu_cfg.h
> >> +++ b/target/riscv/cpu_cfg.h
> >> @@ -125,6 +125,15 @@ struct RISCVCPUConfig {
> >>       /* Named features  */
> >>       bool ext_svade;
> >>       bool ext_zic64b;
> >> +    bool ext_za64rs;
> >> +    bool ext_ziccif;
> >> +    bool ext_ziccrse;
> >> +    bool ext_ziccamoa;
> >> +    bool ext_zicclsm;
> >> +    bool ext_ssccptr;
> >> +    bool ext_sstvecd;
> >> +    bool ext_sstvala;
> >> +    bool ext_sscounterenw;
> >
> > Overall this and the previous patch look fine.
> >
> > One thing though, why store this information? I feel it could be
> > confusing having these variables. If a developer sets them to false
> > nothing actually happens, which is a little misleading
>
> These extensions aren't being exposed to users. riscv_cpu_named_features[=
] isn't

Yep, we should not expose them to users.

I meant developers, as in people reading the C code and compiling QEMU.

> being used to create any CPU user properties. I should've mentioned that =
in
> patch 2 ...
>
> As for the extra booleans that we'll be setting to 'true', as it is now
> isa_edata_arr[] stores a string name, priv_ver and a cpu->cfg offset, so
> everyone that adds a riscv,isa str must also have a valid bool offset in
> RISCVCPUConfig. Having a bool also allow us to treat them as regular exte=
nsions
> because we can re-use existing code to blindly enable them in profiles li=
ke
> any other profile extension.

Yep, and I think that makes sense. The odd part is that we don't
actually use these bools. Which I feel is confusing when looking at
the QEMU code base. Why have a variable that we don't use?

>
> And, in case we need to promote them as regular user extensions, having t=
he
> booleans in place make it easier to do so. Patch 6 is doing that with 'sv=
ade'.

If we plan to do that, I think that also makes sense. But I suspect no
one has any plant to convert some of these to real configuration
options.

>
>
> Thanks,
>
> Daniel
>
>
> We could create a single boolean that is always true in cpu->cfg and use =
it
> for these entries. Another idea would be to change the riscv,isa function=
s to
> handle these extensions separately, then we can add them in the array wit=
hout
> a valid cpu->cfg offfset.

I think these are better ideas.

Alistair

>
> >
> > Alistair
> >
> >>
> >>       /* Vendor-specific custom extensions */
> >>       bool ext_xtheadba;
> >> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> >> index 90861cc065..6d5028cf84 100644
> >> --- a/target/riscv/tcg/tcg-cpu.c
> >> +++ b/target/riscv/tcg/tcg-cpu.c
> >> @@ -206,7 +206,8 @@ static void riscv_cpu_enable_named_feat(RISCVCPU *=
cpu, uint32_t feat_offset)
> >>           cpu->cfg.ext_svadu =3D false;
> >>           break;
> >>       default:
> >> -        g_assert_not_reached();
> >> +        /* Named feature already enabled in riscv_tcg_cpu_instance_in=
it */
> >> +        return;
> >>       }
> >>   }
> >>
> >> @@ -1342,6 +1343,20 @@ static bool riscv_cpu_has_max_extensions(Object=
 *cpu_obj)
> >>       return object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_MAX) !=3D NUL=
L;
> >>   }
> >>
> >> +/* Named features that TCG always implements */
> >> +static void riscv_tcg_cpu_enable_named_feats(RISCVCPU *cpu)
> >> +{
> >> +    cpu->cfg.ext_za64rs =3D true;
> >> +    cpu->cfg.ext_ziccif =3D true;
> >> +    cpu->cfg.ext_ziccrse =3D true;
> >> +    cpu->cfg.ext_ziccamoa =3D true;
> >> +    cpu->cfg.ext_zicclsm =3D true;
> >> +    cpu->cfg.ext_ssccptr =3D true;
> >> +    cpu->cfg.ext_sstvecd =3D true;
> >> +    cpu->cfg.ext_sstvala =3D true;
> >> +    cpu->cfg.ext_sscounterenw =3D true;
> >> +}
> >> +
> >>   static void riscv_tcg_cpu_instance_init(CPUState *cs)
> >>   {
> >>       RISCVCPU *cpu =3D RISCV_CPU(cs);
> >> @@ -1354,6 +1369,8 @@ static void riscv_tcg_cpu_instance_init(CPUState=
 *cs)
> >>       if (riscv_cpu_has_max_extensions(obj)) {
> >>           riscv_init_max_cpu_extensions(obj);
> >>       }
> >> +
> >> +    riscv_tcg_cpu_enable_named_feats(cpu);
> >>   }
> >>
> >>   static void riscv_tcg_cpu_init_ops(AccelCPUClass *accel_cpu, CPUClas=
s *cc)
> >> --
> >> 2.43.0
> >>
> >>

