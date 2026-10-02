Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462E2CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 20:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCjkb-0007Pb-MR; Fri, 02 Oct 2026 16:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkN-0007Jf-SK
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:20:51 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkL-0005mF-Dz
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:20:47 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2dd58e1e2c7so2445ad.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 13:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790972443; x=1791577243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HNP3jY90j0VdEmvR33fcLvA6g8lnID0iKbGWLsBD1aY=;
 b=kP44dOAdftF74qMFbwsNoVWvCGIr0modWxJYtcFEeIOxDoTctyJUt3spChfUPAJqyi
 X1J+oCSQAAv2pjMVI85rEZNGS4f4qDqVM/qNZTR+GqKOUlA5/OUD2BZZjwE7QfjL7kSA
 t7hOXO6k00DbVKoATxK7pebeK+xleLD51ldAernY2LbJPHwmOqdZ2JFjygJZzIIy5SCL
 OCw5K9igBjL1LrUUXQoEDu/+Qkd2eXBJ+oCvm8Y5VKWQ6KhetnI2B0krwGIFefjMQ4Jv
 tyAA4A5ApRfoTTkkBRT8L+xIJexyf30X9uYz7jzYfJPMBwU2yiGikE2qADyvi3/ir8jA
 sfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790972443; x=1791577243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HNP3jY90j0VdEmvR33fcLvA6g8lnID0iKbGWLsBD1aY=;
 b=TCx1Jxm5scx/uR+nlyiXGvOPTtwb8DQrgXznBfC23/3J33Cb9GySRdlM/pBnoR5qTA
 fek4j2uS/CVLG5+B1cgDV0faej7L4oyARhQ9Qn+/vPbS35jBma/IGivgth4i1ULfdBFX
 xDaNCDMTTxude3FN7zAYO1TTGaQcEyCDiM1WuiOND1M0WRmQAGJnDKS8jOqA4INJzp/o
 HgJgnlnsoiceVgl3aza8KOspWe4H5d/OhC1uGsfOPEuYrJ0POQDqZUPboAl50Mnb1DZK
 i63Hk65Cegji+syIi2eSxZuRFdBUrUVFI/q9gFfikyM8rusicbI3WWXHmUETfVmlWGDX
 RP3Q==
X-Gm-Message-State: AFq9FYKbyU5q4ey3fYmkdy1mDOQjplpM4FHujt54A3nRzmfxuaj594Mp
 snC3dvldIJ3WUNXCTfvMpCtPpk20pl+4b2KrA5MfocZ2+81x4HqkG2P9jwHsLBdqOho=
X-Gm-Gg: AYBFou18FqCPJcn4Vdt/8Yru6DUVVsFLl1utZWrgk5aekt6zucWPdm3I8ArkmPc0Yun
 dovtZW8rYBc9ZTBHzsNC/9wpUHuJzgw/Hp6/Fo/NOK0ZSU+gBmRFU40VpoQmB1k5UqGChYqhZId
 hIk6Ou+S6v7jezf9td8nW4j28aBvWgvtiqaLlauJpN8rKAkeufyaApuPFaF66FqijE/GGHhtMTK
 c5d5sgYg7Bpl9m7XDYlz97WO0bzFW3W7jFKovZ/3LcGNp9UDsR2EFY13IjskOmIlBMJZZQLLVxj
 uX57g1WNG+0eWynX2OhSLArvJ2Ec2NhSLbRJrg8wt/ygh4lxR9fvJtEyJGoT05/FNa2qhpSjp4R
 jzhbcYQytjI1MzqROzzpaYzfnPRJ1a+1V7cVVK0TdO+HbYQfrTiYlCNceNmj7bkNvAub6tebaRY
 ScDJrgWgmAEG1YuNzI4uqSjlFQu7YKlAnQXMgV2Cif39pHfUlVFdkB5qMLInK0ifUCPSRZWQykM
 GqiAR2QkjBKf9H5XWy+sSZO
X-Received: by 2002:a17:902:e5c5:b0:2d9:464f:d45f with SMTP id
 d9443c01a7336-2e49b0bf382mr35608605ad.5.1790972443297; 
 Fri, 02 Oct 2026 13:20:43 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:61ac:e744:6559:a357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:20:42 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 08/22] target/arm/kvm-rme: Keep track of images loaded in
 Realm memory
Date: Fri,  2 Oct 2026 14:20:12 -0600
Message-ID: <20261002202026.1204110-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj2-x10.google.com
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

Add a Rom notifier to keep track of binary blobs loaded in Realm memory.
That way we can deterministically calculate the Realm Initial Measurement (RIM).

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/core/loader.c         | 24 +++++++++++++++++++++++
 include/hw/core/loader.h | 17 +++++++++++++++++
 target/arm/kvm-rme.c     | 41 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 5cbfba0a86d2..644d55c9e0ed 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -74,6 +74,8 @@
 #endif
 
 static int roms_loaded;
+static NotifierList rom_loader_notifier =
+    NOTIFIER_LIST_INITIALIZER(rom_loader_notifier);
 
 /* return the size or -1 if error */
 int64_t get_image_size(const char *filename, Error **errp)
@@ -1201,6 +1203,11 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
     return mr;
 }
 
+void rom_add_load_notifier(Notifier *notifier)
+{
+    notifier_list_add(&rom_loader_notifier, notifier);
+}
+
 /* This function is specific for elf program because we don't need to allocate
  * all the rom. We just allocate the first part and the rest is just zeros. This
  * is why romsize and datasize are different. Also, this function takes its own
@@ -1242,6 +1249,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex)
 static void rom_reset(void *unused)
 {
     Rom *rom;
+    RomLoaderNotifyData notify;
 
     QTAILQ_FOREACH(rom, &roms, next) {
         if (rom->fw_file) {
@@ -1290,6 +1298,22 @@ static void rom_reset(void *unused)
         address_space_flush_icache_range(rom->as, rom->addr, rom->datasize);
 
         trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
+
+        if (rom->addr == -1) {
+            /*
+             * These blobs (ACPI tables) are not loaded into guest RAM at reset.
+             * Instead the firmware will load them via fw_cfg and measure them
+             * itself.
+             */
+            continue;
+        }
+
+        notify = (RomLoaderNotifyData) {
+            .addr = rom->addr,
+            .len = rom->datasize,
+            .data = rom->data,
+        };
+        notifier_list_notify(&rom_loader_notifier, &notify);
     }
 }
 
diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
index d9431e8a8d12..fdfddfa7443e 100644
--- a/include/hw/core/loader.h
+++ b/include/hw/core/loader.h
@@ -342,6 +342,23 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
 ssize_t rom_add_vga(const char *file);
 ssize_t rom_add_option(const char *file, int32_t bootindex);
 
+typedef struct RomLoaderNotifyData {
+    /* Address of the blob in guest memory */
+    hwaddr addr;
+    /* Length of the blob */
+    size_t len;
+    /* Blog data */
+    uint8_t *data;
+} RomLoaderNotifyData;
+
+/**
+ * rom_add_load_notifier - Add a notifier for loaded images
+ *
+ * Add a notifier that will be invoked with a RomLoaderNotifyData structure for
+ * each blob loaded into guest memory, after the blob is loaded.
+ */
+void rom_add_load_notifier(Notifier *notifier);
+
 /* This is the usual maximum in uboot, so if a uImage overflows this, it would
  * overflow on real hardware too. */
 #define UBOOT_MAX_DECOMPRESSED_BYTES (64 << 20)
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index f7c2cc786e2c..b1fb8957f3de 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -10,6 +10,7 @@
 
 #include "hw/core/boards.h"
 #include "hw/core/cpu.h"
+#include "hw/core/loader.h"
 #include "kvm_arm.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
@@ -22,8 +23,16 @@
 #define TYPE_RME_GUEST "rme-guest"
 OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 
+typedef struct {
+    hwaddr base;
+    hwaddr size;
+    uint8_t *data;
+} RmeRamRegion;
+
 struct RmeGuest {
     ConfidentialGuestSupport parent_obj;
+    Notifier rom_load_notifier;
+    GSList *ram_regions;
 };
 
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
@@ -41,6 +50,35 @@ static void rme_vm_state_change(void *opaque, bool running, RunState state)
     kvm_mark_guest_state_protected();
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
+    region = g_new0(RmeRamRegion, 1);
+    region->base = rom->addr;
+    region->size = rom->len;
+    region->data = rom->data;
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
 static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     KVMState *s = KVM_STATE(current_accel());
@@ -58,6 +96,9 @@ static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
     error_setg(&rme_mig_blocker, "RME: migration is not implemented");
     migrate_add_blocker(&rme_mig_blocker, &error_fatal);
 
+    rme_guest->rom_load_notifier.notify = rme_rom_load_notify;
+    rom_add_load_notifier(&rme_guest->rom_load_notifier);
+
     /*
      * The realm activation is done last, when the VM starts, after all images
      * have been loaded and all vcpus finalized.
-- 
2.43.0


