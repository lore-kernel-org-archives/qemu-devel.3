Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E48E606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NCghRlIn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMhm1-0006YK-AE; Fri, 30 Oct 2026 04:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhlu-0006Rb-H2
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:36 -0400
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhls-0001ce-6J
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:34 -0400
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-18cdcfc05ffso549268c88.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793348131; x=1793952931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GKP9t/oHs7wOb99z6biNCqhPIdqzJTK+WwxnKi7cqhs=;
 b=NCghRlIn4RBqrdKCXmg5aLJubq/H64dgYzIVhLaa2XEm+ZDNdaDln8lfuwXSCdl7gw
 PuSDFobRvPyZdnLu/u93hwR98KndnXt8NmRGCdkKvYBDtQQNi7qYg5fyVsoicwEEwAw1
 jTehTFqSKlaIPWspydzfvF0bXJZ/GT45t/nHcdcUW+dBCcu2soVWMSgA2NJlwK62pg5Z
 BjbyxS0myXf0CoeNx6YD9LrUUSi7srtWaogW46B4o+3ZEWvzZXfzeff2525hiiPg3ThM
 8M/V5rfxkov3UiHiHeqmlDsrJdKGnexScBHPgmHxBzieqpL6aWAU7X4QLosOJlpgC6VL
 f9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793348131; x=1793952931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GKP9t/oHs7wOb99z6biNCqhPIdqzJTK+WwxnKi7cqhs=;
 b=aFWIo8ki6wjjo9CyRH8zwa4i0nYKiTZuce0J4n8jWbstt4wn/JM0lP5MaXctSI/6lD
 4O3eeyhZ07wh4RwOdE/jNprTSQdXRB8IXuxFsv93iOL9VcF7mXhrXA/xN85CXVbz0HfO
 m0gQrmayaKkADj/8RYV7jbRQMr1wvZr4H6gL36a7+A5eRVJJ2NaxEgjq9eOI4X2Gh4Qr
 vDrIHvTvg3Xk6nCF6buLlMuwH1RZ75KYjAlWE0Vyb3A14VyDR1V5tRDCp9MkKc6PW5SM
 +4recahtcSThQY0fmQSaZff97NdJPQGB4pCiCmp1JLrA4IlZuu6RLmoohb7wePDQmkp5
 Friw==
X-Gm-Message-State: AFq9FYIiMXDXYIPwc11W4fOCNNqPaCVGhZhcVE3ybl5LZn3jG4Sp/lHx
 +jQwYxI/CjU49pMHR3ckOTAE8cuS0rv/R0bCB40fzmEDUdDPQ6FJ1cL1KodIPw==
X-Gm-Gg: AYBFou36Wth2RPxpVvhzLA4Yx4qZ8KW7C/H5E+uafjEl8gBCjJfqhd+zTLp8fPT2I86
 OSSorGGdmB0J2L895kIdrmr72liIUWYxOsggjhnGosi0WW8Vm0d79ys6OIWyhBU4ySwM/uOfFMR
 BHtEtqatRZU9yw23/pJnsjjGs+UdawdCmJejNCOKfHEr0v03Z6YvFrJyuT7VjiLX166OPOLSbnb
 lq4VbDhuzsYxDuGwUgDs/nkmyPUyiI7rNxI+DTCNjqLkmRcpd2mL18ZfX303++6NYdAGQd5LIUL
 iQGuIL+x/YJjJykHGzm4rNlI3SN4RQnlMB8vYVIpueC6Xb11GWgzVNGx1cjBaZCKcntv+zWN4uN
 mUqECmZYo3e+/nikPbOzecL/d4FAOV4AfYN6GIMr3p6H07Vd/gA3o8QK1WbTmvfZf5b4Xw8pF1j
 ElPRhi1QFAbE2OLwygS89q1THEjWqsfdgfNEXyhz30RzYPs8PaFwJ/Yws3WTc2ivoJtgaI4Ym+Q
 9CanJU6/22FDWDpRxkZznrCbEzgbysEHVdGh0pKEdEs15nj2Df3pJ5zatgd4rGkkvIZdpcCaXTc
 zpsc8ADJhOpKiFk3+42/1/4GAM1y8ZhdBoGnuhfnaDf9YQuPiG64xh25gUFJNpUKPg==
X-Received: by 2002:a05:7022:68f:b0:169:3706:d61b with SMTP id
 a92af1059eb24-1ac5bbba040mr3138230c88.16.1793348130545; 
 Fri, 30 Oct 2026 01:15:30 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm5905766c88.11.2026.10.30.01.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 01:15:30 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, fam@euphon.net, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org, daejun7.park@samsung.com,
 stanleyjhu@google.com, dridiha98@gmail.com, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com
Subject: [PULL 11/12] tests/qtest/ufs-test: Add MCQ runtime register and TMR
 handling test
Date: Fri, 30 Oct 2026 17:14:37 +0900
Message-ID: <a5e4946ba0753c0b715d1189505582607be0f8ea.1793347487.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793347487.git.jeuk20.kim@samsung.com>
References: <cover.1793347487.git.jeuk20.kim@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122a;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-dl1-x122a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stanley Jhu <stanleyjhu@google.com>

Add ufs_test_tmr_handling() to verify UTMRL UFS_QUERY_TASK execution
(both interrupt-driven I=1 and polling I=0 UTMRDs), SQCTI/CQIACR
register access, SQRTC/SQRTS queue stop/start and self-clearing ICU
transitions across running, stopped, and disabled SQ states, nullified
SQE (CT = 0xF) completion with UFS_OCS_ABORTED, and CQIS.TEPS
write-1-to-clear synchronization with IS.CQES.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 tests/qtest/ufs-test.c | 161 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 9270e3b137a..78feeed8599 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -1899,7 +1899,7 @@ static void ufstest_hid(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
-static G_GNUC_UNUSED void ufs_send_tmr(QUfs *ufs, uint64_t utmrlba, int slot,
+static void ufs_send_tmr(QUfs *ufs, uint64_t utmrlba, int slot,
                          uint8_t tm_func, uint8_t lun,
                          uint32_t task_tag,
                          UtpTaskReqDesc *utrd_out)
@@ -2030,6 +2030,164 @@ static void ufs_test_hce_reset(void *obj, void *data, QGuestAllocator *alloc)
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
@@ -2091,6 +2249,7 @@ static void ufs_register_nodes(void)
     qos_add_test("query-desciptor", "ufs", ufstest_query_desc_request,
                  &io_test_opts);
     qos_add_test("hce-reset", "ufs", ufs_test_hce_reset, &mcq_test_opts);
+    qos_add_test("tmr-handling", "ufs", ufs_test_tmr_handling, &mcq_test_opts);
     qos_add_test("wb-init", "ufs", ufstest_wb_init, &wb_test_opts);
     qos_add_test("wb-read-write", "ufs", ufstest_wb_read_write, &wb_test_opts);
     qos_add_test("hid", "ufs", ufstest_hid, &io_test_opts);
-- 
2.43.0


