Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B611C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 23:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOnMX-00071u-AH; Tue, 02 Jul 2024 19:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOnMU-00071b-O6; Tue, 02 Jul 2024 19:56:38 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOnMR-00077Q-St; Tue, 02 Jul 2024 19:56:38 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4f284ef075dso53393e0c.1; 
 Tue, 02 Jul 2024 16:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719964594; x=1720569394; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGhcLKNSmSZudEX1YWoty+YoJntkxfMqiBHyKEceqRE=;
 b=eBK5cfqzO1+m1oEekaqZxFPwTMUAdx091RSkwdBbpzY8hciSNTI0Z+5IGIXLoQvyKJ
 J84J2LelGLPVJBnQ0YptBMtxByvuWNKx6rBPSCNpFnaY4AkQ8GlZzo5Lii8R532LskSQ
 gE2IPuvU1768f7EgGlr9CUbIfKfnXQsznlldMgNt6ICpczk1in8WGtrmkIhXYNKHOIbr
 TKSBEugLtviV+07nFHOPKVJMovullvnUTziviva9m+qGPgptVfIrGjmLsKQWcKo4SzOg
 Jnq7oiO1v8n3w4p+OSz0rmo4q5lP4vuhNZnJaWfJMuGb7eyvzHr4E3fMKNzJ8VJ5fqF4
 56Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719964594; x=1720569394;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGhcLKNSmSZudEX1YWoty+YoJntkxfMqiBHyKEceqRE=;
 b=aB/Qda7UKQ4jhOaGt7vJYWc4IgGS/d1YBqtni4jeSO/cqvObcxlHJFiO9M5/kzzG6W
 mYu5nHP0zOMTsXxifvY3uKW24vPancpoMijqseUcYbkemBaZ+BILZz4bn+u8phqC/1ww
 MQu0mK9u5SE2R8u4sfg/RiBfZ2rFCfe9ArHM3nzf3lSglNPucalII+hB4fpClKsFbklj
 Mtp6rYJhfiso3f/2iDzEUmXTeOKuW64j4MCy1HPVw+Vma2l1a/MH5ak8bK7maM7eqS7r
 9RPrNbsLv3rtAPh9dCKBrD6Bkd80FbBhRHWhZyYhNbkkyVbTtod5LlA2FfZt3oeQr486
 zz/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6Ush7SjxnHL49fj3WL65dgantf1eZKLYafruOSt0ZhQiHOUyddApu/qf/Qwywc3/f58welIU8mpzbTP+QanxOagflQoA=
X-Gm-Message-State: AOJu0YyCNbNOHkF1DmwH9txtR3gi9jnrjEHeX5XGSu1X66rTS0K7rkrh
 btSo1N+o/9In1CTeTEPUnIRRQnWtljH6ZOKE4TRXlNiU341IFMik/2277r6E1moEb8HmEFBd05t
 ZBNBSc7lPXLJOB4mRM+iiIZ6SuZk=
X-Google-Smtp-Source: AGHT+IFB7nYb8JXyLMZ2zTa2PHynmCJCVGog0vkNcEasDTcklwE8fo1D5QDk3ybovYzkw0WgCzRAakGwm5blyUVqiIE=
X-Received: by 2002:a05:6122:4487:b0:4ef:54dd:c806 with SMTP id
 71dfb90a1353d-4f2e0d66096mr76579e0c.7.1719964593889; Tue, 02 Jul 2024
 16:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240627180350.128575-1-richard.henderson@linaro.org>
 <20240627180350.128575-2-richard.henderson@linaro.org>
In-Reply-To: <20240627180350.128575-2-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jul 2024 09:56:07 +1000
Message-ID: <CAKmqyKNpYknHF6Dvv+fWBGyL1pHAaJ538zLa_vHDjckqgaZXNg@mail.gmail.com>
Subject: Re: [PATCH 1/3] util/cpuinfo-riscv: Support host/cpuinfo.h for riscv
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, brad@comstyle.com, Alistair.Francis@wdc.com, 
 palmer@dabbelt.com, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Fri, Jun 28, 2024 at 4:06=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move detection code out of tcg, similar to other hosts.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  host/include/riscv/host/cpuinfo.h | 23 +++++++++
>  tcg/riscv/tcg-target.h            | 46 ++++++++---------
>  util/cpuinfo-riscv.c              | 85 +++++++++++++++++++++++++++++++
>  tcg/riscv/tcg-target.c.inc        | 84 +++---------------------------
>  util/meson.build                  |  2 +
>  5 files changed, 139 insertions(+), 101 deletions(-)
>  create mode 100644 host/include/riscv/host/cpuinfo.h
>  create mode 100644 util/cpuinfo-riscv.c
>
> diff --git a/host/include/riscv/host/cpuinfo.h b/host/include/riscv/host/=
cpuinfo.h
> new file mode 100644
> index 0000000000..2b00660e36
> --- /dev/null
> +++ b/host/include/riscv/host/cpuinfo.h
> @@ -0,0 +1,23 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Host specific cpu identification for RISC-V.
> + */
> +
> +#ifndef HOST_CPUINFO_H
> +#define HOST_CPUINFO_H
> +
> +#define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
> +#define CPUINFO_ZBA             (1u << 1)
> +#define CPUINFO_ZBB             (1u << 2)
> +#define CPUINFO_ZICOND          (1u << 3)
> +
> +/* Initialized with a constructor. */
> +extern unsigned cpuinfo;
> +
> +/*
> + * We cannot rely on constructor ordering, so other constructors must
> + * use the function interface rather than the variable above.
> + */
> +unsigned cpuinfo_init(void);
> +
> +#endif /* HOST_CPUINFO_H */
> diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
> index 2c1b680b93..1a347eaf6e 100644
> --- a/tcg/riscv/tcg-target.h
> +++ b/tcg/riscv/tcg-target.h
> @@ -25,6 +25,8 @@
>  #ifndef RISCV_TCG_TARGET_H
>  #define RISCV_TCG_TARGET_H
>
> +#include "host/cpuinfo.h"
> +
>  #define TCG_TARGET_INSN_UNIT_SIZE 4
>  #define TCG_TARGET_NB_REGS 32
>  #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
> @@ -80,18 +82,12 @@ typedef enum {
>  #define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_NORMAL
>  #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
>
> -#if defined(__riscv_arch_test) && defined(__riscv_zbb)
> -# define have_zbb true
> -#else
> -extern bool have_zbb;
> -#endif
> -
>  /* optional instructions */
>  #define TCG_TARGET_HAS_negsetcond_i32   1
>  #define TCG_TARGET_HAS_div_i32          1
>  #define TCG_TARGET_HAS_rem_i32          1
>  #define TCG_TARGET_HAS_div2_i32         0
> -#define TCG_TARGET_HAS_rot_i32          have_zbb
> +#define TCG_TARGET_HAS_rot_i32          (cpuinfo & CPUINFO_ZBB)
>  #define TCG_TARGET_HAS_deposit_i32      0
>  #define TCG_TARGET_HAS_extract_i32      0
>  #define TCG_TARGET_HAS_sextract_i32     0
> @@ -106,17 +102,17 @@ extern bool have_zbb;
>  #define TCG_TARGET_HAS_ext16s_i32       1
>  #define TCG_TARGET_HAS_ext8u_i32        1
>  #define TCG_TARGET_HAS_ext16u_i32       1
> -#define TCG_TARGET_HAS_bswap16_i32      have_zbb
> -#define TCG_TARGET_HAS_bswap32_i32      have_zbb
> +#define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
>  #define TCG_TARGET_HAS_not_i32          1
> -#define TCG_TARGET_HAS_andc_i32         have_zbb
> -#define TCG_TARGET_HAS_orc_i32          have_zbb
> -#define TCG_TARGET_HAS_eqv_i32          have_zbb
> +#define TCG_TARGET_HAS_andc_i32         (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_orc_i32          (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_eqv_i32          (cpuinfo & CPUINFO_ZBB)
>  #define TCG_TARGET_HAS_nand_i32         0
>  #define TCG_TARGET_HAS_nor_i32          0
> -#define TCG_TARGET_HAS_clz_i32          have_zbb
> -#define TCG_TARGET_HAS_ctz_i32          have_zbb
> -#define TCG_TARGET_HAS_ctpop_i32        have_zbb
> +#define TCG_TARGET_HAS_clz_i32          (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_ctz_i32          (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_ctpop_i32        (cpuinfo & CPUINFO_ZBB)
>  #define TCG_TARGET_HAS_brcond2          1
>  #define TCG_TARGET_HAS_setcond2         1
>  #define TCG_TARGET_HAS_qemu_st8_i32     0
> @@ -125,7 +121,7 @@ extern bool have_zbb;
>  #define TCG_TARGET_HAS_div_i64          1
>  #define TCG_TARGET_HAS_rem_i64          1
>  #define TCG_TARGET_HAS_div2_i64         0
> -#define TCG_TARGET_HAS_rot_i64          have_zbb
> +#define TCG_TARGET_HAS_rot_i64          (cpuinfo & CPUINFO_ZBB)
>  #define TCG_TARGET_HAS_deposit_i64      0
>  #define TCG_TARGET_HAS_extract_i64      0
>  #define TCG_TARGET_HAS_sextract_i64     0
> @@ -137,18 +133,18 @@ extern bool have_zbb;
>  #define TCG_TARGET_HAS_ext8u_i64        1
>  #define TCG_TARGET_HAS_ext16u_i64       1
>  #define TCG_TARGET_HAS_ext32u_i64       1
> -#define TCG_TARGET_HAS_bswap16_i64      have_zbb
> -#define TCG_TARGET_HAS_bswap32_i64      have_zbb
> -#define TCG_TARGET_HAS_bswap64_i64      have_zbb
> +#define TCG_TARGET_HAS_bswap16_i64      (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
>  #define TCG_TARGET_HAS_not_i64          1
> -#define TCG_TARGET_HAS_andc_i64         have_zbb
> -#define TCG_TARGET_HAS_orc_i64          have_zbb
> -#define TCG_TARGET_HAS_eqv_i64          have_zbb
> +#define TCG_TARGET_HAS_andc_i64         (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_orc_i64          (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_eqv_i64          (cpuinfo & CPUINFO_ZBB)
>  #define TCG_TARGET_HAS_nand_i64         0
>  #define TCG_TARGET_HAS_nor_i64          0
> -#define TCG_TARGET_HAS_clz_i64          have_zbb
> -#define TCG_TARGET_HAS_ctz_i64          have_zbb
> -#define TCG_TARGET_HAS_ctpop_i64        have_zbb
> +#define TCG_TARGET_HAS_clz_i64          (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_ctz_i64          (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_ctpop_i64        (cpuinfo & CPUINFO_ZBB)
>  #define TCG_TARGET_HAS_add2_i64         1
>  #define TCG_TARGET_HAS_sub2_i64         1
>  #define TCG_TARGET_HAS_mulu2_i64        0
> diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
> new file mode 100644
> index 0000000000..6b97100620
> --- /dev/null
> +++ b/util/cpuinfo-riscv.c
> @@ -0,0 +1,85 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Host specific cpu identification for RISC-V.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "host/cpuinfo.h"
> +
> +unsigned cpuinfo;
> +static volatile sig_atomic_t got_sigill;
> +
> +static void sigill_handler(int signo, siginfo_t *si, void *data)
> +{
> +    /* Skip the faulty instruction */
> +    ucontext_t *uc =3D (ucontext_t *)data;
> +    uc->uc_mcontext.__gregs[REG_PC] +=3D 4;
> +
> +    got_sigill =3D 1;
> +}
> +
> +/* Called both as constructor and (possibly) via other constructors. */
> +unsigned __attribute__((constructor)) cpuinfo_init(void)
> +{
> +    unsigned left =3D CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND;
> +    unsigned info =3D cpuinfo;
> +
> +    if (info) {
> +        return info;
> +    }
> +
> +    /* Test for compile-time settings. */
> +#if defined(__riscv_arch_test) && defined(__riscv_zba)
> +    info |=3D CPUINFO_ZBA;
> +#endif
> +#if defined(__riscv_arch_test) && defined(__riscv_zbb)
> +    info |=3D CPUINFO_ZBB;
> +#endif
> +#if defined(__riscv_arch_test) && defined(__riscv_zicond)
> +    info |=3D CPUINFO_ZICOND;
> +#endif
> +    left &=3D ~info;
> +
> +    if (left) {
> +        struct sigaction sa_old, sa_new;
> +
> +        memset(&sa_new, 0, sizeof(sa_new));
> +        sa_new.sa_flags =3D SA_SIGINFO;
> +        sa_new.sa_sigaction =3D sigill_handler;
> +        sigaction(SIGILL, &sa_new, &sa_old);
> +
> +        if (left & CPUINFO_ZBA) {
> +            /* Probe for Zba: add.uw zero,zero,zero. */
> +            got_sigill =3D 0;
> +            asm volatile(".insn r 0x3b, 0, 0x04, zero, zero, zero"
> +                         : : : "memory");
> +            info |=3D !got_sigill * CPUINFO_ZBA;
> +            left &=3D ~CPUINFO_ZBA;
> +        }
> +
> +        if (left & CPUINFO_ZBB) {
> +            /* Probe for Zba: andn zero,zero,zero. */
> +            got_sigill =3D 0;
> +            asm volatile(".insn r 0x33, 7, 0x20, zero, zero, zero"
> +                         : : : "memory");
> +            info |=3D !got_sigill * CPUINFO_ZBB;
> +            left &=3D ~CPUINFO_ZBB;
> +        }
> +
> +        if (left & CPUINFO_ZICOND) {
> +            /* Probe for Zicond: czero.eqz zero,zero,zero. */
> +            got_sigill =3D 0;
> +            asm volatile(".insn r 0x33, 5, 0x07, zero, zero, zero"
> +                         : : : "memory");
> +            info |=3D !got_sigill * CPUINFO_ZICOND;
> +            left &=3D ~CPUINFO_ZICOND;
> +        }
> +
> +        sigaction(SIGILL, &sa_old, NULL);
> +        assert(left =3D=3D 0);
> +    }
> +
> +    info |=3D CPUINFO_ALWAYS;
> +    cpuinfo =3D info;
> +    return info;
> +}
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 639363039b..d334857226 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -113,20 +113,6 @@ static const int tcg_target_call_iarg_regs[] =3D {
>      TCG_REG_A7,
>  };
>
> -#ifndef have_zbb
> -bool have_zbb;
> -#endif
> -#if defined(__riscv_arch_test) && defined(__riscv_zba)
> -# define have_zba true
> -#else
> -static bool have_zba;
> -#endif
> -#if defined(__riscv_arch_test) && defined(__riscv_zicond)
> -# define have_zicond true
> -#else
> -static bool have_zicond;
> -#endif
> -
>  static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
>  {
>      tcg_debug_assert(kind =3D=3D TCG_CALL_RET_NORMAL);
> @@ -594,7 +580,7 @@ static void tcg_out_ext8u(TCGContext *s, TCGReg ret, =
TCGReg arg)
>
>  static void tcg_out_ext16u(TCGContext *s, TCGReg ret, TCGReg arg)
>  {
> -    if (have_zbb) {
> +    if (cpuinfo & CPUINFO_ZBB) {
>          tcg_out_opc_reg(s, OPC_ZEXT_H, ret, arg, TCG_REG_ZERO);
>      } else {
>          tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 16);
> @@ -604,7 +590,7 @@ static void tcg_out_ext16u(TCGContext *s, TCGReg ret,=
 TCGReg arg)
>
>  static void tcg_out_ext32u(TCGContext *s, TCGReg ret, TCGReg arg)
>  {
> -    if (have_zba) {
> +    if (cpuinfo & CPUINFO_ZBA) {
>          tcg_out_opc_reg(s, OPC_ADD_UW, ret, arg, TCG_REG_ZERO);
>      } else {
>          tcg_out_opc_imm(s, OPC_SLLI, ret, arg, 32);
> @@ -614,7 +600,7 @@ static void tcg_out_ext32u(TCGContext *s, TCGReg ret,=
 TCGReg arg)
>
>  static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg ret, TCGRe=
g arg)
>  {
> -    if (have_zbb) {
> +    if (cpuinfo & CPUINFO_ZBB) {
>          tcg_out_opc_imm(s, OPC_SEXT_B, ret, arg, 0);
>      } else {
>          tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 24);
> @@ -624,7 +610,7 @@ static void tcg_out_ext8s(TCGContext *s, TCGType type=
, TCGReg ret, TCGReg arg)
>
>  static void tcg_out_ext16s(TCGContext *s, TCGType type, TCGReg ret, TCGR=
eg arg)
>  {
> -    if (have_zbb) {
> +    if (cpuinfo & CPUINFO_ZBB) {
>          tcg_out_opc_imm(s, OPC_SEXT_H, ret, arg, 0);
>      } else {
>          tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 16);
> @@ -1080,7 +1066,7 @@ static void tcg_out_movcond(TCGContext *s, TCGCond =
cond, TCGReg ret,
>      int tmpflags;
>      TCGReg t;
>
> -    if (!have_zicond && (!c_cmp2 || cmp2 =3D=3D 0)) {
> +    if (!(cpuinfo & CPUINFO_ZICOND) && (!c_cmp2 || cmp2 =3D=3D 0)) {
>          tcg_out_movcond_br2(s, cond, ret, cmp1, cmp2,
>                              val1, c_val1, val2, c_val2);
>          return;
> @@ -1089,7 +1075,7 @@ static void tcg_out_movcond(TCGContext *s, TCGCond =
cond, TCGReg ret,
>      tmpflags =3D tcg_out_setcond_int(s, cond, TCG_REG_TMP0, cmp1, cmp2, =
c_cmp2);
>      t =3D tmpflags & ~SETCOND_FLAGS;
>
> -    if (have_zicond) {
> +    if (cpuinfo & CPUINFO_ZICOND) {
>          if (tmpflags & SETCOND_INV) {
>              tcg_out_movcond_zicond(s, ret, t, val2, c_val2, val1, c_val1=
);
>          } else {
> @@ -1304,7 +1290,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGConte=
xt *s, TCGReg *pbase,
>          /* TLB Hit - translate address using addend.  */
>          if (addr_type !=3D TCG_TYPE_I32) {
>              tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, addr_reg, TCG_REG_=
TMP2);
> -        } else if (have_zba) {
> +        } else if (cpuinfo & CPUINFO_ZBA) {
>              tcg_out_opc_reg(s, OPC_ADD_UW, TCG_REG_TMP0,
>                              addr_reg, TCG_REG_TMP2);
>          } else {
> @@ -1335,7 +1321,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGConte=
xt *s, TCGReg *pbase,
>              if (addr_type !=3D TCG_TYPE_I32) {
>                  tcg_out_opc_reg(s, OPC_ADD, base, addr_reg,
>                                  TCG_GUEST_BASE_REG);
> -            } else if (have_zba) {
> +            } else if (cpuinfo & CPUINFO_ZBA) {
>                  tcg_out_opc_reg(s, OPC_ADD_UW, base, addr_reg,
>                                  TCG_GUEST_BASE_REG);
>              } else {
> @@ -2110,62 +2096,8 @@ static void tcg_out_tb_start(TCGContext *s)
>      /* nothing to do */
>  }
>
> -static volatile sig_atomic_t got_sigill;
> -
> -static void sigill_handler(int signo, siginfo_t *si, void *data)
> -{
> -    /* Skip the faulty instruction */
> -    ucontext_t *uc =3D (ucontext_t *)data;
> -    uc->uc_mcontext.__gregs[REG_PC] +=3D 4;
> -
> -    got_sigill =3D 1;
> -}
> -
> -static void tcg_target_detect_isa(void)
> -{
> -#if !defined(have_zba) || !defined(have_zbb) || !defined(have_zicond)
> -    /*
> -     * TODO: It is expected that this will be determinable via
> -     * linux riscv_hwprobe syscall, not yet merged.
> -     * In the meantime, test via sigill.
> -     */
> -
> -    struct sigaction sa_old, sa_new;
> -
> -    memset(&sa_new, 0, sizeof(sa_new));
> -    sa_new.sa_flags =3D SA_SIGINFO;
> -    sa_new.sa_sigaction =3D sigill_handler;
> -    sigaction(SIGILL, &sa_new, &sa_old);
> -
> -#ifndef have_zba
> -    /* Probe for Zba: add.uw zero,zero,zero. */
> -    got_sigill =3D 0;
> -    asm volatile(".insn r 0x3b, 0, 0x04, zero, zero, zero" : : : "memory=
");
> -    have_zba =3D !got_sigill;
> -#endif
> -
> -#ifndef have_zbb
> -    /* Probe for Zba: andn zero,zero,zero. */
> -    got_sigill =3D 0;
> -    asm volatile(".insn r 0x33, 7, 0x20, zero, zero, zero" : : : "memory=
");
> -    have_zbb =3D !got_sigill;
> -#endif
> -
> -#ifndef have_zicond
> -    /* Probe for Zicond: czero.eqz zero,zero,zero. */
> -    got_sigill =3D 0;
> -    asm volatile(".insn r 0x33, 5, 0x07, zero, zero, zero" : : : "memory=
");
> -    have_zicond =3D !got_sigill;
> -#endif
> -
> -    sigaction(SIGILL, &sa_old, NULL);
> -#endif
> -}
> -
>  static void tcg_target_init(TCGContext *s)
>  {
> -    tcg_target_detect_isa();
> -
>      tcg_target_available_regs[TCG_TYPE_I32] =3D 0xffffffff;
>      tcg_target_available_regs[TCG_TYPE_I64] =3D 0xffffffff;
>
> diff --git a/util/meson.build b/util/meson.build
> index 72b505df11..5d8bef9891 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -127,4 +127,6 @@ elif cpu =3D=3D 'loongarch64'
>    util_ss.add(files('cpuinfo-loongarch.c'))
>  elif cpu in ['ppc', 'ppc64']
>    util_ss.add(files('cpuinfo-ppc.c'))
> +elif cpu in ['riscv32', 'riscv64']
> +  util_ss.add(files('cpuinfo-riscv.c'))
>  endif
> --
> 2.34.1
>
>

