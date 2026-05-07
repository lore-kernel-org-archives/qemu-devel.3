Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35622CD3427
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 09:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKvMz-0000AZ-8g; Thu, 07 May 2026 05:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wKvMx-0000A6-D5
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:50:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wKvMu-0005Kq-Ky
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:50:11 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxvelJYPxp83AHAA--.22440S3;
 Thu, 07 May 2026 17:50:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxD8NCYPxpUTJ8AA--.39812S3;
 Thu, 07 May 2026 17:50:00 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org, lixianglai@loongson.cn, chenhuacai@loongson.cn,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 1/4] scripts/update-linux-headers: Add typelimits.h
Date: Thu,  7 May 2026 17:23:55 +0800
Message-Id: <20260507092358.2479135-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260507092358.2479135-1-gaosong@loongson.cn>
References: <20260507092358.2479135-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxD8NCYPxpUTJ8AA--.39812S3
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

From: Avihai Horon <avihaih@nvidia.com>

Upstream Linux added include/uapi/linux/typelimits.h and includes it
from ethtool.h [1][2].

Teach update-linux-headers.sh to install that header into
standard-headers to be able to update kernel headers to versions that
include the above changes.

[1] ca9d74eb5f6a ("uapi: add INT_MAX and INT_MIN constants")
[2] a8a11e5237ae ("ethtool: uapi: Use UAPI definition of INT_MAX")

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 scripts/update-linux-headers.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 386d7a38e7..da367acee7 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -60,6 +60,7 @@ cp_portable() {
                                      -e 'drm.h' \
                                      -e 'limits' \
                                      -e 'linux/const' \
+                                     -e 'linux/typelimits' \
                                      -e 'linux/kernel' \
                                      -e 'linux/sysinfo' \
                                      -e 'asm/setup_data.h' \
@@ -250,6 +251,7 @@ for i in "$hdrdir"/include/linux/*virtio*.h \
          "$hdrdir/include/linux/pci_regs.h" \
          "$hdrdir/include/linux/ethtool.h" \
          "$hdrdir/include/linux/const.h" \
+         "$hdrdir/include/linux/typelimits.h" \
          "$hdrdir/include/linux/kernel.h" \
          "$hdrdir/include/linux/kvm_para.h" \
          "$hdrdir/include/linux/vhost_types.h" \
-- 
2.54.0


