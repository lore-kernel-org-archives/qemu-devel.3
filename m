Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33126606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwpF-00073A-4w; Thu, 19 Nov 2026 02:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xTwoT-0006ua-H5; Thu, 19 Nov 2026 02:44:11 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xTwoO-0001iS-7f; Thu, 19 Nov 2026 02:44:08 -0500
Received: from xiaoou-ubuntu-01 (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowABX8LW1qP5qLIlyAQ--.23889S2;
 Thu, 19 Nov 2026 15:43:49 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Yin Zhang <zhangyin2018@iscas.ac.cn>,
 Dajun Huang <djhuang_1@std.uestc.edu.cn>,
 Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn>
Subject: [PATCH v4 00/20] target/riscv: Add support for RISC-V P extension V0.6
Date: Thu, 19 Nov 2026 07:43:20 +0000
Message-ID: <20261119074345.866125-1-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABX8LW1qP5qLIlyAQ--.23889S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWxXryDWFyftF1fJFWrXwb_yoW3GF48pF
 s5G3yYyayktFWIqw1ftw48Cr15WF4rGa15C3WxX340vw43tF93tFnFkw4YkFn8JF1kWw1j
 9FnFkr15uF4UAFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
 628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
 IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
 MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JV
 W7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
 6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
 BIdaVFxhVjvjDU0xZFpf9x0JULo7NUUUUU=
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.25; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.993,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for the RISC-V Packed SIMD (P) extension for
RV32 and RV64.

The P extension defines packed-SIMD fixed-point operations intended for
DSP workloads such as multimedia and signal processing. These
instructions operate on packed subword elements in general-purpose
registers, with register-pair forms for wider operands on RV32.

The implementation targets the V0.6 development draft of the RISC-V P
extension specification:

  https://github.com/riscv/riscv-p-spec

The local riscv-p-spec reference checkout is at commit 85857f3(tag: v0.6).

P support is enabled with the experimental x-p CPU property. The series
includes instruction decoding and translation, helpers, extension-state
handling, and the specification-defined control of vxsat. The focus
remains functional correctness and instruction coverage; performance
optimization is left for future work.

Thanks to Daniel Henrique Barboza, Nutty Liu, Chao Liu, and Max Chou for
their reviews and suggestions.

Changes in v4:

  - P extension TCG test: migrate from Makefile to the Meson framework.

  - Align rounded logical right shifts with P extension v0.6.

  - Replace TARGET_LONG_SIZE with TARGET_LONG_BITS in GEN_PLI*.

Testing:

  The P extension TCG tests were built with LLVM/Clang 24.0.0git,
  llvm-project commit:

    96295a1412f9afbee9d4a3c2701e83f5a529a9cc

  P extension TCG tests pass for both RV32 and RV64. The test targets 
  enable x-p, zmmul, zba, and zbb on the corresponding rv32 or rv64 CPU. 
  The P-aware compiler path is configurable through PSIMD_CC. The build 
  and test commands are as follows:

  $ export PSIMD_CC=/path/to/clang
  $ ./configure --target-list=riscv32-linux-user,riscv64-linux-user \
    --enable-tcg --enable-tests
  $ cd build && ninja
  $ ./run meson test \
    riscv32-linux-user-psimd-rv32 \
    riscv64-linux-user-psimd-rv64

Changes in v3:

  - Add descriptive commit messages explaining the purpose and behavior
    of the patches, and document helper macro definitions, including
    their interfaces and arithmetic semantics.

  - Add RV32 and RV64 assembly tests under tests/tcg/riscv, with shared
    test macros and integration into the TCG test Makefiles. Cover
    arithmetic, shifts, multiplication, narrowing, saturation, register
    overlap, and zero register-pair operands. The tests are freestanding
    Linux-user programs and do not require a target libc. Set PSIMD_CC
    to a P-capable Clang to build them; the assembler options use
    rv32gp0p21 and rv64gp0p21. Enable previously disabled tests using the
    P v0.21 mnemonics and update signed saturation immediate operands.

  - Correct register-controlled packed byte and halfword shifts to use
    the low five bits of rs2. Share the signed saturating/rounding shift
    implementation between scalar and packed forms: psshar_hs,
    psshar_ws, and sshar are all generated by GEN_PSIMD_VAR_SSHAR.
    Return zero for oversized SSHAR/SHAR right shifts, and widen
    rounding arithmetic before adding the rounding bit.

  - Clamp unsigned rounding right shifts to the element width so that
    the source MSB still participates in rounding for oversized shifts.
    Apply this to PSSHLR/SSHLR and RV64 SHLR. Use a wider intermediate
    for SHLR to preserve the carry when rounding UINT64_MAX right by
    one bit, and add regression tests for these cases.

  - Fix RV32 register-pair operations when the destination overlaps
    the scalar source by completing both results before writeback.
    Treat a zero register-pair selector as {x0, x0}, suppress both
    destination writes for a zero pair, and preserve vxsat side effects.
    Use tcg_gen_movi_i64() to initialize a zero source in narrowing
    translations, with a dedicated regression test.

  - Avoid undefined behavior in helper arithmetic by using unsigned
    operations where wraparound is intended and wider intermediates
    where needed. Handle oversized left shifts explicitly and handle
    zero shifts in SLX/SRX without shifting by the operand width.

  - Correct the RV32 REV encoding, reject unavailable translations
    instead of accepting them without an operation, and fix lane
    selection in PMQWACC.H and PMQRWACC.H.

  - Reuse qemu/bitops.h extract64() for lane extraction, correct
    misleading helper comments, and align macro continuation characters.

Previous versions:

  v3: https://lists.nongnu.org/archive/html/qemu-riscv/2026-09/msg00523.html
  v2: https://lists.nongnu.org/archive/html/qemu-riscv/2026-07/msg00697.html
  v1: https://lists.nongnu.org/archive/html/qemu-riscv/2026-04/msg00301.html

Feedback on the implementation and tests would be appreciated.

Co-authored-by: Yin Zhang <zhangyin2018@iscas.ac.cn>
Co-authored-by: Dajun Huang <djhuang_1@std.uestc.edu.cn>
Co-authored-by: Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn>

Molly Chen (20):
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
  target/riscv: Add packed SIMD pure multiplication instructions
  target/riscv: Add packed SIMD multiply-accumulate instructions
  target/riscv: Add packed SIMD Q-format multiplication instructions
  target/riscv: Add packed SIMD Q-format MAC instructions
  target/riscv: Add packed SIMD two-way multiply-add/subtract
    instructions
  target/riscv: Add packed SIMD four-way multiply-add instructions
  target/riscv: Add packed SIMD load-replicate instructions
  target/riscv: Add packed SIMD RV32 only instructions
  target/riscv: Remove Zbkb dependency from P extension to align with
    the spec
  tests/tcg/riscv: Add tests for the P extension
  target/riscv: align rounded logical right shifts with P extension v0.6

 target/riscv/cpu.c                          |    5 +-
 target/riscv/cpu.h                          |    8 +
 target/riscv/cpu_bits.h                     |    2 +
 target/riscv/helper.h                       |  529 +++
 target/riscv/insn32.decode                  |  830 +++++
 target/riscv/machine.c                      |   19 +
 target/riscv/tcg/csr.c                      |   39 +-
 target/riscv/tcg/insn_trans/trans_rvb.c.inc |    4 +-
 target/riscv/tcg/insn_trans/trans_rvp.c.inc | 1439 ++++++++
 target/riscv/tcg/meson.build                |    3 +-
 target/riscv/tcg/psimd_helper.c             | 3535 +++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                  |   46 +
 target/riscv/tcg/translate.c                |    6 +
 tests/tcg/meson.build                       |    1 +
 tests/tcg/riscv/meson.build                 |   49 +
 tests/tcg/riscv/psimd-common.S              | 1115 ++++++
 tests/tcg/riscv/psimd-rv32.S                | 1275 +++++++
 tests/tcg/riscv/psimd-rv64.S                |  587 +++
 tests/tcg/riscv/psimd-test-macros.inc       |  952 +++++
 19 files changed, 10438 insertions(+), 6 deletions(-)
 create mode 100644 target/riscv/tcg/insn_trans/trans_rvp.c.inc
 create mode 100644 target/riscv/tcg/psimd_helper.c
 create mode 100644 tests/tcg/riscv/meson.build
 create mode 100644 tests/tcg/riscv/psimd-common.S
 create mode 100644 tests/tcg/riscv/psimd-rv32.S
 create mode 100644 tests/tcg/riscv/psimd-rv64.S
 create mode 100644 tests/tcg/riscv/psimd-test-macros.inc

-- 
2.53.0


