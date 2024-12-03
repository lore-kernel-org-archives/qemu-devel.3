Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E57E64AA6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIT4b-00081O-J1; Tue, 03 Dec 2024 08:36:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4Z-00081D-SS
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:15 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4Y-0001GD-AQ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:15 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-215909152c5so21624295ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 05:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733232973; x=1733837773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3C9mQ0zqKyWU81Xua9U9FrEq7qcjZ+Cm0wPCJfJYfvI=;
 b=iaMFG3G1iZcbsrgmz5LNdZpIkFoLOm0/5Qyhsw0zonFMHC2ZKd7aYm0EqTxzumbLMb
 OoeQbqdPaROqOacJ6lp9wWRWMm2VBnaz0EU132XlkiEQUyRyFCFLe4J6n69DC5QVWctE
 9bwY3QYMqWbmfZ6oFmn86zuvzNex6wXwYs7+EmUidUXLJ6dQR+LqScdF3j9RHh4G7fNb
 H57FTSV1CQbUJhpNLrQbLvbTU65sT8YJVZQ7ceFvq1phL5EUKjlJefEYfO0xYi/XeHtl
 QY2Ju47WzgZLt5EVQZ4mV511VPSF1f+4eGlmODv5c6UMHXEiPddb2gk+OkByy+BCVbsj
 JcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733232973; x=1733837773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3C9mQ0zqKyWU81Xua9U9FrEq7qcjZ+Cm0wPCJfJYfvI=;
 b=HMC8vSTqnC7rzz1Oemxotu7T4ZNAyUB39qSvE223gqaRZdqZR4MSFey5sXlIpINniI
 s/QYTdshPpQUlVsBLdPDCJpCcBibd5tqduvm+qO2vShjsYlVjCnsNH9iky/DspmrkkGU
 PicnQrz0W0ZGr9g/FQ2DqdZ3bifDI6r/4fk1oJqoUj3eFPvfoxHH0k23u36/0lynao0G
 pLw2rB7zUoD7m0ewaC5RQO2qUc9MxiwIPv99OerWk8otoo3JELFrEqREcZmv55mJ2L2H
 9Yq7AnIWBqJYE5E6D42rKY/ijRueHbvLVnrJ4Q/7dxJ3IdOKtQObJ9NCF8asU2nlK9KO
 WHzA==
X-Gm-Message-State: AOJu0Yz8dcFBg4gIzVkPXwOsDpwPo2dOfXhEMXjbDxUrNgKdHWo9JLhx
 MXKxFx68EpN0mbmW4f8LzTfL5QmzCOJQbgEwb/xJ1lX3Vr1NgqMdiMu17+PGTg==
X-Gm-Gg: ASbGncs6boA2pF/NAtdTlt6TmQoFWuA340r9iVZ/0a8b0XYgmVP7IqQfNf3CCWtU0pU
 rzSU4Y7udL/QpwZ5SNhy1MuDtEvxPrrMo3/QNqsZJQTuX7LgpdooewQ5sO1h/L/6+MaiZMjTAKg
 xtlZrtuWxMAZf1FMF7aF+xjwfMxaLBiEU5gI9h+o3GA3zi3h8aniqfPxqn94Jno6+jjRWykCufb
 XuknT+nVi2hsumWk5rwL8POUXsDRRnbDx8/KkjCqzIMDEgG2zCL3+KKYkg=
X-Google-Smtp-Source: AGHT+IFzNrbbJ1dlMtfrKzVGEX6Y/ASTpr9pRVL8CXZLJU12ehycssWo+z1vGI/ZrB6H9aTGe6zL/A==
X-Received: by 2002:a17:902:ea07:b0:215:75a5:f72b with SMTP id
 d9443c01a7336-215bd266391mr31549235ad.53.1733232972631; 
 Tue, 03 Dec 2024 05:36:12 -0800 (PST)
Received: from kotori-desktop.lan ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215810cf18esm44183975ad.242.2024.12.03.05.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 05:36:12 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 2/9] vfio/igd: align generation with i915 kernel driver
Date: Tue,  3 Dec 2024 21:35:41 +0800
Message-ID: <20241203133548.38252-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203133548.38252-1-tomitamoeko@gmail.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
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

Define the igd device generations according to i915 kernel driver to
avoid confusion, and adjust comment placement to clearly reflect the
relationship between ids and devices.

The condition of how GTT stolen memory size is calculated is changed
accordingly as GGMS is in multiple of 2 starting from gen 8.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 6ba3045bf3..2ede72d243 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -59,33 +59,33 @@
  */
 static int igd_gen(VFIOPCIDevice *vdev)
 {
-    if ((vdev->device_id & 0xfff) == 0xa84) {
-        return 8; /* Broxton */
+    /*
+     * Device IDs for Broxton/Apollo Lake are 0x0a84, 0x1a84, 0x1a85, 0x5a84
+     * and 0x5a85
+     */
+    if ((vdev->device_id & 0xffe) == 0xa84) {
+        return 9;
     }
 
     switch (vdev->device_id & 0xff00) {
-    /* SandyBridge, IvyBridge, ValleyView, Haswell */
-    case 0x0100:
-    case 0x0400:
-    case 0x0a00:
-    case 0x0c00:
-    case 0x0d00:
-    case 0x0f00:
+    case 0x0100:    /* SandyBridge, IvyBridge */
         return 6;
-    /* BroadWell, CherryView, SkyLake, KabyLake */
-    case 0x1600:
-    case 0x1900:
-    case 0x2200:
-    case 0x5900:
+    case 0x0400:    /* Haswell */
+    case 0x0a00:    /* Haswell */
+    case 0x0c00:    /* Haswell */
+    case 0x0d00:    /* Haswell */
+    case 0x0f00:    /* Valleyview/Bay Trail */
+        return 7;
+    case 0x1600:    /* Broadwell */
+    case 0x2200:    /* Cherryview */
         return 8;
-    /* CoffeeLake */
-    case 0x3e00:
+    case 0x1900:    /* Skylake */
+    case 0x5900:    /* Kaby Lake */
+    case 0x3e00:    /* Coffee Lake */
         return 9;
-    /* ElkhartLake */
-    case 0x4500:
+    case 0x4500:    /* Elkhart Lake */
         return 11;
-    /* TigerLake */
-    case 0x9A00:
+    case 0x9A00:    /* Tiger Lake */
         return 12;
     }
 
@@ -258,7 +258,7 @@ static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
 
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
     ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen > 6) {
+    if (gen >= 8) {
         ggms = 1 << ggms;
     }
 
@@ -668,7 +668,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
     /* Determine the size of stolen memory needed for GTT */
     ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen > 6) {
+    if (gen >= 8) {
         ggms_mb = 1 << ggms_mb;
     }
 
-- 
2.45.2


