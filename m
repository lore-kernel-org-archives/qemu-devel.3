Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AEED74956
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 04:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWRoR-0007Rv-03; Thu, 18 Dec 2025 23:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vWRoP-0007R8-5i
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 23:09:53 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vWRoN-0006kl-GH
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 23:09:52 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c13771b2cf9so1144919a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 20:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1766117389; x=1766722189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lrQstgbOdohjKT9UsosqTVA57ADE7sn5QtCMbQQgfJE=;
 b=Zj9E95Yn71XIZeRRRPOL6KeCiHe3/RPVcZmtF0u1lQnmocuHku85tYIicJ6vQfA3QI
 yOfeP2dUjwQ3/kcL+2em1MS5v/Fb+aZFns6Zb/ivDl/XVMYaV0gBhyZhkg9fe/X1DDtp
 tAu92ps/8yQU9Lnzg950N5jqshonM9t/Q91PAFgPyD7ADFUnnMRt/rDa47pvm0iawune
 9iUKJWw4EOS4WWIXQPYZknsLnYdKouaBqAMzPe83op4lTZM5PDNz8vHpb4InAJfU52Wu
 6doamI0wVTykx5mFG1td/tDjS5oNO7b9DWNHIcozQvz+B0aS+9bNQePg0Cm+ejLG/6if
 BwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766117390; x=1766722190;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lrQstgbOdohjKT9UsosqTVA57ADE7sn5QtCMbQQgfJE=;
 b=Q2lcxOCQ1C2OEdoFja0pobQBTo08aMssuOpYB6PDHxE+U4h8wCo9AC4Lf+qeROp7gf
 lv+uyUMJA6DD4vkFdaEOSUC3CTwUzT00B4AigP+iHmaPtfrk7k5ClmybzKc5zpw7ENnA
 BBo63Q1YENwf5706HAMHQU5w3DDyHu0idON2/TvRXx793cxC6A8gR6YwxEL+UkO0AuCl
 3UYO+XjwDIQ6orzUwRt2aIOeSa6DcosZXYnEPLKbcwbudIDluPtHarBDZ+VY08O35/0P
 CQh8dapg2C1GVYgHvRSjoFhD7kuE8i8k6FcQCvnCXD8OTnMzZoWqbWhPBCNo6tGlGIWG
 Iajw==
X-Gm-Message-State: AOJu0YxHg13G1j8IyMDdkR7ONU6pCctHIA2U47mzvB0hoF0789TNXptj
 hVdamIK78GJxJt2hyFD8vqBg5yUIbCGpK3G4pqJCNIBYAXkc6cUwKiL3Y0FxQFJ99QJBLtZeAJU
 h6BKDvyUBXbLjs5+EAWWdjeWsqdZBVXcOgEmZKfSfqgclcNmXsEtcA1ZepMwJAo8dNG8okMSS7+
 dZnITkmNUM9udAM154VF8M+ylC4yXn86GZ/4BEbLQfcctdAQ==
X-Gm-Gg: AY/fxX5wKK3ol561n65b95D/ey8DJ2/tUs0Y4fi90HdpFT+PhplAPRedE8PY6df4zYK
 hvpWo3l+iUDL/ehkGSiVw+ZsqPmG3igPnpTWT8+hxCoV6nLMHG37G+TfbLyfJKXPHUhaxeXjK6f
 2jvODIJAPAAnGgaHVNy1GoUSFkU7qTwB2DNyTvZEOzlpty9SRvgGc1Q6kHNwRpimb0jCEurMBah
 sI6ZkJZ/TU+iw2g8sFMzdzwQHiRa/jiUv7KDhLBHK8oIzmg1n4YuvLUm1q96aTxL72SkXubQPpB
 pFFw1H8Ar6BTrRfyYX19QOqHFj8klFCDCassv1oAjVS3vCiK8q6o04Tk+KFM60glbYVcVHvs4kA
 nz5Jv+xLWuCRhBwPtuN+TFfMdqCLW+acssRivxDxEMATJP5ZXqyc16nMCSPOyC3V5MGFD6CbzAN
 3yFNFZ8R58Wjherg4qCqfPoEeMlCHlaGkzaxTC8xdjjFMVmhep
X-Google-Smtp-Source: AGHT+IH6Wx/p5kzzX7hPGMFooztXwgEKjCy3FnLPW1BeQRC5mJPP+RhTzh2ul6rD5AFJAHKk1yb7bQ==
X-Received: by 2002:a05:701b:2406:b0:119:e569:f611 with SMTP id
 a92af1059eb24-121721ac01amr1260865c88.10.1766117389219; 
 Thu, 18 Dec 2025 20:09:49 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1217253c23csm4144568c88.9.2025.12.18.20.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 20:09:48 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2] target/riscv: Initialize riscv_excp_names[] and
 riscv_intr_names[] using designated initializer
Date: Fri, 19 Dec 2025 12:09:43 +0800
Message-ID: <20251219040943.1570449-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x534.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Use designated initializers to initialize riscv_excp_names[] and
riscv_intr_names[] so that we don't have to explicitly add "reserved"
items. Also, add the missing trap names: sw_check, hw_error,
virt_illegal_instruction, semihost, s_guest_external, and
counter_overflow.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 89 +++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 44 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index aa58ba8b99a..ee859093f78 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -305,60 +305,61 @@ const char * const riscv_rvv_regnames[] = {
 };
 
 static const char * const riscv_excp_names[] = {
-    "misaligned_fetch",
-    "fault_fetch",
-    "illegal_instruction",
-    "breakpoint",
-    "misaligned_load",
-    "fault_load",
-    "misaligned_store",
-    "fault_store",
-    "user_ecall",
-    "supervisor_ecall",
-    "hypervisor_ecall",
-    "machine_ecall",
-    "exec_page_fault",
-    "load_page_fault",
-    "reserved",
-    "store_page_fault",
-    "double_trap",
-    "reserved",
-    "reserved",
-    "reserved",
-    "guest_exec_page_fault",
-    "guest_load_page_fault",
-    "reserved",
-    "guest_store_page_fault",
+    [RISCV_EXCP_INST_ADDR_MIS] = "misaligned_fetch",
+    [RISCV_EXCP_INST_ACCESS_FAULT] = "fault_fetch",
+    [RISCV_EXCP_ILLEGAL_INST] = "illegal_instruction",
+    [RISCV_EXCP_BREAKPOINT] = "breakpoint",
+    [RISCV_EXCP_LOAD_ADDR_MIS] = "misaligned_load",
+    [RISCV_EXCP_LOAD_ACCESS_FAULT] = "fault_load",
+    [RISCV_EXCP_STORE_AMO_ADDR_MIS] = "misaligned_store",
+    [RISCV_EXCP_STORE_AMO_ACCESS_FAULT] = "fault_store",
+    [RISCV_EXCP_U_ECALL] = "user_ecall",
+    [RISCV_EXCP_S_ECALL] = "supervisor_ecall",
+    [RISCV_EXCP_VS_ECALL] = "hypervisor_ecall",
+    [RISCV_EXCP_M_ECALL] = "machine_ecall",
+    [RISCV_EXCP_INST_PAGE_FAULT] = "exec_page_fault",
+    [RISCV_EXCP_LOAD_PAGE_FAULT] = "load_page_fault",
+    [RISCV_EXCP_STORE_PAGE_FAULT] = "store_page_fault",
+    [RISCV_EXCP_DOUBLE_TRAP] = "double_trap",
+    [RISCV_EXCP_SW_CHECK] = "sw_check",
+    [RISCV_EXCP_HW_ERR] = "hw_error",
+    [RISCV_EXCP_INST_GUEST_PAGE_FAULT] = "guest_exec_page_fault",
+    [RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT] = "guest_load_page_fault",
+    [RISCV_EXCP_VIRT_INSTRUCTION_FAULT] = "virt_illegal_instruction",
+    [RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT] = "guest_store_page_fault",
+    [RISCV_EXCP_SEMIHOST] = "semihost",
 };
 
 static const char * const riscv_intr_names[] = {
-    "u_software",
-    "s_software",
-    "vs_software",
-    "m_software",
-    "u_timer",
-    "s_timer",
-    "vs_timer",
-    "m_timer",
-    "u_external",
-    "s_external",
-    "vs_external",
-    "m_external",
-    "reserved",
-    "reserved",
-    "reserved",
-    "reserved"
+    [IRQ_U_SOFT] = "u_software",
+    [IRQ_S_SOFT] = "s_software",
+    [IRQ_VS_SOFT] = "vs_software",
+    [IRQ_M_SOFT] = "m_software",
+    [IRQ_U_TIMER] = "u_timer",
+    [IRQ_S_TIMER] = "s_timer",
+    [IRQ_VS_TIMER] = "vs_timer",
+    [IRQ_M_TIMER] = "m_timer",
+    [IRQ_U_EXT] = "u_external",
+    [IRQ_S_EXT] = "s_external",
+    [IRQ_VS_EXT] = "vs_external",
+    [IRQ_M_EXT] = "m_external",
+    [IRQ_S_GEXT] = "s_guest_external",
+    [IRQ_PMU_OVF] = "counter_overflow",
 };
 
 const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
 {
     if (async) {
-        return (cause < ARRAY_SIZE(riscv_intr_names)) ?
-               riscv_intr_names[cause] : "(unknown)";
+        if ((cause < ARRAY_SIZE(riscv_intr_names)) && riscv_intr_names[cause]) {
+            return riscv_intr_names[cause];
+        }
     } else {
-        return (cause < ARRAY_SIZE(riscv_excp_names)) ?
-               riscv_excp_names[cause] : "(unknown)";
+        if ((cause < ARRAY_SIZE(riscv_excp_names)) && riscv_excp_names[cause]) {
+            return riscv_excp_names[cause];
+        }
     }
+
+    return "(unknown)";
 }
 
 void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)
-- 
2.43.0


