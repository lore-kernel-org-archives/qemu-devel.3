Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1528C28B24
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 18:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqFXp-00038L-T4; Thu, 06 Mar 2025 13:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tqFXh-00034A-N1
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:01:57 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tqFXW-00006r-A0
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:01:56 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-22356471820so16975305ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 10:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741284102; x=1741888902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+f6msq+IO8zcZ2KQoBk0f5EVnSPIFuiTsc8ZvnAkAZY=;
 b=b2W98BmpTog2aMKgK2UzPnw7UL0SWkOF/Yb0DwL8RP4mneyVfrTVAGFSJKrKrMid/m
 yYMGkP6rtP3eAp0BBcaZhvj0WRawx6vz1GYBXMxsC21b3vpebqYY8g2BUMOlMdo+NsVq
 bDNxkrGUceBiwl41JJ2wqMtAGCiJMjAIcMUBvOVUr6fl6oPFkDtq5AFPm4YRTs5/m5ET
 CMiC3HE608oYhMVzU0/9CFq9fJrp6lciJo32uAWQvvK1D3RvQDL7/PKYS8ghs3hOru4a
 +llHkoFQVweTTNoujVoXa6Q90JlbJ3kIY3lc9+TJPyH5dU3pAKfyuWTFDyJLyu/V1Lne
 FM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741284102; x=1741888902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+f6msq+IO8zcZ2KQoBk0f5EVnSPIFuiTsc8ZvnAkAZY=;
 b=kDOAdqfE8XkIOwDuv90rQPX4Q5ZEJbCYMzHZYsQxEFNUxzbGp3GfcyLclOZFaG2izO
 mlk31bKy45tIChqBGlXREuJ2JuovYB6zx/z/01I+pWL5Dk5ytS5N+LmGo3qJXk6YHRXe
 8a7iTcz7cXkkWsM7LVOcH3PyheL8HmRWBBIWmbF0fonKRXqBBUO+TCboSG6/u4Di6+Hc
 kFK9vcpYtmTCeleUPDDZ576VhuF/yv6JzylEc9pJWqkkx++289+GebDOyoDQXkzaH8G1
 AntaM5E3/ofQNiB3tyTy7si7nPs6gYCrI0gmgyoZ+OKUkBKj5gXkrvgoGbgofpUiAhuu
 /PfA==
X-Gm-Message-State: AOJu0Yx2p7ZVWtMcQsXgD6QvzhJ/tNfvy5aaZG5lrBP4XHI+icR6FbaI
 LbEPiEYAucW0G79DalcerrkgkjWQxrLSFe9vx19ztNkKVBnSuR8=
X-Gm-Gg: ASbGncvktFHgjNRCb6dvs4EOIUdxOyUtSr/U2P6LF5mNVbDUd2IQnvlRII+8PslaS9W
 mz5oABI5c4IBiF8ydNMU57cX9OvxMFhwM+0ePR+4n9k/8eroDdeqIV4hrD8n9QgUrIa78qrm2iH
 CfmRKnkoemv9sfmsUHdNYcc+//6as6ivwQgV0I1IEm0pIkWyWz0puziw/lwvzDMMPiBNN2PvVA4
 MNTqa8EAitXvIBie2fQeZ2x9qTrSHjpl1H4S4npHUgiZR1AngKdP5MIwA+G5mZpuStdzbhFIlX0
 BPdTY6h8mVJAXvbFtKZguwl6ig1yPWFSBgsQ6OFKWqtMnl+JuYvxM94LpA==
X-Google-Smtp-Source: AGHT+IEF+K3Ss1wzguIkGbbzV6KvhQNA3A5wDK09fZJGks8dteeIUbSV4VOfimtJPmuKpfG8LKbo0A==
X-Received: by 2002:a05:6a20:7fa7:b0:1f3:4427:74ae with SMTP id
 adf61e73a8af0-1f544b18642mr829183637.25.1741284102463; 
 Thu, 06 Mar 2025 10:01:42 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28126db9bsm1338498a12.58.2025.03.06.10.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 10:01:41 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 02/10] vfio/igd: Do not include GTT stolen size in
 etc/igd-bdsm-size
Date: Fri,  7 Mar 2025 02:01:22 +0800
Message-ID: <20250306180131.32970-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250306180131.32970-1-tomitamoeko@gmail.com>
References: <20250306180131.32970-1-tomitamoeko@gmail.com>
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

Though GTT Stolen Memory (GSM) is right below Data Stolen Memory (DSM)
in host address space, direct access to GSM is prohibited, and it is
not mapped to guest address space. Both host and guest accesses GSM
indirectly through the second half of MMIO BAR0 (GTTMMADR).

Guest firmware only need to reserve a memory region for DSM and program
the BDSM register with the base address of that region, that's actually
what both SeaBIOS[1] and IgdAssignmentDxe does now.

[1] https://gitlab.com/qemu-project/seabios/-/blob/1.12-stable/src/fw/pciinit.c#L319-332

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index ca3a32f4f2..dda4c7bb5d 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -112,28 +112,8 @@ static int igd_gen(VFIOPCIDevice *vdev)
 
 #define IGD_GMCH_GEN6_GMS_SHIFT     3       /* SNB_GMCH in i915 */
 #define IGD_GMCH_GEN6_GMS_MASK      0x1f
-#define IGD_GMCH_GEN6_GGMS_SHIFT    8
-#define IGD_GMCH_GEN6_GGMS_MASK     0x3
 #define IGD_GMCH_GEN8_GMS_SHIFT     8       /* BDW_GMCH in i915 */
 #define IGD_GMCH_GEN8_GMS_MASK      0xff
-#define IGD_GMCH_GEN8_GGMS_SHIFT    6
-#define IGD_GMCH_GEN8_GGMS_MASK     0x3
-
-static uint64_t igd_gtt_memory_size(int gen, uint16_t gmch)
-{
-    uint64_t ggms;
-
-    if (gen < 8) {
-        ggms = (gmch >> IGD_GMCH_GEN6_GGMS_SHIFT) & IGD_GMCH_GEN6_GGMS_MASK;
-    } else {
-        ggms = (gmch >> IGD_GMCH_GEN8_GGMS_SHIFT) & IGD_GMCH_GEN8_GGMS_MASK;
-        if (ggms != 0) {
-            ggms = 1ULL << ggms;
-        }
-    }
-
-    return ggms * MiB;
-}
 
 static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
 {
@@ -367,7 +347,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     g_autofree struct vfio_region_info *lpc = NULL;
     PCIDevice *lpc_bridge;
     int ret, gen;
-    uint64_t ggms_size, gms_size;
+    uint64_t gms_size;
     uint64_t *bdsm_size;
     uint32_t gmch;
     Error *err = NULL;
@@ -527,7 +507,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         }
     }
 
-    ggms_size = igd_gtt_memory_size(gen, gmch);
     gms_size = igd_stolen_memory_size(gen, gmch);
 
     /*
@@ -539,7 +518,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
      * config offset 0x5C.
      */
     bdsm_size = g_malloc(sizeof(*bdsm_size));
-    *bdsm_size = cpu_to_le64(ggms_size + gms_size);
+    *bdsm_size = cpu_to_le64(gms_size);
     fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
                     bdsm_size, sizeof(*bdsm_size));
 
@@ -559,6 +538,5 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         pci_set_quad(vdev->emulated_config_bits + IGD_BDSM_GEN11, ~0);
     }
 
-    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name,
-                                    (ggms_size + gms_size) / MiB);
+    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, (gms_size / MiB));
 }
-- 
2.47.2


