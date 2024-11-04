Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3DFD1BDF4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84JK-0004oE-PJ; Mon, 04 Nov 2024 16:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84JH-0004LF-B1
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84JF-0005T8-Pa
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UlP335cOFsUkS+Xl7GKV9Lv2XyhG9kOzxJJ+GSB6He4=;
 b=MhSfhKPf+bXF2+lvwC2ksMQuISy01C84Ddk80AM53s6o/g+xQH73AE+LjyfoTAMZLBg0w6
 ZfDAUN58iNCN2R4lhq/lIRK64qrams0se02JfY4Zch9UrbqQ5HXLXaftY4rKuX4fKrzi3j
 5UvVwoQKa3GrseVIPyEuGNBQ/JslIgY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-M0viPKqhMaaPsRSHurSqXw-1; Mon, 04 Nov 2024 16:08:23 -0500
X-MC-Unique: M0viPKqhMaaPsRSHurSqXw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2fb652f40f1so26110281fa.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754501; x=1731359301;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UlP335cOFsUkS+Xl7GKV9Lv2XyhG9kOzxJJ+GSB6He4=;
 b=YBgYXpzDKwdmsbMOfP/UoOTnKgDCDQ/0k0u0fCrUT3IsfU51ITo7eNsY2l7kI0nHQz
 /toazF2gfdELT9p2Ctj0W+lh78Y2ScBkjeyKFKkQYUmaT/GIAhV7SmvbksY0r0Yp8nqB
 MpEwfkjHkNLsQi0D78jaB6jErdgRNsTQ9EBkzkFtEdzuZVvedpz6ICse8O1u1BrGWQOv
 Shr2yYyLzVbwXcw1AK3c9TcLFsDerpfRswbhyBzQtW7cUjZ9ANYwYoGarOn6JdiitPYG
 RkPCCtGpEVYlru5EkhhwD8gXu8o2gqrwKOWLhsbS3MSvX1fdvRtXd4T3LJMOJ6s7t5ci
 h8ng==
X-Gm-Message-State: AOJu0YxI+33qV9qCb4YgdGx0h91Rmq7F/3JMNVN1ggZLVLc2kkzP6s2O
 rR68hwMsiM2v5bWrSSeJqhEQlo0mUtp+6Yz6d07R0+VrxuMoz15A1RqlEjT5sbjT5R6uflZU0eh
 GJxFWDKxtaOhNLmRIjYhU5bD3h1nJG+N38pwWDlp+HTegd814HsadC002LTMoX40rDQs9p3L5Tg
 BXT9zLAlBeuJNTKPS0cMcsmRWQoCqohA==
X-Received: by 2002:a05:651c:1988:b0:2fb:65c8:b4ae with SMTP id
 38308e7fff4ca-2fedb7d910amr67853531fa.31.1730754501278; 
 Mon, 04 Nov 2024 13:08:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmX02BxqSQUkkXcp0eRiwbXtUzuEzLornlj3NSMZHKeONTL8MThiGZsqpsPiVT+DfddNVpvw==
X-Received: by 2002:a05:651c:1988:b0:2fb:65c8:b4ae with SMTP id
 38308e7fff4ca-2fedb7d910amr67853271fa.31.1730754500725; 
 Mon, 04 Nov 2024 13:08:20 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e687sm14225464f8f.84.2024.11.04.13.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:08:20 -0800 (PST)
Date: Mon, 4 Nov 2024 16:08:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 41/65] hw/pci-bridge: Make pxb_dev_realize_common() return if
 it succeeded
Message-ID: <d4d5212c541f57c339a592bcf1b38bf325940bfd.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

For the CXL PXB there is additional code after pxb_dev_realize_common()
is called.  If that realize failed (e.g. due to an out of range numa_node)
we will get a segfault.  Return a bool so the caller can check if the
pxb_dev_realize_common() succeeded or not without having to poke around
in the errp.

Fixes: 4f8db8711cbd ("hw/pxb: Allow creation of a CXL PXB (host bridge)")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241014121902.2146424-8-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-bridge/pci_expander_bridge.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 4578e03024..07d411cff5 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -330,7 +330,7 @@ static gint pxb_compare(gconstpointer a, gconstpointer b)
            0;
 }
 
-static void pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
+static bool pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
                                    Error **errp)
 {
     PXBDev *pxb = PXB_DEV(dev);
@@ -342,13 +342,13 @@ static void pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
 
     if (ms->numa_state == NULL) {
         error_setg(errp, "NUMA is not supported by this machine-type");
-        return;
+        return false;
     }
 
     if (pxb->numa_node != NUMA_NODE_UNASSIGNED &&
         pxb->numa_node >= ms->numa_state->num_nodes) {
         error_setg(errp, "Illegal numa node %d", pxb->numa_node);
-        return;
+        return false;
     }
 
     if (dev->qdev.id && *dev->qdev.id) {
@@ -394,12 +394,13 @@ static void pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
     pci_config_set_class(dev->config, PCI_CLASS_BRIDGE_HOST);
 
     pxb_dev_list = g_list_insert_sorted(pxb_dev_list, pxb, pxb_compare);
-    return;
+    return true;
 
 err_register_bus:
     object_unref(OBJECT(bds));
     object_unparent(OBJECT(bus));
     object_unref(OBJECT(ds));
+    return false;
 }
 
 static void pxb_dev_realize(PCIDevice *dev, Error **errp)
@@ -500,7 +501,9 @@ static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
         return;
     }
 
-    pxb_dev_realize_common(dev, CXL, errp);
+    if (!pxb_dev_realize_common(dev, CXL, errp)) {
+        return;
+    }
     pxb_cxl_dev_reset(DEVICE(dev));
 }
 
-- 
MST


