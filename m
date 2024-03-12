Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7594EC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1GO-0007PE-GX; Tue, 12 Mar 2024 08:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1GL-0007LH-CS; Tue, 12 Mar 2024 08:29:46 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1GI-0005co-00; Tue, 12 Mar 2024 08:29:43 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-29a74c88f74so3205681a91.3; 
 Tue, 12 Mar 2024 05:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710246580; x=1710851380; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=id9E+5h8n7/SevljJjbrDiTDK2zXjrI3ICMD1MUhdB0=;
 b=SN430pbK2FZzcjC5PxZGyJlMfAqnbMgZ1W2GGAmFqiOxoHsg42D5L8h7LVb6NQ1pBh
 2xy+L2EVJzN1AgKI2V1d5VlFrTgWmBwgqu3Qpn3ZEJ+xqDad/9j+HWsO3X8iSA7x0i4Q
 oAy0SpbUmJCDoLxMKbvAd5jHlnsDytP+TPX66Fzl/Lf9+Wnv0O3qnHqC4jCUDtR/ol5i
 8s4eiyaa2pPs80B/6/eGEmeKiSksN3HlgxdgLkjY3YR5maLrrvVQ2HZ1qiw8rQTj+YgQ
 nvJKfMaBTucGVokcQ1jkeiTgAmxnAdA7WkoGsJ/dAwHiRDn4iA08JM16VBK4wkiqVNts
 qPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710246580; x=1710851380;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=id9E+5h8n7/SevljJjbrDiTDK2zXjrI3ICMD1MUhdB0=;
 b=kr4puNPDyI6L7b3NlpqoKvql+jP6btj/jZKSxn/g05m5CKSjFUXNqZvfnoBeQIFa2w
 u94DVnmNkNU95CyJ8KuJqo7jjOyqkJcPpGRFBPiYBqWPS8H48NYFaluWwo7dcMrsZBG2
 02oND74wEyDSdwl+wI/xMhm5Mv4WJAGB/x1oHF2xsCsJ9sVTlgQx9dbk+MLUCD+ol+Ko
 +wIL4Jp9RlkVbFMs7AztsVpWXgNFk0bcAv1ZCRnDrs04/LSE+lcTG870Lkjkh5yTQ5Lf
 gkjObgwBmWsXsNDORaoR6RBL+iq9sl2zyVHSGfoGNq3FSg9KE7KdS5Do1h2AI46z1tAU
 GOQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbFrjOx2/8AteW3EcCVgRvJ67fHfzuCpE5zayo/PFvpYUjhJxsmcJMjGbS+yzAe7J+Y4e09OmReEXA5Rpt9sbFiMWg4popnKH2j57RULBudHZE6/z4B0IO5P4=
X-Gm-Message-State: AOJu0YzEWmN/Y+bX6a3LZhFY/SuZz9vy7+p8qfvbmz1X8xuzHGWyVpzk
 tZt0dGCT6UPMDojgNus3L12NBJeQCZDyPgm3xyeO8dDR4H608wTA
X-Google-Smtp-Source: AGHT+IHzZBghOMAI1nhmohNek6nwYyFLN+LW3ytWgWb0LpF3kZLYU9FE4TCfXV4pVOj+Eli9rITLcg==
X-Received: by 2002:a17:90a:bc06:b0:29b:c317:6b8c with SMTP id
 w6-20020a17090abc0600b0029bc3176b8cmr163695pjr.41.1710246580113; 
 Tue, 12 Mar 2024 05:29:40 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 k4-20020a17090a590400b0029ba8f43336sm7360112pji.20.2024.03.12.05.29.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 05:29:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 22:29:35 +1000
Message-Id: <CZRRTABQ6A99.2YHWZWN6PXQJC@wheely>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, <clg@kaod.org>
Subject: Re: [PATCH v7 04/10] target/ppc: Fix gen_sc to use correct nip
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <cover.1709045654.git.balaton@eik.bme.hu>
 <c382376352a67eda8e899e152ee88f677138a95f.1709045654.git.balaton@eik.bme.hu>
In-Reply-To: <c382376352a67eda8e899e152ee88f677138a95f.1709045654.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1032.google.com
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

On Wed Feb 28, 2024 at 1:08 AM AEST, BALATON Zoltan wrote:
> Most exceptions are raised with nip pointing to the faulting
> instruction but the sc instruction generating a syscall exception
> leaves nip pointing to next instruction. Fix gen_sc to not use
> gen_exception_err() which sets nip back but correctly set nip to
> pc_next so we don't have to patch this in the exception handlers.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/excp_helper.c | 43 ++--------------------------------------
>  target/ppc/translate.c   |  6 ++----
>  2 files changed, 4 insertions(+), 45 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index fba6e03d18..f1e62d9878 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -116,7 +116,7 @@ static void dump_syscall(CPUPPCState *env)
>                    ppc_dump_gpr(env, 0), ppc_dump_gpr(env, 3),
>                    ppc_dump_gpr(env, 4), ppc_dump_gpr(env, 5),
>                    ppc_dump_gpr(env, 6), ppc_dump_gpr(env, 7),
> -                  ppc_dump_gpr(env, 8), env->nip);
> +                  ppc_dump_gpr(env, 8), env->nip - 4);
>  }
> =20
>  static void dump_hcall(CPUPPCState *env)
> @@ -131,7 +131,7 @@ static void dump_hcall(CPUPPCState *env)
>                    ppc_dump_gpr(env, 7), ppc_dump_gpr(env, 8),
>                    ppc_dump_gpr(env, 9), ppc_dump_gpr(env, 10),
>                    ppc_dump_gpr(env, 11), ppc_dump_gpr(env, 12),
> -                  env->nip);
> +                  env->nip - 4);
>  }
> =20
>  #ifdef CONFIG_TCG
> @@ -516,12 +516,6 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int ex=
cp)
>          break;
>      case POWERPC_EXCP_SYSCALL:   /* System call exception               =
     */
>          dump_syscall(env);
> -
> -        /*
> -         * We need to correct the NIP which in this case is supposed
> -         * to point to the next instruction
> -         */
> -        env->nip +=3D 4;
>          break;
>      case POWERPC_EXCP_FIT:       /* Fixed-interval timer interrupt      =
     */
>          trace_ppc_excp_print("FIT");
> @@ -632,12 +626,6 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int ex=
cp)
>          break;
>      case POWERPC_EXCP_SYSCALL:   /* System call exception               =
     */
>          dump_syscall(env);
> -
> -        /*
> -         * We need to correct the NIP which in this case is supposed
> -         * to point to the next instruction
> -         */
> -        env->nip +=3D 4;
>          break;
>      case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception=
     */
>      case POWERPC_EXCP_DECR:      /* Decrementer exception               =
     */
> @@ -780,13 +768,6 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int ex=
cp)
>          } else {
>              dump_syscall(env);
>          }
> -
> -        /*
> -         * We need to correct the NIP which in this case is supposed
> -         * to point to the next instruction
> -         */
> -        env->nip +=3D 4;
> -
>          /*
>           * The Virtual Open Firmware (VOF) relies on the 'sc 1'
>           * instruction to communicate with QEMU. The pegasos2 machine
> @@ -932,13 +913,6 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int e=
xcp)
>          } else {
>              dump_syscall(env);
>          }
> -
> -        /*
> -         * We need to correct the NIP which in this case is supposed
> -         * to point to the next instruction
> -         */
> -        env->nip +=3D 4;
> -
>          /*
>           * The Virtual Open Firmware (VOF) relies on the 'sc 1'
>           * instruction to communicate with QEMU. The pegasos2 machine
> @@ -1098,12 +1072,6 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, in=
t excp)
>          break;
>      case POWERPC_EXCP_SYSCALL:   /* System call exception               =
     */
>          dump_syscall(env);
> -
> -        /*
> -         * We need to correct the NIP which in this case is supposed
> -         * to point to the next instruction
> -         */
> -        env->nip +=3D 4;
>          break;
>      case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception=
     */
>      case POWERPC_EXCP_APU:       /* Auxiliary processor unavailable     =
     */
> @@ -1427,13 +1395,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, in=
t excp)
>          } else {
>              dump_syscall(env);
>          }
> -
> -        /*
> -         * We need to correct the NIP which in this case is supposed
> -         * to point to the next instruction
> -         */
> -        env->nip +=3D 4;
> -
>          /* "PAPR mode" built-in hypercall emulation */
>          if (lev =3D=3D 1 && books_vhyp_handles_hcall(cpu)) {
>              PPCVirtualHypervisorClass *vhc =3D
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index d87aae0cc4..a3ac8c3d0e 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4575,15 +4575,13 @@ static void gen_hrfid(DisasContext *ctx)
>  #endif
>  static void gen_sc(DisasContext *ctx)
>  {
> -    uint32_t lev;
> -
>      /*
>       * LEV is a 7-bit field, but the top 6 bits are treated as a reserve=
d
>       * field (i.e., ignored). ISA v3.1 changes that to 5 bits, but that =
is
>       * for Ultravisor which TCG does not support, so just ignore the top=
 6.
>       */
> -    lev =3D (ctx->opcode >> 5) & 0x1;
> -    gen_exception_err(ctx, POWERPC_SYSCALL, lev);
> +    uint32_t lev =3D (ctx->opcode >> 5) & 0x1;
> +    gen_exception_err_nip(ctx, POWERPC_SYSCALL, lev, ctx->base.pc_next);
>  }
> =20
>  #if defined(TARGET_PPC64)


