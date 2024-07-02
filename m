Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF01C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjws-0003Lt-Mp; Tue, 02 Jul 2024 16:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjwD-0007T9-5X
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjwB-0008Ri-CR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+up8MRKOgqTt/+B4PZNRXPDsgBlrNg7Q1TqZFnoDR0=;
 b=aCeZ/OJfnaN2kJPw7TJpPTV4/lmRzUJ6LoipW21beAiqfVaASdxIOx0ELUMhH4lEtskQBH
 cTLRZjgvwCGBh/jKG4PPmnJaL/K7967QBkpR49+nJoRlqoiy7r5HTAZN4t3iIl4AT6iRw4
 +YHvQ6l871eZ3nNZqJYt2fiem27C0eg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-vCQPHriAOBqZmM6y3dLNuw-1; Tue, 02 Jul 2024 16:17:13 -0400
X-MC-Unique: vCQPHriAOBqZmM6y3dLNuw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4257dd7d462so19995555e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951431; x=1720556231;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j+up8MRKOgqTt/+B4PZNRXPDsgBlrNg7Q1TqZFnoDR0=;
 b=egA5lbspR+ROBXJPebHKA1rpWQHaQJCW5aR2Dro+Qdx7xzftI3L012wsilrCqs8puK
 1cMM5gjGCC9DXsOZol5RszW+x5miT01IclTkvFpSLnkflKDx/rRgx6HRc64wohta3ffV
 IdJCyP0UD8z1RN8p1QFz/3wTnpWe1H1gsYVuaP5ShvHqLSfsYeiZvnxpMnijlLnWadgd
 WmGfuz7afxXBEqiXutou7jKPWrC4vUYuAFtGaX4JOyvZK/uUDT2rC3wXIx6Ye5/Wlkte
 eWTuhz33bW3AoBqZFEQAdILSV2Mpix91/591mX5MOiTwn4F0TPk/YrT7w5lk8BLHByx+
 wukQ==
X-Gm-Message-State: AOJu0Yyld0B/oxxeNJkCGTbWJ2B7oLMW1dFzHcTIWb2VVm/IsiFncSZ5
 2RON+F0DPpo3LsbCVr/2lURSJMIZUIk4DKk+dXMIzCzZTrDyADOspjDFKn1y+yByejw0WwBrEc+
 Q8Enovlrx06mjW3NiOKve5HoPfDeOKGm4TG18wKkiVv2a41rQbsLR+azsefk3isroJwZFTkY1k5
 01Tbyd3iS4Zt22uLyRpr8A88o1AWsu7w==
X-Received: by 2002:a05:600c:1508:b0:425:5a26:a12c with SMTP id
 5b1f17b1804b1-4257a02f915mr67624925e9.13.1719951431637; 
 Tue, 02 Jul 2024 13:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElVd62h5bOqN/L7jD8y+HXmNTR8uaT/5v5s+LAU4QYdKFfPGSHIBr33WV2np7hJOihXNPV6w==
X-Received: by 2002:a05:600c:1508:b0:425:5a26:a12c with SMTP id
 5b1f17b1804b1-4257a02f915mr67624715e9.13.1719951431039; 
 Tue, 02 Jul 2024 13:17:11 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af552bbsm212044095e9.13.2024.07.02.13.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:17:09 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:17:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 31/88] hw/misc/pvpanic: centralize definition of supported
 events
Message-ID: <9b13640da3f94c0fbacbae6d23bd91febfa44588.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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


