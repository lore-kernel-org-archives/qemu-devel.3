Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17837CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIe6-0000sB-K7; Thu, 15 Oct 2026 06:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIe1-0000pZ-ET
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:25:05 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIdz-0003NM-59
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:25:04 -0400
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so46006775e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792059901; x=1792664701;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hRRN1JeUA7jwAaRlPA2bDBFjU7DAkrQAjmmVepzRcwY=;
 b=fL0DKTpPupKFyufSfxxcJb2PZk9DT4UbTAqiQ/gis40jh8sN3ssWvAsorORWmVuBjv
 VmBAiPp4UL1f/9UntIfUC8D5V1SpifJKU40XXcTLLWg3pijqzRV2blGSLZx3l9Z74M7G
 d0KhUemHAnsMLk6VpVVxwMHtIk+n03tIsWZPwTdI6F0KDeg8fjw0gIj9eq/9OGn4NaZJ
 tiW214uZIYWop6H7pbVQ/S6AErM3auOMui1wDehpIVpV0nzFeNAc833ki3vG1tjVaxbA
 1AQp+VfTIbxiGjzsM9HwYum+UzhP9r6RfqGXWPBJSl3QRRvG8ipnUnTY4cCSVjS1bq88
 3AdQ==
X-Gm-Message-State: AFq9FYIcnsj1zArQeLgD4riX1iv2Q6tk8YlcqTbPLiFAIya8BRxoOTnD
 20mYDWJJM6Z+FmlC43GJ7vQQ1KRKsZZI9nj2PI8wucTurV8bPWA8w3o8I7NgabU5
X-Gm-Gg: AYBFou1d2b/hf9Pqv8oa7eYb/0visnBeeN6lQX1+U2FdZ+1W/Gd6AdFJyuOrw/sXXTU
 iEyvzStIlHmno5sWxq3aEtOSXywG/CMaSZ1ITlN3qXyAryNDj+Ds8A8Of5p8fyZUNWvFKptTSwY
 /59E6gCCSdggzOzL6PuG1QZeGhbB7sAhXNglc6tBfYSjH4aLNKdJNKYBdSU89RO/ukF7ffE6cIO
 FW15H+uVyzEwu5DRSHAvkECT15TzSdaWAoTRLYdDFINjw71dgSb9R+JNMt8CzpomR8pTDSZvW0Y
 MI0+e5g7dnqvdHzgKW0gvnUPJjkwF6hrViDJYWlgTHYS0K0Y7L0ag62GLDEpt6ndJItUwkpyGM4
 qMXHipHm47s/zK32rRjBfAJVHeu1Az2IgmEZmdtUJn1+qzzmIkVxNNUQTId+DkOckoMpRyEhxeM
 QueWY/TBfDHlDigkw3CY49WztSDFTjyTinwF+8ioCCzNdbIX412+/ACV5+L/D50/lvNPuY7+Gnf
 QIa1dEVUgF1V1gU4geU85z00k8PVA6I/4TJZ43BaDLpWtxCqc9RXllw
X-Received: by 2002:a05:600c:350b:b0:4a1:ad01:f8dc with SMTP id
 5b1f17b1804b1-4a1ad01f924mr164855695e9.21.1792059901206; 
 Thu, 15 Oct 2026 03:25:01 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de3f7f8b8sm16993684f8f.35.2026.10.15.03.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:25:00 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:27:55 +0200
Subject: [PATCH v3 08/50] hw/rtc: ds1338: move TYPE_DS1338 to a public header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261015-bmc-minerva-v3-8-7d50c8a108e5@free.fr>
References: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
In-Reply-To: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056475; l=1605;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=jNIbEw5Dx6rmzBocKs0idI42P74RBZ2J77WhR75yZGs=;
 b=69tmfEnX6XuLSGcxuI3K9dz2hqhVD3rFmws43ND5avNLLyg4HCGpgtxn6qpeFZDj3RGMoFQ2q
 NwLglTZbW+MCsGZ5bQR/5Yh3+PWECxOyhnYmfRh6WxpbQXw1w3gzV4E
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.52; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f52.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move the TYPE_DS1338 type name definition from ds1338.c into a new
include/hw/rtc/ds1338.h header so that boards instantiating the device
no longer need to redefine the type name string locally.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/rtc/ds1338.c         |  2 +-
 include/hw/rtc/ds1338.h | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index 5f1ee2e410..f8b3340bf0 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
+#include "hw/rtc/ds1338.h"
 #include "migration/vmstate.h"
 #include "qemu/bcd.h"
 #include "qom/object.h"
@@ -29,7 +30,6 @@
 #define HOURS_PM   0x20
 #define CTRL_OSF   0x20
 
-#define TYPE_DS1338 "ds1338"
 OBJECT_DECLARE_SIMPLE_TYPE(DS1338State, DS1338)
 
 struct DS1338State {
diff --git a/include/hw/rtc/ds1338.h b/include/hw/rtc/ds1338.h
new file mode 100644
index 0000000000..f4cfe6a8e7
--- /dev/null
+++ b/include/hw/rtc/ds1338.h
@@ -0,0 +1,20 @@
+/*
+ * MAXIM DS1338 I2C RTC+NVRAM
+ *
+ * Copyright (c) 2009 CodeSourcery.
+ * Written by Paul Brook
+ *
+ * This code is licensed under the GNU GPL v2.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_RTC_DS1338_H
+#define HW_RTC_DS1338_H
+
+#define TYPE_DS1338 "ds1338"
+
+#endif

-- 
2.53.0-Meta


