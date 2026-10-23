Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2416606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=CYnnBxn+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKDbm-0006ps-Ib; Fri, 23 Oct 2026 07:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3REfbagoKCp0PQ7KIBVGERDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--stanleyjhu.bounces.google.com>)
 id 1xKDbk-0006nt-Em
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:38:48 -0400
Received: from mail-pg1-x545.google.com ([2607:f8b0:4864:20::545])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3REfbagoKCp0PQ7KIBVGERDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--stanleyjhu.bounces.google.com>)
 id 1xKDbi-00067R-KQ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:38:48 -0400
Received: by mail-pg1-x545.google.com with SMTP id
 41be03b00d2f7-cd652c0385bso459127a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 04:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792755524; x=1793360324; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U4hcLanIvwKqBp5MHELRHRfiov/8bE+BwM1wRfD35Lg=;
 b=CYnnBxn+4CVI/TB7HJ0hQfYfx1j+T64llSaaodQ7aFcZYFSwmUF1F8VO4YAi46GoBi
 JDXOu165e6TYW/Aa7rWYo/UZESJv5gJQhcm5YfstD5vodWxZmkjs56KR3+iLIdLDLU7F
 I1PwGuiHLSpsSZ6ViNhJrzlcTlpuawC85vbdiGqjFW7PGKZ17MwZgtRHQFP4PTfDdLG9
 YGkSuAwn/m4MpEVtqx+FyfRKnRVlX6O6okTgxf/XHtkV+uXPMWfOYHVzDzTKdquNp87T
 HIy4UssOmchLruB0a+c62alulfKuPrR9UbYJV5a8a8ohQnPtCYJJNSDLXtzA03FFp1Qp
 NaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792755524; x=1793360324;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U4hcLanIvwKqBp5MHELRHRfiov/8bE+BwM1wRfD35Lg=;
 b=Kc6oKWpRul4yX9wtMKG0x4ERt+LNvfv5fnnxhK8SjcnwJ4R7xYwJQK1nh9NJc+Rrkr
 AI/Awa9lZf/+TpGwCFvoqtfTaCpqgiefjnk4jITpWMTh2yOLqaleW7/4PUbUomJ4eeUU
 odSUBBd3X2cSjJCjpRNxw5LA3aj50udcBBgh51JUT2F3oDUNrjjtIka2m0WOw5I7mDk5
 lIKTY+MHliui4rj6Ue+0Zr0ozq1DCXFMFGA+UCXlgUZRK8nEDU3FNcKx/H+5rDJQ5Ou4
 6YHWQ55Iu65ZzDhqF0EPU93GnNNzLi+73nGp7Nau4Pi2RSGTwCj2VkLoDJZPNuqR+Fas
 jRMw==
X-Gm-Message-State: AFq9FYL2PtGkNIGf0AVZIFBgWq+3HzHmFkhWmM4CPFbVdYwZDEH3ui2D
 fKc0cWJ/3Hx6OT6Hnw0A+BqLUfjJ1VudNqEIwpfSntftCagkYlQOjCDQDiysivIFV8dLH7NRH2D
 0bA8FD9EzjYDonJHwzY9Yrg==
X-Received: from pfhk2.prod.google.com ([2002:aa7:9982:0:b0:8a0:70d8:a2ef])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:330b:b0:87d:ee98:606 with SMTP id
 d2e1a72fcca58-8a2c604340cmr1589174b3a.23.1792755524035; 
 Fri, 23 Oct 2026 04:38:44 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:38:28 +0800
In-Reply-To: <20261023113830.3368902-1-stanleyjhu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261023113830.3368902-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023113830.3368902-7-stanleyjhu@google.com>
Subject: [PATCH v3 6/8] tests/qtest/ufs-test: Add HCE reset unit test
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::545;
 envelope-from=3REfbagoKCp0PQ7KIBVGERDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--stanleyjhu.bounces.google.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add ufs_test_hce_reset() to verify HCE 1->0->1 controller reset
behavior, checking that UTMRLRSR and dynamic MCQ queue configuration and
operational registers reset to 0 while host-configured registers (IE,
UTMRLBA/UTMRLBAU, MCQCONFIG) and static capability offsets (SQDAO/CQDAO)
are preserved and subsequent I/O succeeds.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 tests/qtest/ufs-test.c | 79 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index d9317a492e..7fbddafee0 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -1952,6 +1952,84 @@ static G_GNUC_UNUSED int ufs_mcq_send_scsi_cmd_async(QUfs *ufs, uint8_t lun,
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
+    g_assert_cmpuint(ufs_rreg(ufs, orig_sqdao), ==, 0);
+    g_assert_cmpuint(ufs_rreg(ufs, orig_sqdao + 0x4), ==, 0);
+    g_assert_cmpuint(ufs_rreg(ufs, orig_cqdao), ==, 0);
+    g_assert_cmpuint(ufs_rreg(ufs, orig_cqdao + 0x4), ==, 0);
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
 #define ZONE_SIZE (2 * 1024 * 1024)
 #define ZONE_BLOCKS (ZONE_SIZE / 4096)
 #define MAX_OPEN_ZONE 6
@@ -3130,6 +3208,7 @@ static void ufs_register_nodes(void)
                  &io_test_opts);
     qos_add_test("query-desciptor", "ufs", ufstest_query_desc_request,
                  &io_test_opts);
+    qos_add_test("hce-reset", "ufs", ufs_test_hce_reset, &mcq_test_opts);
     qos_add_test("wb-init", "ufs", ufstest_wb_init, &wb_test_opts);
     qos_add_test("wb-read-write", "ufs", ufstest_wb_read_write, &wb_test_opts);
     qos_add_test("hid", "ufs", ufstest_hid, &io_test_opts);
-- 
2.56.0.307.g5fe7bd680c-goog


