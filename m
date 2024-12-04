Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A333E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 03:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIgWH-0001sJ-Gx; Tue, 03 Dec 2024 22:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIgWG-0001s0-IL; Tue, 03 Dec 2024 22:57:44 -0500
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIgWE-0002ej-Uy; Tue, 03 Dec 2024 22:57:44 -0500
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-5154fab9889so1552013e0c.0; 
 Tue, 03 Dec 2024 19:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733284661; x=1733889461; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t4RdB7wG3s1aQTXlPOpQkoI0J5BGgcVqyfo9usAf5Vc=;
 b=ACS9mpArZ1uifFH6SJk7AsK4jUoEcEefloqEeDq9P7T6Zc+S8a1BGIxcY63FFe93kM
 uEaILG1nml97ZuxoKaGsnx0BkwxC+19vwSnA2gDzU4321HICBL0yT+nhOlYkgEBqRtMy
 uOmSUqrvex0kpy9JiQv8QwViJw/llypHjvsbo/ukYmAoSmIE/PWnUJjiHK/w071qGV4s
 ruICNEkK+pJJdVwM16/4erIk1F+iFwavVP/5ITacegquLgMIUyYj8hQN5CRDt4NHLA9K
 YPapa80HFqhZAGKKtVe2htJfHvuoRvFIR3cQhYKockL6lq/hYx7JMywlu+LzcJOUQs1y
 c3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733284661; x=1733889461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t4RdB7wG3s1aQTXlPOpQkoI0J5BGgcVqyfo9usAf5Vc=;
 b=XJF++ohEIJ7HkB8knVaWCUUEA7S9YA017stJD8M7VsXzEu5533YUXHgKS1e3Ih0wV/
 orK1EIqAhecZ3et34jc24fbB8Fg2IYVsAhmaB2zroz4bxivQvyVqtf84ASMGpSeYPKtF
 lhAt5HGH6/oHohknLtUMtC3+crrGc+eiHGdpD0P/CixxxTSKHdJJb8CYiEaNeUH5xaHt
 M5KLE7v713Qfcs9B3DYlHuLQIJXyUkIlb/P088tfpX6teZrn7dotdSVvWaYc+4kqI+Ny
 74wyqANF2GZAr3qvlQMiGDyMSkzJ9Hw9ZJs5/Yw/uDc2IqB0kZUZSGc4oJ/9mQimXwDp
 0JcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb6655yTDNjR+0RoOLvQd8wiePN7pmlyb09nyT/t8cwHIOMMITHgMSd/KNg6RFiZwFj6kbJI1UzEfn@nongnu.org
X-Gm-Message-State: AOJu0YzhYnIeLgKVsshx7h6UBTq8RFPPtNakB8zWb9jQ6SrL48VVzUyh
 TukPKgz68DyHuRjahSVODepGXn+W0gz8pDv5PTc15rOprJpwOFGTGcNkW0zfii9Kv3p+Fh395WL
 HJ/pRlY7U1i2r2F2JgwSLw90mgm8=
X-Gm-Gg: ASbGncuONeP1svqCiuSsvp/PGHjtrrStyVjGLikpmLNVK5lqUX8/4yisgLKOvi34TzH
 u7owwb7zBPjGmtdSToUVZGbtfym+TwurD
X-Google-Smtp-Source: AGHT+IGMOrdJBbksuh3SGhuMSKr6qPGUXQ4KmuR0DGAjkgw6x23uIS2D0as82ZDV1qiTaWudSRfOm0rwVvyXh3KhgqQ=
X-Received: by 2002:a05:6122:3191:b0:50d:3ec1:1537 with SMTP id
 71dfb90a1353d-515cf5fc737mr4332255e0c.1.1733284661482; Tue, 03 Dec 2024
 19:57:41 -0800 (PST)
MIME-Version: 1.0
References: <20241113171755.978109-1-dbarboza@ventanamicro.com>
 <20241113171755.978109-10-dbarboza@ventanamicro.com>
In-Reply-To: <20241113171755.978109-10-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Dec 2024 12:57:15 +0900
Message-ID: <CAKmqyKNJ6FL9qzUnyCJxXAreW2dcpP=K-RG7gSBFPH8uYAcfOg@mail.gmail.com>
Subject: Re: [PATCH for-10.0 9/9] target/riscv/tcg: add sha
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
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

On Thu, Nov 14, 2024 at 2:19=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> 'sha' is the augmented hypervisor extension, defined in RVA22 as a set of
> the following extensions:
>
> - RVH
> - Ssstateen
> - Shcounterenw (always present)
> - Shvstvala (always present)
> - Shtvala (always present)
> - Shvstvecd (always present)
> - Shvsatpa (always present)
> - Shgatpa (always present)
>
> We can claim support for 'sha' by checking if we have RVH and ssstateen.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 2 ++
>  target/riscv/cpu_cfg.h     | 1 +
>  target/riscv/tcg/tcg-cpu.c | 8 ++++++++
>  3 files changed, 11 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index fff7010647..a8b8c9e775 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -184,6 +184,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>      ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
> +    ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
>      ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
> @@ -1615,6 +1616,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental=
_exts[] =3D {
>  const RISCVCPUMultiExtConfig riscv_cpu_named_features[] =3D {
>      MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
>      MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
> +    MULTI_EXT_CFG_BOOL("sha", ext_sha, true),
>
>      DEFINE_PROP_END_OF_LIST(),
>  };
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index c7bf455614..7c60a5becb 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -140,6 +140,7 @@ struct RISCVCPUConfig {
>      bool ext_svade;
>      bool ext_zic64b;
>      bool ext_ssstateen;
> +    bool ext_sha;
>
>      /*
>       * Always 'true' booleans for named features
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 0b9be2b0d3..b06638cca4 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -210,6 +210,11 @@ static void riscv_cpu_enable_named_feat(RISCVCPU *cp=
u, uint32_t feat_offset)
>          cpu->cfg.cbop_blocksize =3D 64;
>          cpu->cfg.cboz_blocksize =3D 64;
>          break;
> +    case CPU_CFG_OFFSET(ext_sha):
> +        if (!cpu_misa_ext_is_user_set(RVH)) {
> +            riscv_cpu_write_misa_bit(cpu, RVH, true);
> +        }
> +        /* fallthrough */
>      case CPU_CFG_OFFSET(ext_ssstateen):
>          cpu->cfg.ext_smstateen =3D true;
>          break;
> @@ -350,6 +355,9 @@ static void riscv_cpu_update_named_features(RISCVCPU =
*cpu)
>                            cpu->cfg.cboz_blocksize =3D=3D 64;
>
>      cpu->cfg.ext_ssstateen =3D cpu->cfg.ext_smstateen;
> +
> +    cpu->cfg.ext_sha =3D riscv_has_ext(&cpu->env, RVH) &&
> +                       cpu->cfg.ext_ssstateen;
>  }
>
>  static void riscv_cpu_validate_g(RISCVCPU *cpu)
> --
> 2.47.0
>
>

