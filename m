Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1A8606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=frtANdKg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKDbw-0006sE-S6; Fri, 23 Oct 2026 07:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3SEfbagoKCqETUBOMFZKIVHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--stanleyjhu.bounces.google.com>)
 id 1xKDbq-0006rV-Nr
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:38:54 -0400
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3SEfbagoKCqETUBOMFZKIVHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--stanleyjhu.bounces.google.com>)
 id 1xKDbm-00067r-VB
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:38:54 -0400
Received: by mail-pl1-x648.google.com with SMTP id
 d9443c01a7336-2e869e00005so11073405ad.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 04:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792755529; x=1793360329; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CTxpWcZ4h9MzrKvwWi+mBF3rXu3yDaaVAhrrQWWXTvc=;
 b=frtANdKguJGqrPlvoyErgjcoPWPFlNlS0hFPm2eiY6maIV/9TAswwmGa6Qfsq2YF8D
 yydQQU8AYwM5J8ksmQMfBIuerLx6r2w4hDQx7suwgWlorisJ57lJdGYYml0FWOegP40O
 Ii09ZKQGA3OrIrIsoGottsC0Lv7zCDpD23kQN/XFOK+vKvo+vW7AaWhfPo9bn2WE9Xi5
 HQCBu+RTWoUdupPxM0/waRaZwAeUzCqWcUTDvyQBXYmZ7b099BTgBE7eF6+S/rR15MpX
 mVUNFYBe6NvaVM7Brkk663aurTpea3D9gwd9AgZmUWn1a5k/K8tM3aTCOUyzpuyZJHJe
 A+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792755529; x=1793360329;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CTxpWcZ4h9MzrKvwWi+mBF3rXu3yDaaVAhrrQWWXTvc=;
 b=F+OkWx2eIT1bOBop+K1cvmj1Bfkp1Xk5d7bI+Jn1NtHMBVzm+TpKmJVKGedl4Jxads
 LdrR1eTmNe4j3P/gzGpIWbZpBvBB8xV2dNvJalAOOc0k/aTSzp4XOs1yE5Xfndm4C8vH
 IFohtCatFncl/qDdaFLSiePRaysBjj1XSqI2zVPC+1sZ8S7sfyNexYap3Wrlrtioc7gD
 Un5/+9qU/tA8kKJuxz5tppmK/JDtAEDhXAGswyyu72g7BKSwLWJhp2VWatmqbObp2fU5
 uHSEm3ui0+u5FZ/izeHCHn+YLbwizdJq07JL/joAGnlZdPziHPEAChPir9bFNnh+NtY0
 3zXg==
X-Gm-Message-State: AFq9FYJdnO1QG3Ne9y90tEV0gPi9lgAzkMvmAvv/YGmlUbPlk8rfv9xR
 2sj7zVw5fN9R8kcHymNIqOAO9eWcBjyvWcle1oxF/E6YxO8+wAWl5wU9D5r2InmUaI6+hNeSmOO
 ow0NXZrrZXPhT/ZYuVQDoFA==
X-Received: from plkz2.prod.google.com ([2002:a17:902:7082:b0:2e9:5f35:6dbc])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e790:b0:2e8:3190:73a with SMTP id
 d9443c01a7336-2ea7cf58102mr20290485ad.58.1792755528473; 
 Fri, 23 Oct 2026 04:38:48 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:38:30 +0800
In-Reply-To: <20261023113830.3368902-1-stanleyjhu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261023113830.3368902-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023113830.3368902-9-stanleyjhu@google.com>
Subject: [PATCH v3 8/8] tests/qtest/ufs-test: Add QOM fault injection task
 abort test
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::648;
 envelope-from=3SEfbagoKCqETUBOMFZKIVHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--stanleyjhu.bounces.google.com;
 helo=mail-pl1-x648.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_PDS_OTHER_BAD_TLD,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add ufs_test_fault_injection_abort() to validate runtime QOM fault
injection modes via x-fault-inject-tag and x-fault-inject-mode
(abort-success with held-request tag overwrite rejection, two-stage
UFS_ABORT_TASK + SQRTC.ICU and LUN matching, in-transition completion,
timeout with UTMRLCLR clear-on-zero verification, abort-failed
rejection, and ssu-timeout WLUN START_STOP filtering).

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 tests/qtest/ufs-test.c | 681 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 680 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 8a3c2c13c3..d8f7f502d6 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -1928,7 +1928,7 @@ static void ufs_send_tmr(QUfs *ufs, uint64_t utmrlba, int slot,
     qtest_memread(ufs->dev.bus->qts, desc_addr, utrd_out, sizeof(*utrd_out));
 }
 
-static G_GNUC_UNUSED int ufs_mcq_send_scsi_cmd_async(QUfs *ufs, uint8_t lun,
+static int ufs_mcq_send_scsi_cmd_async(QUfs *ufs, uint8_t lun,
                                        const uint8_t *cdb)
 {
     int cmd_desc_slot = alloc_cmd_desc_slot(ufs);
@@ -1951,6 +1951,66 @@ static G_GNUC_UNUSED int ufs_mcq_send_scsi_cmd_async(QUfs *ufs, uint8_t lun,
     return cmd_desc_slot;
 }
 
+static int ufs_mcq_send_write_async(QUfs *ufs, uint8_t lun,
+                                    const uint8_t *cdb,
+                                    const uint8_t *data_in,
+                                    size_t data_in_len)
+{
+    QTestState *qts = ufs->dev.bus->qts;
+    int cmd_desc_slot = alloc_cmd_desc_slot(ufs);
+    uint64_t req_upiu_addr =
+        ufs->cmd_desc_addr + cmd_desc_slot * UTP_COMMAND_DESCRIPTOR_SIZE;
+    UfshcdSgEntry entry = { 0 };
+    UtpUpiuReq req_upiu = { 0 };
+    UtpTransferReqDesc utrd;
+
+    g_assert_true(ufs->support_mcq);
+    g_assert_cmpuint(data_in_len, <=, PRD_ENTRY_DATA_SIZE);
+    qtest_memwrite(qts, ufs->data_buffer_addr, data_in, data_in_len);
+    entry.addr = cpu_to_le64(ufs->data_buffer_addr);
+    entry.size = cpu_to_le32(data_in_len - 1);
+    qtest_memwrite(qts, req_upiu_addr + UTP_PRDT_UPIU_OFFSET, &entry,
+                   sizeof(entry));
+
+    req_upiu.header.trans_type = UFS_UPIU_TRANSACTION_COMMAND;
+    req_upiu.header.flags = UFS_UPIU_CMD_FLAGS_WRITE;
+    req_upiu.header.lun = lun;
+    req_upiu.header.task_tag = cmd_desc_slot;
+    req_upiu.sc.exp_data_transfer_len = cpu_to_be32(data_in_len);
+    memcpy(req_upiu.sc.cdb, cdb, UFS_CDB_SIZE);
+    qtest_memwrite(qts, req_upiu_addr, &req_upiu, sizeof(req_upiu));
+
+    utrd = ufs_build_req_utrd(req_upiu_addr, UFS_UTP_HOST_TO_DEVICE, 1);
+    __ufs_send_transfer_request_mcq_async(ufs, lun, &utrd);
+    return cmd_desc_slot;
+}
+
+static int ufs_send_scsi_cmd_doorbell_async(QUfs *ufs, uint8_t lun,
+                                            const uint8_t *cdb)
+{
+    int cmd_desc_slot = alloc_cmd_desc_slot(ufs);
+    uint64_t req_upiu_addr =
+        ufs->cmd_desc_addr + cmd_desc_slot * UTP_COMMAND_DESCRIPTOR_SIZE;
+    uint64_t utrd_addr =
+        ufs->utrlba + cmd_desc_slot * sizeof(UtpTransferReqDesc);
+    UtpUpiuReq req_upiu = { 0 };
+    UtpTransferReqDesc utrd;
+
+    req_upiu.header.trans_type = UFS_UPIU_TRANSACTION_COMMAND;
+    req_upiu.header.flags = UFS_UPIU_CMD_FLAGS_NONE;
+    req_upiu.header.lun = lun;
+    req_upiu.header.task_tag = cmd_desc_slot;
+    memcpy(req_upiu.sc.cdb, cdb, UFS_CDB_SIZE);
+    qtest_memwrite(ufs->dev.bus->qts, req_upiu_addr, &req_upiu,
+                   sizeof(req_upiu));
+
+    utrd = ufs_build_req_utrd(req_upiu_addr, UFS_UTP_NO_DATA_TRANSFER, 0);
+    qtest_memwrite(ufs->dev.bus->qts, utrd_addr, &utrd, sizeof(utrd));
+
+    ufs_wreg(ufs, A_UTRLDBR, 1 << cmd_desc_slot);
+    return cmd_desc_slot;
+}
+
 
 static void ufs_test_hce_reset(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -2188,6 +2248,621 @@ static void ufs_test_tmr_handling(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
+#define UFS_FAULT_INJECT_TAG_NONE 0xffffffffU
+#define UFS_FAULT_INJECT_TAG_ANY  0xfffffffeU
+
+static void ufs_test_fault_injection_abort(void *obj, void *data,
+                                           QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    QTestState *qts = ufs->dev.bus->qts;
+    uint64_t utmrlba, desc_addr;
+    UtpTaskReqDesc utrd, utrd_result;
+    const uint8_t test_unit_ready_cdb[UFS_CDB_SIZE] = { TEST_UNIT_READY };
+    const uint8_t read10_lba512_cdb[UFS_CDB_SIZE] = {
+        READ_10, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00
+    };
+    const uint8_t start_stop_cdb[UFS_CDB_SIZE] = { START_STOP };
+    const uint8_t request_sense_cdb[UFS_CDB_SIZE] = { REQUEST_SENSE };
+    const uint8_t write10_cdb[UFS_CDB_SIZE] = {
+        WRITE_10, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x01, 0x00
+    };
+    const uint8_t read10_cdb[UFS_CDB_SIZE] = {
+        READ_10, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x01, 0x00
+    };
+    const uint8_t read10_lba0_cdb[UFS_CDB_SIZE] = {
+        READ_10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+    };
+    const uint8_t read16_lba0_cdb[UFS_CDB_SIZE] = {
+        READ_16, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+    };
+    const uint8_t read16_lba512_cdb[UFS_CDB_SIZE] = {
+        READ_16, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+    };
+    uint8_t write_buf[4096];
+    uint8_t read_buf[4096];
+    UtpUpiuRsp read_rsp;
+    enum UtpOcsCodes ocs;
+    uint32_t sqdao, cqdao, mcq_reg_offset, cqisao, sqrts, cqhp, cqtp;
+    UfsCqEntry cqe;
+    int slot;
+    QDict *rsp;
+
+    ufs_init(ufs, alloc);
+    g_assert_true(ufs->support_mcq);
+
+    utmrlba = guest_alloc(alloc, 8 * sizeof(UtpTaskReqDesc));
+    ufs_wreg(ufs, A_UTMRLBA, utmrlba & 0xffffffff);
+    ufs_wreg(ufs, A_UTMRLBAU, utmrlba >> 32);
+    ufs_wreg(ufs, A_UTMRLRSR, 1);
+
+    sqdao = ufs->sqdao[TEST_QID];
+    cqdao = ufs->cqdao[TEST_QID];
+    mcq_reg_offset =
+        FIELD_EX32(ufs_rreg(ufs, A_MCQCAP), MCQCAP, QCFGPTR) * 0x200 +
+        TEST_QID * 0x40;
+    cqisao = ufs_rreg(ufs, mcq_reg_offset + A_CQISAO);
+
+    /*
+     * Case 1: x-fault-inject-mode = abort-success (two-stage MCQ abort +
+     * SQRTC.ICU).
+     */
+    slot = find_first_zero_bit(ufs->cmd_desc_bitmap, UFS_MAX_CMD_DESC);
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-mode', 'value': 'abort-success' } }");
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-tag', 'value': %d } }", slot);
+
+    slot = ufs_mcq_send_scsi_cmd_async(ufs, 0, test_unit_ready_cdb);
+    qtest_clock_step(qts, 100);
+
+    /* Issue UFS_QUERY_TASK -> assert Target Success & SUCCEEDED (0x08) */
+    ufs_send_tmr(ufs, utmrlba, 0, UFS_QUERY_TASK, 0, slot, &utrd_result);
+    g_assert_cmpuint(utrd_result.upiu_rsp.rsp_header.response,
+                     ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(be32_to_cpu(utrd_result.upiu_rsp.output_param1),
+                     ==, UFS_UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED);
+
+    /* Verify x-fault-inject-tag cannot be overwritten while a req is held */
+    rsp = qtest_qmp(qts,
+                    "{ 'execute': 'qom-set', 'arguments': { "
+                    "'path': '/machine/peripheral/ufs0', "
+                    "'property': 'x-fault-inject-tag', 'value': 7 } }");
+    g_assert_true(qdict_haskey(rsp, "error"));
+    qobject_unref(rsp);
+
+    /* Issue UFS_ABORT_TASK -> assert COMPL (0x00) and tag cleared */
+    ufs_send_tmr(ufs, utmrlba, 0, UFS_ABORT_TASK, 0, slot, &utrd_result);
+    g_assert_cmpuint(utrd_result.upiu_rsp.rsp_header.response,
+                     ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(be32_to_cpu(utrd_result.upiu_rsp.output_param1),
+                     ==, UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL);
+
+    rsp = qtest_qmp(
+        qts,
+        "{ 'execute': 'qom-get', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-tag' } }");
+    g_assert_cmpuint(qdict_get_int(rsp, "return"), ==,
+                     UFS_FAULT_INJECT_TAG_NONE);
+    qobject_unref(rsp);
+
+    /*
+     * UFS_ABORT_TASK alone must NOT post a CQE
+     * before SQRTC.ICU is issued.
+     */
+    cqhp = ufs_rreg(ufs, cqdao);
+    cqtp = ufs_rreg(ufs, cqdao + 0x4);
+    g_assert_cmpuint(cqtp, ==, cqhp);
+
+    /* Stop SQ and test SQRTC.ICU with a mismatched LUN (lun=1 vs lun=0) */
+    ufs_wreg(ufs, sqdao + A_SQRTC, FIELD_DP32(0, SQRTC, STOP, 1));
+    sqrts = ufs_rreg(ufs, sqdao + A_SQRTS);
+    g_assert_cmpuint(FIELD_EX32(sqrts, SQRTS, STS), ==, 1);
+
+    ufs_wreg(ufs, sqdao + A_SQCTI, (1 << 8) | slot);
+    ufs_wreg(ufs, sqdao + A_SQRTC,
+             FIELD_DP32(0, SQRTC, STOP, 1) | FIELD_DP32(0, SQRTC, ICU, 1));
+    sqrts = ufs_rreg(ufs, sqdao + A_SQRTS);
+    g_assert_cmpuint(FIELD_EX32(sqrts, SQRTS, CUS), ==, 1);
+    g_assert_cmpuint(FIELD_EX32(sqrts, SQRTS, RTC), ==, 1);
+    g_assert_cmpuint(ufs_rreg(ufs, cqdao + 0x4), ==, cqhp);
+
+    /* Issue SQRTC.ICU with matching SQCTI (lun=0) -> posts ABORTED CQE */
+    ufs_wreg(ufs, sqdao + A_SQCTI, (0 << 8) | slot);
+    ufs_wreg(ufs, sqdao + A_SQRTC,
+             FIELD_DP32(0, SQRTC, STOP, 1) | FIELD_DP32(0, SQRTC, ICU, 1));
+    sqrts = ufs_rreg(ufs, sqdao + A_SQRTS);
+    g_assert_cmpuint(FIELD_EX32(sqrts, SQRTS, CUS), ==, 1);
+    g_assert_cmpuint(FIELD_EX32(sqrts, SQRTS, RTC), ==, 0);
+
+    cqtp = ufs_rreg(ufs, cqdao + 0x4);
+    g_assert_cmpuint(cqtp, !=, cqhp);
+    qtest_memread(qts, ufs->cqlba[TEST_QID] + cqhp, &cqe, sizeof(cqe));
+    g_assert_cmpuint(cqe.status, ==, UFS_OCS_ABORTED);
+    g_assert_cmpuint(cqe.task_tag, ==, slot);
+    ufs_wreg(ufs, cqdao, cqtp);
+    ufs_wreg(ufs, cqisao + A_CQIS, FIELD_DP32(0, CQIS, TEPS, 1));
+    ufs_wreg(ufs, A_IS, FIELD_DP32(0, IS, CQES, 1));
+    ufs_wreg(ufs, sqdao + A_SQRTC, 0);
+    release_cmd_desc_slot(ufs, slot);
+
+    /*
+     * Direct SQRTC.ICU without prior UFS_ABORT_TASK:
+     * ufs_fault_inject_sq_cleanup() must clear held_req and active tag.
+     */
+    slot = find_first_zero_bit(ufs->cmd_desc_bitmap, UFS_MAX_CMD_DESC);
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-mode', 'value': 'abort-success' } }");
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-tag', 'value': %d } }", slot);
+
+    cqhp = ufs_rreg(ufs, cqdao);
+    slot = ufs_mcq_send_scsi_cmd_async(ufs, 0, test_unit_ready_cdb);
+    qtest_clock_step(qts, 100);
+
+    /* Abort directly via SQRTC.ICU */
+    ufs_wreg(ufs, sqdao + A_SQRTC, FIELD_DP32(0, SQRTC, STOP, 1));
+    ufs_wreg(ufs, sqdao + A_SQCTI, (0 << 8) | slot);
+    ufs_wreg(ufs, sqdao + A_SQRTC,
+             FIELD_DP32(0, SQRTC, STOP, 1) | FIELD_DP32(0, SQRTC, ICU, 1));
+    sqrts = ufs_rreg(ufs, sqdao + A_SQRTS);
+    g_assert_cmpuint(FIELD_EX32(sqrts, SQRTS, CUS), ==, 1);
+    g_assert_cmpuint(FIELD_EX32(sqrts, SQRTS, RTC), ==, 0);
+
+    /* Verify ufs_fault_inject_sq_cleanup cleared the held request */
+    rsp = qtest_qmp(
+        qts,
+        "{ 'execute': 'qom-get', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-tag' } }");
+    g_assert_cmpuint(qdict_get_int(rsp, "return"), ==,
+                     UFS_FAULT_INJECT_TAG_NONE);
+    qobject_unref(rsp);
+
+    /* Verify setting tag now succeeds (not blocked by held_req) */
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-tag', 'value': 7 } }");
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-tag', 'value': %u } }",
+        UFS_FAULT_INJECT_TAG_NONE);
+
+    cqtp = ufs_rreg(ufs, cqdao + 0x4);
+    ufs_wreg(ufs, cqdao, cqtp);
+    ufs_wreg(ufs, cqisao + A_CQIS, FIELD_DP32(0, CQIS, TEPS, 1));
+    ufs_wreg(ufs, A_IS, FIELD_DP32(0, IS, CQES, 1));
+    ufs_wreg(ufs, sqdao + A_SQRTC, 0);
+    release_cmd_desc_slot(ufs, slot);
+
+    /*
+     * Case 2: x-fault-inject-mode = in-transition.
+     * WRITE a pattern while held -> QUERY TASK (in-transition) releases
+     * and really executes the request -> READ back shows the pattern.
+     */
+    memset(write_buf, 0x5a, sizeof(write_buf));
+    memset(read_buf, 0, sizeof(read_buf));
+
+    /* Clear Unit Attention on LUN 1 before I/O */
+    ufs_send_scsi_command(ufs, 1, request_sense_cdb, NULL, 0, read_buf,
+                          sizeof(read_buf), &read_rsp);
+
+    slot = find_first_zero_bit(ufs->cmd_desc_bitmap, UFS_MAX_CMD_DESC);
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-mode', 'value': 'in-transition' } }");
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-tag', 'value': %d } }", slot);
+
+    cqhp = ufs_rreg(ufs, cqdao);
+    slot = ufs_mcq_send_write_async(ufs, 1, write10_cdb, write_buf,
+                                    sizeof(write_buf));
+    qtest_clock_step(qts, 100);
+
+    /* Command is held; no CQE posted yet */
+    g_assert_cmpuint(ufs_rreg(ufs, cqdao + 0x4), ==, cqhp);
+
+    /* QUERY TASK releases the held request and lets it actually execute */
+    ufs_send_tmr(ufs, utmrlba, 0, UFS_QUERY_TASK, 1, slot, &utrd_result);
+    g_assert_cmpuint(utrd_result.upiu_rsp.rsp_header.response,
+                     ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(be32_to_cpu(utrd_result.upiu_rsp.output_param1),
+                     ==, UFS_UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED);
+
+    /* Wait for the released request to finish and post its CQE */
+    ufs_wait_for_irq(ufs);
+    g_assert_true(FIELD_EX32(ufs_rreg(ufs, A_IS), IS, CQES));
+
+    /* Verify completion CQE was posted with real status (SUCCESS) */
+    cqtp = ufs_rreg(ufs, cqdao + 0x4);
+    g_assert_cmpuint(cqtp, !=, cqhp);
+    qtest_memread(qts, ufs->cqlba[TEST_QID] + cqhp, &cqe, sizeof(cqe));
+    g_assert_cmpuint(cqe.status, ==, UFS_OCS_SUCCESS);
+    ufs_wreg(ufs, cqdao, cqtp);
+    ufs_wreg(ufs, cqisao + A_CQIS, FIELD_DP32(0, CQIS, TEPS, 1));
+    ufs_wreg(ufs, A_IS, FIELD_DP32(0, IS, CQES, 1));
+    release_cmd_desc_slot(ufs, slot);
+
+    /* READ back LBA 512 and verify the pattern actually reached the LU */
+    ocs = ufs_send_scsi_command(ufs, 1, read10_cdb, NULL, 0, read_buf,
+                                sizeof(read_buf), &read_rsp);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpmem(read_buf, sizeof(read_buf), write_buf, sizeof(write_buf));
+
+    /*
+     * Case 3: x-fault-inject-mode = timeout + A_UTMRLCLR clear-on-zero.
+     * UFS_ABORT_TASK times out, leaving UTMRLDBR bit 2 set.
+     *
+     * UFSHCI defines UTMRLCLR as write-0-to-clear: writing 0 to a bit clears
+     * that slot in UTMRLDBR, writing 1 leaves it unchanged.
+     */
+    slot = find_first_zero_bit(ufs->cmd_desc_bitmap, UFS_MAX_CMD_DESC);
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-mode', 'value': 'timeout' } }");
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-tag', 'value': %d } }", slot);
+
+    slot = ufs_mcq_send_scsi_cmd_async(ufs, 0, test_unit_ready_cdb);
+    qtest_clock_step(qts, 100);
+
+    memset(&utrd, 0, sizeof(utrd));
+    utrd.header.dword_0 = cpu_to_le32(UFS_UTP_REQ_DESC_INT_CMD);
+    utrd.header.dword_2 = cpu_to_le32(UFS_OCS_INVALID_COMMAND_STATUS);
+    utrd.upiu_req.req_header.trans_type = UFS_UPIU_TRANSACTION_TASK_REQ;
+    utrd.upiu_req.req_header.query_func = UFS_ABORT_TASK;
+    utrd.upiu_req.req_header.lun = 0;
+    utrd.upiu_req.req_header.task_tag = 2;
+    utrd.upiu_req.input_param1 = cpu_to_be32(0);
+    utrd.upiu_req.input_param2 = cpu_to_be32(slot);
+    desc_addr = utmrlba + 2 * sizeof(UtpTaskReqDesc);
+    qtest_memwrite(qts, desc_addr, &utrd, sizeof(utrd));
+
+    ufs_wreg(ufs, A_UTMRLDBR, 1 << 2);
+    g_assert_cmpuint(ufs_rreg(ufs, A_UTMRLDBR) & (1 << 2), ==, 1 << 2);
+
+    /*
+     * Writing 1s to A_UTMRLCLR indicates no change per UFSHCI spec,
+     * so it must NOT clear UTMRLDBR bit 2.
+     */
+    ufs_wreg(ufs, A_UTMRLCLR, 0xffffffffU);
+    g_assert_cmpuint(ufs_rreg(ufs, A_UTMRLDBR) & (1 << 2), ==, 1 << 2);
+
+    /*
+     * Writing 0 at bit 2 (~(1 << 2)) to A_UTMRLCLR indicates slot cleared,
+     * so it MUST clear bit 2.
+     */
+    ufs_wreg(ufs, A_UTMRLCLR, ~(1U << 2));
+    g_assert_cmpuint(ufs_rreg(ufs, A_UTMRLDBR) & (1 << 2), ==, 0);
+
+    ufs_wreg(ufs, A_HCE, 0);
+    release_cmd_desc_slot(ufs, slot);
+    ufs_exit(ufs, alloc);
+    ufs_init(ufs, alloc);
+    ufs_wreg(ufs, A_UTMRLBA, utmrlba & 0xffffffff);
+    ufs_wreg(ufs, A_UTMRLBAU, utmrlba >> 32);
+    ufs_wreg(ufs, A_UTMRLRSR, 1);
+
+    /*
+     * Case 4: x-fault-inject-mode = abort-failed.
+     */
+    slot = find_first_zero_bit(ufs->cmd_desc_bitmap, UFS_MAX_CMD_DESC);
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-mode', 'value': 'abort-failed' } }");
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-tag', 'value': %d } }", slot);
+
+    slot = ufs_mcq_send_scsi_cmd_async(ufs, 0, test_unit_ready_cdb);
+    qtest_clock_step(qts, 100);
+
+    /* Issue UFS_QUERY_TASK -> assert Target Success & SUCCEEDED (0x08) */
+    ufs_send_tmr(ufs, utmrlba, 0, UFS_QUERY_TASK, 0, slot, &utrd_result);
+    g_assert_cmpuint(utrd_result.upiu_rsp.rsp_header.response,
+                     ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(be32_to_cpu(utrd_result.upiu_rsp.output_param1),
+                     ==, UFS_UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED);
+
+    /* Issue UFS_ABORT_TASK -> assert Target Failure & FAILED (0x05) */
+    ufs_send_tmr(ufs, utmrlba, 0, UFS_ABORT_TASK, 0, slot, &utrd_result);
+    g_assert_cmpuint(utrd_result.upiu_rsp.rsp_header.response,
+                     ==, UFS_COMMAND_RESULT_FAIL);
+    g_assert_cmpuint(be32_to_cpu(utrd_result.upiu_rsp.output_param1),
+                     ==, UFS_UPIU_TASK_MANAGEMENT_FUNC_FAILED);
+
+    /* Reset controller to clear held request cleanly */
+    ufs_wreg(ufs, A_HCE, 0);
+    release_cmd_desc_slot(ufs, slot);
+    ufs_exit(ufs, alloc);
+    ufs_init(ufs, alloc);
+    ufs_wreg(ufs, A_UTMRLBA, utmrlba & 0xffffffff);
+    ufs_wreg(ufs, A_UTMRLBAU, utmrlba >> 32);
+    ufs_wreg(ufs, A_UTMRLRSR, 1);
+
+    /*
+     * Case 5: x-fault-inject-mode = ssu-timeout.
+     * Non-SSU commands on LU 0 complete normally even with a matching
+     * specific tag or UFS_FAULT_INJECT_TAG_ANY, whereas START_STOP to
+     * UFS_UPIU_UFS_DEVICE_WLUN is held.
+     */
+    slot = find_first_zero_bit(ufs->cmd_desc_bitmap, UFS_MAX_CMD_DESC);
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-mode', 'value': 'ssu-timeout' } }");
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-tag', 'value': %d } }", slot);
+
+    cqhp = ufs_rreg(ufs, cqdao);
+    slot = ufs_mcq_send_scsi_cmd_async(ufs, 0, test_unit_ready_cdb);
+    qtest_clock_step(qts, 100);
+    cqtp = ufs_rreg(ufs, cqdao + 0x4);
+    g_assert_cmpuint(cqtp, !=, cqhp);
+    qtest_memread(qts, ufs->cqlba[TEST_QID] + cqhp, &cqe, sizeof(cqe));
+    g_assert_cmpuint(cqe.status, ==, UFS_OCS_SUCCESS);
+    ufs_wreg(ufs, cqdao, cqtp);
+    ufs_wreg(ufs, cqisao + A_CQIS, FIELD_DP32(0, CQIS, TEPS, 1));
+    ufs_wreg(ufs, A_IS, FIELD_DP32(0, IS, CQES, 1));
+    release_cmd_desc_slot(ufs, slot);
+
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-tag', 'value': %u } }",
+        UFS_FAULT_INJECT_TAG_ANY);
+
+    cqhp = ufs_rreg(ufs, cqdao);
+    slot = ufs_mcq_send_scsi_cmd_async(ufs, 0, read10_lba512_cdb);
+    qtest_clock_step(qts, 100);
+    cqtp = ufs_rreg(ufs, cqdao + 0x4);
+    g_assert_cmpuint(cqtp, !=, cqhp);
+    qtest_memread(qts, ufs->cqlba[TEST_QID] + cqhp, &cqe, sizeof(cqe));
+    g_assert_cmpuint(cqe.status, ==, UFS_OCS_SUCCESS);
+    ufs_wreg(ufs, cqdao, cqtp);
+    ufs_wreg(ufs, cqisao + A_CQIS, FIELD_DP32(0, CQIS, TEPS, 1));
+    ufs_wreg(ufs, A_IS, FIELD_DP32(0, IS, CQES, 1));
+    release_cmd_desc_slot(ufs, slot);
+
+    cqhp = ufs_rreg(ufs, cqdao);
+    slot = ufs_mcq_send_scsi_cmd_async(ufs, UFS_UPIU_UFS_DEVICE_WLUN,
+                                       start_stop_cdb);
+    qtest_clock_step(qts, 100);
+    cqtp = ufs_rreg(ufs, cqdao + 0x4);
+    g_assert_cmpuint(cqtp, ==, cqhp);
+
+    ufs_send_tmr(ufs, utmrlba, 0, UFS_QUERY_TASK, UFS_UPIU_UFS_DEVICE_WLUN,
+                 slot, &utrd_result);
+    g_assert_cmpuint(utrd_result.upiu_rsp.rsp_header.response,
+                     ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(be32_to_cpu(utrd_result.upiu_rsp.output_param1),
+                     ==, UFS_UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED);
+
+    ufs_wreg(ufs, A_HCE, 0);
+    release_cmd_desc_slot(ufs, slot);
+    ufs_exit(ufs, alloc);
+    ufs_init(ufs, alloc);
+    ufs_wreg(ufs, A_UTMRLBA, utmrlba & 0xffffffff);
+    ufs_wreg(ufs, A_UTMRLBAU, utmrlba >> 32);
+    ufs_wreg(ufs, A_UTMRLRSR, 1);
+
+    /*
+     * Case 6: x-fault-inject-tag = ANY with READ_10 and READ_16.
+     * Commands with LBA < 512 must complete normally (not held).
+     * Commands with LBA >= 512 must be held.
+     */
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-mode', 'value': 'abort-success' } }");
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-tag', 'value': %u } }",
+        UFS_FAULT_INJECT_TAG_ANY);
+
+    /* (a) READ_10 LBA 0 (< 512) -> completes normally, NOT held */
+    cqhp = ufs_rreg(ufs, cqdao);
+    slot = ufs_mcq_send_scsi_cmd_async(ufs, 0, read10_lba0_cdb);
+    qtest_clock_step(qts, 100);
+    cqtp = ufs_rreg(ufs, cqdao + 0x4);
+    g_assert_cmpuint(cqtp, !=, cqhp);
+    qtest_memread(qts, ufs->cqlba[TEST_QID] + cqhp, &cqe, sizeof(cqe));
+    g_assert_cmpuint(cqe.status, ==, UFS_OCS_SUCCESS);
+    ufs_wreg(ufs, cqdao, cqtp);
+    ufs_wreg(ufs, cqisao + A_CQIS, FIELD_DP32(0, CQIS, TEPS, 1));
+    ufs_wreg(ufs, A_IS, FIELD_DP32(0, IS, CQES, 1));
+    release_cmd_desc_slot(ufs, slot);
+
+    rsp = qtest_qmp(
+        qts,
+        "{ 'execute': 'qom-get', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-tag' } }");
+    g_assert_cmpuint(qdict_get_int(rsp, "return"), ==,
+                     UFS_FAULT_INJECT_TAG_ANY);
+    qobject_unref(rsp);
+
+    /* (b) READ_10 LBA 512 (>= 512) -> HELD */
+    cqhp = ufs_rreg(ufs, cqdao);
+    slot = ufs_mcq_send_scsi_cmd_async(ufs, 0, read10_lba512_cdb);
+    qtest_clock_step(qts, 100);
+    g_assert_cmpuint(ufs_rreg(ufs, cqdao + 0x4), ==, cqhp);
+
+    rsp = qtest_qmp(
+        qts,
+        "{ 'execute': 'qom-get', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-tag' } }");
+    g_assert_cmpuint(qdict_get_int(rsp, "return"), ==, slot);
+    qobject_unref(rsp);
+
+    /* Abort the held READ_10 */
+    ufs_send_tmr(ufs, utmrlba, 0, UFS_ABORT_TASK, 0, slot, &utrd_result);
+    g_assert_cmpuint(utrd_result.upiu_rsp.rsp_header.response,
+                     ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(be32_to_cpu(utrd_result.upiu_rsp.output_param1),
+                     ==, UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL);
+    release_cmd_desc_slot(ufs, slot);
+
+    /* Re-arm ANY for 16-byte testing */
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-tag', 'value': %u } }",
+        UFS_FAULT_INJECT_TAG_ANY);
+
+    /* (c) READ_16 LBA 0 (< 512) -> completes normally, NOT held */
+    cqhp = ufs_rreg(ufs, cqdao);
+    slot = ufs_mcq_send_scsi_cmd_async(ufs, 0, read16_lba0_cdb);
+    qtest_clock_step(qts, 100);
+    cqtp = ufs_rreg(ufs, cqdao + 0x4);
+    g_assert_cmpuint(cqtp, !=, cqhp);
+    qtest_memread(qts, ufs->cqlba[TEST_QID] + cqhp, &cqe, sizeof(cqe));
+    g_assert_cmpuint(cqe.status, ==, UFS_OCS_SUCCESS);
+    ufs_wreg(ufs, cqdao, cqtp);
+    ufs_wreg(ufs, cqisao + A_CQIS, FIELD_DP32(0, CQIS, TEPS, 1));
+    ufs_wreg(ufs, A_IS, FIELD_DP32(0, IS, CQES, 1));
+    release_cmd_desc_slot(ufs, slot);
+
+    rsp = qtest_qmp(
+        qts,
+        "{ 'execute': 'qom-get', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-tag' } }");
+    g_assert_cmpuint(qdict_get_int(rsp, "return"), ==,
+                     UFS_FAULT_INJECT_TAG_ANY);
+    qobject_unref(rsp);
+
+    /* (d) READ_16 LBA 512 (>= 512) -> HELD */
+    cqhp = ufs_rreg(ufs, cqdao);
+    slot = ufs_mcq_send_scsi_cmd_async(ufs, 0, read16_lba512_cdb);
+    qtest_clock_step(qts, 100);
+    g_assert_cmpuint(ufs_rreg(ufs, cqdao + 0x4), ==, cqhp);
+
+    rsp = qtest_qmp(
+        qts,
+        "{ 'execute': 'qom-get', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-tag' } }");
+    g_assert_cmpuint(qdict_get_int(rsp, "return"), ==, slot);
+    qobject_unref(rsp);
+
+    /* Abort the held READ_16 */
+    ufs_send_tmr(ufs, utmrlba, 0, UFS_ABORT_TASK, 0, slot, &utrd_result);
+    g_assert_cmpuint(utrd_result.upiu_rsp.rsp_header.response,
+                     ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(be32_to_cpu(utrd_result.upiu_rsp.output_param1),
+                     ==, UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL);
+    release_cmd_desc_slot(ufs, slot);
+
+    ufs_wreg(ufs, A_HCE, 0);
+    guest_free(alloc, utmrlba);
+    ufs_exit(ufs, alloc);
+}
+
+static void ufs_test_fault_injection_legacy(void *obj, void *data,
+                                            QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    QTestState *qts = ufs->dev.bus->qts;
+    uint64_t utmrlba;
+    UtpTaskReqDesc utrd_result;
+    const uint8_t test_unit_ready_cdb[UFS_CDB_SIZE] = { TEST_UNIT_READY };
+    int slot;
+    QDict *rsp;
+
+    ufs_init(ufs, alloc);
+    g_assert_false(ufs->support_mcq);
+
+    utmrlba = guest_alloc(alloc, 8 * sizeof(UtpTaskReqDesc));
+    ufs_wreg(ufs, A_UTMRLBA, utmrlba & 0xffffffff);
+    ufs_wreg(ufs, A_UTMRLBAU, utmrlba >> 32);
+    ufs_wreg(ufs, A_UTMRLRSR, 1);
+
+    slot = find_first_zero_bit(ufs->cmd_desc_bitmap, UFS_MAX_CMD_DESC);
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-mode', 'value': 'abort-success' } }");
+    qtest_qmp_assert_success(
+        qts,
+        "{ 'execute': 'qom-set', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-tag', 'value': %d } }", slot);
+
+    slot = ufs_send_scsi_cmd_doorbell_async(ufs, 0, test_unit_ready_cdb);
+    qtest_clock_step(qts, 100);
+
+    /* Assert UTRLDBR bit is set while command is held */
+    g_assert_cmpuint(ufs_rreg(ufs, A_UTRLDBR) & (1 << slot), ==, 1 << slot);
+
+    /* Issue UFS_ABORT_TASK -> clears UTRLDBR bit and returns COMPL */
+    ufs_send_tmr(ufs, utmrlba, 0, UFS_ABORT_TASK, 0, slot, &utrd_result);
+    g_assert_cmpuint(utrd_result.upiu_rsp.rsp_header.response,
+                     ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(be32_to_cpu(utrd_result.upiu_rsp.output_param1),
+                     ==, UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL);
+
+    /* Verify UTRLDBR bit was cleared by the abort */
+    g_assert_cmpuint(ufs_rreg(ufs, A_UTRLDBR) & (1 << slot), ==, 0);
+
+    rsp = qtest_qmp(
+        qts,
+        "{ 'execute': 'qom-get', 'arguments': { "
+        "'path': '/machine/peripheral/ufs0', "
+        "'property': 'x-fault-inject-tag' } }");
+    g_assert_cmpuint(qdict_get_int(rsp, "return"), ==,
+                     UFS_FAULT_INJECT_TAG_NONE);
+    qobject_unref(rsp);
+
+    release_cmd_desc_slot(ufs, slot);
+    guest_free(alloc, utmrlba);
+    ufs_exit(ufs, alloc);
+}
+
 #define ZONE_SIZE (2 * 1024 * 1024)
 #define ZONE_BLOCKS (ZONE_SIZE / 4096)
 #define MAX_OPEN_ZONE 6
@@ -3368,6 +4043,10 @@ static void ufs_register_nodes(void)
                  &io_test_opts);
     qos_add_test("hce-reset", "ufs", ufs_test_hce_reset, &mcq_test_opts);
     qos_add_test("tmr-handling", "ufs", ufs_test_tmr_handling, &mcq_test_opts);
+    qos_add_test("fault-injection-abort", "ufs",
+                 ufs_test_fault_injection_abort, &mcq_test_opts);
+    qos_add_test("fault-injection-legacy", "ufs",
+                 ufs_test_fault_injection_legacy, &io_test_opts);
     qos_add_test("wb-init", "ufs", ufstest_wb_init, &wb_test_opts);
     qos_add_test("wb-read-write", "ufs", ufstest_wb_read_write, &wb_test_opts);
     qos_add_test("hid", "ufs", ufstest_hid, &io_test_opts);
-- 
2.56.0.307.g5fe7bd680c-goog


