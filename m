Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D60FC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4hTa-0008Kz-KW; Wed, 08 May 2024 09:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4hTZ-0008KY-Gj; Wed, 08 May 2024 09:36:53 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4hTX-0000Ku-FH; Wed, 08 May 2024 09:36:53 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ed96772f92so31845565ad.0; 
 Wed, 08 May 2024 06:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715175409; x=1715780209; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mN1OaPgu5A1k5aP4qvWANtAd4yY3JPFHaD4HHQl12Co=;
 b=YhCzb5KbZhqDq7PlX1+UVOeSx58H/Vq0XikCbAB5YwU6MsZrLmIduIavkKt/ucMUZY
 ZfO1ir3NQZ9uqGdLiqgdzgFpQ9iXWrsx3WpRpiN8SUa3yzVYDwBtiFFLDR14pSOREHpF
 Bnuszy6EVZi3uQZunT6LzX0DtbISI1jbPd2hmBpJzQ61RLjXjz7ae9w72PRQooBrTJFA
 1Mdh5V2CZDg0UipP273DDSOU7TrYCa8rGCsnHYUiQnUGbgni3GzBgE4gExXHWrOYqLyj
 2Asv2SB2vWCYvAhkk1vGaXypshqK48JapMYY2z2G5wAujOshnMEqlUdw7XX6MPNPziGS
 cEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715175409; x=1715780209;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mN1OaPgu5A1k5aP4qvWANtAd4yY3JPFHaD4HHQl12Co=;
 b=DtydUM1taWW+G2DrzuIchoPqkoP0e93H11axIBVAeZqM6VyCaYTOT87xH7uSTNkejz
 ITZzBfOjxASxq9/4pBzYhdDu3fz4iEyK9AOya3b5XxI9jSdQhMYgjMxtqn3osRUmLggn
 V/iQ/C2GHDLeKiB0W3b3TjwkyMQ9hyx+LWChrQ/47luPjlJXGYzMEpdXY2GtYGBSxTyW
 bz9e51ZKWuC7s+y9NTaxnjZ5SOI9JY/UXCAfhlFlSo8WyALEHOnsvYcxXtJp6DeGmHdo
 0jBPuTP/akVbBzFKY7wyHSx+RBx8wH6mgmNDy78AKwpqjd5Q6eCjMMPORkB0Q2iHUiy6
 1KEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpKAOLqLsbe93KYWNvjiGtWYl9LYaxa/zmQxN15nkqNVwcSk3Y11pGjJdMjHQ794tbiisawgsJuX8kH4UwnhskV8TbCHSgnnpJBfbLekdabgCI6+rtj2n1Cgw=
X-Gm-Message-State: AOJu0YwIHSYiu8Bw2AF959IfWM2MmOVt214KB5fyIq7+dqIla3gQhO6Z
 dVycmoAYYm8TkufVuo+E4ReglIpKffA1BHKGmbPL1U2SeoOo/0uU
X-Google-Smtp-Source: AGHT+IG/awJObtLwLlI3t47zfxIkUiPw/DyL9ejkezW85BYllgzB7f7sBbaeBMRf7dmmTCuo3Sg5wQ==
X-Received: by 2002:a17:903:2292:b0:1e9:4f9:8478 with SMTP id
 d9443c01a7336-1eeb05a1705mr32311745ad.42.1715175409317; 
 Wed, 08 May 2024 06:36:49 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 j12-20020a170903024c00b001e43576a7a1sm11777313plh.222.2024.05.08.06.36.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 06:36:49 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 23:36:44 +1000
Message-Id: <D14AXR65WIXZ.2H0R05J3AL0W4@gmail.com>
Subject: Re: [PATCH v3 01/33] target/ppc: Fix gen_sc to use correct nip
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <addcf637335b56956663aaa4234213da49e85a8b.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <addcf637335b56956663aaa4234213da49e85a8b.1715125376.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

On Wed May 8, 2024 at 10:14 AM AEST, BALATON Zoltan wrote:
> Most exceptions are raised with nip pointing to the faulting
> instruction but the sc instruction generating a syscall exception
> leaves nip pointing to next instruction. Fix gen_sc to not use
> gen_exception_err() which sets nip back but correctly set nip to
> pc_next so we don't have to patch this in the exception handlers.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/excp_helper.c | 43 ++--------------------------------------
>  target/ppc/translate.c   | 15 ++++++--------
>  2 files changed, 8 insertions(+), 50 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 0712098cf7..92fe535815 100644
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
> @@ -1428,13 +1396,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, in=
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
> index 93ffec787c..e112c44a02 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4472,22 +4472,19 @@ static void gen_hrfid(DisasContext *ctx)
>  #endif
> =20
>  /* sc */
> -#if defined(CONFIG_USER_ONLY)
> -#define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL_USER
> -#else
> -#define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL
> -#endif
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
> +#ifdef CONFIG_USER_ONLY
> +    gen_exception_err(ctx, POWERPC_EXCP_SYSCALL_USER, lev);
> +#else
> +    gen_exception_err_nip(ctx, POWERPC_EXCP_SYSCALL, lev, ctx->base.pc_n=
ext);
> +#endif

I think this is the nail in the coffin for this one. Let's shelve it.

Thanks,
Nick

