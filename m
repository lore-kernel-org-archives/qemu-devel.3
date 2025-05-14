Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02BCC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAdi-00065K-C8; Wed, 14 May 2025 07:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdd-0005yR-Cq
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdW-0006Dt-A6
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=scQGANjf5Zg9Z+VVAOZFzRgXSundnohTLR5TyNGPrwM=;
 b=AoEwz66hByQG7mrlnCGKt4CUfyYv8DMRowaBgUf20ZopAlziFYCbcQcvyiiACW+0uLjJ9s
 hlnClpUl26vYACIi/JK2eU8IbYNfVkthElcIjrwSA4Ub5z/Gj0WpmJpqGr8ZIKBruouSt9
 qHha9vZSlJkUwJw9swQK61UlobsAvqI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-7xd1HfThOBKcqEujAQaAhQ-1; Wed, 14 May 2025 07:50:54 -0400
X-MC-Unique: 7xd1HfThOBKcqEujAQaAhQ-1
X-Mimecast-MFC-AGG-ID: 7xd1HfThOBKcqEujAQaAhQ_1747223453
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0b570a73eso3858176f8f.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223453; x=1747828253;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scQGANjf5Zg9Z+VVAOZFzRgXSundnohTLR5TyNGPrwM=;
 b=IDcPsvD+SWF6Pzqoza10WHHU39xtBG/dX7c0rslqah/+v8pfoN3pNPpLgh94Xdx9wv
 wzPouuwRFqeWiAEtr55+DjJPhUsbTItX6xscYrnAGs6U5UKJtCp0+vaTmTSHhmdBlmwL
 x+RRZf9oX3+wfF4KNF7Ez5D3viRckvVNbC07PnAaGCof6MUuToB51S4JszTl5iQZq1j7
 ENCqvtIyJS5YedDSuEt9D8UyUomz4t4sLay6RG2nrOp/qiOCNjBBb/TTA7jayPtqHizK
 5NXcCwmB7cH6ANX5hDJphEw8GmvDEbxNxPxHYP+E4N+P+hlVB3w3AcP0Akm6aTly1Pi9
 dJIw==
X-Gm-Message-State: AOJu0YzXz7Bz1OBoVtgW+nvc9nr4Vqg09mrNtknfbeLoOvdV4nNznYNj
 nElNAG4BWMkPFGjDl20TZDQEg9GH6pHkLSCVZP8Iu5iHfxitpEj/xChuARsPL280nWlQR4nJGhb
 15GhRUdguAx48mU64PyKJJydg7MxFuIildHUi25GDP4Mxpnx6l3L7cF8JbHPJJ9pAqTA1Njzs4Q
 Rg2tvmcSuHst8nX+2lZ1KC0dy7+TfvLA==
X-Gm-Gg: ASbGncs7si+GSQ9M4srObLJn8gPejjPBqe/NY7+qc5yWj8AC+VF14zVOzjBLLqNQqhI
 BwGqjsajFXnLYB8Vnu54rjeyUAnhMI+dDx3swI5E/nW9gfygsuKjpXy3Isv7ydwmQeS46fqwJ+G
 6CfxT+vilsuXVCfQeKkhb1pLS1Xky0KaEmOHMjwRDjilEhti+TyOyYJ6UbWvQdh9ItZMSaFp90d
 DGWoubQlzAg02U8nuiZu8ODef+c35L5bpFJIDARIp7uRETuJOBZq1B3XuMdmOX3oTXry/AQh0aZ
 o/AXrg==
X-Received: by 2002:a5d:64cb:0:b0:3a0:99de:5309 with SMTP id
 ffacd0b85a97d-3a3496a603fmr2321935f8f.18.1747223452728; 
 Wed, 14 May 2025 04:50:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA4FN4bayEGrz10h7rsUcxy72k9CqiQedcMKIUfluKGd2T9ZfthiMnq8Y5twmbXt+Qp8yNSw==
X-Received: by 2002:a5d:64cb:0:b0:3a0:99de:5309 with SMTP id
 ffacd0b85a97d-3a3496a603fmr2321913f8f.18.1747223452343; 
 Wed, 14 May 2025 04:50:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57dde1asm19317210f8f.8.2025.05.14.04.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:50:51 -0700 (PDT)
Date: Wed, 14 May 2025 07:50:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Yui Washizu <yui.washidu@gmail.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PULL 14/27] virtio-net: Implement SR-IOV VF
Message-ID: <49f7cb18db0790f7f32cb85dc35ffc25e44a828b.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

A virtio-net device can be added as a SR-IOV VF to another virtio-pci
device that will be the PF.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250314-sriov-v9-7-57dae8ae3ab5@daynix.com>
Tested-by: Yui Washizu <yui.washidu@gmail.com>
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-net-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index 8cf9788bc3..f857a84f11 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -74,6 +74,7 @@ static void virtio_net_pci_class_init(ObjectClass *klass, const void *data)
     k->device_id = PCI_DEVICE_ID_VIRTIO_NET;
     k->revision = VIRTIO_PCI_ABI_VERSION;
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
+    k->sriov_vf_user_creatable = true;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     device_class_set_props(dc, virtio_net_properties);
     vpciklass->realize = virtio_net_pci_realize;
-- 
MST


