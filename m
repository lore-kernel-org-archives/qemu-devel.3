Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70959C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Hi1-0006qz-9w; Sun, 28 Apr 2024 23:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1Hhy-0006q8-JD; Sun, 28 Apr 2024 23:29:38 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1Hhw-0004cb-M8; Sun, 28 Apr 2024 23:29:38 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-4dae34a3806so2593143e0c.1; 
 Sun, 28 Apr 2024 20:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714361374; x=1714966174; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zC4dpXeOZXr1FP8jNRrXXUIJJ0oHzs08YDXzRiSnI4=;
 b=Hr3xx9ibfNR3j7iXNRiYuoqyRXhf6VjKn+MtClnhw8OgEPAGR4WnjLjk8NP7lDoDE8
 H/dYjW+0+buKQb2HgskVdBSlg3ORBPa4xYlKPbhnfhXbUnOLk4+mfCVdpbMlM4K7x8wE
 XN/FpQguM4e/z4WK5XPiGkzRm8Lheis0uxmPeQ+L7b+v4AYNkHTQdMRt+kf1po4oHcMA
 NV56Xs+V0rDkht1vNxK063DY6vdZ3eUhb8H5kCUmTmR9LK/781VpfsMdrYqCw4RkLnpJ
 AxrFluzq/dynp8Hr5g/pq3Krlnu5L2wXQrh51JJANbPP42JQF0nlM/PIAqhEo0bOHGyw
 IJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361374; x=1714966174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9zC4dpXeOZXr1FP8jNRrXXUIJJ0oHzs08YDXzRiSnI4=;
 b=AJqeNcIgCuURwYARm1Vl6w6aBveZeJcl6dfQjdPoBWOh2oCSKYJtmBkosvm8qRJcI2
 qKEhCaiMhLhbk+XIUVkV61CAtUnDy0aJnsYoR2EqL7NqT/nzPrd/iWP6zOzIrmEc3qcb
 cEn03WJbjUPyPWFATunzv8xIom/MynPCvkB+G3IbtbHmQoO/RFF7xGOT+R++C3URe4QX
 muVe3UGe7qDn8XmabcUCJBLWZtn7+7yd22N6XWDvIwK2EUCsbJ9GaiWdhHuUVnnrNXi0
 bl14Hf+W7NvVSOrScIexiRkbuvLAVAVZ+2wmc5gE+xv9aHv6nY/c6ihMsrKcz/S4vf07
 kmBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5dFNbOKjWo0DBlXFgHtfeEeb6oFM61labHYohCY65to4iMrRGt2h92BOnhDJ47SYc6FNHTaLDdTClBEqpB9dmrUfzM+M=
X-Gm-Message-State: AOJu0Ywo/8Db4t0wUpUhApgMxjXR8woCk7fQyQq2fCgK6Vsf6CpkrfnU
 Y0JrIfimr59fTKLyU0UrcrAQ4NU7M2ZtMYaBB+GiM05acavS7iaHhLQOPeRjrCpV+Fj/cN6Ctja
 iIurq+/i6SRMU8BEUMUfbN32CTTw=
X-Google-Smtp-Source: AGHT+IHcfeGkig8/nTtr9zmswRT5JztjPsAmSfNElTFBlqKmDhgukWa2j9aH6GnMS967ptndf9k81V2jMh8WhER5xkE=
X-Received: by 2002:a05:6122:369e:b0:4da:ae51:b755 with SMTP id
 ec30-20020a056122369e00b004daae51b755mr10606659vkb.3.1714361373165; Sun, 28
 Apr 2024 20:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240422065208.1953562-1-christoph.muellner@vrull.eu>
In-Reply-To: <20240422065208.1953562-1-christoph.muellner@vrull.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 13:29:07 +1000
Message-ID: <CAKmqyKNM-WWtFsUf0vVDi94YD+mMM2AYHL_sT-PdHHeQc289-Q@mail.gmail.com>
Subject: Re: [PATCH v4] riscv: thead: Add th.sxstatus CSR emulation
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Mon, Apr 22, 2024 at 4:53=E2=80=AFPM Christoph M=C3=BCllner
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
> Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> ---
>  target/riscv/cpu.c       |  1 +
>  target/riscv/cpu.h       |  3 ++
>  target/riscv/meson.build |  1 +
>  target/riscv/th_csr.c    | 77 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 82 insertions(+)
>  create mode 100644 target/riscv/th_csr.c
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 36e3e5fdaf..b82ba95ae6 100644
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
> index 3b1a02b944..c9f8f06751 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -824,4 +824,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUStat=
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
> index 0000000000..0eb3ad64f1
> --- /dev/null
> +++ b/target/riscv/th_csr.c
> @@ -0,0 +1,77 @@
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
> +    if (cpu->cfg.mvendorid !=3D THEAD_VENDOR_ID)
> +        return -1;
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
> +        if (!th_csr_list[i].insertion_test(cpu))
> +            riscv_set_csr_ops(csrno, csr_ops);

Checkpatch error here with missing brackets and some other places above

Otherwise:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +    }
> +}
> --
> 2.44.0
>
>

