Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD0CC44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whEVw-0001NQ-Gs; Tue, 07 Jul 2026 18:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVv-0001MU-5O
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:39 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVs-0004Ad-G1
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:38 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cc84e77e78so766125ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783464215; x=1784069015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sdhTsW4I+bhY4ihV01HmgTW3Yi5b9306awX7r7PmOk0=;
 b=ogVc/WI3hgXRsWc5fpP9BT77MSh/ya0CE55/2JVNIrud8VGTEHSksFui6CEjsFqlcr
 aiTVbsJyA1Wg7VzNkCbsKzpPJ6ns5HaYW9hED6cMSeqOwOFfgeu2leTPf7HX2jkACHA9
 8JAmv/hMOMKSYFY0YK0WCFtxn9gjoQbuAAx6kXLPAkdcmfFRqbcL33X7v5lLYOM/zXj0
 0qizbzWgrL2Da80K5HwY0PmdWpHaUyIonYd4S5fDQGtZTjouR+ti52E1pX7doUcnieU2
 lqXFXZbQj/jwN7umsJUk9ndeNIyTiztfhcE4iP5sI1B3A0/Z4Dy1QcIC7UkzXkA1dfIy
 eP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783464215; x=1784069015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sdhTsW4I+bhY4ihV01HmgTW3Yi5b9306awX7r7PmOk0=;
 b=NPAaR4sW35HrIAT41GvVZACk43GAk9EhIjzmImgxVS//pWfB7OT1NQoRIuEV8/Skw5
 oE9bWo0zuOVZLoCAHmpL5tjxBgvfIlTAEY0yX75V0I3mKU1Vsyg9nzcHXLPR5U3GHRPq
 4VoajFvWEOkb35QBHJ6I1vk/LQ4Kxoc1/+jacEYw/5Qf9Sl4HnI8F1E7rkVA1L6iiQkL
 POxJ82UiafGQa/as02p9dk6Y4MvAtHm3cRxuU+8F+Q1jFdosamv5OR4DQ9chooPaHdbN
 EtlOu7UuWnHE+v6tbLSQFbLqmTNHDGPx9q6fpzNWHt2gf/S8nV8ED7DpQ+jKdGDGiwHH
 yonw==
X-Gm-Message-State: AOJu0YwCMHbXQWiPt+sS1KEADYPJfPyk3LUji4ZEUhKv0k8p4drPzC7l
 gHit5AWw8rglyMsDgig3PWgj1zgU23SfuzQd/J0pNPwTJ92hrlNoEOxFJATAcDXhYAQ=
X-Gm-Gg: AfdE7cnmm+jzkyL0bCtqyrw+o/1AM2CsfV+t0j48yiM62ZQMCUfB9PMQLiD5k9G23BO
 7wp3MAwpRsjNsAGeXyhpPZ4fqYaJsegkOH43v3W8CpKA4G8YkiG6WgFOlrcb0iuVWR4Rv3gXWUJ
 2zLaN82kgjlSFbgpGHj5RmY7Xjluur/MOauZb7Uke7xfTShFXzO+M36Zin5u1qkS3bbpvjCcNxD
 wKFkIXTf/HJ+WOd0e7tOFMP8F7NzkAoMPzmX9OLMdnjp1K3M3XDo9oEjyLsLrwFAtlWyAJ6gUuP
 bUO5PqNNZ0pivXLj7+PWGvZZb02k0h9JXXPvUaoa0uqWBfprBNWmtXVZs3B7qL9p/sAmCiUpjEd
 8QiT+Rx2rIG2QBmKGFoJzoa100v0SwfOrBm9V5TRffKAmSKO18KH9yO21SLw2DzRIz8IZqPTBqb
 u3f0rRSrhLGxWey6KcQjd9PFclGa01rX7HRbNtHuwkgUROYOJrqA==
X-Received: by 2002:a17:902:ff8e:b0:2c0:db23:4c4 with SMTP id
 d9443c01a7336-2ccbe628ac2mr67463975ad.16.1783464215210; 
 Tue, 07 Jul 2026 15:43:35 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:43:34 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 12/25] target/arm/kvm-rme: Populate Realm with runtime images
Date: Tue,  7 Jul 2026 16:42:53 -0600
Message-ID: <20260707224306.1202330-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x62b.google.com
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

Once the Realm descriptor has been created, tell KVM to transfer runtime
images (kernel, DT, and rootfs) from guest memory to Realm memory.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c | 56 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 97ec7c8934c9..58669f4a50f1 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -44,12 +44,68 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
 
 static RmeGuest *rme_guest;
 
+static int rme_populate_range(const RmeRamRegion *region, bool measure,
+                              Error **errp)
+{
+    int ret;
+    void *host_ua;
+    hwaddr size = region->size;
+    hwaddr base = region->base;
+    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
+    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
+    struct kvm_arm_rmi_populate populate_args;
+
+    host_ua = address_space_map(region->as, base, &size, false,
+                                MEMTXATTRS_UNSPECIFIED);
+
+    populate_args = (struct kvm_arm_rmi_populate) {
+        .base = start,
+        .size = end - start,
+        .source_uaddr = (uintptr_t)host_ua,
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
+    address_space_unmap(region->as, host_ua, size, false, 0);
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


