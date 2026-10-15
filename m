Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D85CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHEeF-0004C4-Od; Thu, 15 Oct 2026 02:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <37G3QagoKCmcXYFSQJdOMZLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--stanleyjhu.bounces.google.com>)
 id 1xHEe1-0003rH-N7
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:08:51 -0400
Received: from mail-pf1-x446.google.com ([2607:f8b0:4864:20::446])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <37G3QagoKCmcXYFSQJdOMZLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--stanleyjhu.bounces.google.com>)
 id 1xHEdz-0004JB-8z
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:08:49 -0400
Received: by mail-pf1-x446.google.com with SMTP id
 d2e1a72fcca58-86fa6b15ed3so6916492b3a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792044525; x=1792649325; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zP0qzsPhZLXKeqQWLTl5oXfj3C4CySurGv2zGRO6nmw=;
 b=Pd/mzI0xWmASLEKQbEzuJHxc4lSrdaucL4RCLwEayHe5rcPILOdrNowlt680yu7+gc
 JW8AkHE3tlveMpLv36xHNA23NcCRjrP0fxaQiK/48ITHPhgBGG44e3dTT8+p2FCS1S8k
 78wN4JBmzXAMjfDIwHebab30WuZUremvIb3RI7npA6s+DS1F6EiVuL4RHxWo7E7ToLL9
 oGqasemclgzvk3vIXd7y0qQ7ujB8E8bFFaWGXCLF4KM0soi/I/CJKiW0Hx28Yl8lPmft
 MxNBuQbV/J0IuUGi/nLDKPzbRx/uHmIq+EzEEI+9s3SKDkIfn5PgAyhBHFKr7Nze3Lm9
 byxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792044525; x=1792649325;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zP0qzsPhZLXKeqQWLTl5oXfj3C4CySurGv2zGRO6nmw=;
 b=OdlFSdHDBvqCxzWUzuao3PG/cc0n2EIWghvIatHrduc1roGj9gzijDtGaPUZtZaLMs
 oAcA9G2geSnzVPxPJcoHN3SY6rNoa9zfUXosc/nqoAI2edlCsIjsxTxLFOLCf9Ee73W9
 CgWxwzY2zRqSylKoFW/OZnUOOM38qOVHINq4iSRkThjha4wzxOoBPIlupcpVAaZIiwDj
 SFecDPXZX69W7SDQNM8Ciyxo9Pn4cKB6OiODphf32FrUN6DrQOpe1b06g3UNE8YgWGGB
 WkEnq73Kqn0KDxKF3HkZ/N0uATsLyAQwAbdEIDuyXWO1GP4m4nnRy6ROyKgzkjn+XC1z
 o2Sw==
X-Gm-Message-State: AFq9FYI8wa6oMUrwVEY09SNdvGllUclWRMBHYLandBhRwoClsriU+b4J
 hs/FyFqgTTKyhW00GTjfrsHa0fb2UZ8DEjekmr8DoVjtCDMtBW/+qp1oLEpHbJ3Po0gfsxRcaZn
 QJB7dtxCBsPsUASCvzQEkNw==
X-Received: from pfvx21.prod.google.com ([2002:a05:6a00:2715:b0:89e:841c:fb8d])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3692:b0:889:c4e5:687e with SMTP id
 d2e1a72fcca58-897c49b2afemr15239050b3a.8.1792044524754; 
 Wed, 14 Oct 2026 23:08:44 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:08:27 +0800
In-Reply-To: <20261015060827.341298-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20261015060827.341298-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015060827.341298-9-stanleyjhu@google.com>
Subject: [PATCH 8/8] tests/qtest/ufs-test: Add QOM fault injection task abort
 test
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::446;
 envelope-from=37G3QagoKCmcXYFSQJdOMZLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x446.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add ufs_test_fault_injection_abort() to validate runtime QOM fault
injection modes via x-fault-inject-tag and x-fault-inject-mode
(abort-success with held-request tag overwrite rejection, two-stage
UFS_ABORT_TASK + SQRTC.ICU and LUN matching, in-transition completion,
timeout with UTMRLCLR clear-on-zero verification, abort-failed
rejection, and ssu-timeout WLUN START_STOP filtering).

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 tests/qtest/ufs-test.c | 326 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 325 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index c7d901a029..677d110b30 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -1702,7 +1702,7 @@ static void ufs_send_tmr(QUfs *ufs, uint64_t utmrlba, int slot,
     qtest_memread(ufs->dev.bus->qts, desc_addr, utrd_out, sizeof(*utrd_out));
 }
 
-static G_GNUC_UNUSED int ufs_mcq_send_scsi_cmd_async(QUfs *ufs, uint8_t lun,
+static int ufs_mcq_send_scsi_cmd_async(QUfs *ufs, uint8_t lun,
                                                      const uint8_t *cdb)
 {
     int cmd_desc_slot = alloc_cmd_desc_slot(ufs);
@@ -1957,6 +1957,328 @@ static void ufs_test_tmr_handling(void *obj, void *data, QGuestAllocator *alloc)
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
+     * Case 2: x-fault-inject-mode = in-transition.
+     * UFS_QUERY_TASK completes the held request normally (UFS_OCS_SUCCESS CQE).
+     */
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
+    slot = ufs_mcq_send_scsi_cmd_async(ufs, 0, test_unit_ready_cdb);
+    qtest_clock_step(qts, 100);
+
+    ufs_send_tmr(ufs, utmrlba, 0, UFS_QUERY_TASK, 0, slot, &utrd_result);
+    g_assert_cmpuint(utrd_result.upiu_rsp.rsp_header.response,
+                     ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(be32_to_cpu(utrd_result.upiu_rsp.output_param1),
+                     ==, UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL);
+    cqtp = ufs_rreg(ufs, cqdao + 0x4);
+    g_assert_cmpuint(cqtp, !=, cqhp);
+    qtest_memread(qts, ufs->cqlba[TEST_QID] + cqhp, &cqe, sizeof(cqe));
+    g_assert_cmpuint(cqe.status, ==, UFS_OCS_SUCCESS);
+    ufs_wreg(ufs, cqdao, cqtp);
+    ufs_wreg(ufs, cqisao + A_CQIS, FIELD_DP32(0, CQIS, TEPS, 1));
+    ufs_wreg(ufs, A_IS, FIELD_DP32(0, IS, CQES, 1));
+    release_cmd_desc_slot(ufs, slot);
+
+    /*
+     * Case 3: x-fault-inject-mode = timeout + A_UTMRLCLR clear-on-zero.
+     * UFS_ABORT_TASK times out, leaving UTMRLDBR bit 2 set.
+     * Verify that writing 1 to A_UTMRLCLR leaves bit 2 set, while writing 0
+     * clears bit 2.
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
+    /* Writing 1s to A_UTMRLCLR must NOT clear UTMRLDBR bit 2 */
+    ufs_wreg(ufs, A_UTMRLCLR, 0xffffffffU);
+    g_assert_cmpuint(ufs_rreg(ufs, A_UTMRLDBR) & (1 << 2), ==, 1 << 2);
+
+    /* Writing 0 at bit 2 (~(1 << 2)) to A_UTMRLCLR MUST clear bit 2 */
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
+
+    guest_free(alloc, utmrlba);
+    ufs_exit(ufs, alloc);
+}
+
 static void ufs_register_nodes(void)
 {
     const char *arch;
@@ -2015,6 +2337,8 @@ static void ufs_register_nodes(void)
                  &io_test_opts);
     qos_add_test("hce-reset", "ufs", ufs_test_hce_reset, &mcq_test_opts);
     qos_add_test("tmr-handling", "ufs", ufs_test_tmr_handling, &mcq_test_opts);
+    qos_add_test("fault-injection-abort", "ufs",
+                 ufs_test_fault_injection_abort, &mcq_test_opts);
     qos_add_test("wb-init", "ufs", ufstest_wb_init, &wb_test_opts);
     qos_add_test("wb-read-write", "ufs", ufstest_wb_read_write, &wb_test_opts);
     qos_add_test("hid", "ufs", ufstest_hid, &io_test_opts);
-- 
2.56.0.385.gd3acb90ef8-goog


