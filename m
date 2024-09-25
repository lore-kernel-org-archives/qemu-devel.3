Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B22C369D5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 11:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stQf1-0004ve-8g; Wed, 25 Sep 2024 07:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1stQev-0004ih-A7
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:58:17 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1stQes-0000fa-13
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:58:17 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cb57f8b41so84957435e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 04:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727265491; x=1727870291;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JdiM/vMC6kwB+47P6/N1vNq+bAgMUMJgOFL7dhTNZgw=;
 b=pCptGC9F3B00IgBr4OC7iTw0xuTIo3nzotWJBTDOo5RSP6+QYuDceUpv+LL4zU3rqE
 arlts4DM7llhTT3b87vjSvUxdhVrV34EtAuuP/5jQ5udEtqenOyiUOgS7/oRiP6MvRWx
 93sOrcDgfQpZ+IyC+Uk6uljOlkRTjk4jlIh0Q81qNaq1RM9wcauNNd01iEnnO5vLlu0s
 Iosv8rUk2DIrUCfJv+Zw39UGT9hv3SJ2hbfYcJ1wuKT/i+Sry/v6fY3gkaKVrG0cpUVe
 39Tk5O/xiyQv4mGV+TIR/3eMgZTfteu0pMb0xzRScs87NE0Crr8WLPe+Rn16khBlaiDE
 mTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727265491; x=1727870291;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JdiM/vMC6kwB+47P6/N1vNq+bAgMUMJgOFL7dhTNZgw=;
 b=WlNcc+ZzFwkvxIk7YHrZCorv+Y57UHisyC/p4buIcqD96Sa3sghR61/yvVkI8mroiM
 t3lKKyXN6sULf5bt7886+4PueAeEmjg27bYBzec/BWQZeYCsLX+i27oACTTeqLZpxRfF
 sD56Q2/KSBCSGBFi5B0SR4DVywyd5EGvA8H+UXWVKYK8OXfQU2mJJShB3YGBTQ98homa
 fGoLljA9/fGDwwhZ5dJ4DB56w44rMj1zYhKOsE73bQS66hyHEk7O9uDP/S22kcpKf7vE
 zV0+Hw5LKSWIdjtMJNo15fxYNjor0bQ4czOyiEI97L7M+mSoXgwXrkOGfbME/fwrRgJy
 0CsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUfZRtxy2o7RI1aiU3EQN3RBUrwhj0fXuYFlsmxSJQQGF9iKYfnlgAM+XZ8DjxMhAwRg0PRGUDL6a9@nongnu.org
X-Gm-Message-State: AOJu0YxWEK8xgz0NoXrR0BZgHyOzsNjRSGNQ78PipbiP74HPjN4lTpPG
 HF0AWPQupgEuh4W+zfLtBw4U0101hD+Md3lqQeLhjjocknFVMw6056JQ6dnYqDg=
X-Google-Smtp-Source: AGHT+IEV+cIsOEV126sZXs3gVba1AruvI4sBTXxPR6SNxpG5Ajzq7PQCa3v1NPbaOK5H88LFD0ciug==
X-Received: by 2002:a05:6000:50f:b0:374:c3cd:73de with SMTP id
 ffacd0b85a97d-37cc24852c5mr2078500f8f.35.1727265491103; 
 Wed, 25 Sep 2024 04:58:11 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc2ab52fsm3770612f8f.13.2024.09.25.04.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 04:58:10 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/8] target/riscv: Add support for Smdbltrp and Ssdbltrp
 extensions
Date: Wed, 25 Sep 2024 13:57:58 +0200
Message-ID: <20240925115808.77874-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

A double trap typically arises during a sensitive phase in trap handling
operations — when an exception or interrupt occurs while the trap
handler (the component responsible for managing these events) is in a
non-reentrant state. This non-reentrancy usually occurs in the early
phase of trap handling, wherein the trap handler has not yet preserved
the necessary state to handle and resume from the trap. The occurrence
of such event is unlikely but can happen when dealing with hardware
errors.

This series adds support for Ssdbltrp and Smdbltrp ratified ISA
extensions [1]. It is based on the Smrnmi series [6].

Ssdbltrp can be tested using qemu[2], opensbi[3], linux[4] and
kvm-unit-tests[5]. Assuming you have a riscv environment available and
configured (CROSS_COMPILE), it can be built for riscv64 using the
following instructions:

Qemu:
  $ git clone https://github.com/rivosinc/qemu.git
  $ cd qemu
  $ git switch -C dbltrp_v2 dev/cleger/dbltrp_v2
  $ mkdir build && cd build
  $ ../configure --target-list=riscv64-softmmu
  $ make

OpenSBI:
  $ git clone https://github.com/rivosinc/opensbi.git
  $ cd opensbi
  $ git switch -C dbltrp_v3 dev/cleger/dbltrp_v3
  $ make O=build PLATFORM_RISCV_XLEN=64 PLATFORM=generic

Linux:
  $ git clone https://github.com/rivosinc/linux.git
  $ cd linux
  $ git switch -C dbltrp_v1 dev/cleger/dbltrp_v1
  $ export ARCH=riscv
  $ make O=build defconfig
  $ ./script/config --file build/.config --enable RISCV_DBLTRP
  $ make O=build

kvm-unit-tests:
  $ git clone https://github.com/clementleger/kvm-unit-tests.git
  $ cd kvm-unit-tests
  $ git switch -C dbltrp_v1 dev/cleger/dbltrp_v1
  $ ./configure --arch=riscv64 --cross-prefix=$CROSS_COMPILE
  $ make

You will also need kvmtool in your rootfs.

Run with kvm-unit-test test as kernel:
  $ qemu-system-riscv64 \
    -M virt \
    -cpu rv64,ssdbltrp=true,smdbltrp=true \
    -nographic \
    -serial mon:stdio \
    -bios opensbi/build/platform/generic/firmware/fw_jump.bin \
    -kernel kvm-unit-tests-dbltrp/riscv/sbi_dbltrp.flat
  ...
  [OpenSBI boot partially elided]
  Boot HART ISA Extensions  : sscofpmf,sstc,zicntr,zihpm,zicboz,zicbom,sdtrig,svadu,ssdbltrp
  ...
  ##########################################################################
  #    kvm-unit-tests
  ##########################################################################

  PASS: sbi: fwft: FWFT extension probing no error
  PASS: sbi: fwft: FWFT extension is present
  PASS: sbi: fwft: dbltrp: Get double trap enable feature value
  PASS: sbi: fwft: dbltrp: Set double trap enable feature value == 0
  PASS: sbi: fwft: dbltrp: Get double trap enable feature value == 0
  PASS: sbi: fwft: dbltrp: Double trap disabled, trap first time ok
  PASS: sbi: fwft: dbltrp: Set double trap enable feature value == 1
  PASS: sbi: fwft: dbltrp: Get double trap enable feature value == 1
  PASS: sbi: fwft: dbltrp: Trapped twice allowed ok
  INFO: sbi: fwft: dbltrp: Should generate a double trap and crash !

  sbi_trap_error: hart0: trap0: double trap handler failed (error -10)

  sbi_trap_error: hart0: trap0: mcause=0x0000000000000010 mtval=0x0000000000000000
  sbi_trap_error: hart0: trap0: mtval2=0x0000000000000003 mtinst=0x0000000000000000
  sbi_trap_error: hart0: trap0: mepc=0x00000000802000d8 mstatus=0x8000000a01006900
  sbi_trap_error: hart0: trap0: ra=0x00000000802001fc sp=0x0000000080213e70
  sbi_trap_error: hart0: trap0: gp=0x0000000000000000 tp=0x0000000080088000
  sbi_trap_error: hart0: trap0: s0=0x0000000080213e80 s1=0x0000000000000001
  sbi_trap_error: hart0: trap0: a0=0x0000000080213e80 a1=0x0000000080208193
  sbi_trap_error: hart0: trap0: a2=0x000000008020dc20 a3=0x000000000000000f
  sbi_trap_error: hart0: trap0: a4=0x0000000080210cd8 a5=0x00000000802110d0
  sbi_trap_error: hart0: trap0: a6=0x00000000802136e4 a7=0x0000000046574654
  sbi_trap_error: hart0: trap0: s2=0x0000000080210cd9 s3=0x0000000000000000
  sbi_trap_error: hart0: trap0: s4=0x0000000000000000 s5=0x0000000000000000
  sbi_trap_error: hart0: trap0: s6=0x0000000000000000 s7=0x0000000000000001
  sbi_trap_error: hart0: trap0: s8=0x0000000000002000 s9=0x0000000080083700
  sbi_trap_error: hart0: trap0: s10=0x0000000000000000 s11=0x0000000000000000
  sbi_trap_error: hart0: trap0: t0=0x0000000000000000 t1=0x0000000080213ed8
  sbi_trap_error: hart0: trap0: t2=0x0000000000001000 t3=0x0000000080213ee0
  sbi_trap_error: hart0: trap0: t4=0x0000000000000000 t5=0x000000008020f8d0
  sbi_trap_error: hart0: trap0: t6=0x0000000000000000

Run with linux and kvm-unit-test test in kvm (testing VS-mode):
  $ qemu-system-riscv64 \
    -M virt \
    -cpu rv64,ssdbltrp=true,smdbltrp=true \
    -nographic \
    -serial mon:stdio \
    -bios opensbi/build/platform/generic/firmware/fw_jump.bin \
    -kernel linux/build/arch/riscv/boot/Image
  ...
  [Linux boot partially elided]
  [    0.735079] riscv-dbltrp: Double trap handling registered
  ...

  $ lkvm run -k sbi_dbltrp.flat -m 128 -c 2
  ##########################################################################
  #    kvm-unit-tests
  ##########################################################################

  PASS: sbi: fwft: FWFT extension probing no error
  PASS: sbi: fwft: FWFT extension is present
  PASS: sbi: fwft: dbltrp: Get double trap enable feature value
  PASS: sbi: fwft: dbltrp: Set double trap enable feature value == 0
  PASS: sbi: fwft: dbltrp: Get double trap enable feature value == 0
  PASS: sbi: fwft: dbltrp: Double trap disabled, trap first time ok
  PASS: sbi: fwft: dbltrp: Set double trap enable feature value == 1
  PASS: sbi: fwft: dbltrp: Get double trap enable feature value == 1
  PASS: sbi: fwft: dbltrp: Trapped twice allowed ok
  INFO: sbi: fwft: dbltrp: Should generate a double trap and crash !
  [   51.939077] Guest double trap
  [   51.939323] kvm [93]: VCPU exit error -95
  [   51.939683] kvm [93]: SEPC=0x802000d8 SSTATUS=0x200004520 HSTATUS=0x200200180
  [   51.939947] kvm [93]: SCAUSE=0x10 STVAL=0x0 HTVAL=0x3 HTINST=0x0
  KVM_RUN failed: Operation not supported
  $

Testing Smbdbltrp can be done using gdb and trigger some trap. For
instance, interrupt M-mode firmware at some point, set mstatus.mdt = 1
and corrupt some register to generate a NULL pointer exception.

Link: https://github.com/riscv/riscv-isa-manual/commit/52a5742d5ab5a0792019033631b2035a493ad981 [1]
Link: https://github.com/rivosinc/qemu/tree/dev/cleger/dbltrp_v2 [2]
Link: https://github.com/rivosinc/opensbi/tree/dev/cleger/dbltrp_v3 [3]
Link: https://github.com/rivosinc/linux/tree/dev/cleger/dbltrp_v1 [4]
Link: https://github.com/clementleger/kvm-unit-tests/tree/dev/cleger/dbltrp_v1 [5]
Link: https://lore.kernel.org/all/CAKmqyKO9k93OLX_pxtkHcUAvC=NUNxtp6mDCb2J2ZWHMnfbNYQ@mail.gmail.com/T/ [6]

---
V2:
 - Squashed commits that added ext_s{s|m}dbltrp as suggested by Daniel

Clément Léger (8):
  target/riscv: Add Ssdbltrp CSRs handling
  target/riscv: Implement Ssdbltrp sret, mret and mnret behavior
  target/riscv: Implement Ssdbltrp exception handling
  target/riscv: Add Ssdbltrp ISA extension enable switch
  target/riscv: Add Smdbltrp CSRs handling
  target/riscv: Implement Smdbltrp sret, mret and mnret behavior
  target/riscv: Implement Smdbltrp behavior
  target/riscv: Add Smdbltrp ISA extension enable switch

 target/riscv/cpu.c        |  9 +++-
 target/riscv/cpu.h        |  1 +
 target/riscv/cpu_bits.h   |  8 ++++
 target/riscv/cpu_cfg.h    |  2 +
 target/riscv/cpu_helper.c | 98 +++++++++++++++++++++++++++++++++------
 target/riscv/csr.c        | 60 ++++++++++++++++++++----
 target/riscv/op_helper.c  | 47 ++++++++++++++++++-
 7 files changed, 198 insertions(+), 27 deletions(-)

-- 
2.45.2


