Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB75D58B11
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 07:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1fak-0001jE-UH; Sun, 15 Mar 2026 03:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w1fai-0001hY-Nt
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 03:08:48 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w1fah-0000cD-10
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 03:08:48 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35a1cc6e478so1719931a91.0
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 00:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773558525; x=1774163325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k06r4+VvkL2G3ql4sYSuFl4jS3d8PMWI1522EBSoENc=;
 b=TrIGkMTzKeIjxvmxB1Ixt7UawiCgTX+k6PiZmnGVus2WakHzMfjTVHQTLq3AO+47Qz
 22Lopaq3mMcoTU+PdXOjjqqWJKCHM+z8BqrAgCMyLyb9QK5/f5ZdqdlPvpYE4YpAsnlH
 Mu8eYMBzzlxkpr4Wmm3UQgtoHYUWej7tmSthP/6sSiDPeI6zav/MqktgJZlzzEqjre2J
 YO4TiC/4ZZ9iEdtV20CyhwIJx6HOtcqVENTgauycVoJX9b0sAKhBImlp0sZXtIqpgnOc
 MkCzwMD1IBp2ihz+FWPVohpJNIlxmOVHa2wWljNChTHWHa4YIqU7SfDzyAjw7j9HB2Jw
 oEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773558525; x=1774163325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k06r4+VvkL2G3ql4sYSuFl4jS3d8PMWI1522EBSoENc=;
 b=py5FEUawWZgGl7RIUz8UUSviqCcPNm9xvwnuGH62RNhQGCo6r8FQvfcbv/eEURwLge
 gIMzXWvxMv6wC5qR0UC7a5jIAIHVsznAKSgGx/rs1Nle7o8YkCJp4wuKHiwXzU9dbKHK
 rIGE+1SFdS2+cS7LpcnDVcsyJueYydriGfX/ZcDumRAHBT8ak0HcHel1zpiHfmV5jKR8
 5SBVKzrZDJPTZ0oKfttIGSn406rOXBM/czFdO1IpWOHF/0eWmDkXEPZRXkHBh87Lw42Y
 MmVvx/7da0M7QdN0Ef8Ub0LPWrUvv5qPMgNp6bo+9NPvPYy5xD8KO3JEaFAZJGtiUGQl
 1Hig==
X-Gm-Message-State: AOJu0YyIx9naenMVbsSHKlXMueJfUV9DEGxq9yaI53vVlU+/FABvWGpS
 VSfIPVXIOzdYrzTanCy1DXzrjiBkn6gGVKVghRT01toKg4qM1w6c493Ht8JkNSq1AyMZfjWwhNP
 BZA9JL8o=
X-Gm-Gg: ATEYQzxrqTmcpA4DSmrGgIopZsxD35uuQY8IMXZIqAv+FH5NWTC91ipOZTtLYv2F/Zd
 C9a+YsWNg0bNamoUH/WNMv6nbX7uzAZhOFrYQpL0ZKHjK7+SViCfLdm2a3+PXNTTvNa2EPCj+96
 93yJFvzild96pqlkYv5sPpI746/+VnavJOk+qluLEz+KgisZMibDqjLBizxYeGwC1/pE6W9URgm
 sjaiKmw1w0wDsActqmAbGD37GYUzw738n8PZzbYDbm3VW6GLN+u7Pf02KmEiIDBow813BZAS6kg
 +ztJLw8xsfOAXOjzENu5QXol3aAwJKNxBd/2rumm//KwZBvgstpCQIB80hwu9AuTYTZk6a5iXJb
 QLCfglQFPtslSX31TchX4qrZhYf1Guh9etF6StGu8kwD0zhZsyiy3ASxhp/fMKbXg+9Qi+Dp9TL
 TNl85///xOy00NuVHfqXSvDI46lp/Zo4M6rEitVcQ3zA6mWloMf2qfBp2hp18d0FF+e5FFNuQaH
 3o=
X-Received: by 2002:a17:90b:38c1:b0:359:fecd:1cb6 with SMTP id
 98e67ed59e1d1-35a21cb4b21mr7987793a91.0.1773558525286; 
 Sun, 15 Mar 2026 00:08:45 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a24acecadsm3468233a91.2.2026.03.15.00.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 00:08:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-ppc@nongnu.org, eric.auger@redhat.com
Subject: [PATCH v3 3/8] hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
Date: Sun, 15 Mar 2026 00:08:29 -0700
Message-ID: <20260315070834.198331-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
References: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

As well, we need to add pixman to qemuutil library dependencies since
pixman is transitively included from pci.h header, which is needed to be
able to include prototypes for stubs we declared.
In file included from include/ui/console.h:4,
                 from ../hw/vfio/vfio-display.h:12,
                 from ../hw/vfio/pci.h:25,
                 from ../hw/vfio/igd-stubs.c:9:
include/ui/qemu-pixman.h:10:10: fatal error: pixman.h: No such file or directory
   10 | #include <pixman.h>
      |          ^~~~~~~~~~

On OpenBSD, opengl headers are not available in default include path,
and thus we need to add opengl to list of qemuutil dependencies.
In file included from /home/root/qemu/include/ui/console.h:9:
/home/root/qemu/include/ui/surface.h:11:11: fatal error: 'epoxy/gl.h' file not found

Finally, vfio_pci_hot_reset_info must be forwarded declared on non linux
platforms:
In file included from ../hw/vfio/igd-stubs.c:9:
../hw/vfio/pci.h:265:44: error: 'struct vfio_pci_hot_reset_info' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
  265 |                                     struct vfio_pci_hot_reset_info **info_p);
      |

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build          |  2 +-
 hw/vfio/pci.h        |  2 ++
 hw/vfio/igd-stubs.c  | 20 ++++++++++++++++++++
 hw/vfio/pci-quirks.c |  5 -----
 hw/vfio/meson.build  |  1 +
 5 files changed, 24 insertions(+), 6 deletions(-)
 create mode 100644 hw/vfio/igd-stubs.c

diff --git a/meson.build b/meson.build
index 11139f540b0..5abfc8ef190 100644
--- a/meson.build
+++ b/meson.build
@@ -3794,7 +3794,7 @@ util_ss = util_ss.apply({})
 libqemuutil = static_library('qemuutil',
                              build_by_default: false,
                              sources: util_ss.sources() + stub_ss.sources() + genh,
-                             dependencies: [util_ss.dependencies(), libm, threads, glib, socket, malloc, rt])
+                             dependencies: [util_ss.dependencies(), libm, threads, glib, socket, malloc, rt, pixman, opengl])
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res,
                               dependencies: [event_loop_base])
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


