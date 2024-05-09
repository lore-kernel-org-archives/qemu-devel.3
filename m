Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753F2C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 05:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4wfC-00010d-IV; Thu, 09 May 2024 01:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4weE-0000oV-DS; Thu, 09 May 2024 01:49:00 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4weB-0006sC-Bo; Thu, 09 May 2024 01:48:54 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2b239b5fedaso460870a91.0; 
 Wed, 08 May 2024 22:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715233729; x=1715838529; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bIqYnC2hNsmTmi49U4BXfvPLOMlJ/+3Lpt5K8KhzsaE=;
 b=hq28DmvjbDxVH09eZdhzukf3COsm4kxUX/dydJEozUxZeCbq+U6a67HuW5hlRy5gTf
 cyr22cYJ6CFzxwEU3NTvfq5uY926fPV5J2CJArmCNj7WfrldZ7+NNsWJadyApOnAuLi0
 9aaFHjNbn3l3s7UhcrCf1It03deVh5NJ0y1B5lPsy76MQBhNfIJDwoOs05BOXmsioG+1
 VYF8/y51gVhHsgG3kh9eH4ypvfWyn5CX9GCQ1A0cKZWmvAvnEwtMEH9QBqBU1DZEUHnN
 t+E4xNGoJTyKkCkHJTWCBWdqRTAJoHzy9BDa8R1UsypkIqahmu9AxyaPrJCM/geWmMQ+
 9hmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715233729; x=1715838529;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bIqYnC2hNsmTmi49U4BXfvPLOMlJ/+3Lpt5K8KhzsaE=;
 b=UdpEOp+2m5f4keCc8fsgmCB2bf7bwjlrPZPuCIE4k5nPkQRF3sUFymlzt1aNFHDkag
 w5LPLW8B1xIC2cshenUseWjAtUBFbQPC4MWcTCUtZiGBeJ41vGTf+ex5dyiFuLkvyPFQ
 J5d7GvxMIbLF6TXg7e1tB8yyUTuLcv38nJQCjbjXCKK5eAv05bk5Op2xux7mhncITlWh
 S65pWPLzL9XcpQD3FKDhB/W50junTs6Jt3E/gaKpoVW4f1titzZol/u5gH2YqFDHoaFY
 VeVaDVaqNj37iSyxCTjsjhuYNfqrfkCSyuLmexNBfPUuEnzJEL/PXybM71cnQ0ajiSBb
 8zZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXcwDeN71eCLdirPeCw1fa/zMgAsgr3HCTTQfGg+sfad+Mujgx2wSP4UQjkyGs8yUFt/a+8ZEzup159w0VSAzze86C
X-Gm-Message-State: AOJu0YxuVzqOZV5h07jb2z/U7niVO8n9iZ/hthUnu/5U8Ph6DJdwnGCR
 +lsNvqRKt4Sb9k2BUmggh9hImxJLLCl1Mysp47oCxa4NUciBPtMeumF+jg==
X-Google-Smtp-Source: AGHT+IF6cLmc6amcn8RFinoI1jQg/jXcSVsj0zhMdSsRYDvjSCRt0Hh8oZygB0vnp63cMKCNBmcNpg==
X-Received: by 2002:a17:90a:de02:b0:2b2:7c65:efa0 with SMTP id
 98e67ed59e1d1-2b6166c31admr4744427a91.26.1715233728661; 
 Wed, 08 May 2024 22:48:48 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b6711660acsm565961a91.15.2024.05.08.22.48.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 22:48:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 May 2024 15:48:43 +1000
Message-Id: <D14VLYS9ZKFK.2ZPODF3ERRZTD@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 01/33] target/ppc: Fix gen_sc to use correct nip
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <addcf637335b56956663aaa4234213da49e85a8b.1715125376.git.balaton@eik.bme.hu>
 <D14AXR65WIXZ.2H0R05J3AL0W4@gmail.com>
 <e6a92c1b-8ecf-80e5-6095-8aa5d828d82c@eik.bme.hu>
In-Reply-To: <e6a92c1b-8ecf-80e5-6095-8aa5d828d82c@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1033.google.com
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

On Thu May 9, 2024 at 1:17 AM AEST, BALATON Zoltan wrote:
> On Wed, 8 May 2024, Nicholas Piggin wrote:
> > On Wed May 8, 2024 at 10:14 AM AEST, BALATON Zoltan wrote:
> >> Most exceptions are raised with nip pointing to the faulting
> >> instruction but the sc instruction generating a syscall exception
> >> leaves nip pointing to next instruction. Fix gen_sc to not use
> >> gen_exception_err() which sets nip back but correctly set nip to
> >> pc_next so we don't have to patch this in the exception handlers.
> >>
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> ---
> >>  target/ppc/excp_helper.c | 43 ++-------------------------------------=
-
> >>  target/ppc/translate.c   | 15 ++++++--------
> >>  2 files changed, 8 insertions(+), 50 deletions(-)
> >>
> >> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> >> index 0712098cf7..92fe535815 100644
> >> --- a/target/ppc/excp_helper.c
> >> +++ b/target/ppc/excp_helper.c
> >> @@ -116,7 +116,7 @@ static void dump_syscall(CPUPPCState *env)
> >>                    ppc_dump_gpr(env, 0), ppc_dump_gpr(env, 3),
> >>                    ppc_dump_gpr(env, 4), ppc_dump_gpr(env, 5),
> >>                    ppc_dump_gpr(env, 6), ppc_dump_gpr(env, 7),
> >> -                  ppc_dump_gpr(env, 8), env->nip);
> >> +                  ppc_dump_gpr(env, 8), env->nip - 4);
> >>  }
> >>
> >>  static void dump_hcall(CPUPPCState *env)
> >> @@ -131,7 +131,7 @@ static void dump_hcall(CPUPPCState *env)
> >>                    ppc_dump_gpr(env, 7), ppc_dump_gpr(env, 8),
> >>                    ppc_dump_gpr(env, 9), ppc_dump_gpr(env, 10),
> >>                    ppc_dump_gpr(env, 11), ppc_dump_gpr(env, 12),
> >> -                  env->nip);
> >> +                  env->nip - 4);
> >>  }
> >>
> >>  #ifdef CONFIG_TCG
> >> @@ -516,12 +516,6 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int=
 excp)
> >>          break;
> >>      case POWERPC_EXCP_SYSCALL:   /* System call exception            =
        */
> >>          dump_syscall(env);
> >> -
> >> -        /*
> >> -         * We need to correct the NIP which in this case is supposed
> >> -         * to point to the next instruction
> >> -         */
> >> -        env->nip +=3D 4;
> >>          break;
> >>      case POWERPC_EXCP_FIT:       /* Fixed-interval timer interrupt   =
        */
> >>          trace_ppc_excp_print("FIT");
> >> @@ -632,12 +626,6 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int=
 excp)
> >>          break;
> >>      case POWERPC_EXCP_SYSCALL:   /* System call exception            =
        */
> >>          dump_syscall(env);
> >> -
> >> -        /*
> >> -         * We need to correct the NIP which in this case is supposed
> >> -         * to point to the next instruction
> >> -         */
> >> -        env->nip +=3D 4;
> >>          break;
> >>      case POWERPC_EXCP_FPU:       /* Floating-point unavailable except=
ion     */
> >>      case POWERPC_EXCP_DECR:      /* Decrementer exception            =
        */
> >> @@ -780,13 +768,6 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int=
 excp)
> >>          } else {
> >>              dump_syscall(env);
> >>          }
> >> -
> >> -        /*
> >> -         * We need to correct the NIP which in this case is supposed
> >> -         * to point to the next instruction
> >> -         */
> >> -        env->nip +=3D 4;
> >> -
> >>          /*
> >>           * The Virtual Open Firmware (VOF) relies on the 'sc 1'
> >>           * instruction to communicate with QEMU. The pegasos2 machine
> >> @@ -932,13 +913,6 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, in=
t excp)
> >>          } else {
> >>              dump_syscall(env);
> >>          }
> >> -
> >> -        /*
> >> -         * We need to correct the NIP which in this case is supposed
> >> -         * to point to the next instruction
> >> -         */
> >> -        env->nip +=3D 4;
> >> -
> >>          /*
> >>           * The Virtual Open Firmware (VOF) relies on the 'sc 1'
> >>           * instruction to communicate with QEMU. The pegasos2 machine
> >> @@ -1098,12 +1072,6 @@ static void powerpc_excp_booke(PowerPCCPU *cpu,=
 int excp)
> >>          break;
> >>      case POWERPC_EXCP_SYSCALL:   /* System call exception            =
        */
> >>          dump_syscall(env);
> >> -
> >> -        /*
> >> -         * We need to correct the NIP which in this case is supposed
> >> -         * to point to the next instruction
> >> -         */
> >> -        env->nip +=3D 4;
> >>          break;
> >>      case POWERPC_EXCP_FPU:       /* Floating-point unavailable except=
ion     */
> >>      case POWERPC_EXCP_APU:       /* Auxiliary processor unavailable  =
        */
> >> @@ -1428,13 +1396,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu,=
 int excp)
> >>          } else {
> >>              dump_syscall(env);
> >>          }
> >> -
> >> -        /*
> >> -         * We need to correct the NIP which in this case is supposed
> >> -         * to point to the next instruction
> >> -         */
> >> -        env->nip +=3D 4;
> >> -
> >>          /* "PAPR mode" built-in hypercall emulation */
> >>          if (lev =3D=3D 1 && books_vhyp_handles_hcall(cpu)) {
> >>              PPCVirtualHypervisorClass *vhc =3D
> >> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> >> index 93ffec787c..e112c44a02 100644
> >> --- a/target/ppc/translate.c
> >> +++ b/target/ppc/translate.c
> >> @@ -4472,22 +4472,19 @@ static void gen_hrfid(DisasContext *ctx)
> >>  #endif
> >>
> >>  /* sc */
> >> -#if defined(CONFIG_USER_ONLY)
> >> -#define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL_USER
> >> -#else
> >> -#define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL
> >> -#endif
> >>  static void gen_sc(DisasContext *ctx)
> >>  {
> >> -    uint32_t lev;
> >> -
> >>      /*
> >>       * LEV is a 7-bit field, but the top 6 bits are treated as a rese=
rved
> >>       * field (i.e., ignored). ISA v3.1 changes that to 5 bits, but th=
at is
> >>       * for Ultravisor which TCG does not support, so just ignore the =
top 6.
> >>       */
> >> -    lev =3D (ctx->opcode >> 5) & 0x1;
> >> -    gen_exception_err(ctx, POWERPC_SYSCALL, lev);
> >> +    uint32_t lev =3D (ctx->opcode >> 5) & 0x1;
> >> +#ifdef CONFIG_USER_ONLY
> >> +    gen_exception_err(ctx, POWERPC_EXCP_SYSCALL_USER, lev);
> >> +#else
> >> +    gen_exception_err_nip(ctx, POWERPC_EXCP_SYSCALL, lev, ctx->base.p=
c_next);
> >> +#endif
> >
> > I think this is the nail in the coffin for this one. Let's shelve it.
>
> I really would like to get rid of all the +4s and long comments in=20
> excp_helper.c though so I won't let this go until we find a solution. I'v=
e=20

All the +=3D 4 are just because the handlers are repeated so many times.
And with this you have to add the - 4 for other cases.

And you removed the comment but you didn't add one here. Comments aren't
really a problem.

> now found that linux-user/ppc/cpu_loop.c handles this case and that also=
=20
> has a +4 that I've missed before so with that removed this should work.=
=20
> I'll try again.

The invariant that nip always refers to the instruction that caused the
exception for synchronous exceptions is a good one, and the patch has
caused a bunch of problems, so I don't want to merge it.

Thanks,
Nick

