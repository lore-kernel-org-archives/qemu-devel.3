Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EB9C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 11:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXfsx-0002st-JW; Wed, 07 Feb 2024 06:14:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXfsu-0002sP-OC
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:14:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXfst-0003RA-26
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707304470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKhWTRg2zOTnE9OJbj6ui0Mke5/Ni7WWZc/qd5ynn60=;
 b=Xzv1cdSE3dlxEqLNnChzI+hx5Cu/jeKin4WYqx8bNYgzNNWZX2+iqOKiiiLvwCvHqC6BfK
 ZZYmJX/jnMzYdxP17nwA8yrM6VMjgwYlSHA3261c30tADXQUi4161cEaZpFcRGu7MxCtaM
 0ZRg0Y8rSpl/SUI8/iHnQiAVqD6/hPw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-CGPTnnidMXOkfEWc-m0wxw-1; Wed, 07 Feb 2024 06:14:29 -0500
X-MC-Unique: CGPTnnidMXOkfEWc-m0wxw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5605a2937d4so234418a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 03:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707304467; x=1707909267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GKhWTRg2zOTnE9OJbj6ui0Mke5/Ni7WWZc/qd5ynn60=;
 b=DcR+soM64FRLgZ6Kv+9Wuf8YLpIHHosMOKi983irQf5UxmmmglA1xV9vRzNY3DueEK
 ELuoj0Boq1iz3cpvfoKkoY1Qbs50JjL5pUmj9roiuoqdhT4V5ujKKZKMxSymvOgphiUR
 VmZwwy2NrxqbxfDAATS95c9Oc6sRnqW8CeWyhQRhN6j/4Rz4ILAZYx4J+c0qBninwX0r
 TI5mQ/SzY36u4PpTTMfne1FH6GqJdqkD9BuBRjwq4wNzO4avB4ym1FHBXN38om/6qNhl
 220fTus4v0dYlykIDScpYdIOuGkwGWqruwKpyruXwsFKgJujOZNgZk7T4Bqt5oI7OkFP
 gwfg==
X-Gm-Message-State: AOJu0Ywf75lo5xKHuCT4SijPrb/0fveAAO23uKcGAx2JO36ctcM7be6b
 v6g46qXBuu5eq6KftLcznrTuwrHWffG/wsVWS6jxT37CSoybRLS/PEKKVK1o/zrglMdWLB2ZPZU
 p5faFnIK//GfuaDqj7Ew7WQlHtlZNi40l6cmAjlFxdpN+soITRM3y9wp1KbgUxg9881LvppG3hl
 C7yS0JJ9R6fClknGyHe6aNriv3kkIgYHVdSzsr
X-Received: by 2002:a05:6402:2297:b0:560:b758:5e24 with SMTP id
 cw23-20020a056402229700b00560b7585e24mr2980366edb.0.1707304467518; 
 Wed, 07 Feb 2024 03:14:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8IcOc8ktNPSWavxQV3k/ItXtVp8TenHKbGlepN8a3z5faXGerVWdFHe1t//5ieEsliIiVdA==
X-Received: by 2002:a05:6402:2297:b0:560:b758:5e24 with SMTP id
 cw23-20020a056402229700b00560b7585e24mr2980346edb.0.1707304467101; 
 Wed, 07 Feb 2024 03:14:27 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUGWHS+AAV42q0UVzGmb8Hc+l9XNiGGmf2jBpzMYkkbqNZmNkLBtJtJZ7d0Nl6Y1dNFzMZ00p49FCzqMVAyOr9doQ==
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a056402434500b00560c43b48f4sm546040edc.10.2024.02.07.03.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 03:14:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: shentey@gmail.com,
	philmd@linaro.org
Subject: [PATCH v2 6/8] isa: extract FDC37M81X to a separate file
Date: Wed,  7 Feb 2024 12:14:08 +0100
Message-ID: <20240207111411.115040-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207111411.115040-1-pbonzini@redhat.com>
References: <20240207111411.115040-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

isa-superio.c currently defines a SuperIO chip that is not used
by any other user of the faile.  Extract the chip to a separate file.

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


