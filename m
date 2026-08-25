Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D0AC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzDH-0003wJ-6o; Tue, 25 Aug 2026 18:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzD2-0003cW-RF
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:34 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzD1-0001gn-1e
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:32 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38fdeaed181so666151a91.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787695289; x=1788300089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v/EbG9/3Hb8DCKZa1jZljaYOgVIsiNG77AyoF+zPvP4=;
 b=WBSbHCnxyitDp/XHTmueOXOWX8wGlr3uh4jXTEXcP3mlb0XJFWT5cjGFulQEj53AhS
 9F4T29D+AzNk4TUbR/aoqViV3YQu1swQTgri9L+Sj6vOkV5j+uf56Ed5uaxOjh3Lnf50
 cHYjJ+HNACVQaItR5xjwzJvJ6miAgr5z9fSfLjLdsiJA/b7/HWoDkAddumK4M/aQfzcx
 wDLVNyKr4cPG+r/RJ3ECuocuWvfAsRW+ye29r3nVBVMqUGlse8yzOnJt4MVoRG3nwC8E
 lug5yBfnJmCf3kzd8tErD1rp9+4SlsNOXdm3yxRrn88ZsPUSf56Jgc9xGCN0/SWfEXcm
 lkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787695289; x=1788300089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v/EbG9/3Hb8DCKZa1jZljaYOgVIsiNG77AyoF+zPvP4=;
 b=ad5YbWKjETzLFf4xHAH4Et2Vszue/96X24RVOcuDKDdTc59W7m6QPdMSLIMND3tZYw
 k0D1M10S0cFJrjVTpQfZXSqXKJcInR6qd/pF7MujCgIC8k/nmnUoMjfEc2cqCMopg61N
 9qNboolbt3BC0iPtgi9vU+EvI8sXh3eEEqwpduNBJqJ0O8iif96OSNZSEaCsUq58BKtm
 hB7eBuU2kxvBr4SoroUu3n8HUxxcicSrxFWAvu9eWsITkcUZY0YcG2HacpDIx/O/OViA
 82oTzuVrmQOQNsoWaMWgjhTcRjwKwesAGIFoJVnGQdRvqeA6C9rMv5+0h7LG7GX8N6Y1
 Fslw==
X-Gm-Message-State: AFuF++kQ6y/rzP2CF4iRV3poCRsww6VAn7aFgiAfNv802dsR7gqGLeVV
 RxFhh9ABYzTVwdY6F0W5Ia1Y0JYSnF3DxhYryl6SDustYBZpQeiu35lndPiY59p0HOU=
X-Gm-Gg: AR+sD13n2AjmCQStl3ci67eGMoDwFGoiYml8NDdHEhJ/0Mm6c94a9w942wP7g6Rw+s0
 TpUdZnBw1GyatbLYjx9sYto4WcERmUQ00eW74BZOrOpIiFunDRDmNqQXyfJc8+k/grNYHpMVybm
 ZGodFE57RV/42xgGEUQod1DhddYU5J9ejgWvnQg2DsUDXTDm1WX+2bzhpW2eaC05sCaFJSgot8q
 lfp7U26Y205SdAm31CHQlM4zWpVqA2Or9ljt3PgCMwio+Dvkgd5wj6RNxA5LU+8FfZLFiCa72Qz
 /bOTCR723ulNh64Bn/X19CgkMUwA/rttVLYDP1P5zrG0FW3+BmfSM02VyLCp/Dhr6aMV1OZ5STl
 ESMh3tLm1w3gS3gVihMIK93KjmeWUIE0gmsaEu2L1n3tZSvY5WzYf0uhrPozri275yyEaRnyOZL
 8zEQKnA76BjdEOIyshYMYiyY1r71D6mxFjsnTtYZ+0XjtFO2WQi5v2hUPQVXuCUP1B/Xh8kQyRi
 MS6nMSTgM0vxBSZE3WvoViErg==
X-Received: by 2002:a17:90b:1641:b0:38e:2524:724f with SMTP id
 98e67ed59e1d1-3966d421936mr3799826a91.12.1787695288928; 
 Tue, 25 Aug 2026 15:01:28 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:01:27 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v3 11/24] target/arm/kvm-rme: Populate Realm with runtime images
Date: Tue, 25 Aug 2026 16:00:48 -0600
Message-ID: <20260825220101.3443954-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x102f.google.com
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

Once the Realm descriptor has been created, tell KVM to transfer runtime
images (kernel, DT, and rootfs) from guest memory to Realm memory.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 9985f5daba89..c082a5d8f3d1 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -15,6 +15,7 @@
 #include "migration/blocker.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/memalign.h"
 #include "qom/object_interfaces.h"
 #include "system/confidential-guest-support.h"
 #include "system/kvm.h"
@@ -43,12 +44,87 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
 
 static RmeGuest *rme_guest;
 
+static int rme_populate_range(const RmeRamRegion *region, bool measure,
+                              Error **errp)
+{
+    int ret;
+    void *buffer;
+    hwaddr size = region->size;
+    hwaddr base = region->base;
+    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
+    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
+    struct kvm_arm_rmi_populate populate_args;
+    size_t aligned_size = ROUND_UP(region->size, qemu_real_host_page_size());
+
+    if (!region->data) {
+        return -ENODEV;
+    }
+
+    ret = kvm_set_memory_attributes_private(start, end - start);
+    if (ret) {
+        error_report("RME: failed to configure initial"
+                     "private guest memory");
+        return ret;
+    }
+
+    /* Allocate page-aligned memory */
+    buffer = qemu_memalign(qemu_real_host_page_size(), aligned_size);
+
+    if (!buffer) {
+        return -ENOMEM;
+    }
+
+    memset(buffer, 0, aligned_size);
+    memcpy(buffer, region->data, region->size);
+
+    populate_args = (struct kvm_arm_rmi_populate) {
+        .base = start,
+        .size = end - start,
+        .source_uaddr = (uintptr_t)buffer,
+        .flags = measure ? KVM_ARM_RMI_POPULATE_FLAGS_MEASURE : 0,
+    };
+
+    while (populate_args.size > 0) {
+        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);
+        if (ret) {
+            error_setg_errno(errp, -ret,
+                "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
+                start, end);
+            break;
+        }
+    }
+
+    qemu_vfree(buffer);
+
+    return ret;
+}
+
+static void rme_populate_ram_region(gpointer data, gpointer err)
+{
+    Error **errp = err;
+    const RmeRamRegion *region = data;
+
+    if (*errp) {
+        return;
+    }
+
+    rme_populate_range(region, /* measure */ true, errp);
+}
+
 static void rme_vm_state_change(void *opaque, bool running, RunState state)
 {
+    Error *errp = NULL;
+
     if (!running) {
         return;
     }
 
+    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, &errp);
+    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
+    if (errp) {
+        return;
+    }
+
     kvm_mark_guest_state_protected();
 }
 
-- 
2.43.0


