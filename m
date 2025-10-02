Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CC1CAC5BB
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 01:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v48aL-0003nD-DY; Wed, 01 Oct 2025 21:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v48aI-0003kq-Cs
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 21:58:18 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v48a2-0003Cu-2n
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 21:58:16 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b2e0513433bso82892866b.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 18:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759370267; x=1759975067; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYxzDr17ex1ArKRcKaJaschHglNbzUH5EYSWgfIQN1g=;
 b=Q7EGxfmNhqogw6qDcsIulY9SiTQ2eo7NdTS71X9fIR97OPFMMVyWmlxbnyTiC6Bk1P
 7a402X5wV31HaTLxUzfarAwmTAQHIukugCCkGwaDl4TrSu/K3qQ3y0An2Cy72oASQeky
 2U3JC0ld42g+1UNPLYJk5kUX3uPPas8fBZZ5FEBEuk47HFA+IAFIEm1Q0Srg4lcMTj1E
 oRi6IeHHGF+mbUKyKuTSea7aCYLiELi2cZZcMxhRFwze6vhjcYO3ImybyIYMmQEt/JWn
 FKjs7H5BeYnYcwdPilpodkkjnUmtOliou5tWFbbCQ4DiAdyrcQmsL0/U2NzLYonrr0ti
 +BlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759370267; x=1759975067;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jYxzDr17ex1ArKRcKaJaschHglNbzUH5EYSWgfIQN1g=;
 b=HOJnvDkomL1bvYBxG6G5jtt6mjtOR9hfHVR5mfbLz3sGgO9dGKu7Sx82qn0Lq66c2p
 98RcDGjra6xYliuEXqh5PFLqTDdg8RwD35m/9eS/nq71ezn7YOXxz0vHkN77kbGG5vqv
 irVgsHGCLuX6CcRTF8RZid6oHiYwvZ6xcfIsb0VEVg2agCFefNWRO/9xyUmH2e57EHc0
 4D6QDICgkPksd46lxT7JS/YtgAMx6Lq2ze4MTJlTgA/2RedaBLa4R8g83iRfID1iPK+V
 VnB32oghto1MZHCVLrVf3YO7y16xrVgk/r0GLzLn9LJXFgEt0r9mwQIDv7uxISpwlXta
 wpZg==
X-Gm-Message-State: AOJu0Yy/EgiTg5QPQfpajiCBAzuqQ7BZujtnsmrez8YH3IhhFkCjnrqq
 CCRRhqDRrxf+GdWo264lEtXUQGafFEz5mEhw+FSRe6AIoDjSCiwVkvttWOvBMuOnobC2iaz61cF
 CK/00uEVKlew/mco0+eIh3sqOx73dAQU=
X-Gm-Gg: ASbGncspiQxDrP4QLhxT71TnzSKWQyfI3PwP6QqR7mp0sXt440bD1s7JUH8/lOoEql7
 ZJQEc/sBoupFUPjwsg9IMFrGypgmQ8LEOIZbqXQejycLVxRc7lyYTYCe0Notvwz5q2C3QJEK97C
 z4WkDz++eMOVgW5r5zjlCepbr5IYJIo2iThT6HvpatQ0ei/W3ozeA3Qy//mxhu5wNtlixIwQGeX
 k4q58XEqXeRB1Gd2s3GdBC64yYiauVxjuS0ZLWxPQT7nZ7QNm0czmg+9gWMtw==
X-Google-Smtp-Source: AGHT+IG/BgBsyM1lDpAlF6MWlnh5Zc2e8dr2Cn3Cso2GKAH9zb3gmKZsq5Bk/7oL6LeUzisAu7AGjHgAFzyFyMWe7GU=
X-Received: by 2002:a17:907:94d1:b0:b3c:193:820e with SMTP id
 a640c23a62f3a-b46e4d7d8c1mr644124466b.13.1759370267214; Wed, 01 Oct 2025
 18:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-3-anjo@rev.ng>
In-Reply-To: <20251001073306.28573-3-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Oct 2025 11:57:20 +1000
X-Gm-Features: AS18NWAtsHLPWqD0TpgJ1W1IgoaKI5C6JpsNXIr0gWaeMioUnikxZ8VUwN5CB88
Message-ID: <CAKmqyKP93b87wtcCD+BuoogtW+dWnBss=1OLqhWCNK=L6Gmkkg@mail.gmail.com>
Subject: Re: [PATCH v2 02/33] target/riscv: Fix size of trivial CPUArchState
 fields
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x631.google.com
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

On Wed, Oct 1, 2025 at 5:45=E2=80=AFPM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> This commits groups together all CPUArchState fields whose behaviour can
> be retained by simply changing the size of the field.
>
> Note, senvcfg is defined to be SXLEN bits wide, but is widened to 64
> bits to match henvcfg and menvcfg.  Next, [m|h]edeleg are changed to
> 64 bits as defined privileged specification, and hvictl is fixed to 32
> bits which holds all relevant values, see HVICTL_VALID_MASK.  The
> remaining fields touched in the commit are widened from [H|S|M]XLEN
> to 64-bit.
>
> Note, the cpu/hyper, cpu/envcfg, cpu/jvt, and cpu VMSTATE versions are
> bumped, breaking migration from older versions.
>
> References to the privileged/unprivileged RISCV specification refer to
> version 20250508.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h     | 78 +++++++++++++++++++--------------------
>  target/riscv/machine.c | 84 +++++++++++++++++++++---------------------
>  2 files changed, 81 insertions(+), 81 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index f05e06bb70..736e4f6daa 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -254,7 +254,7 @@ struct CPUArchState {
>      /* 128-bit helpers upper part return value */
>      target_ulong retxh;
>
> -    target_ulong jvt;
> +    uint64_t jvt;
>
>      /* elp state for zicfilp extension */
>      bool      elp;
> @@ -271,7 +271,7 @@ struct CPUArchState {
>      target_ulong priv;
>      /* CSRs for execution environment configuration */
>      uint64_t menvcfg;
> -    target_ulong senvcfg;
> +    uint64_t senvcfg;
>
>  #ifndef CONFIG_USER_ONLY
>      /* This contains QEMU specific information about the virt state. */
> @@ -313,18 +313,18 @@ struct CPUArchState {
>       */
>      uint64_t vsie;
>
> -    target_ulong satp;   /* since: priv-1.10.0 */
> -    target_ulong stval;
> -    target_ulong medeleg;
> +    uint64_t satp;   /* since: priv-1.10.0 */
> +    uint64_t stval;
> +    uint64_t medeleg;
>
> -    target_ulong stvec;
> -    target_ulong sepc;
> -    target_ulong scause;
> +    uint64_t stvec;
> +    uint64_t sepc;
> +    uint64_t scause;
>
> -    target_ulong mtvec;
> -    target_ulong mepc;
> -    target_ulong mcause;
> -    target_ulong mtval;  /* since: priv-1.10.0 */
> +    uint64_t mtvec;
> +    uint64_t mepc;
> +    uint64_t mcause;
> +    uint64_t mtval;  /* since: priv-1.10.0 */
>
>      uint64_t mctrctl;
>      uint32_t sctrdepth;
> @@ -346,13 +346,13 @@ struct CPUArchState {
>      uint64_t mvip;
>
>      /* Hypervisor CSRs */
> -    target_ulong hstatus;
> -    target_ulong hedeleg;
> +    uint64_t hstatus;
> +    uint64_t hedeleg;
>      uint64_t hideleg;
>      uint32_t hcounteren;
> -    target_ulong htval;
> -    target_ulong htinst;
> -    target_ulong hgatp;
> +    uint64_t htval;
> +    uint64_t htinst;
> +    uint64_t hgatp;
>      target_ulong hgeie;
>      target_ulong hgeip;
>      uint64_t htimedelta;
> @@ -366,7 +366,7 @@ struct CPUArchState {
>      uint64_t hvip;
>
>      /* Hypervisor controlled virtual interrupt priorities */
> -    target_ulong hvictl;
> +    uint32_t hvictl;
>      uint8_t hviprio[64];
>
>      /* Upper 64-bits of 128-bit CSRs */
> @@ -379,26 +379,26 @@ struct CPUArchState {
>       * For RV64 this is a 64-bit vsstatus.
>       */
>      uint64_t vsstatus;
> -    target_ulong vstvec;
> -    target_ulong vsscratch;
> -    target_ulong vsepc;
> -    target_ulong vscause;
> -    target_ulong vstval;
> -    target_ulong vsatp;
> +    uint64_t vstvec;
> +    uint64_t vsscratch;
> +    uint64_t vsepc;
> +    uint64_t vscause;
> +    uint64_t vstval;
> +    uint64_t vsatp;
>
>      /* AIA VS-mode CSRs */
>      target_ulong vsiselect;
>
> -    target_ulong mtval2;
> -    target_ulong mtinst;
> +    uint64_t mtval2;
> +    uint64_t mtinst;
>
>      /* HS Backup CSRs */
> -    target_ulong stvec_hs;
> -    target_ulong sscratch_hs;
> -    target_ulong sepc_hs;
> -    target_ulong scause_hs;
> -    target_ulong stval_hs;
> -    target_ulong satp_hs;
> +    uint64_t stvec_hs;
> +    uint64_t sscratch_hs;
> +    uint64_t sepc_hs;
> +    uint64_t scause_hs;
> +    uint64_t stval_hs;
> +    uint64_t satp_hs;
>      uint64_t mstatus_hs;
>
>      /*
> @@ -435,8 +435,8 @@ struct CPUArchState {
>
>      PMUFixedCtrState pmu_fixed_ctrs[2];
>
> -    target_ulong sscratch;
> -    target_ulong mscratch;
> +    uint64_t sscratch;
> +    uint64_t mscratch;
>
>      /* Sstc CSRs */
>      uint64_t stimecmp;
> @@ -506,11 +506,11 @@ struct CPUArchState {
>  #endif /* CONFIG_KVM */
>
>      /* RNMI */
> -    target_ulong mnscratch;
> -    target_ulong mnepc;
> -    target_ulong mncause; /* mncause without bit XLEN-1 set to 1 */
> -    target_ulong mnstatus;
> -    target_ulong rnmip;
> +    uint64_t mnscratch;
> +    uint64_t mnepc;
> +    uint64_t mncause; /* mncause without bit XLEN-1 set to 1 */
> +    uint64_t mnstatus;
> +    uint64_t rnmip;
>      uint64_t rnmi_irqvec;
>      uint64_t rnmi_excpvec;
>  };
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 1600ec44f0..99e46c3136 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -80,17 +80,17 @@ static bool hyper_needed(void *opaque)
>
>  static const VMStateDescription vmstate_hyper =3D {
>      .name =3D "cpu/hyper",
> -    .version_id =3D 4,
> -    .minimum_version_id =3D 4,
> +    .version_id =3D 5,
> +    .minimum_version_id =3D 5,
>      .needed =3D hyper_needed,
>      .fields =3D (const VMStateField[]) {
> -        VMSTATE_UINTTL(env.hstatus, RISCVCPU),
> -        VMSTATE_UINTTL(env.hedeleg, RISCVCPU),
> +        VMSTATE_UINT64(env.hstatus, RISCVCPU),
> +        VMSTATE_UINT64(env.hedeleg, RISCVCPU),
>          VMSTATE_UINT64(env.hideleg, RISCVCPU),
>          VMSTATE_UINT32(env.hcounteren, RISCVCPU),
> -        VMSTATE_UINTTL(env.htval, RISCVCPU),
> -        VMSTATE_UINTTL(env.htinst, RISCVCPU),
> -        VMSTATE_UINTTL(env.hgatp, RISCVCPU),
> +        VMSTATE_UINT64(env.htval, RISCVCPU),
> +        VMSTATE_UINT64(env.htinst, RISCVCPU),
> +        VMSTATE_UINT64(env.hgatp, RISCVCPU),
>          VMSTATE_UINTTL(env.hgeie, RISCVCPU),
>          VMSTATE_UINTTL(env.hgeip, RISCVCPU),
>          VMSTATE_UINT64(env.hvien, RISCVCPU),
> @@ -98,28 +98,28 @@ static const VMStateDescription vmstate_hyper =3D {
>          VMSTATE_UINT64(env.htimedelta, RISCVCPU),
>          VMSTATE_UINT64(env.vstimecmp, RISCVCPU),
>
> -        VMSTATE_UINTTL(env.hvictl, RISCVCPU),
> +        VMSTATE_UINT32(env.hvictl, RISCVCPU),
>          VMSTATE_UINT8_ARRAY(env.hviprio, RISCVCPU, 64),
>
>          VMSTATE_UINT64(env.vsstatus, RISCVCPU),
> -        VMSTATE_UINTTL(env.vstvec, RISCVCPU),
> -        VMSTATE_UINTTL(env.vsscratch, RISCVCPU),
> -        VMSTATE_UINTTL(env.vsepc, RISCVCPU),
> -        VMSTATE_UINTTL(env.vscause, RISCVCPU),
> -        VMSTATE_UINTTL(env.vstval, RISCVCPU),
> -        VMSTATE_UINTTL(env.vsatp, RISCVCPU),
> +        VMSTATE_UINT64(env.vstvec, RISCVCPU),
> +        VMSTATE_UINT64(env.vsscratch, RISCVCPU),
> +        VMSTATE_UINT64(env.vsepc, RISCVCPU),
> +        VMSTATE_UINT64(env.vscause, RISCVCPU),
> +        VMSTATE_UINT64(env.vstval, RISCVCPU),
> +        VMSTATE_UINT64(env.vsatp, RISCVCPU),
>          VMSTATE_UINTTL(env.vsiselect, RISCVCPU),
>          VMSTATE_UINT64(env.vsie, RISCVCPU),
>
> -        VMSTATE_UINTTL(env.mtval2, RISCVCPU),
> -        VMSTATE_UINTTL(env.mtinst, RISCVCPU),
> +        VMSTATE_UINT64(env.mtval2, RISCVCPU),
> +        VMSTATE_UINT64(env.mtinst, RISCVCPU),
>
> -        VMSTATE_UINTTL(env.stvec_hs, RISCVCPU),
> -        VMSTATE_UINTTL(env.sscratch_hs, RISCVCPU),
> -        VMSTATE_UINTTL(env.sepc_hs, RISCVCPU),
> -        VMSTATE_UINTTL(env.scause_hs, RISCVCPU),
> -        VMSTATE_UINTTL(env.stval_hs, RISCVCPU),
> -        VMSTATE_UINTTL(env.satp_hs, RISCVCPU),
> +        VMSTATE_UINT64(env.stvec_hs, RISCVCPU),
> +        VMSTATE_UINT64(env.sscratch_hs, RISCVCPU),
> +        VMSTATE_UINT64(env.sepc_hs, RISCVCPU),
> +        VMSTATE_UINT64(env.scause_hs, RISCVCPU),
> +        VMSTATE_UINT64(env.stval_hs, RISCVCPU),
> +        VMSTATE_UINT64(env.satp_hs, RISCVCPU),
>          VMSTATE_UINT64(env.mstatus_hs, RISCVCPU),
>
>          VMSTATE_END_OF_LIST()
> @@ -290,12 +290,12 @@ static bool envcfg_needed(void *opaque)
>
>  static const VMStateDescription vmstate_envcfg =3D {
>      .name =3D "cpu/envcfg",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .needed =3D envcfg_needed,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_UINT64(env.menvcfg, RISCVCPU),
> -        VMSTATE_UINTTL(env.senvcfg, RISCVCPU),
> +        VMSTATE_UINT64(env.senvcfg, RISCVCPU),
>          VMSTATE_UINT64(env.henvcfg, RISCVCPU),
>          VMSTATE_END_OF_LIST()
>      }
> @@ -355,11 +355,11 @@ static bool jvt_needed(void *opaque)
>
>  static const VMStateDescription vmstate_jvt =3D {
>      .name =3D "cpu/jvt",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .needed =3D jvt_needed,
>      .fields =3D (const VMStateField[]) {
> -        VMSTATE_UINTTL(env.jvt, RISCVCPU),
> +        VMSTATE_UINT64(env.jvt, RISCVCPU),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -402,8 +402,8 @@ static const VMStateDescription vmstate_ssp =3D {
>
>  const VMStateDescription vmstate_riscv_cpu =3D {
>      .name =3D "cpu",
> -    .version_id =3D 10,
> -    .minimum_version_id =3D 10,
> +    .version_id =3D 11,
> +    .minimum_version_id =3D 11,
>      .post_load =3D riscv_cpu_post_load,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
> @@ -434,16 +434,16 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          VMSTATE_UINT64(env.mvip, RISCVCPU),
>          VMSTATE_UINT64(env.sie, RISCVCPU),
>          VMSTATE_UINT64(env.mideleg, RISCVCPU),
> -        VMSTATE_UINTTL(env.satp, RISCVCPU),
> -        VMSTATE_UINTTL(env.stval, RISCVCPU),
> -        VMSTATE_UINTTL(env.medeleg, RISCVCPU),
> -        VMSTATE_UINTTL(env.stvec, RISCVCPU),
> -        VMSTATE_UINTTL(env.sepc, RISCVCPU),
> -        VMSTATE_UINTTL(env.scause, RISCVCPU),
> -        VMSTATE_UINTTL(env.mtvec, RISCVCPU),
> -        VMSTATE_UINTTL(env.mepc, RISCVCPU),
> -        VMSTATE_UINTTL(env.mcause, RISCVCPU),
> -        VMSTATE_UINTTL(env.mtval, RISCVCPU),
> +        VMSTATE_UINT64(env.satp, RISCVCPU),
> +        VMSTATE_UINT64(env.stval, RISCVCPU),
> +        VMSTATE_UINT64(env.medeleg, RISCVCPU),
> +        VMSTATE_UINT64(env.stvec, RISCVCPU),
> +        VMSTATE_UINT64(env.sepc, RISCVCPU),
> +        VMSTATE_UINT64(env.scause, RISCVCPU),
> +        VMSTATE_UINT64(env.mtvec, RISCVCPU),
> +        VMSTATE_UINT64(env.mepc, RISCVCPU),
> +        VMSTATE_UINT64(env.mcause, RISCVCPU),
> +        VMSTATE_UINT64(env.mtval, RISCVCPU),
>          VMSTATE_UINTTL(env.miselect, RISCVCPU),
>          VMSTATE_UINTTL(env.siselect, RISCVCPU),
>          VMSTATE_UINT32(env.scounteren, RISCVCPU),
> @@ -454,8 +454,8 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>                               vmstate_pmu_ctr_state, PMUCTRState),
>          VMSTATE_UINTTL_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVE=
NTS),
>          VMSTATE_UINTTL_ARRAY(env.mhpmeventh_val, RISCVCPU, RV_MAX_MHPMEV=
ENTS),
> -        VMSTATE_UINTTL(env.sscratch, RISCVCPU),
> -        VMSTATE_UINTTL(env.mscratch, RISCVCPU),
> +        VMSTATE_UINT64(env.sscratch, RISCVCPU),
> +        VMSTATE_UINT64(env.mscratch, RISCVCPU),
>          VMSTATE_UINT64(env.stimecmp, RISCVCPU),
>
>          VMSTATE_END_OF_LIST()
> --
> 2.51.0
>
>

