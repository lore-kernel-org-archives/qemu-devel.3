Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D508CC25B78
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66ms-0003Pg-J7; Sun, 12 May 2024 06:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mm-0003KC-Fu
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mk-00065P-4A
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSGuDMNpKG/eAq72x1kmer1D/P80D6LHphVej7Q/tIQ=;
 b=L2b98urSTGx+s70+T30EOZYgPze0R495m3U9+Xj6RQxtaJPUhCv5LrpBDpkUK221/u3jhK
 NnLF0s95hDVy4btOS6gkK6Oi8xfIzkuP5BsZDRnzyxSuzdm39OY5c6elach6cAGvknpMWk
 0PKXmABSspH19zmwC4n6p2IR071Bq2w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-PYiQ5xCiOWaq5AhWv_wR3w-1; Sun, 12 May 2024 06:50:25 -0400
X-MC-Unique: PYiQ5xCiOWaq5AhWv_wR3w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-34da8f1bf7cso2316341f8f.2
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511024; x=1716115824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZSGuDMNpKG/eAq72x1kmer1D/P80D6LHphVej7Q/tIQ=;
 b=Uk3Rfrzb0EQ+kkJuEtupsUIbVvFgOVOcaB+lxEy3q2ETT69Pr8SveCDliDOGr+Ydgd
 Mdi8NDjnGi605WG8r2mEy6TLNdhOCRjHF7NXSsLrboaiTIzc5HKtGM3XruW24iV8VBER
 4rfvPzSB1ukfG1weNfuYiMyV7R8sGWMpTEVnFfVxEkSDeQFgT3yAOOx24qqiyNT04Uo1
 B4ULsfTPiEN+SFwlT5y83q1gRxDkE54sDyxsbufDJHcjDJMZlCWYejV/plk+0yQmGkV0
 PQZtY/elQjiki9gs5DdbT+RHGHbdmowHCV66272RJW18yRXeT0QPrWwFme/AGqUWzPAt
 oYYg==
X-Gm-Message-State: AOJu0Yw3C3rpc4DK7Q6XRO6ls1LqHmgDJDqB8Fog/navfubHjaf4e2Ac
 wFv4fPv3rLExSs595ckRMImmoGhSMKTVIp1rlRIRvFAqmf1IYlyjVIZxqnHtjwXrTTHaLvVoLNQ
 1JInaNK098pptlWpSKGlLlk3aoA6M1wLo/nb/I+ZMXrrkAzWZUISndSCuEqHvpzyJQeRG+UZ8ET
 OJ1cR3kxsQ4NbepQ71x47Wa8h5hYhnRI1Mweyb
X-Received: by 2002:adf:e9c9:0:b0:34f:2cea:c86b with SMTP id
 ffacd0b85a97d-3504a969544mr6532913f8f.48.1715511024426; 
 Sun, 12 May 2024 03:50:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkhJc1t81UL/dR3Ah1xBWLvJT/IiqPRQWVpyd1xZdZQ5FhB+YrETCvbjLT11ZggsjQyl5sjA==
X-Received: by 2002:adf:e9c9:0:b0:34f:2cea:c86b with SMTP id
 ffacd0b85a97d-3504a969544mr6532899f8f.48.1715511023981; 
 Sun, 12 May 2024 03:50:23 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781cf91sm441728666b.1.2024.05.12.03.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/27] xen: initialize legacy backends from xen_bus_init()
Date: Sun, 12 May 2024 12:49:32 +0200
Message-ID: <20240512104945.130198-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
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

Prepare for moving the calls to xen_be_register() under the
control of xen_bus_init(), using the normal xen_backend_init()
method that is used by the "modern" backends.

This requires the xenstore global variable to be initialized,
which is done by xen_be_init().  To ensure that everything is
ready at the time the xen_backend_init() functions are called,
remove the xen_be_init() function from all the boards and
place it directly in xen_bus_init().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240509170044.190795-7-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c              | 1 -
 hw/xen/xen-bus.c          | 4 ++++
 hw/xen/xen-hvm-common.c   | 2 --
 hw/xenpv/xen_machine_pv.c | 5 +----
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 505ea750f4d..19f21953b4a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1250,7 +1250,6 @@ void pc_basic_device_init(struct PCMachineState *pcms,
             pci_create_simple(pcms->pcibus, -1, "xen-platform");
         }
         xen_bus_init();
-        xen_be_init();
     }
 #endif
 
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index fb82cc33e48..95b207ac8b4 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -13,6 +13,7 @@
 #include "hw/sysbus.h"
 #include "hw/xen/xen.h"
 #include "hw/xen/xen-backend.h"
+#include "hw/xen/xen-legacy-backend.h" /* xen_be_init() */
 #include "hw/xen/xen-bus.h"
 #include "hw/xen/xen-bus-helper.h"
 #include "monitor/monitor.h"
@@ -329,6 +330,9 @@ static void xen_bus_realize(BusState *bus, Error **errp)
         goto fail;
     }
 
+    /* Initialize legacy backend core & drivers */
+    xen_be_init();
+
     if (xs_node_scanf(xenbus->xsh, XBT_NULL, "", /* domain root node */
                       "domid", NULL, "%u", &domid) == 1) {
         xenbus->backend_id = domid;
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 1627da73982..2d1b0321214 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -872,8 +872,6 @@ void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
 
     xen_bus_init();
 
-    xen_be_init();
-
     return;
 
 err:
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index 1130d1a1479..b500ce09891 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -34,8 +34,7 @@ static void xen_init_pv(MachineState *machine)
 {
     setup_xen_backend_ops();
 
-    /* Initialize backend core & drivers */
-    xen_be_init();
+    xen_bus_init();
 
     switch (xen_mode) {
     case XEN_ATTACH:
@@ -60,8 +59,6 @@ static void xen_init_pv(MachineState *machine)
         vga_interface_created = true;
     }
 
-    xen_bus_init();
-
     /* config cleanup hook */
     atexit(xen_config_cleanup);
 }
-- 
2.45.0


