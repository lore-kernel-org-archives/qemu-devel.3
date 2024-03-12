Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C482CC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0SN-0008LO-9M; Tue, 12 Mar 2024 07:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0Rt-0007Y1-Uj; Tue, 12 Mar 2024 07:37:38 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0Rr-0003Mx-87; Tue, 12 Mar 2024 07:37:37 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5d3907ff128so4314049a12.3; 
 Tue, 12 Mar 2024 04:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710243453; x=1710848253; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0/I/LU6brttqKK883f77TI6HGfavfutp9oA7ZCasWY=;
 b=Cjw4S+B22tCxphznOPZOCu1yNMUh1NmYdhFYvPZvegDBJbmUWPkR0Cr3d0/X2v23iw
 zmXoaVpcxYBhts/mxcS2yrnzN4zDURIqmIII/atICyQhNlh+DJtPYWNPytAW5b/9Td24
 9DR5MrbNKGtj23M8G2lUJLG8/+2A5k4PeX5++7mzkrCBZM2GR8aQ6rwHZNb+kJNrKTg4
 x//P7sBBz0ejHd+vY0OCLQvG+az6xmhQ46G93vrLZ6YORGaMidimdSqHpszCFLYDljuI
 8vxjkgZOrAro+5MCEnOOudMptPG+FkNZzorID8im0U1PnRDbbJP6PWl3leYuYg/AJFIt
 75TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710243453; x=1710848253;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z0/I/LU6brttqKK883f77TI6HGfavfutp9oA7ZCasWY=;
 b=oAFPF3S5kHVjyFIgGs3LpeN6glYwXq5LSu4Sy2WuKRGx9b6UQDvzr7JnU3mA/EqTHJ
 MEoEHOAQzNNyNnLrBdacNCDIKgTVN17BwVNcd42jkju+n41rVtwaVcBaA7Fm9xZxpJtO
 Lp91cz4t8sqNvJsgZeRRz669zMabk/SIaz2KV9ISMyRYzhci1+Qi8ep/0qAJa98DW0MM
 606FYMwtwyoUmA1uE2FxB6cGCS42MFIfVUS48/L9uK/xCT7/frFGAO/KiXLJRvnRIB/e
 MAbw7RzDZK3W34GJbKHYi1y4Iv3qYOv3Z+o4wsw0/jcWeW8cNhWmfo/5hCIUGI8zb68k
 kOAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEoOlwAchE97oSN4yYiKyUCsm+cpucMYx47mciFIHJD5LtajaUp5KNVzHGOiqEfKRyAJ5/s3HUOnHQ+Sfr01UxhR5l2dtdp7V3nPPl75Iq5yjEuTzzM1TDoXU=
X-Gm-Message-State: AOJu0YxyQoDXCRMDJ1ieDZ5hlQCXeNMicwHemQVSro4zJ+1TVQlVwgof
 +1SvFX9pp7Nmq1xvQtUoislWjhFbWNmj2bhn4kW+AT+OiP2r0+uKb+LA4FIrgWg=
X-Google-Smtp-Source: AGHT+IHacUi7c0gkM9zjRcqj9WpNdE7ukg1Atp+43lVkhppScoMiNI52dRC8i1w5B7wugD/r6IrSHw==
X-Received: by 2002:a17:90a:9084:b0:29b:b854:db with SMTP id
 j4-20020a17090a908400b0029bb85400dbmr7293893pjo.27.1710243453318; 
 Tue, 12 Mar 2024 04:37:33 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 gt17-20020a17090af2d100b00298cc4c56cdsm8993816pjb.22.2024.03.12.04.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 04:37:33 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 21:37:27 +1000
Message-Id: <CZRQPDENSPD6.YZDD9KM4G1E6@wheely>
Cc: <clg@kaod.org>, <mikey@neuling.org>, <amachhiw@linux.vnet.ibm.com>,
 <vaibhav@linux.ibm.com>, <sbhat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 09/14] spapr: nested: Extend nested_ppc_state for
 nested PAPR API
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
 <20240308111940.1617660-10-harshpb@linux.ibm.com>
In-Reply-To: <20240308111940.1617660-10-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Mar 8, 2024 at 9:19 PM AEST, Harsh Prateek Bora wrote:
> Currently, nested_ppc_state stores a certain set of registers and works
> with nested_[load|save]_state() for state transfer as reqd for nested-hv =
API.
> Extending these with additional registers state as reqd for nested PAPR A=
PI.
>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Suggested-by: Nicholas Piggin <npiggin@gmail.com>

I still have concerns with exactly how registers are saved and restored,
but it's not necessarily a new problem with v2, and not so much
fundamental design flow more of verifying details so I'm inclined to take
this for now.

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  include/hw/ppc/spapr_nested.h |  50 ++++++++++++++++
>  target/ppc/cpu.h              |   2 +
>  hw/ppc/spapr_nested.c         | 106 ++++++++++++++++++++++++++++++++++
>  3 files changed, 158 insertions(+)
>
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index 2ac3076fac..d232014ccb 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -7,6 +7,7 @@ typedef struct SpaprMachineStateNested {
>      uint64_t ptcr;
>      uint8_t api;
>  #define NESTED_API_KVM_HV  1
> +#define NESTED_API_PAPR    2
>      bool capabilities_set;
>      uint32_t pvr_base;
>      GHashTable *guests;
> @@ -121,6 +122,55 @@ struct nested_ppc_state {
>      uint64_t ppr;
> =20
>      int64_t tb_offset;
> +    /* Nested PAPR API */
> +    uint64_t amor;
> +    uint64_t dawr0;
> +    uint64_t dawrx0;
> +    uint64_t ciabr;
> +    uint64_t purr;
> +    uint64_t spurr;
> +    uint64_t ic;
> +    uint64_t vtb;
> +    uint64_t hdar;
> +    uint64_t hdsisr;
> +    uint64_t heir;
> +    uint64_t asdr;
> +    uint64_t dawr1;
> +    uint64_t dawrx1;
> +    uint64_t dexcr;
> +    uint64_t hdexcr;
> +    uint64_t hashkeyr;
> +    uint64_t hashpkeyr;
> +    ppc_vsr_t vsr[64] QEMU_ALIGNED(16);
> +    uint64_t ebbhr;
> +    uint64_t tar;
> +    uint64_t ebbrr;
> +    uint64_t bescr;
> +    uint64_t iamr;
> +    uint64_t amr;
> +    uint64_t uamor;
> +    uint64_t dscr;
> +    uint64_t fscr;
> +    uint64_t pspb;
> +    uint64_t ctrl;
> +    uint64_t vrsave;
> +    uint64_t dar;
> +    uint64_t dsisr;
> +    uint64_t pmc1;
> +    uint64_t pmc2;
> +    uint64_t pmc3;
> +    uint64_t pmc4;
> +    uint64_t pmc5;
> +    uint64_t pmc6;
> +    uint64_t mmcr0;
> +    uint64_t mmcr1;
> +    uint64_t mmcr2;
> +    uint64_t mmcra;
> +    uint64_t sdar;
> +    uint64_t siar;
> +    uint64_t sier;
> +    uint32_t vscr;
> +    uint64_t fpscr;
>  };
> =20
>  typedef struct SpaprMachineStateNestedGuestVcpu {
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 0133da4e07..4cffd46c79 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1755,9 +1755,11 @@ void ppc_compat_add_property(Object *obj, const ch=
ar *name,
>  #define SPR_PSPB              (0x09F)
>  #define SPR_DPDES             (0x0B0)
>  #define SPR_DAWR0             (0x0B4)
> +#define SPR_DAWR1             (0x0B5)
>  #define SPR_RPR               (0x0BA)
>  #define SPR_CIABR             (0x0BB)
>  #define SPR_DAWRX0            (0x0BC)
> +#define SPR_DAWRX1            (0x0BD)
>  #define SPR_HFSCR             (0x0BE)
>  #define SPR_VRSAVE            (0x100)
>  #define SPR_USPRG0            (0x100)
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index 4c0e2e91e1..09ebf42a57 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -108,6 +108,7 @@ static target_ulong h_copy_tofrom_guest(PowerPCCPU *c=
pu,
>  static void nested_save_state(struct nested_ppc_state *save, PowerPCCPU =
*cpu)
>  {
>      CPUPPCState *env =3D &cpu->env;
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> =20
>      memcpy(save->gpr, env->gpr, sizeof(save->gpr));
> =20
> @@ -134,6 +135,58 @@ static void nested_save_state(struct nested_ppc_stat=
e *save, PowerPCCPU *cpu)
>      save->pidr =3D env->spr[SPR_BOOKS_PID];
>      save->ppr =3D env->spr[SPR_PPR];
> =20
> +    if (spapr_nested_api(spapr) =3D=3D NESTED_API_PAPR) {
> +        save->pvr =3D env->spr[SPR_PVR];
> +        save->amor =3D env->spr[SPR_AMOR];
> +        save->dawr0 =3D env->spr[SPR_DAWR0];
> +        save->dawrx0 =3D env->spr[SPR_DAWRX0];
> +        save->ciabr =3D env->spr[SPR_CIABR];
> +        save->purr =3D env->spr[SPR_PURR];
> +        save->spurr =3D env->spr[SPR_SPURR];
> +        save->ic =3D env->spr[SPR_IC];
> +        save->vtb =3D env->spr[SPR_VTB];
> +        save->hdar =3D env->spr[SPR_HDAR];
> +        save->hdsisr =3D env->spr[SPR_HDSISR];
> +        save->heir =3D env->spr[SPR_HEIR];
> +        save->asdr =3D env->spr[SPR_ASDR];
> +        save->dawr1 =3D env->spr[SPR_DAWR1];
> +        save->dawrx1 =3D env->spr[SPR_DAWRX1];
> +        save->dexcr =3D env->spr[SPR_DEXCR];
> +        save->hdexcr =3D env->spr[SPR_HDEXCR];
> +        save->hashkeyr =3D env->spr[SPR_HASHKEYR];
> +        save->hashpkeyr =3D env->spr[SPR_HASHPKEYR];
> +        memcpy(save->vsr, env->vsr, sizeof(save->vsr));
> +        save->ebbhr =3D env->spr[SPR_EBBHR];
> +        save->tar =3D env->spr[SPR_TAR];
> +        save->ebbrr =3D env->spr[SPR_EBBRR];
> +        save->bescr =3D env->spr[SPR_BESCR];
> +        save->iamr =3D env->spr[SPR_IAMR];
> +        save->amr =3D env->spr[SPR_AMR];
> +        save->uamor =3D env->spr[SPR_UAMOR];
> +        save->dscr =3D env->spr[SPR_DSCR];
> +        save->fscr =3D env->spr[SPR_FSCR];
> +        save->pspb =3D env->spr[SPR_PSPB];
> +        save->ctrl =3D env->spr[SPR_CTRL];
> +        save->vrsave =3D env->spr[SPR_VRSAVE];
> +        save->dar =3D env->spr[SPR_DAR];
> +        save->dsisr =3D env->spr[SPR_DSISR];
> +        save->pmc1 =3D env->spr[SPR_POWER_PMC1];
> +        save->pmc2 =3D env->spr[SPR_POWER_PMC2];
> +        save->pmc3 =3D env->spr[SPR_POWER_PMC3];
> +        save->pmc4 =3D env->spr[SPR_POWER_PMC4];
> +        save->pmc5 =3D env->spr[SPR_POWER_PMC5];
> +        save->pmc6 =3D env->spr[SPR_POWER_PMC6];
> +        save->mmcr0 =3D env->spr[SPR_POWER_MMCR0];
> +        save->mmcr1 =3D env->spr[SPR_POWER_MMCR1];
> +        save->mmcr2 =3D env->spr[SPR_POWER_MMCR2];
> +        save->mmcra =3D env->spr[SPR_POWER_MMCRA];
> +        save->sdar =3D env->spr[SPR_POWER_SDAR];
> +        save->siar =3D env->spr[SPR_POWER_SIAR];
> +        save->sier =3D env->spr[SPR_POWER_SIER];
> +        save->vscr =3D ppc_get_vscr(env);
> +        save->fpscr =3D env->fpscr;
> +    }
> +
>      save->tb_offset =3D env->tb_env->tb_offset;
>  }
> =20
> @@ -141,6 +194,7 @@ static void nested_load_state(PowerPCCPU *cpu, struct=
 nested_ppc_state *load)
>  {
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> =20
>      memcpy(env->gpr, load->gpr, sizeof(env->gpr));
> =20
> @@ -167,6 +221,58 @@ static void nested_load_state(PowerPCCPU *cpu, struc=
t nested_ppc_state *load)
>      env->spr[SPR_BOOKS_PID] =3D load->pidr;
>      env->spr[SPR_PPR] =3D load->ppr;
> =20
> +    if (spapr_nested_api(spapr) =3D=3D NESTED_API_PAPR) {
> +        env->spr[SPR_PVR] =3D load->pvr;
> +        env->spr[SPR_AMOR] =3D load->amor;
> +        env->spr[SPR_DAWR0] =3D load->dawr0;
> +        env->spr[SPR_DAWRX0] =3D load->dawrx0;
> +        env->spr[SPR_CIABR] =3D load->ciabr;
> +        env->spr[SPR_PURR] =3D load->purr;
> +        env->spr[SPR_SPURR] =3D load->purr;
> +        env->spr[SPR_IC] =3D load->ic;
> +        env->spr[SPR_VTB] =3D load->vtb;
> +        env->spr[SPR_HDAR] =3D load->hdar;
> +        env->spr[SPR_HDSISR] =3D load->hdsisr;
> +        env->spr[SPR_HEIR] =3D load->heir;
> +        env->spr[SPR_ASDR] =3D load->asdr;
> +        env->spr[SPR_DAWR1] =3D load->dawr1;
> +        env->spr[SPR_DAWRX1] =3D load->dawrx1;
> +        env->spr[SPR_DEXCR] =3D load->dexcr;
> +        env->spr[SPR_HDEXCR] =3D load->hdexcr;
> +        env->spr[SPR_HASHKEYR] =3D load->hashkeyr;
> +        env->spr[SPR_HASHPKEYR] =3D load->hashpkeyr;
> +        memcpy(env->vsr, load->vsr, sizeof(env->vsr));
> +        env->spr[SPR_EBBHR] =3D load->ebbhr;
> +        env->spr[SPR_TAR] =3D load->tar;
> +        env->spr[SPR_EBBRR] =3D load->ebbrr;
> +        env->spr[SPR_BESCR] =3D load->bescr;
> +        env->spr[SPR_IAMR] =3D load->iamr;
> +        env->spr[SPR_AMR] =3D load->amr;
> +        env->spr[SPR_UAMOR] =3D load->uamor;
> +        env->spr[SPR_DSCR] =3D load->dscr;
> +        env->spr[SPR_FSCR] =3D load->fscr;
> +        env->spr[SPR_PSPB] =3D load->pspb;
> +        env->spr[SPR_CTRL] =3D load->ctrl;
> +        env->spr[SPR_VRSAVE] =3D load->vrsave;
> +        env->spr[SPR_DAR] =3D load->dar;
> +        env->spr[SPR_DSISR] =3D load->dsisr;
> +        env->spr[SPR_POWER_PMC1] =3D load->pmc1;
> +        env->spr[SPR_POWER_PMC2] =3D load->pmc2;
> +        env->spr[SPR_POWER_PMC3] =3D load->pmc3;
> +        env->spr[SPR_POWER_PMC4] =3D load->pmc4;
> +        env->spr[SPR_POWER_PMC5] =3D load->pmc5;
> +        env->spr[SPR_POWER_PMC6] =3D load->pmc6;
> +        env->spr[SPR_POWER_MMCR0] =3D load->mmcr0;
> +        env->spr[SPR_POWER_MMCR1] =3D load->mmcr1;
> +        env->spr[SPR_POWER_MMCR2] =3D load->mmcr2;
> +        env->spr[SPR_POWER_MMCRA] =3D load->mmcra;
> +        env->spr[SPR_POWER_SDAR] =3D load->sdar;
> +        env->spr[SPR_POWER_SIAR] =3D load->siar;
> +        env->spr[SPR_POWER_SIER] =3D load->sier;
> +        ppc_store_vscr(env, load->vscr);
> +        ppc_store_fpscr(env, load->fpscr);
> +    }
> +
>      env->tb_env->tb_offset =3D load->tb_offset;
> =20
>      /*


