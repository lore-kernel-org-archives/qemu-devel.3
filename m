Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2999C2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbLC-0006OZ-3k; Tue, 18 Jun 2024 12:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbLA-0006OF-NW
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:05:48 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbL8-0007jD-Gq
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:05:48 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57d05e0017aso264987a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726744; x=1719331544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hythfOpvKdnQtXG8QgrEpQziqfs8Kk/FNjGJNS+WjGI=;
 b=BNjXYHErjlqlm3ifAFGeoB3OFnJD5OvpgzqL6CSiKutObcmT5dKCjgjfQMBsegAM4L
 awI4NYnTlgrgbHNOW5oTOxojpQ1By29C8l4DzRp0ic7LnEMEUFSV05MLl00u3PrUxm7b
 YE9YZiwl2N4Oj2UvZ8jsyx2qq/NIZT/y7J874013oTMsNhcZ9dcRuSSvBp2TOZHziNPZ
 tvbnNxvgF5QW8+VK7gM8KndHHlxoNfxFAePODbBSfTO7ryGbSocXX/wAR1psHNc42fu+
 g5uoGRYDclaQIAxPKjRR8PwVAamkKEqd1qnf/JuFol+ajJFCSsR0U6FeQnVO5ZMLTTUv
 F3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726744; x=1719331544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hythfOpvKdnQtXG8QgrEpQziqfs8Kk/FNjGJNS+WjGI=;
 b=Zb5BDUHq07TEy5weRxIY7Q/RviJcvETKqRHUnil6X8I1TbQ5KAAAwq+d+POSoIsBR1
 M+MU/QjkpPu1h/3Jq/rqwLL+zpfySv36RqASxysBlTxwH5+xArc7R6pRxdandobhf0R7
 mxmHJ+GbMQnTks0/QUQWh7sU+lcNOiSH5aCBG7aD3/SA28NH3m0Axub1/UnD+pqRhTGt
 o0Jcb9XVeV89ufVGVcjEnJXcx95C1kdUwH73BBs2DBtha7IeAsfHcyCHJYJxwAKQBMao
 XqkuJu/Ex+NpYTRz16MGlhoVNyzwfpTNA/CrI/TcBxSJ6lyjG5xeB/GIckhVK7YWLKPP
 a6qA==
X-Gm-Message-State: AOJu0YzS2OACu2wQ97OfnI6aoVN1D2Q7ZzMx5q1Xr63WUFqjKCyZTgJb
 TUiLCz9vmGe4PKqcD308eMcqaA8boW6yApzxZUQRy8kkn7+BR5AQeR2XU2Voz+/pwf7nOTH9zsQ
 P
X-Google-Smtp-Source: AGHT+IEspRNMV9GWzp1uzSiWH5Clmi5MoCQdX+bcNbpP6GOl8JXh9iUQjYGpsnS7eW3o8HD92O3V3g==
X-Received: by 2002:a50:a402:0:b0:57c:d4e9:4a03 with SMTP id
 4fb4d7f45d1cf-57cd4e94b6emr3841204a12.41.1718726744386; 
 Tue, 18 Jun 2024 09:05:44 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104a26sm14440062f8f.97.2024.06.18.09.05.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:05:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 52/76] hw/intc: Introduce x-query-interrupt-controllers QMP
 command
Date: Tue, 18 Jun 2024 18:00:14 +0200
Message-ID: <20240618160039.36108-53-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a counterpart to the HMP "info pic" command. It is being
added with an "x-" prefix because this QMP command is intended as an
adhoc debugging tool and will thus not be modelled in QAPI as fully
structured data, nor will it have long term guaranteed stability.
The existing HMP command is rewritten to call the QMP command.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20240610063518.50680-3-philmd@linaro.org>
---
 qapi/machine.json          | 17 +++++++++++++++++
 hw/core/machine-qmp-cmds.c | 29 +++++++++++++++++++++++++++++
 monitor/hmp-cmds.c         | 33 ---------------------------------
 hmp-commands-info.hx       |  2 +-
 4 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 453feb9347..2fd3e9c3d5 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1864,3 +1864,20 @@
 { 'command': 'dumpdtb',
   'data': { 'filename': 'str' },
   'if': 'CONFIG_FDT' }
+
+##
+# @x-query-interrupt-controllers:
+#
+# Query information on interrupt controller devices
+#
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
+# Returns: Interrupt controller devices information
+#
+# Since: 9.1
+##
+{ 'command': 'x-query-interrupt-controllers',
+  'returns': 'HumanReadableText',
+  'features': [ 'unstable' ]}
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 5972100b1f..130217da8f 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -361,6 +361,35 @@ HumanReadableText *qmp_x_query_irq(Error **errp)
     return human_readable_text_from_str(buf);
 }
 
+static int qmp_x_query_intc_foreach(Object *obj, void *opaque)
+{
+    InterruptStatsProvider *intc;
+    InterruptStatsProviderClass *k;
+    GString *buf = opaque;
+
+    if (object_dynamic_cast(obj, TYPE_INTERRUPT_STATS_PROVIDER)) {
+        intc = INTERRUPT_STATS_PROVIDER(obj);
+        k = INTERRUPT_STATS_PROVIDER_GET_CLASS(obj);
+        if (k->print_info) {
+            k->print_info(intc, buf);
+        } else {
+            g_string_append_printf(buf,
+                                   "Interrupt controller information not available for %s.\n",
+                                   object_get_typename(obj));
+        }
+    }
+
+    return 0;
+}
+
+HumanReadableText *qmp_x_query_interrupt_controllers(Error **errp)
+{
+    g_autoptr(GString) buf = g_string_new("");
+    object_child_foreach_recursive(object_get_root(),
+                                   qmp_x_query_intc_foreach, buf);
+    return human_readable_text_from_str(buf);
+}
+
 GuidInfo *qmp_query_vm_generation_id(Error **errp)
 {
     GuidInfo *info;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index fbff7fdb57..45ee3a9e1f 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -25,9 +25,7 @@
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/type-helpers.h"
 #include "qemu/cutils.h"
-#include "hw/intc/intc.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
 
@@ -83,37 +81,6 @@ void hmp_info_version(Monitor *mon, const QDict *qdict)
     qapi_free_VersionInfo(info);
 }
 
-static int hmp_info_pic_foreach(Object *obj, void *opaque)
-{
-    InterruptStatsProvider *intc;
-    InterruptStatsProviderClass *k;
-    Monitor *mon = opaque;
-
-    if (object_dynamic_cast(obj, TYPE_INTERRUPT_STATS_PROVIDER)) {
-        intc = INTERRUPT_STATS_PROVIDER(obj);
-        k = INTERRUPT_STATS_PROVIDER_GET_CLASS(obj);
-        if (k->print_info) {
-            g_autoptr(GString) buf = g_string_new("");
-            g_autoptr(HumanReadableText) info = NULL;
-
-            k->print_info(intc, buf);
-            info = human_readable_text_from_str(buf);
-            monitor_puts(mon, info->human_readable_text);
-        } else {
-            monitor_printf(mon, "Interrupt controller information not available for %s.\n",
-                           object_get_typename(obj));
-        }
-    }
-
-    return 0;
-}
-
-void hmp_info_pic(Monitor *mon, const QDict *qdict)
-{
-    object_child_foreach_recursive(object_get_root(),
-                                   hmp_info_pic_foreach, mon);
-}
-
 void hmp_quit(Monitor *mon, const QDict *qdict)
 {
     monitor_suspend(mon);
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 20a9835ea8..cfd4ad5651 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -174,7 +174,7 @@ ERST
         .args_type  = "",
         .params     = "",
         .help       = "show PIC state",
-        .cmd        = hmp_info_pic,
+        .cmd_info_hrt = qmp_x_query_interrupt_controllers,
     },
 
 SRST
-- 
2.41.0


