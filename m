Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACA2CFD62A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTIG-0003fL-V4; Wed, 07 Jan 2026 08:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTIB-0003ML-0h
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:09:40 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTI8-0008VZ-3y
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:09:38 -0500
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-42fbad1fa90so1661981f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767791373; x=1768396173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iTd24fuLkUcPdtjlQ0PktHxm0veo9AVLLnZX4UIhnN8=;
 b=Wrq+YNp5LKubCBonlG1lUMYzG5QgkxRrPScAhptwQCFlnb7r7hzB8E2CLR58KEqa8S
 PP0B+3DiylUw8Nq+eclOE6AU0jCtkPBaP8wrvkF00V/ig5J+r77wgHeSzJ9U7HtEd4aj
 iLO8QAdDwSa+XYG1MySEQihWMAQJmxbiGYEc72Hv9fIAQNPdV/4DrzNCfNFGpDn7RGEp
 /FQcLJqd7CNfdxDCtA+qkZ6Mb4RVgELUhEPh7iP+2r1y26t5oT0P3vgz5ZFaWAbIyJ2R
 PWseihTUHF4zOp1xvKgMPj6q5VoxL8Ky1X7i/kEy/b91KFNmBo7ny5By/rN6Xk26Tb/Y
 QDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767791373; x=1768396173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iTd24fuLkUcPdtjlQ0PktHxm0veo9AVLLnZX4UIhnN8=;
 b=O0Yss/1TDmg2cqYW+iqYu7zu5VoYCruLQ3r51M+VHo73p5R3Aw2UUX1vwa+Cud4g99
 3wCN+UnxDgM8nMTmtyseG/SoVZsE9ZIJNfsdw5B8rsjPR2E2SN/qDcMf5AEA7ENcKQh9
 sQnMS/WAvOSoySdvGbwPTI0KkyCTfr5T+QRIKnZyhtmV9nDaq1PVyAQRezPdiSA/zdO8
 YIMzxJYd4PEVXwAZt+jxUP761IsCizPdwATpPKgbCpQcwUcXAi7Q44iZKM4UarpAWnmz
 tX8mt/GGhDLe2A3+ufgVxPP/dqUnC+XK1P09ymagoxuRZWXvGliAua+YsXowV1PS9sDL
 DhWA==
X-Gm-Message-State: AOJu0YwRYXaTOc1qXENxX4+ZFF+QbUY/wSqxGMfdIKi9EQjLQGwxKV4j
 56mU1Z+AV+jabERhkrQ/qcwqjRfcVJL7fsJECQBo6QzVuM2dow9YZTxN505J6+D4rvdpsi9h/B6
 5rmH9FX5XIA==
X-Gm-Gg: AY/fxX6vbbTFb4xszI0LkpeGO5H4cUiWePDwvsV5NY/U0jIws+xo0bkNpjeXNMsRu7Q
 l3YiB5XaszGBUtisPGxIoctC77HYF1nx7FpuZlOacEhH8sIijzDCwVWmGCTB4bx7an2jYJ0ctO1
 6cLuDGWvLX7HSBmLjEJJNoJUK1Mcwyhlh4YTnCsfI3nMSblsUDUahSM3t5hIYpjyB0+oDxJXuGP
 t65Y8rZSDAwcUprHeMz3ayLd789kvShPM96tVWwkt35QcV1XH2chj2IOlF/AuGDq7NSEdiIc42J
 2/W1oJwCTdoJPqwkv1D5fFgEATaduUnOO4gS52WMSP/DCq8t6BMTIPNuGL6ym8FE0/QBXcrBAcd
 VH4iSxfwX/d78LtUllidWBtmoO47IV9a65rgcxx1uPMVNebJRcdR5fAje+J5kCCVR7BPKcOCBtr
 cf06rJV4gIzv/C0QRyKWrJlYUyblEKthRBQvv0YzyMGMWZjvhTl1AFTsI62NSo
X-Google-Smtp-Source: AGHT+IGadna+9SAN7jsZbhy6tNNiM2SRz2B81Q7enodwT/gTLfrAxYwgMHsmoQ9iwXym0C6/XQcKFA==
X-Received: by 2002:a05:6000:1a8e:b0:432:5d73:79a1 with SMTP id
 ffacd0b85a97d-432c38d0f49mr2711098f8f.55.1767791373285; 
 Wed, 07 Jan 2026 05:09:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0860f5sm10069642f8f.0.2026.01.07.05.09.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 05:09:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH 12/18] target/s390x: Pass vaddr/hwaddr types to
 mmu_translate*()
Date: Wed,  7 Jan 2026 14:08:00 +0100
Message-ID: <20260107130807.69870-13-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107130807.69870-1-philmd@linaro.org>
References: <20260107130807.69870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

mmu_translate() and mmu_translate_real() translate virtual
addresses to physical ones.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/s390x-internal.h  | 9 +++++----
 target/s390x/mmu_helper.c      | 8 ++++----
 target/s390x/tcg/excp_helper.c | 3 ++-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index dfc95702c51..790cd688762 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -11,6 +11,7 @@
 #define S390X_INTERNAL_H
 
 #include "exec/hwaddr.h"
+#include "exec/vaddr.h"
 #include "cpu.h"
 #include "fpu/softfloat.h"
 
@@ -377,10 +378,10 @@ hwaddr mmu_real2abs(CPUS390XState *env, hwaddr raddr);
 bool mmu_absolute_addr_valid(hwaddr addr, bool is_write);
 /* Special access mode only valid for mmu_translate() */
 #define MMU_S390_LRA        -1
-int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
-                  target_ulong *raddr, int *flags, uint64_t *tec);
-int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
-                       target_ulong *addr, int *flags, uint64_t *tec);
+int mmu_translate(CPUS390XState *env, vaddr vaddr, int rw, uint64_t asc,
+                  hwaddr *raddr, int *flags, uint64_t *tec);
+int mmu_translate_real(CPUS390XState *env, vaddr raddr, int rw,
+                       hwaddr *addr, int *flags, uint64_t *tec);
 
 
 /* misc_helper.c */
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index abf8da28ea5..9295a9d8dae 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -381,8 +381,8 @@ static void mmu_handle_skey(hwaddr addr, int rw, int *flags)
  *               there is an exception to raise
  * @return       0 = success, != 0, the exception to raise
  */
-int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
-                  target_ulong *raddr, int *flags, uint64_t *tec)
+int mmu_translate(CPUS390XState *env, vaddr vaddr, int rw, uint64_t asc,
+                  hwaddr *raddr, int *flags, uint64_t *tec)
 {
     uint64_t asce;
     int r;
@@ -584,8 +584,8 @@ void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra)
  * @param flags  the PAGE_READ/WRITE/EXEC flags are stored to this pointer
  * @return       0 = success, != 0, the exception to raise
  */
-int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
-                       target_ulong *addr, int *flags, uint64_t *tec)
+int mmu_translate_real(CPUS390XState *env, vaddr raddr, int rw,
+                       hwaddr *addr, int *flags, uint64_t *tec)
 {
     const bool lowprot_enabled = env->cregs[0] & CR0_LOWPROT;
 
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 019eb4fba1f..41b0017d767 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -147,7 +147,8 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        bool probe, uintptr_t retaddr)
 {
     CPUS390XState *env = cpu_env(cs);
-    target_ulong vaddr, raddr;
+    vaddr vaddr;
+    hwaddr raddr;
     uint64_t asc, tec;
     int prot, excp;
 
-- 
2.52.0


