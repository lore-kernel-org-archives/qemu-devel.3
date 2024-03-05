Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F756C54E55
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 09:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhQe7-00043u-8x; Tue, 05 Mar 2024 03:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhQdx-0003xv-Td
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:59:26 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhQdw-0003i7-8t
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:59:25 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3c1f55ba3ecso738529b6e.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 00:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709629162; x=1710233962;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9/PxcCc+L0baSbSLqEG7FKAVe7dX0Ps3Ftgof5mfrJs=;
 b=sUpZxPPnAf6OtD+zAvanZLg8lCNccscTITyKzGfKQnD5vZacn55yN+BZs2sa9p/5Db
 fNgS+gigW+vZvxu/AHh6mahq6HJ9ScGIjD39Oyu9JgjigiUrTv1E1qR2P1MWi58h2MMI
 LSgigaV0FBuLNEjp2HP8F2EHCFpwOELXINXTzeDP/unSt3aaLvvfMzd5Ap+MbzYel0KQ
 WfHCIkGMq1oUB3JKeMDnuLmNl9TbIMRbXXi/6ugK14pLelqOwgsABH5lv8di/tK0X1f9
 3dJozvAfEP6W063OrRI31mZduBO4ml5UzCiMjsjM8zhboBZ3wCZr3gOIEt+bF80qe9sY
 H8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709629162; x=1710233962;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/PxcCc+L0baSbSLqEG7FKAVe7dX0Ps3Ftgof5mfrJs=;
 b=Mpm/FPiL5YK/8+ybAE9GJp8xYbWDyjuNHghG+3bCv98Td0HxaemLsz3/UNV7u4fUdJ
 CTNR6WqkRyVgqPrfGVzTZ3n85nONkQxPXB+4HVvzszH3FHQ1aDWBuxpDTOczpVUS7V6l
 Mo3ySvR4gPLANLkVyj9CFPe8kz6ekwVuDJu8Mh8HCLHNoGn54BFYZcU9qycOcEnrbYqi
 mPXrOzW06FE+BGGOXPVzXOaHVY4KS2IqBcAL0Nus6FWfgSW1RamLvuOgKPn4aTYlFJ7W
 wEL7csl51rv+MosAQMbI0P1FWMlpHkoH+JuKiprtdzOX/P81BLZgAqMS+LW0jc6T+HDQ
 MxUw==
X-Gm-Message-State: AOJu0YzSDlf2eunl7T9yFZY2N8NEtqu9YXNrr60uDOXiBQz+jRDsAWoz
 UHyujvBlrEVpJ30LMBe/b+vD5cR54hFZUc3HH0DMq9cv10KLHeTVB2ghEc2Nvao=
X-Google-Smtp-Source: AGHT+IHNoMHyxDp+6hezykFHxjdP1Dj4Ao25i1zldbKekttOwMNAckNvfxWys5IfhxF4QNPavee6/g==
X-Received: by 2002:a05:6808:1524:b0:3c1:ed50:7c2b with SMTP id
 u36-20020a056808152400b003c1ed507c2bmr1404124oiw.47.1709629162351; 
 Tue, 05 Mar 2024 00:59:22 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 a30-20020a631a5e000000b005d30550f954sm8652972pgm.31.2024.03.05.00.59.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 00:59:21 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 05 Mar 2024 17:58:52 +0900
Subject: [PATCH RFC v3 5/6] virtio-pci: Implement SR-IOV PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-sriov-v3-5-abdb75770372@daynix.com>
References: <20240305-sriov-v3-0-abdb75770372@daynix.com>
In-Reply-To: <20240305-sriov-v3-0-abdb75770372@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 20240228-reuse-v8-0-282660281e60@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::22f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Allow user to attach SR-IOV VF to a virtio-pci PF.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/virtio/virtio-pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1a7039fb0c68..f6a2dbb3b5e2 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2075,6 +2075,12 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
         pci_register_bar(&proxy->pci_dev, proxy->legacy_io_bar_idx,
                          PCI_BASE_ADDRESS_SPACE_IO, &proxy->bar);
     }
+
+    if (pcie_sriov_pf_init_from_user_created_vfs(&proxy->pci_dev,
+                                                 PCI_CONFIG_SPACE_SIZE,
+                                                 errp)) {
+        virtio_add_feature(&vdev->host_features, VIRTIO_F_SR_IOV);
+    }
 }
 
 static void virtio_pci_device_unplugged(DeviceState *d)
@@ -2083,6 +2089,7 @@ static void virtio_pci_device_unplugged(DeviceState *d)
     bool modern = virtio_pci_modern(proxy);
     bool modern_pio = proxy->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY;
 
+    pcie_sriov_pf_exit(&proxy->pci_dev);
     virtio_pci_stop_ioeventfd(proxy);
 
     if (modern) {

-- 
2.44.0


