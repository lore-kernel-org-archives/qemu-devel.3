Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C510C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjNO-0006jR-Fr; Fri, 22 Mar 2024 14:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNE-0006W9-CZ
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNA-00072t-TD
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RqJQm4y6zppoxY68MoDm2jDZIZGmDU1FCx6RM46Mbno=;
 b=YjYywoei7oplI+9+hLomq8nGqXr4IzG5SpuIWG3pBGqTYiC5WmbZyebar3zxC7iuODlPCd
 hMsex5rDhByer5XzqyaZjGZD4M+ZkD8xm5X1szqqWdei1FRbc/GEnzaAWnDdYBw0sZXwXy
 1+kpzBabKwYnEWm8AnTS4qoO9T1FYp4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-X6RmTzM-MvuBX8v1tn96og-1; Fri, 22 Mar 2024 14:12:07 -0400
X-MC-Unique: X6RmTzM-MvuBX8v1tn96og-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5159663d035so1826776e87.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131124; x=1711735924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RqJQm4y6zppoxY68MoDm2jDZIZGmDU1FCx6RM46Mbno=;
 b=NYe+FTpTVQxSrRJTMY8QVRRzm+uxwti6PmkqdvGXfZzECMaHUaXxE2ZY4wufPiQ64Z
 92gh7cg85L3OQau3BmljlX0zekZPrrzLzBO5kJgtk0HO/+dvc2zeM0UUFG2uG/0MNSnx
 G5bk5Shg6yH2eguNoHVDLwWN7CWIdIZN01uQl2UtMsMcK0fL9w9qRp6o+DoUQJTf5jyI
 n5EM4P0myq6kT3wpQk+WCMX/khaEJmPEooRaNb/xX8+BSVeQ7QbAlW9tKypFI8MRK5RN
 rfb13U0RtvRMTMEZR0KKOV5WklwYUZM/Ne/V4qZJb2RXWv/NTsBzOPE/YSlCfnJNVjkw
 FkKw==
X-Gm-Message-State: AOJu0YykoklH3ijloEYxjlTTXFFrBeZNxzzfeViQGfrIkkpqi/wnOfT/
 7DD7C5ON3xNDxmtcMRaXMgtGQYXDQQs0Nh/GjzDdS6wmJc2MbbaqNzsoWREJOCV9mFTXSppZmRo
 lzS/+pbMFQoLCt7m7QEWAbiHC8znAAN/Xod4Nxm+SdjJhpNpe4X/84QjOPsP3aAnLXfLvdQGyBY
 /qx+3IPo2QYsbi7azzPfNBV9GLvPNzqC3sPZQp
X-Received: by 2002:ac2:4841:0:b0:513:c50d:db59 with SMTP id
 1-20020ac24841000000b00513c50ddb59mr172583lfy.15.1711131124580; 
 Fri, 22 Mar 2024 11:12:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlfn1odaWMxicYwTTtOUDe57ePXqvMgswi4BkcRbH9NTAlZ2V7dvVSR69KGGo0zvZNgxZ1BQ==
X-Received: by 2002:ac2:4841:0:b0:513:c50d:db59 with SMTP id
 1-20020ac24841000000b00513c50ddb59mr172562lfy.15.1711131124131; 
 Fri, 22 Mar 2024 11:12:04 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 cf25-20020a170906b2d900b00a470c55dfc7sm76167ejb.75.2024.03.22.11.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:12:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 14/26] target/i386: introduce x86-confidential-guest
Date: Fri, 22 Mar 2024 19:11:04 +0100
Message-ID: <20240322181116.1228416-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322181116.1228416-1-pbonzini@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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


