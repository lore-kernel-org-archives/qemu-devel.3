Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA7DC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 14:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURq5-0002UJ-AD; Mon, 29 Jan 2024 08:38:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rURpu-0002GS-9w
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:38:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rURpq-0000lX-1W
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706535481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/wLNrSOPwnwYcl0GYuXoPrwMHs3/ciQ0o966uZkfutc=;
 b=TWY9lamWDgQMYaMCtb6Kd7iIHTmmYNrtHF7SWDIx1ww93ja03DG4JaqZCCcsH093+cE7FA
 MnUdmOgIBMQ2Ub1OKUlwTCtxpSfpdDt3oG2tJtqKLsy5mvhndEGGd+qJgpuYC20vObSqBI
 iVX3N75UvMVKvoGaN1asnslZ+67TZKI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-_Xv7N__lMXq_0bLdFZMCnA-1; Mon, 29 Jan 2024 08:37:59 -0500
X-MC-Unique: _Xv7N__lMXq_0bLdFZMCnA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a2bc65005feso210045666b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 05:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706535477; x=1707140277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/wLNrSOPwnwYcl0GYuXoPrwMHs3/ciQ0o966uZkfutc=;
 b=YJux8OayHzt0IbRBmDe0ydOGOiJwAaD4VSgCSCdcAbKxtGBvvO3q7OSb/QVsQTdE1d
 zlfgY9tGI7F+po48iLiXPlG4CcJauxm1WxhdKTqtUbFrw7qvPEHJyHC00wwJaho7fB3x
 NxFh7ziKa3rCAGwaTTRQQpAwDo/KX9UwBcMj0fjMBxFeOSPxYKwph+iq/EGNg6PSTE16
 df5w3J+y6FRgs858Y/DyW9Qn9ZhwWwEZVILj4KAdrJ/Mx36/kthu7OFUSrv6xd7Hpuxm
 ExE1gPeJ9rOne98SUdj2NztVbh0QwLKpS18v7TDUJIzYr7fPNw0HdvDo8XBEvHz0FGA8
 smLQ==
X-Gm-Message-State: AOJu0YzFHh/AC6CFFIK+oWxQwk36BkLzvKUZqUS7zOU5orKd44CHZRUD
 Lsfp7yvyLnh+usd+m/nsPaDMS7cQjOD/+wqGHpR1EBzaVvExFJffdXgjfuqkpW/DIuYSp8CPJWH
 j5SRsEr+XfYBVm8nX7gY185+38HB3LRaDSswjZgAa3HB7ty2omYdvvfg4Qmml6Dltqx+iW/TPMJ
 Dz3rao5k+Hu8tN5VIGQYNnloGWVbgGsNumhLLH
X-Received: by 2002:a17:906:f9c3:b0:a31:f7e:8a53 with SMTP id
 lj3-20020a170906f9c300b00a310f7e8a53mr4631399ejb.26.1706535477451; 
 Mon, 29 Jan 2024 05:37:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdtblCbKuN4Wbe3IFW8vItLmP8PZX7ql7ctXhXJNyF9OCgjxRcfC7yvRbkKdjzGayyF/QEiQ==
X-Received: by 2002:a17:906:f9c3:b0:a31:f7e:8a53 with SMTP id
 lj3-20020a170906f9c300b00a310f7e8a53mr4631385ejb.26.1706535477038; 
 Mon, 29 Jan 2024 05:37:57 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a1709062a8500b00a35922ecbccsm1691638eje.203.2024.01.29.05.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 05:37:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 2/4] isa: extract FDC37M81X to a separate file
Date: Mon, 29 Jan 2024 14:37:46 +0100
Message-ID: <20240129133751.1106716-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129133751.1106716-1-pbonzini@redhat.com>
References: <20240129133751.1106716-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

isa-superio.c currently defines a SuperIO chip that depends on
CONFIG_IDE_ISA, but not all users of isa-superio.c depend on that
symbol.  Extract the chip to a separate file so that there is an
obvious place to select IDE_ISA.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/fdc37m81x-superio.c | 37 +++++++++++++++++++++++++++++++++++++
 hw/isa/isa-superio.c       | 19 -------------------
 hw/isa/Kconfig             |  5 +++++
 hw/isa/meson.build         |  1 +
 hw/mips/Kconfig            |  2 +-
 5 files changed, 44 insertions(+), 20 deletions(-)
 create mode 100644 hw/isa/fdc37m81x-superio.c

diff --git a/hw/isa/fdc37m81x-superio.c b/hw/isa/fdc37m81x-superio.c
new file mode 100644
index 00000000000..5ad769b69e8
--- /dev/null
+++ b/hw/isa/fdc37m81x-superio.c
@@ -0,0 +1,37 @@
+/*
+ * Generic ISA Super I/O
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
+/* SMS FDC37M817 Super I/O */
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
+static const TypeInfo fdc37m81x_type_info = {
+    .name          = TYPE_FDC37M81X_SUPERIO,
+    .parent        = TYPE_ISA_SUPERIO,
+    .instance_size = sizeof(ISASuperIODevice),
+    .class_init    = fdc37m81x_class_init,
+};
+
+static void fdc37m81x_register_types(void)
+{
+    type_register_static(&fdc37m81x_type_info);
+}
+
+type_init(fdc37m81x_register_types)
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 7dbfc374da3..80e0c34652e 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -187,28 +187,9 @@ static const TypeInfo isa_superio_type_info = {
     .class_init = isa_superio_class_init,
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
-    .instance_size = sizeof(ISASuperIODevice),
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
index 7884179d08b..af856af052d 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -23,6 +23,11 @@ config ISA_SUPERIO
     # Some users of ISA_SUPERIO do not use it
     #select IDE_ISA
 
+config FDC37M81X
+    bool
+    select ISA_BUS
+    select IDE_ISA
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
index ab61af209a0..94b969c21db 100644
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


