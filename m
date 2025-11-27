Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548C0D116E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 00:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOPd6-0002lA-0K; Wed, 26 Nov 2025 19:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3hZcnaQcKCqIPCXKFGOIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--navidem.bounces.google.com>)
 id 1vOPd4-0002kV-Ff
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 19:12:58 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3hZcnaQcKCqIPCXKFGOIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--navidem.bounces.google.com>)
 id 1vOPd2-0005yf-Mi
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 19:12:58 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2958a134514so3874975ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 16:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1764202374; x=1764807174; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=LeSHcCma73ddYicqojpjXZ31wT8UUBvPT9dLg7HewLA=;
 b=jmEFVLlD8MMrer1J3HUXticKTG6e4/hfav1M5ChJqlma15wFtuq8vBzn8FrCwra2AY
 OXbbYD91+0+ULWwqbY62mdlcJ8ty/eQ9z5HFKK7+RhGMiR4dWS2QW21nu/PUSg9djZoW
 twnYwXanir+vd/6OA56huRmHs6B20AA+kEPyjueri/iIXvJE57DCfF1SI7/21ulKJwd7
 I2rugnyNxzrT5M6OMZa4yZ2/S7WcVZHDsWnP/6PZEcS2miglOxwkhCtU81U6l3jOmOQv
 Qvb7CyGMwWDR38rJmN3pW1L2huPrLSsQV4F9xv/oB8080EvOYbUtm9IzUrJ6uupEHt8B
 07rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764202374; x=1764807174;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LeSHcCma73ddYicqojpjXZ31wT8UUBvPT9dLg7HewLA=;
 b=D06ZNwoCoCl5rv1FhmWA274DNxS4o6DByXSFSxJ6ue+cYoSrPXEnRy5Em0C+VXOtf6
 OzDNSYGBNUcR2Glue7GNRnSfYY0bVo7Zi31Ij0mVwsiARW0G+wke1C9/yeygNEMyUVvQ
 6oMM1Pci5Qv0a7YB+PWQXxGgSHa/Kk+ttvqb1mS8AMu6Dsr3ugLQJ4GaSnY2XNI6t7eE
 g/orN+zD/nSFBGDKJbp6fQhpirC7bGjZ4lLBClWr8IzUBhqyElllBoT5hsi7i7VM1pwH
 lApADHrzdE3P1ShmcSgl44ntwuzfF0jx9QT8Ko9Z5fk9smHJtOLFbaAEb6mk/S8vxn8n
 CwJA==
X-Gm-Message-State: AOJu0YxAMuXCWqTIEVpkz+mT2Q7gDp3NsmC7mDYqkhiAdPRRMw6CwJCM
 pyUoiNd7f+E8XX2Y04yMXvxB1wssLwzFjZbIn7+0O/v5wu558Y5giADUrJh97xsmCMocrWXnZHc
 vyY7vGZReJ01xFsAatr/a9oczbkUgAyiiFutrO5wQ9FqH/yJJICok7gD1GbUwR7sBAsBj6b9Z9R
 4eGkYjpsJpLzYOadnPXMW7b1mJeQGips/wu/DwYK+D
X-Google-Smtp-Source: AGHT+IEonIG05F5DKSlGvsdxry2o3lDIvp64kc0KQCKQP426xBVLSkzprliwVJhouRXPMmn82VZfFXFAFJyg
X-Received: from plkh11.prod.google.com ([2002:a17:903:19eb:b0:298:465f:129])
 (user=navidem job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2341:b0:295:1a63:57b0
 with SMTP id d9443c01a7336-29baafca153mr90234845ad.23.1764202373663; Wed, 26
 Nov 2025 16:12:53 -0800 (PST)
Date: Thu, 27 Nov 2025 00:12:43 +0000
In-Reply-To: <20251127001247.1672873-1-navidem@google.com>
Mime-Version: 1.0
References: <CAFEAcA-hyn0B-yWE1=g4+NN9=NBjWvk-P8qrAk9L4vpAZpUYvQ@mail.gmail.com>
 <20251127001247.1672873-1-navidem@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251127001247.1672873-2-navidem@google.com>
Subject: [PATCH v2 1/5] libqos: pci: Handle zero-sized BARs gracefully
From: Navid Emamdoost <navidem@google.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, zsm@google.com, 
 alxndr@bu.edu, Navid Emamdoost <navidem@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3hZcnaQcKCqIPCXKFGOIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--navidem.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The qpci_iomap() function would previously fail with a fatal assertion
if it probed a PCI BAR that had a size of zero. This is, however,
expected behavior for some devices like the Q35 host bridge, and the
assertion blocked the creation of new fuzzing targets.

Instead of asserting at map time, modify the QPCIBar struct to store
the BAR's size. Defer the safety check to the accessor functions
(qpci_io_readb, qpci_memread, etc.), which now assert that any
access is within the BAR's bounds.

Signed-off-by: Navid Emamdoost navidem@google.com
---
 tests/qtest/libqos/pci.c | 25 ++++++++++++++++++++++++-
 tests/qtest/libqos/pci.h |  1 +
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index a59197b992..70caf382cc 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -396,6 +396,7 @@ void qpci_config_writel(QPCIDevice *dev, uint8_t offset, uint32_t value)
 
 uint8_t qpci_io_readb(QPCIDevice *dev, QPCIBar token, uint64_t off)
 {
+	g_assert(off + 1 <= token.size);
     QPCIBus *bus = dev->bus;
 
     if (token.is_io) {
@@ -410,6 +411,7 @@ uint8_t qpci_io_readb(QPCIDevice *dev, QPCIBar token, uint64_t off)
 
 uint16_t qpci_io_readw(QPCIDevice *dev, QPCIBar token, uint64_t off)
 {
+	g_assert(off + 2 <= token.size);
     QPCIBus *bus = dev->bus;
 
     if (token.is_io) {
@@ -424,6 +426,7 @@ uint16_t qpci_io_readw(QPCIDevice *dev, QPCIBar token, uint64_t off)
 
 uint32_t qpci_io_readl(QPCIDevice *dev, QPCIBar token, uint64_t off)
 {
+	g_assert(off + 4 <= token.size);
     QPCIBus *bus = dev->bus;
 
     if (token.is_io) {
@@ -438,6 +441,7 @@ uint32_t qpci_io_readl(QPCIDevice *dev, QPCIBar token, uint64_t off)
 
 uint64_t qpci_io_readq(QPCIDevice *dev, QPCIBar token, uint64_t off)
 {
+	g_assert(off + 8 <= token.size);
     QPCIBus *bus = dev->bus;
 
     if (token.is_io) {
@@ -453,6 +457,7 @@ uint64_t qpci_io_readq(QPCIDevice *dev, QPCIBar token, uint64_t off)
 void qpci_io_writeb(QPCIDevice *dev, QPCIBar token, uint64_t off,
                     uint8_t value)
 {
+	g_assert(off + 1 <= token.size);
     QPCIBus *bus = dev->bus;
 
     if (token.is_io) {
@@ -465,6 +470,7 @@ void qpci_io_writeb(QPCIDevice *dev, QPCIBar token, uint64_t off,
 void qpci_io_writew(QPCIDevice *dev, QPCIBar token, uint64_t off,
                     uint16_t value)
 {
+	g_assert(off + 2 <= token.size);
     QPCIBus *bus = dev->bus;
 
     if (token.is_io) {
@@ -478,6 +484,7 @@ void qpci_io_writew(QPCIDevice *dev, QPCIBar token, uint64_t off,
 void qpci_io_writel(QPCIDevice *dev, QPCIBar token, uint64_t off,
                     uint32_t value)
 {
+	g_assert(off + 4 <= token.size);
     QPCIBus *bus = dev->bus;
 
     if (token.is_io) {
@@ -491,6 +498,7 @@ void qpci_io_writel(QPCIDevice *dev, QPCIBar token, uint64_t off,
 void qpci_io_writeq(QPCIDevice *dev, QPCIBar token, uint64_t off,
                     uint64_t value)
 {
+	g_assert(off + 8 <= token.size);
     QPCIBus *bus = dev->bus;
 
     if (token.is_io) {
@@ -500,10 +508,10 @@ void qpci_io_writeq(QPCIDevice *dev, QPCIBar token, uint64_t off,
         bus->memwrite(bus, token.addr + off, &value, sizeof(value));
     }
 }
-
 void qpci_memread(QPCIDevice *dev, QPCIBar token, uint64_t off,
                   void *buf, size_t len)
 {
+	g_assert(off + len <= token.size);
     g_assert(!token.is_io);
     dev->bus->memread(dev->bus, token.addr + off, buf, len);
 }
@@ -511,6 +519,7 @@ void qpci_memread(QPCIDevice *dev, QPCIBar token, uint64_t off,
 void qpci_memwrite(QPCIDevice *dev, QPCIBar token, uint64_t off,
                    const void *buf, size_t len)
 {
+	g_assert(off + len <= token.size);
     g_assert(!token.is_io);
     dev->bus->memwrite(dev->bus, token.addr + off, buf, len);
 }
@@ -541,6 +550,19 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
         addr &= PCI_BASE_ADDRESS_MEM_MASK;
     }
 
+    if (!addr){
+        /*
+         * This is an unimplemented BAR. It is not a fatal error.
+         * We model it as a BAR with a size of zero. Any attempt to
+         * access it will be caught by assertions in the accessors.
+         */
+        if (sizeptr) {
+            *sizeptr = 0;
+        }
+        memset(&bar, 0, sizeof(bar));
+        return bar;
+    }
+
     g_assert(addr); /* Must have *some* size bits */
 
     size = 1U << ctz32(addr);
@@ -572,6 +594,7 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
     }
 
     bar.addr = loc;
+    bar.size = size;
     return bar;
 }
 
diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 8389614523..e790e5293d 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -58,6 +58,7 @@ struct QPCIBus {
 
 struct QPCIBar {
     uint64_t addr;
+    uint64_t size;
     bool is_io;
 };
 
-- 
2.52.0.158.g65b55ccf14-goog


