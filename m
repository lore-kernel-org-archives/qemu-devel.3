Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880FE1093192
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3VsI-0006yT-H8; Fri, 20 Mar 2026 05:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3VsH-0006yF-7z
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:10:33 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3VsF-0003eN-CN
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:10:32 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso13790745e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 02:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773997829; x=1774602629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sv98Vp0Ut573GNvv6G17UiqXbw0gx4JbJhCfFG3N2Hs=;
 b=Nxt2857pKfEO5wVZu9fgvFw/DxLFq83ynMyp+eBL4jsRZfstT8JEjaHPHwQ87yOA85
 8E/Rwc7kTUaUPh1axqmO3swqT15hZYtm67TfyCETcrEP9XEOs7LhKc1hq7NGT5PkxOuM
 yvB+qsFW/ygEjTbEBObXp0ScSwHRz1Pv7EGvyY94j1Ky7zBYci6i8ppzWJdokimzFd+l
 2IVmZxfs+zjwnE1jKQGduyqfXieTUwCjtjFqbCtorkwFFC3PltATju6iyOebPsZPXhDb
 4rnwT9cDVF79XpHHXuPGFU2/Q+kS7gT/yHRo3rudZOUrXtPHZciNxpanl3PITuuoG6ip
 TBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773997829; x=1774602629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sv98Vp0Ut573GNvv6G17UiqXbw0gx4JbJhCfFG3N2Hs=;
 b=ssWy0DYUx3BRj8+29KMC6eUfcWl2el4al7ZniYALMYLkS2DIJjdAA++zVWF5jCA74W
 QHwxechb9QREPnkZDy6pbthQ81Gm6MTaXTTtohqcaefO+C8EqthRy2lPvWA4zPINLhRY
 s7yv2WrTTxmoRONk/khVkJGhE743gAwY25maaPX54vJyz7nQobNbWdYENnF+ndVg7lm7
 lrewyKCcMmXhj3g05Fd2z5nHkD2Uv00YPTRiz5b9S0NFR4yNvlOVS/V8Np6CqeiuoTrT
 cWO8hP7R+YeXUPcVaPN463Rv1G1ZznGQq/yEb4+ZFQ5C+Zv0ew3DDj65oAZ37wr1o/S6
 em+g==
X-Gm-Message-State: AOJu0YwB5UamQoNTwKe7JB+ocr2uimwoF95G7YkC99kEV8q4SlnAq6/7
 aaPtTFBKCFc6UDHcpiigpuwW8V6gzHda/EEr7yyXyR3Dtru7zhA3vf+9akvVdiT+6D4P2V8yl0/
 s79xzfGk=
X-Gm-Gg: ATEYQzw1dQ7M/3R4EaoyYvgCvv5Wn0f5PCleyKwnVF7LjunOdJsMcLOOI1+EKgDzwcD
 5Zeg+s9WmjRD9uENuFiwWjkmTF8+YQ2D0HZ2nJAAh2ec4K4VkqJIvZ1QJqmrX1mHwYgzlFL4arF
 1rRH75YnmPNwjq+yAIGKBP2++ZtRWHwIE50M4dd9DdBWzGIDxJpPUNlKi2jzZhzadQBop5QpVQr
 VtZP6cOOQ+ofQ6bF/8RVPA7bWmuH01rTZzagOatLHBFRg8K0bIp7z3BbSzm77py18RSJHhHS40p
 XEC+GRwMg0f3/wkBNhkgXgrcnAopXQTdjz6C0mlCXbUwOSqS3558Dhs13/4QTmWYgaSVd2O3jq+
 O0IBaAnoGVnG0WsE7DUFAz3qkiF7/xnrj2mxnOx1U9doV8XJr0Jt7RENrmusfUxg2z/WZ1cUlak
 W6ZLJcS4bunWdZS31ET9loMIZ6p/gP/cov678vDGttNKy3V+NTBq6lyJ5SVwuRecVpqEnoghfR
X-Received: by 2002:a05:600c:528e:b0:485:3fe6:2209 with SMTP id
 5b1f17b1804b1-486fedb2f72mr30276945e9.11.1773997828776; 
 Fri, 20 Mar 2026 02:10:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe6d91fbsm47001445e9.3.2026.03.20.02.10.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 02:10:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 v6 1/6] target/sparc/monitor: Dump all registers as
 32-bit
Date: Fri, 20 Mar 2026 10:10:13 +0100
Message-ID: <20260320091019.59902-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320091019.59902-1-philmd@linaro.org>
References: <20260320091019.59902-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

All these SPARC64 registers are 32-bit since their introduction
in commit 3475187dd81 ("sparc64 merge"), see target/sparc/cpu.h:

  511 #if defined(TARGET_SPARC64)
  ...
  515     uint32_t asi;
  516     uint32_t pstate;
  ...
  519     uint32_t cansave, canrestore, otherwin, wstate, cleanwin;

Set MonitorDef::type to MD_I32 to dump them as 32-bit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/monitor.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index a60671a60a4..e9300ded4ad 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -41,13 +41,13 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 
 const MonitorDef monitor_defs[] = {
 #ifdef TARGET_SPARC64
-    { "asi", offsetof(CPUSPARCState, asi) },
-    { "pstate", offsetof(CPUSPARCState, pstate) },
-    { "cansave", offsetof(CPUSPARCState, cansave) },
-    { "canrestore", offsetof(CPUSPARCState, canrestore) },
-    { "otherwin", offsetof(CPUSPARCState, otherwin) },
-    { "wstate", offsetof(CPUSPARCState, wstate) },
-    { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
+    { "asi", offsetof(CPUSPARCState, asi), NULL, MD_I32 },
+    { "pstate", offsetof(CPUSPARCState, pstate), NULL, MD_I32 },
+    { "cansave", offsetof(CPUSPARCState, cansave), NULL, MD_I32 },
+    { "canrestore", offsetof(CPUSPARCState, canrestore), NULL, MD_I32 },
+    { "otherwin", offsetof(CPUSPARCState, otherwin), NULL, MD_I32 },
+    { "wstate", offsetof(CPUSPARCState, wstate), NULL, MD_I32 },
+    { "cleanwin", offsetof(CPUSPARCState, cleanwin), NULL, MD_I32 },
 #endif
     { NULL },
 };
-- 
2.53.0


