Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E941606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SWmApJc8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSrWU-0002dV-Qx; Mon, 16 Nov 2026 02:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xSrWR-0002cJ-7D
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 02:53:04 -0500
Received: from mail-pj2-x09.google.com ([2607:f8b0:4864:39::9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xSrWP-0006Re-D9
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 02:53:02 -0500
Received: by mail-pj2-x09.google.com with SMTP id
 98e67ed59e1d1-3b1478f06e3so864247a91.0
 for <qemu-devel@nongnu.org>; Sun, 15 Nov 2026 23:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794815580; x=1795420380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hIjlzjraPZGou6DwZuYcV0PsGSSXUwI1uycVRUHglCk=;
 b=SWmApJc8Z715GGNIvuonZNt8OP1n6SnDOOIAol/xbDF95nrQAD7zNoSApYEJbBZ8x2
 01u+8XqNBSnnXBXndTJ+BwG10gLL61PWsxYHit5UD100VfFOKcrMBFnfF4d096lhDavz
 gQVRrpE5TumwDMPMDkL8twhtWcDKQL9XDtDJ3Bw8uNmLg7lqJFwRkeofsWoAcJnY+Ppj
 vpSK73Wes59q4khHzfp3294NRlyMKZECS8E7FiiH7xtWHD6Z2zS2dYPel0S+U7xvTIr9
 oCPNCKEB6gPhFZODz+Ydcrl1b6C/l5pFX5kJ98frN1sp2Bai6cpj3xprJUvP8ujLRng6
 yhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794815580; x=1795420380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hIjlzjraPZGou6DwZuYcV0PsGSSXUwI1uycVRUHglCk=;
 b=fK4xW7n0w2sXUeI9Y0bHT4oWvXM7GRHwIS/14vdArEUx7JzWMNJX5bE913jZ+VKc9c
 zRBkdtqbWl3mpYkM85eq0WzbJx8sss9US0VY+KKzTImEmrKRLgcZ9x9NbGwNve1h0i2M
 3hzDljaH/ToLAkgudQAagWzQ34a9M9BYJ0bcrkCdHQgfVTq6jhyBrC5bF2ukY/elvbKx
 wvdQWbjYlbvaGBrHriJbY7r3KKxGQQftLa6uRc+kg4reJ+j/AxNZggHXnKgvgrwKy9a7
 is0/qCNE/PGWhz95gTtGquoEP4aRmX6oH0DQO355/pIDDLDptmN+wwNRBZh2SjL9cu54
 ehlQ==
X-Gm-Message-State: APuU4Z8dv6flt5EtbfMAe3qPTjP+MDxnV4FvHkPy9NnaCC7LvtSdPGFC
 V4Rn6pH1hdMor5rcCkkVadx04dTWuiDRN8ZFFdJP+2QJQLfcwD3uHu5v++mlgQavCOScGIIXoBw
 =
X-Gm-Gg: AZFdTZezzewwqxeUujk4rkMLSgaMQorH5pDbdV8cQVLkI0XacNmgJX6olKmEg8eryDp
 pX41i+zMv8HV02AKWeW4Y5Oe7LcUPnheJfJPjjBsWcAYVce+Ch7Tia0BcEJEw+JpLK1qPBbQiLE
 5BhroygJMeqzeZO68AskL7a7Kk5HiErrE7u7URg/8ofhgWiknaU3UvJs9wOW7A49uw1ksUNbqjJ
 /x9S2pHXFRkb7V5ARuNIpZgb0h/65UqXmeCgsc+5jAElqxqvXQQZLoJBjoYfyZ1KJERwiu7E/JF
 3nb7f2UB7egykgn+0mPTCmYEyJXWIEpy6bmCap0eL4Tp6ixIDrBhFqWvL0I8DZ1E+Tdr4pBhcL1
 skboAeWLyBxtkcpGvO/5vBD/fltLl5rivyJhP0Qw18TUVz+7ym2wCbEDj5oHaEEri/LMCk3ZrxU
 y7V+/orBVgdhCrNUyd6/eyQLsYRLdztwB13Bc5leDE0mdADrf6O7fHluWtiYrTU/oi2kdAqcZMI
 lhxrvP8NCGQiFgXzFBr53UIZBjQuQ7jDZwAPlLbu8cPsH6yhIu/kQX2QHhWplvmAiaUBHeAvWhM
 4SBFqO6Xg6HhzmJRjhSk0ZMh9tXKKwW8bjac75Ju/SXDFaoPCg84XujY
X-Received: by 2002:a17:90b:54cb:b0:3b0:ce1c:e74f with SMTP id
 98e67ed59e1d1-3b1b0a3a251mr9045461a91.27.1794815579609; 
 Sun, 15 Nov 2026 23:52:59 -0800 (PST)
Received: from Dell-WorkStation.localdomain ([152.175.67.81])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d0f6e0sm20745622a91.9.2026.11.15.23.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 23:52:59 -0800 (PST)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-riscv@nongnu.org, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH 2/3] hw/riscv/riscv-iommu: Fix MSI fault PV reporting for
 process ID zero
Date: Mon, 16 Nov 2026 15:51:40 +0800
Message-ID: <20261116075141.167317-3-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116075141.167317-1-fritchleybohrer@gmail.com>
References: <20261116075141.167317-1-fritchleybohrer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::9;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-pj2-x09.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

MSI fault reporting derives PV from the numeric process ID, so process
zero always produces PV=0. Ordinary translation faults and recovery
faults instead use the device context's PDTV bit.

Use the same PDTV policy for MSI faults. Add a qtest with a real PD8
process directory and DPE-selected default process zero, reaching an
invalid MSI PTE after nonidentity nested translation. Check PV=1, PID=0,
and the original IOVA. Also check PV=0 in the existing fault cases
without PDTV.

This aligns QEMU's current context-based reporting policy. Preserving
the validity of an explicitly supplied request PID separately from its
value is outside this change.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 hw/riscv/riscv-iommu.c         |  2 +-
 tests/qtest/iommu-riscv-test.c | 36 ++++++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 016e95fce7..5752a4776b 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -831,7 +831,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
 
 err:
     riscv_iommu_report_fault(s, ctx, fault_type, cause,
-                             !!ctx->process_id, iova, 0);
+                             !!(ctx->tc & RISCV_IOMMU_DC_TC_PDTV), iova, 0);
     return res;
 }
 
diff --git a/tests/qtest/iommu-riscv-test.c b/tests/qtest/iommu-riscv-test.c
index 3678d8a0d4..28af06d770 100644
--- a/tests/qtest/iommu-riscv-test.c
+++ b/tests/qtest/iommu-riscv-test.c
@@ -27,6 +27,7 @@
 
 #define MSI_TABLE_PA            0x80030000ull
 #define MSI_TARGET_PA           0x80040000ull
+#define MSI_PROCESS_GPA         0x00050000ull
 #define MSI_DATA                0x37
 #define EDU_DEVICE_ID           0x11e8
 #define EDU_IRQ_RAISE           0x60
@@ -62,13 +63,15 @@ typedef struct RiscvIommuMsiTest {
     bool valid_pte;
     uint64_t s_walks;
     uint64_t g_walks;
+    bool default_process;
 } RiscvIommuMsiTest;
 
 static const RiscvIommuMsiTest msi_tests[] = {
-    { "first-stage-bare-fault", QRIOMMU_TM_G_STAGE_ONLY, false, 0, 0 },
-    { "nested-fault", QRIOMMU_TM_NESTED, false, 3, 9 },
-    { "first-stage-bare-basic", QRIOMMU_TM_G_STAGE_ONLY, true, 0, 0 },
-    { "nested-basic", QRIOMMU_TM_NESTED, true, 3, 9 },
+    { "first-stage-bare-fault", QRIOMMU_TM_G_STAGE_ONLY, false, 0, 0, false },
+    { "nested-fault", QRIOMMU_TM_NESTED, false, 3, 9, false },
+    { "first-stage-bare-basic", QRIOMMU_TM_G_STAGE_ONLY, true, 0, 0, false },
+    { "nested-basic", QRIOMMU_TM_NESTED, true, 3, 9, false },
+    { "nested-pdtv-pid0-fault", QRIOMMU_TM_NESTED, false, 3, 9, true },
 };
 
 static const RiscvIommuDbgTest debug_tests[] = {
@@ -389,6 +392,27 @@ static void test_riscv_iommu_msi(gconstpointer data)
     /* Match one GPA page; interrupt-file number zero selects the first PTE. */
     dc_addr = QRIOMMU_SPACE_OFFS + QRIOMMU_DC_BASE +
               state.testdev->devfn * sizeof(struct riscv_iommu_dc);
+    if (cfg->default_process) {
+        uint64_t process_pa = QRIOMMU_SPACE_OFFS + MSI_PROCESS_GPA;
+        uint64_t g_leaf_pa = QRIOMMU_SPACE_OFFS + QRIOMMU_G_L1_PTE_VAL;
+        uint64_t fsc = qtest_readq(state.qts, dc_addr + 24);
+
+        g_assert_cmpuint(cfg->mode, ==, QRIOMMU_TM_NESTED);
+        g_assert_cmphex(cap & RISCV_IOMMU_CAP_PD8, !=, 0);
+        /* Map the PD8 table through G-stage; PID zero selects its first PC. */
+        qtest_writeq(state.qts,
+            g_leaf_pa + ((MSI_PROCESS_GPA >> 12) & 0x1ff) * sizeof(uint64_t),
+            ((process_pa >> 12) << 10) | QRIOMMU_LEAF_PTE_RW_MASK);
+        qtest_memset(state.qts, process_pa, 0, 0x1000);
+        qtest_writeq(state.qts, process_pa, RISCV_IOMMU_PC_TA_V);
+        qtest_writeq(state.qts, process_pa + 8, fsc);
+        qtest_writeq(state.qts, dc_addr,
+            RISCV_IOMMU_DC_TC_V | RISCV_IOMMU_DC_TC_PDTV |
+            RISCV_IOMMU_DC_TC_DPE);
+        qtest_writeq(state.qts, dc_addr + 24,
+            (MSI_PROCESS_GPA >> 12) |
+            ((uint64_t)RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8 << 60));
+    }
     qtest_writeq(state.qts, dc_addr + 32,
                  (MSI_TABLE_PA >> 12) | (1ull << 60));
     qtest_writeq(state.qts, dc_addr + 40, 0);
@@ -437,6 +461,10 @@ static void test_riscv_iommu_msi(gconstpointer data)
                          RISCV_IOMMU_FQ_TTYPE_UADDR_WR);
         g_assert_cmpuint((hdr & RISCV_IOMMU_FQ_HDR_DID) >> 40, ==,
                          state.testdev->devfn);
+        /* Check QEMU's PDTV policy using DPE, without an EDU PASID. */
+        g_assert_cmpuint(!!(hdr & RISCV_IOMMU_FQ_HDR_PV), ==,
+                         cfg->default_process);
+        g_assert_cmphex(hdr & RISCV_IOMMU_FQ_HDR_PID, ==, 0);
         g_assert_cmphex(qtest_readq(state.qts, fq_addr + 16), ==, iova);
         g_assert_cmphex(qtest_readq(state.qts, fq_addr + 24), ==, 0);
     }
-- 
2.43.0


