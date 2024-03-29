Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A21FCD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 16:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqF2T-0001x7-Ba; Fri, 29 Mar 2024 12:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1rqDn2-0001kP-DY
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 11:05:08 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1rqDn0-0003Gq-BO
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 11:05:08 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-690cf6ecd3cso10636746d6.2
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 08:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1711724704; x=1712329504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzaR2tfkkvfJNYn7QAkCGmS8gAFONRxGzcSvNxNyFFc=;
 b=juX9a6QbBXXlGf4/6TJrfK9yuFLJjvlQuvC1Wwms2xtoE+crjh9qrR7tZkrqyao3rf
 +jSKsXJUmSLtGnai9/+WyqRfcgQn98a6S5/yP0zQrV32j1B/9f0Q4UcOcWqqS7gY80Mn
 VxEZRvAuTtSJBlQtkkXQ5aZEvntNPv2cxT7mCRTK5xOVjvq/3sMQkE5foISxz2i+VdMa
 sAxaGxNWqF8reAHSi68earoVS32v9TbkF3EfKkaAmInWESckNGfE2W0zJH39RdhZiEdl
 +iHIwXSQu4tdDLU7Pgiv0AuFmG7T5ZZyM3sjMIH39Z+b4Ts/nYCsidT0BGD/ZS/tZAp4
 t/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711724704; x=1712329504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yzaR2tfkkvfJNYn7QAkCGmS8gAFONRxGzcSvNxNyFFc=;
 b=cRN5CsTyT0flq4x9c8hju7lB+JgfrxehkQ5QFfPWfSEU0sKCNo/aBnbqAQON/cRrBo
 3H4xpndZ5TNYT5/4ajgKsKn8U9E276XCWROWPdl/NL1kWAOWQ2dC7In8PYnMEg3MpGiX
 hsnHf5MRGK0JGaz9pXQR5x4h4CVM0XV0+gurmkB9yBYgCLkWBcKVWwWoquKQhiCa115g
 PbaUSa8mdYBM/hAFvyDAkacQTIOZmKnd/CdWSlgMcsGIre17A7NzIdBdKTfgLh0+CUcj
 iAqGlmFG2GKtYFGWmDM9hOzZMIUAre64X7AvacTCTg9FXAzuWZzeWKus0NCOrMuQEwFP
 hbwA==
X-Gm-Message-State: AOJu0Ywt7YE9/1RSAzGTPDr8DHyicksiqOC3DH6clyrIYRClfJNy6GkH
 wGZgSYVbztoJwkjUJX7U++D5kEyj4y7DLezwu12b83NvAygmBYGxj83XbA2Act8S93XPWPK24NE
 5JnpHRumJFyDLWQlzEYx0gtGxova+07q+9mObRI4Z2SLYN9OOVCtOSEnruF1xBiC/s/LTTcOIZ8
 /zChUDGfnSYVfNodGJxRBGuzJlLBBh
X-Google-Smtp-Source: AGHT+IGD/ZMKtmWZNdTN9necnoN6PK4lMJEQtaBCs+gmngiizWN3p6Fe48dIjZTqUyojZT3ahOuQww==
X-Received: by 2002:a05:6214:5809:b0:696:9224:140e with SMTP id
 mk9-20020a056214580900b006969224140emr2749028qvb.39.1711724704303; 
 Fri, 29 Mar 2024 08:05:04 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a0562140c6500b006986c65f3d2sm1704418qvj.137.2024.03.29.08.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 08:05:03 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: Austin Clements <aclements@csail.mit.edu>,
 Geoffrey Thomas <geofft@ldpreload.com>, Don Porter <porter@cs.unc.edu>
Subject: [PATCH 1/1] e1000: Get debug flags from an environment variable
Date: Fri, 29 Mar 2024 11:04:50 -0400
Message-Id: <20240329150450.2843758-2-porter@cs.unc.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329150450.2843758-1-porter@cs.unc.edu>
References: <20240329150450.2843758-1-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=porter@cs.unc.edu; helo=mail-qv1-xf35.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 29 Mar 2024 12:25:08 -0400
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

From: Austin Clements <aclements@csail.mit.edu>

The E1000 debug messages are very useful for developing drivers, so
this introduces an E1000_DEBUG environment variable that lets the
debug flags be set without recompiling QEMU.

Signed-off-by: Austin Clements <aclements@csail.mit.edu>
[geofft@ldpreload.com: Rebased on top of 2.9.0]
Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
Signed-off-by: Don Porter <porter@cs.unc.edu>
---
 hw/net/e1000.c | 65 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 43f3a4a701..8d46225944 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -30,11 +30,14 @@
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
+#include "monitor/monitor.h"
 #include "net/eth.h"
 #include "net/net.h"
 #include "net/checksum.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
+#include "qapi/qmp/qerror.h"
+#include "qemu/error-report.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
 #include "qemu/range.h"
@@ -44,15 +47,19 @@
 #include "trace.h"
 #include "qom/object.h"
 
-/* #define E1000_DEBUG */
-
-#ifdef E1000_DEBUG
 enum {
     DEBUG_GENERAL,      DEBUG_IO,       DEBUG_MMIO,     DEBUG_INTERRUPT,
     DEBUG_RX,           DEBUG_TX,       DEBUG_MDIC,     DEBUG_EEPROM,
     DEBUG_UNKNOWN,      DEBUG_TXSUM,    DEBUG_TXERR,    DEBUG_RXERR,
     DEBUG_RXFILTER,     DEBUG_PHY,      DEBUG_NOTYET,
 };
+
+static const char *debugnames[] = {
+    "GENERAL",      "IO",       "MMIO",     "INTERRUPT",
+    "RX",           "TX",       "MDIC",     "EEPROM",
+    "UNKNOWN",      "TXSUM",    "TXERR",    "RXERR",
+    "RXFILTER",     "PHY",      "NOTYET",   NULL
+};
 #define DBGBIT(x)    (1<<DEBUG_##x)
 static int debugflags = DBGBIT(TXERR) | DBGBIT(GENERAL);
 
@@ -60,9 +67,6 @@ static int debugflags = DBGBIT(TXERR) | DBGBIT(GENERAL);
     if (debugflags & DBGBIT(what)) \
         fprintf(stderr, "e1000: " fmt, ## __VA_ARGS__); \
     } while (0)
-#else
-#define DBGOUT(what, fmt, ...) do {} while (0)
-#endif
 
 #define IOPORT_SIZE       0x40
 #define PNPMMIO_SIZE      0x20000
@@ -1779,3 +1783,52 @@ static void e1000_register_types(void)
 }
 
 type_init(e1000_register_types)
+
+static void e1000_init_debug(void)
+{
+    const char *e1000_debug;
+    const char *p, *p1;
+    const char **debugname;
+    int i;
+
+    e1000_debug = getenv("E1000_DEBUG");
+    if (!e1000_debug || !*e1000_debug) {
+        return;
+    }
+
+    if (strcmp(e1000_debug, "?") == 0) {
+        error_printf("E1000_DEBUG flags:\n");
+        for (debugname = debugnames; *debugname; debugname++) {
+            error_printf("%s\n", *debugname);
+        }
+        exit(0);
+    }
+
+    p = e1000_debug;
+    debugflags = 0;
+    for (p = e1000_debug; ; p = p1 + 1) {
+        p1 = strchr(p, ',');
+        if (!p1) {
+            p1 = p + strlen(p);
+        }
+        for (i = 0, debugname = debugnames; *debugname; i++, debugname++) {
+            if (strlen(*debugname) == p1 - p &&
+                strncasecmp(p, *debugname, p1 - p) == 0) {
+                debugflags |= 1 << i;
+                break;
+            }
+        }
+        if (!*debugname) {
+            error_report(QERR_INVALID_PARAMETER_VALUE, "E1000_DEBUG",
+                         "a comma-separated list of E1000 debug flags");
+            error_printf_unless_qmp(
+                "Try with argument '?' for a list.\n");
+            exit(1);
+        }
+        if (*p1 != ',') {
+            break;
+        }
+    }
+}
+
+type_init(e1000_init_debug)
-- 
2.25.1


