Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F74FD45FB
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO87-0001QT-Um; Wed, 25 Feb 2026 18:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO86-0001CG-2J
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:17:18 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO84-0002w4-E0
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:17:17 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so10318805e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061434; x=1772666234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AdFtKGIsopBDFUGdtCFLNJHYH+Edql8ZEfYb6+rWKQ8=;
 b=K3UPUH/2IBU3FUiMXH8UFT9ypAEk6K/t7sOZiY5Cl74VzrjciZzWWZG9YTRb/f3Ejc
 8r5HfGEww1SpX8ddVFcjPobCs8OPv6tyoYl6P7iFgwR5vUZvqY7khUcxRNhVSpNCx0X0
 URyzLOaPnLmAUS4lZYfXeAR3dgwqfIcFwetZW9udnKQEBDgMjjNARKUZpGKAtMRS6wVc
 ioO2YyuR+g31dG5E76r1OjnW8h/aTxYOFh4ZJZ+T7cPUapGccWXXigdZXPSSuVwMUcA/
 czQdoEEtQmSWQ7XwNV8WagQuWqPlAGXcVr6r/omZLT0QkvwX8Tlenel4UQ1yWEshbcTR
 Yfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061434; x=1772666234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AdFtKGIsopBDFUGdtCFLNJHYH+Edql8ZEfYb6+rWKQ8=;
 b=RO1zBr53DzeJPVpJHtVg/lXl7AMh16BQ5V0kjhGBlCoyRHYK1g2hl5SN93VqjTr6dT
 nsg3Gv49+rU1Mnl4HCdHXj9FX/9NaFrg4HjQ0oiguWpdz1VjcXH8ELKH0+LiuZP8pRGw
 QhhcOOk7yWu6Po/MLF+hDeG3Od/7+H0GSZynF35b1BNnQC0+yWfkY28caJiygyOj7F0a
 6WXQT4aWebmGnFhH/c38Td+TxoYGX9zpEQ9FFbTmxGZflF4ipF5uqbGLr7vwgyFFSF8V
 vaSDY3jBuKd1tq/IkYVHvVS9Y8AP03/M9amkQqMH4h8BrWugPZORnb62VLIIpGtfZrB6
 JEeQ==
X-Gm-Message-State: AOJu0Yw4NRv+LlizCXUpyvZ801maLX/PeleWhSWPi1/v+fG/wGPQTcaw
 aztsMBa3Uc4ExSiZsv0s0CAvNWbG6+IRsr8KrM9CUaG0yCQsAc9TTddUTTjzLmtrl7pM61joYWa
 9uBDU3vY=
X-Gm-Gg: ATEYQzxepK0b9PgpicxgQrMA4FggiMET77HGITixIJ8rJH2vI4m1QA1K9Hv4veKIGJu
 pgQzwv9PF3GLNEakoosKudS0WDjTK3PUMK2JL2OMSl5qNcdnUXbSK7orVyukl3vJjIZTMKcwJC7
 h3mJy9u+dVvcYvGLqcTV0poPOv1kEwLdvS/xpmxDaubFYOPjDVdWwf9auRGxbkwEHVqN8XKRrgL
 rDemxNbKa5FUPA3pA/lIzIhhLos0qhrY39P1d+BfQn96rCgQnHW462C/IBFRgNBHrnbhh9qJKiS
 DTXsHePjjpDfBwfbtEn2O0w28WF4z3E1g9bu/slnpV3TVgTs/7OzZmh6NfLKFHLLaAADSYv6ouH
 lT64aMN7y7S04JPvksWdWQmStXxL7qvxVUMF5e0m/DXKOPYTyJcYM3Z5EgKc+qrKU61TzgaxkD+
 4ef5eX5+xbVqWiNuTTtVs2SZnfebe5MWnmGWOCI8I+FvLONr+nTVz98ur3nuZxL7us0PVqjtzK
X-Received: by 2002:a05:600c:8b71:b0:483:7ea3:3de3 with SMTP id
 5b1f17b1804b1-483c33c3606mr14441025e9.2.1772061434536; 
 Wed, 25 Feb 2026 15:17:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcd0818sm20942465e9.26.2026.02.25.15.17.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:17:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/70] target/m68k: Remove MonitorDef register entries
 available via gdbstub
Date: Thu, 26 Feb 2026 00:13:27 +0100
Message-ID: <20260225231411.96482-28-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
Message-ID: <20260219191955.83815-20-philmd@linaro.org>
---
 target/m68k/monitor.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 6d101c75df0..08ced037b47 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -24,24 +24,6 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 }
 
 static const MonitorDef monitor_defs[] = {
-    { "d0", offsetof(CPUM68KState, dregs[0]), NULL, MD_I32 },
-    { "d1", offsetof(CPUM68KState, dregs[1]), NULL, MD_I32 },
-    { "d2", offsetof(CPUM68KState, dregs[2]), NULL, MD_I32 },
-    { "d3", offsetof(CPUM68KState, dregs[3]), NULL, MD_I32 },
-    { "d4", offsetof(CPUM68KState, dregs[4]), NULL, MD_I32 },
-    { "d5", offsetof(CPUM68KState, dregs[5]), NULL, MD_I32 },
-    { "d6", offsetof(CPUM68KState, dregs[6]), NULL, MD_I32 },
-    { "d7", offsetof(CPUM68KState, dregs[7]), NULL, MD_I32 },
-    { "a0", offsetof(CPUM68KState, aregs[0]), NULL, MD_I32 },
-    { "a1", offsetof(CPUM68KState, aregs[1]), NULL, MD_I32 },
-    { "a2", offsetof(CPUM68KState, aregs[2]), NULL, MD_I32 },
-    { "a3", offsetof(CPUM68KState, aregs[3]), NULL, MD_I32 },
-    { "a4", offsetof(CPUM68KState, aregs[4]), NULL, MD_I32 },
-    { "a5", offsetof(CPUM68KState, aregs[5]), NULL, MD_I32 },
-    { "a6", offsetof(CPUM68KState, aregs[6]), NULL, MD_I32 },
-    { "a7", offsetof(CPUM68KState, aregs[7]), NULL, MD_I32 },
-    { "pc", offsetof(CPUM68KState, pc), NULL, MD_I32 },
-    { "sr", offsetof(CPUM68KState, sr), NULL, MD_I32 },
     { "ssp", offsetof(CPUM68KState, sp[0]), NULL, MD_I32 },
     { "usp", offsetof(CPUM68KState, sp[1]), NULL, MD_I32 },
     { "isp", offsetof(CPUM68KState, sp[2]), NULL, MD_I32 },
-- 
2.52.0


