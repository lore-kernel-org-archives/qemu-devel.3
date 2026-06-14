Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0283ACD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqCf-00075n-5m; Sun, 14 Jun 2026 15:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCQ-0006uS-LB
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCP-0002MU-3s
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0j2TuSt5CDZksYraqgWgna1GGvtBvBsvP1dgCKoiTPU=;
 b=QH+JUuJ8s2vRJVmYQahO8voTl6fPF32+P7K1OEr4EPZ04m4JNrpoaMefzuHJ55GnncBkV8
 EEIvnKA3XblVloImrnj01auHyXdM0BISL6Sm928nmHSTe0yeSz/cMINpg+lcMM91FSnP0M
 ZdaXQpBJQukw35jm/zVDZ5nLelZH3uc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-2vNtkS8gPqWaCWkSpjEdZg-1; Sun, 14 Jun 2026 15:08:47 -0400
X-MC-Unique: 2vNtkS8gPqWaCWkSpjEdZg-1
X-Mimecast-MFC-AGG-ID: 2vNtkS8gPqWaCWkSpjEdZg_1781464126
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b3ec3f7fso15547455e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464126; x=1782068926; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0j2TuSt5CDZksYraqgWgna1GGvtBvBsvP1dgCKoiTPU=;
 b=VhMjbdPhGLP07j3OsA9Jbfa/Y1pkMBURI6QW5VXbIkD2EJnA9bGUjREytEUfQgAqcM
 oV+LhiMMzaCsxefguZu02fIC1RI469TZz4EYzFohBT27lsbcPB7toBgqiR1S7w0bVBqK
 vx16RnPXuYAVOq0KB3iT5DWhQGMgluz/jBYK0wn57ViqUVtoMstSThnN/achHZwwfjPh
 pWan/AOCZiAHTYldSqVWC28+zLoV3fSAwPzt80/P0i5+vd4m4Ha1mUyVqhTmSI70sNBx
 qbWozFdubk9TWeTYfUB3ro7LUM1w95PbrsKdzymuLOjGiCp/I4jpJD1TRTecOLSIGLev
 xrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464126; x=1782068926;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0j2TuSt5CDZksYraqgWgna1GGvtBvBsvP1dgCKoiTPU=;
 b=ekifoZ3JhJopy8qGAJxq9eFlDwfFkhDhgkWZEyYBFRTKhgKpO98hAC/v+a32FLjV62
 JqMYDdPrAOaC6TNoc3xp3v3tUKRwdfxGGZIlC32jYB3YNhsT6/jtwsLkPcXjsM4lUN7q
 cmW8sKXJHEdV1sx3jjxhDIwIAj6bKf6AsX7rA2lmK4Deli/0eeh8dX/sI7DTpnDelaAF
 LGa1MaX+2lOHwfv6NvHmLTNIL00NBIL7zD+T8SYxOSKOqPrNGXcFMjemel97TUz+rjZl
 iK4CBt9OmWeuoRWoR/4KcebGG33aRBVbq8ujB1S83T2MpN2Ny56sAo8w/H8izRAlmzKI
 tW3A==
X-Gm-Message-State: AOJu0YxzsNtkN2TJpJjenjjK3+ae3++YFdiT5F5uvZ+KMGBhROd6RXH0
 GZu/MJmLsy26QtyMugoHE//DEcK5ymm/WW3Phjb0RR+2X4mBEt6iZk9VUg/czPt4gSB9RDtx7CX
 GkU6l7MfRaXy5sNQo2DdinkdK8AQfos88TvSg44Gg2TUM+UEaWaOd5boBLy85rC2lyiI2RtfXXu
 VPHtN+J7WMFY1gF19H3NIFzxllbY/Yfnm3IA==
X-Gm-Gg: Acq92OFOf4lZrDHQ6fhV3g9WUcTjXVKsYIZsPoubeRSyqzLwAqZY89kvo5CfYUWs/5+
 2YcViReD1G8Pz7nyIdv7l99RKA9KEQDHEvGwKb++CwY44MWD5UE2rTJGz584AS6MV3EhF7YF+lN
 iPnHiG/gjpj+8c+R5+yrSSGjSOG6vn+Fsx69mOAGA2cxLbrI6wQ1nn8brHfI7hNDjfUxsp/g9uD
 VxfiMq4R80ZJtwxwbzLGxcRrn+/45n5i41z6AnOWnmEeEqPPSMGzMLg4BfZyK43oED5IOCsDkwr
 J5/5Sd4ema9+BQTl++WLgg8xZ0sbWIc/3MdqdUkyTOcJ3L75pehb4CCKfNsrG1vhpZmxxNnbhXM
 ttA1/o2KI3EODfVjeZ9840Ab8Tc832RSQHbcxABIDqow=
X-Received: by 2002:a05:600c:c4ab:b0:48f:f64c:c2fe with SMTP id
 5b1f17b1804b1-490ec4f8090mr159115655e9.22.1781464125907; 
 Sun, 14 Jun 2026 12:08:45 -0700 (PDT)
X-Received: by 2002:a05:600c:c4ab:b0:48f:f64c:c2fe with SMTP id
 5b1f17b1804b1-490ec4f8090mr159115255e9.22.1781464125313; 
 Sun, 14 Jun 2026 12:08:45 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4a399fsm186564165e9.0.2026.06.14.12.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:44 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexey Gerasimenko <x1917x@gmail.com>,
 Thierry Escande <thierry.escande@vates.tech>
Subject: [PULL 070/106] q35: Fix incorrect values for PCIEXBAR masks
Message-ID: <412c48d054b484a0f88d858dc554c24e07e94358.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexey Gerasimenko <x1917x@gmail.com>

There are two small issues in PCIEXBAR address mask handling:
- wrong bit positions for address mask bits (see PCIEXBAR description
  in Q35 datasheet)
- incorrect usage of 64ADR_MASK

Due to this, attempting to write a valid PCIEXBAR address may cause it
to shift to another address, causing memory layout corruption where
emulated MMIO regions may overlap real (passed through) MMIO ranges. Fix
this by providing correct values.

Fixes: df2d8b3ed4 ("q35: Introduce q35 pc based chipset emulator")
Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
Signed-off-by: Thierry Escande <thierry.escande@vates.tech>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260313164649.794591-4-thierry.escande@vates.tech>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-host/q35.c         | 6 +++---
 include/hw/pci-host/q35.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index e85e4227b3..7368e3c598 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -306,12 +306,12 @@ static void mch_update_pciexbar(MCHPCIState *mch)
         break;
     case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_128M:
         length = 128 * 1024 * 1024;
-        addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK |
-            MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK;
+        addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK;
         break;
     case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_64M:
         length = 64 * 1024 * 1024;
-        addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK;
+        addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK |
+            MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK;
         break;
     case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_RVD:
         qemu_log_mask(LOG_GUEST_ERROR, "Q35: Reserved PCIEXBAR LENGTH\n");
diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index ddafc3f2e3..f31a71010b 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -100,8 +100,8 @@ struct Q35PCIHost {
 #define MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT       0xb0000000
 #define MCH_HOST_BRIDGE_PCIEXBAR_MAX           (0x10000000) /* 256M */
 #define MCH_HOST_BRIDGE_PCIEXBAR_ADMSK         Q35_MASK(64, 35, 28)
-#define MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK      ((uint64_t)(1 << 26))
-#define MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK       ((uint64_t)(1 << 25))
+#define MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK      ((uint64_t)(1 << 27))
+#define MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK       ((uint64_t)(1 << 26))
 #define MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_MASK   ((uint64_t)(0x3 << 1))
 #define MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_256M   ((uint64_t)(0x0 << 1))
 #define MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_128M   ((uint64_t)(0x1 << 1))
-- 
MST


