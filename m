Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4F4C52D73
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 14:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbL2d-0001Kq-6J; Tue, 06 Aug 2024 10:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbL2Z-00019e-Ef
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:19:55 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbL2W-0004TF-Bg
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:19:54 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5b5b67d0024so1062422a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 07:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722953990; x=1723558790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70dZ265UG/nvEVWlFD0BHxq9nX6raHr8FzG2unqteF0=;
 b=cNvD9IKaCHUFmgZrniHWHPt9EH8xIzoA9Db1dFf6ebHxUQlpTXyP0XgFfRjWihp7Qh
 J7oLkBlsShWFW88Or7QjAa6Tz1oDJ29wCo5KUThzZ1/4F9viJIROuKvb2QbazncKz8MG
 x2hH4NAMrjRV1HEUxBDTHEKe1SjzFnWi/jTNE/nKTVg2GnfZXhrPEtp6z8ZDMhSBdF6P
 Qj50nWLoZn+0W8IDg76wWgmtmEGtv3qFWXxQR4t3kGtGB6iVs2d670rWcUgogIjaJwCm
 zQJYydDU6hLjRf4Ub5T0i6bJrkFNGSCp9RASMkIig50I4+LfLKrCbPho2QdLECB7954M
 d+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722953990; x=1723558790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=70dZ265UG/nvEVWlFD0BHxq9nX6raHr8FzG2unqteF0=;
 b=eBToE6O9irZfnkDqt4szOQyenrmcvfUPi/eyMvXskP0zbt5FnyprMVTCipAfwGF/Vm
 1D6MTM+XEDW23xvswAbI8EH+qcMF7hcwo+IfaK/DHM1l4g2/RQpxGNFghBzWsGt1U1tG
 aMpBHWrKTb8r2uCzpSkkxptmCPuhePSBK/AnELNHTjesSs6i19QAVfRkSYLbA0qoGWNU
 0Wu3Tv890D0mzfncTEdZrhr6pb81pjznQAK203YenGXitrsY+YD2raeRG5uq2f4z/zKH
 A6xlSuT5CiRH8I2F7tsNO5+oJlNwshRpqbgbETyLPdDbGgbbKZ6sHXxyfQV01B4xmRdp
 LUSg==
X-Gm-Message-State: AOJu0YzeVnGfnFFJSnxLiGEfj0/TlUBwxA5CW8bA/Y6g31grWUtVUst2
 MgmTSF+a+VtYKQmE94QWOefZhXBX+TCXMDM/KnJ8UVxYh5ya0Hosd3m9m4j8gY+ZjjSz8Aik1g9
 J
X-Google-Smtp-Source: AGHT+IGYpL9w1iiwBHk85bkzsNH0CGFYdU3ik66UseJhCgEgRNkNvNXOOsg4kYeJmnVqlzB2YG0IYg==
X-Received: by 2002:a17:907:2d91:b0:a71:ddb8:9394 with SMTP id
 a640c23a62f3a-a7dc4ff1ad2mr1102470266b.40.1722953989744; 
 Tue, 06 Aug 2024 07:19:49 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c12ad3sm552622066b.88.2024.08.06.07.19.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 07:19:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1? 1/2] target/arm: Move
 qmp_query_gic_capabilities() to hw/intc/
Date: Tue,  6 Aug 2024 16:19:39 +0200
Message-ID: <20240806141940.22095-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806141940.22095-1-philmd@linaro.org>
References: <20240806141940.22095-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

qmp_query_gic_capabilities() is not specific to the ARM
architecture but to the GIC device which is modelled in
hw/intc/, so move the code there for clarity. No logical
change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/arm_gic_qmp.c     | 59 +++++++++++++++++++++++++++++++++++++++
 target/arm/arm-qmp-cmds.c | 52 +---------------------------------
 hw/intc/meson.build       |  1 +
 3 files changed, 61 insertions(+), 51 deletions(-)
 create mode 100644 hw/intc/arm_gic_qmp.c

diff --git a/hw/intc/arm_gic_qmp.c b/hw/intc/arm_gic_qmp.c
new file mode 100644
index 0000000000..71056a0c10
--- /dev/null
+++ b/hw/intc/arm_gic_qmp.c
@@ -0,0 +1,59 @@
+/*
+ * QEMU ARM GIC QMP command
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/util.h"
+#include "qapi/qapi-commands-misc-target.h"
+#include "kvm_arm.h"
+
+static GICCapability *gic_cap_new(int version)
+{
+    GICCapability *cap = g_new0(GICCapability, 1);
+    cap->version = version;
+    /* by default, support none */
+    cap->emulated = false;
+    cap->kernel = false;
+    return cap;
+}
+
+static inline void gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
+{
+#ifdef CONFIG_KVM
+    int fdarray[3];
+
+    if (!kvm_arm_create_scratch_host_vcpu(NULL, fdarray, NULL)) {
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
+#endif
+}
+
+GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
+{
+    GICCapabilityList *head = NULL;
+    GICCapability *v2 = gic_cap_new(2), *v3 = gic_cap_new(3);
+
+    v2->emulated = true;
+    v3->emulated = true;
+
+    gic_cap_kvm_probe(v2, v3);
+
+    QAPI_LIST_PREPEND(head, v2);
+    QAPI_LIST_PREPEND(head, v3);
+
+    return head;
+}
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 3cc8cc738b..3303c71b21 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -22,64 +22,14 @@
 
 #include "qemu/osdep.h"
 #include "hw/boards.h"
-#include "kvm_arm.h"
+#include "sysemu/kvm.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-commands-machine-target.h"
-#include "qapi/qapi-commands-misc-target.h"
 #include "qapi/qmp/qdict.h"
 #include "qom/qom-qobject.h"
 
-static GICCapability *gic_cap_new(int version)
-{
-    GICCapability *cap = g_new0(GICCapability, 1);
-    cap->version = version;
-    /* by default, support none */
-    cap->emulated = false;
-    cap->kernel = false;
-    return cap;
-}
-
-static inline void gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
-{
-#ifdef CONFIG_KVM
-    int fdarray[3];
-
-    if (!kvm_arm_create_scratch_host_vcpu(NULL, fdarray, NULL)) {
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
-GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
-{
-    GICCapabilityList *head = NULL;
-    GICCapability *v2 = gic_cap_new(2), *v3 = gic_cap_new(3);
-
-    v2->emulated = true;
-    v3->emulated = true;
-
-    gic_cap_kvm_probe(v2, v3);
-
-    QAPI_LIST_PREPEND(head, v2);
-    QAPI_LIST_PREPEND(head, v3);
-
-    return head;
-}
-
 QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
 
 /*
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index afd1aa51ee..45d3503d49 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -39,6 +39,7 @@ if config_all_devices.has_key('CONFIG_APIC') or \
 endif
 
 specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_common.c'))
+specific_ss.add(when: 'CONFIG_ARM', if_true: files('arm_gic_qmp.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common.c'))
 specific_ss.add(when: 'CONFIG_ARM_GICV3_TCG', if_true: files('arm_gicv3_cpuif.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
-- 
2.45.2


