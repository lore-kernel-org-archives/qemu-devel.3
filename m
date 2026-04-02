Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14B4D6AB1A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q3A-0000xI-8R; Thu, 02 Apr 2026 17:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2e-0000BN-Vf
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:33 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2c-0007FL-4W
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:31 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-66e07d6bba5so1939428a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167048; x=1775771848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUnnhkK/qXiPp936orDPcoBrWF8G/ssU5VMirqtDrGI=;
 b=ZnDYAFeA/AWOv6euJNqcBkUNrwjicjQKfKe0FnLm8uWCCrsYgDPNFZezW8WFU2kIPP
 NVKUrwiHJN/27R65hDfmwPOMK5fykNf2C3j2XS1ocHVaWxrcbev9+7qkdnOSUdo6izdx
 IWsfZ2QxIhMt5QXhMbWUzjTMKCUWUFnxH8nUQ4MaK5mkbpxOh4XKCEdyyFCdTyFc+orH
 T8rxCnDxQZ0qXtD4tg07enp2QurOAakNrVPdiB53rkOTC93GI0w5ka7K+QU7Ms472VCr
 Yf7a3Glf8WNOPix5m44E1d4sshYBjHtdDAsrU0zcsOqcLxU5Xnm2Tuqwy0dxNHPC/RX4
 PGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167048; x=1775771848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VUnnhkK/qXiPp936orDPcoBrWF8G/ssU5VMirqtDrGI=;
 b=rdCGwrQhWHs9jPlUagF9gamVAWBbo3U18kxNScWrbUWLEnvU0xPRLKUGjxgHJDmi2A
 1S2Kvu49q8Ux3aoZbYJR8cl+PYmmiItKXgKTdYOkvg6Q64D6CbGtmj5HXnFwcNwAnsd0
 zEQd8AZqkYEC3uiyUWp8U8tTn8CiNEtXUo3aacCSDjxB7Q3sD7nD5mmYKHQos5J5TrhA
 Nc3tWNngpAPrW5kkug4BFZg4b9iwNEPCx2tkCZwGPx3uKmZ+qTM9ZoUG4cqnUfd0kseM
 K6WrCMshnGbXrFSrYMh2xqkqv9EhEevqrg3PN3cV5jXya2IUB+BvtiKVazI4KMC/Y37O
 sCag==
X-Gm-Message-State: AOJu0YyMGhbVOKI7+Dd6Sg5rXnPz/K9H9p7wJD+nbbNaxAIli4/Qg9Pi
 kYoMBXuVICd9vB8jAbdTK5iTFhGD+EpWxq2XNVAVu+gKmXcGKChxl5ApdZtF9ZEs
X-Gm-Gg: ATEYQzwaqjTWLsUgot8s76L/WxW6AJ3Q17ejK3f5rIhYkFy4dvF/TBe1+Lp7tvIvLgs
 FwMFlnFF4iST6+i19Y2KfxT7T7an5IR3uT9jDT6EN2X6CkTyPc7UuAfjSt0gL3jcvvtOlRb9sdZ
 CYRVxEOp3wwewXGIJqX+vh/yq7ZCI8A4thKOzJMurGBHiYJJZ+RWFaxrGrdvPgzo6jN6z9RjPxq
 Oogf5JIlDFmFLPjralrHVP1JPkE8C/yD5REaJJUmk4LCMm8cbsoat01p/KMvkMRFIYZk6rynVlp
 OV59jZjnxjahqLNfUN9KFHwd58FcDuhPxJnMIjRk403Kc7uk+Wd9bMWc4+sXACovRhhHbJTqezZ
 PH9CQvRD2E260ToZogn7u/9MHnaCesKb75ksHLpMBZrB2S4RStstOgPklgX8DvoDZHDVIXA0TXA
 luj3YWCEt1WWA0B0PodFlCoVfQHsiuCrsQHSxZJFep6fCIEsV5sw575ybzvzjDLrpY1nhodA==
X-Received: by 2002:a17:907:8b93:b0:b9c:ed9:50c8 with SMTP id
 a640c23a62f3a-b9c67979c9cmr25722466b.26.1775167047654; 
 Thu, 02 Apr 2026 14:57:27 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:57:27 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 26/33] system/memory: implement FDT_GENERIC_MMAP interface
Date: Thu,  2 Apr 2026 23:56:11 +0200
Message-ID: <20260402215629.745866-27-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

The patch implements TYPE_FDT_GENERIC_MMAP interface
for the MemoryRegion class.

This enables memory region objects to be automatically
constructed by FDT parser based on the 'reg' property
in the Device tree. The implementation parses register
tuples and set base address, size and priority properties.

Optionally parent container can be set of newly created
memory region.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 system/memory.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/system/memory.c b/system/memory.c
index cd463a3dde..b3d981dc0c 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -38,6 +38,8 @@
 
 #include "memory-internal.h"
 
+#include "hw/core/fdt_generic_util.h"
+
 //#define DEBUG_UNASSIGNED
 
 static unsigned memory_region_transaction_depth;
@@ -3721,6 +3723,57 @@ static gboolean mtree_info_flatview_free(gpointer key, gpointer value,
     return true;
 }
 
+static bool memory_region_parse_reg(FDTGenericMMap *obj,
+    FDTGenericRegPropInfo reg, Error **errp)
+{
+    MemoryRegion *mr = MEMORY_REGION(obj);
+    uint64_t base_addr = ~0ull;
+    uint64_t total_size = 0;
+    uint64_t max_addr = 0;
+    int i;
+
+    if (!reg.n) {
+        return false;
+    }
+
+    for (i = 0; i < reg.n; ++i) {
+        base_addr = MIN(base_addr, reg.a[i]);
+        max_addr = MAX(max_addr, reg.a[i] + reg.s[i]);
+        total_size += reg.s[i];
+        if (reg.p[i] != reg.p[0]) {
+            error_setg(errp, "FDT generic memory parser does not support"
+                       "mixed priorities");
+            return false;
+        }
+    }
+
+    if (total_size != max_addr - base_addr) {
+        error_setg(errp, "FDT generic memory parse does not "
+        "spport discontiguous or overlapping memory regions");
+        return false;
+    }
+
+    /*
+     * FIXME: parent should not be optional but we need to implement
+     * reg-extended in kernel before we can do things properly
+     */
+    if (reg.parents[0]) {
+        object_property_set_link(OBJECT(mr), "container", reg.parents[0],
+                                 &error_abort);
+    }
+    object_property_set_int(OBJECT(mr), "size", total_size, &error_abort);
+    object_property_set_int(OBJECT(mr), "addr", base_addr, &error_abort);
+    object_property_set_int(OBJECT(mr), "priority", reg.p[0], &error_abort);
+    return false;
+}
+
+static void memory_region_class_init(ObjectClass *oc, const void *data)
+{
+    FDTGenericMMapClass *fmc = FDT_GENERIC_MMAP_CLASS(oc);
+
+    fmc->parse_reg = memory_region_parse_reg;
+}
+
 static void mtree_info_flatview(bool dispatch_tree, bool owner)
 {
     struct FlatViewInfo fvi = {
@@ -3941,6 +3994,11 @@ static const TypeInfo memory_region_info = {
     .instance_size      = sizeof(MemoryRegion),
     .instance_init      = memory_region_initfn,
     .instance_finalize  = memory_region_finalize,
+    .class_init         = memory_region_class_init,
+    .interfaces         = (InterfaceInfo[]) {
+        { TYPE_FDT_GENERIC_MMAP },
+        { },
+    },
 };
 
 static const TypeInfo iommu_memory_region_info = {
-- 
2.43.0


