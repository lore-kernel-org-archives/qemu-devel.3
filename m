Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B675DC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 06:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4x3H-0004Yp-Dz; Thu, 09 May 2024 02:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4x3F-0004Tj-KX; Thu, 09 May 2024 02:14:45 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4x39-0008Mt-Na; Thu, 09 May 2024 02:14:45 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f457853950so1161354b3a.0; 
 Wed, 08 May 2024 23:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715235278; x=1715840078; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2l/A5o72dMeHtpzGJl2SSRb6ErGw8w3qfU4pXOZpbJc=;
 b=N8W7PZ17hsm1r8dD/cOpFrR6FwNYxq208ZbMa3I1ksIHsnsmLpXy4IMQnnD8/LG53p
 dMLiEJMN71YiCdLjErxILLhohv408nOJzCDUWCsiU9iHrzZCQiVzRWgUS6QHo/66EdFW
 4d7wDpb0mun85sx74zfhYCEDSt2z9yK+vAdoCfATrSkVDSB2TvlNJVlXsnVj6LkjqnjE
 A5zfvj6JKVH7Vr61KOLLRQX/GUDyf87n9C9iZ11wdLaBhOWrOGbEnETKno/RRCzqF4wr
 Cmh9xn5iHVxZq0EnpVxjRadQ4nOKeT8fO6bODS0u8cWGk8zPdGRzlX4WhN+PpYECDqBD
 7stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715235278; x=1715840078;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2l/A5o72dMeHtpzGJl2SSRb6ErGw8w3qfU4pXOZpbJc=;
 b=FM4N96Kwl6x7zj2vUTcLEmgbKHbgoHUPmihvuZhsrntL1tFr9mTrQli3AGyHKjpYJ3
 QPHQgJ79QLlwT/boCFeiSSfIlPC1BDoL9vUUyB1t1Zox3FIu4WUE2bVQFTmWqX9FtUis
 OJvBG6ltLNkErc95LFSIb58UzaRGRuUJgIq7PqmlX0Ooh0t7eXbuVkP2kMf/s1jRWNpO
 pP6pt8F2ZyJN7cxXw6pLgmi2fbKQDktlOfFp92/7Y0PHNO7vjKBOzuaBiR+pD6Nw9ETI
 hEyywg0XF7AdY1N0ws7dtTLxf5wmOHcArD96xwP31eb3WThOfHLhmGzCTn/CoURGM23a
 DeNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3h6YkWAbGiWS+atA0tDQ6w5bs2ItNzEykFqyflVCst9bg1NL4i8bqfR7VC983mj8q7F1rVfq/HZjdgHFxx29bfoCr/UF0HY3lzWTaJuyQGIJJDHPknFVukwY=
X-Gm-Message-State: AOJu0YwbYCSEQxCsVbm1tP7Te1PVuwWA32pWQSCX9ZXGh4IyqeTTkHrv
 OIVm5GzWvcrBI1eaO9/lVumvYbOl9EEawM39jyjKKtm54U+P0zVQ
X-Google-Smtp-Source: AGHT+IGSEceSAoEsPkXSa8dq9OTVWaQvkxJ9m0odFkbQpkFx/PvvFXz2Mvk+q35/ZQSuvHA2SorMrA==
X-Received: by 2002:a05:6a21:3989:b0:1af:58b7:763e with SMTP id
 adf61e73a8af0-1afd14663eemr2504347637.14.1715235277765; 
 Wed, 08 May 2024 23:14:37 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a86fb3sm568904b3a.86.2024.05.08.23.14.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 23:14:37 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 May 2024 16:14:33 +1000
Message-Id: <D14W5QEI5JES.2M7I0HWIYQ90K@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v4 21/33] target/ppc/mmu_common.c: Don't use mmu_ctx_t
 in mmubooke206_get_physical_address()
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1715209155.git.balaton@eik.bme.hu>
 <51e1927e3b17781f237e5a8802ad76cdca2c64eb.1715209155.git.balaton@eik.bme.hu>
In-Reply-To: <51e1927e3b17781f237e5a8802ad76cdca2c64eb.1715209155.git.balaton@eik.bme.hu>
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

On Thu May 9, 2024 at 9:36 AM AEST, BALATON Zoltan wrote:
> mmubooke206_get_physical_address() only uses the raddr and prot fields
> from mmu_ctx_t. Pass these directly instead of using a ctx struct.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 32 ++++++++++----------------------
>  1 file changed, 10 insertions(+), 22 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 8c1c7b1851..bffa06455d 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -837,27 +837,22 @@ found_tlb:
>      return access_type =3D=3D MMU_INST_FETCH ? -3 : -2;
>  }
> =20
> -static int mmubooke206_get_physical_address(CPUPPCState *env, mmu_ctx_t =
*ctx,
> -                                            target_ulong address,
> +static int mmubooke206_get_physical_address(CPUPPCState *env, hwaddr *ra=
ddr,
> +                                            int *prot, target_ulong addr=
ess,
>                                              MMUAccessType access_type,
>                                              int mmu_idx)
>  {
>      ppcmas_tlb_t *tlb;
> -    hwaddr raddr;
> -    int i, j, ret;
> -
> -    ret =3D -1;
> -    raddr =3D (hwaddr)-1ULL;
> +    int i, j, ret =3D -1;
> =20
>      for (i =3D 0; i < BOOKE206_MAX_TLBN; i++) {
>          int ways =3D booke206_tlb_ways(env, i);
> -
>          for (j =3D 0; j < ways; j++) {
>              tlb =3D booke206_get_tlbm(env, i, address, j);
>              if (!tlb) {
>                  continue;
>              }
> -            ret =3D mmubooke206_check_tlb(env, tlb, &raddr, &ctx->prot, =
address,
> +            ret =3D mmubooke206_check_tlb(env, tlb, raddr, prot, address=
,
>                                          access_type, mmu_idx);
>              if (ret !=3D -1) {
>                  goto found_tlb;
> @@ -867,17 +862,10 @@ static int mmubooke206_get_physical_address(CPUPPCS=
tate *env, mmu_ctx_t *ctx,
> =20
>  found_tlb:
> =20
> -    if (ret >=3D 0) {
> -        ctx->raddr =3D raddr;
> -         qemu_log_mask(CPU_LOG_MMU, "%s: access granted " TARGET_FMT_lx
> -                       " =3D> " HWADDR_FMT_plx " %d %d\n", __func__, add=
ress,
> -                       ctx->raddr, ctx->prot, ret);
> -    } else {
> -         qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
> -                       " =3D> " HWADDR_FMT_plx " %d %d\n", __func__, add=
ress,
> -                       raddr, ctx->prot, ret);
> -    }
> -
> +    qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " =3D> "
> +                  HWADDR_FMT_plx " %d %d\n", __func__,
> +                  ret < 0 ? "refused" : "granted", address,
> +                  ret < 0 ? -1 : *raddr, *prot, ret);
>      return ret;
>  }
> =20
> @@ -1136,8 +1124,8 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu=
_ctx_t *ctx,
>          return mmubooke_get_physical_address(env, &ctx->raddr, &ctx->pro=
t,
>                                               eaddr, access_type);
>      } else if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
> -        return mmubooke206_get_physical_address(env, ctx, eaddr, access_=
type,
> -                                                mmu_idx);
> +        return mmubooke206_get_physical_address(env, &ctx->raddr, &ctx->=
prot,
> +                                                eaddr, access_type, mmu_=
idx);
>      }
> =20
>      real_mode =3D (type =3D=3D ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR,=
 IR)


