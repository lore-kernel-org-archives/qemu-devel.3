Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F097C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gvO-0003wj-VE; Wed, 08 May 2024 09:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gv9-0003dR-Jm; Wed, 08 May 2024 09:01:21 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gv0-0005JO-OY; Wed, 08 May 2024 09:01:15 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ee13f19e7eso3584698b3a.1; 
 Wed, 08 May 2024 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715173268; x=1715778068; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UkiY3a3o4QAwZqK+HWbkiXBY/BHz1NPh3dZJRMhE0c=;
 b=lB5wTYlybTGYZEw5Zh77HYVbGZc6QCwteoAOF17ZRhNkQ2CWXqamoI27dtxX7YG0xR
 rISA0Nh7IHjjR9RzrYu0ZhxNk9A9uIjMNF77wr7mItqmNUrNs8DX5S8GylOlFPYePDuF
 bWCN0HACt7c6VIxsTLqv++12spO5KnWNYO9Esnx2JQbeWGbXrC/HClzGCR1EYAP4E7a9
 t0jUzgMpAqIDwfFquAgpufOM6MFPRAxSo4IDfTyd/Bfj7jJQ5hHJEsnlv1EO1jMoQN5g
 sJBQHryx8sache6jYZCZGnrL5qDnLBg1QZdh/IcD069tA+m/ZBbc6NXUBaSk3BSgCvxK
 KBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715173268; x=1715778068;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3UkiY3a3o4QAwZqK+HWbkiXBY/BHz1NPh3dZJRMhE0c=;
 b=TcmaDHU0R57irsbFhDcAAWFUwL5y+gXj5Av8IUN1uhazsybmCuyILjeoEwaI+kIw2u
 1kx209T0ie2NminKD/V/SEjCJyJBYJ47URsqpdndGA7uzjUE/pVxCSiMQZai4qkVpV07
 wTNcoDr+uvjymCvSaakxYxsHPQAzLeo4lA6vc9sUbDppUpuqc57TAdFhDuYNNdpaAeRo
 UlUfAlTqgo89Nv9vU3J5lLEgDfp+nA9gAYBYd8BZBXHj+WHsUq7h72GxsoFN44e2ydZR
 tkHRwYiEgYbkUPZJxh18uuMDvyX+IJVBpETFZffOX4jASAgyfeSZ8+Oy5B4kX+vADf+w
 9q1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfdSkrnofC1zduGCH01ipP4lZgsEY5/+JRh2KXN7mTEa333bUg4ZpQ68RjA/AhfyRnFdftrdTHyfN2es/q5sczhZPC9yWF09C7xxaa0Hlsv2URfVKD6+ggoZE=
X-Gm-Message-State: AOJu0YzrWww07UAWhm60p7DsA2XGk+IJvUdNkjtYOohBxDL+NJjE67RO
 XJduQxBjdcz1lVVhBlK8ASTosbYHkOOtJAHjD2YKTq8basv5wtH5bvycjg==
X-Google-Smtp-Source: AGHT+IH28DLhlAqz39fzB2pn7uhuHGzCTNuMXbnRNhFyf//oSNcbaJUjDTckXgVO03a3UrN4tL90sg==
X-Received: by 2002:a05:6a20:9147:b0:1a8:2cc0:290a with SMTP id
 adf61e73a8af0-1afc8d5bfd5mr3366423637.30.1715173268237; 
 Wed, 08 May 2024 06:01:08 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 le8-20020a056a004fc800b006f475027095sm5885143pfb.167.2024.05.08.06.01.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 06:01:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 23:01:02 +1000
Message-Id: <D14A6F3X632Z.2JJMJXEXEAC6U@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 24/33] target/ppc/mmu_common.c: Split off BookE
 handling from ppc_jumbo_xlate()
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <a4e98930eee506ca36e10b10d432879f1d9bfe58.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <a4e98930eee506ca36e10b10d432879f1d9bfe58.1715125376.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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
> Introduce ppc_booke_xlate() to handle BookE and BookE 2.06 cases to
> reduce ppc_jumbo_xlate() further.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 128 +++++++++++++++++++++++++++++-----------
>  1 file changed, 92 insertions(+), 36 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 03b834eb77..83dc041a77 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -1194,6 +1194,92 @@ static void booke206_update_mas_tlb_miss(CPUPPCSta=
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
> @@ -1246,15 +1332,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr=
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
> @@ -1265,23 +1342,12 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vadd=
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
> @@ -1322,15 +1388,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr=
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
> @@ -1347,10 +1404,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr=
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
> @@ -1429,7 +1482,10 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAc=
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


