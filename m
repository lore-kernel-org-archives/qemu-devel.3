Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D688D172D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 05:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmmh3-0003wA-AY; Mon, 02 Feb 2026 00:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vmmgz-0003uK-S7
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:41:46 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vmmgy-0003zd-5q
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:41:45 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a9004e4239so4775205ad.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 21:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770010902; x=1770615702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+iDOixNWGXe//eYSxb/EkDkyE8fD6B5hJmT9PeOp5xY=;
 b=Y8DvHY21yTLZU+qwjSzqBWhfjFnoz/SAi6d/c0gOjtbHowCP1R4rKQjFnls2II1Zaj
 0515Jek73rz0RmVMtkakGi5sJ+V9zO+JYxwmGjQLOGUSk1YpbxMw9L+gFyZ3yQs2BF4v
 PKzd8IZnKXXmm6eLTurlSNZktvqY3TMwYwRQANK6qEzE6t67Yppze+w3OZtnsIlz40NK
 sOEYHyR6Qml7mp9nSEOd4fTXRvgEUhaaJlt27F/tqksm3ylIbP3/qC9A4B+FMiLyUeSx
 zXJMqnPQRa9KIOzjz1/Zg1BjliiBE8PRlrLZ80ntUT6x9Crdltb/A0FtehWvvqCPARI/
 ZNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770010902; x=1770615702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+iDOixNWGXe//eYSxb/EkDkyE8fD6B5hJmT9PeOp5xY=;
 b=W7/CwHwFWJZU87Lnhqj/b8h6TjzP6NnAUrHw0kP6cL0h6UWZBqYVeXmn/QbEgeQe2F
 jt/VVC9VCyQ8m0PSY6TnOqC6gGljh8lUJcPwT/mJkwYj17yPVWd4AHNW2pzWaITYPSqG
 xG9ZDC0MLrnfV9HbB2HitM5M9kjIS4Taa276rw3rh8phi2VARK3EIgxXhDaQuSDgBqvX
 o/1pCWxl0KVSDEln8p7MSa+35I7g9y0PTicY5wrI3sWHvywTSTc+RqffvfenfgP1yKkU
 iiUJWPUYSgVbpS94kyikMwh+Emaeg0SzSyNSnsM+51bpQ3hizSyOMgMl0YnF7jYjSygj
 4t3g==
X-Gm-Message-State: AOJu0YzCKy8t1t6u6y4CiV7ZcLq936e0Mcqp62f8t6jTQafpGJ/Kg3w0
 OfWkUGtLJ8ZI23SByyblZmasG7Ot/8GqkI9gSNFKn45QvKgby1EL0qo/avt63w==
X-Gm-Gg: AZuq6aLG5WPeNCRLab9nx4mPLRE/8KASfUqYJWRPyFhZ7+ojCH/9ZD2hqMiNNoyMGnU
 RDgUOJEROP8okl3kZ41nXUolYWmdbKhEm8uTQ43rAkayM6jJOKgUGh7Rcd/sw8eJwkVYgFIFaSL
 7UFGVLxkM18/xZCH+4PoYxuGiqBjb7kufTcH7HQFMM5i+edAbKvC0od94vyIP8rTnPhSUCxXPKH
 8cH7IvOTfmvZlFz+HbRBiQskjtLV3lewq0aGFr3gP9uesCYDzFFL5y9QbIU9utwU9YHFC0OA1Dl
 sc95CIpR5Hwnkpa+fU+oos/lBMdbcMMNk3PwQfo9oNqVpccLr8D+Jom6Co97mwr2Hrgj4Mq2aew
 m/rSLlYDRCvgHB57UR7y27l94Dvr7hRALPu4OboGi9t8+0U0s/bxOazJc9l48mC0GJDazr8vL5C
 leduKDt+p/DyTxpw==
X-Received: by 2002:a17:903:3b51:b0:2a7:80bf:3131 with SMTP id
 d9443c01a7336-2a8d9a7b928mr72828965ad.58.1770010901607; 
 Sun, 01 Feb 2026 21:41:41 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f610266esm17804018a91.4.2026.02.01.21.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 21:41:41 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, jeuk20.kim@samsung.com,
 qemu-block@nongnu.org, j-young.choi@samsung.com,
 Ilia Levi <ilia.levi@intel.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL v2 4/4] tests/qtest/ufs-test: Add test for mcq completion queue
 wraparound
Date: Mon,  2 Feb 2026 14:41:14 +0900
Message-ID: <94e72135d4d657d672561b1ae02a5854421616a7.1770010668.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770010668.git.jeuk20.kim@samsung.com>
References: <cover.1770010668.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x633.google.com
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
index 8cfdc41d3c..7f99944155 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -167,6 +167,7 @@ __ufs_send_transfer_request_mcq(QUfs *ufs, uint8_t lun,
     cqhp = ufs_rreg(ufs, ufs->cqdao[TEST_QID]);
     cqentry_addr = ufs->cqlba[TEST_QID] + cqhp;
     qtest_memread(ufs->dev.bus->qts, cqentry_addr, &cqentry, sizeof(cqentry));
+    cqhp = (cqhp + sizeof(UfsCqEntry)) % (QUEUE_SIZE * sizeof(UfsCqEntry));
     ufs_wreg(ufs, ufs->cqdao[TEST_QID], cqhp);
 
     return cqentry.status;
@@ -209,6 +210,81 @@ static enum UtpOcsCodes ufs_send_nop_out(QUfs *ufs, UtpUpiuRsp *rsp_out)
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
@@ -417,6 +493,7 @@ static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
     ufs_wreg(ufs, A_UTRIACR, 0);
 
     /* Enable transfer request */
+    bitmap_zero(ufs->cmd_desc_bitmap, UFS_MAX_CMD_DESC);
     ufs->cmd_desc_addr =
         guest_alloc(alloc, UFS_MAX_CMD_DESC * UTP_COMMAND_DESCRIPTOR_SIZE);
     ufs->data_buffer_addr =
@@ -680,6 +757,53 @@ static void ufstest_read_write(void *obj, void *data, QGuestAllocator *alloc)
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
@@ -1130,6 +1254,8 @@ static void ufs_register_nodes(void)
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


