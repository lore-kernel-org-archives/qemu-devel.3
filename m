Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC78C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gho-00018v-8y; Wed, 08 May 2024 08:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4ghm-00018Y-Kf; Wed, 08 May 2024 08:47:30 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4ghk-0000zD-S1; Wed, 08 May 2024 08:47:30 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2b5f3e20615so1273736a91.1; 
 Wed, 08 May 2024 05:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715172447; x=1715777247; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTj8cGqwAXrvO6+6k2tN3QXroviAQtMl3cAZQ85IbXc=;
 b=KS0bJbWXjLhB4K/BtOktCIpLHp9ouyv3Z6aqYeMbGS0JY6YzsTVF1Qt/XRpSdkYmLQ
 j7nVPhsyXf8DQ5Q05u8N+2Xxsay7GweaeBODJEZATAmJc3E5wx7U8rYOBKutGOuT7qmN
 NZICmowrBuiug0xr+ShWT/bGRyT2qSeoQ7TEQaEhH0likCaZ+9dtZkXnJqj2fBoHG7F/
 FZswZxGZYTrg30iTu87KDrYzGODyOEVFGglwrd2Vwoh1rnRKbSY6TRTVwZOtM45tvFNH
 2dAXJhOzkjZYmPLmdG+h37Wm0wd0ad4l7N8+gHhqVNOWO2b2XZYRw/O/gS3ZrHcbQ+7f
 7qXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715172447; x=1715777247;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lTj8cGqwAXrvO6+6k2tN3QXroviAQtMl3cAZQ85IbXc=;
 b=PR141hzd1K74DAts4+CIkjDCByss0bjlGhJd5gP8CFqszZ0yHZ3+YB4o98w/YtDj2F
 OfHyQgR/DtqNHTc4Pfz/v0a/X8n0m7lGcytb1KTBeKPV6q1tcQQJGq0yeZxMDEOcoADg
 RvozwzkEhpK0w+g+SijsaJSm86O9Whjj66HOZE2g9Q5M/yhBmaJHE5Gb00ufnXpVw75m
 nPS28zVSL1qRwg092cPNoFG3MhmJyvosZylUD2WcSE5Yxa2UOGH0cwO150gWs3p3XGIM
 E8q0y5Jub5NGfW2XRV8ioS7SvAp8oFK1Wf9TimwUWIgYTb6BaVFvTd5yLoeymgQRaYJb
 wlLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxTXEj5myUaAqv/7FB89snQmlF+SZNZFPOrCwABHeK35nprzGdi6Z4YuVTNMfrueYTd4rMYK7vqwEVVyJHyhFKa/61dUUnsPjp+7KLgQmdu731Z38dRdovB6Q=
X-Gm-Message-State: AOJu0YxIbCoT7kWd3VwNCz9WIKD2r54pwu0esZnUCSjHWMD94htE3e9X
 UIhaq3UCr7cm40lr9gEh1+fi7qGltjQHM7/qzchxqdrAYpLKjRf5
X-Google-Smtp-Source: AGHT+IGjilTQSxY1Pl9l4R4SfWAp7dEAxGNc4plEFsygr/wDMtflbrP0U9YetmKCqY0pvFn4OkrZsQ==
X-Received: by 2002:a17:90a:c381:b0:2ae:9a80:9065 with SMTP id
 98e67ed59e1d1-2b6166bfdf5mr2225237a91.28.1715172442105; 
 Wed, 08 May 2024 05:47:22 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 bx13-20020a17090af48d00b002b45057477bsm1341826pjb.9.2024.05.08.05.47.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 05:47:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 22:47:17 +1000
Message-Id: <D149VW0RT27T.25C8F3IK0K1KC@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 11/33] target/ppc/mmu_common.c: Move some debug logging
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <0a55610186f38c9dbbad8cc948af3986d945e796.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <0a55610186f38c9dbbad8cc948af3986d945e796.1715125376.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
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
> Move the debug logging within ppc6xx_tlb_check() from after its only
> call to simplify the caller.
>

I *think* the logic looks right.

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 55 +++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 29 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 9d337a73ba..b2f2cee1a8 100644
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
> @@ -251,14 +248,37 @@ static int ppc6xx_tlb_check(CPUPPCState *env, mmu_c=
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
> +#if defined(DUMP_PAGE_TABLES)
> +        if (qemu_loglevel_mask(CPU_LOG_MMU)) {
> +            CPUState *cs =3D env_cpu(env);
> +            PowerPCCPU *cpu =3D env_archcpu(env);

Do you need to de-indent this one level?

Otherwise,=20

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick

> +            hwaddr curaddr;
> +            uint32_t a0, a1, a2, a3;
> =20
> +            qemu_log("Page table: " HWADDR_FMT_plx " len " HWADDR_FMT_pl=
x "\n",
> +                     ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu) =
+ 0x80);
> +            for (curaddr =3D ppc_hash32_hpt_base(cpu);
> +                 curaddr < (ppc_hash32_hpt_base(cpu)
> +                            + ppc_hash32_hpt_mask(cpu) + 0x80);
> +                 curaddr +=3D 16) {
> +                a0 =3D ldl_phys(cs->as, curaddr);
> +                a1 =3D ldl_phys(cs->as, curaddr + 4);
> +                a2 =3D ldl_phys(cs->as, curaddr + 8);
> +                a3 =3D ldl_phys(cs->as, curaddr + 12);
> +                if (a0 !=3D 0 || a1 !=3D 0 || a2 !=3D 0 || a3 !=3D 0) {
> +                    qemu_log(HWADDR_FMT_plx ": %08x %08x %08x %08x\n",
> +                             curaddr, a0, a1, a2, a3);
> +                }
> +            }
> +        }
> +#endif
>      return ret;
>  }
> =20
> @@ -420,29 +440,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *=
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


