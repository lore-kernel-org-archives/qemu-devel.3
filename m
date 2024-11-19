Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D900D60D18
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 03:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDEo9-0001Ma-Bt; Mon, 18 Nov 2024 22:21:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDEny-0001LZ-GS; Mon, 18 Nov 2024 22:21:30 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDEnw-0000G3-JM; Mon, 18 Nov 2024 22:21:30 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-8570543feaaso187901241.2; 
 Mon, 18 Nov 2024 19:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731986487; x=1732591287; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ILtNZwGD2kOAX231/0mAVTqsrNj6LiKnlUzMFEFhcg=;
 b=IvzOCrXQd3wJOc1dD3u/1Y2tEjFJ1fj9fFekK/OhpG2NAn2dkowWrCEbo8InqV4BNP
 3U6MS0WkhhfHaISF23NmvVuKKxJQS5ZgKR3bAeOq9R/iEzXEVjQ98NHzAQ2nByT+Pz4z
 H7G5fCh0DlJfPOAhY2tBKFDZe+XB+Ok87WQPU4o5OPVLzn9SliXv7MxNDf1l6RFhLR/7
 oOCB0BDa+bloCgigYL00+CxwHb8/hQPHAfDdH2m6nEkn8fae6g23zhCI0paqnN9kxJJU
 bX7/ZsMrO6xxuhOpytLtNK9uO+xwfNxOsdDEGqv7PSd0yuNCOMVXcwvGn1wCI6BIkEWf
 mIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731986487; x=1732591287;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ILtNZwGD2kOAX231/0mAVTqsrNj6LiKnlUzMFEFhcg=;
 b=MSlqgpyaHjZGAzrBMnpnnDcjZq4c1LuQN0bU7uMtkqp/J6OvEODDA4jqzuCIOOMRK4
 RuaJIM0+naFr2xIJ/yMfAYXSCpGNnmQ++6SuHr8PfJvF0eemW+3xNAokeLrv4h888yIG
 cjjt0t1q7pSaOQk47ESQCh03Ub1OMBIM48yZwWvaoijd8sdi9D96pnsmjZNqWDoravTD
 fqxbLUkWP+H19JLheZHyaQjYVWQ6+jgGHgsd/4zkliFk3p9WKLpc4Oifnp9QbG/9cvs0
 0dChhC30r6GNen6h+rygA66P96bUazed9UMdBgk8idwKsRTttXVi73atK+j9T8fDE5GJ
 BYkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4NEpzVZyECW5zAtI1+um1zTCQRWyZfVk2IvaQuniGLxoOyCXZLBde2ZyVU2eBQIS4fFhZFhMa/Fzh@nongnu.org
X-Gm-Message-State: AOJu0Yz4jCxYi0QGDqnbluo+b18wP33gIMlpLzXPMcIGzZR7RUUJBb4+
 lIkGr7Z0QsVhiwuOhtC7VE+Y/q7XBnYQOJMcGlv4LnM3WwA/i87XH9lBGKr643L9JeVTxTS/gYQ
 42JFwc6eQqV2OQbYx07r4p/TU/dw=
X-Google-Smtp-Source: AGHT+IEq0vsMgnNG1cnqgaIArQRNwHjD/Sy06DGiYW0pqHjcYnvy5eNKWJ9Nh6c5Bu1zW//ZZaD1J69HELR7rSm6GpY=
X-Received: by 2002:a05:6102:3ec6:b0:4a9:5dbd:6ff with SMTP id
 ada2fe7eead31-4ad631d15b5mr13067675137.27.1731986486751; Mon, 18 Nov 2024
 19:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20241113110459.1607299-1-antonb@tenstorrent.com>
In-Reply-To: <20241113110459.1607299-1-antonb@tenstorrent.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 13:21:00 +1000
Message-ID: <CAKmqyKOXW68FPAQh=BGAs=jgpOLBw4P4eBrp55h0J1brNoEt3w@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Add Tenstorrent Ascalon CPU
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Wed, Nov 13, 2024 at 9:06=E2=80=AFPM Anton Blanchard <antonb@tenstorrent=
.com> wrote:
>
> Add a CPU entry for the Tenstorrent Ascalon CPU, a series of 2 wide to
> 8 wide RV64 cores. More details can be found at
> https://tenstorrent.com/ip/tt-ascalon
>
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 67 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 62115375cd..6547642287 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -49,6 +49,7 @@
>  #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54"=
)
>  #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906"=
)
>  #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
> +#define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon"=
)
>  #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>
>  OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f219f0c3b5..8447ad0dfb 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -579,6 +579,72 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
>  #endif
>  }
>
> +/* Tenstorrent Ascalon */
> +static void rv64_tt_ascalon_cpu_init(Object *obj)
> +{
> +    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> +    RISCVCPU *cpu =3D RISCV_CPU(obj);
> +
> +    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH | RVV);
> +    env->priv_ver =3D PRIV_VERSION_1_13_0;
> +
> +    /* Enable ISA extensions */
> +    cpu->cfg.mmu =3D true;
> +    cpu->cfg.vlenb =3D 256 >> 3;
> +    cpu->cfg.elen =3D 64;
> +    cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
> +    cpu->cfg.rvv_ma_all_1s =3D true;
> +    cpu->cfg.rvv_ta_all_1s =3D true;
> +    cpu->cfg.misa_w =3D true;
> +    cpu->cfg.pmp =3D true;
> +    cpu->cfg.cbom_blocksize =3D 64;
> +    cpu->cfg.cbop_blocksize =3D 64;
> +    cpu->cfg.cboz_blocksize =3D 64;
> +    cpu->cfg.ext_zic64b =3D true;
> +    cpu->cfg.ext_zicbom =3D true;
> +    cpu->cfg.ext_zicbop =3D true;
> +    cpu->cfg.ext_zicboz =3D true;
> +    cpu->cfg.ext_zicntr =3D true;
> +    cpu->cfg.ext_zicond =3D true;
> +    cpu->cfg.ext_zicsr =3D true;
> +    cpu->cfg.ext_zifencei =3D true;
> +    cpu->cfg.ext_zihintntl =3D true;
> +    cpu->cfg.ext_zihintpause =3D true;
> +    cpu->cfg.ext_zihpm =3D true;
> +    cpu->cfg.ext_zimop =3D true;
> +    cpu->cfg.ext_zawrs =3D true;
> +    cpu->cfg.ext_zfa =3D true;
> +    cpu->cfg.ext_zfbfmin =3D true;
> +    cpu->cfg.ext_zfh =3D true;
> +    cpu->cfg.ext_zfhmin =3D true;
> +    cpu->cfg.ext_zcb =3D true;
> +    cpu->cfg.ext_zcmop =3D true;
> +    cpu->cfg.ext_zba =3D true;
> +    cpu->cfg.ext_zbb =3D true;
> +    cpu->cfg.ext_zbs =3D true;
> +    cpu->cfg.ext_zkt =3D true;
> +    cpu->cfg.ext_zvbb =3D true;
> +    cpu->cfg.ext_zvbc =3D true;
> +    cpu->cfg.ext_zvfbfmin =3D true;
> +    cpu->cfg.ext_zvfbfwma =3D true;
> +    cpu->cfg.ext_zvfh =3D true;
> +    cpu->cfg.ext_zvfhmin =3D true;
> +    cpu->cfg.ext_zvkng =3D true;
> +    cpu->cfg.ext_smaia =3D true;
> +    cpu->cfg.ext_smstateen =3D true;
> +    cpu->cfg.ext_ssaia =3D true;
> +    cpu->cfg.ext_sscofpmf =3D true;
> +    cpu->cfg.ext_sstc =3D true;
> +    cpu->cfg.ext_svade =3D true;
> +    cpu->cfg.ext_svinval =3D true;
> +    cpu->cfg.ext_svnapot =3D true;
> +    cpu->cfg.ext_svpbmt =3D true;
> +
> +#ifndef CONFIG_USER_ONLY
> +    set_satp_mode_max_supported(cpu, VM_1_10_SV57);
> +#endif
> +}
> +
>  #ifdef CONFIG_TCG
>  static void rv128_base_cpu_init(Object *obj)
>  {
> @@ -2982,6 +3048,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_=
u_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_=
u_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c=
906_cpu_init),
> +    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_asca=
lon_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_=
v1_cpu_init),
>  #ifdef CONFIG_TCG
>      DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_c=
pu_init),
> --
> 2.34.1
>
>

