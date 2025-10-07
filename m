Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C780CCCD186
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 00:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6IK3-0001d0-V4; Tue, 07 Oct 2025 20:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3PXPlaAMKCggvz6owwotm.kwuymu2-lm3mtvwvov2.wzo@flex--nry.bounces.google.com>)
 id 1v6Dz8-0003ht-Se
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:08:35 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3PXPlaAMKCggvz6owwotm.kwuymu2-lm3mtvwvov2.wzo@flex--nry.bounces.google.com>)
 id 1v6Dz6-0005x1-Nj
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:08:34 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2699ed6d43dso66279475ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 13:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1759867710; x=1760472510; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DbgmcHP15QKvcQQOt72wI53/ywscnVQHdytOVGUxB/s=;
 b=RhOtTPuRO4pF3JsBetsQNFcI6grk8LRH8//TsAOHfumSYS9kHN0HfnUwALYrcuVLXI
 Ndu/8+3AjRXThGJnnBbfwo30U+EsLSU+5YvqAl36ABidM6Cq1tVZh1jyQ8j0yGcG46ZV
 L89RzfR4o1Mv/zlHoWjXY9lKFfvq5xeiQiWukxFGYYItRz1OXO7zoFYu0XjWrGMVVsah
 ye+Px2bx6uQDs9/jBqVv/XtInvySxgLncRzj7jdu0/l5aHHI/TEhhNdWodWlr2pJk6nd
 ISHHS9lOqgQzCARUqsrDYNkza+HWejiF9HXKidFa/mue4N4SPxgwrIYk3J8wbyED3AsE
 DWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759867710; x=1760472510;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DbgmcHP15QKvcQQOt72wI53/ywscnVQHdytOVGUxB/s=;
 b=ETcQE5p9bbOVUHn4Ukn3miTwaAZ9lQXAJAak6G1wPbc7T2ZJ9gKs9md1X9Xrgr/euU
 2UIG1WzmIMprhpWIMqbuJ7gcFKdB0dNOrxygI4cqV5BM7+4rziqxK7jR25bPqaBZe2ck
 tSRxdV+C/Zly4W91krkCy6otb7mmArasqHmEOY12rz4JEQULO+ikA43NL+1BFpEUqASg
 gnB7aVG0tEnf5z7PezV7KOSRY3o7lATqSdIurhpkwpeVBhDu4Ui0pDBAUXbcyzCg4UZV
 Jt9YOUwukBtkM3N3ImohoBw8LzFjxvM2JdFj5fb0NxQWlQto0fq8qGx8d5TFED/kPE/2
 hcGg==
X-Gm-Message-State: AOJu0YxmRXlxe7FePabIXsfcCiREu3eDl7t4AVgf/iAC0buYg4IWFGvW
 7SP7NWyWB8Xkadv91oEniVKQuO0JpjctTMQwPOP8lSAAaCQ0Lfs2zVSzcRDSrOhocV9vQMCzaUb
 on0cse4G4QUpCgQ3DCBr5eIPP8/58fFe2IwdZ64nwa/g6ncKvcqoh/LevY5zz2w/nx5pVp7UeBx
 454vq38z6jyKqXWKTALjY=
X-Google-Smtp-Source: AGHT+IGnN+zO4NthvHf4D/OqYn/cKrk6g2XLKQkRrZmyDYyoLuL1a5pbyhZzk/qWoQ7htdDZgRW6128=
X-Received: from plblv11.prod.google.com ([2002:a17:903:2a8b:b0:234:c104:43f1])
 (user=nry job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:380d:b0:26d:e984:8157
 with SMTP id d9443c01a7336-29027356ab2mr11301575ad.8.1759867709666; Tue, 07
 Oct 2025 13:08:29 -0700 (PDT)
Date: Tue, 07 Oct 2025 20:08:22 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADVz5WgC/x3MSQqAMAxA0atI1gbqUKeriIvaJpqNllZFEO9uc
 fkW/z8QKQhFGLIHAl0SZd8SijwDu5ptIRSXDKUqdaFUi8Y59Nb0uq4wnt7v4cCe26ZjnmvHFaT
 SB2K5/+s4ve8HKpDFB2UAAAA=
X-Change-Id: 20251007-add-pca9543-support-9f768ffb4df3
X-Mailer: b4 0.14.2
Message-ID: <20251007-add-pca9543-support-v1-1-905de56ab741@google.com>
Subject: [PATCH] Signed-off-by: Henry Tsai <nry@google.com>
From: Henry Tsai <nry@google.com>
To: qemu-devel@nongnu.org
Cc: Patrick Leis <venture@google.com>, Henry Tsai <nry@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3PXPlaAMKCggvz6owwotm.kwuymu2-lm3mtvwvov2.wzo@flex--nry.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 07 Oct 2025 20:46:19 -0400
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

This commit adds support for the pca9543.

---
This adds pca9543 support to mux.

Signed-off-by: Henry Tsai <nry@google.com>
---
 hw/i2c/i2c_mux_pca954x.c         | 12 ++++++++++++
 include/hw/i2c/i2c_mux_pca954x.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
index a8ef640cd2575ac627cdc23b1860a8a3fce8a932..05360b2ac4c095309df261094b368a5b7a2a4c26 100644
--- a/hw/i2c/i2c_mux_pca954x.c
+++ b/hw/i2c/i2c_mux_pca954x.c
@@ -30,6 +30,7 @@
 
 #define PCA9548_CHANNEL_COUNT 8
 #define PCA9546_CHANNEL_COUNT 4
+#define PCA9543_CHANNEL_COUNT 2
 
 /*
  * struct Pca954xState - The pca954x state object.
@@ -172,6 +173,12 @@ I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t channel)
     return pca954x->bus[channel];
 }
 
+static void pca9543_class_init(ObjectClass *klass, void *data)
+{
+    Pca954xClass *s = PCA954X_CLASS(klass);
+    s->nchans = PCA9543_CHANNEL_COUNT;
+}
+
 static void pca9546_class_init(ObjectClass *klass, const void *data)
 {
     Pca954xClass *s = PCA954X_CLASS(klass);
@@ -245,6 +252,11 @@ static const TypeInfo pca954x_info[] = {
         .class_init    = pca954x_class_init,
         .abstract      = true,
     },
+    {
+        .name          = TYPE_PCA9543,
+        .parent        = TYPE_PCA954X,
+        .class_init    = pca9543_class_init,
+    },
     {
         .name          = TYPE_PCA9546,
         .parent        = TYPE_PCA954X,
diff --git a/include/hw/i2c/i2c_mux_pca954x.h b/include/hw/i2c/i2c_mux_pca954x.h
index 3dd25ec98309d3203200933b7b48f8d9b0b6249b..1da5508ed51a878640e50c4941a07315edcbc187 100644
--- a/include/hw/i2c/i2c_mux_pca954x.h
+++ b/include/hw/i2c/i2c_mux_pca954x.h
@@ -3,6 +3,7 @@
 
 #include "hw/i2c/i2c.h"
 
+#define TYPE_PCA9543 "pca9543"
 #define TYPE_PCA9546 "pca9546"
 #define TYPE_PCA9548 "pca9548"
 

---
base-commit: eb7abb4a719f93ddd56571bf91681044b4159399
change-id: 20251007-add-pca9543-support-9f768ffb4df3

Best regards,
-- 
Henry Tsai <nry@google.com>


