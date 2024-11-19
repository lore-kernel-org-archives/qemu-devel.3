Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263BAD60D15
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 03:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDEqr-0003Ri-Kp; Mon, 18 Nov 2024 22:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDEqp-0003RA-EE; Mon, 18 Nov 2024 22:24:27 -0500
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDEqn-0000O9-Qx; Mon, 18 Nov 2024 22:24:26 -0500
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-5144e15aa69so1033867e0c.2; 
 Mon, 18 Nov 2024 19:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731986664; x=1732591464; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QgiR/t8n7eb5yby1gCTSJUSFZ0MCA25rRN1mIkv21KE=;
 b=VGTsfAVjwdwdlXVXh8dN7AuTXMonxiSZalnaLYSyNcMYwHDe4h4juTyM/bxrPx/osV
 ZoLlwghRHMrWqqRJguiKFEcy2n4TsZA+DXFb9F2dNIdlqubMxMXOHIdh8elbWpfwZw/a
 6ZCpt4Cju2XQiYUteu7bt/4xH6r1ob78mPA1YfioCkMr/63y9ahTTX2WIQx3NTFO5pmJ
 ad/4kW0lYrIjGHB/SKePE1CI5emvWXHULfHxYhH/yiIXyakTFo1a9YkmL/BD5S5sSW8V
 qZs9JMfQ+F3FDL8vW/qUdD7zG0g3t61mJmCNiXAMWa6ttpVfqsaKrdmbbiPkNBtosXCN
 GeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731986664; x=1732591464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QgiR/t8n7eb5yby1gCTSJUSFZ0MCA25rRN1mIkv21KE=;
 b=CR8KGXkZhXePHsolPIX8OlLffxiK9zFjeJBv5YyLkXDkJJUcxoOWuuOfE8sR1hlPdQ
 S/4Hy+SKIMsL6dLGFKq6oN4ZGL28jJwxIxkNkG9NLAtl9QwgR+TFaBqZ/gtnnQdWp1yV
 HKcTttwqwRZiGttrXjiZ8OyzJviBcRQIX2FXcOZ78tTtCiNzH+xEgKtpfeAauLCpUNuk
 30B8w69pBcsyoU1Zfi9Sdgy22Qo6lNTzxt/CoVvxaX4OCgEx66jlFso7sya5hqX6/7nQ
 OxXEPdCP+rM3tG+tO+jWW9wUy2CABC8//H2B/azVpSQciTN2PJljxtC0Ku/ISae+xtoc
 eYmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWodkHvYautSG3uHB5Z1e6tvAFgDcCwWdwB4ZOTqeqmvzNTB6LTaPUBV4zcGstZ6AZP65zMFu9QGGOk@nongnu.org
X-Gm-Message-State: AOJu0Yx7EwCWpnqDGaDTtPCGt+ffQdLa2ZRMhaYFB8GTv71Nu5LTG6oh
 pBCQ3Rs0MLVOfyAMjostfggrKO4jylInWhTvUw20I3Rn4XCCldXKTOs/vJMHRlyyisOoZuR/Fxe
 C23G0Ejzz8Ijurgl+p6ZqU9c1FCDYxA==
X-Google-Smtp-Source: AGHT+IGGj9PoHC6Rb42wDNCONQ2sSBZ8fSh3usdW4rTrMDd+wMl71/SjJ3hG1ApbK/BdNJwNmpdNiQVz7gsIPh5UB9g=
X-Received: by 2002:a05:6122:3bc9:b0:50d:2769:d757 with SMTP id
 71dfb90a1353d-514781ae0d1mr13959537e0c.11.1731986664163; Mon, 18 Nov 2024
 19:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20241112091423.2529583-1-fea.wang@sifive.com>
 <20241112091423.2529583-3-fea.wang@sifive.com>
In-Reply-To: <20241112091423.2529583-3-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 13:23:58 +1000
Message-ID: <CAKmqyKOy0=+xzGd-H7rUso0nMzgSLsPC+rwYBvOTucoVet2_MQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] target/riscv: Support senvcfg[UKTE] bit when
 svukte extension is enabled
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
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

On Tue, Nov 12, 2024 at 7:13=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrot=
e:
>
> Svukte extension add UKTE bit, bit[8] in senvcfg CSR. The bit will be
> supported when the svukte extension is enabled.
>
> When senvcfg[UKTE] bit is set, the memory access from U-mode should do
> the svukte check only except HLV/HLVX/HSV H-mode instructions which
> depend on hstatus[HUKTE].
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_bits.h | 1 +
>  target/riscv/csr.c      | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 385a2c67c2..4b9f899217 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -785,6 +785,7 @@ typedef enum RISCVException {
>  #define SENVCFG_CBIE                       MENVCFG_CBIE
>  #define SENVCFG_CBCFE                      MENVCFG_CBCFE
>  #define SENVCFG_CBZE                       MENVCFG_CBZE
> +#define SENVCFG_UKTE                       BIT(8)
>
>  #define HENVCFG_FIOM                       MENVCFG_FIOM
>  #define HENVCFG_LPE                        MENVCFG_LPE
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 9846770820..1936a6f32a 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2453,6 +2453,10 @@ static RISCVException write_senvcfg(CPURISCVState =
*env, int csrno,
>          mask |=3D SENVCFG_SSE;
>      }
>
> +    if (env_archcpu(env)->cfg.ext_svukte) {
> +        mask |=3D SENVCFG_UKTE;
> +    }
> +
>      env->senvcfg =3D (env->senvcfg & ~mask) | (val & mask);
>      return RISCV_EXCP_NONE;
>  }
> --
> 2.34.1
>
>

