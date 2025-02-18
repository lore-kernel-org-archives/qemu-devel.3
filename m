Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178D6C021AB
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 02:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkDoQ-0006AU-Ll; Mon, 17 Feb 2025 21:58:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tkDoL-0006A9-JU
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 21:58:14 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tkDoJ-0000ug-0F
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 21:58:13 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e05780509dso2598550a12.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 18:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739847488; x=1740452288; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=adC4BY3Gj0+g5vnLAgmLZBwyPgTPromv9GnjJrUl29Y=;
 b=e5wt6D78gSFtonFlQxwWzRAl+zVhZZnaUCfu9pTJZcTvu4vYKdfEQZLAOJD+iCaA8C
 oGFzdJCLIEe1bZIcOASmWOShoomykE+/Hsu2qeKIEwPd8MWjbWubG/N2bLZGerCBf5Uo
 MlCEEeHtWjh9f+ADySM07or2/EZU+rAwmzwVLMhILA0zzm5v7gVcUF+FaR8Zs11wYIQa
 hEi6HSY5SgTHlmMrrgD9qlbM0Zk80V2bpO3hmNBwpRcCy+GGHy7MN0wmaHPDNXcwXdKc
 tbVEC+VGL//+Z8A1eOKeszBavAs4Ul0V/Fg4w0hlF3Uoo6dOVI1UIM6PMMe5lhhTHZ/g
 gPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739847488; x=1740452288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=adC4BY3Gj0+g5vnLAgmLZBwyPgTPromv9GnjJrUl29Y=;
 b=wzqzkpzqF+sI922CJirtlUoFRT1uKO8aDdd9OBK67wa0Ye9oKr+TZQ99ZintrrtLX+
 sHucZAW9e3b7InX+6lGF7FvoYdOViW9VNZ0yPGFOYeHHfjNXx61Q4tuaWSTHTNZJuq5Y
 uNrj7RIQFi7mw4KylPiIP62x1Y+Q2Bf8YROThBNJU8ASzZ7GR0dYpvDJQkYBkkugaiIo
 sA5nzUbIyPLR7rfPKnUywO655IMjYsbmOHIKkrIpMoE0fr+E4rZH/HUljMtczjgQuw60
 jWF9GWdzmgWnEtsEJ+Cuy0BJLro3o+G0LhMeWA750+YRVIRH6u5VSIxn+QnYm5VAgJQ0
 gsWg==
X-Gm-Message-State: AOJu0YzNeuXoLo0eAgTHxjDJI9JK6GdJ6LoqJJSNZmExUkEbZCMEGFSa
 ELH+tj7MaZeYkbeDGpsEzLvTM3fNyuIwhq/dMG/rysTCrmX0XztEkjLf8zy9J5uDGcdH7yZhnvc
 2Ll2oum5PPfQBaGYcQTp+Cuc/V+Q=
X-Gm-Gg: ASbGnctrA2xEX3jnB8pWzLzT/GH1ddoWRHB08RB/VOZO975CTzYrl7RIAE1s83L+m2p
 stdYwOBU+C1pJCwYOXmIS/GJRU0PceARuu01nKa7NAXN7/5lTlbO+M890q//Kden3B6r7vtOu
X-Google-Smtp-Source: AGHT+IHobnEnWftch+Z1LPIcOAETEW7lKrHdR0aQLB9VLUXpYG5hQkwX3jC8n75BRFzT21GHu9Xqy0c8hOzTDr0Q+SI=
X-Received: by 2002:a05:6402:2548:b0:5e0:3567:8077 with SMTP id
 4fb4d7f45d1cf-5e0360440abmr10909159a12.4.1739847488212; Mon, 17 Feb 2025
 18:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20250217193453.2874125-1-richard.henderson@linaro.org>
In-Reply-To: <20250217193453.2874125-1-richard.henderson@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 18 Feb 2025 10:57:56 +0800
X-Gm-Features: AWEUYZl0_vx1eIC8LvkLMN4EiRf_BpPIQY5UwWRwbT3GyqOxJbxX3cNq7wO8qss
Message-ID: <CAJSP0QWMzfrwpGBux7jRCQ6nO8YVgwc0rZObZ45AnX5s8RTC5g@mail.gmail.com>
Subject: Re: [PULL v2.5 00/27] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x534.google.com
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

On Tue, Feb 18, 2025 at 3:35=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> v2: Fix target/loongarch printf formats for vaddr
>     Include two more reviewed patches.
>
> This time with actual pull urls.  :-/
>
> r~
>
>
> The following changes since commit db7aa99ef894e88fc5eedf02ca2579b8c344b2=
ec:
>
>   Merge tag 'hw-misc-20250216' of https://github.com/philmd/qemu into sta=
ging (2025-02-16 20:48:06 -0500)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20250215-2
>
> for you to fetch changes up to a39bdd0f4ba96fcbb6b5bcb6e89591d2b24f52eb:
>
>   tcg: Remove TCG_TARGET_HAS_{br,set}cond2 from riscv and loongarch64 (20=
25-02-17 09:52:07 -0800)

There is still a macOS build failure:
https://gitlab.com/qemu-project/qemu/-/jobs/9165757871#L5509

../target/mips/tcg/octeon_translate.c:22:39: error: format specifies
type 'unsigned long long' but the argument has type 'vaddr' (aka
'unsigned long') [-Werror,-Wformat]
21 | LOG_DISAS("Branch in delay / forbidden slot at PC 0x"
| ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
22 | TARGET_FMT_lx "\n", ctx->base.pc_next);
| ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
../target/mips/tcg/translate.h:197:49: note: expanded from macro 'LOG_DISAS=
'
197 | qemu_log_mask(CPU_LOG_TB_IN_ASM, ## __VA_ARGS__); \
| ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
/private/var/folders/xf/_tm0f94d66n8kr12tqwrylrr0000gn/T/cirrus-ci-build/in=
clude/qemu/log.h:57:30:
note: expanded from macro 'qemu_log_mask'
57 | qemu_log(FMT, ## __VA_ARGS__); \
| ~~~ ^~~~~~~~~~~

Stefan

>
> ----------------------------------------------------------------
> tcg: Remove last traces of TCG_TARGET_NEED_POOL_LABELS
> tcg: Cleanups after disallowing 64-on-32
> tcg: Introduce constraint for zero register
> tcg: Remove TCG_TARGET_HAS_{br,set}cond2 from riscv and loongarch64
> tcg/i386: Use tcg_{high,unsigned}_cond in tcg_out_brcond2
> linux-user: Move TARGET_SA_RESTORER out of generic/signal.h
> linux-user: Fix alignment when unmapping excess reservation
> target/sparc: Fix register selection for all F*TOx and FxTO* instructions
> target/sparc: Fix gdbstub incorrectly handling registers f32-f62
> target/sparc: fake UltraSPARC T1 PCR and PIC registers
>
> ----------------------------------------------------------------
> Andreas Schwab (1):
>       linux-user: Move TARGET_SA_RESTORER out of generic/signal.h
>
> Artyom Tarasenko (1):
>       target/sparc: fake UltraSPARC T1 PCR and PIC registers
>
> Fabiano Rosas (1):
>       elfload: Fix alignment when unmapping excess reservation
>
> Mikael Szreder (2):
>       target/sparc: Fix register selection for all F*TOx and FxTO* instru=
ctions
>       target/sparc: Fix gdbstub incorrectly handling registers f32-f62
>
> Richard Henderson (22):
>       tcg: Remove last traces of TCG_TARGET_NEED_POOL_LABELS
>       tcg: Remove TCG_OVERSIZED_GUEST
>       tcg: Drop support for two address registers in gen_ldst
>       tcg: Merge INDEX_op_qemu_*_{a32,a64}_*
>       tcg/arm: Drop addrhi from prepare_host_addr
>       tcg/i386: Drop addrhi from prepare_host_addr
>       tcg/mips: Drop addrhi from prepare_host_addr
>       tcg/ppc: Drop addrhi from prepare_host_addr
>       tcg: Replace addr{lo,hi}_reg with addr_reg in TCGLabelQemuLdst
>       plugins: Fix qemu_plugin_read_memory_vaddr parameters
>       accel/tcg: Fix tlb_set_page_with_attrs, tlb_set_page
>       target/loongarch: Use VADDR_PRIx for logging pc_next
>       include/exec: Change vaddr to uintptr_t
>       include/exec: Use uintptr_t in CPUTLBEntry
>       tcg: Introduce the 'z' constraint for a hardware zero register
>       tcg/aarch64: Use 'z' constraint
>       tcg/loongarch64: Use 'z' constraint
>       tcg/mips: Use 'z' constraint
>       tcg/riscv: Use 'z' constraint
>       tcg/sparc64: Use 'z' constraint
>       tcg/i386: Use tcg_{high,unsigned}_cond in tcg_out_brcond2
>       tcg: Remove TCG_TARGET_HAS_{br,set}cond2 from riscv and loongarch64
>
>  include/exec/tlb-common.h                          |  10 +-
>  include/exec/vaddr.h                               |  16 +-
>  include/qemu/atomic.h                              |  18 +-
>  include/tcg/oversized-guest.h                      |  23 ---
>  include/tcg/tcg-opc.h                              |  28 +--
>  include/tcg/tcg.h                                  |   3 +-
>  linux-user/aarch64/target_signal.h                 |   2 +
>  linux-user/arm/target_signal.h                     |   2 +
>  linux-user/generic/signal.h                        |   1 -
>  linux-user/i386/target_signal.h                    |   2 +
>  linux-user/m68k/target_signal.h                    |   1 +
>  linux-user/microblaze/target_signal.h              |   2 +
>  linux-user/ppc/target_signal.h                     |   2 +
>  linux-user/s390x/target_signal.h                   |   2 +
>  linux-user/sh4/target_signal.h                     |   2 +
>  linux-user/x86_64/target_signal.h                  |   2 +
>  linux-user/xtensa/target_signal.h                  |   2 +
>  tcg/aarch64/tcg-target-con-set.h                   |  12 +-
>  tcg/aarch64/tcg-target.h                           |   2 +
>  tcg/loongarch64/tcg-target-con-set.h               |  15 +-
>  tcg/loongarch64/tcg-target-con-str.h               |   1 -
>  tcg/loongarch64/tcg-target-has.h                   |   2 -
>  tcg/loongarch64/tcg-target.h                       |   2 +
>  tcg/mips/tcg-target-con-set.h                      |  26 +--
>  tcg/mips/tcg-target-con-str.h                      |   1 -
>  tcg/mips/tcg-target.h                              |   2 +
>  tcg/riscv/tcg-target-con-set.h                     |  10 +-
>  tcg/riscv/tcg-target-con-str.h                     |   1 -
>  tcg/riscv/tcg-target-has.h                         |   2 -
>  tcg/riscv/tcg-target.h                             |   2 +
>  tcg/sparc64/tcg-target-con-set.h                   |  12 +-
>  tcg/sparc64/tcg-target-con-str.h                   |   1 -
>  tcg/sparc64/tcg-target.h                           |   3 +-
>  tcg/tci/tcg-target.h                               |   1 -
>  accel/tcg/cputlb.c                                 |  32 +---
>  accel/tcg/tcg-all.c                                |   9 +-
>  linux-user/elfload.c                               |   4 +-
>  plugins/api.c                                      |   2 +-
>  target/arm/ptw.c                                   |  34 ----
>  target/loongarch/tcg/translate.c                   |   2 +-
>  target/riscv/cpu_helper.c                          |  13 +-
>  target/sparc/gdbstub.c                             |  18 +-
>  target/sparc/translate.c                           |  19 +++
>  tcg/optimize.c                                     |  21 +--
>  tcg/tcg-op-ldst.c                                  | 103 +++--------
>  tcg/tcg.c                                          |  97 +++++------
>  tcg/tci.c                                          | 119 +++----------
>  docs/devel/multi-thread-tcg.rst                    |   1 -
>  docs/devel/tcg-ops.rst                             |   4 +-
>  target/loongarch/tcg/insn_trans/trans_atomic.c.inc |   2 +-
>  target/sparc/insns.decode                          |  19 ++-
>  tcg/aarch64/tcg-target.c.inc                       |  86 ++++------
>  tcg/arm/tcg-target.c.inc                           | 114 ++++---------
>  tcg/i386/tcg-target.c.inc                          | 190 +++++----------=
------
>  tcg/loongarch64/tcg-target.c.inc                   |  72 +++-----
>  tcg/mips/tcg-target.c.inc                          | 169 ++++++---------=
---
>  tcg/ppc/tcg-target.c.inc                           | 164 +++++----------=
---
>  tcg/riscv/tcg-target.c.inc                         |  56 +++---
>  tcg/s390x/tcg-target.c.inc                         |  40 ++---
>  tcg/sparc64/tcg-target.c.inc                       |  45 ++---
>  tcg/tci/tcg-target.c.inc                           |  60 ++-----
>  61 files changed, 548 insertions(+), 1160 deletions(-)
>  delete mode 100644 include/tcg/oversized-guest.h
>

