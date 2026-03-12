Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A57106ACEE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 22:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0omE-00073d-Sv; Thu, 12 Mar 2026 18:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0omC-000722-Pk
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:45:09 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0omA-0003Fk-LF
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:45:08 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c7384f5a9cdso638864a12.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 15:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773355505; x=1773960305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P+J15QbmDP1KfgvN4Sy0sZRg5hAEYSJNvq7qy4iGGvU=;
 b=bnPU9frdZttKIm03606NlHT1EKwxAGellDhtJm8L/eDeXyaHFzWmvi10D85fS0ajGD
 ikchukvUqQVOj/air5JZF8kr6+2YxK2vL5GOWfqQ6XsfWpAYJDm0Qt3Jc23BXN9BC/6x
 gtX+ZzpUytTfI9RzJwrv4NkXBBoymkKcUWSCv3F+XbXGpTytDDPKCi9SUZ6V2YZbskgi
 GWPqMW4mF46mXNiNf53XNOLa41cMZUUJkDeuGlPo9pTBuoL0+ECgwgwZb4HAqnyJXemW
 vjGowXXGIRvO/Q3Qgy/MWKiZCh0T7aMr6b35Ae9aIVf+eiwbhPB4NUksASBkro7Be/p4
 PmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773355505; x=1773960305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P+J15QbmDP1KfgvN4Sy0sZRg5hAEYSJNvq7qy4iGGvU=;
 b=c8KQ6Qku1PgzwtU2vDg887BBkpCDB4dSmvVplIoIATAASVUlC3d3GVXyUI2fedmYEC
 t1/X2aEVXfJaJd+eS0AqMd+vJF70vOt/X1UTA65eslEoMKW2EC0nQQ9+6l7VyrqTFaR1
 Rrgf7IxNAonLoBvkZ8IPMzBkCt4Ahu0ZcBeFdX4TVspKsdVWC8EVSJhgRMAo0TNVdfV5
 39wi98eRuXZa7C/RNMyQaMLSWrLt5TohjqBMlP1XATly+k6I/CPhDSnHdb10zQNjCzf8
 Q/gHEqDbz7yV1jKY/noy+lu1rXCT6YINWcCys22mA4Ah4Xv4tBjIH6RP8l2KYOJn0ZpM
 9Tmw==
X-Gm-Message-State: AOJu0YwoD1J+PCizTkJqTawHQZ9UMxxsE5j9XW9Yv/G8XHt9XhAk3Gvh
 Apkdhqd1pvJn/WUjw9wLufflSAWx+srDSVquWtzIVfwBSqZEI3sozKlD1esJ/8BW6on8a2MTH6j
 6A+mJgI0=
X-Gm-Gg: ATEYQzyLZikoBNEkq4xIwEIv6FcRpyHDRKkl3uNURa77IpzEfndmW0JrXa5LgTGzG5d
 k7SkWrxb73/tIYXjM/rokATxLBNc2XP9AyNFd0hmwIZVbxuuCG7loP70LjkYbWqaFkcNDuqGZyc
 eN3E9BNQUH0Bycz1e6Aoakt+nrqhDcGQiAvve/34kORlf1EnI4KielVw+Vuu+dzdlp32/kfIZVk
 jMLljT3aTGSOy4ZBUPSiNC8B4zXXrHj/yljMMXf01lbAE6iofX5rtvuge1BJfkoihUz3xQXH6oy
 LRGQXxmZtu0n5smZunCRfVg5JRiRDYUrV+dULp2C8gzwgW5nDTpktiVd6wZs4xWD/vHl9+V79HF
 5SxySxQU0dRr6EoUzM0ezconIEXke4FHp2WI+FMUPlwJOejIvhQTovpx5oN8T5eV3aKFEsrDFZv
 pR07lY4zBnV37JGVlX27tgGDkfIzEV+tafAJ7KQxMNjqP4L7tbiFiDlLMQ9RUsgjBK2f8rcl4uh
 GpY
X-Received: by 2002:a17:903:3910:b0:2ae:cb0e:fd74 with SMTP id
 d9443c01a7336-2aecb0f020fmr8415865ad.24.1773355505045; 
 Thu, 12 Mar 2026 15:45:05 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece7ed9cdsm128215ad.60.2026.03.12.15.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 15:45:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 5/8] hw/vfio/pci.c: eradicate CONFIG_KVM
Date: Thu, 12 Mar 2026 15:44:46 -0700
Message-ID: <20260312224449.1605071-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

We just need to add kvm_enabled() guard on concerned functions, but no
need to extract those kvm functions since they are not using any kvm
specific types that would not be visible at compilation time.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/pci.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index df617f1fe46..62c52407cf9 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -152,7 +152,10 @@ void vfio_pci_intx_eoi(VFIODevice *vbasedev)
 
 static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 {
-#ifdef CONFIG_KVM
+    if (!kvm_enabled()) {
+        return true;
+    }
+
     PCIDevice *pdev = PCI_DEVICE(vdev);
     int irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
 
@@ -206,14 +209,14 @@ fail:
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
+    if (!kvm_enabled()) {
+        return true;
+    }
+
     if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
         vdev->intx.route.mode != PCI_INTX_ENABLED ||
         !kvm_resamplefds_enabled()) {
@@ -236,14 +239,14 @@ static bool vfio_cpr_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
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
+    if (!kvm_enabled()) {
+        return;
+    }
+
     PCIDevice *pdev = PCI_DEVICE(vdev);
 
     if (!vdev->intx.kvm_accel) {
@@ -277,7 +280,6 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
     vfio_device_irq_unmask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 
     trace_vfio_intx_disable_kvm(vdev->vbasedev.name);
-#endif
 }
 
 static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
@@ -350,16 +352,14 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
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
-- 
2.47.3


