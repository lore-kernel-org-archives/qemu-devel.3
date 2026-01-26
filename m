Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10957D19510
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQdD-0001in-2V; Mon, 26 Jan 2026 12:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcz-0001Uv-HS
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:54 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcx-0000Et-4Z
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:53 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42fb4eeb482so3255273f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449429; x=1770054229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3f/R3DyEyYJjykoOvhSgMY2C3lcLS3L+Ir44GNyL2FU=;
 b=O0W9D5qaTvIYVNOZ1dIXyiXMJ7S+d8VRNyy63Hv5DTrp60vLGcJqHz3a80NbdhCom8
 zZNE/UWY58cJB7TDqZ5VPqpnW77sCRqEeAdAhOyLHUuH/48fKrfmBoeWnwF62NGS/nvv
 ysUl5ejLDyeFn/hLDacbyY2REAg1tNd6BCTl2kdRdGMTeWx1Wn18uEw04LlzSq5Wac4z
 7x1u3Vh9pB+wJaS/v7yItTBdh7BR+1mtr5rT5V4/qVkhhhQ6/RJy0jE30XCfZdoekeVG
 KRg9Hz4s8cBgVl1fj9/8FwKAC3bRHIHodGoMZUFcxsjrs5amXsk3dHsUyVM5mS23XZar
 36tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449429; x=1770054229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3f/R3DyEyYJjykoOvhSgMY2C3lcLS3L+Ir44GNyL2FU=;
 b=ptTA17El4/jYdgUvKigvBtdr1bthdPTyFnbf192ON4skHgSFTidFnc9cbc9VMjFhG+
 is2Kx7u5QrEp3fKGeRqgT7WET1h1EC2wb6UN9a3EfH3QOggDkJ4Meggawa4Xnx8sbGqw
 TBuIrAYIqtOoIKYLnDcG7HW5mO+iuvgRXO9XqECQrfciAAXEDzyIrEj3MHMOftiEq6zF
 6x0ZX+LEXOcBEBIvzO7qNd52cumB9jXIe4WnTeRslCWkcfvAe2QQ6RL8D1iWYQa3Bl78
 aYQdPE4sQ/2EBkArwqYWvvzSfLtVKxRr3qiR7CkQsRdNC+/uKG2oSqppkWeVXQvWpFTZ
 s/Sw==
X-Gm-Message-State: AOJu0Yyw578vFL1fDwhIaaRW9Fa2XfGlQOftqkmn5qjidKm+D4WgU6RY
 ayq59UU2+sbfiH6/Ehx9SyaD9WEO5eXcOXLEtkC/tKRmOGM70YztL/hVSPqjZihe
X-Gm-Gg: AZuq6aJlUyrM5fS1kKMji1GDBpkPg+6W4hjLnzv8kiDdliqIWnwpq7kxZcbzX3pYNV4
 E+7f5AyO39OWg8fuQMJL7eHNjZ4+Hu+OIGetucQzuWh8nEQa5RObNms8th9gEc9Vo1vVzCuqcdD
 VCmeAJo/JeukG8X7jP6oaxJ8cmiqLMY8t+bmOOWf5QA9x1j6VuMpFXGKQ9FZYyTpBc8DyLGr98s
 byNHuYupMvb6aFZwsNLj+0THbplMMoswLBOrT8dlsUx+NCNg5bTNbTWeNwi1LZiFtkkHwgMgREk
 xIcTkeLP7GeG3G6AE8DmzKOEl4YjYcVKzhTWQnO1v+iiUcWtsJnrbwwGmpaJucQbUxCeiBNZtv4
 IzYV3svx+Ef1YAxkUKfKWU7Q0CHbVTBntbs09CZEPhobvod9DuYnmPrAtJkd77CrGWKNfjkDJEK
 3XNtE64JD6Ell7nOnzl8S/CdNYHoBRNPgAIbBQ3xCfHPIsnczwIAuy/2nadzZiwn5T
X-Received: by 2002:a05:6000:2212:b0:430:f255:14b2 with SMTP id
 ffacd0b85a97d-435ca0f7a13mr8286844f8f.13.1769449429479; 
 Mon, 26 Jan 2026 09:43:49 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:49 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 25/27] system/memory: implement FDT_GENERIC_MMAP interface
Date: Mon, 26 Jan 2026 18:43:11 +0100
Message-ID: <20260126174313.1418150-26-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42c.google.com
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
index a683af525a..866c741973 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -38,6 +38,8 @@
 
 #include "memory-internal.h"
 
+#include "hw/core/fdt_generic_util.h"
+
 //#define DEBUG_UNASSIGNED
 
 static unsigned memory_region_transaction_depth;
@@ -3749,6 +3751,57 @@ static gboolean mtree_info_flatview_free(gpointer key, gpointer value,
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
@@ -3994,6 +4047,11 @@ static const TypeInfo memory_region_info = {
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


