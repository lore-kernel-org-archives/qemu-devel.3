Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10F3C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 00:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEIKT-0004uk-3s; Mon, 03 Jun 2024 20:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEIKR-0004u5-2e; Mon, 03 Jun 2024 20:47:07 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEIKP-0008Dw-An; Mon, 03 Jun 2024 20:47:06 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-4e8a6159479so1924852e0c.3; 
 Mon, 03 Jun 2024 17:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717462024; x=1718066824; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQPfld/47uidk2YJZIFuy5Zy5ZXeJNjJoGJZb6Mu7eM=;
 b=XrbGBixZiKnPCCRZL6LA7Ow0sDUjMtEq48slPT760YwpPBeyX3poruDFeNDx/BNo3E
 UoS3cILC7+9xJLykByNnT1e8trCKds4x1IMBGaY1KGDJR10wWholI5NAN6d2XsA7pzZj
 D7pJxq2jV44g1Vw+e4MXjgYc6Fw5XrmmuhhBdq6nS3WzQ55CKQYDl+KjKiaIOtyredx4
 evHL/j2b5ifzu4Gfh9+M21Mv6/YxFJFK/cgpxjuFcGPYE2ax+hTr8F2J9jb4/jmXUPh8
 3KLWTgpnOFrLrqXYwi4RcU+rRwO6OXggc1UqN5GYS4hv1Szrk583st3Sw9XuKtgASrG/
 wUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717462024; x=1718066824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQPfld/47uidk2YJZIFuy5Zy5ZXeJNjJoGJZb6Mu7eM=;
 b=rTay0q4YrahYXM9JEgYssbrcuXPgSd7BTO7Op4Fh2JoDxvrq4iiRCU+bN5UVvcL/yU
 /gJc8RWGnk3OsA3jWrHyDICNwRTMvY5nPDpS/2u8TcBOyJNECHQtMjeZBBepl4wUbYo+
 wqAmBTFgR5WtFsft6vlorfRenpimxmDIX8nNcc0EnfFLmyOudRv7nD82pjXO+SWR1+42
 JWyiRnPBmBTO2p7tff/YEN0OmaVxE8/xtDvzRJLjAnLI3rb+d6bTQHYG+50docLtX3hZ
 nH9t8bABNKJSPndLjmZq80aGm4kA8GpskA+zb5KUx7tLY0aeZ8igMF4HoBtU7F1Jv+Le
 DEiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV5EZpokATHlB3j5b2ECctl+h3EAhkjYhZMVbLVY/+/+9XDSN1QpwwuEYwM58tgWmGKWgua2PfWMYx7KrE2QSjueIFD08=
X-Gm-Message-State: AOJu0YwFPeTQ+JevIgYMxV1zW2VErmnatsxM2rNHwr0+u7HYweD6mJzq
 qccABUznn3lsWcRwkXrH/mLMZN4aA/ja1XR4HCERBWv8iAuVYSQsQt+GrIlYTElyTxK0b+2oyGG
 YueK6JPZJc5w1N6MkG2Po7an3X+s=
X-Google-Smtp-Source: AGHT+IEGyJHn8PdE+WI33EkInYD+vVuWN7sNwnd278yBgkMD77HGi/gt/98nQNHmFGE58ubxPyHQdjCDJSi2U6ftfO4=
X-Received: by 2002:a05:6122:368c:b0:4eb:1499:607f with SMTP id
 71dfb90a1353d-4eb1499630amr6626469e0c.14.1717462023628; Mon, 03 Jun 2024
 17:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240515080605.2675399-1-fea.wang@sifive.com>
 <20240515080605.2675399-3-fea.wang@sifive.com>
In-Reply-To: <20240515080605.2675399-3-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 10:46:37 +1000
Message-ID: <CAKmqyKMPy40UQxvVAyuJ+tvC3-58nMvYB1UqMDcoDOT5_A8u1A@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 2/5] target/riscv: Support the version for ss1p13
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Frank Chang <frank.chang@sifive.com>, Weiwei Li <liwei1518@gmail.com>, 
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, Max Chou <max.chou@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

On Wed, May 15, 2024 at 6:02=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrot=
e:
>
> Add RISC-V privilege 1.13 support.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by:  Weiwei Li <liwei1518@gmail.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 6 +++++-
>  target/riscv/cpu.h         | 4 +++-
>  target/riscv/cpu_cfg.h     | 1 +
>  target/riscv/tcg/tcg-cpu.c | 4 ++++
>  4 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6dd3d7f4a3..ee2ec4c4e5 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1775,7 +1775,9 @@ static int priv_spec_from_str(const char *priv_spec=
_str)
>  {
>      int priv_version =3D -1;
>
> -    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
> +    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_13_0_STR)) {
> +        priv_version =3D PRIV_VERSION_1_13_0;
> +    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
>          priv_version =3D PRIV_VERSION_1_12_0;
>      } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_11_0_STR)) {
>          priv_version =3D PRIV_VERSION_1_11_0;
> @@ -1795,6 +1797,8 @@ const char *priv_spec_to_str(int priv_version)
>          return PRIV_VER_1_11_0_STR;
>      case PRIV_VERSION_1_12_0:
>          return PRIV_VER_1_12_0_STR;
> +    case PRIV_VERSION_1_13_0:
> +        return PRIV_VER_1_13_0_STR;
>      default:
>          return NULL;
>      }
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 140eb43fcb..f691c7d828 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -96,12 +96,14 @@ extern RISCVCPUProfile *riscv_profiles[];
>  #define PRIV_VER_1_10_0_STR "v1.10.0"
>  #define PRIV_VER_1_11_0_STR "v1.11.0"
>  #define PRIV_VER_1_12_0_STR "v1.12.0"
> +#define PRIV_VER_1_13_0_STR "v1.13.0"
>  enum {
>      PRIV_VERSION_1_10_0 =3D 0,
>      PRIV_VERSION_1_11_0,
>      PRIV_VERSION_1_12_0,
> +    PRIV_VERSION_1_13_0,
>
> -    PRIV_VERSION_LATEST =3D PRIV_VERSION_1_12_0,
> +    PRIV_VERSION_LATEST =3D PRIV_VERSION_1_13_0,
>  };
>
>  #define VEXT_VERSION_1_00_0 0x00010000
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index e1e4f32698..fb7eebde52 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -136,6 +136,7 @@ struct RISCVCPUConfig {
>       * TCG always implement/can't be user disabled,
>       * based on spec version.
>       */
> +    bool has_priv_1_13;
>      bool has_priv_1_12;
>      bool has_priv_1_11;
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index fa186093fb..f53422d605 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -318,6 +318,10 @@ static void riscv_cpu_update_named_features(RISCVCPU=
 *cpu)
>          cpu->cfg.has_priv_1_12 =3D true;
>      }
>
> +    if (cpu->env.priv_ver >=3D PRIV_VERSION_1_13_0) {
> +        cpu->cfg.has_priv_1_13 =3D true;
> +    }
> +
>      /* zic64b is 1.12 or later */
>      cpu->cfg.ext_zic64b =3D cpu->cfg.cbom_blocksize =3D=3D 64 &&
>                            cpu->cfg.cbop_blocksize =3D=3D 64 &&
> --
> 2.34.1
>
>

