Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA96CC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPGbL-0004jZ-9G; Thu, 04 Jul 2024 03:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGbI-0004io-T1; Thu, 04 Jul 2024 03:09:52 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGbH-0006li-CD; Thu, 04 Jul 2024 03:09:52 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-70224a923fcso215819a34.1; 
 Thu, 04 Jul 2024 00:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720076989; x=1720681789; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KsGFuKzt2RzpIiIVX5o4LdHdi3QuXs5Reg/i+g5Msi4=;
 b=WQ9PFb4pp6Z0i9ogrSJYHBewinjRIDgCUxNCDAFr6iU7PwSjahW3eNDrGyvfC0hMBO
 UoXo81piZXzBB4XMu+yAbwhtx90mlLjoXRpmXwwinJniDVSLv1tDEXw0i6qSbZSxgFne
 3MhbFUhljLoLJ/xC70zyJbw/tgQbjvPawF3gwpmpVDNKZq+gs0+r2Uu0pmd7TjPcjHxO
 FaaKqLSX/38qdzldw8ee7Ta1yFry4ZepPCbhwQyL0v9K++Z1uaUZN2OJJEJuco4WWCUq
 qGn3qKEfEo0sK3DhTtu9eK5PrVQzNIw/KeRdo9cTXCbD5/cbLs+1Ir3F9Q10bfQcjCiC
 3Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720076989; x=1720681789;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KsGFuKzt2RzpIiIVX5o4LdHdi3QuXs5Reg/i+g5Msi4=;
 b=AuGkPfX6PCYs0E2XJb5MfsTRz0y9nxvVNiXrAPRg9g86PHv9GFpBIR4wXn32xNmIXP
 YnyP5Iruxy/WdMZpq6OpCfAgTy9x+//WCQHk8p/+Fp+fFzICqvZwHXeKrzgzkmGMPW5c
 ZGGF/IwCnzyqbA0WumGu4T9VWsNyc6T+K7kXXsDkYFNZcU3AbDeKOyVHb2YF10M4MWmR
 evHtbU70IfT8GLEBog5ZXSDUUU/TTewBNWZxZCen4mWZIHNcHYQ6nZxTOl8FUGh+S37a
 Y8sY5ZHVmowItA53UgwnUDp2WL5dbEP/PN7jbgy1adVdYDiKbQ0kSmB4lV14JV43rmGL
 OZ4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuiEeu4UTPc3nDD0IR7EjbX2Sko7KC6De1Lr6QCs7AG+OWcUcns5RQuO/vuQ5Wxn4OJvrQKrz8RT/lrANjJtavBFV+0jMsKIU0K+42Wv4PmxjlXaQjrnKJNww=
X-Gm-Message-State: AOJu0Yxx67nuUrttxe+uqLaeS4ZNBgUCOlHSh0oag+QcizJxvOMdT7Sm
 F1lDcuxuLcoW2IVRvT5LJ0XSyKNfixrabr8Shu/gxoZS58yw1Agq
X-Google-Smtp-Source: AGHT+IFcFSIDAS84Yqa86Vig267u1q//6scIvRBt539X/jOFs2IlUhQ1ijldYAx1QVoBgCRw+I2zwg==
X-Received: by 2002:a05:6359:4c90:b0:1a1:fe6f:be71 with SMTP id
 e5c5f4694b2df-1aa98b7f7a1mr72601755d.3.1720076988298; 
 Thu, 04 Jul 2024 00:09:48 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6b5846desm7867998a12.55.2024.07.04.00.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:09:47 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:09:43 +1000
Message-Id: <D2GKEHG1EVBJ.K8HG1XRWIW1G@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 26/43] target/ppc/mmu_common.c: Stop using ctx in
 get_bat_6xx_tlb()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <069b4b98c933bb95ba12cf2d6d2921b986cf22c4.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <069b4b98c933bb95ba12cf2d6d2921b986cf22c4.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x332.google.com
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
> Pass raddr and prot in function parameters instead

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 624ed51a92..4770b43630 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -193,7 +193,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env, hwaddr =
*raddr, int *prot,
>      return ret;
>  }
> =20
> -static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
> +static int get_bat_6xx_tlb(CPUPPCState *env, hwaddr *raddr, int *prot,
>                             target_ulong eaddr, MMUAccessType access_type=
,
>                             bool pr)
>  {
> @@ -224,16 +224,16 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ct=
x_t *ctx,
>              if ((eaddr & BATU32_BEPIU) =3D=3D BEPIu &&
>                  ((eaddr & BATU32_BEPIL) & ~bl) =3D=3D BEPIl) {
>                  /* Get physical address */
> -                ctx->raddr =3D (*BATl & BATU32_BEPIU) |
> +                *raddr =3D (*BATl & BATU32_BEPIU) |
>                      ((eaddr & BATU32_BEPIL & bl) | (*BATl & BATU32_BEPIL=
)) |
>                      (eaddr & 0x0001F000);
>                  /* Compute access rights */
> -                ctx->prot =3D ppc_hash32_bat_prot(*BATu, *BATl);
> -                if (check_prot_access_type(ctx->prot, access_type)) {
> +                *prot =3D ppc_hash32_bat_prot(*BATu, *BATl);
> +                if (check_prot_access_type(*prot, access_type)) {
>                      qemu_log_mask(CPU_LOG_MMU, "BAT %d match: r " HWADDR=
_FMT_plx
> -                                  " prot=3D%c%c\n", i, ctx->raddr,
> -                                  ctx->prot & PAGE_READ ? 'R' : '-',
> -                                  ctx->prot & PAGE_WRITE ? 'W' : '-');
> +                                  " prot=3D%c%c\n", i, *raddr,
> +                                  *prot & PAGE_READ ? 'R' : '-',
> +                                  *prot & PAGE_WRITE ? 'W' : '-');
>                      ret =3D 0;
>                  } else {
>                      ret =3D -2;
> @@ -277,7 +277,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
> =20
>      /* First try to find a BAT entry if there are any */
>      if (env->nb_BATs &&
> -        get_bat_6xx_tlb(env, ctx, eaddr, access_type, pr) =3D=3D 0) {
> +        get_bat_6xx_tlb(env, &ctx->raddr, &ctx->prot, eaddr,
> +                        access_type, pr) =3D=3D 0) {
>          return 0;
>      }
> =20


