Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16AE10775FF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2uzr-000261-UG; Wed, 18 Mar 2026 13:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2uzk-00020M-2s
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:47:48 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2uzg-0005pJ-68
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:47:46 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ad9516a653so444615ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773856063; x=1774460863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WdPki2OUDvv7GbdAB4TVVTocQqYHi/i0OX7XXacQtPQ=;
 b=rRdupp46TPnV7AKpe9dn8jijGC1dzEjvm1kmc1MZJwlRv+woScjs4IU/c/BRG+q6pg
 9IJg/lKK7B135X/q82ljDTR/pyDGO6u2fEN8Nf5jvezm20cf9QVqZRhJawRLc06T4cZu
 Ncbn4igm7o1/L5Bdp68z4uUiCjVgKTTBLmBOKvUdTs7tzjW5c4yG+VUAzj4iqI65xr0x
 Nuqs1ux9KHrrsUka3UwGUiACS39+YIoBOc7Swf8KCG7ScqORbvf32JWdCpbmOitvt3JR
 fXdJAmNTVIVUNdfWYjR7i916YLlvzweKYaFzbpN+XjsxTr+5Hhx/Dxk1g+tCWxHptwOI
 Mpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773856063; x=1774460863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WdPki2OUDvv7GbdAB4TVVTocQqYHi/i0OX7XXacQtPQ=;
 b=QKZk6EuFlHkvgYHTGknMCDJHlyVSLt28LTRDDCRWn7Dsrrmp5wt/pe4AybGbn2PElk
 /8T8F8VmIuaR8MGlbeZ7XGVyNTXd+ZYq15z6e4NqYMzoVrURGcxepA7PsoojipxJcHv9
 3/6is5afeV42VU8wmb0sJePcJaKbBgSBGC++VGMt3M5I4N9pi/Sha24i0Kr0MY+P1AXb
 U+sRTAw9aRq6TIkLiOJnZLTUYqJOtQefIe+tndfRqmPX1E7l3vHwrJUWmm8PkColg9Jk
 AaiQixDenL2yZ1zstXRVno1Wb9CDN/pOrPjIX2vj45+XHnaCoTEVhabH7j1zXMsjFiyM
 oxQg==
X-Gm-Message-State: AOJu0YxAHXOIltq5xhCtWXbVhRqKv170lLo/T6t6Vu/Rj8lDSbj9ZPff
 akZ/1tLvQuHyZpTZEifbwtGQiCuVzZykyR0rzxGaFfE8z+bHveLkfXM6rVQYbe91ZERK4p4Ak3X
 qc/WrXuQ=
X-Gm-Gg: ATEYQzzk4fIq5NiKy+tMP75C5UuMw+SdEKeERiOqDRupWkc+kFR8/4b582xwXvFZ5jZ
 Yn2+MXQpcTPx7cbbdBOn/Z/S/lmGQl4L2J278vquGawKu2S6O4lb/HZaOOxBJwnuINvOGAbdkky
 EtUakAywpKog5LqSbrysQvt2ClHYvdMHWA313wQdPw0l5gJkmwMXzwZCbCTlEceiF+nCHgP0hHS
 2c9EyLZ6Z8Ys1he3/Jf1CnoYbXBtfMx1Hu0RRh4r7n1Dzg7BMRRHnXSyBPGR5mw2fnKV/PV6Rub
 lfB4lr1sN2jmFmvcP7m8leJkN2ZkOIl3zo3dBzYmLi8JligsXwAePyhhZQBpzJvubixvPzc2BFa
 cvfKXwZDE8MX4bUGovLPLQHHFSvMxdUncop4bZTPpBeJbZmKctzo2GUBReO6cbo83a1nxElpxBy
 qhdWVVTJ86PI0eli12JaS1AGamfN8DatnBgOK5Gw7+eN2xPxNUBb7s7Qi2PNRf7TGwKjI9b/GRp
 U0Z
X-Received: by 2002:a17:903:38c3:b0:2ae:a45b:42f7 with SMTP id
 d9443c01a7336-2b06e3c3ab2mr44515835ad.36.1773856062557; 
 Wed, 18 Mar 2026 10:47:42 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e5f0ac2sm34066185ad.52.2026.03.18.10.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 10:47:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, philmd@linaro.org,
 qemu-ppc@nongnu.org
Subject: [PATCH v5 5/8] hw/vfio/pci.c: eradicate CONFIG_KVM
Date: Wed, 18 Mar 2026 10:47:30 -0700
Message-ID: <20260318174733.1717643-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
References: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

We just need to add kvm_enabled() guard when calling concerned
functions, but no need to extract those kvm functions since they are not
using any kvm specific types that would not be visible at compilation
time.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/pci.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index df617f1fe46..811e5001de5 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -152,7 +152,6 @@ void vfio_pci_intx_eoi(VFIODevice *vbasedev)
 
 static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 {
-#ifdef CONFIG_KVM
     PCIDevice *pdev = PCI_DEVICE(vdev);
     int irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
 
@@ -206,14 +205,10 @@ fail:
     qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
     vfio_device_irq_unmask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     return false;
-#else
-    return true;
-#endif
 }
 
 static bool vfio_cpr_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 {
-#ifdef CONFIG_KVM
     if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
         vdev->intx.route.mode != PCI_INTX_ENABLED ||
         !kvm_resamplefds_enabled()) {
@@ -236,14 +231,10 @@ static bool vfio_cpr_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     vdev->intx.kvm_accel = true;
     trace_vfio_intx_enable_kvm(vdev->vbasedev.name);
     return true;
-#else
-    return true;
-#endif
 }
 
 static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
 {
-#ifdef CONFIG_KVM
     PCIDevice *pdev = PCI_DEVICE(vdev);
 
     if (!vdev->intx.kvm_accel) {
@@ -277,7 +268,6 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
     vfio_device_irq_unmask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 
     trace_vfio_intx_disable_kvm(vdev->vbasedev.name);
-#endif
 }
 
 static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
@@ -287,7 +277,9 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
     trace_vfio_intx_update(vdev->vbasedev.name,
                            vdev->intx.route.irq, route->irq);
 
-    vfio_intx_disable_kvm(vdev);
+    if (kvm_enabled()) {
+        vfio_intx_disable_kvm(vdev);
+    }
 
     vdev->intx.route = *route;
 
@@ -295,7 +287,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
         return;
     }
 
-    if (!vfio_intx_enable_kvm(vdev, &err)) {
+    if (kvm_enabled() && !vfio_intx_enable_kvm(vdev, &err)) {
         warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
@@ -350,16 +342,14 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     vdev->intx.pin = pin - 1; /* Pin A (1) -> irq[0] */
     pci_config_set_interrupt_pin(pdev->config, pin);
 
-#ifdef CONFIG_KVM
     /*
      * Only conditional to avoid generating error messages on platforms
      * where we won't actually use the result anyway.
      */
-    if (kvm_irqfds_enabled() && kvm_resamplefds_enabled()) {
+    if (kvm_enabled() && kvm_irqfds_enabled() && kvm_resamplefds_enabled()) {
         vdev->intx.route = pci_device_route_intx_to_irq(pdev,
                                                         vdev->intx.pin);
     }
-#endif
 
     if (!vfio_notifier_init(vdev, &vdev->intx.interrupt, "intx-interrupt", 0,
                             errp)) {
@@ -370,7 +360,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 
 
     if (cpr_is_incoming()) {
-        if (!vfio_cpr_intx_enable_kvm(vdev, &err)) {
+        if (kvm_enabled() && !vfio_cpr_intx_enable_kvm(vdev, &err)) {
             warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         }
         goto skip_signaling;
@@ -383,7 +373,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
-    if (!vfio_intx_enable_kvm(vdev, &err)) {
+    if (kvm_enabled() && !vfio_intx_enable_kvm(vdev, &err)) {
         warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
@@ -400,7 +390,9 @@ static void vfio_intx_disable(VFIOPCIDevice *vdev)
     int fd;
 
     timer_del(vdev->intx.mmap_timer);
-    vfio_intx_disable_kvm(vdev);
+    if (kvm_enabled()) {
+        vfio_intx_disable_kvm(vdev);
+    }
     vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     vdev->intx.pending = false;
     pci_irq_deassert(pdev);
-- 
2.47.3


