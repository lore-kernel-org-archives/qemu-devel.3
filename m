Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93ADC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSHn-0008FL-A8; Mon, 14 Jul 2025 19:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGj-0004CM-O7
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGh-0005XW-OI
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uhGqUwTLjS2ARoAcmn4Djkgcyrtq4txVik2vc56G05k=;
 b=cJTwncFh601yLWTZGET6bb3k0LJX47g8g33XAAZ6Z+ilvkIC+h53wFJb1q5U7oYj7aQCbq
 j5uW/KHsCCAK/qhkyxRinBW36gMoO7peniSuOqR37nx32+gbk0R3MgkBL5F+PQ85YugFlA
 cEc0J00I/SpgR6xNH5W8PSoXPIPhQD0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-KVjk3MX0Ntqf1OhhiI6OHA-1; Mon, 14 Jul 2025 19:07:30 -0400
X-MC-Unique: KVjk3MX0Ntqf1OhhiI6OHA-1
X-Mimecast-MFC-AGG-ID: KVjk3MX0Ntqf1OhhiI6OHA_1752534449
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45626e0d3e1so1101335e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534448; x=1753139248;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uhGqUwTLjS2ARoAcmn4Djkgcyrtq4txVik2vc56G05k=;
 b=TWbddBdMMh+6KEv0BQxKWrQLMvOAYg5IW0oR0hVtWjCWfCL8BGeeuLBFk0k9NjFrHD
 KjzgVED+tsk8V1fcHdumPWjF6Anwa6s7T+t+z5ORE3foQRWYGexdiYBV5ExH/DNAV/qa
 dqQ8S0pppuiWhNPql4qqV2O8CoOGYu7JRQl3qjOah4k6fcf9j8jP8e/OKjhIoQr61+VJ
 EzPpgTMkIXKCNnqb4yPu6SunkTQtmSRKVUrzwT2/gVqMG2U6Zf0ebtMTvoQpKPpL1I/Q
 jfJA+6+MiF/mZ2xXs3URwMoodgJ9te1fKmArtpFFvD6x44TTm1hKldtlJ61L/s/gcZ+U
 dMwQ==
X-Gm-Message-State: AOJu0Yw8N9mo8u60Q82xbMMqhFDlK3dQJfQ18hqLNjyFVu3oPwytk/G8
 NkfRd4mAJB5iJFJ90/F6+QHwO/l1t8UZtzF8xQxLOlvRFRPyrnU0T7HFz9p/ggSTF4if3hS4zjU
 Tlhyelwn84idTkpyy58BQPFQZ97Xhc/zPdPnTBdjrkUq6595TX22QzJiaDgMa7RVWYi84Vq6HEI
 uUyMA8RAFbwfgpTBlLaxCeXiX+38mZuY0OIA==
X-Gm-Gg: ASbGncsWTUEqRoF0F2l3CuNYN7YaV3UYIV0gZIS2KhpoQa7gJp/D+21xc5hBjS+21Bx
 8mscbvK0i4TvRKojuWbTMIIVdATHBKVMoE8GuB55gyom4zwegQkhGAOLHexIT6h78vzgKKxmsnO
 Xv9WZlgSnGqsw45loyGSTB/p+7nalNdoELf0TLa5zA4JEfYheLQZ0ocscmiuw4haJJ83bdg5/sp
 oupNaNzcogWlnT1YeB/XwDnxzb0hRoxFIioiV1nmu90Q2gx+Wr35hEWRgENUGsWs5vJnjbqXYmo
 ue/bJLOLt5Ya9ju4hkT18vas475QqZ82
X-Received: by 2002:a05:6000:41fa:b0:3b2:fe84:a10 with SMTP id
 ffacd0b85a97d-3b5f181c283mr13773558f8f.0.1752534448436; 
 Mon, 14 Jul 2025 16:07:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ/M/8T5iJmS75P7VdxU06uufMVT8mkEnTxNK8jVZlna9ATE0cbVNsGVnyjGz94oN5NDa69g==
X-Received: by 2002:a05:6000:41fa:b0:3b2:fe84:a10 with SMTP id
 ffacd0b85a97d-3b5f181c283mr13773535f8f.0.1752534447991; 
 Mon, 14 Jul 2025 16:07:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45626c9ac1dsm3528435e9.0.2025.07.14.16.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:27 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 29/97] pci: Add a memory attribute for pre-translated DMA
 operations
Message-ID: <2dd51fc52a8b85e6f39d1297f338344ed03dc5b1.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

The address_type bit will be set to PCI_AT_TRANSLATED by devices that
use cached addresses obtained via ATS.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250628180226.133285-2-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/memattrs.h | 3 +++
 include/hw/pci/pci.h    | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 8db1d30464..52ee955249 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -54,6 +54,9 @@ typedef struct MemTxAttrs {
      */
     unsigned int pid:8;
 
+    /* PCI - IOMMU operations, see PCIAddressType */
+    unsigned int address_type:1;
+
     /*
      * Bus masters which don't specify any attributes will get this
      * (via the MEMTXATTRS_UNSPECIFIED constant), so that we can
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index df3cc7b875..6b7d3ac8a3 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -134,6 +134,15 @@ struct PCIHostDeviceAddress {
     unsigned int function;
 };
 
+/*
+ * Represents the Address Type (AT) field in a PCI request,
+ * see MemTxAttrs.address_type
+ */
+typedef enum PCIAddressType {
+    PCI_AT_UNTRANSLATED = 0, /* Default when no attribute is set */
+    PCI_AT_TRANSLATED = 1,
+} PCIAddressType;
+
 typedef void PCIConfigWriteFunc(PCIDevice *pci_dev,
                                 uint32_t address, uint32_t data, int len);
 typedef uint32_t PCIConfigReadFunc(PCIDevice *pci_dev,
-- 
MST


