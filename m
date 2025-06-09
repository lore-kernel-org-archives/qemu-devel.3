Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154C3C61CE7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 02:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOSRt-0008Dq-Qc; Sun, 08 Jun 2025 22:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOSRl-0008Cw-RJ; Sun, 08 Jun 2025 22:41:13 -0400
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOSRh-0007hS-GJ; Sun, 08 Jun 2025 22:41:13 -0400
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-4e58ef9cb69so1261223137.1; 
 Sun, 08 Jun 2025 19:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749436867; x=1750041667; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1OAmoIBeQt1beIm8NqWnTd4MoCE3cfG6p0SnvkXa1w=;
 b=YDT+GUTMWeR5+nPFag6jY4yOmaQDOHkXaXxedaQt0OKga4DfGDH4+NfCAy0ed6idti
 dKRakk21nTFSRyJrj0pYMI2tRinEGVabSisiQxu1buTSH1ln0LgcyL73KNm/n1bMavYA
 1uczPiLWiobPysHCn0o17/JK/OmVyR0bPZ8GVwVu49guQJqRy4jTQivXgGwhi2kTwqIl
 x4Vj663W311sYtdRGy1/tgUUFJ4ALUUyAe4MPRxlI8EiwTfTuDQv8+4YensRwi9FC5G1
 NvOYPpfGSbQIM5UxsBcGpCsWxkEkR9luPn/xdqfsu1EUHx3twJYfZ8vl1OY6bVN4/5xo
 uyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749436867; x=1750041667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1OAmoIBeQt1beIm8NqWnTd4MoCE3cfG6p0SnvkXa1w=;
 b=E3QIhN9uh+bccLfnx4KvLvBj1z0azdASlcqZTJEoWai7UptXj0B9y77DAGf0S25VFY
 GShj5PN//ss46wo1dsXNb3aGOrOVudZ7TXtwjxDHJ+qsBXAfHrcnU2OUvpl7gr0jTM32
 wfCcE+/i8cdED0/RCh5bEouztOn88DfRIDZGhofScFFX/QZ+fF4duFtfCd/9kWQDP5RW
 306ILemmwC1I7gHqFya8PdiPzdie0d73Pnf/LwMKwLkGlews0sti5d0+VG7rXwLe2LwV
 /KBGAk7mHUgta3mCmvlyQGaW3S5tuRKBcl+Be4cB3OtbO643Cqk0R5yaB6LXWY9qiPc+
 x/hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZpL7v0lKzCpNSyx/f1UVi7Wl/cCreQ8lgdZ9O5G0E3twAd3zI77UmCdkZ/UGeWjO6Nh/Zr1xQu+6n@nongnu.org
X-Gm-Message-State: AOJu0YxSlvnSoXn4hUyV83mkKaaSYKrJ4CHxaf7TG4l7SKcf1Tem5ElJ
 b0IlrXE8GADsOKeKYwoKpvXk0tmAbZa7qxw0tY5U9AceOlSPYud2eqqh0fUzH6tAzbS4MKJTGt9
 4iHJLhMK0PZ1ddR6qV5IVeJmstndOExI=
X-Gm-Gg: ASbGncs7ItNTcbmuzRXleIUgrabIpp+ZgmSZC3hvbultU7FLdtrBuEqkb0QmHlu9hOG
 MaPxsXg2yhH3r50wK3bLo5Pu6/V5XWCEOvFgjJ7azoxbvMPvIyf6M4cfTKE9+UX1KwsX1+meNTI
 zJfLWP0Yv7xmNRAmmOamNQ9ksCsy+eOCC7jsXCEJYGwEf7gfw8o4j84T5Awsrtwn0=
X-Google-Smtp-Source: AGHT+IGniwp22K6A8fLDM5PnG6hMmjzD/roBwofuitFOj3S3AcqM8pdttgvL4Shw/9zTWTWZ5AlDPFgbGuYNfI+zr1I=
X-Received: by 2002:a05:6102:160c:b0:4da:fc9d:f0c with SMTP id
 ada2fe7eead31-4e7728f526amr9050209137.12.1749436866786; Sun, 08 Jun 2025
 19:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250606034250.181707-1-mengzhuo@iscas.ac.cn>
In-Reply-To: <20250606034250.181707-1-mengzhuo@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Jun 2025 12:40:39 +1000
X-Gm-Features: AX0GCFuAraLCS4JmnLOpkHoJ3ZbQad-gdBZ-hNctQy2TfWtqBnvYqFn7_M2_5eU
Message-ID: <CAKmqyKOxXVQ7WGudSAbwn5jUaGObw4FnLSELTQMGLJhetxB=VQ@mail.gmail.com>
Subject: Re: [PATCH v6] target/riscv/kvm: add max_satp_mode from host cpu
To: Meng Zhuo <mengzhuo@iscas.ac.cn>
Cc: qemu-devel@nongnu.org, Andrew Jones <ajones@ventanamicro.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2e.google.com
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

On Fri, Jun 6, 2025 at 1:45=E2=80=AFPM Meng Zhuo <mengzhuo@iscas.ac.cn> wro=
te:
>
> This patch adds max_satp_mode from host kvm cpu setting.
>
> Tested on: Milkv Megrez (Eswin 7700x)
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2931
> Signed-off-by: Meng Zhuo <mengzhuo@iscas.ac.cn>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Change in v6:
> - Rebase on https://github.com/alistair23/qemu/tree/riscv-to-apply.next
> - Minor change in title
>
> Change in v5:
> - Adds R-B comment from Andrew Jones
>
> Change in v4:
> - Adds changelog in commit message
> - Link to v3: https://lists.nongnu.org/archive/html/qemu-devel/2025-05/ms=
g04629.html
>
> Change in v3:
> - Rebase on https://github.com/alistair23/qemu/tree/riscv-to-apply.next
>   as requested
> - Link to v2: https://lists.nongnu.org/archive/html/qemu-devel/2025-04/ms=
g05203.html
>
> Changes in v2:
> - use set_satp_mode_max_supported instead of hard code
> - Link to v1: https://lists.nongnu.org/archive/html/qemu-devel/2025-04/ms=
g05094.html
> ---
>  target/riscv/kvm/kvm-cpu.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index e1a04be20f..502d33f404 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -999,6 +999,19 @@ static void kvm_riscv_destroy_scratch_vcpu(KVMScratc=
hCPU *scratch)
>      close(scratch->kvmfd);
>  }
>
> +static void kvm_riscv_init_max_satp_mode(RISCVCPU *cpu, KVMScratchCPU *k=
vmcpu)
> +{
> +    struct kvm_one_reg reg;
> +    int ret;
> +
> +    reg.id =3D RISCV_CONFIG_REG(satp_mode);
> +    reg.addr =3D (uint64_t)&cpu->cfg.max_satp_mode;
> +    ret =3D ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
> +    if (ret !=3D 0) {
> +        error_report("Unable to retrieve satp mode from host, error %d",=
 ret);
> +    }
> +}
> +
>  static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvm=
cpu)
>  {
>      struct kvm_one_reg reg;
> @@ -1302,6 +1315,7 @@ static void riscv_init_kvm_registers(Object *cpu_ob=
j)
>      kvm_riscv_init_machine_ids(cpu, &kvmcpu);
>      kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
>      kvm_riscv_init_cfg(cpu, &kvmcpu);
> +    kvm_riscv_init_max_satp_mode(cpu, &kvmcpu);
>
>      kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
>  }
> @@ -1985,7 +1999,7 @@ static bool kvm_cpu_realize(CPUState *cs, Error **e=
rrp)
>          }
>      }
>
> -   return true;
> +    return true;
>  }
>
>  void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
> --
> 2.39.5
>
>

