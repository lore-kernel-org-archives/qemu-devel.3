Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB77D3C934
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 01:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2gmi-0006h1-Ew; Sun, 20 Oct 2024 21:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2gmf-0006g9-0H; Sun, 20 Oct 2024 21:00:33 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2gmd-0003Qj-8R; Sun, 20 Oct 2024 21:00:32 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-84fccf51df1so1121932241.2; 
 Sun, 20 Oct 2024 18:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729472429; x=1730077229; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fGk4iztQSO+FnNEbviXgm+1uyz4hzkPEfQoziC92sHk=;
 b=a+kbHUrjFIU00r859FigBqhocrPotWCRR1qNM/dF8WlQbzkYTz5DPV0CfQahqUWZ1C
 JorZSmWij00o9o6PQ6iWe8F96xAaM8zxjP18X7O80DDORbHBHuGNH0meKz+uqohQLXhN
 XMCz2etdmnVZmSEu6WAVqKKIWIjCHXxfe3cXEPbsQp4wNigs0T+aPdRCAXh6SqSUbx40
 WouO0xGvlN6LixfoSAAIkmL/EmfdtpCtkbbDNTX7qSUGXAwQNalxMD8gdT/OOP0oy2Dq
 ctaphyUVpRtQnbL62FFENh6hjrm0u6fSXBHcKL0gkkbVFyx+uHi7pjKyjmw3makQp9Gv
 Cpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729472429; x=1730077229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fGk4iztQSO+FnNEbviXgm+1uyz4hzkPEfQoziC92sHk=;
 b=bmWvZBCpvpm/vUwqJdoa6kRskSETnGk4xsJGo0R2orILbQ52T/+kHZKV56N1J1xteL
 UHNRIvZTiALUhBTOL+KYIDyuTuh9iisDU2mK722cvNKyzR5oCjPF4WrgBqcH8CXmIRAD
 pKhm+oTcBwohVIAH7w1AvUtZ+ys1HUo0KS/Ldk/LXP+TMuQ33AY5Jy4wrFuGLoyzy1mZ
 gQsb3otrnvEM4CU7CkJdZF7kkeds1c92qLJqaWRek8NW0aLSIPrmoU76/DO8WUeLRWdI
 nd7z+TJNlIQURmIsi3omRBxeJTsCYehdKSX30qaxCXKU33yzZdcpVOX+lTbmudBvI2jv
 fHLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOL+1rqbqmtJ8C4wCudbUrpOKV3mWkf/b+aYyxNg8la+MsnMbaK3Ivyfyzw5ECrpJqsIJ8LQqw07bY@nongnu.org
X-Gm-Message-State: AOJu0Yxfx8kdud3bB6CcKWvi7Rq/Po+8Nj8cRMkGAytgc1yACxeVkwAs
 2soF3ECfKeYFWnhkTswkgXn5XiOLgTPW593wXTltkzZAXpG7dbbxnML6hOSqg0oFaJM7jhMUg61
 MJlvnzm0LsWvQojzWAU1uWbRb44c=
X-Google-Smtp-Source: AGHT+IHNhu1cxpVF02QaiP5wrwHuTxqdl7aWISBuzU1CJUXqtX+o/HI35u5GUzGGDA7rKC6KikF+WPnc/2e7d8FOF+g=
X-Received: by 2002:a05:6102:c11:b0:4a3:ddc5:37a4 with SMTP id
 ada2fe7eead31-4a5d6ae08cbmr6871985137.11.1729472429358; Sun, 20 Oct 2024
 18:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241017145226.365825-1-cleger@rivosinc.com>
 <20241017145226.365825-5-cleger@rivosinc.com>
In-Reply-To: <20241017145226.365825-5-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2024 11:00:03 +1000
Message-ID: <CAKmqyKM3vt24S_yZESQp047Ygf9LK69VgTfqbtktu19NHBU_gQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] target/riscv: Implement Ssdbltrp exception handling
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
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

On Fri, Oct 18, 2024 at 12:54=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> When the Ssdbltrp ISA extension is enabled, if a trap happens in S-mode
> while SSTATUS.SDT isn't cleared, generate a double trap exception to
> M-mode.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c        |  2 +-
>  target/riscv/cpu_bits.h   |  1 +
>  target/riscv/cpu_helper.c | 42 ++++++++++++++++++++++++++++++++++-----
>  3 files changed, 39 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index fed64741d1..5224eb356d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -285,7 +285,7 @@ static const char * const riscv_excp_names[] =3D {
>      "load_page_fault",
>      "reserved",
>      "store_page_fault",
> -    "reserved",
> +    "double_trap",
>      "reserved",
>      "reserved",
>      "reserved",
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 08cc5b2e22..0d0f253fcb 100644
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
> index b9f36e8621..623a3abbf7 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1715,6 +1715,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      CPURISCVState *env =3D &cpu->env;
>      bool virt =3D env->virt_enabled;
>      bool write_gva =3D false;
> +    bool vsmode_exc;
>      uint64_t s;
>      int mode;
>
> @@ -1729,6 +1730,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          !(env->mip & (1 << cause));
>      bool vs_injected =3D env->hvip & (1 << cause) & env->hvien &&
>          !(env->mip & (1 << cause));
> +    bool smode_double_trap =3D false;
> +    uint64_t hdeleg =3D async ? env->hideleg : env->hedeleg;
>      target_ulong tval =3D 0;
>      target_ulong tinst =3D 0;
>      target_ulong htval =3D 0;
> @@ -1839,13 +1842,34 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      mode =3D env->priv <=3D PRV_S && cause < 64 &&
>          (((deleg >> cause) & 1) || s_injected || vs_injected) ? PRV_S : =
PRV_M;
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
> +                /* VS -> VS, use henvcfg instead of menvcfg*/
> +                dte =3D (env->henvcfg & HENVCFG_DTE) !=3D 0;
> +            } else if (env->virt_enabled) {
> +                /* VS -> HS, use mstatus_hs */
> +                sdt =3D (env->mstatus_hs & MSTATUS_SDT) !=3D 0;
> +            }
> +        }
> +        smode_double_trap =3D dte && sdt;
> +        if (smode_double_trap) {
> +            mode =3D PRV_M;
> +        }
> +    }
> +
>      if (mode =3D=3D PRV_S) {
>          /* handle the trap in S-mode */
>          if (riscv_has_ext(env, RVH)) {
> -            uint64_t hdeleg =3D async ? env->hideleg : env->hedeleg;
> -
> -            if (env->virt_enabled &&
> -                (((hdeleg >> cause) & 1) || vs_injected)) {
> +            if (vsmode_exc) {
>                  /* Trap to VS mode */
>                  /*
>                   * See if we need to adjust cause. Yes if its VS mode in=
terrupt
> @@ -1878,6 +1902,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          s =3D set_field(s, MSTATUS_SPIE, get_field(s, MSTATUS_SIE));
>          s =3D set_field(s, MSTATUS_SPP, env->priv);
>          s =3D set_field(s, MSTATUS_SIE, 0);
> +        if (riscv_env_smode_dbltrp_enabled(env, virt)) {
> +            s =3D set_field(s, MSTATUS_SDT, 1);
> +        }
>          env->mstatus =3D s;
>          sxlen =3D 16 << riscv_cpu_sxl(env);
>          env->scause =3D cause | ((target_ulong)async << (sxlen - 1));
> @@ -1913,9 +1940,14 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          env->mstatus =3D s;
>          mxlen =3D 16 << riscv_cpu_mxl(env);
>          env->mcause =3D cause | ((target_ulong)async << (mxlen - 1));
> +        if (smode_double_trap) {
> +            env->mtval2 =3D env->mcause;
> +            env->mcause =3D RISCV_EXCP_DOUBLE_TRAP;
> +        } else {
> +            env->mtval2 =3D mtval2;
> +        }
>          env->mepc =3D env->pc;
>          env->mtval =3D tval;
> -        env->mtval2 =3D mtval2;
>          env->mtinst =3D tinst;
>
>          /*
> --
> 2.45.2
>
>

