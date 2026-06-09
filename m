Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46233CD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 04:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWnpT-0002n6-8Z; Tue, 09 Jun 2026 00:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keosung.park@samsung.com>)
 id 1wWnpQ-0002mo-8T
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 00:12:40 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keosung.park@samsung.com>)
 id 1wWnpN-0005On-22
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 00:12:40 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20260609041229epoutp011ffbe97e3afbe083202d91f53b3e4885~3Tl_JmPiS2942329423epoutp01f
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2026 04:12:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20260609041229epoutp011ffbe97e3afbe083202d91f53b3e4885~3Tl_JmPiS2942329423epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1780978349;
 bh=TqIvJe3RKwK7aU1y+Q7f2uDi1Gq/BJLAwiVun+M56P0=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=HtJj0LYXRisWmurMB4yz8V4OZwPKJO64yK5a1w9zfdO8z24WDTHK4dEO6tuEBEGPm
 mjdkO/cx7KNzFSKtloWJOdq3SC9PfEs6aBXdQR+5IW3DHZLRTnyy0k4CooZOtbfvBu
 kpAbpyearnABLwX55V9OLUUFPDx3h0JL39ph23uU=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
 20260609041229epcas2p4af9c0752bb860e36821c514bcbcba264~3Tl9yzlhr1203712037epcas2p4h;
 Tue,  9 Jun 2026 04:12:29 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.211]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4gZFqd1Qlbz6B9mD; Tue,  9 Jun
 2026 04:12:29 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH 2/2] tests/qtest: Add UFS HID qtest
From: Keoseong Park <keosung.park@samsung.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Keoseong Park
 <keosung.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20260609023909epcms2p3f8856f12fed093168aff636f8dc8f994@epcms2p3>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260609041228epcms2p511070f9b5c2179967c0a27dd591a6d94@epcms2p5>
Date: Tue, 09 Jun 2026 13:12:28 +0900
X-CMS-MailID: 20260609041228epcms2p511070f9b5c2179967c0a27dd591a6d94
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609023909epcms2p3f8856f12fed093168aff636f8dc8f994
References: <20260609023909epcms2p3f8856f12fed093168aff636f8dc8f994@epcms2p3>
 <CGME20260609023909epcms2p3f8856f12fed093168aff636f8dc8f994@epcms2p5>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=keosung.park@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: keosung.park@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Cover the HID attribute permission table, the disable / analysis /
defrag state transitions, partial defrag bounded by dHIDSize, and
the terminal auto-reset behaviors.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 tests/qtest/ufs-test.c | 290 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 290 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index f677896db0..5496276326 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -1386,6 +1386,295 @@ static void *ufs_blk_test_setup(GString *cmd_line, void *arg)
     return arg;
 }
 
+/*
+ * Helper to read a single HID attribute value.
+ * Returns the host-endian attribute value; asserts OCS success.
+ */
+static uint32_t ufs_hid_read_attr(QUfs *ufs, uint8_t idn)
+{
+    enum UtpOcsCodes ocs;
+    UtpUpiuRsp rsp;
+
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                         idn, 0, 0, 0, &rsp);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    return be32_to_cpu(rsp.qr.value);
+}
+
+/*
+ * Helper to write a single HID attribute value.
+ * Asserts OCS success.
+ */
+static void ufs_hid_write_attr(QUfs *ufs, uint8_t idn, uint32_t value)
+{
+    enum UtpOcsCodes ocs;
+    UtpUpiuRsp rsp;
+
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                         idn, 0, 0, value, &rsp);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+}
+
+static uint32_t ufs_hid_wait_leave_state(QUfs *ufs, uint32_t from)
+{
+    uint64_t end_time =
+        g_get_monotonic_time() + TIMEOUT_SECONDS * G_TIME_SPAN_SECOND;
+    uint32_t state;
+
+    do {
+        qtest_clock_step(ufs->dev.bus->qts, 100);
+        state = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_STATE);
+    } while (state == from && g_get_monotonic_time() < end_time);
+
+    return state;
+}
+
+static uint32_t ufs_hid_wait_state(QUfs *ufs, uint32_t expected)
+{
+    uint64_t end_time =
+        g_get_monotonic_time() + TIMEOUT_SECONDS * G_TIME_SPAN_SECOND;
+    uint32_t state;
+
+    do {
+        qtest_clock_step(ufs->dev.bus->qts, 100);
+        state = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_STATE);
+    } while (state != expected && g_get_monotonic_time() < end_time);
+
+    g_assert_cmpuint(state, ==, expected);
+    return state;
+}
+
+static void ufs_hid_wait_progress_complete(QUfs *ufs)
+{
+    uint64_t end_time =
+        g_get_monotonic_time() + TIMEOUT_SECONDS * G_TIME_SPAN_SECOND;
+    uint32_t val;
+
+    do {
+        qtest_clock_step(ufs->dev.bus->qts, 100);
+        val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_PROG_RATIO);
+    } while (val != 100 && g_get_monotonic_time() < end_time);
+
+    g_assert_cmpuint(val, ==, 100);
+}
+
+static void ufstest_hid(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    uint32_t val;
+    enum UtpOcsCodes ocs;
+    UtpUpiuRsp rsp;
+    const int test_lun = 1;
+    const uint8_t request_sense_cdb[UFS_CDB_SIZE] = {
+        REQUEST_SENSE,
+    };
+    const uint8_t write_cdb[UFS_CDB_SIZE] = {
+        /* WRITE(10) to LBA 0, transfer length 8 sectors = 1 fragment */
+        WRITE_10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00
+    };
+    uint8_t write_buf[4096];
+    uint8_t read_buf[4096];
+    int i;
+
+    ufs_init(ufs, alloc);
+
+    /* Clear Unit Attention */
+    ufs_send_scsi_command(ufs, test_lun, request_sense_cdb, NULL, 0,
+                          read_buf, sizeof(read_buf), &rsp);
+
+    /*
+     * 1. Verify HID default attribute values
+     */
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_DEFRAG_OP);
+    g_assert_cmpuint(val, ==, UFS_HID_OP_DISABLE);
+
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_AVAIL_SIZE);
+    g_assert_cmpuint(val, ==, 0xFFFFFFFF);
+
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_SIZE);
+    g_assert_cmpuint(val, ==, 0xFFFFFFFF);
+
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_PROG_RATIO);
+    g_assert_cmpuint(val, ==, 0);
+
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_STATE);
+    g_assert_cmpuint(val, ==, UFS_HID_STATE_IDLE);
+
+    /*
+     * 2. Verify read-only attributes reject writes
+     */
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                         UFS_QUERY_ATTR_IDN_HID_AVAIL_SIZE, 0, 0, 0x100,
+                         &rsp);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp.header.response, ==,
+                     UFS_QUERY_RESULT_NOT_WRITEABLE);
+
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                         UFS_QUERY_ATTR_IDN_HID_PROG_RATIO, 0, 0, 50,
+                         &rsp);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp.header.response, ==,
+                     UFS_QUERY_RESULT_NOT_WRITEABLE);
+
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                         UFS_QUERY_ATTR_IDN_HID_STATE, 0, 0, 0x01, &rsp);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp.header.response, ==,
+                     UFS_QUERY_RESULT_NOT_WRITEABLE);
+
+    /*
+     * 3. Verify invalid bDefragOperation value is rejected
+     */
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                         UFS_QUERY_ATTR_IDN_DEFRAG_OP, 0, 0, 0x03,
+                         &rsp);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp.header.response, ==,
+                     UFS_QUERY_RESULT_INVALID_VALUE);
+
+    /*
+     * 4. dHIDSize is writable and readable
+     */
+    ufs_hid_write_attr(ufs, UFS_QUERY_ATTR_IDN_HID_SIZE, 0x100);
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_SIZE);
+    g_assert_cmpuint(val, ==, 0x100);
+
+    /* Restore default */
+    ufs_hid_write_attr(ufs, UFS_QUERY_ATTR_IDN_HID_SIZE, 0xFFFFFFFF);
+
+    /*
+     * 5. Analysis with no fragments -> Defrag Not Required, then reading
+     *    bHIDState in a terminal state auto-resets HID to Idle.
+     */
+    ufs_hid_write_attr(ufs, UFS_QUERY_ATTR_IDN_DEFRAG_OP,
+                       UFS_HID_OP_ANALYSIS);
+
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_STATE);
+    g_assert_cmpuint(val, ==, UFS_HID_STATE_ANALYSIS_IN_PROGRESS);
+
+    /* Idle handler advances analysis; first non-analysis read is decisive */
+    val = ufs_hid_wait_leave_state(ufs, UFS_HID_STATE_ANALYSIS_IN_PROGRESS);
+    g_assert_cmpuint(val, ==, UFS_HID_STATE_DEFRAG_NOT_REQUIRED);
+
+    /* Reading Not Required auto-reset to Idle */
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_STATE);
+    g_assert_cmpuint(val, ==, UFS_HID_STATE_IDLE);
+
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_AVAIL_SIZE);
+    g_assert_cmpuint(val, ==, 0xFFFFFFFF);
+
+    /*
+     * 6. Generate fragmentation via SCSI WRITE, then analyze (analysis
+     *    only): the machine settles at Defrag Required.
+     */
+    memset(write_buf, 0xab, sizeof(write_buf));
+    for (i = 0; i < 4; i++) {
+        ocs = ufs_send_scsi_command(ufs, test_lun, write_cdb, write_buf,
+                                    sizeof(write_buf), NULL, 0, &rsp);
+        g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    }
+
+    ufs_hid_write_attr(ufs, UFS_QUERY_ATTR_IDN_DEFRAG_OP,
+                       UFS_HID_OP_ANALYSIS);
+
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_STATE);
+    g_assert_cmpuint(val, ==, UFS_HID_STATE_ANALYSIS_IN_PROGRESS);
+
+    val = ufs_hid_wait_leave_state(ufs, UFS_HID_STATE_ANALYSIS_IN_PROGRESS);
+    g_assert_cmpuint(val, ==, UFS_HID_STATE_DEFRAG_REQUIRED);
+
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_DEFRAG_OP);
+    g_assert_cmpuint(val, ==, UFS_HID_OP_DISABLE);
+
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_AVAIL_SIZE);
+    g_assert_cmpuint(val, >, 0);
+
+    /*
+     * 7. Disable resets to Idle from any state
+     */
+    ufs_hid_write_attr(ufs, UFS_QUERY_ATTR_IDN_DEFRAG_OP,
+                       UFS_HID_OP_DISABLE);
+
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_STATE);
+    g_assert_cmpuint(val, ==, UFS_HID_STATE_IDLE);
+
+    /*
+     * 8. Partial defrag cycle: dHIDSize limits the requested defrag size,
+     *    and reading bHIDProgressRatio at 100% resets the HID attributes.
+     */
+    for (i = 0; i < 4; i++) {
+        ocs = ufs_send_scsi_command(ufs, test_lun, write_cdb, write_buf,
+                                    sizeof(write_buf), NULL, 0, &rsp);
+        g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    }
+
+    ufs_hid_write_attr(ufs, UFS_QUERY_ATTR_IDN_HID_SIZE, 2);
+    ufs_hid_write_attr(ufs, UFS_QUERY_ATTR_IDN_DEFRAG_OP,
+                       UFS_HID_OP_DEFRAG);
+
+    /* Should start in Analysis In Progress */
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_STATE);
+    g_assert_cmpuint(val, ==, UFS_HID_STATE_ANALYSIS_IN_PROGRESS);
+
+    ufs_hid_wait_progress_complete(ufs);
+
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_AVAIL_SIZE);
+    g_assert_cmpuint(val, ==, 0xFFFFFFFF);
+
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_DEFRAG_OP);
+    g_assert_cmpuint(val, ==, UFS_HID_OP_DISABLE);
+
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_PROG_RATIO);
+    g_assert_cmpuint(val, ==, 0);
+
+    /*
+     * Re-analyze after the partial defrag. There were 8 fragments before
+     * defrag, and dHIDSize limited the completed operation to 2.
+     */
+    ufs_hid_write_attr(ufs, UFS_QUERY_ATTR_IDN_DEFRAG_OP,
+                       UFS_HID_OP_ANALYSIS);
+
+    val = ufs_hid_wait_leave_state(ufs, UFS_HID_STATE_ANALYSIS_IN_PROGRESS);
+    g_assert_cmpuint(val, ==, UFS_HID_STATE_DEFRAG_REQUIRED);
+
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_AVAIL_SIZE);
+    g_assert_cmpuint(val, ==, 6);
+
+    ufs_hid_write_attr(ufs, UFS_QUERY_ATTR_IDN_DEFRAG_OP,
+                       UFS_HID_OP_DISABLE);
+    ufs_hid_write_attr(ufs, UFS_QUERY_ATTR_IDN_HID_SIZE, 0xFFFFFFFF);
+
+    /*
+     * 9. Full defrag cycle: reading bHIDState in Completed state returns
+     *    Completed once and resets HID attributes to Idle/default values.
+     */
+    ufs_hid_write_attr(ufs, UFS_QUERY_ATTR_IDN_DEFRAG_OP,
+                       UFS_HID_OP_DEFRAG);
+
+    val = ufs_hid_wait_state(ufs, UFS_HID_STATE_DEFRAG_COMPLETED);
+    g_assert_cmpuint(val, ==, UFS_HID_STATE_DEFRAG_COMPLETED);
+
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_STATE);
+    g_assert_cmpuint(val, ==, UFS_HID_STATE_IDLE);
+
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_DEFRAG_OP);
+    g_assert_cmpuint(val, ==, UFS_HID_OP_DISABLE);
+
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_AVAIL_SIZE);
+    g_assert_cmpuint(val, ==, 0xFFFFFFFF);
+
+    ufs_exit(ufs, alloc);
+}
+
 static void ufs_register_nodes(void)
 {
     const char *arch;
@@ -1439,6 +1728,7 @@ static void ufs_register_nodes(void)
                  &io_test_opts);
     qos_add_test("wb-init", "ufs", ufstest_wb_init, &wb_test_opts);
     qos_add_test("wb-read-write", "ufs", ufstest_wb_read_write, &wb_test_opts);
+    qos_add_test("hid", "ufs", ufstest_hid, &io_test_opts);
 }
 
 libqos_init(ufs_register_nodes);
-- 
2.25.1


