Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80386C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IMi-0007Q1-A4; Tue, 07 May 2024 06:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4IMY-0007Mj-2X; Tue, 07 May 2024 06:48:01 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4IMW-0007Hf-Cl; Tue, 07 May 2024 06:47:57 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f472d550cbso1571505b3a.1; 
 Tue, 07 May 2024 03:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715078874; x=1715683674; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXPuDO8eerefpnKg6j5mA/qsoRo+G3ccj32oYA7s1SM=;
 b=nV0n+X1pKUoUJoHHCSmR9owbW1Q42b853hNAHCdwM8OmvNQ8wnhN0fCfwiZtzJGC45
 SaULhWp1FpfbqRwLggBmIFa2YkACBSNtRTkbNA0D19FpZTWTGokddyKDF9n2g1Pdctvs
 TdH83it3sLXErJ7RGTUqyaS6qZJ1AOkIo1pEB9VOvC9/albp4XLvvOtmMvxg9SQ1ZQBX
 jVeCYsVFher6wRpOCvfU9TKWtlygR8HD6JUSqwWVyqazMBQKkQdy0LY0WL4Rx5fSH803
 Tru116eKe7axJAvZgUk8YGKqFS5mPYKGrVCUTKHDs7NQ3Qr2oLrsIBm25gnIraAiwI+j
 O8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715078874; x=1715683674;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NXPuDO8eerefpnKg6j5mA/qsoRo+G3ccj32oYA7s1SM=;
 b=PCuRZAIWJ76cZuZOYzIVqI1YyVeQJ6Eql6s6qhZz4WudHRXhB4uw9wXqTSNUCZIhYm
 AXF6aO8ByL7A0/FeIgamzEBMQ9ny7ug9JDQQEPwF4hWWl7m6Z2oNMlilXfDXOiWaTFt9
 0wxA0NNG55arIMMdQ9AYxmr9EcAuwyRrFpzPYKEKPZgNiuskp6dkJ7wwBRiQHUvQvyUu
 w5RUnVFUbNGQbDCTCRi3wBjjLVIg/ZnVxSY+MyLL7jEfkgMPOfd8qvcpkih8YDcJLLPZ
 vLx9dX5oJJdkTkiwWyRl7UzUKFfTvui8l8H2ZOiunMST2e0nDdCOYl7e1D3Z9jRGepNG
 Yuzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeeB+Lb8CoB7oDIrE1O8TEI7dIdmPJXMvuDqscw6yYtaOHonFtwHgyAzMmHmE/gQBnM4dUBurwUesKMgxleUhi+5TEB5KTcfjd7USxnQS7bv2Yn/TC+AoYCmM=
X-Gm-Message-State: AOJu0YzVAGh/xPMjT5/mrt0Axfeys0LcjbZHLglYzx7dfxYYh/dKihVE
 AUkQtI4llF/JmwRnGg4ZjOBhPnKGINOHaQgZ6OYbvtamciiS2pU+ZY3ttw==
X-Google-Smtp-Source: AGHT+IHOX87GtvBUz25vO+ZyL2M2eADxsKFg/1NCet5aAtcO/HXu5A7VLGWOEb088uGzxowBBXONaQ==
X-Received: by 2002:a05:6a00:9393:b0:6f3:e6d6:7fde with SMTP id
 ka19-20020a056a00939300b006f3e6d67fdemr17292149pfb.26.1715078874297; 
 Tue, 07 May 2024 03:47:54 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a63d405000000b0060c5179a0a5sm9525446pgh.50.2024.05.07.03.47.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 03:47:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 20:47:49 +1000
Message-Id: <D13CPVTK824I.8DR4MRXLJRPB@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 20/28] target/ppc/mmu_common.c: Make
 get_physical_address_wtlb() static
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <55ea002eb081fd1fdc6ff6f0e3f25ba892044e9d.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <55ea002eb081fd1fdc6ff6f0e3f25ba892044e9d.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
> This function is not used from any other files so make it static and
> fix the maybe used uninitialised warnings this has uncovered.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/internal.h   | 5 +----
>  target/ppc/mmu_common.c | 5 ++++-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 601c0b533f..7a99f08dc8 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -261,10 +261,7 @@ typedef struct mmu_ctx_t mmu_ctx_t;
>  bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>                        hwaddr *raddrp, int *psizep, int *protp,
>                        int mmu_idx, bool guest_visible);
> -int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
> -                                     target_ulong eaddr,
> -                                     MMUAccessType access_type, int type=
,
> -                                     int mmu_idx);
> +
>  /* Software driven TLB helpers */
>  int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
>                                      int way, int is_code);
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 762b13805b..4852cb5571 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -666,6 +666,7 @@ static int mmubooke_get_physical_address(CPUPPCState =
*env, mmu_ctx_t *ctx,
>      hwaddr raddr =3D (hwaddr)-1ULL;
>      int i, ret =3D -1;
> =20
> +    ctx->prot =3D 0;
>      for (i =3D 0; i < env->nb_tlb; i++) {
>          tlb =3D &env->tlb.tlbe[i];
>          ret =3D mmubooke_check_tlb(env, tlb, &raddr, &ctx->prot, address=
,
> @@ -873,6 +874,7 @@ static int mmubooke206_get_physical_address(CPUPPCSta=
te *env, mmu_ctx_t *ctx,
>      hwaddr raddr =3D (hwaddr)-1ULL;
>      int i, j, ways, ret =3D -1;
> =20
> +    ctx->prot =3D 0;
>      for (i =3D 0; i < BOOKE206_MAX_TLBN; i++) {
>          ways =3D booke206_tlb_ways(env, i);
>          for (j =3D 0; j < ways; j++) {

The prot warnings are valid AFAIKS, used uninit by qemu_log_mask call.

So, I see what the booke _check_tlb() functions are doing with
*prot now and that is to assign it iff return value is 0 or -2 or
-3, matching TLB address (and possibly mismatch prot).

Would it be better to fix it as:

    qemu_log_mask(CPU_LOG_MMU,
                  "%s: access %s " TARGET_FMT_lx " =3D> " HWADDR_FMT_plx
                  " %d %d\n", __func__, ret < 0 ? "refused" : "granted",
                  address, raddr, ret =3D=3D -1 ? 0 : ctx->prot, ret);

This way it's clearer that we're only printing it when a TLB was
found, and it won't silence other possible use-uninitialised?

> @@ -1144,7 +1146,7 @@ void dump_mmu(CPUPPCState *env)
>      }
>  }
> =20
> -int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
> +static int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
>                                       target_ulong eaddr,
>                                       MMUAccessType access_type, int type=
,
>                                       int mmu_idx)
> @@ -1163,6 +1165,7 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu=
_ctx_t *ctx,
>      if (real_mode && (env->mmu_model =3D=3D POWERPC_MMU_SOFT_6xx ||
>                        env->mmu_model =3D=3D POWERPC_MMU_SOFT_4xx ||
>                        env->mmu_model =3D=3D POWERPC_MMU_REAL)) {
> +        memset(ctx, 0, sizeof(*ctx));
>          ctx->raddr =3D eaddr;
>          ctx->prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>          return 0;

I wonder why the compiler doesn't see these, they are all in the return
not-zero cases that should be quite visible?

What if you leave the static change to the end of your series, do the
simplifications allow the compiler to work it out? I prefer not to
squash such compiler warnings if it can be avoided.

Thanks,
Nick

