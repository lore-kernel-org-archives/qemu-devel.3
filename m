Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C989FF886D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 17:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHm6d-0003LO-70; Tue, 28 Apr 2026 13:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanjiewtw@gmail.com>)
 id 1wHkXw-0005Zz-PR
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:40:24 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanjiewtw@gmail.com>)
 id 1wHkXs-0007no-RU
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:40:24 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c70c112cb61so7575391a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777390816; x=1777995616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DhlNy2l7cJVTYuDoPsfamzM3U+g7x1THoUSGf0UMe5o=;
 b=oUAz1uyALKWGEyJBYSs86RkFvyRFdwTpXBMWpLG1hCy4a942xZa2JbFZcI9F1LwCSI
 SRxgkdn0tkARcd6uswu68cwvAszy9byj3cXykcwWgq7ovbxTq3f9pMCAwPrG5hfqXhFa
 Pv0OHUrhZ4ucJ5EX4IcSosxuaS9JuDb36s3Xu+yLa6IjEos+dL4ZO1M5UAGSmTgpv5KZ
 XyzGKk1G+ek0imp6X3kq/c0Q9P9zRgkbq0ALnfTXJ8QReAVb1ZZT5JyY0Xonaulcqh3j
 r3SJ4ZIthADjw+YhdSrpBThDjLyaTkNyyLTXwfB8Dy/x3K4vqXgYd2OO+6/JsjELzOfH
 KPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777390816; x=1777995616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DhlNy2l7cJVTYuDoPsfamzM3U+g7x1THoUSGf0UMe5o=;
 b=YUZW1A7bYMPx2IXn17DOgzzWuJvBjIDEvK+m5I6P2T1JLbL8fBJr4YrlUhv/XYLEd8
 HWuGc8it39upeYf3mAUG3RH9EDSNcUn/rGVBxMRypjQ4odxeNFMB7maAc6oMqIw5e1nL
 1W1eTuRPK8PEw7ChisacIdWuJ25syOe9a3LsD4jl2r9JI4/RzPSky9lVjmYAndtYPIcl
 IqRbIPpLUCOrAsKTZKEEz+qyCq/0OxrCh1K4LATbLbF73UAKnhp523ivUbZb5bcgurcC
 Qne5/LWRArlV2OXM8Ek/fhxBCZD2HeOFgO+GPKTx3cWYfH2yHclwtG2nx5JL/2m11n+E
 7tGQ==
X-Gm-Message-State: AOJu0YwPUscYybpubNoA0H/y1zaDM65raoFFVBJu2xKTCzfbZh6jUuoH
 R8t1mIWSJ8Wu7U8Tx4gDeLDQpC2C1jYWGeapiwmZNANCwp7gW7ZplOU2oKaC3PdQ6+8=
X-Gm-Gg: AeBDieuQ1esVq3RkouWJ1j9UjthPkRm6iKww8mIflM4Jw0qieKBNxuS1V8t2xAMCtOk
 cmBsAxP8hPx3pJMdqkxE1wZz1jvDk0/pR+v4RLfbbSvx72HWbcuyDY42GXxmCAa+6xlStNbvW6r
 iyJi62gnMyT6x4Ck6eTvoN6yf65tYDdyB5G8VI0flQbm+wZNkSeYXo7Fwmu+nTAl8cgb8OOHMeD
 us3uDy90gN7h485WdeEf3mnAtPa1B9Q11K3/E5pqq5Ry6S48EdYSjGHDDxK5KGj1yYYecfya90k
 SIVs5Q8dIjaBeBxzKOPBDnR+7SlSEMjQPzg6FMA3mLlxZp+tkm9M7xSJZnnxIk40y5ZNhF04pnL
 +KaqHPQIblcYGudVCbtHr22vvansFAgQ4xacYquc4/UfwZPTKuqgryXc570jUwE91u3ehZx/6rT
 1QuyW9SJ6+0owH6pLnJ9hCwJnvIjZk9xntkhI0utkpb5WB9xy8DDyXs54/JTszZOYBBc3Kv+r5p
 2Gzi4uvBVT+Mleglg4tNveEIsvYbFKYLqd95aKq3LKdRw==
X-Received: by 2002:a05:6a00:1d8e:b0:82f:250b:9f1b with SMTP id
 d2e1a72fcca58-834ddbbffdfmr3863710b3a.23.1777390815401; 
 Tue, 28 Apr 2026 08:40:15 -0700 (PDT)
Received: from YanJie-Laptop
 (2001-b011-3817-7976-54ea-e6f1-3f33-d05a.dynamic-ip6.hinet.net.
 [2001:b011:3817:7976:54ea:e6f1:3f33:d05a])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834daf624d9sm3056952b3a.43.2026.04.28.08.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 08:40:14 -0700 (PDT)
From: Yan-Jie Wang <yanjiewtw@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yan-Jie Wang <yanjiewtw@gmail.com>
Subject: [PATCH] hw/i386/vapic: revalidate TPR instruction before patching
Date: Tue, 28 Apr 2026 23:39:46 +0800
Message-ID: <20260428153946.1802-1-yanjiewtw@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=yanjiewtw@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 28 Apr 2026 13:20:17 -0400
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

The kvmvapic TPR optimization identifies a guest TPR access
instruction and queues do_patch_instruction() via async_safe_run_on_cpu()
to patch the instruction later.

In a 32-bit Windows XP guest with multiple vCPUs, I observed that when the
guest is about to reboot, several vCPUs may execute the same TPR access
instruction at nearly the same time. This can queue multiple patch
operations for the same guest IP before any queued patch operation has
completed.

The first queued work item may successfully patch the instruction. Later
queued work items then re-read the same guest IP and observe the already
patched instruction bytes instead of the original TPR instruction. For
example, opcode 0x8b may already have been replaced with 0x90. The old
code treats this as an unexpected opcode and aborts QEMU.

Record the matched instruction bytes before queuing the patch operation,
and re-read and compare the instruction before patching it. If the
instruction has already changed, leave it unchanged instead of aborting.

Use warn_report_once() only for unexpected internal consistency failures,
so the normal multi-vCPU already-patched case remains silent.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3296
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3451

Signed-off-by: Yan-Jie Wang <yanjiewtw@gmail.com>
---
 hw/i386/vapic.c | 112 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 87 insertions(+), 25 deletions(-)

diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 1acb9f91b2..1e16780008 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -25,6 +25,7 @@
 #include "exec/cpu-common.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
+#include "qemu/error-report.h"
 
 #define VAPIC_IO_PORT           0x7e
 
@@ -80,6 +81,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VAPICROMState, VAPIC)
 
 #define TPR_INSTR_ABS_MODRM             0x1
 #define TPR_INSTR_MATCH_MODRM_REG       0x2
+#define TPR_INSTR_MAX_LENGTH            10
 
 typedef struct TPRInstruction {
     uint8_t opcode;
@@ -194,7 +196,7 @@ static bool is_abs_modrm(uint8_t modrm)
     return (modrm & 0xc7) == 0x05;
 }
 
-static bool opcode_matches(uint8_t *opcode, const TPRInstruction *instr)
+static bool opcode_matches(const uint8_t *opcode, const TPRInstruction *instr)
 {
     return opcode[0] == instr->opcode &&
         (!(instr->flags & TPR_INSTR_ABS_MODRM) || is_abs_modrm(opcode[1])) &&
@@ -203,12 +205,13 @@ static bool opcode_matches(uint8_t *opcode, const TPRInstruction *instr)
 }
 
 static int evaluate_tpr_instruction(VAPICROMState *s, X86CPU *cpu,
-                                    target_ulong *pip, TPRAccess access)
+                                    target_ulong *pip, uint8_t *instr_bytes,
+                                    size_t *pinstr_len, TPRAccess access)
 {
     CPUState *cs = CPU(cpu);
     const TPRInstruction *instr;
     target_ulong ip = *pip;
-    uint8_t opcode[2];
+    size_t instr_len = 0;
     uint32_t real_tpr_addr;
     int i;
 
@@ -239,26 +242,44 @@ static int evaluate_tpr_instruction(VAPICROMState *s, X86CPU *cpu,
          */
         for (i = 0; i < ARRAY_SIZE(tpr_instr); i++) {
             instr = &tpr_instr[i];
+            instr_len = instr->length;
+            if (instr_len > TPR_INSTR_MAX_LENGTH) {
+                warn_report_once("kvmvapic: TPR instruction length %zu "
+                                 "exceeds maximum %d",
+                                 instr_len, TPR_INSTR_MAX_LENGTH);
+                return -1;
+            }
             if (instr->access != access) {
                 continue;
             }
-            if (cpu_memory_rw_debug(cs, ip - instr->length, opcode,
-                                    sizeof(opcode), 0) < 0) {
+            if (cpu_memory_rw_debug(cs, ip - instr_len, instr_bytes,
+                                    instr_len, 0) < 0) {
                 return -1;
             }
-            if (opcode_matches(opcode, instr)) {
+            if (opcode_matches(instr_bytes, instr)) {
                 ip -= instr->length;
                 goto instruction_ok;
             }
         }
         return -1;
     } else {
-        if (cpu_memory_rw_debug(cs, ip, opcode, sizeof(opcode), 0) < 0) {
-            return -1;
-        }
         for (i = 0; i < ARRAY_SIZE(tpr_instr); i++) {
             instr = &tpr_instr[i];
-            if (opcode_matches(opcode, instr)) {
+            if (instr->length > TPR_INSTR_MAX_LENGTH) {
+                warn_report_once("kvmvapic: TPR instruction length %zu "
+                                 "exceeds maximum %d",
+                                 instr->length, TPR_INSTR_MAX_LENGTH);
+                return -1;
+            }
+            /* tpr_instr must be sorted by length with shortest first */
+            if (instr->length > instr_len) {
+                instr_len = instr->length;
+                if (cpu_memory_rw_debug(cs, ip, instr_bytes,
+                                        instr_len, 0) < 0) {
+                    return -1;
+                }
+            }
+            if (opcode_matches(instr_bytes, instr)) {
                 goto instruction_ok;
             }
         }
@@ -270,11 +291,14 @@ instruction_ok:
      * Grab the virtual TPR address from the instruction
      * and update the cached values.
      */
-    if (cpu_memory_rw_debug(cs, ip + instr->addr_offset,
-                            (void *)&real_tpr_addr,
-                            sizeof(real_tpr_addr), 0) < 0) {
+    if (instr->addr_offset + sizeof(real_tpr_addr) > instr->length) {
+        warn_report_once(
+            "kvmvapic: TPR address offset %zu exceeds instruction length %zu",
+            (size_t)instr->addr_offset, instr->length);
         return -1;
     }
+    memcpy(&real_tpr_addr, instr_bytes + instr->addr_offset,
+           sizeof(real_tpr_addr));
     real_tpr_addr = le32_to_cpu(real_tpr_addr);
     if ((real_tpr_addr & 0xfff) != 0x80) {
         return -1;
@@ -283,6 +307,7 @@ instruction_ok:
     update_guest_rom_state(s);
 
     *pip = ip;
+    *pinstr_len = instr->length;
     return 0;
 }
 
@@ -403,6 +428,8 @@ static void patch_call(X86CPU *cpu, target_ulong ip, uint32_t target)
 typedef struct PatchInfo {
     VAPICHandlers *handler;
     target_ulong ip;
+    size_t instr_len;
+    uint8_t instr[TPR_INSTR_MAX_LENGTH];
 } PatchInfo;
 
 static void do_patch_instruction(CPUState *cs, run_on_cpu_data data)
@@ -411,19 +438,33 @@ static void do_patch_instruction(CPUState *cs, run_on_cpu_data data)
     PatchInfo *info = (PatchInfo *) data.host_ptr;
     VAPICHandlers *handlers = info->handler;
     target_ulong ip = info->ip;
-    uint8_t opcode[2];
+    size_t instr_len = info->instr_len;
+    uint8_t instr[TPR_INSTR_MAX_LENGTH];
     uint32_t imm32 = 0;
 
-    cpu_memory_rw_debug(cs, ip, opcode, sizeof(opcode), 0);
+    /*
+     * The instruction may have changed before this queued work item runs.
+     * Leave it unchanged if it no longer matches the saved bytes.
+     */
+    if (instr_len == 0 || instr_len > TPR_INSTR_MAX_LENGTH) {
+        warn_report_once(
+            "kvmvapic: saved TPR instruction length %zu is invalid",
+            instr_len);
+        goto out;
+    }
+    if (cpu_memory_rw_debug(cs, ip, instr, instr_len, 0) < 0
+        || memcmp(instr, info->instr, instr_len) != 0) {
+        goto out;
+    }
 
-    switch (opcode[0]) {
+    switch (instr[0]) {
     case 0x89: /* mov r32 to r/m32 */
-        patch_byte(x86_cpu, ip, 0x50 + modrm_reg(opcode[1]));  /* push reg */
+        patch_byte(x86_cpu, ip, 0x50 + modrm_reg(instr[1]));  /* push reg */
         patch_call(x86_cpu, ip + 1, handlers->set_tpr);
         break;
     case 0x8b: /* mov r/m32 to r32 */
         patch_byte(x86_cpu, ip, 0x90);
-        patch_call(x86_cpu, ip + 1, handlers->get_tpr[modrm_reg(opcode[1])]);
+        patch_call(x86_cpu, ip + 1, handlers->get_tpr[modrm_reg(instr[1])]);
         break;
     case 0xa1: /* mov abs to eax */
         patch_call(x86_cpu, ip, handlers->get_tpr[0]);
@@ -432,8 +473,14 @@ static void do_patch_instruction(CPUState *cs, run_on_cpu_data data)
         patch_call(x86_cpu, ip, handlers->set_tpr_eax);
         break;
     case 0xc7: /* mov imm32, r/m32 (c7/0) */
+        if (sizeof(imm32) + 6 > instr_len) {
+            warn_report_once(
+                "kvmvapic: TPR mov-imm instruction length %zu is too short",
+                instr_len);
+            goto out;
+        }
         patch_byte(x86_cpu, ip, 0x68);  /* push imm32 */
-        cpu_memory_rw_debug(cs, ip + 6, (void *)&imm32, sizeof(imm32), 0);
+        memcpy(&imm32, instr + 6, sizeof(imm32));
         cpu_memory_rw_debug(cs, ip + 1, (void *)&imm32, sizeof(imm32), 1);
         patch_call(x86_cpu, ip + 5, handlers->set_tpr);
         break;
@@ -442,13 +489,18 @@ static void do_patch_instruction(CPUState *cs, run_on_cpu_data data)
         patch_call(x86_cpu, ip + 1, handlers->get_tpr_stack);
         break;
     default:
-        abort();
+        warn_report_once("kvmvapic: unexpected TPR instruction opcode 0x%02x "
+                         "while patching; leaving instruction unchanged",
+                         instr[0]);
+        break;
     }
 
+out:
     g_free(info);
 }
 
-static void patch_instruction(VAPICROMState *s, X86CPU *cpu, target_ulong ip)
+static void patch_instruction(VAPICROMState *s, X86CPU *cpu, target_ulong ip,
+                              const uint8_t *instr_bytes, size_t instr_len)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     CPUState *cs = CPU(cpu);
@@ -461,10 +513,18 @@ static void patch_instruction(VAPICROMState *s, X86CPU *cpu, target_ulong ip)
         handlers = &s->rom_state.mp;
     }
 
-    info  = g_new(PatchInfo, 1);
+    if (instr_len == 0 || instr_len > TPR_INSTR_MAX_LENGTH) {
+        warn_report_once(
+            "kvmvapic: not patching invalid TPR instruction length %zu",
+            instr_len);
+        return;
+    }
+
+    info = g_new(PatchInfo, 1);
     info->handler = handlers;
     info->ip = ip;
-
+    info->instr_len = instr_len;
+    memcpy(info->instr, instr_bytes, instr_len);
     async_safe_run_on_cpu(cs, do_patch_instruction, RUN_ON_CPU_HOST_PTR(info));
 }
 
@@ -474,10 +534,12 @@ void vapic_report_tpr_access(DeviceState *dev, CPUState *cs, target_ulong ip,
     VAPICROMState *s = VAPIC(dev);
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    size_t instr_len;
+    uint8_t instr[TPR_INSTR_MAX_LENGTH];
 
     cpu_synchronize_state(cs);
 
-    if (evaluate_tpr_instruction(s, cpu, &ip, access) < 0) {
+    if (evaluate_tpr_instruction(s, cpu, &ip, instr, &instr_len, access) < 0) {
         if (s->state == VAPIC_ACTIVE) {
             vapic_enable(s, cpu);
         }
@@ -489,7 +551,7 @@ void vapic_report_tpr_access(DeviceState *dev, CPUState *cs, target_ulong ip,
     if (vapic_enable(s, cpu) < 0) {
         return;
     }
-    patch_instruction(s, cpu, ip);
+    patch_instruction(s, cpu, ip, instr, instr_len);
 }
 
 typedef struct VAPICEnableTPRReporting {
-- 
2.47.3


