Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC24C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonS8-0003Dm-KJ; Tue, 28 Jul 2026 15:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonS6-0003CX-IG
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:26:58 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonS5-0001U2-0C
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:26:58 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-381b831d535so268740a91.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785266816; x=1785871616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eK8Ckt90ew461zSdg6LQYBpQfbUxeqNFROzikiI270U=;
 b=vteTltXjsgFHtcQ9hPrxkQrg5ljKCwZ0rVBNlyP6GayRXAp2ngChhP8uLD24axaz0a
 TJ4o8FbiAx+D1u/PngGdBm+DDbTuGagka4/3T2mSJPsXwY5y6m9PJkss4pFcLxbAQ7BN
 j1ySxRQl3AqNMsowzd/ggkZSkcadc2fO9gTOnnars8QzXZDt/2KmeaslsSAmd/DVOltd
 gJZDfynWj6cvi3+eByMNr/zwKHqWH6+rqIx5/VztYqx5T2P++bh2nh12aOaeN44MuBEC
 WHHy6uJmmUKKfHTGJv7lSipy20mddJOFQ25JrfYqE94K99feR/GkJ7FHs4YZRptzVBSe
 VCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266816; x=1785871616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eK8Ckt90ew461zSdg6LQYBpQfbUxeqNFROzikiI270U=;
 b=TWPaw47dEcBkFAFOeYGBE4sXvXlNHwp4SSg2OwJIGWxLDzghIH4LERATdZObViRt1k
 hn13rnKYATXQFtFaQAHXvnYhnM3TlpzKUdPp1+6GpOjE1+Zs/j/FNIgnWTr+ph0DgLqO
 T2p8GlM4gF5aX5VASpHPFQ9D9w5vi0mwtjXCAydt4FzGg0HvmBEaQsx0+64DWO4JlhR2
 0pFMe09mx9fEmqAKivRIbMjeebFlS36vGtn08pAaH+bsBdGz5FHcOF94tT0TcuYOC6Oo
 769dxOC4zbTge8W3tPd+BDDMuE2StD53zKjh8LP5EPm1gv/lm8jADCn5L17wFUxhHMVw
 z8wA==
X-Gm-Message-State: AOJu0Yyk95KQo3pO9vvepEvR1eKblrA7QoLZoxtETXfTCaT1Gd7bmkP4
 a97zrSyaIHBG5qovcqgQ+c0S/yUSnMfaVvShXtzmqNm9QtyBCb9JSa1ElnlGL/yvrjs=
X-Gm-Gg: AR+sD13ZF+c1xmFNJVH4+gConsOYBALiNgMQNM7N3A47hPjFwgEZbQWQ+37uAjXRJCp
 IC1pKZtrLNuNZgdAFz0EvUcUmwEenrSMmlISPljWgl8rn1jSTfKsM+TNav0BsK2IRLVTYSx6iJh
 0fqLyfGZHB8gZEPIHV5ValuAz3EMA54AuE2vaGTqGKjGTpwcLngca/5mxeKFM9p8p3H4Tv47YEJ
 4R0AySnaPXCjt1CEn+bT8XSzskmYUpvACFFF7meKeNSFB7t4S/ArRntXHqlxeKO2gK4/m5Y+ocY
 59IGYS5NbSg3fU77TPDrIDtW5qHeGA3JiHbeXy5P4Inx0XhjdifyObLeC40Lw+ygG8cCciU2iEH
 fXhtzFaXQ4X5Z6UAw6FJuZhNbhX7wVIGV+MHsdlaW7Ajk38ok4ihT++4M3U2LfzsGhZEcIK1Kyg
 x7X/Pt7RsV1n9HB7m1BYgIbAorKgZkyTyPT2o+QQJJxr2PRHQWHcli+m3bq2bXJ7bYQhR8Gz9z1
 sk+ZNkGfIONSTY=
X-Received: by 2002:a17:90b:6cb:b0:38f:26c7:165e with SMTP id
 98e67ed59e1d1-38f6a3d5b08mr4041584a91.9.1785266815568; 
 Tue, 28 Jul 2026 12:26:55 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:26:55 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 10/24] target/arm/kvm-rme: Keep track of images loaded in
 Realm memory
Date: Tue, 28 Jul 2026 13:26:16 -0600
Message-ID: <20260728192630.240375-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1034.google.com
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
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 5d6814fcf9e5..10bca9a944ba 100644
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
+    AddressSpace *as;
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


