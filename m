Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A30E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 21:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXooD-0000rv-Ft; Tue, 14 Jan 2025 16:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linux@weissschuh.net>)
 id 1tXooB-0000rT-F6
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 16:50:47 -0500
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linux@weissschuh.net>)
 id 1tXoo8-0003fx-6I
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 16:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
 s=mail; t=1736891435;
 bh=uRwcJb3TjICUyPhUz/VimhDyFmB/p85NF8kCEbSI6rU=;
 h=From:Date:Subject:To:Cc:From;
 b=an8fopgQswiF/V2vvDZ1FiwbUwKXGQM27ZNAOzPSnKSKA55W3uWa1zfB7ePccxYuM
 JQzRrC7Z4SUkPaRVyWbjhytKLNfUbx7v8WdAZqpnbxhSQOrtPLTtTyubWD1AVsefcm
 HGs0ARVySZvBqf/gZlR89Vv7lzHTdJVslkBC10Ps=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 14 Jan 2025 22:50:20 +0100
Subject: [PATCH] firmware: qemu_fw_cfg: constify 'struct bin_attribute'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250114-sysfs-const-bin_attr-qemu_fw_cfg-v1-1-76f525a3ee72@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIABvchmcC/x3NPQ7DIAxA4atEnmsJUjLQq1QVotROPIQkmP4py
 t2LOn7LezsoFSGFS7dDoZeoLLnBnjpIU8wjoTyaoTf9YKx1qF9lxbRkrXiXHGKtBTean4HfIfG
 IHF30gz87bxy0zFqI5fNfXG/H8QMxw/qBcgAAAA==
X-Change-ID: 20250114-sysfs-const-bin_attr-qemu_fw_cfg-fa4a95934904
To: Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736891434; l=1599;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=uRwcJb3TjICUyPhUz/VimhDyFmB/p85NF8kCEbSI6rU=;
 b=V9U8C+VpPf8QiCxoM33e4TVTUFnByc39D1XF6YXt5z3hK4HZlNwyy/pmUlQFi4gXxOpgsOWbv
 4u8avJbXg2EBaUus0gzBwtySCHum5JEP4KdqTN2puzdjjO3uIIXT34m
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=2a01:4f8:c010:41de::1;
 envelope-from=linux@weissschuh.net; helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/firmware/qemu_fw_cfg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index d58da3e4500a5e230b7da9a75e4d70df7c38c542..2615fb780e3c4500db36d4746880455f05479f1f 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -460,7 +460,7 @@ static const struct kobj_type fw_cfg_sysfs_entry_ktype = {
 
 /* raw-read method and attribute */
 static ssize_t fw_cfg_sysfs_read_raw(struct file *filp, struct kobject *kobj,
-				     struct bin_attribute *bin_attr,
+				     const struct bin_attribute *bin_attr,
 				     char *buf, loff_t pos, size_t count)
 {
 	struct fw_cfg_sysfs_entry *entry = to_entry(kobj);
@@ -474,9 +474,9 @@ static ssize_t fw_cfg_sysfs_read_raw(struct file *filp, struct kobject *kobj,
 	return fw_cfg_read_blob(entry->select, buf, pos, count);
 }
 
-static struct bin_attribute fw_cfg_sysfs_attr_raw = {
+static const struct bin_attribute fw_cfg_sysfs_attr_raw = {
 	.attr = { .name = "raw", .mode = S_IRUSR },
-	.read = fw_cfg_sysfs_read_raw,
+	.read_new = fw_cfg_sysfs_read_raw,
 };
 
 /*

---
base-commit: 7f5b6a8ec18e3add4c74682f60b90c31bdf849f2
change-id: 20250114-sysfs-const-bin_attr-qemu_fw_cfg-fa4a95934904

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


