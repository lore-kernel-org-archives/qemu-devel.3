Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB4AC25B74
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 07:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4c5u-0007Qa-Sk; Wed, 08 May 2024 03:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4c59-0006oA-H4
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4c57-0003dV-Ki
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715154676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLI2MH3fyDMFuWedIEfUPyOymOXv08hc0mnpF773TEI=;
 b=Dday36lisamrkpWkk1PGTRjqlhS9R04521sRn9zSQQxgmcPBQHd6fLr+5z1cnuKt/ojnT5
 SUF7/cZgPEuoz1wB4Qduiqf4RhwyDR2HEB7vFJKMTqLXzC/PevYEAbGUelE/xXy5QObCF1
 n9pAH7xDtCJ7k57KpSXOHuiw+GoFeJE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-G5lZtUiqPQG5-ngFXSMc8Q-1; Wed, 08 May 2024 03:51:15 -0400
X-MC-Unique: G5lZtUiqPQG5-ngFXSMc8Q-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59efa9f108so86894766b.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 00:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715154674; x=1715759474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JLI2MH3fyDMFuWedIEfUPyOymOXv08hc0mnpF773TEI=;
 b=qKYf+34C5y8P80wmWhC7/+BC/Lsv72ZKHiipEOrywlnxin9YDTYw8XGi4BKQWBLRnj
 xetObupjjUcnt041KNifgkJDKUMUbJPxH+Xbs2DX4K1mRqZm9d64ooRqEbk8PxN77Hr5
 W3u18lKOdFfYPv3pMzn6VQasKNag5fLI5zHZclZbXCA7fa5FwsvjfUDOLlEKgAGCErOd
 T+LH3ZRg9d85P57xkCxY9PvJC7Mi8HNIfLVqiKiCgcIaaEZDIjTxHYS+1uq9fZc98V3Z
 DD7FtU0cuxeU4lmhqrgf2DsOwY6n4UajgokJz0h4YMAfXWhdMhXLShwLoMQTH/5AZeOV
 Qwsg==
X-Gm-Message-State: AOJu0YzuDF2Whcf+aZKbaV7EDgrgGuwoLxHyplNqdUXpcfZCejwisMUf
 TQGCCd5ca1ZzyQi23msPWb/27ojpcAv1kGlrl2Z1MjutryEB9wxCb8UjHtAu1p9IPCbqMDicjTd
 FzgPQ9spBbGpX7QOUd/79EM+9AiDOCiMghLNvgdcxp+fOfLwXFHPnlBETIIxgulG9vGHXKFm02B
 YsPK47JuAGuIcVl6JgAYbgZcVJB9GGi/tYLvBn
X-Received: by 2002:a17:906:358c:b0:a59:70f0:7706 with SMTP id
 a640c23a62f3a-a59fb9f443dmr97039766b.74.1715154673914; 
 Wed, 08 May 2024 00:51:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGspPyvXIl4Yyz9bvn11PrHYyOLEuuqxomYodTOtxMiZmiC2Q6UxFBWhpp2HxaT0RlNH5n0pQ==
X-Received: by 2002:a17:906:358c:b0:a59:70f0:7706 with SMTP id
 a640c23a62f3a-a59fb9f443dmr97038166b.74.1715154673499; 
 Wed, 08 May 2024 00:51:13 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 gf12-20020a170906e20c00b00a5884e0ad1asm7406037ejb.33.2024.05.08.00.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 00:51:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 3/6] kconfig: allow compiling out QEMU device tree code per
 target
Date: Wed,  8 May 2024 09:51:02 +0200
Message-ID: <20240508075105.15510-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508075105.15510-1-pbonzini@redhat.com>
References: <20240508075105.15510-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce a new Kconfig symbol, CONFIG_DEVICE_TREE, that specifies whether
to include the common device tree code in system/device_tree.c and to
link to libfdt.  For now, include it unconditionally if libfdt is
available.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                  |  1 +
 include/monitor/hmp.h        |  1 +
 include/sysemu/device_tree.h |  1 -
 monitor/hmp-cmds.c           | 17 +++++++++++++++++
 system/device_tree-stub.c    | 10 ++++++++++
 system/device_tree.c         | 14 --------------
 Kconfig.host                 |  4 ++++
 hw/core/Kconfig              |  9 ++++++++-
 hw/core/meson.build          |  2 +-
 system/meson.build           |  4 +++-
 10 files changed, 45 insertions(+), 18 deletions(-)
 create mode 100644 system/device_tree-stub.c

diff --git a/meson.build b/meson.build
index 2e7e2b15406..d8f259d2610 100644
--- a/meson.build
+++ b/meson.build
@@ -2990,6 +2990,7 @@ host_kconfig = \
   (have_ivshmem ? ['CONFIG_IVSHMEM=y'] : []) + \
   (opengl.found() ? ['CONFIG_OPENGL=y'] : []) + \
   (x11.found() ? ['CONFIG_X11=y'] : []) + \
+  (fdt.found() ? ['CONFIG_FDT=y'] : []) + \
   (have_vhost_user ? ['CONFIG_VHOST_USER=y'] : []) + \
   (have_vhost_vdpa ? ['CONFIG_VHOST_VDPA=y'] : []) + \
   (have_vhost_kernel ? ['CONFIG_VHOST_KERNEL=y'] : []) + \
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index f4cf8f6717d..954f3c83ad9 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -180,5 +180,6 @@ void hmp_ioport_write(Monitor *mon, const QDict *qdict);
 void hmp_boot_set(Monitor *mon, const QDict *qdict);
 void hmp_info_mtree(Monitor *mon, const QDict *qdict);
 void hmp_info_cryptodev(Monitor *mon, const QDict *qdict);
+void hmp_dumpdtb(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/include/sysemu/device_tree.h b/include/sysemu/device_tree.h
index 8eab3959341..eb601522f88 100644
--- a/include/sysemu/device_tree.h
+++ b/include/sysemu/device_tree.h
@@ -134,7 +134,6 @@ int qemu_fdt_add_path(void *fdt, const char *path);
     } while (0)
 
 void qemu_fdt_dumpdtb(void *fdt, int size);
-void hmp_dumpdtb(Monitor *mon, const QDict *qdict);
 
 /**
  * qemu_fdt_setprop_sized_cells_from_array:
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 871898ac46b..ea79148ee85 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -22,6 +22,7 @@
 #include "monitor/monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/cutils.h"
@@ -443,3 +444,19 @@ void hmp_info_mtree(Monitor *mon, const QDict *qdict)
 
     mtree_info(flatview, dispatch_tree, owner, disabled);
 }
+
+#if defined(CONFIG_FDT)
+void hmp_dumpdtb(Monitor *mon, const QDict *qdict)
+{
+    const char *filename = qdict_get_str(qdict, "filename");
+    Error *local_err = NULL;
+
+    qmp_dumpdtb(filename, &local_err);
+
+    if (hmp_handle_error(mon, local_err)) {
+        return;
+    }
+
+    monitor_printf(mon, "dtb dumped to %s", filename);
+}
+#endif
diff --git a/system/device_tree-stub.c b/system/device_tree-stub.c
new file mode 100644
index 00000000000..bddda6fa37a
--- /dev/null
+++ b/system/device_tree-stub.c
@@ -0,0 +1,10 @@
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-machine.h"
+
+#ifdef CONFIG_FDT
+void qmp_dumpdtb(const char *filename, Error **errp)
+{
+    error_setg(errp, "This machine doesn't have a FDT");
+}
+#endif
diff --git a/system/device_tree.c b/system/device_tree.c
index eb5166ca360..2e38259d34f 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -668,20 +668,6 @@ void qmp_dumpdtb(const char *filename, Error **errp)
     }
 }
 
-void hmp_dumpdtb(Monitor *mon, const QDict *qdict)
-{
-    const char *filename = qdict_get_str(qdict, "filename");
-    Error *local_err = NULL;
-
-    qmp_dumpdtb(filename, &local_err);
-
-    if (hmp_handle_error(mon, local_err)) {
-        return;
-    }
-
-    info_report("dtb dumped to %s", filename);
-}
-
 void qemu_fdt_randomize_seeds(void *fdt)
 {
     int noffset, poffset, len;
diff --git a/Kconfig.host b/Kconfig.host
index f6a2a131e6c..a0d4a52131e 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -23,6 +23,10 @@ config IVSHMEM
 config TPM
     bool
 
+config FDT
+    bool
+    select DEVICE_TREE
+
 config VHOST_USER
     bool
 
diff --git a/hw/core/Kconfig b/hw/core/Kconfig
index 9397503656d..24411f59306 100644
--- a/hw/core/Kconfig
+++ b/hw/core/Kconfig
@@ -4,8 +4,14 @@ config EMPTY_SLOT
 config PTIMER
     bool
 
+config DEVICE_TREE
+    bool
+    # fail the build if libfdt not found
+    depends on FDT
+
 config FITLOADER
     bool
+    depends on DEVICE_TREE
 
 config GENERIC_LOADER
     bool
@@ -14,13 +20,14 @@ config GENERIC_LOADER
 config GUEST_LOADER
     bool
     default y
-    depends on TCG
+    depends on TCG && DEVICE_TREE
 
 config OR_IRQ
     bool
 
 config PLATFORM_BUS
     bool
+    depends on DEVICE_TREE
 
 config REGISTER
     bool
diff --git a/hw/core/meson.build b/hw/core/meson.build
index f20d4143f7a..a3d9bab9f42 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -16,7 +16,7 @@ common_ss.add(files('cpu-common.c'))
 common_ss.add(files('machine-smp.c'))
 system_ss.add(when: 'CONFIG_FITLOADER', if_true: files('loader-fit.c'))
 system_ss.add(when: 'CONFIG_GENERIC_LOADER', if_true: files('generic-loader.c'))
-system_ss.add(when: ['CONFIG_GUEST_LOADER', fdt], if_true: files('guest-loader.c'))
+system_ss.add(when: 'CONFIG_GUEST_LOADER', if_true: files('guest-loader.c'))
 system_ss.add(when: 'CONFIG_OR_IRQ', if_true: files('or-irq.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('platform-bus.c'))
 system_ss.add(when: 'CONFIG_PTIMER', if_true: files('ptimer.c'))
diff --git a/system/meson.build b/system/meson.build
index 25e21172505..a296270cb00 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -32,7 +32,9 @@ if have_tpm
 endif
 
 system_ss.add(when: seccomp, if_true: files('qemu-seccomp.c'))
-system_ss.add(when: fdt, if_true: files('device_tree.c'))
+system_ss.add(when: 'CONFIG_DEVICE_TREE',
+              if_true: [fdt, files('device_tree.c')],
+              if_false: files('device_tree-stub.c'))
 if host_os == 'linux'
   system_ss.add(files('async-teardown.c'))
 endif
-- 
2.45.0


