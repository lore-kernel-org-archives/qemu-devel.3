Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AC5CF6493
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 08:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suTHY-00008C-Ok; Sat, 28 Sep 2024 04:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suTHW-0008So-Hq
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 04:58:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suTHT-0002IA-R2
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 04:58:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42ca4e0299eso23834685e9.2
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 01:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1727513902; x=1728118702;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emwXegwM6KYIW65+ci8KhXuSLLm423iSwF1B6mw4630=;
 b=1sfp+CL/g/+VkSzEQGRev3AFaYxZfjMq1CJijVh0cxtsqzgvINfzWOfbtQ+TT/jmfv
 zRTQNJitI2fJqtYTld/ukvszKDthNhqql79E+poP7Q0JZZHwktAfiWUtgRyee4mGcLT6
 gkxoHuprk4RoV/YqdHaG3REuZkfGApkDoS9ZXXMZe99w20hDl/ZPqRnmkvPBUnArlDAP
 HmF9aurIYkId4/p9FIv+eGia6GBYXO6afHI7h184EtYU/+RfjVc6+YKa97MQYvUaqd7t
 8m2+3Lfetav2CLtCyo00seW6UuNPMMCv2dc3Pc9zij6r59xbG6Enx0DpFeXwnJedFSHG
 VtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727513902; x=1728118702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=emwXegwM6KYIW65+ci8KhXuSLLm423iSwF1B6mw4630=;
 b=Ps/bHlJAXz8rqoPvOOOu2hG1qlscPfODkMxpvGjEp+fGxBtzLrkz1rhmAYfmcmypDu
 npPncjDWLON6FxrkKq96z0be6S3Pi8FmSKcAGXsXSa3kTZwj3JHryYyxCpdhcGYNRj6H
 xoHKE71eUWlpcZDAMlQojSH6anVdo2Y65HJq42Wm0TRSFfgVsmWFbJ3gluX2yLH5lv5F
 7NL1UkIvu21KT6+Fl2MRCD9NTQMIA9aeQdC03P3CCnEBR6bIDdjwVODcqOt3ak8sE1jY
 G6bIciBaHI0gFUA/Yfups0cnWLAfXVvM4M2rG4fR367FYdoF4gVKlOSpxaspRwcFX3uN
 fXQw==
X-Gm-Message-State: AOJu0Yw+vcQtzWvoJH/O9QbHzxwOTbehV5hdVP0bYNI90n1U0S+AgJKg
 kIUiRh1pdEY1lzpVVh2vFT7mxjWSlqtdS3tVISWUv/Wvmk48MXkE+e2cYaK+Uq9+46HJZYOeBk0
 tjQ==
X-Google-Smtp-Source: AGHT+IGXZBOV88uGQzmNeyQjuqZ1N5iL/ed4zCI6+RTC9fgfOp2UZt4ohgSuxmg97vD1wvnjItC9Ig==
X-Received: by 2002:a05:600c:4f82:b0:428:1310:b6b5 with SMTP id
 5b1f17b1804b1-42f5849c3demr41288325e9.34.1727513902024; 
 Sat, 28 Sep 2024 01:58:22 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bb8:2ae:e42d:7dbb:76ba:120d:8a28])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd57423afsm4313167f8f.90.2024.09.28.01.58.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 28 Sep 2024 01:58:21 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 03/14] ui/cocoa: Adds non-app runloop on main thread mode
Date: Sat, 28 Sep 2024 10:57:16 +0200
Message-Id: <20240928085727.56883-4-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240928085727.56883-1-phil@philjordan.eu>
References: <20240928085727.56883-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::334;
 envelope-from=phil@philjordan.eu; helo=mail-wm1-x334.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

Various system frameworks on macOS and other Apple platforms
require a main runloop to be processing events on the process’s
main thread. The Cocoa UI’s requirement to run the process as a
Cocoa application automatically enables this runloop, but it
can be useful to have the runloop handling events even without
the Cocoa UI active.

This change adds a non-app runloop mode to the cocoa_main
function. This can be requested by other code, while the Cocoa UI
additionally enables app mode. This arrangement ensures there is
only one qemu_main function switcheroo, and the Cocoa UI’s app
mode requirement and other subsystems’ runloop requests don’t
conflict with each other.

The main runloop is required for the AppleGFX PV graphics device,
so the runloop request call has been added to its initialisation.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx.m |  3 +++
 include/qemu-main.h    |  2 ++
 ui/cocoa.m             | 15 +++++++++++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 837300f9cd4..6ef1048d93d 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -14,6 +14,7 @@
 
 #include "apple-gfx.h"
 #include "trace.h"
+#include "qemu-main.h"
 #include "qemu/main-loop.h"
 #include "ui/console.h"
 #include "monitor/monitor.h"
@@ -299,6 +300,8 @@ void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name)
             error_report_err(local_err);
         }
     }
+
+    cocoa_enable_runloop_on_main_thread();
 }
 
 static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
diff --git a/include/qemu-main.h b/include/qemu-main.h
index 940960a7dbc..da4516e69eb 100644
--- a/include/qemu-main.h
+++ b/include/qemu-main.h
@@ -8,4 +8,6 @@
 int qemu_default_main(void);
 extern int (*qemu_main)(void);
 
+void cocoa_enable_runloop_on_main_thread(void);
+
 #endif /* QEMU_MAIN_H */
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 4c2dd335323..40f65d7a45d 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -2028,6 +2028,7 @@ static void cocoa_clipboard_request(QemuClipboardInfo *info,
     exit(status);
 }
 
+static bool run_as_cocoa_app = false;
 static int cocoa_main(void)
 {
     QemuThread thread;
@@ -2040,7 +2041,11 @@ static int cocoa_main(void)
 
     // Start the main event loop
     COCOA_DEBUG("Main thread: entering OSX run loop\n");
-    [NSApp run];
+    if (run_as_cocoa_app) {
+        [NSApp run];
+    } else {
+        CFRunLoopRun();
+    }
     COCOA_DEBUG("Main thread: left OSX run loop, which should never happen\n");
 
     abort();
@@ -2114,13 +2119,19 @@ static void cocoa_cursor_define(DisplayChangeListener *dcl, QEMUCursor *cursor)
     });
 }
 
+void cocoa_enable_runloop_on_main_thread(void)
+{
+    qemu_main = cocoa_main;
+}
+
 static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
 
     COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
 
-    qemu_main = cocoa_main;
+    run_as_cocoa_app = true;
+    cocoa_enable_runloop_on_main_thread();
 
     // Pull this console process up to being a fully-fledged graphical
     // app with a menubar and Dock icon
-- 
2.39.3 (Apple Git-145)


