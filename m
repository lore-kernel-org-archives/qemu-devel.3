Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FA3C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFyR-0002OH-T6; Thu, 04 Jul 2024 02:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFyP-0002Ns-0J; Thu, 04 Jul 2024 02:29:41 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFy9-0004Qs-JM; Thu, 04 Jul 2024 02:29:40 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-701f397e8ffso175512a34.0; 
 Wed, 03 Jul 2024 23:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720074563; x=1720679363; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k3IJVjEqwx9TC2jC5Mzs8z2QBHvhpNv9jGZ6ejySruM=;
 b=edR7OEtDetOmEsxHnj6Cm+EummL9w/IGLxc7xp7btcxtAaQz9y6lum5uthFsI2SF5D
 h/3YHbU+l1nW6MHz8kCfp1CWlnXR0Imf1FDbYoqkw3igkRvJL4gKuQ1X9A70zU4BcLE2
 5+Kk6KOui/iVshRSKN07cmMrc+SUKnmQ9KTVqPcXAzbZAxBVMq/Ddt5mhX64lbNmr4x4
 Is9+fWfW7Wiw30BFRvnzBMOpx8Z1aPAWqjkLdVm7KumZ2b3lHg3OrC7ymRgzpU/ribAS
 L52OO36CBynN65DSyeJKpsUa94sfiZO71fq6iqnIP+oD585EUcBmXHtgGCcjPKhi39XP
 OrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720074563; x=1720679363;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k3IJVjEqwx9TC2jC5Mzs8z2QBHvhpNv9jGZ6ejySruM=;
 b=qjSOuy+OuGbgjtsuAOmmCjd1hjVWSoeactwxiGFm8bDJ/tG7+lFRuIaajRElJLLrgL
 izovAcxSwxtGmbgv/9+J7WkKGP9eqYl6g8s6Qqpp+2APVPIOMyIIcHZ1kQihOYyPbK71
 BMpNXseG+X1Ok6w/9RgNe0rZOoEOg/+eUT1Mj9op8fDM2uMiSt/Gu9ofyh4xjHU2bBn3
 tAyg1YTuy5byLJjdslRFiUyLNZX59RciuMC82CMBV9K1S8OkJKoZFPTG2yP7NtZ1wCmp
 roC6oxV5XAZSptS5nbuckEcNzMtiw7XLX1lnvJDjGNihpxzAXTn8KRFD0leadJdO8G5O
 RsLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKlAiEcLmjWC5PUDGagxv/MCM1yd6es/4QhErGQ3Z+p2KubYz+4dQUfVbwvJitf8p4qpoIenLAhcYJmeUdGX4MQ362mCWNsX0+69/kbkBXHXNkr4zeWdZUnSw=
X-Gm-Message-State: AOJu0YwpPQ/zO84aoBft1Q4w6D7Am08i/ZrjryjQ+62uA8RXUQeBc36A
 14iag7zGFeOMOftMSxtXjuay/LYoP3S/H/vDYKBmxPpHUZnRGHEs
X-Google-Smtp-Source: AGHT+IGemK4J2GLDNXjiLWaAQEhi2pQU3iP9iekgNsZlTe0feObTh960vuF5y1QQ5MfJeAnDPdVmPA==
X-Received: by 2002:a05:6870:a11e:b0:25d:fb57:db43 with SMTP id
 586e51a60fabf-25e2b8d5f55mr725294fac.12.1720074562804; 
 Wed, 03 Jul 2024 23:29:22 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70804a91335sm11414079b3a.213.2024.07.03.23.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 23:29:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:29:17 +1000
Message-Id: <D2GJJJ1IQ7DV.L0VUPH6LA4OQ@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 19/43] target/ppc/mmu-hash32.c: Inline and remove
 ppc_hash32_pte_prot()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <6b845babbcee896afca10204f43ce0990dac43ff.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <6b845babbcee896afca10204f43ce0990dac43ff.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> This is used only once and can be inlined.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu-hash32.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 93559447ff..160311de87 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -37,17 +37,6 @@
>  #  define LOG_BATS(...) do { } while (0)
>  #endif
> =20
> -static int ppc_hash32_pte_prot(int mmu_idx,
> -                               target_ulong sr, ppc_hash_pte32_t pte)
> -{
> -    unsigned pp, key;
> -
> -    key =3D ppc_hash32_key(mmuidx_pr(mmu_idx), sr);
> -    pp =3D pte.pte1 & HPTE32_R_PP;
> -
> -    return ppc_hash32_prot(key, pp, !!(sr & SR32_NX));
> -}
> -
>  static target_ulong hash32_bat_size(int mmu_idx,
>                                      target_ulong batu, target_ulong batl=
)
>  {
> @@ -341,10 +330,10 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr,=
 MMUAccessType access_type,
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
>      target_ulong sr;
> -    hwaddr pte_offset;
> +    hwaddr pte_offset, raddr;
>      ppc_hash_pte32_t pte;
> +    bool key;
>      int prot;
> -    hwaddr raddr;
> =20
>      /* There are no hash32 large pages. */
>      *psizep =3D TARGET_PAGE_BITS;
> @@ -426,8 +415,8 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, M=
MUAccessType access_type,
>                  "found PTE at offset %08" HWADDR_PRIx "\n", pte_offset);
> =20
>      /* 7. Check access permissions */
> -
> -    prot =3D ppc_hash32_pte_prot(mmu_idx, sr, pte);
> +    key =3D ppc_hash32_key(mmuidx_pr(mmu_idx), sr);
> +    prot =3D ppc_hash32_prot(key, pte.pte1 & HPTE32_R_PP, sr & SR32_NX);
> =20
>      if (!check_prot_access_type(prot, access_type)) {
>          /* Access right violation */


