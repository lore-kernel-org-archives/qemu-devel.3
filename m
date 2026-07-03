Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AE0C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfb2S-0000ZE-0n; Fri, 03 Jul 2026 06:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wfb2P-0000Yp-V2
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:22:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wfb2O-0007dH-3p
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:22:25 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxZ_FXjUdqlU0BAA--.7186S3;
 Fri, 03 Jul 2026 18:22:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxSMFTjUdqGNq9AA--.17889S3;
 Fri, 03 Jul 2026 18:22:12 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: maobibo@loongson.cn,
	lixianglai@loongson.cn
Subject: [PATCH 1/2] MAINTAINERS: update Song Gao's email address
Date: Fri,  3 Jul 2026 17:55:37 +0800
Message-Id: <20260703095538.3211983-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260703095538.3211983-1-gaosong@loongson.cn>
References: <20260703095538.3211983-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxSMFTjUdqGNq9AA--.17889S3
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

Update maintainer email from gaosong@loongson.cn to
17746591750@163.com and add corresponding .mailmap entries.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 .mailmap    | 1 +
 MAINTAINERS | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 8ade2eed66..593b6c2c53 100644
--- a/.mailmap
+++ b/.mailmap
@@ -119,6 +119,7 @@ Roman Bolshakov <rbolshakov@ddn.com> <r.bolshakov@yadro.com>
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> <sriram.yagnaraman@est.tech>
 Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
 Stefan Weil <sw@weilnetz.de> Stefan Weil <stefan@weilnetz.de>
+Song Gao <17746591750@163.com> <gaosong@loongson.cn>
 Taylor Simpson <ltaylorsimpson@gmail.com> <tsimpson@quicinc.com>
 Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 97dcc78ded..ef4c3b5c5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -280,7 +280,7 @@ F: disas/hppa.c
 F: tests/tcg/hppa/
 
 LoongArch TCG CPUs
-M: Song Gao <gaosong@loongson.cn>
+M: Song Gao <17746591750@163.com>
 S: Maintained
 F: target/loongarch/
 F: tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -1360,7 +1360,7 @@ F: docs/devel/hexagon-sys.rst
 LoongArch Machines
 ------------------
 Virt
-M: Song Gao <gaosong@loongson.cn>
+M: Song Gao <17746591750@163.com>
 M: Bibo Mao <maobibo@loongson.cn>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Maintained
-- 
2.47.3


