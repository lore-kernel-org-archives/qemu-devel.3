Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6EAC021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 18:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdM7-0001LD-VE; Mon, 24 Feb 2025 13:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdDO-0005nN-Ow
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:30:04 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdDK-0003Ps-NL
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:30:01 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-220e6028214so103493215ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 10:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740421797; x=1741026597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WWgHd6CvjQ8lpt36ZQ5+z6WnJSuOnamZfqpjigbR5uo=;
 b=LN6SVlpLk8d02jkd5FbkZk+srclQ8UHqSZgl3poZa8NLUz7HaZx/B89ftR7jCQnAw0
 j7NiPj6IlXp6xn6kG5ukMmnlbvEQq39KfQi9K0V4cMWMT1ypIUUtIlCiXh++S649h0+I
 OHLwk8bzwfwzEl60nIrukLrjHdSvzj2YKSBEp9geKLJ+OlKmax0zGgKluDGf/w5NOlaI
 ry9MLFATwW2Nq8xhqUymbIII9q1+uiIT/ZMGNSaoXxPq4iyPk1ARKSuwxJeRP6uqe2TC
 swWT4065/Jma4T8O8PquGrL4/w/5tSfcXXDotAoSZf9ZvFOYklemmfgipI3HInhETCU9
 gfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740421797; x=1741026597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WWgHd6CvjQ8lpt36ZQ5+z6WnJSuOnamZfqpjigbR5uo=;
 b=ES9BFOQlZIr0+FGGOxhG3c4JLceBoQkHOgaNZTQQe7q6U1oWo5p4YsY4dBzjr3c2Q1
 hS95WXjIshAciPysmJYRRyBXfJj9w7NDqxZzkbh7d3tMdpzTU2oDUFUVh4f6Ml/BPk9H
 7gOG+4SJzDBLJh4tnjnmMCuDmRvDnUp9KIjukjXxwfnYGQMJf26p7ziroQ8V+sAE6MH7
 T+vfya2HNhtLRdwttPSDgLU7au+FoMkgnemuwfz1FIuwTnpcjVUBQOpd9KWRmGCNFW+1
 3pQsP6qRbXzgEVtu9HL501Ktd90fqB8BuL8SJUBHHLh4tmtK63Nb/q9LO5yFYJsUkbXS
 BILg==
X-Gm-Message-State: AOJu0YyE0lmwz5nebdqhFvbjN1/hZUEiOPQ8KzPC/MowNzH/BtKHJHjz
 CVG7UnjHQJQeZj59MZYPfdh0KUbf/4YOg4ShyDv7sJ9eoEG91Ms=
X-Gm-Gg: ASbGncuBw3wqVKbFZ587QJpZ2Iu4x/khdeSdfU31R0nzjjF2qhXnW4rOKXpIPdrobcc
 LIj5evbkCR2ILXoAQ8T/YLLGm04sCCpmUp9hXE6LmY9Wn8zd5B/vuwgfgnWIx4RTTBNc7FhQswk
 AAAfe0XjUdEgwfaU+0CJUw7J0l2dZuNTUddEaMj3+wYLJzGHlabiU1wukp4Ie4Z64vSaX98Pjyp
 oJLfaCCwQ83jgyNl0xrDlrfwJwfc6wfmatz/rUUfJr9iHkEgds22Kag5GeHueEvDTGjBZog8x8n
 zgGPNlsa2M2IQ/ThwJzKtzxmFviBqvjtT0jRbC0=
X-Google-Smtp-Source: AGHT+IH4teq3Pg6kGVeb/GrLxLEjGn2YP9U0A+s+E7AC0qYLT7+dnZXjipJFcLX8gtRMzpA93WYMbg==
X-Received: by 2002:a17:902:d484:b0:21f:164d:93fa with SMTP id
 d9443c01a7336-2219ff82783mr204766935ad.6.1740421796990; 
 Mon, 24 Feb 2025 10:29:56 -0800 (PST)
Received: from localhost.localdomain ([116.227.8.253])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545cf6bsm183662615ad.123.2025.02.24.10.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:29:56 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 09/10] vfio/igd: Refactor vfio_probe_igd_bar4_quirk into pci
 config quirk
Date: Tue, 25 Feb 2025 02:29:26 +0800
Message-ID: <20250224182927.31519-10-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250224182927.31519-1-tomitamoeko@gmail.com>
References: <20250224182927.31519-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
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

The actual IO BAR4 write quirk in vfio_probe_igd_bar4_quirk was removed
in previous change, leaving the function not matching its name, so move
it into the newly introduced vfio_config_quirk_setup. There is no
functional change in this commit.

For now, to align with current legacy mode behavior, it returns and
proceeds on error. Later it will fail on error after the removal of
legacy mode.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c        | 16 +++++++++-------
 hw/vfio/pci-quirks.c |  6 +++++-
 hw/vfio/pci.h        |  2 +-
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 17e731d7a0..1ed364b497 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -482,8 +482,8 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
 }
 
-
-void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
+bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
+                                 Error **errp G_GNUC_UNUSED)
 {
     int gen;
     uint64_t gms_size;
@@ -497,10 +497,10 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
      * PCI bus address.
      */
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev) || nr != 4 ||
+        !vfio_is_vga(vdev) ||
         &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
                                        0, PCI_DEVFN(0x2, 0))) {
-        return;
+        return true;
     }
 
     /*
@@ -512,21 +512,21 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (gen == -1) {
         error_report("IGD device %s is unsupported in legacy mode, "
                      "try SandyBridge or newer", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     /* Setup OpRegion access */
     if (!vfio_pci_igd_setup_opregion(vdev, &err)) {
         error_append_hint(&err, "IGD legacy mode disabled\n");
         error_report_err(err);
-        return;
+        return true;
     }
 
     /* Setup LPC bridge / Host bridge PCI IDs */
     if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
         error_append_hint(&err, "IGD legacy mode disabled\n");
         error_report_err(err);
-        return;
+        return true;
     }
 
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
@@ -588,4 +588,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     }
 
     trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, (gms_size / MiB));
+
+    return true;
 }
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 8a81c60400..f2b37910f0 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1119,6 +1119,11 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
  */
 bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp)
 {
+#ifdef CONFIG_VFIO_IGD
+    if (!vfio_probe_igd_config_quirk(vdev, errp)) {
+        return false;
+    }
+#endif
     return true;
 }
 
@@ -1170,7 +1175,6 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr)
     vfio_probe_rtl8168_bar2_quirk(vdev, nr);
 #ifdef CONFIG_VFIO_IGD
     vfio_probe_igd_bar0_quirk(vdev, nr);
-    vfio_probe_igd_bar4_quirk(vdev, nr);
 #endif
 }
 
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 5570f08f4f..6fe25c9701 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -217,7 +217,7 @@ bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
 void vfio_quirk_reset(VFIOPCIDevice *vdev);
 VFIOQuirk *vfio_quirk_alloc(int nr_mem);
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr);
-void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr);
+bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp);
 
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
 
-- 
2.47.2


