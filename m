Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F4FCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHN70-0006to-Gw; Thu, 15 Oct 2026 11:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN6y-0006oP-Ib
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:11:16 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN6w-0001jH-PU
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:11:16 -0400
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so22595895e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 08:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792077073; x=1792681873;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h/jBhx8TqfsnPUJuouPhKp95SfbgVptMIf/ysrEaIhQ=;
 b=qlPGz5hWZuSlT5LPPcNXneAwqAcoyIDwhVPPPtoHHRDO+iasZ2WsgrhnaG5NQkoTtJ
 w88+C0e30ejoWw5uJNMqyNkHNP/wrlF3UnBSLYfwgr+XKyMh38XRi6ikDftxBK1aD1nj
 4mCL6WxdT+WxhrZT9dlkO8+lO/zb1Lnsh4wTyLnZY5DxOKhdasho1xI7bRylHCSJZzA1
 L4rxoL/VW768SsovUtKMlEFFkuIeleN/1TED8Qn+qlD2U8N6/7GoajcmyZ2YJrwxto2u
 LC4f2TCM275bi1EpTGMIqU2CTTnyQOH3s+p538x3+wS75DJOJk7iYgk97mf2W9/IP+eM
 MOuQ==
X-Gm-Message-State: AFq9FYJzt0xuZnjN2LFC7M1v0UG1RxBGR4JounB/lYloCLd9WNFUm5l6
 8ZqeUEa5du2r3E3B23CwQncgQKd+jaztdBtCr3PkI7oWryIldo/PvOO0eV4DgA==
X-Gm-Gg: AYBFou3jAFq8cdhsJ0uTWmx0PWsL9N6ucggCD/kaENo4yAkikRIrNZLAR7N+ctUBgD1
 t1R2O3VjlS/PlDDKnUKG1/BiOIO8IL7DZdnHbf+BWHatMaPpnb2wPhArsKWqqlNRFO76sPZxhSP
 9Rlosa+DUMEvUYcWdH2S7cQ7lYKLtqHM0qBd3OXUqRDd1qDRAJGhgwOldLCLLekkGocwjqFuqj+
 oaJN2zQBsDvupRXsydoqvlSp3viieye6qcxwqO5mt6Se16+s2Q/Wn3fPuxrqdtlwndTOGPGC0fF
 L6UnwGBE8PdGQgLZW9xbFY9lPBuwW42AIm+f5CTP8q0Zul9PzH9lOOUUasyhMI0fqTpwO/E90Ck
 teVpsoqmt6VLM0EphmIRbmbm0VW3zdFwvOQCGYAqC02dHJvoaXHNKxGY1GOCfaF8PSJxe93QVg+
 4eyvax9j3enCPOcvY56AKlKsp/kYfwsNZ4VUSV7yB4UEZNh5gU7ya3RBGKAni1MpIHoErvjFd0B
 BfxM1xeqIti+HsE1kq7t/pbO1EMdqHJp9oVysqky1YdqGIOfINhEPWH6Q==
X-Received: by 2002:a05:600c:4ecb:b0:4a1:76c9:5408 with SMTP id
 5b1f17b1804b1-4a18e4a510emr394094355e9.11.1792077073123; 
 Thu, 15 Oct 2026 08:11:13 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1beb77054sm52640165e9.1.2026.10.15.08.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:11:11 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:57:48 +0200
Subject: [PATCH 10/22] hw/sensor: tmp421: publish the variant type names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-clemente-v1-10-bf591886b5b6@free.fr>
References: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
In-Reply-To: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792065465; l=1627;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=8uCJ56eVIcCR8z+k4HKJzPHWZ54KMlo/ENguxWLEwls=;
 b=PWfPkiOW1sGzox04JJcNLsWYGWYKGKZXs4ZX3ccT1Yf4RpTdJd+FzZ3P+utkCha+d8LUtcWpg
 sTqueunC8FwAFPtW2AGhntp85idvyY5QZ+lDaFjtwSX5I1lMlOw8SYB
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.41; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f41.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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

Move TYPE_TMP421/TYPE_TMP422/TYPE_TMP423 from tmp421.c into a new
include/hw/sensor/tmp421.h, so boards instantiating the device share
one definition instead of repeating the type strings locally.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/sensor/tmp421.c         |  4 +---
 include/hw/sensor/tmp421.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index e391bb20e1..5c04960b29 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -41,6 +41,7 @@
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 #include "qom/object.h"
+#include "hw/sensor/tmp421.h"
 
 /* Manufacturer / Device ID's */
 #define TMP421_MANUFACTURER_ID          0x55
@@ -79,9 +80,6 @@ struct TMP421Class {
     uint8_t config2_reset;
 };
 
-#define TYPE_TMP421 "tmp421"
-#define TYPE_TMP422 "tmp422"
-#define TYPE_TMP423 "tmp423"
 OBJECT_DECLARE_TYPE(TMP421State, TMP421Class, TMP421)
 
 
diff --git a/include/hw/sensor/tmp421.h b/include/hw/sensor/tmp421.h
new file mode 100644
index 0000000000..fbfdd87b7a
--- /dev/null
+++ b/include/hw/sensor/tmp421.h
@@ -0,0 +1,19 @@
+/*
+ * Texas Instruments TMP421/TMP422/TMP423 temperature sensor
+ *
+ * Browse the data sheet:
+ *
+ *    https://www.ti.com/lit/gpn/tmp421
+ *
+ * Copyright (c) 2016 IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_SENSOR_TMP421_H
+#define HW_SENSOR_TMP421_H
+
+#define TYPE_TMP421 "tmp421"
+#define TYPE_TMP422 "tmp422"
+#define TYPE_TMP423 "tmp423"
+
+#endif

-- 
2.53.0-Meta


