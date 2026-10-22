Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FD5606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=p4Y8aEad
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJnVV-0007bg-M2; Thu, 22 Oct 2026 03:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3HL_ZagoKCl8PQ7KIBVGERDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--stanleyjhu.bounces.google.com>)
 id 1xJnUX-0007Or-Us
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:45:37 -0400
Received: from mail-pg1-x546.google.com ([2607:f8b0:4864:20::546])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3HL_ZagoKCl8PQ7KIBVGERDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--stanleyjhu.bounces.google.com>)
 id 1xJnUU-0002IO-QD
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:45:36 -0400
Received: by mail-pg1-x546.google.com with SMTP id
 41be03b00d2f7-cd3b9e70f88so1746277a12.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 00:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792655133; x=1793259933; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jDiCW1Z8nBWLuyV93omuB93zBx5tYJkLyAUuU4CEhy4=;
 b=p4Y8aEadFEHSyGu2dEQ4KwhXk1pf/8sViNZemjiDXr4PxMaxW1jwAXtcCjlnjhojwt
 s3ReiVjMyKrjBGh8c/cI8ABAXyWKPK/yeHL9m+rzOc6UX/gqdem3PYHETszBi1pvuVGE
 dlq0iWw/yop4fyO+hJq3FkNjkStYToaqRlO3AochfBQwKv69BRLXMbSaTmaROdyVDlLo
 Jp+O2hfeI+HEx5ln/RvRNBg5bJTydE5Hj7ZaK0CzF8vh7tV1iSubkuK2uXTHqih8Fpi/
 cnAZT6SU3k9TSafEHDqWgAo1+gbiljSHtnY1buqLuRHb39Uh1Hdau7KyywuE9aQcKrrD
 F0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655133; x=1793259933;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jDiCW1Z8nBWLuyV93omuB93zBx5tYJkLyAUuU4CEhy4=;
 b=sAMJA1HhyJ94ObjRdfKzUago2lLxiudcX5GAX5wAen37KZNzMvF7jWnFhsSCFLBfcD
 akG3Uoy8VqeY8W9QBnO2CYzRaXLWHGXqncPQzOKgMm6LjQThA39yiMFtfpr0q22MhiHb
 8geQ3ZgoZtbtOtXSx/VgvsK5GNL2HF/P9Djwjd529GbCkBYMZarNy2KX5j3Hws9+QKYx
 kEsnI0njdT84iYZofyYXKSle8Rtrr22zFbUbbYio9MZLv6diBaJdaklEVkM9UbT0x2Ie
 IIOEhkUR2PwOnL3tT6uTW8ve7fHTiVR2mwAhGt5ALvVG8e7AsaMtdUzSiGFKcZiOtsdM
 wFQA==
X-Gm-Message-State: AFq9FYKgl7ZVwOv3XqxoxTvzb0o+o6xj7z0Q/I4LIgKUb2GW3Oq/N+VM
 4MFGbgmES814w1E/+W2IURt6YR7f2slJex068EwbHrWG/YHcKUFMO4v82Z8FKhhKL5Hl29VJ079
 yGtufojx4QbFwc+5+GjMwlQ==
X-Received: from pfay28.prod.google.com ([2002:a05:6a00:181c:b0:885:756d:3709])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:828c:b0:3e2:30c1:fe01 with SMTP id
 adf61e73a8af0-3e287f3212fmr3637108637.69.1792655132738; 
 Thu, 22 Oct 2026 00:45:32 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:45:11 +0800
In-Reply-To: <20261022074513.2292281-1-stanleyjhu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261022074513.2292281-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022074513.2292281-7-stanleyjhu@google.com>
Subject: [PATCH v2 6/8] tests/qtest/ufs-test: Add HCE reset unit test
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::546;
 envelope-from=3HL_ZagoKCl8PQ7KIBVGERDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--stanleyjhu.bounces.google.com;
 helo=mail-pg1-x546.google.com
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
 tests/qtest/ufs-test.c | 75 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index f577fe2614..019107d818 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -1952,6 +1952,80 @@ static G_GNUC_UNUSED int ufs_mcq_send_scsi_cmd_async(QUfs *ufs, uint8_t lun,
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
 #define ZONE_SIZE (2 * 1024 * 1024)
 #define ZONE_BLOCKS (ZONE_SIZE / 4096)
 #define MAX_OPEN_ZONE 6
@@ -3130,6 +3204,7 @@ static void ufs_register_nodes(void)
                  &io_test_opts);
     qos_add_test("query-desciptor", "ufs", ufstest_query_desc_request,
                  &io_test_opts);
+    qos_add_test("hce-reset", "ufs", ufs_test_hce_reset, &mcq_test_opts);
     qos_add_test("wb-init", "ufs", ufstest_wb_init, &wb_test_opts);
     qos_add_test("wb-read-write", "ufs", ufstest_wb_read_write, &wb_test_opts);
     qos_add_test("hid", "ufs", ufstest_hid, &io_test_opts);
-- 
2.56.0.218.g1ec904b173-goog


