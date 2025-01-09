Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193FEC3ABA1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 07:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVnJ6-0002Zp-Dg; Thu, 09 Jan 2025 02:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tVnJ4-0002XD-Vb
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 02:50:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tVnJ3-0003Cm-7M
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 02:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736409016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nPs58JMEVnx0vxBZVcUrjc3mO8XjDcCYlK8l+CnF45w=;
 b=IPwAm1xsjPZ/x613vriDPuUNFlri96ujoOJ3rVniy/ZtDoJkpBJmXHzmzA1WgRxa9jFqJV
 RPbCF3gq2HnoeltQaqakXYft2W8jfTi7XHF1MZhiIfcZTKkTLC16KfYSaUltaJ1zROd127
 BhGbqOa312W0Vd71aXsTwgFXAU671x4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-VHcYz5ItMCKHfRoxOoWh6w-1; Thu, 09 Jan 2025 02:50:14 -0500
X-MC-Unique: VHcYz5ItMCKHfRoxOoWh6w-1
X-Mimecast-MFC-AGG-ID: VHcYz5ItMCKHfRoxOoWh6w
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-216405eea1fso11077585ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 23:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736409014; x=1737013814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nPs58JMEVnx0vxBZVcUrjc3mO8XjDcCYlK8l+CnF45w=;
 b=pUQsOOWP4dPj7Rg8/7i/sDkYC/eKb4vBEHPGETM/TT4+6GRncykF2nsru9GHkjNSbf
 FRmNAXqFncihzlRAeoDLH31xZA4R8y2edyWVYSWjFaM0piTae3lnPHDDncZPxIhnTVjW
 kZL0dIZry3A+VFeSskj2mfnZ9otwI9VuIhB1e9E9Unt7crG6jyV895pIRBDDW8hfJpvK
 HEExytW1llcNF0qn6nhzc2Mzo34C9moHRLz8GZCNzXOc7t6XUZJDhiRQiyglvlori1ao
 7QGZKFel0Sr/SRU9dqny4dHmsD2f5wJbPpSSiCccLyxPa+/i6L94Dx9J1/B7icwwQgSn
 bGig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXauPvs+vEGbhS7lYF5S47cvE4uLwKcFEAai8CWn1qaOkQECi8hVqmh6S0q/HYTIE2pIEZZl+kj9pNF@nongnu.org
X-Gm-Message-State: AOJu0Yz/u2HLFvTleAXqMKXkMCqtc9JCoRwFpino6sVzQ4L7L5iwyUGi
 x+H0BjfKGwZXUoXtbRxzC7uwwGl8IMmsZvwPXorgJOCQ6XSwUgSFRBcFYATACPLqFT5hq+Vwx0v
 WiCL5Xl/MR+VMZ2yDRid5MivLjAR7n9/yGG+GSVOVWF1VKEzyLwNy
X-Gm-Gg: ASbGncsklSDXRfCiWQnMYvF+ZvfkbyZW+WGMx25rpcDBQUAnoP7tsOtKDwlfATYT8xL
 x2aHUuRcmzi/jmIXYIRRZbgVNaCMZ5D6f9Fv4lj3jiwF9NQrqRSXluQmFWXjgEX5SXodLxVkSrQ
 M1qepzFm2QRiB5jEKZapW2grcCAO15dllTul4w7KdSFMDNPl9za0rP5tTlMODdD/DMsoFB4Y1Dw
 Naa9lPfnHnFBDDnBHQ8Anl3eqymikwgbsbaYdB4XPc5/vmg12Wudlr40jBD7zS1V5UewAaK7XD5
 Cchh
X-Received: by 2002:a05:6a20:1595:b0:1e1:ab63:c5e8 with SMTP id
 adf61e73a8af0-1e88d132eedmr7935242637.26.1736409013365; 
 Wed, 08 Jan 2025 23:50:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeP40YI4gPjfeS4yv7nr3XwoG2DH1KnLpUGGqBNbnEI7/o5UqjEbU4ttrZiYpbZM8wwsGi2A==
X-Received: by 2002:a05:6a20:1595:b0:1e1:ab63:c5e8 with SMTP id
 adf61e73a8af0-1e88d132eedmr7935210637.26.1736409012933; 
 Wed, 08 Jan 2025 23:50:12 -0800 (PST)
Received: from localhost.localdomain ([115.96.158.174])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-72aad8344desm36432128b3a.54.2025.01.08.23.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 23:50:12 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: berrange@redhat.com, armbru@redhat.com, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v4 2/2] tests/qtest/libqos: add DMA support for writing and
 reading fw_cfg files
Date: Thu,  9 Jan 2025 13:19:29 +0530
Message-ID: <20250109074929.252339-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250109074929.252339-1-anisinha@redhat.com>
References: <20250109074929.252339-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

At present, the libqos/fw_cfg.c library does not support the modern DMA
interface which is required to write to the fw_cfg files. It only uses the IO
interface. Implement read and write methods based on DMA. This will enable
developers to write tests that writes to the fw_cfg file(s). The structure of
the code is taken from edk2 fw_cfg implementation. It has been tested by
writing a qtest that writes to a fw_cfg file. This test will be part of a
future patch series.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/libqos/fw_cfg.c | 138 ++++++++++++++++++++++++++++++++++++
 tests/qtest/libqos/fw_cfg.h |   6 +-
 2 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
index f1ed4898f7..b3ae97d32d 100644
--- a/tests/qtest/libqos/fw_cfg.c
+++ b/tests/qtest/libqos/fw_cfg.c
@@ -14,6 +14,8 @@
 
 #include "qemu/osdep.h"
 #include "fw_cfg.h"
+#include "malloc-pc.h"
+#include "libqos-malloc.h"
 #include "../libqtest.h"
 #include "qemu/bswap.h"
 #include "hw/nvram/fw_cfg.h"
@@ -60,6 +62,65 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
     qtest_writew(fw_cfg->qts, fw_cfg->base, key);
 }
 
+static void
+qfw_cfg_dma_transfer(QFWCFG *fw_cfg, QOSState *qs, void *address,
+                     uint32_t length, uint32_t control)
+{
+    FWCfgDmaAccess access;
+    uint32_t addr;
+    uint64_t guest_access_addr;
+    uint64_t gaddr;
+
+    /* create a data buffer in guest memory */
+    gaddr = guest_alloc(&qs->alloc, length);
+    g_assert(gaddr);
+
+    if (control & FW_CFG_DMA_CTL_WRITE) {
+        qtest_bufwrite(fw_cfg->qts, gaddr, address, length);
+    }
+    access.address = cpu_to_be64(gaddr);
+    access.length = cpu_to_be32(length);
+    access.control = cpu_to_be32(control);
+
+    /* now create a separate buffer in guest memory for 'access' */
+    guest_access_addr = guest_alloc(&qs->alloc, sizeof(access));
+    g_assert(guest_access_addr);
+    qtest_bufwrite(fw_cfg->qts, guest_access_addr, &access, sizeof(access));
+
+    /* write lower 32 bits of address */
+    addr = cpu_to_be32((uint32_t)(uintptr_t)guest_access_addr);
+    qtest_outl(fw_cfg->qts, fw_cfg->base + 8, addr);
+
+    /* write upper 32 bits of address */
+    addr = cpu_to_be32((uint32_t)(uintptr_t)(guest_access_addr >> 32));
+    qtest_outl(fw_cfg->qts, fw_cfg->base + 4, addr);
+
+    g_assert(!(be32_to_cpu(access.control) & FW_CFG_DMA_CTL_ERROR));
+
+    if (control & FW_CFG_DMA_CTL_READ) {
+        qtest_bufread(fw_cfg->qts, gaddr, address, length);
+    }
+
+    guest_free(&qs->alloc, guest_access_addr);
+    guest_free(&qs->alloc, gaddr);
+}
+
+static void
+qfw_cfg_write_entry(QFWCFG *fw_cfg, QOSState *qs, uint16_t key,
+                    void *buf, uint32_t len)
+{
+    qfw_cfg_select(fw_cfg, key);
+    qfw_cfg_dma_transfer(fw_cfg, qs, buf, len, FW_CFG_DMA_CTL_WRITE);
+}
+
+static void
+qfw_cfg_read_entry(QFWCFG *fw_cfg, QOSState *qs, uint16_t key,
+                   void *buf, uint32_t len)
+{
+    qfw_cfg_select(fw_cfg, key);
+    qfw_cfg_dma_transfer(fw_cfg, qs, buf, len, FW_CFG_DMA_CTL_READ);
+}
+
 static bool
 find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
                 uint16_t *sel, uint32_t *size)
@@ -123,6 +184,83 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
     return filesize;
 }
 
+/*
+ * The caller need check the return value. When the return value is
+ * nonzero, it means that some bytes have been transferred.
+ *
+ * If the fw_cfg file in question is smaller than the allocated & passed-in
+ * buffer, then the first len bytes were read.
+ *
+ * If the fw_cfg file in question is larger than the passed-in
+ * buffer, then the return value explains how much was actually read.
+ *
+ * It is illegal to call this function if fw_cfg does not support DMA
+ * interface. The caller should ensure that DMA is supported before
+ * calling this function.
+ *
+ * Passed QOSState pointer qs must be initialized. qs->alloc must also be
+ * properly initialized.
+ */
+size_t qfw_cfg_read_file(QFWCFG *fw_cfg, QOSState *qs, const char *filename,
+                         void *data, size_t buflen)
+{
+    uint32_t len = 0;
+    uint16_t sel;
+    uint32_t id;
+
+    g_assert(qs);
+    /* check if DMA is supported since we use DMA for read */
+    id = qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
+    g_assert(id & FW_CFG_VERSION_DMA);
+
+    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
+        if (len > buflen) {
+            len = buflen;
+        }
+        qfw_cfg_read_entry(fw_cfg, qs, sel, data, len);
+    }
+
+    return len;
+}
+
+/*
+ * The caller need check the return value. When the return value is
+ * nonzero, it means that some bytes have been transferred.
+ *
+ * If the fw_cfg file in question is smaller than the allocated & passed-in
+ * buffer, then the buffer has been partially written.
+ *
+ * If the fw_cfg file in question is larger than the passed-in
+ * buffer, then the return value explains how much was actually written.
+ *
+ * It is illegal to call this function if fw_cfg does not support DMA
+ * interface. The caller should ensure that DMA is supported before
+ * calling this function.
+ *
+ * Passed QOSState pointer qs must be initialized. qs->alloc must also be
+ * properly initialized.
+ */
+size_t qfw_cfg_write_file(QFWCFG *fw_cfg, QOSState *qs, const char *filename,
+                          void *data, size_t buflen)
+{
+    uint32_t len = 0;
+    uint16_t sel;
+    uint32_t id;
+
+    g_assert(qs);
+    /* write operation is only valid if DMA is supported */
+    id = qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
+    g_assert(id & FW_CFG_VERSION_DMA);
+
+    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
+        if (len > buflen) {
+            len = buflen;
+        }
+        qfw_cfg_write_entry(fw_cfg, qs, sel, data, len);
+    }
+    return len;
+}
+
 static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
 {
     uint8_t *ptr = data;
diff --git a/tests/qtest/libqos/fw_cfg.h b/tests/qtest/libqos/fw_cfg.h
index b0456a15df..6d6ff09725 100644
--- a/tests/qtest/libqos/fw_cfg.h
+++ b/tests/qtest/libqos/fw_cfg.h
@@ -14,6 +14,7 @@
 #define LIBQOS_FW_CFG_H
 
 #include "../libqtest.h"
+#include "libqos.h"
 
 typedef struct QFWCFG QFWCFG;
 
@@ -33,7 +34,10 @@ uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key);
 uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
 size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
                         void *data, size_t buflen);
-
+size_t qfw_cfg_write_file(QFWCFG *fw_cfg, QOSState *qs, const char *filename,
+                          void *data, size_t buflen);
+size_t qfw_cfg_read_file(QFWCFG *fw_cfg, QOSState *qs, const char *filename,
+                         void *data, size_t buflen);
 QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
 void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
 QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);
-- 
2.45.2


