Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75511C30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 01:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOoTK-0002pH-Ll; Tue, 02 Jul 2024 21:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOoTI-0002oj-Im; Tue, 02 Jul 2024 21:07:44 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOoTG-00036N-GZ; Tue, 02 Jul 2024 21:07:44 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4ef33a09a3aso1325429e0c.2; 
 Tue, 02 Jul 2024 18:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719968860; x=1720573660; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yg3kfiBggTDTzZgSdwNpXEYZON26fXN+JA9foYtceZU=;
 b=edqrPhqhRefi3qt/rzhutNCr1yFIl5WBDdazAdMc+88l4tUXI7mz3B9ssERakkW9E9
 GKYhH2sDpLIfeUjjPf8M/4+vsohYQWseV32Y9sl6V6IO4CspA7r7IORlWWyvAJTTirox
 eR6UTawGvTht7Fy0+u4Lac8zP2Cv5CLs+7a92tUaPgW1jsociUappWf9w76r+Z3rL/FX
 7cKE0Cgp/8OH6Ua9xqZLXBWZr9bfSUqwiQrP3ODcEwajx9Hb34uwrjEHDfTPwoUWOrep
 gsItE1TUEjf1Zlc3bwwbEzPPtLqbbePWonRzvk1B3ttSfAvMT0tP/wFyZOvHIcuZFwUb
 aREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719968860; x=1720573660;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yg3kfiBggTDTzZgSdwNpXEYZON26fXN+JA9foYtceZU=;
 b=unqL9UlaTHU9MHnrGcTZvNnaV6sD5DWmDwDHEO74q+9Yg3i1NYfjntaof3Mi2h/wZ2
 hiQsODcZ7ytB0sgnIOdRg7TZjizlWw/edSlauFglRt1r0xrNj7RBYDkqk9YOgRZf86YS
 oRvBcWLdoNlp7ajRLlEc2vhQx52aTVDNS0oe4nZ9Ahuj+o3d9aJbZPtAtWr0h//6zQgk
 0Wj6jCR56y2Y8FJE1S6JWwpDbVzzzZPtLcgASb6EYtsQHD/iQ7XyYuVES9ZeCAp92Wad
 by8rdW96JNomSguN1JtEUseCustBh55JuakaZnrYAg5gaoa68lb9kvPRU1PeRjnrZfrA
 +9lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8dPOUBYpscOwMApXIyvxPIUDwRJnKlvK4N2RQf/i95QSce28GgvOqQD/+HrqIPs4Xq8jhKp+ewwUgs6KvZp0trbzQ+fs=
X-Gm-Message-State: AOJu0YxqkDCEFsSpgd2YqQCddUgEnWi8drWKIOEp1BeKEGkGzE1oUJUf
 HcdwduRgAjP7Gdf29zAdh4sv86DF6I/So5zij2WSBznBQB2X1kucjQ/kgg4MJ4We0sWE1CrrnjF
 2lmJdFUSIYsw1EN+sKPRiJ4+knq4=
X-Google-Smtp-Source: AGHT+IHgnJAmFuVJxDUQl1479HuLlP0S6nsM093bYlYHtv5Kod1HHl55DggWGE6EyXahHyCidWnNWyzzX1wSMmgRc48=
X-Received: by 2002:a05:6122:608a:b0:4ef:27db:d206 with SMTP id
 71dfb90a1353d-4f2a551a34bmr8908410e0c.0.1719968860532; Tue, 02 Jul 2024
 18:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
 <20240626-smcntrpmf_v7-v7-1-bb0f10af7fa9@rivosinc.com>
In-Reply-To: <20240626-smcntrpmf_v7-v7-1-bb0f10af7fa9@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jul 2024 11:07:14 +1000
Message-ID: <CAKmqyKNbFEQ9HrGhBmF_ZUdz_ZkoT04uRGgDHvf0mP7ewdkO9A@mail.gmail.com>
Subject: Re: [PATCH v7 01/11] target/riscv: Combine set_mode and set_virt
 functions.
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Rajnesh Kanwal <rkanwal@rivosinc.com>, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
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

On Thu, Jun 27, 2024 at 10:02=E2=80=AFAM Atish Patra <atishp@rivosinc.com> =
wrote:
>
> From: Rajnesh Kanwal <rkanwal@rivosinc.com>
>
> Combining riscv_cpu_set_virt_enabled() and riscv_cpu_set_mode()
> functions. This is to make complete mode change information
> available through a single function.
>
> This allows to easily differentiate between HS->VS, VS->HS
> and VS->VS transitions when executing state update codes.
> For example: One use-case which inspired this change is
> to update mode-specific instruction and cycle counters
> which requires information of both prev mode and current
> mode.
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        |  2 +-
>  target/riscv/cpu_helper.c | 57 +++++++++++++++++++++++------------------=
------
>  target/riscv/op_helper.c  | 17 +++++---------
>  3 files changed, 35 insertions(+), 41 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 90b8f1b08f83..46faefd24e09 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -544,7 +544,7 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env=
, uint32_t priv,
>  RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t =
bit);
>  #endif /* !CONFIG_USER_ONLY */
>
> -void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
> +void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool v=
irt_en);
>
>  void riscv_translate_init(void);
>  G_NORETURN void riscv_raise_exception(CPURISCVState *env,
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 6709622dd3ab..10d3fdaed376 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -619,30 +619,6 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target=
_ulong geilen)
>      env->geilen =3D geilen;
>  }
>
> -/* This function can only be called to set virt when RVH is enabled */
> -void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
> -{
> -    /* Flush the TLB on all virt mode changes. */
> -    if (env->virt_enabled !=3D enable) {
> -        tlb_flush(env_cpu(env));
> -    }
> -
> -    env->virt_enabled =3D enable;
> -
> -    if (enable) {
> -        /*
> -         * The guest external interrupts from an interrupt controller ar=
e
> -         * delivered only when the Guest/VM is running (i.e. V=3D1). Thi=
s means
> -         * any guest external interrupt which is triggered while the Gue=
st/VM
> -         * is not running (i.e. V=3D0) will be missed on QEMU resulting =
in guest
> -         * with sluggish response to serial console input and other I/O =
events.
> -         *
> -         * To solve this, we check and inject interrupt after setting V=
=3D1.
> -         */
> -        riscv_cpu_update_mip(env, 0, 0);
> -    }
> -}
> -
>  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
>  {
>      CPURISCVState *env =3D &cpu->env;
> @@ -715,7 +691,7 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env=
, uint32_t priv,
>      }
>  }
>
> -void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
> +void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool v=
irt_en)
>  {
>      g_assert(newpriv <=3D PRV_M && newpriv !=3D PRV_RESERVED);
>
> @@ -736,6 +712,28 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_u=
long newpriv)
>       * preemptive context switch. As a result, do both.
>       */
>      env->load_res =3D -1;
> +
> +    if (riscv_has_ext(env, RVH)) {
> +        /* Flush the TLB on all virt mode changes. */
> +        if (env->virt_enabled !=3D virt_en) {
> +            tlb_flush(env_cpu(env));
> +        }
> +
> +        env->virt_enabled =3D virt_en;
> +        if (virt_en) {
> +            /*
> +             * The guest external interrupts from an interrupt controlle=
r are
> +             * delivered only when the Guest/VM is running (i.e. V=3D1).=
 This
> +             * means any guest external interrupt which is triggered whi=
le the
> +             * Guest/VM is not running (i.e. V=3D0) will be missed on QE=
MU
> +             * resulting in guest with sluggish response to serial conso=
le
> +             * input and other I/O events.
> +             *
> +             * To solve this, we check and inject interrupt after settin=
g V=3D1.
> +             */
> +            riscv_cpu_update_mip(env, 0, 0);
> +        }
> +    }
>  }
>
>  /*
> @@ -1648,6 +1646,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
>      CPURISCVState *env =3D &cpu->env;
> +    bool virt =3D env->virt_enabled;
>      bool write_gva =3D false;
>      uint64_t s;
>
> @@ -1778,7 +1777,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>
>                  htval =3D env->guest_phys_fault_addr;
>
> -                riscv_cpu_set_virt_enabled(env, 0);
> +                virt =3D false;
>              } else {
>                  /* Trap into HS mode */
>                  env->hstatus =3D set_field(env->hstatus, HSTATUS_SPV, fa=
lse);
> @@ -1799,7 +1798,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          env->htinst =3D tinst;
>          env->pc =3D (env->stvec >> 2 << 2) +
>                    ((async && (env->stvec & 3) =3D=3D 1) ? cause * 4 : 0)=
;
> -        riscv_cpu_set_mode(env, PRV_S);
> +        riscv_cpu_set_mode(env, PRV_S, virt);
>      } else {
>          /* handle the trap in M-mode */
>          if (riscv_has_ext(env, RVH)) {
> @@ -1815,7 +1814,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>              mtval2 =3D env->guest_phys_fault_addr;
>
>              /* Trapping to M mode, virt is disabled */
> -            riscv_cpu_set_virt_enabled(env, 0);
> +            virt =3D false;
>          }
>
>          s =3D env->mstatus;
> @@ -1830,7 +1829,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          env->mtinst =3D tinst;
>          env->pc =3D (env->mtvec >> 2 << 2) +
>                    ((async && (env->mtvec & 3) =3D=3D 1) ? cause * 4 : 0)=
;
> -        riscv_cpu_set_mode(env, PRV_M);
> +        riscv_cpu_set_mode(env, PRV_M, virt);
>      }
>
>      /*
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 2baf5bc3ca19..ec1408ba0fb1 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -264,7 +264,7 @@ void helper_cbo_inval(CPURISCVState *env, target_ulon=
g address)
>  target_ulong helper_sret(CPURISCVState *env)
>  {
>      uint64_t mstatus;
> -    target_ulong prev_priv, prev_virt;
> +    target_ulong prev_priv, prev_virt =3D env->virt_enabled;
>
>      if (!(env->priv >=3D PRV_S)) {
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> @@ -307,11 +307,9 @@ target_ulong helper_sret(CPURISCVState *env)
>          if (prev_virt) {
>              riscv_cpu_swap_hypervisor_regs(env);
>          }
> -
> -        riscv_cpu_set_virt_enabled(env, prev_virt);
>      }
>
> -    riscv_cpu_set_mode(env, prev_priv);
> +    riscv_cpu_set_mode(env, prev_priv, prev_virt);
>
>      return retpc;
>  }
> @@ -347,16 +345,13 @@ target_ulong helper_mret(CPURISCVState *env)
>          mstatus =3D set_field(mstatus, MSTATUS_MPRV, 0);
>      }
>      env->mstatus =3D mstatus;
> -    riscv_cpu_set_mode(env, prev_priv);
> -
> -    if (riscv_has_ext(env, RVH)) {
> -        if (prev_virt) {
> -            riscv_cpu_swap_hypervisor_regs(env);
> -        }
>
> -        riscv_cpu_set_virt_enabled(env, prev_virt);
> +    if (riscv_has_ext(env, RVH) && prev_virt) {
> +        riscv_cpu_swap_hypervisor_regs(env);
>      }
>
> +    riscv_cpu_set_mode(env, prev_priv, prev_virt);
> +
>      return retpc;
>  }
>
>
> --
> 2.34.1
>
>

