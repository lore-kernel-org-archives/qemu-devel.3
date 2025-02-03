Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EDCC0218F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 02:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1temYw-0002cn-7w; Sun, 02 Feb 2025 21:51:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1temYt-0002c0-W2; Sun, 02 Feb 2025 21:51:48 -0500
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1temYr-0006QP-43; Sun, 02 Feb 2025 21:51:47 -0500
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-860f0e91121so2762944241.0; 
 Sun, 02 Feb 2025 18:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738551103; x=1739155903; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJ8fsXlKz5N96P8lMsNZ7tIz4QJ8bSKpIHZ1Wg/cNWU=;
 b=QM5DHSjeuCwlqr+6KtEOdwYwdmIiwFOQVZkhLo3kUtIBBjdNV2EGxgYG0u5QsPym5i
 MJi2uyK4B97I6A8yno3ydBnzC4G22fHKrgrH6IRLRzYZG2EOl/fXIHos9VyxkY1mPysW
 u1LZuxm8/n1jdDpnyzp2iBT/wFpbGLmwpQDc8eh1WiEeBx3RTPSn6ZA70DPreGgV0ogM
 qNEdm8OJ4qnqVldir9ikutW8NU0f5EC4mXit8Yj/pgJcvsZqLaNw5RBn3UFujGpDYEu9
 JexaPvyuDtPJU4ue6icb4Rq07slS0jMwi738xi00t/aBNaCSHHDfPFYjcVMXjZGK3aRm
 BHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738551103; x=1739155903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJ8fsXlKz5N96P8lMsNZ7tIz4QJ8bSKpIHZ1Wg/cNWU=;
 b=XNbzNFzW+i+manklYEiwYYlprRZZt1vFSwUavx83OiFIG8RFgtYmGtKEpy8IuymNOG
 J9ZO99RlUBjWczcpvhLtEeWgVXAosjs25SDj0TBMJByNNJtt1M+vwGVuK9WpqzVXcb0g
 k+qbLPybpC/T6Cg8gGM0oMGp5omaWxbquxdc/dyV5QJ9FWUOWW9eqv6Hl5w0wEUm0cMJ
 7roOvAM0xyEOn+Nk7HWUHgcrVEEZAzWH8ITrBRYfpYeKYfbr29Kr77c3PEZhPbHOHykH
 CQFdLDYzpSqrMXMdk4qlufn9KMiiKgF7I+wq6m/w/Sj/I8+rzs0FzpZg2LYrPKPlSbXw
 ng+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv0GbhT+F173jwlDxydYAub0iv316yW1L78yyHBsKuoFX77CNfuHJnCZwuGVFUPE9I5lGfMY15cUcV@nongnu.org
X-Gm-Message-State: AOJu0YzLjks9g1raEToccJ/UVzmOzLEgArfvsts0zSvzN93fSag2NzJe
 yqXAlzO3qi3IpwAf7aAtHlNjkcSOW0cLj0Rpj79imcbr6NtOkXSuxPLrK5GrVeXS4csBbNzG8Vo
 r5M5KE1U7GBkCFHAGT35PfMfIbSg=
X-Gm-Gg: ASbGnctwi7anq+fQorY1SIHYVWKeOsfi6ntanRXj9zmx4+0aZMMIg9hXAupRmbT7KA1
 1x81wYh/rIn3Hq2CGxSNtbVr9l88zlrA8Tsx08MhsBn8j3KYQmstX1CRW3t7AlLIp1Yi1EdzL4B
 lMc+jk3aQAZbd9fVhEChPxEBRCEg==
X-Google-Smtp-Source: AGHT+IHvlSHWFcTTocopRHZJLqQYduupXB1LABI/0fFQkWpMvTZPnvec08KS86R1LEv3kqxWzsLa9o0c1y5bIhCJOdA=
X-Received: by 2002:a05:6102:5798:b0:4b6:99c:dd8f with SMTP id
 ada2fe7eead31-4b9b72169d5mr10822528137.10.1738551103201; Sun, 02 Feb 2025
 18:51:43 -0800 (PST)
MIME-Version: 1.0
References: <20241205-b4-ctr_upstream_v3-v5-0-60b993aa567d@rivosinc.com>
 <20241205-b4-ctr_upstream_v3-v5-4-60b993aa567d@rivosinc.com>
In-Reply-To: <20241205-b4-ctr_upstream_v3-v5-4-60b993aa567d@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Feb 2025 12:51:17 +1000
X-Gm-Features: AWEUYZmb81xEbE0Mu1hklzy_kf1xsEhac4ZXeA_E5RIWLDdH5l82dYi-TIvFzNY
Message-ID: <CAKmqyKNB71fKgYC3QmQTuT7_JjqnOE6S5gNQTOMPu7sYsMmRsg@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] target/riscv: Add support to record CTR entries.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
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

On Thu, Dec 5, 2024 at 9:35=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.com=
> wrote:
>
> This commit adds logic to records CTR entries of different types
> and adds required hooks in TCG and interrupt/Exception logic to
> record events.
>
> This commit also adds support to invoke freeze CTR logic for breakpoint
> exceptions and counter overflow interrupts.
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h                             |   7 +
>  target/riscv/cpu_helper.c                      | 259 +++++++++++++++++++=
++++++
>  target/riscv/helper.h                          |   1 +
>  target/riscv/insn_trans/trans_privileged.c.inc |   2 +
>  target/riscv/insn_trans/trans_rvi.c.inc        |  75 +++++++
>  target/riscv/insn_trans/trans_rvzce.c.inc      |  21 ++
>  target/riscv/op_helper.c                       |  19 ++
>  target/riscv/translate.c                       |  46 +++++
>  8 files changed, 430 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index da14ac2f874b81d3f01bc31b0064d020f2dbdf61..f39ca48d37332c4e5907ca870=
40de420f78df2e4 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -310,6 +310,10 @@ struct CPUArchState {
>      uint32_t sctrstatus;
>      uint64_t vsctrctl;
>
> +    uint64_t ctr_src[16 << SCTRDEPTH_MAX];
> +    uint64_t ctr_dst[16 << SCTRDEPTH_MAX];
> +    uint64_t ctr_data[16 << SCTRDEPTH_MAX];
> +
>      /* Machine and Supervisor interrupt priorities */
>      uint8_t miprio[64];
>      uint8_t siprio[64];
> @@ -607,6 +611,9 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, i=
nt index, uint64_t bit);
>
>  void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool v=
irt_en);
>
> +void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_lon=
g dst,
> +    enum CTRType type, target_ulong prev_priv, bool prev_virt);
> +
>  void riscv_translate_init(void);
>  G_NORETURN void riscv_raise_exception(CPURISCVState *env,
>                                        uint32_t exception, uintptr_t pc);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 0a3ead69eabaf0e395fc7c78868640a4216573ee..dbdad4e29d7de0713f7530c46=
e9fab03d3c459a4 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -771,6 +771,247 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *e=
nv, uint32_t priv,
>      }
>  }
>
> +static void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask,
> +                             bool virt)
> +{
> +    uint64_t ctl =3D virt ? env->vsctrctl : env->mctrctl;
> +
> +    assert((freeze_mask & (~(XCTRCTL_BPFRZ | XCTRCTL_LCOFIFRZ))) =3D=3D =
0);
> +
> +    if (ctl & freeze_mask) {
> +        env->sctrstatus |=3D SCTRSTATUS_FROZEN;
> +    }
> +}
> +
> +static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool virt)
> +{
> +    switch (priv) {
> +    case PRV_M:
> +        return MCTRCTL_M;
> +    case PRV_S:
> +        if (virt) {
> +            return XCTRCTL_S;
> +        }
> +        return XCTRCTL_S;
> +    case PRV_U:
> +        if (virt) {
> +            return XCTRCTL_U;
> +        }
> +        return XCTRCTL_U;
> +    }
> +
> +    g_assert_not_reached();
> +}
> +
> +static uint64_t riscv_ctr_get_control(CPURISCVState *env, target_long pr=
iv,
> +                                      bool virt)
> +{
> +    switch (priv) {
> +    case PRV_M:
> +        return env->mctrctl;
> +    case PRV_S:
> +    case PRV_U:
> +        if (virt) {
> +            return env->vsctrctl;
> +        }
> +        return env->mctrctl;
> +    }
> +
> +    g_assert_not_reached();
> +}
> +
> +/*
> + * This function assumes that src privilege and target privilege are not=
 same
> + * and src privilege is less than target privilege. This includes the vi=
rtual
> + * state as well.
> + */
> +static bool riscv_ctr_check_xte(CPURISCVState *env, target_long src_prv,
> +                                bool src_virt)
> +{
> +    target_long tgt_prv =3D env->priv;
> +    bool res =3D true;
> +
> +    /*
> +     * VS and U mode are same in terms of xTE bits required to record an
> +     * external trap. See 6.1.2. External Traps, table 8 External Trap E=
nable
> +     * Requirements. This changes VS to U to simplify the logic a bit.
> +     */
> +    if (src_virt && src_prv =3D=3D PRV_S) {
> +        src_prv =3D PRV_U;
> +    } else if (env->virt_enabled && tgt_prv =3D=3D PRV_S) {
> +        tgt_prv =3D PRV_U;
> +    }
> +
> +    /* VU mode is an outlier here. */
> +    if (src_virt && src_prv =3D=3D PRV_U) {
> +        res &=3D !!(env->vsctrctl & XCTRCTL_STE);
> +    }
> +
> +    switch (src_prv) {
> +    case PRV_U:
> +        if (tgt_prv =3D=3D PRV_U) {
> +            break;
> +        }
> +        res &=3D !!(env->mctrctl & XCTRCTL_STE);
> +        /* fall-through */
> +    case PRV_S:
> +        if (tgt_prv =3D=3D PRV_S) {
> +            break;
> +        }
> +        res &=3D !!(env->mctrctl & MCTRCTL_MTE);
> +        /* fall-through */
> +    case PRV_M:
> +        break;
> +    }
> +
> +    return res;
> +}
> +
> +/*
> + * Special cases for traps and trap returns:
> + *
> + * 1- Traps, and trap returns, between enabled modes are recorded as nor=
mal.
> + * 2- Traps from an inhibited mode to an enabled mode, and trap returns =
from an
> + * enabled mode back to an inhibited mode, are partially recorded.  In s=
uch
> + * cases, the PC from the inhibited mode (source PC for traps, and targe=
t PC
> + * for trap returns) is 0.
> + *
> + * 3- Trap returns from an inhibited mode to an enabled mode are not rec=
orded.
> + * Traps from an enabled mode to an inhibited mode, known as external tr=
aps,
> + * receive special handling.
> + * By default external traps are not recorded, but a handshake mechanism=
 exists
> + * to allow partial recording.  Software running in the target mode of t=
he trap
> + * can opt-in to allowing CTR to record traps into that mode even when t=
he mode
> + * is inhibited.  The MTE, STE, and VSTE bits allow M-mode, S-mode, and =
VS-mode,
> + * respectively, to opt-in. When an External Trap occurs, and xTE=3D1, s=
uch that
> + * x is the target privilege mode of the trap, will CTR record the trap.=
 In such
> + * cases, the target PC is 0.
> + */
> +/*
> + * CTR arrays are implemented as circular buffers and new entry is store=
d at
> + * sctrstatus.WRPTR, but they are presented to software as moving circul=
ar
> + * buffers. Which means, software get's the illusion that whenever a new=
 entry
> + * is added the whole buffer is moved by one place and the new entry is =
added at
> + * the start keeping new entry at idx 0 and older ones follow.
> + *
> + * Depth =3D 16.
> + *
> + * buffer [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] [F=
]
> + * WRPTR                                   W
> + * entry   7   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8
> + *
> + * When a new entry is added:
> + * buffer [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] [F=
]
> + * WRPTR                                       W
> + * entry   8   7   6   5   4   3   2   1   0   F   E   D   C   B   A   9
> + *
> + * entry here denotes the logical entry number that software can access
> + * using ctrsource, ctrtarget and ctrdata registers. So xiselect 0x200
> + * will return entry 0 i-e buffer[8] and 0x201 will return entry 1 i-e
> + * buffer[7]. Here is how we convert entry to buffer idx.
> + *
> + *    entry =3D isel - CTR_ENTRIES_FIRST;
> + *    idx =3D (sctrstatus.WRPTR - entry - 1) & (depth - 1);
> + */
> +void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_lon=
g dst,
> +    enum CTRType type, target_ulong src_priv, bool src_virt)
> +{
> +    bool tgt_virt =3D env->virt_enabled;
> +    uint64_t src_mask =3D riscv_ctr_priv_to_mask(src_priv, src_virt);
> +    uint64_t tgt_mask =3D riscv_ctr_priv_to_mask(env->priv, tgt_virt);
> +    uint64_t src_ctrl =3D riscv_ctr_get_control(env, src_priv, src_virt)=
;
> +    uint64_t tgt_ctrl =3D riscv_ctr_get_control(env, env->priv, tgt_virt=
);
> +    uint64_t depth, head;
> +    bool ext_trap =3D false;
> +
> +    /*
> +     * Return immediately if both target and src recording is disabled o=
r if
> +     * CTR is in frozen state.
> +     */
> +    if ((!(src_ctrl & src_mask) && !(tgt_ctrl & tgt_mask)) ||
> +        env->sctrstatus & SCTRSTATUS_FROZEN) {
> +        return;
> +    }
> +
> +    /*
> +     * With RAS Emul enabled, only allow Indirect, direct calls, Functio=
n
> +     * returns and Co-routine swap types.
> +     */
> +    if (tgt_ctrl & XCTRCTL_RASEMU &&
> +        type !=3D CTRDATA_TYPE_INDIRECT_CALL &&
> +        type !=3D CTRDATA_TYPE_DIRECT_CALL &&
> +        type !=3D CTRDATA_TYPE_RETURN &&
> +        type !=3D CTRDATA_TYPE_CO_ROUTINE_SWAP) {
> +        return;
> +    }
> +
> +    if (type =3D=3D CTRDATA_TYPE_EXCEPTION || type =3D=3D CTRDATA_TYPE_I=
NTERRUPT) {
> +        /* Case 2 for traps. */
> +        if (!(src_ctrl & src_mask)) {
> +            src =3D 0;
> +        } else if (!(tgt_ctrl & tgt_mask)) {
> +            /* Check if target priv-mode has allowed external trap recor=
ding. */
> +            if (!riscv_ctr_check_xte(env, src_priv, src_virt)) {
> +                return;
> +            }
> +
> +            ext_trap =3D true;
> +            dst =3D 0;
> +        }
> +    } else if (type =3D=3D CTRDATA_TYPE_EXCEP_INT_RET) {
> +        /*
> +         * Case 3 for trap returns.  Trap returns from inhibited mode ar=
e not
> +         * recorded.
> +         */
> +        if (!(src_ctrl & src_mask)) {
> +            return;
> +        }
> +
> +        /* Case 2 for trap returns. */
> +        if (!(tgt_ctrl & tgt_mask)) {
> +            dst =3D 0;
> +        }
> +    }
> +
> +    /* Ignore filters in case of RASEMU mode or External trap. */
> +    if (!(tgt_ctrl & XCTRCTL_RASEMU) && !ext_trap) {
> +        /*
> +         * Check if the specific type is inhibited. Not taken branch fil=
ter is
> +         * an enable bit and needs to be checked separatly.
> +         */
> +        bool check =3D tgt_ctrl & BIT_ULL(type + XCTRCTL_INH_START);
> +        if ((type =3D=3D CTRDATA_TYPE_NONTAKEN_BRANCH && !check) ||
> +            (type !=3D CTRDATA_TYPE_NONTAKEN_BRANCH && check)) {
> +            return;
> +        }
> +    }
> +
> +    head =3D get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
> +
> +    depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
> +    if (tgt_ctrl & XCTRCTL_RASEMU && type =3D=3D CTRDATA_TYPE_RETURN) {
> +        head =3D (head - 1) & (depth - 1);
> +
> +        env->ctr_src[head] &=3D ~CTRSOURCE_VALID;
> +        env->sctrstatus =3D
> +            set_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK, head);
> +        return;
> +    }
> +
> +    /* In case of Co-routine SWAP we overwrite latest entry. */
> +    if (tgt_ctrl & XCTRCTL_RASEMU && type =3D=3D CTRDATA_TYPE_CO_ROUTINE=
_SWAP) {
> +        head =3D (head - 1) & (depth - 1);
> +    }
> +
> +    env->ctr_src[head] =3D src | CTRSOURCE_VALID;
> +    env->ctr_dst[head] =3D dst & ~CTRTARGET_MISP;
> +    env->ctr_data[head] =3D set_field(0, CTRDATA_TYPE_MASK, type);
> +
> +    head =3D (head + 1) & (depth - 1);
> +
> +    env->sctrstatus =3D set_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK=
, head);
> +}
> +
>  void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool v=
irt_en)
>  {
>      g_assert(newpriv <=3D PRV_M && newpriv !=3D PRV_RESERVED);
> @@ -1806,10 +2047,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          !(env->mip & (1 << cause));
>      bool vs_injected =3D env->hvip & (1 << cause) & env->hvien &&
>          !(env->mip & (1 << cause));
> +    const bool prev_virt =3D env->virt_enabled;
> +    const target_ulong prev_priv =3D env->priv;
>      target_ulong tval =3D 0;
>      target_ulong tinst =3D 0;
>      target_ulong htval =3D 0;
>      target_ulong mtval2 =3D 0;
> +    target_ulong src;
>      int sxlen =3D 0;
>      int mxlen =3D 0;
>
> @@ -1960,6 +2204,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          env->pc =3D (env->stvec >> 2 << 2) +
>                    ((async && (env->stvec & 3) =3D=3D 1) ? cause * 4 : 0)=
;
>          riscv_cpu_set_mode(env, PRV_S, virt);
> +
> +        src =3D env->sepc;
>      } else {
>          /* handle the trap in M-mode */
>          /* save elp status */
> @@ -1997,6 +2243,19 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          env->pc =3D (env->mtvec >> 2 << 2) +
>                    ((async && (env->mtvec & 3) =3D=3D 1) ? cause * 4 : 0)=
;
>          riscv_cpu_set_mode(env, PRV_M, virt);
> +        src =3D env->mepc;
> +    }
> +
> +    if (riscv_cpu_cfg(env)->ext_smctr || riscv_cpu_cfg(env)->ext_ssctr) =
{
> +        if (async && cause =3D=3D IRQ_PMU_OVF) {
> +            riscv_ctr_freeze(env, XCTRCTL_LCOFIFRZ, virt);
> +        } else if (!async && cause =3D=3D RISCV_EXCP_BREAKPOINT) {
> +            riscv_ctr_freeze(env, XCTRCTL_BPFRZ, virt);
> +        }
> +
> +        riscv_ctr_add_entry(env, src, env->pc,
> +                        async ? CTRDATA_TYPE_INTERRUPT : CTRDATA_TYPE_EX=
CEPTION,
> +                        prev_priv, prev_virt);
>      }
>
>      /*
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 451261ce5a4f6138a06afb1e4abc0c838acb283e..820ddccf92ab07cbe80ae03b3=
d2d2ccc4f8e4765 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -135,6 +135,7 @@ DEF_HELPER_1(wfi, void, env)
>  DEF_HELPER_1(wrs_nto, void, env)
>  DEF_HELPER_1(tlb_flush, void, env)
>  DEF_HELPER_1(tlb_flush_all, void, env)
> +DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
>  /* Native Debug */
>  DEF_HELPER_1(itrigger_match, void, env)
>  #endif
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/risc=
v/insn_trans/trans_privileged.c.inc
> index 0bdfa9a0ed3313223ce9032fb24484c3887cddf9..b19d692c22dc74c41df72dae9=
9448c37a0216980 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -80,6 +80,7 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
>      if (has_ext(ctx, RVS)) {
>          decode_save_opc(ctx, 0);
>          translator_io_start(&ctx->base);
> +        gen_update_pc(ctx, 0);
>          gen_helper_sret(cpu_pc, tcg_env);
>          exit_tb(ctx); /* no chaining */
>          ctx->base.is_jmp =3D DISAS_NORETURN;
> @@ -97,6 +98,7 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
>  #ifndef CONFIG_USER_ONLY
>      decode_save_opc(ctx, 0);
>      translator_io_start(&ctx->base);
> +    gen_update_pc(ctx, 0);
>      gen_helper_mret(cpu_pc, tcg_env);
>      exit_tb(ctx); /* no chaining */
>      ctx->base.is_jmp =3D DISAS_NORETURN;
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index 96c218a9d7875c6419287ac3aa9746251be3f442..b55f56a5eb2c72eee004e1681=
7a6df13c60446de 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -93,6 +93,51 @@ static bool trans_jal(DisasContext *ctx, arg_jal *a)
>      return true;
>  }
>
> +#ifndef CONFIG_USER_ONLY
> +/*
> + * Indirect calls
> + * - jalr x1, rs where rs !=3D x5;
> + * - jalr x5, rs where rs !=3D x1;
> + * - c.jalr rs1 where rs1 !=3D x5;
> + *
> + * Indirect jumps
> + * - jalr x0, rs where rs !=3D x1 and rs !=3D x5;
> + * - c.jr rs1 where rs1 !=3D x1 and rs1 !=3D x5.
> + *
> + * Returns
> + * - jalr rd, rs where (rs =3D=3D x1 or rs =3D=3D x5) and rd !=3D x1 and=
 rd !=3D x5;
> + * - c.jr rs1 where rs1 =3D=3D x1 or rs1 =3D=3D x5.
> + *
> + * Co-routine swap
> + * - jalr x1, x5;
> + * - jalr x5, x1;
> + * - c.jalr x5.
> + *
> + * Other indirect jumps
> + * - jalr rd, rs where rs !=3D x1, rs !=3D x5, rd !=3D x0, rd !=3D x1 an=
d rd !=3D x5.
> + */
> +static void gen_ctr_jalr(DisasContext *ctx, arg_jalr *a, TCGv dest)
> +{
> +    TCGv src =3D tcg_temp_new();
> +    TCGv type;
> +
> +    if ((a->rd =3D=3D 1 && a->rs1 !=3D 5) || (a->rd =3D=3D 5 && a->rs1 !=
=3D 1)) {
> +        type =3D tcg_constant_tl(CTRDATA_TYPE_INDIRECT_CALL);
> +    } else if (a->rd =3D=3D 0 && a->rs1 !=3D 1 && a->rs1 !=3D 5) {
> +        type =3D tcg_constant_tl(CTRDATA_TYPE_INDIRECT_JUMP);
> +    } else if ((a->rs1 =3D=3D 1 || a->rs1 =3D=3D 5) && (a->rd !=3D 1 && =
a->rd !=3D 5)) {
> +        type =3D tcg_constant_tl(CTRDATA_TYPE_RETURN);
> +    } else if ((a->rs1 =3D=3D 1 && a->rd =3D=3D 5) || (a->rs1 =3D=3D 5 &=
& a->rd =3D=3D 1)) {
> +        type =3D tcg_constant_tl(CTRDATA_TYPE_CO_ROUTINE_SWAP);
> +    } else {
> +        type =3D tcg_constant_tl(CTRDATA_TYPE_OTHER_INDIRECT_JUMP);
> +    }
> +
> +    gen_pc_plus_diff(src, ctx, 0);
> +    gen_helper_ctr_add_entry(tcg_env, src, dest, type);
> +}
> +#endif
> +
>  static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
>  {
>      TCGLabel *misaligned =3D NULL;
> @@ -117,6 +162,12 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *=
a)
>      gen_pc_plus_diff(succ_pc, ctx, ctx->cur_insn_len);
>      gen_set_gpr(ctx, a->rd, succ_pc);
>
> +#ifndef CONFIG_USER_ONLY
> +    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> +        gen_ctr_jalr(ctx, a, target_pc);
> +    }
> +#endif
> +
>      tcg_gen_mov_tl(cpu_pc, target_pc);
>      if (ctx->fcfi_enabled) {
>          /*
> @@ -231,6 +282,19 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, =
TCGCond cond)
>      } else {
>          tcg_gen_brcond_tl(cond, src1, src2, l);
>      }
> +
> +#ifndef CONFIG_USER_ONLY
> +    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> +        TCGv type =3D tcg_constant_tl(CTRDATA_TYPE_NONTAKEN_BRANCH);
> +        TCGv dest =3D tcg_temp_new();
> +        TCGv src =3D tcg_temp_new();
> +
> +        gen_pc_plus_diff(src, ctx, 0);
> +        gen_pc_plus_diff(dest, ctx, ctx->cur_insn_len);
> +        gen_helper_ctr_add_entry(tcg_env, src, dest, type);
> +    }
> +#endif
> +
>      gen_goto_tb(ctx, 1, ctx->cur_insn_len);
>      ctx->pc_save =3D orig_pc_save;
>
> @@ -243,6 +307,17 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, =
TCGCond cond)
>          gen_pc_plus_diff(target_pc, ctx, a->imm);
>          gen_exception_inst_addr_mis(ctx, target_pc);
>      } else {
> +#ifndef CONFIG_USER_ONLY
> +        if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> +            TCGv type =3D tcg_constant_tl(CTRDATA_TYPE_TAKEN_BRANCH);
> +            TCGv dest =3D tcg_temp_new();
> +            TCGv src =3D tcg_temp_new();
> +
> +            gen_pc_plus_diff(src, ctx, 0);
> +            gen_pc_plus_diff(dest, ctx, a->imm);
> +            gen_helper_ctr_add_entry(tcg_env, src, dest, type);
> +        }
> +#endif
>          gen_goto_tb(ctx, 0, a->imm);
>      }
>      ctx->pc_save =3D -1;
> diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/ins=
n_trans/trans_rvzce.c.inc
> index cd234ad960724c936b92afb6fd1f3c7c2a37cb80..c77c2b927b0cfdf7d21dca765=
7712015494e1b46 100644
> --- a/target/riscv/insn_trans/trans_rvzce.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzce.c.inc
> @@ -203,6 +203,14 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, =
bool ret, bool ret_val)
>
>      if (ret) {
>          TCGv ret_addr =3D get_gpr(ctx, xRA, EXT_SIGN);
> +#ifndef CONFIG_USER_ONLY
> +        if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> +            TCGv type =3D tcg_constant_tl(CTRDATA_TYPE_RETURN);
> +            TCGv src =3D tcg_temp_new();
> +            gen_pc_plus_diff(src, ctx, 0);
> +            gen_helper_ctr_add_entry(tcg_env, src, ret_addr, type);
> +        }
> +#endif
>          tcg_gen_mov_tl(cpu_pc, ret_addr);
>          tcg_gen_lookup_and_goto_ptr();
>          ctx->base.is_jmp =3D DISAS_NORETURN;
> @@ -309,6 +317,19 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_cm_=
jalt *a)
>          gen_set_gpr(ctx, xRA, succ_pc);
>      }
>
> +#ifndef CONFIG_USER_ONLY
> +    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> +        if (a->index >=3D 32) {
> +            TCGv type =3D tcg_constant_tl(CTRDATA_TYPE_DIRECT_CALL);
> +            gen_helper_ctr_add_entry(tcg_env, cpu_pc, addr, type);
> +        } else {
> +            TCGv type =3D tcg_constant_tl(CTRDATA_TYPE_DIRECT_JUMP);
> +            gen_helper_ctr_add_entry(tcg_env, cpu_pc, addr, type);
> +        }
> +    }
> +#endif
> +
> +
>      tcg_gen_mov_tl(cpu_pc, addr);
>
>      tcg_gen_lookup_and_goto_ptr();
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index eddedacf4b4f191127b6378d4c2dbfd747123f9e..0684a27bfdb72f6fc5945f305=
00c2e3a95e85e2f 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -263,6 +263,8 @@ target_ulong helper_sret(CPURISCVState *env)
>  {
>      uint64_t mstatus;
>      target_ulong prev_priv, prev_virt =3D env->virt_enabled;
> +    const target_ulong src_priv =3D env->priv;
> +    const bool src_virt =3D env->virt_enabled;
>
>      if (!(env->priv >=3D PRV_S)) {
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> @@ -318,6 +320,11 @@ target_ulong helper_sret(CPURISCVState *env)
>      }
>      env->mstatus =3D set_field(env->mstatus, MSTATUS_SPELP, 0);
>
> +    if (riscv_cpu_cfg(env)->ext_smctr || riscv_cpu_cfg(env)->ext_ssctr) =
{
> +        riscv_ctr_add_entry(env, env->pc, retpc, CTRDATA_TYPE_EXCEP_INT_=
RET,
> +                            src_priv, src_virt);
> +    }
> +
>      return retpc;
>  }
>
> @@ -367,9 +374,21 @@ target_ulong helper_mret(CPURISCVState *env)
>      }
>      env->mstatus =3D set_field(env->mstatus, MSTATUS_MPELP, 0);
>
> +    if (riscv_cpu_cfg(env)->ext_smctr || riscv_cpu_cfg(env)->ext_ssctr) =
{
> +        riscv_ctr_add_entry(env, env->pc, retpc, CTRDATA_TYPE_EXCEP_INT_=
RET,
> +                            PRV_M, false);
> +    }
> +
>      return retpc;
>  }
>
> +void helper_ctr_add_entry(CPURISCVState *env, target_ulong src,
> +                          target_ulong dest, target_ulong type)
> +{
> +    riscv_ctr_add_entry(env, src, dest, (enum CTRType)type,
> +                        env->priv, env->virt_enabled);
> +}
> +
>  void helper_wfi(CPURISCVState *env)
>  {
>      CPUState *cs =3D env_cpu(env);
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index bccaf8e89a650fdc08e866f2edc4f22910e6c328..b235898b4d922033748a41a98=
5ea7f905f3d02be 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -563,6 +563,46 @@ static void gen_set_fpr_d(DisasContext *ctx, int reg=
_num, TCGv_i64 t)
>      }
>  }
>
> +#ifndef CONFIG_USER_ONLY
> +/*
> + * Direct calls
> + * - jal x1;
> + * - jal x5;
> + * - c.jal.
> + * - cm.jalt.
> + *
> + * Direct jumps
> + * - jal x0;
> + * - c.j;
> + * - cm.jt.
> + *
> + * Other direct jumps
> + * - jal rd where rd !=3D x1 and rd !=3D x5 and rd !=3D x0;
> + */
> +static void gen_ctr_jal(DisasContext *ctx, int rd, target_ulong imm)
> +{
> +    TCGv dest =3D tcg_temp_new();
> +    TCGv src =3D tcg_temp_new();
> +    TCGv type;
> +
> +    /*
> +     * If rd is x1 or x5 link registers, treat this as direct call other=
wise
> +     * its a direct jump.
> +     */
> +    if (rd =3D=3D 1 || rd =3D=3D 5) {
> +        type =3D tcg_constant_tl(CTRDATA_TYPE_DIRECT_CALL);
> +    } else if (rd =3D=3D 0) {
> +        type =3D tcg_constant_tl(CTRDATA_TYPE_DIRECT_JUMP);
> +    } else {
> +        type =3D tcg_constant_tl(CTRDATA_TYPE_OTHER_DIRECT_JUMP);
> +    }
> +
> +    gen_pc_plus_diff(dest, ctx, imm);
> +    gen_pc_plus_diff(src, ctx, 0);
> +    gen_helper_ctr_add_entry(tcg_env, src, dest, type);
> +}
> +#endif
> +
>  static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
>  {
>      TCGv succ_pc =3D dest_gpr(ctx, rd);
> @@ -577,6 +617,12 @@ static void gen_jal(DisasContext *ctx, int rd, targe=
t_ulong imm)
>          }
>      }
>
> +#ifndef CONFIG_USER_ONLY
> +    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> +        gen_ctr_jal(ctx, rd, imm);
> +    }
> +#endif
> +
>      gen_pc_plus_diff(succ_pc, ctx, ctx->cur_insn_len);
>      gen_set_gpr(ctx, rd, succ_pc);
>
>
> --
> 2.34.1
>
>

