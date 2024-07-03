Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC286C31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8kZ-0001Tm-Ka; Wed, 03 Jul 2024 18:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8kV-00017B-Lm
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:46:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8kT-0001VP-MT
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+up8MRKOgqTt/+B4PZNRXPDsgBlrNg7Q1TqZFnoDR0=;
 b=WlYMpXYwO9HzGPhRrE+U3eaLojyAmqCfyhG3EHAFQjAbVpQBnBo2O3Q+3FCT5xdlXjiZNd
 1QpU6TD+t+d486HFF3kl7kh03Rr7F/5xzF2julfe01kbeUb59Y2c7pQ3c/wTLdFiGXNwQL
 MOsdJtC48PLOmCyZnRaQfr3ctSISfTI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-Jr6rwW8JMyy7T1LQRV5xAw-1; Wed, 03 Jul 2024 18:46:47 -0400
X-MC-Unique: Jr6rwW8JMyy7T1LQRV5xAw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a74914bc770so1331666b.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046806; x=1720651606;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j+up8MRKOgqTt/+B4PZNRXPDsgBlrNg7Q1TqZFnoDR0=;
 b=Fz+HgD7nTOsOqjhDHv+R+f2kRb4qxVjSL1ZscPWgXUFxlbFQI/PH6ag7+QVWHLj9bw
 FehXxFo+rHFNjlRIbHx4UDcSdlLrYrL3VrUc2JmjqKcEq6nYFVyhwH5Ur9qVcLLX1XFr
 /h91ZIPgDrAsmzxz4mOP+LpfcamCRHqEUrTqtEEVNaT+8xA2Qh+xdjqbjtXlUWl/3ZGS
 h8GPgrO6zsc0uj7+GXWvCPwyiKmsvLtQOruyXRHrtezaNQBEfTODEJk2koUwDA+BfdAc
 YGSIjCaS7JxCLeGU/TvDHryndfG7GWnQ43vNdhOI/EgK0IMongbPc8vSTDorJ8z3iyJl
 X36Q==
X-Gm-Message-State: AOJu0Yz23QWIqCPmXzTapcbArlbfdnTEMlvsvtbid2hfQoEiUWh5iNNq
 2x4+KdbPnxS2Jp1xWbcaW9PsAAFjPTAlNAqo5szzHgdDTmb6GANri7asXBal85W7Td+CvKzwtdM
 pLKKcbS5svTRJ8OfJlNb1Ih+j1p2O7R8a95XzQHnJo5pC1ezPGdSyEgczpgYnChdaXxQ/VIoKWv
 HqbNoKVZNtJfUsU6fcmdohqSa8A5hpVw==
X-Received: by 2002:a17:907:970e:b0:a72:6ff6:b91a with SMTP id
 a640c23a62f3a-a751447b21dmr985020966b.51.1720046806240; 
 Wed, 03 Jul 2024 15:46:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqDIcr1nehmyqq/Q/H9NH88MFEmFa/7HKpee3t40YW08L2g5qo6fdLWWU/J0b0dV2kH0Eugw==
X-Received: by 2002:a17:907:970e:b0:a72:6ff6:b91a with SMTP id
 a640c23a62f3a-a751447b21dmr985018666b.51.1720046805467; 
 Wed, 03 Jul 2024 15:46:45 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0b8021sm549382566b.216.2024.07.03.15.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:46:44 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:46:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 31/85] hw/misc/pvpanic: centralize definition of supported
 events
Message-ID: <9b13640da3f94c0fbacbae6d23bd91febfa44588.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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


