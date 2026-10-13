Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFB9CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY3a-0007Sw-SU; Tue, 13 Oct 2026 04:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3P-00071c-Sp
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3K-0007d1-Fz
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:09 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso21710605e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880799; x=1792485599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7xlfYHyIYxKoALR890FGz7sTstMZUZWDOD7rBywE0fs=;
 b=vF8XZMNfRabwmEJeKKFs9YYjE+l+gRDlxofuaZJYBecBDRR9OiYros4kQZ9JnH8bos
 Ae6WiueLaGGMFdizoY+rYXQ1zRqisqnIGqVciA/WLA6bmTzPgDvUWE4jaoG/v4IJLqxK
 xKF1aXE1vpbptyl1DVEnnLQWrPTDREaSX5LDJtUSoQ+8ZbNAb0DPOUnoO6ffiE8t4aqV
 HbogZ6P67LRLQsh9CTdC58CtOqJcZvY8hDxWaN4z2G5QaZbgPUd5ERQYJ4pt+J/fZYtO
 7Z2giW1uV4hG0o2oIC/9ExNxbMIedPnE8m0YKATXBsN6nORFXxry1L4gnLUQzafMYe1m
 lUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880799; x=1792485599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7xlfYHyIYxKoALR890FGz7sTstMZUZWDOD7rBywE0fs=;
 b=CBK24vnIafoVf+zCEVmFIElkQq9qfTS1MwWZPdQtf6C5oB5fK+AqqAXmu6cuLLsFd+
 CVeiCE5gAxaxiwYPoMCHluSIl+v/Nq7BFrldFu1hb8/ZoseFz+lErwPsPfN1Bqf/lpI4
 YL2VQpesZlr8imjYF9l3WGulMcQZv4b2E5mRDGxA9vU630l/I98xQTlm0F1VB2z7Z/2e
 Y2iMcFNF6k1HDffc3tDO+vb8+21PvHlF8qwg6fUfVV0Td/X3KlEk62zNsXFd7CfxGGeW
 +8i1FwK7cCc4yLbGgrIBEEbZkPnDg2p7L/J2R4HNEV5bPn8iT+pViLfS9kQPBzB95WAF
 sTMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByS4xyOjAtB8LLV+pdwKtAd+i6+aF3fGx4wkhEvrDYlo9g8US7vsqW+r7aKCQQnadjP+CGCdBDo9Fcj@nongnu.org
X-Gm-Message-State: AFq9FYL6ZFc6Z/041ME8u+1IwmBmPnAw1VADzqy6F/l4RaavY5+ClHMq
 QLW/03IbQU7SGrzh2/kHPZ21k2hB7UIec+e8iE1kb78xerKh9qbbXJ6xUBmurKMOUyU51IGaL8E
 tDb9ubxk=
X-Gm-Gg: AYBFou0DpUDHlP1hjFBldW2PrRjWbVm2ElBy4Bkg8l8Bbhe8reoD1tBWSQU+GRN/99e
 Rcmwf37v7kUdQbU2psZU7Qq3bS3t2X5FSySbCFpIiUGLiHHHF522JvTh06jAl/AFgV/M4eH+rH5
 pvAj3cfIIGOImYnhJe0S4bpBzuQ6r+yXWK/XV1EiVRLyMVKojsfY1ZyO0bnRE491bngot1zoA/C
 cjGSMa6qYaRzF4txFldInZKftDKBPub0XGJMh0QkVvtXHhECO9lUqJjHtsTDzwRP7tXgaVFs9Cq
 oQVULRWbNQqvD3/4DDkrfTFypDsMm7RVGQYXVRqjISmEq0TjXNFSMuCgozrs2SXC967HhvT8XwV
 ydmlQ5ufvBY0LYJ68jJJTYhea/TLlTeaQXhdThO4SvKpn5h6ZUajlYZB3zXPC9lL6pdW69VDqra
 u8TLnrpxSrIG1aYMoiwSdNvw4uyo2FU2GMJZlaqZ3xQ3JqPmWg8KLFpXKhU1ykfmfbgNzLsdHCo
 rClszQIZ4QMwg/jTtsoVuePH63cwuaKfYz1R9ALKmWAUJM3b8Q5IMj+X1JDoQc3OrIpRzsf/T2/
 tJCjXhHUn8IjVA==
X-Received: by 2002:a05:600c:4593:b0:4a1:7ed5:99e8 with SMTP id
 5b1f17b1804b1-4a18e49bffbmr230919965e9.22.1791880799246; 
 Tue, 13 Oct 2026 01:39:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:39:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 18/86] target/arm: GICv5 cpuif: Implement GIC fine-grained
 trap registers
Date: Tue, 13 Oct 2026 09:38:25 +0100
Message-ID: <20261013083933.1024405-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The GICv5 cpu interface includes a set of fine-grained trap registers
which allow a hypervisor to trap guest accesses to the various GIC
cpu interface registers and instructions.  We implement this using
the existing fine-grained-trap mechanism.

This commit provides the definitions of the FGT register bits and the
registers themselves; we will mark up the cpreg definitions with the
fgt trap information in the following commit.

Note that because FGWTE3 has only write-traps and the indexes into
fgt_read[] and fgt_write[] have to line up, we leave a gap in the
fgt_read[] array for the unused slot.  We could have moved FGTWE3 to
the end of the array, since the array location isn't encoded in the
migration stream, but that only saves us 8 bytes in the CPU struct
size and leaves the possibility that we forget about the need to
align the read/write indexes next time we add an FGT feature.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h          | 85 +++++++++++++++++++++++++++++++++++-
 target/arm/cpu.h             | 10 +++--
 target/arm/tcg/gicv5-cpuif.c | 22 ++++++++++
 3 files changed, 111 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index ce651a4faa6..e46c8c979e1 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -389,12 +389,16 @@ typedef enum CPAccessResult {
 /* Indexes into fgt_read[] */
 #define FGTREG_HFGRTR 0
 #define FGTREG_HDFGRTR 1
-/* Indexes into fgt_write[] */
+/* 2 unused: FGWTE3 doesn't have read-traps */
+#define FGTREG_ICH_HFGRTR 3 /* GICv5 */
+/* Indexes into fgt_write[]; these must align with the fgt_read[] ones */
 #define FGTREG_HFGWTR 0
 #define FGTREG_HDFGWTR 1
 #define FGTREG_FGWTE3 2
-/* Indexes into fgt_exec[] */
+#define FGTREG_ICH_HFGWTR 3 /* GICv5 */
+/* Indexes into fgt_exec[] (these don't have to line up with read/write) */
 #define FGTREG_HFGITR 0
+#define FGTREG_ICH_HFGITR 1 /* GICv5 */
 
 FIELD(HFGRTR_EL2, AFSR0_EL1, 0, 1)
 FIELD(HFGRTR_EL2, AFSR1_EL1, 1, 1)
@@ -720,6 +724,45 @@ FIELD(FGWTE3_EL3, TTBR0_EL3, 20, 1)
 FIELD(FGWTE3_EL3, VBAR_EL3, 21, 1)
 FIELD(FGWTE3_EL3, GPCBW_EL3, 22, 1)
 
+/* These are the GICv5 fine-grained trap registers */
+FIELD(ICH_HFGRTR_EL2, ICC_APR_EL1, 0, 1)
+FIELD(ICH_HFGRTR_EL2, ICC_IDRN_EL1, 1, 1)
+FIELD(ICH_HFGRTR_EL2, ICC_CR0_EL1, 2, 1)
+/* Bit 3 is RES1 */
+FIELD(ICH_HFGRTR_EL2, ICC_HPPIR_EL1, 4, 1)
+FIELD(ICH_HFGRTR_EL2, ICC_PCR_EL1, 5, 1)
+FIELD(ICH_HFGRTR_EL2, ICC_ICSR_EL1, 6, 1)
+FIELD(ICH_HFGRTR_EL2, ICC_IAFFIDR_EL1, 7, 1)
+FIELD(ICH_HFGRTR_EL2, ICC_PPI_HMRN_EL1, 16, 1)
+FIELD(ICH_HFGRTR_EL2, ICC_PPI_ENABLERN_EL1, 17, 1)
+FIELD(ICH_HFGRTR_EL2, ICC_PPI_PENDRN_EL1, 18, 1)
+FIELD(ICH_HFGRTR_EL2, ICC_PPI_PRIORITYRN_EL1, 19, 1)
+FIELD(ICH_HFGRTR_EL2, ICC_PPI_ACTIVERN_EL1, 20, 1)
+/* All RES1 bits in this register */
+#define ICH_HFGRTR_EL2_RES1_MASK (1 << 3)
+
+/* Matches ICH_HFGRTR_EL2, but bits for RO regs are RES0 */
+FIELD(ICH_HFGWTR_EL2, ICC_APR_EL1, 0, 1)
+FIELD(ICH_HFGWTR_EL2, ICC_CR0_EL1, 2, 1)
+FIELD(ICH_HFGWTR_EL2, ICC_PCR_EL1, 5, 1)
+FIELD(ICH_HFGWTR_EL2, ICC_ICSR_EL1, 6, 1)
+FIELD(ICH_HFGWTR_EL2, ICC_PPI_ENABLERN_EL1, 17, 1)
+FIELD(ICH_HFGWTR_EL2, ICC_PPI_PENDRN_EL1, 18, 1)
+FIELD(ICH_HFGWTR_EL2, ICC_PPI_PRIORITYRN_EL1, 19, 1)
+FIELD(ICH_HFGWTR_EL2, ICC_PPI_ACTIVERN_EL1, 20, 1)
+
+FIELD(ICH_HFGITR_EL2, GICCDEN, 0, 1);
+FIELD(ICH_HFGITR_EL2, GICCDDIS, 1, 1);
+FIELD(ICH_HFGITR_EL2, GICCDPRI, 2, 1);
+FIELD(ICH_HFGITR_EL2, GICCDAFF, 3, 1);
+FIELD(ICH_HFGITR_EL2, GICCDPEND, 4, 1);
+FIELD(ICH_HFGITR_EL2, GICCDRCFG, 5, 1);
+FIELD(ICH_HFGITR_EL2, GICCDHM, 6, 1);
+FIELD(ICH_HFGITR_EL2, GICCDEOI, 7, 1);
+FIELD(ICH_HFGITR_EL2, GICCDDI, 8, 1);
+FIELD(ICH_HFGITR_EL2, GICRCDIA, 9, 1);
+FIELD(ICH_HFGITR_EL2, GICRCDNMIA, 10, 1);
+
 FIELD(FGT, NXS, 13, 1) /* Honour HCR_EL2.FGTnXS to suppress FGT */
 /* Which fine-grained trap bit register to check, if any */
 FIELD(FGT, TYPE, 10, 3)
@@ -798,6 +841,9 @@ typedef enum FGTBit {
     FGT_HDFGWTR = FGT_W | (FGTREG_HDFGWTR << R_FGT_IDX_SHIFT),
     FGT_HFGITR = FGT_EXEC | (FGTREG_HFGITR << R_FGT_IDX_SHIFT),
     FGT_FGWTE3 = FGT_W | (FGTREG_FGWTE3 << R_FGT_IDX_SHIFT),
+    FGT_ICH_HFGRTR = FGT_RW | (FGTREG_ICH_HFGRTR << R_FGT_IDX_SHIFT),
+    FGT_ICH_HFGWTR = FGT_W | (FGTREG_ICH_HFGWTR << R_FGT_IDX_SHIFT),
+    FGT_ICH_HFGITR = FGT_EXEC | (FGTREG_ICH_HFGITR << R_FGT_IDX_SHIFT),
 
     /* Trap bits in HFGRTR_EL2 / HFGWTR_EL2, starting from bit 0. */
     DO_BIT(HFGRTR, AFSR0_EL1),
@@ -955,6 +1001,41 @@ typedef enum FGTBit {
     DO_EL3_BIT(FGWTE3, TTBR0_EL3),
     DO_EL3_BIT(FGWTE3, VBAR_EL3),
     DO_EL3_BIT(FGWTE3, GPCBW_EL3),
+
+    /*
+     * Trap bits in ICH_HFGRTR_EL2 / ICH_HFGWTR_EL2, starting from bit 0.
+     * These are all "trap on 0, don't trap on 1" and don't follow the
+     * "name starts with 'n' if sense is reversed" convention of the
+     * main FEAT_FGT registers.
+     */
+    DO_REV_BIT(ICH_HFGRTR, ICC_APR_EL1),
+    DO_REV_BIT(ICH_HFGRTR, ICC_IDRN_EL1),
+    DO_REV_BIT(ICH_HFGRTR, ICC_CR0_EL1),
+    DO_REV_BIT(ICH_HFGRTR, ICC_HPPIR_EL1),
+    DO_REV_BIT(ICH_HFGRTR, ICC_PCR_EL1),
+    DO_REV_BIT(ICH_HFGRTR, ICC_ICSR_EL1),
+    DO_REV_BIT(ICH_HFGRTR, ICC_IAFFIDR_EL1),
+    DO_REV_BIT(ICH_HFGRTR, ICC_PPI_HMRN_EL1),
+    DO_REV_BIT(ICH_HFGRTR, ICC_PPI_ENABLERN_EL1),
+    DO_REV_BIT(ICH_HFGRTR, ICC_PPI_PENDRN_EL1),
+    DO_REV_BIT(ICH_HFGRTR, ICC_PPI_PRIORITYRN_EL1),
+    DO_REV_BIT(ICH_HFGRTR, ICC_PPI_ACTIVERN_EL1),
+
+    /*
+     * Trap bits in ICH_HFGITR_EL2, starting from bit 0.  These also
+     * are all "trap on 0".
+     */
+    DO_REV_BIT(ICH_HFGITR, GICCDEN),
+    DO_REV_BIT(ICH_HFGITR, GICCDDIS),
+    DO_REV_BIT(ICH_HFGITR, GICCDPRI),
+    DO_REV_BIT(ICH_HFGITR, GICCDAFF),
+    DO_REV_BIT(ICH_HFGITR, GICCDPEND),
+    DO_REV_BIT(ICH_HFGITR, GICCDRCFG),
+    DO_REV_BIT(ICH_HFGITR, GICCDHM),
+    DO_REV_BIT(ICH_HFGITR, GICCDEOI),
+    DO_REV_BIT(ICH_HFGITR, GICCDDI),
+    DO_REV_BIT(ICH_HFGITR, GICRCDIA),
+    DO_REV_BIT(ICH_HFGITR, GICRCDNMIA),
 } FGTBit;
 
 #undef DO_BIT
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4e7076a5339..276466d2b84 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -550,11 +550,13 @@ typedef struct CPUArchState {
          * Fine-Grained Trap registers. We store these as arrays so the
          * access checking code doesn't have to manually select
          * HFGRTR_EL2 vs HFDFGRTR_EL2 etc when looking up the bit to test.
-         * FEAT_FGT2 will add more elements to these arrays.
+         * These include the trap registers for all features which have
+         * FGT-style trapping: FEAT_FGT, FEAT_FGWTE3. GICv5, and (when we
+         * implement it) FEAT_FGT2.
          */
-        uint64_t fgt_read[2]; /* HFGRTR, HDFGRTR */
-        uint64_t fgt_write[3]; /* HFGWTR, HDFGWTR, FGWTE3 */
-        uint64_t fgt_exec[1]; /* HFGITR */
+        uint64_t fgt_read[4]; /* HFGRTR, HDFGRTR, unused, ICH_HFGRTR */
+        uint64_t fgt_write[4]; /* HFGWTR, HDFGWTR, FGWTE3, ICH_HFGWTR */
+        uint64_t fgt_exec[2]; /* HFGITR, ICH_HFGITR */
 
         /* RME registers */
         uint64_t gpccr_el3;
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index ac667c84c2f..55dc2e3b3b2 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -979,6 +979,28 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .accessfn = access_gicv5_ich_reg,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ich_apr_el2),
     },
+    {   .name = "ICH_HFGRTR_EL2", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 9, .opc2 = 4,
+        .access = PL2_RW, .type = ARM_CP_NO_RAW,
+        .nv2_redirect_offset = 0xb10,
+        .accessfn = access_gicv5_ich_reg,
+        .fieldoffset = offsetof(CPUARMState, cp15.fgt_read[FGTREG_ICH_HFGRTR]),
+        .resetvalue = ICH_HFGRTR_EL2_RES1_MASK,
+    },
+    {   .name = "ICH_HFGWTR_EL2", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 9, .opc2 = 6,
+        .access = PL2_RW, .type = ARM_CP_NO_RAW,
+        .nv2_redirect_offset = 0xb10,
+        .accessfn = access_gicv5_ich_reg,
+        .fieldoffset = offsetof(CPUARMState, cp15.fgt_write[FGTREG_ICH_HFGWTR]),
+    },
+    {   .name = "ICH_HFGITR_EL2", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 9, .opc2 = 7,
+        .access = PL2_RW, .type = ARM_CP_NO_RAW,
+        .nv2_redirect_offset = 0xb10,
+        .accessfn = access_gicv5_ich_reg,
+        .fieldoffset = offsetof(CPUARMState, cp15.fgt_exec[FGTREG_ICH_HFGITR]),
+    },
     /*
      * Note that DVIR bits RAZ/WI when the PPI isn't assigned to the
      * current domain, so we will need to mask them when we implement
-- 
2.43.0


