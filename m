Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE3ACD98CC
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 00:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXpn2-0003Gm-Kp; Thu, 11 Jun 2026 20:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wXpn0-0003Gb-Ei
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 20:30:26 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wXpmy-0007bJ-8l
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 20:30:26 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-36bdb11bf8bso334689a91.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 17:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781224223; x=1781829023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHx1ZM1aqHrO21VAUN6JcB5x7KXJtXWA76/NKTdx31E=;
 b=cHFcdWMqQC+lV14Ix/70vCdar+RxXGcuhDDZTz4IYh6Fws6EVPigBC7sm3cTXy9iR9
 xOYV7N5L1JGRhwYANBMAF/9xApPjtdE+yreikkwyqJoMcOUvPm7+/GnMYde/tzkrmVDG
 +t6fSuc+RCG/Cg8hNk6djPOlY1qtCW5+U2QQt3R2R6ncT1GZwE+DLlZi/FVFUyQ0XTYU
 CZy38imds1HltspntgxfKclNnsWwP99Gd0cda2zxWuZTBwwmxp0gSrwqw7Lj8aZ/zy6e
 RDJcdHj9QeEeUN23KcDMG0o0v2IIzPOvteFXK822r7tysVViP5PpKAj3KZc02B4DiI3M
 XVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781224223; x=1781829023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VHx1ZM1aqHrO21VAUN6JcB5x7KXJtXWA76/NKTdx31E=;
 b=smET3n/rRsckgJMy82rBPIjAuijTUTbF528MKnDD9C+T4EndlqEmg3Fn2bvfI5wKG4
 D+y3DAzvnDe73LE8MaH9dL2nsd3CSYJW+wyYzpGjMUQZEOc64RPm6s3dD9XS+DwXzLPf
 Ml6bXdXVjZq7VJ3tuTrC7Sj0SOBQ92Nz7M/BPWKAJS//1rGgguEqo47ITlCqEt1lAyCn
 u46wR4WpUqSFuCjxyms3LOVuimgbknE4MLWR6rqx8B7Ez90Mc5ywNcQJ1tGFsqnYuNEo
 2hOlZZaMEXGu5Docag00/KSSmZyY0QIyvIQZ22wcP8lNLUMLHmTNK5gjYHI4l6aRQyp5
 FyoA==
X-Gm-Message-State: AOJu0YyyhSVhs0tREnNoOdh/VHfjROSSp95msnEohG2Rj8Rou7t3fQT4
 8dVZU5yfqU8176y9Ca0O0GsXe71OhlVTVqYG/eILZCDA+ECvbWgtxStnvxEdQA==
X-Gm-Gg: Acq92OGdEeL6lbOUPlvpWfsjlmywIYvKfq6v+cw5FbmPcyscKKjrF8Bt6VTEy8jSuR4
 by9SAEhX/AUuGt/CE4spEaODKvH23M+lJxpQ089PWxX4lc2NZqHY78Xb4TFLHZGPoaEPAcJN25Y
 iSXbJi4B5xoya3qVfnr4u6NA30gaGGhGjCYIEtkSkAh8KJ5YPaRQWL8pvbVS+DpBERAN8TcGbwc
 XwMu23CZm9bwYEL9W98GYgUWQ+Zg/HGjL2A2p8yacCxo3A9kd599njCKU/p6nt017JaEqL3BvUA
 OXW0VD+dfXQvqy9diMutp84PJY45f0ySRq6py8JxUvJBi60JPlUfhObPIrfx13XVbqtSaGaDwus
 lH5V1KJvDNJq3N3Ah1cFCddLRHE9425pimtj2f0iL1osjygT61qavmybffGfXaw663BRDNZIVZk
 tsAfgHQDRmXgm0mM4vdfrr+VZqBgkC
X-Received: by 2002:a17:90b:4d07:b0:369:e4d4:79c6 with SMTP id
 98e67ed59e1d1-37a03ad61d9mr693646a91.20.1781224222651; 
 Thu, 11 Jun 2026 17:30:22 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-379e79396d7sm336989a91.1.2026.06.11.17.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 17:30:22 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, Keoseong Park <keosung.park@samsung.com>
Subject: [PULL 2/2] tests/qtest: Add UFS HID qtest
Date: Fri, 12 Jun 2026 09:29:56 +0900
Message-ID: <6b1215d82f7cd8a0b562a02a1473aa6714759eed.1781223925.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781223925.git.jeuk20.kim@samsung.com>
References: <cover.1781223925.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1035.google.com
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

From: Keoseong Park <keosung.park@samsung.com>

Cover the HID attribute permission table, the disable / analysis /
defrag state transitions, partial defrag bounded by dHIDSize, and
the terminal auto-reset behaviors.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 tests/qtest/ufs-test.c | 275 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 275 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index f677896db0..3b85296a72 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -1386,6 +1386,280 @@ static void *ufs_blk_test_setup(GString *cmd_line, void *arg)
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
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR, idn, 0, 0, 0, &rsp);
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
+                         UFS_UPIU_QUERY_OPCODE_WRITE_ATTR, idn, 0, 0, value,
+                         &rsp);
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
+    ufs_send_scsi_command(ufs, test_lun, request_sense_cdb, NULL, 0, read_buf,
+                          sizeof(read_buf), &rsp);
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
+                         UFS_QUERY_ATTR_IDN_HID_AVAIL_SIZE, 0, 0, 0x100, &rsp);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp.header.response, ==, UFS_QUERY_RESULT_NOT_WRITEABLE);
+
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                         UFS_QUERY_ATTR_IDN_HID_PROG_RATIO, 0, 0, 50, &rsp);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp.header.response, ==, UFS_QUERY_RESULT_NOT_WRITEABLE);
+
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                         UFS_QUERY_ATTR_IDN_HID_STATE, 0, 0, 0x01, &rsp);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp.header.response, ==, UFS_QUERY_RESULT_NOT_WRITEABLE);
+
+    /*
+     * 3. Verify invalid bDefragOperation value is rejected
+     */
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                         UFS_QUERY_ATTR_IDN_DEFRAG_OP, 0, 0, 0x03, &rsp);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp.header.response, ==, UFS_QUERY_RESULT_INVALID_VALUE);
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
+    ufs_hid_write_attr(ufs, UFS_QUERY_ATTR_IDN_DEFRAG_OP, UFS_HID_OP_ANALYSIS);
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
+    ufs_hid_write_attr(ufs, UFS_QUERY_ATTR_IDN_DEFRAG_OP, UFS_HID_OP_ANALYSIS);
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
+    ufs_hid_write_attr(ufs, UFS_QUERY_ATTR_IDN_DEFRAG_OP, UFS_HID_OP_DISABLE);
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
+    ufs_hid_write_attr(ufs, UFS_QUERY_ATTR_IDN_DEFRAG_OP, UFS_HID_OP_DEFRAG);
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
+    ufs_hid_write_attr(ufs, UFS_QUERY_ATTR_IDN_DEFRAG_OP, UFS_HID_OP_ANALYSIS);
+
+    val = ufs_hid_wait_leave_state(ufs, UFS_HID_STATE_ANALYSIS_IN_PROGRESS);
+    g_assert_cmpuint(val, ==, UFS_HID_STATE_DEFRAG_REQUIRED);
+
+    val = ufs_hid_read_attr(ufs, UFS_QUERY_ATTR_IDN_HID_AVAIL_SIZE);
+    g_assert_cmpuint(val, ==, 6);
+
+    ufs_hid_write_attr(ufs, UFS_QUERY_ATTR_IDN_DEFRAG_OP, UFS_HID_OP_DISABLE);
+    ufs_hid_write_attr(ufs, UFS_QUERY_ATTR_IDN_HID_SIZE, 0xFFFFFFFF);
+
+    /*
+     * 9. Full defrag cycle: reading bHIDState in Completed state returns
+     *    Completed once and resets HID attributes to Idle/default values.
+     */
+    ufs_hid_write_attr(ufs, UFS_QUERY_ATTR_IDN_DEFRAG_OP, UFS_HID_OP_DEFRAG);
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
@@ -1439,6 +1713,7 @@ static void ufs_register_nodes(void)
                  &io_test_opts);
     qos_add_test("wb-init", "ufs", ufstest_wb_init, &wb_test_opts);
     qos_add_test("wb-read-write", "ufs", ufstest_wb_read_write, &wb_test_opts);
+    qos_add_test("hid", "ufs", ufstest_hid, &io_test_opts);
 }
 
 libqos_init(ufs_register_nodes);
-- 
2.43.0


