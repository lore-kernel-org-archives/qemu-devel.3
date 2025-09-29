Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13B7CAC5BB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 01:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v330Y-0002Bn-KN; Sun, 28 Sep 2025 21:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v330X-0002Bd-7a
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 21:48:53 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v330M-0000Jt-8v
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 21:48:51 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-afcb7322da8so795591266b.0
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 18:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759110515; x=1759715315; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ooEfhCxXgV0dD6pArfFh87L+8XTqLsd12HTfn0ojuY=;
 b=ZLs0zlFrANOvbMAR6zYOy/i+oxLC+q02x9A31uVmacKwgmV9GZX96B5plge3W1WeBy
 coI6KnwWbv5zSl6JMQkwtcykX49eOTrnnKIol3BxIr5POCSNnEEvxsLIkGaDuDYZF1W7
 NONWP/+BjgxcdGvidDRwmSLEfLjO970eG3aUXa+ei6/aEKWf5FVJcQOYES3vzY6MunvE
 P8y5nDXZTvjkgPtWbtuznNhEFSQ8sfZuLB0nk6BN6eFE3lp9GiPdvZd1q6v7T1TYnsBx
 U8gfCJsQs0zbyqgwVwX9XJ3gJxxVsNhysQhcwQUQDRTrUYpWXT9arSrDCovjAzWx3SpI
 UM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759110515; x=1759715315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ooEfhCxXgV0dD6pArfFh87L+8XTqLsd12HTfn0ojuY=;
 b=L/Ctsntl4pIDwbQj0XojXkUcwP8tN5bdlKcfDgv/xg6gF4877g88VzOMAxqK21wEPV
 V4S88T1+AQLMnaNzddz4rc1uLbLHrQeP/Lv9/qbgfyRf/G7y84kZ3rrItmxcte94lGSI
 oh62EJ2NroHUKyG27/SBpRxYvTY9GVC7JkrL2CkLOUYhnsgveWgQ2YykRChFRFOgklO5
 P1YXGXNYD1v4IKrBPMPLfgrtn572rJZkPKs+wOiftbifE7v0PbKKMGgyVnauHOuwzADR
 cAADzamEtd8w1X5pFRNPms6/qxJ1mfU8G2edRE8cgStdu9Ck0oasg1IVwwXuSzFTY7Q1
 MItg==
X-Gm-Message-State: AOJu0YzoxOsILhM0H51Fzk/6Xo/QcvWZAqoaDtVQTF26QRiRHcglLKpk
 2KBBSHTeL3QIHxRT33hgcCROBsMHkGqAl0W9YHu5roV389LtrAbJ3SOLqhQRgayVJzhrb4i2ZRa
 NR2z42fs/HDrEF5NCR78+vrlIi5QPA0M=
X-Gm-Gg: ASbGncsgGXarj7iha367praGB6yRiQaXaXVf0pZjGmKOLdWzI6YeFjJ3MHcbghC4mau
 AEElZW2vaEzuPoxlKlK9MYqTWXS1VWmnX1XAbQrBFql5vkWDHLs7bHBDkSOw3byRw/StwpYSpRa
 wHaasBbFC5H7nSrqwEe/z7VN0cx30JHeDMuoXeuxaI2TFYNDSh6Q9CDbRiF/xtQRgd7IbcJk9C0
 t8i45eLOwh09VAfEcZc/slYp72cUFY3SQDf7vLkUiQf/Mnt
X-Google-Smtp-Source: AGHT+IEtmMyPSpRuLF0q/8CS3S5potyVgAxymogrhBLEmTiUQ5/iH9bgUyuMM2gmGEXLRmOTyuBWSndts2ZzNRXjgkM=
X-Received: by 2002:a17:907:9805:b0:b33:a2ef:c7 with SMTP id
 a640c23a62f3a-b34beba93f8mr1674930966b.55.1759110515185; Sun, 28 Sep 2025
 18:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250915070811.3422578-1-xb@ultrarisc.com>
 <20250915070811.3422578-2-xb@ultrarisc.com>
In-Reply-To: <20250915070811.3422578-2-xb@ultrarisc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 11:48:08 +1000
X-Gm-Features: AS18NWDMhbRXlp4v_lxZgzQJhgqYmLlE6qOHGFDZi2JvWuuuXoWfbXpYI-773Mg
Message-ID: <CAKmqyKMMo0XfaEsTYqpsV8UfXkhM5YHZsCdptFVR5pSYM1KRxQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] Set KVM initial privilege mode and mp_state
To: Xie Bo <xb@ultrarisc.com>
Cc: qemu-devel@nongnu.org, ajones@ventanamicro.com, qemu-riscv@nongnu.org, 
 pbonzini@redhat.com, anup@brainfault.org, alistair.francis@wdc.com, 
 rkrcmar@ventanamicro.com, palmer@dabbelt.com, xiamy@ultrarisc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 15, 2025 at 5:08=E2=80=AFPM Xie Bo <xb@ultrarisc.com> wrote:
>
> For KVM mode, the privilege mode should not include M-mode, and the
> initial value should be set to S-mode. Additionally, a following patch
> adds the implementation of putting the vCPU privilege mode to KVM.
> When the vCPU runs for the first time, QEMU will first put the privilege
> state to KVM. If the initial value is set to M-mode, KVM will encounter
> an error.
>
> In addition, this patch introduces the 'mp_state' field to RISC-V
> vCPUs, following the convention used by KVM on x86. The 'mp_state'
> reflects the multiprocessor state of a vCPU, and is used to control
> whether the vCPU is runnable by KVM. Randomly select one CPU as the
> boot CPU. Since each CPU executes the riscv_cpu_reset_hold() function
> and CPU0 executes first, only CPU0 randomly selects the boot CPU.
>
> Signed-off-by: Xie Bo <xb@ultrarisc.com>
> ---
>  target/riscv/cpu.c | 17 ++++++++++++++++-
>  target/riscv/cpu.h |  2 ++
>  2 files changed, 18 insertions(+), 1 deletion(-)

This fails to build with the following error, it seems an include is missin=
g

../target/riscv/cpu.c: In function =E2=80=98riscv_cpu_reset_hold=E2=80=99:
../target/riscv/cpu.c:711:25: error: =E2=80=98KVM_MP_STATE_RUNNABLE=E2=80=
=99
undeclared (first use in this function)
 711 |         env->mp_state =3D KVM_MP_STATE_RUNNABLE;
     |                         ^~~~~~~~~~~~~~~~~~~~~
../target/riscv/cpu.c:711:25: note: each undeclared identifier is
reported only once for each function it appears in
../target/riscv/cpu.c:713:25: error: =E2=80=98KVM_MP_STATE_STOPPED=E2=80=99=
 undeclared
(first use in this function); did you mean =E2=80=98S390_CPU_STATE_STOPPED=
=E2=80=99?
 713 |         env->mp_state =3D KVM_MP_STATE_STOPPED;
     |                         ^~~~~~~~~~~~~~~~~~~~
     |                         S390_CPU_STATE_STO

Alistair

>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d055ddf462..55892a2fc7 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -37,6 +37,7 @@
>  #include "kvm/kvm_riscv.h"
>  #include "tcg/tcg-cpu.h"
>  #include "tcg/tcg.h"
> +#include "hw/boards.h"
>
>  /* RISC-V CPU definitions */
>  static const char riscv_single_letter_exts[] =3D "IEMAFDQCBPVH";
> @@ -685,18 +686,32 @@ static void riscv_cpu_reset_hold(Object *obj, Reset=
Type type)
>  #ifndef CONFIG_USER_ONLY
>      uint8_t iprio;
>      int i, irq, rdzero;
> +    static int boot_cpu_index;
>  #endif
>      CPUState *cs =3D CPU(obj);
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
>      RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(obj);
>      CPURISCVState *env =3D &cpu->env;
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
>
>      if (mcc->parent_phases.hold) {
>          mcc->parent_phases.hold(obj, type);
>      }
>  #ifndef CONFIG_USER_ONLY
>      env->misa_mxl =3D mcc->def->misa_mxl_max;
> -    env->priv =3D PRV_M;
> +    if (kvm_enabled()) {
> +        env->priv =3D PRV_S;
> +    } else {
> +        env->priv =3D PRV_M;
> +    }
> +    if (cs->cpu_index =3D=3D 0) {
> +        boot_cpu_index =3D g_random_int_range(0, ms->smp.cpus);
> +    }
> +    if (cs->cpu_index =3D=3D boot_cpu_index) {
> +        env->mp_state =3D KVM_MP_STATE_RUNNABLE;
> +    } else {
> +        env->mp_state =3D KVM_MP_STATE_STOPPED;
> +    }
>      env->mstatus &=3D ~(MSTATUS_MIE | MSTATUS_MPRV);
>      if (env->misa_mxl > MXL_RV32) {
>          /*
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 738e68fa6e..7ea4859de7 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -269,6 +269,8 @@ struct CPUArchState {
>  #endif
>
>      target_ulong priv;
> +    /* Current multiprocessor state of this vCPU. */
> +    uint32_t mp_state;
>      /* CSRs for execution environment configuration */
>      uint64_t menvcfg;
>      target_ulong senvcfg;
> --
> 2.43.0
>

