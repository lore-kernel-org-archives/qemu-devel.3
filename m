Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66B2C3271F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFY9-0005NZ-VP; Thu, 04 Jul 2024 02:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFY7-0005Md-Pw; Thu, 04 Jul 2024 02:02:32 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFY6-0003Gb-5G; Thu, 04 Jul 2024 02:02:31 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-754d2b05db5so155703a12.0; 
 Wed, 03 Jul 2024 23:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720072948; x=1720677748; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fW1kHwQW+ZQqfl6YzXuD5WAQD0U/p8pO3/HG5Kgcih8=;
 b=Rh/KXfiBAyS5+ed0eKKOpn5I56eWx/OELhilDCCt/tgkP+LQP80CZBFWU06cPrNp27
 bUHl6v65qm28SOc6XwL7+Ebr89qbEHmzF6KHwwdJ7pShK6eL4knDWhKcP95f0ixd7NyG
 FfqVmL+BVg+hDCWuXF8lD3qYnD2/LxY5V9ddP8YdhhmHm3Y5/RLb6lw4ZLYutTr7bibe
 9FssrLqHBv2IQVafpmfjGd6tJA/9nDAT1Eq9Jd2jGAGXMzou/LmUsiPGIvi7578NpVY2
 4NgWXzPLPQlacihcnzCGaibMGFf2vtU2Wg2GC1Xs+8t1ijFiMg4rnBnuvrMErYfnpSNB
 LBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720072948; x=1720677748;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fW1kHwQW+ZQqfl6YzXuD5WAQD0U/p8pO3/HG5Kgcih8=;
 b=G92JkgcZMtzapat6VWXxiFK/X2+v37YTszYaT9HDcYt92JOxn3Zw7LEsf6rL1hKcXZ
 jXChwzyXXT9vdjjpsyWaViikqjgTeIOaCtbYTWH4TUvR3VYmo+YVsRNi6hKSZPgm/cLT
 NXiwqjbSWxsXcBR+IVYWr/WUykorQ8LKjtQxsKw9BFPKd56XCSFKj0k0qJ0R/0xJ2Kw0
 rl7ZhsMHJNHAkW0Er6Dz686FFW89Zsz45f4b16S88BrymjKblI8TdfFntxNMxohkcK1Z
 NHE+hBRdtAcTXV6X86/00yUEN5Gf7NzO/4DxbgmvvjJ8DSOtHyZstMlRTEMBAu7r5awb
 2EcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM+bFR09snnCvQZeX9sNEZKkWQdMVDrx+dnsmDFnG1IPqm1Ew7CyMBi1lYaG3KXO9QZzy2izqtAA8QWhruFrPRDpYzV8c8szL5CeRJkfPWyL6deyGIHKxzc5M=
X-Gm-Message-State: AOJu0YzBsOAJcfOl9ByQ9CqUnCgVLLVPTAI6lGUa+5k8us9pebEi4NAo
 MOoFvb/610NGZCQ2GzLTu0Lm5NX31Z6KUKMIbYkphUlWarvJYZHv
X-Google-Smtp-Source: AGHT+IFEiRdWTAY8zzVDLHycGP9ZQJv9ssGHllTmzUlzIGM4KDcn4aV/118nhX2ECLXZBkVnPY7OPQ==
X-Received: by 2002:a05:6a20:da8e:b0:1bd:1d46:e6ca with SMTP id
 adf61e73a8af0-1c0cc8d6ea7mr551304637.50.1720072947879; 
 Wed, 03 Jul 2024 23:02:27 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99aab8e04sm587600a91.56.2024.07.03.23.02.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 23:02:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:02:22 +1000
Message-Id: <D2GIYX6CYSWW.2Y6J4P6XFM45S@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 09/43] target/ppc/mmu_common.c: Remove unused field from
 mmu_ctx_t
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <889571de5f25b4abdff5df829706286367b59cc9.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <889571de5f25b4abdff5df829706286367b59cc9.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x533.google.com
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
> The eaddr field of mmu_ctx_t is set once but never used so can be
> removed.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mmu_common.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 28adb3ca10..0a07023f48 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -40,7 +40,6 @@
>  /* Context used internally during MMU translations */
>  typedef struct {
>      hwaddr raddr;      /* Real address             */
> -    hwaddr eaddr;      /* Effective address        */
>      int prot;          /* Protection bits          */
>      hwaddr hash[2];    /* Pagetable hash values    */
>      target_ulong ptem; /* Virtual segment ID | API */
> @@ -348,7 +347,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
> =20
>      /* Perform segment based translation when no BATs matched */
>      pr =3D FIELD_EX64(env->msr, MSR, PR);
> -    ctx->eaddr =3D eaddr;
> =20
>      sr =3D env->sr[eaddr >> 28];
>      ctx->key =3D (((sr & 0x20000000) && pr) ||


