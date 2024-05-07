Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFD8C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4K7o-0006Kb-M5; Tue, 07 May 2024 08:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4K7Z-0006Fm-3v; Tue, 07 May 2024 08:40:38 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4K7W-00056f-Eq; Tue, 07 May 2024 08:40:36 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5ad2da2196bso1519082eaf.3; 
 Tue, 07 May 2024 05:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715085632; x=1715690432; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LiwPL2CtC+PD+ASVZMatvoEJvdaZbT3OQz+0RdeBp4I=;
 b=UqyLLD8/fAaFmHWFP4HjqtDrv5aEe013xBeFGuWaAg6osJ1JbVtLJpgtvfvq68KVy3
 J7rNvue9NHtFBBKXbgr4Em1hYpyHAkjOjUxh+gXugiDWYEERAPVIPadj+B6cudmDqVQB
 DsBl1e+R9BIEO+uC5iMSeQ4uPMdWvpVDT+N33FaG/vOnleRcjY1mF7Akjx4PoOq6AXyE
 1SxRAS7ZGxs272IFwGnWojWsUkLPX7L0bmV3/0fmSqQgUqaTy5MZNQUE+4Z/iKFAt9nw
 uWTgNhj6IKN4LJWOeYvfyanbGMqd/wG4ouI762Yrrc5/6YPhj9ZE3xJuvNqmYP6vljb4
 LeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715085632; x=1715690432;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LiwPL2CtC+PD+ASVZMatvoEJvdaZbT3OQz+0RdeBp4I=;
 b=dWCF5Yw8pPyJwtSVYis8qCMcj/bD9YKJ3qPty+8fkw2mSSLuPLfk9XwfId/RofQylH
 OrAUF56MlJknVmR9OTdQYYmSPRUckjzyjDLlBtSvGrpk7h2pomjEtRnVAY1Kmkm9Hj0L
 7kuYZW4aon4l43eVor3N7eqoo/4D2SL05/49uhknW3c2NcML1ej+LZgxLM0rmfHvyMdV
 dDVZ45v7A/cQg6SlVu0iAAx5GuO2tkU4dk9IhfKTQ+xLd5kbT9U93/JNGF/MPoi46ltW
 6/ENMAr0jJE0AgNMcygoGGTqC3gCMIDzu609fmVjM7VVP8eJOAl+ig9xUHY8rjHMDB7Z
 wm2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGlPqed8iEDhzay8+P/PksI2l4zx9XftbKAy7dAn6Qqz1s75P5S15rk2EAnEekZnIRmb4oyHPZ0t2f/Hhj73oiVJf16h/gTmXCziLUxaDeV+pF+tWQLTZG5ME=
X-Gm-Message-State: AOJu0Yw/74jqoU/u2oR5YcQYMNWUfja2npnLCQatwxufD/29/LTzJY4R
 K82Xs3DYw4OKB0/J+S6oODEu30iGnOORVuUrKvU7lbzpLytpt5Yv
X-Google-Smtp-Source: AGHT+IHE7TEK2YejsQx9Zth+0z/mHvpr0CnjJm4BSLbN3Ak5TxNM7lpGykwl3YwTr3s351RWeOQbfw==
X-Received: by 2002:a05:6358:70c3:b0:183:b7a0:8aa with SMTP id
 h3-20020a05635870c300b00183b7a008aamr10106175rwh.13.1715085632304; 
 Tue, 07 May 2024 05:40:32 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0061f42afa8d0sm6888135pga.6.2024.05.07.05.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 05:40:32 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 22:40:27 +1000
Message-Id: <D13F4451TLXZ.2Q4MCLTIOCK4H@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 28/28] target/ppc: Split off common 4xx TLB init
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <a99aeec44ad192f842d66f7514702bd5d5f912ad.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <a99aeec44ad192f842d66f7514702bd5d5f912ad.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc36.google.com
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
> Several 4xx related CPUs have the same TLB settings. Split it off in a
> common function in cpu_init.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/cpu_init.c | 46 ++++++++++++++++---------------------------
>  1 file changed, 17 insertions(+), 29 deletions(-)
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 07ad788e54..d7e85c1b07 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -2107,18 +2107,22 @@ static int check_pow_hid0_74xx(CPUPPCState *env)
>      return 0;
>  }
> =20
> +static void init_tlbs_4xx(CPUPPCState *env)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    env->nb_tlb =3D 64;
> +    env->nb_ways =3D 1;
> +    env->tlb_type =3D TLB_EMB;
> +#endif
> +}

e200 isn't 4xx though is it? Call it init_TLB_EMB()?

Otherwise,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick

> +
>  static void init_proc_405(CPUPPCState *env)
>  {
>      register_40x_sprs(env);
>      register_405_sprs(env);
>      register_usprgh_sprs(env);
> =20
> -    /* Memory management */
> -#if !defined(CONFIG_USER_ONLY)
> -    env->nb_tlb =3D 64;
> -    env->nb_ways =3D 1;
> -    env->tlb_type =3D TLB_EMB;
> -#endif
> +    init_tlbs_4xx(env);
>      init_excp_4xx(env);
>      env->dcache_line_size =3D 32;
>      env->icache_line_size =3D 32;
> @@ -2185,12 +2189,8 @@ static void init_proc_440EP(CPUPPCState *env)
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   &spr_read_generic, &spr_write_generic,
>                   0x00000000);
> -    /* Memory management */
> -#if !defined(CONFIG_USER_ONLY)
> -    env->nb_tlb =3D 64;
> -    env->nb_ways =3D 1;
> -    env->tlb_type =3D TLB_EMB;
> -#endif
> +
> +    init_tlbs_4xx(env);
>      init_excp_BookE(env);
>      env->dcache_line_size =3D 32;
>      env->icache_line_size =3D 32;
> @@ -2282,12 +2282,7 @@ static void init_proc_440GP(CPUPPCState *env)
>      register_440_sprs(env);
>      register_usprgh_sprs(env);
> =20
> -    /* Memory management */
> -#if !defined(CONFIG_USER_ONLY)
> -    env->nb_tlb =3D 64;
> -    env->nb_ways =3D 1;
> -    env->tlb_type =3D TLB_EMB;
> -#endif
> +    init_tlbs_4xx(env);
>      init_excp_BookE(env);
>      env->dcache_line_size =3D 32;
>      env->icache_line_size =3D 32;
> @@ -2355,12 +2350,8 @@ static void init_proc_440x5(CPUPPCState *env)
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   &spr_read_generic, &spr_write_generic,
>                   0x00000000);
> -    /* Memory management */
> -#if !defined(CONFIG_USER_ONLY)
> -    env->nb_tlb =3D 64;
> -    env->nb_ways =3D 1;
> -    env->tlb_type =3D TLB_EMB;
> -#endif
> +
> +    init_tlbs_4xx(env);
>      init_excp_BookE(env);
>      env->dcache_line_size =3D 32;
>      env->icache_line_size =3D 32;
> @@ -2717,11 +2708,8 @@ static void init_proc_e200(CPUPPCState *env)
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   &spr_read_generic, &spr_write_generic,
>                   0x00000000);
> -#if !defined(CONFIG_USER_ONLY)
> -    env->nb_tlb =3D 64;
> -    env->nb_ways =3D 1;
> -    env->tlb_type =3D TLB_EMB;
> -#endif
> +
> +    init_tlbs_4xx(env);
>      init_excp_e200(env, 0xFFFF0000UL);
>      env->dcache_line_size =3D 32;
>      env->icache_line_size =3D 32;


