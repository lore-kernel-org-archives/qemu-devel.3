Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDB7C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGbL-0004yX-Fr; Wed, 17 Jul 2024 22:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbJ-0004xb-4a
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:33 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbD-0003FA-G7
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:29 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fb8781ef1bso3420855ad.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268625; x=1721873425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wq+jMDWVrSkYCiGdOBPx0OV6sZXIMXmMyKfYCrgKzhc=;
 b=Fpi+liJSYXA4zv7YRZ2N7fXu4Ob7qc/NJ6nRLPlzpbQsROFToQifMYW1j62lCVlr01
 quoncjJaEeG72yWwGsaE7NDbM4TcM6HTbC3TFU8CDZ0lCjlArtoBnU9r3+zy6YTBWijg
 9PO1L/1zsOVgOeEqimrQv4NWmq6CA6WKp4r1jlq5wPdLxPH+G+eYthaGxeCFOjpdOStM
 0l2zGNZRlwXltaPVDnUOQeGj9pfyohqT3XSEg8OWVm9KA50HBnkIY5FtYaqrVOJxJBK4
 GWJyvMWRknSRzm2F//gdKWLLGkMBjeJCQpxnoyty9HnEq6qKRyrFsCb0T1zDNN2SnLID
 xjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268625; x=1721873425;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wq+jMDWVrSkYCiGdOBPx0OV6sZXIMXmMyKfYCrgKzhc=;
 b=annPOpn+8RG5NvFD89KfccJRY0JsLG4m41MxailcViYrOx0lQFmPJnr5VCXywfbDSe
 TitDDK7lOZcNhhKmoeSIJSuU43tE4CoiYleyzr8oXEhju9Gz9QFOPC+jZtciyxliyR1R
 sZz8F8U5lFxj8RKVkShFBzywsZoQ+26MDWN9oyRq3MSejZyxuLzMNTHdNzNiIY5SiNbp
 Qw2hLFdMwfxWodeyXJzOK6NKKDDptfERNe6BM9P3Y/i7P+EeB+J5UNpDWoTcP/kJ3zx6
 f5WHG150L2+C6/JN5WlRvjxgXdaAVzCmFyBCb7YxIpPadTArqvfo7DsFBCn1Qcasqm/U
 JMCw==
X-Gm-Message-State: AOJu0YzGYBqI3qklHlQ8Qldn4LPWbxIjgN2Oefxfi4aBQFqJLiqZFYMa
 SERCctF9SAImR5IHWRdCpV2GBfzJCY+gYYlwr+1B3co9N/ekNLiI1d/3RODV
X-Google-Smtp-Source: AGHT+IHYNRc49h7HDOrxX8RrFTZ02jxTJANaqhgjKo90doY6ok/Iib2MuwCuCdViqVOFB01XK5bHtg==
X-Received: by 2002:a17:902:fa4c:b0:1fb:85ff:3f92 with SMTP id
 d9443c01a7336-1fc4e6a4df8mr24181815ad.53.1721268624994; 
 Wed, 17 Jul 2024 19:10:24 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:10:24 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/30] riscv-to-apply queue
Date: Thu, 18 Jul 2024 12:09:42 +1000
Message-ID: <20240718021012.2057986-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

The following changes since commit 58ee924b97d1c0898555647a31820c5a20d55a73:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-07-17 15:40:28 +1000)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240718-1

for you to fetch changes up to daff9f7f7a457f78ce455e6abf19c2a37dfe7630:

  roms/opensbi: Update to v1.5 (2024-07-18 12:08:45 +1000)

----------------------------------------------------------------
RISC-V PR for 9.1

* Support the zimop, zcmop, zama16b and zabha extensions
* Validate the mode when setting vstvec CSR
* Add decode support for Zawrs extension
* Update the KVM regs to Linux 6.10-rc5
* Add smcntrpmf extension support
* Raise an exception when CSRRS/CSRRC writes a read-only CSR
* Re-insert and deprecate 'riscv,delegate' in virt machine device tree
* roms/opensbi: Update to v1.5

----------------------------------------------------------------
Atish Patra (7):
      target/riscv: Fix the predicate functions for mhpmeventhX CSRs
      target/riscv: Only set INH fields if priv mode is available
      target/riscv: Implement privilege mode filtering for cycle/instret
      target/riscv: Save counter values during countinhibit update
      target/riscv: Enforce WARL behavior for scounteren/hcounteren
      target/riscv: Do not setup pmu timer if OF is disabled
      target/riscv: Expose the Smcntrpmf config

Balaji Ravikumar (1):
      disas/riscv: Add decode for Zawrs extension

Daniel Henrique Barboza (3):
      target/riscv/kvm: update KVM regs to Linux 6.10-rc5
      hw/riscv/virt.c: re-insert and deprecate 'riscv,delegate'
      roms/opensbi: Update to v1.5

Jiayi Li (1):
      target/riscv: Validate the mode in write_vstvec

Kaiwen Xue (3):
      target/riscv: Add cycle & instret privilege mode filtering properties
      target/riscv: Add cycle & instret privilege mode filtering definitions
      target/riscv: Add cycle & instret privilege mode filtering support

LIU Zhiwei (11):
      target/riscv: Add zimop extension
      disas/riscv: Support zimop disassemble
      target/riscv: Add zcmop extension
      disas/riscv: Support zcmop disassemble
      target/riscv: Support Zama16b extension
      target/riscv: Move gen_amo before implement Zabha
      target/riscv: Add AMO instructions for Zabha
      target/riscv: Move gen_cmpxchg before adding amocas.[b|h]
      target/riscv: Add amocas.[b|h] for Zabha
      target/riscv: Expose zabha extension as a cpu property
      disas/riscv: Support zabha disassemble

Rajnesh Kanwal (3):
      target/riscv: Combine set_mode and set_virt functions.
      target/riscv: Start counters from both mhpmcounter and mcountinhibit
      target/riscv: More accurately model priv mode filtering.

Yu-Ming Chang (1):
      target/riscv: raise an exception when CSRRS/CSRRC writes a read-only CSR

 docs/about/deprecated.rst                      |  11 +
 target/riscv/cpu.h                             |  24 +-
 target/riscv/cpu_bits.h                        |  41 ++
 target/riscv/cpu_cfg.h                         |   5 +
 target/riscv/pmu.h                             |   4 +
 target/riscv/insn16.decode                     |   1 +
 target/riscv/insn32.decode                     |  33 ++
 disas/riscv.c                                  | 187 +++++++++
 hw/riscv/virt.c                                |   9 +
 target/riscv/cpu.c                             |  10 +
 target/riscv/cpu_helper.c                      |  66 ++--
 target/riscv/csr.c                             | 501 ++++++++++++++++++++-----
 target/riscv/kvm/kvm-cpu.c                     |   2 +
 target/riscv/machine.c                         |   5 +-
 target/riscv/op_helper.c                       |  23 +-
 target/riscv/pmu.c                             | 181 ++++++++-
 target/riscv/tcg/tcg-cpu.c                     |   5 +
 target/riscv/translate.c                       |  38 ++
 target/riscv/insn_trans/trans_rva.c.inc        |  51 +--
 target/riscv/insn_trans/trans_rvd.c.inc        |  14 +-
 target/riscv/insn_trans/trans_rvf.c.inc        |  14 +-
 target/riscv/insn_trans/trans_rvi.c.inc        |   6 +
 target/riscv/insn_trans/trans_rvzabha.c.inc    | 145 +++++++
 target/riscv/insn_trans/trans_rvzacas.c.inc    |  13 -
 target/riscv/insn_trans/trans_rvzcmop.c.inc    |  29 ++
 target/riscv/insn_trans/trans_rvzimop.c.inc    |  37 ++
 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin | Bin 267416 -> 268312 bytes
 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin | Bin 270808 -> 272504 bytes
 roms/opensbi                                   |   2 +-
 29 files changed, 1246 insertions(+), 211 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvzabha.c.inc
 create mode 100644 target/riscv/insn_trans/trans_rvzcmop.c.inc
 create mode 100644 target/riscv/insn_trans/trans_rvzimop.c.inc

