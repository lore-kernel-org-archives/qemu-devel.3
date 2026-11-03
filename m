Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D8606D819
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f/RfjwpW;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gWe5Bq1Z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOD30-0005TZ-3l; Tue, 03 Nov 2026 06:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2x-0005Ld-DQ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:51:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2v-0000Or-6k
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793706680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R8RjRqZq+zwdRtCWfwySynm5xd1MEW7N/hnP/GKOxA8=;
 b=f/RfjwpWNf8dRTQQb1pgc8vR//mOnpkj9oxSS34jnDArO5EjwYZfVRacvL+XOW3k5tnauP
 Xh/SvSApiTbW6pvkxUocgnSJyHWmXmkf21UHDWsfQCZX36/ShqGcFiVeQ+pVHeDMd5pwCY
 l3TT2UjXOyUwTOrVbWd8aAEkWkYtKr4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654--uzPgEnIOoSLDYdNDeMADQ-1; Tue, 03 Nov 2026 06:51:19 -0500
X-MC-Unique: -uzPgEnIOoSLDYdNDeMADQ-1
X-Mimecast-MFC-AGG-ID: -uzPgEnIOoSLDYdNDeMADQ_1793706678
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48af4a0bd0fso2274506f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793706678; x=1794311478; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R8RjRqZq+zwdRtCWfwySynm5xd1MEW7N/hnP/GKOxA8=;
 b=gWe5Bq1Zi7Su/qV6M/fVUqpia2yfVaQO7M2N+7dJX1nXkuSlDPpI4O9rYPBk9pGXFd
 bQ+vPdUlBxfyYY3q9iXdKKBMJQsC40ay7ylLdHdZIYik4qJSRgpppYqEHgm5ggSn8Lnv
 5gaxRTq0CfW9pPNh0ZADdOCVKXnZMsZB7lq3dIosFgYoy9/ra0XLE13kCYl8v+v9KDqQ
 o9nwWeUGnkCdroh3Ff2rovmbFae+eeDn4QypBPv/8v1z0VnY751UYoTVcCDx3UJuKQim
 VXQZ6QjtTofns3IPkBIZNlUPlE1FnTdOXXMnYV9p9dBZEhaXe+9PV3uW6AeuL9cGXwd5
 WYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706678; x=1794311478;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R8RjRqZq+zwdRtCWfwySynm5xd1MEW7N/hnP/GKOxA8=;
 b=HgeyrMHv2Be5wGZnJqNJ3w9ndtoPV6iZXl9Zx24KzQENXApdThacHbSYiyu7A1lv3w
 3uur6wrXFBhZDB4DiEisGW6B8S2FTR+aJbf0XHlHW92hQ41esjzKu4d5gXY0OVuuF38h
 7NB9oqNjTQbaoZwEtCOQW/5TsM89dZMyZNqSR9U7SV1HdCtznVs2DE2pwYWb54l7abmF
 TGNVovqoxwPr0eKLCy0xqd3PItBcw8BWX8Tdsvp6mb1cRP3xIufpgEqhEnEeWHFWGfad
 LnIv6IQsdikd1xKrKAN0neJQn0CBhnL4h/d8dDphTQbumV1YViff1fiuqxKHE5eJaurf
 HWcg==
X-Gm-Message-State: APuU4Z+/N/FfZ5pKx8soJJl+OYWL9YGFrVDz6gJvBRISIDB4oAFyK2jh
 AWhkWMMZS0dnJ3NeFIsn+KJdjrCBKbMCB3bVJy4nA4Quu7h/E64/OdLpzroMy7WxfNmD1k3kS8D
 7Tz3awUOFqN8Il0ipNhWyyst//mMpao3TiB9GyHYTCzSGwSHLbkOUnuoKMapv6k297Orh+HhR+j
 BZN0V2b5rBTGQtVlMGU5PgDqL9TPLRRAF/lw==
X-Gm-Gg: AYBFou1Dv1Kr3w/qRZbtu1L8DB/3659cy54PG3dBHrqWFmhCJKbNr3IDbwQ8EapWjod
 77bGOfdsKcpFdFWy2grLQqL2TW0CBEqvr0NUSLTCTRBZcFsf1gTK5ZKUq4z5+Vgt9P5TY8kjGKa
 uOciScSmepubq80mGJO/CZThc+kDqJ5ft2bZlPkeq4kIp9tCJJlWGK/WrBOf/F+sU8qlt5NpTG4
 GY2FqxXz9dsBdR/dG4/QneCG1EP8eJHNVGHZqF3/4gLdM1j7xP/YNR3wjW5nhQl8xp27FCiq8Zy
 kmnqq19yA7rJiwufe+9hV1DpOsMRs6MzohVt9OAHj8oGYd0sCMHHZ6EbqlknwnFQxf6kleZZ2+R
 ecXmz4ucJI9QRk4Au2kyhF1Sh4n9zpM2vMhOFu75yXA==
X-Received: by 2002:a05:6000:1aca:b0:48c:7037:aee9 with SMTP id
 ffacd0b85a97d-48e6e4fcfacmr27885105f8f.50.1793706677989; 
 Tue, 03 Nov 2026 03:51:17 -0800 (PST)
X-Received: by 2002:a05:6000:1aca:b0:48c:7037:aee9 with SMTP id
 ffacd0b85a97d-48e6e4fcfacmr27885051f8f.50.1793706677399; 
 Tue, 03 Nov 2026 03:51:17 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b7815fsm25315109f8f.22.2026.11.03.03.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:51:16 -0800 (PST)
Date: Tue, 3 Nov 2026 06:51:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>,
 Jishnu Warrier <jishnuvw@linux.ibm.com>,
 Utkarsh Verma <uverma@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 16/17] qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
Message-ID: <3c6c791284c12350266ec7ef8ed0079de39e05cf.1793706601.git.mst@redhat.com>
References: <cover.1793706601.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793706601.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nicholas Piggin <npiggin@gmail.com>

Devices where the MSI-X addresses are shared with other MMIO on BAR0
can not use msi_enable because it unmaps and remaps BAR0, which
interferes with device MMIO mappings. xhci-nec is one such device we
would like to test with msix.

Use the BAR iomap tracking structure introduced in the previous change
to have qpci_misx_enable() use existing iomaps if msix bars are
already mapped.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261102035306.2291147-10-uverma@linux.ibm.com>
---
 tests/qtest/libqos/pci.h |  1 +
 tests/qtest/libqos/pci.c | 40 ++++++++++++++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 2f9555ae4e..2fcddd19a8 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -75,6 +75,7 @@ struct QPCIDevice
     bool bars_mapped[QPCI_NUM_REGIONS];
     QPCIBar bars[QPCI_NUM_REGIONS];
     bool msix_enabled;
+    bool msix_table_bar_iomap, msix_pba_bar_iomap;
     QPCIBar msix_table_bar, msix_pba_bar;
     uint64_t msix_table_off, msix_pba_off;
 };
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index 365fde1fb9..41f9673022 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -274,15 +274,21 @@ void qpci_msix_enable(QPCIDevice *dev)
 
     table = qpci_config_readl(dev, addr + PCI_MSIX_TABLE);
     bir_table = table & PCI_MSIX_FLAGS_BIRMASK;
-    dev->msix_table_bar = qpci_iomap(dev, bir_table, NULL);
+    if (dev->bars_mapped[bir_table]) {
+        dev->msix_table_bar = dev->bars[bir_table];
+    } else {
+        dev->msix_table_bar_iomap = true;
+        dev->msix_table_bar = qpci_iomap(dev, bir_table, NULL);
+    }
     dev->msix_table_off = table & ~PCI_MSIX_FLAGS_BIRMASK;
 
     table = qpci_config_readl(dev, addr + PCI_MSIX_PBA);
     bir_pba = table & PCI_MSIX_FLAGS_BIRMASK;
-    if (bir_pba != bir_table) {
-        dev->msix_pba_bar = qpci_iomap(dev, bir_pba, NULL);
+    if (dev->bars_mapped[bir_pba]) {
+        dev->msix_pba_bar = dev->bars[bir_pba];
     } else {
-        dev->msix_pba_bar = dev->msix_table_bar;
+        dev->msix_pba_bar_iomap = true;
+        dev->msix_pba_bar = qpci_iomap(dev, bir_pba, NULL);
     }
     dev->msix_pba_off = table & ~PCI_MSIX_FLAGS_BIRMASK;
 
@@ -293,6 +299,7 @@ void qpci_msix_disable(QPCIDevice *dev)
 {
     uint8_t addr;
     uint16_t val;
+    uint32_t table;
 
     g_assert(dev->msix_enabled);
     addr = qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
@@ -301,10 +308,31 @@ void qpci_msix_disable(QPCIDevice *dev)
     qpci_config_writew(dev, addr + PCI_MSIX_FLAGS,
                                                 val & ~PCI_MSIX_FLAGS_ENABLE);
 
-    if (dev->msix_pba_bar.addr != dev->msix_table_bar.addr) {
+    if (dev->msix_pba_bar_iomap) {
+        dev->msix_pba_bar_iomap = false;
         qpci_iounmap(dev, dev->msix_pba_bar);
+    } else {
+        /*
+         * If we had reused an existing iomap, ensure it is still mapped
+         * otherwise it would be a bug if it were unmapped before msix is
+         * disabled. A refcounting iomap implementation could avoid this
+         * issue entirely, but let's wait until that's needed.
+         */
+        uint8_t bir_pba;
+        table = qpci_config_readl(dev, addr + PCI_MSIX_PBA);
+        bir_pba = table & PCI_MSIX_FLAGS_BIRMASK;
+        g_assert(dev->bars_mapped[bir_pba]);
+    }
+
+    if (dev->msix_table_bar_iomap) {
+        dev->msix_table_bar_iomap = false;
+        qpci_iounmap(dev, dev->msix_table_bar);
+    } else {
+        uint8_t bir_table;
+        table = qpci_config_readl(dev, addr + PCI_MSIX_TABLE);
+        bir_table = table & PCI_MSIX_FLAGS_BIRMASK;
+        g_assert(dev->bars_mapped[bir_table]);
     }
-    qpci_iounmap(dev, dev->msix_table_bar);
 
     dev->msix_enabled = 0;
     dev->msix_table_off = 0;
-- 
MST


