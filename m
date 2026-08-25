Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D23C61DC6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzDU-0004MY-HO; Tue, 25 Aug 2026 18:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzD0-0003XP-9q
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:31 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzCy-0001bm-1F
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:30 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2cf452def93so10085565ad.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 15:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787695286; x=1788300086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6yAZYi7h64i0sOWTrsMVth4dHq383ltCyuAo47L2qv8=;
 b=EXH4oFUsKceaP9ddeM7E/AQpe5dia3FhjNTOxvzBrT3BFKxnT3iZYHKukjgwYI16/X
 WvXgYZ4bL9wzRaw2rQXpCF81hm12KKfnKKbEmJTzkGR1K7UNRdM6XjzME5vfqo/l8T5Z
 3E1Y/zn7MozL7GTanN8tWn6GqeIbFM7F4TohQtWvg/abMTp0jMgPi7/0JsEtLcAo6nMz
 rbOj3+3K4bLd21WN+69ADjqFlb9EOck6X82svyROm5Byaf+cqJzZCCD+L1DzbUY+41e5
 p67u1q/9SL+NVliHjnST0VXwO2zuVHxWkWXnOElh7cF0ugxxY88DyaBdrJeCepE052Ru
 2S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787695286; x=1788300086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6yAZYi7h64i0sOWTrsMVth4dHq383ltCyuAo47L2qv8=;
 b=LZOXVUzJi4qswGG24syH1FdsLpGRowarH5rkVgONCHlBwKSJVyhjZGgcEb7hWD6xvE
 q5k8caOqU18IMOv8D+Och26Kd5WgtuIzllflfSXe00efvWbfi+ALaryk1A1y0jSIfAg1
 nAnQvpOVxijZhE6beOdw037Y4Z+xBG534ZOxPxcSpywjQFC2/RvZ6ffM259gTyzoTXnB
 6oPPPrSqvbVoj4t0LHzWc/xbvkbOOn/axx3Jzs+ZYaZO074gN02RrqprwFaoquknS5mZ
 Qt4s6qP2yfXS0+hXz0DwNT8wEkioy2qb7g1w0KRzm9sV78ebd9MbKp3m8nwq8Wwyliiw
 +MDQ==
X-Gm-Message-State: AFuF++ltBmsir31ZntmB/UVaLFYGwv2T9VePfXb4MBqWQ/IB+7b4C/wt
 8OjsgHXiYexOva9NRhtOaWt5mY7JAmQ1+le0NrFn746S+PNoksYqyb9MtISlpDPaxqRrkCPGyg/
 /E9l7
X-Gm-Gg: AR+sD11BAMnnFcmqHeHYYwlx+T64+48ik3RG09OMSBFbLB9JzzrnYIMGUL8fae4urQk
 YvYZ32CLb6UgHloyhGFoXmkaRp01wu2epZ5vXiAFUINlYOn+U+LPjs4dEiYE4obpOFnw0i1aUlO
 SXzGwtXuEQD/tyx7Gzs8HPqXDicHvKTPVbA3xeLSbeFEfnrDtvMo3ywcswuydTsNJr915cd1CqO
 1DTUvqDuRZj4Ra+QZYL/MHHAVrVI5pgMTm7+LuQRBQgDZpb0YGe6aLJ1vqRuK0BzBszzsdAcbRn
 1txFORwZa3MwcqHSvzXeAc1/nWvz94HcFOiIplHoFb7aasfy35NQ4jWsXgvhC7usboIXkBXKHOo
 EfHxvj+FTIYSz6SMgGfAgXgf5I/c1ODoF4n86ZRlQ27XGb7X750yzcUhXWTwWskWZViQz3dR7Ln
 ztPN6A4xwmqFVHtd7zrSEq7D3KmwgZW6Mucc0OWPW5zZjE0wJiGUlRoW3ZxUGc22UppSgeqcyex
 CEDKO8i+J/0jxs=
X-Received: by 2002:a17:90b:2ccf:b0:38e:9ca8:e99 with SMTP id
 98e67ed59e1d1-3966d70a74fmr2259623a91.5.1787695286153; 
 Tue, 25 Aug 2026 15:01:26 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:01:25 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v3 10/24] target/arm/kvm-rme: Keep track of images loaded in
 Realm memory
Date: Tue, 25 Aug 2026 16:00:47 -0600
Message-ID: <20260825220101.3443954-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x635.google.com
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
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index f7c2cc786e2c..9985f5daba89 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -10,6 +10,7 @@
 
 #include "hw/core/boards.h"
 #include "hw/core/cpu.h"
+#include "hw/core/loader.h"
 #include "kvm_arm.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
@@ -22,8 +23,18 @@
 #define TYPE_RME_GUEST "rme-guest"
 OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 
+#define RME_PAGE_SIZE qemu_real_host_page_size()
+
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
@@ -41,6 +52,44 @@ static void rme_vm_state_change(void *opaque, bool running, RunState state)
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
@@ -58,6 +107,9 @@ static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
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


