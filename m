Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFC1606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=R2EPVLK5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXu8-0005NO-HL; Mon, 09 Nov 2026 17:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtp-0005EK-Hd
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:41 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtn-0003uO-6P
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:37 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8a07078200fso554673b3a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794263494; x=1794868294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=btUbetnuXJs/xXAN/qzDAKN55zdtCIUFJdsrBrK8sZE=;
 b=R2EPVLK5VAJ/jJi1rUk0RvvXs6di6sW3tIMc3mIBCrVK+KbKMN21Fjcpt6SN+hBZPm
 xssYHq9u5jhW+wa1XVkibPVOetflUECrnZ2gdrrUsmJEX2fXE93E5IFXxDrNS3xguous
 ElQ5GAGNi42k4AB4L9EkaaLsaR41hhmGzwWCW53bD2ywwcE347542MrrSBavZ3sfC9/1
 XP9QZy66j6USb0m5Hr295PUGWTCfkJcstoGUrP6J6ZfstAVpy1WVmYUoeP7ghQx99QlO
 Oeygt/YAredZqZrj+M2xBy3n5G1zSz3QR0CzDqYwKcDyxjoiP7TVwZ2L5eZ69ZJkgxQR
 j8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263494; x=1794868294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=btUbetnuXJs/xXAN/qzDAKN55zdtCIUFJdsrBrK8sZE=;
 b=uJMeGwHvNnI/5DBhNl1Npz1/cTl9wmFnRrV0XwD/1SRmA0Cyg2Msj5EyYBRqDJSPe1
 5pGlzSfLI44RgghWW3M4IqdzWIT3SvHWH6ixK5jmcMH4aQ3UQroDQ5bvnV9wLXGdBjQ6
 OTfbva4Z/O9Yh0UPV17rlsB0v3nR5zRqAONJM8dZ2uvMUTKI4orNuYAlce3chPLURZ6t
 3jnSSFc6TWaNyxsAIA03lMHTAQ1A+L8UwfVy+E7tEVyPk+ZdyMLIZ2VNZm1PtJ7I/QrJ
 BqnZeo92ofxo5ERsBnnhg7RxulwVmTMe1COqyUwQ5hQFrkvfd6GEEKCkSRLrNdNkhHP6
 Dokw==
X-Gm-Message-State: APuU4Z/vS2iy9LtSkxY8iQmn+WhTe61S3MdF6eiFH6se2FXcozIXn6Zo
 jIHVzix5NUJK0HZYMAS4jjwEZuyoOINKSvbTyWyZ6qfMcTmYtflqMbTM9GLZf9vWoFU=
X-Gm-Gg: AYBFou1euommTXOm+q0vIuYXdQAzUUHf34BfR9HbHOLthhZIpR/6sBL3faBbO9a2036
 0iax1nOvOFZLg9ZmBsTRK/7ZhNMAofxhVjDJs6VZbBEy6OGjqZUZj/DHCfeP8xaFijePQ8CYovf
 5qhTClcNkbITmP750eL82J+ad1v0KdUJjnTmaVQ2GfDiXKXTmc1T/evoPsUdKwUSk0FjwSP1+YI
 eVqKk6P9/5Gn0z6lyHW/4pykQr+AAcICW9tQgDQiEWZQkcH/jd4gdXw8ArmpfsoUz9/cQyA8ng0
 kDCUQAJjZGRr+dA74yEKk2HQlYh1/vDE3RXAQhkjNZM3gvaUvOkleBLPMVQJx/QFLg6UUZ4DRWL
 oidQuYG4m2QWmCt4RveepHwDlRPii4WwLLAhhUNmyHd1/J1q8z9Yas39cYGSIJrZC9QMxxVTvCp
 dnf+dVpOWmoA5JTku4Jv+QATAndQ4KVZ6CHt2lEWE8EP7UH7YFmESNsxd9zJJAx61sne5JP2IIC
 SXMUWpDfIFXsS0eHgO9cFYxHI6yd6quN6b/AjkJtaWagEtsNnYSCmO8UGnh+EqPYHcOu9C41LOH
 lqVXG5dED5TuRNgvVgrw7urQaekFZVa8rJT6whDNrZIOigLQDCq6Ph0=
X-Received: by 2002:a05:6a00:1885:b0:89e:9c7e:fd56 with SMTP id
 d2e1a72fcca58-8ba86d850cbmr871469b3a.33.1794263493533; 
 Mon, 09 Nov 2026 14:31:33 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:31:33 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 10/23] target/arm/kvm-rme: Populate Realm with runtime
 images
Date: Mon,  9 Nov 2026 16:30:57 -0600
Message-ID: <20261109223110.1619504-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x42c.google.com
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

Once the Realm descriptor has been created, tell KVM to transfer runtime
images (kernel, DT, and rootfs) from guest memory to Realm memory.

This patch was originally authored by Jean-Philippe Brucker
<jean-philippe@linaro.org> and updated to account for guest-memfd
convert-in-place by Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>.
It was later completely refactored by the current author.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c | 166 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index ca90bf5af890..0996cddf0849 100644
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
@@ -29,18 +30,182 @@ struct RmeGuest {
     GSList *ram_regions;
 };
 
+typedef struct RmeAlignedSlab {
+    hwaddr aligned_start, aligned_end;
+    hwaddr end;
+    GList *region_list;
+} RmeAlignedSlab;
+
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
                                           CONFIDENTIAL_GUEST_SUPPORT,
                                           { TYPE_USER_CREATABLE }, { })
 
 static RmeGuest *rme_guest;
 
+static void rme_populate_slab(gpointer data, gpointer err)
+{
+    RmeAlignedSlab *slab = data;
+    hwaddr aligned_start = slab->aligned_start;
+    hwaddr aligned_end = slab->aligned_end;
+    unsigned long page_size = qemu_real_host_page_size();
+    size_t aligned_size = aligned_end - aligned_start;
+    struct kvm_arm_rmi_populate populate_args;
+    GList *list = slab->region_list;
+    Error **errp = err;
+    void *buffer;
+    int ret;
+
+    if (*errp) {
+        goto out;
+    }
+
+    ret = kvm_set_memory_attributes_private(aligned_start, aligned_size);
+    if (ret) {
+        error_setg_errno(errp, -ret, "RME: failed to configure initial"
+                         "private guest memory");
+        goto out;
+    }
+
+    /* Allocate page-aligned memory */
+    buffer = qemu_memalign(page_size, aligned_size);
+    if (!buffer) {
+        goto out;
+    }
+
+    memset(buffer, 0, aligned_size);
+
+    for (GList *elem = g_list_first(list); elem; elem = g_list_next(elem)) {
+        RomLoaderNotifyData *region = elem->data;
+        hwaddr offset = region->addr - aligned_start;
+        memcpy(buffer + offset, region->data, region->len);
+    }
+
+    populate_args = (struct kvm_arm_rmi_populate) {
+        .base = aligned_start,
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
+                aligned_start, aligned_end);
+            break;
+        }
+    }
+
+    qemu_vfree(buffer);
+out:
+    g_list_free_full(g_steal_pointer(&slab->region_list), g_free);
+}
+
+static RmeAlignedSlab *
+rme_init_aligned_slab(RomLoaderNotifyData *region)
+{
+    RmeAlignedSlab *slab = g_malloc0(sizeof(RmeAlignedSlab));
+    unsigned long page_size = qemu_real_host_page_size();
+    hwaddr base = region->addr;
+    hwaddr size = region->len;
+
+    slab->aligned_start = QEMU_ALIGN_DOWN(base, page_size);
+    slab->aligned_end = QEMU_ALIGN_UP(base + size, page_size);
+    slab->end = base + size;
+
+    slab->region_list = g_list_append(slab->region_list, region);
+
+    return slab;
+}
+
+static void rme_insert_in_aligned_slab(RmeAlignedSlab *slab,
+                                       RomLoaderNotifyData *region)
+{
+    slab->end = region->addr + region->len;
+    slab->region_list = g_list_append(slab->region_list, region);
+}
+
+static GList *rme_swizzle_memory_regions(void)
+{
+    GSList *tmp, *node = g_steal_pointer(&rme_guest->ram_regions);
+    GList *slab_list = NULL;
+    RomLoaderNotifyData *region;
+    RmeAlignedSlab *slab;
+
+    /* Memory regions, i.e @node, appear in ascending order */
+    while (node) {
+        region = (RomLoaderNotifyData *)node->data;
+        tmp = node;
+        node = g_slist_remove_link(node, tmp);
+        g_slist_free(tmp);
+
+        /*
+         * The slab list is empty, so simply create a slab based on the first
+         * entry we got from @rme_guest->ram_regions.  Since ->ram_regions are
+         * sorted, we are guaranteed to start with the lowest region.
+         */
+        if (!slab_list) {
+            slab = rme_init_aligned_slab(region);
+            slab_list = g_list_append(slab_list, slab);
+            continue;
+        }
+
+        /*
+         * Slabs and ->ram_regions are sorted, so we know the last slab in the
+         * list is always the current one.
+         */
+        slab = g_list_last(slab_list)->data;
+
+        /*
+         * TODO: Add support for memory region that straddle two pages if we
+         * think it is important.  Doing so may lead to large memory areas that
+         * may not be accommodated easily by qemu_memalign() in
+         * rme_populate_slab().
+         */
+        if (region->addr < slab->aligned_end &&
+            region->addr + region->len > slab->aligned_end) {
+            error_report("Memory region [0x%"HWADDR_PRIx", 0x%lx]"
+                         "straddles two pages",
+                         region->addr, region->len);
+            g_free(region);
+            continue;
+        }
+
+        /* Add the memory region in the current slab if it fits */
+        if (region->addr >= slab->end &&
+            region->addr + region->len <= slab->aligned_end) {
+            rme_insert_in_aligned_slab(slab, region);
+            continue;
+        }
+
+        /*
+         * Allocate a new page aligned slab if the region can't be fitted
+         * in the current slab.
+         */
+        slab = rme_init_aligned_slab(region);
+        slab_list = g_list_append(slab_list, slab);
+    }
+
+    return slab_list;
+}
+
 static void rme_vm_state_change(void *opaque, bool running, RunState state)
 {
+    Error *errp = NULL;
+    GList *slab_list;
+
     if (!running) {
         return;
     }
 
+    slab_list = rme_swizzle_memory_regions();
+    g_list_foreach(slab_list, rme_populate_slab, &errp);
+    g_list_free_full(slab_list, g_free);
+    if (errp) {
+        return;
+    }
+
     kvm_mark_guest_state_protected();
 }
 
@@ -55,6 +220,7 @@ static gint rme_compare_ram_regions(gconstpointer a, gconstpointer b)
 
 static void rme_rom_load_notify(Notifier *notifier, void *data)
 {
+    /* Each memory region is free'ed in rme_populate_slab() */
     RomLoaderNotifyData *region = g_memdup2(data,
                                             sizeof(struct RomLoaderNotifyData));
 
-- 
2.53.0


