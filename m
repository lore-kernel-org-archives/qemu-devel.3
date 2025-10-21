Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433F9CCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJR5-0000fH-Ht; Tue, 21 Oct 2025 16:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJR4-0000Wr-4U
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:58:26 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJR2-0002Nc-1G
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:58:25 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-470ffbf2150so1643365e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761080302; x=1761685102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhKwIpK6oHtKElKWV9wfvCnnIBbAtivgR1l9aH1KDRU=;
 b=d7eG6t4VUVxk+Ey2vwF972TzngwI/r9GsMe1ewd6JK1YFuxmcwzBBM1ZWea4JlbSr5
 7UJdjBaLU3SZdOAnLqTYwsZhaSJGUr5Og7ycZBalp2ucbHhY8gGEcvTQOc9P8j9qXPni
 RA1R9FvY3TfPwQoHcg2h1G9InW414SDLvOA8QSPFlge114uyN/GRV0L7p7SFYz3reyZy
 FC9BncCeEbJqSDJhnkTamRB6N+DpWFYj3rJA7wSzahNm7OmjypqUCnMznQCd1qWdjQc5
 B1V+lX6rm7yi7pvXAOYUPQT3OPBNJJPspQxIcXsc6tVFHhrcdKqIou4f9J/4RI9tpGJb
 HnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761080302; x=1761685102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GhKwIpK6oHtKElKWV9wfvCnnIBbAtivgR1l9aH1KDRU=;
 b=fs3Kdw5gkosQrycJK+pJ/CvIhUQxDYUCZmEv8P5ZPyb6Dc3VeUZlEeVR3YxNVd+aIL
 /8IxzROpuFldjV19d6Ze/G8V5cMEOxAsSD8LWQ5FUAz5YMwf7gcnocbfit/G8SN2/Ab9
 owOiUUDRlwndhWXTrTo2xUrIA1idRxSe+Uw4DU8aP56OlGtfbC0mNR7UDQj2S5+V6fqe
 oGKsD5vV/2gwddKKjElF2Q7sqtOynXLXBSEX0A7rVsoUhlJLPGRoKgP01L7r5iu1uKAJ
 B9ctdP0ccsNuvZhZ+a7CXjFb8Lp0soSVkhYt/5lHpbqBwNwmS8AbX1QTVa69BY4ShxKI
 R20w==
X-Gm-Message-State: AOJu0YyYT1qh3JqbOApo12fcE5932z9gEinTnmM4whgiSpy6f6jL2SL9
 B0m5ONnGw6YB33PxLdjp7oBc1PNDX7kuM2Nzo6VIre+RhGvPj6YbWAsJI7IihSCeNyy3IRW4+jI
 qmbHJQHA=
X-Gm-Gg: ASbGnctMcjZOkADgYKxnSCqGVijUOa4O/RQqVQJbvvitdsjiAqfSPCsTCuXWcFHTfhE
 bV6NUyynqnmy0ebXuv+r1ZNewIOTsxtyMmUx4+MXWNvtuLYV/5NyEJd68wmy89Mp6dLiIJLq9hT
 A6C88xOwYbkbgiYFCjgg7He1lNXvNhOT/dP9g+2cF7sHGLlH3yz6Yod6rpaYw8+Wau06EeCs3jF
 hI8dDg3nD3X9gb0MXJilyLK8tP3EzsWyD26f5cE7HV4iMNOjh+Np0sPe7zOCV0dggYdmtBBjmEC
 +HoEDuoAQZuTHYTUUJZgbWDCVgQPZ7IE7mQxQlSoSm+euRe85sEW9uK52gfkM6nkoJ7FNZmW7J0
 E8G35DWkvrQvklLEt8TbCso16PbkdBu4Uwyh6UlNtmY2idCqRX0sJizrNhg0pHf7gm98H8Xg30j
 g8hzRhNnC/wrumFcwBuy32uBO7FKp5KKv+iP6iTjego3DrNP5ayLxByVPxr1DE
X-Google-Smtp-Source: AGHT+IEd/UUE56W5KjJpwQejPhpsH9urDl28j9H+KgQrbuItNFnqsfDOrr3Ib4fSrJ/nhkRfeiCx7A==
X-Received: by 2002:a05:6000:310e:b0:426:dac0:8ee8 with SMTP id
 ffacd0b85a97d-428532554b6mr823031f8f.10.1761080301940; 
 Tue, 21 Oct 2025 13:58:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3c34sm21788824f8f.17.2025.10.21.13.58.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:58:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc.michel@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 03/19] hw/arm: Add DEFINE_MACHINE_ARM() /
 DEFINE_MACHINE_AARCH64() macros
Date: Tue, 21 Oct 2025 22:57:24 +0200
Message-ID: <20251021205741.57109-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021205741.57109-1-philmd@linaro.org>
References: <20251021205741.57109-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

A machine defined with the DEFINE_MACHINE_ARM() macro will
be available in both qemu-system-arm and qemu-system-aarch64
binaries.

One defined with DEFINE_MACHINE_AARCH64() will only be
available in the qemu-system-aarch64 binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/arm/machines-qom.h | 28 ++++++++++++++++++++++++++++
 target/arm/machine.c          | 18 ++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
index a17225f5f92..3f64d5eb024 100644
--- a/include/hw/arm/machines-qom.h
+++ b/include/hw/arm/machines-qom.h
@@ -9,10 +9,38 @@
 #ifndef HW_ARM_MACHINES_QOM_H
 #define HW_ARM_MACHINES_QOM_H
 
+#include "hw/boards.h"
+
 #define TYPE_TARGET_ARM_MACHINE \
         "target-info-arm-machine"
 
 #define TYPE_TARGET_AARCH64_MACHINE \
         "target-info-aarch64-machine"
 
+/*
+ * A machine filtered with arm_machine_interfaces[] or
+ * arm_aarch64_machine_interfaces[] will be available
+ * in both qemu-system-arm and qemu-system-aarch64 binaries.
+ *
+ * One filtered with aarch64_machine_interfaces[] will only
+ * be available in the qemu-system-aarch64 binary.
+ */
+extern const InterfaceInfo arm_machine_interfaces[];
+extern const InterfaceInfo arm_aarch64_machine_interfaces[];
+extern const InterfaceInfo aarch64_machine_interfaces[];
+
+/*
+ * A machine defined with the DEFINE_MACHINE_ARM() macro will be
+ * available in both qemu-system-arm and qemu-system-aarch64 binaries.
+ *
+ * One defined with DEFINE_MACHINE_AARCH64() will only be available in
+ * the qemu-system-aarch64 binary.
+ */
+#define DEFINE_MACHINE_ARM(namestr, machine_initfn) \
+        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
+                                            arm_machine_interfaces)
+#define DEFINE_MACHINE_AARCH64(namestr, machine_initfn) \
+        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
+                                            aarch64_machine_interfaces)
+
 #endif
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 44a0cf844b0..0befdb0b28a 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -9,6 +9,7 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "target/arm/gtimer.h"
+#include "hw/arm/machines-qom.h"
 
 static bool vfp_needed(void *opaque)
 {
@@ -1212,3 +1213,20 @@ const VMStateDescription vmstate_arm_cpu = {
         NULL
     }
 };
+
+const InterfaceInfo arm_machine_interfaces[] = {
+    { TYPE_TARGET_ARM_MACHINE },
+    { TYPE_TARGET_AARCH64_MACHINE },
+    { }
+};
+
+const InterfaceInfo arm_aarch64_machine_interfaces[] = {
+    { TYPE_TARGET_ARM_MACHINE },
+    { TYPE_TARGET_AARCH64_MACHINE },
+    { }
+};
+
+const InterfaceInfo aarch64_machine_interfaces[] = {
+    { TYPE_TARGET_AARCH64_MACHINE },
+    { }
+};
-- 
2.51.0


