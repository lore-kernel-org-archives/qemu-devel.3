Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39685C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 19:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhYYb-0005DH-UI; Sun, 18 Jan 2026 14:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYYa-0005B1-9R
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:35:28 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYYY-0006e8-O1
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:35:28 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso23481475e9.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 11:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768764925; x=1769369725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTAOH/xq/3mecKgOFQc299O+6eUqLk/ATHdhAOXEHr4=;
 b=GOp2KxgHSxkHUKiLcqws2pRPk6wDcCr9JvXRx+Wle8I/CWEWv0WAbEMVdZmryiZc/L
 dyQh0t9gmBKkmhsGEmkgzMUyikg4/s15H+dLOjIxa9UeQ9fXjdeQQBm13p+/K2qGj7M0
 juImmVHen2OxMDDjfzSINGG+NeQwUNpU+vMKK5nV6ktcH7wk3Xz4zsBdsxPoYg3QT7r8
 aT8K2I/6YnM66wY1yydMB8jqWcUw7xNb8F73mIxDGcvIM+vL23+kTZM7RZr1Z9erZlRL
 c+E6K50yWPYhGPxR3M8VA2ikFYZUuiDlGTDwqA//eKPNHdglROOs1Sof63/7ThPzCfz2
 +B6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768764925; x=1769369725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RTAOH/xq/3mecKgOFQc299O+6eUqLk/ATHdhAOXEHr4=;
 b=Umtb3sUOZ46OyVceTWwEEEPBOBc/ZvJp0qEA1TdkeiNYND38Hh768WoSc7uP5akgR7
 Q3mpUHX7nB98fFI1gvn8bCkufIuGwlofu9uK1IkumRanwKAct8W/G4UR/nHBiSNIqWdY
 OqT8ApaIt42OceBIn0/lnDsqCeFlKS/YximtHSQo/KtCxu3sGo9LnPbFmcb862drzjoc
 liVaC88glTfJ8N/ro8enCdzxaMaZvGZrFCg085iGdr4NYjgCuY4LnBlE0d+a5f5mnmHE
 Jap3xc6kEFEKFv551gaZ433PwFe2UbDZUkKUz6AxzguOsp/2h5k5gwsYKBWFEh5SEME8
 3vMA==
X-Gm-Message-State: AOJu0Yx0EMV9IRmOViVtICRAyP8+Uzt8TYW3MPA8O3hd/MWznDZ7fTjF
 AUpt/Qhu2G0d/t3X88DVjjYZpVupTBTrYHusRVRuQhLVbl6bkcjWVIRzhQOAySnIVIbnLhVIRyA
 hyugsC9o=
X-Gm-Gg: AY/fxX6t/dKGBVOZPlbJOA8vm8p4IOqWhoeoILtn9Xbr50UvUgdY5HY9wiV+KKuR6oM
 yxidAYkZP3LP9ASQtlJorUVBhxygR7ZGhftYlc1SQSpsGrkTuTgyobTSwKXsLR2ekUqCw9HheIP
 3KlS1fUMklmcvkIeG+m3TYGfPibHeT8Cg/QGfo0Y2TIGwwH27A84JKR7jRfGbCWpYrnMpn8x81Z
 8+EmWtnkwamdQx0CSTrmzTiY0r3ZPWCIR9o17CaVmWSNhqp1ONvWPgSY6Ey79ZCug1b9e+rRVRM
 sYSSMpg2flCuk5eIDdUKUSmLlrlKSBMmhRfJNVgdb+KjTN8K+ay80BfJW6pvHTPJQq7dRuLSMtw
 W3U9fblWBx+T5RuosFRDHWwf3BSYRP0e2WL9fUtebDWDdcpRrOrBibylR1rVlP6/iuzS8NW9pZI
 4XkoA/uarN+jll046Nps6TNmeclT8WE57/OoZqXj4U3igsMyH6byw8t8mqfJ/1
X-Received: by 2002:a05:600c:4094:b0:47a:8383:f2b2 with SMTP id
 5b1f17b1804b1-47f44d4dfb4mr109274705e9.17.1768764925003; 
 Sun, 18 Jan 2026 11:35:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428ac749sm213885615e9.5.2026.01.18.11.35.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 11:35:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 02/18] bswap: Use 'qemu/bswap.h' instead of
 'qemu/host-utils.h'
Date: Sun, 18 Jan 2026 20:34:52 +0100
Message-ID: <20260118193509.42923-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118193509.42923-1-philmd@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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


