Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1283CF45A0D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHw0-0000ry-Hk; Fri, 10 Apr 2026 15:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHvy-0000pv-Se
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:54:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHvv-0001US-I6
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:54:30 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso28740705e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850864; x=1776455664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EuoKZZrJIA/hKCIvNS2NFNqHU7220n1eLUSWyy7IvJI=;
 b=ojN2lMcenJRrbVuHebxt77o/Zn5ZVKZBHEVBGJKGFrAsQ7YLks9c02YOEQuzU1hjFL
 G6CP6F11HbakOLwDwlCzDvzamzNVMEtXIDUFuVMpn/MUERdZ30x4OS2sZld7rry3JJRJ
 +84Nu2FFrgsDxc/tIRJ8l6uWL4z5WUzGIvMzs4yCzQbOf+v4k9telaJaI4EIC9C6fIxD
 sw9pTAA5Xcy81MAjChhSCfc90WLGrrc/yB38o0YN+EyokhGGh0VsUmS3r4cbkmsXFkpK
 k9OlrtrPTlRdZ+zcj4WyfBBQ99YtOlTZc2awY46YP3x1hkOISZ3xMVElyTuVq8foo3mA
 396w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850864; x=1776455664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EuoKZZrJIA/hKCIvNS2NFNqHU7220n1eLUSWyy7IvJI=;
 b=smFeGNIbMEcOJPE6PqTSG40GGJHyVoZJPPCjgr2TrDX4rZcWe8J12rjB4uC8FCMz73
 EZk/8Oc+O5KuLVij35NQp66ipAfMfJPzjqS44/g6asCB6LlGfkcXH7P+lq7FDha59u95
 bAoM0L6xgaN7HXtUQ/p0Vvpnjg7AKevwtUV+IFHJpGG2ocGS9ETM8AQrHYiTmdYRQBfD
 Ckm/YM0kv6/P9ztNhbYnXc49hVrPDu0e258TOC/ylbIPEw7p6FV+IEijNYhVxi9n7CHD
 CGE8NWNGFy0L9J5xo019pNV92WObTua76URY6CLJC/THgIfIdcwqzUak7ojO2SuhVAT3
 QHvw==
X-Gm-Message-State: AOJu0YxYhUSWpxWXt29OCuRsKu25cFU6xJtITVkrDV7zuG4WPeUZ6sKt
 RKILGTDWmShV3DMz4PJ2TrA0zPulseUqzzsfULtwRC5qXUf+DLrtEuIhKFTY4opd5pTVDWqKarT
 SE41tLQI=
X-Gm-Gg: AeBDieujGLiF0rCmJzxvearRwbO9/FK6b40r0LtcDjVMl1EuVQKnIoKh2T0jAGGWaWs
 a0ZGJIWgMx+OCxoRoHQ0y4Ib18YTsuHuBlyEovccmBDVSbAUrbu24WSuhmwqF8Fi9yiDU0xQ7TS
 9K9uSvDdcLgK0V5N8JkPR4PnLk4Caf4I266iY0xqEfMZxPVEV5HN1eAr7GHdlJ9eKWfnDLoB+9v
 t0AGIl9omMMONQ63CEPZCpomNQJ4E8JXSVIP3aY8RofGqGkzmZBV9oa31Z2uF18KenZnkMqKuVV
 aHo0TJzTVulpFmjr35xm9/nUZsJkButxMmqOYHV0cWaPEXzAqTByO2B0ttD4Pmb0dhNTaBsegeQ
 +nQVMAVqXd13ouzCgthFh0mJKOXOeiKTmLsFhNmkPo8dMg4XvXVJnG5DCwmuxnT9smYmomqEpLw
 2n3K/NczIgMwOotM6XyH7ikS/rcFVeEsWotD+NcgtfftqiSRlDzjtLI1ruHDjrA9BxJSrCGjQX
X-Received: by 2002:a05:600c:a109:b0:488:a977:8de with SMTP id
 5b1f17b1804b1-488d6839866mr43608325e9.16.1775850863956; 
 Fri, 10 Apr 2026 12:54:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d683e54fsm26145515e9.23.2026.04.10.12.54.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:54:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 08/27] target/m68k: Replace target_monitor_defs ->
 SysemuCPUOps::monitor_defs
Date: Fri, 10 Apr 2026 21:53:02 +0200
Message-ID: <20260410195323.17937-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Restrict m68k_monitor_defs[] to cpu.c, register it as
SysemuCPUOps::monitor_defs hook, allowing to remove
the target_monitor_defs() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/cpu.c     | 18 ++++++++++++++++++
 target/m68k/monitor.c | 21 ---------------------
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index d849a4a90fc..f704a6af613 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -25,6 +25,7 @@
 
 #ifndef CONFIG_USER_ONLY
 #include "migration/vmstate.h"
+#include "monitor/hmp.h"
 #endif
 
 #include "cpu.h"
@@ -602,11 +603,28 @@ static const VMStateDescription vmstate_m68k_cpu = {
     },
 };
 
+static const MonitorDef m68k_monitor_defs[] = {
+    { "ssp", offsetof(CPUM68KState, sp[0]) },
+    { "usp", offsetof(CPUM68KState, sp[1]) },
+    { "isp", offsetof(CPUM68KState, sp[2]) },
+    { "sfc", offsetof(CPUM68KState, sfc) },
+    { "dfc", offsetof(CPUM68KState, dfc) },
+    { "urp", offsetof(CPUM68KState, mmu.urp) },
+    { "srp", offsetof(CPUM68KState, mmu.srp) },
+    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]) },
+    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]) },
+    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]) },
+    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]) },
+    { "mmusr", offsetof(CPUM68KState, mmu.mmusr) },
+    { NULL },
+};
+
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps m68k_sysemu_ops = {
     .has_work = m68k_cpu_has_work,
     .get_phys_page_debug = m68k_cpu_get_phys_page_debug,
+    .monitor_defs = m68k_monitor_defs,
 };
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index be7411edca6..3e0df40a6b8 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -21,24 +21,3 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 
     dump_mmu(env1);
 }
-
-static const MonitorDef monitor_defs[] = {
-    { "ssp", offsetof(CPUM68KState, sp[0]) },
-    { "usp", offsetof(CPUM68KState, sp[1]) },
-    { "isp", offsetof(CPUM68KState, sp[2]) },
-    { "sfc", offsetof(CPUM68KState, sfc) },
-    { "dfc", offsetof(CPUM68KState, dfc) },
-    { "urp", offsetof(CPUM68KState, mmu.urp) },
-    { "srp", offsetof(CPUM68KState, mmu.srp) },
-    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]) },
-    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]) },
-    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]) },
-    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]) },
-    { "mmusr", offsetof(CPUM68KState, mmu.mmusr) },
-    { NULL },
-};
-
-const MonitorDef *target_monitor_defs(void)
-{
-    return monitor_defs;
-}
-- 
2.53.0


