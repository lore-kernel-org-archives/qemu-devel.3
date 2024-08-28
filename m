Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B870C636ED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 17:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjMm0-0006my-3g; Wed, 28 Aug 2024 13:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjMlt-0006X6-HN
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:47:53 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjMlp-0004PF-H1
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:47:53 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2021c03c13aso7794755ad.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 10:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724867266; x=1725472066;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UZJps+EUHcZoq37h9DE5bexnHRO8yBnuf/NqiODFi5U=;
 b=dAY7nSvQQqm91frSoj7qUKwCfKMCK7eJM3RNd8X7fJ4TyuBohqqdILAdBUiMX/i0ka
 DnZQt38aFKV26tihSL/v1+qQ/SNX+AULGgJ2aIPKaAs6A1vcHstuNbgNfgOVyr+zbteT
 JlcbmkGZnL1uqAPPEMx5f/RASd2LV0ogD/jsm+QOU+Do8Kg/q8b+gHEZzBB5pykCEI8I
 caeFGTikYijs3zzbUH+PaJNZ7pTHMJnUvunkFHueedk3AV/7zEBijvv1ZlzbRk64fw0V
 Hvm1ZKif6wHsFRXBYwbYAXiIPFBslq+LVcMEHfSh8KiJzpd4CI3F9WfB3Hb57Zmw8d2f
 /uiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724867266; x=1725472066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UZJps+EUHcZoq37h9DE5bexnHRO8yBnuf/NqiODFi5U=;
 b=cf9Z1K5VOSdO1fdctd0m+ehG/gqdNMcASZwkOQFYFvhYBLCWl75i7jwprCt3rJUL2K
 b6jrmpBD6d074wuG2kXlRTZmmrtnw8YWhOoEEU7AfMAvVbWCeFgm6WP+P0fGs7ag6AO2
 al8hsFeHlB+ehzHkefQ/PJU9JlGbYt/oxTUB4794RFKYHKl9lpVt97QKhzQQJ9G/9lIx
 dkmMIsW1ZU6Ww9U16VeoUTxTJoLvQc2ieZSLsZXEM+p5RLHp573VpP94lagsiOz2iaUv
 RlaCGPbC2siqcDufBmgR4962xfP/nUhRe6SD/IZv6pkSz+XiO34TKGdzBHxCJoCVdlYi
 sJ7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrbOCBCZSx5sv0w5nDPlmz6wQ+t6gYj5x95JMcerofgz/eD4M3y7bmnLCQ0FcQC6VsTsJzYkgyRzHP@nongnu.org
X-Gm-Message-State: AOJu0Ywu6W3DNkkeoiBuPKz06+j+VyypHFdMcLawatmr0OtECZcWl9Xh
 oXjkuNEb7hfE/X2qGnCYvDYy24yAes1OAyRD1Kci1Y3Klgt7nsYFRWYB1ZvBSC0=
X-Google-Smtp-Source: AGHT+IGurCn798Lhcj0+l8PKBytogQMGYryDn4RA9FIwZmC6ASjeZ5rssqDXe8MajGcjYZBEdGd80Q==
X-Received: by 2002:a17:902:da8c:b0:202:3469:2c8d with SMTP id
 d9443c01a7336-204f9ca6f75mr41565105ad.28.1724867265632; 
 Wed, 28 Aug 2024 10:47:45 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9acdcf7dsm9778316a12.50.2024.08.28.10.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 10:47:45 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v11 00/20] riscv support for control flow integrity extensions
Date: Wed, 28 Aug 2024 10:47:18 -0700
Message-ID: <20240828174739.714313-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62d.google.com
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

v11 for riscv zicfilp and zicfiss extensions support in qemu.

Links for previous versions
[1] - v1 https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg06017.html
[2] - v2 https://lore.kernel.org/all/ed23bcbc-fdc4-4492-803c-daa95880375a@linaro.org/T/
[3] - v3 https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg01005.html
[4] - v4 https://lore.kernel.org/all/20240816010711.3055425-6-debug@rivosinc.com/T/
[5] - v5
+https://lore.kernel.org/all/20240820000129.3522346-1-debug@rivosinc.com/T/#m7b9cc847e739ec86f9569a3ca9f3d9377b01e21
[6] - v6 https://mail.gnu.org/archive/html/qemu-riscv/2024-08/msg00418.html
[7] - v7 https://lore.kernel.org/all/20240822082504.3979610-1-debug@rivosinc.com/
[8] - v8 https://lore.kernel.org/all/20240823190140.4156920-1-debug@rivosinc.com/T/
[9] - v9 https://lore.kernel.org/all/20240826152949.294506-1-debug@rivosinc.com/

---
v10:
   - Exposed *envcfg CSR and priv to qemu-user as well and removed special
     state management for *envcfg related feature enabling for qemu-user
   - Exposing zicfilp and zicfiss as different patch
v9:
   - fix switch case fallthrough for sw_check excp in patch 4
v8:
   - fixed up `gen_cmpxchg` to store extra word2 during compile to raise storeAMO always
v7:
   - Updated decode_save_opc to take extra argument of excp_uw2 and
     updated callsites
   - added a helper for promoting load faults to store faults
   - Removed stale comments and edited existed comments
v6:
   - Added support extra store word 2 for tcg compile and extraction during unwind
   - Using extra word, AMO instructions and shadow stack instructions can raise store fault
   - some alignment and cosmetic changes
   - added vmstate migration support for elp and ssp cpu state
v5:
   - Simplified elp tracking and lpad implementation as per suggestion by richard
   - Simplified shadow stack mmu checks as per suggestion by richard
   - Converged zicfiss compressed and non-comressed instructions to same translation
   - Removed trace hooks. Don't need for upstream.

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

Deepak Gupta (20):
  target/riscv: expose *envcfg csr and priv to qemu-user as well
  target/riscv: Add zicfilp extension
  target/riscv: Introduce elp state and enabling controls for zicfilp
  target/riscv: save and restore elp state on priv transitions
  target/riscv: additional code information for sw check
  target/riscv: tracking indirect branches (fcfi) for zicfilp
  target/riscv: zicfilp `lpad` impl and branch tracking
  disas/riscv: enable `lpad` disassembly
  target/riscv: Expose zicfilp extension as a cpu property
  target/riscv: Add zicfiss extension
  target/riscv: introduce ssp and enabling controls for zicfiss
  target/riscv: tb flag for shadow stack  instructions
  target/riscv: mmu changes for zicfiss shadow stack protection
  target/riscv: AMO operations always raise store/AMO fault
  target/riscv: update `decode_save_opc` to store extra word2
  target/riscv: implement zicfiss instructions
  target/riscv: compressed encodings for sspush and sspopchk
  disas/riscv: enable disassembly for zicfiss instructions
  disas/riscv: enable disassembly for compressed sspush/sspopchk
  target/riscv: Expose zicfiss extension as a cpu property

 disas/riscv.c                                 |  77 ++++++++-
 disas/riscv.h                                 |   4 +
 target/riscv/cpu.c                            |  14 ++
 target/riscv/cpu.h                            |  31 +++-
 target/riscv/cpu_bits.h                       |  17 ++
 target/riscv/cpu_cfg.h                        |   2 +
 target/riscv/cpu_helper.c                     | 155 +++++++++++++++++-
 target/riscv/cpu_user.h                       |   1 +
 target/riscv/csr.c                            |  84 ++++++++++
 target/riscv/insn16.decode                    |   4 +
 target/riscv/insn32.decode                    |  26 ++-
 .../riscv/insn_trans/trans_privileged.c.inc   |   8 +-
 target/riscv/insn_trans/trans_rva.c.inc       |  43 ++++-
 target/riscv/insn_trans/trans_rvd.c.inc       |   4 +-
 target/riscv/insn_trans/trans_rvf.c.inc       |   4 +-
 target/riscv/insn_trans/trans_rvh.c.inc       |   8 +-
 target/riscv/insn_trans/trans_rvi.c.inc       |  61 ++++++-
 target/riscv/insn_trans/trans_rvvk.c.inc      |  10 +-
 target/riscv/insn_trans/trans_rvzacas.c.inc   |   4 +-
 target/riscv/insn_trans/trans_rvzfh.c.inc     |   4 +-
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  75 +++++++++
 target/riscv/insn_trans/trans_svinval.c.inc   |   6 +-
 target/riscv/internals.h                      |   3 +
 target/riscv/machine.c                        |  38 +++++
 target/riscv/op_helper.c                      |  18 ++
 target/riscv/pmp.c                            |   5 +
 target/riscv/pmp.h                            |   3 +-
 target/riscv/tcg/tcg-cpu.c                    |  25 +++
 target/riscv/translate.c                      |  45 ++++-
 29 files changed, 726 insertions(+), 53 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc

-- 
2.44.0


