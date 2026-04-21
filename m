Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BFAF327B3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF5GV-0003dt-RK; Tue, 21 Apr 2026 03:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF5GS-0003dR-9W
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:11:20 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF5GP-00044B-Sy
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:11:20 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-362bb3260f1so260005a91.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 00:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776755475; x=1777360275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1ffO50MMxG2IDWSSIbiX+9kzNZ5vhwSUgSE0rk877XE=;
 b=gg8LFrYR9ZI3LCETgkkhUQcq0TzF9NaZvmB3Wx7pTCiBQyqosb1FWQwHEkrNIn6CyD
 O+LnGGsXmj5DIhxL/ZKmcPl6r03qjltwdNr042Z5iHh79gZ0eHmBhJinuaPgF8c7LAVt
 Mna6M4nrPMd4lJLBNnGObf09BtQ4ap8XzwtlJFPEgr5wbYlEG7eEYoTLYvGdbtSMz+q0
 usA3zNa9OruL7gJgEMlywP2zVHGVcT+wRUBuuTz/U6K5MwBuX4cUCdCowFYf4jq3PzZH
 rWd5wAqi0NhwcoeC3yZFMVOOCDaY+o7EmHWJYc5HjnXO5S9X0xnPP+td9LjCkLKjwF4+
 eg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776755475; x=1777360275;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ffO50MMxG2IDWSSIbiX+9kzNZ5vhwSUgSE0rk877XE=;
 b=GFYz39PfawyEpJei/oE2SAevFuxy2cQqw2wmwO0LuxrlQmjtLe5q/zXVdSf1VX0z2Q
 Y12ovGxIPbmq6F17+qWXvukT5uMy1wolr23KOxh/TV6GHntw4RJK0/eyFdtqlvI0C9zc
 Q0MEkdn5JeXfRQxd0K4ZueAxQKSxQkldhbV/wswYYzS9yk5K3GsWGuH8CMqWsNicak1V
 GpaEusndqNn/lfMLcvlc+7Amt1LQPPzfl8dS8SrYEpKkEHvBUjqzTQBORiyiSA0dOKUc
 H1pOrn6EgfDAcHDP4h1Thwc0DFBg5QDkWFu0q8U9RH7tFi2Y+D/t8wS2y3dMM4c/m0sb
 pwrQ==
X-Gm-Message-State: AOJu0YykvvcJDxbab7+JEZ0czxzu8ooG4JTq6G+xAWi8WLl0jo+77GJm
 QPYfqN58AqOjqzJLjJL40e+CmJhAZIcmecW4T7nkW63/UlAW70JoBI7h5VxLmCaWqZcrQqBbnsp
 OP1qs4FyYlE9pVOwK9pyDAI+Uv0yzTnLxnJ8ZPTMl/InzTdXy2p/mbkbtOd2eVmdwlXj46iPOPo
 ZSuB5FSlkEZ7obGCyVzVIRKa61PQN/4zbMtwQPXFZQ19UqfVW8
X-Gm-Gg: AeBDievWrtpF/2su4Da0ic7VBh6Ah8pgMjRQdPm4gVrWCHRYmlbilEDXJ7gdEi2xFSB
 Jf4DrBN4fLFfbxhZQGHezpqZ8w7tQFdmwUHjQr2OuYHdAX94T04qZXkmfNHxkJMG9UzQ5+SMPJR
 XL+vB5hYi7sbEx4KdbgSdmz+PWkWdPhAcj+XcTwJHnOdoD+eeXZ74eNGx9Z59FbkmPJ3h5mZkG7
 1IufW/dkw/a4sB4Jb3WEMwrXG5uY4gCM8L5+uhkBr58FBNKzTnBANIpbsMjh32RbKqCMfH7tlHF
 iZsJVF4Bbn3s1oBbXCfJrQEO2LhWotqy9zplSWoHFiFezxiHdgOMfm08R3CKT0f8HgEoDfqm24N
 eW0BVjoDH67vAJ0VQIw/1wZBCGew/NTSTJn2iNpaDUJqQBPiUz+1lMbXFST3ko7yz1uXp4wXq4t
 PZC7mwKopoja+h+fmGZ+OIApXcGjnCvuod5+r68O44HwtWD7U7cmUzTSx+SqVE
X-Received: by 2002:a17:90b:3950:b0:35f:b714:e516 with SMTP id
 98e67ed59e1d1-361404659e2mr16246064a91.16.1776755474983; 
 Tue, 21 Apr 2026 00:11:14 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f9cacasm10674709a12.8.2026.04.21.00.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 00:11:14 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3] target/riscv: Initialize riscv_excp_names[] and
 riscv_intr_names[] using designated initializer
Date: Tue, 21 Apr 2026 15:11:07 +0800
Message-ID: <20260421071107.2848439-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1033.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Use designated initializers to initialize riscv_excp_names[] and
riscv_intr_names[] so that we don't have to explicitly add "reserved"
items. Also, add the missing trap names: sw_check, hw_error,
virt_illegal_instruction, semihost, s_guest_external, and
counter_overflow.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.c | 89 +++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 44 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 72c6f4f0f14..ce15a17c37d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -328,60 +328,61 @@ const char * const riscv_rvv_regnames[] = {
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


