Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6736CFA1FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdjY-0005ZY-RG; Wed, 22 Apr 2026 15:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdih-0005FC-K9
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:58:50 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdig-0000Jm-1r
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:58:47 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43fea39e066so4755682f8f.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776887924; x=1777492724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KPL9mAoAtYsT0he0lYtVqoN6j9yoWpEy+6N/BBY9Ams=;
 b=GkFEizMmeAk/83EQO9PA6+MH3fcM0+Chox0i1ISZTLWgRrWS1O/OXjuZWOt7DPEJi8
 bs63wJ/1h2gXhNNmxwQJdJ05Vykv/rWEdYS6QNiI0MHHA24mxY+brwcSWllwwwZaYgh1
 njsT1TRtz8YwUl1UaMK5EZHJq1N0y7zy9xVuf1V8K/NLSOSjjykvJYO2IWQhJILrBOrN
 komWhWeAuP8A6HFTpg0wjrexcIC5bCQsmhbiaKwP1PawZmOpNFvyW2I7Y9SP0kMOgoHs
 givHO0QOT1TtjzT93n+fBEukrPxq3VLVq0Gy4UfJRcIcScmBw02qQ1tgBUkpdLbe1WwC
 53OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887924; x=1777492724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KPL9mAoAtYsT0he0lYtVqoN6j9yoWpEy+6N/BBY9Ams=;
 b=QDD61QEXcqiO/JQwW68E4icFVPzPEaiXrx04gI4Gq+RNUxbB2rl8SFrqsB7mW1dMql
 54R+wdgc5MrAOm+KHCROxgIWeQqZRje+TfP5WyRYGqh3WQTXM1KNG/9oG0QGPf3ZFPfP
 sL3HeSkehXkSq47WTJpkCZ22HdvNyktkybO9o0LITQvzYC6UxFQJ0Q8ShQ3nx4dy+vZd
 x7tgS3WgBD4hJlJZy8PPQVZFxW3hFGLJWXhydrwKUz0QIwt6VwPc8fZEdTh1B1+ZrXVz
 gotb6E4TZeWukrKiR3kB+OZN8WRjRCxeD1lFmGKfgKrFzp98gVxMXLyqBPXJfsc8oRP/
 lZIg==
X-Gm-Message-State: AOJu0YwEU21Vx1TMFSFUsZTGzcTDyZsfhTZDuL+cZbPOpkMmxrfQV1Ub
 hl42wfavRwqDdbqAswlkXAOs9ut7Cy3tRPCXwi3bffIhPn1fIM7WWne25/SvgbVA88u+Xcr/L8i
 I/LWnWtU=
X-Gm-Gg: AeBDievMSMsoya7OG2p7XcJcoDdD0hTmtZe5RAC2dXDK4X5t48CsAxseE+TX4wrrE5L
 6A6BxY1rp1/u0ugSzkodm6YAkpHxZTV903O+yuDP2CuYG5EOpWQrdYlqjEFC0fHRgTNGuG/tlFL
 TukWeZ0LqPHCgi37bTu3p2roCNQ+vC/3BZ3Cj2ioZXs7zzqYDBvydtNEJ/fxgkL1xtVaE7+p0LI
 clYbEbHf2UT5Xa6yjTSoVS6WCtND866VO/Pi1JNJI9Jw9cJUQ9IBBKirgkRK7+UG1h4+kVGuLQo
 t4PJDG377XNRJCrdpEsq/01g31sYh+9nnhz/GPiz8253+hErSmrEL90r42eYzvGVPgM9H21D8ir
 mVZj4PCmi4bNspXIFlr/mfzHcpZQuyWKZLeaTETqKerFC4xFfoXhH+wFRfddw+6Mcl9sKAssvjL
 yAtCTxJEhjHpSrRaZjRhm0W+AAY2xbpBZPGRC0RscfyFE6xOPa5TvVpareEaD7hfiIJjzxjhKuh
 32R3tdh0/0=
X-Received: by 2002:a05:6000:22ca:b0:43d:50c:6f33 with SMTP id
 ffacd0b85a97d-43fe3e0bde7mr37515966f8f.26.1776887924168; 
 Wed, 22 Apr 2026 12:58:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d525sm45605486f8f.31.2026.04.22.12.58.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 12:58:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/48] hw/m68k: Include full path to target 'cpu.h' header
Date: Wed, 22 Apr 2026 21:57:06 +0200
Message-ID: <20260422195746.88865-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-26-philmd@linaro.org>
---
 hw/intc/m68k_irqc.c | 2 +-
 hw/m68k/an5206.c    | 2 +-
 hw/m68k/mcf5206.c   | 2 +-
 hw/m68k/mcf5208.c   | 2 +-
 hw/m68k/mcf_intc.c  | 2 +-
 hw/m68k/q800-glue.c | 2 +-
 hw/m68k/q800.c      | 2 +-
 hw/m68k/virt.c      | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index c652bf143f0..68ddb5351be 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/m68k/cpu.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/nmi.h"
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index f92a5d6a339..1acd2fbdfb3 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/m68k/cpu.h"
 #include "hw/m68k/mcf.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index c5befa02eb5..9f373b99b12 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
-#include "cpu.h"
+#include "target/m68k/cpu.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 0e07aa45e9d..a8068c91f24 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -20,7 +20,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "qemu/datadir.h"
-#include "cpu.h"
+#include "target/m68k/cpu.h"
 #include "hw/core/irq.h"
 #include "hw/m68k/mcf.h"
 #include "hw/m68k/mcf_fec.h"
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index 1014fe6fa57..e8d3bd937de 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -10,7 +10,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
-#include "cpu.h"
+#include "target/m68k/cpu.h"
 #include "hw/core/irq.h"
 #include "hw/core/sysbus.h"
 #include "hw/m68k/mcf.h"
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index 24fccab9666..ac9062c6488 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -21,7 +21,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/m68k/cpu.h"
 #include "hw/m68k/q800-glue.h"
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index c0d78eb7d71..ab64250c47c 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -26,7 +26,7 @@
 #include "qemu/guest-random.h"
 #include "exec/target_page.h"
 #include "system/system.h"
-#include "cpu.h"
+#include "target/m68k/cpu.h"
 #include "hw/core/boards.h"
 #include "hw/core/or-irq.h"
 #include "elf.h"
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index ffe6e234155..cf8ebd65e30 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -12,7 +12,7 @@
 #include "qemu/guest-random.h"
 #include "exec/target_page.h"
 #include "system/system.h"
-#include "cpu.h"
+#include "target/m68k/cpu.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "elf.h"
-- 
2.53.0


