Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7910C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 05:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7qTI-0004ks-Vd; Fri, 17 May 2024 01:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7qTD-0004fZ-9R; Fri, 17 May 2024 01:49:31 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7qT4-0007CF-7h; Fri, 17 May 2024 01:49:30 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ed904c2280so1672835ad.2; 
 Thu, 16 May 2024 22:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715924960; x=1716529760; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGMieEc7o3D1Jk1WVKsiopIpHsM+RLEUQ6LsdmydI+k=;
 b=m2l3+O38P/J1+e+92QLK79HeMggY8J7eCVIVzVUbY4w1cEjhbbgRel3QalbjK+Kow8
 EPwyHUmVw7xNfzmzW13lP3C/zEnc5m9tU2NPn2vjEmgUaMSVERZARS8xsIkNSA7MZkKX
 RslROHTnyJK1lI4wbh963CgDe6eC5l6F1y8dxkUKNgemzP8MIHPCle+PDs5RvoLG5H8V
 fqvEM4shdNsAkdTRFLY386eOt4Pk5amcWEhDnS6Eb25A/SHiQy/yvUz6T+9WgbaaUIVa
 nby9x24z4c8R7tAKrAmZfvdiginrSAZpPfutKIiAwjcGyzae0kfUVGZPRAtCZegm1iJg
 CsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715924960; x=1716529760;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JGMieEc7o3D1Jk1WVKsiopIpHsM+RLEUQ6LsdmydI+k=;
 b=WNaUK0l89m5i4+oOrqnY3DGTwcKKpRmlx/v7LbRPSlQbwROqtEZfpR1ldILAj5bv5b
 2wQWE5u286wMHQaNfo+hY6BJFAUjGqqOf01NN8Ql+1g9sM9XXRg7IWGCNogfLWu7+aeD
 baHXWdnNpEs9L3W1SG66U6C3muTNIibPhP7ZegTPD4kA2DyXMAq+dvLPuZ9Fj4LXP264
 h80WewuU4zR+k3WXLyW72l+XmCsbwFGHhTBAXla89H0KX2HcRmknsj7/o//z6g0iDjYJ
 t3WT9rmFvmDtE/K2W2a3MejqrWj5hQbiunmcJYKvb3F994BHTKYid+d7ft36Vh6FdXhA
 DEAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW4cMId0/Q5Fv3VOaPcfp5Sx7SQISF9J9bLcm2DDNKLHE58Ov/+/eRa1mNV9DrjB3BXXUrniEFSkDlTnGFUCwIac86WWBPmaG/vVLC027olYYDA2RqRGqnJD4=
X-Gm-Message-State: AOJu0Yw6Z2CxUZON7YTItJ7jL7naoHcQaKe2kFtB0ip1DmyysAeInTMt
 ixgQ7DfIhD9rQa/R3zTeCs0/GcpKL+gukmxWV5NumjUVdmYJGfE1
X-Google-Smtp-Source: AGHT+IG/MhhN0ncJ8FaoCe/o4/CdCc7xhyBQinK0agNS4H7m/+LsFonyE7wP9kAH6H3RsIr7/r6xaA==
X-Received: by 2002:a17:903:234d:b0:1f0:96df:3aa0 with SMTP id
 d9443c01a7336-1f096df3f70mr62141885ad.52.1715924959674; 
 Thu, 16 May 2024 22:49:19 -0700 (PDT)
Received: from localhost ([1.146.118.37]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0b9d3e26sm148719435ad.43.2024.05.16.22.49.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 22:49:19 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 May 2024 15:49:13 +1000
Message-Id: <D1BOMPEB8367.1EUJ76W9OWEO0@gmail.com>
Subject: Re: [PATCH v7 25/61] target/ppc/mmu_common.c: Split off 40x cases
 from ppc_jumbo_xlate()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1715555763.git.balaton@eik.bme.hu>
 <dd4a3e96a09b1fb1b966f6c21cc80601229be8eb.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <dd4a3e96a09b1fb1b966f6c21cc80601229be8eb.1715555763.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon May 13, 2024 at 9:27 AM AEST, BALATON Zoltan wrote:
> Introduce ppc_40x_xlate() to split off 40x handlning leaving only 6xx
> in ppc_jumbo_xlate() now.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 150 +++++++++++++++++++++++++---------------
>  1 file changed, 93 insertions(+), 57 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index ab912da821..ddb014e0aa 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -1258,6 +1258,74 @@ static bool ppc_real_mode_xlate(PowerPCCPU *cpu, v=
addr eaddr,
>      return false;
>  }
> =20
> +static bool ppc_40x_xlate(PowerPCCPU *cpu, vaddr eaddr,
> +                          MMUAccessType access_type,
> +                          hwaddr *raddrp, int *psizep, int *protp,
> +                          int mmu_idx, bool guest_visible)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +    CPUPPCState *env =3D &cpu->env;
> +    int ret;
> +
> +    if (ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep, pro=
tp)) {
> +        return true;
> +    }
> +
> +    ret =3D mmu40x_get_physical_address(env, raddrp, protp, eaddr, acces=
s_type);
> +    if (ret =3D=3D 0) {
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
> +            cs->exception_index =3D POWERPC_EXCP_ITLB;
> +            env->error_code =3D 0;
> +            env->spr[SPR_40x_DEAR] =3D eaddr;
> +            env->spr[SPR_40x_ESR] =3D 0x00000000;
> +            break;
> +        case -2:
> +            /* Access rights violation */
> +            cs->exception_index =3D POWERPC_EXCP_ISI;
> +            env->error_code =3D 0x08000000;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +    } else {
> +        switch (ret) {
> +        case -1:
> +            /* No matches in page tables or TLB */
> +            cs->exception_index =3D POWERPC_EXCP_DTLB;
> +            env->error_code =3D 0;
> +            env->spr[SPR_40x_DEAR] =3D eaddr;
> +            if (access_type =3D=3D MMU_DATA_STORE) {
> +                env->spr[SPR_40x_ESR] =3D 0x00800000;
> +            } else {
> +                env->spr[SPR_40x_ESR] =3D 0x00000000;
> +            }
> +            break;
> +        case -2:
> +            /* Access rights violation */
> +            cs->exception_index =3D POWERPC_EXCP_DSI;
> +            env->error_code =3D 0;
> +            env->spr[SPR_40x_DEAR] =3D eaddr;
> +            if (access_type =3D=3D MMU_DATA_STORE) {
> +                env->spr[SPR_40x_ESR] |=3D 0x00800000;
> +            }
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +    }
> +    return false;
> +}
> +
>  /* Perform address translation */
>  /* TODO: Split this by mmu_model. */
>  static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
> @@ -1301,23 +1369,11 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vadd=
r eaddr,
>          switch (ret) {
>          case -1:
>              /* No matches in page tables or TLB */
> -            switch (env->mmu_model) {
> -            case POWERPC_MMU_SOFT_6xx:
> -                cs->exception_index =3D POWERPC_EXCP_IFTLB;
> -                env->error_code =3D 1 << 18;
> -                env->spr[SPR_IMISS] =3D eaddr;
> -                env->spr[SPR_ICMP] =3D 0x80000000 | ctx.ptem;
> -                goto tlb_miss;
> -            case POWERPC_MMU_SOFT_4xx:
> -                cs->exception_index =3D POWERPC_EXCP_ITLB;
> -                env->error_code =3D 0;
> -                env->spr[SPR_40x_DEAR] =3D eaddr;
> -                env->spr[SPR_40x_ESR] =3D 0x00000000;
> -                break;
> -            default:
> -                g_assert_not_reached();
> -            }
> -            break;
> +            cs->exception_index =3D POWERPC_EXCP_IFTLB;
> +            env->error_code =3D 1 << 18;
> +            env->spr[SPR_IMISS] =3D eaddr;
> +            env->spr[SPR_ICMP] =3D 0x80000000 | ctx.ptem;
> +            goto tlb_miss;
>          case -2:
>              /* Access rights violation */
>              cs->exception_index =3D POWERPC_EXCP_ISI;
> @@ -1339,54 +1395,31 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vadd=
r eaddr,
>          switch (ret) {
>          case -1:
>              /* No matches in page tables or TLB */
> -            switch (env->mmu_model) {
> -            case POWERPC_MMU_SOFT_6xx:
> -                if (access_type =3D=3D MMU_DATA_STORE) {
> -                    cs->exception_index =3D POWERPC_EXCP_DSTLB;
> -                    env->error_code =3D 1 << 16;
> -                } else {
> -                    cs->exception_index =3D POWERPC_EXCP_DLTLB;
> -                    env->error_code =3D 0;
> -                }
> -                env->spr[SPR_DMISS] =3D eaddr;
> -                env->spr[SPR_DCMP] =3D 0x80000000 | ctx.ptem;
> -            tlb_miss:
> -                env->error_code |=3D ctx.key << 19;
> -                env->spr[SPR_HASH1] =3D ppc_hash32_hpt_base(cpu) +
> -                  get_pteg_offset32(cpu, ctx.hash[0]);
> -                env->spr[SPR_HASH2] =3D ppc_hash32_hpt_base(cpu) +
> -                  get_pteg_offset32(cpu, ctx.hash[1]);
> -                break;
> -            case POWERPC_MMU_SOFT_4xx:
> -                cs->exception_index =3D POWERPC_EXCP_DTLB;
> +            if (access_type =3D=3D MMU_DATA_STORE) {
> +                cs->exception_index =3D POWERPC_EXCP_DSTLB;
> +                env->error_code =3D 1 << 16;
> +            } else {
> +                cs->exception_index =3D POWERPC_EXCP_DLTLB;
>                  env->error_code =3D 0;
> -                env->spr[SPR_40x_DEAR] =3D eaddr;
> -                if (access_type =3D=3D MMU_DATA_STORE) {
> -                    env->spr[SPR_40x_ESR] =3D 0x00800000;
> -                } else {
> -                    env->spr[SPR_40x_ESR] =3D 0x00000000;
> -                }
> -                break;
> -            default:
> -                g_assert_not_reached();
>              }
> +            env->spr[SPR_DMISS] =3D eaddr;
> +            env->spr[SPR_DCMP] =3D 0x80000000 | ctx.ptem;
> +tlb_miss:
> +            env->error_code |=3D ctx.key << 19;
> +            env->spr[SPR_HASH1] =3D ppc_hash32_hpt_base(cpu) +
> +                                  get_pteg_offset32(cpu, ctx.hash[0]);
> +            env->spr[SPR_HASH2] =3D ppc_hash32_hpt_base(cpu) +
> +                                  get_pteg_offset32(cpu, ctx.hash[1]);
>              break;
>          case -2:
>              /* Access rights violation */
>              cs->exception_index =3D POWERPC_EXCP_DSI;
>              env->error_code =3D 0;
> -            if (env->mmu_model =3D=3D POWERPC_MMU_SOFT_4xx) {
> -                env->spr[SPR_40x_DEAR] =3D eaddr;
> -                if (access_type =3D=3D MMU_DATA_STORE) {
> -                    env->spr[SPR_40x_ESR] |=3D 0x00800000;
> -                }
> +            env->spr[SPR_DAR] =3D eaddr;
> +            if (access_type =3D=3D MMU_DATA_STORE) {
> +                env->spr[SPR_DSISR] =3D 0x0A000000;
>              } else {
> -                env->spr[SPR_DAR] =3D eaddr;
> -                if (access_type =3D=3D MMU_DATA_STORE) {
> -                    env->spr[SPR_DSISR] =3D 0x0A000000;
> -                } else {
> -                    env->spr[SPR_DSISR] =3D 0x08000000;
> -                }
> +                env->spr[SPR_DSISR] =3D 0x08000000;
>              }
>              break;
>          case -4:
> @@ -1462,6 +1495,9 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAcc=
essType access_type,
>      case POWERPC_MMU_BOOKE206:
>          return ppc_booke_xlate(cpu, eaddr, access_type, raddrp,
>                                 psizep, protp, mmu_idx, guest_visible);
> +    case POWERPC_MMU_SOFT_4xx:
> +        return ppc_40x_xlate(cpu, eaddr, access_type, raddrp,
> +                             psizep, protp, mmu_idx, guest_visible);
>      case POWERPC_MMU_REAL:
>          return ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psiz=
ep,
>                                     protp);


