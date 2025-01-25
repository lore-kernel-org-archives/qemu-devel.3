Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C50CC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjYF-0007jJ-BD; Sat, 25 Jan 2025 12:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjY3-0007Ns-0a
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:22 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjY1-0000Ub-2D
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:18 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso3546573f8f.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824535; x=1738429335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srYqpBi+i1JHdcQoMXjqQayhwRKKfnrZUrD1yEs/h/w=;
 b=H4P+IGCYykG0iClof5eIR9TPZIMz5MZD5+P6gdixBeKm0FeMrlg1lQCR2rl2yuHzQv
 LbiphyFBGK3xV/A35+QJuUCg9kB9P88HPE1QuKNpGBDbTCKZgy/mhBRvW1UUUMIkELLO
 SR3/+88PrjtJ2jhKGcMVPaYwnio4ABesdr83I1h79oB/BBWgXBSPafwX+he4Q4ENtWJq
 chN9nAjOGekZZV9F5daV04fGG9SajCn/DrcmwRfSDcMzdmYyxhJIbLQzKzRnYEXzgXtL
 Y5iwFWbr1AIOzUylrgC/axzbfx90voaTiWXYgRF6fXTzs1/GcQ9GkdLYxZ0MFvKCVJAn
 F1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824535; x=1738429335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=srYqpBi+i1JHdcQoMXjqQayhwRKKfnrZUrD1yEs/h/w=;
 b=hLDZm6LWfWKa8p5N1Z+8paUCP9AgGkbVyXUp2pyYdJ6a7YawCJ/uv/fb6mA8z9Z9su
 KqCTTQBWtCR3FidXb1TtOUGdwfN6PT5/7ZV4ln6U5vCFgznRPf0AVB5JR+93yTDphjTh
 YpJEzmd0726ZSL4drXigsf3J+LRrLOeuQE4cK5lrk1BOCQ/QPfhAftvunUr6LaNuYshp
 zGswmQ9HD28m4JVmDecYMRoHHWHGFsqg42M1WD8WeZb+2nKdZ89eFaCAfzYyx0zXd07G
 an97CHe3j3YfjnC4MjOzj0LqzKLYJv4WdY4hcJS5bBXNGx1X1Xa9tzqY2rBMRGBk/eT+
 61+A==
X-Gm-Message-State: AOJu0YzXPMajjiL+EtQd/nz1LYvqgRitepnNqfWUMbBLfNQyQz7SDNtp
 dZKg/VwBHtVHAdbSqosTllSh3Hudkar1K3shNaOsZnDhhuftEsxk4pP2w1AnS0SAzqDq8Xv/h9F
 vsTY=
X-Gm-Gg: ASbGncvlvEBa87H01iRFSScN4FbP/mIphbyS0CNh/4CNPmOiabS3ju7xXhKWk4W2/wS
 4lXzY2e1XMyPmwisqoeE8n9F5awD1X3G8kpcxge41IUa+heMdluRyGT17dKkbp2wlDrqxuSeyLs
 K+hRw2f71Vz1cg2VrRXlwreZENcRJGphv1NYis17sw08zIiJ7862NK9hEZQW8J+rlwSof291N+j
 lQTn8kTp1Uaimcc17EV24cyZ3a5Zmzb7GncAzC9FkTxmsHRRiaq9ngH7N4fBQsG1nPr+UUag7Sc
 JpHTNi0wfsrGWuQGSfKCYF+8kqR5R8/Q7w0kgiNT01T+2d1wSrjixz4=
X-Google-Smtp-Source: AGHT+IFwA5bZR17+i0WU35oIAB1ENpa8jYp88hCa1KAuZoPxhtuXvqPZ2pWw0r1ukuIgzQsM2MUPiw==
X-Received: by 2002:a5d:648a:0:b0:385:fb8d:865b with SMTP id
 ffacd0b85a97d-38bf57be4a2mr37231545f8f.48.1737824535020; 
 Sat, 25 Jan 2025 09:02:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188689sm5983635f8f.48.2025.01.25.09.02.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:02:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/24] target/loongarch: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 18:01:11 +0100
Message-ID: <20250125170125.32855-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
 target/loongarch/cpu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index d611a604704..20aba0e1fff 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -349,11 +349,9 @@ static void loongarch_restore_state_to_opc(CPUState *cs,
 }
 #endif /* CONFIG_TCG */
 
+#ifndef CONFIG_USER_ONLY
 static bool loongarch_cpu_has_work(CPUState *cs)
 {
-#ifdef CONFIG_USER_ONLY
-    return true;
-#else
     bool has_work = false;
 
     if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
@@ -362,8 +360,8 @@ static bool loongarch_cpu_has_work(CPUState *cs)
     }
 
     return has_work;
-#endif
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -835,6 +833,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps loongarch_sysemu_ops = {
+    .has_work = loongarch_cpu_has_work,
     .write_elf64_note = loongarch_cpu_write_elf64_note,
     .get_phys_page_debug = loongarch_cpu_get_phys_page_debug,
 };
@@ -860,7 +859,6 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
                                        &lacc->parent_phases);
 
     cc->class_by_name = loongarch_cpu_class_by_name;
-    cc->has_work = loongarch_cpu_has_work;
     cc->mmu_index = loongarch_cpu_mmu_index;
     cc->dump_state = loongarch_cpu_dump_state;
     cc->set_pc = loongarch_cpu_set_pc;
-- 
2.47.1


