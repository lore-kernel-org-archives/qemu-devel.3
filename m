Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B8FFD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO84-0000wL-Hv; Wed, 25 Feb 2026 18:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO7u-0000Pa-8l
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:17:07 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO7r-0002vT-EX
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:17:05 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4398913af88so193372f8f.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061422; x=1772666222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lSNlwJuPXGszeQdnTHeG7EmOBqF5JmRNaaxT9HlYMjc=;
 b=RJ4+XRZFo+iMferKtM1YZCI/A920HK44hHKIOsVTm01eGypXrSDshnHT5dIK4BihAM
 HZPqb0gwWKICoG6Av75ULMQwyNPfQXKHDTal3Cbe1X0THUWYC0pGHdOZvjiD1NIMyze6
 TkZUWmWIkC1gBgUGIaT1pilJ1ILweZNruD0qO4XN1uovNvYv7CYtxP1aMFx/iFc1h1Bk
 cMWnxxOxTu9T/gP3UGxKRnZDf6MpIUUfTPwmuP7neY/kO4CMPewCaYfHjykmSMikIrk/
 hLEdUJssXN+XXMg78Q0sTZmA9Am4lvf/MjzMvnVhL87cxeI8ubLwcn2gaA9pK7elXBNJ
 tFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061422; x=1772666222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lSNlwJuPXGszeQdnTHeG7EmOBqF5JmRNaaxT9HlYMjc=;
 b=n49W8pV8gO2R7mjJ6bCd4CV7MI73fmePCZ7l0X0Y3Sx/BNgsMJ17AhNliXlrsk003F
 Gs4zSB73MxNfiUAG6p5yZ/0gnEpKtLdliB1CKvPa1/+eY/6fFkSGqKgk8w127mRnYRLq
 6IoU9aIDsoWefHlM62nsLSdjudgfTG7dSFuOFJZYotE371u77cGnCACoIsArJcNnaMUJ
 ++5SQMlb6yPgzNMATO/s6FD1kRAi9NLOsbSTDu9Vg2wLKrKupsmLVYMnAiicjtsvu+n8
 qV0cprAw7DwcLBH9pJ1nsAaKO4FJr3grPg199Zgd+sWn35mIO5kx1r1iRg213JU3//wT
 Obqg==
X-Gm-Message-State: AOJu0Yw9nEzDiRaR9xJDqd1bxXZ0dXMJpT1zfvQlG15NwFezSpBkV1Gr
 wHrTXCVX6DeWq8ZFe6EL8e5qWT0udmpj+izBofEQL9UzwAA1T0WTeHjH8KrYxCIo1yHeeWwuJLZ
 +J+7YU3w=
X-Gm-Gg: ATEYQzz0gE2NFpkXLuHUWTNby661EMqDxT+vkFe0+mnzFHiuVsOvkiGbz1eInuM029G
 o1yVQI5vCECvfZq4AF9Z77Uk0O/+JJxqPjRyJwx4PmDIYH7z/f7cG7TD3e7OzFz/d50bTMQwXJG
 t7F5mEVM/wBT254CrcZHwHXfjjGdLjW54HP3evqBDX40Yghoqs5EPGbFb8IntQ7Gk/ZS+s0rowu
 UNiYdwozQuTY4raJKXkUrljzKaMI5A8YQAviMFTESAiTp6fHM2+4pUkqq8V8y+qbRSeLYjoF7SI
 Rfn3KPWg4NEPBAcNaKMW935BS4CsLwIadASy0e5njMK+u0lK8BKQxh3VO0XBhi4r3CIhUzTO6wC
 3d+rowRRNh76qIgnGL68R/8vMOrXDMCMSzxwrJtKZ9iURIULzVEeIGVibFkWNEYIdrK3ZuhwZ9c
 Sbc6+u8LFmE54vdPXqUmzIktFm1vuMJeh/uhLQWh7xpe31ni8debli1wZ/Kt3zovBGdkUCCiSH
X-Received: by 2002:a05:6000:228a:b0:436:38a4:2423 with SMTP id
 ffacd0b85a97d-439942a847dmr4056806f8f.22.1772061421559; 
 Wed, 25 Feb 2026 15:17:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970c00768sm35490761f8f.10.2026.02.25.15.17.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:17:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/70] target/sparc: Remove MonitorDef register entries
 available via gdbstub
Date: Thu, 26 Feb 2026 00:13:25 +0100
Message-ID: <20260225231411.96482-26-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
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

All these registers are already provided by via gdbstub parsed XML
and handler by the gdb_get_register() helper in the monitor/hmp.c
file. Remove as now unreachable code.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-18-philmd@linaro.org>
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


