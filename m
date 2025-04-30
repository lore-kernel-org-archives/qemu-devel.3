Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E14C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 23:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAGeh-0000TI-8t; Wed, 30 Apr 2025 19:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAGef-0000SW-SI
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:15:53 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAGea-0008VG-1F
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:15:53 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-86d3907524cso108357241.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 16:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746054946; x=1746659746; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muxkVay0Vj5NQ8TpJr0ueRNhpljQhCzJIY89sbFU38Q=;
 b=d2tVtcRl7jaFmpZZKuBZdbHXHuqL/dexd2x6RtBWqkleh4Z740U9HT/A95T4TNRMa8
 0vgiTW5rTdulQ6YDA4Aeb4Yu+x/1EInCR7nENhE1wC/bNXSCYrXY/A0IcKvuqnuOs+EO
 sQ7IIKhiYgG8qq4w8CJ3uLq75iwhZUWi11S6dcNmP+JvVKIszl6Pb3XvukFWtIPeTcS0
 xccF35QngiLfGQqJII9GWvroKCkdMxNIHUdbc3mypLWDDI1QE9R3pOlYlgcl2G5VtB8r
 96NzmX1EO5oA21bLO74VSa5B8MrmGk9kAVG/umHiwFp8UAYVKxrf2jagF2EeYRHyHrfr
 Iwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746054946; x=1746659746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=muxkVay0Vj5NQ8TpJr0ueRNhpljQhCzJIY89sbFU38Q=;
 b=C1B9CG0RCnW5oNxGa+TrPJWPoTBc40EDahm6hhvsLJqsFqfiYaFDbtpBrpZz+fIHU4
 5KBGKeCkUzfytsAiAVXAQL2W31F6M/Ov9B9y1upzCIMmcazXF3Y2rFvh0f67dymvvl2W
 KkAodnFLyhLOnvqtsxlMBuEEkKyktJFm8eg3AmngiKQz/lTwWALsze/NZZfeYWC9DsX4
 orHQDxd9lD603Vo9Le75oSS2EWG7TMFRIFQ44VxDesZvKrLsUgppd8rIfGJc6jAZu5UR
 7U3xL13sHQ4zV40oQqYOCwV+M7KhD+/odJ+gnVTuCDUWjoDzRPo3K1UZ0GBLjZCTHgzl
 YYSQ==
X-Gm-Message-State: AOJu0YwQc/6U0mRNtCiP+ZLQ5QZ0CPD4Ik2THgwp6nsg/Zvu/RXv15KA
 tnogPNMWHFMXih7Yx2gN7C8eCQqCe4Gara0yY7dExtjD4f7soiEQtbujM1N/0Hh7544xNXQDJlh
 cAHeVe6q81AOPKoTiHRAUZFW0ieY=
X-Gm-Gg: ASbGncvjHH7w8L7w/oZHXLjLiJ+bitAj21kjrb/Ms1lbnDJU7TghZSXdwaERfLAWBrR
 pp64AWjJUoOf+YYIOk7JfHR0VDWcq3FxY1nceJtYivp+p63p4WB/Es1MqN8QzSpMjUSec77eBXp
 nhL9f4Yc7VVQSkBA7C1p4rHwu8xz8DVKxUk9x12OmAL6edkDs3AAyN
X-Google-Smtp-Source: AGHT+IEUtLMGNGVUx6yF7aekGx4W0EhqqIF7uXnS101eKKmfSDxpwAsqN3g3rB7/mcPxGGSUtLINK3So9uZdEA9JR2E=
X-Received: by 2002:a05:6102:2921:b0:4af:fca2:1b7 with SMTP id
 ada2fe7eead31-4dae9194e25mr179742137.14.1746054946286; Wed, 30 Apr 2025
 16:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250429124421.223883-1-dbarboza@ventanamicro.com>
 <20250429124421.223883-7-dbarboza@ventanamicro.com>
In-Reply-To: <20250429124421.223883-7-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 May 2025 09:15:19 +1000
X-Gm-Features: ATxdqUH5C83vX7SCWCF06HGaREtVxI1pY6aSkfYDxp6Ylv1IJVJ-DFVlmSDOEY4
Message-ID: <CAKmqyKOOGMSHEB5svoBZ0VTsq2C9-EdpvJ0BiUfgUh44S5H+Sg@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] target/riscv/kvm: do not read unavailable CSRs
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, ajones@ventanamicro.com, 
 Andrea Bolognani <abologna@redhat.com>
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

On Tue, Apr 29, 2025 at 10:45=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> [1] reports that commit 4db19d5b21 broke a KVM guest running kernel 6.6.
> This happens because the kernel does not know 'senvcfg', making it
> unable to boot because QEMU is reading/wriiting it without any checks.
>
> After converting the CSRs to do "automated" get/put reg procedures in
> the previous patch we can now scan for availability. Two functions are
> created:
>
> - kvm_riscv_read_csr_cfg_legacy() will check if the CSR exists by brute
>   forcing KVM_GET_ONE_REG in each one of them, interpreting an EINVAL
>   return as indication that the CSR isn't available. This will be use in
>   absence of KVM_GET_REG_LIST;
>
> - kvm_riscv_read_csr_cfg() will use the existing result of get_reg_list
>   to check if the CSRs ids are present.
>
> kvm_riscv_init_multiext_cfg() is now kvm_riscv_init_cfg() to reflect that
> the function is also dealing with CSRs.
>
> [1] https://lore.kernel.org/qemu-riscv/CABJz62OfUDHYkQ0T3rGHStQprf1c7_E0q=
BLbLKhfv=3D+jb0SYAw@mail.gmail.com/
>
> Fixes: 4db19d5b21 ("target/riscv/kvm: add missing KVM CSRs")
> Reported-by: Andrea Bolognani <abologna@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 62 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 59 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index f881e7eb5d..1ce747d047 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -636,6 +636,10 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
>      for (i =3D 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
>          KVMCPUConfig *csr_cfg =3D &kvm_csr_cfgs[i];
>
> +        if (!csr_cfg->supported) {
> +            continue;
> +        }
> +
>          ret =3D kvm_get_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
>          if (ret) {
>              return ret;
> @@ -662,6 +666,10 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
>      for (i =3D 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
>          KVMCPUConfig *csr_cfg =3D &kvm_csr_cfgs[i];
>
> +        if (!csr_cfg->supported) {
> +            continue;
> +        }
> +
>          if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) =3D=3D sizeof(uint32_t)) {
>              reg =3D kvm_cpu_csr_get_u32(cpu, csr_cfg);
>          } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) =3D=3D sizeof(uint6=
4_t)) {
> @@ -1090,6 +1098,32 @@ static void kvm_riscv_read_multiext_legacy(RISCVCP=
U *cpu,
>      }
>  }
>
> +static void kvm_riscv_read_csr_cfg_legacy(KVMScratchCPU *kvmcpu)
> +{
> +    uint64_t val;
> +    int i, ret;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
> +        KVMCPUConfig *csr_cfg =3D &kvm_csr_cfgs[i];
> +        struct kvm_one_reg reg;
> +
> +        reg.id =3D csr_cfg->kvm_reg_id;
> +        reg.addr =3D (uint64_t)&val;
> +        ret =3D ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
> +        if (ret !=3D 0) {
> +            if (errno =3D=3D EINVAL) {
> +                csr_cfg->supported =3D false;
> +            } else {
> +                error_report("Unable to read KVM CSR %s: %s",
> +                             csr_cfg->name, strerror(errno));
> +                exit(EXIT_FAILURE);
> +            }
> +        } else {
> +            csr_cfg->supported =3D true;
> +        }
> +    }
> +}
> +
>  static int uint64_cmp(const void *a, const void *b)
>  {
>      uint64_t val1 =3D *(const uint64_t *)a;
> @@ -1146,7 +1180,26 @@ static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KV=
MScratchCPU *kvmcpu,
>      }
>  }
>
> -static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kv=
mcpu)
> +static void kvm_riscv_read_csr_cfg(struct kvm_reg_list *reglist)
> +{
> +    struct kvm_reg_list *reg_search;
> +    uint64_t reg_id;
> +
> +    for (int i =3D 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
> +        KVMCPUConfig *csr_cfg =3D &kvm_csr_cfgs[i];
> +
> +        reg_id =3D csr_cfg->kvm_reg_id;
> +        reg_search =3D bsearch(&reg_id, reglist->reg, reglist->n,
> +                             sizeof(uint64_t), uint64_cmp);
> +        if (!reg_search) {
> +            continue;
> +        }
> +
> +        csr_cfg->supported =3D true;
> +    }
> +}
> +
> +static void kvm_riscv_init_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
>  {
>      g_autofree struct kvm_reg_list *reglist =3D NULL;
>      KVMCPUConfig *multi_ext_cfg;
> @@ -1163,7 +1216,9 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *c=
pu, KVMScratchCPU *kvmcpu)
>       * (EINVAL). Use read_legacy() in this case.
>       */
>      if (errno =3D=3D EINVAL) {
> -        return kvm_riscv_read_multiext_legacy(cpu, kvmcpu);
> +        kvm_riscv_read_multiext_legacy(cpu, kvmcpu);
> +        kvm_riscv_read_csr_cfg_legacy(kvmcpu);
> +        return;
>      } else if (errno !=3D E2BIG) {
>          /*
>           * E2BIG is an expected error message for the API since we
> @@ -1226,6 +1281,7 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *c=
pu, KVMScratchCPU *kvmcpu)
>      }
>
>      kvm_riscv_check_sbi_dbcn_support(cpu, reglist);
> +    kvm_riscv_read_csr_cfg(reglist);
>  }
>
>  static void riscv_init_kvm_registers(Object *cpu_obj)
> @@ -1239,7 +1295,7 @@ static void riscv_init_kvm_registers(Object *cpu_ob=
j)
>
>      kvm_riscv_init_machine_ids(cpu, &kvmcpu);
>      kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
> -    kvm_riscv_init_multiext_cfg(cpu, &kvmcpu);
> +    kvm_riscv_init_cfg(cpu, &kvmcpu);
>
>      kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
>  }
> --
> 2.49.0
>
>

