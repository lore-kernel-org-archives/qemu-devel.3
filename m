Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7556010775FC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2uzq-00024q-Nx; Wed, 18 Mar 2026 13:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2uzi-000207-AD
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:47:48 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2uzf-0005oX-Kx
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:47:45 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2aae146b604so475455ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773856061; x=1774460861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Isu00EW2YlgRGO8VPU3tjd6Ko/MUdKtIVB1rQeSkNIk=;
 b=JzW+6DvQJzAtOwBk9y/mXmDIW5fW/R1btrhUJRY38qLAe7vWh+/ulUQsXSgnRVVDvH
 8RM7IB7iQFJf33OZ3xU+EIbXPqAfyXjUPQxWLDFduTm2HX8BoJO01t1J9NzqfFQNdYmi
 Yths65PWCLhE9cxcuSFlI69OB3SkoXZNaSxKclCV/pwg9CAh5auXMYAJ4RPukQW+zhWo
 SjPnlE/uqtrMBJBpNeRDZHGCcBmNByRgdQIkJ9csRqMdtfigT9LaL4bFEYBHxzF+th5e
 QD2on0mM43wT2Ba3b7Gnn40JmX0ILQV6CXl8Rob9GIL3vPGXP9eSlZNKSQlDlka6MA6k
 7oug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773856061; x=1774460861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Isu00EW2YlgRGO8VPU3tjd6Ko/MUdKtIVB1rQeSkNIk=;
 b=gsU+Z9Cn//a7Zb4hZKQ4etRXnItXCEHQQ8V2yIwThfZIdKtpVfqdOsHeDgFD0e1oQW
 8okVtMfDTp1ptLD8cZ3g4kzJABXLBN+/akcr9FfvYL2GwpPGhjGZlJOvN30GO4bD3Xw4
 vqT9LvHGpfUbVx+ZdiwuhPCOKKV0D2/NpCOlx7gpXePZEzSG6lEDMFDor7E1Uw5aWYbl
 i8z87XwggEqNIsM1/xCsHiOWZM5nS9J1qXkOle+Ts0SfeOnfz5qNSENgPHThmZMeS6Bf
 5EBCc5rSCmqjzcaBuIw5T21EUJs6U76RpDPX9/CWfOF8AKBY7vVUhqv/pk6eTmmDxowM
 KRxg==
X-Gm-Message-State: AOJu0YyDcKNM/xJiPanCkb8OXEfaCIAWpokRm/LoMT6ohmfuM80sCmzC
 aiaCv8Ht6lq5IY0a6Sxt54icBOYwerA8fHkNNP7n/Tmtw4BJ7epbm1dndhD/t+JAmSP8SfVAMbM
 JZ3LatQc=
X-Gm-Gg: ATEYQzz2hJy3WbKN3CxZnK2shUSS/QKuD44/OIyJrLPC79am2XpMsP7QX1pAaUBGOEo
 91y9eurdzoeN7p9Yhsdt+iyyPnxYuzKPVx0lYM89WVyqbZviuBS/KqpTr3laI6A5WbFWbIZh5Fo
 QbGt6Gxf21Cvq4QmIN5nOroRAs8Pt4fKOKK155maQnFXN32QuFuIkzCTZ8dqIuAPhTw/xt2QBHb
 PBeXTmDScFHoskWdn6ZjSEMkBgfnlJFjTY6LpN1FyHqrestat27AI8PsFt4mlDxp1sesE6HbZzM
 lumqW4l+frW0ipfloXkKGciAxfB/71zzn8mWh7XCNfaYk7hxnXpmpTbDhAHcHvWFEWTE0BJ6BCY
 +jrnMbpeB0BFMFp/QG9yFGFq92t3tNuKlli3AS+t4qi1+Wes7RYqTPzQc00cWHPvMqaEVfEPvM9
 uqcy5yn3lntUUs5zZgkfQwMefvzc67Js2Ub6814ZN1nOH6cD+5veOZNbD4hWTF6feJTVwF+U7Za
 GDB
X-Received: by 2002:a17:903:b85:b0:2ae:7fbd:3dcd with SMTP id
 d9443c01a7336-2b06e44062dmr37780395ad.52.1773856061017; 
 Wed, 18 Mar 2026 10:47:41 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e5f0ac2sm34066185ad.52.2026.03.18.10.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 10:47:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, philmd@linaro.org,
 qemu-ppc@nongnu.org
Subject: [PATCH v5 3/8] hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
Date: Wed, 18 Mar 2026 10:47:28 -0700
Message-ID: <20260318174733.1717643-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
References: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

vfio_pci_hot_reset_info must be forwarded declared on non linux platforms:
In file included from ../hw/vfio/igd-stubs.c:9:
../hw/vfio/pci.h:265:44: error: 'struct vfio_pci_hot_reset_info' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
  265 |                                     struct vfio_pci_hot_reset_info **info_p);
      |

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/pci.h        |  2 ++
 hw/vfio/igd-stubs.c  | 20 ++++++++++++++++++++
 hw/vfio/pci-quirks.c |  5 -----
 hw/vfio/meson.build  |  1 +
 4 files changed, 23 insertions(+), 5 deletions(-)
 create mode 100644 hw/vfio/igd-stubs.c

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index d6495d7f297..c3a1f53d350 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -258,6 +258,8 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp);
 
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
 
+struct vfio_pci_hot_reset_info;
+
 void vfio_pci_pre_reset(VFIOPCIDevice *vdev);
 void vfio_pci_post_reset(VFIOPCIDevice *vdev);
 bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name);
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
index f2a7728d3d0..6c00a7f51bb 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -17,6 +17,7 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
 vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
+stub_ss.add(files('igd-stubs.c'))
 
 specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 
-- 
2.47.3


