Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B76CC5B543
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkZs-0003cs-Lx; Sun, 01 Jun 2025 11:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZX-0003HM-EV
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZW-0004gs-0o
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAQySewBx8SloVNKOXAdxhJJVB1Xqg1y29AdslpVETY=;
 b=B5QiWHdgFgmxubefF5ciq0Mvyc9Gr96AX73+VO0S8fWjGhAgJ6+ErJxSNyLk8ufWMfaxGk
 +ltSWxkgwU5uQ7s0BP39eEcH1FYw70nGD8retr1qJiQPjCIikc5urUbJL8azNRvBWhTK+b
 GYq99xfbqA823V6Dv2i2iT8l0AuROxk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-FvOkRplJP3alXuX75Wgqyw-1; Sun, 01 Jun 2025 11:26:00 -0400
X-MC-Unique: FvOkRplJP3alXuX75Wgqyw-1
X-Mimecast-MFC-AGG-ID: FvOkRplJP3alXuX75Wgqyw_1748791559
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f7f1b932so1836294f8f.2
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791559; x=1749396359;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IAQySewBx8SloVNKOXAdxhJJVB1Xqg1y29AdslpVETY=;
 b=iZjeKTMguOTEiwSjFhfilOc9vO4aO4LcTBNs8uS6YQquDi1dw5aUM+c8pxeI4earcq
 7jukwTrdn5iEXNTRUfX2fKqy5Jir6qRtHYSOo5sOJK9gjBbs5a15oMc+rL1pqVp7RUwH
 A0XfSWj3wk1EcrofsA54jWlRDTWuBm5pe+el4d0ssbJXiU5trM3ouNMuL41CTMM2yGKa
 0SNK/EQqRwVdJMcJfsV7kCK7Wbtvl1sVK7PWXUUumCt9Z1xYVMuj6mZ09R8QWIgDSPTL
 JbeaoLhTVXo/f3S6SsSipecXzK1FtnewQYpba9oI4G+MO0ut9yg0C/U3+4cFrpshixnB
 S0kg==
X-Gm-Message-State: AOJu0YwAPea7T+VIifH5VuXJJStbB2ahEbbScrtIkLZKbe4nCXhbwd/F
 LyDePFRq6nqHxrwoef8UzdZ1Tip8ZvUXCp2YJSZvlHGIGY08b2CvkzwcK5b9+pgClX/Fym9riJe
 veTjQbU0vvRtPiJEl37WvkEKRTUa8O8diNtA6UrA9TnIhQK/ROuiNhKGSeVzhHVN7kjHK+jqfhl
 g5Zp/UqkwcLmDGlI77+EbX0joX0p5qYSoOjQ==
X-Gm-Gg: ASbGncuM804/TO716UPe/hK07HodOWL0gulBUoaemWEm8fuDGWZ+SaTn/zS9TmiytTn
 Yvgfhe7Q/RY4irZH/zCw1+C8fKcn0+p/kvQwxceJlV7jsP2nTb9dZz2dYPy+Z/MK9ijezVuOYTa
 PvDjSAVlfgX5mH+WtHNUDNwdeD3DH8uLTBs8o6jfxRbYlB2yBBosLLai5QAv/tjThmwCAy22lh2
 Nkjv59FesdgcPzbFKGRFGrB/v6aRN3L0+KdK5lVvJaeTW4S1aC7cLFLj+upVtcBuCZWZWIgvpOT
 dxDykw==
X-Received: by 2002:a05:6000:220d:b0:3a3:4baa:3f3d with SMTP id
 ffacd0b85a97d-3a4fe154f5bmr3345749f8f.6.1748791558964; 
 Sun, 01 Jun 2025 08:25:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhNPdPvfIEFhKvRLZWGylYG9MfuTqUug660UFI2s8TsbqTM4TXdNswoR4+vV/eGNsbwakL8A==
X-Received: by 2002:a05:6000:220d:b0:3a3:4baa:3f3d with SMTP id
 ffacd0b85a97d-3a4fe154f5bmr3345727f8f.6.1748791558536; 
 Sun, 01 Jun 2025 08:25:58 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8f188sm89607355e9.3.2025.06.01.08.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:56 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 28/31] vdpa: reorder listener assignment
Message-ID: <0e8b3b44e9dfa8f2b05313b9d19eb1fb622945b8.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

From: Eugenio Pérez <eperezma@redhat.com>

Since commit f6fe3e333f ("vdpa: move memory listener to
vhost_vdpa_shared") this piece of code repeatedly assign
shared->listener members.  This was not a problem as it was not used
until device start.

However next patches move the listener registration to this
vhost_vdpa_init function.  When the listener is registered it is added
to an embedded linked list, so setting its members again will cause
memory corruption to the linked list node.

Do the right thing and only set it in the first vdpa device.

Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20250522145839.59974-6-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 450f68f117..de834f2ebd 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -633,7 +633,6 @@ static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
 
     v->dev = dev;
     dev->opaque =  opaque ;
-    v->shared->listener = vhost_vdpa_memory_listener;
 
     ret = vhost_vdpa_set_backend_cap(dev);
     if (unlikely(ret != 0)) {
@@ -675,6 +674,7 @@ static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
     vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
                                VIRTIO_CONFIG_S_DRIVER);
 
+    v->shared->listener = vhost_vdpa_memory_listener;
     return 0;
 }
 
-- 
MST


