Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6999DC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4hMv-0004cD-KB; Wed, 08 May 2024 09:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4hMu-0004by-6Q; Wed, 08 May 2024 09:30:00 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4hMq-0006Qu-Qn; Wed, 08 May 2024 09:29:59 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-602801ea164so3014962a12.0; 
 Wed, 08 May 2024 06:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715174995; x=1715779795; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbAyXkIVdtSEvm+H3hNMYgiuAiF0Xxdah3XNLdkUJGg=;
 b=AusF0CPK+/TWO7tSdOsjAe3knEPd4DYXNLaUQYEG/koZw0S73HJxadgri/43e1+xTo
 DpFEvrcpX9wY4X/I8yXg4GtxiU0tckNACP0Ndj2qicEV/5jsAYfSMmE58Uu23mj6BIZ6
 fmW0ZeXHD5iznHDD4SV8q2nyEF2finQejJJ/3YkuJe2GfIyuIczSAMWdmZmSUlZYBoqB
 ZlTi2qq37MEcMBQSKWKCAjKq4hoopBmQIf5mriwOn5tk5oeimAcwolJr1nlQuar1/e3z
 SCYNA1AWnOZoLMGR3LUDMyGKCuySgN0IBKKkt9PYWBOxZ+/YL0IMt3gJ71yngL5GcaPE
 Onkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715174995; x=1715779795;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bbAyXkIVdtSEvm+H3hNMYgiuAiF0Xxdah3XNLdkUJGg=;
 b=okfTtGdteb3lHzvHiJJY6TTb84yphbY7cxR61Y4wQNvDc1/ALKMPe30Ax8y0g6Xs2F
 FiqhpyKS/39LLDozggcbjzbUqNw0jEJ78S6nL3YidjTkrNUZLhtAOUwiRU12bHJTnyir
 /hfLp70Vu1IL7h1aVrHFGkdJcO9RT7H8RLUecm8vFxw9bq9o2wtscTRFDKQJ2JuTzvST
 HFhpWInUSkgVQPnWxWBRjdb4KEPc2sUT24JwKU/uvTjk8bIX3igb1UqLcyIAjVUbqqxE
 FUXTNKAIT5jnypAXzCE/o/VEQab0M8WPPrb6cygOSVnHlJAIUkOtQEqpPID85K0/Wgog
 CQMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE/FIKgqqI2wdfPoQtv/aVhbGsJnil7rz49ljlAHGA7zt8TIYf0kof4nQDRqJo+dnXX961UQVOEHQFWNdVEn2iDyeBly2cPZ/sGhuqI21V1N8TB8NNrxF5udg=
X-Gm-Message-State: AOJu0YypDj8Cn5JBRVpxHLAzQLiSY94wn1Pve3gEDw/gH8n/9LyRrjN6
 HL98KDRm9TG+M3Z3DVgKYD2fGu+gs6E7Kes9NScM4mOd/0jZeHK7
X-Google-Smtp-Source: AGHT+IFwQZwwYGOOa0QFIaZHhzaKbwLs4NbcS3JOVIdefkt1H+kXOzjXrOFFmcyFKu0fmgVg1dcXxQ==
X-Received: by 2002:a17:90b:704:b0:2b6:227a:50bd with SMTP id
 98e67ed59e1d1-2b6227a5196mr1686269a91.46.1715174994819; 
 Wed, 08 May 2024 06:29:54 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 l5-20020a17090aec0500b002b328adaa40sm1411705pjy.17.2024.05.08.06.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 06:29:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 23:29:49 +1000
Message-Id: <D14ASGGTNSQB.3TX66EXAL001R@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 33/33] target/ppc: Add a macro to check for page
 protection bit
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <a91a1b9455f88cbbeff2652fc4f44acd89e98215.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <a91a1b9455f88cbbeff2652fc4f44acd89e98215.1715125376.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52e.google.com
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
> Checking if a page protection bit is set for a given access type is a
> common operation. Add a macro to avoid repeating the same check at
> multiple places and also avoid a function call. As this relies on
> access type and page protection bit values having certain relation
> also add an assert to ensure that this assumption holds.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/cpu_init.c    |  4 ++++
>  target/ppc/internal.h    | 20 ++------------------
>  target/ppc/mmu-hash32.c  |  6 +++---
>  target/ppc/mmu-hash64.c  |  2 +-
>  target/ppc/mmu-radix64.c |  2 +-
>  target/ppc/mmu_common.c  | 26 +++++++++++++-------------
>  6 files changed, 24 insertions(+), 36 deletions(-)
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 92c71b2a09..6639235544 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7377,6 +7377,10 @@ static void ppc_cpu_class_init(ObjectClass *oc, vo=
id *data)
>      resettable_class_set_parent_phases(rc, NULL, ppc_cpu_reset_hold, NUL=
L,
>                                         &pcc->parent_phases);
> =20
> +    /* CHECK_PROT_ACCESS relies on this MMU access and PAGE bits relatio=
n */
> +    assert(MMU_DATA_LOAD =3D=3D 0 && MMU_DATA_STORE =3D=3D 1 && MMU_INST=
_FETCH =3D=3D 2 &&
> +           PAGE_READ =3D=3D 1 && PAGE_WRITE =3D=3D 2 && PAGE_EXEC =3D=3D=
 4);
> +

Can you use qemu_build_assert() for this?

>      cc->class_by_name =3D ppc_cpu_class_by_name;
>      cc->has_work =3D ppc_cpu_has_work;
>      cc->mmu_index =3D ppc_cpu_mmu_index;
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 46176c4711..9880422ce3 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -234,24 +234,8 @@ void destroy_ppc_opcodes(PowerPCCPU *cpu);
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
> -{
> -    switch (access_type) {
> -    case MMU_INST_FETCH:
> -        return PAGE_EXEC;
> -    case MMU_DATA_LOAD:
> -        return PAGE_READ;
> -    case MMU_DATA_STORE:
> -        return PAGE_WRITE;
> -    }
> -    g_assert_not_reached();
> -}
> +/* Check if permission bit required for the access_type is set in prot *=
/
> +#define CHECK_PROT_ACCESS(prot, access_type) ((prot) & (1 << (access_typ=
e)))

We don't want to use a macro when an inline function will work.

Does the compiler not see the pattern and transform the existing
code into a shift? If it does then I would leave it. If not, then
just keep prot_for_access_type but make it a shift and maybe
comment the logic.

I would call the new function check_prot_for_access_type().

> =20
>  #ifndef CONFIG_USER_ONLY
> =20
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index b5d7aeed4e..fa4a4ced6d 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -213,7 +213,7 @@ static bool ppc_hash32_direct_store(PowerPCCPU *cpu, =
target_ulong sr,
>      }
> =20
>      *prot =3D key ? PAGE_READ | PAGE_WRITE : PAGE_READ;
> -    if (*prot & prot_for_access_type(access_type)) {
> +    if (CHECK_PROT_ACCESS(*prot, access_type)) {
>          *raddr =3D eaddr;
>          return true;
>      }

This does read better, and better than the check_prot() below
that it replaces too, so I like the cleanup.

Thanks,
Nick

> @@ -364,7 +364,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, M=
MUAccessType access_type,
>      if (env->nb_BATs !=3D 0) {
>          raddr =3D ppc_hash32_bat_lookup(cpu, eaddr, access_type, protp, =
mmu_idx);
>          if (raddr !=3D -1) {
> -            if (prot_for_access_type(access_type) & ~*protp) {
> +            if (!CHECK_PROT_ACCESS(*protp, access_type)) {
>                  if (guest_visible) {
>                      if (access_type =3D=3D MMU_INST_FETCH) {
>                          cs->exception_index =3D POWERPC_EXCP_ISI;
> @@ -432,7 +432,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, M=
MUAccessType access_type,
> =20
>      prot =3D ppc_hash32_pte_prot(mmu_idx, sr, pte);
> =20
> -    if (prot_for_access_type(access_type) & ~prot) {
> +    if (!CHECK_PROT_ACCESS(prot, access_type)) {
>          /* Access right violation */
>          qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
>          if (guest_visible) {
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 5a0d80feda..14c2116ae7 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1097,7 +1097,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr,=
 MMUAccessType access_type,
>      amr_prot =3D ppc_hash64_amr_prot(cpu, pte);
>      prot =3D exec_prot & pp_prot & amr_prot;
> =20
> -    need_prot =3D prot_for_access_type(access_type);
> +    need_prot =3D CHECK_PROT_ACCESS(PAGE_RWX, access_type);
>      if (need_prot & ~prot) {
>          /* Access right violation */
>          qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index 395ce3b782..a72cd927c4 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -209,7 +209,7 @@ static bool ppc_radix64_check_prot(PowerPCCPU *cpu, M=
MUAccessType access_type,
>      }
> =20
>      /* Check if requested access type is allowed */
> -    if (prot_for_access_type(access_type) & ~*prot) {
> +    if (!CHECK_PROT_ACCESS(*prot, access_type)) {
>          /* Page Protected for that Access */
>          *fault_cause |=3D access_type =3D=3D MMU_INST_FETCH ? SRR1_NOEXE=
C_GUARD :
>                                                          DSISR_PROTFAULT;
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index eff015066d..24d68926b4 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -76,11 +76,6 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong val=
ue)
>  /***********************************************************************=
******/
>  /* PowerPC MMU emulation */
> =20
> -static int check_prot(int prot, MMUAccessType access_type)
> -{
> -    return prot & prot_for_access_type(access_type) ? 0 : -2;
> -}
> -
>  int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
>                                      int way, int is_code)
>  {
> @@ -125,13 +120,14 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, tar=
get_ulong pte0,
>              /* Keep the matching PTE information */
>              ctx->raddr =3D pte1;
>              ctx->prot =3D ppc_hash32_pp_prot(ctx->key, pp, ctx->nx);
> -            ret =3D check_prot(ctx->prot, access_type);
> -            if (ret =3D=3D 0) {
> +            if (CHECK_PROT_ACCESS(ctx->prot, access_type)) {
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
> @@ -317,12 +313,14 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ct=
x_t *ctx,
>                      (virtual & 0x0001F000);
>                  /* Compute access rights */
>                  ctx->prot =3D prot;
> -                ret =3D check_prot(ctx->prot, access_type);
> -                if (ret =3D=3D 0) {
> +                if (CHECK_PROT_ACCESS(ctx->prot, access_type)) {
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
> @@ -540,9 +538,11 @@ static int mmu40x_get_physical_address(CPUPPCState *=
env, mmu_ctx_t *ctx,
>          check_perms:
>              /* Check from TLB entry */
>              ctx->prot =3D tlb->prot;
> -            ret =3D check_prot(ctx->prot, access_type);
> -            if (ret =3D=3D -2) {
> +            if (CHECK_PROT_ACCESS(ctx->prot, access_type)) {
> +                ret =3D 0;
> +            } else {
>                  env->spr[SPR_40x_ESR] =3D 0;
> +                ret =3D -2;
>              }
>              break;
>          }
> @@ -607,7 +607,7 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcem=
b_tlb_t *tlb,
>      } else {
>          *prot =3D (tlb->prot >> 4) & 0xF;
>      }
> -    if (*prot & prot_for_access_type(access_type)) {
> +    if (CHECK_PROT_ACCESS(*prot, access_type)) {
>          qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
>          return 0;
>      }
> @@ -811,7 +811,7 @@ found_tlb:
>              *prot |=3D PAGE_EXEC;
>          }
>      }
> -    if (*prot & prot_for_access_type(access_type)) {
> +    if (CHECK_PROT_ACCESS(*prot, access_type)) {
>          qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
>          return 0;
>      }


