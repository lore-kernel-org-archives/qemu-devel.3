Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2343FC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5NpA-0001xc-Oa; Fri, 10 May 2024 06:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Noy-0001ob-75
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:49:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Nou-0001Wv-MD
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:49:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41fd5dc04f0so9555255e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 03:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715338183; x=1715942983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6xsQqOmikZFwXbyDk6ZpqqheWDHvbw4l/2JG+MVzRA=;
 b=ByLvpVQETrEL0LhjnwyS/H2dH8apyGyxayszlwbsr5shLr6TWCJa1RlAJLncUCAP1d
 SEYGbxY7M9wxz7T46ArOORat3VSfk+PqbRGAXap8UERMC50GjMAfCbpZOwlufTQGRmsQ
 HN7JejWk3VIpoFLERcO1ibwPKb905O1rzWgZ3KFJzdBK4klNnnrgeoA8BqPCK2Bxt09/
 r9PT6cWcryce2vZc/UNJRODsRPns8VbrnQWs3Q+1vBPq67K3npKtKtWm2WnINTGnK+E9
 VV0GBn0stE0iSfmK0sjfqCFrGrDXplhPdK5rWAf3Hpy91VglOpjb5nZ2vkQBdntlyaQY
 FSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715338183; x=1715942983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6xsQqOmikZFwXbyDk6ZpqqheWDHvbw4l/2JG+MVzRA=;
 b=b8DfjKhYlxJgQafsfQHcBhwrxVNFFrlkwhoz9TNHkByZ12Pq3XasdajAAy69VOlRCL
 5aO0KzFRGewAzwbp8D1vNoJBhUnFzn+7XSbSzun+JMOXA3pXrKI/srqlYgmkXqPF+Ojr
 pIBu0k/SkQrG/i81cQnd2j5UO316kszFIuJxmp0G9aFUVum9XhLxEGu9YH8+Eqjrobxu
 quEeTmmB//tWER1BvdRQFCIYehUJdbJDdcH/D4ZbjbrhfSVBjbnXlpKfiyveV/Hu60p2
 Oz9CfmK2g7J+h8MZ1lW64AnICoGs1KPvIm3TSTBtTobPfqfYEdPbJNVzn2fMzxzIHI7c
 IGEw==
X-Gm-Message-State: AOJu0Yxu1U4ra6bPqOu0BY/5rWRQYCe0Z9BQtYBp7vYsv6EEdE54fxZU
 XQwmENs+MvlppOPVyv8xaML1ql+KflJJnIKQ5EH4HYyNy1y6yOVJr98wydTtobaU3TeRfpwuA2e
 +
X-Google-Smtp-Source: AGHT+IH3RnmZXXuxt2IBSPxIon61ivul84ejF6Ul9PK/puKcX3RJUgwhud+k6udV+bWCsrG6K2uZGg==
X-Received: by 2002:a05:600c:490a:b0:41f:dcdd:5631 with SMTP id
 5b1f17b1804b1-41feaa30cfamr23776095e9.13.1715338182860; 
 Fri, 10 May 2024 03:49:42 -0700 (PDT)
Received: from m1x-phil.lan (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baacf52sm4278278f8f.87.2024.05.10.03.49.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 May 2024 03:49:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/7] hw/xen: initialize legacy backends from xen_bus_init()
Date: Fri, 10 May 2024 12:49:06 +0200
Message-ID: <20240510104908.76908-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240510104908.76908-1-philmd@linaro.org>
References: <20240510104908.76908-1-philmd@linaro.org>
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

From: Paolo Bonzini <pbonzini@redhat.com>

Prepare for moving the calls to xen_be_register() under the
control of xen_bus_init(), using the normal xen_backend_init()
method that is used by the "modern" backends.

This requires the xenstore global variable to be initialized,
which is done by xen_be_init().  To ensure that everything is
ready at the time the xen_backend_init() functions are called,
remove the xen_be_init() function from all the boards and
place it directly in xen_bus_init().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240509170044.190795-7-pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c              | 1 -
 hw/xen/xen-bus.c          | 4 ++++
 hw/xen/xen-hvm-common.c   | 2 --
 hw/xenpv/xen_machine_pv.c | 5 +----
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 505ea750f4..19f21953b4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1250,7 +1250,6 @@ void pc_basic_device_init(struct PCMachineState *pcms,
             pci_create_simple(pcms->pcibus, -1, "xen-platform");
         }
         xen_bus_init();
-        xen_be_init();
     }
 #endif
 
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index fb82cc33e4..95b207ac8b 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -13,6 +13,7 @@
 #include "hw/sysbus.h"
 #include "hw/xen/xen.h"
 #include "hw/xen/xen-backend.h"
+#include "hw/xen/xen-legacy-backend.h" /* xen_be_init() */
 #include "hw/xen/xen-bus.h"
 #include "hw/xen/xen-bus-helper.h"
 #include "monitor/monitor.h"
@@ -329,6 +330,9 @@ static void xen_bus_realize(BusState *bus, Error **errp)
         goto fail;
     }
 
+    /* Initialize legacy backend core & drivers */
+    xen_be_init();
+
     if (xs_node_scanf(xenbus->xsh, XBT_NULL, "", /* domain root node */
                       "domid", NULL, "%u", &domid) == 1) {
         xenbus->backend_id = domid;
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 1627da7398..2d1b032121 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -872,8 +872,6 @@ void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
 
     xen_bus_init();
 
-    xen_be_init();
-
     return;
 
 err:
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index 1130d1a147..b500ce0989 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -34,8 +34,7 @@ static void xen_init_pv(MachineState *machine)
 {
     setup_xen_backend_ops();
 
-    /* Initialize backend core & drivers */
-    xen_be_init();
+    xen_bus_init();
 
     switch (xen_mode) {
     case XEN_ATTACH:
@@ -60,8 +59,6 @@ static void xen_init_pv(MachineState *machine)
         vga_interface_created = true;
     }
 
-    xen_bus_init();
-
     /* config cleanup hook */
     atexit(xen_config_cleanup);
 }
-- 
2.41.0


