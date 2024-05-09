Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D357AC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 06:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4x2b-00039P-Ma; Thu, 09 May 2024 02:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4x2P-00031p-UA; Thu, 09 May 2024 02:14:00 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4x2N-0008Dd-W1; Thu, 09 May 2024 02:13:53 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f4551f2725so476813b3a.1; 
 Wed, 08 May 2024 23:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715235230; x=1715840030; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7N+IVEzQpoBYl3BYLcXaGhJa2dV8U++F02CVVB4YzzY=;
 b=Iil4sBkmcfVC/hIVclVGlH/YbbWDbSzGvfOFe48/EJpex6BvqKqSHtp8CPD9dlhV/N
 tsx94/0QZ6sP/LWIemI9gMEjQhpHof9IYw675ZX0F+eGDDfQzCFX3xuSPhGCb+RVz+pn
 4WKgUc7GdWqSdafJtWyp/y8Z1PGJnUQtDo54AR7nUpq0c5ICq+Nj6jtvsT2M/V2+Tng/
 tMXtXZNz5QDv5Dk7LEE8S4vd3/oEifIXWJ6raw4my8N77d2KO3a4B0ZMcW2pvQ3CeVaX
 Upqda/1LV18fwYaaWy5Tabrv8WUjMs+b0iTvsB3HUAoBHxuk6T0SZ1prhFmTXnXraZfJ
 vUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715235230; x=1715840030;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7N+IVEzQpoBYl3BYLcXaGhJa2dV8U++F02CVVB4YzzY=;
 b=fSg8cGmCUj196STIUROhwfeJtJU+TiU57v1KhDMDaZoHzun93KmDEh83IoZHOqC5BC
 P84UeDMAjvODomBP+K346qcoURKCdbBAjTYluzXH5Q4moB7Y6dp634NihvBu/16wA9+G
 tHm1ryC2ypqxHQ7ua8j9KVWnh785N1wsciQGNDO0lBupaimOWLKB5hTjczYRFP69ZkmZ
 XygbHyJlNaPkoTFoGhFMF0nZbja+r0PdWqct1qcz/Zvkn4xn8rFEIreDDjURkVGk4iWz
 xqriG7uZ9PbgBStTo73Fg63OsfgZGhILKi5NZhya1ZZvIibjiALGafjtvSB5DYQCcXGA
 f66Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9i0ECW8T4G+l4oFD4kNJE3oeMTYWyr8UBTFpGW8kY09Bfzs6c2mkwX8LQ4TCs90scTCF0df+bNKb9Tm5lgpT9VWnFA+d/i4gmY9GNFEj6wTXslSQIGHaTiXk=
X-Gm-Message-State: AOJu0YwMARxvEX0HQzxSs+tPHsiIvncUoDEBUzvZBlEJCIuUEC62B8sz
 ARQfPOZBmi9qV6gSVsdbpsA7KALS7m/IITuHuKqy/+umjuzr3Ejx
X-Google-Smtp-Source: AGHT+IHnysajS4IRzeUZVyJYeulmJWm3vccUwtmZSYJsqbBJA8w7xgeIFqjaT1qlrTgUo0Q8fbVgXA==
X-Received: by 2002:a05:6a20:da8d:b0:1a7:1bef:2377 with SMTP id
 adf61e73a8af0-1afc8db5b90mr5728564637.38.1715235230276; 
 Wed, 08 May 2024 23:13:50 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c15a8fcsm5768845ad.278.2024.05.08.23.13.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 23:13:49 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 May 2024 16:13:45 +1000
Message-Id: <D14W54O0C1NK.QFI1I44N51DJ@gmail.com>
Subject: Re: [PATCH v4 20/33] target/ppc/mmu_common.c: Don't use mmu_ctx_t
 in mmubooke_get_physical_address()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1715209155.git.balaton@eik.bme.hu>
 <30fb2142b0c22d11c783741054d5de680135a73a.1715209155.git.balaton@eik.bme.hu>
In-Reply-To: <30fb2142b0c22d11c783741054d5de680135a73a.1715209155.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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
> mmubooke_get_physical_address() only uses the raddr and prot fields
> from mmu_ctx_t. Pass these directly instead of using a ctx struct.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index c5ef02f05e..8c1c7b1851 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -635,36 +635,25 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppc=
emb_tlb_t *tlb,
>      return access_type =3D=3D MMU_INST_FETCH ? -3 : -2;
>  }
> =20
> -static int mmubooke_get_physical_address(CPUPPCState *env, mmu_ctx_t *ct=
x,
> -                                         target_ulong address,
> +static int mmubooke_get_physical_address(CPUPPCState *env, hwaddr *raddr=
,
> +                                         int *prot, target_ulong address=
,
>                                           MMUAccessType access_type)
>  {
>      ppcemb_tlb_t *tlb;
> -    hwaddr raddr;
> -    int i, ret;
> +    int i, ret =3D -1;
> =20
> -    ret =3D -1;
> -    raddr =3D (hwaddr)-1ULL;
>      for (i =3D 0; i < env->nb_tlb; i++) {
>          tlb =3D &env->tlb.tlbe[i];
> -        ret =3D mmubooke_check_tlb(env, tlb, &raddr, &ctx->prot, address=
,
> +        ret =3D mmubooke_check_tlb(env, tlb, raddr, prot, address,
>                                   access_type, i);
>          if (ret !=3D -1) {
>              break;
>          }
>      }
> -
> -    if (ret >=3D 0) {
> -        ctx->raddr =3D raddr;
> -        qemu_log_mask(CPU_LOG_MMU, "%s: access granted " TARGET_FMT_lx
> -                      " =3D> " HWADDR_FMT_plx " %d %d\n", __func__,
> -                      address, ctx->raddr, ctx->prot, ret);
> -    } else {
> -         qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
> -                       " =3D> " HWADDR_FMT_plx " %d %d\n", __func__,
> -                       address, raddr, ctx->prot, ret);
> -    }
> -
> +    qemu_log_mask(CPU_LOG_MMU,
> +                  "%s: access %s " TARGET_FMT_lx " =3D> " HWADDR_FMT_plx
> +                  " %d %d\n", __func__, ret < 0 ? "refused" : "granted",
> +                  address, ret < 0 ? -1 : *raddr, *prot, ret);
>      return ret;
>  }
> =20
> @@ -1144,7 +1133,8 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu=
_ctx_t *ctx,
>      bool real_mode;
> =20
>      if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE) {
> -        return mmubooke_get_physical_address(env, ctx, eaddr, access_typ=
e);
> +        return mmubooke_get_physical_address(env, &ctx->raddr, &ctx->pro=
t,
> +                                             eaddr, access_type);
>      } else if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
>          return mmubooke206_get_physical_address(env, ctx, eaddr, access_=
type,
>                                                  mmu_idx);


