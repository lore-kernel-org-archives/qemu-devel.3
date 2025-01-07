Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D65BE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 14:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVAy7-0004LJ-4E; Tue, 07 Jan 2025 09:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tVAxt-0004Ei-TC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 09:53:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tVAxq-0007uP-1I
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 09:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736261629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VjK5zWV5Vf1QC5xjU+BYC9vn2BoraPpfRJiivkBViDQ=;
 b=bokAhlCrZTbfTjYeMWhQq0fSW3flAZGSqu6ch7CAQOKz8fn5uwNv6EMQg/WQeK+rww6ykM
 4sK9HeVYPEdC5tJxASq9ypOMivjEMaOKl1pXRmhBWe+TPUFA2Ha8E2j1m0/C+Jip6xjXnp
 tAiV0+uuoHcWzpSY/asJfOO3cP3kCrM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-Zc_gQExMNxukxpuuINSkjg-1; Tue, 07 Jan 2025 09:53:47 -0500
X-MC-Unique: Zc_gQExMNxukxpuuINSkjg-1
X-Mimecast-MFC-AGG-ID: Zc_gQExMNxukxpuuINSkjg
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef6ef9ba3fso23220120a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 06:53:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736261626; x=1736866426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VjK5zWV5Vf1QC5xjU+BYC9vn2BoraPpfRJiivkBViDQ=;
 b=MQ4+0EKKwy3u02KusB3BL0aENfhMWD6ZOXMZEjRutxGdXhBvM/QLW6ZkyM2N0CeI3a
 Q0seSkvSqKB1rkJQ3NVIjvujcAnzPjvdWyvLXLosFokAH9s8PsoDfbk2+qdrwIsWjnAy
 d1/HFJkXUTq95oOIC9kvZP1ik4tfdHVyZM2qepxVppGy/Ar6mjpn4B+iUbZ7xotUgZVb
 05661ptcpkJhvRlczwhN2W1TILUWPED4GeR9YqAI2xRkgRadQvYZxGypzAJ6NatWZBT0
 qLgUcLxnzm2Q0TMLCBflenLbbSKkHH0ZPGP2jFZclYVv64vMA/jZcnvsnae5W10Q8e4m
 6veg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLxyNmfk8E//aq+7iYDC/go65PLKANxQzAFyCfwn/a8C2WT7Hnl0zAwNPr0KtZ2Y7BJhjzyeQQI9Bz@nongnu.org
X-Gm-Message-State: AOJu0YzpHE3GTNrIwfaNX801jFnif8UUU20mbuEVbZkao3lpseLKUGWH
 e5dklGiLnCQ58H1vnE9ida3dq+w7ZN40Fi3gFpav/A1FYpFBu0+ypeMYIRZj4lG8ZrFdGcwuxCN
 odpdoy3L25j+SFRXOA5Z0EdZxSL30m+JoZv1ClYLNHt/55YUcX8OK
X-Gm-Gg: ASbGncvVfDkGTA/o/BpQQepVTavG1+bG/LZO5TBa2q/ywCB2Ox9sE5g2wQ1UUIICdZt
 QtDTe9U9FsXCw6g0Wuv+rDcRgmh6XtdVv9lRIgqYF7C649PK4Jt3iFwKUrgxVK6daCMWgoDzu1e
 NqdlZuKSj9OE+/NNzSA7ijlPld47sWR4FTVA7pMaX6D7+3RXtTKBBkZO9ir7GA2Q/c5PxqnFJbE
 Zn2V6bUPExgu9s1yvW1ZS6fjWhExmh8y5IuOwxDI5+VY1P1hgOE/rUIS4NLjmoulqCQnGORNBVK
 /NA1
X-Received: by 2002:a05:6a00:4096:b0:729:c7b:9385 with SMTP id
 d2e1a72fcca58-72abdd7bdecmr92284477b3a.6.1736261625929; 
 Tue, 07 Jan 2025 06:53:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg2NLLzfnl4TIQOzBUGb1TED+iPyUU4Xr5iJREkveMcCZyhg2iy9WV3fKI/g0PcPn3zzHKCA==
X-Received: by 2002:a05:6a00:4096:b0:729:c7b:9385 with SMTP id
 d2e1a72fcca58-72abdd7bdecmr92284438b3a.6.1736261625542; 
 Tue, 07 Jan 2025 06:53:45 -0800 (PST)
Received: from localhost.localdomain ([115.96.125.221])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-72d012b1de0sm4108546b3a.80.2025.01.07.06.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 06:53:44 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: armbru@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v2] tests/qtest/libqos: add DMA support for writing and
 reading fw_cfg files
Date: Tue,  7 Jan 2025 20:21:37 +0530
Message-ID: <20250107145138.157696-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
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
 tests/qtest/libqos/fw_cfg.c | 191 +++++++++++++++++++++++++++++++-----
 tests/qtest/libqos/fw_cfg.h |   4 +
 2 files changed, 172 insertions(+), 23 deletions(-)

changelog:
v2: refactor common code into a helper.

diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
index 89f053ccac..ac4c6b73e5 100644
--- a/tests/qtest/libqos/fw_cfg.c
+++ b/tests/qtest/libqos/fw_cfg.c
@@ -17,6 +17,8 @@
 #include "../libqtest.h"
 #include "qemu/bswap.h"
 #include "hw/nvram/fw_cfg.h"
+#include "malloc-pc.h"
+#include "libqos-malloc.h"
 
 void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
 {
@@ -60,6 +62,94 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
     qtest_writew(fw_cfg->qts, fw_cfg->base, key);
 }
 
+static void
+qfw_cfg_dma_transfer(QFWCFG *fw_cfg, void *address, uint32_t length,
+                     uint32_t control)
+{
+    FWCfgDmaAccess access;
+    uint32_t addr;
+    QGuestAllocator guest_malloc;
+    uint64_t guest_access_addr;
+    uint64_t gaddr;
+
+    pc_alloc_init(&guest_malloc, fw_cfg->qts, ALLOC_NO_FLAGS);
+
+    /* create a data buffer in guest memory */
+    gaddr = guest_alloc(&guest_malloc, length);
+    g_assert(gaddr);
+    qtest_bufwrite(fw_cfg->qts, gaddr, address, length);
+
+    access.address = cpu_to_be64(gaddr);
+    access.length = cpu_to_be32(length);
+    access.control = cpu_to_be32(control);
+
+    /* now create a separate buffer in guest memory for 'access' */
+    guest_access_addr = guest_alloc(&guest_malloc, sizeof(access));
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
+    guest_free(&guest_malloc, guest_access_addr);
+    guest_free(&guest_malloc, gaddr);
+    alloc_destroy(&guest_malloc);
+}
+
+static void
+qfw_cfg_write_entry(QFWCFG *fw_cfg, uint16_t key, void *buf, uint32_t len)
+{
+    qfw_cfg_select(fw_cfg, key);
+    qfw_cfg_dma_transfer(fw_cfg, buf, len, FW_CFG_DMA_CTL_WRITE);
+}
+
+static void
+qfw_cfg_read_entry(QFWCFG *fw_cfg, uint16_t key, void *buf, uint32_t len)
+{
+    qfw_cfg_select(fw_cfg, key);
+    qfw_cfg_dma_transfer(fw_cfg, buf, len, FW_CFG_DMA_CTL_READ);
+}
+
+static bool find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
+                            uint16_t *sel, uint32_t *size)
+{
+    unsigned char *filesbuf = NULL;
+    uint32_t count;
+    size_t dsize;
+    FWCfgFile *pdir_entry;
+    uint32_t i;
+    bool found = false;
+
+    *size = 0;
+    *sel = 0;
+
+    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
+    count = be32_to_cpu(count);
+    dsize = sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
+    filesbuf = g_malloc(dsize);
+    g_assert(filesbuf);
+    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
+    pdir_entry = (FWCfgFile *)(filesbuf + sizeof(uint32_t));
+    for (i = 0; i < count; ++i, ++pdir_entry) {
+        if (!strcmp(pdir_entry->name, filename)) {
+            *size = be32_to_cpu(pdir_entry->size);
+            *sel = be16_to_cpu(pdir_entry->select);
+            found = true;
+            break;
+        }
+    }
+
+    g_free(filesbuf);
+    return found;
+}
+
 /*
  * The caller need check the return value. When the return value is
  * nonzero, it means that some bytes have been transferred.
@@ -73,37 +163,92 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
  * populated, it has received only a starting slice of the fw_cfg file.
  */
 size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
-                      void *data, size_t buflen)
+                        void *data, size_t buflen)
 {
-    uint32_t count;
-    uint32_t i;
-    unsigned char *filesbuf = NULL;
-    size_t dsize;
-    FWCfgFile *pdir_entry;
     size_t filesize = 0;
+    uint32_t len;
+    uint16_t sel;
 
-    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
-    count = be32_to_cpu(count);
-    dsize = sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
-    filesbuf = g_malloc(dsize);
-    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
-    pdir_entry = (FWCfgFile *)(filesbuf + sizeof(uint32_t));
-    for (i = 0; i < count; ++i, ++pdir_entry) {
-        if (!strcmp(pdir_entry->name, filename)) {
-            uint32_t len = be32_to_cpu(pdir_entry->size);
-            uint16_t sel = be16_to_cpu(pdir_entry->select);
-            filesize = len;
-            if (len > buflen) {
-                len = buflen;
-            }
-            qfw_cfg_get(fw_cfg, sel, data, len);
-            break;
+    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
+        filesize = len;
+        if (len > buflen) {
+            len = buflen;
         }
+        qfw_cfg_get(fw_cfg, sel, data, len);
     }
-    g_free(filesbuf);
+
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
+ */
+size_t qfw_cfg_read_file(QFWCFG *fw_cfg, const char *filename,
+                         void *data, size_t buflen)
+{
+    uint32_t len = 0;
+    uint16_t sel;
+    uint32_t id;
+
+    /* check if DMA is supported since we use DMA for read */
+    id = qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
+    g_assert(id & FW_CFG_VERSION_DMA);
+
+    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
+        if (len > buflen) {
+            len = buflen;
+        }
+        qfw_cfg_read_entry(fw_cfg, sel, data, len);
+    }
+
+    return (size_t) len;
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
+ */
+size_t qfw_cfg_write_file(QFWCFG *fw_cfg, const char *filename,
+                          void *data, size_t buflen)
+{
+    uint32_t len = 0;
+    uint16_t sel;
+    uint32_t id;
+
+    /* write operation is only valid if DMA is supported */
+    id = qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
+    g_assert(id & FW_CFG_VERSION_DMA);
+
+    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
+        if (len > buflen) {
+            len = buflen;
+        }
+        qfw_cfg_write_entry(fw_cfg, sel, data, len);
+    }
+    return (size_t) len;
+}
+
 static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
 {
     uint8_t *ptr = data;
diff --git a/tests/qtest/libqos/fw_cfg.h b/tests/qtest/libqos/fw_cfg.h
index b0456a15df..62221a9500 100644
--- a/tests/qtest/libqos/fw_cfg.h
+++ b/tests/qtest/libqos/fw_cfg.h
@@ -33,6 +33,10 @@ uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key);
 uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
 size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
                         void *data, size_t buflen);
+size_t qfw_cfg_write_file(QFWCFG *fw_cfg, const char *filename,
+                          void *data, size_t buflen);
+size_t qfw_cfg_read_file(QFWCFG *fw_cfg, const char *filename,
+                         void *data, size_t buflen);
 
 QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
 void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
-- 
2.45.2


