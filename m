Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C871C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 02:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRjvP-0003xz-04; Wed, 10 Jul 2024 22:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sRjvN-0003r3-1B
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 22:52:49 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sRjvI-0007sI-1T
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 22:52:48 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3c9cc66c649so224241b6e.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 19:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720666363; x=1721271163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QPSVV5we5gSNTaloIadk8enBm9gzXLNPNMXWqTWw/Qc=;
 b=FJznW3y5mUlK+hiFAcw7h01IWbnhqRD+NllAYXxLwCut3b3tcS2dLCDg9DbcFLPOjK
 lJBg4gNfL9LSjRuOG3CuMaoNy3eM0XXeWcg8AGJmTDx8/T+92U1q1b/08OcbuiyU4u7x
 21rsdUtnwQ0S8GBC274OtmDTtt4GsqHAPNjGF+F+oxT8XpTJgtK96vOMvEGUv0X2+bjw
 GlZsaQZgIDLZBRrlUx7fkIL5uIEI3ZMa5croJbPRmugh61YnChQBXD+V3cmAjk40finK
 UavUlet8jWRvId3K15+zbUYyRpEbJ8sG/r7v2UKnX0sSexyb6qyNlS4XuclPALX23/7N
 5Ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720666363; x=1721271163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QPSVV5we5gSNTaloIadk8enBm9gzXLNPNMXWqTWw/Qc=;
 b=QsEl+EeaFR7xUA6ZmaMEe72I6v74PyrbLlFvfwCjkHcBBpFNyN0yFF8hZCb8wDyp2f
 0SfFp1nKhiwyg+1Agd6qwHm/g8qjBYYiQEVIMFXdOlJCwAIQNHQykLFntThWVQ38rqvm
 fykMVHG+IFg/O8BG47+ciVtuxns/a+xFm19ooB/yWmeHnSVr1siPXQcXD3IuLX6kdRlv
 Pbg/pTstgk5d5yylj2CfCvVjFMPbFi+7c1CYLAxCn5LXuPaCtDrCRuubJnlm9iS78MPE
 2WA10zj1wnsYQeCcRFFz3Z83X2W6/zVDRuuaUxGyuqzrTyLr1KyYg8LFtmKg36Xhvfl0
 g0Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjbl5nY2DMM4AI5L90AE/wz9alXZPumGkIEkvHGZwAQKywp31VUipfEL5vDheQ3dO/HGHQYefpzatoQrSzGL2qOzh+EE8=
X-Gm-Message-State: AOJu0Yw0VNnJsBpd4bP70gVOxYb9D9Vna0LYP5h7UDjP09lueW4kKa4J
 z4jtZqhbNsiiKOsI6vUfoFRS+H50YshSY9WpMs8XkaCtgflQC6DvSszm6Ifgfe8=
X-Google-Smtp-Source: AGHT+IHHslnGO0B8QEV7q0NJIOmKYsoM0oQJe2bhh6fTHJI4oQQwGYMYptHUP/Z3VzQ8A+lrp6vVUQ==
X-Received: by 2002:a05:6808:2023:b0:3d9:263b:3a35 with SMTP id
 5614622812f47-3d93c0a9dcdmr8241627b6e.47.1720666362626; 
 Wed, 10 Jul 2024 19:52:42 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([208.184.112.130])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3daa12f4f7csm117827b6e.41.2024.07.10.19.52.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jul 2024 19:52:42 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v5 4/5] migration: Introduce 'qatzip' compression method
Date: Wed, 10 Jul 2024 19:52:28 -0700
Message-Id: <20240711025229.66260-5-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240711025229.66260-1-yichen.wang@bytedance.com>
References: <20240711025229.66260-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=yichen.wang@bytedance.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Bryan Zhang <bryan.zhang@bytedance.com>

Adds support for 'qatzip' as an option for the multifd compression
method parameter, and implements using QAT for 'qatzip' compression and
decompression.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 hw/core/qdev-properties-system.c |   6 +-
 migration/meson.build            |   1 +
 migration/multifd-qatzip.c       | 403 +++++++++++++++++++++++++++++++
 migration/multifd.h              |   5 +-
 qapi/migration.json              |   3 +
 tests/qtest/meson.build          |   4 +
 6 files changed, 419 insertions(+), 3 deletions(-)
 create mode 100644 migration/multifd-qatzip.c

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index f13350b4fb..eb50d6ec5b 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -659,7 +659,11 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
 const PropertyInfo qdev_prop_multifd_compression = {
     .name = "MultiFDCompression",
     .description = "multifd_compression values, "
-                   "none/zlib/zstd/qpl/uadk",
+                   "none/zlib/zstd/qpl/uadk"
+#ifdef CONFIG_QATZIP
+                   "/qatzip"
+#endif
+                   ,
     .enum_table = &MultiFDCompression_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
diff --git a/migration/meson.build b/migration/meson.build
index 5ce2acb41e..c9454c26ae 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -41,6 +41,7 @@ system_ss.add(when: rdma, if_true: files('rdma.c'))
 system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
 system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
 system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
+system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
                 if_true: files('ram.c',
diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
new file mode 100644
index 0000000000..d01d51de8f
--- /dev/null
+++ b/migration/multifd-qatzip.c
@@ -0,0 +1,403 @@
+/*
+ * Multifd QATzip compression implementation
+ *
+ * Copyright (c) Bytedance
+ *
+ * Authors:
+ *  Bryan Zhang <bryan.zhang@bytedance.com>
+ *  Hao Xiang <hao.xiang@bytedance.com>
+ *  Yichen Wang <yichen.wang@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "exec/ramblock.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qapi/qapi-types-migration.h"
+#include "options.h"
+#include "multifd.h"
+#include <qatzip.h>
+
+typedef struct {
+    /*
+     * Unique session for use with QATzip API
+     */
+    QzSession_T sess;
+
+    /*
+     * For compression: Buffer for pages to compress
+     * For decompression: Buffer for data to decompress
+     */
+    uint8_t *in_buf;
+    uint32_t in_len;
+
+    /*
+     * For compression: Output buffer of compressed data
+     * For decompression: Output buffer of decompressed data
+     */
+    uint8_t *out_buf;
+    uint32_t out_len;
+} QatzipData;
+
+/**
+ * qatzip_send_setup: Set up QATzip session and private buffers.
+ *
+ * @param p    Multifd channel params
+ * @param errp Pointer to error, which will be set in case of error
+ * @return     0 on success, -1 on error (and *errp will be set)
+ */
+static int qatzip_send_setup(MultiFDSendParams *p, Error **errp)
+{
+    QatzipData *q;
+    QzSessionParamsDeflate_T params;
+    const char *err_msg;
+    int ret;
+
+    q = g_new0(QatzipData, 1);
+    p->compress_data = q;
+    /* We need one extra place for the packet header */
+    p->iov = g_new0(struct iovec, 2);
+
+    /* Prefer without sw_fallback because of bad performance with sw_fallback.
+     * Warn if sw_fallback needs to be used. */
+    ret = qzInit(&q->sess, false);
+    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
+        /* Warn, and try with sw_fallback. */
+        warn_report("Initilizing QAT with sw_fallback...");
+        ret = qzInit(&q->sess, true);
+        if (ret != QZ_OK && ret != QZ_DUPLICATE) {
+            /* Warn, and try with sw_fallback. */
+            err_msg = "qzInit failed";
+            goto err_free_q;
+        }
+    }
+
+    ret = qzGetDefaultsDeflate(&params);
+    if (ret != QZ_OK) {
+        err_msg = "qzGetDefaultsDeflate failed";
+        goto err_close;
+    }
+
+    /* Make sure to use configured QATzip compression level. */
+    params.common_params.comp_lvl = migrate_multifd_qatzip_level();
+
+    ret = qzSetupSessionDeflate(&q->sess, &params);
+    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
+        err_msg = "qzSetupSessionDeflate failed";
+        goto err_close;
+    }
+
+    if (MULTIFD_PACKET_SIZE > UINT32_MAX) {
+        err_msg = "packet size too large for QAT";
+        goto err_close;
+    }
+
+    q->in_len = MULTIFD_PACKET_SIZE;
+    q->in_buf = qzMalloc(q->in_len, 0, PINNED_MEM);
+    if (!q->in_buf) {
+        err_msg = "qzMalloc failed";
+        goto err_close;
+    }
+
+    q->out_len = qzMaxCompressedLength(MULTIFD_PACKET_SIZE, &q->sess);
+    q->out_buf = qzMalloc(q->out_len, 0, PINNED_MEM);
+    if (!q->out_buf) {
+        err_msg = "qzMalloc failed";
+        goto err_free_inbuf;
+    }
+
+    return 0;
+
+err_free_inbuf:
+    qzFree(q->in_buf);
+err_close:
+    qzClose(&q->sess);
+err_free_q:
+    g_free(q);
+    g_free(p->iov);
+    p->iov = NULL;
+    p->compress_data = NULL;
+    error_setg(errp, "multifd %u: %s", p->id, err_msg);
+    return -1;
+}
+
+/**
+ * qatzip_send_cleanup: Tear down QATzip session and release private buffers.
+ *
+ * @param p    Multifd channel params
+ * @param errp Pointer to error, which will be set in case of error
+ * @return     None
+ */
+static void qatzip_send_cleanup(MultiFDSendParams *p, Error **errp)
+{
+    QatzipData *q = p->compress_data;
+    const char *err_msg;
+    int ret;
+
+    ret = qzTeardownSession(&q->sess);
+    if (ret != QZ_OK) {
+        err_msg = "qzTeardownSession failed";
+        goto err;
+    }
+
+    ret = qzClose(&q->sess);
+    if (ret != QZ_OK) {
+        err_msg = "qzClose failed";
+        goto err;
+    }
+
+    qzFree(q->in_buf);
+    q->in_buf = NULL;
+    qzFree(q->out_buf);
+    q->out_buf = NULL;
+    g_free(p->iov);
+    p->iov = NULL;
+    g_free(p->compress_data);
+    p->compress_data = NULL;
+    return;
+
+err:
+    error_setg(errp, "multifd %u: %s", p->id, err_msg);
+}
+
+/**
+ * qatzip_send_prepare: Compress pages and update IO channel info.
+ *
+ * @param p    Multifd channel params
+ * @param errp Pointer to error, which will be set in case of error
+ * @return     0 on success, -1 on error (and *errp will be set)
+ */
+static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
+{
+    MultiFDPages_t *pages = p->pages;
+    QatzipData *q = p->compress_data;
+    int ret;
+    unsigned int in_len, out_len;
+
+    if (!multifd_send_prepare_common(p)) {
+        goto out;
+    }
+
+    /* Unlike other multifd compression implementations, we use a
+     * non-streaming API and place all the data into one buffer, rather than
+     * sending each page to the compression API at a time. */
+    for (int i = 0; i < pages->normal_num; i++) {
+        memcpy(q->in_buf + (i * p->page_size),
+               p->pages->block->host + pages->offset[i],
+               p->page_size);
+    }
+
+    in_len = pages->normal_num * p->page_size;
+    if (in_len > q->in_len) {
+        error_setg(errp, "multifd %u: unexpectedly large input", p->id);
+        return -1;
+    }
+    out_len = q->out_len;
+
+    /*
+     * Unlike other multifd compression implementations, we use a non-streaming
+     * API and place all the data into one buffer, rather than sending each page
+     * to the compression API at a time. Based on initial benchmarks, the
+     * non-streaming API outperforms the streaming API. Plus, the logic in QEMU
+     * is friendly to using the non-streaming API anyway. If either of these
+     * statements becomes no longer true, we can revisit adding a streaming
+     * implementation.
+     */
+    ret = qzCompress(&q->sess, q->in_buf, &in_len, q->out_buf, &out_len, 1);
+    if (ret != QZ_OK) {
+        error_setg(errp, "multifd %u: QATzip returned %d instead of QZ_OK",
+                   p->id, ret);
+        return -1;
+    }
+    if (in_len != pages->normal_num * p->page_size) {
+        error_setg(errp, "multifd %u: QATzip failed to compress all input",
+                   p->id);
+        return -1;
+    }
+
+    p->iov[p->iovs_num].iov_base = q->out_buf;
+    p->iov[p->iovs_num].iov_len = out_len;
+    p->iovs_num++;
+    p->next_packet_size = out_len;
+
+out:
+    p->flags |= MULTIFD_FLAG_QATZIP;
+    multifd_send_fill_packet(p);
+    return 0;
+}
+
+/**
+ * qatzip_recv_setup: Set up QATzip session and allocate private buffers.
+ *
+ * @param p    Multifd channel params
+ * @param errp Pointer to error, which will be set in case of error
+ * @return     0 on success, -1 on error (and *errp will be set)
+ */
+static int qatzip_recv_setup(MultiFDRecvParams *p, Error **errp)
+{
+    QatzipData *q;
+    QzSessionParamsDeflate_T params;
+    const char *err_msg;
+    int ret;
+
+    q = g_new0(QatzipData, 1);
+    p->compress_data = q;
+
+    /* Prefer without sw_fallback because of bad performance with sw_fallback.
+     * Warn if sw_fallback needs to be used. */
+    ret = qzInit(&q->sess, false);
+    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
+        /* Warn, and try with sw_fallback. */
+        warn_report("Initilizing QAT with sw_fallback...");
+        ret = qzInit(&q->sess, true);
+        if (ret != QZ_OK && ret != QZ_DUPLICATE) {
+            /* Warn, and try with sw_fallback. */
+            err_msg = "qzInit failed";
+            goto err_free_q;
+        }
+    }
+
+    ret = qzGetDefaultsDeflate(&params);
+    if (ret != QZ_OK) {
+        err_msg = "qzGetDefaultsDeflate failed";
+        goto err_close;
+    }
+
+    ret = qzSetupSessionDeflate(&q->sess, &params);
+    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
+        err_msg = "qzSetupSessionDeflate failed";
+        goto err_close;
+    }
+
+    /*
+     * Mimic multifd-zlib, which reserves extra space for the
+     * incoming packet.
+     */
+    q->in_len = MULTIFD_PACKET_SIZE * 2;
+    /* PINNED_MEM is an enum from qatzip headers, which means to use
+     * kzalloc_node() to allocate memory for QAT DMA purposes. */
+    q->in_buf = qzMalloc(q->in_len, 0, PINNED_MEM);
+    if (!q->in_buf) {
+        err_msg = "qzMalloc failed";
+        goto err_close;
+    }
+
+    q->out_len = MULTIFD_PACKET_SIZE;
+    q->out_buf = qzMalloc(q->out_len, 0, PINNED_MEM);
+    if (!q->out_buf) {
+        err_msg = "qzMalloc failed";
+        goto err_free_inbuf;
+    }
+
+    return 0;
+
+err_free_inbuf:
+    qzFree(q->in_buf);
+err_close:
+    qzClose(&q->sess);
+err_free_q:
+    g_free(q);
+    p->compress_data = NULL;
+    error_setg(errp, "multifd %u: %s", p->id, err_msg);
+    return -1;
+}
+
+/**
+ * qatzip_recv_cleanup: Tear down QATzip session and release private buffers.
+ *
+ * @param p    Multifd channel params
+ * @return     None
+ */
+static void qatzip_recv_cleanup(MultiFDRecvParams *p)
+{
+    QatzipData *q = p->compress_data;
+
+    /* Ignoring return values here due to function signature. */
+    qzTeardownSession(&q->sess);
+    qzClose(&q->sess);
+    qzFree(q->in_buf);
+    qzFree(q->out_buf);
+    g_free(p->compress_data);
+}
+
+
+/**
+ * qatzip_recv: Decompress pages and copy them to the appropriate
+ * locations.
+ *
+ * @param p    Multifd channel params
+ * @param errp Pointer to error, which will be set in case of error
+ * @return     0 on success, -1 on error (and *errp will be set)
+ */
+static int qatzip_recv(MultiFDRecvParams *p, Error **errp)
+{
+    QatzipData *q = p->compress_data;
+    int ret;
+    unsigned int in_len, out_len;
+    uint32_t in_size = p->next_packet_size;
+    uint32_t expected_size = p->normal_num * p->page_size;
+    uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
+
+    if (in_size > q->in_len) {
+        error_setg(errp, "multifd %u: received unexpectedly large packet",
+                   p->id);
+        return -1;
+    }
+
+    if (flags != MULTIFD_FLAG_QATZIP) {
+        error_setg(errp, "multifd %u: flags received %x flags expected %x",
+                   p->id, flags, MULTIFD_FLAG_QATZIP);
+        return -1;
+    }
+
+    multifd_recv_zero_page_process(p);
+    if (!p->normal_num) {
+        assert(in_size == 0);
+        return 0;
+    }
+
+    ret = qio_channel_read_all(p->c, (void *)q->in_buf, in_size, errp);
+    if (ret != 0) {
+        return ret;
+    }
+
+    in_len = in_size;
+    out_len = q->out_len;
+    ret = qzDecompress(&q->sess, q->in_buf, &in_len, q->out_buf, &out_len);
+    if (ret != QZ_OK) {
+        error_setg(errp, "multifd %u: qzDecompress failed", p->id);
+        return -1;
+    }
+    if (out_len != expected_size) {
+        error_setg(errp, "multifd %u: packet size received %u size expected %u",
+                   p->id, out_len, expected_size);
+        return -1;
+    }
+
+    /* Copy each page to its appropriate location. */
+    for (int i = 0; i < p->normal_num; i++) {
+        memcpy(p->host + p->normal[i],
+               q->out_buf + p->page_size * i,
+               p->page_size);
+    }
+    return 0;
+}
+
+static MultiFDMethods multifd_qatzip_ops = {
+    .send_setup = qatzip_send_setup,
+    .send_cleanup = qatzip_send_cleanup,
+    .send_prepare = qatzip_send_prepare,
+    .recv_setup = qatzip_recv_setup,
+    .recv_cleanup = qatzip_recv_cleanup,
+    .recv = qatzip_recv
+};
+
+static void multifd_qatzip_register(void)
+{
+    multifd_register_ops(MULTIFD_COMPRESSION_QATZIP, &multifd_qatzip_ops);
+}
+
+migration_init(multifd_qatzip_register);
diff --git a/migration/multifd.h b/migration/multifd.h
index 0ecd6f47d7..adceb65050 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -34,14 +34,15 @@ MultiFDRecvData *multifd_get_recv_data(void);
 /* Multifd Compression flags */
 #define MULTIFD_FLAG_SYNC (1 << 0)
 
-/* We reserve 4 bits for compression methods */
-#define MULTIFD_FLAG_COMPRESSION_MASK (0xf << 1)
+/* We reserve 5 bits for compression methods */
+#define MULTIFD_FLAG_COMPRESSION_MASK (0x1f << 1)
 /* we need to be compatible. Before compression value was 0 */
 #define MULTIFD_FLAG_NOCOMP (0 << 1)
 #define MULTIFD_FLAG_ZLIB (1 << 1)
 #define MULTIFD_FLAG_ZSTD (2 << 1)
 #define MULTIFD_FLAG_QPL (4 << 1)
 #define MULTIFD_FLAG_UADK (8 << 1)
+#define MULTIFD_FLAG_QATZIP (16 << 1)
 
 /* This value needs to be a multiple of qemu_target_page_size() */
 #define MULTIFD_PACKET_SIZE (512 * 1024)
diff --git a/qapi/migration.json b/qapi/migration.json
index cd08f2f710..42b5363449 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -558,6 +558,8 @@
 #
 # @zstd: use zstd compression method.
 #
+# @qatzip: use qatzip compression method. (Since 9.1)
+#
 # @qpl: use qpl compression method.  Query Processing Library(qpl) is
 #       based on the deflate compression algorithm and use the Intel
 #       In-Memory Analytics Accelerator(IAA) accelerated compression
@@ -570,6 +572,7 @@
 { 'enum': 'MultiFDCompression',
   'data': [ 'none', 'zlib',
             { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
+            { 'name': 'qatzip', 'if': 'CONFIG_QATZIP'},
             { 'name': 'qpl', 'if': 'CONFIG_QPL' },
             { 'name': 'uadk', 'if': 'CONFIG_UADK' } ] }
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6508bfb1a2..3068d73e08 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -327,6 +327,10 @@ if gnutls.found()
   endif
 endif
 
+if qatzip.found()
+  migration_files += [qatzip]
+endif
+
 qtests = {
   'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
   'cdrom-test': files('boot-sector.c'),
-- 
Yichen Wang


