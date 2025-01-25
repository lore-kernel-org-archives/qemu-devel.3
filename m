Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBF2C0218E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjY0-0007IZ-NK; Sat, 25 Jan 2025 12:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXe-0006d8-0K
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:01:55 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXc-0000Pu-HO
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:01:53 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43618283d48so21877245e9.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824511; x=1738429311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlhipGgHKI5N0qn8K1o15KvLAOg1D9rjFfwCNaRH9Tg=;
 b=hr6Rz8tuLVfDG6ZpyODy2j9ESmVfLqT0yKiFjTLLPgFXC9rTnH5x/GRmOkIVhKfQuB
 fK0e1TiskP+AofQbitYIp8m5wti7ouMpzVup+fGs4RDsOMayB0nuPWMSuccgBZAAmlbM
 Ln4QnHIF1nlzU8VHETvGERLOwxzDobK4ixgGJS3g6k1iqocOOheGy7IUvK5cutsEnU7p
 Zv1J/bld+dwV28tY3sYj8pxgWtklGkD5XbBoNDmXp4jmRyYOfj9qSJzXXq1592I/Acsh
 rgYM3NqhDVMmkByt9JoPGqj5KQuWzF7P7rXLX951fGByperJ+OA49iW6Lne4eK9M1EGY
 Bq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824511; x=1738429311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hlhipGgHKI5N0qn8K1o15KvLAOg1D9rjFfwCNaRH9Tg=;
 b=eILC25rWmviawmfmMQvQ0bnPS2XfoqOcKPjDnFmo0jZODrcM1j5v80dwohg2Oiv0+J
 kei+LXWNyzM2/3GFSYpZauW381q35uQaVLCaxEhJ0CoduPUpNa8FQ3PdwTRzw0J+f+if
 52W3dnilbbC6KuPLp18uDB8wVFmzRNXQdn+PRvi4FHLp17nQXcD5z+PBi7AqmdU7/izu
 Z9sN69vEdRt9peFRK5P0ERHh9NVxIWsd2obM1madLRLRTe76XjOg2UyIYiLYO1F3Wv2U
 WqHdLDy6uHnW0WfZXJQUvPM3KC3HKaruJiEVvg4A2UuIDGwSbw2LSYmSjNrS9ynG6dq9
 vE4g==
X-Gm-Message-State: AOJu0YwzXkVOQkF48RvF15EyQ5SoYKvLM1hDGVg/0KdbdNBci0gxg/iy
 VjYG1YkVYsOQTSnCNXXE1lZHqjV3qz5vkY2vjyVj94rCcBDIft53bnmMph8d1yqtYtvuFurYTSL
 dFBw=
X-Gm-Gg: ASbGncuugKBwugZdezrxwR5o739R1Auk3wfptA9P4CnpQvU+EdDnyXLzLkDbEzCWcBD
 wcLvuzMucLA4ZU4tVgyfLd0zI3o/INXPINho61lTMIbFC2EeuPkG1nToiLqiKlQzP3y5Nz78D4/
 CDKjmG4WwuaSJTANdvH+Mo20+XXS03Ugirv6AQgOc41r7PJTp3VTLoFtHTLigXvUIlfBr795AP3
 r7DDR0fHKxr+XhE5Vx4KFaX5+5Ny9h0/DLHXKel5bKQ6ixbUMEbO6yhEnbRfDkCeEAcJSxCHrtD
 4B1nt4xArgyiVrEWIk+Y+deSOuOjBvnzXF3lC9sM/4gp9DxnwIGEj7Mu5g5FBnrf0w==
X-Google-Smtp-Source: AGHT+IEf2NKsj8zOnsCZFWI37fq2kOCafRzQbgx+Nuf5k0Cmo2DUwWLvcs8jsT47wYuAkXvvmwDlmQ==
X-Received: by 2002:a05:600c:384a:b0:431:6153:a258 with SMTP id
 5b1f17b1804b1-438913db2c3mr342701525e9.13.1737824510730; 
 Sat, 25 Jan 2025 09:01:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd502007sm66229665e9.14.2025.01.25.09.01.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:01:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 05/24] target/arm: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 18:01:06 +0100
Message-ID: <20250125170125.32855-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 048b825a006..322c95038d5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -123,6 +123,7 @@ void arm_restore_state_to_opc(CPUState *cs,
 }
 #endif /* CONFIG_TCG */
 
+#ifndef CONFIG_USER_ONLY
 /*
  * With SCTLR_ELx.NMI == 0, IRQ with Superpriority is masked identically with
  * IRQ without Superpriority. Moreover, if the GIC is configured so that
@@ -141,6 +142,7 @@ static bool arm_cpu_has_work(CPUState *cs)
          | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
          | CPU_INTERRUPT_EXITTB);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int arm_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -2671,6 +2673,7 @@ static const gchar *arm_gdb_arch_name(CPUState *cs)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps arm_sysemu_ops = {
+    .has_work = arm_cpu_has_work,
     .get_phys_page_attrs_debug = arm_cpu_get_phys_page_attrs_debug,
     .asidx_from_attrs = arm_asidx_from_attrs,
     .write_elf32_note = arm_cpu_write_elf32_note,
@@ -2721,7 +2724,6 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = arm_cpu_class_by_name;
-    cc->has_work = arm_cpu_has_work;
     cc->mmu_index = arm_cpu_mmu_index;
     cc->dump_state = arm_cpu_dump_state;
     cc->set_pc = arm_cpu_set_pc;
-- 
2.47.1


