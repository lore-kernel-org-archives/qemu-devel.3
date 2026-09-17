Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFDCC982CC
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 02:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x729c-0006QI-2J; Wed, 16 Sep 2026 22:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x728z-0006Ku-T7
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 22:46:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x728x-00058X-7Y
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 22:46:37 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8AxYdGAVKtqAuEMAA--.38031S3;
 Thu, 17 Sep 2026 10:46:25 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJCx+c18VKtqA60hAA--.39456S2;
 Thu, 17 Sep 2026 10:46:20 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] loongarch queue
Date: Thu, 17 Sep 2026 10:47:31 +0800
Message-ID: <20260917024742.200257-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx+c18VKtqA60hAA--.39456S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFWftF1fCF1DWw15Cw1fKrX_yoW8ZryUpr
 W3ury3Kr48JrZrGr1fXa45Xrn8Jr1xGw42q3W3tryxCw43ZryxXF18t392gFy5Ja48Wry2
 qF1rCw15XF4UJwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

The following changes since commit 28e7aad52202c7e6210e0e05d4f60360aaf8d027:

  Merge tag 'pull-target-arm-20260915' of https://gitlab.com/pm215/qemu into staging (2026-09-15 09:50:49 -1000)

are available in the Git repository at:

  https://github.com/bibo-mao/qemu.git pull-loongarch-20260917

for you to fetch changes up to 2dfba02c30509a8c36a3bf10ccac5519495a811d:

  target/loongarch: Add la664 CPU type (2026-09-17 10:08:16 +0800)

----------------------------------------------------------------
pull-loongarch-20260917 queue

----------------------------------------------------------------
Bibo Mao (11):
      target/loongarch: Fix data race in CSR_ESTAT
      target/loongarch: Remove CSR registers relative MERR
      target/loongarch: Rename function name constant_timer with timer
      target/loongarch: Rename filename constant_timer.c with timer.c
      target/loongarch: Add CPUTimerState structure
      hw/intc/loongarch_dintc: Check irqchip in kernel mode firstly
      target/loongarch/kvm: Check LoongArch Instruction Set version 1.1
      target/loongarch: Enable LoongArch Instruction Set version 1.1
      target/loongarch: Set msgint property with auto detected
      target/loongarch: Enable HW PTW feature by default
      target/loongarch: Add la664 CPU type

 hw/intc/loongarch_dintc.c                          | 19 +++--
 target/loongarch/cpu.c                             | 89 +++++++++++++---------
 target/loongarch/cpu.h                             | 15 +++-
 target/loongarch/csr.c                             |  6 --
 target/loongarch/disas.c                           |  6 --
 target/loongarch/internals.h                       |  9 +--
 target/loongarch/kvm/kvm.c                         | 66 ++++++++++++++++
 target/loongarch/tcg/csr_helper.c                  | 14 ++--
 target/loongarch/tcg/meson.build                   |  2 +-
 target/loongarch/tcg/op_helper.c                   |  6 +-
 target/loongarch/tcg/{constant_timer.c => timer.c} | 30 ++++----
 11 files changed, 170 insertions(+), 92 deletions(-)
 rename target/loongarch/tcg/{constant_timer.c => timer.c} (65%)


