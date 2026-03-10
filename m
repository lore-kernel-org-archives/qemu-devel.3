Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C279EFD88C7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05d1-0001Hc-CL; Tue, 10 Mar 2026 18:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cx-0001GU-8J
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:36 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cv-000740-RO
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:34 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 12ac18be3bf7e79e0eb564a6cc4c3d4b410700961179fd83028dbfb35223fa36 with SMTP id
 69b09bf698e94a06ee1352f6; Tue, 10 Mar 2026 22:32:22 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1773181942;
 bh=2qNE+06FFkIw6FzpLa1xH6jqTf5ePHgQhjUSgoNbprA=;
 h=X-Mailgun-Dkim:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Developer-Signature:X-Developer-Key:From:Reply-to:Subject:Date:
 Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=PR+vIq/7UsXb6i9K5wVfn8CfYq/P1YJ2/iLc+0jGFA+UuEPY87oIlzu4Jn2l7p5Qp
 ubuMTFYRFCNTRCwuRECmmNyWEICxbYlpllZysPqQvkC1mZI+3RGjuplfdKdXvJKBm6
 +JV2RdAUFDQsu9WOZAdhGLVOz62s+nlYIF49Z7Yk3lBqLbzZ3vZiM6+SI9s1GgpyzE
 JJCv2fQDx9O9oNyCH/OdlWZm5ehvkBcIQBz1BYIaiQEDHhkb+b3hbb33XDLX7Nsh6s
 xZfz4iXEGMJNbnxdQGCBUuwBQvngn1tUQOHBuL3lINP9XiAvczM0dx5R9NSp2MgAxr
 zHP9SF7E9QjHQ==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Date: Tue, 10 Mar 2026 17:31:51 -0500
Subject: [PATCH 11/15] hw/alpha: Explicitly define TyphoonClass in alpha_sys.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-MS-Reactions: disallow
Message-Id: <20260310-qomify-alpha-v1-11-4375b00a85ff@yodel.dev>
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
In-Reply-To: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Yodel Eldar <yodel.eldar@yodel.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; i=yodel.eldar@yodel.dev; 
 h=from:subject:message-id;
 bh=tloD9q2Ixvhe/Je+2/nijrGzuxhxU/t2z7pz6TfC2+s=; 
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI3zP6k+8xj87YPYpMPRLju3Oq6/mm4nMF+s7/73N/w9
 R/7u2WBc0cpC4MYF4OsmCLL5bMSZx1yd3elrfxxH2YOKxPIEAYuTgGYCG8WI8Pe7Blyzmu33XLk
 +76Hky0o/92/ZYVtC9lWV/L1C0uqNgYy/C/+FR/sXhR39PI/mU9el/bKrrWJPmzSvss8bcH+f8c
 VfnMCAA==
X-Developer-Key: i=yodel.eldar@yodel.dev; a=openpgp;
 fpr=D3CD18CD406DBB8A66A9F8DF95EE4FB736654DAC
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HELO_STATIC_HOST=-0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Currently, the Typhoon has no additional class fields besides
its inheritance (PCIHostBridgeClass), so an explicit definition
of its class struct was unnecessary, and we simply used
OBJECT_DECLARE_SIMPLE_TYPE to declare its instance and class;
however, forthcoming changes will require additional Typhoon-specific
class fields.

This commit creates the Typhoon class definition, although it remains
a shell of its parent class for now.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 hw/alpha/alpha_sys.h | 8 +++++++-
 hw/alpha/typhoon.c   | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index 8611881b55..794a47127d 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -5,11 +5,17 @@
 
 #include "target/alpha/cpu-qom.h"
 #include "hw/pci/pci.h"
+#include "hw/pci/pci_host.h"
 #include "hw/core/boards.h"
 #include "hw/intc/i8259.h"
 
 #define TYPE_TYPHOON_PCI_HOST_BRIDGE "typhoon-pcihost"
-OBJECT_DECLARE_SIMPLE_TYPE(TyphoonState, TYPHOON_PCI_HOST_BRIDGE)
+
+typedef struct TyphoonClass {
+    PCIHostBridgeClass parent_class;
+} TyphoonClass;
+
+OBJECT_DECLARE_TYPE(TyphoonState, TyphoonClass, TYPHOON_PCI_HOST_BRIDGE)
 
 PCIBus *typhoon_init(pci_map_irq_fn, uint8_t devfn_min, TyphoonState *);
 
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 792ace5ce7..8745025319 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -976,6 +976,7 @@ static const TypeInfo typhoon_pcihost_info = {
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(TyphoonState),
     .instance_init = typhoon_pcihost_init,
+    .class_size    = sizeof(TyphoonClass),
     .class_init    = typhoon_pcihost_class_init,
 };
 

-- 
2.53.0


