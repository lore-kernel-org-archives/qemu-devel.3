Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936D4FEDA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2aJg-0007Sa-7O; Tue, 17 Mar 2026 15:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aJa-0007P6-CR
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:42:55 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aJW-000750-4I
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:42:53 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35b9d29480aso1974249a91.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773776568; x=1774381368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ulMoUdwMDiHrvD5Zpn2ftSeLnR6XY1V16teWljLREWQ=;
 b=u/A30AXCI+8zEC9zecKUG8dY4jE+7ullskae+U833fHb4G/V1HpJFumJRXGzdst7Yh
 HUZ43UvoHcZdgZwEme9IWA402rYZEoJd8Gw49oVJ9qz/+wOtvgz+KNDpzGWXJ9TCDfma
 wy6Lo02TyXO8aVY8FpI7nXemcE6RKZE/oyR3Z/h9kU5f7wCc95kIfzR9LNnDb32KcDs8
 BRCULe3xbg5cEc48tN+HKEE9WUC/YldapNZCri4LrBsICG3gy1DLnqVPDgwGECq42tNW
 ZBMsVl78L02LxdgPIgWzqOX2Ij9btblxRytgMqnDXof/cIbe5NpWd23HjyzyNtomWoLF
 ovvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773776568; x=1774381368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ulMoUdwMDiHrvD5Zpn2ftSeLnR6XY1V16teWljLREWQ=;
 b=Z9SQj/mD0KxamkDcKj0PXrqKeX1nWOm1y5rKEzHa04p20oNCuRYq9mxx9UMiu44TBC
 ojxwmrddNbFeZXiBctzfbHNGaMP84UXWgR9Rfo3vmei1DyZS5qQLyW0JUAWvr5uORUCP
 dAy74HVT4opc5lmWOmkbEsLFmX0oPlMd+pOkImIZDl4R3Y27OMY3wt3GkosZZUjYniRv
 5LLsbfBGm/z/5WJVrzhjB4Rqx1QcpEBQMCQZXxr9/TodME8Q0bp8iHmadQLlI/49yPaQ
 tDNOox7MMs+/AmW4cCe3aR7u8yDKp6KA7GW5WYBX76M15PqGqeb8j9AJ9jsg26FX8Pzt
 OChA==
X-Gm-Message-State: AOJu0YyjmlEobAjW1NXkBTAlaMhKCEPoSPy4THwHvhhooBmboaqK3m0K
 3udi/S7kycVgz8qciNKzCPFw8cy7OgIjXK5g367jyXhCCIDimGO4FGozrFP3Pov4qI9P2wdVMPg
 nLb4jPBA=
X-Gm-Gg: ATEYQzxX4u1v63kwrUWAa/wLgPDENp6er+Vs+96Uad/UxfG3b83kpetn8lPHNYsEj9D
 RPvHdnZMZrsSCkL1bYvdvNMloYdGqr/D90v5QBQDCSgqFOwm3Cfb6sJiel+VJE5buZ6aBTuN2lB
 XUVl60eZbIu+hGa+L7wjQgjJ/+beq10XtYtenUhfJcmMwUXbnjX4hcIeuFtY2naHAXDBx8IhYxq
 cvrlF7OHEibmcA/Y3ll4gRtfj/mXvZ67NoScmW6ghmfViSB2tKN8OwgDFWxFEtDt8YJVibEKNC8
 R06Oc/6laBDZL4pklOKFdEm4BuB1YwM6okIieASh1wji66JY3WI5kuIbJJ40tqKpZTKQrD37AH8
 5EIsEGxxMJy6XC6DSR/MdND4Uyy+11JEVg5eEIvaBDRxpfYSTVcQv8+8DPh55tGBGRuGj+g36Cm
 4wmnJIfUN7yipFgrAdBZpbuZpyQOa73a+WMK1X/ev53mPmudY3fg6HSRlkOA4Ruly7rsI8vs9Y4
 3/U
X-Received: by 2002:a17:90b:1c01:b0:35b:99f8:964e with SMTP id
 98e67ed59e1d1-35bb9e6e873mr579982a91.13.1773776567742; 
 Tue, 17 Mar 2026 12:42:47 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bba5b8606sm239907a91.14.2026.03.17.12.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 12:42:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org
Subject: [PATCH v4 3/8] hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
Date: Tue, 17 Mar 2026 12:42:36 -0700
Message-ID: <20260317194241.869568-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
References: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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
index b2154bb9287..ab726ea1152 100644
--- a/meson.build
+++ b/meson.build
@@ -3781,7 +3781,7 @@ util_ss = util_ss.apply({})
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


