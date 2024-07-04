Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9596C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFjr-0005Ku-6C; Thu, 04 Jul 2024 02:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFjp-0005GB-8s; Thu, 04 Jul 2024 02:14:37 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFjm-00048K-7D; Thu, 04 Jul 2024 02:14:36 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3815eaa136eso1322415ab.0; 
 Wed, 03 Jul 2024 23:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720073670; x=1720678470; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMdN9Iw/jjAqJoNPiqMzrB5IXm13kQB2KCgkpsBgDUw=;
 b=jmtUwFnbzo80hHgY0mOUMqpkcjM8YVRr7S+Ea3BSbhfqDrXmxB2aJAENoFDLppRWgq
 XKlVgh8/0KdATVMseVpzZg3lc7yrS2leDJWExbdgZVzLrxFllF+gm//NoNZwMQ93NvAK
 3SSwNLXHTfN6SX0AF+NkvGgo1yH8F6tSz8XSp1NHLU7KXLEjTeRm2o3pVO/0jBiqMoe5
 zILSWct5+EudAxqAnELIz9ZUm7cCdmHMpFH9h/B4Wr78gfW3UUg7iwyaGwKdFkSVRqKM
 l9jJNlzQi6siwNZI9gaiScr6QjZ1MkgIH6Aviw4DGYBxBXT9KrJqNjdsCXRiaHBkGQiR
 XUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720073670; x=1720678470;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BMdN9Iw/jjAqJoNPiqMzrB5IXm13kQB2KCgkpsBgDUw=;
 b=ovvHYw1Iqpusw+AXnjOP/D7H1IFYtTOoOD9KX0z9jcbF8AqBQAc49Ag+rNc6TgEP59
 DWvCf6UKwUm/H/rjLGEnSJ9NyS9Mk/U6O6hSLCrWPNyoRbmpEi+7oAYeaAOLEWraXekK
 t4LiutDpV86F36efdQ9St7KONG2K519ucblqkNLe9wCq1rp9J2klz1Hefru9YjKa1SK2
 WQw0jM8dQ1D9DGrSM51hIqY+1vnjsKB+x7Ur6c1jg1WDr9PFBeguxUU/b6rlk7upPe7/
 K93T5NA/5SeAsJTyGB+S3fAxf1Pf1e6FBlmhazHqYgIBO/T5ElcRd7Xpcm/8o/Hv9mWi
 YMDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDUl3WZp/yRPSnoHw5hTRJhCZGWqdRfT4MYr6tF7p1cQgS9Xgyi0fYJCjYMiqrQIhIjIZh75rmAk230jRPRd4lupP6DYpuAVcDPEnvBPIG+zPGu6jlPggCMRE=
X-Gm-Message-State: AOJu0YwQzwm50BgS/6c0gFnnPWTHlF+vjMOFRj9E/rjkBdUK57sb1OQR
 50xQ/HBDYaied7L6ti/xb7y9+EuWff2rAjCLo5c5BLaelGPLi/+2
X-Google-Smtp-Source: AGHT+IFTbKgH2rtU7qOsS33TpcW3MKizP7YHxGtZEvhiiX3e2ppi0sD9/OHRmvM2IidFu4T9ZTy2uA==
X-Received: by 2002:a05:6e02:1785:b0:375:efde:97a6 with SMTP id
 e9e14a558f8ab-38398cece8cmr9723545ab.7.1720073670278; 
 Wed, 03 Jul 2024 23:14:30 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6c7f723csm7643075a12.57.2024.07.03.23.14.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 23:14:29 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:14:24 +1000
Message-Id: <D2GJ84TPV12M.1YO4QGT9K26ZZ@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 12/43] target/ppc/mmu_common.c: Remove nx field from
 mmu_ctx_t
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <3235abe633100992ad1437879a9869f3fb9a8189.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <3235abe633100992ad1437879a9869f3fb9a8189.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x136.google.com
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
> Pass it as a parameter instead. Also use named constants instead of
> hex values when extracting bits from SR.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index c4902b7632..9f402a979d 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -43,7 +43,6 @@ typedef struct {
>      int prot;          /* Protection bits          */
>      target_ulong ptem; /* Virtual segment ID | API */
>      int key;           /* Access key               */
> -    int nx;            /* Non-execute area         */
>  } mmu_ctx_t;
> =20
>  void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
> @@ -94,7 +93,7 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong ea=
ddr,
> =20
>  static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
>                                  target_ulong pte1, int pteh,
> -                                MMUAccessType access_type)
> +                                MMUAccessType access_type, bool nx)
>  {
>      /* Check validity and table match */
>      if (!pte_is_valid(pte0) || ((pte0 >> 6) & 1) !=3D pteh ||
> @@ -109,7 +108,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, targe=
t_ulong pte0,
>      }
>      /* Keep the matching PTE information */
>      ctx->raddr =3D pte1;
> -    ctx->prot =3D ppc_hash32_prot(ctx->key, pte1 & HPTE32_R_PP, ctx->nx)=
;
> +    ctx->prot =3D ppc_hash32_prot(ctx->key, pte1 & HPTE32_R_PP, nx);
>      if (check_prot_access_type(ctx->prot, access_type)) {
>          qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
>          return 0;
> @@ -121,8 +120,9 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, targe=
t_ulong pte0,
> =20
>  /* Software driven TLB helpers */
> =20
> -static int ppc6xx_tlb_check(CPUPPCState *env, mmu_ctx_t *ctx,
> -                            target_ulong eaddr, MMUAccessType access_typ=
e)
> +static int ppc6xx_tlb_check(CPUPPCState *env,
> +                            mmu_ctx_t *ctx, target_ulong eaddr,
> +                            MMUAccessType access_type, bool nx)
>  {
>      ppc6xx_tlb_t *tlb;
>      target_ulong *pte1p;
> @@ -150,7 +150,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env, mmu_ctx=
_t *ctx,
>                        access_type =3D=3D MMU_DATA_STORE ? 'S' : 'L',
>                        access_type =3D=3D MMU_INST_FETCH ? 'I' : 'D');
>          switch (ppc6xx_tlb_pte_check(ctx, tlb->pte0, tlb->pte1,
> -                                     0, access_type)) {
> +                                     0, access_type, nx)) {
>          case -2:
>              /* Access violation */
>              ret =3D -2;
> @@ -322,7 +322,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>      hwaddr hash;
>      target_ulong vsid, sr, pgidx;
>      int ds, target_page_bits;
> -    bool pr;
> +    bool pr, nx;
> =20
>      /* First try to find a BAT entry if there are any */
>      if (env->nb_BATs && get_bat_6xx_tlb(env, ctx, eaddr, access_type) =
=3D=3D 0) {
> @@ -336,8 +336,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>      ctx->key =3D (((sr & 0x20000000) && pr) ||
>                  ((sr & 0x40000000) && !pr)) ? 1 : 0;
>      ds =3D sr & 0x80000000 ? 1 : 0;
> -    ctx->nx =3D sr & 0x10000000 ? 1 : 0;
> -    vsid =3D sr & 0x00FFFFFF;
> +    nx =3D sr & SR32_NX;
> +    vsid =3D sr & SR32_VSID;
>      target_page_bits =3D TARGET_PAGE_BITS;
>      qemu_log_mask(CPU_LOG_MMU,
>                    "Check segment v=3D" TARGET_FMT_lx " %d " TARGET_FMT_l=
x
> @@ -352,10 +352,10 @@ static int mmu6xx_get_physical_address(CPUPPCState =
*env, mmu_ctx_t *ctx,
>      ctx->ptem =3D (vsid << 7) | (pgidx >> 10);
> =20
>      qemu_log_mask(CPU_LOG_MMU, "pte segment: key=3D%d ds %d nx %d vsid "
> -                  TARGET_FMT_lx "\n", ctx->key, ds, ctx->nx, vsid);
> +                  TARGET_FMT_lx "\n", ctx->key, ds, nx, vsid);

This could be !!nx for consistency.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>      if (!ds) {
>          /* Check if instruction fetch is allowed, if needed */
> -        if (type =3D=3D ACCESS_CODE && ctx->nx) {
> +        if (type =3D=3D ACCESS_CODE && nx) {
>              qemu_log_mask(CPU_LOG_MMU, "No access allowed\n");
>              return -3;
>          }
> @@ -368,7 +368,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>          /* Initialize real address with an invalid value */
>          ctx->raddr =3D (hwaddr)-1ULL;
>          /* Software TLB search */
> -        return ppc6xx_tlb_check(env, ctx, eaddr, access_type);
> +        return ppc6xx_tlb_check(env, ctx, eaddr, access_type, nx);
>      }
> =20
>      /* Direct-store segment : absolutely *BUGGY* for now */


