Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36CFC5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzUu8-0003rD-2N; Thu, 27 Aug 2026 03:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wzUu5-0003qj-0j
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 03:52:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wzUu2-00050h-C4
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 03:52:04 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8AxdvCZ7I9qs5wFAA--.15748S3;
 Thu, 27 Aug 2026 15:51:54 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJAxnM6Z7I9qFvwTAA--.16948S2;
 Thu, 27 Aug 2026 15:51:53 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Subject: [PATCH 0/3] hw/intc: Add LoongArch irqchip status display
Date: Thu, 27 Aug 2026 15:53:07 +0800
Message-ID: <20260827075310.1389232-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxnM6Z7I9qFvwTAA--.16948S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr15uF4rGr4rAry7tr4xGrX_yoW5JF18pr
 1UJr45Cr48Jr17Jr13Jr15Jr15Jr4Ik3WkJr17Jr1UAr1DKr1UXr1UJry8GryDGr1UJr17
 tF1DJr4UKr1UJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcHUqUUUUU
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

When irqchip in kernel is enabled, the register status of irqchip device
is in KVM kernel. Here add interrupt status display in user side in order
to debug ipi/pch_pci/extioi irqchip driver, however interrupt statistic
information is not added here since there is no obvious requirements.

Here is output of command "virsh qemu-monitor-command VM --hmp info pic"
loongarch_ipi:
  CPU 0   status=0x0 en=0xffffffff
  CPU 1   status=0x0 en=0xffffffff
  CPU 2   status=0x0 en=0xffffffff
  CPU 3   status=0x0 en=0xffffffff
loongarch_pic:
  mask     0xffffffffffffff7b msi_en 0xffffffffffffffff edge 0x0000000000000080 clr    0x0000000000000000
  last_irr 0x0000000000000000 irr    0x0000000000000040 isr  0x0000000000000000 polary 0x0000000000000000
  MSI map  0x0000040302010000 0x0000000000000000 0x0000000000060500 0x0000000000000000
           0x0000000000000000 0x0000000000000000 0x0000000000000000 0x0000000000000000
loongarch.extioi:
  ISR     0x0000000000000000 0x00000061007d0000 0x0000000000000000 0x0000000000000000
  ENABLE  0xffffffffffffffff 0xffffffffffffffff 0xffffffffffffffff 0xffffffffffffffff
  IPMAP   0x0808040402020101
  COREMAP 0x0000000000000003 0x0000000000000000 0x0000000000000000 0x0000000000000000
  COREMAP 0x0000000000000000 0x0000000000000000 0x0000000000000000 0x0000000000000000
  COREMAP 0x0002010103020202 0x0000030101030300 0x0000030201000203 0x0100010303000000
  COREMAP 0x0001030301020302 0x0000000000000000 0x0000000000000000 0x0000000000000000
  COREMAP 0x0000000000000000 0x0000000000000000 0x0000000000000000 0x0000000000000000
  COREMAP 0x0000000000000000 0x0000000000000000 0x0000000000000000 0x0000000000000000
  COREMAP 0x0000000000000000 0x0000000000000000 0x0000000000000000 0x0000000000000000
  COREMAP 0x0000000000000000 0x0000000000000000 0x0000000000000000 0x0000000000000000

Bibo Mao (3):
  hw/intc/loongarch_ipi: Add ipi interrupt status display
  hw/intc/loongarch_pch_pic: Add pic interrupt status display
  hw/intc/loongarch_extioi: Add extioi interrupt status display

 hw/intc/loongarch_extioi.c  | 58 +++++++++++++++++++++++++++++++++++++
 hw/intc/loongarch_ipi.c     | 42 +++++++++++++++++++++++++++
 hw/intc/loongarch_pch_pic.c | 38 ++++++++++++++++++++++++
 3 files changed, 138 insertions(+)


base-commit: 324bb5ef83ad5e9026ea3242f99ba53191a7bf3f
-- 
2.54.0


