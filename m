Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F7606A33F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dLp9gDZT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJI7-0002Ji-7x; Tue, 17 Nov 2026 08:32:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTJI0-0002H2-Gf
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:32:02 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTJHv-0000TV-Tf
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:31:59 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b571979178so7141280a12.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 05:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794922313; x=1795527113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=n5J86D86hRkkGGTVZsvRC5R3HIR9PRKOlDUYg06iqH8=;
 b=dLp9gDZT7myrfQQdgwNA2PQeycZHUGY2t4FBEaJaPWCu2oextuPAr3tgBgCJNUFNbn
 5jQF5PZesG7s9nz6SyzQuS2YzXOt05Vwb83vcZw+ezmtuQ76UmvLzozEblwh7+UIcKr8
 svu9Myn+WoqOu6v+jXxU9h4/Oz5AgNslNndUM6GMF5mLGbmXB/Xo2lQ4ZTHIDiWlw/1p
 JVuBFRO2nB/y8AhyUW63TLiAszPpE83+HB2eHi4rQcwnkur0ykPY4DidDnMLWr4uuuiU
 otDq1F4o7OAXczJ4xiU2dDQD4U4utlpHw/CXDfLEBI4v57pazFHioX41Zn8zgassvq6P
 +JWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794922313; x=1795527113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=n5J86D86hRkkGGTVZsvRC5R3HIR9PRKOlDUYg06iqH8=;
 b=ZzELEflrjW7P2egVxS3aKUPiBTmSfa6cwArnMYVWqFN1dvMScVaaaHst5IhaZxpoeH
 ugCM1vU3NCTaxdLxM48VWgwyNqXk92EfJx+gAa5RYJvG6ibRQd9VA0/PZo/qtWYRuzFM
 RPg8XACplvDbKIUP6id7iwSZDZ0nsiVRJJNkWJ/zVItwRbujjjojcXp3ofstkB+TpJtA
 HSHD6bLYviz0m5gj02io2iS2eonjeGqy+oCPBL33uQxk+cAoYp2fVPrjJpDcq4pYVk/M
 AgzjaCrjif1d9ZJg+Fm2IhCSQPwLIfnJ/Gu40+fESfr/OGR5Fwxi6fPGLMde++BEGcQC
 9TSA==
X-Gm-Message-State: APuU4Z9mHY8w7h/egz6JRPIlCC2jS/ESwu1FeI3xN5YXMRNm+5sqUU7O
 10+mZ1wA/+5jQTusW+lUryOBo37OHWSKugjiIDnuebDpPMM0cWEFm2XXTO01dHJfORq3zygvOkC
 rqxzwzEA=
X-Gm-Gg: AYBFou2thcGp0LoZJyM6V5+eJXfB3AlW84Bg9/RBY3z35AwEBUzrTt++RFpVjm2pUpm
 fVFS6HCASd+aKBiUUfqBxLLkubD0ZGOs4lvbNueq5hQJ7FoqjUhviQKWfJ7w06O8EvQV2+r3UYn
 LQkd0p+fXgSQ/thPNHGaiglp2+6eD9NJzt5eRnvptx8PZXaLvRMfAscoz39OonbMWIZSxSPxlj9
 mtndHgKMQHsc8LI6Kre+ccDFGf2ePT/RfhHhrOqn6GKIlHXNMZ0J7jrv11zTns2MZq2PfcVkCss
 vssABSlZO5S6UlOrXl2IahzUIxLOVhEj8GugYblTayps2NvLpSyF9XXxnvr8L/lULqExpWoeJFj
 zhXN/Z7WFesoaeZY0BjmJZc1Arz8jc094+tJRe9+O3lBlWD46VBIJuF0RoS+43OLmQnJlBEnkoi
 bzXAwbFT8QeV1R0oSJR+cBYU1lQKPT4DWNUJ8MYuXezULl50sBpemn4QyRlO++JNfbzm8q8cUa2
 zhK46rqlSUbeZEJbk3AlyLERyRbcuzIYe1E7C6nlo/KQQdZaN1OY5PhVegxtUxo2bg8uEg7UcGN
 VOBSsmmQRNts78mYMSH8lEsgcy9Exvh1YqZVY+I6wE5JHDqf92BcnP7djByJxPJs7rg9cMWry9C
 gzaNkHYerMWpzQG8xudTsR/+OLs756r71WQ==
X-Received: by 2002:a05:6402:1e8f:b0:6b8:5823:1ccf with SMTP id
 4fb4d7f45d1cf-6b858231d4emr2806821a12.28.1794922313111; 
 Tue, 17 Nov 2026 05:31:53 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c8a77sm28516886f8f.49.2026.11.17.05.31.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 05:31:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/8] Revert "include: introduce qemu/version.h"
Date: Tue, 17 Nov 2026 13:31:43 +0000
Message-ID: <20261117133149.2108068-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117133149.2108068-1-peter.maydell@linaro.org>
References: <20261117133149.2108068-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This reverts commit fc35f24387703da027c242ff17382b89ed5a269f.

This commit was made as a pre-requisite for ab78ac76f44a124; now
we've reverted that, revert this one as well so we return to the
previous version header setup.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20261106155858.3779237-3-peter.maydell@linaro.org
---
 include/qemu/version.h               | 12 ------------
 bsd-user/main.c                      |  2 +-
 linux-user/main.c                    |  2 +-
 monitor/qmp-cmds-control.c           |  2 +-
 qemu-img.c                           |  2 +-
 qemu-io.c                            |  2 +-
 qemu-nbd.c                           |  2 +-
 qga/main.c                           |  2 +-
 scsi/qemu-pr-helper.c                |  2 +-
 storage-daemon/qemu-storage-daemon.c |  2 +-
 system/vl.c                          |  2 +-
 tools/i386/qemu-vmsr-helper.c        |  3 ++-
 tools/qemu-vnc/qemu-vnc.c            |  2 +-
 util/module.c                        |  2 +-
 ui/cocoa.m                           |  2 +-
 15 files changed, 15 insertions(+), 26 deletions(-)
 delete mode 100644 include/qemu/version.h

diff --git a/include/qemu/version.h b/include/qemu/version.h
deleted file mode 100644
index 38405495c0e..00000000000
--- a/include/qemu/version.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * QEMU version strings
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef QEMU_VERSION_H
-#define QEMU_VERSION_H
-
-#include "qemu-version.h"
-
-#endif
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 6720dbde6f8..29ee59de2cf 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -25,7 +25,7 @@
 #include "qemu/help-texts.h"
 #include "qemu/units.h"
 #include "qemu/accel.h"
-#include "qemu/version.h"
+#include "qemu-version.h"
 #include <machine/trap.h>
 
 #include "qapi/error.h"
diff --git a/linux-user/main.c b/linux-user/main.c
index 2f0c0a50c8a..60a695b7ca3 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -21,7 +21,7 @@
 #include "qemu/help-texts.h"
 #include "qemu/units.h"
 #include "qemu/accel.h"
-#include "qemu/version.h"
+#include "qemu-version.h"
 #include <sys/syscall.h>
 #include <sys/resource.h>
 #include <sys/shm.h>
diff --git a/monitor/qmp-cmds-control.c b/monitor/qmp-cmds-control.c
index bc938712f3d..8fe0876a3da 100644
--- a/monitor/qmp-cmds-control.c
+++ b/monitor/qmp-cmds-control.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 
 #include "monitor-internal.h"
-#include "qemu/version.h"
+#include "qemu-version.h"
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
diff --git a/qemu-img.c b/qemu-img.c
index 766d8540bfe..edf75e43aba 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -27,7 +27,7 @@
 
 #include "qemu/help-texts.h"
 #include "qemu/qemu-progress.h"
-#include "qemu/version.h"
+#include "qemu-version.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block-core.h"
 #include "qapi/qapi-visit-block-core.h"
diff --git a/qemu-io.c b/qemu-io.c
index b5f2ae631a4..598d5b1c9ca 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -34,7 +34,7 @@
 #include "block/block_int.h"
 #include "trace/control.h"
 #include "crypto/init.h"
-#include "qemu/version.h"
+#include "qemu-version.h"
 
 #define CMD_NOFILE_OK   0x01
 
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 4f7e965edba..fa28609d7dc 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -46,7 +46,7 @@
 #include "crypto/init.h"
 #include "crypto/tlscreds.h"
 #include "trace/control.h"
-#include "qemu/version.h"
+#include "qemu-version.h"
 
 #ifdef CONFIG_SELINUX
 #include <selinux/selinux.h>
diff --git a/qga/main.c b/qga/main.c
index 06358cb213c..fd19c7037db 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -30,7 +30,7 @@
 #include "qemu/help_option.h"
 #include "qemu/sockets.h"
 #include "qemu/systemd.h"
-#include "qemu/version.h"
+#include "qemu-version.h"
 #ifdef _WIN32
 #include <windows.h>
 #include <objbase.h>
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 7629f364045..1f97a5c4bfe 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -50,7 +50,7 @@
 #include "qobject/qstring.h"
 #include "io/channel-socket.h"
 #include "trace/control.h"
-#include "qemu/version.h"
+#include "qemu-version.h"
 
 #include "block/thread-pool.h"
 
diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index b2e29f00054..50dbfbd97ae 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -43,7 +43,7 @@
 #include "qapi/qobject-input-visitor.h"
 
 #include "qemu/help-texts.h"
-#include "qemu/version.h"
+#include "qemu-version.h"
 #include "qemu/cutils.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
diff --git a/system/vl.c b/system/vl.c
index e7b759d5442..7ae6a8298fc 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -37,7 +37,7 @@
 #include "qobject/qdict.h"
 #include "qobject/qstring.h"
 #include "qobject/qjson.h"
-#include "qemu/version.h"
+#include "qemu-version.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
 #include "qemu/hw-version.h"
diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/i386/qemu-vmsr-helper.c
index fac7fbe6b61..f12fd3c3e81 100644
--- a/tools/i386/qemu-vmsr-helper.c
+++ b/tools/i386/qemu-vmsr-helper.c
@@ -34,7 +34,7 @@
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
-#include "qemu/version.h"
+#include "qemu-version.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
@@ -42,6 +42,7 @@
 #include "io/channel.h"
 #include "io/channel-socket.h"
 #include "trace/control.h"
+#include "qemu-version.h"
 #include "rapl-msr-index.h"
 
 #define MSR_PATH_TEMPLATE "/dev/cpu/%u/msr"
diff --git a/tools/qemu-vnc/qemu-vnc.c b/tools/qemu-vnc/qemu-vnc.c
index a668f3f734d..c915589ca7e 100644
--- a/tools/qemu-vnc/qemu-vnc.c
+++ b/tools/qemu-vnc/qemu-vnc.c
@@ -15,7 +15,7 @@
 #include "qemu/option.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
-#include "qemu/version.h"
+#include "qemu-version.h"
 #include "ui/vnc.h"
 #include "crypto/secret.h"
 #include "crypto/tlscredsx509.h"
diff --git a/util/module.c b/util/module.c
index 6de9ff2e411..8f8e6994f11 100644
--- a/util/module.c
+++ b/util/module.c
@@ -23,7 +23,7 @@
 #include "qemu/config-file.h"
 #include "qapi/error.h"
 #ifdef CONFIG_MODULE_UPGRADES
-#include "qemu/version.h"
+#include "qemu-version.h"
 #endif
 #include "trace.h"
 
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 36a72d36238..4587547c98c 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -44,7 +44,7 @@
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
 #include "system/blockdev.h"
-#include "qemu/version.h"
+#include "qemu-version.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
-- 
2.43.0


