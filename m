Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF58DC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZv4J-0003lX-AJ; Tue, 13 Feb 2024 10:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv40-0003WB-Vi
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:51:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv3y-0005Yn-0t
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707839473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5HC+tz6aaJY+t7RF5sHfhbX2fGyic7JwYjzUweoBHas=;
 b=HJGQC6qDbkHJmS0opIozdHAUQkvKEaHQ+ZPc04NSL/AHURhSbkknsRzVi3jzEzuudn/Wff
 mFcbJ5ksMNbdB9hV1LdncRer0hRVugsGgSAJTHsSESEeMof4C/T50lDWmeO+y2IRYubTcU
 hkuNwAjuNvQ7p4cfbA3yrQHjV2Gc5bc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-LsTz5QwTOHSjjyBIqrYiiw-1; Tue, 13 Feb 2024 10:51:11 -0500
X-MC-Unique: LsTz5QwTOHSjjyBIqrYiiw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-51161adad50so953854e87.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:51:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839467; x=1708444267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5HC+tz6aaJY+t7RF5sHfhbX2fGyic7JwYjzUweoBHas=;
 b=WxzthslP/9WhyNqL6MfvCJlfttMxLJ/cw2ny9Nto6yiBUmdBF6gwE0ZBfNfMMyv8Wv
 K6PSWq/qhzAnyQW3f8vjoHzZB35z7+n67UZ3Sg3PrGXs/xiY8xYrjwY/HPDGy5NQ+Do7
 iOrTiIzqNXV23i961JG6OZtspJckgI2czpoP09eQtCYp7z5D3DK7//m9Fj0rBlVp3B1d
 jkO9Qah3SCvCAwvvui0zvnNIfQjeDXj0qZrNy+07s3SlApf6TIiiDmUb4o0AlaH5pjf1
 ABiUnydtuqOXHIPY0M2Foo4YBQD7EckEAMzqf9hIJj6st6b0/lZRbvJ1Jaejn3CW2I3i
 6IvA==
X-Gm-Message-State: AOJu0Yy5fRImJtBVV5/xKLZbxh+AOF8AhPfQUrF3odShYl/Ru4JJp95K
 bSy9+r0Qls+lBsFLkSfabTlA3pC6FSIaZhYJejlEza4XQemAkmI9HD0SE3A1UiawC38ODdHHdOe
 04Zf7vig1/pCox7eQIIHrrq0BUgXXqRIHQ/5dLpIU6aBj+ExstnGxAxwbUTj5RwLUKhuoALgG0/
 XWt2ZjVlVySCr2aCitXRqSTUgnP7J34ousx5yM
X-Received: by 2002:a05:6512:ea4:b0:511:603e:7afc with SMTP id
 bi36-20020a0565120ea400b00511603e7afcmr8690997lfb.46.1707839467408; 
 Tue, 13 Feb 2024 07:51:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnl3rRCVVecFLkiOiDHb2EtiBNGi0liMe8HjMMd8P46N/dUtKKCAN6a8NjSyhGL6HUXI6rHg==
X-Received: by 2002:a05:6512:ea4:b0:511:603e:7afc with SMTP id
 bi36-20020a0565120ea400b00511603e7afcmr8690973lfb.46.1707839467104; 
 Tue, 13 Feb 2024 07:51:07 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ2YDQDO8uw9yiV3fyUh436IpKM8gYHKR6gYk/l/AgrFO4appXzGl5maRNF5cRzwPE6iq+K0huQkn15a9LpyA3cubq5mL2ZRzIY6+Y2nWE5TimZnnL
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a056402434500b0055d333a0584sm3802738edc.72.2024.02.13.07.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 07:51:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	shentey@gmail.com,
	balaton@eik.bme.hu
Subject: [PATCH v3 6/9] isa: extract FDC37M81X to a separate file
Date: Tue, 13 Feb 2024 16:50:01 +0100
Message-ID: <20240213155005.109954-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213155005.109954-1-pbonzini@redhat.com>
References: <20240213155005.109954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

isa-superio.c currently defines a SuperIO chip that is not used
by any other user of the file.  Extract the chip to a separate file.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/fdc37m81x-superio.c | 32 ++++++++++++++++++++++++++++++++
 hw/isa/isa-superio.c       | 18 ------------------
 hw/isa/Kconfig             |  4 ++++
 hw/isa/meson.build         |  1 +
 hw/mips/Kconfig            |  2 +-
 5 files changed, 38 insertions(+), 19 deletions(-)
 create mode 100644 hw/isa/fdc37m81x-superio.c

diff --git a/hw/isa/fdc37m81x-superio.c b/hw/isa/fdc37m81x-superio.c
new file mode 100644
index 00000000000..55e91fbca17
--- /dev/null
+++ b/hw/isa/fdc37m81x-superio.c
@@ -0,0 +1,32 @@
+/*
+ * SMS FDC37M817 Super I/O
+ *
+ * Copyright (c) 2018 Philippe Mathieu-Daudé
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/isa/superio.h"
+
+static void fdc37m81x_class_init(ObjectClass *klass, void *data)
+{
+    ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
+
+    sc->serial.count = 2; /* NS16C550A */
+    sc->parallel.count = 1;
+    sc->floppy.count = 1; /* SMSC 82077AA Compatible */
+    sc->ide.count = 0;
+}
+
+static const TypeInfo types[] = {
+    {
+        .name          = TYPE_FDC37M81X_SUPERIO,
+        .parent        = TYPE_ISA_SUPERIO,
+        .class_init    = fdc37m81x_class_init,
+    },
+};
+
+DEFINE_TYPES(types)
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 98d50844f71..a8c8c58ef7f 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -190,27 +190,9 @@ static const TypeInfo isa_superio_type_info = {
     .instance_size = sizeof(ISASuperIODevice),
 };
 
-/* SMS FDC37M817 Super I/O */
-static void fdc37m81x_class_init(ObjectClass *klass, void *data)
-{
-    ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
-
-    sc->serial.count = 2; /* NS16C550A */
-    sc->parallel.count = 1;
-    sc->floppy.count = 1; /* SMSC 82077AA Compatible */
-    sc->ide.count = 0;
-}
-
-static const TypeInfo fdc37m81x_type_info = {
-    .name          = TYPE_FDC37M81X_SUPERIO,
-    .parent        = TYPE_ISA_SUPERIO,
-    .class_init    = fdc37m81x_class_init,
-};
-
 static void isa_superio_register_types(void)
 {
     type_register_static(&isa_superio_type_info);
-    type_register_static(&fdc37m81x_type_info);
 }
 
 type_init(isa_superio_register_types)
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 5df3c09cd51..73c6470805c 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -23,6 +23,10 @@ config ISA_SUPERIO
     # Some users of ISA_SUPERIO do not use it
     #select IDE_ISA
 
+config FDC37M81X
+    bool
+    select ISA_SUPERIO
+
 config PC87312
     bool
     select ISA_SUPERIO
diff --git a/hw/isa/meson.build b/hw/isa/meson.build
index 2ab99ce0c6b..f650b395071 100644
--- a/hw/isa/meson.build
+++ b/hw/isa/meson.build
@@ -4,6 +4,7 @@ system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('isa-bus.c'))
 system_ss.add(when: 'CONFIG_ISA_SUPERIO', if_true: files('isa-superio.c'))
 system_ss.add(when: 'CONFIG_PC87312', if_true: files('pc87312.c'))
 system_ss.add(when: 'CONFIG_PIIX', if_true: files('piix.c'))
+system_ss.add(when: 'CONFIG_FDC37M81X', if_true: files('fdc37m81x-superio.c'))
 system_ss.add(when: 'CONFIG_SMC37C669', if_true: files('smc37c669-superio.c'))
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686.c'))
 
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index afcfb2b8eca..e57db4f6412 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -1,7 +1,7 @@
 config MALTA
     bool
+    select FDC37M81X
     select GT64120
-    select ISA_SUPERIO
     select PIIX
 
 config MIPSSIM
-- 
2.43.0


