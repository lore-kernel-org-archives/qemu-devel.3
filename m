Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFE6C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByJA-0000dK-Pv; Tue, 28 May 2024 11:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sByJ8-0000bB-C2
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:00:10 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sByJ6-00074i-IZ
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:00:10 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f45cso1129090a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716908407; x=1717513207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXSsU3bC3/S4MPVHakO32DgE7Q0Emp+SarB3ZR8O4Ck=;
 b=W7XO3NKOwshww8oCZVx82B5CBgBryccqf9NKChMeaVwX+pwrhbRBIKRoVOy1Foettt
 rIN8KSU22lzCaOLkCV2dBvvJp6M61eZWVYoGnBWfmONWR0d6Ghui2VoldyrJddKxm+K+
 vGmfImPjdika6a+Ml8EwotWm32t/UKiMo9qstbSevtpdlCu3cMCsLUfAQyNy1VQHLJGE
 bhH5j2zwpifUQ3cg7UhKKb3vcIEe+kl/sv0vFBT9WLBgCxZXWwsCFzPuw9QPyvrjuPcs
 hgCXL13Y9wt9P1KxtdFfkzabGhPK/NaQ98PGpqdJLQaU0xx20pJhUJfmECAIdRpXjlbx
 AMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716908407; x=1717513207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MXSsU3bC3/S4MPVHakO32DgE7Q0Emp+SarB3ZR8O4Ck=;
 b=YFdnQH1WqLqZxX9mmeENGNmkucjIl/dIOHs3SbU572wDmjbq5i17o0RR7ezbRY3JMR
 xo+9ngcgrm/o14b1WiNF0LtEo+7gKa7CM3bMupUj23T8FaaRrZomxIpwiF28CJiOqVMI
 ExPx0+mpZk99iNwiABZ5B/9wk7jdOOoWiK5//o17hdltRP0mMISFBdSgcDFIAALKpORK
 HlyBuOno+p/iQGKtbNoGN2JqxjtYvCGE8LpNcsCyWYHnbYNQ65GYofico2YXZId1/DOE
 spUO6XHgRx3JeQTEcd8/B+Rv08oyqPx84JE5zSR/IfRTvSlhaNu3qHoApg40CKQfe6wz
 nouw==
X-Gm-Message-State: AOJu0YwqOhfkv2h8tHjR5vdRClSuFCR6AxL/JQYJabbMt3EZ4709X0ka
 PtmWZEK6afkmb1hrLdqvGM6oChmuQdKgKw86SfJHthhKENsNZW5Z2so6/Snja7VpHAL6hu/eXYU
 X
X-Google-Smtp-Source: AGHT+IH20g+nR0V3xBOKczGAmmt451eBuXIlzPVINdDInP0pzqV2o2taOh3ZtgQDnsp6+iBpPcsyqw==
X-Received: by 2002:a50:c04d:0:b0:578:572d:8d1e with SMTP id
 4fb4d7f45d1cf-578572d8e3amr7798101a12.6.1716908406774; 
 Tue, 28 May 2024 08:00:06 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.214.26])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-579db5406a7sm2242454a12.63.2024.05.28.08.00.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 08:00:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/6] accel/tcg: Move common declarations to 'internal-common.h'
Date: Tue, 28 May 2024 16:59:48 +0200
Message-ID: <20240528145953.65398-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240528145953.65398-1-philmd@linaro.org>
References: <20240528145953.65398-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

'internal-target.h' is meant for target-specific declarations,
while 'internal-common.h' for common ones. Move common declarations
to it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-common.h | 15 +++++++++++++++
 accel/tcg/internal-target.h | 14 --------------
 accel/tcg/tcg-all.c         |  2 +-
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index cff43d221b..a8fc3db774 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -15,6 +15,8 @@
 extern int64_t max_delay;
 extern int64_t max_advance;
 
+extern bool one_insn_per_tb;
+
 /*
  * Return true if CS is not running in parallel with other cpus, either
  * because there are no other cpus or we are within an exclusive context.
@@ -41,4 +43,17 @@ static inline bool cpu_plugin_mem_cbs_enabled(const CPUState *cpu)
 #endif
 }
 
+TranslationBlock *tb_gen_code(CPUState *cpu, vaddr pc,
+                              uint64_t cs_base, uint32_t flags,
+                              int cflags);
+void page_init(void);
+void tb_htable_init(void);
+void tb_reset_jump(TranslationBlock *tb, int n);
+TranslationBlock *tb_link_page(TranslationBlock *tb);
+void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
+                               uintptr_t host_pc);
+
+bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
+void tcg_exec_unrealizefn(CPUState *cpu);
+
 #endif
diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 4e36cf858e..fe109724c6 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -69,19 +69,7 @@ void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
 G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 #endif /* CONFIG_SOFTMMU */
 
-TranslationBlock *tb_gen_code(CPUState *cpu, vaddr pc,
-                              uint64_t cs_base, uint32_t flags,
-                              int cflags);
-void page_init(void);
-void tb_htable_init(void);
-void tb_reset_jump(TranslationBlock *tb, int n);
-TranslationBlock *tb_link_page(TranslationBlock *tb);
 bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc);
-void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
-                               uintptr_t host_pc);
-
-bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
-void tcg_exec_unrealizefn(CPUState *cpu);
 
 /* Return the current PC from CPU, which may be cached in TB. */
 static inline vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
@@ -93,8 +81,6 @@ static inline vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
     }
 }
 
-extern bool one_insn_per_tb;
-
 /**
  * tcg_req_mo:
  * @type: TCGBar
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c6619f5b98..2090907dba 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -38,7 +38,7 @@
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/boards.h"
 #endif
-#include "internal-target.h"
+#include "internal-common.h"
 
 struct TCGState {
     AccelState parent_obj;
-- 
2.41.0


