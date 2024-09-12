Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEB1EEE270
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 23:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sotcy-0004M7-MG; Thu, 12 Sep 2024 19:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotcv-0004Gk-Vm
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:29 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotct-000871-G7
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:29 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7db1f13b14aso1424319a12.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 16:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726185204; x=1726790004;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZwlXX0B4mV+rfetJEHOYqTcHII/EoULVzyFVXJFS27c=;
 b=cem9pir493TMqrobv/IU8kTQnGiEPNqTWxfqwh6gnXpUxPBR15vkKUBPmQJk0+Zw7D
 Tal66H/AqGVuBQRn0/yIIondsLr6glhMcBz8da8+Ozakv1o03BLHNFjxY2NRecYkeNsg
 00jtCSd4LZrI1wQp9IRl5rGWYsa1ahtKOhV5Al+umHNN3xAxSCbhgVU77DlhH5Y4GCRG
 y653FhVM41yvaI8qqpfhDUmJ3nAk13eyRnV8k0vv2VBIWUiDHSSc1Y8e9yGSAx88N/Vp
 OnX0aw/b3OZWmmJq/cnduExHUQvQJWbQt+MzbMBD1hMvhKcWgTrP0xtxETZoxiv1kj2I
 c1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726185204; x=1726790004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZwlXX0B4mV+rfetJEHOYqTcHII/EoULVzyFVXJFS27c=;
 b=xSuKfHp8QOsjLuqzoyNizQH+cSD+3XsGLEjxOakCDA5AFXevytLLKs4ovsWMlLtM5B
 C2oRH2fI0kCA/aY4Qp3UfnTV9gusDd3U5AZkQ2AY5bv2aQw/asFDQtF4mQ3PfGwQkCzZ
 W7ii6xeINnb9iHbn+CAkWKzBgp+XBndDs3z1kspAFqH5rIX2CxYkLxR1w0Q+dTQrXGPs
 qHvFzrwL1qbwpg1xrqX57TMPiDP4UiDEQ9D/6BwnKAQJ1giqaCk3WLaGq5WZojmPa0d8
 CkH71SUglYmGWJM+mIeb5x1vUxnwtWmZ/21g86WU36XDiNonVMvzh8aTXNJWd86TbDv+
 o7AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVukMHK1PKTtWjM2SzB+F0QSsXbgFnPXeFfFR3ewHJzcGD8jVbeWAhnvUGUqjC/0p02gaoTZ4TcGgrM@nongnu.org
X-Gm-Message-State: AOJu0YzjOLKQkH6lkLb2PhBssACB8ZeepNYJcRdI15ZZxcuFw9kxq/3q
 +McozC5QTwflaI8+VH1yUploIWZK6fS3tuDrLIE+IW0zrSpWC/5v57YsWe5aG34=
X-Google-Smtp-Source: AGHT+IFDn4k/ejoLguuJNgCtWzos6lPGDsFt+XIQhOFUQYtso0z12ZYqCrNKjrw3LUHHuqfGokioDQ==
X-Received: by 2002:a05:6a21:58d:b0:1cf:29a8:8e1c with SMTP id
 adf61e73a8af0-1cf75f6544fmr7221584637.28.1726185204268; 
 Thu, 12 Sep 2024 16:53:24 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe22e6sm5102229b3a.66.2024.09.12.16.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 16:53:23 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v14 00/20] riscv support for control flow integrity extensions
Date: Thu, 12 Sep 2024 16:53:00 -0700
Message-ID: <20240912235320.3768582-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=debug@rivosinc.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

v14 for riscv zicfilp and zicfiss extensions support in qemu.

v14 is rebased on https://github.com/alistair23/qemu/blob/riscv-to-apply.next

zicfilp and zicfiss spec pdf
https://github.com/riscv/riscv-cfi/releases/download/v1.0/riscv-cfi.pdf

github sources to spec
https://github.com/riscv/riscv-cfi

I have kept names of `cpu_get_bcfien` or `cpu_get_fcfien` same and didn't change
them because in most cases when they're used, they are conveying intent of whether
in current execution environment backward cfi / forward cfi is enabled or not.

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
[10]- v10 https://lore.kernel.org/all/20240827231906.553327-1-debug@rivosinc.com/
[11]- v11 https://lore.kernel.org/all/20240828174739.714313-1-debug@rivosinc.com/
[12]- v12 https://lore.kernel.org/all/20240829233425.1005029-1-debug@rivosinc.com/

---
v14:
   - Rebased on https://github.com/alistair23/qemu/blob/riscv-to-apply.next
v13:
   - Fixed bug(s) reported by richard that
         - shadow stack doesn't exist in M-mode
         - shadow stack is not available in M + U only config
   - updated commit messages with removal of `ufcfien` and `ubcfien` mentions
v12
   - Moved ssamoswap to trans_rvzicfiss.
   - Fixed bcfi_enabled in disascontext to rely only on tb flag
   - added comment on why PMP_TRANSLATE_FAIL for stores on shadow stack page

v11:
   - default *envcfg and priv for qemu-user are handled in `riscv_cpu_reset_hold`
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

 disas/riscv.c                                 |  77 +++++++-
 disas/riscv.h                                 |   4 +
 target/riscv/cpu.c                            |  14 ++
 target/riscv/cpu.h                            |  31 +++-
 target/riscv/cpu_bits.h                       |  17 ++
 target/riscv/cpu_cfg.h                        |   2 +
 target/riscv/cpu_helper.c                     | 166 +++++++++++++++++-
 target/riscv/cpu_user.h                       |   1 +
 target/riscv/csr.c                            |  84 +++++++++
 target/riscv/insn16.decode                    |   4 +
 target/riscv/insn32.decode                    |  26 ++-
 .../riscv/insn_trans/trans_privileged.c.inc   |   8 +-
 target/riscv/insn_trans/trans_rva.c.inc       |   4 +-
 target/riscv/insn_trans/trans_rvd.c.inc       |   4 +-
 target/riscv/insn_trans/trans_rvf.c.inc       |   4 +-
 target/riscv/insn_trans/trans_rvh.c.inc       |   8 +-
 target/riscv/insn_trans/trans_rvi.c.inc       |  61 ++++++-
 target/riscv/insn_trans/trans_rvvk.c.inc      |  10 +-
 target/riscv/insn_trans/trans_rvzacas.c.inc   |   4 +-
 target/riscv/insn_trans/trans_rvzfh.c.inc     |   4 +-
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 114 ++++++++++++
 target/riscv/insn_trans/trans_svinval.c.inc   |   6 +-
 target/riscv/internals.h                      |   3 +
 target/riscv/machine.c                        |  38 ++++
 target/riscv/op_helper.c                      |  17 ++
 target/riscv/pmp.c                            |   5 +
 target/riscv/pmp.h                            |   3 +-
 target/riscv/tcg/tcg-cpu.c                    |  29 +++
 target/riscv/translate.c                      |  44 ++++-
 29 files changed, 738 insertions(+), 54 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc

-- 
2.45.0


