Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133FCC0218E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 17:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taeMW-0004Q3-Df; Wed, 22 Jan 2025 12:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1taeMU-0004PT-IH
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 12:17:54 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1taeMR-0008GL-QW
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 12:17:53 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso129762035ad.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 09:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737566270; x=1738171070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hpBzjRP7lcZnfFl2TlBZJg+t978qeJXz0xSVkKJdZmw=;
 b=Y2p8BzKWmg+plYzzdFAmCl/M1qUb0/T2KLTWNx/ExFo881pPQZG8N4GWAyJnnbJiKI
 JQ8q7/RxeqXRt0jfMobjIF8wSdrV4pSjnj65NZvgcYCiF806xoDnSXL6FNNLTusP5FQm
 bj1Q5uYmVyJ7R/sG2ImKAXx+LvHUN97tcax30Al0+ySEnfHhldYrYjjpV4/nZGtOUMU9
 XgtBWNro2zEQFhYjafTM1y14kIfzTap9g1uuUOqM8vX25An9ZrU/BzfG3JPyXJBy9Wyx
 KkRMv9df4jdkIaVocEhkjXEhxULrhq1gdJ0QXce8QULQmIhv/h57SkdQTz2auVwLapEA
 23mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737566270; x=1738171070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hpBzjRP7lcZnfFl2TlBZJg+t978qeJXz0xSVkKJdZmw=;
 b=o6Z5XDjW1DVXkFHE08vAPFNNRIle01SO06mF7yWXbcvdtYB6XPx3uBabkfd7+pKNLT
 4tEEdFG961fCUOe5hKj/ZaU8Byvro0dbt0gGjm8RTV2zZMzqtblntpJRgni8A5lonLKG
 Gq6WJxkVgxFiVG/OI7T3/YxjRZSFtQrJ0q/3B8azvSxILbSGFmkLDGJVj4er3B24uoqI
 GHyh1GwarKXgMRDLo/C/nbxAJWOiOP1CXhWNBpd8bOiuR6yQZm124kXiNKywWopOC/iv
 olH6nf1fYzrFM0N2pL7BYXqa8AIhLjhiuQZ+60hMU1vyfal4H+u2rL1Jap7/QIr7UjpF
 vNDA==
X-Gm-Message-State: AOJu0Ywi8n0jBQwXZ1YAZ2hifkNLzvWNV6v4W+0Kc/8VZJ6hjA97Uf1s
 eT76HtCbzs+0xlRVC0OTlJXVupOB63by+y/xQG2VBt5KlOzUREo=
X-Gm-Gg: ASbGncuCoxGPsITrF0DNG9XuyDyOqOuLmwnH0KJoGxJwSreh8uDYbxmbloP/5I6FdpA
 955ObWCcGW1FYV0weyW8HQamTVL8soFlxpFK8i0IYiaB3RhWwSZ5CuGd80MubYYEmRalqc5yzMu
 ZytDMADGWkDurIgNa5MvYqb2PRC5q5tAY1tNyntdeKBXSDeVBFS6aqBmjk2F1lUsEPcaWbO7LqP
 zeRxRxHnhOSDibgFuNRvoUn642TlfI9PTaeb/F7lpUtigayXVMKrRJtPbizBGpGJ9bKHMM5iH/j
 /sztUCY=
X-Google-Smtp-Source: AGHT+IFFNh8JyQ9UOrSO1cm7CZek4UNnycK/4CObBYm/X4ADhxnUGrJ0ubYZe8v8LlbpNw3+SWPfTA==
X-Received: by 2002:a05:6a20:6a04:b0:1e1:ab51:f531 with SMTP id
 adf61e73a8af0-1eb214de774mr37279690637.22.1737566270432; 
 Wed, 22 Jan 2025 09:17:50 -0800 (PST)
Received: from localhost.localdomain ([58.38.120.217])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72daba48eb8sm11597818b3a.136.2025.01.22.09.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:17:50 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 2/4] vfio/pci: add placeholder for device-specific config
 space quirks
Date: Thu, 23 Jan 2025 01:17:29 +0800
Message-ID: <20250122171731.40444-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250122171731.40444-1-tomitamoeko@gmail.com>
References: <20250122171731.40444-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x642.google.com
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

Some devices, such as IGD, require device-specific quirks to be applied
to their pci config spaces. Currently, these quirks are either part of
BAR quirk, or being a part of vfio_realize(). Add a placeholder for pci
config quirks for moving the quirks to one place later.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/pci-quirks.c | 5 +++++
 hw/vfio/pci.c        | 4 ++++
 hw/vfio/pci.h        | 1 +
 3 files changed, 10 insertions(+)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index fbe43b0a79..c40e3ca88f 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1167,6 +1167,11 @@ bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
 /*
  * Common quirk probe entry points.
  */
+bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp)
+{
+    return true;
+}
+
 void vfio_vga_quirk_setup(VFIOPCIDevice *vdev)
 {
     vfio_vga_probe_ati_3c3_quirk(vdev);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ab17a98ee5..e624ae56c4 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3124,6 +3124,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto out_unset_idev;
     }
 
+    if (!vfio_config_quirk_setup(vdev, errp)) {
+        goto out_unset_idev;
+    }
+
     if (vdev->vga) {
         vfio_vga_quirk_setup(vdev);
     }
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 43c166680a..5359e94f18 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -205,6 +205,7 @@ uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
 void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
 
 bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev);
+bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp);
 void vfio_vga_quirk_setup(VFIOPCIDevice *vdev);
 void vfio_vga_quirk_exit(VFIOPCIDevice *vdev);
 void vfio_vga_quirk_finalize(VFIOPCIDevice *vdev);
-- 
2.45.2


