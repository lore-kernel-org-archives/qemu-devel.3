Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A850BD24463
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 03:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz6FM-0004zS-5n; Thu, 10 Oct 2024 23:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz6FK-0004z7-Ht; Thu, 10 Oct 2024 23:23:18 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz6FF-0002y5-Gv; Thu, 10 Oct 2024 23:23:18 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-84fdb038aaaso230312241.3; 
 Thu, 10 Oct 2024 20:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728616992; x=1729221792; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Kmn639IsS4UYWYBUd0KXRR5/POzdf7Mg6P0434qjJA=;
 b=PdLDZqZreewWoueigI6Ak+58+gIewED/4qSNyyiWG1m5dHYNJXDCYHNw+Y8fl3VnIB
 GqRR3kiXIz6UY+o5mRlwA0hPHe4NEWWsQqRjAXfgxmbh/NYCPdwAk0eYSoYqVvq7Ad1U
 iwbR0tboB8fxlU6PUNY8+Xy5F/XvQaLlvox4LRjqN4Q9/IHUout3/v+iWqBBXeBrMXiL
 QEvVSM8iy5YFGQ3OgmPxONB/b92iUsVz4xKPNi3QbORJaSLLg4eHYASJV/NzfeYqzCl+
 HkKvOUJ6YphJnR5XBL3SOVXX8rOpj9XMJ6x7juEga0Q2koRmgODJLIn2n0nIgwUnhwBH
 ng0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728616992; x=1729221792;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Kmn639IsS4UYWYBUd0KXRR5/POzdf7Mg6P0434qjJA=;
 b=r8ZqgRXtlcA5hP4Jv5DquwmBCOK+M5AgsJ499vHUUl7AS+UK7al1GAepKY0F/U5gMG
 JuLEkx35CqwJZvmHvNvDdHPjWCgf5M7MZvRrDpeuaQcEjk7AyRECS/cG3S8S7ySWayeu
 752mRfTHDlhT29owDgseM7LHUjB93pr0gkfkwRiCrbkQWbV98J0cLkfRRT877YPwnhim
 EAFba7vELVeU8bWHiSqOishzpVX7NVTZpvK5mnJHli06P30MfnFsLazWmKqOW7vSoWuf
 PADqMuf0YAPLSAIOZsrGaEe2TS36/ma27geyJuUlcDqhYHeoZ7Z0/jEb0zTJpmNtKabB
 vhQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHf7YvpEJWje209EFm8ILSlu3d3FFSirshAGxC1Es7jLkb23ipCA4RtcPaKKvJJRe9zpSjMZMt3s9W@nongnu.org
X-Gm-Message-State: AOJu0YyW7fv2PyLpwyF3eNHFhoXC6VxfbGZJt4IjHWlQTY54oQKaePP4
 Ys4aNZt2GQMLMelgA5xsWEOMQ5bP+CL4EIcFdJma5eINCbgKLntPrcG9UDYAt6cqr+XLV2Z5cSw
 QOUSFDm6YTBOBRmL4G8xs7Pd2fbM=
X-Google-Smtp-Source: AGHT+IGiN2cZOm2ng5DYaBlB/kO87lNEeW6xpxxlOl8wEwfbUr5mnihLdXVHe1ALSQzoo6YFsVU6vZT/mG7U9JhfOR0=
X-Received: by 2002:a05:6102:3051:b0:4a3:d4bd:257a with SMTP id
 ada2fe7eead31-4a465a4e8ddmr742847137.23.1728616991626; Thu, 10 Oct 2024
 20:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240925115808.77874-1-cleger@rivosinc.com>
 <20240925115808.77874-4-cleger@rivosinc.com>
In-Reply-To: <20240925115808.77874-4-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 11 Oct 2024 13:22:45 +1000
Message-ID: <CAKmqyKNYJjudgxA6z4dF5AP31NFn3ZOePMadjiVumja29oti5w@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] target/riscv: Implement Ssdbltrp exception handling
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Sep 25, 2024 at 9:59=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> When the Ssdbltrp ISA extension is enabled, if a trap happens in S-mode
> while SSTATUS.SDT isn't cleared, generate a double trap exception to
> M-mode.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  target/riscv/cpu.c        |  2 +-
>  target/riscv/cpu_bits.h   |  1 +
>  target/riscv/cpu_helper.c | 47 ++++++++++++++++++++++++++++++++++-----
>  3 files changed, 43 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index cf06cd741a..65347ccd5a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -284,7 +284,7 @@ static const char * const riscv_excp_names[] =3D {
>      "load_page_fault",
>      "reserved",
>      "store_page_fault",
> -    "reserved",
> +    "double_trap",
>      "reserved",
>      "reserved",
>      "reserved",
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 3a5588d4df..5557a86348 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -699,6 +699,7 @@ typedef enum RISCVException {
>      RISCV_EXCP_INST_PAGE_FAULT =3D 0xc, /* since: priv-1.10.0 */
>      RISCV_EXCP_LOAD_PAGE_FAULT =3D 0xd, /* since: priv-1.10.0 */
>      RISCV_EXCP_STORE_PAGE_FAULT =3D 0xf, /* since: priv-1.10.0 */
> +    RISCV_EXCP_DOUBLE_TRAP =3D 0x10,
>      RISCV_EXCP_SW_CHECK =3D 0x12, /* since: priv-1.13.0 */
>      RISCV_EXCP_HW_ERR =3D 0x13, /* since: priv-1.13.0 */
>      RISCV_EXCP_INST_GUEST_PAGE_FAULT =3D 0x14,
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 395d8235ce..69da3c3384 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -575,7 +575,9 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *en=
v)
>          mstatus_mask |=3D MSTATUS_FS;
>      }
>      bool current_virt =3D env->virt_enabled;
> -
> +    if (riscv_env_smode_dbltrp_enabled(env, current_virt)) {
> +        mstatus_mask |=3D MSTATUS_SDT;
> +    }
>      g_assert(riscv_has_ext(env, RVH));
>
>      if (current_virt) {
> @@ -1707,6 +1709,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      CPURISCVState *env =3D &cpu->env;
>      bool virt =3D env->virt_enabled;
>      bool write_gva =3D false;
> +    bool vsmode_exc;
>      uint64_t s;
>      int mode;
>
> @@ -1721,6 +1724,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          !(env->mip & (1 << cause));
>      bool vs_injected =3D env->hvip & (1 << cause) & env->hvien &&
>          !(env->mip & (1 << cause));
> +    bool smode_double_trap =3D false;
> +    uint64_t hdeleg =3D async ? env->hideleg : env->hedeleg;
>      target_ulong tval =3D 0;
>      target_ulong tinst =3D 0;
>      target_ulong htval =3D 0;
> @@ -1837,13 +1842,35 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>                  !async &&
>                  mode =3D=3D PRV_M;
>
> +    vsmode_exc =3D env->virt_enabled && (((hdeleg >> cause) & 1) || vs_i=
njected);
> +    /*
> +     * Check double trap condition only if already in S-mode and targeti=
ng
> +     * S-mode
> +     */
> +    if (cpu->cfg.ext_ssdbltrp && env->priv =3D=3D PRV_S && mode =3D=3D P=
RV_S) {
> +        bool dte =3D (env->menvcfg & MENVCFG_DTE) !=3D 0;
> +        bool sdt =3D (env->mstatus & MSTATUS_SDT) !=3D 0;
> +        /* In VS or HS */
> +        if (riscv_has_ext(env, RVH)) {
> +            if (vsmode_exc) {
> +                /* VS -> VS */
> +                /* Stay in VS mode, use henvcfg instead of menvcfg*/
> +                dte =3D (env->henvcfg & HENVCFG_DTE) !=3D 0;
> +            } else if (env->virt_enabled) {
> +                /* VS -> HS */
> +                dte =3D false;

I don't follow why this is false

Alistair

