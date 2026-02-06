Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A224EE6B66
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTfc-0007dW-MH; Fri, 06 Feb 2026 16:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTeX-0005rb-D1
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:46:17 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTeV-0002fT-Oc
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:46:13 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so1598946f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414370; x=1771019170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVyVPMNTDVkZJhgsUBfaZ+2RLKBm/y39t49V3pygcas=;
 b=eyi+6LkPqVzTeBItwuJoQNrvKXx8RBA1iKu9au3F73AG1rTYiLr6GgoC3nRQlQ+b/G
 8Gwt/vLgeac5sFglWU0MRZfFg0xwfVf2tBdmChmRwnwIGfdO8VbrkT693s5NEID8EUAH
 TmkKmmTqq9bFFuuX11Ybb2ouIPUZmwKCrS9AzX5YNr4+r7vFKhtYMbS7d1tTvrSLCyZY
 rSVppTVA+XIuVnhN9+4tciC25le9tO7MdM+x1DjHFZWxrVTWLxHas/VK+oSEOq/domNV
 aWpbKMzNRtAGEMuuBNYZWoz4e6PishvHnd15X3IsNC7t1xnIN087Tuq8Xg9vXqL9hlBX
 yTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414370; x=1771019170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iVyVPMNTDVkZJhgsUBfaZ+2RLKBm/y39t49V3pygcas=;
 b=hWzIjdGDCCjf16K5Jn2POSamQT5KrYizaxH630aS++eDYWvTIVoEwYPTvkh2qaT8nP
 RDIftr0CLl8xvR23c409jQ8vlMSK68q7CU2rFCGt6Xz39QDWY4m2UO50nU0E6dYBxCHp
 VOJ0+3iZI0DC2suMJ+xIsBZy/F6sJjAsmWMuFsk6Qyd8bt3jpZj9YXxfIc7jQVwldWfj
 FP2MMcJya0ws3KcVUXq2JsSeS/A2iIbNdo/67dwCl1picqaJ4q0X8c0nUO52U5U+zYBj
 liG19lRHohLWY4WQ1z7MUtsVhmQOkqar7cV47KDBw4RFatAjy8EFnr4nKlIl0eaJTmfp
 mBJQ==
X-Gm-Message-State: AOJu0Yx/4ljCuGO1eMNJm7UpV9eoGvt2v84bsDU+MOa9pvO0Z2CSPn0I
 0Ann2e2abDeriWmiYvRPQ+pclQFdsAOuCYA26bd00eqKTXgtUTfcKohuOsNqUwX2oTx5IIWMYmp
 wmoKlPuU=
X-Gm-Gg: AZuq6aL4dKylLEK/RYCNwC1ehheOTm4lPNPnuXTr4kGF7LwMjh1/C+7JQt7s17IQGis
 gWPMZylHBoJ1SRYr5yLXWuQnRjdODxh6wJmv1UtgekQZG4i6iPlolqDgJD1Ct5EUSHJgh/s+snv
 /FZHhMUWlAdqy1ShP4PIKzZW4UFlpiwwvEXLFOoS5x3RAF1N7U3Olz3uhuMyDCXwywAv4XVpYDV
 ep0+nMxTHavxM5KWXY7JlHEqJB9ZpDnMGdHaJuksenOsQY9L34oOCEKwix0EpIPsAeUl8qk9G6c
 o5OAAHpCOYw5KCOImGnwWQI0K91OzJMVkDQojU27nlnPmpyE17XBz/nutadOg6bBD3P0IW0YPdy
 Bog+98k90OlMYLeLNsNJ+hjwSyIrICjshu2x77WJz31HgSAlbLcgj4n5gTAZG3yl6hhw7ZaOeTB
 Cpe5SL2m3B0/1LoFsIxV2040g66q0K+s7qU8JOZWs6AXiTTFeZrl1cE9E3N3nf
X-Received: by 2002:a05:6000:2507:b0:435:960c:5286 with SMTP id
 ffacd0b85a97d-436293b24f1mr6835989f8f.58.1770414369875; 
 Fri, 06 Feb 2026 13:46:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296b20fasm9178296f8f.6.2026.02.06.13.46.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:46:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 12/30] target/arm/arm-qmp-cmds.c: make compilation unit common
Date: Fri,  6 Feb 2026 22:44:30 +0100
Message-ID: <20260206214448.22008-13-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Move gic_cap_kvm_probe to target/arm/kvm.c to remove #ifdef CONFIG_KVM.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260206042150.912578-2-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/kvm_arm.h      |  3 +++
 target/arm/arm-qmp-cmds.c | 27 +++------------------------
 target/arm/kvm-stub.c     |  5 +++++
 target/arm/kvm.c          | 21 +++++++++++++++++++++
 target/arm/meson.build    |  2 +-
 5 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 6a9b6374a6d..cc0b374254e 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -11,6 +11,7 @@
 #ifndef QEMU_KVM_ARM_H
 #define QEMU_KVM_ARM_H
 
+#include "qapi/qapi-types-misc-arm.h"
 #include "system/kvm.h"
 #include "target/arm/cpu-qom.h"
 
@@ -263,4 +264,6 @@ void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
 
 void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level);
 
+void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
+
 #endif
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 45df15de782..83ec95c290f 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -43,29 +43,6 @@ static GICCapability *gic_cap_new(int version)
     return cap;
 }
 
-static inline void gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
-{
-#ifdef CONFIG_KVM
-    int fdarray[3];
-
-    if (!kvm_arm_create_scratch_host_vcpu(fdarray, NULL)) {
-        return;
-    }
-
-    /* Test KVM GICv2 */
-    if (kvm_device_supported(fdarray[1], KVM_DEV_TYPE_ARM_VGIC_V2)) {
-        v2->kernel = true;
-    }
-
-    /* Test KVM GICv3 */
-    if (kvm_device_supported(fdarray[1], KVM_DEV_TYPE_ARM_VGIC_V3)) {
-        v3->kernel = true;
-    }
-
-    kvm_arm_destroy_scratch_host_vcpu(fdarray);
-#endif
-}
-
 GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
 {
     GICCapabilityList *head = NULL;
@@ -74,7 +51,9 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
     v2->emulated = true;
     v3->emulated = true;
 
-    gic_cap_kvm_probe(v2, v3);
+    if (kvm_enabled()) {
+        arm_gic_cap_kvm_probe(v2, v3);
+    }
 
     QAPI_LIST_PREPEND(head, v2);
     QAPI_LIST_PREPEND(head, v3);
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index c93462c5b9b..ea67deea520 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -124,3 +124,8 @@ bool kvm_arm_cpu_post_load(ARMCPU *cpu)
 {
     g_assert_not_reached();
 }
+
+void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 3e35570f15f..ded582e0da0 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2580,3 +2580,24 @@ void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level)
     }
     kvm_arm_set_irq(cs->cpu_index, KVM_ARM_IRQ_TYPE_CPU, irq_id, !!level);
 }
+
+void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
+{
+    int fdarray[3];
+
+    if (!kvm_arm_create_scratch_host_vcpu(fdarray, NULL)) {
+        return;
+    }
+
+    /* Test KVM GICv2 */
+    if (kvm_device_supported(fdarray[1], KVM_DEV_TYPE_ARM_VGIC_V2)) {
+        v2->kernel = true;
+    }
+
+    /* Test KVM GICv3 */
+    if (kvm_device_supported(fdarray[1], KVM_DEV_TYPE_ARM_VGIC_V3)) {
+        v3->kernel = true;
+    }
+
+    kvm_arm_destroy_scratch_host_vcpu(fdarray);
+}
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 462c71148d2..1a1bcde2601 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -16,7 +16,7 @@ arm_common_ss.add(files(
   'mmuidx.c',
 ))
 
-arm_system_ss.add(files(
+arm_common_system_ss.add(files(
   'arm-qmp-cmds.c',
 ))
 arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
-- 
2.52.0


