Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93592D60D18
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 03:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDEi9-0000Ib-HS; Mon, 18 Nov 2024 22:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDEi7-0000I5-HK; Mon, 18 Nov 2024 22:15:27 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDEi5-00083n-Ii; Mon, 18 Nov 2024 22:15:27 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-514bb6953f4so228897e0c.2; 
 Mon, 18 Nov 2024 19:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731986124; x=1732590924; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rzWGx/RBy9YssCzco6cfWDNj7CEiuLv4M+irqUiDBC4=;
 b=ARPcPUMla8zTMIP6de7PUsa1iv64sgaKhowURC/zgIHM+RHYx6vLcwcEQ8Svb972dx
 ZwwimjIybZtG2m60OA0/JEbHid6QH/oDehruzt0w7/LO9/66x3e/cIyHHZJvT294jMm6
 +/6ZQU7oWRgEYTBCw7eSpKAMrYFIRmGgAqE24NfH/huxAoGItE55H1/7VoxqzxRMW0BP
 Dyt4TqMC+2ev07IZJW9kU7ELqI876T+hzORdiNylF60p6YU3E2UCH6bzuAVZ04u6UFWQ
 wWv6MMI2jKudCTDYzHoLQ4xPWHeY5yJrWWT+9loxYw5Y0uV11nKWT/1U8TCK8YDh3ojh
 m9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731986124; x=1732590924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rzWGx/RBy9YssCzco6cfWDNj7CEiuLv4M+irqUiDBC4=;
 b=OXjDeqXdZGjmt8tHUhTlK6yanbEkItYmIbvX3BDwlIkhfucbY0Z9Oa4qasry0rOVD9
 SMcJduX/UhJ01hNCUXGNYMz+bnYzTlHyD4HPdDkOmTr8WUJYBrDS/Q7sjXXLze5vqFq3
 RWB3B88wp9eYW9kK7sMEKqq8AqkVNBQkCHW/pf/rwWjHqFlRc3WxSFi1soFr8eKiKM9S
 HH4aTpUft9VHpM/31knlsPtxDvtcAwJiDTZFa3KnvY9A50JuKzrnkpLtRG359Xtvlznj
 IvTSezCUn7Z539e7cyRKeTEloqZr3mD4uKJi3sSgmvWSl/Qb4f1XMa98CAfJsyzYnu4g
 YDCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGw9J5MKgI1a/CO+UT6LY+LQ2dsnGaLG2IIN6aJt95x1tjx3HSNuGEOqmfg+GZmjcrzAlhtnvkuUAE@nongnu.org
X-Gm-Message-State: AOJu0YwMmGVI7rEWWVP/+9tQ5fx+gwQqcCZ0npBlgMJJUoE2jsANMIaX
 bopCB8q75IGOqlheSaNcULzvNNdmMi+tm3AlkuXwYytWnNe0CLbPrEMCQoGBZOeNXzmCJj+azVF
 MZ8Ep6pVd5RhLISbcUMESzsnjgL4=
X-Google-Smtp-Source: AGHT+IGmER+VKNsVfE6F6nZhK/yj+vUA9N31pyO1HI06dqZf9MY/e0UNwGl72LimyXYwUxLB9es1taT1myjJmW7Yqas=
X-Received: by 2002:a05:6122:896:b0:509:e80:3ed2 with SMTP id
 71dfb90a1353d-5147866a43bmr12239776e0c.7.1731986123836; Mon, 18 Nov 2024
 19:15:23 -0800 (PST)
MIME-Version: 1.0
References: <20241113110459.1607299-1-antonb@tenstorrent.com>
In-Reply-To: <20241113110459.1607299-1-antonb@tenstorrent.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 13:14:57 +1000
Message-ID: <CAKmqyKO0+H7Wc_cjOHZ4-C6Q3Zsi-6aKHGZYs8QdsskZYBsvkQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>

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

