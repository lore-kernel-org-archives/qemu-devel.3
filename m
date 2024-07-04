Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F46C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 05:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFUb-00014v-08; Thu, 04 Jul 2024 01:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFUP-0000rn-1l; Thu, 04 Jul 2024 01:58:44 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFUN-0000Om-4r; Thu, 04 Jul 2024 01:58:40 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70683d96d0eso202479b3a.0; 
 Wed, 03 Jul 2024 22:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720072716; x=1720677516; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dtbD8PWq6PjUaqJpeNwkKajPuZ4TmCEhqWB+66Lk0ow=;
 b=Np6QP2IxxSFH9CuSJmkLopTtACvAGK/G8gjUh0j0u/lLP4iujqPV1T8COMhiyYd3hH
 Ig3h1wKyS4acLK+kGsHn1E0OJQV+18Uci+/Kqtwln1q4tiZT8o5XBVazQlIPUsSrVdVC
 +P3bS/b82k8Jm39JrVUkV/0GI1mFQCbj1C9GdHuvzoQCQ0jYVy1BkCoHLn9OZrkdYbD0
 cf+YKz8OsuMQKHxQGwnCl4eB38BLV2EEVQiC0ogLRHQa3mHMSTEBK7b7w04NzSD3RUmN
 tjgYnoKvt8ao9eBEoYrDk7daGqQUGc597hCVrCKuZH7C42Okq7y77Zdzt+uMMnNO4tpf
 diFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720072716; x=1720677516;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dtbD8PWq6PjUaqJpeNwkKajPuZ4TmCEhqWB+66Lk0ow=;
 b=bNLzln9kJOWVJEXW2w/9FA+TBOCLxJWN0ZVwVtwy9W3h8J/oF7vY8ZTL3cLH20JTp/
 Pj8Eo/y7JReVCEH2bGqrZVctxUj5eVYFEHB1aoPqed5axExcM6KVD7eu5UA6xvZYmqOD
 Ljy7AngqBHyWmCOIUc5/3qM/ZqVc2FjvKpe5LuGKqldDjywE8efY71z/Pmy0Yt7y0yGv
 UranS9Lf2iir/R2CjphQ6BK1iDXP7ceand6OZw8IH3/ZTw4/iwAsYAhllTs7UlUxmaJu
 W0/YyESaeY8KXQ0POo0dVigH8pdf90A0aAj1FRoO3G5KkhR25iM2cLMSBkyQJjfaFVah
 r4CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXetUjXqNmjxLi5B09X3qa8AseVZKq3xm/3PSDnkqZwK63OYlUWi/pJB/vPBEKycWLskczBqTCgftglt2Og1SGXnKMuNI5H/ngaTk+IHWMJtH+mCZ6wflBIvzg=
X-Gm-Message-State: AOJu0YyB+Krs365wEZBaqNhoSKMJkA9C06MdtVDUlqEg1hACSW1q4aa3
 9IMVVlyceND9NfBxmSdyBfXT/QXO1qPwz3THBZiIz+AOmQbIGyBXcPFqcA==
X-Google-Smtp-Source: AGHT+IEBROjHGcLp85pkJEiti1tE0uwO2809HA9P0oxRzOQyLEEpAuoTytmOzccS1YpZgyU2VFTvpQ==
X-Received: by 2002:a05:6a20:a129:b0:1be:ce69:ca5f with SMTP id
 adf61e73a8af0-1c0cc736e74mr633780637.1.1720072716448; 
 Wed, 03 Jul 2024 22:58:36 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99aa607e4sm582490a91.40.2024.07.03.22.58.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 22:58:36 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 15:58:31 +1000
Message-Id: <D2GIVYWDGPPP.3DZH2NLV3MGAZ@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 04/43] target/ppc/mmu_common.c: Remove single use local
 variable
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <f8e3b71d33bca6fa2dec97b1a7b50dfaa5414210.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <f8e3b71d33bca6fa2dec97b1a7b50dfaa5414210.1716763435.git.balaton@eik.bme.hu>
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

On Mon May 27, 2024 at 9:12 AM AEST, BALATON Zoltan wrote:
> The ptev variable in ppc6xx_tlb_pte_check() is used only once and just
> obfuscates an otherwise clear value. Get rid of it.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mmu_common.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 371ec24485..16578f7fa5 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -98,13 +98,12 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, targe=
t_ulong pte0,
>                                  target_ulong pte1, int h,
>                                  MMUAccessType access_type)
>  {
> -    int ret, pteh, ptev, pp;
> +    int ret, pteh, pp;
> =20
>      ret =3D -1;
>      /* Check validity and table match */
> -    ptev =3D pte_is_valid(pte0);
>      pteh =3D (pte0 >> 6) & 1;
> -    if (ptev && h =3D=3D pteh) {
> +    if (pte_is_valid(pte0) && h =3D=3D pteh) {
>          /* Check vsid & api */
>          pp =3D pte1 & 0x00000003;
>          if ((pte0 & PTE_PTEM_MASK) =3D=3D ctx->ptem) {


