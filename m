Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44898C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whEVw-0001NU-Tb; Tue, 07 Jul 2026 18:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVv-0001MT-51
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:39 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVr-0004AU-Vm
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:38 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2cace91f112so824945ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783464212; x=1784069012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tjTKQ+pNbBLpWy4623zrp+MUjeVCpuJZYWOZQR0J4OM=;
 b=m0WBBNAKr1JWrB1zQVh+30OdloAHGzePSIn8gQF+PIv0/Jn1P95lbechU4eOK+iMEz
 gTrIgBFEiyaqVy4etmnwIyj7kPnO/E3Mkm+NZi63PARRm4MXlyWksa9iqFq3l97TIloj
 nWfb9JgAYtuaNzSKqp10Ol3D82lX31xXIAN+YXB5tq/yYhKRJ5c5zRVZqhCK5ObbSbGA
 KiUCWhxOmHXoJP6RLgDXvWw0/jFJF3zZywI8QCLHPo+u86E9dZurRQc7D82QrEQP/PvO
 SBaXPfcCDxwAaa38pfx4r+z7PEJ3qvQ2fa8K9J0V35j5FIzWNpnZNBHdjhvUA+jnxl6c
 /7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783464212; x=1784069012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tjTKQ+pNbBLpWy4623zrp+MUjeVCpuJZYWOZQR0J4OM=;
 b=mbtNcJn7lVdiN6/lydVSx0m1C5CEbvVGHdy8yYBCuO49JAEZnDwNAp1JT+SO+CB9EJ
 sEsoYZgpZbdx0cVaDLnBSTJLRb8MVQes9kCLdlnx4C6zb9vezl0E5FbHfYBi2Dh1nauf
 5S3J3vMXnpm98M0vp+5iMGMVPJ9n+/oJBJSbw8lf8r68/1vuHAkJBOA2AXG1B/2myEXG
 W5KqcgcEthmUDZXo0B7tn48Y4HYdPy7+e5yLYN+aeMy3jYZrZiIU7dQlIlZOpNxa0Aod
 6t1XQxmuS+AHvpcg+E4fPdKT2OhlJBRLpxN0zQMkvIOaoH4o1MTaf+0LvdNAzvufYMSe
 hsZA==
X-Gm-Message-State: AOJu0YxY87FJmRoIKoOc9sM/SujJfpCxH/y7vPidFymWXw4JgzqrNnMu
 drgqrcH1Edwklhnkvup9Ff7JC09NHxMXFcBEmse5FTb5S37xWI42c+tHI0izAfFSm60kvOyS/Gl
 BVdGPAvU=
X-Gm-Gg: AfdE7cm7Yr8a6PpDEjmfRt35LL9cWVj+MKWb0aoSbjFajhv1YrUOCZFolQhkkr06AhI
 Ms9f0xnLGcdI8nIiPHXWYHnj6qzDrxrbmB2sdALPZuS4ka9bb0KLamiqXVJPsGD3LOc0y83i/s1
 ofnHRAtc3wVAyClj1kIXWOlj980pLuZXNBatGY3Z3X0RS23FChxQQTrww6yj1eoGwW7SZe4DbDo
 sFSqQFuKFJ2DSmVdxzCc6CH7B4FjweyBNhY5ewv6Ltf7w1E7r+XbwBG3Ti0ThAhVMh2Qdo6GaG7
 +6SzQdjqJnI577ICXbQh1uY7npcvuXGRHgVwNLweOX6Xj6sbYcOPhs7fFxeegkCLPuXXmx+Arzn
 +LcUPyyjLpT0OkDtu/KtCnLPASEq6IWwBoe3OaXspv1I76ILWOEki67PnxtPXvBP0KtVLtYOsG0
 2YLzXM4FHVoYBW2fEkTUCOx15w8jy8e4xXHuTkkS0=
X-Received: by 2002:a17:903:3550:b0:2c9:d539:61e7 with SMTP id
 d9443c01a7336-2ccbe6267f4mr64613375ad.19.1783464212055; 
 Tue, 07 Jul 2026 15:43:32 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:43:31 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 11/25] target/arm/kvm-rme: Keep track of images loaded in
 Realm memory
Date: Tue,  7 Jul 2026 16:42:52 -0600
Message-ID: <20260707224306.1202330-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x636.google.com
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

Add a Rom notifier to keep track of binary blobs loaded in Realm memory.
That way we can deterministically calculate the Realm Initial Measurement (RIM).

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 697e7d507f0d..97ec7c8934c9 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -10,6 +10,7 @@
 
 #include "hw/core/boards.h"
 #include "hw/core/cpu.h"
+#include "hw/core/loader.h"
 #include "kvm_arm.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
@@ -27,11 +28,14 @@ OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 typedef struct {
     hwaddr base;
     hwaddr size;
+    AddressSpace *as;
 } RmeRamRegion;
 
 struct RmeGuest {
     ConfidentialGuestSupport parent_obj;
+    Notifier rom_load_notifier;
     RmeRamRegion init_ram;
+    GSList *ram_regions;
 };
 
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
@@ -66,6 +70,44 @@ static void rme_guest_finalize(Object *obj)
 {
 }
 
+static gint rme_compare_ram_regions(gconstpointer a, gconstpointer b)
+{
+    const RmeRamRegion *ra = a;
+    const RmeRamRegion *rb = b;
+
+    g_assert(ra->base != rb->base);
+    return ra->base < rb->base ? -1 : 1;
+}
+
+static void rme_rom_load_notify(Notifier *notifier, void *data)
+{
+    RmeRamRegion *region;
+    RomLoaderNotifyData *rom = data;
+
+    if (rom->addr == -1) {
+        /*
+         * These blobs (ACPI tables) are not loaded into guest RAM at reset.
+         * Instead the firmware will load them via fw_cfg and measure them
+         * itself.
+         */
+        return;
+    }
+
+    region = g_new0(RmeRamRegion, 1);
+    region->base = rom->addr;
+    region->size = rom->len;
+    region->as = rom->as;
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
 int kvm_arm_rme_init(MachineState *ms, KVMState *s)
 {
     static Error *rme_mig_blocker;
@@ -88,6 +130,9 @@ int kvm_arm_rme_init(MachineState *ms, KVMState *s)
     error_setg(&rme_mig_blocker, "RME: migration is not implemented");
     migrate_add_blocker(&rme_mig_blocker, &error_fatal);
 
+    rme_guest->rom_load_notifier.notify = rme_rom_load_notify;
+    rom_add_load_notifier(&rme_guest->rom_load_notifier);
+
     /*
      * The realm activation is done last, when the VM starts, after all images
      * have been loaded and all vcpus finalized.
@@ -107,6 +152,7 @@ void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
 
     rme_guest->init_ram.base = base;
     rme_guest->init_ram.size = size;
+    rme_guest->init_ram.as = NULL;
 }
 
 void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
-- 
2.43.0


