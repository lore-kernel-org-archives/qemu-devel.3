Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2820BC47422
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 07:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSXuF-0003Hm-UV; Wed, 24 Jan 2024 02:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSXuE-0003GN-O0
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:42:42 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSXuB-00036Y-KI
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:42:41 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40ec3535225so9915065e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 23:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706082158; x=1706686958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0LfIs7wXUaYUULeAS3e2X+WCSShQ2MUHLfcscfH09+U=;
 b=KstOr1mM/om7HpQqrQLv3E7C7UndAaqdgdSjTa52NS9BvdN7gGADsqwsZ9KEMBFga7
 CD7aepBaKcypBH+Hl+beamcqFqu/zq4+4/naBTKZsLLiJZtLAdte1fW9q8/YB7YfpPkS
 0xFdHv3aDzjicZhYLDxZ79pULdEGqKYEeLDk+zZo5Wl04/fG2WhDEjrAZMUuR7ofsRxU
 +WvW3W0JuHJSYNRhMup95j9gjQ166VpyzFpLg3CbFPaWX4oO1PvmgCmfnT4TDzH1mokv
 8OH/ff/eLXYkPt8MLv03QLHboN4vS+S8Vmw8wVOO/4fTqd2fwqrCNPnREr60Nb2CzCoF
 u3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706082158; x=1706686958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0LfIs7wXUaYUULeAS3e2X+WCSShQ2MUHLfcscfH09+U=;
 b=KUc1buV/s5d0rG/g90WqhSYC1Zcz0CK/kBzGoGktq4pLeZ4VLJjVuMeoVUim7CDCzu
 TFmnUmcVw49xYVe52JIGaSN/S0PWLNXhW84QH3Kz3Vfes/jjpqhzadqHLVIDpJrQEFJe
 HPGInf7fYBiGJLjZtBRepidYxUBADsaMw4iCJdsnOcH86U5KL0FYjyHVlKhbNXM58mmC
 TPTdxcl2Zr2+fUeoq7r3Yc7PHaa7vIT4MbaTD8OxSsY7fub0KsSdOWq7lzK9xJ5DF2cJ
 09c+uRNuVOXYXK2nxJLkmcsGyev1/4h7Dxb4h28DZFhqLxkWixD48D88uBRAz1W/0VrM
 qNCg==
X-Gm-Message-State: AOJu0YyjuvWkU5mBDlhmDhxhHAqQFuUJjxpKs/YZ5z4wMF1QHKnH5UGC
 xZYY4ExufaCogXzOe8fzrlclZH1V2PZhrb6MtIABSJJ7h2uxbEtv08l6qeQ0P0/VY1r2ex3YpWf
 X
X-Google-Smtp-Source: AGHT+IHamU2WFi5iMAKXcInpPdC+7yZesGDEwbvijPxIIogJ8VyWAuds54XbX8F6cwkHpI2gofe2Ng==
X-Received: by 2002:a05:600c:5207:b0:40e:7e40:10c6 with SMTP id
 fb7-20020a05600c520700b0040e7e4010c6mr679976wmb.182.1706082158086; 
 Tue, 23 Jan 2024 23:42:38 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 c8-20020a05600c0a4800b0040e4746d80fsm44902735wmq.19.2024.01.23.23.42.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 23:42:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/6] hw/vfio/common: Use RCU_READ macros
Date: Wed, 24 Jan 2024 08:42:00 +0100
Message-ID: <20240124074201.8239-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124074201.8239-1-philmd@linaro.org>
References: <20240124074201.8239-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Replace the manual rcu_read_(un)lock calls by the
*RCU_READ_LOCK_GUARD macros (See commit ef46ae67ba
"docs/style: call out the use of GUARD macros").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/common.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 4aa86f563c..09878a3603 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -308,13 +308,13 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
         return;
     }
 
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
 
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
         if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
-            goto out;
+            return;
         }
         /*
          * vaddr is only valid until rcu_read_unlock(). But after
@@ -343,8 +343,6 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
             vfio_set_migration_error(ret);
         }
     }
-out:
-    rcu_read_unlock();
 }
 
 static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
@@ -1223,23 +1221,23 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if (iotlb->target_as != &address_space_memory) {
         error_report("Wrong target AS \"%s\", only system memory is allowed",
                      iotlb->target_as->name ? iotlb->target_as->name : "none");
-        goto out;
-    }
-
-    rcu_read_lock();
-    if (vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
-        ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
-                                    translated_addr);
-        if (ret) {
-            error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
-                         "0x%"HWADDR_PRIx") = %d (%s)",
-                         bcontainer, iova, iotlb->addr_mask + 1, ret,
-                         strerror(-ret));
+    } else {
+        WITH_RCU_READ_LOCK_GUARD() {
+            if (vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
+                ret = vfio_get_dirty_bitmap(bcontainer, iova,
+                                            iotlb->addr_mask + 1,
+                                            translated_addr);
+                if (ret) {
+                    error_report("vfio_iommu_map_dirty_notify(%p,"
+                                 " 0x%"HWADDR_PRIx
+                                 ", 0x%"HWADDR_PRIx") = %d (%s)",
+                                 bcontainer, iova, iotlb->addr_mask + 1, ret,
+                                 strerror(-ret));
+                }
+            }
         }
     }
-    rcu_read_unlock();
 
-out:
     if (ret) {
         vfio_set_migration_error(ret);
     }
-- 
2.41.0


