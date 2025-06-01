Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DDAC5B549
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkYt-00022G-43; Sun, 01 Jun 2025 11:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYl-0001wg-Nn
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYj-0004aX-Fw
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZDSsFEzywjh9OxEWL6pzAyxwPIhej9RWGxAoQQErVX4=;
 b=JUN+F2XAwRKYQOB/orSUOxUpN6pSQ2o3ElMpcdO6Q04XCYr+ky0Tn9077UFCj4TcmFj6bk
 6QeDqelb/jg0SyIvHyUcJcPgHqTWdIDonI+9O5Xmzze1DbLY63WS+PXuqwGUC45B0b0noc
 BzZ+6xVNscu+LxzuTEdT3Az9rHEEB6M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-7LNTfkrtM52UkWzxQr8vmw-1; Sun, 01 Jun 2025 11:25:08 -0400
X-MC-Unique: 7LNTfkrtM52UkWzxQr8vmw-1
X-Mimecast-MFC-AGG-ID: 7LNTfkrtM52UkWzxQr8vmw_1748791507
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f6ff23ccso1563856f8f.2
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791506; x=1749396306;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDSsFEzywjh9OxEWL6pzAyxwPIhej9RWGxAoQQErVX4=;
 b=ZLewJDudA/jzWHzHhNQPTrjq3tXC84NnXhq5Q7SgNfVn4J1RXAIt/wqAMAiVN/su7a
 t3AcLuUtHdz0zOHiG0uEAJvzXnIOyWrUsfIcmjeuUv3p4ioif8D+paBE3tucUcIwbBQk
 ajyRLpt/3kMp3K8uX5+McUptsudL3Y32vlLz48heyDmnhLFYO0xhj2W8bJSUvYKRYn/h
 c88/HWT/Is9yAimvJU3zdgIzuZZpVWqjTpJuqQdFEokMpFs0DPSky+TtpyX8Nh4dAO63
 hgWABMp3TJ13wiIjAAW7xeDKkPG+CVl2pR5hXK/qFuNe9QzK4Yp8XKKOteHUx/WslKPy
 VlfA==
X-Gm-Message-State: AOJu0Yy7ckAYERDYtOB8ijGo8sT0+/Mfi9dcHOy2sd0SYIQgX6qfdQJb
 ZRYN7ACwCWXEGMsJvE9/BYZObiii8hw5UKpYrX/x1FluiWm4Uk+fpW+WWeDPIfPrrfZJ5x/+7Xb
 o3AJC2RzqLxtnNf27BgS56fERnTMDAeXoQi3FRfXEtaNi6wzWwnzClt0NeswbxstiL3bgdO6CKc
 mZrsIiJJKHQcEP3kNSqVj45rcvh3wJUoytgw==
X-Gm-Gg: ASbGncsBwqjJ6Nplq4Cau1OS3DiFexMsWxKzfBrsHl6OblhE92JlHa0S/oYwTNnc5BX
 3QZYcW2GoiVlSLDJX63O4spp0OWSn2+dA6IE62UVbw6+hB+PleFq7kQNMR0IU6t+BD/6sAOpwUD
 G7KJO684aFRFMDjaqrf3D8slbXeKfIVeQup0qdQnQ7/GfauiwwuOdvhpSwrV7o/vCczA5Y4BoGe
 qRF79DgP38Jmvm7PgxsRlRntj6ZdcbDw7+gHTHsfIKs90bCl7qyjJUhjzx+B4zzp6ftSGLhCyNG
 FQb+Lg==
X-Received: by 2002:a5d:64ed:0:b0:3a4:f51c:21a9 with SMTP id
 ffacd0b85a97d-3a4f7ab12a5mr7889761f8f.52.1748791506209; 
 Sun, 01 Jun 2025 08:25:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAcjJF6g+byLvSoBtxBrabkU4aCLTkZrOdWxEpTUostWIklT4x+FbaGhGkGDryG3QKZYa0Vg==
X-Received: by 2002:a5d:64ed:0:b0:3a4:f51c:21a9 with SMTP id
 ffacd0b85a97d-3a4f7ab12a5mr7889741f8f.52.1748791505822; 
 Sun, 01 Jun 2025 08:25:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8013e0esm87687235e9.39.2025.06.01.08.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:05 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 08/31] pcie: Helper functions to check to check if PRI is
 enabled
Message-ID: <5be8cf79188a2a1c73d16f3a8b458d909ac976f4.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

pri_enabled can be used to check whether the capability is present and
enabled on a PCIe device

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250520071823.764266-6-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie.h | 1 +
 hw/pci/pcie.c         | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 17f06cd5d6..ff6ce08e13 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -158,6 +158,7 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
 void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_pr_cap,
                    bool prg_response_pasid_req);
 
+bool pcie_pri_enabled(const PCIDevice *dev);
 bool pcie_pasid_enabled(const PCIDevice *dev);
 bool pcie_ats_enabled(const PCIDevice *dev);
 #endif /* QEMU_PCIE_H */
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 542172b3fa..eaeb68894e 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1266,6 +1266,15 @@ void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_pr_cap,
     dev->exp.pri_cap = offset;
 }
 
+bool pcie_pri_enabled(const PCIDevice *dev)
+{
+    if (!pci_is_express(dev) || !dev->exp.pri_cap) {
+        return false;
+    }
+    return (pci_get_word(dev->config + dev->exp.pri_cap + PCI_PRI_CTRL) &
+                PCI_PRI_CTRL_ENABLE) != 0;
+}
+
 bool pcie_pasid_enabled(const PCIDevice *dev)
 {
     if (!pci_is_express(dev) || !dev->exp.pasid_cap) {
-- 
MST


