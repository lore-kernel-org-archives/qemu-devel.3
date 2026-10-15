Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1649CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHEeE-000458-Dw; Thu, 15 Oct 2026 02:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <36m3QagoKCmUVWDQOHbMKXJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--stanleyjhu.bounces.google.com>)
 id 1xHEdz-0003pH-Ii
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:08:49 -0400
Received: from mail-pf1-x446.google.com ([2607:f8b0:4864:20::446])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <36m3QagoKCmUVWDQOHbMKXJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--stanleyjhu.bounces.google.com>)
 id 1xHEdx-0004J1-H7
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:08:47 -0400
Received: by mail-pf1-x446.google.com with SMTP id
 d2e1a72fcca58-88c4da716f4so1568409b3a.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792044523; x=1792649323; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YXfNj14sqOtZZ8CMqr7JKbQhAXcN7HYzqRY9snrtqfA=;
 b=wCsjFuQEnWn3kjU3Elz/7+Zli7J/Eyzs4Dpz4LPQ37DPLADnai5MGA0ZRWUQa3UbQN
 XXmEKPwsM17BrBFP2US7kCVRcsRjOe57caNguxgMrtI7VO3fPj9IZhiNZcIRn0fYexvD
 Q3rGdYGBWBnZKFWXoj95xn4Cc44dXRZ1W+vcq6RNNCbBTRThoJBe5w/MC77I8jCDHWKb
 CRN+CjCZxLYnhXQBTr9riGCTbBxsCU09s4yMF5KaJjDBHWXH20/wizOZoUJ7Um2wsKza
 nJ5TGdPm3ga4Yo9ftq4GmCBax7cHr2BrExPKuYsu2r15oA/Wd7WkcJWPF9n0FxGp3GkI
 ZtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792044523; x=1792649323;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YXfNj14sqOtZZ8CMqr7JKbQhAXcN7HYzqRY9snrtqfA=;
 b=1ZPIfmgI6s67q6klY4FItMo+gde/uRGVQq702v/fRpUFKOB/keKVe3E4qKWCJ38Nf4
 ZFk+MLZfXIyfzJo6Uhb9+6WpWGB8hAjhC91du9QtNCxoP/AHztxnqJx5yO48/MRN3zKL
 Laou3Txc9FqsXTJlxo+FKdne8Zf6z53pQjC3vXSTFLBj6GYOXJxnUHjwLo8ECCKj1o8/
 ue2fn6QKiaoLuGe6QTVM27hGDNYPBEAqtCbgky0yPdacgUH5pCjCnA+xeOBkoX4a7H3q
 AtgAmqQlz6+bc9ZQGEaBG4FGuPD/jSrd3eqyn90kVUv8qhH4eC0LT1/MgLd3Bi/DGJJ4
 m4yA==
X-Gm-Message-State: AFq9FYKb8mLOzN2L9BQ3C1sxbd6dfycQ22uGsdVrmAXnCp3kQz+jdUcX
 2gSnSglpy2uRkhoeo2YZir2MINK4eOV8CgrBeoK+eo1ryiCtYkBT3YV9wJwILKkQVWpRXWVrURv
 aLrUiEZTllLmwe4+Gx4U2jw==
X-Received: from pfdr1.prod.google.com ([2002:aa7:8b81:0:b0:88e:5b93:cd3f])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a01:b0:886:bb44:631f with SMTP id
 d2e1a72fcca58-897c6e1c80emr17928098b3a.10.1792044522769; 
 Wed, 14 Oct 2026 23:08:42 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:08:26 +0800
In-Reply-To: <20261015060827.341298-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20261015060827.341298-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015060827.341298-8-stanleyjhu@google.com>
Subject: [PATCH 7/8] tests/qtest/ufs-test: Add MCQ runtime register and TMR
 handling test
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::446;
 envelope-from=36m3QagoKCmUVWDQOHbMKXJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x446.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add ufs_test_tmr_handling() to verify UTMRL UFS_QUERY_TASK execution
(both interrupt-driven I=1 and polling I=0 UTMRDs), SQCTI/CQIACR
register access, SQRTC/SQRTS queue stop/start and self-clearing ICU
transitions across running, stopped, and disabled SQ states, nullified
SQE (CT = 0xF) completion with UFS_OCS_ABORTED, and CQIS.TEPS
write-1-to-clear synchronization with IS.CQES.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 tests/qtest/ufs-test.c | 161 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index c82e35b2b5..c7d901a029 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -1673,7 +1673,7 @@ static void ufstest_hid(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
-static G_GNUC_UNUSED void ufs_send_tmr(QUfs *ufs, uint64_t utmrlba, int slot,
+static void ufs_send_tmr(QUfs *ufs, uint64_t utmrlba, int slot,
                                        uint8_t tm_func, uint8_t lun,
                                        uint32_t task_tag,
                                        UtpTaskReqDesc *utrd_out)
@@ -1799,6 +1799,164 @@ static void ufs_test_hce_reset(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
+static void ufs_test_tmr_handling(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    uint64_t utmrlba, desc_addr, req_upiu_addr, rsp_upiu_addr;
+    UtpTaskReqDesc desc = { 0 }, utrd_result;
+    UtpTransferReqDesc null_utrd;
+    UtpUpiuReq req_upiu = { 0 };
+    UfsCqEntry cqe;
+    uint32_t mcq_reg_offset, sqdao, cqisao, sqrts, sqrtc, orig_sqattr;
+    int null_slot;
+    enum UtpOcsCodes ocs;
+    UtpUpiuRsp rsp_upiu;
+
+    ufs_init(ufs, alloc);
+    g_assert_true(ufs->support_mcq);
+
+    /* Set up UTMRL */
+    utmrlba = guest_alloc(alloc, 8 * sizeof(UtpTaskReqDesc));
+    ufs_wreg(ufs, A_UTMRLBA, utmrlba & 0xffffffff);
+    ufs_wreg(ufs, A_UTMRLBAU, utmrlba >> 32);
+    ufs_wreg(ufs, A_UTMRLRSR, 1);
+
+    /* Issue UFS_QUERY_TASK for inactive tag 15 (Interrupt bit I=1) */
+    ufs_send_tmr(ufs, utmrlba, 0, UFS_QUERY_TASK, 0, 15, &utrd_result);
+    g_assert_cmpuint(le32_to_cpu(utrd_result.header.dword_2) & UFS_MASK_OCS,
+                     ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(utrd_result.upiu_rsp.rsp_header.response,
+                     ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(be32_to_cpu(utrd_result.upiu_rsp.output_param1),
+                     ==, UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL);
+
+    /* Issue polling UTMRD with I=0 (slot 1): clears doorbell without UTMRCS */
+    desc_addr = utmrlba + 1 * sizeof(UtpTaskReqDesc);
+    desc.header.dword_0 = 0;
+    desc.header.dword_2 = cpu_to_le32(UFS_OCS_INVALID_COMMAND_STATUS);
+    desc.upiu_req.req_header.trans_type = UFS_UPIU_TRANSACTION_TASK_REQ;
+    desc.upiu_req.req_header.query_func = UFS_QUERY_TASK;
+    desc.upiu_req.req_header.lun = 0;
+    desc.upiu_req.req_header.task_tag = 0x11;
+    desc.upiu_req.input_param1 = cpu_to_be32(0);
+    desc.upiu_req.input_param2 = cpu_to_be32(15);
+    qtest_memwrite(ufs->dev.bus->qts, desc_addr, &desc, sizeof(desc));
+
+    ufs_wreg(ufs, A_UTMRLDBR, 1 << 1);
+    g_assert_cmpuint(ufs_rreg(ufs, A_UTMRLDBR) & (1 << 1), ==, 0);
+    g_assert_cmpuint(FIELD_EX32(ufs_rreg(ufs, A_IS), IS, UTMRCS), ==, 0);
+    qtest_memread(ufs->dev.bus->qts, desc_addr, &utrd_result,
+                  sizeof(utrd_result));
+    g_assert_cmpuint(le32_to_cpu(utrd_result.header.dword_2) & UFS_MASK_OCS,
+                     ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(utrd_result.upiu_rsp.rsp_header.response,
+                     ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(be32_to_cpu(utrd_result.upiu_rsp.output_param1),
+                     ==, UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL);
+
+    /* Verify SQCTI, CQIACR, SQRTS/SQRTC, and CQIS/IS.CQES W1C sync */
+    sqdao = ufs->sqdao[TEST_QID];
+    mcq_reg_offset =
+        FIELD_EX32(ufs_rreg(ufs, A_MCQCAP), MCQCAP, QCFGPTR) * 0x200 +
+        TEST_QID * 0x40;
+    cqisao = ufs_rreg(ufs, mcq_reg_offset + A_CQISAO);
+
+    /* SQCTI and CQIACR read/write */
+    ufs_wreg(ufs, sqdao + A_SQCTI, (1 << 8) | 0x2b);
+    g_assert_cmpuint(ufs_rreg(ufs, sqdao + A_SQCTI), ==, (1 << 8) | 0x2b);
+    ufs_wreg(ufs, cqisao + offsetof(UfsMcqCqIntReg, iacr), 0x101);
+    g_assert_cmpuint(ufs_rreg(ufs, cqisao + offsetof(UfsMcqCqIntReg, iacr)),
+                     ==, 0x101);
+
+    /* SQ_ICU while running (STS=0) -> sets SQRTS.CUS=1, RTC=2 */
+    ufs_wreg(ufs, sqdao + A_SQRTC, FIELD_DP32(0, SQRTC, ICU, 1));
+    sqrts = ufs_rreg(ufs, sqdao + A_SQRTS);
+    sqrtc = ufs_rreg(ufs, sqdao + A_SQRTC);
+    g_assert_cmpuint(FIELD_EX32(sqrts, SQRTS, STS), ==, 0);
+    g_assert_cmpuint(FIELD_EX32(sqrts, SQRTS, CUS), ==, 1);
+    g_assert_cmpuint(FIELD_EX32(sqrts, SQRTS, RTC), ==, 2);
+    g_assert_cmpuint(FIELD_EX32(sqrtc, SQRTC, ICU), ==, 0);
+
+    /* SQ_STOP -> sets SQRTS.STS = 1 */
+    ufs_wreg(ufs, sqdao + A_SQRTC, FIELD_DP32(0, SQRTC, STOP, 1));
+    sqrts = ufs_rreg(ufs, sqdao + A_SQRTS);
+    g_assert_cmpuint(FIELD_EX32(sqrts, SQRTS, STS), ==, 1);
+
+    /*
+     * SQ_ICU while stopped (no matching req) -> sets SQRTS.CUS=1, RTC=1 and
+     * self-clears ICU.
+     */
+    ufs_wreg(ufs, sqdao + A_SQRTC,
+             FIELD_DP32(0, SQRTC, STOP, 1) | FIELD_DP32(0, SQRTC, ICU, 1));
+    sqrts = ufs_rreg(ufs, sqdao + A_SQRTS);
+    sqrtc = ufs_rreg(ufs, sqdao + A_SQRTC);
+    g_assert_cmpuint(FIELD_EX32(sqrts, SQRTS, STS), ==, 1);
+    g_assert_cmpuint(FIELD_EX32(sqrts, SQRTS, CUS), ==, 1);
+    g_assert_cmpuint(FIELD_EX32(sqrts, SQRTS, RTC), ==, 1);
+    g_assert_cmpuint(FIELD_EX32(sqrtc, SQRTC, ICU), ==, 0);
+
+    /*
+     * Queue a nullified SQE (CT = 0xF) while SQ is stopped, then resume SQ
+     * (STOP 1->0): SQRTS.STS clears to 0 while SQRTS.CUS remains 1, and the
+     * nullified SQE posts CQE with UFS_OCS_ABORTED without writing rsp_upiu.
+     */
+    null_slot = alloc_cmd_desc_slot(ufs);
+    req_upiu_addr =
+        ufs->cmd_desc_addr + null_slot * UTP_COMMAND_DESCRIPTOR_SIZE;
+    rsp_upiu_addr = req_upiu_addr + UTP_RESPONSE_UPIU_OFFSET;
+    req_upiu.header.trans_type = UFS_UPIU_TRANSACTION_NOP_OUT;
+    req_upiu.header.task_tag = null_slot;
+    qtest_memwrite(ufs->dev.bus->qts, req_upiu_addr, &req_upiu,
+                   sizeof(req_upiu));
+    memset(&rsp_upiu, 0xa5, sizeof(rsp_upiu));
+    qtest_memwrite(ufs->dev.bus->qts, rsp_upiu_addr, &rsp_upiu,
+                   sizeof(rsp_upiu));
+
+    null_utrd = ufs_build_req_utrd(req_upiu_addr, UFS_UTP_NO_DATA_TRANSFER, 0);
+    null_utrd.header.dword_0 = cpu_to_le32((UFS_UTP_CMD_TYPE_NULL << 28) |
+                                           UFS_UTP_NO_DATA_TRANSFER |
+                                           UFS_UTP_REQ_DESC_INT_CMD);
+    __ufs_send_transfer_request_mcq_async(ufs, 0, &null_utrd);
+
+    /* SQ_START (STOP 1->0) -> clears SQRTS.STS = 0 while preserving CUS = 1 */
+    ufs_wreg(ufs, sqdao + A_SQRTC, 0);
+    sqrts = ufs_rreg(ufs, sqdao + A_SQRTS);
+    g_assert_cmpuint(FIELD_EX32(sqrts, SQRTS, STS), ==, 0);
+    g_assert_cmpuint(FIELD_EX32(sqrts, SQRTS, CUS), ==, 1);
+
+    ufs_wait_for_irq(ufs);
+    g_assert_cmpuint(ufs_mcq_poll_cq(ufs, &cqe, 1), ==, 1);
+    g_assert_cmpuint(cqe.status, ==, UFS_OCS_ABORTED);
+    g_assert_cmpuint(cqe.task_tag, ==, null_slot);
+    qtest_memread(ufs->dev.bus->qts, rsp_upiu_addr, &rsp_upiu,
+                  sizeof(rsp_upiu));
+    g_assert_cmpuint(rsp_upiu.header.trans_type, ==, 0xa5);
+    ufs_wreg(ufs, cqisao + A_CQIS, FIELD_DP32(0, CQIS, TEPS, 1));
+    release_cmd_desc_slot(ufs, null_slot);
+
+    /* Verify MCQ command sets CQIS.TEPS=1 and W1C clears CQIS.TEPS & IS.CQES */
+    ocs = ufs_send_nop_out(ufs, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(FIELD_EX32(ufs_rreg(ufs, cqisao + A_CQIS), CQIS, TEPS),
+                     ==, 1);
+    ufs_wreg(ufs, cqisao + A_CQIS, FIELD_DP32(0, CQIS, TEPS, 1));
+    g_assert_cmpuint(FIELD_EX32(ufs_rreg(ufs, cqisao + A_CQIS), CQIS, TEPS),
+                     ==, 0);
+    g_assert_cmpuint(FIELD_EX32(ufs_rreg(ufs, A_IS), IS, CQES), ==, 0);
+
+    /* SQ_ICU on disabled SQ (SQEN=0) -> sets SQRTS.CUS=1, RTC=3 */
+    orig_sqattr = ufs_rreg(ufs, mcq_reg_offset + A_SQATTR);
+    ufs_wreg(ufs, mcq_reg_offset + A_SQATTR, 0);
+    ufs_wreg(ufs, sqdao + A_SQRTC, FIELD_DP32(0, SQRTC, ICU, 1));
+    sqrts = ufs_rreg(ufs, sqdao + A_SQRTS);
+    g_assert_cmpuint(FIELD_EX32(sqrts, SQRTS, CUS), ==, 1);
+    g_assert_cmpuint(FIELD_EX32(sqrts, SQRTS, RTC), ==, 3);
+    ufs_wreg(ufs, mcq_reg_offset + A_SQATTR, orig_sqattr);
+
+    guest_free(alloc, utmrlba);
+    ufs_exit(ufs, alloc);
+}
+
 static void ufs_register_nodes(void)
 {
     const char *arch;
@@ -1856,6 +2014,7 @@ static void ufs_register_nodes(void)
     qos_add_test("query-desciptor", "ufs", ufstest_query_desc_request,
                  &io_test_opts);
     qos_add_test("hce-reset", "ufs", ufs_test_hce_reset, &mcq_test_opts);
+    qos_add_test("tmr-handling", "ufs", ufs_test_tmr_handling, &mcq_test_opts);
     qos_add_test("wb-init", "ufs", ufstest_wb_init, &wb_test_opts);
     qos_add_test("wb-read-write", "ufs", ufstest_wb_read_write, &wb_test_opts);
     qos_add_test("hid", "ufs", ufstest_hid, &io_test_opts);
-- 
2.56.0.385.gd3acb90ef8-goog


