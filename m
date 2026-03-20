Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D3F109879E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3cPn-0000Y8-Om; Fri, 20 Mar 2026 12:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cPb-0000Ve-42
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:09:24 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cPY-0000DD-NG
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:09:22 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so20855195e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774022959; x=1774627759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ls+6UcXld1NtMIbY4Nw5EuiQUjc1V4AaOnaDRbb7rxs=;
 b=RoGb6w5U3fPQyc8ia85VMhaj20uRuemdhh7riK/XGqS3I3mIVZHJUWCOp/Gcmh34uY
 ZXjwUmAzssmP11feSMxR73ezLXZv0SIkTTU+d6YyM2RR5qj9X3mOcWASSMR/EJzxOBto
 +fP/VEv+oh/nhXEKlGVzf7kJ/ebtdKXKhAgzbn6q8z0+2l2phnlvJdPld0R526OEvK7w
 78bImdguJVsPrvVUKRIjkbrUNGeHC4lCg92DJ9WiEIBODkyTW/DV+1w+HpaFyJsxDeVc
 R+RWUzjqDULJEOUs+N3dcy5KVjn8SdpazBKBXLbNaaeLXBMRjHcAWxkFhamuMvtknTuf
 RoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774022959; x=1774627759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ls+6UcXld1NtMIbY4Nw5EuiQUjc1V4AaOnaDRbb7rxs=;
 b=V5d/6Zuxkixtg0YlFu3jC54D33YInK8WWtfrJ4YGlonamkmCV1D0RoJgj1/nDrUhn8
 fQw0DGLTw1k1+J29VXnNyqpiLFOfnEnTP28CecgEx0id8goed2AIPKRoPKx9SSGM9bsT
 tak0sEfTHMYTsF+nKxsteuU/FOwiJfxTVS1MddExxwBLm305X143vhtLH3cO3WPGAu9l
 w4YqSFqXi7c0E8EjGnRe07NpOWhzm4N1YXVbDtbxgRujuI0rpgeaS+TDJ3TQTYaoOuwc
 o9/MqVGhqOmLsVPQ/0/b3GHgJBmP769mSwc/tepyHbe4D8RNSE0DF/qOfFYVGRuyJnSN
 +jxQ==
X-Gm-Message-State: AOJu0YwRTUyGXYCGy4dJR30iFUvMufQLO2s4eZ5wuoVgPF1mW06fgHDq
 +3RsaqpllhqoES9CalKSomUqI304NLtxXEvqFsWrwINM46p9KiGmtpxZe30Gp4ZwV7WuMu7ZlTf
 g7n49Kso=
X-Gm-Gg: ATEYQzyS3a63rXtuKLkAAbawjlVB0Xav4kihCs2L+YzpIxPAEyctG80ApS1+9TodxmF
 7Y8b/osA+8228ODualjNyMqna8Ji8gm2dBMv8DiB5d5itpVrGuoZOmYSPVbSObwwgRBwfxkZw2G
 EnBfkq+Z1TjF+cmNnNY+Uj3ev31lZn4I5cACUkmcxaDQqFdR6prGNosBtCjeDvb5jwYAg4z/SjI
 gbD+VYoLcweRMISNvl7awlAzeU5pj7EVWHs7Vqs6nN2ULO1kaQXKOBVw4JQHv0Sr2MoYib4Ftay
 knMaWiJYezkvfBvJXG1bKOOVX6T+peHiaKi9eyyTSYG0AhCeO8H3X2K4H9hYixoh4kPKwe0Qad3
 CplWBTgQav6YuoMDBoRQHmBztEBryH9TvVNaPCZxyVyl4N6hdlJiuWzHChMuarmqpNUX0JgEkXs
 88ruBsMWpEvV7l0GAdSwn6zEm4wBmqQe4RA4f8nOwhxQ++GaG29aunvp5y2ZiMpfIjkwMe8wJq
X-Received: by 2002:a05:600c:c173:b0:485:5981:1411 with SMTP id
 5b1f17b1804b1-486fee1a26bmr50416455e9.23.1774022958872; 
 Fri, 20 Mar 2026 09:09:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644bdaf8sm8333196f8f.13.2026.03.20.09.09.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 09:09:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH-for-11.1 09/10] target/riscv: Register target_get_monitor_def
 in CPUClass
Date: Fri, 20 Mar 2026 17:08:09 +0100
Message-ID: <20260320160811.28611-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320160811.28611-1-philmd@linaro.org>
References: <20260320160811.28611-1-philmd@linaro.org>
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

Rename target_get_monitor_def() as riscv_monitor_get_register_legacy()
and register it as CPUClass::legacy_monitor_get_register() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/internals.h | 3 +++
 target/riscv/cpu.c       | 1 +
 target/riscv/monitor.c   | 4 +++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 460346dd6de..90225d322ff 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -245,4 +245,7 @@ static inline int insn_len(uint16_t first_word)
     return (first_word & 3) == 3 ? 4 : 2;
 }
 
+int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
+                                      uint64_t *pval);
+
 #endif
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8ac935ac06e..e73d15476a7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2750,6 +2750,7 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
     cc->get_arch_id = riscv_get_arch_id;
 #endif
     cc->gdb_arch_name = riscv_gdb_arch_name;
+    cc->legacy_monitor_get_register = riscv_monitor_get_register_legacy;
 #ifdef CONFIG_TCG
     cc->tcg_ops = &riscv_tcg_ops;
 #endif /* CONFIG_TCG */
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 3f206b9fca5..1c90c779534 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -26,6 +26,7 @@
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
 #include "system/memory.h"
+#include "internals.h"
 
 #ifdef TARGET_RISCV64
 #define PTE_HEADER_FIELDS       "vaddr            paddr            "\
@@ -310,7 +311,8 @@ static bool reg_is_vreg(const char *name)
     return false;
 }
 
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
+int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
+                                      uint64_t *pval)
 {
     CPURISCVState *env = &RISCV_CPU(cs)->env;
     target_ulong val = 0;
-- 
2.53.0


