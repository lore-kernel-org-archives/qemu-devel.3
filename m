Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC78C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZWM-0000D1-NY; Tue, 04 Jun 2024 15:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZWK-0008MJ-Hr
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZWH-00012L-PQ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=COb9qMgVhyWcfSZ4kcRJbOToHu92CV+3NurJg9nrDAw=;
 b=a1cxQwEUNtw9PBHNgmejJKe8SIBM+kNdhbwajR8Uwzc+nxmIhhY+LTtFfLLzmn90S/jtk6
 XGp+uj+2q/w6gg77Obxcy6wa2RjOhWrsK160rqHBUKOhmr0oXvrR2vYXzrO8g6got2922U
 4n40pLLP36iV+5kYoYnbP4ANsj49zqU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-BgAx0JxTMPupAthj-nPiuQ-1; Tue, 04 Jun 2024 15:08:26 -0400
X-MC-Unique: BgAx0JxTMPupAthj-nPiuQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35dca0dc826so1051044f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528104; x=1718132904;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=COb9qMgVhyWcfSZ4kcRJbOToHu92CV+3NurJg9nrDAw=;
 b=LHsFFsitDDUvKBxDZQiMCcVUrhw1cWVOtTY+KKzSV0cQB9t4tOz+8JOP1Be75OThqN
 WacN+dtXKOaqzivg9PDXvzpqs3j5Lrv4PN1oVNdbaV2XKeBV7Y+HzYCN5OHUWB89pnJE
 /LDB+UzYi/caYD3NwwjdihQx7JnEgJU0Compgt5ib0cgKDx5eMccRaUtl6lxFogs7qGY
 SeCi/P4hPXFv/68wFg9el5c8Ur7nSrj6ODBezOOC8zr8DM8ndJlgXzxO2byEFsCgvj3l
 KHvdV9/xlU9BWhxAwG7chaRq8fVP/XBq4WfI0mOMIs2v8DZ8FSDV2rYuqJReHig4AaWH
 IqxA==
X-Gm-Message-State: AOJu0Ywa5Rjn5YBtrNbzw3IVtUaac7rCeQhJcyxEuEHohRDIwZcWY2op
 egu2XJIQdO9L1bvYLlwhI6cHNqpiFMFDBz4/Hcx2ZfGMCnN5eXdAWUu54DH2VWgh1obbRTi9tuq
 n6AMB55C96uEiUFyaV0Z6fdJ+fLQg6DDfWG+1jovLJ4tdxN7OnhdNCzkyT8umx/sEZpLAWRMG/i
 5OB3vhQm46RYIyrJCLqxbM3077gv2FLA==
X-Received: by 2002:a5d:50cb:0:b0:354:fc85:7416 with SMTP id
 ffacd0b85a97d-35e9809b6f2mr223593f8f.71.1717528104501; 
 Tue, 04 Jun 2024 12:08:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVT6MRHx0PGbdhRtQj3KX/KlbO/4iNjQ1oxQIcew9988BENFNyh/aleYEt6Y/rv9VszHafNA==
X-Received: by 2002:a5d:50cb:0:b0:354:fc85:7416 with SMTP id
 ffacd0b85a97d-35e9809b6f2mr223573f8f.71.1717528103979; 
 Tue, 04 Jun 2024 12:08:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b838b55sm165368105e9.5.2024.06.04.12.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:08:23 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:08:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 39/46] hw/misc/pvpanic: centralize definition of supported
 events
Message-ID: <b3d8479a90ba270c3dbf645277704f131c8ddf94.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Thomas Weißschuh <thomas@t-8ch.de>

The different components of pvpanic duplicate the list of supported
events. Move it to the shared header file to minimize changes when new
events are added.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Message-Id: <20240527-pvpanic-shutdown-v8-3-5a28ec02558b@t-8ch.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/misc/pvpanic.h | 4 ++++
 hw/misc/pvpanic-isa.c     | 3 +--
 hw/misc/pvpanic-pci.c     | 3 +--
 hw/misc/pvpanic.c         | 3 +--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index fab94165d0..947468b81b 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -18,6 +18,10 @@
 #include "exec/memory.h"
 #include "qom/object.h"
 
+#include "standard-headers/linux/pvpanic.h"
+
+#define PVPANIC_EVENTS (PVPANIC_PANICKED | PVPANIC_CRASH_LOADED)
+
 #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
 #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
 
diff --git a/hw/misc/pvpanic-isa.c b/hw/misc/pvpanic-isa.c
index ccec50f61b..9a923b7869 100644
--- a/hw/misc/pvpanic-isa.c
+++ b/hw/misc/pvpanic-isa.c
@@ -21,7 +21,6 @@
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
 #include "hw/isa/isa.h"
-#include "standard-headers/linux/pvpanic.h"
 #include "hw/acpi/acpi_aml_interface.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(PVPanicISAState, PVPANIC_ISA_DEVICE)
@@ -102,7 +101,7 @@ static void build_pvpanic_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
 static Property pvpanic_isa_properties[] = {
     DEFINE_PROP_UINT16(PVPANIC_IOPORT_PROP, PVPanicISAState, ioport, 0x505),
     DEFINE_PROP_UINT8("events", PVPanicISAState, pvpanic.events,
-                      PVPANIC_PANICKED | PVPANIC_CRASH_LOADED),
+                      PVPANIC_EVENTS),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/misc/pvpanic-pci.c b/hw/misc/pvpanic-pci.c
index 83be95d0d2..603c5c7600 100644
--- a/hw/misc/pvpanic-pci.c
+++ b/hw/misc/pvpanic-pci.c
@@ -21,7 +21,6 @@
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
 #include "hw/pci/pci_device.h"
-#include "standard-headers/linux/pvpanic.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(PVPanicPCIState, PVPANIC_PCI_DEVICE)
 
@@ -55,7 +54,7 @@ static void pvpanic_pci_realizefn(PCIDevice *dev, Error **errp)
 
 static Property pvpanic_pci_properties[] = {
     DEFINE_PROP_UINT8("events", PVPanicPCIState, pvpanic.events,
-                      PVPANIC_PANICKED | PVPANIC_CRASH_LOADED),
+                      PVPANIC_EVENTS),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 1540e9091a..a4982cc592 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -21,13 +21,12 @@
 #include "hw/qdev-properties.h"
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
-#include "standard-headers/linux/pvpanic.h"
 
 static void handle_event(int event)
 {
     static bool logged;
 
-    if (event & ~(PVPANIC_PANICKED | PVPANIC_CRASH_LOADED) && !logged) {
+    if (event & ~PVPANIC_EVENTS && !logged) {
         qemu_log_mask(LOG_GUEST_ERROR, "pvpanic: unknown event %#x.\n", event);
         logged = true;
     }
-- 
MST


