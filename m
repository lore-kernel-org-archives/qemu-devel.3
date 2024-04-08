Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FE8CD129A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrJx-0001HX-2J; Mon, 08 Apr 2024 11:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJv-0001Gz-Fe
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJs-0001pL-Jz
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712591643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hf56ciMuERPF0cEabxiAJBGlTdfq68PH3JYLDVjSE20=;
 b=jUspRLqFR0xPiF5iioyRakwgWiJu0Ss5webUUxshkVa0tSczDvV6oZFarlVK+aEhyafCuJ
 SmsIxx0wuI7LCRs7VLjpUggbFco97+nASuikysnEXcc30bPujABk7mxcKOC+edA5dWuu6K
 b40N6btGL4/SfhAPp8Jfi5W3cpIhROY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-JHq2W5CKNkWCZ9LZtBBIfg-1; Mon, 08 Apr 2024 11:54:02 -0400
X-MC-Unique: JHq2W5CKNkWCZ9LZtBBIfg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-416542ed388so7208065e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591640; x=1713196440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hf56ciMuERPF0cEabxiAJBGlTdfq68PH3JYLDVjSE20=;
 b=PAnjEQA9JRjzYFMBKi6QMVn91Xxk228zGOqZT9J82EB8VKQRCM6dKnlHWwdqXKsPlK
 ECsPFMbG/9ZKlVEBVBq4CnnRh6zc+w4b8cTeq3Syaud3Tu2QH1qNB3gD1VoDvfeUCluN
 HMEjpgtLm5dnUYP0ryfOB0IXXW0wJGd191I6OZTmKbI3Q0jXNn1wUf+UyE/7P6p0H5k+
 z1ixou0SGBqkU8tLTq11AJ3y5OZluV6Mk4bh8S2QcNPuV/zBaghB3XHZumv922MUHN3H
 DSPiPJ8r5+e02hWETZG2hbhzO/bVr1gu1ifqA89PQNy8csYK9dVpmTe3vAfFQ8q0g6rK
 LHww==
X-Gm-Message-State: AOJu0Yys+S4UYn9ZBVYkL9VqM7Wqawyg1eo2GmE/F47xYtsFvl/MGN/V
 1jMtYC+46uoUTA5faGgWUlt5XwdosRnw0EpJcg+Hnhxa0ChGUGCZ+xY5A2Imtm/dmAs2wvJQ9o9
 Gi6ojYSAahDd8ng5Xwmtaix1aJBDP7T+GVddzRoodvbqJeHRYSN4rG7PkTmuVJOuru+GCjHMEvs
 tdePKjOup7XoXNt6E1ONF9HKVkPitV6OjpUPmA
X-Received: by 2002:a05:600c:3d86:b0:416:7398:8323 with SMTP id
 bi6-20020a05600c3d8600b0041673988323mr2344710wmb.18.1712591640436; 
 Mon, 08 Apr 2024 08:54:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrzZnaDa0ICHGqM5UaF6A/JmT/3m9PPXJ9IcWiDKdH+UGs937tB8OGXUC/uCZ2TXVglPaeaA==
X-Received: by 2002:a05:600c:3d86:b0:416:7398:8323 with SMTP id
 bi6-20020a05600c3d8600b0041673988323mr2344691wmb.18.1712591640114; 
 Mon, 08 Apr 2024 08:54:00 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a05600c139600b004162b4c6366sm13859642wmf.20.2024.04.08.08.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:53:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 09/18] stubs: remove obsolete stubs
Date: Mon,  8 Apr 2024 17:53:21 +0200
Message-ID: <20240408155330.522792-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408155330.522792-1-pbonzini@redhat.com>
References: <20240408155330.522792-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
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


