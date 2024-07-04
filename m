Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97658C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFwW-0000gG-0F; Thu, 04 Jul 2024 02:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFwU-0000du-Fc; Thu, 04 Jul 2024 02:27:42 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFwL-000410-80; Thu, 04 Jul 2024 02:27:42 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7201cb6cae1so154775a12.2; 
 Wed, 03 Jul 2024 23:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720074450; x=1720679250; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8v1sM/8UBJZymI3Xrg+3t9HNx/rOzvi6EiUf1Hfsub0=;
 b=K2CekdBfsk55t9qdnPE4FzETtqMHAktxGV48AVMi9/R6vj2LzdUVx/qwLfve2TBocd
 pZCPnZPFiEjvQTWdQrc+DNtEu6/EFWlYBp0R2tsvHWXdtJxVz61kkfc/mfp4yEjQ9H9N
 fENx2CeZE5RYo2G+PbpgPxr2meCOWHIQqtnlUj0ZI0FKjJ2Py3wM2kMtmBIYo5YaFOjF
 lBopTPgbizzrf63N9eNeRRxDkyZ8ZUWuyl1c91KY54PNsTTgx0OTGWnpWcTLL8AMRALc
 9t5dV6sV4tz5GyRK+uXWQJbyZjmTt7qYHV7kh78/eCEOnoO9HF2wS4DKSjTORzCMwZCn
 87aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720074450; x=1720679250;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8v1sM/8UBJZymI3Xrg+3t9HNx/rOzvi6EiUf1Hfsub0=;
 b=rroFV2nqQzu/kAJQYAZqMCHlHPjM6dbAyW1kvupXAZxIuK6zGWE6uTweyy516vKf5h
 uFsMuoM1rCu50zkHSlgaVWF8f8haUuYVq8WkZF/wUW7Fhx+zYUEqT2mp/MMH6f2WhREj
 Qc5ELyeQC2KzxDg7nK3CgFEyzsApnvCxsX3qpppNQvvJfB+VpsfynZEpYqexBoER7j2s
 LAf81jw4mTbriDKFp/tWSzAeeM/b4bu5ZPYMcXiZ1MAjNzTsdiV4R8bat9uTiqJBUl1D
 IFYRh017edBsCBp4SXF53tGUjdr3gWXkUiFBCr9w4HKUVIt//e7x+IKmzT1NYkrrCEac
 y8Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNhJfzbIYHHFepk9I4uwvoeZiGBgLdHwBjz81dSkrlrYkUFyMFIrv57fomK8FrprgOHvIoP/Vo6mudR2PdM/tmYNmEZx1t+OYta/iix3tS1JQsYoABCZPfOHk=
X-Gm-Message-State: AOJu0Yx5dURk8giS+/zkhQcFisK1qfinR/5nN53bm2sFLAl7dMq++BXs
 JWbTedxI/fFOzpvfUdC9FFqcKnIlW99u0rAzzk07xi/eZibrWSVJBLOSPQ==
X-Google-Smtp-Source: AGHT+IEcBsoWs9nU+yRdwADvE6X/GvugDD4CQUq1Leww83BsYQaxqu5KeY3M/yImNe5P5GLhvgJZ/g==
X-Received: by 2002:a05:6a20:8401:b0:1be:ccea:41ea with SMTP id
 adf61e73a8af0-1c0cc8baaf5mr596371637.49.1720074450149; 
 Wed, 03 Jul 2024 23:27:30 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99a989405sm652983a91.27.2024.07.03.23.27.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 23:27:29 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:27:24 +1000
Message-Id: <D2GJI33WWBJ0.3K03ENUYHPN4A@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 18/43] target/ppc: Add function to get protection key
 for hash32 MMU
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <1fb34b3d81b3301bcc8febde9c8b40e3760b02c0.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <1fb34b3d81b3301bcc8febde9c8b40e3760b02c0.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Mon May 27, 2024 at 9:12 AM AEST, BALATON Zoltan wrote:
> Add a function to get key bit from SR and use it instead of open coded
> version.
>

Nice.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu-hash32.c | 9 ++++++---
>  target/ppc/mmu-hash32.h | 5 +++++
>  target/ppc/mmu_common.c | 3 +--
>  3 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 8a446c8a7d..93559447ff 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -42,7 +42,7 @@ static int ppc_hash32_pte_prot(int mmu_idx,
>  {
>      unsigned pp, key;
> =20
> -    key =3D !!(mmuidx_pr(mmu_idx) ? (sr & SR32_KP) : (sr & SR32_KS));
> +    key =3D ppc_hash32_key(mmuidx_pr(mmu_idx), sr);
>      pp =3D pte.pte1 & HPTE32_R_PP;
> =20
>      return ppc_hash32_prot(key, pp, !!(sr & SR32_NX));
> @@ -145,7 +145,6 @@ static bool ppc_hash32_direct_store(PowerPCCPU *cpu, =
target_ulong sr,
>  {
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> -    int key =3D !!(mmuidx_pr(mmu_idx) ? (sr & SR32_KP) : (sr & SR32_KS))=
;
> =20
>      qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
> =20
> @@ -206,7 +205,11 @@ static bool ppc_hash32_direct_store(PowerPCCPU *cpu,=
 target_ulong sr,
>          cpu_abort(cs, "ERROR: insn should not need address translation\n=
");
>      }
> =20
> -    *prot =3D key ? PAGE_READ | PAGE_WRITE : PAGE_READ;
> +    if (ppc_hash32_key(mmuidx_pr(mmu_idx), sr)) {
> +        *prot =3D PAGE_READ | PAGE_WRITE;
> +    } else {
> +        *prot =3D PAGE_READ;
> +    }
>      if (check_prot_access_type(*prot, access_type)) {
>          *raddr =3D eaddr;
>          return true;
> diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
> index bc4eedbecc..5902cf8333 100644
> --- a/target/ppc/mmu-hash32.h
> +++ b/target/ppc/mmu-hash32.h
> @@ -102,6 +102,11 @@ static inline void ppc_hash32_store_hpte1(PowerPCCPU=
 *cpu,
>      stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, pte=
1);
>  }
> =20
> +static inline bool ppc_hash32_key(bool pr, target_ulong sr)
> +{
> +    return pr ? (sr & SR32_KP) : (sr & SR32_KS);
> +}
> +
>  static inline int ppc_hash32_prot(bool key, int pp, bool nx)
>  {
>      int prot;
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 339df377e8..1ed2f45ac7 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -310,8 +310,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>      pr =3D FIELD_EX64(env->msr, MSR, PR);
> =20
>      sr =3D env->sr[eaddr >> 28];
> -    ctx->key =3D (((sr & 0x20000000) && pr) ||
> -                ((sr & 0x40000000) && !pr)) ? 1 : 0;
> +    ctx->key =3D ppc_hash32_key(pr, sr);
>      ds =3D sr & SR32_T;
>      nx =3D sr & SR32_NX;
>      vsid =3D sr & SR32_VSID;


