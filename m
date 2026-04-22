Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1772BFA1FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdl3-0002Jp-Ub; Wed, 22 Apr 2026 16:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdl1-00026d-Lu
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:01:11 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdkz-0002BW-Nu
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:01:11 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so4022485f8f.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888068; x=1777492868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9C3GmGqq4X3bcYct2EZbutIAPO9e+b3FqHWdpN1MU58=;
 b=LuM4tF34W5dmIDqoW6/cO8Do5v87d2ookZWTtDgzIZQdGsuwQ1YGXCxYGsVP72hjze
 9FFmfLk6SPTgkrWnTFTgRc4notm+TBm8w3O6L4aQQwdtGlZhJSomHjVbWPrCbhzUsV0g
 pD4tp0D8N8kR0bAZ45aA8aEY41e1HNscu9lj1us87UcwWvTUzeEtny+3uaWd+A70sLRt
 eTuX+opF8Dip6bbylIu6gdgwoAvMsNHWoQUCeyLGpOQiVCkrEFFQpDLZO+pRZdMP+QhM
 Eb+C/3M6rtT91a0m3vGU1/b7TfbJCzNXSfNrAZ3uhogcSNR49yc+1zSFDzJcGQIF5hOy
 2IOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888068; x=1777492868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9C3GmGqq4X3bcYct2EZbutIAPO9e+b3FqHWdpN1MU58=;
 b=K2CXuH7dhKu5n6bcGYzRtSjbbU3cdUfSim7y7c5I8HmZTursI9vaYIjb81LWL/fPKD
 rqS+14eAXhFgWVP6LNKHyCZ6uh01W3ZD4xmux1I9zrixOJrLRGCG7gghDB2vA0vqbeNG
 RCJW7AydUYxoA65Un+JJEzomyfxOtukN8jWg2yDj78iQ5bkeeUzlPPNPs4g8O2HnKP8t
 Fb+4c0xinM39HPOPP/lIXSSsL95u1E8AVx/huXo9AK1epb8V8Hr724tRoJWeAAFUbLAC
 ZzmeLg6cS6EA9d9MMDI/09Udd+lLtbAMm5GoJRCHOQucl5ZNkaH0e02CjK37E0TlPSmO
 IqBw==
X-Gm-Message-State: AOJu0YwawgMa/FWevFGlGAgjAxw7RvwerVU72ri0oM2MmK+gLtu5zNAa
 r/2QdNYFRoQ8SxzsNGtuYmks3cwEFsX8BbnL+jEiLFdkdkggh069RYxDA+kt6/TL/8L6aO6J/c7
 ecUaib+4=
X-Gm-Gg: AeBDiesN5Z3NgV9mSvT6/iRn4BvGq9879ln7FtrOXSIwnIQS5VkHUx0pgQ+dvjLl/3D
 dALq351GW68t5pqmXcMlRq5NvJV84S2ToXfBy6uxkIy0rHUTRl4MgHeII7wugPfo/yvAndExbkS
 uuDSN6Vm2bCQnqsRAKlaoZ+MueKTfg6iuk+Ke35QL/AgpR97Zv30eC+OEyEJTa84nyecTpzbOfB
 GQFZNyMHlfjkXr/zZ/GXUIVc/bmoMyfGeYmWxEegdLeCGpXgb4IW+8+Bbj+DPfD4bznujH0Diju
 W7QAywhHyPvKaOeTpN44wsHC8Bvw0Cg2ro5mOYan36D31kYVoZVGzaDlDsgWyVwQ4U6VU9OtKGb
 4gCNaH+34pum66mN4clCdMyw/6s2rgdrb/Brh9Ly2z969zYKvaHxFdar88+5NoqQPUIXmeUDmOJ
 Alxd3sl87mMvIzx1iYcfM3wSQVh8+Iq+iNl0ZAGadC2XWL+daXHTHfBbzLiDx/9oIKkj239/Ipo
 RGMcH5LAEE=
X-Received: by 2002:a5d:5d05:0:b0:43f:e22d:9a73 with SMTP id
 ffacd0b85a97d-43fe3db3cbfmr36077530f8f.2.1776888067735; 
 Wed, 22 Apr 2026 13:01:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e46471sm46426753f8f.28.2026.04.22.13.01.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:01:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/48] qom: Declare GlobalProperty structure in
 'qom/compat-properties.h'
Date: Wed, 22 Apr 2026 21:57:26 +0200
Message-ID: <20260422195746.88865-29-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

While GlobalProperty is expected to only be used by QDev board
layer, it is used by the lower QOM API, so define it in the
qom/ namespace. This helps to build binary which use QOM but
don't need the QDev layer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20260325151728.45378-4-philmd@linaro.org>
---
 include/hw/core/boards.h          |  1 +
 include/hw/core/qdev-properties.h |  1 +
 include/hw/core/qdev.h            | 17 ----------------
 include/qom/compat-properties.h   | 32 +++++++++++++++++++++++++++++++
 qom/object.c                      |  2 +-
 5 files changed, 35 insertions(+), 18 deletions(-)
 create mode 100644 include/qom/compat-properties.h

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 0ac7e17ef7a..3f9a7127ad9 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -8,6 +8,7 @@
 #include "system/blockdev.h"
 #include "qapi/qapi-types-machine.h"
 #include "qemu/module.h"
+#include "qom/compat-properties.h"
 #include "qom/object.h"
 #include "hw/core/cpu.h"
 #include "hw/core/resettable.h"
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index d8745d4c65f..17543957a6c 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -1,6 +1,7 @@
 #ifndef QEMU_QDEV_PROPERTIES_H
 #define QEMU_QDEV_PROPERTIES_H
 
+#include "qom/compat-properties.h"
 #include "hw/core/qdev.h"
 
 /**
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 778617787c7..337d69ea2c3 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -404,23 +404,6 @@ struct BusState {
     ResettableState reset;
 };
 
-/**
- * typedef GlobalProperty - a global property type
- *
- * @used: Set to true if property was used when initializing a device.
- * @optional: If set to true, GlobalProperty will be skipped without errors
- *            if the property doesn't exist.
- *
- * An error is fatal for non-hotplugged devices, when the global is applied.
- */
-typedef struct GlobalProperty {
-    const char *driver;
-    const char *property;
-    const char *value;
-    bool used;
-    bool optional;
-} GlobalProperty;
-
 /*** Board API.  This should go away once we have a machine config file.  ***/
 
 /**
diff --git a/include/qom/compat-properties.h b/include/qom/compat-properties.h
new file mode 100644
index 00000000000..6e44aabc26b
--- /dev/null
+++ b/include/qom/compat-properties.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU Object Model
+ *
+ * Copyright IBM, Corp. 2011
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_COMPAT_PROPERTIES_H
+#define QEMU_COMPAT_PROPERTIES_H
+
+/**
+ * typedef GlobalProperty - a global property type
+ *
+ * @used: Set to true if property was used when initializing a device.
+ * @optional: If set to true, GlobalProperty will be skipped without errors
+ *            if the property doesn't exist.
+ *
+ * An error is fatal for non-hotplugged devices, when the global is applied.
+ */
+typedef struct GlobalProperty {
+    const char *driver;
+    const char *property;
+    const char *value;
+    bool used;
+    bool optional;
+} GlobalProperty;
+
+#endif
diff --git a/qom/object.c b/qom/object.c
index ff8ede8a328..838b1d2b225 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -11,8 +11,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/core/qdev.h"
 #include "qapi/error.h"
+#include "qom/compat-properties.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
 #include "qemu/cutils.h"
-- 
2.53.0


