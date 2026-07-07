Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45ADC44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whEVi-0001HD-67; Tue, 07 Jul 2026 18:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVg-0001EG-KX
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:24 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVc-00045J-HX
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:24 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cc7ef7ec27so1332935ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783464199; x=1784068999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dR3NfNdVtBBic7lSVzoRn85byyneAw/58XsEkxNw3ag=;
 b=MSvhoSF6ruHad/lRBTnZAUYk9KvxhJgtb5+6Rqr4Xs1TTGNhqQhgqAKNogyvym9CL3
 FUIH8gMuQTrjBsPVOF2r5R9U7onAtyEbZ+1z45I4HUH9xoWv4O7+mchKMO14m2QKIMMa
 v8FugXW7CNUp5ssZuD7z36oXN1f+4cJ3nLGG/WvLbj7kQP7AolhT+erqhB0STCvBfR2+
 U/2LTeU+O/fXq+AL75SOdeO6TVG2eFm19/MK6CuUK65NJno85cUUP+wNssBDhuu/ju4m
 Fxjl0HsemasiVLplUzj68HNe4wODAAGZzcrfhs33Hu7NZ4KNh/kDSSNISpRlLDuA3z9h
 vigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783464199; x=1784068999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dR3NfNdVtBBic7lSVzoRn85byyneAw/58XsEkxNw3ag=;
 b=MC+DqMkVxcnlai2Wu+V9khjRTeL3jfuwtJjiV//THHd/ac34LHi6CjSsgSgWnOSjyL
 3Wzgp4H3Mu5LXlCOE76lumEVmFlBCO+2EXsFZBXkEJAT7wjOHj17XL2u4/ZOM9eqTDY+
 ffKkPdRsN/FMoUzGLQDrxR1RxCWgEVjlHBgXauNMrNP5IU2ohiGjPTZ86OBD2CxZdaZl
 ClpAxbFZw2FgE7exIaXelrEPuBoFS90LxCnG2SFhNJ+osgEmFyLc+E32qAI+eqz0EovR
 5H7QqV4u0BmdCvGv1aGN5eY4GF3HOf0q7NhsIvrMVC/x9rqkuDqdbaKkLtToscFxJ8KK
 Npzg==
X-Gm-Message-State: AOJu0Yx6AVMEDfOc/X9Ja7txl/mfJdHLZuNB3IBpDbk0QM3Y/35El/LK
 0qkBcnyaUnEsMCoe0bpADKejxEXg9BrL95/EoVxyQH+kIGpZL/uP8hn6968tCooX9Bs=
X-Gm-Gg: AfdE7clLnGZl5UahObdnowPix8IwMyCGm3EFr7CgOoRLOegJjCXy3949j6To4P2gNpS
 XgVmydpDj1RZSfQmQTZClB+2qpkvXGv5R5KEmNrS7KVB6Pjw/PaG8o5MEvKHAY7+wQ0ybnECnHk
 84GGbdDfXmO7V2381lMwaYLy5PLMtbnbki6vJxsmxHCHSNH021QzFUBpqOuwx/mGA5qYuMjENGJ
 1W1qXh1XGzGCqdkSZvBDTnDNa1cIPzCboGEEzPu0A8JL2bCxWtbEAg3sKKxDUunQY6spTChZpCN
 3nHv2W2qYce9JgzwwUw5gAhrufW8TxoGf4gBc8xDc9ux+jmDF5YFetMozU42A1uCHtIJtVgkshF
 oI+3b+E2ntavc7rowCOYMQcQ1he/ebsPPxpq3wL0MVspg81vTqjI3bmZzO8gMiaqwElEBcdHwsi
 1ENs9XCY/O27M2x9qDQjJ3stvKv8yHShdQOBbtyUY=
X-Received: by 2002:a17:902:daca:b0:2ca:e565:7b15 with SMTP id
 d9443c01a7336-2ccbe50aa04mr67799045ad.10.1783464198645; 
 Tue, 07 Jul 2026 15:43:18 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:43:18 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 04/25] target/arm/kvm-rme: Add mechanic to initialize realms
Date: Tue,  7 Jul 2026 16:42:45 -0600
Message-ID: <20260707224306.1202330-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Initialise an @rme_guest object and install a handler to get notified
when the Realm is ready to start.  That way we can finish reading the
Realm once we know everything is in place.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c  | 50 +++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm-stub.c |  5 +++++
 target/arm/kvm.c      |  7 +++++-
 target/arm/kvm_arm.h  |  9 ++++++++
 4 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 42e1d1e7b859..b86b9d6a25cb 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -13,6 +13,7 @@
 #include "kvm_arm.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qom/object_interfaces.h"
 #include "system/confidential-guest-support.h"
 #include "system/kvm.h"
@@ -29,14 +30,63 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
                                           CONFIDENTIAL_GUEST_SUPPORT,
                                           { TYPE_USER_CREATABLE }, { })
 
+static RmeGuest *rme_guest;
+
+static void rme_vm_state_change(void *opaque, bool running, RunState state)
+{
+    if (!running) {
+        return;
+    }
+
+    kvm_mark_guest_state_protected();
+}
+
 static void rme_guest_class_init(ObjectClass *oc, const void *data)
 {
 }
 
 static void rme_guest_init(Object *obj)
 {
+    if (rme_guest) {
+        error_report("a single instance of RmeGuest is supported");
+        exit(1);
+    }
+    rme_guest = RME_GUEST(obj);
 }
 
 static void rme_guest_finalize(Object *obj)
 {
 }
+
+int kvm_arm_rme_init(MachineState *ms, KVMState *s)
+{
+    static Error *rme_mig_blocker;
+    ConfidentialGuestSupport *cgs = ms->cgs;
+
+    if (!rme_guest) {
+        return 0;
+    }
+
+    if (!cgs) {
+        error_report("missing -machine confidential-guest-support parameter");
+        return -EINVAL;
+    }
+
+    if (!kvm_vm_check_extension(s, KVM_CAP_ARM_RMI)) {
+        error_report("KVM doesn't support Realms");
+        return -ENODEV;
+    }
+
+    error_setg(&rme_mig_blocker, "RME: migration is not implemented");
+    migrate_add_blocker(&rme_mig_blocker, &error_fatal);
+
+    /*
+     * The realm activation is done last, when the VM starts, after all images
+     * have been loaded and all vcpus finalized.
+     */
+    qemu_add_vm_change_state_handler(rme_vm_state_change, NULL);
+
+    cgs->require_guest_memfd = true;
+    cgs->ready = true;
+    return 0;
+}
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 88cbe8d85c41..eec1ca3dd2e5 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -119,3 +119,8 @@ char *kvm_print_register_name(uint64_t regidx)
 {
     g_assert_not_reached();
 }
+
+int kvm_arm_rme_init(MachineState *ms, KVMState *s)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ed99be7fd80c..28d5643d6779 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -660,7 +660,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
-    return 0;
+    ret = kvm_arm_rme_init(ms, s);
+    if (ret) {
+        error_report("Failed to enable RME: %s", strerror(-ret));
+    }
+
+    return ret;
 }
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index e7c40fb003e4..6d058b0e08a2 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -240,4 +240,13 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
  */
 char *kvm_print_register_name(uint64_t regidx);
 
+/**
+ * kvm_arm_rme_init
+ * @ms: the machine state
+ * @s: State of KVM
+ *
+ * Prepare the machine to be a Realm, if the user enabled it.
+ */
+int kvm_arm_rme_init(MachineState *ms, KVMState *s);
+
 #endif
-- 
2.43.0


