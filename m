Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F82C19F4F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnD-0004m9-Ik; Tue, 23 Apr 2024 11:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmg-0004NL-Vl
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmc-00005B-H9
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9AiM914CD+vMBdT1Wb1P5fEBdl543CI+JfxJ8v1vmDU=;
 b=bHF6b6fcU9lXDPpvZsuKHIxoryMbBmeBRn0aYx36m3KN/70/wuacwWmdNOacYabVUUCjp4
 tHAUrLpDW6EmneZzZDw7hgW+RcC1bi9V1rfcj9iwrxLndFF6I3cntrfcOx5fgxlx6WhRTS
 LcTZTaxYlbOwmVUiEu6r5ytaRIb/Two=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-EFJ8kivaNd-S8Ky_mYR8JQ-1; Tue, 23 Apr 2024 11:10:04 -0400
X-MC-Unique: EFJ8kivaNd-S8Ky_mYR8JQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B815B104B501;
 Tue, 23 Apr 2024 15:10:03 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D92220296D2;
 Tue, 23 Apr 2024 15:10:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/63] stubs: remove obsolete stubs
Date: Tue, 23 Apr 2024 17:08:57 +0200
Message-ID: <20240423150951.41600-10-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

These file define functions are are not called from common code
anymore.  Delete those functions and, if applicable, the entire files.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240408155330.522792-10-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/sysemu.h |  2 --
 stubs/isa-bus.c         |  7 -------
 stubs/module-opts.c     |  2 --
 stubs/monitor-core.c    |  6 ------
 stubs/pci-bus.c         |  7 -------
 stubs/qdev.c            |  6 ------
 stubs/qtest.c           | 10 ----------
 stubs/usb-dev-stub.c    |  5 -----
 stubs/meson.build       |  3 ---
 9 files changed, 48 deletions(-)
 delete mode 100644 stubs/isa-bus.c
 delete mode 100644 stubs/module-opts.c
 delete mode 100644 stubs/pci-bus.c

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index eb1dc1e4eda..5b4397eeb80 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -71,8 +71,6 @@ Chardev *serial_hd(int i);
 
 extern Chardev *parallel_hds[MAX_PARALLEL_PORTS];
 
-void hmp_info_usb(Monitor *mon, const QDict *qdict);
-
 void add_boot_device_path(int32_t bootindex, DeviceState *dev,
                           const char *suffix);
 char *get_boot_devices_list(size_t *size);
diff --git a/stubs/isa-bus.c b/stubs/isa-bus.c
deleted file mode 100644
index 522f448997d..00000000000
--- a/stubs/isa-bus.c
+++ /dev/null
@@ -1,7 +0,0 @@
-#include "qemu/osdep.h"
-#include "hw/isa/isa.h"
-
-ISADevice *isa_create_simple(ISABus *bus, const char *name)
-{
-    g_assert_not_reached();
-}
diff --git a/stubs/module-opts.c b/stubs/module-opts.c
deleted file mode 100644
index 5412429ea86..00000000000
--- a/stubs/module-opts.c
+++ /dev/null
@@ -1,2 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu/config-file.h"
diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
index afa477aae65..1894cdfe1f8 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -12,10 +12,6 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
     return NULL;
 }
 
-void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
-{
-}
-
 void qapi_event_emit(QAPIEvent event, QDict *qdict)
 {
 }
@@ -24,5 +20,3 @@ int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
 {
     abort();
 }
-
-
diff --git a/stubs/pci-bus.c b/stubs/pci-bus.c
deleted file mode 100644
index a8932fa9325..00000000000
--- a/stubs/pci-bus.c
+++ /dev/null
@@ -1,7 +0,0 @@
-#include "qemu/osdep.h"
-#include "hw/pci/pci.h"
-
-PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name)
-{
-    g_assert_not_reached();
-}
diff --git a/stubs/qdev.c b/stubs/qdev.c
index 6869f6f90a2..7e957b3e524 100644
--- a/stubs/qdev.c
+++ b/stubs/qdev.c
@@ -20,9 +20,3 @@ void qapi_event_send_device_deleted(const char *device,
 {
     /* Nothing to do. */
 }
-
-void qapi_event_send_device_unplug_guest_error(const char *device,
-                                               const char *path)
-{
-    /* Nothing to do. */
-}
diff --git a/stubs/qtest.c b/stubs/qtest.c
index 4666a49d7d1..39e376eb67d 100644
--- a/stubs/qtest.c
+++ b/stubs/qtest.c
@@ -13,13 +13,3 @@
 
 /* Needed for qtest_allowed() */
 bool qtest_allowed;
-
-bool qtest_driver(void)
-{
-    return false;
-}
-
-int64_t qtest_get_virtual_clock(void)
-{
-    return 0;
-}
diff --git a/stubs/usb-dev-stub.c b/stubs/usb-dev-stub.c
index aa557692b71..fcabe8429e6 100644
--- a/stubs/usb-dev-stub.c
+++ b/stubs/usb-dev-stub.c
@@ -26,8 +26,3 @@ HumanReadableText *qmp_x_query_usb(Error **errp)
     error_setg(errp, "Support for USB devices not built-in");
     return NULL;
 }
-
-void hmp_info_usb(Monitor *mon, const QDict *qdict)
-{
-    monitor_printf(mon, "Support for USB devices not built-in\n");
-}
diff --git a/stubs/meson.build b/stubs/meson.build
index f87f5c1110f..aa7120f7110 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -22,13 +22,11 @@ stub_ss.add(files('iothread-lock.c'))
 if have_block
   stub_ss.add(files('iothread-lock-block.c'))
 endif
-stub_ss.add(files('isa-bus.c'))
 stub_ss.add(files('is-daemonized.c'))
 if libaio.found()
   stub_ss.add(files('linux-aio.c'))
 endif
 stub_ss.add(files('migr-blocker.c'))
-stub_ss.add(files('module-opts.c'))
 stub_ss.add(files('monitor.c'))
 stub_ss.add(files('monitor-core.c'))
 stub_ss.add(files('physmem.c'))
@@ -57,7 +55,6 @@ if have_block or have_ga
 endif
 if have_system
   stub_ss.add(files('fw_cfg.c'))
-  stub_ss.add(files('pci-bus.c'))
   stub_ss.add(files('semihost.c'))
   stub_ss.add(files('usb-dev-stub.c'))
   stub_ss.add(files('xen-hw-stub.c'))
-- 
2.44.0



