Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A6EC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZv5H-0001EU-7d; Tue, 13 Feb 2024 10:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZv5F-000187-IP
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:52:33 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZv5D-0005nG-2x
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:52:33 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-411bf7e5c6bso5287985e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707839549; x=1708444349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L085CpBqbUnpyqRxr8xkRM4/gsDgBNq2ejRMwVmcLvc=;
 b=gqfUylW1BlOnHp7REJXELwFpkibfREbnhWI+7NDJqlUUKV442ZM19/Q9yr86+thPZG
 7rqOP719Dq7wiFe6IF2LNVl+CwJAcFa6tL7beQUoBqAlLoUOWc4ted3axR17a4uaOE2A
 Ij9fwmZLSwuuOd0KZViEVYQowzusFSjjPYMMqg8Wv8mhWNAy5i8vCLxI99dzs+iexCn/
 +vHAPORZdbdwEkUNrFF54iisIDybysL7CqL6NvbWjVgnhwE/4vH/WzqhbtPpuwWWJqNo
 nk+IwdNkRtCa4QC0zsL+V69wOCcFUTi3bZY/KWSoUp8x2y+GzdpVWw/xz6xqY+6FEKbj
 IM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839549; x=1708444349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L085CpBqbUnpyqRxr8xkRM4/gsDgBNq2ejRMwVmcLvc=;
 b=K1G6MRWp41FZ6Yj0J/c6A/Wg/VEl0Lcrmjh6/zAZwL/ilgJRtmzNOPzwRx5VXWHuKw
 LQ4Iylrn397vgmax4auCOm0qV5eGhbyZOWsUvB6RfX8F1uymTgFeqsqP4ZKluWzBUcYJ
 +cFSqX4ec4oIcAU/9Yasi98xDBhx4Oj8FtmnaGUwQagOpYFxPkCJ0n5mfk0/jwUHtHKN
 eUlnJhHJCOTY02jo/qJMAKsY8EAQpGSUr4o2fU6uXUIzN97K/COHf0+vsoAYa/lZuXbc
 stDxgO8QulcchqagfG+OKVyUQRQN0DEHKOdtGMWl3oEVpoHgxx9Aymn9MYhYtm8pMghj
 Ppow==
X-Gm-Message-State: AOJu0YwL2Eh05kyi7qfaAtgvS8ScwXabnsL3mM7+OGUeq+MaBScp9J+V
 3WNvSVS/eDM20WWbP5unpjH5gNnOfXNyensWRmPRCh90x87wqwcaCEiPWWZLLOFolhGpunk74W+
 k
X-Google-Smtp-Source: AGHT+IGzsV8wfwVEjWR9KuE1fz7unSM1UOufwbFay0thLSXsPRgjWxJuy48IdYGI9uulUJ3GutK/lw==
X-Received: by 2002:adf:e68a:0:b0:33b:68bb:e0d4 with SMTP id
 r10-20020adfe68a000000b0033b68bbe0d4mr7797379wrm.56.1707839549476; 
 Tue, 13 Feb 2024 07:52:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUw9y43ORycSmZRs6lqlG6429iNGLXvQA6XQLHwb0lbgnL7tN5yeWLsm0rHJkPib5f/eWu5ixgBCx4lWz05Oq3aH7JWmC+D0+w12+i8Vs4guKa5o/BXcMo1jlmK0S4zf+BNhMwYl3pPKcjkoJ/bSoHwVg==
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 a15-20020adffacf000000b0033b39cba5e4sm9826619wrs.116.2024.02.13.07.52.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 07:52:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/4] hw/arm/stellaris: Convert I2C controller to Resettable
 interface
Date: Tue, 13 Feb 2024 16:52:12 +0100
Message-ID: <20240213155214.13619-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213155214.13619-1-philmd@linaro.org>
References: <20240213155214.13619-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/stellaris.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 4fa857970b..d3a12fe51c 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -462,7 +462,10 @@ static void stellaris_sys_instance_init(Object *obj)
     s->sysclk = qdev_init_clock_out(DEVICE(s), "SYSCLK");
 }
 
-/* I2C controller.  */
+/*
+ * I2C controller.
+ * ??? For now we only implement the master interface.
+ */
 
 #define TYPE_STELLARIS_I2C "stellaris-i2c"
 OBJECT_DECLARE_SIMPLE_TYPE(stellaris_i2c_state, STELLARIS_I2C)
@@ -607,10 +610,17 @@ static void stellaris_i2c_write(void *opaque, hwaddr offset,
     stellaris_i2c_update(s);
 }
 
-static void stellaris_i2c_reset(stellaris_i2c_state *s)
+static void stellaris_i2c_reset_enter(Object *obj, ResetType type)
 {
+    stellaris_i2c_state *s = STELLARIS_I2C(obj);
+
     if (s->mcs & STELLARIS_I2C_MCS_BUSBSY)
         i2c_end_transfer(s->bus);
+}
+
+static void stellaris_i2c_reset_hold(Object *obj)
+{
+    stellaris_i2c_state *s = STELLARIS_I2C(obj);
 
     s->msa = 0;
     s->mcs = 0;
@@ -619,6 +629,12 @@ static void stellaris_i2c_reset(stellaris_i2c_state *s)
     s->mimr = 0;
     s->mris = 0;
     s->mcr = 0;
+}
+
+static void stellaris_i2c_reset_exit(Object *obj)
+{
+    stellaris_i2c_state *s = STELLARIS_I2C(obj);
+
     stellaris_i2c_update(s);
 }
 
@@ -658,8 +674,6 @@ static void stellaris_i2c_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &stellaris_i2c_ops, s,
                           "i2c", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
-    /* ??? For now we only implement the master interface.  */
-    stellaris_i2c_reset(s);
 }
 
 /* Analogue to Digital Converter.  This is only partially implemented,
@@ -1396,7 +1410,11 @@ type_init(stellaris_machine_init)
 static void stellaris_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    rc->phases.enter = stellaris_i2c_reset_enter;
+    rc->phases.hold = stellaris_i2c_reset_hold;
+    rc->phases.exit = stellaris_i2c_reset_exit;
     dc->vmsd = &vmstate_stellaris_i2c;
 }
 
-- 
2.41.0


