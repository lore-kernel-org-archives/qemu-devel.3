Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F82FC2A069
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 02:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcDs0-0002wA-7H; Sat, 03 Jan 2026 21:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vcDrx-0002v7-2N
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 21:29:25 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vcDru-00071v-3H
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 21:29:24 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Cx68J10Flp9EoFAA--.16410S3;
 Sun, 04 Jan 2026 10:29:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJAxWcFy0Flp2_ULAA--.13602S2;
 Sun, 04 Jan 2026 10:29:07 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] target/loongarch: Add host CPU type support
Date: Sun,  4 Jan 2026 10:29:01 +0800
Message-Id: <20260104022905.2120787-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxWcFy0Flp2_ULAA--.13602S2
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

Host CPU model is basically the same with max CPU model, except Product
ID and CPU model name. With host CPU model, Product ID comes from
cpucfg0 on host machine and CPU model from /proc/cpuinfo, also some
CPUCFG bits which are irrelative with KVM hypervisor somes from host
machine.

---
v1 ... v2:
  1. Add some CPUCFG capability bits from host machine.
---
Bibo Mao (4):
  target/loongarch: Add detailed information with CPU Product ID
  target/loongarch: Add generic CPU model information
  target/loongarch: Add host CPU model in kvm mode
  target/loongarch: Add some CPUCFG bits with host CPU model

 hw/loongarch/virt.c    |   6 +-
 target/loongarch/cpu.c | 135 ++++++++++++++++++++++++++++++++++++++++-
 target/loongarch/cpu.h |  24 +++++++-
 3 files changed, 160 insertions(+), 5 deletions(-)


base-commit: 667e1fff878326c35c7f5146072e60a63a9a41c8
-- 
2.39.3


