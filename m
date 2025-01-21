Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2B0C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFCZ-0002lx-Dr; Tue, 21 Jan 2025 09:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFBi-0001rD-0E
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:25:15 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFBe-0003He-8s
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:25:04 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso20288235e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469500; x=1738074300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJiPCCG+WztNHXWvHaN+Ou3cngv4lAHFeGfB5H1KSFc=;
 b=Joru2x0UA3WreeWp+RBvbTrkrChHpMH82jQbL3XY+oz0Rs/Nc9fFt20Uev6Pw1pA7K
 v8VOpg9yhviE2BlGj7d9i1BaKh7H90FQ/2YorG0Qyx7J2jn5i0kjWm2axRi7GxnreN0T
 OMhoYGayn4xSAU8DViiSPmGlcOy8v4SMRz0Zv5kOG9cEL+IcDKPbTM67B81xyE9fH40s
 MsUX4gVtuRWcygi8L8oByP6N/HIDt24aV9URp/oWHLRhcEyCIpYMzYNcLY23WddWUP2V
 kp5WbcdqpzPUaEQbzDjs3elOBTyYPvWkEjDYhGBWT0T/dESbTV7LrwWEsKABFewO9/LJ
 f4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469500; x=1738074300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJiPCCG+WztNHXWvHaN+Ou3cngv4lAHFeGfB5H1KSFc=;
 b=XPHK877mblUdyjPiA3YhrGoLveETD7XxS8XdLORHdUjEQ1Yqfpb2KbFqDmdVLzeFxV
 9nYCbKmRpx9H7dHVetL7mvzp+s4l+oFicPBmzeFF8R7oPzNcRFZtIw89Om5CKn7A+OHG
 ADzet72J+DcYqp24NSDIF2ryuFteFp4dWOYU2v0q4Vk/bleTfjEm3bxEy8cDSKcxtToS
 23Bhbh9ZSVK/3wzYUItooJvuWmU0ec5s7zkXIz+OLB36RAU00Zx+ki2KzHKsm2/BWzAi
 Q4Q3+EuVbF2EFiQmtgi+WS9gexiwGn0neveH/3f5QtzgxIFftuMH6T8I+Zrx+1JwOndF
 /pjA==
X-Gm-Message-State: AOJu0Yy/NdwYvX39Zdf8G3uBMMn+FGiF9C0JGqYFpL9DhlUgbsQrZo1E
 QtTZJ+LJ0KRn1r2IXd6MhbNXswpz2OsKmyBTa19Or/LnbGDnZ/n54Vy8Sf4uQwG+8eK2nkLCy/L
 upkk=
X-Gm-Gg: ASbGncsVffy+DuRFSd4xztDjHtz1yDPQcwMZChQJ/rza0ON5GOvu74AdnxRywZqoCnd
 U7YaxsnTdfeQZC0wNuFy5jQ/Od+bgNwGXzgq+MBR/Qwy8ZydZW8PehwBdesfO+bHkTfTeo5gPIt
 x9x82Bd+DW77LLvkP4+EbtcY3om6McUHki0FVOkFTQBsGYeAihIoxZQtWnByyUVhOXbAWxmHapO
 V4R/tw1LUy+CZH6T1OP2JzKMQqyWqC0+gqPB5xj3O03wIZQTBLMiAQWtRKECG/O66KfpL19s44a
 ywgp/xua2YkqDbl5r49RjHj8vleNs1dFFNrUVL0vVWxQ
X-Google-Smtp-Source: AGHT+IF9O8HqJLypCEu6Q5T6Q50TpWY2gzJiCNKDgpkayKJ82GUvzgYNUcjhETHkI8YWNvGx5Fw/ew==
X-Received: by 2002:a05:600c:1987:b0:434:a7b6:10e9 with SMTP id
 5b1f17b1804b1-438913e2fa9mr173391555e9.17.1737469500271; 
 Tue, 21 Jan 2025 06:25:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389041f7e9sm184241255e9.23.2025.01.21.06.24.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:24:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 16/28] target/microblaze: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Tue, 21 Jan 2025 15:23:29 +0100
Message-ID: <20250121142341.17001-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121142341.17001-1-philmd@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index f114789abd8..7a90cb3016b 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -115,10 +115,12 @@ static void mb_restore_state_to_opc(CPUState *cs,
     cpu->env.iflags = data[1];
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool mb_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int mb_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -415,6 +417,7 @@ static ObjectClass *mb_cpu_class_by_name(const char *cpu_model)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps mb_sysemu_ops = {
+    .has_work = mb_cpu_has_work,
     .get_phys_page_attrs_debug = mb_cpu_get_phys_page_attrs_debug,
 };
 #endif
@@ -450,7 +453,6 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mb_cpu_class_by_name;
-    cc->has_work = mb_cpu_has_work;
     cc->mmu_index = mb_cpu_mmu_index;
     cc->dump_state = mb_cpu_dump_state;
     cc->set_pc = mb_cpu_set_pc;
-- 
2.47.1


