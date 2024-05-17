Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238E6C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 06:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7qdL-0000pJ-K5; Fri, 17 May 2024 01:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7qdJ-0000p4-QV; Fri, 17 May 2024 01:59:57 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7qdH-0000FI-Mk; Fri, 17 May 2024 01:59:57 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-64e93d9b14bso787770a12.1; 
 Thu, 16 May 2024 22:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715925592; x=1716530392; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4I6BOmBr22BWtSUelwYgXV1xnD05GG60OzJVNh/r3OI=;
 b=k9X6W+vibRpEMOKSz4qwELZTuZlVGvBv5I2PYjxHPOzyxKskuHsJDVIeTI7+cVqWZc
 EhTXCzkC8ppeGLMPkcX5Ui0G0cDXkMxIX1KZQbbs+kbCaRh/esTgNQsMWUaAJLHnxOMa
 u+LyoSBHHjyw7TcGf4IYKPbSTvWfFrVUWBXOM8ImNsuxQ3zv8IhTO5xu1Vhfe6z7ns+j
 Vq2oMf/eaUCzmPPQKJkTmZYaarh9983o8l9TgX8ReT4SuYQ6yBXnui3kn1W5jb51Abgf
 bttTMMcI5v6ZAWIAaaXuR/jJgBercWHBUWfDEYbeIeezxzkkZVeKM6fgc6suQpWQQ+Zt
 Ps5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715925592; x=1716530392;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4I6BOmBr22BWtSUelwYgXV1xnD05GG60OzJVNh/r3OI=;
 b=hdx7QjfH5UXd8siVkoKyRhaZeEa1y9Wp+R9t9PFCra2dYQXh0BUG4gDH5ZH9afwzNx
 Sj9qKJUPvyfVo/T4KBnYUTDuMsITZ6A/8cv3WmjO17bLRvSexJctHlfnWTC+2U73F5R+
 RckOVNHNqxZoZUx3PnsZhxE86y50u5IMMUnm0dxMAuWxbdRrbmDJyiUzHu7XBbFPrRrT
 T+G5XjJdWVF2fPRJFVqEHRdiWwyO01oua0xKEI/mvMrgTGBt+JG2ddI6ZPcmhIk8ydNa
 lm9oHq/xVZ0WHcqgfWCIYPdA3Mbo/G2B1j2Tg444uXyzgN3jtrBT4ahhL0TQTpzhpV4T
 wa8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCKqHYkA0X4bCCKHgsdmZ1jTobHasQDiTJUDu5UI+9x6ZL/Qz8CcpfAlWBMvNDlYzcYkI9Ty9qC4HEwRpiuCwbMiSzeE2y2sJNct4Qj8ScO1yjVczRFdFLUko=
X-Gm-Message-State: AOJu0Yz8efY0W/ju6BRFBuvR55CHpdnDqB6m8vD6Q8g6K1AkoSsmOeIp
 ZrQ9A8qGdX2qcydMUqOb1ElDF0Ydrlg4XbEzkwCnofkU6HiSGgCa
X-Google-Smtp-Source: AGHT+IFL2yDxy25aAqm39ylcV62uLwFqvIXGntO6hruMbjQTxYTkmRGHTu0XIAjIPr9hiouN+JERWA==
X-Received: by 2002:a05:6a20:7348:b0:1af:baf9:feee with SMTP id
 adf61e73a8af0-1afde0fba34mr22658700637.26.1715925592341; 
 Thu, 16 May 2024 22:59:52 -0700 (PDT)
Received: from localhost ([1.146.118.37]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b6d0b8c887sm13088991a91.21.2024.05.16.22.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 22:59:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 May 2024 15:59:47 +1000
Message-Id: <D1BOUSCZ6HDM.1LJMQOGHA5GAZ@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v7 33/61] target/ppc: Add a function to check for page
 protection bit
X-Mailer: aerc 0.17.0
References: <cover.1715555763.git.balaton@eik.bme.hu>
 <bdcece8f03687b37610cc7459e1cd9f0c594650e.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <bdcece8f03687b37610cc7459e1cd9f0c594650e.1715555763.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x533.google.com
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

On Mon May 13, 2024 at 9:28 AM AEST, BALATON Zoltan wrote:
> Checking if a page protection bit is set for a given access type is a
> common operation. Add a function to avoid repeating the same check at
> multiple places. As this relies on access type and page protection bit
> values having certain relation also add an assert to ensure that this
> assumption holds.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/cpu_init.c    |  5 +++++
>  target/ppc/internal.h    | 23 +++++------------------
>  target/ppc/mmu-hash32.c  |  6 +++---
>  target/ppc/mmu-hash64.c  |  2 +-
>  target/ppc/mmu-radix64.c |  2 +-
>  target/ppc/mmu_common.c  | 26 +++++++++++++-------------
>  6 files changed, 28 insertions(+), 36 deletions(-)
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 92c71b2a09..d3b92d9f0e 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7388,6 +7388,11 @@ static void ppc_cpu_class_init(ObjectClass *oc, vo=
id *data)
>  #ifndef CONFIG_USER_ONLY
>      cc->sysemu_ops =3D &ppc_sysemu_ops;
>      INTERRUPT_STATS_PROVIDER_CLASS(oc)->get_statistics =3D ppc_get_irq_s=
tats;
> +
> +    /* check_prot_access_type relies on MMU access and PAGE bits relatio=
ns */
> +    qemu_build_assert(MMU_DATA_LOAD =3D=3D 0 && MMU_DATA_STORE =3D=3D 1 =
&&
> +                      MMU_INST_FETCH =3D=3D 2 && PAGE_READ =3D=3D 1 &&
> +                      PAGE_WRITE =3D=3D 2 && PAGE_EXEC =3D=3D 4);
>  #endif
> =20
>      cc->gdb_num_core_regs =3D 71;
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 4a90dd2584..20fb2ec593 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -234,27 +234,14 @@ void destroy_ppc_opcodes(PowerPCCPU *cpu);
>  void ppc_gdb_init(CPUState *cs, PowerPCCPUClass *ppc);
>  const gchar *ppc_gdb_arch_name(CPUState *cs);
> =20
> -/**
> - * prot_for_access_type:
> - * @access_type: Access type
> - *
> - * Return the protection bit required for the given access type.
> - */
> -static inline int prot_for_access_type(MMUAccessType access_type)
> +#ifndef CONFIG_USER_ONLY
> +
> +/* Check if permission bit required for the access_type is set in prot *=
/
> +static inline int check_prot_access_type(int prot, MMUAccessType access_=
type)
>  {
> -    switch (access_type) {
> -    case MMU_INST_FETCH:
> -        return PAGE_EXEC;
> -    case MMU_DATA_LOAD:
> -        return PAGE_READ;
> -    case MMU_DATA_STORE:
> -        return PAGE_WRITE;
> -    }
> -    g_assert_not_reached();
> +    return prot & (1 << access_type);

I checked and sadly gcc is not able to figure this out on its own yet,
so we'll go with it. Nice improvement.

Reivewed-by: Nicholas Piggin <npiggin@gmail.com>

>  }
> =20
> -#ifndef CONFIG_USER_ONLY
> -
>  /* PowerPC MMU emulation */
> =20
>  bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 3abaf16e78..1e8f1df0f0 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -252,7 +252,7 @@ static bool ppc_hash32_direct_store(PowerPCCPU *cpu, =
target_ulong sr,
>      }
> =20
>      *prot =3D key ? PAGE_READ | PAGE_WRITE : PAGE_READ;
> -    if (*prot & prot_for_access_type(access_type)) {
> +    if (check_prot_access_type(*prot, access_type)) {
>          *raddr =3D eaddr;
>          return true;
>      }
> @@ -403,7 +403,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, M=
MUAccessType access_type,
>      if (env->nb_BATs !=3D 0) {
>          raddr =3D ppc_hash32_bat_lookup(cpu, eaddr, access_type, protp, =
mmu_idx);
>          if (raddr !=3D -1) {
> -            if (prot_for_access_type(access_type) & ~*protp) {
> +            if (!check_prot_access_type(*protp, access_type)) {
>                  if (guest_visible) {
>                      if (access_type =3D=3D MMU_INST_FETCH) {
>                          cs->exception_index =3D POWERPC_EXCP_ISI;
> @@ -471,7 +471,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, M=
MUAccessType access_type,
> =20
>      prot =3D ppc_hash32_pte_prot(mmu_idx, sr, pte);
> =20
> -    if (prot_for_access_type(access_type) & ~prot) {
> +    if (!check_prot_access_type(prot, access_type)) {
>          /* Access right violation */
>          qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
>          if (guest_visible) {
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 0966422a55..d9626f6aab 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1097,7 +1097,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr,=
 MMUAccessType access_type,
>      amr_prot =3D ppc_hash64_amr_prot(cpu, pte);
>      prot =3D exec_prot & pp_prot & amr_prot;
> =20
> -    need_prot =3D prot_for_access_type(access_type);
> +    need_prot =3D check_prot_access_type(PAGE_RWX, access_type);
>      if (need_prot & ~prot) {
>          /* Access right violation */
>          qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index 395ce3b782..2c5ade5cea 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -209,7 +209,7 @@ static bool ppc_radix64_check_prot(PowerPCCPU *cpu, M=
MUAccessType access_type,
>      }
> =20
>      /* Check if requested access type is allowed */
> -    if (prot_for_access_type(access_type) & ~*prot) {
> +    if (!check_prot_access_type(*prot, access_type)) {
>          /* Page Protected for that Access */
>          *fault_cause |=3D access_type =3D=3D MMU_INST_FETCH ? SRR1_NOEXE=
C_GUARD :
>                                                          DSISR_PROTFAULT;
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 69f98b7d0e..6746a8ff6b 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -114,11 +114,6 @@ static int pp_check(int key, int pp, int nx)
>      return access;
>  }
> =20
> -static int check_prot(int prot, MMUAccessType access_type)
> -{
> -    return prot & prot_for_access_type(access_type) ? 0 : -2;
> -}
> -
>  int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
>                                      int way, int is_code)
>  {
> @@ -165,13 +160,14 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, tar=
get_ulong pte0,
>              /* Keep the matching PTE information */
>              ctx->raddr =3D pte1;
>              ctx->prot =3D access;
> -            ret =3D check_prot(ctx->prot, access_type);
> -            if (ret =3D=3D 0) {
> +            if (check_prot_access_type(ctx->prot, access_type)) {
>                  /* Access granted */
>                  qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
> +                ret =3D 0;
>              } else {
>                  /* Access right violation */
>                  qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
> +                ret =3D -2;
>              }
>          }
>      }
> @@ -339,12 +335,14 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ct=
x_t *ctx,
>                      (virtual & 0x0001F000);
>                  /* Compute access rights */
>                  ctx->prot =3D prot;
> -                ret =3D check_prot(ctx->prot, access_type);
> -                if (ret =3D=3D 0) {
> +                if (check_prot_access_type(ctx->prot, access_type)) {
>                      qemu_log_mask(CPU_LOG_MMU, "BAT %d match: r " HWADDR=
_FMT_plx
>                                    " prot=3D%c%c\n", i, ctx->raddr,
>                                    ctx->prot & PAGE_READ ? 'R' : '-',
>                                    ctx->prot & PAGE_WRITE ? 'W' : '-');
> +                    ret =3D 0;
> +                } else {
> +                    ret =3D -2;
>                  }
>                  break;
>              }
> @@ -561,9 +559,11 @@ static int mmu40x_get_physical_address(CPUPPCState *=
env, hwaddr *raddr,
>  check_perms:
>              /* Check from TLB entry */
>              *prot =3D tlb->prot;
> -            ret =3D check_prot(*prot, access_type);
> -            if (ret =3D=3D -2) {
> +            if (check_prot_access_type(*prot, access_type)) {
> +                ret =3D 0;
> +            } else {
>                  env->spr[SPR_40x_ESR] =3D 0;
> +                ret =3D -2;
>              }
>              break;
>          }
> @@ -621,7 +621,7 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcem=
b_tlb_t *tlb,
>      } else {
>          *prot =3D (tlb->prot >> 4) & 0xF;
>      }
> -    if (*prot & prot_for_access_type(access_type)) {
> +    if (check_prot_access_type(*prot, access_type)) {
>          qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
>          return 0;
>      }
> @@ -823,7 +823,7 @@ found_tlb:
>              *prot |=3D PAGE_EXEC;
>          }
>      }
> -    if (*prot & prot_for_access_type(access_type)) {
> +    if (check_prot_access_type(*prot, access_type)) {
>          qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
>          return 0;
>      }


