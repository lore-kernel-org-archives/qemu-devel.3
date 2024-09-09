Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9F3ECE588
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 20:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snkk8-0000tb-HO; Mon, 09 Sep 2024 16:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkk7-0000nu-2c
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkk4-00053V-JV
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725912727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gp9q23FGsWBNBV5XuIUFLE2Uwzbt24RL4MjU9ohmxj4=;
 b=Mg2FBGMPTmgTadPOXMRL1mdl8CYbELf1MTYeSjHedR4o4pYB9pLVII5MJJt12O6iHVieRT
 NjJNtkAn3z7IOH9uFlfjZ37DQTfVJ1xnhunSgyPwbTA9/Auj6QOfumyYPWa2z5h0as4lxY
 aHT2fCV1m8OosqckE/PaFQ8uVZUXYvY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-kXbs6j1sNgq2FxoFYwu8SA-1; Mon, 09 Sep 2024 16:12:06 -0400
X-MC-Unique: kXbs6j1sNgq2FxoFYwu8SA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4581253bd26so45577061cf.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 13:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725912725; x=1726517525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gp9q23FGsWBNBV5XuIUFLE2Uwzbt24RL4MjU9ohmxj4=;
 b=CvecA09r0saZQ+ANeyk6TAP+XCs0mXAe7MSHGuOIlA956IaI4Q7tGuqxNtYP2UdYAc
 Yz4Dw/MvvNAqLpcxUjeugzeLp4QtDCLR6ka/JZINFLAM2G5VOuL0himWoQzTnR2YUf7X
 juIOyoZ8uxsPJdi0vNX2RyWBuaJ4LyhW/bm7Y15maPGVdrQFy7ZkwqV/jKqixQdZqTtj
 ckHfg3oSasx04GogS8n2ybsshQd7YykiAq6iN6lRVMyH83ErrC0pIMsghoNV2l+xAtXM
 SDXZU/ur05nS9D1PmwF6FOg8lYBRgx4aP0LNIdVXw8sFxgwmUZtSJl89U+FXR0X5d+jk
 bXiw==
X-Gm-Message-State: AOJu0YwmQUXUq3AQy0VKOCt6H5lA/aRqMFOpJNlgo1DcASsv6sAaWJPq
 L8OE0rEYRUgNKnMOGQWoIU1UAuCP5PGbDUwNP1Hyt6M90PLxkGYkwmfZsbXO1XYUotFPmD0WRS4
 Amk82b/89TW7vb+saFDWdNioWaw1jzCeCZhk80hOf8K/lrsOuYNFgXsD+9TiPeokW6T6tXCuOnb
 BHArchy0aEALBlmSp5iJXaMgvzOp/9WFC6uQ==
X-Received: by 2002:ac8:7dc6:0:b0:458:3324:fff1 with SMTP id
 d75a77b69052e-458332502bcmr63956481cf.48.1725912725315; 
 Mon, 09 Sep 2024 13:12:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVrdtBovLGoHqDbqIKXvA5FQz+4LuoaZsSoQDE6npIXDr2JlwI1WIaxF3SG2JpihBeeU9UfA==
X-Received: by 2002:ac8:7dc6:0:b0:458:3324:fff1 with SMTP id
 d75a77b69052e-458332502bcmr63955771cf.48.1725912724764; 
 Mon, 09 Sep 2024 13:12:04 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822f93978sm22838561cf.83.2024.09.09.13.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 13:12:03 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Bryan Zhang <bryan.zhang@bytedance.com>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, Hao Xiang <hao.xiang@linux.dev>,
 Yichen Wang <yichen.wang@bytedance.com>
Subject: [PULL 7/9] migration: Introduce 'qatzip' compression method
Date: Mon,  9 Sep 2024 16:11:45 -0400
Message-ID: <20240909201147.3761639-8-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240909201147.3761639-1-peterx@redhat.com>
References: <20240909201147.3761639-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
Link: https://lore.kernel.org/r/20240830232722.58272-5-yichen.wang@bytedance.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json              |   3 +
 migration/multifd.h              |   5 +-
 hw/core/qdev-properties-system.c |   2 +-
 migration/multifd-qatzip.c       | 394 +++++++++++++++++++++++++++++++
 migration/meson.build            |   1 +
 5 files changed, 402 insertions(+), 3 deletions(-)
 create mode 100644 migration/multifd-qatzip.c

diff --git a/qapi/migration.json b/qapi/migration.json
index f4c27426c8..f1b7103dc8 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -561,6 +561,8 @@
 #
 # @zstd: use zstd compression method.
 #
+# @qatzip: use qatzip compression method.  (Since 9.2)
+#
 # @qpl: use qpl compression method.  Query Processing Library(qpl) is
 #     based on the deflate compression algorithm and use the Intel
 #     In-Memory Analytics Accelerator(IAA) accelerated compression and
@@ -573,6 +575,7 @@
 { 'enum': 'MultiFDCompression',
   'data': [ 'none', 'zlib',
             { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
+            { 'name': 'qatzip', 'if': 'CONFIG_QATZIP'},
             { 'name': 'qpl', 'if': 'CONFIG_QPL' },
             { 'name': 'uadk', 'if': 'CONFIG_UADK' } ] }
 
diff --git a/migration/multifd.h b/migration/multifd.h
index 3bb96e9558..50d58c0c9c 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -36,14 +36,15 @@ MultiFDRecvData *multifd_get_recv_data(void);
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
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index f13350b4fb..a56fbf728d 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -659,7 +659,7 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
 const PropertyInfo qdev_prop_multifd_compression = {
     .name = "MultiFDCompression",
     .description = "multifd_compression values, "
-                   "none/zlib/zstd/qpl/uadk",
+                   "none/zlib/zstd/qpl/uadk/qatzip",
     .enum_table = &MultiFDCompression_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
new file mode 100644
index 0000000000..3c787ed879
--- /dev/null
+++ b/migration/multifd-qatzip.c
@@ -0,0 +1,394 @@
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
+    /*
+     * Initialize QAT device with software fallback by default. This allows
+     * QATzip to use CPU path when QAT hardware reaches maximum throughput.
+     */
+    ret = qzInit(&q->sess, true);
+    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
+        err_msg = "qzInit failed";
+        goto err;
+    }
+
+    ret = qzGetDefaultsDeflate(&params);
+    if (ret != QZ_OK) {
+        err_msg = "qzGetDefaultsDeflate failed";
+        goto err;
+    }
+
+    /* Make sure to use configured QATzip compression level. */
+    params.common_params.comp_lvl = migrate_multifd_qatzip_level();
+    ret = qzSetupSessionDeflate(&q->sess, &params);
+    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
+        err_msg = "qzSetupSessionDeflate failed";
+        goto err;
+    }
+
+    if (MULTIFD_PACKET_SIZE > UINT32_MAX) {
+        err_msg = "packet size too large for QAT";
+        goto err;
+    }
+
+    q->in_len = MULTIFD_PACKET_SIZE;
+    /*
+     * PINNED_MEM is an enum from qatzip headers, which means to use
+     * kzalloc_node() to allocate memory for QAT DMA purposes. When QAT device
+     * is not available or software fallback is used, the malloc flag needs to
+     * be set as COMMON_MEM.
+     */
+    q->in_buf = qzMalloc(q->in_len, 0, PINNED_MEM);
+    if (!q->in_buf) {
+        q->in_buf = qzMalloc(q->in_len, 0, COMMON_MEM);
+        if (!q->in_buf) {
+            err_msg = "qzMalloc failed";
+            goto err;
+        }
+    }
+
+    q->out_len = qzMaxCompressedLength(MULTIFD_PACKET_SIZE, &q->sess);
+    q->out_buf = qzMalloc(q->out_len, 0, PINNED_MEM);
+    if (!q->out_buf) {
+        q->out_buf = qzMalloc(q->out_len, 0, COMMON_MEM);
+        if (!q->out_buf) {
+            err_msg = "qzMalloc failed";
+            goto err;
+        }
+    }
+
+    return 0;
+
+err:
+    error_setg(errp, "multifd %u: [sender] %s", p->id, err_msg);
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
+
+    if (q) {
+        if (q->in_buf) {
+            qzFree(q->in_buf);
+        }
+        if (q->out_buf) {
+            qzFree(q->out_buf);
+        }
+        (void)qzTeardownSession(&q->sess);
+        (void)qzClose(&q->sess);
+        g_free(q);
+    }
+
+    g_free(p->iov);
+    p->iov = NULL;
+    p->compress_data = NULL;
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
+    /*
+     * Unlike other multifd compression implementations, we use a non-streaming
+     * API and place all the data into one buffer, rather than sending each
+     * page to the compression API at a time. Based on initial benchmarks, the
+     * non-streaming API outperforms the streaming API. Plus, the logic in QEMU
+     * is friendly to using the non-streaming API anyway. If either of these
+     * statements becomes no longer true, we can revisit adding a streaming
+     * implementation.
+     */
+    for (int i = 0; i < pages->normal_num; i++) {
+        memcpy(q->in_buf + (i * p->page_size),
+               pages->block->host + pages->offset[i],
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
+    /*
+     * Initialize QAT device with software fallback by default. This allows
+     * QATzip to use CPU path when QAT hardware reaches maximum throughput.
+     */
+    ret = qzInit(&q->sess, true);
+    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
+        err_msg = "qzInit failed";
+        goto err;
+    }
+
+    ret = qzGetDefaultsDeflate(&params);
+    if (ret != QZ_OK) {
+        err_msg = "qzGetDefaultsDeflate failed";
+        goto err;
+    }
+
+    ret = qzSetupSessionDeflate(&q->sess, &params);
+    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
+        err_msg = "qzSetupSessionDeflate failed";
+        goto err;
+    }
+
+    /*
+     * Reserve extra spaces for the incoming packets. Current implementation
+     * doesn't send uncompressed pages in case the compression gets too big.
+     */
+    q->in_len = MULTIFD_PACKET_SIZE * 2;
+    /*
+     * PINNED_MEM is an enum from qatzip headers, which means to use
+     * kzalloc_node() to allocate memory for QAT DMA purposes. When QAT device
+     * is not available or software fallback is used, the malloc flag needs to
+     * be set as COMMON_MEM.
+     */
+    q->in_buf = qzMalloc(q->in_len, 0, PINNED_MEM);
+    if (!q->in_buf) {
+        q->in_buf = qzMalloc(q->in_len, 0, COMMON_MEM);
+        if (!q->in_buf) {
+            err_msg = "qzMalloc failed";
+            goto err;
+        }
+    }
+
+    q->out_len = MULTIFD_PACKET_SIZE;
+    q->out_buf = qzMalloc(q->out_len, 0, PINNED_MEM);
+    if (!q->out_buf) {
+        q->out_buf = qzMalloc(q->out_len, 0, COMMON_MEM);
+        if (!q->out_buf) {
+            err_msg = "qzMalloc failed";
+            goto err;
+        }
+    }
+
+    return 0;
+
+err:
+    error_setg(errp, "multifd %u: [receiver] %s", p->id, err_msg);
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
+    if (q) {
+        if (q->in_buf) {
+            qzFree(q->in_buf);
+        }
+        if (q->out_buf) {
+            qzFree(q->out_buf);
+        }
+        (void)qzTeardownSession(&q->sess);
+        (void)qzClose(&q->sess);
+        g_free(q);
+    }
+    p->compress_data = NULL;
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
diff --git a/migration/meson.build b/migration/meson.build
index 77f3abf08e..66d3de86f0 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -42,6 +42,7 @@ system_ss.add(when: rdma, if_true: files('rdma.c'))
 system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
 system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
 system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
+system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
                 if_true: files('ram.c',
-- 
2.45.0


