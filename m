Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD94C27C5E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0XH-0000cj-Ao; Wed, 05 Jun 2024 19:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sF0XF-0000au-7d; Wed, 05 Jun 2024 19:59:17 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sF0XD-0001OE-Ah; Wed, 05 Jun 2024 19:59:16 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-80b26f1cadaso133914241.3; 
 Wed, 05 Jun 2024 16:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717631953; x=1718236753; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s1qO5PxmSyEKIngMdhqfZwB0yJn6C50Iy79IGICv9zQ=;
 b=ETz0KFkCbrHn/sjLLHC9XMUWHpuzbJXOcU1hc4NHgomHTL5KO+xMPPU8dDsO90+Bo6
 PXQmHSrZWc80ioGx+JVSOrfvcZCvgrzP+UIpbCiRhzdQnvu0LnVmJY6aegukmasAOG1o
 g+ynXWHwWzJkbREtvDXNduD8EfoehwJxDAxRBTzflgpurxrak38l4JopI7jh51Ydcqy1
 uHcHysW2kQigl7r5N56pAcfsup1rEYhkqSM1vNyYsd89H0ign4mzhYpP12DYqmkdXKB8
 2zCPJ2SDqBUgko1B+E7XQ3WCS2wZoWLiwMpxmzJT9Bh3R0DK7gqmg7PxaAejDeaA5giq
 CKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717631953; x=1718236753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s1qO5PxmSyEKIngMdhqfZwB0yJn6C50Iy79IGICv9zQ=;
 b=Lch9o4RjumxPKd1tR4wD/KXwXRZmt3VTNI9lSG5rQ2WHmyOxEtIBHkQXFWyGLuFhZp
 aZy9cQGppX9g3u8OA8tQkRpB/lOW9RTkESLw12a9xfp4UJ/sHnLB8au5yW9g/8NXTkMv
 MGf/b2Q8MzBxIDqIOnwu7Rf53Q6jkznGMPYPp8ZaeRqKKaN5sUUNPWMArWU+iiqdWiEg
 kKPPODh+4V8/Cca5uLOuKFh2nYquv++s8CKLoox0pgBmSOK7CutQ2jQh/GqNTkorTUL3
 6LT2qdc479kGcX+MagDjM69KjewNp6RVs34HHOw1hL2AFFxPEwDvb+o5xy8cYVnlY8i6
 UdGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj7klcdqts9+sssoZ7cfam17Vv1imO068ZUmKILb8kYfpBjJpTxkpDwDtoadudFEDweB6RhBAmk67h4M0Ra2kOoPZ65hk=
X-Gm-Message-State: AOJu0YyFcc78Xh9MOzYY0kK/MBQCa7zgnT/HtPqVs+k+R6nQCIcvGqCP
 UqL8upEyOedss3tjJ3OxKP5majWuqMsCZA3cIK+St8BbYEetyOpRDfpXPhcLiYaXN94K/D4pUbQ
 4jeSNcuN015GvgAM5wIcP2o1hsdU=
X-Google-Smtp-Source: AGHT+IHt0lZPpb3ALTo2Hj7ySkvS0MqzjSdwFNPAk6j55ReIBIJVSAf9zpXWCnce42UHyHnU5e65cAksUDKIcLcFPUo=
X-Received: by 2002:a67:b109:0:b0:48b:bce7:a80 with SMTP id
 ada2fe7eead31-48c0493aea9mr4751054137.24.1717631953468; Wed, 05 Jun 2024
 16:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240604062747.9212-1-fea.wang@sifive.com>
 <20240604062747.9212-5-fea.wang@sifive.com>
In-Reply-To: <20240604062747.9212-5-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Jun 2024 09:58:47 +1000
Message-ID: <CAKmqyKPqD3YiKv1g9Tr8AnoBR=j8oqYQ5BM8CpXb0-Uv9Q3gEg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] target/riscv: Add 'P1P13' bit in SMSTATEEN0
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 4, 2024 at 4:24=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrote=
:
>
> Based on privilege 1.13 spec, there should be a bit56 for 'P1P13' in
> mstateen0 that controls access to the hedeleg.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Weiwei Li <liwei1518@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_bits.h | 1 +
>  target/riscv/csr.c      | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 74318a925c..28bd3fb0b4 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -315,6 +315,7 @@
>  #define SMSTATEEN0_CS       (1ULL << 0)
>  #define SMSTATEEN0_FCSR     (1ULL << 1)
>  #define SMSTATEEN0_JVT      (1ULL << 2)
> +#define SMSTATEEN0_P1P13    (1ULL << 56)
>  #define SMSTATEEN0_HSCONTXT (1ULL << 57)
>  #define SMSTATEEN0_IMSIC    (1ULL << 58)
>  #define SMSTATEEN0_AIA      (1ULL << 59)
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 58ef7079dc..3dcfb343fe 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2245,6 +2245,10 @@ static RISCVException write_mstateen0(CPURISCVStat=
e *env, int csrno,
>          wr_mask |=3D SMSTATEEN0_FCSR;
>      }
>
> +    if (env->priv_ver >=3D PRIV_VERSION_1_13_0) {
> +        wr_mask |=3D SMSTATEEN0_P1P13;
> +    }
> +
>      return write_mstateen(env, csrno, wr_mask, new_val);
>  }
>
> @@ -2280,6 +2284,10 @@ static RISCVException write_mstateen0h(CPURISCVSta=
te *env, int csrno,
>  {
>      uint64_t wr_mask =3D SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
>
> +    if (env->priv_ver >=3D PRIV_VERSION_1_13_0) {
> +        wr_mask |=3D SMSTATEEN0_P1P13;
> +    }
> +
>      return write_mstateenh(env, csrno, wr_mask, new_val);
>  }
>
> --
> 2.34.1
>
>

