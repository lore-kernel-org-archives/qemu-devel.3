Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBFBFF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcoK-00060M-HS; Wed, 06 May 2026 10:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcoG-0005pD-9a
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:01:08 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcoE-0000hY-HL
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:01:07 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso160381066b.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076064; x=1778680864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TIc9UfgUwKaCrlx/OZB1YgMDt8qDxahOFd4p2608LcQ=;
 b=iJ5ipC81os5P9rvwF7RMsSirENFm6Xmx/dJ/QvdLskWpkoV+G86GdIkpV0lhwG7+B2
 7QlE5Yjc67uz2a4cMRy/GUCQcGdACHSu9NcG6pgtLPS0/LQQTBAIx+36uz32ZYm8iNsl
 2wK/alUxYn4kKE9gwiUzqkOq2bCBSQEploCn1cv42k25l2u2V21STEthEhbbkLn5FYy5
 JijEyuEXb0X80/waARX8uuNEY3zojRtrUTjLQdLRJs2M0+4yFdL/1uYKoU3T4KkZNkOx
 f3nS/eLqVE4fYUn7UU4uq0+5fvd0FX9EpeZSlKzZArdweBFZpR5T+9DHqN0smIRB8eJf
 7djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076064; x=1778680864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TIc9UfgUwKaCrlx/OZB1YgMDt8qDxahOFd4p2608LcQ=;
 b=ksNaa9VuezrH6/lfb1jvgPG/D57UvRb4qFQU7j+nUl+hwd0i1U3O5aJis8wmDaMptT
 X6j9StcmddmtHJKrV0UNQ+FDWNUQsT6B5x8uV1mgL25xiwcrQPLJk+vM+IiSUgcXeEjA
 Fog7t4uAHUvJfWfshuG2dthEjWcBzS5pmNN3uhqkp1U0pNvwIEHxRNR9GH1AZ2b9IJjP
 jyCVCngYGhH1W5BNvfxvRJFTSCn+rMeqj6n0imXb0eURaxd3G+egjDfqg/X0/hD86ttn
 x3QbGhZ3SFy917NwmQMeZzPywBvtUYaj7Y04R0y9SRvHr4YwHU5PIPQA6qjUR6TqtA60
 n+Kw==
X-Gm-Message-State: AOJu0YxI5t5QZSUEfGcZ3/bAKPBHt820x3QYYu8kb4vTWnyTLzYss7J5
 16xhoeUroB0Wyl+jXxmF8f89OFwzjO33e3EfbnjDUDYSEFMaIl4o04oXQEHXRiemMJTNukmegNw
 HH14M+dQ=
X-Gm-Gg: AeBDiete7nbVhqY47iGmrRoFRytVTfvtSxNdofbi5zklHC7WaYZAReQfTEhsRHKYj9B
 goTwhzI9QC7vM+/2U7F/myM7mGdVBBcF8hNZIygeHRrkcWwDAQqa5t8IrbnQSJSIDRP+IjTdeTr
 UjOduVDDLbveX3Bbahb5xWm1AnT2Wu5WO5rbx55/uYAoT2YqXj0o+dKKN17RKgxyfhAD3CrUXkU
 vSt+9/OE5oTfzz2zcqwaXHbyfPQy9vcPZ7+1HA5sZDZT8XtDReN53QAegFOWmZMFeuwXa6XjoSC
 kge+mUhlxxJ/6HBwWLO3l14LiMuYVAbwu2pJhPLByM29cxEbALopkWVqB4lTwygRIKmII++3Pe2
 eCrmeopU8/S23ivaNGnORzDK2gplDkjdLJISt2RgQ6gYAY4OYM0cVTYTPJfpZP20TLmu2W/iEB8
 uZ2sxzWOcRjqFkCtnvjtxaN2QADA3K41RTsPIYHuo3Y5upMz8qnQKPak4vUDIfvIMHufB5CiqrS
 3N4O+wh/JE=
X-Received: by 2002:a17:907:7244:b0:bc3:a0aa:1a04 with SMTP id
 a640c23a62f3a-bc3cfd336camr485447966b.13.1778076063232; 
 Wed, 06 May 2026 07:01:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960fd6sm13483447f8f.31.2026.05.06.07.01.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:01:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 044/110] monitor: Make 'info via' a generic command
Date: Wed,  6 May 2026 15:54:16 +0200
Message-ID: <20260506135524.20617-45-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

In order to build hmp-commands-info.hx once we need to stop
using device target-specific check. Use the generic pattern
to make the command available on all targets, providing a
stub with kind error message when the device is not available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260427080738.77138-9-philmd@linaro.org>
---
 MAINTAINERS            |  2 +-
 hw/misc/mos6522-stub.c | 16 ++++++++++++++++
 hmp-commands-info.hx   |  2 --
 hw/misc/meson.build    |  1 +
 4 files changed, 18 insertions(+), 3 deletions(-)
 create mode 100644 hw/misc/mos6522-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f560853ea41..b05e4d2097e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1566,7 +1566,7 @@ F: hw/ppc/mac_newworld.c
 F: hw/pci-host/uninorth.c
 F: hw/pci-bridge/dec.[hc]
 F: hw/misc/macio/
-F: hw/misc/mos6522.c
+F: hw/misc/mos6522*.c
 F: hw/nvram/mac_nvram.c
 F: hw/ppc/fw_cfg.c
 F: hw/input/adb*
diff --git a/hw/misc/mos6522-stub.c b/hw/misc/mos6522-stub.c
new file mode 100644
index 00000000000..85eb0ee36ee
--- /dev/null
+++ b/hw/misc/mos6522-stub.c
@@ -0,0 +1,16 @@
+/*
+ * QEMU MOS6522 VIA stubs
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp.h"
+
+void hmp_info_via(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "MOS6522 VIA is not available in this QEMU\n");
+}
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 964eed004c0..0138c7ec4e7 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -878,7 +878,6 @@ SRST
     Show intel SGX information.
 ERST
 
-#if defined(CONFIG_MOS6522)
     {
         .name         = "via",
         .args_type    = "",
@@ -886,7 +885,6 @@ ERST
         .help         = "show guest mos6522 VIA devices",
         .cmd          = hmp_info_via,
     },
-#endif
 
 SRST
   ``info via``
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index cd084a19363..fa6a961ac9a 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -20,6 +20,7 @@ system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 
 # Mac devices
 system_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
+stub_ss.add(files('mos6522-stub.c'))
 system_ss.add(when: 'CONFIG_DJMEMC', if_true: files('djmemc.c'))
 system_ss.add(when: 'CONFIG_IOSB', if_true: files('iosb.c'))
 
-- 
2.53.0


