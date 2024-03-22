Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024E4C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjN1-0006Hi-Md; Fri, 22 Mar 2024 14:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjMp-0006GQ-TD
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:11:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjMn-0006yV-WF
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sKz1EYMWvMohSbHGKABPVU60K0D/HveOBbfCcHvL+0Y=;
 b=I39Hm6OPJDaVG1smCBi3GA3Oln2ePaL0+36yL3KKPEJaDab2lVCYmALnk6TPGo3wxn3S0F
 1v0YgbJ5jQQ2U8c2Oh0upS8r2fDt10eUO2H4iCaDJsNfUKZMzE8mCqKhMW2va3Eh+vLrD1
 xqMSLmr6XivG2D+o+Rzq2AuBJiSNCyg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-1WzJHGZiN5qIdjx-uZwYGA-1; Fri, 22 Mar 2024 14:11:42 -0400
X-MC-Unique: 1WzJHGZiN5qIdjx-uZwYGA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3fb52f121eso132911266b.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131100; x=1711735900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sKz1EYMWvMohSbHGKABPVU60K0D/HveOBbfCcHvL+0Y=;
 b=mHaHhzNCbam2Hna6y4ekIlHEh4rIQwqmtR+G1G2f/3AgTMD+yF4uhBRzyX47Irtutu
 inpvLmPA9rIuHvpM4l8nTRB56EBa9dbL5T4lNwIFGtocIYyeFsgElKmJwuTPcBroGnK5
 R6cAMmL+Cf4zA+ZZlVR3dOUrqRkD1qDfAg3cr4659PzvLbDHJ/KgXtTNKfjGPmrSR8Vn
 Dveo7+IXXk/IaYsUXZM1ZhXztPluyekklbJlnTfD69CZ33kucjg5aiOkuCVcstOYXHAN
 XjJ05yO6/BKsyeyY7AkEotbhqmys8H4i3sOCxWhKOBhhSAjcXwlUMhjUoC67JW/4Rqmy
 QyUA==
X-Gm-Message-State: AOJu0Yw9LB8RU/aOeO+kgSBLCiz8yv7M1GGrZUqcabwQ67yRSgBWtRmP
 2fC9G1R7RWLlEHG/+GXky+4ajkJlV/0q2HN/DzQ0Y0sIkk1NNNxVUI4XlghsP2gdndGf3lGBF3Y
 nFNIH43SuFfSCuepIMlUMC6/MsQ3+m87oCrPLjmG0V5A94/yCOCO9TfFu+OjlQnCqMs+jk0yX8F
 OUfO5zxOsEL8N3oTyOpaN1IE4OQKsNBoP+n9Rv
X-Received: by 2002:a17:906:1986:b0:a46:6fe4:af27 with SMTP id
 g6-20020a170906198600b00a466fe4af27mr321737ejd.24.1711131100097; 
 Fri, 22 Mar 2024 11:11:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWDaaHZKPF4/Ud7gNL/dd0Co5gmsSUoej8q5FH2vAIiF/1xGr1pny1OHIq19/TE9miADjMkg==
X-Received: by 2002:a17:906:1986:b0:a46:6fe4:af27 with SMTP id
 g6-20020a170906198600b00a466fe4af27mr321718ejd.24.1711131099741; 
 Fri, 22 Mar 2024 11:11:39 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 e25-20020a170906845900b00a4673706b4dsm75949ejy.78.2024.03.22.11.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:11:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 06/26] s390: Switch to use confidential_guest_kvm_init()
Date: Fri, 22 Mar 2024 19:10:56 +0100
Message-ID: <20240322181116.1228416-7-pbonzini@redhat.com>
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

Use unified confidential_guest_kvm_init() for consistency with
other architectures.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-Id: <20240229060038.606591-1-xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/s390x/kvm/pv.h      | 14 --------------
 hw/s390x/s390-virtio-ccw.c |  5 ++++-
 target/s390x/kvm/pv.c      |  8 ++++++++
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/s390x/kvm/pv.h b/target/s390x/kvm/pv.h
index 5877d28ff10..4b408174391 100644
--- a/target/s390x/kvm/pv.h
+++ b/target/s390x/kvm/pv.h
@@ -80,18 +80,4 @@ static inline int kvm_s390_dump_mem_state(uint64_t addr, size_t len,
 static inline int kvm_s390_dump_completion_data(void *buff) { return 0; }
 #endif /* CONFIG_KVM */
 
-int s390_pv_kvm_init(ConfidentialGuestSupport *cgs, Error **errp);
-static inline int s390_pv_init(ConfidentialGuestSupport *cgs, Error **errp)
-{
-    if (!cgs) {
-        return 0;
-    }
-    if (kvm_enabled()) {
-        return s390_pv_kvm_init(cgs, errp);
-    }
-
-    error_setg(errp, "Protected Virtualization requires KVM");
-    return -1;
-}
-
 #endif /* HW_S390_PV_H */
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index b1dcb3857f0..e35b90ed83c 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "exec/ram_addr.h"
+#include "exec/confidential-guest-support.h"
 #include "hw/s390x/s390-virtio-hcall.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
@@ -260,7 +261,9 @@ static void ccw_init(MachineState *machine)
     s390_init_cpus(machine);
 
     /* Need CPU model to be determined before we can set up PV */
-    s390_pv_init(machine->cgs, &error_fatal);
+    if (machine->cgs) {
+        confidential_guest_kvm_init(machine->cgs, &error_fatal);
+    }
 
     s390_flic_init();
 
diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index 7ca7faec73e..c04d53753bf 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -340,6 +340,11 @@ int s390_pv_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         return 0;
     }
 
+    if (!kvm_enabled()) {
+        error_setg(errp, "Protected Virtualization requires KVM");
+        return -1;
+    }
+
     if (!s390_has_feat(S390_FEAT_UNPACK)) {
         error_setg(errp,
                    "CPU model does not support Protected Virtualization");
@@ -364,6 +369,9 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(S390PVGuest,
 
 static void s390_pv_guest_class_init(ObjectClass *oc, void *data)
 {
+    ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
+
+    klass->kvm_init = s390_pv_kvm_init;
 }
 
 static void s390_pv_guest_init(Object *obj)
-- 
2.44.0


