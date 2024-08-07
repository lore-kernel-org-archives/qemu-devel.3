Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F05C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 00:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbUD9-0003GL-OW; Tue, 06 Aug 2024 20:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUCl-0002Ud-9x
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:03 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUCh-000179-4r
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:02 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fb3b7d0d56so7907995ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 17:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722989217; x=1723594017;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yVrfmqZuHnqczvhQ8mgDAmJCmYFAwaLihn73o8nyeTo=;
 b=JhGu7Yj+NNfCTbcBitoRRPXAID+Tk4kzTAY1SBJl02ASRyA2TM0HafTpXx6nEg/ZXF
 7vt8SIPAmCEU6wloJzKImX4WJIjc6gIhQJND+altL/l4QqTibFXqmBboV6TpU6juHa+e
 NzNPF9fZFZF9YPN+ALGlPSuatbQ3iuihy0qrj6BWOYHE/bZiRKLVKfVbQSeVxgmB5WmI
 QvkFTWNUCL0kfJk8/yA55uwrdfbYC0K0sXqXMeddBsb/yHUUCFOMxMuU+8juUaqkXkjK
 H2hOLWmKt4I+/cC6oVhAC2L3L073ptN3G+Y1cyHHMrVAS3VJSDFRbY/IqfMf0OcOST7p
 393g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722989217; x=1723594017;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yVrfmqZuHnqczvhQ8mgDAmJCmYFAwaLihn73o8nyeTo=;
 b=lOf3QVMaD+lCx8nKQK7+7fNL0raFDWt9eETF0C8mg9f9WYC3bAGA+xVLMNkmXre2/+
 L6rb70d9ppJ6ksl44k/z37nQxXal4O3PHiRGABExuTrPYXugGbR+4OlzhbhPOItES2N3
 wSyQtI5Q1W4Fant3aczRN+uCNDOdu5k1DsaEVONLrBDeYRdBJXPjoVXCz3XkKIqcS5vd
 XeG7CP4PNcZVvzW1GPAIbJy6iyN5k1wGrjJH/nmedauxPKr3KZKYOufW51/hRzr5XpWN
 ga2LystwzWOcNzbs9zEAcBXoMOpmfyuuq4RwVuDcb7nbLSZNUj+3GTBHw+D4u8znQTul
 vmYw==
X-Gm-Message-State: AOJu0Yx7996++z/N2bopeFwHE4oMt871jLsbgyfCwxm6urvJuy4Ubhzw
 RR4CcBMkEHzXSnnQFtkbBHSXfCgeeo04jMCdX7QFr3X2w0SlMBqzuQVl3udY0u8UpTwAuTmf51L
 r
X-Google-Smtp-Source: AGHT+IGrWTuY4gLkAZ5811juyY9OLkLLKk3PVLl4ZL8WMt52tRAa1QsdM8FgtL25td0zNYzjWW/fRw==
X-Received: by 2002:a17:902:f54b:b0:1ff:4618:36c2 with SMTP id
 d9443c01a7336-1ff57257f12mr184178655ad.10.1722989216527; 
 Tue, 06 Aug 2024 17:06:56 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f59cc2sm93381845ad.92.2024.08.06.17.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 17:06:56 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v3 00/20] riscv support for control flow integrity extensions
Date: Tue,  6 Aug 2024 17:06:31 -0700
Message-ID: <20240807000652.1417776-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Sending out v3 for riscv zicfilp and zicfiss extensions support in qemu.
I sent out v1 [1] and v2 [2] a while ago.

[1] - https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg06017.html
[2] - https://lore.kernel.org/all/ed23bcbc-fdc4-4492-803c-daa95880375a@linaro.org/T/

---
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
  accel/tcg: restrict assert on icount_enabled to qemu-system
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
  target/riscv: implement zicfiss instructions
  target/riscv: compressed encodings for sspush and sspopchk
  target/riscv: mmu changes for zicfiss shadow stack protection
  target/riscv: shadow stack mmu index for shadow stack instructions
  disas/riscv: enable disassembly for zicfiss instructions
  disas/riscv: enable disassembly for compressed sspush/sspopchk
  target/riscv: add trace-hooks for each case of sw-check exception
  linux-user: permit RISC-V CFI dynamic entry in VDSO
  linux-user: Add RISC-V zicfilp support in VDSO

 accel/tcg/cpu-exec.c                          |   2 +-
 disas/riscv.c                                 |  71 +++++++-
 disas/riscv.h                                 |   4 +
 linux-user/gen-vdso-elfn.c.inc                |   7 +
 linux-user/riscv/vdso-64.so                   | Bin 3944 -> 4128 bytes
 linux-user/riscv/vdso.S                       |  50 ++++++
 target/riscv/cpu.c                            |  17 ++
 target/riscv/cpu.h                            |  28 +++
 target/riscv/cpu_bits.h                       |  29 +++
 target/riscv/cpu_cfg.h                        |   2 +
 target/riscv/cpu_helper.c                     | 167 +++++++++++++++++-
 target/riscv/cpu_user.h                       |   1 +
 target/riscv/csr.c                            | 106 +++++++++++
 target/riscv/helper.h                         |   3 +
 target/riscv/insn16.decode                    |   4 +
 target/riscv/insn32.decode                    |  23 ++-
 target/riscv/insn_trans/trans_rva.c.inc       |  55 ++++++
 target/riscv/insn_trans/trans_rvi.c.inc       |  68 +++++++
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 155 ++++++++++++++++
 target/riscv/internals.h                      |   4 +
 target/riscv/op_helper.c                      |  49 +++++
 target/riscv/pmp.c                            |   5 +
 target/riscv/pmp.h                            |   3 +-
 target/riscv/tcg/tcg-cpu.c                    |  20 +++
 target/riscv/trace-events                     |   6 +
 target/riscv/translate.c                      |  75 ++++++++
 26 files changed, 945 insertions(+), 9 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc

-- 
2.44.0


