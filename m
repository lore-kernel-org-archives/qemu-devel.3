Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BDDC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPG2y-00072f-PX; Thu, 04 Jul 2024 02:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPG2w-00072H-1B; Thu, 04 Jul 2024 02:34:22 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPG2u-0006xd-Bp; Thu, 04 Jul 2024 02:34:21 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f9de13d6baso1696755ad.2; 
 Wed, 03 Jul 2024 23:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720074858; x=1720679658; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwkTShqOVMt4DB6dRbamleMFHSds+hYTFXe7lTeYk2Y=;
 b=BDuf8fJM4AgrG6eFg/9jvOi0GNabdqytyu8vzVxgZqhEc7woBACMEFqRdcxzwkh60h
 iXG1blxnDSpUkDo1hG5swDfBKrC8cpYbrMR8lsRoegfQPALEVHB2dXNz7nM2jNS0u9X+
 YILzmL9hRHPy6vb8XT/nn2ms/3fo5P96snTP8nOXMAu4vA/3x5+Kp8GQc+oJrf97+bc5
 BkwulCf0WULCcxB9SpWQFidpBgb/zm0faGzN0gxSWEJrWICuiuhSt6csn4Pr9GmMYDnh
 3SfLgc+FNIGJ1CfkuiqtcbbXCIn4PJsiVK1C9V33wHPVSZfQMzVJDgjKUfSgc0iPJfv0
 x1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720074858; x=1720679658;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HwkTShqOVMt4DB6dRbamleMFHSds+hYTFXe7lTeYk2Y=;
 b=rBoxiaPmTLvULfJBL9yLRYXdEXGfsEMB4V1GgZtuXdFN7nFe3+CX2nIttYR0GJtZEJ
 2Yn8bPTCVGndPV3pvjHAvM+mtuSyP5M6g1lkf5FGKFLkgY75kKSCI8Dp6vTKT5Bu4vue
 XBc25/+p12tR6GVySE/ihbx+H9QY4QfZBxnBXwF7zzY1Tb+IUco7xy0VfeTJ/qqkoRLa
 L7gjYtpc2IFqMxG68phwbWzR2LnJRmyKlsFFMx7WjFhLw7pVaRaK585zKPF6fIclieFj
 7+JlArjdDRhB5uHci4V/y83zRKkqhwb4vjdb20BfPDXK/BjZWCg+cZmAiWI+SrCbKhl1
 99yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbmtbVm0Ermgj2FCQYTFFEmcgOBhnsubkLXf2/pFX4O5Ec8DCZpEp8FGlQ+GQ/hjq5LPP/fWU/6Y0aLKIZN4Ruq1kvN5EFAON6NkLjjRHCwFMmAagDDm9T2oI=
X-Gm-Message-State: AOJu0YxVbKq8btKRQtPTL3gNmjxIRwRd3l5vsX2kcneRECpLqmEM+vwU
 GC73+7NUbEDjd7MSc4cFWLynBb/Mx77mMqx6YS9Wd93R1Yqxlr5y
X-Google-Smtp-Source: AGHT+IG40GE4qj13MZRabCGlg0QhNGVJ0XTdc7EpYhooSYX7xfmNbNKbndAprfI2H94MqoiRAgiErw==
X-Received: by 2002:a17:903:2308:b0:1fb:2ba3:2f6c with SMTP id
 d9443c01a7336-1fb33ef9152mr5439785ad.52.1720074858411; 
 Wed, 03 Jul 2024 23:34:18 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb1aff7469sm23999875ad.189.2024.07.03.23.34.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 23:34:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:34:13 +1000
Message-Id: <D2GJNAUB3V5A.MV0MMLOT6EY7@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 24/43] target/ppc/mmu_common.c: Use defines instead of
 numeric constants
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <635b831560a89d6e996ae0e8514f3b669217e967.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <635b831560a89d6e996ae0e8514f3b669217e967.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

On Mon May 27, 2024 at 9:13 AM AEST, BALATON Zoltan wrote:
> Replace some BAT related constants with defines from mmu-hash32.h

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 110936ca83..aa002bba35 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -201,7 +201,7 @@ static inline void bat_size_prot(CPUPPCState *env, ta=
rget_ulong *blp,
>      target_ulong bl;
>      int pp, valid, prot;
> =20
> -    bl =3D (*BATu & 0x00001FFC) << 15;
> +    bl =3D (*BATu & BATU32_BL) << 15;
>      valid =3D 0;
>      prot =3D 0;
>      if ((!FIELD_EX64(env->msr, MSR, PR) && (*BATu & 0x00000002)) ||
> @@ -241,19 +241,19 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ct=
x_t *ctx,
>      for (i =3D 0; i < env->nb_BATs; i++) {
>          BATu =3D &BATut[i];
>          BATl =3D &BATlt[i];
> -        BEPIu =3D *BATu & 0xF0000000;
> -        BEPIl =3D *BATu & 0x0FFE0000;
> +        BEPIu =3D *BATu & BATU32_BEPIU;
> +        BEPIl =3D *BATu & BATU32_BEPIL;
>          bat_size_prot(env, &bl, &valid, &prot, BATu, BATl);
>          qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_lx " BATu=
 "
>                        TARGET_FMT_lx " BATl " TARGET_FMT_lx "\n", __func_=
_,
>                        ifetch ? 'I' : 'D', i, eaddr, *BATu, *BATl);
> -        if ((eaddr & 0xF0000000) =3D=3D BEPIu &&
> -            ((eaddr & 0x0FFE0000) & ~bl) =3D=3D BEPIl) {
> +        if ((eaddr & BATU32_BEPIU) =3D=3D BEPIu &&
> +            ((eaddr & BATU32_BEPIL) & ~bl) =3D=3D BEPIl) {
>              /* BAT matches */
>              if (valid !=3D 0) {
>                  /* Get physical address */
> -                ctx->raddr =3D (*BATl & 0xF0000000) |
> -                    ((eaddr & 0x0FFE0000 & bl) | (*BATl & 0x0FFE0000)) |
> +                ctx->raddr =3D (*BATl & BATU32_BEPIU) |
> +                    ((eaddr & BATU32_BEPIL & bl) | (*BATl & BATU32_BEPIL=
)) |
>                      (eaddr & 0x0001F000);
>                  /* Compute access rights */
>                  ctx->prot =3D prot;
> @@ -277,9 +277,9 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_=
t *ctx,
>              for (i =3D 0; i < 4; i++) {
>                  BATu =3D &BATut[i];
>                  BATl =3D &BATlt[i];
> -                BEPIu =3D *BATu & 0xF0000000;
> -                BEPIl =3D *BATu & 0x0FFE0000;
> -                bl =3D (*BATu & 0x00001FFC) << 15;
> +                BEPIu =3D *BATu & BATU32_BEPIU;
> +                BEPIl =3D *BATu & BATU32_BEPIL;
> +                bl =3D (*BATu & BATU32_BL) << 15;
>                  qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_l=
x
>                                " BATu " TARGET_FMT_lx " BATl " TARGET_FMT=
_lx
>                                "\n\t" TARGET_FMT_lx " " TARGET_FMT_lx " "
> @@ -520,9 +520,9 @@ static void mmu6xx_dump_BATs(CPUPPCState *env, int ty=
pe)
>      for (i =3D 0; i < env->nb_BATs; i++) {
>          BATu =3D &BATut[i];
>          BATl =3D &BATlt[i];
> -        BEPIu =3D *BATu & 0xF0000000;
> -        BEPIl =3D *BATu & 0x0FFE0000;
> -        bl =3D (*BATu & 0x00001FFC) << 15;
> +        BEPIu =3D *BATu & BATU32_BEPIU;
> +        BEPIl =3D *BATu & BATU32_BEPIL;
> +        bl =3D (*BATu & BATU32_BL) << 15;
>          qemu_printf("%s BAT%d BATu " TARGET_FMT_lx
>                      " BATl " TARGET_FMT_lx "\n\t" TARGET_FMT_lx " "
>                      TARGET_FMT_lx " " TARGET_FMT_lx "\n",


