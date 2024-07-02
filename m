Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B62C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCB-00067N-7o; Tue, 02 Jul 2024 10:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeBn-0005Lj-Vg
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeBZ-0008DW-7m
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+up8MRKOgqTt/+B4PZNRXPDsgBlrNg7Q1TqZFnoDR0=;
 b=PUpYj2fhYx7NYY9itseC0fcrvYl7tGfdy6MTIt3ZRRDbmMVl14THjputCqnW7pRLV3hQeR
 VH56615nYzStmPM3cGLuOcmOmfCVZ2f175opUImV74/xniqDsOqjcpBQYDjyXlzgyMjCoM
 asO3KZoXzamr8Jozl3v1Drdf4l1rDWI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-pG6lwUWYMcuUg6cjIT-d_Q-1; Tue, 02 Jul 2024 10:08:40 -0400
X-MC-Unique: pG6lwUWYMcuUg6cjIT-d_Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-425739141c2so27411325e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929317; x=1720534117;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j+up8MRKOgqTt/+B4PZNRXPDsgBlrNg7Q1TqZFnoDR0=;
 b=UfUDyDknLbZ6rmQTcA9MiVb8fRwZsVGn00Wh8ktSyJiAG12Rm+9slZtb9q4xS+0qIS
 pLKouJ98GO7mPbeY97gEk5TDCgO1DJy1Xn1QClQFkxCVTNwmQ/thSDYG39hqOTCYNHwm
 I+ADphpblm7IREip8LJgMvXfGbZ/pbyNdn5twykx708cqjVaNj4jbLgWb5S7ol3Q9DTB
 75W0JsxqMtq/TK7M/KbjlRrS0ADDD4VoyWeRyt9gU5BaJiel1eOBZdG4ZTSNPad+Uv0K
 0eDEPNkaJQXS+4vnKfJ9jmvbn72OUjU/TjGFTrQUXAxe7U4yYs/7hIqJuYHtkmepL5ao
 krCw==
X-Gm-Message-State: AOJu0Yz3Rq3cOw1/HQV9uORuzEPxvTP6FlHkZ7fn0mIvLBjh5Hij9RTR
 3sevHVWXcNaD8A56GNTZSPSb1Hb0CfN1tt7y0AHdnMIVJ/5LuGHKfte3kZ/cAUL96I0FqY6FXFb
 AtqYTpeze7y0l8wj9393ykFaVJdkBf/w6IOxh6f0rAzgXtEBIR4ERPR0uePGlU5zxW5pddM1k6C
 VUIivyVZuCtCich9Iw7ztZyyySSgdjrg==
X-Received: by 2002:a05:600c:47d0:b0:425:7884:6b29 with SMTP id
 5b1f17b1804b1-4257a03c070mr67701985e9.19.1719929317537; 
 Tue, 02 Jul 2024 07:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHykH9+3shuMGW7806/cP9OPUCs9v8PTveOribz6PfGjmeEaQjWhAeNiK0O85WI2quMZoFjhA==
X-Received: by 2002:a05:600c:47d0:b0:425:7884:6b29 with SMTP id
 5b1f17b1804b1-4257a03c070mr67701645e9.19.1719929316976; 
 Tue, 02 Jul 2024 07:08:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a32asm201996655e9.31.2024.07.02.07.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:08:36 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:08:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 31/91] hw/misc/pvpanic: centralize definition of supported
 events
Message-ID: <9b13640da3f94c0fbacbae6d23bd91febfa44588.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

MST: tweak: keep header included in pvpanic.c to avoid header
dependency, rebase.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Message-Id: <20240527-pvpanic-shutdown-v8-3-5a28ec02558b@t-8ch.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/misc/pvpanic.h | 4 ++++
 hw/misc/pvpanic-isa.c     | 3 +--
 hw/misc/pvpanic-pci.c     | 2 +-
 hw/misc/pvpanic.c         | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index fab94165d0..1e5b20e4ed 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -18,6 +18,10 @@
 #include "exec/memory.h"
 #include "qom/object.h"
 
+#include "standard-headers/misc/pvpanic.h"
+
+#define PVPANIC_EVENTS (PVPANIC_PANICKED | PVPANIC_CRASH_LOADED)
+
 #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
 #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
 
diff --git a/hw/misc/pvpanic-isa.c b/hw/misc/pvpanic-isa.c
index b4f84c4110..9a923b7869 100644
--- a/hw/misc/pvpanic-isa.c
+++ b/hw/misc/pvpanic-isa.c
@@ -21,7 +21,6 @@
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
 #include "hw/isa/isa.h"
-#include "standard-headers/misc/pvpanic.h"
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
index 4d44a881da..106d03ccd6 100644
--- a/hw/misc/pvpanic-pci.c
+++ b/hw/misc/pvpanic-pci.c
@@ -55,7 +55,7 @@ static void pvpanic_pci_realizefn(PCIDevice *dev, Error **errp)
 
 static Property pvpanic_pci_properties[] = {
     DEFINE_PROP_UINT8("events", PVPanicPCIState, pvpanic.events,
-                      PVPANIC_PANICKED | PVPANIC_CRASH_LOADED),
+                      PVPANIC_EVENTS),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 80289ecf5f..4b2307d2c2 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -27,7 +27,7 @@ static void handle_event(int event)
 {
     static bool logged;
 
-    if (event & ~(PVPANIC_PANICKED | PVPANIC_CRASH_LOADED) && !logged) {
+    if (event & ~PVPANIC_EVENTS && !logged) {
         qemu_log_mask(LOG_GUEST_ERROR, "pvpanic: unknown event %#x.\n", event);
         logged = true;
     }
-- 
MST


