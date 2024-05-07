Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED8DC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HLh-0004Ts-0X; Tue, 07 May 2024 05:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4HLe-0004Pr-Eb; Tue, 07 May 2024 05:42:58 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4HLV-0007SH-Ja; Tue, 07 May 2024 05:42:58 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f453d2c5a1so2768366b3a.2; 
 Tue, 07 May 2024 02:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715074968; x=1715679768; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cSHe4lQJQlirhi5Pyo5LOHp5Kx+I2u4K5jPgZlKynGo=;
 b=ciNWWLCgUv8Y26OqT10WzH10sh3pmBntiJGhL8cc/gCLQoUVnZp+X7vpuQj4ooMPG3
 7w9uXPNs97hDgQcznlH3IwcomLAl16mC/66WzClZ3HEyv4YFDs66UYYo4mxLNcmjY8lG
 60zOkY+1TVNNzZ69S1Gel/iU0rHgIzkV+2AIRINpxkjNO/p7tCEBDK0vvTdF1rObgHpN
 WmH722zKiAvTVCpAtCBQZfyFwmgl5IEeGU5qlr950x423ymfWcBnECiqnIGRCWYH95yE
 lK+w4RLkSI1s9VpZMWNqxPbiukODSC93thj9+eFFiBrGCy8ixGjicsUgdj6Dd9c1G5P4
 ghFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715074968; x=1715679768;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cSHe4lQJQlirhi5Pyo5LOHp5Kx+I2u4K5jPgZlKynGo=;
 b=Wul+KaXxvUEJpdi05iSzKj87hq8r5hqkohKbaP81/1wvWRAjFdDJu2uTp6GbFEVmR3
 VfXUJRWbyw8QLJnirEGtlh+DoqYS1Ks8qT8msv64rlD+MhtFAvlo7LtMPC+5GsjJ/PfI
 1Lqsv6x0II1ojtL8mUnnGya0tFwYLJH+JaHl5LyXiuJykMZIYk4zkBNNVkayEPsjH+u+
 Igfl3MjOrkJNMrF7g5F8LsZl17+e1fAxJu8ZdwyVcqJR53NZo7mcB7H87R0qIyFvm7tU
 42YOG1PXFzTXio+ekX8NQm8dt7rg+0VPBIjMQFAmjnoYAhks6CQnw45f2Jalhod0+LL+
 3etQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8WXYQG496tiij0lOC+HCZha7Ts1qppwkzIhxfuJdUI6fSIjeF/3mXco92R0HE+hQlm7frxQXvxfUVORRitP/cc+tbsttZitfe+5jwsC7s8J1sRPLB6DiHD8E=
X-Gm-Message-State: AOJu0Yzwr3Y1WmRVIPiJZurR8BxRWkFXXLHih7RnylFdJM5tDEn+bF6/
 aZrV4zMINypqX5FCK7nIJwIuvNJeVLKO2ck5FteEC7MojDMf/Drv
X-Google-Smtp-Source: AGHT+IEvha9GLpxSPzHxXLbCPe4C8wc4ekbJiSICJhm3ddgPVMl2WK5k7WC8GOv6f16ZzjAVTrBXIA==
X-Received: by 2002:a05:6a21:9202:b0:1af:a5b1:2907 with SMTP id
 tl2-20020a056a21920200b001afa5b12907mr9814921pzb.3.1715074967708; 
 Tue, 07 May 2024 02:42:47 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a170902e84f00b001db5fc51d71sm9720629plg.160.2024.05.07.02.42.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 02:42:47 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 19:42:41 +1000
Message-Id: <D13BC0EOO2DU.23H382TF3ZXIN@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 10/28] target/ppc/mmu_common.c: Introduce
 mmu6xx_get_physical_address()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <af31ebb6090c4875472b2e31a41569bf0e40ba37.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <af31ebb6090c4875472b2e31a41569bf0e40ba37.1714606359.git.balaton@eik.bme.hu>
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

On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
> Repurpose get_segment_6xx_tlb() to do the whole address translation
> for POWERPC_MMU_SOFT_6xx MMU model by moving the BAT check there and
> renaming it to match other similar functions. These are only called
> once together so no need to keep these separate functions and
> combining them simplifies the caller allowing further restructuring.

Looks good...

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 98730035b1..ef1669b01d 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -359,19 +359,25 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ct=
x_t *ctx,
>      return ret;
>  }
> =20
> -/* Perform segment based translation */
> -static int get_segment_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
> -                               target_ulong eaddr, MMUAccessType access_=
type,
> -                               int type)
> +static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
> +                                       target_ulong eaddr,
> +                                       MMUAccessType access_type, int ty=
pe)
>  {
>      PowerPCCPU *cpu =3D env_archcpu(env);
>      hwaddr hash;
> -    target_ulong vsid;
> -    int ds, target_page_bits;
> +    target_ulong vsid, sr, pgidx;
>      bool pr;
> -    int ret;
> -    target_ulong sr, pgidx;
> +    int ds, target_page_bits, ret =3D -1;
> =20
> +    /* First try to find a BAT entry if there are any */
> +    if (env->nb_BATs !=3D 0) {
> +        ret =3D get_bat_6xx_tlb(env, ctx, eaddr, access_type);
> +    }
> +    if (ret >=3D 0) {
> +        return ret;
> +    }

Would you consider not doing any rearranging of local variables there
and change this as:

    /* First try to find a BAT entry if there are any */
    if (env->nb_BATs !=3D 0) {
        int ret =3D get_bat_6xx_tlb(env, ctx, eaddr, access_type);
        if (ret >=3D 0) {
            return ret;
        }
    }

Otherwise,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> +    /* Perform segment based translation when no BATs matched */
>      pr =3D FIELD_EX64(env->msr, MSR, PR);
>      ctx->eaddr =3D eaddr;
> =20
> @@ -1193,14 +1199,8 @@ int get_physical_address_wtlb(CPUPPCState *env, mm=
u_ctx_t *ctx,
>          if (real_mode) {
>              ret =3D check_physical(env, ctx, eaddr, access_type);
>          } else {
> -            /* Try to find a BAT */
> -            if (env->nb_BATs !=3D 0) {
> -                ret =3D get_bat_6xx_tlb(env, ctx, eaddr, access_type);
> -            }
> -            if (ret < 0) {
> -                /* We didn't match any BAT entry or don't have BATs */
> -                ret =3D get_segment_6xx_tlb(env, ctx, eaddr, access_type=
, type);
> -            }
> +            ret =3D mmu6xx_get_physical_address(env, ctx, eaddr, access_=
type,
> +                                              type);
>          }
>          break;
> =20


