Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD41C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whEVq-0001LJ-DH; Tue, 07 Jul 2026 18:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVn-0001KV-3D
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:31 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVl-00049U-93
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:30 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2c9bd2f8bf7so17178345ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783464208; x=1784069008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFExSdxFK8RfkshviK2HeeDzgoNR/sUY6pTQO70u6q8=;
 b=Clx6au72z/MhnXd/dDzx53vg3zw+KKQuDi2XRwVfOUBfX2qqTGB+Pt5cfSVsAKzxsR
 OeergP7JY0bDX5KuJbyaLGLKqLpJoY7Ws+6V/gAXkC2nC7BEqN9a5yRuUa8p9L9dAddw
 IwuTQTkYukC9u3L2ulpSldNdHOwE6R7lKg7/3ivbJzdIsoCNLGqnY38KTNe4O9QrRxZe
 vuWpcqf+W/QHeI/4NJk7aFFXBOlxXfnWBxVrE4wCdTAh2/6sA/U9LZOch6z2ROGMFyeN
 sae6muzmn8MsVagxumR62zYxMySrcQoeo0joNdJxIgUU2nERr3Cn2zaaV7poVD2DvWqF
 7GTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783464208; x=1784069008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eFExSdxFK8RfkshviK2HeeDzgoNR/sUY6pTQO70u6q8=;
 b=UwI2jmTkbkJ10lYkmS2KzeIakjZ9WsO9+mBqUAW5WCmiSeeC03hOUnRLj47VhPo5nf
 M+ElZIAPKH7IKdxA6VIfRLHYwjmT98t2sHHfmmtoU9CnQc2YlcsfLVfPkaueQMXHQWKv
 KqeoV61kH3xvg0oX0jBslVlwSYLeZqbTPhfgVp85PnzqlNcnLANh9X4kDSLM74jCY9+k
 kcfiF25GpU2PyQnEIFKY7yp6N03q709YfpJ+O1J+lVhBUWM1vymWan1LumrkR+gD+ab5
 l5HWQxuuynrtZ98eQl4GNS76jv++mZbXZ7AP+TzlWBgG6rCmFPpd6m9/JyF4mTdAQg8J
 FloQ==
X-Gm-Message-State: AOJu0YxqqEVF5BzWvyi24uFSyWpT8M84maykD51x+acdGcqsB4X6oKCZ
 Kww0XU/i3JBvqfwlaLhJX1tOMal7knHRfQVe/9jhyPmAMhkcxq2nZO1pkOKl5rYkN2I=
X-Gm-Gg: AfdE7cmvRY09x94m5fcl1MwWXV2bBZ3+MIPac/F6mcFPeBFQmEJVp5+CTtquSLyj+5t
 T+n4+bZw1dQk/IgJ6oThdAIUx+BL8uhAzimRCDZM4dvpj900kRtGRkD/Z9b0nQq4fSUMnJembqW
 n2WEjDIZ1kOyZ8NSIUKbdEQqjHxzP9UKtqNrmCH8Ly4Hd2hm+D4HaXGJhhMTUYjRYvBQAj6EW2e
 cWv9mAL7jJPSaBXV7b2a4yL5hsJ+xWHqhkGMoCE8sfr4vuQLsaUrL06qL0UP7s6wSwayr3g78/u
 QqEMP0CD8KWxz45Wu2PyH1rxtPAT8BFsfW94GH49h9w2depsfhcSin8hNHv5Nvbn8y162bys9a1
 KsB4XdXIc0Dgz17h4ySCPop9FtnA7AD4FeWbUS+y5fwlK8bDQTWzPPG5aa5QReFYpvsj+7S5upe
 l1GcPHzDyx+LITIPTwAq1i8gW2frTeRHM6DI5EGMA=
X-Received: by 2002:a17:902:f791:b0:2ca:5023:f983 with SMTP id
 d9443c01a7336-2cccaf31b0amr41495705ad.29.1783464207883; 
 Tue, 07 Jul 2026 15:43:27 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:43:27 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 09/25] target/arm/kvm-rme: Initialise Realm Initial Address
 space
Date: Tue,  7 Jul 2026 16:42:50 -0600
Message-ID: <20260707224306.1202330-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x632.google.com
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

Initialise the Realm's initial physical address space based on
the VM's configuration.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/boot.c         |  4 ++++
 target/arm/kvm-rme.c  | 18 ++++++++++++++++++
 target/arm/kvm-stub.c |  4 ++++
 target/arm/kvm_arm.h  | 10 ++++++++++
 4 files changed, 36 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 9b7553dde5e1..bcab21d349b4 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -32,6 +32,7 @@
 #include "qemu/option.h"
 #include "qemu/units.h"
 #include "qemu/bswap.h"
+#include "kvm_arm.h"
 
 /* Kernel boot protocol is specified in the kernel docs
  * Documentation/arm/Booting and Documentation/arm64/booting.txt
@@ -1210,6 +1211,9 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
     /* We assume the CPU passed as argument is the primary CPU.  */
     info->primary_cpu = cpu;
 
+    /* Mark all Realm memory as RAM */
+    kvm_arm_rme_init_guest_ram(info->loader_start, info->ram_size);
+
     /* Load the kernel.  */
     if (!info->kernel_filename || info->firmware_loaded) {
         arm_setup_firmware_boot(cpu, info);
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index f763d5ed6199..697e7d507f0d 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -22,8 +22,16 @@
 #define TYPE_RME_GUEST "rme-guest"
 OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 
+#define RME_PAGE_SIZE qemu_real_host_page_size()
+
+typedef struct {
+    hwaddr base;
+    hwaddr size;
+} RmeRamRegion;
+
 struct RmeGuest {
     ConfidentialGuestSupport parent_obj;
+    RmeRamRegion init_ram;
 };
 
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
@@ -91,6 +99,16 @@ int kvm_arm_rme_init(MachineState *ms, KVMState *s)
     return 0;
 }
 
+void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
+{
+    if (!rme_guest) {
+        return;
+    }
+
+    rme_guest->init_ram.base = base;
+    rme_guest->init_ram.size = size;
+}
+
 void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
 {
     if (!rme_guest) {
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 6d52f172c5df..790e1940fd8a 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -42,6 +42,10 @@ bool kvm_arm_el2_supported(void)
     return false;
 }
 
+void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
+{
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 65ec1b970606..c7dc45595159 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -267,4 +267,14 @@ void kvm_arm_rme_vcpu_init(ARMCPU *cpu);
  */
 int kvm_arm_rme_vm_type(void);
 
+/*
+ * kvm_arm_rme_init_guest_ram
+ * @base: base address of RAM
+ * @size: size of RAM
+ *
+ * If the user requested a Realm, set the base and size of guest RAM, in order
+ * to initialize the Realm IPA space.
+ */
+void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size);
+
 #endif
-- 
2.43.0


