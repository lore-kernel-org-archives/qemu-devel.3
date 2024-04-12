Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB97EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQR-00078D-3O; Fri, 12 Apr 2024 03:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQP-00076b-6e
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:17 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQJ-0007DW-4P
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:16 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e220e40998so4537685ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907247; x=1713512047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRXCXUY4I/jEqq87nwbnLzBZIzxiWLj4iUBZS7Znhy0=;
 b=luqGkJIMFNSaoXXMI7IAIDBSz1wvp3ZHFtASxtg7unvnkkxUcmsQ7Q4xbBVnkUVItV
 AV9tUxdLbCJwsqjfrdUYZUaYAa/pmfL5NpZ3ywwINw8GRKFvU8oGYL3VKaw7TWTnal+1
 +JG7xCJtnmu1ex8veBWf6yC7vbqjv/m2UpUm4ejGVRWhxOpNFSl0HUktr7ccZZdSxE3P
 BWcWhNe1JaXL74ZOxa7QzQmvl2rZrMNbd+DLcIYpTgYdcnz1gSzBbuBlGh/PFH2ECMS5
 1AKpbYI52v+ka4mDeOHKm5iXoWFktn6T24BFgMjswHA0yTGYcKS6SFgYxIX2yHR0G/I0
 SY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907247; x=1713512047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eRXCXUY4I/jEqq87nwbnLzBZIzxiWLj4iUBZS7Znhy0=;
 b=jhraScrkZZImigQoYfdMCQpUS9TCv0nmmMFaemyBlucj6REtrxf+yxHYZqAK+6ai/L
 RtGUbGmJY/PzQp5QsCWYZ60LHmL6VqGSFS/Vtp1qgNVOge3zZa8JebFPV31MRP+oWfRU
 8UrwHvV6CX0STFrd8XJMvcNVll1xmCV5t7sL8js2wE+DOWJXeSYqfEng0AYmf1kWvOtG
 5pFXekn+egNcI8cktWzMjjCz3dFVJhMVcH9hpBJPPMmACmJ9Q0+SxBj8eEiIe/Xu8xdJ
 ROMDRXgOUlEixpu1yOr0soGe9afchiPYjxnOMlM8iuW2s7jIINn8HH9FBcsQ8SgrAlcA
 DoAg==
X-Gm-Message-State: AOJu0YzL3/ZyMJOKQ1bVszpANujlSN2Sjv2eZRTpMa8vqLGjuNsrhxru
 vAZmtyJ9y4bXjej8WuTFhmRRSpYsMhVqacnV+tsQ6BTYK+qmuEBK7BG9dn1C/GA302JqsXFVHot
 a
X-Google-Smtp-Source: AGHT+IHnopKwfYYPUykV9ULcOCPgthiwJZVXaMAX99aKQSxR/BuOjQCmWyqVEGqW40HpyY3Im1Ro/Q==
X-Received: by 2002:a17:902:c101:b0:1e2:a5ee:c0a2 with SMTP id
 1-20020a170902c10100b001e2a5eec0a2mr1613846pli.31.1712907247436; 
 Fri, 12 Apr 2024 00:34:07 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:34:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 25/27] hw/riscv/virt: Replace sprintf by g_strdup_printf
Date: Fri, 12 Apr 2024 00:33:44 -0700
Message-Id: <20240412073346.458116-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.
Use g_strdup_printf instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240411104340.6617-8-philmd@linaro.org>
[rth: Use g_strdup_printf]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/riscv/virt.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d171e74f7b..4fdb660525 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1617,10 +1617,8 @@ static void virt_machine_instance_init(Object *obj)
 static char *virt_get_aia_guests(Object *obj, Error **errp)
 {
     RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
-    char val[32];
 
-    sprintf(val, "%d", s->aia_guests);
-    return g_strdup(val);
+    return g_strdup_printf("%d", s->aia_guests);
 }
 
 static void virt_set_aia_guests(Object *obj, const char *val, Error **errp)
@@ -1741,7 +1739,6 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
 
 static void virt_machine_class_init(ObjectClass *oc, void *data)
 {
-    char str[128];
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
@@ -1767,7 +1764,6 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
 
-
     object_class_property_add_bool(oc, "aclint", virt_get_aclint,
                                    virt_set_aclint);
     object_class_property_set_description(oc, "aclint",
@@ -1785,9 +1781,14 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     object_class_property_add_str(oc, "aia-guests",
                                   virt_get_aia_guests,
                                   virt_set_aia_guests);
-    sprintf(str, "Set number of guest MMIO pages for AIA IMSIC. Valid value "
-                 "should be between 0 and %d.", VIRT_IRQCHIP_MAX_GUESTS);
-    object_class_property_set_description(oc, "aia-guests", str);
+    {
+        g_autofree char *str =
+            g_strdup_printf("Set number of guest MMIO pages for AIA IMSIC. "
+                            "Valid value should be between 0 and %d.",
+                            VIRT_IRQCHIP_MAX_GUESTS);
+        object_class_property_set_description(oc, "aia-guests", str);
+    }
+
     object_class_property_add(oc, "acpi", "OnOffAuto",
                               virt_get_acpi, virt_set_acpi,
                               NULL, NULL);
-- 
2.34.1


