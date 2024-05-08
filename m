Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4D0C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gse-0001Pf-53; Wed, 08 May 2024 08:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gsb-0001Oc-Gt; Wed, 08 May 2024 08:58:41 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gsZ-0004Uk-JO; Wed, 08 May 2024 08:58:41 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2b3c711dfd3so3331972a91.2; 
 Wed, 08 May 2024 05:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715173118; x=1715777918; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SnS0TPoxYOeZtdGUnATOlFKk6AxDQ1lpQMHgXYCINPk=;
 b=SXBVFGSl8gae8v5GhVfpOsLRtLxWrzyXryl84GG4xhiQECy+ZD+GlPphC2AqHieldn
 RU/dm6uw3f4LLVYmKmaGAZ224aGUtjHiuMtvpf0t7/YWcFG3xTfzrJb3FhvbMX4vGj29
 FYiEeUYafJEqzmrleXSAnbUpM8+feQ3WiyOjN6XJc595NMUqPMzuewFyunXOUZ7jxYeK
 BdkTOpYhLwvTGOfVhbQM8ZEEXyXIAYeb4Z201PavM2n0XtD0AtotvrGBcR6NmHqSnAN+
 KqnmqI38JF1afGgnuZK+d7G5S12glNozZL+3eXATlLOiDKp9kFlUVJIMr0FQZMSyuHiN
 8iYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715173118; x=1715777918;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SnS0TPoxYOeZtdGUnATOlFKk6AxDQ1lpQMHgXYCINPk=;
 b=tN0RATYnifeyif97Kkx3cPGimelCf9aGv3mE3e2xinoQjfPsiT1mGgI/Y/n3EMSXD+
 zcuPTGAYmblUum+Z+DrIEkCZ9anA4rTL5Nld8R5CMLWyS4jnSFvnCsMenmZYdu2/iTEH
 bjTVJ+IsNtrvsJPW+icw/lWIWdqcQjnJq2qdeNFqG13rE252nOF0kkudnowzygYAJtoD
 +rwup4dEuta4RJOpIF4pOH4Tz/XScr3V/RMcC4z9EXPVsiqZLRvtFydyZWsdde8DMRSZ
 KbQMNYjvq+abgSaCwBHvqY2DA4uPesm4KFzbgs8bcIIJnhvJPrsJcR8wUVOwuWdn6cH0
 1Fag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfhE6LiKaCY9jei75FBfa9Sw61gjNMjuBc5tVF6rhJv/Jk+I/b9o2yZ3DnA/F/6PHO2Li+H7tFKzcivpQgSLGjzmCQEgY+e1+EmKJR5PFvtk7mCu+r0e0ajC4=
X-Gm-Message-State: AOJu0YyPD3yQMFzQYbdYSfhFDEZ54E7EmvRznXCNcs0ZQtOuDx7YgO7Q
 T+oOldEzTcOZnRFwwcwRytrAIopHc6J8Np9a5u399oy1VJ5XulfwlRuvow==
X-Google-Smtp-Source: AGHT+IF9VO0OXgvWL+iNXJU9aLdtJ7w7j3BRG0smx7THFE4tBzUYaHIR9blfmjsUGKBcGbmLftpDbQ==
X-Received: by 2002:a17:90a:885:b0:2b5:fcf8:6e43 with SMTP id
 98e67ed59e1d1-2b6169e1eebmr2483404a91.38.1715173117753; 
 Wed, 08 May 2024 05:58:37 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ca53c3sm1348853a91.46.2024.05.08.05.58.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 05:58:37 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 22:58:32 +1000
Message-Id: <D14A4I716QEF.165UUHJMDA041@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 21/33] target/ppc/mmu_common.c: Make
 get_physical_address_wtlb() static
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <4f102d70464882b99b812092d3a65d6c867a0d2d.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <4f102d70464882b99b812092d3a65d6c867a0d2d.1715125376.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
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
> This function is not used from any other files so make it static and
> fix the maybe used uninitialised warnings this has uncovered. Also
> remove mmu_ctx_t definition from internal.h as this type is only used
> within this file.

If you add a /* quiet used uninitialized warning */ or similar comment
on the memset then.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

If you respin you could, put the prot fixes as their own patch but
pretty minor thing if you can't be bothered.

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/internal.h   | 17 +----------------
>  target/ppc/mmu_common.c | 18 +++++++++++++++---
>  2 files changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 98b41a970c..4a90dd2584 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -257,28 +257,13 @@ static inline int prot_for_access_type(MMUAccessTyp=
e access_type)
> =20
>  /* PowerPC MMU emulation */
> =20
> -typedef struct mmu_ctx_t mmu_ctx_t;
> -
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
> -/* Context used internally during MMU translations */
> -struct mmu_ctx_t {
> -    hwaddr raddr;      /* Real address              */
> -    hwaddr eaddr;      /* Effective address         */
> -    int prot;                      /* Protection bits           */
> -    hwaddr hash[2];    /* Pagetable hash values     */
> -    target_ulong ptem;             /* Virtual segment ID | API  */
> -    int key;                       /* Access key                */
> -    int nx;                        /* Non-execute area          */
> -};
> =20
>  #endif /* !CONFIG_USER_ONLY */
> =20
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 63b5fb98d1..d92c9607b8 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -36,6 +36,17 @@
> =20
>  /* #define DUMP_PAGE_TABLES */
> =20
> +/* Context used internally during MMU translations */
> +typedef struct {
> +    hwaddr raddr;      /* Real address             */
> +    hwaddr eaddr;      /* Effective address        */
> +    int prot;          /* Protection bits          */
> +    hwaddr hash[2];    /* Pagetable hash values    */
> +    target_ulong ptem; /* Virtual segment ID | API */
> +    int key;           /* Access key               */
> +    int nx;            /* Non-execute area         */
> +} mmu_ctx_t;
> +
>  void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
>  {
>      PowerPCCPU *cpu =3D env_archcpu(env);
> @@ -667,7 +678,7 @@ static int mmubooke_get_physical_address(CPUPPCState =
*env, mmu_ctx_t *ctx,
>      qemu_log_mask(CPU_LOG_MMU,
>                    "%s: access %s " TARGET_FMT_lx " =3D> " HWADDR_FMT_plx
>                    " %d %d\n", __func__, ret < 0 ? "refused" : "granted",
> -                  address, raddr, ctx->prot, ret);
> +                  address, raddr, ret =3D=3D -1 ? 0 : ctx->prot, ret);
>      return ret;
>  }
> =20
> @@ -883,7 +894,7 @@ found_tlb:
>      qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " =3D> "
>                    HWADDR_FMT_plx " %d %d\n", __func__,
>                    ret < 0 ? "refused" : "granted", address, raddr,
> -                  ctx->prot, ret);
> +                  ret =3D=3D -1 ? 0 : ctx->prot, ret);
>      return ret;
>  }
> =20
> @@ -1131,7 +1142,7 @@ void dump_mmu(CPUPPCState *env)
>      }
>  }
> =20
> -int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
> +static int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
>                                       target_ulong eaddr,
>                                       MMUAccessType access_type, int type=
,
>                                       int mmu_idx)
> @@ -1150,6 +1161,7 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu=
_ctx_t *ctx,
>      if (real_mode && (env->mmu_model =3D=3D POWERPC_MMU_SOFT_6xx ||
>                        env->mmu_model =3D=3D POWERPC_MMU_SOFT_4xx ||
>                        env->mmu_model =3D=3D POWERPC_MMU_REAL)) {
> +        memset(ctx, 0, sizeof(*ctx));
>          ctx->raddr =3D eaddr;
>          ctx->prot =3D PAGE_RWX;
>          return 0;


