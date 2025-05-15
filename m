Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FACCC2D0CB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRMc-0007Jt-TQ; Thu, 15 May 2025 01:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRMX-0007By-FW
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:42:33 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRMV-0008Aw-8f
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:42:33 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-86f9c719d63so119428241.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 22:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747287750; x=1747892550; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YBduvQkxvMQ9RBJcVlSa9QYTlgKMlO60e4HxZjKU+JA=;
 b=aLhVHWk1Z1WKK1CpslE+eWCs1BYrVZWQOJ2STF+gyJb3wHpTBtBlhk+ykdHVXOsJGN
 5nu/URAGwxIOa8vqJqUFexAS2I+tByikHh3J1fQ0D04Mdi2DeqNxwGAjCgeqfZvGe2I3
 CXoYeIZ8nHOfDFqaPMBqhUFWR4C80cM9M+/tMieDqFwdqtaekKRJZDZxSEQ6vHHM7nyC
 G6VY8skwwqXu7pABAG10fbZ4CvWs4lhKyPgEExUxUGm00eAsoyb4v1g9ttoO6Sf8F9kL
 5IE8+ywInbFFccweIr0VrPVarZLwtjXCN+HXKxkcVbT8oncoZf+AwgTlx3HYBv3HuNdj
 OvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747287750; x=1747892550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YBduvQkxvMQ9RBJcVlSa9QYTlgKMlO60e4HxZjKU+JA=;
 b=KzSSTOqxp46u3aZfo5VTgObiDeRUSYV35ZIr0RopFUnUnUVxBH+aZ6UuEX0iKB4/zZ
 gjjVMb398gaGmD49guEXebr4zzv/ZKrCluDvgkSOoovFTetHZY7mBZ4v8RxsC54T6Obc
 /0mpZ3QU4YTNsXOR+Ft9JpGLJrO1yKf3QdRuLsjfuSaaTJPahx1UW61WISSR8GqC/AyT
 DNKjtDwHEX6jptu1tOhzGi226lPKcfR7CfyDuab5PD8wTXXMtjSrDmOBjZBUYldw1nbs
 SCeMmqVXruMCrGSWi6zXr5ht1Do74imUewzl5WFBgXVqRhHu4OnpW3PlcmgfUnteAcjj
 9fDw==
X-Gm-Message-State: AOJu0YxyzTdBYeOlHSAKKObs0Qvo8T8LBL90EG9wRbnyFmIQ8nhv1oNz
 0WoRCp1YxUK5cKy+CjaRhniXRR1slbN6LXZoNkQVzu1SX/V32XmEwTlJQtyIvTQyYu9HestikGH
 7qvyQCOffTpAu03Wwnqt3gUSYrPM=
X-Gm-Gg: ASbGncuNQZ9AnCzTtYcMEzOjpvFaouauUPZcNy4dUfaNcDfggcOt1+8zmNtuYt1sc5X
 UGMyLmIm89L90tq0XQ2VRcKVHoCyfzAFT8oMMcVY6avmEVy9IIdPzA2kv8a2q6uTosFZJBM9BDl
 lMHcbGjkx4KSWdoCmn5u3ihgCETOMprZcAd3HTn1kD55uRzSTAhnodjx2j1jte+Vc=
X-Google-Smtp-Source: AGHT+IFVOhYMRejX9lyGr0qNlITst7FWUNIKQg1QQY5PeQrvDdjL1i8gK3/h1w9gGVf5NIqNBR2gFofmAQlMPMLvWdY=
X-Received: by 2002:a05:6102:801d:b0:4af:c519:4e7f with SMTP id
 ada2fe7eead31-4df7dd3c21amr5817838137.18.1747287749976; Wed, 14 May 2025
 22:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <20250512095226.93621-23-pbonzini@redhat.com>
In-Reply-To: <20250512095226.93621-23-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 May 2025 15:42:03 +1000
X-Gm-Features: AX0GCFve8xPujGF7l3j-xZ_81CbkhTLrhaL7DV_bAj_wolFsBTm0Mp0q2syBp2I
Message-ID: <CAKmqyKMCz_SJUYnbix+tnJBpHpSFgmWb0QbgTjNFGuNPyOzMzg@mail.gmail.com>
Subject: Re: [PATCH 22/26] target/riscv: convert TT Ascalon to RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Mon, May 12, 2025 at 7:54=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 127 +++++++++++++++++++++------------------------
>  1 file changed, 60 insertions(+), 67 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index dbfd8c7a348..18b60428d14 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -539,72 +539,6 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
>  #endif
>  }
>
> -/* Tenstorrent Ascalon */
> -static void rv64_tt_ascalon_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -
> -    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH | RVV);
> -    env->priv_ver =3D PRIV_VERSION_1_13_0;
> -
> -    /* Enable ISA extensions */
> -    cpu->cfg.mmu =3D true;
> -    cpu->cfg.vlenb =3D 256 >> 3;
> -    cpu->cfg.elen =3D 64;
> -    cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
> -    cpu->cfg.rvv_ma_all_1s =3D true;
> -    cpu->cfg.rvv_ta_all_1s =3D true;
> -    cpu->cfg.misa_w =3D true;
> -    cpu->cfg.pmp =3D true;
> -    cpu->cfg.cbom_blocksize =3D 64;
> -    cpu->cfg.cbop_blocksize =3D 64;
> -    cpu->cfg.cboz_blocksize =3D 64;
> -    cpu->cfg.ext_zic64b =3D true;
> -    cpu->cfg.ext_zicbom =3D true;
> -    cpu->cfg.ext_zicbop =3D true;
> -    cpu->cfg.ext_zicboz =3D true;
> -    cpu->cfg.ext_zicntr =3D true;
> -    cpu->cfg.ext_zicond =3D true;
> -    cpu->cfg.ext_zicsr =3D true;
> -    cpu->cfg.ext_zifencei =3D true;
> -    cpu->cfg.ext_zihintntl =3D true;
> -    cpu->cfg.ext_zihintpause =3D true;
> -    cpu->cfg.ext_zihpm =3D true;
> -    cpu->cfg.ext_zimop =3D true;
> -    cpu->cfg.ext_zawrs =3D true;
> -    cpu->cfg.ext_zfa =3D true;
> -    cpu->cfg.ext_zfbfmin =3D true;
> -    cpu->cfg.ext_zfh =3D true;
> -    cpu->cfg.ext_zfhmin =3D true;
> -    cpu->cfg.ext_zcb =3D true;
> -    cpu->cfg.ext_zcmop =3D true;
> -    cpu->cfg.ext_zba =3D true;
> -    cpu->cfg.ext_zbb =3D true;
> -    cpu->cfg.ext_zbs =3D true;
> -    cpu->cfg.ext_zkt =3D true;
> -    cpu->cfg.ext_zvbb =3D true;
> -    cpu->cfg.ext_zvbc =3D true;
> -    cpu->cfg.ext_zvfbfmin =3D true;
> -    cpu->cfg.ext_zvfbfwma =3D true;
> -    cpu->cfg.ext_zvfh =3D true;
> -    cpu->cfg.ext_zvfhmin =3D true;
> -    cpu->cfg.ext_zvkng =3D true;
> -    cpu->cfg.ext_smaia =3D true;
> -    cpu->cfg.ext_smstateen =3D true;
> -    cpu->cfg.ext_ssaia =3D true;
> -    cpu->cfg.ext_sscofpmf =3D true;
> -    cpu->cfg.ext_sstc =3D true;
> -    cpu->cfg.ext_svade =3D true;
> -    cpu->cfg.ext_svinval =3D true;
> -    cpu->cfg.ext_svnapot =3D true;
> -    cpu->cfg.ext_svpbmt =3D true;
> -
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(cpu, VM_1_10_SV57);
> -#endif
> -}
> -
>  static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
>  {
>      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> @@ -3213,7 +3147,66 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>  #endif
>      ),
>
> -    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_asca=
lon_cpu_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_TT_ASCALON, TYPE_RISCV_VENDOR_CPU,
> +        .misa_mxl_max =3D MXL_RV64,
> +        .misa_ext =3D RVG | RVC | RVS | RVU | RVH | RVV,
> +        .priv_spec =3D PRIV_VERSION_1_13_0,
> +        .vext_spec =3D VEXT_VERSION_1_00_0,
> +
> +        /* ISA extensions */
> +        .cfg.mmu =3D true,
> +        .cfg.vlenb =3D 256 >> 3,
> +        .cfg.elen =3D 64,
> +        .cfg.rvv_ma_all_1s =3D true,
> +        .cfg.rvv_ta_all_1s =3D true,
> +        .cfg.misa_w =3D true,
> +        .cfg.pmp =3D true,
> +        .cfg.cbom_blocksize =3D 64,
> +        .cfg.cbop_blocksize =3D 64,
> +        .cfg.cboz_blocksize =3D 64,
> +        .cfg.ext_zic64b =3D true,
> +        .cfg.ext_zicbom =3D true,
> +        .cfg.ext_zicbop =3D true,
> +        .cfg.ext_zicboz =3D true,
> +        .cfg.ext_zicntr =3D true,
> +        .cfg.ext_zicond =3D true,
> +        .cfg.ext_zicsr =3D true,
> +        .cfg.ext_zifencei =3D true,
> +        .cfg.ext_zihintntl =3D true,
> +        .cfg.ext_zihintpause =3D true,
> +        .cfg.ext_zihpm =3D true,
> +        .cfg.ext_zimop =3D true,
> +        .cfg.ext_zawrs =3D true,
> +        .cfg.ext_zfa =3D true,
> +        .cfg.ext_zfbfmin =3D true,
> +        .cfg.ext_zfh =3D true,
> +        .cfg.ext_zfhmin =3D true,
> +        .cfg.ext_zcb =3D true,
> +        .cfg.ext_zcmop =3D true,
> +        .cfg.ext_zba =3D true,
> +        .cfg.ext_zbb =3D true,
> +        .cfg.ext_zbs =3D true,
> +        .cfg.ext_zkt =3D true,
> +        .cfg.ext_zvbb =3D true,
> +        .cfg.ext_zvbc =3D true,
> +        .cfg.ext_zvfbfmin =3D true,
> +        .cfg.ext_zvfbfwma =3D true,
> +        .cfg.ext_zvfh =3D true,
> +        .cfg.ext_zvfhmin =3D true,
> +        .cfg.ext_zvkng =3D true,
> +        .cfg.ext_smaia =3D true,
> +        .cfg.ext_smstateen =3D true,
> +        .cfg.ext_ssaia =3D true,
> +        .cfg.ext_sscofpmf =3D true,
> +        .cfg.ext_sstc =3D true,
> +        .cfg.ext_svade =3D true,
> +        .cfg.ext_svinval =3D true,
> +        .cfg.ext_svnapot =3D true,
> +        .cfg.ext_svpbmt =3D true,
> +
> +        .cfg.max_satp_mode =3D VM_1_10_SV57,
> +    ),
> +
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_=
v1_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
>                                                   MXL_RV64, rv64_xiangsha=
n_nanhu_cpu_init),
> --
> 2.49.0
>

