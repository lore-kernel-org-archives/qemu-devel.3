Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD74D3CCAF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 04:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgFNn-00027A-ED; Wed, 14 Jan 2026 23:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vgFNl-00024R-6U
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:54:53 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vgFNj-00076t-DK
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:54:52 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c2dc870e194so211003a12.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 20:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768452890; x=1769057690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rJHXNit0JKho2PSdVDxe5tw9YboCOURabBlYsSPHIE=;
 b=RXtPfpJZVWV+auA12PLFxS8O8QJ9TBIa4g2V1MxyaVC9ueUyPTADxKH/yNAZzb30G9
 rDMBO7dkOexPPEjjbl28WF6zCFeDt4RZXpxh08jGziUZPceDBiz+TRaqglayPt4PvNPO
 OsksBXJ0N9vefg1Ugh+uRa+JM3/QEcZHyl+LctyQ4/zJtGt7hLRvF4L9tCpAruLpg1Yx
 7OS2ilUh1VvEWJFC+TB3GUrcXfcRtTAR5MMvuJtGtndm3oPqGDhbaQYrPyRYe+YyjVu1
 EZFPZNvFaWg5twVWUgC37XIa89EvPKcFJSVhSKB53EKFrKruKYmvwuUXxpmK6B4cc7Hu
 hMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768452890; x=1769057690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0rJHXNit0JKho2PSdVDxe5tw9YboCOURabBlYsSPHIE=;
 b=M7/bwgL1J8r3BPiYpZZL6RrOEdlEqJykOTLbtPr6OeROdM+KBV2Ol2iM0diA1j6DJz
 VJ7+5M6kKT3Y3Gzj7xOoCGzbGZjfmACrc6QOaMpRnQCcab7RtvyETykNhwZvS03b28vO
 m1btvA3Kmym6vLK4EJ3vz+2Z/cxsiwZukBwNbR2o8SG3S7S2e+HF7QGV8uT0eDVFxy8+
 MvI2ZQISY/dRbpmkjt2bP5xIi4b7hBnZNuPaAakpXW+0bNhfX42KgsxfvG7NCCdSl4CJ
 YfKkbEzNlwJAZbWwCAMx6MXl2owIBGwhp8edQ8ccVqg663vFy7iyZ529ECtqHbSZJLE3
 HZpg==
X-Gm-Message-State: AOJu0YzJcg/EoTBcp9rFpB00tJUu+m0GdlFGxG74UEpFhwT4JE2rWHlx
 ORFKiDF/52reynbvnJ/D5+gqlrykv46zHN4O7qGeXeR3VhtpxCFD31ktz/x7sQ==
X-Gm-Gg: AY/fxX6Jnzz9itUyi8pmFVvt1StrqkZdAUwtnfYXLtmdQOis0FdG2Sl1mqeRmQxvKrX
 86sq9OjEkkUsyZw9k0i7EpNzqPHuxzrnr6wPlTuJkQt8FjlJ9jZI8Hq+Lb45TzmOD6du6rH+nUK
 /ghfPGH4yG6R+LyO9jkG3ifkZz0GMKUpyWEulyzXKn9lK0fZsutHpAb57TpvHF36fcviPX6Yr1s
 hn6+2MZjpPGfLifxtS+mtgQDOdvyDFxfCTPNSSlGWASyOR2uTu/0AQioiZ13sOYgdexlK0N1XzA
 YCdtEdRgp1zslSbdFA7OKhjDYGxGSeLPb9y4yCV+z13XqAtOlXAnW5K64T4PTsOB9wEj0GO/QYc
 aS5Z8agyQUORqluvLnzjkHe+bKdF1YR55dtQeiPoled9WcT4VYraEErRnJczdkQpjdbcAEDnYHq
 PozLPhjWfXxlUfVA==
X-Received: by 2002:a05:6a00:420b:b0:81f:3cd5:2069 with SMTP id
 d2e1a72fcca58-81f81d13491mr5272132b3a.4.1768452889755; 
 Wed, 14 Jan 2026 20:54:49 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f8e4b4110sm1141426b3a.10.2026.01.14.20.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 20:54:49 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, Ilia Levi <ilia.levi@intel.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 3/3] tests/qtest/ufs-test: Add test for mcq completion queue
 wraparound
Date: Thu, 15 Jan 2026 13:54:01 +0900
Message-ID: <0995e513c7c46412ccb5b11a2e71b9c7145997b0.1768452598.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768452598.git.jeuk20.kim@samsung.com>
References: <cover.1768452598.git.jeuk20.kim@samsung.com>
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

From: Ilia Levi <ilia.levi@intel.com>

Added a test that sends 32 NOP Out commands asynchronously. Since the CQ
has 31 entries by default, this tests the scenario where CQ processing
needs to wait for space to become available.

Additionally, added two minor fixes to existing tests:
* advance CQ head after reading from CQ
* initialize command descriptor slots bitmap in ufs_init()

Signed-off-by: Ilia Levi <ilia.levi@intel.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 tests/qtest/ufs-test.c | 126 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 4867ccf08a..ff9835735c 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -166,6 +166,7 @@ __ufs_send_transfer_request_mcq(QUfs *ufs, uint8_t lun,
     cqhp = ufs_rreg(ufs, ufs->cqdao[TEST_QID]);
     cqentry_addr = ufs->cqlba[TEST_QID] + cqhp;
     qtest_memread(ufs->dev.bus->qts, cqentry_addr, &cqentry, sizeof(cqentry));
+    cqhp = (cqhp + sizeof(UfsCqEntry)) % (QUEUE_SIZE * sizeof(UfsCqEntry));
     ufs_wreg(ufs, ufs->cqdao[TEST_QID], cqhp);
 
     return cqentry.status;
@@ -208,6 +209,81 @@ static enum UtpOcsCodes ufs_send_nop_out(QUfs *ufs, UtpUpiuRsp *rsp_out)
     return ret;
 }
 
+static bool ufs_mcq_sq_has_space(QUfs *ufs)
+{
+    uint32_t sqhp = ufs_rreg(ufs, ufs->sqdao[TEST_QID]);
+    uint32_t sqtp = ufs_rreg(ufs, ufs->sqdao[TEST_QID] + 0x4);
+    uint32_t next_sqtp =
+        (sqtp + sizeof(UfsSqEntry)) % (QUEUE_SIZE * sizeof(UfsSqEntry));
+    return next_sqtp != sqhp;
+}
+
+static void
+__ufs_send_transfer_request_mcq_async(QUfs *ufs, uint8_t lun,
+                                      const UtpTransferReqDesc *utrd)
+{
+    uint32_t sqtp;
+    uint64_t utrd_addr;
+
+    /* Wait for SQ space */
+    while (!ufs_mcq_sq_has_space(ufs)) {
+        qtest_clock_step(ufs->dev.bus->qts, 100);
+    }
+
+    sqtp = ufs_rreg(ufs, ufs->sqdao[TEST_QID] + 0x4);
+    utrd_addr = ufs->sqlba[TEST_QID] + sqtp;
+    qtest_memwrite(ufs->dev.bus->qts, utrd_addr, utrd, sizeof(*utrd));
+    sqtp = (sqtp + sizeof(UfsSqEntry)) % (QUEUE_SIZE * sizeof(UfsSqEntry));
+    ufs_wreg(ufs, ufs->sqdao[TEST_QID] + 0x4, sqtp);
+}
+
+static int ufs_mcq_send_nop_out_async(QUfs *ufs)
+{
+    int cmd_desc_slot = alloc_cmd_desc_slot(ufs);
+    uint64_t req_upiu_addr =
+        ufs->cmd_desc_addr + cmd_desc_slot * UTP_COMMAND_DESCRIPTOR_SIZE;
+
+    /* Build up request upiu */
+    UtpUpiuReq req_upiu = { 0 };
+    req_upiu.header.trans_type = UFS_UPIU_TRANSACTION_NOP_OUT;
+    req_upiu.header.task_tag = cmd_desc_slot;
+    qtest_memwrite(ufs->dev.bus->qts, req_upiu_addr, &req_upiu,
+                   sizeof(req_upiu));
+
+    /* Build up utp transfer request descriptor */
+    UtpTransferReqDesc utrd =
+        ufs_build_req_utrd(req_upiu_addr, UFS_UTP_NO_DATA_TRANSFER, 0);
+
+    /* Send Transfer Request */
+    __ufs_send_transfer_request_mcq_async(ufs, 0, &utrd);
+
+    return cmd_desc_slot;
+}
+
+static int ufs_mcq_poll_cq(QUfs *ufs, UfsCqEntry *cqe, uint16_t n_cqe)
+{
+    uint32_t cqhp, cqtp;
+    uint64_t cqe_addr;
+    int ix = 0;
+
+    cqhp = ufs_rreg(ufs, ufs->cqdao[TEST_QID]);
+    cqtp = ufs_rreg(ufs, ufs->cqdao[TEST_QID] + 0x4);
+
+    while (cqhp != cqtp && ix < n_cqe) {
+        /* read completion entry */
+        cqe_addr = ufs->cqlba[TEST_QID] + cqhp;
+        qtest_memread(ufs->dev.bus->qts, cqe_addr, &cqe[ix], sizeof(cqe[ix]));
+
+        /* advance completion queue head pointer */
+        cqhp = (cqhp + sizeof(UfsCqEntry)) % (QUEUE_SIZE * sizeof(UfsCqEntry));
+        ix++;
+    }
+
+    ufs_wreg(ufs, ufs->cqdao[TEST_QID], cqhp);
+
+    return ix;
+}
+
 static enum UtpOcsCodes ufs_send_query(QUfs *ufs, uint8_t query_function,
                                        uint8_t query_opcode, uint8_t idn,
                                        uint8_t index, uint8_t selector,
@@ -416,6 +492,7 @@ static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
     ufs_wreg(ufs, A_UTRIACR, 0);
 
     /* Enable transfer request */
+    bitmap_zero(ufs->cmd_desc_bitmap, UFS_MAX_CMD_DESC);
     ufs->cmd_desc_addr =
         guest_alloc(alloc, UFS_MAX_CMD_DESC * UTP_COMMAND_DESCRIPTOR_SIZE);
     ufs->data_buffer_addr =
@@ -679,6 +756,53 @@ static void ufstest_read_write(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
+static void ufstest_mcq_cq_wraparound(void *obj, void *data,
+                                      QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    UfsCqEntry cqe[QUEUE_SIZE];
+    const int num_requests = QUEUE_SIZE;
+    int i, completed = 0;
+
+    ufs_init(ufs, alloc);
+
+    /* Ensure MCQ is supported */
+    g_assert_true(ufs->support_mcq);
+
+    for (i = 0; i < num_requests; ++i) {
+        ufs_mcq_send_nop_out_async(ufs);
+    }
+
+    while (completed != num_requests) {
+        int n_cqe = ufs_mcq_poll_cq(ufs, cqe, ARRAY_SIZE(cqe));
+        if (!n_cqe) {
+            break;
+        }
+
+        for (i = 0; i < n_cqe; ++i) {
+            uint64_t ucdba;
+            uint64_t rsp_upiu_addr;
+            UtpUpiuRsp rsp_upiu;
+            uint8_t tag;
+
+            g_assert_cmpuint(cqe[i].status, ==, UFS_OCS_SUCCESS);
+
+            ucdba = le64_to_cpu(cqe[i].utp_addr) & MAKE_64BIT_MASK(7, 57);
+            rsp_upiu_addr = ucdba + UTP_RESPONSE_UPIU_OFFSET;
+            qtest_memread(ufs->dev.bus->qts, rsp_upiu_addr, &rsp_upiu,
+                          sizeof(rsp_upiu));
+
+            tag = rsp_upiu.header.task_tag;
+            release_cmd_desc_slot(ufs, tag);
+        }
+
+        completed += n_cqe;
+    }
+
+    g_assert_cmpint(completed, ==, num_requests);
+    ufs_exit(ufs, alloc);
+}
+
 static void ufstest_query_flag_request(void *obj, void *data,
                                        QGuestAllocator *alloc)
 {
@@ -1129,6 +1253,8 @@ static void ufs_register_nodes(void)
     qos_add_test("init", "ufs", ufstest_init, NULL);
     qos_add_test("legacy-read-write", "ufs", ufstest_read_write, &io_test_opts);
     qos_add_test("mcq-read-write", "ufs", ufstest_read_write, &mcq_test_opts);
+    qos_add_test("mcq-cq-wraparound", "ufs", ufstest_mcq_cq_wraparound,
+                 &mcq_test_opts);
     qos_add_test("query-flag", "ufs", ufstest_query_flag_request,
                  &io_test_opts);
     qos_add_test("query-attribute", "ufs", ufstest_query_attr_request,
-- 
2.43.0


