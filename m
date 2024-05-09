Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC61C41513
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 17:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5790-0002M2-Uz; Thu, 09 May 2024 13:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s578w-0002KP-Dh
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s578h-0003XB-Rt
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715274062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6WAHTvAaE6sY6xhH4JOpgzSpMmfvt1RmbHZ80hmJ/+E=;
 b=VEBlLBivj9FjRlOb1jKgJvV+teJ5aK4HnONALqcp2C8M6FubMw9P9AXjytko1w1DqxeRkH
 z8UnTiDP29Vp7f8qBiQmJJrrcSMiS6Rj94xbeHcMe2fjiBjjLTZ/WdBZc2YhXwQt3L2Vsa
 FjJLBZLJuiSqo7KIsjEyCK7tf5JBaFc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-hdMl6wfLPwG1Mo2gagOh7Q-1; Thu, 09 May 2024 13:01:01 -0400
X-MC-Unique: hdMl6wfLPwG1Mo2gagOh7Q-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-51f98fc5a80so952136e87.1
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 10:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715274059; x=1715878859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6WAHTvAaE6sY6xhH4JOpgzSpMmfvt1RmbHZ80hmJ/+E=;
 b=SlUzMSII4ViYEFcmQjxomAa7mJY4GUEgyYh5lMGVpsTP8T8TAOBw5TcaT2+gt7FN5b
 Q9UDKpup8qmUTAoYQv8Zv89kF4qDj8UpwUoqNGKwHmJ2b630W0q9OKIY6nF/bc/Pwjbd
 nhX/AqLSV+rFrrmInT3PRySEfGXdDJzz5dVxUcIvw6jIHJsNHp7xnpDHJp7IQneuiluz
 WzJhkD7P96tfXMDs8jpfKQdPpOsFqOg4jShpNnT486HeydNIeXXDRp8xSVP8njX7ZUsa
 /xbG0MqsacpDA9l5bVoYCu59zq/UfNJC+iV5QdYyHFXJrJChikI1JMzKRHgjU4GbMtR4
 54jg==
X-Gm-Message-State: AOJu0YykGnhScE4CUsp3IzDtGnzVxc48HL4t7Y0126DohDJaVY+Ip4Pn
 sez0HF2mm5bjOiCRoLdDwAyS7UxPQF95rkFSFvhuLifpbVb1DOfQeIDnPg39qjgM3TjrbzZHFDc
 Mm7t4X57EwR8fvWjs/wwAZVJ0X4VRCkLNM6iRzf0Io7e9+HIp6mD+RF57CgFldUncwGrl5nIszF
 b64GxSYCrj2xkdXAKKauFpc+1EvKkRDjnXfqlT
X-Received: by 2002:a05:6512:e81:b0:51b:6ed6:af3f with SMTP id
 2adb3069b0e04-5221006e630mr82583e87.16.1715274058822; 
 Thu, 09 May 2024 10:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERzlguJhi1uTwj2+3mHaHADh5DS+tmJn6GHgD9UDre8mMOfIWMRii+3e2JZ5PaXFxTmqi71w==
X-Received: by 2002:a05:6512:e81:b0:51b:6ed6:af3f with SMTP id
 2adb3069b0e04-5221006e630mr82562e87.16.1715274058295; 
 Thu, 09 May 2024 10:00:58 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781d342sm92958566b.6.2024.05.09.10.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 10:00:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [PATCH 06/13] xen: initialize legacy backends from xen_bus_init()
Date: Thu,  9 May 2024 19:00:37 +0200
Message-ID: <20240509170044.190795-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240509170044.190795-1-pbonzini@redhat.com>
References: <20240509170044.190795-1-pbonzini@redhat.com>
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


