Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06ACC02193
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZCS-0003yF-4o; Thu, 30 Jan 2025 13:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCE-0003sD-50
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:22 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCA-0000Ua-Ab
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:20 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38a8b35e168so719154f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261397; x=1738866197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQ3INqN7YHVgBd+O3rmiUMiDsje4n5n7QZ4vk3TY7Qg=;
 b=adPNNor4Zl2AIbZ0M3hbvRhjIJIKL/81vd7CL4Avcqu4lXaFKxVzKDlx8D7y/uEmnB
 PTv+31bPpd5eewclFdbrGCPpdSdAw0NezTPrh9T0+cSpuUoQGaFi3U/a4oRg/QjvVKaT
 sTxqU0R8Adnzx86PQ/xY/S2Vv68a3gCumb6j9DJxO0K1kRLCZ5KO/5iXmW4Mlatk/fZu
 vgemYuO0p+v3lCajnC7YOL8mba+dRHFSEf5MATNARx0qAAp84a52egRlYjBbUq/H8oUq
 US2gVbt1VXNT5A2mLb4O/igPn0NM8plGDwMcfsPqRykE04QwykAlYhnf8vK+eDVQliAs
 XTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261397; x=1738866197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQ3INqN7YHVgBd+O3rmiUMiDsje4n5n7QZ4vk3TY7Qg=;
 b=rpdLc56yXVotH0Vs8EyiBTN9GFD7hhOlsp/upIr3CxXhvRJ16HXsjLylX3ByTN17ZD
 8YPKF5LB1Ebpr7hMIw2ACitxxVi6WMBj6yY5uyjefsLy0X6rjiG/ct56ijzod7kccAek
 Sn8sB4k4F+bgndOtdNZCRlSxiS5k6DBz+tQWaetT7xqDhz3eBYBV9N3dHiBdSDhnAcgg
 bQuhB1NTdRt7MFGCqA+4dxU/4TQWFsmU+bvfYDFvLnIzv299qWsEB1wmYljWo0Y4hoiu
 yTNADoeGoP0LQvA/eGCHQ4NbXNdo5c2KmECIyxCsr96fZUmMJpRNY93svW1fb5QMcNjw
 m91Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2iIt0UaTqeaUCgBwZ5+CtPgcLSHI1S4krZi+TL5ktIhbj402XsR6Fd3pobM2sBOJEBB4vUyU85hW2@nongnu.org
X-Gm-Message-State: AOJu0YzoGCNtLBT82I+z4BsOKgo2NdIEh4Q8x3EWZLhXrAzs3VfJO3BO
 i2ULKC3hTVvICXesf3/pOJEoYv/Wl6vOWwr4V+PaUBazlgtsA5Mh6lAEL0ym5Mg=
X-Gm-Gg: ASbGncuKewgSoGnpeI1yg6ps1BhX84Ewbjfk5dZdLn78MFg95gBDkewLdBD/etSTyx7
 Afz1ex152mYOQoJlRkl2PX34LfdBbqHrNNas6QO5u4c43zviMzeB/Y/nL+4yaYij2S3fmCLPRWc
 6+8hdZV0p0CofOpxJ6bBNDr+i3ytD7n7evXaZj0CfsjDWJY6YkWSnlsbgYIwytMHKWMJCNN2uOV
 05bXyPZJk9pjtArmunse6vLjj+T5Cq6r8+3cQDdplUTYicMIx+xvne/PXzwFVaGc/dH6S05Fsg2
 6AJtkZv7M3JYZ7sA06jwxA==
X-Google-Smtp-Source: AGHT+IFk46o9MJfRxDQ5fp1zop2gX0pBdlLuXLQqomMqheDgghI/upyTVaZIVnOv9Ncrv7Wp4oLxvQ==
X-Received: by 2002:a05:6000:1fae:b0:38a:a019:30dd with SMTP id
 ffacd0b85a97d-38c5a96f0b7mr3987385f8f.8.1738261396692; 
 Thu, 30 Jan 2025 10:23:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c101599sm2634426f8f.23.2025.01.30.10.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 10:23:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 05/14] target/arm: Make CP_ACCESS_TRAPs to AArch32 EL3 be
 Monitor traps
Date: Thu, 30 Jan 2025 18:23:00 +0000
Message-Id: <20250130182309.717346-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130182309.717346-1-peter.maydell@linaro.org>
References: <20250130182309.717346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In system register access pseudocode the common pattern for
AArch32 registers with access traps to EL3 is:

at EL1 and EL2:
  if HaveEL(EL3) && !ELUsingAArch32(EL3) && (SCR_EL3.TERR == 1) then
     AArch64.AArch32SystemAccessTrap(EL3, 0x03);
  elsif HaveEL(EL3) && ELUsingAArch32(EL3) && (SCR.TERR == 1) then
     AArch32.TakeMonitorTrapException();
at EL3:
  if (PSTATE.M != M32_Monitor) && (SCR.TERR == 1) then
     AArch32.TakeMonitorTrapException();

(taking as an example the ERRIDR access pseudocode).

This implements the behaviour of (in this case) SCR.TERR that
"Accesses to the specified registers from modes other than Monitor
mode generate a Monitor Trap exception" and of SCR_EL3.TERR that
"Accesses of the specified Error Record registers at EL2 and EL1
are trapped to EL3, unless the instruction generates a higher
priority exception".

In QEMU we don't implement this pattern correctly in two ways:
 * in access_check_cp_reg() we turn the CP_ACCESS_TRAP_EL3 into
   an UNDEF, not a trap to Monitor mode
 * in the access functions, we check trap bits like SCR.TERR
   only when arm_current_el(env) < 3 -- this is correct for
   AArch64 EL3, but misses the "trap non-Monitor-mode execution
   at EL3 into Monitor mode" case for AArch32 EL3

In this commit we fix the first of these two issues, by
making access_check_cp_reg() handle CP_ACCESS_TRAP_EL3
as a Monitor trap. This is a kind of exception that we haven't
yet implemented(!), so we need a new EXCP_MON_TRAP for it.

This diverges from the pseudocode approach, where every access check
function explicitly checks for "if EL3 is AArch32" and takes a
monitor trap; if we wanted to be closer to the pseudocode we could
add a new CP_ACCESS_TRAP_MONITOR and make all the accessfns use it
when appropriate.  But because there are no non-standard cases in the
pseudocode (i.e.  where either it raises a Monitor trap that doesn't
correspond to an AArch64 SystemAccessTrap or where it raises a
SystemAccessTrap that doesn't correspond to a Monitor trap), handling
this all in one place seems less likely to result in future bugs
where we forgot again about this special case when writing an
accessor.

(The cc of stable here is because "hw/intc/arm_gicv3_cpuif: Don't
downgrade monitor traps for AArch32 EL3" which is also cc:stable
will implicitly use the new EXCP_MON_TRAP code path.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |  1 +
 target/arm/helper.c        | 11 +++++++++++
 target/arm/tcg/op_helper.c | 13 ++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2213c277348..4cb672c120b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -62,6 +62,7 @@
 #define EXCP_NMI            26
 #define EXCP_VINMI          27
 #define EXCP_VFNMI          28
+#define EXCP_MON_TRAP       29   /* AArch32 trap to Monitor mode */
 /* NB: add new EXCP_ defines to the array in arm_log_exception() too */
 
 #define ARMV7M_EXCP_RESET   1
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5d9eca35c04..c5cd27b249f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9684,6 +9684,7 @@ void arm_log_exception(CPUState *cs)
             [EXCP_NMI] = "NMI",
             [EXCP_VINMI] = "Virtual IRQ NMI",
             [EXCP_VFNMI] = "Virtual FIQ NMI",
+            [EXCP_MON_TRAP] = "Monitor Trap",
         };
 
         if (idx >= 0 && idx < ARRAY_SIZE(excnames)) {
@@ -10250,6 +10251,16 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
         mask = CPSR_A | CPSR_I | CPSR_F;
         offset = 0;
         break;
+    case EXCP_MON_TRAP:
+        new_mode = ARM_CPU_MODE_MON;
+        addr = 0x04;
+        mask = CPSR_A | CPSR_I | CPSR_F;
+        if (env->thumb) {
+            offset = 2;
+        } else {
+            offset = 4;
+        }
+        break;
     default:
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
         return; /* Never happens.  Keep compiler happy.  */
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 1161d301b71..1ba727e8e9f 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -758,6 +758,7 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
     const ARMCPRegInfo *ri = get_arm_cp_reginfo(cpu->cp_regs, key);
     CPAccessResult res = CP_ACCESS_OK;
     int target_el;
+    uint32_t excp;
 
     assert(ri != NULL);
 
@@ -851,8 +852,18 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
     }
 
  fail:
+    excp = EXCP_UDEF;
     switch (res & ~CP_ACCESS_EL_MASK) {
     case CP_ACCESS_TRAP:
+        /*
+         * If EL3 is AArch32 then there's no syndrome register; the cases
+         * where we would raise a SystemAccessTrap to AArch64 EL3 all become
+         * raising a Monitor trap exception. (Because there's no visible
+         * syndrome it doesn't matter what we pass to raise_exception().)
+         */
+        if ((res & CP_ACCESS_EL_MASK) == 3 && !arm_el_is_aa64(env, 3)) {
+            excp = EXCP_MON_TRAP;
+        }
         break;
     case CP_ACCESS_TRAP_UNCATEGORIZED:
         /* Only CP_ACCESS_TRAP traps are direct to a specified EL */
@@ -888,7 +899,7 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
         g_assert_not_reached();
     }
 
-    raise_exception(env, EXCP_UDEF, syndrome, target_el);
+    raise_exception(env, excp, syndrome, target_el);
 }
 
 const void *HELPER(lookup_cp_reg)(CPUARMState *env, uint32_t key)
-- 
2.34.1


