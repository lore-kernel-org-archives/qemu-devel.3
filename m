Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07756C5DF7F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvutQ-0006hw-4m; Mon, 17 Aug 2026 06:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvut5-0006GM-58; Mon, 17 Aug 2026 06:48:20 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvut3-0004QL-11; Mon, 17 Aug 2026 06:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786963487; bh=VmzP4cwG8y5g3NtV0tq+9+rh6fizh+WXwZl0J9kgTLY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PNmsxjWIs4Ysuq7T5SCcMJsUd63UwFY0IvkyjD5Pce1m9gDdHL2XxAU7N0H6QF1Ok
 VlEcBOPx4EXpvdNHlEJD6xTNXeGa7QoErPHzdjLupYMsEmdOS8VAln+1NaA2pUWMw+
 dd5Rjabh4Z5Phhc7TOvzVYvo7OYExGR3LeN7L+yfAvGFWsC+TyUk7YY/OWhFKAgmax
 3ALk4w9XB/6O58no07yIjlDZVgvj4TrVYJtplt4Yn1+1ORhCqSuVnBxEIzwHNBE2ze
 /SgHxKZUEUN+0gZ6FXkk9bl9lE7Dn+efcfaKdcWgprDjJZM199UHh6+duudWdPRi9y
 w9F6OoH6veb2w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 09EE21CBB8D;
 Mon, 17 Aug 2026 13:44:47 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0B8EE40D221;
 Mon, 17 Aug 2026 13:45:08 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 67D5A30E92; Mon, 17 Aug 2026 13:44:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v2 160/161] hw/nvme: add SPDM_SOCKET Kconfig dependency
Date: Mon, 17 Aug 2026 13:43:14 +0300
Message-ID: <20260817104344.2047346-40-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The NVMe emulation code unconditionally calls spdm_socket_*() APIs. Add
a Kconfig dependency to avoid build errors when NVME_PCI is enabled
without SPDM_SOCKET.

Fixes: 4f947b10d52 ("hw/nvme: Add SPDM over DOE support")
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260810214846.76805-1-stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 6dab35f5492b04083f70726a3048d89d8deb4a32)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/Kconfig b/hw/nvme/Kconfig
index cfa2ab0f9d5..cfeeed64cd7 100644
--- a/hw/nvme/Kconfig
+++ b/hw/nvme/Kconfig
@@ -2,3 +2,4 @@ config NVME_PCI
     bool
     default y if PCI_DEVICES || PCIE_DEVICES
     depends on PCI
+    select SPDM_SOCKET
-- 
2.47.3


