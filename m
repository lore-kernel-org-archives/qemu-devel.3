Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC445CA5FE5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 20:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCjkb-0007PD-KE; Fri, 02 Oct 2026 16:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkQ-0007Jw-95
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:20:52 -0400
Received: from mail-pj2-x2a.google.com ([2607:f8b0:4864:39::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkM-0005mT-NQ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:20:49 -0400
Received: by mail-pj2-x2a.google.com with SMTP id
 d9443c01a7336-2e2db9f927cso22117545ad.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 13:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790972445; x=1791577245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rc1hMaz4HVihHTfD+cBzgKL6/9ldS//SvnIMYsY26sA=;
 b=sPhrHH2Hpgj7LhAzG78rLhJGmV+CS+dNezkMUOmxq7ZvbTzTQVbYkN9i0Qh597Sum/
 K3rN3D2YHLGQslOvJXaDEF7YSDJMS4R4llUVApZnepGfUXpnwFyo4O14wX2RnZPwVbj1
 6Ore+mDNnxq0WdS5VIH2TuJoblGqZQPayX/b9s2uO7tq+Qpcrwpamglh2iZI3B1mDo/p
 ZE4Jkrb99/tWPmym4vULAP3sw/cOeOgGitj9nwOFUzqO11ZzyIYowoNCrfIAZDvXwGpT
 XirWnEuGvPE12Lu7V+qiw2b/2Wmu/qquoFyzCJ1Ivj10MkkK/C69xEpABp5HT9dRcsX2
 3MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790972445; x=1791577245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rc1hMaz4HVihHTfD+cBzgKL6/9ldS//SvnIMYsY26sA=;
 b=ouMoqLoOBEJNGfKyAHgy4So1cIX1HtSR6PLwcE8vAmzgMES1cdmdIc1YtjeWaZ/xrQ
 gEWT2yjpZTSQQVLEOhHpWYj3T1Tx1pp8g3yTSgrv1ZIBMs0eKzSqdyPwEf8HUGNZ4voO
 MdLoaWD935d8tQQYP6U4lpPMdnxM0/qGK28DlxPutVASeK3pAUsm0pS7W8SChhncgELi
 nyl95kpoqKxU1AmjKXQiIH3zPIEKKCcOEs5LuhMbhX9quijiz4ZlXt9kWdOLIX9xEMay
 1rxqAsry8XHAoC2jwSELGmYEnkaDo5TfWDmxDGupkMuV7CE/RbOD3Rf9SgaPRvvhzwqX
 V6fg==
X-Gm-Message-State: AFq9FYJMqY4uiVCxLleopGHFbBff63orrf7yeYvPTvw7SLrXz87a06hR
 v/2yGQXcynIpcBzHqCkVRl1fLuU4VsLlgOKGq8c5X55n7eMtJakNOH0Xk3nf3t9BYgQ=
X-Gm-Gg: AYBFou0JOGY380kCbot1/zydC9HV/BfuByTWwquH3AyWGQdzBQ1fJGp7JQCNkgk3/1U
 ahpmIUBN0927ehGuWzRFrJXEuUdbNvXIvaRifA+hCAukUzhM2vI5YacWhrNh6cTDv+8ypm1PwA5
 9V0O+HTMBgcqxlL4ADXi4xDPbOs0iK4sYts/oGYPXXSkt7pLxzv0Lz3cXCUDVqUBWF5DidD/SNH
 Sm5Szsh7EpeTQqn3MFdx+IAzy0TS+SNo4f8SuQRgMrU6yheDugNug5fXQ4q0mLb3bDVM7YEvChM
 9MvVIqZe6W4pIKwNvAQElYrox1OxCop/4ZIT62K1X4uvUKFXWAz6YFyOUoGcO9d8rGEuzSAGD3T
 F1eAGHpQKSMBbD38VP4S+VxY3Qaw0ldIkyBSBtjDKe2rGpHeZt9vJnaNK0Odpotn7QAV6QtMNDp
 6LqUIagp1CgOdrftW2cHD86fSSrXD7bwggiEMieKshNn2+75tMkGSoNzTIYiv//Wq3ZgGX7kuDW
 /S8KIqIWWaZbLJ4scUqDOE2
X-Received: by 2002:a17:902:e802:b0:2df:35f1:8771 with SMTP id
 d9443c01a7336-2e49b6d0622mr33942355ad.54.1790972445148; 
 Fri, 02 Oct 2026 13:20:45 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:61ac:e744:6559:a357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:20:44 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 09/22] target/arm/kvm-rme: Populate Realm with runtime images
Date: Fri,  2 Oct 2026 14:20:13 -0600
Message-ID: <20261002202026.1204110-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::2a;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj2-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
index b1fb8957f3de..22c8afe21505 100644
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
@@ -41,12 +42,87 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
 
 static RmeGuest *rme_guest;
 
+static int rme_populate_range(const RmeRamRegion *region, Error **errp)
+{
+    int ret;
+    void *buffer;
+    hwaddr size = region->size;
+    hwaddr base = region->base;
+    unsigned long page_size = qemu_real_host_page_size();
+    hwaddr start = QEMU_ALIGN_DOWN(base, page_size);
+    hwaddr end = QEMU_ALIGN_UP(base + size, page_size);
+    size_t aligned_size = end - start;
+    struct kvm_arm_rmi_populate populate_args;
+
+    if (!region->data) {
+        return -ENODEV;
+    }
+
+    ret = kvm_set_memory_attributes_private(start, aligned_size);
+    if (ret) {
+        error_report("RME: failed to configure initial"
+                     "private guest memory");
+        return ret;
+    }
+
+    /* Allocate page-aligned memory */
+    buffer = qemu_memalign(page_size, aligned_size);
+
+    if (!buffer) {
+        return -ENOMEM;
+    }
+
+    memset(buffer, 0, aligned_size);
+    memcpy(buffer + (base - start), region->data, region->size);
+
+    populate_args = (struct kvm_arm_rmi_populate) {
+        .base = start,
+        .size = aligned_size,
+        .source_uaddr = (uintptr_t)buffer,
+        .flags = KVM_ARM_RMI_POPULATE_FLAGS_MEASURE,
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
+    rme_populate_range(region, errp);
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


