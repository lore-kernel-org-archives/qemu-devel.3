Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F89C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 06:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4x8s-0003eU-Qx; Thu, 09 May 2024 02:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4x8U-0003Lq-6U; Thu, 09 May 2024 02:20:10 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4x8O-0001WR-Gb; Thu, 09 May 2024 02:20:09 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f467fb2e66so514584b3a.1; 
 Wed, 08 May 2024 23:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715235602; x=1715840402; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+UW9ote00TJtB6sGTub9dFRlojYQAeGdQQ0W2y0IUKs=;
 b=mVGUC7Yv2ed+sW+3TnNIWwa4uvN5tVq6I+HVVGtq1W3WAvAn0nzz3guj6ZXZm9nep/
 NZ72kHsBKbJv6ddWhoBFQGeZUUgv9Yh/+QpARia123P7muILnl5njJYGAMJ6fg4TqoxX
 1U+8BzeIuxHsIPJ/GgjLS6OOX05bYjnDjD3zMmqQkOdYRe0IlYVRfiLquVCNswHchHaj
 piv381kxfibEOfWUF+deYrkzdgfy/xAqJyqXekgOyjMn8VjtwCXb1+IbdL3ZnfUKtAbE
 p1C4mRU28NjGh3O45gWTKpGjpuaQkFoz0YKe/jZamFDq2griutrfP/CMIDvaia2U7ezb
 vvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715235602; x=1715840402;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+UW9ote00TJtB6sGTub9dFRlojYQAeGdQQ0W2y0IUKs=;
 b=BCR6bUgnhYLvhYpTtPjmjaKImd9mAYbP3OuQ4Yw59ZhFfWR5FC3eO0ZsxdxIliirMX
 phjv1Ww4BxJRdZoDDIvCiuEm1cCCQOtz9IrfTlZsaXALx5kWd7xzwstVe4ZzDgzKIJtI
 qA1XeAbkY9EGbL76G38njyVAXsxL0t1FePYWWdLNNXTKtCvgype3r6rKBanA8J1eAm5q
 71K2XmDnUlZPCf2ap9ah7QSR7ws6Oe9ZgoxwkZoWyQuCD2aLY26rFH+8w5KVrgPokdHk
 s8GXaxWrTrgDgH6aOPNf9h/TvrDEdTN7DdKwOWWZuLZD3dXNi3F434MQw9i/D5bB9bvF
 225Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUnmUyFNsuTkFHQ6a4q4TQA+j2cEu2RScaYd0r8G/klJx1BQsyTVUnuzT+/sFeekqP+anwCK6+ZeaSarcXdfy4wi6YwqZwGfCH6uan5k8x6gpUWreyjoGbyzM=
X-Gm-Message-State: AOJu0YyH/s/ILE0VsH2A8duAWcKj9XzMH868d1qvmEhyheMPtMpXzDZJ
 5jSn4I/M3dfjHTEtD7Y3gJDCbiv9qAZFYHrBl2JiEGG6dg76ISlT
X-Google-Smtp-Source: AGHT+IG+BUENRgUZ4VZ4Cp4sPOYaoeOR/sQ1RLsSqnjInfwBksjxxpFN7DvrqKd0Gj4+yV6qQcdUrw==
X-Received: by 2002:a05:6a21:6daa:b0:1af:3870:20dc with SMTP id
 adf61e73a8af0-1afc8dbdc02mr5583072637.55.1715235602150; 
 Wed, 08 May 2024 23:20:02 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b6711682bcsm634544a91.20.2024.05.08.23.19.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 23:20:01 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 May 2024 16:19:57 +1000
Message-Id: <D14W9V8URHO8.2VEA40YNOOV49@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v4 33/33] target/ppc: Move out BookE and related MMU
 functions from mmu_common.c
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715209155.git.balaton@eik.bme.hu>
 <7b00fad6422a3f1e31130943518ed47362796655.1715209155.git.balaton@eik.bme.hu>
In-Reply-To: <7b00fad6422a3f1e31130943518ed47362796655.1715209155.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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
> Add a new mmu-booke.c file for BookE and related MMU bits from
> mmu_common.c.
>
Nice work.

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/cpu.h        |   4 -
>  target/ppc/meson.build  |   1 +
>  target/ppc/mmu-booke.c  | 532 ++++++++++++++++++++++++++++++++++++++++
>  target/ppc/mmu-booke.h  |  17 ++
>  target/ppc/mmu_common.c | 509 +-------------------------------------
>  target/ppc/mmu_helper.c |   1 +
>  6 files changed, 552 insertions(+), 512 deletions(-)
>  create mode 100644 target/ppc/mmu-booke.c
>  create mode 100644 target/ppc/mmu-booke.h
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index cfb3ba5ac8..92b50a1be2 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1606,10 +1606,6 @@ void ppc_tlb_invalidate_all(CPUPPCState *env);
>  void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr);
>  void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
>  void cpu_ppc_set_1lpar(PowerPCCPU *cpu);
> -int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp=
,
> -                     target_ulong address, uint32_t pid);
> -int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t p=
id);
> -hwaddr booke206_tlb_to_page_size(CPUPPCState *env, ppcmas_tlb_t *tlb);
>  #endif
> =20
>  void ppc_store_fpscr(CPUPPCState *env, target_ulong val);
> diff --git a/target/ppc/meson.build b/target/ppc/meson.build
> index 0b89f9b89f..db3b7a0c33 100644
> --- a/target/ppc/meson.build
> +++ b/target/ppc/meson.build
> @@ -37,6 +37,7 @@ ppc_system_ss.add(files(
>    'arch_dump.c',
>    'machine.c',
>    'mmu-hash32.c',
> +  'mmu-booke.c',
>    'mmu_common.c',
>    'ppc-qmp-cmds.c',
>  ))
> diff --git a/target/ppc/mmu-booke.c b/target/ppc/mmu-booke.c
> new file mode 100644
> index 0000000000..cc93dc1c8c
> --- /dev/null
> +++ b/target/ppc/mmu-booke.c
> @@ -0,0 +1,532 @@
> +/*
> + *  PowerPC BookE MMU, TLB emulation helpers for QEMU.
> + *
> + *  Copyright (c) 2003-2007 Jocelyn Mayer
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "exec/page-protection.h"
> +#include "exec/log.h"
> +#include "cpu.h"
> +#include "internal.h"
> +#include "mmu-booke.h"
> +
> +/* Generic TLB check function for embedded PowerPC implementations */
> +static bool ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
> +                             hwaddr *raddrp,
> +                             target_ulong address, uint32_t pid, int i)
> +{
> +    target_ulong mask;
> +
> +    /* Check valid flag */
> +    if (!(tlb->prot & PAGE_VALID)) {
> +        return false;
> +    }
> +    mask =3D ~(tlb->size - 1);
> +    qemu_log_mask(CPU_LOG_MMU, "%s: TLB %d address " TARGET_FMT_lx
> +                  " PID %u <=3D> " TARGET_FMT_lx " " TARGET_FMT_lx " %u =
%x\n",
> +                  __func__, i, address, pid, tlb->EPN,
> +                  mask, (uint32_t)tlb->PID, tlb->prot);
> +    /* Check PID */
> +    if (tlb->PID !=3D 0 && tlb->PID !=3D pid) {
> +        return false;
> +    }
> +    /* Check effective address */
> +    if ((address & mask) !=3D tlb->EPN) {
> +        return false;
> +    }
> +    *raddrp =3D (tlb->RPN & mask) | (address & ~mask);
> +    return true;
> +}
> +
> +/* Generic TLB search function for PowerPC embedded implementations */
> +int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t p=
id)
> +{
> +    ppcemb_tlb_t *tlb;
> +    hwaddr raddr;
> +    int i;
> +
> +    for (i =3D 0; i < env->nb_tlb; i++) {
> +        tlb =3D &env->tlb.tlbe[i];
> +        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i)) {
> +            return i;
> +        }
> +    }
> +    return -1;
> +}
> +
> +int mmu40x_get_physical_address(CPUPPCState *env, hwaddr *raddr, int *pr=
ot,
> +                                target_ulong address,
> +                                MMUAccessType access_type)
> +{
> +    ppcemb_tlb_t *tlb;
> +    int i, ret, zsel, zpr, pr;
> +
> +    ret =3D -1;
> +    *prot =3D 0;
> +    pr =3D FIELD_EX64(env->msr, MSR, PR);
> +    for (i =3D 0; i < env->nb_tlb; i++) {
> +        tlb =3D &env->tlb.tlbe[i];
> +        if (!ppcemb_tlb_check(env, tlb, raddr, address,
> +                              env->spr[SPR_40x_PID], i)) {
> +            continue;
> +        }
> +        zsel =3D (tlb->attr >> 4) & 0xF;
> +        zpr =3D (env->spr[SPR_40x_ZPR] >> (30 - (2 * zsel))) & 0x3;
> +        qemu_log_mask(CPU_LOG_MMU,
> +                      "%s: TLB %d zsel %d zpr %d ty %d attr %08x\n",
> +                      __func__, i, zsel, zpr, access_type, tlb->attr);
> +        /* Check execute enable bit */
> +        switch (zpr) {
> +        case 0x2:
> +            if (pr !=3D 0) {
> +                goto check_perms;
> +            }
> +            /* fall through */
> +        case 0x3:
> +            /* All accesses granted */
> +            *prot =3D PAGE_RWX;
> +            ret =3D 0;
> +            break;
> +
> +        case 0x0:
> +            if (pr !=3D 0) {
> +                /* Raise Zone protection fault.  */
> +                env->spr[SPR_40x_ESR] =3D 1 << 22;
> +                *prot =3D 0;
> +                ret =3D -2;
> +                break;
> +            }
> +            /* fall through */
> +        case 0x1:
> +check_perms:
> +            /* Check from TLB entry */
> +            *prot =3D tlb->prot;
> +            if (CHECK_PROT_ACCESS(*prot, access_type)) {
> +                ret =3D 0;
> +            } else {
> +                env->spr[SPR_40x_ESR] =3D 0;
> +                ret =3D -2;
> +            }
> +            break;
> +        }
> +    }
> +    qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " =3D> "
> +                  HWADDR_FMT_plx " %d %d\n",  __func__,
> +                  ret < 0 ? "refused" : "granted", address,
> +                  ret < 0 ? 0 : *raddr, *prot, ret);
> +
> +    return ret;
> +}
> +
> +static bool mmubooke_check_pid(CPUPPCState *env, ppcemb_tlb_t *tlb,
> +                               hwaddr *raddr, target_ulong addr, int i)
> +{
> +    if (ppcemb_tlb_check(env, tlb, raddr, addr, env->spr[SPR_BOOKE_PID],=
 i)) {
> +        if (!env->nb_pids) {
> +            /* Extend the physical address to 36 bits */
> +            *raddr |=3D (uint64_t)(tlb->RPN & 0xF) << 32;
> +        }
> +        return true;
> +    } else if (!env->nb_pids) {
> +        return false;
> +    }
> +    if (env->spr[SPR_BOOKE_PID1] &&
> +        ppcemb_tlb_check(env, tlb, raddr, addr, env->spr[SPR_BOOKE_PID1]=
, i)) {
> +        return true;
> +    }
> +    if (env->spr[SPR_BOOKE_PID2] &&
> +        ppcemb_tlb_check(env, tlb, raddr, addr, env->spr[SPR_BOOKE_PID2]=
, i)) {
> +        return true;
> +    }
> +    return false;
> +}
> +
> +static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
> +                              hwaddr *raddr, int *prot, target_ulong add=
ress,
> +                              MMUAccessType access_type, int i)
> +{
> +    if (!mmubooke_check_pid(env, tlb, raddr, address, i)) {
> +        qemu_log_mask(CPU_LOG_MMU, "%s: TLB entry not found\n", __func__=
);
> +        return -1;
> +    }
> +
> +    /* Check the address space */
> +    if ((access_type =3D=3D MMU_INST_FETCH ?
> +        FIELD_EX64(env->msr, MSR, IR) :
> +        FIELD_EX64(env->msr, MSR, DR)) !=3D (tlb->attr & 1)) {
> +        qemu_log_mask(CPU_LOG_MMU, "%s: AS doesn't match\n", __func__);
> +        return -1;
> +    }
> +
> +    if (FIELD_EX64(env->msr, MSR, PR)) {
> +        *prot =3D tlb->prot & 0xF;
> +    } else {
> +        *prot =3D (tlb->prot >> 4) & 0xF;
> +    }
> +    if (CHECK_PROT_ACCESS(*prot, access_type)) {
> +        qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
> +        return 0;
> +    }
> +
> +    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, *pro=
t);
> +    return access_type =3D=3D MMU_INST_FETCH ? -3 : -2;
> +}
> +
> +static int mmubooke_get_physical_address(CPUPPCState *env, hwaddr *raddr=
,
> +                                         int *prot, target_ulong address=
,
> +                                         MMUAccessType access_type)
> +{
> +    ppcemb_tlb_t *tlb;
> +    int i, ret =3D -1;
> +
> +    for (i =3D 0; i < env->nb_tlb; i++) {
> +        tlb =3D &env->tlb.tlbe[i];
> +        ret =3D mmubooke_check_tlb(env, tlb, raddr, prot, address,
> +                                 access_type, i);
> +        if (ret !=3D -1) {
> +            break;
> +        }
> +    }
> +    qemu_log_mask(CPU_LOG_MMU,
> +                  "%s: access %s " TARGET_FMT_lx " =3D> " HWADDR_FMT_plx
> +                  " %d %d\n", __func__, ret < 0 ? "refused" : "granted",
> +                  address, ret < 0 ? -1 : *raddr, ret =3D=3D -1 ? 0 : *p=
rot, ret);
> +    return ret;
> +}
> +
> +hwaddr booke206_tlb_to_page_size(CPUPPCState *env, ppcmas_tlb_t *tlb)
> +{
> +    int tlbm_size;
> +
> +    tlbm_size =3D (tlb->mas1 & MAS1_TSIZE_MASK) >> MAS1_TSIZE_SHIFT;
> +
> +    return 1024ULL << tlbm_size;
> +}
> +
> +/* TLB check function for MAS based SoftTLBs */
> +int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp=
,
> +                     target_ulong address, uint32_t pid)
> +{
> +    hwaddr mask;
> +    uint32_t tlb_pid;
> +
> +    if (!FIELD_EX64(env->msr, MSR, CM)) {
> +        /* In 32bit mode we can only address 32bit EAs */
> +        address =3D (uint32_t)address;
> +    }
> +
> +    /* Check valid flag */
> +    if (!(tlb->mas1 & MAS1_VALID)) {
> +        return -1;
> +    }
> +
> +    mask =3D ~(booke206_tlb_to_page_size(env, tlb) - 1);
> +    qemu_log_mask(CPU_LOG_MMU, "%s: TLB ADDR=3D0x" TARGET_FMT_lx
> +                  " PID=3D0x%x MAS1=3D0x%x MAS2=3D0x%" PRIx64 " mask=3D0=
x%"
> +                  HWADDR_PRIx " MAS7_3=3D0x%" PRIx64 " MAS8=3D0x%" PRIx3=
2 "\n",
> +                  __func__, address, pid, tlb->mas1, tlb->mas2, mask,
> +                  tlb->mas7_3, tlb->mas8);
> +
> +    /* Check PID */
> +    tlb_pid =3D (tlb->mas1 & MAS1_TID_MASK) >> MAS1_TID_SHIFT;
> +    if (tlb_pid !=3D 0 && tlb_pid !=3D pid) {
> +        return -1;
> +    }
> +
> +    /* Check effective address */
> +    if ((address & mask) !=3D (tlb->mas2 & MAS2_EPN_MASK)) {
> +        return -1;
> +    }
> +
> +    if (raddrp) {
> +        *raddrp =3D (tlb->mas7_3 & mask) | (address & ~mask);
> +    }
> +
> +    return 0;
> +}
> +
> +static bool is_epid_mmu(int mmu_idx)
> +{
> +    return mmu_idx =3D=3D PPC_TLB_EPID_STORE || mmu_idx =3D=3D PPC_TLB_E=
PID_LOAD;
> +}
> +
> +static uint32_t mmubooke206_esr(int mmu_idx, MMUAccessType access_type)
> +{
> +    uint32_t esr =3D 0;
> +    if (access_type =3D=3D MMU_DATA_STORE) {
> +        esr |=3D ESR_ST;
> +    }
> +    if (is_epid_mmu(mmu_idx)) {
> +        esr |=3D ESR_EPID;
> +    }
> +    return esr;
> +}
> +
> +/*
> + * Get EPID register given the mmu_idx. If this is regular load,
> + * construct the EPID access bits from current processor state
> + *
> + * Get the effective AS and PR bits and the PID. The PID is returned
> + * only if EPID load is requested, otherwise the caller must detect
> + * the correct EPID.  Return true if valid EPID is returned.
> + */
> +static bool mmubooke206_get_as(CPUPPCState *env,
> +                               int mmu_idx, uint32_t *epid_out,
> +                               bool *as_out, bool *pr_out)
> +{
> +    if (is_epid_mmu(mmu_idx)) {
> +        uint32_t epidr;
> +        if (mmu_idx =3D=3D PPC_TLB_EPID_STORE) {
> +            epidr =3D env->spr[SPR_BOOKE_EPSC];
> +        } else {
> +            epidr =3D env->spr[SPR_BOOKE_EPLC];
> +        }
> +        *epid_out =3D (epidr & EPID_EPID) >> EPID_EPID_SHIFT;
> +        *as_out =3D !!(epidr & EPID_EAS);
> +        *pr_out =3D !!(epidr & EPID_EPR);
> +        return true;
> +    } else {
> +        *as_out =3D FIELD_EX64(env->msr, MSR, DS);
> +        *pr_out =3D FIELD_EX64(env->msr, MSR, PR);
> +        return false;
> +    }
> +}
> +
> +/* Check if the tlb found by hashing really matches */
> +static int mmubooke206_check_tlb(CPUPPCState *env, ppcmas_tlb_t *tlb,
> +                                 hwaddr *raddr, int *prot,
> +                                 target_ulong address,
> +                                 MMUAccessType access_type, int mmu_idx)
> +{
> +    uint32_t epid;
> +    bool as, pr;
> +    bool use_epid =3D mmubooke206_get_as(env, mmu_idx, &epid, &as, &pr);
> +
> +    if (!use_epid) {
> +        if (ppcmas_tlb_check(env, tlb, raddr, address,
> +                             env->spr[SPR_BOOKE_PID]) >=3D 0) {
> +            goto found_tlb;
> +        }
> +
> +        if (env->spr[SPR_BOOKE_PID1] &&
> +            ppcmas_tlb_check(env, tlb, raddr, address,
> +                             env->spr[SPR_BOOKE_PID1]) >=3D 0) {
> +            goto found_tlb;
> +        }
> +
> +        if (env->spr[SPR_BOOKE_PID2] &&
> +            ppcmas_tlb_check(env, tlb, raddr, address,
> +                             env->spr[SPR_BOOKE_PID2]) >=3D 0) {
> +            goto found_tlb;
> +        }
> +    } else {
> +        if (ppcmas_tlb_check(env, tlb, raddr, address, epid) >=3D 0) {
> +            goto found_tlb;
> +        }
> +    }
> +
> +    qemu_log_mask(CPU_LOG_MMU, "%s: No TLB entry found for effective add=
ress "
> +                  "0x" TARGET_FMT_lx "\n", __func__, address);
> +    return -1;
> +
> +found_tlb:
> +
> +    /* Check the address space and permissions */
> +    if (access_type =3D=3D MMU_INST_FETCH) {
> +        /* There is no way to fetch code using epid load */
> +        assert(!use_epid);
> +        as =3D FIELD_EX64(env->msr, MSR, IR);
> +    }
> +
> +    if (as !=3D ((tlb->mas1 & MAS1_TS) >> MAS1_TS_SHIFT)) {
> +        qemu_log_mask(CPU_LOG_MMU, "%s: AS doesn't match\n", __func__);
> +        return -1;
> +    }
> +
> +    *prot =3D 0;
> +    if (pr) {
> +        if (tlb->mas7_3 & MAS3_UR) {
> +            *prot |=3D PAGE_READ;
> +        }
> +        if (tlb->mas7_3 & MAS3_UW) {
> +            *prot |=3D PAGE_WRITE;
> +        }
> +        if (tlb->mas7_3 & MAS3_UX) {
> +            *prot |=3D PAGE_EXEC;
> +        }
> +    } else {
> +        if (tlb->mas7_3 & MAS3_SR) {
> +            *prot |=3D PAGE_READ;
> +        }
> +        if (tlb->mas7_3 & MAS3_SW) {
> +            *prot |=3D PAGE_WRITE;
> +        }
> +        if (tlb->mas7_3 & MAS3_SX) {
> +            *prot |=3D PAGE_EXEC;
> +        }
> +    }
> +    if (CHECK_PROT_ACCESS(*prot, access_type)) {
> +        qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
> +        return 0;
> +    }
> +
> +    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, *pro=
t);
> +    return access_type =3D=3D MMU_INST_FETCH ? -3 : -2;
> +}
> +
> +static int mmubooke206_get_physical_address(CPUPPCState *env, hwaddr *ra=
ddr,
> +                                            int *prot, target_ulong addr=
ess,
> +                                            MMUAccessType access_type,
> +                                            int mmu_idx)
> +{
> +    ppcmas_tlb_t *tlb;
> +    int i, j, ret =3D -1;
> +
> +    for (i =3D 0; i < BOOKE206_MAX_TLBN; i++) {
> +        int ways =3D booke206_tlb_ways(env, i);
> +        for (j =3D 0; j < ways; j++) {
> +            tlb =3D booke206_get_tlbm(env, i, address, j);
> +            if (!tlb) {
> +                continue;
> +            }
> +            ret =3D mmubooke206_check_tlb(env, tlb, raddr, prot, address=
,
> +                                        access_type, mmu_idx);
> +            if (ret !=3D -1) {
> +                goto found_tlb;
> +            }
> +        }
> +    }
> +
> +found_tlb:
> +
> +    qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " =3D> "
> +                  HWADDR_FMT_plx " %d %d\n", __func__,
> +                  ret < 0 ? "refused" : "granted", address,
> +                  ret < 0 ? -1 : *raddr, ret =3D=3D -1 ? 0 : *prot, ret)=
;
> +    return ret;
> +}
> +
> +static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong =
address,
> +                                         MMUAccessType access_type, int =
mmu_idx)
> +{
> +    uint32_t epid;
> +    bool as, pr;
> +    uint32_t missed_tid =3D 0;
> +    bool use_epid =3D mmubooke206_get_as(env, mmu_idx, &epid, &as, &pr);
> +
> +    if (access_type =3D=3D MMU_INST_FETCH) {
> +        as =3D FIELD_EX64(env->msr, MSR, IR);
> +    }
> +    env->spr[SPR_BOOKE_MAS0] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_TLBSELD=
_MASK;
> +    env->spr[SPR_BOOKE_MAS1] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_TSIZED_=
MASK;
> +    env->spr[SPR_BOOKE_MAS2] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_WIMGED_=
MASK;
> +    env->spr[SPR_BOOKE_MAS3] =3D 0;
> +    env->spr[SPR_BOOKE_MAS6] =3D 0;
> +    env->spr[SPR_BOOKE_MAS7] =3D 0;
> +
> +    /* AS */
> +    if (as) {
> +        env->spr[SPR_BOOKE_MAS1] |=3D MAS1_TS;
> +        env->spr[SPR_BOOKE_MAS6] |=3D MAS6_SAS;
> +    }
> +
> +    env->spr[SPR_BOOKE_MAS1] |=3D MAS1_VALID;
> +    env->spr[SPR_BOOKE_MAS2] |=3D address & MAS2_EPN_MASK;
> +
> +    if (!use_epid) {
> +        switch (env->spr[SPR_BOOKE_MAS4] & MAS4_TIDSELD_PIDZ) {
> +        case MAS4_TIDSELD_PID0:
> +            missed_tid =3D env->spr[SPR_BOOKE_PID];
> +            break;
> +        case MAS4_TIDSELD_PID1:
> +            missed_tid =3D env->spr[SPR_BOOKE_PID1];
> +            break;
> +        case MAS4_TIDSELD_PID2:
> +            missed_tid =3D env->spr[SPR_BOOKE_PID2];
> +            break;
> +        }
> +        env->spr[SPR_BOOKE_MAS6] |=3D env->spr[SPR_BOOKE_PID] << 16;
> +    } else {
> +        missed_tid =3D epid;
> +        env->spr[SPR_BOOKE_MAS6] |=3D missed_tid << 16;
> +    }
> +    env->spr[SPR_BOOKE_MAS1] |=3D (missed_tid << MAS1_TID_SHIFT);
> +
> +
> +    /* next victim logic */
> +    env->spr[SPR_BOOKE_MAS0] |=3D env->last_way << MAS0_ESEL_SHIFT;
> +    env->last_way++;
> +    env->last_way &=3D booke206_tlb_ways(env, 0) - 1;
> +    env->spr[SPR_BOOKE_MAS0] |=3D env->last_way << MAS0_NV_SHIFT;
> +}
> +
> +bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_=
type,
> +                     hwaddr *raddrp, int *psizep, int *protp, int mmu_id=
x,
> +                     bool guest_visible)
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
> +    env->error_code =3D 0;
> +    switch (ret) {
> +    case -1:
> +        /* No matches in page tables or TLB */
> +        if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
> +            booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_id=
x);
> +        }
> +        cs->exception_index =3D (access_type =3D=3D MMU_INST_FETCH) ?
> +                              POWERPC_EXCP_ITLB : POWERPC_EXCP_DTLB;
> +        env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> +        env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_type=
);
> +        break;
> +    case -2:
> +        /* Access rights violation */
> +        cs->exception_index =3D (access_type =3D=3D MMU_INST_FETCH) ?
> +                              POWERPC_EXCP_ISI : POWERPC_EXCP_DSI;
> +        if (access_type !=3D MMU_INST_FETCH) {
> +            env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> +            env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_=
type);
> +        }
> +        break;
> +    case -3:
> +        /* No execute protection violation */
> +        cs->exception_index =3D POWERPC_EXCP_ISI;
> +        env->spr[SPR_BOOKE_ESR] =3D 0;
> +        break;
> +    }
> +
> +    return false;
> +}
> diff --git a/target/ppc/mmu-booke.h b/target/ppc/mmu-booke.h
> new file mode 100644
> index 0000000000..f972843bbb
> --- /dev/null
> +++ b/target/ppc/mmu-booke.h
> @@ -0,0 +1,17 @@
> +#ifndef PPC_MMU_BOOKE_H
> +#define PPC_MMU_BOOKE_H
> +
> +#include "cpu.h"
> +
> +int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t p=
id);
> +int mmu40x_get_physical_address(CPUPPCState *env, hwaddr *raddr, int *pr=
ot,
> +                                target_ulong address,
> +                                MMUAccessType access_type);
> +hwaddr booke206_tlb_to_page_size(CPUPPCState *env, ppcmas_tlb_t *tlb);
> +int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp=
,
> +                     target_ulong address, uint32_t pid);
> +bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_=
type,
> +                     hwaddr *raddrp, int *psizep, int *protp, int mmu_id=
x,
> +                     bool guest_visible);
> +
> +#endif
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index bcd20ddc7b..9be48c8db0 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -33,6 +33,7 @@
>  #include "internal.h"
>  #include "mmu-book3s-v3.h"
>  #include "mmu-radix64.h"
> +#include "mmu-booke.h"
> =20
>  /* #define DUMP_PAGE_TABLES */
> =20
> @@ -444,402 +445,6 @@ static int mmu6xx_get_physical_address(CPUPPCState =
*env, mmu_ctx_t *ctx,
>      return -2;
>  }
> =20
> -/* Generic TLB check function for embedded PowerPC implementations */
> -static bool ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
> -                             hwaddr *raddrp,
> -                             target_ulong address, uint32_t pid, int i)
> -{
> -    target_ulong mask;
> -
> -    /* Check valid flag */
> -    if (!(tlb->prot & PAGE_VALID)) {
> -        return false;
> -    }
> -    mask =3D ~(tlb->size - 1);
> -    qemu_log_mask(CPU_LOG_MMU, "%s: TLB %d address " TARGET_FMT_lx
> -                  " PID %u <=3D> " TARGET_FMT_lx " " TARGET_FMT_lx " %u =
%x\n",
> -                  __func__, i, address, pid, tlb->EPN,
> -                  mask, (uint32_t)tlb->PID, tlb->prot);
> -    /* Check PID */
> -    if (tlb->PID !=3D 0 && tlb->PID !=3D pid) {
> -        return false;
> -    }
> -    /* Check effective address */
> -    if ((address & mask) !=3D tlb->EPN) {
> -        return false;
> -    }
> -    *raddrp =3D (tlb->RPN & mask) | (address & ~mask);
> -    return true;
> -}
> -
> -/* Generic TLB search function for PowerPC embedded implementations */
> -int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t p=
id)
> -{
> -    ppcemb_tlb_t *tlb;
> -    hwaddr raddr;
> -    int i;
> -
> -    for (i =3D 0; i < env->nb_tlb; i++) {
> -        tlb =3D &env->tlb.tlbe[i];
> -        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i)) {
> -            return i;
> -        }
> -    }
> -    return -1;
> -}
> -
> -static int mmu40x_get_physical_address(CPUPPCState *env, hwaddr *raddr,
> -                                       int *prot, target_ulong address,
> -                                       MMUAccessType access_type)
> -{
> -    ppcemb_tlb_t *tlb;
> -    int i, ret, zsel, zpr, pr;
> -
> -    ret =3D -1;
> -    *prot =3D 0;
> -    pr =3D FIELD_EX64(env->msr, MSR, PR);
> -    for (i =3D 0; i < env->nb_tlb; i++) {
> -        tlb =3D &env->tlb.tlbe[i];
> -        if (!ppcemb_tlb_check(env, tlb, raddr, address,
> -                              env->spr[SPR_40x_PID], i)) {
> -            continue;
> -        }
> -        zsel =3D (tlb->attr >> 4) & 0xF;
> -        zpr =3D (env->spr[SPR_40x_ZPR] >> (30 - (2 * zsel))) & 0x3;
> -        qemu_log_mask(CPU_LOG_MMU,
> -                      "%s: TLB %d zsel %d zpr %d ty %d attr %08x\n",
> -                      __func__, i, zsel, zpr, access_type, tlb->attr);
> -        /* Check execute enable bit */
> -        switch (zpr) {
> -        case 0x2:
> -            if (pr !=3D 0) {
> -                goto check_perms;
> -            }
> -            /* fall through */
> -        case 0x3:
> -            /* All accesses granted */
> -            *prot =3D PAGE_RWX;
> -            ret =3D 0;
> -            break;
> -
> -        case 0x0:
> -            if (pr !=3D 0) {
> -                /* Raise Zone protection fault.  */
> -                env->spr[SPR_40x_ESR] =3D 1 << 22;
> -                *prot =3D 0;
> -                ret =3D -2;
> -                break;
> -            }
> -            /* fall through */
> -        case 0x1:
> -check_perms:
> -            /* Check from TLB entry */
> -            *prot =3D tlb->prot;
> -            if (CHECK_PROT_ACCESS(*prot, access_type)) {
> -                ret =3D 0;
> -            } else {
> -                env->spr[SPR_40x_ESR] =3D 0;
> -                ret =3D -2;
> -            }
> -            break;
> -        }
> -    }
> -    qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " =3D> "
> -                  HWADDR_FMT_plx " %d %d\n",  __func__,
> -                  ret < 0 ? "refused" : "granted", address,
> -                  ret < 0 ? 0 : *raddr, *prot, ret);
> -
> -    return ret;
> -}
> -
> -static bool mmubooke_check_pid(CPUPPCState *env, ppcemb_tlb_t *tlb,
> -                               hwaddr *raddr, target_ulong addr, int i)
> -{
> -    if (ppcemb_tlb_check(env, tlb, raddr, addr, env->spr[SPR_BOOKE_PID],=
 i)) {
> -        if (!env->nb_pids) {
> -            /* Extend the physical address to 36 bits */
> -            *raddr |=3D (uint64_t)(tlb->RPN & 0xF) << 32;
> -        }
> -        return true;
> -    } else if (!env->nb_pids) {
> -        return false;
> -    }
> -    if (env->spr[SPR_BOOKE_PID1] &&
> -        ppcemb_tlb_check(env, tlb, raddr, addr, env->spr[SPR_BOOKE_PID1]=
, i)) {
> -        return true;
> -    }
> -    if (env->spr[SPR_BOOKE_PID2] &&
> -        ppcemb_tlb_check(env, tlb, raddr, addr, env->spr[SPR_BOOKE_PID2]=
, i)) {
> -        return true;
> -    }
> -    return false;
> -}
> -
> -static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
> -                              hwaddr *raddr, int *prot, target_ulong add=
ress,
> -                              MMUAccessType access_type, int i)
> -{
> -    if (!mmubooke_check_pid(env, tlb, raddr, address, i)) {
> -        qemu_log_mask(CPU_LOG_MMU, "%s: TLB entry not found\n", __func__=
);
> -        return -1;
> -    }
> -
> -    /* Check the address space */
> -    if ((access_type =3D=3D MMU_INST_FETCH ?
> -        FIELD_EX64(env->msr, MSR, IR) :
> -        FIELD_EX64(env->msr, MSR, DR)) !=3D (tlb->attr & 1)) {
> -        qemu_log_mask(CPU_LOG_MMU, "%s: AS doesn't match\n", __func__);
> -        return -1;
> -    }
> -
> -    if (FIELD_EX64(env->msr, MSR, PR)) {
> -        *prot =3D tlb->prot & 0xF;
> -    } else {
> -        *prot =3D (tlb->prot >> 4) & 0xF;
> -    }
> -    if (CHECK_PROT_ACCESS(*prot, access_type)) {
> -        qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
> -        return 0;
> -    }
> -
> -    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, *pro=
t);
> -    return access_type =3D=3D MMU_INST_FETCH ? -3 : -2;
> -}
> -
> -static int mmubooke_get_physical_address(CPUPPCState *env, hwaddr *raddr=
,
> -                                         int *prot, target_ulong address=
,
> -                                         MMUAccessType access_type)
> -{
> -    ppcemb_tlb_t *tlb;
> -    int i, ret =3D -1;
> -
> -    for (i =3D 0; i < env->nb_tlb; i++) {
> -        tlb =3D &env->tlb.tlbe[i];
> -        ret =3D mmubooke_check_tlb(env, tlb, raddr, prot, address,
> -                                 access_type, i);
> -        if (ret !=3D -1) {
> -            break;
> -        }
> -    }
> -    qemu_log_mask(CPU_LOG_MMU,
> -                  "%s: access %s " TARGET_FMT_lx " =3D> " HWADDR_FMT_plx
> -                  " %d %d\n", __func__, ret < 0 ? "refused" : "granted",
> -                  address, ret < 0 ? -1 : *raddr, ret =3D=3D -1 ? 0 : *p=
rot, ret);
> -    return ret;
> -}
> -
> -hwaddr booke206_tlb_to_page_size(CPUPPCState *env, ppcmas_tlb_t *tlb)
> -{
> -    int tlbm_size;
> -
> -    tlbm_size =3D (tlb->mas1 & MAS1_TSIZE_MASK) >> MAS1_TSIZE_SHIFT;
> -
> -    return 1024ULL << tlbm_size;
> -}
> -
> -/* TLB check function for MAS based SoftTLBs */
> -int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp=
,
> -                     target_ulong address, uint32_t pid)
> -{
> -    hwaddr mask;
> -    uint32_t tlb_pid;
> -
> -    if (!FIELD_EX64(env->msr, MSR, CM)) {
> -        /* In 32bit mode we can only address 32bit EAs */
> -        address =3D (uint32_t)address;
> -    }
> -
> -    /* Check valid flag */
> -    if (!(tlb->mas1 & MAS1_VALID)) {
> -        return -1;
> -    }
> -
> -    mask =3D ~(booke206_tlb_to_page_size(env, tlb) - 1);
> -    qemu_log_mask(CPU_LOG_MMU, "%s: TLB ADDR=3D0x" TARGET_FMT_lx
> -                  " PID=3D0x%x MAS1=3D0x%x MAS2=3D0x%" PRIx64 " mask=3D0=
x%"
> -                  HWADDR_PRIx " MAS7_3=3D0x%" PRIx64 " MAS8=3D0x%" PRIx3=
2 "\n",
> -                  __func__, address, pid, tlb->mas1, tlb->mas2, mask,
> -                  tlb->mas7_3, tlb->mas8);
> -
> -    /* Check PID */
> -    tlb_pid =3D (tlb->mas1 & MAS1_TID_MASK) >> MAS1_TID_SHIFT;
> -    if (tlb_pid !=3D 0 && tlb_pid !=3D pid) {
> -        return -1;
> -    }
> -
> -    /* Check effective address */
> -    if ((address & mask) !=3D (tlb->mas2 & MAS2_EPN_MASK)) {
> -        return -1;
> -    }
> -
> -    if (raddrp) {
> -        *raddrp =3D (tlb->mas7_3 & mask) | (address & ~mask);
> -    }
> -
> -    return 0;
> -}
> -
> -static bool is_epid_mmu(int mmu_idx)
> -{
> -    return mmu_idx =3D=3D PPC_TLB_EPID_STORE || mmu_idx =3D=3D PPC_TLB_E=
PID_LOAD;
> -}
> -
> -static uint32_t mmubooke206_esr(int mmu_idx, MMUAccessType access_type)
> -{
> -    uint32_t esr =3D 0;
> -    if (access_type =3D=3D MMU_DATA_STORE) {
> -        esr |=3D ESR_ST;
> -    }
> -    if (is_epid_mmu(mmu_idx)) {
> -        esr |=3D ESR_EPID;
> -    }
> -    return esr;
> -}
> -
> -/*
> - * Get EPID register given the mmu_idx. If this is regular load,
> - * construct the EPID access bits from current processor state
> - *
> - * Get the effective AS and PR bits and the PID. The PID is returned
> - * only if EPID load is requested, otherwise the caller must detect
> - * the correct EPID.  Return true if valid EPID is returned.
> - */
> -static bool mmubooke206_get_as(CPUPPCState *env,
> -                               int mmu_idx, uint32_t *epid_out,
> -                               bool *as_out, bool *pr_out)
> -{
> -    if (is_epid_mmu(mmu_idx)) {
> -        uint32_t epidr;
> -        if (mmu_idx =3D=3D PPC_TLB_EPID_STORE) {
> -            epidr =3D env->spr[SPR_BOOKE_EPSC];
> -        } else {
> -            epidr =3D env->spr[SPR_BOOKE_EPLC];
> -        }
> -        *epid_out =3D (epidr & EPID_EPID) >> EPID_EPID_SHIFT;
> -        *as_out =3D !!(epidr & EPID_EAS);
> -        *pr_out =3D !!(epidr & EPID_EPR);
> -        return true;
> -    } else {
> -        *as_out =3D FIELD_EX64(env->msr, MSR, DS);
> -        *pr_out =3D FIELD_EX64(env->msr, MSR, PR);
> -        return false;
> -    }
> -}
> -
> -/* Check if the tlb found by hashing really matches */
> -static int mmubooke206_check_tlb(CPUPPCState *env, ppcmas_tlb_t *tlb,
> -                                 hwaddr *raddr, int *prot,
> -                                 target_ulong address,
> -                                 MMUAccessType access_type, int mmu_idx)
> -{
> -    uint32_t epid;
> -    bool as, pr;
> -    bool use_epid =3D mmubooke206_get_as(env, mmu_idx, &epid, &as, &pr);
> -
> -    if (!use_epid) {
> -        if (ppcmas_tlb_check(env, tlb, raddr, address,
> -                             env->spr[SPR_BOOKE_PID]) >=3D 0) {
> -            goto found_tlb;
> -        }
> -
> -        if (env->spr[SPR_BOOKE_PID1] &&
> -            ppcmas_tlb_check(env, tlb, raddr, address,
> -                             env->spr[SPR_BOOKE_PID1]) >=3D 0) {
> -            goto found_tlb;
> -        }
> -
> -        if (env->spr[SPR_BOOKE_PID2] &&
> -            ppcmas_tlb_check(env, tlb, raddr, address,
> -                             env->spr[SPR_BOOKE_PID2]) >=3D 0) {
> -            goto found_tlb;
> -        }
> -    } else {
> -        if (ppcmas_tlb_check(env, tlb, raddr, address, epid) >=3D 0) {
> -            goto found_tlb;
> -        }
> -    }
> -
> -    qemu_log_mask(CPU_LOG_MMU, "%s: No TLB entry found for effective add=
ress "
> -                  "0x" TARGET_FMT_lx "\n", __func__, address);
> -    return -1;
> -
> -found_tlb:
> -
> -    /* Check the address space and permissions */
> -    if (access_type =3D=3D MMU_INST_FETCH) {
> -        /* There is no way to fetch code using epid load */
> -        assert(!use_epid);
> -        as =3D FIELD_EX64(env->msr, MSR, IR);
> -    }
> -
> -    if (as !=3D ((tlb->mas1 & MAS1_TS) >> MAS1_TS_SHIFT)) {
> -        qemu_log_mask(CPU_LOG_MMU, "%s: AS doesn't match\n", __func__);
> -        return -1;
> -    }
> -
> -    *prot =3D 0;
> -    if (pr) {
> -        if (tlb->mas7_3 & MAS3_UR) {
> -            *prot |=3D PAGE_READ;
> -        }
> -        if (tlb->mas7_3 & MAS3_UW) {
> -            *prot |=3D PAGE_WRITE;
> -        }
> -        if (tlb->mas7_3 & MAS3_UX) {
> -            *prot |=3D PAGE_EXEC;
> -        }
> -    } else {
> -        if (tlb->mas7_3 & MAS3_SR) {
> -            *prot |=3D PAGE_READ;
> -        }
> -        if (tlb->mas7_3 & MAS3_SW) {
> -            *prot |=3D PAGE_WRITE;
> -        }
> -        if (tlb->mas7_3 & MAS3_SX) {
> -            *prot |=3D PAGE_EXEC;
> -        }
> -    }
> -    if (CHECK_PROT_ACCESS(*prot, access_type)) {
> -        qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
> -        return 0;
> -    }
> -
> -    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, *pro=
t);
> -    return access_type =3D=3D MMU_INST_FETCH ? -3 : -2;
> -}
> -
> -static int mmubooke206_get_physical_address(CPUPPCState *env, hwaddr *ra=
ddr,
> -                                            int *prot, target_ulong addr=
ess,
> -                                            MMUAccessType access_type,
> -                                            int mmu_idx)
> -{
> -    ppcmas_tlb_t *tlb;
> -    int i, j, ret =3D -1;
> -
> -    for (i =3D 0; i < BOOKE206_MAX_TLBN; i++) {
> -        int ways =3D booke206_tlb_ways(env, i);
> -        for (j =3D 0; j < ways; j++) {
> -            tlb =3D booke206_get_tlbm(env, i, address, j);
> -            if (!tlb) {
> -                continue;
> -            }
> -            ret =3D mmubooke206_check_tlb(env, tlb, raddr, prot, address=
,
> -                                        access_type, mmu_idx);
> -            if (ret !=3D -1) {
> -                goto found_tlb;
> -            }
> -        }
> -    }
> -
> -found_tlb:
> -
> -    qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " =3D> "
> -                  HWADDR_FMT_plx " %d %d\n", __func__,
> -                  ret < 0 ? "refused" : "granted", address,
> -                  ret < 0 ? -1 : *raddr, ret =3D=3D -1 ? 0 : *prot, ret)=
;
> -    return ret;
> -}
> -
>  static const char *book3e_tsize_to_str[32] =3D {
>      "1K", "2K", "4K", "8K", "16K", "32K", "64K", "128K", "256K", "512K",
>      "1M", "2M", "4M", "8M", "16M", "32M", "64M", "128M", "256M", "512M",
> @@ -1107,118 +712,6 @@ static int get_physical_address_wtlb(CPUPPCState *=
env, mmu_ctx_t *ctx,
>      }
>  }
> =20
> -static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong =
address,
> -                                         MMUAccessType access_type, int =
mmu_idx)
> -{
> -    uint32_t epid;
> -    bool as, pr;
> -    uint32_t missed_tid =3D 0;
> -    bool use_epid =3D mmubooke206_get_as(env, mmu_idx, &epid, &as, &pr);
> -
> -    if (access_type =3D=3D MMU_INST_FETCH) {
> -        as =3D FIELD_EX64(env->msr, MSR, IR);
> -    }
> -    env->spr[SPR_BOOKE_MAS0] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_TLBSELD=
_MASK;
> -    env->spr[SPR_BOOKE_MAS1] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_TSIZED_=
MASK;
> -    env->spr[SPR_BOOKE_MAS2] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_WIMGED_=
MASK;
> -    env->spr[SPR_BOOKE_MAS3] =3D 0;
> -    env->spr[SPR_BOOKE_MAS6] =3D 0;
> -    env->spr[SPR_BOOKE_MAS7] =3D 0;
> -
> -    /* AS */
> -    if (as) {
> -        env->spr[SPR_BOOKE_MAS1] |=3D MAS1_TS;
> -        env->spr[SPR_BOOKE_MAS6] |=3D MAS6_SAS;
> -    }
> -
> -    env->spr[SPR_BOOKE_MAS1] |=3D MAS1_VALID;
> -    env->spr[SPR_BOOKE_MAS2] |=3D address & MAS2_EPN_MASK;
> -
> -    if (!use_epid) {
> -        switch (env->spr[SPR_BOOKE_MAS4] & MAS4_TIDSELD_PIDZ) {
> -        case MAS4_TIDSELD_PID0:
> -            missed_tid =3D env->spr[SPR_BOOKE_PID];
> -            break;
> -        case MAS4_TIDSELD_PID1:
> -            missed_tid =3D env->spr[SPR_BOOKE_PID1];
> -            break;
> -        case MAS4_TIDSELD_PID2:
> -            missed_tid =3D env->spr[SPR_BOOKE_PID2];
> -            break;
> -        }
> -        env->spr[SPR_BOOKE_MAS6] |=3D env->spr[SPR_BOOKE_PID] << 16;
> -    } else {
> -        missed_tid =3D epid;
> -        env->spr[SPR_BOOKE_MAS6] |=3D missed_tid << 16;
> -    }
> -    env->spr[SPR_BOOKE_MAS1] |=3D (missed_tid << MAS1_TID_SHIFT);
> -
> -
> -    /* next victim logic */
> -    env->spr[SPR_BOOKE_MAS0] |=3D env->last_way << MAS0_ESEL_SHIFT;
> -    env->last_way++;
> -    env->last_way &=3D booke206_tlb_ways(env, 0) - 1;
> -    env->spr[SPR_BOOKE_MAS0] |=3D env->last_way << MAS0_NV_SHIFT;
> -}
> -
> -static bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr,
> -                            MMUAccessType access_type,
> -                            hwaddr *raddrp, int *psizep, int *protp,
> -                            int mmu_idx, bool guest_visible)
> -{
> -    CPUState *cs =3D CPU(cpu);
> -    CPUPPCState *env =3D &cpu->env;
> -    hwaddr raddr;
> -    int prot, ret;
> -
> -    if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
> -        ret =3D mmubooke206_get_physical_address(env, &raddr, &prot, ead=
dr,
> -                                               access_type, mmu_idx);
> -    } else {
> -        ret =3D mmubooke_get_physical_address(env, &raddr, &prot, eaddr,
> -                                            access_type);
> -    }
> -    if (ret =3D=3D 0) {
> -        *raddrp =3D raddr;
> -        *protp =3D prot;
> -        *psizep =3D TARGET_PAGE_BITS;
> -        return true;
> -    } else if (!guest_visible) {
> -        return false;
> -    }
> -
> -    log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
> -    env->error_code =3D 0;
> -    switch (ret) {
> -    case -1:
> -        /* No matches in page tables or TLB */
> -        if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
> -            booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_id=
x);
> -        }
> -        cs->exception_index =3D (access_type =3D=3D MMU_INST_FETCH) ?
> -                              POWERPC_EXCP_ITLB : POWERPC_EXCP_DTLB;
> -        env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -        env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_type=
);
> -        break;
> -    case -2:
> -        /* Access rights violation */
> -        cs->exception_index =3D (access_type =3D=3D MMU_INST_FETCH) ?
> -                              POWERPC_EXCP_ISI : POWERPC_EXCP_DSI;
> -        if (access_type !=3D MMU_INST_FETCH) {
> -            env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -            env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_=
type);
> -        }
> -        break;
> -    case -3:
> -        /* No execute protection violation */
> -        cs->exception_index =3D POWERPC_EXCP_ISI;
> -        env->spr[SPR_BOOKE_ESR] =3D 0;
> -        break;
> -    }
> -
> -    return false;
> -}
> -
>  /* Perform address translation */
>  /* TODO: Split this by mmu_model. */
>  static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 680ca0b618..87bfe26220 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -33,6 +33,7 @@
>  #include "internal.h"
>  #include "mmu-book3s-v3.h"
>  #include "mmu-radix64.h"
> +#include "mmu-booke.h"
>  #include "exec/helper-proto.h"
>  #include "exec/cpu_ldst.h"
> =20


