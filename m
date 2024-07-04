Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55055C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPG1o-000592-DJ; Thu, 04 Jul 2024 02:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPG1k-0004yV-TS; Thu, 04 Jul 2024 02:33:08 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPG1h-0006kU-Mj; Thu, 04 Jul 2024 02:33:07 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-70df2135426so155861a12.2; 
 Wed, 03 Jul 2024 23:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720074781; x=1720679581; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6pW4IVJ3VX7HsHjeIdWQNmZStem/CMD0/GtV2HTSZTY=;
 b=LF2C4mtVzcX+Q7ogh1g2ruu3hS6xY4whVH2g7ZQvVaXHUL6ieIZdFwLXyWkt8HDzRR
 qE5RngSdxVXV4iI+rQwTMm/VKdbRPGlfQm2EF+mLlMADONpxMqiNpoNTqhRwtWip7LGc
 ssY/3wXUAlOJt2EeIhdT7+WOzQ8uBs3THKbYMMInnWhOZbm+RH1gC249SrRGQDKmKm1I
 DXnwXpIcaGSPQ83P5SrqSCIOOdECowK9+2N+64I8dhgmUsLku9JdU2KLCIIkgfUSFkli
 DouUsv5663nHL52lMExSHfZQSQLz7J7dliJOxLM1nizS10vI698lVq1kXR/kKS4t/+bx
 +Cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720074781; x=1720679581;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6pW4IVJ3VX7HsHjeIdWQNmZStem/CMD0/GtV2HTSZTY=;
 b=jlfZhafkvLpLKvqynP0mx/0zHB9EyzAQPlfqI/oLh4aTmrcvT8RaF2LgZ6VJ1xQV0b
 m8yYP6rKmXFaVQ1VzZIqOjTb7Wn3Mx8sGatsSf42pvRYDg9IFJPJXIb+niGu9izKCKnL
 2ADb3tmFBUmt0zm0FYJ/cZ6e+cP8ND+EDBgcLmphFnXWjsCF2l3aMgyKl2rVQsSSDAgU
 iGG3yU3G2tEvHv1LQO2YBF1nu65xSWB2GlsHnxt7mv5YEyv5f7TIjgjQ+1SiwV4rbHnn
 QHcEgdZFYFzh9NBpJ+c58YiB6tv71ecKjpHC6Iu4KwTEVaIdjgxXaROqB3xogFm+kNT5
 TlQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVvoRDc9NaIWA40mPKo52mjj5jl77EjVJDynGDbcL6oOofpkBRdQyXUZ/20KoF+gOM0XG1zZcmowjC9bYCB8sVbSxHwictkpOkARItih8Cm5tDyc9Db0uYN7I=
X-Gm-Message-State: AOJu0YwkCp9HeDavsWGwDPDRqtPaiZb2N6FtIU9BnYpAOp0ETO/sIpvu
 6PA+hwiOfcfbWU1oITnzqQLDiD392mQrWOvhbc0o7jKsjiUqHOH/C5fMpA==
X-Google-Smtp-Source: AGHT+IEhbT1lpEBwqzRqeOYwgeoah+I5sM6qxQfzFkSSLm6Ww3XrwSknE6DNWccTDeEi1hTnM9MxfQ==
X-Received: by 2002:a05:6a20:12c2:b0:1b7:4f5a:8d27 with SMTP id
 adf61e73a8af0-1c0cc8eff2emr628023637.56.1720074780843; 
 Wed, 03 Jul 2024 23:33:00 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10c6c57sm114571755ad.53.2024.07.03.23.32.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 23:33:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:32:55 +1000
Message-Id: <D2GJMBA6A7HV.3H5SSP17PXY32@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 23/43] target/ppc/mmu_common.c: Rename function parameter
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <f09e49e0e0e400e67ac0c61164ca3937ee8cc335.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <f09e49e0e0e400e67ac0c61164ca3937ee8cc335.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
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
> Rename parameter of get_bat_6xx_tlb() from virtual to eaddr to match
> other functions.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index ede409eb99..110936ca83 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -221,7 +221,7 @@ static inline void bat_size_prot(CPUPPCState *env, ta=
rget_ulong *blp,
>  }
> =20
>  static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
> -                           target_ulong virtual, MMUAccessType access_ty=
pe)
> +                           target_ulong eaddr, MMUAccessType access_type=
)
>  {
>      target_ulong *BATlt, *BATut, *BATu, *BATl;
>      target_ulong BEPIl, BEPIu, bl;
> @@ -230,7 +230,7 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_=
t *ctx,
>      bool ifetch =3D access_type =3D=3D MMU_INST_FETCH;
> =20
>      qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT v " TARGET_FMT_lx "\n", __func=
__,
> -                  ifetch ? 'I' : 'D', virtual);
> +                  ifetch ? 'I' : 'D', eaddr);
>      if (ifetch) {
>          BATlt =3D env->IBAT[1];
>          BATut =3D env->IBAT[0];
> @@ -246,15 +246,15 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ct=
x_t *ctx,
>          bat_size_prot(env, &bl, &valid, &prot, BATu, BATl);
>          qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_lx " BATu=
 "
>                        TARGET_FMT_lx " BATl " TARGET_FMT_lx "\n", __func_=
_,
> -                      ifetch ? 'I' : 'D', i, virtual, *BATu, *BATl);
> -        if ((virtual & 0xF0000000) =3D=3D BEPIu &&
> -            ((virtual & 0x0FFE0000) & ~bl) =3D=3D BEPIl) {
> +                      ifetch ? 'I' : 'D', i, eaddr, *BATu, *BATl);
> +        if ((eaddr & 0xF0000000) =3D=3D BEPIu &&
> +            ((eaddr & 0x0FFE0000) & ~bl) =3D=3D BEPIl) {
>              /* BAT matches */
>              if (valid !=3D 0) {
>                  /* Get physical address */
>                  ctx->raddr =3D (*BATl & 0xF0000000) |
> -                    ((virtual & 0x0FFE0000 & bl) | (*BATl & 0x0FFE0000))=
 |
> -                    (virtual & 0x0001F000);
> +                    ((eaddr & 0x0FFE0000 & bl) | (*BATl & 0x0FFE0000)) |
> +                    (eaddr & 0x0001F000);
>                  /* Compute access rights */
>                  ctx->prot =3D prot;
>                  if (check_prot_access_type(ctx->prot, access_type)) {
> @@ -273,7 +273,7 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_=
t *ctx,
>      if (ret < 0) {
>          if (qemu_log_enabled()) {
>              qemu_log_mask(CPU_LOG_MMU, "no BAT match for "
> -                          TARGET_FMT_lx ":\n", virtual);
> +                          TARGET_FMT_lx ":\n", eaddr);
>              for (i =3D 0; i < 4; i++) {
>                  BATu =3D &BATut[i];
>                  BATl =3D &BATlt[i];
> @@ -284,7 +284,7 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_=
t *ctx,
>                                " BATu " TARGET_FMT_lx " BATl " TARGET_FMT=
_lx
>                                "\n\t" TARGET_FMT_lx " " TARGET_FMT_lx " "
>                                TARGET_FMT_lx "\n", __func__, ifetch ? 'I'=
 : 'D',
> -                              i, virtual, *BATu, *BATl, BEPIu, BEPIl, bl=
);
> +                              i, eaddr, *BATu, *BATl, BEPIu, BEPIl, bl);
>              }
>          }
>      }


