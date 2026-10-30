Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19707606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W0XN0OsH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMhm7-0006ik-OF; Fri, 30 Oct 2026 04:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhls-0006RC-PA
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:36 -0400
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhlq-0001cK-E7
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:32 -0400
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-1931ff67a29so1264801c88.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793348128; x=1793952928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=USQSlCDXbe2Po2yshNTH5Baw8p7W0+sQ6ZyjyEsakFc=;
 b=W0XN0OsH6QXknGiPjJHxBHYCg0+LL/Q8emEMe0ZlZSKKi9zDvgZFXlQHUHVMRpzGIU
 WpXF9eA1dLTFBOOT3DThORg30i+Zc/X6Hea0ETWhEf90mPAf3ad2r5c8hvX8lToAWlZa
 miLvkNbAWds4kslkQJkdEkCes+79ivkK5Ze+B/G9Ld8KetnLg/XiSDm9IRlJmV5+YeZg
 W7zdUhRewTe1kXZs3B6RmgV3fvToe1Ojk8q4xugie/+tttr+Ax72nKaK46lD9FwkiUcp
 yJhw6RlqKGm363+5crfxmKvUqge5t01Bv/AclmlxNaS8MrQMVNfplhYAwttKeGhpsomn
 Xjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793348128; x=1793952928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=USQSlCDXbe2Po2yshNTH5Baw8p7W0+sQ6ZyjyEsakFc=;
 b=z8dBGAE8fhixc9pHfskTa5nImo0OWpueABlVBhQVih1pXIViFhDa4xf9hcFFu9FZ7G
 tjFoC8sM9gUq9D6pJr21cYrfHfeGy1sNASGIeGUYoL2lL9Idp59q5ZwqH0Ha1r1w5kXj
 7T5ty8Qq7sCU/KuN9Jvc7s45WtJ02grJvbebdHdDGnHm80C0LhYbK628vAFE4w897gLd
 Vuag45Zd5eTX+nFm8Ln43GnnYERefErp1/nST/AQIFqPMhVUIJ7PlvPzoeFts4YbjGy4
 iWCzgsaNtx1qg1SqB0DdCEYPM5BxIP3ynODaUKGPVqsjC1FyjFDxQrAutD+f4B/AGai/
 NRYw==
X-Gm-Message-State: AFq9FYLH12KcmJta/EZ7REFfLHvzAKye9yZ6J2pPSX0J/++kKyHDNVEI
 55l0YigZ/VKL5PClC6mzOoMRTRJordUVGKVQpcCLyWoQgdVdZAcxPXStLWx6pA==
X-Gm-Gg: AYBFou2neihgSYvryw3MW0mZsfKpZNcGz7elI9U7HrAmT0BC+2JAfK70x6xjrLizcd8
 CWHFPgOg/MY18FPI95pqYibyNh15iWwHxYjfaG+8OVdGYQIOMJj4NSzh1bNYS/J1aF6soZYYq04
 jfa9002g3CUjbb1PuR5lXwygRr8/tiG5dm9T08kWOSo5oqdRqQfbI4V7v9SBnTnerb+LTkwiU3k
 f2FEbbW7FZcnSDdik7wn+vj39q4YqCoalhfiv/yTUSel7m8l+VKESTdWKgpUwTRLywnDEjh/dZw
 tnsz8//wFLHv5nPmLkhvBYV/MEHf1k2Rma+PYi/2LbiLdWeOxj/DR7IxbiU5y5rrC01+Hh8Jo68
 GLieLgTLpXfCaED1CHZ/8udeM7SHgrBrv/UCegslrv++yfhwVauJ6nD8SlHJcTQyG4pu3Q8kBWy
 5wypLXbLnzMPXYTG+WB/1JoGrysU6t8NAZbKb+3skTp/Q+nybf0shR3HbS2f5CXHErVRa2lUeny
 /ptaPY91gH415bbYOluc/OyebJ3PXOnlQ9/kfelUEkPCPO5NbtaFdyLgxyb33S6HzuD8f8Prh1M
 s5W4qVEX5gRRGZyltzo/+Y29dWtqd1y1TfD4LM/SHzugT/J1hNu/1IgmsOdoHA6xAQ==
X-Received: by 2002:a05:7022:258a:b0:18c:e014:6f1d with SMTP id
 a92af1059eb24-1ac55f2d3cemr2748373c88.1.1793348127532; 
 Fri, 30 Oct 2026 01:15:27 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm5905766c88.11.2026.10.30.01.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 01:15:27 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, fam@euphon.net, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org, daejun7.park@samsung.com,
 stanleyjhu@google.com, dridiha98@gmail.com, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com
Subject: [PULL 10/12] tests/qtest/ufs-test: Add HCE reset unit test
Date: Fri, 30 Oct 2026 17:14:36 +0900
Message-ID: <415c4cf108707a0ba580ba9fa6e2aec17ffd5fc1.1793347487.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793347487.git.jeuk20.kim@samsung.com>
References: <cover.1793347487.git.jeuk20.kim@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122b;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-dl1-x122b.google.com
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

Add ufs_test_hce_reset() to verify HCE 1->0->1 controller reset
behavior, checking that UTMRLRSR and dynamic MCQ queue configuration and
operational registers reset to 0 while host-configured registers (IE,
UTMRLBA/UTMRLBAU, MCQCONFIG) and static capability offsets (SQDAO/CQDAO)
are preserved and subsequent I/O succeeds.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 tests/qtest/ufs-test.c | 79 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 2914723430c..9270e3b137a 100644
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
 static void ufs_register_nodes(void)
 {
     const char *arch;
@@ -2012,6 +2090,7 @@ static void ufs_register_nodes(void)
                  &io_test_opts);
     qos_add_test("query-desciptor", "ufs", ufstest_query_desc_request,
                  &io_test_opts);
+    qos_add_test("hce-reset", "ufs", ufs_test_hce_reset, &mcq_test_opts);
     qos_add_test("wb-init", "ufs", ufstest_wb_init, &wb_test_opts);
     qos_add_test("wb-read-write", "ufs", ufstest_wb_read_write, &wb_test_opts);
     qos_add_test("hid", "ufs", ufstest_hid, &io_test_opts);
-- 
2.43.0


