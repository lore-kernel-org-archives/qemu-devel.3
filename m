Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE189C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 21:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgtDl-0004uw-3x; Wed, 21 Aug 2024 17:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgtDj-0004te-TT
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:50:23 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgtDh-00083y-SY
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:50:23 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fc47abc040so1541405ad.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 14:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724277020; x=1724881820;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gmNCeFg+iNjMCag33jf5Wlc5jeP9l7YxDGZwtpUEJLs=;
 b=XINqd+qPkr14hu9YPvCiI5yKPojISzCPdnOpifS4AOxSOZ1iiCqR1nGZjR55Et26mk
 wFBgN3PE5asWe5wAjb0q0OSVwv02YnsHRWzwnmCeNdoCNUEeZWep4JSrRscZKSK9vTTy
 2y5XcL4bmsheaZVAmClThPbx2KaXcKAE0k2CJQJAdksyCHt65kz6GBui4BkrnYnXYcKI
 vlhUiVsyPYIWOg+M0ApQ59MimHIBE71YY90N7eG3Vd/+lN0vfB5THTyLem1EE7WwUIhv
 qr3Fo4nbhj+RJo5nwpxY8kH8dy/3nfe8WbGojRKAUB2wEssouIHVwR5ACZWjjtbHtNnk
 dkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724277020; x=1724881820;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gmNCeFg+iNjMCag33jf5Wlc5jeP9l7YxDGZwtpUEJLs=;
 b=Z3Msnpyw27dDxV+BUR5Q56/OL6AR+ElBYJSQAL3FTME6H3OiGaA6FZ38cS2fpbtO8I
 2CjMu8Gq3ROkFDg9g8L1Xg81vJGteKuH43Gs8jd8dg7d4RPWjl72QcAL1ztsszMEKAt/
 oGo3topHEC3SnwZl7AFrv7xHxo9EZVd8TNAIpS0ai1yZzSlwE2oylpK2dmD6y/xza93D
 G1HKVuqJkNvRcnGEf1TOA/axrDoCNt8IIsZq69ZC1lFCbqj1/CM1gCbkeATDuqybtevG
 ev5w2RsL+2d40H5+N/pB7xnR7LpIfpbpgVI4Ax20NpJ9I7xKKtN9DfKt6YENj/udsubv
 vD9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtULtDfrqAbZS47sCv1ihkz6jedFxA/H9uBOfAvSPUNOsSxL3Q6BY9LI9Gknu4v/hU2YnLGE797Zxh@nongnu.org
X-Gm-Message-State: AOJu0YxIvLddyqX4z/C97sF0HxQSVMzQQDciOu1DDLG3Cd/wXbvH53HF
 31f78Kn29tYIt2AXWpgAkK9/RANu8Hd4A16jdbnEkcb9bvACkF7MkU8hwyBuQIw=
X-Google-Smtp-Source: AGHT+IH3ntLz8NDAW+G5OMQGO6R0L2NaTpf/TJQroFQNnExgyVPn/ARqY+ktdggJteaknrYPqKvduQ==
X-Received: by 2002:a17:902:db05:b0:202:671:e5bc with SMTP id
 d9443c01a7336-20368074234mr40789605ad.42.1724277019323; 
 Wed, 21 Aug 2024 14:50:19 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203859ef0fdsm586345ad.248.2024.08.21.14.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 14:50:19 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v6 00/16] riscv support for control flow integrity extensions
Date: Wed, 21 Aug 2024 14:49:58 -0700
Message-ID: <20240821215014.3859190-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x631.google.com
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

v6 for riscv zicfilp and zicfiss extensions support in qemu.

Links for previous versions
[1] - v1 https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg06017.html
[2] - v2 https://lore.kernel.org/all/ed23bcbc-fdc4-4492-803c-daa95880375a@linaro.org/T/
[3] - v3 https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg01005.html
[4] - v4 https://lore.kernel.org/all/20240816010711.3055425-6-debug@rivosinc.com/T/
[5] - v5 https://lore.kernel.org/all/20240820000129.3522346-1-debug@rivosinc.com/T/#m7b9cc847e739ec86f9569a3ca9f3d9377b01e21e

---
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

Deepak Gupta (16):
  target/riscv: Add zicfilp extension
  target/riscv: Introduce elp state and enabling controls for zicfilp
  target/riscv: save and restore elp state on priv transitions
  target/riscv: additional code information for sw check
  target/riscv: tracking indirect branches (fcfi) for zicfilp
  target/riscv: zicfilp `lpad` impl and branch tracking
  disas/riscv: enable `lpad` disassembly
  target/riscv: Add zicfiss extension
  target/riscv: introduce ssp and enabling controls for zicfiss
  target/riscv: tb flag for shadow stack  instructions
  target/riscv: mmu changes for zicfiss shadow stack protection
  target/riscv: AMO operations always raise store/AMO fault
  target/riscv: implement zicfiss instructions
  target/riscv: compressed encodings for sspush and sspopchk
  disas/riscv: enable disassembly for zicfiss instructions
  disas/riscv: enable disassembly for compressed sspush/sspopchk

 disas/riscv.c                                 |  77 ++++++++-
 disas/riscv.h                                 |   4 +
 target/riscv/cpu.c                            |  17 ++
 target/riscv/cpu.h                            |  24 ++-
 target/riscv/cpu_bits.h                       |  17 ++
 target/riscv/cpu_cfg.h                        |   2 +
 target/riscv/cpu_helper.c                     | 148 +++++++++++++++++-
 target/riscv/cpu_user.h                       |   1 +
 target/riscv/csr.c                            |  84 ++++++++++
 target/riscv/insn16.decode                    |   4 +
 target/riscv/insn32.decode                    |  26 ++-
 target/riscv/insn_trans/trans_rva.c.inc       |  43 +++++
 target/riscv/insn_trans/trans_rvi.c.inc       |  55 +++++++
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  77 +++++++++
 target/riscv/internals.h                      |   3 +
 target/riscv/machine.c                        |  38 +++++
 target/riscv/op_helper.c                      |  18 +++
 target/riscv/pmp.c                            |   5 +
 target/riscv/pmp.h                            |   3 +-
 target/riscv/tcg/tcg-cpu.c                    |  25 +++
 target/riscv/translate.c                      |  43 ++++-
 21 files changed, 699 insertions(+), 15 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc

-- 
2.44.0


