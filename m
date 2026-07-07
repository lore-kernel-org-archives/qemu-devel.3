Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA8DC44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5Jg-0000Pr-VW; Tue, 07 Jul 2026 08:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wh5Jd-0000P6-Lt
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:54:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wh5JZ-0003W1-SX
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:54:21 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxuvCS9kxqHe4AAA--.4054S3;
 Tue, 07 Jul 2026 20:52:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJAxX8eF9kxqpekDAA--.23644S10;
 Tue, 07 Jul 2026 20:52:33 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, lixianglai@loongson.cn,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 8/8] MAINTAINERS: add LoongArch's maintainers
Date: Tue,  7 Jul 2026 20:32:26 +0800
Message-Id: <20260707123226.25918-9-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260707123226.25918-1-gaosong@loongson.cn>
References: <20260707123226.25918-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxX8eF9kxqpekDAA--.23644S10
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Xianglai Li <lixianglai@loongson.cn>
Message-ID: <20260703095538.3211983-3-gaosong@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03afb5c7dc..614d04fae3 100644
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
2.55.0


