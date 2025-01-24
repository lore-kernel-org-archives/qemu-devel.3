Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AA8C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 19:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbP7A-0006jx-Rk; Fri, 24 Jan 2025 14:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tbP78-0006jX-Mc
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 14:13:10 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tbP76-0007pn-Ty
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 14:13:10 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-21675fd60feso56260865ad.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 11:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737745987; x=1738350787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/rreBwOJjOLgAVavOMfVYZVMv6rRdXnJTWZ6kk51L4c=;
 b=nOoiz80ZCELhqkDqqtSnIZO1TOMrzvIqalPhFD2g6vB/ArwQpULjvxH6n0zUiBxJSL
 WbgpChrNrV5EscMzEqBrc6hs6vs9p+vtQpyTgIt0BIItj3adWEQtbDsfu1VFG3HBHPzc
 fPafVXXoxbF9ztGkgh9ypRKtjUjN8s0VwyhpMGwlPMlN8sPkFTkeApVnBr8zO8UGy8RS
 xKRIc473F3+rQGNAVrhV7t6DKx5ZUwvRoYrTVhHx8FAHQ46q2bVf1FRQHJRyvP8YBtN+
 FZhwl4RIBI6xLnHDh8n96sQbPe/FywKMda/HFm0Lr3N4R4ufSIwwGg16o5GpUpMI5oxV
 af6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737745987; x=1738350787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/rreBwOJjOLgAVavOMfVYZVMv6rRdXnJTWZ6kk51L4c=;
 b=J/WeAZMzCPe6VgrHfQOjxjZZ2i3d9Cno3rIGFkS9XfsoOMKT4JfmQg7q6a9n8A5WJq
 wdJAmzlBHFdF513KhTXRKfBd+Fns4dOjfIJh1C+XN3DWOaQbOZPWiQYQsF9HAuhNlCDY
 YJJq8ofhMgIxCgwhISWIVmrnPWj2P4hCfITMo1Q6KFJ1/2AxvQmhPNizkJhUDY6/OGpP
 a48WxpMvJdzu/tAmqVbjkGPTBPCr8k33F+X2nja+ELE4h/9vlnpK64JfnBkYc6tYC84M
 OGg/q89BHp1RkCbS6NlKYzMGtjf84CbKsXT9SihSLiWH5uta9/SilNm1VeurjenPgW5x
 aryA==
X-Gm-Message-State: AOJu0YwmwqpwHBTjJ9fEGlQz2EYz0ZVQVPFEIet/FokI+an9Xy8lC/L0
 q7Fn44A6aNHY95Ii5mT1HtGRpufysP2Zy36Zh1ZLZyvgjRqx3Kc=
X-Gm-Gg: ASbGncvGtDF4AZ4Rra6kRZtE0sYkQUnRPuIgcA/R+WDNzTCZWLeraQ/Xy6LD2XBSvEG
 NLU0qM+0BehO1A5fVh9cDLUFFkDxsNqLQuFcVboKU55KBklon0Sadrz64bfvlho4eYzwYHWDfh+
 Zs3F+1jJNMtOa818/fhZMy2Lq8Q3XD+bSHYvRhwzQ8fI6AZP8/qgC8swu3ZhuMNpnsyyEnxuG89
 jTz7fblXIJNcl4hX0e++6d4bKraXokumC/j9x7h3s+uYuT78DWTZh4da+PFgUmJTLthzkwMPINe
 vp3c8zJIfhE2TFHlOQ==
X-Google-Smtp-Source: AGHT+IG2QG0ppyJFwFtEoP7v+MeXi57vim1EtYYkMoNF3OfkKS1j8vwdbl1ECY+3odZy26AWJq7kfw==
X-Received: by 2002:a05:6a20:8429:b0:1e1:e2d9:7f0a with SMTP id
 adf61e73a8af0-1eb2156f917mr59811442637.34.1737745987468; 
 Fri, 24 Jan 2025 11:13:07 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.151])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a69eb75sm2318406b3a.12.2025.01.24.11.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 11:13:07 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 4/5] vfio/igd: do not include GTT stolen size in
 etc/igd-bdsm-size
Date: Sat, 25 Jan 2025 03:12:44 +0800
Message-ID: <20250124191245.12464-5-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250124191245.12464-1-tomitamoeko@gmail.com>
References: <20250124191245.12464-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
what both SeaBIOS[1] and OVMF does now.

[1] https://gitlab.com/qemu-project/seabios/-/blob/1.12-stable/src/fw/pciinit.c#L319-332

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 376a26fbae..6e06dd774a 100644
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
@@ -368,7 +348,7 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
     g_autofree struct vfio_region_info *lpc = NULL;
     PCIDevice *lpc_bridge;
     int ret, gen;
-    uint64_t ggms_size, gms_size;
+    uint64_t gms_size;
     uint64_t *bdsm_size;
     uint32_t gmch;
     Error *err = NULL;
@@ -528,7 +508,6 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
         }
     }
 
-    ggms_size = igd_gtt_memory_size(gen, gmch);
     gms_size = igd_stolen_memory_size(gen, gmch);
 
     /*
@@ -540,7 +519,7 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
      * config offset 0x5C.
      */
     bdsm_size = g_malloc(sizeof(*bdsm_size));
-    *bdsm_size = cpu_to_le64(ggms_size + gms_size);
+    *bdsm_size = cpu_to_le64(gms_size);
     fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
                     bdsm_size, sizeof(*bdsm_size));
 
@@ -560,8 +539,7 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
         pci_set_quad(vdev->emulated_config_bits + IGD_BDSM_GEN11, ~0);
     }
 
-    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name,
-                                    (ggms_size + gms_size) / MiB);
+    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, (gms_size / MiB));
 
     return true;
 }
-- 
2.45.2


