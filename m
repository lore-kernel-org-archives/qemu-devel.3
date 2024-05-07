Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9314EC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Hh7-0002ZX-Fw; Tue, 07 May 2024 06:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4Hh5-0002Yr-Ce; Tue, 07 May 2024 06:05:07 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4Hh2-0002FL-Cx; Tue, 07 May 2024 06:05:07 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f4496af4cdso2412981b3a.0; 
 Tue, 07 May 2024 03:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715076302; x=1715681102; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jo52RS86kcfQd48Wvl43HJ4CfxMFbj82aBWZOce79vA=;
 b=kemjUdGoykpoTBC77Ug/VFzsZHn4aT4N8o3VpXoXMEN3Wat0jJO4Z2NwP+HqtXhlci
 6V97oiOuTz6mckpENNsQsb+fgT+r0t5vHp/HhiJR7dRR4ymD5z5PmgJnbvjwO1Vn/ggM
 D9fot62cuytA86B9yxlr58gNbKQ7yYNki/MJ2KXmq3XB1lUBjzwwlidvwoNhpf+6MrKO
 0mMpZjzREThxhcs8JMZoCbn959NzctU+ekuigF1dtCsgJL3puKr4PB3i3amXfWumTAq5
 KHSQn51cdJkT6gUKA+R4s+P+BCYC7zpyyL3E/XVytaIye3lvDvrUaJapRsTE4qJGKA9F
 MXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715076302; x=1715681102;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jo52RS86kcfQd48Wvl43HJ4CfxMFbj82aBWZOce79vA=;
 b=usNClBzmQvTs+/l0bu6bmxYixX3zATg6oQeHApRwxCtJJpxHsC+g8kmNWimVfTtsm2
 IRxNO//ekD1nFbjg4LC24UgskNRKmP8bvjSjGr155yBM4udzd5GLYPvy/msPCQ4kGHhB
 nIJwVFcQDoCzmUKIzEu6EnDE5WFgmu1mwUgE2+FmB5zmDQkmj9Urtp6vT3S+ExouXMOg
 FYfqmpYnhG2Z+CjjoIgZbhK9Judvij/t2agsxWHOsWaCRt0wStT0wvx9zv/DEElm5Zd0
 UP5gSp7AO+35sbieSn8ixM9/pPxeV+FYNj1+jITIIApKTNyaQ5HjKJzq+x2kNPAZVJmk
 OszQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+i6ajDLGyldFKxwP+a9JBP8Q5F6dlAmALvGdoZLROOsGUyldChXjb4Bkcu16XulULdcjrbwceZFVpO3UXr266RV83cDOy+2B2vJ23XpDxHzVUqxvx5DDHILo=
X-Gm-Message-State: AOJu0YwgLdZPAEmaAexcqDNBUIfKhiip6eJoQbxGZYuic9UEs4UlXD7J
 sHAWjEh5wVJp/pHORAHk/Lnk2BiEkdSW8ista62iy8RcrPWtlIq27bGwvQ==
X-Google-Smtp-Source: AGHT+IGuT5hmZJ0qEHvP2AIJwKkb7XYNJPYbvUzQOtt9gLfkJPNKn9CJVuz1YjFVrD6xFY7irCmiuA==
X-Received: by 2002:a05:6a20:9794:b0:1a3:65af:9baa with SMTP id
 hx20-20020a056a20979400b001a365af9baamr10361677pzc.62.1715076301729; 
 Tue, 07 May 2024 03:05:01 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a170902ebd000b001ebd7bdaaffsm9673368plg.288.2024.05.07.03.04.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 03:05:01 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 20:04:56 +1000
Message-Id: <D13BT1NPFI22.2CUU4PPJDPY5Q@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 16/28] target/ppc/mmu_common.c: Simplify
 mmubooke206_get_physical_address()
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <14bc4664f49e6634e49f454971d8281c69ff0ff2.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <14bc4664f49e6634e49f454971d8281c69ff0ff2.1714606359.git.balaton@eik.bme.hu>
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

On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
> This function is similar to mmubooke_get_physical_address() and can be
> simplified the same way.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 760e4072b2..ebf18a751c 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -872,15 +872,11 @@ static int mmubooke206_get_physical_address(CPUPPCS=
tate *env, mmu_ctx_t *ctx,
>                                              int mmu_idx)
>  {
>      ppcmas_tlb_t *tlb;
> -    hwaddr raddr;
> -    int i, j, ret;
> -
> -    ret =3D -1;
> -    raddr =3D (hwaddr)-1ULL;
> +    hwaddr raddr =3D (hwaddr)-1ULL;
> +    int i, j, ways, ret =3D -1;
> =20
>      for (i =3D 0; i < BOOKE206_MAX_TLBN; i++) {
> -        int ways =3D booke206_tlb_ways(env, i);

Don't need to bring the ways variable into a larger scope I think?
Otherwise,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> -
> +        ways =3D booke206_tlb_ways(env, i);
>          for (j =3D 0; j < ways; j++) {
>              tlb =3D booke206_get_tlbm(env, i, address, j);
>              if (!tlb) {
> @@ -889,6 +885,9 @@ static int mmubooke206_get_physical_address(CPUPPCSta=
te *env, mmu_ctx_t *ctx,
>              ret =3D mmubooke206_check_tlb(env, tlb, &raddr, &ctx->prot, =
address,
>                                          access_type, mmu_idx);
>              if (ret !=3D -1) {
> +                if (ret >=3D 0) {
> +                    ctx->raddr =3D raddr;
> +                }
>                  goto found_tlb;
>              }
>          }
> @@ -896,17 +895,10 @@ static int mmubooke206_get_physical_address(CPUPPCS=
tate *env, mmu_ctx_t *ctx,
> =20
>  found_tlb:
> =20
> -    if (ret >=3D 0) {
> -        ctx->raddr =3D raddr;
> -         qemu_log_mask(CPU_LOG_MMU, "%s: access granted " TARGET_FMT_lx
> -                       " =3D> " HWADDR_FMT_plx " %d %d\n", __func__, add=
ress,
> -                       ctx->raddr, ctx->prot, ret);
> -    } else {
> -         qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
> -                       " =3D> " HWADDR_FMT_plx " %d %d\n", __func__, add=
ress,
> -                       raddr, ctx->prot, ret);
> -    }
> -
> +    qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " =3D> "
> +                  HWADDR_FMT_plx " %d %d\n", __func__,
> +                  ret < 0 ? "refused" : "granted", address, raddr,
> +                  ctx->prot, ret);
>      return ret;
>  }
> =20


