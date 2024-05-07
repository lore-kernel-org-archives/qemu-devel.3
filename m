Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D3EC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Hfg-0001k7-Dz; Tue, 07 May 2024 06:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4Hfe-0001jJ-UP; Tue, 07 May 2024 06:03:38 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4Hfd-00026V-91; Tue, 07 May 2024 06:03:38 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-36c703d13e6so12636195ab.3; 
 Tue, 07 May 2024 03:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715076215; x=1715681015; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7aJ8DLnvlKe2mm6bmvpsdaGAMKDtrV44/uy3OXpS4g=;
 b=H81asOj0o8fOdjjx5amHQcPZ0Rq/+6zqd+ye4juIsKKfuTqSWBi22XEtHLzRNgGi5H
 oPirrbdKrWUUKFwhXXpxuAlNU4nP7ebL9upB0mPrpDzOqwDbQeOJaoXzdFBkFl1q2m1V
 YQw+EnJQJUtcO+nXARQyCimUmOhAix1eGKFM9orMdZD2Mi6WGCc2u3A5mwGu1RHI8Rmr
 GXoapbsT5WF0zRtaCJTnRayFOXWIkcz+69E/TS/SR3kb3m1xG78Nis1YbKpAZP+KUIzb
 A851JWw3iX0DY1CLRSB7ocj5Qfw0CQ3DoAnaEZMN8VCVEUbTKhVPRNam1QhAz6zG6KWz
 Oc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715076215; x=1715681015;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q7aJ8DLnvlKe2mm6bmvpsdaGAMKDtrV44/uy3OXpS4g=;
 b=jhfrII3ESkUbQYGzBX3NYS6CPe2BDgugo6TmcxcLLNEnFmIQlWm+HA/huR2d6gMByU
 3Okkt8l6nt5K0CJH3sfL26t1CxdobV/so8XG3v3aIIgGsumltAG1iga+s4F/xEisq/Tp
 RnbvWHWE0QzdZrCK7tgTlmOnz4BBdLBvpLEZBzdoxDP54sFIIl/rlR1+b51nmsJRZAmo
 6i1aKunUFicQOMn6Z4IMsf3XJv+xDR7x6yFj8xpylKrt6GC0s+SCIzkOZBs8rqA+CeXV
 Fsu+bE+ZKcx8HZ1bqTPxKx3A1MuR/jynsCdnnD+gHPyBurXCFvqSoi+4jjsh+b9g8T/e
 OepQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSBI51DEWM243/7BJP3RQtS/gkJGlA3s5W8KcRF4ul6BZcr2gVEvWzoGhw3YEtxDaXPp05RAMKUAtRunr9Uvqs63auhk9fmd8Fzv2RS+7RU+uf/t247tvuvZY=
X-Gm-Message-State: AOJu0YxH+lHvL0w99eqUAO19AXnOGrLVqPrkFbw/O5ysEDUSRZwyxSCe
 yjFKgwognsRhQC/bzL9PvTRR0mMBUKrZDXRPS+qBrIJ0nBLeW8+r
X-Google-Smtp-Source: AGHT+IGW2LXTtw7zvP51VFlI6xwfTbjC/hS6GnmcYyRiCg48Gsci/hiKqDwpCWEvyb6EKMdZSNV3GA==
X-Received: by 2002:a92:cd8b:0:b0:36a:fe5f:732d with SMTP id
 r11-20020a92cd8b000000b0036afe5f732dmr16400557ilb.12.1715076215626; 
 Tue, 07 May 2024 03:03:35 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 l184-20020a6388c1000000b0061c9b4f2f17sm7912272pgd.45.2024.05.07.03.03.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 03:03:35 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 20:03:30 +1000
Message-Id: <D13BRY8Z2TYJ.2OKOJAUMQW9PG@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 15/28] target/ppc/mmu_common.c: Simplify
 mmubooke_get_physical_address()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <64b67465625047cca82742a59a520d51359b853b.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <64b67465625047cca82742a59a520d51359b853b.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x136.google.com
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
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mmu_common.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index fab86a8f3e..760e4072b2 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -665,31 +665,24 @@ static int mmubooke_get_physical_address(CPUPPCStat=
e *env, mmu_ctx_t *ctx,
>                                           MMUAccessType access_type)
>  {
>      ppcemb_tlb_t *tlb;
> -    hwaddr raddr;
> -    int i, ret;
> +    hwaddr raddr =3D (hwaddr)-1ULL;
> +    int i, ret =3D -1;
> =20
> -    ret =3D -1;
> -    raddr =3D (hwaddr)-1ULL;
>      for (i =3D 0; i < env->nb_tlb; i++) {
>          tlb =3D &env->tlb.tlbe[i];
>          ret =3D mmubooke_check_tlb(env, tlb, &raddr, &ctx->prot, address=
,
>                                   access_type, i);
>          if (ret !=3D -1) {
> +            if (ret >=3D 0) {
> +                ctx->raddr =3D raddr;
> +            }
>              break;
>          }
>      }
> -
> -    if (ret >=3D 0) {
> -        ctx->raddr =3D raddr;
> -        qemu_log_mask(CPU_LOG_MMU, "%s: access granted " TARGET_FMT_lx
> -                      " =3D> " HWADDR_FMT_plx " %d %d\n", __func__,
> -                      address, ctx->raddr, ctx->prot, ret);
> -    } else {
> -         qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
> -                       " =3D> " HWADDR_FMT_plx " %d %d\n", __func__,
> -                       address, raddr, ctx->prot, ret);
> -    }
> -
> +    qemu_log_mask(CPU_LOG_MMU,
> +                  "%s: access %s " TARGET_FMT_lx " =3D> " HWADDR_FMT_plx
> +                  " %d %d\n", __func__, ret < 0 ? "refused" : "granted",
> +                  address, raddr, ctx->prot, ret);
>      return ret;
>  }
> =20


