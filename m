Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80E6C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPGiS-00017t-2u; Thu, 04 Jul 2024 03:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGiO-00015p-J4; Thu, 04 Jul 2024 03:17:14 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGiJ-0002lc-0H; Thu, 04 Jul 2024 03:17:12 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-75e7e110e89so179959a12.3; 
 Thu, 04 Jul 2024 00:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720077425; x=1720682225; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2lHcjNGBSgRJ4EugwwnvEemXnideuZ3dBI7H424eAM=;
 b=bMdv1ynq0EFm52k8TkDEx1KgIgSTm1KHghJEYDeWu0NwAc/K7yqD4IAPdqGt4+LWi2
 No5IuBsKQC3+mlHq8pEPie7g5ojtneoovnkDV01Co3PhQ/kN90LAe0Bgykr4zRnYgYXz
 R2bOnX2d77bG9qxa8ivPOhvc/3M0Mrv8Ll2/vycZCs6LTeASD/+ClzlDtL2/64vKfYfx
 E56ORCR76zKSVPdoJUtexvssuyRhpz856EhOGLh5aHaR2Gqi1r8Q3dLVBGQ3aMWqqum9
 SkUFWmkIXyI2yKAh14iAVQGBsGcpOSTgjKINaJ/tmV7GY8nWmFqNw3ml0Muin17Cv6eG
 7Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720077425; x=1720682225;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y2lHcjNGBSgRJ4EugwwnvEemXnideuZ3dBI7H424eAM=;
 b=RJdSvcWqjtrM7JlvVpUoqNFQDAhJdYVSk9T5QKHfjbx4pA2f9LEfOsz4p8hjrnqg7q
 r+hdVSXdQmtWrF7Ormzjhx3C0hpwnic6H6UiGKJJCObOQcwnzl3Uf7XaGrhNuiY/S63j
 l3G1UwwkJT9WtFY60oV//qRlQtEVkzClomH3hxFI6pHBDPz8SAfjwG8QpVmAPTsCnNp0
 xXjlOS8md7FXW4rcj5W1bR+TMti8dIwNu3MoctcCAuL7lMYhdd7kCXnp3UBcagU30I5s
 Y0iwbh6nXdGwj19MpVC4xrtk5OaCmao5JARoaRD31WyZhdNUBKPnOMwCfOPVeYYwR8SB
 g7ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWynHgi9QAsAyP0OgMcoDe4DCC1Jfk5IR3snS77c+NiAPemvx4E8JTP2SYyNASqJPPZl7xQJHueFbv/3wZJjeryVJYdbo7b6S4KisPx/TVTp3x/t30ISwntzw=
X-Gm-Message-State: AOJu0YyqDpy63YMhEZeSwej+qQRwzFzaHNuzkqSpSTTddWjOS925jJ6s
 4hKaj5+Rjy7BOFzjAJWq/9sBzbOGE3BF7aUFaszQkHFCPZ263MI+
X-Google-Smtp-Source: AGHT+IECQ4mQVhIhzjvQhDwn3ToeF11IHi2hUqvQ5JnKEksfuqmU/IxAp/H9I3z/ZP2cEn93ypJ6JQ==
X-Received: by 2002:a05:6a21:9990:b0:1bf:117b:bea1 with SMTP id
 adf61e73a8af0-1c0cc8b3a39mr778337637.41.1720077425019; 
 Thu, 04 Jul 2024 00:17:05 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1569449sm115446385ad.220.2024.07.04.00.17.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:17:04 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:16:59 +1000
Message-Id: <D2GKK1VXLXIM.20G0PWTUV1MP@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 31/43] target/ppc/mmu-radix64: Remove externally unused
 parts from header
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <3eccbbc40175cbf8e592fb62c0544202052c571c.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <3eccbbc40175cbf8e592fb62c0544202052c571c.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon May 27, 2024 at 9:13 AM AEST, BALATON Zoltan wrote:
> Move the parts not needed outside of mmu-radix64.c from the header to
> the C file to leave only parts in the header that need to be exported.
> Also drop unneded include of this header.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mmu-book3s-v3.c |  1 -
>  target/ppc/mmu-radix64.c   | 49 +++++++++++++++++++++++++++++++++++
>  target/ppc/mmu-radix64.h   | 53 +-------------------------------------
>  3 files changed, 50 insertions(+), 53 deletions(-)
>
> diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
> index c8f69b3df9..a812cb5113 100644
> --- a/target/ppc/mmu-book3s-v3.c
> +++ b/target/ppc/mmu-book3s-v3.c
> @@ -21,7 +21,6 @@
>  #include "cpu.h"
>  #include "mmu-hash64.h"
>  #include "mmu-book3s-v3.h"
> -#include "mmu-radix64.h"
> =20
>  bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lpid, ppc_v3_pate_t=
 *entry)
>  {
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index 5a02e4963b..cf9619e847 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -29,6 +29,37 @@
>  #include "mmu-radix64.h"
>  #include "mmu-book3s-v3.h"
> =20
> +/* Radix Partition Table Entry Fields */
> +#define PATE1_R_PRTB           0x0FFFFFFFFFFFF000
> +#define PATE1_R_PRTS           0x000000000000001F
> +
> +/* Radix Process Table Entry Fields */
> +#define PRTBE_R_GET_RTS(rts) \
> +    ((((rts >> 58) & 0x18) | ((rts >> 5) & 0x7)) + 31)
> +#define PRTBE_R_RPDB            0x0FFFFFFFFFFFFF00
> +#define PRTBE_R_RPDS            0x000000000000001F
> +
> +/* Radix Page Directory/Table Entry Fields */
> +#define R_PTE_VALID             0x8000000000000000
> +#define R_PTE_LEAF              0x4000000000000000
> +#define R_PTE_SW0               0x2000000000000000
> +#define R_PTE_RPN               0x01FFFFFFFFFFF000
> +#define R_PTE_SW1               0x0000000000000E00
> +#define R_GET_SW(sw)            (((sw >> 58) & 0x8) | ((sw >> 9) & 0x7))
> +#define R_PTE_R                 0x0000000000000100
> +#define R_PTE_C                 0x0000000000000080
> +#define R_PTE_ATT               0x0000000000000030
> +#define R_PTE_ATT_NORMAL        0x0000000000000000
> +#define R_PTE_ATT_SAO           0x0000000000000010
> +#define R_PTE_ATT_NI_IO         0x0000000000000020
> +#define R_PTE_ATT_TOLERANT_IO   0x0000000000000030
> +#define R_PTE_EAA_PRIV          0x0000000000000008
> +#define R_PTE_EAA_R             0x0000000000000004
> +#define R_PTE_EAA_RW            0x0000000000000002
> +#define R_PTE_EAA_X             0x0000000000000001
> +#define R_PDE_NLB               PRTBE_R_RPDB
> +#define R_PDE_NLS               PRTBE_R_RPDS
> +
>  static bool ppc_radix64_get_fully_qualified_addr(const CPUPPCState *env,
>                                                   vaddr eaddr,
>                                                   uint64_t *lpid, uint64_=
t *pid)
> @@ -180,6 +211,24 @@ static void ppc_radix64_raise_hsi(PowerPCCPU *cpu, M=
MUAccessType access_type,
>      }
>  }
> =20
> +static int ppc_radix64_get_prot_eaa(uint64_t pte)
> +{
> +    return (pte & R_PTE_EAA_R ? PAGE_READ : 0) |
> +           (pte & R_PTE_EAA_RW ? PAGE_READ | PAGE_WRITE : 0) |
> +           (pte & R_PTE_EAA_X ? PAGE_EXEC : 0);
> +}
> +
> +static int ppc_radix64_get_prot_amr(const PowerPCCPU *cpu)
> +{
> +    const CPUPPCState *env =3D &cpu->env;
> +    int amr =3D env->spr[SPR_AMR] >> 62; /* We only care about key0 AMR6=
3:62 */
> +    int iamr =3D env->spr[SPR_IAMR] >> 62; /* We only care about key0 IA=
MR63:62 */
> +
> +    return (amr & 0x2 ? 0 : PAGE_WRITE) | /* Access denied if bit is set=
 */
> +           (amr & 0x1 ? 0 : PAGE_READ) |
> +           (iamr & 0x1 ? 0 : PAGE_EXEC);
> +}
> +
>  static bool ppc_radix64_check_prot(PowerPCCPU *cpu, MMUAccessType access=
_type,
>                                     uint64_t pte, int *fault_cause, int *=
prot,
>                                     int mmu_idx, bool partition_scoped)
> diff --git a/target/ppc/mmu-radix64.h b/target/ppc/mmu-radix64.h
> index c5c04a1527..6620b3d648 100644
> --- a/target/ppc/mmu-radix64.h
> +++ b/target/ppc/mmu-radix64.h
> @@ -3,7 +3,7 @@
> =20
>  #ifndef CONFIG_USER_ONLY
> =20
> -#include "exec/page-protection.h"
> +#ifdef TARGET_PPC64
> =20
>  /* Radix Quadrants */
>  #define R_EADDR_MASK            0x3FFFFFFFFFFFFFFF
> @@ -14,61 +14,10 @@
>  #define R_EADDR_QUADRANT2       0x8000000000000000
>  #define R_EADDR_QUADRANT3       0xC000000000000000
> =20
> -/* Radix Partition Table Entry Fields */
> -#define PATE1_R_PRTB           0x0FFFFFFFFFFFF000
> -#define PATE1_R_PRTS           0x000000000000001F
> -
> -/* Radix Process Table Entry Fields */
> -#define PRTBE_R_GET_RTS(rts) \
> -    ((((rts >> 58) & 0x18) | ((rts >> 5) & 0x7)) + 31)
> -#define PRTBE_R_RPDB            0x0FFFFFFFFFFFFF00
> -#define PRTBE_R_RPDS            0x000000000000001F
> -
> -/* Radix Page Directory/Table Entry Fields */
> -#define R_PTE_VALID             0x8000000000000000
> -#define R_PTE_LEAF              0x4000000000000000
> -#define R_PTE_SW0               0x2000000000000000
> -#define R_PTE_RPN               0x01FFFFFFFFFFF000
> -#define R_PTE_SW1               0x0000000000000E00
> -#define R_GET_SW(sw)            (((sw >> 58) & 0x8) | ((sw >> 9) & 0x7))
> -#define R_PTE_R                 0x0000000000000100
> -#define R_PTE_C                 0x0000000000000080
> -#define R_PTE_ATT               0x0000000000000030
> -#define R_PTE_ATT_NORMAL        0x0000000000000000
> -#define R_PTE_ATT_SAO           0x0000000000000010
> -#define R_PTE_ATT_NI_IO         0x0000000000000020
> -#define R_PTE_ATT_TOLERANT_IO   0x0000000000000030
> -#define R_PTE_EAA_PRIV          0x0000000000000008
> -#define R_PTE_EAA_R             0x0000000000000004
> -#define R_PTE_EAA_RW            0x0000000000000002
> -#define R_PTE_EAA_X             0x0000000000000001
> -#define R_PDE_NLB               PRTBE_R_RPDB
> -#define R_PDE_NLS               PRTBE_R_RPDS
> -
> -#ifdef TARGET_PPC64
> -
>  bool ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType acces=
s_type,
>                         hwaddr *raddr, int *psizep, int *protp, int mmu_i=
dx,
>                         bool guest_visible);
> =20
> -static inline int ppc_radix64_get_prot_eaa(uint64_t pte)
> -{
> -    return (pte & R_PTE_EAA_R ? PAGE_READ : 0) |
> -           (pte & R_PTE_EAA_RW ? PAGE_READ | PAGE_WRITE : 0) |
> -           (pte & R_PTE_EAA_X ? PAGE_EXEC : 0);
> -}
> -
> -static inline int ppc_radix64_get_prot_amr(const PowerPCCPU *cpu)
> -{
> -    const CPUPPCState *env =3D &cpu->env;
> -    int amr =3D env->spr[SPR_AMR] >> 62; /* We only care about key0 AMR6=
3:62 */
> -    int iamr =3D env->spr[SPR_IAMR] >> 62; /* We only care about key0 IA=
MR63:62 */
> -
> -    return (amr & 0x2 ? 0 : PAGE_WRITE) | /* Access denied if bit is set=
 */
> -           (amr & 0x1 ? 0 : PAGE_READ) |
> -           (iamr & 0x1 ? 0 : PAGE_EXEC);
> -}
> -
>  #endif /* TARGET_PPC64 */
> =20
>  #endif /* CONFIG_USER_ONLY */


