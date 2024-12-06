Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0ECE7717D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXRM-0005x0-DT; Fri, 06 Dec 2024 07:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXRF-0005wZ-QX
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:07 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXRE-00041Y-38
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:05 -0500
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-7fd23d9160dso930705a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 04:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733488083; x=1734092883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCr1Si5UmdcLC4IV56KLZI508jQrygzNhxY3gT6chl4=;
 b=mFXTnM3/MwT1HzpLG45V1C/ta/b6UGDKoBqqSEya11Owl7dfr42HEeB6wIQgFDJqEu
 KEtONb+VqlDwwIm4/K4fcEZ6A//hwKzqEI+wr8dwNKIvZmZBRJYefnVd9crzSY/C2S5t
 lDcuMxnsOryZqJF3jsAtlX5Mg9lWKEsxoEwTEsBpNYxq2QtuoBJqT5L+ThOmW7kDJI1r
 VSpva2zun6I/fcZSoFk4WJVv1Fk574un3hF9OMfyk12IZC/qa4/lMOG/Mha+ph0D8Y3v
 m15RMZZnOuJPgpZjQcPCqrVuQS59kEwum7ziAaFdUZVOK4EGKcSQ9a6NhZqQQIQc8LT7
 aUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733488083; x=1734092883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCr1Si5UmdcLC4IV56KLZI508jQrygzNhxY3gT6chl4=;
 b=SQ3uNieA+2dTIW7DggA26fsxiXhFOAKkZ9jaMRgx0XzyOAwCGUsSoiH/xaSxM4Ea23
 JXoo0DwiUnnmwKiTlDw2F3RJgPDuqoYP/DVbxO0XpHBi7nNCDRXu2FY1vNT61B3HWZzU
 JfGSOXIAw/D0zqfwtXPaUzObTMKBZIRlYCogcW4D1T2E5HNzjL2w6ZaXYbVMXEtR0TGY
 JTWIyL9eFZ1WaA4t7RjCddeOoLEJ/Ua54F6RPPRlo/RCnEUhZbLcTofPMRAURV1W8PEI
 Gn98tEsr1rUR93aoembPi5ViLaruUw/q07OEcX5A0d45Yus+HyWualH4GJ/mQmcUPend
 K4Pw==
X-Gm-Message-State: AOJu0YwqgWZ3iRy/Ux+UdTkF+kO2nDYgj3IPq4DNI4kRrGlKMlg+97Iq
 KIABqKGu8Z+OJvMP2qDfwXKXh4v23xOPA19DrHLK7biohdlEIG0=
X-Gm-Gg: ASbGnctfpFsZd6Mghjx8hemoNQNyTCuo8BuKr1CLV+Xfdr0OYlFDFK6RlQBfi4xAlBV
 agOjLfoAGv0eV5B108pvdee16hJ+7CjRUtZoh3zUdLs8uKEAPI8EeBt3MU+/ni8gzaB9q+6w2HE
 /LVTwHqQPacheOBP5e22kmciPOps0xdSEHzZGDPruwL4vXauf8QifDzz+mjibssbd4yiy6b4HuT
 8DOPXqFlqeLr8cwoKxKv9s0HfzdmW/TbccOAVwqS/B4qfkOG12IJ2w8nA==
X-Google-Smtp-Source: AGHT+IGZ/H8CQLg0JG+d4G+cGZgkcqsDPjr7UG3EqVLXEihxm4XSJquwabTpAOYvJIQ30SVdp/GkkQ==
X-Received: by 2002:a05:6a21:99a2:b0:1e0:de01:4407 with SMTP id
 adf61e73a8af0-1e18713703cmr5172849637.37.1733488082773; 
 Fri, 06 Dec 2024 04:28:02 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd15710123sm2579866a12.49.2024.12.06.04.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 04:28:02 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v4 03/10] vfio/igd: align generation with i915 kernel driver
Date: Fri,  6 Dec 2024 20:27:41 +0800
Message-ID: <20241206122749.9893-4-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206122749.9893-1-tomitamoeko@gmail.com>
References: <20241206122749.9893-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pg1-x542.google.com
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

Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 059ed56439..09bd4e5383 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -59,33 +59,34 @@
  */
 static int igd_gen(VFIOPCIDevice *vdev)
 {
-    if ((vdev->device_id & 0xfff) == 0xa84) {
-        return 8; /* Broxton */
+    /*
+     * Device IDs for Broxton/Apollo Lake are 0x0a84, 0x1a84, 0x1a85, 0x5a84
+     * and 0x5a85, match bit 11:1 here
+     * Prefix 0x0a is taken by Haswell, this rule should be matched first.
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
 
@@ -258,7 +259,7 @@ static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
 
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
     ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen > 6 && ggms != 0) {
+    if (gen >= 8 && ggms != 0) {
         ggms = 1 << ggms;
     }
 
@@ -668,7 +669,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
     /* Determine the size of stolen memory needed for GTT */
     ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen > 6 && ggms_mb != 0) {
+    if (gen >= 8 && ggms_mb != 0) {
         ggms_mb = 1 << ggms_mb;
     }
 
-- 
2.45.2


