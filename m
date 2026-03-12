Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA13106ACF3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 22:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0omD-000723-6z; Thu, 12 Mar 2026 18:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0omB-00070i-CG
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:45:07 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0om9-0003Bt-2T
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:45:07 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ae3a2f6007so11081905ad.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 15:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773355503; x=1773960303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TZOplH2+O/7OD+MRzOhHvfoC8xpMBAXb6gpsEWwHNLc=;
 b=mBGwFLRf7Aw8N7XcCRhuNyjEFnp8D+qtiDexaQGR8qveGtHx5IlzZAjLgWhw+i6qYS
 qoduwFUP7r9m8FZ9go+Otf8G+kiRBgJH09LrCjE1Ud4v6q/1S4uWRgL0q98h8yi7HNwW
 2BM/yOM3ush2QXQ9B0LHuOmt2lST0uBI37NkuW24XoZTWAGpByk4fTJMAeRqdfGoQOZu
 Q+DIDreDixu2DFnQ2dmGFJnjs5iyAewZ2xg2asqEBa4/ie5XeAt5Jzky3aTQ2Syu6Sdm
 8rJL3IyOEJ0H7qiosqB3gfFE/r49OLr2I1DCMt+huHDhOo412cek3lwrZwSQv3JE1iHa
 Mhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773355503; x=1773960303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TZOplH2+O/7OD+MRzOhHvfoC8xpMBAXb6gpsEWwHNLc=;
 b=GQonf2RfvyB+IIWtlgbYqHu4poekStEC6WLS/BN/5VquHoRQqgrifKkpuJY0+czxL7
 L1+5f/vu35pEKxbZFuNC4X4+eM9Gn8iKm33ScX+ZdX5L2+9Yh5+1YyiOhWKCFieArIqs
 fOUXZjEvT80O4gUTbHSA2X4Yzt+ASBxFxo9qH0aS87WMNhTCYgcRP7tSIi/WbgE5tczk
 Z2LogKL/8KBOqa6f/hfnZTdGehuc9EXH/obriJmNCPEgkmQbUWHJeCIPtMvpBnexwD91
 vGLwjWHeQoAfx0qNP27I7Lz9S6cRg9Wqu3Qh4jrGvYG3bf2hhJi4jpt8mJjzfloE3H5o
 vvvw==
X-Gm-Message-State: AOJu0YxoV2LLluqkwtF8X8wygBfoRwDCZc8Nx/1G1bBf1pka4yBV2LGp
 FcJN4YNCnlhYZAQkk6OsAfuiDFhkQdhkyJE07AwW/7YxxD/OmhxQXDp/JNngdmBKzZPOVMdoX06
 Qarwtbnc=
X-Gm-Gg: ATEYQzzlAGeXrapdmscdK4GkFNdy2MgpDiRVHckCdPlM8qSO0Ix8VhCxmn7aisufZh0
 AKIgEzRBLf6Gxg4Sw60dvvwqZRTfFjE9sQkd6wNTYMHVWnm8HHPatpIhnwhJKOt0AQDwoaI650+
 2KMd+lPe+QM8n4Irt7QOM0bUuqz7UsxZHOXypbRQmWjsGOAl0K8YbHVCYiCxpe/9m5LSs8vvjpp
 BEmkvYEwlZhgeuYVBQUVum24fllVcBfBKiM4TPCcaZVdWSUQCqpJaQpteN7Fmw2LAvejK95X/Er
 0EW6x7MQ1l0LatZz4BNCUZ8c6oavgBx3W6W+5A7QaYH8hW0a3FIPvJmv68WzCEyrU5v5zmTvW4h
 BXf8ngl2mnJYmwttQI+zo5mQHeA0pBhKgmptmN1CTn9Gv1QR14A71RwRhOGj0EPxE4DTwtYLfwz
 dSSDLDFPAwpqIiAb6S58aYa0v8dqCWzRIxcpYQn21z2TzfBlpoPfRSzlM7/2Gc2gbmj0NmONNCR
 u4Y
X-Received: by 2002:a17:902:fc87:b0:2ae:5a55:3ded with SMTP id
 d9443c01a7336-2aecac79ec4mr9026985ad.45.1773355503530; 
 Thu, 12 Mar 2026 15:45:03 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece7ed9cdsm128215ad.60.2026.03.12.15.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 15:45:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 3/8] hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
Date: Thu, 12 Mar 2026 15:44:44 -0700
Message-ID: <20260312224449.1605071-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

Add stubs for needed functions.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/igd-stubs.c  | 20 ++++++++++++++++++++
 hw/vfio/pci-quirks.c |  5 -----
 hw/vfio/meson.build  |  3 ++-
 3 files changed, 22 insertions(+), 6 deletions(-)
 create mode 100644 hw/vfio/igd-stubs.c

diff --git a/hw/vfio/igd-stubs.c b/hw/vfio/igd-stubs.c
new file mode 100644
index 00000000000..f7687d90912
--- /dev/null
+++ b/hw/vfio/igd-stubs.c
@@ -0,0 +1,20 @@
+/*
+ * IGD device quirks stubs
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/qmp/qerror.h"
+#include "pci.h"
+#include "pci-quirks.h"
+
+void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
+{
+    return;
+}
+
+bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
+{
+    return true;
+}
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 7b907b9360d..ab864048943 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -11,7 +11,6 @@
  */
 
 #include "qemu/osdep.h"
-#include CONFIG_DEVICES
 #include "exec/memop.h"
 #include "qemu/units.h"
 #include "qemu/log.h"
@@ -1128,11 +1127,9 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
  */
 bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp)
 {
-#ifdef CONFIG_VFIO_IGD
     if (!vfio_probe_igd_config_quirk(vdev, errp)) {
         return false;
     }
-#endif
     return true;
 }
 
@@ -1179,9 +1176,7 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr)
     vfio_probe_nvidia_bar5_quirk(vdev, nr);
     vfio_probe_nvidia_bar0_quirk(vdev, nr);
     vfio_probe_rtl8168_bar2_quirk(vdev, nr);
-#ifdef CONFIG_VFIO_IGD
     vfio_probe_igd_bar0_quirk(vdev, nr);
-#endif
 }
 
 void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr)
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index f32d8573600..562ba79d1c0 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -16,7 +16,8 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
 ))
 vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
-vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
+vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'),
+                                     if_false: files('igd-stubs.c'))
 
 specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 
-- 
2.47.3


