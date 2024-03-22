Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D3FC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjMs-0006Gi-4G; Fri, 22 Mar 2024 14:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjMl-0006Fg-HY
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjMj-0006xX-Qj
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lS61gCLs7YziC1lAPCrOTzqqeI8VkoEudAEH6HlvNFc=;
 b=MaQU58nO46wdwIxru7h2JkP2DRu+Q+5n46CmDTLjWzaDpBf+kC4smcYlJSPRqolIyTwbJ3
 ZbgYTouhCP+Pnld67TMsg0h4WfTZsvfBewYE4C68VdKG1JL6xV+0apuAq0apK3Hd3sC2/s
 L67m7Y6vdLp1PVB0cLNTcqRpF5dwySM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-M2x_8ASgPd6iL8PFyuMxeQ-1; Fri, 22 Mar 2024 14:11:38 -0400
X-MC-Unique: M2x_8ASgPd6iL8PFyuMxeQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a4736548760so66897166b.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131097; x=1711735897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lS61gCLs7YziC1lAPCrOTzqqeI8VkoEudAEH6HlvNFc=;
 b=sYpUmnTGO5bV3N17fVjCbOpyi0hbXuGP7Viwmwr9p0kfFgUMF37o2U5+8C2vqGq7S6
 saoeCMwRfi3zzalZvRwU1kloDdGNoqEzGeQSr45nJmhR/zkqLmZp4wls1FUuNMezsyQ1
 2+mnNYtlbn1g9eWILOXDuxPT79Nc79ir9c4kYFp9ZORxD/ty/lrchlCq7CAj4lh0Hxel
 CVBDpnx2J5u+xgNwQYdvq8fE3rEJAT0XI/0AInZSV6HYHVSO7xDIlNotzkjU2Rxk5MJn
 QORVgVrrTxelxYkRXuGMbCBFCR/RZzV97YAKztp+Mf0b1CpxjqzigpMHupWjmxLZ+foz
 duwA==
X-Gm-Message-State: AOJu0YxmRvo4AKzENfYwKH/Sc85EuMF7YjXfUvf14wTx3+VKIesdzJMV
 HE9KmSqU21S31Kee4iKxjTwq6PADLxaBNM1JXCU2UmfrbaRo0giMA33Wn60EcQPloR/x3aUeouj
 0/3s5sLA2Y/YBu40I7HJGl1eyN5BQJ/rNd8nHY2X1ihNtjjfk27//GbzWVgL6q/TxCz3QbvzuPj
 BTtByf7a91JrNMZMyVG2VJT8kAD0S8xtYY6RKa
X-Received: by 2002:a17:906:6d8a:b0:a47:2011:11c1 with SMTP id
 h10-20020a1709066d8a00b00a47201111c1mr308323ejt.8.1711131096844; 
 Fri, 22 Mar 2024 11:11:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcxrgzCoc7VjsRg0xYrlLEmbzy6FnUnFowYqI7Sp8SNbdzKS59YFy4h4qMQAcXTT0k9KgfNw==
X-Received: by 2002:a17:906:6d8a:b0:a47:2011:11c1 with SMTP id
 h10-20020a1709066d8a00b00a47201111c1mr308306ejt.8.1711131096601; 
 Fri, 22 Mar 2024 11:11:36 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 a27-20020a170906191b00b00a46bd891b5bsm67953eje.225.2024.03.22.11.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:11:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 05/26] ppc/pef: switch to use
 confidential_guest_kvm_init/reset()
Date: Fri, 22 Mar 2024 19:10:55 +0100
Message-ID: <20240322181116.1228416-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322181116.1228416-1-pbonzini@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Use the unified interface to call confidential guest related kvm_init()
and kvm_reset(), to avoid exposing pef specific functions.

As a bonus, pef.h goes away since there is no direct call from sPAPR
board code to PEF code anymore.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/ppc/pef.h | 17 -----------------
 hw/ppc/pef.c         |  9 ++++++---
 hw/ppc/spapr.c       | 10 +++++++---
 3 files changed, 13 insertions(+), 23 deletions(-)
 delete mode 100644 include/hw/ppc/pef.h

diff --git a/include/hw/ppc/pef.h b/include/hw/ppc/pef.h
deleted file mode 100644
index 707dbe524c4..00000000000
--- a/include/hw/ppc/pef.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * PEF (Protected Execution Facility) for POWER support
- *
- * Copyright Red Hat.
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#ifndef HW_PPC_PEF_H
-#define HW_PPC_PEF_H
-
-int pef_kvm_init(ConfidentialGuestSupport *cgs, Error **errp);
-int pef_kvm_reset(ConfidentialGuestSupport *cgs, Error **errp);
-
-#endif /* HW_PPC_PEF_H */
diff --git a/hw/ppc/pef.c b/hw/ppc/pef.c
index d28ed3ba733..47553348b1e 100644
--- a/hw/ppc/pef.c
+++ b/hw/ppc/pef.c
@@ -15,7 +15,6 @@
 #include "sysemu/kvm.h"
 #include "migration/blocker.h"
 #include "exec/confidential-guest-support.h"
-#include "hw/ppc/pef.h"
 
 #define TYPE_PEF_GUEST "pef-guest"
 OBJECT_DECLARE_SIMPLE_TYPE(PefGuest, PEF_GUEST)
@@ -93,7 +92,7 @@ static int kvmppc_svm_off(Error **errp)
 #endif
 }
 
-int pef_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
+static int pef_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     if (!object_dynamic_cast(OBJECT(cgs), TYPE_PEF_GUEST)) {
         return 0;
@@ -107,7 +106,7 @@ int pef_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     return kvmppc_svm_init(cgs, errp);
 }
 
-int pef_kvm_reset(ConfidentialGuestSupport *cgs, Error **errp)
+static int pef_kvm_reset(ConfidentialGuestSupport *cgs, Error **errp)
 {
     if (!object_dynamic_cast(OBJECT(cgs), TYPE_PEF_GUEST)) {
         return 0;
@@ -131,6 +130,10 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(PefGuest,
 
 static void pef_guest_class_init(ObjectClass *oc, void *data)
 {
+    ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
+
+    klass->kvm_init = pef_kvm_init;
+    klass->kvm_reset = pef_kvm_reset;
 }
 
 static void pef_guest_init(Object *obj)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c417f9dd523..7178da53901 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -74,6 +74,7 @@
 #include "hw/virtio/vhost-scsi-common.h"
 
 #include "exec/ram_addr.h"
+#include "exec/confidential-guest-support.h"
 #include "hw/usb.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
@@ -86,7 +87,6 @@
 #include "hw/ppc/spapr_tpm_proxy.h"
 #include "hw/ppc/spapr_nvdimm.h"
 #include "hw/ppc/spapr_numa.h"
-#include "hw/ppc/pef.h"
 
 #include "monitor/monitor.h"
 
@@ -1714,7 +1714,9 @@ static void spapr_machine_reset(MachineState *machine, ShutdownCause reason)
         qemu_guest_getrandom_nofail(spapr->fdt_rng_seed, 32);
     }
 
-    pef_kvm_reset(machine->cgs, &error_fatal);
+    if (machine->cgs) {
+        confidential_guest_kvm_reset(machine->cgs, &error_fatal);
+    }
     spapr_caps_apply(spapr);
     spapr_nested_reset(spapr);
 
@@ -2840,7 +2842,9 @@ static void spapr_machine_init(MachineState *machine)
     /*
      * if Secure VM (PEF) support is configured, then initialize it
      */
-    pef_kvm_init(machine->cgs, &error_fatal);
+    if (machine->cgs) {
+        confidential_guest_kvm_init(machine->cgs, &error_fatal);
+    }
 
     msi_nonbroken = true;
 
-- 
2.44.0


