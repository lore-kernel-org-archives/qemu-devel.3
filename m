Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2B7F4368D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgfv-00089k-Dv; Fri, 17 Apr 2026 06:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgfm-000875-Fw; Fri, 17 Apr 2026 06:43:42 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgfj-00079a-0v; Fri, 17 Apr 2026 06:43:41 -0400
Received: from Huawei.localdomain (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAAn0WzLDuJpdSWSDQ--.31038S2;
 Fri, 17 Apr 2026 18:43:24 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/14] target/riscv: add support for RISC-V P extension (v0.20
 draft)
Date: Fri, 17 Apr 2026 18:42:47 +0800
Message-Id: <20260417104302.17800-1-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAn0WzLDuJpdSWSDQ--.31038S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr13KF4fWw1DXr1DWF1DGFg_yoW5Xryfpr
 s5G34aka1DJ3yxWw1ftr4DCry5WF4rWr4rAan7Jw18tan8tFWFyr9Fgw1akFy5JFy8Wr12
 93Wj9r13Zr4UAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
 6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
 IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbzpBDUUUU
 U==
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.21; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.998,
 HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  https://www.jhauser.us/RISCV/ext-P/

All instructions defined prior to the v0.20 update were verified
using a simple instruction coverage test suite:

  https://github.com/mollybuild/qemu-riscv-test-uart

Instructions newly introduced in v0.20 were not tested yet because
toolchain support for generating them is still under development.

The implementation focuses on functional correctness and ISA coverage.
Performance optimizations were not considered at this stage.

Feedback on implementation details would be highly appreciated.

Co-Authored by: Yin Zhang <zhangyin2018@iscas.ac.cn>
Co-Authored by: Dajun Huang <djhuang_1@std.uestc.edu.cn>
Co-Authored by: Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn> 

Molly Chen (14):
  target/riscv: rvp: Add option defines and dependency check for packed
    simd extension
  target/riscv: rvp: add arithmetic instructions,including saturating
    and non-saturating operations
  target/riscv: rvp: add averaging operations
  target/riscv: rvp: add absolute value and difference,comparison and
    mask generation operations
  target/riscv: rvp: add shift operations
  target/riscv: rvp: add exchange operations
  target/riscv: rvp: add horizontal reduction, pack, merge and cout
    leading operations
  target/riscv: rvp: add pure multiplication operations
  target/riscv: rvp: add multiply-accumulate operations
  target/riscv: rvp: add Q-format multiplication operations
  target/riscv: rvp: add two-way and four-way multiply and accumulate
    operations
  target/riscv: rvp: add load and replicate instructions.
  target/riscv: rvp: add rv32-only register-pair instructions
  target/riscv: rvp: update to v020, add SHL and PNCLIP[U]P.*
    instructions

 target/riscv/cpu.c                      |    5 +-
 target/riscv/cpu.h                      |    1 +
 target/riscv/helper.h                   |  531 ++
 target/riscv/insn32.decode              |  829 ++
 target/riscv/insn_trans/trans_rvp.c.inc | 1691 ++++
 target/riscv/meson.build                |    3 +-
 target/riscv/psimd_helper.c             | 9452 +++++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c              |   16 +
 target/riscv/translate.c                |    3 +
 9 files changed, 12528 insertions(+), 3 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvp.c.inc
 create mode 100644 target/riscv/psimd_helper.c

-- 
2.34.1


