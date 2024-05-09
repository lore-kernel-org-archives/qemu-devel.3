Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564A1C41513
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 06:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4wqr-0007uX-Vm; Thu, 09 May 2024 02:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4wqq-0007uB-3v; Thu, 09 May 2024 02:01:56 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4wqo-0002Ww-FV; Thu, 09 May 2024 02:01:55 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f489e64eb3so468419b3a.1; 
 Wed, 08 May 2024 23:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715234512; x=1715839312; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwnbxJwCm18pysvEpcmyCAsUosBoDkJ2x+/rUJUGr2s=;
 b=iJejlpmtLhh7jb/7mVgmjBgvFUE1CBCwZXBwXKa5KurKBLQSYCCNMRPmFSdrDAA2Tg
 Rtr3+8FcAK2MIyBQfhlUDctN8rsXr5tO8xk6Di8s8qrm9AD2yKvUSnU5BKlbYxPiD5Sd
 UIQoVGT+96WHZR8MUjb0B8c8b6KowIr/2AQnJMVD6GgMHAI7QHwgf9NrDz363ssNtLlF
 s0n9xPUDsFFcvfWufmhcsHkxVl73PTVl/2PaBcgnNinMR5TkfyzveSCQMqysPhNi2TID
 sfzBDupRP2yqW7QCaODfs8zt/ACeXaxm/9a8VaCk6GppjlOz2kzPiabiJBuyihsYdNKL
 SMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715234512; x=1715839312;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nwnbxJwCm18pysvEpcmyCAsUosBoDkJ2x+/rUJUGr2s=;
 b=SHJOmRiUCHHPRorLCQHVJIO3baqSn36Os86j6L/fBRtd9DguM+bh5ipLAoGc1Tl7Jw
 t+8eW+GPBeakt+0Mpomg8XRtzQkinXp5j+pCPA3YtdHDqUvHTrhCmgS3FIgDX1TmuDqN
 1P5JzxTENjXL93/dtvemtcpXzQ8kVq5+R3oIMyOFkkcT/TrQxE3ZVGafra9vEaYykFbZ
 7bsY5IhhUHwg/M8/IZ3g2Y8H4GFatpkI/Kmo8v6PfL6kp8bSwNZVnn9Ll/qbdHsOnD3C
 qT/UMUgC9cVE/x/VlzBkfUJtBxYGCDtyurUXGwiNXdFAFW+mxH4XVQC76ipd3JUWIdsT
 0GkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4vrRXdFEcEEBciry3uu49KAbU2LVTXlwCWMNiTQ92aE/eiY+Uj13+Fp0bN7eoLzmAm59UGko9bgLF2QiqsozZ1SjT55+9Lu1gYiTxFjpkhnpJg6s+jzgq2CY=
X-Gm-Message-State: AOJu0YxlHH/rgDaQ79QjzVsLwaLSkuSDqi06TrADdm/H4lNhAW7CvRCF
 sKDtPJizTImFGEldgzwtI3nMtk8T8hKDbMddnkhWu61FMiZBRniALUIbOA==
X-Google-Smtp-Source: AGHT+IG3zqtuLXkigJrHbbvHboOYvJK9hJS3noTwhyuyiAQXB7ia6E3k6z7zvrAebLa3G/ooBwi+KA==
X-Received: by 2002:a05:6a21:7882:b0:1aa:4289:5921 with SMTP id
 adf61e73a8af0-1afc8db8223mr5615795637.50.1715234512386; 
 Wed, 08 May 2024 23:01:52 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6340a447391sm529183a12.3.2024.05.08.23.01.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 23:01:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 May 2024 16:01:47 +1000
Message-Id: <D14VVYX2BVWJ.R043K7RLC59V@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v4 11/33] target/ppc/mmu_common.c: Move some debug logging
X-Mailer: aerc 0.17.0
References: <cover.1715209155.git.balaton@eik.bme.hu>
 <5a82816a6aa18887e48f9d0b788f99f55277a980.1715209155.git.balaton@eik.bme.hu>
In-Reply-To: <5a82816a6aa18887e48f9d0b788f99f55277a980.1715209155.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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
> Move the debug logging within ppc6xx_tlb_check() from after its only
> call to simplify the caller.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mmu_common.c | 54 ++++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 30 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index ba60b4902b..89bfd9aa45 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -225,17 +225,14 @@ static int ppc6xx_tlb_check(CPUPPCState *env, mmu_c=
tx_t *ctx,
>                        access_type =3D=3D MMU_INST_FETCH ? 'I' : 'D');
>          switch (ppc6xx_tlb_pte_check(ctx, tlb->pte0, tlb->pte1,
>                                       0, access_type)) {
> -        case -3:
> -            /* TLB inconsistency */
> -            return -1;
>          case -2:
>              /* Access violation */
>              ret =3D -2;
>              best =3D nr;
>              break;
> -        case -1:
> +        case -1: /* No match */
> +        case -3: /* TLB inconsistency */
>          default:
> -            /* No match */
>              break;
>          case 0:
>              /* access granted */
> @@ -251,14 +248,34 @@ static int ppc6xx_tlb_check(CPUPPCState *env, mmu_c=
tx_t *ctx,
>          }
>      }
>      if (best !=3D -1) {
> -    done:
> +done:
>          qemu_log_mask(CPU_LOG_MMU, "found TLB at addr " HWADDR_FMT_plx
>                        " prot=3D%01x ret=3D%d\n",
>                        ctx->raddr & TARGET_PAGE_MASK, ctx->prot, ret);
>          /* Update page flags */
>          pte_update_flags(ctx, &env->tlb.tlb6[best].pte1, ret, access_typ=
e);
>      }
> -
> +#if defined(DUMP_PAGE_TABLES)
> +    if (qemu_loglevel_mask(CPU_LOG_MMU)) {
> +        CPUState *cs =3D env_cpu(env);
> +        hwaddr base =3D ppc_hash32_hpt_base(env_archcpu(env));
> +        hwaddr len =3D ppc_hash32_hpt_mask(env_archcpu(env)) + 0x80;
> +        uint32_t a0, a1, a2, a3;
> +
> +        qemu_log("Page table: " HWADDR_FMT_plx " len " HWADDR_FMT_plx "\=
n",
> +                 base, len);
> +        for (hwaddr curaddr =3D base; curaddr < base + len; curaddr +=3D=
 16) {
> +            a0 =3D ldl_phys(cs->as, curaddr);
> +            a1 =3D ldl_phys(cs->as, curaddr + 4);
> +            a2 =3D ldl_phys(cs->as, curaddr + 8);
> +            a3 =3D ldl_phys(cs->as, curaddr + 12);
> +            if (a0 !=3D 0 || a1 !=3D 0 || a2 !=3D 0 || a3 !=3D 0) {
> +                qemu_log(HWADDR_FMT_plx ": %08x %08x %08x %08x\n",
> +                         curaddr, a0, a1, a2, a3);
> +            }
> +        }
> +    }
> +#endif
>      return ret;
>  }
> =20
> @@ -420,29 +437,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *=
env, mmu_ctx_t *ctx,
>          ctx->raddr =3D (hwaddr)-1ULL;
>          /* Software TLB search */
>          ret =3D ppc6xx_tlb_check(env, ctx, eaddr, access_type);
> -#if defined(DUMP_PAGE_TABLES)
> -        if (qemu_loglevel_mask(CPU_LOG_MMU)) {
> -            CPUState *cs =3D env_cpu(env);
> -            hwaddr curaddr;
> -            uint32_t a0, a1, a2, a3;
> -
> -            qemu_log("Page table: " HWADDR_FMT_plx " len " HWADDR_FMT_pl=
x "\n",
> -                     ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu) =
+ 0x80);
> -            for (curaddr =3D ppc_hash32_hpt_base(cpu);
> -                 curaddr < (ppc_hash32_hpt_base(cpu)
> -                            + ppc_hash32_hpt_mask(cpu) + 0x80);
> -                 curaddr +=3D 16) {
> -                a0 =3D ldl_phys(cs->as, curaddr);
> -                a1 =3D ldl_phys(cs->as, curaddr + 4);
> -                a2 =3D ldl_phys(cs->as, curaddr + 8);
> -                a3 =3D ldl_phys(cs->as, curaddr + 12);
> -                if (a0 !=3D 0 || a1 !=3D 0 || a2 !=3D 0 || a3 !=3D 0) {
> -                    qemu_log(HWADDR_FMT_plx ": %08x %08x %08x %08x\n",
> -                             curaddr, a0, a1, a2, a3);
> -                }
> -            }
> -        }
> -#endif
>      } else {
>          qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
>          /* Direct-store segment : absolutely *BUGGY* for now */


