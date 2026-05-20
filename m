Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA69CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 08:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPbrC-0003sh-En; Wed, 20 May 2026 04:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wPbqj-0003f5-5A
 for qemu-devel@nongnu.org; Wed, 20 May 2026 04:00:30 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wPbqY-0004AM-TL
 for qemu-devel@nongnu.org; Wed, 20 May 2026 04:00:10 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c827313dac0so2444266a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 01:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779264000; x=1779868800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q171zmzoZtyUjP/bzaCh8JzygW2pCZmah2r5hRqpdIM=;
 b=F21tMMub6vD6bXeNGlt026U57nBi6bjHE6tddh4z+T4GQGMIDvFw33EoOBdbWtUsJ3
 EOomwtX29yFYlUstD6WSgqLUjY4JrncYr290HruUqHK6JJkZyN7dM7fwnyVaDNrY0e9V
 J3tCsLRaj3SHu0oJbgBtN0p0FeAYTXRHOpLBrmXrFG3YRHvKRQIt2qVpQQ3no4SsAkZn
 3w9MO4EDCLySd4909LEgvItIQvq3t69TY5fzqBdeDD5zEiQHCptesRyz/GxL9/fGBKJk
 60oRFqRRIhlDwFFQiJE5MvrmEWdsujMn7WyXy9tLsZ/AdR1ZtyKWpL97LmcJa4H5NH9e
 xN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779264000; x=1779868800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q171zmzoZtyUjP/bzaCh8JzygW2pCZmah2r5hRqpdIM=;
 b=sSbm34xpJltLwCWzOSwxf2zNSRPGf1fL3voQIGYPla8P8ZNocPFd0jgbIQGiPljE7Q
 Oq0s9HjqNR7BH7BJfAOWe3lCbO2FCV0TRQqMNDICgVVHtoSRqSL0pu7zr0TWJ0IFQIQo
 2vyHb47ZyxZc7O5/LbcsXyCZrnaTfXtAIj2SBSZDxGeai66B3FmMMI3CkXmensAqTm1a
 Z62tXSBuUPupeHmFKqQnYmKiOVt2K9PDhSgowQwWNW2TDIikaMdkTBCjMmi+XXXg0ova
 iQwXxzfEGqdZSz5QvJIv748+cERT73P6gERbJHzUubTrS3lqt3cjyBaFvYcn8SZi39hZ
 R87g==
X-Gm-Message-State: AOJu0Yx6M80+lmBoRInx4iqXmTeVNmpqzDQo1sZW6+ziq9ewVe91MzLp
 Z7Y7PY/eJOGr8tH7rovGEq5MkyimkENMSZq/dudEj+NJnHBD6PaMXK6NkOez4Q==
X-Gm-Gg: Acq92OGg/rKDt+MOWBgyZPgYkGmq/qhNziEu66BdJ7M8mZ9lT5DJ2NtA1IrD5wQg6Ar
 yFyEHy2ObgBfXTY+tTMHcLIamvx4kwY2omnpfg7M5y/QH3gzLvIm5A1DYU+MXlnuIf3mQ8E/XQ9
 EwLXhy8RNUfI44xsFdFE0p93s7pWsnT8tUkR3ryhb56mwXNv1xiljHJ5iGXUrxbXuzofqDCJdBg
 5ua96awhd8eixHNSN4V4hncgaz+ADNGY+MuAzuBJ1z2wPuhiRggdpA8HYsy3WsscQnSAAUEYFyc
 nEYYDvmESnTeZvnJ6f/p6RGnPR08Zq5KhwW9A8Fe90V3XWOyppSpptJbjeFNaGXYAsvSfDLEQSw
 94ii6CMPitMzyn+mTeppqevNfkuLoyOInzxq2RGjTmTLLZuchGslDNT9qxWEqzeGIgtA4lGz4oc
 X67PUygRMgg9PoUkZOrwi6oChK+MBF
X-Received: by 2002:a17:902:d509:b0:2b4:5bf8:a7e1 with SMTP id
 d9443c01a7336-2bd7e8288acmr207100325ad.6.1779263999848; 
 Wed, 20 May 2026 00:59:59 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c05ffbesm216608435ad.27.2026.05.20.00.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 00:59:59 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, jaemyung.lee@samsung.com,
 Jaemyung Lee <ldc.jml@gmail.com>
Subject: [PULL 5/5] tests/qtest: Add UFS Write Booster QTest
Date: Wed, 20 May 2026 16:59:31 +0900
Message-ID: <f50738e34f5bf8d907cfdb8195fedc780341b99a.1779263628.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779263628.git.jeuk20.kim@samsung.com>
References: <cover.1779263628.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Jaemyung Lee <ldc.jml@gmail.com>

It adds 'wb-init' and 'wb-read-write' TCs into tests/qtest/ufs-test.c.
'wb-init' tests that the WB support is properly initialized with UFS
device and 'wb-read-write' tests that WB can be enabled and WRITE I/O
can be handled/buffered as a WB command.

Signed-off-by: Jaemyung Lee <jaemyung.lee@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 tests/qtest/ufs-test.c | 177 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 7f99944155..f677896db0 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -1182,6 +1182,175 @@ static void ufstest_query_desc_request(void *obj, void *data,
     ufs_exit(ufs, alloc);
 }
 
+static void ufstest_wb_init(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    enum UtpOcsCodes ocs;
+    UtpUpiuRsp rsp_upiu;
+    uint8_t *desc;
+    uint32_t value;
+
+    ufs_init(ufs, alloc);
+
+    /* Read Device Descriptor */
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_DEVICE, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.opcode, ==, UFS_UPIU_QUERY_OPCODE_READ_DESC);
+    g_assert_cmpuint(rsp_upiu.qr.idn, ==, UFS_QUERY_DESC_IDN_DEVICE);
+    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(DeviceDescriptor));
+    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_DEVICE);
+
+    /* Check Write Booster Supportability */
+    desc = rsp_upiu.qr.data;
+
+    value = lduw_be_p(desc + UFS_DEVICE_DESC_PARAM_EXT_WB_SUP);
+    g_assert_cmpuint(value, ==, WB_RESIZE | WB_FIFO | WB_PINNED);
+
+    value = ldl_be_p(desc + UFS_DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
+    g_assert_cmpuint(value & UFS_DEV_WB_SUPPORT, ==, UFS_DEV_WB_SUPPORT);
+
+    /* Read Geometry Descriptor */
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_GEOMETRY, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(GeometryDescriptor));
+    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_GEOMETRY);
+
+    /* Check Write Booster Configuration */
+    desc = rsp_upiu.qr.data;
+
+    value = ldl_be_p(desc + UFS_GEOMETRY_DESC_PARAM_WB_MAX_ALLOC_UNITS);
+    g_assert_cmpuint(value, ==, 1024);
+
+    value = desc[UFS_GEOMETRY_DESC_PARAM_WB_MAX_WB_LUNS];
+    g_assert_cmpuint(value, ==, 1);
+
+    value = desc[UFS_GEOMETRY_DESC_PARAM_WB_BUFF_CAP_ADJ];
+    g_assert_cmpuint(value, ==, 3);
+
+    value = desc[UFS_GEOMETRY_DESC_PARAM_WB_SUP_RED_TYPE];
+    g_assert_cmpuint(value, ==, 1);
+
+    value = desc[UFS_GEOMETRY_DESC_PARAM_WB_SUP_WB_TYPE];
+    g_assert_cmpuint(value, ==, 1);
+
+    ufs_exit(ufs, alloc);
+}
+
+static void ufstest_wb_read_write(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    uint8_t read_buf[4096] = { 0 };
+    uint8_t write_buf[4096] = { 0 };
+    const uint8_t read_capacity_cdb[UFS_CDB_SIZE] = {
+        /* allocation length 4096 */
+        SERVICE_ACTION_IN_16,
+        SAI_READ_CAPACITY_16,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x10,
+        0x00,
+        0x00,
+        0x00
+    };
+    const uint8_t request_sense_cdb[UFS_CDB_SIZE] = {
+        REQUEST_SENSE,
+    };
+    const uint8_t write_cdb[UFS_CDB_SIZE] = {
+        /* WRITE(10) to LBA 0, transfer length 1 */
+        WRITE_10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
+    };
+    uint32_t block_size;
+    enum UtpOcsCodes ocs;
+    UtpUpiuRsp rsp_upiu;
+    const int test_lun = 1;
+    uint64_t end_time;
+
+    ufs_init(ufs, alloc);
+
+    /* Clear Unit Attention */
+    ocs = ufs_send_scsi_command(ufs, test_lun, request_sense_cdb, NULL, 0,
+                                read_buf, sizeof(read_buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+
+    /* Read capacity */
+    ocs = ufs_send_scsi_command(ufs, test_lun, read_capacity_cdb, NULL, 0,
+                                read_buf, sizeof(read_buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==,
+                     UFS_COMMAND_RESULT_SUCCESS);
+    block_size = ldl_be_p(&read_buf[8]);
+    g_assert_cmpuint(block_size, ==, 4096);
+
+    /* Check available buffer size */
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                         UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE, 0, 0, 0,
+                         &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.opcode, ==, UFS_UPIU_QUERY_OPCODE_READ_ATTR);
+    g_assert_cmpuint(rsp_upiu.qr.idn, ==,
+                     UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0xA));
+
+    /* Enable WB */
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_SET_FLAG,
+                         UFS_QUERY_FLAG_IDN_WB_EN, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(1));
+
+    /* Write data */
+    for (int i = 0; i < 256; i++) {
+        memset(write_buf, 0xab, block_size);
+        ocs = ufs_send_scsi_command(ufs, test_lun, write_cdb, write_buf,
+                                    block_size, NULL, 0, &rsp_upiu);
+        g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+        g_assert_cmpuint(rsp_upiu.header.scsi_status, ==,
+                         UFS_COMMAND_RESULT_SUCCESS);
+    }
+
+    end_time = g_get_monotonic_time() + TIMEOUT_SECONDS * G_TIME_SPAN_SECOND;
+    do {
+        qtest_clock_step(ufs->dev.bus->qts, 100);
+
+        /* Check available buffer size */
+        ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                             UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                             UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE, 0, 0, 0,
+                             &rsp_upiu);
+        g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+        g_assert_cmpuint(rsp_upiu.header.response, ==,
+                         UFS_COMMAND_RESULT_SUCCESS);
+        g_assert_cmpuint(rsp_upiu.qr.opcode, ==,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR);
+        g_assert_cmpuint(rsp_upiu.qr.idn, ==,
+                         UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE);
+    } while (rsp_upiu.qr.value == cpu_to_be32(0xA) &&
+             g_get_monotonic_time() < end_time);
+
+    /* Check available buffer size */
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x9));
+
+    ufs_exit(ufs, alloc);
+}
+
 static void drive_destroy(void *path)
 {
     unlink(path);
@@ -1234,6 +1403,12 @@ static void ufs_register_nodes(void)
                                           .edge.extra_device_opts =
                                               "mcq=true,mcq-maxq=1" };
 
+    QOSGraphTestOptions wb_test_opts = { .before = ufs_blk_test_setup,
+                                         .edge.extra_device_opts =
+                                             "mcq=false,nutrs=32,nutmrs=8,"
+                                             "wb-max-size=1024,"
+                                             "wb-min-size=256" };
+
     add_qpci_address(&edge_opts, &(QPCIAddress){ .devfn = QPCI_DEVFN(4, 0) });
 
     qos_node_create_driver("ufs", ufs_create);
@@ -1262,6 +1437,8 @@ static void ufs_register_nodes(void)
                  &io_test_opts);
     qos_add_test("query-desciptor", "ufs", ufstest_query_desc_request,
                  &io_test_opts);
+    qos_add_test("wb-init", "ufs", ufstest_wb_init, &wb_test_opts);
+    qos_add_test("wb-read-write", "ufs", ufstest_wb_read_write, &wb_test_opts);
 }
 
 libqos_init(ufs_register_nodes);
-- 
2.43.0


