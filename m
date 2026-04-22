Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129DFFA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 19:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdjb-0005c1-6M; Wed, 22 Apr 2026 15:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdic-0005Eo-A3
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:58:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdia-0000Is-FO
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:58:42 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso61219185e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776887918; x=1777492718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bDeVhZrbeVrjdrG26Beki+idideGEh/ioT8HxGndim8=;
 b=Xb5Q68yTM1oIYdx50wGqxC2sDYAxgjkBrl+bjEag0FYg42CDxA3ExjW5ktgyCMbwWg
 MDroRIVNQiEEwuEel/eN3hNMe4OSKT5lwH/Eue3lR3XWDx0lcUeRuT0Bi+bbLQdoD98o
 qUnjyyM7XC5lSIJi5/iwZWVyw1p/s2/CanTKSGvFrJ0nvMGbrZlcV3ihUUfElSLRF/RQ
 sS+8LZbxrJ2g9sba1G0ggX/gyo1Hv+h7vn/9jSRgKKj8NVl/SaZFKiC1bE7xsZ7j+ePf
 f60wFjQ3RQwbEc5R3icz9qewbJQrIOIekfzP1AEWzRKZe/VJijJBwC45cTBgdJ6wxhKW
 0rXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887918; x=1777492718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bDeVhZrbeVrjdrG26Beki+idideGEh/ioT8HxGndim8=;
 b=Fgsen66g/LLjrUsGlsaYiag59xo6bqQK/730Fv1dTmSBcCermzyCvFSiy7Fo4idPM2
 ohBm9y6BEUfVzXdBMMt5xskKK7bNSLdet+BIWXwuWCL39VcODyd+4hHO+pYC/3WdnrLo
 4qR5iA9EAl47EVQWam4iVoE8j6dvMHhL9ezPuKGpx9vR/xjcL//mdy1GTV6sy5ShsGfq
 NszA59G8aEqXN3wJqetO9DlaIy8UjQM7Zk4BWKSiccc2ll5ySx6Q7O6KKEhdakeE5dom
 HV49Np0o4OFd1T3W9t3mb6W1H1iit+fRGI4sy4xVHYziQZq9OmqY/BBTpBUOo/x4wENG
 bEZg==
X-Gm-Message-State: AOJu0Yyyl6PVu5Kntncyzn5jVSCxYvxj8EibTSqxOjrnnMDfD+FLV9W9
 /u2W4/+xuVK2Ot3U9tSfHZ8AvLOYbLJxNKsf4zK6V0OX5APyJ2lZTD3zx9zDN6JCWM5985U+SIw
 PsSxT/v4=
X-Gm-Gg: AeBDiesODFpfYeCeTikb8OWZhsbi9NxNLhetlS7zEtmjl+G4r3m+O/h4FdWZsuRfuTm
 qIeHfNzk1MJ58aPbQyJBYlahPBDmCqbmyc2ou1MB6R7obqd+NKXo4EqulkTe+lo3mH3DZ8SawWB
 bVQ73/gFGWiWZ/oVn/IA5UqJ+J7mxsjus0Iutv92LyBjL5FmTYvZgfrM9tGN//ozPaxI4aZPKGe
 xMA5OmWVK0ynC4Yrez2i+pyadGjqxYcQTP/j3iM69LYtq5yxiru8/G6ouf/RANS3kYWULkKrZUa
 uxLwTJnmoXqvXOgsynSDUd71mw9Gm2iGlDV2V4QIjYTWD3NVPdeJUc/Z4b92qXfD3JhlHtF64uA
 CgDI41T2C7QB3bd/BIqIvG9SVd2JI/aclTGglY5HtpROT2PNiJi9XyubYNEU4+R+5JxIZoS5SD/
 mnqWwQhXuxqDrA5UEz6fPgAHbLRAZWY4E3622Im1tDOwm267OwhiLvhDudJNx4HCW/ZtsVhI8DS
 QPpGHs7tNc=
X-Received: by 2002:a05:600c:b96:b0:48a:5339:a46 with SMTP id
 5b1f17b1804b1-48a53390f6cmr145563445e9.9.1776887917476; 
 Wed, 22 Apr 2026 12:58:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc17f642sm427217315e9.5.2026.04.22.12.58.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 12:58:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/48] hw/i386: Include full path to target 'cpu.h' header
Date: Wed, 22 Apr 2026 21:57:05 +0200
Message-ID: <20260422195746.88865-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-25-philmd@linaro.org>
---
 include/hw/i386/apic_internal.h | 2 +-
 hw/i386/multiboot.c             | 2 +-
 hw/i386/pc_sysfw_ovmf.c         | 2 +-
 hw/i386/vmmouse.c               | 2 +-
 hw/isa/lpc_ich9.c               | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 0cb06bbc76c..a26d53bb9d9 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -21,7 +21,7 @@
 #ifndef QEMU_APIC_INTERNAL_H
 #define QEMU_APIC_INTERNAL_H
 
-#include "cpu.h"
+#include "target/i386/cpu.h"
 #include "hw/i386/apic.h"
 #include "system/memory.h"
 #include "qemu/timer.h"
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 0e960a15dda..d544b62afbd 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/option.h"
-#include "cpu.h"
+#include "target/i386/cpu.h"
 #include "hw/nvram/fw_cfg.h"
 #include "multiboot.h"
 #include "hw/core/loader.h"
diff --git a/hw/i386/pc_sysfw_ovmf.c b/hw/i386/pc_sysfw_ovmf.c
index 2f7d15c9f3e..822c611710e 100644
--- a/hw/i386/pc_sysfw_ovmf.c
+++ b/hw/i386/pc_sysfw_ovmf.c
@@ -27,7 +27,7 @@
 #include "qemu/error-report.h"
 #include "hw/i386/pc.h"
 #include "exec/target_page.h"
-#include "cpu.h"
+#include "target/i386/cpu.h"
 #include "target/i386/sev.h"
 #include "kvm/tdx.h"
 
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index c1aeeca0c9a..20ebb0dbbf6 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -29,7 +29,7 @@
 #include "hw/input/i8042.h"
 #include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
-#include "cpu.h"
+#include "target/i386/cpu.h"
 #include "qom/object.h"
 
 #include "trace.h"
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 51dc680029d..9cec18a378c 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -30,7 +30,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "cpu.h"
+#include "target/i386/cpu.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/range.h"
-- 
2.53.0


