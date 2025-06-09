Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6E0C61DB2
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 04:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOU7o-0006LN-5d; Mon, 09 Jun 2025 00:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOU7n-0006Kx-4B; Mon, 09 Jun 2025 00:28:43 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOU7l-0001xK-HA; Mon, 09 Jun 2025 00:28:42 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad89f9bb725so729493966b.2; 
 Sun, 08 Jun 2025 21:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749443319; x=1750048119; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1+elC4FyR0o7sbxrD9IJtqh8eNxB+uZKW3CZsx01wE=;
 b=K0eIzw0Tz03RQdn7mA50WCNblqGVnte3cMHjZ9pLV+JZAIvrcCS/tcK1/dLkZ2GqEM
 6RnlJ/hjHQwZK6NDm46iffJ7VQGC4LL4RvxnMRfo2ByrSv0miy9wV+Z/H0qjLpECwlb+
 c+XFIaOcniMTcqqY9LoY4bz9meaTgLmcK7Po+zcmEu/12cEJEm0NuoWyX87wVR54ciNW
 o2KzUrf2jGXaKTA7Zaw4zAykzbb8K9aLNx7EFdyaquYMrUGrC/ATTwV+VW2aVr/O+5Kp
 qp4F2KF6HLJx0yhEdhGChlzsLRgZdt2Jq1o4UtKwc4ABmGBhIqDUMLp/cpBmumrP2bO5
 EbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749443319; x=1750048119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f1+elC4FyR0o7sbxrD9IJtqh8eNxB+uZKW3CZsx01wE=;
 b=MTjtl7vSDWx633J+9cVEKWJ3QFUuzZUwy7NDMcVstEuNqq49wn8cKZR76/gscUUebP
 4Ur+kfZXlYGYdtw1aTxM8sGovYxMV4M+S3MFY2jdaj2cw7iLp9s3pzyT7i7/63y+tzse
 1OrgF9/rUO2C73OGxHRMeNKCZAGzOW3m2qRwpRzPIDrEYevVDwR6VXI+KYSmTbg62nK3
 o6wYkWq9tjP1OyqURCv93nRwyjle2fBOCGuguYonN8roVSYzATdyK5NavTQlokzx7hvV
 nNd8419LkBjm1KB7PpFpiVBlCcLVGBMHB/OUqaYpiXsaXHHoiMWWWOAUVyUVJkoWBHcj
 axAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVByNFiXXT+DKMMaZyHxoG7wI9Ppy76Sab5NAunGC2GXjDm+A1KEUjGPnt0o4UdOjS2Gid7tL1c/cFA@nongnu.org
X-Gm-Message-State: AOJu0YxKsknXE2EKpX8Z+VJ9QBxWm6MIcrFgxe+hvaX2jcDv7LKqP9Rf
 JkMA8hA8pQujjIhdGhgpY3aB8TTYSFtUb0IKTWc/CAPwsHt0mDmwj39SKHnjsLG11cAkxAymPtq
 EkbHjryi4yXyq/Dv0iimR+W2pvTwtYhk=
X-Gm-Gg: ASbGncuaO2+PvjR7AJjd+vOB4r4BNZipwVUh0zEpGfkwTYnBua5KhXKacfng2ypRZvl
 cZlUpwqK6UBib1n2cN5s3Ku61zfNxa4qaIDsbPF8muM7IdfeSdCGzXMIcgFepNVe22E9JCCPE0a
 hzxwmsy0L1Vc3z703gJtHkgxuu2tipsBePGES4/YYmr4X7Rg2v5w969tdQu4Rx/jLdX4n2KKu7v
 g==
X-Google-Smtp-Source: AGHT+IHcMmziI5GlhZZGyMeKkSTBHeicN2bBpMVdkQOO3jsa0Dko9V4t5j9rkMXePuELPze1tHRPSKAiRq8f+0oAmiA=
X-Received: by 2002:a17:907:96a2:b0:ade:7bd:e0ec with SMTP id
 a640c23a62f3a-ade1a9eefc4mr965217466b.56.1749443318729; Sun, 08 Jun 2025
 21:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250501114253.594887-1-antonb@tenstorrent.com>
In-Reply-To: <20250501114253.594887-1-antonb@tenstorrent.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Jun 2025 14:28:11 +1000
X-Gm-Features: AX0GCFsgE4tlSMJs6_NwT-xOEtU6mNMT-eIRIyEqh9bSM7ZZti7h1wCFYUXFZBY
Message-ID: <CAKmqyKOOF9euOi==ey91NjXA1LMxvQfKc=A_uTCjrBzELYp6Yw@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Fix fcvt.s.bf16 NaN box checking
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, May 1, 2025 at 9:44=E2=80=AFPM Anton Blanchard <antonb@tenstorrent.=
com> wrote:
>
> fcvt.s.bf16 uses the FP16 check_nanbox_h() which returns an FP16
> quiet NaN. Add check_nanbox_bf16() which returns a BF16 quiet NaN.
>
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/fpu_helper.c |  2 +-
>  target/riscv/internals.h  | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index 91b1a56d10..31c17399fc 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -756,6 +756,6 @@ uint64_t helper_fcvt_bf16_s(CPURISCVState *env, uint6=
4_t rs1)
>
>  uint64_t helper_fcvt_s_bf16(CPURISCVState *env, uint64_t rs1)
>  {
> -    float16 frs1 =3D check_nanbox_h(env, rs1);
> +    float16 frs1 =3D check_nanbox_bf16(env, rs1);
>      return nanbox_s(env, bfloat16_to_float32(frs1, &env->fp_status));
>  }
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 213aff31d8..794c81bf7c 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -142,6 +142,22 @@ static inline float16 check_nanbox_h(CPURISCVState *=
env, uint64_t f)
>      }
>  }
>
> +static inline float16 check_nanbox_bf16(CPURISCVState *env, uint64_t f)
> +{
> +    /* Disable nanbox check when enable zfinx */
> +    if (env_archcpu(env)->cfg.ext_zfinx) {
> +        return (uint16_t)f;
> +    }
> +
> +    uint64_t mask =3D MAKE_64BIT_MASK(16, 48);
> +
> +    if (likely((f & mask) =3D=3D mask)) {
> +        return (uint16_t)f;
> +    } else {
> +        return 0x7FC0u; /* default qnan */
> +    }
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>  /* Our implementation of SysemuCPUOps::has_work */
>  bool riscv_cpu_has_work(CPUState *cs);
> --
> 2.34.1
>
>

