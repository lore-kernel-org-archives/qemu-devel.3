Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958CBC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 06:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7r1Z-0007ka-GU; Fri, 17 May 2024 02:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7r1Q-0007jS-RR; Fri, 17 May 2024 02:24:55 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7r1O-0005az-Lj; Fri, 17 May 2024 02:24:51 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f4472561f1so1054858b3a.0; 
 Thu, 16 May 2024 23:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715927088; x=1716531888; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CHt7zJNVf23z/XCMWcGBFwTOLG/F7NSPYdGwwYlEu2g=;
 b=X9aqwgadeeq/5y56fsTttRKak5GWBubKgMvra8zmk0xCn8K9GAOGRSr/rld0OceziC
 a4uIrOO5PeeZ+36TzgdzqY0WvUyCc3YAT+/M6EkzajkBCPoajuniEeI9bDZWySgQSmPp
 eX/dH/4/V1EK3omM7lZs+vd10TpP0mnNvg/7R/EUkf0kWA4bZ1c9irkdLyuRyGEeH14N
 DAhgutamcpjfnNzyf2Y3Gn1v/k8qNvD546D/+jnZh2tsuhHuZtslUPDz/rmm9m7SonnT
 R2MXm/MrsF8Arac11QOt/h7LDFUaRzmnyMwI+6DquoftF3bjfRWOrPo9IrTJAzLzcL2V
 MrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715927088; x=1716531888;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CHt7zJNVf23z/XCMWcGBFwTOLG/F7NSPYdGwwYlEu2g=;
 b=ejot17EqCYSWQaNb2KVv3sds5lpBLXXrSR3cqY1O2bqnJuG4GAYUBlqZdzK5uOIURb
 hlC+JzSY/X5gepQEKcTCzLpJmPSQ/Mf7/UlDsIQRH8rFsvUZjDWk3J3N+Nr+AaXMoTRc
 mPgFS32C1It8jSyZtnQn2LSxVuilG8D8/GnZHqntv8ytapgGi43csSWnC3uxKp5GfH9G
 JEQBgD4l0/AeobDPEWdEJVd7XhWvnpfdb3TFVm2Lh355qDIRjl+REcebSPnYoQh37Wc7
 WOfNxRNeUbJe5/4k8ADP5ga6q20ZJvpYS1zgBE+T1TZ9Ya3Y61tZ3Hed7hhS6JjWU84C
 dU/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4VJN9EYnVe445wbU3U8WqsH3qvHy4COyzny9ftACIHUmzmoAdtiLkapPrI/aonBKiZKTkiEtuaBFub08NSilpyRnEH82vHppmu2r75yomxuVG1Na9pc5d2is=
X-Gm-Message-State: AOJu0YxNtZGxfDCqcEpQMhm+f7qWaeVHGZjRbFbA+UMaLMkN3+GS7P5N
 WLBBRz5OgNAnyt0MAtjpQ2Bfu4Ec7iRzz53UAarWZbjnWOKIquoX
X-Google-Smtp-Source: AGHT+IEfDacLXraCriEQyRM0VG6UP4oGMzSw03uoWdsJjdOn9QRXQIrBsdWcVrM2X15ecOZ8blc83w==
X-Received: by 2002:a05:6a20:6f8f:b0:1a9:a3c6:1d97 with SMTP id
 adf61e73a8af0-1afde0ecbc5mr32559273637.33.1715927087979; 
 Thu, 16 May 2024 23:24:47 -0700 (PDT)
Received: from localhost ([1.146.118.37]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b62863a5fbsm16800892a91.4.2024.05.16.23.24.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 23:24:47 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 May 2024 16:24:42 +1000
Message-Id: <D1BPDV94VAAQ.ISPDNEYB3NFW@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v7 52/61] target/ppc/mmu-hash32.c: Inline and remove
 ppc_hash32_pte_prot()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715555763.git.balaton@eik.bme.hu>
 <d57adbc137f68713cc34a2982ed414f82c6ffaa0.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <d57adbc137f68713cc34a2982ed414f82c6ffaa0.1715555763.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

On Mon May 13, 2024 at 9:28 AM AEST, BALATON Zoltan wrote:
> This is used only once and can be inlined.

This reminds me, ppc_hash32_pp_prot() calculates prot from
pp and nx (which is not from pp but from segment) and from
key of course. It could be renamed to say ppc_hash32_prot().
Maybe do that when you split out the rearranging of that
function.

Thanks,
Nick

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu-hash32.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 8e5e83f46a..9de42713b3 100644
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
> -    return ppc_hash32_pp_prot(key, pp, !!(sr & SR32_NX));
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
> +    prot =3D ppc_hash32_pp_prot(key, pte.pte1 & HPTE32_R_PP, sr & SR32_N=
X);
> =20
>      if (!check_prot_access_type(prot, access_type)) {
>          /* Access right violation */


