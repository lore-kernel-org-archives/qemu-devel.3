Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F1BC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPGnD-00065Q-Q7; Thu, 04 Jul 2024 03:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGnA-00064u-Kl; Thu, 04 Jul 2024 03:22:08 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGn6-0006F4-SO; Thu, 04 Jul 2024 03:22:08 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fb05ac6b77so1774455ad.0; 
 Thu, 04 Jul 2024 00:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720077723; x=1720682523; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXLfQXle7nhOAef2yXO7OjgmFDet8et43lG2GOe9ASY=;
 b=h56bdAq3T4mj2ebG4tibeiyb5qlA3PXtBz87ErFDInxEn4sWjufLgf6n53AGsE52of
 wgF6aiNboYwEgloqPSghqnP7nT3bWYis5PnIm8NApLA75TRE/lMljro78XAUy+1lJVPo
 E2r00ko4XXwbwUSVlzb0JxG0XrzWHf0KKjkFu0Q0A5u+T14AfkoKpFgo4J6SI8pOPzrS
 Q5L8Klgh0EOeZqHYH+3MZBbpi1DdzGP5ba2k5NgsFywlGcwPp3144NZnWhiJVzomHMOo
 PlRW2rwq3IBPIEqvxUSR6V8CO1oX4zayp8QH8INcFXFFXV1rJmMwprlL4lHuaTAeGVJg
 pxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720077723; x=1720682523;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MXLfQXle7nhOAef2yXO7OjgmFDet8et43lG2GOe9ASY=;
 b=JPLuh6swUOIxzZ0jIEX6Qy/LKCqIuKx75fv9TcyGUWX6bhd+PIBqX1N8Un6I1bvubV
 GyNjA8qHEbRLr6l9udHKPSYpRfkT3CCAOTnD4+qSut8bIXtvkeuNTxtNHoyJ25FdJsa4
 r/lDrRV3wQO6WJkENxDjEfNJ2sjeWtqfqykIldX6r3ljXFs9JKSEw9WmdAaeU63Q9X5a
 agdjcLp95hq4HRB9w9inLasiYGJ3jH1Y+GJhC/dRiPhWlwEKL166NBasV7nZ2ps3Jz33
 NH1e14npOwk+NTMp7Tb5cIAnmBLm7SD1O8UUT61SFtMFyimhEPra6+3/3q3lHCOtXkyr
 D1xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4j+1eYobcYWuLJBiBIRHSDWGH06yG2GlCRfbLJxHSP/hOJJ8g8Q6u+KPszJJOJkKz/N8B/qD27jWVMGpoj0Xs8xLaOYjwXi20/Ww7U3hm357lv8A11L962fk=
X-Gm-Message-State: AOJu0YzS28WXwkPuwx0ScLIj7VbS1PRHTkeEKPcjwDoHPeFcAImIh8m5
 nU9lW7HIOmcacJVHu2CRK2YcQaRJKuXbTKq3Kr5TaT8wnZJkGYMC
X-Google-Smtp-Source: AGHT+IEjhsTX4jnIWmFuEyfsPUr0c6qtFCJtd2Xr9Raui+pOjXt0C5YfCNH2Y3QsmERSEXVMMFdIjA==
X-Received: by 2002:a17:903:234e:b0:1f9:f018:6973 with SMTP id
 d9443c01a7336-1fb33f0a667mr8846215ad.51.1720077723001; 
 Thu, 04 Jul 2024 00:22:03 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10d2652sm115773045ad.1.2024.07.04.00.22.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:22:02 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:21:57 +1000
Message-Id: <D2GKNUSA4XP0.35L5LIXFHYBTB@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 36/43] target/ppc/mmu-hash32: Remove some static inlines
 from header
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <3b3cce4a39e0debbf6fa29d4a2ead3014898cb93.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <3b3cce4a39e0debbf6fa29d4a2ead3014898cb93.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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
> Two of these are not used anywhere and the other two are used only
> once and can be inlined and removed from the header.

I'd prefer to put these in the .c file. Probably calculating the
base once would generate marginally better code since it would not
have to keep reloading it (since there is a barrier there it can't
cache the value).

Thanks,
Nick

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu-hash32.c |  5 +++--
>  target/ppc/mmu-hash32.h | 32 --------------------------------
>  2 files changed, 3 insertions(+), 34 deletions(-)
>
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index a2c0ac05d2..7a6a674f8a 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -206,17 +206,18 @@ static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cp=
u, hwaddr pteg_off,
>  {
>      hwaddr pte_offset =3D pteg_off;
>      target_ulong pte0, pte1;
> +    hwaddr base =3D ppc_hash32_hpt_base(cpu);
>      int i;
> =20
>      for (i =3D 0; i < HPTES_PER_GROUP; i++) {
> -        pte0 =3D ppc_hash32_load_hpte0(cpu, pte_offset);
> +        pte0 =3D ldl_phys(CPU(cpu)->as, base + pte_offset);
>          /*
>           * pte0 contains the valid bit and must be read before pte1,
>           * otherwise we might see an old pte1 with a new valid bit and
>           * thus an inconsistent hpte value
>           */
>          smp_rmb();
> -        pte1 =3D ppc_hash32_load_hpte1(cpu, pte_offset);
> +        pte1 =3D ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZ=
E_32 / 2);
> =20
>          if ((pte0 & HPTE32_V_VALID)
>              && (secondary =3D=3D !!(pte0 & HPTE32_V_SECONDARY))
> diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
> index 2838de031c..4db55fb0a0 100644
> --- a/target/ppc/mmu-hash32.h
> +++ b/target/ppc/mmu-hash32.h
> @@ -69,38 +69,6 @@ static inline hwaddr ppc_hash32_hpt_mask(PowerPCCPU *c=
pu)
>      return ((cpu->env.spr[SPR_SDR1] & SDR_32_HTABMASK) << 16) | 0xFFFF;
>  }
> =20
> -static inline target_ulong ppc_hash32_load_hpte0(PowerPCCPU *cpu,
> -                                                 hwaddr pte_offset)
> -{
> -    target_ulong base =3D ppc_hash32_hpt_base(cpu);
> -
> -    return ldl_phys(CPU(cpu)->as, base + pte_offset);
> -}
> -
> -static inline target_ulong ppc_hash32_load_hpte1(PowerPCCPU *cpu,
> -                                                 hwaddr pte_offset)
> -{
> -    target_ulong base =3D ppc_hash32_hpt_base(cpu);
> -
> -    return ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 /=
 2);
> -}
> -
> -static inline void ppc_hash32_store_hpte0(PowerPCCPU *cpu,
> -                                          hwaddr pte_offset, target_ulon=
g pte0)
> -{
> -    target_ulong base =3D ppc_hash32_hpt_base(cpu);
> -
> -    stl_phys(CPU(cpu)->as, base + pte_offset, pte0);
> -}
> -
> -static inline void ppc_hash32_store_hpte1(PowerPCCPU *cpu,
> -                                          hwaddr pte_offset, target_ulon=
g pte1)
> -{
> -    target_ulong base =3D ppc_hash32_hpt_base(cpu);
> -
> -    stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, pte=
1);
> -}
> -
>  static inline hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
>  {
>      return (hash * HASH_PTEG_SIZE_32) & ppc_hash32_hpt_mask(cpu);


