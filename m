Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FDCF531DE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRiK-0001B5-4y; Mon, 13 Apr 2026 20:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRiI-0001AE-3C
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:33:10 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRiG-0003b4-Hk
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:33:09 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4887fd35e60so35228265e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126787; x=1776731587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P+MkKHTxKAsGH7mkXb7QOys2aguqDNuWH1H2LcjP2Ig=;
 b=ufCm6J0fs61FwhPg5m4XSAoo5iYs3af31GLjX/BGJHbcwo1neesSsWV7EMFdRVAGD+
 yewAks2lfdH+39Gk6kSrF76D0Fe6kT8i4VjzlYRZrm7DOE5tlFWW637HXAkxHYkg6Y0u
 mbpxTC57uEsEIildL8Fl5FmRFixQGVOhhVFzTRxuG+vYGFX46XTqKiX/1cBn1E9is/Fy
 0wAiDInD2W2uHCUweieFDm8c41OgYALUKUOpVMgo/o6KDqDNlW1gkBElw8dP84N+hppq
 cRt9EHtJwUhL5nmhAz7lGgq+Xreii+JmssbK7AShLXIBXdvT0LP6kbvH5Wk+nAf/TkgA
 fSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126787; x=1776731587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P+MkKHTxKAsGH7mkXb7QOys2aguqDNuWH1H2LcjP2Ig=;
 b=jJzr7bFvETX8yjcQxm6E11a+j7hwihWRN/qtPkAS8N5EFGeEojuQxLZe1Wqwrw6uV2
 FK3x0bzI6zfRFzySLuvR4m8YXxP3GStIjDkaP4D9RG2Vc95OjbVYqSqylfiieRovYjkr
 yfhVs1Ap22EdGNgWxU2k9glQOS0ZgSwo0aRvLkw+kNLSega4+g7H3KFgNeIaLXPEXzwO
 qxJrM9uek+pcRdhIEOqGZQwF+8FutbWsfYZiBdJ+nJMMYnzSck9MVPUTzoSBxg/hs/Iu
 jvLS2toUU7lv9+tc6UOHB4spEQWbsToVYHyzhyGe+LE/PkuEIF6zNuh0kfHPzgteZcJt
 MGuA==
X-Gm-Message-State: AOJu0Yyq1oLYgdYHlj9vgP+Gx6+SDks+SFrYGiN0kx3fdbXMmejx3nhf
 O85Qrp+GH+MIXVWFSOZ2KA+vGK1NZEUtGHhbIjuxAUGVn5zSvaPo5gCnGYEqL6WzHKVRAkxUdYq
 AqhIYok0=
X-Gm-Gg: AeBDiesiesbhbHFdPA64WNRd684ENI8WEcKPt9DfR8pHdBSWqq6/OFXWilvSA+GczdB
 hhxUiQ8AnhAsocI/UbcNQCZbwNvzgDEumYlWFXpvBPDGf3aF1sdP2Er1ALUBEN2XqtAC3U6OLa1
 N06iSyDn3oSa6qaI0v77npJBpg/cfsbhXBZL2PQdAUdrxS7DdP9MxURh1vvbVjhzA29cmqvqNxq
 B1qNjD/1A5G//OhA2Ls2yIfVYF/7oWGv30qwI+UoKma55Sz0JbMZ6dHAK3cXLDmh//PScAAKokf
 PLSDBwRjFabC1H2hIQ0Kddw8qFlF1M1AcFYMHgh9UvWNUHe583kNcOnXmMntRvc6Ny8y+il6/yA
 PY3XpsY7qKnHtw38w+xR/ORzEfmH+i5kd8YafZA3kRMX3rA4ZKuBedsNJJeLgIO953sPs1p8mxy
 g91cq+Oc1qY1Id+oAKB3UDEv5sg+b8w7DIqe9FORq3dKqLYCCtmDr89Kbnekmba/1sJ1rytMRW
X-Received: by 2002:a05:600c:3ba8:b0:488:af7f:7707 with SMTP id
 5b1f17b1804b1-488d6836621mr210119185e9.18.1776126786861; 
 Mon, 13 Apr 2026 17:33:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede24eb0sm5829775e9.8.2026.04.13.17.33.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:33:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v3 25/27] target/sparc: Replace target_monitor_defs ->
 SysemuCPUOps::monitor_defs
Date: Tue, 14 Apr 2026 02:29:57 +0200
Message-ID: <20260414003001.97571-26-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
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

Restrict sparc64_monitor_defs[] to cpu.c, register it
as SysemuCPUOps::monitor_defs hook (taking care to not
register it on 32-bit SPARC target), allowing to remove
the target_monitor_defs() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.c     | 19 +++++++++++++++++++
 target/sparc/monitor.c | 18 ------------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 1493336e7a2..9c5175aca34 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -993,12 +993,31 @@ static const Property sparc_cpu_properties[] = {
 };
 
 #ifndef CONFIG_USER_ONLY
+
+#ifdef TARGET_SPARC64
+#include "monitor/hmp.h"
+
+static const MonitorDef sparc64_monitor_defs[] = {
+    { "asi", offsetof(CPUSPARCState, asi) },
+    { "pstate", offsetof(CPUSPARCState, pstate) },
+    { "cansave", offsetof(CPUSPARCState, cansave) },
+    { "canrestore", offsetof(CPUSPARCState, canrestore) },
+    { "otherwin", offsetof(CPUSPARCState, otherwin) },
+    { "wstate", offsetof(CPUSPARCState, wstate) },
+    { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
+    { NULL },
+};
+#endif
+
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps sparc_sysemu_ops = {
     .has_work = sparc_cpu_has_work,
     .get_phys_page_debug = sparc_cpu_get_phys_page_debug,
     .legacy_vmsd = &vmstate_sparc_cpu,
+#if defined(TARGET_SPARC64)
+    .monitor_defs = sparc64_monitor_defs,
+#endif
 };
 #endif
 
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 99abddbf1e0..36f3d8d58e9 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -37,21 +37,3 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
     }
     dump_mmu(env1);
 }
-
-const MonitorDef monitor_defs[] = {
-#ifdef TARGET_SPARC64
-    { "asi", offsetof(CPUSPARCState, asi) },
-    { "pstate", offsetof(CPUSPARCState, pstate) },
-    { "cansave", offsetof(CPUSPARCState, cansave) },
-    { "canrestore", offsetof(CPUSPARCState, canrestore) },
-    { "otherwin", offsetof(CPUSPARCState, otherwin) },
-    { "wstate", offsetof(CPUSPARCState, wstate) },
-    { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
-#endif
-    { NULL },
-};
-
-const MonitorDef *target_monitor_defs(void)
-{
-    return monitor_defs;
-}
-- 
2.53.0


