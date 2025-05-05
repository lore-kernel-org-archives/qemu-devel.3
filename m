Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFECAC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 17:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBzEY-0005RY-9o; Mon, 05 May 2025 13:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzE8-0005JB-Vo
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:37 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzE6-0003ZO-EG
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:36 -0400
Received: by mail-pg1-x544.google.com with SMTP id
 41be03b00d2f7-af579e46b5dso3118507a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 10:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746464613; x=1747069413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xvzD+hKZ5iB1XZ0subi7aM6hNe8/NYN2Y8J3TcC1UM=;
 b=Y1bRPFTRwuy6QeSq+lOCDBwRXW4rNfFJsT6Us+ZERi8LFzIg1DUN21LPoOYCd4rghU
 rdROJDISw/9TsMtbXZZw2BpvgWdSdP+vqw0zMOTVXU1psCrPHA3LkFWZpckij03qr+9U
 qPVmUGGcqQf/TcBkHhsA/0yoC3U0krfsnllA108EpLTvXl9PGMPW0dL1kcjV+0vlYp9p
 wZXoGf8JJvH1zBXEN9VslODMJ7yJVLLcDZjMGr0TDIUh4RBn5d6BrG+UBh6mRbBY0x/w
 pnmvHS/sk68nYrldo7WHS/k8OLLWLG4AmAdEOJa65taxdpqhiN4dfdFPNfLRCIqQHFzC
 qLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746464613; x=1747069413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xvzD+hKZ5iB1XZ0subi7aM6hNe8/NYN2Y8J3TcC1UM=;
 b=e95CCknK02zm18Fqnhp4xwKyTsXQhHQuZZNOLtwO6IRXugiIshcP3PK4XTL7rE7iKm
 jAkOe+oe0DazYZiDsDTW+sikfEoTjIihmIrsCSg9mfLogMyHeHYWPSuYRP+P7R7SXZZq
 matH2lZaQgtaO6R7AZvJeAhmEQKMv8j6NxujM5uZz09XNfDP2EUYX/hPaN/DBnWMlAQT
 i8UvoH+nOPUsEpyeQ3Y5YYHcUOuASl4Wr/0bxsXyOipBNqxlDVd9UpuMt3j+sIEQghbc
 xknyeFKAPcz4SfYdFknOEtw073vEmQNqgZSo17N8lO26UTIN5f7f/czQboPsRDbp5RJu
 Cbuw==
X-Gm-Message-State: AOJu0Yz9K6wltdis0fnqDeJOQlByoLXJHJiQ3p4HuvklI9jlFiGTFtEK
 hYMRqA5rpVReWKbRmxIps3bJn2VI7MAUgetmZQjtsz6n6kG5vSs=
X-Gm-Gg: ASbGnct+LHtLWNaSOA1WbT2G+Q4fGbY1hkhvO22RhlCuUj4TbuocNfV+FGYg0yFbPsA
 e2bZuetxTgvUcuK9n/kWimTV+8b/wttrXUDX4vEcSFBvaclLilxPPBOIvoqsIO/HXVDhN2cuCEv
 t4M5K2elsd3CXDKpI31dLcIft5RPAIYOW+EY/tWSozAKhI2U3pmMsUML73PvdhfUFpfw1drvVyM
 2R7Drc78r8yHfs+xUFixQQtJgds3sRlJXnM1GIQ9usSI9CzO7N9rfwyoUQJgZiYvZr4lrvkf6rg
 ZGiS/gMaKadj29VfxsO8b+s+hYzVas+dS1Kc1UIeezRdiuuEPm+UHxcZ
X-Google-Smtp-Source: AGHT+IGkl99tcbtV/fZKiQX7C0vpnhFv1VQI0UrQdweoHF1Q2UGUOMA7xsG8ZKMVpbk7v1jKsy1Y5w==
X-Received: by 2002:a17:90b:6c4:b0:305:2d68:8d55 with SMTP id
 98e67ed59e1d1-30a6197c0bemr12975820a91.8.1746464612785; 
 Mon, 05 May 2025 10:03:32 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.131])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e9e9dsm57335135ad.83.2025.05.05.10.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 10:03:32 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH v3 5/9] vfio/igd: Check OpRegion support on GVT-g mdev
Date: Tue,  6 May 2025 01:03:01 +0800
Message-ID: <20250505170305.23622-6-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505170305.23622-1-tomitamoeko@gmail.com>
References: <20250505170305.23622-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pg1-x544.google.com
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

The Intel GVT-g backend `kvmgt` always emulates OpRegion for vGPU,
make sure the OpRegion is present for enabling access to it
automatically later.

Also, hotplugging GVT-g vGPU is now always disallowed regardless of
OpRegion to prevent potential issues. Intel has never claimed support
for GVT-g hotplugging.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index f5dd475028..9dec32818c 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -685,9 +685,13 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         return true;
     }
 
+    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
+        /* Should never reach here, KVMGT always emulates OpRegion */
+        return false;
+    }
+
     if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
-        (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp) ||
-         !vfio_pci_igd_opregion_init(vdev, opregion, errp))) {
+        !vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
         return false;
     }
 
-- 
2.47.2


