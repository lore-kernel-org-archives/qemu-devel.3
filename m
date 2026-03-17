Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A3AFEDA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2aJj-0007Vl-QR; Tue, 17 Mar 2026 15:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aJc-0007Qo-Hz
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:42:57 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aJX-0007Ch-PZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:42:56 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3590042fa8eso25466a91.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773776569; x=1774381369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WdPki2OUDvv7GbdAB4TVVTocQqYHi/i0OX7XXacQtPQ=;
 b=PrpiCexZiOl4dIP4j1hn9oWmhgRKfeU3JgaEZuU3OD6TyKEADeTO34/xJtM/vJg4hY
 Zf4XfDgQ1nBDpSeVPCxuurB1NBmFZLp4T7xhMTlRx7D16nvpnaLYohY0t/fiSkH5fHpk
 L+ctQSieUO0XmC5urIU7YqNrF67KGK5HtfNhNWXND1uYef96ap7L8HJ+tspIBxqI4FpW
 snEBeJzMcNrxJ3ROB/roIrgOjL07dQ5YJpxBYIcXZNYXx5K8aPDD9q9JDnjCNeczbOnG
 ROgY8302Me2PkDuDNoqUITZSwK6nrzWKFhnzszoqY76Ipbsa+KO1T1fovfQEFmtkyU0K
 wwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773776569; x=1774381369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WdPki2OUDvv7GbdAB4TVVTocQqYHi/i0OX7XXacQtPQ=;
 b=Zs/PVvdEVFGOGQvvLMTadtr9xyyO1lDVFY7Ee+mZDQPT65y+0iKjctiDzRTYfMtBgo
 sei+THUGwKMXYQFsRyQlW6xm1FPYTapqUdxRv1Xc25qBcgsgC5tBQbQlpuak2fiLkYMQ
 A1N6jrKTxlHGoc2u/54Bgni8/FTcwENxAivv9P1RTXcKkxtFe1X/CT1UQp5X3NYw3mFE
 mPUpkHAJ8AYwSrne+6qQSGSIQwMUUBkjSe7XgtmyGAaDUZOMxacLyksWP1r9wuirrCOL
 w5TH1Vt9ich1JBAf0pDbU/5wfqHJt0skuU+I4SOELASGa7QdzSf4sbK09lx9ltwPqCsO
 1lDg==
X-Gm-Message-State: AOJu0YwT3wvWKKv1PpPaYjcCr8IrjFm1x6HOL2GhpHcUNrslsqd6/lRi
 1pJZD5SOhsrRj9cb8i4SPi6AEkrAYhLvzctICgBWolV9qYxbZCnliYAh9M49j7pPPsnyje4AaYk
 s1QSyWrc=
X-Gm-Gg: ATEYQzwsY71Ut8WRJwqY4iWthEOCkAgIubTh2IdRnC/6pzMBB6U4fkQZgnND553D0EQ
 G3SpTcqJfADJ75e6LLdMq17UV2y3ghZA56nyzpyTm/KrhMY4xAdVpQZ4giCDjLNctMcKuOmcYZA
 AONFS/lb5g06zFLEynDZ80arW7su3Ohb1nbOI81HTJVuVD1jw8GHZRIe9pRxRbTjE15THBX3JzL
 l0TVmehD6CgUPkN1r8qSbByoD5E7XrViEAeZYnzQqdLSI3DF3+0TgE+xYrPGfjem2pybnyTfXS/
 2P//v5XRqmJGwKqcywgMozIOpvKTS3Kzzn6VkhMYGn+mdlb2jlmyW0nJhX+dA3yPBkPU/IqraBj
 /TxzmAVasqi6bAtPs9PJrPf8D879cZZiz07DfDKVR6UnMlP6MYu3ZNNElBwvERh5tv7EYKNaMW8
 h6PT2HdRCBZWiXDN1QrPFct+gte6oUKxQG5ODpTvX/iC7QRQ4l0YtXl3wWOH2TyzdmafNGWVNYs
 TqbsIVqmuVZXuo=
X-Received: by 2002:a17:90b:390b:b0:35b:947d:9fca with SMTP id
 98e67ed59e1d1-35bb9f2fbc8mr464598a91.19.1773776569339; 
 Tue, 17 Mar 2026 12:42:49 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bba5b8606sm239907a91.14.2026.03.17.12.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 12:42:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org
Subject: [PATCH v4 5/8] hw/vfio/pci.c: eradicate CONFIG_KVM
Date: Tue, 17 Mar 2026 12:42:38 -0700
Message-ID: <20260317194241.869568-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
References: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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


