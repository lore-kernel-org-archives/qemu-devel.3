Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37E0C54E6A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rma15-0005as-PU; Tue, 19 Mar 2024 10:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rma0y-0005YT-Cc
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rma0v-000742-M6
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710856825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RqJQm4y6zppoxY68MoDm2jDZIZGmDU1FCx6RM46Mbno=;
 b=eqTyeu0rcG/Srjm5jbAwYftGwbKxrwaoEIqZ3YG8oCKVqd6Cu5I2rYYpnRISFVB9A5aLD8
 Hh2376CL0O6KfpKE1h39E5mwqVbwu8B/8bB5uATHhQyTboZL01Iq3h3XvnsCxd4+MMt1t+
 YiyoILFrhm3z9S+yp5ae+gYSXsd7kGU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-KJPQm6BvOg-E3mu90vAEKw-1; Tue, 19 Mar 2024 10:00:22 -0400
X-MC-Unique: KJPQm6BvOg-E3mu90vAEKw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-513e214be2aso2728989e87.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710856819; x=1711461619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RqJQm4y6zppoxY68MoDm2jDZIZGmDU1FCx6RM46Mbno=;
 b=UDEqnYFG9alKcDwqUWuKHeG9u4P5xX4lT7X9jBOVKR86BNVk5dGWKLr47ImDECoiXE
 Gs1r/NinFnpPvubm/WOz1P824Faqjz7uQi6/f5wxPG2yj/9MEBfF4upi9w2QzW3vG7rs
 zAjOfADbuLyZvL0PsgN5oPEKDp3S1I6NZtPVXxziS8DyRzRLkUiPbDXu0dMeTvF1IYSb
 WhQDG9O9IgCedf8sRNl6vEdD8poKksn+qb/rORQm1XMiiLbwQxmco9iuGdiMdhp26JyJ
 OyiDjyWqJbkL79Y2/RQynNZJBc9osYOla1PY6fxXKPH7ygksv6v5ebPNRFp38MEsCM3h
 w9Lw==
X-Gm-Message-State: AOJu0Ywsd5+U4aruaTJz1wM0EXnY6XtsKNmRJrPWCUkN4D4lAG70jbE6
 iaVRKpTit8O27D/BAaFUc/IliUsbEfhpXg53fQ/iy+WoJiNXKA8cMLGj4xkN6gXSkr6f32nZfcA
 FzIePf+VemGJe2EQdaXbZnL9fQ8703Rsbjradq3HyqhPenmtPEdHSjPM0TEJcL8Lx4dWkcl7ORd
 H5Bg+wDpDwQWi6/dsy3Y8m0EU17CrcUp+DlOe2
X-Received: by 2002:a05:6512:2e7:b0:513:cf77:48c5 with SMTP id
 m7-20020a05651202e700b00513cf7748c5mr7978790lfq.38.1710856819363; 
 Tue, 19 Mar 2024 07:00:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuOtePUmsOTK1hlN3aQyO932UZt77tS5HkS+UAl0E7Ihzz3w6oFYRSgTnqMYjFm8ecPXMAEQ==
X-Received: by 2002:a05:6512:2e7:b0:513:cf77:48c5 with SMTP id
 m7-20020a05651202e700b00513cf7748c5mr7978763lfq.38.1710856818818; 
 Tue, 19 Mar 2024 07:00:18 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 kt6-20020a170906aac600b00a4673706b4dsm5904073ejb.78.2024.03.19.07.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 07:00:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com
Subject: [PATCH 5/7] target/i386: introduce x86-confidential-guest
Date: Tue, 19 Mar 2024 14:59:58 +0100
Message-ID: <20240319140000.1014247-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319140000.1014247-1-pbonzini@redhat.com>
References: <20240319140000.1014247-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

Introduce a common superclass for x86 confidential guest implementations.
It will extend ConfidentialGuestSupportClass with a method that provides
the VM type to be passed to KVM_CREATE_VM.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/confidential-guest.h | 40 ++++++++++++++++++++++++++++++++
 target/i386/confidential-guest.c | 33 ++++++++++++++++++++++++++
 target/i386/sev.c                |  6 ++---
 target/i386/meson.build          |  2 +-
 4 files changed, 77 insertions(+), 4 deletions(-)
 create mode 100644 target/i386/confidential-guest.h
 create mode 100644 target/i386/confidential-guest.c

diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
new file mode 100644
index 00000000000..ca12d5a8fba
--- /dev/null
+++ b/target/i386/confidential-guest.h
@@ -0,0 +1,40 @@
+/*
+ * x86-specific confidential guest methods.
+ *
+ * Copyright (c) 2024 Red Hat Inc.
+ *
+ * Authors:
+ *  Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef TARGET_I386_CG_H
+#define TARGET_I386_CG_H
+
+#include "qom/object.h"
+
+#include "exec/confidential-guest-support.h"
+
+#define TYPE_X86_CONFIDENTIAL_GUEST "x86-confidential-guest"
+
+OBJECT_DECLARE_TYPE(X86ConfidentialGuest,
+                    X86ConfidentialGuestClass,
+                    X86_CONFIDENTIAL_GUEST)
+
+struct X86ConfidentialGuest {
+    /* <private> */
+    ConfidentialGuestSupport parent_obj;
+};
+
+/**
+ * X86ConfidentialGuestClass:
+ *
+ * Class to be implemented by confidential-guest-support concrete objects
+ * for the x86 target.
+ */
+struct X86ConfidentialGuestClass {
+    /* <private> */
+    ConfidentialGuestSupportClass parent;
+};
+#endif
diff --git a/target/i386/confidential-guest.c b/target/i386/confidential-guest.c
new file mode 100644
index 00000000000..b3727845adc
--- /dev/null
+++ b/target/i386/confidential-guest.c
@@ -0,0 +1,33 @@
+/*
+ * QEMU Confidential Guest support
+ *
+ * Copyright (C) 2024 Red Hat, Inc.
+ *
+ * Authors:
+ *  Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "confidential-guest.h"
+
+OBJECT_DEFINE_ABSTRACT_TYPE(X86ConfidentialGuest,
+                            x86_confidential_guest,
+                            X86_CONFIDENTIAL_GUEST,
+                            CONFIDENTIAL_GUEST_SUPPORT)
+
+static void x86_confidential_guest_class_init(ObjectClass *oc, void *data)
+{
+}
+
+static void x86_confidential_guest_init(Object *obj)
+{
+}
+
+static void x86_confidential_guest_finalize(Object *obj)
+{
+}
diff --git a/target/i386/sev.c b/target/i386/sev.c
index c49a8fd55eb..ebe36d4c10c 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -35,7 +35,7 @@
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
 #include "qapi/qapi-commands-misc-target.h"
-#include "exec/confidential-guest-support.h"
+#include "confidential-guest.h"
 #include "hw/i386/pc.h"
 #include "exec/address-spaces.h"
 
@@ -54,7 +54,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(SevGuestState, SEV_GUEST)
  *         -machine ...,memory-encryption=sev0
  */
 struct SevGuestState {
-    ConfidentialGuestSupport parent_obj;
+    X86ConfidentialGuest parent_obj;
 
     /* configuration parameters */
     char *sev_device;
@@ -1372,7 +1372,7 @@ sev_guest_instance_init(Object *obj)
 
 /* sev guest info */
 static const TypeInfo sev_guest_info = {
-    .parent = TYPE_CONFIDENTIAL_GUEST_SUPPORT,
+    .parent = TYPE_X86_CONFIDENTIAL_GUEST,
     .name = TYPE_SEV_GUEST,
     .instance_size = sizeof(SevGuestState),
     .instance_finalize = sev_guest_finalize,
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 7c74bfa8591..8abce725f86 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -6,7 +6,7 @@ i386_ss.add(files(
   'xsave_helper.c',
   'cpu-dump.c',
 ))
-i386_ss.add(when: 'CONFIG_SEV', if_true: files('host-cpu.c'))
+i386_ss.add(when: 'CONFIG_SEV', if_true: files('host-cpu.c', 'confidential-guest.c'))
 
 # x86 cpu type
 i386_ss.add(when: 'CONFIG_KVM', if_true: files('host-cpu.c'))
-- 
2.44.0


