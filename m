Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18B7C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 11:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Mux-0004Zr-0t; Mon, 28 Apr 2025 07:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9Muv-0004ZG-7t; Mon, 28 Apr 2025 07:44:57 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9Mus-0000Dv-Q4; Mon, 28 Apr 2025 07:44:56 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-86715793b1fso1920903241.0; 
 Mon, 28 Apr 2025 04:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745840693; x=1746445493; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nMNAx0FIGNCynJv/U/EJMmNHcembZk6vk7eNGPV+Vw=;
 b=VxO5WlwABYFaWe3b8deCQ+GRng5LTP0vxyCOEWr7UY46b6CFARu1KkVC11hvyPemZT
 BjkA1a6F2mdC9SdpZdgv/55f6urTgqgzf4qM36A27kJSVNzPRpPQGlaIqQToE6f7acAS
 AOizITUddfPSxTupirL2ypCgvpAOkax9wZW0DRB4MWJ2/VgMs1KnBbrYzTAoVUU/zeea
 /pAxa18WVT4lZLcabgZPfdVcCr640y/ukVXTVJp+F7tspZ0tWHm2cqdTKBPeOTe8o4Vh
 jFTYb02R1ij3TriIk+AXUAKdGzlflSi5+8rUOvzEcN++Vdfts83wxaV1IXPxXovQSWxz
 +5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745840693; x=1746445493;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+nMNAx0FIGNCynJv/U/EJMmNHcembZk6vk7eNGPV+Vw=;
 b=KENcE60isjftwbfgZnN0MQHZXfKv/1bOBygptVIfAyvblT2UkqNcEThxZbOA7EtdFH
 10SLf1+iKjii5gwr21bo/9JelD7r+DWR5WK0UvYz7AeQi3ylJPRsAq4Jic1q6zggKvpu
 S02daC0EWl5iN0M+2gakV9mG2Rcszch7q7bVaqI1Q2ql3mhchfxAj7fVDQ7bddKxDACz
 zzM8f0g5vw7s9Wr49Xr8cE8rIMsnQqx/k/5w8P6ofkgYkNZwyNdVWo0kck8nkeIaFI/Q
 5dK69u1LDauMwPro9nIRhqTVQBvw1DNdFn09hSsJJBKznP/lANkKofoxdNyuY1fXClxI
 0QlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUUI0H+N9wn02/r/zJA2GGattLEFJFvT+5AsOQPFdaCTC27VlYRlteRwmLCChRRn5R8JIUk8jfCVZF@nongnu.org
X-Gm-Message-State: AOJu0YzPA8fom8Yv968jrjR2HfJFqcBUFvJaNMQlUfT3yVnWA/pSVZyT
 +DTBEEEe9ULYB2CxFiPpWlBDHyT0fGGf2RWIh0ypVpsDVEdTiiMgOJtOT2mPnFbJg4kXRmF8hOa
 vJd2xOSBhefUr3TGRyDVUdwiV8LI=
X-Gm-Gg: ASbGnct7+HnyriwPQIGq5SMw9IFJIK3WHykXnodNDDh3EuaPyaMTs71JznzcK36b9ru
 etWchKUL373XkfM4BBs8+kbPmmbB78lhuk9YIHTRDqZEbzThyOkXQ/37OZkLtSmA6/i9zFwrU4T
 aeS74sjbpIY7m9SLT/Lx9rEBs290HT0+5Gqm/LplaBJR/l7tGccVR+j46mMyXPt3A=
X-Google-Smtp-Source: AGHT+IFS4aeXaI+uTL4gowhyhMAm5FWd9tJX1LE2TiXZXDlWkAEw0Wz5/8AYyt2SK2LVolnE96SzgsseaKPMKFZlaBc=
X-Received: by 2002:a05:6102:3e08:b0:4c3:6393:8448 with SMTP id
 ada2fe7eead31-4d6400a6885mr4691186137.1.1745840692913; Mon, 28 Apr 2025
 04:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
 <20250425160203.2774835-6-dbarboza@ventanamicro.com>
In-Reply-To: <20250425160203.2774835-6-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 28 Apr 2025 21:44:25 +1000
X-Gm-Features: ATxdqUHe72AihwhlPmZf1dzRi4wNUyPt3MBoGXEtZ_Zx3sD5xXNjLWcJPKK3Lk8
Message-ID: <CAKmqyKNKGiTOp1WhPo_8f6AOwTacJPMQNwZE8f-unJ3VvD8e8w@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] target/riscv/kvm: add kvm_csr_cfgs[]
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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

On Sat, Apr 26, 2025 at 2:04=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> At this moment we're not checking if the host has support for any
> specific CSR before doing get/put regs. This will cause problems if the
> host KVM doesn't support it (see [1] as an example).
>
> We'll use the same approach done with the CPU extensions: read all known
> KVM CSRs during init() to check for availability, then read/write them
> if they are present. This will be made by either using get-reglist or by
> directly reading the CSRs.
>
> For now we'll just convert the CSRs to use a kvm_csr_cfg[] array,
> reusing the same KVMCPUConfig abstraction we use for extensions, and use
> the array in (get|put)_csr_regs() instead of manually listing them. A
> lot of boilerplate will be added but at least we'll automate the get/put
> procedure for CSRs, i.e. adding a new CSR in the future will be a matter
> of adding it in kvm_csr_regs[] and everything else will be taken care
> of.
>
> Despite all the code changes no behavioral change is made.
>
> [1] https://lore.kernel.org/qemu-riscv/CABJz62OfUDHYkQ0T3rGHStQprf1c7_E0q=
BLbLKhfv=3D+jb0SYAw@mail.gmail.com/
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h         |   1 +
>  target/riscv/kvm/kvm-cpu.c | 121 ++++++++++++++++++++++++++-----------
>  2 files changed, 86 insertions(+), 36 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 679f417336..f5a60d0c52 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -79,6 +79,7 @@ const char *riscv_get_misa_ext_name(uint32_t bit);
>  const char *riscv_get_misa_ext_description(uint32_t bit);
>
>  #define CPU_CFG_OFFSET(_prop) offsetof(struct RISCVCPUConfig, _prop)
> +#define ENV_CSR_OFFSET(_csr) offsetof(CPURISCVState, _csr)
>
>  typedef struct riscv_cpu_profile {
>      struct riscv_cpu_profile *u_parent;
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index fd66bc1759..f881e7eb5d 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -114,22 +114,6 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cp=
u,
>      KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_VECTOR, \
>                             KVM_REG_RISCV_VECTOR_CSR_REG(name))
>
> -#define KVM_RISCV_GET_CSR(cs, env, csr, reg) \
> -    do { \
> -        int _ret =3D kvm_get_one_reg(cs, RISCV_CSR_REG(csr), &reg); \
> -        if (_ret) { \
> -            return _ret; \
> -        } \
> -    } while (0)
> -
> -#define KVM_RISCV_SET_CSR(cs, env, csr, reg) \
> -    do { \
> -        int _ret =3D kvm_set_one_reg(cs, RISCV_CSR_REG(csr), &reg); \
> -        if (_ret) { \
> -            return _ret; \
> -        } \
> -    } while (0)
> -
>  #define KVM_RISCV_GET_TIMER(cs, name, reg) \
>      do { \
>          int ret =3D kvm_get_one_reg(cs, RISCV_TIMER_REG(name), &reg); \
> @@ -251,6 +235,53 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *=
cpu, CPUState *cs)
>      }
>  }
>
> +#define KVM_CSR_CFG(_name, _env_prop, reg_id) \
> +    {.name =3D _name, .offset =3D ENV_CSR_OFFSET(_env_prop), \
> +     .kvm_reg_id =3D reg_id}
> +
> +static KVMCPUConfig kvm_csr_cfgs[] =3D {
> +    KVM_CSR_CFG("sstatus",    mstatus,    RISCV_CSR_REG(sstatus)),
> +    KVM_CSR_CFG("sie",        mie,        RISCV_CSR_REG(sie)),
> +    KVM_CSR_CFG("stvec",      stvec,      RISCV_CSR_REG(stvec)),
> +    KVM_CSR_CFG("sscratch",   sscratch,   RISCV_CSR_REG(sscratch)),
> +    KVM_CSR_CFG("sepc",       sepc,       RISCV_CSR_REG(sepc)),
> +    KVM_CSR_CFG("scause",     scause,     RISCV_CSR_REG(scause)),
> +    KVM_CSR_CFG("stval",      stval,      RISCV_CSR_REG(stval)),
> +    KVM_CSR_CFG("sip",        mip,        RISCV_CSR_REG(sip)),
> +    KVM_CSR_CFG("satp",       satp,       RISCV_CSR_REG(satp)),
> +};
> +
> +static void *kvmconfig_get_env_addr(RISCVCPU *cpu, KVMCPUConfig *csr_cfg=
)
> +{
> +    return (void *)&cpu->env + csr_cfg->offset;
> +}
> +
> +static uint32_t kvm_cpu_csr_get_u32(RISCVCPU *cpu, KVMCPUConfig *csr_cfg=
)
> +{
> +    uint32_t *val32 =3D kvmconfig_get_env_addr(cpu, csr_cfg);
> +    return *val32;
> +}
> +
> +static uint64_t kvm_cpu_csr_get_u64(RISCVCPU *cpu, KVMCPUConfig *csr_cfg=
)
> +{
> +    uint64_t *val64 =3D kvmconfig_get_env_addr(cpu, csr_cfg);
> +    return *val64;
> +}
> +
> +static void kvm_cpu_csr_set_u32(RISCVCPU *cpu, KVMCPUConfig *csr_cfg,
> +                                uint32_t val)
> +{
> +    uint32_t *val32 =3D kvmconfig_get_env_addr(cpu, csr_cfg);
> +    *val32 =3D val;
> +}
> +
> +static void kvm_cpu_csr_set_u64(RISCVCPU *cpu, KVMCPUConfig *csr_cfg,
> +                                uint64_t val)
> +{
> +    uint64_t *val64 =3D kvmconfig_get_env_addr(cpu, csr_cfg);
> +    *val64 =3D val;
> +}
> +
>  #define KVM_EXT_CFG(_name, _prop, _reg_id) \
>      {.name =3D _name, .offset =3D CPU_CFG_OFFSET(_prop), \
>       .kvm_reg_id =3D _reg_id}
> @@ -598,34 +629,52 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
>
>  static int kvm_riscv_get_regs_csr(CPUState *cs)
>  {
> -    CPURISCVState *env =3D &RISCV_CPU(cs)->env;
> +    RISCVCPU *cpu =3D RISCV_CPU(cs);
> +    uint64_t reg;
> +    int i, ret;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
> +        KVMCPUConfig *csr_cfg =3D &kvm_csr_cfgs[i];
>
> -    KVM_RISCV_GET_CSR(cs, env, sstatus, env->mstatus);
> -    KVM_RISCV_GET_CSR(cs, env, sie, env->mie);
> -    KVM_RISCV_GET_CSR(cs, env, stvec, env->stvec);
> -    KVM_RISCV_GET_CSR(cs, env, sscratch, env->sscratch);
> -    KVM_RISCV_GET_CSR(cs, env, sepc, env->sepc);
> -    KVM_RISCV_GET_CSR(cs, env, scause, env->scause);
> -    KVM_RISCV_GET_CSR(cs, env, stval, env->stval);
> -    KVM_RISCV_GET_CSR(cs, env, sip, env->mip);
> -    KVM_RISCV_GET_CSR(cs, env, satp, env->satp);
> +        ret =3D kvm_get_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
> +        if (ret) {
> +            return ret;
> +        }
> +
> +        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) =3D=3D sizeof(uint32_t)) {
> +            kvm_cpu_csr_set_u32(cpu, csr_cfg, reg);
> +        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) =3D=3D sizeof(uint6=
4_t)) {
> +            kvm_cpu_csr_set_u64(cpu, csr_cfg, reg);
> +        } else {
> +            g_assert_not_reached();
> +        }
> +    }
>
>      return 0;
>  }
>
>  static int kvm_riscv_put_regs_csr(CPUState *cs)
>  {
> -    CPURISCVState *env =3D &RISCV_CPU(cs)->env;
> +    RISCVCPU *cpu =3D RISCV_CPU(cs);
> +    uint64_t reg;
> +    int i, ret;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
> +        KVMCPUConfig *csr_cfg =3D &kvm_csr_cfgs[i];
> +
> +        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) =3D=3D sizeof(uint32_t)) {
> +            reg =3D kvm_cpu_csr_get_u32(cpu, csr_cfg);
> +        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) =3D=3D sizeof(uint6=
4_t)) {
> +            reg =3D kvm_cpu_csr_get_u64(cpu, csr_cfg);
> +        } else {
> +            g_assert_not_reached();
> +        }
>
> -    KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);
> -    KVM_RISCV_SET_CSR(cs, env, sie, env->mie);
> -    KVM_RISCV_SET_CSR(cs, env, stvec, env->stvec);
> -    KVM_RISCV_SET_CSR(cs, env, sscratch, env->sscratch);
> -    KVM_RISCV_SET_CSR(cs, env, sepc, env->sepc);
> -    KVM_RISCV_SET_CSR(cs, env, scause, env->scause);
> -    KVM_RISCV_SET_CSR(cs, env, stval, env->stval);
> -    KVM_RISCV_SET_CSR(cs, env, sip, env->mip);
> -    KVM_RISCV_SET_CSR(cs, env, satp, env->satp);
> +        ret =3D kvm_set_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
>
>      return 0;
>  }
> --
> 2.49.0
>
>

