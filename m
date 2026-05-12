Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D795CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuRF-0005Kt-LK; Tue, 12 May 2026 17:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuR3-0005BS-Sk; Tue, 12 May 2026 17:14:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuR2-0005iT-30; Tue, 12 May 2026 17:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619305; bh=Re9h9iKEengeEyzIXX22uCpUR2K67K75BdjmELrCjnA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=W852sIafW1Kze/bixXe71YQQ3gL19XGF5AcdV+6c/G7nd7O2C6+OVkx1Q8tsum2dW
 ENz57ig6jUqfuSPFftfyDmkKln2J6nl1qTbzZy27YItDOH+h+oLpXRHzYcGm2N2Zkp
 2xH8Tng2FfxNFo09HvpxnVUMxJQZ4QMpbkYVoA4SnSAVfj935hNPWDgrKKf63+gWcN
 Hcxn6M7Q/nanS5AXdNkGFp0RNGmdnfbuNBfaSUuywIJrI5gUMFeX+NN/Xlr9MG0NrO
 ppjSeghAVL8MaOzrWnLKWUR8iIphzErXvkqN9fLybT/oDmpL9DvEeUF6y/Ry/KH9Wn
 A3UnQP0zoIXtA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7E98D1AA393;
 Tue, 12 May 2026 23:55:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 89CF73ABD02;
 Tue, 12 May 2026 23:55:09 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 085/117] linux-user/mips: sync k0 TLS for
 EF_MIPS_MACH_OCTEON userlands
Date: Tue, 12 May 2026 23:54:27 +0300
Message-ID: <20260512205503.361097-85-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: James Hilliard <james.hilliard1@gmail.com>

Cavium Octeon userspace is not following a generic MIPS Linux TLS
ABI rule here. Older Octeon glibc uses the k0 register as the fast
thread pointer, while newer Octeon2 and Octeon3 glibc variants use
the normal rdhwr $29 path.

linux-user already updates CP0_UserLocal for cpu_set_tls() and
TARGET_NR_set_thread_area, but it does not keep gpr[26]
synchronized. That leaves EF_MIPS_MACH_OCTEON userlands able to
complete set_thread_area() and still reach pthread startup or
pthread_self() with a stale k0 value.

Use the existing MIPS ELF machine flags from linux-user/elfload.c and
mirror CP0_UserLocal into gpr[26] only for EF_MIPS_MACH_OCTEON.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 4c681ba3b82d9a9f00a3f361399a1bb7612f3535)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 59b543f740..0e757787d2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1476,6 +1476,9 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
     /* Usual start for brk is after all sections of the main executable. */
     info->brk = TARGET_PAGE_ALIGN(hiaddr + load_bias);
     info->elf_flags = ehdr->e_flags;
+#ifdef TARGET_MIPS
+    info->use_k0_tls = (ehdr->e_flags & EF_MIPS_MACH) == EF_MIPS_MACH_OCTEON;
+#endif
 
     prot_exec = PROT_EXEC;
 #ifdef TARGET_AARCH64
diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
index c375616c55..2bbd0a81c5 100644
--- a/linux-user/mips/target_cpu.h
+++ b/linux-user/mips/target_cpu.h
@@ -35,7 +35,12 @@ static inline void cpu_clone_regs_parent(CPUMIPSState *env, unsigned flags)
 
 static inline void cpu_set_tls(CPUMIPSState *env, target_ulong newtls)
 {
+    TaskState *ts = get_task_state(env_cpu(env));
+
     env->active_tc.CP0_UserLocal = newtls;
+    if (ts->info->use_k0_tls) {
+        env->active_tc.gpr[26] = newtls;
+    }
 }
 
 static inline abi_ulong get_sp_from_cpustate(CPUMIPSState *state)
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index cfe5f45fc4..7f98fb2607 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -65,6 +65,7 @@ struct image_info {
         uint32_t        note_flags;
 
 #ifdef TARGET_MIPS
+        bool            use_k0_tls;
         int             fp_abi;
         int             interp_fp_abi;
 #endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0261f2fc5c..7b6343deba 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -13205,7 +13205,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_set_thread_area
     case TARGET_NR_set_thread_area:
 #if defined(TARGET_MIPS)
-      cpu_env->active_tc.CP0_UserLocal = arg1;
+      cpu_set_tls(cpu_env, arg1);
       return 0;
 #elif defined(TARGET_I386) && defined(TARGET_ABI32)
       return do_set_thread_area(cpu_env, arg1);
-- 
2.47.3


