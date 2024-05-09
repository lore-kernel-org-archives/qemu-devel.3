Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24561C25B74
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 06:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4x6q-0001HA-By; Thu, 09 May 2024 02:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4x6G-0000xi-0i; Thu, 09 May 2024 02:17:53 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4x6B-0000wt-LV; Thu, 09 May 2024 02:17:51 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ed41eb3382so3517105ad.0; 
 Wed, 08 May 2024 23:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715235465; x=1715840265; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nKFFOosT3DC17O2ypwtMP7hscZql6RGpk+MuRN1Xn7Q=;
 b=fk8OweqwSpO9kyGv9dWKDnozv0sEsh7nk2iFmZRnCqMahZ4oCoh58jIWHy2Id5VFHc
 CSOOwxWJyeK3alC5hvAaQPlN7d//VDoNGje5Ddj3IOMeJaXYr+nBRYZvMB1c04OVntsG
 XIscoaGVs9Ljlomeu47kfohiH+Gkiz4SAMN4ckQHH8sUE9ruYb3V5C43sFG3mLuVMC56
 +tgq6ItHoFc2PY+QhZkFvsNGfda4TIAzBdW5/daA5EnTsndSGqTPMKNJGmoZVUIFU1/P
 KdZ025zkRTCYLLS5UNExSCD4oamzNuOQGcJe9PrgziN2QyjADEYbRlEII96pjl7rvgWc
 3QFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715235465; x=1715840265;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nKFFOosT3DC17O2ypwtMP7hscZql6RGpk+MuRN1Xn7Q=;
 b=TANXIpmNZDW7+O1b1NnIb0AqS9qtfL2CHmHXOz6xaH6hwJ/03I6TyB/TMTZVMOlekO
 JH0AovtS0X3Ld7rWqE2Ts+xUWc2x/c96x4k42Tk1B/ba8HHTNoE1+AftTD2OM2O6+5La
 8balS5i9md++wrFW22VIsM6pW7F0FAqgNiWgLd9Q+AXrIMVG0gDmjqcEXcWM8inq7ssU
 3SL7B7GNzC1cwlSEPVDwz1+V/plP0NXU3In/06iQgSiO2cEPoS1a1IX6PrcHcxLplHH0
 8O6h2ns7/kSoHKmgtra0N5UV2VIuLaCjXpuA1qKTxeSaRzg/CDbsScsUPav2pdiryjZA
 IEkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUgO2c9bsqGjO8e/sN8BX9VGl4HtiKZyHqXUCSdo0P3hLgddvO2M6jaFcQafamvGdgUOkLv1x84ojmSdTP8bxkO67mYK9+iFsb5O8RgwhrcucoYQ++Pa1r/VY=
X-Gm-Message-State: AOJu0Yw3EIAcGWYPKvKaoTB7xAIU8TTwY5RaH4O1wPc+j001LCW8ubCv
 0KKmMCK36ki6mY7/EuWBneSeusm+qfnZZfV9CgWtVwPlLbRyuPXx
X-Google-Smtp-Source: AGHT+IFij6ub5xflb6c/gCSc4qw6tA21gINWZcYuw1N/3i0pjHc37YMyTftaB9uh3GAPYP+LafJsJg==
X-Received: by 2002:a17:902:8486:b0:1eb:77ed:8fba with SMTP id
 d9443c01a7336-1eeb01a63f6mr50301055ad.17.1715235465519; 
 Wed, 08 May 2024 23:17:45 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bad62fesm5938325ad.83.2024.05.08.23.17.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 23:17:45 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 May 2024 16:17:39 +1000
Message-Id: <D14W84AKT9KY.3HX1DFSQYU7IT@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v4 25/33] target/ppc/mmu_common.c: Split off BookE
 handling from ppc_jumbo_xlate()
X-Mailer: aerc 0.17.0
References: <cover.1715209155.git.balaton@eik.bme.hu>
 <49e2b7e5a0fb98fd3f8a6d3c0c8ac2a05ebceb7a.1715209155.git.balaton@eik.bme.hu>
In-Reply-To: <49e2b7e5a0fb98fd3f8a6d3c0c8ac2a05ebceb7a.1715209155.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

On Thu May 9, 2024 at 9:36 AM AEST, BALATON Zoltan wrote:
> Introduce ppc_booke_xlate() to handle BookE and BookE 2.06 cases to
> reduce ppc_jumbo_xlate() further.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 148 ++++++++++++++++++++++++++--------------
>  1 file changed, 98 insertions(+), 50 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 53ffcc795d..be0565f19c 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -1089,21 +1089,9 @@ static int get_physical_address_wtlb(CPUPPCState *=
env, mmu_ctx_t *ctx,
>                                       MMUAccessType access_type, int type=
,
>                                       int mmu_idx)
>  {
> -    bool real_mode;
> -
> -    if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE) {
> -        return mmubooke_get_physical_address(env, &ctx->raddr, &ctx->pro=
t,
> -                                             eaddr, access_type);
> -    } else if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
> -        return mmubooke206_get_physical_address(env, &ctx->raddr, &ctx->=
prot,
> -                                                eaddr, access_type, mmu_=
idx);
> -    }
> -
> -    real_mode =3D (type =3D=3D ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR,=
 IR)
> -                                      : !FIELD_EX64(env->msr, MSR, DR);
> -    if (real_mode && (env->mmu_model =3D=3D POWERPC_MMU_SOFT_6xx ||
> -                      env->mmu_model =3D=3D POWERPC_MMU_SOFT_4xx ||
> -                      env->mmu_model =3D=3D POWERPC_MMU_REAL)) {
> +    bool real_mode =3D (type =3D=3D ACCESS_CODE) ? !FIELD_EX64(env->msr,=
 MSR, IR)
> +                                           : !FIELD_EX64(env->msr, MSR, =
DR);
> +    if (real_mode) {
>          ctx->raddr =3D eaddr;
>          ctx->prot =3D PAGE_RWX;
>          return 0;
> @@ -1113,6 +1101,8 @@ static int get_physical_address_wtlb(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>      case POWERPC_MMU_SOFT_6xx:
>          return mmu6xx_get_physical_address(env, ctx, eaddr, access_type,=
 type);
>      case POWERPC_MMU_SOFT_4xx:
> +        /* avoid maybe used uninitialized warnings for unused fields in =
ctx */
> +        memset(ctx, 0, sizeof(*ctx));
>          return mmu40x_get_physical_address(env, &ctx->raddr, &ctx->prot,=
 eaddr,
>                                             access_type);
>      case POWERPC_MMU_REAL:
> @@ -1177,6 +1167,93 @@ static void booke206_update_mas_tlb_miss(CPUPPCSta=
te *env, target_ulong address,
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
> +    hwaddr raddr;
> +    int prot, ret;
> +
> +    if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
> +        ret =3D mmubooke206_get_physical_address(env, &raddr, &prot, ead=
dr,
> +                                               access_type, mmu_idx);
> +    } else {
> +        ret =3D mmubooke_get_physical_address(env, &raddr, &prot, eaddr,
> +                                            access_type);
> +    }
> +    if (ret =3D=3D 0) {
> +        *raddrp =3D raddr;
> +        *protp =3D prot;
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
> +        }
> +    }
> +    return false;
> +}
> +
>  /* Perform address translation */
>  /* TODO: Split this by mmu_model. */
>  static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
> @@ -1229,15 +1306,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr=
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
> @@ -1248,23 +1316,12 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vadd=
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
> @@ -1305,15 +1362,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr=
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
> @@ -1330,10 +1378,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr=
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
> @@ -1412,6 +1456,10 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAc=
cessType access_type,
>      case POWERPC_MMU_32B:
>          return ppc_hash32_xlate(cpu, eaddr, access_type, raddrp,
>                                 psizep, protp, mmu_idx, guest_visible);
> +    case POWERPC_MMU_BOOKE:
> +    case POWERPC_MMU_BOOKE206:
> +        return ppc_booke_xlate(cpu, eaddr, access_type, raddrp,
> +                               psizep, protp, mmu_idx, guest_visible);
>      case POWERPC_MMU_MPC8xx:
>          cpu_abort(env_cpu(&cpu->env), "MPC8xx MMU model is not implement=
ed\n");
>      default:


