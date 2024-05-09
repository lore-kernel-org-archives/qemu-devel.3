Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BC4C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 06:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4x2D-0002qK-Cb; Thu, 09 May 2024 02:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4x28-0002oD-3o; Thu, 09 May 2024 02:13:36 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4x25-00087Y-Cw; Thu, 09 May 2024 02:13:35 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f490b5c23bso483422b3a.3; 
 Wed, 08 May 2024 23:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715235210; x=1715840010; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L6lHuETSaY4LNk4ufNyzYwS/HrxbDbWQnhPMSTE2ujY=;
 b=IbO1d7XorYgZ7E4HA4/mn6yOi2t121YxMblkiCkR39FjiwN2IbrZZwsjz44Y2r0rSr
 MyAlTeo3JIX2NjdNKis+atynzGxdQzUoJ3Zbl/qnUNpgoG7ImIzbjzUk1WZtURQEoyDd
 tGDnzu5tpCscK4pChNydWLvYopxQt0CzD8bL31rQAiSGEO0lkGbyIRkD4egsr6XQqslJ
 FWdfperC/04rnQ9c/NbC8Nzwuk/Tm9SjExWCoI8gcShAqy9yYclQSunda9Qfr2E1w+li
 lWI5/Cs0YBm2Nj0o8J/DwwWhKzh+xUAsv4NKdlKKk2AE0xK3fC9/ynjp29LMIA3dGfyu
 +F1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715235210; x=1715840010;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L6lHuETSaY4LNk4ufNyzYwS/HrxbDbWQnhPMSTE2ujY=;
 b=knbfcwzlKJq9JI5tWuzbImYPHGdY4HzkABHVzMUBh+7JZoiLR6oUxE+0j2WyQNPlh6
 je4b++BJxb5DFG/LG3wA7nCLNXP2iDBIhbKAnNT9FwJLf4z5o7v/r/vF0U1EKTcb51QO
 Ygfj3IYtFjr3JFJBOVo5dUEipXHaHe5A/X82B/m8a35hVAK6JkwtjY50FmsWcQEvj5I1
 VCQDmpWMIJmvYMbKT84UCGOxpAWIEITCdsV6ATrDX1EyfgqEIIePxiMXqG+8guWsc6mt
 V/NU6h31J8Fo/dO41S9kV1pWfqY1OEbBnjLce1MkTjKprX018g9vUSuFv8y1cSOAxfjB
 8pMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/WOoZQROVDMsM4pwGvUZFfy43YvNFl5+UpUDtGuq2ncJaBBbdtMjFsrU7uqbl2a3ZGnwtawbZsEC/90f6P2Jp8DjuAv96mxWXYjjBi2wTvMNHQ2fHTXZPjHQ=
X-Gm-Message-State: AOJu0Yy+TI5LfnObY98bnF+koCXay63jOEIcVFhrW8MUZ3eC6+njQjgC
 YYGsCuEfSr3y/jtH87kUcQPqGfViSt2mey3asiGvuveHkXHGl6Xu6+jGGg==
X-Google-Smtp-Source: AGHT+IFdnR257JHniHA6HtiwwekhnolSxHZW3/BTAhpycdpFUBovIyQundNUE12m7Y9w3HM1HjEmEQ==
X-Received: by 2002:a05:6a00:26d2:b0:6ee:1508:edc8 with SMTP id
 d2e1a72fcca58-6f49c2943camr4415764b3a.23.1715235210022; 
 Wed, 08 May 2024 23:13:30 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2ae0b8bsm560574b3a.131.2024.05.08.23.13.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 23:13:29 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 May 2024 16:13:24 +1000
Message-Id: <D14W4V2S0AHQ.K5CWOH967O5E@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v4 19/33] target/ppc/mmu_common.c: Don't use mmu_ctx_t
 for mmu40x_get_physical_address()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715209155.git.balaton@eik.bme.hu>
 <c70c4716eb59944e8eb810c2b1d57dc715ac551e.1715209155.git.balaton@eik.bme.hu>
In-Reply-To: <c70c4716eb59944e8eb810c2b1d57dc715ac551e.1715209155.git.balaton@eik.bme.hu>
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
> mmu40x_get_physical_address() only uses the raddr and prot fields from
> mmu_ctx_t. Pass these directly instead of using a ctx struct.
>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 38 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 6570b280ca..c5ef02f05e 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -519,20 +519,19 @@ int ppcemb_tlb_search(CPUPPCState *env, target_ulon=
g address, uint32_t pid)
>      return -1;
>  }
> =20
> -static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
> -                                       target_ulong address,
> +static int mmu40x_get_physical_address(CPUPPCState *env, hwaddr *raddr,
> +                                       int *prot, target_ulong address,
>                                         MMUAccessType access_type)
>  {
>      ppcemb_tlb_t *tlb;
> -    hwaddr raddr;
>      int i, ret, zsel, zpr, pr;
> =20
>      ret =3D -1;
> -    raddr =3D (hwaddr)-1ULL;
> +    *prot =3D 0;

This is still doing some sneaky used-uninit things which I would
rather not without a comment, but okay we can try untangle things
more after this series.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>      pr =3D FIELD_EX64(env->msr, MSR, PR);
>      for (i =3D 0; i < env->nb_tlb; i++) {
>          tlb =3D &env->tlb.tlbe[i];
> -        if (!ppcemb_tlb_check(env, tlb, &raddr, address,
> +        if (!ppcemb_tlb_check(env, tlb, raddr, address,
>                                env->spr[SPR_40x_PID], i)) {
>              continue;
>          }
> @@ -550,40 +549,34 @@ static int mmu40x_get_physical_address(CPUPPCState =
*env, mmu_ctx_t *ctx,
>              /* fall through */
>          case 0x3:
>              /* All accesses granted */
> -            ctx->prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +            *prot =3D PAGE_RWX;
>              ret =3D 0;
>              break;
> +
>          case 0x0:
>              if (pr !=3D 0) {
>                  /* Raise Zone protection fault.  */
>                  env->spr[SPR_40x_ESR] =3D 1 << 22;
> -                ctx->prot =3D 0;
> +                *prot =3D 0;
>                  ret =3D -2;
>                  break;
>              }
>              /* fall through */
>          case 0x1:
> -        check_perms:
> +check_perms:
>              /* Check from TLB entry */
> -            ctx->prot =3D tlb->prot;
> -            ret =3D check_prot(ctx->prot, access_type);
> +            *prot =3D tlb->prot;
> +            ret =3D check_prot(*prot, access_type);
>              if (ret =3D=3D -2) {
>                  env->spr[SPR_40x_ESR] =3D 0;
>              }
>              break;
>          }
> -        if (ret >=3D 0) {
> -            ctx->raddr =3D raddr;
> -            qemu_log_mask(CPU_LOG_MMU, "%s: access granted " TARGET_FMT_=
lx
> -                          " =3D> " HWADDR_FMT_plx
> -                          " %d %d\n", __func__, address, ctx->raddr, ctx=
->prot,
> -                          ret);
> -            return 0;
> -        }
>      }
> -    qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
> -                  " =3D> " HWADDR_FMT_plx " %d %d\n",
> -                  __func__, address, raddr, ctx->prot, ret);
> +    qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " =3D> "
> +                  HWADDR_FMT_plx " %d %d\n",  __func__,
> +                  ret < 0 ? "refused" : "granted", address,
> +                  ret < 0 ? 0 : *raddr, *prot, ret);
> =20
>      return ret;
>  }
> @@ -1171,7 +1164,8 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu=
_ctx_t *ctx,
>      case POWERPC_MMU_SOFT_6xx:
>          return mmu6xx_get_physical_address(env, ctx, eaddr, access_type,=
 type);
>      case POWERPC_MMU_SOFT_4xx:
> -        return mmu40x_get_physical_address(env, ctx, eaddr, access_type)=
;
> +        return mmu40x_get_physical_address(env, &ctx->raddr, &ctx->prot,=
 eaddr,
> +                                           access_type);
>      case POWERPC_MMU_REAL:
>          cpu_abort(env_cpu(env),
>                    "PowerPC in real mode do not do any translation\n");


