Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1292DC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4GyP-0004Dm-Nb; Tue, 07 May 2024 05:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4GyO-0004DE-DU; Tue, 07 May 2024 05:18:56 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4GyM-0003ut-DO; Tue, 07 May 2024 05:18:55 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e46dcd8feaso1066633b3a.2; 
 Tue, 07 May 2024 02:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715073533; x=1715678333; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BrDmWQ5RkziQ6JRvc8PlQszqB9p0enhjKo03QqLJ5WI=;
 b=jGqn8XtxumOQTVmK6qe6miiW1/OKgOTkxuXCzgTU+rvKo8GBme8jO/il1NMKYOdQQw
 k9fYnl3kbuE7agOr+o1hof2LvQGsi7X9L3OprVdbggzndgVH9q3dhNjdXs92TEBukHXS
 PpJ85H3JJfD5IAKW0V/Ku2fW9xZz9X+JAslS7hAEMgK5gxTF97KFPzoFiCAzBP0q3XKH
 lPZDnpraZHBTrMMM1vPUGHCcJF4QVqufPLLUVicxHn2TvSO5dHu1xBPpP+7gNSJU19eb
 +SNiDQv+9VycrUuipjnz/rLE+M3g/9v5EjZLy6FKOwTFaW7vKx8qFupaCByxdAngorXJ
 nhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715073533; x=1715678333;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BrDmWQ5RkziQ6JRvc8PlQszqB9p0enhjKo03QqLJ5WI=;
 b=hCUnBiE7PwOYMQlkwP34umk0TU1fD/Ph5Myjo/Yi3+LMDI4Pf5muZgjbRUCB3nyMMH
 1QQh9ddpW8qv6SxQymQx0sz/KmizJr6pgxxypl4GwYW97kqCSw9tmoZZ//fLOxeHy+zs
 JcW1T33xHEEcDDWCsSohdLaNZOE6995PihXb6livNYry3SjOG2+j3JfmwQ758dCF42GC
 06KpVc3bYkADBYqZCznro1AtRRs+VmpWh6MrgX9GQrZNRTyOnuf/cCApE4FamQF8+gGA
 thiZ99J3cR+vH/i7Bj3uyRdxEoq4VxGVBxcIPfTmlIO4GJgZr9rper0f2nWJGCmY7wCP
 ATIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKblmSc4TMIXiDz9YQzoN1uk+NPjpkyETOM+yEqstpK/Mg82Jd8BLJ9/muMs6A14TOQQuiRhwhHXHAHyg2vdzVj9p+xMGaFBF07tU4/L2g4ID4FuSikxDZSs8=
X-Gm-Message-State: AOJu0Yz4xxSFeM2ss0AAyOe7VDg0Oq9WZX5eEsWeA8EwFdxrwUG1K/Cm
 75tpXpKbZv6G++4u6uQ9VQBGiBvksEjYzzkSRiBeIb/YjLq4/uck
X-Google-Smtp-Source: AGHT+IHmxHDWwcoxFhbyyOjlb5qbgUlRzmoaEsIo8IvrzND2MH2DBqFDFUxpXJIENTDzF2qMrF2jrw==
X-Received: by 2002:a05:6a21:3941:b0:1af:a45a:ab78 with SMTP id
 ac1-20020a056a21394100b001afa45aab78mr7813589pzc.9.1715073532598; 
 Tue, 07 May 2024 02:18:52 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 x21-20020a170902ea9500b001e510b3e807sm9454370plb.263.2024.05.07.02.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 02:18:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 19:18:46 +1000
Message-Id: <D13ATP0YSIZ8.2SHHJEA9VROT5@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 04/28] target/ppc: Remove unused helper
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <747ae7cc484e0d9387fd7647381009005cd81833.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <747ae7cc484e0d9387fd7647381009005cd81833.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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
> The helper_rac function is defined but not used, remove it.
>
> Fixes: 005b69fdcc (target/ppc: Remove PowerPC 601 CPUs)
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviwed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/helper.h     |  2 --
>  target/ppc/mmu_helper.c | 24 ------------------------
>  2 files changed, 26 deletions(-)
>
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 86f97ee1e7..f769e01c3d 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -700,8 +700,6 @@ DEF_HELPER_2(book3s_msgclr, void, env, tl)
> =20
>  DEF_HELPER_4(dlmzb, tl, env, tl, tl, i32)
>  #if !defined(CONFIG_USER_ONLY)
> -DEF_HELPER_2(rac, tl, env, tl)
> -
>  DEF_HELPER_2(load_dcr, tl, env, tl)
>  DEF_HELPER_3(store_dcr, void, env, tl, tl)
>  #endif
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index c071b4d5e2..817836b731 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -595,30 +595,6 @@ void helper_6xx_tlbi(CPUPPCState *env, target_ulong =
EPN)
>      do_6xx_tlb(env, EPN, 1);
>  }
> =20
> -/***********************************************************************=
******/
> -/* PowerPC 601 specific instructions (POWER bridge) */
> -
> -target_ulong helper_rac(CPUPPCState *env, target_ulong addr)
> -{
> -    mmu_ctx_t ctx;
> -    int nb_BATs;
> -    target_ulong ret =3D 0;
> -
> -    /*
> -     * We don't have to generate many instances of this instruction,
> -     * as rac is supervisor only.
> -     *
> -     * XXX: FIX THIS: Pretend we have no BAT
> -     */
> -    nb_BATs =3D env->nb_BATs;
> -    env->nb_BATs =3D 0;
> -    if (get_physical_address_wtlb(env, &ctx, addr, 0, ACCESS_INT, 0) =3D=
=3D 0) {
> -        ret =3D ctx.raddr;
> -    }
> -    env->nb_BATs =3D nb_BATs;
> -    return ret;
> -}
> -
>  static inline target_ulong booke_tlb_to_page_size(int size)
>  {
>      return 1024 << (2 * size);


