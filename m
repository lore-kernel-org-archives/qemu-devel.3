Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61683F36BAE
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 05:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB4sE-0004vt-2y; Fri, 10 Apr 2026 01:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wB4sC-0004t2-7d
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 01:57:44 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wB4sA-0007zM-Cz
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 01:57:44 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c70fb6aa323so671296a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 22:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775800661; x=1776405461; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UvnDam+RI7xNOArU3spJiI07Kx70RBnYFEvTvltBdIM=;
 b=odOEuxPSULQeUrqIBSKO9zOBgyfXoUy9cnR2a349r0DzstylLTDjM+/tB85SZ1y9/b
 l6e+Drht6NZhYfT9X2o8SpcaAH0F9yXpmLynNNJGa7KNsrUWxn/Ohm2gxofRAAxYLiKC
 OyUrKAOIWz1c/8I3aQxxNu9lY8NtW/mtk6qTf/dCqfwzPvU83dAr+8v9iKrzWVkcO7GN
 rW0l9Q3RMTd6aCZ7YwkdjRbaruRhEFLyAsfHhmGRovk1BY8YcArCf/zQ771netcpIk1A
 S8T5X+0/QjrCStm/e7U+euSFzmN2xX92xyuNpNf4RHJ23FlHWCX05ad68WQOVxvAcfkR
 ZZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775800661; x=1776405461;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UvnDam+RI7xNOArU3spJiI07Kx70RBnYFEvTvltBdIM=;
 b=Qzy2TfeBApd86/3XWrv7IEDU8+7eonJMCZngXRQIBi1/q57dbNHJ9AOmbzvotp5D4y
 lmtCJIFQta9SnE1SmSbL0YbnDebqzjLhHbZjacN2A9x8nscXVte4BSAocaur49b0eKw7
 iVpUPwkUomodE6UtwH53wokD8pSmFpY2spsHKF4qMsIgRYj20DsQZ47KXQU6BXUx6wE/
 puVA+Y1VuyeW3qYrOctlTh6aGDJe23BhFa1Ec+wopxVHMd+HaL0KsynQBhg0GtQOY2HR
 Wm0aWullz2IDpeKWp06aa4Xf5acWrg7pkpmU0RGVWWfd+8hbZwTxelhqD2xjJfh5JIrM
 vmMA==
X-Gm-Message-State: AOJu0YxiTBcQ++2wz4pjcWXGddyCipsbLV/XGjEnoeDHhifUoGZQgBwX
 WV8d9F4xVIML+Ql9JEFvaPRlN62Waza6YLNN1DeBKq5awsCk6Bry6oQC
X-Gm-Gg: AeBDievaHMMIyuKbqg6rsK80vskrPwPHI6sCLQ3+tPvOxH68YJmuoCKgoGeA51Nqn0T
 tmxvOim2i31jr3NYS8SriAaw/og4mm0kF2eq7Ik7O8TCVkOjrxMqwRnTEBhU8B1WUbSCwtcq/Dy
 vP5SSRzD/w2Z1m0BE5vWVYVzgyxE6IkIZY3hGqFZkFnWJ0jeIbdql8N2ETEqBDUDV/GOux0veoe
 R3n2aTvtBFOiK23Tm+43OsvbOxZWbHfun95b6bxbcIC8aXKwAs1xlDttp9Jg3NRPJUqHHBNpUPp
 ESlL2RB9D9pJo/YXISMq/I6kDPSBDU3bGeYcmTyMlR4vRwtCIU+inqpzgLxrWmhciqN0vYWWnlg
 hrmwY5FkhwefcE9cZGjMa/M0MouS+u5grwBYVh79YjP9ZBF0sFP3abRob/76/Ejnzs1y4ElOxvn
 q3NQvWTXPPD1Yj2gzo1K1gfq+Oh/2T0DSVPvdjTL3g
X-Received: by 2002:a05:6a20:6a1d:b0:39f:a8fb:3354 with SMTP id
 adf61e73a8af0-39fe3cf233fmr2319155637.17.1775800660823; 
 Thu, 09 Apr 2026 22:57:40 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79218fc8d9sm1225965a12.12.2026.04.09.22.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 22:57:40 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Date: Fri, 10 Apr 2026 14:57:18 +0900
Subject: [PATCH v5 5/5] tests/qtest: Add UFS Write Booster QTest
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-write_booster-v5-5-d44e1a0e191c@samsung.com>
References: <20260410-write_booster-v5-0-d44e1a0e191c@samsung.com>
In-Reply-To: <20260410-write_booster-v5-0-d44e1a0e191c@samsung.com>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775800645; l=8918;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=rU67KxRcVLL6ZVBVhiBQ/INRn8llY3KXffQmzbO047E=;
 b=9aBa1DA8BEB/wBsYy+k3c3Bh5gJpLqOCExbaDWns0ydiSQAT4zknTw3J0R5LIH1lumD5kFBAg
 vG0L80gPwyVAlDvp+poDJy9rVT3+uylJ8BRUYBTJnEaIMFpflPBuWUH
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=ldc.jml@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

It adds 'wb-init' and 'wb-read-write' TCs into tests/qtest/ufs-test.c.
'wb-init' tests that the WB support is properly initialized with UFS
device and 'wb-read-write' tests that WB can be enabled and WRITE I/O
can be handled/buffered as a WB command.

Signed-off-by: Jaemyung Lee <jaemyung.lee@samsung.com>
---
 tests/qtest/ufs-test.c | 176 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 7f999441552a105987aaaf8e2b976f4a05f953ed..253fea27a5e52619f433d15075500a566eddeccc 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -1182,6 +1182,173 @@ static void ufstest_query_desc_request(void *obj, void *data,
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
+    value = *(uint16_t *)(desc + UFS_DEVICE_DESC_PARAM_EXT_WB_SUP);
+    value = be16_to_cpu(value);
+    g_assert_cmpuint(value, ==, WB_RESIZE | WB_FIFO | WB_PINNED);
+
+    value = *(uint32_t *)(desc + UFS_DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
+    value = be32_to_cpu(value);
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
+    value = *(uint32_t *)(desc + UFS_GEOMETRY_DESC_PARAM_WB_MAX_ALLOC_UNITS);
+    value = be32_to_cpu(value);
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
+                         UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.opcode, ==, UFS_UPIU_QUERY_OPCODE_READ_ATTR);
+    g_assert_cmpuint(rsp_upiu.qr.idn, ==, UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0xA));
+
+    /* Enable WB */
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_SET_FLAG,
+                         UFS_QUERY_FLAG_IDN_WB_EN, 0, 0, 0,
+                         &rsp_upiu);
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
+        g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+        g_assert_cmpuint(rsp_upiu.qr.opcode, ==, UFS_UPIU_QUERY_OPCODE_READ_ATTR);
+        g_assert_cmpuint(rsp_upiu.qr.idn, ==, UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE);
+    } while (rsp_upiu.qr.value == cpu_to_be32(0xA) && g_get_monotonic_time() < end_time);
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
@@ -1234,6 +1401,13 @@ static void ufs_register_nodes(void)
                                           .edge.extra_device_opts =
                                               "mcq=true,mcq-maxq=1" };
 
+    QOSGraphTestOptions wb_test_opts = { .before = ufs_blk_test_setup,
+                                         .edge.extra_device_opts =
+                                             "mcq=false,nutrs=32,nutmrs=8,"
+                                             "wb-max-size=1024,wb-min-size=256,"
+                                             "wb-max-lus=1,wb-cap-adj-fac=3,"
+                                             "wb-reduction=1" };
+
     add_qpci_address(&edge_opts, &(QPCIAddress){ .devfn = QPCI_DEVFN(4, 0) });
 
     qos_node_create_driver("ufs", ufs_create);
@@ -1262,6 +1436,8 @@ static void ufs_register_nodes(void)
                  &io_test_opts);
     qos_add_test("query-desciptor", "ufs", ufstest_query_desc_request,
                  &io_test_opts);
+    qos_add_test("wb-init", "ufs", ufstest_wb_init, &wb_test_opts);
+    qos_add_test("wb-read-write", "ufs", ufstest_wb_read_write, &wb_test_opts);
 }
 
 libqos_init(ufs_register_nodes);

-- 
2.48.1


