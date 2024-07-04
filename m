Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFA7C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFZF-0007MY-Ua; Thu, 04 Jul 2024 02:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFZE-0007Lu-KX; Thu, 04 Jul 2024 02:03:40 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFZC-0003Sr-Vh; Thu, 04 Jul 2024 02:03:40 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70b03ffbb3aso32258b3a.0; 
 Wed, 03 Jul 2024 23:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720073016; x=1720677816; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxGgsi1OylkVRUeaDXjiAR6xLQSDHDQBOi/tBKGkzfU=;
 b=MODVG/ulDL20EgGpdAWBgk4aYfdNva+IvbIA6try80oZ6GxN8je35n3P9eBOMk5BXF
 8z5Z6k3V27391fnXLX7JbINW3hW76Xgdcwu26H148gHNo4MTmmaZUb3Ur97nCOU3MM1d
 2+q8MIbfKETa/R0FgRz6zg+s9BAWigJYrGAFiTOlqzczq/KYYE3aV9ecOGidQipCG7lY
 rGBGHm9uQhs5qMKVcPZbbjUVGq8GdgBoCMXtXgVoYNm12RTrpkTDGCrlALYNoJSxJy6P
 lTuFM4tllenIeEry9hu25mYZMR3rLYBwlRk0PN6v6Ig5feVTclecSEZCHdeRakw79z8M
 NGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720073016; x=1720677816;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mxGgsi1OylkVRUeaDXjiAR6xLQSDHDQBOi/tBKGkzfU=;
 b=t9kj7bFKtP0PYVKioYW/CAEOZnVl2yNsjLzhqhqHwPCoxFWqKpezJ/bqI36h0x/SZz
 U+b0tCxSF4PHqBGyfRoAtlRN4I1HsAWwzpLIDO/KezSDc4THLu4e2/S5IWsNT+CzPdqD
 2lSBTHcnDi27GtYip+Uux9l3vRggf2irtVJ9raJgp+oJlejl4QlMpkOBXc3KYG4Ic0Xn
 Kg/uH6Bd3hJFbxV7uhqlGRz9SyPK66snQTMqY+krhAsJeFi/s+2/+g+RQMH1PMUu5Nse
 o9jwy9JNurou92BUJxLG5txysI+7iGvsOB3QYq5wQJI4yNJNzeAxAtQViHctrcQMP6L6
 hRjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBvxRQUvFaA6dunqBanQbo4ezBPpQYDEHQ4hpdXnUnezSTtYxXjx9JGj6jCgHiLaEJFiU+esEHvMcN6S8wuJ/4Q50FNDlqfTtj/p0mxChJciqnudXEzYtVxA0=
X-Gm-Message-State: AOJu0YwCROUUQJYatLHXanwd7cmbD3RqDq4qppOCL6yUp4Q9r4m8/SZn
 erTol0tp6kRLidOLx/Tv84sgnSKFYdh/dpAjLTDaMndMfFkyUbQR
X-Google-Smtp-Source: AGHT+IHIqdN0F3Z3I6KvfljY+kP40hupil8VKEwIYAfprzoU74gNVEG3A/SiXuC/x4g8Wcw/abwsiw==
X-Received: by 2002:a05:6a20:7291:b0:1be:d745:66bc with SMTP id
 adf61e73a8af0-1c0cc877b66mr640660637.15.1720073016344; 
 Wed, 03 Jul 2024 23:03:36 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70803ed469fsm11453545b3a.111.2024.07.03.23.03.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 23:03:35 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:03:31 +1000
Message-Id: <D2GIZSONBKGW.2L3FO5O933FIF@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 10/43] target/ppc/mmu_common.c: Remove hash field from
 mmu_ctx_t
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <21fb0a89458b7d245d688abfdcf77492f674610a.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <21fb0a89458b7d245d688abfdcf77492f674610a.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

On Mon May 27, 2024 at 9:12 AM AEST, BALATON Zoltan wrote:
> Return hash value via a parameter and remove it from mmu_ctx.t.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mmu_common.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 0a07023f48..e3537c63c0 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -41,7 +41,6 @@
>  typedef struct {
>      hwaddr raddr;      /* Real address             */
>      int prot;          /* Protection bits          */
> -    hwaddr hash[2];    /* Pagetable hash values    */
>      target_ulong ptem; /* Virtual segment ID | API */
>      int key;           /* Access key               */
>      int nx;            /* Non-execute area         */
> @@ -331,7 +330,7 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_=
t *ctx,
>  }
> =20
>  static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
> -                                       target_ulong eaddr,
> +                                       target_ulong eaddr, hwaddr *hashp=
,
>                                         MMUAccessType access_type, int ty=
pe)
>  {
>      PowerPCCPU *cpu =3D env_archcpu(env);
> @@ -379,8 +378,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>          qemu_log_mask(CPU_LOG_MMU, "htab_base " HWADDR_FMT_plx " htab_ma=
sk "
>                        HWADDR_FMT_plx " hash " HWADDR_FMT_plx "\n",
>                        ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu)=
, hash);
> -        ctx->hash[0] =3D hash;
> -        ctx->hash[1] =3D ~hash;
> +        *hashp =3D hash;
> =20
>          /* Initialize real address with an invalid value */
>          ctx->raddr =3D (hwaddr)-1ULL;
> @@ -761,8 +759,8 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eadd=
r,
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
>      mmu_ctx_t ctx;
> -    int type;
> -    int ret;
> +    hwaddr hash =3D 0; /* init to 0 to avoid used uninit warning */
> +    int type, ret;
> =20
>      if (ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep, pro=
tp)) {
>          return true;
> @@ -779,9 +777,8 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eadd=
r,
>      }
> =20
>      ctx.prot =3D 0;
> -    ctx.hash[0] =3D 0;
> -    ctx.hash[1] =3D 0;
> -    ret =3D mmu6xx_get_physical_address(env, &ctx, eaddr, access_type, t=
ype);
> +    ret =3D mmu6xx_get_physical_address(env, &ctx, eaddr, &hash,
> +                                      access_type, type);
>      if (ret =3D=3D 0) {
>          *raddrp =3D ctx.raddr;
>          *protp =3D ctx.prot;
> @@ -834,9 +831,9 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eadd=
r,
>  tlb_miss:
>              env->error_code |=3D ctx.key << 19;
>              env->spr[SPR_HASH1] =3D ppc_hash32_hpt_base(cpu) +
> -                                  get_pteg_offset32(cpu, ctx.hash[0]);
> +                                  get_pteg_offset32(cpu, hash);
>              env->spr[SPR_HASH2] =3D ppc_hash32_hpt_base(cpu) +
> -                                  get_pteg_offset32(cpu, ctx.hash[1]);
> +                                  get_pteg_offset32(cpu, ~hash);
>              break;
>          case -2:
>              /* Access rights violation */


