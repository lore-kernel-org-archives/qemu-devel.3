Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A1DCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 03:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8sdp-0001bA-0L; Tue, 14 Oct 2025 23:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v8sdf-0001Zd-QR
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 23:57:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v8sdV-0006ma-35
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 23:57:19 -0400
Received: from loongson.cn (unknown [10.2.10.34])
 by gateway (Coremail) with SMTP id _____8Cx6tGMG+9onUUWAA--.48080S3;
 Wed, 15 Oct 2025 11:57:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
 by front1 (Coremail) with SMTP id qMiowJCxM+SEG+9oJMrkAA--.45496S2;
 Wed, 15 Oct 2025 11:56:52 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] loongarch queue
Date: Wed, 15 Oct 2025 11:56:47 +0800
Message-Id: <20251015035651.1462972-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxM+SEG+9oJMrkAA--.45496S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw4rKF1xCF4DGrykXr47Awc_yoW8GFy8pr
 W3CrnxGr48Gr9rJrn3Xry5Xr15Jrn7GF12qF13try8Cr43Zr1UZr18Ar1kCFyUJ34rJry0
 qr1rCw1DuF1UJrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
 xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
 Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jr0_JrylIxkGc2Ij64vIr41lIxAIcVC0I7
 IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
 6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
 AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 3bf5c57a11827d9fa706524d57ee3e5af68a429e:

  Merge tag 'pull-tcg-20251014' of https://gitlab.com/rth7680/qemu into staging (2025-10-14 10:25:05 -0700)

are available in the Git repository at:

  https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20251015

for you to fetch changes up to a9c5e0ed9b63becde7a6188bf71f95e31a132b19:

  hw/loongarch/virt: Sort order by hardware device base address (2025-10-15 11:07:37 +0800)

----------------------------------------------------------------
pull-loongarch-20251015 queue

----------------------------------------------------------------
Bibo Mao (4):
      target/loongarch: Add missing TLB flush with different asid
      target/loongarch: Skip global TLB when calculating replaced TLB
      hw/loongarch/virt: Remove header file ls7a.h
      hw/loongarch/virt: Sort order by hardware device base address

 MAINTAINERS                            |  1 -
 hw/intc/loongarch_pic_kvm.c            |  1 -
 hw/loongarch/virt-acpi-build.c         |  1 -
 hw/loongarch/virt-fdt-build.c          |  1 -
 hw/loongarch/virt.c                    |  3 +-
 include/hw/intc/loongarch_pic_common.h |  2 +-
 include/hw/loongarch/virt.h            | 75 +++++++++++++++++++++++++---------
 include/hw/pci-host/ls7a.h             | 39 ------------------
 target/loongarch/tcg/tlb_helper.c      | 22 ++++++----
 9 files changed, 70 insertions(+), 75 deletions(-)


