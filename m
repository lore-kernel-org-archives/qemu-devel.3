Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0483CC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 01:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1selRC-0000nd-LT; Thu, 15 Aug 2024 21:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selR4-0000lx-SV
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:24 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selR2-0002IW-6T
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:22 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-710e39961f4so1140656b3a.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 18:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723770438; x=1724375238;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UVgqSXGbDG3KIOH2TWfF1Osar7ymB7+INCHwitRDPF4=;
 b=f5KZRmqlBBKAAR90ZaGtFlYbNbetdgRZaxnOMPoRZLzI50qDfVL5D8gXB5iBl4xQUj
 sovRNPoMvQmtGmBNF5mcg1vFYFoHw2PJlD+0VPW4jFRhgjAlpRj9xhFZnPI/v2+RFMQ/
 /VgZjUNYdzT5FkOXuVnzuN5wydiNPA9imToE4sIQKe8h79VvgP1uMjahGGQhfC8TNXd8
 lP1ND0vLRfe/oSe1utaIpUla8p6me7gTOT7YhvE4FrMksOAnLIFgyRkwSWZgYYRDAc16
 l3Idca3Pd0mor7DZ0YkdTksMJkbH9PJujHRZISGKcQjZ655Xa25mhLDfoFYlohcKsmfk
 dILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723770438; x=1724375238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UVgqSXGbDG3KIOH2TWfF1Osar7ymB7+INCHwitRDPF4=;
 b=UqtvsECw7IrPO5RbdBvzC/uibYRYPyLd69/okABypPWpHGqsGc0VMVrzl6h9oZ+moL
 yhkmeYgk99eqrs2aL63lbrd5uqRTGrnorvs3BNsWjVVooT4LzJcXgKrTAZXj3RzpYASa
 secskPgOJAWjYqVCB7W1hYZSJns98xM6/uiiZcDfS8E9qdbMU629GZzltg6/AVyO4EUP
 oIiyi4oLCUUhP2vikpJytKDh6c+4sA+1L4XnGAt0aYkOnaStb80pGO942ZOhYyEVY/VE
 vFJ753fW4fnVhCJzAHWaj2zCM0fg8DTfuhfO0kvol5Q1w1IJdhB3td8IE+pg+vZoXIoV
 llhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3SJwZdbNVJpoXWiwX6UQItyQD2fhpGvYmHr+9e8Wl1nsJJJ6AI7QoJ0bLuv5QeBGm/t/7gfF6O0JcGH1elHMK6yIgsaw=
X-Gm-Message-State: AOJu0YzL3f3mhr+Jm8cqk6fSHCXDn2QwrVXxFjYrBhf0qhJp8FrBR7LJ
 5aVRrWpkz8BzLyOgkwm+KcuDtt52tap9ax7qYtltQ0oiflgKipcVDwra2D9Pa2k=
X-Google-Smtp-Source: AGHT+IG0lcqPr/UKaw52BZDEwk7b5X7qlJqNBHsQMhXXecfdbD6oFhhVD+1Xx7hxIUuAGcCV3h+9yg==
X-Received: by 2002:a05:6a00:3cd5:b0:70d:3a27:54ca with SMTP id
 d2e1a72fcca58-713c5126a1bmr2034190b3a.22.1723770437870; 
 Thu, 15 Aug 2024 18:07:17 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae120cdsm1604806b3a.77.2024.08.15.18.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 18:07:17 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, richard.henderson@linaro.org,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v4 00/16] riscv support for control flow integrity extensions
Date: Thu, 15 Aug 2024 18:06:54 -0700
Message-ID: <20240816010711.3055425-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v4 for riscv zicfilp and zicfiss extensions support in qemu.


Links for previous versions
[1] - v1 https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg06017.html
[2] - v2 https://lore.kernel.org/all/ed23bcbc-fdc4-4492-803c-daa95880375a@linaro.org/T/
[3] - v3 https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg01005.html

---
v4:
   - elp state in cpu is true/false instead of enum and elp cleared
     unconditionally on trap entry. elp in *status cleared unconditionally on
     trap return. 
   - Moved logic for branch tracking in instruction translation from tb_start.
   - fixed zicfiss dependency on 'A'
   - `cpu_get_fcfien/bcfien` helpers checks fixed to check for extension first.
   - removed trace hook enums. Instead added dedicated trace helpers wherever needed.
   - fixed/simplified instruction format in decoder for lpad, sspush, sspopchk
   - simplified tlb index logic for shadow stack instructions. Removed SUM TB_FLAG
   - access to ssp CSR is gated on `cpu_get_bcfien` instead of duplicated logic
   - removed vDSO related changes for now. 
v3:
   - Removed prctl specific patches because they need to be upstream
     in kernel first.
   - As suggested by Richard, added TB flag if fcfi enabled
   - Re-worked translation for landing pad and shadow stack instructions
     to not require helper.
   - tcg helpers only for cfi violation cases so that trace hooks can be
     placed.
   - Style changes.
   - fixes assert condition in accel/tcg

v2:
   - added missed file (in v1) for shadow stack instructions implementation.

Deepak Gupta (16):
  target/riscv: Add zicfilp extension
  target/riscv: Introduce elp state and enabling controls for zicfilp
  target/riscv: save and restore elp state on priv transitions
  target/riscv: additional code information for sw check
  target/riscv: tracking indirect branches (fcfi) for zicfilp
  target/riscv: zicfilp `lpad` impl and branch tracking
  disas/riscv: enabled `lpad` disassembly
  target/riscv: Add zicfiss extension
  target/riscv: introduce ssp and enabling controls for zicfiss
  target/riscv: tb flag for shadow stack  instructions
  target/riscv: mmu changes for zicfiss shadow stack protection
  target/riscv: implement zicfiss instructions
  target/riscv: compressed encodings for sspush and sspopchk
  disas/riscv: enable disassembly for zicfiss instructions
  disas/riscv: enable disassembly for compressed sspush/sspopchk
  target/riscv: add trace-hooks for each case of sw-check exception

 disas/riscv.c                                 |  77 ++++++++-
 disas/riscv.h                                 |   4 +
 include/tcg/tcg.h                             |   1 +
 target/riscv/cpu.c                            |  17 ++
 target/riscv/cpu.h                            |  15 ++
 target/riscv/cpu_bits.h                       |  17 ++
 target/riscv/cpu_cfg.h                        |   2 +
 target/riscv/cpu_helper.c                     | 150 +++++++++++++++++-
 target/riscv/cpu_user.h                       |   1 +
 target/riscv/csr.c                            |  84 ++++++++++
 target/riscv/helper.h                         |   6 +
 target/riscv/insn16.decode                    |   2 +
 target/riscv/insn32.decode                    |  26 ++-
 target/riscv/insn_trans/trans_rva.c.inc       |  43 +++++
 target/riscv/insn_trans/trans_rvi.c.inc       |  56 +++++++
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 124 +++++++++++++++
 target/riscv/internals.h                      |   3 +
 target/riscv/op_helper.c                      |  37 +++++
 target/riscv/pmp.c                            |   5 +
 target/riscv/pmp.h                            |   3 +-
 target/riscv/tcg/tcg-cpu.c                    |  24 +++
 target/riscv/trace-events                     |   6 +
 target/riscv/translate.c                      |  48 ++++++
 23 files changed, 742 insertions(+), 9 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc

-- 
2.44.0


