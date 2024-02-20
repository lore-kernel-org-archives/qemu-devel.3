Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0B0C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcRkJ-0005Fd-C3; Tue, 20 Feb 2024 10:09:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcRk3-00054h-83
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:09:07 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcRk1-0003ox-4U
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:09:06 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40fd72f7125so45872665e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 07:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708441742; x=1709046542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKFNf1gtsBliHsHbsrrbkJOq0Jz4DmD1IjvRvgcWfg0=;
 b=fexEQGh9XEL8qUstAtojl0IVHEEyKJbK0ajvhXPcORIQZGdbcZT4FKZ3suIauvIwBY
 K4NYx1FZkh7FDp16IgqWPGYN6idxtqOudJbhA+81O0W8vVAuDbaNKwrfOiTyLioGDtQD
 0zOvHyEz6a09gDPeKH0WPMnzxdoBx1qfOw/hGiEZfpOiIM2pp0cJteyFmedWfYUX+B0O
 k9O6goS6wPzhtadfvgghHAYbP5C2u0XitAmUcobPG+YhVMeD8Wms8xLXSYj2weQomgoO
 G9Vxpjn7mBi4Rnj6V7j2yTRKOJqkzzl1DTiRdJeBhGoPwtWMHxpdp7ZWqK7J37MjXwKy
 wDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708441742; x=1709046542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKFNf1gtsBliHsHbsrrbkJOq0Jz4DmD1IjvRvgcWfg0=;
 b=BLZsGQTJ3ikpl4u6/4NNoMF0ZNQzJPltFaCqNHXSJZgOzm2d4PTCf2+T3ko/JkoCP1
 h0SaBYSjQFn+B1U112dG7jbUD38IOpKU+zj74Qg6i9Moundwlt0g5wfj0ygXJOmOdIP9
 Sp2cW9Fp5jz1TloHsJlX1zM3CXFoYfewMauXOwiEmBypTW83Yk6SnhGDCu+KlVMaTCsx
 OIm/mFkKOlsnJVUqtw/fM90VGW3z+p0Pj+E6vTTronNCXf6d4JfJHj2EaJ0rHMdNgQTW
 j3xYUC/HgfFog+RjReSSdT9UGuHH1nqKTA3QhJeDVncQBUxRssnVWfJYJGOG63ohIMGi
 106A==
X-Gm-Message-State: AOJu0Yxjf0rzb4JBvjtQlO3UWjuS1vKll3ZAxL14LsH9iu94/QZ8XXLF
 YPgF8v5686TUBppxS9R20M/UXj6MVUsFtqGnRMWlLsMuKBRcvL6ljuNWvjkM0HM+w0VWfycuQba
 t
X-Google-Smtp-Source: AGHT+IEvJLQjlgEv1wMgwFYDdLZHb6BoK1P485HLbKH/RyLiXGF/VIzX3Bc1qGZtgaPoLLXMdh6e0w==
X-Received: by 2002:a05:600c:198a:b0:412:6d66:c88 with SMTP id
 t10-20020a05600c198a00b004126d660c88mr1686022wmq.23.1708441742437; 
 Tue, 20 Feb 2024 07:09:02 -0800 (PST)
Received: from m1x-phil.lan (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 r13-20020a05600c35cd00b00410c7912c6esm15202117wmq.14.2024.02.20.07.09.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Feb 2024 07:09:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Corey Minyard <minyard@acm.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 4/4] hw/nmi: Remove @cpu_index argument from nmi_trigger()
Date: Tue, 20 Feb 2024 16:08:33 +0100
Message-ID: <20240220150833.13674-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240220150833.13674-1-philmd@linaro.org>
References: <20240220150833.13674-1-philmd@linaro.org>
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

nmi_monitor_handle() is not related to the monitor,
rename it as nmi_trigger(). Return boolean value
indicating success / failure. The 'cpu_index' argument
is not used, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/nmi.h       | 13 ++++++++++++-
 hw/core/nmi.c          |  9 ++++-----
 hw/ipmi/ipmi.c         |  3 +--
 hw/watchdog/watchdog.c |  2 +-
 system/cpus.c          |  2 +-
 5 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/hw/nmi.h b/include/hw/nmi.h
index c70db941c9..32b27067f2 100644
--- a/include/hw/nmi.h
+++ b/include/hw/nmi.h
@@ -49,6 +49,17 @@ struct NMIClass {
     bool (*nmi_handler)(NMIState *n, Error **errp);
 };
 
-void nmi_monitor_handle(int cpu_index, Error **errp);
+/**
+ * nmi_trigger: Trigger a NMI.
+ *
+ * @errp: pointer to error object
+ *
+ * Iterate over all objects implementing the TYPE_NMI interface
+ * and deliver NMI to them.
+ *
+ * On success, return %true.
+ * On failure, store an error through @errp and return %false.
+ */
+bool nmi_trigger(Error **errp);
 
 #endif /* NMI_H */
diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index 409164d445..a740f39c98 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -22,11 +22,8 @@
 #include "qemu/osdep.h"
 #include "hw/nmi.h"
 #include "qapi/error.h"
-#include "qemu/module.h"
-#include "monitor/monitor.h"
 
 struct do_nmi_s {
-    int cpu_index;
     Error *err;
     bool handled;
 };
@@ -53,19 +50,21 @@ static int nmi_children(Object *o, struct do_nmi_s *ns)
     return object_child_foreach_recursive(o, do_nmi, ns);
 }
 
-void nmi_monitor_handle(int cpu_index, Error **errp)
+bool nmi_trigger(Error **errp)
 {
     struct do_nmi_s ns = {
-        .cpu_index = cpu_index,
         .err = NULL,
         .handled = false
     };
 
     if (nmi_children(object_get_root(), &ns)) {
         error_propagate(errp, ns.err);
+        return false;
     } else if (!ns.handled) {
         error_setg(errp, "machine does not provide NMIs");
+        return false;
     }
+    return true;
 }
 
 static const TypeInfo nmi_info = {
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index bbb07b151e..45e36a7492 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -59,8 +59,7 @@ static int ipmi_do_hw_op(IPMIInterface *s, enum ipmi_op op, int checkonly)
         if (checkonly) {
             return 0;
         }
-        /* We don't care what CPU we use. */
-        nmi_monitor_handle(0, NULL);
+        nmi_trigger(NULL);
         return 0;
 
     case IPMI_SHUTDOWN_VIA_ACPI_OVERTEMP:
diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 955046161b..d324c761aa 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -81,7 +81,7 @@ void watchdog_perform_action(void)
 
     case WATCHDOG_ACTION_INJECT_NMI:
         qapi_event_send_watchdog(WATCHDOG_ACTION_INJECT_NMI);
-        nmi_monitor_handle(0, NULL);
+        nmi_trigger(NULL);
         break;
 
     default:
diff --git a/system/cpus.c b/system/cpus.c
index 68d161d96b..f11ee3d404 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -856,6 +856,6 @@ exit:
 
 void qmp_inject_nmi(Error **errp)
 {
-    nmi_monitor_handle(monitor_get_cpu_index(monitor_cur()), errp);
+    nmi_trigger(errp);
 }
 
-- 
2.41.0


