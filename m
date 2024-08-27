Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5986C54743
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 23:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj5T4-0002Xl-9m; Tue, 27 Aug 2024 19:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5T1-0002XE-9v
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:15 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5Sy-0000pI-UH
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:15 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20230059241so51211485ad.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 16:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724800751; x=1725405551;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SvjKf/rIfA9jaUUelUyDC9d4Ohp0wbx6FhHiek9InnE=;
 b=ffsoHNJWSgl5cFSsxrout88ZyehDI/PzcYvHPd8PgZ6tudCy5CKoJIAZto3dyaWNTB
 MT+UEC/VBR4e7VI7sxdKRweUu2FBJrcEllhZDpOIF239Fq69xYQDrXFrAYtxr/yaCq06
 l4q1HS/0tT3Zhm6rbKB8esmY6U4dnnZ5QKgyL4GYXin1XRHD87wvyr0iMdKxWg+Jmhfd
 8uVW1B8HN+YqWdDVeIEbUiIm8y5k0RYzUH/LOXtp/kk6zM7KhVOQhrx86BgF9FjqIXUH
 T6qpRrFspbJCDZ7yoFYXOuJTj2etrdsMrMybqOpb6aLK6nB7pne70047I0H/5VfZb3P0
 xZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800751; x=1725405551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SvjKf/rIfA9jaUUelUyDC9d4Ohp0wbx6FhHiek9InnE=;
 b=KKyD3huwo0yG5/5y7eVfAgxRMtMIvv4WdgyEjSl1pjhUDhzPHbs6msHUhZ6yqX5cjd
 PpS9ip7AtxQvU+tmu5dfXNh4YOexwzBluTycfMc2rSB6jTK5dvhV7rksYerZVR593Jew
 QOoZzWKDz9pYvykWpVDu34hnkvnyKbXF+Uesxca9wAv8qVCn+E3TJ+5sGTzQaWMuQM1q
 5KdiC+ajzEdeOrrSS8x8hS8ky9QwAcCVbY55Mfy64EYVqh/uXpsjzLWXGRDMYjxXlYX1
 PFI+yb8mCWO3jfGYFEc3FOVDk0JMRSKIPqEM4oufnBXpD1NAf7O8dO2u8k5TH1tl872I
 guYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoNElvMkKSMi/WjgCegy0jEYqExDaVemnEbv48fok3HtjOLTPnDwjAngzzPseg+fDUS9nOUCiqjCKL@nongnu.org
X-Gm-Message-State: AOJu0Yy++i5UrU8JMd5etb9QUrfuRSWDPp9TIthzICcpB/LAWydGrTZX
 YBsp0L5t7a0FD7hnU8Uev7EzXljjDAYAfIYjB4whZLDot/AQ7w6H+pnPdTQUwpw=
X-Google-Smtp-Source: AGHT+IGnN4voApBT8H5C5035zpNPR75MKcMXN9eLyN+BcpQyHEQH78KuxbILwSOFr6o4MLFQjHBo5Q==
X-Received: by 2002:a17:902:f60a:b0:1fb:35c7:8eb2 with SMTP id
 d9443c01a7336-2039e512374mr149040595ad.55.1724800750921; 
 Tue, 27 Aug 2024 16:19:10 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0ee6179sm57785155ad.92.2024.08.27.16.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:19:10 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v10 00/21] riscv support for control flow integrity extensions
Date: Tue, 27 Aug 2024 16:18:44 -0700
Message-ID: <20240827231906.553327-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62a.google.com
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

v10 for riscv zicfilp and zicfiss extensions support in qemu.

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

Deepak Gupta (21):
  target/riscv: expose *envcfg csr and priv to qemu-user as well
  linux-user/riscv: set priv for qemu-user and defaults for *envcfg
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
 linux-user/riscv/cpu_loop.c                   |   4 +
 target/riscv/cpu.c                            |  10 ++
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
 30 files changed, 726 insertions(+), 53 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc

-- 
2.44.0


