Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E298BC47258
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 00:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTAVa-0003h9-7H; Thu, 25 Jan 2024 19:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3EQOzZQcKChg8CA9C164CC492.0CAE2AI-12J29BCB4BI.CF4@flex--komlodi.bounces.google.com>)
 id 1rTAVY-0003gu-OC
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 19:55:48 -0500
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3EQOzZQcKChg8CA9C164CC492.0CAE2AI-12J29BCB4BI.CF4@flex--komlodi.bounces.google.com>)
 id 1rTAVX-0004ow-3C
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 19:55:48 -0500
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-6ddc2aefbe4so142749b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 16:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1706230545; x=1706835345; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=m19Pu1vkmJDMyBn5hNIU5j0Y+S3lgC3I8zwbtySHjio=;
 b=erhDR9gOPTgIfKPR2ui3SqnzgedM0LZG+4IOItLXuiZolwACr1A2I/w21pxLsGFpW0
 CY6Pmg+A+dV3scEO2aS0RXCnsXCmBV0fgQ5AgvDlaEYDG0zj0H8m0ZPMWn9auHUi/NIU
 iXtW6EK61iqUY5ZcO5JyaZbp+uFqFG0AGuqTeq07xoNzZ7WFSiQpnsN1VbbTnvOqUb+/
 3qn0/jnWBTZNdUJFKWZN7njkxfGXRjAdd8yT/OWkT3r4jBEAMSTRMq/5hIHo26qptYFj
 MONc7vKA2fQap56I73jgLkc487P+tembmjbgLnRdVAYv97rM5iWYAsKhRclQLYu02kiC
 6fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706230545; x=1706835345;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m19Pu1vkmJDMyBn5hNIU5j0Y+S3lgC3I8zwbtySHjio=;
 b=RkqRpZMIC76Czkr6/SP0N0yOy6LqIotZ/9YLnU/x2QYtQHdRfmBuviv2NLgtNBsn/N
 y/ZA9hKjrDQBmGkdRSHFN0CQU1h20yarDJLC09jS67cRvuI8XT28FVLkkHmAOHJfat04
 U82PxRlkcqWj9XhhdNvzf/7NecIlp03nXzDU0lQ7UC59/LpaYG4T10JAwmcgLUL/d5l8
 l1uwXC5AxebnLHYPudDVxUJhJzit9WdrBPYcdoo2KgVjNT35KW91hs0FqdSKAEjhjipV
 AZVYmMbKo29f/0Gg7aV5opaQpiyXq5CEU0wHVDK/kzqIPerhA+v7Fz12hB+cSIzIFBE2
 6XPw==
X-Gm-Message-State: AOJu0YyyqaVFOcHgzUloQ/s7+5I/yXALI3em7aZojFULe2GBRoedUcW7
 9yJqCoE820FsDzuW6J0C9LrJ9DKs7nbJ/YjZynGO+ZHt6tB4shYBDKV5jj0IspcN096TGbY0ytj
 Okc1Rezc5oHL8hNtJyWS3zYoYggXe8XNUJamLxCqSnvpf2GVNhbxUwA7ap+BW/EhsqURK0H8KjD
 lBeRzAQ5+8G43cuF1vLxivR2K+1a2MqP5pnoo1
X-Google-Smtp-Source: AGHT+IHceoXjQVw+EsO1WWjw+SpKgK+xfMt68zYWoE0jve3G6T4RPO9uZHF2CsBRbqGSNClbnZVFhQQ2YIbb
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a05:6a00:3697:b0:6dd:8444:d141 with SMTP
 id dw23-20020a056a00369700b006dd8444d141mr75871pfb.4.1706230545064; Thu, 25
 Jan 2024 16:55:45 -0800 (PST)
Date: Fri, 26 Jan 2024 00:55:39 +0000
In-Reply-To: <20240126005541.1839038-1-komlodi@google.com>
Mime-Version: 1.0
References: <20240126005541.1839038-1-komlodi@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240126005541.1839038-2-komlodi@google.com>
Subject: [PATCH v2 1/3] hw/i2c: core: Add reset
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, minyard@acm.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3EQOzZQcKChg8CA9C164CC492.0CAE2AI-12J29BCB4BI.CF4@flex--komlodi.bounces.google.com;
 helo=mail-pf1-x449.google.com
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

It's possible for a reset to come in the middle of a transaction, which
causes the bus to be in an old state when a new transaction comes in.

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 hw/i2c/core.c        | 30 +++++++++++++++++++++++++-----
 include/hw/i2c/i2c.h |  6 +++++-
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 4cf30b2c86..def4f134d0 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -23,11 +23,31 @@ static Property i2c_props[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static const TypeInfo i2c_bus_info = {
-    .name = TYPE_I2C_BUS,
-    .parent = TYPE_BUS,
-    .instance_size = sizeof(I2CBus),
-};
+static void i2c_bus_enter_reset(Object *obj, ResetType type)
+{
+    I2CBus *bus = I2C_BUS(obj);
+    I2CNode *node, *next;
+
+    bus->broadcast = false;
+    QLIST_FOREACH_SAFE(node, &bus->current_devs, next, next) {
+        QLIST_REMOVE(node, next);
+        g_free(node);
+    }
+}
+
+static void i2c_bus_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    rc->phases.enter = i2c_bus_enter_reset;
+}
+
+ static const TypeInfo i2c_bus_info = {
+     .name = TYPE_I2C_BUS,
+     .parent = TYPE_BUS,
+     .instance_size = sizeof(I2CBus),
+     .class_size = sizeof(I2CBusClass),
+     .class_init = i2c_bus_class_init,
+ };
 
 static int i2c_bus_pre_save(void *opaque)
 {
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 2a3abacd1b..420868a269 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -64,7 +64,7 @@ struct I2CSlave {
 };
 
 #define TYPE_I2C_BUS "i2c-bus"
-OBJECT_DECLARE_SIMPLE_TYPE(I2CBus, I2C_BUS)
+OBJECT_DECLARE_TYPE(I2CBus, I2CBusClass, I2C_BUS)
 
 typedef struct I2CNode I2CNode;
 
@@ -83,6 +83,10 @@ struct I2CPendingMaster {
 typedef QLIST_HEAD(I2CNodeList, I2CNode) I2CNodeList;
 typedef QSIMPLEQ_HEAD(I2CPendingMasters, I2CPendingMaster) I2CPendingMasters;
 
+struct I2CBusClass {
+    DeviceClass parent_class;
+};
+
 struct I2CBus {
     BusState qbus;
     I2CNodeList current_devs;
-- 
2.43.0.429.g432eaa2c6b-goog


