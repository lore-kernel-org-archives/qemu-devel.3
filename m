Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D46C5B543
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkZW-0003Fp-D1; Sun, 01 Jun 2025 11:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZU-0003E9-GD
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZS-0004gS-SK
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iOHxmu/DSPgZPvZMkn1J47zj3LBk3Nk/LBdtFk70RKE=;
 b=Draeg9yfhThKQqPJqdTGD2tf7gRaEzzLNibAH/st97Wta4S19IFUQQApullfyWBp5cXVEk
 dcpdztvKLVgznlo2Zizzrb0CRTSAH0VDiRjxyckFkUAzjGVGtikM6Ln+Oz4l4TkRVwhLkN
 JLzBAcGIfTJaNBZ6bB82ez7brgC3YG0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-kPSueeaGOluutR4w9XKBbA-1; Sun, 01 Jun 2025 11:25:57 -0400
X-MC-Unique: kPSueeaGOluutR4w9XKBbA-1
X-Mimecast-MFC-AGG-ID: kPSueeaGOluutR4w9XKBbA_1748791556
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4517abcba41so6828425e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791555; x=1749396355;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iOHxmu/DSPgZPvZMkn1J47zj3LBk3Nk/LBdtFk70RKE=;
 b=nP46atqxKorbX2ZFzzxBEi9lIxy3MS9hiAV7c8IlChhOSpsgXeGpdFY09kib5loa4e
 wzAS7C+xO82+Jdmg7pazWHYPdEuBXA6d+tIaUXNdorsRjG9aUOHBOSxnI+Cbtb65krwW
 OkeSHSaedfA++dtVQvoMERM3Cor9VqpyxZPppSaY+UfhaXMJg/HpGOKHIyHOsxUHc+G0
 klwmFfVRoOjhrhr3x+5VmcaY9F4xEsYM9bnlGsM4/Ekl5eIKS8kp5j8DM8qIVL0MxHkV
 9hwfIpcZqv1J0CP8J09SDDFFMMpVfUjX9UNmESnMBSFKu41oeLC3XTCAXRMYUB2Bj2gf
 b9OQ==
X-Gm-Message-State: AOJu0YxE3OWYWo9f4lnR0ZAWyIbJ5wMBHlVf0YirYkLeQjcEDwImF6kx
 qq9/eqrpJoY6f+UpO/muyXuCbQOdI62MYTF5c0+3Hfe7b82dLzbH+toj8H0bFapXUivO/CW3Ikk
 HM6oJdjptcv7jw3mq803r7e+TqOhFAlwlt/S3+rRitRyHxYccmJC2HcL23vXVznpQyKdOMxBN+G
 qnzfOP0edtXV5peLtUA34dJXaiJgxBMn7MCQ==
X-Gm-Gg: ASbGnctR68u2rCHNvfjCshaYNf0honSpJYZZja4wWMyFwk98hNE3XwQ9G3rQ8k0w/bZ
 KjynSAneug8/HuB3DA85QW1fOMS1ZUSUKUe5vbXyVxb/unyXSoPaEkXL93qu6Lkh+SIE6PSjhkE
 NLVtHxOGzO3FejaADXN3Do6tfwLw36B3NB5mnXcQ4gObSY3NWI9KI5TUBuf/py+mg9wXt23JzlW
 jzN38cA4obH6oh5/Jw2J14UGfXng/GrxDF/1o19qIFo7ZBkxd/aJENc6ikzOGjnr9Wcdzr78tc5
 I0VSQMa6MJBubgXS
X-Received: by 2002:a05:600c:5291:b0:440:54ef:dfdc with SMTP id
 5b1f17b1804b1-450d8843256mr85184065e9.8.1748791555502; 
 Sun, 01 Jun 2025 08:25:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgwoMPhijx7k/O/1H2zVl2GQJiQ25zWQ01e0OwzVFk+07yM+J+49MrKylbR9R30LuiL+rSVg==
X-Received: by 2002:a05:600c:5291:b0:440:54ef:dfdc with SMTP id
 5b1f17b1804b1-450d8843256mr85183855e9.8.1748791555098; 
 Sun, 01 Jun 2025 08:25:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8000d5dsm89010975e9.26.2025.06.01.08.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:54 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 27/31] vdpa: add listener_registered
Message-ID: <a849b49e5b769c2458ff91174a907e055a26f785.1748791463.git.mst@redhat.com>
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

Check if the listener has been registered or not, so it needs to be
registered again at start.

Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20250522145839.59974-5-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h | 6 ++++++
 hw/virtio/vhost-vdpa.c         | 7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 0a9575b469..221840987e 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -51,6 +51,12 @@ typedef struct vhost_vdpa_shared {
 
     bool iotlb_batch_begin_sent;
 
+    /*
+     * The memory listener has been registered, so DMA maps have been sent to
+     * the device.
+     */
+    bool listener_registered;
+
     /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
     bool shadow_data;
 
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index e9826ede2c..450f68f117 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1379,7 +1379,10 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
                          "IOMMU and try again");
             return -1;
         }
-        memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
+        if (!v->shared->listener_registered) {
+            memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
+            v->shared->listener_registered = true;
+        }
 
         return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
     }
@@ -1399,6 +1402,8 @@ static void vhost_vdpa_reset_status(struct vhost_dev *dev)
     vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
                                VIRTIO_CONFIG_S_DRIVER);
     memory_listener_unregister(&v->shared->listener);
+    v->shared->listener_registered = false;
+
 }
 
 static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t base,
-- 
MST


