Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C38C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcqTh-00018a-BB; Wed, 21 Feb 2024 12:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <37DPWZQwKCuEQDELKHVWHIDQJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--nabihestefan.bounces.google.com>)
 id 1rcqTT-0000sy-8S
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:33:44 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <37DPWZQwKCuEQDELKHVWHIDQJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--nabihestefan.bounces.google.com>)
 id 1rcqTO-0002TZ-20
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:33:38 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dc6b26845cdso1280973276.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708536812; x=1709141612; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=+9+8PfRfulApedC4nlWtcYgUGbJ4o3VdSnLLrjIzEPA=;
 b=n3+Zfzpn0YSxuUhwDm+sLoF9XwsgVFg922SlmH9AxymcjJtgM+IDlsRh0A+cGuFIzq
 OYbS3fEG0MHIMHnJ9IWxdOM54fCjIYd/gLatxUILoRRvR9QqyOpatkwcfNAqej0gEmW0
 rTDBln5ZPscaarUGIN2dVQCI24SXgGn6w6JIpU8M5I/ysTZRVG9BGp5fcbRjMBhiks+U
 8nc2f/2CMOl5jOrzPiPJHT5BuQuY95waZJaZ6OAowhjABCzG+JKErXQKXVqzo2bzoGJE
 fBL35wf7Jad5TOpFU0gsNrB1itKmKZB6YtMv/k6Nm6rKhDBn9H3/Dp0lAPkLFMoOdowA
 7rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708536812; x=1709141612;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+9+8PfRfulApedC4nlWtcYgUGbJ4o3VdSnLLrjIzEPA=;
 b=vZ2ublDe9UoxaSvjVdGMMGdJURNSye+EnRw96s9482I6WhEe2CPx+ay3Ou9drLO99L
 x5IbZZhy8ckrHA3jGnBcC1y9W9AYqnYSEdVzYNQJGSgjyNZDLwNrjrNa1Kn4KedBiqaC
 YigAYbc9cetwb8NEuHZO63Mu2eEmPtGzwENu6lmaTphI/1HngrzawpFfeo+IJMzqONfa
 SIAMRgQkW7Eea1T5lbc44WPkdQyrjYojdX252+jMyHl9X9puMURIeZvzFA7tWUkzbg4y
 0i84QiXDE3vBBQQfKlzw3iteWA/tgcYQY/QylFd+VcVAC7LohL+o2sV2hdUVsTEO2rJK
 FQrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmnnxYiIpTJYeZpPaH2h6HVqm2o95OtTF5xSNgjXfEuHq2D+jpEWRlz0Q4+MMDL0uUqAi5KhRNTTukL7s4+Po5f0Z51GM=
X-Gm-Message-State: AOJu0YzTmQBqlWhc9eNUyYJnYmBKuUCTUe7VDZ87Lha88XqO+dqBP1NO
 HurDBDVMCDeg+/mnDqjPzaujtccrbPidwe87sj8EGTt1VaLEBrKYK9JcPs8JxxKs6m199j3WLhG
 BoZ6Dn+aHbeeRg7D0T5/wmlvaLQ==
X-Google-Smtp-Source: AGHT+IHHegS9BiqqQsd4K3mHQP1OesSLBWhLCf6gVkCfxmhaQBH2LN/8ZsyV8oXdFBvBw5VLxVMnTNagOqR3q162vyg=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a25:840d:0:b0:dc6:519b:5425 with SMTP
 id u13-20020a25840d000000b00dc6519b5425mr5001050ybk.11.1708536812182; Wed, 21
 Feb 2024 09:33:32 -0800 (PST)
Date: Wed, 21 Feb 2024 17:33:25 +0000
In-Reply-To: <20240221173325.1494895-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240221173325.1494895-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221173325.1494895-3-nabihestefan@google.com>
Subject: [PATCH 2/2] hw/intc/arm_gicv3_its: Use send_msi in the
 GITS_TRANSLATER write
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 its@irrelevant.dk, kbusch@kernel.org, roqueh@google.com, 
 nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=37DPWZQwKCuEQDELKHVWHIDQJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Roque Arcudia Hernandez <roqueh@google.com>

This is trying to achieve 2 things: To be able to redefine the send_msi in a
derived class of arm_gicv3_its and/or to expose a method call interface to
inject interrupts from another device.

Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 hw/intc/arm_gicv3_its.c                | 20 +++++++++-----------
 include/hw/intc/arm_gicv3_its_common.h | 13 +++++++++++--
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/hw/intc/arm_gicv3_its.c b/hw/intc/arm_gicv3_its.c
index 52e9aca9c6..9342e96be3 100644
--- a/hw/intc/arm_gicv3_its.c
+++ b/hw/intc/arm_gicv3_its.c
@@ -20,16 +20,6 @@
 #include "qom/object.h"
 #include "qapi/error.h"
 
-typedef struct GICv3ITSClass GICv3ITSClass;
-/* This is reusing the GICv3ITSState typedef from ARM_GICV3_ITS_COMMON */
-DECLARE_OBJ_CHECKERS(GICv3ITSState, GICv3ITSClass,
-                     ARM_GICV3_ITS, TYPE_ARM_GICV3_ITS)
-
-struct GICv3ITSClass {
-    GICv3ITSCommonClass parent_class;
-    ResettablePhases parent_phases;
-};
-
 /*
  * This is an internal enum used to distinguish between LPI triggered
  * via command queue and LPI triggered via gits_translater write.
@@ -1561,7 +1551,8 @@ static MemTxResult gicv3_its_translation_write(void *opaque, hwaddr offset,
     switch (offset) {
     case GITS_TRANSLATER:
         if (s->ctlr & R_GITS_CTLR_ENABLED_MASK) {
-            result = do_process_its_cmd(s, attrs.requester_id, data, NONE);
+            GICv3ITSCommonClass *c = ARM_GICV3_ITS_COMMON_GET_CLASS(s);
+            result = c->send_msi(s, data, attrs.requester_id);
         }
         break;
     default:
@@ -1994,6 +1985,12 @@ static void gicv3_its_reset_hold(Object *obj)
     }
 }
 
+static int gicv3_its_send_msi(GICv3ITSState *s, uint32_t eventid,
+                              uint32_t devid)
+{
+    return do_process_its_cmd(s, devid, eventid, NONE);
+}
+
 static void gicv3_its_post_load(GICv3ITSState *s)
 {
     if (s->ctlr & R_GITS_CTLR_ENABLED_MASK) {
@@ -2020,6 +2017,7 @@ static void gicv3_its_class_init(ObjectClass *klass, void *data)
     resettable_class_set_parent_phases(rc, NULL, gicv3_its_reset_hold, NULL,
                                        &ic->parent_phases);
     icc->post_load = gicv3_its_post_load;
+    icc->send_msi = gicv3_its_send_msi;
 }
 
 static const TypeInfo gicv3_its_info = {
diff --git a/include/hw/intc/arm_gicv3_its_common.h b/include/hw/intc/arm_gicv3_its_common.h
index e072c36cca..c81bd0b26e 100644
--- a/include/hw/intc/arm_gicv3_its_common.h
+++ b/include/hw/intc/arm_gicv3_its_common.h
@@ -25,8 +25,6 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "qom/object.h"
 
-#define TYPE_ARM_GICV3_ITS "arm-gicv3-its"
-
 #define ITS_CONTROL_SIZE 0x10000
 #define ITS_TRANS_SIZE   0x10000
 #define ITS_SIZE         (ITS_CONTROL_SIZE + ITS_TRANS_SIZE)
@@ -132,4 +130,15 @@ struct GICv3ITSCommonClass {
  */
 const char *its_class_name(void);
 
+#define TYPE_ARM_GICV3_ITS "arm-gicv3-its"
+typedef struct GICv3ITSClass GICv3ITSClass;
+/* This is reusing the GICv3ITSState typedef from ARM_GICV3_ITS_COMMON */
+DECLARE_OBJ_CHECKERS(GICv3ITSState, GICv3ITSClass,
+                     ARM_GICV3_ITS, TYPE_ARM_GICV3_ITS)
+
+struct GICv3ITSClass {
+    GICv3ITSCommonClass parent_class;
+    ResettablePhases parent_phases;
+};
+
 #endif
-- 
2.44.0.rc0.258.g7320e95886-goog


