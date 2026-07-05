Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1257BC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 13:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgMja-0002KA-83; Sun, 05 Jul 2026 09:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imaginos32@gmail.com>)
 id 1wgMjX-0002Jd-Vm
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 09:18:07 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imaginos32@gmail.com>)
 id 1wgMjV-0003pp-RP
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 09:18:07 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493ba701891so16298615e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 06:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783257483; x=1783862283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3iQ6foKp7BWXNI7l7JdIldcj04hpvpDIkEePupB9eIQ=;
 b=poaQrKri+3Fu+zOE//3MG5qV8kAkwGsqKRDOWI0YPxQXR1gZ+9SfnYxHjRhQx296/2
 jrpPNJponyqhVczUTLpQEUaxRvO5ZhcMVT9Qo4x7B0lvgi/3kYbGJ+T9SRk3vTjC5QYO
 gFgiuAcSSyr54luC7ELLa37tPUf6RFviU6skqEl9frWV86x4KopIDoPKLlSvGc2etCf+
 RXj1Wmo1YwzwL9Ycv1uKKbcWG22ZLZi2n336jf9RpbIn02yJcpPv30QAo42SQuvZfNB+
 rfncCTR90YVJw8j/YvBHVTTbG1/hXxlXmMKcC0rELkx5KuLkWDZSAhP7ZQ6kRvsPLroa
 NKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783257483; x=1783862283;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3iQ6foKp7BWXNI7l7JdIldcj04hpvpDIkEePupB9eIQ=;
 b=WDCX0301t3t0RVsL2PbErqnR8z8k011wJNWQ02pucqS9LoPpMf1e//FoQI/yPpo3u4
 andtJZCe4CpNBE3YVj97IaR43V/T9TCsBzQCz9fcLxQDFPuMTdcKdqAYYgR4ftp7OByQ
 Vs1QjESyyadAvjG2iFfmks8f97z/1122ixL1CcOt4INtCgpqgupbD497mEqGFCWPgTna
 G17kZFF4pJ72whnMX6N5jW/D1JaYgR8wfZSMfIjGPDIEYZkfYudZ2g0R1DFlkQoEtu8X
 09ticKrtlihTx+2QBZg5GHbH4BRzUocfFi5pd/nNsyGvwmqtNed6v3H6gu29Eb3a+y2j
 JeZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8pODMcM4Dqf7vNvG/kJcajyibVQsblIx/jm3ms7dXR1a+vCVwVcHrn7AxKc4KE+nsSvUhn+3EuErIY@nongnu.org
X-Gm-Message-State: AOJu0Yx0LwC1NXZL90JbJT2IOxrQM6mGTx4tLUMtA49DGjLC6SrH6WIZ
 lpsBDBCZzTw6BYNXcwxuJNstsiKE3LS947hioTw5p+QHQizOCgqG5Ysj
X-Gm-Gg: AfdE7ckmMQ2xaJ5NaInj6fr+VnYkMRCNc7/YZSuz+IZTghYR2xeMpU6fSEDFXbxGx3K
 Py0pke2GhktlmjFAVEdxJPxGwnFQirUmCFaMHH1qCOqAucw9QpLd672OsnBMx4UooaeRgv5DrL2
 JQTtfQ9C7N6eGJk3z1TRfMWHLHNPZLd0a+V83L/i8duTACEHg+V7Jwkc7lSLvaYVeGqkoviDwjE
 jgYMs3SjbuKYxnEa1kYPAa2bZG6dkszjtX/+3g7m15wurRzEzNcnYcU9OACO42TuPK7MBSEGOks
 fuZUJXC4FFKfsZTsnj6SjmxN3wlE17t3cRs1ABiCj3BksxmINa8l+UeG8mt78LPtZTuQAWGriVo
 9rMYMGxgBvbE4AG8P1hFbXb9fI7i6nwoUrdXBA6GGRlxvY6yWFkw/0KR1mboCaXOSz4DoZt+bB4
 uzfoZ4J1Ua63qp1VPpyYBXuBKGJoYKY6+aq7aJDFP0CWoCpOGCLQaInKGfsMH36uvzg3O0
X-Received: by 2002:a05:600c:529a:b0:493:b7cb:c5f with SMTP id
 5b1f17b1804b1-493d11d7f58mr79902045e9.11.1783257482717; 
 Sun, 05 Jul 2026 06:18:02 -0700 (PDT)
Received: from user-Legion-Pro-5-16ARX8.. (cable-94-189-254-58.dynamic.sbb.rs.
 [94.189.254.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccd9d607sm259916135e9.2.2026.07.05.06.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 06:18:02 -0700 (PDT)
From: imaginos <imaginos32@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, imaginos <imaginos32@gmail.com>
Subject: [PATCH] target/riscv: check G-stage write permission for VS-stage A/D
 updates
Date: Sun,  5 Jul 2026 15:16:40 +0200
Message-ID: <20260705131734.13792-1-imaginos32@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=imaginos32@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

During a two-stage (VS-stage + G-stage) page-table walk with hardware
A/D updating enabled (Svadu / menvcfg.ADUE), a store that reaches a
VS-stage leaf PTE whose accessed or dirty bit is clear triggers a
hardware write-back of those bits into the PTE. That write-back is an
implicit store to the PTE's guest-physical address, so it must be
permitted by G-stage.

Fix this by re-running the G-stage translation of the guest PTE's
address with store semantics. get_physical_address() then also checks
that G-stage permits the guest PTE to be written, and raises a
guest-page store fault when it does not.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3426
Signed-off-by: imaginos <imaginos32@gmail.com>
---
 target/riscv/cpu_helper.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

 Verified against Spike, with this patch QEMU's
 reported values match Spike.

 Spike (reference):        QEMU, before this patch:
    mcause 0x17               mcause 0x17
    mtval  0x80000000         mtval  0x80000000
    mtval2 0x20001004         mtval2 0x20000000
    mtinst 0x3020             mtinst 0x6a704073

 If I've misread any of the A/D-update semantics here, I'd appreciate the
 correction.

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2db07f5dfb..3b4d2aea96 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1370,6 +1370,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     int ptshift;
     target_ulong pte;
     hwaddr pte_addr;
+    hwaddr pte_gpa = 0;
     const hwaddr base_root = base;
     const bool be = mo_endian_env(env) == MO_BE;
     int i;
@@ -1407,6 +1408,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             }
 
             pte_addr = vbase + idx * ptesize;
+            pte_gpa = base + idx * ptesize;
         } else {
             pte_addr = base + idx * ptesize;
         }
@@ -1661,6 +1663,28 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             return TRANSLATE_FAIL;
         }
 
+        /*
+         * The implicit store that writes updated A/D bits back to a VS-stage
+         * (first-stage) PTE must itself be permitted by G-stage. Re-run the
+         * second-stage translation of the PTE's guest-physical address with
+         * store semantics; if G-stage denies write, G-stage store fault
+         * against the PTE address.
+         */
+        if (two_stage && first_stage) {
+            int gpa_prot;
+            hwaddr gpa_paddr;
+            int gpa_ret = get_physical_address(env, &gpa_paddr, &gpa_prot,
+                                               pte_gpa, NULL, MMU_DATA_STORE,
+                                               MMUIdx_U, false, true,
+                                               is_debug, false);
+            if (gpa_ret != TRANSLATE_SUCCESS) {
+                if (fault_pte_addr) {
+                    *fault_pte_addr = pte_gpa >> 2;
+                }
+                return TRANSLATE_G_STAGE_FAIL;
+            }
+        }
+
         pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
                                            sxlen_bytes, MMU_DATA_STORE, PRV_S);
         if (pmp_ret != TRANSLATE_SUCCESS) {
@@ -2345,6 +2369,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                  * doing VS-stage page table walk.
                  */
                 tinst = (riscv_cpu_xlen(env) == 32) ? 0x00002000 : 0x00003000;
+
+                if (cause == RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT) {
+                    tinst |= 0x20;
+                }
             } else {
                 /*
                  * The "Addr. Offset" field in transformed instruction is
-- 
2.43.0


