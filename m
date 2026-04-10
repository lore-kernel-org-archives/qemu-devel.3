Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AA4F45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHwt-0003XN-O5; Fri, 10 Apr 2026 15:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHws-0003Q8-Aa
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:55:26 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHwp-0002Go-BV
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:55:25 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488c2690057so23816625e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850921; x=1776455721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7DYNcbBqYRxENhIeovRDLogIedruZzNw+qepAaR4ak=;
 b=Id3b9VX4uOXPzOej/emz/IrY9x5unFfcDQza2aKuaP4vSBqReIR/nmH8yG1bTZxt6B
 kJ0mMFbX4AC4RNbn3yUc4pKJp8S1BkpJMUacLq0J4u7I8v3/rOGjQUGZS5vrntOPuLT7
 YQEJ0q1XUo7mM/yyY0+szNeFIA3sMfqkcYVw3oI2cjDWyMMzYGx/C5c4tFeq1ZJBzIF6
 alnYhgYSDiYuq2DIAUWEfKKVLJto9pEGqEfUK19+j6C+vyan38Iembuh40+kQEvO2BmS
 w+FkTWK7Jp/vjb1Wp7zwVkb2rirDpZPvoDuU2iCjLW+qINTKjqtFjtEz++bSmYQlSeYc
 hUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850921; x=1776455721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P7DYNcbBqYRxENhIeovRDLogIedruZzNw+qepAaR4ak=;
 b=qxlc9MjF+c2BMP5S8UeV6XnhfmwWPAWIBVlB8lUTqQ3TaHlWNKxG59N0A6ao4P4tEC
 AcbRkWN59pUZvyIQxhnNpGqPyGV1j1W8eaztJ3UtKHHEq8PKUfUB2rBYzfO2WG0V+OWR
 09HE6Fwv1eF9RWNobzcgRWFTtM9XVycYxmtbourNsRupROnW7rwQENdhNalVV/hjjW9p
 +qwo3jT8TbRjcWtZhwrqrK7MlRpfNNyOELwapDhCEG8TOD+BbKHl8XzkFaw7zsYshnvh
 67hmszm9OraVGDgMEs08I/iXfOwiCgYuuVmaWM4DBsw5X74I6So9b+rY0sWZxAh9Vu8F
 IY9A==
X-Gm-Message-State: AOJu0YyVzB50LROFoKsIqV6gVQtXF81z1fDmhKyG7ajpx9N7I3IUscQZ
 sorX/b6kzNwYNB7JF25DGXuNtrMkoMwrL35QaC2J006MvCm7kY+i4rr3yHs4sXwQ3kKxB7rtp6Z
 c+gAuti4=
X-Gm-Gg: AeBDieuKkO0Xer1IeGznE1J55jTnxvRi8j6c7brbRMLne7MW2FB8GpY8V3eQMnYl+Iv
 YcUK390ZfmspBp8j+rh+iUPf+PF7sJLETY89e+mmokwx7m8bhYBgT3EUC7Fyj7CudX6r3W49Swv
 IUgkNH5kZh1iwdbJh2Ad65K1+5kAii+wBbQhTjnYLTHkKFwxLMkQMuawcMf3MuKcDtcmY5sIHtU
 7HK6VqFH0vwGnLean876LIycioccJz9D4PJUkqiDT1pcvleP7qUlI8UuYbpR9NNebR4yKAtpcpO
 qRrQaQCU94UYNcCjhfmSClNrHz5A1J/ydugywPpuD36Xi8AApscJ0BJqbSDTN9kCtTMzaK3sZPW
 vHCIKkSdxdQNCvO9fFya/ujj1kaR22G/K6+VZe120tk1hcGGQ7hIbg+Nk7OrXPLIrc8RWC9cuvS
 zQo4WUvFPlKdKyRkj3qa3bnhYWRAPRWXCCOYU/37mDMAmN1wICrUQgy6+ipr09+WHn2sjWUWIRd
 28R0Tlx+38=
X-Received: by 2002:a05:600c:4e4d:b0:485:3193:6ddb with SMTP id
 5b1f17b1804b1-488d6808507mr60392295e9.3.1775850921143; 
 Fri, 10 Apr 2026 12:55:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5d80bafsm29705155e9.5.2026.04.10.12.55.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:55:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v2 16/27] monitor: Make 'info via' a generic command
Date: Fri, 10 Apr 2026 21:53:10 +0200
Message-ID: <20260410195323.17937-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

In order to build hmp-commands-info.hx once we need to stop
using device target-specific check. Use the generic pattern
to make the command available on all targets, providing a
stub with kind error message when the device is not available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS            |  2 +-
 hw/misc/mos6522-stub.c | 16 ++++++++++++++++
 hmp-commands-info.hx   |  2 --
 hw/misc/meson.build    |  1 +
 4 files changed, 18 insertions(+), 3 deletions(-)
 create mode 100644 hw/misc/mos6522-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 932d6aee507..1810625eb1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1558,7 +1558,7 @@ F: hw/ppc/mac_newworld.c
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
index 74c741f80e2..463038c302a 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -885,7 +885,6 @@ SRST
     Show intel SGX information.
 ERST
 
-#if defined(CONFIG_MOS6522)
     {
         .name         = "via",
         .args_type    = "",
@@ -893,7 +892,6 @@ ERST
         .help         = "show guest mos6522 VIA devices",
         .cmd          = hmp_info_via,
     },
-#endif
 
 SRST
   ``info via``
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 245ab9b98cc..d7e97a4a32f 100644
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


