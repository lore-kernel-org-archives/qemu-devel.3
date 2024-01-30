Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCFDC47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 00:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUcAO-0000Mw-3P; Mon, 29 Jan 2024 19:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUcAL-0000MS-J4; Mon, 29 Jan 2024 19:39:53 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUcAI-0001e3-Tt; Mon, 29 Jan 2024 19:39:53 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-4bdc8cdd6a2so672921e0c.3; 
 Mon, 29 Jan 2024 16:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706575188; x=1707179988; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xgLBaAtH3oGihEve2iNQvD5qjcVl5BIm3JtCuboJjqA=;
 b=aOqQdipnn5EEEzwDmcbX83k0UVAQ1Z4se5fIfbA0F51WYNgr8UkGWkUuTeodHFvMfk
 NiCxlJ8snteBtwY6e0oYf1rWBmxAGmiUiAUTwy5VKJycYD4kQJWeKOHCUmtPN5mQVcnz
 6OACOD6Y4zzuH+u92i3e8WD6DeOMKYXYpuDsun2bBhxasthugrLPjo3W2YBEPROuFQHU
 wyt445HZVuSrYPMJzaOPsLpZJeXpTNvMZhAYWaPcq/AMff2TQkUGB6OgURzwvEO28VwC
 BBbokILb1Fz7XpEk81JJ0xFbO0UtuWzoRDxMr8dOuaO1Olvob8kiB9ZRWwalMX2SiSIE
 HaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706575188; x=1707179988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xgLBaAtH3oGihEve2iNQvD5qjcVl5BIm3JtCuboJjqA=;
 b=RCI3aMjmWR+d0ZszYt85oWqQy39rXRbg1F+qtHt2WixqcHqUAT1zaQt4caJC8gZCSZ
 PRt+BK+V7XDhIQh83VxDYp8D7tSIWeiHmBfsBtR92uj+esoI6B0zxkXdUQ56sV8trMtr
 yVThTZTtfTRmYYf3XyNwivlzxurrkCEcfT37a4DVkqwiuP13uIRwFMa+cbvWjXe3yyDR
 YgIKpzr/TP3wfan9JfDr8z4lwZlzUc5sLqmTq+bYyzYUrMtSKfsOSnytTkzentKbmDdo
 zsPRqLYlOCdXn1lXj2VuQ8fEmXWvR8QfKOa0DLCN1GXUBVv/hH7J3KGILluF6ovkVmli
 B5ZA==
X-Gm-Message-State: AOJu0YzjRjbTnFQtA/C2Z+4wtKntbloSUFC83JxKNxM5jXvoZzvE+Xwp
 k49DeqMzHc0kR5unOTO0IjpxyJjg0vo4z7xFrdcVkdhuMLIhfWt9/ATUWgTd2x7X/OBAyGi7LYD
 1KyeNN5v4je7mPMvufkrPURQSOQo=
X-Google-Smtp-Source: AGHT+IFOvCqL2ps1d0mglgDukYHloWUlgq6B12Wyv7VOxXTPXFBITYeo/eLDuyWjJ6az8GtMlZbW7qTLlgaV6ZT9iE8=
X-Received: by 2002:a05:6122:d11:b0:4b6:dfda:525c with SMTP id
 az17-20020a0561220d1100b004b6dfda525cmr4127171vkb.5.1706575188288; Mon, 29
 Jan 2024 16:39:48 -0800 (PST)
MIME-Version: 1.0
References: <20240129164514.73104-1-philmd@linaro.org>
 <20240129164514.73104-23-philmd@linaro.org>
In-Reply-To: <20240129164514.73104-23-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Jan 2024 10:39:22 +1000
Message-ID: <CAKmqyKMMYUT44mc4muZv0t+Cpu0ysw3Y5B6d6KVpnkw29pP0gQ@mail.gmail.com>
Subject: Re: [PATCH v3 22/29] target/riscv: Prefer fast cpu_env() over slower
 CPU QOM cast macro
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Tue, Jan 30, 2024 at 2:52=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/arch_dump.c   |  6 ++----
>  target/riscv/cpu.c         | 17 +++++------------
>  target/riscv/cpu_helper.c  | 17 +++++------------
>  target/riscv/debug.c       |  9 +++------
>  target/riscv/gdbstub.c     |  6 ++----
>  target/riscv/kvm/kvm-cpu.c | 11 +++--------
>  target/riscv/tcg/tcg-cpu.c | 10 +++-------
>  target/riscv/translate.c   |  6 ++----
>  8 files changed, 25 insertions(+), 57 deletions(-)
>
> diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
> index 434c8a3dbb..994709647f 100644
> --- a/target/riscv/arch_dump.c
> +++ b/target/riscv/arch_dump.c
> @@ -68,8 +68,7 @@ int riscv_cpu_write_elf64_note(WriteCoreDumpFunction f,=
 CPUState *cs,
>                                 int cpuid, DumpState *s)
>  {
>      struct riscv64_note note;
> -    RISCVCPU *cpu =3D RISCV_CPU(cs);
> -    CPURISCVState *env =3D &cpu->env;
> +    CPURISCVState *env =3D cpu_env(cs);
>      int ret, i =3D 0;
>      const char name[] =3D "CORE";
>
> @@ -137,8 +136,7 @@ int riscv_cpu_write_elf32_note(WriteCoreDumpFunction =
f, CPUState *cs,
>                                 int cpuid, DumpState *s)
>  {
>      struct riscv32_note note;
> -    RISCVCPU *cpu =3D RISCV_CPU(cs);
> -    CPURISCVState *env =3D &cpu->env;
> +    CPURISCVState *env =3D cpu_env(cs);
>      int ret, i;
>      const char name[] =3D "CORE";
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 1bd99bc5c6..8af4f7a088 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -419,8 +419,7 @@ static void riscv_any_cpu_init(Object *obj)
>
>  static void riscv_max_cpu_init(Object *obj)
>  {
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -    CPURISCVState *env =3D &cpu->env;
> +    CPURISCVState *env =3D cpu_env(CPU(obj));
>      RISCVMXL mlx =3D MXL_RV64;
>
>  #ifdef TARGET_RISCV32
> @@ -828,8 +827,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *=
f, int flags)
>
>  static void riscv_cpu_set_pc(CPUState *cs, vaddr value)
>  {
> -    RISCVCPU *cpu =3D RISCV_CPU(cs);
> -    CPURISCVState *env =3D &cpu->env;
> +    CPURISCVState *env =3D cpu_env(cs);
>
>      if (env->xl =3D=3D MXL_RV32) {
>          env->pc =3D (int32_t)value;
> @@ -840,8 +838,7 @@ static void riscv_cpu_set_pc(CPUState *cs, vaddr valu=
e)
>
>  static vaddr riscv_cpu_get_pc(CPUState *cs)
>  {
> -    RISCVCPU *cpu =3D RISCV_CPU(cs);
> -    CPURISCVState *env =3D &cpu->env;
> +    CPURISCVState *env =3D cpu_env(cs);
>
>      /* Match cpu_get_tb_cpu_state. */
>      if (env->xl =3D=3D MXL_RV32) {
> @@ -853,8 +850,7 @@ static vaddr riscv_cpu_get_pc(CPUState *cs)
>  static bool riscv_cpu_has_work(CPUState *cs)
>  {
>  #ifndef CONFIG_USER_ONLY
> -    RISCVCPU *cpu =3D RISCV_CPU(cs);
> -    CPURISCVState *env =3D &cpu->env;
> +    CPURISCVState *env =3D cpu_env(cs);
>      /*
>       * Definition of the WFI instruction requires it to ignore the privi=
lege
>       * mode and delegation registers, but respect individual enables
> @@ -1642,10 +1638,7 @@ static void rva22s64_profile_cpu_init(Object *obj)
>
>  static const gchar *riscv_gdb_arch_name(CPUState *cs)
>  {
> -    RISCVCPU *cpu =3D RISCV_CPU(cs);
> -    CPURISCVState *env =3D &cpu->env;
> -
> -    switch (riscv_cpu_mxl(env)) {
> +    switch (riscv_cpu_mxl(cpu_env(cs))) {
>      case MXL_RV32:
>          return "riscv:rv32";
>      case MXL_RV64:
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 791435d628..01b32a3f83 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -493,9 +493,7 @@ static int riscv_cpu_local_irq_pending(CPURISCVState =
*env)
>  bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  {
>      if (interrupt_request & CPU_INTERRUPT_HARD) {
> -        RISCVCPU *cpu =3D RISCV_CPU(cs);
> -        CPURISCVState *env =3D &cpu->env;
> -        int interruptno =3D riscv_cpu_local_irq_pending(env);
> +        int interruptno =3D riscv_cpu_local_irq_pending(cpu_env(cs));
>          if (interruptno >=3D 0) {
>              cs->exception_index =3D RISCV_EXCP_INT_FLAG | interruptno;
>              riscv_cpu_do_interrupt(cs);
> @@ -1196,8 +1194,7 @@ static void raise_mmu_exception(CPURISCVState *env,=
 target_ulong address,
>
>  hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>  {
> -    RISCVCPU *cpu =3D RISCV_CPU(cs);
> -    CPURISCVState *env =3D &cpu->env;
> +    CPURISCVState *env =3D cpu_env(cs);
>      hwaddr phys_addr;
>      int prot;
>      int mmu_idx =3D cpu_mmu_index(env, false);
> @@ -1223,8 +1220,7 @@ void riscv_cpu_do_transaction_failed(CPUState *cs, =
hwaddr physaddr,
>                                       int mmu_idx, MemTxAttrs attrs,
>                                       MemTxResult response, uintptr_t ret=
addr)
>  {
> -    RISCVCPU *cpu =3D RISCV_CPU(cs);
> -    CPURISCVState *env =3D &cpu->env;
> +    CPURISCVState *env =3D cpu_env(cs);
>
>      if (access_type =3D=3D MMU_DATA_STORE) {
>          cs->exception_index =3D RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
> @@ -1244,8 +1240,7 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, va=
ddr addr,
>                                     MMUAccessType access_type, int mmu_id=
x,
>                                     uintptr_t retaddr)
>  {
> -    RISCVCPU *cpu =3D RISCV_CPU(cs);
> -    CPURISCVState *env =3D &cpu->env;
> +    CPURISCVState *env =3D cpu_env(cs);
>      switch (access_type) {
>      case MMU_INST_FETCH:
>          cs->exception_index =3D RISCV_EXCP_INST_ADDR_MIS;
> @@ -1631,9 +1626,7 @@ static target_ulong riscv_transformed_insn(CPURISCV=
State *env,
>  void riscv_cpu_do_interrupt(CPUState *cs)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -
> -    RISCVCPU *cpu =3D RISCV_CPU(cs);
> -    CPURISCVState *env =3D &cpu->env;
> +    CPURISCVState *env =3D cpu_env(cs);
>      bool write_gva =3D false;
>      uint64_t s;
>
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 4945d1a1f2..c8df9812be 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -757,8 +757,7 @@ target_ulong tinfo_csr_read(CPURISCVState *env)
>
>  void riscv_cpu_debug_excp_handler(CPUState *cs)
>  {
> -    RISCVCPU *cpu =3D RISCV_CPU(cs);
> -    CPURISCVState *env =3D &cpu->env;
> +    CPURISCVState *env =3D cpu_env(cs);
>
>      if (cs->watchpoint_hit) {
>          if (cs->watchpoint_hit->flags & BP_CPU) {
> @@ -773,8 +772,7 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
>
>  bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>  {
> -    RISCVCPU *cpu =3D RISCV_CPU(cs);
> -    CPURISCVState *env =3D &cpu->env;
> +    CPURISCVState *env =3D cpu_env(cs);
>      CPUBreakpoint *bp;
>      target_ulong ctrl;
>      target_ulong pc;
> @@ -832,8 +830,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>
>  bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
>  {
> -    RISCVCPU *cpu =3D RISCV_CPU(cs);
> -    CPURISCVState *env =3D &cpu->env;
> +    CPURISCVState *env =3D cpu_env(cs);
>      target_ulong ctrl;
>      target_ulong addr;
>      int trigger_type;
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 58b3ace0fe..999d815b34 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -49,8 +49,7 @@ static const struct TypeSize vec_lanes[] =3D {
>
>  int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n=
)
>  {
> -    RISCVCPU *cpu =3D RISCV_CPU(cs);
> -    CPURISCVState *env =3D &cpu->env;
> +    CPURISCVState *env =3D cpu_env(cs);
>      target_ulong tmp;
>
>      if (n < 32) {
> @@ -75,8 +74,7 @@ int riscv_cpu_gdb_read_register(CPUState *cs, GByteArra=
y *mem_buf, int n)
>
>  int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>  {
> -    RISCVCPU *cpu =3D RISCV_CPU(cs);
> -    CPURISCVState *env =3D &cpu->env;
> +    CPURISCVState *env =3D cpu_env(cs);
>      int length =3D 0;
>      target_ulong tmp;
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 680a729cd8..563b371ec9 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -171,9 +171,7 @@ static void kvm_cpu_get_misa_ext_cfg(Object *obj, Vis=
itor *v,
>  {
>      KVMCPUConfig *misa_ext_cfg =3D opaque;
>      target_ulong misa_bit =3D misa_ext_cfg->offset;
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -    CPURISCVState *env =3D &cpu->env;
> -    bool value =3D env->misa_ext_mask & misa_bit;
> +    bool value =3D cpu_env(CPU(obj))->misa_ext_mask & misa_bit;
>
>      visit_type_bool(v, name, &value, errp);
>  }
> @@ -184,15 +182,13 @@ static void kvm_cpu_set_misa_ext_cfg(Object *obj, V=
isitor *v,
>  {
>      KVMCPUConfig *misa_ext_cfg =3D opaque;
>      target_ulong misa_bit =3D misa_ext_cfg->offset;
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -    CPURISCVState *env =3D &cpu->env;
>      bool value, host_bit;
>
>      if (!visit_type_bool(v, name, &value, errp)) {
>          return;
>      }
>
> -    host_bit =3D env->misa_ext_mask & misa_bit;
> +    host_bit =3D cpu_env(CPU(obj))->misa_ext_mask & misa_bit;
>
>      if (value =3D=3D host_bit) {
>          return;
> @@ -1583,10 +1579,9 @@ static void kvm_cpu_instance_init(CPUState *cs)
>   */
>  static bool kvm_cpu_realize(CPUState *cs, Error **errp)
>  {
> -    RISCVCPU *cpu =3D RISCV_CPU(cs);
>      int ret;
>
> -    if (riscv_has_ext(&cpu->env, RVV)) {
> +    if (riscv_has_ext(cpu_env(cs), RVV)) {
>          ret =3D prctl(PR_RISCV_V_SET_CONTROL, PR_RISCV_V_VSTATE_CTRL_ON)=
;
>          if (ret) {
>              error_setg(errp, "Error in prctl PR_RISCV_V_SET_CONTROL, cod=
e: %s",
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 994ca1cdf9..e0f05d898c 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -92,8 +92,7 @@ static void riscv_cpu_synchronize_from_tb(CPUState *cs,
>                                            const TranslationBlock *tb)
>  {
>      if (!(tb_cflags(tb) & CF_PCREL)) {
> -        RISCVCPU *cpu =3D RISCV_CPU(cs);
> -        CPURISCVState *env =3D &cpu->env;
> +        CPURISCVState *env =3D cpu_env(cs);
>          RISCVMXL xl =3D FIELD_EX32(tb->flags, TB_FLAGS, XL);
>
>          tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
> @@ -110,8 +109,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
>                                         const TranslationBlock *tb,
>                                         const uint64_t *data)
>  {
> -    RISCVCPU *cpu =3D RISCV_CPU(cs);
> -    CPURISCVState *env =3D &cpu->env;
> +    CPURISCVState *env =3D cpu_env(cs);
>      RISCVMXL xl =3D FIELD_EX32(tb->flags, TB_FLAGS, XL);
>      target_ulong pc;
>
> @@ -1030,11 +1028,9 @@ static void cpu_get_misa_ext_cfg(Object *obj, Visi=
tor *v, const char *name,
>  {
>      const RISCVCPUMisaExtConfig *misa_ext_cfg =3D opaque;
>      target_ulong misa_bit =3D misa_ext_cfg->misa_bit;
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -    CPURISCVState *env =3D &cpu->env;
>      bool value;
>
> -    value =3D env->misa_ext & misa_bit;
> +    value =3D cpu_env(CPU(obj))->misa_ext & misa_bit;
>
>      visit_type_bool(v, name, &value, errp);
>  }
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 071fbad7ef..24db9f3882 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1074,9 +1074,8 @@ static uint32_t opcode_at(DisasContextBase *dcbase,=
 target_ulong pc)
>  {
>      DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
>      CPUState *cpu =3D ctx->cs;
> -    CPURISCVState *env =3D cpu_env(cpu);
>
> -    return cpu_ldl_code(env, pc);
> +    return cpu_ldl_code(cpu_env(cpu), pc);
>  }
>
>  /* Include insn module translation function */
> @@ -1265,8 +1264,7 @@ static void riscv_tr_disas_log(const DisasContextBa=
se *dcbase,
>                                 CPUState *cpu, FILE *logfile)
>  {
>  #ifndef CONFIG_USER_ONLY
> -    RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
> -    CPURISCVState *env =3D &rvcpu->env;
> +    CPURISCVState *env =3D cpu_env(cpu);
>  #endif
>
>      fprintf(logfile, "IN: %s\n", lookup_symbol(dcbase->pc_first));
> --
> 2.41.0
>
>

