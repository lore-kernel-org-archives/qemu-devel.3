Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D37D3E77D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SMg-0008Ke-6u; Tue, 05 Nov 2024 17:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SMX-0007RO-TD
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:26 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SMW-0004Ov-AT
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:25 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso53246935e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846963; x=1731451763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aEfnTilVurA0fFYJxE8yf9x0TGhAiI0Ndz7fmD4ll1I=;
 b=ADWKX29WiXKWf1Hwg5l+q5lkmqq6uVvaMuiyUEBMTnYgaQDG16dMhRL7NiU54q544U
 CWuKne+HKW4l1YrhQ4S4v3hlvK6XEVvIzjvDNEqRlnYYViMQEOJIU6hTuMQOL6tHOO2J
 8xXLYx+GdhxvnZZ9xephqvfFaWZ4XQOOmtPyzJft4OVpWxO2K79Zrc17tn+3pXa4N9yi
 gOSg0Bl/qXt80DRVU0Sj99MG26mRQMzec+uPro1lduqdSjX6SV+ibYCpn0NsxkJ1gXl3
 YcrkTqgA/4lUF98x0evMKkHIOPjHoDkMoP16NQcRSVhRe8haqEySFPEz1F1Nfe5rjb+e
 ziPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846963; x=1731451763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aEfnTilVurA0fFYJxE8yf9x0TGhAiI0Ndz7fmD4ll1I=;
 b=eLnoarm08tDKlrkSk2suMt96spoVHfJxLV4n0UCGTI52Dl4mNW6pwzlbgSWExOqEBm
 1kilPHwlOvJoLz5w0cIcp1FWhxthSpqFEK/kgVQ25SjeZ6zBL6pAynWizCiBR4nh7pmZ
 MCHjo0wRZp808RIbDoqY9SKgQngvu+PuNmpIea9/9pYZeCgKJ8mQPmQF9ykD3mDpqGFZ
 IXYczd35+Gv60q2BkjC31mvb+lc0RMV5oO6ay0BXZ80dqyPKPF256OJMEAJPiIeKJGgk
 QkU/vSgiGB/tw0qNEtfnerHIqPTwHachALY5hPH161gzN4T11QcKYH1U4VAm7ZhcMZKU
 XIrw==
X-Gm-Message-State: AOJu0YyhfU1JBu+jjwKUvvC5wJEKwKkKgeCfJYH4DyXTX1asKHxrr0Hx
 sZoKXF8hMJOYOeFLTrL1JSO/oBzBSq1WWgVsKr2Ln9PJlPnxToIGqdTcO9lRX7dIqWkA2x5kk+k
 iuYnmww==
X-Google-Smtp-Source: AGHT+IHG40mqTDyX7dcM7kL0xBQs2LjsF8jZ8oFrrSxKKma+rKjJD481cfHTMRHDzQ+2Le7sfjmCWw==
X-Received: by 2002:a05:600c:3b8d:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-43283255a89mr139364135e9.19.1730846962660; 
 Tue, 05 Nov 2024 14:49:22 -0800 (PST)
Received: from localhost.localdomain ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa523a0esm1358135e9.0.2024.11.05.14.49.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:49:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/29] hw/net/fsl_etsec/etsec: Prefer DEFINE_TYPES() macro
Date: Tue,  5 Nov 2024 22:47:19 +0000
Message-ID: <20241105224727.53059-22-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20241103133412.73536-17-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/fsl_etsec/etsec.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 3fdd16ef2ee..d8076e7be48 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -36,7 +36,6 @@
 #include "registers.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
-#include "qemu/module.h"
 
 /* #define HEX_DUMP */
 /* #define DEBUG_REGISTER */
@@ -431,17 +430,14 @@ static void etsec_class_init(ObjectClass *klass, void *data)
     dc->user_creatable = true;
 }
 
-static const TypeInfo etsec_info = {
-    .name                  = TYPE_ETSEC_COMMON,
-    .parent                = TYPE_SYS_BUS_DEVICE,
-    .instance_size         = sizeof(eTSEC),
-    .class_init            = etsec_class_init,
-    .instance_init         = etsec_instance_init,
+static const TypeInfo etsec_types[] = {
+    {
+        .name          = TYPE_ETSEC_COMMON,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(eTSEC),
+        .class_init    = etsec_class_init,
+        .instance_init = etsec_instance_init,
+    },
 };
 
-static void etsec_register_types(void)
-{
-    type_register_static(&etsec_info);
-}
-
-type_init(etsec_register_types)
+DEFINE_TYPES(etsec_types)
-- 
2.45.2


