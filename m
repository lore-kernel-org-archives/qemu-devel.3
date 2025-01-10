Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1264E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWCXw-0002V2-8Q; Fri, 10 Jan 2025 05:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tWCXV-000298-CH
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:46:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tWCXT-0000wa-HP
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736506010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZMMh3Ct3D59i/vZcmkBqIRDug6lODH51ZMZv/tlh6U=;
 b=ZIE5k+ncpJUdHHgKcF0EQm7vPNBFtxmtTzMnRwV9Ijtmkt4CTssLPab3KiKWKtAXdyru1B
 +WiZ2hAwJr1ktfaWV0LoCQ68rvx9ZlD1TknRrDaqvDmskarpxwg8HdukiSnWCDUtBDHbnB
 /uy7i3CAh/gAlxoEbV4B8lvUjy5oQK4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-LvuEjwU1OVGwUF9HwqMqRQ-1; Fri, 10 Jan 2025 05:46:47 -0500
X-MC-Unique: LvuEjwU1OVGwUF9HwqMqRQ-1
X-Mimecast-MFC-AGG-ID: LvuEjwU1OVGwUF9HwqMqRQ
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-216750b679eso26279115ad.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 02:46:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736506006; x=1737110806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GZMMh3Ct3D59i/vZcmkBqIRDug6lODH51ZMZv/tlh6U=;
 b=JHUprbwTmmmxhpm1anfQWDhZKyckbqjlbHFzaAN+xthLYSn1KXU9xd86gtZ+6a79/8
 j2pc4d7Ko/Vg+n54Y/yeBObJXXNZdOstY0mqhonSS6FpmGh7Dznfv6qtbaRsJh+ZQKT5
 FQ/cSZZlW7fceGtKvy7evNeshb/hNpWT9Mg/JiuJNQIbBe5afyNWAlCcmkXmOBNQrndA
 l/Dp/XC4hJi2WE+mSwWytG/u6e2cgKIrwyF5Kvyy4Ktscav/Twk06jRdgeTdRt3PRX/V
 nScsDk20yMY4JM+n7k3OL3ws2Vd/nZoG12wYgFfZ054eUs6h5MnYiPJMdxAJDU/cIMnI
 7LmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl8iQB/ZstzAIGZQI1VT6tU2XPHqHkgDYDiH70zQ/cowuD8l5e76MpVKzspzmgIVtv1SuG8exqk+YE@nongnu.org
X-Gm-Message-State: AOJu0Yw7KCJQRZL68jne0vwfujFKS4SXy9NtMFwJNTeo3Xvzm4kvGkMP
 xaaOVqedZRKG/rZbdhE6nv7/umYaX7T97j3Q1PQj4Z9BKX3oI5quw0i7ktuEM9RZ3QQMr/hl/wm
 FNAOosH55+BT3Snv/y/NL/J0RbgXdHUbvsj9NeTK4HSIJ96+7r049
X-Gm-Gg: ASbGnct2/FFCAqMMH2DssA06r+EXrxuRYWV4oxS9HJ3Zq5HobukxRL2zPUXzY/k+73Y
 Lxp4Fnznacj+9633ttsBrLC14h4SuYt4huwb9AiwZsTGv0cHmVigptypqj40do+w+NOEgE9/meo
 PJMBHdNyR+iBJRR2LY2DOZyK4JAkhUsk4/UqY2rg3K/rNLQJgFiq/WJt6/Www8FDNj5ahNUrLXx
 eBisQX8JeIRrcGBZNSxlCKjAsopF47uFEzxNEFDu8dy+BLRZHrgIzKgG1XGBGFZEzxrlLq2sDD9
 +cA=
X-Received: by 2002:a17:902:d4c4:b0:215:5ea2:6543 with SMTP id
 d9443c01a7336-21a83f6400cmr161720695ad.28.1736506005608; 
 Fri, 10 Jan 2025 02:46:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlMtGtmFqVLCLlCNDtxuvluWrUbeDJHdsWl3c7mXOV2ZkVnwMt8IP7SF8F0QG5FwaGUaKRNg==
X-Received: by 2002:a17:902:d4c4:b0:215:5ea2:6543 with SMTP id
 d9443c01a7336-21a83f6400cmr161720375ad.28.1736506005203; 
 Fri, 10 Jan 2025 02:46:45 -0800 (PST)
Received: from localhost.localdomain ([115.96.31.209])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-21a9f10ddbesm11722255ad.2.2025.01.10.02.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 02:46:44 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: armbru@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 2/3] tests/qtest/libqos: add DMA support for writing and
 reading fw_cfg files
Date: Fri, 10 Jan 2025 16:16:17 +0530
Message-ID: <20250110104619.267564-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250110104619.267564-1-anisinha@redhat.com>
References: <20250110104619.267564-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
 tests/qtest/libqos/fw_cfg.c | 142 ++++++++++++++++++++++++++++++++++++
 tests/qtest/libqos/fw_cfg.h |   6 +-
 2 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
index b178d0b1b8..7c86f0fecf 100644
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
@@ -60,6 +62,63 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
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
@@ -122,6 +181,89 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
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
+    g_assert(filename);
+    g_assert(data);
+    g_assert(buflen);
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
+    g_assert(filename);
+    g_assert(data);
+    g_assert(buflen);
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


