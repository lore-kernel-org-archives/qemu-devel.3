Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4706FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 07:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbDgF-0005vf-Hx; Fri, 24 Jan 2025 02:00:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tbDgC-0005t1-2q
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 02:00:36 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tbDg8-00083j-FY
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 02:00:35 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxG+KHOpNnHyhoAA--.6408S3;
 Fri, 24 Jan 2025 15:00:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx_8eGOpNnM2ksAA--.32130S2;
 Fri, 24 Jan 2025 15:00:22 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 0/7] loongarch-to-apply queue
Date: Fri, 24 Jan 2025 15:00:14 +0800
Message-Id: <20250124070021.800907-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_8eGOpNnM2ksAA--.32130S2
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit cf86770c7aa31ebd6e56f4eeb25c34107f92c51e:

  Merge tag 'pull-request-2025-01-21v2' of https://gitlab.com/thuth/qemu into staging (2025-01-22 09:59:02 -0500)

are available in the Git repository at:

  https://gitlab.com/bibo-mao/qemu.git tags/pull-loongarch-20250124

for you to fetch changes up to 3215fe8528de45a1794f0314623cc10bd8e8e19f:

  target/loongarch: Dump all generic CSR registers (2025-01-24 14:49:24 +0800)

----------------------------------------------------------------
pull-loongarch-20250124 queue

----------------------------------------------------------------
Bibo Mao (7):
      target/loongarch: Add dynamic function access with CSR register
      target/loongarch: Remove static CSR function setting
      target/loongarch: Add generic csr function type
      target/loongarch: Add common header file for CSR registers
      target/loongarch: Add common source file for CSR register
      target/loongarch: Set unused flag with CSR registers
      target/loongarch: Dump all generic CSR registers

 target/loongarch/cpu.c                             |  96 +++++++++---
 target/loongarch/csr.c                             | 129 +++++++++++++++++
 target/loongarch/csr.h                             |  29 ++++
 target/loongarch/meson.build                       |   1 +
 .../tcg/insn_trans/trans_privileged.c.inc          | 161 +++++----------------
 target/loongarch/tcg/tcg_loongarch.h               |  12 ++
 target/loongarch/tcg/translate.c                   |   5 +
 7 files changed, 294 insertions(+), 139 deletions(-)
 create mode 100644 target/loongarch/csr.c
 create mode 100644 target/loongarch/csr.h
 create mode 100644 target/loongarch/tcg/tcg_loongarch.h


