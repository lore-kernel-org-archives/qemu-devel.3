Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C439C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 10:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6SyF-0004I2-5K; Mon, 13 May 2024 06:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6SyB-0004CO-Aq; Mon, 13 May 2024 06:31:47 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6Sy9-00025W-8R; Mon, 13 May 2024 06:31:47 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-7f34ebbcde4so1194216241.3; 
 Mon, 13 May 2024 03:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715596303; x=1716201103; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DsI1weIBSJMTTlyQgJyLl6EDZ985NNAHdpnJWgYg1s8=;
 b=JSeiuL5R2aYnGszhr+xkqguvNq8rRRFwLJ4r63xCXs9OqMsi4+TJYeRtFoJNPKjlc3
 LWd9wX3OykNnFwJrzu8kibIaXySmA4StBYFTtZCsW8JrGojM4DntRIcujaCAip67+Zbf
 fpQP5LFa1o/iLuWKi2JG5Y/f0VSzh4Fil4kqURAKbZZqbOzbTNaz9cDq5gdSBN2IKxL2
 sbL24S2DN1d05JfOKJOZVI5m5yDwBncXblhEnk7Qf5eg3PfEC2SUc+ang20pJ3YAYhL3
 4ZOJNR4X/N89OcL2MnwFlliKhnhklfwtMjxyLcICJfvUtcOP9LTbH7aIAXDogAyNR8s6
 2Ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715596303; x=1716201103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DsI1weIBSJMTTlyQgJyLl6EDZ985NNAHdpnJWgYg1s8=;
 b=QoT3VFpeoScdXkLkeiuRcLBj6boTURtk24QpvC3w0uM0QiMzWForWzS1bFl7EWh7G3
 /dtcykHgH3Mv5UUgp8YDZOLekxgJZm9EEI250S5njnoC0j3ePLMgrkgN1VD7QHH5G4QA
 Tc9/hfb5KAr4hmtQ7flcFkJYg2YZ9jvHMpwxUHZ0rF2daK+rPNEz3TDTMZCVr+qry0Hq
 ZAdPF+hM+kQOTqN2/N7xIo7pydnvFAF7+acv8wFgc0bOTBaxpixBl+SQxpF9opea5782
 bWdIchSZLK/PoeAm4DzZj1XUTGvPV1tJvnk9WXCriNGhM+yc1bVgs5wT4W2ELabv3P2u
 +X2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtANv9ZDo8uHmpy/mKibQGWPLpEJj88tIJaw/T4H3PQQL+BSv4M+nC6nUdbMgL/QGfhaf+FCCUzG5nE05pOgGSn+glycc=
X-Gm-Message-State: AOJu0YxLzAeKOJiblTMu32S+4xRLd8gifWKh25bQwjsMUkcnVwUhINWw
 Lk6Gd+Njm7fdKMS0GELMqwlnp4IeQabGcSgkIN6IKdKmbfVTwL6aGRakK0aDHeKLxseqVsX1m3J
 zF2blB8y12cBhTelFiI+KiZy+D8Q=
X-Google-Smtp-Source: AGHT+IHxokdYq6XVPSQCWCZ8dPj31mYc00a0pgn4oUodIQRuAjHOJHArC+8ZKHEoJE1Ff63jnatsiOtaq3h1VXTvucM=
X-Received: by 2002:a05:6102:3ecc:b0:47b:f690:c8fc with SMTP id
 ada2fe7eead31-48077dcba4amr9753491137.11.1715596302845; Mon, 13 May 2024
 03:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240429073656.2486732-1-christoph.muellner@vrull.eu>
In-Reply-To: <20240429073656.2486732-1-christoph.muellner@vrull.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 May 2024 20:31:16 +1000
Message-ID: <CAKmqyKMgTY7vUSOVg0L_UPvXV4KdmyD0mjspXDgF4UKVqRTFNg@mail.gmail.com>
Subject: Re: [PATCH v5] riscv: thead: Add th.sxstatus CSR emulation
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cooper Qu <cooper.qu@linux.alibaba.com>, 
 Zhiwei Liu <zhiwei_liu@linux.alibaba.com>,
 Huang Tao <eric.huang@linux.alibaba.com>, 
 Conor Dooley <conor@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Vivian Wang <uwu@dram.page>, 
 Qingfang Deng <dqfext@gmail.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 LIU Zhiwei <zhiwe_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Mon, Apr 29, 2024 at 5:37=E2=80=AFPM Christoph M=C3=BCllner
<christoph.muellner@vrull.eu> wrote:
>
> The th.sxstatus CSR can be used to identify available custom extension
> on T-Head CPUs. The CSR is documented here:
>   https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheads=
xstatus.adoc
>
> An important property of this patch is, that the th.sxstatus MAEE field
> is not set (indicating that XTheadMae is not available).
> XTheadMae is a memory attribute extension (similar to Svpbmt) which is
> implemented in many T-Head CPUs (C906, C910, etc.) and utilizes bits
> in PTEs that are marked as reserved. QEMU maintainers prefer to not
> implement XTheadMae, so we need give kernels a mechanism to identify
> if XTheadMae is available in a system or not. And this patch introduces
> this mechanism in QEMU in a way that's compatible with real HW
> (i.e., probing the th.sxstatus.MAEE bit).
>
> Further context can be found on the list:
> https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00775.html
>
> Reviewed-by: LIU Zhiwei <zhiwe_liu@linux.alibaba.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  MAINTAINERS              |  1 +
>  target/riscv/cpu.c       |  1 +
>  target/riscv/cpu.h       |  3 ++
>  target/riscv/meson.build |  1 +
>  target/riscv/th_csr.c    | 79 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 85 insertions(+)
>  create mode 100644 target/riscv/th_csr.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 302b6fd00c..628e2b3141 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -342,6 +342,7 @@ L: qemu-riscv@nongnu.org
>  S: Supported
>  F: target/riscv/insn_trans/trans_xthead.c.inc
>  F: target/riscv/xthead*.decode
> +F: target/riscv/th_*
>  F: disas/riscv-xthead*
>
>  RISC-V XVentanaCondOps extension
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index eb1a2e7d6d..70d30a2c00 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -545,6 +545,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
>      cpu->cfg.mvendorid =3D THEAD_VENDOR_ID;
>  #ifndef CONFIG_USER_ONLY
>      set_satp_mode_max_supported(cpu, VM_1_10_SV39);
> +    th_register_custom_csrs(cpu);
>  #endif
>
>      /* inherited from parent obj via riscv_cpu_init() */
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 2d0c02c35b..8dd6175e20 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -822,4 +822,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUStat=
e *cs);
>  uint8_t satp_mode_max_from_map(uint32_t map);
>  const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
>
> +/* Implemented in th_csr.c */
> +void th_register_custom_csrs(RISCVCPU *cpu);
> +
>  #endif /* RISCV_CPU_H */
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index a5e0734e7f..a4bd61e52a 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -33,6 +33,7 @@ riscv_system_ss.add(files(
>    'monitor.c',
>    'machine.c',
>    'pmu.c',
> +  'th_csr.c',
>    'time_helper.c',
>    'riscv-qmp-cmds.c',
>  ))
> diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
> new file mode 100644
> index 0000000000..6c970d4e81
> --- /dev/null
> +++ b/target/riscv/th_csr.c
> @@ -0,0 +1,79 @@
> +/*
> + * T-Head-specific CSRs.
> + *
> + * Copyright (c) 2024 VRULL GmbH
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
> +#define CSR_TH_SXSTATUS 0x5c0
> +
> +/* TH_SXSTATUS bits */
> +#define TH_SXSTATUS_UCME        BIT(16)
> +#define TH_SXSTATUS_MAEE        BIT(21)
> +#define TH_SXSTATUS_THEADISAEE  BIT(22)
> +
> +typedef struct {
> +    int csrno;
> +    int (*insertion_test)(RISCVCPU *cpu);
> +    riscv_csr_operations csr_ops;
> +} riscv_csr;
> +
> +static RISCVException smode(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_has_ext(env, RVS)) {
> +        return RISCV_EXCP_NONE;
> +    }
> +
> +    return RISCV_EXCP_ILLEGAL_INST;
> +}
> +
> +static int test_thead_mvendorid(RISCVCPU *cpu)
> +{
> +    if (cpu->cfg.mvendorid !=3D THEAD_VENDOR_ID) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
> +                                       target_ulong *val)
> +{
> +    /* We don't set MAEE here, because QEMU does not implement MAEE. */
> +    *val =3D TH_SXSTATUS_UCME | TH_SXSTATUS_THEADISAEE;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static riscv_csr th_csr_list[] =3D {
> +    {
> +        .csrno =3D CSR_TH_SXSTATUS,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.sxstatus", smode, read_th_sxstatus }
> +    }
> +};
> +
> +void th_register_custom_csrs(RISCVCPU *cpu)
> +{
> +    for (size_t i =3D 0; i < ARRAY_SIZE(th_csr_list); i++) {
> +        int csrno =3D th_csr_list[i].csrno;
> +        riscv_csr_operations *csr_ops =3D &th_csr_list[i].csr_ops;
> +        if (!th_csr_list[i].insertion_test(cpu)) {
> +            riscv_set_csr_ops(csrno, csr_ops);
> +        }
> +    }
> +}
> --
> 2.44.0
>
>

