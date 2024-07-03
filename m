Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E1CC30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvf5-00006I-8R; Wed, 03 Jul 2024 04:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baxiantai@gmail.com>)
 id 1sOvf3-00005q-NP; Wed, 03 Jul 2024 04:48:21 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baxiantai@gmail.com>)
 id 1sOvf1-0007Pz-7H; Wed, 03 Jul 2024 04:48:21 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7449fbfeb6bso2110690a12.2; 
 Wed, 03 Jul 2024 01:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719996497; x=1720601297; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sHHUGNVgEsPx1lgq30q6KcHaBV/5fLluYt9+ZUDKxwE=;
 b=JnrLeWGicqDWcE4Y63ddDr2RGQQpagOkkPxEzztV8rBQLqlQ+m3CtOhf/7NLaSNUcR
 K75wyXl/0ieQXTKHQCFtY0+SAFz+MV9pn2B8vGLOmPKYuT5EZEQem+DXf5Hsha2QBLsq
 Pc/Bk46enIanJUBF/BQLf351am1HRJwVG6PiNBvE6ORpa6rLx2oUwGUmkC1cpAfflbc+
 qS1r30w5xajhW4lTmqLNhJjE51I4F7BawQHZHms7OJj+KAraUfeHHo5EMJHKNP/H28JT
 1pHNnnkHMSqQPjdiu2hJ97AAcbTYf3Kac+4Ivyvq7H6dR9pjgOIdq7rAk62Geg5inoEB
 3KYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719996497; x=1720601297;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sHHUGNVgEsPx1lgq30q6KcHaBV/5fLluYt9+ZUDKxwE=;
 b=enJjYqiE6CehioO86fB5jUASXAmlzr1RLWXBdIwDHVBZCVovy8ivVtoL5ZhYRRIwZp
 ef3oOxQPXMnnRzb38aDrSYNxXpkjM89zUbZUG6/+S87OsbVAerzRrE7VJ5KHo2b47lYj
 I6IOAJ3zW/UrO58ERwtAjN6Oj/GJg5v1fnY/cb+HjhUyO3hUgnWyDjbszDFP8tSV6c+1
 hKDlU3YtaF4UOMm80Kk9NIn4a+LNq5LQiKRvricYpXQywSsanFifNw4UkYElTrbb2XnR
 6Y9CFsa3TpZHWrcUwwlSOho6HAhEcj4c27FDAHvDovytekdWVCwvqsdtcJlMRdo9CyH/
 ee6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtFFxa+hfwgX3hD8SRR3XKat+AQJZ3S79i0Nxl5FMFGfenYAWr0Rl3k71X6V2K69RRrc+9ML8OfOdkDOzYyM5sapP/AjILn3xCTmakmaRJFP+kDEENzbURc93Q8w==
X-Gm-Message-State: AOJu0YxsnmP0T9qtuLLAfAmgvZ80lSHgU90dK7vuL5AJj9NL4Ey9JV++
 m6fC54Gg6hfBEZDDbrQk0N7YfXATHv0wr3/SYCeHhK/ih7VHCCHS
X-Google-Smtp-Source: AGHT+IHa2St+hXtpEk3PJUh0HQ826bze6jj0xIUY74CUk8oVU49vN2npqK+5E6ajR0bcJfcBBmTjjA==
X-Received: by 2002:a05:6a20:a11a:b0:1be:c967:311f with SMTP id
 adf61e73a8af0-1bef611b816mr10452648637.13.1719996496491; 
 Wed, 03 Jul 2024 01:48:16 -0700 (PDT)
Received: from [30.166.64.126] ([47.246.101.254])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1569f83sm97411895ad.204.2024.07.03.01.48.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:48:16 -0700 (PDT)
Message-ID: <8bba24bf-2a7d-442f-81a5-236d6f119ea5@gmail.com>
Date: Wed, 3 Jul 2024 16:46:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] util/cpuinfo-riscv: Support host/cpuinfo.h for riscv
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: brad@comstyle.com, Alistair.Francis@wdc.com, palmer@dabbelt.com,
 qemu-riscv@nongnu.org
References: <20240627180350.128575-1-richard.henderson@linaro.org>
 <20240627180350.128575-2-richard.henderson@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <baxiantai@gmail.com>
In-Reply-To: <20240627180350.128575-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=baxiantai@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On 2024/6/28 2:03, Richard Henderson wrote:
> Move detection code out of tcg, similar to other hosts.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

> ---
>   host/include/riscv/host/cpuinfo.h | 23 +++++++++
>   tcg/riscv/tcg-target.h            | 46 ++++++++---------
>   util/cpuinfo-riscv.c              | 85 +++++++++++++++++++++++++++++++
>   tcg/riscv/tcg-target.c.inc        | 84 +++---------------------------
>   util/meson.build                  |  2 +
>   5 files changed, 139 insertions(+), 101 deletions(-)
>   create mode 100644 host/include/riscv/host/cpuinfo.h
>   create mode 100644 util/cpuinfo-riscv.c
>
> diff --git a/host/include/riscv/host/cpuinfo.h b/host/include/riscv/host/cpuinfo.h
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
>   #ifndef RISCV_TCG_TARGET_H
>   #define RISCV_TCG_TARGET_H
>   
> +#include "host/cpuinfo.h"
> +
>   #define TCG_TARGET_INSN_UNIT_SIZE 4
>   #define TCG_TARGET_NB_REGS 32
>   #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
> @@ -80,18 +82,12 @@ typedef enum {
>   #define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_NORMAL
>   #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
>   
> -#if defined(__riscv_arch_test) && defined(__riscv_zbb)
> -# define have_zbb true
> -#else
> -extern bool have_zbb;
> -#endif
> -
>   /* optional instructions */
>   #define TCG_TARGET_HAS_negsetcond_i32   1
>   #define TCG_TARGET_HAS_div_i32          1
>   #define TCG_TARGET_HAS_rem_i32          1
>   #define TCG_TARGET_HAS_div2_i32         0
> -#define TCG_TARGET_HAS_rot_i32          have_zbb
> +#define TCG_TARGET_HAS_rot_i32          (cpuinfo & CPUINFO_ZBB)
>   #define TCG_TARGET_HAS_deposit_i32      0
>   #define TCG_TARGET_HAS_extract_i32      0
>   #define TCG_TARGET_HAS_sextract_i32     0
> @@ -106,17 +102,17 @@ extern bool have_zbb;
>   #define TCG_TARGET_HAS_ext16s_i32       1
>   #define TCG_TARGET_HAS_ext8u_i32        1
>   #define TCG_TARGET_HAS_ext16u_i32       1
> -#define TCG_TARGET_HAS_bswap16_i32      have_zbb
> -#define TCG_TARGET_HAS_bswap32_i32      have_zbb
> +#define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
>   #define TCG_TARGET_HAS_not_i32          1
> -#define TCG_TARGET_HAS_andc_i32         have_zbb
> -#define TCG_TARGET_HAS_orc_i32          have_zbb
> -#define TCG_TARGET_HAS_eqv_i32          have_zbb
> +#define TCG_TARGET_HAS_andc_i32         (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_orc_i32          (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_eqv_i32          (cpuinfo & CPUINFO_ZBB)
>   #define TCG_TARGET_HAS_nand_i32         0
>   #define TCG_TARGET_HAS_nor_i32          0
> -#define TCG_TARGET_HAS_clz_i32          have_zbb
> -#define TCG_TARGET_HAS_ctz_i32          have_zbb
> -#define TCG_TARGET_HAS_ctpop_i32        have_zbb
> +#define TCG_TARGET_HAS_clz_i32          (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_ctz_i32          (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_ctpop_i32        (cpuinfo & CPUINFO_ZBB)
>   #define TCG_TARGET_HAS_brcond2          1
>   #define TCG_TARGET_HAS_setcond2         1
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
> @@ -125,7 +121,7 @@ extern bool have_zbb;
>   #define TCG_TARGET_HAS_div_i64          1
>   #define TCG_TARGET_HAS_rem_i64          1
>   #define TCG_TARGET_HAS_div2_i64         0
> -#define TCG_TARGET_HAS_rot_i64          have_zbb
> +#define TCG_TARGET_HAS_rot_i64          (cpuinfo & CPUINFO_ZBB)
>   #define TCG_TARGET_HAS_deposit_i64      0
>   #define TCG_TARGET_HAS_extract_i64      0
>   #define TCG_TARGET_HAS_sextract_i64     0
> @@ -137,18 +133,18 @@ extern bool have_zbb;
>   #define TCG_TARGET_HAS_ext8u_i64        1
>   #define TCG_TARGET_HAS_ext16u_i64       1
>   #define TCG_TARGET_HAS_ext32u_i64       1
> -#define TCG_TARGET_HAS_bswap16_i64      have_zbb
> -#define TCG_TARGET_HAS_bswap32_i64      have_zbb
> -#define TCG_TARGET_HAS_bswap64_i64      have_zbb
> +#define TCG_TARGET_HAS_bswap16_i64      (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
>   #define TCG_TARGET_HAS_not_i64          1
> -#define TCG_TARGET_HAS_andc_i64         have_zbb
> -#define TCG_TARGET_HAS_orc_i64          have_zbb
> -#define TCG_TARGET_HAS_eqv_i64          have_zbb
> +#define TCG_TARGET_HAS_andc_i64         (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_orc_i64          (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_eqv_i64          (cpuinfo & CPUINFO_ZBB)
>   #define TCG_TARGET_HAS_nand_i64         0
>   #define TCG_TARGET_HAS_nor_i64          0
> -#define TCG_TARGET_HAS_clz_i64          have_zbb
> -#define TCG_TARGET_HAS_ctz_i64          have_zbb
> -#define TCG_TARGET_HAS_ctpop_i64        have_zbb
> +#define TCG_TARGET_HAS_clz_i64          (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_ctz_i64          (cpuinfo & CPUINFO_ZBB)
> +#define TCG_TARGET_HAS_ctpop_i64        (cpuinfo & CPUINFO_ZBB)
>   #define TCG_TARGET_HAS_add2_i64         1
>   #define TCG_TARGET_HAS_sub2_i64         1
>   #define TCG_TARGET_HAS_mulu2_i64        0
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
> +    ucontext_t *uc = (ucontext_t *)data;
> +    uc->uc_mcontext.__gregs[REG_PC] += 4;
> +
> +    got_sigill = 1;
> +}
> +
> +/* Called both as constructor and (possibly) via other constructors. */
> +unsigned __attribute__((constructor)) cpuinfo_init(void)
> +{
> +    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND;
> +    unsigned info = cpuinfo;
> +
> +    if (info) {
> +        return info;
> +    }
> +
> +    /* Test for compile-time settings. */
> +#if defined(__riscv_arch_test) && defined(__riscv_zba)
> +    info |= CPUINFO_ZBA;
> +#endif
> +#if defined(__riscv_arch_test) && defined(__riscv_zbb)
> +    info |= CPUINFO_ZBB;
> +#endif
> +#if defined(__riscv_arch_test) && defined(__riscv_zicond)
> +    info |= CPUINFO_ZICOND;
> +#endif
> +    left &= ~info;
> +
> +    if (left) {
> +        struct sigaction sa_old, sa_new;
> +
> +        memset(&sa_new, 0, sizeof(sa_new));
> +        sa_new.sa_flags = SA_SIGINFO;
> +        sa_new.sa_sigaction = sigill_handler;
> +        sigaction(SIGILL, &sa_new, &sa_old);
> +
> +        if (left & CPUINFO_ZBA) {
> +            /* Probe for Zba: add.uw zero,zero,zero. */
> +            got_sigill = 0;
> +            asm volatile(".insn r 0x3b, 0, 0x04, zero, zero, zero"
> +                         : : : "memory");
> +            info |= !got_sigill * CPUINFO_ZBA;
> +            left &= ~CPUINFO_ZBA;
> +        }
> +
> +        if (left & CPUINFO_ZBB) {
> +            /* Probe for Zba: andn zero,zero,zero. */
> +            got_sigill = 0;
> +            asm volatile(".insn r 0x33, 7, 0x20, zero, zero, zero"
> +                         : : : "memory");
> +            info |= !got_sigill * CPUINFO_ZBB;
> +            left &= ~CPUINFO_ZBB;
> +        }
> +
> +        if (left & CPUINFO_ZICOND) {
> +            /* Probe for Zicond: czero.eqz zero,zero,zero. */
> +            got_sigill = 0;
> +            asm volatile(".insn r 0x33, 5, 0x07, zero, zero, zero"
> +                         : : : "memory");
> +            info |= !got_sigill * CPUINFO_ZICOND;
> +            left &= ~CPUINFO_ZICOND;
> +        }
> +
> +        sigaction(SIGILL, &sa_old, NULL);
> +        assert(left == 0);
> +    }
> +
> +    info |= CPUINFO_ALWAYS;
> +    cpuinfo = info;
> +    return info;
> +}
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 639363039b..d334857226 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -113,20 +113,6 @@ static const int tcg_target_call_iarg_regs[] = {
>       TCG_REG_A7,
>   };
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
>   static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
>   {
>       tcg_debug_assert(kind == TCG_CALL_RET_NORMAL);
> @@ -594,7 +580,7 @@ static void tcg_out_ext8u(TCGContext *s, TCGReg ret, TCGReg arg)
>   
>   static void tcg_out_ext16u(TCGContext *s, TCGReg ret, TCGReg arg)
>   {
> -    if (have_zbb) {
> +    if (cpuinfo & CPUINFO_ZBB) {
>           tcg_out_opc_reg(s, OPC_ZEXT_H, ret, arg, TCG_REG_ZERO);
>       } else {
>           tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 16);
> @@ -604,7 +590,7 @@ static void tcg_out_ext16u(TCGContext *s, TCGReg ret, TCGReg arg)
>   
>   static void tcg_out_ext32u(TCGContext *s, TCGReg ret, TCGReg arg)
>   {
> -    if (have_zba) {
> +    if (cpuinfo & CPUINFO_ZBA) {
>           tcg_out_opc_reg(s, OPC_ADD_UW, ret, arg, TCG_REG_ZERO);
>       } else {
>           tcg_out_opc_imm(s, OPC_SLLI, ret, arg, 32);
> @@ -614,7 +600,7 @@ static void tcg_out_ext32u(TCGContext *s, TCGReg ret, TCGReg arg)
>   
>   static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
>   {
> -    if (have_zbb) {
> +    if (cpuinfo & CPUINFO_ZBB) {
>           tcg_out_opc_imm(s, OPC_SEXT_B, ret, arg, 0);
>       } else {
>           tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 24);
> @@ -624,7 +610,7 @@ static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
>   
>   static void tcg_out_ext16s(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
>   {
> -    if (have_zbb) {
> +    if (cpuinfo & CPUINFO_ZBB) {
>           tcg_out_opc_imm(s, OPC_SEXT_H, ret, arg, 0);
>       } else {
>           tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 16);
> @@ -1080,7 +1066,7 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
>       int tmpflags;
>       TCGReg t;
>   
> -    if (!have_zicond && (!c_cmp2 || cmp2 == 0)) {
> +    if (!(cpuinfo & CPUINFO_ZICOND) && (!c_cmp2 || cmp2 == 0)) {
>           tcg_out_movcond_br2(s, cond, ret, cmp1, cmp2,
>                               val1, c_val1, val2, c_val2);
>           return;
> @@ -1089,7 +1075,7 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
>       tmpflags = tcg_out_setcond_int(s, cond, TCG_REG_TMP0, cmp1, cmp2, c_cmp2);
>       t = tmpflags & ~SETCOND_FLAGS;
>   
> -    if (have_zicond) {
> +    if (cpuinfo & CPUINFO_ZICOND) {
>           if (tmpflags & SETCOND_INV) {
>               tcg_out_movcond_zicond(s, ret, t, val2, c_val2, val1, c_val1);
>           } else {
> @@ -1304,7 +1290,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
>           /* TLB Hit - translate address using addend.  */
>           if (addr_type != TCG_TYPE_I32) {
>               tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, addr_reg, TCG_REG_TMP2);
> -        } else if (have_zba) {
> +        } else if (cpuinfo & CPUINFO_ZBA) {
>               tcg_out_opc_reg(s, OPC_ADD_UW, TCG_REG_TMP0,
>                               addr_reg, TCG_REG_TMP2);
>           } else {
> @@ -1335,7 +1321,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
>               if (addr_type != TCG_TYPE_I32) {
>                   tcg_out_opc_reg(s, OPC_ADD, base, addr_reg,
>                                   TCG_GUEST_BASE_REG);
> -            } else if (have_zba) {
> +            } else if (cpuinfo & CPUINFO_ZBA) {
>                   tcg_out_opc_reg(s, OPC_ADD_UW, base, addr_reg,
>                                   TCG_GUEST_BASE_REG);
>               } else {
> @@ -2110,62 +2096,8 @@ static void tcg_out_tb_start(TCGContext *s)
>       /* nothing to do */
>   }
>   
> -static volatile sig_atomic_t got_sigill;
> -
> -static void sigill_handler(int signo, siginfo_t *si, void *data)
> -{
> -    /* Skip the faulty instruction */
> -    ucontext_t *uc = (ucontext_t *)data;
> -    uc->uc_mcontext.__gregs[REG_PC] += 4;
> -
> -    got_sigill = 1;
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
> -    sa_new.sa_flags = SA_SIGINFO;
> -    sa_new.sa_sigaction = sigill_handler;
> -    sigaction(SIGILL, &sa_new, &sa_old);
> -
> -#ifndef have_zba
> -    /* Probe for Zba: add.uw zero,zero,zero. */
> -    got_sigill = 0;
> -    asm volatile(".insn r 0x3b, 0, 0x04, zero, zero, zero" : : : "memory");
> -    have_zba = !got_sigill;
> -#endif
> -
> -#ifndef have_zbb
> -    /* Probe for Zba: andn zero,zero,zero. */
> -    got_sigill = 0;
> -    asm volatile(".insn r 0x33, 7, 0x20, zero, zero, zero" : : : "memory");
> -    have_zbb = !got_sigill;
> -#endif
> -
> -#ifndef have_zicond
> -    /* Probe for Zicond: czero.eqz zero,zero,zero. */
> -    got_sigill = 0;
> -    asm volatile(".insn r 0x33, 5, 0x07, zero, zero, zero" : : : "memory");
> -    have_zicond = !got_sigill;
> -#endif
> -
> -    sigaction(SIGILL, &sa_old, NULL);
> -#endif
> -}
> -
>   static void tcg_target_init(TCGContext *s)
>   {
> -    tcg_target_detect_isa();
> -
>       tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
>       tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
>   
> diff --git a/util/meson.build b/util/meson.build
> index 72b505df11..5d8bef9891 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -127,4 +127,6 @@ elif cpu == 'loongarch64'
>     util_ss.add(files('cpuinfo-loongarch.c'))
>   elif cpu in ['ppc', 'ppc64']
>     util_ss.add(files('cpuinfo-ppc.c'))
> +elif cpu in ['riscv32', 'riscv64']
> +  util_ss.add(files('cpuinfo-riscv.c'))
>   endif

