Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C90E606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 04:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=fbBK6so3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLvKj-0007bo-FH; Wed, 28 Oct 2026 00:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xLvKb-0007a2-HS
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 00:32:10 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xLvKZ-0001f8-49
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 00:32:08 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2e74a32a07fso731515ad.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 21:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1793161926; x=1793766726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x3H27yPs25NYbZfcAePSdPu7O3Sz4eG9pHWgehun8bQ=;
 b=fbBK6so36pq/j260u3QWJiMf/LlWD07YMdDMzemHdZ1Ah2POBw5ESj0Z13yay4j0Tn
 LXVE0mupinhRsqBegVUUlAKCeAuwAfgq0WLTzkFCPnyiSVYrrkA7idEVuGt75PFFkcQF
 DNZbgDPHN8jCEK8kwvM29eCugl4+Sn22ag0kUwPR3wYA8Um/evTy2thMqv20jlxl0e8o
 X+2+6Y8l2o9qd5Kwjt7D93v/cLVZJ0v5L23b9a5c3btQa1DGoeVSLL5bYTIpJIas7gwp
 mtdco/wnwzXcKtVbmitV2sRD1z1xgn2dVKw0O+fxG6717wkWp4AoBsz1Nk7FxNmiCVfq
 u0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793161926; x=1793766726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x3H27yPs25NYbZfcAePSdPu7O3Sz4eG9pHWgehun8bQ=;
 b=Bj6eaiaI7nDbaT4z25Wt/EQi/vlEPcX8anGRXp2RW2tJcSOXr/tYcDFjZ7ucbiPADL
 Jee5nJeuuac8UzszLFexBvryxIVSgfJxSNzP2ILktV9FIYT1accoM9DDTPdR2D/8V2K4
 KZf15BXOpIpdnFAY1OydvkHke1UiUb6p396D4pduqBy862XzDlq24SDlnO3j81HqcDV1
 JKnB/+XH5/jvWBFsnQM30UPRwxniCBdXGsXRseBPWqqzrfGnusZu6N4i77Zl4Z5hbBBc
 K4LnQjetOLZybokKaW3MZ8pr8wpsAlooYEr23w4XXHnqJ3GG+N9qFFUcacTqB0/Kv5b1
 7exA==
X-Gm-Message-State: AFq9FYLd4EVbuiZMEDGu3AW2ogjjJeWproYH/uN8VhyGV9VR+4Y0ajRV
 /NKTQcbDSS9ZubCH68Wq/dpaRTDWBY1KRWSsb3Pj6h37JumAJniJb554OL25ZYNmDh2FHIK250u
 A1lbLLsQ=
X-Gm-Gg: AYBFou33fEWMmMKq49j1mDQXUhAPY+YM8+EBByus5btvZKR1euHGQLrbZkAC2c1D+kv
 VmTcrNTbWleiYVfECiBmEW2yNB3wG32fFN+diFljclFVOhLPVl1g5vmy2oVJHsQsKog1FPfZOLl
 ZO7EwdcO7qxQ7XM+e/Opzbk+gpkZA3wDwSDQ634R73i8wCNPXuudx8JSCw2ipYsiv5zdVW+GX/x
 4yUhtSFEnqmPkQ7lS/Qt7R/6Jvx+Vw/3+CDDC/59axTwIJLSPoAaLXeqUmdjxzSUqZtpqaVIuIy
 sbhql3x5mHoc94xsvaVvSgh6l12Bw0Q20s8tmxqcsA78Im3tX97GchUgzeVcYnhNqoiMjfepjUN
 DkovgG17Adkpk4pgtoZ8z3Iu2HlJX+k9kr4PCBOKMVRFCaER54Bu8fwYPmOmk7fL0Haxq4aHvxf
 ZHpgS/cJpfDlkJV86hmHtnZQpTPzgd/zBDsguaTUVUGgYfwyVF+XVuFj2wnE9+XNEynR8MB44Zj
 9oi19s7lkJlXRK1FkGF9Jhu5pTTdQda1gWBakT1uoX/PVy1dcy+w2Amg4PD3U6+so+kBKD5jUfs
 +R6WNfgqzB4gtvY8biCVZf3Fcx4bpvC5mSnRriDSyXJEbgFOjtVkIVRt2pHNFgyau5Wh5vVdZ0O
 jYg==
X-Received: by 2002:a17:90b:4cc9:b0:3ac:77a2:18b1 with SMTP id
 98e67ed59e1d1-3ae581469a3mr1472682a91.5.1793161925793; 
 Tue, 27 Oct 2026 21:32:05 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a5d45a8sm1024470a91.17.2026.10.27.21.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 21:32:05 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Ellerman <mpe@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 08/10] hw/riscv/atlantis: Load the RCPU bootrom
Date: Wed, 28 Oct 2026 14:30:57 +1000
Message-ID: <20261028043059.600498-9-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028043059.600498-1-portias@oss.tenstorrent.com>
References: <20261028043059.600498-1-portias@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=portias@tenstorrent.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update tt-atlantis to, when the RCPU is enabled and bootrom binary is
provided, load the provided bootrom binary for the RCPU to execute.

This adds a tt-atlantis machine property 'bootrom' that takes a file
name. qemu_find_file() tries the filename before the search path, so both
full file paths and filenames relative to -L work:

    -M tt-atlantis,rcpu=on,bootrom=out/bootrom.bin

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 hw/riscv/tt_atlantis.c         | 62 +++++++++++++++++++++++++++++++++-
 include/hw/riscv/tt_atlantis.h |  4 +++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 66cbb2b8cf..d2ba2935af 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
+#include "qemu/datadir.h"
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
 #include "qemu/units.h"
@@ -671,13 +672,37 @@ static void tt_rcpu_cluster_realize(DeviceState *dev, Error **errp)
      */
     mmio_map_unimplemented(&rc->memory, SYS_BUS_DEVICE(&rc->unimp_mem),
                            "tt-rcpu.unimp", 0, UINT32_MAX);
+
+    if (rc->bootrom_name) {
+        ssize_t rom_size;
+
+        g_autofree char *rom_file = qemu_find_file(QEMU_FILE_TYPE_BIOS, rc->bootrom_name);
+        if (!rom_file) {
+            error_setg(errp, "could not find bootrom image '%s'", rc->bootrom_name);
+            return;
+        }
+
+        rom_size = load_image_mr(rom_file, &rc->bootrom);
+        if (rom_size <= 0) {
+            error_setg(errp, "could not load RCPU bootrom");
+            return;
+        }
+    } else {
+        /* If no bootrom is provided, don't let the core run */
+        CPU(&rc->cpus.harts[0])->start_powered_off = true;
+    }
 }
 
+static const Property tt_rcpu_cluster_props[] = {
+    DEFINE_PROP_STRING("bootrom-name", TTRCPUClusterState, bootrom_name),
+};
+
 static void tt_rcpu_cluster_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = tt_rcpu_cluster_realize;
+    device_class_set_props(dc, tt_rcpu_cluster_props);
 }
 
 static void tt_ascalon_cluster_init(Object *obj)
@@ -832,6 +857,13 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
     if (s->has_rcpu) {
         /* Only create the RCPU if it is enabled */
         object_initialize_child(OBJECT(s), "rcpu", &s->rcpu, TYPE_TT_RCPU_CLUSTER);
+
+        if (s->bootrom) {
+            object_property_set_str(OBJECT(rc), "bootrom-name",
+                                    s->bootrom,
+                                    &error_abort);
+        }
+
         if (!qdev_realize(DEVICE(&s->rcpu), NULL, errp)) {
             return;
         }
@@ -1010,7 +1042,8 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
 static const Property tt_atlantis_soc_props[] = {
     DEFINE_PROP_LINK("dram", TTAtlantisSoCState, dram,
                      TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_BOOL("has-rcpu", TTAtlantisSoCState, has_rcpu, false)
+    DEFINE_PROP_BOOL("has-rcpu", TTAtlantisSoCState, has_rcpu, false),
+    DEFINE_PROP_STRING("bootrom-name", TTAtlantisSoCState, bootrom)
 };
 
 static void tt_atlantis_soc_class_init(ObjectClass *oc, const void *data)
@@ -1058,6 +1091,13 @@ static void tt_atlantis_machine_init(MachineState *machine)
                             num_asc_harts,
                             &error_abort);
 
+    if (ams->has_rcpu && ams->bootrom) {
+        /* Set the RCPU bootrom file name provided on the command line */
+        object_property_set_str(OBJECT(s), "bootrom-name",
+                                ams->bootrom,
+                                &error_abort);
+    }
+
     object_property_set_link(OBJECT(s), "dram", OBJECT(machine->ram),
                              &error_abort);
     object_property_set_bool(OBJECT(&ams->soc), "has-rcpu", ams->has_rcpu,
@@ -1094,6 +1134,22 @@ static void tt_atlantis_machine_set_rcpu(Object *obj, bool value, Error **errp)
     s->has_rcpu = value;
 }
 
+static char *tt_atlantis_get_bootrom(Object *obj, Error **errp)
+{
+    TTAtlantisState *s = TT_ATLANTIS_MACHINE(obj);
+
+    return g_strdup(s->bootrom);
+}
+
+static void tt_atlantis_set_bootrom(Object *obj, const char *value,
+                                   Error **errp)
+{
+    TTAtlantisState *s = TT_ATLANTIS_MACHINE(obj);
+
+    g_free(s->bootrom);
+    s->bootrom = g_strdup(value);
+}
+
 static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1121,6 +1177,10 @@ static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set to enable/disable modeling the RCPU.");
     object_property_set_default_bool(prop, true);
 
+    object_class_property_add_str(oc, "bootrom",
+                                  tt_atlantis_get_bootrom,
+                                  tt_atlantis_set_bootrom);
+    object_class_property_set_description(oc, "bootrom", "RCPU bootrom image");
 }
 
 static const TypeInfo tt_atlantis_types[] = {
diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 4dfeb993d4..cab7e2625f 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -69,6 +69,8 @@ struct TTRCPUClusterState {
      * prevent faults on accesses to regions not modeled.
      */
     UnimplementedDeviceState unimp_mem;
+
+    char *bootrom_name;
 };
 
 struct TTAtlantisSoCState {
@@ -89,6 +91,7 @@ struct TTAtlantisSoCState {
     TTAtlantisPRCMState prcm[TT_ATL_NUM_PRCM];
 
     bool has_rcpu;              /* Enable RCPU */
+    char *bootrom;              /* RCPU boot ROM image */
 };
 
 struct TTAtlantisState {
@@ -101,6 +104,7 @@ struct TTAtlantisState {
     TTAtlantisSoCState soc;
 
     bool has_rcpu;              /* Enable RCPU */
+    char *bootrom;              /* RCPU boot ROM image */
 };
 
 enum {
-- 
2.43.0


