Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD9BC021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdpQ-0005mr-PQ; Mon, 24 Feb 2025 14:09:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdpF-0005iU-NJ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:09:11 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdpC-0004sf-8n
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:09:09 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso140716125ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 11:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740424143; x=1741028943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z8p5zfD1qIU3ybTmqcZLhj2sWdxHJ8heHhex8dKGI3k=;
 b=VWvS6DIYki/r6vyKNBLr/psPYB1NxdbbIbjHt8q4pUgcMVl/aBY9WHNU2goRJSfapA
 nDMDvaLc0fRCydsNRjnX66lO+r1WG2lN1NBeGvpL4pgZgXP1nqgJ/Vc7A2SBmHqY3DIn
 X2Ca0EEDAYHAOkAhV/Gb0Vpn0j2VTBVUZimbl1ETfLfkLX+PewXk9bOmJCT31ZLVtKET
 fhnWvdl+t/TcaYfAjJcO7VZAgAxapkbct/Ybjq8kGqvAFlDiJtV7vYprewM84E60lvsL
 A/XWRTFJAnwAUzSr1DOErWQlKDxo3q2SAYRBqyKz0UGNbaIW+F/0yIYxxpoHhgn1fTR8
 qBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740424143; x=1741028943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z8p5zfD1qIU3ybTmqcZLhj2sWdxHJ8heHhex8dKGI3k=;
 b=W9ptdk4A/fgrMBRhT993cwkmgNQb9InLPn09mP6/yNsI+oFdxszZTZl8/x/BvnxpDQ
 ppfBAtkcSNInvODE7MtPCFNRdV9BIQbQiCmPyFpXIQtYGDnKXz3mxPL/Q/H0V7+JxkJo
 RaC9y5TuDbgGFzYDbd27XTEMDNVo2XR7kmMEYx8+00o8YlsfRlLRsqznm1aNrafc+N+e
 yeXLEjmBRqsimq+hVMjF3/8e2IeQR9YxJTwQzNbzWjrguZOEuJjNUKG9tTWAbyZpMAlx
 H2NXKCYIy1uohppAGEOHTT50ImPzduJLMbyXeFc3UojJvvksxejnzYhVKUq2BKKEmtAJ
 EyJA==
X-Gm-Message-State: AOJu0YyDChuxpsA1ASg3zCVotZ6TO4Gkb/FhEx4hQCvpGR3HPct1XQJ1
 kVhD0C3gR8GLRAuoV7+Pc9JPgSD6PQbVNT/CK0evzf3se9+4l+w/US9kdTop9JvI/SU2o/QeWPD
 w
X-Gm-Gg: ASbGncvhOx5e2qWmYVMn12Of7prtY5Ea3LGMRnv9yaIl+tO+vB+6BzVkFBqPyImymcW
 o1qHqVLawxIbugs6rec2hTz0rE83k+Ss8dvUPL18IUdrJmG7YJH7hFC1j1E2XOo+QuKtDCNEh2y
 KDBj3r99/JyGOmK4lHfh4I1yPGvnw6GczOCTPpxJ0reEzND16axeePB8njvcQPf/f0wKXsNDl/6
 BTHtWVA1f40zLG7/FHJQh1naiOIL+tF8Bp0FcXxkSR30WWri9j2C0q/tHZTYJ8aXMu/NnUxtEhe
 IbX0FqQ0dJ+BjqilI4JLJddLWmRZOw==
X-Google-Smtp-Source: AGHT+IFVFWhQJonmNlj8kVJsSDooCmqlP3WehKqKKacVKwMVd0on/wzMDJISKkxC5kwpH4Bg1yxokg==
X-Received: by 2002:a17:902:c402:b0:21f:617a:f1b2 with SMTP id
 d9443c01a7336-22307e7021fmr4360865ad.46.1740424143155; 
 Mon, 24 Feb 2025 11:09:03 -0800 (PST)
Received: from grind.. ([2804:7f0:bcc0:6edb:f473:a9df:d551:443b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545df28sm183583155ad.153.2025.02.24.11.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:09:02 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 10/11] hw/riscv: add IOMMU HPM trace events
Date: Mon, 24 Feb 2025 16:08:25 -0300
Message-ID: <20250224190826.1858473-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
References: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a handful of trace events to allow for an easier time debugging the
HPM feature.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-hpm.c | 10 ++++++++++
 hw/riscv/trace-events      |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
index 5518c287a5..c5034bff79 100644
--- a/hw/riscv/riscv-iommu-hpm.c
+++ b/hw/riscv/riscv-iommu-hpm.c
@@ -39,6 +39,8 @@ uint64_t riscv_iommu_hpmcycle_read(RISCVIOMMUState *s)
     const uint64_t ctr_prev = s->hpmcycle_prev;
     const uint64_t ctr_val = s->hpmcycle_val;
 
+    trace_riscv_iommu_hpm_read(cycle, inhibit, ctr_prev, ctr_val);
+
     if (get_field(inhibit, RISCV_IOMMU_IOCOUNTINH_CY)) {
         /*
          * Counter should not increment if inhibit bit is set. We can't really
@@ -61,6 +63,8 @@ static void hpm_incr_ctr(RISCVIOMMUState *s, uint32_t ctr_idx)
     cntr_val = ldq_le_p(&s->regs_rw[RISCV_IOMMU_REG_IOHPMCTR_BASE + off]);
     stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_IOHPMCTR_BASE + off], cntr_val + 1);
 
+    trace_riscv_iommu_hpm_incr_ctr(cntr_val);
+
     /* Handle the overflow scenario. */
     if (cntr_val == UINT64_MAX) {
         /*
@@ -244,6 +248,8 @@ void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState *s, bool prev_cy_inh)
         return;
     }
 
+    trace_riscv_iommu_hpm_iocntinh_cy(prev_cy_inh);
+
     if (!(inhibit & RISCV_IOMMU_IOCOUNTINH_CY)) {
         /*
          * Cycle counter is enabled. Just start the timer again and update
@@ -268,6 +274,8 @@ void riscv_iommu_process_hpmcycle_write(RISCVIOMMUState *s)
     const uint64_t val = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_IOHPMCYCLES);
     const uint32_t ovf = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_IOCOUNTOVF);
 
+    trace_riscv_iommu_hpm_cycle_write(ovf, val);
+
     /*
      * Clear OF bit in IOCNTOVF if it's being cleared in IOHPMCYCLES register.
      */
@@ -352,6 +360,8 @@ void riscv_iommu_process_hpmevt_write(RISCVIOMMUState *s, uint32_t evt_reg)
         return;
     }
 
+    trace_riscv_iommu_hpm_evt_write(ctr_idx, ovf, val);
+
     /* Clear OF bit in IOCNTOVF if it's being cleared in IOHPMEVT register. */
     if (get_field(ovf, BIT(ctr_idx + 1)) &&
         !get_field(val, RISCV_IOMMU_IOHPMEVT_OF)) {
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index 7bcbb03d08..b50b14a654 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -19,3 +19,8 @@ riscv_iommu_sys_irq_sent(uint32_t vector) "IRQ sent to vector %u"
 riscv_iommu_sys_msi_sent(uint32_t vector, uint64_t msi_addr, uint32_t msi_data, uint32_t result) "MSI sent to vector %u msi_addr 0x%"PRIx64" msi_data 0x%x result %u"
 riscv_iommu_sys_reset_hold(int reset_type) "reset type %d"
 riscv_iommu_pci_reset_hold(int reset_type) "reset type %d"
+riscv_iommu_hpm_read(uint64_t cycle, uint32_t inhibit, uint64_t ctr_prev, uint64_t ctr_val) "cycle 0x%"PRIx64" inhibit 0x%x ctr_prev 0x%"PRIx64" ctr_val 0x%"PRIx64
+riscv_iommu_hpm_incr_ctr(uint64_t cntr_val) "cntr_val 0x%"PRIx64
+riscv_iommu_hpm_iocntinh_cy(bool prev_cy_inh) "prev_cy_inh %d"
+riscv_iommu_hpm_cycle_write(uint32_t ovf, uint64_t val) "ovf 0x%x val 0x%"PRIx64
+riscv_iommu_hpm_evt_write(uint32_t ctr_idx, uint32_t ovf, uint64_t val) "ctr_idx 0x%x ovf 0x%x val 0x%"PRIx64
-- 
2.48.1


