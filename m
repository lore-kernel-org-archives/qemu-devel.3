Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA13C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HcM-0008KP-DY; Tue, 07 May 2024 06:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4HcK-0008K8-TD; Tue, 07 May 2024 06:00:12 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4HcJ-0007kH-5C; Tue, 07 May 2024 06:00:12 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1eab16c8d83so21636255ad.3; 
 Tue, 07 May 2024 03:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715076009; x=1715680809; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zV8O19pdwQmkBxyYBvxO/m0TDrbIAC7Y5q95d//8bw=;
 b=LCD/c7gSdZprc7CFKrRJUp3MFd+iZs4zzay7kA8183vdCt2O9HJ1VdodYR46cv/htW
 E5x7UIl4wNLU6EsCWIHNpV6lqmbU/MGehzDKpsJBqWv9t17pOwMKuYIlBK63T7gahI6W
 fmYtOwFZzX8P4Wyv2V1rIVH3S7tysNHfkzip5TV9mhsS09VB2rllhB0yQEJIoMYMDS50
 xoKeM1zEJ3FtXtpMbcYb9oroyOm30nUBK0fk6cN7Rn7Yu8vRkTa+2QWt4IDl6zL30SfT
 VHH9raYu1dXLD36afCL0UDRIEK6IK8WmOMrRPoVt3FBkKcUK0t2w6J96XYDCH7894fEk
 5tGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715076009; x=1715680809;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8zV8O19pdwQmkBxyYBvxO/m0TDrbIAC7Y5q95d//8bw=;
 b=kQ+rC5WCuKz/QA4cev7i0CWd9l3RBYq38qsTi1BuNhigvD0UIc0cbWTN6jWouEHzr6
 HctsZuXEDsyR/yrP7d8zf2rPPMveYQMAuvd6fCsHKapsr5n04Ya1SlPhYkHwH1IxYRuk
 a6NMpSSYXIK/byT3+j2+V/WMzl5wiJ8X6W43PMR5jLaIVl177c08tRn3SH9MifIIBPS6
 5iY8lWoLx2cSe68XBb4dN7slFzCpqvJbSdF3+tKMyjxLW7YbDVFDc6x3NOZDnXeCeaFY
 l2G8OhKQNpYu/yGLQ/LnaOMJ7uhRdoUDBcDjoDuvBqxfLFnnCG8HyrTTZRR8YQHA5dx/
 +dAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkotI3VON7VxqY1Pwa66TAFEa7HQapCFAexVG4lks7n2BH2aJOnaku2xvuzH4j2ljzJ1bHSRlBmfeYxmxenKqiFOWrSNlpOxHlCImiQsv3kU2dW3Ou0aB70Ps=
X-Gm-Message-State: AOJu0Yw/xUCy0c+W91zJ9FZMlIolwUHtwsvzuhfbP+ouk+GimFuC2CJ7
 x8ViNEZ+fZzoRRPy2fgDPABTyRyO/8qZY7BnfqwZytn9T28cV6T9
X-Google-Smtp-Source: AGHT+IFxEglUlGQkutSjkn23STIzAiY0oWslw5Gr5inpy6BmDb0eFxrCA+F7S2nrcKBRezLMHknYmQ==
X-Received: by 2002:a17:902:ce0c:b0:1e9:320c:2ecf with SMTP id
 k12-20020a170902ce0c00b001e9320c2ecfmr16742263plg.35.1715076007790; 
 Tue, 07 May 2024 03:00:07 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a170902cf4500b001eb48c26a0esm9727402plg.135.2024.05.07.03.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 03:00:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 20:00:03 +1000
Message-Id: <D13BPAZK1WA2.3W3FLBIE4P9NF@gmail.com>
Subject: Re: [PATCH v2 14/28] target/ppc/mmu_common.c: Inline and remove
 check_physical()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <095bdaf2ac340bd731e4e33e296fce8a8e93cd67.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <095bdaf2ac340bd731e4e33e296fce8a8e93cd67.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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
> This function just does two assignments and and unnecessary check that
> is always true so inline it in the only caller left and remove it.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 26 +++-----------------------
>  1 file changed, 3 insertions(+), 23 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 3132030baa..fab86a8f3e 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -1161,28 +1161,6 @@ void dump_mmu(CPUPPCState *env)
>      }
>  }
> =20
> -static int check_physical(CPUPPCState *env, mmu_ctx_t *ctx, target_ulong=
 eaddr,
> -                          MMUAccessType access_type)
> -{
> -    ctx->raddr =3D eaddr;
> -    ctx->prot =3D PAGE_READ | PAGE_EXEC;
> -
> -    switch (env->mmu_model) {
> -    case POWERPC_MMU_SOFT_6xx:
> -    case POWERPC_MMU_SOFT_4xx:
> -    case POWERPC_MMU_REAL:
> -    case POWERPC_MMU_BOOKE:
> -        ctx->prot |=3D PAGE_WRITE;
> -        break;
> -
> -    default:
> -        /* Caller's checks mean we should never get here for other model=
s */
> -        g_assert_not_reached();
> -    }
> -
> -    return 0;
> -}
> -
>  int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
>                                       target_ulong eaddr,
>                                       MMUAccessType access_type, int type=
,
> @@ -1202,7 +1180,9 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu=
_ctx_t *ctx,
>      if (real_mode && (env->mmu_model =3D=3D POWERPC_MMU_SOFT_6xx ||
>                        env->mmu_model =3D=3D POWERPC_MMU_SOFT_4xx ||
>                        env->mmu_model =3D=3D POWERPC_MMU_REAL)) {
> -        return check_physical(env, ctx, eaddr, access_type);
> +        ctx->raddr =3D eaddr;
> +        ctx->prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +        return 0;
>      }
> =20
>      switch (env->mmu_model) {


