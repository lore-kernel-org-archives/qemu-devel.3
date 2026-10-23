Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F1E606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4Os-00067J-QO; Thu, 22 Oct 2026 21:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xK4OJ-0005we-6i
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:48:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xK4OF-0005ob-85
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:48:17 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8DxztLWvNpqB5sYAA--.5759S3;
 Fri, 23 Oct 2026 09:48:07 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAxW87SvNpqxF8vAA--.7370S2;
 Fri, 23 Oct 2026 09:48:03 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] pull-loongarch-20261023 queue
Date: Fri, 23 Oct 2026 09:49:20 +0800
Message-ID: <20261023014931.4055823-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxW87SvNpqxF8vAA--.7370S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ArW7uF4kGFy8WryrtryUCFX_yoW8Zry8pr
 y3Zr13Kr48J39xJrn3A345Xrn8Xrn7GF42q3Wxtry0krn8Ar17Xr18Jw1kXFyUJ348Jryj
 qr18Cw1UWF1UJwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1j6r15MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit ed698be7700160c74d24ef7830adccd2a28d840a:

  Merge tag 'firmware-20261021-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-10-22 08:20:10 +0200)

are available in the Git repository at:

  https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20261023

for you to fetch changes up to b8cb88aaa32d8e1ff55c5bc347bae7da09f2e63f:

  target/loongarch: Select sys state by VM level (2026-10-23 09:28:51 +0800)

----------------------------------------------------------------
pull-loongarch-20261023 queue

----------------------------------------------------------------
Bibo Mao (8):
      target/loongarch: Replace address_space_ldq_le() -> cpu_ldq_le_data_ra()
      target/loongarch: Use input parameter mmu_idx rather than current mode
      target/loongarch: Replace address_space_ldq_le -> cpu_ldq_le_mmuidx_ra in loongarch_ptw
      target/loongarch: Add dynamic irq_nr field
      target/loongarch: Remove TLB entry in vmstate
      target/loongarch: Add paravirt preempt feature
      target/loongarch: Preserve PTW dirty tracking on read fills
      hw/intc: Acess LoongArch irqchip data with align method

SignKirigami (2):
      target/loongarch: Delete macro CSR_OFF_FUNCS
      target/loongarch: Select sys state by VM level

 hw/intc/loongarch_extioi.c        | 51 ++++++++++++++++++++-----------
 hw/intc/loongarch_ipi.c           |  9 +++---
 hw/intc/loongarch_pch_pic.c       | 28 +++++++++--------
 target/loongarch/cpu.c            | 12 +++++---
 target/loongarch/cpu.h            | 10 ++++--
 target/loongarch/cpu_helper.c     | 64 +++++++++------------------------------
 target/loongarch/csr.c            | 15 +++++----
 target/loongarch/kvm/kvm.c        | 39 ++++++++++++++++++++++++
 target/loongarch/machine.c        | 35 ---------------------
 target/loongarch/tcg/tlb_helper.c | 30 +++++++++---------
 10 files changed, 145 insertions(+), 148 deletions(-)


