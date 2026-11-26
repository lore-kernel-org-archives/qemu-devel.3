Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA1D606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWTfc-0003pV-SV; Thu, 26 Nov 2026 02:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xWTfX-0003jC-Or
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:23 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xWTfV-0003BJ-3d
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:23 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8CxKvAD3AdrziojAA--.33754S3;
 Thu, 26 Nov 2026 15:13:08 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJDxg8wA3AdrsX03AA--.16771S2;
 Thu, 26 Nov 2026 15:13:04 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 00/18] target/loongarch: Small enhancements to CSR emulation
Date: Thu, 26 Nov 2026 15:14:22 +0800
Message-ID: <20261126071440.3293877-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxg8wA3AdrsX03AA--.16771S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr4xGw4xuFyxZFW8Gw18tFc_yoW5GFy3pr
 9rury5tF48tFZxurn3Xa4fXr98XF4xGF42v3WftryI9r45A34avrW0qa9F9FyUG3WxGryj
 qr18C34j9F43ZacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There are some small enhancements to CSR register emulation on
LoongArch based on the manual, such as fixing CSR.MISC being
incorrectly marked read-only and avoiding raising an exception on
writes to read-only CSRs etc.

---
v2 ... v3:
  1. Add reserved fields to register CSR_MISC in new patch 13
  2. Fix CSR_ECFG field definitions and remove MSGINT field in new patch
     14
  3. Add field reserve bit with CSR bit definition, use reserve bit
     marco for CSR write mask setting.
  4. Modify some code style issues.

v1 ... v2:
  1. Add sign-extended value with 32-bit CSR reading
  2. Add read-only bit support with CSR register writing, discard
     writing for these read-only bit
  3. Remove debug exception support
  4. Remove some unused CSR registers such as CSR CTAG and Memory Error
     register, which QEMU emulation does not support.
---
Bibo Mao (18):
  target/loongarch: Remove csrrd_cpuid() helper
  target/loongarch: Remove debug exception support
  target/loongarch: Remove some unused CSR registers
  target/loongarch: Move field definition of some CSR register to
    cpu-csr.h
  target/loongarch: Move CSR_TLBRERA FIELD definition next to
    LOONGARCH_CSR_TLBRERA
  target/loongarch: Fix BADV for BCE exception
  target/loongarch: Fix CSR.MISC being incorrectly marked read-only
  target/loongarch: Set register CSR_MSGIS as read-only
  target/loongarch: Do not raise exception on read-only CSR write
  target/loongarch: Add CSRFL_WIDTH64 flag for some CSR registers
  target/loongarch: Return sign-extended value when reading 32-bit CSR
    registers
  target/loongarch: Add write mask to CSRInfo
  target/loongarch: Add reserved fields to CSR_MISC
  target/loongarch: Fix CSR_ECFG field definitions
  target/loongarch: Add fine-grained write masks for CSRs
  target/loongarch: Add generic csrwr helper
  target/loongarch: Call generic csrwr helper for part read-only bits
  target/loongarch: Define some csrwr helper functions static

 target/loongarch/cpu-csr.h                    | 108 +++++++++---
 target/loongarch/cpu.c                        |  17 +-
 target/loongarch/cpu.h                        |  19 +-
 target/loongarch/csr.c                        | 165 ++++++++++--------
 target/loongarch/csr.h                        |   9 +
 target/loongarch/disas.c                      |   4 -
 target/loongarch/tcg/csr_helper.c             |  67 +++++--
 target/loongarch/tcg/helper.h                 |   9 +-
 .../tcg/insn_trans/trans_privileged.c.inc     | 139 +++++++++++----
 target/loongarch/tcg/op_helper.c              |   3 +-
 target/loongarch/tcg/tcg_cpu.c                |  25 +--
 target/loongarch/tcg/tlb_helper.c             |   4 +-
 12 files changed, 366 insertions(+), 203 deletions(-)


base-commit: 16067c8ad46433975758ffa9f38a2646e8b641af
-- 
2.54.0


