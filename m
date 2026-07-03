Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EB2C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfb2R-0000ZC-0R; Fri, 03 Jul 2026 06:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wfb2P-0000YX-AS
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:22:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wfb2N-0007cG-8g
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:22:24 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Ax+fBXjUdqlk0BAA--.7105S3;
 Fri, 03 Jul 2026 18:22:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxSMFTjUdqGNq9AA--.17889S4;
 Fri, 03 Jul 2026 18:22:15 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: maobibo@loongson.cn,
	lixianglai@loongson.cn
Subject: [PATCH 2/2] MAINTAINERS: add LoongArch's maintainers
Date: Fri,  3 Jul 2026 17:55:38 +0800
Message-Id: <20260703095538.3211983-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260703095538.3211983-1-gaosong@loongson.cn>
References: <20260703095538.3211983-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxSMFTjUdqGNq9AA--.17889S4
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

Add xianglai and bibo as maintainers for the loongarch architecture

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ef4c3b5c5b..fe3a3c2b57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -281,6 +281,8 @@ F: tests/tcg/hppa/
 
 LoongArch TCG CPUs
 M: Song Gao <17746591750@163.com>
+M: Bibo Mao <maobibo@loongson.cn>
+R: Xianglai Li <lixianglai@loongson.cn>
 S: Maintained
 F: target/loongarch/
 F: tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -1362,6 +1364,7 @@ LoongArch Machines
 Virt
 M: Song Gao <17746591750@163.com>
 M: Bibo Mao <maobibo@loongson.cn>
+R: Xianglai Li <lixianglai@loongson.cn>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Maintained
 F: docs/system/loongarch/virt.rst
-- 
2.47.3


