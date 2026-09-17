Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3E0C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7JkS-0007x3-8D; Thu, 17 Sep 2026 17:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7JkN-0007vy-8a; Thu, 17 Sep 2026 17:34:23 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7JkI-0005uy-HN; Thu, 17 Sep 2026 17:34:22 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 02B1043E36;
 Thu, 17 Sep 2026 21:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF471F000FF;
 Thu, 17 Sep 2026 21:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789680848;
 bh=fQRmR9lE14wGY1FrTI9fM5TiOsIeYq4zXoFKivHzOKQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WFwYejFgfj7FLR0LxaZoJASoJ28lF9kLMEiRaNo1MiquKidekzGwP1nqv7DYuLE7z
 H65/dhvKQ1L8s6iLWzTQJxZRML+rO2lMPFrIiOf7szrOLI+RMCVPAXuUpF4URvAtMx
 JLOOQ13Rr9S76NyRG5MAlPqfoTBgBfolAIGOcsES/8v31pjSHxXjqsASKrMKK/y+vF
 MYkVJZxv42fBycCR0gPtlpjFwpfSwWjSA4QZlqnO5Y1PvOR7qGvGYZ5KAvt1fOdK44
 H4hswz2PQWH3AUaRnTrefSf0s35fHZv6eXI7R+3j3KsacgvLsXWjtMHLSES4+Gztir
 iIPBy3pjd1k3w==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Helge Deller <deller@gmx.de>, John Snow <jsnow@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>,
 qemu-block@nongnu.org
Subject: [PATCH 1/7] hw/pci/pci_ids: Add PCI vendor ID and IDs for NS chips
Date: Thu, 17 Sep 2026 23:33:54 +0200
Message-ID: <20260917213402.3127-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260917213402.3127-1-deller@kernel.org>
References: <20260917213402.3127-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Helge Deller <deller@gmx.de>

Some HP B- and C-class workstations used a PCI SuperIO chip from National
Semiconductor for USB, serial, parallel and FDC. Add the relevant PCI IDs, so
that the QEMU driver can reuse the constants.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 include/hw/pci/pci_ids.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index 16034aaa2c..477609ed62 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -168,6 +168,11 @@
 #define PCI_DEVICE_ID_LSI_SAS1078        0x0060
 #define PCI_DEVICE_ID_LSI_SAS0079        0x0079
 
+#define PCI_VENDOR_ID_NS                 0x100b
+#define PCI_DEVICE_ID_NS_87415           0x0002
+#define PCI_DEVICE_ID_NS_87560_LIO       0x000e
+#define PCI_DEVICE_ID_NS_87560_USB       0x0012
+
 #define PCI_VENDOR_ID_DEC                0x1011
 #define PCI_DEVICE_ID_DEC_21143          0x0019
 
-- 
2.54.0


