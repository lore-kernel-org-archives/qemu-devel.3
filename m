Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788FEC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 11:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4JMa-0007ox-Q9; Tue, 07 May 2024 07:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4JMD-0007en-TC; Tue, 07 May 2024 07:51:48 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4JM7-0005B2-Ax; Tue, 07 May 2024 07:51:40 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f4302187c0so3877286b3a.1; 
 Tue, 07 May 2024 04:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715082693; x=1715687493; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgeIt2sEeqSlMD1/Uyq9iBXMq6YY5pvO0LmOY3uL06Y=;
 b=j/MEdw2S9M+x5Yr5XUbFJfEye8sClHO1FJ4kUi7LgfSFtjUK9YsVYWZ9XAAjy5YzTM
 dqXolkk8UgMx1PSdnr3ktWsH939KmYn0hUr69PmyPY4hJkdicEDz9dc+db3aeLLJrvTT
 u43ysiUHRrMTBb6hs2USr6GR1JQyEMJuD9BhihBedrg/L2nsA4gjBS6pItqgsg+bO2ci
 Xy181aLTNDVMAlX9udday5hkVYocyM13UCd2b4yLKOsWRlViq0QpNG6gvOPFf/uyvxXu
 O/aNd6Xql0Dn8YTQc2XMlE6OL79BgWuM+N/hUpranCNdCk+Yn7s3Xpy3P2luXXlCAcLK
 juUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715082693; x=1715687493;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VgeIt2sEeqSlMD1/Uyq9iBXMq6YY5pvO0LmOY3uL06Y=;
 b=hOLpHpVtuYRpQ44k1CpWr3IQ7R3ma3feqAojFRhrOE7JoSd1UE2wSILLqyPm2p9KFL
 YirjRwi6cU54bFblKpqDy049SVYyZmNZfgE6DdDBe6z9s5w2LkrvXqFZbygGGDMW4vqq
 0CnCR48qP+fMXaYzOeZmG8kM9DOjzkt/HizDBjoRHj34HaXSpGSHQEH7PbnKL02MaPAJ
 QieSMO2M4BZLpzIz31+D2xCfpbxPl73o6UPsUPKspl3350N+HTzmdiWr83FH1R1F/OCX
 RKwy7OvXzJm4m3b1NRjQLSogetiPm+49uUiDHtz9CFGpY6okJDYDDgaD+YGgtxFIuxna
 +LCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1mIpCB5IsP/DcyeSZlCL6OUa0HYRJOtZ/wx2YgStDlFpxl8rueGq5YvBahBJgqbvyAja+GxYgOOJjW5McsApziph86qq+HdTXRc+6pqiYAFo41ZwrfyAvc1Q=
X-Gm-Message-State: AOJu0YyGHSg+PjFzqd7iHMB+zcOEica2hBRPVrjZZWNkCEKP2qyhoYuy
 geN8uXTBmRmovHRR4R82XB97TajisxW0t2bGcZM2Sr9IUJWn0CJ8
X-Google-Smtp-Source: AGHT+IFsgA/G4xbpwSFTBiPcVnzSjv4piaVuVvf7xC5Kxjc6mpsAnlorGEvq5iQSOX+fg2pq8BWgVg==
X-Received: by 2002:a05:6a20:d492:b0:1ac:de57:b1e3 with SMTP id
 im18-20020a056a20d49200b001acde57b1e3mr3609090pzb.0.1715082693092; 
 Tue, 07 May 2024 04:51:33 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 w17-20020aa79a11000000b006f4476e078dsm8091122pfj.192.2024.05.07.04.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 04:51:32 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 21:51:28 +1000
Message-Id: <D13E2M3CRFEZ.2CW6QQE6KSL31@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 23/28] target/ppc/mmu_common.c: Split off BookE
 handling from ppc_jumbo_xlate()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <d0a46ea05b85367f763506bbe12a8e9e146cdab5.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <d0a46ea05b85367f763506bbe12a8e9e146cdab5.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
> Introduce ppc_booke_xlate() to handle BookE and BookE 2.06 cases to
> reduce ppc_jumbo_xlate() further.

Nice.

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 180 ++++++++++++++++++++++++++++++----------
>  1 file changed, 138 insertions(+), 42 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 0ce5c1e841..a1f98f8de4 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -1250,6 +1250,137 @@ static void booke206_update_mas_tlb_miss(CPUPPCSt=
ate *env, target_ulong address,
>      env->spr[SPR_BOOKE_MAS0] |=3D env->last_way << MAS0_NV_SHIFT;
>  }
> =20
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
> +    if (access_type =3D=3D MMU_INST_FETCH) {
> +        switch (ret) {
> +        case -1:
> +            /* No matches in page tables or TLB */
> +            switch (env->mmu_model) {
> +            case POWERPC_MMU_BOOKE206:
> +                booke206_update_mas_tlb_miss(env, eaddr, access_type, mm=
u_idx);
> +                /* fall through */
> +            case POWERPC_MMU_BOOKE:
> +                cs->exception_index =3D POWERPC_EXCP_ITLB;
> +                env->error_code =3D 0;
> +                env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> +                env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, acc=
ess_type);
> +                break;
> +            default:
> +                g_assert_not_reached();
> +            }
> +            break;
> +        case -2:
> +            /* Access rights violation */
> +            cs->exception_index =3D POWERPC_EXCP_ISI;
> +            env->error_code =3D 0;
> +            break;
> +        case -3:
> +            /* No execute protection violation */
> +            cs->exception_index =3D POWERPC_EXCP_ISI;
> +            env->spr[SPR_BOOKE_ESR] =3D 0;
> +            env->error_code =3D 0;
> +            break;
> +        case -4:
> +            /* Direct store exception */
> +            /* No code fetch is allowed in direct-store areas */
> +            cs->exception_index =3D POWERPC_EXCP_ISI;
> +            env->error_code =3D 0;
> +            break;

I don't think BookE has -4 (direct address translation) areas, it's
only 6xx by the looks.

You could put another patch before this to remove the BOOKE tests
from the ret =3D=3D -4 cases, then avoid copying them in here.

Otherwise I think it looks okay.

Thanks,
Nick

> +        }
> +    } else {
> +        switch (ret) {
> +        case -1:
> +            /* No matches in page tables or TLB */
> +            switch (env->mmu_model) {
> +            case POWERPC_MMU_BOOKE206:
> +                booke206_update_mas_tlb_miss(env, eaddr, access_type, mm=
u_idx);
> +                /* fall through */
> +            case POWERPC_MMU_BOOKE:
> +                cs->exception_index =3D POWERPC_EXCP_DTLB;
> +                env->error_code =3D 0;
> +                env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> +                env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, acc=
ess_type);
> +                break;
> +            default:
> +                g_assert_not_reached();
> +            }
> +            break;
> +        case -2:
> +            /* Access rights violation */
> +            cs->exception_index =3D POWERPC_EXCP_DSI;
> +            env->error_code =3D 0;
> +            env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> +            env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_=
type);
> +            break;
> +        case -4:
> +            /* Direct store exception */
> +            switch (env->access_type) {
> +            case ACCESS_FLOAT:
> +                /* Floating point load/store */
> +                cs->exception_index =3D POWERPC_EXCP_ALIGN;
> +                env->error_code =3D POWERPC_EXCP_ALIGN_FP;
> +                env->spr[SPR_DAR] =3D eaddr;
> +                break;
> +            case ACCESS_RES:
> +                /* lwarx, ldarx or stwcx. */
> +                cs->exception_index =3D POWERPC_EXCP_DSI;
> +                env->error_code =3D 0;
> +                env->spr[SPR_DAR] =3D eaddr;
> +                if (access_type =3D=3D MMU_DATA_STORE) {
> +                    env->spr[SPR_DSISR] =3D 0x06000000;
> +                } else {
> +                    env->spr[SPR_DSISR] =3D 0x04000000;
> +                }
> +                break;
> +            case ACCESS_EXT:
> +                /* eciwx or ecowx */
> +                cs->exception_index =3D POWERPC_EXCP_DSI;
> +                env->error_code =3D 0;
> +                env->spr[SPR_DAR] =3D eaddr;
> +                if (access_type =3D=3D MMU_DATA_STORE) {
> +                    env->spr[SPR_DSISR] =3D 0x06100000;
> +                } else {
> +                    env->spr[SPR_DSISR] =3D 0x04100000;
> +                }
> +                break;
> +            default:
> +                printf("DSI: invalid exception (%d)\n", ret);
> +                cs->exception_index =3D POWERPC_EXCP_PROGRAM;
> +                env->error_code =3D POWERPC_EXCP_INVAL | POWERPC_EXCP_IN=
VAL_INVAL;
> +                env->spr[SPR_DAR] =3D eaddr;
> +                break;
> +            }
> +            break;
> +        }
> +    }
> +    return false;
> +}
> +
>  /* Perform address translation */
>  /* TODO: Split this by mmu_model. */
>  static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
> @@ -1302,15 +1433,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr=
 eaddr,
>                  env->spr[SPR_40x_DEAR] =3D eaddr;
>                  env->spr[SPR_40x_ESR] =3D 0x00000000;
>                  break;
> -            case POWERPC_MMU_BOOKE206:
> -                booke206_update_mas_tlb_miss(env, eaddr, access_type, mm=
u_idx);
> -                /* fall through */
> -            case POWERPC_MMU_BOOKE:
> -                cs->exception_index =3D POWERPC_EXCP_ITLB;
> -                env->error_code =3D 0;
> -                env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -                env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, acc=
ess_type);
> -                break;
>              case POWERPC_MMU_REAL:
>                  cpu_abort(cs, "PowerPC in real mode should never raise "
>                                "any MMU exceptions\n");
> @@ -1321,34 +1443,18 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vadd=
r eaddr,
>          case -2:
>              /* Access rights violation */
>              cs->exception_index =3D POWERPC_EXCP_ISI;
> -            if ((env->mmu_model =3D=3D POWERPC_MMU_BOOKE) ||
> -                (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206)) {
> -                env->error_code =3D 0;
> -            } else {
> -                env->error_code =3D 0x08000000;
> -            }
> +            env->error_code =3D 0x08000000;
>              break;
>          case -3:
>              /* No execute protection violation */
> -            if ((env->mmu_model =3D=3D POWERPC_MMU_BOOKE) ||
> -                (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206)) {
> -                env->spr[SPR_BOOKE_ESR] =3D 0x00000000;
> -                env->error_code =3D 0;
> -            } else {
> -                env->error_code =3D 0x10000000;
> -            }
>              cs->exception_index =3D POWERPC_EXCP_ISI;
> +            env->error_code =3D 0x10000000;
>              break;
>          case -4:
>              /* Direct store exception */
>              /* No code fetch is allowed in direct-store areas */
>              cs->exception_index =3D POWERPC_EXCP_ISI;
> -            if ((env->mmu_model =3D=3D POWERPC_MMU_BOOKE) ||
> -                (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206)) {
> -                env->error_code =3D 0;
> -            } else {
> -                env->error_code =3D 0x10000000;
> -            }
> +            env->error_code =3D 0x10000000;
>              break;
>          }
>      } else {
> @@ -1383,15 +1489,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr=
 eaddr,
>                      env->spr[SPR_40x_ESR] =3D 0x00000000;
>                  }
>                  break;
> -            case POWERPC_MMU_BOOKE206:
> -                booke206_update_mas_tlb_miss(env, eaddr, access_type, mm=
u_idx);
> -                /* fall through */
> -            case POWERPC_MMU_BOOKE:
> -                cs->exception_index =3D POWERPC_EXCP_DTLB;
> -                env->error_code =3D 0;
> -                env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -                env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, acc=
ess_type);
> -                break;
>              case POWERPC_MMU_REAL:
>                  cpu_abort(cs, "PowerPC in real mode should never raise "
>                                "any MMU exceptions\n");
> @@ -1408,10 +1505,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr=
 eaddr,
>                  if (access_type =3D=3D MMU_DATA_STORE) {
>                      env->spr[SPR_40x_ESR] |=3D 0x00800000;
>                  }
> -            } else if ((env->mmu_model =3D=3D POWERPC_MMU_BOOKE) ||
> -                       (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206)) {
> -                env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -                env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, acc=
ess_type);
>              } else {
>                  env->spr[SPR_DAR] =3D eaddr;
>                  if (access_type =3D=3D MMU_DATA_STORE) {
> @@ -1490,7 +1583,10 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAc=
cessType access_type,
>      case POWERPC_MMU_32B:
>          return ppc_hash32_xlate(cpu, eaddr, access_type, raddrp,
>                                 psizep, protp, mmu_idx, guest_visible);
> -
> +    case POWERPC_MMU_BOOKE:
> +    case POWERPC_MMU_BOOKE206:
> +        return ppc_booke_xlate(cpu, eaddr, access_type, raddrp,
> +                               psizep, protp, mmu_idx, guest_visible);
>      default:
>          return ppc_jumbo_xlate(cpu, eaddr, access_type, raddrp,
>                                 psizep, protp, mmu_idx, guest_visible);


