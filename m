Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A84CC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqRG-0004WW-VI; Thu, 22 Jan 2026 03:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqRF-0004WB-To
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:53:13 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqRE-0005oR-EZ
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:53:13 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so5229025e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769071990; x=1769676790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bo35Dd0AhLNc2UVgpDKnkNtO0kfipxtX6eZZir4zmO8=;
 b=HIUU8ls8IVPJsfZOHNDzE8zF4CSnDy5R35Al/vh8d2f7I2406DEuXGGz6i8/E/LBaJ
 UFydDDhkjxNcFegxZwhABsXDxQ51Evl5kSaG6CjLRckkHURz8bO3yChDsuOe40K4dFdB
 mRk7+3uVqBC8N9AnBMyTN98xOXbc4HyAsJZsqGknxRsl0IMHSn1Q6E0KM7Sh4Iw8XzHT
 QaUhXXB5ZyYSBGQ5S/fjeSslP9is0wZZC7wZMgvHjAH9ICTfIHguetk8zzlLc1EVEJZO
 SbCTCttu9Tv+5oVLP4+3iRegLoaleBxkIppWbqgOM0XXsRAZzU37Klbc14lC6J1grwAq
 +qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769071990; x=1769676790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bo35Dd0AhLNc2UVgpDKnkNtO0kfipxtX6eZZir4zmO8=;
 b=n4LvwA3zT1BBLR9H3OcgjSvoSwNPYD1XlFXEEcRGXEJvBhVAuY2QOGrmCgYkSwA7E7
 pqmo3zXL2KgOCgM0tNqdNXzZN6UPHn569j8Aa3jKTUck03H04PKDUDhKsc+bNT9A4MYi
 QN41tuGKC9p1AhrB9UDLykXIXVhhiO7La4h5+ZU/NjLEDnL8O3Ka7ONVfembRewT0hAR
 MObFbMzBEyDylOJpSs6x9CWlLpXmwKng2JkB8/F3XWAcs2OMOMeRZP+nppXfxJJHejI+
 SdOUDGN6dFz6kkRnsNGiNiprfA8j1RS2FY2/a7aet2QSNd/VPHoKSRtttvqHjIYwg2U4
 aVmw==
X-Gm-Message-State: AOJu0YxFPsM4V0WpCZJMbjGuoaPxSlaI9GaVN9yH3k+gzMDq9P5mzbzT
 tqsQX3w43vN3BnD44XWTJHZPjvivbIr1jKpzO3cfoZcIQabg263hmY29rSNtGnRAatbwJgOVcel
 EFkwj3iY=
X-Gm-Gg: AZuq6aLRt2NQJvHGNm5G/foWvSQzFs2xcnSz//GsoJOh3WspE2ydOw8Wtn/eVlHBxIl
 xcQcmirlU4o98VPichQhZUd0fZO5E89JY0oDQTz6IRCH/aa7smqFpdWhy33+6qmE5xyW5mMynYL
 y/dBiyN9LoTnFL0o0bcw22GSFDgCyU8dIM4LUxdmhbMyJ/R2pl3zp3RjNDbT3C1AwtKu47XiJzy
 aQAhThpqNcY0YVSgJD3rf+dF5S6LcFnxFsazq4ZHmHK2RDL/KCvEgq+zL5hdJQ5iSRwYau9M/39
 yhsY0kOYAMJS0lNW9CeJgCiDde2CQmkIwW4JL8sh2lyZ4dP3bS4zEJZxsq0VRa4VIojcnOfPwrS
 ypzwtgDnx4J4kZgf+NAXcMPYrpLVsz/MfxkEWPd9urStk+fwIKz638nKqGDEdzTHdhL1EqfOJpl
 prSi1NfmO1SUTmAbZd4m0/Bl9LwQ+wcUuYGaG4dA9rq9aQn/8TkhOyd9fznAEU
X-Received: by 2002:a05:600c:3509:b0:47a:94fc:d057 with SMTP id
 5b1f17b1804b1-4801eab54e2mr245091055e9.2.1769071990310; 
 Thu, 22 Jan 2026 00:53:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48046fba46dsm51433645e9.0.2026.01.22.00.53.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:53:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/31] bswap: Use 'qemu/bswap.h' instead of 'qemu/host-utils.h'
Date: Thu, 22 Jan 2026 09:52:25 +0100
Message-ID: <20260122085255.95035-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

These files only require "qemu/bswap.h", not "qemu/host-utils.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109163730.57087-2-philmd@linaro.org>
---
 tests/qtest/ahci-test.c              | 2 +-
 tests/qtest/libqos/ahci.c            | 2 +-
 tests/qtest/libqos/generic-pcihost.c | 2 +-
 tests/qtest/libqos/pci-spapr.c       | 2 +-
 util/hbitmap.c                       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index e8aabfc13f5..5c32ff20029 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -31,7 +31,7 @@
 #include "libqos/pci-pc.h"
 
 #include "qobject/qdict.h"
-#include "qemu/host-utils.h"
+#include "qemu/bswap.h"
 
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/pci_regs.h"
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 34a75b7f43b..0621a6c4775 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -28,7 +28,7 @@
 #include "ahci.h"
 #include "pci-pc.h"
 
-#include "qemu/host-utils.h"
+#include "qemu/bswap.h"
 
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/pci_regs.h"
diff --git a/tests/qtest/libqos/generic-pcihost.c b/tests/qtest/libqos/generic-pcihost.c
index 4bbeb5ff508..b77617524ca 100644
--- a/tests/qtest/libqos/generic-pcihost.c
+++ b/tests/qtest/libqos/generic-pcihost.c
@@ -15,7 +15,7 @@
 #include "generic-pcihost.h"
 #include "qobject/qdict.h"
 #include "hw/pci/pci_regs.h"
-#include "qemu/host-utils.h"
+#include "qemu/bswap.h"
 
 #include "qemu/module.h"
 
diff --git a/tests/qtest/libqos/pci-spapr.c b/tests/qtest/libqos/pci-spapr.c
index 0f1023e4a73..3723cbb38db 100644
--- a/tests/qtest/libqos/pci-spapr.c
+++ b/tests/qtest/libqos/pci-spapr.c
@@ -13,7 +13,7 @@
 
 #include "hw/pci/pci_regs.h"
 
-#include "qemu/host-utils.h"
+#include "qemu/bswap.h"
 #include "qemu/module.h"
 
 /*
diff --git a/util/hbitmap.c b/util/hbitmap.c
index d9a1dabc630..3525bf7751a 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -10,8 +10,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "qemu/hbitmap.h"
-#include "qemu/host-utils.h"
 #include "trace.h"
 #include "crypto/hash.h"
 
-- 
2.52.0


