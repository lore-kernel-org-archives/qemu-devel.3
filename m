Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF09CCD18D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 06:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v76T0-0001eY-QM; Fri, 10 Oct 2025 02:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v76Sq-0001Zg-9J
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:18:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v76Sj-0001G9-Bg
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:18:52 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e4f2696bdso17907935e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 23:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760077123; x=1760681923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96TZGDASTr7bkfhHVGvxBafMfwww43RZcVo8qqBiSF8=;
 b=wWSQcORZhAfIR5GHtJ0ONQFl4tlog8OUQ/JBk1cwJLVfJsHlgT2XsfwSuoZEAlbVpe
 7A4hjONTgrtIsaTuFoKBGlFgYBG7uLqd2TCn1cZMwuQQAmtwsUiMWh234FExnzWBy4/S
 0kQUx5dWSUiQlkx7vzpQAgV02kkey+dHyYWZU3lz0Fuv+pD4eVxyUFDz31MPhdT6zeS9
 YiKvRY4JnElMWU+ts2xn+V41h94b4dSaorKmJNed5ZTB/2eQdwPCdrDSpgmjdG4z2d8l
 +lJu4cZ9BckpR3PJ54+Tqsdp1tcROjo1TMihQK7ZarQ6fLHjbx+kH6XWF85r+I/dKM63
 SRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760077123; x=1760681923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96TZGDASTr7bkfhHVGvxBafMfwww43RZcVo8qqBiSF8=;
 b=d83wx/wSbirZCCc4CuiyYdH8iu3f7RrBOCIvdmGLaTrkVETHUZI2tS9ZpBTScULuaP
 rWucQhHI2/ZxNw67ijr5GzOZ46Q/Zm2SiuToQ3D1i/04o26wKVfiZD+3ycbeWEoMEAWc
 lCqGLlGGkS+BH4+DeR2R258l0/ocKnSUebBkHHw4HcEiKvieSFe3rXxCV8AtDHQhZnJY
 0EJf5WPeABkqchaCtdEqLslRPJc9CO+gImwRgrwnLYBj8dW55vmIKIx0h1e5XbqyMWps
 FI1PifcVWYVSSeQJVGV1PllczAfegCJu6RCdeKnx1NdKpDZ4zlKXB0zxOLRzIdrW/0ix
 qFyA==
X-Gm-Message-State: AOJu0YxNM3HB5Ty4N2Sw/f8bt50fGblrZrooHd97JQ7tKL5HwbQyWsD+
 6tgDR8xT4uIJah5LaQKuHrUxPAqgfFtnXYwlz9zA2LpZ1ALfbyd9cATeQ3Vt1J1TFEzQh096A7u
 kaEEhGQ6d8g==
X-Gm-Gg: ASbGncuvcU/2PtR1X8KVpsTHNlbVwRRTl0J6n4uEB86sBa6+P/Pnzn8/wo6zSInfZDp
 LI/YunoG3/MAhtzTcjszQ/j6486ZCFEUyvWznQBT2xfjkZSfe8RNynKoTXDemyYY+aBFdW6pC+h
 wIf1wgYVd4q9wppUrlEqCJ8ICZYWdLlb9DKjc2VyLVXOdQ1IEi9eaBweHQ2h2E8s+pLD1f6pEbx
 8lRetYAUTF2ncVMGt9AkstwjEC8FEV6agZsQx7mW9Cxl2U3EIjkXoCzw9R2AuLHN1w0L2rhITNO
 AEoGpVbMviQ0WjYxupFjDdeVr6MB5f08eMcF6yazH2z3PMpmTgkNK6zxSI+XpQqu12HYqqRiJNk
 gyTXlLgTl22dyoz1IWdvPVA+JrXnJAdZjed0j8uXpmHNlKt5NeW4rLJhpiiV00OBiw9eWp7EEp7
 KeHtbWLx2UB0JzauwZBJE73Gc1DXJQ83l6akQ=
X-Google-Smtp-Source: AGHT+IH708eYU7HUaeAqWhnI4aTsxrVK+YKL+9hSWjickVluFlrAx3eKjUI0/MLg0LFWZNlhnRdMVg==
X-Received: by 2002:a05:600c:1394:b0:45d:d1a3:ba6a with SMTP id
 5b1f17b1804b1-46fa9b1706amr67712105e9.33.1760077122873; 
 Thu, 09 Oct 2025 23:18:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb4989601sm27988795e9.9.2025.10.09.23.18.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 23:18:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/6] hw/hppa: Convert type_init() -> DEFINE_TYPES()
Date: Fri, 10 Oct 2025 08:18:31 +0200
Message-ID: <20251010061836.45739-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010061836.45739-1-philmd@linaro.org>
References: <20251010061836.45739-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Prefer DEFINE_TYPES() macro over type_init() to register
multiple QOM types.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/machine.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index dacedc5409c..2ab5fcb471a 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -709,16 +709,6 @@ static void HP_B160L_machine_init_class_init(ObjectClass *oc, const void *data)
     nc->nmi_monitor_handler = hppa_nmi;
 }
 
-static const TypeInfo HP_B160L_machine_init_typeinfo = {
-    .name = MACHINE_TYPE_NAME("B160L"),
-    .parent = TYPE_MACHINE,
-    .class_init = HP_B160L_machine_init_class_init,
-    .interfaces = (const InterfaceInfo[]) {
-        { TYPE_NMI },
-        { }
-    },
-};
-
 static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
@@ -745,20 +735,24 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
     nc->nmi_monitor_handler = hppa_nmi;
 }
 
-static const TypeInfo HP_C3700_machine_init_typeinfo = {
-    .name = MACHINE_TYPE_NAME("C3700"),
-    .parent = TYPE_MACHINE,
-    .class_init = HP_C3700_machine_init_class_init,
-    .interfaces = (const InterfaceInfo[]) {
-        { TYPE_NMI },
-        { }
+static const TypeInfo hppa_machine_types[] = {
+    {
+        .name = MACHINE_TYPE_NAME("B160L"),
+        .parent = TYPE_MACHINE,
+        .class_init = HP_B160L_machine_init_class_init,
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_NMI },
+            { }
+        },
+    }, {
+        .name = MACHINE_TYPE_NAME("C3700"),
+        .parent = TYPE_MACHINE,
+        .class_init = HP_C3700_machine_init_class_init,
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_NMI },
+            { }
+        },
     },
 };
 
-static void hppa_machine_init_register_types(void)
-{
-    type_register_static(&HP_B160L_machine_init_typeinfo);
-    type_register_static(&HP_C3700_machine_init_typeinfo);
-}
-
-type_init(hppa_machine_init_register_types)
+DEFINE_TYPES(hppa_machine_types)
-- 
2.51.0


