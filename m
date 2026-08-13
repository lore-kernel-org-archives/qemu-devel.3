Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C35C5AC67
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 03:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuMIM-0003ZI-2p; Wed, 12 Aug 2026 23:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wuMIJ-0003YO-Ol
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 23:39:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wuMIH-0004Qx-3S
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 23:39:51 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8DxjdJ6PH1qwcgAAA--.2435S3;
 Thu, 13 Aug 2026 11:39:39 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJDxCc56PH1qT+8CAA--.4096S2;
 Thu, 13 Aug 2026 11:39:38 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] loongarch queue
Date: Thu, 13 Aug 2026 11:40:47 +0800
Message-ID: <20260813034052.79094-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxCc56PH1qT+8CAA--.4096S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw4DGF4kArW8GF4kGF4rZwc_yoW8GF15pr
 W3Arnxtr4xtry7JFnxJ345Xrn8Jrs7ur12q3W7Jr18CF15Cr18Xr18JryFgFy3G348Jr10
 qrn5Jw1UWF1UXwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit d49f87606ac1a6e15701b26c1b16c5d7e948ffcb:

  Merge tag 'linux-user-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-08-12 15:21:53 -0700)

are available in the Git repository at:

  https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20260813

for you to fetch changes up to 77b91aca6148fafcade41516f12a3309f1e1f552:

  target/loongarch: Set timer tick value even if disabled (2026-08-13 11:34:48 +0800)

----------------------------------------------------------------
pull-loongarch-20260813 queue

----------------------------------------------------------------
Bibo Mao (1):
      target/loongarch: Set timer tick value even if disabled

Bin Guo (1):
      hw/intc/loongarch_pch_pic: Validate htmsi_vector before indexing parent_irq

Dongyan Qian (3):
      tests/acpi: Allow LoongArch virt MADT changes
      hw/loongarch/virt: Set MADT revision to 6
      tests/acpi: Update LoongArch virt MADT

 hw/intc/loongarch_pch_pic.c                    |  19 +++++++++++++++++--
 hw/loongarch/virt-acpi-build.c                 |   2 +-
 target/loongarch/tcg/constant_timer.c          |  17 +++++++++++++----
 tests/data/acpi/loongarch64/virt/APIC          | Bin 108 -> 108 bytes
 tests/data/acpi/loongarch64/virt/APIC.topology | Bin 153 -> 153 bytes
 5 files changed, 31 insertions(+), 7 deletions(-)


