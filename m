Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66158CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 01:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ034-0006ZD-SM; Tue, 11 Nov 2025 20:53:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vJ02j-0006Vf-H4
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 20:53:14 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vJ02g-0002B8-0S
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 20:53:05 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b728a43e410so67057066b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 17:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762912380; x=1763517180; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h3NSfBrXFusAi+hWaGkvdhWGYM99uw6czHjs+nP0lI4=;
 b=bByZAkiYNUhLLALe+Los5YB1oRMyATQuaMMAvmUWePsB90ymAL7fnEEahhjavjQB/u
 Bsh554pTiJKqX4tLBWH4hD8FCsfYCn7FIc8rFwhtsQ8cVk6bFbvAdrtRjtygp9DIxua/
 e7eUafYeqYZ7CqkbhFTHhIzz2vstuCOUXwp4h4P2RaVdFarUEvYd6jESlrQUn/Tk7jPp
 sl+N99vqs/eNH1RK7Mwaso24NBtbXHM+59+V8jNMNnkM0lbGMs7aKyfuGs+cXt3/YjYZ
 nS+rdl6ktsuHhwid4hwqGVyllvd63DUu1wcCvD/F/uT07JbIkazWQfT9DbIMVKPHs3B2
 eMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762912380; x=1763517180;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h3NSfBrXFusAi+hWaGkvdhWGYM99uw6czHjs+nP0lI4=;
 b=la9q8onmFebS337Ihr/nAuSm9xLa7y5Yb3pDvN02cSpIReNogjVyoQL4Qv/onpoNfG
 bbNmfwWazRgcioSKB2VCa3CrnIKRS7X/pBUZDttpVHK7VsahntouIRgXulxpT45xI2Oq
 zDRgNek229zr1KV9wWEgQqKoiwwEu3HHx+EpHg5D+jXJ6Md/nIXew2CuCqEIK3GEcWEN
 yxbFfDQjb1/QwXbyG7WibgeYx1nhzoz15FFxCyOtajJynN9F1g1eLkKCpHotkIeo7Qki
 056zCP56nxppgFwUe+OmYcwti4HzNONWQytlnq5kt0XdKsPKMtikAQJ5EeMtPb90DCZP
 6ICQ==
X-Gm-Message-State: AOJu0YzCCIv/nPDY9WEAZ8iaBRoVQxX8Alq0nRLwbwmXqi6DWnJ4gQFJ
 +ZdOEUP3bAt2t+xrTcNkFdVkMqWJYpBnmvbqxAsjd1lG5+jClxeeqKojJkZhnHLQVM0cSyI0jvd
 9FfxjXvIbPWL39pfgKpukilCa0UDgnr+UyA==
X-Gm-Gg: ASbGncvc9qEjvX9BR8+etScIduy9CKyVkG5TuapwAJ1kiSSSNAAy/R50W7ZUIxTZ4rs
 Qe4a1gFJOscIL/QoZZ2LOup+6jQbrcHjCP/vCgPOGvkGTN3AQ9+4yo/c4Ak1FN4zqc4eIMBrUhv
 kIqHuyWZh9SJ2nH9SDtLxYWSFjmb0nFEH9H6Xly84dFAOxgjndecGNgtJNjwqTUWDMOxfBkD9/7
 hh6w0ISXIZBgg5judGYk1Rru4xJlDFlCSzgB6NGXxrh1gfwyr4yLHLyp+9GtLENAHD7fFhbY8fG
 Uc3usOJkvs1o2Qc=
X-Google-Smtp-Source: AGHT+IGxUEgL8WFg6CGYQFor4OfLvHtzP9op9N5MJ/p98ABJEsFpXCBZoIF8VhsunTNRbKjlpvl/d2lmA/C+4Qw1BIE=
X-Received: by 2002:a17:907:7f17:b0:b70:b3e8:a353 with SMTP id
 a640c23a62f3a-b7331ac5960mr108529566b.50.1762912380218; Tue, 11 Nov 2025
 17:53:00 -0800 (PST)
MIME-Version: 1.0
References: <20251027100938.11822-1-michael@videogpu.com>
 <20251027100938.11822-2-michael@videogpu.com>
In-Reply-To: <20251027100938.11822-2-michael@videogpu.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Nov 2025 11:52:33 +1000
X-Gm-Features: AWmQ_blnEkxcXk9je3KDXlQviT1XutaPVKEk9kGZKdg4ml-pnSG7t9BwxJkmHck
Message-ID: <CAKmqyKOoZnm+wjypuTPxRWYGy+bb=RS3sc0gF=TOeBybaAmwaw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] target/riscv: add NEORV32 RV32 CPU type and vendor
 CSR hooks
To: Michael Levit <michael@videogpu.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, philmd@linaro.org, 
 pbonzini@redhat.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 liwei1518@gmail.com, smishash@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
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

On Mon, Oct 27, 2025 at 8:12=E2=80=AFPM Michael Levit <michael@videogpu.com=
> wrote:
>
> From: Michael <michael@videogpu.com>
>
> Introduce NEORV32 RV32 CPU type under target/riscv, wire NEORV32 vendor I=
D,
> and add a vendor CSR (CSR_MXISA) guarded by mvendorid match, plus meson g=
lue.

Looks good. There are a bunch of whitespace errors though, can you run
your patches through checkpatch.pl

Alistair

>
> Signed-off-by: Michael Levit <michael@videogpu.com>
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 75f4e43408..a39bf853cc 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -57,6 +57,8 @@
>  #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-n=
anhu")
>  #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-k=
unminghu")
>  #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
> +#define TYPE_RISCV_CPU_NEORV32          RISCV_CPU_TYPE_NAME("neorv32")
> +
>
>  OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 73d4280d7c..7bcf93c66c 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -245,6 +245,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(xtheadmempair, PRIV_VERSION_1_11_0, ext_xtheadmem=
pair),
>      ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
>      ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentan=
aCondOps),
> +    ISA_EXT_DATA_ENTRY(xneorv32xisa,PRIV_VERSION_1_10_0,ext_xneorv32xisa=
),
>
>      { },
>  };
> @@ -1366,6 +1367,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[=
] =3D {
>      MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
>      MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
>      MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
> +       MULTI_EXT_CFG_BOOL("xneorv32xisa", ext_xneorv32xisa, false),
>
>      { },
>  };
> @@ -3032,6 +3034,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.pmp_regions =3D 8
>      ),
>
> +
>  #if defined(TARGET_RISCV32) || \
>      (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
> @@ -3075,6 +3078,21 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .misa_mxl_max =3D MXL_RV32,
>          .misa_ext =3D RVE
>      ),
> +       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_NEORV32, TYPE_RISCV_VENDOR_CPU,
> +               .misa_mxl_max =3D MXL_RV32,
> +        .misa_ext =3D RVI | RVM | RVA | RVC | RVU,
> +        .priv_spec =3D PRIV_VERSION_1_10_0,
> +
> +        .cfg.max_satp_mode =3D VM_1_10_MBARE,
> +        .cfg.ext_zifencei =3D true,
> +        .cfg.ext_zicsr =3D true,
> +        .cfg.pmp =3D true,
> +        .cfg.pmp_regions =3D 16,
> +               .cfg.mvendorid =3D NEORV32_VENDOR_ID,
> +#ifndef CONFIG_USER_ONLY
> +        .custom_csrs =3D neorv32_csr_list
> +#endif
> +    ),
>  #endif
>
>  #if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 36e7f10037..6a9918a25a 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -985,5 +985,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_=
32_bit);
>  /* In th_csr.c */
>  extern const RISCVCSR th_csr_list[];
>
> +/* Implemented in neorv32_csr.c */
> +extern const RISCVCSR neorv32_csr_list[];
> +
>  const char *priv_spec_to_str(int priv_version);
>  #endif /* RISCV_CPU_H */
>
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index aa28dc8d7e..9ad38506e4 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -64,5 +64,6 @@ MATERIALISE_EXT_PREDICATE(xtheadmemidx)
>  MATERIALISE_EXT_PREDICATE(xtheadmempair)
>  MATERIALISE_EXT_PREDICATE(xtheadsync)
>  MATERIALISE_EXT_PREDICATE(XVentanaCondOps)
> +MATERIALISE_EXT_PREDICATE(xneorv32xisa)
>
>  #endif
>
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index a154ecdc79..b84e1bd287 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
>  BOOL_FIELD(ext_xtheadmempair)
>  BOOL_FIELD(ext_xtheadsync)
>  BOOL_FIELD(ext_XVentanaCondOps)
> +BOOL_FIELD(ext_xneorv32xisa)
>
>  BOOL_FIELD(mmu)
>  BOOL_FIELD(pmp)
>
> diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
> index 96b6b9c2cb..66a8f30b81 100644
> --- a/target/riscv/cpu_vendorid.h
> +++ b/target/riscv/cpu_vendorid.h
> @@ -7,4 +7,6 @@
>  #define VEYRON_V1_MIMPID        0x111
>  #define VEYRON_V1_MVENDORID     0x61f
>
> +#define NEORV32_VENDOR_ID       0xF0000001
> +
>  #endif /*  TARGET_RISCV_CPU_VENDORID_H */
>
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index fdefe88ccd..44e706ad3f 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -40,6 +40,7 @@ riscv_system_ss.add(files(
>    'th_csr.c',
>    'time_helper.c',
>    'riscv-qmp-cmds.c',
> +  'neorv32_csr.c',
>  ))
>
>  subdir('tcg')
>
> diff --git a/target/riscv/neorv32_csr.c b/target/riscv/neorv32_csr.c
> new file mode 100644
> index 0000000000..0cb8663436
> --- /dev/null
> +++ b/target/riscv/neorv32_csr.c
> @@ -0,0 +1,54 @@
> +/*
> + * Neorv32-specific CSR.
> + *
> + * Copyright (c) 2025 Michael Levit
> + *
> + * Author:
> + *   Michael Levit <michael@videogpu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "cpu_vendorid.h"
> +
> +#define    CSR_MXISA    (0xfc0)
> +
> +static RISCVException smode(CPURISCVState *env, int csrno)
> +{
> +       return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_neorv32_xisa(CPURISCVState *env, int csrno,
> +                                       target_ulong *val)
> +{
> +       /* We don't support any extension for now on QEMU */
> +    *val =3D 0x00;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static bool test_neorv32_mvendorid(RISCVCPU *cpu)
> +{
> +    return cpu->cfg.mvendorid =3D=3D NEORV32_VENDOR_ID;
> +}
> +
> +const RISCVCSR neorv32_csr_list[] =3D {
> +    {
> +        .csrno =3D CSR_MXISA,
> +        .insertion_test =3D test_neorv32_mvendorid,
> +        .csr_ops =3D { "neorv32.xisa", smode, read_neorv32_xisa }
> +    },
> +    { }
> +};
> +
> --
> 2.51.1
>

