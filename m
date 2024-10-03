Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8868ACF34A9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 14:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swMrS-0006Au-LG; Thu, 03 Oct 2024 10:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1swMrQ-00068i-1v
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:31:20 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1swMrN-0003uk-RD
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:31:19 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2fac3f1287bso12924761fa.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 07:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727965876; x=1728570676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mm+KI23c86LD33sZYRxxXCIhV12T/Ywht8Xuz1hXe+0=;
 b=SIpf5zmVjM8mr06cmbG3hnWfXADK2m6hJ20nWVtCvLbG0ZXte66lOLz6dyeKiW4Gua
 BKb0yEleHCwuzHX6LnK1h+CD+OmOVm9yvz48ExTuLzjCuqDzfqC/4j/Bcy5OApdhjdYT
 NZ0ZY84CsyUMJjUrRAl5UFJ6V4pbJSCaGsnrYii+q0IIMz4c+mbSCs6eLbCQp1zGDcNS
 RjNBd69A4zx8UqPKtKcHzq6w7E2/VRJHh5TikfAUS8SQ85I8t9oVUJFG5ti7E6axKY4k
 w8YPA/FBZHkd10IreNZ2U2fb98bXJ0oQUVpHBx5hjRQyQZo6Rs0Op8jPazreaVmde6TS
 DbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727965876; x=1728570676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mm+KI23c86LD33sZYRxxXCIhV12T/Ywht8Xuz1hXe+0=;
 b=O0X2pkWnO4y+Gru+Sq/lIPX5gXNDs1tPubMRYT5q8lvLlQgFDOGzrMHDyVMu0VQIdr
 4ShC/j8vt/8UfVZfuRpa4c8ndoM3QO8InNsMiidkozl7YFFGvcbzN1168LOdQMRLKgNi
 aGkStT6rQkcqiOAgz5POAvKVQo4r+QgVuWNz9X4WlwYbFW+D7EPKp6Hmrv2eOy9kxnfe
 e6oHrylqGWMoTSBldWn+2y49x/ljkOKFBJmS33bfmWqVvUyKubUcUcOKOeZQpbtdDahI
 ZsbTdZ9Yg2DGfItJfDdf8zFZNwX+KlIGgrpLeFrEYYqZnpsUZqhY7ypSaZ9Y8TgwNSna
 prbQ==
X-Gm-Message-State: AOJu0YxkM8iPYYnkOlIomCJWHKfhpUhAnxroPrANPS5S7epE1KiD3YeD
 pdW6Rj45nw6lPqZJUkWDoIVgR2fNYc9Iet2h40rlFIwwv02K5P3mM+S2g60k
X-Google-Smtp-Source: AGHT+IHCsQYggo4+QHNTj+E9IQLO7FGvdIFdGsNJPj3Xn8OHbIfJIYVd+Xs40rnxZoWpf5j1Z25ZfA==
X-Received: by 2002:a2e:bc1a:0:b0:2fa:d723:efc8 with SMTP id
 38308e7fff4ca-2fae1033a7amr52001111fa.26.1727965875455; 
 Thu, 03 Oct 2024 07:31:15 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faecc6b0a7sm2305121fa.94.2024.10.03.07.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 07:31:13 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PULL v1 4/5] hw/xen: xenpvh: Add pci-intx-irq-base property
Date: Thu,  3 Oct 2024 16:31:01 +0200
Message-ID: <20241003143103.1476805-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241003143103.1476805-1-edgar.iglesias@gmail.com>
References: <20241003143103.1476805-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-pvh-common.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 76a9b2b945..218ac851cf 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -218,6 +218,11 @@ static void xen_pvh_init(MachineState *ms)
             error_report("pci-ecam-size only supports values 0 or 0x10000000");
             exit(EXIT_FAILURE);
         }
+        if (!s->cfg.pci_intx_irq_base) {
+            error_report("PCI enabled but pci-intx-irq-base not set");
+            exit(EXIT_FAILURE);
+        }
+
         xenpvh_gpex_init(s, xpc, sysmem);
     }
 
@@ -273,6 +278,30 @@ XEN_PVH_PROP_MEMMAP(pci_ecam)
 XEN_PVH_PROP_MEMMAP(pci_mmio)
 XEN_PVH_PROP_MEMMAP(pci_mmio_high)
 
+static void xen_pvh_set_pci_intx_irq_base(Object *obj, Visitor *v,
+                                          const char *name, void *opaque,
+                                          Error **errp)
+{
+    XenPVHMachineState *xp = XEN_PVH_MACHINE(obj);
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+
+    xp->cfg.pci_intx_irq_base = value;
+}
+
+static void xen_pvh_get_pci_intx_irq_base(Object *obj, Visitor *v,
+                                          const char *name, void *opaque,
+                                          Error **errp)
+{
+    XenPVHMachineState *xp = XEN_PVH_MACHINE(obj);
+    uint32_t value = xp->cfg.pci_intx_irq_base;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
 void xen_pvh_class_setup_common_props(XenPVHMachineClass *xpc)
 {
     ObjectClass *oc = OBJECT_CLASS(xpc);
@@ -318,6 +347,13 @@ do {                                                                      \
         OC_MEMMAP_PROP(oc, "pci-ecam", pci_ecam);
         OC_MEMMAP_PROP(oc, "pci-mmio", pci_mmio);
         OC_MEMMAP_PROP(oc, "pci-mmio-high", pci_mmio_high);
+
+        object_class_property_add(oc, "pci-intx-irq-base", "uint32_t",
+                                  xen_pvh_get_pci_intx_irq_base,
+                                  xen_pvh_set_pci_intx_irq_base,
+                                  NULL, NULL);
+        object_class_property_set_description(oc, "pci-intx-irq-base",
+                                  "Set PCI INTX interrupt base line.");
     }
 
 #ifdef CONFIG_TPM
-- 
2.43.0


