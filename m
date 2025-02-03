Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617D6C0218F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 02:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1temfJ-0004Gk-3R; Sun, 02 Feb 2025 21:58:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1temfH-0004GS-LM; Sun, 02 Feb 2025 21:58:23 -0500
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1temfF-0007nH-BL; Sun, 02 Feb 2025 21:58:23 -0500
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-518954032b2so1170297e0c.0; 
 Sun, 02 Feb 2025 18:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738551500; x=1739156300; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QE3LyFqIRHwsiEWt7keCQNUZr2TRYY/gU6mh5Z1+0T0=;
 b=ETG64zdtt69jmruAgSDrt4WoNMHLfIZzLdDsr9ilrqyhK+2rdFjuLHoJ1vRjW2ClGA
 7dazR6ogFMrB240v4L6J6iy6QfcZEX8M4LnbNrP0acnqPChUSuWa/TTj9B06V8HvfZTu
 O1Rq5BZE1aHIwR+LsQSc6GrdmfFnyarP/CyC/759ddCJg3t6RKLp7yNnl3kcEbBBo+ZY
 82XPDQD4KdjcgUKAYRcyaUw/fnZPxy58iuV09t26pxexUYCKNRWYcFpqnAh1rnoMGeM+
 qVu7pqMs5LVKy7HxYsWzOkBi/kkpyN/oyyYdHnv2pnCZKYMBZp5oGg4KivhzSO7usnAO
 gpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738551500; x=1739156300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QE3LyFqIRHwsiEWt7keCQNUZr2TRYY/gU6mh5Z1+0T0=;
 b=V3T5n4RywrGQtvz0AQ6UV/wxy7C8gYkh840BQZDCUGy/t3j0lcvq5XPe0gi8GnCZr2
 H0k5JhEYrL6jiRvKAPfoBk5FBk8qtIbbfPjeO6wl5AvqWCt5WDYheVsGyXXWUoCo2So+
 YxcaTy/mOdwFTt8P8yKvps8/B5WHCTddMAuZ2TKmO/hZwy2agmesyQ4uwccnxPNtgfpn
 V3tgliPNZS+o7mObR98+yTR4OwnZ3KhuxvgZ22vABJgMnnxOBZqpkGVtiM6dqQBOyUGy
 wmODjHiDPMrtwps47Pd5Tzkver8mclexQ9yAYkLlvUDYKnQ6zsYNyDqKwu5wYVJv23M8
 h3qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdBzMrPgwXbL9X6LGXH8ND2qaAjoqW4aNhsb5kS2YYpUXxusOHal/Ey4/5IKU7eNEuuiN3gPDJtYtQ@nongnu.org
X-Gm-Message-State: AOJu0Yy+QBENnKtJIi9PUGWCjPB46+fk/3wQ2HNE5VXeNA8H1Ymjx2Uk
 GCzvWVRTTUwiUjIoNdwQ24jNv7/K+QsONE6HIgFKUBMdU/f4y7cSKCO6UhlScRlARfbxCCpsMyW
 FIfn/sFkTHZ5RC9Vu1qvqYOWFuXE=
X-Gm-Gg: ASbGncsB7n1TBGosntG0zgI1swnXU1GoWpiTQmEinnbHztDtRZCgSWT6WPGDfA4v7yJ
 iWuJdfMEvTxiRnHUBe4X0naaRbEXRusZ7C6AgSHNeSHk0fzj20ZMXOxhDielOet2XmOjQOPyynx
 iVRPLYVUjCF8ucE3M0dXPKTTK0LQ==
X-Google-Smtp-Source: AGHT+IEbIgjhmsJXnOPS8W82sclKOYddAyuiktrCdyn4wrOF5l+Vmx19/5maUD3lJtU6aAlBZHc+qwWOwO73OupnhEI=
X-Received: by 2002:a05:6122:8296:b0:517:4d53:4272 with SMTP id
 71dfb90a1353d-51e9e4e8735mr15678687e0c.7.1738551499773; Sun, 02 Feb 2025
 18:58:19 -0800 (PST)
MIME-Version: 1.0
References: <20241205-b4-ctr_upstream_v3-v5-0-60b993aa567d@rivosinc.com>
 <20241205-b4-ctr_upstream_v3-v5-6-60b993aa567d@rivosinc.com>
In-Reply-To: <20241205-b4-ctr_upstream_v3-v5-6-60b993aa567d@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Feb 2025 12:57:53 +1000
X-Gm-Features: AWEUYZnQ1QEp9s81SLucCSjQPfBu2TjclTf5lxvpAuY7My6hPTP5DXFg-lp0ytc
Message-ID: <CAKmqyKM1hnbUhVwZeKa6Qrsk0tQdF5=D50gsDMk9TUNjJJUHkg@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] target/riscv: Add support to access ctrsource,
 ctrtarget, ctrdata regs.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
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

On Thu, Dec 5, 2024 at 9:36=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.com=
> wrote:
>
> CTR entries are accessed using ctrsource, ctrtarget and ctrdata
> registers using smcsrind/sscsrind extension. This commits extends
> the csrind extension to support CTR registers.
>
> ctrsource is accessible through xireg CSR, ctrtarget is accessible
> through xireg1 and ctrdata is accessible through xireg2 CSR.
>
> CTR supports maximum depth of 256 entries which are accessed using
> xiselect range 0x200 to 0x2ff.
>
> This commits also adds properties to enable CTR extension. CTR can be
> enabled using smctr=3Dtrue and ssctr=3Dtrue now.
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
>  target/riscv/cpu.c         |  26 +++++++-
>  target/riscv/csr.c         | 150 +++++++++++++++++++++++++++++++++++++++=
+++++-
>  target/riscv/tcg/tcg-cpu.c |  11 ++++
>  3 files changed, 185 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2a4f285a974ffc62e7f3e938691dbffe376a7e46..751029e924d4690aaa5de6545=
6fd5a5ec25b916a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -199,6 +199,8 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
> +    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
> +    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
>      ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
>      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>      ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
> @@ -1481,6 +1483,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
>      MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
>      MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
> +    MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
> +    MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),

This should be the very last patch (once everything is supported)

Otherwise

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>      MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
>      MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
>      MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
> @@ -2656,6 +2660,26 @@ static RISCVCPUImpliedExtsRule SSCFG_IMPLIED =3D {
>      },
>  };
>
> +static RISCVCPUImpliedExtsRule SMCTR_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_smctr),
> +    .implied_misa_exts =3D RVS,
> +    .implied_multi_exts =3D {
> +        CPU_CFG_OFFSET(ext_sscsrind),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule SSCTR_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_ssctr),
> +    .implied_misa_exts =3D RVS,
> +    .implied_multi_exts =3D {
> +        CPU_CFG_OFFSET(ext_sscsrind),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] =3D {
>      &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
>      &RVM_IMPLIED, &RVV_IMPLIED, NULL
> @@ -2674,7 +2698,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_ru=
les[] =3D {
>      &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
>      &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
>      &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
> -    NULL
> +    &SMCTR_IMPLIED, &SSCTR_IMPLIED, NULL
>  };
>
>  static Property riscv_cpu_properties[] =3D {
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index a399d55740c7259cd1c1d893687541e23ea3ce52..d7b520099563d3a680c5b75dc=
987881caab95407 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2399,6 +2399,13 @@ static bool xiselect_cd_range(target_ulong isel)
>      return (ISELECT_CD_FIRST <=3D isel && isel <=3D ISELECT_CD_LAST);
>  }
>
> +static bool xiselect_ctr_range(int csrno, target_ulong isel)
> +{
> +    /* MIREG-MIREG6 for the range 0x200-0x2ff are not used by CTR. */
> +    return CTR_ENTRIES_FIRST <=3D isel && isel <=3D CTR_ENTRIES_LAST &&
> +           csrno < CSR_MIREG;
> +}
> +
>  static int rmw_iprio(target_ulong xlen,
>                       target_ulong iselect, uint8_t *iprio,
>                       target_ulong *val, target_ulong new_val,
> @@ -2444,6 +2451,124 @@ static int rmw_iprio(target_ulong xlen,
>      return 0;
>  }
>
> +static int rmw_ctrsource(CPURISCVState *env, int isel, target_ulong *val=
,
> +                          target_ulong new_val, target_ulong wr_mask)
> +{
> +    /*
> +     * CTR arrays are treated as circular buffers and TOS always points =
to next
> +     * empty slot, keeping TOS - 1 always pointing to latest entry. Give=
n entry
> +     * 0 is always the latest one, traversal is a bit different here. Se=
e the
> +     * below example.
> +     *
> +     * Depth =3D 16.
> +     *
> +     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E=
] [F]
> +     * TOS                                 H
> +     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8=
   7
> +     */
> +    const uint64_t entry =3D isel - CTR_ENTRIES_FIRST;
> +    const uint64_t depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH_M=
ASK);
> +    uint64_t idx;
> +
> +    /* Entry greater than depth-1 is read-only zero */
> +    if (entry >=3D depth) {
> +        if (val) {
> +            *val =3D 0;
> +        }
> +        return 0;
> +    }
> +
> +    idx =3D get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
> +    idx =3D (idx - entry - 1) & (depth - 1);
> +
> +    if (val) {
> +        *val =3D env->ctr_src[idx];
> +    }
> +
> +    env->ctr_src[idx] =3D (env->ctr_src[idx] & ~wr_mask) | (new_val & wr=
_mask);
> +
> +    return 0;
> +}
> +
> +static int rmw_ctrtarget(CPURISCVState *env, int isel, target_ulong *val=
,
> +                          target_ulong new_val, target_ulong wr_mask)
> +{
> +    /*
> +     * CTR arrays are treated as circular buffers and TOS always points =
to next
> +     * empty slot, keeping TOS - 1 always pointing to latest entry. Give=
n entry
> +     * 0 is always the latest one, traversal is a bit different here. Se=
e the
> +     * below example.
> +     *
> +     * Depth =3D 16.
> +     *
> +     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E=
] [F]
> +     * head                                H
> +     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8=
   7
> +     */
> +    const uint64_t entry =3D isel - CTR_ENTRIES_FIRST;
> +    const uint64_t depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH_M=
ASK);
> +    uint64_t idx;
> +
> +    /* Entry greater than depth-1 is read-only zero */
> +    if (entry >=3D depth) {
> +        if (val) {
> +            *val =3D 0;
> +        }
> +        return 0;
> +    }
> +
> +    idx =3D get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
> +    idx =3D (idx - entry - 1) & (depth - 1);
> +
> +    if (val) {
> +        *val =3D env->ctr_dst[idx];
> +    }
> +
> +    env->ctr_dst[idx] =3D (env->ctr_dst[idx] & ~wr_mask) | (new_val & wr=
_mask);
> +
> +    return 0;
> +}
> +
> +static int rmw_ctrdata(CPURISCVState *env, int isel, target_ulong *val,
> +                        target_ulong new_val, target_ulong wr_mask)
> +{
> +    /*
> +     * CTR arrays are treated as circular buffers and TOS always points =
to next
> +     * empty slot, keeping TOS - 1 always pointing to latest entry. Give=
n entry
> +     * 0 is always the latest one, traversal is a bit different here. Se=
e the
> +     * below example.
> +     *
> +     * Depth =3D 16.
> +     *
> +     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E=
] [F]
> +     * head                                H
> +     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8=
   7
> +     */
> +    const uint64_t entry =3D isel - CTR_ENTRIES_FIRST;
> +    const uint64_t mask =3D wr_mask & CTRDATA_MASK;
> +    const uint64_t depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH_M=
ASK);
> +    uint64_t idx;
> +
> +    /* Entry greater than depth-1 is read-only zero */
> +    if (entry >=3D depth) {
> +        if (val) {
> +            *val =3D 0;
> +        }
> +        return 0;
> +    }
> +
> +    idx =3D get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
> +    idx =3D (idx - entry - 1) & (depth - 1);
> +
> +    if (val) {
> +        *val =3D env->ctr_data[idx];
> +    }
> +
> +    env->ctr_data[idx] =3D (env->ctr_data[idx] & ~mask) | (new_val & mas=
k);
> +
> +    return 0;
> +}
> +
>  static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
>                           target_ulong isel, target_ulong *val,
>                           target_ulong new_val, target_ulong wr_mask)
> @@ -2596,6 +2721,27 @@ done:
>      return ret;
>  }
>
> +static int rmw_xireg_ctr(CPURISCVState *env, int csrno,
> +                        target_ulong isel, target_ulong *val,
> +                        target_ulong new_val, target_ulong wr_mask)
> +{
> +    if (!riscv_cpu_cfg(env)->ext_smctr && !riscv_cpu_cfg(env)->ext_ssctr=
) {
> +        return -EINVAL;
> +    }
> +
> +    if (csrno =3D=3D CSR_SIREG || csrno =3D=3D CSR_VSIREG) {
> +        return rmw_ctrsource(env, isel, val, new_val, wr_mask);
> +    } else if (csrno =3D=3D CSR_SIREG2 || csrno =3D=3D CSR_VSIREG2) {
> +        return rmw_ctrtarget(env, isel, val, new_val, wr_mask);
> +    } else if (csrno =3D=3D CSR_SIREG3 || csrno =3D=3D CSR_VSIREG3) {
> +        return rmw_ctrdata(env, isel, val, new_val, wr_mask);
> +    } else if (val) {
> +        *val =3D 0;
> +    }
> +
> +    return 0;
> +}
> +
>  /*
>   * rmw_xireg_csrind: Perform indirect access to xireg and xireg2-xireg6
>   *
> @@ -2607,11 +2753,13 @@ static int rmw_xireg_csrind(CPURISCVState *env, i=
nt csrno,
>                                target_ulong isel, target_ulong *val,
>                                target_ulong new_val, target_ulong wr_mask=
)
>  {
> -    int ret =3D -EINVAL;
>      bool virt =3D csrno =3D=3D CSR_VSIREG ? true : false;
> +    int ret =3D -EINVAL;
>
>      if (xiselect_cd_range(isel)) {
>          ret =3D rmw_xireg_cd(env, csrno, isel, val, new_val, wr_mask);
> +    } else if (xiselect_ctr_range(csrno, isel)) {
> +        ret =3D rmw_xireg_ctr(env, csrno, isel, val, new_val, wr_mask);
>      } else {
>          /*
>           * As per the specification, access to unimplented region is und=
efined
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 2b57aa4d1704b176f314dbe0b120cfcc943bf4f8..575b5692c7f68a5f6d37edbc1=
7269e41f496f682 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -652,6 +652,17 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          return;
>      }
>
> +    if ((cpu->cfg.ext_smctr || cpu->cfg.ext_ssctr) &&
> +        (!riscv_has_ext(env, RVS) || !cpu->cfg.ext_sscsrind)) {
> +        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_smctr)) ||
> +            cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_ssctr))) {
> +            error_setg(errp, "Smctr and Ssctr require S-mode and Sscsrin=
d");
> +            return;
> +        }
> +        cpu->cfg.ext_smctr =3D false;
> +        cpu->cfg.ext_ssctr =3D false;
> +    }
> +
>      /*
>       * Disable isa extensions based on priv spec after we
>       * validated and set everything we need.
>
> --
> 2.34.1
>
>

