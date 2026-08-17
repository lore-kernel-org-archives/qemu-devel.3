Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E44C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxXq-0000Ph-QU; Mon, 17 Aug 2026 09:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxXj-00008p-U2; Mon, 17 Aug 2026 09:38:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxXi-0007p1-9Y; Mon, 17 Aug 2026 09:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786973727; bh=VmzP4cwG8y5g3NtV0tq+9+rh6fizh+WXwZl0J9kgTLY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MTYkWi8ZU5l5vWefM9PK5B9Pu0oyWlr4ghoVJG2jIzQsjZDiEksiQuY5bF/NDiwzq
 cuvP0+Qgq6sefSEJ4q8DeON0e2ajNN388oGr2qiL3YHDxi1P6tyjoJX3v0R4/2cLCz
 sePHgzQ35j3zWEiF4Zb0/uBpMatBVgOk8tBpkm24Ebbta2uarzpbze/jwQ1lTXhFlZ
 cY8P7X51o1AlfFTHY+p0P3u2hcm2S/jHDXyYUQo3ivq5EOItvEjE6OzTR8paMvVLxM
 ITnzfMhqzJtAPvn3aZEZ1CFJvzABfItVACSz8lYTGKW2SrL33LHsWlV63llWIRxqhy
 K1p6wfJM4Yxbw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9A5E61CBCD5;
 Mon, 17 Aug 2026 16:35:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D57DE40D432;
 Mon, 17 Aug 2026 16:35:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E538B30FB4; Mon, 17 Aug 2026 16:35:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v2 134/135] hw/nvme: add SPDM_SOCKET Kconfig
 dependency
Date: Mon, 17 Aug 2026 16:34:44 +0300
Message-ID: <20260817133451.2384630-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
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


