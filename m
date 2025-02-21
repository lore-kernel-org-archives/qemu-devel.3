Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7F4C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS3Q-0004Xz-Ub; Fri, 21 Feb 2025 07:22:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3I-0004Pw-E3
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:22:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3G-0006zZ-F2
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2kxcyww6qI/yOi6ipYazJfpY4N/lEp2Wmj/5+d4jfT0=;
 b=VXCxPDY2rD84uDwG9z9r3fkdxNgiMORBaF4KysjDScv2GLsUgs1sHZQz9vtE3H8o1nQzKK
 FHW3W/EeSGTkT8TbhQVjUGSDkUNqmjyDM9+5S1+/GS3HQnoa7HebYYxbQidaKjGhgGAcZi
 ZcrXOROHUsUbwY9e/RBmxz+tAhGIR5w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-P_j2QwBLNd2MmVZXMN59Rw-1; Fri, 21 Feb 2025 07:22:40 -0500
X-MC-Unique: P_j2QwBLNd2MmVZXMN59Rw-1
X-Mimecast-MFC-AGG-ID: P_j2QwBLNd2MmVZXMN59Rw_1740140559
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4399a5afcb3so18577605e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140559; x=1740745359;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2kxcyww6qI/yOi6ipYazJfpY4N/lEp2Wmj/5+d4jfT0=;
 b=rQZ+wA3ZFoklUTF6g51Lff3+j2ixtePsWVH9Pe1Q3wj0+BovV848DRA6Z8CFyB616+
 g9Zm17gDaFic/5k7vURgRu9Ns3c0Mv32ywCUT39YKy+8s+eBhaO0vOxc/Qnm5lVHlSLY
 Z4HXTATgnuwrYGiOxfCRzFh8Ff4gqt1SexwwY9ou/USkx8pVNfUiwC8FHOsGxp3NpT1A
 X5JZ753vvgSCk8jtUev2uNATWynnJooyrozG3gkzpJLyLWWWo+5ucN6dfE5E15WL+foQ
 3nXtzhFheW22tCwXZkQwDV6v/IgNMGmDZjC1Pnzspe6iCqZMqkBBXL5DOWmMXyx3rOxx
 9oww==
X-Gm-Message-State: AOJu0YyDwKr9dUX65lyLKkxc9yKa7IZx8Tg56MBJfL34AvV21QLwIN4U
 D79/8p6CjepG26bAmHD9bsS2qBZQHuSmrVp6JhSxTBKv8biw8jcTm1NkaBLSm+nWOmGg012IXzj
 GATKVFOhFnz7h11QFfgaa6QzH9MJfhNWmCRwFG12/pehpoepaet1V0NTFQIooHRZhNZvG/0GegF
 aBhiGBJA6deA76CBgZX41B933oNlx0xw==
X-Gm-Gg: ASbGnct2EWq7cg14ywmXv3V14UF8kG7aF8q1DdiopO0yVDU0bf1Nfuls33Ig4TL47A7
 GNgZp9rtznqgS8WaXBXt1CFkhy+3I5bw7p+mKj2e2UR/BHcvWbI9/mcI7Qw7XPvLQdr13HOtF8f
 LehEhPv2d4kl6m+BoKIj1dkAxOgR8nJNOL4DEyDRm/h+lTJtkh5C2aU90H8T6J//6Z6F0TYsp87
 +B96R4J/zgusqFf2FpUliFCcZHck0HgtDFuo763KsopavZwHw9Jzj4S1/ULdp11M+yd7U8W3sQr
 hB6bOA==
X-Received: by 2002:a05:600c:3107:b0:439:98ca:e39b with SMTP id
 5b1f17b1804b1-439ae21e4bbmr26685075e9.29.1740140558725; 
 Fri, 21 Feb 2025 04:22:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEN4YcJ9vKJa+eo1RGTH1NKKhEOeELWzpnWtdqCEJZ5+b9iJ2ykD60ZMRSsOBSq1sy22GS2Zg==
X-Received: by 2002:a05:600c:3107:b0:439:98ca:e39b with SMTP id
 5b1f17b1804b1-439ae21e4bbmr26684715e9.29.1740140558292; 
 Fri, 21 Feb 2025 04:22:38 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b0371db0sm15456915e9.37.2025.02.21.04.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:22:37 -0800 (PST)
Date: Fri, 21 Feb 2025 07:22:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PULL 03/41] hw/ppc/spapr_pci: Do not create DT for disabled PCI
 device
Message-ID: <5731b005246297ab5b91975f52fcd525e08507cd.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Disabled means it is a disabled SR-IOV VF and hidden from the guest.
Do not create DT when starting the system and also keep the disabled PCI
device not linked to DRC, which generates DT in case of hotplug.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Shivaprasad G Bhat<sbhat@linux.ibm.com>
Tested-by: Shivaprasad G Bhat<sbhat@linux.ibm.com>
Message-Id: <20250116-reuse-v20-1-7cb370606368@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/ppc/spapr_pci.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 904227d9aa..b94e4ba131 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1283,8 +1283,7 @@ static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
     PciWalkFdt *p = opaque;
     int err;
 
-    if (p->err) {
-        /* Something's already broken, don't keep going */
+    if (p->err || !pdev->enabled) {
         return;
     }
 
@@ -1572,6 +1571,14 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
     SpaprDrc *drc = drc_from_dev(phb, pdev);
     uint32_t slotnr = PCI_SLOT(pdev->devfn);
 
+    /*
+     * If DR or the PCI device is disabled we don't need to do anything
+     * in the case of hotplug or coldplug callbacks.
+     */
+    if (!pdev->enabled) {
+        return;
+    }
+
     g_assert(drc);
 
     if (IS_PCI_BRIDGE(plugged_dev)) {
@@ -1647,6 +1654,11 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
     SpaprDrc *drc = drc_from_dev(phb, pdev);
 
     g_assert(drc);
+
+    if (!drc->dev) {
+        return;
+    }
+
     g_assert(drc->dev == plugged_dev);
 
     if (!spapr_drc_unplug_requested(drc)) {
-- 
MST


