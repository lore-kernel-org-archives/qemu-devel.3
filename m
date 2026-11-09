Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6C7606A325
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cWWSyTvL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXu7-0005MV-Ql; Mon, 09 Nov 2026 17:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtn-0005E9-R6
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:41 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtl-0003tp-TT
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:35 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8a0880a46e7so771347b3a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794263492; x=1794868292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l7cfw0TdjsR+3R0sW/rw9uWVrC9z73bNOgT/MeSJe90=;
 b=cWWSyTvLF6NS+ik8vgoLNyTxC6YZ0xgxGC65Fvn3Z+C8RgxMNgn4ca1jb9huTAg2ay
 IZLz4gmFg3soVWqcLrlBfA44Ur+C7DpT46JUCLGNI8v+MhIpMDDda8Emy5fSMovA6Qs0
 5OSYZWkkQ6/xTn+HDpjKyxFAncOYpBGMzQnPrWOsSKLbbJFa1g94dTjSBGc5oZP6hNnc
 bpsYkgUomW8Lmt/5n0QGLhz9H9zIAmhrejVS3AIjp+KnINoUNoAJBTbw68qih+GKiSwZ
 CbxcxF7TyA3PpbEQh2QtNJRlwt5+4QUT4kkEeNYAd4r+wt3NhEuwzSAIP4ufXsdwejiZ
 PCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263492; x=1794868292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l7cfw0TdjsR+3R0sW/rw9uWVrC9z73bNOgT/MeSJe90=;
 b=tuF0XnY4NCBbx4n9xh090jHAo8xVpq1uGXmLdqEVtVN55S7+eXQ3vUBYzdZds19Sy+
 ikmx4PteIEJvFrhxhRwsfCuSLuqKj+xUOapcTKvVv6t1neRt200oCxl0o8TrQ8gxHzc7
 vHCJEpsGysXyh2y8yvZL6oJgnTA+2QOfcWoDQEZoDSUDgyiTi0F/h9yH48tuADov4MzF
 v+/AYFDpqta1JlFrOSrkVyGKnRpSOPFlP+N7wZx1UhqFt9yInuZ6WgnVLC9RLnnpL5rA
 7VTK458kRIcjbqiIh4adTzVqM+vvQTHtbl5u7N3ZIMFhbgESFvb5OgcaxKTdkXynu1RQ
 4ttg==
X-Gm-Message-State: APuU4Z8G0hovOsrXehqPpYXiL+g1yhb8oEc24JGr6ETVgP2L3NlAg8iL
 ZvY17W3bqgN0z4yULdiR9jToWIGuqOJKlJYnpbLdfcur9gywSRvcfjAS85PuzdE3lO7TKN6vC7l
 nQOZn
X-Gm-Gg: AYBFou2KHUwWvk4ZYQqkmwUdXGf8gI0JuZL8xH/tPsZbRieRiVisA7hG1pgEF3y7KCD
 PrDqjGhLpIxm8l39MDm8Bmy2VDWLbd+scUFA0OfH0XFE6WLzhdCFkvRRsyuCoHQoNyPuPfKoj2D
 nkO2+hI6F0JAWXcrTelkNb+vy/eSkcznAsYRzXiFYnmFVY/GB54vG00DPtCbFse/7abccDpVTS/
 6rN8QelX0TngoAIGdL7k0HbuEgg33P9gf0xvB9HArsq17U6oAVcZapCyXHt1tPUiyBiz+ctwxKo
 ZS9KP6PC3IzI0cgFlctn9mU5GwUAUtAachzG+D+rVVZ3BjT/ilP7ikCnQdr5GMSfvaY73O0ADhu
 Nmq8E3OLF1bCltA817/eFZ2HwCsMvEUGv+WGMn7QsiqMXVi7Pva8PvU+7MZOwwerrIn0BuELJyu
 +/3RFD37Xiui/Go/RrBdxy9sbLVrHgvcPvMerJctn/JrxkXfvX6tB/wLW1v7Hy7KMVTVtgIonzY
 qBjwR//lob/gZ90LvMqLkimfUoz8KviXWAR7439qpv3QU2pVSpbD5CnxtTYyWVBAYhmx4b9isij
 wnBVhb6fb1Sw3LNydH1aeKBpbRDmRAVMz2By6LpNHgxPrOD1ld/o+g==
X-Received: by 2002:a05:6a00:b610:b0:881:e266:c3d8 with SMTP id
 d2e1a72fcca58-8ba98c48edcmr546467b3a.35.1794263492240; 
 Mon, 09 Nov 2026 14:31:32 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:31:31 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 09/23] target/arm/kvm-rme: Keep track of images loaded in
 Realm memory
Date: Mon,  9 Nov 2026 16:30:56 -0600
Message-ID: <20261109223110.1619504-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x430.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add a Rom notifier to keep track of binary blobs loaded in Realm memory.
That way we can deterministically calculate the Realm Initial Measurement (RIM).

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/core/loader.c         | 24 ++++++++++++++++++++++++
 include/hw/core/loader.h | 14 ++++++++++++++
 target/arm/kvm-rme.c     | 30 ++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

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
index d9431e8a8d12..e22f587627f5 100644
--- a/include/hw/core/loader.h
+++ b/include/hw/core/loader.h
@@ -342,6 +342,20 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
 ssize_t rom_add_vga(const char *file);
 ssize_t rom_add_option(const char *file, int32_t bootindex);
 
+typedef struct RomLoaderNotifyData {
+    hwaddr  addr;   /* Address of the blob in guest memory */
+    size_t  len;    /* Length of the blob */
+    uint8_t *data;  /* Blob data */
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
index b3edfa8e0a95..ca90bf5af890 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -10,6 +10,7 @@
 
 #include "hw/core/boards.h"
 #include "hw/core/cpu.h"
+#include "hw/core/loader.h"
 #include "kvm_arm.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
@@ -24,6 +25,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 
 struct RmeGuest {
     ConfidentialGuestSupport parent_obj;
+    Notifier rom_load_notifier;
+    GSList *ram_regions;
 };
 
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
@@ -41,6 +44,30 @@ static void rme_vm_state_change(void *opaque, bool running, RunState state)
     kvm_mark_guest_state_protected();
 }
 
+static gint rme_compare_ram_regions(gconstpointer a, gconstpointer b)
+{
+    const RomLoaderNotifyData *ra = a;
+    const RomLoaderNotifyData *rb = b;
+
+    g_assert(ra->addr != rb->addr);
+    return ra->addr < rb->addr ? -1 : 1;
+}
+
+static void rme_rom_load_notify(Notifier *notifier, void *data)
+{
+    RomLoaderNotifyData *region = g_memdup2(data,
+                                            sizeof(struct RomLoaderNotifyData));
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
@@ -58,6 +85,9 @@ static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
     error_setg(&rme_mig_blocker, "RME: migration is not implemented");
     migrate_add_blocker(&rme_mig_blocker, &error_fatal);
 
+    rme_guest->rom_load_notifier.notify = rme_rom_load_notify;
+    rom_add_load_notifier(&rme_guest->rom_load_notifier);
+
     /*
      * The realm activation is done last, when the VM starts, after all images
      * have been loaded and all vcpus finalized.
-- 
2.53.0


