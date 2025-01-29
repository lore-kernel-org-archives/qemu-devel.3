Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D7AC0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcwn3-0003Xw-HM; Tue, 28 Jan 2025 20:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwn1-0003Wj-Ql; Tue, 28 Jan 2025 20:22:47 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwn0-0000UZ-8K; Tue, 28 Jan 2025 20:22:47 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-51e902afc38so806288e0c.1; 
 Tue, 28 Jan 2025 17:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738113764; x=1738718564; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVRTXGe8jo/ox3mXpR94plsDiaQZ3KBWk7lXo0NZRFg=;
 b=duOsqtiCOTRXQdlujWeLe3VhJsRKEF5rJ/U6xYuOg4w5sUy2SjV2Bwp253nxJUIEZL
 YY6SwPiix0QgoUWf1gv35Deul5a+/c2zCxqjst4S5YNv6GRfO6V+68I4CinJ77nAPCup
 8RljXEGvP9nbdqVhVyXs25Ak2hw+5FRvwsTE2CE8jPgbSBs0GxdjSg0oUhv9ivz8MWO9
 ZgJo2PrhxX43ki1HMrclN2GRl4rHUv+Hlt8dykmfnzQMGvjtxqruz75uTERPd+cV4ndY
 qKxbl3G30qBhNIFKXu6f2SVSJhVAfkePou8Y527juUPCcUEwcmig5uwb5G/oX6Qkvu9P
 s8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738113764; x=1738718564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVRTXGe8jo/ox3mXpR94plsDiaQZ3KBWk7lXo0NZRFg=;
 b=QITwf5uIt1AA916/GgHfIvTWZ1wsbw7MQFVDcw3G/hEbvpMEPycmbQEJ1aw7u3mrn4
 CQwic+Y2a3YJZyJ1bGaKOg6QgRFPA6AxlPAHmyRmv/yV+D68XeMKhHQYZfAKoGCROjWY
 z9iR8m3xpN+TvS3u5mVu1/RIzovooTFVhb7LSnoRLqGzvDnjVKmIZWXg928w+Mm83pj1
 P15KBoheY9ypWNOeurBdzVpRsubuRiKYe6dpBpElxCfNkXCXg7Vaa5J3Fx6nYl8LRaj5
 qPZ7lxGUHmBpkWPVdIxRx2F+kYzMGJz9If3MUbJPZO8Fe3fFMzBAWWxUYoy6gvT1YgKX
 dFkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUseA5lOQfIydpW8iKa2kpNQYjplUNetIbswGA2fuWSNzUbrzFrorFTGGl5K0BdiSPI4y5osLMr8b5n@nongnu.org
X-Gm-Message-State: AOJu0YwBEeZ9A0jUJvOxQzamF/R+zTdmyj4L/AD05xsUBXv+16ref60h
 7/H+2/SscDk+xx9jZVuBlkzFS+kogWeP3aVI6lOWwOcfcG5cwSgdxUKhch5j48HwT4LhceowrP6
 4dh3FA56cYZCb8pDWXH/+Tt0m/KE=
X-Gm-Gg: ASbGncsedFsi19vhPSIjs3+/7hCMArYjOfRVmrJaBO1eFwHJDkj6X0M0tbU86NPI5UC
 LZbYsQ01TfqMNPHffAL4L7VX7TasCUfqEhaT6M3aZlwxt/BR/3MVs/ZwC5nJtWmvxSdqacatMae
 GFNxKo4sZluh2ZrxcugU3ufGgTnzQOJj+v1x6i
X-Google-Smtp-Source: AGHT+IHSW4Kh40DsSQGdUoRa1cD5++X4uMDeAU29jwweHYGQGjf6kiTQIQ3CWSC3vxhzHVBCkvc9hnGBkjzAjKhnibA=
X-Received: by 2002:a05:6122:54b:b0:518:91b3:5e37 with SMTP id
 71dfb90a1353d-51e9e43e687mr1577873e0c.5.1738113764233; Tue, 28 Jan 2025
 17:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20250114190001.1650942-1-dbarboza@ventanamicro.com>
 <20250114190001.1650942-4-dbarboza@ventanamicro.com>
In-Reply-To: <20250114190001.1650942-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Jan 2025 11:22:18 +1000
X-Gm-Features: AWEUYZl6ICy03vBIAaavBISpqW4vTNBI1IqUhW2BBBy7PiXzlgZlPz7HdclnQzM
Message-ID: <CAKmqyKPc6OuKjf3PdY9AzyUzNBzP8AtyQD6+koBSqQsu9=Z=KA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] target/riscv: add RVA23U64 profile
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Wed, Jan 15, 2025 at 5:02=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Add RVA23U64 as described in [1]. Add it as a child of RVA22U64 since
> all RVA22U64 mandatory extensions are also present in RVA23U64. What's
> left then is to list the mandatory extensions that are RVA23 only.
>
> A new "rva23u64" CPU is also added.
>
> [1] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.a=
doc
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index d56b067bf2..53ead481a9 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -40,6 +40,7 @@
>  #define TYPE_RISCV_CPU_RV64E            RISCV_CPU_TYPE_NAME("rv64e")
>  #define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
>  #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
> +#define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
>  #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibe=
x")
>  #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>  #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31"=
)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6fb4d5f374..371a7d63fa 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2395,9 +2395,33 @@ static RISCVCPUProfile RVA22S64 =3D {
>      }
>  };
>
> +/*
> + * All mandatory extensions from RVA22U64 are present
> + * in RVA23U64 so set RVA22 as a parent. We need to
> + * declare just the newly added mandatory extensions.
> + */
> +static RISCVCPUProfile RVA23U64 =3D {
> +    .parent =3D &RVA22U64,
> +    .name =3D "rva23u64",
> +    .misa_ext =3D RVV,
> +    .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,
> +    .satp_mode =3D RISCV_PROFILE_ATTR_UNUSED,
> +    .ext_offsets =3D {
> +        CPU_CFG_OFFSET(ext_zvfhmin), CPU_CFG_OFFSET(ext_zvbb),
> +        CPU_CFG_OFFSET(ext_zvkt), CPU_CFG_OFFSET(ext_zihintntl),
> +        CPU_CFG_OFFSET(ext_zicond), CPU_CFG_OFFSET(ext_zimop),
> +        CPU_CFG_OFFSET(ext_zcmop), CPU_CFG_OFFSET(ext_zcb),
> +        CPU_CFG_OFFSET(ext_zfa), CPU_CFG_OFFSET(ext_zawrs),
> +        CPU_CFG_OFFSET(ext_supm),
> +
> +        RISCV_PROFILE_EXT_LIST_END
> +    }
> +};
> +
>  RISCVCPUProfile *riscv_profiles[] =3D {
>      &RVA22U64,
>      &RVA22S64,
> +    &RVA23U64,
>      NULL,
>  };
>
> @@ -2884,6 +2908,13 @@ static void rva22s64_profile_cpu_init(Object *obj)
>
>      RVA22S64.enabled =3D true;
>  }
> +
> +static void rva23u64_profile_cpu_init(Object *obj)
> +{
> +    rv64i_bare_cpu_init(obj);
> +
> +    RVA23U64.enabled =3D true;
> +}
>  #endif
>
>  static const gchar *riscv_gdb_arch_name(CPUState *cs)
> @@ -3163,6 +3194,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>      DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_c=
pu_init),
>      DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_pro=
file_cpu_init),
>      DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_pro=
file_cpu_init),
> +    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_pro=
file_cpu_init),
>  #endif /* TARGET_RISCV64 */
>  };
>
> --
> 2.47.1
>
>

