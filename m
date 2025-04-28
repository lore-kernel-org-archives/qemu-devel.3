Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6762C3ABA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 11:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9MsD-0002bT-9z; Mon, 28 Apr 2025 07:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9Ms9-0002Ud-G0; Mon, 28 Apr 2025 07:42:05 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9Ms4-0008LD-HM; Mon, 28 Apr 2025 07:42:05 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-86d69774081so1967664241.0; 
 Mon, 28 Apr 2025 04:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745840518; x=1746445318; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zoZ23h+0t4Ylo7V3s8WlX5TovJjgvt0c5gmCa8D7wBU=;
 b=Z3GYXHtVitY2cFqyLFFhKnBa4dgG+V2lSNxZWnwlP40PywdYtbKnS/oMUYV5CVMzd4
 0kTFivjMYYTS+yftT4rGaPueKJLEv/B//aO/MbEzTlgV+H+jE/F/BnXutLsqDfLI64kA
 ghri/C6BIZGYWuEoYa3t7NGiHd7g0UvzDmeCtRCJLM/ouYaiYdk6EBc3fFoCyF0C7r/4
 VCb8st0liXrTNIG17IgBZteNM/PxK548oXCQyPzXn+TiWLSyTtkr8S4qg9yElonqaAKs
 zmRJlBK+SLgRBU4hwdVedQz/+YwJAG1RC3foiEzOh2gBtpePStXn52f2ITEjgVPCOd+D
 DKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745840518; x=1746445318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zoZ23h+0t4Ylo7V3s8WlX5TovJjgvt0c5gmCa8D7wBU=;
 b=icuc3WgqUMvvmTAyd28rGk5fEBOPTk4/eW/9D2UvE10QKWD9Tezpxq6OPfQwXnixh6
 3vmQusz4EU2wyACF1+loIb4crQvvedLhCfCizDzmIeHwcBrjiJXsF0NB1a6JtpkSAYFD
 0uZtlU6CCHUYrUWe8S8HCkEjz3M7TlJFX1l4jyjuxnpexJCARTNGoUgziorIKPk2nRCa
 IP8xej24bpKWj/QXFPzs4qW+vPGOcvoqYquO1HrfimRBcoCv/+ow2QLMDiU671XzBqMQ
 Ix+YkKEqvCsjEklU5HqDgJzRwIuFX1coY9UmL8FKoIGONt/rYvnFdmk9Tj9XquPgGo/A
 vbxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNHDUxkhS7Z8pUqPR72DuMHwd6O/CByoVn2ptDM2NkEMUPLyFDJEFOSOxPH197DxlankxnX7cUUABh@nongnu.org
X-Gm-Message-State: AOJu0YzMk+Ce8ywbifw+x4Mq14jRiDZKRcES3By2OIOwrOXPpUBJD/CY
 yBRJfWAGepsgtIeAgoFbf9pw9jRg7SXmrpHQBjjrOOjdnigtOAzvTn1ONgIRQYI7qHLEqnWjaRQ
 DDwZvqWmnhQJBEyZLIcfcts4eVg8=
X-Gm-Gg: ASbGncs3I/hM99wL291JL9kWgTdTh307MYEkHCPnE7cikYLLP4NZGwmZUyu2ga+k+Wm
 /p8Oqm0WlC47ibtZA/nH2mKtpK4WoPUcSnOVv00lfjNgd+cdEg82ReA9ID7SuJb/Q/1YLfvo1Eh
 uEFGQtbRUShQtO+vRQh821uzt72XVZYTYj/FViKPP5s9pvCu256hjj
X-Google-Smtp-Source: AGHT+IEU3JuuZr6P4JnJm6KMYWYxBFXx9QpCjnPoA4r7U/Ryk3fnC9PRIlVlTJTCtv689+6RDXU47Jo1huwoBduBZTA=
X-Received: by 2002:a05:6102:1525:b0:4bb:c4ff:5cb9 with SMTP id
 ada2fe7eead31-4d640d85cbemr5004615137.15.1745840518476; Mon, 28 Apr 2025
 04:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
 <20250425160203.2774835-5-dbarboza@ventanamicro.com>
In-Reply-To: <20250425160203.2774835-5-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 28 Apr 2025 21:41:30 +1000
X-Gm-Features: ATxdqUFSXgpcc0im3iIGOKv5QB3FHU6IjogQyk_qi-B90ZbwIUKF0eO8IieWzAQ
Message-ID: <CAKmqyKPx7cDedo5jWGR5KO3UcV2mgJ-9oakXYbtkwQj0C3brqA@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] target/riscv/kvm: turn kvm_riscv_reg_id_ulong()
 into a macro
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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
> We need the reg_id_ulong() helper to be a macro to be able to create a
> static array of KVMCPUConfig that will hold CSR information.
>
> Despite the amount of changes all of them are tedious/trivial:
>
> - replace instances of "kvm_riscv_reg_id_ulong" with
>   "KVM_RISCV_REG_ID_ULONG";
>
> - RISCV_CORE_REG(), RISCV_CSR_REG(), RISCV_CONFIG_REG() and
>   RISCV_VECTOR_CSR_REG() only receives one 'name' arg. Remove unneeded
>   'env' variables when applicable.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 99 ++++++++++++++++----------------------
>  1 file changed, 41 insertions(+), 58 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index c91ecdfe59..fd66bc1759 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -64,23 +64,11 @@ static bool cap_has_mp_state;
>  #define KVM_RISCV_REG_ID_U64(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U6=
4 | \
>                                           type | idx)
>
> -static uint64_t kvm_riscv_reg_id_ulong(CPURISCVState *env, uint64_t type=
,
> -                                 uint64_t idx)
> -{
> -    uint64_t id =3D KVM_REG_RISCV | type | idx;
> -
> -    switch (riscv_cpu_mxl(env)) {
> -    case MXL_RV32:
> -        id |=3D KVM_REG_SIZE_U32;
> -        break;
> -    case MXL_RV64:
> -        id |=3D KVM_REG_SIZE_U64;
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -    return id;
> -}
> +#if defined(TARGET_RISCV64)
> +#define KVM_RISCV_REG_ID_ULONG(type, idx) KVM_RISCV_REG_ID_U64(type, idx=
)
> +#else
> +#define KVM_RISCV_REG_ID_ULONG(type, idx) KVM_RISCV_REG_ID_U32(type, idx=
)
> +#endif
>
>  static uint64_t kvm_encode_reg_size_id(uint64_t id, size_t size_b)
>  {
> @@ -103,16 +91,16 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cp=
u,
>      return kvm_encode_reg_size_id(id, size_b);
>  }
>
> -#define RISCV_CORE_REG(env, name) \
> -    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, \
> +#define RISCV_CORE_REG(name) \
> +    KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CORE, \
>                             KVM_REG_RISCV_CORE_REG(name))
>
> -#define RISCV_CSR_REG(env, name) \
> -    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CSR, \
> +#define RISCV_CSR_REG(name) \
> +    KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CSR, \
>                             KVM_REG_RISCV_CSR_REG(name))
>
> -#define RISCV_CONFIG_REG(env, name) \
> -    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG, \
> +#define RISCV_CONFIG_REG(name) \
> +    KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG, \
>                             KVM_REG_RISCV_CONFIG_REG(name))
>
>  #define RISCV_TIMER_REG(name)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_TIMER,=
 \
> @@ -122,13 +110,13 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *c=
pu,
>
>  #define RISCV_FP_D_REG(idx)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_FP_D, id=
x)
>
> -#define RISCV_VECTOR_CSR_REG(env, name) \
> -    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_VECTOR, \
> +#define RISCV_VECTOR_CSR_REG(name) \
> +    KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_VECTOR, \
>                             KVM_REG_RISCV_VECTOR_CSR_REG(name))
>
>  #define KVM_RISCV_GET_CSR(cs, env, csr, reg) \
>      do { \
> -        int _ret =3D kvm_get_one_reg(cs, RISCV_CSR_REG(env, csr), &reg);=
 \
> +        int _ret =3D kvm_get_one_reg(cs, RISCV_CSR_REG(csr), &reg); \
>          if (_ret) { \
>              return _ret; \
>          } \
> @@ -136,7 +124,7 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu=
,
>
>  #define KVM_RISCV_SET_CSR(cs, env, csr, reg) \
>      do { \
> -        int _ret =3D kvm_set_one_reg(cs, RISCV_CSR_REG(env, csr), &reg);=
 \
> +        int _ret =3D kvm_set_one_reg(cs, RISCV_CSR_REG(csr), &reg); \
>          if (_ret) { \
>              return _ret; \
>          } \
> @@ -244,7 +232,7 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *c=
pu, CPUState *cs)
>
>          /* If we're here we're going to disable the MISA bit */
>          reg =3D 0;
> -        id =3D kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_ISA_EXT,
> +        id =3D KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_ISA_EXT,
>                                      misa_cfg->kvm_reg_id);
>          ret =3D kvm_set_one_reg(cs, id, &reg);
>          if (ret !=3D 0) {
> @@ -430,7 +418,6 @@ static KVMCPUConfig kvm_sbi_dbcn =3D {
>
>  static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs=
)
>  {
> -    CPURISCVState *env =3D &cpu->env;
>      uint64_t id, reg;
>      int i, ret;
>
> @@ -441,7 +428,7 @@ static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU=
 *cpu, CPUState *cs)
>              continue;
>          }
>
> -        id =3D kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_ISA_EXT,
> +        id =3D KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_ISA_EXT,
>                                      multi_ext_cfg->kvm_reg_id);
>          reg =3D kvm_cpu_cfg_get(cpu, multi_ext_cfg);
>          ret =3D kvm_set_one_reg(cs, id, &reg);
> @@ -566,14 +553,14 @@ static int kvm_riscv_get_regs_core(CPUState *cs)
>      target_ulong reg;
>      CPURISCVState *env =3D &RISCV_CPU(cs)->env;
>
> -    ret =3D kvm_get_one_reg(cs, RISCV_CORE_REG(env, regs.pc), &reg);
> +    ret =3D kvm_get_one_reg(cs, RISCV_CORE_REG(regs.pc), &reg);
>      if (ret) {
>          return ret;
>      }
>      env->pc =3D reg;
>
>      for (i =3D 1; i < 32; i++) {
> -        uint64_t id =3D kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, =
i);
> +        uint64_t id =3D KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CORE, i);
>          ret =3D kvm_get_one_reg(cs, id, &reg);
>          if (ret) {
>              return ret;
> @@ -592,13 +579,13 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
>      CPURISCVState *env =3D &RISCV_CPU(cs)->env;
>
>      reg =3D env->pc;
> -    ret =3D kvm_set_one_reg(cs, RISCV_CORE_REG(env, regs.pc), &reg);
> +    ret =3D kvm_set_one_reg(cs, RISCV_CORE_REG(regs.pc), &reg);
>      if (ret) {
>          return ret;
>      }
>
>      for (i =3D 1; i < 32; i++) {
> -        uint64_t id =3D kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, =
i);
> +        uint64_t id =3D KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CORE, i);
>          reg =3D env->gpr[i];
>          ret =3D kvm_set_one_reg(cs, id, &reg);
>          if (ret) {
> @@ -796,26 +783,26 @@ static int kvm_riscv_get_regs_vector(CPUState *cs)
>          return 0;
>      }
>
> -    ret =3D kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vstart), &reg)=
;
> +    ret =3D kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vstart), &reg);
>      if (ret) {
>          return ret;
>      }
>      env->vstart =3D reg;
>
> -    ret =3D kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vl), &reg);
> +    ret =3D kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vl), &reg);
>      if (ret) {
>          return ret;
>      }
>      env->vl =3D reg;
>
> -    ret =3D kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vtype), &reg);
> +    ret =3D kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vtype), &reg);
>      if (ret) {
>          return ret;
>      }
>      env->vtype =3D reg;
>
>      if (kvm_v_vlenb.supported) {
> -        ret =3D kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vlenb), &r=
eg);
> +        ret =3D kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vlenb), &reg);
>          if (ret) {
>              return ret;
>          }
> @@ -853,26 +840,26 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
>      }
>
>      reg =3D env->vstart;
> -    ret =3D kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vstart), &reg)=
;
> +    ret =3D kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vstart), &reg);
>      if (ret) {
>          return ret;
>      }
>
>      reg =3D env->vl;
> -    ret =3D kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vl), &reg);
> +    ret =3D kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vl), &reg);
>      if (ret) {
>          return ret;
>      }
>
>      reg =3D env->vtype;
> -    ret =3D kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vtype), &reg);
> +    ret =3D kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vtype), &reg);
>      if (ret) {
>          return ret;
>      }
>
>      if (kvm_v_vlenb.supported) {
>          reg =3D cpu->cfg.vlenb;
> -        ret =3D kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vlenb), &r=
eg);
> +        ret =3D kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vlenb), &reg);
>
>          for (int i =3D 0; i < 32; i++) {
>              /*
> @@ -951,25 +938,24 @@ static void kvm_riscv_destroy_scratch_vcpu(KVMScrat=
chCPU *scratch)
>
>  static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvm=
cpu)
>  {
> -    CPURISCVState *env =3D &cpu->env;
>      struct kvm_one_reg reg;
>      int ret;
>
> -    reg.id =3D RISCV_CONFIG_REG(env, mvendorid);
> +    reg.id =3D RISCV_CONFIG_REG(mvendorid);
>      reg.addr =3D (uint64_t)&cpu->cfg.mvendorid;
>      ret =3D ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
>      if (ret !=3D 0) {
>          error_report("Unable to retrieve mvendorid from host, error %d",=
 ret);
>      }
>
> -    reg.id =3D RISCV_CONFIG_REG(env, marchid);
> +    reg.id =3D RISCV_CONFIG_REG(marchid);
>      reg.addr =3D (uint64_t)&cpu->cfg.marchid;
>      ret =3D ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
>      if (ret !=3D 0) {
>          error_report("Unable to retrieve marchid from host, error %d", r=
et);
>      }
>
> -    reg.id =3D RISCV_CONFIG_REG(env, mimpid);
> +    reg.id =3D RISCV_CONFIG_REG(mimpid);
>      reg.addr =3D (uint64_t)&cpu->cfg.mimpid;
>      ret =3D ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
>      if (ret !=3D 0) {
> @@ -984,7 +970,7 @@ static void kvm_riscv_init_misa_ext_mask(RISCVCPU *cp=
u,
>      struct kvm_one_reg reg;
>      int ret;
>
> -    reg.id =3D RISCV_CONFIG_REG(env, isa);
> +    reg.id =3D RISCV_CONFIG_REG(isa);
>      reg.addr =3D (uint64_t)&env->misa_ext_mask;
>      ret =3D ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
>
> @@ -1001,11 +987,10 @@ static void kvm_riscv_init_misa_ext_mask(RISCVCPU =
*cpu,
>  static void kvm_riscv_read_cbomz_blksize(RISCVCPU *cpu, KVMScratchCPU *k=
vmcpu,
>                                           KVMCPUConfig *cbomz_cfg)
>  {
> -    CPURISCVState *env =3D &cpu->env;
>      struct kvm_one_reg reg;
>      int ret;
>
> -    reg.id =3D kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG,
> +    reg.id =3D KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
>                                      cbomz_cfg->kvm_reg_id);
>      reg.addr =3D (uint64_t)kvmconfig_get_cfg_addr(cpu, cbomz_cfg);
>      ret =3D ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
> @@ -1019,7 +1004,6 @@ static void kvm_riscv_read_cbomz_blksize(RISCVCPU *=
cpu, KVMScratchCPU *kvmcpu,
>  static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
>                                             KVMScratchCPU *kvmcpu)
>  {
> -    CPURISCVState *env =3D &cpu->env;
>      uint64_t val;
>      int i, ret;
>
> @@ -1027,7 +1011,7 @@ static void kvm_riscv_read_multiext_legacy(RISCVCPU=
 *cpu,
>          KVMCPUConfig *multi_ext_cfg =3D &kvm_multi_ext_cfgs[i];
>          struct kvm_one_reg reg;
>
> -        reg.id =3D kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_ISA_EXT,
> +        reg.id =3D KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_ISA_EXT,
>                                          multi_ext_cfg->kvm_reg_id);
>          reg.addr =3D (uint64_t)&val;
>          ret =3D ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
> @@ -1159,7 +1143,7 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *c=
pu, KVMScratchCPU *kvmcpu)
>
>      for (i =3D 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
>          multi_ext_cfg =3D &kvm_multi_ext_cfgs[i];
> -        reg_id =3D kvm_riscv_reg_id_ulong(&cpu->env, KVM_REG_RISCV_ISA_E=
XT,
> +        reg_id =3D KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_ISA_EXT,
>                                          multi_ext_cfg->kvm_reg_id);
>          reg_search =3D bsearch(&reg_id, reglist->reg, reglist->n,
>                               sizeof(uint64_t), uint64_cmp);
> @@ -1338,12 +1322,11 @@ void kvm_arch_init_irq_routing(KVMState *s)
>
>  static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu, CPUState *cs)
>  {
> -    CPURISCVState *env =3D &cpu->env;
>      target_ulong reg;
>      uint64_t id;
>      int ret;
>
> -    id =3D RISCV_CONFIG_REG(env, mvendorid);
> +    id =3D RISCV_CONFIG_REG(mvendorid);
>      /*
>       * cfg.mvendorid is an uint32 but a target_ulong will
>       * be written. Assign it to a target_ulong var to avoid
> @@ -1355,13 +1338,13 @@ static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu=
, CPUState *cs)
>          return ret;
>      }
>
> -    id =3D RISCV_CONFIG_REG(env, marchid);
> +    id =3D RISCV_CONFIG_REG(marchid);
>      ret =3D kvm_set_one_reg(cs, id, &cpu->cfg.marchid);
>      if (ret !=3D 0) {
>          return ret;
>      }
>
> -    id =3D RISCV_CONFIG_REG(env, mimpid);
> +    id =3D RISCV_CONFIG_REG(mimpid);
>      ret =3D kvm_set_one_reg(cs, id, &cpu->cfg.mimpid);
>
>      return ret;
> @@ -1911,7 +1894,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu,=
 Error **errp)
>      if (cpu->cfg.ext_zicbom &&
>          riscv_cpu_option_set(kvm_cbom_blocksize.name)) {
>
> -        reg.id =3D kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG,
> +        reg.id =3D KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
>                                          kvm_cbom_blocksize.kvm_reg_id);
>          reg.addr =3D (uint64_t)&val;
>          ret =3D ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
> @@ -1930,7 +1913,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu,=
 Error **errp)
>      if (cpu->cfg.ext_zicboz &&
>          riscv_cpu_option_set(kvm_cboz_blocksize.name)) {
>
> -        reg.id =3D kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG,
> +        reg.id =3D KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
>                                          kvm_cboz_blocksize.kvm_reg_id);
>          reg.addr =3D (uint64_t)&val;
>          ret =3D ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
> --
> 2.49.0
>
>

