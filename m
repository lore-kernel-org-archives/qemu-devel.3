Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E626BC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4hFa-0008RA-9V; Wed, 08 May 2024 09:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4hF7-00083I-Jo; Wed, 08 May 2024 09:22:04 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4hF3-0003HA-RO; Wed, 08 May 2024 09:21:56 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f447260f9dso3235742b3a.0; 
 Wed, 08 May 2024 06:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715174512; x=1715779312; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EI+aW5pswkdFCTCLttuA3RuJKFUvLOwAf8ON/XmbjeU=;
 b=ZLJttHezeID/8Hhu5LVwTxp7J9vWxeQ+8vWGPX5EUiy7g1IBhLtCbj3YEi4VfBPP5w
 bQRBsAMuCWV1eCq2qBsfmlsiTIPlNuGyoiRDp5yzdqVQLO8iMLrNOdXVPQpNK5h1GSxx
 pfo7LJ4z1csGh9DMUnJcxuJ+8SBQB0kFKOislpRspS/JrsLWi5FdDejdIKZCyGF9qfZt
 aoHB5822CwrHPuowW/3dmz/dEl9fFip7mQ96BnLyOmufNZHtQFUK8KIDPFJWvne/ao7T
 11YcUcjxreHD4jeKXzq9hunR/3THmEInF1GASdh9kTabcfpNEWPPSPhFtfFOZ8Sug0Tz
 N19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715174512; x=1715779312;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EI+aW5pswkdFCTCLttuA3RuJKFUvLOwAf8ON/XmbjeU=;
 b=GlOlQK/WhRCqoIZXgUss1gz+CdxKJcsVnjdciBmvhHD8CJiZwQcoVl4yTl3n8mXDtE
 8TxAm3tTQXRxZ4CsI9d4LliKAWFKqGJjxIHqYVoWf/ncxYGkCZGaudq7hbyHCno2VJhQ
 qb/85+DuwTcBV8pIqPfkr1a/QI3yS8ODdnF3Kh8MPZ55tQIDPe+O0tqAjzxNpAQBrE/Z
 apc1xfnsd+053MWiJpji323LhiFL5hmytNqiBIf8OIJtmpFeqSChAW/YYrMecQj66wgH
 DL+oxHYBKlPlXd+v++b95ZonUwh4mczAMHOwyiK6S1/xg099UOWp5Su40fA4Vg/3OF38
 fMAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWEC0ImH9jP9EwkdDLtfGM6lcIhqCHiePao/5d9AmcjZmaszr8dNk8zMlIjUrH1rY9oolzRqfNYccPLg0Bgstc4zDiZN95WYC/KwIoBMxyf4dXA5zPoY/jEKU=
X-Gm-Message-State: AOJu0YxCksqDBPhmvfUPQgr1o+rUvdZZd6SqNq/CtP4pyOC4YO2AARAS
 JH0kxnthPt0uuHzXOIQCGw/pepVQ1lBFqT3tLIU0jc1Rt4a1qtOHc3f80A==
X-Google-Smtp-Source: AGHT+IEsMjzNr9Rc2vsaBb6I6ajtzKPN++RqRppW79+1siH+X7zcgMukT5wSaQwjfOdr50K8O+m9TQ==
X-Received: by 2002:a05:6300:8095:b0:1a7:aecd:9785 with SMTP id
 adf61e73a8af0-1afc8d3d59cmr2776626637.25.1715174511873; 
 Wed, 08 May 2024 06:21:51 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 d3-20020a17090ac24300b002b1cad4fd97sm1398907pjx.25.2024.05.08.06.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 06:21:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 23:21:46 +1000
Message-Id: <D14AMAUZ44BZ.1PQBLRVTX4NU5@gmail.com>
Subject: Re: [PATCH v3 28/33] target/ppc/mmu_common.c: Move BookE MMU
 functions together
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <814d4b4526282af7854f52cf6a268245c33c674a.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <814d4b4526282af7854f52cf6a268245c33c674a.1715125376.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed May 8, 2024 at 10:15 AM AEST, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Okay for now but we should split into a new file soon.

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mmu_common.c | 226 ++++++++++++++++++++--------------------
>  1 file changed, 113 insertions(+), 113 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 04e5ad661d..a6e7b64049 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -854,6 +854,119 @@ found_tlb:
>      return ret;
>  }
> =20
> +static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong =
address,
> +                                         MMUAccessType access_type, int =
mmu_idx)
> +{
> +    uint32_t epid;
> +    bool as, pr;
> +    uint32_t missed_tid =3D 0;
> +    bool use_epid =3D mmubooke206_get_as(env, mmu_idx, &epid, &as, &pr);
> +
> +    if (access_type =3D=3D MMU_INST_FETCH) {
> +        as =3D FIELD_EX64(env->msr, MSR, IR);
> +    }
> +    env->spr[SPR_BOOKE_MAS0] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_TLBSELD=
_MASK;
> +    env->spr[SPR_BOOKE_MAS1] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_TSIZED_=
MASK;
> +    env->spr[SPR_BOOKE_MAS2] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_WIMGED_=
MASK;
> +    env->spr[SPR_BOOKE_MAS3] =3D 0;
> +    env->spr[SPR_BOOKE_MAS6] =3D 0;
> +    env->spr[SPR_BOOKE_MAS7] =3D 0;
> +
> +    /* AS */
> +    if (as) {
> +        env->spr[SPR_BOOKE_MAS1] |=3D MAS1_TS;
> +        env->spr[SPR_BOOKE_MAS6] |=3D MAS6_SAS;
> +    }
> +
> +    env->spr[SPR_BOOKE_MAS1] |=3D MAS1_VALID;
> +    env->spr[SPR_BOOKE_MAS2] |=3D address & MAS2_EPN_MASK;
> +
> +    if (!use_epid) {
> +        switch (env->spr[SPR_BOOKE_MAS4] & MAS4_TIDSELD_PIDZ) {
> +        case MAS4_TIDSELD_PID0:
> +            missed_tid =3D env->spr[SPR_BOOKE_PID];
> +            break;
> +        case MAS4_TIDSELD_PID1:
> +            missed_tid =3D env->spr[SPR_BOOKE_PID1];
> +            break;
> +        case MAS4_TIDSELD_PID2:
> +            missed_tid =3D env->spr[SPR_BOOKE_PID2];
> +            break;
> +        }
> +        env->spr[SPR_BOOKE_MAS6] |=3D env->spr[SPR_BOOKE_PID] << 16;
> +    } else {
> +        missed_tid =3D epid;
> +        env->spr[SPR_BOOKE_MAS6] |=3D missed_tid << 16;
> +    }
> +    env->spr[SPR_BOOKE_MAS1] |=3D (missed_tid << MAS1_TID_SHIFT);
> +
> +
> +    /* next victim logic */
> +    env->spr[SPR_BOOKE_MAS0] |=3D env->last_way << MAS0_ESEL_SHIFT;
> +    env->last_way++;
> +    env->last_way &=3D booke206_tlb_ways(env, 0) - 1;
> +    env->spr[SPR_BOOKE_MAS0] |=3D env->last_way << MAS0_NV_SHIFT;
> +}
> +
> +static bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr,
> +                            MMUAccessType access_type,
> +                            hwaddr *raddrp, int *psizep, int *protp,
> +                            int mmu_idx, bool guest_visible)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +    CPUPPCState *env =3D &cpu->env;
> +    mmu_ctx_t ctx;
> +    int ret;
> +
> +    if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
> +        ret =3D mmubooke206_get_physical_address(env, &ctx, eaddr, acces=
s_type,
> +                                               mmu_idx);
> +    } else {
> +        ret =3D mmubooke_get_physical_address(env, &ctx, eaddr, access_t=
ype);
> +    }
> +    if (ret =3D=3D 0) {
> +        *raddrp =3D ctx.raddr;
> +        *protp =3D ctx.prot;
> +        *psizep =3D TARGET_PAGE_BITS;
> +        return true;
> +    } else if (!guest_visible) {
> +        return false;
> +    }
> +
> +    log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
> +    env->error_code =3D 0;
> +    switch (ret) {
> +    case -1:
> +        /* No matches in page tables or TLB */
> +        if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
> +            booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_id=
x);
> +        }
> +        cs->exception_index =3D (access_type =3D=3D MMU_INST_FETCH) ?
> +                              POWERPC_EXCP_ITLB : POWERPC_EXCP_DTLB;
> +        env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> +        env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_type=
);
> +        break;
> +    case -2:
> +        /* Access rights violation */
> +        cs->exception_index =3D (access_type =3D=3D MMU_INST_FETCH) ?
> +                              POWERPC_EXCP_ISI : POWERPC_EXCP_DSI;
> +        if (access_type !=3D MMU_INST_FETCH) {
> +            env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> +            env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_=
type);
> +        }
> +        break;
> +    case -3:
> +        /* No execute protection violation */
> +        if (access_type =3D=3D MMU_INST_FETCH) {
> +            cs->exception_index =3D POWERPC_EXCP_ISI;
> +            env->spr[SPR_BOOKE_ESR] =3D 0;
> +        }
> +        break;
> +    }
> +
> +    return false;
> +}
> +
>  static const char *book3e_tsize_to_str[32] =3D {
>      "1K", "2K", "4K", "8K", "16K", "32K", "64K", "128K", "256K", "512K",
>      "1M", "2M", "4M", "8M", "16M", "32M", "64M", "128M", "256M", "512M",
> @@ -1125,119 +1238,6 @@ static int get_physical_address_wtlb(CPUPPCState =
*env, mmu_ctx_t *ctx,
>      }
>  }
> =20
> -static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong =
address,
> -                                         MMUAccessType access_type, int =
mmu_idx)
> -{
> -    uint32_t epid;
> -    bool as, pr;
> -    uint32_t missed_tid =3D 0;
> -    bool use_epid =3D mmubooke206_get_as(env, mmu_idx, &epid, &as, &pr);
> -
> -    if (access_type =3D=3D MMU_INST_FETCH) {
> -        as =3D FIELD_EX64(env->msr, MSR, IR);
> -    }
> -    env->spr[SPR_BOOKE_MAS0] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_TLBSELD=
_MASK;
> -    env->spr[SPR_BOOKE_MAS1] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_TSIZED_=
MASK;
> -    env->spr[SPR_BOOKE_MAS2] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_WIMGED_=
MASK;
> -    env->spr[SPR_BOOKE_MAS3] =3D 0;
> -    env->spr[SPR_BOOKE_MAS6] =3D 0;
> -    env->spr[SPR_BOOKE_MAS7] =3D 0;
> -
> -    /* AS */
> -    if (as) {
> -        env->spr[SPR_BOOKE_MAS1] |=3D MAS1_TS;
> -        env->spr[SPR_BOOKE_MAS6] |=3D MAS6_SAS;
> -    }
> -
> -    env->spr[SPR_BOOKE_MAS1] |=3D MAS1_VALID;
> -    env->spr[SPR_BOOKE_MAS2] |=3D address & MAS2_EPN_MASK;
> -
> -    if (!use_epid) {
> -        switch (env->spr[SPR_BOOKE_MAS4] & MAS4_TIDSELD_PIDZ) {
> -        case MAS4_TIDSELD_PID0:
> -            missed_tid =3D env->spr[SPR_BOOKE_PID];
> -            break;
> -        case MAS4_TIDSELD_PID1:
> -            missed_tid =3D env->spr[SPR_BOOKE_PID1];
> -            break;
> -        case MAS4_TIDSELD_PID2:
> -            missed_tid =3D env->spr[SPR_BOOKE_PID2];
> -            break;
> -        }
> -        env->spr[SPR_BOOKE_MAS6] |=3D env->spr[SPR_BOOKE_PID] << 16;
> -    } else {
> -        missed_tid =3D epid;
> -        env->spr[SPR_BOOKE_MAS6] |=3D missed_tid << 16;
> -    }
> -    env->spr[SPR_BOOKE_MAS1] |=3D (missed_tid << MAS1_TID_SHIFT);
> -
> -
> -    /* next victim logic */
> -    env->spr[SPR_BOOKE_MAS0] |=3D env->last_way << MAS0_ESEL_SHIFT;
> -    env->last_way++;
> -    env->last_way &=3D booke206_tlb_ways(env, 0) - 1;
> -    env->spr[SPR_BOOKE_MAS0] |=3D env->last_way << MAS0_NV_SHIFT;
> -}
> -
> -static bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr,
> -                            MMUAccessType access_type,
> -                            hwaddr *raddrp, int *psizep, int *protp,
> -                            int mmu_idx, bool guest_visible)
> -{
> -    CPUState *cs =3D CPU(cpu);
> -    CPUPPCState *env =3D &cpu->env;
> -    mmu_ctx_t ctx;
> -    int ret;
> -
> -    if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
> -        ret =3D mmubooke206_get_physical_address(env, &ctx, eaddr, acces=
s_type,
> -                                               mmu_idx);
> -    } else {
> -        ret =3D mmubooke_get_physical_address(env, &ctx, eaddr, access_t=
ype);
> -    }
> -    if (ret =3D=3D 0) {
> -        *raddrp =3D ctx.raddr;
> -        *protp =3D ctx.prot;
> -        *psizep =3D TARGET_PAGE_BITS;
> -        return true;
> -    } else if (!guest_visible) {
> -        return false;
> -    }
> -
> -    log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
> -    env->error_code =3D 0;
> -    switch (ret) {
> -    case -1:
> -        /* No matches in page tables or TLB */
> -        if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
> -            booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_id=
x);
> -        }
> -        cs->exception_index =3D (access_type =3D=3D MMU_INST_FETCH) ?
> -                              POWERPC_EXCP_ITLB : POWERPC_EXCP_DTLB;
> -        env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -        env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_type=
);
> -        break;
> -    case -2:
> -        /* Access rights violation */
> -        cs->exception_index =3D (access_type =3D=3D MMU_INST_FETCH) ?
> -                              POWERPC_EXCP_ISI : POWERPC_EXCP_DSI;
> -        if (access_type !=3D MMU_INST_FETCH) {
> -            env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -            env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_=
type);
> -        }
> -        break;
> -    case -3:
> -        /* No execute protection violation */
> -        if (access_type =3D=3D MMU_INST_FETCH) {
> -            cs->exception_index =3D POWERPC_EXCP_ISI;
> -            env->spr[SPR_BOOKE_ESR] =3D 0;
> -        }
> -        break;
> -    }
> -
> -    return false;
> -}
> -
>  /* Perform address translation */
>  /* TODO: Split this by mmu_model. */
>  static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,


