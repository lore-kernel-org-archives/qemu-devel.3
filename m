Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CA5CC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHEeB-0003wH-LQ; Thu, 15 Oct 2026 02:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <36G3QagoKCmMTUBOMFZKIVHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--stanleyjhu.bounces.google.com>)
 id 1xHEdx-0003p7-Od
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:08:48 -0400
Received: from mail-pg1-x545.google.com ([2607:f8b0:4864:20::545])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <36G3QagoKCmMTUBOMFZKIVHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--stanleyjhu.bounces.google.com>)
 id 1xHEdv-0004In-PV
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:08:45 -0400
Received: by mail-pg1-x545.google.com with SMTP id
 41be03b00d2f7-cc4ac5feaa4so3350251a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792044521; x=1792649321; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mqjEmUU0U9hvpchxY/PjtiKlPdGQUq34O/p+GdEPli8=;
 b=B+2NPnc0pwKXpZQPhGRVTOBhFp1eoultDTdSakjwjU+7pwve0QjWCuoq+re3O83Orl
 583TAGSHGA+q2SfgWF1HAWTKlDCLkmp/eMtQCcrFaeGt/gYJEo44qsjgSJCSbQ6csUT0
 JdPq6z0JH7UFx6cO/5+w7fjZgV0VMmidLbvBnKHKxC/UbO1vge2YowCwcftDXodbKFK4
 KT/tGq58VTrmS8PwrcSpUuEcplYFgnSJOhLc0QRBkCjs4XDb5QnTeYjo70d71iXgknZ4
 cUR1xH1vc5A+W/ncoVW16/zDEA7jK87X+Up85SkuxxQiUmjj/g1bttuKZ0GfbSyR4D5Y
 /7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792044521; x=1792649321;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mqjEmUU0U9hvpchxY/PjtiKlPdGQUq34O/p+GdEPli8=;
 b=XDv+DJN/TUIO09iWTFAujrCg1EDcODd5EmZNb5e4IY3HQ8uSHAxfjF32TzI7mmNqe9
 DYnTZwQ3GHVKXWTwPtFA0bvRm0D16NJIVDao/8DH6b7F82cQRKgS6QnZrqkO5+IUyL+3
 JyCuPzrr70amP23K+TxFYP1hFq5rvarUVnEsEocMYHE63Buq1y4PyZuMKY3uYyX5Wg1I
 71SD0gfmY9Wqs3vonRPhAH7oKhdJmurqryeogzLQAfRoEtX8/uVSXPzW+FKeqVoqXJsr
 FgIb7XXLmj/3rWfJrtlAdMikYWfonfjvxrsfc3/Lf03tl0IkV9J50KHXMGsa/YdQh8ID
 FKUg==
X-Gm-Message-State: AFq9FYKBhQeZEMQhNpFacVuzNbRQNyQeX7FUzdOCXtoCMROelzqDHfbP
 OWsxqZOkDMzW+E2I+5dWntMoVNcVeaJmgdqZL/oOczuJPvAmxidqpC4wd2kSljOBWtWKt1WPe96
 1C6zvaZj1XGlxSd1lJdMifg==
X-Received: from pfbbw17.prod.google.com ([2002:a05:6a00:4091:b0:891:74f:5b6])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:854:b0:881:bc81:e8f3 with SMTP id
 d2e1a72fcca58-897c5d5c3bfmr12446577b3a.12.1792044520742; 
 Wed, 14 Oct 2026 23:08:40 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:08:25 +0800
In-Reply-To: <20261015060827.341298-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20261015060827.341298-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015060827.341298-7-stanleyjhu@google.com>
Subject: [PATCH 6/8] tests/qtest/ufs-test: Add HCE reset unit test
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::545;
 envelope-from=36G3QagoKCmMTUBOMFZKIVHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--stanleyjhu.bounces.google.com;
 helo=mail-pg1-x545.google.com
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

Add ufs_test_hce_reset() to verify HCE 1->0->1 controller reset
behavior, checking that UTMRLRSR and dynamic MCQ queue configuration and
operational registers reset to 0 while host-configured registers (IE,
UTMRLBA/UTMRLBAU, MCQCONFIG) and static capability offsets (SQDAO/CQDAO)
are preserved and subsequent I/O succeeds.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 tests/qtest/ufs-test.c | 75 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index d8329d1409..c82e35b2b5 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -1725,6 +1725,80 @@ static G_GNUC_UNUSED int ufs_mcq_send_scsi_cmd_async(QUfs *ufs, uint8_t lun,
     return cmd_desc_slot;
 }
 
+static void ufs_test_hce_reset(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    uint32_t mcqcap, qcfgptr, mcq_reg_offset;
+    uint32_t orig_sqdao, orig_cqdao, orig_ie;
+    enum UtpOcsCodes ocs;
+    UtpUpiuRsp rsp_upiu;
+
+    ufs_init(ufs, alloc);
+    g_assert_true(ufs->support_mcq);
+
+    mcqcap = ufs_rreg(ufs, A_MCQCAP);
+    qcfgptr = FIELD_EX32(mcqcap, MCQCAP, QCFGPTR);
+    mcq_reg_offset = qcfgptr * 0x200 + TEST_QID * 0x40;
+
+    orig_sqdao = ufs_rreg(ufs, mcq_reg_offset + A_SQDAO);
+    orig_cqdao = ufs_rreg(ufs, mcq_reg_offset + A_CQDAO);
+    orig_ie = ufs_rreg(ufs, A_IE);
+    g_assert_cmpuint(orig_sqdao, !=, 0);
+    g_assert_cmpuint(orig_cqdao, !=, 0);
+    g_assert_cmpuint(orig_ie, !=, 0);
+    g_assert_cmpuint(ufs_rreg(ufs, mcq_reg_offset + A_SQATTR), !=, 0);
+    g_assert_cmpuint(ufs_rreg(ufs, mcq_reg_offset + A_CQATTR), !=, 0);
+    g_assert_cmpuint(ufs_rreg(ufs, orig_sqdao + 0x4), !=, 0);
+
+    ufs_wreg(ufs, A_UTMRLBA, 0x1000);
+    ufs_wreg(ufs, A_UTMRLBAU, 0x1);
+    ufs_wreg(ufs, A_UTMRLRSR, 1);
+    ufs_wreg(ufs, A_MCQCONFIG, 0x100);
+    g_assert_cmpuint(ufs_rreg(ufs, A_UTMRLRSR), ==, 1);
+
+    /* Write HCE=0 to trigger controller reset */
+    ufs_wreg(ufs, A_HCE, 0);
+    g_assert_cmpuint(FIELD_EX32(ufs_rreg(ufs, A_HCE), HCE, HCE), ==, 0);
+    g_assert_cmpuint(ufs_rreg(ufs, A_HCS), ==, 0);
+    g_assert_cmpuint(ufs_rreg(ufs, A_UTMRLRSR), ==, 0);
+
+    /* Verify host-configured registers remain preserved across HCE=0 */
+    g_assert_cmpuint(ufs_rreg(ufs, A_IE), ==, orig_ie);
+    g_assert_cmpuint(ufs_rreg(ufs, A_UTMRLBA), ==, 0x1000);
+    g_assert_cmpuint(ufs_rreg(ufs, A_UTMRLBAU), ==, 0x1);
+    g_assert_cmpuint(ufs_rreg(ufs, A_MCQCONFIG), ==, 0x100);
+
+    /* Verify dynamic queue configuration registers reset to 0 */
+    g_assert_cmpuint(ufs_rreg(ufs, mcq_reg_offset + A_SQATTR), ==, 0);
+    g_assert_cmpuint(ufs_rreg(ufs, mcq_reg_offset + A_SQLBA), ==, 0);
+    g_assert_cmpuint(ufs_rreg(ufs, mcq_reg_offset + A_CQATTR), ==, 0);
+    g_assert_cmpuint(ufs_rreg(ufs, mcq_reg_offset + A_CQLBA), ==, 0);
+
+    /* Verify dynamic MCQ operational registers reset to 0 on HCE=0 */
+    g_assert_cmpuint(ufs_rreg(ufs, orig_sqdao), ==, 0);
+    g_assert_cmpuint(ufs_rreg(ufs, orig_sqdao + 0x4), ==, 0);
+    g_assert_cmpuint(ufs_rreg(ufs, orig_cqdao), ==, 0);
+    g_assert_cmpuint(ufs_rreg(ufs, orig_cqdao + 0x4), ==, 0);
+
+    /* Verify read-only capability offsets (SQDAO/CQDAO) remain intact */
+    g_assert_cmpuint(ufs_rreg(ufs, mcq_reg_offset + A_SQDAO), ==, orig_sqdao);
+    g_assert_cmpuint(ufs_rreg(ufs, mcq_reg_offset + A_CQDAO), ==, orig_cqdao);
+
+    /* Re-enable HCE=1 and verify dynamic queue status/pointers remain 0 */
+    ufs_wreg(ufs, A_HCE, FIELD_DP32(0, HCE, HCE, 1));
+    g_assert_cmpuint(FIELD_EX32(ufs_rreg(ufs, A_HCE), HCE, HCE), ==, 1);
+
+    /* Free previous guest allocations before re-initializing */
+    ufs_exit(ufs, alloc);
+
+    /* Re-enable HCE=1, re-init controller, and verify normal I/O succeeds */
+    ufs_init(ufs, alloc);
+    ocs = ufs_send_nop_out(ufs, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+
+    ufs_exit(ufs, alloc);
+}
+
 static void ufs_register_nodes(void)
 {
     const char *arch;
@@ -1781,6 +1855,7 @@ static void ufs_register_nodes(void)
                  &io_test_opts);
     qos_add_test("query-desciptor", "ufs", ufstest_query_desc_request,
                  &io_test_opts);
+    qos_add_test("hce-reset", "ufs", ufs_test_hce_reset, &mcq_test_opts);
     qos_add_test("wb-init", "ufs", ufstest_wb_init, &wb_test_opts);
     qos_add_test("wb-read-write", "ufs", ufstest_wb_read_write, &wb_test_opts);
     qos_add_test("hid", "ufs", ufstest_hid, &io_test_opts);
-- 
2.56.0.385.gd3acb90ef8-goog


