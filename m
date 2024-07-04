Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C37C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 05:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFVB-0001tL-BM; Thu, 04 Jul 2024 01:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFV3-0001j2-2w; Thu, 04 Jul 2024 01:59:21 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFV1-0000Ss-Fv; Thu, 04 Jul 2024 01:59:20 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5ba33b08550so134798eaf.2; 
 Wed, 03 Jul 2024 22:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720072758; x=1720677558; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qL46qZ39H+Xg0tFz1xXVpwUV2bwPeooEv4hRjyzxPC4=;
 b=E8v6T1AxubX2tODdS91NZvQOxE6+jP0hcTjqjFJLCUJTnq9hMqMzoZeXBBpgWtnVF8
 edWjVLkDbbTQBB35TsIuvOiB4ksDDJxqgOGjmGzfCKE6jdckqWR+O5e78wOxmZpQDVPN
 Ysfl0XR3fgyf2RV5G9almZo4R2Rqjug3zMUzu1NAkUXqzxiHgRCD3uXEYSxsjEAZVp7t
 OZIKj6qbBIjNP5UWzvzWBoCgmANO5ShfxY+UR7il23n9WZ0XwxbI3hX11DBxgubXK+6T
 67o/opAsK1eqjyM5nyACNhnO9J5FIyHzp0MXmJ//XDLMMUij6gmZpx3XEBZa7cSDnYH9
 T8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720072758; x=1720677558;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qL46qZ39H+Xg0tFz1xXVpwUV2bwPeooEv4hRjyzxPC4=;
 b=s2N/+4pKeWgoPjjqgSBBtRRz8wvMWYrwH046nMi/cvwBLZCb+cBKH901eYl4a5+Qsn
 SEU48wB4ElkYe8yiKztXbFKtU3mxHWnHO3LcmrNQKOJhtCNK9AuW8oCD6loqO7ekOVys
 xL1YL37hXuCBGpGbpICPVUja0ustxGc7iSeFroENHD60gQgl85+xMxqVwjzPpnqJtVvP
 +1k7lAPF4E/aJrnP4KnKTvUIXy6nWIpk5Y6TIKNN2lRAVfxOvGSdLNVZiRyS8AZ6x7mJ
 VDBhpGoZyms6LbG3P6Grv75Q3NDTvKkSo1UoXmgOKWXAG18hn8NAIJ4hnF5OqhxTnmet
 GZqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOVohQ5k/kercHhf4ZTPq6Ix95qbYp53F0R2UfIP2gK1f7v2bw7TUAHBY/TQcnPDMjATZpfKHxbFvwe/z5HiFkTKR3l6Gx9WEE0M1ABrl1v3V1ytV4ZP2IVbE=
X-Gm-Message-State: AOJu0YzPuVjWnJJDX5ABA7F15QUUbQtIb9ZC7524KezF/nAumHfVM25o
 NlyJrtHnu7Npan3D5WLBEjp7y0btTdBrjytNxFGHvqPa5e3eO/o7
X-Google-Smtp-Source: AGHT+IEwUZ83hv9FbK+DW+8Pb/+x+ZLhSbseQejp4z7VOZAQoG606Ez2CXQpfAt+BtT0nHyZRx52dQ==
X-Received: by 2002:a05:6358:2792:b0:19f:346d:d1d1 with SMTP id
 e5c5f4694b2df-1aa98c21547mr62327855d.16.1720072757689; 
 Wed, 03 Jul 2024 22:59:17 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99a8057b8sm607568a91.0.2024.07.03.22.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 22:59:17 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 15:59:12 +1000
Message-Id: <D2GIWHXXMYBR.1VBDNSF87G7OY@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 05/43] target/ppc/mmu_common.c: Remove another single
 use local variable
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <fef23749d9832afc1dd45d1a1ddd492a4198c451.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <fef23749d9832afc1dd45d1a1ddd492a4198c451.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc35.google.com
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
> In ppc6xx_tlb_pte_check() the pteh variable is used only once to
> compare to the h parameter of the function. Inline its value and use
> pteh name for the function parameter which is more descriptive.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mmu_common.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 16578f7fa5..b21f52290f 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -95,15 +95,14 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong =
eaddr,
>  }
> =20
>  static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
> -                                target_ulong pte1, int h,
> +                                target_ulong pte1, int pteh,
>                                  MMUAccessType access_type)
>  {
> -    int ret, pteh, pp;
> +    int ret, pp;
> =20
>      ret =3D -1;
>      /* Check validity and table match */
> -    pteh =3D (pte0 >> 6) & 1;
> -    if (pte_is_valid(pte0) && h =3D=3D pteh) {
> +    if (pte_is_valid(pte0) && ((pte0 >> 6) & 1) =3D=3D pteh) {
>          /* Check vsid & api */
>          pp =3D pte1 & 0x00000003;
>          if ((pte0 & PTE_PTEM_MASK) =3D=3D ctx->ptem) {


