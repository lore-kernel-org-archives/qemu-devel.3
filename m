Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D6DC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 05:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7q7T-0005WA-Po; Fri, 17 May 2024 01:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7q7S-0005Vr-JV; Fri, 17 May 2024 01:27:02 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7q7Q-0003NG-PZ; Fri, 17 May 2024 01:27:02 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f0937479f8so2164055ad.3; 
 Thu, 16 May 2024 22:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715923619; x=1716528419; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wz4Mdvhn7hFKdXTaqlrKxVyG1U3HQ+vutlLvwK0ih7Q=;
 b=Httm0InLMN7XcDX+zpcIYCp3Y0WWCGxyvcLb01dyfb+zyhnBISDP9JPX1zp/vvqL2I
 Ovt3AGUH4mLxBx6c2JmqgGGsSq/SOKZlTXoIqlxAh7/xTkuq9ja/esyacnK59brLm3hT
 YzqiVBSPE8w0y1bYh5uZ4E6/LyHh4SG8SFUjkU1nAUOm9CSyb+dqJZEX7VztTfwz3f9b
 7521KGaBtCwvG1l+/vzAiakZD3vmZvHFEIYKwFL+RVverfDi+pC+dv6qLdzTCyfCCILR
 kerjdNEouLajZ48F5lfaZJsaF6LDFBlAkCZsNQpWuGmhRO8KyJ5W/Bw/q03loXaIIB+2
 FUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715923619; x=1716528419;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wz4Mdvhn7hFKdXTaqlrKxVyG1U3HQ+vutlLvwK0ih7Q=;
 b=GgV/60jj57WhrVODzOrqpLsB4732y34OfbqpVGvFGmucRzbfHAVnQNHVuGBYm/6vNh
 F+nA8Bs8xueAumGRdegtqa4ARO7F92Wg7rBlonxP1Auk1yaDhGVfHJ50hTTeTwvfp7Si
 UMkx62oXZ6hScj+EVx1th+o5CV7Pe80gpWuW/oJLCkehfG3l6QxLA/eVg8UyAdfhZJQ7
 qP5F1COzm6vYQRL5BfdYMz0dA8fLmbVjFl+HklfcJRCeuWuJOPk0DM6t4fylOqlnRyou
 YZVEY8AXq3Jox3Hm6KOQmGyK0BCgVLHON5Lgwza9w5uH/wOSRCagwrC6x1xt/xpGffFu
 sNDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFTaJ9goPtFLS25cA7pgDDjgedmlC00xAA8PFKUgsjrrwAgc9z6nzlIL09cX4Y9UAjOLJi+NhwzfSeD2Z4VR7FvEcgxPqQXH6V8UXFJXHbXwLIvHu8xzavwmM=
X-Gm-Message-State: AOJu0YzM2sdxiSdpQqKm8N0dt/FHabXMWbEZl9P/Wb+s9NVmGcBQp1mb
 DXxMWIc88ZuvX81qA/Fv+1KSA0q4+Gjf5Ol61kkyUmAxvEShKH1q
X-Google-Smtp-Source: AGHT+IF1ZOUuP2BB/d5k4vsp9OTgWD/ktYDVKnWekaiWH9XMpYg4RzGWtKkxm8+FRzsicsihSJoVnQ==
X-Received: by 2002:a17:902:da8e:b0:1e8:2c8d:b74a with SMTP id
 d9443c01a7336-1ef43c0c862mr241050635ad.10.1715923618591; 
 Thu, 16 May 2024 22:26:58 -0700 (PDT)
Received: from localhost ([1.146.118.37]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f2e1c81db0sm4757505ad.78.2024.05.16.22.26.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 22:26:58 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 May 2024 15:26:52 +1000
Message-Id: <D1BO5L8SIA2J.231225LUX9VFN@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v7 24/61] target/ppc/mmu_common.c: Split off real mode
 handling from get_physical_address_wtlb()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715555763.git.balaton@eik.bme.hu>
 <8b83d8228a471d9be431114aa0bc449b20c7c351.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <8b83d8228a471d9be431114aa0bc449b20c7c351.1715555763.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

On Mon May 13, 2024 at 9:27 AM AEST, BALATON Zoltan wrote:
> Add ppc_real_mode_xlate() to handle real mode translation and allow
> removing this case from ppc_jumbo_xlate().
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 46 ++++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 19 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 8599106f75..ab912da821 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -1117,23 +1117,12 @@ int get_physical_address_wtlb(CPUPPCState *env, m=
mu_ctx_t *ctx,
>                                       MMUAccessType access_type, int type=
,
>                                       int mmu_idx)
>  {
> -    bool real_mode =3D (type =3D=3D ACCESS_CODE) ? !FIELD_EX64(env->msr,=
 MSR, IR)
> -                                           : !FIELD_EX64(env->msr, MSR, =
DR);
> -    if (real_mode) {
> -        ctx->raddr =3D eaddr;
> -        ctx->prot =3D PAGE_RWX;
> -        return 0;
> -    }
> -
>      switch (env->mmu_model) {
>      case POWERPC_MMU_SOFT_6xx:
>          return mmu6xx_get_physical_address(env, ctx, eaddr, access_type,=
 type);
>      case POWERPC_MMU_SOFT_4xx:
>          return mmu40x_get_physical_address(env, &ctx->raddr, &ctx->prot,=
 eaddr,
>                                             access_type);
> -    case POWERPC_MMU_REAL:
> -        cpu_abort(env_cpu(env),
> -                  "PowerPC in real mode do not do any translation\n");
>      default:
>          cpu_abort(env_cpu(env), "Unknown or invalid MMU model\n");
>      }
> @@ -1251,6 +1240,24 @@ static bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr=
 eaddr,
>      return false;
>  }
> =20
> +static bool ppc_real_mode_xlate(PowerPCCPU *cpu, vaddr eaddr,
> +                                MMUAccessType access_type,
> +                                hwaddr *raddrp, int *psizep, int *protp)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    if (access_type =3D=3D MMU_INST_FETCH ? !FIELD_EX64(env->msr, MSR, I=
R)
> +                                      : !FIELD_EX64(env->msr, MSR, DR)) =
{
> +        *raddrp =3D eaddr;
> +        *protp =3D PAGE_RWX;
> +        *psizep =3D TARGET_PAGE_BITS;
> +        return true;
> +    } else if (env->mmu_model =3D=3D POWERPC_MMU_REAL) {
> +        cpu_abort(CPU(cpu), "PowerPC in real mode shold not do translati=
on\n");
> +    }
> +    return false;
> +}
> +
>  /* Perform address translation */
>  /* TODO: Split this by mmu_model. */
>  static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
> @@ -1264,6 +1271,10 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr=
 eaddr,
>      int type;
>      int ret;
> =20
> +    if (ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep, pro=
tp)) {
> +        return true;
> +    }
> +
>      if (access_type =3D=3D MMU_INST_FETCH) {
>          /* code access */
>          type =3D ACCESS_CODE;
> @@ -1303,11 +1314,8 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr=
 eaddr,
>                  env->spr[SPR_40x_DEAR] =3D eaddr;
>                  env->spr[SPR_40x_ESR] =3D 0x00000000;
>                  break;
> -            case POWERPC_MMU_REAL:
> -                cpu_abort(cs, "PowerPC in real mode should never raise "
> -                              "any MMU exceptions\n");
>              default:
> -                cpu_abort(cs, "Unknown or invalid MMU model\n");
> +                g_assert_not_reached();
>              }
>              break;
>          case -2:
> @@ -1359,11 +1367,8 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr=
 eaddr,
>                      env->spr[SPR_40x_ESR] =3D 0x00000000;
>                  }
>                  break;
> -            case POWERPC_MMU_REAL:
> -                cpu_abort(cs, "PowerPC in real mode should never raise "
> -                              "any MMU exceptions\n");
>              default:
> -                cpu_abort(cs, "Unknown or invalid MMU model\n");
> +                g_assert_not_reached();
>              }
>              break;
>          case -2:
> @@ -1457,6 +1462,9 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAcc=
essType access_type,
>      case POWERPC_MMU_BOOKE206:
>          return ppc_booke_xlate(cpu, eaddr, access_type, raddrp,
>                                 psizep, protp, mmu_idx, guest_visible);
> +    case POWERPC_MMU_REAL:
> +        return ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psiz=
ep,
> +                                   protp);
>      case POWERPC_MMU_MPC8xx:
>          cpu_abort(env_cpu(&cpu->env), "MPC8xx MMU model is not implement=
ed\n");
>      default:


