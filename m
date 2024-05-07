Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BAFC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Hau-0007VU-1j; Tue, 07 May 2024 05:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4Has-0007Uq-9J; Tue, 07 May 2024 05:58:42 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4Haq-0007YE-Ns; Tue, 07 May 2024 05:58:42 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ecddf96313so25150145ad.2; 
 Tue, 07 May 2024 02:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715075919; x=1715680719; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qcKjRONJbZ8KAIaBcfyIczov33abj/sPC+r8WMQoOko=;
 b=UaZgabnltv+NJnJNTYMEWoMxq5F8abbO4PEWdWZlv9+tkTZW0u6QblKoGQqhJbCXxm
 f+CWcob5KqzVcs+RHpSS5ayNJysEUwX0AYg8MPuhi0utdTETdXebU/r9tSselH7C/m+W
 FURyP61TSf1JwUErLx5D7BZmN43akKHxmkvP7c4PrbgajeQPGeMB6UoK/7qIFJuIAIBy
 bRV4FWGyu9OGeCentHuGkiWcAzKmucg4SNjNBjO7/6nhZaXZgQVl9oFiN44GIwCEh2jS
 gWHOd2+Yjj0GCpNDkIA6DoPoycbnk2gsxoekqkGnQO86eSOYIGQ3qtzOEdXYiZYm7PYe
 FGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715075919; x=1715680719;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qcKjRONJbZ8KAIaBcfyIczov33abj/sPC+r8WMQoOko=;
 b=UMv/0qcaaqRNQ0+TlJOp6nM3L7PxYCSM3ysqof4Sku/Isklf82dfIF10Eg84LCiZbn
 2mbq1S+m93fDcah6B70ms8/PQ75CtDTnEQpsNFVmUrm5UzRbOCSjM1adpJyEOHHe011L
 SmkTzMTRITUvIcHpm+hswGQ7XfHcvAXt6lL2nkWyswwuCQfQ9j79n6ED/68JSRl8bxpw
 35AQR6aeScyIPMZgfVxaEbc2B78kPf6K+9pTcL2wabGddnaNPKYeJhcH5CaQJZ1JCcM+
 H2vDaL0sZctcSU2JyGGmaU6Glkydg2QmVc1NmPUZg60xvQHP19TxRmnvPh4xm0nRstrD
 qn2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9bMd7WmyTiu06yPDER6jyS4qlzay7XDrND8dVMhvXQSn7wQI1LMwlJzaKJ3Er1uCco1pW0WkUTDqkTDELRnnGy7HJXtWFovCmLy6RKXpYjof/k1pqHUOUgIQ=
X-Gm-Message-State: AOJu0YwYIDFzxaf4/gxL6eTfyfiVM9Dt5JJA/7zFCVBVjkIvkg3bwnd5
 a7qkuSUWz6QyoD2/DXg88XF15w5UBmgrR+kVR+ZBvamcWq8W+vls
X-Google-Smtp-Source: AGHT+IFN00l67adL/5fpcKnNTQmSyXdwDjA3o/m3a5jlFm+6j4a4IcNswe9m0nhThPAK9QK1RaT2wQ==
X-Received: by 2002:a17:902:ea11:b0:1e2:adce:9139 with SMTP id
 s17-20020a170902ea1100b001e2adce9139mr17952086plg.44.1715075918895; 
 Tue, 07 May 2024 02:58:38 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 lf14-20020a170902fb4e00b001e556734814sm9693158plb.134.2024.05.07.02.58.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 02:58:38 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 19:58:33 +1000
Message-Id: <D13BO5SCS2IU.33N7IQ7577OI4@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 13/28] target/ppc/mmu_common.c: Split off real mode
 cases in get_physical_address_wtlb()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <bef3cb72e6f139b5af5cc29ebc86c9f6eb907886.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <bef3cb72e6f139b5af5cc29ebc86c9f6eb907886.1714606359.git.balaton@eik.bme.hu>
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

On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
> The real mode handling is identical in the remaining switch cases.
> Split off these common real mode cases into a separate conditional to
> leave only the else branches in the switch that are different.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 34 +++++++++-------------------------
>  1 file changed, 9 insertions(+), 25 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 24a9b9ef19..3132030baa 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -1188,7 +1188,6 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu=
_ctx_t *ctx,
>                                       MMUAccessType access_type, int type=
,
>                                       int mmu_idx)
>  {
> -    int ret =3D -1;
>      bool real_mode;
> =20
>      if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE) {
> @@ -1200,38 +1199,23 @@ int get_physical_address_wtlb(CPUPPCState *env, m=
mu_ctx_t *ctx,
> =20
>      real_mode =3D (type =3D=3D ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR,=
 IR)
>                                        : !FIELD_EX64(env->msr, MSR, DR);
> +    if (real_mode && (env->mmu_model =3D=3D POWERPC_MMU_SOFT_6xx ||
> +                      env->mmu_model =3D=3D POWERPC_MMU_SOFT_4xx ||
> +                      env->mmu_model =3D=3D POWERPC_MMU_REAL)) {
> +        return check_physical(env, ctx, eaddr, access_type);
> +    }
> =20
>      switch (env->mmu_model) {
>      case POWERPC_MMU_SOFT_6xx:
> -        if (real_mode) {
> -            ret =3D check_physical(env, ctx, eaddr, access_type);
> -        } else {
> -            ret =3D mmu6xx_get_physical_address(env, ctx, eaddr, access_=
type,
> -                                              type);
> -        }
> -        break;
> -
> +        return mmu6xx_get_physical_address(env, ctx, eaddr, access_type,=
 type);
>      case POWERPC_MMU_SOFT_4xx:
> -        if (real_mode) {
> -            ret =3D check_physical(env, ctx, eaddr, access_type);
> -        } else {
> -            ret =3D mmu40x_get_physical_address(env, ctx, eaddr, access_=
type);
> -        }
> -        break;
> +        return mmu40x_get_physical_address(env, ctx, eaddr, access_type)=
;
>      case POWERPC_MMU_REAL:
> -        if (real_mode) {
> -            ret =3D check_physical(env, ctx, eaddr, access_type);
> -        } else {
> -            cpu_abort(env_cpu(env),
> -                      "PowerPC in real mode do not do any translation\n"=
);
> -        }
> -        return -1;
> +        cpu_abort(env_cpu(env),
> +                  "PowerPC in real mode do not do any translation\n");
>      default:
>          cpu_abort(env_cpu(env), "Unknown or invalid MMU model\n");
> -        return -1;
>      }
> -
> -    return ret;
>  }
> =20
>  static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong =
address,


