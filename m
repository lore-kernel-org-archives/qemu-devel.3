Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BA3C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFDu-0004Ou-Fd; Tue, 21 Jan 2025 09:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFBu-000258-Sw
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:25:22 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFBs-0003WQ-7C
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:25:18 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso39093455e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469514; x=1738074314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+p++OfByvnnjrmCWTGZNYeoc1QnZaouIzDSmAGjov8=;
 b=zLuCsclzR8QhUwrARZZrcv8kZi6+s5aP4uo2Oa02T3T79NFvKlGKsKE4QAKGE6mg14
 itB5we4Yiv1Vf9WBO+SQTWlyjHBvF5csOOkXdESHnuMiTD/9qRtsRZ7UGgZ/0eDToK/G
 /jrDQgHWUXtVFl34aKNIHAv1MT37JStfza1pRKukZusPnUa+KWTDgdpWe5IQNNkXuWrX
 rDULHF6u+aGWJ92uTyfB3Fnek8wSC8tPo1tapdgMt/KkJmhq+BFavYI+UKwFlGoRx9TD
 g26g9VAVjc7R2oknDcpYMlTH4uV/6bYQoQG1Sd1LtMll6cgrP3mdipPudi1JvHOaQuLn
 ONsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469514; x=1738074314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+p++OfByvnnjrmCWTGZNYeoc1QnZaouIzDSmAGjov8=;
 b=dIsO/d8g9VJjrpqctl+3BmdozSqOFLsIlDgeo7rfbKl6On60zmtRkGSS71/k15OfDq
 SiDORRadrCXNkAq9IX25jWSJtFPTIoe4DiBiY5rITBDc4qu9N6l9D8NpH/6wjAy8WaFO
 bfKBA/Z9shAg9oLuaTPiYTSuOORIZcuU6dULBcu3R/GtIRAlT7l36JHgYzGurvJaZgCC
 CP9R/zj2ugj0r/9L69zO/+uUECTE8gQ8V94oHB5VTbLqcJG+SXdqO+4nXdjs+CaIDuB+
 JvTAOVxWnJOvz2xiZuGOlUyRovetwzkah2K+rLeEjQ5cZFv5KKlxeB0QPbljHdsqWnhQ
 l7Zg==
X-Gm-Message-State: AOJu0Yy4Y/5/HiaimJiXPNDa9rQYSHfXN6yMc7araA7/dBRWN2ob/IB3
 Q/B94ZHuhlEZt5GKkYRfDMXgUDougY6aAKyFgTBShrBcV5JRX9StS5VnvB56y/NLhQAw88SVdh+
 +C8M=
X-Gm-Gg: ASbGncvHJaYiShSNCOTyAZFhD/rm6KUYDgEMewDageJfHwV/pygN4Hjv+djj7eSZduO
 IkbgqoZ+oub9QH/1fbmK7/mF89EFBfSg826fxJdgqDCdOpijEkEceWdAMvtn0pshaa9vm0qUfyq
 zPEK73R+xLQgvP4nYZY+q3fvMUxbY8qU3rY9ZFp8Mo5Jwi/m9nXwEKlaieiCG/EA37CqdBkQzk2
 E6pESJl5vwDOcCbg2eZl8M85Tbt6G1BBu/eEmQ90B+7gzThagd10mXuOMLIkHR6Xax2BpuZT4c+
 OUN/PBGzlhAUWRrVCXQ7fcY18LDLSEc1EclOBhzA5OqC
X-Google-Smtp-Source: AGHT+IEvOwqMxcIB4CxmsBHfttg0Kz/rGyaM5A6hndZP1gZhHsB3FmvGqmb9xhrMEyQ0ZMSypwnoTw==
X-Received: by 2002:a05:600c:3b02:b0:434:a7f1:6545 with SMTP id
 5b1f17b1804b1-43891441f27mr152566255e9.27.1737469514459; 
 Tue, 21 Jan 2025 06:25:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322a414sm13450253f8f.47.2025.01.21.06.25.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:25:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 19/28] target/ppc: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Tue, 21 Jan 2025 15:23:32 +0100
Message-ID: <20250121142341.17001-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121142341.17001-1-philmd@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
 target/ppc/cpu_init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index c05c2dc42dc..081fb5bd343 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7177,10 +7177,12 @@ static void ppc_restore_state_to_opc(CPUState *cs,
 }
 #endif /* CONFIG_TCG */
 
+#ifndef CONFIG_USER_ONLY
 static bool ppc_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -7418,6 +7420,7 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps ppc_sysemu_ops = {
+    .has_work = ppc_cpu_has_work,
     .get_phys_page_debug = ppc_cpu_get_phys_page_debug,
     .write_elf32_note = ppc32_cpu_write_elf32_note,
     .write_elf64_note = ppc64_cpu_write_elf64_note,
@@ -7469,7 +7472,6 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
                                        &pcc->parent_phases);
 
     cc->class_by_name = ppc_cpu_class_by_name;
-    cc->has_work = ppc_cpu_has_work;
     cc->mmu_index = ppc_cpu_mmu_index;
     cc->dump_state = ppc_cpu_dump_state;
     cc->set_pc = ppc_cpu_set_pc;
-- 
2.47.1


