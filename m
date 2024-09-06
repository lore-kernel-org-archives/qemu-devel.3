Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7596CE7AAE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 03:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smPzP-00005L-DL; Thu, 05 Sep 2024 23:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smPzK-0008Tc-Dx; Thu, 05 Sep 2024 23:50:23 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smPzI-0008UB-96; Thu, 05 Sep 2024 23:50:22 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-49bc13c3a47so631909137.3; 
 Thu, 05 Sep 2024 20:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725594618; x=1726199418; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oR5cKyMepejgGxA1gcCjJbiA+gpjBXhWwD3ZQNqOKYI=;
 b=EF33//PYen0tbSh9J3kS7hObmpyw5hzfRRZUS2KPo0gzpkUi+c3NGWSJWH2S7q4nh/
 iioo2CZbgtK+TYk0q5zp/e+BhSPQTZOwbvRuNnRUZTCtR6mbb0yG3kOtcESi89mr1VK0
 3TLy7tLh2t/KVuab5y0b4MH71tyZwJfoos73onVpTdwgFKJlwD4+zYzi8xoLhZilhqSM
 hNCBB6HveMQ4564ZcxcpH6qjfWeiOUU7OB8ElimUexEyWo3D0Il9Cff335gX5Z8PhWEt
 TyZz96UoJauTl+UkTfZMZuGa0xjxmhRo2HL715Yx5Z+xH66VptB/Sd44oPXgpNESFmZ2
 yCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725594618; x=1726199418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oR5cKyMepejgGxA1gcCjJbiA+gpjBXhWwD3ZQNqOKYI=;
 b=iD3XjP2c4a+T6VKIl/ZXRhaYPE9ZhmLiirmWtkoKB3KS9hC9QOXs/hly9ZVR+MGpuv
 QERWWtnvSujw5N9j2aX6Q1yPeKtpCCrfANkQ/1zvmFQP4jef2o/A/XCn+ysKNZOFMgP6
 jqWzkwhCLGlLiEp2X9bfmIO99BFOU+tfBY2m4tzJHR3WIuI+1MuQxySHUVVwgeeJsjhk
 Qq377ChPF1GExFNNIt2Mtl7J7tzFf4Q0aEywrwWViadO7/eLnItU7/YOOYJcWaBjBdMV
 aWH/W8Y0UKnZLkXw2q6O2f+wGjLdqz9Dg8pWYaZgAv/JHkO430kki8VgA6ex8Jq2QZRm
 EXYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9S3oCj11gHxkgJGb2lDyZMzfhBF1ORoGhJet754J8DhkVBuGCkMBIXsV/2aVSVPbzhL7CcHQyMeuz@nongnu.org
X-Gm-Message-State: AOJu0YwzOZC6XYtNeRRiANqtIIZoShg2w769L61V4YtnhtXXmP3L/auw
 Jhm8FfUjNZdGQwb1GE9murgfPs1JPQ+VcRtW2IHNanidzsF/sh31XQFhFTfWogpYVsMqEH6XOxh
 VuMz7QO3Bj3JhJ5DqDwkpPsL+lt8=
X-Google-Smtp-Source: AGHT+IExKpjXRt9iApk5GWemc5ZSgM/lmQOvbp2G+95vVUu0LGn1eCW4zzZmJlbTMp9QzNKs2Q9zhTISBVfPIr/BqT0=
X-Received: by 2002:a05:6102:3750:b0:493:d325:4d71 with SMTP id
 ada2fe7eead31-49bde195c4emr1562626137.9.1725594618585; Thu, 05 Sep 2024
 20:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
 <20240819160742.27586-12-Ian.Brockbank@cirrus.com>
In-Reply-To: <20240819160742.27586-12-Ian.Brockbank@cirrus.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 13:49:52 +1000
Message-ID: <CAKmqyKNQaPbOtrhQCx+fAnzZzjSyHn=RC9KLJu4rj4kAsp857g@mail.gmail.com>
Subject: Re: [PATCH 08/11 v2] target/riscv: Update interrupt handling in CLIC
 mode
To: Ian Brockbank <Ian.Brockbank@cirrus.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
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

On Tue, Aug 20, 2024 at 2:14=E2=80=AFAM Ian Brockbank <Ian.Brockbank@cirrus=
.com> wrote:
>
> From: Ian Brockbank <ian.brockbank@cirrus.com>
>
> Decode CLIC interrupt information from exccode, includes interrupt
> privilege mode, interrupt level, and irq number.
>
> Then update CSRs xcause, xstatus, xepc, xintstatus and jump to
> correct PC according to the CLIC specification.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Signed-off-by: Ian Brockbank <ian.brockbank@cirrus.com>
> ---
>  target/riscv/cpu_helper.c | 129 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 119 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 395a1d9140..944afb68d2 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -24,6 +24,7 @@
>  #include "internals.h"
>  #include "pmu.h"
>  #include "exec/exec-all.h"
> +#include "exec/cpu_ldst.h"
>  #include "exec/page-protection.h"
>  #include "instmap.h"
>  #include "tcg/tcg-op.h"
> @@ -33,6 +34,7 @@
>  #include "cpu_bits.h"
>  #include "debug.h"
>  #include "tcg/oversized-guest.h"
> +#include "hw/intc/riscv_clic.h"
>
>  int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
>  {
> @@ -428,6 +430,20 @@ int riscv_cpu_vsirq_pending(CPURISCVState *env)
>                                      (irqs | irqs_f_vs), env->hviprio);
>  }
>
> +static int riscv_cpu_local_irq_mode_enabled(CPURISCVState *env, int mode=
)
> +{
> +    switch (mode) {
> +    case PRV_M:
> +        return env->priv < PRV_M ||
> +            (env->priv =3D=3D PRV_M && get_field(env->mstatus, MSTATUS_M=
IE));
> +    case PRV_S:
> +        return env->priv < PRV_S ||
> +            (env->priv =3D=3D PRV_S && get_field(env->mstatus, MSTATUS_S=
IE));
> +    default:
> +        return false;
> +    }
> +}
> +
>  static int riscv_cpu_local_irq_pending(CPURISCVState *env)
>  {
>      uint64_t irqs, pending, mie, hsie, vsie, irqs_f, irqs_f_vs;
> @@ -506,6 +522,18 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int inte=
rrupt_request)
>              return true;
>          }
>      }
> +    if (interrupt_request & CPU_INTERRUPT_CLIC) {
> +        RISCVCPU *cpu =3D RISCV_CPU(cs);
> +        CPURISCVState *env =3D &cpu->env;
> +        int mode =3D get_field(env->exccode, RISCV_EXCP_CLIC_MODE);
> +        int enabled =3D riscv_cpu_local_irq_mode_enabled(env, mode);
> +        if (enabled) {
> +            cs->exception_index =3D RISCV_EXCP_CLIC | env->exccode;
> +            cs->interrupt_request =3D cs->interrupt_request & ~CPU_INTER=
RUPT_CLIC;
> +            riscv_cpu_do_interrupt(cs);
> +            return true;
> +        }
> +    }
>      return false;
>  }
>
> @@ -1641,6 +1669,60 @@ static target_ulong riscv_transformed_insn(CPURISC=
VState *env,
>      return xinsn;
>  }
>
> +static target_ulong riscv_intr_pc(CPURISCVState *env, target_ulong tvec,
> +                                  target_ulong tvt, bool async,
> +                                  int cause, int mode)
> +{
> +    int mode1 =3D tvec & XTVEC_MODE;
> +    int mode2 =3D tvec & XTVEC_FULL_MODE;
> +

This is going to need extension checks

> +    if (!async) {
> +        return tvec & XTVEC_OBASE;
> +    }
> +    /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D rese=
rved */
> +    switch (mode1) {
> +    case XTVEC_CLINT_DIRECT:
> +        return tvec & XTVEC_OBASE;
> +    case XTVEC_CLINT_VECTORED:
> +        return (tvec & XTVEC_OBASE) + cause * 4;
> +    default:
> +        if (env->clic && (mode2 =3D=3D XTVEC_CLIC)) {
> +            /* Non-vectored, clicintattr[i].shv =3D 0 || cliccfg.nvbits =
=3D 0 */
> +            if (!riscv_clic_shv_interrupt(env->clic, cause)) {
> +                /* NBASE =3D mtvec[XLEN-1:6]<<6 */
> +                return tvec & XTVEC_NBASE;
> +            } else {
> +                /*
> +                 * pc :=3D M[TBASE + XLEN/8 * exccode)] & ~1,
> +                 * TBASE =3D mtvt[XLEN-1:6]<<6
> +                 */
> +                int size =3D TARGET_LONG_BITS / 8;
> +                target_ulong tbase =3D (tvt & XTVEC_NBASE) + size * caus=
e;
> +                void *host =3D tlb_vaddr_to_host(env, tbase, MMU_DATA_LO=
AD, mode);

This doesn't look right.

I think you want cpu_ l*_mmuidx_ra(). That will raise an exception on
an access failure

> +                if (host !=3D NULL) {
> +                    target_ulong new_pc =3D tbase;
> +                    if (!riscv_clic_use_jump_table(env->clic)) {
> +                        /*
> +                         * Standard CLIC: the vector entry is a function=
 pointer
> +                         * so look up the destination.
> +                         */
> +                        new_pc =3D ldn_p(host, size);
> +                        host =3D tlb_vaddr_to_host(env, new_pc,
> +                                                 MMU_INST_FETCH, mode);

At xtvt is the base address of a table of pointers, you also then want
to call cpu_ l*_mmuidx_ra() a second time and that value should be
returned as the next PC

> +                    }
> +                    if (host) {
> +                        return new_pc;
> +                    }
> +                }
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "CLIC: load trap handler error!\n");
> +                exit(1);

Don't allow the guest to exit. Print a guest error and keep going

Alistair

