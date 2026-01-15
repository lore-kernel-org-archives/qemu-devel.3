Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498AED3CCB3
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 06:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgHAA-0007AL-Rj; Thu, 15 Jan 2026 01:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vgHA7-00078I-TM
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 01:48:55 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vgHA4-0006FU-3y
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 01:48:55 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dx_8PKjWhp8xMJAA--.29821S3;
 Thu, 15 Jan 2026 14:48:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJAxHMLJjWhpReoeAA--.61288S2;
 Thu, 15 Jan 2026 14:48:41 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] loongarch queue
Date: Thu, 15 Jan 2026 14:48:34 +0800
Message-Id: <20260115064840.219920-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxHMLJjWhpReoeAA--.61288S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
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

The following changes since commit d03c3e522eb0696dcfc9c2cf643431eaaf51ca0f:

  Merge tag 'pull-vfio-20260113' of https://github.com/legoater/qemu into staging (2026-01-14 02:37:13 +1100)

are available in the Git repository at:

  https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20260115

for you to fetch changes up to 49ee001a5b8378e9a9b3db8cbf61e7eda970ecd2:

  hw/loongarch/virt: Don't abort on access to unimplemented IOCSR (2026-01-15 14:36:11 +0800)

----------------------------------------------------------------
pull-loongarch-20260115 queue

----------------------------------------------------------------
Song Gao (3):
      target/loongach: Fix some exceptions failure in updating CSR_BADV
      target/loongarch: Fix exception BCE missing to update CSR_BADV
      target/loongarch: Fix exception ADEF/ADEM missing to update CSR_BADV

Xianglai Li (2):
      hw/loongarch/virt: Modify the interrupt trigger type in fdt table
      hw/loongarch/virt: Fix irq allocation failure with pci device from fdt

Yao Zi (1):
      hw/loongarch/virt: Don't abort on access to unimplemented IOCSR

 hw/loongarch/virt-fdt-build.c  | 55 ++++++++++++++++++++++++++++--------------
 hw/loongarch/virt.c            | 14 +++++++++--
 target/loongarch/tcg/tcg_cpu.c |  7 +++---
 3 files changed, 53 insertions(+), 23 deletions(-)


