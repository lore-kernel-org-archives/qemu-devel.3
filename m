Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD1CC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 22:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x991G-0004Kz-Td; Tue, 22 Sep 2026 18:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x991D-0004KD-R0
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 18:31:19 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x991C-0004Ll-7i
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 18:31:19 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a99391ffb2so586220a12.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 15:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20251104.gappssmtp.com; s=20251104; t=1790116276; x=1790721076;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E/yrKJCjDuZmSSLOO6Exn3E8pLS/glsRsFU41Fc4t+A=;
 b=zhCjAtaqcuTB1jGND/9afQCav8sUwXxfZ4lVOhfYFWDOxW2vps9hesNls0JHwREWxj
 hPV3GJ2EeOBHTOBhokD+UiEXhGn/LCWydZQblBZ3Zvke5SR4X5B/H8jCsVyfCz3+Rfov
 u+LMLzl72+AtnmDtSwAJxXY/H5YdrS6c+KNQKru6hVOymbFPU0cuklPO5k+4dM2SLIco
 MKCz/xXalkyWpUaZZTiQgUt7MfrcIUVZHqdD8OPimEEhopv8VlX3z/+b3TMDSE4m9ziG
 drpHFQBrFuTB2L3sXGety+TZefiXaIpCfiFX7B5zNsiFU9Fz4PCDGpSMESlT83wrsC7Z
 hoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790116276; x=1790721076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E/yrKJCjDuZmSSLOO6Exn3E8pLS/glsRsFU41Fc4t+A=;
 b=1K3nP3pHDiw/VQLtGcynCgGbzbG2gqW5l6zYSUizdrgE2O5ElDFTZx1gHeWRmLrKVG
 saTWKbjTCQJMZ2Y1c/U4MTbUar6g1ckQU830xLVZGilRMZEYbPsRtA42NvajaKfweqHh
 VwZrtTh2fbnhidVwS08lVfzQ28ZL1s8OF4SFzOQcf0fHci/spMGJbpDIKIRv63lSsprw
 vMhWo0Sdxi4Qgr2cICBbILEG8s5jWOoiplKGqVxSVyr6Hv/l+UgUz8moAhxS64O/Gw1H
 y0AAJccOE8PlX8D+hiTIGlXvxLShv7ZU/H1c4WemKvbZsFXadaSpTTEPdy0wl5G2I6TK
 dg0A==
X-Gm-Message-State: AFuF++kmze0uNR2nk6YBH4EdtWtJo+bhbKuJ0XePPK+Kg3n1zWLpW9w9
 9YDPURMTw3d/vHHTywaV5WXjqs6yFg3a+28YnB9epIe4nUYo/ibS+4Pt6n2uBQv31hh/WaKDjmr
 gNAW7wUI=
X-Gm-Gg: AYBFou14H6pAopxgSpcAJCfBw01quhCIDDgilCG+0MHxxfhQQsueGa3J7njEq7O74f0
 T2rAeWUS/fHBsAzqmfTJwzKxBedotd2p6aXuM7hA8t2j0Y9MWAaLjj1FoMhJ2+N5JXovvE9zg9t
 mksdKHfG6Vi4nANOYLRAqI3AEJOUBHHMFeRqvu97Y0FPFU8YNr+lDG3DBXYgC8bFmmxqczofDoP
 bu4t1OoyVIdXArzGSLdp1TsBgZHz0Vgy2PjXp6vfNhv9ZxOVp2IVM574HXmukHO0g3PnL3XATeK
 WvR3NvbXdnLZprUpF8nfAVLdwKrJCa5HqZQUUPyMRDX2OZsLRxyrZfI2akwxoh9VLaQO7idu6m1
 KFLwUTRMfxWJJ26cUWV4CC+imeANobgkt49E0xOtD/IMjLC+kZX5QCWu8kLvC3n94EKFapOqBOP
 4PiNFh6l3MFZwJvh6y7l0o9CW0TSGsd2e6IunNt2x3zABSFVy3f39PRxQKi0Eq4OSCzC7fYRvOI
 5N/TmN0K9EoQQsRf3M9VVlat+Bh6UloIWvur4juGypZWPZraTEYxwMq3WB1FxCTZ2A9SjLuGbRv
 oJ/Zpx6h0yU=
X-Received: by 2002:a05:6402:278e:b0:6a7:ee55:dccd with SMTP id
 4fb4d7f45d1cf-6aab3b419ddmr563992a12.28.1790116276345; 
 Tue, 22 Sep 2026 15:31:16 -0700 (PDT)
Received: from node-dev.home
 (86-45-19-184-dynamic.agg1.roc.bbh-prp.eircom.net. [86.45.19.184])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aab3883151sm411663a12.14.2026.09.22.15.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 15:31:15 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, mst@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 jasowangio@gmail.com, pbonzini@redhat.com, farosas@suse.de,
 lvivier@redhat.com
Subject: [PATCH v2 1/6] pci: Add device ID for CnuasNIC
Date: Tue, 22 Sep 2026 22:30:40 +0000
Message-ID: <20260922223045.190062-2-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922223045.190062-1-weqaar.janjua@packetfive.com>
References: <20260922223045.190062-1-weqaar.janjua@packetfive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:33::10;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-ed2-x10.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Reserve device ID 0015 for the Cnuas virtual network adapter.

Signed-off-by: Weqaar Janjua <weqaar.janjua@packetfive.com>
---
 docs/specs/pci-ids.rst | 2 ++
 include/hw/pci/pci.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index 261b0f359f..3f3825bfe5 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -100,6 +100,8 @@ PCI devices (other than virtio):
   PCI UFS device (``-device ufs``)
 1b36:0014
   PCI RISC-V IOMMU device
+1b36:0015
+  Cnuas virtual RDMA network adapter (:doc:`cnuas-vnic`)
 
 All these devices are documented in :doc:`index`.
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f2448e941a..51b3f83514 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -121,6 +121,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_ACPI_ERST   0x0012
 #define PCI_DEVICE_ID_REDHAT_UFS         0x0013
 #define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
+#define PCI_DEVICE_ID_REDHAT_CNUASNIC    0x0015
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
-- 
2.43.0


