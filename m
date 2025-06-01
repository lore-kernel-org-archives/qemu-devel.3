Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D62C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkZM-0002i6-87; Sun, 01 Jun 2025 11:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZJ-0002YC-Mw
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZH-0004fS-SQ
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ds1bRuEkiJDFHQgBvKVW02NaDKRDGpXfpkGE2xqPN+s=;
 b=DK1igBdU8rAga6BM5/iE0ejHB9WoW5ZHBzwymsubudiLd7OUqRxYmW4lzAlBy34128S+Nk
 yalmivG/uC2OPEVS43X1SIwTTd5FRVQtB+umwP/xm6tYV6mukEBco0aeDYM2J/glMhobvD
 Lpsj8a6i2KtcuzM6ombgO05DPUdaN7Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-5oYnwjaiPvG-XYypH1OsLw-1; Sun, 01 Jun 2025 11:25:46 -0400
X-MC-Unique: 5oYnwjaiPvG-XYypH1OsLw-1
X-Mimecast-MFC-AGG-ID: 5oYnwjaiPvG-XYypH1OsLw_1748791545
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450cb902173so16116365e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791545; x=1749396345;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ds1bRuEkiJDFHQgBvKVW02NaDKRDGpXfpkGE2xqPN+s=;
 b=G7hDUtB0OYIy5h9oeAYpg0EVx9e8fE8PaOJ0jtsAagirO8MybjNYdOSJ4cCL6aq7g7
 hj2+gNZ8Ff86nf5b1BHQlxMdxaWX+RrG1YSG6T00wKdbATQzj9vXdKilux3HJq/2BtCj
 nWIz+WVZ8mqWmT0Se5vDjAuTaRO4ChyNHCJiNdSzJW2Z/LFQrKMIr7Ip6JmxaHga6cUy
 JqWzqOHm6L9iYU6ga6+QobHEHnCH45TbDTIpTzubXIxEjsIVdRUC9iAd+NRwRrK9E6bV
 cnA0Z6CdH1gBbCTquszpnS4Db72GF6MKaA14XSQnnpOV13Z8U8SaXU5LH7jvYXg24Wd7
 kxZw==
X-Gm-Message-State: AOJu0Yzok8HfICpmrECgYDTtdOvvtl4MZQF0pfE0i+QwBTlYY0ykCpSV
 HrUbKrhGh2YIb3vOz4Nq/V/h2L3fipH5lD6CrAMG8NPa2sQO82d4jzL0LqZBK5ez2JrH3Qw98Yy
 VX5u1Pwou97tMV9EWmI3OFu/rMGn9GAVuzRUe3bY2PTN8HegQN5/W9S3yMjJ+JYwETZpBGqKurS
 HYOpRl38XUCjv2scWohrTPUpITsG4tGe8dQg==
X-Gm-Gg: ASbGncvmFy25ftw7sf7pvZyJhp61BGwVRcQzQrgz7gKZp9CJx5WlVOVkTHU2zJsC2OV
 x6bxvv64jEVl4CnYRhJknISXTs4z7/yOx5ZDlTkMa5aClbrMFaHYT0YN/rf/nPlzQ7eYjuKdamy
 mUvAIrdSDwQSsd1ghbTk9TuVgggQYvlGAYg6gjKPll8K8mTsvDgenXFwGrW64mj/xuWEGTQTtUJ
 tRhV/M12cfhl9rbQTfLCRGdLRYCN40z2Z2o7/xsOFw/f074+5itPHpC+3szvx6GMhD2MdoEUJh/
 +fcOlw==
X-Received: by 2002:a05:6000:310d:b0:3a4:d719:5be0 with SMTP id
 ffacd0b85a97d-3a4eed91301mr11558961f8f.2.1748791544752; 
 Sun, 01 Jun 2025 08:25:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWhMl6G+vbhiNftOiQZ/OlcUza2hJxsqcICcLQSeyJSaqQTnvFnhLFajYUaA+crQIR1PuXLw==
X-Received: by 2002:a05:6000:310d:b0:3a4:d719:5be0 with SMTP id
 ffacd0b85a97d-3a4eed91301mr11558939f8f.2.1748791544322; 
 Sun, 01 Jun 2025 08:25:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa2442sm90047815e9.9.2025.06.01.08.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:43 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>,
 Jidong Xia <xiajd@chinatelecom.cn>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 23/31] vhost: Don't set vring call if guest notifier is unused
Message-ID: <51ee7357e9e6e017fc25837743bef0a18aeafbe6.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Huaitong Han <hanht2@chinatelecom.cn>

The vring call fd is set even when the guest does not use MSI-X (e.g., in the
case of virtio PMD), leading to unnecessary CPU overhead for processing
interrupts.

The commit 96a3d98d2c("vhost: don't set vring call if no vector") optimized the
case where MSI-X is enabled but the queue vector is unset. However, there's an
additional case where the guest uses INTx and the INTx_DISABLED bit in the PCI
config is set, meaning that no interrupt notifier will actually be used.

In such cases, the vring call fd should also be cleared to avoid redundant
interrupt handling.

Fixes: 96a3d98d2c("vhost: don't set vring call if no vector")

Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
Signed-off-by: Jidong Xia <xiajd@chinatelecom.cn>
Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
Message-Id: <20250522100548.212740-1-hanht2@chinatelecom.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h   | 1 +
 hw/pci/pci.c           | 2 +-
 hw/virtio/virtio-pci.c | 7 ++++++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index a6854dad2b..35d59d7672 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -983,6 +983,7 @@ void lsi53c8xx_handle_legacy_cmdline(DeviceState *lsi_dev);
 
 qemu_irq pci_allocate_irq(PCIDevice *pci_dev);
 void pci_set_irq(PCIDevice *pci_dev, int level);
+int pci_irq_disabled(PCIDevice *d);
 
 static inline void pci_irq_assert(PCIDevice *pci_dev)
 {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c6b5768f3a..9b4bf48439 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1730,7 +1730,7 @@ static void pci_update_mappings(PCIDevice *d)
     pci_update_vga(d);
 }
 
-static inline int pci_irq_disabled(PCIDevice *d)
+int pci_irq_disabled(PCIDevice *d)
 {
     return pci_get_word(d->config + PCI_COMMAND) & PCI_COMMAND_INTX_DISABLE;
 }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 9b48aa8c3e..7e309d1d49 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1215,7 +1215,12 @@ static int virtio_pci_set_guest_notifier(DeviceState *d, int n, bool assign,
 static bool virtio_pci_query_guest_notifiers(DeviceState *d)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
-    return msix_enabled(&proxy->pci_dev);
+
+    if (msix_enabled(&proxy->pci_dev)) {
+        return true;
+    } else {
+        return pci_irq_disabled(&proxy->pci_dev);
+    }
 }
 
 static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, bool assign)
-- 
MST


