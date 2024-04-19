Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A6BC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqho-0006Su-7H; Fri, 19 Apr 2024 12:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqej-0001Fl-As
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:07 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqea-000191-M1
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:02 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d715638540so27541081fa.3
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542395; x=1714147195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0sA7sQRj9S8478926YbMyMtx1fea3V/JVwzEIyV34Xk=;
 b=gPDsxUPqx3r5SN4DtKYYnvhP5G152iMBeq9ZCh+uPit4buHqfOa0BBj4n66gMM+Iqt
 v/VZR9T4LHLu7Qqu/ds3VM3+yXSRRhqejsTPxL6xYvGkEypE5Qkm5Q4cawqsX21vCUM8
 GNqRHV4FRG2ri2LgH/2SKcG5b2oTtmP0UrOa/Jt9EYfY5g0oNk5q+k9sVvh5gbSY79PO
 hvpRC4H2Bmc0rMgrHZxsFYjNWmIuQyIGU4FkyVLoFyUFGWNZzNHeBLk4pivO1zd6y9j5
 EffBGoeOZj2gh+AmLAvw4KWTCCvPsJvaUTGxDsmRPq4uCtXK6Xu/em98r9ShX9BEb3w5
 x/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542395; x=1714147195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0sA7sQRj9S8478926YbMyMtx1fea3V/JVwzEIyV34Xk=;
 b=VHbt4fkBqq5b2PeJQAwa86evoIhmxulfj+hNZKTScPlBJAbCoNmynzStKc9iN/HJbn
 xifjksEygsiTGtvnnl6mjJxO4xFYc3pYpaLltk+IeCMSFr9daZHQ0JTncVay+Q1DPvjs
 LZ0+XVRuv568W/SSYtqAeKQ4833tOXj8vYyIxRr4wPcVQtRtTYsQpPho9QHsRF3biqF5
 CuJN/3/0uHqm6zIWm0d1cbsk5w1jCv4+nyfw+jTGUE8S2oQofNn5C/+4WBHQJ9LTzCtU
 YMwIfTyxUztXon66AFpP0A4KKPXHIRFlvBomJQ/zvf/TiPQEu5QF+5ZelL5yktDbHr56
 mCzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt5tXhld37Kh1jvMC1V5AJlNJrX9lrlGlQmBhgnGNWOwlBUkSuaTpeATokXvXmFEv1dkiHFDCVoPZG2OpNhn/R6t1e11E=
X-Gm-Message-State: AOJu0Yz45C0LdJftZrO5lX42fmrYncoXW0vlRrAQJUu16uHjTbvTDepO
 0aTXJ7dCP93Pabh7oYOw4JVZhYxVIiGKOueEUI0IFO09fKhmRK+knnJWK7jN1tc=
X-Google-Smtp-Source: AGHT+IFfQi+a8Yue9CKu52ltaOyqCZ506+N2z0+WdOQedFIdKEWuv3ocq7AR6ZTSkFjbZvW+CXb+VA==
X-Received: by 2002:a2e:855a:0:b0:2da:6f19:d359 with SMTP id
 u26-20020a2e855a000000b002da6f19d359mr1512569ljj.2.1713542394779; 
 Fri, 19 Apr 2024 08:59:54 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.08.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:59:54 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 12/22] target/arm/kvm-rme: Populate Realm memory
Date: Fri, 19 Apr 2024 16:57:00 +0100
Message-ID: <20240419155709.318866-14-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=jean-philippe@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Collect the images copied into guest RAM into a sorted list, and issue
POPULATE_REALM KVM ioctls once we've created the Realm Descriptor. The
images are part of the Realm Initial Measurement.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2: Use a ROM loader notifier
---
 target/arm/kvm-rme.c | 97 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index aa9c3b5551..bee6694d6d 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -9,9 +9,11 @@
 #include "exec/confidential-guest-support.h"
 #include "hw/boards.h"
 #include "hw/core/cpu.h"
+#include "hw/loader.h"
 #include "kvm_arm.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qom/object_interfaces.h"
 #include "sysemu/kvm.h"
 #include "sysemu/runstate.h"
@@ -19,10 +21,21 @@
 #define TYPE_RME_GUEST "rme-guest"
 OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 
+#define RME_PAGE_SIZE qemu_real_host_page_size()
+
 struct RmeGuest {
     ConfidentialGuestSupport parent_obj;
+    Notifier rom_load_notifier;
+    GSList *ram_regions;
 };
 
+typedef struct {
+    hwaddr base;
+    hwaddr len;
+    /* Populate guest RAM with data, or only initialize the IPA range */
+    bool populate;
+} RmeRamRegion;
+
 static RmeGuest *rme_guest;
 
 bool kvm_arm_rme_enabled(void)
@@ -41,6 +54,41 @@ static int rme_create_rd(Error **errp)
     return ret;
 }
 
+static void rme_populate_realm(gpointer data, gpointer unused)
+{
+    int ret;
+    const RmeRamRegion *region = data;
+
+    if (region->populate) {
+        struct kvm_cap_arm_rme_populate_realm_args populate_args = {
+            .populate_ipa_base = region->base,
+            .populate_ipa_size = region->len,
+            .flags = KVM_ARM_RME_POPULATE_FLAGS_MEASURE,
+        };
+        ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_RME, 0,
+                                KVM_CAP_ARM_RME_POPULATE_REALM,
+                                (intptr_t)&populate_args);
+        if (ret) {
+            error_report("RME: failed to populate realm (0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx"): %s",
+                         region->base, region->len, strerror(-ret));
+            exit(1);
+        }
+    } else {
+        struct kvm_cap_arm_rme_init_ipa_args init_args = {
+            .init_ipa_base = region->base,
+            .init_ipa_size = region->len,
+        };
+        ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_RME, 0,
+                                KVM_CAP_ARM_RME_INIT_IPA_REALM,
+                                (intptr_t)&init_args);
+        if (ret) {
+            error_report("RME: failed to initialize GPA range (0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx"): %s",
+                         region->base, region->len, strerror(-ret));
+            exit(1);
+        }
+    }
+}
+
 static void rme_vm_state_change(void *opaque, bool running, RunState state)
 {
     int ret;
@@ -55,6 +103,9 @@ static void rme_vm_state_change(void *opaque, bool running, RunState state)
         return;
     }
 
+    g_slist_foreach(rme_guest->ram_regions, rme_populate_realm, NULL);
+    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
+
     /*
      * Now that do_cpu_reset() initialized the boot PC and
      * kvm_cpu_synchronize_post_reset() registered it, we can finalize the REC.
@@ -75,6 +126,49 @@ static void rme_vm_state_change(void *opaque, bool running, RunState state)
     }
 }
 
+static gint rme_compare_ram_regions(gconstpointer a, gconstpointer b)
+{
+        const RmeRamRegion *ra = a;
+        const RmeRamRegion *rb = b;
+
+        g_assert(ra->base != rb->base);
+        return ra->base < rb->base ? -1 : 1;
+}
+
+static void rme_add_ram_region(hwaddr base, hwaddr len, bool populate)
+{
+    RmeRamRegion *region;
+
+    region = g_new0(RmeRamRegion, 1);
+    region->base = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
+    region->len = QEMU_ALIGN_UP(len, RME_PAGE_SIZE);
+    region->populate = populate;
+
+    /*
+     * The Realm Initial Measurement (RIM) depends on the order in which we
+     * initialize and populate the RAM regions. To help a verifier
+     * independently calculate the RIM, sort regions by GPA.
+     */
+    rme_guest->ram_regions = g_slist_insert_sorted(rme_guest->ram_regions,
+                                                   region,
+                                                   rme_compare_ram_regions);
+}
+
+static void rme_rom_load_notify(Notifier *notifier, void *data)
+{
+    RomLoaderNotify *rom = data;
+
+    if (rom->addr == -1) {
+        /*
+         * These blobs (ACPI tables) are not loaded into guest RAM at reset.
+         * Instead the firmware will load them via fw_cfg and measure them
+         * itself.
+         */
+        return;
+    }
+    rme_add_ram_region(rom->addr, rom->max_len, /* populate */ true);
+}
+
 int kvm_arm_rme_init(MachineState *ms)
 {
     static Error *rme_mig_blocker;
@@ -102,6 +196,9 @@ int kvm_arm_rme_init(MachineState *ms)
      */
     qemu_add_vm_change_state_handler(rme_vm_state_change, NULL);
 
+    rme_guest->rom_load_notifier.notify = rme_rom_load_notify;
+    rom_add_load_notifier(&rme_guest->rom_load_notifier);
+
     cgs->ready = true;
     return 0;
 }
-- 
2.44.0


