Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81619C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4hGN-0001nO-7J; Wed, 08 May 2024 09:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4hG9-0001hk-0N; Wed, 08 May 2024 09:23:03 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4hG6-0004FR-GG; Wed, 08 May 2024 09:23:00 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6ed9fc77bbfso3264809b3a.1; 
 Wed, 08 May 2024 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715174575; x=1715779375; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/n0n+zCiBPrH5BiX8omhLSBTynULzIwzR9PYNH+tHw=;
 b=i5e7i+AMWOxDkwGgd/gf4wxzOvvN5EyTkDkYIyDGrRrtNrMBW93NJphSJy4JcTeajP
 4UP0h59gfcRGryWSdnC7+IgtiUJlH4QXYn5d94934+AVnz2pApd7xSvn/LhSqzNEB0qP
 IhxG1pBgGBiTmqLLe7Ig+de7qdVTVQSVTht/xftd2rzeAr+Ek76F8alFjfgZ2eDqZ5Zv
 Hwq2OAMymF5aa08GvcCidEvpVcd2uc/RzIRffr5KEJxN8es0bjek24zxyxRMptV3+cH/
 Eit+tXpOy8IeOH2cgtKGONYyDDRGeLIzDb6XaDbsyLi/S/YfLHV9cswo12X1ddBIq+4W
 T20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715174575; x=1715779375;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q/n0n+zCiBPrH5BiX8omhLSBTynULzIwzR9PYNH+tHw=;
 b=iIWAWO2Zmcj4C/w7dS5LhsOejjaCzWCXfpoiLKt2EpOboJdh8vHT+2lbiiuVNi/KfA
 JiD5Q58re9kjpzn/CZUspIhQtOJIoMuQoahbRKx9yvW6ahlpDnL7QPYk0pSDlfLTwvHy
 baQymfa/CB1Fxzl/xDp2rkcJBELQ30n7OI+Zv1drpQ9OwxBylFURpvtg4grD3ywf7DK7
 7L5BqL5cwBJAVKmDKCZae0pt8PU1PmIwWOltWXopuZ3YAmKEDVRMCjUhQmgxC4y7WJbT
 FcR5u12lBR4qNbSPPPZY/TdQhtEhRDlLoHE3eQTgvLbk6bgqfc9LYI75QD3SKNpKI1a9
 xu7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJLxWZgYvqTbtTqYlpDVDXbUoB/Gpk0Q86U4gneqfH/hxsvK7EN93Qtl9C4zFVAvtN5SQJfYzD8m7XDjcP7N+iLXEAgh/X07wAiwrGimXhTBLGdVz7hIr+sh0=
X-Gm-Message-State: AOJu0YyYI1NkWXDwJpwk5eVmRDqLxsOy9ugyOFP9rbhk9NgLfZP3J6Ul
 7kpMkLiZM1hI28vV12qI8JhSVnYgnvaK1u7KCRd6HkoFcVjSSaF+
X-Google-Smtp-Source: AGHT+IGkEMVHd+/9vOt3+i1q7Uhwobr9T9gBYemOa9aHkE+DscpnllU3OB8T1IRt1O1DjheGgOFRpA==
X-Received: by 2002:a05:6a20:d04e:b0:1af:55e7:633d with SMTP id
 adf61e73a8af0-1afc8afc54bmr3061125637.0.1715174575329; 
 Wed, 08 May 2024 06:22:55 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 gx14-20020a056a001e0e00b006f44be6cef2sm9408027pfb.114.2024.05.08.06.22.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 06:22:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 23:22:48 +1000
Message-Id: <D14AN35W73CG.M5JMRK9M5P8I@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 31/33] target/ppc/mmu-hash32.c: Drop a local variable
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <2cb59eadd107d11b47635da829e578a55f263013.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <2cb59eadd107d11b47635da829e578a55f263013.1715125376.git.balaton@eik.bme.hu>
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

On Wed May 8, 2024 at 10:15 AM AEST, BALATON Zoltan wrote:
> In ppc_hash32_xlate() the value of need_prop is checked in two places
> but precalculating it does not help because when we reach the first
> check we always return and not reach the second place so the value
> will only be used once. We can drop the local variable and calculate
> it when needed, which makes these checks using it similar to other
> places with such checks.

Sure, why not.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu-hash32.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 960751a50e..b5d7aeed4e 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -347,7 +347,6 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, M=
MUAccessType access_type,
>      hwaddr pte_offset;
>      ppc_hash_pte32_t pte;
>      int prot;
> -    int need_prot;
>      hwaddr raddr;
> =20
>      /* There are no hash32 large pages. */
> @@ -361,13 +360,11 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr,=
 MMUAccessType access_type,
>          return true;
>      }
> =20
> -    need_prot =3D prot_for_access_type(access_type);
> -
>      /* 2. Check Block Address Translation entries (BATs) */
>      if (env->nb_BATs !=3D 0) {
>          raddr =3D ppc_hash32_bat_lookup(cpu, eaddr, access_type, protp, =
mmu_idx);
>          if (raddr !=3D -1) {
> -            if (need_prot & ~*protp) {
> +            if (prot_for_access_type(access_type) & ~*protp) {
>                  if (guest_visible) {
>                      if (access_type =3D=3D MMU_INST_FETCH) {
>                          cs->exception_index =3D POWERPC_EXCP_ISI;
> @@ -435,7 +432,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, M=
MUAccessType access_type,
> =20
>      prot =3D ppc_hash32_pte_prot(mmu_idx, sr, pte);
> =20
> -    if (need_prot & ~prot) {
> +    if (prot_for_access_type(access_type) & ~prot) {
>          /* Access right violation */
>          qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
>          if (guest_visible) {


