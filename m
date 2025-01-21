Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE26C0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFBQ-00019g-GL; Tue, 21 Jan 2025 09:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFBN-000137-JG
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:24:45 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFBK-0003Cg-Ue
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:24:45 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso4321310f8f.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469481; x=1738074281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i0IEgUTUoJtMoDUBjCVWUA9LQ/fRvYT8kph+CQLQqnc=;
 b=OLHDIXs4a/Pf3z8kFmoMXIh1gin6KSzrNPk3FvTLFnWbTG5v9MQcBAL5NcGntDBxLR
 ++EKQafU6UBlmEIN9ESTi/ac2sbLcMiCHoXHfWpnDsWSncxlFX3WnjgJf8Z201PjEng/
 bJAc8Z37BhWLlJ7/yTbLHu7R7tepSVbhc2gxPe8iTUAc0Xh+8y0bWVplEJyIRmdhbou4
 0bxSmz0LotzfbeB/skshRiTUNZmN+Sdggg9kzCgwFEEbYmMECwK0WKaqhKMBFUh69LBC
 NNAkrQ7rPIUkKFuhy8ZMjqmrn3LKZUBvmQFwuzWuFcEhw/e3fcvNrr97H0a2HofjwrQ7
 PP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469481; x=1738074281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i0IEgUTUoJtMoDUBjCVWUA9LQ/fRvYT8kph+CQLQqnc=;
 b=TLEbxMucjyri2po/vsUPBXsdw9NlVKxet2nDRZsq33Qw72Vog8ke0nQ2l7iTXm78Z8
 K4xKEvCfq6N146OiKCv7jRlMRcBp5INpeq9Vli06xp9R44YYjbLOvvdwCEGQ0dYe93iI
 F7Z8CZUBvNS66SZm8gU6duXavcD+K0gSJ//UkD/DL+TxY8V9NoqKOERMZgbE0FjjJC/i
 T5fBsQxvs3e4vyYhIu2I2tadT2i27mvjybH/z6Hm2zNTHOMwPtl+T3rUFv7KvKqW0qH+
 yzpvixEl6LoJzfx6n5GsuLNuKU0qce0LHg8TZRTrGXqXAewKMjLyBHTjjniwbjuIdZoR
 QKZg==
X-Gm-Message-State: AOJu0Yz7Tghnyr0ftXGDyXK+nSr6UMNs1+DbnzukvYPS5i3FMN8wIJSq
 XT+toBYoqDVwpGmUDiIVZTvj6P9wnOViZMyycyAXTRUdUQtbi9+2n7uHNXNLVDj94wPRplABncY
 MrdU=
X-Gm-Gg: ASbGnctRyfZcFiyzRHuyF/cXh3wjcJo03FGeWcFDtLeRk26qqLlLi9coHO31Frd+5jE
 TmdnoqyV+xoA880/Tew+mz7yVEICHeeonD4cM7gjogQoPzXvDVsgPgvXUxJ1UkgZRc1BEQYorjt
 GsYjY/k6cobLoxsY33yDa0ycFfsSvkM63+9d5dbYLpczpEyD91VeMuYV38dn7Xykyq/ikJJsxnw
 f31rzTf8OrOespcB3ws8AOdENDvZxEFE0+q6XF2GxeM9n8A4n10S8uRyZTvoWPgOemw9g0pTVdq
 3mQA+r57wX/TUOat5mpi7J4EE+9P7BmZG6IsP6+T47o0
X-Google-Smtp-Source: AGHT+IGmK+04j7KIt7xGWt/FgU5zgcafQ9vituDDOPLVNSUOhJzowwtpVRwn76WAIAbcLcmUtYLWyw==
X-Received: by 2002:a05:6000:86:b0:385:ef39:6cf7 with SMTP id
 ffacd0b85a97d-38bf5673ea3mr11098765f8f.32.1737469481194; 
 Tue, 21 Jan 2025 06:24:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3215099sm13303268f8f.3.2025.01.21.06.24.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:24:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/28] target/hppa: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Tue, 21 Jan 2025 15:23:25 +0100
Message-ID: <20250121142341.17001-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121142341.17001-1-philmd@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
 target/hppa/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index b0bc9d35e4c..d5a58a03cbb 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -125,10 +125,12 @@ static void hppa_restore_state_to_opc(CPUState *cs,
     env->psw_n = 0;
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool hppa_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int hppa_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -231,6 +233,7 @@ static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps hppa_sysemu_ops = {
+    .has_work = hppa_cpu_has_work,
     .get_phys_page_debug = hppa_cpu_get_phys_page_debug,
 };
 #endif
@@ -267,7 +270,6 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = hppa_cpu_class_by_name;
-    cc->has_work = hppa_cpu_has_work;
     cc->mmu_index = hppa_cpu_mmu_index;
     cc->dump_state = hppa_cpu_dump_state;
     cc->set_pc = hppa_cpu_set_pc;
-- 
2.47.1


