Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8500C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFlJ-00073V-Uq; Thu, 04 Jul 2024 02:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFlA-0006vc-S1; Thu, 04 Jul 2024 02:16:01 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFl7-0006jC-SF; Thu, 04 Jul 2024 02:15:59 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fab03d2f23so1834805ad.0; 
 Wed, 03 Jul 2024 23:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720073756; x=1720678556; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6EBnC1/+NqOLswNVR0ga33UDffFVJ3Bk8tIRtt7oE4k=;
 b=bYljc+CCuVLi4O3jh13ui+3RW3a0nXBUDH1lFhEaIpPYZ2UxizqWH1ZYIw0tzC77se
 nLdGqr+75diXosPFj1ryl20qryS+Xzx9jC7FDQUsFtqOcNHRmqMbl8zpg6zqVGPji7Sp
 hGQUddq6n7KUEDJqV9URGpZzWAk0LJrDtgEXBx8WFrtmHtsruJyCOA5hIqLfwgqzKyC+
 4LFztKEjDCcLPcPH9lqpM4yEijs5ilJad1wDbuHBGFpKMoOpz0lt4CWPiEspm/05X2Or
 Vm0+yqhcbvHj7BSA/829+IimQJhF7MlQlylrKKVSK2jplYTxYX5w4on9mCTBGJqVXVJb
 Ullw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720073756; x=1720678556;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6EBnC1/+NqOLswNVR0ga33UDffFVJ3Bk8tIRtt7oE4k=;
 b=stxcSeA+gk1TY0iFWATXt5lIHJA+I43YJfdTQj5bUcaKKL2cyQD+9SzHXRmD0S6XNR
 uluDfaeeXLfm2FzIMBGPFI0NE34meRH6J5bntHCW97AD/d8vYk9AjIp8mzqoMTuTOX8J
 kBq3xws9yeiqFC1vao1J52Fy7gBtlsjO0NIkp6zeF+OwjgxqXXRK7hjr42boLeRsnqpe
 OaUStauR2DAJHWx9ok84a8aBLW1Btyra3pzxKYuFgJUK9KT2k7V1KmSoFeGo+/Q0vT3Z
 h5Ni0TZYdcQw8Dgp8wSEILWIF5pvfakG0le707I9YDTsIZFFCRf9aCwUdOA1JQhC1ttf
 e5nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxP3QCvU9uql8XtGHrkL8GQh/175pPUyRbLLvGbQtksc1+/tjAlFjMF3LLof+rgYeek3njkxcItIsThaTpCwNue94XRUj8ZcHOcR3mjdZNWt9sJYiQUO7kA4o=
X-Gm-Message-State: AOJu0Yzf3Zt2ypyNgwYAmfOHW66ZTc81T40VbzvKk0soSK13jMdYuREs
 G07Fb9uNzNTOSkUcILgB795GElS6dpwjqN91JAZ8KEshfU/lJ+cQt0uCTg==
X-Google-Smtp-Source: AGHT+IGGLormwx1sFZj3EvciP0SsM2B2Aksxiql0t3v5KsIlRq+Lpy9SZeC0+U7p1aNho8qo0fKfDQ==
X-Received: by 2002:a05:6a20:9145:b0:1be:6bbe:5ffe with SMTP id
 adf61e73a8af0-1c0cc8c95efmr569374637.38.1720073756087; 
 Wed, 03 Jul 2024 23:15:56 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99a9d122esm620690a91.42.2024.07.03.23.15.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 23:15:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:15:50 +1000
Message-Id: <D2GJ98DMRI3H.1OSSIJCQEPV40@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 13/43] target/ppc/mmu_common.c: Convert local variable
 to bool
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <cda242dffbdbf2634869c8a5f0c723d3d362afa5.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cda242dffbdbf2634869c8a5f0c723d3d362afa5.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

On Mon May 27, 2024 at 9:12 AM AEST, BALATON Zoltan wrote:
> In mmu6xx_get_physical_address() ds is used as bool, declare it as
> such. Also use named constant instead of hex value.

Oh nx was bool, ignore my previous comment then.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 9f402a979d..5145bde7f9 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -321,8 +321,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>      PowerPCCPU *cpu =3D env_archcpu(env);
>      hwaddr hash;
>      target_ulong vsid, sr, pgidx;
> -    int ds, target_page_bits;
> -    bool pr, nx;
> +    int target_page_bits;
> +    bool pr, ds, nx;
> =20
>      /* First try to find a BAT entry if there are any */
>      if (env->nb_BATs && get_bat_6xx_tlb(env, ctx, eaddr, access_type) =
=3D=3D 0) {
> @@ -335,7 +335,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>      sr =3D env->sr[eaddr >> 28];
>      ctx->key =3D (((sr & 0x20000000) && pr) ||
>                  ((sr & 0x40000000) && !pr)) ? 1 : 0;
> -    ds =3D sr & 0x80000000 ? 1 : 0;
> +    ds =3D sr & SR32_T;
>      nx =3D sr & SR32_NX;
>      vsid =3D sr & SR32_VSID;
>      target_page_bits =3D TARGET_PAGE_BITS;


