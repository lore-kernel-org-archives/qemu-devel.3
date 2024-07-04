Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5882C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFlL-0007B1-7M; Thu, 04 Jul 2024 02:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFlI-00072t-VM; Thu, 04 Jul 2024 02:16:09 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFlH-000707-B1; Thu, 04 Jul 2024 02:16:08 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70af9f7104cso229317b3a.3; 
 Wed, 03 Jul 2024 23:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720073766; x=1720678566; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjX4Nl9mKhKT0Bq+REbqGD4hiDf8un+CVlwQQRLI278=;
 b=g5dpnjzkDBDT70CgbIlTAL/K7M32mJlagwqw6YqK7wMRyXrPQor2JROkRXp4C7i5RV
 8CkQffarxCR7JPrmqc4uWo3D72aNOSU0Bz2FRnjwUGjMxBNv99c1XWwoAVsvixCftSYZ
 ZYdx+id6fgfLBGda4gMTm3fv0NnSKcjDodBW6aZ1CAZ1tdE40GBVp+jJ7NGvPhj4xYL/
 /HI6ol01rFHmn2Vpa5S8etDIuJUkJKY3gn+duUvYtirNYWjwaGLk6zUouHOTtRqXJm56
 7ZFAIXEaXErSU7SluZCIlN/kE0OikOE1KZerrGABBlH979jkkF867pUNs6Aiu1wzOsgP
 PGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720073766; x=1720678566;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FjX4Nl9mKhKT0Bq+REbqGD4hiDf8un+CVlwQQRLI278=;
 b=ig+SbfxSZUE3ahJBC+6UMhut2Vyj7qTPxNNv41r3mEOUZ2A//YPYYrHQAXHo7sxZjt
 sawT10LOD2AfvWpayPxupF8G2fqpMy1tNIioURiupGYHQO0WNHN/EiQB2cZMVnubKarv
 HLx8IL6UCrlGDE4ap7vt+fqb8hfa9hohobdZSgGd8NeIMx0hSNi42SQrH+WDZosvWzif
 +t6rTNy3yieQ2B1k7PGhR8JoFEPspF7h62L7OST9z7JlgZfj3O3+Ywpi4u0uy6yESn6k
 eIUBK710gA9a7cqLOc2TFnWka3XYV1zjrGz0Pq/KWKL9qlocpdnDUBdbrv/eAXPClHot
 RG+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/EZi9gCI4KK3iGcuYChz4hgtA2Tv8UPFrQk4B2j9Kw16/Mu5Vp9ZbsrJlxaTSlBSHSeFacXH15e3rRp2xLHLVWx8GYnUlXw7d7qplG/yNLtHyEXF/UZYZJxw=
X-Gm-Message-State: AOJu0YzaPgOo4qbBzVRDLW9O2/kMyCNRk/I/s04gBtFYieLYD1T6JjCn
 nDHsUhcDeG9I5M6iXnDxNWNaf4qReREKtDRkENIV6ErMbpYbsoBOkjRX5Q==
X-Google-Smtp-Source: AGHT+IHO3nRG7UWbcs5W2q2fNSrPWy+AFQsgu32qiJQcJJX3MtwS0Det3rBEYnTZIJ+bB8cC7VMMtw==
X-Received: by 2002:a05:6a00:9298:b0:70a:f576:beeb with SMTP id
 d2e1a72fcca58-70b0095a1ffmr799383b3a.15.1720073765580; 
 Wed, 03 Jul 2024 23:16:05 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b0193744bsm373003b3a.163.2024.07.03.23.16.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 23:16:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:16:00 +1000
Message-Id: <D2GJ9CTUAQ0L.3QYAB5K6FJSYF@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 14/43] target/ppc/mmu_common.c: Remove single use local
 variable
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <a3b3b04f1a1d2b31e044419cbcdabff92743cc57.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <a3b3b04f1a1d2b31e044419cbcdabff92743cc57.1716763435.git.balaton@eik.bme.hu>
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

On Mon May 27, 2024 at 9:12 AM AEST, BALATON Zoltan wrote:
> In mmu6xx_get_physical_address() tagtet_page_bits local is declared
> only to use TARGET_PAGE_BITS once. Drop the unneeded variable.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 5145bde7f9..0152e8d875 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -321,7 +321,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>      PowerPCCPU *cpu =3D env_archcpu(env);
>      hwaddr hash;
>      target_ulong vsid, sr, pgidx;
> -    int target_page_bits;
>      bool pr, ds, nx;
> =20
>      /* First try to find a BAT entry if there are any */
> @@ -338,7 +337,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>      ds =3D sr & SR32_T;
>      nx =3D sr & SR32_NX;
>      vsid =3D sr & SR32_VSID;
> -    target_page_bits =3D TARGET_PAGE_BITS;
>      qemu_log_mask(CPU_LOG_MMU,
>                    "Check segment v=3D" TARGET_FMT_lx " %d " TARGET_FMT_l=
x
>                    " nip=3D" TARGET_FMT_lx " lr=3D" TARGET_FMT_lx
> @@ -347,7 +345,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>                    (int)FIELD_EX64(env->msr, MSR, IR),
>                    (int)FIELD_EX64(env->msr, MSR, DR), pr ? 1 : 0,
>                    access_type =3D=3D MMU_DATA_STORE, type);
> -    pgidx =3D (eaddr & ~SEGMENT_MASK_256M) >> target_page_bits;
> +    pgidx =3D (eaddr & ~SEGMENT_MASK_256M) >> TARGET_PAGE_BITS;
>      hash =3D vsid ^ pgidx;
>      ctx->ptem =3D (vsid << 7) | (pgidx >> 10);
> =20


