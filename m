Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CDCC44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfTn-0003b7-JP; Fri, 17 Jul 2026 06:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wkfTk-0003Y4-JX; Fri, 17 Jul 2026 06:07:36 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wkfTg-0006aY-A9; Fri, 17 Jul 2026 06:07:36 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3T_Pa_llqSAw4AA--.34459S2;
 Fri, 17 Jul 2026 18:07:22 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 00/18] target/riscv: Add support for RISC-V P
Date: Fri, 17 Jul 2026 10:06:53 +0000
Message-Id: <cover.1784280142.git.xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3T_Pa_llqSAw4AA--.34459S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr13KF1kuFyktFWxArW5KFg_yoWrWrykpr
 s5G3yakayDtrZ7Gw1ftw48Gr13GF4rWr45Awn7Xw1xtanxtFZ3tFnFkw1jkF98JFy8Ww12
 9F1qkF13ZF4UAFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
 6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
 AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
 c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
 AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
 Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU11rW7
 UUUUU==
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.21; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series adds support for the RISC-V Packed SIMD (P) extension.

The P extension defines packed-SIMD fixed-point operations intended
for DSP-style workloads such as multimedia and signal processing.
These instructions operate on packed subword elements within
general-purpose registers (GPRs).

The implementation follows the current development draft of the
specification (v0.20):

  https://github.com/riscv/riscv-p-spec/
  or
  https://www.jhauser.us/RISCV/ext-P/

Compared with v1, this version reduces implementation boilerplate by
defining and reusing helper macros for common patterns in
trans_rvp.c.inc and psimd_helper.c. It also consolidates the P
extension prerequisite validation in riscv_cpu_validate_p().

The Zbkb dependency has been removed to align the implementation with
the current specification. This version also implements the
specification-defined control of vxsat, which was missing from v1.

All instructions have been functionally tested using the following
test suite:

  https://github.com/mollybuild/qemu-riscv-test-uart

The implementation focuses on functional correctness and ISA
coverage. Performance optimizations were not considered at this
stage.

Feedback on the implementation details would be highly appreciated.

Tested with:

  - ninja -C build test
  - make -C build check-qtest-riscv32
  - make -C build check-qtest-riscv64
  - Functional tests for all P extension instructions using
    qemu-riscv-test-uart

No regressions or test failures were observed.

---
Changes in v2:

  - Refactored trans_rvp.c.inc and psimd_helper.c by defining and
    reusing helper macros for common implementation patterns, reducing
    boilerplate and overall code size.
  - Moved the P extension prerequisite checks into
    riscv_cpu_validate_p().
  - Removed the Zbkb dependency to align with the current
    specification.
  - Added the specification-defined vxsat control mechanism, which was
    missing from v1.

v1:
  https://lists.nongnu.org/archive/html/qemu-riscv/2026-04/msg00301.html

Molly Chen (18):
  target/riscv: Add packed SIMD extension state
  target/riscv: Add packed SIMD helper framework
  target/riscv: Add packed SIMD arithmetic instructions
  target/riscv: Add packed SIMD averaging and rounding instructions
  target/riscv: Add packed SIMD absolute, difference, compare and mask
    instructions
  target/riscv: Add packed SIMD shift instructions
  target/riscv: Add packed SIMD exchange instructions
  target/riscv: Add packed SIMD horizontal reduction instructions
  target/riscv: Add packed SIMD pack, merge and count-leading
    instructions
  target/riscv: Add packed SIMD multiplication instructions
  target/riscv: Add packed SIMD multiply-accumulate instructions
  target/riscv: Add packed SIMD Q-format multiplication instructions
  target/riscv: Add packed SIMD Q-format MAC instructions
  target/riscv: Add packed SIMD two-way MAC instructions
  target/riscv: Add packed SIMD four-way MAC instructions
  target/riscv: Add packed SIMD load-replicate instructions
  target/riscv: Add packed SIMD RV32 only instructions
  target/riscv: Remove Zbkb dependency from P extension to align with
    the spec

 target/riscv/cpu.c                          |    5 +-
 target/riscv/cpu.h                          |    8 +
 target/riscv/cpu_bits.h                     |    2 +
 target/riscv/helper.h                       |  529 ++++
 target/riscv/insn32.decode                  |  829 +++++
 target/riscv/machine.c                      |   19 +
 target/riscv/tcg/csr.c                      |   39 +-
 target/riscv/tcg/insn_trans/trans_rvb.c.inc |    4 +-
 target/riscv/tcg/insn_trans/trans_rvp.c.inc | 1389 ++++++++
 target/riscv/tcg/meson.build                |    3 +-
 target/riscv/tcg/psimd_helper.c             | 3165 +++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                  |   46 +
 target/riscv/tcg/translate.c                |    6 +
 13 files changed, 6038 insertions(+), 6 deletions(-)
 create mode 100644 target/riscv/tcg/insn_trans/trans_rvp.c.inc
 create mode 100644 target/riscv/tcg/psimd_helper.c


base-commit: 8fb307591625731060d399aca42373c02c7cb040
-- 
2.34.1


