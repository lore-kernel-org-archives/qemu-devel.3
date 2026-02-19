Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51BFE9A04F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9cI-000425-9F; Thu, 19 Feb 2026 14:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9bC-0002lV-7z
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:22:08 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9b8-00089P-Po
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:22:05 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48069a48629so13215245e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528920; x=1772133720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4b7EKIXUxIIWUL8kF3shWPR4w8ejLWmhqz7rlqrrl8=;
 b=Ax/pqDxk48lkk1acsFj4LAVE/3O0I44CzFPYePBCsDH14stIZ9V7/4YlQ4hyNy6PdT
 JUgVD+K+Ah2cKfGjvHr7/STK1X/PtHHohyjEUJR94ipQkZDpKfDB0FPr2CkeKmfqBoV0
 jQSQzFWG46TKOvLhvvAdaTZ7mMVWcrLxv7WLLlC9gk48usHs2EgqvZxUR/XOrtrZC4II
 ph9qKM03Dli/KZqxHmFr9LC4Z5yyS+rdsQe4FKMpiO6joVQuJLEWrUOzCI5dSGNfVDxl
 0S+YuebkOsZu32zswrdRTQG+9n8mmI6mmJG1ih2M0+LCOf9brQvTr2WcufNkrvspbQsg
 gZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528920; x=1772133720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z4b7EKIXUxIIWUL8kF3shWPR4w8ejLWmhqz7rlqrrl8=;
 b=CVEDYfGjhmR05SSWuiQZHZINJJi9kfsPqqpiB2uK8c4sZyY9mGtOhQsQS3FzAVyoZ9
 JmTokmL8fjZkAPMGnyX/TVxc8Imwwr3mQErfMN+5urC+zQ8WepQsqxpoub5RX9V9y8De
 p7/+cKyvtR5ezWVb3fmUpGQYsU8dNbik2fTaaRzYryZzU28nV56WyzxIQV3MRi3vQeT9
 KwQJ7ZK5ExKg5oxskZYOCTus6MZBT/aLhVDxDE7fQgCTSSveoQGqghw9PD5cQ96GN2vC
 LzdoFvSB689s6SgHBWJDn4xlPatuD+CNPTNy7YFGVRoMCKmHe41TiA2534AsNVrpa6u2
 O0cw==
X-Gm-Message-State: AOJu0YxjJ86sMBhPZHtgR1A3SwboD1oCxIPYbBY7+Rptm/VSvrfriBAZ
 /tZjnNudZH4DwYJQWXrMV0OZFqkLtT1Nean7rTrKjm/GpGDczOGtpHyjbv0v8nz8Oq+x3NfncoG
 q1OOK64sR6A==
X-Gm-Gg: AZuq6aIcRmQXRaCklsirH2/zPDKCwRs4YZSkuFGU7XDZkxf2Gd6zn9OslNH55PB5+R+
 RJlCRpeQcFm8/JkODTDDMyHx1aKlSVTuzviSUg3Q3J/SNik/zqX9KXHGn+jCscyOv/5/qHyHLTp
 SQM2U2EcUg7SpHtjB+FQX/QWnj8j8mR2Z/3mj5/kwiV/pyeEAFdC+fQ/fUrn5eIxclalexLUPgS
 wT7Sqvm5uiLD6iOsSLx4ru8v2taSklqFwczRzb0tRjkivDqvgX/uv6TfRWIs5GmNZTYgFMmqlci
 gpTp04yZ1cAAuOqNolMlT0GRNvoXiR+mUoqcUhIJxmI5DNkn0eTdcZmg1d9ktPI0HKY+q5ANIIO
 cXx6KKVhXABZNR4SP1Ba/Ns6hi6e4pfPCckWwkevE20pq3/wOzNpnKDVRO0ltL0CzKTGBbr2ybn
 QlYKwNqPVrEUvR+b43b7k1nyzzQ0pnlEnSPJbRlMkOtW3NNZmjtAchQuiUy6qr9JgcTdCRxFev
X-Received: by 2002:a05:600c:4e56:b0:480:20f1:7abd with SMTP id
 5b1f17b1804b1-48373a58997mr405360645e9.31.1771528920276; 
 Thu, 19 Feb 2026 11:22:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31ff4d7sm22156645e9.15.2026.02.19.11.21.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:21:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v2 17/50] target/sparc: Remove MonitorDef register entries
 available via gdbstub
Date: Thu, 19 Feb 2026 20:19:19 +0100
Message-ID: <20260219191955.83815-18-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
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

All these registers are already provided by via gdbstub parsed XML
and handler by the gdb_get_register() helper in the monitor/hmp.c
file. Remove as now unreachable code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/monitor.c | 107 -----------------------------------------
 1 file changed, 107 deletions(-)

diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 73f15aa272d..a60671a60a4 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -39,114 +39,8 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
     dump_mmu(env1);
 }
 
-#ifndef TARGET_SPARC64
-static target_long monitor_get_psr(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
-{
-    CPUArchState *env = mon_get_cpu_env(mon);
-
-    return cpu_get_psr(env);
-}
-#endif
-
-static target_long monitor_get_reg(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
-{
-    CPUArchState *env = mon_get_cpu_env(mon);
-    return env->regwptr[val];
-}
-
 const MonitorDef monitor_defs[] = {
-    { "g0", offsetof(CPUSPARCState, gregs[0]) },
-    { "g1", offsetof(CPUSPARCState, gregs[1]) },
-    { "g2", offsetof(CPUSPARCState, gregs[2]) },
-    { "g3", offsetof(CPUSPARCState, gregs[3]) },
-    { "g4", offsetof(CPUSPARCState, gregs[4]) },
-    { "g5", offsetof(CPUSPARCState, gregs[5]) },
-    { "g6", offsetof(CPUSPARCState, gregs[6]) },
-    { "g7", offsetof(CPUSPARCState, gregs[7]) },
-    { "o0", 0, monitor_get_reg },
-    { "o1", 1, monitor_get_reg },
-    { "o2", 2, monitor_get_reg },
-    { "o3", 3, monitor_get_reg },
-    { "o4", 4, monitor_get_reg },
-    { "o5", 5, monitor_get_reg },
-    { "o6", 6, monitor_get_reg },
-    { "o7", 7, monitor_get_reg },
-    { "l0", 8, monitor_get_reg },
-    { "l1", 9, monitor_get_reg },
-    { "l2", 10, monitor_get_reg },
-    { "l3", 11, monitor_get_reg },
-    { "l4", 12, monitor_get_reg },
-    { "l5", 13, monitor_get_reg },
-    { "l6", 14, monitor_get_reg },
-    { "l7", 15, monitor_get_reg },
-    { "i0", 16, monitor_get_reg },
-    { "i1", 17, monitor_get_reg },
-    { "i2", 18, monitor_get_reg },
-    { "i3", 19, monitor_get_reg },
-    { "i4", 20, monitor_get_reg },
-    { "i5", 21, monitor_get_reg },
-    { "i6", 22, monitor_get_reg },
-    { "i7", 23, monitor_get_reg },
-    { "pc", offsetof(CPUSPARCState, pc) },
-    { "npc", offsetof(CPUSPARCState, npc) },
-    { "y", offsetof(CPUSPARCState, y) },
-#ifndef TARGET_SPARC64
-    { "psr", 0, &monitor_get_psr, },
-    { "wim", offsetof(CPUSPARCState, wim) },
-#endif
-    { "tbr", offsetof(CPUSPARCState, tbr) },
-    { "fsr", offsetof(CPUSPARCState, fsr) },
-    { "f0", offsetof(CPUSPARCState, fpr[0].l.upper) },
-    { "f1", offsetof(CPUSPARCState, fpr[0].l.lower) },
-    { "f2", offsetof(CPUSPARCState, fpr[1].l.upper) },
-    { "f3", offsetof(CPUSPARCState, fpr[1].l.lower) },
-    { "f4", offsetof(CPUSPARCState, fpr[2].l.upper) },
-    { "f5", offsetof(CPUSPARCState, fpr[2].l.lower) },
-    { "f6", offsetof(CPUSPARCState, fpr[3].l.upper) },
-    { "f7", offsetof(CPUSPARCState, fpr[3].l.lower) },
-    { "f8", offsetof(CPUSPARCState, fpr[4].l.upper) },
-    { "f9", offsetof(CPUSPARCState, fpr[4].l.lower) },
-    { "f10", offsetof(CPUSPARCState, fpr[5].l.upper) },
-    { "f11", offsetof(CPUSPARCState, fpr[5].l.lower) },
-    { "f12", offsetof(CPUSPARCState, fpr[6].l.upper) },
-    { "f13", offsetof(CPUSPARCState, fpr[6].l.lower) },
-    { "f14", offsetof(CPUSPARCState, fpr[7].l.upper) },
-    { "f15", offsetof(CPUSPARCState, fpr[7].l.lower) },
-    { "f16", offsetof(CPUSPARCState, fpr[8].l.upper) },
-    { "f17", offsetof(CPUSPARCState, fpr[8].l.lower) },
-    { "f18", offsetof(CPUSPARCState, fpr[9].l.upper) },
-    { "f19", offsetof(CPUSPARCState, fpr[9].l.lower) },
-    { "f20", offsetof(CPUSPARCState, fpr[10].l.upper) },
-    { "f21", offsetof(CPUSPARCState, fpr[10].l.lower) },
-    { "f22", offsetof(CPUSPARCState, fpr[11].l.upper) },
-    { "f23", offsetof(CPUSPARCState, fpr[11].l.lower) },
-    { "f24", offsetof(CPUSPARCState, fpr[12].l.upper) },
-    { "f25", offsetof(CPUSPARCState, fpr[12].l.lower) },
-    { "f26", offsetof(CPUSPARCState, fpr[13].l.upper) },
-    { "f27", offsetof(CPUSPARCState, fpr[13].l.lower) },
-    { "f28", offsetof(CPUSPARCState, fpr[14].l.upper) },
-    { "f29", offsetof(CPUSPARCState, fpr[14].l.lower) },
-    { "f30", offsetof(CPUSPARCState, fpr[15].l.upper) },
-    { "f31", offsetof(CPUSPARCState, fpr[15].l.lower) },
 #ifdef TARGET_SPARC64
-    { "f32", offsetof(CPUSPARCState, fpr[16]) },
-    { "f34", offsetof(CPUSPARCState, fpr[17]) },
-    { "f36", offsetof(CPUSPARCState, fpr[18]) },
-    { "f38", offsetof(CPUSPARCState, fpr[19]) },
-    { "f40", offsetof(CPUSPARCState, fpr[20]) },
-    { "f42", offsetof(CPUSPARCState, fpr[21]) },
-    { "f44", offsetof(CPUSPARCState, fpr[22]) },
-    { "f46", offsetof(CPUSPARCState, fpr[23]) },
-    { "f48", offsetof(CPUSPARCState, fpr[24]) },
-    { "f50", offsetof(CPUSPARCState, fpr[25]) },
-    { "f52", offsetof(CPUSPARCState, fpr[26]) },
-    { "f54", offsetof(CPUSPARCState, fpr[27]) },
-    { "f56", offsetof(CPUSPARCState, fpr[28]) },
-    { "f58", offsetof(CPUSPARCState, fpr[29]) },
-    { "f60", offsetof(CPUSPARCState, fpr[30]) },
-    { "f62", offsetof(CPUSPARCState, fpr[31]) },
     { "asi", offsetof(CPUSPARCState, asi) },
     { "pstate", offsetof(CPUSPARCState, pstate) },
     { "cansave", offsetof(CPUSPARCState, cansave) },
@@ -154,7 +48,6 @@ const MonitorDef monitor_defs[] = {
     { "otherwin", offsetof(CPUSPARCState, otherwin) },
     { "wstate", offsetof(CPUSPARCState, wstate) },
     { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
-    { "fprs", offsetof(CPUSPARCState, fprs), NULL, MD_I32 },
 #endif
     { NULL },
 };
-- 
2.52.0


