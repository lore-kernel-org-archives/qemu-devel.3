Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5A4103E162
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oQk-0003ZK-51; Wed, 18 Mar 2026 06:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w2oQc-0003Vu-0X
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:47:06 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w2oQa-0003LH-Bq
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:47:05 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48540355459so65282845e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773830822; x=1774435622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUGPmMKqMk4+vVhGesc7w5uFwyBaXJELY7Ee1310cEg=;
 b=OKDaNc9sj0GiPK0c6w629I/wsrECCKf+GrKf/VJs3A6ciB66phCV62enN1qL/NPItd
 h+oLor9Kccm2uKyovBUH/gwY6Kx0/5AsCFnBs+dPad4WLRjoB8tUXpGG2QgjviRUTSg0
 C2A+PKWxd5a2ee9XOSDQbh77FYhJO0tKgLCASXz5Zzb24WYFxFqsv336vRTogUELWiFk
 F7nkB0Ftg1ssxBeUdJDya9wMJfKROl1WuySduqhhKxf0cQJPENPCbh1oy7jrieHrL+tU
 OcMuA9pmnoG/Oo3yH2YxkP3N1e+dPwB4PfaIH1IJPggvytuSogB7Of6aLwcEV4dMJWfU
 qrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773830822; x=1774435622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TUGPmMKqMk4+vVhGesc7w5uFwyBaXJELY7Ee1310cEg=;
 b=luJ7GLriVZ21azGLYTUJCKDSkj/44ZVKYgqKBJclDy2yrX7sAphjj8u9HEsHoR0xHa
 yvh5HHDGwidcp+CkLpt2hRE+Ia+jj+HDt0zSgNHj1d7qaO8bZ4HZvR0MnhwdcOuSfI1P
 EQLkAipKPaBzN/e1cArllwcB6lAawHCIUk1XtHZRiEe/tPM9am54JlnCrRGtl1D+VVVz
 kqfQxsjrbuHhTqsHilZ2Ues9Jj6nof3qE3G6rTw4c9rrhBNKzex3Pmpwm0jjG1MKsOvD
 3cNhCVlm3kQ3d7ztzT8V3UnCunslCO7VGZbI7ZAles4lE4EtANl4Z90QGXrn4Q/TID4z
 zwPQ==
X-Gm-Message-State: AOJu0YxGKSbADbFhibeaeSrIa9l8zFimRjiRZ38q1QIexAPPwSSARzq5
 9HNO4HzSnZdkk7j9fTqjLPpLbUrnGvDEAT0HEg0lPqCsMgzrYJj4fc+28tUIK/NZ
X-Gm-Gg: ATEYQzy+TXjRcyX7Th+GoQOe7YP1r/fHvntrVHEmZAcwp2eB9quQEodNzub+LVVR0Yd
 mUcIg3TZf7uj64ddNA5kbipfs1wLS+asUAPGEJJLUkXGcTO//HUd1qfXX+foxwy2hhZfnJz0is0
 OaJ5uEfqGkZiUMD/pLtyHSUeoy1eqiSKa5zJNR2rY3+gxAAMF2ZbVGaG7AGCsGLhTk4pwkTnbfS
 ncNagcOqbZo723MPy8O9hi7lOTiz24+gPTDze/4gMKwtU29KejT+VF2iQtR6GwgY6c59lhGy1Ea
 Il7mBeDukzAx68tgW7SsOu/UyNeq3X0exLo2MJ0YHjID6CQbuZRYo3OwtF2aS9o+I5pwH/NEAB0
 WNr7xubo1VOW5idlpU0MGuw+A3yzAFAHgjGU/FO/TYLVhpVfLTMrIrRI68Q0hYF/5k+iztZ4j6s
 086nVt0W/LHJNGDl0VQKAG5v5ZsHf7oU0MqSdwZ73W/Lahblk8+MKwLEMkFVJZM31NPw==
X-Received: by 2002:a05:600c:810c:b0:477:b642:9dc1 with SMTP id
 5b1f17b1804b1-486f4475342mr47765135e9.20.1773830822041; 
 Wed, 18 Mar 2026 03:47:02 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-80-194.adsl.net.t-com.hr.
 [93.143.80.194]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-486f420de8asm56471095e9.3.2026.03.18.03.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 03:47:01 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 alex.bennee@linaro.org, peter.maydell@linaro.org,
 pierrick.bouvier@linaro.org, philmd@linaro.org, Ruslan_Ruslichenko@epam.com
Subject: [RFC PATCH 3/9] plugins: Expose Transaction Block cache flush API to
 plugins
Date: Wed, 18 Mar 2026 11:46:34 +0100
Message-ID: <20260318104640.239752-4-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318104640.239752-1-ruslichenko.r@gmail.com>
References: <20260318104640.239752-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

The patch introduces qemu_plugin_flush_tb_cache() to the plugin API,
allowing plugins to invalidate QEMU translate code cache.

If a plugin needs to dynamically register a new instruction or memory
callback, the new hooks may not be triggered for code blocks that
QEMU has already translated and cached. This API allows QEMU
re-translate TB, so that new applied hooks will take effect.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 include/plugins/qemu-plugin.h |  3 +++
 plugins/api.c                 |  6 ++++++
 plugins/core.c                | 11 +++++++++++
 plugins/plugin.h              |  2 ++
 4 files changed, 22 insertions(+)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index bbd21e79c5..a68427536f 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -1246,6 +1246,9 @@ void qemu_plugin_u64_set(qemu_plugin_u64 entry, unsigned int vcpu_index,
 QEMU_PLUGIN_API
 uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry);
 
+QEMU_PLUGIN_API
+void qemu_plugin_flush_tb_cache(void);
+
 QEMU_PLUGIN_API
 uint64_t qemu_plugin_get_virtual_clock_ns(void);
 
diff --git a/plugins/api.c b/plugins/api.c
index 609ea69293..fa650e1219 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -653,6 +653,12 @@ uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry)
     return total;
 }
 
+QEMU_PLUGIN_API
+void qemu_plugin_flush_tb_cache(void)
+{
+    plugin_flush_tb_cache();
+}
+
 typedef struct {
     void (*cb)(void *opaque);
     void* opaque;
diff --git a/plugins/core.c b/plugins/core.c
index 42fd986593..462f4bae81 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -21,6 +21,7 @@
 #include "qemu/rcu.h"
 #include "exec/tb-flush.h"
 #include "tcg/tcg-op-common.h"
+#include "qemu/main-loop.h"
 #include "plugin.h"
 
 struct qemu_plugin_cb {
@@ -888,3 +889,13 @@ enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_flags(int flags)
         return QEMU_PLUGIN_CB_RW_REGS;
     }
 }
+
+void plugin_flush_tb_cache(void)
+{
+    CPUState *cpu = qemu_get_cpu(0);
+    if (cpu) {
+        queue_tb_flush(cpu);
+
+        qemu_cpu_kick(cpu);
+    }
+}
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 6fbc443b96..0bf819536b 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -125,4 +125,6 @@ void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score);
  */
 void qemu_plugin_fillin_mode_info(qemu_info_t *info);
 
+void plugin_flush_tb_cache(void);
+
 #endif /* PLUGIN_H */
-- 
2.43.0


